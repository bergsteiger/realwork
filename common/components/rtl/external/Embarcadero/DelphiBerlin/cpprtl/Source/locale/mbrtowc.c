/*-----------------------------------------------------------------------*
 * mbrtowc.c
 *
 * restartable multibyte to wchar conversions
 *
 * function(s)
 *        mbrtowc    - converts multibyte character to wide character
 *        mbrtowc_cp - converts multibyte character to wide character
 *                     with specified codepage
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2010, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <stdlib.h>
#include <mbctype.h>
#include <wchar.h>
#include <windows.h>
#include <_locale.h>

#if defined(__clang__)
  #if (__SIZEOF_WCHAR_T__ == 1)
  #error *** size of wchar_t is incorrect ***
  #endif
#else
  #if ( sizeof( wchar_t ) == 1 )
  #error *** size of wchar_t is incorrect ***
  #endif
#endif

// current maximum MBCS character length
#define MB_MAX_CHARLEN    2


/* Converts an MBCS char to Wide char        */

int _RTLENTRY _EXPFUNC mbrtowc( wchar_t *pwc, const char *s, size_t n, mbstate_t *mbs)

{
    /* return "no state-dependent encodings" */
    if ( (s == NULL)  || (n == 0) )
        return( 0 );

    if ( *s == 0 )
    {
        /* Null character */
        if ( pwc )
            *pwc = 0;
        return( 0 );
    }

    if ( __locale->isCLocale )
    {
        if ( pwc != NULL )
            /* zero extend */
            *pwc = (wchar_t) (unsigned char) *s;
        return( sizeof( char ) );
    }

    if (*mbs)
    {
        *((char *)mbs+1) = *s;
        if (MultiByteToWideChar(__locale->codepage, MB_PRECOMPOSED|MB_ERR_INVALID_CHARS, 
                                (char *)mbs, 2, pwc, (pwc) ? 1: 0) == 0)
        {
            *mbs = 0;
            return -1;
        }
        *mbs = 0;
        return MB_MAX_CHARLEN;
    }

    if ( _ismbblead( (unsigned char)*s ) )
    {
        if ((int)n < MB_MAX_CHARLEN)
        {
            *(char *)mbs = *s;
            return -2;
        }
        if (MultiByteToWideChar(__locale->codepage, MB_PRECOMPOSED|MB_ERR_INVALID_CHARS, 
                                s, MB_MAX_CHARLEN, pwc, (pwc) ? 1: 0) == 0)
        {
            if ( (int)n < MB_MAX_CHARLEN || (*(s+1) == 0))
                return -1;
        }
        return MB_MAX_CHARLEN;
    }
    else
    {
        /* Single byte charactr */
        if ( MultiByteToWideChar( __locale->codepage, MB_PRECOMPOSED|MB_ERR_INVALID_CHARS,
            s, 1, pwc, (pwc) ? 1: 0) == 0 )
                return -1;

        return sizeof ( char );
    }

}


/* Converts an MBCS char to Wide char with codepage        */

int _RTLENTRY _EXPFUNC mbrtowc_cp(wchar_t *pwc, const char *s, size_t n, 
                                  mbstate_t *mbs, const unsigned _codepage)
{
    /* return "no state-dependent encodings" */
    if ( (s == NULL)  || (n == 0) )
        return( 0 );


    if ( *s == 0 )
    {
        /* Null character */
        if ( pwc )
            *pwc = 0;
        return( 0 );
    }

    if ( _codepage == 0 ) // C Locale
    {
        if ( pwc != NULL )
            /* zero extend */
            *pwc = (wchar_t) (unsigned char) *s;
        return( sizeof( char ) );
    }

    if (*mbs)
    {
        char *s1 = (char *)mbs;
        s1[1] = *s;
        if (MultiByteToWideChar(_codepage, MB_PRECOMPOSED|MB_ERR_INVALID_CHARS, 
                                s1, 2, pwc, (pwc) ? 1: 0) == 0)
        {
            *mbs = 0;
            return -1;
        }
        *mbs = 0;
        return MB_MAX_CHARLEN;
    }

    if ( IsDBCSLeadByteEx(_codepage, (unsigned char)*s ) )
    {
        if ((int)n < MB_MAX_CHARLEN)
        {
            char *s1 = (char *)mbs;
            *s1 = *s;
            return -2;
        }
        if (MultiByteToWideChar(_codepage, MB_PRECOMPOSED|MB_ERR_INVALID_CHARS,
                                s, MB_MAX_CHARLEN, pwc, (pwc) ? 1: 0) == 0)
        {
            if ((int)n < MB_MAX_CHARLEN || (*(s+1) == 0 ))
                return -1;
        }
        return MB_MAX_CHARLEN;
    }
    else
    {
        /* Single byte charactr */
        if ( MultiByteToWideChar( _codepage, MB_PRECOMPOSED|MB_ERR_INVALID_CHARS,
            s, 1, pwc, (pwc) ? 1: 0) == 0 )
                return -1;

        return sizeof ( char );
    }
}
