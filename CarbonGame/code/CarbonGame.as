package code {

  import flash.display.*;
  import fl.containers.ScrollPane;
  import flash.events.Event;

  public class CarbonGame extends Sprite {

    var myStage:Stage;
		var sp:ScrollPane;
		var view:CarbonView;

    public function CarbonGame() {
			view = new CarbonView(this);
			addChild(view);
			
			myStage = this.stage;
			myStage.scaleMode = StageScaleMode.NO_SCALE;
			myStage.align = StageAlign.TOP_LEFT;
			myStage.addEventListener(Event.RESIZE, onSWFResized);
			
			sp = new ScrollPane();
			sp.move(0, 0);
			onSWFResized(null);
			sp.source = view;
			addChild(sp);
    }

		function onSWFResized(e:Event):void {
			sp.setSize(stage.stageWidth, stage.stageHeight);
		}
		
		public function reloadContents():void {
			sp.refreshPane();
		}
  }
}