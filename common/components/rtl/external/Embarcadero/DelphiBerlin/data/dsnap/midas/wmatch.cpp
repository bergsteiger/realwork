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
#include "conv.h"
#if !defined(__ANDROID__)
#include <cwchar>
#endif
#define CharUpper( c )   toupper(*((int*) c) )
#define CharLower( c )   tolower(*((int*) c) )

#if 0
void OutputDebugString(const wchar_t * pszOutput)
{
   wprintf(pszOutput);
}
#endif
#endif

// Wide version definition.
#define isSingleWildCardW(cp)     (*cp == L'_' )
#define isMultiWildCardW(cp)      (*cp == L'%' )

typedef UINT16 far *pWORD;

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

WQPattern::WQPattern(pUCS2Char pat, UINT16 strLen, UINT16 fldNum, ucs2char_t escapeChar, BOOL bCase)
{

   /* make our own copy of the pattern so we can modify it to */
   /* eliminate escape characters. */
   /* this copy of the pattern is then used as storage for long substrings */
   UINT16 patLength = strLen + 1;
   pattern = new ucs2char_t[patLength];
   minLength = 0;
   // wcsncpy(pattern, pat, strLen);
   memcpy(pattern, pat, strLen*sizeof(ucs2char_t));
   pattern[patLength - 1] = 0;
   // fldNo = fldNum;
   BYTE scanOp = (fldNum == 0xFFFF) ? SCANFORCHAR : SCANBLOBFORCHAR;
   // BYTE scanOp = SCANFORCHAR;

   /* make a rough estimate of space required to store pattern match pCode */
   /* estimate based on worst case patterns "_t_t_t" --> 2.5 bytes per char */
   patMatchCode = new WORD[2 * patLength + (patLength / 2) + 5];
   WORD *pCode = patMatchCode;

   UINT16 bytesToSkip;
   BOOL inScan = FALSE;
   BOOL inJump = FALSE;
   BOOL inStrCmp = FALSE;
   pUCS2Char strToCompare = NULL;
   UINT16 bytesToCmp = 0;
   WORD * lastScan = patMatchCode;

   pUCS2Char pattrn = pattern;

   bCaseIn = bCase;

   while (*pattrn)
   {
      if (isMultiWildCardW(pattrn))
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

      else if (isSingleWildCardW(pattrn))
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

         minLength++;
         bytesToSkip++;
      }

      else
      {
         /* remove any escape characters from the pattern to match */
         if (*pattrn == escapeChar)
            memmove(pattrn, pattrn+1, WideStrLen(pattrn+1)*sizeof(ucs2char_t) );

         if (inJump)
         {
            *pCode++ = SKIPCHARS;
            memcpy(pCode, &bytesToSkip, sizeof(bytesToSkip));
            pCode += sizeof(bytesToSkip) / sizeof(WORD);
         }

         if (inScan)
         {
            *pCode++ = scanOp;
            *pCode++ = *pattrn;
            lastScan = pCode;
         }
         else
         {
            if (!inStrCmp)
            {
               inStrCmp = TRUE;
               strToCompare = pattrn;
               bytesToCmp = 0;
            }

            bytesToCmp++;
         }

         minLength++;

         inScan = FALSE;
         inJump = FALSE;
      }

      pattrn++;
   }

   /* Add the last compare operation if pattern ends in a string compare */
   if (inStrCmp)
      pCode = addStrCmp(pCode, strToCompare, bytesToCmp);

   *pCode = DONE;
   /* if the pattern does not end with arbitrary string specifier '%' */
   /* insert a command to check for a zero scan length after last scan. */
   if (!inScan)
   {
      memmove(lastScan + 1, lastScan, (pCode - lastScan + 1)*sizeof(WORD));
      *lastScan = CHECKFORZEROLEN;
   }

   /* check our estimate on the memory required for pCode */
   if (pCode - patMatchCode > 3 * patLength)
   {
      // SYSASSERT (FALSE, "Bad space estimate for pattern match pcode.");
      patMatchCode = NULL;
   }
}

WQPattern::~WQPattern()
{
   delete[] patMatchCode;
   if (pattern)
      delete[] pattern;
}

