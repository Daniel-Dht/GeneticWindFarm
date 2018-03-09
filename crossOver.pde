void copiePop() {
  for (int k=0; k<pop; k++) {    
    for (int i=0; i<n; i++) {      // remplissage de la copie de la population
       for (int j=0; j<n; j++) {   
         tempPopChamp[k][i][j] = popChamp[k][i][j];
       }
    }
  }  
}


void crossOver3() {   // crossOver case par case 
// Effectue un crossover sur chaque couple d'élément sous une conditionde proba 0.8
// On est obligé d'utiliser une copie membre par membre, même problême que les listes de python sinon
  copiePop();   
  for (int k=0; k<pop; k+=2) { 
    if(random(1)<0.8) {
      
      for (int i=0; i<n; i++) {     
        for (int j=0; j<n; j++) {   
          
          if(random(1)<0.5){ // prend une case du parent 1 avec une proba 0.5
           popChamp[k][i][j] = tempPopChamp[k][i][j] ;
           popChamp[k+1][j][j] = tempPopChamp[k+1][i][j] ;
         } else { // la même chose avec le deuxième parent
           popChamp[k][i][j] = tempPopChamp[k+1][i][j] ;
           popChamp[k+1][j][j] = tempPopChamp[k][i][j] ;  
         }
        }
      }  
    }
  }
}

void crossOver2() {  // crossOver demie tableau par demi tableau (pas terrible), mais fonctionne très bien pour les config actuelles
  // Effectue un crossover sur chaque couple d'élément sous une conditionde proba 0.8
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