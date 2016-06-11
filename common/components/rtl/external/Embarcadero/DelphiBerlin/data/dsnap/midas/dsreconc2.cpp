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

// From dsinmem2.cpp
DBIResult DBIFN GetRowCountForSetID(pLTABLEEntry pLEntry, BOOL bRemUnused, UINT32 iSetID, pUINT piCnt,
   pUINT32 *ppiRecNos);

BOOL DBIFN RecordsAreEqual(DSBASE *pDs1, UINT32 iRecNo1, DSBASE *pDs2, UINT32 iRecNo2, BOOL bCmpBlobs, pBOOL pbSame);

// From dsrefr2.cpp
DBIResult DBIFN RefreshRec(
   DSBASE *pDs,
   DSBASE *pDsNew, // Dataset containing 'new values'
   UINT32 iRecNo, // Refresh this specific record
   UINT32 iRecNoNew, // from this one in pDsNew
   pBYTE pRecBuf, // Supplied record buffers (to save repeated allocations)
   pBYTE pRecBufNew,
   UINT32 iLevels // Number of levels to go down!
);

// From dsreconc.cpp
DBIResult RevertRecord(DSBASE *pDs, UINT32 iRecNoOrg, UINT32 iRecNo1, UINT32 iAction, BOOL bUndo);

class RECONCB
{
public:
   ULONGP iClientData;
   UINT32 iLevels; // Number of levels to this dataset
   UINT   piFieldIDs[16]; // FieldID's to navigate to this level

   UINT32 iDetCnt; // Number of details on this one
   DBIKEY iDetFlds; // FieldID's of setids in master

   class RECONCB *pDets[16];

   DSBASE *pDs;
   DSBASE *pDsDelta;
   DSBASE *pDsErr;
   DSBASE *pDsCallB;

   UINT32 iRecsInDelta;
   pUINT32 pDsRecNos; // Recnos in pDs that corresponds to recnos in DsDelta
   pDSAttr pDsAction; // Action of each record in the DsDelta
   pBOOL pbRecAccepted;
   pBOOL pbIgn; // For calls to OverWriteRecord to ignore calc fields

   pfDSReconcile_MD pfReconcile_MD;
   pBYTE pRecBuf; // Callback : modified record
   pBYTE pRecBufErr; // Callback : conflicting record
   pBYTE pRecBufUpd;  // Callback : updated record

   UINT32 iFld_DeltaRecNo;
   UINT32 iFld_ErrMes;
   UINT32 iFld_ErrResp;
   UINT32 iFld_ErrCon;
   UINT32 iFld_ErrCat;
   UINT32 iFld_ErrCode;
   UINT32 iFld_FirstField; // FieldNo of first ordinary field in errorpacket (6)

   BOOL bHasUpdate;
   BOOL bHasConflict;

   UINT32 iRecNoDelta;
   UINT32 iRecNoOrg;
   UINT32 iRecNo1;
   UINT32 iAction;

   RECONCB();

   ~RECONCB();

   DBIResult DBIFN Init(DSBASE *pDs, DSBASE *pDsErr, DSBASE *pDsDelta, DSBASE *pDsCallB, UINT32 iLevels,
      pUINT piFieldIDMs, UINT32 iFieldID, ULONGP iClientData, pfDSReconcile_MD pfReconcile_MD);

   DBIResult DBIFN MakeRecordOrg(UINT32 iRecNo, UINT32 iSetID);

   DBIResult DBIFN FinishRecord(UINT32 iRecNo, UINT32 iSetIDM);

   DBIResult DBIFN CallBack(UINT32 iErrRecs, pUINT32 piRecNos, pBOOL pbRemoteAbort);

   DBIResult DBIFN DoCallBack(UINT32 iRecNoErr, pBOOL pbLocalAbort, pBOOL pbRemoteAbort);

   DBIResult DBIFN Accept(VOID); // Make all accepted records permanent

};

typedef RECONCB *pRECONCB;

