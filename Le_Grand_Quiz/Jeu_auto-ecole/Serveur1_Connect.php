<?php
//enregistre quels identifiants ont été donnés 
$joueursFile = fopen("Serveur1_nbJoueurs.txt", "r+");
$j1 = fgets($joueursFile);
$j2 = fgets($joueursFile);
$j3 = fgets($joueursFile);
$j4 = fgets($joueursFile);

//si un identifiant est libre, le esrveur le renvoie au joueur
if($j1 == 0) {
	echo 1;
	fseek($joueursFile, 0);
	fputs($joueursFile, "1\n");
} else if ($j2 == 0) {
	echo 2;
	fseek($joueursFile, 2);
	fputs($joueursFile, "1\n");
} else if ($j3 == 0){
	echo 3;
	fseek($joueursFile, 4);
	fputs($joueursFile, "1\n");
} else if ($j4 == 0){
	echo 4;
	fseek($joueursFile, 6);
	fputs($joueursFile, "1");
} else {
	echo 5;
}

fclose($joueursFile);
?>