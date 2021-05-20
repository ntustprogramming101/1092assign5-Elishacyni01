class Cabbage{
  // Properties
  float[] cabbageX, cabbageY;
  // Methods
  // Init Cabbage
  void initCabbages(){
    cabbageX = new float[6];
    cabbageY = new float[6];
  
    for(int i = 0; i < cabbageX.length; i++){
      cabbageX[i] = SOIL_SIZE * floor(random(SOIL_COL_COUNT));
      cabbageY[i] = SOIL_SIZE * ( i * 4 + floor(random(4)));
    }
  }
  // constructor
}
