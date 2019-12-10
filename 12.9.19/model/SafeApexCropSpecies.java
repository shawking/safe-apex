package safeapex.model;

import java.io.Serializable;
import capsis.defaulttype.Species;


/**
 * Crop species parameters HISAFE specific
 * APEX parameters are in safeapex.apex.SafeApexPlant
 *
 * @author Isabelle Lecomte - October 2018
 */
public class SafeApexCropSpecies implements Species,Serializable, Cloneable {	// fc - 29.7.2004 - EnumProperty

	
	private boolean isInitialized;			//APEX initialisation is done
	private SafeApexCell firstCell;			//First cell planted with this crop species
	private String code; 					//code of crop species
	private String name; 					//name of crop species

	/*-------- APEX parameters --------------------------------------------*/
	private int value;
	
	
	/*------- WATER REPARTITION PARAMETERS --------------------------------*/
	private float cropRootDiameter;			//cm

	//For calculating the transpiration reduction factor following Campbell
	private float cropAlpha;
	private float cropMinTranspirationPotential;		//cm
	private float cropMaxTranspirationPotential;		//cm

	//Root axial conductance (1/resistance involved in water transport inside the root per unit gradient in water potential and per unit path-length)
	//Unit should be here kg s-1 cm-1, or if the flux is expressed in cm, cm cm-1
	//According to Tyree, root axial conductance is higher for large roots
	private float cropRootConductivity;				//cm cm-1

	//Potential drop needed to enter the root expressed as a % of soil water potential
	private float cropBufferPotential;					//cm

	//Longitudinal resistance factor for root sap
	private float cropLongitudinalResistantFactor;		//mm.cm-1.m-1


	/**	Constructor
	*/
	public SafeApexCropSpecies ()   {
		this.isInitialized = false;
	}

	public SafeApexCropSpecies (int value,String code, String name)   {
		
		this.isInitialized = false;
		this.value=value;
		this.code=code;
		this.name=name;
	}
	
	public SafeApexCropSpecies (
			int value, String code, String name,	
			float cropRootDiameter,			
			float cropAlpha,
			float cropMinTranspirationPotential,		
			float cropMaxTranspirationPotential,		
			float cropRootConductivity,				
			float cropBufferPotential,					
			float cropLongitudinalResistantFactor)   {
		
		this.isInitialized = false;
		this.value=value;
		this.code=code;
		this.name=name;
		System.out.println("creation value="+value+" crop="+code+" name="+name);

		this.cropRootDiameter=cropRootDiameter;			
		this.cropAlpha=cropAlpha;
		this.cropMinTranspirationPotential=cropMinTranspirationPotential;		
		this.cropMaxTranspirationPotential=cropMaxTranspirationPotential;		
		this.cropRootConductivity=cropRootConductivity;				
		this.cropBufferPotential=cropBufferPotential;					
		this.cropLongitudinalResistantFactor=cropLongitudinalResistantFactor;		
	}
	

	public int getValue() {return value;}
	public String getCode () {return code;}
	public String getName () {return name;}
	public boolean getIsInitialized () {return isInitialized;}
	public SafeApexCell getFirstCell () {return firstCell;}
	public void setIsInitialized (boolean b) {isInitialized = b;}
	public void setFirstCell(SafeApexCell c) {firstCell = c;}

	public double getCropRootDiameter() {return (double) cropRootDiameter;}
	public double getCropAlpha() {return (double) cropAlpha;}
	public double getCropRootConductivity() {return (double) cropRootConductivity;}
	public double getCropMaxTranspirationPotential() {return (double) cropMaxTranspirationPotential;}
	public double getCropMinTranspirationPotential() {return (double) cropMinTranspirationPotential;}
	public double getCropBufferPotential() {return (double) cropBufferPotential;}
	public double getCropLongitudinalResistantFactor() {return (double) cropLongitudinalResistantFactor;}

	

	//TO FORCED PARAMETERS VALUES
	public void setName (String v) {name = v;}
	public void setCropRootDiameter (double v) {cropRootDiameter = (float) v;}
	public void setCropAlpha (double v) {cropAlpha = (float) v;}
	public void setCropRootConductivity(double v) {cropRootConductivity = (float) v;}
	public void setCropMaxTranspirationPotential (double v) {cropMaxTranspirationPotential = (float) v;}
	public void setCropMinTranspirationPotential (double v) {cropMinTranspirationPotential = (float) v ;}
	public void setCropBufferPotential(double v) {cropBufferPotential = (float) v;}
	public void setCropLongitudinalResistantFactor(double v) {cropLongitudinalResistantFactor = (float) v;}

	/**
	 * return Campbell factor  (dimensionless)
	 * ICRAF method
	 */
	public double getCampbellFactorIcraf() {
		return (2 * Math.log (getCropAlpha() / (1 - getCropAlpha()))
				/ Math.log (getCropMaxTranspirationPotential() / getCropMinTranspirationPotential()));
	}
	
	/**
	 * return Campbell factor (dimensionless) 
	 * NOT USED
	 */
	public double getCampbellFactor (double plantWaterPotential) {
		double halfCurrWaterPotential= getHalfCurrWaterPotential();
		double a = getA();
		return 1.0/(1.0+Math.pow(plantWaterPotential/halfCurrWaterPotential,a));
	}
	
	/**
	*  return water potential where tranpiration demand is half of its potential
	*  ICRAF method
	*/
	public double getHalfCurrWaterPotentialIcraf() {
			return (getCropMaxTranspirationPotential() 
					* Math.pow ((1 - getCropAlpha()) / getCropAlpha(), 1 / getCampbellFactorIcraf()));
	}

	/**
	 * return water potential where tranpiration demand is half of its potential 
	 * NOT USED
	 */
	public double getHalfCurrWaterPotential() {
			return -Math.sqrt (getCropMaxTranspirationPotential() * getCropMinTranspirationPotential());
	}
	

	public double getA() {
			return (2.0 * Math.log (getCropAlpha() / (1 - getCropAlpha()))
					   / Math.log (getCropMaxTranspirationPotential() / getCropMinTranspirationPotential()));
	}

}


