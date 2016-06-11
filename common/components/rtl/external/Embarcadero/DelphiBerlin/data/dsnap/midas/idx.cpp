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

// Default constructor
DSIDX::DSIDX()
{
   iRefCount = 1;
   bSortIndex = FALSE;
   pIdxNext = NULL;
   iSeqNo = 0;
   iRecs = 0;
   iRecsMax = 0;
   piOrder = NULL;
   pDs = NULL;
   iType = idxNormal;
   ZeroMem(&IdxDesc, sizeof(DSIDXDesc));
   ppFldObjs = NULL;
   iID = 0;
   pGroups = NULL;
   bGlobal = FALSE;
   iInsertHintPos = 0;
}

DSIDX::DSIDX(DSBASE * pDS)
{
   iRefCount = 1;
   bSortIndex = FALSE;
   pIdxNext = NULL;
   iSeqNo = 0;
   iRecs = 0;
   iRecsMax = 0;
   piOrder = NULL;
   pDs = NULL;
   iType = idxNormal;
   ZeroMem(&IdxDesc, sizeof(DSIDXDesc));
   ppFldObjs = NULL;
   iID = 0;
   pGroups = NULL;

   iType = idxNormal;
   pDs = pDS;
   bGlobal = FALSE;
   iInsertHintPos = 0;
}

DSIDX::~DSIDX()
{
   DsFree(piOrder);
   // Should remove itself from the pDs-chain
   if (ppFldObjs)
   {
      UINT32 i;

      for (i = 0; i < IdxDesc.iFields; i++)
         delete ppFldObjs[i];
      delete[] ppFldObjs;
      ppFldObjs = NULL;
   }
   if (pGroups)
   {
      delete pGroups;
      pGroups = NULL;
   }
}

DBIResult DSIDX::IdxCreateOrder(pDSIDXDesc pIdxDesc, pDSIDX pIdxSameOrder)
{
   DBIResult rslt = DBIERR_NONE;

   if (piOrder == NULL) // always create one, && pDs->iRecords)
      GrowIDX(pDs->iRecords + 10); // Number of 'visible records' +10

   // move to local
   if (pIdxDesc)
   { // New order
      rslt = InitIdxDesc(pIdxDesc);
      if (rslt)
         goto Exit;
   }

   iSeqNo = 0;
   iRecs = 0;

   rslt = SortData(pIdxSameOrder);
Exit:
   return rslt;
}

DBIResult DSIDX::SortData(pDSIDX pIdxSameOrder)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   DSAttr iAttr;
   BOOL bVisible, bDelta;
   BOOL bDoQSort = FALSE;
   UINT32 iIdxFields;
   UINT32 iRecNo;
   UINT32 iNumberOfRecords;

   bDelta = pDs->bDelta;
   if (pIdxSameOrder && pIdxSameOrder->piOrder == NULL)
      pIdxSameOrder = NULL; // Not ready!

   if (pDs->iRecNoNext > 1 && IdxDesc.iFields > 0)
   {
      if ((LdStrCmp(IdxDesc.szName, szDEFAULT_ORDER) != 0) && (pIdxSameOrder == NULL))
      { // If default order, assume append sort!
         bDoQSort = TRUE;
         iIdxFields = IdxDesc.iFields; // Save value
         IdxDesc.iFields = 0; // To create unordered array of 'visible' records
      }
   }
   else
   {
      pIdxSameOrder = NULL; // NO use
   }

   iNumberOfRecords = pIdxSameOrder ? pIdxSameOrder->iRecs : pDs->iRecNoNext - 1;

   for (i = 1; i <= iNumberOfRecords; i++) // i-based
   {
      iRecNo = pIdxSameOrder ? pIdxSameOrder->piOrder[i] : i;
      if (bDelta)
         bVisible = TRUE;
      else
      {
         pDs->GetField(iRecNo, 0, (pBYTE) & iAttr, NULL);
         bVisible = !(iAttr & dsISNOTVISIBLE);
      }
      if (bVisible)
      {
         rslt = IdxInsert(iRecNo);
         if (rslt)
         { // Back-out
            break;
         }
      }
   }
   if (bDoQSort)
   {
      BOOL bCheckUnique = (IdxDesc.iFields == 0 && IdxDesc.bUnique);
      IdxDesc.iFields = iIdxFields; // Restore
      if (!rslt)
      {
         IdxSort();
         if (bCheckUnique)
         { // We need to check for uniqueness
            for (i = 1; i < this->iRecs; i++)
            {
               iRecNo = piOrder[i];
               if (IdxComp(iRecNo, iIdxFields, i + 1) == 0)
               {
                  rslt = DBIERR_KEYVIOL;
                  break;
               }
            }
         }
      }
   }

   return rslt;
}

