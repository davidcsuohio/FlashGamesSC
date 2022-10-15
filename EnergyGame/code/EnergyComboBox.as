package code {
	
	import fl.controls.ComboBox;
	import flash.text.TextFormat;

  public class EnergyComboBox extends ComboBox {
		
		public function EnergyComboBox() {
			super();

			var boldFormat:TextFormat = EnergyUtils.boldFormat();
			boldFormat.size = 11;
			
			textField.setStyle("textFormat", boldFormat);
			dropdown.setRendererStyle("textFormat", boldFormat);
		}
	}
}