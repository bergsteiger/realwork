/*-----------------------------------------------------------------------*
 * filename - randomize.c
 *
 * function(s)
 *        randomize  - seed random number generator
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$        */

#include <stdlib.h>
#include <time.h>

void _RTLENTRY _EXPFUNC randomize(void)
{
    srand((unsigned) time(NULL));
}
