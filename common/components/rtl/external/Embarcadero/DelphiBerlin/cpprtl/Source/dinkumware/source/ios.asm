	.386p
	ifdef ??version
	if ??version GT 500H
	.mmx
	endif
	endif
	model flat
	ifndef	??version
	?debug	macro
	endm
	endif
	?debug	S "ios.i"
	?debug	T "ios.i"
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
_DATA	segment dword public use32 'DATA'
_DATA	ends
_BSS	segment dword public use32 'BSS'
_BSS	ends
DGROUP	group	_BSS,_DATA
_DATA	segment dword public use32 'DATA'
	align	4
@std@_BADOFF	label	dword
	dd	-1
	align	4
@std@_Fpz	label	dword
	dd	0
_DATA	ends
_DATA	segment dword public use32 'DATA'
@std@ios_base@_Index	segment virtual
	align	2
@@std@ios_base@_Index	label	dword
	dd	0
@std@ios_base@_Index	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@std@ios_base@_Sync	segment virtual
@@std@ios_base@_Sync	label	byte
	db	1
@std@ios_base@_Sync	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
	align	4
@std@stdstr	label	dword
	dd	0
	db	36	dup(?)
@std@stdopens	label	byte
	db	0
	db	9	dup(?)
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$DCOP$@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo	segment virtual
	align	2
@@_$DCOP$@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo	label	dword
	dd	@@$xt$20std@ios_base@failure
	dd	4
	dd	-48
	dd	0
	dd	@@$xt$60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	dd	4
	dd	-88
	dd	@@$xt$20std@ios_base@failure
	dd	2052
	dd	-48
	dd	0
	dd	@@$xt$20std@ios_base@failure
	dd	4
	dd	-136
	dd	0
	dd	@@$xt$60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	dd	4
	dd	-176
	dd	@@$xt$20std@ios_base@failure
	dd	2052
	dd	-136
	dd	0
	dd	@@$xt$20std@ios_base@failure
	dd	4
	dd	-224
	dd	0
	dd	@@$xt$60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	dd	4
	dd	-264
	dd	@@$xt$20std@ios_base@failure
	dd	2052
	dd	-224
	dd	0
@_$DCOP$@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTPP$@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo	segment virtual
	align	2
@@_$ECTPP$@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo	label	dword
	dd	0
	dd	0
	dd	-300
	dw	0
	dw	5
	dd	0
	dd	@@_$DCOP$@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo
	dw	12
	dw	5
	dd	0
	dd	@@_$DCOP$@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo+16
	dw	0
	dw	5
	dd	0
	dd	@@_$DCOP$@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo+44
	dw	36
	dw	5
	dd	0
	dd	@@_$DCOP$@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo+60
	dw	0
	dw	5
	dd	0
	dd	@@_$DCOP$@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo+88
	dw	60
	dw	5
	dd	0
	dd	@@_$DCOP$@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo+104
@_$ECTPP$@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo	segment virtual
@@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo	proc	near
?live16387@0:
 ;	
 ;	/* ios.cpp 26: */void ios_base::clear(iostate state, bool reraise)
 ;	
	push      ebp
	mov       ebp,esp
	add       esp,-300
	push      ebx
	mov       ebx,dword ptr [ebp+8]
@1:
	mov       eax,offset @@_$ECTPP$@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo
	call      @__InitExceptBlockLDTC
 ;	
 ;	/* ios.cpp 27: */{	
 ;	/* ios.cpp 28: */_Mystate = (iostate)(state & _Statmask);
 ;	
?live16387@16: ; EBX = this
	mov       edx,dword ptr [ebp+12]
	and       edx,23
	mov       dword ptr [ebx+16],edx
 ;	
 ;	/* ios.cpp 29: */if ((_Mystate & _Except) == 0)
 ;	
	mov       ecx,dword ptr [ebx+16]
	and       ecx,dword ptr [ebx+20]
	test      ecx,ecx
	je        @2
 ;	
 ;	/* ios.cpp 30: */;
 ;	/* ios.cpp 31: */else if (reraise)
 ;	
	cmp       byte ptr [ebp+16],0
	je        short @3
 ;	
 ;	/* ios.cpp 32: */throw;
 ;	
?live16387@64: ; 
	push      0
	push      0
	call      @_ReThrowException$quipuc
	add       esp,8
	jmp @4
 ;	
 ;	/* ios.cpp 33: */else if (_Mystate & _Except & badbit)
 ;	
?live16387@80: ; EBX = this
@3:
	mov       eax,dword ptr [ebx+16]
	and       eax,dword ptr [ebx+20]
	and       eax,4
	test      eax,eax
	je        @5
 ;	
 ;	/* ios.cpp 34: */throw failure("ios_base::badbit set");
 ;	
?live16387@96: ; 
	lea       edx,dword ptr [ebp-300]
	push      edx
	push      0
	push      0
	push      0
	push      1
	push      offset @@std@ios_base@failure@$bctr$qrx20std@ios_base@failure
	push      0
	mov       word ptr [ebp-284],24
	push      offset s@+2
	lea       ecx,dword ptr [ebp-88]
	push      ecx
	call      @@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc
	add       esp,8
	add       dword ptr [ebp-272],0
	lea       eax,dword ptr [ebp-88]
	push      eax
	lea       edx,dword ptr [ebp-48]
	push      edx
	call      @@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	add       esp,8
	add       dword ptr [ebp-272],4
	dec       dword ptr [ebp-272]
	push      2
	lea       ecx,dword ptr [ebp-88]
	push      ecx
	call      @@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bdtr$qv
	add       esp,8
	mov       word ptr [ebp-284],12
	lea       eax,dword ptr [ebp-48]
	push      eax
	push      offset @@$xt$20std@ios_base@failure
	call      @_ThrowExceptionLDTC$qpvt1t1t1uiuiuipuct1
	add       esp,36
	jmp @4
 ;	
 ;	/* ios.cpp 35: */else if (_Mystate & _Except & failbit)
 ;	
?live16387@112: ; EBX = this
@5:
	mov       edx,dword ptr [ebx+16]
	and       edx,dword ptr [ebx+20]
	and       edx,2
	test      edx,edx
	je        @6
 ;	
 ;	/* ios.cpp 36: */throw failure("ios_base::failbit set");
 ;	
?live16387@128: ; 
	lea       ecx,dword ptr [ebp-300]
	push      ecx
	push      0
	push      0
	push      0
	push      1
	push      offset @@std@ios_base@failure@$bctr$qrx20std@ios_base@failure
	push      0
	mov       word ptr [ebp-284],48
	push      offset s@+23
	lea       eax,dword ptr [ebp-176]
	push      eax
	call      @@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc
	add       esp,8
	inc       dword ptr [ebp-272]
	lea       edx,dword ptr [ebp-176]
	push      edx
	lea       ecx,dword ptr [ebp-136]
	push      ecx
	call      @@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	add       esp,8
	add       dword ptr [ebp-272],4
	dec       dword ptr [ebp-272]
	push      2
	lea       eax,dword ptr [ebp-176]
	push      eax
	call      @@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bdtr$qv
	add       esp,8
	mov       word ptr [ebp-284],36
	lea       edx,dword ptr [ebp-136]
	push      edx
	push      offset @@$xt$20std@ios_base@failure
	call      @_ThrowExceptionLDTC$qpvt1t1t1uiuiuipuct1
	add       esp,36
	jmp @4
 ;	
 ;	/* ios.cpp 37: */else
 ;	/* ios.cpp 38: */throw failure("ios_base::eofbit set");
 ;	
@6:
	lea       ecx,dword ptr [ebp-300]
	push      ecx
	push      0
	push      0
	push      0
	push      1
	push      offset @@std@ios_base@failure@$bctr$qrx20std@ios_base@failure
	push      0
	mov       word ptr [ebp-284],72
	push      offset s@+45
	lea       eax,dword ptr [ebp-264]
	push      eax
	call      @@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc
	add       esp,8
	inc       dword ptr [ebp-272]
	lea       edx,dword ptr [ebp-264]
	push      edx
	lea       ecx,dword ptr [ebp-224]
	push      ecx
	call      @@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	add       esp,8
	add       dword ptr [ebp-272],4
	dec       dword ptr [ebp-272]
	push      2
	lea       eax,dword ptr [ebp-264]
	push      eax
	call      @@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bdtr$qv
	add       esp,8
	mov       word ptr [ebp-284],60
	lea       edx,dword ptr [ebp-224]
	push      edx
	push      offset @@$xt$20std@ios_base@failure
	call      @_ThrowExceptionLDTC$qpvt1t1t1uiuiuipuct1
	add       esp,36
 ;	
 ;	/* ios.cpp 39: */}
 ;	
@2:
@4:
	mov       ecx,dword ptr [ebp-300]
	mov       dword ptr fs:[0],ecx
@7:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo	endp
@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@copyfmt$qrx12std@ios_base	segment virtual
@@std@ios_base@copyfmt$qrx12std@ios_base	proc	near
?live16397@0:
 ;	
 ;	/* ios.cpp 41: */ios_base& ios_base::copyfmt(const ios_base& other)
 ;	
	push      ebp
	mov       ebp,esp
	add       esp,-8
	push      ebx
	push      esi
	push      edi
	mov       edi,dword ptr [ebp+12]
	mov       esi,dword ptr [ebp+8]
 ;	
 ;	/* ios.cpp 42: */{	
 ;	/* ios.cpp 43: */if (this != &other)
 ;	
?live16397@16: ; ESI = this, EDI = other
@8:
	cmp       edi,esi
	je        @9
 ;	
 ;	/* ios.cpp 44: */{	
 ;	/* ios.cpp 45: */_Tidy();
 ;	
@10:
	push      esi
	call      @@std@ios_base@_Tidy$qv
	pop       ecx
 ;	
 ;	/* ios.cpp 46: */*_Ploc = *other._Ploc;
 ;	
	push      dword ptr [edi+44]
	push      dword ptr [esi+44]
	call      @@std@locale@$basg$qrx10std@locale
	add       esp,8
 ;	
 ;	/* ios.cpp 47: */_Fmtfl = other._Fmtfl;
 ;	
	mov       eax,dword ptr [edi+24]
	mov       dword ptr [esi+24],eax
 ;	
 ;	/* ios.cpp 48: */_Prec = other._Prec;
 ;	
	mov       edx,dword ptr [edi+28]
	mov       dword ptr [esi+28],edx
 ;	
 ;	/* ios.cpp 49: */_Wide = other._Wide;
 ;	
	mov       ecx,dword ptr [edi+32]
	mov       dword ptr [esi+32],ecx
 ;	
 ;	/* ios.cpp 50: */_Iosarray *p = other._Arr;
 ;	
	mov       ebx,dword ptr [edi+36]
 ;	
 ;	/* ios.cpp 51: */
 ;	/* ios.cpp 52: */for (_Arr = 0; p != 0; p = p->_Next)
 ;	
?live16397@128: ; EBX = p, ESI = this, EDI = other
	xor       eax,eax
	mov       dword ptr [esi+36],eax
	test      ebx,ebx
	je        short @12
 ;	
 ;	/* ios.cpp 53: */if (p->_Lo != 0 || p->_Vp != 0)
 ;	
@11:
	cmp       dword ptr [ebx+8],0
	jne       short @14
	cmp       dword ptr [ebx+12],0
	je        short @13
 ;	
 ;	/* ios.cpp 54: */{	
 ;	/* ios.cpp 55: */iword(p->_Index) = p->_Lo;
 ;	
@14:
@15:
	mov       edx,dword ptr [ebx+4]
	mov       dword ptr [ebp-4],edx
	push      dword ptr [ebp-4]
	push      esi
	call      @@std@ios_base@_Findarr$qi
	add       esp,8
	add       eax,8
	mov       ecx,dword ptr [ebx+8]
	mov       dword ptr [eax],ecx
 ;	
 ;	/* ios.cpp 56: */pword(p->_Index) = p->_Vp;
 ;	
	mov       eax,dword ptr [ebx+4]
	mov       dword ptr [ebp-8],eax
	push      dword ptr [ebp-8]
	push      esi
	call      @@std@ios_base@_Findarr$qi
	add       esp,8
	add       eax,12
	mov       edx,dword ptr [ebx+12]
	mov       dword ptr [eax],edx
@16:
@13:
	mov       ebx,dword ptr [ebx]
	test      ebx,ebx
	jne       short @11
 ;	
 ;	/* ios.cpp 57: */}
 ;	/* ios.cpp 58: */
 ;	/* ios.cpp 59: */for (_Fnarray *q = other._Calls; q != 0; q = q->_Next)
 ;	
?live16397@192: ; ESI = this, EDI = other
@12:
@18:
	mov       ebx,dword ptr [edi+40]
	test      ebx,ebx
	je        short @20
 ;	
 ;	/* ios.cpp 60: */register_callback(q->_Pfn, q->_Index);	
 ;	
?live16397@208: ; ESI = this, EBX = q, EDI = other
@19:
	push      dword ptr [ebx+4]
	push      dword ptr [ebx+8]
	push      esi
	call      @@std@ios_base@register_callback$qpq18std@ios_base@eventr12std@ios_basei$vi
	add       esp,12
@21:
	mov       ebx,dword ptr [ebx]
	test      ebx,ebx
	jne       short @19
 ;	
 ;	/* ios.cpp 61: */
 ;	/* ios.cpp 62: */_Callfns(copyfmt_event);	
 ;	
?live16397@240: ; ESI = this, EDI = other
@20:
	push      2
	push      esi
	call      @@std@ios_base@_Callfns$q18std@ios_base@event
	add       esp,8
 ;	
 ;	/* ios.cpp 63: */exceptions(other._Except);	
 ;	
	mov       eax,dword ptr [edi+20]
	and       eax,23
	mov       dword ptr [esi+20],eax
	mov       eax,dword ptr [esi+16]
	push      0
	push      eax
	push      esi
	call      @@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo
	add       esp,12
 ;	
 ;	/* ios.cpp 64: */}
 ;	/* ios.cpp 65: */return (*this);
 ;	
?live16397@272: ; ESI = this
@23:
@9:
	mov       eax,esi
 ;	
 ;	/* ios.cpp 66: */}
 ;	
?live16397@288: ; 
@25:
@24:
	pop       edi
	pop       esi
	pop       ebx
	pop       ecx
	pop       ecx
	pop       ebp
	ret 
@@std@ios_base@copyfmt$qrx12std@ios_base	endp
@std@ios_base@copyfmt$qrx12std@ios_base	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$DCQP$@std@ios_base@imbue$qrx10std@locale	segment virtual
	align	2
@@_$DCQP$@std@ios_base@imbue$qrx10std@locale	label	dword
	dd	@@$xt$10std@locale
	dd	4
	dd	-16
	dd	0
	dd	@@$xt$10std@locale
	dd	4
	dd	-16
	dd	0
	dd	@@$xt$p10std@locale
	dd	20
	dd	8
	dd	0
	dd	@@$xt$p10std@locale
	dd	52
	dd	8
	dd	0
@_$DCQP$@std@ios_base@imbue$qrx10std@locale	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTRP$@std@ios_base@imbue$qrx10std@locale	segment virtual
	align	2
@@_$ECTRP$@std@ios_base@imbue$qrx10std@locale	label	dword
	dd	0
	dd	0
	dd	-52
	dw	0
	dw	5
	dd	0
	dd	@@_$DCQP$@std@ios_base@imbue$qrx10std@locale
	dw	12
	dw	5
	dd	0
	dd	@@_$DCQP$@std@ios_base@imbue$qrx10std@locale+16
	dw	12
	dw	5
	dd	1
	dd	@@_$DCQP$@std@ios_base@imbue$qrx10std@locale+32
	dw	36
	dw	5
	dd	1
	dd	@@_$DCQP$@std@ios_base@imbue$qrx10std@locale+48
@_$ECTRP$@std@ios_base@imbue$qrx10std@locale	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@imbue$qrx10std@locale	segment virtual
@@std@ios_base@imbue$qrx10std@locale	proc	near
?live16399@0:
 ;	
 ;	/* ios.cpp 68: */locale ios_base::imbue(const locale& loc)
 ;	
	push      ebp
	mov       ebp,esp
	add       esp,-52
	push      ebx
	mov       ebx,dword ptr [ebp+12]
