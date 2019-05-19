/************************************************************************
 FAURE           Hugo
 TOUBLANC        Maxime
 TS2 - Projet 3 : Quiz
 
 Quiz en multijoueur
 ************************************************************************/
 
//URL du jeu
String URL = "http://sen1.2008.free.fr/ISN/Le_Grand_Quiz/Jeu_numerique/";
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
/********************************************************
 CODE COMMUN AUX MODES 1 ET 2
 *********************************************************/

//timer pour savoir quand demander une nouvelle question
int tempsQuestion;
//numero de la reponse choisie par l'utilisateur, 0 = pas de reponse
int reponseChoisie = 0;
//nombre de secondes ecoulees depuis la nouvelle question
int seconde = 0;
//score du joueur
int score = 0;
//tableau pour recevoir en 0 la question, en 1 2 3 et 4 les reponses et en 5 le numero de la bonne reponse
String[] question = new String[6];

//affichage du bouton retour
void affichageBoutonRetour() {
  fill(couleur_bouton_fond);  
  stroke(couleur_bouton);
  strokeWeight(epaisseur_trait);
  rect(boutonRetour[0], boutonRetour[1], boutonRetour[2], boutonRetour[3]);
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  //texte dans le bouton
  text("Retour", boutonRetour[0], boutonRetour[1]-5, boutonRetour[2], boutonRetour[3]+5);
}

//affichage des cadres pour les questions et reponses
void dessinCadres() {
  fill(couleur_bouton_fond);  
  strokeWeight(epaisseur_trait);

  //affichage des 5 cadres
  for (int bouton = 0; bouton < 5; bouton++) {
    if (bouton != 0 && bouton == reponseChoisie) {
      stroke(couleur_bouton_select);
    } else {
      if (bouton == 0) {
        stroke(couleur_bouton_question);
      } else {
        stroke(couleur_bouton);
      }
    }
    rect(boutonsQuiz[bouton][0], boutonsQuiz[bouton][1], boutonsQuiz[bouton][2], boutonsQuiz[bouton][3]);
  }

  //affiche la bonne reponse au bout de 10 secondes
  if (seconde <= 3 && int(question[5]) != 0) {
    stroke(couleur_bouton_vrai);
    rect(boutonsQuiz[int(question[5])][0], boutonsQuiz[int(question[5])][1], boutonsQuiz[int(question[5])][2], boutonsQuiz[int(question[5])][3]);
  }

  //affichage de la barre du temps
  if (seconde >= 3) {
    fill(couleur_bouton);
    noStroke();
    rect(100, 25, (seconde - 3) * 70, 10);
  }
}

//ecriture du texte dans les cadres
void afficherQuestions() {
  fill(0);
  textSize(18);
  textAlign(CENTER, TOP);
  //ecrit le texte de chaque question dans le cadre correspondant
  for (int rep = 0; rep <= 4; rep++) {
    text(question[rep], boutonsQuiz[rep][0] + margeTexte, boutonsQuiz[rep][1] + margeTexte, boutonsQuiz[rep][2] - 2*margeTexte, boutonsQuiz[rep][3] - 2*margeTexte);
  }
  textSize(20);
  textAlign(LEFT, TOP);
  text("Score : " + score, 50, 550);
}

//permet de voir si un bouton a ete clique
void clicMode12() {
  //Clic sur le bouton retour
  if (mouseX > boutonRetour[0]
    && mouseY > boutonRetour[1]
    && mouseX < boutonRetour[0] + boutonRetour[2]
    && mouseY < boutonRetour[1] + boutonRetour[3]) {
    //si le mode etait le mode 2, on supprime l'ancien identifiant du joueur
    if (mode==2) {
      pret = false;
      supprimerID();
    }
    //inutile si on est en mode 1 car il n'y a pas d'identifiant
    mode = 0;
  }

  //enregistre quel bouton a ete clique et donc quelle reponse a ete choisie
  if (seconde >= 3) {
    for (int bouton = 1; bouton <= 4; bouton++) {
      if (mouseX > boutonsQuiz[bouton][0]
        && mouseY > boutonsQuiz[bouton][1]
        && mouseX < boutonsQuiz[bouton][0] + boutonsQuiz[bouton][2]
        && mouseY < boutonsQuiz[bouton][1] + boutonsQuiz[bouton][3]) {
        reponseChoisie = bouton;
      }
    }
  }

  //lance le jeu si l'utilisateur clique sur le bouton
  if (pret == false && mode == 2) {
    if (mouseX > boutonDemarrer[0]
      && mouseY > boutonDemarrer[1]
      && mouseX < boutonDemarrer[0] + boutonDemarrer[2]
      && mouseY < boutonDemarrer[1] + boutonDemarrer[3]) {
      pret = true;
      lancerJeu();
    }
  }
}

/********************************************************
 MODE 0 : MENU PRINCIPAL
 *********************************************************/

