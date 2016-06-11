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

DBIResult DBIFN DSBASE::SetNotifyCallBack( // Called when posting changes to dataset
   ULONGP iId, // Cursor handle
   pfCHANGECallBack pfCallBack // Call back fn being registered
)
{
   DBIResult rslt;

   LOCK();
   if (pDsCallBacks == NULL)
      pDsCallBacks = new DSCALLBACK;
   if (pfCallBack)
      rslt = pDsCallBacks->Add(iId, pfCallBack);
   else
      rslt = pDsCallBacks->Remove(iId);
   UNLOCK();
   return rslt;
}

DSCALLBACK::DSCALLBACK()
{
   pEntries = NULL;
   iSize = 0;
   iLast = 0;
}

DSCALLBACK::~DSCALLBACK()
{
   if (pEntries)
      DsFree(pEntries);
}

DBIResult DSCALLBACK::Add(ULONGP iId, pfCHANGECallBack pfCallBack)
{
   DBIResult rslt = DBIERR_NONE;
   pCALLBACKEntry pEntry;

   if (iLast >= iSize)
   {
      rslt = Grow(2);
   }
   pEntry = &pEntries[iLast];
   pEntry->iId = iId;
   pEntry->pfCallBack = pfCallBack;
   iLast++;
   return rslt;
}

DBIResult DSCALLBACK::Remove(ULONGP iId)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;

   for (i = 0; i < iLast; i++)
   {
      if (pEntries[i].iId == iId)
      { // Found it,
         if (i < iLast - 1)
            CopyMem((pBYTE) &pEntries[i], (pBYTE) &pEntries[i+1], sizeof(CALLBACKEntry)*(iLast-1-i));
         iLast--;
      }
   }
   return rslt;
}

VOID DSCALLBACK::Notify(VOID)
{
   UINT32 i;
   pCALLBACKEntry pEntry;

   for (i = 0; i < iLast; i++)
   {
      pEntry = &pEntries[i];
      if (pEntry->pfCallBack)
      {
         pEntry->pfCallBack(pEntry->iId);
      }
   }
}

DBIResult DSCALLBACK::Grow(UINT32 iEntries) // Grow size
{
   pBYTE pTmp;

   pTmp = (pBYTE)DsRealloc((pVOID)pEntries,
      sizeof(CALLBACKEntry) * iSize, sizeof(CALLBACKEntry) * (iSize+iEntries));
   if (!pTmp)
      return DBIERR_NOMEMORY;
   pEntries = (CALLBACKEntry*)pTmp;
   iSize += iEntries;
   return DBIERR_NONE;
}
