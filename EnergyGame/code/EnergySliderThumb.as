package code {
	
	import fl.core.UIComponent;
	import flash.text.*;
	
	public class EnergySliderThumb extends UIComponent {
		
		var tfValue:TextField;
		
		public function EnergySliderThumb(val:Number) {
			var button:EnergySliderThumbButton = new EnergySliderThumbButton();
			addChild(button);

      tfValue = new TextField();
			setValue(val);
			tfValue.y = 2;
			tfValue.width = 20;
			tfValue.height = 16;
			tfValue.autoSize = TextFieldAutoSize.CENTER;
			tfValue.selectable = false;
      var format:TextFormat = new TextFormat();
			format.size = 14;
			format.bold = true;
			format.align = TextFormatAlign.CENTER;
			tfValue.setTextFormat(format);
			tfValue.defaultTextFormat = format;
			tfValue.mouseEnabled = false;
			addChild(tfValue);
    }
		
		public function setValue(val:Number):void {
			tfValue.text = String(val);
			adjustX(tfValue, val);
		}
		
		// this function is to adjust the vertical alignment of the TextField due to the bold font in use
		private function adjustX(tfValue:TextField, val:Number):void {
			if (val < 10)
				tfValue.x = -6;
			else
				tfValue.x = -9;
		}
	}
	
}
