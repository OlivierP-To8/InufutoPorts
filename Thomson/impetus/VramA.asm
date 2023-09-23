include 'Vram.inc'
include 'VVram.inc'

INIT1 equ $FF91
VramTop equ Vram
Char_Color equ $5d

ext VVramFront_, RowFlags_
ext PatternRam_, ColorPattern_

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
pFlag:
    defw 0
flagByte:
    defb 0
flagBit:
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

        do
            lda #CharHeight | sta <yCount
            do
                ldb ,y+
                lda #VramStep | sta <xCount
                do
                    clr <pattern
                    lda #2 | sta <bitCount
                    do
                        lda <pattern
                        lsla | lsla | lsla | lsla
                        sta <pattern

                        lda MakePatternMono_@Param3 ; color
                        bitb #$80
                        if ne
                            lda MakePatternMono_@Param3 ; color
                            anda #$0f
                        else
                            lsra | lsra | lsra | lsra
                        endif
                        ora <pattern
                        sta <pattern

                        lslb
                        dec <bitCount
                    while ne | wend
                    lda <pattern | sta ,x+
                    dec <xCount
                while ne | wend
                dec <yCount
            while ne | wend
            dec MakePatternMono_@Param2 ; count
        while ne | wend
    puls a,b,x,y
rts


; ; void MakePatternColor(byte c, ptr<byte> pSource, byte count);
; dseg
; MakePatternColor_@Param2: public MakePatternColor_@Param2
;     defb 0 ; count
; cseg
; MakePatternColor_: public MakePatternColor_
;     pshs a,b,x,y
;         ldb #PatternSize
;         mul
;         addd #PatternRam_
;         tfr d,x

;         lda MakePatternColor_@Param2 ; count
;         ldb #PatternSize
;         mul

;         do
;             pshs a,b
;                 lda ,y+ | sta ,x+
;             puls a,b
;             subd #1
;         while ne | wend
;     puls a,b,x,y
; rts


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    pshs a,b,x,y
        pshs cc | orcc #$50
            lda INIT1
            ora #$01
            sta INIT1

            ldx #Vram
            do
                clr ,x+
                cmpx #Vram+VramRowSize*VramHeight
            while ne | wend

            lda INIT1
            anda #not $01
            sta INIT1
        puls cc

        ldx #Backup
        do
            clr ,x+
            cmpx #Backup+VVramWidth*VVramHeight
        while ne | wend

        bsr ClearFlags
    puls a,b,x,y
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    pshs a,b,x,y
        cmpb #Char_Color
        if cs
            ldy #PatternRam_
        else
            ldy #ColorPattern_-Char_Color*32
        endif
        lda #PatternSize
        mul
        leay d,y
        
        pshs cc | orcc #$50
            lda INIT1
            ora #$01
            sta INIT1

            ldb #CharHeight
            do
                pshs b
                    ldb #VramStep
                    do
                        lda ,y+
                        sta ,x+
                        decb
                    while ne | wend
                    leax VramWidth-VramStep,x
                puls b
                decb
            while ne | wend

            lda INIT1
            anda #not $01
            sta INIT1
        puls cc
    puls a,b,x,y    
    tfr	x,d
    addd #VramStep
rts


VVramToVramRow:
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
rts

ClearFlags:
    clra
    sta RowFlags_
    sta RowFlags_+1
    sta RowFlags_+2
rts


; void VVramToVramAll();
VVramToVramAll_: public VVramToVramAll_
    pshs a,b,x,y
        ldx #VramTop | stx <pVram
        ldx #VVramFront_
        ldy #Backup
        lda #VVramHeight | sta <yCount
        do
            bsr VVramToVramRow
            dec <yCount
        while ne | wend
        bsr ClearFlags
    puls a,b,x,y
rts


; void VVramToVramChanged();
VVramToVramChanged_: public VVramToVramChanged_
    pshs a,b,x,y
        ldx #VramTop
        stx <pVram
        
        ldx #RowFlags_
        lda ,x+
        sta <flagByte
        stx <pFlag
        lda #1
        sta <flagBit

        ldx #VVramFront_
        ldy #Backup
        lda #VVramHeight
        sta <yCount
        do
            lda <flagByte
            anda <flagBit
            if ne
                bsr VVramToVramRow
            else
                leax VVramWidth,x
                leay VVramWidth,y
                ldd <pVram
                addd #VramRowSize
                std <pVram
            endif
            lsl <flagBit
            if eq
                pshs x
                    ldx <pFlag
                    lda ,x+
                    sta <flagByte
                    stx <pFlag
                    lda #1
                    sta <flagBit
                puls x
            endif
            dec <yCount
        while ne | wend
        bsr ClearFlags
    puls a,b,x,y
rts


ext Status_

; void StatusToVram();
cseg
StatusToVram_: public StatusToVram_
    pshs a,b,x,y
        ldx #VramTop
        ldy #Status_
        lda #2 | sta <yCount
        do
            lda #VVramWidth | sta <xCount
            do 
                ldb ,y+
                if ne
                    bsr Put_
                endif
                leax VramStep,x
                dec <xCount
            while ne | wend
            leax VramRowSize-VVramWidth*VramStep,x

            dec <yCount
        while ne | wend
    puls a,b,x,y
rts