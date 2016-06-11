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

#ifdef _UNIX
#include <stdlib.h>
#include "conv.h"
#else
#include <windows.h>
#include <winnls.h> // for surrogate pair support.
#endif
#include <string.h>
#pragma hdrstop

#include "alctypes.h"
#include "ossrv.h"
#include "stdio.h"

#include "dspickle.h"
#include "dsxml.h"
#include "canex.h"

#ifndef _UNIX
#define min(__a,__b)    (((__a) < (__b)) ? (__a) : (__b))
#endif

#if defined(_UNIX)
const int _NL_CTYPE_CODESET_NAME = 0 << 16 + 14;
#endif

void DateDecode(DBIDATE Date, pUINT16 iMon, pUINT16 iDay, pINT16 iYear);

BOOL bIsNumber(pCHAR pVal, UINT32 iLen);

#define IsDigit(ch) (ch>='0'&& ch<='9')

DBIDATE DateEncode(UINT16 iMon, UINT16 iDay, INT16 iYear);
DBIResult TimeEncode(UINT16 iHour, UINT16 iMin, UINT16 iMilSec, pTIME pTime);
DBIResult TimeStampEncode(DBIDATE Date, TIME Time, pTIMESTAMP ptimeStamp);

void TimeStampDecode(TIMESTAMP TimeStamp, pDBIDATE Date, pTIME Time);
void TimeDecode(TIME time, pUINT16 iHour, pUINT16 iMin, pUINT16 iMilSec);

int EncodeStream(unsigned char*Input, unsigned int InputLen, unsigned char*Output, unsigned int*OutputLen);
int DecodeStream(unsigned char*Input, unsigned int InputLen, unsigned char*Output, unsigned int*OutputLen);

// Encode binary data
pCHAR DSXML_W::FromBINARY(pBYTE pValue, pUINT32 piLen)
{
   if (!pValue)
      return NULL;
   unsigned int iOutLen = *piLen*2+4;

   GetVarBuf(iOutLen);
   EncodeStream(pValue, *piLen, pVarBuf, &iOutLen);
   *piLen = iOutLen;
   return(pCHAR)pVarBuf;
}

// Decode binary data
DBIResult DSXML_W::ReadBinaryStr(pCHAR pValue, pCHAR pStr, pUINT32 piLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   unsigned int iInLen, iOutLen;

   if (pbBlank)
      *pbBlank = FALSE;
   iInLen = *piLen;

   rslt = DecodeStream((pBYTE)pValue, iInLen, (pBYTE)pStr, &iOutLen);
   *piLen = iOutLen;
   return rslt;
}

pCHAR DSXML_W::FromINT8(pBYTE pVal)
{
   pCHAR pcInt = pBuf;
   if (!pVal)
      return NULL;
   itoa((int)(*(pINT8)pVal), pBuf, 10);
   while (*pcInt == ' ')
      pcInt++;
   return pcInt;
}

pCHAR DSXML_W::FromINT16(pBYTE pVal)
{
   pCHAR pcInt = pBuf;

   if (!pVal)
      return NULL;
   itoa((int)(*(pINT16)pVal), pBuf, 10);
   while (*pcInt == ' ')
      pcInt++;
   return pcInt;
}

pCHAR DSXML_W::FromINT32(pBYTE pVal)
{
   pCHAR pcInt = pBuf;

   if (!pVal)
      return NULL;
   itoa((int)(*(pINT32)pVal), pBuf, 10);
   while (*pcInt == ' ')
      pcInt++;
   return pcInt;
}

pCHAR DSXML_W::FromINT64(pBYTE pVal)
{
   pCHAR pcInt = pBuf;

   if (!pVal)
      return NULL;
   sprintf(pBuf, "%lld", (INT64)(*(INT64*)pVal));
   while (*pcInt == ' ')
      pcInt++;
   return pcInt;
}

pCCHAR DSXML_W::FromBOOL8(pBYTE pValue)
{
   UINT32 iVal;
   if (!pValue)
      return NULL;
   iVal = *(pUINT8)pValue;
   return FromBOOL32((pBYTE) &iVal);
}

pCCHAR DSXML_W::FromBOOL16(pBYTE pValue)
{
   UINT32 iVal;
   if (!pValue)
      return NULL;
   iVal = *(pUINT16)pValue;
   return FromBOOL32((pBYTE) &iVal);
}

pCCHAR DSXML_W::FromBOOL32(pBYTE pValue)
{
   if (!pValue)
      return NULL;
   if (*(pUINT32)pValue == 0)
   {
      return "FALSE";
   }
   return "TRUE";
}

// YYYYMMDD   ISO8601
pCHAR DSXML_W::FromDATE(pBYTE pValue)
{

   UINT32 iDate;
   UINT16 iM, iD;
   INT16 iY;
   pCHAR pPtr = pBuf;

   if (!pValue)
      return NULL;
   iDate = *(pUINT32)pValue;
   DateDecode(iDate, &iM, &iD, &iY);
   // this formatting depends on system!
   if (iY <1000)
   {
      *pPtr++ = '0';
      if (iY < 100)
      {
         *pPtr++ = '0';
         if (iY < 10)
            *pPtr++ = '0';
      }
   }
   itoa(iY, pPtr, 10);
   pPtr += strlen(pPtr);
   if (iM <10)
   {
      *pPtr++ = '0';
   }
   itoa(iM, pPtr, 10);
   pPtr += strlen(pPtr);
   if (iD <10)
   {
      *pPtr++ = '0';
   }
   itoa(iD, pPtr, 10);
   return pBuf;
}

// HH:MM:SS[SSS]  iso8601 (should seconds/milliseconds be here ?)
pCHAR DSXML_W::FromTIME(pBYTE pValue)
{
   UINT32 iTime;
   UINT16 iH, iM, iMS;
   pCHAR pPtr = pBuf;

   if (!pValue)
      return NULL;
   iTime = *(pUINT32)pValue;
   TimeDecode(iTime, &iH, &iM, &iMS);
   // this formatting depends on system!
   if (iH <10)
   {
      *pPtr++ = '0';
   }
   itoa(iH, pPtr, 10);
   pPtr += strlen(pPtr);
   *pPtr++ = ':';
   if (iM < 10)
   {
      *pPtr++ = '0';
   }
   itoa(iM, pPtr, 10);
   pPtr += strlen(pPtr);
   *pPtr++ = ':';
   if (iMS < 10000)
   {
      *pPtr++ = '0';
   }
   if (iMS < 1000)
   {
      *pPtr++ = '0';
   }
   if (iMS < 100)
   {
      *pPtr++ = '0';
   }
   if (iMS < 10)
   {
      *pPtr++ = '0';
   }
   itoa(iMS, pPtr, 10);
   // pPtr += strlen(pPtr);
   return pBuf;
}

// YYYY:MM:DD['T'HH:MM:SSSS]
pCHAR DSXML_W::FromTIMESTAMP(pBYTE pValue)
{
   INT32 iTime;
   INT32 iDate;
   pCHAR pPtr = pBuf;
   CHAR Tmp[16];

   if (!pValue)
      return NULL;

   TimeStampDecode(*(pTIMESTAMP)pValue, &iDate, &iTime);
   if (iTime)
   {
      FromTIME((pBYTE) &iTime);
      strcpy(Tmp, pPtr);
      FromDATE((pBYTE) &iDate);
      pPtr += strlen(pBuf);
      *pPtr++ = 'T';
      strcpy(pPtr, Tmp);
   }
   else
      FromDATE((pBYTE) &iDate);
   return pBuf;
}

// YYYY:MM:DD['T'HH:MM:SSSS]
pCHAR DSXML_W::FromSQLTIMESTAMP(pBYTE pValue)
{
   SQLTIMESTAMP * pTimeStamp = (SQLTIMESTAMP*)pValue;
   UINT16 iY, iMo, iD, iH, iM, iMS;
   CHAR Tmp[21];
   if (!pValue)
      return NULL;
   // extract Time members from struct
   iY = (UINT16)pTimeStamp->year;
   iMo = pTimeStamp->month;
   iD = pTimeStamp->day;
   iH = pTimeStamp->hour;
   iM = pTimeStamp->minute;
   iMS = pTimeStamp->second * 1000 + pTimeStamp->fraction;
   if (iH + iM + iMS == 0)
      sprintf(Tmp, "%04d%02d%02d", iY, iMo, iD);
   else
      sprintf(Tmp, "%04d%02d%02dT%02d:%02d:%05d", iY, iMo, iD, iH, iM, iMS);
   strcpy(pBuf, Tmp);
   return pBuf;
}

