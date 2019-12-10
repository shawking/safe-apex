package safeapex.model;
import java.util.Comparator;

/**
 * A class for sorting the tree on height
 *
 * @author Isabelle LECOMTE - June 2004
 */

public class SafeApexTreeHeightComparator implements Comparator
{
	public int compare (Object obj1, Object obj2) {
 		if(((SafeApexTree) obj1).getHeight() >=((SafeApexTree) obj2).getHeight() )
      		return 0;
 		else return 1;
 	}
}


