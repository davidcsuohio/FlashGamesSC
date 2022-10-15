package code {
	
	public class EnergyLevelDataItem {

    private var _veryEasy:Number = -1;
    private var _easy:Number = -1;
    private var _medium:Number = -1;
    private var _hard:Number = -1;
    private var _veryHard:Number = -1;

		public function EnergyLevelDataItem(veryEasy:Number,
																				easy:Number,
																				medium:Number,
																				hard:Number,
																				veryHard:Number) {
			_veryEasy = veryEasy;
			_easy = easy;
			_medium = medium;
			_hard = hard;
			_veryHard = veryHard;
		}

		public function getValue(level:String):Number {
			switch (level.toUpperCase()) {
				case EnergyConsts.VERY_EASY_NAME:
				  return _veryEasy;
				case EnergyConsts.EASY_NAME:
				  return _easy;
				case EnergyConsts.MEDIUM_NAME:
				  return _medium;
				case EnergyConsts.HARD_NAME:
				  return _hard;
				case EnergyConsts.VERY_HARD_NAME:
				  return _veryHard;
				default:
				  return -1;
			}
		}

	}
}
