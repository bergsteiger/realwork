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

#include "canex.h"

// TODO : - make sure 'pGroups' is deallocated when index is removed
// - cloning, in case of using filters. Agg-handles must be preserved.
// - special issues with 'appending' to partial datasets,

// iSubGroupID is 0-based
// piSBG   is 1-based

IDXGROUPING::IDXGROUPING(DSIDX *pIdx, // Associate with this index
   UINT32 iFields // Grouping defined on these fields
)
{
   this->pIdx = pIdx;
   this->iFields = iFields;
   pAggsMng = NULL;
   iSubGroupCnt = 0;
   piSBG = NULL;
   iSizeSBG = 0;
}

IDXGROUPING::~IDXGROUPING()
{
   if (pAggsMng)
      delete pAggsMng;
   pIdx = NULL;
   iFields = 0;
   iSubGroupCnt = 0;
   if (piSBG)
      DsFree(piSBG);
   piSBG = NULL;
   iSizeSBG = 0;
}

// Increase capacity of
DBIResult IDXGROUPING::GrowSBG(UINT32 iInc)
{
   DBIResult rslt = DBIERR_NONE;
   pBYTE pTmp = (pBYTE)piSBG;
   UINT32 iSize = iSizeSBG*sizeof(UINT32);
   UINT32 iNewSize = iSize + iInc*sizeof(UINT32);

   pTmp = (pBYTE)DsRealloc((pVOID)pTmp, iSize, iNewSize);
   if (pTmp == NULL)
   {
      rslt = DBIERR_NOMEMORY;
   }
   else
   {
      piSBG = (pUINT32)pTmp;
      iSizeSBG += iInc;
   }
   return rslt;
}

// Must be called only once to sync with the current index, BEFORE aggregates
// are added.
DBIResult DBIFN IDXGROUPING::Initialize()
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;

   if (iFields && pIdx)
   {
      if (pIdx->iRecs + 1 >= iSizeSBG)
      {
         rslt = GrowSBG(pIdx->iRecs - iSizeSBG + 50);
         if (rslt)
            return rslt;
      }
      iSubGroupCnt = 0;
      if (pIdx->iRecs >=1)
      {
         piSBG[1] = iSubGroupCnt;
         for (i = 1+1; i <= pIdx->iRecs; i++) // Establish subgroup for each record in index
         {
            if (InSameSubGroup(i-1, i))
            {
               piSBG[i] = iSubGroupCnt;
            }
            else
            {
               piSBG[i] = ++iSubGroupCnt; // Create new subgroupid
            }
         }
      }
   }
   return rslt;
}

DBIResult DBIFN IDXGROUPING::Reset(VOID)
{
   DBIResult rslt = DBIERR_NONE;

   if (pAggsMng)
   {
      rslt = pAggsMng->Reset();
   }
   iSubGroupCnt = 0;
   ZeroMem(piSBG, iSizeSBG);
   return rslt;
}

VOID IDXGROUPING::MakeSpaceSBG(UINT32 iPos, UINT32 iLen)
{
   UINT32 i;

   if (iLen)
      for (i = iLen; i >= iPos; i--)
         piSBG[i+1] = piSBG[i];
}

// Move all elements following iPos one position back
VOID IDXGROUPING::RemSpaceSBG(UINT32 iPos, UINT32 iLen)
{
   INT32 iMove = iLen - iPos /* -1 */ ;
   if (iMove > 0)
      CopyMem((pVOID) &piSBG[iPos], (pVOID) &piSBG[iPos+1], (UINT32)sizeof(UINT32)*(iMove));
}

// Returns TRUE, if the 2 records are in the same group (matches on iFields)
BOOL DBIFN IDXGROUPING::InSameSubGroup(UINT32 iPos1, UINT32 iPos2)
{
   UINT32 iRecNo1;

   iRecNo1 = pIdx->IdxSeqNoToRecNo(iPos1);

   return(pIdx->IdxComp(iRecNo1, iFields, iPos2) == 0);
}

