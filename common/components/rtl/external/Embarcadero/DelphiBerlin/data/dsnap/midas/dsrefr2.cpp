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

BOOL DBIFN RecBufsEqual(DSBASE *pDs1, pBYTE pBuf1, DSBASE *pDs2, pBYTE pBuf2, BOOL bCmpBlobs, pBOOL pbSame);

DBIResult DBIFN RFModify(
   DSBASE *pDs,
   UINT32 iRecNoOrg, // Record to modify. If == 0 : insertion.
   DSBASE *pDsDelta, pBYTE pRecBufDeltaUpd, // Updated/new record (relative to Original record
   ULONGP iClientData, pfDSReconcile pfReconcile, // Callback for resolving conflicts
   pdsCBRType piCB // Returns reconcile action
);

DBIResult DBIFN RFCheckOriginal(
   UINT32 iAction,
   DSBASE *pDs,
   pUINT32 piRecNoOrg, // Return recno of record to be modified/deleted
   DSBASE *pDsDelta, pBYTE pRecBufDeltaOrg, ULONGP iClientData,
   pfDSReconcile pfReconcile, // Callback for resolving conflicts
   pdsCBRType piCB);

DBIResult DBIFN RFDelete(
   DSBASE *pDs,
   UINT32 iRecNoOrg, // Return recno of record to be modified/deleted
   ULONGP iClientData, pfDSReconcile pfReconcile, // Callback for resolving conflicts
   pdsCBRType piCB);

DBIResult DBIFN RefreshRec(
   DSBASE *pDs,
   DSBASE *pDsNew, // Dataset containing 'new values'
   UINT32 iRecNo, // Refresh this specific record
   UINT32 iRecNoNew, // from this one in pDsNew
   pBYTE pRecBuf, // Supplied record buffers (to save repeated allocations)
   pBYTE pRecBufNew, UINT32 iLevels);

DBIResult DBIFN RefreshDetails(
   DSBASE *pDs,
   DSBASE *pDsNew, // Dataset containing 'new values'
   UINT32 iRecNo, // Refresh this specific record
   UINT32 iRecNoNew // from this one in pDsNew
);

DBIResult DBIFN AppendDetails(
   DSBASE *pDsDet,
   pLTABLEEntry pEntryNew, // Dataset containing 'new values'
   UINT32 iSetID, // Refresh this specific record
   UINT32 iSetIdNew, // from this one in pDsNew
   BOOL bReplace // TRUE: Replace existing, otherwise append
);

// From dsinmem2.cpp
DBIResult DBIFN GetRowCountForSetID(
   pLTABLEEntry pLEntry,
   BOOL bRemUnused,
   UINT32 iSetID,
   pUINT piCnt,
   pUINT32 *ppiRecNos);

DBIResult DBIFN CancelDetails(
   pLTABLEEntry pEntryM, // Entry for dataset containing 'new values'
   UINT32 iSetID, // Refresh this specific record
   BOOL bRecurse);

DBIResult DBIFN GetRowReq(DSCursor *pCur, ROWREQ *pRowReq, BOOL bKeysOnly, pUINT32 piLevels);

// Refresh ALL
DBIResult DBIFN DSBASE::Refresh(
   SAFEARRAY *pNewDataPacket, // New updated pickle
   ULONGP iClientData,
   pfDSReconcile pfReconcile // Callback for resolving conflicts
)
{
   UNREFERENCED_PARAMETER(pNewDataPacket);
   UNREFERENCED_PARAMETER(iClientData);
   UNREFERENCED_PARAMETER(pfReconcile);

#ifdef NOTREADY

   DBIResult rslt; // = DBIERR_NONE;
   ULONGP iSaveBlobsInDelta = 0;
   DSBASE *pDsDelta = NULL;

   if (pNewDataPacket == NULL)
   {
      rslt = DBIERR_INVALIDPARAM;
      goto Exit;
   }

   // Set options to include full blobs, and all changes.
   GetProp(dspropINCLBLOBSINDELTA, &iSaveBlobsInDelta);
   SetProp(dspropINCLBLOBSINDELTA, -1);
   rslt = GetDelta((pBYTE*) &pDsDelta);
   SetProp(dspropINCLBLOBSINDELTA, iSaveBlobsInDelta);
   if (rslt != DBIERR_DELTAISEMPTY)
      goto Exit;

   rslt = Reset();
   if (rslt)
      goto Exit;

   if (pNewDataPacket) // Null could be allowed
   {
      rslt = AppendData(pNewDataPacket, TRUE);
      if (rslt)
         goto Exit;
   }

   if (pDsDelta)
   {
      // Get save point
      rslt = ApplyDelta(pDsDelta, iClientData, pfReconcile);
      // If rslt, restore to save point ?
   }

Exit:
   if (pDsDelta)
      delete pDsDelta; // Option to return Delta, modified with changes
   return rslt;
#endif
   return 0;
}

#ifdef NOTREADY

// DSBASE or DSCursor ?
DBIResult DBIFN DSBASE::ApplyDelta(
   DSBASE *pDsDelta, // Apply these changes
   ULONGP iClientData,
   pfDSReconcile pfReconcile // Callback for resolving conflicts
   )
{
   DBIResult rslt = DBIERR_NONE;
   pBYTE pRecBufOrg = NULL, pRecBufUpd = NULL, pRecBufDeltaUpd = NULL, pRecBufDeltaOrg = NULL;

   if (pDsDelta && pDsDelta->iRecords > 0)
   {
      UINT32 iRecNoDelta;
      DSAttr iAction;

      pRecBufDeltaOrg = new BYTE[pDsDelta->iRecordSize];
      pRecBufDeltaUpd = new BYTE[pDsDelta->iRecordSize];
      pRecBufOrg = new BYTE[this->iRecordSize];
      pRecBufUpd = new BYTE[this->iRecordSize];
      if (pRecBufOrg == NULL || pRecBufUpd == NULL || pRecBufDeltaOrg == NULL || pRecBufDeltaUpd == NULL)
      {
         rslt = DBIERR_NOMEMORY;
         goto Exit;
      }

      // MAIN LOOP over delta records
      for (iRecNoDelta = 1; iRecNoDelta <= pDsDelta->iRecords; iRecNoDelta++)
      {
         dsCBRType iCB = 0;

         // Get Action and record(s)
         rslt = pDsDelta->GetRecord(iRecNoDelta, pRecBufDeltaOrg);
         if (rslt)
            goto Exit;
         pDsDelta->GetField(iRecNoDelta, 0, &iAction, NULL);
         if (iAction == dsRecOrg)
         {
            iRecNoDelta++; // (must be less than iRecords)
            rslt = pDsDelta->GetRecord(iRecNoDelta, pRecBufDeltaUpd);
            if (rslt)
               goto Exit;
            pDsDelta->GetField(iRecNoDelta, 0, &iAction, NULL);
            if (iAction != dsRecModified)
            {
               rslt = DBIERR_NA;
               goto Exit;
            }
         }
         if (iAction == dsUnused)
            continue; // Ignore

         switch(iAction)
         {

            // MODIFICATION
         case dsRecModified:
            {
               UINT32 iRecNoOrg; // = 0;

               rslt = RFCheckOriginal(dsRecModified, this, &iRecNoOrg, pDsDelta, pRecBufDeltaOrg, iClientData,
                  pfReconcile, &iCB);
               if (!rslt)
                  rslt = RFModify(this, iRecNoOrg, pDsDelta, pRecBufDeltaUpd, iClientData, pfReconcile, &iCB);
               else
               {
                  if (rslt == DBIERR_KEYORRECDELETED && iCB == dscbrCORRECT)
                  { // Insert the record in order not to loose the info
                     // First Merge the original record in the delta with the updatefrom the delta, keeping
                     // blobs in the context of pDsDelta
                     // rslt = RFModify(this, 0, pDsDelta, pRecbufDeltaUpd, iClientData, pfReconcile, &iCB);
                  }
               }
            }break;

            // DELETION
         case dsRecDeleted:
            {
               UINT32 iRecNoOrg; // = 0;

               rslt = RFCheckOriginal(dsRecDeleted, this, &iRecNoOrg, pDsDelta, pRecBufDeltaOrg, iClientData,
                  pfReconcile, &iCB);
               if (!rslt)
                  rslt = RFDelete(this, iRecNoOrg, iClientData, pfReconcile, &iCB);

            }break;

            // INSERTION
         case dsRecNew:
            {
               rslt = RFModify(this, 0, pDsDelta, pRecBufDeltaOrg, iClientData, pfReconcile, &iCB);
            }break;
         }

         if (rslt)
         {
            if (iCB == dscbrABORT)
               goto Exit;
            if (rslt == DBIERR_NOMEMORY)
               goto Exit;
            rslt = DBIERR_NONE;
         }

      } // End for  each delta record
   }
   else
      rslt = DBIERR_DELTAISEMPTY;

Exit:
   if (pRecBufDeltaOrg)
      delete pRecBufDeltaOrg;
   if (pRecBufDeltaUpd)
      delete pRecBufDeltaUpd;
   if (pRecBufOrg)
      delete pRecBufOrg;
   if (pRecBufUpd)
      delete pRecBufUpd;
   return rslt;
}

