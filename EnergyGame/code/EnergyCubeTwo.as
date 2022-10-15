package code {

  import flash.display.*;

  // the bottom energy uses parent's stuff;
  public class EnergyCubeTwo extends EnergyCube {

		// top-left point of the front side
		private var yPosEffic:Number;
		private var efficiencyHeight:Number;

    public function EnergyCubeTwo(data:EnergyData,
	 															 x:Number,
																 yBase:Number,
																 cubeWidth:Number,
																 cubeDeltaX:Number,
																 cubeDeltaY:Number,
															 	 energyHeight:Number,
																 efficiencyHeight:Number,
															 	 energyLogo:MovieClip) {
			super(data, x, yBase, cubeWidth, energyHeight, cubeDeltaX, cubeDeltaY, energyLogo);
			this.efficiencyHeight = efficiencyHeight;
			yPosEffic = yBase - energyHeight;
    }

    public function updateUsages(energyH:Number, color:uint, efficiencyH:Number):void {
			clearContainer();
			super.container = new Sprite();
			
			if (efficiencyH == 0 && energyH >= cubeHeight) {
				drawBar(yPos + cubeHeight - energyH, energyH, color);
			}
			else if (energyH + efficiencyH <= cubeHeight) {
				// update energy bar at the bottom;
				drawBar(yPos + cubeHeight - energyH, energyH, color);
				// update efficiency bar at the top;
				drawBar(yPosEffic, efficiencyH, color);
			}
			else if ((energyH + efficiencyH > cubeHeight) &&
							 energyH <= cubeHeight) {
				var overlap:Number = energyH + efficiencyH - cubeHeight;
				// simply draw these two cubes and draw the orange overlap cubes at last step;
				drawBar(yPos + cubeHeight - energyH, energyH, color);
				if (energyH == cubeHeight) {
					drawTop(yPosEffic, EnergyConsts.CUBE_ORANGE_COLOR);
				}
				else {
					drawBar(yPosEffic, efficiencyH, color);
				}
				drawFrontAndRight(yPos + cubeHeight - energyH,
													overlap, EnergyConsts.CUBE_ORANGE_COLOR);
			}
			else if (energyH > cubeHeight) {
				drawBar(yPos + cubeHeight - energyH, energyH, color);
				drawFrontAndRight(yPosEffic, efficiencyH, EnergyConsts.CUBE_ORANGE_COLOR);
			}
			
			addChildAt(super.container, numChildren - frontSiblings);
		}

  }
}