/*------------------------------------------------------------------------
 * filename - _ctype.h
 *
 *      Helper functions for ctype.
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1992, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 24816 $ */

#ifdef __cplusplus
extern "C" {
#endif

int _RTLENTRY  _EXPFUNC __isctype(int c, int type);
int _RTLENTRY  _EXPFUNC __isctypeEx(int c, int type, int disallow);
int _RTLENTRY  _EXPFUNC __iswctype(int c, int type);
int _RTLENTRY  _EXPFUNC __iswctypeEx(int c, int type, int disallow);

#ifdef __cplusplus
}
#endif