// Update 'iRecNoOrg' with record from delta, pRecBufDelta, which might contain
// pRecBufDsOrg is the modified record.
DBIResult DBIFN RFModify(
   DSBASE *pDs,
   UINT32 iRecNoOrg, // Record to modify. If == 0 : insertion.
   DSBASE *pDsDelta,
   pBYTE pRecBufDeltaUpd, // Updated/new record (relative to Original record
   ULONGP iClientData,
   pfDSReconcile pfReconcile, // Callback for resolving conflicts
   pdsCBRType piCB // Returns reconcile action
   )
{
   DBIResult rslt;
   UINT32 i;
   dsCBRType iCB;
   pBYTE pRecBufDsUpd = NULL;
   pBYTE pRecBufConflicting = NULL;
   pBYTE pRecBufDsOrg = NULL;

   *piCB = 0;
   pRecBufDsUpd = new BYTE[pDs->iRecordSize];
   if (pRecBufDsUpd == NULL)
   {
      rslt = DBIERR_NOMEMORY;
      goto Exit;
   }
   if (iRecNoOrg)
      pDs->GetRecord(iRecNoOrg, pRecBufDsUpd);
   else
      ZeroMem(pRecBufDsUpd, pDs->iRecordSize); // Initialize recor buffer!

   // Update record buffer with new values, transfer blobs to context of ds
   for (i = 0; i < pDs->iFields; i++)
   { // calculated fields
      BOOL bBlank = FALSE;
      pBYTE pValue;

      pDsDelta->GetFieldPtr(pRecBufDeltaUpd, i+1, &pValue, &bBlank);
      if (bBlank != BLANK_NOTCHANGED)
      {
         if (bBlank)
            pDs->PutField(pRecBufDsUpd, i+1, NULL);
         else
         {
            if (pDs->pFieldDesc[i].iFldType != fldBLOB)
            {
               pDs->PutField(pRecBufDsUpd, i+1, pValue);
            }
            else
            {
               UINT32 iBlobLen = 0;

               pDsDelta->GetBlobLen(pRecBufDeltaUpd, i+1, &iBlobLen);
               if (iBlobLen != 0)
               {
                  pBYTE pBuf = (pBYTE)DsMalloc(iBlobLen);

                  if (pBuf == NULL)
                  {
                     rslt = DBIERR_NOMEMORY;
                     goto Exit;
                  }
                  pDsDelta->GetBlob(pRecBufDeltaUpd, i+1, 0, pBuf, NULL);
                  pDs->PutBlob(pRecBufDsUpd, i+1, 0, pBuf, iBlobLen);
                  DsFree(pBuf);
               }
            }
         }
      }
   }

   if (iRecNoOrg)
      rslt = pDs->ModifyRecord(iRecNoOrg, pRecBufDsUpd, NULL);
   else
      rslt = pDs->InsertRecord(pRecBufDsUpd, NULL);

   if (rslt)
   {
      DBIResult xrslt;
      CHAR szErr[255];

      // Get conflicting record
      if (rslt == DBIERR_KEYVIOL)
      {
         UINT32 iPosKV, iRecNoKV;

         if (!pRecBufConflicting)
            pRecBufConflicting = new BYTE[pDs->iRecordSize];
         xrslt = pDs->pIdxDef->IdxFindKey(pDs->pIdxDef->IdxDesc.iFields, 0, pRecBufDsUpd, FALSE, &iPosKV);
         if (xrslt)
         {
            // We might need to try multiple idx's
            goto Exit;
         }
         iRecNoKV = pDs->pIdxDef->IdxSeqNoToRecNo(iPosKV);
         pDs->GetRecord(iRecNoKV, pRecBufConflicting);
      }

      xrslt = rslt;
      rslt = DBIERR_NONE;

   Callback_Again:
      if (pfReconcile)
      {
         // We could show pRecBufDsUpd and pRecBufConflicting 'relative' to pRecBufDsOrg

         if (!pRecBufDsOrg)
            pRecBufDsOrg = new BYTE[pDs->iRecordSize];
         if (!pRecBufDsOrg)
         {
            rslt = DBIERR_NOMEMORY;
            goto Exit;
         }
         pDs->GetRecord(iRecNoOrg, pRecBufDsOrg);
         pDs->GetErrorString(xrslt, szErr);
         iCB = pfReconcile(iClientData, rslt, iRecNoOrg ? dsRecModified : dsRecNew, dscbrSKIP, xrslt, szErr, NULL,
            pRecBufDsUpd, // Modified/inserted record
            pRecBufDsOrg, // Original record
            (xrslt == DBIERR_KEYVIOL) ? (pRecBufConflicting) : (NULL) // Conflicting record
            );
      }
      else
         iCB = dscbrSKIP;

      switch(iCB)
      {
      case dscbrSKIP:
      case dscbrCANCEL:
         rslt = DBIERR_NONE;
         // Ignore
         break;
      case dscbrCORRECT:
         if (iRecNoOrg)
            rslt = pDs->ModifyRecord(iRecNoOrg, pRecBufDsUpd, NULL);
         else
            rslt = pDs->InsertRecord(pRecBufDsUpd, NULL);
         break;
      case dscbrABORT:
         rslt = DBIERR_NA; // Aborted
         goto Exit;
      default:
         rslt = DBIERR_NA;
         break;
      } // End switch
      if (rslt)
         goto Callback_Again;
   }

Exit:
   if (pRecBufDsUpd)
      delete pRecBufDsUpd;
   if (pRecBufDsOrg)
      delete pRecBufDsOrg;
   if (pRecBufConflicting)
      delete pRecBufConflicting;
   if (piCB)
      *piCB = iCB;
   return rslt;
}

