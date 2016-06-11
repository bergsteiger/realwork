/*------------------------------------------------------------------------
 * filename - bsearch.c
 *
 * function(s)
 *        bsearch - binary search
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 25737 $        */

#include <stdlib.h>

/*--------------------------------------------------------------------------*

Name            bsearch - binary search

Usage           void *bsearch(const void *key, const void * base,
                              size_t nelem, size_t width,
                              int (*fcmp)(const void *, const void *) );

Prototype in    stdlib.h

Description     bsearch is a binary search  algorithm designed to search an
                arbitrary  table of  information. The  entries in  the table
                must  be  sorted  into  ascending  order  before  search is
                called.

                . key points to  the item to be searched  for. ("the search
                  key")

                . base points to the base (0th element) of the search table

                . nelem contains the number of entries in the table

                . width contains the number of bytes in each entry

                . fcmp  points to  a user-written  comparison routine. That
                  routine compares 2  items and returns a value  based on the
                  comparison.

                On each call to the comparison routine, the search function
                pass 2 arguments: key, a pointer to the item being searched
                for;  and elem,  a pointer   to the  element of  base being
                compared.
                fcmp  is free  to interpret  the search  key and  the table
                entry any way it likes.

Return value    bsearch returns the address of the first entry in the table
                that matches the search key.  If no match is found, bsearch
                returns 0.

                In bsearch:

                  If the key is         fcmp returns
                  -------------         ------------
                  Greater than *elem    An integer < 0
                  Identical to *elem    0
                  Less than *elem       An integer > 0

*---------------------------------------------------------------------------*/

#if defined(__SECURE)
void *_RTLENTRYF _EXPFUNC bsearch_s(const void *key, const void *base,
				    size_t nelem, size_t width,
				    int (_USERENTRY *fcmp)(const void *, const void *, void *context),
				    void *context)
#else
void *_RTLENTRYF _EXPFUNC bsearch(const void *key, const void *base,
				  size_t nelem, size_t width,
				  int (_USERENTRY *fcmp)(const void *, const void *))
#endif
{
    char  *kmin, *probe;
    int i, j;

#if defined(__SECURE)
    /* Constraints */
    if (nelem > RSIZE_MAX || width > RSIZE_MAX || (nelem && !(base && fcmp && key)))
    {
	__invoke_constraint_handler_s(__func__, 0, EINVAL);
	return 0;
    }
#endif

    kmin = (char *) base;
    while (nelem > 0){
	i = nelem >> 1;
	probe = kmin + i * width;
	j = (*fcmp)(key, probe
#if defined(__SECURE)
		    , context
#endif
	    );
	if (j == 0)
	    return(probe);
	else if (j < 0)
	    nelem = i;
	else  {
	    kmin = probe + width;
	    nelem = nelem - i - 1;
	}
    }
    return 0;
}
