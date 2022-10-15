package code {
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;

  public class WsAddScoreRow extends Sprite {
		
		private const FONT_SIZE:Object = 16;  //12

		private var _initialTF:TextField;
		private var _dollarsTF:TextField;
		private var _scoresTF:TextField;
		private var rectInitial:Rectangle;
		private var rectDollars:Rectangle;
		private var rectScores:Rectangle;
		private var container:Sprite;
		private var bReadOnly:Boolean;

		// this class cannot use Event.ADDED;
    public function WsAddScoreRow(xPos:Number, yPos:Number,
															    wTF:Number, hTF:Number,
																	bReadOnly:Boolean=false) {
			this.bReadOnly = bReadOnly;
			updateRects(xPos, yPos, wTF, hTF);
			addEventListener(MouseEvent.CLICK, mouseClicked, false, 0, true);
			addEventListener(KeyboardEvent.KEY_DOWN, keyboardKeydowned, false, 0, true);
			
			setupContents();
		}
		
		public function updateContents(xPos:Number, yPos:Number,
																	 wTF:Number, hTF:Number):void {
			updateRects(xPos, yPos, wTF, hTF);
			this.drawBgBorder();
			// update three TextFields;
			this._initialTF.x = this.rectInitial.x;
			this._initialTF.y = this.rectInitial.y +
										(this.rectInitial.height - this._initialTF.getBounds(container).height) / 2;
			this._initialTF.width = this.rectInitial.width;
			this._initialTF.height = this.rectInitial.height;
			container.addChild(this._initialTF);
			this._dollarsTF.x = this.rectDollars.x;
			this._dollarsTF.y = this.rectDollars.y + 
										(this.rectDollars.height - this._dollarsTF.getBounds(container).height) / 2;
			this._dollarsTF.width = this.rectDollars.width;
			this._dollarsTF.height = this.rectDollars.height;
			container.addChild(this._dollarsTF);
			this._scoresTF.x = this.rectScores.x;
			this._scoresTF.y = this.rectScores.y +
			        			(this.rectScores.height - this._scoresTF.getBounds(container).height) / 2;
			this._scoresTF.width = this.rectScores.width;
			this._scoresTF.height = this.rectScores.height;
			container.addChild(this._scoresTF);
		}
		
		public function get initialTF():TextField {
			return this._initialTF;
		}
		
		public function get dollarsTF():TextField {
			return this._dollarsTF;
		}
		
		public function get scoresTF():TextField {
			return this._scoresTF;
		}
		
		private function setupContents():void {
			drawBgBorder();
			// setup three TextFields															
			this._initialTF = new TextField();
			WsUtils.setupTextFieldC1(container, this._initialTF,
															 rectInitial.x, rectInitial.y,
															 rectInitial.width, rectInitial.height,
															 FONT_SIZE, true);
			if (!this.bReadOnly) {
				this._initialTF.type = TextFieldType.INPUT;
				this._initialTF.selectable = true;
				this._initialTF.restrict = "A-Z a-z";
			}
			this._dollarsTF = new TextField();
			WsUtils.setupTextFieldC1(container, this._dollarsTF,
															 rectDollars.x, rectDollars.y,
															 rectDollars.width, rectDollars.height,
															 FONT_SIZE, true);
			if (!this.bReadOnly) {
				this._dollarsTF.type = TextFieldType.INPUT;
				this._dollarsTF.selectable = true;
				this._dollarsTF.restrict = "0-9";
			}
			this._scoresTF = new TextField();
			WsUtils.setupTextFieldC1(container, this._scoresTF,
															 rectScores.x, rectScores.y,
															 rectScores.width, rectScores.height,
															 FONT_SIZE, true);
			if (!this.bReadOnly) {
				this._scoresTF.type = TextFieldType.INPUT;
				this._scoresTF.selectable = true;
				this._scoresTF.restrict = "0-9 .";
			}
    }
		
		private function drawBgBorder():void {
			if (container && container.parent)
				removeChild(container);
			container = new Sprite();
			// draw the backgrould;
			var bgColor:uint = this.bReadOnly ? WsConsts.LIGHT_GREY_COLOR : WsConsts.WHITE_COLOR;
			WsUtils.setupBackground(container, bgColor, 1,
															rectInitial.x, rectInitial.y,
															rectInitial.width + rectDollars.width + rectScores.width,
															rectInitial.height);
			// draw three rectangles;
			var box:Shape = new Shape;
			box.graphics.lineStyle(1, WsConsts.BLACK_COLOR, 1,
														 false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			box.graphics.drawRect(rectInitial.x, rectInitial.y, rectInitial.width, rectInitial.height);
			box.graphics.drawRect(rectDollars.x, rectDollars.y, rectDollars.width, rectDollars.height);
			box.graphics.drawRect(rectScores.x, rectScores.y, rectScores.width, rectScores.height);
			container.addChild(box);
			addChild(container);
		}
		
		private function mouseClicked(e:MouseEvent):void {
			if (rectInitial.contains(e.stageX, e.stageY)) {
				stage.focus = this._initialTF;
			}
			else if (rectDollars.contains(e.stageX, e.stageY)) {
				stage.focus = this._dollarsTF;
			}
			else if (rectScores.contains(e.stageX, e.stageY)) {
				stage.focus = this._scoresTF;
			}
		}
		
		private function keyboardKeydowned(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.RIGHT) {
				focusNextItem();
			}
			else if (e.keyCode == Keyboard.LEFT) {
				focusPrevItem();
			}
			else if (e.keyCode == Keyboard.ENTER) {
				if (this._initialTF.text.length != 0 &&
						this._dollarsTF.text.length != 0 &&
						this._scoresTF.text.length != 0) {
					dispatchEvent(new WsEvent(WsEvent.ADD_NEW_ITEM, true));
				}
			}
		}
		
		private function focusNextItem():Boolean {
			if (stage.focus == this._initialTF) {
				stage.focus = this._dollarsTF;
				return true;
			}
			else if (stage.focus == this._dollarsTF) {
				stage.focus = this._scoresTF;
				return true;
			}
			return false;
		}

		private function focusPrevItem():Boolean {
			if (stage.focus == this._dollarsTF) {
				stage.focus = this._initialTF;
				return true;
			}
			else if (stage.focus == this._scoresTF) {
				stage.focus = this._dollarsTF;
				return true;
			}
			return false;
		}

		private function updateRects(x:Number, y:Number, w:Number, h:Number):void {
			this.rectInitial = new Rectangle(x, y, w, h);
			this.rectDollars = new Rectangle(x + w, y, w, h);
			this.rectScores = new Rectangle(x + w * 2, y, w, h);
		}
	}
}