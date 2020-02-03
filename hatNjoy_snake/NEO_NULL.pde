public class NEO_NULL extends Roboid
{
  public NEO_NULL(Cheese cs) {
    cs.attachPID(this);
    name = "Null Device";
    this.id = 0x0;
    this.type = 0;    
  }
  
  public void setSimulacrum(String sensory) {
    super.setSimulacrum(sensory);
    //System.out.println(sensory);
  }
  
  public String getSimulacrum()
  {
    motoringPacket[0] = 0x40;

    String motoring = super.getSimulacrum();
    //System.out.println(motoring);
    return motoring;
  }
}
