package code {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	public class WsSpriteX extends Sprite {
		
		protected const X_BUTTON_WIDTH:Number = 20;
		protected const X_BUTTON_HEIGHT:Number = 20;
		
		protected var xBtn:WsButton;
		
		public function WsSpriteX(x:Number, y:Number, w:Number) {
			this.xBtn = new WsButton();
			xBtn.label = "X";
			xBtn.setSize(X_BUTTON_WIDTH, X_BUTTON_HEIGHT);
			xBtn.move(x + w - X_BUTTON_WIDTH - 10, y + 10);
			xBtn.addEventListener(MouseEvent.CLICK, xBtnClicked, false, 0, true);
		}
		
    // The child classes will implement the following functions if necessary;
		protected function addXBtn():void {
			addChild(xBtn);
		}
		
		protected function xBtnClickedHandling():void {
		}
		
		protected function xBtnClicked(e:MouseEvent):void {
			xBtnClickedHandling();
		}
		
		protected function createCloseMenu(closeItemName:String):ContextMenu {
			var myCM:ContextMenu = new ContextMenu();
			myCM.hideBuiltInItems();
			var myCMI = new ContextMenuItem(closeItemName);
			myCM.customItems.push(myCMI);

			myCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, closeItemSelected);
			return myCM;
		}
		
		protected function closeItemSelected(e:ContextMenuEvent):void {
			xBtnClickedHandling();
		}
	}
}
