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

extern INT32 iObjCount;

DSCursor::DSCursor(VOID)
{
   iRefCount = 0;
   iObjCount++;
   pDs = NULL; // Not initialized
}

DBIResult DBIFN DSCursor::InitCursor(pVOID pTDs)
{
   UINT32 i;
   UINT32 iFldLen = 0;
   DSBASE * pDs = (DSBASE*)pTDs;

   if (this->pDs)
      return DBIERR_NA; // Already initialized ?

   DSLOCK(pDs);
   this->pDs = pDs;

   // Get Fields
   piFieldMap = new UINT32[pDs->iFields];
   pFieldDesc = new DSFLDDesc[pDs->iFields];
   iFields = 0;

   for (i = 0; i < pDs->iFields; i++)
   {
      CopyMem(&pFieldDesc[iFields], &pDs->pFieldDesc[i], sizeof(DSFLDDesc));
      pFieldDesc[iFields].iFldOffsInRec = iFldLen;
      iFldLen += pFieldDesc[iFields].iFldLen;
      piFieldMap[iFields] = i + 1; // (+1 ?) Store original fieldId
      iFields++;
   }
   iNullOffset = iFldLen; // After all fields
   iFldLen += iFields; // Add 1 byte for each field
   iRecordSize = iFldLen;
   // Setup null offsets
   for (i = 0; i < iFields; i++)
   {
      pFieldDesc[i].iNullOffsInRec = iNullOffset + i;
   }

   // Reset range
   bActiveRange = FALSE;
   iRangeFieldsLow = 0;
   iRangePartLenLow = 0;
   bRangeIncLow = TRUE;
   iRangeFieldsHigh = 0;
   iRangePartLenHigh = 0;
   bRangeIncHigh = TRUE;
   pRangeLow = NULL;
   pRangeHigh = NULL;

   pBaseRecBuf = new BYTE[pDs->iRecordSize];

   pIdx = pDs->pIdxDef; // Use default order
   pIdx->AddRef();

   SetActiveRange();
   // MoveToBOF
   iCurPos = BEGPOS; // BOF
   iCurState = DBIERR_BOF;
   iSavePos = BEGPOS;
   iSaveRecNo = 0;
   iSaveState = DBIERR_BOF;

   iBookMarkSize = BOOKMARKSIZE;
   iFilters = 0;
   iNotifyData = 0;
   pfNotifyCallBack = NULL;

   hLocate = 0;
   pLocateFilt = NULL;

   iSeqNoM = 0;
   iSeqNoD = 0;
   hCurParent = 0;
   iCurrSetID = 0;

   DSUNLOCK(pDs);
   return DBIERR_NONE;
}

DSCursor::~DSCursor()
{
   DSLOCK(pDs);
   if (hCurParent && pDs->pDsParent)
   { // unlink from parent, in case the detail cursor is closed first
      // In case the master is already closed, it unlinks the entry, and the pDsParent, not the hCurParent!
      pLTABLEEntry pEntry;
      pEntry = hCurParent->pDs->pLinkedTables->GetEntry(pDs->iDetID);
      if (pEntry->phCurDet == this)
         pEntry->phCurDet = NULL;
   }

   if (pfNotifyCallBack)
      SetNotifyCallBack(reinterpret_cast<ULONGP>(this), NULL); // Remove callback at ds-level

   if (pFieldDesc)
      delete[]pFieldDesc;
   pFieldDesc = NULL;

   if (piFieldMap)
      delete[] piFieldMap;
   piFieldMap = NULL;

   if (pRangeLow)
      delete[] pRangeLow;
   pRangeLow = NULL;
   if (pRangeHigh)
      delete[] pRangeHigh;
   pRangeHigh = NULL;

   if (pBaseRecBuf)
      delete[] pBaseRecBuf;
   pBaseRecBuf = NULL;

   if (pIdx)
      pDs->DropIndex(pIdx);
   pIdx = NULL;

   if (pLocateFilt)
      delete pLocateFilt;
   pLocateFilt = NULL;
   hLocate = 0;

   iObjCount--;
   DSUNLOCK(pDs);
}