pCHAR DSXML_W::FromSQLTIMESTAMPOFFSET(pBYTE pValue)
{
   SQLTIMESTAMPOFFSET * pTimeStampOffset = (SQLTIMESTAMPOFFSET*)pValue;
   UINT16 iY, iMo, iD, iH, iM, iMS;
   INT16 tzH, tzM;
   CHAR Tmp[27];
   if (!pValue)
      return NULL;
   // extract Time members from struct
   iY = (UINT16)pTimeStampOffset->year;
   iMo = pTimeStampOffset->month;
   iD = pTimeStampOffset->day;
   iH = pTimeStampOffset->hour;
   iM = pTimeStampOffset->minute;
   iMS = pTimeStampOffset->second * 1000 + pTimeStampOffset->fraction;
   tzH = pTimeStampOffset->timezone_hour;
   tzM = pTimeStampOffset->timezone_minute;
   if (iH + iM + iMS == 0)
      sprintf(Tmp, "%04d%02d%02d", iY, iMo, iD);
   else if (tzH < 0)
      sprintf(Tmp, "%04d%02d%02dT%02d:%02d:%05d-%02d:%02d", iY, iMo, iD, iH, iM, iMS, tzH, tzM);
   else
      sprintf(Tmp, "%04d%02d%02dT%02d:%02d:%05d+%02d:%02d", iY, iMo, iD, iH, iM, iMS, tzH, tzM);
   strcpy(pBuf, Tmp);
   return pBuf;
}

pCHAR DSXML_W::FromSINGLE(pBYTE pValue)
{
   pCHAR pPtr = pBuf;

   if (!pValue)
      return NULL;

#if defined(__ANDROID__)
   sprintf(pBuf, "%f", *pValue);
#else
   gcvt(*(SINGLE*)pValue, 8, pBuf);
#endif

   while (*pPtr == ' ')
      pPtr++;
   return pPtr;
}

pCHAR DSXML_W::FromFLOAT(pBYTE pValue)
{
   pCHAR pPtr = pBuf;

   if (!pValue)
      return NULL;

#if defined(__ANDROID__)
   sprintf(pBuf, "%f", PtrToDFloat(pValue));
#else
   gcvt(*(DFLOAT*)pValue, 16, pBuf);
#endif

   while (*pPtr == ' ')
      pPtr++;
   return pPtr;
}

pCHAR DSXML_W::FromFLOATIEEE(pBYTE pValue)
{
   if (!pValue)
      return NULL;

   return pBuf;
}

pCHAR DSXML_W::FromBCD(pBYTE pValue)
{
   if (!pValue)
      return NULL;
   pFMTBcd pBcd = (pFMTBcd)pValue;
   UINT32 iDecimals = pBcd->iSignSpecialPlaces & 63;
   UINT32 iIntPart = pBcd->iPrecision - iDecimals;
   UINT32 i, j, k;
   BOOL bFirst = FALSE;
   BYTE Tmp, iLow, iHigh;
   pCHAR pPtr = pBuf;

   if (pBcd->iSignSpecialPlaces&~63)
   {
      *pPtr = '-';
      pPtr++;
   }
   for (i = 64 - iDecimals - iIntPart, j = 0, k = 0; i < 64; i++, j++, k++)
   {
      Tmp = pBcd->iFraction[k];
      iLow = (BYTE)(Tmp & 0x0f);
      iHigh = (BYTE)(Tmp >> 4);

      if (j == iIntPart)
      {
         if (!bFirst)
         {
            *pPtr = '0';
            pPtr++;
            bFirst = TRUE;
         }
         *pPtr = '.';
         pPtr++;
      }

      if (bFirst || iHigh!=0)
      {
         bFirst = TRUE;
         *pPtr = (CHAR)(iHigh+'0');
         pPtr++;
      }
      j++;
      i++;
      if (j == iIntPart)
      {
         if (!bFirst)
         {
            *pPtr = '0';
            pPtr++;
            bFirst = TRUE;
         }
         *pPtr = '.';
         pPtr++;
      }
      if (i<64 && (bFirst || iLow!=0))
      {
         bFirst = TRUE;
         *pPtr = (CHAR)(iLow+'0');
         pPtr++;
      }
   }
   if (pPtr == pBuf)
   {
      *pPtr = (CHAR)'0';
      pPtr++;
   }
   *pPtr = 0;
   return pBuf;
}

// DATE encoding functions

#define D400 146097L
#define D100 36524L
#define D4 1461
#define D1 365

BOOL LocalIsLeapx(INT16 iYr)
{
   return(!(iYr % 4)) && (iYr % 100 || (!(iYr % 400)));
}

extern int iDayTable[2][13];

void WEAKATTR LocalMonthDay(UINT16 iN, UINT16 *piMon, UINT16 *piDay, UINT16 iYr)
{
   INT16 i, iDaysInMo, iLeapFlag;

   iLeapFlag = (INT16)LocalIsLeapx(iYr);

   for (i = 1; iN > (iDaysInMo = iDayTable[iLeapFlag][i++]); )
      iN -= iDaysInMo;

   *piMon = --i;
   *piDay = iN;
}

void DateDecode(DBIDATE Date, pUINT16 iMon, pUINT16 iDay, pINT16 iYear)
{
   INT32 mod400, mod100;
   UINT16 mod4, mod1;
   INT16 iYr;

   if (!Date)
   {
      *iMon = *iDay = *iYear = 0;
      return;
   }
   if (Date < 0)
   {
      // DecodeBCDate( Date, iMon, iDay, iYear);
      return;
   }

   mod400 = Date % D400;
   mod100 = mod400 % D100;
   mod4 = (UINT16)(mod100 % D4);
   mod1 = (UINT16)(mod4 % D1);

   iYr = (UINT16)(1 + (Date/D400)*400 + (mod400/D100)*100 + (mod100/D4)*4 + (mod4/D1));

   if (!mod1)
   { /* test end of year condition */
      iYr--;
      mod1 = (UINT16)(((!mod4) && (mod100 || !mod400)) ? 366 : 365);
   }

   LocalMonthDay(mod1, iMon, iDay, iYr);

   *iYear = iYr;

}

#define   MILSECSPERMIN      60000L
#define   MILSECSPERHOUR   3600000L
#define   MILSECSPERDAY   86400000L

void TimeDecode(TIME time, pUINT16 iHour, pUINT16 iMin, pUINT16 iMilSec)
{

   if (time >= MILSECSPERDAY)
   {
      *iHour = 0;
      *iMin = 0;
      *iMilSec = 0;
   }
   else
   {
      *iHour = (UINT16)(time / MILSECSPERHOUR);
      *iMin = (UINT16)((time - ((TIME)*iHour * MILSECSPERHOUR)) / MILSECSPERMIN);
      *iMilSec = (UINT16)(time - ((TIME)*iHour * (TIME)MILSECSPERHOUR) - ((TIME)*iMin * (TIME)MILSECSPERMIN));
   }
}

void TimeStampDecode(TIMESTAMP TimeStamp, pDBIDATE Date, pTIME Time)
{
   *Date = (DBIDATE)(TimeStamp / (TIMESTAMP)MILSECSPERDAY);
   *Time = (TIME)(TimeStamp - TIMESTAMP(((TIMESTAMP)(*Date)) * ((TIMESTAMP)MILSECSPERDAY)));
   if (*Time < (TIME)0)
   {
      (*Date)--;
      (*Time) += MILSECSPERDAY;
   }

   if (*Time >= MILSECSPERDAY)
   {
      *Time -= MILSECSPERDAY;
      (*Date)++;
   }
}

