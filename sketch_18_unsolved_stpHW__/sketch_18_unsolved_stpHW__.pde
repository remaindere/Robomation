import g4p_controls.*;

Cheese cheese;
GCScheme GCScheme;
GImageToggleButton mdc_ab, mdc_cd, mdc_dc, mdc_srv, srv_auto, stp_hs;
GCustomSlider mab_slider, mcd_slider, dc_slider, srv_slider, stp_slider;
GToggleGroup stp_opt;
GOption stp_wave, stp_full, stp_half, stp_off;
GButton buz_off, buz_happy, buz_angry, buz_sad, buz_sleep, buz_toy, buz_birthday;

boolean updown = true;
int srv_degree = 0;

public void setup(){
  size(600, 700, JAVA2D);
  
  cheese = new Cheese(this);
  
  GCScheme.makeColorSchemes();
  GCScheme.changePaletteColor(8,3,color(0,0));
  GCScheme.savePalettes(this);

  G4P.setGlobalColorScheme(8); // black
  g4pControlSet();
}


public void draw(){
  background(255);
  
  stroke(5);
  strokeWeight(2);
  line(0,100, 600,100);
  line(0,400, 600,400);
  line(300,100, 300,900);
  
  textAlign(CENTER, CENTER);
  fill(5);
  
  /////////////////////////title///////////////////////////
  textSize(30);
  text("Config M Port Tester", 300, 50);
  
  /////////////////////////sub titles///////////////////////////
  textSize(20);
  text("M & DC Tests", 150, 125);
  text("Servo Motor", 450, 125);
  text("Stpping Motor", 150, 425);
  text("Buzz", 450, 425);
  
  /////////////////////////details-M & DC///////////////////////////
  textSize(16);
  
  text("M_ab", 65, 240);
  if(mdc_ab.getState() == 0){ // toggle - off state
    mab_slider.setVisible(false);
  }
  else{
    mab_slider.setVisible(true);
    text(int((mab_slider.getValueF()*10)), 130, 270);
  }
  
  text("M_cd", 190, 240);
  if(mdc_cd.getState() == 0){
    mcd_slider.setVisible(false);
  }
  else{
    mcd_slider.setVisible(true);
    text(int((mcd_slider.getValueF()*10)), 255, 270);
  }
    
  text("DC", 130, 360);
  if(mdc_dc.getState() == 0){
    dc_slider.setVisible(false);
  }
  else{
    dc_slider.setVisible(true);
    text(int((dc_slider.getValueF()-0.5)*200), 225, 320);
  }
  
  /////////////////////////details-servo///////////////////////////
  textSize(20);
  text("Auto", 400, 280);
  text(int(srv_slider.getValueF()*180)+"\nDegrees", 540, 250);
  if(mdc_ab.getState() != 0 || mdc_cd.getState() != 0 || mdc_dc.getState() != 0){
    pushStyle(); fill(200, 0, 0); text("Please disable \n ANY toggles in M & DC Tests", 450, 350);  popStyle();
    srv_slider.setValue(0);
  }
  
  /////////////////////////details-stppin///////////////////////////
  pushStyle();
  noFill();
  strokeWeight(1);
  rect(160, 475, 40, 20);
  popStyle();
  
  textSize(16);
  text("HW/SW", 180, 460);
  
  if(stp_hs.getState() == 0){
    text("SW", 180, 482.5);
    text("HALF", 180, 620);
    text("WAVE", 180, 520);
    text("FULL", 180, 570);
    text(int(stp_slider.getValueF()*500)+"PPS", 250, 670);
    pushStyle(); fill(200, 0, 0); text("NONE", 180, 670); popStyle();
    stp_half.setVisible(true);
    stp_full.setVisible(true);
    stp_wave.setVisible(true);
    stp_off.setVisible(true);
    stp_slider.setVisible(true);
  }
  else{
    text("HW", 180, 482.5);
    pushStyle(); fill(200, 0, 0); text("HW: Under Construction", 150, 520); popStyle();
    stp_half.setVisible(false);
    stp_full.setVisible(false);
    stp_wave.setVisible(false);
    stp_off.setVisible(false);
    stp_slider.setVisible(false);
  }
  
  /////////////////////////details-buz/////////////////////////////
  textSize(16);
  text("SOUND OFF", 450, 470);
  text("Happy", 375, 530);
  text("Angry", 525, 530);
  text("Sad", 375, 590);
  text("Sleep", 525, 590);
  text("Toy", 375, 650);
  text("Birthday", 525, 650);
  
  //////////////////////////////////////////////////////////////////
}

