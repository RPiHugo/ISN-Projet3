<?php
$idJoueur = $_GET["id"];

$joueursFile = fopen("Serveur1_nbJoueurs.txt", "r+");
$demarrageFile = fopen("Serveur1_demarrage.txt", "r+");
$idMasterFile = fopen("Serveur1_idMaster.txt", "r+");
$numeroQuestionFile = fopen("Serveur1_numeroQuestion.txt", "r+");
$scoreFile = fopen("Serveur1_score.txt", "r+");

//libère l'identifiant du joueur
$idJoueur -= 1;
fseek($joueursFile, $idJoueur * 2);
fputs($joueursFile, "0\n");

//enregistre chaque identifiant
fseek($joueursFile, 0);
$j1 = fgets($joueursFile);
$j2 = fgets($joueursFile);
$j3 = fgets($joueursFile);
$j4 = fgets($joueursFile);

//si le serveur est vide
if($j1 + $j2 + $j3 + $j4 == 0) {
	//enregistrer que la partie est terminée
	fseek($demarrageFile, 0);
	fputs($demarrageFile, "false");
	//plus de joueur maitre
	fseek($idMasterFile, 0);
	fputs($idMasterFile, 0);
	fputs($numeroQuestionFile, "00\n0");
	fputs($scoreFile, "0\n0\n0\n0");
} else {
	//sinon si le serveur n'est pas vide, designe un nouveau joueur master
	fseek($idMasterFile, 0);
	if($j1 == 1) {
		fputs($idMasterFile, "1");
	} else if ($j2 == 1) {
		fputs($idMasterFile, "2");
	} else if ($j3 == 1){
		fputs($idMasterFile, "3");
	} else if ($j4 == 1){
		fputs($idMasterFile, "4");
	}
}

fclose($joueursFile);
fclose($demarrageFile);
fclose($idMasterFile);
fclose($numeroQuestionFile);
fclose($scoreFile);
echo "Identifiant supprimé";
?>