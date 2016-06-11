/********************************************************
*                                                       *
*                Delphi Runtime Library                 *
*                                                       *
* Copyright(c) 2016 Embarcadero Technologies, Inc.      *
*               All rights reserved                     *
*                                                       *
*   Copyright and license exceptions noted in source    *
*                                                       *
********************************************************/

#ifndef MATCH_H
#define MATCH_H

#ifndef _UNIX
  #include "windows.h"
#endif
#include "bdetypes.h"
#include "ossrv.h"

// SQL
#define isSingleWildCard(cp)     (*cp == '_' )
#define isMultiWildCard(cp)      (*cp == '%' )

// QBE
//#define isSingleWildCard(cp)     (*cp == '@' )
//#define isMultiWildCard(cp)      (*cp == '.' && *(cp + 1) == '.' )


/* QBE Notes                                                                */
/* A single . is not a wild card and does not need to be escaped.  It is    */
/*    treated as a character to match.                                      */
/* Thus a pattern of '.\.' or '\..' or '\.\.' asks us to search for a field */
/*    that contains '..' and does not imply any wild card matches.          */
/* Quotes '"' that occur in a pattern should be ignored unless they are     */
/*    escaped. '.."TODAY".. asks us to search for a field that contains     */
/*    the string TODAY.  This must be done since TODAY is a keyword in QBE. */

#ifndef WCHAR
typedef wchar_t WCHAR;
#endif
#ifndef PWCHAR
typedef wchar_t* PWCHAR;
#endif

class QPatternMB
{
public:
   QPatternMB(pCHAR pat, UINT16 fldNum, CHAR escapeChar, BOOL bCaseIn);

   ~QPatternMB ();

   BOOL doesMatch (pCHAR str);

   BOOL doesMatch (pCHAR str, UINT16 strLen );

   BOOL    bCaseIn;
   UINT32  lcid;

protected:
   pCHAR    pattern;
   UINT16   minLength;
   pBYTE   patMatchCode;
   pBYTE   lastScanPCode;

/* the following data is used for blob pattern matching only */
#if 0
   hDBICur  cursor;
   pBYTE    recBuf;
   UINT16   fldNo;
   pBYTE    bufEndPlus1;
   pBYTE    blobBuf;
   UINT32   nextOffset;
#endif

   pBYTE    addStrCmp (pBYTE pCode, pCHAR strToCompare, UINT16 bytesToCmp);
   BOOL     execPatMatch (BYTE *pCode, pCHAR str, UINT16 scanLen);
 //void     dumpCode (BYTE *pCode);
 //pCHAR    scanBlob (pCHAR start, char forChar, pUINT16 scanLen);
};

typedef UINT16    far *pWORD;

// UNICODE version QPattern
class WQPattern
{
public:
   WQPattern(pUCS2Char pat, UINT16 strLen, UINT16 fldNum, ucs2char_t escapeChar, BOOL bCaseIn);

   ~WQPattern ();

   BOOL doesMatch (pUCS2Char str);

   BOOL doesMatch (pUCS2Char str, UINT16 strLen );

   BOOL    bCaseIn;
//   UINT32  lcid;

private:
   pUCS2Char    pattern;
   UINT16   minLength;
   pWORD   patMatchCode;
   pWORD   lastScanPCode;

/* the following data is used for blob pattern matching only */
#if 0
   hDBICur  cursor;
   pBYTE    recBuf;
   UINT16   fldNo;
   pBYTE    bufEndPlus1;
   pBYTE    blobBuf;
   UINT32   nextOffset;
#endif

   pWORD    addStrCmp (pWORD pCode, pUCS2Char strToCompare, UINT16 bytesToCmp);
   BOOL     execPatMatch (WORD *pCode, pUCS2Char str, UINT16 scanLen);
   void     dumpCode (WORD *pCode);
 //PWCHAR   scanBlob (PWCHAR start, wchar_t forChar, pUINT16 scanLen);
};

#endif   // MATCH_H
