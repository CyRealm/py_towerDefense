import processing.sound.*;
/*
Bonus: 
 - Bouncing Bullets
 - Tracking Bullets
 - Explosive Bullets
 - Range for towers
*/

int TILESIZE = 50;
int TOTAL_LIVES = 10;
MapGrid level1;
ArrayList<Projectile> projs = new ArrayList();
ArrayList<Defender> towers = new ArrayList();
ArrayList<Attacker> minions = new ArrayList();
SoundFile bgm;

void setup()
{
  size(1200, 900);
  level1 = new MapGrid();
  minions.add(new Attacker(TILESIZE, level1.startTileX, level1.startTileY));
  bgm = new SoundFile(this, "bgm.mp3");
  bgm.rate(1.1);
  bgm.loop();
}

void draw()
{
  for (Attacker minion : minions)
  {
    minion.Seek(level1);
    minion.Move(level1);
  }
  background(100);
  level1.Visualize();
  level1.Render();
  for (Defender tower : towers)
  {
    if (minions.size() == 0)
    {
      break;
    }
    tower.Target(minions.get(0));
    tower.Render();
  }
  for (Attacker minion : minions)
  {
    minion.Render();

    for (Projectile proj : projs)
    {
      if (proj.Collision(minion))
      {
        minion.hp--;
      }
      proj.Update();
      proj.Render();
    }
  }
}

void mouseClicked()
{
  int rowClicked = mouseY / TILESIZE;
  int colClicked = mouseX / TILESIZE;
  if (level1.def_mapping[rowClicked][colClicked] != null ||
    level1.mapping[rowClicked][colClicked] != 0)
  {
    println("You can't build here");
    return;
  }
  // Spawn a defender at this location
  towers.add(new Defender(colClicked, rowClicked, TILESIZE));
  level1.def_mapping[rowClicked][colClicked] = towers.get(towers.size() - 1);
}

void keyPressed()
{
  for (Defender tower : towers)
  {
    tower.Shoot(projs);
  }
}
