package code {

  import flash.display.*;
  import flash.geom.*;
	import flash.events.*;

  public class EnergyFuel extends EnergyGraphBase {

    private var data:EnergyData;
		private var xBase:Number;
		private var yBase:Number;
		private var fuelCube:EnergyCube;
		private var fuelHeight:Number;
		private var maxEnergyNeedsInAllYears:Number;

    public function EnergyFuel(data:EnergyData,
															 xBase:Number,
															 yBase:Number) {
			super(EnergyConsts.FUEL_NAME);
			this.data = data;
			this.xBase = xBase;
			this.yBase = yBase - TITLE_HEIGHT;
			this.maxEnergyNeedsInAllYears = data.getMaxEnergyNeedsInAllYears();
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			fuelCube = null;
			updateUsage(true);
    }
		
		public function updateUsage(limitChanged:Boolean):void {
			if (limitChanged) {
				createCube();
			}
			var dataItem:EnergyDataItem = this.data.currentDataItem;
			var sourceValue:Number = dataItem.vehicleFuel;
			super.sourceValueTF.text = String(Math.round(sourceValue));
			var vHeight:Number;
			var color:uint;
			if (data.isReadOnlyData) {
				vHeight = fuelHeight;
				color = EnergyConsts.GOAL_MET_COLOR;
			}
			else {
				vHeight = Math.round(fuelHeight * sourceValue / dataItem.vehicleFuelLimit);
				color = (sourceValue < dataItem.vehicleFuelMinimum) ?
									EnergyConsts.GOAL_NOT_MET_COLOR : EnergyConsts.GOAL_MET_COLOR;
			}
			fuelCube.updateUsage(vHeight, color);
		}
		
		private function createCube():void {
			super.clearContainer();
			super.container = new Sprite();
			var ratio:Number;
			if (data.isReadOnlyData)
			  ratio = data.currentDataItem.vehicleFuel / maxEnergyNeedsInAllYears;
		  else
				ratio = data.currentDataItem.vehicleFuelLimit / maxEnergyNeedsInAllYears;
			var uiR:Number = Math.sqrt(ratio);
			fuelHeight = Math.round(MAX_CUBE_HEIGHT * ratio);
			var fuelWidth:Number = Math.round(MAX_CUBE_WIDTH * uiR);
			var fuelMC:MovieClip = new VehicleMC();
			var mtx:Matrix = new Matrix(uiR, 0, 0, uiR);
			fuelMC.transform.matrix = mtx;
			var xPos:Number = xBase + (1 - uiR) * MAX_CUBE_WIDTH / 2;
			var deltaX:Number = Math.round(MAX_CUBE_DELTA_X * uiR);
			var deltaY:Number = Math.round(MAX_CUBE_DELTA_Y * uiR);
			
			fuelCube = new EnergyCube(data, xPos, yBase,
																fuelWidth, fuelHeight, deltaX, deltaY, 
																fuelMC);
			super.container.addChild(fuelCube);
			addChild(super.container);
			super.setupTitle(xPos, yBase, fuelWidth);
			super.setupSourceValueField(xPos + deltaX, yBase - fuelHeight - TITLE_HEIGHT - deltaY, fuelWidth);
		}
  }
}