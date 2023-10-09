include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

INIT1 equ $FF91
AsciiCount equ 64

ext AsciiPatternSource_, MonoPatternSource_, ColorPatternSource_
ext VVram_, RowFlags_

dseg
Backup:
    defs VVramWidth*VVramHeight
AsciiPatternRam: public AsciiPatternRam
    defs CharHeight*4*AsciiCount
PatternRam: public PatternRam
    defs CharHeight*2*Char_Enemy

zseg
foreColor:     public foreColor
    defb 0
backColor:
    defb 0
pColor:
pVram:
    defw 0
pFlsgs:
    defw 0
bits:
    defb 0
flagByte:
    defb 0


; void InitAsciiPattern();
cseg
InitAsciiPattern_: public InitAsciiPattern_
    pshs a,b,x,y
        ldx #AsciiPatternSource_
        ldy #AsciiPatternRam
        ldd #CharHeight*AsciiCount
        do
            pshs a,b
                lda ,x+
                ldb #4
                do
                    pshs b
                        ldb #$f0 | stb <bits
                        clrb
                        do
                            lsla
                            if cs
                                orb <bits
                            endif
                            lsr <bits | lsr <bits | lsr <bits | lsr <bits
                        while ne | wend
                        stb ,y+
                    puls b
                    decb
                while ne | wend
            puls a,b
            subd #1
        while ne | wend
    puls a,b,x,y
rts


; void InitMonoPattern();
cseg
Colors:
    defb 4,0dh
    defb 3,0fh
    defb 1,0eh
    defb 0
InitMonoPattern_: public InitMonoPattern_
    pshs a,b,x,y
        ldx #Colors | stx <pColor
        ldx #MonoPatternSource_
        ldy #PatternRam
        do
            pshs x
                ldx <pColor
                ldb ,x+
                stx <pColor
            puls x
            tstb
        while ne
            pshs x
                ldx <pColor
                lda ,x+
                stx <pColor
                pshs a
                    anda #$0f | sta <foreColor
                puls a
                lsra | lsra | lsra | lsra | sta <backColor
            puls x
            do
                pshs b
                    ldb #CharHeight/2
                    do
                        pshs b
                            lda ,x+
                            ldb #4
                            do
                                pshs b
                                    clr <bits
                                    ldb #2
                                    do
                                        pshs b
                                            ldb <bits
                                            lslb | lslb | lslb | lslb
                                            lsla
                                            if cs
                                                orb <foreColor
                                            else
                                                orb <backColor
                                            endif
                                            stb <bits
                                        puls b
                                        decb
                                    while ne | wend
                                    ldb <bits | stb ,y+
                                puls b
                                decb
                            while ne | wend
                        puls b
                        decb
                    while ne | wend
                puls b
                decb ; char count
            while ne | wend
        wend
    puls a,b,x,y
rts


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
    puls a,b,x,y
rts


cseg
PutN:
    pshs cc | orcc #$50
        lda INIT1
        ora #$01
        sta INIT1

        do
            lda ,x+ | sta ,y+
            lda ,x+ | sta ,y
            leay VramWidth-1,y
            decb
        while ne | wend

        lda INIT1
        anda #not $01
        sta INIT1
    puls cc
rts

ClearN:
    pshs cc | orcc #$50
        lda INIT1
        ora #$01
        sta INIT1

        do
            clr ,y+
            clr ,y
            leay VramWidth-1,y
            decb
        while ne | wend

        lda INIT1
        anda #not $01
        sta INIT1
    puls cc
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    pshs a,b,x,y
        tfr x,y
        cmpb #Char_Enemy
        if cs
            ldx #PatternRam
        else
            ldx #ColorPatternSource_-PatternSize*Char_Enemy
        endif
        lda #PatternSize
        mul
        leax d,x
        
        ldb #CharHeight
        bsr PutN

    puls a,b,x,y    
    tfr	x,d
    addd #2
rts


