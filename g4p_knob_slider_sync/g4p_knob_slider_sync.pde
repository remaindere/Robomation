import g4p_controls.*;

GKnob Knob;
GCustomSlider slider;

public void setup(){
  size(800,800,JAVA2D);
  
  Knob = new GKnob(this,125,125,250,250,0.8f);
  Knob.setTurnMode(G4P.CTRL_HORIZONTAL);
  //Knob.setTurnMode(G4P.CTRL_VERTICAL);
  //Knob.setTurnMode(G4P.CTRL_ANGULAR);
  //Knob.setTurnRange(120,420);
  Knob.setValue(0.4);
  Knob.setEasing(5.0);
  Knob.setSensitivity(2.0);
  
  slider = new GCustomSlider(this, 125, 500, 280, 50, null);
  slider.setShowDecor(false, false, true, false);
  slider.setLimits(0.0, 1.0);
}

public void draw(){
  float knob_val = Knob.getValueF();
  
  background(255);
  
  fill(0);
  textSize(20);
  text("Knob_val :"+knob_val,150,400);
  
  Knob.setValue(slider.getValueF());
}

//public void handleKnobEvents(GValueControl knob, GEvent event){
  
//}

//public void handleSliderEvents(GValueControl slider, GEvent event){
  
//}
