;[]-----------------------------------------------------------------[]
;|   FABSL.ASM -- absolute value                                             |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

;----------------------------------------------------------------------
; function(s)
;        fabsl - absolute value of long double
;----------------------------------------------------------------------

        include RULES.ASI

;       Segments Definitions

Header@

;--------------------------------------------------------------------------
;
;Name           fabsl - absolute value
;
;Usage          long double fabsl(long double x);
;
;Prototype in   math.h
;
;Description    fabsl calculates the absolute value of x, which may have any
;               value.
;
;Return value   fabsl returns the absolute value of x.
;
;--------------------------------------------------------------------------

Code_Seg@

Func@   fabsl, _EXPFUNC, _RTLENTRY, <longdouble x>

        Link@

        FLD     x.longdouble
        FABS

        Unlink@
        Return@

EndFunc@ fabsl

Code_EndS@
        end
