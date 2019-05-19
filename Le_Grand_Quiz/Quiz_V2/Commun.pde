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