VVramToVramRow:
    ldb #VVramWidth/2
    do 
        pshs b
            ldd ,x++
            cmpd ,y
            if ne
                std ,y
                pshs x,y
                    ldy <pVram
                    tsta
                    if eq
                        ldb #CharHeight
                        bsr ClearN
                    else
                        pshs b
                            cmpa #Char_Enemy
                            if cs
                                ldx #PatternRam
                            else
                                ldx #ColorPatternSource_-PatternSize*Char_Enemy
                            endif
                            ldb #PatternSize
                            mul
                            leax d,x
                        puls b
                        tstb
                        if eq
                            ldb #CharHeight
                            bsr PutN
                            bra rowputend
                        endif
                        decb
                        if eq
                            ldb #CharHeight/2
                            bsr ClearN
                            ldb #CharHeight/2
                            bsr PutN
                            bra rowputend
                        endif
                        decb
                        if eq
                            leax PatternSize/2,x
                            ldb #CharHeight/2
                            bsr PutN
                            leax PatternSize*3,x
                            ldb #CharHeight/2
                            bsr PutN
                        else
                            leax PatternSize/2,x
                            ldb #CharHeight/2
                            bsr PutN
                            ldb #CharHeight/2
                            bsr ClearN
                        endif
                        rowputend:
                    endif
                    leay 2-VramWidth*CharHeight,y
                    sty <pVram
                puls x,y
            else
                pshs y
                    ldy <pVram
                    leay 2,y
                    sty <pVram
                puls y
            endif
            leay 2,y
        puls b
        decb
    while ne | wend
    pshs y
        ldy <pVram
        leay VramRowSize-VVramWidth/2*2,y
        sty <pVram
    puls y
rts


; void VVramToVramAll();
VVramToVramAll_: public VVramToVramAll_
    pshs a,b,x,y
        ldy #Vram | sty <pVram
        ldx #VVram_
        ldy #Backup
        ldb #VVramHeight
        do
            pshs b
                bsr VVramToVramRow
            puls b
            decb
        while ne | wend
    puls a,b,x,y
rts


; void VVramToVramChanged();
VVramToVramChanged_: public VVramToVramChanged_
    pshs a,b,x,y
        ldx #RowFlags_ | stx <pFlsgs
        lda #$01 | sta <bits
        lda ,x+ | sta <flagByte
        stx <pFlsgs

        ldy #Vram | sty <pVram
        ldx #VVram_
        ldy #Backup
        ldb #VVramHeight
        do
            pshs b
                ldb <flagByte
                andb <bits
                if ne
                    bsr VVramToVramRow
                else
                    leax VVramWidth,x
                    leay VVramWidth,y
                    pshs x
                        ldx <pVram
                        leax VramRowSize,x
                        stx <pVram
                    puls x
                endif                    
                lsl <bits
                if eq
                    pshs a,x
                        ldx <pFlsgs
                        lda ,x+ | sta <flagByte
                        lda #$01 | sta <bits
                        stx <pFlsgs
                    puls a,x
                endif
            puls b
            decb
        while ne | wend

        clr RowFlags_+0
        clr RowFlags_+1
        clr RowFlags_+2
    puls a,b,x,y
rts


; word PrintC(word vram, byte c);
PrintC_: public PrintC_
    pshs a,b,x,y
        tfr x,y
        subb #' '
        lda #CharHeight*4
        mul
        ldx #AsciiPatternRam
        leax d,x
        
        pshs cc | orcc #$50
            lda INIT1
            ora #$01
            sta INIT1

            ldb #CharHeight
            do
                pshs b
                    ldb #4
                    do
                        lda ,x+ | sta ,y+
                        decb
                    while ne | wend
                    leay VramWidth-4,y
                puls b
                decb
            while ne | wend

            lda INIT1
            anda #not $01
            sta INIT1
        puls cc
    puls a,b,x,y    
    tfr	x,d
    addd #4
rts