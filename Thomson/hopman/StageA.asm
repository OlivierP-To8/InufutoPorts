ext @Temp@Word

ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
dseg
cseg
CellMapPtr_: public CellMapPtr_
    lsra | lsra
    sta <@Temp@Word+1
    clr <@Temp@Word
    lda #32
    mul
    addd <@Temp@Word
    addd #CellMap_
rts
