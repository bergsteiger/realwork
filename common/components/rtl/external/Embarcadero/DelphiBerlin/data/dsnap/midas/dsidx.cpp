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

// Move record to new position (no data-changes)
DBIResult DBIFN xMoveRecord(DSBASE *pDs, UINT32 iRecNoTo, UINT32 iRecNoFrom, UINT32 iNo)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i, iPos;
   DSIDX *pI = pDs->pIdx; // *pIdxChange;

   for (i = 0; i < iNo; i++)
   {
      if (pI->iType != idxChange)
      {
         iPos = pI->IdxRecNoToSeqNo(iRecNoFrom);
         if (iPos != 0) // Could be 0 if IdxFilt.
            pI->piOrder[iPos] = iRecNoTo;
      }
      pI = pI->pIdxNext;
   }
   return rslt;
}

// Insert into indexes
DBIResult DBIFN DSBASE::xInsertRecord(UINT32 iRecNo, UINT32 iNo)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   DSIDX *pI = pIdx; // *pIdxChange;

   for (i = 0; i < iNo; i++)
   {
      rslt = pI->IdxInsert(iRecNo);
      if (rslt)
      { // back-out
         if (i) // backout previous
            xDeleteRecord(iRecNo, i);
         break;
      }
      pI = pI->pIdxNext;
   }
   return rslt;
}

// Delete from indexes
DBIResult DBIFN DSBASE::xDeleteRecord(UINT32 iRecNo, UINT32 iNo)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   DSIDX *pI = pIdx; // *pIdxChange;

   for (i = 0; i < iNo; i++)
   {
      rslt = pI->IdxDelete(iRecNo);
      if (rslt)
      { // back-out
         if (i) // backout previous
            xInsertRecord(iRecNo, i /* -1 */ );
         break;
      }
      pI = pI->pIdxNext;
   }
   return rslt;
}

// Modify indexes
// iRecNo1 is changed record
DBIResult DBIFN DSBASE::xModifyRecord(UINT32 iRecNo1, UINT32 iRecNo2, UINT32 iNo)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   DSIDX *pI = pIdx; // *pIdxChange;

   for (i = 0; i < iNo; i++)
   {
      rslt = pI->IdxModify(iRecNo1, iRecNo2);
      if (rslt)
      { // back-out
         if (i) // backout previous
            xModifyRecord(iRecNo2, iRecNo1, i /* -1 */ );
         break;
      }
      pI = pI->pIdxNext;
   }
   return rslt;
}

// Update index positions, in case any keys were changed
DBIResult DBIFN xOverWriteRecord(DSBASE *pDs, UINT32 iRecNo, UINT32 iNo)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   DSIDX *pI = pDs->pIdx; // *pIdxChange;

   for (i = 0; i < iNo; i++)
   {
      if (pI->IdxDesc.iFields != 0 && pI->iType != idxChange)
      {
         // In case the index is not unique, this might create 'funny' semantics!
         pI->IdxDelete(iRecNo);
         rslt = pI->IdxInsert(iRecNo); // reinsert, possibly with new key.
         if (rslt)
         { // What to do!
         }
      }
      pI = pI->pIdxNext;
   }
   return rslt;
}

DBIResult DBIFN DSBASE::AddIndex(DSIDX *pIdxNew)
{
   DBIResult rslt = DBIERR_NONE;
   DSIDX *pIdxNext;

   LOCK();
   pIdxNew->iID = ++iIndexIDs;
   if (iIndexes == 0)
      pIdx = pIdxNew;
   else
   {
      pIdxNext = pIdx;
      while (pIdxNext->pIdxNext != NULL)
         pIdxNext = pIdxNext->pIdxNext;
      pIdxNext->pIdxNext = pIdxNew;
   }
   iIndexes++;
   if (!pIdxNew->bSortIndex && (pIdxNew->iType == idxNormal || pIdxNew->iType == idxChange))
      iIndexesShared++;
   UNLOCK();
   return rslt;
}

