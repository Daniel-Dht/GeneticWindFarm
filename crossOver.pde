void copiePop() {
  for (int k=0; k<pop; k++) {    
    for (int i=0; i<n; i++) {      // remplissage de la copie de la population
       for (int j=0; j<n; j++) {   
         tempPopChamp[k][i][j] = popChamp[k][i][j];
       }
    }
  }  
}


void crossOver3() {   // Effectue un crossover sur chaque couple d'élément sous une conditionde proba 0.8
  copiePop();
  
  for (int k=0; k<pop; k+=2) { 
    if(random(1)<0.8) {
      
      for (int i=0; i<n; i++) {      // remplissage des moitiés
        for (int j=0; j<n; j++) {   
          
          if(random(1)<0.5){
           popChamp[k][i][j] = tempPopChamp[k][i][j] ;
           popChamp[k+1][j][j] = tempPopChamp[k+1][i][j] ;
         } else {
           popChamp[k][i][j] = tempPopChamp[k+1][i][j] ;
           popChamp[k+1][j][j] = tempPopChamp[k][i][j] ;  
         }
        }
      }  
      

    }
  }
}