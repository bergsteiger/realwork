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

#include "dsconst.h"

DBIResult RevertRecord(DSBASE *pDs, UINT32 iRecNoOrg, UINT32 iRecNo1, UINT32 iAction, BOOL bUndo);
DBIResult CorrectRecord(DSBASE *pDs, UINT32 iRecNoOrg, UINT32 iRecNo1, pBYTE pRecUpd);

DBIResult DBIFN DSBASE::Reconcile(
   SAFEARRAY *pDeltaPickle, // Delta pickle
   SAFEARRAY *pErrorPickle, // NULL if all changes accepted
   ULONGP iClientData,
   pfDSReconcile pfReconcile // Callback-fn (called for each error)
)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   DSBASE *pDsDelta = NULL;
   DSBASE *pDsErr = NULL;
   pBYTE pRecDs = NULL, pRecDelta = NULL, pRecErr = NULL, pRecDeltaOrg = NULL, pRecDeltaConflict = NULL;
   pBOOL pbRecAccepted = NULL;
   pUINT32 piDsRecNo = NULL; // Record-numbers in original dataset
   pDSAttr piDsAction = NULL;
   DSLOG *pLogNew = NULL;
   dsCBRType eReconc;
   DSAttr iAction;
   BOOL bRemoteAbort = FALSE; // Resolver aborted, (made no changes)
   BOOL bLocalAbort = FALSE; // User on client aborted reconcile process.
   LOCK();

   if (bDelta)
   { // (XML case)
      goto Exit;
   }

   if (pErrorPickle)
   { // Some conflicts happened
      UINT32 iErrRecNo, iDeltaRecNo;
      UINT32 iFnd;
      UINT32 iFld_DeltaRecNo = 0, iFld_ErrMes = 0, iFld_ErrResp = 0, iFld_ErrCon = 0, iFld_ErrCat = 0,
      iFld_ErrCode = 0, iFld_FirstDelta = 0;

      if (pDeltaPickle == NULL)
      {
         rslt = DBIERR_INVALIDPARAM; // Invalid combination
         goto Exit;
      }
      pDsDelta = new DSBASE();
      pDsErr = new DSBASE();
      if (pDsDelta == NULL || pDsErr == NULL)
      {
         rslt = DBIERR_INVALIDPARAM; // Invalid pickle ?
         goto Exit;
      }
      rslt = pDsDelta->AppendData(pDeltaPickle, TRUE);
      if (rslt)
         goto Exit;
      rslt = pDsErr->AppendData(pErrorPickle, TRUE);
      if (rslt)
         goto Exit;

      pRecDs = new BYTE[iRecordSize];
      pRecDelta = new BYTE[iRecordSize]; // (Use base dataset, since it might be bigger!
      pRecDeltaOrg = new BYTE[iRecordSize]; //
      pRecDeltaConflict = new BYTE[iRecordSize]; //
      pRecErr = new BYTE[pDsErr->iRecordSize];
      piDsRecNo = new UINT32[pDsDelta->iRecords+1];
      piDsAction = new DSAttr[pDsDelta->iRecords+1];
      pbRecAccepted = new BOOL[pDsDelta->iRecords+1];
      if (pRecDs == NULL || pRecDelta == NULL || pRecErr == NULL || pbRecAccepted == NULL || pRecDeltaOrg == NULL ||
         pRecDeltaConflict == NULL || piDsRecNo == NULL || piDsAction == NULL)
      {
         rslt = DBIERR_NOMEMORY;
         goto Exit;
      }
      ZeroMem(pbRecAccepted, sizeof(BOOL)*(pDsDelta->iRecords+1));
      iFnd = 0;
      for (i = 0; i < pDsErr->iFields; i++) // Setup fieldnumbers
      {
         pDSFLDDesc pFDes = &pDsErr->pFieldDesc[i];

         if (!iFld_DeltaRecNo && strcmp(pFDes->szName, szdsERRRECORDNO) == 0)
         {
            iFld_DeltaRecNo = i+1;
            iFnd++;
         }
         else if (!iFld_ErrMes && strcmp(pFDes->szName, szdsERRMESSAGE) == 0)
         {
            iFld_ErrMes = i+1;
            iFnd++;
         }
         else if (!iFld_ErrResp && strcmp(pFDes->szName, szdsERRRESPONSE) == 0)
         {
            iFld_ErrResp = i+1;
            iFnd++;
         }
         else if (!iFld_ErrCon && strcmp(pFDes->szName, szdsERRCONTEXT) == 0)
         {
            iFld_ErrCon = i+1;
            iFnd++;
         }
         else if (!iFld_ErrCat && strcmp(pFDes->szName, szdsERRCATEGORY) == 0)
         {
            iFld_ErrCat = i+1;
            iFnd++;
         }
         else if (!iFld_ErrCode && strcmp(pFDes->szName, szdsERRCODE) == 0)
         {
            iFld_ErrCode = i+1;
            iFnd++;
         }
         else if (!iFld_FirstDelta && iFnd > 5 && LCStrCmpi(iLCID, pFDes->szName, pDsDelta->pFieldDesc[0].szName) == 0)
         { // First field of delta
            iFld_FirstDelta = i+1;
            break;
         }
      }
      if (iFld_FirstDelta == 0)
      {
         rslt = DBIERR_DATAPACKETMISMATCH;
         goto Exit;
      }

      // Establish connection between delta and recno's in
      {
         UINT32 iCnt;

         pLogNew = new DSLOG(pDsLog->iLast, this);
         if (pLogNew)
         {
            if (pDsLog->CompactLog(pLogNew) || pLogNew->iLast == 0)
            {
               rslt = DBIERR_DELTAISEMPTY;
               goto Exit;
            }

            iCnt = 0;
            for (i = 0; i < pLogNew->iLast; i++)
            {
               LOGENTRY *pEntry = &pLogNew->pLogEntries[i];
               if (pEntry->iRecNo2)
               {
                  if (RecsEqual(pEntry->iRecNo1, pEntry->iRecNo2, TRUE, NULL))
                     continue; // Not part of delta

                  piDsRecNo[iCnt] = pEntry->iRecNo2;
                  piDsAction[iCnt++] = dsRecOrg; // Original record in modify
               }
               if (iCnt > pDsDelta->iRecords)
               {
                  rslt = DBIERR_DATAPACKETMISMATCH; // Delta misc-match
                  goto Exit;
               }
               piDsRecNo[iCnt] = pEntry->iRecNo1;
               piDsAction[iCnt++] = (DSAttr)pEntry->iAttr;
            }

            if (iCnt != pDsDelta->iRecords)
            {
               rslt = DBIERR_DATAPACKETMISMATCH; // Delta misc-match
               goto Exit;
            }
         }
      }

      // Execute all errors
      for (iErrRecNo = 1; iErrRecNo <= pDsErr->iRecords; iErrRecNo++)
      {
         // UINT32   iDeltaRecNo = 0;
         BOOL bBlank;
         UINT32 iErrCode; //
         UINT32 iErrCategory;
         dsCBRType iResponse;
         pCHAR pErrMessage; //
         pCHAR pErrContext; //
         pBYTE pRecUpd = NULL; // Record that failed update
         pBYTE pRecOrg = NULL; // Original record, if any
         pBYTE pRecConflict = NULL; // Conflicting error, if any
         UINT32 iRecNo1 = 0; // Corresponding recordno in pDs
         UINT32 iRecNoOrg = 0; // Only if modify

         // Get Errror-record
         pDsErr->GetRecord(iErrRecNo, pRecErr);

         // Get parameters
         pDsErr->GetField(pRecErr, iFld_DeltaRecNo, (pBYTE) &iDeltaRecNo, &bBlank);
         if (bBlank || iDeltaRecNo == 0)
            continue; // This should never happen.

         // From this one, find iRecNo1, iRecNoOrg
         if (iDeltaRecNo > 0 && iDeltaRecNo <= pDsDelta->iRecords)
         {
            DSAttr iAttr = 0;

            iRecNo1 = piDsRecNo[iDeltaRecNo-1];
            iAction = piDsAction[iDeltaRecNo-1];
            if (iAction == dsRecModified)
               iRecNoOrg = piDsRecNo[iDeltaRecNo-2];

            pDsDelta->GetField(iDeltaRecNo, 0, (pBYTE) &iAttr, NULL);
            if (iAttr != iAction)
            {
               rslt = DBIERR_DATAPACKETMISMATCH; // Misc-match
               goto Exit;
            }
            // We need to get the record from the original dataset, otherwise
            // Blobs can not be retrieved !
            GetRecord(iRecNo1, pRecDelta);
            pRecUpd = pRecDelta;

            if (iAction == dsRecModified)
            {
               UINT32 i;

               // Check attribute field
               pDsDelta->GetField(iDeltaRecNo-1, 0, (pBYTE) &iAttr, NULL);
               if (iAttr != dsRecOrg)
               {
                  rslt = DBIERR_DATAPACKETMISMATCH;
                  goto Exit;
               }
               GetRecord(iRecNoOrg, pRecDeltaOrg); // (Get original, because we want to show blobs)
               pRecOrg = pRecDeltaOrg;

               // Record all the 'unchanged fields', and propagate them to the
               // /modified record
               for (i = 0; i < iFields; i++)
               {
                  BOOL bBlank;

                  pDsDelta->GetField(iDeltaRecNo, i+1, NULL, &bBlank);
                  if (bBlank == BLANK_NOTCHANGED)
                  { // Use pDsDelta to avoid problems with blobs in pDs!
                     pDsDelta->PutBlank(pRecUpd, 0, i+1, BLANK_NOTCHANGED);
                  }
               }
            }
         }
         else
         {
            rslt = DBIERR_DATAPACKETMISMATCH; // Misc-match
            goto Exit;
         }

         pDsErr->GetField(pRecErr, iFld_ErrCode, (pBYTE) &iErrCode, &bBlank);
         if (bBlank)
            iErrCode = 0;

         pDsErr->GetField(pRecErr, iFld_ErrResp, (pBYTE) &iResponse, &bBlank);

         pDsErr->GetField(pRecErr, iFld_ErrCat, (pBYTE) &iErrCategory, &bBlank);
         if (bBlank)
            iErrCategory = 0;

         // Point pointers
         pDsErr->GetField(pRecErr, iFld_ErrMes, NULL, &bBlank);
         pErrMessage = (pCHAR)(bBlank ? NULL : pRecErr+pDsErr->pFieldDesc[iFld_ErrMes -1].iFldOffsInRec);

         pDsErr->GetField(pRecErr, iFld_ErrCon, NULL, &bBlank);
         pErrContext = (pCHAR)(bBlank ? NULL : pRecErr+pDsErr->pFieldDesc[iFld_ErrCon -1].iFldOffsInRec);

         // Check if conflict record is NULL-record
         for (i = iFld_FirstDelta-1; i < pDsErr->iFields; i++)
         { // Check if conflicting record
            pBYTE pValue;
            UINT32 iDeltaFldNo = i+1 - iFld_FirstDelta +1;

            pDsErr->GetFieldPtrB(pRecErr, i+1, &pValue, &bBlank);
            if (bBlank != BLANK_NULL) // Some change!
            {
               pRecConflict = pRecDeltaConflict;
            }
            if (!bBlank)
            {
               if (pDsDelta->pFieldDesc[iDeltaFldNo-1].iFldType == fldBLOB)
               { // NOTE: we need to move the blob to the context of pDs, since that is
                  // the dataset used by the client.
                  UINT32 iBlobLen = 0;
                  // Move blob
                  pDsErr->GetBlobLen(pRecErr, i+1, &iBlobLen);
                  if (iBlobLen == 0)
                     PutField(pRecDeltaConflict, iDeltaFldNo, NULL);
                  else
                  {
                     pBYTE pBuf = (pBYTE)DsMalloc(iBlobLen);

                     if (pBuf == NULL)
                     {
                        rslt = DBIERR_NOMEMORY;
                        goto Exit;
                     }
                     pDsErr->GetBlob(pRecErr, i+1, 0, pBuf, NULL);
                     PutBlob(pRecDeltaConflict, iDeltaFldNo, 0, pBuf, iBlobLen);
                     DsFree(pBuf);
                  }
               }
               else
                  pDsDelta->PutField(pRecDeltaConflict, iDeltaFldNo, pValue);
            }
            else
               pDsDelta->PutBlank(pRecDeltaConflict, 0, iDeltaFldNo, bBlank);
         }
         rslt = DBIERR_NONE;
         if (iResponse == dscbrABORT)
            bRemoteAbort = TRUE;
         // Call reconcile callback
      Again:
         if (!bLocalAbort && pfReconcile)
         {
            eReconc = pfReconcile(iClientData, rslt, // Last error
               iAction, iResponse, iErrCode, pErrMessage, pErrContext, pRecUpd, pRecOrg, pRecConflict);
         }
         else
         { // Default action in case of no callback.
            eReconc = dscbrSKIP;
         }

         if (eReconc == dscbrABORT)
         { // Abort reconcile session, but we need to continue through
            // trouble records, so we can make succeded records permanent.
            bLocalAbort = TRUE;
            eReconc = dscbrSKIP; //
         }
         if (pDsLog == NULL || pDsLog->iLast == 0)
            continue;
         switch(eReconc)
         {
         case dscbrCANCEL:
            { // Revert record back to original
               // This action can NOT be undone
               rslt = RevertRecord(this, iRecNoOrg, iRecNo1, iAction, TRUE);
            }break;

         case dscbrCORRECT:
            { // This action can be undone
               if (pRecUpd)
                  rslt = CorrectRecord(this, iRecNoOrg, iRecNo1, pRecUpd);
               else
                  rslt = DBIERR_INVALIDPARAM;
            }break;

         case dscbrMERGE:
            // This action can NOT be undone
            if (pRecConflict && iRecNoOrg && pRecUpd)
            {
               rslt = RevertRecord(this, iRecNoOrg, iRecNo1, iAction, (iAction != dsRecNew));
               if (rslt)
                  break;
               // Overwrite record directly without involving the log
               rslt = OverWriteRecord(iRecNoOrg, pRecConflict, FALSE);
               if (rslt)
                  break;
               rslt = CorrectRecord(this, iRecNoOrg, iRecNoOrg, pRecUpd);
            }
            else
            { // Insert failed, if keyviolation, refresh record
               if (pRecConflict && pRecUpd && iAction == dsRecNew && iErrCode == DBIERR_KEYVIOL)
               {
                  rslt = RevertRecord(this, iRecNo1, iRecNo1, iAction, (iAction != dsRecNew));
                  if (rslt)
                     break;
                  // Overwrite record directly without involving the log
                  rslt = OverWriteRecord(iRecNo1, pRecConflict, FALSE);
                  if (rslt)
                     break;
                  rslt = CorrectRecord(this, iRecNo1, iRecNo1, pRecUpd);
               }
               else
                  rslt = DBIERR_INVALIDPARAM;
            }
            break;

         case dscbrREFRESH:
            // This action can NOT be undone
            // Revert to original, then overwrite it.
            if (pRecConflict && iRecNoOrg)
            {
               rslt = RevertRecord(this, iRecNoOrg, iRecNo1, iAction, (iAction != dsRecNew));
               if (rslt)
                  break;
               // Overwrite record directly without involving the log
               rslt = OverWriteRecord(iRecNoOrg, pRecConflict, FALSE);
            }
            else
            { // Insert failed, if keyviolation, refresh record
               if (pRecConflict /* && iAction == dsRecNew && iErrCode == DBIERR_KEYVIOL */ )
               {
                  rslt = RevertRecord(this, iRecNo1, iRecNo1, iAction, (iAction != dsRecNew));
                  if (rslt)
                     break;
                  // Overwrite record directly without involving the log
                  rslt = OverWriteRecord(iRecNo1, pRecConflict, FALSE);
                  // if (!rslt)
                  // bMakeAccepted = FALSE; //Force it to be removed from log!
               }
               else
                  rslt = DBIERR_INVALIDPARAM;
            }
            break;
         case dscbrSKIP: // Do nothing, keep in log
            rslt = DBIERR_NONE;
            break;
         }
         if (rslt)
         {
            goto Again;
         }
         pbRecAccepted[iDeltaRecNo-1] = TRUE;
         if (pRecOrg)
            pbRecAccepted[iDeltaRecNo-2] = TRUE;
         if (pRecDeltaConflict)
         { // If any blobs were allocated, we should free them here
            // (Not if they are copied though! (refresh, merge)
         }
      }

      if (bRemoteAbort)
         goto Exit;

      // For all accepted records, make the records permanent
      if (pDsLog && pDsLog->iLast)
      {
         pUINT32 piRecs = new UINT32[pDsLog->iLast +1];

         for (i = 0; i < pDsDelta->iRecords; i++)
         {
            if (!pbRecAccepted[i])
            { // Make change permanent
               UINT32 iCnt = 0;
               UINT32 iAction;
               UINT32 iRecNo1 = 0, iRecNoOrg = 0;

               iAction = piDsAction[i];
               iRecNo1 = piDsRecNo[i];
               if (iAction == dsRecOrg)
               {
                  iAction = piDsAction[++i];
                  iRecNoOrg = piDsRecNo[i];
               }

               if (pDsLog->RemoveAction((DSAttr)iAction, iRecNoOrg ? iRecNoOrg : iRecNo1, &iCnt, piRecs, NULL)
                  == DBIERR_NONE)
               {
                  if (iCnt > 1)
                  {
                     UINT32 j;
                     for (j = 0; j < iCnt; j++)
                     {
                        UINT32 iNo = piRecs[j];
                        if ((piAttr[iNo-1] & dsISNOTVISIBLE))
                           MakeUnused(iNo); // Make records unused
                        else
                           piAttr[iNo-1] = 0; // Remove attribute state
                     }
                  }
               }
            }
         }
         delete piRecs;
      } // End if pDsLog->iLast
   }
   else
   { // No Error-pickle
      UINT32 iMax, iLoops;
      pUINT32 piRecs;

      if (pDsLog == NULL)
         goto Exit;

      piRecs = new UINT32[pDsLog->iLast+1];
      iMax = pDsLog->iLast;
      iLoops = 0;
      while (pDsLog->iLast)
      {
         UINT32 iCnt = 0;
         UINT32 iAction;
         UINT32 iRecNo1, iRecNoOrg;
         LOGENTRY *pEntry = &pDsLog->pLogEntries[0];

         if (iLoops++ >= iMax)
            break; // Avoid eternal loop

         iAction = pEntry->iAttr;
         iRecNo1 = pEntry->iRecNo1;
         iRecNoOrg = pEntry->iRecNo2;

         if (pDsLog->RemoveAction((DSAttr)iAction, iRecNoOrg ? iRecNoOrg : iRecNo1, &iCnt, piRecs, NULL) == DBIERR_NONE)
         {
            if (iCnt > 0)
            {
               UINT32 j;
               for (j = 0; j < iCnt; j++)
               {
                  UINT32 iNo = piRecs[j];
                  if ((piAttr[iNo-1] & dsISNOTVISIBLE))
                     MakeUnused(iNo); // Make records unused
                  else
                     piAttr[iNo-1] = 0; // Remove attribute state (new f.ex.)
               }
            }
         }
      } // End while
      delete piRecs;
   }
   if (pIdxChg)
   { // Readjust change-index
      pIdxChg->IdxCreateOrder(NULL, NULL);
   }