// Removes it (if last user)
DBIResult DBIFN DSBASE::DropIndex(DSIDX *pIdx)
{
   DBIResult rslt = DBIERR_NONE;

   LOCK();
   if (pIdx->iRefCount /* UseCnt */ > 1)
   {
      pIdx->iRefCount-- /* UseCnt-- */ ;
      goto Exit;
   }
   if (this->pIdx == pIdx)
   {
      this->pIdx = pIdx->pIdxNext;
   }
   else
   {
      DSIDX *pTmp = this->pIdx;

      while (pTmp != NULL && pTmp->pIdxNext != pIdx)
         pTmp = pTmp->pIdxNext;
      if (pTmp)
      {
         pTmp->pIdxNext = pIdx->pIdxNext;
      }
      else
      {
         rslt = DBIERR_OBJNOTFOUND;
         goto Exit;
      }
   }
   iIndexes--;
   if (!pIdx->bSortIndex && (pIdx->iType == idxNormal || pIdx->iType == idxChange))
      iIndexesShared--;
   delete pIdx;

Exit:
   UNLOCK();
   return rslt;
}

// Does not return sort-indices or filter-indices, because they belong to a
// specific cursor
DBIResult DBIFN DSBASE::FindIndex(pCCHAR pszName, class DSIDX **ppIdx)
{
   DBIResult rslt = DBIERR_NONE;
   DSIDX *pIdxNew = pIdxDef;
   UINT32 i;
   pCCHAR pszIndexName = pszName;

   LOCK();
   if (pszName == NULL || *pszName == 0)
   {
      pszIndexName = szDEFAULT_ORDER; // Blank is same as default
   }

   pIdxNew = pIdx;

   for (i = 0; i < iIndexes; i++)
   {
      if (pIdxNew == NULL)
         break;
      if (LCStrCmp(iLCID, pszIndexName, pIdxNew->IdxDesc.szName) == 0)
      {
         if ((pIdxNew->iType == idxNormal || pIdxNew->iType == idxChange) && !pIdxNew->bSortIndex)
            goto Found; // Found one
      }
      pIdxNew = pIdxNew->pIdxNext;
   }
   rslt = DBIERR_NOSUCHINDEX; // Index not found
Found:
   *ppIdx = pIdxNew;
   UNLOCK();
   return rslt;
}

