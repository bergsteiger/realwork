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
#include "dsconst.h"

int MultiByteToUTF8(INT32 AnsiCP, unsigned char*Input, unsigned int InputLen, unsigned char*Output, unsigned int OutputLen);
int UTF8ToMultiByte(INT32 AnsiCP, unsigned char*Input, unsigned int InputLen, unsigned char*Output, unsigned int OutputLen);

extern INT32 iObjCount;
DBIResult MakeFldDescs(UINT32 iFlds, pDSFLDDesc pFldDes, pUINT32 piFlds, pDSFLDDesc *ppFldDes,
   pUINT32 piFldsCompressed);
UINT32 ComputeMaxFieldIDs(UINT32 iFlds, pDSFLDDesc pFldDes, pUINT32 piCompressed);
// from dsinmem2.cpp
DBIResult DBIFN AddChangeIndex(pDSBASE pDs, BOOL bWalkTree);

DBIResult DBIFN ExtractEmbeddedTables(DSBASE *pDs, pUINT32 piFields, pUINT32 piCompressedFields,
   pDSFLDDesc pFieldDesc);

// From dsinmem2.cpp
DBIResult DBIFN InitEmbeddedTable(DSBASE * pDs, DSBASE * pDsDet, UINT32 iFieldIDM // Master fieldID
);

DSBASE::DSBASE(VOID)
{
   InitDsObj(NULL);
   bUTF8METADATA = 0;
   iANSICodePage = 0;
   InitializeCriticalSection(&s_Crit);
   iRefCount = 0;
   iObjCount++;
}

// Create empty dataset
DBIResult DBIFN DSBASE::Create(UINT32 iFlds, // Number of fielddesc. following
   pDSFLDDesc pFldDes, pCHAR pDsName)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;

   LOCK();
   // We should check that dataset does not already contain a dataset
   if (bPartial != -1)
   { // Initialized by somebody else
      rslt = DBIERR_NONE;
      goto Exit;
   }
   InitDsObj(pDsName);

   if (pFldDes)
   { // Data is given,

      iFieldsCompressed = iFlds;
      rslt = MakeFldDescs(iFlds, pFldDes, &iFields, &pFieldDesc, &iFieldsCompressed);
      if (rslt)
         goto Exit;
      // Adjusts iFields and pFieldDesc
      rslt = ExtractEmbeddedTables(this, &iFields, &iFieldsCompressed, pFieldDesc);
      if (rslt)
         goto Exit;
   }

   rslt = InitializeFields();
   if (rslt)
      goto Exit;

   if (pLinkedTables)
   {
      pLinkedTables->AdjustFieldIDs(); // Not known until know!
   }

   iFieldsDataPacket = iFields;
   for (i = 0; i < iFields; i++)
   {
      if (pFieldDesc[i].iFldSubType == fldstAUTOINC && pFieldDesc[i].iFldLen == sizeof(UINT32))
      {
         iAutoIncField = i+1;
         break;
      }
   }

   // Create default order
   if (pIdxDef == NULL)
   {
      DBIResult rslt;
      DSIDXDesc DefIdxDesc;

      ZeroMem(&DefIdxDesc, sizeof(DSIDXDesc));
      LdStrCpy(DefIdxDesc.szName, szDEFAULT_ORDER);
      rslt = CreateIndex(&DefIdxDesc);
      if (rslt == DBIERR_NONE)
         FindIndex(szDEFAULT_ORDER, &pIdxDef);
      else
         goto Exit;
   }

   rslt = AddChangeIndex(this, TRUE); // recurse
   if (rslt)
      goto Exit;

   // Get internal record buffer
   rslt = GetByteBuffer(iRecordSize, &pAuxRecBuf, FALSE);

Exit:
   if (rslt)
   {
      ResetAll();
   }
   else
   {
      bPartial = FALSE;
   }
   UNLOCK();
   return rslt;
}

VOID DBIFN DSBASE::InitDsObj(pCHAR pDsName)
{
   UINT32 i;

   // put all initialization here
   if (pDsName)
   {
      pszName = new CHAR[LdStrLen(pDsName)+1];
      LdStrCpy(pszName, pDsName);
   }
   else
      pszName = NULL;

   pIdx = NULL; // Marked with * below : affected by AddField
   pIdxDef = NULL;
   pIdxChg = NULL;
   pDsLog = NULL;
   iIndexes = 0;
   iIndexesShared = 0;
   pAuxRecBuf = NULL; // *
   piAttr = NULL;
   pFieldDesc = NULL; // *

   iFields = 0; // *
   iBlobFields = 0; // *
   iNullOffset = 0; // *
   iNullLength = 0; // *
   iRecordSize = 0; // *
   iRecordSpace = 0;
   pDsBlobs = NULL;
   pDsConstr = NULL;
   pDsOptParams = NULL;
   pDsCallBacks = NULL;
   iRecords = 0;
   iRecNoNext = 1;
   bDelta = FALSE;
   ppColumns = NULL; // *
   pNulls = NULL; // *
   bDisableLog = FALSE;
   iIndexIDs = 0;
   iLCID = 0;
   bReadOnly = FALSE;

   iCalcClientData = 0;
   pfCalcFn = NULL;

   pDsExtract = NULL;
   pDsExtractSave = NULL;
   bPartial = -1; // Not initialized, TRUE : partial, FALSE : Complete
   bConstraintsDisabled = FALSE;
   bDefOrderChanged = FALSE;
   iAutoIncField = 0;
   iAutoIncNext = 1;
   bDontInclMetaData = FALSE;
   iSeqSavePoints = 1; // Sequence number to invalidate savepoints
   bCompressArrays = FALSE;
   iFieldsCompressed = 0; // *
   iFieldsDataPacket = 0;
   pLinkedTables = NULL;
   pDsParent = NULL;
   iSetIDNext = 1;
   iDetID = 0;
   iLinkFields = 0;
   for (i = 0; i < DBIMAXFLDSINKEY; i++)
      piLinkField[i] = 0;
   iMDSemantics = mdNONE;
   iFieldID_SetIDD = 0;
   pStrings = NULL;
   pDsReq = NULL;
   iUnusedCnt = 0;
   iRemoteUpdMode = dsUPDMODE_ALL; // dsUPDMODE_KEY; // Default = update where all
   bIgnSetIDInIdx = FALSE;
#ifdef MIDAS_DLL
   iXmlMode = 0;
#else
   iXmlMode = 0x0001+0x0004;
#endif
   pFldBufScratch = NULL;
   iFldBufScratchLen = 0;
   bDisableDeletes = FALSE;
   bDisableInserts = FALSE;
   bDisableEdits = FALSE;
   bDisableStringTrimming = FALSE; // Disable trimming of strings (in putfield)
   bDataHasChanged = FALSE;

   // bUTF8METADATA is initialized in constructor.
   // bUTF8METADATA = FALSE; // Default is FALSE.
}

DSBASE::~DSBASE()
{
   LOCK();
   ResetAll();
   UNLOCK();
   DeleteCriticalSection(&s_Crit);
   iObjCount--;
}

VOID DBIFN DSBASE::ResetAll(VOID)
{
   UINT32 i;

   if (pAuxRecBuf)
      delete[] pAuxRecBuf;

   // Delete all known indices
   while (pIdx != NULL)
      DropIndex(pIdx);
   pIdxDef = NULL;
   pIdxChg = NULL;

   if (pDsBlobs)
      delete pDsBlobs;
   if (pDsLog)
      delete pDsLog;
   if (pDsConstr)
      delete pDsConstr;
   if (pDsOptParams)
      delete pDsOptParams;
   if (pDsCallBacks)
      delete pDsCallBacks;
   if (pFieldDesc)
      delete[] pFieldDesc;

   if (ppColumns)
   {
      for (i = 0; i < iFields; i++)
      {
         DsFree(ppColumns[i]);
         ppColumns[i] = NULL;
      }
      delete[] ppColumns;
   }
   if (piAttr)
      DsFree(piAttr);
   if (pNulls)
      DsFree(pNulls);
   if (pszName)
      delete[] pszName;

   if (pDsExtract)
      delete pDsExtract;

   if (pDsExtractSave)
      delete pDsExtractSave;

   if (pLinkedTables)
      delete pLinkedTables;

   if (pStrings)
      delete pStrings;

   if (pDsReq)
      delete pDsReq;

   if (pFldBufScratch)
      delete[] pFldBufScratch;
   iFldBufScratchLen = 0;

   InitDsObj(NULL);
}

