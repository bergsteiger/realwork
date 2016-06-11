!include defines.mak

OBJS = \
	atan2f$(OBJ)   \
        ceilf$(OBJ)     \
	cosf$(OBJ)     \
	delaop$(OBJ)   \
	delaop2$(OBJ)  \
	delaop3$(OBJ)  \
	delop$(OBJ)    \
	delop2$(OBJ)   \
	delop3$(OBJ)   \
	exceptio$(OBJ) \
	exp2$(OBJ)     \
	exp2f$(OBJ)    \
	exp2l$(OBJ)    \
	expf$(OBJ)     \
        expm1$(OBJ)     \
        expm1f$(OBJ)     \
        expm1l$(OBJ)     \
	fiopen$(OBJ)   \
	fmodf$(OBJ)    \
	fwide$(OBJ)    \
        log2$(OBJ)   \
        log2f$(OBJ)   \
        log2l$(OBJ)   \
	gccex$(OBJ)    \
	gcctinfo$(OBJ) \
	iomanip$(OBJ)  \
	ios$(OBJ)      \
	iostream$(OBJ) \
	ldexpf$(OBJ)   \
	locale0$(OBJ)  \
	locale_dw$(OBJ) \
	logf$(OBJ)     \
	new$(OBJ)      \
	newaop$(OBJ)   \
	newaop2$(OBJ)  \
	newop$(OBJ)    \
	newop2$(OBJ)   \
	nothrow$(OBJ)  \
	powf$(OBJ)     \
	raisehan$(OBJ) \
	sinf$(OBJ)     \
	sqrtf$(OBJ)    \
	stdthrow$(OBJ) \
	string$(OBJ)   \
	tanf$(OBJ)     \
	wiostrea$(OBJ) \
	wlocale$(OBJ)  \
	xatan$(OBJ)    \
	xcosh$(OBJ)    \
	xdclass$(OBJ)  \
	xdint$(OBJ)    \
	xdnorm$(OBJ)   \
	xdscale$(OBJ) \
	xdtento$(OBJ)  \
	xdtest$(OBJ)   \
	xdunscal$(OBJ) \
	xexp$(OBJ)     \
	xfatan$(OBJ)   \
	xfcosh$(OBJ)   \
	xfdclass$(OBJ) \
	xfdint$(OBJ)   \
	xfdnorm$(OBJ)  \
	xfdscale$(OBJ) \
	xfdsign$(OBJ)  \
	xfdtento$(OBJ) \
	xfdtest$(OBJ)  \
	xfdunsca$(OBJ) \
	xferaise$(OBJ) \
	xferfc$(OBJ)   \
	xfexp$(OBJ)    \
	xfloat$(OBJ)   \
	xflog$(OBJ)    \
	xfprec$(OBJ) \
	xfquad$(OBJ)   \
	xfquad$(OBJ)   \
	xfsin$(OBJ)    \
	xfsinh$(OBJ)   \
        xftan$(OBJ)  \
	xfvalues$(OBJ) \
	xlcosh$(OBJ)   \
	xldint$(OBJ)   \
	xldnorm$(OBJ)  \
	xldscale$(OBJ) \
	xldsign$(OBJ)  \
	xldtento$(OBJ) \
	xldtest$(OBJ)  \
	xldunsca$(OBJ) \
	xlexp$(OBJ)    \
	xllog$(OBJ) \
	xlocale$(OBJ)  \
	xlocinfo$(OBJ) \
	xlog$(OBJ)\
	xlpoly$(OBJ)   \
	xlprec$(OBJ) \
	xlquad$(OBJ)   \
	xlsin$(OBJ)    \
	xlsinh$(OBJ)   \
	xlvalues$(OBJ) \
	xmtx$(OBJ)     \
	xmutex$(OBJ)   \
	xprec$(OBJ) \
	xquad$(OBJ)    \
	xsin$(OBJ)     \
	xsinh$(OBJ)    \
	xstart$(OBJ)   \
	xstod_dw$(OBJ)  \
	xstof$(OBJ)    \
	xstoflt$(OBJ)  \
	xstol$(OBJ)   \
	xstold$(OBJ)   \
	xstoll$(OBJ)   \
	xstopfx$(OBJ)  \
	xstoul$(OBJ)   \
	xstoull$(OBJ)  \
	xstoxflt$(OBJ) \
	xsyslock$(OBJ)  \
	xthrow$(OBJ)   \
	xvalues$(OBJ) \
