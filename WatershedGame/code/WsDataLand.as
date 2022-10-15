package code {

  public class WsDataLand {

		private var _color:uint;
		private var _useNumber:int;
		private var _coordsIndex:int;
		private var _hrus:Vector.<WsDataHru>;

    public function WsDataLand(useNumber:int, coordsIndex:int) {
			this._useNumber = useNumber;
			this._coordsIndex = coordsIndex;
			this.resetLanduse();
			this._hrus = new Vector.<WsDataHru>();
    }

		public function get useNumber():int {
			return this._useNumber;
		}
		
		public function get coordsIndex():int {
			return this._coordsIndex;
		}
		
		public function get color():uint {
			return this._color;
		}
		public function set color(color:uint):void {
			this._color = color;
		}
		
		public function unassigned():Boolean {
			return (this.color == WsConsts.LANDUSE_UNUSE_COLOR);
		}
		
		public function resetLanduse():void {
			this.color = WsConsts.LANDUSE_UNUSE_COLOR;
		}
		
		public function addHru(hru:WsDataHru):void {
			this._hrus.push(hru);
		}
		
		public function maxSyld():Number {
			var ret:Number = Number.MIN_VALUE;
			for (var i:uint = 0; i < _hrus.length; i++) {
				if (ret < _hrus[i].syld) {
					ret = _hrus[i].syld;
				}
			}
			return ret;
		}
		
		public function maxPyld():Number {
			var ret:Number = Number.MIN_VALUE;
			for (var i:uint = 0; i < _hrus.length; i++) {
				if (ret < _hrus[i].pyld) {
					ret = _hrus[i].pyld;
				}
			}
			return ret;
		}
		
		public function maxNyld():Number {
			var ret:Number = Number.MIN_VALUE;
			for (var i:uint = 0; i < _hrus.length; i++) {
				if (ret < _hrus[i].nyld) {
					ret = _hrus[i].nyld;
				}
			}
			return ret;
		}
		
		public function maxPflw():Number {
			var ret:Number = Number.MIN_VALUE;
			for (var i:uint = 0; i < _hrus.length; i++) {
				if (ret < _hrus[i].pflw) {
					ret = _hrus[i].pflw;
				}
			}
			return ret;
		}
		
		public function maxCrbn():Number {
			var ret:Number = Number.MIN_VALUE;
			for (var i:uint = 0; i < _hrus.length; i++) {
				if (ret < _hrus[i].crbn) {
					ret = _hrus[i].crbn;
				}
			}
			return ret;
		}
  }
}
