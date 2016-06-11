;[]-----------------------------------------------------------------[]
;|   CVTENTRY.NASM -- real number conversion entry points            |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision$

default rel

SECTION .data

%ifndef _UNICODE
extern _realcvtptr
extern _nextrealptr
extern _scantodptr
extern _scanrsltptr
%else
extern _realcvtwptr
extern _nextrealwptr
extern _scanwtodptr
extern _scanwrsltptr
%endif

; Entry points for the conversion functions

SECTION .text

%ifndef _UNICODE
global __realcvt
__realcvt:
        jmp [_realcvtptr]

global __nextreal
__nextreal:
        jmp [_nextrealptr]

global _scantod
_scantod:
        jmp [_scantodptr]

global _scanrslt
_scanrslt:
        jmp [_scanrsltptr]
%else
global __realcvtw
__realcvtw:
        jmp [_realcvtwptr]

global __nextrealw
__nextrealw:
        jmp [_nextrealwptr]

global _scanwtod
_scanwtod:
        jmp [_scanwtodptr]

global _scanrsltw
_scanrsltw:
        jmp [_scanwrsltptr]
%endif
