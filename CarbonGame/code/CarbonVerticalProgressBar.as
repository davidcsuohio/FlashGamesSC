package code {

  import flash.display.*;
  import flash.geom.*;
  import flash.text.*;
	import fl.controls.*;

  public class CarbonVerticalProgressBar extends CarbonProgressBar {
		
		// ProgressBarDirection.RIGHT means the bar is drawn top-down;
		// ProgressBarDirection.LEFT means the bar is drawn bottom-up;
		public function CarbonVerticalProgressBar(x:Number, y:Number, w:Number, h:Number,
																			direction:String = ProgressBarDirection.LEFT) {
			super(x, y, w, h, direction);
			drawTitle();
		}

    // the maximum value is not drawn;
		override public function set maximum(value:Number):void {
			_maximum = value;
		}

    override protected function drawBar():void {
			_bar = new Shape();
			var color:uint;
			if (_value <= _maximum) {
				color = 0xFF00FF;
			}
			else {
				color = 0xFF0000;
			}
			_bar.graphics.beginFill(color);
			var hh:Number = Math.round(_h * percentComplete / 100);
			if (_direction == ProgressBarDirection.RIGHT) {
			  _bar.graphics.drawRect(_x, _y, _w, hh);
			}
			else {
				_bar.graphics.drawRect(_x, _y + _h - hh, _w, hh);
			}
			addChildAt(_bar, 0);
		}
		
		override protected function drawValue():void {
			// the size of this TextField is 50x30;
			_valueTF = new TextField();
			_valueTF.x = _x + (_w - 50) / 2;
			_valueTF.y = _y + (_h - 30) / 2;
			_valueTF.width = 50;
			_valueTF.height = 40;
			_valueTF.text = String(Math.round(_value));
			_valueTF.autoSize = TextFieldAutoSize.CENTER;
			var format:TextFormat = new TextFormat();
			format.bold = true;
			format.size = 20;
			format.align = TextFormatAlign.CENTER;
			_valueTF.setTextFormat(format);
			addChildAt(_valueTF, 0);
		}
		
		private function drawTitle():void {
			var title:TextField = new TextField();
			title.text = CarbonConsts.TOTAL_CARBON_POINTS_TITLE;
			title.x = _x;
			title.y = _y;
			title.width = _w;
			title.height = 40;
			title.autoSize = TextFieldAutoSize.CENTER;
			var format:TextFormat = new TextFormat();
			format.size = 14;
			format.align = TextFormatAlign.CENTER;
			title.setTextFormat(format);
			addChildAt(title, 0);
		}
	}
}
