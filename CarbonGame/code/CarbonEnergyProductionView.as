package code {

	import flash.display.Bitmap;
	
  public class CarbonEnergyProductionView extends CarbonActionCategoryView {

    public function CarbonEnergyProductionView(
														categoryData:CarbonActionCategoryData) {
      super(categoryData);
    }

    override protected function createFirstPageActionViews():void {
			// create actions;
			createActionView(0, new Bitmap(new Co2captureBD()), new Bitmap(new Co2capture2BD()), 0);
			createActionView(1, new Bitmap(new HydrogencarBD()), new Bitmap(new Hydrogencar2BD()), 1);
			createActionView(2, new Bitmap(new BiofueledcarBD()), new Bitmap(new Biofueledcar2BD()), 2);
			createActionView(3, new Bitmap(new WoodcoalplantBD()), new Bitmap(new Woodcoalplant2BD()), 3);
			createActionView(4, new Bitmap(new SolarroofBD()), new Bitmap(new Solarroof2BD()), 4);
		}
		
    override protected function createSecondPageActionViews():void {
			// create actions;
			createActionView(5, new Bitmap(new GasplantBD()), new Bitmap(new Gasplant2BD()), 0);
			createActionView(6, new Bitmap(new NuclearplantBD()), new Bitmap(new Nuclearplant2BD()), 1);
			createActionView(7, new Bitmap(new SolarplantBD()), new Bitmap(new Solarplant2BD()), 2);
			createActionView(8, new Bitmap(new WindfarmBD()), new Bitmap(new Windfarm2BD()), 3);
    }
  }
}