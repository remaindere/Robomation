import processing.core.PApplet;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import jssc.SerialPort;
import jssc.SerialPortException;
import processing.serial.Serial;

public class Cheese extends Roboid implements Runnable
{
  PApplet parent;
  Method execute = null;
  Method loop = null;
  Class mainApp;
  private Thread execute_thread = null;
  
  public Serial port;
  public String portName;
  int baudRate = 115200;
  String packet;
  private int cr = 13;
  String hex[] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 
    "A", "B", "C", "D", "E", "F"};
  private char[] localName = {'C', 'h', 'e', 'e', 's', 'e'};
  private char[] newName;

  // define effectors 
  private int bleResetId, newNameId, lifeTimeId, lifeTime;
  private int configS, configL, configM, configD, configG;
  private int configX, configPulseSc, configPulseLc, configNeo;
  public  int outSa, outSb, outSc;
  public  int outLa, outLb, outLc;
  public  int outMab, outMcd, pps;
  private int stepId, stepsToGoH, stepsToGoL;
  private int buzz, soundH, soundL;

  // define sensors
  public int rssi, battery, temperature;  
  public int inputSa, inputSb, inputSc;
  public int inputLa, inputLb, inputLc;
  public int gravity_X, gravity_Y, gravity_Z;
  public int echoDistance, steps;
  public int g_event, freeFallId;
  public int tap, tapId, tapSign;
  public int state, powerState, playState, stepState;
  public String tap_axis;
  public String address;
  
  // define UART
  private int uartTxId = 0;
  private char[] uartTxPacket;
  private int uartRxId;
  private char[] uartRxPacket;

  private Roboid hat_null = new HAT_NULL(this);
  private Roboid pid_null = new PID_NULL(this);  
  private Roboid neo_null = new NEO_NULL(this);  
  private Roboid hat = hat_null;
  private Roboid pid = pid_null;  
  private Roboid neo = neo_null; 
  
  public Cheese(PApplet parent) 
  {
    this.parent = parent;
    //parent.registerMethod("draw", this);
    //parent.registerMethod("dispose", this);     
    
    if (openPort() == null) {
      System.err.println("No available USB to BLE bridge  ");
    }
    
    mainApp = parent.getClass();  
    Class[] param = {}; 

    if(execute == null) {
      try {
        execute = mainApp.getMethod("execute", param);
      } catch (Exception e) {}
    } 
    
    if(loop == null) {
      try {
        loop = mainApp.getMethod("loop", param);
      } catch (Exception e) {}
    }   
    
    Thread t = new Thread(this);
    t.start();
    
    // create singleton thread
    if(execute_thread == null) {
      execute_thread = new Thread(new Execute(parent, execute));
      execute_thread.start();
    }    
  }

  /**@control executed only once  */
  class Execute implements Runnable{
    private PApplet applet;
    private Method execute;
    
    public Execute(PApplet applet, Method execute){
      this.applet = applet;
      this.execute = execute;
    }

    @Override
    public void run() {      
      // TODO Auto-generated method stub
      //while(true) 
      {
        try {
          if(execute != null) execute.invoke(applet, null);
          //Thread.sleep(10);
        } catch (Exception e) {}
      }
    }    
  }
  
  @Override
  public void run() {
    for (;; ) {          
      // Sensory simulacrum
      if (port != null) packet = port.readStringUntil(cr);  
      if (packet != null && packet.length() == 54) 
      {
        // Sensory Simulacrum
        setSimulacrum(packet);

        // Motoring Simulacrum    
        // System.out.println(packet);
        String value = packet.substring(0, 1);
        if (value.equals("1")) port.write(getSimulacrum());
        if (value.equals("2")) port.write(hat.getSimulacrum());
        if (value.equals("3")) port.write(pid.getSimulacrum());
        if (value.equals("4")) port.write(neo.getSimulacrum());

        // call loop() method 
        Object[] param = {};    
        try {
          if(loop != null) {
            if (value.equals("1")) loop.invoke(parent, param);
          }
        } catch (Exception e) {}
      }
              
      // Wait for next packet from robot
      try {
        Thread.sleep(2);
      } 
      catch (InterruptedException e) {
        // TODO Auto-generated catch block
      }
    }
  }

  // define setter methods
  public void setBleReset()
  {
    bleResetId++;
  }

  public void setPacketLife(int time)
  {
    lifeTimeId++;
    lifeTime = time;
  }

  public void setNewName(char[] name)
  {
    newNameId++;
    newName = name;
  }

  private int config(int mode, int param)
  {
    int config = 0;
    int out = 0;

    switch(mode) 
    {
    case DIGITAL_IN:
      if (param == PULL_DN_50K) out = PULL_DN_50K;
      if (param == PULL_UP_50K) out = PULL_UP_50K;
      if (param == PULL_DN_2M)  out = PULL_DN_2M;
      break;
    case ANALOG_IN:
      config = ANALOG_IN;
      if (param == ADC_BGV) out = ADC_BGV << 4;    
      break;
    case PWM_OUT:
      config = PWM_OUT;
      break;
    case SERVO_OUT:
      config = SERVO_OUT;
      break;
    }
    return config + (out << 8);
  }

  // set configration of S port
  public void configSa(int mode, int param)
  {
    int cf = config(mode, param);
    configS &= ~(0x3);
    configS |= cf & 0x3;
    outSa = cf >> 8;
  }
  public void configSb(int mode, int param)
  {
    int cf = config(mode, param);
    configS &= ~(0xC);
    configS |= (cf << 2) & 0xC;
    outSb = cf >> 8;
  }
  public void configSc(int mode, int param)
  {
    if(mode == PULSE_IN) {
      configPulseSc = 1;
    }
    else {
      int cf = config(mode, param);
      configS &= ~(0x30);
      configS |= (cf << 4) & 0x30;
      outSa = cf >> 8;
      configPulseSc = 0;
    }
  }

  // set configration of L port
  public void configLa(int mode, int param)
  {
    int cf = config(mode, param);
    configL &= ~(0x3);
    configL |= cf & 0x3;
    outLa = cf >> 8;
  }
  public void configLb(int mode, int param)
  {
    int cf = config(mode, param);
    configL &= ~(0xC);
    configL |= (cf << 2) & 0xC;
    outLb = cf >> 8;
  }
  public void configLc(int mode, int param)
  {
    if(mode == PULSE_IN) {
      configPulseLc = 1;
    }
    else {
      int cf = config(mode, param);
      configL &= ~(0x30);
      configL |= (cf << 4) & 0x30;
      outLc = cf >> 8;
      configPulseLc = 0;
    }
  }  

  // set configration of M port
  public void configM(int mode, int mab, int mcd)
  {
    configM = (mode << 6) + (mcd << 2) + mab;
  }
  public void configM(int mode, int drive)
  {
    configM = (mode << 6) + (drive << 4);
  }
  public void configM(int mode)
  {
    configM = mode << 6;
  }

  public void stepMotor(int pps, int stepsToGo)
  {
    if(stepsToGo < 0) {
      this.pps = -pps;
      stepsToGo *= -1;
    }
    else this.pps = pps;

    stepsToGoH = (stepsToGo >> 8) & 0xFF;
    stepsToGoL = stepsToGo & 0xFF;
//    steps = 0;
    stepId++;
  }
  public void stepMotor(int stepsToGo)
  {
    stepMotor(this.pps, stepsToGo);
  }
  
  public void setBlueLed(int on)
  {
    configX &= 0xCF;
    switch(on) 
    {
    case REMOTE_DISABLE:
      break;
    case REMOTE_ON:
      configX |= 0x30;
      break;
    case REMOTE_OFF:
      configX |= 0x20;
      break;
    }
  }
  public void setRedLed(int on)
  {
    configX &= 0x3F;
    switch(on) 
    {
    case REMOTE_DISABLE:
      break;
    case REMOTE_ON:
      configX |= 0xC0;
      break;
    case REMOTE_OFF:
      configX |= 0x80;
      break;
    }
  }

  // setters for sound control
  public void setSoundFreq(int freq)
  {
    soundH = (freq >> 8) + 2;
    soundL = freq & 0xFF;
  } 
  public void setSoundNote(int note)
  {
    soundH = 1;
    soundL = note;
  }
  public void setSoundClip(int clip)
  {
    soundH = 0;
    if((soundL & 0x80) == 0) soundL = clip + 0x80;
    else soundL = clip;
  } 

  public void setGravity(int bandWidth, int range)
  {
    configG = (bandWidth << 4) + range;
  }
  
  // handling simulacrum to build motoring  packet
  public String getSimulacrum() 
  {
    int[] packet = motoringPacket;
    String motoring = "";
   
    /**@command? */
    if(bleResetId > 0) {
      bleResetId = 0;
      packet[0] = 0xF0;
    }
    else if(lifeTimeId > 0) {
      lifeTimeId = 0;
      packet[0] = 0xD0;
      packet[1] = lifeTime;
    }
    else if(newNameId > 0) {
      newNameId = 0;
      if(newName == null) newName = localName;
      packet[0] = 0xA0;
      packet[1] = newName.length;
      for(int i = 0; i < newName.length; i++)
      {
        packet[i + 2] = newName[i];
      }
    }
    else {
      /**@control effectors */
      packet[0] = 0x10;
      packet[1] = configS + (configPulseSc << 6) + (configNeo << 7);
      packet[2] = configL + (configPulseLc << 6);
      packet[3] = configM;
      packet[4] = configD;
      packet[5] = configG; 
      packet[6] = outSa;
      packet[7] = outSb;
      packet[8] = outSc;
      packet[9] = outLa;
      packet[10] = outLb;
      packet[11] = outLc;
      if((configM & 0xC0) == 0x80 || (configM & 0xC0) == 0xC0) {
        packet[12] = pps >> 8;
        packet[13] = pps & 0xFF;        
      }
      else {
        packet[12] = outMab;
        packet[13] = outMcd;
      }
      packet[14] = stepId;
      packet[15] = stepsToGoH;
      packet[16] = stepsToGoL;    
      packet[17] = soundH;
      packet[18] = soundL;
      packet[19] = 0;
    }
    motoring = super.getSimulacrum();   
    //System.out.println("motor: " + motoring);
    return motoring;
  }

  public static final int IN_A = 1*2;
  public static final int IN_B = 2*2;
  public static final int IN_C = 3*2;
  public static final int IN_LA = 4*2;
  public static final int IN_LB = 5*2;
  public static final int IN_LC = 6*2;
  public static final int ECHO = 5*2;
  public static final int GRAVITY = 7*2;  
  public static final int STEPS = 13*2;
  public static final int G_EVENT = 15*2;
  public static final int STATE = 16*2;
  public static final int TEMPER = 17*2;
  public static final int RSSI = 18*2;
  public static final int BATTERY = 19*2;

  public void setSimulacrum(String packet) 
  {
    //System.out.println(packet);

    // Packet Type
    String value = packet.substring(0, 2);
    int i = Integer.valueOf(value, 16).intValue();
    i &= 0xF0;  
    if (i == 0x20) hat.setSimulacrum(packet); 
    if (i == 0x30) pid.setSimulacrum(packet);
    if (i == 0x40) neo.setSimulacrum(packet); 
    if (i != 0x10) return; 

    // RSSI
    value = packet.substring(RSSI, RSSI+2);
    i = Integer.valueOf(value, 16).intValue();
    i -= 255;
    rssi = i;

    // Battery
    value = packet.substring(BATTERY, BATTERY+2);
    i = Integer.valueOf(value, 16).intValue();
    i += 200;
    battery = i*10;

    // Temperature
    value = packet.substring(TEMPER, TEMPER+2);
    i = Integer.valueOf(value, 16).intValue();
    if (i >= 128) i = i - 256;
    temperature = 24 + i/2;

    // IO
    value = packet.substring(IN_A, IN_A+2);
    inputSa = Integer.valueOf(value, 16).intValue();
    value = packet.substring(IN_B, IN_B+2);
    inputSb = Integer.valueOf(value, 16).intValue();
    value = packet.substring(IN_C, IN_C+2);
    inputSc = Integer.valueOf(value, 16).intValue();    

    value = packet.substring(IN_LA, IN_LA+2);
    inputLa = Integer.valueOf(value, 16).intValue();
    value = packet.substring(IN_LB, IN_LB+2);
    inputLb = Integer.valueOf(value, 16).intValue();
    value = packet.substring(IN_LC, IN_LC+2);
    inputLc = Integer.valueOf(value, 16).intValue();    

    value = packet.substring(GRAVITY, GRAVITY+4);
    i = Integer.valueOf(value, 16).intValue();
    if (i >= 0x8000) i = i - 0xFFFF;
    gravity_X = i;
    value = packet.substring(GRAVITY+4, GRAVITY+8);
    i = Integer.valueOf(value, 16).intValue();
    if (i >= 0x8000) i = i - 0xFFFF;
    gravity_Y = i;
    value = packet.substring(GRAVITY+8, GRAVITY+12);
    i = Integer.valueOf(value, 16).intValue();
    if (i >= 0x8000) i = i - 0xFFFF;
    gravity_Z = -i;  

    // Accumulated Distance
    value = packet.substring(STEPS, STEPS+4);
    i = Integer.valueOf(value, 16).intValue();
    if (i < 0) i = 0x10000 - i;
    steps = i;

    // G event
    value = packet.substring(G_EVENT, G_EVENT+2);
    g_event = Integer.valueOf(value, 16).intValue();
    freeFallId = (g_event >> 6) & 0x03;
    tapId = (g_event >> 4) & 0x03;
    tap = g_event & 0x0F;
    tapSign = (g_event >> 3) & 0x01;
    if (tapSign == 0x01) {
      if ((tap & 0x01) != 0) tap_axis = "-X";
      else if ((tap & 0x02) != 0) tap_axis = "-Y";
      else if ((tap & 0x04) != 0) tap_axis = "-Z";
    } else {
      if ((tap & 0x01) != 0) tap_axis = "+X";
      else if ((tap & 0x02) != 0) tap_axis = "+Y";
      else if ((tap & 0x04) != 0) tap_axis = "+Z";
    }

    // internal state
    value = packet.substring(STATE, STATE+2);
    state = Integer.valueOf(value, 16).intValue();  
    powerState = state & 0x03;
    playState = (state >> 4) & 1;
    stepState = (state >> 7) & 1;

    address = packet.substring(41, 53);
    //System.out.println(play_state);
  }

  private void delay(int d) {
    try {
      Thread.sleep(d);
    } 
    catch (InterruptedException e) {
      // TODO Auto-generated catch block
    }
  }

  private String getLivePacket() {
    String packet;
    for (int w = 0; w < 10; w++) {
      delay(10);
      if ((packet = port.readStringUntil(cr)) != null)
        return packet;
    }
    return null;
  }  

  private String getInfoPacket() {
    String packet;
    for (int w = 0; w < 10; w++) {
      delay(10);
      if ((packet = port.readStringUntil(cr)) != null) {
        if (packet.substring(0, 2).equals("FF")) return packet;
      }
    }
    return null;
  }

  private boolean isDongle() {
    String pkt1, pkt2;
    getLivePacket();
    pkt1 = getLivePacket();
    pkt2 = getLivePacket();

    for(int ty = 0; ty < 3; ty++){
      if (pkt2 != null && pkt2.length() == 54)
      {
        port.write("FF\r");
        String info = getInfoPacket();
        if (info != null) {
          info = info.trim();
          System.out.println(portName + ": " + info + "  ");
          return true;
        }
      }
      else{
        //System.out.println("Unknown packet");
      }
    }

    if (pkt2 != null && pkt1 != null && pkt2.length() == 2) {
      System.out.println(portName + ": Connection lost..  ");
      return true;
    }
    return false;
  } 


  private Serial openPort() {  
    // try to open port sequentially
    for (int portNum = 0; portNum <  Serial.list().length; portNum++) {
      try {
        port = new Serial(parent, Serial.list()[portNum], 115200);
        port.port.setFlowControlMode(SerialPort.FLOWCONTROL_RTSCTS_IN | SerialPort.FLOWCONTROL_RTSCTS_OUT);
        port.clear();

        // connect and check packet
        portName = port.port.getPortName();
        if (isDongle()) return port;
        port.port.closePort();
      } 
      catch (Exception e) {
        continue;
      }
    }
    return null;
  }
  
  public void attachHAT(Roboid hat)
  {
    this.hat = hat; 
  }

  public void attachPID(Roboid pid)
  {
    this.pid = pid;
    outLa = pid.type;  // set type first
    configD = pid.id;  // set config last
  }
  
  public void attachNEO(Roboid neo)
  {
    this.neo = neo;
    configNeo = 1;
  }
  
  public void detachHAT()
  {   
    this.hat = hat_null; 
  }

  public void detachPID()
  {
    this.pid = pid_null;
    configD = pid.id;
    outLa = pid.type;
  }
  
  public void detachNEO()
  {
    configNeo = 0;
  }
  
  public Roboid getHAT()
  {
    return hat;
  }
  
  public Roboid getPID()
  {
    return pid;
  }  
}
