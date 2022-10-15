package code {

  import flash.display.*;
	import flash.events.*;
	import flash.ui.*;

  public class WsLegend extends Sprite {

		private var xPos:Number;
		private var yPos:Number;
		private var w:Number;
		private var h:Number;
		private var _color:uint;
		private var cursor:String;
		private var prevCursor:String;

    public function WsLegend(x:Number, y:Number, w:Number, h:Number, color:uint, cursor:String) {
			this.xPos = x;
			this.yPos = y;
			this.w = w;
			this.h = h;
			this._color = color;
			this.cursor = cursor;
			this.prevCursor = MouseCursor.IBEAM;

			addEventListener(Event.ADDED, setupChildren, false, 0, true);
			addEventListener(MouseEvent.CLICK, mouseClickHandler, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true);
    }
		
		public function get color():uint {
			return this._color;
		}

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			drawLegend();
		}
		
		private function drawLegend():void {
			this.graphics.lineStyle(2, WsConsts.STEEL_BLUE_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			this.graphics.beginFill(this.color);
			this.graphics.drawRect(xPos, yPos, w, h);
			this.graphics.endFill();
		}
		
		private function mouseClickHandler(e:MouseEvent):void {
			e.stopPropagation();
			Mouse.cursor = this.cursor;
			this.prevCursor = Mouse.cursor;
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			if (Mouse.cursor == this.cursor)
				return;
			if (Mouse.cursor != MouseCursor.HAND) {
				this.prevCursor = Mouse.cursor;
				Mouse.cursor = MouseCursor.HAND;
			}
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			Mouse.cursor = this.prevCursor;
		}
		
  }
}
