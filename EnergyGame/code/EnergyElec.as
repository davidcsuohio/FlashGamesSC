package code {

  import flash.display.*;
  import flash.geom.*;
	import flash.events.*;

  public class EnergyElec extends EnergyGraphBase {

    private var data:EnergyData;
		private var xBase:Number;
		private var yBase:Number;
		private var elecCube:EnergyCube;
		private var elecHeight:Number;
		private var maxEnergyNeedsInAllYears:Number;

    public function EnergyElec(data:EnergyData,
															 xBase:Number,
															 yBase:Number) {
			super(EnergyConsts.ELEC_NAME);
			this.data = data;
			this.xBase = xBase;
			this.yBase = yBase - TITLE_HEIGHT;
			this.maxEnergyNeedsInAllYears = data.getMaxEnergyNeedsInAllYears();
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			elecCube = null;
			updateUsage(true);
    }
		
		public function updateUsage(limitChanged:Boolean):void {
			if (limitChanged) {
				createCube();
			}
			var dataItem:EnergyDataItem = this.data.currentDataItem;
			var sourceValue:Number = dataItem.electricity;
			super.sourceValueTF.text = String(Math.round(sourceValue));
			var eHeight:Number;
			var color:uint;
			if (data.isReadOnlyData) {
				eHeight = elecHeight;
				color = EnergyConsts.GOAL_MET_COLOR;
			}
			else {
				var goal:Number = dataItem.electricityRequired;
				eHeight = Math.round(elecHeight * sourceValue / dataItem.electricityLimit);
				color = (goal == 0 || sourceValue < goal) ?
							 EnergyConsts.GOAL_NOT_MET_COLOR : EnergyConsts.GOAL_MET_COLOR;
			}
			elecCube.updateUsage(eHeight, color);
		}
		
		private function createCube():void {
			super.clearContainer();
			super.container = new Sprite();
			var ratio:Number;
			if (data.isReadOnlyData)
				ratio = data.currentDataItem.electricity / maxEnergyNeedsInAllYears;
			else
				ratio = data.currentDataItem.electricityLimit / maxEnergyNeedsInAllYears;
			var uiR:Number = Math.sqrt(ratio);
			elecHeight = Math.round(MAX_CUBE_HEIGHT * ratio);
			var elecWidth:Number = Math.round(MAX_CUBE_WIDTH * uiR);
			var elecMC:MovieClip = new ElectricityMC();
			var mtx:Matrix = new Matrix(uiR, 0, 0, uiR);
			elecMC.transform.matrix = mtx;
			var xPos:Number = xBase + (1 - uiR) * MAX_CUBE_WIDTH / 2;
			var deltaX:Number = Math.round(MAX_CUBE_DELTA_X * uiR);
			var deltaY:Number = Math.round(MAX_CUBE_DELTA_Y * uiR);
			
			elecCube = new EnergyCube(data, xPos, yBase,
																elecWidth, elecHeight, deltaX, deltaY,
																elecMC);
			super.container.addChild(elecCube);
			addChild(super.container);
			super.setupTitle(xPos, yBase, elecWidth);
			super.setupSourceValueField(xPos + deltaX, yBase - elecHeight - TITLE_HEIGHT - deltaY, elecWidth);
		}
  }
}