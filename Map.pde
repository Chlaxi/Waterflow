class Map {

  int cellSize;
  int columns, rows;

  Cell[][] cells;

  public Map(int c) {
    cellSize=c;
    columns = width/c;
    rows = height/c;
    cells = new Cell[columns][rows];
    Init();
  }

  void Init() {
    for (int i=0; i<columns; i++) {
      for (int j=0; j<rows; j++) {
        cells[i][j] = new Cell(i, j, "Void", 0);
      }
    }
    cells[1][1].setToWater();
    cells[columns-2][rows-2].setToWater();
    cells[columns-2][1].setToWater();
    cells[1][rows-2].setToWater();
    InitBoundary();
  }

  void InitBoundary() {

    for (int i=0; i<rows; i++) {
      cells[i][0].type = "Border";
      cells[i][rows-1].type = "Border";
    }
    for (int i=0; i<columns; i++) {
      cells[0][i].type = "Border";
      cells[columns-1][i].type = "Border";
    }
    DrawMap();
  }

  void generate() {
    for (int x = 1; x < columns-1; x++) {
      for (int y = 1; y < rows-1; y++) {
        if (cells[x][y].isWater())
        { 
          WaterExpansion(x, y);
        }
      }
    }
  }

  void WaterExpansion(int x, int y) {
    Cell[] neighbours = GetNeighbours(x, y);
    if (neighbours.length !=0) {
      FillNeighbours(neighbours, x, y);
      cells[x][y].drain(neighbours.length*FlowSpeed);
    }
  }


  Cell[] GetNeighbours(int x, int y) {
    int neighbours=0;  
    Cell[] nb;// = {cells[x-1][y], cells[x][y-1], cells[x+1][y], cells[x][y+1]};  
    ArrayList<Cell> nbList = new ArrayList<Cell>();

    if (ShouldFlow(cells[x-1][y], x, y))
    {
      nbList.add(cells[x-1][y]);  //left
    }
    if (ShouldFlow(cells[x][y-1], x, y))
    {
      nbList.add(cells[x][y-1]);  //top
    }
    if (ShouldFlow(cells[x+1][y], x, y))
    {
      nbList.add(cells[x+1][y]);  //right
    }

    if (ShouldFlow(cells[x][y+1], x, y))
    {
      nbList.add(cells[x][y+1]);  //down
    }

    nb = nbList.toArray(new Cell[nbList.size()]);
    return nb;
  }


  boolean ShouldFlow(Cell nb, int x, int y) 
  {
    return (nb.isVoid() || (nb.isWater() && nb.strength < cells[x][y].strength));
  }

  void FillNeighbours(Cell[] nb, int x, int y) {

    if (cells[x][y].strength > nb.length)
    { 
      for (int i = 0; i < nb.length; i++) {
        nb[i].strength += FlowSpeed;
      }
    }
  }

  void DrawMap() {
    int waterFlow = 0;
    background(25, 25, 25);
    for (int i=1; i<columns-1; i++) {
      for (int j=1; j<rows-1; j++) {
        cells[i][j].DrawCell(cellSize);
        waterFlow += cells[i][j].strength;
      }
    }
    println(waterFlow+"/"+(columns+rows)*255);
  }


  boolean checkMouse(int x, int y, int c) 
  {
    return mouseX > x && mouseX < x+c && mouseY > y && mouseY < y+c;
  }

  String GetType()
  {

    for (int i=1; i<columns-1; i++) {
      for (int j=1; j<rows-1; j++) {
        if (checkMouse(i*cellSize, j*cellSize, cellSize)) {
          return cells[i][j].type;
        }
      }
    }
    return null;
  }


  void CellTypeChanger(String type)
  {
    for (int i=1; i<columns-1; i++) {
      for (int j=1; j<rows-1; j++) {
        if (checkMouse(i*cellSize, j*cellSize, cellSize)) {
           if(cells[i][j].isGround()){
               cells[i][j].type = "Void";
               cells[i][j].strength = 0;
               break;
            }
          if (type == "Water") {
            if(cells[i][j].isWater())
            {
               cells[i][j].continous = !cells[i][j].continous;
            }
            cells[i][j].setToWater(255);
            break;
          }
          if(type == "ContWater")
          {
            cells[i][j].setToWater();
            break;
          }
          else{
            cells[i][j].type = type;
          }
          break;
        }
      }
    }
  }
}