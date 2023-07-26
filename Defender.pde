
class Defender
{
  final PImage standard = loadImage("tower_standard.png");
  final PImage advanced = loadImage("tower_advanced.png");
  int x, y, w, h;
  float angle;
  PImage img;
  
  // Constructor
  public Defender(int tx, int ty, int ts)
  {
    this.x = tx * ts;
    this.y = ty * ts;
    this.w = ts;
    this.h = ts;
    img = standard;
    angle = 0;
  }
  
  // Render
  public void Render()
  {
    image(img, x, y);
  }
  
  // Aiming
  public void Target(Attacker mark)
  {
    int defX = x + w/2;
    int defY = y + h/2;
    int xShift;
    int yShift;
    /* --- X SHIFT --- */
    try
    {
      xShift = mark.xSpeed / abs(mark.xSpeed);
      if (mark.xSpeed < 0)
      {
        xShift += 1;
      }
    }
    catch(ArithmeticException e)
    {
      xShift = 0;
    }
    /* --- Y SHIFT --- */
    try
    {
      yShift = mark.ySpeed / abs(mark.ySpeed);
      if (mark.ySpeed < 0)
      {
        yShift += 1;
      }
    }
    catch(ArithmeticException e)
    {
      yShift = 0;
    }
    
    int atkX = xShift * TILESIZE + mark.x;
    int atkY = yShift * TILESIZE + mark.y;
    
    float xDiff = atkX - defX;
    float yDiff = -(atkY - defY);
    angle = atan(yDiff / xDiff);
    if (xDiff < 0)
    {
      angle += PI;
    }
  }
  
  public void Shoot(ArrayList<Projectile> list)
  {
    Projectile new_proj = new Projectile(x + w/2, y + h/2, 5, 5, 8, angle);
    list.add(new_proj);
  }
}