RECONCB::RECONCB()
{
   iClientData = 0;
   iLevels = 0;
   iDetCnt = 0;
   iDetFlds[0] = 0;
   pDs = NULL;
   pDsDelta = NULL;
   pDsErr = NULL;
   pDsCallB = NULL;

   iRecsInDelta = 0;
   pDsRecNos = NULL;
   pDsAction = NULL;
   pbRecAccepted = NULL;
   pfReconcile_MD = NULL;
   pRecBuf = NULL;
   pRecBufErr = NULL;
   pRecBufUpd = NULL;
   pbIgn = NULL;

   // FieldIDs of fixed fields in Error_packet
   iFld_DeltaRecNo = 1;
   iFld_ErrResp = 2;
   iFld_ErrMes = 3;
   iFld_ErrCon = 4;
   iFld_ErrCat = 5;
   iFld_ErrCode = 6;
   iFld_FirstField = 7;
}

RECONCB::~RECONCB()
{
   UINT32 i;

   if (pDsRecNos)
      delete pDsRecNos;
   if (pDsAction)
      delete pDsAction;
   if (pbRecAccepted)
      delete pbRecAccepted;
   if (pRecBuf)
      delete pRecBuf;
   if (pbIgn)
      delete pbIgn;
   if (pRecBufErr)
      delete pRecBufErr;
   if (pRecBufUpd)
      delete pRecBufUpd;

   for (i = 0; i < iDetCnt; i++)
   {
      if (pDets[i])
         delete pDets[i];
   }
}

DBIResult DBIFN RECONCB::Init(
   DSBASE *pDs,
   DSBASE *pDsErr,
   DSBASE *pDsDelta,
   DSBASE *pDsCallB,
   UINT32 iLevelsAbove,
   pUINT piFieldIDMs, // Path to master
   UINT32 iFieldIDM, // FieldID of this detail in master
   ULONGP iClientData,
   pfDSReconcile_MD
   pfReconcile_MD)
{
   DBIResult rslt = DBIERR_NONE;
   DSLOG *pLogNew = NULL;
   UINT32 i;

   this->pDs = pDs;
   this->pDsDelta = pDsDelta;
   this->pDsErr = pDsErr;
   this->pDsCallB = pDsCallB;
   this->pfReconcile_MD = pfReconcile_MD;
   this->iClientData = iClientData;
   this->iLevels = iLevelsAbove;
   if (iLevelsAbove)
   {
      for (i = 0; i < iLevelsAbove-1; i++)
      {
         piFieldIDs[i] = piFieldIDMs[i];
      }
      piFieldIDs[iLevelsAbove-1] = iFieldIDM;
   }

   iRecsInDelta = (pDsDelta) ? pDsDelta->iRecNoNext-1 : 0; // Could be 0

   // For each detial-table
   if (pDs->pLinkedTables)
   {
      for (i = 0; i < pDs->pLinkedTables->iLast; i++)
      {
         DSBASE *pDsDet = NULL;
         DSBASE *pDsErrDet = NULL;
         DSBASE *pDsDeltaDet = NULL;
         DSBASE *pDsCallBDet = NULL;
         RECONCB *pReconcDet = NULL;
         pLTABLEEntry pEntry = pDs->pLinkedTables->GetEntry(i+1);
         UINT32 iFieldIDM = pEntry->iFieldID_SetIDM;
         pDsDet = pEntry->pDsDet;
         if (pDsErr && pDsErr->pLinkedTables)
         {
            pLTABLEEntry pEntryErr = pDsErr->pLinkedTables->Find(iFieldIDM + iFld_FirstField-1);
            if (pEntryErr)
            {
               pDsErrDet = pEntryErr->pDsDet;
            }
         }
         if (pDsDelta && pDsDelta->pLinkedTables)
         {
            pLTABLEEntry pEntryDelta = pDsDelta->pLinkedTables->Find(iFieldIDM);
            if (pEntryDelta)
               pDsDeltaDet = pEntryDelta->pDsDet;
         }
         if (pDsCallB && pDsCallB->pLinkedTables)
         {
            pLTABLEEntry pEntryCallB = pDsCallB->pLinkedTables->Find(iFieldIDM);
            if (pEntryCallB)
               pDsCallBDet = pEntryCallB->pDsDet;
         }

         pReconcDet = new RECONCB();
         rslt = pReconcDet->Init(pDsDet, pDsErrDet, pDsDeltaDet, pDsCallBDet, iLevels+1, piFieldIDs, iFieldIDM,
            iClientData, pfReconcile_MD);
         if (rslt)
         {
            delete pReconcDet;
            goto Exit;
         }
         iDetFlds[iDetCnt] = (UINT16)pEntry->iFieldID_SetIDM;
         pDets[iDetCnt++] = pReconcDet;
      }
   }

   // Initialize pDsRecNos, and pDsAction
   if (iRecsInDelta)
   {
      UINT32 iCnt;

      rslt = GetByteBuffer(sizeof(UINT32)*iRecsInDelta+1, (ppBYTE) &pDsRecNos, TRUE);
      if (rslt)
         goto Exit;
      rslt = GetByteBuffer(sizeof(DSAttr)*iRecsInDelta+1, (ppBYTE) &pDsAction, TRUE);
      if (rslt)
         goto Exit;
      rslt = GetByteBuffer(sizeof(BOOL)*iRecsInDelta+1, (ppBYTE)&pbRecAccepted, TRUE);
      if (rslt)
         goto Exit;
      rslt = GetByteBuffer(pDsCallB->iRecordSize, &pRecBuf, TRUE);
      if (rslt)
         goto Exit;
      rslt = GetByteBuffer(sizeof(BOOL)*pDs->iFields, (ppBYTE)&pbIgn, TRUE);
      if (rslt)
         goto Exit;
      rslt = GetByteBuffer(pDsCallB->iRecordSize, &pRecBufErr, TRUE);
      if (rslt)
         goto Exit;
      rslt = GetByteBuffer(pDsCallB->iRecordSize, &pRecBufUpd, TRUE);
      if (rslt)
         goto Exit;

      pLogNew = new DSLOG(pDs->pDsLog->iLast, NULL);
      if (pLogNew)
      {
         pDs->pDsLog->CompactLog(pLogNew);

         iCnt = 0;
         for (i = 0; i < pLogNew->iLast; i++)
         {
            LOGENTRY *pEntry = &pLogNew->pLogEntries[i];
            if (pEntry->iRecNo2 && pEntry->iAttr == dsRecModified)
            {
               // This would have been removed when creating delta
               if (RecordsAreEqual(pDs, pEntry->iRecNo2, pDs, pEntry->iRecNo1, TRUE, NULL))
                  continue; // Not part of delta

               pDsRecNos[iCnt] = pEntry->iRecNo2;
               pDsAction[iCnt++] = dsRecOrg; // Original record in modify
            }
            if (iCnt > iRecsInDelta)
            {
               rslt = DBIERR_DATAPACKETMISMATCH; // Delta misc-match
               goto Exit;
            }
            pDsRecNos[iCnt] = pEntry->iRecNo1;
            pDsAction[iCnt++] = (DSAttr)pEntry->iAttr;
         }

         if (iCnt != iRecsInDelta)
         {
            rslt = DBIERR_DATAPACKETMISMATCH; // Delta misc-match
            goto Exit;
         }
      }

      for (i = 0; i < pDs->iFields; i++)
      {
         pbIgn[i] = pDs->pFieldDesc[i].bCalculated && !(pDs->pFieldDesc[i].iFldAttr & fldAttrLINK);
      }
   }
Exit:
   if (pLogNew)
      delete pLogNew;
   // if rslt, must call ~RECONCB() -> done at higher level..
   return rslt;
}

