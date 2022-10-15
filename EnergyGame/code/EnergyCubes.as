package code {

  import flash.display.*;
  import flash.text.*;
  import flash.geom.*;

  public class EnergyCubes extends Sprite {

		const VEHICLE_X_POSITION:int = 0;
		const ELECTRICITY_X_POSITION:int = 60;
		const ENERGY_X_POSITION:int = 120;
		// title height 25 is not included in the MAX_CUBE_HEIGHT;
		const MAX_CUBE_HEIGHT:int = 420;
		const ELECTRICITY_Y_BASE:int = 445;
		const VEHICLE_Y_BASE:int = 445;
		const ENERGY_Y_BASE:int = 445;

    var data:EnergyData;
		var xPos:Number;
		var yPos:Number;
		var vehicleCube:EnergyCube;
		var electricityCube:EnergyCube;
		var energyCube:EnergyCube;
		var vehicleHeight:Number;
		var electricityHeight:Number;
		var energyHeight:Number;
		var cubeHeightPerUnit:Number;

    public function EnergyCubes(data:EnergyData,
															 x:Number,
															 y:Number) {
			this.data = data;
			xPos = x;
			yPos = y;
			
			cubeHeightPerUnit = MAX_CUBE_HEIGHT / (data.getMaxEnergyNeedsInAllYears() + data.getMaxEfficiencyLimitInAllYears());
			updateUsage(true);
    }
		
		public function updateUsage(limitChanged:Boolean):void {
			if (limitChanged) {
				removeChildren();
				createCubes();
			}
			var dataItem:EnergyDataItem = this.data.currentDataItem;
			var vHeight:Number = Math.round(vehicleHeight * dataItem.vehicleFuel / dataItem.vehicleFuelLimit);
			var color:uint = (dataItem.vehicleFuel < dataItem.vehicleFuelMinimum) ?
												EnergyConsts.CUBE_GRAY_COLOR : EnergyConsts.VEHICLE_CUBE_COLOR;
			vehicleCube.updateUsage(vHeight, color);
			vHeight = Math.round(electricityHeight * dataItem.electricity / dataItem.electricityLimit);
			color = (dataItem.electricity < dataItem.electricityRequired) ?
							 EnergyConsts.CUBE_GRAY_COLOR : EnergyConsts.ELECTRICITY_CUBE_COLOR;
			electricityCube.updateUsage(vHeight, color);
			vHeight = Math.round(energyHeight * dataItem.total / this.data.getMaxEnergyNeedsInAllYears());
			color = (dataItem.total < dataItem.energyNeeds) ?
							 EnergyConsts.CUBE_GRAY_COLOR : EnergyConsts.ENERGY_CUBE_COLOR;
			energyCube.updateUsage(vHeight, color);
		}
		
		function createCubes():void {
			vehicleHeight = Math.round(this.data.currentDataItem.vehicleFuelLimit * cubeHeightPerUnit);
			vehicleCube = new EnergyCube(data, xPos + VEHICLE_X_POSITION, yPos + VEHICLE_Y_BASE,
																	 vehicleHeight,
																	 EnergyConsts.FUEL_NAME,
																	 new VehicleMC());
			addChild(vehicleCube);
			electricityHeight = Math.round(this.data.currentDataItem.electricityLimit * cubeHeightPerUnit);
			electricityCube = new EnergyCube(data, xPos + ELECTRICITY_X_POSITION, yPos + ELECTRICITY_Y_BASE,
																			 electricityHeight,
																			 EnergyConsts.ELECTRICITY_NAME,
																			 new ElectricityMC());
			addChild(electricityCube);
			energyHeight = Math.round(this.data.getMaxEnergyNeedsInAllYears() * cubeHeightPerUnit);
			energyCube = new EnergyCube(data, xPos + ENERGY_X_POSITION, yPos + ENERGY_Y_BASE,
																			 energyHeight,
																			 EnergyConsts.ENERGY_NAME,
																			 new HeatMC());
			addChild(energyCube);
		}

		function removeChildren():void {
			if (numChildren <= 0) { return; }
			for (var i:int = numChildren - 1; i >= 0; i--) {
				removeChildAt(i);
			}
		}

  }
}