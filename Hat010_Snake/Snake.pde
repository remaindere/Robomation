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
  public int sColor;
  public Node head; // snake's head
  public Node tail; // snake's tail
  
  Snake(){ // head is constructed by constructor, when it was defined
    this.sState = 0;
    this.sSize = 0;
    this.sColor = 1;
    this.head = null;
    this.tail = null;
    Node initN = new Node();
    initN.x = 4;
    initN.y = 3;
    this.head = initN;
    this.feedx = int(random(1,5));
    this.feedy = int(random(1,5));
  };
 
  public void Start(){ // make snake (head body tail)
    Node pTail = new Node(); //tail
  
    this.head.direction = 1; //left
    pTail.x = this.head.x + 1;
    pTail.y = this.head.y;
    this.head.nextL = pTail;
    pTail.nextL = null;
    this.sSize = 2;
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
  
    // snake has dead, wall collision..T T [Outbound]
    if (this.head.x == -1 || this.head.x == 6 || this.head.y == -1 || this.head.y == 6)
    {
      this.sState = 2; // die
      return;
    }
    pCur = pCur.nextL;

    // snake has dead, bite his own body..T T
    while (pCur!=null)
    {
      if (pCur.x == this.head.x && pCur.y == this.head.y) //collision detected
      {
        this.sState = 3; // die
        return;
      }
      pCur = pCur.nextL;
    }
  
    // snake's body moves toward its head direction
    // linked list
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
    
    if (this.head.x == this.feedx && this.head.y == this.feedy) 
    {
      Node OOC = new Node();
      OOC = this.head; // OUT OF CREATE
      while (true)
      {
        feedx = int(random(1,5));
        feedy = int(random(1,5));
        while (OOC!=null) // check every node(body parts)
        {
          if (OOC.x == this.feedx && OOC.y == this.feedy) break; // if feed is generated in body
          OOC = OOC.nextL;
        }
        if (OOC!=null) continue;//re-generate feed
        else break;
      }
      
      this.sColor++;
      cs.setSoundClip(BEEP); // sound fx - beep
      if(this.sColor == 5){ // it grows!
        Node bodyNew = new Node(); //create new body
        bodyNew.x = Prevx;
        bodyNew.y = Prevy;
        this.tail = bodyNew; // newbody becomes its tail
        pCur.nextL = bodyNew;
        this.sSize++;
        this.sColor = 1; //color reset
      }
    }
  }
};