public void loop(){
  ////////////OFF, there are no enabled toggle SW ////////////
  cheese.configM(NORMAL_MODE, 0, 0);
  // step motor cannot be disabled by setting pps by 0; changing mod is needed.
  cheese.outMab = 0;
  cheese.outMcd = 0;

  /////////////////////////////M & DC test///////////////////////////
  if(mdc_ab.getState() == 1){
    cheese.outMab = int(mab_slider.getValueF()*100);
  }
  
  if(mdc_cd.getState() == 1){
    cheese.outMcd = int(mcd_slider.getValueF()*100);
  }
  
  if(mdc_dc.getState() == 1){
    cheese.configM(NORMAL_MODE, 1, 1);
    cheese.outMab = int(((dc_slider.getValueF()-0.5)*200));
  }
  
  /////////////////////////////servo moter//////////////////////////
  if(srv_auto.getState() == 1){// auto state
    cheese.configM(MONO_SERVO_MODE,0);
    cheese.outMab = srv_degree;
    
    if(updown) srv_degree+=5;     
    else srv_degree-=5;
    
    if(srv_degree==180 || srv_degree==0) updown = !updown;
  }
  
  else if(srv_auto.getState() == 0 && srv_slider.getValueF() != 0 && mdc_ab.getState() == 0 && mdc_cd.getState() == 0 && mdc_dc.getState() == 0){ // manual state(slider)
    float degree = (srv_slider.getValueF()*180);
    cheese.configM(MONO_SERVO_MODE,0);
    cheese.outMab = (int)degree;
  }
  /////////////////////////stepping moter///////////////////////////
  if(stp_off.isSelected()){ // off
    stp_slider.setValue(0);
    cheese.pps = stp_slider.getValueI();
  }
  
  if(stp_hs.getState() == 0){ // sw state
    if(stp_wave.isSelected()){
      cheese.configM(STEP_MOTOR_SW_MODE,1);
      cheese.pps = int(stp_slider.getValueF()*500);
    }
    else if(stp_full.isSelected()){
      cheese.configM(STEP_MOTOR_SW_MODE,2);
      cheese.pps = int(stp_slider.getValueF()*500);
    }
    else if(stp_half.isSelected()){
      cheese.configM(STEP_MOTOR_SW_MODE,3);
      cheese.pps = int(stp_slider.getValueF()*500);
    }
  }
  else{ // hw state    
    if(stp_wave.isSelected()){
      cheese.configM(STEP_MOTOR_HW_MODE, 1);
      cheese.outMab=2;
      cheese.outMcd=0;
    }
    else if(stp_full.isSelected()){
      cheese.configM(STEP_MOTOR_HW_MODE, 2);
      cheese.outMab=2;
      cheese.outMcd=0;
    }
  }
  
  ////////////////////BUZZ events is in handleButtonEvents//////////////
  
  //
}

public void handleButtonEvents(GButton button, GEvent event){
  if(button == buz_off){
    cheese.setSoundClip(0);
    return;
  }
  
  cheese.configM(NORMAL_MODE, 0, OFF_COILS);
  
  delay(20);
  if(button == buz_happy){
    cheese.setSoundClip(HAPPY_SONG);
  }
  else if(button == buz_angry){
    cheese.setSoundClip(ANGRY_SONG);
  }
  else if(button == buz_sad){
    cheese.setSoundClip(SAD_SONG);
  }
  else if(button == buz_sleep){
    cheese.setSoundClip(SLEEP_SONG);
  }
  else if(button == buz_toy){
    cheese.setSoundClip(TOY_SONG);
  }
  else if(button == buz_birthday){
    cheese.setSoundClip(BIRTHDAY_SONG);
  }
}

