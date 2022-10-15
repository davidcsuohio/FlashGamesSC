package code {

  import flash.display.*;
  import flash.geom.*;
  import flash.text.*;
	import fl.controls.*;

  // The maximum value displayed will be put to the right of the progress bar,
	// which means the x value of the maximum value will be greater than (_x + _w).
  public class CarbonProgressBar extends Sprite {
		
		protected const VALUE_TEXT_FIELD_WIDTH = 30;
		protected const VALUE_TEXT_FIELD_HEIGHT = 20;
		protected const VALUE_TEXT_FIELD_Y_ADJUSTMENT = -1;
		protected const MAXIMUM_X_OFFSET_TO_BAR = 5;
		
		protected var _x:Number = 0;
		protected var _y:Number = 0;
		protected var _w:Number = 0;
		protected var _h:Number = 0;
		
		protected var _minimum:Number = 0;
		protected var _maximum:Number = 0;
		protected var _value:Number = 0;
		protected var _direction:String = ProgressBarDirection.RIGHT;
		
		protected var _bar:Shape = null;
		protected var _valueTF:TextField = null;
		
		public function CarbonProgressBar(x:Number, y:Number, w:Number, h:Number,
																			direction:String = ProgressBarDirection.RIGHT) {
			_x = x;
			_y = y;
			_w = w;
			_h = h;
			_direction = direction;
			
			drawOutline();
			drawValue();
		}
		
		public function get minimum():Number {
			return _minimum;
		}
		
		public function set minimum(value:Number):void {
			_minimum = value;
		}

		public function get maximum():Number {
			return _maximum;
		}

		public function set maximum(value:Number):void {
			_maximum = value;
			drawMaximum();
		}

		public function get value():Number {
			return _value;
		}

		public function set value(value:Number):void {
			setProgress(value);
		}

		protected function get percentComplete():Number {
			return (_maximum <= _minimum || _value <= _minimum) ?  0 : Math.max(0,Math.min(100,(_value-_minimum)/(_maximum-_minimum)*100));
		}

    private function setProgress(value:Number):void {
			if (value == _value) { return; }
			_value = value;
			
			if (_bar != null) {
				removeChild(_bar);
			}
			if (_valueTF != null) {
				removeChild(_valueTF);
			}
			
			drawValue();
			drawBar();
		}

    protected function drawBar():void {
			_bar = new Shape();
			var color:uint;
			if (_value <= _maximum) {
				color = 0x00FF00;
			}
			else {
				color = 0xFF0000;
			}
			_bar.graphics.beginFill(color);
			var ww:Number = Math.round(_w * percentComplete / 100);
			if (_direction == ProgressBarDirection.RIGHT) {
			  _bar.graphics.drawRect(_x, _y, ww, _h);
			}
			else {
				_bar.graphics.drawRect(_x + _w - ww, _y, ww, _h);
			}
			addChildAt(_bar, 0);
		}
		
    private function drawOutline():void {
			//create the outlines of the bar;
			var outline:Shape = new Shape();
			outline.graphics.lineStyle(1, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			outline.graphics.moveTo(_x, _y);
			outline.graphics.lineTo(_x, _y + _h);
			outline.graphics.lineTo(_x + _w, _y + _h);
			outline.graphics.lineTo(_x + _w, _y);
			outline.graphics.lineTo(_x, _y);
			addChild(outline);
		}
		
		protected function drawValue():void {
			// the size of this TextField is 30x20;
			_valueTF = new TextField();
			var tfValue:int = Math.round(_value);
			_valueTF.text = String(tfValue);
			_valueTF.autoSize = TextFieldAutoSize.CENTER;
			_valueTF.x = _x + (_w - VALUE_TEXT_FIELD_WIDTH) / 2;
			_valueTF.y = _y + (_h - VALUE_TEXT_FIELD_HEIGHT) / 2 + VALUE_TEXT_FIELD_Y_ADJUSTMENT;
			_valueTF.width = VALUE_TEXT_FIELD_WIDTH;
			_valueTF.height = VALUE_TEXT_FIELD_HEIGHT;
			// adjustment is needed due to the bold font in use
			if (tfValue >= 100)
			{
				_valueTF.x -= 1;
				_valueTF.width += 2;
			}
			_valueTF.selectable = false;
			var format:TextFormat = new TextFormat();
			format.size = 14;
			format.bold = true;
			format.align = TextFormatAlign.CENTER;
			_valueTF.setTextFormat(format);
			_valueTF.defaultTextFormat = format;
			_valueTF.mouseEnabled = false;
			addChildAt(_valueTF, 0);
		}
		
		// see the comments at the beginning of this class;
		private function drawMaximum():void {
			var tf:TextField = new TextField();
			tf.text = String(Math.round(_maximum));
			tf.x = _x + _w + MAXIMUM_X_OFFSET_TO_BAR;
			tf.y = _y + (_h - VALUE_TEXT_FIELD_HEIGHT) / 2 + VALUE_TEXT_FIELD_Y_ADJUSTMENT;
			tf.width = VALUE_TEXT_FIELD_WIDTH;
			tf.height = VALUE_TEXT_FIELD_HEIGHT;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.size = 14;
			format.bold = true;
			format.align = TextFormatAlign.LEFT;
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
			tf.mouseEnabled = false;
			addChild(tf);
		}
	}
}