HRESULT DBIFN DSBASE::QueryInterface(REFIID riid, void** ppv)
{
#ifdef MIDAS_DLL
   if (IsEqualCLSID(riid, IID_MDSBASE_1) || IsEqualCLSID(riid, IID_IUnknown))
#else
      if (IsEqualCLSID(riid, IID_DSBASE_1) || IsEqualCLSID(riid, IID_DSBASE_2) || IsEqualCLSID(riid, IID_IUnknown))
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

DBIResult DBIFN DSBASE::IsValidRec(UINT32 iRecNo)
{
   DBIResult rslt = DBIERR_NONE;

   LOCK();
   if (iRecNo == 0 || iRecNo > iRecNoNext)
   {
      rslt = DBIERR_OUTOFRANGE;
   }
   else
   {
      if (!bDelta && piAttr[iRecNo-1] & dsISNOTVISIBLE)
         rslt = DBIERR_NA;
   }
   UNLOCK();
   return rslt;
}

// Grow the number of allocated rows, but not beyond the specified max limit
DBIResult DBIFN DSBASE::GrowRows(UINT32 iAddRecs, UINT32 iMax)
{
   if (iMax > 0)
   {
      UINT32 iCurrSize = iRecordSpace;

      if (iCurrSize >= iMax)
         iAddRecs = 0;
      else
      {
         if (iCurrSize + iAddRecs > iMax)
         {
            iAddRecs = iMax - iCurrSize;
         }
      }
   }
   if (iAddRecs == 0) // Nothing to do
      return DBIERR_NONE;
   return GrowDS(iAddRecs);
}

DBIResult DBIFN DSBASE::IncRow(VOID)
{
   if (++iRecNoNext < iRecordSpace)
      return DBIERR_NONE;
   if (iRecordSpace > 1000)
      return GrowDS(iRecordSpace/2);
   return GrowDS(iRecordSpace); // Double
}

DBIResult DBIFN DSBASE::GrowDS(UINT32 iAddRecs)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   pBYTE pTmp;
   UINT32 iSize, iNewSize;

   // Attr field
   iSize = iRecordSpace*sizeof(DSAttr);
   iNewSize = iSize + (iAddRecs)*sizeof(DSAttr);
   pTmp = piAttr;
   pTmp = (pBYTE)DsRealloc((pVOID)pTmp, iSize, iNewSize);
   if (pTmp == NULL)
   {
      rslt = DBIERR_NOMEMORY;
      goto Exit;
   }
   piAttr = pTmp;

   // Null field
   if (iFields == 0)
      goto Exit;
   iSize = iRecordSpace*iNullLength;
   iNewSize = iSize + (iAddRecs)*iNullLength;
   pTmp = pNulls;
   pTmp = (pBYTE)DsRealloc((pVOID)pTmp, iSize, iNewSize);
   if (pTmp == NULL)
   {
      rslt = DBIERR_NOMEMORY;
      goto Exit;
   }
   pNulls = pTmp;

   // All fields
   for (i = 0; i < iFields; i++)
   {
      iSize = iRecordSpace*pFieldDesc[i].iFldLen;
      iNewSize = iSize + (iAddRecs)*pFieldDesc[i].iFldLen;
      if (iNewSize) // Otherwise ADT/ARRAY field!
      {
         pTmp = (pBYTE)ppColumns[i];
         pTmp = (pBYTE)DsRealloc((pVOID)pTmp, iSize, iNewSize);
         if (pTmp == NULL)
         {
            rslt = DBIERR_NOMEMORY;
            goto Exit;
         }
         ppColumns[i] = pTmp;
      }
   }

Exit:
   if (!rslt)
   {
      iRecordSpace += iAddRecs;
   }
   return rslt;
}

UINT32 DBIFN DSBASE::AddRef(VOID)
{
   return++iRefCount;
}

UINT32 DBIFN DSBASE::Release(VOID)
{
   UINT32 iRefSave;

   if (iRefCount > 0)
      iRefSave = --iRefCount;
   else
      iRefSave = iRefCount;
   if (iRefCount == 0)
      delete this;
   return iRefSave;
}

DBIResult DBIFN DSBASE::GetErrorString(DBIResult iErrCode, pCHAR pString)
{
#ifdef _UNIX
   int i;
   if (pString)
   {
      *pString = '\0';
      if (iErrCode == DBIERR_CONSTRAINTFAILED && pDsConstr && pDsConstr->szErrMsg[0])
      {
         LdStrCpy(pString, pDsConstr->szErrMsg);
         pDsConstr->szErrMsg[0] = '\0';
      }
      else if (LoadString((HINSTANCE)0, iErrCode, pString, DBIMAXMSGLEN) == 0)
      {
         for (i = 0; i < MAXMIDASERRORS; i++)
         {
            if (iErrCode == ResourcedErrorString[i].errorCode)
            {
               strcpy(pString, ResourcedErrorString[i].message);
               return DBIERR_NONE;
            }
         }
         return SetError(DBIERR_OBJNOTFOUND); // resource not found
      }
   }
#else
   ULONGP hDll;

   if (pString)
   {
      *pString = '\0';
      if (iErrCode == DBIERR_CONSTRAINTFAILED && pDsConstr && pDsConstr->szErrMsg[0])
      {
         LdStrCpy(pString, pDsConstr->szErrMsg);
         pDsConstr->szErrMsg[0] = '\0';
      }
      else
      {
#ifdef MIDAS_OBJ
         // For midaslib, main application contains resources.
         hDll = GetResourceModuleHandle(NULL);
#else
         hDll = GetResourceModuleHandle(szALCHEMYDLL);
#endif
         if (hDll < HINSTANCE_ERROR)
            hDll = reinterpret_cast<ULONGP>(GetModuleHandle(NULL));

         if (hDll < HINSTANCE_ERROR)
            return DBIERR_OBJNOTFOUND; // resource not found

         if ((bUTF8ERRORMSG ? LoadStringUTF8((HINSTANCE)hDll, iErrCode, pString, DBIMAXMSGLEN) : LoadString
               ((HINSTANCE)hDll, iErrCode, pString, DBIMAXMSGLEN)) == 0)
            return DBIERR_OBJNOTFOUND; // resource not found
      }
   }
#endif
   return DBIERR_NONE;
}

DBIResult DBIFN DSBASE::GetProps(pDSProps pProps)
{
   // LOCK();
   ZeroMem(pProps, sizeof(DSProps));
   if (pszName)
      LdStrCpy(&pProps->szName[0], pszName);
   else
      pProps->szName[0] = 0;
   pProps->iFields = bCompressArrays ? iFieldsCompressed : iFields;
   pProps->iRecBufSize = iRecordSize;
   pProps->iBookMarkSize = BOOKMARKSIZE;

   // Should only return idxNormal-indexes
   pProps->iIndexes = iIndexesShared;
   pProps->iOptParams = pDsOptParams ? pDsOptParams->iLast : 0;
   pProps->bDelta = bDelta;
   pProps->bReadOnly = bReadOnly;
   pProps->iLCID = iLCID;
   // UNLOCK();
   return DBIERR_NONE;
}

// Helper function for GetFldDesc
// pFldDes[*pi] points to array-desc. This element HAS been copied.
// Function compresses all array elemenyts into pFldDesC[*pj], and
// updates *pi and *pj
VOID CompressFldDescs(pUINT32 pi, pDSFLDDesc pFldDes, pUINT32 pj, pDSFLDDesc pFldDesC, UINT32 iFields)
{
   UINT32 iElCnt, iElSize;
   UINT32 i, j;

   if (pi == NULL)
   { // First level)
      iElCnt = 1;
      iElSize = iFields;
   }
   else
   {
      iElCnt = pFldDes[*pi].iUnits1;
      iElSize = pFldDes[*pi].iUnits2/iElCnt; // Total number of fields in each element
   }

   for (i = (pi == NULL)? 0 : *pi+1, j = (pj == NULL)? 0 : *pj+1; i < (((pi == NULL)? 0 : *pi+1) + iElSize); i++, j++)
   {
      CopyMem(&pFldDesC[j], &pFldDes[i], sizeof(DSFLDDesc));
      if (pFldDes[i].iFldType == fldARRAY)
      {
         CompressFldDescs(&i, pFldDes, &j, pFldDesC, 0);
      }
   }
   if (pi)
   {
      *pi += iElCnt*iElSize;
      *pj += iElSize;
   }
}

DBIResult DBIFN DSBASE::GetFieldDescs(pDSFLDDesc pFldDesc)
{
   LOCK();
   if (bCompressArrays && iFields != iFieldsCompressed)
   {
      CompressFldDescs(NULL, pFieldDesc, NULL, pFldDesc, iFields);
   }
   else
   {
      CopyMem(pFldDesc, &pFieldDesc[0], iFields*sizeof(DSFLDDesc));
   }
   UNLOCK();
   return DBIERR_NONE;
}

DBIResult DBIFN DSBASE::GetIndexDescs(pDSIDXDesc pIdxDesc)
{
   UINT32 i, j;
   pDSIDX pTmp = pIdx;

   LOCK();
   // Should only return idxNormal-indexes
   for (i = 0, j = 0; i < iIndexes; i++)
   {
      if (pTmp == NULL || j >= iIndexesShared)
         break;
      if (!pTmp->bSortIndex && (pTmp->iType == idxNormal || pTmp->iType == idxChange))
      {
         CopyMem((pBYTE) &pIdxDesc[j], (pBYTE) &pTmp->IdxDesc, sizeof(DSIDXDesc));
         j++;
      }
      pTmp = pTmp->pIdxNext;
   }
   UNLOCK();
   return DBIERR_NONE;
}