pWORD WQPattern::addStrCmp(pWORD pCode, pUCS2Char strToCompare, UINT16 bytesToCmp)
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
         *((pUCS2Char*)pCode) = strToCompare;
         pCode += sizeof(pUCS2Char) / sizeof(*pCode);
         break;
      }
   }
   else
   {
      // For unicode version, bytesToCmp means the number of character.
      switch(bytesToCmp)
      {
      case 0:
         return NULL;

      case 1:
         *pCode++ = COMPAREBYTE; // one word
         *pCode++ = *strToCompare;
         break;

      case 2:
         *pCode++ = COMPARE2BYTES; // two words - 32 bit compare
         *((pUINT32)pCode) = *(pUINT32)strToCompare;
         pCode += sizeof(UINT32) / sizeof(*pCode);
         break;

      case 3: // three words - 32 + 16 compare
         *pCode++ = COMPARE3BYTES;
         *((pUINT32)pCode) = *((pUINT32)strToCompare);
         pCode += sizeof(UINT32) / sizeof(*pCode);
         *((pUINT16)pCode) = *((pUINT16)strToCompare + 2);
         pCode += sizeof(UINT16) / sizeof(*pCode);
         break;

      case 4: // four words - 32 x 2 comapre
         *pCode++ = COMPARE4BYTES;
         *((pUINT32)pCode) = *((pUINT32)strToCompare);
         pCode += sizeof(UINT32) / sizeof(*pCode);
         *((pUINT32)pCode) = *((pUINT32)strToCompare + 1);
         pCode += sizeof(UINT32) / sizeof(*pCode);
         break;

      default:
         *pCode++ = COMPARESTRING;
         *(reinterpret_cast<pUINT16>(pCode)) = bytesToCmp;
         pCode += sizeof(UINT16) / sizeof(*pCode);
         *((pUCS2Char*)pCode) = strToCompare;
         pCode += sizeof(pUCS2Char) / sizeof(*pCode);
         break;
      }
   }
   return pCode;
}

#if 0  // used only for debugging the pattern compiler p-code

void WQPattern::dumpCode(BYTE *pCode)
{
   ucs2char_t buf[80];
   pUCS2Char pstr;

loop:

   switch(*pCode++)
   {

   case DONE:
      OutputDebugString("DONE\r\n");
      return;

   case CHECKFORZEROLEN:
      OutputDebugString("Last Scan - scan length should be zero\r\n");
      break;

   case SCANFORCHAR:
      wsprintf(buf, "Scan for byte '%c'\r\n", *pCode++);
      OutputDebugString(buf);
      break;

   case SCANBLOBFORCHAR:
      wsprintf(buf, "Scan BLOB for byte '%c'\r\n", *pCode++);
      OutputDebugString(buf);
      break;

   case SKIPCHARS:
      wsprintf(buf, "Skip the next %d bytes\r\n", *((pUINT16)pCode)++);
      OutputDebugString(buf);
      break;

   case COMPAREBYTE:
      wsprintf(buf, "Compare byte to value %c\r\n", *pCode++);
      OutputDebugString(buf);
      break;

   case COMPARE2BYTES:
      wsprintf(buf, "Compare 2 bytes to value %2s\r\n", pCode);
      OutputDebugString(buf);
      pCode += 2;
      break;

   case COMPARE3BYTES:
      wsprintf(buf, "Compare 3 bytes to value %3s\r\n", pCode);
      OutputDebugString(buf);
      pCode += 3;
      break;

   case COMPARE4BYTES:
      wsprintf(buf, "Compare 4 bytes to value %4s\r\n", pCode);
      OutputDebugString(buf);
      pCode += 4;
      break;

   case COMPARESTRING:
      {
         UINT16 bytes = *((pUINT16)pCode)++;
         pstr = *((pUCS2Char*)pCode)++;
         wsprintf(buf, "Compare %d bytes to string %s\r\n", bytes, pstr);
         OutputDebugString(buf);
         break;
      }

   default:
      OutputDebugString("ERROR in pattern match pcode\r\n");
      return;
   }
   goto loop;

}
#endif

BOOL WQPattern::doesMatch(pUCS2Char str)
{
   return doesMatch( str, (unsigned short) (WideStrLen( str )));
}

BOOL WQPattern::doesMatch(pUCS2Char str, UINT16 strLen)
{
   if (minLength > strLen)
      return FALSE;

   return execPatMatch(patMatchCode, str, strLen - minLength);
}