DBIResult DBIFN IDXGROUPING::Clone(DSIDX *pIdx2, // NULL : same index
   IDXGROUPING **ppGr)
{
   DBIResult rslt = DBIERR_NONE;
   IDXGROUPING *pGr;

   if (pIdx2 == NULL)
      pIdx2 = pIdx;

   if (ppGr == NULL)
      return DBIERR_NA;

   pGr = new IDXGROUPING(pIdx2, iFields);
   if (pGr == NULL)
      rslt = DBIERR_INVALIDPARAM;
   else
   {
      rslt = pGr->Initialize(); // Sync with index
      if (rslt)
         goto Exit;
      if (pAggsMng)
      {
         rslt = pAggsMng->Clone(&pGr->pAggsMng);
         if (rslt)
            goto Exit;
      }
   }

Exit:
   if (ppGr)
   {
      *ppGr = (rslt)? NULL : pGr;
   }
   if (rslt && pGr)
      delete pGr;
   return rslt;
}

DBIResult DBIFN IDXGROUPING::AddAggs( // Create aggregates with given grouping
   UINT32 iCanLen, pBYTE pCanExpr, phDSAggregate phAgg)
{
   DBIResult rslt = DBIERR_NONE;

   if (iCanLen && pCanExpr)
   {
      if (pAggsMng == NULL)
      {
         pAggsMng = new AGGSMNG(pIdx->pDs);
         if (pAggsMng == NULL)
            return DBIERR_NOMEMORY;
      }
      rslt = pAggsMng->Add(iCanLen, pCanExpr, (pUINT32)phAgg);
   }
   else
   {
      if (phAgg)
         *phAgg = 0;
   }
   if (rslt == DBIERR_NONE && phAgg)
      *phAgg += iFields << 16; // Upper word contains grouping!
   return rslt;
}

DBIResult DBIFN IDXGROUPING::DropAggs(hDSAggregate hAgg)
{
   DBIResult rslt;
   hDSAggregate hAggInt = hAgg & 0x0000ffff;

   // Check if hAgg contains an aggregate at all
   if (hAggInt == 0)
      return DBIERR_NONE; // Just ignore

   if (pAggsMng == NULL)
      rslt = DBIERR_NA;
   else
      rslt = pAggsMng->Drop(hAggInt);
   return rslt;
}

DBIResult DBIFN IDXGROUPING::GetAggValue(hDSAggregate hAgg, UINT32 iPos, pBYTE pValue, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iSubGroupId = 0;
   UINT32 iAggState;
   pBYTE pRecBuf = NULL;

   if (pAggsMng == NULL)
      return DBIERR_NA;

   // Validate iPos ?
   if (piSBG) // iFields && pIdx
   { // Maintain piSBG
      iSubGroupId = piSBG[iPos];
   }
   // Validate iSubGroupId?
   pAggsMng->GetAggValue(hAgg, iSubGroupId, pValue, pbBlank, &iAggState, NULL);
   if (iAggState != aggSTATEOK)
   { // Needs a recalc
      rslt = pAggsMng->ResetAggValue(hAgg, iSubGroupId);
      if (rslt == DBIERR_NONE)
      {
         UINT32 iPosFirst, iCnt, i;

         RangeOfSubGroup(iPos, &iPosFirst, &iCnt);

         rslt = GetByteBuffer(pIdx->pDs->iRecordSize, &pRecBuf, FALSE);
         if (rslt)
            goto Exit;
         for (i = iPosFirst; i < iPosFirst + iCnt; i++)
         {
            UINT32 iRecNo;
            iRecNo = pIdx->IdxSeqNoToRecNo(i);
            rslt = pIdx->pDs->GetRecord(iRecNo, pRecBuf);
            if (rslt)
               break;
            rslt = pAggsMng->AddAggValue(hAgg, iSubGroupId, pRecBuf);
            if (rslt)
               break;
         }
         if (rslt == DBIERR_NONE)
         {
            rslt = pAggsMng->GetAggValue(hAgg, iSubGroupId, pValue, pbBlank, &iAggState, NULL);
         }
      }
   }
Exit:
   if (pRecBuf)
      delete pRecBuf;
   return rslt;
}

DBIResult DBIFN IDXGROUPING::GetAggDesc(hDSAggregate hAgg, pDSFLDDesc pDesc)
{
   DBIResult rslt = DBIERR_NONE;

   if (pAggsMng == NULL)
      return DBIERR_NA;
   rslt = pAggsMng->GetAggDesc(hAgg, pDesc);
   return rslt;
}

