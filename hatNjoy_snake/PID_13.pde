public class PID_13 extends Roboid
{
  public int x, y;
  public boolean A, B;
  
  public PID_13(Cheese cs) {
    name = "JOYSTICK_1";
    this.id = 13;
    type = 0;
    cs.attachPID(this);
  }
  
  public void setSimulacrum(String sensory) {
    super.setSimulacrum(sensory);
    
    // parse device data
    x = sensoryPacket[1];
    y = sensoryPacket[2];
    A = sensoryPacket[3] == 1 ? true : false; 
    B = sensoryPacket[4] == 1 ? true : false; 
    
    //System.out.println(x + ", " + y);
    //System.out.println(A + ", " + B);
  }
  
  public String getSimulacrum()
  {
    motoringPacket[0] = 0x30 + this.id;
    String motoring = super.getSimulacrum();
    //System.out.println(motoring);
    return motoring;
  }  
}
