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
        ldy #$F8F8 ; blanc sur noir
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

    puls a,b,x,y
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    pshs a,b,x,y

        lda #PatternSize
        mul
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

