package code {
	
	import flash.display.*;
	import fl.controls.*;
	import flash.text.*;
	import flash.events.*;

  public class WsSlope extends Sprite {
		
		private const MARGIN:Number = 10;
		private const TITLE_WIDTH:Number = 30;
		private const LEGEND_WIDTH_Y_AXIS:Number = 30;
		// including SLOPE and 0, 10
		private const LEGEND_HEIGHT_X_AXIS:Number = 30;

		private var xPos:Number;
		private var yBottom:Number;
		private var wGraph:Number;
		private var hGraph:Number;
		private var title:String;
		private var origX:Number;
		private var origY:Number;
		
		public function WsSlope(x:Number, yBottom:Number, w:Number, h:Number,
														title:String) {
			this.xPos = x + MARGIN;
			this.yBottom = yBottom - MARGIN;
			this.wGraph = w - MARGIN * 2;
			this.hGraph = h - MARGIN * 2;
			this.title = title;
			this.origX = xPos + TITLE_WIDTH + LEGEND_WIDTH_Y_AXIS;
			this.origY = yBottom - LEGEND_HEIGHT_X_AXIS;
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			// draw the title;
			WsUtils.setupTextFieldL4(this, this.title,
															 xPos, origY, hGraph, TITLE_WIDTH,
															 14, true);
			// draw legends on y axis;
			var yTop:Number = yBottom - hGraph - MARGIN;
			WsUtils.setupTextFieldR2(this, WsConsts.LOW_NAME,
															 xPos + TITLE_WIDTH, origY - 10,
															 LEGEND_WIDTH_Y_AXIS, 16,
															 12, true);
			WsUtils.setupTextFieldR2(this, WsConsts.HIGH_NAME,
															 xPos + TITLE_WIDTH, yTop - 10,
															 LEGEND_WIDTH_Y_AXIS, 16,
															 12, true);
			// draw legends on x asix;
			WsUtils.setupTextFieldC4(this, "0",
															 origX, origY, 10, 16,
															 12, true);
			var xRight:Number = xPos + wGraph;
			WsUtils.setupTextFieldC4(this, "10",
															 xRight, origY, 10, 16,
															 12, true);
			WsUtils.setupTextFieldC4(this, WsConsts.SLOPE_NAME,
															 (origX + xRight) / 2, origY + 7, (xRight - origX) / 2, 16,
															 12, true);
			// draw x and y axises;
			this.graphics.lineStyle(1, WsConsts.BLACK_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			this.graphics.moveTo(origX, yTop);
			this.graphics.lineTo(origX, origY + 5);
			this.graphics.moveTo(origX, origY);
			this.graphics.lineTo(xRight, origY);
			this.graphics.moveTo(xRight, origY - 5);
			this.graphics.lineTo(xRight, origY + 5);
			var ww:Number = xRight - origX;
			var hh:Number = origY - yTop;
			// draw the soybeans curve and legend;
			this.graphics.lineStyle(1, WsConsts.SOY_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			this.graphics.moveTo(origX, origY);
			this.graphics.curveTo(origX + ww * 0.5, origY - hh * 0.4, origX + ww * 0.7, origY - hh);
			WsUtils.setupTextFieldL2(this, WsConsts.SOYBEANS_NAME,
															 origX + ww * 0.7, origY - hh - 9,
															 50, 16,
															 12, true);
			// draw the corn curve and legend;
			this.graphics.lineStyle(1, WsConsts.CORN_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			this.graphics.moveTo(origX, origY);
			this.graphics.curveTo(origX + ww * 0.6, origY - hh * 0.3, origX + ww * 0.8, origY - hh * 0.8);
			WsUtils.setupTextFieldL2(this, WsConsts.CORN_NAME,
															 origX + ww * 0.8, origY - hh * 0.8 - 9,
															 50, 16,
															 12, true);
			// draw the hay curve and legend;
			this.graphics.lineStyle(1, WsConsts.HAY_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			this.graphics.moveTo(origX, origY);
			this.graphics.curveTo(origX + ww * 0.5, origY - hh * 0.1, origX + ww * 0.9, origY - hh * 0.3);
			WsUtils.setupTextFieldL2(this, WsConsts.HAY_NAME,
															 origX + ww * 0.9, origY - hh * 0.3 - 9,
															 50, 16,
															 12, true);
			// draw the forest curve and legend;
			this.graphics.lineStyle(1, WsConsts.FOREST_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			this.graphics.moveTo(origX, origY);
			this.graphics.curveTo(origX + ww * 0.5, origY - hh * 0.05, origX + ww * 0.9, origY - hh * 0.1);
			WsUtils.setupTextFieldL2(this, WsConsts.FOREST_NAME,
															 origX + ww * 0.9, origY - hh * 0.1 - 9,
															 50, 16,
															 12, true);
		}
		
	}
}