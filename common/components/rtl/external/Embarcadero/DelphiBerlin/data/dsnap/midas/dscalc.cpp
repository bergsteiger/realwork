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

DBIResult DBIFN DSBASE::SetFieldCalculation( // Register fieldcalculation on this field
   ULONGP iClientData,  //
   pfDSCalcField pfCalc // Callback function, NULL to remove
)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iRowNo;
   pBYTE pRecBuf = NULL;

   LOCK();

   if (pfCalc)
   { // Recalculate all records

      // Only if no errors!
      iCalcClientData = iClientData;
      pfCalcFn = pfCalc;

      pRecBuf = new BYTE[iRecordSize];
      for (iRowNo = 1; iRowNo < iRecNoNext; iRowNo++)
      {
         DSAttr iAttr = piAttr[iRowNo-1]; // Set attribute
         BOOL bVisible = !(iAttr & dsISNOTVISIBLE);

         if (!bVisible)
            continue;
         GetRecord(iRowNo, pRecBuf);
         rslt = RecalcRec(iRowNo, pRecBuf);
      }
      // for all filter/indexes, if any reliance on calculated field, recreate it
      {
         DSIDX *pX = pIdx;

         while (pX != NULL)
         {
            if (pX->iType == idxFilter)
            { // We need to recompile filters
               DSIDXFILT *pXF = (DSIDXFILT*)pX;
               if (pXF->pFilt)
                  pXF->pFilt->Recompile();
               pXF->IdxCreateOrder(NULL, NULL);
            }
            else
            {
               UINT32 i;
               for (i = 0; i < pX->IdxDesc.iFields; i++)
               {
                  if (pFieldDesc[pX->IdxDesc.iKeyFields[i] -1].bCalculated) // Includes calculated field
                  {
                     pX->IdxCreateOrder(NULL, NULL); // Reevaluate it
                     break;
                  }
               }
            }
            pX = pX->pIdxNext;
         }
      }
   }
   else
   { // Should we clear out all values to blanks?
      iCalcClientData = 0;
      pfCalcFn = NULL;
   }

   if (pRecBuf)
	  delete[] pRecBuf;
   UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::RecalcRec(UINT32 iRowNo, pBYTE pRecBuf)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   BOOL bBufAllocated = FALSE;

   if (pfCalcFn == NULL || iRowNo == 0)
      return DBIERR_NONE; // nothing to do
   // LOCK(); (already done)
   if (pRecBuf == NULL)
   {
      pRecBuf = new BYTE[iRecordSize];
      bBufAllocated = TRUE;
      rslt = GetRecord(iRowNo, pRecBuf);
      if (rslt)
         goto Exit;
   }
   rslt = pfCalcFn(iCalcClientData, pRecBuf);
   if (rslt)
      goto Exit;
   for (i = 0; i < iFields; i++)
   {
      if (pFieldDesc[i].bCalculated && !(pFieldDesc[i].iFldAttr & fldAttrLINK))
      {
         BOOL bBlank;
         pBYTE pFld;

         GetFieldPtrB(pRecBuf, i+1, &pFld, &bBlank); // Store calculated value
         if (bBlank)
            PutField(iRowNo, i+1, NULL);
         else
            PutField(iRowNo, i+1, pFld); // No posibility for constraints, right ?
      }
   }
Exit:
   if (bBufAllocated)
	  delete[] pRecBuf;
   // UNLOCK();
   return rslt;
}
