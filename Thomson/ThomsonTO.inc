;----------------------------------------------------------
;Organisation de la mémoire
;----------------------------------------------------------
;Debut  Fin    Taille   Description
;----------------------------------------------------------
;0000   3FFF   16 Ko    ROM cartouche MEMO7 + Logiciels intégrés
;4000   5F3F    8 Ko    VRAM (vidéo RAM, page physique 0) - 2x8 Ko (A FORME et B COULEUR)
;5F40   5FFF            Reste VRAM réservé au système
;6000   60FF    0.25 Ko Réservé au système (page 0 du moniteur)
;6100   9FFF   15.75 Ko RAM Système (Fixe, page physique 1) - 7.75 Ko pour TO7 (6100-7FFF)
;A000   DFFF   16 Ko    RAM Donnée (fenêtre de RAM paginée) - 14x16 Ko (256 Ko) ou 30x16 Ko (512 Ko)
;E000   E7BF    2 Ko    ROM contrôleur disquette - 2x1.9 Ko sur TO8
;E7B0   E7FF            Accès aux périphériques (voir ci-dessous)
;E800   FFFF    6 Ko    ROM Moniteur - 2x6 Ko sur TO8
;----------------------------------------------------------
;6100-7FFF disponibles pour un TO7 sans extension mémoire
;6100-BFFF disponibles pour un TO7 avec extension mémoire 16 Ko

;----------------------------------------------------------
;Points d'entrée standard de la ROM Moniteur ($E800-$FFFF)
;----------------------------------------------------------
;Nom      Adresse    Description
;----------------------------------------------------------
EXTRA   equ $EC0C   ;Appel de l'extramoniteur
PEIN    equ $EC09   ;Lecture des boutons de la souris
GEPE    equ $EC06   ;Lecture de la souris
COMS    equ $EC03   ;Appel d'un sous-programme en ROM
SETP    equ $EC00   ;Programmation de la palette
CHPL    equ $E833   ;Ecriture d'un point "caractère"
KBIN    equ $E830   ;Sortie programme d'interruption
MENU    equ $E82D   ;Retour au menu principal
DKC0    equ $E82A   ;Contrôleur de disque
JOYS    equ $E827   ;Lecture des manette de jeux
GETS    equ $E824   ;Lecture de l'écran
GETP    equ $E821   ;Lecture de la couleur d'un point
NOTE    equ $E81E   ;Génération de musique
LPIN    equ $E81B   ;Lecture du bouton du crayon optique
GETL    equ $E818   ;Lecture du crayon optique
K7C0    equ $E815   ;Lecture/écriture sur cassette
RSC0    equ $E812   ;Gestion de l'interface de communication
PLOT    equ $E80F   ;Allumage ou extinction d'un point
DRAW    equ $E80C   ;Tracé d'un segment de droite
KTST    equ $E809   ;Lecture rapide du clavier
GETC    equ $E806   ;Lecture du clavier
PUTC    equ $E803   ;Affichage d'un caractère
; Si dans le menu "Réglage et préférences" du TO8 on choisi la souris
; à la place du crayon-optique (choix 2), alors
; les routines GETL ($E818) et LPIN ($E81B) pour lire le crayon optique
; sont détournées par le moniteur vers GEPE ($EC06) et PEIN ($EC09)
; pour lire la souris de façon transparente.

MODELE  equ $fff0   ;Modèle de la gamme
                    ;0: TO7
                    ;1: TO7-70
                    ;2: TO9
                    ;3: TO8/TO8D
                    ;6: TO9+


;----------------------------------------------------------
;Registres du moniteur ($6000 à $60FF)
;----------------------------------------------------------
;Nom      Adresse    Description
;----------------------------------------------------------
STATUS  equ $6019   ;Différents sémaphores
                    ;b7 semigraphique
                    ;b6 scroll rapide
                    ;b5 interruption utilisateur validée: timer 
                    ;b4 graphique sans écriture de couleurs
                    ;b3 forme seule
                    ;b2 curseur visible/invisible
                    ;b1 transmission par GETC
                    ;b0 traitement des séquences SS2 dans GETC

TIMEPT  equ $6027   ;Pointeur sur la routine utilisateur de
                    ;   traitement des interruptions TIMER utilisateur.

TEMPO   equ $6032   ;Tempo général pour la génération de musique.
DUREE   equ $6034   ;Durée de la note (de 1 à 96).
TIMBRE  equ $6035   ;Attaque de la note.
OCTAVE  equ $6037   ;Octave (1, 2, 4, 8 ou 16).

