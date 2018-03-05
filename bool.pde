
void iniValues(){
  for (int k=0; k<pop; k++) {
    for (int i=0; i<n; i++) {
      for (int j=0; j<n; j++) {
        bool = trueOrFalse();
        popChamp[k][i][j] = bool;
      }
    }
  }
}

int sep = 4 ;
void displayChamp2(Boolean [][] champ){ // affiche un des éléments de la population
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      float pas = width/n;
      fill(255);
      stroke(0);
      rect( pas*i,pas*j,pas,pas);
      if(i<sep) fill(20,150,20);
      if(i>=sep) fill(255,80,80);
      noStroke();
      if (champ[i][j]) ellipse( pas*i+pas/2,pas*j+pas/2,pas/3,pas/3);
    }
  }  
}

int findPower2(Boolean [][] champ){ // ATTENTION POWER inf à N

  int n2 =int(n/2) ;
  int s = 0;
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      if((i<sep )&&( champ[i][j] )) s+=20;
      if((i>=sep )&&( !champ[i][j] )) s+=20;   
      
    }
  }
  return s;
}

void findTheBest2(){ // donne le meilleur pour l'afficher

  int temp_power = power[0];
  indexOfBest = 0;
  for (int k=0; k<pop; k++) {
    if(power[k] > temp_power){
      indexOfBest = k ;
      temp_power = power[k];
    }
  }
  PowerOfBest = temp_power ;
  ProbaOfBest = proba[indexOfBest];
}

void setPower2() { // permet de calculer les proba en settant les poids pour chaque el de la pop
  totalPowerUp = 0;
  
  for (int k=0; k<pop; k++) {
    
    power[k] = findPower2(popChamp[k]);
    totalPowerUp  += pow(power[k], pulse);   // puissance
    //print("power de champ[",k,"] : ",power[k],"\n");
  }
}


void findProba2(){  // retourne la proba de selection pour tous les parents grâce au total du poids.
  //sommeProba =0;
  for (int i=0; i<pop; i++) {
    
    proba[i] = pow(power[i],pulse)/totalPowerUp ;    // puissance
    
    //sommeProba += proba[i];
    //print("Generation n°", nbGen,",  proba[",i,"] : ",proba[i],"\n");
  }

}
////////////////////////////////////////////////////////////////////////////////////////////////////////// fortunewheel selection crossover et mutation

int fortuneWheel2(){ // enclenche la selection d'après proba[] pour un parent
  boolean go = true;
  int i =0;
  
  float tetaProgLow = 0;
  float tetaProgHigh = 2*PI*proba[0];

  float r = 2*PI*random(1);
  while(go)
  { 
    if(tetaProgLow <=r && r<=tetaProgHigh+0.01) {
      //print( "index tour", i ," : ","[ ",tetaProgLow,"<", r ,"<",tetaProgHigh, "]", "\n", "\n");  
      go = false ;
    } else {
      i +=1 ;
      tetaProgHigh += 2*PI*proba[i];
      tetaProgLow += 2*PI*proba[i-1];  
    }
  }
  //print("index choisi  : ", i , "\n");
  return i;
}

void selection2(){ // applique la seletion pour tous les parents grâce à fortuneWheel
  copiePop();
  //print("****** nouvelle génération : *****","\n");
  for (int k=0; k<pop; k++) {
   // print("_____ New element, index : ",k,   "  _____ (sommeProba : ", sommeProba,")   ");
    int indexSelected = fortuneWheel2();
    popChamp[k] = tempPopChamp[indexSelected] ;
    //print("(fct Selection)  popChamp[",k,"] ---->", "popChamp[",indexSelected,"]", "avec une proba de ",proba[k], "un poids de ",power[k],"\n");
  }  
}

void crossOver2() {   // Effectue un crossover sur chaque couple d'élément sous une conditionde proba 0.8
  int n2 = int(n/2);
  copiePop();
  
  for (int k=0; k<pop; k+=2) { 
    if(random(1)<0.8) {
      for (int i=0; i<n; i++) {      // remplissage des moitiés
        for (int j=0; j<n2; j++) {
          
          popChamp[k][i][n2+j]   = tempPopChamp[k+1][i][j] ;      // parent 1 partie 1
          popChamp[k][i][j]      = tempPopChamp[k][i][j+n2] ;   // parent 1 partie 2
          popChamp[k+1][i][n2+j] = tempPopChamp[k][i][j] ;    // parent 2 partie 1
          popChamp[k+1][i][j]    = tempPopChamp[k+1][i][j+n2];  // parent 2 partie 2   
          
        }
      }
    }
  }
}

void mutation2() {
  // Effectue une mutation pour chaque bit de chaque élément de la population sous une condition de proba 0.01
  for (int k=0; k<pop; k++) {
    for (int i=0; i<n; i++) {
      for (int j=0; j<n; j++) {
        if(random(1)<mutation) popChamp[k][i][j] = !popChamp[k][i][j];         
      }
    }
  }
}