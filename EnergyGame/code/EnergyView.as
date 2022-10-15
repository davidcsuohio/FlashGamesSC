package code {

  import flash.display.*;
	import flash.events.*;
	import flash.net.FileReference;
	import flash.utils.*;
	import fl.motion.easing.Back;

  public class EnergyView extends Sprite {

    // bottom:558; budget h:230; plan h:473; cubes h:361; ghg h:244; oil h:150;
		private const PLAN_X:int = 312 + EnergyConsts.DELTA_X;
		private const PLAN_Y:int = 136;
		private const FUEL_X:int = 497 + EnergyConsts.DELTA_X;
		private const FUEL_Y:int = 350;
		private const ELEC_X:int = 432 + EnergyConsts.DELTA_X;
		private const ELEC_Y:int = 637;
		private const HEAT_X:int = 497 + EnergyConsts.DELTA_X;
		private const HEAT_Y:int = 637;
		private const ENERGY_X:int = 572 + EnergyConsts.DELTA_X;
		private const ENERGY_Y:int = 637;
		private const BUDGET_X:int = 660 + EnergyConsts.DELTA_X;
		private const BUDGET_Y:int = 360;
		private const OIL_X:int = 663 + EnergyConsts.DELTA_X;
		private const OIL_Y:int = 637;
		private const GHG_X:int = 776 + EnergyConsts.DELTA_X;
		private const GHG_Y:int = 637;
		private const OBJ_INFO_X:int = 15;
		private const OBJ_INFO_Y:int = 495;
		private const YOU_WIN_X:int = 520 + EnergyConsts.DELTA_X;
		private const YOU_WIN_Y:int = 130;
		
    private var data:EnergyData;
		private var toolbar:EnergyToolbar;
		private var plan:EnergyPlan;
		private var heat:EnergyHeat;
		private var fuel:EnergyFuel;
		private var elec:EnergyElec;
		private var energy:EnergyEnergy;
		private var budget:EnergyBudget;
		private var ghg:EnergyGhg;
		private var oil:EnergyOil;
		private var objInfo:EnergyInfoObjective;
		private var actualInfo:EnergyInfoActual;
		private var myTimer:Timer;
		private var blinkingToggle;
		private var youWinMC:MovieClip;
		
    public function EnergyView() {
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

		public function loadGame(xml:XML):void {
			initialize(xml);
		}
		
    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			initialize(null);
		}
		
		// load xml if it is not null;
		private function initialize(xml:XML) {
			removeChildren();
			myTimer = new Timer(200, 30);
			blinkingToggle = false;
			data = new EnergyData();
			if (xml) {
				data.loadXml(xml);
			}
			setupBackground();
			setupToolbar();
			setupEnergyPlan();
			setupEnergyHeat();
			setupEnergyFuel();
			setupEnergyElec();
			setupEnergyEnergy();
			setupEnergyBudget();
			setupEnergyGhg();
			setupEnergyOil();
			setupEnergyObjInfo();
			this.addEventListener(EnergyEvent.UPDATE_NON_SECTOR_VIEW, updateNonSectorView, false, 0, true);
			this.addEventListener(EnergyEvent.UPDATE_ALL_VIEWS, updateAllViews, false, 0, true);
			this.addEventListener(EnergyEvent.UPDATE_OBJECTIVES, updateObjectives, false, 0, true);
			myTimer.addEventListener(TimerEvent.TIMER, blinkingViews, false, 0, true);
			myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleted, false, 0, true);
			updateAllViews(null);
		}
		
		// this background is added as a workaround of the small edge area being cut off by the scroll pane
		// when the scroll bars appear.
		private function setupBackground():void {
			var bg:Shape = new Shape();
			bg.graphics.beginFill(EnergyConsts.BACKGROUND_COLOR);
			bg.graphics.drawRect(0, 0,
													 EnergyConsts.GAME_WIDTH,
													 EnergyConsts.GAME_HEIGHT);
			bg.graphics.endFill();
			addChild(bg);
		}
		
    private function setupToolbar():void {
			toolbar = new EnergyToolbar(data, this);
			addChild(toolbar);
		}
    
		private function setupEnergyPlan():void {
			plan = new EnergyPlan(data, PLAN_X, PLAN_Y);
			addChild(plan);
		}

		private function setupEnergyHeat():void {
			heat = new EnergyHeat(data, HEAT_X, HEAT_Y);
			addChild(heat);
		}
		
		private function setupEnergyFuel():void {
			fuel = new EnergyFuel(data, FUEL_X, FUEL_Y);
			addChild(fuel);
		}
		
		private function setupEnergyElec():void {
			elec = new EnergyElec(data, ELEC_X, ELEC_Y);
			addChild(elec);
		}
		
		private function setupEnergyEnergy():void {
			energy = new EnergyEnergy(data, ENERGY_X, ENERGY_Y);
			addChild(energy);
		}
		
		private function setupEnergyBudget():void {
			budget = new EnergyBudget(data, BUDGET_X, BUDGET_Y);
			addChild(budget);
		}
		
		private function setupEnergyGhg():void {
			ghg = new EnergyGhg(data, GHG_X, GHG_Y);
			addChild(ghg);
		}
		
		private function setupEnergyOil():void {
			oil = new EnergyOil(data, OIL_X, OIL_Y);
			addChild(oil);
		}

		private function setupEnergyObjInfo():void {
			objInfo = new EnergyInfoObjective(data, OBJ_INFO_X, OBJ_INFO_Y);
			addChild(objInfo);
		}

		private function updateNonSectorView(e:Event):void {
			updateViews(false);
		}
		
		private function updateAllViews(e:Event):void {
			if (data.isReadOnlyData) {
				if (myTimer.running) {
					timerCompleted(null);
				}
				// disable everything in Toolbar except for the year combobox
				toolbar.enableComponents(false);
				removeComponents();
				displayActualInfo(true);
				return;
			}
			else {
				displayActualInfo(false);
				// enable everything in Toolbar
				toolbar.enableComponents(true);
				updateObjectives(null);
  			updateViews(true);
			}
		}
		
		private function updateObjectives(e:Event):void {
			if (!objInfo.parent)
			  addChild(objInfo);
			if (data.budgetLimitChBSelected) {
				if (!budget.parent) {
					addChild(budget);
				}
				objInfo.displayBudget(true);
			}
			else {
				if (budget.parent) {
					removeChild(budget);
				}
				objInfo.displayBudget(false);
			}
			if (data.oilLimitChBSelected) {
				if (!oil.parent) {
					addChild(oil);
				}
				objInfo.displayOil(true);
			}
			else {
				if (oil.parent) {
					removeChild(oil);
				}
				objInfo.displayOil(false);
			}
			if (data.ghgLimitChBSelected) {
				if (!ghg.parent) {
					addChild(ghg);
				}
				objInfo.displayGhg(true);
			}
			else {
				if (ghg.parent) {
					removeChild(ghg);
				}
				objInfo.displayGhg(false);
			}
			if (data.electricityMinChBSelected) {
				if (!elec.parent) {
					addChild(elec);
				}
				objInfo.displayElec(true);
			}
			else {
				if (elec.parent) {
					removeChild(elec);
				}
				objInfo.displayElec(false);
			}
			if (data.energyMinChBSelected) {
				if (!energy.parent) {
					addChild(energy);
				}
				objInfo.displayEnergy(true);
			}
			else {
				if (energy.parent) {
					removeChild(energy);
				}
				objInfo.displayEnergy(false);
			}
			if (data.heatMinChBSelected) {
				if (!heat.parent) {
					addChild(heat);
				}
				objInfo.displayHeat(true);
			}
			else {
				if (heat.parent) {
					removeChild(heat);
				}
				objInfo.displayHeat(false);
			}
			if (data.fuelMinChBSelected) {
				if (!fuel.parent) {
					addChild(fuel);
				}
				objInfo.displayFuel(true);
			}
			else {
				if (fuel.parent) {
					removeChild(fuel);
				}
				objInfo.displayFuel(false);
			}
		}
		
		private function updateViews(limitChanged:Boolean):void {
			plan.updatePlan();
			heat.updateUsage(limitChanged);
			fuel.updateUsage(limitChanged);
			elec.updateUsage(limitChanged);
			energy.updateUsage(limitChanged);
			objInfo.updateInfo();
			budget.updateUsage(limitChanged);
			ghg.updateUsage(limitChanged);
			oil.updateUsage(limitChanged);
			// this function should not be called while it's read-only data;
			// no harm to check again here;
			if (!data.isReadOnlyData) {
				if (data.winGame()) {
					myTimer.start();
				}
				else {
					if (myTimer.running) {
						timerCompleted(null);
					}
				}
			}
		}
		
		private function blinkingViews(e:TimerEvent):void {
			displayComponents(blinkingToggle);
			displayYouWinMC(blinkingToggle);
			blinkingToggle = !blinkingToggle;
		}
		
		private function timerCompleted(e:TimerEvent):void {
			myTimer.reset();
			displayYouWinMC(false);
			updateObjectives(null);
		}
		
		private function displayComponents(display:Boolean) {
			if (display) {
				if (!heat.parent)
					addChild(heat);
				if (!fuel.parent)
					addChild(fuel);
				if (!elec.parent)
					addChild(elec);
				if (!energy.parent)
					addChild(energy);
				if (!budget.parent)
					addChild(budget);
				if (!ghg.parent)
					addChild(ghg);
				if (!oil.parent)
					addChild(oil);
			}
			else {
				if (heat.parent)
					removeChild(heat);
				if (fuel.parent)
					removeChild(fuel);
				if (elec.parent)
					removeChild(elec);
				if (energy.parent)
					removeChild(energy);
				if (budget.parent)
					removeChild(budget);
				if (ghg.parent)
					removeChild(ghg);
				if (oil.parent)
					removeChild(oil);
			}
		}
		
		private function removeComponents() {
//			displayComponents(false);
			plan.updatePlan();
			heat.updateUsage(true);
			fuel.updateUsage(true);
			elec.updateUsage(true);
			energy.updateUsage(true);
			ghg.updateUsage(true);
			oil.updateUsage(true);
			if (budget.parent)
				removeChild(budget);
			if (objInfo.parent)
				removeChild(objInfo);
		}
		
		private function displayActualInfo(display:Boolean) {
			if (display) {
				actualInfo = new EnergyInfoActual(data, OBJ_INFO_X, OBJ_INFO_Y);
				addChild(actualInfo);
			}
			else {
				if (actualInfo && actualInfo.parent)
				  removeChild(actualInfo);
			}
		}
		
		private function displayYouWinMC(display:Boolean) {
			if (!youWinMC) {
				youWinMC = new YouWinMC();
				youWinMC.x = YOU_WIN_X;
				youWinMC.y = YOU_WIN_Y;
			}
			if (display) {
				if (!youWinMC.parent)
				  addChild(youWinMC);
			}
			else {
				if (youWinMC.parent)
				  removeChild(youWinMC);
			}
		}
		
		private function removeChildren():void {
			if (numChildren <= 0) { return; }
			for (var i:int = numChildren - 1; i >= 0; i--) {
				removeChildAt(i);
			}
		}
  }
}