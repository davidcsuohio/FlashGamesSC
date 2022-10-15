package code {

  import flash.display.*;
	import flash.events.*;
	import flash.text.*;

  public class EnergyInfoBase extends EnergyViewBase {

    protected var data:EnergyData;
		protected var xPos:Number;
		protected var yPos:Number;

    public function EnergyInfoBase(data:EnergyData,
															 		 x:Number,
																	 y:Number) {
			this.data = data;
			xPos = x;
			yPos = y;
    }

		protected function setupBackground():void {
			var bg:Shape = new Shape();
			bg.graphics.lineStyle(1, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			bg.graphics.beginFill(EnergyConsts.PLAN_BACKGROUND_COLOR);
			bg.graphics.drawRect(xPos, yPos, 275, 143);
			bg.graphics.moveTo(xPos, yPos + 26);
			bg.graphics.lineTo(xPos + 275, yPos + 26);
			bg.graphics.endFill();
			addChild(bg);
		}
		
		protected function setupTitle(name:String):void {
			super.setupTextField2(name, xPos, yPos + 4.2, 275, 19.60, 14);
		}
		
		protected function setupFirstRowLeftText(tf:TextField, name:String):void {
			super.setupTextFieldL2(tf, name, xPos + 2, yPos + 38.35, 82.35, 16.55, 11);
		}
		
		protected function setupFirstRowLeftValue(tf:TextField):void {
			super.setupTextFieldL1(tf, xPos + 87, yPos + 38.35, 80, 25.15, 11);
		}
		
		protected function setupSecondRowLeftText(tf:TextField, name:String):void {
			super.setupTextFieldL2(tf, name, xPos + 2, yPos + 63.65, 82.35, 16.55, 11);
		}
		
		protected function setupSecondRowLeftValue(tf:TextField):void {
			super.setupTextFieldL1(tf, xPos + 87, yPos + 63.65, 80, 25.15, 11);
		}
		
		protected function setupThirdRowLeftText(tf:TextField, name:String):void {
			super.setupTextFieldL2(tf, name, xPos + 2, yPos + 88.95, 82.35, 16.55, 11);
		}
		
		protected function setupThirdRowLeftValue(tf:TextField):void {
			super.setupTextFieldL1(tf, xPos + 87, yPos + 88.95, 80, 25.15, 11);
		}
			
		protected function setupFirstRowRightText(tf:TextField, name:String):void {
			super.setupTextFieldL2(tf, name, xPos + 134.80, yPos + 38.35, 99.30, 16.55, 11);
		}
		
		protected function setupFirstRowRightValue(tf:TextField):void {
			super.setupTextFieldL1(tf, xPos + 237, yPos + 38.35, 80, 25.15, 11);
		}
		
		protected function setupSecondRowRightText(tf:TextField, name:String):void {
			super.setupTextFieldL2(tf, name, xPos + 134.80, yPos + 63.65, 99.30, 16.55, 11);
		}
		
		protected function setupSecondRowRightValue(tf:TextField):void {
			super.setupTextFieldL1(tf, xPos + 237, yPos + 63.65, 80, 25.15, 11);
		}
		
		protected function setupThirdRowRightText(tf:TextField, name:String):void {
			super.setupTextFieldL2(tf, name, xPos + 134.80, yPos + 88.95, 99.30, 16.55, 11);
		}
		
		protected function setupThirdRowRightValue(tf:TextField):void {
			super.setupTextFieldL1(tf, xPos + 237, yPos + 88.95, 80, 25.15, 11);
		}
		
		protected function setupFourthRowRightText(tf:TextField, name:String):void {
			super.setupTextFieldL2(tf, name, xPos + 134.80, yPos + 114.25, 99.30, 16.55, 11);
		}
		
		protected function setupFourthRowRightValue(tf:TextField):void {
			super.setupTextFieldL1(tf, xPos + 237, yPos + 114.25, 80, 25.15, 11);
		}
		
  }
}