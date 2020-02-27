public static final int defaultX=90, defaultY=90;
public static final int JOY_DEFAULT=0;
public static final int JOY_FORWARD=1; 
public static final int JOY_UPPERRIGHT=2;
public static final int JOY_RIGHT=3;
public static final int JOY_LOWERRIGHT=4;
public static final int JOY_BACKWARD=5;
public static final int JOY_LOWERLEFT=6;
public static final int JOY_LEFT=7;
public static final int JOY_UPPERLEFT=8;
int sound_flag_A=0, sound_flag_B=0;
int sound_flag_=0;
int status_flag=0;
int debounce_flag=0;
int start_flag=1, cheese_flag=0, conv_flag=0;
int btn_R_flag, btn_L_flag=0, toggle_flag=0, LED_COLOR=0x07;
char color_flag=0x00;
String str_table[] = {"BLACK", "RED", "GREEN", "BLUE", "YELLOW", "CYAN", "MAGENTA", "WHITE", "None"};
int color_index =0;

void joyUI()
{

  fill(200);
  noStroke();
  image(joy, defaultX-47, defaultY+30, 220, 220);
  ellipse(defaultX+(pid13.x/2), defaultY+(200-pid13.y/2), 100, 100);

  /////
  image(btn_a, defaultX+350, defaultY+110, 100, 100);
  image(btn_b, defaultX+250, defaultY+80, 100, 100);
  fill(100, 100);


  if (pid13.A) {
    cs.setSoundClip(BEEP);
    ellipse(defaultX+400, defaultY+160, 85, 85);
  } else if (pid13.B) {
    cs.setSoundClip(BEEP);    
    ellipse(defaultX+300, defaultY+130, 85, 85);
  } else {
    cs.setSoundClip(MUTE);    
  }




  /////
  //status detection
  LED_test();

  if (pid13.x>220 && pid13.y>220 ) {
    status_flag=JOY_UPPERRIGHT;
  } //UPPERRIGHT
  else if (pid13.x<20 && pid13.y>220) {
    status_flag=JOY_UPPERLEFT;
  } //UPPERLEFT 
  else if (pid13.y>220) {
    status_flag=JOY_FORWARD;
  } // FORWARD
  else if (pid13.x>220 && pid13.y<20) {
    status_flag=JOY_LOWERRIGHT;
  }//LOWERRIGHT
  else if (pid13.x>220) {
    status_flag=JOY_RIGHT;
  }//RIGHT
  else if (pid13.x<20 && pid13.y<20) {
    status_flag=JOY_LOWERLEFT;
  } //LOWERLEFT
  else if (pid13.x<20) {
    status_flag=JOY_LEFT;
  } //LEFT
  else if (pid13.y<20) {
    status_flag=JOY_BACKWARD;
  } //BACKWARD
  else {
    status_flag=JOY_DEFAULT;
  }//default
  /////

  arrow(status_flag, LED_COLOR);

  /////
  fill(0);
  stroke(0);
}

