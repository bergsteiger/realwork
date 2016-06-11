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

#include "dspickle.h"

DBIResult DBIFN xOverWriteRecord(DSBASE *pDs, UINT32 iRecNo, UINT32 iNo);
DBIResult DBIFN xMoveRecord(DSBASE *pDs, UINT32 iRecNoTo, UINT32 iRecNoFrom, UINT32 iNo);

// Overwrites the given record with recordbuffer
DBIResult DBIFN DSBASE::PutRecord(UINT32 iRecNo, pBYTE pRecBuf)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   pDSFLDDesc pFldDes;
   pBYTE pPtr = pRecBuf;
   UINT32 iFldLen;
   pBYTE pValue, pNullField;

   LOCK();
   for (i = 0; i < iFields; i++)
   {
      pFldDes = &pFieldDesc[i];
      iFldLen = pFldDes->iFldLen;
      if (iFldLen) // If not an ADT/ARRAY field
      {
         pValue = ppColumns[i]; // Start of value array for field i+1
         pValue += iFldLen*(iRecNo-1);
         CopyMem(pValue, pPtr, iFldLen);
         pPtr += iFldLen;
      }
   }
   pNullField = pNulls + iNullLength*(iRecNo-1);
   CopyMem(pNullField, pRecBuf + iNullOffset, iNullLength);
   UNLOCK();
   return rslt;
}

// Assembles record number 'iRecNum' into pRecBuf
DBIResult DBIFN DSBASE::GetRecord(UINT32 iRecNo, pBYTE pRecBuf)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   pDSFLDDesc pFldDes;
   pBYTE pPtr = pRecBuf;
   UINT32 iFldLen;
   pBYTE pValue, pNullField;

   LOCK();
   if (iRecNo == 0 || iRecNo > iRecNoNext) // Just check range
   {
      rslt = DBIERR_OUTOFRANGE;
      goto Exit;
   }

   if (pRecBuf == NULL) // Use internal buffer
      pPtr = pAuxRecBuf;

   for (i = 0; i < iFields; i++)
   {

      pFldDes = &pFieldDesc[i];
      iFldLen = pFldDes->iFldLen;
      pValue = ppColumns[i];
      pValue += iFldLen*(iRecNo-1);
      CopyMem(pPtr, pValue, iFldLen);
      pPtr += iFldLen;
   }
   pNullField = pNulls + iNullLength*(iRecNo-1);
   CopyMem(pRecBuf + iNullOffset, pNullField, iNullLength);

Exit:
   UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::DeleteRecord(UINT32 iRecNo)
{
   DBIResult rslt;

   LOCK();
   if (!bDisableLog && (bReadOnly || bDisableDeletes))
   { // Do not accept changes, unless bDisablelog is TRUE (meaning it is initializing data)
      rslt = DBIERR_TABLEREADONLY;
      goto Exit;
   }
   rslt = IsValidRec(iRecNo);
   if (rslt)
      goto Exit;

   piAttr[iRecNo-1] |= dsRecDeleted;

   rslt = xDeleteRecord(iRecNo, iIndexes); // Delete from indexes
   if (rslt)
   { // Back-out
      piAttr[iRecNo-1] &= ~dsRecDeleted;
      goto Exit;
   }
   iRecords--;
   if (!bDisableLog)
   {
      if (pDsLog == NULL)
         pDsLog = new DSLOG(3, this);
      rslt = pDsLog->AddToLog(iRecNo, 0, dsRecDeleted, 0);
   }
   if (pDsCallBacks)
      pDsCallBacks->Notify();
   bDataHasChanged++;

Exit:
   UNLOCK();
   return rslt;
}

