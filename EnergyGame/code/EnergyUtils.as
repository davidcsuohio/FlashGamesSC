package code {

  import flash.display.*;
  import flash.text.*;
	
  public final class EnergyUtils {

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
	}
}
