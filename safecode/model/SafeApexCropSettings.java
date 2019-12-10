package safeapex.model;

import java.util.Collection;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;

public class SafeApexCropSettings {
	private Map species; // Map cropSpeciesCode -> cropSpecies object

	/** Constructor
	*/
	public SafeApexCropSettings () {
		species= new Hashtable ();
	}
	

	/** Add a species
	*/
	public void addSpecies (SafeApexCropSpecies s) {
		species.put (s.getCode (), s);
	}
	

	/** return the Species objet with this name
	*/
	public SafeApexCropSpecies getSpecies (String cropSpeciesCode) {
		return (SafeApexCropSpecies) species.get (cropSpeciesCode);
	}

	/**	Return the complete Species list
	*/
	public Collection getList () {
		return species.values ();
	}
	/**	To check the list in the Capsis inspector
	*/
	public String toString() {
		String s = "Crop Species list = ";
		for (Iterator i = species.values ().iterator (); i.hasNext ();) {
			SafeApexCropSpecies sp = (SafeApexCropSpecies) i.next ();

			s+=sp.getValue ()+" "+sp.getName ();
			if (i.hasNext ()) {s+=" - ";}
		}
		return s;
	}

}
