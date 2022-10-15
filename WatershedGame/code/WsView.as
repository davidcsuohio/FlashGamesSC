package code {
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import fl.controls.ComboBox;
	
	public class WsView extends Sprite{
		
		private const YEAR_ONE_X:Number = 10;
		private const YEAR_ONE_Y:Number = WsConsts.GAME_TITLE_HEIGHT + 20;
		private const YEAR_TWO_X:Number = 570;
		private const YEAR_TWO_Y:Number = WsConsts.GAME_TITLE_HEIGHT + 20;
		private const LEGENDS_X:Number = 450;
		private const LEGENDS_Y:Number = WsConsts.GAME_TITLE_HEIGHT + 50;
		private const OPERATIONS_X:Number = LEGENDS_X;
		private const OPERATIONS_Y:Number = 500;
		private const ERROR_MSG_X:Number = LEGENDS_X;
		private const ERROR_MSG_Y:Number = 350;
		private const ERROR_MSG_WIDTH:Number = 100;
		private const ERROR_MSG_HEIGHT:Number = 100;
		private const COMBOBOX_Y:Number = 11;
		private const COMBOBOX_WIDTH:Number = 160;
		private const COMBOBOX_HEIGHT:Number = 24;
		private const GRAPHS_CB_LABEL_WIDTH:Number = 55;
		private const GRAPHS_CB_X:Number = 60;
		private const PRESET_CB_LABEL_WIDTH:Number = 110;
		private const PRESET_CB_X:Number = WsConsts.GAME_WIDTH - COMBOBOX_WIDTH - 10;
				
		private var data:WsData;
		private var yearOneLandUse:WsLands;
		private var yearTwoLandUse:WsLands;
		private var legends:WsLegends;
		private var operations:WsOperations;
		private var errorTF:TextField;
		private var ecoScore:WsEcoScore;
		private var ecoService:WsEcoService;
		private var relationshipsBtn:WsButton;
		private var graphsCB:WsComboBox;
		private var relationships:WsRelationships;
		private var satelliteImage:WsSatelliteImage;
		private var streetMap:WsStreetMap;
		private var presetCB:WsComboBox;
		private var addScores:WsAddScores;
		// These two variables are used to fix the arrow issue when the scrollpane scrolled.
		// involved classes:
		//   ... (used by the parent class WsResizeComponent);
		private var _scrollPaneDx:Number;
		private var _scrollPaneDy:Number;
		
		public function WsView() {
			_scrollPaneDx = 0;
			_scrollPaneDy = 0;
			this.ecoScore = null;
			this.ecoService = null;
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
		}

		public function get scrollPaneDx():Number {
			return _scrollPaneDx;
		}
		public function set scrollPaneDx(value:Number):void {
			_scrollPaneDx = value;
		}
		
		public function get scrollPaneDy():Number {
			return _scrollPaneDy;
		}
		public function set scrollPaneDy(value:Number):void {
			_scrollPaneDy = value;
		}
		
    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			addEventListener(WsEvent.RESET_LANDUSE, resetLanduse, false, 0, true);
			addEventListener(WsEvent.SUBMIT_LANDUSE, submitLanduse, false, 0, true);
			addEventListener(WsEvent.CLEAR_ERROR_MSG, clearErrorMsg, false, 0, true);
			addEventListener(WsEvent.ADD_ECO_SCORE, addEcoScore, false, 0, true);
			addEventListener(WsEvent.CLOSE_ECO_SCORE, closeEcoScore, false, 0, true);
			addEventListener(WsEvent.CLOSE_ECO_SERVICE, closeEcoService, false, 0, true);
			addEventListener(WsEvent.CLOSE_RELATIONSHIPS, closeRelationships, false, 0, true);
			addEventListener(WsEvent.CLOSE_SATELLITE_IMAGE, closeSatelliteImage, false, 0, true);
			addEventListener(WsEvent.CLOSE_STREET_MAP, closeStreetMap, false, 0, true);
			addEventListener(WsEvent.ADD_ADD_SCORES, addAddScores, false, 0, true);
			addEventListener(WsEvent.CLOSE_ADD_SCORES, closeAddScores, false, 0, true);
			
			this.data = new WsData();
			setupBgTitleAndCBs();
			setupLands();
			setupLegends();
			setupOperations();
			setupErrorTextField();
		}
		
		private function setupBgTitleAndCBs():void {
//			WsUtils.setupBackground(this,
//															WsConsts.BACKGROUND_COLOR, 0.4,
//															0, 0, WsConsts.GAME_WIDTH, WsConsts.GAME_HEIGHT);
			WsUtils.setupTextFieldC2(this, WsConsts.GAME_TITLE,
															 0, 5, WsConsts.GAME_WIDTH, WsConsts.GAME_TITLE_HEIGHT,
															 24, true);
			WsUtils.setupTextFieldL2(this, WsConsts.GRAPHS_NAME,
															 GRAPHS_CB_X - GRAPHS_CB_LABEL_WIDTH, COMBOBOX_Y + 2,
															 GRAPHS_CB_LABEL_WIDTH, 20,
															 12, true);
			WsUtils.setupTextFieldL2(this, WsConsts.PRESET_OPTIONS_NAME,
															 PRESET_CB_X - PRESET_CB_LABEL_WIDTH, COMBOBOX_Y + 2,
															 PRESET_CB_LABEL_WIDTH, 20,
															 12, true);
			// create the graphs combobox;
			graphsCB = new WsComboBox();
			graphsCB.move(GRAPHS_CB_X, COMBOBOX_Y);
			graphsCB.setSize(COMBOBOX_WIDTH, COMBOBOX_HEIGHT);
			graphsCB.prompt = WsConsts.GRAPHS_CB_PROMPT;
      graphsCB.addItem( { label: WsConsts.BASIC_RELATIONSHIPS_NAME } );
      graphsCB.addItem( { label: WsConsts.SATELLITE_IMAGE_NAME } );
      graphsCB.addItem( { label: WsConsts.STREET_MAP_NAME } );
      graphsCB.addEventListener(Event.CHANGE, graphsChanged, false, 0, true);
			syncGraphsCBIndex();
			addChild(graphsCB);
			// create the preset Land Use combobox;
			presetCB = new WsComboBox();
			presetCB.move(PRESET_CB_X, COMBOBOX_Y);
			presetCB.setSize(COMBOBOX_WIDTH, COMBOBOX_HEIGHT);
			presetCB.prompt = WsConsts.PRESET_CB_PROMPT;
			presetCB.addItem( { label: WsConsts.OPTION_1_NAME } );
			presetCB.addItem( { label: WsConsts.OPTION_2_NAME } );
			presetCB.addItem( { label: WsConsts.OPTION_3_NAME } );
			presetCB.addItem( { label: WsConsts.OPTION_4_NAME } );
//			presetCB.addItem( { label: WsConsts.OPTION_5_NAME } );
			presetCB.addEventListener(Event.CHANGE, presetChanged, false, 0, true);
			presetCB.selectedIndex = -1;
			addChild(presetCB);
		}
		
		private function setupErrorTextField():void {
			errorTF = WsUtils.setupTextFieldL1(this,
																	this.ERROR_MSG_X, this.ERROR_MSG_Y,
																	this.ERROR_MSG_WIDTH, this.ERROR_MSG_HEIGHT,
																	12, false);
			errorTF.multiline = true;
			errorTF.wordWrap = true;
			errorTF.visible = false;
			errorTF.textColor = WsConsts.RED_COLOR;
		}
		
		private function setupLands():void {
			yearOneLandUse = new WsLands(this.data.yearOneLands, WsConsts.YEAR_ONE_LAND_USE_NAME,
																	 this.YEAR_ONE_X, this.YEAR_ONE_Y);
			addChild(yearOneLandUse);
			yearTwoLandUse = new WsLands(this.data.yearTwoLands, WsConsts.YEAR_TWO_LAND_USE_NAME,
																	 this.YEAR_TWO_X, this.YEAR_TWO_Y);
			addChild(yearTwoLandUse);
		}
		
		private function setupLegends():void {
			legends = new WsLegends(this.LEGENDS_X, this.LEGENDS_Y);
			addChild(legends);
		}
		
		private function setupOperations():void {
			operations = new WsOperations(this.OPERATIONS_X, this.OPERATIONS_Y);
			addChild(operations);
		}
		
		private function resetLanduse(e:Event):void {
			data.resetLanduse();
			this.updateLanduse();
			clearErrorMsg(null);
			this.presetCB.selectedIndex = -1;
		}
		
		private function updateLanduse():void {
			yearOneLandUse.updateLanduse();
			yearTwoLandUse.updateLanduse();
		}
		
		private function submitLanduse(e:Event):void {
			if (displayErrorMsg(data.yearOneUnassigned(), WsConsts.YEAR_ONE_LAND_USE_NAME))
				return;
			if (displayErrorMsg(data.yearTwoUnassigned(), WsConsts.YEAR_TWO_LAND_USE_NAME))
				return;
			this.data.addEcoDot();
			// display the chart;
			this.addEcoService();
		}
		
		private function displayErrorMsg(unassigned:Vector.<int>, land:String):Boolean {
			var ret:Boolean = false;
			var error:String;
			unassigned.sort(Array.NUMERIC);
			if (unassigned.length == 1) {
				error = "The following land in " + land + " is not assigned:\n";
				error += unassigned[0].toString() + "\n";
				setErrorMsg(error);
				ret = true;
			}
			else if (unassigned.length > 1) {
				error = "The following lands in " + land + " are not assigned:\n";
				for (var i:uint = 0; i < unassigned.length; i++) {
					error += unassigned[i].toString() + " ";
				}
				error += "\n";
				setErrorMsg(error);
				ret = true;
			}
			return ret;
		}
		
		private function setErrorMsg(error:String):void {
			errorTF.text = error;
			errorTF.visible = true;
		}
		
		private function clearErrorMsg(e:Event):void {
			errorTF.text = "";
			errorTF.visible = false;
		}
		
		private function closeEcoScore(e:Event):void {
			if (ecoScore && ecoScore.parent)
				removeChild(this.ecoScore);
			this.ecoScore = null;
		}
		
		private function addEcoScore(e:Event):void {
			var idx:int = this.numChildren;
			if (ecoScore && ecoScore.parent) {
			  idx = this.getChildIndex(ecoScore);
				removeChild(ecoScore);
			}
			var x:Number = 10;
			var y:Number = WsConsts.GAME_TITLE_HEIGHT + 10;
			var w:Number = this.stage.stageWidth - x - 10;
			var h:Number = this.stage.stageHeight - y - 10;
			ecoScore = new WsEcoScore(x, y, w, h, this.data, this);
			addChildAt(ecoScore, idx);
		}
		
		private function closeEcoService(e:Event):void {
			if (ecoService && ecoService.parent)
				removeChild(this.ecoService);
			this.ecoService = null;
		}

		private function addEcoService():void {
			var idx:int = this.numChildren;
			if (ecoService && ecoService.parent) {
			  idx = this.getChildIndex(ecoService);
				removeChild(ecoService);
			}
			var x:Number = 10;
			var y:Number = WsConsts.GAME_TITLE_HEIGHT + 10;
			var w:Number = this.stage.stageWidth - x - 10;
			var h:Number = this.stage.stageHeight - y - 10;
			ecoService = new WsEcoService(x, y, w, h, this.data, this);
			addChildAt(ecoService, idx);
		}
		
		private function relationshipsSelected():void {
			if (this.relationships && this.relationships.parent)
				removeChild(this.relationships);
			var x:Number = 10;
			var y:Number = WsConsts.GAME_TITLE_HEIGHT + 10;
			this.relationships = new WsRelationships(x, y);
			addChild(this.relationships);
		}
		
		private function satelliteImageSelected():void {
			if (this.satelliteImage && this.satelliteImage.parent)
				removeChild(this.satelliteImage);
			var x:Number = 10;
			var y:Number = WsConsts.GAME_TITLE_HEIGHT + 10;
			this.satelliteImage = new WsSatelliteImage(x, y);
			addChild(this.satelliteImage);
		}
		
		private function streetMapSelected():void {
			if (this.streetMap && this.streetMap.parent)
				removeChild(this.streetMap);
			var x:Number = 10;
			var y:Number = WsConsts.GAME_TITLE_HEIGHT + 10;
			this.streetMap = new WsStreetMap(x, y);
			addChild(this.streetMap);
		}

		private function closeRelationships(e:Event):void {
			removeChild(this.relationships);
			syncGraphsCBIndex();
		}
		
		private function closeSatelliteImage(e:Event):void {
			removeChild(this.satelliteImage);
			syncGraphsCBIndex();
		}
		
		private function closeStreetMap(e:Event):void {
			removeChild(this.streetMap);
			syncGraphsCBIndex();
		}
		
		private function graphsChanged(e:Event):void {
			var sel:String = graphsCB.selectedLabel;
			if (sel == WsConsts.BASIC_RELATIONSHIPS_NAME) {
				this.relationshipsSelected();
			}
			else if (sel == WsConsts.SATELLITE_IMAGE_NAME) {
				this.satelliteImageSelected();
			}
			else if (sel == WsConsts.STREET_MAP_NAME) {
				this.streetMapSelected();
			}
		}
		
		private function syncGraphsCBIndex():void {
			var idxR:int = -1;
			var idxSI:int = -1;
			var idxSM:int = -1;
			if (relationships && relationships.parent)
				idxR = this.getChildIndex(relationships);
			if (satelliteImage && satelliteImage.parent)
			  idxSI = this.getChildIndex(satelliteImage);
			if (streetMap && streetMap.parent)
			  idxSM = this.getChildIndex(streetMap);
			if (idxR == -1 && idxSI == -1 && idxSM == -1) {
				this.graphsCB.selectedIndex = -1;
			}
			else {
				// idxCB will be the index decided when the graphsCB calls addItem().
				var idxCB = -1;
				var idx:int = (int)(Math.max(idxR, idxSI, idxSM));
				if (idx == idxR)
					idxCB = 0;
				else if (idx == idxSI)
					idxCB = 1;
				else if (idx == idxSM)
					idxCB = 2;
				this.graphsCB.selectedIndex = idxCB;
			}
		}
		
		private function presetChanged(e:Event):void {
			var sel:String = presetCB.selectedLabel;
			if (sel == WsConsts.OPTION_1_NAME) {
				this.data.presetOption1();
			}
			else if (sel == WsConsts.OPTION_2_NAME) {
				this.data.presetOption2();
			}
			else if (sel == WsConsts.OPTION_3_NAME) {
				this.data.presetOption3();
			}
			else if (sel == WsConsts.OPTION_4_NAME) {
				this.data.presetOption4();
			}
			this.updateLanduse();
			if (this.ecoScore && this.ecoScore.parent) {
				this.closeEcoScore(null);
			}
			if (this.ecoService && this.ecoService.parent) {
				this.closeEcoService(null);
			}
			clearErrorMsg(null);
		}

		private function addAddScores(e:Event):void {
			var idx:int = this.numChildren;
			if (addScores && addScores.parent) {
			  idx = this.getChildIndex(addScores);
				removeChild(addScores);
			}
			var x:Number = 10;
			var y:Number = WsConsts.GAME_TITLE_HEIGHT + 10;
			var w:Number = this.stage.stageWidth - x - 10;
			var h:Number = this.stage.stageHeight - y - 10;
			addScores = new WsAddScores(x, y, w, h, this.data, this);
			addChildAt(addScores, idx);
		}
		
		private function closeAddScores(e:Event):void {
			if (addScores && addScores.parent)
				removeChild(this.addScores);
		}
		
	}
}
