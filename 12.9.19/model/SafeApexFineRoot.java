package safeapex.model;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;


/**
 * Tree of crop fine root
 *
 * @author
 * Degi HARJA          - ICRAF Bogor Indonisia		- July 2004
 * Isabelle LECOMTE    - INRA Montpellier France
 *
 **/

public class SafeApexFineRoot implements   Serializable {

	/**
	 * This class contains immutable instance variables for a SafeApexFineRoot
	 */
	public static class Immutable implements  Cloneable, Serializable {
		private Object plant;			//Reference on initial SafeApexTree or SafeApexCrop object
	}
	protected Immutable immutable;

	//PLANT POTENTIALS
	private float radialTransportPotential;			//Potential gradient  for root radial transport entry (cm)
	private float longitudinalTransportPotential;	//Potential gradient for longitudinal transport (cm)
  	private float requiredWaterPotential;			//Required plant water potential (cm)
	private float actualWaterPotential;				//Required Plant Water Potential with reduced uptake (cm)
	private float waterUptakePotential;				//Potential water uptake in all rooted voxels (cm)
	private float nitrogenUptakePotential;			//Potential nitrogen uptake in all rooted voxels (g)
    private float waterDemandReductionFactor;		//Reduction factor for transpirational demand (dimensionless)
	private float nitrogenSinkStrength;				//dimensionless
	
	//Total root lenght in all rooted voxels (density * voxels volume)  (m)
	private float totalRootLength;					//m

	private SafeApexRootNode firstRootNode;		//First node for coarse root topology
	private HashMap rootTopology;			//Root topology of RootNode 
	private HashMap rootedVoxelMap;			//Root topology of RootVoxel
	/**
	 * Create an Immutable object whose class is declared at one level of the hierarchy.
	 * This is called only in constructor for new logical object in superclass.
	 * If an Immutable is declared in subclass, subclass must redefine this method
	 * (same body) to create an Immutable defined in subclass.
	 */
	protected void createImmutable () {immutable = new Immutable ();}

	/**
	* Root constructor
	*/
	public SafeApexFineRoot (Object plant)  {
		createImmutable ();

		this.immutable.plant = plant;			//tree or crop
		this.totalRootLength = 0;
		this.rootedVoxelMap = null;
		this.radialTransportPotential = 0;
		this.longitudinalTransportPotential = 0;
		this.requiredWaterPotential = 0;
		this.actualWaterPotential = 0;
		this.waterUptakePotential = 0;
		this.nitrogenUptakePotential = 0;
		this.waterDemandReductionFactor = 0;
   		this.nitrogenSinkStrength = 0;
   		
		this.rootTopology = new LinkedHashMap (); // fc+qm-6.8.2014 tracking inconsistency
		this.firstRootNode = null;
		
	}

	/**
	* Constructor for cloning a SafeApexFineRoot
	*/
	public SafeApexFineRoot (SafeApexFineRoot rootModel) {


		this.immutable = rootModel.immutable;	// that's why immutable objects exist
		this.totalRootLength 	= rootModel.totalRootLength;
		this.rootedVoxelMap = null;
		this.radialTransportPotential=0;
		this.longitudinalTransportPotential= 0;
	  	this.requiredWaterPotential= 0;
		this.actualWaterPotential= 0;
		this.waterUptakePotential= 0;
		this.nitrogenUptakePotential = 0;
	    this.waterDemandReductionFactor= 0;
   		this.nitrogenSinkStrength = 0;
   		
   	   	
   		this.firstRootNode = rootModel.firstRootNode;
   		this.rootTopology = new LinkedHashMap ();
   		
		//Cloning topology coarse roots hash map
		//voxel references have CHANGED after cloning the STAND !!!!!
   		if (firstRootNode != null) {
			cloneNode(this.rootTopology, this.firstRootNode);
			if  (rootModel.firstRootNode.getNodeColonised() != null) 
				this.cloneRootTopology(this.rootTopology, this.firstRootNode.getNodeColonised());
		}

   		//clear to save memory space
		rootModel.rootTopology = null;
	}

