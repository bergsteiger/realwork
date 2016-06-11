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

DSCONSTR::DSCONSTR(DSBASE *pDs)
{
   this->pDs = pDs;
   iSize = 0;
   iLast = 0;
   pEntries = NULL;
   iIds = 1;
   pRecBuf = NULL;
}

DSCONSTR::~DSCONSTR()
{
   UINT32 i;

   if (pEntries)
   {
      for (i = 0; i < iLast; i++)
      {
         if (pEntries[i].hCanConstraints)
         {
            delete[] pEntries[i].pCanExpr; // Free handle, if any
            pEntries[i].pCanExpr = NULL;
            QFreeCanFilter(pEntries[i].hCanConstraints);
         }
      }
      DsFree(pEntries);
   }
   pEntries = NULL;
   if (pRecBuf)
      delete pRecBuf;
}

DBIResult DSCONSTR::Grow(UINT32 iEntries) // Grow size
{
   pBYTE pTmp;

   pTmp = (pBYTE)DsRealloc((pVOID)pEntries,
      sizeof(CONSTREntry) * iSize, sizeof(CONSTREntry) * (iSize+iEntries));
   if (!pTmp)
      return DBIERR_NOMEMORY;
   pEntries = (CONSTREntry*)pTmp;
   iSize += iEntries;
   return DBIERR_NONE;
}

// returns 'handle' or id
DBIResult DSCONSTR::Add(pBYTE pCanExpr, UINT32 iLen, FLTArgType fltType, pULONGP piId)
{
   DBIResult rslt = DBIERR_NONE;
   pCONSTREntry pEntry;

   if (iLast >= iSize)
   {
      Grow(1);
   }

   pEntry = &this->pEntries[iLast];
   if (pCanExpr && iLen)
   {
      ULONGP hCanConstraints;
      UINT16 iFldNo;
      BOOL bFldRequired;
      rslt = QCompileCanFilter(fltType, pCanExpr, &iFldNo, &hCanConstraints, &bFldRequired, pDs);
      if (rslt == DBIERR_NONE)
      {
         pEntry->pCanExpr = new BYTE[iLen];
         CopyMem(pEntry->pCanExpr, pCanExpr, iLen);
         pEntry->iLen = iLen;
         pEntry->hCanConstraints = hCanConstraints;
         pEntry->iClientData = 0;
         pEntry->pfFilter = NULL;
         pEntry->iId = iIds;
         pEntry->eFltType = fltType;
         pEntry->iFldNo = iFldNo; // Fieldconstraint if <> 0
         if (iFldNo && (UINT32)iFldNo <= pDs->iFields && bFldRequired)
         { // This is one way to pass required constraints to the Flddesc
            pDs->pFieldDesc[iFldNo-1].iFldAttr |= fldAttrREQUIRED;
         }
         if (piId)
            *piId = iIds;
         iLast++;
         iIds++;
      }
   }
   return rslt;
}

// returns 'handle' or id
DBIResult DSCONSTR::Add(ULONGP iClientData, pfDSFilter pfFilter, pULONGP piId)
{
   DBIResult rslt = DBIERR_NONE;
   pCONSTREntry pEntry;

   if (iLast >= iSize)
   {
      rslt = Grow(1);
   }

   if (rslt == DBIERR_NONE)
   {
      pEntry = &this->pEntries[iLast];
      pEntry->pCanExpr = NULL;
      pEntry->iLen = 0;
      pEntry->hCanConstraints = 0;
      pEntry->iClientData = iClientData;
      pEntry->pfFilter = pfFilter;
      pEntry->iId = iIds;
      if (piId)
         *piId = iIds;
      iLast++;
      iIds++;
   }
   return rslt;
}

DBIResult DSCONSTR::Remove(UINT32 iId)
{
   DBIResult rslt;
   UINT32 i;

   // Find entry
   for (i = 0; i < iLast; i++)
   {
      if (pEntries[i].iId == iId)
      { // Found it
         if (pEntries[i].hCanConstraints)
         {
            delete[] pEntries[i].pCanExpr; // Free handle, if any
            pEntries[i].pCanExpr = NULL;
            QFreeCanFilter(pEntries[i].hCanConstraints);
         }
         if (i < iLast - 1)
            CopyMem((pBYTE) &pEntries[i], (pBYTE) &pEntries[i+1], sizeof(CONSTREntry)*(iLast-1-i));
         iLast--;
         rslt = DBIERR_NONE;
         goto Exit;
      }
   }
   rslt = DBIERR_OBJNOTFOUND; // not found
Exit:
   return rslt;
}

