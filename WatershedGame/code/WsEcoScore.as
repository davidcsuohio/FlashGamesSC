package code {

  import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.ui.*;
	import fl.controls.Button;

  public class WsEcoScore extends WsResizeComponent {

		// y axis: CPI (Crop productivity index);
		private const UNIT_Y:Number = 2000;
		// x axis: total ecosystem services score (0-4)
		private const UNIT_X:Number = 1;
		private const MAX_NUM_X:Number = 4;
		private const MAX_NUM_Y:Number = 4;
		private const LEFT_MARGIN:Number = 10;
		private const RIGHT_MARGIN:Number = 20;
		private const BOTTOM_MARGIN:Number = 60;
		private const TOP_MARGIN:Number = 20;
		private const DOT_RADIUS:Number = 14;
		private const LEGEND_WIDTH_Y_AXIS:Number = 65;
		private const LEGEND_WIDTH_X_AXIS:Number = 20;
		private const Y_AXIS_NAME_WIDTH:Number = 20;
		private const X_AXIS_NAME_HEIGHT:Number = 20;
		private const BUTTON_WIDTH:Number = WsConsts.CLOSE_BUTTON_WIDTH;
		private const BUTTON_HEIGHT:Number = WsConsts.CLOSE_BUTTON_HEIGHT;
		private const DOT_COLOR_ARRAY:Array = [WsConsts.PURPLE_COLOR,
																					 WsConsts.BLUE_COLOR,
																					 WsConsts.GREEN_COLOR,
																					 WsConsts.RED_COLOR];

		private var data:WsData;
		private var w:Number;
		private var h:Number;
		private var unitX:Number;
		private var unitY:Number;
		private var container:Sprite;
		private var resetBtn:Button;
		private var addScoresBtn:Button;

    public function WsEcoScore(x:Number, yTop:Number,
															 w:Number, h:Number,
															 data:WsData, view:WsView) {
			super(x, yTop, 400, 400, w, h, view);
			this.data = data;
			this.createResetBtn();
			this.createAddScoresBtn();
			this.updateCalculationData(w, h);
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);

			handleContextMenu();
			drawScoreInfo();
			super.addResizeIconAndFrame();
		}
		
		override public function resizeDone():void {
			this.updateCalculationData(super.width, super.height);
			drawScoreInfo();
		}
		
		override protected function closeBtnClickedHandling():void {
			closeEcoScore(null);
		}
		
		private function drawScoreInfo():void {
			var idx:int = this.numChildren;
			if (container && container.parent) {
			  idx = this.getChildIndex(container);
				removeChild(container);
			}
			container = new Sprite();
			drawCoordinates();
			drawDots();
			addChildAt(container, idx);
			if (!this.resetBtn.parent)
				addChild(resetBtn);
			resetBtn.move(super.closeBtn.x, super.closeBtn.y + super.closeBtn.height + 10);
			if (!this.addScoresBtn.parent)
				addChild(this.addScoresBtn);
			this.addScoresBtn.move(this.resetBtn.x, this.resetBtn.y + this.resetBtn.height + 10);
		}
		
		private function updateCalculationData(wNew:Number, hNew:Number):void {
			this.w = wNew > super.minWidth ? wNew : super.minWidth;
			this.h = hNew > super.minHeight ? hNew : super.minHeight;
			this.unitX = (this.w - LEFT_MARGIN - LEGEND_WIDTH_Y_AXIS - Y_AXIS_NAME_WIDTH - RIGHT_MARGIN) / MAX_NUM_X;
			this.unitY = (this.h - BOTTOM_MARGIN - TOP_MARGIN) / MAX_NUM_Y;
		}
		
    private function drawDots():void {
			var scores:Number;
			var x:Number;
			var dollars:Number;
			var y:Number;
			var box:Shape;
			var color:uint;
			var colorLength:uint = this.DOT_COLOR_ARRAY.length;
			for (var i:uint = 0; i < this.data.ecoDots.length; i++) {
				scores = this.data.ecoDots[i].scores;
				x = xPos + LEFT_MARGIN + Y_AXIS_NAME_WIDTH + LEGEND_WIDTH_Y_AXIS +
						scores * unitX / UNIT_X;
				dollars = this.data.ecoDots[i].dollars;
				y = yTop + h - BOTTOM_MARGIN - dollars * unitY / UNIT_Y;
				box = new Shape();
				color = this.DOT_COLOR_ARRAY[i % colorLength];
				box.graphics.lineStyle(1, color, 1,
															 false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
				box.graphics.beginFill(color);
				box.graphics.drawCircle(x, y, DOT_RADIUS);
				box.graphics.endFill();
				container.addChild(box);
				WsUtils.setupTextFieldC4(container,
																 this.data.ecoDots[i].initial(),
																 x, y - 12, 14, 20,
																 16, true).textColor = WsConsts.CORN_COLOR;
			}
		}
		
		private function drawCoordinates():void {
			WsUtils.setupBackground(container,
															WsConsts.PALE_GREEN_COLOR, 1,
															xPos, yTop, w, h);
			// draw the vertical line;
			var leftOffset:Number = LEFT_MARGIN + Y_AXIS_NAME_WIDTH + LEGEND_WIDTH_Y_AXIS;
			var xBase:Number = xPos + leftOffset;
			var yBase:Number = yTop + h - BOTTOM_MARGIN;
			var line:Shape = new Shape();
			line.graphics.lineStyle(2, WsConsts.BLACK_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			line.graphics.moveTo(xBase, yTop);
			line.graphics.lineTo(xBase, yBase);
			// draw the horizontal line;
			line.graphics.moveTo(xBase, yBase);
			line.graphics.lineTo(xPos + w, yBase);
			container.addChild(line);
			// draw legends on x axis
			var xx:Number;
			for (var i:int = 0; i <= MAX_NUM_X; i++) {
				xx = xBase + i * unitX;
				WsUtils.setupTextFieldC4(container,
																 String(i),
																 xx,
																 yBase,
																 LEGEND_WIDTH_X_AXIS, 16,
																 12, true);
			}
			// draw x axis name;
			var wName:Number = w - leftOffset - RIGHT_MARGIN;
			WsUtils.setupTextFieldC4(container,
															 WsConsts.TOTAL_ECOSYSTEM_SERVICES_SCORE_NAME,
															 xBase + wName / 2,
															 yTop + h - 30,
															 wName, 20,
															 14, true);
			// draw legends on y axis
			var yy:Number;
			for (i = 0; i <= MAX_NUM_Y; i++) {
				yy = yBase - i * unitY;
				WsUtils.setupTextFieldR2(container,
																 "$" + String(Math.round(i * UNIT_Y)),
																 xPos + LEFT_MARGIN + Y_AXIS_NAME_WIDTH,
																 yy - 10,
																 LEGEND_WIDTH_Y_AXIS - 7, 16,
																 12, true);
			}
			// draw y axis name
			WsUtils.setupTextFieldC3(container,
															 WsConsts.TOTAL_DOLLARS_FROM_CROPS_NAME,
															 xPos + LEFT_MARGIN, yBase,
															 h - TOP_MARGIN - BOTTOM_MARGIN, Y_AXIS_NAME_WIDTH,
															 14, true);
		}
		
		private function handleContextMenu():void {
			var myCM:ContextMenu = new ContextMenu();
			myCM.hideBuiltInItems();
			var myCMI = new ContextMenuItem(WsConsts.CLOSE_ECO_SCORE_NAME);
			myCM.customItems.push(myCMI);

			myCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, closeEcoScore);
			this.contextMenu = myCM;
		}
		
		private function closeEcoScore(e:ContextMenuEvent):void {
			dispatchEvent(new WsEvent(WsEvent.CLOSE_ECO_SCORE, true));
		}
		
		private function createResetBtn():void {
			this.resetBtn = new Button();
			resetBtn.label = WsConsts.RESET_NAME;
			resetBtn.setSize(BUTTON_WIDTH, BUTTON_HEIGHT);
			resetBtn.addEventListener(MouseEvent.CLICK, resetBtnClicked, false, 0, true);
		}
		
		private function resetBtnClicked(e:MouseEvent):void {
			this.data.resetEcoDots();
			dispatchEvent(new WsEvent(WsEvent.CLOSE_ECO_SERVICE, true));
			dispatchEvent(new WsEvent(WsEvent.ADD_ECO_SCORE, true));
		}
		
		private function createAddScoresBtn():void {
			this.addScoresBtn = new Button();
			addScoresBtn.label = WsConsts.ADD_SCORES_NAME;
			addScoresBtn.setSize(BUTTON_WIDTH, BUTTON_HEIGHT);
			addScoresBtn.addEventListener(MouseEvent.CLICK, addScoresBtnClicked, false, 0, true);
		}
		
		private function addScoresBtnClicked(e:MouseEvent):void {
			dispatchEvent(new WsEvent(WsEvent.ADD_ADD_SCORES, true));
		}
  }
}
