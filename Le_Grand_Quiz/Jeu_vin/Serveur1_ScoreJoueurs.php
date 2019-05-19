<?php
//id du joueur faisant la demande
$idJoueur = $_GET["id"];
$scoreJoueur = $_GET["score"];

//ecriture du score du joueur dans le fichier pour enregistrer la variable
$scoreFile = fopen("Serveur1_score.txt", "r+");
fseek($scoreFile, ($idJoueur - 1) * 2);
fputs($scoreFile, $scoreJoueur . "\n");

echo "Score reçu.";
?>