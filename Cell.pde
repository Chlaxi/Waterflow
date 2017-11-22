class Cell {
  int x, y;
  public float strength;
  public String type;
  boolean continous = false;

  Cell(int x, int y, String type, int strength)
  { 
    this.x = x;
    this.y = y;
    this.strength = strength;
    this.type = "Void";
  }

  boolean isWater()
  {
    return type == "Water";
  }

  boolean isVoid()
  {
    return type == "Void";
  }

  boolean isGround()
  {
    return type == "Ground";
  }

  void setToWater(int strength) {
    this.strength = strength;
    type = "Water";
  }
  
   void setToWater() {
     println("cont source created");
    strength = 255;
    type = "Water";
    continous = true;
  }

  void UpdateCell() {
    if (strength ==0 && isWater()) {
      type="Void";
    }
    if (strength > 0 && isVoid())
    {
      type = "Water";
    }
  }

  void DrawCell(int size) {
    strength = constrain(strength, 0, 255);
    UpdateCell();
    switch(type) {
    case "Water" : 
      fill(170, 200, 247, strength);
      if(continous)
      {
        fill(170, 255, 247);
      }
      break;
    case "Ground" :
      strength = 0;
      fill(0, 226, 90);
      break;
    case "Void": 
      fill(25, 25, 25);
      break;
    case "Border" :
      fill(30, 175, 25);
      break;
    }  
    rect(x*size, y*size, size, size);

    if (DebugMode) {
      fill(255, 0, 0);
      text((int)strength, x*size, 15+(y*size));
    }
  }

  void drain(int nb) {
    if (strength > nb && !continous)
    {
      strength -=  nb;
    }
  }
}