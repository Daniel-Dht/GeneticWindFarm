
void iniValues(){ // Initialise la première génération aléatoirement
  for (int k=0; k<pop; k++) {
    for (int i=0; i<n; i++) {
      for (int j=0; j<n; j++) {
        bool = trueOrFalse();
        popChamp[k][i][j] = bool;
        popChampInit[i][j] = bool;
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

int findPower2(Boolean [][] champ){ // FONCTION FITNESS

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

void findTheBest2(){ // donne le meilleur élément pour l'afficher

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

void setPower2() { // permet de calculer les proba en settant les poids pour chaque élément de la pop
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
  // fonction consruite sur le même principe qu'une véritable roue de la fortune
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

void displayChampInit(Boolean [][] champ){ 
// affiche le meilleur un des élément de la population initiale (génération 0), une fois l'algo fini
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      float pas = width/n;
      noFill();
      stroke(20,80,255);
      if (champ[i][j]) ellipse( pas*i+pas/2,pas*j+pas/2,pas/2,pas/2);
    }
  }  
}