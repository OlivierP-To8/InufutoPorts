; Thomson Floppy Disk Boot Loader by OlivierP-To8
; https://github.com/OlivierP-To8

include '../ThomsonTO.inc'

zseg
Direct: public Direct

dseg
Buffer   defs 256

cseg
    ; set S (system stack) register to ZSEG value from makefile
    lds #DIRECT

    ; set DP (direct page) register
    lda #$60
    tfr a,dp

    ; drive 0
    lda #$00
    sta <DKDRV

    ; load track 20 sector 1 in buffer
    ldd #$1401
    ldx #Buffer
    jsr ReadSector_
    tfr x,y
    leay 16,y           ; y points to first track and sector

    ; read sectors until FileEnd
    ldx Buffer+12       ; x = Address where to load file
    leax -5,x           ; starts 5 bytes before address to ignore bin header
    do
        ldd ,y++        ; AB = track/sector to read
        jsr ReadSector_
        leax 255,x      ; x = where to load next sector
        cmpx Buffer+14  ; Adress where file ends
    while lt | wend

    ldx Buffer+12       ; x = Address where to exec file
    jmp ,X

swi


ReadSector_:
    pshs a,b

    ; track in A
    sta <DKTRK

    ; sector in B
    stb <DKSEC

    ; buffer address
    stx <DKBUF

    ; read sector command
    lda #$02
    sta <DKOPC

    ; call ROM
    jsr DKCO
    if cs
        ; error
        lda <DKSTA
    endif

    puls a,b
rts

