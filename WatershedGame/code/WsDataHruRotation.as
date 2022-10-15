package code {

	public class WsDataHruRotation {

		private var _yearone:int;
		private var _yeartwo:int;
		private var _hru:WsDataHru;

		// yearone and yeartwo only take the following values:
		//   WsConsts.CORN, WsConsts.SOY, WsConsts.FOREST, WsConsts.HAY
    public function WsDataHruRotation(yearone:int, yeartwo:int, hru:WsDataHru) {
			this._yearone = yearone;
			this._yeartwo = yeartwo;
			this._hru = hru;
    }

		public function get yearone():int {
			return this._yearone;
		}
		
		public function get yeartwo():int {
			return this._yeartwo;
		}
		
		public function get hru():WsDataHru {
			return this._hru;
		}
		
  }
}
