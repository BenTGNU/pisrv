#/bin/bash

DIR=/var/motion/capture
OLD=/var/motion/archives

ONE=1   #Indique la première exécution de la boucle
REBCL=1

while [ $REBCL -eq 1 ]
do
        #Liste les fichiers à inclure.
        ls -1 $DIR/*.jpg > $DIR/liste
        ls -1 $DIR/*.avi >> $DIR/liste

        #Détermine la date exact de l'évènement (head prend la première ligne, puis cut découpe le nom de fichier pour ne garder que le milieu du nom.
        CHAINE=$(head -n 1 $DIR/liste | cut -d "-" -f 3 | cut -d " " -f 1)
        ANNEE=$(echo $CHAINE | cut -c 1-4)
        MOIS=$(echo $CHAINE | cut -c 5-6)
        JOUR=$(echo $CHAINE | cut -c 7-8)
        HEURE=$(echo $CHAINE | cut -c 9-10)
        MINUTE=$(echo $CHAINE | cut -c 11-12)

        ARCHIVE=$JOUR.$MOIS.$ANNEE-$HEURE,$MINUTE.tar.gz

        if [ $ONE -eq 1 ]
        then
                sleep 5         #Patiente 5 secondes pour laisser le temps à la webcam d'enregistrer
                #Ne garde que les 10 premières images de la liste pour envoyer un premier échantillon
                head -n 10 $DIR/liste > $DIR/corps_mail
                #Créer l'archive des images et vidéos à joindre au mail.
                tar -cz -f $DIR/$ARCHIVE -T $DIR/corps_mail
                ONE=0
        else
                #Créer l'archive des images et vidéos à joindre au mail. Les fichiers originaux sont supprimés
                tar -cz --remove-files -f $DIR/$ARCHIVE -T $DIR/liste
        fi

        #Corps du mail
        echo "Motion semble avoir détecté un mouvement à $HEURE:$MINUTE le $JOUR/$MOIS/$ANNEE." > $DIR/corps_mail
        echo "" >> $DIR/corps_mail

        #Ajout de la pièce jointe
        uuencode $DIR/$ARCHIVE $ARCHIVE >> $DIR/corps_mail

        #Envoi du mail
        mail -s Motion myname@isp.tld < $DIR/corps_mail

	#Archivage
	sleep 30
	mv $DIR/$ARCHIVE $OLD

        sleep 120       #Patiente 2 minutes avant de renvoyer un second mail.
        if ! ls $DIR/*.jpg >/dev/null 2>&1      #Teste la présence de fichier jpg dans le dossier (en exploitant le code d'erreur de ls)
        then
                REBCL=0
        fi
done
