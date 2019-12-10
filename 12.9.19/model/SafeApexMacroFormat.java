package safeapex.model;

import java.util.Iterator;

import jeeb.lib.util.Import;
import jeeb.lib.util.Record;
import jeeb.lib.util.RecordSet;
import safeapex.apex.*;

/**
 * Records description for  MacroClimat
 *
 * @author Isabelle Lecomte - January 2003
 */
public class SafeApexMacroFormat extends RecordSet {


	// Safeapex crop species record is described here
	@Import
	static public class ClimatRecord extends Record {
		public ClimatRecord () {super ();}
		public ClimatRecord (String line) throws Exception {super (line);}
		//public String getSeparator () {return ";";}	// to change default "\t" separator

		public int julianDay;			//number of day in the year
		public int year;				//year YYYY
		public int month;				//month MM
		public int day;					//day DD
		public float tmax;				//temperature max in degree
		public float tmin;				//temperature min in degree
		public float rhmax;				//relative humidity in %
		public float rhmin;				//relative humidity min in %
		public float globalRadiation;	//global radiation in KW m-2
		public float rain;				//rain in mm
		public float windSpeed;			//m s-1
		public float waterTableDepth;	//m
		public float co2Concentration;	//ppm
	}

	public SafeApexMacroFormat (String climatFileName) throws Exception {createRecordSet (climatFileName);}

	/**
	 * Load RecordSet -> SafeApexMacroClimat
	 */
	public void load(SafeApexInitialParameters settings,
			SafeApexMacroClimat ms, float latitude) throws Exception {

		for (Iterator i = this.iterator(); i.hasNext();) {
			Record record = (Record) i.next();

			if (record instanceof SafeApexMacroFormat.KeyRecord) {

				SafeApexMacroFormat.KeyRecord r = (SafeApexMacroFormat.KeyRecord) record;
		
					  
			}
			else if (record instanceof SafeApexMacroFormat.ClimatRecord) {
				

				SafeApexMacroFormat.ClimatRecord cr =
							(SafeApexMacroFormat.ClimatRecord) record;	// cast to precise type

				ms.createDailyClimat(settings,  latitude,
										  cr.julianDay, cr.year , cr.month, cr.day,
										  cr.tmin, cr.tmax, cr.rhmin, cr.rhmax, cr.globalRadiation,
										  cr.rain, cr.windSpeed, cr.waterTableDepth, cr.co2Concentration);

			} else {
				throw new Exception ("Unrecognized record : "+record);	// automatic toString () (or null)

			}
			
		}



	}

}