	/**
	* ESTIMATION OF PLANT WATER POTENTIAL (at stem base)
	* On the basis of the various resistances in the catenary process
	*
	* IN  : potentialWaterDemand = Potential amount of water demand by plant per day (l/m^2 or mm)
	*
	*/
	public void calculatePotential (SafeApexInitialParameters settings, double potentialWaterDemand) {

		//***************** PLANT SPECIES PARAMETERS *******************************//
		// expected resistance between bulk soil in the voxel and the root surfaces
		
		double campbellFactor = 0;
		double halfCurrWaterPotential = 0;

		//Tree species
  		if (this.getPlant() instanceof SafeApexTree) {
			  campbellFactor = ((SafeApexTree) this.getPlant()).getTreeSpecies().getCampbellFactorIcraf();
			  halfCurrWaterPotential =  ((SafeApexTree) this.getPlant()).getTreeSpecies().getHalfCurrWaterPotentialIcraf();
  		}
  		//Crop species
  		if (this.getPlant() instanceof SafeApexCrop) {
			  campbellFactor = ((SafeApexCrop) this.getPlant()).getCropSpecies().getCampbellFactorIcraf();
			  halfCurrWaterPotential =  ((SafeApexCrop) this.getPlant()).getCropSpecies().getHalfCurrWaterPotentialIcraf();
  		}
		
		setWaterDemandReductionFactor (1d / (1d + Math.pow (getRequiredWaterPotential() / halfCurrWaterPotential, campbellFactor)));

	
		//actualWaterPotential (cm)
		setActualWaterPotential (getRequiredWaterPotential()
								- (1-getWaterDemandReductionFactor ())
								* (getRadialTransportPotential () + getLongitudinalTransportPotential ()));
								 
		setRadialTransportPotential(getRadialTransportPotential()*getWaterDemandReductionFactor());		// gt - 12.11.2009
		setLongitudinalTransportPotential(getLongitudinalTransportPotential()*getWaterDemandReductionFactor());		// gt - 12.11.2009 desactiv�	//GT 20/94/2011	r�activ�

		return;

	}

	/**
	* CALCULATION OF PLANT WATER ACTUAL UPTAKE
	* as the minimum of demand and total supply
	* and allocate it to voxels on the basis of potential uptake rates and its root density
	*
	* OUT : waterUptakeTotal = Total amount of water uptaken by plant per day (liters)
	*/

