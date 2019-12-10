package safeapex.model;

import java.util.Collection;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;

import capsis.kernel.AbstractSettings;

/**
 * SafeApexTreeSettings - List of tree species settings.
 *
 * @author Isabelle Lecomte - July 2002
 */
public class SafeApexTreeSettings extends AbstractSettings {

	private Map species; // Map treeSpeciesName -> treeSpecies object


	/** Constructor
	*/
	public SafeApexTreeSettings () {
		species= new Hashtable ();
	}


	/** Add a species
	*/
	public void addSpecies (SafeApexTreeSpecies s) {
		species.put (s.getName (), s);
	}

	/** return the Species objet with this name
	*/
	public SafeApexTreeSpecies getSpecies (String treeSpeciesName) {
		return (SafeApexTreeSpecies) species.get (treeSpeciesName);
	}

	/**	Return the complete Species list
	*/
	public Collection getList () {
		return species.values ();
	}


	/**	To check the list in the Capsis inspector
	*/
	public String toString() {
		String s = "Tree Species list = ";
		for (Iterator i = species.values ().iterator (); i.hasNext ();) {
			SafeApexTreeSpecies sp = (SafeApexTreeSpecies) i.next ();

			s+=sp.getValue ()+" "+sp.getName ();
			if (i.hasNext ()) {s+=" - ";}
		}
		return s;
	}

}