public void g4pControlSet(){
  mdc_ab = new GImageToggleButton(this, 45, 180);
  mdc_cd = new GImageToggleButton(this, 170, 180);
  mdc_dc = new GImageToggleButton(this, 110, 300);
  mab_slider = new GCustomSlider(this,125,255, 100,10);
  mab_slider.setRotation(-PI/2);
  mab_slider.setValue(0);
  mcd_slider = new GCustomSlider(this,250,255, 100,10);
  mcd_slider.setRotation(-PI/2);
  mcd_slider.setValue(0);
  dc_slider = new GCustomSlider(this,185,375, 100,10);
  dc_slider.setRotation(-PI/2);
  dc_slider.setValue(0.5);
  
  srv_auto = new GImageToggleButton(this, 380, 220);
  srv_slider = new GCustomSlider(this, 480, 325, 150, 10);
  srv_slider.setRotation(-PI/2);
  srv_slider.setValue(0);
  
  stp_hs = new GImageToggleButton(this, 87.5, 450);
  stp_wave = new GOption(this, 100, 515, 15, 15); 
  stp_full = new GOption(this, 100, 565, 15, 15); 
  stp_half = new GOption(this, 100, 615, 15, 15);
  stp_off = new GOption(this, 100, 665, 15, 15);
  stp_opt = new GToggleGroup();
  stp_opt.addControls(stp_wave, stp_full, stp_half, stp_off);
  stp_off.setSelected(true);//this statements must be located after ToggleGroup setting)
  stp_slider = new GCustomSlider(this, 245,650, 150,10);
  stp_slider.setRotation(-PI/2);
  stp_slider.setValue(0);
  
  buz_off = new GButton(this, 400,457.5, 100,30);
  buz_off.useRoundCorners(false);  
  buz_off.setLocalColor(4,color(255,0)); // background color_mouse off(4), color 255/ completely-transparent(0)
  buz_off.setLocalColor(6,color(192, 128)); // background color_mouse over
  buz_off.setLocalColor(14,color(128, 128)); // background color_mouse click-on
  
  buz_happy = new GButton(this, 335,517.5, 80,30);
  buz_happy.useRoundCorners(false);  
  buz_happy.setLocalColor(4,color(255,0));
  buz_happy.setLocalColor(6,color(192, 128)); 
  buz_happy.setLocalColor(14,color(128, 128));
  
  buz_angry = new GButton(this, 485,517.5, 80,30);
  buz_angry.useRoundCorners(false);
  buz_angry.setLocalColor(4,color(255,0));
  buz_angry.setLocalColor(6,color(192, 128)); 
  buz_angry.setLocalColor(14,color(128, 128));
  
  buz_sad = new GButton(this, 335,577.5, 80,30);
  buz_sad.useRoundCorners(false);
  buz_sad.setLocalColor(4,color(255,0));
  buz_sad.setLocalColor(6,color(192, 128)); 
  buz_sad.setLocalColor(14,color(128, 128));
  
  buz_sleep = new GButton(this, 485,577.5, 80,30);
  buz_sleep.useRoundCorners(false);
  buz_sleep.setLocalColor(4,color(255,0));
  buz_sleep.setLocalColor(6,color(192, 128)); 
  buz_sleep.setLocalColor(14,color(128, 128));
  
  buz_toy = new GButton(this, 335,637.5, 80,30);
  buz_toy.useRoundCorners(false);
  buz_toy.setLocalColor(4,color(255,0));
  buz_toy.setLocalColor(6,color(192, 128)); 
  buz_toy.setLocalColor(14,color(128, 128));
  
  buz_birthday = new GButton(this, 485,637.5, 80,30);
  buz_birthday.useRoundCorners(false);
  buz_birthday.setLocalColor(4,color(255,0));
  buz_birthday.setLocalColor(6,color(192, 128)); 
  buz_birthday.setLocalColor(14,color(128, 128));
}

// you can add events with these functions
// public void handleToggleButtonEvents(GImageToggleButton button, GEvent event)
// public void handleCustomSliderEvents(GCustomSlider slider, GEvent event)
// public void handleOptionEvents(GOption option, GEvent event)