DBIResult DSXML_W::ReadBOOL(pCHAR pValue, pBOOL pbBool, UINT32 iValLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   BOOL bBlank = (iValLen == 0); // !bIsNumber(pValue, iValLen);
   if (pbBlank)
      *pbBlank = bBlank;
   if (!bBlank)
      if (bBlank)
         return rslt;

   if (*pValue == 'T' || *pValue == 't') // && iLen == 4)
      *pbBool = TRUE;
   else
   {
      if (*pValue == 'F' || *pValue == 'f') // && iLen == 5)
         *pbBool = FALSE;
      else
         (VOID)SetError(DBIERR_DATAPACKETMISMATCH);
   }
   return rslt;
}

DBIResult DSXML_W::ReadINT32(pCHAR pValue, pINT32 pInt, UINT32 iValLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   BOOL bBlank = !bIsNumber(pValue, iValLen);
   if (pbBlank)
      *pbBlank = bBlank;
   if (!bBlank)
      *pInt = atoi(pValue);
   return rslt;
}

DBIResult DSXML_W::ReadUINT32(pCHAR pValue, pUINT32 pUInt, UINT32 iValLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   BOOL bBlank = !bIsNumber(pValue, iValLen);
   if (pbBlank)
      *pbBlank = bBlank;
   if (!bBlank)
      *pUInt = atoi(pValue);
   return rslt;
}

DBIResult DSXML_W::ReadStr(pCHAR pValue, pCHAR pStr, pUINT32 piLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   CHAR ch;
   if (pbBlank)
      *pbBlank = FALSE;
   UINT32 i, j;
   for (i = 0, j = 0; i<*piLen; i++)
   {
      // If input is UTF8 stream,
      ch = pValue[i];
      if (bUTF8 && ((unsigned char)ch >= 0x80))
      {
         unsigned char ch8 = pValue[i];
         int iUTF8Len = 1; // worst case.
         if (ch8 <= 0xDF) // 2bytes - 110x xxxx
            iUTF8Len = 2;
         else if (ch8 <= 0xEF) // 3bytes- 1110 1xxx
            iUTF8Len = 3;
         else if (ch8 <= 0xF7) // 4bytes - 1111 01xx
            iUTF8Len = 4;

         CHAR mbcsBuf[4];
         int mbcsLength = UTF8ToMultiByte(iANSICodePage, (pBYTE)pValue+i, iUTF8Len, (pBYTE)mbcsBuf, sizeof(mbcsBuf));
         if (mbcsLength != 0)
            for (int Ind = 0; Ind < mbcsLength; Ind++)
            {
               if (pStr)
                 pStr[j] = mbcsBuf[Ind];
               j++;
            }

         i += iUTF8Len-1;
         continue;
      }
      else if (ch == '&')
      { // escape
         switch(pValue[i+1])
         {
         case 'a':
            if (pValue[i+2] == 'p')
            {
               ch = 39; // ' apostrophe
               i+= 5; // "apos;"
            }
            else
            {
               ch = '&';
               i+= 4; // "amp;"
            }
            break;
         case 'q':
            ch = '"';
            i+= 5; // "quot;"
            break;
         case 'l':
            ch = '<';
            i+=3; // "lt;"
            break;
         case 'g':
            ch = '>';
            i+=3; // "gt;"
            break;
         case '#':
            i+=2;
            if (pValue[i] == 'x')
            {
               UINT32 ic;
               ch = 0;
               do
               {
                  ic = pValue[++i];
                  if (ic>='0' && ic<='9')
                     ic = ic-'0';
                  else if (ic>='A' && ic<='F')
                     ic = 10+ic-'A';
                  else if (ic>='a' && ic<='f')
                     ic = 10+ic-'a';
                  else
                     break;
                  ch = (CHAR)((ch<<4) +ic);
               }
               while (TRUE);
            }
            else
            {
               ch = (CHAR)atoi(&pValue[i]);
            }
            while (pValue[i] != ';')
            {
               i++;
               if (i>=*piLen)
                  break;
            }

         }
      }

      if (pStr) // ANSI or 7bit-ascii part.
         pStr[j] = ch;
      j++;
   }
   if (piLen)
      *piLen = j; // Update
   if (pStr)
      pStr[j] = 0; // Zeroterminate
   if (piLen)
      *piLen = *piLen+1; // Includes 0
   return rslt;
}

DBIResult DSXML_W::ReadSINGLE(pCHAR pValue, pSINGLE pSingle, UINT32 iValLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   BOOL bBlank = !bIsNumber(pValue, iValLen);
   if (pbBlank)
      *pbBlank = bBlank;
   if (!bBlank)
#if defined(MIDAS_OBJ)
	  *pSingle = bsdstrtod(pValue, NULL);
#else
	  *pSingle = atof(pValue);
#endif
   return rslt;
}

DBIResult DSXML_W::ReadFLOAT(pCHAR pValue, pDFLOAT pDFloat, UINT32 iValLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   BOOL bBlank = !bIsNumber(pValue, iValLen);
   if (pbBlank)
      *pbBlank = bBlank;
   if (!bBlank)
#if defined(MIDAS_OBJ)
	  *pDFloat = bsdstrtod(pValue, NULL);
#else
	  *pDFloat = atof(pValue);
#endif
   return rslt;
}

DBIResult DSXML_W::ReadFLOATIEEE(pCHAR pValue, long double * pFloatIEEE, UINT32 iValLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   BOOL bBlank = !bIsNumber(pValue, iValLen);
   if (pbBlank)
      *pbBlank = bBlank;
   if (!bBlank)
#if _MSC_VER || defined(__ANDROID__)
      //double and long double are equivalent with Microsoft Visual C++
      //strtold does not exist in android ndk
      *pFloatIEEE = strtod(pValue, NULL);
#else
#if defined(__GNUC__) && !defined(__BORLANDC__)
      *pFloatIEEE = strtold(pValue, NULL);
#else
      *pFloatIEEE = _atold(pValue);
#endif //GNUC and not BORLANDC
#endif //MSC_VER

   return rslt;
}

DBIResult DSXML_W::ReadBCD(pCHAR pValue, pBYTE pBcd, UINT32 iValLen, pBOOL pbBlank, UINT32 iPrecision, UINT32 iDecimals)
{
   DBIResult rslt = DBIERR_NONE;
   FMTBcd Bcd;
   UINT32 iFixedIntPart = iPrecision-iDecimals;
   INT32 iIntPart = -1;
   INT32 iStart, i, iDigCnt = 0;
   pCHAR pPos = pValue;
   CHAR ch;
   CHAR Digits[65];
   BOOL bSign = FALSE;
   BOOL bBlank = !bIsNumber(pValue, iValLen);
   if (pbBlank)
      *pbBlank = bBlank;
   if (bBlank)
      return rslt;

   ZeroMem((pBYTE) &Bcd, sizeof(Bcd));
   while ((ch = *pPos)!=0 && iDigCnt<64)
   {
      if (ch>='0' && ch<='9')
      {
         Digits[iDigCnt++] = (CHAR)(ch-'0');
      }
      else if (ch == '-' && iDigCnt == 0)
         bSign = TRUE;
      else if (ch == '.')
         iIntPart = iDigCnt;
      else if (ch!=' ')
         break; // truncate ?
      pPos++;
   }
   Digits[iDigCnt] = 0; // (just to avoid checking below)

   if (iIntPart == -1)
      iIntPart = iDigCnt;

   if (pbBlank)
      *pbBlank = (iDigCnt == 0);
   iStart = iFixedIntPart-iIntPart;
   if (iStart<0)
      return DBIERR_OUTOFRANGE; // Too big ?
   Bcd.iPrecision = (BYTE)iPrecision;
   Bcd.iSignSpecialPlaces = (BYTE)(iDecimals + (bSign? 0x80 : 0));
   for (i = 0; i<iDigCnt; i++)
   {
      if (i == 0 && iStart & 0x0001)
      {
         iStart = (iStart>>1);
         Bcd.iFraction[iStart++] = Digits[0];
      }
      else
      {
         if (i == 0)
            iStart = (iStart>>1);
         Bcd.iFraction[iStart++] = (BYTE)((Digits[i]<<4) | Digits[i+1]);
         i++;
      }
   }
   if (pBcd)
      CopyMem(pBcd, (pBYTE) &Bcd, 18); // sizeof(Bcd)); //Is it smaller ?
   return rslt;
}

