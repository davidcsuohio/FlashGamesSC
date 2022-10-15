package code {

	import flash.events.*;
	import flash.text.*;

  public class EnergyInfoActual extends EnergyInfoBase {

		private var heatText:TextField;
		private var oilText:TextField;
		private var ghgText:TextField;
		private var elecText:TextField;
		private var energyText:TextField;
		private var fuelText:TextField;
		private var heatValue:TextField;
		private var oilValue:TextField;
		private var ghgValue:TextField;
		private var elecValue:TextField;
		private var energyValue:TextField;
		private var fuelValue:TextField;

    public function EnergyInfoActual(data:EnergyData,
															 			 x:Number,
																		 y:Number) {
			super(data, x, y);
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			super.setupBackground();
			super.setupTitle(EnergyConsts.ACTUAL_NAME);
			setupInfo();
			updateInfo();
    }
		
		private function updateInfo():void {
			heatValue.text = String(Math.round(data.currentDataItem.heat));
			oilValue.text = String(Math.round(data.currentDataItem.totalOil));
			ghgValue.text = String(Math.round(data.currentDataItem.ghgMtonnes));
			elecValue.text = String(Math.round(data.currentDataItem.electricity));
			energyValue.text = String(Math.round(data.currentDataItem.total));
			heatValue.text = String(Math.round(data.currentDataItem.heat));
			fuelValue.text = String(Math.round(data.currentDataItem.vehicleFuel));
		}
		
		private function setupInfo():void {
			this.oilText = new TextField();
			super.setupSecondRowLeftText(oilText, EnergyConsts.OIL_NAME);
			this.oilValue = new TextField();
			super.setupSecondRowLeftValue(oilValue);
			this.ghgText = new TextField();
			super.setupThirdRowLeftText(ghgText, EnergyConsts.GHG_NAME);
			this.ghgValue = new TextField();
			super.setupThirdRowLeftValue(ghgValue);
			
			this.fuelText = new TextField();
			super.setupFirstRowRightText(fuelText, EnergyConsts.FUEL_NAME);
			this.fuelValue = new TextField();
			super.setupFirstRowRightValue(fuelValue);
			this.elecText = new TextField();
			super.setupSecondRowRightText(elecText, EnergyConsts.ELECTRICITY_NAME);
			this.elecValue = new TextField();
			super.setupSecondRowRightValue(elecValue);
			this.heatText = new TextField();
			super.setupThirdRowRightText(heatText, EnergyConsts.HEAT_NAME);
			this.heatValue = new TextField();
			super.setupThirdRowRightValue(heatValue);
			this.energyText = new TextField();
			super.setupFourthRowRightText(energyText, EnergyConsts.ENERGY_NAME);
			this.energyValue = new TextField();
			super.setupFourthRowRightValue(energyValue);
		}
		
  }
}