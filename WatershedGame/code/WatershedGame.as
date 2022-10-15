package code {

  import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.Shape;
	import flash.display.BitmapData
  import fl.containers.ScrollPane;
  import flash.events.Event;
  import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.ui.MouseCursorData;
	import flash.geom.Point;
	import flash.display.MovieClip;
	import fl.events.ScrollEvent;
	import fl.controls.ScrollBar;

  public class WatershedGame extends Sprite {

		// made it public to temporarily fix the resizing issue with the scroll bars appearing
		public var sp:ScrollPane;
    private var myStage:Stage;
		private var view:WsView;

    public function WatershedGame() {
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);

			createCursors();

			view = new WsView();
			addChild(view);
			
			myStage = this.stage;
			myStage.scaleMode = StageScaleMode.NO_SCALE;
			myStage.align = StageAlign.TOP_LEFT;
			myStage.addEventListener(Event.RESIZE, onSWFResized, false, 0, true);
			myStage.addEventListener(MouseEvent.CLICK, mouseClickHandler, false, 0, true);
			
			sp = new ScrollPane();
			sp.move(0, 0);
			onSWFResized(null);
			sp.source = view;
			sp.addEventListener(ScrollEvent.SCROLL, scrollHandler);
			addChild(sp);
			
    }

		private function onSWFResized(e:Event):void {
			if (stage.stageWidth >= WsConsts.GAME_WIDTH && stage.stageHeight >= WsConsts.GAME_HEIGHT) {
				view.scrollPaneDx = 0;
				view.scrollPaneDy = 0;
			}
			else if (stage.stageHeight >= WsConsts.GAME_HEIGHT + ScrollBar.WIDTH) {
				view.scrollPaneDy = 0;
			}
			else if (stage.stageWidth >= WsConsts.GAME_WIDTH + ScrollBar.WIDTH) {
				view.scrollPaneDx = 0;
			}
			sp.setSize(stage.stageWidth, stage.stageHeight);
		}
		
		private function mouseClickHandler(e:MouseEvent):void {
			if ((e.target is MovieClip || e.target is Stage) && Mouse.cursor != MouseCursor.AUTO) {
				Mouse.cursor = MouseCursor.AUTO;
			}
		}

		private function scrollHandler(event:ScrollEvent):void {
			var mySP:ScrollPane = event.currentTarget as ScrollPane;
			view.scrollPaneDx = mySP.horizontalScrollPosition;
			view.scrollPaneDy = mySP.verticalScrollPosition;
		}

		private function createCursor(color:uint):MouseCursorData {
      var mouseCursorData:MouseCursorData = new MouseCursorData();
      var cursorData:Vector.<BitmapData> = new Vector.<BitmapData>();
      var cursorShape:Shape = new Shape();
      cursorShape.graphics.lineStyle(1);
			cursorShape.graphics.beginFill(color);
      cursorShape.graphics.drawRect(0, 0, 15, 15);
			cursorShape.graphics.endFill();
      var cursorFrame:BitmapData = new BitmapData(16, 16, true, 0);
      cursorFrame.draw(cursorShape);
			cursorData.push(cursorFrame);
			mouseCursorData.data = cursorData;
			mouseCursorData.frameRate = 1;
			mouseCursorData.hotSpot = new Point(0, 0);
			return mouseCursorData;
		}
		
		private function createCursors():void {
      Mouse.registerCursor(WsConsts.CORN_CURSOR, createCursor(WsConsts.CORN_COLOR));
      Mouse.registerCursor(WsConsts.SOY_CURSOR, createCursor(WsConsts.SOY_COLOR));
      Mouse.registerCursor(WsConsts.HAY_CURSOR, createCursor(WsConsts.HAY_COLOR));
      Mouse.registerCursor(WsConsts.FOREST_CURSOR, createCursor(WsConsts.FOREST_COLOR));
		}
		
  }
}