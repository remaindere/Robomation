public abstract class Roboid
{
  public int frame;
  public String name = "";
  public int id = 0;
  public int type = 0;
  protected int[] motoringPacket = new int[20];
  protected int[] sensoryPacket = new int[20];
  private String hexChar[] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 
    "A", "B", "C", "D", "E", "F"};
  private String value;
  private int hex;
  
  /** convert hex packet to string */
  public String getSimulacrum() 
  {
    String motoringSimulacrum = "";
    
    // Convert to byte to string
    for(int i = 0; i < 20; i++)
    {
     int j = (motoringPacket[i] >> 4) & 0x0F;
     int k = motoringPacket[i] &0x0F;
      
     motoringSimulacrum += hexChar[j];
     motoringSimulacrum += hexChar[k];
    }
    motoringSimulacrum += "\r";
    return motoringSimulacrum;
  }
  
  /** convert string to hex packet */
  public void setSimulacrum(String sensory) 
  {
    // frame number
    frame++;
    
    for(int i = 0; i < 20; i++)
    {
      value = sensory.substring(i * 2, i * 2 + 2);
      hex = Integer.valueOf(value, 16).intValue();    
      sensoryPacket[i] = hex;
    }
  }
  
  protected void clearMotoringPacket()
  {
    this.motoringPacket = new int[20];
  }
}