// returns sequential position in index of iRecNo (0 if not found)
// KHNOTE: Optimization : use hint, and search area around hint, (defined by differnce in iSeqNo)
DSSEQNUM DSIDX::IdxRecNoToSeqNo(UINT32 iRecNo)
{
   UINT32 i, iPos = 0;

   for (i = 1; i <= iRecs; i++)
   {
      if (piOrder[i] == iRecNo)
      {
         iPos = i;
         break;
      }
   }
   return iPos;
}

DBIResult DSIDX::IdxInsert(UINT32 iRecNo)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iFnd;

   if (iRecs + 1 >= iRecsMax) // +1 since 0 is not used!
      GrowIDX(50);

   // Check if more space
   if (IdxDesc.iFields == 0)
   { // Insert at end
      if (iInsertHintPos > 0 && iInsertHintPos <= iRecs)
      {
         iFnd = iInsertHintPos;
         MakeSpace(iFnd, iRecs);
      }
      else
         iFnd = iRecs + 1;
   }
   else
   { // Find position in index to point to inserted record iRecNo
      DBIResult x;
      if (!IdxDesc.bUnique)
      {
         IdxFindKey(IdxDesc.iFields, iRecNo, -1, &iFnd); // Insert after last duplicate!
      }
      else
      {
         // In case of duplicates, insert after last, rather than the first.
         x = IdxFindKey(IdxDesc.iFields, iRecNo, FALSE, &iFnd);
         if (x != DBIERR_RECNOTFOUND)
         { // Already there!, keyviolation ?
            if (IdxDesc.bUnique)
            {
               rslt = DBIERR_KEYVIOL;
               goto Exit;
            }
         }
      }
      iFnd++; // IMPORTANT
      MakeSpace(iFnd, iRecs);
   }
Exit:
   if (!rslt)
   {
      // if (pGroups)
      // {
      // rslt = pGroups->Insert(iFnd); // Maintain aggregates
      // }
      piOrder[iFnd] = iRecNo;
      iRecs++;
      iSeqNo++;
      if (pGroups)
      { // AFTER insert
         rslt = pGroups->Insert(iFnd); // Maintain aggregates
         // if (rslt)
         // undo insert ?
      }
   }
   return rslt;
}

DBIResult DSIDX::IdxDelete(UINT32 iRecNo)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iPos;

   iPos = IdxRecNoToSeqNo(iRecNo);
   if (iPos)
   {
      if (pGroups)
      { // Before delete
         rslt = pGroups->Delete(iPos); // Maintain aggregates
         if (rslt)
            goto Exit;
         // undo delete ?
      }
      RemSpace(iPos, iRecs);
      iRecs--;
      iSeqNo++;
   }
   else
      rslt = DBIERR_NA; // could not delete
Exit:
   return rslt;
}