// Maintains aggregates/subgrouping
DBIResult DBIFN IDXGROUPING::Insert(UINT32 iPos, pBYTE pRecBuf)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iSubGroupId = 0;

   if (iFields && pIdx)
   { // Maintain piSBG
      if (pIdx->iRecs + 2 >= iSizeSBG) // (+2 because we are inserting, and array is 1-based)
      {
         rslt = GrowSBG(pIdx->iRecs - iSizeSBG + 50);
         if (rslt)
            return rslt;
      }
      MakeSpaceSBG(iPos, pIdx->iRecs-1); // -1 because irecs has been incremented already
      if (iPos > 1 && InSameSubGroup(iPos, iPos-1))
      { // Same group as previous
         iSubGroupId = piSBG[iPos-1];
      }
      else
      {
         if (iPos < pIdx->iRecs && InSameSubGroup(iPos, iPos+1))
         {
            iSubGroupId = piSBG[iPos+1];
         }
         else
         { // New group
            iSubGroupId = ++iSubGroupCnt;
         }
      }
      piSBG[iPos] = iSubGroupId;
   }
   // For all aggregates, update the value for iSubGroupId
   // (if 0, aggs are global)
   if (pAggsMng) // Could be NULL if there are no expression on grouping
   {
      pAggsMng->AddAggValue(0, iSubGroupId, pRecBuf);
   }

   return rslt;
}

DBIResult DBIFN IDXGROUPING::Delete(UINT32 iPos, pBYTE pRecBuf)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iSubGroupId = 0;

   if (piSBG) // iFields && pIdx
   { // Maintain piSBG
      iSubGroupId = piSBG[iPos];
      RemSpaceSBG(iPos, pIdx->iRecs+1); // +1 because irecs has been decremented already
   }
   // For all aggregates, update the value for iSubGroupId
   // (if 0, aggs are global)
   if (pAggsMng) // Could be NULL if there are no expression on grouping
   {
      pAggsMng->SubAggValue(0, iSubGroupId, pRecBuf);
   }

   return rslt;
}

DBIResult DBIFN IDXGROUPING::Modify(UINT32 iPos1, // Old value
   UINT32 iPos2, // Modified value
   pBYTE pRecBuf1, pBYTE pRecBuf2)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iSubGroupId1 = 0;
   UINT32 iSubGroupId2 = 0;

   if (iFields && pIdx)
   { // Maintain piSBG
      if (pIdx->iRecs + 1 >= iSizeSBG)
      {
         rslt = GrowSBG(pIdx->iRecs - iSizeSBG + 50);
         if (rslt)
            return rslt;
      }
      iSubGroupId1 = piSBG[iPos1];
      if (iPos1 != iPos2)
      {
         RemSpaceSBG(iPos1, pIdx->iRecs);
         MakeSpaceSBG(iPos2, pIdx->iRecs-1);
      }
      if (iPos2 > 1 && InSameSubGroup(iPos2, iPos2-1))
      { // Same group as previous
         iSubGroupId2 = piSBG[iPos2-1];
      }
      else
      {
         if (iPos2 < pIdx->iRecs && InSameSubGroup(iPos2, iPos2+1))
         {
            iSubGroupId2 = piSBG[iPos2+1];
         }
         else
         { // New group
            iSubGroupId2 = ++iSubGroupCnt;
         }
      }
      piSBG[iPos2] = iSubGroupId2;
   }
   // For all aggregates, update the value for iSubGroupId
   // (if 0, aggs are global)
   // Remove values
   // Add values
   if (pAggsMng)
   {
      if (iSubGroupId1 == iSubGroupId2)
      {
         pAggsMng->UpdAggValue(0, iSubGroupId1, pRecBuf1, pRecBuf2);
      }
      else
      {
         pAggsMng->SubAggValue(0, iSubGroupId1, pRecBuf1);
         pAggsMng->AddAggValue(0, iSubGroupId2, pRecBuf2);
      }
   }

   return rslt;
}

