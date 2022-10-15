package code {
	
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.display.*;	
	import fl.managers.IFocusManagerComponent;
	import fl.core.UIComponent;
	import flash.text.TextField;
	import fl.events.*;
  import flash.text.*;
	
	public class EnergySlider extends UIComponent implements IFocusManagerComponent {

    // If we need to change the tick height, we need to change the thumb.y below 
		// and the EnergySliderThumb symbol size as well.
    private const BIG_TICK_HEIGHT:int = 12;

		private var thumb:EnergySliderThumb;
		private var track:EnergySliderTrack;
		private var tickContainer:Sprite;
		private var highlightBarContainer:Sprite;
		private var minValue:TextField;
		private var maxValue:TextField;
		private var _minimum:Number = 0;
		private var _maximum:Number = 10;
		private var _value:Number = 0;

		public function EnergySlider(min:Number, max:Number, val:Number) {
			_minimum = min;
			_maximum = max;
			_value = val;

			minValue = new TextField();
			setupTextField(minValue, EnergyConsts.STRING_ZERO, -10, BIG_TICK_HEIGHT, 20, 20);

			maxValue = new TextField();
			// the x location will be changed in setSize();
			setupTextField(maxValue, String(maximum), -10, BIG_TICK_HEIGHT, 20, 20);

			thumb = new EnergySliderThumb(_value);
			thumb.x = -20;
			thumb.y = BIG_TICK_HEIGHT * 3 / 4;
			thumb.width = 4;
			thumb.height = 20;
			addChild(thumb);
			
			thumb.addEventListener(MouseEvent.MOUSE_DOWN,thumbPressHandler,false,0,true);
			
			track = new EnergySliderTrack();
			track.x = 0;
			track.y = BIG_TICK_HEIGHT * 3 / 4;
			track.width = 100;
			track.height = 20;
			track.addEventListener(MouseEvent.CLICK,onTrackClick,false,0,true);
			addChildAt(track,0);
		}
		
		override public function setSize(w:Number, h:Number):void {
			super.setSize(w, h);
			if (w > 0 && h > 0) {
				track.width = w;
				maxValue.x = w - maxValue.getBounds(this).width / 2;
			}
		}

		override protected function draw():void {
			drawTicks();
			positionThumb();
			super.draw();
		}

    public function get minimum():Number {
			return _minimum;
		}
		public function set minimum(value:Number):void {
			_minimum = value;
			this.value = Math.max(value, this.value);
		}

		public function get maximum():Number {
			return _maximum;
		}		
		public function set maximum(value:Number):void {
			_maximum = value;
			this.value = Math.min(value, this.value);
		}

		public function get value():Number {
			return _value;
		}
		public function set value(value:Number):void {
			doSetValue(value);
		}
		
		public function setThumbValue(val:Number):void {
			thumb.setValue(val);
		}

		private function doSetValue(val:Number, clickTarget:String=null):void {
			var oldVal:Number = _value;
			_value = Math.max(minimum, Math.min(maximum, Math.round(val)));
			// Only dispatch if value has changed
			// Dispatch when dragging			
			if (oldVal != _value && clickTarget != null) {
				dispatchEvent(new SliderEvent(SliderEvent.CHANGE, value, clickTarget, InteractionInputType.MOUSE));
			}
			positionThumb();
		}

		private function positionThumb():void {
			var pos = (value - minimum)/(maximum - minimum) * _width;
			thumb.x = pos;
			thumb.setValue(value);
			drawHighlightBar(pos);
		}
		
    private function thumbPressHandler(event:MouseEvent):void {
			var myForm:DisplayObjectContainer = focusManager.form;
			myForm.addEventListener(MouseEvent.MOUSE_MOVE, doDrag, false, 0, true);
			myForm.addEventListener(MouseEvent.MOUSE_UP, thumbReleaseHandler, false, 0, true);
    }

		private function thumbReleaseHandler(event:MouseEvent):void {
			var myForm:DisplayObjectContainer = focusManager.form;
			myForm.removeEventListener(MouseEvent.MOUSE_MOVE, doDrag);
			myForm.removeEventListener(MouseEvent.MOUSE_UP, thumbReleaseHandler);
			dispatchEvent(new SliderEvent(SliderEvent.CHANGE, value, SliderEventClickTarget.THUMB, InteractionInputType.MOUSE));
		}

		private function doDrag(event:MouseEvent):void {
			calculateValue(track.mouseX * track.scaleX, SliderEventClickTarget.THUMB);
		}

		private function calculateValue(pos:Number, clickTarget:String):void {
			var newValue:Number = (pos / _width) * ( maximum - minimum) + minimum;
			doSetValue(newValue, clickTarget);
		}

    private function onTrackClick(event:MouseEvent):void {
			calculateValue(track.mouseX * track.scaleX, SliderEventClickTarget.TRACK);
//   		it's already dispatched during dragging;
//			dispatchEvent(new SliderEvent(SliderEvent.CHANGE, value, SliderEventClickTarget.TRACK, InteractionInputType.MOUSE));
		}
		
		private function drawTicks():void {
			clearTicks();
			tickContainer = new Sprite();
			var line:Shape = new Shape();
			line.graphics.lineStyle(2, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			line.graphics.moveTo(0, 0);
			line.graphics.lineTo(0, BIG_TICK_HEIGHT);
			line.graphics.moveTo(_width, 0);
			line.graphics.lineTo(_width, BIG_TICK_HEIGHT);
			line.graphics.lineStyle(1, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			line.graphics.moveTo(0, BIG_TICK_HEIGHT / 2);
			line.graphics.lineTo(_width, BIG_TICK_HEIGHT / 2);
			var l:Number = maximum - minimum;
			var dist:Number = _width / l;
			var x:Number;
			for (var i:uint = 1; i < l; i++) {
				x = dist * i;
				line.graphics.moveTo(x, BIG_TICK_HEIGHT / 4);
				line.graphics.lineTo(x, BIG_TICK_HEIGHT * 3 / 4);
			}
			tickContainer.addChild(line);
			addChildAt(tickContainer, 0);
		}

		private function clearTicks():void {
			if (!tickContainer || !tickContainer.parent) { return; }
			removeChild(tickContainer);
		}
		
		private function drawHighlightBar(pos:Number):void {
			clearHighlightBar();
			highlightBarContainer = new Sprite();
			var line:Shape = new Shape();
			line.graphics.lineStyle(BIG_TICK_HEIGHT / 2 - 2, EnergyConsts.SLIDER_BAR_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			line.graphics.moveTo(0, BIG_TICK_HEIGHT / 2);
			line.graphics.lineTo(pos, BIG_TICK_HEIGHT / 2);
			highlightBarContainer.addChild(line);
			addChildAt(highlightBarContainer, 1);
		}
		
		private function clearHighlightBar():void {
			if (!highlightBarContainer || !highlightBarContainer.parent) { return; }
			removeChild(highlightBarContainer);
		}
		
    private function setupTextField(tf:TextField, name:String, x:Number, y:Number, w:Number, h:Number):void {
			tf.text = name;
			tf.x = x;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = 13;
			format.bold = true;
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
			tf.mouseEnabled = false;
			addChild(tf);
		}
	}
}
