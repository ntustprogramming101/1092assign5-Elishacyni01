class Soil{
  // Properties
  final int SOIL_COL_COUNT = 8;
  final int SOIL_ROW_COUNT = 24;
  
  
  int[][] soilHealth;
  
  // Methods
  
  // Load PImage[][] soils
  void load(){
    soils = new PImage[6][5];
    for(int i = 0; i < soils.length; i++){
      for(int j = 0; j < soils[i].length; j++){
        soils[i][j] = loadImage("img/soils/soil" + i + "/soil" + i + "_" + j + ".png");
      }
    }
  }
  
  // Init Soils
  void initSoils(){
    soilHealth = new int[SOIL_COL_COUNT][SOIL_ROW_COUNT];
  
    int[] emptyGridCount = new int[SOIL_ROW_COUNT];
  
    for(int j = 0; j < SOIL_ROW_COUNT; j++){
      emptyGridCount[j] = ( j == 0 ) ? 0 : floor(random(1, 3));
    }
  
    for(int i = 0; i < soilHealth.length; i++){
      for (int j = 0; j < soilHealth[i].length; j++) {
         // 0: no soil, 15: soil only, 30: 1 stone, 45: 2 stones
        float randRes = random(SOIL_COL_COUNT - i);
        
        if(randRes < emptyGridCount[j]){
          soilHealth[i][j] = 0;
          emptyGridCount[j] --;
        }else{
          soilHealth[i][j] = 15;
          if(j < 8){
            if(j == i) soilHealth[i][j] = 2 * 15;
          }else if(j < 16){
            int offsetJ = j - 8;
            if(offsetJ == 0 || offsetJ == 3 || offsetJ == 4 || offsetJ == 7){
              if(i == 1 || i == 2 || i == 5 || i == 6){
                soilHealth[i][j] = 2 * 15;
              }
            }else{
              if(i == 0 || i == 3 || i == 4 || i == 7){
                soilHealth[i][j] = 2 * 15;
              }
            }
          }else{
            int offsetJ = j - 16;
            int stoneCount = (offsetJ + i) % 3;
            soilHealth[i][j] = (stoneCount + 1) * 15;
          }
        }
      }
    }
  }
  
  
  // Display Soil
  void display(){
    for(int i = 0; i < SOIL_COL_COUNT; i++){
      for(int j = 0; j < SOIL_ROW_COUNT; j++){

        if(soilHealth[i][j] > 0){

          int soilColor = (int) (j / 4);
          int soilAlpha = (int) (min(5, ceil((float)soilHealth[i][j] / (15 / 5))) - 1);

          image(soils[soilColor][soilAlpha], i * SOIL_SIZE, j * SOIL_SIZE);

          if(soilHealth[i][j] > 15){
            int stoneSize = (int) (min(5, ceil(((float)soilHealth[i][j] - 15) / (15 / 5))) - 1);
            image(stones[0][stoneSize], i * SOIL_SIZE, j * SOIL_SIZE);
          }

          if(soilHealth[i][j] > 15 * 2){
            int stoneSize = (int) (min(5, ceil(((float)soilHealth[i][j] - 15 * 2) / (15 / 5))) - 1);
            image(stones[1][stoneSize], i * SOIL_SIZE, j * SOIL_SIZE);
          }

        }else{
          image(soilEmpty, i * SOIL_SIZE, j * SOIL_SIZE);
        }

      }
    }
    
    // Soil background past layer 24
    for(int i = 0; i < SOIL_COL_COUNT; i++){
      for(int j = SOIL_ROW_COUNT; j < SOIL_ROW_COUNT + 4; j++){
        image(soilEmpty, i * SOIL_SIZE, j * SOIL_SIZE);
      }
    }
    image(sweethome, 0, SOIL_ROW_COUNT * SOIL_SIZE);
  }
  
  // Constructor
  
  
  
}
