package code {

	import flash.events.Event;

  public class WsEvent extends Event {

		public static const RESET_LANDUSE:String = "resetLanduse";
		public static const SUBMIT_LANDUSE:String = "submitLanduse";
		public static const CLEAR_ERROR_MSG:String = "clearErrorMsg";
		public static const CLOSE_ECO_SCORE:String = "closeEcoScore";
		public static const CLOSE_ECO_SERVICE:String = "closeEcoService";
		public static const ADD_ECO_SCORE:String = "addEcoScore";
		public static const CLOSE_RELATIONSHIPS:String = "closeRelationships";
		public static const CLOSE_SATELLITE_IMAGE:String = "closeSatelliteImage";
		public static const CLOSE_STREET_MAP:String = "closeStreetMap";
		public static const ADD_ADD_SCORES:String = "addAddScores";
		public static const CLOSE_ADD_SCORES:String = "closeAddScores";
		public static const ADD_NEW_ITEM:String = "addNewItem";

    public function WsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
    }

		override public function toString():String {
			return formatToString("WsEvent", "type", "bubbles", "cancelable");
		}
		
		override public function clone():Event {
			return new WsEvent(type, bubbles, cancelable);
		}
  }
}