HRESULT DBIFN DSCursor::QueryInterface(REFIID riid, void** ppv)
{
#ifdef MIDAS_DLL
   if (IsEqualCLSID(riid, IID_MDSCURSOR_1) || IsEqualCLSID(riid, IID_IUnknown))
#else
      if (IsEqualCLSID(riid, IID_DSCURSOR_1) || IsEqualCLSID(riid, IID_DSCURSOR_2) || IsEqualCLSID(riid, IID_IUnknown))
#endif
      {
         if (ppv)
            *ppv = this;
         AddRef();
         return NOERROR;
      }
   if (ppv)
      *ppv = NULL;
   return E_NOINTERFACE;
}

INT32 DBIFN DSCursor::AddRef(VOID)
{
   return++iRefCount;
}

INT32 DBIFN DSCursor::Release(VOID)
{
   INT32 iRefSave;

   if (iRefCount > 0)
      iRefSave = --iRefCount;
   else
      iRefSave = iRefCount;
   if (iRefCount == 0)
      delete this;
   return iRefSave;
}

DBIResult DBIFN DSCursor::GetCursorProps(pDSProps pProps)
{
   DBIResult rslt = DBIERR_NONE;

   pDs->GetProps(pProps);
   pProps->iRecBufSize = iRecordSize;
   pProps->iBookMarkSize = iBookMarkSize;
   return rslt;
}

DBIResult DBIFN DSCursor::GetFieldDescs(pDSFLDDesc pFldDesc)
{
   DBIResult rslt = DBIERR_NONE;

   pDs->GetFieldDescs(pFldDesc);
   return rslt;
}

DBIResult DBIFN DSCursor::GetIndexDescs(BOOL bCurrentOnly, pDSIDXDesc pIdxDesc)
{
   DBIResult rslt = DBIERR_NONE;

   if (bCurrentOnly)
      CopyMem((pBYTE)pIdxDesc, (pBYTE) &pIdx->IdxDesc, sizeof(DSIDXDesc));
   else
      rslt = pDs->GetIndexDescs(pIdxDesc);
   return rslt;
}

// Records in active view
DBIResult DBIFN DSCursor::GetRecordCount(pUINT piRecs)
{
   INT32 iRecs;

   if (ResyncWithMaster() == DBIERR_NOCURRREC)
   {
      *piRecs = 0;
   }
   else
   {
      Resync();
      iRecs = iCurLast - iCurFirst + 1;
      *piRecs = iRecs > 0 ? iRecs : 0;
      if (iCurrSetID & dsDELAYEDBIT)
      {
         *piRecs = dsDELAYEDBIT; // (-1), signal that there are no details
         return DBIERR_DETAILSNOTFETCHED;
      }
   }
   return DBIERR_NONE;
}

DBIResult DBIFN DSCursor::InternalDropRange(VOID)
{
   DBIResult rslt = DBIERR_NONE;

   iRangeFieldsLow = 0;
   iRangePartLenLow = 0;
   iRangeFieldsHigh = 0;
   iRangePartLenHigh = 0;
   bActiveRange = FALSE;
   iSeqNo = pIdx->iSeqNo-1; // Force resync and setting of iCurFirst/last

   return rslt;
}

DBIResult DBIFN DSCursor::DropRange(VOID)
{
   DBIResult rslt = InternalDropRange();

   if (hCurParent)
   {
      iSeqNoD--;
      ResyncWithMaster();
   }
   return rslt;
}

