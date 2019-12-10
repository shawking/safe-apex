package safeapex.model;

import java.io.Serializable;

/**
 * Wheather data for one day
 *
 * @author : Isabelle LECOMTE / Herve SINOQUET
 * Date    : February 2003
 */


public class SafeApexDailyClimat implements  Serializable {

	private int julianDay;				// number of the day in the year (1 to 365)
	private int year;					// year YYYY
	private int month;					// month MM
	private int day;					// day DD
	private float minTemperature;		// degree
	private float maxTemperature;		// degree
	private float minRelativeHumidity;	// %
	private float maxRelativeHumidity;	// %
	private float globalRadiation;		// MJ m-2
	private float globalPar; 			// Moles m-2 (direct+diffuse)
	private float precipitation;		// mm
	private float windSpeed;			// m s-1
	private float waterTableDepth;		// m
	private float cO2Concentration;		// ppm

// Calculated values
	private float diffusePar; 					// Moles m-2
	private float sunDeclination; 				// radian
	private float dayLength; 					// in hours
	private float extraTerrestrialRadiation; 	// MJ m-2 day-1
	private float airVapourPressureSat;			// Vapour pressure saturated of the day (mbar or hPa)
	private float airVapourPressure;			// Vapour pressure of the day (mbar or hPa)
	private float airDayVapourPressure;			// Vapour pressure of the day without night (mbar or hPa)
	private float airVpd;						// Vapour pressure deficit of the air (mbar or hPa)
	private float delta;						// slope of the saturation vapour pressure curve of the air
	private float etpPenman;					// etp penman calculated
	private float infraRedRadiation;			// atmospheric long-wave radiation (Watts m-2)
	
	private float rain;							//mm of rain (precipitation - snow + meltedSnow) 
	private float snow;							//mm of rain transformed in snow
	private float stockedSnow;					//mm of rain transformed in snow (stocked to day-1) 
	private float meltedSnow;					//mm of snow melted
	private float rainCapacityinSnow;			//mm capacity of rain stocked by snow 

	
	public SafeApexDailyClimat (SafeApexInitialParameters settings, 
							int julian, float latitude,
							int y, int m, int d,
							float tmin, float tmax,	float rhmin, float rhmax,
							float rg,  float r,  float ws, float wt, float co2) {

		julianDay = julian;
		this.year = y;
		this.month = m;
		this.day = d;
		this.minTemperature = tmin;
		this.maxTemperature = tmax;
		this.minRelativeHumidity = rhmin;
		this.maxRelativeHumidity = rhmax;
		this.globalRadiation = rg;
		//convertion of global radiation (MJ m-2) in PAR (Moles m-2)
		this.globalPar = (float) ((rg * settings.parGlobalCoefficient) / settings.molesParCoefficient);
		this.precipitation = r;		
		this.windSpeed = ws;
		this.waterTableDepth = wt;
		this.cO2Concentration = co2;
		//snow module (il 31-10-2017)
		this.rain = r;
		this.snow = 0;
		this.meltedSnow = 0;
		this.stockedSnow = 0;
		this.rainCapacityinSnow = 0;
		
		//VPD
		this.airVapourPressure = (float) (vpSatFunction (getMeanTemperature ())
					  	      		* (minRelativeHumidity+maxRelativeHumidity) / 2 / 100) ;
		this.airDayVapourPressure = (float) (vpSatFunction (getMeanDayTemperature ())
					  	      		* (minRelativeHumidity+maxRelativeHumidity) / 2 / 100) ;

		this.airVapourPressureSat = (float) (vpSatFunction (getMeanTemperature ()));

		this.airVpd = (float) (vpSatFunction (getMeanTemperature ()) - this.airVapourPressure);

		this.delta = (float) (deltaFunction (getMeanTemperature ()));

		//sun declination in radian
		double om = 0.017202 * (((float) julianDay) - 3.244);
		double teta = om + 0.03344 * Math.sin(om) * (1 + 0.021 * Math.cos(om)) - 1.3526;        // Celestial longitude of the sun
		double sidec = 0.3978 * Math.sin(teta);			// Sine of sun declination
		sunDeclination = (float) (Math.asin(sidec));	//in radian

		//day lenght calculation in hours
		double codec = Math.cos(sunDeclination);				// cosine of sun declination
		double silat = Math.sin(Math.toRadians(latitude));
		double colat = Math.cos(Math.toRadians(latitude));
		double sinR = 0.01064; // Here is the French touch, ie there is another number for the other definitions
		double AA = (-sinR - sidec * silat) / (codec * colat);
		dayLength = (float) ((24/Math.PI) * Math.acos(AA));

		// extra Terrestrial Radiation calculation
		double CC = 1370 * 3600	* 1.e-6;			//Solar constant, in MJ m-2 hour-1
		CC = CC * (1 + 0.033 * Math.cos(2 * Math.PI * ((float)(julianDay)-4)/366)); //Solar constant, with sun-earth distance correction

		double G0 = silat * sidec * dayLength;
		G0 = G0 + colat * codec * (24/Math.PI) * Math.sin((Math.PI/12)*(dayLength/2));
		extraTerrestrialRadiation = (float) (G0 * CC);

		//	Coefficients aDG and bDG of the relationship : D/G = a - b G/G0
		//	(where D, G, G0 are diffuse incident, global incident and extraterrestrial radiation at daily time step, respectively.
		double aDG = settings.diffuseCoeffA;
		double bDG = settings.diffuseCoeffB;

		diffusePar = (float) (globalPar * (aDG - bDG * (globalRadiation/extraTerrestrialRadiation)));
		if (diffusePar >= globalPar) {
			diffusePar = (float) (0.99*globalPar);	//IL 06.07.2018 to avoid direct=0
		}
		if (diffusePar <= (0.1*globalPar)) diffusePar = (float) (globalPar * 0.1);

		//ETP penman calculation
		etpPenman = getETPPenman (settings, globalRadiation, 1);

		this.infraRedRadiation=infraRedCalculation(settings, globalRadiation,
													extraTerrestrialRadiation,
													airVapourPressure,
													minTemperature, maxTemperature);


	}

