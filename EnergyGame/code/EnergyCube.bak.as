package code {

  import flash.display.*;
  import flash.text.*;
  import flash.geom.*;

  public class EnergyCube extends Sprite {

    const FRONT_TOP_Y_POSITION:int = 45;
		const EFFICIENCY_HEIGHT:int = 52;
		const ELECTRICITY_HEIGHT:int = 116;
		const HEAT_HEIGHT:int = 116;
		const VEHICLE_HEIGHT:int = 116;
		
    var data:EnergyData;
		var xPos:Number;
		var yPos:Number;
		var efficiencyContainer:Sprite = null;
		var electricityContainer:Sprite = null;
		var heatContainer:Sprite = null;
		var vehicleContainer:Sprite = null;
		var frontSiblings:int;

    public function EnergyCube(data:EnergyData,
															 x:Number,
															 y:Number) {
			this.data = data;
			xPos = x;
			yPos = y;
			frontSiblings = 0;
			
			drawTitle();
			drawCube();
			updateUsage();
    }

    function drawTitle():void {
			setupTextField(EnergyConsts.ENERGY_NAME, xPos + 20, yPos, 25, 16, true);
		}
		
		function setupTextField(name:String, x:Number, y:Number, h:Number, fontSize:Object, bold:Object=false) {
			var tf:TextField = new TextField();
			tf.text = name;
			tf.x = x;
			tf.y = y;
			tf.width = 66;
			tf.height = h;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = fontSize;
			format.bold = bold;
			format.font = "Arial";
			tf.setTextFormat(format);
			addChild(tf);
		}
		
    function drawCube():void {
			// width - 86, height 420 starting at 25 (for title), 20 x 20 for diagonal lines
			var line:Shape = new Shape();
			line.graphics.lineStyle(2, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			line.graphics.drawRect(xPos + 20, yPos + 25, 66, 400);
			line.graphics.moveTo(xPos, yPos + 445);
			line.graphics.lineTo(xPos + 20, yPos + 425);
			addChild(line);
			
			var mc:MovieClip = new EfficiencyMC();
			mc.x = xPos + 29;
			mc.y = yPos + 42;
			addChild(mc);
			frontSiblings++;
			
			mc = new ElectricityMC();
			mc.x = xPos + 25;
			mc.y = yPos + 112;
			addChild(mc);
			frontSiblings++;
			
			mc = new HeatMC();
			mc.x = xPos + 17;
			mc.y = yPos + 251;
			addChild(mc);
			frontSiblings++;
			
			mc = new VehicleMC();
			mc.x = xPos + 22;
			mc.y = yPos + 341;
			addChild(mc);
			frontSiblings++;
			
			line = new Shape();
			line.graphics.lineStyle(2, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			line.graphics.drawRect(xPos, yPos + FRONT_TOP_Y_POSITION, 66, 400);
			line.graphics.moveTo(xPos, yPos + FRONT_TOP_Y_POSITION);
			line.graphics.lineTo(xPos + 20, yPos + 25);
			line.graphics.moveTo(xPos + 66, yPos + FRONT_TOP_Y_POSITION);
			line.graphics.lineTo(xPos + 86, yPos + 25);
			line.graphics.moveTo(xPos + 66, yPos + 445);
			line.graphics.lineTo(xPos + 86, yPos + 425);
			addChild(line);
			frontSiblings++;
			
			setupTextField(EnergyConsts.VEHICLE_FUEL_NAME, xPos,
										 yPos + FRONT_TOP_Y_POSITION + EFFICIENCY_HEIGHT + ELECTRICITY_HEIGHT + HEAT_HEIGHT + VEHICLE_HEIGHT - 15,
										 15, 9);
			frontSiblings++;
			setupTextField(EnergyConsts.HEAT_NAME, xPos,
										 yPos + FRONT_TOP_Y_POSITION + EFFICIENCY_HEIGHT + ELECTRICITY_HEIGHT + HEAT_HEIGHT - 15,
										 15, 9);
			frontSiblings++;
			setupTextField(EnergyConsts.ELECTRICITY_NAME, xPos,
										 yPos + FRONT_TOP_Y_POSITION + EFFICIENCY_HEIGHT + ELECTRICITY_HEIGHT - 15,
										 15, 9);
			frontSiblings++;
			setupTextField(EnergyConsts.EFFICIENCY_NAME, xPos,
										 yPos + FRONT_TOP_Y_POSITION + EFFICIENCY_HEIGHT - 15,
										 15, 9);
			frontSiblings++;
		}
		
    public function updateUsage():void {
			clearSectorContainers();
			this.efficiencyContainer = new Sprite();
			this.electricityContainer = new Sprite();
			this.heatContainer = new Sprite();
			this.vehicleContainer = new Sprite();
			var effHeight:Number = 0;
			var eHeight:Number = 0;
			var hHeight:Number = 0;
			var vHeight:Number = 0;
			var dataItem:EnergyDataItem = this.data.currentDataItem;
			if (dataItem) {
				effHeight = Math.round(EFFICIENCY_HEIGHT * dataItem.efficiency / dataItem.efficiencyLimit);
				eHeight = Math.round(ELECTRICITY_HEIGHT * dataItem.electricity / dataItem.electricityLimit);
				hHeight = Math.round(HEAT_HEIGHT * dataItem.heat / dataItem.heatLimit);
				vHeight = Math.round(VEHICLE_HEIGHT * dataItem.vehicleFuel / dataItem.vehicleFuelLimit);
			}
			// the following update order is important;
			// it affects the index position of the container in the display list;
			updateSectorUsage(vehicleContainer, vHeight, 0x8ABDE5,
												yPos + FRONT_TOP_Y_POSITION + EFFICIENCY_HEIGHT + ELECTRICITY_HEIGHT + HEAT_HEIGHT + VEHICLE_HEIGHT - vHeight);
			updateSectorUsage(heatContainer, hHeight, 0xE25B64,
												yPos + FRONT_TOP_Y_POSITION + EFFICIENCY_HEIGHT + ELECTRICITY_HEIGHT + HEAT_HEIGHT - hHeight);
			updateSectorUsage(electricityContainer, eHeight, 0xFEF05A,
												yPos + FRONT_TOP_Y_POSITION + EFFICIENCY_HEIGHT + ELECTRICITY_HEIGHT - eHeight);
			updateSectorUsage(efficiencyContainer, effHeight, 0xAECE7A,
												yPos + FRONT_TOP_Y_POSITION + EFFICIENCY_HEIGHT - effHeight);
		}
		
		function updateSectorUsage(container:Sprite, cubeHeight:Number, color:uint, yBase:Number) {
			var box:Shape;
			if (cubeHeight > 1.0) {
				box = new Shape();
				box.graphics.lineStyle(2, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
				box.graphics.beginFill(color);
				box.graphics.drawRect(xPos, yBase, 66, cubeHeight);
				box.graphics.moveTo(xPos + 66, yBase);
				box.graphics.lineTo(xPos + 66, yBase + cubeHeight);
				box.graphics.lineTo(xPos + 86, yBase + cubeHeight - 20);
				box.graphics.lineTo(xPos + 86, yBase - 20);
				box.graphics.lineTo(xPos + 66, yBase);
				box.graphics.endFill();
				container.addChild(box);
			}
			box = new Shape();
			box.graphics.lineStyle(2, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			box.graphics.beginFill(color);
			box.graphics.moveTo(xPos, yBase);
			box.graphics.lineTo(xPos + 66, yBase);
			box.graphics.lineTo(xPos + 86, yBase - 20);
			box.graphics.lineTo(xPos + 20, yBase - 20);
			box.graphics.lineTo(xPos, yBase);
			box.graphics.endFill();
			container.addChild(box);
			addChildAt(container, numChildren - frontSiblings);
		}
		
		function clearSectorContainers():void {
		  if (efficiencyContainer && efficiencyContainer.parent) {
				removeChild(efficiencyContainer);
			}
			if (electricityContainer && electricityContainer.parent) {
				removeChild(electricityContainer);
			}
			if (heatContainer && heatContainer.parent) {
				removeChild(heatContainer);
			}
			if (vehicleContainer && vehicleContainer.parent) {
				removeChild(vehicleContainer);
			}
		}
  }
}