BOOL ExtractDate(pCHAR pValue, UINT32 iValLen, pINT16 py, pINT16 pm, pINT16 pd, pUINT32 piValLen, pCHAR* ppValue)
{
   CHAR Temp[10];
   INT16 J;
   CHAR ch;

   J = 0;
   while (J < 4 && iValLen-- > 0)
   {
      ch = *pValue++;
      if (!IsDigit(ch))
         continue;
      Temp[J++] = ch;
   }
   if (J < 2 || J == 3)
   {
   Blank:
      return true;
   }
   Temp[J] = 0;
   *py = (INT16)atoi(Temp);

   J = 0;
   while (J < 2 && iValLen-- > 0)
   {
      ch = *pValue++;
      if (!IsDigit(ch))
         continue;
      Temp[J++] = ch;
   }

   if (J < 2)
      goto Blank;

   Temp[J] = 0;
   *pm = (INT16)atoi(Temp);

   J = 0;
   while (J < 2 && iValLen-- > 0)
   {
      ch = *pValue++;
      if (!IsDigit(ch))
         continue;
      Temp[J++] = ch;
   }

   if (J < 1)
      goto Blank;
   Temp[J] = 0;
   *pd = (INT16)atoi(Temp);
   if (*pm > 12 || *pd > 31)
      goto Blank;
   if (ppValue)
      *ppValue = pValue;
   if (piValLen)
      *piValLen = iValLen;
   return FALSE;
}

DBIResult DSXML_W::ReadDATE(pCHAR pValue, pUINT32 piDate, UINT32 iValLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   DBIDATE Date;
   INT16 y, m, d;

   if (ExtractDate(pValue, iValLen, &y, &m, &d, NULL, NULL))
   {
      // Blank:
      if (pbBlank)
         *pbBlank = true;
      return rslt;
   }
   Date = DateEncode(m, d, y);
   *piDate = Date;
   if (pbBlank)
      *pbBlank = false;
   return rslt;
}

DBIResult DSXML_W::ReadTIME(pCHAR pValue, pUINT32 piTime, UINT32 iValLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   BOOL bBlank = !bIsNumber(pValue, iValLen);
   if (pbBlank)
      *pbBlank = bBlank;
   if (bBlank)
      return rslt;

   CHAR temp[10];
   pCHAR pPtr = &pValue[0];
   UINT32 i;
   UINT16 h, m;
   UINT32 ms;
   TIME iTime;

   h = (INT16)atoi(pPtr);
   pPtr+=3;
   m = (INT16)atoi(pPtr);
   pPtr+=3;
   i = 0;
   while (*pPtr>='0' && *pPtr<='9')
      temp[i++] = *pPtr++;
   while (i<5) // Max is 59,999
   {
      temp[i++] = '0';
   }
   temp[i] = 0;
   ms = atoi(temp);
   TimeEncode(h, m, (UINT16)ms, &iTime);
   *piTime = iTime;
   return rslt;
}

DBIResult DSXML_W::ReadTIMESTAMP(pCHAR pValue, pDFLOAT piTimeStamp, UINT32 iValLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   INT16 y, m, d;
   DBIDATE Date;
   TIME Time;

   if (ExtractDate(pValue, iValLen, &y, &m, &d, &iValLen, &pValue))
   {
      // Blank:
      if (pbBlank)
         *pbBlank = true;
      return rslt;
   }
   Date = DateEncode(m, d, y);

   Time = 0;
   if (pValue[0] == 'T')
   {
      pCHAR pPtr = &pValue[1];
      UINT32 i;
      UINT16 h, m;
      UINT32 ms;
      CHAR temp[10];

      h = (INT16)atoi(pPtr);
      pPtr+=3;
      m = (INT16)atoi(pPtr);
      pPtr+=3;
      i = 0;
      while (*pPtr>='0' && *pPtr<='9')
         temp[i++] = *pPtr++;
      while (i<5) // Max is 59,999
      {
         temp[i++] = '0';
      }
      temp[i] = 0;
      ms = atoi(temp);
      TimeEncode(h, m, (UINT16)ms, &Time);
   }
   TimeStampEncode(Date, Time, piTimeStamp);
   if (pbBlank)
      *pbBlank = false;
   return rslt;
}

DBIResult ReadSQLDate(pCHAR pValue, SQLTIMESTAMP * pTimeStamp)
{
   CHAR temp[10];
   CopyMem(temp, pValue, 4);
   temp[4] = 0;
   pTimeStamp->year = (INT16)atoi(temp);
   temp[0] = pValue[4];
   temp[1] = pValue[5];
   temp[2] = 0;
   pTimeStamp->month = (INT16)atoi(temp);
   temp[0] = pValue[6];
   temp[1] = pValue[7];
   temp[2] = 0;
   pTimeStamp->day = (INT16)atoi(temp);
   return DBIERR_NONE;
}

DBIResult ReadSQLDate(pCHAR pValue, SQLTIMESTAMPOFFSET * pTimeStamp)
{
   CHAR temp[10];
   CopyMem(temp, pValue, 4);
   temp[4] = 0;
   pTimeStamp->year = (INT16)atoi(temp);
   temp[0] = pValue[4];
   temp[1] = pValue[5];
   temp[2] = 0;
   pTimeStamp->month = (INT16)atoi(temp);
   temp[0] = pValue[6];
   temp[1] = pValue[7];
   temp[2] = 0;
   pTimeStamp->day = (INT16)atoi(temp);
   return DBIERR_NONE;
}

DBIResult ReadSQLTime(pCHAR pValue, SQLTIMESTAMP * pTimeStamp)
{
   CHAR temp[10];
   pCHAR pPtr = &pValue[0];
   UINT32 i, iMs;
   pTimeStamp->hour = (UINT16)atoi(pPtr);
   pPtr+=3;
   pTimeStamp->minute = (UINT16)atoi(pPtr);
   pPtr+=3;
   i = 0;
   while (*pPtr>='0' && *pPtr<='9')
      temp[i++] = *pPtr++;
   while (i<5) // Max is 59,999
      temp[i++] = '0';
   temp[i] = 0;
   iMs = atoi(temp);
   pTimeStamp->second = (UINT16)(iMs/1000);
   pTimeStamp->fraction = (UINT32)iMs - (pTimeStamp->second * 1000);
   return DBIERR_NONE;
}

DBIResult ReadSQLTime(pCHAR pValue, SQLTIMESTAMPOFFSET * pTimeStamp)
{
   CHAR temp[10];
   pCHAR pPtr = &pValue[0];
   UINT32 i, iMs;
   pTimeStamp->hour = (UINT16)atoi(pPtr);
   pPtr+=3;
   pTimeStamp->minute = (UINT16)atoi(pPtr);
   pPtr+=3;
   i = 0;
   while (*pPtr>='0' && *pPtr<='9')
      temp[i++] = *pPtr++;
   while (i<5) // Max is 59,999
      temp[i++] = '0';
   temp[i] = 0;
   iMs = atoi(temp);
   pTimeStamp->second = (UINT16)(iMs/1000);
   pTimeStamp->fraction = (UINT32)iMs - (pTimeStamp->second * 1000);
   return DBIERR_NONE;
}

DBIResult ReadSQLTimeOS(pCHAR pValue, SQLTIMESTAMPOFFSET * pTimeStamp)
{
   pCHAR pPtr = &pValue[0];

   pTimeStamp->timezone_hour = (INT16)atoi(pPtr);
   pPtr+=3;
   pTimeStamp->timezone_minute = (INT16)atoi(pPtr);
   return DBIERR_NONE;
}

DBIResult DSXML_W::ReadSQLTIMESTAMP(pCHAR pValue, SQLTIMESTAMP * pTimeStamp, UINT32 iValLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   BOOL bBlank = !bIsNumber(pValue, iValLen);
   if (pbBlank)
      *pbBlank = bBlank;
   if (bBlank)
      return rslt;
   memset(pTimeStamp, 0, sizeof(SQLTIMESTAMP));
   ReadSQLDate(pValue, pTimeStamp);
   if ((pValue + 8)[0] == 'T')
      ReadSQLTime(pValue + 9, pTimeStamp);
   return rslt;
}

