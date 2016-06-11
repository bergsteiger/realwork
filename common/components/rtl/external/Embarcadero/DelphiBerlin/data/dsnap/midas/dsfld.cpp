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
#else
#include <windows.h>
#endif
#include <string.h>
#pragma hdrstop

#include "filter.h"
#include "alchemy.h"
#include "alc_ds.h"
#include "ossrv.h"
#include "srvbcd.h"

#ifndef _UNIX
#define min(__a,__b)    (((__a) < (__b)) ? (__a) : (__b))
#endif

INT32 TimeStampCompare(pBYTE pt1, pBYTE pt2);
INT32 TimeStampOffsetCompare(pBYTE pt1, pBYTE pt2);

// returns
DBIResult DBIFN DSBASE::GetField(UINT32 iRecNo, UINT32 iFldNo, pBYTE pFldBuf, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   pBYTE pValue;
   pDSFLDDesc pFldDes;

   LOCK();
   if (iRecNo == 0 || iRecNo > iRecNoNext) // Just check range
   {
      rslt = DBIERR_OUTOFRANGE;
      goto Exit;
   }

   if (iFldNo == FIELD_ATTR) // Get attribute
   {
      if (pFldBuf)
      {
         DSAttr iAttr = piAttr[iRecNo-1];

         CopyMem(pFldBuf, (pBYTE) &iAttr, sizeof(DSAttr));
      }
      goto Exit;
   }

   pFldDes = &pFieldDesc[iFldNo-1]; // 0-based
   if (pFldBuf)
   {
      UINT32 iFldLen;

      iFldLen = pFldDes->iFldLen;
      if (iFldLen)
      { // Otherwise fldADT, fldARRAY
         pValue = ppColumns[iFldNo-1]; // Start of value array for field i+1
         pValue += iFldLen*(iRecNo-1);
         CopyMem(pFldBuf, pValue, iFldLen);
      }
   }

   if (pbBlank)
   {
      BYTE bBlank;

      pValue = pNulls; // Start of value array for field i+1
      pValue += iNullLength*(iRecNo-1);
      if (pFldDes->iFieldIDParent)
      { // Special treatment if part of ADT/ARRAY
      }
      if (iFldNo) // Nesc. ?
         bBlank = pValue[iFldNo - 1]; // None for attr-field!
      else
         bBlank = FALSE;
      *pbBlank = (BOOL)bBlank;
   }

Exit:
   UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::GetField(pBYTE pRecBuf, UINT32 iFldNo, pBYTE pFldBuf, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   // pBYTE       pValue ;
   pDSFLDDesc pFldDes;

   // LOCK();

   if (iFldNo == 0)
      return DBIERR_OUTOFRANGE;

   pFldDes = &pFieldDesc[iFldNo-1]; // 0-based
   if (pFldBuf)
   {
      UINT32 iFldLen;
      iFldLen = pFldDes->iFldLen;
      CopyMem(pFldBuf, pRecBuf + pFldDes->iFldOffsInRec, iFldLen);
   }
   if (pbBlank)
   {
      pBYTE pNullOffset = pRecBuf + iNullOffset;
      BYTE bBlank = pNullOffset[iFldNo-1];
      if (pFldDes->iFieldIDParent)
      { // Special treatment if part of ADT/ARRAY
      }
      *pbBlank = bBlank;
   }
   // UNLOCK();
   return rslt;
}

// returns
DBIResult DBIFN DSBASE::PutField(UINT32 iRecNo, UINT32 iFldNo, pBYTE pFldBuf)
{
   DBIResult rslt = DBIERR_NONE;
   pDSFLDDesc pFldDes;
   UINT32 iFldLen;
   pBYTE pValue;
   pBYTE pNullOffset;
   BYTE bBlank;

   LOCK();
   if (iRecNo == 0 || iRecNo > iRecNoNext) // Just check range
   {
      rslt = DBIERR_OUTOFRANGE;
      goto Exit;
   }

   if (iFldNo == FIELD_ATTR) // Put attribute
   {
      if (pFldBuf)
         CopyMem((pBYTE) &piAttr[iRecNo-1], pFldBuf, sizeof(DSAttr));
      goto Exit;
   }
   pFldDes = &pFieldDesc[iFldNo -1]; // 0-based
   iFldLen = pFldDes->iFldLen;
   if (iFldLen) // Otherwise fldADT, fldARRAY
   {
      pValue = ppColumns[iFldNo-1]; // Start of value array for field i+1
      pValue += iFldLen*(iRecNo-1);
      if (pFldBuf)
      {
         if (pFldDes->iFldType == fldBCD || pFldDes->iFldType == fldFMTBCD)
         {
            rslt = FldMoveNormalizeBCD((pFMTBcd)pFldBuf, (pFMTBcd)pValue, pFldDes->iUnits1, pFldDes->iUnits2);
            if (rslt)
               goto Exit;
         }
         else
            CopyMem(pValue, pFldBuf, iFldLen);
         bBlank = FALSE;
      }
      else
      {
         ZeroMem(pValue, iFldLen);
         bBlank = BLANK_NULL;
      }
   }
   else
   {
      bBlank = (BYTE)(pFldBuf ? FALSE : BLANK_NULL);
   }
   pNullOffset = pNulls;
   pNullOffset += iNullLength*(iRecNo-1); // Point to records null values

   if (pFldDes->iFieldIDParent && !bBlank) // If a non-null value was assigned
   { // Special treatment if part of ADT/ARRAY
      // Semantics could either be to disallow changes if a parent is atomic null, OR
      // to set all parent's nullbyte to FALSE.
      UINT32 iFldIDParent = pFldDes->iFieldIDParent;
      while (iFldIDParent)
      {
         pDSFLDDesc pFldD = &pFieldDesc[iFldIDParent-1];
         if (pNullOffset[iFldIDParent-1] == BLANK_NULL) // If null
         {
            // Depending on null-semantics
            pNullOffset[iFldIDParent-1] = FALSE;
         }
         iFldIDParent = pFldD->iFieldIDParent;
      }
   }

   pNullOffset[iFldNo-1] = bBlank;

   if (iFldLen == 0 && bBlank) // fldADT,fldARRAY
   { // Should we zero all blank values in nested fields?
      UINT32 j;
      for (j = 0; j < pFldDes->iUnits2; j++) //
      {
         pNullOffset[iFldNo +j] = bBlank;
      }
   }

Exit:
   UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::PutField(pBYTE pRecBuf, UINT32 iFldNo, pBYTE pFldBuf)
{
   DBIResult rslt = DBIERR_NONE;
   pDSFLDDesc pFldDes;
   UINT32 iFldLen;
   pBYTE pNullOffset = pRecBuf + iNullOffset;
   BOOL bBlank;

   // LOCK();
   if (iFldNo == 0)
      return DBIERR_OUTOFRANGE;

   pFldDes = &pFieldDesc[iFldNo-1]; // 0-based
   iFldLen = pFldDes->iFldLen;
   if (iFldLen)
   {
      if (pFldBuf)
      {
         if (pFldDes->iFldType == fldBCD || pFldDes->iFldType == fldFMTBCD)
         {
            rslt = FldMoveNormalizeBCD((pFMTBcd)pFldBuf, (pFMTBcd)(pRecBuf + pFldDes->iFldOffsInRec), pFldDes->iUnits1,
               pFldDes->iUnits2);
            if (rslt)
               return rslt;
         }
         else
            CopyMem(pRecBuf + pFldDes->iFldOffsInRec, pFldBuf, iFldLen);
         bBlank = FALSE;
      }
      else
      {
         ZeroMem(pRecBuf + pFldDes->iFldOffsInRec, iFldLen); // Clear value
         bBlank = BLANK_NULL;
      }
   }
   else
   {
      bBlank = pFldBuf ? FALSE : BLANK_NULL;
   }

   if (pFldDes->iFieldIDParent && !bBlank)
   { // Special treatment if part of ADT/ARRAY
      // Semantics could either be to disallow changes if a parent is atomic null, OR
      // to set all parent's nullbyte to FALSE.
      UINT32 iFldIDParent = pFldDes->iFieldIDParent;
      while (iFldIDParent)
      {
         pDSFLDDesc pFldD = &pFieldDesc[iFldIDParent-1];
         if (pNullOffset[iFldIDParent-1] == BLANK_NULL) // If null
         {
            // Depending on null-semantics
            pNullOffset[iFldIDParent-1] = FALSE;
         }
         iFldIDParent = pFldD->iFieldIDParent;
      }
   }

   pNullOffset[iFldNo-1] = (BYTE)bBlank;

   if (iFldLen == 0 && bBlank) // fldADT,fldARRAY
   { // Should we zero all blank values in nested fields?
      UINT32 j;
      for (j = 0; j < pFldDes->iUnits2; j++) //
      {
         pNullOffset[iFldNo +j] = (BYTE)bBlank;
      }
   }
   // UNLOCK();
   return rslt;
}

// returns
DBIResult DBIFN DSBASE::PutBlank(pBYTE pRecBuf, UINT32 iRecNo, UINT32 iFldNo, UINT32 iBlankValue)
{
   DBIResult rslt = DBIERR_NONE;
   pDSFLDDesc pFldDes;
   UINT32 iFldLen;
   pBYTE pNullOffset;

   // Check iFldNo
   LOCK();

   pFldDes = &pFieldDesc[iFldNo -1]; // 0-based
   iFldLen = pFldDes->iFldLen;
   if (pRecBuf)
   {
      pNullOffset = pRecBuf + iNullOffset;
   }
   else
   {
      if (iRecNo == 0 || iRecNo > iRecNoNext) // Just check range
      {
         rslt = DBIERR_OUTOFRANGE;
         goto Exit;
      }
      pNullOffset = pNulls;
      pNullOffset += iNullLength*(iRecNo-1);
   }

   pNullOffset[iFldNo-1] = (BYTE)iBlankValue;

   if (iFldLen == 0 && iBlankValue == BLANK_NULL) // fldADT,fldARRAY
   { // Should we zero all blank values in nested fields?
      UINT32 j;
      for (j = 0; j < pFldDes->iUnits2; j++) //
      {
         pNullOffset[iFldNo +j] = (BYTE)iBlankValue;
      }
   }

Exit:
   UNLOCK();
   return rslt;
}

// ONLY checks wether the fields are EQUAL !
INT DBIFN DSBASE::FldCmp(UINT32 iFldType, pBYTE pFld1, pBYTE pFld2, UINT32 iUnits1, UINT32 iUnits2)
{
   INT32 iCmp;

   UNREFERENCED_PARAMETER(iUnits1);
   UNREFERENCED_PARAMETER(iUnits2);
   // LOCK();

   if (pFld1 == NULL || pFld2 == NULL)
   {
      if (pFld1 == pFld2)
         iCmp = 0; // null semantics
      else
         iCmp = (pFld1 == NULL) ? -1 : 1;
   }
   else
   {
      switch(iFldType)
      {
      case fldINT8:
         iCmp = (INT32)(*(pINT8)pFld1 - *(pINT8)pFld2);
         break;

      case fldBOOL8:
      case fldUINT8:
         iCmp = (INT32)(*(pUINT8)pFld1 - *(pUINT8)pFld2);
         break;

      case fldZSTRING:
         {
            // only compare as many characters as there are in the string.
            UINT32 iLen1 = strlen((char*)pFld1);
            UINT32 iLen2 = strlen((char*)pFld2);
            if (iLen1 != iLen2)
               iCmp = iLen1 < iLen2 ? -1 : 1;
            else
               iCmp = memcmp(pFld1, pFld2, iLen1);
         }
         break;
      case fldINT16:
         iCmp = (INT32)(*(pINT16)pFld1 - *(pINT16)pFld2);
         break;

      case fldBOOL16:
      case fldUINT16:
         iCmp = (INT32)(*(pUINT16)pFld1 - *(pUINT16)pFld2);
         break;

      case fldBOOL32:
      case fldUINT32:
      case fldDATE:
      case fldTIME:
         iCmp = (INT32)(*(pUINT32)pFld1 - *(pUINT32)pFld2);
         break;

      case fldINT32:
         iCmp = (INT32)(*(pINT32)pFld1 - *(pINT32)pFld2);
         break;
      case fldDATETIME:
         iCmp = TimeStampCompare(pFld1, pFld2);
         break;

      case fldDATETIMEOFFSET:
         iCmp = TimeStampOffsetCompare(pFld1, pFld2);
         break;

      case fldTIMESTAMP:
      case fldFLOAT:
         iCmp = (PtrToDFloat(pFld1) == PtrToDFloat(pFld2)) ? 0 : 1;
         break;

      case fldSINGLE:
         iCmp = (*(pSINGLE)pFld1 == *(pSINGLE)pFld2) ? 0 : 1;
         break;

      case fldFMTBCD:
      case fldBCD:
         {
            UINT32 iLen = iUnits1/2 + 2; // Compute length
            if (iUnits1 & 1)
               iLen++;
            iCmp = ByteComp(pFld1, pFld2, iLen); // (just check if equal or not)
         }break;
      case fldUINT64:
      case fldINT64:
         iCmp = ByteComp(pFld1, pFld2, 8); // (just check if equal or not)
         break;
      case fldBYTES:
         iCmp = ByteComp(pFld1, pFld2, iUnits1); // (just check if equal or not)
         break;
      case fldVARBYTES:
         // Should compare using length-prefix
         iCmp = ByteComp(pFld1, pFld2, iUnits1+sizeof(UINT16)); // Added 2 to account for legth prefix
         break;
      case fldFLOATIEEE:
         iCmp = ByteComp(pFld1, pFld2, iUnits1); // (just check if equal or not)
         break;
      case fldUNICODE:
         {
            // only compare as many characters as there are in the string.
            UINT32 iLen1 = *(UINT16*)pFld1;
            UINT32 iLen2 = *(UINT16*)pFld2;
            if (iLen1 != iLen2)
               iCmp = iLen1<iLen2 ? -1 : 1;
            else
               iCmp = memcmp(&pFld1[sizeof(UINT16)], &pFld2[sizeof(UINT16)], iLen1);
         }
         break;
      default:
         iCmp = ByteComp(pFld1, pFld2, iUnits1);
         break;
      }
   }
   // UNLOCK();
   return iCmp;
}

DBIResult DBIFN DSBASE::GetBlobLen( // Return length of blob
   pBYTE pRecBuf, UINT32 iFieldNo, pUINT32 piLength)
{
   DBIResult rslt;
   UINT32 iBlobLen;
   UINT32 iBlobId;
   BOOL bBlank;

   LOCK();
   rslt = GetField(pRecBuf, iFieldNo, (pBYTE) &iBlobId, &bBlank);
   if (bBlank || iBlobId == 0)
      iBlobLen = 0;
   else
   {
      rslt = pDsBlobs->GetBlobLen(iBlobId, &iBlobLen);
   }
   if (piLength)
      *piLength = iBlobLen;
   UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::GetBlob( // Return blob
   pBYTE pRecBuf, UINT32 iFieldNo, UINT32 iOffset, pBYTE pBuf, pUINT32 piLength)
{
   DBIResult rslt;
   UINT32 iBlobId;
   BOOL bBlank;

   LOCK();
   rslt = GetField(pRecBuf, iFieldNo, (pBYTE) &iBlobId, &bBlank);
   if (rslt)
      goto Exit;
   if (bBlank || iBlobId == 0)
   {
      rslt = DBIERR_FIELDISBLANK;
      goto Exit;
   }
   else
   {
      rslt = this->pDsBlobs->GetBlob(iBlobId, iOffset, pBuf, piLength);
   }
Exit:
   UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::PutBlob( //
   pBYTE pRecBuf, UINT32 iFieldNo, UINT32 iOffset, pBYTE pBuf, UINT32 iLength)
{
   DBIResult rslt;
   UINT32 iBlobId;

   LOCK();
   if (iLength && pBuf) // (otherwise a truncate)
   {
      if (iOffset == 0) // This is first allocation
      {
         rslt = this->pDsBlobs->AddBlob(pBuf, iLength, &iBlobId); // Add blob
      }
      else // Adjust an existing one!
      {
         BOOL bBlank;

         rslt = GetField(pRecBuf, iFieldNo, (pBYTE) &iBlobId, &bBlank);
         if (rslt)
            goto Exit;
         if (bBlank || iBlobId == 0)
         {
            rslt = DBIERR_INVALIDPARAM;
            goto Exit;
         }
         rslt = this->pDsBlobs->UpdBlob(pBuf, iOffset, iLength, iBlobId);
         goto Exit; // (no need to put)
      }
   }
   else
   {
      rslt = DBIERR_NONE; // Should get rid of corresponding blob ?
      iBlobId = 0;
   }
   if (rslt == DBIERR_NONE)
   {
      rslt = PutField(pRecBuf, iFieldNo, (pBYTE) &iBlobId);
   }
Exit:
   UNLOCK();
   return rslt;
}

// Field-objects

FLDObj::FLDObj()
{
   iLen = 0;
   iFldType = 0;
   bDescending = FALSE;
}

FLDObj::FLDObj(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

FLDObj::~FLDObj()
{
}

// Uses byte compare
INT32 FLDObj::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      iCmp = ByteComp(pVal1, pVal2, iLen);
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

// Move to pVal1
DBIResult FLDObj::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   CopyMem(pVal1, pVal2, iLen);
   return DBIERR_NONE;
}

FLDInt8::FLDInt8()
{
}

FLDInt8::FLDInt8(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 FLDInt8::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      if (*(pINT8)pVal1 > *(pINT8)pVal2)
         iCmp = 1;
      else if (*(pINT8)pVal1 == *(pINT8)pVal2)
         iCmp = 0;
      else
         iCmp = -1;
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

// Move to pVal1
DBIResult FLDInt8::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   *(pINT8)pVal1 = *(pINT8)pVal2;
   return DBIERR_NONE;
}

FLDInt16::FLDInt16()
{
}

FLDInt16::FLDInt16(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 FLDInt16::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      if (*(pINT16)pVal1 > *(pINT16)pVal2)
         iCmp = 1;
      else if (*(pINT16)pVal1 == *(pINT16)pVal2)
         iCmp = 0;
      else
         iCmp = -1;
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

// Move to pVal1
DBIResult FLDInt16::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   *(pINT16)pVal1 = *(pINT16)pVal2;
   return DBIERR_NONE;
}

FLDInt32::FLDInt32()
{
}

FLDInt32::FLDInt32(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 FLDInt32::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      if (*(pINT32)pVal1 > *(pINT32)pVal2)
         iCmp = 1;
      else if (*(pINT32)pVal1 == *(pINT32)pVal2)
         iCmp = 0;
      else
         iCmp = -1;
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

// Move to pVal1
DBIResult FLDInt32::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   *(pINT32)pVal1 = *(pINT32)pVal2;
   return DBIERR_NONE;
}

FLDInt64::FLDInt64()
{
}

FLDInt64::FLDInt64(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 FLDInt64::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      if (*(INT64*)pVal1 > *(INT64*)pVal2)
         iCmp = 1;
      else if (*(INT64*)pVal1 == *(INT64*)pVal2)
         iCmp = 0;
      else
         iCmp = -1;

   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

// Move to pVal1
DBIResult FLDInt64::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   *(pINT32)pVal1 = *(pINT32)pVal2;
   *(((pINT32)pVal1) +1) = *(((pINT32)pVal2) + 1);
   return DBIERR_NONE;
}

FLDString::FLDString(pDSFLDDesc pFldDes, BOOL bDescending, UINT32 iLC)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
   bCaseInsensitive = FALSE;
   iLCID = iLC;
}

INT32 FLDString::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      if (bCaseInsensitive)
         iCmp = LCStrCmpi(iLCID, (pCHAR)pVal1, (pCHAR)pVal2);
      else
         iCmp = LCStrCmp(iLCID, (pCHAR)pVal1, (pCHAR)pVal2);
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

// Move to pVal1
// How about blank-trimming!
DBIResult FLDString::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   LdStrCpy(pVal1, pVal2);
   return DBIERR_NONE;
}

FLDBcd::FLDBcd(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
   this->iUnits1 = pFldDes->iUnits1;
   this->iUnits2 = pFldDes->iUnits2;
}

#if defined(_UNIX) || defined(MIDAS_OBJ) || defined(_MSC_VER) || defined(__GNUC__) || defined(__clang__)

static UINT16 GetStringFromFractions(char* to, BYTE *from, INT16 count, INT16 iPlaces)
{
   // From to nibbles to bytes, both left aligned
   int i, iStart = 0, iToPos = 0;

   TwoNibbles * pTwoNibbles;
   for (i = iStart; i < count/2; i++)
   {
      pTwoNibbles = (TwoNibbles*)from; // cast each byte as pointer to 2 Nibbles
      // convert both to char value for digit (0-9 +48)
      to[iToPos] = (CHAR)(pTwoNibbles->value1+48);
      to[iToPos + 1] = (CHAR)(pTwoNibbles->value2+48);
      from++;
      iToPos += 2;
   }
   // if there are odd # of digits, get the last one
   if ((count % 2) == 1)
   {
      pTwoNibbles = (TwoNibbles*)from;
      to[iToPos] = (CHAR)(pTwoNibbles->value1+48);
      iToPos++;
   }
   // zero terminate string
   if (count < 64) // only 64 bytes allocated.
      to[iToPos] = (CHAR)0;

   return count - iPlaces;
}
#endif

INT32 FLDBcd::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;
   BOOL bPos;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
#if defined(_UNIX) || defined(MIDAS_OBJ) || defined(_MSC_VER) || defined(__GNUC__) || defined(__clang__)
   {
      FMTBcd * pBcd1 = (FMTBcd*)pVal1;
      FMTBcd * pBcd2 = (FMTBcd*)pVal2;
      if (memcmp(pBcd1, pBcd2, sizeof(FMTBcd)) == 0)
         iCmp = 0;
      else
      {
         // assumes normalized bcd values
         BOOL16 bNeg1 = (pBcd1->iSignSpecialPlaces & 0x80) != 0;
         BOOL16 bNeg2 = (pBcd2->iSignSpecialPlaces & 0x80) != 0;
         if (bNeg1 != bNeg2)
            iCmp = bNeg1 ? -1 : 1;
         else
         {
            char str1[64];
            char str2[64];
            INT16 iNumLen1, iNumLen2;
            iNumLen1 = GetStringFromFractions(str1, pBcd1->iFraction, pBcd1->iPrecision,
               pBcd1->iSignSpecialPlaces & 0x3F);
            iNumLen2 = GetStringFromFractions(str2, pBcd2->iFraction, pBcd2->iPrecision,
               pBcd2->iSignSpecialPlaces & 0x3F);
            if (iNumLen1 == iNumLen2)
               iCmp = strcmp(str1, str2);
            else
               iCmp = iNumLen1 > iNumLen2 ? 1 : -1;
            if ((bNeg1 || bNeg2) && iCmp)
               iCmp = -iCmp;
         }
      }
   }
#else
   {
      asm  push  ebx
      asm  push  esi
      asm  mov   esi, pVal1
      asm  mov   ax, word ptr [esi]
      asm  mov   esi, pVal2
      asm  mov   bx, word ptr [esi]
      asm  cmp ax, bx
      asm  pop   esi
      asm  pop   ebx
      asm  je    SameSign
      asm  jc   LessBcd
      asm  mov  iCmp, -1
      asm  jmp short DoneBcd
    LessBcd :
      asm  mov  iCmp, 1
      asm  jmp short DoneBcd
    SameSign:
      asm  test  ah, 10000000b  ; //Sign bit set ?
      asm  jz   PosBcd
      asm  mov  bPos, 0         ; //Negative bcd's
      asm  jmp short ByteComp
    PosBcd:                     ; //Positive bcd's
      asm  mov  bPos, 1
    ByteComp:
      iCmp = ByteComp(pVal1+2, pVal2 +2, iLen-2);
      if (bPos == FALSE)
         iCmp = -iCmp;
   DoneBcd: ;
   }
#endif
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

// Move to pVal1
// Should test for valid bcd number ?
DBIResult FLDBcd::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   CopyMem(pVal1, pVal2, iLen);
   return DBIERR_NONE;
}

FLDTimeStamp::FLDTimeStamp(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

FLDTimeStampOffset::FLDTimeStampOffset(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 TimeStampCompare(pBYTE pt1, pBYTE pt2)
{
   UINT32 iCmp = 0;
   iCmp = 0; // first 6 members are UINT16 (2 bytes)
   for (int i = 0; i < 12 && iCmp == 0; i+=2)
      iCmp = *((UINT16*)(pt1+i)) - *((UINT16*)(pt2+i));
   if (!iCmp) // last member is UINT32 (4 bytes)
      iCmp = *((UINT32*)(pt1+12)) - *((UINT32*)(pt2+12));
   return iCmp;
}

INT32 TimeStampOffsetCompare(pBYTE pt1, pBYTE pt2)
{
   UINT32 iCmp = 0;
   iCmp = 0; // first 6 members are UINT16 (2 bytes)
   for (int i = 0; i < 12 && iCmp == 0; i+=2)
      iCmp = *((UINT16*)(pt1+i)) - *((UINT16*)(pt2+i));
   if (!iCmp) // last member is UINT32 (4 bytes)
      iCmp = *((UINT32*)(pt1+12)) - *((UINT32*)(pt2+12));
   if (!iCmp)
      for (int i = 16; i < 20 && iCmp == 0; i+=2)
         iCmp = *((UINT16*)(pt1+i)) - *((UINT16*)(pt2+i));
   return iCmp;
}

INT32 FLDTimeStamp::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;
   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0;
      else
         iCmp = pVal1 == NULL ? -1 : 1;
   }
   else
      iCmp = TimeStampCompare(pVal1, pVal2);
   if (bDescending)
      iCmp *= -1;
   return(iCmp > 0) ? 1 : (iCmp < 0 ? -1 : 0);
}

INT32 FLDTimeStampOffset::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;
   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0;
      else
         iCmp = pVal1 == NULL ? -1 : 1;
   }
   else
      iCmp = TimeStampOffsetCompare(pVal1, pVal2);
   if (bDescending)
      iCmp *= -1;
   return(iCmp > 0) ? 1 : (iCmp < 0 ? -1 : 0);
}

