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

BLOBIDList::BLOBIDList()
{
   iLeafSize = 0;
   iSize = 0;
   iLast = 0;
   ppBlobEntryLeaves = NULL;
}

BLOBIDList::~BLOBIDList()
{
   UINT32 i;

   for (i = 0; i < iLast; i++)
      DsFree(getBlobEntry(i).pBlob); // Free blob, if any
   iSize = 0;
   iLast = 0;

   for (i = 0; i < iLeafSize; i++)
      DsFree(ppBlobEntryLeaves[i]); // Free BLOB entry leaf.
   iLeafSize = 0;

   DsFree(ppBlobEntryLeaves);
}

DBIResult BLOBIDList::Ensure(UINT32 iEnsureSize)
{
   DBIResult rslt = DBIERR_NONE;
   if (iEnsureSize >= iSize)
      rslt = Grow(15);
   return rslt;
}

DBIResult BLOBIDList::Grow(UINT32 iEntries)
{
   UINT32 iNewLeafSize = ((iSize + iEntries) + (BLOBLEAFSIZE-1))/BLOBLEAFSIZE;

   UINT32 iAllocLeaf = (iNewLeafSize - iLeafSize);
   if (iAllocLeaf > 0)
   {
      ppBLOBEntryLeaf pTmp;

      pTmp = (ppBLOBEntryLeaf)DsRealloc((pVOID)ppBlobEntryLeaves,
         sizeof(pBLOBEntryLeaf) * iLeafSize, sizeof(pBLOBEntryLeaf) * iNewLeafSize);

      if (!pTmp)
         return DBIERR_NOMEMORY;

      for (UINT32 idx = iLeafSize; idx < iNewLeafSize; idx++)
      {
         pTmp[idx] = (pBLOBEntryLeaf)DsCalloc(BLOBLEAFSIZE, sizeof(BLOBEntry));
      }

      ppBlobEntryLeaves = pTmp;

      iLeafSize = iNewLeafSize;
      iSize = iNewLeafSize * BLOBLEAFSIZE;
   }
   return DBIERR_NONE;
}

VOID BLOBIDList::Reset(VOID)
{
   UINT32 i;

   for (i = 0; i < iLast; i++)
   {
      pBLOBEntry pEntry = &getBlobEntry(i);
      if (pEntry->pBlob)
         DsFree(pEntry->pBlob);
      pEntry->iBlobLen = 0;
      pEntry->pBlob = NULL;
   }
   iLast = 0;
}

inline BLOBEntry& BLOBIDList::getBlobEntry(UINT32 index)
{
   return ppBlobEntryLeaves[index / BLOBLEAFSIZE][index % BLOBLEAFSIZE];
}

DSBLOBS::DSBLOBS()
{
   iLastCommitted = 0;
}

DSBLOBS::~DSBLOBS()
{
}

// Returns blobid (1-based)
DBIResult DSBLOBS::AddBlob(pBYTE pBlob, UINT32 iBlobLen, pUINT32 piBlobId)
{
   DBIResult rslt;
   pBLOBEntry pEntry;
   pBYTE pBuf;

   pBlobEntries.Ensure(pBlobEntries.iLast);
   pBuf = (pBYTE)DsMalloc(iBlobLen);
   if (pBuf == NULL)
      rslt = DBIERR_NOMEMORY;
   else
   {
      CopyMem(pBuf, pBlob, iBlobLen);
      pEntry = &pBlobEntries[pBlobEntries.iLast++];
      pEntry->pBlob = pBuf;
      pEntry->iBlobLen = iBlobLen;
      *piBlobId = pBlobEntries.iLast;
      rslt = DBIERR_NONE;
   }
   return rslt;
}

// Extend the size of a blob
DBIResult DSBLOBS::UpdBlob(pBYTE pBlob, UINT32 iOffset, UINT32 iBlobLen, UINT32 iBlobId)
{
   DBIResult rslt = DBIERR_NONE;
   pBLOBEntry pEntry;

   if (iBlobId > pBlobEntries.iLast || iBlobId == 0)
   {
      if (iBlobId & dsDELAYEDBIT)
         return DBIERR_BLOBNOTFETCHED;
      return DBIERR_INVALIDBLOBHANDLE;
   }
   pEntry = &pBlobEntries[iBlobId-1];
   if (iOffset > pEntry->iBlobLen)
      rslt = DBIERR_OUTOFRANGE; // Out of range
   else
   {
      if (iOffset + iBlobLen <= pEntry->iBlobLen)
      { // Overwriting part of existing one
         if (pBlob)
         {
            CopyMem(pEntry->pBlob + iOffset, pBlob, iBlobLen);
            pEntry->iBlobLen = iOffset + iBlobLen;
         }
         else
         {
            // Truncate it to zero
            if (pEntry->pBlob)
               DsFree(pEntry->pBlob); // Free old one
            pEntry->pBlob = NULL;
            pEntry->iBlobLen = 0;
         }
      }
      else
      { // Extending existing one
         pBYTE pBuf;

         pBuf = (pBYTE)DsMalloc(iOffset + iBlobLen);
         if (pBuf == NULL)
         {
            rslt = DBIERR_NOMEMORY;
            goto Exit;
         }
         CopyMem(pBuf, pEntry->pBlob, iOffset);
         CopyMem(pBuf + iOffset, pBlob, iBlobLen);
         DsFree(pEntry->pBlob); // Free old one
         pEntry->pBlob = pBuf;
         pEntry->iBlobLen = iOffset + iBlobLen;
      }
   }
Exit:
   return rslt;
}

