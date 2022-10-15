package code {

  import flash.text.*;
  import flash.display.*;

  public class EnergyGraphBase extends EnergyViewBase {

		protected const TITLE_HEIGHT:int = 20;
		// title height 20 is not included in the MAX_CUBE_HEIGHT;
		protected const MAX_CUBE_HEIGHT:int = 280;
    protected const MAX_CUBE_WIDTH:int = 40;
		protected const MAX_CUBE_DELTA_X:int = 10;
		protected const MAX_CUBE_DELTA_Y:int = 10;
		
		protected var title:String;
		protected var titleTF:TextField;
		protected var sourceValueTF:TextField;
		protected var container:Sprite;

    public function EnergyGraphBase(title:String) {
			this.title = title;
			this.titleTF = null;
			this.sourceValueTF = null;
			this.container = null;
    }

		protected function setupTitle(x:Number, y:Number, w:Number) {
			if (titleTF && titleTF.parent)
			  removeChild(titleTF);
			titleTF = new TextField();
			titleTF.text = title;
			setupTextField(titleTF, x, y + 2, w, TITLE_HEIGHT, 12, true);
		}
		
		protected function setupSourceValueField(x:Number, y:Number, w:Number) {
			if (sourceValueTF && sourceValueTF.parent)
			  removeChild(sourceValueTF);
			sourceValueTF = new TextField();
			setupTextField(sourceValueTF, x, y - 2, w, TITLE_HEIGHT, 16, true); 
		}
		
    protected function clearContainer():void {
			if (container && container.parent)
			  removeChild(container);
		}
  }
}