// Delete with callback if it failes
DBIResult DBIFN RFDelete(DSBASE *pDs, UINT32 iRecNoOrg, // Return recno of record to be modified/deleted
   ULONGP iClientData, pfDSReconcile pfReconcile, // Callback for resolving conflicts
   pdsCBRType piCB)
{
   DBIResult rslt = DBIERR_NONE, xrslt;
   CHAR szErr[255];
   dsCBRType iCB = dscbrSKIP;
   pBYTE pRecBufDsOrg = NULL;

   rslt = pDs->DeleteRecord(iRecNoOrg);
   if (rslt)
   {
      xrslt = rslt;
      rslt = DBIERR_NONE;

   Callback_Again:
      if (pfReconcile)
      {
         if (!pRecBufDsOrg)
            pRecBufDsOrg = new BYTE[pDs->iRecordSize];
         if (!pRecBufDsOrg)
         {
            rslt = DBIERR_NOMEMORY;
            goto Exit;
         }
         pDs->GetRecord(iRecNoOrg, pRecBufDsOrg);
         // We could show pRecBufDsUpd and pRecBufConflicting 'relative' to pRecBufDsOrg
         pDs->GetErrorString(xrslt, szErr);
         iCB = pfReconcile(iClientData, rslt, dsRecDeleted, dscbrSKIP, xrslt, szErr, NULL, NULL,
            pRecBufDsOrg, // Original record
            NULL);
      }
      else
         iCB = dscbrSKIP;

      switch(iCB)
      {
      case dscbrSKIP:
      case dscbrCANCEL:
         rslt = DBIERR_NONE;
         // Ignore
         break;
      case dscbrABORT:
         rslt = DBIERR_NA; // Aborted
         goto Exit;
      default:
         rslt = DBIERR_NA;
         break;
      } // End switch
      if (rslt)
         goto Callback_Again;
   }

Exit:
   if (pRecBufDsOrg)
      delete pRecBufDsOrg;
   if (piCB)
      *piCB = iCB;
   return rslt;
}

// Find original record in pDs, and check if it changed at all
DBIResult DBIFN RFCheckOriginal(UINT32 iAction, DSBASE *pDs, pUINT32 piRecNoOrg,
   // Return recno of record to be modified/deleted

   DSBASE *pDsDelta, pBYTE pRecBufDeltaOrg, ULONGP iClientData, pfDSReconcile pfReconcile,
   // Callback for resolving conflicts
   pdsCBRType piCB)
{
   DBIResult rslt = DBIERR_NONE, xrslt;
   UINT32 iPosOrg, iRecNoOrg;
   CHAR szErr[255];
   dsCBRType iCB = dscbrSKIP;
   pBYTE pRecBufDsOrg = NULL;
   pBOOL pbSame = NULL;

   pbSame = new BOOL[pDs->iFields];
   pRecBufDsOrg = new BYTE[pDs->iRecordSize];
   if (pRecBufDsOrg == NULL || pbSame == NULL)
   {
      rslt = DBIERR_NOMEMORY;
      goto Exit;
   }
   *piCB = 0;
   // Find it in new dataset
   if ((xrslt = pDs->pIdxDef->IdxFindKey(pDs->pIdxDef->IdxDesc.iFields, 0, pRecBufDeltaOrg, FALSE, &iPosOrg))
      == DBIERR_NONE)
   { // Found it
      iRecNoOrg = pDs->pIdxDef->IdxSeqNoToRecNo(iPosOrg);
      *piRecNoOrg = iRecNoOrg;
      // Compare this record to the original record in Delta
      pDs->GetRecord(iRecNoOrg, pRecBufDsOrg);
      if (RecBufsEqual(pDs, pRecBufDsOrg, pDsDelta, pRecBufDeltaOrg, TRUE, pbSame))
         goto Exit; // We are done

      // Record was changed by remote user
      xrslt = DBIERR_OPTRECLOCKFAILED;
      rslt = DBIERR_NONE;
   Callback_OrgChanged:
      if (pfReconcile) // Only
      {
         pDs->GetErrorString(xrslt, szErr);
         iCB = pfReconcile(iClientData, rslt, iAction, dscbrSKIP, // Default
            xrslt, szErr, NULL, NULL, // pRecBufDeltaUpd (relative change)
            pRecBufDeltaOrg, // Original record change was based on
            pRecBufDsOrg // Conflicting record
            );
      }
      else
         iCB = dscbrCANCEL; // Forget the change

      switch(iCB)
      {
      case dscbrIGNORE:
      case dscbrSKIP:
         // case dscbrCANCEL  :
         rslt = DBIERR_NONE;
         break;
      case dscbrMERGE:
      case dscbrCORRECT:
         // Need create record buffer and copy blobs as well
         rslt = DBIERR_NA; // pDs->InsertRecord(pRecUpd, NULL);
         break;
      case dscbrABORT:
         rslt = DBIERR_NA; // Aborted
         goto Exit;
      default:
         rslt = DBIERR_NA;
      }
      if (rslt)
         goto Callback_OrgChanged;
   }
   else // Org not found
   {
      // Key changed, or was deleted
      // ** Insert or ignore
      if (iAction == dsRecDeleted)
      {
         rslt = DBIERR_KEYORRECDELETED;
         iCB = dscbrCANCEL;
         goto Exit; // Ignore this error
      }

      xrslt = DBIERR_KEYORRECDELETED; // Only possibility ?
      rslt = DBIERR_NONE;

   Again_OrgNotFound:
      if (pfReconcile) // Only
      {
         pDs->GetErrorString(xrslt, szErr);
         iCB = pfReconcile(iClientData, rslt, dsRecModified, dscbrSKIP, // Default
            xrslt, szErr, NULL, NULL, // pRecBufDeltaUpd,
            pRecBufDeltaOrg, NULL);
      }
      else
         iCB = dscbrCANCEL; // Forget the change

      switch(iCB)
      {
      case dscbrSKIP:
      case dscbrCANCEL:
         break;
      case dscbrCORRECT:
         // Need create record buffer and copy blobs as well
         rslt = DBIERR_NA;
         break;
      case dscbrABORT:
         rslt = DBIERR_NA; // Aborted
         goto Exit;
      default:
         rslt = DBIERR_NA;
      }

      if (rslt)
         goto Again_OrgNotFound;
   }
Exit:
   if (pbSame)
      delete pbSame;
   if (pRecBufDsOrg)
      delete pRecBufDsOrg;
   if (piCB)
      *piCB = iCB;
   return rslt;
}

#endif // NOTREADY

