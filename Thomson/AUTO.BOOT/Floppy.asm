; Thomson Floppy Disk Boot Loader by OlivierP-To8
; https://github.com/OlivierP-To8

include '../ThomsonTO.inc'

FileSize equ $62fc
FileAddr equ $62fe

zseg
Direct: public Direct

dseg
FileEnd:
    defw $0000

cseg
    ; system stack = $608b-$60cc
    lds #DIRECT  ; Stack à zseg du makefile

    ; drive 0
    lda #$00
    sta DKDRV

    ; init controller
    lda #$01
    sta DKOPC

    ; call ROM
    jsr DKCONT
    if cs
        ; error
        lda DKSTA
    else
        ldd FileAddr
        addd FileSize
        std FileEnd

        lda #0          ; track
        ldb #2          ; sector
        ldx FileAddr    ; buffer
        do
            jsr ReadSector_
            incb
            leax 256,x
            cmpx FileEnd
        while lt | wend

        ldx FileAddr
        jmp ,X
    endif

swi


ReadSector_:
    pshs a,b

    ; track in A
    sta DKTRK

    ; sector in B
    stb DKSEC

    ; search for track DKTRK
    lda #$40
    sta DKOPC

    ; call ROM
    jsr DKCONT
    if cs
        ; error
        lda DKSTA
    else
        ; buffer address
        stx DKBUF

        ; read sector
        lda #$02
        sta DKOPC

        ; call ROM
        jsr DKCONT
        if cs
            ; error
            lda DKSTA
        endif
    endif

    puls a,b
rts