// iRecNo1 is 'new' modified record
DBIResult DSIDX::IdxModify(UINT32 iRecNoNew, UINT32 iRecNoOld)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iPosOld;

   iPosOld = IdxRecNoToSeqNo(iRecNoOld);

   if (IdxDesc.iFields == 0) // No order
      goto Replace;

   if (IdxComp(iRecNoNew, IdxDesc.iFields, iPosOld) != 0)
   { // Key changed
      IdxDelete(iRecNoOld);
      rslt = IdxInsert(iRecNoNew);
      if (rslt)
      { // Keyviolation
         IdxInsert(iRecNoOld); // Backup
      }
   }
   else
   {
   Replace:
      if (pGroups)
      { // Before delete
         rslt = pGroups->Delete(iPosOld); // Maintain aggregates
         if (rslt)
            goto Exit;
      }
      piOrder[iPosOld] = iRecNoNew;
      if (pGroups)
      { // After insert
         rslt = pGroups->Insert(iPosOld); // Maintain aggregates
      }
   }
Exit:
   return rslt;
}

// Returns 'closest' position, on or before the key
// If not found, DBIERR_RECNOTFUOND is returned.
// If record is to be inserted, the position will be the returned position +1!
// Used after insertion. iRecNo was the record inserted
DBIResult DSIDX::IdxFindKey(UINT32 iFields, UINT32 iRecNo, BOOL bFirst, pUINT32 piPos)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iLast, iMiddle, iFirst;
   INT32 c;

   *piPos = 0;
   iLast = iRecs;
   if (iLast > 0)
   {
      if ((c = IdxComp(iRecNo, iFields, iLast)) >= 0)
      {
         if (c) // > 0
         {
            *piPos = iLast /* +1 */ ;
            rslt = DBIERR_RECNOTFOUND;
         }
         else
         {
            *piPos = iLast;
            if (bFirst)
            {
               if (bFirst < 0)
                  while (*piPos < iRecs && IdxComp(iRecNo, iFields, *piPos + 1) == 0)
                     (*piPos)++;
               else
                  while (*piPos > 1 && IdxComp(iRecNo, iFields, *piPos - 1) == 0)
                     (*piPos)--;
            }
         }
         goto Exit;
      }

      iFirst = 1;
      if ((c = IdxComp(iRecNo, iFields, iFirst)) <= 0)
      {
         if (c) // < 0
         {
            rslt = DBIERR_RECNOTFOUND;
            *piPos = 0; // (means insert at pos 1)
         }
         else
         {
            *piPos = iFirst;
            if (bFirst < 0) // insert after last
               while (*piPos < iRecs && IdxComp(iRecNo, iFields, *piPos + 1) == 0)
                  (*piPos)++;
         }
         goto Exit;
      }

      if (iLast == iFirst + 1)
      {
         *piPos = iFirst;
         rslt = DBIERR_RECNOTFOUND;
      }
      else
      {
         // make sure c is set
         while (iLast > iFirst + 1)
         {
            iMiddle = iFirst + ((iLast - iFirst) >> 1);
            if ((c = IdxComp(iRecNo, iFields, iMiddle)) >= 0)
            {
               if (c == 0) // no reason to continue when found
                  break;
               iFirst = iMiddle;
            }
            else
               iLast = iMiddle;
         }
         if (c == 0)
         {
            *piPos = iMiddle; // Found a match
            if (bFirst)
            {
               if (bFirst < 0)
                  while (*piPos < iRecs && IdxComp(iRecNo, iFields, *piPos + 1) == 0)
                     (*piPos)++;
               else
                  while (*piPos > 1 && IdxComp(iRecNo, iFields, *piPos - 1) == 0)
                     (*piPos)--;
            }
         }
         else
         {
            if (c > 0) // iMiddle = iFirst
            {
               if (IdxComp(iRecNo, iFields, iLast) != 0)
               {
                  *piPos = iFirst;
                  rslt = DBIERR_RECNOTFOUND;
               }
               else
               {
                  *piPos = iLast;
                  if (bFirst)
                  {
                     // In case of partial key, or non-unique key, the one found might not be the first!
                     if (bFirst < 0)
                        while (*piPos < iRecs && IdxComp(iRecNo, iFields, *piPos + 1) == 0)
                           (*piPos)++;
                     else
                        while (*piPos > 1 && IdxComp(iRecNo, iFields, *piPos - 1) == 0)
                           (*piPos)--;
                  }
               }
            }
            else // c < 0, iMiddle = iLast
            {
               *piPos = iFirst;
               if (IdxComp(iRecNo, iFields, iFirst) != 0)
               {
                  rslt = DBIERR_RECNOTFOUND;
               }
               else
               {
                  if (bFirst)
                  {
                     // In case of partial key, or non-unique key, the one found might not be the first!
                     if (bFirst < 0)
                        while (*piPos < iRecs && IdxComp(iRecNo, iFields, *piPos + 1) == 0)
                           (*piPos)++;
                     else
                        while (*piPos > 1 && IdxComp(iRecNo, iFields, *piPos - 1) == 0)
                           (*piPos)--;
                  }
               }
            }
         }
      }
   }
   else
      rslt = DBIERR_RECNOTFOUND;
