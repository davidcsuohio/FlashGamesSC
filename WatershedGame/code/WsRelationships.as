package code {
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	public class WsRelationships extends WsSpriteX {
		
		private const MARGIN:Number = 20;
		
		private var xPos:Number;
		private var yTop:Number;
		private var w:Number;
		private var h:Number;
		
		public function WsRelationships(x:Number, y:Number) {
			// hard-coded fixed size;
			this.w = 660;
			this.h = 500;
			super(x, y, w);
			xPos = x;
			yTop = y;
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
		}
		
    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			this.contextMenu = super.createCloseMenu(WsConsts.CLOSE_BASIC_RELATIONSHIPS_NAME);
			// draw background;
			WsUtils.setupBackground(this,
															WsConsts.RELATIONSHIPS_BG_COLOR, 1,
															xPos, yTop, w, h);
			// create basic relationships graphs;
			var ww:Number = (this.w - MARGIN * 4) / 3;
			var hh:Number = (this.h - MARGIN * 3) / 2;
			var xx:Number = xPos + MARGIN;
			var yy:Number = yTop + hh + MARGIN;
			// soil erosion / slope (0, 0)
			addChild(new WsSlope(xx, yy, ww * 1.5, hh,
																	WsConsts.SLOPE_RELATION_TITLE));
			// water pollution (0, 2)
			xx = xPos + ww * 2 + MARGIN * 3;
			addChild(new WsRelationship(xx, yy, ww, hh,
																	WsConsts.WATER_RELATION_TITLE,
																	1, 0.7, 0.4, 0.1));
			// carbon retention (1, 0)
			xx = xPos + MARGIN;
			yy = yTop + (hh + MARGIN) * 2;
			addChild(new WsRelationship(xx, yy, ww, hh,
																	WsConsts.CARBON_RELATION_TITLE,
																	0.1, 0.025, 0.5, 1));
			// peak flow (1, 1)
			xx = xPos + ww + MARGIN * 2;
			addChild(new WsRelationship(xx, yy, ww, hh,
																	WsConsts.FLOOD_RELATION_TITLE,
																	0.8, 1, 0.5, 0.2));
			// average revenue (1, 2)
			xx = xPos + ww * 2 + MARGIN * 3;
			addChild(new WsRelationship(xx, yy, ww, hh,
																	WsConsts.REVENUE_RELATION_TITLE,
																	1, 0.9, 0.4, 0.1));
			super.addXBtn();
		}
		
		override protected function xBtnClickedHandling():void {
			dispatchEvent(new WsEvent(WsEvent.CLOSE_RELATIONSHIPS, true));
		}
	}
}
