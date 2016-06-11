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
#include "dsconst.h"

DBIResult MoveRecord(DSBASE *pDs, pBYTE pRecBuf, UINT32 iRecNo, DSAttr iAttr, DSBASE *pDsDelta, pBOOL pbSame);
DBIResult DBIFN CreateEmptyDelta(DSBASE *pDs, DSBASE **ppDsDelta);

// From curupd.cpp
DBIResult DBIFN LinkFieldsCascade(DSBASE *pDsM, pLTABLEEntry pEntry, UINT32 iSetID, UINT32 iRecNoM, BOOL bFromDelta);

// From dsinmem2.cpp
DBIResult DBIFN InitEmbeddedTable(DSBASE * pDs, DSBASE * pDsDet, UINT32 iFieldID_M // Master fieldID
);

DBIResult DBIFN DSBASE::GetDelta( // Extract delta from ds, as delta
   pBYTE *ppDsDelta)
{
   DBIResult rslt;
   DSBASE *pDsDelta = NULL;
   DSLOG *pLogNew = NULL;
   pBYTE pRecBuf = NULL;
   UINT32 i;
   pBOOL pbSame = NULL;

   LOCK();

   if (bDelta) // this is itself a delta (XML-case)
   {
      *ppDsDelta = (pBYTE)this;
      AddRef();
      return 0;
   }

   if (pDsLog == NULL)
   {
      rslt = DBIERR_DELTAISEMPTY;
      goto Exit;
   }
   pLogNew = new DSLOG(pDsLog->iLast, NULL);
   pRecBuf = new BYTE[iRecordSize];

   if (pDsLog->CompactLog(pLogNew) || pLogNew->iLast == 0)
   {
      rslt = DBIERR_DELTAISEMPTY;
      goto Exit;
   }

   pbSame = new BOOL[iFields];
   ZeroMem(pbSame, sizeof(BOOL)*iFields);

   rslt = CreateEmptyDelta(this, &pDsDelta);
   if (rslt)
      goto Exit;

   // Main loop, move records
   for (i = 0; i < pLogNew->iLast; i++)
   {
      DSAttr iAttr;
      UINT32 iRecNo;
      LOGENTRY *pLogEntry = &pLogNew->pLogEntries[i];

      if (pLogEntry->iAttr == dsRecModified)
      {
         if (RecsEqual(pLogEntry->iRecNo2, pLogEntry->iRecNo1, TRUE, pbSame))
            continue; // Changes were canceled out
      }
      if (pLogEntry->iAttr == dsRecModified)
      {
         iAttr = dsRecOrg;
         iRecNo = pLogEntry->iRecNo2;
      }
      else
      {
         iAttr = (DSAttr)pLogEntry->iAttr;
         iRecNo = pLogEntry->iRecNo1;
      }
      rslt = MoveRecord(this, pRecBuf, iRecNo, iAttr, pDsDelta, NULL);
      if (rslt)
         break;
      if (iAttr == dsRecOrg)
      {
         iAttr = dsRecModified;
         rslt = MoveRecord(this, pRecBuf, pLogEntry->iRecNo1, iAttr, pDsDelta, pbSame);
         if (iFieldID_SetIDD) // && !pbSame[iFieldID_SetIDD-1])
         { // Detail fly away, we need to make sure the SetID is the same!
            UINT32 iSetID;
            BOOL bBlank;
            GetField(iRecNo, iFieldID_SetIDD, (pBYTE) &iSetID, &bBlank);
            // This is the just created record in the delta
            pDsDelta->PutField(pDsDelta->iRecNoNext-1, iFieldID_SetIDD, (pBYTE) &iSetID);
         }
      }
   } // end for

   if (pDsDelta && pDsDelta->iRecords == 0)
   { // None was added
      rslt = DBIERR_DELTAISEMPTY;
      goto Exit;
   }

LinkDetails:

   if (pLinkedTables)
   {

      for (i = 0; i < pLinkedTables->iLast; i++)
      {
         DSBASE *pDsDet = NULL;
         DSBASE *pDsDetDelta = NULL;
         pLTABLEEntry pEntry = pLinkedTables->GetEntry(i+1);

         pDsDet = pEntry->pDsDet;
         if (pDsDet != NULL && pDsDet->GetDelta((ppBYTE) &pDsDetDelta) == DBIERR_NONE)
         { // Link it to this delta!
            rslt = InitEmbeddedTable(pDsDelta, pDsDetDelta, pEntry->iFieldID_SetIDM);
            if (rslt)
            {
               delete pDsDelta;
               goto Exit;
            }

            // Inherit MD_links, if any
            if (pEntry->iFields> 0)
            {
               UINT32 j;
               UINT32 piM[16], piD[16];
               for (j = 0; j < pEntry->iFields; j++)
               {
                  piM[j] = (UINT32)pEntry->iFieldIDM[j];
                  piD[j] = (UINT32)pDsDet->piLinkField[j];
               }
               rslt = pDsDelta->pLinkedTables->Link_Fields
                  (pDsDetDelta, pEntry->iFields, piM, piD, &pDsDetDelta->iDetID);
               if (rslt)
                  goto Exit;
            }

            if (pDsDetDelta->iRecNoNext > 1)
            { // Cascade all changes to Master linkfields to details!
               UINT32 j;

               for (j = 0; j < pLogNew->iLast; j++)
               {
                  LOGENTRY *pLogEntry = &pLogNew->pLogEntries[j];
                  if (pLogEntry->iAttr == dsRecModified)
                  {
                     UINT32 k;
                     BOOL bLinkFieldsChanged = FALSE;

                     // Check if any of the linking fields changed
                     RecsEqual(pLogEntry->iRecNo2, pLogEntry->iRecNo1, FALSE, pbSame);
                     for (k = 0; k < pEntry->iFields; k++)
                     {
                        UINT32 iFieldID = pEntry->iFieldIDM[k];
                        if (!pbSame[iFieldID-1])
                           bLinkFieldsChanged = TRUE;
                     }
                     if (bLinkFieldsChanged)
                     { // Cascade all links on details back to original link
                        pLTABLEEntry pDeltaEntry = pDsDelta->pLinkedTables->GetEntry(pDsDetDelta->iDetID);
                        UINT32 iRecNoDelta = j+1;

                        LinkFieldsCascade(pDsDelta, pDeltaEntry, 0, iRecNoDelta, TRUE);
                     }
                  }
               }
            }
         }
      }
   }

Exit:
   if (rslt)
   { // backout

      if (rslt == DBIERR_DELTAISEMPTY && (pDsParent /* || (pLinkedTables && pLinkedTables->iLast > 0) */ ))
      // This is a detail, we must create an emtpty one!
      {
         if (pDsDelta == NULL)
         {
            rslt = CreateEmptyDelta(this, &pDsDelta);
            if (rslt)
               goto Exit;
         }
         rslt = DBIERR_NONE;
         goto LinkDetails;
      }
      if (pDsDelta)
         delete pDsDelta;
   }
   else
      *ppDsDelta = (pBYTE)pDsDelta;
   if (pLogNew)
      delete pLogNew;
   if (pRecBuf)
      delete[] pRecBuf;
   if (pbSame)
      delete[] pbSame;
   UNLOCK();
   return rslt;
}

