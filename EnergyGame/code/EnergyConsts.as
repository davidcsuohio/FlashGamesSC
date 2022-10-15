package code {

  public final class EnergyConsts {
		
		public static const DELTA_X:Number = 10;
		// need to manually change stage Size property of EnergyGame.fla if these two values are going to change;
		public static const GAME_WIDTH:Number = 910;
		public static const GAME_HEIGHT:Number = 657;

    public static const VERY_EASY_NAME:String = "VERY EASY";
    public static const EASY_NAME:String = "EASY";
    public static const MEDIUM_NAME:String = "MEDIUM";
    public static const HARD_NAME:String = "HARD";
    public static const VERY_HARD_NAME:String = "VERY HARD";
		
		public static const STRING_ZERO:String = "0";
		public static const PLAN_NAME:String = "PLAN";
		public static const ENERGY_NAME:String = "ENERGY";
		public static const FUEL_NAME:String = "FUEL";
		public static const ELEC_NAME:String = "ELEC";
		public static const BUDGET_NAME:String = "BUDGET";
		public static const GHG_NAME:String = "GHG";
		public static const SAVE_GAME_NAME:String = "SAVE GAME";
		public static const LOAD_GAME_NAME:String = "LOAD GAME";
		public static const NEW_GAME_NAME:String = "NEW GAME";
		public static const ENERGY_SECTOR_NAME:String = "ENERGY SECTOR";
		public static const DIFFICULTY_NAME:String = "DIFFICULTY";
		public static const YEAR_NAME:String = "YEAR";
		public static const OBJECTIVES_NAME:String = "OBJECTIVES";
		public static const GAME_TITLE:String = "THE ENERGY GAME";
		public static const BUDGET_LIMIT_NAME:String = "BUDGET LIMIT";
		public static const OIL_LIMIT_NAME:String = "OIL LIMIT";
		public static const GHG_LIMIT_FULL_NAME:String = "GREEN HOUSE GAS LIMIT";
		public static const GHG_LIMIT_NAME:String = "GHG LIMIT";
		public static const ELECTRICITY_MINIMUM_NAME:String = "ELECTRICITY MINIMUM";
		public static const TOTAL_ENERGY_MINIMUM_NAME:String = "TOTAL ENERGY MINIMUM";
		public static const HEAT_MINIMUM_NAME:String = "HEAT MINIMUM";
		public static const FUEL_MINIMUM_NAME:String = "FUEL MINIMUM";
		public static const ELECTRICITY_MIN_NAME:String = "ELECTRICITY MIN";
		public static const ENERGY_MIN_NAME:String = "ENERGY MIN";
		public static const HEAT_MIN_NAME:String = "HEAT MIN";
		public static const FUEL_MIN_NAME:String = "FUEL MIN";
		public static const ACTUAL_NAME:String = "ACTUAL";
		
    public static const EFFICIENCY_INVESTMENT_NAME:String = "EFFICIENCY INVESTMENT";
    public static const HEAT_NAME:String = "HEAT";
    public static const VEHICLE_FUEL_NAME:String = "VEHICLE FUEL";
		public static const NEXT_BUTTON_LABEL_NAME:String = "MORE";
		public static const PREV_BUTTON_LABEL_NAME:String = "PREV";
		
    // source names
		public static const COAL_NAME:String = "COAL";
		public static const NATURAL_GAS_NAME:String = "NATURAL GAS";
		public static const OLD_NUCLEAR_NAME:String = "NUCLEAR ('70s)";
		public static const HYDRO_NAME:String = "HYDRO";
		public static const WIND_NAME:String = "WIND";
		public static const OIL_NAME:String = "OIL";
		public static const NEW_NUCLEAR_NAME:String = "NEW NUCLEAR";
		public static const CLEAN_COAL_NAME:String = "CLEAN COAL";
		public static const SOLAR_NAME:String = "SOLAR";
		public static const BIOFUELS_NAME:String = "BIOFUELS";
		public static const GEOTHERMAL_NAME:String = "GEOTHERMAL";
		public static const FUSION_NAME:String = "FUSION";
    public static const CROP_BIOFUELS_NAME:String = "CROP BIOFUELS";
		public static const CELLULOSIC_NAME:String = "CELLULOSIC BIOFUELS";
    public static const ELECTRICITY_NAME:String = "ELECTRICITY";
    public static const EFFICIENCY_NAME:String = "EFFICIENCY";
		// source keys
		public static const COAL_KEY:int = 1;
		public static const NATURAL_GAS_KEY:int = 2;
		public static const OLD_NUCLEAR_KEY:int = 3;
		public static const HYDRO_KEY:int = 4;
		public static const WIND_KEY:int = 5;
		public static const OIL_KEY:int = 6;
		public static const NEW_NUCLEAR_KEY:int = 7;
		public static const CLEAN_COAL_KEY:int = 8;
		public static const SOLAR_KEY:int = 9;
		public static const BIOFUELS_KEY:int = 10;
		public static const GEOTHERMAL_KEY:int = 11;
		public static const FUSION_KEY:int = 12;
		public static const CROP_BIOFUELS_KEY:int = 13;
		public static const CELLULOSIC_KEY:int = 14;
		public static const ELECTRICITY_KEY:int = 15;
		public static const EFFICIENCY_KEY:int = 16;
		
		// color definition:
		public static const BACKGROUND_COLOR:uint = 0xEAF3D7;
		// if we change this color, we need to change the color of the EnergySliderThumb symbol as well;
		public static const SLIDER_BAR_COLOR:uint = 0x91C84B;
		public static const PLAN_BACKGROUND_COLOR:uint = 0xF6E7CD;
		public static const GOAL_NOT_MET_COLOR:uint = 0xFF0000;
		public static const GOAL_MET_COLOR:uint = 0x91C84B;
//		public static const RED_COLOR:uint = 0xFF0000;
		public static const CUBE_ORANGE_COLOR:uint = 0xFFA500;
		public static const CURVE_GREEN_COLOR:uint = 0x669900;
		public static const PRICE_TEXT_COLOR:uint = 0x006F3B;
  }
}