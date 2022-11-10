#!/bin/bash
# script1.sh


# Copie de tous les services disponibles dans le fichier " liste_des_services.txt "

systemctl list-unit-files --type=service | more > liste_des_services.txt 

while
	echo " Entrer le nom du service que vous voulez verifier son status "
	read "service"
do
	if grep "$service" liste_des_services.txt
	then

		if sudo systemctl is-active $service
		then
			echo " Service actif "
		break
		else
			echo " Service inactif "
			echo " Demarrage en cours ------------------------------------------------------------------------------  "
			sudo systemctl start $service
			echo " Affichage de son status "
			sudo systemctl status $service
		break
                fi

		if systemctl is-failed $service
		then
			echo " Un problème est survenu au démarrage "
			echo " Regarder le status du service et le journalctl "
			sudo systemctl status $service
			sudo journalctl -xe
		fi
	else
		echo " Ce n'est pas un service, veuillez rééssayer "
	fi
done
	

