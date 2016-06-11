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

DBIResult DBIFN DSCursor::LinkCursors(UINT32 iFieldsLink, pUINT32 piFieldsM, // Fields in Master
   pUINT32 piFieldsD, // Fields in Detail
   TDSCursor *hCurDetIn // Detail cursor to link (assumes current index at least includes these)
)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   DSCursor *hCurDet = (DSCursor*)hCurDetIn;
   DSBASE *pDsDet;
   pLTABLEEntry pEntry;

   DSLOCK(pDs);

   // make sure that current index has all link fields
   if (iFieldsLink > hCurDet->pIdx->IdxDesc.iFields)
   {
      rslt = DBIERR_OUTOFRANGE;
      goto Exit;
   }

   pDsDet = hCurDet->pDs;
   for (i = 0; i < iFieldsLink; i++)
   {
      if (piFieldsD[i] != hCurDet->pIdx->IdxDesc.iKeyFields[i])
      {
         rslt = DBIERR_OUTOFRANGE;
         goto Exit;
      }
   }

   // Link tables together
   if (pDs->pLinkedTables == NULL)
      pDs->pLinkedTables = new LTABLEList(pDs);

   // FieldID of master not known yet
   if (iFieldsLink > 0)
   {
      rslt = pDs->pLinkedTables->Link_Fields(pDsDet, iFieldsLink, piFieldsM, piFieldsD, &pDsDet->iDetID);
      if (rslt)
         goto Exit;
   }

   pEntry = pDs->pLinkedTables->GetEntry(pDsDet->iDetID);
   // Only set the pEntry->phCurDet if not already set to something else for delete after clone case
   if (pEntry->phCurDet == NULL)
      pEntry->phCurDet = (pVOID)hCurDet; // Link detailcursor to master
   pDsDet->pDsParent = pDs;
   hCurDet->hCurParent = this; // Link mastercursor to detail

   // (in case not already done)
   this->pDs->iMDSemantics |= mdMASTER;
   pDsDet->iMDSemantics |= mdDETAIL;

Exit:

   DSUNLOCK(pDs);
   return rslt;
}

// Resync detail with master record
// If this is a detail, reset range according to master, if master position changed.
DBIResult DBIFN DSCursor::ResyncWithMaster(VOID)
{
   DBIResult rslt = DBIERR_NONE;

   if (hCurParent)
   {
      UINT32 iRangeFields;
      hCurParent->ResyncWithMaster(); // Recurse backwards
      if (iSeqNoD == hCurParent->iSeqNoM)
         goto Exit;
      rslt = hCurParent->GetDetailKey(pDs->iDetID, pBaseRecBuf, FALSE, &iCurrSetID, NULL, NULL);
      if (rslt) // || !bChanged)
      {
         if (rslt == DBIERR_BOF || rslt == DBIERR_EOF || rslt == DBIERR_RECDELETED || rslt == DBIERR_NOCURRREC)
         {
            iCurState = DBIERR_NOCURRREC;
            rslt = (DBIResult)iCurState;
            iCurLast = iCurFirst = 0; // Invalidate range (check this)
         }
         goto Exit;
      }
      iRangeFields = pDs->iFieldID_SetIDD != 0 ? -1 : pDs->iLinkFields;
      // NOTE: -1 instead of 1, special signal to avoid recursion!
      rslt = SetRange(iRangeFields, pBaseRecBuf, TRUE, pBaseRecBuf, TRUE);
      if (rslt)
         goto Exit;
      iSeqNoD = hCurParent->iSeqNoM;
   }
Exit:
   return rslt;
}

