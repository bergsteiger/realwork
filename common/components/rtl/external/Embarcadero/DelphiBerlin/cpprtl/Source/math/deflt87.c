/*------------------------------------------------------------------------
 * filename - deflt87.c
 *
 * function(s)
 *        none
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1992, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */


/* Default control word for the 387.  */

#include <float.h>

unsigned int _RTLENTRY _EXPDATA _default87 =
    RC_NEAR+PC_64+IC_AFFINE+EM_UNDERFLOW+EM_INEXACT+EM_DENORMAL;
