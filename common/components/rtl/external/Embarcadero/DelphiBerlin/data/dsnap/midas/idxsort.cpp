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

#define M 10

// Sort piOrder according to IdxDesc
DBIResult DSIDX::IdxSort(VOID)
{
   DBIResult rslt = DBIERR_NONE;

   if (iRecs > 1)
   {
      // Min/max tuples (tested for in sortcomp)
      piOrder[0] = 0;
      if (iRecs +1 >= iRecsMax) // +1 since 0 is not used!
         GrowIDX(10);
      piOrder[iRecs + 1] = (UINT32) -1;

      if (iRecs > M)
         QSort(1, iRecs);
      InsSort();
   }
   return rslt;
}

#define Swp(x,y) iTemp = piOrder[x]; piOrder[x] = piOrder[y]; piOrder[y] = iTemp;

VOID DSIDX::QSort(UINT32 iLeft, UINT32 iRight)
{
   UINT32 i, j, iSavej, iTemp, iRec1, iRec2;

top:
   // Create median of 3

   i = iLeft + ((iRight-iLeft) >>1); // Middle
   if (iRight - iLeft <=3) // KH: would this ever happen ?
   {
      Swp(iLeft, i); /* swap l with middle tup of range */
   }
   else
   { // Wanted : iRight > iLeft > iMid
      iRec1 = piOrder[iLeft];
      iRec2 = piOrder[iRight];
      if (SortCmp(iRec1, iRec2) > 0)
      {
         Swp(iLeft, iRight); // iLeft <= iRight
         iRec1 = piOrder[iLeft];
      }
      iRec2 = piOrder[i]; // Middle
      if (SortCmp(iRec2, iRec1) > 0)
      {
         Swp(iLeft, i); // iLeft >= iMiddle
         iRec1 = piOrder[iLeft];
         iRec2 = piOrder[iRight];
         if (SortCmp(iRec1, iRec2) > 0)
         {
            Swp(iLeft, iRight); // iLeft <= iRight
         }
      }
   }

   for (i = iLeft, j = iRight + 1; ; )
   {
      iRec2 = piOrder[iLeft];
      do
      {
         iRec1 = piOrder[++i];
      }
      while (SortCmp(iRec1, iRec2) < 0);

      iRec1 = piOrder[iLeft];
      do
      {
         iRec2 = piOrder[--j];
      }
      while (SortCmp(iRec1, iRec2) < 0);

      if (j <= i)
      {
         Swp(iLeft, j);
         break;
      }
      else
      {
         Swp(i, j);
      }
   }
   if (iRight - j >= j - iLeft)
   {
      if (j - iLeft > M)
      {
         QSort(iLeft, (iSavej = j) - 1);
         iLeft = iSavej + 1;
         goto top;
      }
      else
      {
         if (iRight - j > M)
         {
            iLeft = j + 1;
            goto top;
         }
      }
   }
   else
   {
      if (iRight - j > M)
      {
         QSort((iSavej = j) + 1, iRight);
         iRight = iSavej - 1;
         goto top;
      }
      else
      {
         if (j - iLeft > M)
         {
            iRight = j - 1;
            goto top;
         }
      }
   }
}

VOID DSIDX::InsSort(VOID)
{
   UINT32 i, j, k, iRec1, iRec2;

   if (iRecs < 2)
      return;

   for (j = 1; ++j <= iRecs; )
   {
      iRec1 = piOrder[j-1];
      iRec2 = piOrder[j];

      if (SortCmp(iRec1, iRec2) > 0)
      {
         k = piOrder[j];
         i = j - 1;
         do
         {
            piOrder[i+1] = piOrder[i];
            iRec1 = piOrder[--i];
            iRec2 = k; // ?tups[k];
         }
         while (SortCmp(iRec1, iRec2) > 0);
         piOrder[i+1] = k;
      }
   }
}

INT32 DSIDX::SortCmp(UINT32 iRecNo1, UINT32 iRecNo2)
{
   UINT32 i;
   UINT32 iFldNo;
   pDSFLDDesc pFldDescs = pDs->pFieldDesc;
   pDSFLDDesc pFldDes;
   pBYTE pFld1, pFld2;
   INT32 iCmp = 1;
   pBYTE pBlank1, pBlank2;

   if (iRecNo1 == 0)
      return-1;
   if (iRecNo2 == 0)
      return 1;
   if (iRecNo1 == (UINT32) -1)
      return 1;
   if (iRecNo2 == (UINT32) -1)
      return-1;

   for (i = 0; i < IdxDesc.iFields; i++)
   {
      iFldNo = IdxDesc.iKeyFields[i];
      pFldDes = &pFldDescs[iFldNo - 1];
      pFld2 = pFld1 = pDs->ppColumns[iFldNo -1];

      pBlank1 = (pBYTE)pDs->pNulls + pDs->iNullLength*(iRecNo1-1);
      pBlank2 = (pBYTE)pDs->pNulls + pDs->iNullLength*(iRecNo2-1);

      if (pBlank1[iFldNo - 1] != 0)
         pFld1 = NULL;
      else
         pFld1 += pFldDes->iFldLen*(iRecNo1 - 1);

      if (pBlank2[iFldNo-1] != 0)
         pFld2 = NULL;
      else
         pFld2 += pFldDes->iFldLen*(iRecNo2 - 1);

      iCmp = ppFldObjs[i]->FldComp(pFld1, pFld2);
      if (iCmp)
         break;
   }
   return iCmp;
}