#	inst$(OBJ)     \
#	limits$(OBJ)   \
#	strstrea$(OBJ) \
##       xfpostox$(OBJ) \
	$(EMPTY)

!if $d(WIN64)
OBJS = $(OBJS) \
	wchar$(OBJ)
!else
OBJS = $(OBJS) \
	wcharcx$(OBJ)
!endif

!if $d(WIN64)
# Until 64bit version available in RTL
OBJS = $(OBJS) \
	hypot$(OBJ) \
	hypotf$(OBJ) \
	hypotl$(OBJ) \
	ldexp$(OBJ)   \
	ldexpf$(OBJ)  \
	ldexpl$(OBJ)  \
	xatan$(OBJ)\
	xlatan$(OBJ)\
        acos$(OBJ)     \
        acosf$(OBJ)    \
        acosl$(OBJ)     \
        acosh$(OBJ)     \
        acoshf$(OBJ)    \
        acoshl$(OBJ)     \
        asin$(OBJ)    \
        asinf$(OBJ)   \
        asinl$(OBJ)   \
        asinh$(OBJ)    \
        asinhf$(OBJ)   \
        asinhl$(OBJ)   \
        atan$(OBJ)   \
        atan2$(OBJ)   \
        atan2f$(OBJ)  \
        atan2l$(OBJ)  \
        atanf$(OBJ)   \
        atanl$(OBJ)   \
        ceil$(OBJ)  \
        ceill$(OBJ)  \
	copysign$(OBJ) \
	copysignf$(OBJ) \
	copysignl$(OBJ) \
        cos$(OBJ)     \
        cosf$(OBJ)    \
        cosh$(OBJ)     \
        coshf$(OBJ)    \
        coshl$(OBJ)     \
        cosl$(OBJ)    \
        exp$(OBJ)     \
        expf$(OBJ)     \
        expl$(OBJ)     \
        fabs$(OBJ)  \
        fabsf$(OBJ)  \
        fabsl$(OBJ)  \
        floor$(OBJ)  \
        floorf$(OBJ)  \
        floorl$(OBJ)  \
        fmod$(OBJ)   \
        fmodl$(OBJ)  \
        frexp$(OBJ)  \
        frexpf$(OBJ)  \
        frexpl$(OBJ)  \
        log$(OBJ)   \
        logf$(OBJ)  \
        log10$(OBJ)   \
        log10f$(OBJ)   \
        log10l$(OBJ)   \
        log1p$(OBJ)   \
        log1pf$(OBJ)   \
        log1pl$(OBJ)   \
        logl$(OBJ)  \
        modf$(OBJ)  \
        modff$(OBJ)  \
        modfl$(OBJ)  \
	nan$(OBJ) \
	nanf$(OBJ) \
	nanl$(OBJ) \
        pow$(OBJ)   \
        powf$(OBJ)  \
        powl$(OBJ)  \
	round$(OBJ) \
	roundf$(OBJ) \
	roundl$(OBJ) \
        sin$(OBJ)   \
        sinf$(OBJ)  \
        sinh$(OBJ)   \
        sinhf$(OBJ)   \
        sinhl$(OBJ)   \
        sinl$(OBJ)  \
        sqrt$(OBJ)   \
        sqrtf$(OBJ)  \
        sqrtl$(OBJ)  \
        tan$(OBJ)   \
        tanf$(OBJ)  \
        tanh$(OBJ)   \
        tanhf$(OBJ)  \
        tanhl$(OBJ)   \
        tanl$(OBJ)  \
        xfhypot$(OBJ)  \
        xhypot$(OBJ)   \
        xlhypot$(OBJ)  \
        xltan$(OBJ)  \
        xtan$(OBJ)  \
	$(EMPTY)

!endif

PENDING = \
	$(EMPTY)

!if $d(WIN64)
HOLD = \
	strtof$(OBJ) \
	strtold$(OBJ) \
	wcstof$(OBJ) \
	wcstold$(OBJ) \
	xwstof$(OBJ)    \
	xwstoflt$(OBJ)  \
	xwstold$(OBJ)   \
	xwstopfx$(OBJ)  \
	xwstoxfl$(OBJ) \
	$(EMPTY)

#OBJS = $(OBJS) $(HOLD) 
!endif

!include rules.mak