DBIResult DSXML_W::ReadSQLTIMESTAMPOFFSET(pCHAR pValue, SQLTIMESTAMPOFFSET * pTimeStampOffset, UINT32 iValLen,
   pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   BOOL bBlank = !bIsNumber(pValue, iValLen);
   if (pbBlank)
      *pbBlank = bBlank;
   if (bBlank)
      return rslt;
   memset(pTimeStampOffset, 0, sizeof(SQLTIMESTAMPOFFSET));
   ReadSQLDate(pValue, pTimeStampOffset);
   if ((pValue + 8)[0] == 'T')
   {
      ReadSQLTime(pValue + 9, pTimeStampOffset);
      if (((pValue + 20)[0] == '+') || ((pValue + 20)[0] == '-'))
         ReadSQLTimeOS(pValue + 21, pTimeStampOffset);
   }
   return rslt;
}

DBIResult DSXML_W::ReadINT64(pCHAR pValue, pINT64 pInt64, UINT32 iValLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   UNREFERENCED_PARAMETER(pValue);
   UNREFERENCED_PARAMETER(pInt64);
   BOOL bBlank = !bIsNumber(pValue, iValLen);
   if (pbBlank)
      *pbBlank = bBlank;
   if (!bBlank)
#if defined(__APPLE__) || defined(__arm__) || defined(__arm64__)
      *(INT64*)pInt64 = strtoll(pValue, NULL, 10);
#else
      *(INT64*)pInt64 = _atoi64(pValue);
#endif
   return rslt;
}

INT16 WEAKATTR LocalDayOfYear(INT16 iMon, INT16 iDay, INT16 iYear)
{
   INT16 iSum, i;
   INT16 iLeapFlag = (INT16)LocalIsLeapx(iYear);

   for (i = 1, iSum = iDay; i < iMon; )
      iSum += iDayTable[iLeapFlag][i++];

   return iSum;
}

DBIDATE DateEncode(UINT16 iMon, UINT16 iDay, INT16 iYear)
{
   INT16 iLastYear = (INT16)(iYear - 1);
   return LocalDayOfYear(iMon, iDay, iYear) + 365L*iLastYear + iLastYear/4 - iLastYear/100 + iLastYear/400;
}

DBIResult TimeStampEncode(DBIDATE Date, TIME Time, pTIMESTAMP ptimeStamp)
{
   *ptimeStamp = (TIMESTAMP)(((TIMESTAMP)Date) * ((TIMESTAMP)MILSECSPERDAY)) + Time;
   return DBIERR_NONE;
}

DBIResult TimeEncode(UINT16 iHour, UINT16 iMin, UINT16 iMilSec, pTIME pTime)
{
   if (iHour > 23 || iMin > 59 || iMilSec > 59999L)
      return SetError(DBIERR_INVALIDTIME);

   *pTime = (iHour * 60 + iMin) * MILSECSPERMIN + iMilSec;
   return(DBIERR_NONE);
}

BOOL bIsNumber(pCHAR pVal, UINT32 iLen)
{
   BOOL bDigit = FALSE;
   CHAR ch;
   while (iLen-- >0)
   {
      ch = *pVal;
      pVal++;
      if (ch>='0' && ch <='9')
         return TRUE;
      if ((ch >='a' && ch <='z') || (ch>='A' && ch<='Z'))
         return FALSE;
   }
   return bDigit;
}

pCHAR DSXML_W::FromSTRING(pBYTE pValue, pUINT32 piLen)
{
   if (!pValue)
      return NULL;
   UINT32 i;
   UINT32 iLen = *piLen;
   UINT32 iNewLen = 0;
   pUINT8 pP = (pUINT8)pValue;
   pCHAR pOut;

   pOut = (pCHAR)GetVarBuf(iLen);
   pP = pValue;

   iNewLen = 0;
   for (i = 0; i < iLen; i++)
   {
      *pOut++ = *pP++;
      iNewLen++;
   }
   *piLen = iNewLen;
   return(pCHAR)pVarBuf;
}

pCHAR DSXML_W::FromUNICODE(pBYTE pValue, pUINT32 piLen)
{
   if (!pValue)
      return NULL;
   UINT32 i;
   UINT32 iLen = *piLen/2; // number of 2-byte characters?or number of bytes?
   UINT32 iNewLen = 0;
   UINT16 iCh;
   pUINT16 pP = (pUINT16)pValue;
   pCHAR pOut;

   for (i = 0; i<iLen; i++)
   {
      iCh = *pP++;
      if (iCh < 0x80)
         iNewLen++;
      else
      // The sizeof one UTF8 character is from 2 to 6 byte. Not 2 byte.
      // iNewLen+= (bUTF8)? 2: 8;
      // Temporary, true UTF8 conversion is disabled. All extended character is used numeric character reference. ( &#28450; )
         iNewLen += 8;
   }
   pOut = (pCHAR)GetVarBuf(iNewLen);
   pP = (pUINT16)pValue;
   iNewLen = 0;
   for (i = 0; i<iLen; i++)
   {
      iCh = *pP++;
      if (iCh < 0x80)
      {
         *pOut++ = (CHAR)iCh;
         iNewLen++;
      }
      else
      {
         // Temporary, true UTF8 conversion is disabled. All extended character is used numeric character reference. ( &#28450; )
#if 0
         if (bUTF8)
         {
            if (iCh < 0x800)
            {
               *pOut++ = (CHAR)(0xC0 | (iCh >> 6));
               iNewLen++;
               *pOut++ = (CHAR)(0x80 | (iCh & 0x3F));
               iNewLen++;
            }
            else
            {
               *pOut++ = (CHAR)(0xE0 | (iCh >> 12));
               iNewLen++;
               *pOut++ = (CHAR)(0x80 | ((iCh >> 6) & 0x3F));
               iNewLen++;
               *pOut++ = (CHAR)(0x80 | (iCh & 0x3F));
               iNewLen++;
            }
         }
         else
#endif
         {
            UINT32 numlen;
            CHAR num[10];
            *pOut++ = '&';
            *pOut++ = 0x01; // special signal to 'replacespecialchars' , so that it will not convert the'&'  '#';
            itoa(iCh, num, 10);
            numlen = strlen(num);
            if (numlen < 3)
            {
               *pOut++ = '0';
               iNewLen++;
               if (numlen<2)
               {
                  *pOut++ = '0';
                  iNewLen++;
               }
            }
            strcpy(pOut, num);
            pOut+=numlen;
            iNewLen+=numlen;
            *pOut++ = ';';
            iNewLen += 3;
         }
      }
   }
   *piLen = iNewLen;
   return(pCHAR)pVarBuf;
}

