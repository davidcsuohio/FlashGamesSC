package code {
	import fl.controls.progressBarClasses.IndeterminateBar;

  public class WsData {

		private var _yearOneLands:Vector.<WsDataLand>;
		private var _yearTwoLands:Vector.<WsDataLand>;
		private var _hruAreas:Vector.<WsDataHruArea>;
		private var _minSyld:Number;
		private var _minSumOfPyldNyld:Number;
		private var _minPflw:Number;
		private var _minCrbn:Number;
		private var _maxSyld:Number;
		private var _maxSumOfPyldNyld:Number;
		private var _maxPflw:Number;
		private var _maxCrbn:Number;
		private var _ecoDots:Vector.<WsDataDot>;

    public function WsData() {
			this.resetEcoDots();
			setupData();
    }

		public function get yearOneLands():Vector.<WsDataLand> {
			return _yearOneLands;
		}

		public function get yearTwoLands():Vector.<WsDataLand> {
			return _yearTwoLands;
		}
		
		public function resetLanduse():void {
			for (var i:int = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				_yearOneLands[i].resetLanduse();
				_yearTwoLands[i].resetLanduse();
			}
		}
		
		public function presetOption1():void {
			setFullLanduse(this._yearOneLands, WsConsts.LANDUSE_UNUSE_COLOR);
			setFullLanduse(this._yearTwoLands, WsConsts.LANDUSE_UNUSE_COLOR);
		}
		
		public function presetOption2():void {
			// array of [color, useNumber array]
			var useArr:Array = [[WsConsts.FOREST_COLOR, [0,1,5,16,20,23,26,27,28]],
													[WsConsts.HAY_COLOR, [3,4,10,11,12,13,14,17,24]],
													[WsConsts.SOY_COLOR, [2,6,7,21,25]],
													[WsConsts.CORN_COLOR, [8,9,15,18,19,22]]];
			setLanduse(this._yearOneLands, useArr);
			setFullLanduse(this._yearTwoLands, WsConsts.LANDUSE_UNUSE_COLOR);
		}
		
		public function presetOption3():void {
			// array of [color, useNumber array]
			var useArr:Array = [[WsConsts.FOREST_COLOR, [6,7,8,9,15,19]],
													[WsConsts.HAY_COLOR, [0,1,2,3,4,5,10,11,12,13,14,16,17,18,21,22,24,25]],
													[WsConsts.SOY_COLOR, [20,23,26,27,28]]];
			setLanduse(this._yearOneLands, useArr);
			setFullLanduse(this._yearTwoLands, WsConsts.LANDUSE_UNUSE_COLOR);
			// for test purpose;
//			setLanduse(this._yearTwoLands, useArr);
//			this.addEcoDotWithName("A", "1000", "4.0");
//			this.addEcoDotWithName("B", "2000", "3.5");
//			this.addEcoDotWithName("C", "3000", "3.2");
//			this.addEcoDotWithName("D", "4000", "2.9");
//			this.addEcoDotWithName("E", "5000", "2.6");
//			this.addEcoDotWithName("F", "6000", "2.0");
//			this.addEcoDotWithName("G", "7000", "1.0");
//			this.addEcoDotWithName("H", "8000", "0.5");
//			this.addEcoDotWithName("I", "1000", "1.0");
//			this.addEcoDotWithName("J", "2000", "2.0");
//			this.addEcoDotWithName("K", "3000", "3.0");
//			this.addEcoDotWithName("L", "4000", "1.0");
//			this.addEcoDotWithName("M", "5000", "1.5");
//			this.addEcoDotWithName("N", "6000", "3.0");
		}
		
		public function presetOption4():void {
			setFullLanduse(this._yearOneLands, WsConsts.FOREST_COLOR);
			setFullLanduse(this._yearTwoLands, WsConsts.LANDUSE_UNUSE_COLOR);
		}
		
		// return a vector of useNumbers of unassigned lands
		public function yearOneUnassigned():Vector.<int> {
			var ret:Vector.<int> = new Vector.<int>();
			for (var i:int = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				if (_yearOneLands[i].unassigned())
					ret.push(_yearOneLands[i].useNumber);
			}
			return ret;
		}

		// return a vector of useNumbers of unassigned lands
		public function yearTwoUnassigned():Vector.<int> {
			var ret:Vector.<int> = new Vector.<int>();
			for (var i:int = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				if (_yearTwoLands[i].unassigned())
					ret.push(_yearTwoLands[i].useNumber);
			}
			return ret;
		}
		
		// all Acres values are rounded;
		public function forestAcres():Number {
			return Math.round(this.serviceAcres(WsConsts.FOREST));
		}
		
		public function hayAcres():Number {
			return Math.round(this.serviceAcres(WsConsts.HAY));
		}
		
		public function cornAcres():Number {
			return Math.round(this.serviceAcres(WsConsts.CORN));
		}
		
		public function soyAcres():Number {
			return Math.round(this.serviceAcres(WsConsts.SOY));
		}
		
		private function forestBushels():Number {
			return this.serviceBushels(WsConsts.FOREST);
		}
		
		private function hayBushels():Number {
			return this.serviceBushels(WsConsts.HAY);
		}
		
		private function cornBushels():Number {
			return this.serviceBushels(WsConsts.CORN);
		}
		
		private function soyBushels():Number {
			return this.serviceBushels(WsConsts.SOY);
		}
		
		// Corn $2/bushel
		// Soybean $6/bushel
		// Hay  $9/ton
		// Forest $0.05/acre
		// All dollars values are rounded;
		public function forestDollars():Number {
			return Math.round(this.forestAcres() * 0.05);
		}
		
		public function hayDollars():Number {
			return Math.round(this.hayBushels() * 9);
		}
		
		public function cornDollars():Number {
			return Math.round(this.cornBushels() * 2);
		}
		
		public function soyDollars():Number {
			return Math.round(this.soyBushels() * 6);
		}
		
		// The following four values are rounded to two decimal places
		// soil conservation: opposite of normalized SYLD sediment yield scaled between 0 and 1
		public function soilConservation():Number {
			if (this._minSyld == this._maxSyld)
				return 1;
			// calculate the normalized syld scaled between 0 and 1 in two years;
			var syld:Vector.<Number> = new Vector.<Number>(WsCoordConsts.DATA_SIZE);
			var useNumber:int;
			var hruArea:WsDataHruArea;
			var yearone:int;
			var yeartwo:int;
			var hruRotation:WsDataHruRotation;
			var i:int;
			for (i = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				if (_yearOneLands[i].useNumber != _yearTwoLands[i].useNumber)
					throw new Error("Year one and year two data internal error!");
				useNumber = _yearOneLands[i].useNumber;
				yearone = WsUtils.getEcoServiceByUse(_yearOneLands[i].color);
				yeartwo = WsUtils.getEcoServiceByUse(_yearTwoLands[i].color);
				hruArea = this.getHruArea(useNumber);
				if (hruArea != null) {
					hruRotation = hruArea.getHruRotation(yearone, yeartwo);
					if (hruRotation != null) {
						syld[i] = (hruRotation.hru.syld - _minSyld) / (_maxSyld - _minSyld);
					}
				}
			}
			var sum:Number = 0.0;
			for (i = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				sum += syld[i];
			}
			return Math.round((1 - sum / WsCoordConsts.DATA_SIZE) * 100) / 100;
		}
		
		// water quality: opposite of normalized PYLD and NYLD scaled between 0 and 1
		public function waterQuality():Number {
			if (this._minSumOfPyldNyld == this._maxSumOfPyldNyld)
				return 1;
			// calculate the normalized sum of pyld and nyld scaled between 0 and 1 in two years;
			var pnyld:Vector.<Number> = new Vector.<Number>(WsCoordConsts.DATA_SIZE);
			var useNumber:int;
			var hruArea:WsDataHruArea;
			var yearone:int;
			var yeartwo:int;
			var hruRotation:WsDataHruRotation;
			var i:int;
			for (i = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				if (_yearOneLands[i].useNumber != _yearTwoLands[i].useNumber)
					throw new Error("Year one and year two data internal error!");
				useNumber = _yearOneLands[i].useNumber;
				yearone = WsUtils.getEcoServiceByUse(_yearOneLands[i].color);
				yeartwo = WsUtils.getEcoServiceByUse(_yearTwoLands[i].color);
				hruArea = this.getHruArea(useNumber);
				if (hruArea != null) {
					hruRotation = hruArea.getHruRotation(yearone, yeartwo);
					if (hruRotation != null) {
						pnyld[i] = (hruRotation.hru.pyld + hruRotation.hru.nyld - _minSumOfPyldNyld) / (_maxSumOfPyldNyld - _minSumOfPyldNyld);
					}
				}
			}
			var sum:Number = 0.0;
			for (i = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				sum += pnyld[i];
			}
			return Math.round((1 - sum / WsCoordConsts.DATA_SIZE) * 100) / 100;
		}
		
		// flood reduction: opposite of normalized PFLW scaled between 0 and 1
		public function floodReduction():Number {
			if (this._minPflw == this._maxPflw)
				return 1;
			// calculate the normalized pflw scaled between 0 and 1 in two years;
			var pflw:Vector.<Number> = new Vector.<Number>(WsCoordConsts.DATA_SIZE);
			var useNumber:int;
			var hruArea:WsDataHruArea;
			var yearone:int;
			var yeartwo:int;
			var hruRotation:WsDataHruRotation;
			var i:int;
			for (i = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				if (_yearOneLands[i].useNumber != _yearTwoLands[i].useNumber)
					throw new Error("Year one and year two data internal error!");
				useNumber = _yearOneLands[i].useNumber;
				yearone = WsUtils.getEcoServiceByUse(_yearOneLands[i].color);
				yeartwo = WsUtils.getEcoServiceByUse(_yearTwoLands[i].color);
				hruArea = this.getHruArea(useNumber);
				if (hruArea != null) {
					hruRotation = hruArea.getHruRotation(yearone, yeartwo);
					if (hruRotation != null) {
						pflw[i] = (hruRotation.hru.pflw - _minPflw) / (_maxPflw - _minPflw);
					}
				}
			}
			var sum:Number = 0.0;
			for (i = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				sum += pflw[i];
			}
			return Math.round((1 - sum / WsCoordConsts.DATA_SIZE) * 100) / 100;
		}
		
		// carbon retention: CRBN Carbon sequestrationv (more is better) normalized sum of flows at the outlet of each HRU
		public function carbonRetention():Number {
			if (this._minCrbn == this._maxCrbn)
				return 1;
			// calculate the normalized crbn scaled between 0 and 1 in two years;
			var crbn:Vector.<Number> = new Vector.<Number>(WsCoordConsts.DATA_SIZE);
			var useNumber:int;
			var hruArea:WsDataHruArea;
			var yearone:int;
			var yeartwo:int;
			var hruRotation:WsDataHruRotation;
			var i:int;
			for (i = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				if (_yearOneLands[i].useNumber != _yearTwoLands[i].useNumber)
					throw new Error("Year one and year two data internal error!");
				useNumber = _yearOneLands[i].useNumber;
				yearone = WsUtils.getEcoServiceByUse(_yearOneLands[i].color);
				yeartwo = WsUtils.getEcoServiceByUse(_yearTwoLands[i].color);
				hruArea = this.getHruArea(useNumber);
				if (hruArea != null) {
					hruRotation = hruArea.getHruRotation(yearone, yeartwo);
					if (hruRotation != null) {
						crbn[i] = (hruRotation.hru.crbn - _minCrbn) / (_maxCrbn - _minCrbn);
					}
				}
			}
			var sum:Number = 0.0;
			for (i = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				sum += crbn[i];
			}
			return Math.round(sum / WsCoordConsts.DATA_SIZE *100) / 100;
		}
		
		public function get ecoDots():Vector.<WsDataDot> {
			return this._ecoDots;
		}
		
		public function addEcoDot():void {
			var serialNo:int = this._ecoDots.length;
			var dollars:Number = this.forestDollars() + this.hayDollars() +
													 this.cornDollars() + this.soyDollars();
			var scores:Number = this.soilConservation() + this.waterQuality() +
												  this.floodReduction() + this.carbonRetention();
			this._ecoDots.push(new WsDataDot(serialNo, scores, dollars));
		}
		
		public function addEcoDotWithName(name:String, dollars:String, scores:String):void {
			if (name.length == 0 || dollars.length == 0 || scores.length == 0)
				return;
			var serialNo:int = this._ecoDots.length;
			this._ecoDots.push(new WsDataDot(serialNo, Number(scores), Number(dollars), name));
		}
		
		public function resetEcoDots():void {
			this._ecoDots = new Vector.<WsDataDot>();
		}
		
		private function setupData():void {
			var dataArr:Array = new Array();
			// [useNumber, coordsIndex]
			dataArr[0]  = [0,  0 ];
			dataArr[1]  = [2,  1 ];
			dataArr[2]  = [1,  2 ];
			dataArr[3]  = [18, 3 ];
			dataArr[4]  = [3,  4 ];
			dataArr[5]  = [17, 5 ];
			dataArr[6]  = [4,  6 ];
			dataArr[7]  = [5,  7 ];
			dataArr[8]  = [22, 8 ];
			dataArr[9]  = [21, 9 ];
			dataArr[10] = [19, 10];
			dataArr[11] = [6,  11];
			dataArr[12] = [7,  12];
			dataArr[13] = [8,  13];
			dataArr[14] = [24, 14];
			dataArr[15] = [9,  15];
			dataArr[16] = [15, 16];
			dataArr[17] = [11, 17];
			dataArr[18] = [10, 18];
			dataArr[19] = [25, 19];
			dataArr[20] = [13, 20];
			dataArr[21] = [12, 21];
			dataArr[22] = [20, 22];
			dataArr[23] = [26, 23];
			dataArr[24] = [16, 24];
			dataArr[25] = [27, 25];
			dataArr[26] = [23, 26];
			dataArr[27] = [14, 27];
			dataArr[28] = [28, 28];

			_yearOneLands = new Vector.<WsDataLand>();
			_yearTwoLands = new Vector.<WsDataLand>();
			var land:WsDataLand;
			var i:int;
			for (i = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				land = new WsDataLand(dataArr[i][0],
															dataArr[i][1]);
				_yearOneLands.push(land);
			}
			for (i = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				land = new WsDataLand(dataArr[i][0],
															dataArr[i][1]);
				_yearTwoLands.push(land);
			}
			
			// setup _hruAreas;
			this._hruAreas = new Vector.<WsDataHruArea>();
			var hruArea:WsDataHruArea = null;
			var useNumber:int;
			var prevUseNumber:int = -1;
			for (i = 0; i < WsDataConsts.WS_DATA_ARRAY.length; i++) {
				useNumber = WsDataConsts.WS_DATA_ARRAY[i][1];
				if (useNumber == prevUseNumber) {
					hruArea.addHruRotation(this.createHruRotation(i));
				}
				else {
					if (hruArea != null)
						this._hruAreas.push(hruArea);
					hruArea = new WsDataHruArea(WsDataConsts.WS_DATA_ARRAY[i][0], useNumber);
					hruArea.addHruRotation(this.createHruRotation(i));
					prevUseNumber = useNumber;
				}
			}
			// add the last hruArea;
			if (hruArea != null)
				this._hruAreas.push(hruArea);
			// calculate the min, max syld, pflw, crbn and (pyld+nyld)
			var temp:Number;
			_minSyld = this._hruAreas[0].minSyld();
			for (i = 1; i < this._hruAreas.length; i++) {
				temp = this._hruAreas[i].minSyld();
				if (_minSyld > temp)
					_minSyld = temp;
			}
			_maxSyld = this._hruAreas[0].maxSyld();
			for (i = 1; i < this._hruAreas.length; i++) {
				temp = this._hruAreas[i].minSyld();
				if (_maxSyld < temp)
					_maxSyld = temp;
			}
			this._minSumOfPyldNyld = this._hruAreas[0].minSumOfPyldNyld();
			for (i = 1; i < this._hruAreas.length; i++) {
				temp = this._hruAreas[i].minSumOfPyldNyld();
				if (_minSumOfPyldNyld > temp)
					_minSumOfPyldNyld = temp;
			}
			_maxSumOfPyldNyld = this._hruAreas[0].maxSumOfPyldNyld();
			for (i = 1; i < this._hruAreas.length; i++) {
				temp = this._hruAreas[i].maxSumOfPyldNyld();
				if (_maxSumOfPyldNyld < temp)
					_maxSumOfPyldNyld = temp;
			}
			this._minPflw = this._hruAreas[0].minPflw();
			for (i = 1; i < this._hruAreas.length; i++) {
				temp = this._hruAreas[i].minPflw();
				if (_minPflw > temp)
					_minPflw = temp;
			}
			this._maxPflw = this._hruAreas[0].maxPflw();
			for (i = 1; i < this._hruAreas.length; i++) {
				temp = this._hruAreas[i].maxPflw();
				if (_maxPflw < temp)
					_maxPflw = temp;
			}
			this._minCrbn = this._hruAreas[0].minCrbn();
			for (i = 1; i < this._hruAreas.length; i++) {
				temp = this._hruAreas[i].minCrbn();
				if (_minCrbn > temp)
					_minCrbn = temp;
			}
			this._maxCrbn = this._hruAreas[0].maxCrbn();
			for (i = 1; i < this._hruAreas.length; i++) {
				temp = this._hruAreas[i].maxCrbn();
				if (_maxCrbn < temp)
					_maxCrbn = temp;
			}
			
		}
		
		private function createHruRotation(rowIdx:int):WsDataHruRotation {
			var hru:WsDataHru = new WsDataHru(
								WsDataConsts.WS_DATA_ARRAY[rowIdx][3],
								WsDataConsts.WS_DATA_ARRAY[rowIdx][4],
								WsDataConsts.WS_DATA_ARRAY[rowIdx][5],
								WsDataConsts.WS_DATA_ARRAY[rowIdx][6],
								WsDataConsts.WS_DATA_ARRAY[rowIdx][7],
								WsDataConsts.WS_DATA_ARRAY[rowIdx][8],
								WsDataConsts.WS_DATA_ARRAY[rowIdx][9],
								WsDataConsts.WS_DATA_ARRAY[rowIdx][10],
								WsDataConsts.WS_DATA_ARRAY[rowIdx][11]);
			var yearone:int;
			var yeartwo:int;
			switch (WsDataConsts.WS_DATA_ARRAY[rowIdx][2]) {
				case WsDataConsts.CC:
					yearone = WsConsts.CORN;
					yeartwo = WsConsts.CORN;
					break;
				case WsDataConsts.CF:
					yearone = WsConsts.CORN;
					yeartwo = WsConsts.FOREST;
					break;
				case WsDataConsts.CH:
					yearone = WsConsts.CORN;
					yeartwo = WsConsts.HAY;
					break;
				case WsDataConsts.CS:
					yearone = WsConsts.CORN;
					yeartwo = WsConsts.SOY;
					break;
				case WsDataConsts.FC:
					yearone = WsConsts.FOREST;
					yeartwo = WsConsts.CORN;
					break;
				case WsDataConsts.FF:
					yearone = WsConsts.FOREST;
					yeartwo = WsConsts.FOREST;
					break;
				case WsDataConsts.FH:
					yearone = WsConsts.FOREST;
					yeartwo = WsConsts.HAY;
					break;
				case WsDataConsts.FS:
					yearone = WsConsts.FOREST;
					yeartwo = WsConsts.SOY;
					break;
				case WsDataConsts.HC:
					yearone = WsConsts.HAY;
					yeartwo = WsConsts.CORN;
					break;
				case WsDataConsts.HF:
					yearone = WsConsts.HAY;
					yeartwo = WsConsts.FOREST;
					break;
				case WsDataConsts.HH:
					yearone = WsConsts.HAY;
					yeartwo = WsConsts.HAY;
					break;
				case WsDataConsts.HS:
					yearone = WsConsts.HAY;
					yeartwo = WsConsts.SOY;
					break;
				case WsDataConsts.SC:
					yearone = WsConsts.SOY;
					yeartwo = WsConsts.CORN;
					break;
				case WsDataConsts.SF:
					yearone = WsConsts.SOY;
					yeartwo = WsConsts.FOREST;
					break;
				case WsDataConsts.SH:
					yearone = WsConsts.SOY;
					yeartwo = WsConsts.HAY;
					break;
				case WsDataConsts.SS:
					yearone = WsConsts.SOY;
					yeartwo = WsConsts.SOY;
					break;
				default:
					yearone = WsConsts.CORN;
					yeartwo = WsConsts.CORN;
			}
			return new WsDataHruRotation(yearone, yeartwo, hru);
		}
		
		private function getHruArea(useNumber:int):WsDataHruArea {
			for (var i:uint = 0; i < this._hruAreas.length; i++) {
				if (this._hruAreas[i].useNumber == useNumber)
					return this._hruAreas[i];
			}
			return null;
		}
		
		private function serviceAcres(service:int):Number {
			var ret:Number = 0;
			var useNumber:int;
			var hruArea:WsDataHruArea;
			var ecoService:int;
			for (var i:int = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				if (_yearOneLands[i].useNumber != _yearTwoLands[i].useNumber)
					throw new Error("Year one and year two data internal error!");
				useNumber = _yearOneLands[i].useNumber;
				ecoService = WsUtils.getEcoServiceByUse(_yearOneLands[i].color);
				if (ecoService == service) {
					hruArea = this.getHruArea(useNumber);
					if (hruArea != null) {
						ret += hruArea.area;
					}
				}
				ecoService = WsUtils.getEcoServiceByUse(_yearTwoLands[i].color);
				if (ecoService == service) {
					hruArea = this.getHruArea(useNumber);
					if (hruArea != null) {
						ret += hruArea.area;
					}
				}
			}
			return ret * WsConsts.ACRES_PER_SQKM / 2;
		}

		private function serviceBushels(service:int):Number {
			var ret:Number = 0;
			var useNumber:int;
			var hruArea:WsDataHruArea;
			var yearone:int;
			var yeartwo:int;
			var hruRotation:WsDataHruRotation;
			for (var i:int = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				if (_yearOneLands[i].useNumber != _yearTwoLands[i].useNumber)
					throw new Error("Year one and year two data internal error!");
				useNumber = _yearOneLands[i].useNumber;
				yearone = WsUtils.getEcoServiceByUse(_yearOneLands[i].color);
				yeartwo = WsUtils.getEcoServiceByUse(_yearTwoLands[i].color);
				if (yearone != service && yeartwo != service)
					continue;
				hruArea = this.getHruArea(useNumber);
				if (hruArea != null) {
					hruRotation = hruArea.getHruRotation(yearone, yeartwo);
					if (hruRotation != null) {
						if (yearone == service)
							ret += this.calculateBushels(service, hruRotation);
						if (yeartwo == service)
							ret += this.calculateBushels(service, hruRotation);
					}
				}
			}
			return ret / 2;
		}
		
		private function calculateBushels(service:int,
																			hruRotation:WsDataHruRotation):Number {
			if (service == WsConsts.CORN)
				return hruRotation.hru.cory;
			else if (service == WsConsts.SOY)
				return hruRotation.hru.soyy;
			else if (service == WsConsts.HAY)
				return hruRotation.hru.hayy;
			else if (service == WsConsts.FOREST)
				return hruRotation.hru.frsy;
			else
				throw new Error("Internal error in calculateBushels()!");
		}

		private function getLand(lands:Vector.<WsDataLand>, useNumber:int):WsDataLand {
			for (var i:int = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				if (lands[i].useNumber == useNumber)
					return lands[i];
			}
			return null;
		}
		
		private function setFullLanduse(lands:Vector.<WsDataLand>, color:uint):void {
			for (var i:int = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				lands[i].color = color;
			}
		}
		
		// example useArr format:
		//             [color, useNumber array]
		// useArr[0] = [WsConsts.FOREST_COLOR, [0,1,2,4,6,17]];
		public function setLanduse(lands:Vector.<WsDataLand>, useArr:Array):void {
			var color:uint = WsConsts.LANDUSE_UNUSE_COLOR;
			var useNumberArr:Array;
			var land:WsDataLand;
			for (var i:uint = 0; i < useArr.length; i++) {
				color = useArr[i][0];
				useNumberArr = useArr[i][1];
				for (var j:uint = 0; j < useNumberArr.length; j++) {
					land = this.getLand(lands, useNumberArr[j]);
					if (land)
						land.color = color;
				}
			}
		}
		
  }
}
