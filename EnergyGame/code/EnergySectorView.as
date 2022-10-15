package code {

  import flash.display.Sprite;
  import flash.display.MovieClip;
  import fl.controls.Button;
  import flash.events.MouseEvent;
	
  public class EnergySectorView extends Sprite {

    private const ICON_X_OFFSET:int = 16;
		private const BUTTON_X_OFFSET:int = 16;
		private const BUTTON_WIDTH:int = 70;
		private const BUTTON_HEIGHT:int = 30;
		private const SOURCE_VIEW_HEIGHT:int = 50;
		
    private var data:EnergyDataSector;
    private var sectorName:String;
		private var xPos:Number;
		private var yPos:Number;
		// assume only two pages;
		private var nextBtn:Button;
		private var prevBtn:Button;

    public function EnergySectorView(data:EnergyDataSector,
																		 name:String,
																		 x:Number,
																		 y:Number) {
			this.data = data;
			sectorName = name;
			xPos = x;
			yPos = y;
    }
		
		// the EnergySourceView is not displayed if its limit equals to 0;
    public function createSectorView():void {
			var nzls:Vector.<EnergyDataElement> = this.data.getNonZeroLimitSources();
			var count:uint = nzls.length;
			if (count > 6) {
			  count = 6;
			}
			var xP:Number = xPos + ICON_X_OFFSET;
			var yP:Number;
			var i:uint;
			for (i = 0; i < count; i++) {
				yP = yPos + SOURCE_VIEW_HEIGHT * i;
				createSourceView(nzls[i], xP, yP);
			}
			if (nzls.length > 6) {
			  nextBtn = new Button();
				nextBtn.label = EnergyConsts.NEXT_BUTTON_LABEL_NAME;
				nextBtn.move(BUTTON_X_OFFSET, yPos + SOURCE_VIEW_HEIGHT * 6);
				nextBtn.setSize(BUTTON_WIDTH, BUTTON_HEIGHT);
				nextBtn.addEventListener(MouseEvent.CLICK, nextBtnClicked, false, 0, true);
				addChild(nextBtn);
			}
		}
		
		private function nextBtnClicked(event:MouseEvent):void {
			removeChildren();
			var nzls:Vector.<EnergyDataElement> = this.data.getNonZeroLimitSources();
			var xP:Number = xPos + ICON_X_OFFSET;
			var yP:Number;
			var i:uint;
			for (i = 6; i < nzls.length; i++) {
				yP = yPos + SOURCE_VIEW_HEIGHT * (i - 6);
				createSourceView(nzls[i], xP, yP);
			}
			prevBtn = new Button();
			prevBtn.label = EnergyConsts.PREV_BUTTON_LABEL_NAME;
			prevBtn.move(BUTTON_X_OFFSET, yPos + SOURCE_VIEW_HEIGHT * 6);
			prevBtn.setSize(BUTTON_WIDTH, BUTTON_HEIGHT);
			prevBtn.addEventListener(MouseEvent.CLICK, prevBtnClicked, false, 0, true);
			addChild(prevBtn);
		}
		
		private function prevBtnClicked(event:MouseEvent):void {
			removeChildren();
			createSectorView();
		}
		
		private function removeChildren():void {
			if (numChildren <= 0) { return; }
			for (var i:int = numChildren - 1; i >= 0; i--) {
				removeChildAt(i);
			}
		}
		
		private function createSourceView(element:EnergyDataElement, xP:Number, yP:Number):void {
			var mcIcon:MovieClip;
			switch (element.key) {
				case EnergyConsts.COAL_KEY:
				  mcIcon = new CoalMC();
					break;
				case EnergyConsts.NATURAL_GAS_KEY:
				  mcIcon = new NaturalGasMC();
					break;
				case EnergyConsts.OLD_NUCLEAR_KEY:
				  mcIcon = new OldNuclearMC();
					break;
				case EnergyConsts.HYDRO_KEY:
				  mcIcon = new HydroMC();
					break;
				case EnergyConsts.WIND_KEY:
				  mcIcon = new WindMC();
					break;
				case EnergyConsts.OIL_KEY:
				  mcIcon = new OilMC();
					break;
				case EnergyConsts.NEW_NUCLEAR_KEY:
				  mcIcon = new NewNuclearMC();
					break;
				case EnergyConsts.CLEAN_COAL_KEY:
				  mcIcon = new CleanCoalMC();
					break;
				case EnergyConsts.SOLAR_KEY:
				  mcIcon = new SolarMC();
					break;
				case EnergyConsts.BIOFUELS_KEY:
				  mcIcon = new BiofuelsMC();
					break;
				case EnergyConsts.GEOTHERMAL_KEY:
				  mcIcon = new GeothermalMC();
					break;
				case EnergyConsts.FUSION_KEY:
				  mcIcon = new FusionMC();
					break;
				// use the same icon as BIOFUELS_KEY;
				case EnergyConsts.CROP_BIOFUELS_KEY:
				  mcIcon = new BiofuelsMC();
					break;
				case EnergyConsts.CELLULOSIC_KEY:
				  mcIcon = new CellulosicMC();
					break;
				case EnergyConsts.ELECTRICITY_KEY:
				  mcIcon = new ElecMC();
					break;
				case EnergyConsts.EFFICIENCY_KEY:
				  mcIcon = new EfficMC();
					break;
				default:
          mcIcon = new OilMC();
			}
			var src:EnergySourceView = new EnergySourceView(element, mcIcon, xP, yP, data);
//			sources.push(src);
			addChild(src);
		}
		
  }
}