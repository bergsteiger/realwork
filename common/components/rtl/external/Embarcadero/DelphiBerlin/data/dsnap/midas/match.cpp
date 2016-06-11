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

/* -------------------------------------------------------------------------
The pattern matcher determines whether a target text string matches a
pattern.

The current implementation of the pattern matcher is case-sensitive
for SQL.  QBE would require it to be case-insensitive or to have both
the pattern and target text string presented to it in a single (upper
or lower) case only.

Pattern matching has a preparation phase (compilation) and and
execution phase.  The compilation phase transforms the pattern
%abc%de_f into a set of pseudo or pcode instructions that can be
executed very quickly.

Both the length and the character specifications are used to determine
that the target string does not match the pattern as soon as possible.
For example the matching of strings "abcdef", "abcwzxydef" and "abcwzxydeafg"
will be terminated without matching any characters (first string) or
matching the "e_f" substrings.  In the first case the string is too
short to match the target. In the second case the d does not occur
soon enough and would never be found.  In the third case although the d
would be found at that point we know that the string is too long to
match the remainder of the pattern.

The pattern matcher limits the recursive nature of its implementation
by not repeating the previous scan for the first letter of a substring
once the current scan has been successfully completed.  An example of
this can be found in the code comments for the "scan" instruction.

Short substrings in the pattern (4 characters or less) are matched as
bytes, words, or dwords rather than using a string compare function.
They are also imbedded into the compiled pcode as operands.
------------------------------------------------------------------------- */

#pragma hdrstop
#include "match.h"
#ifdef _UNIX
#include <stdio.h>
#define CharUpper( c )   toupper(*((int*) c) )
#define CharLower( c )   tolower(*((int*) c) )

void OutputDebugString(const char * pszOutput)
{
   printf("%s", pszOutput);
}
#endif

#define DONE                0xFC
#define CHECKFORZEROLEN     0x01
#define SCANFORCHAR         0x02
#define SCANBLOBFORCHAR     0x03
#define SKIPCHARS           0x04
#define COMPAREBYTE         0x05
#define COMPARE2BYTES       0x06
#define COMPARE3BYTES       0x07
#define COMPARE4BYTES       0x08
#define COMPARESTRING       0x09

UINT16 blobBufLen = 4024;

// QPatternMB

