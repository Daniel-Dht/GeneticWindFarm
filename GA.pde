
int n=10; //TAILLE DU CHAMP 
int pop = 1000; // taille d'une génération

int indexOfBest ;               // index du meilleur élément
int PowerOfBest;                // Poid du meilleur élément
float ProbaOfBest ;            // proba du meilleur élément

int[] power = new int[pop];     // liste du poids des éléments de la population
float totalPowerUp=0;   //total du poids afin de calculer les proba de selection 
float[] proba = new float[pop] ;// proba d'apparition des chaque élément dans la selection naturelle


Boolean[][][] popChamp = new Boolean[pop][n][n]; // liste de la population
Boolean[][] popChampInit = new Boolean[n][n]; // liste de la population initiale
Boolean[][][] tempPopChamp = new Boolean[pop][n][n];  // copie de la liste de la population pour effectuer les corssOver correctement
Boolean bool ; // permet d'inialitser la première génération

int nbGen =0; // compteur de génération
int powerMaxOfEvolution =0; // compteur du poids du meilleur élément intergénérationnel
//float sommeProba =0 ; // debug tool

int pulse =8; // intensité de la séparation des bons éléments des faibles 
float mutation = 0.001; // proba de mutation de chaque bit

int powerStop = n*n*20; // si on atteint ce max, le loop se stop A MODIFIE SI MODIF DE LA FCT FITNESS

void setup(){  //********************************************  SETUP *************************************************************
  size(800,800);
  background(220);
  iniValues(); // on initialise la première génération
}

Boolean go =true;
void draw() {//********************************************  LOOP *************************************************************

   if (go) {
   
     //go=false; // décommenter si on veut faire génération par génération pour observer le comportement de l'algo
     
     process(); // processus de l'algo de génétic
     
   }
   if (keyPressed) go =true;

   if(powerMaxOfEvolution == powerStop ) {
     go =false;
     displayChampInit(popChampInit);
   }
}



void process() {      //********************************************  Main  *************************************************************
  
     setPower2();
       
     findTheBest2(); // on cherche le meilleur élément de la génration
     displayChamp2(popChamp[indexOfBest]); // on l'affiche
     if(powerMaxOfEvolution<PowerOfBest) powerMaxOfEvolution = PowerOfBest ;   // détermine si c'est meilleur (intergénérationnel)
     
     print("**************      Generation n°", nbGen, "     POWER MAX : ", powerMaxOfEvolution, "   current power : ", PowerOfBest, " --> proba : ", ProbaOfBest,"******************\n");  
     //print("  Generation n°", nbGen,"\n");
     
     findProba2();
     selection2();
     crossOver2();
     mutation2() ;  // fin de traitement de génération
     
     nbGen +=1 ;
  
}


Boolean trueOrFalse(){ // permet d'initialiser la première génération dans initValues()
  float r = random(1);
  if(r<0.5) {
    return true;
  } else {
    return false;
  }
}