@26:
	mov       eax,offset @@_$ECTRP$@std@ios_base@imbue$qrx10std@locale
	call      @__InitExceptBlockLDTC
 ;	
 ;	/* ios.cpp 69: */{	
 ;	/* ios.cpp 70: */locale oldlocale = *_Ploc;
 ;	
?live16399@16: ; EBX = this
	mov       word ptr [ebp-36],24
	push      dword ptr [ebx+44]
	lea       edx,dword ptr [ebp-16]
	push      edx
	call      @@std@locale@$bctr$qrx10std@locale
	add       esp,8
	inc       dword ptr [ebp-24]
	mov       word ptr [ebp-36],12
 ;	
 ;	/* ios.cpp 71: */*_Ploc = loc;
 ;	
	push      dword ptr [ebp+16]
	push      dword ptr [ebx+44]
	call      @@std@locale@$basg$qrx10std@locale
	add       esp,8
 ;	
 ;	/* ios.cpp 72: */_Callfns(imbue_event);
 ;	
	push      1
	push      ebx
	call      @@std@ios_base@_Callfns$q18std@ios_base@event
	add       esp,8
 ;	
 ;	/* ios.cpp 73: */return (oldlocale);
 ;	
?live16399@64: ; 
	mov       word ptr [ebp-36],36
	lea       ecx,dword ptr [ebp-16]
	push      ecx
	push      dword ptr [ebp+8]
	call      @@std@locale@$bctr$qrx10std@locale
	add       esp,8
	inc       dword ptr [ebp-24]
	mov       eax,dword ptr [ebp+8]
	mov       word ptr [ebp-36],48
	push      eax
	dec       dword ptr [ebp-24]
	push      2
	lea       edx,dword ptr [ebp-16]
	push      edx
	call      @@std@locale@$bdtr$qv
	add       esp,8
	pop       eax
	mov       word ptr [ebp-36],36
	inc       dword ptr [ebp-24]
	mov       edx,dword ptr [ebp-52]
	mov       dword ptr fs:[0],edx
 ;	
 ;	/* ios.cpp 74: */}
 ;	
@28:
@27:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@ios_base@imbue$qrx10std@locale	endp
@std@ios_base@imbue$qrx10std@locale	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$DCSP$@std@ios_base@register_callback$qpq18std@ios_base@eventr12std@ios_basei$vi	segment virtual
	align	2
@@_$DCSP$@std@ios_base@register_callback$qpq18std@ios_base@eventr12std@ios_basei$vi	label	dword
	dd	@@$xt$p21std@ios_base@_Fnarray
	dd	8199
	dd	-4
	dd	0
@_$DCSP$@std@ios_base@register_callback$qpq18std@ios_base@eventr12std@ios_basei$vi	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTTP$@std@ios_base@register_callback$qpq18std@ios_base@eventr12std@ios_basei$vi	segment virtual
	align	2
@@_$ECTTP$@std@ios_base@register_callback$qpq18std@ios_base@eventr12std@ios_basei$vi	label	dword
	dd	0
	dd	0
	dd	-40
	dw	0
	dw	5
	dd	0
	dd	0
	dw	12
	dw	5
	dd	0
	dd	@@_$DCSP$@std@ios_base@register_callback$qpq18std@ios_base@eventr12std@ios_basei$vi
@_$ECTTP$@std@ios_base@register_callback$qpq18std@ios_base@eventr12std@ios_basei$vi	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@register_callback$qpq18std@ios_base@eventr12std@ios_basei$vi	segment virtual
@@std@ios_base@register_callback$qpq18std@ios_base@eventr12std@ios_basei$vi	proc	near
?live16406@0:
 ;	
 ;	/* ios.cpp 76: */void ios_base::register_callback(event_callback pfn, int idx)
 ;	
	push      ebp
	mov       ebp,esp
	add       esp,-40
	push      ebx
	mov       ebx,dword ptr [ebp+8]
@29:
	mov       eax,offset @@_$ECTTP$@std@ios_base@register_callback$qpq18std@ios_base@eventr12std@ios_basei$vi
	call      @__InitExceptBlockLDTC
 ;	
 ;	/* ios.cpp 77: */{	
 ;	/* ios.cpp 78: */_Calls = new _Fnarray(idx, pfn, _Calls);
 ;	
?live16406@16: ; EBX = this
	push      12
	call      @$bnew$qui
	pop       ecx
	mov       dword ptr [ebp-4],eax
	test      eax,eax
	je        short @30
	mov       word ptr [ebp-24],24
	push      dword ptr [ebx+40]
	push      dword ptr [ebp+12]
	push      dword ptr [ebp+16]
	push      dword ptr [ebp-4]
	call      @@std@ios_base@_Fnarray@$bctr$qipq18std@ios_base@eventr12std@ios_basei$vp21std@ios_base@_Fnarray
	add       esp,16
	mov       word ptr [ebp-24],12
	mov       edx,dword ptr [ebp-4]
	jmp short @31
@30:
	mov       edx,dword ptr [ebp-4]
@31:
	mov       dword ptr [ebx+40],edx
 ;	
 ;	/* ios.cpp 79: */}
 ;	
?live16406@32: ; 
	mov       eax,dword ptr [ebp-40]
	mov       dword ptr fs:[0],eax
@32:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@ios_base@register_callback$qpq18std@ios_base@eventr12std@ios_basei$vi	endp
@std@ios_base@register_callback$qpq18std@ios_base@eventr12std@ios_basei$vi	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$ECTUP$@std@ios_base@$bdtr$qv	segment virtual
	align	2
@@_$ECTUP$@std@ios_base@$bdtr$qv	label	dword
	dd	0
	dd	0
	dd	-36
@_$ECTUP$@std@ios_base@$bdtr$qv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@$bdtr$qv	segment virtual
@@std@ios_base@$bdtr$qv	proc	near
?live16411@0:
 ;	
 ;	/* ios.cpp 81: */ios_base::~ios_base()
 ;	
	push      ebp
	mov       ebp,esp
	add       esp,-36
	push      ebx
	mov       ebx,dword ptr [ebp+8]
@33:
	mov       eax,offset @@_$ECTUP$@std@ios_base@$bdtr$qv
	call      @__InitExceptBlockLDTC
	test      ebx,ebx
	je        short @35
	mov       edx,offset @@std@ios_base@3+12
	mov       dword ptr [ebx+8],edx
 ;	
 ;	/* ios.cpp 82: */{	
 ;	/* ios.cpp 83: */if (0 < _Stdstr && 0 < --stdopens[_Stdstr])
 ;	
?live16411@16: ; EBX = this
	cmp       dword ptr [ebx+12],0
	jbe       short @36
	mov       ecx,dword ptr [ebx+12]
	dec       byte ptr [ecx+@std@stdopens]
	mov       al,byte ptr [ecx+@std@stdopens]
	test      al,al
	jle       short @36
 ;	
 ;	/* ios.cpp 84: */return;
 ;	
	mov       edx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],edx
	jmp short @37
 ;	
 ;	/* ios.cpp 85: */_Tidy();
 ;	
@36:
	push      ebx
	call      @@std@ios_base@_Tidy$qv
	pop       ecx
 ;	
 ;	/* ios.cpp 86: */delete (_Ploc);
 ;	
	push      3
	push      dword ptr [ebx+44]
	call      @@std@locale@$bdtr$qv
	add       esp,8
@37:
	test      byte ptr [ebp+12],1
	je        short @38
	push      ebx
	call      @$bdele$qpv
	pop       ecx
 ;	
 ;	/* ios.cpp 87: */}
 ;	
?live16411@80: ; 
@38:
@35:
	mov       ecx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],ecx
@39:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@ios_base@$bdtr$qv	endp
@std@ios_base@$bdtr$qv	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@_Callfns$q18std@ios_base@event	segment virtual
@@std@ios_base@_Callfns$q18std@ios_base@event	proc	near
?live16413@0:
 ;	
 ;	/* ios.cpp 89: */void ios_base::_Callfns(event ev)
 ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	push      esi
	push      edi
	mov       edi,dword ptr [ebp+12]
	mov       esi,dword ptr [ebp+8]
 ;	
 ;	/* ios.cpp 90: */{	
 ;	/* ios.cpp 91: */for (_Fnarray *p = _Calls; p != 0; p = p->_Next)
 ;	
?live16413@16: ; ESI = this, EDI = ev
@40:
@41:
	mov       ebx,dword ptr [esi+40]
	test      ebx,ebx
	je        short @43
 ;	
 ;	/* ios.cpp 92: */(*p->_Pfn)(ev, *this, p->_Index);
 ;	
?live16413@32: ; EBX = p, ESI = this, EDI = ev
@42:
	push      dword ptr [ebx+4]
	push      esi
	push      edi
	call      dword ptr [ebx+8]
	add       esp,12
@44:
	mov       ebx,dword ptr [ebx]
	test      ebx,ebx
	jne       short @42
 ;	
 ;	/* ios.cpp 93: */}
 ;	
?live16413@64: ; 
@43:
@46:
	pop       edi
	pop       esi
	pop       ebx
	pop       ebp
	ret 
@@std@ios_base@_Callfns$q18std@ios_base@event	endp
@std@ios_base@_Callfns$q18std@ios_base@event	ends
_TEXT	ends
_BSS	segment dword public use32 'BSS'
	align	4
$ibdcnaia	label	byte
	db	16	dup(?)
_BSS	ends
_DATA	segment dword public use32 'DATA'
$ilonmaia	label	byte
	db	0
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$DCVP$@std@ios_base@_Findarr$qi	segment virtual
	align	2
@@_$DCVP$@std@ios_base@_Findarr$qi	label	dword
	dd	@@$xt$p22std@ios_base@_Iosarray
	dd	8199
	dd	-4
	dd	0
@_$DCVP$@std@ios_base@_Findarr$qi	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTWP$@std@ios_base@_Findarr$qi	segment virtual
	align	2
@@_$ECTWP$@std@ios_base@_Findarr$qi	label	dword
	dd	0
	dd	0
	dd	-40
	dw	0
	dw	5
	dd	0
	dd	0
	dw	12
	dw	5
	dd	0
	dd	@@_$DCVP$@std@ios_base@_Findarr$qi
@_$ECTWP$@std@ios_base@_Findarr$qi	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@_Findarr$qi	segment virtual
@@std@ios_base@_Findarr$qi	proc	near
?live16414@0:
 ;	
 ;	/* ios.cpp 95: */ios_base::_Iosarray& ios_base::_Findarr(int idx)
 ;	
	push      ebp
	mov       ebp,esp
	add       esp,-40
	push      ebx
	mov       ebx,dword ptr [ebp+12]
@47:
	mov       eax,offset @@_$ECTWP$@std@ios_base@_Findarr$qi
	call      @__InitExceptBlockLDTC
 ;	
 ;	/* ios.cpp 96: */{	
 ;	/* ios.cpp 97: */static _Iosarray stub(0, 0);
 ;	
?live16414@16: ; EBX = idx
	cmp       byte ptr [$ilonmaia],0
	jne       short @48
	push      0
	push      0
	push      offset $ibdcnaia
	call      @@std@ios_base@_Iosarray@$bctr$qip22std@ios_base@_Iosarray
	add       esp,12
	inc       byte ptr [$ilonmaia]
 ;	
 ;	/* ios.cpp 98: */_Iosarray *p, *q;
 ;	/* ios.cpp 99: */
 ;	/* ios.cpp 100: */if (idx < 0)
 ;	
@48:
	test      ebx,ebx
	jge       short @49
 ;	
 ;	/* ios.cpp 101: */{	
 ;	/* ios.cpp 102: */setstate(badbit);
 ;	
?live16414@48: ; 
@50:
	push      0
	mov       edx,dword ptr [ebp+8]
	mov       ecx,dword ptr [edx+16]
	or        ecx,4
	push      ecx
	push      dword ptr [ebp+8]
	call      @@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo
	add       esp,12
 ;	
 ;	/* ios.cpp 103: */return (stub);
 ;	
	mov       eax,offset $ibdcnaia
	mov       edx,dword ptr [ebp-40]
	mov       dword ptr fs:[0],edx
	jmp @51
 ;	
 ;	/* ios.cpp 104: */}
 ;	/* ios.cpp 105: */
 ;	/* ios.cpp 106: */for (p = _Arr, q = 0; p != 0; p = p->_Next)
 ;	
?live16414@80: ; EBX = idx
@52:
@49:
	mov       ecx,dword ptr [ebp+8]
	mov       eax,dword ptr [ecx+36]
	xor       edx,edx
	test      eax,eax
	je        short @54
 ;	
 ;	/* ios.cpp 107: */if (p->_Index == idx)
 ;	
?live16414@96: ; EAX = p, EDX = q, EBX = idx
@53:
	cmp       ebx,dword ptr [eax+4]
	jne       short @55
 ;	
 ;	/* ios.cpp 108: */return (*p);	
 ;	
?live16414@112: ; EAX = p
	mov       ecx,dword ptr [ebp-40]
	mov       dword ptr fs:[0],ecx
	jmp short @51
 ;	
 ;	/* ios.cpp 109: */else if (q == 0 && p->_Lo == 0 && p->_Vp == 0)
 ;	
?live16414@128: ; EAX = p, EDX = q, EBX = idx
@55:
	test      edx,edx
	jne       short @56
	cmp       dword ptr [eax+8],0
	jne       short @56
	cmp       dword ptr [eax+12],0
	jne       short @56
 ;	
 ;	/* ios.cpp 110: */q = p;	
 ;	
?live16414@144: ; EAX = p, EBX = idx
	mov       edx,eax
@56:
	mov       eax,dword ptr [eax]
	test      eax,eax
	jne       short @53
 ;	
 ;	/* ios.cpp 111: */
 ;	/* ios.cpp 112: */if (q != 0)
 ;	
?live16414@160: ; EDX = q, EBX = idx
@54:
	test      edx,edx
	je        short @59
 ;	
 ;	/* ios.cpp 113: */{	
 ;	/* ios.cpp 114: */q->_Index = idx;
 ;	
@60:
	mov       dword ptr [edx+4],ebx
 ;	
 ;	/* ios.cpp 115: */return (*q);
 ;	
?live16414@192: ; EDX = q
	mov       eax,edx
	mov       ecx,dword ptr [ebp-40]
	mov       dword ptr fs:[0],ecx
	jmp short @51
 ;	
 ;	/* ios.cpp 116: */}
 ;	/* ios.cpp 117: */
 ;	/* ios.cpp 118: */_Arr = new _Iosarray(idx, _Arr);	
 ;	
?live16414@208: ; EBX = idx
@61:
@59:
	push      16
	call      @$bnew$qui
	pop       ecx
	mov       dword ptr [ebp-4],eax
	test      eax,eax
	je        short @62
	mov       word ptr [ebp-24],24
	mov       edx,dword ptr [ebp+8]
	push      dword ptr [edx+36]
	push      ebx
	push      dword ptr [ebp-4]
	call      @@std@ios_base@_Iosarray@$bctr$qip22std@ios_base@_Iosarray
	add       esp,12
	mov       word ptr [ebp-24],12
	mov       ecx,dword ptr [ebp-4]
	jmp short @63
@62:
	mov       ecx,dword ptr [ebp-4]
@63:
	mov       eax,dword ptr [ebp+8]
	mov       dword ptr [eax+36],ecx
 ;	
 ;	/* ios.cpp 119: */return (*_Arr);
 ;	
?live16414@224: ; 
	mov       edx,dword ptr [ebp+8]
	mov       eax,dword ptr [edx+36]
	mov       edx,dword ptr [ebp-40]
	mov       dword ptr fs:[0],edx
 ;	
 ;	/* ios.cpp 120: */}
 ;	
@64:
@51:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@ios_base@_Findarr$qi	endp
@std@ios_base@_Findarr$qi	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$DCXP$@std@ios_base@_Addstd$qv	segment virtual
	align	2
@@_$DCXP$@std@ios_base@_Addstd$qv	label	dword
	dd	@@$xt$11std@_Lockit
	dd	4
	dd	-8
	dd	0
	dd	@@$xt$11std@_Lockit
	dd	4
	dd	-8
	dd	0
@_$DCXP$@std@ios_base@_Addstd$qv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTYP$@std@ios_base@_Addstd$qv	segment virtual
	align	2
@@_$ECTYP$@std@ios_base@_Addstd$qv	label	dword
	dd	0
	dd	0
	dd	-44
	dw	0
	dw	5
	dd	0
	dd	@@_$DCXP$@std@ios_base@_Addstd$qv+16
	dw	0
	dw	5
	dd	0
	dd	@@_$DCXP$@std@ios_base@_Addstd$qv
@_$ECTYP$@std@ios_base@_Addstd$qv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@_Addstd$qv	segment virtual
@@std@ios_base@_Addstd$qv	proc	near
?live16419@0:
 ;	
 ;	/* ios.cpp 122: */void ios_base::_Addstd()
 ;	
	push      ebp
	mov       ebp,esp
	add       esp,-44
	push      ebx
	push      esi
	mov       ebx,dword ptr [ebp+8]
	mov       esi,offset @std@stdstr