BUZZ    equ $6073   ;Sémaphore d'extinction du buzzer.

CONFIG  equ $6074   ;Flags de présence périphériques.
                    ;b7 lecture lightpen redirigée vers périphérique
                    ;b6 périphérique clavier branché
                    ;b5 présence modem première et deuxième génération
                    ;b4 imprimante connectée et ON-LINE
                    ;b3 interface RS232 connectée
                    ;b2 présence lecteur de cassettes
                    ;b1 présence ram disque
                    ;b0 interface jeu et musique connectée


;----------------------------------------------------------
;PIA System 6846 ($E7C0-$E7C7)
;----------------------------------------------------------
;Nom      Adresse    Description
;----------------------------------------------------------
CSR     equ $E7C0   ;registre d'état composite

CRC     equ $E7C1   ;registre de contrôle périphérique
                    ;b2 : sortie son 1 bit
                    ;CP1: inutilisé (TO9)
                    ;CP1: request clavier (TO8, TO9+)
                    ;CP2: sortie son (TO9)
                    ;CP2: mute son pour souris (TO8, TO9+)
                    ;   0: passage du son
                    ;   1: blocage du son

DDRC    equ $E7C2   ;registre de direction de données

PRC     equ $E7C3   ;registre de données périphériques
                    ;b0 (sortie)   commutation mémoire écran FORME (1) et mémoire écran COULEUR (0)

                    ;b1 (entrée)   interrupteur crayon optique
                    ;   0: ouvert
                    ;   1: fermé

                    ;b2            inutilisé (TO7)
                    ;b2 (sortie)   Couleur tour pastel (TO7-70)
                    ;b2 (sortie)   sélection banque RAM DISK (TO9)
                    ;b2 (sortie)   sélection Cartouche/Basic (TO8, TO9+)

                    ;b3 (sortie)   LED clavier (TO7-70)
                    ;b3            Reflet LED clavier (TO9, TO8, TO9+)

                    ;b4-6(sortie)  Couleur tour (TO7-70)
                    ;b4-5(sortie)  sélection slot ROM (TO9)
                    ;b6 (sortie)   sélection banque RAM DISK (TO9)
                    ;b4 (sortie)   sélection banque ROM moniteur (TO8, TO9+) 0: partie haute, 1: partie basse
                    ;b5 (entrée)   ACK liaison clavier (TO8)
                    ;b5 (entrée)   réserve (TO9+)
                    ;b6 (entrée)   busy imprimante (TO8, TO9+) 0: occupée, 1: disponible

                    ;b7 (entrée)   lecture cassette

CSR4    equ $E7C4   ;registre d'état composite
TCR     equ $E7C5   ;registre contrôle temporisateur
TMSB    equ $E7C6   ;registre temporisateur d'octet de poids fort
TLSB    equ $E7C7   ;registre temporisateur d'octet de poids faible


;----------------------------------------------------------
;PIA System 6821 ($E7C8-$E7CB)
;----------------------------------------------------------
;Nom      Adresse    Description
;----------------------------------------------------------
PRA     equ $E7C8   ;Registre de données, port A.
                    ;b0-7(entrée)    lecture matrice clavier (TO7-70)
                    ;b0 (entrée)     bit de keytest (TO9, TO8, TO9+)
                    ;b1-7 (sortie)   D1-D7 de l'imprimante (TO9, TO8, TO9+)

PRB     equ $E7C9   ;Registre de données, port B.
                    ;b0-7(sortie)    écriture matrice clavier (TO7)
                    ;b0-2(sortie)    multiplexage clavier (TO7-70)
                    ;b3-7(entr/sort) sélection banque mémoire (TO7-70, TO9)
                    ;b0 (sortie)     D0 de l'imprimante (TO9, TO8, TO9+)
                    ;b1 (sortie)     strobe imprimante (TO9, TO8, TO9+)
                    ;b2 (sortie)     commande d'incrustation (TO9, TO8, TO9+)
                    ;b3-7(entr/sort) sélection banque mémoire (TO9, TO8, TO9+)

CRA     equ $E7CA   ;Registre de contrôle, port A
                    ;CA1 (entrée)    présence carte incrustation
                    ;CA2 (sortie)    moteur du L.E.P.

CRB     equ $E7CB   ;Registre de contrôle, port B
                    ;CB1 (entrée)    interruption light-pen (TO9)
                    ;CB1 (entrée)    signal code barre (TO8, TO9+)
                    ;CB2 (sortie)    inutilisé