DBIResult FLDTimeStamp::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   *((CTIMESTAMP*)pVal1) = *((CTIMESTAMP*)pVal2);
   return DBIERR_NONE;
}

DBIResult FLDTimeStampOffset::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   *((CTIMESTAMPOFFSET*)pVal1) = *((CTIMESTAMPOFFSET*)pVal2);
   return DBIERR_NONE;
}

FLDSingle::FLDSingle(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 FLDSingle::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      if (*(pSINGLE)pVal1 > *(pSINGLE)pVal2)
         iCmp = 1;
      else if (*(pSINGLE)pVal1 == *(pSINGLE)pVal2)
         iCmp = 0;
      else
         iCmp = -1;
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

// Move to pVal1
DBIResult FLDSingle::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   *(pSINGLE)pVal1 = *(pSINGLE)pVal2;
   return DBIERR_NONE;
}

FLDFloat::FLDFloat(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 FLDFloat::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      if (*(pDFLOAT)pVal1 > *(pDFLOAT)pVal2)
         iCmp = 1;
      else if (*(pDFLOAT)pVal1 == *(pDFLOAT)pVal2)
         iCmp = 0;
      else
         iCmp = -1;

   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

// Move to pVal1
DBIResult FLDFloat::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   *(pDFLOAT)pVal1 = PtrToDFloat(pVal2);
   return DBIERR_NONE;
}

