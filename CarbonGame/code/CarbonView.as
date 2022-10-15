package code {

  import fl.controls.*;
  import flash.display.*;
  import flash.display.DisplayObject;
	import flash.geom.*;
  import flash.text.*;
  import flash.events.Event;

  public class CarbonView extends Sprite {

		private const BANNER_Y_POSITION:int = 32;
		private const OPTIONS_REMAINING_BAR_Y_POSITION:int = 64;
		private const OPTIONS_USED_BAR_Y_POSITION:int = 96;
		private const DISTANCE_BETWEEN_BANNERS_IN_PIXELS:int = 5;
		private const BORDER_TEXT_FIELDS_Y_DISTANCE:int = 30;
		private const BORDER_TEXT_FIELDS_X:int = 580;
		private const BORDER_TEXT_FIELDS_WIDTH:int = 50;
		private const BORDER_TEXT_FIELDS_HEIGHT:int = 20;
		private const BORDER_TEXT_FONT_SIZE:int = 14;
		private const STATIC_TEXT_FIELDS_X:int = 450;
		private const STATIC_TEXT_FIELDS_WIDTH:int = 120;
		private const STATIC_TEXT_FIELDS_HEIGHT:int = 20;
		private const ENERGY_EFFICIENCY_Y:int = 146;

    private var removeObject:CarbonActionCategoryView = null;
		private var currentCategoryView:CarbonActionCategoryView = null;
		private var gameData:CarbonData = null;
		private var gameView:CarbonGame = null;

		// text fields for bordered points;
		private var energyEfficiency:TextField;
		private var energyProduction:TextField;
		private var landManagement:TextField;
		private var totalCarbonPoints:TextField;
		
		private var optionsComboBox:ComboBox;
		private var optionsRemainingProgressBar:CarbonProgressBar = null;
		private var optionsUsedProgressBar:CarbonProgressBar = null;
		private var totalCarbonPointsBar:CarbonProgressBar = null;

    public function CarbonView(game:CarbonGame) {
			gameData = new CarbonData(this);
			this.gameView = game;
      setupTitleAndBanner();
			setupStaticTextFields();
      setupOptionsComboBox();
			setupTextFields();
			setupProgressBars();
    }

    private function setupTitleAndBanner():void {
			var title:TextField = new TextField();
			title.text = CarbonConsts.THE_CARBON_GAME_NAME;
			title.x = 0;
			title.y = 0;
			title.width = 780;
			title.height = 28;
			title.autoSize = TextFieldAutoSize.CENTER;
			var format:TextFormat = new TextFormat();
			format.bold = true;
			format.size = 24;
			format.align = TextFormatAlign.CENTER;
			title.setTextFormat(format);
			addChild(title);
			var biomass:MovieClip = new Biomass();
			biomass.x = CarbonConsts.CPU_X_POSITION;
			biomass.y = BANNER_Y_POSITION;
			addChild(biomass);
			var ocean:MovieClip = new Ocean();
			ocean.x = biomass.x + biomass.width + DISTANCE_BETWEEN_BANNERS_IN_PIXELS;
			ocean.y = biomass.y;
			addChild(ocean);
			var atmosphere:MovieClip = new Atmosphere();
			atmosphere.x = ocean.x - 1;
			atmosphere.y = biomass.y + biomass.height + DISTANCE_BETWEEN_BANNERS_IN_PIXELS;
			addChild(atmosphere);
			var fossilFuel:MovieClip = new FossilFuel();
			fossilFuel.x = biomass.x + 5;
			fossilFuel.y = atmosphere.y + 5;
			addChild(fossilFuel);
		}
		
    private function setupOptionsComboBox():void {
			optionsComboBox = new ComboBox();
			optionsComboBox.move(CarbonConsts.OPTIONS_COMBOBOX_X_POSITION,
													 CarbonConsts.OPTIONS_COMBOBOX_Y_POSITION);
      optionsComboBox.setSize(150, 22);
			optionsComboBox.prompt = CarbonConsts.OPTIONS_NAME;
      optionsComboBox.addItem( { label: CarbonConsts.ENERGY_EFFICIENCY_CATEGORY_NAME, data:1 } );
      optionsComboBox.addItem( { label: CarbonConsts.ENERGY_PRODUCTION_CATEGORY_NAME, data:2 } );
      optionsComboBox.addItem( { label: CarbonConsts.LAND_MANAGEMENT_CATEGORY_NAME, data:3 } );
      optionsComboBox.addEventListener(Event.CHANGE, actionCategoryChanged);
			addChild(optionsComboBox);
    }

    private function actionCategoryChanged(e:Event):void {
      displayActions(optionsComboBox.selectedLabel);
			gameView.reloadContents();
			updateScores();
    }

    private function displayActions(selectedActionCategory:String):void {
      if (removeObject != null) {
        this.removeChild(removeObject);
        removeObject = null;
      }
			currentCategoryView = null;
      if (selectedActionCategory == CarbonConsts.ENERGY_EFFICIENCY_CATEGORY_NAME) {
        currentCategoryView = createEnergyEfficiencyCategoryView();
      } else if (selectedActionCategory == CarbonConsts.ENERGY_PRODUCTION_CATEGORY_NAME) {
        currentCategoryView = createEnergyProductionCategoryView();
      } else if (selectedActionCategory == CarbonConsts.LAND_MANAGEMENT_CATEGORY_NAME) {
				currentCategoryView = createLandManagementCategoryView();
			}
			if (currentCategoryView != null) {
			  addChild(currentCategoryView);
				removeObject = currentCategoryView;
			}
    }

    private function createEnergyEfficiencyCategoryView():CarbonActionCategoryView {
      var cacv:CarbonActionCategoryView = new CarbonEnergyEfficiencyView(gameData.getActionCategoryData(0));
			cacv.createActionViews();
	    return cacv;
    }

    private function createEnergyProductionCategoryView():CarbonActionCategoryView {
      var cacv:CarbonActionCategoryView = new CarbonEnergyProductionView(gameData.getActionCategoryData(1));
			cacv.createActionViews();
	    return cacv;
    }

		private function createLandManagementCategoryView():CarbonActionCategoryView {
      var cacv:CarbonActionCategoryView = new CarbonLandManagementView(gameData.getActionCategoryData(2));
			cacv.createActionViews();
	    return cacv;
    }
		
		public function updateScores():void {
			energyEfficiency.text = String(gameData.getActionCategoryData(0).getTotal());
			energyProduction.text = String(gameData.getActionCategoryData(1).getTotal());
			landManagement.text = String(gameData.getActionCategoryData(2).getTotal());
			var score:int = gameData.getTotalScore();
			totalCarbonPoints.text = String(score);
			if (this.currentCategoryView != null) {
			  this.currentCategoryView.updateOptionsProgressBar();
			}
			if (this.optionsRemainingProgressBar != null) {
				updateProgressBars();
			}
		}

    private function setupTextFields():void {
			energyEfficiency = new TextField();
			setupTextField(energyEfficiency,
										 BORDER_TEXT_FONT_SIZE,
										 BORDER_TEXT_FIELDS_X,
										 ENERGY_EFFICIENCY_Y,
										 BORDER_TEXT_FIELDS_WIDTH,
										 BORDER_TEXT_FIELDS_HEIGHT);
			energyProduction = new TextField();
			setupTextField(energyProduction,
										 BORDER_TEXT_FONT_SIZE,
										 BORDER_TEXT_FIELDS_X,
										 ENERGY_EFFICIENCY_Y + BORDER_TEXT_FIELDS_Y_DISTANCE,
										 BORDER_TEXT_FIELDS_WIDTH,
										 BORDER_TEXT_FIELDS_HEIGHT);
			landManagement = new TextField();
			setupTextField(landManagement,
										 BORDER_TEXT_FONT_SIZE,
										 BORDER_TEXT_FIELDS_X,
										 ENERGY_EFFICIENCY_Y + BORDER_TEXT_FIELDS_Y_DISTANCE * 2,
										 BORDER_TEXT_FIELDS_WIDTH,
										 BORDER_TEXT_FIELDS_HEIGHT);
			totalCarbonPoints = new TextField();
			setupTextField(totalCarbonPoints,
										 BORDER_TEXT_FONT_SIZE,
										 BORDER_TEXT_FIELDS_X,
										 ENERGY_EFFICIENCY_Y + BORDER_TEXT_FIELDS_Y_DISTANCE * 3,
										 BORDER_TEXT_FIELDS_WIDTH,
										 BORDER_TEXT_FIELDS_HEIGHT);
			
			updateScores();
		}

    private function setupTextField(tf:TextField, size:Object,
																		x:Number, y:Number, w:Number, h:Number):void {
			tf.x = x;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.border = true;
			var format:TextFormat = new TextFormat();
			format.bold = true;
			format.size = size;
			format.align = TextFormatAlign.RIGHT;
			tf.defaultTextFormat = format;
			addChild(tf);
		}
		
		private function setupStaticTextFields():void {
		  var tf:TextField = new TextField();
			setupStaticTextField(tf,
													 CarbonConsts.ENERGY_EFFICIENCY_CATEGORY_NAME,
													 STATIC_TEXT_FIELDS_X,
													 ENERGY_EFFICIENCY_Y,
													 STATIC_TEXT_FIELDS_WIDTH,
													 STATIC_TEXT_FIELDS_HEIGHT);
		  tf = new TextField();
			setupStaticTextField(tf,
													 CarbonConsts.ENERGY_PRODUCTION_CATEGORY_NAME,
													 STATIC_TEXT_FIELDS_X,
													 ENERGY_EFFICIENCY_Y + BORDER_TEXT_FIELDS_Y_DISTANCE,
													 STATIC_TEXT_FIELDS_WIDTH,
													 STATIC_TEXT_FIELDS_HEIGHT);
		  tf = new TextField();
			setupStaticTextField(tf,
													 CarbonConsts.LAND_MANAGEMENT_CATEGORY_NAME,
													 STATIC_TEXT_FIELDS_X,
													 ENERGY_EFFICIENCY_Y + BORDER_TEXT_FIELDS_Y_DISTANCE * 2,
													 STATIC_TEXT_FIELDS_WIDTH,
													 STATIC_TEXT_FIELDS_HEIGHT);
		  tf = new TextField();
			setupStaticTextField(tf,
													 CarbonConsts.TOTAL_CARBON_POINTS_NAME,
													 STATIC_TEXT_FIELDS_X,
													 ENERGY_EFFICIENCY_Y + BORDER_TEXT_FIELDS_Y_DISTANCE * 3,
													 STATIC_TEXT_FIELDS_WIDTH,
													 STATIC_TEXT_FIELDS_HEIGHT);
			tf = new TextField();
			setupStaticTextField(tf,
													 CarbonConsts.OPTIONS_REMAINING_NAME,
													 320,
													 OPTIONS_REMAINING_BAR_Y_POSITION + 2,
													 STATIC_TEXT_FIELDS_WIDTH,
													 22);
			tf = new TextField();
			setupStaticTextField(tf,
													 CarbonConsts.OPTIONS_USED_NAME,
													 320,
													 OPTIONS_USED_BAR_Y_POSITION + 2,
													 STATIC_TEXT_FIELDS_WIDTH,
													 22);
		}
		
    private function setupStaticTextField(tf:TextField, name:String, x:Number, y:Number, w:Number, h:Number):void {
			tf.text = name;
			tf.x = x;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.autoSize = TextFieldAutoSize.RIGHT;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.RIGHT;
			tf.setTextFormat(format);
			addChild(tf);
		}

		private function setupProgressBars():void {
			optionsRemainingProgressBar = new CarbonProgressBar(
																					CarbonConsts.PROGRESSBAR_X_POSITION,
																					OPTIONS_REMAINING_BAR_Y_POSITION,
																					CarbonConsts.PROGRESSBAR_WIDTH,
																					CarbonConsts.PROGRESSBAR_HEIGHT,
																					ProgressBarDirection.LEFT);
			optionsRemainingProgressBar.minimum = 0;
			optionsRemainingProgressBar.maximum = 100;
			addChild(optionsRemainingProgressBar);
			optionsUsedProgressBar = new CarbonProgressBar(
																					CarbonConsts.PROGRESSBAR_X_POSITION,
																					OPTIONS_USED_BAR_Y_POSITION,
																					CarbonConsts.PROGRESSBAR_WIDTH,
																					CarbonConsts.PROGRESSBAR_HEIGHT);
			optionsUsedProgressBar.minimum = 0;
			optionsUsedProgressBar.maximum = 100;
			addChild(optionsUsedProgressBar);
			totalCarbonPointsBar = new CarbonVerticalProgressBar(
																					670,
																					BANNER_Y_POSITION,
																					110,
																					ENERGY_EFFICIENCY_Y +
																					BORDER_TEXT_FIELDS_Y_DISTANCE * 3 +
																					BORDER_TEXT_FIELDS_HEIGHT - BANNER_Y_POSITION);
			totalCarbonPointsBar.minimum = 0;
			totalCarbonPointsBar.maximum = 15000;
			addChild(totalCarbonPointsBar);
			
			updateProgressBars();
		}
		
		private function updateProgressBars():void {
			optionsRemainingProgressBar.value = this.gameData.getOptionsRemaining();
			optionsUsedProgressBar.value = this.gameData.getTotalSpent();
			totalCarbonPointsBar.value = this.gameData.getTotalScore();
		}

  }
}