void LED_test()
{

  if ((pid13.A)) {
    if (debounce_flag==1) {
      if (btn_L_flag==1) {

        toggle_flag++;
        toggle_flag%=5;
        switch(toggle_flag) {
        case 0 :
          LED_COLOR=0x00;
          break;
        case 1 :            
          LED_COLOR=0x01;
          break;
        case 2 :            
          LED_COLOR=0x02;
          break;
        case 3 :            
          LED_COLOR=0x04;
          break;
        case 4 :            
          LED_COLOR=0x07;
          break;
        }
        btn_L_flag=0;
      }
    }
  } else btn_L_flag=1;

  if ((pid13.B)) {
    if (debounce_flag==1) {
      if (btn_R_flag==1) {
        toggle_flag++;
        toggle_flag%=5;
        switch(toggle_flag) {
        case 0 :
          LED_COLOR=0x00;
          break;
        case 1 :            
          LED_COLOR=0x01;
          break;
        case 2 :            
          LED_COLOR=0x02;
          break;
        case 3 :            
          LED_COLOR=0x04;
          break;
        case 4 :            
          LED_COLOR=0x07;
          break;
        }        
        btn_R_flag=0;
      }
    }
  } else btn_R_flag=1;

  if (toggle_flag!=0) color_flag=0x80;
  else color_flag=0x01;
  debounce_flag=1;

  ////////////////////////////////
}
public void allClear()
{

  for (int i=0; i<5; i++)for (int j=0; j<5; j++)hat.led[i][j]=BLACK;
}
public void arrow(int status, int clr)
{
  allClear();
  switch(status) {
  case JOY_FORWARD:
    for (int i=0; i<5; i++)if (i==2)hat.led[i][0]=clr;
    for (int i=0; i<5; i++)if (i!=0)hat.led[i][1]=clr;
    for (int i=0; i<5; i++)if (true)hat.led[i][2]=clr;
    for (int i=0; i<5; i++)if (i!=0)hat.led[i][3]=clr;
    for (int i=0; i<5; i++)if (i==2)hat.led[i][4]=clr;
    break;
  case JOY_UPPERRIGHT:
    for (int i=0; i<5; i++)if (i==3)hat.led[i][0]=clr;
    for (int i=0; i<5; i++)if (i!=1)hat.led[i][1]=clr;
    for (int i=0; i<5; i++)if (i!=4)hat.led[i][2]=clr;
    for (int i=0; i<5; i++)if (i!=4&& i!=3)hat.led[i][3]=clr;
    for (int i=0; i<5; i++)if (i !=4)hat.led[i][4]=clr;
    break;  
  case JOY_RIGHT:
    for (int i=0; i<5; i++)if (i != 0 && i != 4)hat.led[i][0]=clr;
    for (int i=0; i<5; i++)if (i != 0 && i != 4)hat.led[i][1]=clr;
    for (int i=0; i<5; i++)if (true)hat.led[i][2]=clr;
    for (int i=0; i<5; i++)if (i != 0 && i != 4)hat.led[i][3]=clr;
    for (int i=0; i<5; i++)if (i==2)hat.led[i][4]=clr;
    break;
  case JOY_LOWERRIGHT:
    for (int i=0; i<5; i++)if (i==1)hat.led[i][0]=clr;
    for (int i=0; i<5; i++)if (i != 3 )hat.led[i][1]=clr;
    for (int i=0; i<5; i++)if (i!=0)hat.led[i][2]=clr;
    for (int i=0; i<5; i++)if (i != 0 && i != 1)hat.led[i][3]=clr;
    for (int i=0; i<5; i++)if (i!=0)hat.led[i][4]=clr;
    break;
  case JOY_BACKWARD:
    for (int i=0; i<5; i++)if (i==2)hat.led[i][0]=clr;
    for (int i=0; i<5; i++)if (i!=4)hat.led[i][1]=clr;
    for (int i=0; i<5; i++)if (true)hat.led[i][2]=clr;
    for (int i=0; i<5; i++)if (i!=4)hat.led[i][3]=clr;
    for (int i=0; i<5; i++)if (i==2)hat.led[i][4]=clr;
    break;
  case JOY_LOWERLEFT:
    for (int i=0; i<5; i++)if (i!=0)hat.led[i][0]=clr;
    for (int i=0; i<5; i++)if (i != 0 && i!=1 )hat.led[i][1]=clr;
    for (int i=0; i<5; i++)if (i!=0)hat.led[i][2]=clr;
    for (int i=0; i<5; i++)if (i != 3 )hat.led[i][3]=clr;
    for (int i=0; i<5; i++)if (i==1)hat.led[i][4]=clr;
    break;
  case JOY_LEFT:
    for (int i=0; i<5; i++)if (i==2)hat.led[i][0]=clr;
    for (int i=0; i<5; i++)if (i != 0 && i != 4)hat.led[i][1]=clr;
    for (int i=0; i<5; i++)if (true)hat.led[i][2]=clr;
    for (int i=0; i<5; i++)if (i != 0 && i != 4)hat.led[i][3]=clr;
    for (int i=0; i<5; i++)if (i != 0 && i != 4)hat.led[i][4]=clr;
    break;
  case JOY_UPPERLEFT:
    for (int i=0; i<5; i++)if (i!=4)hat.led[i][0]=clr;
    for (int i=0; i<5; i++)if (i != 3 && i!=4 )hat.led[i][1]=clr;
    for (int i=0; i<5; i++)if (i!=4)hat.led[i][2]=clr;
    for (int i=0; i<5; i++)if (i != 1 )hat.led[i][3]=clr;
    for (int i=0; i<5; i++)if (i==3)hat.led[i][4]=clr;
    break;
  default:  
    for (int i=0; i<5; i++)if (i == 2 )hat.led[i][2]=clr;
    break;
  }
}