Exit:
   return rslt;
}

// Returns 'closest' position, on or before the key
// (position is less than key, if not found)
// If not found, DBIERR_RECNOTFUOND is returned.
// If record is to be inserted, the position will be the returned position +1!
DBIResult DSIDX::IdxFindKey(UINT32 iFields, UINT16 iLength, pBYTE pRecBuf, BOOL bFirst,
   pUINT32 piPos)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iLast, iMiddle, iFirst;
   INT32 c;

   *piPos = 0;
   iLast = iRecs;
   if (iLast > 0)
   {
      if ((c = IdxComp(pRecBuf, iFields, iLength, iLast)) >= 0)
      {
         if (c)
         {
            *piPos = iLast /* +1 */ ;
            rslt = DBIERR_RECNOTFOUND;
         }
         else
         {
            *piPos = iLast;
            if (bFirst)
            {
               while (*piPos > 1 && IdxComp(pRecBuf, iFields, iLength, *piPos - 1) == 0)
                  (*piPos)--;
            }
         }
         goto Exit;
      }

      iFirst = 1;
      if ((c = IdxComp(pRecBuf, iFields, iLength, iFirst)) <= 0)
      {
         if (c)
         {
            rslt = DBIERR_RECNOTFOUND;
            *piPos = 0; // (means insert at pos 1)
         }
         else
            *piPos = iFirst;
         goto Exit;
      }

      if (iLast == iFirst + 1)
      {
         *piPos = iFirst;
         rslt = DBIERR_RECNOTFOUND;
      }
      else
      {
         // make sure c is set
         while (iLast > iFirst + 1)
         {
            iMiddle = iFirst + ((iLast - iFirst) >> 1);
            if ((c = IdxComp(pRecBuf, iFields, iLength, iMiddle)) >= 0)
            {
               if (c == 0) // no reason to continue when found
                  break;
               iFirst = iMiddle;
            }
            else
               iLast = iMiddle;
         }
         if (c == 0)
         {
            *piPos = iMiddle; // Found a match
            if (bFirst)
            {
               while (*piPos > 1 && IdxComp(pRecBuf, iFields, iLength, *piPos - 1) == 0)
                  (*piPos)--;
            }
         }
         else
         {
            if (c > 0) // iMiddle = iFirst
            {
               if (IdxComp(pRecBuf, iFields, iLength, iMiddle) != 0)
               {
                  *piPos = iFirst;
                  rslt = DBIERR_RECNOTFOUND;
               }
               else
               {
                  *piPos = iLast;
                  if (bFirst)
                  {
                     // In case of partial key, or non-unique key, the one found might not be the first!
                     while (*piPos > 1 && IdxComp(pRecBuf, iFields, iLength, *piPos - 1) == 0)
                        (*piPos)--;
                  }
               }
            }
            else // c < 0, iMiddle = iLast
            {
               *piPos = iFirst;
               if (IdxComp(pRecBuf, iFields, iLength, iFirst) != 0)
               {
                  rslt = DBIERR_RECNOTFOUND;
               }
               else
               {
                  if (bFirst)
                  {
                     // In case of partial key, or non-unique key, the one found might not be the first!
                     while (*piPos > 1 && IdxComp(pRecBuf, iFields, iLength, *piPos - 1) == 0)
                        (*piPos)--;
                  }
               }
            }
         }
      }
   }
   else
      rslt = DBIERR_RECNOTFOUND;