// Sets iCurFirst/Last after change
// KHNOTE:Optimization: have an AdjustActiveRange
DBIResult DBIFN DSCursor::SetActiveRange(VOID)
{
   DBIResult rslt = DBIERR_NONE;

   DSLOCK(pDs);
   if (bActiveRange)
   {
      DBIResult x;
      UINT32 iFnd;

      if (pRangeLow)
      {
         x = pIdx->IdxFindKey(iRangeFieldsLow, (UINT16)iRangePartLenLow, pRangeLow, TRUE, &iFnd);
         if (x)
         { // Not found, goto next
            iCurFirst = iFnd + 1;
         }
         else // Found match
         {
            iCurFirst = iFnd; // Found, stay and include it
            if (!bRangeIncLow)
            {
               iCurFirst++;
               // Continue as long as 'equal'
               while (iCurFirst <= pIdx->iRecs && pIdx->IdxComp(pRangeLow, iRangeFieldsLow, (UINT16)iRangePartLenLow,
                     iCurFirst) == 0)
               {
                  iCurFirst++; // (May go to iRecs+1, okay?)
               }
            }
         }
      }
      else
         iCurFirst = 1;

      if (pRangeHigh)
      {
         if (bRangeHLSame)
         {
            iCurLast = iCurFirst; // (in case not found above (x != 0), we must start from the same pos. +1;
            while (iCurLast <= pIdx->iRecs && pIdx->IdxComp(pRangeHigh, iRangeFieldsHigh, (UINT16)iRangePartLenHigh,
                  iCurLast) >= 0)
            {
               iCurLast++;
            }
            if (bRangeIncHigh)
               iCurLast--; // Include last record
         }
         else
         {
            x = pIdx->IdxFindKey(iRangeFieldsHigh, (UINT16)iRangePartLenHigh, pRangeHigh, TRUE, &iFnd);
            if (x) // Not found
            {
               iCurLast = iFnd;
            }
            else
            { // Found it
               if (bRangeIncHigh)
               {
                  iCurLast = iFnd; // This on is in
                  // Go forward as long as 'equal'
                  while (iCurLast + 1 <= pIdx->iRecs && pIdx->IdxComp(pRangeHigh, iRangeFieldsHigh, (UINT16)
                        iRangePartLenHigh, iCurLast + 1) == 0)
                  {
                     iCurLast++;
                  }
               }
               else
                  iCurLast = iFnd - 1;
            }
         }
      }
      else
         iCurLast = pIdx->iRecs;
   }
   else
   {
      iCurFirst = 1;
      iCurLast = pIdx->iRecs; // iCurPos moves in [iCurFirst, iCurLast]
   }
   DSUNLOCK(pDs);
   return rslt;
}

// switch to index order, stays on same record, if possible
DBIResult DBIFN DSCursor::UseIndexOrder(pCHAR pszName)
{
   pDSIDX pIdxNew;
   DBIResult rslt;
   DSBOOKMRK BkMark;

   DSLOCK(pDs);
   rslt = pDs->FindIndex(pszName, &pIdxNew); // Does not return sort-index/filt-index
   if (rslt)
      goto Exit;

   if (pIdxNew == pIdx)
      goto Exit;

   if (bActiveRange)
      InternalDropRange();

   GetCurrentBookMark((pBYTE) &BkMark);
   if ((pIdxNew->iType != idxChange) &&                      // if new index is StatusFIlter, release old index.
       ((pIdx->iType == idxFilter) ||
        (pIdxNew->bSortIndex && pIdx->bSortIndex))) // cannot use new one directly
   { // Use current index
      pIdx->IdxCreateOrder(&pIdxNew->IdxDesc, pIdxNew); // Use same sort order as pIdxNew!
   }
   else
   {
      if (pIdxNew) // Found one
      {
         if (pIdxNew->bSortIndex)
         { // Not usable
            rslt = DBIERR_NOSUCHINDEX;
            goto Exit; // pIdxNew->AddRef(); //pIdxNew->iUseCnt++;
         }

         if (this->pIdx->bSortIndex)
         {
            pDs->DropIndex(this->pIdx);
         }
         else
            this->pIdx->Release(); // Decrement usecount
         pIdx = pIdxNew;
         pIdxNew->AddRef();
         iBookMarkSize = BOOKMARKSIZE;
      }
   }
   iSeqNo = pIdxNew->iSeqNo-1; // Force resync., setting of iCurFirst/last
   if (!iCurState)
   {
      MoveToBookMark((pBYTE) &BkMark);
   }
   else
      MoveToBOF();

Exit:
   DSUNLOCK(pDs);
   return rslt;
}

BOOL ContainsField(UINT32 iFields, pULONGP piFields, UINT32 iFieldNo)
{
   UINT32 i;
   for (i = 0; i < iFields; i++) // Validate fieldnumbers
      if (piFields[i] == iFieldNo)
      {
         return TRUE;
      }
   return FALSE;
}