// Sets the pbSame array,
BOOL DBIFN RecBufsEqual(DSBASE *pDs1, pBYTE pBuf1, DSBASE *pDs2, pBYTE pBuf2, BOOL bCmpBlobs, pBOOL pbSame)
{
   BOOL bEqual = TRUE;
   BOOL bBlank1, bBlank2;
   pBYTE pFld1, pFld2;
   UINT32 i;
   UINT32 iFlds = pDs1->iFields <= pDs2->iFields ? pDs1->iFields : pDs2->iFields;

   for (i = 0; i < iFlds; i++)
   {
      DSFLDDesc *pFldDes = &pDs1->pFieldDesc[i];

      if (pFldDes->bCalculated)
      {
         goto Same;
      }
      if ((pFldDes->iFldAttr & fldAttrLINK) || pFldDes->iFldType == fldTABLE)
      { // Cannot compare SetIDS
         goto Same;
      }

      pDs2->GetFieldPtrB(pBuf2, i+1, &pFld2, &bBlank2);
      // if (bBlank2 == BLANK_NOTCHANGED)
      // {
      // goto Same;
      // }

      pDs1->GetFieldPtrB(pBuf1, i+1, &pFld1, &bBlank1);

      if (pFldDes->iFldType == fldBLOB)
      {
         if (bCmpBlobs)
         {
            UINT32 iBlobId1, iBlobId2;

            iBlobId1 = pFld1 == NULL ? 0 : *(pUINT32)pFld1;
            iBlobId2 = pFld2 == NULL ? 0 : *(pUINT32)pFld2;

            {
               UINT32 iBlobLen1;
               pBYTE pBlob1;

               if (iBlobId1 == 0 || iBlobId2 == 0)
                  goto NotSame; // (could be same if empty ?)
               pDs1->pDsBlobs->GetBlobInfo(iBlobId1, &iBlobLen1, &pBlob1);

               // Takes care of dsDELAYEDBIT
               if (pDs2->pDsBlobs->BlobIsSame(iBlobLen1, pBlob1, iBlobId2))
                  goto Same;
               else
                  goto NotSame;
            }
         }
         else
         {
            goto Same;
         }
      }
      else
      {
         INT32 iCmp;
         iCmp = pDs1->FldCmp(pFldDes->iFldType, pFld1, pFld2, pFldDes->iUnits1, pFldDes->iUnits2);
         if (iCmp)
         {
         NotSame:
            bEqual = FALSE;
            if (pbSame)
               pbSame[i] = FALSE;
         }
         else
         {
         Same:
            if (pbSame)
               pbSame[i] = TRUE;
         }
      }
   }
   return bEqual;
}

BOOL DBIFN RecordsAreEqual(DSBASE *pDs1, UINT32 iRecNo1, DSBASE *pDs2, UINT32 iRecNo2, BOOL bCmpBlobs, pBOOL pbSame)
{
   BOOL bEqual = TRUE;
   BOOL bBlank1, bBlank2;
   pBYTE pFld1, pFld2;
   UINT32 i;
   UINT32 iFlds = pDs1->iFields <= pDs2->iFields ? pDs1->iFields : pDs2->iFields;

   for (i = 0; i < iFlds; i++)
   {
      DSFLDDesc *pFldDes = &pDs1->pFieldDesc[i];
      if (pFldDes->bCalculated)
      {
         goto Same;
      }
      if ((pFldDes->iFldAttr & fldAttrLINK) || pFldDes->iFldType == fldTABLE)
      { // Cannot compare SetIDS
         goto Same;
      }

      pDs2->GetFieldPtr(iRecNo2, i+1, &pFld2, &bBlank2);
      if (bBlank2 == BLANK_NOTCHANGED)
      {
         goto Same;
      }
      pDs1->GetFieldPtr(iRecNo1, i+1, &pFld1, &bBlank1);

      if (pFldDes->iFldType == fldBLOB)
      {
         if (bCmpBlobs)
         {
            UINT32 iBlobId1, iBlobId2;

            iBlobId1 = pFld1 == NULL ? 0 : *(pUINT32)pFld1;
            iBlobId2 = pFld2 == NULL ? 0 : *(pUINT32)pFld2;
            if (iBlobId1 == iBlobId2 && pDs1 == pDs2)
               goto Same;
            else
            {
               UINT32 iBlobLen1;
               pBYTE pBlob1;

               if (iBlobId1 == 0 || iBlobId2 == 0)
                  goto NotSame; // (could be same if empty ?)
               pDs1->pDsBlobs->GetBlobInfo(iBlobId1, &iBlobLen1, &pBlob1);
               // Takes care of dsDELAYEDBIT
               if (pDs2->pDsBlobs->BlobIsSame(iBlobLen1, pBlob1, iBlobId2))
                  goto Same;
               else
                  goto NotSame;
            }
         }
         else
         {
            goto Same;
         }
      }
      else
      {
         INT32 iCmp;

         iCmp = pDs1->FldCmp(pFldDes->iFldType, pFld1, pFld2, pFldDes->iUnits1, pFldDes->iUnits2);
         if (iCmp)
         {
         NotSame:
            bEqual = FALSE;
            if (pbSame)
               pbSame[i] = FALSE;
         }
         else
         {
         Same:
            if (pbSame)
               pbSame[i] = TRUE;
         }
      }
   }
   return bEqual;
}

// Refreshes a set of 'selected' records
// This requires that we have some kind of unique key, that identifies the record
DBIResult DBIFN DSBASE::RefreshRecords(
   SAFEARRAY *pNewDataPacket, // New updated pickle
   UINT32 iRecNo, // Refresh this specific record
   ULONGP iClientData,
   pfDSReconcile pfReconcile // Callback for resolving conflicts
   )
{
   DBIResult rslt = DBIERR_NONE;
   DSBASE *pDs2 = NULL;
   UINT32 iRecNo2, iRecCnt2;
   pBYTE pRecBuf = NULL, pRecBuf2 = NULL;

   UNREFERENCED_PARAMETER(iClientData);
   UNREFERENCED_PARAMETER(pfReconcile);

   // Expand datapacket into new dataset-tree
   pDs2 = new DSBASE();
   rslt = pDs2->AppendData(pNewDataPacket, TRUE);
   if (rslt)
      goto Exit;

   iRecCnt2 = pDs2->iRecords;
   if ((iRecNo && iRecCnt2 > 1) || iRecCnt2 == 0)
   {
      rslt = DBIERR_NA;
      goto Exit;
   }

   // Get record buffers for both datasets
   rslt = GetByteBuffer(this->iRecordSize, &pRecBuf, FALSE);
   if (rslt)
      goto Exit;
   rslt = GetByteBuffer(pDs2->iRecordSize, &pRecBuf2, FALSE);
   if (rslt)
      goto Exit;

   for (iRecNo2 = 1; iRecNo2 <= iRecCnt2; iRecNo2++)
   {
      pDs2->GetRecord(iRecNo2, pRecBuf2);

      // Find record in original set, if
      if (!(iRecNo2 == 1 && iRecNo))
      {
         UINT32 iSeqNo;

         if (!pIdxDef->IdxDesc.bUnique)
         { // Must have a unique index
            rslt = DBIERR_NA;
            goto Exit;
         }
         if (pIdxDef->IdxFindKey(pIdxDef->IdxDesc.iFields, 0, pRecBuf2, TRUE, &iSeqNo) == DBIERR_NONE)
         {
            iRecNo = pIdxDef->IdxSeqNoToRecNo(iSeqNo);
         }
         { // Not found (insert ?)
         }
      }
      rslt = RefreshRec(this, pDs2, iRecNo, iRecNo2, pRecBuf, pRecBuf2, 16);
   }

Exit:
   if (pDs2)
      delete pDs2;
   if (pRecBuf)
      delete pRecBuf;
   if (pRecBuf2)
      delete pRecBuf2;
   return rslt;
}

