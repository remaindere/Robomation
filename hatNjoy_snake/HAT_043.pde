public class HAT_043 extends Roboid
{
  public int bright = 10;  // default brightness
  public boolean[][] led = new boolean[16][8];
  //public int buttonA, buttonB;
  //private final int Button_A = 2;
  //private final int Button_B = 3;
  
  public HAT_043(Cheese cs) {
    cs.attachHAT(this);
    name = "8x16 Dot Matrix";
    id = 43;  // 0x2B
  }
  
  public void setSimulacrum(String sensory) {
    super.setSimulacrum(sensory);
    
    // parse device data
    //buttonA= sensoryPacket[Button_A]; //boolean? int?
    //buttonB= sensoryPacket[Button_B];
    // System.out.println(sensory);
  }

  public void clear()
  {
    led = new boolean[16][8];
  }
  
  public String getSimulacrum()
  {
    motoringPacket[0] = 0x2B;
    motoringPacket[1] = 0x02;
    
    for(int i=2; i<19; i++)
    {
      motoringPacket[i]=0;
    }
    // build simulacrum
    for(int i = 0; i < 8; i++) {
//      motoringPacket[2+i] = 0;
      for(int j = 0; j < 16; j++) {
        
        if(led[j][i]) motoringPacket[2+2*i+j/8] += (1 << (((j/8)==0)? (7-j) : (15-j)));
      }
    }
    motoringPacket[19] = bright;
    String motoring = super.getSimulacrum();
    System.out.println(motoring);
    return motoring;
  }
}