@65:
	mov       eax,offset @@_$ECTYP$@std@ios_base@_Addstd$qv
	call      @__InitExceptBlockLDTC
 ;	
 ;	/* ios.cpp 123: */{	
 ;	/* ios.cpp 124: */_Lockit lock(2);
 ;	
?live16419@16: ; EBX = this, ESI = &@std@stdstr
	mov       word ptr [ebp-28],12
	push      2
	lea       edx,dword ptr [ebp-8]
	push      edx
	call      @@std@_Lockit@$bctr$qi
	add       esp,8
	inc       dword ptr [ebp-16]
	mov       word ptr [ebp-28],24
 ;	
 ;	/* ios.cpp 125: */
 ;	/* ios.cpp 126: */for (_Stdstr = 0; ++_Stdstr < 8; )
 ;	
	xor       ecx,ecx
	mov       dword ptr [ebx+12],ecx
	jmp short @67
 ;	
 ;	/* ios.cpp 127: */if (stdstr[_Stdstr] == 0 || stdstr[_Stdstr] == this)
 ;	
@66:
	mov       eax,dword ptr [ebx+12]
	cmp       dword ptr [esi+4*eax],0
	je        short @70
	mov       edx,dword ptr [ebx+12]
	cmp       ebx,dword ptr [esi+4*edx]
	je        short @70
 ;	
 ;	/* ios.cpp 128: */break;	
 ;	
@67:
	inc       dword ptr [ebx+12]
	mov       ecx,dword ptr [ebx+12]
	cmp       ecx,8
	jb        short @66
 ;	
 ;	/* ios.cpp 129: */
 ;	/* ios.cpp 130: */stdstr[_Stdstr] = this;
 ;	
@70:
	mov       eax,dword ptr [ebx+12]
	mov       dword ptr [esi+4*eax],ebx
 ;	
 ;	/* ios.cpp 131: */++stdopens[_Stdstr];
 ;	
?live16419@96: ; EBX = this
	mov       edx,dword ptr [ebx+12]
	inc       byte ptr [edx+@std@stdopens]
 ;	
 ;	/* ios.cpp 132: */}
 ;	
?live16419@112: ; 
	dec       dword ptr [ebp-16]
	push      2
	lea       ecx,dword ptr [ebp-8]
	push      ecx
	call      @@std@_Lockit@$bdtr$qv
	add       esp,8
	mov       eax,dword ptr [ebp-44]
	mov       dword ptr fs:[0],eax
@72:
	pop       esi
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@ios_base@_Addstd$qv	endp
@std@ios_base@_Addstd$qv	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$DCZP$@std@ios_base@_Init$qv	segment virtual
	align	2
@@_$DCZP$@std@ios_base@_Init$qv	label	dword
	dd	@@$xt$p10std@locale
	dd	8199
	dd	-4
	dd	0
@_$DCZP$@std@ios_base@_Init$qv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTAQ$@std@ios_base@_Init$qv	segment virtual
	align	2
@@_$ECTAQ$@std@ios_base@_Init$qv	label	dword
	dd	0
	dd	0
	dd	-40
	dw	0
	dw	5
	dd	0
	dd	0
	dw	12
	dw	5
	dd	0
	dd	@@_$DCZP$@std@ios_base@_Init$qv
@_$ECTAQ$@std@ios_base@_Init$qv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@_Init$qv	segment virtual
@@std@ios_base@_Init$qv	proc	near
?live16425@0:
 ;	
 ;	/* ios.cpp 134: */void ios_base::_Init()
 ;	
	push      ebp
	mov       ebp,esp
	add       esp,-40
	push      ebx
	mov       ebx,dword ptr [ebp+8]
@73:
	mov       eax,offset @@_$ECTAQ$@std@ios_base@_Init$qv
	call      @__InitExceptBlockLDTC
 ;	
 ;	/* ios.cpp 135: */{	
 ;	/* ios.cpp 136: */_Ploc = new locale;
 ;	
?live16425@16: ; EBX = this
	push      16
	call      @$bnew$qui
	pop       ecx
	mov       dword ptr [ebp-4],eax
	test      eax,eax
	je        short @74
	mov       word ptr [ebp-24],24
	push      dword ptr [ebp-4]
	call      @@std@locale@$bctr$qv
	pop       ecx
	mov       word ptr [ebp-24],12
	mov       edx,dword ptr [ebp-4]
	jmp short @75
@74:
	mov       edx,dword ptr [ebp-4]
@75:
	mov       dword ptr [ebx+44],edx
 ;	
 ;	/* ios.cpp 137: */_Except = goodbit;
 ;	
	xor       eax,eax
	mov       dword ptr [ebx+20],eax
 ;	
 ;	/* ios.cpp 138: */_Fmtfl = skipws | dec;
 ;	
	mov       dword ptr [ebx+24],17
 ;	
 ;	/* ios.cpp 139: */_Prec = 6;
 ;	
	mov       dword ptr [ebx+28],6
 ;	
 ;	/* ios.cpp 140: */_Wide = 0;
 ;	
	xor       ecx,ecx
	mov       dword ptr [ebx+32],ecx
 ;	
 ;	/* ios.cpp 141: */_Arr = 0;
 ;	
	xor       eax,eax
	mov       dword ptr [ebx+36],eax
 ;	
 ;	/* ios.cpp 142: */_Calls = 0;
 ;	
	xor       edx,edx
	mov       dword ptr [ebx+40],edx
 ;	
 ;	/* ios.cpp 143: */clear(goodbit);
 ;	
	push      0
	push      0
	push      ebx
	call      @@std@ios_base@clear$q22std@%_Iosb$i%@_Iostateo
	add       esp,12
 ;	
 ;	/* ios.cpp 144: */}
 ;	
?live16425@144: ; 
	mov       ecx,dword ptr [ebp-40]
	mov       dword ptr fs:[0],ecx
@76:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@ios_base@_Init$qv	endp
@std@ios_base@_Init$qv	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@_Tidy$qv	segment virtual
@@std@ios_base@_Tidy$qv	proc	near
?live16428@0:
 ;	
 ;	/* ios.cpp 146: */void ios_base::_Tidy()
 ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	push      esi
	mov       esi,dword ptr [ebp+8]
 ;	
 ;	/* ios.cpp 147: */{	
 ;	/* ios.cpp 148: */_Callfns(erase_event);
 ;	
?live16428@16: ; ESI = this
@77:
	push      0
	push      esi
	call      @@std@ios_base@_Callfns$q18std@ios_base@event
	add       esp,8
 ;	
 ;	/* ios.cpp 149: */_Iosarray *q1, *q2;
 ;	/* ios.cpp 150: */
 ;	/* ios.cpp 151: */for (q1 = _Arr; q1 != 0; q1 = q2)
 ;	
	mov       eax,dword ptr [esi+36]
	test      eax,eax
	je        short @79
 ;	
 ;	/* ios.cpp 152: */q2 = q1->_Next, delete (q1);	
 ;	
?live16428@48: ; EAX = q1, ESI = this
@78:
	mov       ebx,dword ptr [eax]
	push      eax
	call      @$bdele$qpv
	pop       ecx
	mov       eax,ebx
	test      eax,eax
	jne       short @78
 ;	
 ;	/* ios.cpp 153: */_Arr = 0;
 ;	
?live16428@64: ; ESI = this
@79:
	xor       edx,edx
	mov       dword ptr [esi+36],edx
 ;	
 ;	/* ios.cpp 154: */
 ;	/* ios.cpp 155: */_Fnarray *q3, *q4;
 ;	/* ios.cpp 156: */for (q3 = _Calls; q3 != 0; q3 = q4)
 ;	
	mov       eax,dword ptr [esi+40]
	test      eax,eax
	je        short @82
 ;	
 ;	/* ios.cpp 157: */q4 = q3->_Next, delete (q3);	
 ;	
?live16428@96: ; EAX = q3, ESI = this
@81:
	mov       ebx,dword ptr [eax]
	push      eax
	call      @$bdele$qpv
	pop       ecx
	mov       eax,ebx
	test      eax,eax
	jne       short @81
 ;	
 ;	/* ios.cpp 158: */_Calls = 0;
 ;	
?live16428@112: ; ESI = this
@82:
	xor       edx,edx
	mov       dword ptr [esi+40],edx
 ;	
 ;	/* ios.cpp 159: */}
 ;	
?live16428@128: ; 
@84:
	pop       esi
	pop       ebx
	pop       ebp
	ret 
@@std@ios_base@_Tidy$qv	endp
@std@ios_base@_Tidy$qv	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$DCBQ$@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	segment virtual
	align	2
@@_$DCBQ$@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	label	dword
	dd	@@$xt$p20std@ios_base@failure
	dd	5
	dd	8
	dd	0
@_$DCBQ$@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTCQ$@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	segment virtual
	align	2
@@_$ECTCQ$@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	label	dword
	dd	0
	dd	0
	dd	-36
	dw	0
	dw	5
	dd	0
	dd	@@_$DCBQ$@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
@_$ECTCQ$@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	segment virtual
@@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	proc	near
?live16388@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
@85:
	mov       eax,offset @@_$ECTCQ$@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	call      @__InitExceptBlockLDTC
	mov       word ptr [ebp-20],12
	push      dword ptr [ebp+12]
	push      dword ptr [ebp+8]
	call      @@std@runtime_error@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	add       esp,8
	add       dword ptr [ebp-8],3
	mov       edx,offset @@std@ios_base@failure@3+12
	mov       ecx,dword ptr [ebp+8]
	mov       dword ptr [ecx],edx
	mov       eax,dword ptr [ebp-36]
	mov       dword ptr fs:[0],eax
	mov       eax,dword ptr [ebp+8]
@87:
@86:
	mov       esp,ebp
	pop       ebp
	ret 
@@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	endp
@std@ios_base@failure@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$TLDQ$@std@ios_base@failure@$bdtr$qv	segment virtual
	align	2
@@_$TLDQ$@std@ios_base@failure@$bdtr$qv	label	dword
	dd	0
@_$TLDQ$@std@ios_base@failure@$bdtr$qv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$DCEQ$@std@ios_base@failure@$bdtr$qv	segment virtual
	align	2
@@_$DCEQ$@std@ios_base@failure@$bdtr$qv	label	dword
	dd	@@$xt$p20std@ios_base@failure
	dd	5
	dd	8
	dd	0
@_$DCEQ$@std@ios_base@failure@$bdtr$qv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTFQ$@std@ios_base@failure@$bdtr$qv	segment virtual
	align	2
@@_$ECTFQ$@std@ios_base@failure@$bdtr$qv	label	dword
	dd	@@_$TLDQ$@std@ios_base@failure@$bdtr$qv
	dd	0
	dd	-36
	dw	0
	dw	5
	dd	0
	dd	@@_$DCEQ$@std@ios_base@failure@$bdtr$qv
@_$ECTFQ$@std@ios_base@failure@$bdtr$qv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@failure@$bdtr$qv	segment virtual
@@std@ios_base@failure@$bdtr$qv	proc	near
?live16389@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
@88:
	mov       eax,offset @@_$ECTFQ$@std@ios_base@failure@$bdtr$qv
	call      @__InitExceptBlockLDTC
	mov       dword ptr [ebp-8],3
	dec       dword ptr [ebp-8]
	cmp       dword ptr [ebp+8],0
	je        short @89
	mov       word ptr [ebp-20],12
	mov       edx,offset @@std@ios_base@failure@3+12
	mov       ecx,dword ptr [ebp+8]
	mov       dword ptr [ecx],edx
	sub       dword ptr [ebp-8],3
	push      0
	push      dword ptr [ebp+8]
	call      @@std@runtime_error@$bdtr$qv
	add       esp,8
	test      byte ptr [ebp+12],1
	je        short @90
	push      dword ptr [ebp+8]
	call      @$bdele$qpv
	pop       ecx
@90:
@89:
	mov       eax,dword ptr [ebp-36]
	mov       dword ptr fs:[0],eax
@91:
	mov       esp,ebp
	pop       ebp
	ret 
@@std@ios_base@failure@$bdtr$qv	endp
@std@ios_base@failure@$bdtr$qv	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bdtr$qv	segment virtual
@@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bdtr$qv	proc	near
?live16391@0:
	push      ebp
	mov       ebp,esp
	push      ebx
	push      esi
	push      edi
	mov       ebx,dword ptr [ebp+8]
@92:
	test      ebx,ebx
	je        short @93
?live16391@16: ; EBX = this
	cmp       dword ptr [ebx+36],16
	jb        short @94
	mov       esi,dword ptr [ebx+16]
	mov       edi,esi
	push      edi
	call      @$bdele$qpv
	pop       ecx
@94:
@95:
	mov       dword ptr [ebx+36],15
	xor       eax,eax
	cmp       dword ptr [ebx+36],16
	jb        short @96
	mov       edx,dword ptr [ebx+16]
	jmp short @97
@96:
	lea       edx,dword ptr [ebx+16]
@97:
	xor       ecx,ecx
	mov       dword ptr [ebx+32],ecx
	add       edx,ecx
	mov       byte ptr [edx],al
	test      byte ptr [ebp+12],1
	je        short @98
	push      ebx
	call      @$bdele$qpv
	pop       ecx
?live16391@32: ; 
@98:
@93:
@99:
	pop       edi
	pop       esi
	pop       ebx
	pop       ebp
	ret 
@@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bdtr$qv	endp
@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bdtr$qv	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$ECTGQ$@std@ios_base@failure@$bctr$qrx20std@ios_base@failure	segment virtual
	align	2
@@_$ECTGQ$@std@ios_base@failure@$bctr$qrx20std@ios_base@failure	label	dword
	dd	0
	dd	0
	dd	-36
@_$ECTGQ$@std@ios_base@failure@$bctr$qrx20std@ios_base@failure	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@failure@$bctr$qrx20std@ios_base@failure	segment virtual
@@std@ios_base@failure@$bctr$qrx20std@ios_base@failure	proc	near
?live16392@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
	push      ebx
	push      esi
	push      edi
	mov       esi,dword ptr [ebp+12]
	mov       ebx,dword ptr [ebp+8]
@100:
	mov       eax,offset @@_$ECTGQ$@std@ios_base@failure@$bctr$qrx20std@ios_base@failure
	call      @__InitExceptBlockLDTC
	mov       edi,esi
	mov       edx,offset @@std@exception@3+12
	mov       dword ptr [ebx],edx
	inc       dword ptr [ebp-8]
	add       edi,8
	push      edi
	lea       eax,dword ptr [ebx+8]
	push      eax
	call      @@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	add       esp,8
	add       dword ptr [ebp-8],0
	mov       edx,offset @@std@runtime_error@3+12
	mov       dword ptr [ebx],edx
	inc       dword ptr [ebp-8]
	mov       ecx,offset @@std@ios_base@failure@3+12
	mov       dword ptr [ebx],ecx
	mov       eax,ebx
	mov       edx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],edx
@102:
@101:
	pop       edi
	pop       esi
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@ios_base@failure@$bctr$qrx20std@ios_base@failure	endp
@std@ios_base@failure@$bctr$qrx20std@ios_base@failure	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$DCHQ$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc	segment virtual
	align	2
@@_$DCHQ$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc	label	dword
	dd	@@$xt$p60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	dd	5
	dd	8
	dd	0
@_$DCHQ$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTIQ$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc	segment virtual
	align	2
@@_$ECTIQ$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc	label	dword
	dd	0
	dd	0
	dd	-36
	dw	0
	dw	5
	dd	0
	dd	@@_$DCHQ$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc
@_$ECTIQ$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc	segment virtual
@@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc	proc	near
?live16393@0:
	push      ebp
	mov       ebp,esp
	add       esp,-236
	push      ebx
	push      esi
	push      edi
	lea       ebx,dword ptr [ebp+8]
@103:
	mov       eax,offset @@_$ECTIQ$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc
	call      @__InitExceptBlockLDTC
?live16393@16: ; EBX = &this
	mov       word ptr [ebp-20],12
	add       esp,-8
	push      esp
	call      @@std@%allocator$c%@$bctr$qv
	pop       ecx
	push      dword ptr [ebx]
	call      @@std@%_String_val$c17std@%allocator$c%%@$bctr$q17std@%allocator$c%
	add       esp,12
	mov       edx,dword ptr [ebx]
	mov       dword ptr [edx+36],15
	xor       eax,eax
	mov       edx,dword ptr [ebx]
	xor       ecx,ecx
	mov       dword ptr [edx+32],ecx
	mov       edx,ecx
	mov       ecx,dword ptr [ebx]
	cmp       dword ptr [ecx+36],16
	jb        short @104
	mov       ecx,dword ptr [ebx]
	mov       ecx,dword ptr [ecx+16]
	jmp short @105
@104:
	mov       ecx,dword ptr [ebx]
	add       ecx,16
@105:
	add       edx,ecx
	mov       byte ptr [edx],al
	mov       edi,dword ptr [ebp+12]
	push      edi
	call      @_strlen
	pop       ecx
	mov       esi,eax
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @111
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [edx+16]
	jmp short @112
@111:
	mov       ecx,dword ptr [ebx]
	add       ecx,16
@112:
	cmp       edi,ecx
	jb        short @110
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @113
	mov       edx,dword ptr [ebx]
	mov       eax,dword ptr [edx+16]
	jmp short @114
@113:
	mov       eax,dword ptr [ebx]
	add       eax,16
@114:
	mov       edx,dword ptr [ebx]
	add       eax,dword ptr [edx+32]
	cmp       edi,eax
	jb        short @108
@110:
	xor       ecx,ecx
	jmp short @109
@108:
	mov       cl,1
@109:
	test      cl,cl
	je        @106
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @115
	mov       edx,dword ptr [ebx]
	mov       eax,dword ptr [edx+16]
	jmp short @116
