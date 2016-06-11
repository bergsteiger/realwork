;----------------------------------------------------------------------
; _rfree.asm -  jump stubs for the for the PCRE functions
;----------------------------------------------------------------------

; $Copyright: 1998$
; $Revision: 23293 $

include rules.asi
include entry.inc

  Entry@ regfree,_pcre_regfree               , _RTLENTRY, 0

end
