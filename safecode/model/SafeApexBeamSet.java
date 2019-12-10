package safeapex.model;

import capsis.lib.samsaralight.SLBeamSet;

/**
 * A light beam set composed of direct or diffuse beams.
 *
 * @see SafeApexBeam
 * @author B. Courbaud - January 2000
 */
public class SafeApexBeamSet<T> extends SLBeamSet {

	//sky mask by slope
	private double skyDiffuseMask;
	private double skyDirectMask;
	private double skyInfraRedMask;

	public SafeApexBeamSet () {
		super ();
		skyDiffuseMask = 1;
		skyDirectMask = 1;
	}

	public float getSize () {return  getBeams().size();}
	public double getSkyDiffuseMask () {return  skyDiffuseMask;}
	public double getSkyDirectMask () {return  skyDirectMask;}
	public double getSkyInfraRedMask () {return skyInfraRedMask;}

	public void setSkyDiffuseMask (double e) {skyDiffuseMask =  e;}
	public void setSkyDirectMask(double e) {skyDirectMask =  e;}
	public void setSkyInfraRedMask(double e) {skyInfraRedMask =  e;}

}