@115:
	mov       eax,dword ptr [ebx]
	add       eax,16
@116:
	sub       edi,eax
	mov       dword ptr [ebp-40],edi
	mov       edx,dword ptr [ebx]
	mov       dword ptr [ebp-44],edx
	mov       ecx,dword ptr [ebp-44]
	mov       eax,dword ptr [ecx+32]
	cmp       eax,dword ptr [ebp-40]
	jae       short @117
	push      dword ptr [ebx]
	call      @@std@_String_base@_Xran$xqv
	pop       ecx
@117:
@118:
	mov       edx,dword ptr [ebp-44]
	mov       ecx,dword ptr [edx+32]
	sub       ecx,dword ptr [ebp-40]
	mov       dword ptr [ebp-48],ecx
	cmp       esi,dword ptr [ebp-48]
	jae       short @119
	mov       dword ptr [ebp-48],esi
@119:
@120:
	mov       eax,dword ptr [ebx]
	cmp       eax,dword ptr [ebp-44]
	jne       @121
	mov       dword ptr [ebp-52],-1
	mov       edx,dword ptr [ebp-40]
	add       edx,dword ptr [ebp-48]
	mov       dword ptr [ebp-56],edx
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+32]
	cmp       eax,dword ptr [ebp-56]
	jae       short @123
	push      dword ptr [ebx]
	call      @@std@_String_base@_Xran$xqv
	pop       ecx
@123:
@124:
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [edx+32]
	sub       ecx,dword ptr [ebp-56]
	cmp       ecx,dword ptr [ebp-52]
	jae       short @125
	mov       eax,dword ptr [ebx]
	mov       edx,dword ptr [eax+32]
	sub       edx,dword ptr [ebp-56]
	mov       dword ptr [ebp-52],edx
@125:
@126:
	cmp       dword ptr [ebp-52],0
	jbe       @127
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+32]
	sub       eax,dword ptr [ebp-56]
	sub       eax,dword ptr [ebp-52]
	mov       dword ptr [ebp-60],eax
	mov       edx,dword ptr [ebx]
	cmp       dword ptr [edx+36],16
	jb        short @129
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+16]
	jmp short @130
@129:
	mov       eax,dword ptr [ebx]
	add       eax,16
@130:
	add       eax,dword ptr [ebp-56]
	add       eax,dword ptr [ebp-52]
	mov       dword ptr [ebp-64],eax
	mov       edx,dword ptr [ebx]
	cmp       dword ptr [edx+36],16
	jb        short @131
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+16]
	jmp short @132
@131:
	mov       eax,dword ptr [ebx]
	add       eax,16
@132:
	add       eax,dword ptr [ebp-56]
	mov       dword ptr [ebp-68],eax
	push      dword ptr [ebp-60]
	push      dword ptr [ebp-64]
	push      dword ptr [ebp-68]
	call      @_memmove
	add       esp,12
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [edx+32]
	sub       ecx,dword ptr [ebp-52]
	mov       dword ptr [ebp-72],ecx
	mov       eax,dword ptr [ebp-72]
	mov       dword ptr [ebp-76],eax
	mov       byte ptr [ebp-77],0
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [ebp-76]
	mov       dword ptr [edx+32],ecx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @133
	mov       edx,dword ptr [ebx]
	mov       eax,dword ptr [edx+16]
	jmp short @134
@133:
	mov       eax,dword ptr [ebx]
	add       eax,16
@134:
	add       ecx,eax
	mov       dword ptr [ebp-84],ecx
	mov       edx,dword ptr [ebp-84]
	mov       cl,byte ptr [ebp-77]
	mov       byte ptr [edx],cl
@127:
@128:
	mov       eax,dword ptr [ebp-40]
	mov       dword ptr [ebp-88],eax
	mov       edx,dword ptr [ebx]
	cmp       dword ptr [edx+32],0
	jae       short @135
	push      dword ptr [ebx]
	call      @@std@_String_base@_Xran$xqv
	pop       ecx
@135:
@136:
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+32]
	cmp       eax,dword ptr [ebp-88]
	jae       short @137
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [edx+32]
	mov       dword ptr [ebp-88],ecx
@137:
@138:
	cmp       dword ptr [ebp-88],0
	jbe       @107
	mov       eax,dword ptr [ebx]
	mov       edx,dword ptr [eax+32]
	sub       edx,dword ptr [ebp-88]
	mov       dword ptr [ebp-92],edx
	mov       ecx,dword ptr [ebx]
	cmp       dword ptr [ecx+36],16
	jb        short @141
	mov       eax,dword ptr [ebx]
	mov       edx,dword ptr [eax+16]
	jmp short @142
@141:
	mov       edx,dword ptr [ebx]
	add       edx,16
@142:
	add       edx,dword ptr [ebp-88]
	mov       dword ptr [ebp-96],edx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @143
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+16]
	jmp short @144
@143:
	mov       eax,dword ptr [ebx]
	add       eax,16
@144:
	mov       dword ptr [ebp-100],eax
	push      dword ptr [ebp-92]
	push      dword ptr [ebp-96]
	push      dword ptr [ebp-100]
	call      @_memmove
	add       esp,12
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [edx+32]
	sub       ecx,dword ptr [ebp-88]
	mov       dword ptr [ebp-104],ecx
	mov       eax,dword ptr [ebp-104]
	mov       dword ptr [ebp-108],eax
	mov       byte ptr [ebp-109],0
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [ebp-108]
	mov       dword ptr [edx+32],ecx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @145
	mov       edx,dword ptr [ebx]
	mov       eax,dword ptr [edx+16]
	jmp short @146
@145:
	mov       eax,dword ptr [ebx]
	add       eax,16
@146:
	add       ecx,eax
	mov       dword ptr [ebp-116],ecx
	mov       edx,dword ptr [ebp-116]
	mov       cl,byte ptr [ebp-109]
	mov       byte ptr [edx],cl
	jmp @107
@121:
	mov       eax,dword ptr [ebp-48]
	mov       dword ptr [ebp-120],eax
	mov       edx,dword ptr [ebx]
	add       edx,8
	push      edx
	call      @@std@%allocator$c%@max_size$xqv
	pop       ecx
	mov       dword ptr [ebp-124],eax
	cmp       dword ptr [ebp-124],1
	ja        short @151
	mov       ecx,1
	jmp short @152
@151:
	mov       ecx,dword ptr [ebp-124]
	dec       ecx
@152:
	cmp       ecx,dword ptr [ebp-120]
	jae       short @149
	push      dword ptr [ebx]
	call      @@std@_String_base@_Xlen$xqv
	pop       ecx
@149:
@150:
	mov       eax,dword ptr [ebx]
	mov       edx,dword ptr [eax+36]
	cmp       edx,dword ptr [ebp-120]
	jae       @155
	mov       eax,dword ptr [ebx]
	push      dword ptr [eax+32]
	push      dword ptr [ebp-120]
	push      dword ptr [ebx]
	call      @@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui
	add       esp,12
	jmp @154
	jmp @155
	cmp       dword ptr [ebp-120],16
	jae       @155
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [edx+32]
	cmp       ecx,dword ptr [ebp-120]
	jbe       short @157
	mov       eax,dword ptr [ebp-120]
@157:
	mov       edx,dword ptr [ebx]
	mov       eax,dword ptr [edx+32]
	mov       dword ptr [ebp-128],eax
	mov       edx,dword ptr [ebx]
	cmp       dword ptr [edx+36],16
	jb        short @159
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+16]
	mov       dword ptr [ebp-132],eax
	cmp       dword ptr [ebp-128],0
	jbe       short @161
	mov       edx,dword ptr [ebp-132]
	mov       dword ptr [ebp-136],edx
	mov       ecx,dword ptr [ebx]
	add       ecx,16
	mov       dword ptr [ebp-140],ecx
	push      dword ptr [ebp-128]
	push      dword ptr [ebp-136]
	push      dword ptr [ebp-140]
	call      @_memcpy
	add       esp,12
@161:
@162:
	mov       eax,dword ptr [ebp-132]
	mov       dword ptr [ebp-144],eax
	push      dword ptr [ebp-144]
	call      @$bdele$qpv
	pop       ecx
@159:
@160:
	mov       edx,dword ptr [ebx]
	mov       dword ptr [edx+36],15
	mov       byte ptr [ebp-145],0
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ebp-128]
	mov       dword ptr [ecx+32],eax
	mov       edx,dword ptr [ebx]
	cmp       dword ptr [edx+36],16
	jb        short @163
	mov       ecx,dword ptr [ebx]
	mov       edx,dword ptr [ecx+16]
	jmp short @164
@163:
	mov       edx,dword ptr [ebx]
	add       edx,16
@164:
	add       eax,edx
	mov       dword ptr [ebp-152],eax
	mov       eax,dword ptr [ebp-152]
	mov       cl,byte ptr [ebp-145]
	mov       byte ptr [eax],cl
	jmp short @156
@155:
	cmp       dword ptr [ebp-120],0
	jne       short @165
	mov       byte ptr [ebp-153],0
	mov       eax,dword ptr [ebx]
	xor       edx,edx
	mov       dword ptr [eax+32],edx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @167
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+16]
	jmp short @168
@167:
	mov       eax,dword ptr [ebx]
	add       eax,16
@168:
	add       edx,eax
	mov       dword ptr [ebp-160],edx
	mov       edx,dword ptr [ebp-160]
	mov       cl,byte ptr [ebp-153]
	mov       byte ptr [edx],cl
@165:
@166:
@156:
@154:
	cmp       dword ptr [ebp-120],0
	seta      al
	and       eax,1
	test      al,al
	je        @107
	mov       edx,dword ptr [ebp-48]
	mov       dword ptr [ebp-164],edx
	mov       ecx,dword ptr [ebp-44]
	cmp       dword ptr [ecx+36],16
	jb        short @169
	mov       eax,dword ptr [ebp-44]
	mov       edx,dword ptr [eax+16]
	jmp short @170
@169:
	mov       edx,dword ptr [ebp-44]
	add       edx,16
@170:
	add       edx,dword ptr [ebp-40]
	mov       dword ptr [ebp-168],edx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @171
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+16]
	jmp short @172
@171:
	mov       eax,dword ptr [ebx]
	add       eax,16
@172:
	mov       dword ptr [ebp-172],eax
	push      dword ptr [ebp-164]
	push      dword ptr [ebp-168]
	push      dword ptr [ebp-172]
	call      @_memcpy
	add       esp,12
	mov       edx,dword ptr [ebp-48]
	mov       dword ptr [ebp-176],edx
	mov       byte ptr [ebp-177],0
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ebp-176]
	mov       dword ptr [ecx+32],eax
	mov       edx,dword ptr [ebx]
	cmp       dword ptr [edx+36],16
	jb        short @173
	mov       ecx,dword ptr [ebx]
	mov       edx,dword ptr [ecx+16]
	jmp short @174
@173:
	mov       edx,dword ptr [ebx]
	add       edx,16
@174:
	add       eax,edx
	mov       dword ptr [ebp-184],eax
	mov       eax,dword ptr [ebp-184]
	mov       cl,byte ptr [ebp-177]
	mov       byte ptr [eax],cl
	jmp @107
@106:
	mov       eax,dword ptr [ebx]
	add       eax,8
	push      eax
	call      @@std@%allocator$c%@max_size$xqv
	pop       ecx
	mov       dword ptr [ebp-188],eax
	cmp       dword ptr [ebp-188],1
	ja        short @179
	mov       edx,1
	jmp short @180
@179:
	mov       edx,dword ptr [ebp-188]
	dec       edx
@180:
	cmp       esi,edx
	jbe       short @177
	push      dword ptr [ebx]
	call      @@std@_String_base@_Xlen$xqv
	pop       ecx
@177:
@178:
	mov       eax,dword ptr [ebx]
	cmp       esi,dword ptr [eax+36]
	jbe       @183
	mov       ecx,dword ptr [ebx]
	push      dword ptr [ecx+32]
	push      esi
	push      dword ptr [ebx]
	call      @@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui
	add       esp,12
	jmp @182
	jmp @183
	cmp       esi,16
	jae       @183
	mov       eax,dword ptr [ebx]
	cmp       esi,dword ptr [eax+32]
	jae       short @185
	mov       edx,esi
@185:
	mov       ecx,dword ptr [ebx]
	mov       edx,dword ptr [ecx+32]
	mov       dword ptr [ebp-192],edx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @187
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+16]
	mov       dword ptr [ebp-196],eax
	cmp       dword ptr [ebp-192],0
	jbe       short @189
	mov       edx,dword ptr [ebp-196]
	mov       dword ptr [ebp-200],edx
	mov       ecx,dword ptr [ebx]
	add       ecx,16
	mov       dword ptr [ebp-204],ecx
	push      dword ptr [ebp-192]
	push      dword ptr [ebp-200]
	push      dword ptr [ebp-204]
	call      @_memcpy
	add       esp,12
@189:
@190:
	mov       eax,dword ptr [ebp-196]
	mov       dword ptr [ebp-208],eax
	push      dword ptr [ebp-208]
	call      @$bdele$qpv
	pop       ecx
@187:
@188:
	mov       edx,dword ptr [ebx]
	mov       dword ptr [edx+36],15
	mov       byte ptr [ebp-209],0
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ebp-192]
	mov       dword ptr [ecx+32],eax
	mov       edx,dword ptr [ebx]
	cmp       dword ptr [edx+36],16
	jb        short @191
	mov       ecx,dword ptr [ebx]
	mov       edx,dword ptr [ecx+16]
	jmp short @192
@191:
	mov       edx,dword ptr [ebx]
	add       edx,16
@192:
	add       eax,edx
	mov       dword ptr [ebp-216],eax
	mov       eax,dword ptr [ebp-216]
	mov       cl,byte ptr [ebp-209]
	mov       byte ptr [eax],cl
	jmp short @184
@183:
	test      esi,esi
	jne       short @193
	mov       byte ptr [ebp-217],0
	mov       eax,dword ptr [ebx]
	xor       edx,edx
	mov       dword ptr [eax+32],edx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @195
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+16]
	jmp short @196
@195:
	mov       eax,dword ptr [ebx]
	add       eax,16
@196:
	add       edx,eax
	mov       dword ptr [ebp-224],edx
	mov       edx,dword ptr [ebp-224]
	mov       cl,byte ptr [ebp-217]
	mov       byte ptr [edx],cl
@193:
@194:
@184:
@182:
	test      esi,esi
	seta      al
	and       eax,1
	test      al,al
	je        short @175
	mov       edx,dword ptr [ebx]
	cmp       dword ptr [edx+36],16
	jb        short @197
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+16]
	jmp short @198
@197:
	mov       eax,dword ptr [ebx]
	add       eax,16
@198:
	mov       dword ptr [ebp-228],eax
	push      esi
	push      edi
	push      dword ptr [ebp-228]
	call      @_memcpy
	add       esp,12
	mov       byte ptr [ebp-229],0
	mov       edx,dword ptr [ebx]
	mov       dword ptr [edx+32],esi
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @199
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [edx+16]
	jmp short @200
@199:
	mov       ecx,dword ptr [ebx]
	add       ecx,16
@200:
	add       esi,ecx
	mov       dword ptr [ebp-236],esi
	mov       eax,dword ptr [ebp-236]
	mov       dl,byte ptr [ebp-229]
	mov       byte ptr [eax],dl
@175:
@176:
@107:
	mov       eax,dword ptr [ebp-36]
	mov       dword ptr fs:[0],eax
	mov       eax,dword ptr [ebx]
?live16393@80: ; 
@202:
@201:
	pop       edi
	pop       esi
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
?t1 = -256
@@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc	endp
@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qpxc	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$TLJQ$@std@locale@$basg$qrx10std@locale	segment virtual
	align	2
@@_$TLJQ$@std@locale@$basg$qrx10std@locale	label	dword
	dd	0
@_$TLJQ$@std@locale@$basg$qrx10std@locale	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$DCKQ$@std@locale@$basg$qrx10std@locale	segment virtual
	align	2
@@_$DCKQ$@std@locale@$basg$qrx10std@locale	label	dword
	dd	@@$xt$a2$p16std@locale@facet
	dd	20495
	dd	-8
	dd	0
@_$DCKQ$@std@locale@$basg$qrx10std@locale	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTLQ$@std@locale@$basg$qrx10std@locale	segment virtual
	align	2
@@_$ECTLQ$@std@locale@$basg$qrx10std@locale	label	dword
	dd	@@_$TLJQ$@std@locale@$basg$qrx10std@locale
	dd	0
	dd	-44
	dw	0
	dw	5
	dd	0
	dd	0
	dw	12
	dw	5
	dd	0
	dd	@@_$DCKQ$@std@locale@$basg$qrx10std@locale
@_$ECTLQ$@std@locale@$basg$qrx10std@locale	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@locale@$basg$qrx10std@locale	segment virtual
@@std@locale@$basg$qrx10std@locale	proc	near
?live16398@0:
	push      ebp
	mov       ebp,esp
	add       esp,-44
	push      ebx
	push      esi
	mov       esi,dword ptr [ebp+12]
	mov       ebx,dword ptr [ebp+8]