DBIResult DBIFN RECONCB::CallBack(UINT32 iErrRecs, // Number of error-records to process (details only)
   pUINT32 piRecNos, // These are the record numbers in the error-packet (details only)
   pBOOL pbRemoteAbort)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   BOOL bLocalAbort = FALSE;

   if (piRecNos == NULL)
      iErrRecs = pDsErr->iRecNoNext-1; // Highest level (RecNoNext is more reliable than iRecords!)

   // Main loop, each error-record
   for (i = 0; i < iErrRecs; i++)
   {
      UINT32 j;
      UINT32 iErrRecNo = piRecNos ? piRecNos[i] : i+1;

      // Create original record for this level. No links to details
      rslt = MakeRecordOrg(iErrRecNo, 1 /* iSetID */ ); // make this level
      if (rslt)
         goto Exit;

      // First fix all the details
      for (j = 0; j < iDetCnt; j++) // Do the details first
      {
         pLTABLEEntry pEntry;
         UINT iRecsDet = 0;
         // DSBASE      *pDsErrDet = NULL;
         UINT32 iSetIDM = 0;
         BOOL bBlank;
         pRECONCB pReconcDet = NULL;
         pUINT32 piRecNosDet;
         UINT32 iFieldIDMErr = (UINT32)iDetFlds[j] + iFld_FirstField-1;

         pEntry = pDsErr->pLinkedTables->Find(iFieldIDMErr);
         pDsErr->GetField(iErrRecNo, iFieldIDMErr, (pBYTE) &iSetIDM, &bBlank);
         if (!iSetIDM || bBlank || pEntry == NULL)
            continue; // No details, so proceed to the next detail

         rslt = GetRowCountForSetID(pEntry, FALSE, iSetIDM, &iRecsDet, &piRecNosDet);
         if (rslt)
            goto Exit;

         if (iRecsDet == 0)
            continue;
         pReconcDet = pDets[j];
         rslt = pReconcDet->CallBack(iRecsDet, piRecNosDet, pbRemoteAbort);
         if (rslt)
            goto Exit;
         if (*pbRemoteAbort)
            goto Exit;
      }

      rslt = FinishRecord(iErrRecNo, 1); // Make this level
      if (rslt)
         goto Exit;

      // Empty pDsCallB at this level
      rslt = DoCallBack(iErrRecNo, &bLocalAbort, pbRemoteAbort);
      if (*pbRemoteAbort)
         goto Exit;
   }