// Refreshes a given identified record from pDsNew
// If details, calls RefreshDetails()
DBIResult DBIFN RefreshRec(
   DSBASE *pDs,
   DSBASE *pDsNew, // Dataset containing 'new values'
   UINT32 iRecNo, // Refresh this specific record
   UINT32 iRecNoNew, // from this one in pDsNew
   pBYTE pRecBuf, // Supplied record buffers (to save repeated allocations)
   pBYTE pRecBufNew,
   UINT32 iLevels // Number of levels to go down!
   )
{
   DBIResult rslt = DBIERR_NONE;
   pBOOL pbSame = NULL;
   DSAttr iAttr;

   UNREFERENCED_PARAMETER(pRecBuf);
   UNREFERENCED_PARAMETER(pRecBufNew);

   pDs->GetField(iRecNo, 0, (pBYTE) &iAttr, NULL); // Get attribute byte
   if (iAttr)
   { // Merge changes into all versions of record
      if (iAttr == dsRecModified)
      { // Get original recordno
         UINT32 iTmp;
         UINT32 iRecNoOrg = iRecNo;
         pBOOL pbSame2;
         UINT32 i;

         rslt = GetByteBuffer(2*pDs->iFields*sizeof(BOOL), (pBYTE*) &pbSame, TRUE);
         if (rslt)
            goto Exit;

         pbSame2 = pbSame + pDs->iFields; // (shares the buffer)
         // Find the original record
         while ((iTmp = pDs->pDsLog->GetPrevRecNo(iRecNoOrg)) != 0)
            iRecNoOrg = iTmp;

         if (RecordsAreEqual(pDs, iRecNoOrg, pDsNew, iRecNoNew, TRUE, pbSame2))
            goto Exit; // Nothing changed

         do
         {
            if (RecordsAreEqual(pDs, iRecNoOrg, pDs, iRecNo, TRUE, pbSame))
               break; // Should not happen!

            // Invert values
            for (i = 0; i < pDs->iFields; i++)
               pbSame[i] = !pbSame[i];
            rslt = pDs->OverWriteRecord(iRecNo, (TDSBASE*)pDsNew, iRecNoNew, 0, pbSame);
            if (rslt)
               goto Exit;
         }
         while ((iRecNo = pDs->pDsLog->GetPrevRecNo(iRecNo)) != iRecNoOrg);

      }
      else
      {
         // nothing
      }
   }
   // Overwrite the main (original) record
   rslt = pDs->OverWriteRecord(iRecNo, (TDSBASE*)pDsNew, iRecNoNew, 0, NULL);
   if (rslt)
      goto Exit;
   if (iLevels && pDs->pLinkedTables)
   {
      rslt = RefreshDetails(pDs, pDsNew, iRecNo, iRecNoNew);
   }

Exit:
   if (pbSame)
      delete pbSame;
   return rslt;
}

// Refresh the details of a master record (pDs, iRecNo), with the new ones
// (pDsNew, iRecNoNew)
DBIResult DBIFN RefreshDetails(
   DSBASE *pDs,
   DSBASE *pDsNew, // Dataset containing 'new values'
   UINT32 iRecNo, // Refresh this specific record
   UINT32 iRecNoNew // from this one in pDsNew
   )
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iRecNoSave = iRecNo;
   UINT32 i;

   if (pDs->pLinkedTables)
   {
      for (i = 0; i < pDs->pLinkedTables->iLast; i++)
      {
         UINT32 j;
         pLTABLEEntry pEntry = pDs->pLinkedTables->GetEntry(i+1);
         pLTABLEEntry pEntryNew;
         UINT32 iFieldID_SetIDM = pEntry->iFieldID_SetIDM;
         UINT32 iSetID, iSetIDNew;
         BOOL bBlank, bBlankNew;

         iRecNo = iRecNoSave; // iRecNo is changed below !
         for (j = 0; j < pDsNew->pLinkedTables->iLast; j++)
         { // Find the corresponding entry in the detail
            pEntryNew = pDsNew->pLinkedTables->GetEntry(j+1);
            if (pEntryNew->iFieldID_SetIDM == pEntry->iFieldID_SetIDM)
               break; // found it
         }
         // See if there are any details on the 'new' record.
         rslt = pDsNew->GetField(iRecNoNew, iFieldID_SetIDM, (pBYTE) &iSetIDNew, &bBlankNew);
         if (rslt)
            goto Exit;
         if (bBlankNew == BLANK_NOTCHANGED)
            continue;
         // get SetID of original
         rslt = pDs->GetField(iRecNo, iFieldID_SetIDM, (pBYTE) &iSetID, &bBlank);
         if (rslt)
            goto Exit;
         if (bBlankNew && bBlank)
         { // OverwriteRecord made the fields the same if bBlankNew != BLANK_NOTCHANGED, and there were no detailrecord (~dsDELAYEDBIT)
            if (pEntry->phCurDet)
               ((DSCursor*)(pEntry->phCurDet))->iSeqNoD--; // So that iCurrSetID will reset.
            continue;
         }
         if (iSetID & dsDELAYEDBIT)
         { // There are no current details. Details were delayed
            if (pEntry->phCurDet)
               ((DSCursor*)(pEntry->phCurDet))->iSeqNoD--; // So that iCurrSetID will reset.
            if (bBlankNew == BLANK_NULL)
            { // Does not change any indexes (happened already in Overwrite-record ?)
               rslt = pDs->PutBlank(NULL, iRecNo, iFieldID_SetIDM, BLANK_NULL);
            }
            else
            { // Append the new details
               iSetID = iSetID & (~dsDELAYEDBIT);
               rslt = AppendDetails(pEntry->pDsDet, pEntryNew, iSetID, iSetIDNew, FALSE);
               if (rslt)
                  goto Exit;

               // Now, remove all dsDELAYEDBIT's in all occurences of this record
               // Since this field is not part of any indexes (?), this shold be safe to do ?
            PutSetID:
               rslt = pDs->PutField(iRecNo, iFieldID_SetIDM, (pBYTE) &iSetID);
               if (pDs->pDsLog)
               {
                  iRecNo = pDs->pDsLog->GetPrevRecNo(iRecNo);
                  if (iRecNo)
                     goto PutSetID;
               }

            }
         }
         else
         {
            if (bBlankNew == BLANK_NULL)
            {
               // Remove all details, and set details to NULL
               // If any chanegd details, fail ?
               rslt = CancelDetails(pEntry, iSetID, TRUE);
               if (rslt)
                  goto Exit;
               pDs->PutBlank(NULL, iRecNo, iFieldID_SetIDM, BLANK_NULL);
            }
            else
            {
               // TODO: Remove current details, if any
               // rslt = CancelDetails(pEntry->pDsDet, pEntryNew, iSetID, iSetIDNew, TRUE);
               if (rslt)
                  goto Exit;
               // Append new ones
               rslt = AppendDetails(pEntry->pDsDet, pEntryNew, iSetID, iSetIDNew, TRUE);
               if (rslt)
                  goto Exit;
            }
         }
         if (rslt)
            break;
      }
   }
