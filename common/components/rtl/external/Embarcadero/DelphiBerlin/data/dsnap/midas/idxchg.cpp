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

DSIDXCHG::DSIDXCHG(DSBASE * pDS)
{
   pDs = pDS;
   iType = idxChange;
   bDisabled = FALSE;
   iVisibleAttr = 0;
}

DSIDXCHG::~DSIDXCHG()
{
}

DBIResult DSIDXCHG::IdxCreateOrder(pDSIDXDesc pIdxDesc, pDSIDX pIdxSameOrder)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   // DSAttr      iAttr;
   // BOOL        bVisible;

   UNREFERENCED_PARAMETER(pIdxSameOrder);

   bDisabled = FALSE;
   if (piOrder)
   {
      DsFree(piOrder);
      piOrder = NULL;
      iRecsMax = 0;
   }

   iSeqNo = 0;
   iRecs = 0;
   if (pDs->pDsLog && pDs->pDsLog->iLast >0)
      GrowIDX(pDs->pDsLog->iLast + 10);

   if (pIdxDesc)
   { // New order  (nescessary ?)
      rslt = InitIdxDesc(pIdxDesc);
      if (rslt)
         goto Exit;
   }

   if (pDs->pDsLog)
   {
      pLOGENTRY pEntry;

      for (i = 0; i < pDs->pDsLog->iLast; i++)
      {
         pEntry = &pDs->pDsLog->pLogEntries[i];
         // if (pEntry->iRecNo2) // Original record
         // {
         // rslt = IdxInsert(pEntry->iRecNo2);
         // if (rslt)
         // { //Back-out
         // break;
         // }
         // }
         // rslt = IdxInsert(pEntry->iRecNo1);

         // Replay the changes in the original order
         switch(pEntry->iAttr)
         {
         case dsRecModified:
            rslt = IdxModify(pEntry->iRecNo1, pEntry->iRecNo2);
            break;
         case dsRecNew:
            rslt = IdxInsert(pEntry->iRecNo1);
            break;
         case dsRecDeleted:
            rslt = IdxDelete(pEntry->iRecNo1);
            break;
         case dsDetUpd:
            break;
         }
         if (rslt)
         { // Back-out
            break;
         }
      }
   }
Exit:
   return rslt;
}

DBIResult DSIDXCHG::IdxInsert(UINT32 iRecNo)
{
   DBIResult rslt = DBIERR_NONE;

   if (bDisabled || pDs->bDisableLog)
      goto Exit;
   if (!(iVisibleAttr == 0 || iVisibleAttr & dsRecNew))
      goto Exit;
   if (!(pDs->piAttr[iRecNo-1] & dsRecNew)) // Undo deleted record
      rslt = DSIDX::IdxDelete(iRecNo); // Delete previously inserted record
   else
      rslt = DSIDX::IdxInsert(iRecNo); //
Exit:
   return rslt;
}

DBIResult DSIDXCHG::IdxDelete(UINT32 iRecNo)
{
   DBIResult rslt = DBIERR_NONE;

   if (bDisabled || pDs->bDisableLog)
      goto Exit;
   if (!(iVisibleAttr == 0 || iVisibleAttr & dsRecDeleted))
      goto Exit;

   if (pDs->piAttr[iRecNo-1] == 0 /* & dsRecNew */ ) // Undoing ?
   { // Delete record from index (undoing an insert)
      rslt = DSIDX::IdxDelete(iRecNo); // Delete previously inserted record
   }
   else
   { // Insert deleted record in index
      rslt = DSIDX::IdxInsert(iRecNo); //
   }
Exit:
   return rslt;
}

// iRecNo1 is 'new' modified record
DBIResult DSIDXCHG::IdxModify(UINT32 iRecNoNew, UINT32 iRecNoOld)
{
   DBIResult rslt = DBIERR_NONE;

   if (bDisabled || pDs->bDisableLog)
      goto Exit;
   if (!(iVisibleAttr == 0 || iVisibleAttr & dsRecModified))
      goto Exit;

   if (pDs->piAttr[iRecNoOld-1] == dsRecOrg) // Is this first change to record ?
   {
      rslt = DSIDX::IdxInsert(iRecNoOld); // insert original record in index
   }
   else
   {
      if (pDs->piAttr[iRecNoOld-1] != (dsRecNew + dsRecOrg))
         rslt = DSIDX::IdxDelete(iRecNoOld); // delete intermediate record (and undo)
      else
         rslt = DBIERR_NONE;
   }
   if (rslt)
      goto Exit;

   if (pDs->piAttr[iRecNoNew-1] == 0) // Changing back to original (undo)
   {
      rslt = DSIDX::IdxDelete(iRecNoNew); // undoing change
   }
   else
   {
      if (pDs->piAttr[iRecNoNew-1] != dsRecNew)
         rslt = DSIDX::IdxInsert(iRecNoNew); //
   }
Exit:
   return rslt;
}
