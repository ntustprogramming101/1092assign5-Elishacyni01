class Soldier{
  // Properties
  float[] soldierX, soldierY;
  float soldierSpeed = 2f;
  
  
  // Methods
  
  // Init Soldier
  void initSoldiers(){
    soldierX = new float[6];
    soldierY = new float[6];
  
    for(int i = 0; i < soldierX.length; i++){
      soldierX[i] = random(-SOIL_SIZE, width);
      soldierY[i] = SOIL_SIZE * ( i * 4 + floor(random(4)));
    }
  }
  // Constructor
}
