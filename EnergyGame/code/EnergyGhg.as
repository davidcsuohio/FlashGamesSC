package code {
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;

  public class EnergyGhg extends EnergyGraphBase {

		//0,0,105.35x201.35
		//18.65, 0, 86.70x125.35
		//0,0,97.80x74.20
		private const CLOUD_X_BASE:Number = 18.65;
		private const CLOUD_Y_BASE:Number = 76;
		private const MAX_CLOUD_WIDTH:Number = 86.70;
		private const MAX_CLOUD_HEIGHT:Number = 125.35;
		private const CLOUD_TROUGH_X_RATIO:Number = 0.39;
		private const MASK_WIDTH:Number = 87;

    private var data:EnergyData;
		private var xPos:Number;
		private var yBase:Number;
		private var ghgRedBaseMC:MovieClip;
		private var ghgGreenBaseMC:MovieClip;
		private var ghgEmptyGasMC:MovieClip;
		private var ghgGreenGasMC:MovieClip;
		private var ghgRedGasMC:MovieClip;
		private var ghgMask:Shape;
		private var ghgGasHeight:Number;
		private var maxGhgLimitInAllYears:Number;

    public function EnergyGhg(data:EnergyData, x:Number, yBase:Number) {
			super(EnergyConsts.GHG_NAME);
			this.data = data;
			xPos = x;
			this.yBase = yBase - TITLE_HEIGHT;
			this.maxGhgLimitInAllYears = data.getMaxGhgLimitInAllYears();

			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			updateUsage(true);
    }
		
		public function updateUsage(limitChanged:Boolean):void {
			super.clearContainer();
			super.container = new Sprite();
			if (limitChanged) {
				createGhg();
			}
			var ghg:Number = this.data.currentDataItem.ghgMtonnes;
			super.sourceValueTF.text = String(Math.round(ghg));
			if (data.isReadOnlyData) {
				super.container.addChild(ghgGreenBaseMC);
				ghgGreenGasMC.mask = null;
				super.container.addChild(ghgGreenGasMC);
				addChild(super.container);
				return;
			}
			var limit:Number = this.data.currentDataItem.ghgLimit;
			if (ghg > limit) {
				super.container.addChild(ghgRedBaseMC);
				super.container.addChild(ghgRedGasMC);
			}
			else if (ghg == limit) {
				super.container.addChild(ghgGreenBaseMC);
				ghgGreenGasMC.mask = null;
				super.container.addChild(ghgGreenGasMC);
			}
			else {
				super.container.addChild(ghgGreenBaseMC);
				var ghgH:Number = Math.round(ghgGasHeight * ghg / limit);
				ghgGreenGasMC.mask = null;
				super.container.addChild(ghgEmptyGasMC);
				// it has to be added after ghgEmptyGasMC;
				super.container.addChild(ghgGreenGasMC);
				ghgMask = new Shape();
				ghgMask.graphics.beginFill(0x000000);
        ghgMask.graphics.drawRect(xPos + CLOUD_X_BASE, yBase - CLOUD_Y_BASE - ghgH, MASK_WIDTH, ghgH);
				ghgMask.graphics.endFill();
				super.container.addChild(ghgMask);
			  ghgGreenGasMC.mask = ghgMask;
			}
			addChild(super.container);
		}

		private function createGhg():void {
			var ratio:Number;
			if (data.isReadOnlyData)
			  ratio = data.currentDataItem.ghgMtonnes / maxGhgLimitInAllYears;
			else
				ratio = data.currentDataItem.ghgLimit / maxGhgLimitInAllYears;
			var uiR:Number = Math.sqrt(ratio);
			ghgGasHeight = Math.round(MAX_CLOUD_HEIGHT * uiR);
			var mtx:Matrix = new Matrix(uiR, 0, 0, uiR);
			var xx:Number = xPos + CLOUD_X_BASE + (1 - uiR) * MAX_CLOUD_WIDTH * CLOUD_TROUGH_X_RATIO;
			
      // added in the updateUsage(), as needed;
			ghgRedBaseMC = new GhgRedBaseMC();
			ghgRedBaseMC.x = xPos;
			ghgRedBaseMC.y = yBase - CLOUD_Y_BASE;

      ghgGreenBaseMC = new GhgGreenBaseMC();
			ghgGreenBaseMC.x = xPos;
			ghgGreenBaseMC.y = yBase - CLOUD_Y_BASE;
			
			ghgRedGasMC = new GhgRedGasMC();
			ghgRedGasMC.transform.matrix = mtx;
			ghgRedGasMC.x = xx;
			var yy:Number = yBase - CLOUD_Y_BASE - ghgRedGasMC.height;
			ghgRedGasMC.y = yy;
			
			ghgGreenGasMC = new GhgGreenGasMC();
			ghgGreenGasMC.transform.matrix = mtx;
			ghgGreenGasMC.x = xx;
			ghgGreenGasMC.y = yy;
			
			ghgEmptyGasMC = new GhgEmptyGasMC();
			ghgEmptyGasMC.transform.matrix = mtx;
			ghgEmptyGasMC.x = xx;
			ghgEmptyGasMC.y = yy;
			
			super.setupTitle(xPos, yBase, ghgRedBaseMC.width);
			super.setupSourceValueField(xx, yy - TITLE_HEIGHT, ghgRedGasMC.width);
    }
		
  }
}