QPatternMB::QPatternMB(pCHAR pat, UINT16 fldNum, CHAR escapeChar, BOOL bCase)
{

   /* make our own copy of the pattern so we can modify it to */
   /* eliminate escape characters. */
   /* this copy of the pattern is then used as storage for long substrings */
   UINT16 patLength = strlen(pat) + 1;
   pattern = new char[patLength];
   minLength = 0;
   strcpy(pattern, pat);
   // fldNo = fldNum;
   BYTE scanOp = (fldNum == 0xFFFF) ? SCANFORCHAR : SCANBLOBFORCHAR;
   // BYTE scanOp = SCANFORCHAR;

   /* make a rough estimate of space required to store pattern match pCode */
   /* estimate based on worst case patterns "_t_t_t" --> 2.5 bytes per char */
   patMatchCode = new BYTE[2 * patLength + (patLength / 2) + 5];
   BYTE *pCode = patMatchCode;

   UINT16 bytesToSkip;
   BOOL inScan = FALSE;
   BOOL inJump = FALSE;
   BOOL inStrCmp = FALSE;
   pCHAR strToCompare = NULL;
   UINT16 bytesToCmp = 0;

   pCHAR pattrn = pattern;

   // at least 1 bytes is needed to scan multibyte character in Blob.
   minLength = 1;

   bCaseIn = bCase;

   while (*pattrn)
   {
      if (isMultiWildCard(pattrn))
      {
         inScan = TRUE;
         /* dont set scan op here because we need to convert %__a to __%a */
         /* as they specify the same pattern */
         /* besides we dont know what character to scan for! */

         /* if this scan terminates a string to match then add it to pcode */
         if (inStrCmp)
         {
            pCode = addStrCmp(pCode, strToCompare, bytesToCmp);
            inStrCmp = FALSE;
         }

         /* do this to step over the multi character wild card in QBE */
         if (*pattrn == *(pattrn + 1))
            pattrn++;
      }
      else if (isSingleWildCard(pattrn))
      {

         if (!inJump)
         {
            /* if this jump terminates a string to match then add it to pcode */
            if (inStrCmp)
            {
               pCode = addStrCmp(pCode, strToCompare, bytesToCmp);
               inStrCmp = FALSE;
            }

            inJump = TRUE;
            bytesToSkip = 0;
         }

         minLength += 2; // may match doublebyte character
         bytesToSkip++;
      }
      else
      {
         /* remove any escape characters from the pattern to match */
         if (*pattrn == escapeChar)
         {
            strcpy(pattrn, pattrn + 1);
         }

         if (inJump)
         {
            *pCode++ = SKIPCHARS;
            memcpy(pCode, &bytesToSkip, sizeof(bytesToSkip));
            pCode += sizeof(bytesToSkip);
         }

         if (inScan)
         {
            *pCode++ = scanOp;
            *pCode++ = *pattrn;
#ifdef _UNIX
            if (((*(pBYTE)pattrn) >= 0x81) && ((*(pBYTE)pattrn) <= 0x9f) && *(pattrn + 1))
#else
            if (IsDBCSLeadByte((*(pBYTE)pattrn)) && *(pattrn + 1))
#endif
            {
               pattrn++;
               *pCode++ = *pattrn;
            }
         }
         else
         {
            if (!inStrCmp)
            {
               inStrCmp = TRUE;
               strToCompare = pattrn;
               bytesToCmp = 0;
            }

#ifdef _UNIX
            if (((*(pBYTE)pattrn) >= 0x81) && ((*(pBYTE)pattrn) <= 0x9f) && *(pattrn + 1))
#else
            if (IsDBCSLeadByte(*(pBYTE)pattrn) && *(pattrn + 1))
#endif
            {
               bytesToCmp++;
               minLength++;
               pattrn++;
            }
            bytesToCmp++;
            minLength++;
         }

         inScan = FALSE;
         inJump = FALSE;

      }

      pattrn++;
   }

   /* Add the last compare operation if pattern ends in a string compare */
   if (inStrCmp)
      pCode = addStrCmp(pCode, strToCompare, bytesToCmp);

   if (inJump)
   {
      *pCode++ = SKIPCHARS;
      memcpy(pCode, &bytesToSkip, sizeof(bytesToSkip));
      pCode += sizeof(bytesToSkip);
   }

   /* if the pattern does not end with arbitrary string specifier '%' */
   /* insert a command to check for a zero scan length after last scan. */
   if (!inScan)
      * pCode++ = CHECKFORZEROLEN;

   *pCode = DONE;

   /* check our estimate on the memory required for pCode */
   if (pCode - patMatchCode > 3 * patLength)
   {
      // SYSASSERT (FALSE, "Bad space estimate for pattern match pcode.");
      // pSystem->SysAssert("Bad space estimate for pattern match pcode.");
      patMatchCode = NULL;
   }
}

QPatternMB::~QPatternMB()
{
   delete[] patMatchCode;
   if (pattern)
      delete[] pattern;
}

pBYTE QPatternMB::addStrCmp(pBYTE pCode, pCHAR strToCompare, UINT16 bytesToCmp)
{
   if (bCaseIn)
   {
      switch(bytesToCmp)
      {
      case 0:
         return NULL;
      default:
         *pCode++ = COMPARESTRING;
         *((pUINT16)pCode) = bytesToCmp;
         pCode += sizeof(UINT16) / sizeof(*pCode);
         *((pCHAR*)pCode) = strToCompare;
         pCode += sizeof(pCHAR) / sizeof(*pCode);
         break;
      }
   }
   else
   {
      switch(bytesToCmp)
      {
      case 0:
         return NULL;

      case 1:
         *pCode++ = COMPAREBYTE;
         *pCode++ = *strToCompare;
         break;

      case 2:
         *pCode++ = COMPARE2BYTES;
         *((pUINT16)pCode) = *(pUINT16)strToCompare;
         pCode += sizeof(UINT16) / sizeof(*pCode);
         break;

      case 3:
         *pCode++ = COMPARE3BYTES;
         *((pUINT16)pCode) = *((pUINT16)strToCompare);
         pCode += sizeof(UINT16) / sizeof(*pCode);
         strToCompare += sizeof(UINT16) / sizeof(*strToCompare);
         *pCode++ = *strToCompare;
         break;

      case 4:
         *pCode++ = COMPARE4BYTES;
         *((pUINT32)pCode) = *(pUINT32)strToCompare;
         pCode += sizeof(UINT32) / sizeof(*pCode);
         break;

      default:
         *pCode++ = COMPARESTRING;
         *((pUINT16)pCode) = bytesToCmp;
         pCode += sizeof(UINT16) / sizeof(*pCode);
         *((pCHAR*)pCode) = strToCompare;
         pCode += sizeof(pCHAR) / sizeof(*pCode);
         break;
      }
   }
   return pCode;
}

