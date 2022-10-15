package code {
	
	public class EnergyDataElement {

  	// value will change based on user operation;
	  // limit will change based on level selection (only oil in Vehicle fuel and Heating);
  	// price will not change (not used by Efficiency = 0);
    private var _value:Number;
    private var _limit:Number;
    private var _price:Number;
		private var _name:String;
		private var _key:int;

		public function EnergyDataElement(key:int, name:String, value:Number, limit:int, price:int) {
			_value = value;
		  _limit = limit;
			_price = price;
			_name = name;
			_key = key;
		}

		public function get value():Number {
			return _value;
		}
		public function set value(value:Number):void {
			_value = value;
		}

		public function get limit():Number {
			return _limit;
		}
		public function set limit(limit:Number):void {
			_limit = limit;
			this.value = Math.min(limit, this.value);
		}

		public function get price():Number {
			if (key == EnergyConsts.EFFICIENCY_KEY) {
				return 5 + value * 1;
			}
			else {
				return _price;
			}
		}

		public function get name():String {
			return _name;
		}
		
		public function get key():int {
			return _key;
		}
		
		public function updatePrice():Boolean {
			if (key == EnergyConsts.EFFICIENCY_KEY)
			  return true;
			return false;
		}
		
		public function save():XML {
			var pattern:RegExp = / /g;
			var tag:String = _name.replace(pattern, "_");
			return new XML(<{tag}>{value}</{tag}>);
		}
		
		// see the comments in EnergyDataSector.loadXml();
		// do nothing if the name does not match;
		public function loadXml(xml:XML):void {
			var xmlName:String = xml.name().localName;
			var pattern:RegExp = /_/g;
			if (xmlName.replace(pattern, " ") == _name) {
				this.value = int(xml.valueOf());
			}
		}
	}
	
}
