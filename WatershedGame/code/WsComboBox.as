package code {
	
	import fl.controls.ComboBox;
	import flash.text.TextFormat;

  public class WsComboBox extends ComboBox {
		
		public function WsComboBox() {
			super();

			var boldFormat:TextFormat = WsUtils.boldFormat();
			
			textField.setStyle("textFormat", boldFormat);
			dropdown.setRendererStyle("textFormat", boldFormat);
		}
	}
}