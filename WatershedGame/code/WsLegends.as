package code {
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	
	public class WsLegends extends Sprite {

		private const LEGEND_WIDTH:Number = 100;
		private const LEGEND_HEIGHT:Number = 30;
		private const LEGEND_TITLE_H:Number = 20
		private const LEGEND_GAP_Y:Number = 10;
		private const CORN_LEGEND_X:Number = 0;
		private const CORN_LEGEND_Y:Number = 0;
		private const SOY_LEGEND_X:Number = CORN_LEGEND_X;
		private const SOY_LEGEND_Y:Number = CORN_LEGEND_Y + LEGEND_TITLE_H + LEGEND_HEIGHT + LEGEND_GAP_Y;
		private const HAY_LEGEND_X:Number = CORN_LEGEND_X;
		private const HAY_LEGEND_Y:Number = SOY_LEGEND_Y + LEGEND_TITLE_H + LEGEND_HEIGHT + LEGEND_GAP_Y;
		private const FOREST_LEGEND_X:Number = CORN_LEGEND_X;
		private const FOREST_LEGEND_Y:Number = HAY_LEGEND_Y + LEGEND_TITLE_H + LEGEND_HEIGHT + LEGEND_GAP_Y;
		
		private var xPos:Number;
		private var yPos:Number;
		private var cornLegend:WsLegend;
		private var soyLegend:WsLegend;
		private var hayLegend:WsLegend;
		private var forestLegend:WsLegend;
		
		public function WsLegends(x:Number, y:Number) {
			this.xPos = x;
			this.yPos = y;
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
		}

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			setupCornLegend();
			setupSoyLegend();
			setupHayLegend();
			setupForestLegend();

		}
		
		private function setupCornLegend():void {
			// setup legend name;
			WsUtils.setupTextFieldC2(this,
															 WsConsts.CORN_NAME,
															 xPos + this.CORN_LEGEND_X, yPos + this.CORN_LEGEND_Y,
															 this.LEGEND_WIDTH, this.LEGEND_TITLE_H,
															 12, true);
			// setup legend symbol;
			cornLegend = new WsLegend(xPos + this.CORN_LEGEND_X, yPos + this.CORN_LEGEND_Y + this.LEGEND_TITLE_H,
															 this.LEGEND_WIDTH, this.LEGEND_HEIGHT,
															 WsConsts.CORN_COLOR, WsConsts.CORN_CURSOR);
			addChild(cornLegend);
		}
		
		private function setupSoyLegend():void {
			// setup legend name;
			WsUtils.setupTextFieldC2(this,
															 WsConsts.SOYBEANS_NAME,
															 xPos + this.SOY_LEGEND_X, yPos + this.SOY_LEGEND_Y,
															 this.LEGEND_WIDTH, this.LEGEND_TITLE_H,
															 12, true);
			// setup legend symbol;
			soyLegend = new WsLegend(xPos + this.SOY_LEGEND_X, yPos + this.SOY_LEGEND_Y + this.LEGEND_TITLE_H,
															 this.LEGEND_WIDTH, this.LEGEND_HEIGHT,
															 WsConsts.SOY_COLOR, WsConsts.SOY_CURSOR);
			addChild(soyLegend);
		}
		
		private function setupHayLegend():void {
			// setup legend name;
			WsUtils.setupTextFieldC2(this,
															 WsConsts.HAY_NAME,
															 xPos + this.HAY_LEGEND_X, yPos + this.HAY_LEGEND_Y,
															 this.LEGEND_WIDTH, this.LEGEND_TITLE_H,
															 12, true);
			// setup legend symbol;
			hayLegend = new WsLegend(xPos + this.HAY_LEGEND_X, yPos + this.HAY_LEGEND_Y + this.LEGEND_TITLE_H,
															 this.LEGEND_WIDTH, this.LEGEND_HEIGHT,
															 WsConsts.HAY_COLOR, WsConsts.HAY_CURSOR);
			addChild(hayLegend);
		}
		
		private function setupForestLegend():void {
			// setup legend name;
			WsUtils.setupTextFieldC2(this,
															 WsConsts.FOREST_NAME,
															 xPos + this.FOREST_LEGEND_X, yPos + this.FOREST_LEGEND_Y,
															 this.LEGEND_WIDTH, this.LEGEND_TITLE_H,
															 12, true);
			// setup legend symbol;
			forestLegend = new WsLegend(xPos + this.FOREST_LEGEND_X, yPos + this.FOREST_LEGEND_Y + this.LEGEND_TITLE_H,
															 this.LEGEND_WIDTH, this.LEGEND_HEIGHT,
															 WsConsts.FOREST_COLOR, WsConsts.FOREST_CURSOR);
			addChild(forestLegend);
		}
		
	}
	
}
