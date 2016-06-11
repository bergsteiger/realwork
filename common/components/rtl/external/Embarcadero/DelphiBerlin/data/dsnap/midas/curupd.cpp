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

DBIResult DBIFN MDDelete(DSBASE * pDs, UINT32 iRecNo);
DBIResult DBIFN MDModify(DSBASE * pDs, DSCursor *phCur, UINT32 iRecNo, pBYTE pNewRecBuf, pBOOL pbCascading,
   pBOOL pbDetFlyAway, UINT32 iRecNoNew);
DBIResult DBIFN MDInsert(DSBASE * pDs, pBYTE pNewRecBuf, UINT32 iRecNoM, UINT32 iFieldIDM, UINT32 iSetIDM);

BOOL DBIFN LinkFieldsChanged(DSBASE * pDs, pBYTE pNewRecBuf, UINT32 iRecNo, UINT32 iLinkFields, DBIKEY piLinkFields);
DBIResult DBIFN LinkFieldsUnique(DSBASE * pDs, pLTABLEEntry pEntry, pBYTE pNewRecBuf, UINT32 iRecNo);
DBIResult DBIFN LinkFieldsCascade(DSBASE *pDsM, pLTABLEEntry pEntry, UINT32 iSetID, UINT32 iRecNoM, BOOL bFromDelta);

// From dsinmem2.cpp
DBIResult DBIFN GetRowCountForSetID(pLTABLEEntry pLEntry, BOOL bRemUnused, UINT32 iSetID, pUINT piCnt,
   pUINT32 *ppiRecNos);

DBIResult DBIFN DSCursor::InitRecord(pBYTE pRecBuf)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;

   DSLOCK(pDs);
   if (pRecBuf)
   {
      for (i = 0; i < iFields; i++)
      {
         PutField(pRecBuf, i+1, NULL); // Also clears out buffers etc.
         pDs->PutBlank(pRecBuf, 0, i+1, BLANK_NOTCHANGED); //
      }
      if (pDs->pDsConstr)
      { // Fill it with possible default values
         rslt = pDs->pDsConstr->GetDefaults(pRecBuf);
         if (rslt)
            goto Exit;
      }
      if (hCurParent)
      { // This is  a detail, overwrite link fields!
         hCurParent->GetDetailKey(pDs->iDetID, pRecBuf, FALSE, NULL, NULL, NULL);
         // if (rslt)  // Ignore error in case there is no current record
         // goto Exit;
      }
   }
