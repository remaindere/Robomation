Cheese cs;
PID_15 pid15;
PFont myfont;
int dataSav;
String [] funcName = {null};
public void settings(){
  size(450, 370, JAVA2D);
}

int [] data = new int [2] ;
public void setup()
{
  cs = new Cheese(this);
  //rx test : parameter->1
  myfont = createFont("맑은 고딕",16);  
  pid15 = new PID_15(cs,1); //[(cs,1) == La핀을 Rx], [(cs,0)== La 핀을 Tx]
  fill(0);
  cs.setSoundClip(BEEP);
  textFont(myfont);
}

public void draw()
{
  background(235,235,255);
  LED_ON();
 
  strokeWeight(3);
  fill(0);
  stroke(0);
  line(0,50,width,50);
  strokeWeight(1);
  line(0,120,width,120);
  line(0,290,width,290);
  textAlign(CENTER, CENTER);
  textSize(40);
  
  text("Infrared sensor_RX", width/2,20);
  
//

  //Rx 신호를 받기 전, Address코드로 Tx 장치 판별을 해주어야 함.
  /*
    EX)
    Tx장치에서 보내는 신호의 Address code가 0x5A인 경우,
    
    Rx : 
    address code = 0x5A -> 받아오고자 하는 Tx 장치이다. 허용
    address code = 0x36 -> 받아오고자 하는 장치가 아니다. 비허용
    
  */
  
  //Rx 신호 중, 데이터 부분에 대해 Tx부와 규약이 되어 있어야 함.
  /*
    EX)
    (Rx신호의 Address 데이터가 일치할 경우)
    data code = 0x01 -> 부저울리기
    data code = 0x02 -> HAT-010 RGBLED 켜기(HAT010이 등록되었을 경우 ) 
    data code = 0x09 -> PWM신호를 50%로 정하기  
    등등... 
    정하기 나름이며, 우선 규약을 하기 전 틀을 만들어주면 좋을 것 같습니다.
  */
  textSize(25);

  textAlign(RIGHT, CENTER);
  text("Status : ",120,80);
  
  text("Length : ",120,150);
  text("Address : ",120,200);
  text("Data : ",120, 250);
  text("Action : ",120,320);
  
  textSize(20);
  text("_Inverted : ",350,202);
  text("_Inverted : ",350,252);
  
  textAlign(LEFT, CENTER);
  if(pid15.rxId == 0){
    textSize(25);
    text("Detecting. . .",120,80);
    textSize(20);
    text("NULL",120,152);
    text("NULL",120,202);
    text("NULL",350,202);
    text("NULL",120,252);
    text("NULL",350,252);
    text("NULL",120,322);
  }
  
  else{
    pushStyle();
    fill(230,0,0);
    textSize(25);
    text("Data Received",120,80);
    popStyle();
    text(pid15.rxLength,120,152);
    //Address code (in NEC Protocol)
    text(hex(pid15.rxData[0]),120,202);
    text(hex(pid15.rxData[1]),350,202); // inverted value
    // Data code (in NEC Protocol)
    text(hex(pid15.rxData[2]),120,252);
    text(hex(pid15.rxData[3]),350,252); // inverted value
    //if data code is registred action; print action's name 
    //if(funcName[pid15.rxData[2]]==null) text("NULL",120,322);
    //else text(funcName[pid15.rxData[2]],120,322);
  }
  
  //executed once
  if(pid15.rxData[0]==10 && dataSav != pid15.sensoryPacket[0]) // 10==0x0A, whitelist address. can be altered by coder;
  {
    dataSav = pid15.sensoryPacket[0];
    cs.setSoundClip(BEEP);
    switch(pid15.rxData[2]){
      case 0:
        //as you wish..
        break;
      case 1:
        //function
        break;
      default :
        break;
    }
  }
  //아래부터는 사용하지 않는 부분임. Tx에서 더 많은 데이터를 보낸다면야 사용하겠지만, 보통 Payload Data Length가 길어지면 갱신 속도에 안좋으므로 Address code와 Data code 각각 2바이트씩 총 4바이트만 사용한다.
  //text(hex(pid15.rxData[4]),300,180);
  //text(hex(pid15.rxData[5]),300,200);
  //text(hex(pid15.rxData[6]),300,220);
  //text(hex(pid15.rxData[7]),300,240);
  //text(hex(pid15.rxData[8]),300,260);
  //text(hex(pid15.rxData[9]),300,280);
  //text(hex(pid15.rxData[10]),300,300);
  //text(hex(pid15.rxData[11]),300,320);
  //text(hex(pid15.rxData[12]),300,340);
  //text(hex(pid15.rxData[13]),300,360);
  //text(hex(pid15.rxData[14]),300,380);
  //text(hex(pid15.rxData[15]),300,400);
  //text(hex(pid15.rxData[16]),300,420);
  //text(hex(pid15.rxData[17]),300,440);
  //text(hex(pid15.rxData[18]),300,460);
  //text(hex(pid15.rxData[19]),300,480);

}

public void loop()
{
  
}

public void LED_ON(){
  cs.inputLa = 255;
}
