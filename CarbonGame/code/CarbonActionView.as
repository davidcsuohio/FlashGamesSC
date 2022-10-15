package code {

  import fl.controls.*;
  import fl.events.*;
  import flash.display.*;
	import flash.geom.*;
  import flash.text.*;

  public class CarbonActionView extends Sprite {
		
		private const INDICATOR_Y_POSITION:int = 17;
		private const CURRENT_POINTS_Y_POSITION:int = 15;
		private const SLIDER_X_POSITION:int = 84;
		private const SLIDER_Y_POSITION:int = 5;
		private const SLIDER_HEIGHT:int = 60;
		private const TITLE_X_POSITION:int = 250;
		private const INDICATOR_VALUE_Y_POSITION:int = 44;

    private var actionData:CarbonActionData;
		private var yPos:Number;

    private var actionIcon:Bitmap;
		private var ppuIcon:Bitmap;
    private var slider:CarbonSlider;

    private var actionTitle:TextField;
    private var currentPoints:TextField;
    private var maxPoints:TextField;
		private var minPoints:TextField;
    private var pointsIndicator:CarbonPointsIndicator;

    public function CarbonActionView(actionData:CarbonActionData,
																		 actionIcon:Bitmap,
																		 ppuIcon:Bitmap,
																		 y:Number) {
      this.actionData = actionData;
			this.actionIcon = actionIcon;
			this.ppuIcon = ppuIcon;
			this.yPos = y;

      actionIcon.x = CarbonConsts.CPU_X_POSITION;
			actionIcon.y = yPos;
			
      slider = new CarbonSlider(0, actionData.getLimit(), actionData.getNumber());
			slider.x = SLIDER_X_POSITION;
			slider.y = yPos + SLIDER_Y_POSITION;
			var maxActionLimit = actionData.getCategoryMaxActionLimit();
      slider.setSize((TITLE_X_POSITION - SLIDER_X_POSITION - 40) * actionData.getLimit() / maxActionLimit, SLIDER_HEIGHT);
      slider.addEventListener(SliderEvent.CHANGE, sliderChanged);
			
      actionTitle = new TextField();
      actionTitle.text = actionData.getDisplayName();
      actionTitle.x = TITLE_X_POSITION;
			actionTitle.y = yPos;
      actionTitle.autoSize = TextFieldAutoSize.LEFT;

			pointsIndicator = new CarbonPointsIndicator(actionData, TITLE_X_POSITION, yPos + INDICATOR_Y_POSITION);

			minPoints = new TextField();
			setupPointsTextField(minPoints, CarbonConsts.STRING_ZERO,
													 TITLE_X_POSITION,
													 yPos + INDICATOR_VALUE_Y_POSITION,
													 40, 20);
			
			var totalLimit:int = actionData.getTotalLimit();
			setupCurrentPointsTextField(totalLimit);
			updateCurrentPoints();
			
      maxPoints = new TextField();
			setupPointsTextField(maxPoints, String(totalLimit),
													 TITLE_X_POSITION + totalLimit / CarbonConsts.POINTS_PER_PIXEL,
													 yPos + INDICATOR_VALUE_Y_POSITION,
													 40, 20);

      ppuIcon.x = CarbonConsts.PPU_X_POSITION;
			ppuIcon.y = yPos;

      addChild(this.actionIcon);
      addChild(this.actionTitle);
			addChild(this.minPoints);
      addChild(this.currentPoints);
      addChild(this.maxPoints);
			addChild(this.pointsIndicator);
			addChild(this.ppuIcon);
			// to ensure the slider receives the mouse click/drag input easily, always add it last.
      addChild(this.slider);
    }

    private function sliderChanged(e:SliderEvent):void {
      var curr:Number = e.target.value;
			actionData.setNumber(curr);
			slider.setThumbValue(curr);
			updateCurrentPoints();
			
			removeChild(this.pointsIndicator);
			this.pointsIndicator = new CarbonPointsIndicator(actionData, TITLE_X_POSITION, yPos + INDICATOR_Y_POSITION);
			// add it to behind the slider to ensure the slider receives the mouse click/drag input easily
			addChildAt(this.pointsIndicator, numChildren - 2);
			
			updateScores();
    }
		
		private function updateCurrentPoints():void {
      currentPoints.text = String(CarbonConsts.POINTS_NAME + actionData.getTotal());
		}

		private function updateScores():void {
			actionData.updateScores();
		}
		
    private function setupPointsTextField(tf:TextField, name:String, xCenter:Number, y:Number, w:Number, h:Number):void {
			tf.text = name;
			tf.x = xCenter - w / 2;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			tf.setTextFormat(format);
		}
		
    private function setupCurrentPointsTextField(totalLimit:int):void {
      currentPoints = new TextField();
			currentPoints.x = TITLE_X_POSITION + totalLimit / CarbonConsts.POINTS_PER_PIXEL;
			currentPoints.y = yPos + CURRENT_POINTS_Y_POSITION;;
			currentPoints.width = 62;
			currentPoints.height = CarbonConsts.POINTS_INDICATOR_HEIGHT;
			currentPoints.autoSize = TextFieldAutoSize.CENTER;
			currentPoints.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			currentPoints.defaultTextFormat = format;
		}
  }
}