Exit:
   return rslt;
}

INT32 DSIDX::IdxComp(pBYTE pRecBuf, UINT32 iFields, UINT16 iLength, UINT32 iPos)
{
   UINT32 i;
   UINT32 iRecNo = piOrder[iPos];
   UINT32 iFldNo;
   pDSFLDDesc pFldDescs = pDs->pFieldDesc;
   pDSFLDDesc pFldDes;
   pBYTE pFld1, pFld2;
   INT32 iCmp = 1;
   pBYTE pBlank2;

   if (iLength)
      iFields++;
   for (i = 0; i < iFields; i++)
   {
      iFldNo = IdxDesc.iKeyFields[i];
      pFldDes = &pFldDescs[iFldNo - 1];
      if (*(pRecBuf + pFldDes->iNullOffsInRec) != 0)
         pFld1 = NULL; // Should we return iCmp = -1 already here ?
      else
         pFld1 = pRecBuf + pFldDes->iFldOffsInRec;

      pBlank2 = pDs->pNulls + pDs->iNullLength * (iRecNo - 1);
      if (pBlank2[iFldNo - 1] != 0)
         pFld2 = NULL;
      else
      {
         pFld2 = pDs->ppColumns[iFldNo - 1];
         pFld2 += pFldDes->iFldLen * (iRecNo - 1);
      }

      if ((i == (iFields - 1)) && iLength)
      { // Only char-fields allowed for partial searches!

         if (pFld1 == NULL || pFld2 == NULL)
         {
            if (pFld1 == pFld2)
               iCmp = 0; // null semantics
            else
               iCmp = (pFld1 == NULL) ? -1 : 1;
         }
         else
         {
            if (IdxDesc.bCaseInsensitive[i])
               iCmp = LCStrnCmpi(pDs->iLCID, (pCHAR)pFld1, (pCHAR)pFld2, iLength);
            else
               iCmp = LCStrnCmp(pDs->iLCID, (pCHAR)pFld1, (pCHAR)pFld2, iLength);
         }
      }
      else
      {
         iCmp = ppFldObjs[i]->FldComp(pFld1, pFld2);
      }
      if (iCmp)
         break;
   }
   return iCmp;
}

// Returns > 0 if record iRecNo1 is greater than key at seqnece number iPos
// iPos is a seuence number in the piOrder array
INT32 DSIDX::IdxComp(UINT32 iRecNo1, UINT32 iFields, UINT32 iPos)
{
   UINT32 i;
   UINT32 iRecNo2 = piOrder[iPos];
   UINT32 iFldNo;
   pDSFLDDesc pFldDescs = pDs->pFieldDesc;
   pDSFLDDesc pFldDes;
   pBYTE pFld1, pFld2;
   INT32 iCmp = 1;
   pBYTE pBlank1, pBlank2;

   for (i = 0; i < iFields; i++)
   {
      iFldNo = IdxDesc.iKeyFields[i];
      pFldDes = &pFldDescs[iFldNo - 1];
      pFld2 = pFld1 = pDs->ppColumns[iFldNo - 1];

      pBlank1 = (pBYTE)pDs->pNulls + pDs->iNullLength * (iRecNo1 - 1);
      pBlank2 = (pBYTE)pDs->pNulls + pDs->iNullLength * (iRecNo2 - 1);

      if (pBlank1[iFldNo - 1] != 0)
         pFld1 = NULL;
      else
         pFld1 += pFldDes->iFldLen * (iRecNo1 - 1);

      if (pBlank2[iFldNo - 1] != 0)
         pFld2 = NULL;
      else
         pFld2 += pFldDes->iFldLen * (iRecNo2 - 1);

      iCmp = ppFldObjs[i]->FldComp(pFld1, pFld2);
      if (iCmp)
         break;
   }
   return iCmp;
}

