package code {
	
	import fl.controls.CheckBox;
	import flash.text.TextFormat;

  public class EnergyCheckBox extends CheckBox {
		
		public function EnergyCheckBox() {
			super();

			var boldFormat:TextFormat = EnergyUtils.boldFormat();
			boldFormat.size = 10;
			
			this.setStyle("textFormat", boldFormat);
		}
	}
}