DBIResult DSBLOBS::GetBlobLen(UINT32 iBlobId, pUINT32 piLen)
{
   if (iBlobId > pBlobEntries.iLast || iBlobId == 0)
   {
      if (iBlobId & dsDELAYEDBIT)
      {
         if (piLen)
            *piLen = iBlobId;
         return DBIERR_BLOBNOTFETCHED;
      }
      return DBIERR_INVALIDBLOBHANDLE;
   }
   *piLen = pBlobEntries[iBlobId-1].iBlobLen;
   return DBIERR_NONE;
}

DBIResult DSBLOBS::GetBlob(UINT32 iBlobId, UINT32 iOffset, pBYTE pBlob, pUINT32 piLength)
{
   pBLOBEntry pEntry;
   UINT32 iLen;

   if (iBlobId > pBlobEntries.iLast || iBlobId == 0)
   {
      if (iBlobId & dsDELAYEDBIT)
         return DBIERR_BLOBNOTFETCHED;
      return DBIERR_INVALIDBLOBHANDLE;
   }

   pEntry = &pBlobEntries[iBlobId-1];
   iLen = (iOffset > pEntry->iBlobLen) ? 0 : pEntry->iBlobLen - iOffset;
   if (piLength && *piLength < iLen)
      iLen = *piLength;
   if (iLen)
      CopyMem(pBlob, pEntry->pBlob + iOffset, iLen);
   if (piLength)
      *piLength = iLen;
   return DBIERR_NONE;
}

BOOL DSBLOBS::BlobIsSame(UINT32 iBlobLen, pBYTE pBlob, UINT32 iBlobId)
{
   UINT32 i;
   pBLOBEntry pEntry;
   pBYTE pBlob2;

   if (iBlobId & dsDELAYEDBIT)
      return iBlobId == iBlobLen;

   pEntry = &pBlobEntries[iBlobId-1];
   if (iBlobLen != pEntry->iBlobLen)
      return FALSE;

   pBlob2 = pEntry->pBlob;
   for (i = 0; i < iBlobLen; i++)
      if (pBlob[i] != pBlob2[i])
         return FALSE;
   return TRUE;
}

DBIResult DSBLOBS::GetBlobInfo(UINT32 iBlobId, pUINT32 piBlobLen, ppBYTE ppBlob)
{
   DBIResult rslt = DBIERR_NONE;
   pBLOBEntry pEntry;

   if (iBlobId > pBlobEntries.iLast || iBlobId == 0)
   {
      if (iBlobId & dsDELAYEDBIT)
      {
         *piBlobLen = iBlobId;
         *ppBlob = NULL;
         return DBIERR_BLOBNOTFETCHED;
      }
      return DBIERR_INVALIDBLOBHANDLE;
   }

   pEntry = &pBlobEntries[iBlobId-1];
   *piBlobLen = pEntry->iBlobLen;
   *ppBlob = pEntry->pBlob;
   return rslt;
}

VOID DSBLOBS::Reset(VOID)
{
   pBlobEntries.Reset();
   iLastCommitted = 0;
}

VOID DSBLOBS::Commit(VOID)
{
   iLastCommitted = pBlobEntries.iLast;
}

VOID DSBLOBS::Release(UINT32 iBlobId)
{
   if (iBlobId)
   {
      if (iBlobId <= pBlobEntries.iLast)
      {
         pBLOBEntry pEntry = &pBlobEntries[iBlobId-1];
         if (pEntry->pBlob)
            DsFree(pEntry->pBlob);
         ZeroMem((pBYTE)pEntry, sizeof(BLOBEntry));
         if (iBlobId == pBlobEntries.iLast)
            pBlobEntries.iLast--; // Only if last!
      }
   }
   else
   {
      while (iLastCommitted < pBlobEntries.iLast)
      {
         pBLOBEntry pEntry = &pBlobEntries[pBlobEntries.iLast-1];
         if (pEntry->pBlob)
            DsFree(pEntry->pBlob);
         ZeroMem((pBYTE)pEntry, sizeof(BLOBEntry));
         pBlobEntries.iLast--;
      }
   }
}
