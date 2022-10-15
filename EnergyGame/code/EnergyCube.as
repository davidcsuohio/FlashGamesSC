package code {

  import flash.display.*;
  import flash.geom.*;
	import flash.events.*;

  public class EnergyCube extends Sprite {

    protected var data:EnergyData;
		protected var xPos:Number;
		// top-left point of the front side
		protected var yPos:Number;
		protected var cubeWidth:Number;
		protected var cubeHeight:Number;
		protected var cubeDeltaX:Number;
		protected var cubeDeltaY:Number;
		protected var logo:MovieClip;
		protected var container:Sprite;
		protected var frontSiblings:int;

    public function EnergyCube(data:EnergyData,
															 x:Number,
															 yBase:Number,
															 cubeWidth:Number,
															 cubeHeight:Number,
															 cubeDeltaX:Number,
															 cubeDeltaY:Number,
															 logo:MovieClip) {
			this.data = data;
			xPos = x;
			this.cubeWidth = cubeWidth;
			this.cubeHeight = cubeHeight;
			this.cubeDeltaX = cubeDeltaX;
			this.cubeDeltaY = cubeDeltaY;
			yPos = yBase - cubeHeight;
			this.logo = logo;
			frontSiblings = 0;
			container = null;
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    protected function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			drawCube();
    }

    protected function drawCube():void {
			// 25 (for title), 10 x 10 for diagonal lines
			drawBackAndLeftLines(yPos, cubeHeight);
			drawLogo(logo, yPos, cubeHeight);
			drawFrontAndRightLines(yPos, cubeHeight);
		}
		
    public function updateUsage(vHeight:Number, color:uint):void {
			clearContainer();
			this.container = new Sprite();

      drawBar(yPos + cubeHeight - vHeight, vHeight, color);
			
			addChildAt(this.container, numChildren - frontSiblings);
		}

    protected function drawLogo(mc:MovieClip, yTop:Number, h:Number):void {
			mc.x = xPos + (cubeWidth + cubeDeltaX - mc.width) / 2;
			mc.y = yTop + (h - mc.height) / 2;
			addChild(mc);
			frontSiblings++;
		}
		
    protected function drawBackAndLeftLines(yTop:Number, h:Number):void {
			var line:Shape = new Shape();
			line.graphics.lineStyle(2, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			line.graphics.drawRect(xPos + cubeDeltaX, yTop - cubeDeltaY, cubeWidth, h);
			line.graphics.moveTo(xPos, yTop + h);
			line.graphics.lineTo(xPos + cubeDeltaX, yTop + h - cubeDeltaY);
			line.graphics.moveTo(xPos, yTop);
			line.graphics.lineTo(xPos + cubeDeltaX, yTop - cubeDeltaY);
			addChild(line);
		}
		
		protected function drawFrontAndRightLines(yTop:Number, h:Number):void {
			var line:Shape = new Shape();
			line.graphics.lineStyle(2, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			line.graphics.drawRect(xPos, yTop, cubeWidth, h);
			line.graphics.moveTo(xPos + cubeWidth, yTop);
			line.graphics.lineTo(xPos + cubeWidth + cubeDeltaX, yTop - cubeDeltaY);
			line.graphics.moveTo(xPos + cubeWidth, yTop + h);
			line.graphics.lineTo(xPos + cubeWidth + cubeDeltaX, yTop + h - cubeDeltaY);
			addChild(line);
			frontSiblings++;
		}
		
    protected function drawFrontAndRight(yTop:Number, h:Number, color:uint):void {
			var box:Shape = new Shape();
			box.graphics.lineStyle(2, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			box.graphics.beginFill(color);
			box.graphics.drawRect(xPos, yTop, cubeWidth, h);
			box.graphics.moveTo(xPos + cubeWidth, yTop);
			box.graphics.lineTo(xPos + cubeWidth, yTop + h);
			box.graphics.lineTo(xPos + cubeWidth + cubeDeltaX, yTop + h - cubeDeltaY);
			box.graphics.lineTo(xPos + cubeWidth + cubeDeltaX, yTop - cubeDeltaY);
			box.graphics.lineTo(xPos + cubeWidth, yTop);
			box.graphics.endFill();
			container.addChild(box);
		}
		
    protected function drawTop(yTop:Number, color:uint):void {
			var box:Shape = new Shape();
			box.graphics.lineStyle(2, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			box.graphics.beginFill(color);
			box.graphics.moveTo(xPos, yTop);
			box.graphics.lineTo(xPos + cubeWidth, yTop);
			box.graphics.lineTo(xPos + cubeWidth + cubeDeltaX, yTop - cubeDeltaY);
			box.graphics.lineTo(xPos + cubeDeltaX, yTop - cubeDeltaY);
			box.graphics.lineTo(xPos, yTop);
			box.graphics.endFill();
			container.addChild(box);
		}

    protected function drawBar(yTop:Number, h:Number, color:uint):void {
			if (h > 1.0) {
				drawFrontAndRight(yTop, h, color);
			}
			drawTop(yTop, color);
		}
		
		protected function clearContainer():void {
		  if (container && container.parent) {
				removeChild(container);
			}
		}
  }
}