package code {

	public class WsDataDot {

		private var _initial:String;
		private var _serialNumber:int;
		private var _scores:Number;
		private var _dollars:Number;

    public function WsDataDot(serialNo:int, scores:Number, dollars:Number, initial:String="") {
			this._serialNumber = serialNo;
			this._scores = scores;
			this._dollars = dollars;
			this._initial = initial;
    }

		public function get scores():Number {
			return this._scores;
		}
		
		public function get dollars():Number {
			return this._dollars;
		}
		
		public function initial():String {
			return this._initial.length > 0 ? this._initial : String(this._serialNumber);
		}
		
  }
}
