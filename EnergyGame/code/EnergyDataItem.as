package code {
	
	public class EnergyDataItem {

    private var _year:int;

    private var sectors:Vector.<EnergyDataSector>;
    
    private var _efficiencySector:EnergyDataSector;
		private var _electricitySector:EnergyDataSector;
		private var _heatSector:EnergyDataSector;
		private var _vehicleFuelSector:EnergyDataSector;
		
		// These are level-based variables;
		private var _energyNeedsPerLevel:Number;
		private var _budgetPerLevel:Number;
		private var _oilLimitPerLevel:Number;
		private var _ghgLimitPerLevel:Number;
		
		public function EnergyDataItem(year:int) {
			_year = year;
			sectors = new Vector.<EnergyDataSector>();
		}
		
		public function get year():int { return _year; }
		
		public function get efficiencySector():EnergyDataSector { return _efficiencySector; }
		public function get electricitySector():EnergyDataSector { return _electricitySector; }
		public function get heatSector():EnergyDataSector { return _heatSector; }
		public function get vehicleFuelSector():EnergyDataSector { return _vehicleFuelSector; }

		public function get efficiency():Number {
			return efficiencySector.getTotalValue();
		}
		
		public function get efficiencyLimit():Number {
			return efficiencySector.getTotalLimit();
		}
		
		public function get electricity():Number {
			return electricitySector.getTotalValue();
		}

		public function get electricityLimit():Number {
			return electricitySector.getTotalLimit();
		} 

    public function get vehicleFuel():Number {
			return vehicleFuelSector.getTotalValue();
		}
		
    public function get vehicleFuelLimit():Number {
			return vehicleFuelSector.getTotalLimit();
		}
		
		public function get heat():Number {
			return heatSector.getTotalValue();
		}
		
		public function get heatLimit():Number {
			return heatSector.getTotalLimit();
		}
		
		public function get total():Number {
			return electricity + vehicleFuel + heat -
			       vehicleFuelSector.electricity.value;
		}
		
		public function get totalLimit():Number {
			return electricityLimit + vehicleFuelLimit + heatLimit + efficiencyLimit;
		}
		
		public function get ghgMtonnes():Number {
			return 53 * totalNaturalGas +
			       94 * (electricitySector.coal.value + heatSector.coal.value) +
						 64 * (totalOil + electricitySector.biofuels.value +
									 vehicleFuelSector.cropBiofuels.value +
									 vehicleFuelSector.cellulosic.value +
									 heatSector.biofuels.value);
		}
		
		public function get totalNaturalGas():Number {
			return electricitySector.naturalGas.value + 
			       vehicleFuelSector.naturalGas.value +
						 heatSector.naturalGas.value;
		}
		
		public function get totalCoal():Number {
			return electricitySector.coal.value +
			       electricitySector.cleanCoal.value +
						 heatSector.coal.value;
		}
		
		public function get totalOil():Number {
			return this.electricitySector.oil.value +
			       this.vehicleFuelSector.oil.value +
						 this.heatSector.oil.value;
		}
		
		public function get totalFossilFuels():Number {
			return totalNaturalGas + totalCoal + totalOil;
		}
		
		public function get heatMinimum():Number {
			return 25;
		}
		
		public function get vehicleFuelMinimum():Number {
			return 25;
		}
		
		public function get electricityRequired():Number {
			return 0.45 * energyNeeds + this.vehicleFuelSector.electricity.value;
		}
		
		public function get energyNeedsPerLevel():Number {
			return _energyNeedsPerLevel;
		}
		
		public function get energyNeeds():Number {
			return _energyNeedsPerLevel - efficiency;
		}
		
		public function get budgetLimit():Number {
			return _budgetPerLevel;
		}
		
		public function get oilLimit():Number {
			return _oilLimitPerLevel;
		}
		
		public function get ghgLimit():Number {
			return _ghgLimitPerLevel;
		}
		
		public function get electricityPrice():Number {
			return electricitySector.getSumproductPrice();
		}
		
		public function get vehicleFuelPrice():Number {
			return vehicleFuelSector.getSumproductPrice();
		}
		
		public function get heatPrice():Number {
			return heatSector.getSumproductPrice();
		}
		
		public function get efficiencyPrice():Number {
			return (0.5 * efficiency + 4.5) * efficiency;
		}
		
		public function get totalPrice():Number {
			return electricityPrice + vehicleFuelPrice + heatPrice + efficiencyPrice;
		}
		
		public function updateLevelBasedValues(level:String) {
			_oilLimitPerLevel = EnergyDifficultyData.getOilLimit(_year, level);
			if (!isNaN(_oilLimitPerLevel)) {
				this.vehicleFuelSector.oil.limit = _oilLimitPerLevel;
				this.heatSector.oil.limit = _oilLimitPerLevel;
			}
			_energyNeedsPerLevel = EnergyDifficultyData.getEnergyNeeds(_year, level);
			_budgetPerLevel = EnergyDifficultyData.getBudget(_year, level);
			_ghgLimitPerLevel = EnergyDifficultyData.getGhgLimit(_year, level);
		}
		
		public function save():XML {
			if (!hasNonZeroValueSources()) {
				return null;
			}
			var xml:XML = new XML(<year></year>);
			xml.@value = String(this.year);
			var xmlSectors:XML = null;
			var xmlSector:XML;
			for (var i:uint = 0; i < sectors.length; i++) {
				xmlSector = sectors[i].save();
				if (xmlSector) {
					if (!xmlSectors) {
						xmlSectors = new XML(<sectors></sectors>);
					}
					xmlSectors.appendChild(xmlSector);
				}
			}
			if (xmlSectors) {
				xml.appendChild(xmlSectors);
			}
			return xml;
		}
		
		public function loadXml(xml:XML):void {
			var xmlList:XMLList = xml..sector;
      var item:XML;
			var sec:EnergyDataSector;
			for each(item in xmlList) {
				sec = getDataSector(item.@value);
				if (sec) {
					sec.loadXml(item);
				}
			}
		}
		
    public function setupElectricityDataElements(coalV:Number, coalL:int, coalP:int,
																								 naturalGasV:Number, naturalGasL:int, naturalGasP:int,
																								 oldNuclearV:Number, oldNuclearL:int, oldNuclearP:int,
																								 hydroV:Number, hydroL:int, hydroP:int,
																								 windV:Number, windL:int, windP:int,
																								 oilV:Number, oilL:int, oilP:int,
																								 newNuclearV:Number, newNuclearL:int, newNuclearP:int,
																								 cleanCoalV:Number, cleanCoalL:int, cleanCoalP:int,
																								 solarV:Number, solarL:int, solarP:int,
																								 fusionV:Number, fusionL:int, fusionP:int,
																								 biofuelsV:Number, biofuelsL:int, biofuelsP:int,
																								 geothermalV:Number, geothermalL:int, geothermalP:int):void {
			this._electricitySector = new EnergyDataSector(EnergyConsts.ELECTRICITY_NAME);
			sectors.push(_electricitySector);
    	_electricitySector.addSource(new EnergyDataElement(EnergyConsts.COAL_KEY, EnergyConsts.COAL_NAME, coalV, coalL, coalP));
	    _electricitySector.addSource(new EnergyDataElement(EnergyConsts.NATURAL_GAS_KEY, EnergyConsts.NATURAL_GAS_NAME, naturalGasV, naturalGasL, naturalGasP));
  	  _electricitySector.addSource(new EnergyDataElement(EnergyConsts.OLD_NUCLEAR_KEY, EnergyConsts.OLD_NUCLEAR_NAME, oldNuclearV, oldNuclearL, oldNuclearP));
    	_electricitySector.addSource(new EnergyDataElement(EnergyConsts.HYDRO_KEY, EnergyConsts.HYDRO_NAME, hydroV, hydroL, hydroP));
	    _electricitySector.addSource(new EnergyDataElement(EnergyConsts.WIND_KEY, EnergyConsts.WIND_NAME, windV, windL, windP));
  	  _electricitySector.addSource(new EnergyDataElement(EnergyConsts.OIL_KEY, EnergyConsts.OIL_NAME, oilV, oilL, oilP));
    	_electricitySector.addSource(new EnergyDataElement(EnergyConsts.NEW_NUCLEAR_KEY, EnergyConsts.NEW_NUCLEAR_NAME, newNuclearV, newNuclearL, newNuclearP));
	    _electricitySector.addSource(new EnergyDataElement(EnergyConsts.CLEAN_COAL_KEY, EnergyConsts.CLEAN_COAL_NAME, cleanCoalV, cleanCoalL, cleanCoalP));
  	  _electricitySector.addSource(new EnergyDataElement(EnergyConsts.SOLAR_KEY, EnergyConsts.SOLAR_NAME, solarV, solarL, solarP));
    	_electricitySector.addSource(new EnergyDataElement(EnergyConsts.FUSION_KEY, EnergyConsts.FUSION_NAME, fusionV, fusionL, fusionP));
	    _electricitySector.addSource(new EnergyDataElement(EnergyConsts.BIOFUELS_KEY, EnergyConsts.BIOFUELS_NAME, biofuelsV, biofuelsL, biofuelsP));
  	  _electricitySector.addSource(new EnergyDataElement(EnergyConsts.GEOTHERMAL_KEY, EnergyConsts.GEOTHERMAL_NAME, geothermalV, geothermalL, geothermalP));
		}

    public function setupVehicleFuelDataElements(oilV:Number, oilL:int, oilP:int,
																								 cropBiofuelsV:Number, cropBiofuelsL:int, cropBiofuelsP:int,
																								 cellulosicV:Number, cellulosicL:int, cellulosicP:int,
																								 naturalGasV:Number, naturalGasL:int, naturalGasP:int,
																								 electricityV:Number, electricityL:int, electricityP:int):void {
	    this._vehicleFuelSector = new EnergyDataSector(EnergyConsts.VEHICLE_FUEL_NAME);
			sectors.push(_vehicleFuelSector);
			_vehicleFuelSector.addSource(new EnergyDataElement(EnergyConsts.OIL_KEY, EnergyConsts.OIL_NAME, oilV, oilL, oilP));
  	  _vehicleFuelSector.addSource(new EnergyDataElement(EnergyConsts.CROP_BIOFUELS_KEY, EnergyConsts.CROP_BIOFUELS_NAME, cropBiofuelsV, cropBiofuelsL, cropBiofuelsP));
    	_vehicleFuelSector.addSource(new EnergyDataElement(EnergyConsts.CELLULOSIC_KEY, EnergyConsts.CELLULOSIC_NAME, cellulosicV, cellulosicL, cellulosicP));
	    _vehicleFuelSector.addSource(new EnergyDataElement(EnergyConsts.NATURAL_GAS_KEY, EnergyConsts.NATURAL_GAS_NAME, naturalGasV, naturalGasL, naturalGasP));
  	  _vehicleFuelSector.addSource(new EnergyDataElement(EnergyConsts.ELECTRICITY_KEY, EnergyConsts.ELECTRICITY_NAME, electricityV, electricityL, electricityP));
		}

    public function setupHeatDataElements(naturalGasV:Number, naturalGasL:int, naturalGasP:int,
																					coalV:Number, coalL:int, coalP:int,
																					oilV:Number, oilL:int, oilP:int,
																					biofuelsV:Number, biofuelsL:int, biofuelsP:int,
																					solarV:Number, solarL:int, solarP:int,
																					geothermalV:Number, geothermalL:int, geothermalP:int):void {
			this._heatSector = new EnergyDataSector(EnergyConsts.HEAT_NAME);
			sectors.push(_heatSector);
			_heatSector.addSource(new EnergyDataElement(EnergyConsts.NATURAL_GAS_KEY, EnergyConsts.NATURAL_GAS_NAME, naturalGasV, naturalGasL, naturalGasP));
			_heatSector.addSource(new EnergyDataElement(EnergyConsts.COAL_KEY, EnergyConsts.COAL_NAME, coalV, coalL, coalP));
			_heatSector.addSource(new EnergyDataElement(EnergyConsts.OIL_KEY, EnergyConsts.OIL_NAME, oilV, oilL, oilP));
			_heatSector.addSource(new EnergyDataElement(EnergyConsts.BIOFUELS_KEY, EnergyConsts.BIOFUELS_NAME, biofuelsV, biofuelsL, biofuelsP));
			_heatSector.addSource(new EnergyDataElement(EnergyConsts.SOLAR_KEY, EnergyConsts.SOLAR_NAME, solarV, solarL, solarP));
			_heatSector.addSource(new EnergyDataElement(EnergyConsts.GEOTHERMAL_KEY, EnergyConsts.GEOTHERMAL_NAME, geothermalV, geothermalL, geothermalP));
		}

    public function setupEfficiencyDataElements(value:Number, limit:int, price:int):void {
			this._efficiencySector = new EnergyDataSector(EnergyConsts.EFFICIENCY_INVESTMENT_NAME);
			sectors.push(_efficiencySector);
			_efficiencySector.addSource(new EnergyDataElement(EnergyConsts.EFFICIENCY_KEY, EnergyConsts.EFFICIENCY_NAME, value, limit, price));
		}
		
		private function hasNonZeroValueSources():Boolean {
			for (var i:uint = 0; i < sectors.length; i++) {
				if (sectors[i].getNonZeroValueSources().length > 0) {
					return true;
				}
			}
			return false;
		}
		
		private function getDataSector(sectorName:String):EnergyDataSector {
			for (var i:uint = 0; i < sectors.length; i++) {
				if (sectors[i].name == sectorName) {
					return sectors[i];
				}
			}
			return null;
		}
  }
	
}
