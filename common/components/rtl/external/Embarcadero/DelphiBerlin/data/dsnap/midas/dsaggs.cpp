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

AGGS::AGGS(VOID)
{
   iCanLen = 0;
   pCanExpr = NULL;
   pAggObj = NULL;
   pAggValues = NULL;
   iSize = 0;
   iEntries = 0;
   iAggEntryLen = 0;
}

AGGS::~AGGS(VOID)
{
   if (pCanExpr)
      delete pCanExpr;
   pCanExpr = NULL;
   if (pAggObj)
      delete pAggObj;
   pAggObj = NULL;
   if (pAggValues)
      DsFree(pAggValues);
   pAggValues = NULL;

}

DBIResult AGGS::Clone(AGGS **ppAgg)
{
   DBIResult rslt = DBIERR_NONE;
   AGGS *pAgg;

   if (ppAgg == NULL)
      return DBIERR_NA;

   pAgg = new AGGS();
   if (pAgg == NULL)
      rslt = DBIERR_NOMEMORY;
   else
      rslt = pAgg->InitAgg(pDs, iCanLen, pCanExpr, iEntries);

   *ppAgg = (rslt)? NULL : pAgg;

   if (rslt && pAgg)
      delete pAgg;
   return rslt;

}

DBIResult AGGS::InitAgg( //
   DSBASE *pDs, // Base Ds
   UINT32 iCanLen, //
   pBYTE pCanExpr, //
   UINT32 iInitialSize // Number of subgroupids
   )
{
   DBIResult rslt = DBIERR_NONE;

   if (pCanExpr && iCanLen)
   {
      pDSFLDDesc pDsFldDescs, pDsFldDes;
      pFLDDesc pFlds;
      UINT32 i, iFields;

      iFields = pDs->iFields;
      pDsFldDescs = pDs->pFieldDesc;

      pFlds = new FLDDesc[iFields];
      ZeroMem(pFlds, iFields*sizeof(FLDDesc));
      // convert field desc
      for (i = 0; i < iFields; i++)
      {
         pFLDDesc pFldDes = &pFlds[i];

         pDsFldDes = &pDsFldDescs[i];
         pFldDes->iFldNum = (UINT16)(i+1);
         LdStrCpy(pFldDes->szName, pDsFldDes->szName);
         pFldDes->iFldType = (UINT16)pDsFldDes->iFldType;
         pFldDes->iSubType = (UINT16)pDsFldDes->iFldSubType;
         pFldDes->iUnits1 = (UINT16)pDsFldDes->iUnits1;
         pFldDes->iUnits2 = (UINT16)pDsFldDes->iUnits2;
         pFldDes->iLen = (UINT16)pDsFldDes->iFldLen;
         pFldDes->iOffset = (UINT16)pDsFldDes->iFldOffsInRec;
         pFldDes->iNullOffset = (UINT16)pDsFldDes->iNullOffsInRec;
         // iOffs += pFldDes->iLen;
      }

      pAggObj = new QAggregate();
      if (!pAggObj)
         rslt = DBIERR_NOMEMORY;
      if (rslt == DBIERR_NONE)
         rslt = pAggObj->Prepare(NULL, (pCANExpr)pCanExpr, pDs);

      delete pFlds;

      if (rslt != DBIERR_NONE && pAggObj)
      {
         delete pAggObj;
         pAggObj = NULL;
      }

      if (pAggObj != NULL)
      {
         pFLDDesc pFldDes;
         UINT16 DataLength;

         this->pCanExpr = new BYTE[iCanLen];
         CopyMem(this->pCanExpr, pCanExpr, iCanLen);
         this->iCanLen = iCanLen;

         pFldDes = pAggObj->GetResultType((UINT16*)(&DataLength));

         ZeroMem(&AggFieldDesc, sizeof(AggFieldDesc));
         LdStrCpy(AggFieldDesc.szName, pFldDes->szName);
         AggFieldDesc.iFldType = pFldDes->iFldType;
         AggFieldDesc.iFldSubType = pFldDes->iSubType;
         AggFieldDesc.iUnits1 = pFldDes->iUnits1;
         AggFieldDesc.iUnits2 = pFldDes->iUnits2;
         AggFieldDesc.iFldLen = pFldDes->iLen;

         this->pDs = pDs;
         this->iAggEntryLen = (sizeof(AGGVALUE) + DataLength + 3) & (~(size_t)3);
         Grow(iInitialSize + 10);
      }
      else if (rslt == DBIERR_NONE)
         rslt = DBIERR_NA;
   }
   return rslt;
}