Exit:
   return rslt;
}

// Move original record into dataset, if any.
// Should link to master above
DBIResult DBIFN RECONCB::MakeRecordOrg(UINT32 iRecNoErr, UINT32 iSetIDM)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iRecNoCallB, i;
   BOOL bBlank;

   pDsCallB->Reset(); // Empty it  (also empties all details..)

   iRecNoDelta = 0;
   iRecNoOrg = 0;
   iRecNo1 = 0;
   iAction = 0; // del/mod/ins

   rslt = pDsErr->GetField(iRecNoErr, iFld_DeltaRecNo, (pBYTE) &iRecNoDelta, &bBlank);
   if (rslt)
      goto Exit;
   if (bBlank || iRecNoDelta == 0 || iRecNoDelta > iRecsInDelta)
   {
      rslt = DBIERR_DATAPACKETMISMATCH; // Invalid error-packet
      goto Exit;
   }

   bHasConflict = FALSE;
   bHasUpdate = FALSE;
   iAction = pDsAction[iRecNoDelta -1];
   if (iAction == dsRecModified) // get original record fro pDs
   {
      iAction = dsRecOrg;
      iRecNoOrg = pDsRecNos[iRecNoDelta-2];
      iRecNo1 = pDsRecNos[iRecNoDelta-1];
      bHasUpdate = TRUE;
   }
   else
      iRecNoOrg = pDsRecNos[iRecNoDelta-1];

   if (pDsCallB)
   {
      UINT32 iAux = 0;
      pDsCallB->PutField(pRecBuf, 0, (pBYTE) &iAux);
      for (i = 0; i < pDsCallB->iFields; i++)
         pDsCallB->PutBlank(pRecBuf, 0, i+1, BLANK_NOTCHANGED);
      // Initialize linkfield to master, if any
      if (pDs->iFieldID_SetIDD)
         pDsCallB->PutField(pRecBuf, pDs->iFieldID_SetIDD, (pBYTE) &iSetIDM);

      pDsCallB->bDisableLog = TRUE;
      pDsCallB->InsertRecord(pRecBuf, &iRecNoCallB);
      pDsCallB->bDisableLog = FALSE;
      pDsCallB->OverWriteRecord(iRecNoCallB, (TDSBASE*)pDs, iRecNoOrg, 0, NULL);

      pDsCallB->PutField(iRecNoCallB, 0, (pBYTE) &iAction); // Write action

      // Initialize linkfield to master, if any (always 1)
      if (pDs->iFieldID_SetIDD)
         pDsCallB->PutField(iRecNoCallB, pDs->iFieldID_SetIDD, (pBYTE) &iSetIDM);
      // Fill in all linking fields for details, if any
      for (i = 0; i < iDetCnt; i++)
         pDsCallB->PutField(iRecNoCallB, (UINT32)iDetFlds[i], (pBYTE) &iSetIDM);
   }

Exit:
   return rslt;
}

