cseg

PatternRam_: public PatternRam_
include "../CharPat_Ascii.inc"
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
; Char_Floor
	defb $ff,$ff,$ff,$ff,$00,$00,$00,$00
; Char_Needle
	defb $10,$10,$38,$38,$7c,$7c,$fe,$fe
include "../CharPat_ManLeft.inc"
include "../CharPat_ManRight.inc"
include "../CharPat_ManLoose.inc"
; Char_Goal
	defb $00,$7f,$ff,$f0,$ef,$ec,$ee,$f0
	defb $00,$ff,$ff,$e3,$dd,$dd,$dd,$e3
	defb $00,$ff,$ff,$c7,$bb,$83,$bb,$bb
	defb $00,$fe,$ff,$7f,$7f,$7f,$7f,$07
	defb $ff,$7f,$00,$0e,$0e,$0e,$0e,$0e
	defb $ff,$ff,$00,$00,$00,$00,$00,$00
	defb $ff,$ff,$00,$00,$00,$00,$00,$00
	defb $ff,$fe,$00,$70,$70,$70,$70,$70
	defb $0e,$0e,$0e,$0e,$0e,$0e,$0e,$0e
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $70,$70,$70,$70,$70,$70,$70,$70
	defb $0e,$0e,$0e,$0e,$0e,$0e,$0e,$0e
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $70,$70,$70,$70,$70,$70,$70,$70
; Char_Item
	defb $00,$07,$07,$07,$07,$07,$07,$07
	defb $00,$f8,$f8,$f8,$f8,$f8,$f8,$f8
	defb $04,$04,$04,$04,$04,$04,$0e,$1f
	defb $00,$00,$00,$00,$00,$00,$00,$00
include "../CharPat_MonsterLeft.inc"
include "../CharPat_MonsterRight.inc"
; Char_Lift_Right
	defb $ff,$ff,$ff,$f8,$f8,$7f,$3f,$1f
	defb $ff,$7f,$3f,$1f,$1f,$3e,$7c,$f8
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
; Char_Lift_Left
	defb $ff,$fe,$fc,$f8,$f8,$7c,$3e,$1f
	defb $ff,$ff,$ff,$1f,$1f,$fe,$fc,$f8
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
; Char_Lift_Down
	defb $ff,$fe,$fe,$fe,$f8,$7c,$3e,$1f
	defb $ff,$7f,$7f,$7f,$1f,$3e,$7c,$f8
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
; Char_Lift_Up
	defb $ff,$fe,$fc,$f8,$fe,$7e,$3e,$1f
	defb $ff,$7f,$3f,$1f,$7f,$7e,$7c,$f8
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00



ColorSource_: public ColorSource_
include "../CharCol_ManLeft.inc"
include "../CharCol_ManRight.inc"
include "../CharCol_ManLoose.inc"
; Char_Goal
	defb $40,$50,$50,$50,$50,$50,$50,$50
	defb $40,$50,$50,$50,$50,$50,$50,$50
	defb $40,$50,$50,$50,$50,$50,$50,$50
	defb $40,$50,$50,$50,$50,$50,$50,$50
	defb $50,$50,$48,$48,$48,$48,$48,$48
	defb $50,$50,$40,$40,$40,$40,$40,$40
	defb $50,$50,$40,$40,$40,$40,$40,$40
	defb $50,$50,$48,$48,$48,$48,$48,$48
	defb $48,$48,$48,$48,$48,$48,$48,$48
	defb $40,$40,$40,$40,$40,$40,$40,$40
	defb $40,$40,$40,$40,$40,$40,$40,$40
	defb $48,$48,$48,$48,$48,$48,$48,$48
	defb $48,$48,$48,$48,$48,$48,$48,$48
	defb $40,$40,$40,$40,$40,$40,$40,$40
	defb $40,$40,$40,$40,$40,$40,$40,$40
	defb $48,$48,$48,$48,$48,$48,$48,$48
