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
