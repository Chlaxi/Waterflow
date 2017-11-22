private boolean loop = false;
int w = 40;
int gen = 0;

public static boolean DebugMode = false;
public static int FlowSpeed=2;

Map map;
void setup() {
  size(800, 800); 
  map = new Map(w);
  frameRate(60);
}

void draw()
{

  map.DrawMap();
  if (loop) {
    map.generate();

    gen++;
  }
  println(gen+"----------- Speed: " +FlowSpeed);
  if (loop) { 
    fill(25, 255, 25);
  } else {
    fill(255, 25, 25);
  }
  text("(Controls: W/S) Flow speed: "+FlowSpeed+"  | (Space) Looping? "+loop, 5, 15);
  text("Left click to create terrain (dragable). Right clicking creates water. If you right click on water, it switches between permanent or not.", 5, 30);
  text("Made by Chloe Parbst", width/2, height-20);
}

void mousePressed() {
  String type = map.GetType();
  if (mouseButton == RIGHT)
  {
    map.CellTypeChanger("Water");
  } else {
    map.CellTypeChanger("Ground");
  }
}

void keyReleased() {
  if (key == 'r')
  {
    map = new Map(w);
  }
  if (key == 'a')
  {
    map.CellTypeChanger("ContWater");
  }
  if (key == 'd') {
    DebugMode = !DebugMode;
  }
  if (key == 'w')
  {
    FlowSpeed++;
  }
  if (key == 's')
  {
    FlowSpeed--;
  }
  if (key == ' ')
  {
    loop = !loop;
  }
}