	/**
	 * Calculation of infra red radiation of the day
	 * infra red radiation is (atmospheric radiation)-(system radiation, assuming T=Tair)
	 * gregoire Talbot 14/09/2007
	 * Brutsaert's formula, from Stics formalism
	*/
	public float infraRedCalculation(SafeApexInitialParameters settings, float rad, float extraRad,
										float vapourP, float tmin, float tmax){
		double t = (tmin+tmax)/2+2*(tmax-tmin)*Math.sin(Math.PI*this.dayLength/24)/this.dayLength;		// GT 1/02/2008
		double fracinsol = ((rad/extraRad)-settings.aangst)/settings.bangst;	//insolation fraction
		double eabrut = 1.24*Math.pow(vapourP/(t+273.15),1/7);
		double emissa = eabrut+(1-fracinsol)*(1-eabrut)*(1-4*11/(t+273.15));	//sky emissivity
		double infraRed = settings.sigma*Math.pow((t+273.15),4)*(1-emissa);				// W.m-2
		return (float) infraRed;
	}


	/**
	 * Calculation of saturated vapour pressure of air mbar
	*/
	public double vpSatFunction (double airTemp)
	{
		return (6.107 * Math.pow (
					(1 + Math.sqrt(2)*Math.sin(Math.PI*airTemp/3d/180d)),8.827));
	}

	/**
	 * Calculation of slope of the saturation vapour pressure curve of the air
	 */
	public double deltaFunction (double airTemp)
	{
		return (vpSatFunction(airTemp+0.5) - vpSatFunction(airTemp-0.5));
	}
	/**
	 * Calculation of ETP Penman
	 */
	public float getETPPenman (SafeApexInitialParameters settings, double rg, double visibleSky) {

		double gamma = settings.gamma;
		double tmoy = getMeanTemperature();
		double delta = getDelta();

		double dsat = vpSatFunction(tmoy) - getAirVapourPressure();
		double L = (2500840-2358.6*tmoy)/1000000;
		double fracinsol =((getGlobalRadiation()/getExtraTerrestrialRadiation ()) - 0.18) / 0.62;
		double var1 =Math.pow((tmoy + 273.16), 4)/1000000000;
		double var2 =(0.1 + 0.9*fracinsol);
		double var3 = 0.56 - 0.08*Math.sqrt(getAirVapourPressure());
		double rglo = 4.9 * var1 * var2 * var3;
		double rnetp =(1-0.2)*rg-rglo*visibleSky;
		double etp =  (rnetp/L*delta/(delta+gamma)+(gamma/(delta+gamma))
							 *(0.26*(1+0.54*getWindSpeed()))*dsat);
		etp = Math.max (etp,0);
		return (float) etp;

	}

