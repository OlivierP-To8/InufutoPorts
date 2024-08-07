include 'ThomsonTO.inc'

ext InitScanKeys_

cseg
Init_: public  Init_
    ; identification du modèle
    ;    00 = T9000,TO7  => bord écran par PRC + modifier la palette en 8c
    ;    01 = TO7-70     => bord écran par PRC
    ;    02 = TO9        => bord écran par LGATOU avec saturation $08
    ;    03 = TO8,TO8D   => bord écran par LGATOU
    ;    06 = TO9+
    ldb MODELE
    cmpb #$03
    if ge
        ; bord noir sur TO8/TO8D/TO9+
        lda #$00   ; XXXXPBVR (pastel bleu vert rouge)
        sta LGATOU ; registre uniquement en écriture
    else
        cmpb #$02
        if eq
            ; bord noir sur TO9
            lda #$08   ; XXXXSBVR (saturation bleu vert rouge)
            sta LGATOU ; registre uniquement en écriture
        else
            ; bord noir sur TO7 et TO7-70
            lda PRC
            anda #$8f ; border color b654=000
            sta PRC

            ; buzzer clavier TO7
            lda #1     ; 0=ON 1=OFF
            sta BUZZ
        endif
    endif

    clr $6031 ; nettoyage du registre moniteur TEMPO, nécessaire sur TO9. Merci à Sam pour l'explication :
    ; La rom utilise le MSByte de TEMPO comme tentative de chargement du bootsecteur.
    ; Elle l'initialise à 3, et tente de lire le secteur de boot. Si ça échoue elle le DEC, et quand ça arrive à 0, elle boot le basic.
    ; Donc le basic récupère un MSByte à 0, alors qu'un truc sur bootsecteur ne passe pas par les DEC récupère le MSByte à 3.
    ; Or comme par la suite quand on joue de la musique, on ne met à jour que l'octet poids faible de TEMPO.
    ; On reste donc avec un TEMPO>=768 au lieu d'un truc autour de 5 (tempo par défaut du basic).
    ; On joue donc 153 fois trop lentement si on n'initialise pas ce MSByte à 0 dans son propre code...

    ; passage au mode TO7 320x200x16c avec conflit de proximite (2 couleurs pour 8 pixels)
    ; la mémoire écran se trouve entre $4000 et $5F3F
    lda #$0
    sta LGAMOD

    jsr BlackScreen_
    jsr InitScanKeys_

rts


BlackScreen_ : public BlackScreen_

    pshs a,x,y

    ; commutation du bit de couleur (C0 a 0)
    lda PRC
    anda #$fe
    sta PRC

    ; on efface l'ecran (de $4000 à $5F3F)
    ldx #$4000
    ldy #$C0C0 ; noir sur noir
    do
        sty ,x
        leax 2,x
        cmpx #$5F3F
    while lt | wend

    ; commutation du bit de forme (C0 a 1)
    lda PRC
    ora #$01
    sta PRC

    ; on efface l'ecran (de $4000 à $5F3F)
    ldx #$4000
    ldy #$0000
    do
        sty ,x
        leax 2,x
        cmpx #$5F3F
    while lt | wend

    puls a,x,y

rts
