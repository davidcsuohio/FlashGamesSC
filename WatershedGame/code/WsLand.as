package code {

  import flash.display.*;
	import flash.events.*;
	import flash.ui.Mouse;
	import flash.text.TextField;

  public class WsLand extends Sprite {

		// coordinates of the use number characters;
		// based on the use number of each land (hru);
		private const USENUMBER_COORDS:Vector.<Number> = Vector.<Number>(
			//  0   ,    1   ,    2   ,    3   ,    4   ,    5   ,    6   ,    7
			[110,120, 160,95,  100,200, 230,160, 140,165, 300,225, 115,250, 210,290,
			//  8   ,    9   ,   10   ,   11   ,   12   ,   13   ,   14   ,   15
			 180,305, 180,360, 320,360, 125,380, 340,410, 90,395,  210,510, 250,330,
			//  16  ,   17   ,   18   ,   19   ,   20   ,   21   ,   22   ,   23
			 175,440, 175,155, 200,180, 180,240, 240,450, 220,195, 250,240, 285,510,
			//  24  ,   25   ,   26   ,   27
			 305,310, 275,370, 285,420, 317,500]);

		private var data:WsDataLand;
		private var xPos:Number;
		private var yPos:Number;
		private var prevColor:uint;

    public function WsLand(data:WsDataLand, x:Number, y:Number) {
			this.data = data;
			this.xPos = x;
			this.yPos = y;
			this.prevColor = WsConsts.WHITE_COLOR;
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			addEventListener(MouseEvent.CLICK, mouseClickHandler, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true);
			drawUseNumber();
			drawLand(this.data.color);
		}
		
		public function updateLanduse():void {
			this.drawLand(this.data.color);
		}
		
		private function drawUseNumber():void {
			var useNumber:Number = this.data.useNumber;
			WsUtils.setupTextFieldL2(this, String(useNumber),
															 xPos + USENUMBER_COORDS[useNumber * 2],
															 yPos + USENUMBER_COORDS[useNumber * 2 + 1],
															 20, 20,
															 16, true).textColor = WsConsts.WHITE_COLOR;
		}
		
		private function drawLand(color:uint):void {
			if (color == prevColor)
				return;
			prevColor = color;
			this.graphics.clear();
			var alpha:Number = 0.4;
			if (color == WsConsts.LANDUSE_UNUSE_COLOR)
				alpha = 0;
			this.graphics.lineStyle(2, WsConsts.RED_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			this.graphics.beginFill(color, alpha);
			var j:int = this.data.coordsIndex;
			var i:int;
			var commands:Vector.<int> = new Vector.<int>();
			for (i = 0; i < WsCoordConsts.WS_COORDS_LENGTHS[0][j] / 2; i++) {
				commands.push(WsCoordConsts.WS_COMMANDS[j][i]);
			}
			var coord:Vector.<Number> = new Vector.<Number>();
			for (i = 0; i < WsCoordConsts.WS_COORDS_LENGTHS[0][j]; i++) {
				if ((i & 1) == 0) {
					coord.push(xPos + WsConsts.PICTURE_X +
										 Math.round(WsCoordConsts.WS_COORDS[j][i] / WsCoordConsts.CANVAS_WIDTH * WsConsts.PICTURE_WIDTH * 100) / 100);
				}
				else {
					coord.push(yPos + WsConsts.PICTURE_Y +
										 Math.round(WsCoordConsts.WS_COORDS[j][i] / WsCoordConsts.CANVAS_HEIGHT * WsConsts.PICTURE_HEIGHT * 100) / 100);
				}
			}
			this.graphics.drawPath(commands, coord);
			this.graphics.endFill();
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			drawLand(WsUtils.getColorByCursor(Mouse.cursor));
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			var color:uint = this.data.color;
			drawLand(color);
		}
		
		private function mouseClickHandler(e:MouseEvent):void {
			e.stopPropagation();
			this.dispatchEvent(new WsEvent(WsEvent.CLEAR_ERROR_MSG, true));
			var color:uint = WsUtils.getColorByCursor(Mouse.cursor);
			drawLand(color);
			this.data.color = color;
		}
		
  }
}
