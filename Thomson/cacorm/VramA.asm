include 'Vram.inc'
include 'VVram.inc'
include '../ThomsonTO.inc'

VramTop equ Vram+VramRowSize*2

ext VVram_
ext PatternRam_
ext ColorRam_
ext PaletteValues_

dseg
Backup:
    defs VVramWidth*VVramHeight

zseg
yCount:
    defb 0
xCount:
    defb 0
bitCount:
    defb 0
pattern:
    defb 0
pVram:
    defw 0


; void MakePatternMono(byte c, ptr<byte> pSource, byte count, byte color);
dseg
MakePatternMono_@Param2: public MakePatternMono_@Param2
    defb 0 ; count
MakePatternMono_@Param3: public MakePatternMono_@Param3
    defb 0 ; color
cseg
MakePatternMono_: public MakePatternMono_
    pshs a,b,x,y

        ldb #PatternSize
        mul

        pshs a,b

        addd #PatternRam_
        tfr d,x

        ; ajout de la forme
        lda MakePatternMono_@Param2 | sta <xCount
        do
            lda #CharHeight | sta <yCount
            do
                ldb ,y+
                stb ,x+

                dec <yCount
            while ne | wend

            dec <xCount
        while ne | wend

        ; on prend la couleur correspondante dans la palette
        ; et on la stocke dans pattern
        ldx #PaletteValues_
        lda MakePatternMono_@Param3
        leax a,x
        lda ,x
        sta <pattern

        puls a,b

        addd #ColorRam_
        tfr d,x

        ; ajout de la couleur
        lda MakePatternMono_@Param2 | sta <xCount
        do
            lda #CharHeight | sta <yCount
            do
                ldb <pattern
                stb ,x+

                dec <yCount
            while ne | wend

            dec <xCount
        while ne | wend

    puls a,b,x,y
rts


; void MakePatternColor(byte c, ptr<byte> pSource, byte count);
dseg
MakePatternColor_@Param2: public MakePatternColor_@Param2
    defb 0 ; count
cseg
MakePatternColor_: public MakePatternColor_
    pshs a,b,x,y

        ldb #PatternSize
        mul

        pshs a,b,y

        addd #PatternRam_
        tfr d,x
        ; x pointe où écrire
        ; y pointe où lire

        ; ajout de la forme
        lda MakePatternColor_@Param2 | sta <xCount
        do
            lda #CharHeight | sta <yCount
            do
                clr <pattern

                lda ,y+
                ; découpe de l'octet en deux (image source en 4 bits/16 couleurs)
                tfr a,b
                andb #$0f
                anda #$f0
                lsra | lsra | lsra | lsra
                ; A contient la 1ere partie de l'octet, B la 2nd partie

                tsta
                if ne
                    lda #$80
                    ora <pattern
                    sta <pattern
                endif

                tstb
                if ne
                    lda #$40
                    ora <pattern
                    sta <pattern
                endif

                lda ,y+
                ; découpe de l'octet en deux (image source en 4 bits/16 couleurs)
                tfr a,b
                andb #$0f
                anda #$f0
                lsra | lsra | lsra | lsra
                ; A contient la 1ere partie de l'octet, B la 2nd partie

                tsta
                if ne
                    lda #$20
                    ora <pattern
                    sta <pattern
                endif

                tstb
                if ne
                    lda #$10
                    ora <pattern
                    sta <pattern
                endif

                lda ,y+
                ; découpe de l'octet en deux (image source en 4 bits/16 couleurs)
                tfr a,b
                andb #$0f
                anda #$f0
                lsra | lsra | lsra | lsra
                ; A contient la 1ere partie de l'octet, B la 2nd partie

                tsta
                if ne
                    lda #$08
                    ora <pattern
                    sta <pattern
                endif

                tstb
                if ne
                    lda #$04
                    ora <pattern
                    sta <pattern
                endif

                lda ,y+
                ; découpe de l'octet en deux (image source en 4 bits/16 couleurs)
                tfr a,b
                andb #$0f
                anda #$f0
                lsra | lsra | lsra | lsra
                ; A contient la 1ere partie de l'octet, B la 2nd partie

                tsta
                if ne
                    lda #$02
                    ora <pattern
                    sta <pattern
                endif

                tstb
                if ne
                    lda #$01
                    ora <pattern
                    sta <pattern
                endif

                lda <pattern | sta ,x+

                dec <yCount
            while ne | wend

            dec <xCount
        while ne | wend

        puls a,b,y

        addd #ColorRam_
        tfr d,x
        ; x pointe où écrire
        ; y pointe où lire

        ; ajout de la couleur
        lda MakePatternColor_@Param2 | sta <xCount
        do
            lda #CharHeight | sta <yCount
            do
                clr <pattern

                ; on récupère la couleur ayant la valeur la plus élevée (entre 0 et 15)
                ; pour 8 pixels, donc 4 octets, dans pattern
                lda #4 | sta <bitCount ; il faut 4 octets pour 8 pixels
                do
                    lda ,y+
                    ; découpe de l'octet en deux (image source en 4 bits/16 couleurs)
                    tfr a,b
                    andb #$0f
                    anda #$f0
                    lsra | lsra | lsra | lsra
                    ; A contient la 1ere partie de l'octet, B la 2nd partie

                    cmpa <pattern
                    if ge
                        sta <pattern
                    endif

                    cmpb <pattern
                    if ge
                        stb <pattern
                    endif

                    dec <bitCount
                while ne | wend

                ; on prend la couleur correspondante dans la palette
                ; et on la stocke dans ColorRam_ (X)
                pshs y
                    ldy #PaletteValues_
                    lda <pattern
                    leay a,y
                    ldb ,y
                    stb ,x+
                puls y

                dec <yCount
            while ne | wend

            dec <xCount
        while ne | wend

    puls a,b,x,y
