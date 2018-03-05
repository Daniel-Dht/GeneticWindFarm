
//************  int test  *************//
//*************************************//                              stat : n=14,pop=1000, mutation=0.0001  => 6625 générations 
//*************************************//                              stat : n=10,pop=1000, mutation=0.001  => 1645,1116,986,820,771,675,675,595,590,579,492,480,459,449 générations   

int n=10; //TAILLE DU CHAMP 
int pop = 1000; // taille d'une génération

int indexOfBest ;               // index du meilleur élément
int PowerOfBest;                // Poid du meilleur élément
float ProbaOfBest ;            // proba du meilleur élément

int[] power = new int[pop];     // power de la population
float totalPower;      //total du poids afin de calculer les proba de selection
float totalPowerUp=0;   //total du poids afin de calculer les proba de selection amélioré
float[] proba = new float[pop] ;// proba d'apparition des chaque élément dans la selection naturelle


Boolean[][][] popChamp = new Boolean[pop][n][n]; // liste de la population
Boolean[][][] tempPopChamp = new Boolean[pop][n][n];  // copie de la liste de la population
Boolean bool ; // permet d'inialitser la première génération

int nbGen =0; // compteur de génération
int powerMaxOfEvolution =0; // compteur du poids du meilleur élément intergénérationnel
//float sommeProba =0 ; // debug tool

int pulse =6; // intensité de la séparation des bons éléments des failes
float mutation = 0.001;

int powerStop = n*n*20;

void setup(){  //********************************************  SETUP *************************************************************
  size(800,800);
  background(220);
  
  iniValues();
 
}

Boolean go =true;
int count =1;

void draw() {//********************************************  LOOP *************************************************************

   if (go) {
   
     //go=false;
     
     process();
     
   }
   if (keyPressed) go =true;

   //go =true ;
   if(powerMaxOfEvolution == powerStop ) go =false;
}



void process() {      //********************************************  Main  *************************************************************
  
     setPower2();
       
       findTheBest2();
       displayChamp2(popChamp[indexOfBest]);
       if(powerMaxOfEvolution<PowerOfBest) powerMaxOfEvolution = PowerOfBest ;   
       
     print("**************      Generation n°", nbGen, "     POWER MAX : ", powerMaxOfEvolution, "   current power : ", PowerOfBest, " --> proba : ", ProbaOfBest,"******************\n");  
     //print("  Generation n°", nbGen,"\n");
     
     findProba2();
     selection2();
     crossOver2();
     mutation2() ;  // fin de traitement de génération
     
     nbGen +=1 ;
  
}


Boolean trueOrFalse(){ // permet d'initialiser la première génération
  float r = random(1);
  if(r<0.5) {
    return true;
  } else {
    return false;
  }
}