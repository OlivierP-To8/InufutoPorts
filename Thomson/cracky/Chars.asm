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
; cracked floor
	defb $bf,$be,$dd,$d2,$ef,$6f,$b3,$bd
	defb $7d,$fd,$fb,$fb,$77,$cf,$b6,$b9
	defb $a8,$f0,$dc,$d2,$ea,$68,$b0,$b8
	defb $0d,$15,$0b,$a3,$57,$43,$12,$09
	defb $80,$e0,$c2,$d0,$e8,$4c,$b0,$80
	defb $00,$05,$0b,$43,$07,$09,$26,$01
	defb $80,$c0,$c0,$c0,$80,$00,$00,$00
	defb $00,$01,$03,$01,$01,$01,$00,$00
; hard floor
	defb $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
; ladder left
	defb $60,$7f,$7f,$60,$60,$7f,$7f,$60
; ladder right
	defb $06,$fe,$fe,$06,$06,$fe,$fe,$06
; item
	defb $00,$00,$00,$01,$01,$01,$7f,$3f
	defb $00,$80,$80,$c0,$c0,$c0,$ff,$fe
	defb $0f,$07,$07,$07,$0f,$0c,$08,$00
	defb $f8,$f0,$f0,$f0,$78,$18,$08,$00
; man left stop
	defb $00,$07,$0f,$0a,$0a,$0f,$07,$0f
	defb $00,$80,$c0,$c0,$c0,$c0,$80,$c0
	defb $17,$37,$37,$04,$0c,$0c,$0c,$0c
	defb $a0,$b0,$b0,$80,$c0,$c0,$c0,$c0
; man left0
	defb $00,$07,$0f,$0a,$0a,$0f,$07,$03
	defb $00,$80,$c0,$c0,$c0,$c0,$80,$80
	defb $37,$37,$07,$07,$0e,$1c,$38,$10
	defb $e0,$b0,$b0,$00,$e0,$e0,$00,$00
; man left1
	defb $00,$07,$0f,$0a,$0a,$0f,$07,$03
	defb $00,$80,$c0,$c0,$c0,$c0,$80,$80
	defb $03,$03,$07,$06,$00,$06,$06,$06
	defb $00,$00,$00,$00,$80,$80,$80,$00
; man left2
	defb $00,$07,$0f,$0a,$0a,$0f,$07,$03
	defb $00,$80,$c0,$c0,$c0,$c0,$80,$80
	defb $07,$1e,$1d,$03,$05,$0e,$1c,$08
	defb $a0,$b0,$b0,$80,$e0,$e0,$00,$00
; man right stop
	defb $00,$01,$03,$03,$03,$03,$01,$03
	defb $00,$e0,$f0,$50,$50,$f0,$e0,$f0
	defb $05,$0d,$0d,$01,$03,$03,$03,$03
	defb $e8,$ec,$ec,$20,$30,$30,$30,$30
; man right0
	defb $00,$01,$03,$03,$03,$03,$01,$01
	defb $00,$e0,$f0,$50,$50,$f0,$e0,$c0
	defb $07,$0d,$0d,$00,$07,$07,$00,$00
	defb $ec,$ec,$e0,$e0,$70,$38,$1c,$08
; man right1
	defb $00,$01,$03,$03,$03,$03,$01,$01
	defb $00,$e0,$f0,$50,$50,$f0,$e0,$c0
	defb $00,$00,$00,$00,$01,$01,$01,$00
	defb $c0,$c0,$e0,$60,$00,$60,$60,$60
; man right2
	defb $00,$01,$03,$03,$03,$03,$01,$01
	defb $00,$e0,$f0,$50,$50,$f0,$e0,$c0
	defb $05,$0d,$0d,$01,$07,$07,$00,$00
	defb $e0,$78,$b8,$c0,$a0,$70,$38,$10
; man updown0
	defb $00,$07,$0f,$0f,$0f,$0f,$07,$37
	defb $00,$80,$c0,$c0,$d8,$d8,$98,$f0
	defb $3f,$3f,$17,$07,$06,$06,$00,$00
	defb $e0,$c0,$c0,$c0,$c0,$c0,$c0,$c0