DBIResult AGGS::Grow(UINT32 iInc) // Grow size
{
   UINT32 iIncSize = iInc*iAggEntryLen;
   pBYTE pTmp;

   pTmp = (pBYTE)DsRealloc((pVOID)pAggValues,
      sizeof(BYTE) * iSize, sizeof(BYTE) * (iSize + iIncSize));
   if (!pTmp)
      return DBIERR_NOMEMORY;
   pAggValues = (AGGVALUE*)pTmp;
   iSize += iIncSize;
   iEntries += iInc;
   return DBIERR_NONE;
}

DBIResult AGGS::Reset(VOID)
{
   UINT32 iInc = iEntries;

   if (pAggValues)
   {
      DsFree(pAggValues);
      pAggValues = NULL;
      iSize = 0;
      iEntries = 0;
   }
   Grow(iInc + 5);
   return DBIERR_NONE;
}

// Return value for iSubGroupId (1-based)
// Returns NULL, if undefined
AGGVALUE *AGGS::GetEntry(UINT32 iSubGroupId)
{
   pBYTE pEntry = NULL;

   if (iSubGroupId < iEntries)
   {
      pEntry = ((pBYTE)pAggValues) + (iSubGroupId)*iAggEntryLen;
   }
   return(AGGVALUE*)pEntry;
}

DBIResult AGGS::GetAggValue( // Returns agg-value and state
   UINT32 iSubGroupId, pBYTE pValue, // returns agg-value, if any (see state)
   pBOOL pbBlank, pUINT32 piState, // returns state of agg-value, if undefined, must be recalculated using 'AddAggValue'
   pUINT32 piCnt // returns count of records in agg-value
   )
{
   DBIResult rslt = DBIERR_NONE;
   AGGVALUE *pEntry;

   pEntry = GetEntry(iSubGroupId);
   if (pEntry)
   {
      if (piState)
         *piState = pEntry->eAggState;
      if (piCnt)
         *piCnt = pEntry->iCnt;
      pAggObj->GetResult(pEntry, pEntry->Value, pValue, pbBlank);
      // CopyMem(pValue, pEntry->Value, AggFieldDesc.iFldLen);
   }
   else
   {
      if (piState)
         *piState = aggSTATEUNDEF; // 0
      if (piCnt)
         *piCnt = 0;
   }
   return rslt;
}

DBIResult AGGS::ResetAggValue( // Reset agg-value
   UINT32 iSubGroupId // If 0, reset all agg-values for iAggId
   )
{
   DBIResult rslt = DBIERR_NONE;
   AGGVALUE *pEntry;

   if (iSubGroupId + 1 > iEntries)
      rslt = Grow(iSubGroupId - iEntries + 10);
   if (rslt == DBIERR_NONE)
   {
      pEntry = GetEntry(iSubGroupId); // MUST be != NULL!
      ZeroMem(pEntry, iAggEntryLen);
      pEntry->eAggState = aggSTATEOK;
   }
   return rslt;
}

DBIResult AGGS::AddAggValue( // Add contribution from inserted record
   UINT32 iSubGroupId, pBYTE pRecBuf)
{
   DBIResult rslt = DBIERR_NONE;
   AGGVALUE *pEntry;

   pEntry = GetEntry(iSubGroupId);
   if (pEntry && pEntry->eAggState == aggSTATEOK)
   {
      pAggObj->AddValue(pEntry, pRecBuf);
      // rslt = pAggObj->....();
      // if (rslt)
      // {
      // pEntry->eAggState = aggSTATEERROR;
      // }
      // else
      pEntry->iCnt++;
   }
   else
   { // Ignore
   }
   return rslt;
}

DBIResult AGGS::SubAggValue( // Remove contribution from deleted record
   UINT32 iSubGroupId, pBYTE pRecBuf)
{
   DBIResult rslt = DBIERR_NONE;
   AGGVALUE *pEntry;

   pEntry = GetEntry(iSubGroupId);
   if (pEntry && pEntry->eAggState == aggSTATEOK && pEntry->iCnt > 0)
   {
      rslt = pAggObj->SubValue(pEntry, pRecBuf); // (BOOL)
      // rslt = pAggObj->....();
      if (rslt)
      {
         pEntry->eAggState = aggSTATEERROR;
      }
      else
         pEntry->iCnt--;
   }
   else
   { // Ignore
   }
   return rslt;
}