DBIResult DBIFN DSBASE::AcceptChanges(VOID)
{
   DBIResult rslt = DBIERR_NONE;

   LOCK();
   rslt = Reconcile_MD(NULL, NULL, NULL, 0, NULL);
   UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::GetProp( // Get property
   DSProp eProp, // Property to get
   pULONGP piPropValue // Returns property value (or pointer depending on type)
   )
{
   DBIResult rslt = DBIERR_NONE;

   LOCK();
   switch(eProp)
   {
   case dspropLOGCHANGES:
      if (piPropValue)
         *piPropValue = (UINT32)!bDisableLog;
      break;
   case dspropREADONLY:
      if (piPropValue)
         *piPropValue = (UINT32)bReadOnly;
   case dspropNOOFCHANGES:
      if (piPropValue)
      {
         UINT32 i, iChanges = 0;

         if (pDsLog && pDsLog->iLast)
         {
            DSLOG *pLogNew = new DSLOG(pDsLog->iLast, NULL);

            if (pDsLog->CompactLog(pLogNew) == DBIERR_NONE && pLogNew->iLast > 0)
            {
               iChanges = pLogNew->iLast;
               for (i = 0; i < pLogNew->iLast; i++)
               {
                  LOGENTRY *pLogEntry = &pLogNew->pLogEntries[i];
                  if (pLogEntry->iAttr == dsRecModified)
                  {
                     if (RecsEqual(pLogEntry->iRecNo2, pLogEntry->iRecNo1, TRUE, NULL))
                        iChanges--; // Changes were canceled out
                  }
               }
            }
            delete pLogNew;
         }
         else if (bDelta) // XML-hack
            iChanges = iRecNoNext-1;
         *piPropValue = iChanges;
      }
      break;
   case dspropCONSTRAINTS_DISABLED:
      if (piPropValue)
      {
         *piPropValue = bConstraintsDisabled;
      }
      break;
   case dspropDSISPARTIAL:
      if (piPropValue)
      {
         *piPropValue = (bPartial == TRUE);
      }
      break;
   case dspropRECORDSINDS:
      if (piPropValue)
      {
         *piPropValue = iRecords; // or pIdxDef->iRecs ?
      }
      break;
   case dspropAUTOINC_DISABLED:
      if (piPropValue)
      {
         *piPropValue = (iAutoIncField == 0);
      }
      break;
   case dspropISDELTA:
      if (piPropValue)
      {
         *piPropValue = (bDelta);
      }
      break;
   case dspropDONTINCLMETADATA:
      if (piPropValue)
      {
         *piPropValue = (bDontInclMetaData);
      }
      break;
   case dspropINCLBLOBSINDELTA:
      if (piPropValue)
      {
         *piPropValue = (iInclBlobsInDelta);
      }
      break;
   case dspropGETSAVEPOINT:
      if (piPropValue)
      {
         UINT32 iSavePoint = 0;

         if (pDsLog)
         {
            pDsLog->GetSavePoint(&iSavePoint);
         }
         *piPropValue = iSavePoint;
      }
      break;
   case dspropCOMPRESSARRAYS:
      if (piPropValue)
      {
         *piPropValue = bCompressArrays;
      }
      break;

   case dspropMD_SEMANTICS:
      if (piPropValue)
      {
         *piPropValue = iMDSemantics; // & mdMD; //
      }
      break;

   case dspropFIELD_FULLNAME:
      if (piPropValue)
      {
         UINT32 iFieldID = *piPropValue;
         UINT32 iIds[32];
         UINT32 iCnt = 0, i;
         pCHAR pStrOut = (pCHAR)piPropValue;

         if (iFieldID == 0 || iFieldID > iFields)
            goto Err;

         while (iFieldID)
         {
            iIds[iCnt++] = iFieldID;
            iFieldID = pFieldDesc[iFieldID-1].iFieldIDParent;
         }
         i = iCnt;
         pStrOut[0] = 0;
         do
         {
            pDSFLDDesc pFldDes;
            iFieldID = iIds[i-1];
            pFldDes = &pFieldDesc[iFieldID-1];
            if (pFldDes->iFldType == fldARRAY)
               continue; // Name is in element!
            LdStrCat(pStrOut, pFldDes->szName);
            if (i > 1 /* && pFldDes->szName[0] != '[' */ ) // not too nice
            {
               LdStrCat(pStrOut, ".");
            }
         }
         while (--i);
      }
      break;

   case dspropFIELDID_FORNAME:
      if (piPropValue)
      {
         rslt = DBIERR_INVALIDPARAM;
      }
      break;

   case dspropFIELDID_FORPARENT:
      if (piPropValue)
      {
         UINT32 iFieldID = *piPropValue;
         if (iFieldID == 0 || iFieldID > iFields)
            goto Err;

         *piPropValue = pFieldDesc[iFieldID-1].iFieldIDParent;
      }
      break;

   case dspropCHANGEINDEX_VIEW:
      if (piPropValue)
      {
         if (pIdxChg)
            *piPropValue = (UINT32)((DSIDXCHG*)pIdxChg)->iVisibleAttr;
      }
      break;

   case dspropGETUNIQUEINDEX:
      if (piPropValue)
      {
         pDSIDX pTmp = pIdx;
         UINT32 i;
         rslt = DBIERR_NOSUCHINDEX;

         for (i = 0; i < iIndexes; i++)
         {
            if (pTmp == NULL)
               break;
            if (pTmp->IdxDesc.bUnique && !pTmp->bSortIndex && pTmp->iType == idxNormal)
            { // Found one
               *piPropValue = reinterpret_cast<ULONGP>(pTmp);
               rslt = DBIERR_NONE;
               break;
            }
            pTmp = pTmp->pIdxNext;
         }
      }
      break;

   case dspropREMOTE_UPDATEMODE:
      if (piPropValue)
      {
         *piPropValue = iRemoteUpdMode;
      }
      break;
   case dspropXML_STREAMMODE:
      if (piPropValue)
      {
         *piPropValue = iXmlMode;
      }
      break;
   case dspropDISABLEDELETES:
      if (piPropValue)
      {
         *piPropValue = bDisableDeletes;
      }
      break;
   case dspropDISABLEINSERTS:
      if (piPropValue)
      {
         *piPropValue = bDisableInserts;
      }
      break;
   case dspropDISABLEEDITS:
      if (piPropValue)
      {
         *piPropValue = bDisableEdits;
      }
      break;
   case dspropDISABLESTRINGTRIMMING:
      if (piPropValue)
      {
         *piPropValue = bDisableStringTrimming;
      }
      break;

   case dspropDATAHASCHANGED:
      if (piPropValue)
      {
         *piPropValue = bDataHasChanged;
         if (bDataHasChanged == FALSE && pLinkedTables)
         {
            UINT32 i;
            pLTABLEEntry pEntry = (pLTABLEEntry)pLinkedTables->pEntries;
            for (i = 0; i < pLinkedTables->iLast; i++)
            {
               if (pEntry->pDsDet)
               {
                  pEntry->pDsDet->GetProp(eProp, piPropValue);
                  if (*piPropValue != FALSE)
                     break;
               }
               pEntry++;
            }
         }
      }
      break;

   case dspropUTF8METADATA:
      if (piPropValue)
      {
         *piPropValue = bUTF8METADATA;
      }
      break;

   case dspropUTF8ERRORMSG:
      if (piPropValue)
      {
         *piPropValue = bUTF8ERRORMSG;
      }
      break;

   case dspropANSICODEPAGE:
      if (piPropValue)
      {
         *piPropValue = iANSICodePage;
      }
      break;

   Err:
   default:
      rslt = DBIERR_INVALIDPARAM;
      break;
   }

   UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::SetProp( // Set property
   DSProp eProp, // Property to set
   ULONGP iPropValue // Property value (or pointer to value)
   )
{
   DBIResult rslt = DBIERR_NONE;

   LOCK();
   switch(eProp)
   {
   case dspropLOGCHANGES:
      bDisableLog = !((BOOL)iPropValue);
   TREEWALK:
      if (pLinkedTables)
      {
         UINT32 i;
         pLTABLEEntry pEntry = (pLTABLEEntry)pLinkedTables->pEntries;
         for (i = 0; i < pLinkedTables->iLast; i++)
         {
            if (pEntry->pDsDet)
               pEntry->pDsDet->SetProp(eProp, iPropValue);
            pEntry++;
         }
      }
      break;

   case dspropREADONLY:
      bReadOnly = (BOOL)iPropValue;
      break;

   case dspropCONSTRAINTS_DISABLED:
      bConstraintsDisabled = (BOOL)iPropValue;
      break;

   case dspropDSISPARTIAL:
      if (bPartial == FALSE && pDsExtractSave != NULL)
      {
         bPartial = TRUE;
         pDsExtract = pDsExtractSave;
         pDsExtractSave = NULL;
      }
      else
         rslt = DBIERR_NA;
      break;

   case dspropAUTOINC_DISABLED:
      if ((BOOL)iPropValue)
      { // Disable
         if (iAutoIncField)
            iAutoIncField = 0;
         else
            rslt = DBIERR_NA;
      }
      else
      { // (Find it, and set it )
      }
      break;

   case dspropDONTINCLMETADATA:
      bDontInclMetaData = (BOOL)iPropValue;
      break;

   case dspropINCLBLOBSINDELTA:
      iInclBlobsInDelta = (UINT32)iPropValue;
      break;
   case dspropCOMPRESSARRAYS:
      bCompressArrays = (BOOL)iPropValue;
      break;
   case dspropMD_SEMANTICS: // (Allow setting bits, but not removing them!)
      iMDSemantics |= (UINT32)iPropValue;
      break;
   case dspropCHANGEINDEX_VIEW:
      if (pIdxChg && ((DSIDXCHG*)pIdxChg)->iVisibleAttr != (DSAttr)iPropValue)
      {
         ((DSIDXCHG*)pIdxChg)->iVisibleAttr = (DSAttr)iPropValue;
         pIdxChg->IdxCreateOrder(NULL, NULL); // Recreate index
      }
      break;
   case dspropREMOTE_UPDATEMODE:
      iRemoteUpdMode = iPropValue;
      break;
   case dspropXML_STREAMMODE:
      iXmlMode = iPropValue;
      if (pLinkedTables)
         goto TREEWALK;
      break;
   case dspropDISABLEDELETES:
      bDisableDeletes = iPropValue;
      if (pLinkedTables)
         goto TREEWALK;
      break;
   case dspropDISABLEINSERTS:
      bDisableInserts = iPropValue;
      if (pLinkedTables)
         goto TREEWALK;
      break;
   case dspropDISABLEEDITS:
      bDisableEdits = iPropValue;
      if (pLinkedTables)
         goto TREEWALK;
      break;

   case dspropDISABLESTRINGTRIMMING:
      bDisableStringTrimming = iPropValue;
      if (pLinkedTables)
         goto TREEWALK;
      break;

   case dspropDATAHASCHANGED:
      bDataHasChanged = iPropValue;
      if (pLinkedTables)
         goto TREEWALK;
      break;

   case dspropUTF8METADATA:
      bUTF8METADATA = (BOOL)iPropValue;
      break;

   case dspropUTF8ERRORMSG:
      bUTF8ERRORMSG = (BOOL)iPropValue;
      break;

   case dspropANSICODEPAGE:
      iANSICodePage = (INT32)iPropValue;
      break;

   default:
      rslt = DBIERR_INVALIDPARAM;
      break;
   }
   UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::AddField(pDSFLDDesc pFldDes // NULL, remove all appended calculated fields
   )
{
   DBIResult rslt = DBIERR_NONE;
   pDSFLDDesc pTmp, pFldDesNew;
   UINT32 i;
   pBYTE *ppColTmp;
   INT32 iIncFields = 1;

   if (pFldDes == NULL && pFieldDesc == NULL)
      return DBIERR_INVALIDPARAM;

   LOCK();

   if (pFldDes == NULL)
   {
      iIncFields = 0;
      for (i = iFields; i > 0; i--)
      {
         if (pFieldDesc[i-1].bCalculated && !(pFieldDesc[i-1].iFldAttr & fldAttrLINK))
         {
            DsFree(ppColumns[i-1]);
            ppColumns[i-1] = NULL;
            iIncFields--;
         }
         else
            break;
      }
      if (iIncFields == 0)
         goto Exit;
      goto Delete1;
   }

   // Check for duplicate fields
   if (pFldDes->szName[0] == 0)
   {
      rslt = DBIERR_INVALIDPARAM;
      goto Exit;
   }
   if (pFldDes->iFldType == fldARRAY || pFldDes->iFldType == fldADT)
   {
      rslt = DBIERR_INVALIDPARAM;
      goto Exit;
   }
   for (i = 0; i < iFields; i++)
   { // Casesensitive compare
      if (LCStrCmp(iLCID, pFieldDesc[i].szName, pFldDes->szName) == 0)
      {
         // In case the field is part of an ADT/ARRAY, it is okay to add
         if (pFieldDesc[i].iFieldIDParent && pFieldDesc[i].iFieldIDParent != pFieldDesc[i].iFieldID)
            continue;
         if (pFieldDesc[i].bCalculated && pFieldDesc[i].iFldType == pFldDes->iFldType)
            goto Exit; // Ignore the whole thing

         rslt = DBIERR_NAMENOTUNIQUE;
         goto Exit;
      }
   }

   // If any cursors on this, return error
   // Validate pFldDes !
   pTmp = new DSFLDDesc[iFields+1];
   if (!pTmp)
   {
      rslt = DBIERR_NOMEMORY;
      goto Exit;
   }

   // Copy fields, except null-field
   if (pFieldDesc)
   {
      CopyMem(pTmp, &pFieldDesc[0], sizeof(DSFLDDesc)*iFields);
      delete[] pFieldDesc;
   }
   // Copy new field
   pFldDesNew = pTmp + iFields;
   CopyMem(pFldDesNew, pFldDes, sizeof(DSFLDDesc));
   if (pFldDesNew->bCalculated)
      pFldDesNew->bCalculated = 2; // To signal it is a local
   pFieldDesc = pTmp;

   // Affects :
   // pFieldDesc
   // iFields
   // iFieldsVisible
   // iFieldNoNulls
   // iNullOffset
   // iNullLength
   // iBlobFields
   // iRecordSize
   // pAuxRecBuf
   // FieldDesc.iNullOffsInRec
   // FieldDesc.iFldOffset
   // Affects constraints pDsConstr

   // Reallocate ppColumns
   ppColTmp = new pBYTE[iFields + 1];
   ZeroMem((pBYTE)ppColTmp, sizeof(pBYTE)*(iFields+1));
   if (ppColumns)
   {
      CopyMem(&ppColTmp[0], &ppColumns[0], sizeof(pBYTE)*iFields);
      delete[] ppColumns;
   }
   ppColumns = ppColTmp;

Delete1:

   iFields += iIncFields;
   iFieldsCompressed += iIncFields;
   InitializeFields(); // Computes iFldLen, iRecordSize etc.

   if (pFldDes == NULL) // Special case
      goto Delete2;

   if (iRecordSpace)
   {
      ppColumns[iFields-1] = (pBYTE)DsCalloc(pFieldDesc[iFields-1].iFldLen, iRecordSpace);
      if (ppColumns[iFields-1] == NULL)
      { // Backout
      BackOut:
         iFields--;
         InitializeFields();
         rslt = DBIERR_NOMEMORY;
         goto Exit;
      }
   }
   if (pAuxRecBuf)
      delete[] pAuxRecBuf;
   pAuxRecBuf = new BYTE[iRecordSize];

Delete2:

   // Reallocate nulls array (1 byte bigger per record)
   if (pNulls && iRecordSpace) // (if NULL -> allocated in GrowDs)
   {
      pBYTE pN = (pBYTE)DsMalloc(iNullLength*sizeof(BYTE)*iRecordSpace);
      pBYTE pS, pD;
      UINT32 i;
      UINT32 iOrgLen = iNullLength - iIncFields; // If deleting: iOrglen > iNullLength!

      if (pN == NULL)
         goto BackOut;

      pD = pN;
      pS = pNulls;
      // Copy over all null-values
      for (i = 0; i < iRecordSpace; i++)
      {
         if (iOrgLen < iNullLength)
         { // Normal case
            CopyMem(pD, pS, iOrgLen);
            pD += iOrgLen;
            pS += iOrgLen;
            *pD++ = BLANK_NULL;
         }
         else
         {
            CopyMem(pD, pS, iNullLength);
            pD += iNullLength;
            pS += iOrgLen;
         }
      }
      DsFree(pNulls);
      pNulls = pN;
   }

#ifdef DEBUG
   {
      pBYTE p3 = new BYTE[1000];
      delete[] p3;
   }
#endif

   // Fix up autoinc-field
   iAutoIncField = 0;
   for (i = 0; i < iFields; i++)
   {
      if (pFieldDesc[i].iFldSubType == fldstAUTOINC && pFieldDesc[i].iFldLen == sizeof(UINT32))
      {
         iAutoIncField = i+1;
         break;
      }
   }

Exit:
   if (!rslt)
   { // Fix up constraints (no filter indexes because there are no cursors)
      if (pDsConstr)
         pDsConstr->Recompile();
   }

   UNLOCK();
   return rslt;
}

// Remove all records, including blobs
// Also resets all indexes
DBIResult DBIFN DSBASE::Reset(VOID)
{
   DBIResult rslt = DBIERR_NONE;
   DSIDX *pX;

   iRecords = 0;
   iRecNoNext = 1;

   pX = pIdx;
   while (pX)
   {
      pX->iRecs = 0;
      pX->iSeqNo++;
      if (pX->pGroups)
         pX->pGroups->Reset();
      pX = pX->pIdxNext;
   }
   if (pDsBlobs)
      pDsBlobs->Reset();
   if (pDsLog)
   { // Remove delta
      delete pDsLog;
      pDsLog = NULL;
   }

   if (piAttr)
      ZeroMem(piAttr, iRecordSpace*sizeof(DSAttr));

   // Recurse
   if (pLinkedTables)
   {
      UINT32 i;
      pLTABLEEntry pEntry = (pLTABLEEntry)pLinkedTables->pEntries;

      for (i = 0; i < pLinkedTables->iLast; i++)
      {
         if (pEntry->pDsDet)
            pEntry->pDsDet->Reset();
         pEntry++;
      }
   }

   // bPartial = -1; //Do not set, screwes up logic
   return rslt;
}

// Computes and fills in iUnits2 for all composite datattypes
// Returns number of FieldIDs required to represent all fields in pFldDes
// Only Array fields will cause this number to grow beyond iFlds.
// Assuming iUnits1 is set to number of fields in ADT's and ARRAYs, computes
// iUnits2 as total number of fields within that structure!
UINT32 ComputeMaxFieldIDs(UINT32 iFlds, pDSFLDDesc pFldDes, pUINT32 piCompressed)
{
   UINT32 iMaxFldId = 0;
   INT32 i;

   if (piCompressed) // In case the field-descriptors already has been expanded
      *piCompressed = iFlds;

   for (i = iFlds-1; i >= 0; i--)
   {
      if (pFldDes[i].iFldType == fldARRAY)
      {
         if (pFldDes[i].iUnits2 != 0)
         { // Assume it has already been expanded, adjust the compressed count
            if (piCompressed)
            {
               *piCompressed -= pFldDes[i].iUnits2;
               if (pFldDes[i].iUnits1)
                  *piCompressed += pFldDes[i].iUnits2/pFldDes[i].iUnits1;
               else
                  *piCompressed += 1;
            }
         }
         else
         {
            UINT32 iElementSize;
            if ((UINT32)i+1>=iFlds)
               return 0;
            if (pFldDes[i+1].iFldType == fldARRAY || pFldDes[i+1].iFldType ==
               fldADT /* || pFldDes[i+1].iFldType == fldTABLE */ )
            {
               iElementSize = pFldDes[i+1].iUnits2+1; // Computed value (+1 to include the pseudofield)
            }
            else
               iElementSize = 1;
            pFldDes[i].iUnits2 = pFldDes[i].iUnits1*iElementSize;
            iMaxFldId += pFldDes[i].iUnits2-iElementSize; // (-1 because first element has already been counted)
         }
      }
      else
      {
         // If iFldType == fldTABLE, iUnits1 contains ALL fields to follow
         // Check this : fldTABLE part of ADT -> ?
         // fldTABLE part of ARRAY -> not allowed
         if (pFldDes[i].iFldType == fldADT /* || pFldDes[i].iFldType == fldTABLE */ )
         { // Assume it has already been expanded, adjust the compressed count
            if (pFldDes[i].iUnits2 == 0)
            {
               UINT32 j;
               UINT32 iTotalElements = 0;
               UINT32 iElements = pFldDes[i].iUnits1;
               // Go forward to compute totalelement count
               for (j = i + 1; j < i + 1 + iElements; j++)
               {
                  if (pFldDes[j].iFldType == fldARRAY || pFldDes[j].iFldType == fldADT)
                  {
                     iTotalElements += pFldDes[j].iUnits2;
                  }
                  iTotalElements++; // Field itself
               }
               pFldDes[i].iUnits2 = iTotalElements;
            }
         }
      }
      iMaxFldId++;
   }
   return iMaxFldId;
}

// Create an array of field-descriptors given the user defined ones.
// In case of array datatypes, the array is 'expanded'
DBIResult MakeFldDescs(UINT32 iFlds, pDSFLDDesc pFldDes, pUINT32 piFlds, pDSFLDDesc *ppFldDes, pUINT32 piFldsCompressed)
{
   DBIResult rslt = DBIERR_NONE;
   pDSFLDDesc pFieldDesc = NULL;
   UINT32 iMaxFieldIDs = ComputeMaxFieldIDs(iFlds, pFldDes, piFldsCompressed);

   if (iMaxFieldIDs == 0)
   {
      rslt = DBIERR_INVALIDPARAM;
      goto Exit;
   }

   pFieldDesc = new DSFLDDesc[iMaxFieldIDs];
   if (pFieldDesc == NULL)
   {
      rslt = DBIERR_NOMEMORY;
      goto Exit;
   }
   if (iFlds == iMaxFieldIDs) // If arrays are already expanded, just copy!
   {
      CopyMem(pFieldDesc, pFldDes, iMaxFieldIDs*sizeof(DSFLDDesc));
   }
   else
   { // We need to construct fielddesc's for array-elements
      INT32 i, j;

      ZeroMem(pFieldDesc, iMaxFieldIDs*sizeof(DSFLDDesc));
      for (i = iFlds-1, j = iMaxFieldIDs-1; i >= 0 && j >= 0; i--, j--)
      {
         if (pFldDes[i].iFldType == fldARRAY)
         {
            UINT32 iElSize;
            if (pFldDes[i].iUnits1 == 0)
            {
               rslt = DBIERR_INVALIDPARAM; ;
               goto Exit;
            }

            iElSize = pFldDes[i].iUnits2/pFldDes[i].iUnits1;
            UINT32 iEl, jFix;

            j++;
            jFix = j;
            for (iEl = 0; iEl < pFldDes[i].iUnits1 -1; iEl++) // Copy elements 'arraysize times' -1
            {
               j -= iElSize;
               CopyMem(&pFieldDesc[j], &pFieldDesc[jFix], sizeof(DSFLDDesc)*iElSize);
            }
            j--;

            // Generate array names: the name of the first element becomes the name of
            // the array. The name of all the elements becomes: "[0]", "[1]" etc.
            // OR : the array-name is ignored and the element gets the index appended
            // (problem : might become too long to fit)
            // update: use array-name, ignore element name.
            // NOTE: this algorithme might not work with arrays of arrays, in which case we need to
            // go top-down instead of bottom-up.
            for (iEl = 0; iEl < pFldDes[i].iUnits1; iEl++)
            {
               CHAR szNum[10];
               CHAR szLongName[256];

               szNum[0] = '[';
               itoa((int)iEl, &szNum[1], 10);
               strcat(szNum, "]");
               LdStrCpy(szLongName, pFldDes[i].szName);
               if (LdStrLen(szLongName) + LdStrLen(szNum)+ 1 >= (int)sizeof(DBINAME))
               {
                  // Truncate the array-name
                  szLongName[sizeof(DBINAME) -1 - LdStrLen(szNum)] = 0;
                  // Or give an error
               }
               LdStrCat(szLongName, szNum);
               LdStrCpy(pFieldDesc[j +1 +iEl*iElSize].szName, szLongName);
            }
            // Copy the array-element itself
            CopyMem(&pFieldDesc[j], &pFldDes[i], sizeof(DSFLDDesc));
         }
         else
            CopyMem(&pFieldDesc[j], &pFldDes[i], sizeof(DSFLDDesc));
      }
   }

Exit:
   if (rslt)
   {
      if (pFieldDesc)
         delete[] pFieldDesc;
   }
   else
   {
      *piFlds = iMaxFieldIDs;
      *ppFldDes = pFieldDesc;
   }
   return rslt;
}

VOID VARList::Init(UINT32 iInitialSize, UINT32 iLen, UINT32 iDefInc)
{
   iLast = 0;
   iSize = 0;
   iEntryLen = 0;

   pEntries = NULL;
   iIds = 1;
   iEntryLen = iLen;
   this->iDefInc = iDefInc;
   if (iInitialSize)
      Grow(iInitialSize);
}

VARList::VARList(VOID)
{
   Init(0, 0, 1);
}

VARList::~VARList(VOID)
{
   if (pEntries)
      DsFree(pEntries);
   pEntries = NULL;
}

DBIResult DBIFN VARList::Grow(UINT32 iEntries)
{
   UINT32 iNewSize = iSize + iEntries;
   pBYTE pTmp;

   pTmp = (pBYTE)DsRealloc((pVOID)pEntries,
      iEntryLen * iSize, iEntryLen * iNewSize);
   if (!pTmp)
      return DBIERR_NOMEMORY;
   pEntries = pTmp;
   iSize = iNewSize;
   return DBIERR_NONE;
}

DBIResult DBIFN VARList::Add(pBYTE pEntry, pUINT32 piId)
{
   DBIResult rslt = DBIERR_NONE;
   pBYTE pDest;

   if (iLast >= iSize)
   {
      rslt = Grow(iDefInc);
      if (rslt)
         return rslt;
   }

   pDest = pEntries + iLast*iEntryLen;
   CopyMem(pDest, pEntry, iEntryLen);
   iLast++;
   if (piId)
      *piId = iLast;
   return rslt;
}

DBIResult DBIFN VARList::Drop(UINT32 iId)
{
   UNREFERENCED_PARAMETER(iId);
   return DBIERR_NONE;
}

VOID DBIFN VARList::Reset(VOID)
{
   iLast = 0;
}

pBYTE DBIFN VARList::GetEntry(UINT32 iId)
{
   if (iId > iLast || iId == 0 || pEntries == NULL)
      return NULL;

   return(pEntries + (iId-1)*iEntryLen);
}

LTABLEList::LTABLEList(DSBASE *pDs)
{
   Init(0, sizeof(LTABLEEntry), 1);
   this->pDs = pDs;
}

LTABLEList::~LTABLEList(VOID)
{
   UINT32 i;
   pLTABLEEntry pEntry = (pLTABLEEntry)pEntries;

   for (i = 0; i < iLast; i++)
   {
      if (pEntry->pDsDet)
      {
         // Remove links if possible
         pEntry->pDsDet->pDsParent = NULL;
         pEntry->pDsDet->Release();
      }
      if (pEntry->piRecNos)
         delete[] pEntry->piRecNos;
      pEntry++;
   }
}

DBIResult DBIFN LTABLEList::Link(DSBASE *pDsDet, UINT32 iFieldID_SetIDM, UINT32 iFieldID_SetIDD, pUINT32 pDetID)
{
   DBIResult rslt;
   LTABLEEntry Entry;
   // UINT32     i;

   ZeroMem(&Entry, sizeof(LTABLEEntry));
   Entry.pDsDet = pDsDet;
   Entry.iFieldID_SetIDM = iFieldID_SetIDM; // FieldID for field containing setIDs, in master table
   pDsDet->iFieldID_SetIDD = iFieldID_SetIDD;

   rslt = Add((pBYTE) &Entry, pDetID);
   return rslt;
}

DBIResult DBIFN LTABLEList::Link_Fields(DSBASE *pDsDet, UINT32 iFields, pUINT32 piFieldIDs_M, pUINT32 piFieldIDs_D,
   pUINT32 pDetID)
{
   DBIResult rslt = DBIERR_NONE;
   LTABLEEntry Entry;
   UINT32 i;
   pLTABLEEntry pEntry;

   if (*pDetID)
   { // Already exists
      pEntry = GetEntry(*pDetID);
   }
   else
   {
      ZeroMem(&Entry, sizeof(LTABLEEntry));
      pEntry = &Entry;
   }

   pEntry->pDsDet = pDsDet;

   pEntry->iFields = iFields;
   pDsDet->iLinkFields = iFields;
   for (i = 0; i < iFields; i++)
   {
      pEntry->iFieldIDM[i] = (UINT16)piFieldIDs_M[i];
      pDsDet->piLinkField[i] = (UINT16)piFieldIDs_D[i];
   }
   if (*pDetID == 0)
      rslt = Add((pBYTE) &Entry, pDetID);

   return rslt;
}

DSBASE * DBIFN LTABLEList::FindDs(UINT32 iFieldID)
{
   pLTABLEEntry pEntry = (pLTABLEEntry)pEntries;
   UINT32 i;

   UNREFERENCED_PARAMETER(iFieldID);
   for (i = 0; i < iLast; i++)
   {
      // if (pEntry->iFieldID == iFieldID)
      // return pEntry->pDsDet;
      pEntry++;
   }

   return NULL;
}

pLTABLEEntry DBIFN LTABLEList::GetEntry(UINT32 iID)
{
   if (iID-1 >= iLast)
      return NULL;
   return(pLTABLEEntry)pEntries + (iID-1);
}

pLTABLEEntry DBIFN LTABLEList::Find(UINT32 iFieldID)
{
   pLTABLEEntry pEntry = (pLTABLEEntry)pEntries;
   UINT32 i;

   for (i = 0; i < iLast; i++)
   {
      if (pEntry->iFieldID_SetIDM == iFieldID) // pEntry->iFieldIDM[0] == iFieldID && pEntry->iFields == 1)
         return pEntry;
      pEntry++;
   }

   return NULL;
}

UINT32 DBIFN LTABLEList::GetTotalFieldDesc(BOOL bCompressed)
{
   pLTABLEEntry pEntry = (pLTABLEEntry)pEntries;
   UINT32 i, j;
   UINT32 iFieldsTotal = 0;

   for (i = 0; i < iLast; i++)
   {
      if (pEntry->pDsDet)
      {
         iFieldsTotal += bCompressed? pEntry->pDsDet->iFieldsCompressed : pEntry->pDsDet->iFields;
         if (pEntry->pDsDet->iFieldID_SetIDD && !(pEntry->pDsDet->pDsLog && pEntry->pDsDet->pDsLog->iLast))
            iFieldsTotal--; // Do not count link_field
         for (j = 0; j<pEntry->pDsDet->iFields; j++)
            if (pEntry->pDsDet->pFieldDesc[j].bCalculated == 2 && !
               (pEntry->pDsDet->pFieldDesc[j].iFldAttr & fldAttrLINK))
               iFieldsTotal--; // do not include locally added calculated fields

         if (pEntry->pDsDet->pLinkedTables)
            iFieldsTotal += pEntry->pDsDet->pLinkedTables->GetTotalFieldDesc(bCompressed);
      }
      pEntry++;
   }
   return iFieldsTotal;
}

//
DBIResult DBIFN LTABLEList::AdjustFieldIDs(VOID)
{
   DBIResult rslt = DBIERR_NONE;
   pLTABLEEntry pEntry = (pLTABLEEntry)pEntries;
   UINT32 i, j;

   for (i = 0, j = iLast; i < pDs->iFields && j > 0; i++)
   {
      if (pDs->pFieldDesc[i].iFldType == fldTABLE)
      {
         pEntry->iFieldID_SetIDM = i+1; // Set master fieldID
         pDs->pFieldDesc[i].iUnits1 = (UINT16)pEntry->pDsDet->iFieldsCompressed;
         // Adjust, including calculated field(s)?
         j--;
         pEntry++;
      }
   }
   return rslt;
}

// Called after MakeFldDesc. Assumes expanded array-fielddesc. so that
// fieldID's are predictable, and that iUnits2 is computed.
// Creates Embedded tables, and adjusts iFields and pFieldDesc by
// removing the fielddescriptors for the embedded table.
DBIResult DBIFN ExtractEmbeddedTables(DSBASE *pDs, pUINT32 piFields, pUINT32 piFieldsCompressed, pDSFLDDesc pFieldDesc)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   DSBASE *pDsDet = NULL;
   UINT32 iFields = *piFields, iEmbeddedFields;
   UINT32 iFieldsCompressed = *piFieldsCompressed;
   for (i = 0; i < iFields; i++)
   {
      if (pFieldDesc[i].iFldType == fldTABLE && pFieldDesc[i].iUnits2)
      {
         // Create empty DS
         pDsDet = new DSBASE();
         if (pDsDet == NULL)
         {
            rslt = DBIERR_NOMEMORY;
            goto Exit;
         }
         pDsDet->AddRef();
         iEmbeddedFields = pFieldDesc[i].iUnits2;
         rslt = pDsDet->Create(iEmbeddedFields, &pFieldDesc[i+1], NULL);
         if (rslt)
            goto Exit;
         pDsDet->iXmlMode = pDs->iXmlMode;
         // Create link field, default order etc.
         rslt = InitEmbeddedTable(pDs, pDsDet, i+1);
         if (rslt)
            goto Exit;
         CopyMem(&pFieldDesc[i+1], &pFieldDesc[i+iEmbeddedFields+1], (iFields-iEmbeddedFields-i-1)*sizeof(DSFLDDesc));
         iFields -= iEmbeddedFields; // Adjust iFields
         iFieldsCompressed -= iEmbeddedFields;
         pFieldDesc[i].iUnits2 = 0; // !
      }
   }
Exit:
   if (rslt)
   {
      if (pDsDet)
         delete pDsDet;
   }
   *piFields = iFields;
   *piFieldsCompressed = iFieldsCompressed;
   return rslt;
}

DBIResult DBIFN DSBASE::MakeEmbedded(TDSBASE *pDsDetail, // Embed this ds in
   UINT32 iFieldsLink, pUINT32 piFieldsM, // Fields in Master
   pUINT32 piFieldsD, // Fields in Detail
   pCHAR pMasterFieldName, // Name of new link field in master, NULL if using default name
   pCHAR pDetailFieldName // Name of new link field in detail, NULL if using defaultname
   )
{
   DBIResult rslt = DBIERR_NONE;
   DSBASE *pDsDet = (DSBASE*)pDsDetail;
   DSFLDDesc FldDesc_SetID;
   UINT32 iFldIDM = 0, iFldIDD = 0;
   UINT32 iRecNoM;
   UINT32 i, iDetTotal = 0;
   DSIDX *pLinkIdx;
   DSIDXDesc LinkIdxDesc;
   pBYTE pRecBufDet = new BYTE[pDsDet->iRecordSize];

   if (pDsLog && pDsLog->iLast > 0)
   {
      rslt = DBIERR_NA;
      goto Exit;
   }

   if (piFieldsM && iFieldsLink == 1 && pFieldDesc[*piFieldsM -1].iFldType == fldTABLE)
   { // We already have a master linking field
      // Check that it is compatible with a UINT32 type
      iFldIDM = *piFieldsM;
      if (piFieldsD)
      {
         iFldIDD = *piFieldsD;
      }
      else
      {
         for (i = 0; i < pDsDet->iFields; i++)
         {
            if (pDsDet->pFieldDesc[i].iFldAttr & fldAttrLINK) // (Only ONE linkfield per table!)
            {
               iFldIDD = i+1;
               break;
            }
         }
      }
   }
   else
   { //
      ZeroMem(&FldDesc_SetID, sizeof(DSFLDDesc));
      if (pMasterFieldName)
         LdStrCpy(FldDesc_SetID.szName, pMasterFieldName);
      // else //Use tablename of detail
      // LdStrCpy(FldDesc_SetID.szName, pMasterFieldname);

      FldDesc_SetID.iFldType = fldTABLE; // Could make it 'unknown'
      // FldDesc_SetID.iFldAttr    = fldAttrHIDDEN | fldAttrLINK;
      FldDesc_SetID.iUnits1 = sizeof(UINT32);
      FldDesc_SetID.iFldLen = sizeof(UINT32);
      FldDesc_SetID.bCalculated = TRUE;
      rslt = AddField(&FldDesc_SetID);
      if (rslt)
         goto Exit;
      iFldIDM = iFields;
   }

   if (iFldIDD == 0)
   {
      ZeroMem(&FldDesc_SetID, sizeof(DSFLDDesc));
      if (pDetailFieldName)
         LdStrCpy(FldDesc_SetID.szName, pDetailFieldName);
      else
         LdStrCpy(FldDesc_SetID.szName, szLINK_FIELD);
      FldDesc_SetID.iFldType = fldUINT32; // Could make it 'unknown'
      FldDesc_SetID.iFldAttr = fldAttrHIDDEN | fldAttrLINK;
      FldDesc_SetID.iUnits1 = sizeof(UINT32);
      FldDesc_SetID.iFldLen = sizeof(UINT32);
      FldDesc_SetID.bCalculated = TRUE;
      rslt = pDsDet->AddField(&FldDesc_SetID);
      if (rslt)
         goto Exit;
      iFldIDD = pDsDet->iFields;
   }

   // Create Link index
   ZeroMem(&LinkIdxDesc, sizeof(DSIDXDesc));
   LinkIdxDesc.iFields = iFieldsLink;
   for (i = 0; i < iFieldsLink; i++)
   {
      LinkIdxDesc.iKeyFields[i] = piFieldsD[i];
   }
   LdStrCpy(LinkIdxDesc.szName, szLINK_INDEX);

   // It is okay if linkfields are a subset of the default index
   //TODO: Test whether this should be an if conditional as that might have been
   //      the intent of the code.  The change from if (pDsDet->FindEqIndex(&LinkIdxDesc, &pLinkIdx) != DBIERR_NONE);
   //      makes it more clear what the code has been doing since Delphi 7 or earlier.
   pDsDet->FindEqIndex(&LinkIdxDesc, &pLinkIdx);
   {
      pDSIDXDesc pDefIdxDesc = &pDsDet->pIdxDef->IdxDesc;
      UINT32 j;

      // Add default order to index to preserve order within details
      for (i = 0, j = LinkIdxDesc.iFields; i < pDefIdxDesc->iFields; i++, j++)
      {
         if (LinkIdxDesc.iFields < DBIMAXFLDSINKEY)
         {
            LinkIdxDesc.iKeyFields[j] = pDefIdxDesc->iKeyFields[i];
            LinkIdxDesc.bDescending[j] = pDefIdxDesc->bDescending[i];
            LinkIdxDesc.bCaseInsensitive[j] = pDefIdxDesc->bCaseInsensitive[i];
            LinkIdxDesc.iFields++;
         }
      }
      LinkIdxDesc.bUnique = pDefIdxDesc->bUnique;
      rslt = pDsDet->CreateIndex(&LinkIdxDesc);
      if (rslt)
         goto Exit;
      rslt = pDsDet->FindIndex(LinkIdxDesc.szName, &pLinkIdx);
      if (rslt)
         goto Exit;
   }

   // Initialize SetId column in master
   for (iRecNoM = 1; iRecNoM < this->iRecNoNext; iRecNoM++)
   {
      UINT32 i;
      pBYTE pFldBuf;
      BOOL bBlank;
      UINT32 iRecNoD;
      UINT32 iSeqNoFirst, iSeqNoLast;

      rslt = this->PutField(iRecNoM, iFldIDM, (pBYTE) &(this->iSetIDNext));
      if (rslt)
         goto Exit;
      // Initialize SetId column in detail
      for (i = 0; i < iFieldsLink; i++)
      { // Get all link fields in master
         GetFieldPtr(iRecNoM, piFieldsM[i], &pFldBuf, &bBlank);
         // This is werer we should put any conversions
         if (bBlank)
         { // Should we allow this?
            pDsDet->PutField(pRecBufDet, piFieldsD[i], NULL);
         }
         else
         {
            pDsDet->PutField(pRecBufDet, piFieldsD[i], pFldBuf);
         }
      }
      if (pLinkIdx->IdxFindKey(iFieldsLink, 0, pRecBufDet, TRUE, &iSeqNoFirst) == DBIERR_NONE)
      {
         iSeqNoLast = iSeqNoFirst+1;
         for (i = iSeqNoFirst+1; i < pDsDet->iRecNoNext; i++)
         {
            if (pLinkIdx->IdxComp(pRecBufDet, iFieldsLink, 0, i) == 0)
               iSeqNoLast++;
            else
               break;
         }
         for (i = iSeqNoFirst; i < iSeqNoLast; i++)
         {
            iDetTotal++; // Counts number
            iRecNoD = pLinkIdx->IdxSeqNoToRecNo(i);
            rslt = pDsDet->PutField(iRecNoD, iFldIDD, (pBYTE) &(this->iSetIDNext));
            if (rslt)
               goto Exit;
         }
      }
      this->iSetIDNext++;
   }

   if (iDetTotal < pDsDet->iRecNoNext-1)
   {
      // Orphans ?
      // Insert an empty record in master in order to hold orphaned details ?
   }

   rslt = InitEmbeddedTable(this, pDsDet, iFldIDM);
   if (rslt)
      goto Exit;

   rslt = pLinkedTables->Link_Fields(pDsDet, iFieldsLink, piFieldsM, piFieldsD, &pDsDet->iDetID);
   if (rslt)
      goto Exit;

   for (i = 0; i < iFieldsLink; i++)
   {
      // remove me.
   }

Exit:
   if (pRecBufDet)
      delete pRecBufDet;
   return rslt;
}

#ifdef DEBUG

VOID EnterFunc(VOID)
{
   static INT32 iFuncEntryCnt = 0;

   iFuncEntryCnt++;
}

VOID LeaveFunc(VOID)
{
   static INT32 iFuncLeaveCnt = 0;

   iFuncLeaveCnt++;
}

VOID IEnterFunc(VOID)
{
   static INT32 iIFuncEntryCnt = 0;

   iIFuncEntryCnt++;
}

VOID ILeaveFunc(VOID)
{
   static INT32 iIFuncLeaveCnt = 0;

   iIFuncLeaveCnt++;
}

#endif

DBIResult DBIFN DSBASE::Unused1(VOID)
{
   return DBIERR_NA;
}

DBIResult DBIFN DSBASE::Unused2(VOID)
{
   return DBIERR_NA;
}

DBIResult DBIFN DSBASE::Unused3(VOID)
{
   return DBIERR_NA;
}

DBIResult DBIFN DSBASE::GetEmbeddedDS(UINT32 iFieldID, // FieldID of embedded table (0 : get the first one)
   TDSBASE **ppDsDet // Returns the ds of the embedded table
   )
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   DSBASE *pDsDet = NULL;

   LOCK();
   if (iFieldID == 0)
   {
      for (i = 0; i < iFields; i++)
      {
         if (pFieldDesc[i].iFldType == fldTABLE)
         {
            iFieldID = i+1;
            break;
         }
      }
   }
   if (pFieldDesc[iFieldID-1].iFldType != fldTABLE)
      goto Exit;
   if (pLinkedTables)
   {
      pLTABLEEntry pEntry = pLinkedTables->Find(iFieldID);
      if (pEntry)
      {
         pDsDet = pEntry->pDsDet;
      }
   }

Exit:
   UNLOCK();
   if (pDsDet)
   {
      if (ppDsDet)
      {
         pDsDet->AddRef();
         *ppDsDet = (TDSBASE*)pDsDet;
      }
   }
   else
      rslt = DBIERR_NA;
   return rslt;
}

VARStrList::VARStrList(VOID)
{
   Init(0, 1, 512);
   iStrings = 0;
}

VARStrList::~VARStrList(VOID)
{
}

pCHAR DBIFN VARStrList::GetStrPtr( // Returns pointer to Entry
   UINT32 iId)
{
   if (pEntries)
      return(pCHAR)(pEntries + iId);
   return NULL;
}

DBIResult DBIFN VARStrList::AddStr( // Add entry
   pCHAR pStr, pUINT32 piId)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iStrLen;
   pCHAR pPtr;

   iStrLen = LdStrLen(pStr) +1;

Again:
   if (iLast + iStrLen >= iSize)
   {
      rslt = Grow(iDefInc);
      if (rslt)
         return rslt;
      goto Again;
   }
   pPtr = GetStrPtr(iLast);
   CopyMem(pPtr, pStr, iStrLen); // Copies one 0 at end

   if (piId)
      *piId = iLast;
   iLast += iStrLen+1;
   iStrings++;
   return rslt;
}