//affichage du menu
void affichageMode0() {
  background(couleur_fond);
  fill(couleur_bouton_fond);  
  stroke(couleur_bouton);
  strokeWeight(epaisseur_trait);
  
  //affichage des deux boutons de jeu
  for (int bouton=0; bouton<2; bouton++) {
    rect(boutonsMenu[bouton][0], boutonsMenu[bouton][1], boutonsMenu[bouton][2], boutonsMenu[bouton][3]);
  }
  //dessin du cadre du bouton reinitialiser
  rect(boutonReinitialiser[0], boutonReinitialiser[1], boutonReinitialiser[2], boutonReinitialiser[3]);
  
  //affichage du texte dans chaque bouton
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Jeu en Solo", boutonsMenu[0][0], boutonsMenu[0][1], boutonsMenu[0][2], boutonsMenu[0][3]);
  text("Jeu en Multi", boutonsMenu[1][0], boutonsMenu[1][1], boutonsMenu[1][2], boutonsMenu[1][3]);
  text("Reinitialiser serveur " + serveur.substring(7, 8), boutonReinitialiser[0], boutonReinitialiser[1], boutonReinitialiser[2], boutonReinitialiser[3]);
}

//permet de voir si un bouton a ete clique
void clicMode0() {
  //demarrage du jeu en solo
  if (mouseX > boutonsMenu[0][0]
    && mouseY > boutonsMenu[0][1]
    && mouseX < boutonsMenu[0][0] + boutonsMenu[0][2]
    && mouseY < boutonsMenu[0][1] + boutonsMenu[0][3]) {
    changerMode1();
  }

  //demarrage du jeu en multi
  if (mouseX > boutonsMenu[1][0]
    && mouseY > boutonsMenu[1][1]
    && mouseX < boutonsMenu[1][0] + boutonsMenu[1][2]
    && mouseY < boutonsMenu[1][1] + boutonsMenu[1][3]) {
    changerMode2();
  }
  
  //reinitialise le serveur multijoueur
  if (mouseX > boutonReinitialiser[0]
    && mouseY > boutonReinitialiser[1]
    && mouseX < boutonReinitialiser[0] + boutonReinitialiser[2]
    && mouseY < boutonReinitialiser[1] + boutonReinitialiser[3]) {
    reinitialiserServeur();
  }
}

//changer le mode de jeu avec le mode 1 : solo
void changerMode1() {
  mode = 1;
  tempsQuestion = frameCount % IPS;
  seconde = 13;
  score = 0;
  //demande d'une nouvelle question au serveur
  demandeQuestionSolo();
}

//changer le mode de jeu avec le mode 2 : multijoueur
void changerMode2() {
  mode = 2;
  //demande d'un identifiant pour jouer en multijoueur delivre par le serveur
  demandeID();
  pret = false;
}

//reinitialisaiton du serveur multijoueur
void reinitialiserServeur() {
  print("Reinitialisation du serveur " + serveur.substring(7, 8) + ". ");
  //Envoi du score
  tampon1 = loadStrings(URL + serveur + "Reinitialiser" + ".php");

  //on transforme le tableau de Strings en 1 seul String
  tampon2 = "";
  for (int i=0; i<tampon1.length; i++) {
    tampon2 += tampon1[i];
  }

  println(tampon2);
}

//demande d'un identifiant de multijoueur au serveur
void demandeID() {
  println("Demande d'identifiant.");
  //demande d'un identifiant
  tampon1 = loadStrings(URL + serveur + "Connect" + ".php");

  //on transforme le tableau de Strings en 1 seul String
  tampon2 = "";
  for (int i=0; i<tampon1.length; i++) {
    tampon2 += tampon1[i];
  }

  //enregistrement de l'identifiant du joueur si le serveur n'est pas plein
  if (int(tampon2) == 5) {
    println("Le serveur est dejà plein");
  } else {
    id = int(tampon2);
    println("Votre ID est : " + id);
  }
}
/********************************************************
 MODE 1 : JEU EN SOLO
 *********************************************************/

//affichage du jeu en multi
void affichageMode1() {
  background(couleur_fond);

  //affichage du bouton retour
  affichageBoutonRetour();

  //si le temps restant est nul, demander une nouvelle question et reinitialiser le temps, attribuer les points
  if (seconde == 0) {
    if (reponseChoisie == int(question[5])) {
      score++;
    }
    demandeQuestionSolo();
    seconde = 13;
  }
  //affiche les cadres des questions
  dessinCadres();
  //affiche le texte des questions dans les cadres
  afficherQuestions();

  //timer pour le nombre de secondes ecoulees depuis la question
  if (frameCount % IPS == tempsQuestion) {
    seconde--;
  }
}

//demande d'une nouvelle question au serveur
void demandeQuestionSolo() {
  println("Demande d'une question.");
  //demande du texte au serveur
  tampon1 = loadStrings(URL + serveur + "Solo" + ".php");

  //on transforme le tableau de Strings en 1 seul String
  tampon2 = "";
  for (int i=0; i<tampon1.length; i++) {
    tampon2 += tampon1[i];
  }

  //on vide le tableau de String question
  for (int emplacement = 0; emplacement < question.length; emplacement++) {
    question[emplacement] = "";
  }

  //on divise le texte recu en 6, la question en 0, les reponses en 1 à 4, et le numero de la bonne reponse en 5
  question = split(tampon2, ";");

  reponseChoisie = 0;
}
/********************************************************
 MODE 2 : JEU EN MULTIJOUEURS
 *********************************************************/