DBIResult AGGS::UpdAggValue( // Update contribution from a changed record
   UINT32 iSubGroupId, pBYTE pRecBufRem, pBYTE pRecBufAdd)
{
   DBIResult rslt = DBIERR_NONE;
   AGGVALUE *pEntry;

   UNREFERENCED_PARAMETER(pRecBufRem);
   UNREFERENCED_PARAMETER(pRecBufAdd);

   pEntry = GetEntry(iSubGroupId);
   if (pEntry && pEntry->eAggState == aggSTATEOK && pEntry->iCnt > 0)
   {
      // rslt = pAggObj->....();
      if (rslt)
      {
         pEntry->eAggState = aggSTATEERROR;
      }
      else
      {
         // pEntry->iCnt--;
      }
   }
   else
   { // Ignore
   }
   return rslt;
}

AGGSMNG::AGGSMNG(class DSBASE *pDs)
{
   this->pDs = pDs;
   iSize = 0;
   iLast = 0;
   pEntries = NULL;
   iAggs = 0;
}

AGGSMNG::~AGGSMNG()
{
   UINT32 i;

   if (pEntries)
   {
      for (i = 0; i < iLast; i++)
      {
         if (pEntries[i])
         {
            delete pEntries[i]; // Free handle, if any
            pEntries[i] = NULL;
            iAggs--;
         }
      }
      delete pEntries;
      pEntries = NULL;
   }
}

DBIResult AGGSMNG::Grow(UINT32 iInc) // Grow size
{
   pBYTE pTmp;

   pTmp = (pBYTE)DsRealloc((pVOID)pEntries,
      sizeof(AGGS*) * iSize, sizeof(AGGS*) * (iSize + iInc));
   if (!pTmp)
      return DBIERR_NOMEMORY;
   pEntries = (AGGS **)pTmp;
   iSize += iInc;
   return DBIERR_NONE;
}

AGGS *AGGSMNG::GetEntry(UINT32 iAggId)
{
   // Mask out upper word (grouping)
   iAggId &= 0x0000ffff;
   if (iAggId > 0 && iAggId <= iLast && pEntries && pEntries[iAggId-1])
      return pEntries[iAggId-1];
   return NULL;
}

DBIResult AGGSMNG::Clone(AGGSMNG **ppAMng // Return clone of whole object
   )
{
   DBIResult rslt = DBIERR_NONE;
   AGGSMNG *pAMng;

   if (ppAMng == NULL)
      return DBIERR_NA;

   pAMng = new AGGSMNG(pDs);
   if (pAMng == NULL)
      rslt = DBIERR_NOMEMORY;
   else
   {
      if (iAggs)
      {
         UINT32 i;

         rslt = pAMng->Grow(iSize); // Make it same size
         if (rslt)
            goto Exit;
         pAMng->iLast = iLast;
         for (i = 0; i < iLast; i++)
         {
            AGGS *pAgg;

            if (pEntries[i])
            {
               rslt = pEntries[i]->Clone(&pAgg);
               if (rslt)
                  goto Exit;
               pAMng->pEntries[i] = pAgg;
               pAMng->iAggs++;
            }
         }
      }
   }

Exit:
   *ppAMng = (rslt)? NULL : pAMng;

   if (rslt && pAMng)
      delete pAMng;
   return rslt;
}

// Aggregate Id is position in array +1
DBIResult AGGSMNG::Add(UINT32 iCanLen, pBYTE pCanExpr, pUINT32 piAggId) // Add aggregate
{
   DBIResult rslt = DBIERR_NONE;

   if (iLast >= iSize)
   {
      Grow(1);
   }

   pEntries[iLast] = NULL;
   if (pCanExpr && iCanLen)
   {
      AGGS * pAgg = new AGGS();
      if (pAgg == NULL)
         rslt = DBIERR_NOMEMORY;
      else
      {
         rslt = pAgg->InitAgg(pDs, iCanLen, pCanExpr, 0);
         if (rslt == DBIERR_NONE)
         {
            pEntries[iLast] = pAgg;
            iLast++;
            iAggs++;
            if (piAggId)
               *piAggId = iLast;
         }
      }
   }
   return rslt;
}

DBIResult AGGSMNG::Drop( // Remove aggregate
   UINT32 iAggId)
{
   DBIResult rslt = DBIERR_NONE;
   AGGS *pAggs = GetEntry(iAggId);

   if (pAggs)
   {
      delete pAggs;
      iAggId &= 0x0000ffff;
      pEntries[iAggId-1] = NULL;
      iAggs--;
   }
   else
      rslt = DBIERR_INVALIDPARAM;
   return rslt;
}

