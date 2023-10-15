include 'Vram.inc'
include 'VVram.inc'
include '../ThomsonTO.inc'

VramTop equ Vram

ext VVram_
ext PatternRam_
ext ColorRam_
ext PaletteValues_
ext ColorSource_

dseg
Backup:
    defs VVramWidth*VVramHeight

zseg
yCount:
    defb 0
xCount:
    defb 0
pVram:
    defw 0


; void MakeMono(byte count, ptr<byte> pDest, byte color);
dseg
MakeMono_@Param2: public MakeMono_@Param2
    defb 0 ; color
cseg
MakeMono_: public MakeMono_
    pshs a,b,x,y

        sta <xCount

        ; y pointe où écrire la couleur (pDest)

        ; on prend la couleur correspondante dans la palette
        ; et on la stocke dans B
        ldx #PaletteValues_
        lda MakeMono_@Param2
        leax a,x
        ldb ,x

        ; ajout de la couleur
        do
            lda #CharHeight | sta <yCount
            do
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
        ; x pointe où lire les index de palette
        ldx #ColorSource_

        ; ajout de la couleur selon les index de palette dans ColorSource_
        do
            lda #CharHeight | sta <yCount
            do
                ; y pointe où lire
                lda ,x+

                pshs x
                    ; on prend la couleur correspondante dans la palette
                    ldx #PaletteValues_
                    leax a,x
                    ldb ,x

                    ; et on la stocke dans ColorRam_ (Y)
                    stb ,y+
                puls x

                dec <yCount
            while ne | wend

            dec <xCount
        while ne | wend

    puls a,b,x,y
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
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
        ldy #VVramWidth*VVramHeight
        do
            clr ,x+
            leay -1,y
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