DBIResult DSIDX::ExtractKey(pBYTE pRecBuf, pBYTE pKeyBuf, BOOL bFromKey)
{
   UINT32 i;
   pBYTE pFld1;
   UINT32 iFldNo, iofflen = 0;
   pDSFLDDesc pFldDescs = pDs->pFieldDesc;
   pDSFLDDesc pFldDes;
   UINT32 iFields = IdxDesc.iFields;

   for (i = 0; i < iFields; i++)
   {
      iFldNo = IdxDesc.iKeyFields[i];
      pFldDes = &pFldDescs[iFldNo - 1];
      pFld1 = pRecBuf + pFldDescs[iFldNo - 1].iFldOffsInRec;
      if (bFromKey)
         CopyMem(pFld1, pKeyBuf + iofflen, pFldDes->iFldLen);
      else
         CopyMem(pKeyBuf + iofflen, pFld1, pFldDes->iFldLen);
      iofflen += pFldDes->iFldLen;
   }
   return DBIERR_NONE;
}

// Move all elements right from iPos to iLen, with 1 position
VOID DSIDX::MakeSpace(UINT32 iPos, UINT32 iLen)
{
   UINT32 i;

   if (iLen)
      for (i = iLen; i >= iPos; i--)
         piOrder[i + 1] = piOrder[i];
}

// Move all elements left from iPos +1 to iLen, with 1 position
VOID DSIDX::RemSpace(UINT32 iPos, UINT32 iLen)
{
   INT32 iMove = iLen - iPos /* -1 */ ;
   if (iMove > 0)
      CopyMem((pVOID) & piOrder[iPos], (pVOID) & piOrder[iPos + 1], (UINT32)sizeof(UINT32) *
      (iMove));
}

// Increase capacity of
DBIResult DSIDX::GrowIDX(UINT32 iInc)
{
   DBIResult rslt;
   pBYTE pTmp = (pBYTE)piOrder;
   UINT32 iSize = iRecsMax*sizeof(UINT32);
   UINT32 iNewSize = iSize + iInc*sizeof(UINT32);

   pTmp = (pBYTE)DsRealloc((pVOID)pTmp, iSize, iNewSize);
   if (pTmp == NULL)
   {
      rslt = DBIERR_NOMEMORY;
   }
   else
   {
      piOrder = (pUINT32)pTmp;
      iRecsMax += iInc;
      rslt = DBIERR_NONE;
   }
   return rslt;
}

INT32 DSIDX::IdxSeqNoToRecNo(UINT32 iSeqNo) // Returns record number for given sequence number
{
   INT32 iRecNo;

   if (iSeqNo > iRecs || iSeqNo == 0)
      iRecNo = 0;
   else
   // if does not point to an underlying index
      iRecNo = piOrder[iSeqNo];
   return iRecNo;
}

INT32 DBIFN DSIDX::AddRef(VOID)
{
   return++iRefCount;
}

INT32 DBIFN DSIDX::Release(VOID)
{
   INT32 iRefSave;

   iRefSave = --iRefCount;
   if (iRefCount == 0)
      pDs->DropIndex(this);
   return iRefSave;
}

