cseg

PatternRam_: public PatternRam_
; ascii
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $18,$18,$18,$18,$18,$00,$18,$00
	defb $36,$36,$36,$00,$00,$00,$00,$00
	defb $06,$37,$3e,$77,$3e,$76,$30,$00
	defb $08,$3f,$48,$3e,$09,$7e,$08,$00
	defb $00,$32,$54,$68,$16,$2a,$4c,$00
	defb $38,$6c,$6c,$38,$6b,$66,$3b,$00
	defb $0c,$18,$30,$00,$00,$00,$00,$00
	defb $0c,$18,$30,$30,$30,$18,$0c,$00
	defb $30,$18,$0c,$0c,$0c,$18,$30,$00
	defb $08,$2a,$1c,$7f,$1c,$2a,$08,$00
	defb $00,$18,$18,$7e,$18,$18,$00,$00
	defb $00,$00,$00,$00,$18,$18,$30,$00
	defb $00,$00,$00,$7e,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$18,$18,$00
	defb $00,$03,$06,$0c,$18,$30,$60,$00
	defb $3e,$63,$67,$6b,$73,$63,$3e,$00
	defb $18,$78,$18,$18,$18,$18,$7e,$00
	defb $3e,$63,$07,$1e,$3c,$70,$7f,$00
	defb $3e,$63,$03,$1e,$03,$63,$3e,$00
	defb $06,$0e,$1e,$36,$66,$7f,$06,$00
	defb $7f,$60,$7e,$03,$03,$63,$3e,$00
	defb $1e,$30,$60,$7e,$63,$63,$3e,$00
	defb $7f,$63,$06,$0c,$18,$18,$18,$00
	defb $3e,$63,$63,$3e,$63,$63,$3e,$00
	defb $3e,$63,$63,$3f,$03,$63,$3e,$00
	defb $00,$00,$18,$00,$00,$18,$00,$00
	defb $00,$00,$18,$00,$00,$18,$30,$00
	defb $0c,$18,$30,$60,$30,$18,$0c,$00
	defb $00,$00,$7e,$00,$7e,$00,$00,$00
	defb $30,$18,$0c,$06,$0c,$18,$30,$00
	defb $3e,$63,$03,$0e,$18,$00,$18,$00
	defb $1e,$21,$4d,$55,$4e,$20,$1e,$00
	defb $1c,$36,$63,$63,$7f,$63,$63,$00
	defb $7e,$63,$63,$7e,$63,$63,$7e,$00
	defb $1e,$33,$60,$60,$60,$33,$1e,$00
	defb $7c,$66,$63,$63,$63,$66,$7c,$00
	defb $7e,$60,$60,$7e,$60,$60,$7e,$00
	defb $7e,$60,$60,$7e,$60,$60,$60,$00
	defb $1e,$33,$60,$6f,$63,$33,$1f,$00
	defb $63,$63,$63,$7f,$63,$63,$63,$00
	defb $7e,$18,$18,$18,$18,$18,$7e,$00
	defb $06,$06,$06,$06,$06,$66,$3c,$00
	defb $63,$66,$6c,$78,$6c,$66,$63,$00
	defb $60,$60,$60,$60,$60,$60,$7e,$00
	defb $7e,$6b,$6b,$6b,$6b,$6b,$6b,$00
	defb $63,$73,$7b,$7f,$6f,$67,$63,$00
	defb $3e,$63,$63,$63,$63,$63,$3e,$00
	defb $7e,$63,$63,$63,$7e,$60,$60,$00
	defb $3e,$63,$63,$63,$6b,$66,$3b,$00
	defb $7e,$63,$63,$67,$7c,$6e,$67,$00
	defb $3e,$63,$60,$3e,$03,$63,$3e,$00
	defb $7e,$18,$18,$18,$18,$18,$18,$00
	defb $63,$63,$63,$63,$63,$63,$3e,$00
	defb $63,$63,$63,$36,$36,$1c,$1c,$00
	defb $63,$6b,$6b,$6b,$6b,$6b,$7e,$00
	defb $63,$63,$36,$1c,$36,$63,$63,$00
	defb $66,$66,$66,$3c,$18,$18,$18,$00
	defb $7f,$06,$0c,$18,$30,$60,$7f,$00
	defb $3c,$20,$20,$20,$20,$20,$3c,$00
	defb $22,$22,$14,$3e,$08,$3e,$08,$00
	defb $3c,$04,$04,$04,$04,$04,$3c,$00
	defb $08,$14,$22,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$7e,$00