Exit:
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::DeleteRecord(VOID)
{
   DBIResult rslt;

   if (pIdx->iType == idxChange)
      return DBIERR_INDEXREADONLY;

   if (pDs->bDelta) // No meaning for delta
      return DBIERR_NA;

   DSLOCK(pDs);

   ResyncWithMaster();
   Resync();
   if (!iCurState)
   {
      UINT32 iRecNoCurr = pIdx->piOrder[iCurPos];

      rslt = MDDelete(pDs, iRecNoCurr);
      if (rslt)
         goto Exit;
      rslt = pDs->DeleteRecord(iRecNoCurr);
      if (rslt)
         goto Exit;
      iSeqNoM++;
      if (hCurParent)
      {
         if (!pDs->bDisableLog)
            hCurParent->GlobalUpdateNotify(pDs->iDetID);
      }
      iCurState = DBIERR_RECDELETED;
   }
   else
   {
      rslt = (DBIResult)iCurState;
   }
Exit:
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::ModifyRecord(pBYTE pRecBuf)
{
   DBIResult rslt;

   if (pIdx->iType == idxChange)
      return DBIERR_INDEXREADONLY;

   DSLOCK(pDs);

   ResyncWithMaster();
   Resync();
   if (!iCurState)
   {
      UINT32 iRecNo = pIdx->piOrder[iCurPos];
      UINT32 i;
      BOOL bBlank;
      pBYTE pFldBuf;

      rslt = pDs->GetRecord(iRecNo, pBaseRecBuf); // Get original record
      if (rslt)
         goto Exit;

      // Check if record changed at all
      if (ByteComp(pBaseRecBuf, pRecBuf, pDs->iRecordSize) == 0)
         goto Exit; // No op.

      for (i = 0; i < iFields; i++)
      {
         UINT32 iBaseFldNo = piFieldMap[i];

         pDs->GetFieldPtrB(pRecBuf, iBaseFldNo, &pFldBuf, &bBlank);

         if ((pFieldDesc[i].iFldAttr & fldAttrREADONLY) && pFldBuf)
         { // Adding value ?
            if (ByteComp(pFldBuf, pBaseRecBuf + pDs->pFieldDesc[iBaseFldNo-1].iFldOffsInRec, pFieldDesc[i].iFldLen)
               != 0)
            {
               rslt = DBIERR_READONLYFLD;
               goto Exit;
            }
         }

         if (pFieldDesc[i].iFldType == fldTABLE || pFieldDesc[i].iFldAttr & fldAttrLINK)
         { // Trying to change a link field (SetID-link)
            continue;
         }

         if (pFieldDesc[i].iFldAttr & fldAttrREQUIRED)
         {
            // Code commented out to fix QC 71984/Raid 268357
            if (bBlank /*|| (pFieldDesc[i].iFldType == fldZSTRING && *pFldBuf == 0)*/)
            {

               rslt = DBIERR_REQDERR; // Required field
               goto Exit;
            }
         }
         if (bBlank)
            pDs->PutBlank(pBaseRecBuf, 0, iBaseFldNo, bBlank);
         else
            pDs->PutField(pBaseRecBuf, iBaseFldNo, pFldBuf);
      } // For each field
      // Check for val-checks
      if (pDs->bDelta)
      {
         // Preserves attribute byte
         rslt = pDs->OverWriteRecord(iRecNo, pBaseRecBuf, TRUE);
      }
      else
      {
         UINT32 iRecNoPrev = iSaveRecNo;
         BOOL bDetFlyAway = FALSE, bCascading = FALSE;

         rslt = MDModify(pDs, this, iRecNo, pBaseRecBuf, &bCascading, &bDetFlyAway, 0);
         if (rslt)
            goto Exit;

         rslt = pDs->ModifyRecord(iRecNo, pBaseRecBuf, &iSaveRecNo);
         if (rslt == DBIERR_NONE)
         {
            if (bCascading)
            {
               rslt = MDModify(pDs, this, iRecNo, pBaseRecBuf, NULL, NULL, iSaveRecNo);
            }
            if (iRecNoPrev != iSaveRecNo)
               iSeqNoM++;
            if (hCurParent)
            {
               if (!pDs->bDisableLog)
                  hCurParent->GlobalUpdateNotify(pDs->iDetID);
            }
            if (bDetFlyAway)
               MoveToBOF();
         }
      }
      // Note : Fly away semantics are defined by using the returned new position
   }
   else
   {
      rslt = (DBIResult)iCurState;
   }
Exit:
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::InsertRecord(pBYTE pRecBuf)
{
   DBIResult rslt;
   UINT32 i;
   BOOL bBlank;
   pBYTE pFldBuf;
   UINT32 iRecNoM = 0, iFieldIDM = 0;

   if (pIdx->iType == idxChange)
      return DBIERR_INDEXREADONLY;
   if (pDs->bDelta) // No meaning for delta
      return DBIERR_NA;

   DSLOCK(pDs);
   ResyncWithMaster(); // Make sure the scope is correct
   ZeroMem(pBaseRecBuf, pDs->iRecordSize);
   if (pIdx)
      pIdx->iInsertHintPos = 0;

   if (hCurParent)
   { // This is  a detail, get master recno, master setid

      rslt = hCurParent->GetDetailKey(pDs->iDetID, pBaseRecBuf, FALSE, &iCurrSetID, &iRecNoM, &iFieldIDM);
      if (rslt)
         goto Exit;
   }

   for (i = 0; i < iFields; i++)
   {
      UINT32 iBaseFldNo = piFieldMap[i];

      pDs->GetFieldPtrB(pRecBuf, iBaseFldNo, &pFldBuf, &bBlank);

      if (pFieldDesc[i].iFldAttr & fldAttrREQUIRED)
      {
         if (bBlank /* == TRUE */ || (pFieldDesc[i].iFldType == fldZSTRING && *pFldBuf == 0))
         {
            rslt = DBIERR_REQDERR; // Required field
            goto Exit;
         }
      }
      if (iBaseFldNo == pDs->iAutoIncField) // Add autoinc field
      {
         pDs->PutField(pBaseRecBuf, iBaseFldNo, (pBYTE) &(pDs->iAutoIncNext));
         continue;
      }
      if (pDs->pLinkedTables && pFieldDesc[i].iFldType == fldTABLE)
      {
         pDs->PutField(pBaseRecBuf, iBaseFldNo, (pBYTE) &(pDs->iSetIDNext));
         continue;
      }
      if (bBlank)
         pDs->PutBlank(pBaseRecBuf, 0, iBaseFldNo, bBlank);
      else
         pDs->PutField(pBaseRecBuf, iBaseFldNo, pFldBuf);
   }

   if (hCurParent)
   { // This is  a detail, overwrite link fields!
      if (iCurrSetID & dsDELAYEDBIT)
      { // Do not allow insertions in a non-present detail!
         rslt = DBIERR_DETAILSNOTFETCHED;
         goto Exit;
      }

      if (iCurrSetID == 0)
      { // Master record has a blank in the setidfield!
         iCurrSetID = hCurParent->pDs->iSetIDNext++;
         hCurParent->pDs->PutField(iRecNoM, iFieldIDM, (pBYTE) &iCurrSetID);
         // Is this the right way ? Any indexes that should be updated ?
         iSeqNoD--;
      }
      pDs->PutField(pBaseRecBuf, pDs->iFieldID_SetIDD, (pBYTE) &iCurrSetID);
   }

   rslt = MDInsert(pDs, pBaseRecBuf, iRecNoM, iFieldIDM, iCurrSetID);
   if (rslt)
      goto Exit;

   // Check for val-checks
   if (pIdx && iCurState == 0 && iSavePos > 0)
      pIdx->iInsertHintPos = iSavePos; // Hint, in case inde is not unique
   rslt = pDs->InsertRecord(pBaseRecBuf, &iSaveRecNo);
   if (rslt)
      goto Exit;
   iSeqNoM++;

   // If visible !
   if (pIdx->iType == idxFilter && pIdx->IdxRecNoToSeqNo(iSaveRecNo) == 0)
   {
      iCurState = DBIERR_NOCURRREC;
   }
   else
      iCurState = 0; // Aug. 97 In case position was BOF/EOF

   if (hCurParent)
   { // Notify parent about change
      if (!pDs->bDisableLog)
         hCurParent->GlobalUpdateNotify(pDs->iDetID);
   }
   if (pDs->iAutoIncField)
      pDs->iAutoIncNext++;
   if (pDs->pLinkedTables)
      pDs->iSetIDNext++;
Exit:
   if (pIdx)
      pIdx->iInsertHintPos = 0;

   // Adjust cursorposition
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::UndoLastChange(BOOL bFollowChange)
{
   DBIResult rslt;
   UINT32 iRecNo;
   BOOL bCascading = FALSE;
   UINT32 iRecNoOrg, iRecNoCurrent;
   BOOL bDetFlyAway = FALSE;
   // UINT32    iLogPos = 0;

   if (pDs->bDelta) // No meaning for delta
      return DBIERR_NA;

   // DSLOCK(pDs);
   if (pDs->pDsLog)
   {
      DSAttr iAttr = 0;

      pDs->pDsLog->GetLogEntry(&iRecNoCurrent, &iRecNoOrg, &iAttr);
      if (iAttr & dsRecModified && pDs->pLinkedTables)
      { // Check for potential cascading!

         rslt = pDs->GetRecord(iRecNoOrg, pBaseRecBuf); // Get original record
         if (rslt)
            goto Exit;
         rslt = MDModify(pDs, this, iRecNoCurrent, pBaseRecBuf, &bCascading, &bDetFlyAway, 0);
         if (rslt)
            goto Exit;
      }
   }

   rslt = pDs->UndoLastChange(&iRecNo);
   if (rslt)
      goto Exit;

   if (bCascading)
   {
      rslt = MDModify(pDs, this, iRecNoCurrent, pBaseRecBuf, NULL, NULL, iRecNoOrg);
   }

   if (bFollowChange)
   {
      if (iSaveRecNo != iRecNo)
      { // Could be detail update
         iSaveRecNo = iRecNo;
         iSeqNo--; // Make sure it resyncs
      }
   }
Exit:
   // DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::RevertRecord(VOID)
{
   DBIResult rslt = DBIERR_NONE;
   pUINT32 piRecs = NULL;
   DSLOG *pDsLogComp = NULL;
   pUINT32 piLogPos = NULL;

   if (pDs->bDelta) // No meaning for delta
      return DBIERR_NA;
   if (pDs->pDsLog == NULL || pDs->pDsLog->iLast == 0)
      return DBIERR_NONE; // Ignore

   DSLOCK(pDs);
   ResyncWithMaster();
   Resync();

   if (hCurParent)
   { // This is a detail!
      // If detail, we need to remove all references in masters to the change

   }

   if (iCurState == 0 || iCurState == DBIERR_RECDELETED)
   {
      DSAttr iAttr = 0;
      DSAttr iAction = 0;
      UINT32 iRecNoCurrent = pIdx->piOrder[iCurPos]; // Current record (BEGPOS safe?)
      UINT32 iRecNoOrg = 0;
      BOOL bDetFlyAway = FALSE, bCascading = FALSE;

      pDs->GetField(iRecNoCurrent, 0, &iAttr, NULL);

      if (iAttr & dsRecModified || iAttr & dsRecNew || iAttr & dsRecDeleted)
      {
         // Attribute most be 'last modified' or visible! Could be recModified or recNew.
         // We need to find the original record, resulting in iRecNo1, if any
         UINT32 iCnt = 0;
         UINT32 i;

         if (iAttr & dsRecDeleted)
         {
            iAction = dsRecDeleted; // Will always be the last one!
            goto Undo;
         }
         pDsLogComp = new DSLOG(pDs->pDsLog->iLast, NULL);
         if (pDsLogComp == NULL)
         {
            rslt = DBIERR_NOMEMORY;
            goto Exit;
         }
         pDs->pDsLog->CompactLog(pDsLogComp); // Create compacted log

         // Find entry
         for (i = 0; i < pDsLogComp->iLast; i++)
         {
            LOGENTRY *pEntry = &pDsLogComp->pLogEntries[i];

            if (pEntry->iRecNo1 == iRecNoCurrent)
            {
               iAction = (DSAttr)pEntry->iAttr;
               iRecNoOrg = pEntry->iRecNo2; // For modify only
               break; // found it
            }
         }
         if (iAction == 0) // Not found
            goto Exit;
      Undo:
         if (pDs->pLinkedTables && iAction == dsRecNew)
         { // If record was originally inserted, we should fail if details were added
            // Make sure there are no inserted details here!
            // (if cascaded deletes is enabled, it actually deletes the details)
            rslt = MDDelete(pDs, iRecNoCurrent);
            if (rslt)
               goto Exit;
         }

         if (pDs->pLinkedTables && iAction == dsRecModified)
         {
            rslt = pDs->GetRecord(iRecNoOrg, pBaseRecBuf); // Get original record
            if (rslt)
               goto Exit;
            rslt = MDModify(pDs, this, iRecNoCurrent, pBaseRecBuf, &bCascading, &bDetFlyAway, 0);
            if (rslt)
               goto Exit;
         }
         rslt = pDs->UndoRecord(iRecNoCurrent, iRecNoOrg, iAction, FALSE);
         if (rslt)
            goto Exit;
         if (bCascading)
         {
            rslt = MDModify(pDs, this, iRecNoCurrent, pBaseRecBuf, NULL, NULL, iRecNoOrg);
         }
         if (iAction == dsRecDeleted)
         { // When reverting a deleted record, we do not want to revert all the way back
            // if the record was also modified or inserted..
            for (i = 0; i < pDs->pDsLog->iLast; i++)
            {
               LOGENTRY *pEntry = &pDs->pDsLog->pLogEntries[i];

               if (pEntry->iRecNo1 == iRecNoCurrent && pEntry->iAttr == (UINT32)iAction)
               {
                  pDs->pDsLog->RemoveEntry(i);
                  // if (hCurParent)
                  // { //Notify parent
                  // hCurParent->GlobalLogUndo(pDs->iDetID, i+1); // +1 ?
                  // }
                  break; // found it
               }
            }
            goto AdjustIdx;
         }
         piRecs = new UINT32[(pDs->pDsLog->iLast + 1)*(hCurParent? 2 : 1)];
         if (piRecs == NULL)
         {
            rslt = DBIERR_NOMEMORY;
            goto Exit;
         }
         if (hCurParent)
            piLogPos = piRecs +(pDs->pDsLog->iLast + 1);

         pDs->pDsLog->RemoveAction(iAction, iRecNoOrg ? iRecNoOrg : iRecNoCurrent, &iCnt, piRecs, piLogPos);
         if (iCnt > 1)
         {
            UINT32 j;

            for (j = 1; j < iCnt; j++)
            {
               UINT32 iNo = piRecs[j];
               pDs->MakeUnused(iNo); // Make records unused
            }
         }

         // Follow change
         if (iRecNoOrg)
         { // If modified back to original, goto that position
            iSaveRecNo = iRecNoOrg;
            iSeqNo--; // Make sure it resyncs
         }
         else
         { // if inserted record was reverted, the current position is now undefined.
            if (!(iAttr & dsRecDeleted))
               iCurState = DBIERR_RECDELETED;
         }
      }
   AdjustIdx:
      if (pIdx->iType == idxChange)
      {
         ((DSIDXCHG*)pIdx)->IdxCreateOrder(NULL, NULL); // Clean it up!
      }
   }
Exit:
   if (piRecs)
      delete piRecs;
   DSUNLOCK(pDs);
   return rslt;
}

// Master-detail semantics for deletion
DBIResult DBIFN MDDelete(DSBASE * pDs, UINT32 iRecNo)
{
   DBIResult rslt = DBIERR_NONE;

   // If any detail tables, check if there are any details belonging to this table
   if (pDs->iMDSemantics & mdMASTER && pDs->pLinkedTables)
   {
      UINT32 i = 1;
      pLTABLEEntry pEntry;

      while ((pEntry = pDs->pLinkedTables->GetEntry(i++)) != NULL)
      {
         // DSBASE *pDsDet = pEntry->pDsDet;
         UINT32 iSetId;
         BOOL bBlank;
         DSCursor *phLinkCur;
         UINT iRecCnt = 0;
         BOOL bHasDetails = FALSE;

         // This is actually a reference, skip test
         if (pDs->pFieldDesc[pEntry->iFieldID_SetIDM-1].iFldSubType == fldstREFNestedTable)
            continue;

         // Get SetID for details
         pDs->GetField(iRecNo, pEntry->iFieldID_SetIDM, (pBYTE) &iSetId, &bBlank);
         if (bBlank) // No details
            continue;
         // Check if there are details
         phLinkCur = (DSCursor*)pEntry->phCurDet;
         if (phLinkCur)
         {
            rslt = phLinkCur->GetRecordCount(&iRecCnt);
            if (rslt == DBIERR_DETAILSNOTFETCHED || iRecCnt)
            {
               bHasDetails = TRUE;
            }
         }
         else
         {
            pUINT32 piRecNos = NULL;

            if (iSetId & dsDELAYEDBIT)
               bHasDetails = TRUE;
            else
            {
               rslt = GetRowCountForSetID(pEntry, FALSE, iSetId, &iRecCnt, &piRecNos);
               if (rslt)
                  goto Exit;
               if (iRecCnt)
                  bHasDetails = TRUE;
            }
         }
         if (bHasDetails)
         {
            // UINT32 j;
            if (!(pDs->iMDSemantics & mdCASCADEDEL))
            {
               rslt = DBIERR_DETAILRECORDSEXIST;
               goto Exit;
            }

         }
      }
   }
Exit:
   return rslt;
}

// Master-detail semantics for insert
DBIResult DBIFN MDInsert(DSBASE * pDs, pBYTE pNewRecBuf, UINT32 iRecNoM, UINT32 iFieldIDM, UINT32 iSetIDM)
{
   DBIResult rslt = DBIERR_NONE;
   UNREFERENCED_PARAMETER(iRecNoM);
   UNREFERENCED_PARAMETER(iSetIDM);

   // This is a master table. Check that all linking fields to details are unique!
   // MASTERSemantics
   if (pDs->iMDSemantics & mdMASTER && pDs->pLinkedTables)
   {
      pLTABLEEntry pEntry;
      UINT32 i = 1;

      // For all embedded details, check if linking fields ar unique
      while ((pEntry = pDs->pLinkedTables->GetEntry(i++)) != NULL)
      {
         // This is actually a reference, skip test
         if (pDs->pFieldDesc[pEntry->iFieldID_SetIDM-1].iFldSubType == fldstREFNestedTable)
            continue;
         // Check that linking fields are unique, within current dataset
         // Generate unique index on links, if not there
         rslt = LinkFieldsUnique(pDs, pEntry, pNewRecBuf, 0);
         if (rslt)
            goto Exit;
      }
   }

   if (pDs->iMDSemantics & mdDETAIL && pDs->iLinkFields)
   { // This is detail table with link-fields. Check if linking to master is correct

      UINT32 iSetIDM2 = 0;
      UINT32 iRecNoM2 = 0;

      if (pDs->iMDSemantics & mdALLOWORPHANS)
         goto Exit;

      rslt = pDs->pDsParent->pLinkedTables->GetNewMasterForDetail(pDs->iDetID, pNewRecBuf, &iRecNoM2, &iSetIDM2);
      if (rslt)
      {
         rslt = DBIERR_NOMASTERRECORD;
         goto Exit;
      }
      if (iSetIDM2 == 0)
      {
         if (iRecNoM2 == 0)
         {
            rslt = DBIERR_NOMASTERRECORD;
            goto Exit;
         }
         // The iSetId is blank, we need to create one !
         iSetIDM2 = pDs->pDsParent->iSetIDNext++;
         pDs->pDsParent->PutField(iRecNoM2, iFieldIDM, (pBYTE) &iSetIDM2);
         // Is this the right way ? Any indexes that should be updated ?
      }
      else
      {
         if (iSetIDM2 & dsDELAYEDBIT)
         { // Do not allow insertions in a non-present detail!
            rslt = DBIERR_DETAILSNOTFETCHED;
            goto Exit;
         }
      }

      // PutSetID:
      pDs->PutField(pNewRecBuf, pDs->iFieldID_SetIDD, (pBYTE) &iSetIDM2);
   }
Exit:
   return rslt;
}

// Master-detail semantics for modify
DBIResult DBIFN MDModify(DSBASE *pDs, DSCursor *phCur, // Used to get current record no of master, if any
   UINT32 iRecNo, // MOdifying this record
   pBYTE pNewRecBuf, // with these values
   pBOOL pbCascading, // Has cascading update. If NULL, DO cascading
   pBOOL pbDetFlyAway, UINT32 iRecNoNew // Only used when cascading, recor with NEW values
   )
{
   DBIResult rslt = DBIERR_NONE;

   if (pbDetFlyAway)
      *pbDetFlyAway = FALSE;
   // If any detail tables, check if there are any details belonging to this table
   // MASTERsemantics
   if (pDs->iMDSemantics & mdMASTER && pDs->pLinkedTables)
   { // This is a master table
      UINT32 i = 1;
      pLTABLEEntry pEntry;

      // For all embedded details, check if linking fields changed!
      while ((pEntry = pDs->pLinkedTables->GetEntry(i++)) != NULL)
      {
         // DSBASE   *pDsDet = pEntry->pDsDet;

         BOOL bLinkedFieldsChanged;

         bLinkedFieldsChanged = LinkFieldsChanged(pDs, pNewRecBuf, iRecNo, pEntry->iFields, pEntry->iFieldIDM);
         if (bLinkedFieldsChanged)
         {
            UINT32 iSetId;
            DSCursor *phLinkCur;
            UINT iRecCnt = 0;
            BOOL bBlank;
            // BOOL      bRemoteDetails;
            BOOL bHasDetails = FALSE;

            // Get SetID for details
            pDs->GetField(iRecNo, pEntry->iFieldID_SetIDM, (pBYTE) &iSetId, &bBlank);
            if (bBlank) // No details
               continue;
            // Check if there are details
            phLinkCur = (DSCursor*)pEntry->phCurDet;
            if (phLinkCur)
            {
               rslt = phLinkCur->GetRecordCount(&iRecCnt); // gets visible records
               if (rslt == DBIERR_DETAILSNOTFETCHED || iRecCnt)
               {
                  bHasDetails = TRUE;
               }
            }
            else
            {
               pUINT32 piRecNos = NULL;

               if (iSetId & dsDELAYEDBIT)
                  bHasDetails = TRUE;
               else
               {
                  rslt = GetRowCountForSetID(pEntry, FALSE, iSetId, &iRecCnt, &piRecNos);
                  if (rslt)
                     goto Exit;
                  if (iRecCnt)
                     bHasDetails = TRUE;
               }
            }

            if (bHasDetails)
            {
               if (!(pDs->iMDSemantics & mdCASCADEMOD))
               {
                  rslt = DBIERR_NOCASCADEDUPDATES;
                  goto Exit;
               }

               if (iRecNoNew == 0)
               {
                  // Generate unique index on links, if not there
                  // Check that linking fields are unique, within current dataset

                  rslt = LinkFieldsUnique(pDs, pEntry, pNewRecBuf, iRecNo);
                  if (rslt)
                     goto Exit;

                  if (pbCascading)
                     *pbCascading = TRUE;
               }
               else
               { // Do the cascading of the linkfield changes

                  rslt = LinkFieldsCascade(pDs, pEntry, iSetId, iRecNoNew, FALSE);

               } // Cascading
            }
         }
      }
   }

   if (pbDetFlyAway == NULL)
      goto Exit;

   // DETAIL-Semantics
   if (pDs->iMDSemantics & mdDETAIL && pDs->pDsParent)
   { // This is detail table. Check if any linking fields changed value.
      // This would indicate a 'fly-away'.
      // Check if new master exists, if not : DBIERR_FOREIGNKEYERR
      // Get setID of new master.
      BOOL bLinkedFieldsChanged;

      bLinkedFieldsChanged = LinkFieldsChanged(pDs, pNewRecBuf, iRecNo, pDs->iLinkFields, pDs->piLinkField);
      if (bLinkedFieldsChanged)
      { // Fly-away, make sure there is a corresponding master record.
         // Get the new setID from the new master, and update it!
         UINT32 iSetIDM;
         UINT32 iRecNoM;

         rslt = pDs->pDsParent->pLinkedTables->GetNewMasterForDetail(pDs->iDetID, pNewRecBuf, &iRecNoM, &iSetIDM);
         if (rslt || iSetIDM == 0)
         {
            if (pDs->iMDSemantics & mdALLOWORPHANS)
               goto PutSetID;
            rslt = DBIERR_NOMASTERRECORD;
            goto Exit;
         }
         else
         {
            // Check special case of new master being an inserted record, in which case we
            // need to make sure the insertion happened BEFORE the first modification to the
            // the current master record
            DSAttr iAttrM = 0;

            pDs->pDsParent->GetField(iRecNoM, 0, (pBYTE) &iAttrM, NULL);
            if (iAttrM & dsRecNew /* || iAttrM & dsRecModified */ )
            {
               // Only if dsRecModified was a cascaded update!
               UINT32 ipThis, ipM;
               UINT32 iRecNoThis = 0;

               phCur->hCurParent->GetRecordNumber(&iRecNoThis);
               ipThis = pDs->pDsParent->pDsLog->GetOrgUpd(iRecNoThis, NULL);
               if (ipThis) // It was modified
               {
                  ipM = pDs->pDsParent->pDsLog->GetOrgUpd(iRecNoM, NULL);
                  if (ipThis < ipM)
                  { // Inserted record must happen before first update to current record

                     if (pDs->pDsParent->pDsParent != NULL) // 3. level
                     {
                        rslt = DBIERR_FLYAWAY_WRONGORDER;
                        goto Exit;
                     }
                     else
                     {
                        pDs->pDsParent->pDsLog->AddToLog(iRecNoM, iRecNoThis, 0, dsDetInsFlyAway);
                     }
                  }
               }
            }
         }
      PutSetID:
         pDs->PutField(pNewRecBuf, pDs->iFieldID_SetIDD, (pBYTE) &iSetIDM);
         if (pbDetFlyAway)
            *pbDetFlyAway = TRUE;
      }
   }

Exit:
   return rslt;
}

BOOL DBIFN LinkFieldsChanged(DSBASE * pDs, pBYTE pNewRecBuf, UINT32 iRecNo, UINT32 iLinkFields, DBIKEY piLinkFields)
{
   BOOL bBlank;
   UINT32 j;
   BOOL bLinkedFieldsChanged = FALSE;

   for (j = 0; j < iLinkFields; j++)
   {
      pBYTE pFldBufOrg, pFldBufMod;
      UINT32 iFldID = piLinkFields[j];

      pDs->GetFieldPtr(iRecNo, iFldID, &pFldBufOrg, &bBlank); // Get current value
      pDs->GetFieldPtrB(pNewRecBuf, iFldID, &pFldBufMod, &bBlank); // Get current value

      if (pFldBufOrg == NULL || pFldBufMod == NULL)
      {
         if (pFldBufOrg != pFldBufMod)
         {
            bLinkedFieldsChanged = TRUE;
            break;
         }
      }
      else
      {
         if (ByteComp(pFldBufOrg, pFldBufMod, pDs->pFieldDesc[iFldID-1].iFldLen) != 0)
         {
            bLinkedFieldsChanged = TRUE;
            break;
         }
      }
   }

   return bLinkedFieldsChanged;
}

DBIResult DBIFN LinkFieldsUnique(DSBASE * pDs, pLTABLEEntry pEntry, pBYTE pNewRecBuf, UINT32 iRecNo)
{
   DBIResult rslt = DBIERR_NONE;
   DSIDX *pIdxMLink = NULL;
   UINT32 iPos, iRecNoM;

   if (pEntry->iFields == 0)
      goto Exit;
   rslt = pDs->pLinkedTables->GetMasterLinkIndex(pEntry->pDsDet->iDetID, TRUE, TRUE, &pIdxMLink);
   if (rslt)
      goto Exit;
   // Check that linking fields are unique, within current dataset
   rslt = pIdxMLink->IdxFindKey(pEntry->iFields, 0, pNewRecBuf, TRUE, &iPos);
   if (rslt == DBIERR_NONE)
   { // Already exists ?
      if (pIdxMLink == pDs->pIdxDef)
         goto Exit; // Give the 'normal' error in this case
      iRecNoM = pIdxMLink->IdxSeqNoToRecNo(iPos);
      if (iRecNo == 0 || iRecNoM != iRecNo) // ==0 if insert!
      {
         rslt = DBIERR_LINKFIELDSNOTUNIQUE;
         goto Exit;
      }
   }
   else
   { // Not found
      rslt = DBIERR_NONE;
   }
Exit:
   return rslt;
}

// Cascades the changes made to iRecNoM to
DBIResult DBIFN LinkFieldsCascade(DSBASE *pDsM, pLTABLEEntry pEntry, UINT32 iSetID, UINT32 iRecNoM, BOOL bForDelta)
{
   DBIResult rslt = DBIERR_NONE;
   DSBASE *pDsDet = pEntry->pDsDet;
   pBOOL pbIgn = NULL;
   pUINT32 piRecNos;
   UINT32 i;
   UINT iRecCnt = 0;
   UINT32 iRecNoDet;

   if (pDsDet->iLinkFields == 0)
      goto Exit; // Nothing to do

   if (iSetID == 0)
   {
      pDsM->GetField(iRecNoM, pEntry->iFieldID_SetIDM, (pBYTE) &iSetID, NULL);
   }

   rslt = GetRowCountForSetID(pEntry, FALSE, iSetID, &iRecCnt, &piRecNos);
   if (rslt || iRecCnt == 0)
      goto Exit;
   rslt = GetByteBuffer(sizeof(BOOL)*pDsDet->iFields, (ppBYTE) &pbIgn, FALSE);
   if (rslt)
      goto Exit;

   for (i = 0; i < pDsDet->iFields; i++)
      pbIgn[i] = TRUE; // Initialize array

   iRecNoDet = piRecNos[0]; // Use first one
   // Put the values in the first record
   for (i = 0; i < pEntry->iFields; i++)
   {
      pBYTE pPtr;
      BOOL bBlank;

      // Overwrite all linkfield in detail
      pDsM->GetFieldPtr(iRecNoM, pEntry->iFieldIDM[i], &pPtr, &bBlank);
      pDsDet->PutFieldPtr(iRecNoDet, pDsDet->piLinkField[i], pPtr, bBlank);
      pbIgn[pDsDet->piLinkField[i]-1] = FALSE; // Overwrite this one
   }

   for (i = 0; i < iRecCnt; i++)
   {
      UINT32 iRecNoD = piRecNos[i];

      if (bForDelta) // If Attribute is dsRecModified, then do not touch linking fields
      {
         DSAttr iAttr;

         pDsDet->GetField(iRecNoD, 0, (pBYTE) &iAttr, NULL);
         if (iAttr & dsRecModified)
            continue;
      }
      rslt = pDsDet->OverWriteRecord(iRecNoD, (TDSBASE*)pDsDet, iRecNoDet, 0, pbIgn);
      if (rslt)
         break;
   }

Exit:
   if (pbIgn)
      delete pbIgn;
   return rslt;
}
