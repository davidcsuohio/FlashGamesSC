package code {
	
	import fl.controls.Button;
	import flash.text.TextFormat;

  public class EnergyButton extends Button {
		
		public function EnergyButton() {
			super();

			setStyle("textFormat", EnergyUtils.boldCenterFormat());
		}
	}
}