; logo
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $f0,$f0,$f0,$f0,$00,$00,$00,$00
	defb $00,$00,$00,$00,$f0,$f0,$f0,$f0
	defb $f0,$f0,$f0,$f0,$f0,$f0,$f0,$f0
	defb $0f,$0f,$0f,$0f,$00,$00,$00,$00
	defb $ff,$ff,$ff,$ff,$00,$00,$00,$00
	defb $0f,$0f,$0f,$0f,$f0,$f0,$f0,$f0
	defb $ff,$ff,$ff,$ff,$f0,$f0,$f0,$f0
	defb $00,$00,$00,$00,$0f,$0f,$0f,$0f
	defb $f0,$f0,$f0,$f0,$0f,$0f,$0f,$0f
	defb $00,$00,$00,$00,$ff,$ff,$ff,$ff
	defb $f0,$f0,$f0,$f0,$ff,$ff,$ff,$ff
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $ff,$ff,$ff,$ff,$0f,$0f,$0f,$0f
	defb $0f,$0f,$0f,$0f,$ff,$ff,$ff,$ff
	defb $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
; Char_Wall
	defb $00,$7f,$77,$7b,$5d,$6e,$77,$7b
	defb $00,$fe,$77,$ba,$df,$ee,$77,$ba
	defb $5d,$6e,$77,$7b,$5d,$6e,$7f,$2a
	defb $df,$ee,$77,$ba,$df,$ee,$ff,$aa
; Char_Block
	defb $00,$3f,$60,$5f,$5f,$5f,$5f,$5f
	defb $00,$fc,$06,$fa,$fa,$fa,$fa,$fa
	defb $5f,$5f,$5f,$5f,$5f,$60,$3f,$00
	defb $fa,$fa,$fa,$fa,$fa,$06,$fc,$00
	defb $00,$37,$60,$56,$56,$0e,$4e,$50
	defb $00,$7c,$06,$f2,$ea,$d8,$1a,$ca
	defb $5b,$1c,$50,$46,$1d,$60,$3b,$00
	defb $e2,$48,$9a,$da,$d8,$06,$ec,$00
	defb $00,$00,$00,$00,$00,$07,$10,$36
	defb $00,$00,$00,$00,$00,$38,$c2,$da
	defb $4a,$1c,$40,$59,$5c,$02,$58,$38
	defb $c8,$02,$48,$da,$52,$98,$c6,$cc
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$0c,$10,$2e,$40,$1c,$42,$34
	defb $00,$80,$24,$d0,$da,$0a,$c2,$1c
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$14,$02,$65
	defb $00,$00,$00,$00,$00,$80,$62,$9a
	defb $00,$00,$00,$00,$00,$03,$06,$05
	defb $00,$00,$00,$00,$00,$c0,$60,$a0
	defb $05,$06,$03,$00,$00,$00,$00,$00
	defb $a0,$60,$c0,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$07,$0c,$0b,$0b
	defb $00,$00,$00,$00,$e0,$30,$d0,$d0
	defb $0b,$0b,$0c,$07,$00,$00,$00,$00
	defb $d0,$d0,$30,$e0,$00,$00,$00,$00
	defb $00,$00,$00,$0f,$18,$17,$17,$17
	defb $00,$00,$00,$f0,$18,$e8,$e8,$e8
	defb $17,$17,$17,$18,$0f,$00,$00,$00
	defb $e8,$e8,$e8,$18,$f0,$00,$00,$00
	defb $00,$00,$1f,$30,$2f,$2f,$2f,$2f
	defb $00,$00,$f8,$0c,$f4,$f4,$f4,$f4
	defb $2f,$2f,$2f,$2f,$30,$1f,$00,$00
	defb $f4,$f4,$f4,$f4,$0c,$f8,$00,$00
