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

DBIResult DBIFN DSCursor::GetCurrentRecord(pBYTE pRecBuf)
{
   DBIResult rslt = DBIERR_NONE;

   DSLOCK(pDs);
   ResyncWithMaster();
   Resync();
   if (!iCurState)
   {
      if (pRecBuf)
      {
         pBYTE pNulls;
         UINT32 iRecNo;
         UINT32 i;

         pNulls = pRecBuf + iNullOffset;
         iRecNo = pIdx->piOrder[iCurPos];

         for (i = 0; i < iFields; i++)
         {
            BOOL bBlank;

            rslt = pDs->GetField(iRecNo, piFieldMap[i], pRecBuf, &bBlank);
            if (rslt)
               break;
            pNulls[i] = (BYTE)bBlank;
            pRecBuf += pFieldDesc[i].iFldLen;
         }
      }
   }
   else
      rslt = (DBIResult)iCurState;
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::MoveRelative(INT i)
{
   DBIResult rslt = DBIERR_NONE;

   ResyncWithMaster();
   Resync();
   if (i == 0)
   {
      rslt = (DBIResult)iCurState;
      goto Exit;
   }
   if (i > 0)
   {
      if (iCurState == DBIERR_BOF)
      {
         iCurPos = BEGPOS; // Make sure it points at 0
      }
      if (iCurPos >= ENDPOS || iCurPos + i >= ENDPOS) // avoid wrap-around!
      {
         rslt = DBIERR_EOF;
         iCurPos = ENDPOS;
      }
      else
      {
         if (iCurState!=DBIERR_RECDELETED)
            iCurPos += i;
      }
   }
   else
   {
      i = -i;
      if (iCurState)
      {
         if (iCurState == DBIERR_EOF)
            iCurPos = ENDPOS; // Could have changed
         else
            i--; // Decrement, since crack-position is BEFORE crack
      }
      if (iCurPos <= BEGPOS || iCurPos - i <= BEGPOS) // To avoid wrap-around!
      {
         rslt = DBIERR_BOF;
         iCurPos = BEGPOS;
      }
      else
      {
         iCurPos -= i;
      }
   }
   iCurState = rslt;
   SavePos();
Exit:
   return rslt;
}

DBIResult DBIFN DSCursor::MoveToSeqNo(UINT32 iSeqNo)
{
   DBIResult rslt = DBIERR_NONE;

   ResyncWithMaster();
   Resync();
   iSeqNo += BEGPOS; // (in case of a range)
   if (iSeqNo <= BEGPOS)
   {
      iSeqNo = BEGPOS;
      rslt = DBIERR_BOF;
   }
   if (iSeqNo >= ENDPOS)
   {
      iSeqNo = ENDPOS;
      rslt = DBIERR_EOF;
   }

   iCurPos = iSeqNo;
   iCurState = rslt;
   SavePos();
   return rslt;
}

DBIResult DBIFN DSCursor::GetField(pBYTE pRecBuf, UINT32 iFieldNo, pBYTE pFldBuf, pBOOL pBlank)
{
   DBIResult rslt = DBIERR_NONE;
   pDSFLDDesc pDsFldDes;

   if (pRecBuf == NULL)
   {
      UINT32 iBaseFieldNo = piFieldMap[iFieldNo-1];
      rslt = pDs->GetField(pIdx->piOrder[iCurPos], iBaseFieldNo-1, pFldBuf, pBlank);
   }
   else
   {
      pDsFldDes = &(pFieldDesc[iFieldNo-1]);
      if (pFldBuf)
         CopyMem(pFldBuf, pRecBuf + pDsFldDes->iFldOffsInRec, pDsFldDes->iFldLen);
      if (pBlank)
      {
         if (pDsFldDes->iNullOffsInRec)
         {
            BYTE bBlank = *(pRecBuf + pDsFldDes->iNullOffsInRec);
            *pBlank = (BOOL)bBlank;
         }
      }
   }
   return rslt;
}

DBIResult DBIFN DSCursor::PutField(pBYTE pRecBuf, UINT32 iFieldNo, pBYTE pFldBuf)
{
   DBIResult rslt;
   pDSFLDDesc pDsFldDes;

   rslt = DBIERR_NONE;
   pDsFldDes = &(pFieldDesc[iFieldNo-1]);
   if (pFldBuf)
   {
      if (pDsFldDes->iFldType == fldZSTRING)
      { // trim blanks, pad with zeros (ASM)
         UINT32 iLen = pDsFldDes->iFldLen;
         pBYTE pDest = pRecBuf + pDsFldDes->iFldOffsInRec;

         ZeroMem(pDest, iLen);
         iLen = LdStrLen((pCHAR)pFldBuf);

         if (pDs->bDisableStringTrimming == FALSE)
         {
            while (iLen && pFldBuf[iLen-1] == ' ')
               iLen--;
         }
         if (iLen)
         {
            CopyMem(pDest, pFldBuf, iLen);
         }
      }
      else if (pDsFldDes->iFldType == fldBCD || pDsFldDes->iFldType == fldFMTBCD)
      {
         rslt = FldMoveNormalizeBCD((pFMTBcd)pFldBuf, (pFMTBcd)(pRecBuf + pDsFldDes->iFldOffsInRec),
            pDsFldDes->iUnits1, pDsFldDes->iUnits2);
         if (rslt)
            goto Exit;
      }
      else
         CopyMem(pRecBuf + pDsFldDes->iFldOffsInRec, pFldBuf, pDsFldDes->iFldLen);
      if (pDsFldDes->iNullOffsInRec)
      {
         *(pRecBuf + pDsFldDes->iNullOffsInRec) = (BYTE)FALSE;
      }
   }
   else
   { // Get default value OR blank field
      if (pDsFldDes->iFldLen == 0 && (pDsFldDes->iFldType == fldADT || pDsFldDes->iFldType == fldARRAY))
      {
         UINT32 j;
         for (j = 0; j < pDsFldDes->iUnits2 +1; j++) // +1
         {
            *(pRecBuf + pDsFldDes->iNullOffsInRec + j) = (BYTE)TRUE;
         }

      }
      else
      {
         ZeroMem(pRecBuf + pDsFldDes->iFldOffsInRec, pDsFldDes->iFldLen);
         *(pRecBuf + pDsFldDes->iNullOffsInRec) = (BYTE)TRUE;
      }
   }
Exit:
   return rslt;
}

DBIResult DBIFN DSCursor::GetBlobLen( // Return length of blob
   pBYTE pRecBuf, UINT32 iFieldNo, pUINT32 piLength)
{
   DBIResult rslt;
   UINT32 iBlobId;
   BOOL bBlank;

   DSLOCK(pDs);
   rslt = GetField(pRecBuf, iFieldNo, (pBYTE) &iBlobId, &bBlank);
   if (bBlank || iBlobId == 0)
      *piLength = 0;
   else
   {
      rslt = pDs->pDsBlobs->GetBlobLen(iBlobId, piLength);
   }
   // Exit:
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::GetBlob( // Return blob
   pBYTE pRecBuf, UINT32 iFieldNo, UINT32 iOffset, pBYTE pBuf, pUINT32 piLength)
{
   DBIResult rslt;
   UINT32 iBlobId;
   BOOL bBlank;

   DSLOCK(pDs);
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
      rslt = pDs->pDsBlobs->GetBlob(iBlobId, iOffset, pBuf, piLength);
   }
Exit:
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::PutBlob( //
   pBYTE pRecBuf, UINT32 iFieldNo, UINT32 iOffset, pBYTE pBuf, UINT32 iLength)
{
   DBIResult rslt;
   UINT32 iBlobId = 0;
   UINT32 iOldBlobId = 0;
   ULONGP bLogChanges = 0; // BOOL

   DSLOCK(pDs);

   // If not logging changes, track existing blob to be freed later.
   pDs->GetProp(dspropLOGCHANGES, &bLogChanges);
   if (!bLogChanges)
   {
      BOOL bBlank = FALSE;
      rslt = GetField(pRecBuf, iFieldNo, (pBYTE) &iOldBlobId, &bBlank);
      if (rslt)
         goto Exit;
      if (bBlank)
         iOldBlobId = 0;
   }

   if (iLength && pBuf) // (otherwise a truncate)
   {
      if (iOffset == 0) // This is first allocation
      {
         rslt = pDs->pDsBlobs->AddBlob(pBuf, iLength, &iBlobId); // Add blob
      }
      else // Adjust an existing one!
      {
         BOOL bBlank;

         rslt = GetField(pRecBuf, iFieldNo, (pBYTE) &iBlobId, &bBlank);
         if (rslt)
            goto Exit;
         if (bBlank || iBlobId == 0)
         {
            rslt = DBIERR_FIELDISBLANK;
            goto Exit;
         }
         rslt = pDs->pDsBlobs->UpdBlob(pBuf, iOffset, iLength, iBlobId);
         goto Exit; // (no need to put)
      }
      if (rslt == DBIERR_NONE)
      {
         rslt = PutField(pRecBuf, iFieldNo, (pBYTE) &iBlobId);
      }
   }
   else
   {
      rslt = PutField(pRecBuf, iFieldNo, NULL); // Should get rid of corresponding blob ?
   }
   // Free existing blob (logChanges = False only)
   if (iOldBlobId != 0)
   {
      pDs->pDsBlobs->Release(iOldBlobId);
      pDs->pDsBlobs->Commit();
   }
Exit:

   DSUNLOCK(pDs);
   return rslt;
}

// Adjusts iCurPos,iCurState, if affected by  change
DBIResult DBIFN DSCursor::Resync(VOID)
{
   UINT32 i;

   if (hCurParent)
   {
      if (iSeqNoD != hCurParent->iSeqNoM)
      {
         // ResyncWithMaster(); // Set new range if nesc. (incs iSeqNo)
         // MoveToBOF(); // (check that range actually changed?)
      }
   }

   if (iSeqNo != pIdx->iSeqNo) // Something changed
   { // Resync
      DSLOCK(pDs);
      SetActiveRange(); // Reset iCurFirst/iCurLast
      if (iCurState != DBIERR_BOF && iCurState != DBIERR_EOF)
      {
         if (iSavePos <= pIdx->iRecs && iSaveRecNo == pIdx->piOrder[iSavePos])
         {
            iCurPos = iSavePos;
            if (iCurPos <= BEGPOS)
               MoveToBOF();
            if (iCurPos >= ENDPOS)
               MoveToEOF();
         }
         else
         {
            i = pIdx->IdxRecNoToSeqNo(iSaveRecNo);
            if (i == 0)
            {
               iCurState = DBIERR_RECDELETED;
               if (pIdx->IdxDesc.iFields && pIdx->IdxDesc.bUnique) // If not a heap
               {
                  DBIResult r;
                  // Now should move to 'Closest' position (in case of multiple updates)
                  r = pIdx->IdxFindKey(pIdx->IdxDesc.iFields, iSaveRecNo, TRUE, &iCurPos); // Ignore return
                  if (r == DBIERR_RECNOTFOUND && iCurPos<ENDPOS)
                     iCurPos++; // (points to record before deleted one, because key is unique and it was deleted)
               }
            }
            else
            {
               iCurPos = i;
               if (iCurPos <= BEGPOS)
                  MoveToBOF();
               if (iCurPos >= ENDPOS)
                  MoveToEOF();
            }
         }
      }

      iSeqNo = pIdx->iSeqNo; // We are now in sync
      iSeqNoM++; // reset details
      DSUNLOCK(pDs);
   }
   return DBIERR_NONE;
}

DBIResult DBIFN DSCursor::SavePos(VOID)
{
   if (iCurState != DBIERR_EOF && iCurState != DBIERR_BOF)
   {
      DSLOCK(pDs);
      iSaveRecNo = pIdx->piOrder ? pIdx->piOrder[iCurPos] : 0;
      DSUNLOCK(pDs);
   }
   if (iSavePos != iCurPos)
   {
      iSavePos = iCurPos;
      iSeqNoM++; // Must resync details
   }
   if (iSaveState != iCurState)
   {
      iSaveState = iCurState;
      iSeqNoM++; // Must resync details
   }
   return DBIERR_NONE;
}

DBIResult DBIFN DSCursor::GetCurrentBookMark(pBYTE pBookMark)
{
   pDSBOOKMRK pBk = (pDSBOOKMRK)pBookMark;

   DSLOCK(pDs);
   pBk->iPos = iCurPos;
   pBk->iState = iCurState;
   if (pIdx->piOrder)
   {
     if (iCurPos == 0xffffffff)
       pBk->iRecNo = pIdx->piOrder[static_cast<size_t>(-1)];
     else
       pBk->iRecNo = pIdx->piOrder[iCurPos];
   }
   else
     pBk->iRecNo = 0;
   pBk->iSeqNo = iSeqNo;
   pBk->iOrderID = pIdx->iID;
   DSUNLOCK(pDs);
   return DBIERR_NONE;
}

DBIResult DBIFN DSCursor::MoveToBookMark(pBYTE pBookMark)
{
   pDSBOOKMRK pBk = (pDSBOOKMRK)pBookMark;
   DBIResult rslt = DBIERR_NONE;

   DSLOCK(pDs);
   ResyncWithMaster();
   // Resync();

   if (iSeqNo != pIdx->iSeqNo) // Something changed
   {
      SetActiveRange(); // Reset iCurFirst/iCurLast
   }
   // Check if iOrderID is correct;
   if (pBk->iOrderID != pIdx->iID || pBk->iSeqNo != pIdx->iSeqNo)
   { // Use recno instead of iCurPos
      iCurPos = pIdx->IdxRecNoToSeqNo(pBk->iRecNo); // (0 if not found)
   }
   else
      iCurPos = pBk->iPos;
   if (iCurPos >= ENDPOS)
   {
      rslt = MoveToEOF();
      goto Exit;
   }
   if (iCurPos <= BEGPOS)
   {
      rslt = MoveToBOF();
      goto Exit;
   }
   iCurState = pBk->iState;
   iSeqNo = pBk->iSeqNo; // If out of date, will force a resync when accessed
   SavePos();
Exit:
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::MoveToBOF(VOID)
{
   iCurState = DBIERR_BOF;
   Resync(); // Sets BEGPOS/ENDPOS if nesc.
   iCurPos = BEGPOS;
   SavePos();
   return DBIERR_NONE;
}

DBIResult DBIFN DSCursor::MoveToEOF(VOID)
{
   iCurState = DBIERR_EOF;
   Resync(); // Sets BEGPOS/ENDPOS if nesc.
   iCurPos = ENDPOS;
   SavePos();
   return DBIERR_NONE;
}

DBIResult DBIFN DSCursor::GetRecordBlock( // Return block of records
   pUINT32 piRecs, pBYTE pRecBuf)
{
   DBIResult rslt = DBIERR_NONE;

   UNREFERENCED_PARAMETER(piRecs);
   UNREFERENCED_PARAMETER(pRecBuf);
   return rslt;
}

DBIResult DBIFN DSCursor::GetSequenceNumber( // Get Sequence number of current position
   pUINT32 piSeq)
{
   DBIResult rslt = DBIERR_NONE;

   ResyncWithMaster();
   Resync();
   if (!iCurState)
   {
      if (piSeq)
         *piSeq = iCurPos - BEGPOS;
   }
   else
      rslt = (DBIResult)iCurState;
   return rslt;
}

DBIResult DBIFN DSCursor::GetRecordNumber( // Return record number, if any
   pUINT32 piRecNo)
{
   UINT32 iSeqNo;
   DBIResult rslt = GetSequenceNumber(&iSeqNo);

   if (rslt == DBIERR_NONE && piRecNo)
   {
      iSeqNo += BEGPOS;
      *piRecNo = pIdx->IdxSeqNoToRecNo(iSeqNo);
   }
   return rslt;
}

DBIResult DBIFN DSCursor::GetRecordAttribute( // Get record attribute of current position
   pDSAttr piAttr)
{
   DBIResult rslt;

   ResyncWithMaster();
   Resync();
   if (!iCurState)
   {
      DSLOCK(pDs);
      UINT32 iRecNo = pIdx->piOrder[iCurPos];
      DSAttr iAttr = 0;
      rslt = pDs->GetField(iRecNo, 0, &iAttr, NULL);
      if (iAttr & dsRecModified && pDs->pDsLog)
      {
         UINT32 iRecNoOrg;
         DSAttr iAttrOrg;
         pDs->pDsLog->GetOrgUpd(iRecNo, &iRecNoOrg);
         if (iRecNo!=iRecNoOrg)
         {
            pDs->GetField(iRecNoOrg, 0, &iAttrOrg, NULL);
            if (iAttrOrg & dsRecNew)
               iAttr = dsRecNew;
         }
      }
      if (piAttr)
         *piAttr = iAttr;
      DSUNLOCK(pDs);
   }
   else
      rslt = (DBIResult)iCurState;
   return rslt;
}

// Locates NEXT record matching filter, from current position.
// Should be at BOF for Locate first
DBIResult DBIFN DSCursor::LocateWithFilter(pVOID pCanExpr, // NULL -> use previous
   UINT32 iLen) // Length of canexpr
{
   DBIResult rslt = DBIERR_NONE;

   if (pLocateFilt == NULL)
   {
      pLocateFilt = new DSCONSTR(pDs);
      hLocate = 0;
   }
   if (hLocate && pCanExpr)
   { // Replace filter
      pLocateFilt->Remove(hLocate);
      hLocate = 0;
   }
   if (pCanExpr)
   {
      rslt = pLocateFilt->Add((pBYTE)pCanExpr, iLen, fltCANEX, &hLocate);
   }
   if (!rslt)
   {
      pBYTE pRecBuf = (pBYTE)DsCalloc(1, iRecordSize);
      UINT32 iRecNo;

      if (pRecBuf)
      {
         while ((rslt = MoveRelative(1)) == DBIERR_NONE)
         {
            iRecNo = pIdx->piOrder[iCurPos];
            rslt = pDs->GetRecord(iRecNo, pRecBuf);
            if (rslt)
               break;
            if (pLocateFilt->Evaluate(pRecBuf))
               break; // Found one
         }
         if (rslt == DBIERR_EOF)
            rslt = DBIERR_RECNOTFOUND;
         DsFree(pRecBuf);
      }
      else
         rslt = DBIERR_NOMEMORY;
   }
   return rslt;
}
