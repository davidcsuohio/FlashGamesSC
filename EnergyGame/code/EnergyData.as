package code {
	
	public class EnergyData {

    private var energyData:Vector.<EnergyDataItem>;
		private var energyDataReadOnly:Vector.<EnergyDataItem>;
		private var _level:String = null;
		private var _year:int = -1;
		private var _curSector:String = null;
		private var _current:EnergyDataItem = null;
		private var _isReadOnlyData:Boolean = false;
		
		private var _budgetLimitChBSelected:Boolean;
		private var _oilLimitChBSelected:Boolean;
		private var _ghgLimitChBSelected:Boolean;
		private var _electricityMinChBSelected:Boolean;
		private var _energyMinChBSelected:Boolean;
		private var _heatMinChBSelected:Boolean;
		private var _fuelMinChBSelected:Boolean;
		
		public function EnergyData() {
			setupEnergyData();
			level = EnergyConsts.VERY_EASY_NAME;
			year = 2020;
			curSector = EnergyConsts.VEHICLE_FUEL_NAME;
			_isReadOnlyData = false;
			
			budgetLimitChBSelected = true;
			oilLimitChBSelected = true;
			ghgLimitChBSelected = true;
			electricityMinChBSelected = true;
			energyMinChBSelected = true;
			heatMinChBSelected = true;
			fuelMinChBSelected = true;
		}
		
		public function get level():String {
			return _level;
		}
		public function set level(value:String):void {
			if (_level == value) { return; }
			_level = value;
			if (currentDataItem) {
				currentDataItem.updateLevelBasedValues(_level);
			}
		}

		public function get year():int {
			return _year;
		}
		public function set year(value:int):void {
			if (_year == value) { return; }
			_year = value;
			_current = getDataItem(_year);
			if (level && _current) {
				_current.updateLevelBasedValues(level);
			}
		}

		public function get currentDataItem():EnergyDataItem {
			return _current;
		}
		
		public function get isReadOnlyData():Boolean {
			return _isReadOnlyData;
		}
		
		public function get curSector():String {
			return _curSector;
		}
		public function set curSector(value:String):void {
			if (_curSector == value) { return; }
			_curSector = value;
		}
		
		public function get budgetLimitChBSelected():Boolean {
			return _budgetLimitChBSelected;
		}
		public function set budgetLimitChBSelected(value:Boolean):void {
			_budgetLimitChBSelected = value;
		}
		
		public function get oilLimitChBSelected():Boolean {
			return _oilLimitChBSelected;
		}
		public function set oilLimitChBSelected(value:Boolean):void {
			_oilLimitChBSelected = value;
		}
		
		public function get ghgLimitChBSelected():Boolean {
			return _ghgLimitChBSelected;
		}
		public function set ghgLimitChBSelected(value:Boolean):void {
			_ghgLimitChBSelected = value;
		}
		
		public function get electricityMinChBSelected():Boolean {
			return _electricityMinChBSelected;
		}
		public function set electricityMinChBSelected(value:Boolean):void {
			_electricityMinChBSelected = value;
		}

		public function get energyMinChBSelected():Boolean {
			return _energyMinChBSelected;
		}
		public function set energyMinChBSelected(value:Boolean):void {
			_energyMinChBSelected = value;
		}

		public function get heatMinChBSelected():Boolean {
			return _heatMinChBSelected;
		}
		public function set heatMinChBSelected(value:Boolean):void {
			_heatMinChBSelected = value;
		}
		
		public function get fuelMinChBSelected():Boolean {
			return _fuelMinChBSelected;
		}
		public function set fuelMinChBSelected(value:Boolean):void {
			_fuelMinChBSelected = value;
		}
		
		// assume the max number is the difficulty of EnergyConsts.VERY_EASY_NAME among all difficulties 
		public function getMaxBudgetLimitInAllYears():Number {
			var ret:Number = 0;
			var val:Number = 0;
			for (var i:uint = 0; i < energyData.length; i++) {
				val = EnergyDifficultyData.getBudget(energyData[i].year, EnergyConsts.VERY_EASY_NAME);
				if (ret < val) {
					ret = val;
				}
			}
			return ret;
		}

		// assume the max number is the difficulty of EnergyConsts.VERY_EASY_NAME among all difficulties 
		public function getMaxOilLimitInAllYears():Number {
			var ret:Number = 0;
			var val:Number = 0;
			for (var i:uint = 0; i < energyData.length; i++) {
				val = EnergyDifficultyData.getOilLimit(energyData[i].year, EnergyConsts.VERY_EASY_NAME);
				if (ret < val) {
					ret = val;
				}
			}
			return ret;
		}

		// assume the max number is the difficulty of EnergyConsts.VERY_EASY_NAME among all difficulties 
		public function getMaxGhgLimitInAllYears():Number {
			var ret:Number = 0;
			var val:Number = 0;
			for (var i:uint = 0; i < energyData.length; i++) {
				val = EnergyDifficultyData.getGhgLimit(energyData[i].year, EnergyConsts.VERY_EASY_NAME);
				if (ret < val) {
					ret = val;
				}
			}
			return ret;
		}

		// assume the max number is the difficulty of EnergyConsts.VERY_HARD_NAME among all difficulties 
		public function getMaxEnergyNeedsInAllYears():Number {
			var ret:Number = 0;
			var val:Number = 0;
			for (var i:uint = 0; i < energyData.length; i++) {
				val = EnergyDifficultyData.getEnergyNeeds(energyData[i].year, EnergyConsts.VERY_HARD_NAME);
				if (ret < val) {
					ret = val;
				}
			}
			return ret;
		}

		public function getMaxEfficiencyLimitInAllYears():Number {
			var ret:Number = 0;
			var val:Number = 0;
			for (var i:uint = 0; i < energyData.length; i++) {
				val = energyData[i].efficiencySector.getMaxSourceLimit();
				if (ret < val) {
					ret = val;
				}
			}
			return ret;
		}
		
		public function loadXml(xml:XML):void {
			level = xml.curLevel;
			year = xml.curYear;
			curSector = xml.curSector;
			this.budgetLimitChBSelected = (xml.budgetSel.toString() == "true");
			this.oilLimitChBSelected = (xml.oilSel.toString() == "true");
			this.ghgLimitChBSelected = (xml.ghgSel.toString() == "true");
			this.electricityMinChBSelected = (xml.elecSel.toString() == "true");
			this.energyMinChBSelected = (xml.energySel.toString() == "true");
			this.heatMinChBSelected = (xml.heatSel.toString() == "true");
			this.fuelMinChBSelected = (xml.fuelSel.toString() == "true");
			var xmlList:XMLList = xml..year;
      var item:XML;
			var dItem:EnergyDataItem;
			for each(item in xmlList) {
				dItem = getDataItem(int(item.@value));
				if (dItem) {
					dItem.loadXml(item);
				}
			}
		}
		
		public function save():XML {
			var pattern:RegExp = /:/g;
			var now:String = (new Date()).toLocaleString().replace(pattern, " ");
			var xml:XML = new XML(<energyGame></energyGame>);
			xml.@saveTime = now;
			xml.curLevel = this.level;
			xml.curYear = String(this.year);
			xml.curSector = this.curSector;
			xml.budgetSel = this.budgetLimitChBSelected;
			xml.oilSel = this.oilLimitChBSelected;
			xml.ghgSel = this.ghgLimitChBSelected;
			xml.elecSel = this.electricityMinChBSelected;
			xml.energySel = this.energyMinChBSelected;
			xml.heatSel = this.heatMinChBSelected;
			xml.fuelSel = this.fuelMinChBSelected;
			var xmlYears:XML = null;
			var xmlYear:XML;
			for (var i:uint = 0; i < energyData.length; i++) {
				xmlYear = energyData[i].save();
				if (xmlYear) {
					if (!xmlYears) {
						xmlYears = new XML(<years></years>);
					}
					xmlYears.appendChild(xmlYear);
				}
			}
			if (xmlYears) {
				xml.appendChild(xmlYears);
			}
			return xml;
		}
		
		public function winGame():Boolean {
			if (this.currentDataItem.total >= this.currentDataItem.energyNeeds &&
					this.currentDataItem.heat >= this.currentDataItem.heatMinimum &&
					this.currentDataItem.vehicleFuel >= this.currentDataItem.vehicleFuelMinimum &&
					this.currentDataItem.electricity >= this.currentDataItem.electricityRequired &&
					this.currentDataItem.totalPrice <= this.currentDataItem.budgetLimit &&
					this.currentDataItem.totalOil <= this.currentDataItem.oilLimit &&
					this.currentDataItem.ghgMtonnes <= this.currentDataItem.ghgLimit)
				return true;
			else
				return false;
		}

    private function getDataItem(year:int):EnergyDataItem {
			for (var i:uint = 0; i < energyData.length; i++) {
				if (energyData[i].year == year) {
					_isReadOnlyData = false;
					return energyData[i];
				}
			}
			for (i = 0; i < energyDataReadOnly.length; i++) {
				if (energyDataReadOnly[i].year == year) {
					_isReadOnlyData = true;
					return energyDataReadOnly[i];
				}
			}
			return null;
		}
		
    private function setupEnergyData():void {
			energyDataReadOnly = new Vector.<EnergyDataItem>();
			var item:EnergyDataItem = new EnergyDataItem(1990);
			item.setupElectricityDataElements(21, 21, 0,
																				4,  4,  0,
																				8,  8,  0,
																				3,  3,  0,
																				0,  0,  0,
																				1,  1,  0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0);
			item.setupVehicleFuelDataElements(25, 25, 0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0);
			item.setupHeatDataElements(12, 12, 0,
																 2,  2,  0,
																 12, 12, 0,
																 1,  1,  0,
																 0, 0,   0,
																 0, 0,   0);
			item.setupEfficiencyDataElements(0, 0, 0);
			energyDataReadOnly.push(item);
			
			item = new EnergyDataItem(2000);
			item.setupElectricityDataElements(21, 21, 0,
																				6,  6,  0,
																				8,  8,  0,
																				3,  3,  0,
																				0,  0,  0,
																				1,  1,  0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0,
																				1,  1,  0,
																				0,  0,  0);
			item.setupVehicleFuelDataElements(27, 27, 0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0);
			item.setupHeatDataElements(14, 14, 0,
																 2,  2,  0,
																 12, 12, 0,
																 2,  2,  0,
																 0,  0,  0,
																 0,  0,  0);
			item.setupEfficiencyDataElements(0, 0, 0);
			energyDataReadOnly.push(item);
			
			// use 2005 data for now;
			item = new EnergyDataItem(2010);
			item.setupElectricityDataElements(21, 21, 0,
																				7,  10, 0,
																				8,  8,  0,
																				3,  3,  0,
																				0,  0,  0,
																				1,  1,  0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0,
																				1,  1,  0,
																				0,  0,  0);
			item.setupVehicleFuelDataElements(28, 28, 0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0,
																				0,  0,  0);
			item.setupHeatDataElements(15, 15, 0,
																 2,  2,  0,
																 12, 12, 0,
																 2,  2,  0,
																 0,  0,  0,
																 0,  0,  0);
			item.setupEfficiencyDataElements(0, 0, 0);
			energyDataReadOnly.push(item);
		
			energyData = new Vector.<EnergyDataItem>();
			item = new EnergyDataItem(2020);
			item.setupElectricityDataElements(0, 19, 10,
																				0, 14, 14,
																				0, 6,  10,
																				0, 3,  8,
																				0, 4,  15,
																				0, 1,  20,
																				0, 4,  20,
																				0, 2,  23,
																				0, 2,  30,
																				0, 0,  0,
																				0, 1,  18,
																				0, 2,  20);
			item.setupVehicleFuelDataElements(0, -1, 25,
																				0, 1,  24,
																				0, 1,  60,
																				0, 4,  25,
																				0, 4,  40);
			item.setupHeatDataElements(0, 30, 10,
																 0, 2,  8,
																 0, -1, 17,
																 0, 1,  12,
																 0, 2,  30,
																 0, 2,  20);
			item.setupEfficiencyDataElements(0, 30, 0);
			energyData.push(item);
		
			item = new EnergyDataItem(2030);
			item.setupElectricityDataElements(0, 17, 10,
																				0, 18, 14,
																				0, 4,  10,
																				0, 3,  8,
																				0, 8,  15,
																				0, 1,  28,
																				0, 12, 18,
																				0, 8,  21,
																				0, 8,  20,
																				0, 0,  0,
																				0, 1,  16,
																				0, 3,  20);
			item.setupVehicleFuelDataElements(0, -1, 35,
																				0, 1,  28,
																				0, 3,  35,
																				0, 12, 20,
																				0, 12, 30);
			item.setupHeatDataElements(0, 30, 10,
																 0, 2,  8,
																 0, -1, 23,
																 0, 1,  12,
																 0, 4,  15,
																 0, 6,  14);
			item.setupEfficiencyDataElements(0, 30, 0);
			energyData.push(item);
		
			item = new EnergyDataItem(2040);
			item.setupElectricityDataElements(0, 15, 10,
																				0, 22, 16,
																				0, 2,  10,
																				0, 3,  8,
																				0, 12, 15,
																				0, 1,  36,
																				0, 20, 16,
																				0, 16, 19,
																				0, 16, 18,
																				0, 0,  0,
																				0, 1,  15,
																				0, 3,  20);
			item.setupVehicleFuelDataElements(0, -1, 45,
																				0, 1,  32,
																				0, 5,  28,
																				0, 20, 25,
																				0, 20, 20);
			item.setupHeatDataElements(0, 30, 12,
																 0, 2,  8,
																 0, -1, 30,
																 0, 1,  12,
																 0, 6,  10,
																 0, 10, 12);
			item.setupEfficiencyDataElements(0, 30, 0);
			energyData.push(item);
		
			item = new EnergyDataItem(2050);
			item.setupElectricityDataElements(0, 13, 10,
																				0, 18, 18,
																				0, 0,  10,
																				0, 3,  8,
																				0, 20, 15,
																				0, 1,  44,
																				0, 28, 16,
																				0, 24, 17,
																				0, 24, 16,
																				0, 4,  10,
																				0, 1,  15,
																				0, 4,  20);
			item.setupVehicleFuelDataElements(0, -1, 55,
																				0, 1,  36,
																				0, 7,  24,
																				0, 28, 35,
																				0, 28, 20);
			item.setupHeatDataElements(0, 30, 17,
																 0, 2,  8,
																 0, -1, 37,
																 0, 1,  12,
																 0, 12, 10,
																 0, 14, 10);
			item.setupEfficiencyDataElements(0, 30, 0);
			energyData.push(item);
		}
	}
	
}
