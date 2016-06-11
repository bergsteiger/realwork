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

DBIResult DBIFN DSCursor::CompareBookMarks(pBYTE pBookMark1, pBYTE pBookMark2, pINT pCmpBkMkResult)
{
   pDSBOOKMRK pBk1 = (pDSBOOKMRK)pBookMark1;
   pDSBOOKMRK pBk2 = (pDSBOOKMRK)pBookMark2;
   pCMPBkMkRslt pRslt = (pCMPBkMkRslt)pCmpBkMkResult;

   if (pBk1->iPos == pBk2->iPos)
      *pRslt = CMPEql;
   else if (pBk1->iPos < pBk2->iPos)
      *pRslt = CMPLess;
   else if (pBk1->iPos > pBk2->iPos)
      *pRslt = CMPGtr;

   return DBIERR_NONE;
}

DBIResult DBIFN DSCursor::ExtractKey(pBYTE pRecBuf, pBYTE pKeyBuf)
{
   DBIResult rslt = DBIERR_NONE;

   if (!pKeyBuf)
      return rslt;
   DSLOCK(pDs);
   rslt = pIdx->ExtractKey(pRecBuf, pKeyBuf, FALSE);
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::MoveToKey(DSSearchCond eSearchCond, UINT32 iFields, UINT32 iPartLen, pBYTE pBuff)
{
   // Default
   BOOL bDirectKey = FALSE;

   DBIResult rslt;
   UINT32 iFnd;
   pBYTE pRecBuf = NULL;

   DSLOCK(pDs);
   ResyncWithMaster();
   Resync();

   if (pIdx->IdxDesc.iFields == 0)
   {
      rslt = DBIERR_NOTINDEXED;
      goto Exit; // No keyfields
   }

   if (pDs->iFieldID_SetIDD && iFields < pIdx->IdxDesc.iFields)
   {
      if (iFields)
         iFields++; // To account for SetID. We need to get current setid from master record
      if (hCurParent)
      {
         UINT32 iSetID = 0;

         rslt = hCurParent->GetDetailKey(pDs->iDetID, NULL, FALSE, &iSetID, NULL, NULL);
         if (rslt)
            goto Exit;
         if (iSetID == 0)
         {
            rslt = DBIERR_RECNOTFOUND;
            goto Exit;
         }
         // Make sure it contains the right SetID!
         // (We should make a copy of the buffer here)
         pDs->PutField(pBuff, pDs->iFieldID_SetIDD, (pBYTE) &iSetID);
      }
   }

   if (!iPartLen && !iFields)
      iFields = pIdx->IdxDesc.iFields;

   if (iFields + (iPartLen ? 1 : 0) > pIdx->IdxDesc.iFields)
   {
      rslt = DBIERR_OUTOFRANGE;
      goto Exit;
   }
   if (iPartLen && pFieldDesc[pIdx->IdxDesc.iKeyFields[iFields] -1].iFldType != fldZSTRING)
   {
      rslt = DBIERR_INVALIDPARAM;
      goto Exit;
   }

   if (bDirectKey)
   {
      rslt = GetByteBuffer(iRecordSize, &pRecBuf, TRUE);
      if (rslt)
         goto Exit;
      rslt = pIdx->ExtractKey(pRecBuf, pBuff, TRUE);
      if (rslt)
         goto Exit;
   }
   else
      pRecBuf = (pBYTE)pBuff;

   rslt = pIdx->IdxFindKey(iFields, iPartLen, pRecBuf, TRUE, &iFnd);
   if (eSearchCond == dskeySEARCHEQ)
   {
      if (rslt)
      {
         // Do not save position!
         goto Exit;
      }
      else
      { // Found position, make crack
         iCurPos = iFnd -1; // getnext moves to the right position
      }
   }
   else
   {
      if (rslt) // Record was not found
      {
         iCurPos = iFnd; // Creates crack AFTER this record, which is LESS than key
      }
      else
      {
         iCurPos = (eSearchCond == dskeySEARCHGEQ) ? iFnd-1 : iFnd+1-1; //
         if (eSearchCond == dskeySEARCHGT)
         { // Continue as long as 'equal'. (Curpos is at 'equal' record
            while (iCurPos+1 <= iCurLast && pIdx->IdxComp(pRecBuf, iFields, iPartLen, iCurPos +1) == 0)
            {
               iCurPos++;
            }
         }
      }
      rslt = DBIERR_NONE;
   }
   if (iCurPos > iCurLast)
   {
      MoveToEOF();
      goto Exit;
   }
   if (iCurPos < iCurFirst)
   {
      MoveToBOF();
      goto Exit;
   }
   iCurState = DBIERR_NOCURRREC; // Make a crack
   SavePos();
Exit:
   DSUNLOCK(pDs);
   if (bDirectKey && pRecBuf)
      delete pRecBuf;
   return rslt;
}

DBIResult DBIFN DSCursor::SetRange(UINT32 iFields1, pBYTE pKey1, BOOL bKey1Incl, pBYTE pKey2, BOOL bKey2Incl)
{
   // Defaults
   BOOL bKeyItself = FALSE;
   UINT32 iFields2;
   UINT32 iLen1 = 0;
   UINT32 iLen2 = iLen1;

   DBIResult rslt = DBIERR_NONE;

   DSLOCK(pDs);
   if (pIdx->IdxDesc.iFields == 0)
   {
      rslt = DBIERR_NOTINDEXED;
      goto Exit; // No keyfields
   }

   if (iFields1 == (UINT32) -1) // Special signal to avoid recursion from 'ResyncWithMaster'
   { // (problem is that seqno's are not syncronized yet!
      iFields1 = 1;
      goto cont;
   }

   // This is the same code as in 'MoveToKey'
   if (pDs->iFieldID_SetIDD && iFields1 < pIdx->IdxDesc.iFields)
   {
      if (iFields1)
         iFields1++; // To account for SetID. We need to get current setid from master record
      if (hCurParent)
      {
         ResyncWithMaster();
         // Resync();
         if (iCurrSetID == 0)
         {
            rslt = DBIERR_RECNOTFOUND;
            goto Exit;
         }
         // Make sure it contains the right SetID!
         // (We should make a copy of the buffer here)
         if (pKey1)
            pDs->PutField(pKey1, pDs->iFieldID_SetIDD, (pBYTE) &iCurrSetID);
         if (pKey2)
            pDs->PutField(pKey2, pDs->iFieldID_SetIDD, (pBYTE) &iCurrSetID);
      }
   }

cont:

   iFields2 = iFields1;
   if (!iLen1 && !iFields1)
      iFields1 = pIdx->IdxDesc.iFields;
   if (!iLen2 && !iFields2)
      iFields2 = pIdx->IdxDesc.iFields;

   if (iFields1 + (iLen1 ? 1 : 0) > pIdx->IdxDesc.iFields || iFields2 + (iLen2 ? 1 : 0) > pIdx->IdxDesc.iFields)
   {
      rslt = DBIERR_OUTOFRANGE;
      goto Exit;
   }

   // TA 12/10/2008 - No one update iLen1 and iLen2 from default value;
   // The following condition is never active.
   if ((iLen1 && (pFieldDesc[iFields1].iFldType != fldZSTRING)) || (iLen2 && (pFieldDesc[iFields2].iFldType != fldZSTRING)))
   {
      rslt = DBIERR_OUTOFRANGE;
      goto Exit;
   }

   bRangeHLSame = FALSE;
   if (pKey1)
   {
      if (pRangeLow == NULL)
      {
         pRangeLow = new BYTE[iRecordSize];
         if (pRangeLow == NULL)
         {
            rslt = DBIERR_NOMEMORY;
            goto Exit;
         }
      }
      ZeroMem(pRangeLow, iRecordSize);
      if (bKeyItself)
      {
         rslt = pIdx->ExtractKey(pRangeLow, pKey1, TRUE);
         if (rslt)
            goto Exit;
      }
      else
         CopyMem(pRangeLow, pKey1, iRecordSize);
      iRangeFieldsLow = iFields1;
      iRangePartLenLow = iLen1;
      bRangeIncLow = bKey1Incl;
      bActiveRange = TRUE;
   }

   if (pKey2)
   {
      if (pRangeHigh == NULL)
      {
         pRangeHigh = new BYTE[iRecordSize];
         if (pRangeHigh == NULL)
         {
            rslt = DBIERR_NOMEMORY;
            goto Exit;
         }
      }
      ZeroMem(pRangeHigh, iRecordSize);
      if (bKeyItself)
      {
         rslt = pIdx->ExtractKey(pRangeHigh, pKey2, TRUE);
         if (rslt)
            goto Exit;
      }
      else
         CopyMem(pRangeHigh, pKey2, iRecordSize);
      iRangeFieldsHigh = iFields2;
      iRangePartLenHigh = iLen2;
      bRangeIncHigh = bKey2Incl;
      bActiveRange = TRUE;
   }
   if (bActiveRange && iRangeFieldsLow == iRangeFieldsHigh && iRangePartLenLow == iRangePartLenHigh && bRangeIncLow ==
      bRangeIncHigh && ByteComp(pRangeLow, pRangeHigh, iRecordSize) == 0)
   {
      bRangeHLSame = TRUE;
   }

   SetActiveRange();
   MoveToBOF();

Exit:

   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::GetRecordForKey(UINT32 iFields, UINT32 iPartLen, pBYTE pKey, pBYTE pRecBuff)
{
   DBIResult rslt;

   // DSLOCK(pDs);
   rslt = MoveToKey(dskeySEARCHEQ, iFields, iPartLen, pKey);
   if (rslt)
      goto Exit;
   if (iCurState)
      rslt = MoveRelative(1); // Move off crack
   if (rslt)
      goto Exit;
   if (pRecBuff)
      rslt = GetCurrentRecord(pRecBuff);
Exit:
   // DSUNLOCK(pDs);
   return rslt;
}