unsigned char *OsLdMByteChr(const unsigned char *s, UINT16 c, INT32 nbyte)
{
   while (nbyte > 0)
   {
      if (*s == c)
         return (pBYTE)s;
#ifdef _UNIX
      if (((*(pBYTE)s) >= 0x81) && ((*(pBYTE)s) <= 0x9f))
#else
      if (IsDBCSLeadByte(*(pBYTE)s))
#endif
      {
         if (c == 0)
            return (nbyte <= 1 || s[1] == '\0') ? (unsigned char *)(s + 1) : NULL;
         s += 2;
         nbyte -= 2;
      }
      else
      {
         s++;
         nbyte--;
      }
   }
   return NULL;
}

/* ------------------- TYPEDEFS  --------------------------- */
typedef struct
{
   unsigned long length; /* number of bytes, 0,1,2,3,4 */
   unsigned short nmoji; /* number of characters, 0,1,2 */
   unsigned short c; /* result of table conversion */
   unsigned char c_f; /* 1 if c is kanji, else 0 */
}last_t;

#ifdef _UNIX
static void JC_getchar(const unsigned char *data, int length, last_t* plast)
#else
static void pascal JC_getchar(const unsigned char *data, int length, last_t* plast)
#endif
{
   unsigned char c;
   if (length <= 0 || (c = *data) == '\0')
   {
      plast->length = 0;
      return;
   }
#ifdef _UNIX
   if (!((c >= 0x81) && (c <= 0x9f)))
#else
   if (!IsDBCSLeadByte(c))
#endif
   {
      plast->length = 1; /* single byte */
      return;
   }
   if (length == 1)
   {
      plast->length = 1; /* treat invalid dbc as sbc */
      return;
   }
   c = *(data + 1);
   //
   // No trail-byte (second byte) validation.
   // Current implemtation of _ismbbtrail suppots only SJIS/Japanese.
   //
   // if (!_ismbbtrail(c)) {
   // plast->length = 1;         /* treat invalid dbc as sbc */
   // return;
   // }
   plast->length = 2;
}

int OsJLdCMtoB(const unsigned char *string, int nmoji)
{
   const unsigned char *p;
   last_t last;
   for (p = string; nmoji > 0 && *p; nmoji--)
   {
      JC_getchar(p, 999, &last);
      if (!last.length)
         return 0;
      p += last.length;
   }
   return(int)(p - string);
}

int OsJLdCBtoM(const unsigned char *string, int n)
{
   int nmoji = 0;
   last_t last;
   for (; n > 0 && *string; nmoji++)
   {
      JC_getchar(string, n, &last);
      if (!last.length)
         return 0;
      n -= last.length;
      string += last.length;
   }
   return nmoji;
}

BOOL QPatternMB::doesMatch(pCHAR str)
{
   return doesMatch( str, (unsigned short) (strlen(str)));
}

BOOL QPatternMB::doesMatch(pCHAR str, UINT16 strLen)
{
   return execPatMatch(patMatchCode, str, strLen);
}

