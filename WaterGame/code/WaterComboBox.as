package code {
	
	import fl.controls.ComboBox;
	import flash.text.TextFormat;

  public class WaterComboBox extends ComboBox {
		
		public function WaterComboBox() {
			super();

			var boldFormat:TextFormat = WaterUtils.boldFormat();
			
			textField.setStyle("textFormat", boldFormat);
			dropdown.setRendererStyle("textFormat", boldFormat);
		}
	}
}