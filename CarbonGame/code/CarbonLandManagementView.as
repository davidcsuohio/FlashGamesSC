package code {

	import flash.display.Bitmap;

  public class CarbonLandManagementView extends CarbonActionCategoryView {

    public function CarbonLandManagementView(
														categoryData:CarbonActionCategoryData) {
      super(categoryData);
    }

		override public function createActionViews():void {
			super.createContainer();
			// create actions;
			createActionView(0, new Bitmap(new TillageBD()), new Bitmap(new Tillage2BD()), 0);
			createActionView(1, new Bitmap(new TreesfarmBD()), new Bitmap(new Treesfarm2BD()), 1);
			createActionView(2, new Bitmap(new CattleBD()), new Bitmap(new Cattle2BD()), 2);
			createActionView(3, new Bitmap(new WetlandfarmBD()), new Bitmap(new Wetlandfarm2BD()), 3);
			createActionView(4, new Bitmap(new CementBD()), new Bitmap(new Cement2BD()), 4);
    }
  }
}