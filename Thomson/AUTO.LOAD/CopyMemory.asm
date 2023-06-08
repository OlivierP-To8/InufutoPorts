; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
dseg
CopyMemory_@Param2: public CopyMemory_@Param2
    defw 0
cseg
CopyMemory_: public CopyMemory_
    pshs a,b,x,y
        ldd CopyMemory_@Param2
        do
            pshs a
                lda ,y+
                sta ,x+
            puls a
            subd #1
        while ne | wend
    puls a,b,x,y
rts

; void CopyToAddress(word pDestination, ptr<byte> pSource, word length);
dseg
CopyToAddress_@Param2: public CopyToAddress_@Param2
    defw 0
cseg
CopyToAddress_: public CopyToAddress_
    pshs a,b,x,y
        ldd CopyToAddress_@Param2
        do
            pshs a
                lda ,y+
                sta ,x+
            puls a
            subd #1
        while ne | wend
    puls a,b,x,y
rts
