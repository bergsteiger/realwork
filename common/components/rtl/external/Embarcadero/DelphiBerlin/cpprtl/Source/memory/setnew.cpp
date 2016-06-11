/*-----------------------------------------------------------------------*
 * filename - setnew.cpp
 * C++ new
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1990, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 26648 $        */

#include <cstddef>
#include <cstdlib>
#include <new>
//#include <string>
#include <exception>

using namespace std;

new_handler _new_handler;

#if !defined(NOXX)
std::bad_alloc __bad_alloc;

static void default_new_handler() { throw __bad_alloc; }

static void init_new_handler(void)
{
    set_new_handler(default_new_handler);
}
#if !defined(_DINKUMWARE)
#pragma startup init_new_handler 0 /* Initializes the default new handler */
#else
/* Set new handler after globals init in Dinkumware */
#pragma startup init_new_handler 36
#endif

#endif
