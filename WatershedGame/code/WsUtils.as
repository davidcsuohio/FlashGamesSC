package code {

  import flash.display.*;
  import flash.text.*;
	
  public final class WsUtils {

		static function setupTextFieldC0(tf:TextField, x:Number, w:Number,
																		 fontSize:Object, bold:Object=false):void {
			tf.x = x;
			tf.width = w;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = fontSize;
			format.bold = bold;
			format.font = "Arial";
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
		}

		public static function setupTextFieldC1(container:Sprite, tf:TextField,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, bold:Object=false):void {
			setupTextFieldC0(tf, x, w, fontSize, bold);
			tf.y = y;
			tf.height = h;
			container.addChild(tf);
		}
		
		public static function setupTextFieldC2(container:Sprite, name:String,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, bold:Object=false):TextField {
			var tf:TextField = new TextField();
			tf.text = name;
			setupTextFieldC1(container, tf, x, y, w, h, fontSize, bold);
			return tf;
		}

		// embedded font;
		public static function setupTextFieldC3(container:Sprite, name:String,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, color:Object):TextField {
			var myFont:Font = new ArialBoldFont();
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.font = myFont.fontName;
			format.size = fontSize;
			format.color = color;
			
			var tf:TextField = new TextField();
			tf.text = name;
			tf.x = x;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.autoSize = TextFieldAutoSize.NONE;
			tf.selectable = false;
			tf.embedFonts = true;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.defaultTextFormat = format;
			tf.setTextFormat(format);
			tf.rotation = -90;
			container.addChild(tf);
			return tf;
		}

		public static function setupTextFieldC4(container:Sprite, name:String,
																						xMid:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, bold:Object=false):TextField {
			var tf:TextField = new TextField();
			tf.text = name;
			setupTextFieldC1(container, tf, xMid - w / 2, y, w, h, fontSize, bold);
			// move to the left to align with the mid point;
			tf.x = xMid - tf.getBounds(container).width / 2;
			return tf;
		}
		
		public static function setupTextFieldR1(container:Sprite, tf:TextField,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, bold:Object=false):void {
			tf.x = x;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.RIGHT;
			format.size = fontSize;
			format.bold = bold;
			format.font = "Arial";
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
			container.addChild(tf);
		}
		
		public static function setupTextFieldR2(container:Sprite, name:String,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, bold:Object=false):TextField {
			var tf:TextField = new TextField();
			tf.autoSize = TextFieldAutoSize.RIGHT;
			tf.text = name;
			setupTextFieldR1(container, tf, x, y, w, h, fontSize, bold);
			return tf;
		}
		
		public static function setupTextFieldL1(container:Sprite,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, bold:Object=false):TextField {
			var tf:TextField = new TextField();
			tf.x = x;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.LEFT;
			format.size = fontSize;
			format.bold = bold;
			format.font = "Arial";
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
			container.addChild(tf);
			return tf;
		}
		
		public static function setupTextFieldL2(container:Sprite, name:String,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, bold:Object=false):TextField {
			var tf:TextField = setupTextFieldL1(container, x, y, w, h, fontSize, bold);
			tf.text = name;
			return tf;
		}
		
		public static function setupTextFieldL34Help(myFont:Font,
																						container:Sprite, name:String,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, bold:Object=false):TextField {
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.LEFT;
			format.font = myFont.fontName;
			format.size = fontSize;
			format.bold = bold;
			
			var tf:TextField = new TextField();
			tf.text = name;
			tf.x = x;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.autoSize = TextFieldAutoSize.NONE;
			tf.selectable = false;
			tf.embedFonts = true;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.defaultTextFormat = format;
			tf.setTextFormat(format);
			container.addChild(tf);
			
			return tf;
		}
		
		public static function setupTextFieldL4(container:Sprite, name:String,
																						x:Number, yTop:Number, w:Number, hFrame:Number,
																						fontSize:Object, bold:Object=false):TextField {
			var myFont:Font = new ArialBoldFont();
			var ret:TextField = setupTextFieldL34Help(myFont, container, name, x, yTop, w, hFrame, fontSize, bold);
			ret.rotation = -90;
			return ret;
		}

		public static function setupBackground(container:Sprite,
																					 color:uint, alpha:Number,
																					 x:Number, y:Number, w:Number, h:Number):void {
			var bg:Shape = new Shape();
			bg.graphics.beginFill(color, alpha);
			bg.graphics.drawRect(x, y, w, h);
			bg.graphics.endFill();
			container.addChild(bg);
		}
		
		public static function boldFormat():TextFormat {
			var boldFormat:TextFormat = new TextFormat();
			boldFormat.bold = true;
			return boldFormat;
		}
		
		public static function boldCenterFormat():TextFormat {
			var ret = boldFormat()
			ret.align = TextFormatAlign.CENTER;
			return ret;
		}
		
		public static function getColorByCursor(cursor:String):uint {
			switch (cursor) {
				case WsConsts.CORN_CURSOR:
					return WsConsts.CORN_COLOR;
				case WsConsts.SOY_CURSOR:
					return WsConsts.SOY_COLOR;
				case WsConsts.HAY_CURSOR:
					return WsConsts.HAY_COLOR;
				case WsConsts.FOREST_CURSOR:
					return WsConsts.FOREST_COLOR;
				default:
					return WsConsts.LANDUSE_UNUSE_COLOR;
			}
		}
		
		public static function getEcoServiceByUse(useColor:uint):int {
			switch (useColor) {
				case WsConsts.CORN_COLOR:
					return WsConsts.CORN;
				case WsConsts.SOY_COLOR:
					return WsConsts.SOY;
				case WsConsts.HAY_COLOR:
					return WsConsts.HAY;
				case WsConsts.FOREST_COLOR:
					return WsConsts.FOREST;
				default:
					return WsConsts.NOSERVICE;
			}
		}
		
	}
}