;----------------------------------------------------------
;PIA jeux et musique 6821 ($E7CC-$E7CF)
;----------------------------------------------------------
;Nom      Adresse    Description
;----------------------------------------------------------
PRA1    equ $E7CC   ;Registre de données, Port A:
                    ;b0-7 (entrée) lecture des manettes de jeux ou souris.
                    ;b0-3 : Direction Joy0 N,S,O,E (1 au repos)
                    ;       Souris gachette1, gachette2, XB, YB
                    ;b4-7 : Direction Joy1 N,S,O,E (1 au repos)

PRB1    equ $E7CD   ;Registre de données, Port B:
                    ;b0-5 (entrée) Convertisseur Numérique Analogique (son 6 bits)
                    ;b0 (entrée) commun bufferisé manette 0
                    ;b1 (entrée) commun bufferisé manette 1
                    ;b2 (entrée) bouton d'action B manette 0 ou XA de la souris
                    ;b3 (entrée) bouton d'action B manette 1
                    ;b6 (entrée) bouton d'action A manette 0 ou YA de la souris
                    ;b7 (entrée) bouton d'action A manette 1

CRA1    equ $E7CE   ;Registre de contrôle, Port A:
                    ;CA1 (entrée) bouton d'action B manette 0
                    ;CA2 (entrée) bouton d'action A manette 0

CRB1    equ $E7CF   ;Registre de contrôle, Port B:
                    ;CB1 (entrée) bouton d'action B manette 1
                    ;CB2 (entrée) bouton d'action A manette 1