Exit:
   if (pDsDelta)
      delete pDsDelta;
   if (pDsErr)
      delete pDsErr;
   if (pRecDs)
      delete pRecDs;
   if (pRecDelta)
      delete pRecDelta;
   if (pRecDeltaOrg)
      delete pRecDeltaOrg;
   if (pRecDeltaConflict)
      delete pRecDeltaConflict;
   if (pRecErr)
      delete pRecErr;
   if (piDsRecNo)
      delete piDsRecNo;
   if (piDsAction)
      delete piDsAction;
   if (pbRecAccepted)
      delete pbRecAccepted;
   if (pLogNew)
      delete pLogNew;
   UNLOCK();
   return rslt;
}

DBIResult RevertRecord(DSBASE *pDs, UINT32 iRecNoOrg, UINT32 iRecNo1, UINT32 iAction, BOOL bUndo)
{
   UINT32 iCnt = 0;
   pUINT32 piRecs = new UINT32[pDs->pDsLog->iLast+1];
   DBIResult rslt;

   if (piRecs == NULL)
   {
      rslt = DBIERR_NOMEMORY;
      goto Exit;
   }
   rslt = ((bUndo)? pDs->UndoRecord(iRecNo1, iRecNoOrg, (DSAttr)iAction, FALSE) : DBIERR_NONE);
   if (rslt == DBIERR_NONE)
   {
      pDs->pDsLog->RemoveAction((DSAttr)iAction, iRecNoOrg ? iRecNoOrg : iRecNo1, &iCnt, piRecs, NULL);
      if (iCnt > 1)
      {
         UINT32 j;
         for (j = 0; j < iCnt; j++)
         {
            UINT32 iNo = piRecs[j];
            if ((pDs->piAttr[iNo-1] & dsISNOTVISIBLE))
               pDs->MakeUnused(iNo); // Make records unused
            // Nesc. here ?
            else
               pDs->piAttr[iNo-1] = 0; // Remove attribute state
         }
      }
   }
   delete piRecs;
Exit:
   return rslt;
}

// Update iRecNo1 with values in
DBIResult CorrectRecord(DSBASE *pDs, UINT32 iRecNoOrg, UINT32 iRecNo1, pBYTE pRecUpd)
{
   DBIResult rslt;
   UINT32 i;

   if (iRecNoOrg)
   { // Make sure that any 'unchanged' fields are updated
      // from the original record
      for (i = 0; i < pDs->iFields; i++)
      { // Disregard blob/calculated fields
         BOOL bBlank = FALSE;

         pDs->GetField(pRecUpd, i+1, NULL, &bBlank);
         if (bBlank == BLANK_NOTCHANGED)
         {
            pBYTE pValue;

            pDs->GetFieldPtr(iRecNoOrg, i+1, &pValue, &bBlank);
            if (bBlank)
               pDs->PutField(pRecUpd, i+1, NULL);
            else
               pDs->PutField(pRecUpd, i+1, pValue); // Works for blobs too!
         }
      }
   }
   // iRecNo1 could be the same as iRecNoOrg (when merging)
   rslt = pDs->ModifyRecord(iRecNo1, pRecUpd, NULL); // Modify
   return rslt;
}
