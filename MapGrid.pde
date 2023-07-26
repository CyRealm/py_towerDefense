static int up = 1;
static int right = 2;
static int down = 3;
static int left = 4;

class MapGrid
{
  int[][] mapping;
  Defender[][] def_mapping;
  String[] mapTxt;
  int startTileX = 0;
  int startTileY = 0;
  PImage portal;
  
  public MapGrid()
  {
    mapping = new int[height/50][width/50];
    def_mapping = new Defender[height/50][width/50];
    mapTxt = loadStrings("mapping.txt");
    portal = loadImage("portal.png");
    for(int row = 0; row < height/50; row++)
    {
      String rowText = mapTxt[row];
      String[] rowTextSplit = rowText.split(",");
      for(int col = 0; col < width/50; col++)
      {
        mapping[row][col] = Integer.parseInt(rowTextSplit[col]);
      }
    }
    
    for (int row = 0; row < mapping.length; row++)
    {
      for (int col = 0; col < mapping[row].length; col++)
      {
        if (mapping[row][col] > 4)
        {
          startTileX = col;
          startTileY = row;
        }
      }
    }
    
    // For visuals of the mapping
    for(int[] row: mapping)
    {
      String currentLine = "";
      for(int col: row)
      {
        currentLine += col + " ";
      }
      println(currentLine);
    }
  }
  
  public void Update()
  {
  }
  
  public void Visualize()
  {
    stroke(0, 255, 50);
    for(int rowNum = 0; rowNum < mapping.length; rowNum++)
    {
      line(0, rowNum * 50, width, rowNum * 50);
    }
    for(int colNum = 0; colNum < mapping[0].length; colNum++)
    {
      line(colNum * 50, 0, colNum * 50, height);
    }
  }
  
  public void Render()
  {
    image(portal, startTileX * TILESIZE, startTileY * TILESIZE);
  }
}
