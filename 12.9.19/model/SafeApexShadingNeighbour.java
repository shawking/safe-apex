

package safeapex.model;

import java.awt.Point;

import capsis.defaulttype.ShiftItem;

/**
 * Used for light interception by crops
 * Contains : a neigbour cell, its relative coordinates, and informations about the path of a
 * beam above this cell (distance to impact point of entrance and exit points)
 *
 * @see SafeApexShadingMask
 * @author G. Talbot - May 2007
 */

public class SafeApexShadingNeighbour {
	Point p;		//cell coordinates (x,y) relatively to target cell
	double lOut; 	//distance entre le point de sortie de la cellule concurrente et le point d'impact
	double lIn;
	SafeApexCell cell;
	ShiftItem shift;

	/*
	Constructor
	*/

	public SafeApexShadingNeighbour (Point e, double lin, double lout){
		p = e;
		lOut = lout;
		lIn = lin;
	}

	/*
	accessors
	*/

	public void setLOut (double l) {lOut = l;}
	public double getLOut () {return lOut;}
	public void setLIn (double l) {lIn = l;}
	public double getLIn () {return lIn;}
	public SafeApexCell getCell() {return cell;}
	public ShiftItem getShift() {return shift;}
	public void setCell (SafeApexCell c) {cell = c;}
	public void setShift (ShiftItem s) {shift = s;}
	public Point getRelCoordinates () {return p;}


}