DBIResult DBIFN DSBASE::Clone(UINT32 iPType, // 0:ordinary, 1:delta-packet, 2:error-packet, 4:request-packet
   BOOL bRecurse, // TRUE:create complete tree-structure
   BOOL bCloneOptParams, // TRUE:clone all optional parameters
   class TDSBASE **ppDsClone)
{
   DBIResult rslt = DBIERR_NONE;
   DBINAME szNameClone;
   DSBASE *pDsClone;
   UINT32 i;
   UINT32 iFieldsClone = iFields;
   pDSFLDDesc pFieldDescClone = pFieldDesc;
   BOOL bAllocated = FALSE;
   UINT32 iFldBegin = 0;

   if (pszName)
   {
      LdStrCpy(szNameClone, pszName);
   }
   else
      szNameClone[0] = 0;

   if (iPType == dsPACKET_DELTA) // Delta
   {
      if (LdStrLen(pszName) + LdStrLen(szDELTA) < (int)sizeof(DBINAME))
         LdStrCat(szNameClone, szDELTA);
   }
   pDsClone = new DSBASE();
   if (pDsClone == NULL)
   {
      rslt = DBIERR_NA;
      goto Exit;
   }
   pDsClone->AddRef();

   if (iPType == dsPACKET_ERROR) // Error-packet
   {
      pDSFLDDesc pFldDes;

      iFieldsClone += ERRORPACKETExtraFields;
      pFieldDescClone = new DSFLDDesc[iFieldsClone];
      if (pFieldDescClone == NULL)
      {
         rslt = DBIERR_NOMEMORY;
         goto Exit;
      }
      bAllocated = TRUE;
      ZeroMem(pFieldDescClone, sizeof(DSFLDDesc)*iFieldsClone);
      pFldDes = pFieldDescClone;
      // Set the first field for the record number.
      LdStrCpy((pCHAR)pFldDes->szName, szdsERRRECORDNO);
      pFldDes->iFldType = fldUINT32;
      pFldDes->iFldLen = sizeof(UINT32);
      pFldDes++;
      // Set the second field for the error response.
      LdStrCpy((pCHAR)pFldDes->szName, szdsERRRESPONSE);
      pFldDes->iFldType = fldUINT32;
      pFldDes->iFldLen = sizeof(UINT32);
      pFldDes++;

      // Set the third field for the error string.
      LdStrCpy((pCHAR)pFldDes->szName, szdsERRMESSAGE);
      pFldDes->iFldType = fldZSTRING;
      pFldDes->iUnits1 = 255; // Increased on request.. DBIMAXMSGLEN;
      pFldDes++;

      // Set the fourth field for the error context.
      LdStrCpy((pCHAR)pFldDes->szName, szdsERRCONTEXT);
      pFldDes->iFldType = fldZSTRING;
      pFldDes->iUnits1 = DBIMAXMSGLEN;
      pFldDes++;

      // Set the fifth field for the error category.
      LdStrCpy((pCHAR)pFldDes->szName, szdsERRCATEGORY);
      pFldDes->iFldType = fldUINT32;
      pFldDes->iFldLen = sizeof(UINT32);
      pFldDes++;

      // Set the sixth field for the error code.
      LdStrCpy((pCHAR)pFldDes->szName, szdsERRCODE);
      pFldDes->iFldType = fldUINT32;
      pFldDes->iFldLen = sizeof(UINT32);
      pFldDes++;
      // Move over the rest..
      memmove((pFldDes), pFieldDesc, iFields*sizeof(DSFLDDesc));

      for (i = 0; i < iFieldsClone; i++)
      {
         pFieldDescClone[i].iFldAttr &=~(fldAttrREQUIRED | fldAttrREADONLY);
      }
   }

