package code {

	import fl.controls.Button;
	import fl.controls.ScrollBar;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import fl.events.ScrollEvent;

  public class WsAddScores extends WsResizeComponent {

		private const LEFT_MARGIN:Number = 10;
		private const RIGHT_MARGIN:Number = 10;
		private const BOTTOM_MARGIN:Number = 10;
		private const TOP_MARGIN:Number = 10;
		private const INTER_GAP:Number = 10;
		private const TABLE_HEADER_HEIGHT:Number = 40;  //20
		private const BUTTON_WIDTH:Number = WsConsts.CLOSE_BUTTON_WIDTH;
		private const BUTTON_HEIGHT:Number = WsConsts.CLOSE_BUTTON_HEIGHT;
		private const BUTTON_ROW_HEIGHT:Number = BUTTON_HEIGHT + INTER_GAP;
		private const CELL_HEIGHT:Number = 40;  //20 //30
		private const TABLE_HEADER_FONT_SIZE:Object = 18;  //14

		private var data:WsData;
		private var ww:Number;
		private var hh:Number;
		private var xTable:Number;
		private var yTable:Number;
		private var wTable:Number;
		private var hTable:Number;
		private var container:Sprite;
		private var containerTable:Sprite;
		private var submitBtn:Button;
		private var addNewItemBtn:Button;
		private var uiRows:Vector.<WsAddScoreRow>;
		private var pendingRows:Vector.<WsAddScoreRow>;
		private var scrollBar:ScrollBar;
		private var pageSize:Number;
		private var itemsToDisplay:uint;

    public function WsAddScores(x:Number, yTop:Number,
															  w:Number, h:Number,
															  data:WsData, view:WsView) {
			super(x, yTop, 400, 400, w, h, view);
			this.data = data;
			this.uiRows = new Vector.<WsAddScoreRow>();
			this.pendingRows = new Vector.<WsAddScoreRow>();
			this.createSubmitBtn();
			this.createAddNewItemBtn();
			this.createScrollBar();
			this.updateCalculationData(w, h);
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
			addEventListener(WsEvent.ADD_NEW_ITEM, addNewItem, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);

			// create an empty row in pendingRows
			// it will be placed as the last line in drawTableAndScrollBar()
			var emptyRow:WsAddScoreRow = new WsAddScoreRow(xTable, yTable, wTable / 3, this.CELL_HEIGHT);
			this.pendingRows.push(emptyRow);
			drawContents();
			super.addResizeIconAndFrame();
			stage.focus = emptyRow.initialTF;
		}
		
		override public function resizeDone():void {
			this.updateCalculationData(super.width, super.height);
			drawContents();
		}
		
		override protected function closeBtnClickedHandling():void {
			dispatchEvent(new WsEvent(WsEvent.CLOSE_ADD_SCORES, true));
		}
		
		private function drawContents():void {
			var idx:int = this.numChildren;
			if (container && container.parent) {
			  idx = this.getChildIndex(container);
				if (containerTable && containerTable.parent)
					container.removeChild(containerTable);
				removeChild(container);
			}
			container = new Sprite();
			drawBgAndTableHeader();
			drawTableAndScrollBar();
			addChildAt(container, idx);
			if (!this.submitBtn.parent)
				addChild(this.submitBtn);
			submitBtn.move(super.xPos + this.ww - this.RIGHT_MARGIN - this.submitBtn.width - this.INTER_GAP,
										 super.yTop + this.hh - this.BOTTOM_MARGIN - this.submitBtn.height);
			if (!this.addNewItemBtn.parent)
				addChild(this.addNewItemBtn);
			addNewItemBtn.move(this.submitBtn.x - this.INTER_GAP - this.addNewItemBtn.width,
												 this.submitBtn.y);
		}
		
		private function updateCalculationData(wNew:Number, hNew:Number):void {
			this.ww = wNew > super.minWidth ? wNew : super.minWidth;
			this.hh = hNew > super.minHeight ? hNew : super.minHeight;
			this.xTable = super.xPos + this.LEFT_MARGIN;
			this.yTable = super.yTop + this.TOP_MARGIN + this.BUTTON_ROW_HEIGHT + this.TABLE_HEADER_HEIGHT;
			this.wTable = this.ww - this.LEFT_MARGIN - this.RIGHT_MARGIN - ScrollBar.WIDTH;
			this.hTable = this.hh - this.TOP_MARGIN - this.BOTTOM_MARGIN - this.TABLE_HEADER_HEIGHT - this.BUTTON_ROW_HEIGHT * 2;
			this.itemsToDisplay = uint(Math.floor(hTable / this.CELL_HEIGHT));
			this.pageSize = this.CELL_HEIGHT * this.itemsToDisplay;
		}
		
    private function drawBgAndTableHeader():void {
			// draw background;
			WsUtils.setupBackground(this.container,
															WsConsts.ADD_SCORE_BG_COLOR, 1,
															super.xPos, super.yTop, this.ww, this.hh);
			// draw table header;
			var wCell:Number = this.wTable / 3;
			var yDelta:Number = (this.TABLE_HEADER_HEIGHT - Number(this.TABLE_HEADER_FONT_SIZE) - 8) / 2;
			if (yDelta < 0)
				yDelta = 0;
			var yy:Number = this.yTable - this.TABLE_HEADER_HEIGHT + yDelta;											
			WsUtils.setupTextFieldC2(this.container,
															 WsConsts.INITIAL_NAME,
															 this.xTable, yy,
															 wCell, this.TABLE_HEADER_HEIGHT,
															 TABLE_HEADER_FONT_SIZE, true);
			WsUtils.setupTextFieldC2(this.container,
															 WsConsts.DOLLARS_NAME,
															 this.xTable + wCell, yy,
															 wCell, this.TABLE_HEADER_HEIGHT,
															 TABLE_HEADER_FONT_SIZE, true);
			WsUtils.setupTextFieldC2(this.container,
															 WsConsts.ESS_SCORE_NAME,
															 this.xTable + wCell * 2, yy,
															 wCell, this.TABLE_HEADER_HEIGHT,
															 TABLE_HEADER_FONT_SIZE, true);
		}
		
		private function drawTableAndScrollBar():void {
			// build uiRows first
			uiRows = new Vector.<WsAddScoreRow>();
			var i:uint;
			var asr:WsAddScoreRow;
			var dot:WsDataDot;
			var xx:Number = this.xTable;
			var yy:Number;
			var wTF:Number = this.wTable / 3;
			var dotsLength:uint = this.data.ecoDots.length;
			for (i = 0; i < dotsLength; i++) {
				dot = this.data.ecoDots[i];
				yy = this.yTable + i * this.CELL_HEIGHT;
				asr = new WsAddScoreRow(xx, yy, wTF, this.CELL_HEIGHT, true);
				asr.initialTF.text = dot.initial();
				asr.dollarsTF.text = dot.dollars.toString();
				asr.scoresTF.text = dot.scores.toString();
				uiRows.push(asr);
			}
			for (i = 0; i < pendingRows.length; i++) {
				yy = this.yTable + (dotsLength + i) * this.CELL_HEIGHT;
				pendingRows[i].updateContents(xx, yy, wTF, this.CELL_HEIGHT);
				uiRows.push(pendingRows[i]);
			}
	
			// always add it to bring the scrollbar to top;
			container.addChild(this.scrollBar);
			scrollBar.setSize(ScrollBar.WIDTH, pageSize);
			scrollBar.move(this.xTable + this.wTable, this.yTable);
			var content:Number = uiRows.length * this.CELL_HEIGHT;
			if (this.pageSize < content) {
				scrollBar.enabled = true;
				scrollBar.setScrollProperties(pageSize, 0, content - this.pageSize);
				this.drawTable(uiRows.length - this.itemsToDisplay);
				// this will call scrollHandler to scroll to the end;
				// note: the scrollHandler won't get called when the graph enlarge;
				scrollBar.scrollPosition = scrollBar.maxScrollPosition;
			}
			else {
				scrollBar.enabled = false;
				this.drawTable(0);
			}
		}
		
		private function createSubmitBtn():void {
			this.submitBtn = new Button();
			submitBtn.label = WsConsts.SUBMIT_NAME;
			submitBtn.setSize(BUTTON_WIDTH, BUTTON_HEIGHT);
			submitBtn.addEventListener(MouseEvent.CLICK, submitBtnClicked, false, 0, true);
		}
		
		private function submitBtnClicked(e:MouseEvent):void {
			var name:String;
			var dollars:String;
			var scores:String;
			var dot:WsDataDot;
			var serialNo:int;
			for (var i:uint = 0; i < pendingRows.length; i++) {
				this.data.addEcoDotWithName(pendingRows[i].initialTF.text,
																		pendingRows[i].dollarsTF.text,
																		pendingRows[i].scoresTF.text);
			}
			dispatchEvent(new WsEvent(WsEvent.ADD_ECO_SCORE, true));
			dispatchEvent(new WsEvent(WsEvent.CLOSE_ADD_SCORES, true));
		}
		
		private function createAddNewItemBtn():void {
			this.addNewItemBtn = new Button();
			addNewItemBtn.label = WsConsts.ADD_NEW_ITEM_NAME;
			addNewItemBtn.setSize(BUTTON_WIDTH, BUTTON_HEIGHT);
			addNewItemBtn.addEventListener(MouseEvent.CLICK, addNewItemBtnClicked, false, 0, true);
		}
		
		private function addNewItemBtnClicked(e:MouseEvent):void {
			this.addNewItem(null);
		}
		
		// build uiRows whenever a new item is added - could be improved in the future;
		private function addNewItem(e:Event):void {
			var xx:Number = this.xTable;
			var yy:Number = this.yTable + this.uiRows.length * this.CELL_HEIGHT;
			var wTF:Number = this.wTable / 3;
			var row:WsAddScoreRow = new WsAddScoreRow(xx, yy, wTF, this.CELL_HEIGHT);
			this.pendingRows.push(row);
			this.drawTableAndScrollBar();
			stage.focus = row.initialTF;
		}

		private function createScrollBar():void {
			this.scrollBar = new ScrollBar();
			this.scrollBar.lineScrollSize = this.CELL_HEIGHT;
			this.scrollBar.addEventListener(ScrollEvent.SCROLL, scrollHandler, false, 0, true);
		}
		
		private function scrollHandler(e:ScrollEvent):void {
			if (uiRows.length <= this.itemsToDisplay)
				return;
			var percent:Number = e.position / (scrollBar.maxScrollPosition - scrollBar.minScrollPosition);
			var startIdx:uint = Math.round((uiRows.length - this.itemsToDisplay) * percent);
			this.drawTable(startIdx);
		}
		
		private function drawTable(startIdx:uint):void {
			var endIdx:uint = uiRows.length <= startIdx + this.itemsToDisplay ?
													uiRows.length : startIdx + this.itemsToDisplay;
			if (containerTable && containerTable.parent)
				container.removeChild(containerTable);
			containerTable = new Sprite();
			var j:int = 0;
			var xx:Number = xTable;
			var yy:Number;
			var wTF:Number = wTable / 3;
			for (var i:uint = startIdx; i < endIdx; i++) {
				yy = this.yTable + j * this.CELL_HEIGHT;
				uiRows[i].updateContents(xx, yy, wTF, this.CELL_HEIGHT);
				containerTable.addChild(uiRows[i]);
				j++;
			}
			container.addChild(containerTable);
		}
  }
}
