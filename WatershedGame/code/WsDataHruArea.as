package code {

	public class WsDataHruArea {

		private var _area:Number;
		private var _useNumber:int;
		private var _rotations:Vector.<WsDataHruRotation>;

		// useNumber equals to HRU in the data file
		// area (sq.km)
    public function WsDataHruArea(area:Number, useNumber:int) {
			this._area = area;
			this._useNumber = useNumber;
			this._rotations = new Vector.<WsDataHruRotation>();
    }

		public function get useNumber():int {
			return this._useNumber;
		}
		
		public function get area():Number {
			return this._area;
		}
		
		public function addHruRotation(hruRotation:WsDataHruRotation):void {
			this._rotations.push(hruRotation);
		}
		
		public function getHruRotation(yearone:int, yeartwo:int):WsDataHruRotation {
			var hruRotation:WsDataHruRotation = null;
			for (var i:uint = 0; i < this._rotations.length; i++) {
				hruRotation = this._rotations[i];
				if (hruRotation.yearone == yearone && hruRotation.yeartwo == yeartwo)
					return hruRotation;
			}
			return null;
		}
		
		public function minSyld():Number {
			var ret:Number = this._rotations[0].hru.syld;
			for (var i:uint = 1; i < this._rotations.length; i++) {
				if (ret > this._rotations[i].hru.syld)
					ret = this._rotations[i].hru.syld;
			}
			return ret;
		}
		
		public function maxSyld():Number {
			var ret:Number = this._rotations[0].hru.syld;
			for (var i:uint = 1; i < this._rotations.length; i++) {
				if (ret < this._rotations[i].hru.syld)
					ret = this._rotations[i].hru.syld;
			}
			return ret;
		}
		
		public function minSumOfPyldNyld():Number {
			var ret:Number = this._rotations[0].hru.pyld + this._rotations[0].hru.nyld;
			for (var i:uint = 1; i < this._rotations.length; i++) {
				if (ret > this._rotations[i].hru.pyld + this._rotations[i].hru.nyld)
					ret = this._rotations[i].hru.pyld + this._rotations[i].hru.nyld;
			}
			return ret;
		}
		
		public function maxSumOfPyldNyld():Number {
			var ret:Number = this._rotations[0].hru.pyld + this._rotations[0].hru.nyld;
			for (var i:uint = 1; i < this._rotations.length; i++) {
				if (ret < this._rotations[i].hru.pyld + this._rotations[i].hru.nyld)
					ret = this._rotations[i].hru.pyld + this._rotations[i].hru.nyld;
			}
			return ret;
		}
		
		public function minPflw():Number {
			var ret:Number = this._rotations[0].hru.pflw;
			for (var i:uint = 1; i < this._rotations.length; i++) {
				if (ret > this._rotations[i].hru.pflw)
					ret = this._rotations[i].hru.pflw;
			}
			return ret;
		}
		
		public function maxPflw():Number {
			var ret:Number = this._rotations[0].hru.pflw;
			for (var i:uint = 1; i < this._rotations.length; i++) {
				if (ret < this._rotations[i].hru.pflw)
					ret = this._rotations[i].hru.pflw;
			}
			return ret;
		}
		
		public function minCrbn():Number {
			var ret:Number = this._rotations[0].hru.crbn;
			for (var i:uint = 1; i < this._rotations.length; i++) {
				if (ret > this._rotations[i].hru.crbn)
					ret = this._rotations[i].hru.crbn;
			}
			return ret;
		}
		
		public function maxCrbn():Number {
			var ret:Number = this._rotations[0].hru.crbn;
			for (var i:uint = 1; i < this._rotations.length; i++) {
				if (ret < this._rotations[i].hru.crbn)
					ret = this._rotations[i].hru.crbn;
			}
			return ret;
		}
  }
}
