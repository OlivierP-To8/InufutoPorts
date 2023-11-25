# Comment jouer sur le vrai matériel


## TO9/TO8/TO8D/TO9+
- Ecrire l'image InufuTO.fd sur disquette DD avec l'outil adapté à votre système :
    - Windows : [Omniflop](http://www.shlock.co.uk/Utils/OmniFlop/OmniFlop.htm),
    - DOS : [DCFDUTIL](http://dcmoto.free.fr/emulateur/prog/dcfdutil33.zip),
    - Amiga : [ToDisk](http://aminet.net/package/disk/misc/ToDisk).

    Pour réduire les temps de chargement des jeux de moitié, il faut utiliser un facteur d'entrelacement de 2 plutôt que celui de 7 par défaut. Pour changer le facteur d'entrelacement de la disquette sur TO8/TO8D/TO9+, entrer les instructions suivantes en BASIC 512 :
    - formater la face 1 si ce n'est pas déjà fait : **DSKINI 1**
    - copier la face 0 sur la face 1 : **BACKUP 0 TO 1**
    - reformater la face 0 avec un facteur d'entrelacement de 2 : **DSKINI 0,2**
    - copier la face 1 sur la face 0 : **BACKUP 1 TO 0**


## TO7-70/TO8/TO8D/TO9+
- Utiliser un [SDDRIVE](http://dcmoto.free.fr/bricolage/sddrive/index.html) et mettre InufuTO.sd sur une carte SD. Attention il y a une manipulation supplémentaire sur TO8D et TO9+ pour désactiver le lecteur interne.


## TO9
- Utiliser une nappe droite 5"25 - 3"5 de lecteur disquette. Brancher sur le côté 3"5 un [HxC](https://hxc2001.com/floppy_drive_emulator/) ou [HxC Gotek](https://hxc2001.com/docs/gotek-floppy-emulator-hxc-firmware/) configuré en Shugart et contenant l'image InufuTO.hfe. Brancher l'autre côté 5"25 sur le [connecteur 5](https://www.old-computers.com/museum/photos/Thomson_To9_Rear_1.jpg) à l'arrière du TO9. Il faut prévoir une alimentation 5V externe pour le lecteur HxC.

    Une fois branché, choisir le BASIC 128 et entrer **DEVICE"2:"** suivi de **LOADM"LOAD.BIN",,R**

    Pour copier le contenu du HxC sur une disquette dans le lecteur interne, entrer les instructions suivantes en BASIC 128 :
    - formater la face 0 avec un facteur d'entrelacement de 2 : **DSKINI 0,2**
    - copier la face 2 sur la face 0 : **BACKUP 2 TO 0**


## TO8/TO8D/TO9+
- Faire une disquette Thomson contenant [DC Transferts](http://dcmoto.free.fr/programmes/dctransferts/index.html), mettre l'image InufuTO.fd sur une autre disquette DD formatée DOS 720k, et créer une troisième disquette sur le Thomson avec les deux précédentes.

- Faire un [câble DIN 14 pour lecteur externe de disquette](http://forum.system-cfg.com/viewtopic.php?p=53096#p53096) et y brancher un [HxC](https://hxc2001.com/floppy_drive_emulator/) ou [HxC Gotek](https://hxc2001.com/docs/gotek-floppy-emulator-hxc-firmware/) configuré en Shugart et contenant l'image InufuTO.hfe. Il faut prévoir une alimentation 5V externe pour le lecteur HxC.

    Une fois branché, choisir le BASIC 512 et entrer **DEVICE"2:"** suivi de **LOADM"LOAD.BIN",,R**

    Pour copier le contenu du HxC sur une disquette dans le lecteur interne, entrer les instructions suivantes en BASIC 512 :
    - formater la face 0 avec un facteur d'entrelacement de 2 : **DSKINI 0,2**
    - copier la face 2 sur la face 0 : **BACKUP 2 TO 0**


## TO7/TO7-70/TO9/TO8/TO8D/TO9+
- Faire une [MEMO7](http://forum.system-cfg.com/viewtopic.php?f=10&t=7086) et y mettre l'image du jeu .m7
- Avec une interface CC90-232 et un câble série, faire un transfert série en utilisant [CC90](http://www.pulsdemos.com/cc90.html).


## TO7-70
- Faire une K7 audio avec l'image du jeu .k7, mais cela ne fonctionne généralement pas. Il faut utiliser [DCTOK7](http://dcmoto.free.fr/emulateur/prog/dctok7_20210507.zip) pour faire le fichier .wav à partir du fichier .k7
- Utiliser un [SDLEP-READER](http://dcmoto.free.fr/bricolage/sdlep-reader/index.html) ou un [SDLEP-READER TFT](http://dcmoto.free.fr/bricolage/sdlep-tft/index.html). La création d'un fichier .lep avec [DCLEP](http://dcmoto.free.fr/emulateur/prog/dclep_20210507.zip) nécessite un enregistrement .wav fidèle de la sortie TTL.

