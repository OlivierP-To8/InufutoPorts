FondNoir equ $80
CharHeight equ 8

ext ColorRam_
ext ColorSource_

zseg
xCount:
    defb 0
yCount:
    defb 0


; void MakeMono(byte count, ptr<byte> pDest, byte color);
dseg
MakeMono_@Param2: public MakeMono_@Param2
    defb 0 ; color
cseg
MakeMono_: public MakeMono_
    pshs a,b,x,y

        sta <xCount

        ; y pointe où écrire la couleur (pDest)

        ; on prend la couleur dans B
        ; et on ajoute le fond noir
        ldb MakeMono_@Param2
        orb #FondNoir

        do
            lda #CharHeight | sta <yCount
            do
                ; on stocke la couleur dans ColorRam_ (Y)
                stb ,y+

                dec <yCount
            while ne | wend

            dec <xCount
        while ne | wend

    puls a,b,x,y
rts


; void MakeColor(byte count, ptr<byte> pDest);
cseg
MakeColor_: public MakeColor_
    pshs a,b,x,y

        sta <xCount

        ; y pointe où écrire la couleur (pDest)

        ; x pointe où lire les couleurs
        ldx #ColorSource_

        do
            lda #CharHeight | sta <yCount
            do
                ; on prend la couleur dans B
                ; et on ajoute le fond noir
                ldb ,x+
                orb #FondNoir

                ; et on la stocke dans ColorRam_ (Y)
                stb ,y+

                dec <yCount
            while ne | wend

            dec <xCount
        while ne | wend

    puls a,b,x,y
rts

