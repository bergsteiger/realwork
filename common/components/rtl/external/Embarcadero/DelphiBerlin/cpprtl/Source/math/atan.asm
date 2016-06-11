;[]-----------------------------------------------------------------[]
;|   ATAN.ASM -- trigonometric function                              |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

        include RULES.ASI
        include _MATH.INC

;       Segments Definitions

Header@

;----------------------------------------------------------------------
;
;Name            atan - trigonometric function
;
;Usage           double atan(double x);
;
;Prototype in    math.h
;
;Description     atan returns the arc tangent  of the input value, which may
;                be any finite value.
;
;Return value    atan returns a value in the range -pi/2 to pi/2.
;
;----------------------------------------------------------------------

Code_Seg@

Func@   atan, _EXPFUNC, _RTLENTRY,        <double x>

        Link@   ebx
        fld     x.double
        f87     ArcTan
        Unlink@ ebx
        Return@

EndFunc@ atan

Code_Ends@

        end