DBIResult DSXML_W::ReadUniStr(pCHAR pValue, pCHAR pStr, pUINT32 piLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   UINT16 ch16;
   BYTE ch8;
   pUINT16 piOut = (pUINT16)pStr;
   pBYTE piIn = (pBYTE)pValue;
   UINT32 i, j;

   if (pbBlank)
      *pbBlank = FALSE;
   for (i = 0, j = 0; i<*piLen; i++)
   {
      if (pValue[i] == '&')
      { // escape
         switch(pValue[i+1])
         {
         case 'a':
            if (pValue[i+2] == 'p')
            {
               ch16 = (UINT16)39; // ' apostrophe
               i+= 5; // "apos;"
            }
            else
            {
               ch16 = (UINT16)'&';
               i+= 4; // "amp;"
            }
            break;
         case 'q':
            ch16 = '"';
            i+= 5; // "quot;"
            break;
         case 'l':
            ch16 = (UINT16)'<';
            i+=3; // "lt;"
            break;
         case 'g':
            ch16 = (UINT16)'>';
            i+=3; // "gt;"
            break;
         case '#':
            i+=2; // point to number
            if (pValue[i] == 'x')
            {
               UINT32 ic;
               ch16 = 0;
               do
               {
                  ic = pValue[++i];
                  if (ic>='0' && ic<='9')
                     ic = ic-'0';
                  else if (ic>='A' && ic<='F')
                     ic = 10+ic-'A';
                  else if (ic>='a' && ic<='f')
                     ic = 10+ic-'a';
                  else
                     break;
                  ch16 = (ch16<<4) +ic;
               }
               while (TRUE);
            }
            else
            {
               ch16 = (INT16)atoi(&pValue[i]);
            }
            while (pValue[i] != ';')
            {
               i++;
               if (i>=*piLen)
                  break;
            }
            break;
         }
      }
      else
      {
         ch8 = piIn[i];
         if (bUTF8 && (ch8 & 0x80) && (ch8 & 0x40))
         { // Lead byte
            UINT32 ch32;
            if (ch8 & 0x20)
            {
               if (ch8 & 0x10)
               { // 4 bytes
                  ch32 = ((UINT32)(ch8 & 0x07) << 18) | ((UINT32)((piIn[i+1]) & 0x3f) << 12) |
                     ((UINT32)((piIn[i+2]) & 0x3f) << 6) | ((UINT32)((piIn[i+3]) & 0x3f));
                  i += 3;
                  ch16 = (UINT16)ch32;
               }
               else
               { // 3 bytes
                  ch32 = ((UINT32)(ch8 & 0x0f) << 12) | ((UINT32)((piIn[i+1]) & 0x3f) << 6) |
                     ((UINT32)((piIn[i+2]) & 0x3f));
                  i += 2;
                  ch16 = (UINT16)ch32;
               }
            }
            else
            { // 2 bytes
               ch32 = ((UINT32)(ch8 & 0x1f) << 6) | ((UINT32)((piIn[i+1]) & 0x3f));
               i += 1;
               ch16 = (UINT16)ch32;
            }
         }
         else
            ch16 = (UINT16)ch8;
      }

      if (piOut)
         piOut[j] = ch16;
      j++;
   }

   if (piOut)
      piOut[j] = 0; // Zeroterminate
   if (piLen)
      *piLen = (j+1)*sizeof(UINT16); // Includes 0
   return rslt;
}

int MultiByteToUTF8(INT32 AnsiCP, unsigned char * Input, unsigned int InputLen, unsigned char *Output, unsigned int OutputLen)
{
   pUCS2Char wbuf;
   ucs2char_t wc;

   pCHAR pCh = (pCHAR)Input;
   unsigned int i;
   for (i = 0; i < InputLen; i++)
   {
      if ((BYTE)*pCh++ >= 0x80)
         break;
   }
   if (i == InputLen)
   {
      if (Output == NULL)
         return InputLen;
      else
      {
         memcpy(Output, Input, min(InputLen, OutputLen));
         return min(InputLen, OutputLen);
      }
   }

   int wbuflen = (InputLen+1) * 2; // Is it enough?
   int wLen;

#ifdef _UNIX
   wbuf = (pUCS2Char)malloc(wbuflen);
   wLen = CharToWChar(AnsiCP, (pCHAR)Input, InputLen, wbuf, wbuflen);
   if (wLen == (-1)/(int)sizeof(ucs2char_t)) // If CharToWChar fail, (-1)/sizeof(ucs2char_t) will return
      return-1;
#else
   wbuf = (pUCS2Char)malloc(wbuflen);
   wLen = MultiByteToWideChar(AnsiCP, 0, (char*)Input, InputLen, (wchar_t*)wbuf, wbuflen);
   if (wLen == 0)
      return-1;
#endif

   int iNewLen = 0;
   unsigned char *pOut = Output;

   int j;
   for (j = 0; j < wLen; j++) // char
   {
      wc = wbuf[j];

      if (wc < 0x80)
      {
         if (pOut)
         {
            if (OutputLen < 1)
               break;
            *pOut++ = CHAR(0x007F & wc);
         }
         iNewLen++;
      }
      else if (wc < 0x800)
      {
         if (pOut)
         {
            if (OutputLen < 2)
               break;
            *pOut++ = (CHAR)(0xC0 | ((0x0FC0 & wc) >> 6));
            *pOut++ = (CHAR)(0x80 | ((0x003F & wc)));
         }
         iNewLen += 2;
      }
      else /* if ( wc <= 0xFFFF ) */
      {
         if (pOut)
         {
            if (OutputLen < 3)
               break;
            *pOut++ = (CHAR)(0xE0 | ((0xF000 & wc) >>12));
            *pOut++ = (CHAR)(0x80 | ((0x0FC0 & wc) >> 6));
            *pOut++ = (CHAR)(0x80 | ((0x003F & wc)));
         }
         iNewLen += 3;
      }
   }

   free(wbuf);

   return iNewLen;
}

int MultiByteToUTF8WithEscape(INT32 AnsiCP, unsigned char * Input, unsigned int InputLen, unsigned char *Output,
   unsigned int OutputLen)
{
   pUCS2Char wbuf;
   UINT32 wc;

   pCHAR pCh = (pCHAR)Input;

   unsigned int i;
   for (i = 0; i < InputLen; i++)
   {
      BYTE ch = (BYTE)*pCh++;
      if (ch >= 0x80 || ch == '&')
         break;
   }
   if (i == InputLen)
   {
      if (Output == NULL)
         return InputLen;
      else
      {
         memcpy(Output, Input, min(InputLen, OutputLen));
         return min(InputLen, OutputLen);
      }
   }

   int wbuflen = (InputLen+1) * 2; // Is it enough?
   int wLen;

#ifdef _UNIX
   wbuf = (pUCS2Char)malloc(wbuflen);
   wLen = CharToWChar(AnsiCP, (pCHAR)Input, InputLen, wbuf, wbuflen);
   if (wLen == (-1)/(int)sizeof(ucs2char_t)) // If CharToWChar fail, (-1)/sizeof(ucs2char_t) will return
      return-1;
#else
   wbuf = (pUCS2Char)malloc(wbuflen);
   wLen = MultiByteToWideChar(AnsiCP, 0, (pCHAR)Input, InputLen, (wchar_t*)wbuf, wbuflen);
   if (wLen == 0)
      return-1;
#endif

   int iNewLen = 0;
   unsigned char *pOut = Output;

   int j;

   for (j = 0; j < wLen; j++) // char
   {
      wc = (unsigned int)wbuf[j];

      if (wc == '&' && ((j+1) < wLen) && wbuf[j+1] == '#')
      {
         // &#12354; or &#xABCD;
         if ((j+2) < wLen && (wbuf[j+2] == 'x' || wbuf[j+2] == 'X'))
         {
            // &#xABCD; - Hexdecimal format.
         }
         else
         {
            // &#12345; - Assuming Decimal format.
            wc = WideStrToInt(&wbuf[j+2]);
         }
         //
         while (wbuf[j] != ';')
         {
            j++;
            if (j>=wLen)
               break;
         }

         //
      }
      else if (IS_HIGH_SURROGATE(wc) && ((j+1) < wLen) && IS_LOW_SURROGATE(wbuf[j+1]))
      {
         wc = ((wc & 0x03FF) << 10) + (wbuf[j+1] & 0x03FF);
         j++;
      }

      if (wc < 0x80)
      {
         if (pOut)
         {
            if (OutputLen < 1)
               break;
            *pOut++ = CHAR(0x007F & wc);
         }
         iNewLen++;
      }
      else if (wc < 0x800)
      {
         if (pOut)
         {
            if (OutputLen < 2)
               break;
            *pOut++ = (CHAR)(0xC0 | ((0x0FC0 & wc) >> 6));
            *pOut++ = (CHAR)(0x80 | ((0x003F & wc)));
         }
         iNewLen += 2;
      }
      else if (wc < 0x10000)
      {
         if (pOut)
         {
            if (OutputLen < 3)
               break;
            *pOut++ = (CHAR)(0xE0 | ((0xF000 & wc) >>12));
            *pOut++ = (CHAR)(0x80 | ((0x0FC0 & wc) >> 6));
            *pOut++ = (CHAR)(0x80 | ((0x003F & wc)));
         }
         iNewLen += 3;
      }
      else /* surrogate pair */
      {
         if (pOut)
         {
            if (OutputLen < 4)
               break;
            *pOut++ = (CHAR)(0xF0 | ((0x1C0000 & wc) >>18));
            *pOut++ = (CHAR)(0x80 | ((0x03F000 & wc) >>12));
            *pOut++ = (CHAR)(0x80 | ((0x000FC0 & wc) >> 6));
            *pOut++ = (CHAR)(0x80 | ((0x00003F & wc)));
         }
         iNewLen += 4;
      }
   }

   free(wbuf);

   return iNewLen;
}