// Take care of second record (modify), and conflicting record, if any
// If a conflicting error, and err_no == DBIERR_NONE, treat it as a refresh
// Should unlink any details
DBIResult DBIFN RECONCB::FinishRecord(UINT32 iRecNoErr, UINT32 iSetIDM)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iRecNoCallB;
   UINT32 i;
   BOOL bBlank;
   BOOL bBlankFirst;

   // Stub out any linking field in original record
   for (i = 0; i < iDetCnt; i++)
      pDsCallB->PutBlank(NULL, 1, (UINT32)iDetFlds[i], BLANK_NOTCHANGED);

   // Initialize updated record, if any
   if (bHasUpdate)
   {
      UINT32 iAux = 0;
      iAction = dsRecModified;

      // Reset recordbuffer
      pDsCallB->PutField(pRecBuf, 0, (pBYTE) &iAux);
      for (i = 0; i < pDsCallB->iFields; i++)
         pDsCallB->PutBlank(pRecBuf, 0, i+1, BLANK_NOTCHANGED);
      // Initialize linkfield to master, if any
      if (pDs->iFieldID_SetIDD)
         pDsCallB->PutField(pRecBuf, pDs->iFieldID_SetIDD, (pBYTE) &iSetIDM);

      pDsCallB->bDisableLog = TRUE;
      pDsCallB->InsertRecord(pRecBuf, &iRecNoCallB); // == 2
      pDsCallB->bDisableLog = FALSE;
      pDsCallB->OverWriteRecord(iRecNoCallB, (TDSBASE*)pDsDelta, iRecNoDelta, 0, NULL);
      pDsCallB->PutField(iRecNoCallB, 0, (pBYTE) &iAction);

      pDsCallB->GetRecord(iRecNoCallB, pRecBufUpd); // Get the updated record
   }

   // Initialize conflicting record, if any
   for (i = iFld_FirstField-1; i < pDsErr->iFields; i++)
   { // Check if conflicting record
      pBYTE pVal;
      UINT32 iFldType = pDsErr->pFieldDesc[i].iFldType;
      if (iFldType == fldTABLE) // jul-99
         continue; // Blobs ?
      pDsErr->GetFieldPtr(iRecNoErr, i+1, &pVal, &bBlank);
      if (i == iFld_FirstField-1)
      {
         // Disregard if all fields are blanks (of the same kind!)
         if (bBlank)
            bBlankFirst = bBlank;
         else
         {
            // Linking field ?
            bHasConflict = TRUE;
            break;
         }
      }
      else
      {
         if (bBlank != bBlankFirst) // Some change!
         {
            // Linking field ?
            bHasConflict = TRUE;
            break;
         }
      }
   }

   if (bHasConflict)
   {
      UINT32 iAux = 0;

      pDsCallB->PutField(pRecBuf, 0, (pBYTE) &iAux);
      for (i = 0; i < pDsCallB->iFields; i++)
         pDsCallB->PutBlank(pRecBuf, 0, i +1, BLANK_NOTCHANGED);
      if (pDs->iFieldID_SetIDD)
         pDsCallB->PutField(pRecBuf, pDs->iFieldID_SetIDD, (pBYTE) &iSetIDM);

      pDsCallB->bDisableLog = TRUE;
      pDsCallB->InsertRecord(pRecBuf, &iRecNoCallB); // == 3
      pDsCallB->bDisableLog = FALSE;
      pDsCallB->OverWriteRecord(iRecNoCallB, (TDSBASE*)pDsErr, iRecNoErr, 6, NULL);
      // Initialize linkfield to master, if any

      if (pDs->iFieldID_SetIDD)
         pDsCallB->PutField(iRecNoCallB, pDs->iFieldID_SetIDD, (pBYTE) &iSetIDM);
      pDsCallB->GetRecord(iRecNoCallB, pRecBufErr); // Get the conflicting error record
   }

   pDsCallB->GetRecord(1, pRecBuf); // Get the original record

   return rslt;
}