; Char_Man
	defb $00,$03,$07,$05,$05,$07,$03,$00
	defb $00,$c0,$e0,$60,$60,$e0,$c0,$00
	defb $01,$07,$07,$00,$06,$06,$0c,$1c
	defb $80,$80,$00,$c0,$60,$30,$30,$70
	defb $00,$03,$07,$05,$05,$07,$03,$00
	defb $00,$c0,$e0,$60,$60,$e0,$c0,$00
	defb $03,$1b,$1b,$03,$00,$01,$01,$03
	defb $f0,$f8,$d8,$c0,$c0,$80,$80,$80
	defb $00,$03,$07,$06,$06,$07,$03,$00
	defb $00,$c0,$e0,$a0,$a0,$e0,$c0,$00
	defb $01,$01,$00,$03,$06,$0c,$0c,$0e
	defb $80,$e0,$e0,$00,$60,$60,$30,$38
	defb $00,$03,$07,$06,$06,$07,$03,$00
	defb $00,$c0,$e0,$a0,$a0,$e0,$c0,$00

	defb $0f,$1f,$1b,$03,$03,$01,$01,$01
	defb $c0,$d8,$d8,$c0,$00,$80,$80,$c0
	defb $00,$07,$0f,$0f,$0f,$0f,$07,$00
	defb $00,$c0,$e0,$e0,$e0,$e0,$c0,$00
	defb $17,$17,$07,$06,$06,$06,$06,$06
	defb $f0,$d8,$d8,$c0,$c0,$c0,$00,$00
	defb $00,$07,$0f,$0f,$0f,$0f,$07,$00
	defb $00,$c0,$e0,$e0,$e0,$e0,$c0,$00
	defb $1f,$37,$37,$06,$06,$06,$00,$00
	defb $d0,$d0,$c0,$c0,$c0,$c0,$c0,$c0
	defb $00,$07,$0f,$0d,$0d,$0f,$07,$00
	defb $00,$c0,$e0,$60,$60,$e0,$c0,$00
	defb $1f,$37,$27,$06,$06,$06,$06,$06
	defb $a0,$b0,$70,$a0,$c0,$c0,$00,$00
	defb $00,$07,$0f,$0d,$0d,$0f,$07,$00
	defb $00,$c0,$e0,$60,$60,$e0,$c0,$00
	defb $0b,$1b,$1d,$0a,$06,$06,$00,$00
	defb $f0,$d8,$c8,$c0,$c0,$c0,$c0,$c0

	defb $00,$1e,$3f,$2b,$2b,$3f,$1e,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $9b,$fb,$77,$07,$09,$18,$0c,$1c
	defb $00,$80,$80,$c0,$e0,$60,$30,$70
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$78,$fc,$d4,$d4,$fc,$78,$00
	defb $00,$01,$01,$03,$07,$06,$0c,$0e
	defb $d9,$df,$ee,$e0,$90,$18,$30,$38
	defb $18,$0c,$08,$07,$0f,$0f,$0f,$0f
	defb $30,$60,$20,$c0,$e0,$e0,$e0,$e0
	defb $07,$00,$07,$07,$07,$06,$06,$06
	defb $c0,$00,$c0,$c0,$c0,$c0,$c0,$c0
	defb $00,$00,$00,$00,$07,$0f,$0f,$0d
	defb $00,$00,$00,$00,$c0,$e0,$e0,$60
	defb $0d,$07,$08,$1c,$0e,$06,$36,$60
	defb $60,$c0,$20,$70,$e0,$c0,$d8,$0c

; Char_Monster_Left0
	defb $04,$06,$0f,$1a,$1a,$1f,$15,$50
	defb $80,$c0,$e0,$f0,$f0,$f0,$70,$76
	defb $6f,$3f,$1f,$0f,$07,$03,$01,$00
	defb $ee,$fc,$f8,$f0,$e0,$e0,$f0,$78
