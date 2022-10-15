package code {

  import flash.display.*;
  import flash.geom.*;
	import flash.events.*;

  public class EnergyHeat extends EnergyGraphBase {

    private var data:EnergyData;
		private var xBase:Number;
		private var yBase:Number;
		private var heatCube:EnergyCube;
		private var heatHeight:Number;
		private var maxEnergyNeedsInAllYears:Number;

    public function EnergyHeat(data:EnergyData,
															 xBase:Number,
															 yBase:Number) {
			super(EnergyConsts.HEAT_NAME);
			this.data = data;
			this.xBase = xBase;
			this.yBase = yBase - TITLE_HEIGHT;
			this.maxEnergyNeedsInAllYears = data.getMaxEnergyNeedsInAllYears();
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			heatCube = null;
			updateUsage(true);
    }
		
		public function updateUsage(limitChanged:Boolean):void {
			if (limitChanged) {
				createCube();
			}
			var dataItem:EnergyDataItem = this.data.currentDataItem;
			var sourceValue:Number = dataItem.heat;
			super.sourceValueTF.text = String(Math.round(sourceValue));
			var vHeight:Number;
			var color:uint;
			if (data.isReadOnlyData) {
				vHeight = heatHeight;
				color = EnergyConsts.GOAL_MET_COLOR;
			}
			else {
				vHeight = Math.round(heatHeight * sourceValue / dataItem.heatLimit);
				color = (sourceValue < dataItem.heatMinimum) ?
									EnergyConsts.GOAL_NOT_MET_COLOR : EnergyConsts.GOAL_MET_COLOR;
			}
			heatCube.updateUsage(vHeight, color);
		}
		
		private function createCube():void {
			super.clearContainer();
			super.container = new Sprite();
			var ratio:Number;
			if (data.isReadOnlyData)
			  ratio = data.currentDataItem.heat / maxEnergyNeedsInAllYears;
		  else
				ratio = data.currentDataItem.heatLimit / maxEnergyNeedsInAllYears;
			var uiR:Number = Math.sqrt(ratio);
			heatHeight = Math.round(MAX_CUBE_HEIGHT * ratio);
			var heatWidth:Number = Math.round(MAX_CUBE_WIDTH * uiR);
			var heatMC:MovieClip = new HeatMC();
			var mtx:Matrix = new Matrix(uiR, 0, 0, uiR);
			heatMC.transform.matrix = mtx;
			var xPos:Number = xBase + (1 - uiR) * MAX_CUBE_WIDTH / 2;
			var deltaX:Number = Math.round(MAX_CUBE_DELTA_X * uiR);
			var deltaY:Number = Math.round(MAX_CUBE_DELTA_Y * uiR);
			
			heatCube = new EnergyCube(data, xPos, yBase,
																heatWidth, heatHeight, deltaX, deltaY, 
																heatMC);
			super.container.addChild(heatCube);
			addChild(super.container);
			super.setupTitle(xPos, yBase, heatWidth);
			super.setupSourceValueField(xPos + deltaX, yBase - heatHeight - TITLE_HEIGHT - deltaY, heatWidth);
		}
  }
}