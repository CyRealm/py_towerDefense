class Attacker
{
  int x, y, w, h;
  int tileX, tileY;
  int xSpeed, ySpeed;
  int hp;
  boolean active;
  PImage texture;

  // Constructor
  public Attacker(int ts, int tx, int ty)
  {
    this.x = tx * ts;
    this.y = ty * ts;
    this.w = ts;
    this.h = ts;
    tileX = tx;
    tileY = ty;
    active = true;
    hp = 5;
    //texture = loadImage("ufo.png");
  }

  public void Seek(MapGrid mg)
  {
    try
    {
      xSpeed = 0;
      ySpeed = 0;
      if (mg.mapping[tileY][tileX]%4 == 1)
      {
        ySpeed = -1;
      } else if (mg.mapping[tileY][tileX]%4 == 2)
      {
        xSpeed = 1;
      } else if (mg.mapping[tileY][tileX]%4 == 3)
      {
        ySpeed = 1;
      } else if (mg.mapping[tileY][tileX] == 4)
      {
        xSpeed = -1;
      }
    }
    catch(Exception e)
    {
      println("Ran into a problem");
    }
  }
  
  public void RemoveUnit(ArrayList<Attacker> atks)
  {
    atks.remove(this);
  }
  
  public void Move(MapGrid map)
  {
    x += xSpeed;
    y += ySpeed;
    tileX = (x + xSpeed) / TILESIZE;
    tileY = (y + ySpeed) / TILESIZE;
    if (xSpeed < 0)
    {
      tileX += 1;
    }
    else if (ySpeed < 0)
    {
      tileY += 1;
    }
    
    // Check if the attacker is out of bounds
    if (tileX < 0 || tileX > map.mapping.length)
    {
      active = false;
    }
  }

  // Render
  public void Render()
  {
    fill(255, 0, 50);
    rect(x, y, w, h);
    //image(texture, x, y);
  }
}
