; void FillMemory(ptr<byte> pDestination, word length, byte b);
dseg
FillMemory_@Param2: public FillMemory_@Param2
    defb 0
cseg
FillMemory_: public FillMemory_
    pshs a,x,y
        lda FillMemory_@Param2
        do
            sta ,x+
            leay -1,y
        while ne | wend
    puls a,x,y
rts