int UTF8ToMultiByte(INT32 AnsiCP, unsigned char * Input, unsigned int InputLen, unsigned char *Output, unsigned int OutputLen)
{
   // Guess UCS2 size.

   int Result = -1; // default is error.

   int wLen = 0;
   unsigned char ch;
   BOOL cvtFlag = FALSE;

   for (unsigned int i = 0; i < InputLen; )
   {
      ch = Input[i];
      if (ch < 0x80)
         i++;
      else if ((ch >= 0xC2) && (ch <= 0xDF))
         cvtFlag = TRUE, i += 2;
      else if ((ch >= 0xE0) && (ch <= 0xEF))
         cvtFlag = TRUE, i += 3;
      else if ((ch >= 0xF0) && (ch <= 0xF7))
         cvtFlag = TRUE, i += 4, wLen++; // Surrogate pair support.
      else // other case, fill space char.
         cvtFlag = TRUE, i++;
      wLen++;
   }

   if (!cvtFlag) // no need to convert to UTF-8
   {
      if (Output == NULL)
         return InputLen;
      else
      {
         memcpy(Output, Input, min(InputLen, OutputLen));
         return min(InputLen, OutputLen);
      }
   }

   pUCS2Char wBuf = (pUCS2Char)malloc(wLen*sizeof(ucs2char_t));
   if (wBuf == NULL)
      return Result;

   pUCS2Char pTemp = wBuf;
   ucs2char_t wChar;

   for (unsigned int i = 0; i < InputLen; )
   {
      ch = Input[i++];
      if (ch < 0x80)
      {
         wChar = ch;
      }
      else if ((ch >= 0xC2) && (ch <= 0xDF) && (i < InputLen))
      {
         wChar = ((UINT16)(ch & 0x1F) << 6) | ((UINT16)(Input[i] & 0x3F));
         i++;
      }
      else if ((ch >= 0xE0) && (ch <= 0xEF) && (i+1 < InputLen))
      {
         wChar = ((UINT16)(ch & 0x0F) <<12) | ((UINT16)(Input[i] & 0x3F) << 6) | ((UINT16)(Input[i+1] & 0x3F));
         i += 2;
      }
      else if ((ch >= 0xF0) && (ch <= 0xF7) && (i+2 < InputLen))
      {
         wChar = ((UINT16)(ch & 0x07) <<18) | ((UINT16)(Input[i] & 0x3F) <<12)
               | ((UINT16)(Input[i+1] & 0x3F) << 6) | ((UINT16)(Input[i+2] & 0x3F));
         i += 3;
      }
      else
         wChar = 0x20;
      *pTemp++ = wChar;
   }

#ifdef _UNIX
   if (Output == NULL)
   {
      int tempBufSize = wLen*sizeof(ucs2char_t); // UNICODE -> MBCS. 2byte -> 1 or 2. wLen is enough.
      pCHAR tempBuf = (pCHAR)malloc(tempBufSize);
      Result = WCharToChar(wBuf, tempBufSize, AnsiCP, tempBuf, tempBufSize);
      free(tempBuf);
   }
   else
      Result = WCharToChar(wBuf, wLen*sizeof(ucs2char_t), AnsiCP, (pCHAR)Output, OutputLen);
#else
   Result = WideCharToMultiByte(AnsiCP, 0, (LPWSTR)wBuf, wLen, (LPSTR)Output, OutputLen, NULL, NULL);
#endif

   free(wBuf);

   return Result;
}

int UTF8ToAsciiWithEscape(unsigned char * Input, unsigned int InputLen, unsigned char *Output,
   unsigned int OutputLen)
{
   // Guess UCS2 size.

   int Result = -1; // default is error.

   BOOL cvtFlag = FALSE;

   for (unsigned int i = 0; i < InputLen; i++)
   {
      if (Input[i] > 0x80)
      {
         cvtFlag = TRUE;
         break;
      }
   }

   if (!cvtFlag) // All characters are US-ASCII. no need to convert from UTF-8
   {
      if (Output == NULL)
         return InputLen;
      else
      {
         memcpy(Output, Input, min(InputLen, OutputLen));
         return min(InputLen, OutputLen);
      }
   }

   unsigned char ch;
   unsigned int wChar;
   Result = 0;

   for (unsigned int i = 0; i < InputLen; )
   {
      ch = Input[i++];
      if (ch < 0x80)
      {
         wChar = ch;
      }
      else if ((ch >= 0xC2) && (ch <= 0xDF) && (i < InputLen))
      {
         wChar = ((UINT16)(ch & 0x1F) << 6) | ((UINT16)(Input[i] & 0x3F));
         i++;
      }
      else if ((ch >= 0xE0) && (ch <= 0xEF) && (i+1 < InputLen))
      {
         wChar = ((UINT16)(ch & 0x0F) <<12) | ((UINT16)(Input[i] & 0x3F) << 6) | ((UINT16)(Input[i+1] & 0x3F));
         i += 2;
      }
      else if ((ch >= 0xF0) && (ch <= 0xF7) && (i+2 < InputLen))
      {
         wChar = ((UINT16)(ch & 0x07) <<18) | ((UINT16)(Input[i] & 0x3F) <<12) | ((UINT16)(Input[i+1] & 0x3F) << 6) |
            ((UINT16)(Input[i+2] & 0x3F));
         i += 3;
      }
      else
         wChar = 0x20;

      if (wChar < 0x80)
      {
         Result++;
         if (Output)
         {
            *Output++ = wChar;
         }
      }
      else
      { // &<special>#XXXXX;
         UINT32 numlen;
         CHAR num[10];

         Result += 2;
         if (Output)
         {
            *Output++ = '&';
            *Output++ = 0x01; // special signal to 'replacespecialchars' , so that it will not convert the'&'  '#';
         }

         itoa(wChar, num, 10);
         numlen = strlen(num);
         Result += numlen;
         if (Output)
         {
            strcpy((char*)Output, num);
            Output+=numlen;
         }
         Result++;
         if (Output)
            *Output++ = ';';
      }
   }

   return Result;
}

pCHAR WideCharToUTF8(const pUCS2Char Input)
{
   pCHAR rst = NULL;
   if (Input)
   {
#ifdef _UNIX
      int Inputlen = WideStrLen(Input);
      size_t srcsize = (Inputlen+1) * sizeof(ucs2char_t);
      pUCS2Char src = (pUCS2Char) malloc(srcsize);
      pCHAR psrc = (pCHAR)src;
      memcpy(src, Input, (Inputlen+1) * sizeof(ucs2char_t));
#if defined(__ANDROID__)
      UErrorCode status = U_ZERO_ERROR;
      INT32 len = 0;
      pu_strToUTF8(NULL, 0, &len, src, -1, &status);

      //Reset buffer overflow error that may have occurred during pre-flighting
      status = U_ZERO_ERROR;

      if (len !=0)
      {
         rst = (pCHAR) malloc((len+1) * sizeof(CHAR));
         pu_strToUTF8(rst, len+1, NULL, src, -1, &status);
      }
#else
      iconv_t cdesc = iconv_open("UTF-8", "UTF-16LE");
      size_t rstsize = (Inputlen+1) * 4;
      rst = (pCHAR)malloc(rstsize);
      pCHAR prst = rst;
      iconv(cdesc, &psrc, (size_t*)&srcsize, &prst, (size_t*)&rstsize);
      iconv_close(cdesc);
      free(src);
#endif
#else
      int len = 0;
      len = WideCharToMultiByte(CP_UTF8, 0, (wchar_t*)Input, -1, NULL, 0, NULL, NULL);
      if (len != 0)
      {
         rst = (pCHAR) malloc(len);
         WideCharToMultiByte(CP_UTF8, 0, (wchar_t*)Input, -1, rst, len, NULL, NULL);
      }
#endif
   }
   return rst;
}

