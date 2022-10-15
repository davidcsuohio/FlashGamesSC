package code {

  import flash.display.Bitmap;

  public class CarbonEnergyEfficiencyView extends CarbonActionCategoryView {

    public function CarbonEnergyEfficiencyView(
														categoryData:CarbonActionCategoryData) {
      super(categoryData);
    }

    override protected function createFirstPageActionViews():void {
			// create actions;
			createActionView(0, new Bitmap(new GeothermalBD()), new Bitmap(new Geothermal2BD()), 0);
			createActionView(1, new Bitmap(new InsulationBD()), new Bitmap(new Insulation2BD()), 1);
			createActionView(2, new Bitmap(new CarmpgBD()), new Bitmap(new Carmpg2BD()), 2);
			createActionView(3, new Bitmap(new TruckmpgBD()), new Bitmap(new Truckmpg2BD()), 3);
			createActionView(4, new Bitmap(new WindowBD()), new Bitmap(new Window2BD()), 4);
    }
		
		override protected function createSecondPageActionViews():void {
			// create actions;
			createActionView(5, new Bitmap(new TrainBD()), new Bitmap(new Train2BD()), 0);
			createActionView(6, new Bitmap(new TvoffBD()), new Bitmap(new Tvoff2BD()), 1);
			createActionView(7, new Bitmap(new CflbulbsBD()), new Bitmap(new Cflbulbs2BD()), 2);
		}
  }
}