@203:
	mov       eax,offset @@_$ECTLQ$@std@locale@$basg$qrx10std@locale
	call      @__InitExceptBlockLDTC
?live16398@16: ; EBX = this, ESI = _Right
	mov       edx,dword ptr [ebx+8]
	cmp       edx,dword ptr [esi+8]
	je        short @204
@205:
	push      dword ptr [ebx+8]
	call      @@std@locale@facet@_Decref$qv
	pop       ecx
	mov       dword ptr [ebp-8],eax
	cmp       dword ptr [ebp-8],0
	je        short @206
	mov       ecx,dword ptr [ebp-8]
	mov       eax,dword ptr [ecx]
	mov       dword ptr [ebp-4],eax
	mov       word ptr [ebp-28],24
	push      3
	mov       edx,dword ptr [ebp-8]
	push      edx
	mov       ecx,dword ptr [edx]
	call      dword ptr [ecx]
	add       esp,8
	mov       word ptr [ebp-28],12
@206:
@207:
	mov       eax,dword ptr [esi+8]
	mov       dword ptr [ebx+8],eax
?live16398@64: ; EBX = this
	push      dword ptr [ebx+8]
	call      @@std@locale@facet@_Incref$qv
	pop       ecx
@208:
@204:
	mov       eax,ebx
	mov       edx,dword ptr [ebp-44]
	mov       dword ptr fs:[0],edx
?live16398@96: ; 
@210:
@209:
	pop       esi
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@locale@$basg$qrx10std@locale	endp
@std@locale@$basg$qrx10std@locale	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$TLMQ$@std@locale@$bctr$qrx10std@locale	segment virtual
	align	2
@@_$TLMQ$@std@locale@$bctr$qrx10std@locale	label	dword
	dd	0
@_$TLMQ$@std@locale@$bctr$qrx10std@locale	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$DCNQ$@std@locale@$bctr$qrx10std@locale	segment virtual
	align	2
@@_$DCNQ$@std@locale@$bctr$qrx10std@locale	label	dword
	dd	@@$xt$p10std@locale
	dd	5
	dd	8
	dd	0
@_$DCNQ$@std@locale@$bctr$qrx10std@locale	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTOQ$@std@locale@$bctr$qrx10std@locale	segment virtual
	align	2
@@_$ECTOQ$@std@locale@$bctr$qrx10std@locale	label	dword
	dd	@@_$TLMQ$@std@locale@$bctr$qrx10std@locale
	dd	0
	dd	-36
	dw	0
	dw	5
	dd	0
	dd	@@_$DCNQ$@std@locale@$bctr$qrx10std@locale
@_$ECTOQ$@std@locale@$bctr$qrx10std@locale	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@locale@$bctr$qrx10std@locale	segment virtual
@@std@locale@$bctr$qrx10std@locale	proc	near
?live16400@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
@211:
	mov       eax,offset @@_$ECTOQ$@std@locale@$bctr$qrx10std@locale
	call      @__InitExceptBlockLDTC
	mov       word ptr [ebp-20],12
	mov       edx,dword ptr [ebp+8]
	mov       ecx,dword ptr [ebp+12]
	mov       eax,dword ptr [ecx+8]
	mov       dword ptr [edx+8],eax
	mov       edx,dword ptr [ebp+8]
	push      dword ptr [edx+8]
	call      @@std@locale@facet@_Incref$qv
	pop       ecx
	mov       ecx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],ecx
	mov       eax,dword ptr [ebp+8]
@213:
@212:
	mov       esp,ebp
	pop       ebp
	ret 
@@std@locale@$bctr$qrx10std@locale	endp
@std@locale@$bctr$qrx10std@locale	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$TLPQ$@std@locale@$bdtr$qv	segment virtual
	align	2
@@_$TLPQ$@std@locale@$bdtr$qv	label	dword
	dd	0
@_$TLPQ$@std@locale@$bdtr$qv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$DCQQ$@std@locale@$bdtr$qv	segment virtual
	align	2
@@_$DCQQ$@std@locale@$bdtr$qv	label	dword
	dd	@@$xt$a2$p16std@locale@facet
	dd	20495
	dd	-8
	dd	0
@_$DCQQ$@std@locale@$bdtr$qv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTRQ$@std@locale@$bdtr$qv	segment virtual
	align	2
@@_$ECTRQ$@std@locale@$bdtr$qv	label	dword
	dd	@@_$TLPQ$@std@locale@$bdtr$qv
	dd	0
	dd	-44
	dw	0
	dw	5
	dd	0
	dd	0
	dw	12
	dw	5
	dd	0
	dd	@@_$DCQQ$@std@locale@$bdtr$qv
@_$ECTRQ$@std@locale@$bdtr$qv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@locale@$bdtr$qv	segment virtual
@@std@locale@$bdtr$qv	proc	near
?live16401@0:
	push      ebp
	mov       ebp,esp
	add       esp,-44
	push      ebx
	mov       ebx,dword ptr [ebp+8]
@214:
	mov       eax,offset @@_$ECTRQ$@std@locale@$bdtr$qv
	call      @__InitExceptBlockLDTC
?live16401@16: ; EBX = this
	dec       dword ptr [ebp-16]
	test      ebx,ebx
	je        short @215
	cmp       dword ptr [ebx+8],0
	je        short @216
	push      dword ptr [ebx+8]
	call      @@std@locale@facet@_Decref$qv
	pop       ecx
	mov       dword ptr [ebp-8],eax
	cmp       dword ptr [ebp-8],0
	je        short @217
	mov       edx,dword ptr [ebp-8]
	mov       ecx,dword ptr [edx]
	mov       dword ptr [ebp-4],ecx
	mov       word ptr [ebp-28],24
	push      3
	mov       eax,dword ptr [ebp-8]
	push      eax
	mov       edx,dword ptr [eax]
	call      dword ptr [edx]
	add       esp,8
	mov       word ptr [ebp-28],12
@217:
@218:
@216:
	test      byte ptr [ebp+12],1
	je        short @219
	push      ebx
	call      @$bdele$qpv
	pop       ecx
?live16401@64: ; 
@219:
@215:
	mov       ecx,dword ptr [ebp-44]
	mov       dword ptr fs:[0],ecx
@220:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@locale@$bdtr$qv	endp
@std@locale@$bdtr$qv	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$ECTSQ$@std@ios_base@_Fnarray@$bctr$qipq18std@ios_base@eventr12std@ios_basei$vp21std@ios_base@_Fnarray	segment virtual
	align	2
@@_$ECTSQ$@std@ios_base@_Fnarray@$bctr$qipq18std@ios_base@eventr12std@ios_basei$vp21std@ios_base@_Fnarray	label	dword
	dd	0
	dd	0
	dd	-36
@_$ECTSQ$@std@ios_base@_Fnarray@$bctr$qipq18std@ios_base@eventr12std@ios_basei$vp21std@ios_base@_Fnarray	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@_Fnarray@$bctr$qipq18std@ios_base@eventr12std@ios_basei$vp21std@ios_base@_Fnarray	segment virtual
@@std@ios_base@_Fnarray@$bctr$qipq18std@ios_base@eventr12std@ios_basei$vp21std@ios_base@_Fnarray	proc	near
?live16407@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
	push      ebx
	mov       ebx,dword ptr [ebp+8]
@221:
	mov       eax,offset @@_$ECTSQ$@std@ios_base@_Fnarray@$bctr$qipq18std@ios_base@eventr12std@ios_basei$vp21std@ios_base@_Fnarray
	call      @__InitExceptBlockLDTC
?live16407@16: ; EBX = this
	mov       edx,dword ptr [ebp+20]
	mov       dword ptr [ebx],edx
	mov       ecx,dword ptr [ebp+12]
	mov       dword ptr [ebx+4],ecx
	mov       eax,dword ptr [ebp+16]
	mov       dword ptr [ebx+8],eax
	mov       edx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],edx
	mov       eax,ebx
?live16407@48: ; 
@223:
@222:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@ios_base@_Fnarray@$bctr$qipq18std@ios_base@eventr12std@ios_basei$vp21std@ios_base@_Fnarray	endp
@std@ios_base@_Fnarray@$bctr$qipq18std@ios_base@eventr12std@ios_basei$vp21std@ios_base@_Fnarray	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$ECTTQ$@std@ios_base@_Iosarray@$bctr$qip22std@ios_base@_Iosarray	segment virtual
	align	2
@@_$ECTTQ$@std@ios_base@_Iosarray@$bctr$qip22std@ios_base@_Iosarray	label	dword
	dd	0
	dd	0
	dd	-36
@_$ECTTQ$@std@ios_base@_Iosarray@$bctr$qip22std@ios_base@_Iosarray	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@ios_base@_Iosarray@$bctr$qip22std@ios_base@_Iosarray	segment virtual
@@std@ios_base@_Iosarray@$bctr$qip22std@ios_base@_Iosarray	proc	near
?live16415@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
	push      ebx
	mov       ebx,dword ptr [ebp+8]
@224:
	mov       eax,offset @@_$ECTTQ$@std@ios_base@_Iosarray@$bctr$qip22std@ios_base@_Iosarray
	call      @__InitExceptBlockLDTC
?live16415@16: ; EBX = this
	mov       edx,dword ptr [ebp+16]
	mov       dword ptr [ebx],edx
	mov       ecx,dword ptr [ebp+12]
	mov       dword ptr [ebx+4],ecx
	xor       eax,eax
	mov       dword ptr [ebx+8],eax
	xor       edx,edx
	mov       dword ptr [ebx+12],edx
	mov       ecx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],ecx
	mov       eax,ebx
?live16415@48: ; 
@226:
@225:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@ios_base@_Iosarray@$bctr$qip22std@ios_base@_Iosarray	endp
@std@ios_base@_Iosarray@$bctr$qip22std@ios_base@_Iosarray	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$DCUQ$@std@_Lockit@$bctr$qi	segment virtual
	align	2
@@_$DCUQ$@std@_Lockit@$bctr$qi	label	dword
	dd	@@$xt$p11std@_Lockit
	dd	5
	dd	8
	dd	0
@_$DCUQ$@std@_Lockit@$bctr$qi	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTVQ$@std@_Lockit@$bctr$qi	segment virtual
	align	2
@@_$ECTVQ$@std@_Lockit@$bctr$qi	label	dword
	dd	0
	dd	0
	dd	-36
	dw	0
	dw	5
	dd	0
	dd	@@_$DCUQ$@std@_Lockit@$bctr$qi
@_$ECTVQ$@std@_Lockit@$bctr$qi	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@_Lockit@$bctr$qi	segment virtual
@@std@_Lockit@$bctr$qi	proc	near
?live16420@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
@227:
	mov       eax,offset @@_$ECTVQ$@std@_Lockit@$bctr$qi
	call      @__InitExceptBlockLDTC
	mov       word ptr [ebp-20],12
	mov       edx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],edx
	mov       eax,dword ptr [ebp+8]
@229:
@228:
	mov       esp,ebp
	pop       ebp
	ret 
@@std@_Lockit@$bctr$qi	endp
@std@_Lockit@$bctr$qi	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@std@_Lockit@$bdtr$qv	segment virtual
@@std@_Lockit@$bdtr$qv	proc	near
?live16421@0:
	push      ebp
	mov       ebp,esp
	mov       eax,dword ptr [ebp+8]
@230:
	test      eax,eax
	je        short @231
	test      byte ptr [ebp+12],1
	je        short @232
	push      eax
	call      @$bdele$qpv
	pop       ecx
@232:
@231:
@233:
	pop       ebp
	ret 
@@std@_Lockit@$bdtr$qv	endp
@std@_Lockit@$bdtr$qv	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$DCWQ$@std@runtime_error@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	segment virtual
	align	2
@@_$DCWQ$@std@runtime_error@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	label	dword
	dd	@@$xt$p17std@runtime_error
	dd	5
	dd	8
	dd	0
@_$DCWQ$@std@runtime_error@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTXQ$@std@runtime_error@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	segment virtual
	align	2
@@_$ECTXQ$@std@runtime_error@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	label	dword
	dd	0
	dd	0
	dd	-36
	dw	0
	dw	5
	dd	0
	dd	@@_$DCWQ$@std@runtime_error@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	dw	12
	dw	5
	dd	0
	dd	0
@_$ECTXQ$@std@runtime_error@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@runtime_error@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	segment virtual
@@std@runtime_error@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	proc	near
?live16429@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
@234:
	mov       eax,offset @@_$ECTXQ$@std@runtime_error@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	call      @__InitExceptBlockLDTC
	mov       word ptr [ebp-20],12
	push      dword ptr [ebp+8]
	call      @@std@exception@$bctr$qv
	pop       ecx
	inc       dword ptr [ebp-8]
	mov       edx,offset @@std@runtime_error@3+12
	mov       ecx,dword ptr [ebp+8]
	mov       dword ptr [ecx],edx
	push      dword ptr [ebp+12]
	mov       eax,dword ptr [ebp+8]
	add       eax,8
	push      eax
	call      @@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	add       esp,8
	inc       dword ptr [ebp-8]
	mov       edx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],edx
	mov       eax,dword ptr [ebp+8]
@236:
@235:
	mov       esp,ebp
	pop       ebp
	ret 
@@std@runtime_error@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	endp
@std@runtime_error@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$DCYQ$@std@runtime_error@$bdtr$qv	segment virtual
	align	2
@@_$DCYQ$@std@runtime_error@$bdtr$qv	label	dword
	dd	@@$xt$p17std@runtime_error
	dd	5
	dd	8
	dd	0
@_$DCYQ$@std@runtime_error@$bdtr$qv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTZQ$@std@runtime_error@$bdtr$qv	segment virtual
	align	2
@@_$ECTZQ$@std@runtime_error@$bdtr$qv	label	dword
	dd	0
	dd	0
	dd	-36
	dw	0
	dw	5
	dd	0
	dd	@@_$DCYQ$@std@runtime_error@$bdtr$qv
@_$ECTZQ$@std@runtime_error@$bdtr$qv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@runtime_error@$bdtr$qv	segment virtual
@@std@runtime_error@$bdtr$qv	proc	near
?live16433@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
@237:
	mov       eax,offset @@_$ECTZQ$@std@runtime_error@$bdtr$qv
	call      @__InitExceptBlockLDTC
	mov       dword ptr [ebp-8],2
	cmp       dword ptr [ebp+8],0
	je        short @238
	mov       word ptr [ebp-20],12
	mov       edx,offset @@std@runtime_error@3+12
	mov       ecx,dword ptr [ebp+8]
	mov       dword ptr [ecx],edx
	dec       dword ptr [ebp-8]
	push      2
	mov       eax,dword ptr [ebp+8]
	add       eax,8
	push      eax
	call      @@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bdtr$qv
	add       esp,8
	dec       dword ptr [ebp-8]
	push      0
	push      dword ptr [ebp+8]
	call      @@std@exception@$bdtr$qv
	add       esp,8
	test      byte ptr [ebp+12],1
	je        short @239
	push      dword ptr [ebp+8]
	call      @$bdele$qpv
	pop       ecx
@239:
@238:
	mov       edx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],edx
@240:
	mov       esp,ebp
	pop       ebp
	ret 
@@std@runtime_error@$bdtr$qv	endp
@std@runtime_error@$bdtr$qv	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$DCAR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	segment virtual
	align	2
@@_$DCAR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	label	dword
	dd	@@$xt$p60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	dd	5
	dd	8
	dd	0
@_$DCAR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTBR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	segment virtual
	align	2
@@_$ECTBR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	label	dword
	dd	0
	dd	0
	dd	-36
	dw	0
	dw	5
	dd	0
	dd	@@_$DCAR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
@_$ECTBR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	segment virtual
@@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	proc	near
?live16437@0:
	push      ebp
	mov       ebp,esp
	add       esp,-164
	push      ebx
	push      esi
	push      edi
	mov       esi,dword ptr [ebp+12]
	lea       ebx,dword ptr [ebp+8]
@241:
	mov       eax,offset @@_$ECTBR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	call      @__InitExceptBlockLDTC
?live16437@16: ; EBX = &this, ESI = _Right
	mov       word ptr [ebp-20],12
	add       esp,-8
	lea       edx,dword ptr [esi+8]
	push      edx
	lea       ecx,dword ptr [esp+4]
	push      ecx
	call      @@std@%allocator$c%@$bctr$qrx17std@%allocator$c%
	add       esp,8
	push      dword ptr [ebx]
	call      @@std@%_String_val$c17std@%allocator$c%%@$bctr$q17std@%allocator$c%
	add       esp,12
	mov       eax,dword ptr [ebx]
	mov       dword ptr [eax+36],15
	xor       eax,eax
	mov       edx,dword ptr [ebx]
	xor       ecx,ecx
	mov       dword ptr [edx+32],ecx
	mov       edx,ecx
	mov       ecx,dword ptr [ebx]
	cmp       dword ptr [ecx+36],16
	jb        short @242
	mov       ecx,dword ptr [ebx]
	mov       ecx,dword ptr [ecx+16]
	jmp short @243