   // Clear ReadOnly bit for a request packet
   if (iPType == dsPACKET_REQUEST) // Request-packet
   {
      for (i = 0; i < iFieldsClone; i++)
      {
         pFieldDescClone[i].iFldAttr &=~fldAttrREADONLY;
      }
   }

   rslt = pDsClone->Create(iFieldsClone, pFieldDescClone, szNameClone);
   if (rslt)
      goto Exit;

   // if (this->iXmlMode)
   pDsClone->iXmlMode = this->iXmlMode;

   if (iPType == dsPACKET_ERROR) // Errorpacket
   {
      pDsClone->SetProp(dspropLOGCHANGES, TRUE);
      pDsClone->SetProp(dspropAUTOINC_DISABLED, TRUE); // Disable autoinc, if any
      iFldBegin = 6; // Offset to beginning of first field
   }

   if (iPType == dsPACKET_DELTA)
   {
      UINT32 iValue, iPCKLType;
      // Add optional parameters
      iValue = 1; // TRUE
      iPCKLType = dsfldUINT << dsSizeBitsLen;
      iPCKLType |= sizeof(UINT32);
      pDsClone->AddOptParameter(0, szDATASET_DELTA, iPCKLType, sizeof(UINT32), (pBYTE) &iValue);
   }

   if (iPType == dsPACKET_NORMAL)
   {
      // Add default-order.
      // Add Unique-order
      // Add M_D-linkingfields
   }