// Get all error_info, and do the callback, if any
DBIResult DBIFN RECONCB::DoCallBack(UINT32 iRecNoErr, pBOOL pbLocalAbort, pBOOL pbRemoteAbort)
{
   DBIResult rslt = DBIERR_NONE;
   BOOL bBlank;
   dsCBRType eReconc;
   UINT32 iErrCode;
   UINT32 iErrCategory;
   dsCBRType iErrResponse;
   pCHAR pErrMessage; //
   pCHAR pErrContext; //
   pBYTE pRecUpd = NULL, pRecConflict = NULL, pRecOrg = NULL;

   // Get error information, if any
   pDsErr->GetField(iRecNoErr, iFld_ErrCode, (pBYTE) &iErrCode, &bBlank);
   if (bBlank)
      iErrCode = 0;
   pDsErr->GetField(iRecNoErr, iFld_ErrResp, (pBYTE) &iErrResponse, &bBlank);
   if (bBlank)
      iErrResponse = 0;
   pDsErr->GetField(iRecNoErr, iFld_ErrCat, (pBYTE) &iErrCategory, &bBlank);
   if (bBlank)
      iErrCategory = 0;
   pDsErr->GetFieldPtr(iRecNoErr, iFld_ErrMes, (ppBYTE) &pErrMessage, &bBlank);
   pDsErr->GetFieldPtr(iRecNoErr, iFld_ErrCon, (ppBYTE) &pErrContext, &bBlank);

   if (iErrCode == 0)
   {
      if (bHasConflict && iAction && iAction!= dsDetUpd)
      { // This is not an error, refresh updated record instead
         if (bHasUpdate)
            rslt = pDs->OverWriteRecord(iRecNo1, (pTDSBASE)pDsCallB, 3, 0, pbIgn);
         else
            rslt = pDs->OverWriteRecord(iRecNoOrg, (pTDSBASE)pDsCallB, 2, 0, pbIgn);
      }
      goto Exit; // Accept;
   }

   if (bHasUpdate)
   {
      pRecOrg = pRecBuf;
      pRecUpd = pRecBufUpd;
   }
   else
   { // Delete/insert
      pRecUpd = pRecBuf;
   }

   if (bHasConflict)
   {
      pRecConflict = pRecBufErr;
   }

   rslt = DBIERR_NONE;
   if (iErrResponse == dscbrABORT)
      *pbRemoteAbort = TRUE;

   // Call reconcile callback
Again:
   if (!(*pbLocalAbort) && pfReconcile_MD)
   {
      eReconc = pfReconcile_MD(iClientData,
         (UINT)rslt, // Last error
         (DSAttr)iAction,
         iErrResponse,
         iErrCode,
         pErrMessage,
         pErrContext,
         pRecUpd,
         pRecOrg,
         pRecConflict,
         iLevels,
         piFieldIDs);
   }
   else
   { // Default action in case of no callback.
      eReconc = dscbrSKIP;
   }

   // Take action
   if (eReconc == dscbrABORT)
   { // Abort reconcile session, but we need to continue through
      // trouble records, so we can make succeded records permanent.
      *pbLocalAbort = TRUE;
      eReconc = dscbrSKIP; //
   }

   if (pDs->pDsLog == NULL || pDs->pDsLog->iLast == 0)
      goto Exit;

   switch(eReconc)
   {
   case dscbrCANCEL:
      { // Revert record back to original
         // This action can NOT be undone
         if (iRecNo1 == 0)
         { // Delete and New
            rslt = RevertRecord(pDs, 0, iRecNoOrg, iAction, TRUE);
         }
         else
         {
            rslt = RevertRecord(pDs, iRecNoOrg, iRecNo1, iAction, TRUE);
         }
      }break;

   case dscbrCORRECT:
      { // This action can NOY be undone (anymore)
         if (bHasUpdate)
         { //
            UINT32 iRecNoUpd = 2; // This is the updated record in pDsCAllB. If a new copy was created, it is record 3 or 4

            // Note : Old code would do a modify record, allowing for undo
            rslt = pDsCallB->OverWriteRecord(iRecNoUpd, pRecUpd, TRUE);
            if (rslt)
               goto Exit;
            rslt = pDs->OverWriteRecord(iRecNo1, (pTDSBASE)pDsCallB, iRecNoUpd, 0, NULL);
         }
         else
         {
            if (iAction == dsRecNew)
            {
               UINT32 iRecNoUpd = 1;

               rslt = pDsCallB->OverWriteRecord(iRecNoUpd, pRecUpd, TRUE);
               if (rslt)
                  goto Exit;
               // Overwrite the record in the dataset
               rslt = pDs->OverWriteRecord(iRecNoOrg, (pTDSBASE)pDsCallB, iRecNoUpd, 0, NULL);
            }
            else
               rslt = DBIERR_INVALIDPARAM;
         }
      }break;

   case dscbrMERGE:
      { // This action can NOT be undone
         if (bHasConflict && bHasUpdate)
         {
            UINT32 iRecNoUpd = 2;
            UINT32 iRecNoConf = 3;

            // Refresh all occurences of record with 'conflict' record. Keep all
            // changed values.
            // Should we revert the record ?
            rslt = RefreshRec(pDs, pDsCallB, iRecNo1, iRecNoConf, NULL, NULL, 0);
            if (!rslt)
            { // Should we update, in case user corrected the update record ?

               rslt = pDsCallB->OverWriteRecord(iRecNoUpd, pRecUpd, TRUE);
               if (rslt)
                  goto Exit;
               rslt = pDs->OverWriteRecord(iRecNo1, (pTDSBASE)pDsCallB, iRecNoUpd, 0, NULL);
            }
         }
         else
         { // Insert failed, if keyviolation, the record already exists on server
            // Could convert it to a modify on a permanent record!
            if (bHasConflict && iAction == dsRecNew && iErrCode == DBIERR_KEYVIOL)
            {
               UINT32 iRecNoConf = 2;
               rslt = RevertRecord(pDs, iRecNoOrg, 0, iAction, (iAction != dsRecNew));
               if (rslt)
                  break;
               // Overwrite record directly without involving the log
               rslt = pDs->OverWriteRecord(iRecNoOrg, (pTDSBASE)pDsCallB, iRecNoConf, 0, NULL);
            }
            else
            {
               rslt = DBIERR_INVALIDPARAM;
            }
         }
      }break;

   case dscbrREFRESH:
      { // This action can NOT be undone
         // Revert to original, then overwrite it.
         // It actually removes the actions from the log ?
         if (bHasConflict && bHasUpdate)
         {
            UINT32 iRecNoConf = 3;

            rslt = RevertRecord(pDs, iRecNoOrg, iRecNo1, iAction, (iAction != dsRecNew));
            if (rslt)
               break;
            // Overwrite record directly without involving the log
            rslt = pDs->OverWriteRecord(iRecNoOrg, (pTDSBASE)pDsCallB, iRecNoConf, 0, NULL);

         }
         else
         { // Insert failed, if keyviolation, refresh record
            if (bHasConflict /* && iAction == dsRecNew && iErrCode == DBIERR_KEYVIOL */ )
            {
               UINT32 iRecNoConf = 2;

               rslt = RevertRecord(pDs, iRecNoOrg, iRecNoOrg, iAction, (iAction != dsRecNew));
               if (rslt)
                  break;
               rslt = pDs->OverWriteRecord(iRecNoOrg, (pTDSBASE)pDsCallB, iRecNoConf, 0, NULL);
            }
            else
               rslt = DBIERR_INVALIDPARAM;
         }
      }break;

   case dscbrSKIP:
      { // Do nothing, keep in log
         rslt = DBIERR_NONE;
      }break;
   } // End switch

   if (rslt)
   {

      goto Again;
   }

   // Accept:
   pbRecAccepted[iRecNoDelta-1] = TRUE;
   if (bHasUpdate) // iAction == dsRecModified)
      pbRecAccepted[iRecNoDelta-2] = TRUE;

   if (*pbRemoteAbort)
      goto Exit;

Exit:
   return rslt;
}