// PiRecNo is the new record-number
DBIResult DBIFN DSBASE::ModifyRecord(UINT32 iRecNo, pBYTE pRecBuf, pUINT32 piRecNo)
{
   DBIResult rslt = DBIERR_NONE;

   LOCK();
   if (!bDisableLog && (bReadOnly||bDisableEdits))
   { // Do not accept changes, unless bDisablelog is TRUE (meaning it is initializing data)
      rslt = DBIERR_TABLEREADONLY;
      goto Exit;
   }
   if (iRecNoNext >= iRecordSpace)
   {
      rslt = GrowDS(100); // We must grow dataset
   }
   if (!rslt)
   {
      BOOL bValid;
      DSAttr iAttrOld;

      rslt = IsValidRec(iRecNo);
      if (rslt)
         goto Exit;

      if (pfCalcFn) // Fill calculated fields
      { // Should we protect by using different buffer?
         rslt = pfCalcFn(iCalcClientData, pRecBuf);
         if (rslt)
            goto Exit;
      }
      bValid = pDsConstr && !bConstraintsDisabled ? pDsConstr->Evaluate(pRecBuf) : TRUE;
      if (!bValid)
      {
         rslt = DBIERR_CONSTRAINTFAILED; // Did not pass constraint
         goto Exit;
      }

      if (bDisableLog)
      {
         rslt = OverWriteRecord(iRecNo, pRecBuf, 0); // Does BlobCommit, does recalc!
         if (rslt)
            goto Exit;
         if (piRecNo)
            *piRecNo = iRecNo;
         if (pDsCallBacks)
            pDsCallBacks->Notify();
         goto Exit;
      }

      rslt = PutRecord(iRecNoNext, pRecBuf); //
      if (rslt)
         goto Exit;

      iAttrOld = piAttr[iRecNo-1];

      piAttr[iRecNo-1] |= dsRecOrg; // 0/dsRecNew/dsRecModified + dsRecOrg
      piAttr[iRecNoNext-1] = dsRecModified; // Before upd. chgindex)
      if (iAttrOld & dsRecNew)
         piAttr[iRecNoNext-1] |= dsRecNew;
      rslt = xModifyRecord(iRecNoNext, iRecNo, iIndexes); // Modifies from indexes
      if (rslt)
      { // Back-out
         piAttr[iRecNo-1] = iAttrOld; // restore status
         goto Exit;
      }

      if (piRecNo)
         *piRecNo = iRecNoNext;
      if (!bDisableLog)
      {
         if (pDsLog == NULL)
            pDsLog = new DSLOG(3, this);
         pDsLog->AddToLog(iRecNoNext, iRecNo, dsRecModified, 0);
      }
      iRecNoNext++;
      if (pDsCallBacks)
         pDsCallBacks->Notify();
      if (pDsBlobs)
         pDsBlobs->Commit();
      bDataHasChanged++;
   }
Exit:
   UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::InsertRecord(pBYTE pRecBuf, pUINT32 piRecNo)
{
   DBIResult rslt = DBIERR_NONE;

   LOCK();
   if (!bDisableLog && (bReadOnly||bDisableInserts))
   { // Do not accept changes, unless bDisablelog is TRUE (meaning it is initializing data)
      rslt = DBIERR_TABLEREADONLY;
      goto Exit;
   }
   if (iRecords == 0)
   { // Setup field-offsets
      // rslt = ComputeFldOffs();
      // InitBaseProps();
      // if (rslt)
      // goto Exit;
   }
   if (iRecNoNext >= iRecordSpace)
   {
      rslt = GrowDS(100); // We must grow dataset
   }
   if (!rslt)
   {
      BOOL bValid;

      if (pRecBuf == NULL)
      { // (NULL if called from readrows/append)
         if (pfCalcFn)
         {
            if (pAuxRecBuf)
            {
               GetRecord(iRecNoNext, pAuxRecBuf);
               rslt = RecalcRec(iRecNoNext, pAuxRecBuf);
            }
            else
            {
               rslt = RecalcRec(iRecNoNext, NULL);
            }
            if (rslt)
               goto Exit;
         }
      }
      else
      {
         if (pfCalcFn) // Fill calculated fields
         { // Should we protect by using different buffer?
            rslt = pfCalcFn(iCalcClientData, pRecBuf);
            if (rslt)
               goto Exit;
         }
         bValid = pDsConstr && !bConstraintsDisabled ? pDsConstr->Evaluate(pRecBuf) : TRUE;
         if (!bValid)
         {
            rslt = DBIERR_CONSTRAINTFAILED; // DId not pass constraint
            goto Exit;
         }
         PutRecord(iRecNoNext, pRecBuf);
      }

      // piAttr[iRecNoNext-1] |= dsRecNew;
      if (!bDisableLog) // Nov. -97
      {
         piAttr[iRecNoNext-1] = dsRecNew;
      }
      rslt = xInsertRecord(iRecNoNext, iIndexes); // Inserts in indexes
      if (rslt)
      { // Back-out
         piAttr[iRecNoNext-1] = 0;
         goto Exit;
      }
      iRecords++;
      if (!bDisableLog)
      {
         if (pDsLog == NULL)
            pDsLog = new DSLOG(3, this);
         pDsLog->AddToLog(iRecNoNext, 0, dsRecNew, 0);
      }
      if (piRecNo)
         *piRecNo = iRecNoNext;
      iRecNoNext++;
      if ((!bDisableLog) && (pDsCallBacks))
         pDsCallBacks->Notify(); // Fix for clone resync bug
      if (pDsBlobs)
         pDsBlobs->Commit();
      bDataHasChanged++;
   }
Exit:
   UNLOCK();
   return rslt;
}

// Returns record number of undone record (used for fly with change sem.)
DBIResult DBIFN DSBASE::UndoLastChange(pUINT32 piRecNo)
{
   DBIResult rslt;
   UINT32 iRecNo1, iRecNo2;
   DSAttr iAttr;

   LOCK();
   if (pDsLog == NULL || (rslt = pDsLog->GetLogEntry(&iRecNo1, &iRecNo2, &iAttr)) != DBIERR_NONE)
   {
      rslt = DBIERR_NOTHINGTOUNDO;
      goto Exit; // No more entries to undo
   }

   // Should see if any blobs where allocated, and free them!
   switch(iAttr)
   {
   case dsRecDeleted: // Undo delete
      piAttr[iRecNo1-1] &= ~dsRecDeleted; // NOT
      iRecords++;
      if (piRecNo)
         *piRecNo = iRecNo1;
      if (pfCalcFn) // Fill calculated fields
      {
         RecalcRec(iRecNo1, NULL);
      }
      rslt = xInsertRecord(iRecNo1, iIndexes);
      if (rslt) // restore
      {
         piAttr[iRecNo1-1] |= dsRecDeleted;
         goto Exit;
      }
      pDsLog->RemFromLog(); // Remove last item from log
      break;

   case dsRecNew: // Undo insert
      if (iRecNo1 == iRecNoNext-1)
      { // If last one
         piAttr[iRecNo1-1] = 0; // Remove entry
         iRecNoNext--;
         if (iAutoIncField) // Add autoinc field
            iAutoIncNext--;
      }
      else
         MakeUnused(iRecNo1);
      iRecords--;
      if (piRecNo)
         *piRecNo = iRecNo1;
      rslt = xDeleteRecord(iRecNo1, iIndexes); // Remove from indexes
      if (rslt)
      {
         piAttr[iRecNo1-1] = dsRecNew; // Restore
         goto Exit;
      }
      pDsLog->RemFromLog(); // Remove last item from log
      break;

   case dsRecModified: // Undo Modify. iRecNo2 is original record
      if (iRecNo1 == iRecNoNext-1)
      {
         piAttr[iRecNo1-1] = 0; // Remove entry
         iRecNoNext--;
      }
      else
         MakeUnused(iRecNo1);
      if (piAttr[iRecNo2-1] & dsRecOrg)
         piAttr[iRecNo2-1] &= ~dsRecOrg;
      if (piRecNo)
         *piRecNo = iRecNo2; // New position
      if (pfCalcFn) // Fill calculated fields
      {
         RecalcRec(iRecNo2, NULL);
      }
      rslt = xModifyRecord(iRecNo2, iRecNo1, iIndexes); // Remove from indexes
      if (rslt)
      {
         piAttr[iRecNo2-1] |= dsRecOrg;
         goto Exit;
      }
      pDsLog->RemFromLog(); // Remove last item from log
      break;

   case dsDetUpd: // Undo detail update. iRecNo1 is Master-RecNo, iRecNo2 is iDetID
      {
         UINT32 iDetID = iRecNo2;
         pLTABLEEntry pEntry = pLinkedTables->GetEntry(iDetID);

         rslt = pEntry->pDsDet->UndoLastChange(NULL); // This removes logentry at this level!
         if (piRecNo) // Follow record whos detail was changed
            *piRecNo = iRecNo1;
      }
      break;
   case 0 /* dsDetInsFlyAway */ : // This is a hint, remove it
      {
         pDsLog->RemFromLog(); // Remove last item from log
         rslt = UndoLastChange(piRecNo);
      }
      break;
   }
Exit:
   if (rslt == DBIERR_NONE)
   {
      if (pDsCallBacks)
         pDsCallBacks->Notify();
      if (pDsBlobs) // Release all uncommitted blobs
         pDsBlobs->Release(0);
   }
   UNLOCK();
   return rslt;
}

// Undoes operation. It is assumed the action is not the last one in the log when bAdjLog is TRUE.
// Higher level must adjust log !
DBIResult DBIFN DSBASE::UndoRecord(UINT32 iRecNo1, UINT32 iRecNo2, DSAttr iAttr, BOOL bAdjLog)
{
   DBIResult rslt;

   // LOCK();
   UNREFERENCED_PARAMETER(bAdjLog);
   // Should see if any blobs where allocated, and free them!
   switch(iAttr)
   {
   case dsRecDeleted: // Make it visible again
      piAttr[iRecNo1-1] &= ~dsRecDeleted; // NOT
      iRecords++;
      if (pfCalcFn) // Fill calculated fields
      {
         RecalcRec(iRecNo1, NULL);
      }
      rslt = xInsertRecord(iRecNo1, iIndexes);
      if (rslt) // restore
         piAttr[iRecNo1-1] |= dsRecDeleted;
      break;

   case dsRecNew: // Undo insert
      if (iRecNo1 == iRecNoNext-1)
      {
         iRecNoNext--;
         if (iAutoIncField) // Add autoinc field
            iAutoIncNext--;
      }
      piAttr[iRecNo1-1] = 0; // Remove entry
      iRecords--;
      rslt = xDeleteRecord(iRecNo1, iIndexes); // Remove from indexes
      if (rslt)
         piAttr[iRecNo1-1] = dsRecNew; // Restore
      break;

   case dsRecModified: // Undo Modify
      if (iRecNo1 == iRecNoNext-1)
      {
         iRecNoNext--;
      }
      piAttr[iRecNo1-1] = 0; // Remove entry
      if (piAttr[iRecNo2-1] & dsRecOrg)
         piAttr[iRecNo2-1] &= ~dsRecOrg;
      if (pfCalcFn) // Fill calculated fields
      {
         RecalcRec(iRecNo2, NULL);
      }
      rslt = xModifyRecord(iRecNo2, iRecNo1, iIndexes); // Remove from indexes
      if (rslt)
         piAttr[iRecNo2-1] |= dsRecOrg;
      break;
   }

   if (!rslt)
   {
      if (pDsCallBacks)
         pDsCallBacks->Notify();
   }
   // UNLOCK();
   return rslt;
}

// Make the specified record unused, assume it is not part of any indexes
DBIResult DBIFN DSBASE::MakeUnused(UINT32 iRecNo)
{
   UINT32 i;
   BOOL bBlank = BLANK_NULL;

   if (piAttr[iRecNo-1] & dsUnused) // Already marked!
      goto Exit;

   for (i = 0; i < iFields; i++)
   {
      // if blob field, release blob, if nescessary
      if (pFieldDesc[i].iFldType == fldBLOB && piAttr[iRecNo-1] == 0)
      {
         // UINT32 iBlobID = 0;
         // BOOL   bBlank;
         // JOSH reports a problem
         // GetField(iRecNo, i+1, (pBYTE) &iBlobID, &bBlank);
         // if (!bBlank && iBlobID)
         // pDsBlobs->UpdBlob(NULL, 0, 0, 0); //Truncate blob
      }
      PutBlank(NULL, iRecNo, i+1, bBlank);
   }
   piAttr[iRecNo-1] |= dsUnused; // (don't destroy original attribute)
   if (iRecNo == iRecNoNext-1)
      iRecNoNext--;
   else
      iUnusedCnt++;

Exit:
   return DBIERR_NONE;
}

// Overwrites with all values different from BLANK_NOTCHANGED
// Preserves attribute-field.
DBIResult DBIFN DSBASE::OverWriteRecord(UINT32 iRecNo, pBYTE pRecBuf, BOOL bBlobs)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   // DSAttr iAttr;
   BOOL bDataChange = 0;

   UNREFERENCED_PARAMETER(bBlobs);

   if (iRecNoNext >= iRecordSpace)
   {
      rslt = GrowDS(100); // We must grow dataset
      if (rslt)
         goto Exit;
   }

   MoveRecordOver(iRecNoNext, iRecNo); // Move original record out in unused slot, includes status-field

   for (i = 0; i < iFields; i++)
   { // Disregard blob
      // New record is in pRecBuf, original record is iRec
      BOOL bBlank = FALSE;
      pBYTE pValue;

      GetFieldPtrB(pRecBuf, i+1, &pValue, &bBlank);
      if (bBlank != BLANK_NOTCHANGED)
      { // Different from  original
         if (bBlank)
            PutBlank(NULL, iRecNoNext, i+1, bBlank);
         else
            PutField(iRecNoNext, i+1, pValue); // Works for blobs too!
         bDataChange++;
      }
   }

   if (!bDataChange)
      goto Exit;

   if (pIdxChg)
      ((DSIDXCHG*)pIdxChg)->bDisabled++;
   if (pfCalcFn) // Fill calculated fields
   {
      RecalcRec(iRecNoNext, NULL);
   }
   rslt = xModifyRecord(iRecNoNext, iRecNo, iIndexes); // Modifies from indexes
   if (!rslt)
   {
      MoveRecordOver(iRecNo, iRecNoNext); // Move new record back in old slot, includes status-field
      xMoveRecord(this, iRecNo, iRecNoNext, iIndexes); // Adjust recno in indecis
      bDataHasChanged++;
   }
   if (pIdxChg)
      ((DSIDXCHG*)pIdxChg)->bDisabled--;
   if (pDsBlobs)
      pDsBlobs->Commit();
Exit:
   return rslt;
}