; man updown1
	defb $00,$03,$07,$07,$37,$37,$33,$1f
	defb $00,$c0,$e0,$e0,$e0,$e0,$c0,$d8
	defb $0f,$07,$07,$07,$06,$06,$06,$06
	defb $f8,$f8,$d0,$c0,$c0,$c0,$00,$00
; man loose0
	defb $00,$00,$00,$00,$00,$00,$3d,$7f
	defb $00,$00,$00,$00,$60,$e0,$0f,$ff
	defb $67,$7f,$67,$3d,$00,$00,$00,$00
	defb $e0,$e0,$ff,$0f,$e0,$60,$00,$00
; man loose1
	defb $03,$03,$03,$03,$01,$0d,$0d,$05
	defb $30,$30,$30,$30,$20,$ec,$ec,$e8
	defb $03,$01,$03,$03,$03,$03,$01,$00
	defb $f0,$e0,$f0,$50,$50,$f0,$e0,$00
; man loose2
	defb $00,$00,$06,$07,$f0,$ff,$07,$07
	defb $00,$00,$00,$00,$bc,$e6,$fe,$e6
	defb $ff,$f0,$07,$06,$00,$00,$00,$00
	defb $fe,$bc,$00,$00,$00,$00,$00,$00
; monster left0
	defb $04,$06,$0f,$1a,$1a,$1f,$15,$50
	defb $80,$c0,$e0,$f0,$f0,$f0,$70,$76
	defb $6f,$3f,$1f,$0f,$07,$03,$01,$00
	defb $ee,$fc,$f8,$f0,$e0,$e0,$f0,$78
; monster left1
	defb $00,$04,$06,$0f,$1a,$1a,$1f,$15
	defb $00,$80,$c0,$e0,$f0,$f0,$f0,$70
	defb $10,$3f,$7f,$df,$0f,$07,$03,$01
	defb $70,$f8,$fc,$f6,$f0,$e0,$f6,$fc
; monster right0
	defb $01,$03,$07,$0f,$0f,$0f,$0e,$6e
	defb $20,$60,$f0,$58,$58,$f8,$a8,$0a
	defb $77,$3f,$1f,$0f,$07,$07,$0f,$1e
	defb $f6,$fc,$f8,$f0,$e0,$c0,$80,$00
; monster right1
	defb $00,$01,$03,$07,$0f,$0f,$0f,$0e
	defb $00,$20,$60,$f0,$58,$58,$f8,$a8
	defb $0e,$1f,$3f,$6f,$0f,$07,$6f,$3f
	defb $08,$fc,$fe,$fb,$f0,$e0,$c0,$80
; monster up0
	defb $02,$06,$0f,$1f,$1f,$1f,$1f,$5f
	defb $40,$60,$f0,$f8,$f8,$f8,$f8,$fa
	defb $6f,$3f,$1f,$0f,$0f,$07,$03,$01
	defb $f6,$fc,$f8,$f0,$f0,$e0,$c0,$80
; monster up1
	defb $00,$02,$06,$0f,$1f,$1f,$1f,$1f
	defb $00,$40,$60,$f0,$f8,$f8,$f8,$f8
	defb $1f,$0f,$3f,$6f,$0f,$0f,$07,$03
	defb $f8,$f0,$fc,$f6,$f0,$f0,$e0,$c0
; monster down0
	defb $02,$06,$0f,$1d,$1d,$1f,$1a,$58
	defb $40,$60,$f0,$b8,$b8,$f8,$58,$1a
	defb $6f,$3f,$1f,$0f,$0f,$07,$03,$01
	defb $f6,$fc,$f8,$f0,$f0,$e0,$c0,$80
; monster down1
	defb $00,$02,$06,$0f,$1d,$1d,$1f,$1a
	defb $00,$40,$60,$f0,$b8,$b8,$f8,$58
	defb $18,$0f,$3f,$6f,$0f,$0f,$07,$03
	defb $18,$f0,$fc,$f6,$f0,$f0,$e0,$c0



