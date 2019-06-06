// A DNA is a color(r,g,b)
class DNA{
 color gene;
 float fitness;
 
 DNA(){
  gene = color((int)random(256), (int)random(256), (int)random(256));
 }
 
  
 //calculates the fitness of the gene
 void fitness(color target){
     PVector thisv = new PVector(red(gene), green(gene), blue(gene));
     PVector targetv = new PVector(red(target), green(target), blue(target));
     
     float distance = thisv.dist(targetv);
     
     PVector origin = new PVector(0, 0, 0);
     PVector corner = new PVector(255, 255, 255);
     float maxDistance = origin.dist(corner);
     
     fitness = map(distance, 0, maxDistance, 1, 0);
 }
 
 DNA crossover(DNA partner){
   DNA child = new DNA();
   float thisr = red(this.gene);
   float thisg = green(this.gene);
   float thisb = blue(this.gene);
   
   float partnerr = red(partner.gene);
   float partnerg = green(partner.gene);
   float partnerb = blue(partner.gene);
   
   float childr = (thisr + partnerr)/2;
   float childg = (thisg + partnerg)/2;
   float childb = (thisb + partnerb)/2;
   child.gene = color(childr, childg, childb);
   
   return child;
 }
 
 ////mutation function
 //void mutate(float mutationRate){
 //  for(int i = 0; i < 3; i++){
 //    if(random(1) < mutationRate){
    
 //      if(i == 0){
 //        this.gene = color((int)random(256), green(this.gene), blue(this.gene));
 //      }
 //      if(i == 1){
 //        this.gene = color(red(this.gene), int(random(0, 256)), blue(this.gene));   
 //      }
 //      if(i == 2){
 //        this.gene = color(red(this.gene), green(this.gene), int(random(0,256)));
 //      }
 //    }
 //  }
   
   
   //mutation function
 void mutate(float mutationRate){
   if(random(1) < mutationRate){
       gene = color(int(random(0, 256)), int(random(0, 256)), int(random(0, 256)));
   }
 }
}
