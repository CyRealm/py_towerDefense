class Projectile
{
  float x, y, w, h;
  float xVel, yVel;
  float speed;

  public Projectile(int x, int y, int w, int h, float s, float a)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    speed = s;
    xVel = (cos(a) * speed);
    yVel = -(sin(a) * speed);
  }

  public void Update()
  {
    x += xVel;
    y += yVel;
  }

  public boolean Collision(Attacker target)
  {
    // 1. Current Position -> Future Position
    float fX = x + xVel;
    float fY = y + yVel;
    float slope = (fY - y) / (fX - x);
    float b = y - slope * x;
    // 2. Create line segements across all sides of target
    float yTop = target.y;
    float yBottom = target.y + target.h;
    float xLeft = target.x;
    float xRight = target.x + target.w;
    // 3. Calculate the point of intersection
    float pointTop = (yTop - b) / slope;
    float pointBottom = (yBottom - b) / slope;
    float pointLeft = xLeft * slope + b;
    float pointRight = xRight * slope + b;
    float[][] allContactPoints = {{xLeft, pointLeft}, {xRight, pointRight}, 
      {pointTop, yTop}, {pointBottom, yBottom}};
    // 4. Evaluate if the PoI is within the range of attacker
    for (float[] point: allContactPoints)
    {
      if(point[0] <= max(fX, x) && point[0] >= min(fX, x))
      {
        if(point[1] <= max(fY, y) && point[1] >= min(fY, y))
        {
          return true;
        }
      }
    }
    return false;
  }

  public void Render()
  {
    fill(0, 255, 255); 
      rect(x, y, w, h);
  }
}
