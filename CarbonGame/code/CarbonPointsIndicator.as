package code {

  import flash.display.*;

  // this class represents the points indicator
	// it draws the rectangles depending on the data
  public class CarbonPointsIndicator extends Sprite {

		 private const INDICATOR_TICK_HEIGHT:int = 5;
		 
     public function CarbonPointsIndicator(actionData:CarbonActionData,
																		       x:Number,
                                           y:Number) {
			// it draws the green rectangle for biomass; (00 6E 3A)
			//              blue for oceans; (00 54 A6)
			//              red for atmosphere; (C0 27 2D)
			//              black for fossilFuels; (23 1F 20)
			//              white for the rest;
			// hard-coded 1 pixel for CarbonConsts.POINTS_PER_PIXEL points;
			//            height CarbonConsts.POINTS_INDICATOR_HEIGHT;
		  // did not draw if the points are less than CarbonConsts.POINTS_PER_PIXEL;
			var wPixels:int = actionData.getBiomassPoints() / CarbonConsts.POINTS_PER_PIXEL;
			var xx:Number = x;
			if (wPixels > 0) {
        var child:Shape = new Shape();
        child.graphics.beginFill(0x006E3A);
        child.graphics.lineStyle(1, 0x000000);
        child.graphics.drawRect(xx, y, wPixels, CarbonConsts.POINTS_INDICATOR_HEIGHT);
        child.graphics.endFill();
        addChild(child);
				xx += wPixels;
			}
			wPixels = actionData.getOceansPoints() / CarbonConsts.POINTS_PER_PIXEL;
			if (wPixels > 0) {
        child = new Shape();
        child.graphics.beginFill(0x0054A6);
        child.graphics.lineStyle(1, 0x000000);
        child.graphics.drawRect(xx, y, wPixels, CarbonConsts.POINTS_INDICATOR_HEIGHT);
        child.graphics.endFill();
        addChild(child);
				xx += wPixels;
			}
			wPixels = actionData.getAtmospherePoints() / CarbonConsts.POINTS_PER_PIXEL;
			if (wPixels > 0) {
        child = new Shape();
        child.graphics.beginFill(0xC0272D);
        child.graphics.lineStyle(1, 0x000000);
        child.graphics.drawRect(xx, y, wPixels, CarbonConsts.POINTS_INDICATOR_HEIGHT);
        child.graphics.endFill();
        addChild(child);
				xx += wPixels;
			}
			wPixels = actionData.getFossilFuelsPoints() / CarbonConsts.POINTS_PER_PIXEL;
			if (wPixels > 0) {
        child = new Shape();
        child.graphics.beginFill(0x231F20);
        child.graphics.lineStyle(1, 0x000000);
        child.graphics.drawRect(xx, y, wPixels, CarbonConsts.POINTS_INDICATOR_HEIGHT);
        child.graphics.endFill();
        addChild(child);
				xx += wPixels;
			}
			wPixels = actionData.getRestPoints() / CarbonConsts.POINTS_PER_PIXEL;
			if (wPixels > 0) {
        child = new Shape();
        child.graphics.beginFill(0xFFFFFF);
        child.graphics.lineStyle(1, 0x000000);
        child.graphics.drawRect(xx, y, wPixels, CarbonConsts.POINTS_INDICATOR_HEIGHT);
        child.graphics.endFill();
        addChild(child);
				xx += wPixels;
			}
			// draw 2-pixels rectangle and 1-pixel ticks;
      var line:Shape = new Shape();
			line.graphics.lineStyle(2, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			line.graphics.moveTo(x, y);
			line.graphics.lineTo(x, y + CarbonConsts.POINTS_INDICATOR_HEIGHT + INDICATOR_TICK_HEIGHT);
			line.graphics.moveTo(x, y);
			line.graphics.lineTo(xx, y);
			line.graphics.lineTo(xx, y + CarbonConsts.POINTS_INDICATOR_HEIGHT + INDICATOR_TICK_HEIGHT);
			line.graphics.moveTo(x, y + CarbonConsts.POINTS_INDICATOR_HEIGHT);
			line.graphics.lineTo(xx, y + CarbonConsts.POINTS_INDICATOR_HEIGHT);
			line.graphics.lineStyle(1, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			// draw a tick every 10 pixels;
			var i:int = x + 10;
			while (i < xx) {
				line.graphics.moveTo(i, y + CarbonConsts.POINTS_INDICATOR_HEIGHT);
				line.graphics.lineTo(i, y + CarbonConsts.POINTS_INDICATOR_HEIGHT + INDICATOR_TICK_HEIGHT);
				i += 10;
			}
			addChild(line);			
    }
  }
}