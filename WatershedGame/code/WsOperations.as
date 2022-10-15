package code {
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.MouseCursor;
	
	public class WsOperations extends Sprite{
		
		private const BUTTON_WIDTH:Number = 100;
		private const BUTTON_HEIGHT:Number = 30;
		private const BUTTON_GAP_Y:Number = 10;
		private const RESET_BTN_X:Number = 0;
		private const RESET_BTN_Y:Number = 0;
		private const SUBMIT_BTN_X:Number = 0;
		private const SUBMIT_BTN_Y:Number = RESET_BTN_Y + BUTTON_HEIGHT + BUTTON_GAP_Y;
		
		private var xPos:Number;
		private var yPos:Number;
		private var resetBtn:WsOpButton;
		private var submitBtn:WsOpButton;
		
		public function WsOperations(x:Number, y:Number) {
			this.xPos = x;
			this.yPos = y;
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
		}

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			setupButtons();
		}
		
		private function setupButtons():void {
			// setup reset button
			this.resetBtn = new WsOpButton();
			this.resetBtn.move(xPos + this.RESET_BTN_X, yPos + this.RESET_BTN_Y);
			this.resetBtn.setSize(this.BUTTON_WIDTH, this.BUTTON_HEIGHT);
			this.resetBtn.label = WsConsts.RESET_NAME;
			this.resetBtn.addEventListener(MouseEvent.CLICK, resetClickHandler, false, 0, true);
			addChild(this.resetBtn);
			// setup submit button
			this.submitBtn = new WsOpButton();
			this.submitBtn.move(xPos + this.SUBMIT_BTN_X, yPos + this.SUBMIT_BTN_Y);
			this.submitBtn.setSize(this.BUTTON_WIDTH, this.BUTTON_HEIGHT);
			this.submitBtn.label = WsConsts.SUBMIT_NAME;
			this.submitBtn.addEventListener(MouseEvent.CLICK, submitClickHandler, false, 0, true);
			addChild(this.submitBtn);
		}
		
		private function resetClickHandler(e:MouseEvent):void {
			this.setPrevCursor();
			this.dispatchEvent(new WsEvent(WsEvent.RESET_LANDUSE, true));
		}
		
		private function submitClickHandler(e:MouseEvent):void {
			this.setPrevCursor();
			this.dispatchEvent(new WsEvent(WsEvent.SUBMIT_LANDUSE, true));
		}
		
		private function setPrevCursor():void {
			this.resetBtn.setPrevCursor(MouseCursor.AUTO);
			this.submitBtn.setPrevCursor(MouseCursor.AUTO);
		}
	}
	
}
