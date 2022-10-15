package code {
	
	public class EnergyDifficultyDataItem {

    private var _year:int;
    private var _energyNeeds:EnergyLevelDataItem;
    private var _budget:EnergyLevelDataItem;
    private var _oilLimit:EnergyLevelDataItem;
    private var _ghgLimit:EnergyLevelDataItem;

		public function EnergyDifficultyDataItem(year:int,
																						 energyNeeds:EnergyLevelDataItem,
																						 budget:EnergyLevelDataItem,
																						 oilLimit:EnergyLevelDataItem,
																						 ghgLimit:EnergyLevelDataItem) {
			_year = year;
		  _energyNeeds = energyNeeds;
			_budget = budget;
			_oilLimit = oilLimit;
			_ghgLimit = ghgLimit;
		}

		public function get year():int {
			return _year;
		}

		public function get energyNeeds():EnergyLevelDataItem {
			return _energyNeeds;
		}

		public function get budget():EnergyLevelDataItem {
			return _budget;
		}

		public function get oilLimit():EnergyLevelDataItem {
			return _oilLimit;
		}

		public function get ghgLimit():EnergyLevelDataItem {
			return _ghgLimit;
		}

	}
	
}