Exit:
   return rslt;
}

// Appends a set of details that does not exist in the
DBIResult DBIFN AppendDetails(
   DSBASE *pDsDet,
   pLTABLEEntry pEntryNew, // Entry for dataset containing 'new values'
   UINT32 iSetID, // Refresh this specific record
   UINT32 iSetIDNew, // from this one in pDsNew
   BOOL bReplace // TRUE: Replace existing, otherwise append
   )
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i, j;
   UINT iCnt;
   pUINT32 piRecNos;
   DSBASE *pDsDetNew = pEntryNew->pDsDet;
   UINT32 iRecNo, iRecNoNew;
   pBYTE pRecBuf = NULL, pRecBufNew = NULL;
   BOOL bUpdState = pDsDet->bDisableLog; // Store state
   BOOL bMustCopy = pDsDetNew->iFields != pDsDet->iFields; // 143339 - Copy flag

   UNREFERENCED_PARAMETER(bReplace);
   pDsDet->bDisableLog = TRUE;
   // Get record buffers for both datasets
   rslt = GetByteBuffer(pDsDetNew->iRecordSize, &pRecBufNew, FALSE);
   if (rslt)
      goto Exit;

   if (bMustCopy) // 143339 - only alloc pRecBuf if we needed it (was allocated, but not used)
   {
      rslt = GetByteBuffer(pDsDet->iRecordSize, &pRecBuf, FALSE);
      if (rslt)
         goto Exit;
   }
   else
      pRecBuf = pRecBufNew;

   // Return all the records in the new detail-set
   rslt = GetRowCountForSetID(pEntryNew, FALSE, iSetIDNew, &iCnt, &piRecNos);
   if (rslt)
      goto Exit;
   if (iCnt == 0)
      goto Exit; // Nothing to do
   for (i = 0; i < iCnt; i++)
   {
      // For all record in the new detail-set
      iRecNoNew = piRecNos[i];
      pDsDetNew->GetRecord(iRecNoNew, pRecBufNew);
      // Overwrite the SetId to link with the master
      pDsDetNew->PutField(pRecBufNew, pDsDetNew->iFieldID_SetIDD, (pBYTE) &iSetID);
      // If there are any details on this detail, set the delayed bit
      if (!bReplace && pDsDet->pLinkedTables)
      {
         for (j = 0; j < pDsDet->pLinkedTables->iLast; j++)
         {
            pLTABLEEntry pEntry = pDsDet->pLinkedTables->GetEntry(j+1);
            UINT32 iSetIDDet = 0;
            // BOOL    bBlankDet;

            // pDsDetNew->GetField(pRecBufNew, pEntry->iFieldID_SetIDM, (pBYTE) &iSetIDDet, &bBlankDet);
            iSetIDDet = pDsDet->iSetIDNext++; // We must get it from the original
            iSetIDDet |= dsDELAYEDBIT;
            pDsDetNew->PutField(pRecBufNew, pEntry->iFieldID_SetIDM, (pBYTE) &iSetIDDet);
         }
      }

      // Handle delayed details with internalcalc fields.
      // If there are extra (calculated) fields in pDsDet, we will need to copy the values
      // from pRecBufNew into a correctly sized buffer to call InsertRecord.
      if (bMustCopy || pDsDet->iBlobFields)
      {
         BOOL bBlank;
         pBYTE pValue;
         for (j = 0; j < pDsDetNew->iFields; j++)
         {
            pDsDetNew->GetFieldPtrB(pRecBufNew, j+1, &pValue, &bBlank);
            if (!bBlank && (pDsDetNew->pFieldDesc[j].iFldType == fldBLOB))
            {
               UINT32 iLen;
               pBYTE pBlob;
               rslt = pDsDetNew->pDsBlobs->GetBlobInfo(*(pUINT32)pValue, &iLen, &pBlob);
               if (rslt)
                  goto Exit;
               rslt = pDsDet->pDsBlobs->AddBlob(pBlob, iLen, (UINT32*)pValue);
               if (rslt)
                  goto Exit;
               pDsDet->pDsBlobs->Commit();
               pDsDet->PutField(pRecBuf, j+1, pValue);
            }
            else
               pDsDet->PutField(pRecBuf, j+1, pValue);
         }
         // Fill in the "extra" (calculated) fields with null.
         pValue = NULL;
         for (j = pDsDetNew->iFields; j < pDsDet->iFields; j++)
         {
            pDsDet->PutField(pRecBuf, j+1, pValue); // Works for blobs too!
         }
      }

      // Insert the record in the old dataset
      rslt = pDsDet->InsertRecord(pRecBuf, &iRecNo);
      if (rslt)
         goto Exit;
   }

Exit:
   if (pRecBuf && (pRecBuf != pRecBufNew)) // Only free pRecBuf if we allocated one
      delete pRecBuf;
   if (pRecBufNew)
      delete pRecBufNew;
   pDsDet->bDisableLog = bUpdState;
   return rslt;
}

DBIResult DBIFN CancelDetails(pLTABLEEntry pEntryM, // Entry for dataset containing 'new values'
   UINT32 iSetID, // Cancel details for this specific record
   BOOL bRecurse)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   UINT iCnt;
   pUINT32 piRecNos;
   DSBASE *pDsDet = pEntryM->pDsDet;
   BOOL bUpdState = pDsDet->bDisableLog; // Store state

   pDsDet->bDisableLog = TRUE;
   // Return all the records in the new detail-set
   rslt = GetRowCountForSetID(pEntryM, FALSE, iSetID, &iCnt, &piRecNos);
   if (rslt)
      goto Exit;
   if (iCnt == 0)
      goto Exit; // Nothing to do

   for (i = 0; i < iCnt; i++)
   {
      UINT32 iRecNo;
      DSAttr iAttr;
      BOOL bBlank;

      // For all record in the new detail-set
      iRecNo = piRecNos[i];

      if (pDsDet->pLinkedTables && bRecurse)
      {
         for (i = 0; i < pDsDet->pLinkedTables->iLast; i++)
         {
            BOOL bBlank;
            UINT32 iSetID;
            pLTABLEEntry pEntry = pDsDet->pLinkedTables->GetEntry(i+1);
            UINT32 iFieldID_SetIDM = pEntry->iFieldID_SetIDM;

            rslt = pDsDet->GetField(iRecNo, iFieldID_SetIDM, (pBYTE) &iSetID, &bBlank);
            if (rslt)
               goto Exit;
            rslt = CancelDetails(pEntry, iSetID, TRUE);
            if (rslt)
               goto Exit;
         }
      }

      pDsDet->GetField(iRecNo, FIELD_ATTR, (pBYTE) &iAttr, &bBlank);
      if (iAttr)
      {

      }
      else
      {
         // Delete in order to maintain indexes, aggs.
         // (this action is not logged)
         rslt = pDsDet->DeleteRecord(iRecNo);
         if (rslt)
            goto Exit;
         // Now remove it!
         rslt = pDsDet->MakeUnused(iRecNo);
         if (rslt)
            goto Exit;
      }
   }