DBIResult DSIDX::InitIdxDesc(DSIDXDesc *pIdxDesc)
{
   UINT32 i;

   // Check for valid fields
   for (i = 0; i < pIdxDesc->iFields; i++)
   {
      pDSFLDDesc pFldDes = &pDs->pFieldDesc[pIdxDesc->iKeyFields[i] - 1];
      if (pFldDes->iFldType == fldBLOB || pFldDes->iFldType == fldADT || pFldDes->iFldType ==
         fldARRAY || pFldDes->iFldType == fldTABLE || pFldDes->iFldType == fldREF)
         return DBIERR_INVALIDFLDTYPE;
   }

   if (ppFldObjs) // release previous
   {
      for (i = 0; i < IdxDesc.iFields; i++)
         delete ppFldObjs[i];
      if (IdxDesc.iFields < pIdxDesc->iFields)
      { // cannot reuse
         delete[] ppFldObjs;
         ppFldObjs = NULL;
      }
   }
   if (ppFldObjs == NULL && pIdxDesc->iFields)
      ppFldObjs = new FLDObj*[pIdxDesc->iFields];

   CopyMem(&IdxDesc, pIdxDesc, sizeof(DSIDXDesc));
   // Compute key length
   IdxDesc.iKeyLen = 0;
   for (i = 0; i < IdxDesc.iFields; i++)
   {
      FLDObj *pFldObj;
      BOOL bDesc = IdxDesc.bDescending[i];
      pDSFLDDesc pFldDes = &pDs->pFieldDesc[IdxDesc.iKeyFields[i] - 1];

      IdxDesc.iKeyLen += pFldDes->iFldLen;

      switch(pFldDes->iFldType)
      {
      case fldZSTRING:
         {
            FLDString *pFldStr = new FLDString(pFldDes, bDesc, pDs->iLCID);
            pFldStr->bCaseInsensitive = IdxDesc.bCaseInsensitive[i];
            pFldObj = (FLDObj*)pFldStr;
         }break;
      case fldINT8:
         pFldObj = (FLDObj*)new FLDInt8(pFldDes, bDesc);
         break;
      case fldBOOL8:
      case fldUINT8:
         pFldObj = (FLDObj*)new FLDUInt8(pFldDes, bDesc);
         break;
      case fldINT16:
         pFldObj = (FLDObj*)new FLDInt16(pFldDes, bDesc);
         break;
      case fldBOOL16:
      case fldUINT16:
         pFldObj = (FLDObj*)new FLDUInt16(pFldDes, bDesc);
         break;
      case fldBOOL32:
      case fldUINT32:
      case fldDATE:
      case fldTIME:
         pFldObj = (FLDObj*)new FLDUInt32(pFldDes, bDesc);
         break;

      case fldINT32:
         pFldObj = (FLDObj*)new FLDInt32(pFldDes, bDesc);
         break;
      case fldDATETIME:
         pFldObj = (FLDObj*)new FLDTimeStamp(pFldDes, bDesc);
         break;
      case fldDATETIMEOFFSET:
         pFldObj = (FLDObj*)new FLDTimeStampOffset(pFldDes, bDesc);
         break;
      case fldSINGLE:
         pFldObj = (FLDObj*)new FLDSingle(pFldDes, bDesc);
         break;
      case fldTIMESTAMP:
      case fldFLOAT:
         pFldObj = (FLDObj*)new FLDFloat(pFldDes, bDesc);
         break;
      case fldFMTBCD:
      case fldBCD:
         pFldObj = (FLDObj*)new FLDBcd(pFldDes, bDesc);
         break;

      case fldINT64:
         pFldObj = (FLDObj*)new FLDInt64(pFldDes, bDesc);
         break;
      case fldUINT64:
         pFldObj = (FLDObj*)new FLDUInt64(pFldDes, bDesc);
         break;
      case fldUNICODE: // (Length prefixed)
         {
            FLDUniCode *pFldUni = new FLDUniCode(pFldDes, bDesc, pDs->iLCID);
            pFldUni->bCaseInsensitive = IdxDesc.bCaseInsensitive[i];
            pFldObj = (FLDObj*)pFldUni;
         }break;
      case fldVARBYTES: // (Length prefixed)
         pFldObj = (FLDObj*)new FLDVarBytes(pFldDes, bDesc);
         break;
      case fldBLOB:
         pFldObj = (FLDObj*)new FLDBlob(pFldDes, bDesc);
         break;
      case fldBYTES: // (byte compatible)
      default:
         pFldObj = new FLDObj(pFldDes, bDesc);
         break;
      }
      ppFldObjs[i] = pFldObj;
   }
   return DBIERR_NONE;
}
