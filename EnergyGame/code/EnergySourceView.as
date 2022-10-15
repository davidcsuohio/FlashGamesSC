package code {

  import flash.display.*;
	import fl.events.*;
	import flash.text.*;
	import flash.events.*;

  public class EnergySourceView extends EnergyViewBase {

    // icon width 31
    private const SLIDER_X_POSITION:int = 43;
		private const SLIDER_Y_POSITION:int = 15;
		private const SLIDER_WIDTH:int = 240;
		private const NAME_Y_POSITION:int = 0;
		private const ICON_Y_POSITION:int = 4;
		
    private var sourceData:EnergyDataElement;
    private var sourceIcon:MovieClip;
    private var slider:EnergySlider = null;
		private var xPos:Number;
		private var yPos:Number;
		private var sectorData:EnergyDataSector;
		private var priceTF:TextField;

    public function EnergySourceView(data:EnergyDataElement,
																		 icon:MovieClip,
																		 x:Number,
																		 y:Number,
																		 sectorData:EnergyDataSector,
																		 updatePrice:Boolean=false) {
			sourceData = data;
			sourceIcon = icon;
			xPos = x;
			yPos = y;
			this.sectorData = sectorData;
			priceTF = null;
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			sourceIcon.x = xPos;
			sourceIcon.y = yPos + ICON_Y_POSITION;
			addChild(sourceIcon);
			
			setupName();
			setupSlider();
    }

    private function setupSlider():void {
			slider = new EnergySlider(0, sourceData.limit, sourceData.value);
			slider.x = xPos + SLIDER_X_POSITION;
			slider.y = yPos + SLIDER_Y_POSITION;
			slider.setSize(SLIDER_WIDTH * sourceData.limit / sectorData.getMaxSourceLimit(), 20);
			slider.addEventListener(SliderEvent.CHANGE, sliderChanged, false, 0, true);
			
			addChild(slider);
		}
		
  	private function sliderChanged(e:SliderEvent):void {
      var curr:Number = e.target.value;
			sourceData.value = curr;
			if (sourceData.updatePrice() && priceTF) {
				priceTF.text = "$" + String(sourceData.price);
			}
			this.dispatchEvent(new EnergyEvent(EnergyEvent.UPDATE_NON_SECTOR_VIEW, true));
		}
		
		private function setupName():void {
			var tf:TextField = super.setupTextFieldL3(sourceData.name,
																								xPos + SLIDER_X_POSITION,
																								yPos + NAME_Y_POSITION,
																								10,
																								true); 
			var tf2:TextField = super.setupTextFieldL3("$" + String(sourceData.price),
																								 tf.x + tf.getBounds(this).width,
																								 tf.y - 1,
																								 12,
																								 true,
																								 EnergyConsts.PRICE_TEXT_COLOR);
			if (sourceData.updatePrice())
				priceTF = tf2;
		}
  }
}