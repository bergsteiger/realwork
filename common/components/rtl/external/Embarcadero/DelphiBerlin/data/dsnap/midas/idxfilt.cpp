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

DSIDXFILT::DSIDXFILT(DSBASE * pDS)
{
   iType = idxFilter;
   pDs = pDS;
   iRecordSize = 0;
   pRecBuf = NULL;
   pFilt = NULL;
}

DSIDXFILT::~DSIDXFILT()
{
   if (pRecBuf)
      DsFree(pRecBuf);
   pRecBuf = NULL;
   iRecordSize = 0;
   if (pFilt)
   {
      delete pFilt;
      pFilt = NULL;
   }
}

// Create an order, given a definition, or recompile order
DBIResult DSIDXFILT::IdxCreateOrder(pDSIDXDesc pIdxDesc, pDSIDX pIdxSameOrder)
{
   DBIResult rslt = DBIERR_NONE;

   if (piOrder)
   {
      DsFree(piOrder);
      piOrder = NULL;
      iRecsMax = 0; //
   }

   iRecs = 0;
   iSeqNo = 0;

   // Sets iRecsMax
   if (piOrder == NULL)
   {
      if (pDs->iRecords > 500)
         GrowIDX(pDs->iRecords/5 +10); // Some estimate
      else
         GrowIDX(pDs->iRecords+10);
   }

   // move to local
   if (pIdxDesc)
   { // New order
      rslt = InitIdxDesc(pIdxDesc);
      if (rslt)
         goto Exit;
   }

   if (iRecordSize)
   {
      if (iRecordSize != pDs->iRecordSize && pFilt)
      { // Must reevaluate all filters!
         pFilt->Recompile();
         DsFree(pRecBuf);
         pRecBuf = NULL;
         goto Realloc;
      }
   }
   else
   {
   Realloc:
      iRecordSize = pDs->iRecordSize;
      pRecBuf = (pBYTE)DsCalloc(1, iRecordSize);
      if (pRecBuf == NULL)
      {
         rslt = DBIERR_NOMEMORY;
         goto Exit;
      }
   }

   rslt = SortData(pIdxSameOrder);
Exit:
   return rslt;
}

DBIResult DSIDXFILT::IdxInsert(UINT32 iRecNo)
{
   DBIResult rslt = DBIERR_NONE;

   if (RecordIsIn(iRecNo))
      rslt = DSIDX::IdxInsert(iRecNo); //
   return rslt;
}

DBIResult DSIDXFILT::IdxDelete(UINT32 iRecNo)
{
   DBIResult rslt = DBIERR_NONE;

   if (RecordIsIn(iRecNo)) // If iRecs is very small, just check piOrder
      rslt = DSIDX::IdxDelete(iRecNo); //
   return rslt;
}

// iRecNo1 is 'new' modified record
DBIResult DSIDXFILT::IdxModify(UINT32 iRecNoNew, UINT32 iRecNoOld)
{
   DBIResult rslt = DBIERR_NONE;
   BOOL bOldIsIn, bNewIsIn;

   bOldIsIn = RecordIsIn(iRecNoOld); // If iRecs is very small, just check piOrder
   bNewIsIn = RecordIsIn(iRecNoNew);

   if (bOldIsIn && bNewIsIn)
      rslt = DSIDX::IdxModify(iRecNoNew, iRecNoOld);
   else
   {
      if (bNewIsIn)
         rslt = DSIDX::IdxInsert(iRecNoNew); // Insert new one
      else
      {
         if (bOldIsIn)
            rslt = DSIDX::IdxDelete(iRecNoOld); // Delete old one
      } // if !bOldIsIn && !bNewIsIn -> do nothing
   }
   return rslt;
}

BOOL DSIDXFILT::RecordIsIn(UINT32 iRecNo)
{
   DBIResult rslt;

   if (pFilt == NULL || pFilt->iLast == 0)
      return TRUE; // No active filter

   // Optimize
   rslt = pDs->GetRecord(iRecNo, pRecBuf);
   if (rslt)
      return FALSE;
   return pFilt->Evaluate(pRecBuf);
}

DBIResult DSIDXFILT::IdxAddFilter(pBYTE pCanExpr, UINT32 iLen, pULONGP piId)
{
   DBIResult rslt;

   if (pFilt == NULL)
   {
      pFilt = new DSCONSTR(pDs);
   }
   rslt = pFilt->Add(pCanExpr, iLen, fltCANEX, piId);
   return rslt;
}

DBIResult DSIDXFILT::IdxAddFilter(ULONGP iClientData, pfDSFilter pfFilter, pULONGP piId)
{
   DBIResult rslt;

   if (pFilt == NULL)
   {
      pFilt = new DSCONSTR(pDs);
   }
   rslt = pFilt->Add(iClientData, pfFilter, piId);
   return rslt;
}

DBIResult DSIDXFILT::IdxRemFilter(UINT32 iId)
{
   DBIResult rslt;

   if (pFilt)
   {
      rslt = pFilt->Remove(iId);
      if (pFilt->iLast == 0)
      {
         delete pFilt;
         pFilt = NULL;
      }
   }
   else
      rslt = DBIERR_NA;
   return rslt;
}
