<?php
//fichier contenant les questions
$questionsFile = fopen("Questions.txt", "r+");
$totalQuestions = fgets($questionsFile);
$numeroQuestion = rand(1, intval($totalQuestions));

//cherche la question dans le fichier
for($ligne = 0; $ligne < $numeroQuestion; $ligne ++) {
	$question = fgets($questionsFile);
}
//la revoie au joueur
echo $question;
?>