Exit:
   pDsDet->bDisableLog = bUpdState;
   return rslt;
}

DBIResult DBIFN GetRowReq(DSCursor *pCur, ROWREQ *pRowReq, BOOL bKeysOnly, pUINT32 piLevels)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iLevels = 1;
   DSCursor *hCurTmp = pCur;
   UINT32 iRecNoCur;
   UINT32 iDetID = 0;

   // Fill out a RowRequest for each level above the current level
   while (hCurTmp)
   {
      pRowReq->pDs = hCurTmp->pDs;
      rslt = hCurTmp->GetRecordNumber(&iRecNoCur);
      if (rslt)
         goto Exit;
      if (pRowReq->pDs && pRowReq->pDs->pDsLog)
      {
         UINT32 iRecNoOrg = 0;
         pRowReq->pDs->pDsLog->GetOrgUpd(iRecNoCur, &iRecNoOrg);
         if (iRecNoOrg)
            iRecNoCur = iRecNoOrg;
      }
      pRowReq->iRowNo = iRecNoCur;
      if (iDetID && hCurTmp->pDs->pLinkedTables)
      {
         LTABLEEntry *pEntry = hCurTmp->pDs->pLinkedTables->GetEntry(iDetID);
         if (pEntry)
            pRowReq->iFieldID = pEntry->iFieldID_SetIDM;
      }

      if (bKeysOnly)
      {
         UINT32 i;
         pDSIDX pIdx = hCurTmp->pDs->pIdx;
         DSIDXDesc IdxDescTmp;
         pDSIDXDesc pIdxDescTmp = NULL;

         for (i = 0; i<hCurTmp->pDs->iIndexes; i++)
         {
            if (pIdx)
            {
               if (pIdx->IdxDesc.bUnique)
               {
                  pIdxDescTmp = &pIdx->IdxDesc;
                  break;
               }
               else
                  pIdx = pIdx->pIdxNext;
            }
            else
               break;
         }
         if (pIdxDescTmp == NULL)
         {
            hCurTmp->GetIndexDescs(TRUE, &IdxDescTmp);
            pIdxDescTmp = &IdxDescTmp;
         }
         // if (!IdxDescTmp.bUnique)
         // pIdxTmp = hCurTmp->pDs->pIdxDef;
         // Should use better way to find a unique index!
         // If Setid first field in index, we should remove it !
         pRowReq->iFields = pIdxDescTmp->iFields;
         for (i = 0; i < pIdxDescTmp->iFields; i++)
            pRowReq->piKeys[i] = (UINT16)pIdxDescTmp->iKeyFields[i];
      }
      iDetID = hCurTmp->pDs->iDetID;
      hCurTmp = hCurTmp->hCurParent;
      if (hCurTmp)
      {
         iLevels++;
         pRowReq--; // goto higher level
      }
   }
   *piLevels = iLevels;
Exit:
   return rslt;
}

#define MAXNESTEDLEVELS 16