rts


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    pshs a,b,x,y

        ; commutation du bit de couleur (C0 a 0)
        lda PRC
        anda #$fe
        sta PRC

        ldx #Vram
        ldy #$C0C0 ; noir sur noir
        do
            sty ,x+
            cmpx #Vram+VramRowSize*VramHeight
        while ne | wend

        ; commutation du bit de forme (C0 a 1)
        lda PRC
        ora #$01
        sta PRC

        ldx #Vram
        do
            clr ,x+
            cmpx #Vram+VramRowSize*VramHeight
        while ne | wend

        ldx #Backup
        do
            clr ,x+
            cmpx #Backup+VVramWidth*VVramHeight
        while ne | wend

    puls a,b,x,y
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    pshs a,b,x,y

        lda #PatternSize
        mul

        pshs a,b,x

        ldy #ColorRam_
        leay d,y

        ; commutation du bit de couleur (C0 a 0)
        lda PRC
        anda #$fe
        sta PRC

        ldb #CharHeight
        do
            lda ,y+
            sta ,x
            leax VramWidth,x
            decb
        while ne | wend

        puls a,b,x

        ldy #PatternRam_
        leay d,y

        ; commutation du bit de forme (C0 a 1)
        lda PRC
        ora #$01
        sta PRC

        ldb #CharHeight
        do
            lda ,y+
            sta ,x
            leax VramWidth,x
            decb
        while ne | wend

    puls a,b,x,y
    tfr	x,d
    addd #VramStep
rts


; void VVramToVram();
VVramToVram_: public VVramToVram_
    pshs a,b,x,y
        ldx #VramTop | stx <pVram
        ldx #VVram_
        ldy #Backup
        lda #VVramHeight | sta <yCount
        do
            lda #VVramWidth | sta <xCount
            do 
                ldb ,x+
                cmpb ,y
                if ne
                    stb ,y
                    pshs x
                        ldx <pVram
                        bsr Put_
                        std <pVram
                    puls x
                else
                    ldd <pVram
                    addd #VramStep
                    std <pVram
                endif
                leay 1,y
                dec <xCount
            while ne | wend
            ldd <pVram
            addd #VramRowSize-VVramWidth*VramStep
            std <pVram

            dec <yCount
        while ne | wend
    puls a,b,x,y
rts
