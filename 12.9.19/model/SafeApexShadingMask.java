package safeapex.model;

import java.io.Serializable;
import java.util.Vector;

import jeeb.lib.util.Vertex3d;


/**
 * A collection of SafeApexShadingNeighbour (used for light interception by crops)
 *
 * @see SafeApexShadingNeighbour and SafeApexBeam
 * @author G. Talbot - May 2007
 */


public class SafeApexShadingMask implements Serializable {

protected Vector shadingNeighbours;	// relative coordinates (Points)
private Vertex3d impact;

	public SafeApexShadingMask(Vertex3d imp) {
		impact = imp;
		shadingNeighbours = new Vector ();
	}

	public void addShadingNeighbour (SafeApexShadingNeighbour c) {
		shadingNeighbours.add (c);
	}

	public Vector getShadingNeighbours () {
		return shadingNeighbours;
	}

	public Vertex3d getImpact (){
		return impact;
	}
}

