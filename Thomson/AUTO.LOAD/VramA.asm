include 'Vram.inc'
include '../ThomsonTO.inc'

ext PatternRam_

zseg
yCount:
    defb 0
xCount:
    defb 0
pattern:
    defb 0


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pshs a,b,x,y

        ; commutation du bit de couleur (C0 a 0)
        lda PRC
        anda #$fe
        sta PRC

        ; on efface l'ecran (de $4000 à $5F3F)
        ldx #$4000
        ldy #$F8F8 ; blanc sur noir
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

    puls a,b,x,y
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    pshs a,b,x,y

        lda #PatternSize
        mul
        ldy PTGENE
        leay d,y

        ; inversion des lignes du caractère
        ldb #CharHeight
        do
            lda ,y+
            pshs a
            decb
        while ne | wend

        ; commutation du bit de forme (C0 a 1)
        lda PRC
        ora #$01
        sta PRC

        ldb #CharHeight
        do
            puls a
            sta ,x
            leax VramWidth,x
            decb
        while ne | wend

    puls a,b,x,y
    tfr	x,d
    addd #VramStep
rts

