package code {

  public class EnergyDataSector {

    // there should not be any performance issue due to the small data size;
		// otherwise consider Dictionary;
    private var sources:Vector.<EnergyDataElement>;
		private var _name:String;
		
    public function EnergyDataSector(name:String) {
			_name = name;
			sources = new Vector.<EnergyDataElement>();
    }
		
		public function get name():String { return _name; }
		
		public function get coal():EnergyDataElement { return this.getSource(EnergyConsts.COAL_KEY); }
		public function get naturalGas():EnergyDataElement { return this.getSource(EnergyConsts.NATURAL_GAS_KEY); }
		public function get oldNuclear():EnergyDataElement { return this.getSource(EnergyConsts.OLD_NUCLEAR_KEY); }
		public function get hydro():EnergyDataElement { return this.getSource(EnergyConsts.HYDRO_KEY); }
		public function get wind():EnergyDataElement { return this.getSource(EnergyConsts.WIND_KEY); }
		public function get oil():EnergyDataElement { return this.getSource(EnergyConsts.OIL_KEY); }
		public function get newNuclear():EnergyDataElement { return this.getSource(EnergyConsts.NEW_NUCLEAR_KEY); }
		public function get cleanCoal():EnergyDataElement { return this.getSource(EnergyConsts.CLEAN_COAL_KEY); }
		public function get solar():EnergyDataElement { return this.getSource(EnergyConsts.SOLAR_KEY); }
		public function get fusion():EnergyDataElement { return this.getSource(EnergyConsts.FUSION_KEY); }
		public function get biofuels():EnergyDataElement { return this.getSource(EnergyConsts.BIOFUELS_KEY); }
		public function get geothermal():EnergyDataElement { return this.getSource(EnergyConsts.GEOTHERMAL_KEY); }
		public function get cropBiofuels():EnergyDataElement { return this.getSource(EnergyConsts.CROP_BIOFUELS_KEY); }
		public function get cellulosic():EnergyDataElement { return this.getSource(EnergyConsts.CELLULOSIC_KEY); }
		public function get electricity():EnergyDataElement { return this.getSource(EnergyConsts.ELECTRICITY_KEY); }
		public function get efficiency():EnergyDataElement { return this.getSource(EnergyConsts.EFFICIENCY_KEY); }

		public function addSource(source:EnergyDataElement):void {
			sources.push(source);
		}
		
		public function getTotalValue():Number {
			var total:Number = 0;
			for (var i:uint = 0; i < sources.length; i++) {
				total += sources[i].value;
			}
			return total;
		}
		
		public function getTotalLimit():Number {
			var total:Number = 0;
			for (var i:uint = 0; i < sources.length; i++) {
				total += sources[i].limit;
			}
			return total;
		}
		
		public function getSumproductPrice():Number {
			var total:Number = 0;
			for (var i:uint = 0; i < sources.length; i++) {
				total += sources[i].value * sources[i].price;
			}
			return total;
		}
		
		public function getMaxSourceLimit():Number {
			var max:Number = 0;
			for (var i:uint = 0; i < sources.length; i++) {
				if (sources[i].limit > max) {
					max = sources[i].limit;
				}
			}
			return max;
		}
		
		public function getNonZeroValueSources():Vector.<EnergyDataElement> {
			var ret:Vector.<EnergyDataElement> = new Vector.<EnergyDataElement>();
			for (var i:uint = 0; i < sources.length; i++) {
				if (sources[i].value > 0) {
					ret.push(sources[i]);
				}
			}
			return ret;
		}
		
		public function getNonZeroLimitSources():Vector.<EnergyDataElement> {
			var ret:Vector.<EnergyDataElement> = new Vector.<EnergyDataElement>();
			for (var i:uint = 0; i < sources.length; i++) {
				if (sources[i].limit > 0) {
					ret.push(sources[i]);
				}
			}
			return ret;
		}
		
		public function save():XML {
			var ret:Vector.<EnergyDataElement> = getNonZeroValueSources();
			if (ret.length == 0) {
				return null;
			}
			var xml:XML = new XML(<sector></sector>);
			xml.@value = this.name;
			for (var i:uint = 0; i < ret.length; i++) {
				xml.appendChild(ret[i].save());
			}
			return xml;
		}

    // Since the source name (EnergyDataElement name) has been changed during the save process - 
		// the space being replaced with the underscore - we need to restore the name while loading;
		// we delegate the restoring process to the class EnergyDataElement;
		// The normal way is first to find the source and then set the value.
		// Here we skip the finding process due to the small data size.
		public function loadXml(xml:XML):void {
			var xmlList:XMLList = xml.child("*");
      var item:XML;
			var element:EnergyDataElement;
			for each(item in xmlList) {
				for (var i:uint = 0; i < sources.length; i++) {
					sources[i].loadXml(item);
				}
			}
		}
		
		private function getSource(key:int):EnergyDataElement {
			for (var i:uint = 0; i < sources.length; i++) {
				if (sources[i].key == key) {
					return sources[i];
				}
			}
			return null;
		}
  }
}