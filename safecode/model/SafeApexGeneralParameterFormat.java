package safeapex.model;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import jeeb.lib.util.AmapTools;
import jeeb.lib.util.CancellationException;
import jeeb.lib.util.Record;
import jeeb.lib.util.RecordSet;
import safeapex.apex.*;

/**
 * Records description for  GENERAL parameters
 *
 * @author : Isabelle LECOMTE  - INRA SYSTEM Montpellier (March 2003)
 */
public class SafeApexGeneralParameterFormat extends RecordSet {

	public SafeApexGeneralParameterFormat (String fileName) throws Exception {
		createRecordSet (fileName);
		System.out.println("SafeApexGeneralParameterFormat fileName="+fileName);
	}

	
	/**
	 * File -> RecordSet is delegated to superclass.
	 */
 // for direct use for Import

	public SafeApexGeneralParameterFormat ()
			throws Exception {
		createRecordSet ();
	} // for direct use for Export

	public void createRecordSet ()
			throws Exception {


	}
	
	/**
	 * Load general parameters
	 */
	public  void load (SafeApexInitialParameters settings) throws Exception {

		Set<String> requiredParameters = new HashSet<>();

		requiredParameters.add("diffuseCoeffA");
		requiredParameters.add("diffuseCoeffB");
		requiredParameters.add("SOC");
		requiredParameters.add("UOC");
		requiredParameters.add("turtleOption");
		requiredParameters.add("timeStep");
		requiredParameters.add("nbTimeStepMax");
		requiredParameters.add("diffuseAngleStep");
		requiredParameters.add("declinationThreshold");
		requiredParameters.add("leafAreaThreshold");
		requiredParameters.add("nbImpactMultiplication");
		requiredParameters.add("parGlobalCoefficient");
		requiredParameters.add("molesParCoefficient");
		requiredParameters.add("aangst");
		requiredParameters.add("bangst");
		requiredParameters.add("priestleyTaylorCoeff");
		requiredParameters.add("sigma");
		requiredParameters.add("gamma");
		requiredParameters.add("harmonicWeightedMean");
		requiredParameters.add("integrationStep");
		requiredParameters.add("maxPhiPF");
		requiredParameters.add("maxTempSnow");
		requiredParameters.add("minTempSnow");
		requiredParameters.add("maxDailySnowMelt");
		requiredParameters.add("maxTempSnowMelt");	
		requiredParameters.add("minTempSnowMelt");							
		requiredParameters.add("nitrogenDiffusionConstant");													
		requiredParameters.add("nitrogenEffectiveDiffusionA0");												
		requiredParameters.add("nitrogenEffectiveDiffusionA1");										
		requiredParameters.add("no3AbsorptionConstant");
		requiredParameters.add("nh4AbsorptionConstant");													
		requiredParameters.add("no3Fraction");
	
		
		for (Iterator i = this.iterator (); i.hasNext ();) {
			Record record = (Record) i.next ();

		 	if (record instanceof SafeApexGeneralParameterFormat.KeyRecord) {

		 		SafeApexGeneralParameterFormat.KeyRecord r = (SafeApexGeneralParameterFormat.KeyRecord) record;

				if (r.key.equals ("diffuseCoeffA")) {
					settings.diffuseCoeffA = r.getDoubleValue ();
					requiredParameters.remove("diffuseCoeffA");
					
				} else if  (r.key.equals ("diffuseCoeffB")) {
					settings.diffuseCoeffB  = r.getDoubleValue ();
					requiredParameters.remove("diffuseCoeffB");
					
				} else if  (r.key.equals ("parGlobalCoefficient")) {
					settings.parGlobalCoefficient  = r.getDoubleValue ();
					requiredParameters.remove("parGlobalCoefficient");
					
				} else if  (r.key.equals ("molesParCoefficient")) {
					settings.molesParCoefficient  = r.getDoubleValue ();
					requiredParameters.remove("molesParCoefficient");
					
				} else if  (r.key.equals ("aangst")) {
					settings.aangst  = r.getDoubleValue ();
					requiredParameters.remove("aangst");
					
				} else if  (r.key.equals ("bangst")) {
					settings.bangst  = r.getDoubleValue ();
					requiredParameters.remove("bangst");
					
				} else if  (r.key.equals ("priestleyTaylorCoeff")) {
					settings.priestleyTaylorCoeff  = r.getDoubleValue ();
					requiredParameters.remove("priestleyTaylorCoeff");
					
				} else if  (r.key.equals ("sigma")) {
					settings.sigma  = r.getDoubleValue ();
					requiredParameters.remove("sigma");
					
				} else if (r.key.equals ("gamma")) {
					settings.gamma  = r.getDoubleValue ();	
					requiredParameters.remove("gamma");
								
				} else if (r.key.equals ("timeStep")) {
					settings.timeStep  = r.getDoubleValue ();
					requiredParameters.remove("timeStep");
					
				} else if (r.key.equals ("nbTimeStepMax")) {
					settings.nbTimeStepMax  = r.getIntValue ();	
					requiredParameters.remove("nbTimeStepMax");
					
				} else if (r.key.equals ("diffuseAngleStep")) {
					settings.diffuseAngleStep  = r.getDoubleValue ();
					requiredParameters.remove("diffuseAngleStep");
					
				} else if (r.key.equals ("declinationThreshold")) {
					settings.declinationThreshold  = r.getDoubleValue ();
					requiredParameters.remove("declinationThreshold");
					
				} else if (r.key.equals ("leafAreaThreshold")) {
					settings.leafAreaThreshold  = r.getDoubleValue ();	
					requiredParameters.remove("leafAreaThreshold");
					
				} else if (r.key.equals ("nbImpactMultiplication")) {
					settings.nbImpactMultiplication  = r.getIntValue ();
					requiredParameters.remove("nbImpactMultiplication");
						
				} else if (r.key.equals("SOC")) {
					int ri = r.getIntValue();
					settings.SOC = true;
					if (ri == 0) settings.SOC = false;
					if (ri == 1) settings.SOC = true;
					requiredParameters.remove("SOC");
					
				} else if (r.key.equals("UOC")) {
					int ri = r.getIntValue();
					settings.UOC = false;
					if (ri == 0) settings.UOC = false;
					if (ri == 1) settings.UOC = true;	
					requiredParameters.remove("UOC");
					
				} else if (r.key.equals("turtleOption")) {
					int ri = r.getIntValue();
					settings.turtleOption = false;
					if (ri == 0) settings.turtleOption = false;	
					if (ri == 1) settings.turtleOption = true;	
					requiredParameters.remove("turtleOption");
					
				} else if (r.key.equals("cropLightMethod")) {
					int ri = r.getIntValue();
					settings.cropLightMethod = false;
					if (ri == 0) settings.cropLightMethod = false;
					if (ri == 1) settings.cropLightMethod = true;
					
				} else if  (r.key.equals ("harmonicWeightedMean")) {
					settings.harmonicWeightedMean  = r.getDoubleValue ();
					requiredParameters.remove("harmonicWeightedMean");
					
				} else if  (r.key.equals ("integrationStep")) {
					settings.integrationStep  = r.getDoubleValue ();
					requiredParameters.remove("integrationStep");
					
				} else if  (r.key.equals ("maxPhiPF")) {
					settings.maxPhiPF  = r.getDoubleValue ();
					requiredParameters.remove("maxPhiPF");
				
				} else if  (r.key.equals ("maxTempSnow")) {
					settings.maxTempSnow  = r.getDoubleValue ();
					requiredParameters.remove("maxTempSnow");
					
				} else if  (r.key.equals ("minTempSnow")) {
					settings.minTempSnow  = r.getDoubleValue ();
					requiredParameters.remove("minTempSnow");
					
				} else if  (r.key.equals ("maxDailySnowMelt")) {
					settings.maxDailySnowMelt  = r.getDoubleValue ();
					requiredParameters.remove("maxDailySnowMelt");
					
				} else if  (r.key.equals ("maxTempSnowMelt")) {
					settings.maxTempSnowMelt  = r.getDoubleValue ();
					requiredParameters.remove("maxTempSnowMelt");
					
				} else if  (r.key.equals ("minTempSnowMelt")) {
					settings.minTempSnowMelt  = r.getDoubleValue ();
					requiredParameters.remove("minTempSnowMelt");
					
				
				
				} else if (r.key.equals ("nitrogenDiffusionConstant")) {
					settings.nitrogenDiffusionConstant = r.getDoubleValue ();
					requiredParameters.remove("nitrogenDiffusionConstant");
					
				} else if (r.key.equals ("nitrogenEffectiveDiffusionA0")) {
					settings.nitrogenEffectiveDiffusionA0 = r.getDoubleValue ();
					requiredParameters.remove("nitrogenEffectiveDiffusionA0");
					
				} else if (r.key.equals ("nitrogenEffectiveDiffusionA1")) {
					settings.nitrogenEffectiveDiffusionA1 = r.getDoubleValue ();
					requiredParameters.remove("nitrogenEffectiveDiffusionA1");
					
				} else if (r.key.equals ("no3AbsorptionConstant")) {
					settings.no3AbsorptionConstant = r.getDoubleValue ();
					requiredParameters.remove("no3AbsorptionConstant");
					
				} else if (r.key.equals ("nh4AbsorptionConstant")) {
					settings.nh4AbsorptionConstant = r.getDoubleValue ();
					requiredParameters.remove("nh4AbsorptionConstant");
					
				} else if (r.key.equals ("no3Fraction")) {
					settings.no3Fraction = r.getDoubleValue ();	
					requiredParameters.remove("no3Fraction");
					
				
				}
		 	}
		}
		//missing required parameters
		if (!requiredParameters.isEmpty()) {
			System.out.println("Missing general parameters : " + AmapTools.toString(requiredParameters));
			throw new CancellationException();	// abort

		}
	}
}