	public double calculateWaterUptake (SafeApexStand stand, Object plant, SafeApexInitialParameters settings, double actualWaterDemand,int day) {

		
		double waterUptakeTotal = 0;
		double waterUptakePotentialTotal  	= this.getWaterUptakePotential ();


		if (this.getRootedVoxelMap() == null) return 0;

		Iterator itr = this.getRootedVoxelMap().iterator();
		while (itr.hasNext()) {

			SafeApexVoxel voxel = (SafeApexVoxel) itr.next();
  			SafeApexRootVoxel rootVoxel = getRootedVoxelMap (voxel);
  			double waterUptake = 0;
  			double waterUptakePotential = rootVoxel.getWaterUptakePotential();

			//Water uptake potential for this plant in this voxel (liters)
			if (waterUptakePotentialTotal > actualWaterDemand) {
				waterUptake = actualWaterDemand * waterUptakePotential /waterUptakePotentialTotal;
			}
			else {
				waterUptake = waterUptakePotential;
			}

			
			//cumulation of water uptaken in the voxel for each plant
			if (waterUptake > 0) {

				//rootVoxel.addWaterUptake (waterUptake);
				waterUptakeTotal += waterUptake;

				if (this.getPlant() instanceof SafeApexCrop) {
					SafeApexCrop crop = (SafeApexCrop) (plant) ;
					voxel.addCropWaterUptake (waterUptake);
				
					if (crop.getFineRoots().getRootTopology ().containsKey(voxel)) {
						SafeApexRootNode rootNode = crop.getFineRoots().getRootTopology (voxel);
						rootNode.addWaterUptake (waterUptake);
					}
					
					if(voxel.getIsSaturated())	// gt - 5.02.2009
						voxel.getCell().addWaterUptakeInSaturationByCrop(waterUptake);	
				}
				else {
					SafeApexTree tree = (SafeApexTree) (plant) ;
					int treeIndex = tree.getId() - 1;
					voxel.addTreeWaterUptake  (treeIndex, waterUptake);
					tree.addWaterUptake (waterUptake);

					if (tree.getFineRoots().getRootTopology().containsKey(voxel)) {
						SafeApexRootNode node = tree.getFineRoots().getRootTopology (voxel);
						node.addWaterUptake (waterUptake);
					}
					
					if(voxel.getIsSaturated())	{
						voxel.getCell().addWaterUptakeInSaturationByTrees(waterUptake);	
						tree.addWaterUptakeInSaturation(waterUptake);	
					}

				}
				
				if(!voxel.getIsSaturated())	// gt - 5.02.2009 - waterStock is reduced only if voxel is not saturated
					voxel.reduceWaterStock  (waterUptake);
			}
		}
		return waterUptakeTotal;
	}

	/**
	* CALCULATION OF PLANT NITROGEN SINK STRENGTH
	*
	* OUT : Current demand per unit root lenght (dimensionless, timedependent)
	*/
	public void calculateNitrogenSinkStrength (SafeApexInitialParameters settings, double nitrogenDemand) {

		
		double totalRootLength = this.getTotalRootLength();		
		
		setNitrogenSinkStrength (nitrogenDemand / totalRootLength);

	}

	/**
	* CALCULATION OF PLANT NITROGEN ACTUAL UPTAKE
	* as the minimum of demand and total supply
	* and allocate it to voxels on the basis of potential uptake rates and its root density
	*
	* OUT : nitrogenUptakeTotal = Total amount of nitrogen uptaken by plant per day (g)
	*/

	public double calculateNitrogenUptake (SafeApexStand stand, Object plant, SafeApexInitialParameters settings, double nitrogenDemand) {


		double nitrogenUptakeTotal = 0;
		double nitrogenUptakePotentialTotal  	= this.getNitrogenUptakePotential ();	//g


		if (this.getRootedVoxelMap() == null) return 0;

		Iterator itr = this.getRootedVoxelMap().iterator();
		while (itr.hasNext()) {

			SafeApexVoxel voxel = (SafeApexVoxel) itr.next();
  			SafeApexRootVoxel rootVoxel = getRootedVoxelMap (voxel);
  			double nitrogenUptake = 0;
  			double nitrogenUptakePotential = rootVoxel.getNitrogenUptakePotential();	//g
			//Water uptake potential for this plant in this voxel (liters)
			if (nitrogenUptakePotentialTotal > nitrogenDemand) {
				nitrogenUptake = nitrogenDemand * nitrogenUptakePotential /nitrogenUptakePotentialTotal;
				}
			else {
				nitrogenUptake = nitrogenUptakePotential;
			}


			//cumulation of nitrogen uptaken in the voxel for each plant
			if (nitrogenUptake > 0) {
				
				//rootVoxel.addNitrogenUptake (nitrogenUptake);
				nitrogenUptakeTotal += nitrogenUptake;
				
				if (this.getPlant() instanceof SafeApexCrop) {
					SafeApexCrop crop = (SafeApexCrop) (plant) ;
					voxel.addCropNitrogenUptake (nitrogenUptake);		//g
					if (crop.getFineRoots().getRootTopology().containsKey(voxel)) {
						SafeApexRootNode node = crop.getFineRoots().getRootTopology (voxel);
						node.addNitrogenUptake (nitrogenUptake/1000); //convert g in kg
					}
					if(voxel.getIsSaturated())	// gt - 5.02.2009
						voxel.getCell().addNitrogenUptakeInSaturationByCrop (nitrogenUptake/1000/(voxel.getCell().getArea()/10000));	//convert g in kg ha-1
				}
				else {
					SafeApexTree tree = (SafeApexTree) (plant) ;
					int treeIndex = tree.getId() - 1;
					voxel.addTreeNitrogenUptake  (treeIndex, nitrogenUptake);	//g		
					tree.addNitrogenUptake (nitrogenUptake/1000);		//convert g in kg
					if (tree.getFineRoots().getRootTopology().containsKey(voxel)) {
						SafeApexRootNode node = tree.getFineRoots().getRootTopology (voxel);
						node.addNitrogenUptake (nitrogenUptake/1000);
					}
					

				
					if(voxel.getIsSaturated())	{
						voxel.getCell().addNitrogenUptakeInSaturationByTrees (nitrogenUptake/1000/(voxel.getCell().getArea()/10000));	//convert g in kg ha-1
						tree.addNitrogenUptakeInSaturation (nitrogenUptake/1000);	//convert g in kg
					}
				}
			}
		}

		return nitrogenUptakeTotal;
	}
	

