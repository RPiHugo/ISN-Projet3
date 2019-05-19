/************************************************************************
 FAURE           Hugo
 TOUBLANC        Maxime
 TS2 - Projet 3 : Quiz
 
 Quiz en multijoueur
 ************************************************************************/
 
//URL du jeu
String URL = "http://sen1.2008.free.fr/ISN/Le_Grand_Quiz/Jeu_auto-ecole/";
//choix du serveur de jeu
String serveur = "Serveur1_";
//variables tampons pour la reception des donnees envoyees par le serveur PHP
String[] tampon1;
String tampon2;

//mode selectionne
int mode = 0;

//emplacement et dimention des boutons du menu
int[][] boutonsMenu = {   {350, 200, 200, 80}, 
                          {350, 320, 200, 80} };

//emplacement et dimention du bouton retour
int[] boutonRetour = {800, 550, 80, 30};

//emplacement et dimention des boutons du QCM
int[][] boutonsQuiz = {   {100, 50, 700, 200}, 
                          {100, 300, 325, 100}, 
                          {475, 300, 325, 100}, 
                          {100, 425, 325, 100}, 
                          {475, 425, 325, 100} };
  
int[] boutonDemarrer = {100, 200, 700, 200};
  
int[] boutonReinitialiser = {600, 50, 250, 50};

//marge entre le cadre et le texte
int margeTexte = 10;

color couleur_fond = color(225);           //couleur du background
color couleur_bouton = color(255, 150, 0);          //couleur des cadres des boutons
color couleur_bouton_fond = color(200);          //couleur des cadres des boutons
color couleur_bouton_select = color(0, 200, 255);    //couleur du cadre du bouton selectionne par le joueur
color couleur_bouton_vrai = color(100, 255, 0);      //couleur du cadre du bouton de la bonne reponse
color couleur_bouton_question = color(100, 0, 255);  //couleur du cadre de la question

int epaisseur_trait = 5;  //epaisseur des traits des cadres

//nombre d'images par seconde
int IPS = 20;

//s'execute une fois au demarrage du code
void setup() {
  size(900, 600);
  frameRate(IPS);
}

//s'execute en boucle
void draw() {
  switch(mode) {
    //mode 0 = menu principal
  case 0:
    affichageMode0();
    break;
    //mode 1 = jeu en solo
  case 1:
    affichageMode1();
    break;
    //mode 2 = jeu en multi
  case 2:
    affichageMode2();
    break;
  }
}

//s'execute lors d'un clic de souris
void mouseClicked() {
  switch(mode) {
  case 0: 
    clicMode0();
    break;
  case 1:
    clicMode12();
    break;
  case 2:
    clicMode12();
    break;
  }
}

//s'execute lors d'un appui sur une touche de clavier
void keyTyped() {
  switch(mode) {
  case 0: 
    break;
  case 2:
    if (pret == false) {
      joueurPret();
    }
    break;
  }
}