DBIResult DBIFN RECONCB::Accept(VOID)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 j, i;

   // First Accept all the details
   for (j = 0; j < iDetCnt; j++) // Do the details first
   {
      pRECONCB pReconcDet = NULL;

      pReconcDet = pDets[j];
      rslt = pReconcDet->Accept();
      if (rslt)
         goto Exit;
   }

   // For all accepted records, make the records permanent
   if (iRecsInDelta)
   {
      pUINT32 piRecs = new UINT32[pDs->pDsLog->iLast +1];

      for (i = 0; i < iRecsInDelta; i++)
      {
         if (!pbRecAccepted[i])
         { // Make change permanent
            UINT32 iCnt = 0;
            UINT32 iAction;
            UINT32 iRecNo1 = 0, iRecNoOrg = 0;

            iAction = pDsAction[i];
            if (iAction == dsDetUpd)
               continue;
            iRecNo1 = pDsRecNos[i];
            if (iAction == dsRecOrg)
            {
               iAction = pDsAction[++i];
               iRecNoOrg = iRecNo1;
               iRecNo1 = pDsRecNos[i];
            }

            if (pDs->pDsLog->RemoveAction((DSAttr)iAction, (iRecNoOrg && iAction == dsRecModified)
                  ? iRecNoOrg : iRecNo1, &iCnt, piRecs, NULL) == DBIERR_NONE)
            {
               // How do we keep master-logs in sync with this ?
               if (iCnt > 0)
               {
                  UINT32 j;
                  for (j = 0; j < iCnt; j++)
                  {
                     UINT32 iNo = piRecs[j];
                     if ((pDs->piAttr[iNo-1] & dsISNOTVISIBLE))
                        pDs->MakeUnused(iNo); // Make records unused
                     else
                        pDs->piAttr[iNo-1] = 0; // Remove attribute state
                  }
               }
            }
         }
      }
      delete[] piRecs;
   } // End if pDsLog->iLast