	//ACCESSORS FOR PLANT WATER POTENTIALS
	public Object getPlant () {return immutable.plant;}
	public String getPlantName () {
		String ret = "";
		if (this.getPlant() instanceof SafeApexCrop) {
			SafeApexCrop crop = (SafeApexCrop) (getPlant ()) ;
			ret=crop.getCell().getId()+" "+crop.getCropSpecies().getName();
			
		}
		if (this.getPlant() instanceof SafeApexTree) {
			SafeApexTree tree = (SafeApexTree) (getPlant ()) ;
			ret=tree.getId()+" "+tree.getTreeSpecies().getName();
			
		}
		return ret;
	}
	public double getTotalRootLength () {return (double) totalRootLength;}
	public double getRadialTransportPotential () {return (double) radialTransportPotential;}
	public double getLongitudinalTransportPotential () {return (double) longitudinalTransportPotential;}
	public double getRequiredWaterPotential () {return (double) requiredWaterPotential;}
	public double getActualWaterPotential () {return (double) actualWaterPotential;}
	public double getWaterUptakePotential () {return (double) waterUptakePotential;}
	public double getWaterDemandReductionFactor () {return (double) waterDemandReductionFactor;}
	public double getNitrogenSinkStrength () {return (double) nitrogenSinkStrength;}
	public double getNitrogenUptakePotential () {return (double) nitrogenUptakePotential;}

	
	public void setTotalRootLength (double v) {totalRootLength = (float) v;}
	public void setRadialTransportPotential (double v) {radialTransportPotential = (float) v;}
	public void setLongitudinalTransportPotential (double v) {longitudinalTransportPotential = (float) v;}
	public void setRequiredWaterPotential (double v) {requiredWaterPotential = (float) v;}
	public void setActualWaterPotential (double v) {actualWaterPotential = (float) v;}
	public void addUptakeWaterPotential (double v) {waterUptakePotential += (float) v;}
	private void  setNitrogenSinkStrength (double v) {nitrogenSinkStrength = (float) v;}
	public  void setNitrogenUptakePotential (double v) {nitrogenUptakePotential = (float) v;}
	public  void addNitrogenUptakePotential (double v) {nitrogenUptakePotential += (float) v;}
	public void setWaterDemandReductionFactor (double v) {waterDemandReductionFactor= (float) v;}


  	public Collection getRootedVoxelMap () {
		if (rootedVoxelMap == null) return null;
		else return rootedVoxelMap.keySet ();
  	}

  	public SafeApexRootVoxel getRootedVoxelMap (SafeApexVoxel v) {
		return (SafeApexRootVoxel) rootedVoxelMap.get (v);
  	}

