public class HAT_010 extends Roboid
{
  private final int Button_A = 2;
  private final int Button_B = 3;
  public int bright = 10;  // default brightness
  public int[][] led = new int[5][5];
  public int buttonA, buttonB;
  
  public HAT_010(Cheese cs) 
  {
    name = "5x5 RGB Matrix";
    id = 10;  // 0x0A
    cs.attachHAT(this);
  }
  
  public void setSimulacrum(String sensory) {
    super.setSimulacrum(sensory);
    
    // parse device data
    buttonA = sensoryPacket[Button_A];
    buttonB = sensoryPacket[Button_B];
    //System.out.println(sensory);
  }
  
  public String getSimulacrum()
  {
    motoringPacket[0] = 0x2A;
    motoringPacket[1] = 0x0;
    
    // build simulacrum
    motoringPacket[2] = led[0][0] * 16 + led[0][1];
    motoringPacket[3] = led[0][2] * 16 + led[0][3];
    motoringPacket[4] = led[0][4] * 16 + led[1][0];
    motoringPacket[5] = led[1][1] * 16 + led[1][2];
    motoringPacket[6] = led[1][3] * 16 + led[1][4];
    motoringPacket[7] = led[2][0] * 16 + led[2][1];
    motoringPacket[8] = led[2][2] * 16 + led[2][3];
    motoringPacket[9] = led[2][4] * 16 + led[3][0];
    motoringPacket[10] = led[3][1] * 16 + led[3][2];
    motoringPacket[11] = led[3][3] * 16 + led[3][4];
    motoringPacket[12] = led[4][0] * 16 + led[4][1];
    motoringPacket[13] = led[4][2] * 16 + led[4][3];
    motoringPacket[14] = led[4][4] * 16;
    motoringPacket[19] = bright;
    String motoring = super.getSimulacrum();
    //System.out.println(motoring);
    return motoring;
  }
}
