package code {
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import fl.containers.ScrollPane;
	import fl.controls.ScrollBar;
	
	public class WsSatelliteImage extends WsSpriteX {
		
		private var xPos:Number;
		private var yTop:Number;
		private var w:Number;
		private var h:Number;
		private var sp:ScrollPane;
		
		public function WsSatelliteImage(x:Number, y:Number) {
			// hard-coded fixed size;
			this.w = WsConsts.IMAGE_MAP_WIDTH;
			this.h = WsConsts.IMAGE_MAP_HEIGHT;
			super(x, y, w);
			xPos = x;
			yTop = y;
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
		}
		
    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			this.contextMenu = super.createCloseMenu(WsConsts.CLOSE_SATELLITE_IMAGE_NAME);
			sp = new ScrollPane();
			sp.move(xPos, yTop);
			sp.setSize(w, h);
			var mcSI:MovieClip = new SatelliteImageMC();
			sp.source = mcSI;
			addChild(sp);
			super.addXBtn();
			// adjust the x position of "X" button due to the presence of scroll bar;
			(super.xBtn.x) -= ScrollBar.WIDTH;
		}
		
		override protected function xBtnClickedHandling():void {
			dispatchEvent(new WsEvent(WsEvent.CLOSE_SATELLITE_IMAGE, true));
		}
	}
}