// Overwrites with all values different from BLANK_NOTCHANGED FROM another DSBASE!
// Does not change the attribute-field
DBIResult DBIFN DSBASE::OverWriteRecord(UINT32 iRecNo, TDSBASE *pTDs2, UINT32 iRecNo2, INT32 iFldFirst, pBOOL pbIgn)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   DSBASE *pDs2 = (DSBASE*)pTDs2;
   DSAttr iAttr;
   BOOL bVisible;
   UINT32 iInc2 = (UINT32)iFldFirst;

   if (iRecNoNext >= iRecordSpace)
   {
      rslt = GrowDS(100); // We must grow dataset
      if (rslt)
         goto Exit;
   }

   GetField(iRecNo, 0, (pBYTE) &iAttr, NULL);
   bVisible = !(iAttr & dsISNOTVISIBLE);

   MoveRecordOver(iRecNoNext, iRecNo); // Move original record out in unused slot, includes status-field

   for (i = 0; i < iFields; i++)
   {
      BOOL bBlank = FALSE;
      pBYTE pValue;

      if (i+1+iInc2 > pDs2->iFields) // Calculated fields ?
         break;
      if (pbIgn && pbIgn[i])
         continue; // Ignore this field
      pDs2->GetFieldPtr(iRecNo2, i+1+iInc2, &pValue, &bBlank);
      if (bBlank == BLANK_NOTCHANGED)
         continue; // Ignore

      // Different from  original
      if (bBlank)
      {
         PutBlank(NULL, iRecNoNext, i+1, bBlank);
         continue;
      }

      if (pFieldDesc[i].iFldAttr & fldAttrLINK)
         continue; // Don't touch SetID linking-field!

      switch(pFieldDesc[i].iFldType)
      {
      case fldTABLE:
         {
         }
         break;

      case fldBLOB:
         {
            UINT32 iBlobID2 = *(pUINT32)pValue;

            if (iBlobID2 & dsDELAYEDBIT)
               continue; // Do not overwrite.  Or should we invalidate it?

            if (iBlobID2)
            {
               UINT32 iBlobID;
               BOOL bBlankBlob;
               UINT32 iBlobLen2;
               pBYTE pBlobPtr2;

               pDs2->pDsBlobs->GetBlobInfo(iBlobID2, &iBlobLen2, &pBlobPtr2);

               GetField(iRecNoNext, i+1, (pBYTE) &iBlobID, &bBlankBlob);
               if (iBlobID && !(iBlobID & dsDELAYEDBIT) && !bBlankBlob)
               {
                  pDsBlobs->UpdBlob(pBlobPtr2, 0, iBlobLen2, iBlobID);
               }
               else
               { // Create a new blob
                  UINT32 iBlobIDNew = iBlobID;
                  rslt = pDsBlobs->AddBlob(pBlobPtr2, iBlobLen2, &iBlobIDNew);
                  if (rslt)
                     goto Exit;
                  PutField(iRecNoNext, i+1, (pBYTE) &iBlobIDNew);
                  if (iBlobID & dsDELAYEDBIT && pDsLog)
                  {
                     UINT32 iRecNoPrev = iRecNo;
                     // Fix up all previous versions
                     while ((iRecNoPrev = pDsLog->GetPrevRecNo(iRecNoPrev)) != 0)
                     {
                        PutField(iRecNoPrev, i+1, (pBYTE) &iBlobIDNew);
                     }
                  }
               }
            }
         }
         break;

      default:
         {
            PutField(iRecNoNext, i+1, pValue);
         }
         break;
      }
   }

   if (pIdxChg)
      ((DSIDXCHG*)pIdxChg)->bDisabled++;

   bDataHasChanged++;

   if (pfCalcFn) // Fill calculated fields
   {
      RecalcRec(iRecNoNext, NULL);
   }
   // If visible, update indexes. Should run constraints on it ?
   if (bVisible)
      rslt = xModifyRecord(iRecNoNext, iRecNo, iIndexes); // Modifies from indexes
   if (!rslt)
   {
      MoveRecordOver(iRecNo, iRecNoNext); // Move new record back in old slot, includes status-field
      if (bVisible)
         xMoveRecord(this, iRecNo, iRecNoNext, iIndexes); // Adjust recno in indecis
      bDataHasChanged++;
   }

   if (pIdxChg)
      ((DSIDXCHG*)pIdxChg)->bDisabled--;
   if (pDsBlobs)
      pDsBlobs->Commit();

