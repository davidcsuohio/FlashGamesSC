package code {
	
	import fl.controls.Button;
	import flash.text.TextFormat;

  public class WsButton extends Button {
		
		public function WsButton() {
			super();
			setStyle("textFormat", WsUtils.boldCenterFormat());
		}
	}
}