package code {
	
	import flash.display.*;
	import flash.events.*;
	
	public class WsLands extends Sprite {
		
		private const TITLE_HEIGHT:Number = 25;
		
		private var dataLands:Vector.<WsDataLand>;
		private var uiLands:Vector.<WsLand>;
		private var title:String;
		private var xPos:Number;
		private var yPos:Number;
		private var w:Number;
		private var shadedShed:MovieClip;
		
		public function WsLands(dataLands:Vector.<WsDataLand>, title:String, x:Number, y:Number) {
			this.dataLands = dataLands;
			this.title = title;
			this.xPos = x;
			this.yPos = y;
			this.uiLands = new Vector.<WsLand>();
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
		}
		
		public function updateLanduse():void {
			for (var i:uint = 0; i < uiLands.length; i++) {
				uiLands[i].updateLanduse();
			}
		}

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			setupShadedWatershed();
			setupTitle();
			setupLands();
		}
		
		private function setupTitle():void {
			WsUtils.setupTextFieldC2(this, this.title, xPos, yPos, w, TITLE_HEIGHT, 16, true);
		}
		
		private function setupShadedWatershed():void {
			shadedShed = new WsStreamShadeMC();
			shadedShed.x = xPos;
			shadedShed.y = yPos + TITLE_HEIGHT;
			w = shadedShed.width;
			// try and error to match the picture and the coordinates;
			shadedShed.scaleX = 415 / 442;
			shadedShed.scaleY = 650 / 696;
//			width:  415.65, 442, 415,   442
//			height:  629.5, 696, 614.5, 658
//			trace("width: ", shadedShed.width);
//			trace("height: ", shadedShed.height);
			addChild(shadedShed);
		}
		
		private function setupLands():void {
			var land:WsLand;
			for (var i:int = 0; i < WsCoordConsts.DATA_SIZE; i++) {
				land = new WsLand(this.dataLands[i], xPos, yPos + TITLE_HEIGHT);
				uiLands.push(land);
				addChild(land);
			}
		}
	}
	
}