// This requires a DSLOCK from caller!
// Does NOT return filter indexes, but could return sortindex!
DBIResult DBIFN DSBASE::FindEqIndex( // Find equivalent index
   pDSIDXDesc pIdxDesc, class DSIDX **ppIdx)
{
   DBIResult rslt = DBIERR_NONE;
   DSIDX *pIdxNew = pIdxDef;
   UINT32 i;

   // LOCK();
   pIdxNew = pIdx;

   for (i = 0; i < iIndexes; i++)
   {
      if (pIdxNew == NULL)
         break;

      if (SameIdxDesc(pIdxDesc, &pIdxNew->IdxDesc, TRUE, TRUE))
      { // Found one
         if (pIdxNew->iType == idxNormal)
            goto Found; // Found one
      }
      pIdxNew = pIdxNew->pIdxNext;
   }
   rslt = DBIERR_NOSUCHINDEX; // Index not found
Found:
   *ppIdx = pIdxNew;
   // UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::CreateIndex( // Create, and add an index
   pDSIDXDesc pIdxDescIn)
{
   DBIResult rslt;
   DSIDX *pIdx;
   BOOL bRemoveAgain = FALSE;
   DSIDXDesc IdxDesc;
   pDSIDXDesc pIdxDesc = &IdxDesc;

   LOCK();
   if (pIdxDescIn == NULL)
   {
      rslt = DBIERR_INVALIDPARAM;
      goto Exit;
   }
   CopyMem(pIdxDesc, pIdxDescIn, sizeof(DSIDXDesc));
   if (pIdxDesc->szName[0] == 0)
   {
      LdStrCpy(pIdxDesc->szName, szDEFAULT_ORDER);
      bRemoveAgain = TRUE;
   }

   if (!bIgnSetIDInIdx && iFieldID_SetIDD && pIdxDesc->iKeyFields[0] != iFieldID_SetIDD)
   {
      UINT32 i;
      for (i = IdxDesc.iFields; i > 0; i--)
      { // Problem if iFields == MAXKEYFIELDS!
         IdxDesc.iKeyFields[i] = IdxDesc.iKeyFields[i-1];
         IdxDesc.bDescending[i] = IdxDesc.bDescending[i-1];
         IdxDesc.bCaseInsensitive[i] = IdxDesc.bCaseInsensitive[i-1];
      }
      IdxDesc.iKeyFields[0] = iFieldID_SetIDD;
      IdxDesc.bDescending[0] = FALSE;
      IdxDesc.bCaseInsensitive[0] = FALSE;
      IdxDesc.iFields++;
   }

   rslt = FindIndex(pIdxDesc->szName, &pIdx);
   if (rslt == DBIERR_NONE && pIdx)
   { // Found one with the same name
      // We could either  : fail if already there
      // or : ignore if it is identical, overwrite if different (if it can be removed)
      if (pIdx != pIdxDef)
      {
         if (!SameIdxDesc(&pIdx->IdxDesc, pIdxDesc, FALSE, FALSE))
            rslt = DBIERR_NAMENOTUNIQUE;
         goto Exit; // If same index, ignore
      }
      // If it is the default-order, allow it to be overwritten!
      // (We could restrict it to the situation where the indexfields == 0)
      if (pIdx == pIdxDef)
      {
         if (pIdx->IdxDesc.iFields != 0 || bDefOrderChanged)
         { // Default index was already changed.
            // Note : If we want to be able to change the default index
            // we must remove it from the optional parameter list!
            rslt = DBIERR_ACTIVEINDEX;
            goto Exit;
         }
         bDefOrderChanged = TRUE;
         rslt = pIdx->IdxCreateOrder(pIdxDesc, NULL); // Use
      }
   }
   else
   {
      pIdx = new DSIDX(this); // Create default order
      rslt = pIdx->IdxCreateOrder(pIdxDesc, NULL); // Use
      if (!rslt)
         rslt = this->AddIndex(pIdx); // Make it maintained
      if (rslt)
      {
         if (pIdx)
            delete pIdx;
      }
   }
Exit:
   if (bRemoveAgain)
      pIdxDesc->szName[0] = 0; // Remove szDEFAULT_ORDER
   UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::RemoveIndex( // Remove index of given name
   pCHAR pszName)
{
   DBIResult rslt;
   pDSIDX pIdx;

   if (pszName == NULL || *pszName == 0)
   { // This means the default index
      return DBIERR_ACTIVEINDEX; // DBIERR_INVALIDINDEXNAME;
   }
   LOCK();
   rslt = FindIndex(pszName, &pIdx);
   if (rslt == DBIERR_NONE)
   {
      if (pIdx == pIdxDef)
         rslt = DBIERR_ACTIVEINDEX;
      else
      {
         if (pIdx->iRefCount > 1)
            rslt = DBIERR_ACTIVEINDEX; // In use by a cursor ?
         else
            rslt = DropIndex(pIdx);
      }
   }
   UNLOCK();
   return rslt;
}

BOOL DBIFN SameIdxDesc(DSIDXDesc *pD1, DSIDXDesc *pD2, BOOL bLessFldsOkay, BOOL bIgnUnique)
{
   BOOL bSame = FALSE;

   // Check if equivalent indexes
   if (bLessFldsOkay || pD1->iFields == pD2->iFields)
   {
      UINT32 i;
      for (i = 0; i < pD1->iFields; i++)
      {
         if (pD1->iKeyFields[i] != pD2->iKeyFields[i] || pD1->bDescending[i] != pD2->bDescending[i]
            || pD1->bCaseInsensitive[i] != pD2->bCaseInsensitive[i])
         {
            goto Exit;
         }
      }
      if (bIgnUnique || pD1->bUnique == pD2->bUnique)
         bSame = TRUE;
   }
Exit:
   return bSame;
}

// Reorders all indexes, including details
DBIResult DBIFN ReorderIndexes(DSBASE *pDs, BOOL bWalkTree)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;

   if (pDs->bDelta && pDs->pIdxDef) // XML
   {
      // If this is a detail, we must keep the first-field, which is the setid
      // ,otherwise it must be 0 so the order is not changed!
      pDs->pIdxDef->IdxDesc.iFields = pDs->pDsParent? 1 : 0;
      pDs->pIdxDef->IdxDesc.bUnique = FALSE;
      // if any other unique indexes, should they be disabled?
   }

   DSIDX *pIdxNew;
   pIdxNew = pDs->pIdx;
   for (i = 0; i < pDs->iIndexes; i++)
   {
      if (pIdxNew == NULL)
         break;
      pIdxNew->IdxCreateOrder(NULL, NULL);
      pIdxNew = pIdxNew->pIdxNext;
   }

   if (bWalkTree && pDs->pLinkedTables)
   {
      for (i = 0; i < pDs->pLinkedTables->iLast; i++)
      {
         pLTABLEEntry pEntry = pDs->pLinkedTables->GetEntry(i+1);
         rslt = ReorderIndexes(pEntry->pDsDet, TRUE);
         if (rslt)
            break;
      }
   }
   return rslt;
}