Exit:
   return rslt;
}

DBIResult DBIFN DSBASE::Reconcile_MD(
   class TDSBASE *pTDsCallB, // Ds for callback info
   SAFEARRAY *pDeltaPickle, // Delta pickle
   SAFEARRAY *pErrorPickle, // NULL if all changes accepted
   ULONGP iClientData,
   pfDSReconcile_MD
   pfReconcile_MD // Callback-fn (called for each error)
   )
{
   DBIResult rslt = DBIERR_NONE;
   RECONCB *pReconc = NULL;
   DSBASE *pDsCallB = (DSBASE*)pTDsCallB;
   DSBASE *pDsErr = NULL;
   DSBASE *pDsDelta = NULL;
   BOOL bRemoteAbort = FALSE;

   if (bDelta)
   { // (XML case)
      goto Exit;
   }

   if (pErrorPickle)
   {
      if (pDeltaPickle == NULL)
      { // There must be a delta pickle!
         rslt = DBIERR_INVALIDPARAM; // Invalid combination
         goto Exit;
      }
      pDsDelta = new DSBASE();
      pDsErr = new DSBASE();
      rslt = pDsDelta->AppendData(pDeltaPickle, TRUE);
      if (rslt)
         goto Exit;
      rslt = pDsErr->AppendData(pErrorPickle, TRUE);
      if (rslt)
         goto Exit;

      pReconc = new RECONCB();
      rslt = pReconc->Init(this, pDsErr, pDsDelta, pDsCallB, 0, NULL, 0, iClientData, pfReconcile_MD);
      if (rslt)
         goto Exit;

      // Do all error-callbacks
      rslt = pReconc->CallBack(0, NULL, &bRemoteAbort);
      if (rslt)
         goto Exit;

      if (bRemoteAbort)
      { // Do not do the accept-step

         goto Exit;
      }

      rslt = pReconc->Accept();
      if (rslt)
         goto Exit;

   }
   else
   { // No error-pickle, accept all changes
      // Accept, using log, on all levels
      UINT32 iMax, iLoops;
      pUINT32 piRecs;
      UINT32 i;

      if (pLinkedTables)
      {
         for (i = 0; i < pLinkedTables->iLast; i++)
         {
            pLTABLEEntry pEntry = pLinkedTables->GetEntry(i+1);
            rslt = pEntry->pDsDet->Reconcile_MD(NULL, NULL, NULL, 0, NULL);
            if (rslt)
               break;
         }
      }
      if (rslt)
         goto Exit;

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

         if (pDsLog->RemoveAction(iAction, (iRecNoOrg && iAction == dsRecModified)? iRecNoOrg : iRecNo1, &iCnt, piRecs,
               NULL) == DBIERR_NONE)
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
                  {
                     // UINT32 k;
                     piAttr[iNo-1] = 0; // Remove attribute state (new f.ex.)
                  }
               }
            }
         }
      } // End while
      delete[] piRecs;
      if (pIdxChg)
      { // Readjust change-index
         pIdxChg->IdxCreateOrder(NULL, NULL);
      }
   }

Exit:
   if (pDsErr)
      delete pDsErr;
   if (pDsDelta)
      delete pDsDelta;
   if (pReconc)
      delete pReconc;
   return rslt;
}
