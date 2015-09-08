Des exemples de configuration pour votre Raspberry Pi
=======================================

Pour commencer tout est basé sur [Raspbian](http://www.raspbian.org/) ~~via une installation [NOOBS](http://www.raspberrypi.org/help/noobs-setup/).~~

Les différents aspects suivant seront abordés:
* boot - Une configuration optimal du démarrage de votre RPi
* etc
  * apt - Une gestion optimal des paquet et des màjs
  * ~~bind~~ unbound - Un DNS **léger** sans tracking et bloqeur de pub et bien plus encore
  * default - La configuration de certains démons
  * fstab - Une optimisation de l'usage de la carte mémoire 
  * lighttpd - Un serveur web léger et réactif
  * minidlna - Streamer du contenu sur votre LAN
  * motion - Faire un peu de vidéo-surveillance chez soi
  * polipo - En complément de ~~BIND~~ Unbound pour mettre en cache les sites les plus visités
  * samba - Partager du contenu sur votre LAN
  * sysctl.conf - Obtenir les meilleures performances de votre Rpi
  * tor - Accéder au DeepWeb