Exit:
   return rslt;
}

DBIResult DBIFN DSBASE::RollBack(SAVEPOINT iSavePoint)
{
   DBIResult rslt = DBIERR_NONE;
   INT32 iLast;

   if (iSavePoint == 0)
   {
      iLast = 0; // Undo all
   }
   else
   {
      if (pDsLog == NULL || pDsLog->pSavePoints == NULL)
      {
         rslt = DBIERR_INVALIDPARAM;
         goto Exit;
      }
      iLast = pDsLog->pSavePoints->GetSavePointPos(iSavePoint);
      if (iLast < 1)
      {
         rslt = DBIERR_INVALIDPARAM;
         goto Exit;
      }
   }

   if (!pDsLog)
      goto Exit;

   while (pDsLog->iLast > (UINT32)iLast)
   {
      rslt = UndoLastChange(NULL);
      if (rslt)
         break;
   }
Exit:
   return rslt;
}

DBIResult DBIFN DSBASE::ReleaseBlobs( // Release all uncommitted blobs
   UINT32 iBlobId // 0: all uncommitted blobs, otherwise specific blob
   )
{
   DBIResult rslt = DBIERR_NONE;

   LOCK();
   if (pDsBlobs)
   {
      pDsBlobs->Release(iBlobId);
   }
   UNLOCK();
   return rslt;
}

