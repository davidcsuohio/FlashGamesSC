package code {

  import flash.display.*;
  import flash.text.*;
	
  public class EnergyViewBase extends Sprite {

    public function EnergyViewBase() {
    }

		protected function setupTextField(tf:TextField, x:Number, y:Number, w:Number, h:Number, fontSize:Object, bold:Object=false):void {
			tf.x = x;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = fontSize;
			format.bold = bold;
			format.font = "Arial";
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
			addChild(tf);
		}
		
		protected function setupTextField2(name:String, x:Number, y:Number, w:Number, h:Number, fontSize:Object):void {
			var tf:TextField = new TextField();
			tf.text = name;
			this.setupTextField(tf, x, y, w, h, fontSize, true);
		}
		
		protected function setupTextFieldL0(tf:TextField, x:Number, y:Number, fontSize:Object, bold:Object=false):void {
			tf.x = x;
			tf.y = y;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.LEFT;
			format.size = fontSize;
			format.bold = bold;
			format.font = "Arial";
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
			addChild(tf);
		}
		
		protected function setupTextFieldL1(tf:TextField, x:Number, y:Number, w:Number, h:Number, fontSize:Object):void {
			tf.width = w;
			tf.height = h;
			setupTextFieldL0(tf, x, y, fontSize, true);
		}
		
		protected function setupTextFieldL2(tf:TextField, name:String, x:Number, y:Number, w:Number, h:Number, fontSize:Object):void {
			tf.text = name;
			setupTextFieldL1(tf, x, y, w, h, fontSize);
		}
		
		protected function setupTextFieldL3(name:String, x:Number, y:Number, fontSize:Object, bold:Object=false, textColor:uint=0x000000):TextField {
			var tf:TextField = new TextField();
			tf.text = name;
			tf.textColor = textColor;
			setupTextFieldL0(tf, x, y, fontSize, bold);
			return tf;
		}
	}
}
