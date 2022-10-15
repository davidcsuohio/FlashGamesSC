package code {
	
	import flash.display.*;
	import fl.controls.*;
	import flash.text.*;
	import flash.events.*;

  public class WsRelationship extends Sprite {
		
		private const MARGIN:Number = 10;
		private const TITLE_WIDTH:Number = 30;
		private const BAR_GAP:Number = 15;

		private var xPos:Number;
		private var yBottom:Number;
		private var wGraph:Number;
		private var hGraph:Number;
		private var title:String;
		private var cornPercent:Number;
		private var soyPercent:Number;
		private var hayPercent:Number;
		private var forestPercent:Number;
		
		public function WsRelationship(x:Number, yBottom:Number, w:Number, h:Number,
																	 title:String, cornPercent:Number,
																	 soyPercent:Number, hayPercent:Number,
																	 forestPercent:Number) {
			this.xPos = x + MARGIN;
			this.yBottom = yBottom - MARGIN;
			this.wGraph = w - MARGIN * 2;
			this.hGraph = h - MARGIN * 2;
			this.title = title;
			this.cornPercent = cornPercent;
			this.soyPercent = soyPercent;
			this.hayPercent = hayPercent;
			this.forestPercent = forestPercent;
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			var barW:Number = (wGraph - TITLE_WIDTH - BAR_GAP * 5) / 4;
			// draw the title;
			WsUtils.setupTextFieldL4(this, this.title,
															 xPos, yBottom, hGraph, TITLE_WIDTH,
															 14, true);
			this.graphics.lineStyle(1, WsConsts.BLACK_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			// draw x and y axises;
			var xx:Number = xPos + TITLE_WIDTH;
			this.graphics.moveTo(xx, yBottom - hGraph - MARGIN);
			this.graphics.lineTo(xx, yBottom);
			this.graphics.lineTo(xPos + wGraph + MARGIN, yBottom);
			// draw the corn;
			xx += BAR_GAP;
			var h:Number = this.cornPercent * this.hGraph;
			this.graphics.beginFill(WsConsts.CORN_COLOR);
			this.graphics.drawRect(xx, yBottom - h, barW, h);
			WsUtils.setupTextFieldL4(this, WsConsts.CORN_NAME,
															 xx, yBottom, hGraph, barW,
															 12, true);
			// draw the soybeans;
			xx += barW + BAR_GAP;
			h = this.soyPercent * this.hGraph;
			this.graphics.beginFill(WsConsts.SOY_COLOR);
			this.graphics.drawRect(xx, yBottom - h, barW, h);
			WsUtils.setupTextFieldL4(this, WsConsts.SOYBEANS_NAME,
															 xx, yBottom, hGraph, barW,
															 12, true);
			// draw the hay;
			xx += barW + BAR_GAP;
			h = this.hayPercent * this.hGraph;
			this.graphics.beginFill(WsConsts.HAY_COLOR);
			this.graphics.drawRect(xx, yBottom - h, barW, h);
			WsUtils.setupTextFieldL4(this, WsConsts.HAY_NAME,
															 xx, yBottom, hGraph, barW,
															 12, true);
			// draw the forest;
			xx += barW + BAR_GAP;
			h = this.forestPercent * this.hGraph;
			this.graphics.beginFill(WsConsts.FOREST_COLOR);
			this.graphics.drawRect(xx, yBottom - h, barW, h);
			WsUtils.setupTextFieldL4(this, WsConsts.FOREST_NAME,
															 xx, yBottom, hGraph, barW,
															 12, true);
		}
		
	}
}