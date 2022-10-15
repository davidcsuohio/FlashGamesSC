package code {
	
	public class EnergyDifficultyData {

    private static var difficultyData:Vector.<EnergyDifficultyDataItem> = new Vector.<EnergyDifficultyDataItem>();

		public static function getEnergyNeeds(year:int, level:String):Number {
			var eddi:EnergyDifficultyDataItem = getDifficultyItem(year);
			if (eddi) {
  			return eddi.energyNeeds.getValue(level);
			}
			return NaN;
		}
		
		public static function getBudget(year:int, level:String):Number {
			var eddi:EnergyDifficultyDataItem = getDifficultyItem(year);
			if (eddi) {
  			return eddi.budget.getValue(level);
			}
			return NaN;
		}
		
		public static function getOilLimit(year:int, level:String):Number {
			var eddi:EnergyDifficultyDataItem = getDifficultyItem(year);
			if (eddi) {
  			return eddi.oilLimit.getValue(level);
			}
			return NaN;
		}
		
		public static function getGhgLimit(year:int, level:String):Number {
			var eddi:EnergyDifficultyDataItem = getDifficultyItem(year);
			if (eddi) {
  			return eddi.ghgLimit.getValue(level);
			}
			return NaN;
		}
		
		private static function getDifficultyItem(year:int):EnergyDifficultyDataItem {
			setupDifficultyData();
			var len:uint = difficultyData.length;
			for (var i:uint = 0; i < len; i++) {
				if (difficultyData[i].year == year) {
					return difficultyData[i];
				}
			}
			return null;
		}

		private static function setupDifficultyData():void {
			if (difficultyData.length > 0) {
				return;
			}
			difficultyData.push(new EnergyDifficultyDataItem(
														  2020,
															new EnergyLevelDataItem(100, 100, 106, 110, 110),
															new EnergyLevelDataItem(2200, 2000, 1800, 1700, 1650),
															new EnergyLevelDataItem(42, 36, 30, 24, 20),
															new EnergyLevelDataItem(6300, 5800, 5500, 5300, 5000)));
			difficultyData.push(new EnergyDifficultyDataItem(
														  2030,
															new EnergyLevelDataItem(100, 100, 112, 120, 120),
															new EnergyLevelDataItem(2600, 2400, 2200, 2050, 2000),
															new EnergyLevelDataItem(32, 20, 15, 10, 8),
															new EnergyLevelDataItem(5800, 5200, 4800, 4300, 4000)));
			difficultyData.push(new EnergyDifficultyDataItem(
														  2040,
															new EnergyLevelDataItem(100, 100, 118, 130, 130),
															new EnergyLevelDataItem(2800, 2600, 2500, 2400, 2300),
															new EnergyLevelDataItem(20, 12, 10, 6, 4),
															new EnergyLevelDataItem(4800, 4000, 3600, 3000, 2600)));
			difficultyData.push(new EnergyDifficultyDataItem(
														  2050,
															new EnergyLevelDataItem(100, 100, 124, 140, 140),
															new EnergyLevelDataItem(3200, 3000, 2700, 2600, 2500),
															new EnergyLevelDataItem(12, 8, 6, 2, 1),
															new EnergyLevelDataItem(3500, 3000, 2500, 1800, 1200)));
		}

	}
	
}