DBIResult DBIFN IDXGROUPING::NextSubGroup( // Move to first record in next subgroup, if any
   UINT32 iPos, // Current Position
   pUINT32 piPos // Return position of first record in next subgroup
   )
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;

   if (piSBG)
   {
      UINT32 iSubGroupId = piSBG[iPos];

      for (i = iPos+1; i <= pIdx->iRecs; i++)
      {
         if (piSBG[i] != iSubGroupId)
         {
            if (piPos)
               *piPos = i;
            return rslt;
         }
      }
      rslt = DBIERR_EOF;
   }
   else
      rslt = DBIERR_NA;
   return rslt;
}

DBIResult DBIFN IDXGROUPING::GetSubGroupState(UINT32 iPos, GROUPSTATE *piState)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iState = grSTATEMIDDLE;

   if (piSBG)
   {
      UINT32 iSubGroupId = piSBG[iPos];
      if (iPos <= 1 || piSBG[iPos-1] != iSubGroupId)
         iState |= grSTATEFIRST;
      if (iPos >= pIdx->iRecs || piSBG[iPos+1] != iSubGroupId)
         iState |= grSTATELAST;
      if (piState)
         *piState = (GROUPSTATE)iState; // (Note that iState could be BOTH first AND last!)
   }
   else
      rslt = DBIERR_NA;

   return rslt;
}

DBIResult DBIFN IDXGROUPING::RangeOfSubGroup( // Determines first position for subgroup, and number of elements
   UINT32 iPosCurrent, // Current position
   pUINT32 piPosFirst, // First position for subgroup of iPosCurrent
   pUINT32 piCnt // Number of elements
   )
{

   DBIResult rslt = DBIERR_NONE;
   UINT32 i, iPosFirst, iCnt;

   if (piSBG)
   {
      UINT32 iSubGroupId = piSBG[iPosCurrent];

      // Find first pos
      i = iPosCurrent;
      while (i > 0 && piSBG[i] == iSubGroupId)
      {
         i--;
      }
      iPosFirst = i+1;
      iCnt = 0;
      for (i = iPosFirst; i <= pIdx->iRecs; i++)
      {
         if (piSBG[i] == iSubGroupId)
         {
            iCnt++;
         }
         else
            break;
      }
   }
   else
   {
      iPosFirst = 1;
      iCnt = pIdx->iRecs;
   }
   if (piPosFirst)
      *piPosFirst = iPosFirst;
   if (piCnt)
      *piCnt = iCnt;

   return rslt;
}

IDXGROUPINGMNG::IDXGROUPINGMNG(DSIDX *pIdx)
{
   UINT32 i;

   iGroups = 0;
   this->pIdx = pIdx;
   for (i = 0; i < MAXGROUPINGS; i++)
      pGroupings[i] = NULL;
   pRecBuf1 = NULL;
   pRecBuf2 = NULL;
}

IDXGROUPINGMNG::~IDXGROUPINGMNG()
{
   UINT32 i;

   for (i = 0; i < MAXGROUPINGS; i++)
   {
      if (iGroups == 0)
         break;
      if (pGroupings[i])
      {
         delete pGroupings[i];
         iGroups--;
         // DropAggs(i);
      }
   }
   pIdx = NULL;
   if (pRecBuf1)
      delete[] pRecBuf1;
   pRecBuf1 = NULL;
   if (pRecBuf2)
      delete[] pRecBuf2;
   pRecBuf2 = NULL;
}

DBIResult DBIFN IDXGROUPINGMNG::Reset(VOID)
{
   UINT32 i;

   for (i = 0; i < MAXGROUPINGS; i++)
   {
      if (iGroups == 0)
         break;
      if (pGroupings[i])
         pGroupings[i]->Reset();
   }
   return DBIERR_NONE;
}

DBIResult DBIFN IDXGROUPINGMNG::AllocRecBuffs()
{
   if (pRecBuf1 == NULL)
   {
      UINT32 iRecBufSize = pIdx->pDs->iRecordSize;
      pRecBuf1 = new BYTE[iRecBufSize];
   }
   if (pRecBuf2 == NULL)
   {
      UINT32 iRecBufSize = pIdx->pDs->iRecordSize;
      pRecBuf2 = new BYTE[iRecBufSize];
   }
   if (pRecBuf1 == NULL || pRecBuf2 == NULL)
      return DBIERR_NOMEMORY;
   return DBIERR_NONE;
}