// Add/remove setID field from all indexes, except CHANGE_INDEX
DBIResult DBIFN AddSetIDToIndexes(DSBASE *pDs, UINT32 iFldID, // FieldID of field to include in indexes
   pDSIDX pIdx, // If NULL, all indexes, otherwise just this one
   BOOL bAdd) // TRUE: add, otherwise remove
{
   DBIResult rslt = DBIERR_NONE;
   DSIDXDesc IdxDesc;
   UINT32 i, iCnt;
   DSIDX *pIdxCurr;

   pIdxCurr = pIdx ? pIdx : pDs->pIdx;
   iCnt = pIdx ? 1 : pDs->iIndexes;
   for (i = 0; i < iCnt; i++)
   {
      if (pIdxCurr == NULL)
         break;
      if (pIdxCurr == pDs->pIdxChg)
         continue;
      if (pIdxCurr->bGlobal)
         continue;
      CopyMem(&IdxDesc, &pIdxCurr->IdxDesc, sizeof(DSIDXDesc));
      // Adjust default order
      if (bAdd)
      {
         for (i = IdxDesc.iFields; i > 0; i--)
         { // Problem if iFields == MAXKEYFIELDS!
            IdxDesc.iKeyFields[i] = IdxDesc.iKeyFields[i-1];
            IdxDesc.bDescending[i] = IdxDesc.bDescending[i-1];
            IdxDesc.bCaseInsensitive[i] = IdxDesc.bCaseInsensitive[i-1];
         }
         IdxDesc.iKeyFields[0] = iFldID;
         IdxDesc.bDescending[0] = FALSE;
         IdxDesc.bCaseInsensitive[0] = FALSE;
         IdxDesc.iFields++;
      }
      else
      {
         IdxDesc.iFields--;
         for (i = 1; i < IdxDesc.iFields; i++)
         {
            IdxDesc.iKeyFields[i-1] = IdxDesc.iKeyFields[i];
            IdxDesc.bDescending[i-1] = IdxDesc.bDescending[i];
            IdxDesc.bCaseInsensitive[i-1] = IdxDesc.bCaseInsensitive[i];
         }
      }
      rslt = pIdxCurr->IdxCreateOrder(&IdxDesc, NULL); // Overwrite
      if (rslt)
         goto Exit;
      pIdxCurr = pIdxCurr->pIdxNext;
   }
Exit:
   return rslt;
}