DBIResult DBIFN DSCursor::SortOnFields(UINT32 iFields, pULONGP piFields, pBOOL pbDescending, pBOOL pbCaseInsensitive)
{
   UINT32 i;
   pDSIDX pIdxNew, pIdxSameOrder;
   DBIResult rslt;
   DSBOOKMRK BkMark;
   UINT32 iInc = 0;

   DSLOCK(pDs);
   if (iFields == 0 || piFields == NULL)
   {
      rslt = DBIERR_INVALIDPARAM;
      goto Exit;
   }
   for (i = 0; i < iFields; i++) // Validate fieldnumbers
      if (piFields[i] > this->iFields || piFields[i] == 0)
      {
         rslt = DBIERR_INVALIDPARAM;
         goto Exit;
      }
   GetCurrentBookMark((pBYTE) &BkMark);
   if (bActiveRange)
      DropRange();

   { // Create new one
      DSIDXDesc IdxDesc;

      // Make sure we do not add the link field to the index if it is already in the index.
      if (pDs->iFieldID_SetIDD && !ContainsField(iFields, piFields, pDs->iFieldID_SetIDD))
         iInc++;

      ZeroMem((pVOID) &IdxDesc, sizeof(DSIDXDesc));
      IdxDesc.iFields = iFields + iInc; // NOTE: should add fields of primary index!
      for (i = 0; i < iFields; i++)
      {
         if (iInc && i == 0)
         {
            IdxDesc.iKeyFields[0] = pDs->iFieldID_SetIDD;
         }
         IdxDesc.iKeyFields[i+iInc] = piFields[i];
         if (pbDescending)
            IdxDesc.bDescending[i+iInc] = pbDescending[i];
         if (pbCaseInsensitive)
            IdxDesc.bCaseInsensitive[i+iInc] = pbCaseInsensitive[i];
      }
      IdxDesc.bUnique = FALSE;
      LdStrCpy(IdxDesc.szName, pDs->pFieldDesc[piFields[0]-1].szName); // Store fieldname as name

      if (SameIdxDesc(&IdxDesc, &pIdx->IdxDesc, TRUE, TRUE))
      {
         rslt = DBIERR_NONE;
         goto Exit; // Nothing to do, (ignore unique)
      }
      pIdxSameOrder = NULL;
      pDs->FindEqIndex(&IdxDesc, &pIdxSameOrder);
      if (pIdx->iType == idxFilter || pIdx->bSortIndex)
      { // Reuse it
         rslt = pIdx->IdxCreateOrder(&IdxDesc, pIdxSameOrder);
      }
      else
      {
         pIdxNew = new DSIDX(pDs); // Create default order

         rslt = pIdxNew->IdxCreateOrder(&IdxDesc, pIdxSameOrder); // Use
         if (rslt)
         {
            delete pIdxNew;
            pIdxNew = NULL;
         }
         else
         {
            pIdx->Release();
            pIdxNew->bSortIndex = TRUE;
            pDs->AddIndex(pIdxNew); // Make it maintained
            pIdx = pIdxNew;
         }
      }
   }
   if (rslt == DBIERR_NONE)
   {
      iSeqNo = pIdx->iSeqNo-1;
      iBookMarkSize = BOOKMARKSIZE;
      iSeqNoD--;
      if (!iCurState)
      {
         MoveToBookMark((pBYTE) &BkMark);
      }
      else
         MoveToBOF();

   }
Exit:
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::AddFilter( // Add a canexpr-filter to this cursor
   pVOID pcanExpr, UINT32 iLen, // Length of canexpr
   phDSFilter phFilter)
{
   DBIResult rslt;
   DSBOOKMRK BkMark;

   DSLOCK(pDs);

   GetCurrentBookMark((pBYTE) &BkMark);
   if (pIdx->iType != idxFilter)
   {
      DSIDXFILT *pIdxNew = new DSIDXFILT(pDs);

      rslt = pIdxNew->IdxAddFilter((pBYTE)pcanExpr, iLen, phFilter);
      if (rslt)
         goto Exit;
      rslt = pIdxNew->IdxCreateOrder(&pIdx->IdxDesc, pIdx); // Use current ordering!
      if (!rslt && pIdx->pGroups)
      { // Clone, and initialize aggs
         rslt = pIdx->pGroups->Clone(pIdxNew, &pIdxNew->pGroups);
      }

      if (rslt == DBIERR_NONE)
      {
         pIdx->Release();
         pDs->AddIndex(pIdxNew); // Make it maintained
         pIdx = pIdxNew;
      }
      else
      {
         if (pIdxNew)
            delete pIdxNew;
      }
   }
   else
   {
      rslt = ((DSIDXFILT*)pIdx)->IdxAddFilter((pBYTE)pcanExpr, iLen, phFilter);
      if (rslt == DBIERR_NONE)
      {
         if (pIdx->pGroups)
            pIdx->pGroups->Reset();
         rslt = pIdx->IdxCreateOrder(NULL, NULL);
      }
   }
   if (rslt == DBIERR_NONE)
   {
      iFilters++;
      iSeqNo = pIdx->iSeqNo-1; // Force setting of iFirst/iLast. MUST be done, since iSeqno is reset in IdxCreate, and can end up with the same
      MoveToBookMark((pBYTE) &BkMark);
   }
Exit:
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::AddFilterCallBack( // Add a canexpr-filter to this cursor
   ULONGP iClientData, // Client supplied data
   pfDSFilter pfFilter, // ptr to filter function
   phDSFilter phFilter)
{
   DSBOOKMRK BkMark;
   DBIResult rslt;

   DSLOCK(pDs);
   GetCurrentBookMark((pBYTE) &BkMark);
   if (pIdx->iType != idxFilter)
   {
      DSIDXFILT *pIdxNew = new DSIDXFILT(pDs);

      rslt = pIdxNew->IdxAddFilter(iClientData, pfFilter, phFilter);
      if (rslt == DBIERR_NONE)
         rslt = pIdxNew->IdxCreateOrder(&pIdx->IdxDesc, pIdx);
      if (rslt == DBIERR_NONE)
      {
         pIdx->Release();
         pDs->AddIndex(pIdxNew); // Make it maintained
         pIdx = pIdxNew;
      }
   }
   else
   {
      rslt = ((DSIDXFILT*)pIdx)->IdxAddFilter(iClientData, pfFilter, phFilter);
      if (rslt == DBIERR_NONE)
         rslt = pIdx->IdxCreateOrder(NULL, NULL);
   }
   if (rslt == DBIERR_NONE)
   {
      iFilters++;
      iSeqNo = pIdx->iSeqNo-1; // Force setting of iFirst/iLast. MUST be done, since iSeqno is reset in IdxCreate, and can end up with the same
      MoveToBookMark((pBYTE) &BkMark);
   }
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::DropFilter( // Drop a filter
   hDSFilter hFilter)
{
   DBIResult rslt;

   DSLOCK(pDs);
   if (hFilter)
   {
      if (pIdx->iType == idxFilter)
      {
         rslt = ((DSIDXFILT*)pIdx)->IdxRemFilter(hFilter);
         if (rslt == DBIERR_NONE)
         { // Use original order (or, if not sortindex, switch to original!
            pDSIDX pIdxSameOrder = NULL;
            pDs->FindEqIndex(&pIdx->IdxDesc, &pIdxSameOrder);
            if (pIdx->pGroups)
               pIdx->pGroups->Reset();
            rslt = pIdx->IdxCreateOrder(NULL, pIdxSameOrder); // Regen
         }
         if (rslt == DBIERR_NONE)
         {
            if (hFilter)
               iFilters--;
            else
               iFilters = 0;
         }
      }
   }

   if (rslt == DBIERR_NONE)
   {
      iSeqNo = pIdx->iSeqNo-1; // Resync
   }
   DSUNLOCK(pDs);
   return rslt;
}

VOID DBIFN CursorCallBack(ULONGP hCursor)
{
   DSCursor *pCur = (DSCursor*)hCursor;

   if (pCur->pfNotifyCallBack)
      pCur->pfNotifyCallBack(pCur->iNotifyData);
}

DBIResult DBIFN DSCursor::SetNotifyCallBack( // Called when posting changes to dataset
   ULONGP iClientData, // Pass-thru client data
   pfCHANGECallBack pfCallBack // Call back fn being registered
   )
{
   DBIResult rslt = DBIERR_NONE;

   if (pfNotifyCallBack)
   { // Remove current
      iNotifyData = 0;
      pfNotifyCallBack = NULL;
      pDs->SetNotifyCallBack(reinterpret_cast<ULONGP>(this), NULL);
   }

   if (pfCallBack != NULL)
   { // Add new one
      rslt = pDs->SetNotifyCallBack(reinterpret_cast<ULONGP>(this), CursorCallBack);
      if (!rslt)
      {
         iNotifyData = iClientData;
         pfNotifyCallBack = pfCallBack;
      }
   }
   return rslt;
}

DBIResult DBIFN DSCursor::VerifyField( // Verify if field value is valid
   UINT32 iFieldNo, pBYTE pFldBuf)
{
   DBIResult rslt = DBIERR_NONE;
   BOOL bValid;

   DSLOCK(pDs);
   bValid = pDs->pDsConstr && !pDs->bConstraintsDisabled ? pDs->pDsConstr->Evaluate(iFieldNo, pFldBuf) : TRUE;
   if (!bValid)
   {
      rslt = DBIERR_CONSTRAINTFAILED; // DId not pass constraint
   }
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::GetProp( // Get property
   CURProp eProp, // Property to get
   pULONGP piPropValue // Returns property value (or pointer depending on type)
   )
{
   DBIResult rslt = DBIERR_NONE;

   switch(eProp)
   {
   case curpropDSBASE:
      if (piPropValue)
         *piPropValue = reinterpret_cast<ULONGP>(pDs);
      break;

   case curpropGETORG_RECBUF:
      if (piPropValue)
      { // piPropValue is pointer to record buffer
         pBYTE pRecBuf = (pBYTE)piPropValue;
         UINT32 iRecNo;
         UINT32 iRecNoBef, iTmp;

         rslt = GetRecordNumber(&iRecNo);
         if (rslt)
            goto Exit;
         iRecNoBef = iRecNo;
         if (iRecNo && pDs->pDsLog)
         {
            while ((iTmp = pDs->pDsLog->GetPrevRecNo(iRecNoBef)) != iRecNoBef && iTmp != 0)
               iRecNoBef = iTmp;
         }
         if (iRecNoBef != iRecNo)
         {
            rslt = pDs->GetRecord(iRecNoBef, pRecBuf);
         }
         else
            rslt = DBIERR_RECNOTFOUND;
      }
      break;

   default:
      rslt = DBIERR_INVALIDPARAM;
      break;
   }
Exit:
   return rslt;
}

DBIResult DBIFN DSCursor::SetProp( // Set property
   CURProp eProp, // Property to set
   ULONGP iPropValue // Property value (or pointer to value)
   )
{

   DBIResult rslt = DBIERR_NONE;

   switch(eProp)
   {
   case curpropSETCRACK:
      if (iPropValue == 0)
         iPropValue = DBIERR_NOCURRREC;
      if (iCurState == 0)
      {
         iCurState = iPropValue;
         SavePos();
         iSeqNoM++;

      }
      break;

   case curpropFLD_MAKERW:
      pFieldDesc[static_cast<ULONGP>(iPropValue-1)].iFldAttr = pFieldDesc[static_cast<ULONGP>(iPropValue-1)].iFldAttr & (~fldAttrREADONLY); // Remove bit
      break;

   case curpropFLD_MAKEREADONLY:
      pFieldDesc[static_cast<ULONGP>(iPropValue-1)].iFldAttr |= fldAttrREADONLY; // Set bit
      break;

   default:
      rslt = DBIERR_INVALIDPARAM;
      break;
   }
   return rslt;
}

DBIResult DBIFN DSCursor::CloneCursor( // Clones a cursor
   pVOID pTCur // Initialized cursor to clone
   )
{
   DBIResult rslt = DBIERR_NONE;
   DSBOOKMRK BkMark;
   UINT32 i;
   DSCursor * pCur = (DSCursor*)pTCur;

   if (pCur == NULL || pCur->pDs == NULL)
      return DBIERR_INVALIDPARAM;

   DSLOCK(pCur->pDs);
   if (pDs)
   {
      if (pCur->pDs != pDs)
         rslt = DBIERR_NA; // Not allowed
   }
   else
      rslt = InitCursor((TDSBASE*)pCur->pDs);

   if (!rslt)
   {
      DSIDX *pIdxOld = pCur->pIdx;
      DSIDXDesc *pIdxDesc = &pIdxOld->IdxDesc;

      if (pCur->hCurParent && !this->hCurParent)
      {
         rslt = pCur->hCurParent->LinkCursors(0, NULL, NULL, this);
         if (rslt)
            goto Exit;
      }
      pCur->GetCurrentBookMark((pBYTE) &BkMark);

      // Use index order
      if (pIdxOld->bSortIndex)
      { // Is it a sort-index ?
      SortIndex:
         ULONGP tmp[DBIMAXFLDSINKEY];
         for (i = 0; i < pIdxDesc->iFields; i++)
           tmp[i] = pIdxDesc->iKeyFields[i];
         rslt = SortOnFields(pIdxDesc->iFields, tmp, pIdxDesc->bDescending,
            pIdxDesc->bCaseInsensitive);
      }
      else
      {
         rslt = UseIndexOrder(pIdxDesc->szName);
         if (rslt == DBIERR_NOSUCHINDEX && pIdxOld->iType == idxFilter)
         {
            goto SortIndex; // It is a Filter-sort-index!
         }
      }
      if (rslt)
         goto Exit;

      // Clone all filters
      if (pCur->iFilters)
      {
         DSIDXFILT *pIdxOld = (DSIDXFILT*)pCur->pIdx;

         for (i = 0; i < pIdxOld->pFilt->iLast; i++)
         {
            CONSTREntry *pEntry = &pIdxOld->pFilt->pEntries[i];

            if (pEntry->pCanExpr)
            {
               rslt = AddFilter(pEntry->pCanExpr, pEntry->iLen, NULL);
               if (rslt)
                  goto Exit;
            }
            else
            {
               if (pEntry->pfFilter)
               { // callback
                  rslt = AddFilterCallBack(pEntry->iClientData, pEntry->pfFilter, NULL);
                  if (rslt)
                     goto Exit;
               }
            }
         }
      }
      // Clone range
      if (pCur->bActiveRange)
      {
         rslt = SetRange(pCur->iRangeFieldsLow, pCur->pRangeLow, pCur->bRangeIncLow, pCur->pRangeHigh,
            pCur->bRangeIncHigh);
         if (hCurParent)
         {
            iSeqNoD--;
            ResyncWithMaster();
         }
      }
   }

Exit:
   if (rslt)
   {
   }
   else
   {
      MoveToBookMark((pBYTE) &BkMark);
   }
   DSUNLOCK(pCur->pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::AddAggregate(UINT32 iFlds, // Defines grouping  (0 if global)
   UINT32 iCanLen, // Length of canexpr (0 if grouping only)
   pVOID pCanExpr, // Canexpression for aggregate
   phDSAggregate phAgg // returns aggregate handle
   )
{
   DBIResult rslt = DBIERR_NONE;

   if (pIdx == NULL)
      return DBIERR_NA;

   DSLOCK(pDs);
   if ((pIdx->iType != idxNormal || pIdx->bSortIndex) && (iFlds != 0))
   { // A filter index can not have aggregates added to itself, because it is
      // a copy of an undelying index, that would not see the aggregates.
      rslt = DBIERR_NA;
      goto Exit;
   }
   // Should we check that usecount is 1 ? Another cursor could be using a
   // filterindex, that in that case would be 'incompatible'.
   if (pIdx->pGroups == NULL)
   {
      pIdx->pGroups = new IDXGROUPINGMNG(pIdx);
      if (pIdx->pGroups == NULL)
      {
         rslt = DBIERR_NOMEMORY;
         goto Exit;
      }
   }
   if (pDs->pDsParent)
   { // Take into account the 'link'field'
      if (iFlds < pIdx->IdxDesc.iFields)
         iFlds++;
   }

   // 'Groups', GroupingMng is now defined
   rslt = pIdx->pGroups->AddAggs(iFlds, iCanLen, (pBYTE)pCanExpr, phAgg);
Exit:
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::DropAggregate(hDSAggregate hAgg)
{
   DBIResult rslt = DBIERR_NONE;

   if (pIdx == NULL || pIdx->pGroups == NULL)
      return DBIERR_INVALIDPARAM;

   DSLOCK(pDs);
   if (iFilters || pIdx->bSortIndex)
   { // Dropping an aggregate from a filter index would make it 'incompatible'
      // with the underlying index
      rslt = DBIERR_NA;
      goto Exit;
   }
   rslt = pIdx->pGroups->DropAggs(hAgg);
Exit:
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::GetAggregateValue(hDSAggregate hAgg, pBYTE pValue, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   UINT16 iGrp = (UINT16)(hAgg >> 16); // If 0 -> global one, we do not need to have a current position

   if (pIdx == NULL)
      return DBIERR_INVALIDPARAM;
   DSLOCK(pDs);
   if (iGrp == 0 || (iGrp == 1 && pDs->pDsParent)) // Global or 'global for detail'
   { // Global aggregate
      DSIDX *pIdxTmp;
      UINT32 iCurPosAdj = iCurPos;

      if (iGrp)
      {
         ResyncWithMaster();
         if (iCurState)
         { // We need to find a valid cusrsor position, if any
            if (iCurLast >= iCurFirst)
            {
               iCurPosAdj = iCurFirst;
            }
            else
            { // Empty data set
               if (pbBlank)
                  *pbBlank = TRUE;
               goto Exit;
            }
         }
      }
      if (pIdx->pGroups)
      {
         rslt = pIdx->pGroups->GetAggValue(hAgg, iCurPosAdj, pValue, pbBlank);
         if (rslt == DBIERR_NONE)
            goto Exit;
      }
      pIdxTmp = pDs->pIdx;
      while (pIdxTmp)
      { // Try to find it on all other indexes
         if (pIdxTmp->pGroups)
            rslt = pIdxTmp->pGroups->GetAggValue(hAgg, iCurPosAdj, pValue, pbBlank);
         if (rslt == DBIERR_NONE)
            goto Exit;
         pIdxTmp = pIdxTmp->pIdxNext;
      }
      rslt = DBIERR_INVALIDPARAM;
      goto Exit;
   }

   ResyncWithMaster();
   Resync();
   if (!iCurState)
   {
      if (pIdx->pGroups == NULL)
      {
         rslt = DBIERR_NOSUCHAGGREGATE;
         goto Exit;
      }
      rslt = pIdx->pGroups->GetAggValue(hAgg, iCurPos, pValue, pbBlank);
   }
   else
      rslt = (DBIResult)iCurState;
Exit:
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::GetAggregateDesc(hDSAggregate hAgg, pDSFLDDesc pDesc)
{
   DBIResult rslt = DBIERR_NONE;

   if (pIdx == NULL || pIdx->pGroups == NULL)
      return DBIERR_INVALIDPARAM;

   rslt = pIdx->pGroups->GetAggDesc(hAgg, pDesc);
   return rslt;
}

DBIResult DBIFN DSCursor::MoveToNextSubGroup(UINT32 iFields)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iPos, iPosNew;

   if (pIdx == NULL || pIdx->pGroups == NULL)
      return DBIERR_INVALIDPARAM;

   DSLOCK(pDs);
   ResyncWithMaster();
   Resync();
   // Ignore iCurState!?
   iPos = iCurPos;
   if (pDs->pDsParent)
   { // Take into account the 'link'field'
      if (iFields < pIdx->IdxDesc.iFields)
         iFields++;
   }
   rslt = pIdx->pGroups->NextSubGroup(iFields, iPos, &iPosNew);
   if (rslt == DBIERR_NONE && iPosNew < ENDPOS)
   {
      iCurPos = iPosNew;
   }
   else
   {
      MoveToEOF();
      rslt = DBIERR_EOF;
   }
   DSUNLOCK(pDs);
   return rslt;
}

DBIResult DBIFN DSCursor::GetSubGroupState(UINT32 iFields, GROUPSTATE *piSubGroupState)
{
   DBIResult rslt = DBIERR_NONE;

   if (pIdx == NULL || pIdx->pGroups == NULL)
      return DBIERR_INVALIDPARAM;

   DSLOCK(pDs);
   ResyncWithMaster();
   Resync();
   if (!iCurState)
   {
      if (pDs->pDsParent)
      { // Take into account the 'link'field'
         if (iFields < pIdx->IdxDesc.iFields)
            iFields++;
      }
      rslt = pIdx->pGroups->GetSubGroupState(iFields, iCurPos, piSubGroupState);
   }
   else
      rslt = (DBIResult)iCurState;
   DSUNLOCK(pDs);
   return rslt;
}