	//storing water repartition result in rootedVoxelMap
  	public void addRootedVoxelMap (SafeApexVoxel v, SafeApexRootVoxel root) {
		if (rootedVoxelMap == null) rootedVoxelMap = new LinkedHashMap(); // fc+qm-6.8.2014 keep the insertion order (inconsistency tracking)
//		if (rootedVoxelMap == null) rootedVoxelMap = new HashMap();
		rootedVoxelMap.put (v, root);
	}


	/**
	* cloning root topology hash MAP
	*/
  	public void cloneRootTopology (HashMap after, Collection collection) {
		if (collection == null) return;
		for (Iterator v = collection.iterator (); v.hasNext ();) {
			SafeApexRootNode node = (SafeApexRootNode) v.next ();
			cloneNode(after, node);
			cloneRootTopology (after, node.getNodeColonised());
		}
  	} 	
    //We have decides that Root node is not cloned
  	//BUT voxel references have changed because of cells cloning
  	public void cloneNode (HashMap after, SafeApexRootNode node) {
		//New voxel reference for the KEY voxel
		SafeApexVoxel voxelBefore = node.getVoxelRooted ();
		SafeApexVoxel cloningReference = voxelBefore.getCloningReference();
		node.setVoxelRooted (cloningReference);
		node.setWaterUptake (0);
		node.setNitrogenUptake(0);
		node.setFineRootCost(0);

		
		//ADD the new SET in the HashMap
		after.put (cloningReference, node);
  	} 
  	
  //ROOT TOPOLOGY
  	public HashMap getRootTopology() {return rootTopology;}

  	public SafeApexRootNode getRootTopology (SafeApexVoxel voxel) {
  		return (SafeApexRootNode) (rootTopology.get (voxel));}

  	public SafeApexRootNode getFirstRootNode() {return firstRootNode;}
  	public void setFirstRootNode(SafeApexRootNode node) {firstRootNode = node;}

	//Set density of an existing fine root
	public void setFineRootTopology (SafeApexVoxel voxel, double density) {
		SafeApexRootNode node = (SafeApexRootNode) (rootTopology.get (voxel));
		node.setFineRootDensity (density);
	}
	
	//Add a new TREE root in the root topology 
	public void addTreeRootTopology (SafeApexTree tree, SafeApexVoxel voxel, SafeApexVoxel parentVoxel, int day, double fineRootDensity, int direction) {
		if (rootTopology == null) rootTopology = new LinkedHashMap ();
		SafeApexRootNode parentNode = null;
		if (parentVoxel != null)
			parentNode = getRootTopology (parentVoxel);
		
		SafeApexRootNode node = new SafeApexRootNode (voxel, parentNode, day, fineRootDensity, tree, direction);
		rootTopology.put (voxel, node);
  		//no parent = this node is the first one
  		if (parentVoxel == null)
  			this.firstRootNode = node;
	}
	
	//Add a new CROP root in the root topology 
	public void addCropRootTopology (SafeApexVoxel voxel, SafeApexVoxel parentVoxel, int day, double fineRootDensity) {
		if (rootTopology == null) rootTopology = new LinkedHashMap ();
		SafeApexRootNode parentNode = null;
		if (parentVoxel != null)
			parentNode = getRootTopology (parentVoxel);
		
		SafeApexRootNode node = new SafeApexRootNode (voxel, parentNode, day, fineRootDensity);
		rootTopology.put (voxel, node);
  		//no parent = this node is the first one
  		if (parentVoxel == null)
  			this.firstRootNode = node;
	}
	
  	//Add a new  root in a parent voxel (direction = 4 always from the top) 
  	public void addEmptyRootTopology (SafeApexVoxel voxel) {
		if (rootTopology == null) rootTopology = new LinkedHashMap ();
  		rootTopology.put (voxel, new SafeApexRootNode (voxel, null, 0, 0, null, 4));
  	}
}