// returns TRUE if it satisfies condition
BOOL DSCONSTR::Evaluate(pBYTE pRecBuf)
{
   UINT32 i;

   for (i = 0; i < iLast; i++)
   {
      pCONSTREntry pEntry = &pEntries[i];
      if (pEntry->hCanConstraints)
      {
         if (pEntry->eFltType == fltSQLEX_CONSTRAINT || pEntry->eFltType == fltCANEX) // (Avoid default values)
         {
            if (QExecuteCanFilter(pEntry->hCanConstraints, pRecBuf, pDs) == FALSE)
            {
               QFetchErrStr(pEntry->hCanConstraints, szErrMsg);
               return FALSE;
            }
         }
      }
      else
      {
         if (pEntry->pfFilter)
            if (pEntry->pfFilter(pEntry->iClientData, pRecBuf) == FALSE)
               return FALSE;
      }
   }
   return TRUE;
}

// returns TRUE if field satisfies condition
BOOL DSCONSTR::Evaluate(UINT32 iFldNo, pBYTE pFld)
{
   UINT32 i;

   for (i = 0; i < iLast; i++)
   {
      pCONSTREntry pEntry = &pEntries[i];

      if (pEntry->hCanConstraints && pEntry->iFldNo == iFldNo && pEntry->eFltType == fltSQLEX_CONSTRAINT)
      {
         if (pRecBuf == NULL)
            pRecBuf = new BYTE[pDs->iRecordSize];
         if (pRecBuf)
         {
            pDs->PutField(pRecBuf, iFldNo, pFld);
            if (QExecuteCanFilter(pEntry->hCanConstraints, pRecBuf, pDs) == FALSE)
            {
               QFetchErrStr(pEntry->hCanConstraints, szErrMsg);
               return FALSE;
            }
         }
      }
   }
   return TRUE;
}

DBIResult DSCONSTR::Recompile(VOID)
{
   UINT32 i;
   DBIResult rslt = DBIERR_NONE;
   BOOL bFldRequired;

   if (pRecBuf)
   {
      delete pRecBuf;
      pRecBuf = NULL;
   }

   for (i = 0; i < iLast; i++)
   {
      pCONSTREntry pEntry = &pEntries[i];
      if (pEntry->hCanConstraints)
      {
         ULONGP hCanConstraints;
         UINT16 iFldNo;

         // Remove old one
         QFreeCanFilter(pEntry->hCanConstraints);
         pEntry->hCanConstraints = 0;

         rslt = QCompileCanFilter(pEntry->eFltType, pEntry->pCanExpr, &iFldNo, &hCanConstraints, &bFldRequired, pDs);
         if (rslt == DBIERR_NONE)
         {
            pEntry->hCanConstraints = hCanConstraints;
            pEntry->iFldNo = iFldNo; // Fieldconstraint if <> 0
            if (iFldNo && (UINT32)iFldNo <= pDs->iFields && bFldRequired)
            { // This is one way to pass required constraints to the Flddesc
               pDs->pFieldDesc[iFldNo-1].iFldAttr |= fldAttrREQUIRED;
            }
         }
      }
   }
   return rslt;
}

DBIResult DSCONSTR::GetDefaults(pBYTE pRecBuf)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;

   for (i = 0; i < iLast; i++)
   {
      pCONSTREntry pEntry = &pEntries[i];
      if (pEntry->hCanConstraints && pEntry->eFltType == fltSQLEX_DEFAULT && pEntry->iFldNo)
      {
         pBYTE pFld;

         QExecuteCanFilter(pEntry->hCanConstraints, pRecBuf, pDs);
         pFld = QFetchValue(pEntry->hCanConstraints);
         pDs->PutField(pRecBuf, pEntry->iFldNo, pFld);
      }
   }
   return rslt;
}
