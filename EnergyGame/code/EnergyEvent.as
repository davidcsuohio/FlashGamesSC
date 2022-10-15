package code {

	import flash.events.Event;

  public class EnergyEvent extends Event {

		public static const UPDATE_NON_SECTOR_VIEW:String = "updateNonSectorView";
		public static const UPDATE_ALL_VIEWS:String = "updateAllViews";
		public static const UPDATE_OBJECTIVES:String = "updateObjectives";

    public function EnergyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
    }

		override public function toString():String {
			return formatToString("EnergyEvent", "type", "bubbles", "cancelable");
		}
		
		override public function clone():Event {
			return new EnergyEvent(type, bubbles, cancelable);
		}
  }
}