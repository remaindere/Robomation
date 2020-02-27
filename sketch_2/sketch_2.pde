import g4p_controls.*;

GKnob knob;
Cheese cheese;

float cheese_voltage=0;

public void setup() {
  size(500, 280, JAVA2D);

  cheese = new Cheese(this);  
  cheese.configSa(ANALOG_IN, ADC_VCC);

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
  text("Voltage:"+cheese_voltage+"/4V", 100, 200);

  textSize(20);
  if (cheese.powerState==0) text("Supply Voltage : Normal", 130, 230);
  else if (cheese.powerState==1) text("Supply Voltage : Low", 130, 230);
  else if (cheese.powerState==2) text("Supply Voltage : Very Low", 130, 230);
}

void Knob_Percentage_Print(float num) {
  float Pnum = num/255*100;
  knob.setValue(Pnum);
}


public void loop() 
{
  println("Supply Voltage : " + (cheese.battery/10-200));
  cheese_voltage = (float)cheese.inputSa*4/256;
}
