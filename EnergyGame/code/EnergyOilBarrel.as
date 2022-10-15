package code {
	
	import flash.display.*;

  public class EnergyOilBarrel extends Sprite {

    // 0,0,84.55x165.50
		const MASK_Y_BASE:Number = 166;
		const BARREL_HEIGHT:Number = 165;
		const MASK_WIDTH:Number = 88;

    var data:EnergyData;
		var xPos:Number;
		var yPos:Number;
		var oilBarrelFullMC:MovieClip;
		var oilBarrelEmptyMC:MovieClip;
		var oilBarrelRedMC:MovieClip;
		var oilBarrelMask:Shape;

    public function EnergyOilBarrel(data:EnergyData, x:Number, y:Number) {
			this.data = data;
			xPos = x;
			yPos = y;

      // added in the updateUsage(), as needed;
		  oilBarrelRedMC = new OilBarrelRedMC();
			oilBarrelRedMC.x = xPos + 1;
			oilBarrelRedMC.y = yPos;
			
			oilBarrelEmptyMC = new OilBarrelEmptyMC();
			oilBarrelEmptyMC.x = xPos + 1;
			oilBarrelEmptyMC.y = yPos;
			
			oilBarrelFullMC = new OilBarrelFullMC();
			oilBarrelFullMC.x = xPos + 1;
			oilBarrelFullMC.y = yPos;

			updateUsage();
    }
		
		function updateUsage():void {
			removeChildren();
			var oil:Number = this.data.currentDataItem.totalOil;
			var limit:Number = this.data.currentDataItem.oilLimit;
			if (oil > limit) {
				addChild(oilBarrelRedMC);
			}
			else if (oil == limit) {
				oilBarrelFullMC.mask = null;
				addChild(oilBarrelFullMC);
			}
			else {
				var oilH:Number = Math.round(BARREL_HEIGHT * oil / limit);
				oilBarrelFullMC.mask = null;
				// due to the special feature of oil barrel (full barrel is white outline and empty barrel is black outline)
				// the order of adding FullMC and EmptyMC is opposite to Budget and Ghg;
				// and the y value of EmptyMC symbol is -2 instead of 0;
				addChild(oilBarrelFullMC);
				addChild(oilBarrelEmptyMC);
				oilBarrelMask = new Shape();
				oilBarrelMask.graphics.beginFill(0x000000);
        oilBarrelMask.graphics.drawRect(xPos, yPos + MASK_Y_BASE - oilH, MASK_WIDTH, oilH);
				oilBarrelMask.graphics.endFill();
				addChild(oilBarrelMask);
			  oilBarrelFullMC.mask = oilBarrelMask;
			}
		}

    function removeChildren():void {
			if (numChildren <= 0) { return; }
			for (var i:int = numChildren - 1; i >= 0; i--) {
				removeChildAt(i);
			}
		}
  }
}