DBIResult AGGSMNG::GetAggDesc( // Returns field-desc of agg-value
   UINT32 iAggId, pDSFLDDesc pFldDesc)
{
   DBIResult rslt = DBIERR_NONE;
   AGGS *pAggs = GetEntry(iAggId);

   if (pAggs)
   {
      if (pFldDesc)
         CopyMem(pFldDesc, &pAggs->AggFieldDesc, sizeof(DSFLDDesc));
   }
   else
      rslt = DBIERR_INVALIDPARAM;
   return rslt;
}

DBIResult AGGSMNG::GetAggValue( // Returns agg-value and state
   UINT32 iAggId, //
   UINT32 iSubGroupId, //
   pBYTE pValue, // returns agg-value, if any (see state)
   pBOOL pbBlank, //
   pUINT32 piState, // returns state of agg-value, if undefined, must be recalculated using 'AddAggValue'
   pUINT32 piCnt // returns count of records in agg-value
   )
{
   DBIResult rslt;
   AGGS *pAggs = GetEntry(iAggId);

   if (pAggs)
   {
      rslt = pAggs->GetAggValue(iSubGroupId, pValue, pbBlank, piState, piCnt);
   }
   else
      rslt = DBIERR_INVALIDPARAM;
   return rslt;
}

DBIResult AGGSMNG::ResetAggValue( // Reset agg-value
   UINT32 iAggId, // If 0, reset all agg-values for iSubGroup
   UINT32 iSubGroupId // If 0, reset all agg-values for iAggId
   )
{
   DBIResult rslt;
   AGGS *pAggs = GetEntry(iAggId);

   if (pAggs)
   {
      rslt = pAggs->ResetAggValue(iSubGroupId);
   }
   else
      rslt = DBIERR_INVALIDPARAM;
   return rslt;
}

DBIResult AGGSMNG::AddAggValue( // Add contribution from inserted record
   UINT32 iAggId, UINT32 iSubGroupId, pBYTE pRecBuf)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   AGGS *pAggs;

   if (iAggId != 0)
   {
      pAggs = GetEntry(iAggId);
      pAggs->AddAggValue(iSubGroupId, pRecBuf); // (ignore result)
   }
   else
   {
      for (i = 0; i < iLast; i++)
      {
         if ((pAggs = pEntries[i]) != NULL)
         {
            pAggs->AddAggValue(iSubGroupId, pRecBuf); // (ignore result)
         }
      }
   }
   return rslt;
}

DBIResult AGGSMNG::SubAggValue( // Remove contribution from deleted record
   UINT32 iAggId, UINT32 iSubGroupId, pBYTE pRecBuf)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   AGGS *pAggs;

   if (iAggId != 0)
   {
      pAggs = GetEntry(iAggId);
      pAggs->AddAggValue(iSubGroupId, pRecBuf); // (ignore result)
   }
   else
   {
      for (i = 0; i < iLast; i++)
      {
         if ((pAggs = pEntries[i]) != NULL)
         {
            pAggs->SubAggValue(iSubGroupId, pRecBuf); // (ignore result)
         }
      }
   }
   return rslt;
}

DBIResult AGGSMNG::UpdAggValue( // Update contribution from a changed record
   UINT32 iAggId, // 0 -> All aggs
   UINT32 iSubGroupId, pBYTE pRecBufRem, pBYTE pRecBufAdd)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   AGGS *pAggs;

   if (iAggId != 0)
   {
      pAggs = GetEntry(iAggId);
      pAggs->UpdAggValue(iSubGroupId, pRecBufRem, pRecBufAdd); // (ignore result)
   }
   else
   {
      for (i = 0; i < iLast; i++)
      {
         if ((pAggs = pEntries[i]) != NULL)
         {
            pAggs->UpdAggValue(iSubGroupId, pRecBufRem, pRecBufAdd); // (ignore result)
         }
      }
   }
   return rslt;
}

DBIResult AGGSMNG::Reset() // Reset all aggregates
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   AGGS *pAggs;

   for (i = 0; i < iLast; i++)
   {
      if ((pAggs = pEntries[i]) != NULL)
      {
         pAggs->Reset();
      }
   }
   return rslt;
}

DBIResult AGGSMNG::Recompile() // After change (AddField) // Recreate all QAggregates
{
   return DBIERR_NA;
}
