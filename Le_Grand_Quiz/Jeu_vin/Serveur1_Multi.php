<?php
//id du joueur faisant la demande
$idJoueur = $_GET["id"];
//stockage de l'ID du joueur Master
$idMasterFile = fopen("Serveur1_idMaster.txt", "r+");
$idMaster = fgets($idMasterFile);
//question en cours
$numeroQuestionFile = fopen("Serveur1_numeroQuestion.txt", "r+");
$numeroQuestion = fgets($numeroQuestionFile);
$nombreQuestionsFaites = fgets($numeroQuestionFile);
//fichier contenant les réponses
$questionsFile = fopen("Questions.txt", "r+");
$totalQuestions = fgets($questionsFile);

//si le joueur demandant est le joueur Master
if($idJoueur == $idMaster) {
	//s'il y a eu moins de 5 questions
	if($nombreQuestionsFaites < 5) {
		//tirage d'un numero aleatoire pour la nouvelle question
		$numeroQuestion = rand(1, intval($totalQuestions));
		fseek($numeroQuestionFile, 0);
		fputs($numeroQuestionFile, $numeroQuestion);
		$nombreQuestionsFaites++;
		//enregistrement du numero de la question pour les autres joueurs
		fseek($numeroQuestionFile, 2);
		fputs($numeroQuestionFile, $nombreQuestionsFaites);
	}
}

//s'il y a eu moins de 5 questions
if($nombreQuestionsFaites < 5) {
	//cherche la question dans le fichier
	for($ligne = 0; $ligne < $numeroQuestion; $ligne++) {
		$question = fgets($questionsFile);
	}
} else {
	//sinon renvoyer le score, la partie est finie
	$scoreFile = fopen("Serveur1_score.txt", "r+");
	$question = "Score;Joueur 1 : " . fgets($scoreFile) . ";Joueur 2 : " . fgets($scoreFile) . ";Joueur 3 : " . fgets($scoreFile) . ";Joueur 4 : " . fgets($scoreFile) . ";" . "0";
}
//la revoie au joueur
echo $question;
?>