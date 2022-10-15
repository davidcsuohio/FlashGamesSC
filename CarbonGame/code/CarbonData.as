package code {

  public class CarbonData {
		
    private var actions:Vector.<CarbonActionCategoryData>;
		// this variable is used to access the GUI such as updating the score fields when
		// user made changes to the sliders.
		// It should use event/delegate mechanism to do data binding in the future 
		// so that we could remove all the variables that serve this purpose (back reference).
		// For example, the CarbonData variable in CarbonActionCategoryData,
		// the CarbonActionCategoryData variable in CarbonActionData.
		// For now it will update all the score fields while updating.
		private var view:CarbonView;

    public function CarbonData(view:CarbonView) {
			this.view = view;
      this.actions = new Vector.<CarbonActionCategoryData>();
			setupCarbonData();
    }

    public function setupCarbonData():void {
      // setup Energy Efficiency data
			var actionCategory:CarbonActionCategoryData = new CarbonActionCategoryData(this, 50, CarbonConsts.ENERGY_EFFICIENCY_CATEGORY_NAME);
			var action:CarbonActionData = new CarbonActionData(actionCategory, CarbonConsts.GEOTHERMAL_HEATING_COOLING, 4, -6, 0, -3, 5);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.IMPROVE_INSULATION, 15, -20, 0, -10, 10);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.INCREASE_CAR_MPG, 12, -10, 0, -5, 10);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.INCREASE_TRUCK_MPG, 10, -7, 0, -4, 10);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.INSTALL_SUNLIGHT_FILTERING_WINDOWS, 5, -6, 0, -3, 3);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.RIDE_TRAIN_INSTEAD_OF_DRIVING_OR_FLYING, 4, -12, 0, -6, 10);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.TURN_OFF_COMPUTERS_AND_TVS, 4, -8, 0, -4, 5);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.USE_CFL_LIGHTBULBS, 4, -16, 0, -8, 10);
			actionCategory.addAction(action);
			this.actions.push(actionCategory);

      // setup Energy Production data
			actionCategory = new CarbonActionCategoryData(this, 75, CarbonConsts.ENERGY_PRODUCTION_CATEGORY_NAME);
			action = new CarbonActionData(actionCategory, CarbonConsts.CO2_CAPTURE, 20, -4, 0, -2, 0);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.HYDROGEN_FUELED_CARS, 5, -1, 0, -1, 5);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.BIOFUELED_CARS_TRUCKS, 3, -3, 0, -2, 3);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.MIX_IN_WOOD_IN_COAL_PLANTS, 10, -4, 0, -2, 4);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.SOLAR_PANELS_ON_ROOFTOPS, 10, -2, 0, -1, 7);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.REPLACE_COAL_WITH_NATURAL_GAS_POWER_PLANTS, 5, -2, 0, -1, 0);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.REPLACE_COAL_WITH_NUCLEAR_POWER_PLANTS, 20, -6, 0, -3, 10);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.REPLACE_COAL_WITH_SOLAR_ENERGY_POWER_PLANTS, 20, -1, 0, -1, 10);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.REPLACE_COAL_WITH_WIND_FARMS, 10, -4, 0, -2, 10);
			actionCategory.addAction(action);
			this.actions.push(actionCategory);
			
      // setup Land Management data
			actionCategory = new CarbonActionCategoryData(this, 25, CarbonConsts.LAND_MANAGEMENT_CATEGORY_NAME);
			action = new CarbonActionData(actionCategory, CarbonConsts.CONSERVATION_TILLAGE, 5, -6, 10, -3, 0);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.PLANT_TREES_ON_MEDIOCRE_FARMLAND, 30, -6, 15, -3, 0);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.REDUCE_QUANTITY_OF_CATTLE, 5, -6, 5, -3, 0);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.RESTORE_WETLANDS_ON_FARMLAND, 5, -8, 20, -4, 0);
			actionCategory.addAction(action);
			action = new CarbonActionData(actionCategory, CarbonConsts.REPLACE_CEMENT_WITH_OTHER_BUILDING_MATERIALS, 5, -3, 0, -2, 0);
			actionCategory.addAction(action);
			this.actions.push(actionCategory);
    }
		
		public function getTotalSpent():int {
			var number:int = 0;
			var len:uint = this.actions.length;
			for (var i:uint = 0; i < len; i++) {
				number += this.actions[i].getNumber();
			}
			return number;
		}
		
		public function getTotalScore():int {
			var number:int = 0;
			var len:uint = this.actions.length;
			for (var i:uint = 0; i < len; i++) {
				number += this.actions[i].getTotal();
			}
			return number;
		}

		public function getOptionsRemaining():int {
			var ret:int = 100 - getTotalSpent();
			return ret > 0 ? ret : 0;
		}
		
		public function getActionCategoryData(categoryIndex:int):CarbonActionCategoryData {
			return this.actions[categoryIndex];
		}

    public function updateScores():void {
			view.updateScores();
		}

  }
}