// Sets the pbSame array, in order to compress delta
BOOL DBIFN DSBASE::RecsEqual(UINT32 iRecNo1, UINT32 iRecNo2, BOOL bCmpBlobs, pBOOL pbSame)
{
   BOOL bEqual = TRUE;
   BOOL bBlank1, bBlank2;
   pBYTE pFld1, pFld2;
   UINT32 i;

   for (i = 0; i < iFields; i++)
   {
      if (pFieldDesc[i].bCalculated)
      {
         goto Same;
      }
      GetFieldPtr(iRecNo2, i+1, &pFld2, &bBlank2);
      if (bBlank2 == BLANK_NOTCHANGED)
      {
         goto Same;
      }
      GetFieldPtr(iRecNo1, i+1, &pFld1, &bBlank1);

      if (pFieldDesc[i].iFldType == fldBLOB)
      {
         if (bCmpBlobs)
         {
            UINT32 iBlobId1, iBlobId2;

            iBlobId1 = pFld1 == NULL ? 0 : *(pUINT32)pFld1;
            iBlobId2 = pFld2 == NULL ? 0 : *(pUINT32)pFld2;
            if (iBlobId1 == iBlobId2)
               goto Same;
            else
            {
               UINT32 iBlobLen1;
               pBYTE pBlob1;

               if (iBlobId1 == 0 || iBlobId2 == 0)
                  goto NotSame; // (could be same if empty ?)
               pDsBlobs->GetBlobInfo(iBlobId1, &iBlobLen1, &pBlob1);
               if (pDsBlobs->BlobIsSame(iBlobLen1, pBlob1, iBlobId2))
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

         iCmp = FldCmp(pFieldDesc[i].iFldType, pFld1, pFld2, pFieldDesc[i].iUnits1, pFieldDesc[i].iUnits2);
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

DBIResult MoveRecord(DSBASE *pDs, pBYTE pRecBuf, UINT32 iRecNo, DSAttr iAttr, DSBASE *pDsDelta, pBOOL pbSame)
{
   DBIResult rslt;
   UINT32 iRecNoDelta;
   UINT32 i;

   rslt = pDs->GetRecord(iRecNo, pRecBuf); // Get into pAuxRecbuf
   if (rslt)
      goto Exit;

   if (iAttr == dsRecDeleted || iAttr == dsRecOrg)
   { // Null out blob fields
      if (pDs->iBlobFields)
      {
         for (i = 0; i < pDs->iFields; i++)
         {
            UINT32 iBlobLen;

            if (pDs->pFieldDesc[i].iFldType != fldBLOB)
               continue;
            if (pDs->iInclBlobsInDelta)
               pDs->GetBlobLen(pRecBuf, i+1, &iBlobLen);
            else
               iBlobLen = 0;
            if (iBlobLen == 0 || iBlobLen > pDs->iInclBlobsInDelta || iBlobLen & dsDELAYEDBIT)
            {
               pDsDelta->PutBlank(pRecBuf, 0, i+1, BLANK_NULL); // Should it be BLANK_NOTCHANGED
            }
            else
            {
               pBYTE pBuf = (pBYTE)DsMalloc(iBlobLen);
               if (pBuf == NULL)
               {
                  rslt = DBIERR_NOMEMORY;
                  goto Exit;
               }
               pDs->GetBlob(pRecBuf, i+1, 0, pBuf, NULL);
               pDsDelta->PutBlob(pRecBuf, i+1, 0, pBuf, iBlobLen);
               DsFree(pBuf);
            }
         }
      }
   }
   else
   { // dsRecInsert / dsRecModified : Move all blob fields
      if (pDs->iBlobFields || pbSame)
      {
         for (i = 0; i < pDs->iFields; i++)
         {
            UINT32 iBlobLen;

            if (pbSame && pbSame[i])
            {
               pDsDelta->PutBlank(pRecBuf, 0, i+1, BLANK_NOTCHANGED);
               continue;
            }
            if (pDs->pFieldDesc[i].iFldType != fldBLOB)
            {

            }
            else
            {
               pDs->GetBlobLen(pRecBuf, i+1, &iBlobLen);
               if (iBlobLen == 0 || iBlobLen & dsDELAYEDBIT)
                  pDsDelta->PutBlank(pRecBuf, 0, i+1, BLANK_NULL); // Should it be BLANK_NOTCHANGED
               else
               {
                  pBYTE pBuf = (pBYTE)DsMalloc(iBlobLen);

                  if (pBuf == NULL)
                  {
                     rslt = DBIERR_NOMEMORY;
                     goto Exit;
                  }
                  pDs->GetBlob(pRecBuf, i+1, 0, pBuf, NULL);
                  pDsDelta->PutBlob(pRecBuf, i+1, 0, pBuf, iBlobLen);
                  DsFree(pBuf);
               }
            }
         }
      }
   }

   rslt = pDsDelta->InsertRecord(pRecBuf, &iRecNoDelta);
   if (rslt)
      goto Exit;
   rslt = pDsDelta->PutField(iRecNoDelta, 0, (pBYTE) &iAttr);
   if (rslt)
      goto Exit;

Exit:
   return rslt;
}

DBIResult DBIFN CreateEmptyDelta(DSBASE *pDs, DSBASE **ppDsDelta)
{
   DBIResult rslt;
   DBINAME szDeltaName;
   DSBASE *pDsDelta;
   UINT32 i, iValue, iPCKLType;

   if (pDs->pszName)
   {
      LdStrCpy(szDeltaName, pDs->pszName);
   }
   else
      szDeltaName[0] = 0;

   if (LdStrLen(szDeltaName) + LdStrLen(szDELTA) < (int)sizeof(DBINAME))
      LdStrCat(szDeltaName, szDELTA);

   pDsDelta = new DSBASE();
   if (pDsDelta == NULL)
   {
      rslt = DBIERR_NA;
      goto Exit;
   }
   pDsDelta->AddRef();
   rslt = pDsDelta->Create(pDs->iFields, pDs->pFieldDesc, szDeltaName);
   if (rslt)
      goto Exit;

   if (pDs->iXmlMode)
      pDsDelta->SetProp(dspropXML_STREAMMODE, pDs->iXmlMode);

   // Add optional parameters
   iValue = 1; // TRUE
   iPCKLType = dsfldUINT << dsSizeBitsLen;
   iPCKLType |= sizeof(UINT32);
   pDsDelta->AddOptParameter(0, szDATASET_DELTA, iPCKLType, sizeof(UINT32), (pBYTE) &iValue);

   if (pDs->pDsOptParams)
   {
      for (i = 0; i < pDs->pDsOptParams->iLast; i++)
      {
         pOPTPARAMEntry pEntry = &pDs->pDsOptParams->pEntries[i];

         if (pEntry->iPacketTypes & dsPACKET_DELTA)
         {
            // FldNo is not nesc.
            rslt = pDsDelta->AddOptParameter(pEntry->iFldNo, pEntry->pAttr, pEntry->iType, pEntry->iLen,
               pEntry->pValue);
            if (rslt)
               break;
         }
      }
   }
Exit:
   if (ppDsDelta)
      *ppDsDelta = pDsDelta;
   return rslt;
}
