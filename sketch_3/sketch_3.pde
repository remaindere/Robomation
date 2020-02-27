
import g4p_controls.*;

Cheese cheese;
GKnob knob;

//cheese stick - to use internal values on draw
float cheese_voltage = 0;

public void setup() {
  size(500, 280, JAVA2D);

  cheese = new Cheese(this);
  cheese.configSa(ANALOG_IN, ADC_BGV);

  knob = new GKnob(this, 170, 15, 150, 150, 0.8f);
  knob.setLimits(0,100);
}

public void draw() {
  background(255);
  fill(0);

  stroke(128);
  strokeWeight(1.5);

  Knob_Percentage_Print(cheese.inputSa);  

  textSize(30);
  text("Voltage:"+cheese_voltage+"/3.6V", 120, 200);

  textSize(20);
  if (cheese.powerState==0) text("Supply Voltage : Normal", 130, 230);
  else if (cheese.powerState==1) text("Supply Voltage : Low", 130, 230);
  else if (cheese.powerState==2) text("Supply Voltage : Very Low", 130, 230);
}

public void loop() 
{
  double i;

  println("Supply Voltage : " + (cheese.battery/10-200));  
  i = Math.floor((cheese.inputSa*3.6/256*100))/100;
  cheese_voltage = (float)i;
}

void Knob_Percentage_Print(float num) {
  float Pnum = num/255*100;
  knob.setValue(Pnum);
}