// Get link field(s) from master
DBIResult DBIFN DSCursor::GetDetailKey(UINT32 iDetID, //
   pBYTE pRecBufDet, BOOL bKeyOnly, // If TRUE, returns key only, otherwise overwrites linkfields!
   pUINT32 piSetID, pUINT32 piRecNoM, // RecNo of master !
   pUINT32 piFieldIDM // FieldID of linking field
   )
{
   DBIResult rslt = DBIERR_NONE;

   if (pDs->pLinkedTables)
   {
      pLTABLEEntry pEntry = pDs->pLinkedTables->GetEntry(iDetID);
      DSBASE *pDsDet = pEntry->pDsDet;
      UINT32 iRecNoM;
      UINT32 i;
      pBYTE pFldBuf;
      BOOL bBlank;

      if (piSetID)
         *piSetID = 0;

      // ResyncWithMaster(); // Make sure this master is in sync with its master (if any) -- Causes a loop.
      rslt = GetRecordNumber(&iRecNoM);
      if (rslt)
         goto Exit;
      if (piRecNoM)
         *piRecNoM = iRecNoM;
      if (piFieldIDM)
         *piFieldIDM = pEntry->iFieldID_SetIDM;
      if (pEntry->iFieldID_SetIDM)
      {
         pDs->GetFieldPtr(iRecNoM, pEntry->iFieldID_SetIDM, &pFldBuf, &bBlank);
         if (piSetID)
         {
            *piSetID = bBlank ? 0 : *(pUINT32)pFldBuf; // Propagate SetID back to detail
         }
         if (pRecBufDet)
         {
            // bBlank not allowed!
            if (bKeyOnly)
            {
               UINT32 iFldLen = pDsDet->pFieldDesc[pDsDet->iFieldID_SetIDD-1].iFldLen;
               CopyMem(pRecBufDet, pFldBuf, iFldLen);
               pRecBufDet += iFldLen;
            }
            else
            {
               pDsDet->PutField(pRecBufDet, pDsDet->iFieldID_SetIDD, pFldBuf);
            }
         }
      }
      if (pRecBufDet)
      {
         // Should clear the recordbuffer
         for (i = 0; i < pEntry->iFields; i++)
         { // Get all link fields in master
            pDs->GetFieldPtr(iRecNoM, pEntry->iFieldIDM[i], &pFldBuf, &bBlank);
            if (bBlank)
            { // Should we allow this?
            }
            else
            {
               if (bKeyOnly)
               {
                  UINT32 iFldLen = pDsDet->pFieldDesc[pDsDet->piLinkField[i]-1].iFldLen;
                  CopyMem(pRecBufDet, pFldBuf, iFldLen);
                  pRecBufDet += iFldLen;
               }
               else
               {
                  pDsDet->PutField(pRecBufDet, pDsDet->piLinkField[i], pFldBuf);
               }
            }
         }
      }
   }
Exit:
   return rslt;
}

// Called from detail to insert log in masters log
// We might need to store the recno of the detail as well
DBIResult DBIFN DSCursor::GlobalUpdateNotify(UINT32 iDetID)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iRecNoM;

   rslt = GetRecordNumber(&iRecNoM);
   if (rslt)
      goto Exit;

   if (!pDs->bDisableLog)
   {
      if (pDs->pDsLog == NULL)
         pDs->pDsLog = new DSLOG(3, pDs);
      pDs->pDsLog->GetOrgUpd(iRecNoM, &iRecNoM);
      pDs->pDsLog->AddToLog(iRecNoM, iDetID, dsDetUpd, 0); // First identify master-record
   }

   if (hCurParent) // If this is itself a detail
   {
      rslt = hCurParent->GlobalUpdateNotify(this->pDs->iDetID);
   }
Exit:
   return rslt;
}

DBIResult DBIFN DSCursor::GlobalLogUndo(UINT32 iDetID, UINT32 iCntD // 0: last. Relates to 'iCnt'th last detail upd to this detail!
   )
{
   DBIResult rslt = DBIERR_NONE;

   UNREFERENCED_PARAMETER(iDetID);
   UNREFERENCED_PARAMETER(iCntD);
   return rslt;
}
