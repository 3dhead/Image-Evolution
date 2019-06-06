PImage image;
PImage answer;

Population[] population;
int popmax;
float mutationRate;

PImage newImage(){
  PImage sampleImage = createImage(2, 2, RGB);
  sampleImage.loadPixels();
  sampleImage.pixels[0] = color(0, 0, 0);
  sampleImage.pixels[1] = color(255, 0, 0);
  sampleImage.pixels[2] = color(0, 255, 0);
  sampleImage.pixels[3] = color(0 ,0 ,255);
  sampleImage.updatePixels();
  
  return sampleImage;
}

void setup(){
  // size(687, 1024);
  size(400, 400);
  popmax = 150;
  mutationRate = 2;
  // answer = createImage(687, 1024, RGB);
  answer = createImage(100, 100, RGB);
  // answer = createImage(2, 2, RGB);
  image = loadImage("../index.png");
  //image = newImage();
  image.loadPixels();
  
  population = new Population[image.pixels.length];
  
  for(int i = 0; i < image.pixels.length; i++){
    population[i] = new Population(image.pixels[i] , mutationRate, popmax); 
  }
}

void draw(){
  for(int i = 0; i < population.length; i++){
    if(!population[i].finished()){
       population[i].naturalSelection();
       population[i].generate();
       population[i].calcFitness();
    }
  }
  displayImage();
}

void displayImage(){
  // fill the answer image with the bestDNA
  answer.loadPixels();
  for(int i = 0; i < population.length; i++){
    answer.pixels[i] = population[i].getBest(); 
  }
  answer.updatePixels();
  image(answer, 0, 0, 400, 400);
  println("Generations : " + population[0].generations);
  
  testCode();
}

void testCode(){
  float[] x = new float[4];
  color[] targetColor = new color[4];
  for(int i = 0; i < 4; i++){
    float r = red(population[i].getBest());
    float g = green(population[i].getBest());
    float b = blue(population[i].getBest());
    PVector p = new PVector(r, g, b);
    
    targetColor[i] = population[i].target;
    float rt = red(targetColor[i]);
    float gt = green(targetColor[i]);
    float bt = blue(targetColor[i]);
    PVector pt = new PVector(rt, gt, bt);
    
    x[i] = p.dist(pt);
  }
  
  stroke(targetColor[0]);
  line(0, 600, x[0]*4,600);
  
  stroke(targetColor[1]);
  line(0, 620, x[1]*4,620);
  
  stroke(targetColor[2]);
  line(0, 640, x[2]*4,640);
  
  stroke(targetColor[3]);
  line(0, 660, x[3]*4,660);
}