   if (bCloneOptParams && pDsOptParams && iPType != dsPACKET_ERROR)
   {
      for (i = 0; i < pDsOptParams->iLast; i++)
      {
         pOPTPARAMEntry pEntry = &pDsOptParams->pEntries[i];

         if (pEntry->iPacketTypes & iPType)
         {
            // FldNo is not nesc.
            rslt = pDsClone->AddOptParameter(pEntry->iFldNo +iFldBegin, pEntry->pAttr, pEntry->iType, pEntry->iLen,
               pEntry->pValue);
            if (rslt)
               break;
         }
      }
   }

   if (bRecurse && pLinkedTables)
   {
      for (i = 0; i < pLinkedTables->iLast; i++)
      {
         DSBASE *pDsDet = NULL;
         DSBASE *pDsDetClone = NULL;
         pLTABLEEntry pEntry = pLinkedTables->GetEntry(i+1);

         pDsDet = pEntry->pDsDet;
         rslt = pDsDet->Clone(iPType, TRUE, bCloneOptParams, (TDSBASE**) &pDsDetClone);
         if (rslt)
            goto Exit;
         rslt = InitEmbeddedTable(pDsClone, pDsDetClone, pEntry->iFieldID_SetIDM + iFldBegin);
         if (rslt)
         {
            delete pDsDetClone;
            goto Exit;
         }
         // Inherit links

         if (iPType == dsPACKET_ERROR || iPType == dsPACKET_REQUEST) // Errorpacket
            continue;

         // Inherit MD_links, if any
         if (pEntry->iFields> 0)
         {
            UINT32 j;
            UINT32 piM[16], piD[16];
            for (j = 0; j < pEntry->iFields; j++)
            {
               piM[j] = (UINT32)pEntry->iFieldIDM[j];
               piD[j] = (UINT32)pDsDet->piLinkField[j];
            }
            rslt = pDsClone->pLinkedTables->Link_Fields
               (pDsDetClone, pDsDet->iLinkFields, piM, piD, &pDsDetClone->iDetID);
            if (rslt)
               goto Exit;
         }
      }
   }

