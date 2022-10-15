package code {
	
	import fl.controls.Button;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;

  public class WsOpButton extends WsButton {
		
		private var prevCursor:String;
		
		public function WsOpButton() {
			super();
			this.prevCursor = MouseCursor.IBEAM;

			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true);
		}
		
		public function setPrevCursor(cursor:String):void {
			this.prevCursor = cursor;
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			if (Mouse.cursor == MouseCursor.AUTO) {
				return;
			}
			else {
				this.prevCursor = Mouse.cursor;
				Mouse.cursor = MouseCursor.AUTO;
			}
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			Mouse.cursor = this.prevCursor;
		}
	}
}