pUCS2Char UTF8ToWideChar(pCCHAR Input)
{
   pUCS2Char rst = NULL;

   if (Input)
   {
#ifdef _UNIX
      int len = 0;
      size_t srcsize = (strlen(Input)+1) * 4;
      pCHAR src = (pCHAR) malloc(srcsize);
      pCHAR psrc = src;
      strcpy(src, Input);
#if defined(__ANDROID__)
      UErrorCode status = U_ZERO_ERROR;
      INT32 rlen = 0;

      pu_strFromUTF8(NULL, 0, &rlen, src, -1, &status);

      //Reset buffer overflow error that may have occurred during pre-flighting
      status = U_ZERO_ERROR;

      if (rlen != 0)
      {
         rst = (pUCS2Char) malloc((rlen+1) * sizeof(ucs2char_t));
         pu_strFromUTF8(rst, rlen+1, NULL, src, -1, &status);
      }
#else
      iconv_t cdesc = iconv_open("UTF-16LE", "UTF-8");
      size_t rstsize = srcsize / 4 * sizeof(ucs2char_t);
      rst = (pUCS2Char) malloc(rstsize);
      pCHAR prst = (pCHAR)rst;
      iconv(cdesc, &psrc, (size_t*)&srcsize, &prst, (size_t*)&rstsize);
      iconv_close(cdesc);
      free(src);
#endif
#else
      int len = 0;
      len = MultiByteToWideChar(CP_UTF8, 0, Input, -1, NULL, 0);
      if (len != 0)
      {
         rst = (pUCS2Char) malloc(len * sizeof(ucs2char_t));
         MultiByteToWideChar(CP_UTF8, 0, Input, -1, (wchar_t*)rst, len);
      }
#endif
   }
   return rst;
}

char EncodeTable[64] =
// EncodeTable: array[0..63] of Char =
{
   'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
   'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd',
   'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
   't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7',
   '8', '9', '+', '/'
};

unsigned int DecodeTable[128] =
// array[#0..#127] of Integer =
{
   '=', 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
   64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
   64, 64, 64, 64, 64, 62, 64, 64, 64, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60,
   61, 64, 64, 64, 64, 64, 64, 64, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
   13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 64, 64, 64, 64, 64, 64, 26,
   27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46,
   47, 48, 49, 50, 51, 64, 64, 64, 64, 64
};

typedef struct
{
   CHAR List[4];
}TPacket;
// typedef PPacket =*TPacket;

// type
// PPacket = ^TPacket;
// TPacket = packed record
// case Integer of
// 0: (b0, b1, b2, b3: Byte);
// 1: (i: Integer);
// 2: (a: array[0..3] of Byte);
// 3: (c: array[0..3] of Char);
// end;

void EncodePacket(unsigned char * Packet, unsigned int NumChars, unsigned char * OutBuf)
{
   OutBuf[0] = EncodeTable[Packet[0] >> 2];
   OutBuf[1] = EncodeTable[((Packet[0] << 4) | (Packet[1] >> 4)) & 0x0000003f];
   if (NumChars < 2)
      OutBuf[2] = '=';
   else
      OutBuf[2] = EncodeTable[((Packet[1] << 2) | (Packet[2] >> 6)) & 0x0000003f];
   if (NumChars < 3)
      OutBuf[3] = '=';
   else
      OutBuf[3] = EncodeTable[Packet[2] & 0x0000003f];
}

void DecodePacket(unsigned char * InBuf, unsigned int* nChars, unsigned char *OutBuf)
{
   OutBuf[0] = (DecodeTable[InBuf[0]] << 2) | (DecodeTable[InBuf[1]] >> 4);
   *nChars = 1;
   if (InBuf[2] != '=')
   {
      (*nChars)++;
      OutBuf[1] = (DecodeTable[InBuf[1]] << 4) | (DecodeTable[InBuf[2]] >> 2);
   }
   if (InBuf[3] != '=')
   {
      (*nChars)++;
      OutBuf[2] = (DecodeTable[InBuf[2]] << 6) | DecodeTable[InBuf[3]];
   }
}

// Binary encode
int EncodeStream(unsigned char * Input, unsigned int InputLen, unsigned char *Output, unsigned int * OutputLen)
{
   unsigned char InBuf[510]; // InBuf: array[0..509] of Byte;
   unsigned char OutBuf[1024];
   unsigned char *BufPtr, *OutputPtr;
   unsigned int I, J, K, BytesRead, BytesWritten;
   unsigned char Packet[4];

   K = 0;
   OutputPtr = Output;
   BytesRead = (InputLen > sizeof(InBuf)) ? sizeof(InBuf) : InputLen;

   while (BytesRead > 0)
   {
      memmove(InBuf, Input, BytesRead);
      InputLen -= BytesRead;
      Input += BytesRead;
      I = 0;
      BufPtr = OutBuf;
      while (I < BytesRead)
      {
         if (BytesRead - I < 3)
            J = BytesRead - I;
         else
            J = 3;
         *(int*)Packet = 0;
         Packet[0] = InBuf[I];
         if (J > 1)
            Packet[1] = InBuf[I + 1];
         if (J > 2)
            Packet[2] = InBuf[I + 2];
         EncodePacket(Packet, J, BufPtr);
         I += 3;
         BufPtr += 4;
         K += 4;
      };
      BytesWritten = (BufPtr - OutBuf);
      memmove(OutputPtr, OutBuf, BytesWritten);
      OutputPtr += BytesWritten;
      BytesRead = (InputLen > sizeof(InBuf)) ? sizeof(InBuf) : InputLen;
   }
   *OutputLen = OutputPtr - Output;
   return *OutputLen;
};

unsigned char *SkipWhite(unsigned char * Input, unsigned int *InputLen)
{
   unsigned char C;
   unsigned int Len = *InputLen;

   while (Len > 0)
   {
      C = *Input++;
      Len--;
      if ((C >= '0' && C <= '9') ||
          (C >= 'A' && C <= 'Z') ||
          (C >= 'a' && C <= 'z') ||
          (C == '+') ||
          (C == '/') ||
          (C == '='))
      {
         Input--;
         Len++;
         break;
      }
   };
   *InputLen = Len;
   return Input;
}

int DecodeStream(unsigned char *Input, unsigned int InputLen, unsigned char *Output, unsigned int *OutputLen)
{
   unsigned char InBuf[76];
   //OutBuf needs to be at least size 57 in order to fit all the bytes read
   // with 76 maximum characters for input with base64 encoding
   unsigned char OutBuf[100];
   unsigned char *InBufPtr, *OutBufPtr, *OutputPtr = Output;
   unsigned int I, J, K, BytesRead, BytesWritten, TotalBytesWritten = 0;
   unsigned char Packet[4];

   Input = SkipWhite(Input, &InputLen);
   BytesRead = (InputLen > sizeof(InBuf)) ? sizeof(InBuf) : InputLen;
   while (BytesRead > 0)
   {
      memmove(InBuf, Input, BytesRead);
      InputLen -= BytesRead;
      Input += BytesRead;
      InBufPtr = InBuf;
      OutBufPtr = OutBuf;
      I = 0;
      while (I < BytesRead)
      {
         DecodePacket(InBufPtr, &J, Packet);
         K = 0;
         while (J-- > 0)
         {
            *OutBufPtr++ = Packet[K++];
         }
         InBufPtr += 4;
         I += 4;
      };

      BytesWritten = (OutBufPtr - OutBuf);
      if (OutputPtr != NULL)
      {
         memmove(OutputPtr, OutBuf, BytesWritten);
         OutputPtr += BytesWritten;
      }
      TotalBytesWritten += BytesWritten;
      Input = SkipWhite(Input, &InputLen);
      BytesRead = (InputLen > sizeof(InBuf)) ? sizeof(InBuf) : InputLen;
   }
   *OutputLen = TotalBytesWritten;
   return *OutputLen;
}