   if (ppDsClone)
      *ppDsClone = pDsClone;

Exit:
   if (rslt)
   {
      if (pDsClone && !pDsClone->pDsParent) // (delete from the top to avoid problems!
      {
         delete pDsClone;
      }
   }
   if (bAllocated)
      delete pFieldDescClone;
   return rslt;
}

// Given detail record, find its corresponding master record.
// Creates index on master-linking -fields if nescessary
DBIResult DBIFN LTABLEList::GetNewMasterForDetail(UINT32 iDetID, pBYTE pRecBufD, pUINT32 piRecNo, pUINT32 piSetID)
{
   DBIResult rslt = DBIERR_NONE;
   pLTABLEEntry pEntry;
   pDSIDX pIdx = NULL;
   DSBASE *pDsDet = NULL;
   pBYTE pRecBufM = NULL;
   pBYTE pFldBuf;
   UINT32 i, iFldNoM, iFldNoD, iPos, iRecNoM;
   BOOL bBlank;

   rslt = GetMasterLinkIndex(iDetID, TRUE, TRUE, &pIdx);
   if (rslt || pIdx == NULL)
      goto Exit;
   rslt = GetByteBuffer(pDs->iRecordSize, &pRecBufM, TRUE);
   pEntry = GetEntry(iDetID);
   pDsDet = pEntry->pDsDet;
   // Extract linkfield from detail, create key for master
   for (i = 0; i < pDsDet->iLinkFields; i++)
   {
      iFldNoD = pDsDet->piLinkField[i];
      iFldNoM = pEntry->iFieldIDM[i];
      pDsDet->GetFieldPtrB(pRecBufD, iFldNoD, &pFldBuf, &bBlank);
      if (bBlank)
         pDs->PutBlank(pRecBufM, 0, iFldNoM, bBlank);
      else
         pDs->PutField(pRecBufM, iFldNoM, pFldBuf);
   }
   rslt = pIdx->IdxFindKey(pEntry->iFields, 0, pRecBufM, TRUE, &iPos);
   if (rslt)
      goto Exit;

   iRecNoM = pIdx->IdxSeqNoToRecNo(iPos);
   if (piRecNo)
      *piRecNo = iRecNoM;
   if (piSetID)
   {
      rslt = pDs->GetField(iRecNoM, pEntry->iFieldID_SetIDM, (pBYTE)piSetID, &bBlank);
      if (bBlank)
         *piSetID = 0;
   }

Exit:
   if (pRecBufM)
      delete pRecBufM;
   return rslt;
}

