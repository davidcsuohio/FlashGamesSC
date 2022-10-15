package code {

  public class CarbonActionCategoryData {

    private var categoryName:String;
		private var limit:int;
    private var actions:Vector.<CarbonActionData>;
		// back reference; see comments in CarbonData;
		private var carbonData:CarbonData;

    public function CarbonActionCategoryData(carbonData:CarbonData,
																						 limit:int,
                                             categoryName:String) {
			this.carbonData = carbonData;
      this.limit = limit;
      this.categoryName = categoryName;
			this.actions = new Vector.<CarbonActionData>();
    }

    public function addAction(action:CarbonActionData):void {
      this.actions.push(action);
    }
		
		public function getNumber():int {
			var number:int = 0;
			var len:uint = this.actions.length;
			for (var i:uint = 0; i < len; i++) {
				number += this.actions[i].getNumber();
			}
			return number;
		}
		
		public function getLimit():int {
			return this.limit;
		}
		
		public function getTotal():int {
			var number:int = 0;
			var len:uint = this.actions.length;
			for (var i:uint = 0; i < len; i++) {
				number += this.actions[i].getTotal();
			}
			return number;
		}
		
		public function getActionData(actionIndex:int):CarbonActionData {
			return this.actions[actionIndex];
		}

    public function updateScores():void {
			carbonData.updateScores();
		}

    public function getMaxActionLimit():int {
			var max:int = 0;
			var aLimit:int = 0;
			var len:uint = this.actions.length;
			for (var i:uint = 0; i < len; i++) {
				aLimit = this.actions[i].getLimit();
				if (max < aLimit) {
					max = aLimit;
				}
			}
			return max;
		}
  }
}