package code {
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;

  public class EnergyOil extends EnergyGraphBase {

    // 0,0,76.25x149.20
		private const MASK_Y_BASE_RATIO:Number = 0.07;
		private const OIL_HEIGHT_RATIO:Number = 0.869;
		private const MAX_OIL_HEIGHT:Number = 149.20;
		private const MAX_OIL_WIDTH:Number = 76.25;
		private const MASK_CONTROL_HEIGHT:Number = 20;

    private var data:EnergyData;
		private var xBase:Number;
		private var yBase:Number;
		private var oilGreenMC:MovieClip;
		private var oilEmptyMC:MovieClip;
		private var oilRedMC:MovieClip;
		private var oilMask:Shape;
		private var oilHeight:Number;
		private var oilWidth:Number;
		private var xPos:Number;
		private var maskControlHeight:Number;
		private var maxOilLimitInAllYears:Number;

    public function EnergyOil(data:EnergyData, xBase:Number, yBase:Number) {
			super(EnergyConsts.OIL_NAME);
			this.data = data;
			this.xBase = xBase;
			this.yBase = yBase - TITLE_HEIGHT;
			maxOilLimitInAllYears = data.getMaxOilLimitInAllYears();

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
				createOil();
			}
			var oil:Number = this.data.currentDataItem.totalOil;
			super.sourceValueTF.text = String(Math.round(oil));
			if (data.isReadOnlyData) {
				oilGreenMC.mask = null;
				super.container.addChild(oilGreenMC);
				addChild(super.container);
				return;
			}
			var limit:Number = this.data.currentDataItem.oilLimit;
			if (oil > limit) {
				super.container.addChild(oilRedMC);
			}
			else if (oil == limit) {
				oilGreenMC.mask = null;
				super.container.addChild(oilGreenMC);
			}
			else {
				var oilH:Number = oilHeight * OIL_HEIGHT_RATIO * oil / limit;;
				oilGreenMC.mask = null;
				super.container.addChild(oilEmptyMC);
				// it has to be added after oilEmptyMC;
				super.container.addChild(oilGreenMC);
				var yPos:Number = yBase - MASK_Y_BASE_RATIO * oilHeight - oilH;
				oilMask = new Shape();
				oilMask.graphics.beginFill(0x000000);
				oilMask.graphics.moveTo(xPos, yPos);
				oilMask.graphics.curveTo(xPos + oilWidth / 2,
																 yPos - maskControlHeight,
																 xPos + oilWidth,
																 yPos);
        oilMask.graphics.lineTo(xPos + oilWidth, yBase);
        oilMask.graphics.lineTo(xPos, yBase);
        oilMask.graphics.lineTo(xPos, yPos);
				oilMask.graphics.endFill();
				super.container.addChild(oilMask);
			  oilGreenMC.mask = oilMask;
				var curve:Shape = new Shape();
				curve.graphics.lineStyle(1, EnergyConsts.CURVE_GREEN_COLOR, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
				curve.graphics.moveTo(xPos, yPos + 1);
				curve.graphics.curveTo(xPos + oilWidth / 2,
															 yPos - maskControlHeight,
															 xPos + oilWidth - 2,
															 yPos);
				curve.graphics.moveTo(xPos, yPos + 1);
				curve.graphics.curveTo(xPos + oilWidth / 2,
															 yPos + maskControlHeight,
															 xPos + oilWidth - 2,
															 yPos);
				super.container.addChild(curve);
			}
			addChild(super.container);
		}

		private function createOil():void {
			var ratio:Number;
			if (data.isReadOnlyData)
			  ratio = data.currentDataItem.totalOil / maxOilLimitInAllYears;
			else
			  ratio = data.currentDataItem.oilLimit / maxOilLimitInAllYears;
			var uiR:Number = Math.sqrt(ratio);
			oilHeight = Math.round(MAX_OIL_HEIGHT * uiR);
			maskControlHeight = Math.round(MASK_CONTROL_HEIGHT * uiR);
			var mtx:Matrix = new Matrix(uiR, 0, 0, uiR);
			
      // added in the updateUsage(), as needed;
		  oilRedMC = new OilBarrelRedMC();
			oilRedMC.transform.matrix = mtx;
			var yPos:Number = yBase - oilRedMC.height;
			oilWidth = oilRedMC.width;
			xPos = xBase + (1 - uiR) * MAX_OIL_WIDTH / 2;
			oilRedMC.x = xPos;
			oilRedMC.y = yPos;
			
			oilEmptyMC = new OilBarrelEmptyMC();
			oilEmptyMC.transform.matrix = mtx;
			oilEmptyMC.x = xPos;
			oilEmptyMC.y = yPos;
			
			oilGreenMC = new OilBarrelGreenMC();
			oilGreenMC.transform.matrix = mtx;
			oilGreenMC.x = xPos;
			oilGreenMC.y = yPos;
			
			super.setupTitle(xPos, yBase, oilRedMC.width);
			super.setupSourceValueField(xPos, yPos - TITLE_HEIGHT, oilRedMC.width);
    }
		
  }
}