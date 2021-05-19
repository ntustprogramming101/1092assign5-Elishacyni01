class Stone{
  // Properties
  
  
  
  // Methods
  
  // Load PImage[][] stones
  void load(){
    stones = new PImage[2][5];
    for(int i = 0; i < stones.length; i++){
      for(int j = 0; j < stones[i].length; j++){
        stones[i][j] = loadImage("img/stones/stone" + i + "/stone" + i + "_" + j + ".png");
      }
    }
  }
  
  
  // Constructor
}
