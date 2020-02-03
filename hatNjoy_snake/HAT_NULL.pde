public class HAT_NULL extends Roboid
{
  public HAT_NULL(Cheese cs) {
    cs.attachHAT(this);
    name = "HAT_NULL";
    id = 0;
  }
  
  public String getSimulacrum()
  {
    motoringPacket[0] = 0x20;
    motoringPacket[1] = 0x00;

    String motoring = super.getSimulacrum();
    //System.out.println(motoring);
    return motoring;
  }
}
