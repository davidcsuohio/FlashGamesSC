package code {

  import flash.display.*;
  import flash.text.*;
  import flash.geom.*;
	import flash.events.*;

  public class EnergyPlan extends EnergyViewBase {

		// size 104x410; title height: 25; sub-title height: 20; text height: 15;
		private const PLAN_WIDTH:int = 106;
		private const TITLE_HEIGHT:int = 22;
		private const SUB_TITLE_HEIGHT:int = 20;
		private const TEXT_HEIGHT:int = 16;
		// these sector_y_bases do not include the sub-title heights;
		private const VEHICLE_SECTOR_Y_BASE:int = TITLE_HEIGHT + SUB_TITLE_HEIGHT;
		private const ELEC_SECTOR_Y_BASE:int = VEHICLE_SECTOR_Y_BASE + 5 * TEXT_HEIGHT + 4 + SUB_TITLE_HEIGHT;
		private const HEAT_SECTOR_Y_BASE:int = ELEC_SECTOR_Y_BASE + 12 * TEXT_HEIGHT + 4 + SUB_TITLE_HEIGHT;
		private const EFFIC_SECTOR_Y_BASE:int = HEAT_SECTOR_Y_BASE + 6 * TEXT_HEIGHT + 4 + SUB_TITLE_HEIGHT;
		// 4 * sub-title + 4 (line under sub-title) + text * (5 + 12 + 6 + 1);
		// max source # of each sector: 5 (V) + 12 (E) + 6 (H) + 1 (EFFIC);
		// it does not include the title height; adjustment 4 compensating for the bold outline
		private const PLAN_HEIGHT:int = EFFIC_SECTOR_Y_BASE + 1 * TEXT_HEIGHT + 4 - TITLE_HEIGHT;
		
    private var data:EnergyData;
		private var xPos:Number;
		private var yPos:Number;
		private var sourcesContainer:Sprite;

    public function EnergyPlan(data:EnergyData, x:Number, y:Number) {
			this.data = data;
			xPos = x;
			yPos = y;
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			setupStaticContents();
			updatePlan();
    }
		
		public function updatePlan() {
			// display sources' values if they are greater than 0;
			var dataItem:EnergyDataItem = this.data.currentDataItem;
			if (!dataItem) { return; }
			clearSourcesContainer();
			sourcesContainer = new Sprite();
			updateSector(dataItem.vehicleFuelSector, yPos + VEHICLE_SECTOR_Y_BASE);
			updateSector(dataItem.electricitySector, yPos + ELEC_SECTOR_Y_BASE);
			updateSector(dataItem.heatSector, yPos + HEAT_SECTOR_Y_BASE);
			updateSector(dataItem.efficiencySector, yPos + EFFIC_SECTOR_Y_BASE);
			addChild(sourcesContainer);
		}

    private function setupStaticContents():void {
			setupTextField2(EnergyConsts.PLAN_NAME, xPos, yPos, PLAN_WIDTH, TITLE_HEIGHT, 16);
			var box:Shape = new Shape();
			box.graphics.lineStyle(2, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			box.graphics.beginFill(EnergyConsts.PLAN_BACKGROUND_COLOR);
			box.graphics.drawRect(xPos, yPos + TITLE_HEIGHT, PLAN_WIDTH, PLAN_HEIGHT);
			box.graphics.endFill();
			box.graphics.lineStyle(2, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			box.graphics.moveTo(xPos, yPos + ELEC_SECTOR_Y_BASE - SUB_TITLE_HEIGHT);
			box.graphics.lineTo(xPos + PLAN_WIDTH, yPos + ELEC_SECTOR_Y_BASE - SUB_TITLE_HEIGHT);
			box.graphics.moveTo(xPos, yPos + HEAT_SECTOR_Y_BASE - SUB_TITLE_HEIGHT);
			box.graphics.lineTo(xPos + PLAN_WIDTH, yPos + HEAT_SECTOR_Y_BASE - SUB_TITLE_HEIGHT);
			box.graphics.moveTo(xPos, yPos + EFFIC_SECTOR_Y_BASE - SUB_TITLE_HEIGHT);
			box.graphics.lineTo(xPos + PLAN_WIDTH, yPos + EFFIC_SECTOR_Y_BASE - SUB_TITLE_HEIGHT);
			box.graphics.lineStyle(1, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			box.graphics.moveTo(xPos, yPos + VEHICLE_SECTOR_Y_BASE - 2);
			box.graphics.lineTo(xPos + PLAN_WIDTH, yPos + VEHICLE_SECTOR_Y_BASE - 2);
			box.graphics.moveTo(xPos, yPos + ELEC_SECTOR_Y_BASE - 2);
			box.graphics.lineTo(xPos + PLAN_WIDTH, yPos + ELEC_SECTOR_Y_BASE - 2);
			box.graphics.moveTo(xPos, yPos + HEAT_SECTOR_Y_BASE - 2);
			box.graphics.lineTo(xPos + PLAN_WIDTH, yPos + HEAT_SECTOR_Y_BASE - 2);
			box.graphics.moveTo(xPos, yPos + EFFIC_SECTOR_Y_BASE - 2);
			box.graphics.lineTo(xPos + PLAN_WIDTH, yPos + EFFIC_SECTOR_Y_BASE - 2);
			addChild(box);
			setupTextField2(EnergyConsts.VEHICLE_FUEL_NAME, xPos, yPos + VEHICLE_SECTOR_Y_BASE - SUB_TITLE_HEIGHT + 1, PLAN_WIDTH, SUB_TITLE_HEIGHT, 11);
			setupTextField2(EnergyConsts.ELECTRICITY_NAME, xPos, yPos + ELEC_SECTOR_Y_BASE - SUB_TITLE_HEIGHT + 1, PLAN_WIDTH, SUB_TITLE_HEIGHT, 11);
			setupTextField2(EnergyConsts.HEAT_NAME, xPos, yPos + HEAT_SECTOR_Y_BASE - SUB_TITLE_HEIGHT + 1, PLAN_WIDTH, SUB_TITLE_HEIGHT, 11);
			setupTextField2(EnergyConsts.EFFICIENCY_NAME, xPos, yPos + EFFIC_SECTOR_Y_BASE - SUB_TITLE_HEIGHT + 1, PLAN_WIDTH, SUB_TITLE_HEIGHT, 11);
		}
		
		private function updateSector(sector:EnergyDataSector, yBase:Number) {
			var sources:Vector.<EnergyDataElement> = sector.getNonZeroValueSources();
			for (var i:uint = 0; i < sources.length; i++) {
				setupTextField3(sources[i].name, sources[i].value, xPos, yBase + TEXT_HEIGHT * i, TEXT_HEIGHT);
			}
		}
		
		private function setupTextField3(name:String, val:Number, x:Number, y:Number, h:Number) {
			var tf:TextField = new TextField();
			tf.text = name + " - " + String(val);
			tf.x = x;
			tf.y = y;
			tf.width = PLAN_WIDTH;
			tf.height = h;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.LEFT;
			format.size = 10;
			format.bold = true;
			format.font = "Arial";
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
			truncate(tf);
			sourcesContainer.addChild(tf);
			return tf;
		}
		
		private function clearSourcesContainer():void {
			if (sourcesContainer && sourcesContainer.parent) {
				removeChild(sourcesContainer);
			}
		}
		
		private function truncate(tf:TextField, ellipsis:String="\u2026"):void {
			if (tf.textWidth <= PLAN_WIDTH)
			  return; 
			var tmpTF:TextField = copyTextField(tf);
			var firstPart:String;
			var idx:int = tmpTF.text.search(" ");
			var secondPart:String = tmpTF.text.substr(idx);
			tmpTF.appendText(ellipsis);
			// truncate the end of the first word excluding the out-of-the-first-word case;
			while (tmpTF.textWidth > PLAN_WIDTH - 2) {
				idx = tmpTF.text.search(" ");
				if (idx <= 0)
				  break;
				firstPart = tmpTF.text.substr(0, idx - 1);
				tmpTF.text = firstPart + secondPart + ellipsis;
			}
			if (idx > 0)
			  tf.text = firstPart + ellipsis + secondPart;
		}
		
		function copyTextField(original:TextField):TextField {
			var copy:TextField = new TextField();
			copy.width = original.width;
			copy.height = original.height;
			copy.multiline = original.multiline;
			copy.wordWrap = original.wordWrap;
			copy.embedFonts = original.embedFonts;
			copy.antiAliasType = original.antiAliasType;
			copy.autoSize = original.autoSize;
			copy.defaultTextFormat = original.getTextFormat();
			copy.text = original.text;
			return copy;
		}
  }
}