BOOL QPatternMB::execPatMatch(BYTE *pCode, pCHAR str, UINT16 scanLen)
{
   INT16 nbytes; // for handling of _
   INT16 nscanbytes; // for handling of %x

   /* execute the pcode instructions to see if string matches the pattern */
donextcmd:

   switch(*pCode++)
   {

   case DONE:
      return TRUE;

   case CHECKFORZEROLEN:
      if (scanLen)
         return FALSE;
      break;

   case SCANFORCHAR:

#ifdef _UNIX
      if (((*(pBYTE)pCode) >= 0x81) && ((*(pBYTE)pCode) <= 0x9f))
#else
      if (IsDBCSLeadByte(*(pBYTE)pCode))
#endif
      {
         nscanbytes = 2;
      }
      else
      {
         nscanbytes = 1;
      }

      lastScanPCode = pCode + nscanbytes;
      if (scanLen < nscanbytes)
         return FALSE;
      if (scanLen == nscanbytes)
      {
         if (bCaseIn && nscanbytes == 1)
         {
#ifdef _UNIX
            return !strcasecmp(str, (pCHAR)pCode);
#else
            // Ignore SBCS compare.
            if (CompareStringA(lcid, NORM_IGNORECASE, str, 1, reinterpret_cast<LPCSTR>(pCode), 1) != 2)
               return FALSE;
#endif
         }
         else
         {
            if (memcmp(str, pCode, nscanbytes) != 0)
               return FALSE;
         }
         pCode += nscanbytes;
         str += nscanbytes;
         scanLen -= nscanbytes;
      }
      else
      {
         UINT16 chr = *(pBYTE)pCode;
         unsigned char *firstChar;
      trynext:
         for (; ; )
         {
            if (bCaseIn && nscanbytes == 1)
            {
               // Ignore SBCS compare.
               CHAR Up[2];
               CHAR Low[2];
               Up[0] = chr;
               Up[1] = 0;
               Low[0] = chr;
               Low[1] = 0;
               CharUpper(Up);
               CharLower(Low);

               firstChar = OsLdMByteChr((pBYTE)str, Up[0], scanLen - nscanbytes + 1);
               if (firstChar == NULL)
                  firstChar = OsLdMByteChr((pBYTE)str, Low[0], scanLen - nscanbytes + 1);
            }
            else
               firstChar = OsLdMByteChr((pBYTE)str, chr, scanLen - nscanbytes + 1);
            if (firstChar == NULL)
               return FALSE;
            // assume: nscanbytes = 1 or 2.
            if (nscanbytes <= 1 || firstChar[1] == pCode[1])
               break;
            scanLen -= (pCHAR)firstChar - str + nscanbytes;
            str = (pCHAR)firstChar + nscanbytes;
         }
         scanLen -= (pCHAR)firstChar - str + nscanbytes;
         str = (pCHAR)firstChar + nscanbytes;
         pCode += nscanbytes;

         /* check if remainder of the string matches rest of pattern */

         if (execPatMatch(pCode, str, scanLen))
            return TRUE;
         /* if we have done a scan after this one then we have matched */
         /* this componet and do not need to scan for it again! */
         if (lastScanPCode != pCode)
            return FALSE;

         pCode -= nscanbytes;
         goto trynext;
      }

      break;

   case SKIPCHARS:
      {
         INT16 nskip = *((pUINT16)pCode);
         pCode += sizeof(UINT16) / sizeof(*pCode);
         nbytes = OsJLdCMtoB((pBYTE)str, nskip);
         if (nbytes == 0 || nbytes > scanLen || (nbytes == scanLen && OsJLdCBtoM((pBYTE)str, nbytes)
               != nskip))
            return FALSE;
         str += nbytes;
         scanLen -= nbytes;
      }break;

   case COMPAREBYTE:
      if (scanLen < 1 || *str != *pCode)
         return FALSE;
      pCode++;
      str++;
      scanLen--;
      break;

   case COMPARE2BYTES:
      if (scanLen < 2 || *((pUINT16)str) != *((pUINT16)pCode))
         return FALSE;
      pCode += 2;
      str += 2;
      scanLen -= 2;
      break;

   case COMPARE3BYTES:
      /* shift off the high order byte to get the three bytes to compare */
      if (scanLen < 3 || (*((pUINT32)str) << 8) != (*((pUINT32)pCode) << 8))
         return FALSE;
      pCode += 3;
      str += 3;
      scanLen -= 3;
      break;

   case COMPARE4BYTES:
      if (scanLen < 4 || *((pUINT32)str) != *((pUINT32)pCode))
         return FALSE;
      pCode += 4;
      str += 4;
      scanLen -= 4;
      break;

   case COMPARESTRING:
      nbytes = *((pUINT16)pCode);
      pCode += sizeof(UINT16) / sizeof(*pCode);
      if (bCaseIn)
      {
         if (CompareString(lcid, NORM_IGNORECASE, str, nbytes,
               *((pCHAR*)pCode), nbytes) != 2)
            return FALSE;
      }
      else
      {
         if (memcmp(str, *(pCCHAR*)pCode, nbytes))
            return FALSE;
      }
      pCode += sizeof(pCCHAR*);
      str += nbytes;
      scanLen -= nbytes;
      break;

   default:
      OutputDebugString("ERROR in pattern match pcode\r\n");
      return FALSE;
   }
   goto donextcmd;
}
