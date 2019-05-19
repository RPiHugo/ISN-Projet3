<?php
//id du joueur faisant la demande
$idJoueur = $_GET["id"];
//stockage du joueur demandeur
$idMasterFile = fopen("Serveur1_idMaster.txt", "r+");

//demande de démarrage par le joueur
$demandeDemarrage = $_GET["pret"];
//état de la partie
$demarrageFile = fopen("Serveur1_demarrage.txt", "r+");
$serveurDemarrage = fgets($demarrageFile);

//si le joueur ne demande pas à démarrer
if($demandeDemarrage == "false") {
	//si quelqu'un a déjà démarré
	if($serveurDemarrage == "true ") {
		usleep(25000);
		//pret = true
		echo "true";
	} else {
		//pret = false
		echo "false";
	}
} else {
	//sinon si le joueur demande à démarrer si la partie n'est pas déjà lancée
	if($serveurDemarrage == "false") {
		//enregistrer que la partie commence
		fseek($demarrageFile, 0);
		fputs($demarrageFile, "true ");
		//enregistrement du joueur Master
		fseek($idMasterFile, 0);
		fputs($idMasterFile, $idJoueur);
		//pret = true
		echo "true";
	} else {
		//pret = false
		echo "false";
	}
}
?>