BOOL WQPattern::execPatMatch(WORD *pCode, pUCS2Char str, UINT16 scanLen)
{
   UINT16 cLen;

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
      lastScanPCode = pCode + 1;
      if (!scanLen)
      {
         if (bCaseIn)
         {
#if defined(__ANDROID__)
            if (toupper(*str) != toupper(*pCode))
#else
            if (towupper(*str) != towupper(*pCode))
#endif
               return FALSE;
         }
         else
         {
            if (*str != *pCode)
               return FALSE;
         }
         pCode++;
         str++;
      }
      else
      {
         ucs2char_t chr = *pCode++;
         pUCS2Char firstChar;
      trynext:
         if (bCaseIn)
         {
            ucs2char_t Up[2];
            ucs2char_t Low[2];
            Up[0] = chr;
            Up[1] = 0;
            Low[0] = chr;
            Low[1] = 0;

            WideUpperCase(Up);
            WideLowerCase(Low);

            UINT16 len = scanLen + 1;
            ucs2char_t* src = str;

            while (len > 0)
            {
               if ((*src == Up[0]) || (*src == Low[0]))
               {
                  firstChar = src;
                  break;
               }
               src++;
               len--;
            }
            if (len == 0)
               return FALSE;
         }
         else
         {
            UINT16 len = scanLen + 1;
            pUCS2Char src = str;

            while (len > 0)
            {
               if (*src == chr)
               {
                  firstChar = src;
                  break;
               }
               src++;
               len--;
            }
            if (len == 0)
               return FALSE;
         }

         /* found chr update position in string being compared and scanLen */
         scanLen -= firstChar - str;
         str = firstChar + 1;

         /* if the scan length is zero, this must be the match or else */
         /* no need to call in order to save current position on stack */
         if (!scanLen)
            break;

         /* check if remainder of the string matches rest of pattern */
         // at this point recurrsion is bad and will cause use to search
         // a string unnessecarily for patterns when we know it can not match
         // a case in point is the pattern "..th..th..th..th..th..th..th".  If we ever
         // do a scan and don't find a 't' then we know right then that the string
         // does not match the pattern.  But because of recurrsion we will perform
         // additional scans for the character 't'

         if (execPatMatch(pCode, str, scanLen))
            return TRUE;
         /* if we have done a scan after this one then we have matched */
         /* this componet and do not need to scan for it again! */
         if (lastScanPCode != pCode)
            return FALSE;

         /* This character did not match so skip over it and */
         /* decrement the scan length accordingly. */
         scanLen--;

         goto trynext;
      }

      break;

#if 0
   case SCANBLOBFORCHAR:
      lastScanPCode = pCode + 1;
      if (!scanLen)
      {
         if (*str != *pCode)
            return FALSE;
         pCode++;
         str++;
      }
      else
      {
         ucs2char_t chr = *pCode++;

      tryblobnext:
         if ((str = scanBlob(str, chr, &scanLen)) == NULL)
            return FALSE;

         /* if the scan length is zero, this must be the match or else */
         /* no need to call in order to save current position on stack */
         /* also update automatic scanLen with objects current scanLen */
         if (!scanLen)
            break;

         /* check if remainder of the string matches rest of pattern */
         // at this point recurrsion is bad and will cause use to search
         // a string unnessecarily for patterns when we know it can not match
         // a case in point is the pattern "..th..th..th..th..th..th..th".  If we ever
         // do a scan and don't find a 't' then we know right then that the string
         // does not match the pattern.  But because of recurrsion we will perform
         // additional scans for the character 't'

         if (execPatMatch(pCode, str, scanLen))
            return TRUE;
         /* if we have done a scan after this one then we have matched */
         /* this componet and do not need to scan for it again! */
         if (lastScanPCode != pCode)
            return FALSE;

         /* This character did not match so skip over it and */
         /* decrement the scan length accordingly and try again. */
         scanLen--;

         goto tryblobnext;
      }

      break;
#endif

   case SKIPCHARS:
      str += *((pUINT16)pCode);
      pCode += sizeof(UINT16) / sizeof(*pCode);
      break;

   case COMPAREBYTE:
      if (*str != *pCode)
         return FALSE;
      pCode++;
      str += 1;
      break;

   case COMPARE2BYTES:
      if (*((pUINT32)str) != *((pUINT32)pCode))
         return FALSE;
      pCode += 2;
      str += 2;
      break;

   case COMPARE3BYTES:
      if (*((pUINT32)str) != *((pUINT32)pCode))
         return FALSE;
      if (*((pUINT16)str + 2) != *((pUINT16)pCode + 2))
         return FALSE;
      pCode += 3;
      str += 3;
      break;

   case COMPARE4BYTES:
      if (*((pUINT32)str) != *((pUINT32)pCode))
         return FALSE;
      if (*((pUINT32)str + 1) != *((pUINT32)pCode + 1))
         return FALSE;
      pCode += 4;
      str += 4;
      break;

   case COMPARESTRING:
      cLen = *((pUINT16)pCode);
      pCode += 1;
      if (bCaseIn)
      {
         if (WideStrLIComp(str, cLen, *((pUCS2Char*)pCode), cLen))
            return FALSE;
      }
      else if (memcmp(str, *((pUCS2Char*)pCode), cLen*sizeof(WORD)))
         return FALSE;
      pCode = (WORD*)((BYTE*)pCode+sizeof(pUCS2Char));
      str += cLen;
      break;

   default:
#if 0
#ifdef _UNIX
      OutputDebugString(L"ERROR in pattern match pcode\r\n");
#else
      OutputDebugString("ERROR in pattern match pcode\r\n");
#endif
#endif
      return FALSE;
   }
   goto donextcmd;

}
