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
#include <io.h>
#endif

#include <fcntl.h>

#pragma hdrstop

#include "alchemy.h"
#include "alc_ds.h"
#include "ossrv.h"

// From DsRefr2.cpp
BOOL DBIFN RecBufsEqual(DSBASE *pDs1, pBYTE pBuf1, DSBASE *pDs2, pBYTE pBuf2, BOOL bCmpBlobs, pBOOL pbSame);

// From DsDelta.cpp
DBIResult MoveRecord(DSBASE *pDs, pBYTE pRecBuf, UINT32 iRecNo, DSAttr iAttr, DSBASE *pDsDelta, pBOOL pbSame);

// From DsDelta.cpp
DBIResult DBIFN CreateEmptyDelta(DSBASE *pDs, DSBASE **ppDsDelta);

// Creates a delta from the difference between the old ds and the new ds
// (DsOld + Delta = DsNew)
DBIResult DBIFN DiffDs(DSBASE *pDsOld, DSBASE *pDsNew, DSBASE **ppDsDelta)
{
   DBIResult rslt;
   DSBASE *pDsDelta = NULL;
   UINT32 i, j;
   UINT32 iAllFields;
   pBYTE pRecBufNew = NULL, pRecBufOld = NULL;
   pBOOL pbSame = NULL;

   DSLOCK(pDsOld);
   DSLOCK(pDsNew); // Deadlock situation possible ?

   // We must assume that both datasets has a unique key on the default-order
   iAllFields = pDsOld->pIdxDef->IdxDesc.iFields;
   if (iAllFields == 0)
   {
      rslt = DBIERR_NA;
      goto Exit;
   }
   pRecBufNew = new BYTE[pDsOld->iRecordSize];
   pRecBufOld = new BYTE[pDsOld->iRecordSize];
   pbSame = new BOOL[pDsOld->iFields];
   if (pRecBufNew == NULL || pRecBufOld || pbSame)
   {
      rslt = DBIERR_NOMEMORY;
      goto Exit;
   }
   ZeroMem(pbSame, sizeof(BOOL)*pDsOld->iFields);
   rslt = CreateEmptyDelta(pDsOld, &pDsDelta); // Creates empty delta
   if (rslt)
      goto Exit;

   // Main-loop
   for (i = 0, j = 0; i < pDsOld->pIdxDef->iRecs; i++)
   {
      INT32 iCmp;
      UINT32 iRecNoNew, iRecNoOld;
   Again:
      if (j < pDsNew->pIdxDef->iRecs)
      {
         iRecNoNew = pDsNew->pIdxDef->IdxSeqNoToRecNo(j+1);
         pDsNew->GetRecord(iRecNoNew, pRecBufNew);
         iCmp = pDsOld->pIdxDef->IdxComp(pRecBufNew, iAllFields, 0, i+1);
         if (iCmp == 0)
         { // Same record, check if it changed
            iRecNoOld = pDsOld->pIdxDef->IdxSeqNoToRecNo(i+1);
            pDsOld->GetRecord(iRecNoOld, pRecBufOld);
            if (!RecBufsEqual(pDsOld, pRecBufOld, pDsNew, pRecBufNew, TRUE, pbSame))
            { // Modified record
               rslt = MoveRecord(pDsOld, pRecBufOld, iRecNoOld, dsRecOrg, pDsDelta, pbSame);
               if (rslt)
                  goto Exit;
               rslt = MoveRecord(pDsNew, pRecBufNew, iRecNoNew, dsRecModified, pDsDelta, pbSame);
               if (rslt)
                  goto Exit;
            }
            j++;
         }
         else if (iCmp < 0) // pRecBufNew < pRecBufOld. -> pRecBufNew was inserted
         {
            // Insert in delta
            rslt = MoveRecord(pDsNew, pRecBufNew, iRecNoNew, dsRecNew, pDsDelta, pbSame);
            if (rslt)
               goto Exit;
            j++;
            goto Again; // Loop until iCmp >= 0
         }
         else // (iCmp > 0) pRecBufOld was deleted
         {
            goto Deleted;
         }
      }
      else
      {
      Deleted:
         // Record 'i' was Deleted. In this case we don't increment j!
         rslt = MoveRecord(pDsOld, pRecBufOld, iRecNoOld, dsRecDeleted, pDsDelta, pbSame);
         if (rslt)
            goto Exit;
      }
   }

Exit:
   if (rslt)
   {
      if (pDsDelta)
         delete pDsDelta;
      pDsDelta = NULL;
   }
   if (pRecBufNew)
      delete pRecBufNew;
   if (pRecBufOld)
      delete pRecBufOld;
   if (pbSame)
      delete pbSame;
   if (ppDsDelta)
      *ppDsDelta = pDsDelta;
   DSUNLOCK(pDsNew);
   DSUNLOCK(pDsOld);
   return rslt;
}