@242:
	mov       ecx,dword ptr [ebx]
	add       ecx,16
@243:
	add       edx,ecx
	mov       byte ptr [edx],al
	cmp       dword ptr [esi+32],0
	jae       short @244
	push      dword ptr [ebx]
	call      @@std@_String_base@_Xran$xqv
	pop       ecx
@244:
@245:
	mov       eax,dword ptr [esi+32]
	mov       dword ptr [ebp-40],eax
	cmp       dword ptr [ebp-40],-1
	jbe       short @246
	mov       dword ptr [ebp-40],-1
@246:
@247:
	cmp       esi,dword ptr [ebx]
	jne       @248
	mov       esi,-1
	mov       edi,dword ptr [ebp-40]
	mov       edx,dword ptr [ebx]
	cmp       edi,dword ptr [edx+32]
	jbe       short @250
	push      dword ptr [ebx]
	call      @@std@_String_base@_Xran$xqv
	pop       ecx
@250:
@251:
	mov       eax,dword ptr [ebx]
	mov       edx,dword ptr [eax+32]
	sub       edx,edi
	cmp       esi,edx
	jbe       short @252
	mov       ecx,dword ptr [ebx]
	mov       esi,dword ptr [ecx+32]
	sub       esi,edi
@252:
@253:
	test      esi,esi
	jbe       @254
	mov       eax,dword ptr [ebx]
	mov       edx,dword ptr [eax+32]
	sub       edx,edi
	sub       edx,esi
	mov       dword ptr [ebp-44],edx
	mov       ecx,dword ptr [ebx]
	cmp       dword ptr [ecx+36],16
	jb        short @256
	mov       eax,dword ptr [ebx]
	mov       edx,dword ptr [eax+16]
	jmp short @257
@256:
	mov       edx,dword ptr [ebx]
	add       edx,16
@257:
	add       edx,edi
	add       edx,esi
	mov       dword ptr [ebp-48],edx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @258
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+16]
	jmp short @259
@258:
	mov       eax,dword ptr [ebx]
	add       eax,16
@259:
	add       eax,edi
	mov       dword ptr [ebp-52],eax
	push      dword ptr [ebp-44]
	push      dword ptr [ebp-48]
	push      dword ptr [ebp-52]
	call      @_memmove
	add       esp,12
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [edx+32]
	sub       ecx,esi
	mov       dword ptr [ebp-56],ecx
	mov       eax,dword ptr [ebp-56]
	mov       dword ptr [ebp-60],eax
	mov       byte ptr [ebp-61],0
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [ebp-60]
	mov       dword ptr [edx+32],ecx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @260
	mov       edx,dword ptr [ebx]
	mov       eax,dword ptr [edx+16]
	jmp short @261
@260:
	mov       eax,dword ptr [ebx]
	add       eax,16
@261:
	add       ecx,eax
	mov       dword ptr [ebp-68],ecx
	mov       edx,dword ptr [ebp-68]
	mov       cl,byte ptr [ebp-61]
	mov       byte ptr [edx],cl
@254:
@255:
	xor       eax,eax
	mov       dword ptr [ebp-72],eax
	mov       edx,dword ptr [ebx]
	cmp       dword ptr [edx+32],0
	jae       short @262
	push      dword ptr [ebx]
	call      @@std@_String_base@_Xran$xqv
	pop       ecx
@262:
@263:
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+32]
	cmp       eax,dword ptr [ebp-72]
	jae       short @264
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [edx+32]
	mov       dword ptr [ebp-72],ecx
@264:
@265:
	cmp       dword ptr [ebp-72],0
	jbe       @249
	mov       eax,dword ptr [ebx]
	mov       edx,dword ptr [eax+32]
	sub       edx,dword ptr [ebp-72]
	mov       dword ptr [ebp-76],edx
	mov       ecx,dword ptr [ebx]
	cmp       dword ptr [ecx+36],16
	jb        short @268
	mov       eax,dword ptr [ebx]
	mov       edx,dword ptr [eax+16]
	jmp short @269
@268:
	mov       edx,dword ptr [ebx]
	add       edx,16
@269:
	add       edx,dword ptr [ebp-72]
	mov       dword ptr [ebp-80],edx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @270
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+16]
	jmp short @271
@270:
	mov       eax,dword ptr [ebx]
	add       eax,16
@271:
	mov       dword ptr [ebp-84],eax
	push      dword ptr [ebp-76]
	push      dword ptr [ebp-80]
	push      dword ptr [ebp-84]
	call      @_memmove
	add       esp,12
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [edx+32]
	sub       ecx,dword ptr [ebp-72]
	mov       dword ptr [ebp-88],ecx
	mov       eax,dword ptr [ebp-88]
	mov       dword ptr [ebp-92],eax
	mov       byte ptr [ebp-93],0
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [ebp-92]
	mov       dword ptr [edx+32],ecx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @272
	mov       edx,dword ptr [ebx]
	mov       eax,dword ptr [edx+16]
	jmp short @273
@272:
	mov       eax,dword ptr [ebx]
	add       eax,16
@273:
	add       ecx,eax
	mov       dword ptr [ebp-100],ecx
	mov       edx,dword ptr [ebp-100]
	mov       cl,byte ptr [ebp-93]
	mov       byte ptr [edx],cl
	jmp @249
@248:
	mov       edi,dword ptr [ebp-40]
	mov       eax,dword ptr [ebx]
	add       eax,8
	push      eax
	call      @@std@%allocator$c%@max_size$xqv
	pop       ecx
	mov       dword ptr [ebp-104],eax
	cmp       dword ptr [ebp-104],1
	ja        short @278
	mov       edx,1
	jmp short @279
@278:
	mov       edx,dword ptr [ebp-104]
	dec       edx
@279:
	cmp       edi,edx
	jbe       short @276
	push      dword ptr [ebx]
	call      @@std@_String_base@_Xlen$xqv
	pop       ecx
@276:
@277:
	mov       eax,dword ptr [ebx]
	cmp       edi,dword ptr [eax+36]
	jbe       @282
	mov       ecx,dword ptr [ebx]
	push      dword ptr [ecx+32]
	push      edi
	push      dword ptr [ebx]
	call      @@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui
	add       esp,12
	jmp @281
	jmp @282
	cmp       edi,16
	jae       @282
	mov       eax,dword ptr [ebx]
	cmp       edi,dword ptr [eax+32]
	jae       short @284
	mov       edx,edi
@284:
	mov       ecx,dword ptr [ebx]
	mov       edx,dword ptr [ecx+32]
	mov       dword ptr [ebp-108],edx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @286
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+16]
	mov       dword ptr [ebp-112],eax
	cmp       dword ptr [ebp-108],0
	jbe       short @288
	mov       edx,dword ptr [ebp-112]
	mov       dword ptr [ebp-116],edx
	mov       ecx,dword ptr [ebx]
	add       ecx,16
	mov       dword ptr [ebp-120],ecx
	push      dword ptr [ebp-108]
	push      dword ptr [ebp-116]
	push      dword ptr [ebp-120]
	call      @_memcpy
	add       esp,12
@288:
@289:
	mov       eax,dword ptr [ebp-112]
	mov       dword ptr [ebp-124],eax
	push      dword ptr [ebp-124]
	call      @$bdele$qpv
	pop       ecx
@286:
@287:
	mov       edx,dword ptr [ebx]
	mov       dword ptr [edx+36],15
	mov       byte ptr [ebp-125],0
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ebp-108]
	mov       dword ptr [ecx+32],eax
	mov       edx,dword ptr [ebx]
	cmp       dword ptr [edx+36],16
	jb        short @290
	mov       ecx,dword ptr [ebx]
	mov       edx,dword ptr [ecx+16]
	jmp short @291
@290:
	mov       edx,dword ptr [ebx]
	add       edx,16
@291:
	add       eax,edx
	mov       dword ptr [ebp-132],eax
	mov       eax,dword ptr [ebp-132]
	mov       cl,byte ptr [ebp-125]
	mov       byte ptr [eax],cl
	jmp short @283
@282:
	test      edi,edi
	jne       short @292
	mov       byte ptr [ebp-133],0
	mov       eax,dword ptr [ebx]
	xor       edx,edx
	mov       dword ptr [eax+32],edx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @294
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ecx+16]
	jmp short @295
@294:
	mov       eax,dword ptr [ebx]
	add       eax,16
@295:
	add       edx,eax
	mov       dword ptr [ebp-140],edx
	mov       edx,dword ptr [ebp-140]
	mov       cl,byte ptr [ebp-133]
	mov       byte ptr [edx],cl
@292:
@293:
@283:
@281:
	test      edi,edi
	seta      al
	and       eax,1
	test      al,al
	je        @274
	mov       edx,dword ptr [ebp-40]
	mov       dword ptr [ebp-144],edx
	cmp       dword ptr [esi+36],16
	jb        short @296
	mov       ecx,dword ptr [esi+16]
	jmp short @297
@296:
	lea       ecx,dword ptr [esi+16]
@297:
	mov       dword ptr [ebp-148],ecx
	mov       eax,dword ptr [ebx]
	cmp       dword ptr [eax+36],16
	jb        short @298
	mov       edx,dword ptr [ebx]
	mov       eax,dword ptr [edx+16]
	jmp short @299
@298:
	mov       eax,dword ptr [ebx]
	add       eax,16
@299:
	mov       dword ptr [ebp-152],eax
	push      dword ptr [ebp-144]
	push      dword ptr [ebp-148]
	push      dword ptr [ebp-152]
	call      @_memcpy
	add       esp,12
	mov       edx,dword ptr [ebp-40]
	mov       dword ptr [ebp-156],edx
	mov       byte ptr [ebp-157],0
	mov       ecx,dword ptr [ebx]
	mov       eax,dword ptr [ebp-156]
	mov       dword ptr [ecx+32],eax
	mov       edx,dword ptr [ebx]
	cmp       dword ptr [edx+36],16
	jb        short @300
	mov       ecx,dword ptr [ebx]
	mov       edx,dword ptr [ecx+16]
	jmp short @301
@300:
	mov       edx,dword ptr [ebx]
	add       edx,16
@301:
	add       eax,edx
	mov       dword ptr [ebp-164],eax
	mov       eax,dword ptr [ebp-164]
	mov       cl,byte ptr [ebp-157]
	mov       byte ptr [eax],cl
?live16437@64: ; EBX = &this
@274:
@275:
@249:
	mov       eax,dword ptr [ebp-36]
	mov       dword ptr fs:[0],eax
	mov       eax,dword ptr [ebx]
?live16437@80: ; 
@303:
@302:
	pop       edi
	pop       esi
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
?t2 = -184
@@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	endp
@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bctr$qrx60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$TLCR$@std@%allocator$c%@$bctr$qv	segment virtual
	align	2
@@_$TLCR$@std@%allocator$c%@$bctr$qv	label	dword
	dd	0
@_$TLCR$@std@%allocator$c%@$bctr$qv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTDR$@std@%allocator$c%@$bctr$qv	segment virtual
	align	2
@@_$ECTDR$@std@%allocator$c%@$bctr$qv	label	dword
	dd	@@_$TLCR$@std@%allocator$c%@$bctr$qv
	dd	0
	dd	-36
@_$ECTDR$@std@%allocator$c%@$bctr$qv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@%allocator$c%@$bctr$qv	segment virtual
@@std@%allocator$c%@$bctr$qv	proc	near
?live16439@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
	push      ebx
	mov       ebx,dword ptr [ebp+8]
@304:
	mov       eax,offset @@_$ECTDR$@std@%allocator$c%@$bctr$qv
	call      @__InitExceptBlockLDTC
?live16439@16: ; EBX = this
	mov       edx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],edx
	mov       eax,ebx
?live16439@32: ; 
@306:
@305:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@%allocator$c%@$bctr$qv	endp
@std@%allocator$c%@$bctr$qv	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$ECTER$@std@%_String_val$c17std@%allocator$c%%@$bctr$q17std@%allocator$c%	segment virtual
	align	2
@@_$ECTER$@std@%_String_val$c17std@%allocator$c%%@$bctr$q17std@%allocator$c%	label	dword
	dd	0
	dd	0
	dd	-36
@_$ECTER$@std@%_String_val$c17std@%allocator$c%%@$bctr$q17std@%allocator$c%	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@%_String_val$c17std@%allocator$c%%@$bctr$q17std@%allocator$c%	segment virtual
@@std@%_String_val$c17std@%allocator$c%%@$bctr$q17std@%allocator$c%	proc	near
?live16440@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
	push      ebx
	mov       ebx,dword ptr [ebp+8]
@307:
	mov       eax,offset @@_$ECTER$@std@%_String_val$c17std@%allocator$c%%@$bctr$q17std@%allocator$c%
	call      @__InitExceptBlockLDTC
?live16440@16: ; EBX = this
	lea       edx,dword ptr [ebp+12]
	push      edx
	lea       ecx,dword ptr [ebx+8]
	push      ecx
	call      @@std@%allocator$c%@$bctr$qrx17std@%allocator$c%
	add       esp,8
	mov       eax,dword ptr [ebp-36]
	mov       dword ptr fs:[0],eax
	mov       eax,ebx
?live16440@48: ; 
@309:
@308:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@%_String_val$c17std@%allocator$c%%@$bctr$q17std@%allocator$c%	endp
@std@%_String_val$c17std@%allocator$c%%@$bctr$q17std@%allocator$c%	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$CHGR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui	segment virtual
	align	2
@@_$CHGR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui	label	dword
	dd	0
	dd	0
	dd	@310
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
@_$CHGR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$CHFR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui	segment virtual
	align	2
@@_$CHFR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui	label	dword
	dd	0
	dd	0
	dd	@311
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
@_$CHFR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTHR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui	segment virtual
	align	2
@@_$ECTHR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui	label	dword
	dd	0
	dd	0
	dd	-36
	dw	0
	dw	3
	dd	@@_$CHFR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui
	dw	0
	dw	4
	dw	20
	dw	3
	dd	@@_$CHGR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui
	dw	20
	dw	4
@_$ECTHR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui	segment virtual
@@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui	proc	near
?live16441@0:
	push      ebp
	mov       ebp,esp
	add       esp,-44
	push      ebx
	push      esi
	push      edi
@312:
	mov       eax,offset @@_$ECTHR$@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui
	call      @__InitExceptBlockLDTC
	mov       edx,dword ptr [ebp+12]
	or        edx,15
	mov       dword ptr [ebp-40],edx
	mov       ecx,dword ptr [ebp+8]
	add       ecx,8
	push      ecx
	call      @@std@%allocator$c%@max_size$xqv
	pop       ecx
	mov       ebx,eax
	cmp       ebx,1
	ja        short @314
	mov       eax,1
	jmp short @315
@314:
	mov       eax,ebx
	dec       eax
@315:
	cmp       eax,dword ptr [ebp-40]
	jae       short @313
	mov       edx,dword ptr [ebp+12]
	mov       dword ptr [ebp-40],edx
	jmp short @316
@313:
	mov       eax,dword ptr [ebp-40]
	mov       ecx,3
	xor       edx,edx
	div       ecx
	mov       edx,dword ptr [ebp+8]
	mov       ecx,dword ptr [edx+36]
	shr       ecx,1
	cmp       eax,ecx
	jae       short @317
	mov       eax,dword ptr [ebp+8]
	add       eax,8
	push      eax
	call      @@std@%allocator$c%@max_size$xqv
	pop       ecx
	mov       ebx,eax
	cmp       ebx,1
	ja        short @318
	mov       eax,1
	jmp short @319
@318:
	mov       eax,ebx
	dec       eax
@319:
	mov       edx,dword ptr [ebp+8]
	mov       ecx,dword ptr [edx+36]
	shr       ecx,1
	sub       eax,ecx
	mov       edx,dword ptr [ebp+8]
	cmp       eax,dword ptr [edx+36]
	jb        short @317
	mov       eax,dword ptr [ebp+8]
	mov       ecx,dword ptr [eax+36]
	mov       eax,dword ptr [ebp+8]
	mov       edx,dword ptr [eax+36]
	shr       edx,1
	add       ecx,edx
	mov       dword ptr [ebp-40],ecx
@317:
@316:
	mov       word ptr [ebp-20],12
	mov       ebx,dword ptr [ebp-40]
	inc       ebx
	push      ebx
	call      @$bnew$qui
	pop       ecx
	mov       dword ptr [ebp-44],eax
	mov       word ptr [ebp-20],0
	jmp @320
@321:
@311:
	mov       eax,dword ptr [ebp+12]
	mov       dword ptr [ebp-40],eax
	mov       word ptr [ebp-20],24
	mov       ebx,dword ptr [ebp-40]
	inc       ebx
	push      ebx
	call      @$bnew$qui
	pop       ecx
	mov       dword ptr [ebp-44],eax
	mov       word ptr [ebp-20],20
	jmp short @322
