package code {

  import flash.display.*;
  import fl.controls.*;
	import flash.events.*;
  import flash.text.*;
	import flash.net.FileReference;
	import flash.geom.Rectangle;

  public class EnergyToolbar extends EnergyViewBase {

		private const OBJECTIVES_X:Number = 268 + EnergyConsts.DELTA_X;
		private const TOOL_BAR_Y1:Number = 36;
		private const TOOL_BAR_Y2:Number = 55;
		private const BUTTON_WIDTH:Number = 90;
		private const DISTANCE_BTW_BUTTONS:Number = 16;
		private const FIRST_BUTTON_X:Number = 582 + EnergyConsts.DELTA_X;
    // buttons coordinates and checkboxes coordinates are located in their setup functions;
    // game title: 0, 0, 910x35.30 Arial Bold 28.0pt
		private const GAME_TITLE_X:Number = 0;
		private const GAME_TITLE_Y:Number = 2;
		private const GAME_TITLE_HEIGHT:Number = 35.30;
    // bottom:558; budget h:256; plan h:473; cubes h:446; ghg h:244; oil h:166;
    private const SECTOR_VIEW_X:int = 0;
    private const SECTOR_VIEW_Y:int = 155;
		// title 46.20, 35.85, 99.60x16.55 Arial Bold 11.0pt
		private const ENERGY_SECTOR_TITLE_X:Number = 46.20;
		private const ENERGY_SECTOR_TITLE_Y:Number = 105.85;
		private const ENERGY_SECTOR_TITLE_WIDTH:Number = 99.60;
		private const ENERGY_SECTOR_TITLE_HEIGHT:Number = 16.55;
		private const ENERGY_SECTOR_CB_X:Number = 16;
		private const ENERGY_SECTOR_CB_Y:Number = 124.35;
		private const ENERGY_SECTOR_CB_WIDTH:Number = 160;
		private const ENERGY_SECTOR_CB_HEIGHT:Number = 22;
		// title 225.85, 35.85, 68.30x16.55 Arial Bold 11.0pt
		private const LEVEL_TITLE_X:Number = 167.85;
		private const LEVEL_TITLE_Y:Number = TOOL_BAR_Y1;
		private const LEVEL_TITLE_WIDTH:Number = 68.30;
		private const LEVEL_TITLE_HEIGHT:Number = 16.55;
		private const LEVEL_CB_X:Number = 152;
		private const LEVEL_CB_Y:Number = TOOL_BAR_Y2;
		private const LEVEL_CB_WIDTH:Number = 100;
		private const LEVEL_CB_HEIGHT:Number = 22;
		// title 378.60, 35.85, 34.80x16.55 Arial Bold 11.0pt
		private const YEAR_TITLE_X:Number = 58.60;
		private const YEAR_TITLE_Y:Number = TOOL_BAR_Y1;
		private const YEAR_TITLE_WIDTH:Number = 34.80;
		private const YEAR_TITLE_HEIGHT:Number = 16.55;
		private const YEAR_CB_X:Number = 16;
		private const YEAR_CB_Y:Number = TOOL_BAR_Y2;
		private const YEAR_CB_WIDTH:Number = 120;
		private const YEAR_CB_HEIGHT:Number = 22;
		// OBJECTIVES 476.95, 35.85, 273.00x16.55 Arial Bold 11.0pt
		private const OBJECTIVES_TITLE_X:Number = OBJECTIVES_X;
		private const OBJECTIVES_TITLE_Y:Number = TOOL_BAR_Y1;
		private const OBJECTIVES_TITLE_WIDTH:Number = 297;
		private const OBJECTIVES_TITLE_HEIGHT:Number = 16.55;
		
    private var data:EnergyData;
		private var view:EnergyView;
		private var levelCB:ComboBox;
		private var yearCB:ComboBox;
		private var energySectorCB:ComboBox;
		
		private var currentSectorView:EnergySectorView;

    private var saveBtn:Button;
		private var loadBtn:Button;
		private var newBtn:Button;
		private var fileRef:FileReference;
		
		private var budgetLimitChB:CheckBox;
		private var oilLimitChB:CheckBox;
		private var ghgLimitChB:CheckBox;
		private var electricityMinChB:CheckBox;
		private var energyMinChB:CheckBox;
		private var heatMinChB:CheckBox;
		private var fuelMinChB:CheckBox;

    public function EnergyToolbar(data:EnergyData, view:EnergyView) {
			this.data = data;
			this.view = view;
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			currentSectorView = null;
			setupTitles();
			setupComboBoxes();
			setupCheckBoxes();
			setupButtons();
		}
		
		// enable or disable all components except for the year combobox
    public function enableComponents(enable:Boolean):void {
			if (!enable) {
				this.removeCurrentSectorView();
			}
			else {
				energySectorChanged(null);
			}
			levelCB.enabled = enable;
			energySectorCB.enabled = enable;
			saveBtn.enabled = enable;
			loadBtn.enabled = enable;
			budgetLimitChB.enabled = enable;
			oilLimitChB.enabled = enable;
			ghgLimitChB.enabled = enable;
			electricityMinChB.enabled = enable;
			energyMinChB.enabled = enable;
			heatMinChB.enabled = enable;
			fuelMinChB.enabled = enable;
    }
		
    private function setupComboBoxes():void {
			yearCB = new EnergyComboBox();
			yearCB.move(YEAR_CB_X, YEAR_CB_Y);
			yearCB.setSize(YEAR_CB_WIDTH, YEAR_CB_HEIGHT);
      yearCB.addItem( { label: "1990 (read only)", data:1990 } );
      yearCB.addItem( { label: "2000 (read only)", data:2000 } );
      yearCB.addItem( { label: "2010 (read only)", data:2010 } );
      yearCB.addItem( { label: "2020", data:2020 } );
      yearCB.addItem( { label: "2030", data:2030 } );
      yearCB.addItem( { label: "2040", data:2040 } );
      yearCB.addItem( { label: "2050", data:2050 } );
			yearCB.rowCount = yearCB.length;
      yearCB.addEventListener(Event.CHANGE, yearChanged);
			addChild(yearCB);

			levelCB = new EnergyComboBox();
			levelCB.move(LEVEL_CB_X, LEVEL_CB_Y);
			levelCB.setSize(LEVEL_CB_WIDTH, LEVEL_CB_HEIGHT);
			levelCB.prompt = EnergyConsts.DIFFICULTY_NAME;
      levelCB.addItem( { label: EnergyConsts.VERY_EASY_NAME } );
      levelCB.addItem( { label: EnergyConsts.EASY_NAME } );
      levelCB.addItem( { label: EnergyConsts.MEDIUM_NAME } );
      levelCB.addItem( { label: EnergyConsts.HARD_NAME } );
      levelCB.addItem( { label: EnergyConsts.VERY_HARD_NAME } );
      levelCB.addEventListener(Event.CHANGE, levelChanged);
			addChild(levelCB);
			
      // this has to be added after yearCB;
			energySectorCB = new EnergyComboBox();
			energySectorCB.move(ENERGY_SECTOR_CB_X, ENERGY_SECTOR_CB_Y);
			energySectorCB.setSize(ENERGY_SECTOR_CB_WIDTH, ENERGY_SECTOR_CB_HEIGHT);
			energySectorCB.prompt = EnergyConsts.ENERGY_SECTOR_NAME;
      energySectorCB.addItem( { label: data.currentDataItem.vehicleFuelSector.name } );
      energySectorCB.addItem( { label: data.currentDataItem.electricitySector.name } );
      energySectorCB.addItem( { label: data.currentDataItem.heatSector.name } );
      energySectorCB.addItem( { label: data.currentDataItem.efficiencySector.name } );
      energySectorCB.addEventListener(Event.CHANGE, energySectorChanged);
			addChild(energySectorCB);
			
			updateComboBoxes();
		}
    
    private function energySectorChanged(e:Event):void {
			data.curSector = energySectorCB.selectedLabel;
      displaySector(data.curSector);
    }
		
    private function levelChanged(e:Event):void {
      data.level = levelCB.selectedLabel;
			this.dispatchEvent(new EnergyEvent(EnergyEvent.UPDATE_ALL_VIEWS, true));
    }
		
    private function yearChanged(e:Event):void {
      data.year = yearCB.selectedItem.data;
			this.dispatchEvent(new EnergyEvent(EnergyEvent.UPDATE_ALL_VIEWS, true));
    }
		
		private function displaySector(selectedSector:String):void {
			this.removeCurrentSectorView();
      if (selectedSector == EnergyConsts.EFFICIENCY_INVESTMENT_NAME) {
        currentSectorView = createEfficiencySectorView();
      } else if (selectedSector == EnergyConsts.ELECTRICITY_NAME) {
        currentSectorView = createElectricitySectorView();
      } else if (selectedSector == EnergyConsts.HEAT_NAME) {
				currentSectorView = createHeatSectorView();
      } else if (selectedSector == EnergyConsts.VEHICLE_FUEL_NAME) {
				currentSectorView = createVehicleFuelSectorView();
			}
			if (currentSectorView) {
			  addChild(currentSectorView);
			}
		}
		
		private function removeCurrentSectorView():void {
      if (currentSectorView) {
        this.removeChild(currentSectorView);
        currentSectorView = null;
      }
		}
		
		private function createEfficiencySectorView():EnergySectorView {
			var sector:EnergySectorView = new EnergySectorView(data.currentDataItem.efficiencySector,
																												 EnergyConsts.EFFICIENCY_INVESTMENT_NAME,
																												 SECTOR_VIEW_X,
																												 SECTOR_VIEW_Y);
			sector.createSectorView();
			return sector;
		}
		
		private function createElectricitySectorView():EnergySectorView {
			var sector:EnergySectorView = new EnergySectorView(data.currentDataItem.electricitySector,
																												 EnergyConsts.ELECTRICITY_NAME,
																												 SECTOR_VIEW_X,
																												 SECTOR_VIEW_Y);
			sector.createSectorView();
			return sector;
		}
		
		private function createHeatSectorView():EnergySectorView {
			var sector:EnergySectorView = new EnergySectorView(data.currentDataItem.heatSector,
																												 EnergyConsts.HEAT_NAME,
																												 SECTOR_VIEW_X,
																												 SECTOR_VIEW_Y);
			sector.createSectorView();
			return sector;
		}
		
		private function createVehicleFuelSectorView():EnergySectorView {
			var sector:EnergySectorView = new EnergySectorView(data.currentDataItem.vehicleFuelSector,
																												 EnergyConsts.VEHICLE_FUEL_NAME,
																												 SECTOR_VIEW_X,
																												 SECTOR_VIEW_Y);
			sector.createSectorView();
			return sector;
		}
		
		private function updateComboBoxes():void {
			var idx:int = -1;
			switch (data.level) {
				case EnergyConsts.VERY_EASY_NAME:
				  idx = 0;
					break;
				case EnergyConsts.EASY_NAME:
				  idx = 1;
					break;
				case EnergyConsts.MEDIUM_NAME:
				  idx = 2;
					break;
				case EnergyConsts.HARD_NAME:
				  idx = 3;
					break;
				case EnergyConsts.VERY_HARD_NAME:
				  idx = 4;
					break;
			}
			levelCB.selectedIndex = idx;
			
			idx = 3;
			switch (data.year) {
				case 1990:
				  idx = 0;
					break;
				case 2000:
				  idx = 1;
					break;
				case 2010:
				  idx = 2;
					break;
				case 2020:
				  idx = 3;
					break;
				case 2030:
				  idx = 4;
					break;
				case 2040:
				  idx = 5;
					break;
				case 2050:
				  idx = 6;
					break;
			}
			yearCB.selectedIndex = idx;
			
			idx = -1;
			switch (data.curSector) {
				case EnergyConsts.VEHICLE_FUEL_NAME:
				  idx = 0;
					break;
				case EnergyConsts.ELECTRICITY_NAME:
				  idx = 1;
					break;
				case EnergyConsts.HEAT_NAME:
				  idx = 2;
					break;
				case EnergyConsts.EFFICIENCY_INVESTMENT_NAME:
				  idx = 3;
					break;
			}
			energySectorCB.selectedIndex = idx;
		}
		
		private function setupTitles():void {
			setupTextField2(EnergyConsts.GAME_TITLE,
										 GAME_TITLE_X, GAME_TITLE_Y,
										 EnergyConsts.GAME_WIDTH, GAME_TITLE_HEIGHT,
										 28);
			setupTextField2(EnergyConsts.ENERGY_SECTOR_NAME,
										 ENERGY_SECTOR_TITLE_X, ENERGY_SECTOR_TITLE_Y,
										 ENERGY_SECTOR_TITLE_WIDTH, ENERGY_SECTOR_TITLE_HEIGHT,
										 12);
			setupTextField2(EnergyConsts.DIFFICULTY_NAME,
										 LEVEL_TITLE_X, LEVEL_TITLE_Y,
										 LEVEL_TITLE_WIDTH, LEVEL_TITLE_HEIGHT,
										 12);
			setupTextField2(EnergyConsts.YEAR_NAME,
										 YEAR_TITLE_X, YEAR_TITLE_Y,
										 YEAR_TITLE_WIDTH, YEAR_TITLE_HEIGHT,
										 12);
			setupTextField2(EnergyConsts.OBJECTIVES_NAME,
										 OBJECTIVES_TITLE_X, OBJECTIVES_TITLE_Y,
										 OBJECTIVES_TITLE_WIDTH, OBJECTIVES_TITLE_HEIGHT,
										 12);
		}
		
		private function setupButtons():void {
			newBtn = new EnergyButton();
			newBtn.label = EnergyConsts.NEW_GAME_NAME;
			newBtn.move(FIRST_BUTTON_X, TOOL_BAR_Y2);
			newBtn.setSize(BUTTON_WIDTH, 22);
			newBtn.addEventListener(MouseEvent.CLICK, newGameBtnClicked, false, 0, true);
			addChild(newBtn);
			loadBtn = new EnergyButton();
			loadBtn.label = EnergyConsts.LOAD_GAME_NAME;
			loadBtn.move(FIRST_BUTTON_X + BUTTON_WIDTH + DISTANCE_BTW_BUTTONS, TOOL_BAR_Y2);
			loadBtn.setSize(BUTTON_WIDTH, 22);
			loadBtn.addEventListener(MouseEvent.CLICK, loadGameBtnClicked, false, 0, true);
			addChild(loadBtn);
    	saveBtn = new EnergyButton();
			saveBtn.label = EnergyConsts.SAVE_GAME_NAME;
			saveBtn.move(FIRST_BUTTON_X + BUTTON_WIDTH * 2 + DISTANCE_BTW_BUTTONS * 2, TOOL_BAR_Y2);
			saveBtn.setSize(BUTTON_WIDTH, 22);
			saveBtn.addEventListener(MouseEvent.CLICK, saveGameBtnClicked, false, 0, true);
			addChild(saveBtn);
		}
		
		private function saveGameBtnClicked(e:MouseEvent):void {
			fileRef = new FileReference();
			fileRef.addEventListener(Event.SELECT, onSaveFileSelected, false, 0, true);
			var xml:XML = this.data.save();
			var fName:String = EnergyConsts.ENERGY_NAME + " " + xml.@saveTime;
			fileRef.save(xml.toXMLString(), fName.concat(".xml"));
		}
		
		private function onSaveFileSelected(e:Event):void {
			fileRef.removeEventListener(Event.SELECT, onSaveFileSelected);
			fileRef.addEventListener(Event.COMPLETE, onSaveCompleted, false, 0, true); 
		} 

    private function onSaveCompleted(e:Event):void {
			fileRef.removeEventListener(Event.COMPLETE, onSaveCompleted);
		}

    private function loadGameBtnClicked(e:MouseEvent):void {
			fileRef = new FileReference();
			fileRef.addEventListener(Event.SELECT, onLoadFileSelected, false, 0, true);
			fileRef.browse();
		}
		
		private function onLoadFileSelected(e:Event):void	{
			fileRef.removeEventListener(Event.SELECT, onLoadFileSelected);
			fileRef.addEventListener(Event.COMPLETE, onLoadCompleted, false, 0, true);
			fileRef.load();
		}
		
		private function onLoadCompleted(e:Event):void {
			fileRef.removeEventListener(Event.COMPLETE, onLoadCompleted);
			view.loadGame(new XML(fileRef.data));
		}
		
		private function newGameBtnClicked(e:MouseEvent):void {
			view.loadGame(null);
		}
		
		private function setupCheckBoxes():void {
			var bg:Shape = new Shape();
			bg.graphics.lineStyle(1, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			bg.graphics.beginFill(EnergyConsts.PLAN_BACKGROUND_COLOR);
			bg.graphics.drawRect(OBJECTIVES_X + 2, TOOL_BAR_Y2, 295, 72);
			bg.graphics.endFill();
			addChild(bg);
			budgetLimitChB = new EnergyCheckBox();
			budgetLimitChB.label = EnergyConsts.BUDGET_LIMIT_NAME;
			budgetLimitChB.labelPlacement = ButtonLabelPlacement.RIGHT;
			budgetLimitChB.move(OBJECTIVES_X, TOOL_BAR_Y2);
			budgetLimitChB.setSize(150.00, 22.00);
			budgetLimitChB.addEventListener(MouseEvent.CLICK, checkBoxBtnClicked, false, 0, true);
			addChild(budgetLimitChB);
			oilLimitChB = new EnergyCheckBox();
			oilLimitChB.label = EnergyConsts.OIL_LIMIT_NAME;
			oilLimitChB.labelPlacement = ButtonLabelPlacement.RIGHT;
			oilLimitChB.move(OBJECTIVES_X, TOOL_BAR_Y2 + 17);
			oilLimitChB.setSize(150.00, 22.00);
			oilLimitChB.addEventListener(MouseEvent.CLICK, checkBoxBtnClicked, false, 0, true);
			addChild(oilLimitChB);
			ghgLimitChB = new EnergyCheckBox();
			ghgLimitChB.label = EnergyConsts.GHG_LIMIT_FULL_NAME;
			ghgLimitChB.labelPlacement = ButtonLabelPlacement.RIGHT;
			ghgLimitChB.move(OBJECTIVES_X, TOOL_BAR_Y2 + 34);
			ghgLimitChB.setSize(180.00, 22.00);
			ghgLimitChB.addEventListener(MouseEvent.CLICK, checkBoxBtnClicked, false, 0, true);
			addChild(ghgLimitChB);
			
			fuelMinChB = new EnergyCheckBox();
			fuelMinChB.label = EnergyConsts.FUEL_MINIMUM_NAME;
			fuelMinChB.labelPlacement = ButtonLabelPlacement.LEFT;
			fuelMinChB.move(OBJECTIVES_X + 179.5, TOOL_BAR_Y2);
			fuelMinChB.setSize(120, 22.00);
			fuelMinChB.addEventListener(MouseEvent.CLICK, checkBoxBtnClicked, false, 0, true);
			addChild(fuelMinChB);
			electricityMinChB = new EnergyCheckBox();
			electricityMinChB.label = EnergyConsts.ELECTRICITY_MINIMUM_NAME;
			electricityMinChB.labelPlacement = ButtonLabelPlacement.LEFT;
			electricityMinChB.move(OBJECTIVES_X + 152.5, TOOL_BAR_Y2 + 17);
			electricityMinChB.setSize(147, 22.00);
			electricityMinChB.addEventListener(MouseEvent.CLICK, checkBoxBtnClicked, false, 0, true);
			addChild(electricityMinChB);
			heatMinChB = new EnergyCheckBox();
			heatMinChB.label = EnergyConsts.HEAT_MINIMUM_NAME;
			heatMinChB.labelPlacement = ButtonLabelPlacement.LEFT;
			heatMinChB.move(OBJECTIVES_X + 179.5, TOOL_BAR_Y2 + 34);
			heatMinChB.setSize(120, 22.00);
			heatMinChB.addEventListener(MouseEvent.CLICK, checkBoxBtnClicked, false, 0, true);
			addChild(heatMinChB);
			energyMinChB = new EnergyCheckBox();
			energyMinChB.label = EnergyConsts.TOTAL_ENERGY_MINIMUM_NAME;
			energyMinChB.labelPlacement = ButtonLabelPlacement.LEFT;
			energyMinChB.move(OBJECTIVES_X + 139.5, TOOL_BAR_Y2 + 51);
			energyMinChB.setSize(160, 22.00);
			energyMinChB.addEventListener(MouseEvent.CLICK, checkBoxBtnClicked, false, 0, true);
			addChild(energyMinChB);
			
			updateCheckBoxes();
		}
		
		private function updateCheckBoxes():void {
			budgetLimitChB.selected = data.budgetLimitChBSelected;
			oilLimitChB.selected = data.oilLimitChBSelected;
			ghgLimitChB.selected = data.ghgLimitChBSelected;
			electricityMinChB.selected = data.electricityMinChBSelected;
			energyMinChB.selected = data.energyMinChBSelected;
			heatMinChB.selected = data.heatMinChBSelected;
			fuelMinChB.selected = data.fuelMinChBSelected;
		}
		
		private function checkBoxBtnClicked(e:MouseEvent):void {
			data.budgetLimitChBSelected = budgetLimitChB.selected;
			data.oilLimitChBSelected = oilLimitChB.selected;
			data.ghgLimitChBSelected = ghgLimitChB.selected;
			data.electricityMinChBSelected = electricityMinChB.selected;
			data.energyMinChBSelected = energyMinChB.selected;
			data.heatMinChBSelected = heatMinChB.selected;
			data.fuelMinChBSelected = fuelMinChB.selected;
			this.dispatchEvent(new EnergyEvent(EnergyEvent.UPDATE_OBJECTIVES, true));
		}
  }
}