DBIResult DBIFN IDXGROUPINGMNG::Clone(DSIDX *pIdx2, // NULL : same index
   class IDXGROUPINGMNG **ppGMng)
{
   DBIResult rslt = DBIERR_NONE;
   IDXGROUPINGMNG *pGMng = NULL;

   if (pIdx2 == NULL)
      pIdx2 = pIdx;

   pGMng = new IDXGROUPINGMNG(pIdx2);
   if (pGMng)
   {
      UINT32 i;
      rslt = pGMng->AllocRecBuffs();
      if (rslt)
         goto Exit;

      for (i = 0; i < MAXGROUPINGS; i++)
      {
         IDXGROUPING *pGr = NULL;
         if (pGroupings[i])
         {
            rslt = pGroupings[i]->Clone(pIdx2, &pGr);
            if (rslt)
               goto Exit;
            pGMng->pGroupings[i] = pGr;
            pGMng->iGroups++;
         }
      }
   }
   else
      rslt = DBIERR_NOMEMORY;

Exit:
   if (ppGMng)
   {
      *ppGMng = (rslt)? NULL : pGMng;
   }
   if (rslt && pGMng)
      delete pGMng;

   return rslt;
}

IDXGROUPING * DBIFN IDXGROUPINGMNG::GetGroupObj( // Return group-object for given hAgg
   hDSAggregate hAgg)
{
   UINT32 iGroupId = hAgg >>16;

   if (!ISVALIDGROUPID(iGroupId)) // 0..16
      return NULL; // rslt = DBIERR_OUTOFRANGE;
   return pGroupings[iGroupId];
}

DBIResult DBIFN IDXGROUPINGMNG::AddAggs(UINT32 iFields, // Defines grouping
   UINT32 iCanLen, pBYTE pCanExpr, phDSAggregate phAgg // Handle for aggs
   )
{
   DBIResult rslt = DBIERR_NONE;
   IDXGROUPING *pGr = NULL;
   BOOL bNewGroup = FALSE;

   if (pIdx == NULL)
      return DBIERR_NA;

   if (iFields > pIdx->IdxDesc.iFields)
      return DBIERR_OUTOFRANGE;

   rslt = AllocRecBuffs();
   if (rslt)
      return rslt;

   // Check if the grouping is already defined
   pGr = GetGrouping(iFields);
   if (pGr == NULL)
   {
      bNewGroup = TRUE;
      pGr = new IDXGROUPING(pIdx, iFields);
      if (pGr == NULL)
         rslt = DBIERR_INVALIDPARAM;
      else
      {
         rslt = pGr->Initialize();
      }
   }

   if (rslt == DBIERR_NONE)
   {
      rslt = pGr->AddAggs(iCanLen, pCanExpr, phAgg);
      pGr->iUseCount++;
   }
   if (bNewGroup)
   {
      if (rslt == DBIERR_NONE)
      {
         pGroupings[iFields] = pGr;
         iGroups++;
      }
      else
      {
         delete pGr;
      }
   }

   return rslt;
}

DBIResult DBIFN IDXGROUPINGMNG::DropAggs(hDSAggregate hAgg)
{
   DBIResult rslt = DBIERR_NONE;

   IDXGROUPING *pGr = GetGroupObj(hAgg);
   UINT32 iGroupId = hAgg >>16;

   if (pGr == NULL)
      rslt = DBIERR_INVALIDPARAM;
   else
   {
      rslt = pGr->DropAggs(hAgg);
   }
   if (!rslt && --pGr->iUseCount == 0)
   {
      delete pGr;
      pGroupings[iGroupId] = NULL;
      iGroups--;
   }
   return rslt;
}

DBIResult DBIFN IDXGROUPINGMNG::GetAggValue(hDSAggregate hAgg, UINT32 iPos, pBYTE pValue, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   IDXGROUPING *pGr = GetGroupObj(hAgg);

   if (pGr == NULL)
      rslt = DBIERR_INVALIDPARAM;
   else
   {
      rslt = pGr->GetAggValue(hAgg, iPos, pValue, pbBlank);
   }
   return rslt;
}

DBIResult DBIFN IDXGROUPINGMNG::GetAggDesc(hDSAggregate hAgg, pDSFLDDesc pFldDesc)
{
   DBIResult rslt = DBIERR_NONE;
   IDXGROUPING *pGr = GetGroupObj(hAgg);

   if (pGr == NULL)
      rslt = DBIERR_INVALIDPARAM;
   else
      rslt = pGr->GetAggDesc(hAgg, pFldDesc);
   return rslt;
}

