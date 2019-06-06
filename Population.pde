class Population{
  
  color target;
  float mutationRate;
  DNA[] population;
  ArrayList<DNA> matingPool;
  
  int generations;
  boolean finished;
  int perfectScore;
  
  Population(color tclr, float mr, int num){
    
    target = tclr;
    population = new DNA[num];
    mutationRate = mr;
    
    for(int i = 0; i < num; i++){
      population[i] = new DNA(); 
    }
    calcFitness();
    matingPool = new ArrayList<DNA>();
    finished = false;
    generations = 1;
    
    perfectScore = 1;
  }

  void calcFitness(){
    for(int i = 0; i < population.length ; i++){
      population[i].fitness(target); 
    }
  }
  
  //generate a mating pool
 void naturalSelection(){
  //clear the arraylist
  matingPool.clear();
  
  //getting the maximum fitness
  float maxFitness = 0;
  for(int i = 0; i < population.length; i++){
    if(population[i].fitness > maxFitness){
     maxFitness = population[i].fitness; 
    }
  }

  
  //based on above fitness, we will add poopulation in the mating pool
  // higher fitness, higher number of element in the mating pool
  for(int i = 0; i < population.length ; i++){
   float fitness = map(population[i].fitness, 0, maxFitness, 0, 1);
   int n = int(fitness * 100);
   for(int j = 0; j < n; j++){
    matingPool.add(population[i]); 
   }
  }
 } 
  // Create a new generation, replacing the old one
 void generate(){
   for(int i = 0; i < population.length; i++){
    int index1 = int(random(matingPool.size()));
    int index2 = int(random(matingPool.size()));
    
    DNA partnerA = matingPool.get(index1);
    DNA partnerB = matingPool.get(index2);
    DNA child = partnerA.crossover(partnerB);
    child.mutate(mutationRate);
    population[i] = child;
   }
   generations++;
 }
 
 //computing the "most fit" member of the poplation
 color getBest(){
  float worldRecord = 0.0;
  int index = 0;
  for(int i = 0; i < population.length ; i++){
   if(population[i].fitness > worldRecord){
    index = i;
    worldRecord = population[i].fitness;
   }
  }
  
  if(worldRecord == perfectScore) finished = true;
  
  return population[index].gene;
 }
 
 boolean finished(){
  return finished; 
 }
  
 int getGenerations(){
  return generations; 
 }
  
  // Compute average fitness for the population
  float getAverageFitness() {
    float total = 0;
    for (int i = 0; i < population.length; i++) {
      total += population[i].fitness;
    }
    return total / (population.length);
  }
  
}
