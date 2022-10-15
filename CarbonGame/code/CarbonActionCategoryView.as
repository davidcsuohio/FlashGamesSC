package code {

  import flash.display.*;
	import flash.geom.*;
	import flash.text.*;
  import fl.controls.Button;
  import flash.events.MouseEvent;
	import flash.errors.IllegalOperationError;

  public class CarbonActionCategoryView extends Sprite {

    protected const ACTION_VIEW_HEIGHT:int = 70;
		protected const ACTION_CATEGORY_VIEW_Y_POSITION:int = 330;
		protected const BUTTON_X_OFFSET:int = 580;
		protected const BUTTON_WIDTH:int = 120;
		protected const BUTTON_HEIGHT:int = 30;
		
    protected var categoryData:CarbonActionCategoryData;
		protected var optionsProgressBar:CarbonProgressBar = null;
		protected var tonsOfCarbonPerUnit:TextField = null;
		protected var pointsPerUnit:TextField = null;
		// assume only two pages for Energy Efficiency and Energy Production;
		protected var nextBtn:Button;
		protected var prevBtn:Button;
		protected var container:Sprite;

    public function CarbonActionCategoryView(
														categoryData:CarbonActionCategoryData) {
      this.categoryData = categoryData;
    }

    // this function will add the action to the display list
    protected function addAction(action:CarbonActionView):void {
			if (optionsProgressBar == null) {
				setupOptionsProgressBar();
			}
			if (tonsOfCarbonPerUnit == null) {
				setupColumnTitles();
			}
			this.container.addChild(action);
    }
		
		public function updateOptionsProgressBar():void {
			optionsProgressBar.value = this.categoryData.getNumber();
		}
		
		protected function setupOptionsProgressBar():void {
			// the coordinates should reference optionsComboBox of CarbonView.as;
			optionsProgressBar = new CarbonProgressBar(CarbonConsts.PROGRESSBAR_X_POSITION,
																								 CarbonConsts.OPTIONS_COMBOBOX_Y_POSITION,
																								 CarbonConsts.PROGRESSBAR_WIDTH,
																								 CarbonConsts.PROGRESSBAR_HEIGHT);
			optionsProgressBar.minimum = 0;
			optionsProgressBar.maximum = this.categoryData.getLimit();
			addChild(optionsProgressBar);
			
			updateOptionsProgressBar();
		}

    protected function setupColumnTitles():void {
			tonsOfCarbonPerUnit = new TextField();
			setupStaticTextField(tonsOfCarbonPerUnit,
													 CarbonConsts.TONS_OF_CARBON_PER_UNIT_NAME,
													 CarbonConsts.CPU_X_POSITION,
													 ACTION_CATEGORY_VIEW_Y_POSITION - 55,
													 54,
													 52);
			addChild(tonsOfCarbonPerUnit);
			pointsPerUnit = new TextField();
			setupStaticTextField(pointsPerUnit,
													 CarbonConsts.POINTS_PER_UNIT_NAME,
													 CarbonConsts.PPU_X_POSITION,
													 ACTION_CATEGORY_VIEW_Y_POSITION - 40,
													 54,
													 36);
			addChild(pointsPerUnit);
		}
		
    protected function setupStaticTextField(tf:TextField, name:String, x:Number, y:Number, w:Number, h:Number):void {
			tf.text = name;
			tf.x = x;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.wordWrap = true;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.bold = true;
			format.align = TextFormatAlign.CENTER;
			tf.setTextFormat(format);
			addChild(tf);
		}

    protected function createFirstPageActionViews():void {
			throw new IllegalOperationError("The CarbonActionCategoryView class does not implement this method.");
		}
		
    protected function createSecondPageActionViews():void {
			throw new IllegalOperationError("The CarbonActionCategoryView class does not implement this method.");
		}
		
    public function createActionViews():void {
			prevBtnClicked(null);
    }
		
		protected function nextBtnClicked(event:MouseEvent):void {
			createContainer();
			
			createSecondPageActionViews();
			
			// create prev button;
			prevBtn = new Button();
			prevBtn.label = CarbonConsts.PREV_OPTIONS_BUTTON_LABEL_NAME;
			prevBtn.move(BUTTON_X_OFFSET, ACTION_CATEGORY_VIEW_Y_POSITION - 35);
			prevBtn.setSize(BUTTON_WIDTH, BUTTON_HEIGHT);
			prevBtn.addEventListener(MouseEvent.CLICK, prevBtnClicked, false, 0, true);
			container.addChild(prevBtn);
		}
		
		protected function prevBtnClicked(event:MouseEvent):void {
			createContainer();
			
			createFirstPageActionViews();
			
			// create next button;
			nextBtn = new Button();
			nextBtn.label = CarbonConsts.MORE_OPTIONS_BUTTON_LABEL_NAME;
			nextBtn.move(BUTTON_X_OFFSET, ACTION_CATEGORY_VIEW_Y_POSITION - 35);
			nextBtn.setSize(BUTTON_WIDTH, BUTTON_HEIGHT);
			nextBtn.addEventListener(MouseEvent.CLICK, nextBtnClicked, false, 0, true);
			container.addChild(nextBtn);
		}
		
    protected function createActionView(actionIndex:int,
																				actionIcon:Bitmap,
																				ppuIcon:Bitmap,
																				positionIndex:int):void {
			var av:CarbonActionView = new CarbonActionView(categoryData.getActionData(actionIndex),
																										 actionIcon,
																										 ppuIcon,
																										 ACTION_CATEGORY_VIEW_Y_POSITION + ACTION_VIEW_HEIGHT * positionIndex);
			this.addAction(av);
		}
		
		protected function createContainer():void {
			if (container && container.parent)
				removeChild(container);
			container = new Sprite();
			addChild(container);
		}
  }
}