@323:
@310:
	mov       eax,dword ptr [ebp+8]
	cmp       dword ptr [eax+36],16
	jb        short @324
	mov       edx,dword ptr [ebp+8]
	mov       ebx,dword ptr [edx+16]
	mov       esi,ebx
	push      esi
	call      @$bdele$qpv
	pop       ecx
@324:
@325:
	mov       ecx,dword ptr [ebp+8]
	mov       dword ptr [ecx+36],15
	xor       eax,eax
	mov       edx,dword ptr [ebp+8]
	xor       ecx,ecx
	mov       dword ptr [edx+32],ecx
	mov       edx,ecx
	mov       ecx,dword ptr [ebp+8]
	cmp       dword ptr [ecx+36],16
	jb        short @326
	mov       ecx,dword ptr [ebp+8]
	mov       ecx,dword ptr [ecx+16]
	jmp short @327
@326:
	mov       ecx,dword ptr [ebp+8]
	add       ecx,16
@327:
	add       edx,ecx
	mov       byte ptr [edx],al
	push      0
	push      0
	call      @_ReThrowException$quipuc
	add       esp,8
@328:
	mov       word ptr [ebp-20],32
	call      @@_CatchCleanup$qv
@322:
@329:
	mov       word ptr [ebp-20],20
	call      @@_CatchCleanup$qv
@320:
	cmp       dword ptr [ebp+16],0
	jbe       short @330
	mov       eax,dword ptr [ebp+16]
	mov       edx,dword ptr [ebp+8]
	cmp       dword ptr [edx+36],16
	jb        short @331
	mov       edx,dword ptr [ebp+8]
	mov       edx,dword ptr [edx+16]
	jmp short @332
@331:
	mov       edx,dword ptr [ebp+8]
	add       edx,16
@332:
	mov       ecx,dword ptr [ebp-44]
	push      eax
	push      edx
	push      ecx
	call      @_memcpy
	add       esp,12
@330:
	mov       eax,dword ptr [ebp+8]
	cmp       dword ptr [eax+36],16
	jb        short @333
	mov       eax,dword ptr [ebp+8]
	mov       ebx,dword ptr [eax+16]
	mov       esi,ebx
	push      esi
	call      @$bdele$qpv
	pop       ecx
@333:
@334:
	mov       edx,dword ptr [ebp+8]
	mov       dword ptr [edx+36],15
	xor       eax,eax
	mov       edx,dword ptr [ebp+8]
	xor       ecx,ecx
	mov       dword ptr [edx+32],ecx
	mov       edx,ecx
	mov       ecx,dword ptr [ebp+8]
	cmp       dword ptr [ecx+36],16
	jb        short @335
	mov       ecx,dword ptr [ebp+8]
	mov       ecx,dword ptr [ecx+16]
	jmp short @336
@335:
	mov       ecx,dword ptr [ebp+8]
	add       ecx,16
@336:
	add       edx,ecx
	mov       byte ptr [edx],al
	mov       eax,dword ptr [ebp+8]
	mov       edx,dword ptr [ebp-44]
	mov       dword ptr [eax+16],edx
	mov       eax,dword ptr [ebp+8]
	mov       edx,dword ptr [ebp-40]
	mov       dword ptr [eax+36],edx
	mov       eax,dword ptr [ebp+16]
	xor       edx,edx
	mov       ecx,dword ptr [ebp+8]
	mov       dword ptr [ecx+32],eax
	mov       ecx,dword ptr [ebp+8]
	cmp       dword ptr [ecx+36],16
	jb        short @337
	mov       ecx,dword ptr [ebp+8]
	mov       ecx,dword ptr [ecx+16]
	jmp short @338
@337:
	mov       ecx,dword ptr [ebp+8]
	add       ecx,16
@338:
	add       eax,ecx
	mov       byte ptr [eax],dl
	mov       eax,dword ptr [ebp-36]
	mov       dword ptr fs:[0],eax
@339:
	pop       edi
	pop       esi
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui	endp
@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@_Copy$quiui	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$TLIR$@std@%allocator$c%@max_size$xqv	segment virtual
	align	2
@@_$TLIR$@std@%allocator$c%@max_size$xqv	label	dword
	dd	0
@_$TLIR$@std@%allocator$c%@max_size$xqv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTJR$@std@%allocator$c%@max_size$xqv	segment virtual
	align	2
@@_$ECTJR$@std@%allocator$c%@max_size$xqv	label	dword
	dd	@@_$TLIR$@std@%allocator$c%@max_size$xqv
	dd	0
	dd	-36
@_$ECTJR$@std@%allocator$c%@max_size$xqv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@%allocator$c%@max_size$xqv	segment virtual
@@std@%allocator$c%@max_size$xqv	proc	near
?live16442@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
@340:
	mov       eax,offset @@_$ECTJR$@std@%allocator$c%@max_size$xqv
	call      @__InitExceptBlockLDTC
	or        eax,-1
?live16442@32: ; EAX = _Count
	test      eax,eax
	ja        short @342
	mov       eax,1
@342:
	mov       edx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],edx
?live16442@48: ; 
@344:
@343:
	mov       esp,ebp
	pop       ebp
	ret 
@@std@%allocator$c%@max_size$xqv	endp
@std@%allocator$c%@max_size$xqv	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$DCKR$@std@locale@facet@_Decref$qv	segment virtual
	align	2
@@_$DCKR$@std@locale@facet@_Decref$qv	label	dword
	dd	@@$xt$11std@_Lockit
	dd	4
	dd	-8
	dd	0
	dd	@@$xt$11std@_Lockit
	dd	4
	dd	-8
	dd	0
@_$DCKR$@std@locale@facet@_Decref$qv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTLR$@std@locale@facet@_Decref$qv	segment virtual
	align	2
@@_$ECTLR$@std@locale@facet@_Decref$qv	label	dword
	dd	0
	dd	0
	dd	-44
	dw	0
	dw	5
	dd	0
	dd	@@_$DCKR$@std@locale@facet@_Decref$qv+16
	dw	0
	dw	5
	dd	0
	dd	@@_$DCKR$@std@locale@facet@_Decref$qv
@_$ECTLR$@std@locale@facet@_Decref$qv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@locale@facet@_Decref$qv	segment virtual
@@std@locale@facet@_Decref$qv	proc	near
?live16446@0:
	push      ebp
	mov       ebp,esp
	add       esp,-44
	push      ebx
	mov       ebx,dword ptr [ebp+8]
@345:
	mov       eax,offset @@_$ECTLR$@std@locale@facet@_Decref$qv
	call      @__InitExceptBlockLDTC
?live16446@16: ; EBX = this
	mov       word ptr [ebp-28],12
	push      0
	lea       edx,dword ptr [ebp-8]
	push      edx
	call      @@std@_Lockit@$bctr$qi
	add       esp,8
	inc       dword ptr [ebp-16]
	mov       word ptr [ebp-28],24
	cmp       dword ptr [ebx+4],0
	jbe       short @346
	cmp       dword ptr [ebx+4],-1
	jae       short @346
	dec       dword ptr [ebx+4]
@346:
	cmp       dword ptr [ebx+4],0
	jne       short @347
	mov       eax,ebx
	jmp short @348
@347:
	xor       eax,eax
@348:
	push      eax
	dec       dword ptr [ebp-16]
	push      2
	lea       edx,dword ptr [ebp-8]
	push      edx
	call      @@std@_Lockit@$bdtr$qv
	add       esp,8
	pop       eax
	mov       edx,dword ptr [ebp-44]
	mov       dword ptr fs:[0],edx
?live16446@80: ; 
@350:
@349:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@locale@facet@_Decref$qv	endp
@std@locale@facet@_Decref$qv	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$DCMR$@std@locale@facet@_Incref$qv	segment virtual
	align	2
@@_$DCMR$@std@locale@facet@_Incref$qv	label	dword
	dd	@@$xt$11std@_Lockit
	dd	4
	dd	-8
	dd	0
	dd	@@$xt$11std@_Lockit
	dd	4
	dd	-8
	dd	0
@_$DCMR$@std@locale@facet@_Incref$qv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTNR$@std@locale@facet@_Incref$qv	segment virtual
	align	2
@@_$ECTNR$@std@locale@facet@_Incref$qv	label	dword
	dd	0
	dd	0
	dd	-44
	dw	0
	dw	5
	dd	0
	dd	@@_$DCMR$@std@locale@facet@_Incref$qv+16
	dw	0
	dw	5
	dd	0
	dd	@@_$DCMR$@std@locale@facet@_Incref$qv
@_$ECTNR$@std@locale@facet@_Incref$qv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@locale@facet@_Incref$qv	segment virtual
@@std@locale@facet@_Incref$qv	proc	near
?live16447@0:
	push      ebp
	mov       ebp,esp
	add       esp,-44
	push      ebx
	mov       ebx,dword ptr [ebp+8]
@351:
	mov       eax,offset @@_$ECTNR$@std@locale@facet@_Incref$qv
	call      @__InitExceptBlockLDTC
?live16447@16: ; EBX = this
	mov       word ptr [ebp-28],12
	push      0
	lea       edx,dword ptr [ebp-8]
	push      edx
	call      @@std@_Lockit@$bctr$qi
	add       esp,8
	inc       dword ptr [ebp-16]
	mov       word ptr [ebp-28],24
	cmp       dword ptr [ebx+4],-1
	jae       short @352
	inc       dword ptr [ebx+4]
?live16447@64: ; 
@352:
	dec       dword ptr [ebp-16]
	push      2
	lea       ecx,dword ptr [ebp-8]
	push      ecx
	call      @@std@_Lockit@$bdtr$qv
	add       esp,8
	mov       eax,dword ptr [ebp-44]
	mov       dword ptr fs:[0],eax
@353:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@locale@facet@_Incref$qv	endp
@std@locale@facet@_Incref$qv	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$TLOR$@std@exception@$bctr$qv	segment virtual
	align	2
@@_$TLOR$@std@exception@$bctr$qv	label	dword
	dd	0
@_$TLOR$@std@exception@$bctr$qv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$DCPR$@std@exception@$bctr$qv	segment virtual
	align	2
@@_$DCPR$@std@exception@$bctr$qv	label	dword
	dd	@@$xt$p13std@exception
	dd	5
	dd	8
	dd	0
@_$DCPR$@std@exception@$bctr$qv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTQR$@std@exception@$bctr$qv	segment virtual
	align	2
@@_$ECTQR$@std@exception@$bctr$qv	label	dword
	dd	@@_$TLOR$@std@exception@$bctr$qv
	dd	0
	dd	-36
	dw	0
	dw	5
	dd	0
	dd	@@_$DCPR$@std@exception@$bctr$qv
@_$ECTQR$@std@exception@$bctr$qv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@exception@$bctr$qv	segment virtual
@@std@exception@$bctr$qv	proc	near
?live16463@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
@354:
	mov       eax,offset @@_$ECTQR$@std@exception@$bctr$qv
	call      @__InitExceptBlockLDTC
	mov       word ptr [ebp-20],12
	mov       edx,offset @@std@exception@3+12
	mov       ecx,dword ptr [ebp+8]
	mov       dword ptr [ecx],edx
	mov       eax,dword ptr [ebp-36]
	mov       dword ptr fs:[0],eax
	mov       eax,dword ptr [ebp+8]
@356:
@355:
	mov       esp,ebp
	pop       ebp
	ret 
@@std@exception@$bctr$qv	endp
@std@exception@$bctr$qv	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$TLRR$@std@%allocator$c%@$bctr$qrx17std@%allocator$c%	segment virtual
	align	2
@@_$TLRR$@std@%allocator$c%@$bctr$qrx17std@%allocator$c%	label	dword
	dd	0
@_$TLRR$@std@%allocator$c%@$bctr$qrx17std@%allocator$c%	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTSR$@std@%allocator$c%@$bctr$qrx17std@%allocator$c%	segment virtual
	align	2
@@_$ECTSR$@std@%allocator$c%@$bctr$qrx17std@%allocator$c%	label	dword
	dd	@@_$TLRR$@std@%allocator$c%@$bctr$qrx17std@%allocator$c%
	dd	0
	dd	-36
@_$ECTSR$@std@%allocator$c%@$bctr$qrx17std@%allocator$c%	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@%allocator$c%@$bctr$qrx17std@%allocator$c%	segment virtual
@@std@%allocator$c%@$bctr$qrx17std@%allocator$c%	proc	near
?live16469@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
	push      ebx
	mov       ebx,dword ptr [ebp+8]
@357:
	mov       eax,offset @@_$ECTSR$@std@%allocator$c%@$bctr$qrx17std@%allocator$c%
	call      @__InitExceptBlockLDTC
?live16469@16: ; EBX = this
	mov       edx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],edx
	mov       eax,ebx
?live16469@32: ; 
@359:
@358:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@%allocator$c%@$bctr$qrx17std@%allocator$c%	endp
@std@%allocator$c%@$bctr$qrx17std@%allocator$c%	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$p13std@exception	segment virtual
	align	2
@@$xt$p13std@exception	label	dword
	dd	4
	dw	16
	dw	12
	dd	@@$xt$13std@exception
	db	115
	db	116
	db	100
	db	58
	db	58
	db	101
	db	120
	db	99
	db	101
	db	112
	db	116
	db	105
	db	111
	db	110
	db	32
	db	42
	db	0
@$xt$p13std@exception	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$p17std@runtime_error	segment virtual
	align	2
@@$xt$p17std@runtime_error	label	dword
	dd	4
	dw	144
	dw	12
	dd	@@$xt$17std@runtime_error
	db	115
	db	116
	db	100
	db	58
	db	58
	db	114
	db	117
	db	110
	db	116
	db	105
	db	109
	db	101
	db	95
	db	101
	db	114
	db	114
	db	111
	db	114
	db	32
	db	42
	db	0
@$xt$p17std@runtime_error	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$p11std@_Lockit	segment virtual
	align	2
@@$xt$p11std@_Lockit	label	dword
	dd	4
	dw	16
	dw	12
	dd	@@$xt$11std@_Lockit
	db	115
	db	116
	db	100
	db	58
	db	58
	db	95
	db	76
	db	111
	db	99
	db	107
	db	105
	db	116
	db	32
	db	42
	db	0
@$xt$p11std@_Lockit	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$a2$p16std@locale@facet	segment virtual
	align	2
@@$xt$a2$p16std@locale@facet	label	dword
	dd	8
	dw	1024
	dw	16
	dd	@@$xt$p16std@locale@facet
	dd	2
	db	115
	db	116
	db	100
	db	58
	db	58
	db	108
	db	111
	db	99
	db	97
	db	108
	db	101
	db	58
	db	58
	db	102
	db	97
	db	99
	db	101
	db	116
	db	32
	db	42
	db	91
	db	50
	db	93
	db	0
@$xt$a2$p16std@locale@facet	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$p60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	segment virtual
	align	2
@@$xt$p60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	label	dword
	dd	4
	dw	144
	dw	12
	dd	@@$xt$60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	db	115
	db	116
	db	100
	db	58
	db	58
	db	115
	db	116
	db	114
	db	105
	db	110
	db	103
	db	32
	db	42
	db	0
@$xt$p60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$p20std@ios_base@failure	segment virtual
	align	2
@@$xt$p20std@ios_base@failure	label	dword
	dd	4
	dw	144
	dw	12
	dd	@@$xt$20std@ios_base@failure
	db	115
	db	116
	db	100
	db	58
	db	58
	db	105
	db	111
	db	115
	db	95
	db	98
	db	97
	db	115
	db	101
	db	58
	db	58
	db	102
	db	97
	db	105
	db	108
	db	117
	db	114
	db	101
	db	32
	db	42
	db	0
@$xt$p20std@ios_base@failure	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$11std@_Lockit	segment virtual
	align	2
@@$xt$11std@_Lockit	label	byte
	dd	8
	dw	3
	dw	48
	dd	-1
	dd	3
	dw	64
	dw	68
	dd	0
	dw	0
	dw	0
	dd	0
	dd	1
	dd	1
	dd	@@std@_Lockit@$bdtr$qv
	dw	1
	dw	72
	db	115
	db	116
	db	100
	db	58
	db	58
	db	95
	db	76
	db	111
	db	99
	db	107
	db	105
	db	116
	db	0
	db	0
	db	0
	db	0
	dd	0
	dd	0
	dd	0
@$xt$11std@_Lockit	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$p22std@ios_base@_Iosarray	segment virtual
	align	2
@@$xt$p22std@ios_base@_Iosarray	label	dword
	dd	4
	dw	16
	dw	12
	dd	@@$xt$22std@ios_base@_Iosarray
	db	115
	db	116
	db	100
	db	58
	db	58
	db	105
	db	111
	db	115
	db	95
	db	98
	db	97
	db	115
	db	101
	db	58
	db	58
	db	95
	db	73
	db	111
	db	115
	db	97
	db	114
	db	114
	db	97
	db	121
	db	32
	db	42
	db	0
