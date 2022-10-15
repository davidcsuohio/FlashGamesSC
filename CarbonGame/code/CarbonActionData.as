package code {

  public class CarbonActionData {
		
    private const ATMOSPHERE_CONST:int = -10;
		private const BIOMASS_CONST:int = 2;
		private const OCEANS_CONST:int = -3;
		private const FOSSILFUELS_CONST:int = 1;

    private var displayName:String;
    private var limit:int;
    private var atmosphere:int;
    private var biomass:int;
    private var oceans:int;
    private var fossilFuels:int;

		private var number:int;
		// back reference; see comments in CarbonData;
		private var categoryData:CarbonActionCategoryData;

    // might need action name here;
    public function CarbonActionData(categoryData:CarbonActionCategoryData,
																		 displayName:String,
																		 limit:int,
                                     atmosphere:int,
                                     biomass:int,
                                     oceans:int,
                                     fossilFuels:int) {
			this.categoryData = categoryData;
			this.displayName = displayName;
      this.limit = limit;
      this.atmosphere = atmosphere;
      this.biomass = biomass;
      this.oceans = oceans;
      this.fossilFuels = fossilFuels;
			
			this.number = 0;
    }

    public function getDisplayName():String {
			return this.displayName;
		}

    public function setNumber(number:int):void {
      this.number = number;
    }
		
		public function getNumber():int {
			return this.number;
		}
		
		public function getLimit():int {
			return this.limit;
		}

		public function getTotal():int {
			return getAtmospherePoints() + getBiomassPoints() + getOceansPoints() + getFossilFuelsPoints();
		}

		public function getTotalLimit():int {
			return this.limit * (ATMOSPHERE_CONST * this.atmosphere +
													 BIOMASS_CONST * this.biomass +
													 OCEANS_CONST * this.oceans +
													 FOSSILFUELS_CONST * this.fossilFuels);
		}

		public function getRestPoints():int {
			return getTotalLimit() - getTotal();
		}

		public function getAtmospherePoints():int {
			return this.number * ATMOSPHERE_CONST * this.atmosphere;
		}

		public function getBiomassPoints():int {
			return this.number * BIOMASS_CONST * this.biomass;
		}

		public function getOceansPoints():int {
			return this.number * OCEANS_CONST * this.oceans;
		}

		public function getFossilFuelsPoints():int {
			return this.number * FOSSILFUELS_CONST * this.fossilFuels;
		}

    public function updateScores():void {
			categoryData.updateScores();
		}
		
		public function getCategoryMaxActionLimit():int {
			return categoryData.getMaxActionLimit();
		}
  }
}