; Char_Monster_Left1
	defb $00,$04,$06,$0f,$1a,$1a,$1f,$15
	defb $00,$80,$c0,$e0,$f0,$f0,$f0,$70
	defb $10,$3f,$7f,$df,$0f,$07,$03,$01
	defb $70,$f8,$fc,$f6,$f0,$e0,$f6,$fc
; Char_Monster_Right0
	defb $01,$03,$07,$0f,$0f,$0f,$0e,$6e
	defb $20,$60,$f0,$58,$58,$f8,$a8,$0a
	defb $77,$3f,$1f,$0f,$07,$07,$0f,$1e
	defb $f6,$fc,$f8,$f0,$e0,$c0,$80,$00
; Char_Monster_Right1
	defb $00,$01,$03,$07,$0f,$0f,$0f,$0e
	defb $00,$20,$60,$f0,$58,$58,$f8,$a8
	defb $0e,$1f,$3f,$6f,$0f,$07,$6f,$3f
	defb $08,$fc,$fe,$fb,$f0,$e0,$c0,$80
; Char_Monster_Up0
	defb $02,$06,$0f,$1f,$1f,$1f,$1f,$5f
	defb $40,$60,$f0,$f8,$f8,$f8,$f8,$fa
	defb $6f,$3f,$1f,$0f,$0f,$07,$03,$01
	defb $f6,$fc,$f8,$f0,$f0,$e0,$c0,$80
; Char_Monster_Up1
	defb $00,$02,$06,$0f,$1f,$1f,$1f,$1f
	defb $00,$40,$60,$f0,$f8,$f8,$f8,$f8
	defb $1f,$0f,$3f,$6f,$0f,$0f,$07,$03
	defb $f8,$f0,$fc,$f6,$f0,$f0,$e0,$c0
; Char_Monster_Down0
	defb $02,$06,$0f,$1d,$1d,$1f,$1a,$58
	defb $40,$60,$f0,$b8,$b8,$f8,$58,$1a
	defb $6f,$3f,$1f,$0f,$0f,$07,$03,$01
	defb $f6,$fc,$f8,$f0,$f0,$e0,$c0,$80
; Char_Monster_Down1
	defb $00,$02,$06,$0f,$1d,$1d,$1f,$1a
	defb $00,$40,$60,$f0,$b8,$b8,$f8,$58
	defb $18,$0f,$3f,$6f,$0f,$0f,$07,$03
	defb $18,$f0,$fc,$f6,$f0,$f0,$e0,$c0
; Char_Monster
	defb $00,$09,$0d,$1f,$35,$35,$3f,$2a
	defb $00,$00,$80,$c0,$e0,$e0,$e0,$e0
	defb $20,$95,$d7,$d7,$08,$07,$03,$01
	defb $e0,$c0,$c0,$e0,$e0,$e0,$f6,$fc
	defb $00,$00,$01,$03,$07,$07,$07,$07
	defb $00,$90,$b0,$f8,$ac,$ac,$fc,$54
	defb $07,$03,$03,$07,$07,$07,$6f,$3f
	defb $04,$a9,$eb,$eb,$10,$e0,$c0,$80
	defb $30,$18,$1a,$16,$0f,$1f,$1f,$1f
	defb $0c,$18,$58,$68,$f0,$f8,$f8,$f8
	defb $1f,$1f,$0f,$0f,$0f,$0f,$07,$03
	defb $f8,$f8,$f0,$f0,$f0,$f0,$e0,$c0
	defb $00,$00,$00,$02,$06,$0f,$1d,$1d
	defb $00,$00,$00,$40,$60,$f0,$b8,$b8
	defb $1f,$1a,$18,$0f,$17,$1b,$1d,$0c
	defb $f8,$58,$18,$f0,$e8,$d8,$b8,$30
