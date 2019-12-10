package safeapex.model;

import java.util.Iterator;
import jeeb.lib.util.Import;
import jeeb.lib.util.Record;
import jeeb.lib.util.RecordSet;




public class SafeApexCropFormat extends RecordSet {

	// Plant species record is described here
	@Import
	static public class ApexSpecies extends Record {
		
		public int id;
		public String code;    // plante code 
		public String name;    // plante name 
		
		/*------- WATER REPARTITION PARAMETERS --------------------------------*/
		public float cropRootDiameter;			//cm

		//For calculating the transpiration reduction factor following Campbell
		public float cropAlpha;
		public float cropMinTranspirationPotential;		//cm
		public float cropMaxTranspirationPotential;		//cm

		//Root axial conductance (1/resistance involved in water transport inside the root per unit gradient in water potential and per unit path-length)
		//Unit should be here kg s-1 cm-1, or if the flux is expressed in cm, cm cm-1
		//According to Tyree, root axial conductance is higher for large roots
		public float cropRootConductivity;				//cm cm-1

		//Potential drop needed to enter the root expressed as a % of soil water potential
		public float cropBufferPotential;					//cm

		//Longitudinal resistance factor for root sap
		public float cropLongitudinalResistantFactor;		//mm.cm-1.m-1
		
	    		  
		public ApexSpecies () {super ();}
		public ApexSpecies (String line) throws Exception {super (line);}
		
		//public String getSeparator () {return ";";}	// to change default "\t" separator
	}
	// Soil management record is described here
	
	//CONSTRUCTEUR
	
	public SafeApexCropFormat (String fileName) throws Exception {
		createRecordSet (fileName);
	}
	

	/**
	 * Load RecordSet -> SafeApexMacroClimat
	 */
	public void load (SafeApexCropSettings species) throws Exception {

		
		for (Iterator i = this.iterator (); i.hasNext ();) {

			Record record = (Record) i.next ();
			
			if (record instanceof SafeApexCropFormat.ApexSpecies) {

				SafeApexCropFormat.ApexSpecies r =
						(SafeApexCropFormat.ApexSpecies) record;	// cast to precise type
			
				SafeApexCropSpecies s = new SafeApexCropSpecies(
						r.id, r.code, r.name,
						r.cropRootDiameter,			
						r.cropAlpha,
						r.cropMinTranspirationPotential,		
						r.cropMaxTranspirationPotential,		
						r.cropRootConductivity,				
						r.cropBufferPotential,					
						r.cropLongitudinalResistantFactor);
				
				
				species.addSpecies(s);

			} 

			else {
				throw new Exception ("Unrecognized record : "+record);	// automatic toString () (or null)
			}
		}
	}
}