IDXGROUPING * DBIFN IDXGROUPINGMNG::GetGrouping( // Return object for Id
   UINT32 iFields // GroupId, 0..MAXKEYFIELDS
   )
{

   if (!ISVALIDGROUPID(iFields))
      return NULL;

   return pGroupings[iFields];
}

DBIResult DBIFN IDXGROUPINGMNG::NextSubGroup( // Move to first record in next subgroup, if any
   UINT32 iFields, UINT32 iPos, // Current Position
   pUINT32 piPos // Return position of first record in next subgroup
   )
{
   DBIResult rslt = DBIERR_NONE;
   IDXGROUPING *pGr = GetGrouping(iFields);

   if (pGr == NULL)
      rslt = DBIERR_INVALIDPARAM;
   else
      rslt = pGr->NextSubGroup(iPos, piPos);
   return rslt;
}

DBIResult DBIFN IDXGROUPINGMNG::GetSubGroupState( //
   UINT32 iFields, UINT32 iPos, GROUPSTATE *piState)
{
   DBIResult rslt = DBIERR_NONE;
   IDXGROUPING *pGr = GetGrouping(iFields);

   if (pGr == NULL)
      rslt = DBIERR_INVALIDPARAM;
   else
      rslt = pGr->GetSubGroupState(iPos, piState);
   return rslt;
}

DBIResult DBIFN IDXGROUPINGMNG::Insert( // Maintain aggregates after an insert
   UINT32 iPos1)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i, j = iGroups;
   IDXGROUPING *pGr;

   if (pRecBuf1)
   {
      UINT32 iRecNo1 = pIdx->IdxSeqNoToRecNo(iPos1);
      rslt = pIdx->pDs->GetRecord(iRecNo1, pRecBuf1);
      if (rslt)
         return rslt;
   }

   for (i = 0; (i < MAXGROUPINGS) && (j > 0); i++)
   {
      if ((pGr = pGroupings[i]) != NULL)
      {
         rslt = pGr->Insert(iPos1, pRecBuf1);
         if (rslt)
         {
            // Undo aggregates ?
            break;
         }
         else
            j--;
      }
   }
   return rslt;
}

DBIResult DBIFN IDXGROUPINGMNG::Delete( // Maintain aggregates after an insert
   UINT32 iPos1)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i, j = iGroups;
   IDXGROUPING *pGr;

   if (pRecBuf1)
   {
      UINT32 iRecNo1 = pIdx->IdxSeqNoToRecNo(iPos1);
      rslt = pIdx->pDs->GetRecord(iRecNo1, pRecBuf1);
      if (rslt)
         return rslt;
   }
   for (i = 0; (i < MAXGROUPINGS) && (j > 0); i++)
   {
      if ((pGr = pGroupings[i]) != NULL)
      {
         rslt = pGr->Delete(iPos1, pRecBuf1);
         if (rslt)
         {
            // Undo aggregates ?
            break;
         }
         else
            j--;
      }
   }
   return rslt;
}

DBIResult DBIFN IDXGROUPINGMNG::Modify(UINT32 iPos1, UINT32 iPos2)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i, j = iGroups;
   IDXGROUPING *pGr;

   if (pRecBuf1)
   {
      UINT32 iRecNo1 = pIdx->IdxSeqNoToRecNo(iPos1);
      UINT32 iRecNo2 = pIdx->IdxSeqNoToRecNo(iPos2);

      rslt = pIdx->pDs->GetRecord(iRecNo1, pRecBuf1);
      if (rslt)
         return rslt;
      rslt = pIdx->pDs->GetRecord(iRecNo2, pRecBuf2);
      if (rslt)
         return rslt;
   }
   for (i = 0; (i < MAXGROUPINGS) && (j > 0); i++)
   {
      if ((pGr = pGroupings[i]) != NULL)
      {
         rslt = pGr->Modify(iPos1, iPos2, pRecBuf1, pRecBuf2);
         if (rslt)
         {
            // Undo aggregates ?
            break;
         }
         else
            j--;
      }
   }
   return rslt;
}
