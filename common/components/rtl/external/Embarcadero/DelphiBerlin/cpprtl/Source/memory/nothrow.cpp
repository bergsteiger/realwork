/*-----------------------------------------------------------------------*
 * filename - nothrow.cpp
 * Global C++ instance of nothrow_t
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1999, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

/* Don't define nothrow if DINKUMWARE is in use, since they define their own */
#ifndef _DINKUMWARE

#include <new>

namespace std {

nothrow_t nothrow;

};

#endif /* _DINKUMWARE */
