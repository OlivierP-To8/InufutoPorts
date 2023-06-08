The purpose of this program is to launch the games on a floppy disk from BASIC 1.0 (TO7/TO7-70), without the LOADM command.
The DOS (DIR, LOADM, SAVEM commands, etc.) is not in the BASIC 1.0 ROM, so it has to be loaded into RAM from a [bootable DOS floppy disk](https://www-apr.lip6.fr/~mine/mess/floppies.html.en) . Once DOS has been loaded, there is no longer enough memory to load the games.
This program places itself in the DSEG space of the games to be loaded, and copies the game binary to the address defined in the file header, then executes it.

Ce programme a pour but de lancer les jeux d'une disquette depuis BASIC 1.0 (TO7/TO7-70), sans la commande LOADM.
En effet, le DOS (commandes DIR, LOADM, SAVEM, ...) n'est pas dans la ROM du BASIC 1.0, il faut donc le charger en RAM depuis une [disquette DOS bootable](https://www-apr.lip6.fr/~mine/mess/floppies.html.fr). Une fois le DOS chargé, il n'y a plus assez de mémoire pour charger les jeux.
Ce programme se place dans l'espace DSEG des jeux à charger, et copie le binaire du jeu à l'adresse définie dans l'entête du fichier, puis l'exécute.