// Moves the record to new position. Does not maintain indexes etc.
DBIResult DBIFN DSBASE::MoveRecordOver(UINT32 iRecNoTo, UINT32 iRecNoFrom)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   pDSFLDDesc pFldDes;
   UINT32 iFldLen;
   pBYTE pValueTo, pValueFrom, pNullFieldTo, pNullFieldFrom;
   DSAttr iAttr;
   // LOCK(); Assumed done at a higher level
   if (iRecNoTo == 0 || iRecNoFrom == 0)
   {
      rslt = DBIERR_INVALIDPARAM;
      goto Exit;
   }
   if (iRecNoTo == iRecNoFrom)
      goto Exit; // Nothing to do

   // Move attribute field over
   iAttr = piAttr[iRecNoFrom-1];
   piAttr[iRecNoTo-1] = iAttr;

   for (i = 0; i < iFields; i++)
   {
      // UINT32 iValue;

      pFldDes = &pFieldDesc[i];
      iFldLen = pFldDes->iFldLen;
      if (iFldLen) // If not an ADT/ARRAY field
      {
         pValueFrom = pValueTo = ppColumns[i]; // Start of value array for field i+1
         pValueTo += iFldLen*(iRecNoTo-1);
         pValueFrom += iFldLen*(iRecNoFrom-1);

         CopyMem(pValueTo, pValueFrom, iFldLen);
      }
   }
   pNullFieldTo = pNulls + iNullLength*(iRecNoTo-1);
   pNullFieldFrom = pNulls + iNullLength*(iRecNoFrom-1);
   CopyMem(pNullFieldTo, pNullFieldFrom, iNullLength);
   ZeroMem(pNullFieldFrom, iNullLength);

   // UNLOCK();
Exit:
   return rslt;
}