//identifiant du joueur
int id = 0;
//demarre la partie une fois qu'un joueur le demande
boolean pret = false;

//affichage du jeu en multi
void affichageMode2() {
  background(couleur_fond);

  //affichage de l'identifiant du joueur
  affichageID();

  //affichage du bouton retour
  affichageBoutonRetour();

  //commence le jeu lorsque tout le monde est pret
  if (pret == true) {
    if (seconde == 0) {
      if (reponseChoisie == int(question[5]) && int(question[5]) != 0) {
        score++;
      }
      demandeQuestionMulti();
      envoiScore();
      if (int(question[5]) != 0) {
        seconde = 13;
      }
    }
    //timer pour le nombre de secondes ecoulees depuis la question
    if (frameCount % IPS == tempsQuestion) {
      if (int(question[5]) != 0) {
        seconde--;
      }
    }
    //affiche les cadres des questions
    dessinCadres();
    //affiche le texte des questions dans les cadres
    afficherQuestions();
  } else {
    fill(couleur_bouton_fond);  
    stroke(couleur_bouton);
    strokeWeight(epaisseur_trait);
    rect(boutonDemarrer[0], boutonDemarrer[1], boutonDemarrer[2], boutonDemarrer[3]);
    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Pour commencer la partie appuyez sur ENTER\nou cliquez sur ce bouton.", boutonDemarrer[0], boutonDemarrer[1], boutonDemarrer[2], boutonDemarrer[3]);
    //tant que le joueur ne dit pas qu'il est prêt, verifie si un autre joueur n'a pas lance la partie
    lancerJeu();
  }
}

//affiche l'identifiant du joueur s'il en a un
void affichageID() {
  if (id > 0) {
    fill(0);
    textSize(20);
    textAlign(CENTER, TOP);
    text("Votre identifiant est : " + id, 250, 550, 400, 50);
  } else {
    fill(0);
    textSize(20);
    textAlign(CENTER, TOP);
    text("Le serveur est plein.", 250, 550, 400, 50);
  }
}

//change la valeur de pret lorque le joueur appuie sur la touche ENTER et lance le jeu
void joueurPret() {
  if (key == ENTER) {
    pret = true;
    lancerJeu();
  }
}

//verifie si une partie est lancee ou si le serveur est libre
void lancerJeu() {
  //lancement de la partie
  tampon1 = loadStrings(URL + serveur + "LancerPartie" + ".php" + "?id=" + id + "&pret=" + pret);

  //on transforme le tableau de Strings en 1 seul String
  tampon2 = "";
  for (int i=0; i<tampon1.length; i++) {
    tampon2 += tampon1[i];
  }
  //change la valeur de pret si le serveur n'est pas pret
  pret = boolean(tampon2);

  //si le serveur est libre, demarre la partie pour de bon
  if (pret == true) {
    println("Demarrage de la partie.");
    tempsQuestion = frameCount % IPS;
    seconde = 13;
    score = 0;
    demandeQuestionMulti();
  }
}

//demande une question au serveur
void demandeQuestionMulti() {
  println("Demande d'une question.");
  //demande du texte au serveur
  tampon1 = loadStrings(URL + serveur + "Multi" + ".php" + "?id=" + id);

  //on transforme le tableau de Strings en 1 seul String
  tampon2 = "";
  for (int i=0; i<tampon1.length; i++) {
    tampon2 += tampon1[i];
  }

  //on vide le tableau de String question
  for (int emplacement = 0; emplacement < question.length; emplacement++) {
    question[emplacement] = "";
  }

  //on divise le texte recu en 6, la question en 0, les reponses en 1 à 4, et le numero de la bonne reponse en 5
  question = split(tampon2, ";");

  //reinitialisation de la reponse choisie par le joueur
  reponseChoisie = 0;
}

//envoi du score au serveur
void envoiScore() {
  print("Envoi du score. ");
  //envoi du score
  tampon1 = loadStrings(URL + serveur + "ScoreJoueurs" + ".php" + "?id=" + id + "&score=" + score);

  //on transforme le tableau de Strings en 1 seul String
  tampon2 = "";
  for (int i=0; i<tampon1.length; i++) {
    tampon2 += tampon1[i];
  }

  println(tampon2);
}

//supression de l'identifiant du joueur
void supprimerID() {
  println("Suppression de l'identifiant.");
  //suppression de l'identifiant
  tampon1 = loadStrings(URL + serveur + "Deconnect" + ".php" + "?id=" + id);

  //on transforme le tableau de Strings en 1 seul String
  tampon2 = "";
  for (int i=0; i<tampon1.length; i++) {
    tampon2 += tampon1[i];
  }

  println(tampon2);
}


