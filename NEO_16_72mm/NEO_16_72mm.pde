
Cheese cheese;
NEO_LED neo;

boolean init=true;
int curRange;

public void setup(){
  size(500, 500, JAVA2D);
  
  cheese = new Cheese(this);
  neo = new NEO_LED(cheese, NEO_MODE_5, NEO_CHIP_RGBW);
}


public void draw(){
  
}


public void loop(){
  if(init){
    neo.setBrightness(50);
    neo.setRange(0,15);
    neo.fill(0,0,0,0);
    neo.show(cheese);
    init = false;
  }
  else{
    if(curRange<=15) neo.setRange(curRange,curRange);
    else neo.setRange(curRange-16,curRange-16);
    switch(curRange){
      case 0:
        neo.fill(255,0,0,0);
        break;
      case 1:
        neo.fill(191,63,0,0);
        break;
      case 2:
        neo.fill(127,127,0,0);
        break;
      case 3:
        neo.fill(63,191,0,0);
        break;
      case 4:
        neo.fill(0,255,0,0);
        break;
      case 5:
        neo.fill(0,191,63,0);
        break;
      case 6:
        neo.fill(0,127,127,0);
        break;
      case 7:
        neo.fill(0,63,191,0);
        break;
      case 8:
        neo.fill(0,0,255,0);
        break;
      case 9:
        neo.fill(0,0,191,63);
        break;
      case 10:
        neo.fill(0,0,127,127);
        break;
      case 11:
        neo.fill(0,0,63,191);
        break;
      case 12:
        neo.fill(0,0,0,255);
        break;
      case 13:
        neo.fill(63,0,0,191);
        break;
      case 14:
        neo.fill(127,0,0,127);
        break;
      case 15:
        neo.fill(191,0,0,63);
        break;
      default:
        neo.fill(0,0,0,0);
        break;
    }
    neo.show(cheese);
    curRange++;
    if(curRange==32) curRange=0;
  }
}