	/**
	 * Calculation of rain transformed in snow of the day
	 * Calculation of snow melted  transformed in rain of the day
	 * Isabelle LECOMTE 26/10/2017
	*/
	public void calculateSnow (SafeApexInitialParameters settings, SafeApexDailyClimat yesterday) {
		
		//values from tomorrow tomorrow
		if (yesterday != null) {
			this.stockedSnow = yesterday.getStockedSnow();
			this.rainCapacityinSnow = yesterday.getRainCapacityinSnow();
		}
		

		//calculation of rain transformed in snow 	
		if ((this.getMeanTemperature () <= settings.minTempSnow) && (maxTemperature < settings.maxTempSnow)) {
			this.snow = this.rain;
			
			this.rainCapacityinSnow = this.rainCapacityinSnow + this.snow;
			this.rain = 0;
			this.stockedSnow = this.stockedSnow + this.snow;

		}
		//it is not snowing 
		else {			
			if (yesterday != null) {
				//calculation of rain stocked in snow
				if ((this.rain > 0) && (yesterday.getRainCapacityinSnow() > 0)) {
					float rainStockedInSnow = Math.min(this.rain,yesterday.getRainCapacityinSnow());
					this.rainCapacityinSnow = this.rainCapacityinSnow - rainStockedInSnow;
					this.rain = this.rain - rainStockedInSnow;
					this.stockedSnow = this.stockedSnow + rainStockedInSnow;
				}

				//calculation of melt 
				if  (yesterday.getStockedSnow() > 0)  {
					//max de fonte si tmoy > maxTempSnowMelt
					if (this.getMeanTemperature () > settings.maxTempSnowMelt)  {
						this.meltedSnow = Math.min ((float) settings.maxDailySnowMelt, yesterday.getStockedSnow());
					}	
					//pas de fonte si tmoy < minTempSnowMelt
					else {
						if (this.getMeanTemperature () < settings.minTempSnowMelt)  {
							this.meltedSnow = 0;
						}
						//interpolation entre maxTempSnowMelt et minTempSnowMelt
						else
						{
							this.meltedSnow = Math.min ((float) (settings.maxDailySnowMelt * ((this.getMeanTemperature () -settings.minTempSnowMelt) / (settings.maxTempSnowMelt-settings.minTempSnowMelt))), yesterday.getStockedSnow());
						}
					}	
					this.stockedSnow = this.stockedSnow - this.meltedSnow;
					this.rainCapacityinSnow = this.rainCapacityinSnow - this.meltedSnow;
				}
			}
		}



	}
	
	public int getYear () {return year;}
	public int getJulianDay () {return julianDay;}
	public int getDay () {return day;}
	public int getMonth () {return month;}

	public float getMeanTemperature () {return (maxTemperature+minTemperature)/2;}
	public float getMeanDayTemperature () {return ( (float) ((maxTemperature*0.81)+(minTemperature*(1-0.81))));}
	public float getMinTemperature () {return minTemperature;}
	public float getMaxTemperature () {return maxTemperature;}
	public float getMinRelativeHumidity() {return minRelativeHumidity;}
	public float getMaxRelativeHumidity () {return maxRelativeHumidity;}
	public float getEtpPenman () {return etpPenman;}
	public float getGlobalRadiation () {return globalRadiation;}
	public float getGlobalPar () {return globalPar;}
	public float getDiffusePar () {return diffusePar;}
	public float getDiffuseProp() {return (diffusePar/globalPar);}
	public float getDirectPar () {return globalPar - diffusePar;}
	public float getPrecipitation () {return precipitation;}
	public float getWindSpeed () {return windSpeed;}
	public float getCO2Concentration () {return cO2Concentration;}
	public float getSunDeclination () {return sunDeclination;}
	public float getDayLength () {return dayLength;}
	public float getExtraTerrestrialRadiation () {return extraTerrestrialRadiation;}
	public float getAirVpd () {return airVpd;}
	public float getAirVapourPressure () {return airVapourPressure;}
	public float getAirVapourPressureSat () {return airVapourPressureSat;}
	public float getAirDayVapourPressure () {return airDayVapourPressure;}
	public float getDelta () {return delta;}
	public float getInfraRedRadiation() {return infraRedRadiation;}
	
	//To avoid flood 
	public float getWaterTableDepth () {
		if (waterTableDepth >= 0) return (float)(-0.1);
		return (waterTableDepth);
	}
	
	//snow module (il 31-10-2017)
	public float getRain () {return rain;}
	public float getSnow () {return snow;}
	public float getStockedSnow () {return stockedSnow;}
	public float getMeltedSnow () {return meltedSnow;}
	public float getRainCapacityinSnow() {return rainCapacityinSnow;}



}
