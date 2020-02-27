// The code in this tab is used to create all the other
// controls needed to configure the slider control.

GToggleGroup tg = new GToggleGroup();

GSlider Bright, TestSpd, AD;
GButton analogChk;
//GKnob knbAngle;
//GButton btnMakeCode;
//GButton[] btnColours = new GButton[8];
private final int NumberOfTICKS=6;
public void makeSliderConfigControls() {
  // Create colour scheme selectors
  int x = width - 42, y = 2;
  /*for (int i = 0; i < btnColours.length; i++) {
    btnColours[i] = new GButton(this, x, y + i * 20, 40, 18, "" + (i+1));
    btnColours[i].tag = "Button: " + (i+1);
    btnColours[i].setLocalColorScheme(i);
    btnColours[i].tagNo = 1000+i;
  } */ 
  // Create sliders
  

  
  /////////
  
  
  //    x= width-200;
  //y= 65;
  //AD = new GSlider(this, x, y, 70, 50, 30);
  //AD.setLocalColorScheme(3,true);
  //AD.setLimits(0, 0, 1);
  //AD.setEasing(5);
  //AD.setShowValue(false);
  //AD.setShowTicks(false);
  //AD.setShowLimits(false);
  //AD.setNbrTicks(2);  
  //AD.setStickToTicks(true);
  //AD.setShowDecor(false,false,false,false);
  
  
    x= width-280;
  y= 50;
  analogChk = new GButton(this, x+150, y -20, 100, 100, "check");
  
}
