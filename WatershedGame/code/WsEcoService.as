package code {

  import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.ui.*;
	import fl.controls.Button;

  public class WsEcoService extends WsResizeComponent {

		// the picture will use smaller font size when the height is less than 580;
		private const CHANGE_SIZE_HEIGHT:Number = 580;
		private const AREAS_GAP_Y:Number = 20;
		private const AREAS_GAP_X:Number = 10;
		private const SERVICE_NAME_X:Number = 0;
		private const SERVICE_NAME_WIDTH:Number = 100;
		private const SERVICE_GAP_Y:Number = 10;
		private const BTM_SERVICE_NAME_X:Number = 0;
		private const BTM_SERVICE_NAME_WIDTH:Number = 180;
		private const SCORE_BTN_WIDTH:Number = WsConsts.CLOSE_BUTTON_WIDTH;
		private const SCORE_BTN_HEIGHT:Number = WsConsts.CLOSE_BUTTON_HEIGHT;

		private var data:WsData;
		private var w:Number;
		private var h:Number;
		private var areasWidth:Number;
		private var dollarsWidth:Number;
		private var areasY:Number;
		private var container:Sprite;
		private var btmAreasY:Number;
		private var scoreBtn:Button;
		// the following variables are used to adjust sizes when the window size becomes smaller;
		private var titleFontSize:Object;
		private var categoryFontSize:Object;
		private var areasHeight:Number;
		private var titleHeight:Number;
		private var titleGapY:Number;
		private var serviceHeight:Number;

    public function WsEcoService(x:Number, yTop:Number,
															 w:Number, h:Number,
															 data:WsData, view:WsView) {
			super(x, yTop, 400, 400, w, h, view);
			this.data = data;
			this.createScoreBtn();
			this.updateCalculationData(w, h);
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);

			handleContextMenu();
			drawServiceInfo();
			super.addResizeIconAndFrame();
		}
		
		override public function resizeDone():void {
			this.updateCalculationData(super.width, super.height);
			drawServiceInfo();
		}
		
		override protected function closeBtnClickedHandling():void {
			closeEcoService(null);
		}
		
		private function drawServiceInfo():void {
			var idx:int = this.numChildren;
			if (container && container.parent) {
			  idx = this.getChildIndex(container);
				removeChild(container);
			}
			container = new Sprite();
			drawCharts();
			addChildAt(container, idx);
			if (!this.scoreBtn.parent)
				addChild(scoreBtn);
			scoreBtn.move(super.xPos + this.w - SCORE_BTN_WIDTH - WsConsts.CLOSE_BUTTON_WIDTH - 20, super.yTop + 10);
		}
		
		private function updateCalculationData(wNew:Number, hNew:Number):void {
			this.w = wNew > super.minWidth ? wNew : super.minWidth;
			this.h = hNew > super.minHeight ? hNew : super.minHeight;
			if (this.h < this.CHANGE_SIZE_HEIGHT) {
				this.titleFontSize = 20; //30;
				this.categoryFontSize = 15; //20;
				this.areasHeight = 18; // 20;
				this.titleHeight = 20; // 40;
				this.serviceHeight = 18; // 30;
				this.titleGapY = 10; //20;
			}
			else {
				this.titleFontSize = 30;
				this.categoryFontSize = 20;
				this.areasHeight = 20;
				this.titleHeight = 40;
				this.serviceHeight = 30;
				this.titleGapY = 20;
			}
			this.areasWidth = (this.w - this.SERVICE_NAME_X - this.SERVICE_NAME_WIDTH) / 2;
			this.dollarsWidth = this.w - this.SERVICE_NAME_X - this.SERVICE_NAME_WIDTH - this.areasWidth;
			this.areasY = this.h / 2 - this.titleHeight / 2 - this.titleGapY -
										this.areasHeight - this.AREAS_GAP_Y -
										5 * this.SERVICE_GAP_Y - 4 * this.serviceHeight;
			this.btmAreasY = this.h / 2 + this.titleHeight + this.titleGapY;
		}
		
		private function drawCharts():void {
			WsUtils.setupBackground(container,
															WsConsts.WHITE_COLOR, 1,
															xPos, super.yTop, w, h);
			// draw the legends;
			var yFirstService:Number = super.yTop + this.areasY + this.areasHeight + 
																 this.AREAS_GAP_Y + this.SERVICE_GAP_Y;
			WsUtils.setupTextFieldR2(this.container,
															 WsConsts.FOREST_NAME,
															 xPos + this.SERVICE_NAME_X, yFirstService,
															 this.SERVICE_NAME_WIDTH, this.serviceHeight,
															 12, true);
			WsUtils.setupTextFieldR2(this.container,
															 WsConsts.HAY_NAME,
															 xPos + this.SERVICE_NAME_X, yFirstService + this.serviceHeight + this.SERVICE_GAP_Y,
															 this.SERVICE_NAME_WIDTH, this.serviceHeight,
															 12, true);
			WsUtils.setupTextFieldR2(this.container,
															 WsConsts.CORN_NAME,
															 xPos + this.SERVICE_NAME_X, yFirstService + (this.serviceHeight + this.SERVICE_GAP_Y) * 2,
															 this.SERVICE_NAME_WIDTH, this.serviceHeight,
															 12, true);
			WsUtils.setupTextFieldR2(this.container,
															 WsConsts.SOYBEANS_NAME,
															 xPos + this.SERVICE_NAME_X, yFirstService + (this.serviceHeight + this.SERVICE_GAP_Y) * 3,
															 this.SERVICE_NAME_WIDTH, this.serviceHeight,
															 12, true);
			// draw chart category names;
			WsUtils.setupTextFieldC4(this.container,
															 WsConsts.ACRES_NAME,
															 xPos + this.SERVICE_NAME_X + this.SERVICE_NAME_WIDTH + this.areasWidth / 2,
															 yTop + this.areasY,
															 this.areasWidth, this.areasHeight,
															 categoryFontSize, true);
			WsUtils.setupTextFieldC4(this.container,
															 WsConsts.DOLLARS_NAME,
															 xPos + this.SERVICE_NAME_X + this.SERVICE_NAME_WIDTH + this.areasWidth + this.dollarsWidth / 2,
															 yTop + this.areasY,
															 this.dollarsWidth, this.areasHeight,
															 categoryFontSize, true);
			// draw the title name;
			WsUtils.setupTextFieldC4(this.container,
															 WsConsts.ECOSYSTEM_SERVICES_NAME,
															 xPos + this.w / 2, super.yTop + this.h / 2 - this.titleHeight / 2 + this.titleGapY,
															 this.w, this.titleHeight,
															 titleFontSize, true);
			// draw the area graph;
			var forest:Number = this.data.forestAcres();
			var hay:Number = this.data.hayAcres();
			var corn:Number = this.data.cornAcres();
			var soy:Number = this.data.soyAcres();
			var wMax:Number = this.areasWidth - this.AREAS_GAP_X;
			var unit:Number = wMax / Math.max(forest, hay, corn, soy);
			var xx:Number = xPos + this.SERVICE_NAME_X + this.SERVICE_NAME_WIDTH + this.AREAS_GAP_X;
			this.drawRectsAndValues(xx, yFirstService, wMax, unit, forest, hay, corn, soy);
			// draw the dollar graph;
			forest = this.data.forestDollars();
			hay = this.data.hayDollars();
			corn = this.data.cornDollars();
			soy = this.data.soyDollars();
			wMax = this.dollarsWidth - this.AREAS_GAP_X * 2;
			unit = wMax / Math.max(forest, hay, corn, soy);
			xx = xPos + this.SERVICE_NAME_X + this.SERVICE_NAME_WIDTH + this.areasWidth + this.AREAS_GAP_X;
			this.drawRectsAndValues(xx, yFirstService, wMax, unit, forest, hay, corn, soy);
			// draw the dollars you have earned
			var total:Number = forest + hay + corn + soy;
			var str:String = WsConsts.YOU_EARNED_NAME + total.toString();
			WsUtils.setupTextFieldC4(this.container,
															 str,
															 xPos + this.w / 2,
															 yFirstService + (this.serviceHeight + this.SERVICE_GAP_Y) * 4,
															 this.w, this.serviceHeight,
															 14, true);
			
			// draw the bottom part;
			// draw the legends;
			var yBtmFirstService:Number = super.yTop + this.btmAreasY + this.SERVICE_GAP_Y;
			WsUtils.setupTextFieldR2(this.container,
															 WsConsts.SOIL_CONSERVATION_NAME,
															 xPos + this.BTM_SERVICE_NAME_X, yBtmFirstService,
															 this.BTM_SERVICE_NAME_WIDTH, this.serviceHeight,
															 12, true);
			WsUtils.setupTextFieldR2(this.container,
															 WsConsts.WATER_QUALITY_NAME,
															 xPos + this.BTM_SERVICE_NAME_X, yBtmFirstService + this.serviceHeight + this.SERVICE_GAP_Y,
															 this.BTM_SERVICE_NAME_WIDTH, this.serviceHeight,
															 12, true);
			WsUtils.setupTextFieldR2(this.container,
															 WsConsts.FLOOD_REDUCTION_NAME,
															 xPos + this.BTM_SERVICE_NAME_X, yBtmFirstService + (this.serviceHeight + this.SERVICE_GAP_Y) * 2,
															 this.BTM_SERVICE_NAME_WIDTH, this.serviceHeight,
															 12, true);
			WsUtils.setupTextFieldR2(this.container,
															 WsConsts.CARBON_RETENTION_NAME,
															 xPos + this.BTM_SERVICE_NAME_X, yBtmFirstService + (this.serviceHeight + this.SERVICE_GAP_Y) * 3,
															 this.BTM_SERVICE_NAME_WIDTH, this.serviceHeight,
															 12, true);
			// draw the graph;
			var soil:Number = this.data.soilConservation();
			var water:Number = this.data.waterQuality();
			var flood:Number = this.data.floodReduction();
			var carbon:Number = this.data.carbonRetention();
			unit = this.w - this.BTM_SERVICE_NAME_X - this.BTM_SERVICE_NAME_WIDTH - this.AREAS_GAP_X * 5;
			xx = xPos + this.BTM_SERVICE_NAME_X + this.BTM_SERVICE_NAME_WIDTH + this.AREAS_GAP_X;
			var rect:Shape = new Shape();
			this.container.addChild(rect);
			rect.graphics.lineStyle(1, WsConsts.BLACK_COLOR, 1,
														  false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			rect.graphics.beginFill(WsConsts.SOIL_COLOR);
			this.drawBtmRectAndValue(rect, xx,
															 yBtmFirstService,
															 soil, unit);
			rect.graphics.beginFill(WsConsts.WATER_COLOR);
			this.drawBtmRectAndValue(rect, xx,
															 yBtmFirstService + this.serviceHeight + this.SERVICE_GAP_Y,
															 water, unit);
			rect.graphics.beginFill(WsConsts.FLOOD_COLOR);
			this.drawBtmRectAndValue(rect, xx,
															 yBtmFirstService + (this.serviceHeight + this.SERVICE_GAP_Y) * 2,
															 flood, unit);
			rect.graphics.beginFill(WsConsts.CARBON_COLOR);
			this.drawBtmRectAndValue(rect, xx,
															 yBtmFirstService + (this.serviceHeight + this.SERVICE_GAP_Y) * 3,
															 carbon, unit);
			// draw the total ecosystem services score
			total = soil + water + flood + carbon;
			str = WsConsts.TOTAL_ECOSYSTEM_SERVICES_SCORE_NAME +
						" " + String(total) + " OUT OF 4.00";
			WsUtils.setupTextFieldC4(this.container,
															 str,
															 xPos + this.w / 2,
															 yBtmFirstService + (this.serviceHeight + this.SERVICE_GAP_Y) * 4,
															 this.w, this.serviceHeight,
															 14, true);
		}
		
		private function drawRectsAndValues(xx:Number, yy:Number, wMax:Number, unit:Number,
																				forest:Number, hay:Number, corn:Number, soy:Number):void {
			var rect:Shape = new Shape();
			this.container.addChild(rect);
			rect.graphics.lineStyle(1, WsConsts.BLACK_COLOR, 1,
														  false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			rect.graphics.beginFill(WsConsts.FOREST_COLOR);
			this.drawRectAndValue(rect, xx, yy,
														forest, unit, wMax);
			rect.graphics.beginFill(WsConsts.HAY_COLOR);
			this.drawRectAndValue(rect, xx, yy + this.serviceHeight + this.SERVICE_GAP_Y,
														hay, unit, wMax);
			rect.graphics.beginFill(WsConsts.CORN_COLOR);
			this.drawRectAndValue(rect, xx, yy + (this.serviceHeight + this.SERVICE_GAP_Y) * 2,
														corn, unit, wMax);
			rect.graphics.beginFill(WsConsts.SOY_COLOR);
			this.drawRectAndValue(rect, xx, yy + (this.serviceHeight + this.SERVICE_GAP_Y) * 3,
														soy, unit, wMax);
		}
		
		private function drawRectAndValue(rect:Shape, x:Number, y:Number,
																			service:Number, unit:Number, wMax:Number):void {
			var ww:Number = Math.round(service * unit);
			rect.graphics.drawRect(x, y, ww, this.serviceHeight);
			// 11 = 14 / 2 + 4; 14 - font size ; 4 - font top gap
			var yy:Number = y + this.serviceHeight / 2 - 11;
			if (ww > wMax / 2) {
				WsUtils.setupTextFieldC4(this.container,
																 String(service),
																 x + ww/2, yy, ww, this.serviceHeight,
																 14, true);
			}
			else {
				WsUtils.setupTextFieldL2(this.container,
																 String(service),
																 x + ww + 7, yy, wMax - ww, this.serviceHeight,
																 14, true);
			}
		}
		
		private function drawBtmRectAndValue(rect:Shape, x:Number, y:Number,
																			   service:Number, unit:Number):void {
			var ww:Number = Math.round(service * unit * 100) / 100;
			rect.graphics.drawRect(x, y, ww, this.serviceHeight);
			// 11 = 14 / 2 + 4; 14 - font size ; 4 - font top gap
			var yy:Number = y + this.serviceHeight / 2 - 11;
			WsUtils.setupTextFieldL2(this.container,
															 String(service),
															 x + ww + 7, yy, unit - ww, this.serviceHeight,
															 14, true);
		}

		private function handleContextMenu():void {
			var myCM:ContextMenu = new ContextMenu();
			myCM.hideBuiltInItems();
			var myCMI = new ContextMenuItem(WsConsts.CLOSE_ECO_SERVICES_NAME);
			myCM.customItems.push(myCMI);

			myCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, closeEcoService);
			this.contextMenu = myCM;
		}
		
		private function closeEcoService(e:ContextMenuEvent):void {
			dispatchEvent(new WsEvent(WsEvent.CLOSE_ECO_SERVICE, true));
		}
		
		private function createScoreBtn():void {
			this.scoreBtn = new Button();
			scoreBtn.label = WsConsts.SCORE_GRAPH_NAME;
			scoreBtn.setSize(SCORE_BTN_WIDTH, SCORE_BTN_HEIGHT);
			scoreBtn.addEventListener(MouseEvent.CLICK, scoreBtnClicked, false, 0, true);
		}
		
		private function scoreBtnClicked(e:MouseEvent):void {
			dispatchEvent(new WsEvent(WsEvent.ADD_ECO_SCORE, true));
		}
  }
}