FLDUInt8::FLDUInt8(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

// UINT's
INT32 FLDUInt8::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   { // Works for uint, not int
      if (*(pUINT8)pVal1 > *(pUINT8)pVal2)
         iCmp = 1;
      else if (*(pUINT8)pVal1 == *(pUINT8)pVal2)
         iCmp = 0;
      else
         iCmp = -1;
      // iCmp = (INT32) (*(pUINT8) pVal1 - *(pUINT8) pVal2);
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

FLDUInt16::FLDUInt16(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 FLDUInt16::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      if (*(pUINT16)pVal1 > *(pUINT16)pVal2)
         iCmp = 1;
      else if (*(pUINT16)pVal1 == *(pUINT16)pVal2)
         iCmp = 0;
      else
         iCmp = -1;
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

FLDUInt32::FLDUInt32(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 FLDUInt32::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      if (*(pUINT32)pVal1 > *(pUINT32)pVal2)
         iCmp = 1;
      else if (*(pUINT32)pVal1 == *(pUINT32)pVal2)
         iCmp = 0;
      else
         iCmp = -1;
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

FLDUInt64::FLDUInt64(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 FLDUInt64::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      pVal1 += sizeof(UINT32); // GEt upper part
      pVal2 += sizeof(UINT32);

      if (*(pUINT32)pVal1 > *(pUINT32)pVal2)
         iCmp = 1;
      else if (*(pUINT32)pVal1 == *(pUINT32)pVal2)
      {
         pVal1 -= sizeof(UINT32);
         pVal2 -= sizeof(UINT32);
         if (*(pUINT32)pVal1 > *(pUINT32)pVal2)
            iCmp = 1;
         else if (*(pUINT32)pVal1 == *(pUINT32)pVal2)
            iCmp = 0;
         else
            iCmp = -1;
      }
      else
         iCmp = -1;
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

FLDUniCode::FLDUniCode(pDSFLDDesc pFldDes, BOOL bDescending, UINT32 iLC)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
   bCaseInsensitive = FALSE;
   iLCID = iLC;
}

INT32 FLDUniCode::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      iCmp = CompareStringW(iLCID,
                bCaseInsensitive ? NORM_IGNORECASE : 0,
                (pCUCS2Char) &pVal1[sizeof(UINT16)],
                (int)(*(UINT16*)pVal1) / 2,
                (pCUCS2Char) &pVal2[sizeof(UINT16)],
                (int)(*(UINT16*)pVal2)/2 ) -2;
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

// Move to pVal1
// How about blank-trimming!
DBIResult FLDUniCode::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   UINT32 iLen = *(pUINT16)pVal2+sizeof(UINT16);
   CopyMem(pVal1, pVal2, iLen);
   return DBIERR_NONE;
}

FLDVarBytes::FLDVarBytes(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 FLDVarBytes::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      UINT32 iLen1 = *(pUINT16)pVal1;
      UINT32 iLen2 = *(pUINT16)pVal2;
      UINT32 iMinLen = iLen1 < iLen2 ? iLen1 : iLen2;

      if (iMinLen)
      {
         pVal1 += sizeof(UINT16);
         pVal2 += sizeof(UINT16);
         iCmp = ByteComp(pVal1, pVal2, iMinLen);
      }
      else
         iCmp = 0;
      if (iCmp == 0)
      {
         if (iLen1 > iLen2)
            iCmp = 1;
         else if (iLen1 == iLen2)
            iCmp = 0;
         else
            iCmp = -1;
      }
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

// Move to pVal1
DBIResult FLDVarBytes::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   UINT32 iLen = *(pUINT16)pVal2+sizeof(UINT16);
   CopyMem(pVal1, pVal2, iLen);
   return DBIERR_NONE;
}

FLDBlob::FLDBlob(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 FLDBlob::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      iCmp = 0;
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

// Move to pVal1
DBIResult FLDBlob::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   *(pUINT32)pVal1 = *(pUINT32)pVal2; // Move only blobID for now
   return DBIERR_NONE;
}

// Moves BCD in pBcd1 to pBcd2, normalizing it if nescessary
DBIResult DBIFN FldMoveNormalizeBCD(pFMTBcd pBcd1, pFMTBcd pBcd2, UINT32 iPrecision, UINT32 iScale)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iDecimals = pBcd1->iSignSpecialPlaces & 63;
   UINT32 jmax;

   // jmax : Number of bytes for fractional part
   jmax = iPrecision >> 1; // Divide by 2
   if (iPrecision & 1) // Odd?
      jmax++;

   // clear out output fractions
   ZeroMem(pCHAR(pBcd2) + 2, jmax);

   if (iPrecision == (UINT32)pBcd1->iPrecision && iScale == iDecimals)
   { // Normalized, just copy it over
      CopyMem((pBYTE)pBcd2, (pBYTE)pBcd1, 2 + jmax);
   }
   else
   {
      UINT32 iIntPart = pBcd1->iPrecision - iDecimals;
      UINT32 i, j, iStart;
      BYTE Tmp;

      BYTE BigBcd[64 + 1];
      ZeroMem(BigBcd, sizeof(BigBcd));
      // Expand bcd
      for (i = 64 - iDecimals - iIntPart, j = 0; i < 64; i++)
      {
         Tmp = pBcd1->iFraction[j];
         BigBcd[i+1] = Tmp & 0x0f;
         BigBcd[i] = Tmp >> 4;
         i++;
         j++;
      }
      // Move to pBcd2

      iStart = 64 - (iPrecision - iScale + iDecimals); // NOTE:iPrecision of pBcd2, iDecimals of pBcd1!
      i = iStart;
      while (i > 0)
      {
         if (BigBcd[i - 1] > 0) // (if iStart -1 contains anything, it is lost!)
            return DBIERR_OUTOFRANGE;

         i--;
      }
      for (i = iStart, j = 0; i < 64; i++)
      {
         Tmp = (BigBcd[i] << 4) | BigBcd[i+1];
         if (j < jmax)
            pBcd2->iFraction[j] = Tmp;
         else
         {
            if (Tmp)
            { // We are truncating! Report error ?
            }
         }
         i++;
         j++;
      }
      // Fix up header
      pBcd2->iPrecision = iPrecision;
      pBcd2->iSignSpecialPlaces = iScale | (pBcd1->iSignSpecialPlaces&~63);
   }
   return rslt;
}

// FLDExtended:
FLDExtended::FLDExtended(pDSFLDDesc pFldDes, BOOL bDescending, pfFLDComp pfComp, ULONGP iClientData)
{
   this->pfComp = pfComp;
   this->iClientData = iClientData;
   iLen = pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 FLDExtended::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      if (pfComp)
         iCmp = pfComp(iClientData, pVal1, pVal2);
      else
         iCmp = 0;
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

// Move to pVal1
DBIResult FLDExtended::FldMove(pBYTE pVal1, pBYTE pVal2)
{
   CopyMem(pVal1, pVal2, iLen);
   return DBIERR_NONE;
}

FLDComposite::FLDComposite(pDSFLDDesc pFldDes, BOOL bDescending)
{
   iLen = 0; // pFldDes->iFldLen;
   iFldType = pFldDes->iFldType;
   this->bDescending = bDescending;
}

INT32 FLDComposite::FldComp(pBYTE pVal1, pBYTE pVal2)
{
   INT32 iCmp;

   if (pVal1 == NULL || pVal2 == NULL)
   {
      if (pVal1 == pVal2)
         iCmp = 0; // null semantics
      else
         iCmp = (pVal1 == NULL) ? -1 : 1;
   }
   else
   {
      iCmp = 0;
   }
   if (bDescending == FALSE)
      return iCmp;
   return-iCmp; // Descending
}

DBIResult FLDComposite::FldMove(pBYTE pVal1, pBYTE pVal2)
{ // No data to move
   UNREFERENCED_PARAMETER(pVal1);
   UNREFERENCED_PARAMETER(pVal2);
   return DBIERR_NONE;
}

DBIResult DBIFN DSBASE::RegisterFieldCompare( // Register a field compare function for an extended type
   UINT32 iFieldNo, // Field id
   ULONGP iClientData, // Clientdata returned in compare function
   pfFLDComp pfComp)
{
   // pDSFLDDesc pFldDes;
   UNREFERENCED_PARAMETER(iClientData);
   UNREFERENCED_PARAMETER(pfComp);
   UNREFERENCED_PARAMETER(iFieldNo);
   return DBIERR_NOTSUPPORTED;
}

// Faster way to get to a field value, as opposed to copying the field
// Trusted client only!
DBIResult DBIFN DSBASE::GetFieldPtr(UINT32 iRecNo, UINT32 iFldNo, pBYTE *ppFldPtr, // If Blank, returns NULL
   pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   pBYTE pValue;
   pDSFLDDesc pFldDes;

   // (LOCK must be done at higher level)

   if (iFldNo == FIELD_ATTR) // Get attribute
   {
      // if (ppFldPtr)
      if (ppFldPtr)
         *ppFldPtr = (pBYTE) &piAttr[iRecNo-1];
      if (pbBlank)
         *pbBlank = FALSE;
      return rslt;
   }

   pFldDes = &pFieldDesc[iFldNo-1]; // 0-based
   if (ppFldPtr)
   {
      UINT32 iFldLen;

      iFldLen = pFldDes->iFldLen;
      pValue = ppColumns[iFldNo-1]; // Start of value array for field i+1
      pValue += iFldLen*(iRecNo-1);
      *ppFldPtr = pValue;
   }

   if (pbBlank)
   {
      BYTE bBlank;

      pValue = pNulls; // Start of value array for field i+1
      pValue += iNullLength*(iRecNo-1);
      if (pFldDes->iFieldIDParent)
      { // Special treatment if part of ADT/ARRAY
      }
      if (iFldNo) // Nesc. ?
         bBlank = pValue[iFldNo - 1]; // None for attr-field!
      else
         bBlank = FALSE;
      *pbBlank = (BOOL)bBlank;
      if (bBlank /* == TRUE */ && ppFldPtr)
         *ppFldPtr = NULL;
   }

   return rslt;
}

// Matches GetFieldPtr for
DBIResult DBIFN DSBASE::PutFieldPtr(UINT32 iRecNo, UINT32 iFldNo, pBYTE pFldPtr, // If Blank, returns NULL
   BOOL bBlank)
{
   if (bBlank)
      return PutBlank(NULL, iRecNo, iFldNo, bBlank);
   if (pFldPtr == NULL)
      return PutBlank(NULL, iRecNo, iFldNo, BLANK_NULL);

   // Faster version of PutField
   DBIResult rslt = DBIERR_NONE;
   pDSFLDDesc pFldDes;
   UINT32 iFldLen;
   pBYTE pValue;
   pBYTE pNullOffset;

   if (iFldNo == FIELD_ATTR) // Put attribute
   {
      piAttr[iRecNo-1] = *(pDSAttr)pFldPtr;
      return rslt;
   }

   pFldDes = &pFieldDesc[iFldNo -1]; // 0-based
   iFldLen = pFldDes->iFldLen;
   pValue = ppColumns[iFldNo-1]; // Start of value array for field i+1
   pValue += iFldLen*(iRecNo-1);
   if (pFldDes->iFldType == fldBCD || pFldDes->iFldType == fldFMTBCD)
   {
      rslt = FldMoveNormalizeBCD((pFMTBcd)pFldPtr, (pFMTBcd)pValue, pFldDes->iUnits1, pFldDes->iUnits2);
      if (rslt)
         return rslt;
   }
   else
   {
      if (iFldLen)
      {
         switch(iFldLen)
         {
         case 1:
            *(pUINT8)pValue = *(pUINT8)pFldPtr;
            break;
         case 2:
            *(pUINT16)pValue = *(pUINT16)pFldPtr;
            break;
         case 4:
            *(pUINT32)pValue = *(pUINT32)pFldPtr;
            break;
         default:
            CopyMem(pValue, pFldPtr, iFldLen);
            break;
         }
      }
   }

   pNullOffset = pNulls;
   pNullOffset += iNullLength*(iRecNo-1); // Point to records null values
   pNullOffset[iFldNo-1] = FALSE;

   return rslt;
}

DBIResult DBIFN DSBASE::GetFieldPtrB(pBYTE pRecBuf, UINT32 iFldNo, pBYTE *ppFldPtr, // If Blank, returns NULL
   pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   pDSFLDDesc pFldDes;

   if (iFldNo == 0)
      return DBIERR_OUTOFRANGE;

   pFldDes = &pFieldDesc[iFldNo-1]; // 0-based
   if (ppFldPtr)
   {
      *ppFldPtr = pRecBuf + pFldDes->iFldOffsInRec;
   }
   if (pbBlank)
   {
      pBYTE pNullOffset = pRecBuf + iNullOffset;
      BYTE bBlank = pNullOffset[iFldNo-1];
      if (pFldDes->iFieldIDParent)
      { // Special treatment if part of ADT/ARRAY
      }
      *pbBlank = bBlank;
      if (bBlank /* == TRUE */ && ppFldPtr)
         *ppFldPtr = NULL;
   }
   return rslt;
}
