package code {
	import flash.events.UncaughtErrorEvent;

  public final class WsConsts {
		public static const NOSERVICE:int = 0; // LANDUSE_UNUSE_COLOR - BLACK
		public static const CORN:int = 1;   // YELLOW
		public static const SOY:int = 2;    // ORANGE
		public static const FOREST:int = 3; // GREEN
		public static const HAY:int = 4;    // LIGHT_GREEN
		public static const CORN_CURSOR:String = "cornCursor";
		public static const SOY_CURSOR:String = "soyCursor";
		public static const HAY_CURSOR:String = "hayCursor";
		public static const FOREST_CURSOR:String = "forestCursor";
		
		public static const GAME_WIDTH:Number = 1000;
		public static const GAME_HEIGHT:Number = 730;
		public static const GAME_TITLE_HEIGHT:Number = 30;
		public static const PICTURE_X:Number = 24;
		public static const PICTURE_Y:Number = 53;
		public static const PICTURE_WIDTH:Number = 350;
		public static const PICTURE_HEIGHT:Number = 515;
		public static const ACRES_PER_SQKM:Number = 247.105381;
		public static const HECTARES_PER_SQKM:Number = 100;
		public static const CLOSE_BUTTON_WIDTH:Number = 100;
		public static const CLOSE_BUTTON_HEIGHT:Number = 20;
		public static const IMAGE_MAP_WIDTH:Number = 980;
		public static const IMAGE_MAP_HEIGHT:Number = 680;

		public static const BLACK_COLOR:uint = 0x000000;
		public static const RED_COLOR:uint = 0xFF0000;
		public static const FOREST_COLOR:uint = 0x006600;
		public static const CORN_COLOR:uint = 0xFFFF00;
		public static const HAY_COLOR:uint = 0x99FF00;
		public static const SOY_COLOR:uint = 0xFF9900;
		public static const STEEL_BLUE_COLOR:uint = 0x4F94CD;
		public static const WHITE_COLOR:uint = 0xFFFFFF;
		public static const BACKGROUND_COLOR:uint = 0x28FFFF;
		public static const ADD_SCORE_BG_COLOR:uint = 0xE4C3A8;
		public static const LANDUSE_UNUSE_COLOR:uint = 0x000000;
		public static const BLUE_COLOR:uint = 0x0000FF;
		// PURPLE_COLOR = DARK_ORCHID_COLOR
		public static const PURPLE_COLOR:uint = 0xBF3EFF;
		public static const GREEN_COLOR:uint = 0x00FF00;
		public static const YELLOW_COLOR:uint = 0xFFFF00;
		public static const PALE_GREEN_COLOR:uint = 0xEAF3D7;
		public static const SOIL_COLOR:uint = 0x705951;
		public static const WATER_COLOR:uint = 0x50A29C;
		public static const FLOOD_COLOR:uint = 0xF34F67;
		public static const CARBON_COLOR:uint = 0x000000;
		public static const RELATIONSHIPS_BG_COLOR:uint = 0xCCFFFF;
		public static const LIGHT_GREY_COLOR:uint = 0xD3D3D3;

		public static const GAME_TITLE:String = "THE WATERSHED GAME";
		public static const YEAR_ONE_LAND_USE_NAME:String = "Year 1 Land Use";
		public static const YEAR_TWO_LAND_USE_NAME:String = "Year 2 Land Use";
		public static const CORN_NAME:String = "CORN";
		public static const SOYBEANS_NAME:String = "SOYBEANS";
		public static const HAY_NAME:String = "HAY";
		public static const FOREST_NAME:String = "FOREST";
		public static const RESET_NAME:String = "RESET";
		public static const SUBMIT_NAME:String = "SUBMIT";
		public static const CLOSE_ECO_SCORE_NAME:String = "Close Ecosystem Score";
		public static const TOTAL_ECOSYSTEM_SERVICES_SCORE_NAME:String = "TOTAL ECOSYSTEM SERVICES SCORE";
		public static const YOU_EARNED_NAME:String = "YOU EARNED $";
		public static const ADD_SCORES_NAME:String = "ADD SCORES";
		public static const TOTAL_DOLLARS_FROM_CROPS_NAME:String = "TOTAL DOLLARS FROM CROPS";
		public static const ACRES_NAME:String = "ACRES";
		public static const DOLLARS_NAME:String = "DOLLARS";
		public static const ECOSYSTEM_SERVICES_NAME:String = "Ecosystem Services";
		public static const CLOSE_ECO_SERVICES_NAME:String = "Close Ecosystem Services";
		public static const SOIL_CONSERVATION_NAME:String = "SOIL CONSERVATION";
		public static const WATER_QUALITY_NAME:String = "WATER QUALITY";
		public static const FLOOD_REDUCTION_NAME:String = "FLOOD REDUCTION";
		public static const CARBON_RETENTION_NAME:String = "CARBON RETENTION";
		public static const SCORE_GRAPH_NAME:String = "SCORE GRAPH";
		public static const CLOSE_NAME:String = "CLOSE";
		public static const SLOPE_RELATION_TITLE:String = "SOIL EROSION(TONS/AC/YR)";
		public static const WATER_RELATION_TITLE:String = "WATER POLLUTION/AC/YR";
		public static const CARBON_RELATION_TITLE:String = "CARBON RETENTION/AC/YR";
		public static const FLOOD_RELATION_TITLE:String = "PEAK WATER FLOW (CFS)";
		public static const REVENUE_RELATION_TITLE:String = "AVERAGE REVENUE/AC/YR";
		public static const BASIC_RELATIONSHIPS_NAME:String = "BASIC RELATIONSHIPS";
		public static const CLOSE_BASIC_RELATIONSHIPS_NAME:String = "Close Basic Relationships";
		public static const CLOSE_SATELLITE_IMAGE_NAME:String = "Close Satellite Image";
		public static const CLOSE_STREET_MAP_NAME:String = "Close Street Map";
		public static const LOW_NAME:String = "LOW";
		public static const HIGH_NAME:String = "HIGH";
		public static const SLOPE_NAME:String = "SLOPE (%)";
		public static const SATELLITE_IMAGE_NAME:String = "SATELLITE IMAGE";
		public static const STREET_MAP_NAME:String = "STREET MAP";
		public static const GRAPHS_NAME:String = "GRAPHS";
		public static const GRAPHS_CB_PROMPT:String = "SELECT A GRAPH";
		public static const PRESET_OPTIONS_NAME:String = "PRESET OPTIONS";
		public static const PRESET_CB_PROMPT:String = "SELECT AN OPTION";
		public static const OPTION_1_NAME:String = "OPTION 1";
		public static const OPTION_2_NAME:String = "OPTION 2";
		public static const OPTION_3_NAME:String = "OPTION 3";
		public static const OPTION_4_NAME:String = "OPTION 4";
		public static const INITIAL_NAME:String = "INITIAL";
		public static const ESS_SCORE_NAME:String = "ESS SCORE";
		public static const ADD_NEW_ITEM_NAME:String = "ADD NEW ROW";
	}
	
}
