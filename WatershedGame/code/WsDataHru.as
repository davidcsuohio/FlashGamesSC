package code {

	/*
	SYLD: sediment yield (metrictons/ha/yr)
	PYLD: Phosphorus yield (kg/ha/yr)
	NYLD: Nitrogen yield (kg/ha/yr)
	PFLW: Peak flow (mm/day)
	CRBN: Carbon sequestration (metrictons/ha)
	CORY: Corn yield (bu/ha)
	HAYY: Hay yield (bu/ha)
	SOYY: Soybean yield (bu/ha)
	FRSY: Forest yield (bu/ha)
	CPI = Crop productivity index = Linear combination of normalized and Weighed state variables  (CORN, SOY, HAY), Where the weights are CORN = 1, SOY = 3.1, and HAY = 10.
	CPI = CORN + SOYB*3.1 + HAYY*10
	HWI = Hydrology and Water quality index = Linear combination of normalized and Weighed state  variables(SYLD, PYLD, NYLD, PFLW, CRBN), Where the weight are 1 for all.
	HWI = 1*SYLD/max(SYLD) + 1*PYLD/max(PYLD) + 1*NYLD/max(NYLD) + 1*PFLW/max(PFLW) + 1*CRBN/max(CRBN)
	
	1 hectare (ha) = 10000 m2 = 0.01 km2
	1 sq.km = 100 ha
	1 U.S. bushel (bu) = 8 corn/dry gallons = 2150.42 cu in ≈ 35.2391 litre ≈ 9.30918 wine/liquid gallons
	*/
	// Hydrological Response Unit
	public class WsDataHru {

		private var _syld:Number;
		private var _pyld:Number;
		private var _nyld:Number;
		private var _pflw:Number;
		private var _crbn:Number;
		private var _cory:Number;
		private var _hayy:Number;
		private var _soyy:Number;
		private var _frsy:Number;

    public function WsDataHru(syld:Number, pyld:Number, nyld:Number,
															pflw:Number, crbn:Number,	cory:Number,
															hayy:Number, soyy:Number, frsy:Number) {
			this._syld = syld;
			this._pyld = pyld;
			this._nyld = nyld;
			this._pflw = pflw;
			this._crbn = crbn;
			this._cory = cory;
			this._hayy = hayy;
			this._soyy = soyy;
			this._frsy = frsy;
    }

		public function get syld():Number {
			return this._syld;
		}
		
		public function get pyld():Number {
			return this._pyld;
		}
		
		public function get nyld():Number {
			return this._nyld;
		}
		
		public function get pflw():Number {
			return this._pflw;
		}
		
		public function get crbn():Number {
			return this._crbn;
		}
		
		public function get cory():Number {
			return this._cory;
		}
		
		public function get hayy():Number {
			return this._hayy;
		}
		
		public function get soyy():Number {
			return this._soyy;
		}
		
		public function get frsy():Number {
			return this._frsy;
		}
  }
}