;----------------------------------------------------------
;Contrôleur de disquette ($E7D0-$E7D9)
;----------------------------------------------------------
; Le contrôleur WD1770/WD2793 est remplacé par le contrôleur THMFC1 dans les TO8 et TO9+.
; Seuls les points d’entrée du moniteur sont compatibles.
;Nom      Adresse    Description
;----------------------------------------------------------
STAT0   equ $E7D0   ;(lecture)  Etat
                    ;b7 image de l'horloge caractère
                    ;   1: demande d'opération
                    ;   0: par lecture ou écriture des registre RDATA ou WDATA
                    ;b6 =0
                    ;b5 =0
                    ;b4 à 1 indication que l'opération se termine
                    ;b3 à 1 indication que l'opération est terminée
                    ;b2 à 1 erreur de CRC (checksum de la zone d'identification de données)
                    ;b1 action identique au bit 7 pour les opération dites intelligentes
                    ;b0 à 1 indique le bon résultat d'une détection synchro

CMD0    equ $E7D0   ;(écriture) Commande
                    ;b7 =0
                    ;b6 =0
                    ;b5 0: MFM, 1: FM
                    ;b4 validation de la détection des mots de synchro
                    ;b3 à 0 inhibition de la synchronisation du séparateur de données pour le formatage
                    ;b2 à 1 active la sortie WGN
                    ;b10 code opération
                    ;   00: reset
                    ;   01: écriture secteur
                    ;   10: lecture adresse
                    ;   11: lecteur secteur

STAT1   equ $E7D1   ;(lecture)  Etat
                    ;b7 =0
                    ;b6 à 1 détection d'index pour le floppy
                    ;   à 1 présence de disquette pour le QDD
                    ;b5 à 1 information de changement de disquette (non utilisé pour le QDD)
                    ;b4 image inverse de la commande moteur MO
                    ;b3 à 1 détection de la piste 0 pour le floppy
                    ;   à 1 information de détection d'un QDD
                    ;b2 à 1 information de protection en écriture sur le floppy et le QDD
                    ;b1 à 1 information "ready" en provenance du floppy ou QDD
                    ;b0 non utilisé

CMD1    equ $E7D1   ;(écriture) Commande
                    ;b7 bit de compatibilité
                    ;b65 longueur du secteur
                    ;   00: 128 mots/secteur
                    ;   01: 256 mots/secteur
                    ;   10: 512 mots/secteur
                    ;   11: 1024 mots/secteur
                    ;b4 face du disque
                    ;   0: face 0
                    ;   1: face 1
                    ;b321 commande de pré-compensation à 437.5 ns par pas de 62.5 ns
                    ;b10 inhibition du système lorsque le signal READY est inactif (bit à 1) 

CMD2    equ $E7D2   ;(écriture) Commande
                    ;b7 non utilisé
                    ;b6 0: face 0 / commande active du moteur QDD, 1: fonctions inverses
                    ;b5 0: direction vers l'extérieur (piste 0) du disque, 1: fonction inverse
                    ;b4 0: commande de pas inactivée pour le floppy, 1: fonction inverse (non utilisé pour le QDD)
                    ;b3 non utilisé
                    ;b2 0: commande inactive pour le floppy, 1: active (non utilisé pour le QDD)
                    ;b10 commandes de sélection de drive (floppy et QDD) actives à l'état 1

RDATA   equ $E7D3   ;(lecture)  Données
WDATA   equ $E7D3   ;(écriture) Données
WCLK    equ $E7D4   ;(écriture) Horloge
WSECT   equ $E7D5   ;(écriture) Secteurs
WTRCK   equ $E7D6   ;(écriture) Pistes
WCELL   equ $E7D8   ;(écriture) Taille de la cellule 'bit'


;----------------------------------------------------------
;Palette EF9369 ($E7DA-$E7DB)
;----------------------------------------------------------
;Nom      Adresse    Description
;----------------------------------------------------------
DREG    equ $E7DA   ;(lec/ecr)  Registre de données
AREG    equ $E7DB   ;(écriture) Registre d'adresses
; ATTENTION: ne pas lire la case E7DB car il en résultera une recopie
; parasite de certaines cases de la palette dans d'autres.


;----------------------------------------------------------
;Gate d'affichage ($E7DC-$E7DD)
; Le gate EFGG06 est remplacé par le gate mode page dans les TO8 et TO9+.
; Seuls les points d’entrée du moniteur sont compatibles.
;----------------------------------------------------------
;Nom      Adresse    Description
;----------------------------------------------------------
LGAMOD  equ $E7DC   ;(écriture) Registre de commande
; ATTENTION: il y a incompatibilité avec le to8 et to9 au niveau des codes à inscrire en E7DC.
;--------------------------
; 00000000  00  Mode TO7-70            320x200 16 couleurs avec contraintes de proximité (2 couleurs sur 8 pixels)
; 00100001  21  Bitmap 4               320x200 4 couleurs
; 01000001  65  Bitmap 4 spécial (TO8) 320x200 4 couleurs
; 00101010  2A  80 colonnes            640x200 2 couleurs
; 01111011  7B  Bitmap 16              160x200 16 couleurs
; 00100100  24  Page 1                 320x200 2 couleurs en RAM A
; 00100101  25  Page 2                 320x200 2 couleurs en RAM B
; 00100110  26  Overlay                320x200 2 pages superposées 3 couleurs
; 00111111  3F  Triple overlay         160x200 4 pages superposées 5 couleurs
;--------------------------

LGATOU  equ $E7DD   ;(écriture) Registre "système 2" / couleur tour
                    ;b76 bits indiquant le numéro de page physique à afficher sur l'écran (de 0 à 3)
                    ;   00: système normal type TO7
                    ;   01: RAM1
                    ;   10: Bank 1
                    ;   11: Bank 2
                    ;b5 (MO uniquement) bit pour masquer la cartouche (0: visible, 1: masquée)
                    ;b4 (MO uniquement) bit du basic à sélectionner (0: BASIC1, 1: BASIC128)
                    ;b3210 bits de la couleur du tour (Saturation/Pastel Bleu Vert Rouge)
; ATTENTION: il y a incompatibilité avec le to8 et to9 au niveau des codes à écrire (bit saturation remplacé par bit pastel).


;----------------------------------------------------------
;ACIA liaison clavier 6850 ($E7DE-$E7DF)
; Le mode de fonctionnement sera modifie surtout en ce qui concerne le
; périphérique relie au clavier.
; Seuls les points d'entrée du moniteur sont compatibles.
;----------------------------------------------------------
;Nom      Adresse    Description
;----------------------------------------------------------
SCR     equ $E7DE   ;(écriture) Registre de contrôle
SSR     equ $E7DE   ;(lecture)  Registre d'état
STDR    equ $E7DF   ;(écriture) Registre de transmission de données
SRDR    equ $E7DF   ;(lecture)  Registre de réception de données


;----------------------------------------------------------
;Zone libre / Ancien contrôleur de communication ($E7E0-$E7E3)
;----------------------------------------------------------


;----------------------------------------------------------
;Gate array mode page CF74021 ($E7E4-$E7E7)
;----------------------------------------------------------
;Nom      Adresse    Description
;----------------------------------------------------------
LGA4    equ $E7E4   ;Registres de commutation "lecture traitement/crayon optique"
                    ;b0
                    ;    1: sélection des registres du crayon optique
                    ;    0: sélection des registres de traitement
                    ;       $E7E4 => $E7DD b7654 (b3210 à 0)
                    ;       $E7E5 b43210 (b765 à 0)
                    ;       $E7E6 b76543210

LGA5    equ $E7E5   ;Registre "RAM données"
                    ;b7 autorisation d'accès au registre d'affichage en $E7DC
                    ;   en mode contrôleur de disque externe sélectionné (b7 de $E7E7 écrit à 1).
                    ;   Dû au fait d'un risque de conflit en $E7DC avec un éventuel contrôleur externe de QDD
                    ;   0: écriture autorisée
                    ;   1: écriture inhibée
                    ;b6 =0
                    ;b5 =0
                    ;b43210 bits définissant le numéro de page RAM utilisée dans l'espace "RAM données" (de 0 à 31)
                    ;   donne le numéro de page physique de 16 Ko à affecter à l'espace logique

LGA6    equ $E7E6   ;Registre "cartouche"
                    ;b7 =0
                    ;b6 bit de protection en écriture dans la page RAM sélectionnée
                    ;   lorsque l'espace cartouche est recouvert par cette même page de RAM (b5 = 1)
                    ;   0: écriture impossible
                    ;   1: écriture autorisée
                    ;b5 bit de sélection de l'espace cartouche
                    ;   0: l'espace cartouche n'est pas recouvert par de la RAM
                    ;   1: l'espace cartouche est recouvert par une page de RAM dont le numéro est donné par b4-0
                    ;b43210 bits définissant le numéro de page RAM utilisée dans l'espace cartouche (de 0 à 31)
                    ;   donne le numéro de page physique de 16 Ko à affecter à l'espace logique correspondant

LGA7    equ $E7E7   ;Registre "système 1"
                    ;b7 choix de l'utilisation du contrôleur disque
                    ;   0: contrôleur interne
                    ;   1: contrôleur externe
                    ;b6 gestion RAM dans l'espace cartouche
                    ;   0: mode compatible nanoréseau
                    ;   1: gestion par registre interne "cartouche" $E7E6
                    ;b5 standard d'affichage
                    ;   0: 624 lignes (France) 50Hz
                    ;   1: 524 lignes (export) 60Hz
                    ;b4 gestion RAM dans l'espace "données"
                    ;   0: gestion par bit de PIA (émulation)
                    ;   1: gestion par registre interne $E7E5
                    ;b32 choix du type d'ordinateur
                    ;   00: MO
                    ;   01: TO9
                    ;   11: TO
                    ;b10 choix de la RAM dynamique
                    ;   00: 256K x 1bit, 256K x 4bits
                    ;   10: 128K x 1bit
                    ;   11: 64K x 4bits


;----------------------------------------------------------
;L'interface de communication SY6551 ($E7E8-$E7EB)
; Le TOx gère la nouvelle interface de communication RS232.
; Il ne peut gérer l'ancienne interface qui fonctionne sur les systèmes TO7.
; Ces mêmes systèmes ne peuvent accepter la nouvelle interface.
;----------------------------------------------------------
;Nom      Adresse    Description
;----------------------------------------------------------
SIOTRANSM equ $E7E8 ;(écriture) Registre de transmission des données
SIORECPT  equ $E7E8 ;(lecture)  Registre de réception des données
SIORESET  equ $E7E9 ;(écriture) Registre de RESET
SIOSTATUS equ $E7E9 ;(lecture)  Registre d'état
SIOCMDE   equ $E7EA ;(écriture) Registre de commande
SIOCNTRL  equ $E7EB ;(écriture) Registre de contrôle


;----------------------------------------------------------
;Zone libre / Extension digitalisation TO9+ ($E7EC-$E7EF)
;----------------------------------------------------------


;----------------------------------------------------------
;Extension IEEE ($E7F0-$E7F7)
;----------------------------------------------------------


;----------------------------------------------------------
;Extension MODEM ($E7F8-$E7FF)
;----------------------------------------------------------
;Nom      Adresse    Description
;----------------------------------------------------------
PORTA   equ $E7F8   ;Direction/données port A
COMMA   equ $E7F9   ;Contrôle port A
PORTB   equ $E7FA   ;Direction/données port B
COMMB   equ $E7FB   ;Contrôle port B
;$E7FC inutilisé
;$E7FD inutilisé
ACIAS   equ $E7FE   ;(écriture) Contrôle
                    ;(lecture)  Etats
ACIAD   equ $E7FF   ;(écriture) Transmission
                    ;(lecture)  Réception

