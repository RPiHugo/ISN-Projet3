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
