/*------------------------------------------------------------------------
 * filename - mathwhy.c
 *
 * function(s)
 *        _mathwhy - error message strings for matherr and _matherrl
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

char *_mathwhy [] = {
#ifdef  UNIX_matherr
        "argument domain error",
        "argument singularity ",
        "overflow range error ",
        "underflow range error",
        "total loss of significance",
        "partial loss of significance"
#else
        "DOMAIN",          /* argument domain error -- log (-1)            */
        "SING",            /* argument singularity      -- pow (0,-2))     */
        "OVERFLOW",        /* overflow range error      -- exp (1000)      */
        "UNDERFLOW",       /* underflow range error -- exp (-1000)         */
        "TLOSS",           /* total loss of significance -- sin(10e70) */
        "PLOSS"            /* partial loss of signif. -- not used          */
#endif
        };