PaletteValues_: public PaletteValues_
	defb	$c0, $e8, $e8, $e8, $e8, $f0, $e8, $80
	defb	$e8, $e0, $c8, $e8, $e8, $e8, $d8, $f8

PaletteValues8c_: public PaletteValues8c_
	defb	$c0, $e8, $e8, $e8, $e8, $f0, $e8, $d0
	defb	$e8, $e0, $c8, $e8, $e8, $e8, $d8, $f8

; tableau des couleurs

; B7 : 1/2 teinte fond (1 = saturée, 0 = pastel)
; B6 : 1/2 teinte forme (1 = saturée, 0 = pastel)
; B543 : couleur forme
; B321 : couleur fond

; B V R teinte (saturée / pastel)
; 0 0 0 NOIR    / GRIS
; 0 0 1 ROUGE   / ROSE
; 0 1 0 VERT    / VERT CLAIR
; 0 1 1 JAUNE   / SABLE
; 1 0 0 BLEU    / BLEU CLAIR
; 1 0 1 MAGENTA / PARME
; 1 1 0 CYAN    / BLEU CIEL
; 1 1 1 BLANC   / ORANGE



ColorSource_: public ColorSource_
; man left stop
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$0e,$09,$09,$09,$09,$0e
	defb $0a,$0a,$0e,$09,$09,$09,$09,$0e
; man left0
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0e,$0e,$09,$09,$09,$09,$0e,$0e
	defb $0a,$0a,$0e,$00,$0e,$0e,$00,$00
; man left1
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$0a,$0e,$00,$09,$09,$0e
	defb $00,$00,$00,$00,$09,$09,$0e,$00
; man left2
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0e,$0e,$09,$09,$09,$0e,$0e
	defb $0a,$0a,$0e,$09,$0e,$0e,$00,$00
; man right stop
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$0e,$09,$09,$09,$09,$0e
	defb $0a,$0a,$0e,$09,$09,$09,$09,$0e
; man right0
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$0e,$00,$0e,$0e,$00,$00
	defb $0e,$0e,$09,$09,$09,$09,$0e,$0e
; man right1
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$00,$00,$00,$09,$09,$0e,$00
	defb $0a,$0a,$0a,$0e,$00,$09,$09,$0e
; man right2
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$0e,$09,$0e,$0e,$00,$00
	defb $0a,$0e,$0e,$09,$09,$09,$0e,$0e
; man updown0
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0e
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$0a,$09,$09,$0e,$00,$00
	defb $0a,$0a,$0a,$09,$09,$09,$09,$0e
; man updown1
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0e
	defb $0a,$0a,$0a,$09,$09,$09,$09,$0e
	defb $0a,$0a,$0a,$09,$09,$0e,$00,$00
; man loose0
	defb $00,$00,$00,$00,$00,$00,$0f,$0f
	defb $00,$00,$00,$00,$0e,$0e,$0e,$0e
	defb $0f,$0f,$0f,$0f,$00,$00,$00,$00
	defb $0a,$0a,$0e,$0e,$0e,$0e,$00,$00
; man loose1
	defb $0e,$09,$09,$09,$09,$0e,$0a,$0a
	defb $0e,$09,$09,$09,$09,$0e,$0a,$0a
	defb $0a,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $0a,$0f,$0f,$0f,$0f,$0f,$0f,$00
; man loose2
	defb $00,$00,$0e,$0e,$0e,$0e,$0a,$0a
	defb $00,$00,$00,$00,$0f,$0f,$0f,$0f
	defb $0e,$0e,$0e,$0e,$00,$00,$00,$00
	defb $0f,$0f,$00,$00,$00,$00,$00,$00
; monster left0
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$00
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
; monster left1
	defb $00,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $00,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
; monster right0
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$00
; monster right1
	defb $00,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $00,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
; monster up0
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
; monster up1
	defb $00,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $00,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
; monster down0
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
; monster down1
	defb $00,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $00,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
	defb $0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b
