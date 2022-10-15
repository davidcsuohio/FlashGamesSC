package code {

  import flash.display.*;
  import flash.geom.*;
	import flash.events.*;

  // the width of energy cube never change;
  public class EnergyEnergy extends EnergyGraphBase {

    private var data:EnergyData;
		private var xBase:Number;
		private var yBase:Number;
		private var energyCube:EnergyCubeTwo;
		private var energyHeight:Number;
		private var efficiencyHeight:Number;
		private var maxEnergyNeedsInAllYears:Number;
		private var maxEfficiencyLimitInAllYears:Number;
		private var xPos:Number;
		private var energyWidth:Number;
		private var deltaX:Number;
		private var deltaY:Number;

    public function EnergyEnergy(data:EnergyData,
																 xBase:Number,
																 yBase:Number) {
			super(EnergyConsts.ENERGY_NAME);
			this.data = data;
			this.xBase = xBase;
			this.yBase = yBase - TITLE_HEIGHT;
			this.maxEnergyNeedsInAllYears = data.getMaxEnergyNeedsInAllYears();
			this.maxEfficiencyLimitInAllYears = data.getMaxEfficiencyLimitInAllYears();
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			energyCube = null;
			updateUsage(true);
    }
		
		public function updateUsage(limitChanged:Boolean):void {
			if (limitChanged) {
				createCube();
			}
			var dataItem:EnergyDataItem = this.data.currentDataItem;
			var sourceValue:Number = dataItem.total;
			var eHeight:Number;
			var color:uint;
			var efficHeight:Number;
			if (data.isReadOnlyData) {
				eHeight = energyHeight;
				color = EnergyConsts.GOAL_MET_COLOR;
				efficHeight = 0;
			}
			else {
				var eNeedsPerLevel:Number = dataItem.energyNeedsPerLevel;
				if (sourceValue <= eNeedsPerLevel)
					eHeight = Math.round(energyHeight * sourceValue / dataItem.energyNeedsPerLevel);
				else if (sourceValue <= maxEnergyNeedsInAllYears)
					eHeight = energyHeight +
										Math.round((MAX_CUBE_HEIGHT - energyHeight) * (sourceValue - eNeedsPerLevel) / (maxEnergyNeedsInAllYears - eNeedsPerLevel));
				else if (sourceValue > maxEnergyNeedsInAllYears)
					eHeight = MAX_CUBE_HEIGHT + 
										Math.round((sourceValue - maxEnergyNeedsInAllYears) * MAX_CUBE_HEIGHT / maxEnergyNeedsInAllYears);
				color = (sourceValue < dataItem.energyNeeds) ?
							 EnergyConsts.GOAL_NOT_MET_COLOR : EnergyConsts.GOAL_MET_COLOR;
				efficHeight = Math.round(efficiencyHeight * dataItem.efficiency / maxEfficiencyLimitInAllYears);
			}
			if (eHeight > energyHeight)
				super.setupSourceValueField(xPos + deltaX,
																		yBase - TITLE_HEIGHT - eHeight - deltaY,
																		energyWidth);
			else
				super.setupSourceValueField(xPos + deltaX,
																		yBase - TITLE_HEIGHT - energyHeight - deltaY,
																		energyWidth);
			// this statement has to be after super.setupSourceValueField();
			super.sourceValueTF.text = String(Math.round(sourceValue));
			energyCube.updateUsages(eHeight, color, efficHeight);
		}
		
		private function createCube():void {
			super.clearContainer();
			super.container = new Sprite();
			var ratio:Number;
			var eNeedsPerLevel:Number = data.currentDataItem.energyNeedsPerLevel;
			if (data.isReadOnlyData)
				ratio = data.currentDataItem.total / maxEnergyNeedsInAllYears;
			else
				ratio = eNeedsPerLevel / maxEnergyNeedsInAllYears;
			var uiR:Number = Math.sqrt(ratio);
			energyHeight = Math.round(MAX_CUBE_HEIGHT * ratio);
			energyWidth = Math.round(MAX_CUBE_WIDTH * uiR);
			var mtx:Matrix = new Matrix(uiR, 0, 0, uiR);
			var efficMC:MovieClip = new EfficiencyMC();
			efficMC.transform.matrix = mtx;
			xPos = xBase + (1 - uiR) * MAX_CUBE_WIDTH / 2;
			deltaX = Math.round(MAX_CUBE_DELTA_X * uiR);
			deltaY = Math.round(MAX_CUBE_DELTA_Y * uiR);
			if (data.isReadOnlyData)
				efficiencyHeight = 0;
			else
				efficiencyHeight = Math.round(maxEfficiencyLimitInAllYears * energyHeight / eNeedsPerLevel);

			energyCube = new EnergyCubeTwo(data, xPos, yBase,
																		 energyWidth, deltaX, deltaY,
																		 energyHeight,
																		 efficiencyHeight,
																		 efficMC);
			super.container.addChild(energyCube);
			addChild(super.container);
			super.setupTitle(xPos, yBase, energyWidth);
		}
  }
}