// Creates a request packet for refreshing, delayed fetching of data
DBIResult DBIFN DSCursor::GetRowRequestPacket(BOOL bKeysOnly, BOOL bFetchAllBlobs,
   BOOL bFetchAllDetails, BOOL bInclMetaData, SAFEARRAY **ppPickle)
{
   DBIResult rslt = DBIERR_NONE;
   ROWREQ RowReq[MAXNESTEDLEVELS];
   pROWREQ pRowReq = &RowReq[MAXNESTEDLEVELS -1];
   UINT32 iLevels;
   DSBASE *pDsRoot;
   TDSBASE *pTDs;
   DSBASE *pDsClone = NULL;
   DSBASE *pDsCloneReq;
   UINT32 i, iTmpId;
   BOOL bAllocatedDS = FALSE;
   UINT32 iUpdMode;

   UNREFERENCED_PARAMETER(bKeysOnly); // Use iRemoteUpdMode instead

   if (this->pDs->iXmlMode)
   {
      rslt = DBIERR_XMLNODELAYEDFETCHING;
      goto Exit;
   }

   ZeroMem(RowReq, sizeof(RowReq));
   if (bFetchAllBlobs)
      pRowReq->iFetchBlobs = -1;
   if (bFetchAllDetails)
      pRowReq->iFetchDetails = -1;

   // Fill out a RowRequest for each level above the current level
   rslt = GetRowReq(this, pRowReq, TRUE, &iLevels);
   if (rslt)
      goto Exit;
   pRowReq -= (iLevels-1);

   // Find the root Dataset
   pDsRoot = pDs;
   while (pDsRoot->pDsParent)
      pDsRoot = pDsRoot->pDsParent;
   iUpdMode = bKeysOnly ? dsUPDMODE_KEY : pDsRoot->iRemoteUpdMode;

   if (pDsRoot->pDsReq)
   {
      pDsClone = pDsRoot->pDsReq;
      pDsClone->Reset(); // Remove all data from it!
   }
   else
   {
      // Create a cloned dataset-tree
      rslt = pDsRoot->Clone(dsPACKET_REQUEST, TRUE, TRUE, &pTDs);
      if (rslt)
         goto Exit;
      pDsClone = (DSBASE*)pTDs;
      bAllocatedDS = TRUE;
   }

   pDsClone->SetProp(dspropLOGCHANGES, FALSE);

   if (pDsClone->iFields != pRowReq->pDs->iFields || pDsClone->iRecordSize != pRowReq->pDs->iRecordSize)
   { // Could be because of a restrucure/AddField ?
      rslt = DBIERR_NA;
      goto Exit;
   }

   pDsCloneReq = pDsClone;
   // Move over datavalues according to request
   for (i = 0; i < iLevels; i++)
   {
      pBYTE pRecBuf = NULL;
      pBOOL pbIgn = NULL;
      BOOL bFetchLevel = (i == iLevels-1); // This is the level where we want to fetch from!
      UINT32 j, iRecNoClone;

      rslt = GetByteBuffer(pDsCloneReq->iRecordSize, &pRecBuf, TRUE);
      if (rslt)
         goto Exit;
      rslt = pDsCloneReq->InsertRecord(pRecBuf, &iRecNoClone);
      delete pRecBuf;

      if (rslt)
         goto Exit;
      rslt = GetByteBuffer(sizeof(BOOL)*pDsCloneReq->iFields, (ppBYTE) &pbIgn, TRUE);
      if (rslt)
         goto Exit;

      if (iUpdMode == dsUPDMODE_KEY) // If key-only
      {
         DSBASE *pDsCur = pRowReq->pDs;

         // revert values
         for (j = 0; j < pDsCloneReq->iFields; j++)
            pbIgn[j] = TRUE; //
         // Include all unique key-fields
         for (j = 0; j < pRowReq->iFields; j++)
         {
            pbIgn[pRowReq->piKeys[j] -1] = FALSE;
         }
         // Include all linking-fields to details
         if (bFetchAllDetails && pDsCur->pLinkedTables)
         {
            for (j = 0; j < pDsCur->pLinkedTables->iLast; j++)
            {
               UINT32 k;
               pLTABLEEntry pEntry = pDsCur->pLinkedTables->GetEntry(j+1);
               for (k = 0; k < pEntry->iFields; k++)
               {
                  pbIgn[pEntry->iFieldIDM[k] - 1] = FALSE;
               }
            }
         }
         // If detail, include linking field
         if (pDsCur->iFieldID_SetIDD)
            pbIgn[pDsCur->iFieldID_SetIDD -1] = FALSE;
         // If updated, include all changed fields
      }

      // Default is to include all fields (bIgn == FALSE)
      for (j = 0; j < pDsCloneReq->iFields; j++)
      {
         UINT32 iFldType = pRowReq->pDs->pFieldDesc[j].iFldType;
         switch(iFldType)
         {
         case fldTABLE:
            {
               if (bFetchLevel && bFetchAllDetails)
               {
                  pUINT32 piPtr;
                  BOOL bBlank;
                  // Only put NULL in there if it has not yet been fetched !
                  pRowReq->pDs->GetFieldPtr(pRowReq->iRowNo, j+1, (ppBYTE) &piPtr, &bBlank);
                  if (!bBlank && (*piPtr) & dsDELAYEDBIT)
                  {
                     pbIgn[j] = TRUE;
                     // Signal this is to be fetched
                     pDsCloneReq->PutBlank(NULL, iRecNoClone, j+1, BLANK_NULL);
                  }
                  else
                     goto PutDontCare;
               }
               else
               {
                  if (j+1 == pRowReq->iFieldID)
                  { // This is the one to descend into
                     pbIgn[j] = FALSE; // Get the setid
                  }
                  else
                     goto PutDontCare;
               }
            }break;
         case fldBLOB:
            {
               if (bFetchLevel && bFetchAllBlobs)
               {
                  pUINT32 piPtr;
                  BOOL bBlank;
                  // Only put NULL in there if it has not yet been fetched !
                  pRowReq->pDs->GetFieldPtr(pRowReq->iRowNo, j+1, (ppBYTE) &piPtr, &bBlank);
                  if (!bBlank && (*piPtr) & dsDELAYEDBIT)
                  {
                     pbIgn[j] = TRUE;
                     // Signal this is to be fetched
                     pDsCloneReq->PutBlank(NULL, iRecNoClone, j+1, BLANK_NULL);
                  }
                  else
                     goto PutDontCare;
               }
               else
               {
               PutDontCare:
                  pbIgn[j] = TRUE;
                  pDsCloneReq->PutBlank(NULL, iRecNoClone, j+1, BLANK_NOTCHANGED);
               }
            }break;
         default:
            {
               if (pbIgn[j]) // If set above
                  goto PutDontCare;
            }break;
         } // end switch
      } // end for each field

      rslt = pDsCloneReq->OverWriteRecord(iRecNoClone, (TDSBASE*)pRowReq->pDs, pRowReq->iRowNo, 0, pbIgn);
      delete pbIgn;
      if (rslt)
         goto Exit;
      iTmpId = pRowReq->iFieldID;
      pRowReq++;
      // Descend the cloned cursor
      if (iTmpId && pDsCloneReq->pLinkedTables)
      {
         for (j = 0; j < pDsCloneReq->pLinkedTables->iLast; j++)
         {
            pLTABLEEntry pEntry = pDsCloneReq->pLinkedTables->GetEntry(j+1);
            if (pEntry->iFieldID_SetIDM == iTmpId)
            {
               pDsCloneReq = pEntry->pDsDet;
               break;
            }
         }
      }
   } // Each level

   pDsClone->SetProp(dspropDONTINCLMETADATA, !bInclMetaData);
   rslt = pDsClone->StreamDS(ppPickle);
   if (rslt)
      goto Exit;

Exit:
   // We could hang it of Ds for future use
   if (pDsClone && bAllocatedDS)
   {
      if (rslt)
         delete pDsClone;
      else
      {
         pDsClone->Reset(); // Remove all data from it!
         pDsRoot->pDsReq = pDsClone;
      }
   }
   return rslt;
}

DBIResult DBIFN DSCursor::RefreshRecord(SAFEARRAY *pNewDataPacket // New updated pickle
   )
{
   DBIResult rslt = DBIERR_NONE;
   ROWREQ RowReq[MAXNESTEDLEVELS];
   pROWREQ pRowReq = &RowReq[MAXNESTEDLEVELS -1];
   DSBASE *pDsCurr;
   UINT32 i, iLevels;
   DSBASE *pDsRefrRoot = NULL, *pDsRefr;

   ZeroMem(RowReq, sizeof(ROWREQ)*MAXNESTEDLEVELS);

   // Create a rowreq-array
   rslt = GetRowReq(this, pRowReq, FALSE, &iLevels);
   if (rslt)
      goto Exit;
   pRowReq -= (iLevels-1);

   // Don't cache, since packet returned contains metadata,,
   pDsRefrRoot = new DSBASE(); // Could we use dsreq ?

   rslt = pDsRefrRoot->AppendData(pNewDataPacket, TRUE);
   if (rslt)
      goto Exit;

   pDsRefr = pDsRefrRoot;

   // Refresh above levels, according to refreshed package
   for (i = 0; i < iLevels; i++)
   {
      pBYTE pRecBufRefr, pRecBuf = NULL;
      BOOL bFetchLevel = (i == iLevels-1); // This is the level where we want to fetch from!
      UINT32 iRecNoRefr, iRecNo;

      pDsCurr = pRowReq->pDs;

      rslt = GetByteBuffer(pDsCurr->iRecordSize*2, &pRecBuf, TRUE);
      if (rslt)
         goto Exit;
      pRecBufRefr = pRecBuf + pDsCurr->iRecordSize;

      if (pDsRefr->iRecNoNext -1 > 1) // Not
      {
         // Find the corresponding one !
         iRecNoRefr = 2;
      }
      else
         iRecNoRefr = 1; // There should only be one record
      iRecNo = pRowReq->iRowNo;
      rslt = RefreshRec(pDsCurr, pDsRefr, iRecNo, iRecNoRefr, pRecBuf, pRecBufRefr, bFetchLevel);
      if (rslt)
         goto Exit;
      if (pRecBuf)
         delete pRecBuf;
      if (rslt)
         goto Exit;
      if (!bFetchLevel)
      {
         // get next pDsRefr
         if (pDsRefr->pLinkedTables)
         {
            pLTABLEEntry pEntry = pDsRefr->pLinkedTables->Find(pRowReq->iFieldID);
            if (!pEntry)
            {
               rslt = DBIERR_NA;
               goto Exit;
            }
            pDsRefr = pEntry->pDsDet;
         }
         pRowReq++;
      }
   } // Each level

Exit:
   if (pDsRefrRoot)
      delete pDsRefrRoot;
   return rslt;
}
