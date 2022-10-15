package code {

	import flash.events.*;
	import flash.text.*;

  public class EnergyInfoObjective extends EnergyInfoBase {

		private var budgetLimitText:TextField;
		private var oilLimitText:TextField;
		private var ghgLimitText:TextField;
		private var elecMinText:TextField;
		private var energyMinText:TextField;
		private var heatMinText:TextField;
		private var fuelMinText:TextField;
		private var budgetLimitValue:TextField;
		private var oilLimitValue:TextField;
		private var ghgLimitValue:TextField;
		private var elecMinValue:TextField;
		private var energyMinValue:TextField;
		private var heatMinValue:TextField;
		private var fuelMinValue:TextField;

    public function EnergyInfoObjective(data:EnergyData,
															 					x:Number,
																				y:Number) {
			super(data, x, y);
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			super.setupBackground();
			super.setupTitle(EnergyConsts.OBJECTIVES_NAME);
			setupInfo();
			updateInfo();
    }
		
		public function updateInfo():void {
			budgetLimitValue.text = String(Math.round(data.currentDataItem.budgetLimit));
			oilLimitValue.text = String(Math.round(data.currentDataItem.oilLimit));
			ghgLimitValue.text = String(Math.round(data.currentDataItem.ghgLimit));
			elecMinValue.text = String(Math.round(data.currentDataItem.electricityRequired));
			energyMinValue.text = String(Math.round(data.currentDataItem.energyNeeds));
			heatMinValue.text = String(Math.round(data.currentDataItem.heatMinimum));
			fuelMinValue.text = String(Math.round(data.currentDataItem.vehicleFuelMinimum));
		}
		
		public function displayBudget(display:Boolean):void {
			if (display) {
				if (!budgetLimitText.parent) {
					addChild(budgetLimitText);
					addChild(budgetLimitValue);
				}
			}
			else {
				if (budgetLimitText.parent) {
					removeChild(budgetLimitText);
					removeChild(budgetLimitValue);
				}
			}
		}
		
		public function displayOil(display:Boolean):void {
			if (display) {
				if (!oilLimitText.parent) {
					addChild(oilLimitText);
					addChild(oilLimitValue);
				}
			}
			else {
				if (oilLimitText.parent) {
					removeChild(oilLimitText);
					removeChild(oilLimitValue);
				}
			}
		}
		
		public function displayGhg(display:Boolean):void {
			if (display) {
				if (!ghgLimitText.parent) {
					addChild(ghgLimitText);
					addChild(ghgLimitValue);
				}
			}
			else {
				if (ghgLimitText.parent) {
					removeChild(ghgLimitText);
					removeChild(ghgLimitValue);
				}
			}
		}
		
		public function displayElec(display:Boolean):void {
			if (display) {
				if (!elecMinText.parent) {
					addChild(elecMinText);
					addChild(elecMinValue);
				}
			}
			else {
				if (elecMinText.parent) {
					removeChild(elecMinText);
					removeChild(elecMinValue);
				}
			}
		}
		
		public function displayEnergy(display:Boolean):void {
			if (display) {
				if (!energyMinText.parent) {
					addChild(energyMinText);
					addChild(energyMinValue);
				}
			}
			else {
				if (energyMinText.parent) {
					removeChild(energyMinText);
					removeChild(energyMinValue);
				}
			}
		}
		
		public function displayHeat(display:Boolean):void {
			if (display) {
				if (!heatMinText.parent) {
					addChild(heatMinText);
					addChild(heatMinValue);
				}
			}
			else {
				if (heatMinText.parent) {
					removeChild(heatMinText);
					removeChild(heatMinValue);
				}
			}
		}
		
		public function displayFuel(display:Boolean):void {
			if (display) {
				if (!fuelMinText.parent) {
					addChild(fuelMinText);
					addChild(fuelMinValue);
				}
			}
			else {
				if (fuelMinText.parent) {
					removeChild(fuelMinText);
					removeChild(fuelMinValue);
				}
			}
		}
		
		private function setupInfo():void {
			this.budgetLimitText = new TextField();
			super.setupFirstRowLeftText(budgetLimitText, EnergyConsts.BUDGET_LIMIT_NAME);
			this.budgetLimitValue = new TextField();
			super.setupFirstRowLeftValue(budgetLimitValue);
			this.oilLimitText = new TextField();
			super.setupSecondRowLeftText(oilLimitText, EnergyConsts.OIL_LIMIT_NAME);
			this.oilLimitValue = new TextField();
			super.setupSecondRowLeftValue(oilLimitValue);
			this.ghgLimitText = new TextField();
			super.setupThirdRowLeftText(ghgLimitText, EnergyConsts.GHG_LIMIT_NAME);
			this.ghgLimitValue = new TextField();
			super.setupThirdRowLeftValue(ghgLimitValue);
			
			this.fuelMinText = new TextField();
			super.setupFirstRowRightText(fuelMinText, EnergyConsts.FUEL_MIN_NAME);
			this.fuelMinValue = new TextField();
			super.setupFirstRowRightValue(fuelMinValue);
			this.elecMinText = new TextField();
			super.setupSecondRowRightText(elecMinText, EnergyConsts.ELECTRICITY_MIN_NAME);
			this.elecMinValue = new TextField();
			super.setupSecondRowRightValue(elecMinValue);
			this.heatMinText = new TextField();
			super.setupThirdRowRightText(heatMinText, EnergyConsts.HEAT_MIN_NAME);
			this.heatMinValue = new TextField();
			super.setupThirdRowRightValue(heatMinValue);
			this.energyMinText = new TextField();
			super.setupFourthRowRightText(energyMinText, EnergyConsts.ENERGY_MIN_NAME);
			this.energyMinValue = new TextField();
			super.setupFourthRowRightValue(energyMinValue);
		}
		
  }
}