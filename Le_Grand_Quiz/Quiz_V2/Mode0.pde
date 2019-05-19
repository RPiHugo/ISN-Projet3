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