@$xt$p22std@ios_base@_Iosarray	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$p21std@ios_base@_Fnarray	segment virtual
	align	2
@@$xt$p21std@ios_base@_Fnarray	label	dword
	dd	4
	dw	16
	dw	12
	dd	@@$xt$21std@ios_base@_Fnarray
	db	115
	db	116
	db	100
	db	58
	db	58
	db	105
	db	111
	db	115
	db	95
	db	98
	db	97
	db	115
	db	101
	db	58
	db	58
	db	95
	db	70
	db	110
	db	97
	db	114
	db	114
	db	97
	db	121
	db	32
	db	42
	db	0
@$xt$p21std@ios_base@_Fnarray	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$p10std@locale	segment virtual
	align	2
@@$xt$p10std@locale	label	dword
	dd	4
	dw	144
	dw	12
	dd	@@$xt$10std@locale
	db	115
	db	116
	db	100
	db	58
	db	58
	db	108
	db	111
	db	99
	db	97
	db	108
	db	101
	db	32
	db	42
	db	0
@$xt$p10std@locale	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$10std@locale	segment virtual
	align	2
@@$xt$10std@locale	label	byte
	dd	16
	dw	3
	dw	48
	dd	-1
	dd	7
	dw	60
	dw	76
	dd	0
	dw	0
	dw	0
	dd	0
	dd	1
	dd	1
	dd	@@std@locale@$bdtr$qv
	dw	1
	dw	80
	db	115
	db	116
	db	100
	db	58
	db	58
	db	108
	db	111
	db	99
	db	97
	db	108
	db	101
	db	0
	dd	@@$xt$16std@%_Locbase$i%
	dd	0
	dd	3
	dd	0
	dd	0
	dd	0
@$xt$10std@locale	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	segment virtual
	align	2
@@$xt$60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	label	byte
	dd	40
	dw	3
	dw	48
	dd	-1
	dd	7
	dw	120
	dw	136
	dd	0
	dw	0
	dw	0
	dd	0
	dd	1
	dd	1
	dd	@@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@$bdtr$qv
	dw	1
	dw	140
	db	115
	db	116
	db	100
	db	58
	db	58
	db	98
	db	97
	db	115
	db	105
	db	99
	db	95
	db	115
	db	116
	db	114
	db	105
	db	110
	db	103
	db	60
	db	99
	db	104
	db	97
	db	114
	db	44
	db	115
	db	116
	db	100
	db	58
	db	58
	db	99
	db	104
	db	97
	db	114
	db	95
	db	116
	db	114
	db	97
	db	105
	db	116
	db	115
	db	60
	db	99
	db	104
	db	97
	db	114
	db	62
	db	44
	db	115
	db	116
	db	100
	db	58
	db	58
	db	97
	db	108
	db	108
	db	111
	db	99
	db	97
	db	116
	db	111
	db	114
	db	60
	db	99
	db	104
	db	97
	db	114
	db	62
	db	32
	db	62
	db	0
	db	0
	db	0
	db	0
	dd	@@$xt$38std@%_String_val$c17std@%allocator$c%%
	dd	0
	dd	3
	dd	0
	dd	0
	dd	0
@$xt$60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$20std@ios_base@failure	segment virtual
	align	2
@@$xt$20std@ios_base@failure	label	byte
	dd	48
	dw	3
	dw	48
	dd	0
	dd	119
	dw	72
	dw	88
	dd	0
	dw	0
	dw	0
	dd	0
	dd	4
	dd	4
	dd	@@std@ios_base@failure@$bdtr$qv
	dw	1
	dw	92
	db	115
	db	116
	db	100
	db	58
	db	58
	db	105
	db	111
	db	115
	db	95
	db	98
	db	97
	db	115
	db	101
	db	58
	db	58
	db	102
	db	97
	db	105
	db	108
	db	117
	db	114
	db	101
	db	0
	db	0
	dd	@@$xt$17std@runtime_error
	dd	0
	dd	3
	dd	0
	dd	0
	dd	0
@$xt$20std@ios_base@failure	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@std@exception@3	segment virtual
	align	2
@@std@exception@3	label	byte
	dd	@@$xt$13std@exception
	dd	0
	dd	0
	dd	@@std@exception@$bdtr$qv
	dd	@@std@exception@what$xqv
@std@exception@3	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@std@runtime_error@3	segment virtual
	align	2
@@std@runtime_error@3	label	byte
	dd	@@$xt$17std@runtime_error
	dd	0
	dd	0
	dd	@@std@runtime_error@$bdtr$qv
	dd	@@std@runtime_error@what$xqv
@std@runtime_error@3	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@std@ios_base@failure@3	segment virtual
	align	2
@@std@ios_base@failure@3	label	byte
	dd	@@$xt$20std@ios_base@failure
	dd	0
	dd	0
	dd	@@std@ios_base@failure@$bdtr$qv
	dd	@@std@runtime_error@what$xqv
@std@ios_base@failure@3	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@std@ios_base@3	segment virtual
	align	2
@@std@ios_base@3	label	byte
	dd	@@$xt$12std@ios_base
	dd	0
	dd	0
	dd	@@std@ios_base@$bdtr$qv
@std@ios_base@3	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@$xt$12std@ios_base	segment virtual
	align	2
@@$xt$12std@ios_base	label	byte
	dd	48
	dw	3
	dw	48
	dd	8
	dd	119
	dw	64
	dw	80
	dd	0
	dw	0
	dw	0
	dd	0
	dd	1
	dd	1
	dd	@@std@ios_base@$bdtr$qv
	dw	1
	dw	84
	db	115
	db	116
	db	100
	db	58
	db	58
	db	105
	db	111
	db	115
	db	95
	db	98
	db	97
	db	115
	db	101
	db	0
	db	0
	db	0
	dd	@@$xt$13std@%_Iosb$i%
	dd	0
	dd	3
	dd	0
	dd	0
	dd	0
@$xt$12std@ios_base	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$38std@%_String_val$c17std@%allocator$c%%	segment virtual
	align	2
@@$xt$38std@%_String_val$c17std@%allocator$c%%	label	byte
	dd	16
	dw	3
	dw	32
	dd	-1
	dd	5
	dw	80
	dw	96
	dd	0
	dw	0
	dw	0
	dd	0
	db	115
	db	116
	db	100
	db	58
	db	58
	db	95
	db	83
	db	116
	db	114
	db	105
	db	110
	db	103
	db	95
	db	118
	db	97
	db	108
	db	60
	db	99
	db	104
	db	97
	db	114
	db	44
	db	115
	db	116
	db	100
	db	58
	db	58
	db	97
	db	108
	db	108
	db	111
	db	99
	db	97
	db	116
	db	111
	db	114
	db	60
	db	99
	db	104
	db	97
	db	114
	db	62
	db	32
	db	62
	db	0
	db	0
	db	0
	db	0
	dd	@@$xt$16std@_String_base
	dd	0
	dd	3
	dd	0
	dd	0
@$xt$38std@%_String_val$c17std@%allocator$c%%	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$16std@%_Locbase$i%	segment virtual
	align	2
@@$xt$16std@%_Locbase$i%	label	byte
	dd	8
	dw	1
	dw	16
	dd	-1
	dd	0
	db	115
	db	116
	db	100
	db	58
	db	58
	db	95
	db	76
	db	111
	db	99
	db	98
	db	97
	db	115
	db	101
	db	60
	db	105
	db	110
	db	116
	db	62
	db	0
	db	0
@$xt$16std@%_Locbase$i%	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$21std@ios_base@_Fnarray	segment virtual
	align	2
@@$xt$21std@ios_base@_Fnarray	label	byte
	dd	12
	dw	3
	dw	32
	dd	-1
	dd	1
	dw	56
	dw	60
	dd	0
	dw	0
	dw	0
	dd	0
	db	115
	db	116
	db	100
	db	58
	db	58
	db	105
	db	111
	db	115
	db	95
	db	98
	db	97
	db	115
	db	101
	db	58
	db	58
	db	95
	db	70
	db	110
	db	97
	db	114
	db	114
	db	97
	db	121
	db	0
	dd	0
	dd	0
@$xt$21std@ios_base@_Fnarray	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$22std@ios_base@_Iosarray	segment virtual
	align	2
@@$xt$22std@ios_base@_Iosarray	label	byte
	dd	16
	dw	3
	dw	32
	dd	-1
	dd	1
	dw	60
	dw	64
	dd	0
	dw	0
	dw	0
	dd	0
	db	115
	db	116
	db	100
	db	58
	db	58
	db	105
	db	111
	db	115
	db	95
	db	98
	db	97
	db	115
	db	101
	db	58
	db	58
	db	95
	db	73
	db	111
	db	115
	db	97
	db	114
	db	114
	db	97
	db	121
	db	0
	db	0
	db	0
	db	0
	dd	0
	dd	0
@$xt$22std@ios_base@_Iosarray	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$p16std@locale@facet	segment virtual
	align	2
@@$xt$p16std@locale@facet	label	dword
	dd	4
	dw	16
	dw	12
	dd	@@$xt$16std@locale@facet
	db	115
	db	116
	db	100
	db	58
	db	58
	db	108
	db	111
	db	99
	db	97
	db	108
	db	101
	db	58
	db	58
	db	102
	db	97
	db	99
	db	101
	db	116
	db	32
	db	42
	db	0
@$xt$p16std@locale@facet	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$17std@runtime_error	segment virtual
	align	2
@@$xt$17std@runtime_error	label	byte
	dd	48
	dw	3
	dw	48
	dd	0
	dd	119
	dw	68
	dw	84
	dd	0
	dw	0
	dw	0
	dd	0
	dd	3
	dd	3
	dd	@@std@runtime_error@$bdtr$qv
	dw	1
	dw	88
	db	115
	db	116
	db	100
	db	58
	db	58
	db	114
	db	117
	db	110
	db	116
	db	105
	db	109
	db	101
	db	95
	db	101
	db	114
	db	114
	db	111
	db	114
	db	0
	db	0
	dd	@@$xt$13std@exception
	dd	0
	dd	3
	dd	0
	dd	0
	dd	@@$xt$60std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%
	dd	8
	dd	0
@$xt$17std@runtime_error	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$13std@exception	segment virtual
	align	2
@@$xt$13std@exception	label	byte
	dd	4
	dw	3
	dw	48
	dd	0
	dd	115
	dw	64
	dw	68
	dd	0
	dw	0
	dw	0
	dd	0
	dd	1
	dd	1
	dd	@@std@exception@$bdtr$qv
	dw	1
	dw	72
	db	115
	db	116
	db	100
	db	58
	db	58
	db	101
	db	120
	db	99
	db	101
	db	112
	db	116
	db	105
	db	111
	db	110
	db	0
	db	0
	dd	0
	dd	0
	dd	0
@$xt$13std@exception	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$TLTR$@std@runtime_error@what$xqv	segment virtual
	align	2
@@_$TLTR$@std@runtime_error@what$xqv	label	dword
	dd	0
@_$TLTR$@std@runtime_error@what$xqv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTUR$@std@runtime_error@what$xqv	segment virtual
	align	2
@@_$ECTUR$@std@runtime_error@what$xqv	label	dword
	dd	@@_$TLTR$@std@runtime_error@what$xqv
	dd	0
	dd	-36
@_$ECTUR$@std@runtime_error@what$xqv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@std@runtime_error@what$xqv	segment virtual
@@std@runtime_error@what$xqv	proc	near
?live16499@0:
	push      ebp
	mov       ebp,esp
	add       esp,-36
	push      ebx
	mov       ebx,dword ptr [ebp+8]
@360:
	mov       eax,offset @@_$ECTUR$@std@runtime_error@what$xqv
	call      @__InitExceptBlockLDTC
?live16499@16: ; EBX = this
	lea       eax,dword ptr [ebx+8]
	cmp       dword ptr [eax+36],16
	jb        short @361
	mov       edx,dword ptr [eax+16]
	jmp short @362
@361:
	lea       edx,dword ptr [eax+16]
@362:
	mov       eax,dword ptr [ebp-36]
	mov       dword ptr fs:[0],eax
	mov       eax,edx
?live16499@32: ; 
@364:
@363:
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
@@std@runtime_error@what$xqv	endp
@std@runtime_error@what$xqv	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$16std@locale@facet	segment virtual
	align	2
@@$xt$16std@locale@facet	label	byte
	dd	8
	dw	3
	dw	48
	dd	0
	dd	115
	dw	68
	dw	72
	dd	0
	dw	0
	dw	0
	dd	0
	dd	1
	dd	1
	dd	@@std@locale@facet@$bdtr$qv
	dw	1
	dw	76
	db	115
	db	116
	db	100
	db	58
	db	58
	db	108
	db	111
	db	99
	db	97
	db	108
	db	101
	db	58
	db	58
	db	102
	db	97
	db	99
	db	101
	db	116
	db	0
	db	0
	dd	0
	dd	0
	dd	0
@$xt$16std@locale@facet	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$16std@_String_base	segment virtual
	align	2
@@$xt$16std@_String_base	label	byte
	dd	8
	dw	3
	dw	32
	dd	-1
	dd	4
	dw	52
	dw	68
	dd	0
	dw	0
	dw	0
	dd	0
	db	115
	db	116
	db	100
	db	58
	db	58
	db	95
	db	83
	db	116
	db	114
	db	105
	db	110
	db	103
	db	95
	db	98
	db	97
	db	115
	db	101
	db	0
	db	0
	db	0
	dd	@@$xt$19std@_Container_base
	dd	0
	dd	3
	dd	0
	dd	0
@$xt$16std@_String_base	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$13std@%_Iosb$i%	segment virtual
	align	2
@@$xt$13std@%_Iosb$i%	label	byte
	dd	8
	dw	1
	dw	16
	dd	-1
	dd	0
	db	115
	db	116
	db	100
	db	58
	db	58
	db	95
	db	73
	db	111
	db	115
	db	98
	db	60
	db	105
	db	110
	db	116
	db	62
	db	0
@$xt$13std@%_Iosb$i%	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@std@locale@facet@$bdtr$qv	segment virtual
@@std@locale@facet@$bdtr$qv	proc	near
?live16508@0:
	push      ebp
	mov       ebp,esp
	mov       eax,dword ptr [ebp+8]
@365:
	test      eax,eax
	je        short @366
	mov       edx,offset @@std@locale@facet@3+12
	mov       dword ptr [eax],edx
	test      byte ptr [ebp+12],1
	je        short @367
	push      eax
	call      @$bdele$qpv
	pop       ecx
@367:
@366:
@368:
	pop       ebp
	ret 
@@std@locale@facet@$bdtr$qv	endp
@std@locale@facet@$bdtr$qv	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@std@locale@facet@3	segment virtual
	align	2
@@std@locale@facet@3	label	byte
	dd	@@$xt$16std@locale@facet
	dd	0
	dd	0
	dd	@@std@locale@facet@$bdtr$qv
@std@locale@facet@3	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@$xt$19std@_Container_base	segment virtual
	align	2
@@$xt$19std@_Container_base	label	byte
	dd	8
	dw	1
	dw	16
	dd	-1
	dd	0
	db	115
	db	116
	db	100
	db	58
	db	58
	db	95
	db	67
	db	111
	db	110
	db	116
	db	97
	db	105
	db	110
	db	101
	db	114
	db	95
	db	98
	db	97
	db	115
	db	101
	db	0
	db	0
	db	0
	db	0
@$xt$19std@_Container_base	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
s@	label	byte
	;	s@+0:
	db	"C",0
	;	s@+2:
	db	"ios_base::badbit set",0
	;	s@+23:
	db	"ios_base::failbit set",0
	;	s@+45:
	db	"ios_base::eofbit set",0
	align	4
_DATA	ends
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
 extrn __Exception_list:dword
	public	@std@_Fpz
	public	@std@_BADOFF
 extrn @_ReThrowException$quipuc:near
 extrn @_ThrowExceptionLDTC$qpvt1t1t1uiuiuipuct1:near
 extrn @__InitExceptBlockLDTC:near
 extrn @$bnew$qui:near
 extrn @$bdele$qpv:near
@@std@locale@$bctr$qv equ @std@locale@$bctr$qv
 extrn @std@locale@$bctr$qv:near
@_strlen equ _strlen
 extrn _strlen:near
@@std@_String_base@_Xran$xqv equ @std@_String_base@_Xran$xqv
 extrn @std@_String_base@_Xran$xqv:near
@_memmove equ _memmove
 extrn _memmove:near
@@std@_String_base@_Xlen$xqv equ @std@_String_base@_Xlen$xqv
 extrn @std@_String_base@_Xlen$xqv:near
@_memcpy equ _memcpy
 extrn _memcpy:near
@@std@exception@$bdtr$qv equ @std@exception@$bdtr$qv
 extrn @std@exception@$bdtr$qv:near
@@_CatchCleanup$qv equ @_CatchCleanup$qv
 extrn @_CatchCleanup$qv:near
@@std@exception@what$xqv equ @std@exception@what$xqv
 extrn @std@exception@what$xqv:near
	?debug	D "ios.i" 13971 32499
	end
