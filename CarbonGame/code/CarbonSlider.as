package code {
	
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.display.*;	
	import fl.managers.IFocusManagerComponent;
	import fl.core.UIComponent;
	import flash.text.TextField;
	import fl.events.*;
  import flash.text.*;
	
	public class CarbonSlider extends UIComponent implements IFocusManagerComponent {

    const MIN_MAX_Y_POSITION:Number = 30;

		var sliderThumb:CarbonSliderThumb;
		var sliderTrack:CarbonSliderTrack;
		var minValue:TextField;
		var maxValue:TextField;
		var tickContainer:Sprite;
		var _minimum:Number = 0;
		var _maximum:Number = 10;
		var _value:Number = 0;

		public function CarbonSlider(min:Number, max:Number, val:Number) {

      _minimum = min;
			_maximum = max;
			_value = val;
			
			minValue = new TextField();
			minValue.text = CarbonConsts.STRING_ZERO;
			setupTextField(minValue, -10, MIN_MAX_Y_POSITION, 20, 20);

			maxValue = new TextField();
			maxValue.text = String(maximum);
			// the x location will be changed in setSize();
			setupTextField(maxValue, -10, MIN_MAX_Y_POSITION, 20, 20);

			sliderThumb = new CarbonSliderThumb(_value);
			sliderThumb.x = -20;
			sliderThumb.y = 15;
			sliderThumb.width = 40;
			sliderThumb.height = 20;
			sliderThumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbPressHandler, false, 0, true);
			addChild(sliderThumb);

			sliderTrack = new CarbonSliderTrack();
      sliderTrack.x = 0;
			sliderTrack.y = 15;
			sliderTrack.width = 100;
			sliderTrack.height = 20;
      sliderTrack.addEventListener(MouseEvent.CLICK, onTrackClick, false, 0, true);
			addChildAt(sliderTrack, 0);
		}
		
		override public function setSize(w:Number, h:Number):void {
			super.setSize(w, h);
			if (w > 0 && h > 0) {
			  sliderTrack.width = w;
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
			sliderThumb.setValue(val);
		}

		function doSetValue(val:Number, clickTarget:String=null):void {
			var oldVal:Number = _value;
			_value = Math.max(minimum, Math.min(maximum, Math.round(val)));
			// Only dispatch if value has changed
			// Dispatch when dragging			
			if (oldVal != _value && clickTarget != null) {
				dispatchEvent(new SliderEvent(SliderEvent.CHANGE, value, clickTarget, InteractionInputType.MOUSE));
			}
			positionThumb();
		}

		function positionThumb():void {
			sliderThumb.x = (value - minimum)/(maximum - minimum) * _width;
			sliderThumb.setValue(value);
		}
		
    function thumbPressHandler(event:MouseEvent):void {
			var myForm:DisplayObjectContainer = focusManager.form;
			myForm.addEventListener(MouseEvent.MOUSE_MOVE, doDrag, false, 0, true);
			myForm.addEventListener(MouseEvent.MOUSE_UP, thumbReleaseHandler, false, 0, true);
    }

		function thumbReleaseHandler(event:MouseEvent):void {
			var myForm:DisplayObjectContainer = focusManager.form;
			myForm.removeEventListener(MouseEvent.MOUSE_MOVE, doDrag);
			myForm.removeEventListener(MouseEvent.MOUSE_UP, thumbReleaseHandler);
			dispatchEvent(new SliderEvent(SliderEvent.CHANGE, value, SliderEventClickTarget.THUMB, InteractionInputType.MOUSE));
		}

		function doDrag(event:MouseEvent):void {
			calculateValue(sliderTrack.mouseX * sliderTrack.scaleX, SliderEventClickTarget.THUMB);
		}

		function calculateValue(pos:Number, clickTarget:String):void {
			var newValue:Number = (pos / _width) * ( maximum - minimum) + minimum;
			doSetValue(newValue, clickTarget);
		}

    function onTrackClick(event:MouseEvent):void {
			calculateValue(sliderTrack.mouseX * sliderTrack.scaleX, SliderEventClickTarget.TRACK);
//   		it's already dispatched during dragging;
//			dispatchEvent(new SliderEvent(SliderEvent.CHANGE, value, SliderEventClickTarget.TRACK, InteractionInputType.MOUSE));
		}
		
	  // layout: 15 pixels for the tick section, 20 pixels for the triangle, 5 pixels for the triangle-below
	  //         horizontal pen line 
		function drawTicks():void {
			clearTicks();
			tickContainer = new Sprite();
			var line:Shape = new Shape();
			line.graphics.lineStyle(2, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			line.graphics.moveTo(0, 0);
			line.graphics.lineTo(0, 20);
			line.graphics.moveTo(0, 10);
			line.graphics.lineTo(_width, 10);
			line.graphics.moveTo(_width, 0);
			line.graphics.lineTo(_width, 20);
			line.graphics.lineStyle(1, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			var l:Number = maximum - minimum;
			var dist:Number = _width / l;
			var x:Number;
			for (var i:uint = 0; i <= l; i++) {
				x = dist * i;
				line.graphics.moveTo(x, 5);
				line.graphics.lineTo(x, 15);
			}
			tickContainer.addChild(line);
			addChild(tickContainer);
		}

		protected function clearTicks():void {
			if (!tickContainer || !tickContainer.parent) { return; }
			removeChild(tickContainer);
		}
		
    function setupTextField(tf:TextField, x:Number, y:Number, w:Number, h:Number):void {
			tf.x = x;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.selectable = false;
      var format:TextFormat = new TextFormat();
			format.bold = true;
			format.size = 13;
			format.align = TextFormatAlign.CENTER;
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
			tf.mouseEnabled = false;
			addChild(tf);
		}
	}
}