; Char_Point
	defb $00,$00,$00,$00,$11,$32,$12,$12
	defb $00,$00,$00,$00,$8c,$52,$52,$52
	defb $12,$12,$39,$00,$00,$00,$00,$00
	defb $52,$52,$8c,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$31,$4a,$0a,$12
	defb $00,$00,$00,$00,$8c,$52,$52,$52
	defb $22,$42,$79,$00,$00,$00,$00,$00
	defb $52,$52,$8c,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$31,$52,$52,$52
	defb $00,$00,$00,$00,$8c,$52,$52,$52
	defb $7a,$12,$11,$00,$00,$00,$00,$00
	defb $52,$52,$8c,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$31,$4a,$4a,$32
	defb $00,$00,$00,$00,$8c,$52,$52,$52
	defb $4a,$4a,$31,$00,$00,$00,$00,$00
	defb $52,$52,$8c,$00,$00,$00,$00,$00



PaletteValues_: public PaletteValues_
	defb	$c0, $c0, $c0, $c0, $c0, $f0, $d8, $80
	defb	$c0, $e0, $c8, $e8, $c0, $c0, $c8, $f8

PaletteValues8c_: public PaletteValues8c_
	defb	$c0, $c0, $c0, $c0, $c0, $f0, $d8, $f8
	defb	$c0, $e0, $c8, $e8, $c0, $c0, $c8, $f8

; tableau des couleurs

; B7 : 1/2 teinte fond (1 = saturée, 0 = pastel)
; B6 : 1/2 teinte forme (1 = saturée, 0 = pastel)
; B543 : couleur forme
; B321 : couleur fond

; B V R teinte (saturée / pastel)
; 0 0 0 NOIR    $C0 / $80 GRIS
; 0 0 1 ROUGE   $C8 / $88 ROSE
; 0 1 0 VERT    $D0 / $90 VERT CLAIR
; 0 1 1 JAUNE   $D8 / $98 SABLE
; 1 0 0 BLEU    $E0 / $A0 BLEU CLAIR
; 1 0 1 MAGENTA $E8 / $A8 PARME
; 1 1 0 CYAN    $F0 / $B0 BLEU CIEL
; 1 1 1 BLANC   $F8 / $B8 ORANGE



ColorSource_: public ColorSource_
; Char_Man
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $0a,$0e,$0e,$00,$09,$09,$09,$0e
	defb $0a,$0a,$00,$09,$09,$09,$09,$0e
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $0a,$0a,$0a,$09,$00,$09,$09,$06
	defb $0a,$0a,$0a,$09,$09,$09,$09,$06
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $0a,$0a,$00,$09,$09,$09,$09,$06
	defb $0a,$0a,$0a,$00,$09,$09,$09,$06
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $0a,$0a,$0a,$09,$09,$09,$09,$06
	defb $0a,$0a,$0a,$09,$00,$09,$09,$06

	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $0a,$0a,$0a,$09,$09,$09,$09,$06
	defb $0a,$0a,$0a,$09,$09,$06,$00,$00
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $0a,$0a,$0a,$09,$09,$06,$00,$00
	defb $0a,$0a,$0a,$09,$09,$09,$09,$06
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $0a,$0a,$0a,$09,$09,$09,$09,$06
	defb $0a,$0a,$0a,$09,$09,$06,$00,$00
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $0a,$0a,$0a,$09,$09,$06,$00,$00
	defb $0a,$0a,$0a,$09,$09,$09,$09,$06

	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $0a,$0a,$0a,$09,$09,$09,$09,$06
	defb $00,$0a,$0a,$09,$09,$09,$09,$06
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $00,$0a,$0a,$09,$09,$09,$09,$06
	defb $0a,$0a,$0a,$09,$09,$09,$09,$06
	defb $06,$0a,$0a,$0f,$0f,$0f,$0f,$0f
	defb $06,$0a,$0a,$0f,$0f,$0f,$0f,$0f
	defb $0f,$00,$0a,$0a,$09,$09,$09,$06
	defb $0f,$00,$0a,$0a,$09,$09,$09,$06
	defb $00,$00,$00,$00,$0f,$0f,$0f,$0f
	defb $00,$00,$00,$00,$0f,$0f,$0f,$0f
	defb $0f,$0f,$0a,$0a,$0a,$0a,$09,$06
	defb $0f,$0f,$0a,$0a,$0a,$0a,$09,$06
