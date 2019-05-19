<?php
//ouverture de chaque fichier stockant des variables
$joueursFile = fopen("Serveur1_nbJoueurs.txt", "r+");
$demarrageFile = fopen("Serveur1_demarrage.txt", "r+");
$idMasterFile = fopen("Serveur1_idMaster.txt", "r+");
$numeroQuestionFile = fopen("Serveur1_numeroQuestion.txt", "r+");
$scoreFile = fopen("Serveur1_score.txt", "r+");

//reinitialisation de toutes les variables
fputs($joueursFile, "0\n0\n0\n0\n");
fputs($demarrageFile, "false");
fputs($idMasterFile, "0");
fputs($numeroQuestionFile, "00\n0");
fputs($scoreFile, "0\n0\n0\n0\n");

//fermeture des fichiers
fclose($joueursFile);
fclose($demarrageFile);
fclose($idMasterFile);
fclose($numeroQuestionFile);
fclose($scoreFile);

//renvoie au joueur que l'operation est terminee
echo "Serveur Reinitialise.";
?>