// Creates a master/link index on linking fields.
// Reuses an iexising index, if available
// This is used for :
// -cheking uniqueness when inserting a master record
// -finding new master record on a detail fly-away
DBIResult DBIFN LTABLEList::GetMasterLinkIndex(UINT32 iDetID, BOOL bCreate, BOOL bUnique, pDSIDX *ppIdx)
{
   DBIResult rslt = DBIERR_NONE;
   pLTABLEEntry pEntry;
   pDSIDX pIdx = NULL;
   DSIDXDesc IdxDesc;
   UINT32 i;

   pEntry = GetEntry(iDetID);
   if (pEntry == NULL || pEntry->iFields == 0)
   {
      rslt = DBIERR_NOSUCHINDEX;
      goto Exit;
   }
   if (*pEntry->szIdxName != 0)
   {
      rslt = pDs->FindIndex(pEntry->szIdxName, &pIdx);
      if (!rslt && pIdx)
         goto Exit;
   }
   // First, try to find equivalent index
   ZeroMem(&IdxDesc, sizeof(DSIDXDesc));
   IdxDesc.iFields = pEntry->iFields;
   for (i = 0; i < pEntry->iFields; i++)
   {
      IdxDesc.iKeyFields[i] = pEntry->iFieldIDM[i];
   }
   IdxDesc.bUnique = bUnique;
   rslt = pDs->FindEqIndex(&IdxDesc, &pIdx);
   if (!rslt && pIdx)
   { // If found, store the name
      LdStrCpy(&pEntry->szIdxName, pIdx->IdxDesc.szName);
      goto Exit;
   }

   // Then try to create one
   if (bCreate)
   {
      if (pEntry->szIdxName && pEntry->szIdxName[0])
         LdStrCpy(IdxDesc.szName, pEntry->szIdxName);
      else
      { // Generate name
         DBINAME szName;

         LdStrCpy(szName, szLINK_INDEX);
         LdStrCat(szName, "_");
         if (pEntry->pDsDet->pszName)
            LdStrCat(szName, pEntry->pDsDet->pszName);
         else
         {
            CHAR szNum[10];

            LdStrCat(szName, "DETAIL");
            itoa((int)iDetID, &szNum[0], 10);
            LdStrCat(szName, szNum);
         }
         LdStrCpy(IdxDesc.szName, szName);
      }
      pDs->bIgnSetIDInIdx++; // Set to TRUE
      rslt = pDs->CreateIndex(&IdxDesc);
      pDs->bIgnSetIDInIdx--; // Restore value
      if (rslt == DBIERR_NONE)
      {
         LdStrCpy(&pEntry->szIdxName, IdxDesc.szName);
         rslt = pDs->FindIndex(pEntry->szIdxName, &pIdx);
         if (pIdx)
            pIdx->bGlobal = TRUE; //
      }
   }
Exit:
   if (ppIdx)
      *ppIdx = pIdx;
   return rslt;
}

DBIResult DBIFN DSBASE::GlobalLogUndo(UINT32 iDetID, UINT32 iCntD // 0: last. Relates to 'iCnt'th last detail upd to this detail!
   )
{
   DBIResult rslt = DBIERR_NONE;
   INT32 i;
   UINT32 iCntM = 0;

   for (i = pDsLog->iLast -1; i >= 0; i--)
   {
      if (pDsLog->pLogEntries[i].iAttr == dsDetUpd && pDsLog->pLogEntries[i].iRecNo2 == iDetID)
      { // Found entry for this detail-table
         if (iCntM++ == iCntD)
         { // This is it
            // UINT32 iCntMM = pDsLog->iLast - i;
            pDsLog->RemoveEntry(i); // Recurses, if nesc.
            // if (pDsParent)
            // { //Propagate it backw
            // rslt = pDsParent->GlobalLogUndo(iDetID, iCntMM);
            // }
            break;
         }
      }
   }
   return rslt;
}

Fields_List::Fields_List(UINT32 iCols)
{
   Init(iCols, sizeof(DSFLDDesc), 10);
}

Fields_List::~Fields_List()
{
}

UINT32 DBIFN Fields_List::Columns(VOID)
{
   return iLast;
}

// NOTE: 1-based!
pDSFLDDesc DBIFN Fields_List::GetFldDesc(UINT32 i)
{
   return(pDSFLDDesc)GetEntry(i);
}
