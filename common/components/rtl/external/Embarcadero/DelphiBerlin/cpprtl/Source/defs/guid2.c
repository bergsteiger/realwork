/*[]------------------------------------------------------------[]*/
/*|                                                              |*/
/*|     guid2.c                                                  |*/
/*|                                                              |*/
/*|     This file contains the predefined GUIDs that also        |*/
/*|     prevent the EXE from running under WIN32s.               |*/
/*|                                                              |*/
/*[]------------------------------------------------------------[]*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 35387 $        */

#define __inline         // for VFW.H's static __inline functions
#include <objbase.h>
#include <vfw.h>