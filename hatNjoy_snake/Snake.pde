class Node
{
  public int x, y, direction;
  public Node nextL;
  Node(){
    this.x = 0;
    this.y = 0;
    this.nextL = null;
  }
};


class Snake
{
  public int sSize;
  public int feedx, feedy; // feed
  public int sState;//game state
  public Node head; // snake's head
  public Node tail; // snake's tail
  
  Snake(){ // head is constructed by constructor, when it was defined
    this.sState = 0;
    this.sSize = 0;
    this.head = null;
    this.tail = null;
    Node initN = new Node();
    initN.x = 7;
    initN.y = 4;
    this.head = initN;
    this.feedx = int(random(1,16));
    this.feedy = int(random(1,8));
  };
 
  public void Start(){ // make snake (head body tail)
    Node body = new Node(); // body
    Node pTail = new Node(); 
  
    this.head.direction = 1; // forward
    body.x = this.head.x + 1;
    body.y = this.head.y;
    this.head.nextL = body;
    pTail.x = body.x + 1;
    pTail.y = body.y;
    body.nextL = pTail;
    pTail.nextL = null;
    this.sSize = 3;
  }
  
  public void Move(){// not just move, it is method about "snake game" itself
                     // it contains collision detection, feed generator, actual moves, direction determinator, etc..
    if (sState == 0) return; // do nothing. [game has not been started yet]
  
    // go to next point snake which you want direction
    Node pCur = new Node();
    pCur = this.head;
    int Prevx, Prevy, Nextx, Nexty;
    Prevx = pCur.x;
    Prevy = pCur.y;

    if (this.head.direction == 0)
      this.head.y = this.head.y - 1;
    else if (this.head.direction == 1)
      this.head.x = this.head.x - 1;
    else if (this.head.direction == 2)
      this.head.y = this.head.y + 1;
    else if (this.head.direction == 3)
      this.head.x = this.head.x + 1;
    //move end
  
    // snake has dead, wall collision..T T [Outbound]
    if (this.head.x == 0 || this.head.x == 17 || this.head.y == 0 || this.head.y == 9)
    {
      this.sState = 2; // die
      return;
    }
    pCur = pCur.nextL;

    while (pCur!=null)
    {
      // snake has dead, bite his own body..T T
      if (pCur.x == this.head.x && pCur.y == this.head.y)
      {
        this.sState = 3; // die
        return;
      }
      pCur = pCur.nextL;
    }
  
    // snake's body moves toward its head direction
    pCur = this.head;
    while (pCur.nextL!=null)
    {
      pCur = pCur.nextL;
      Nextx = pCur.x;
      Nexty = pCur.y;
      pCur.x = Prevx;
      pCur.y = Prevy;
      Prevx = Nextx;
      Prevy = Nexty;
    }
  

    // feed section
    // need to do: Do not create feed on snake's body or head
    Node OOC = new Node();
    OOC = this.head; // OUT OF CREATE
    if (this.head.x == this.feedx && this.head.y == this.feedy) 
    {
      while (true)
      {
        feedx = int(random(1,16));
        feedy = int(random(1,8));
        while (OOC!=null)
        {
          if (OOC.x == this.feedx && OOC.y == this.feedy)
            break;
          OOC = OOC.nextL;
          cs.setSoundClip(BEEP);
        }
        if (OOC!=null)    
          continue;
        else
          break;
      }
      //create new body
      Node bodyNew = new Node();
      bodyNew.x = Prevx;
      bodyNew.y = Prevy;
      this.tail = bodyNew;
      pCur.nextL = bodyNew;
      this.sSize++;
    }
  }
};
