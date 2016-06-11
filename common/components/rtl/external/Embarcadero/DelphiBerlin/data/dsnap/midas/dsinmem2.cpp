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


DBIResult MakeBDEFldDesc(DSDATAPACKETFLDDesc *pPDes, pDSFLDDesc pFldDes);
DBIResult MakePcklFldDesc(DSDATAPACKETFLDDesc *pPDes, pDSFLDDesc pFldDes);
DBIResult MakeBDEType(UINT32 iFieldType, pUINT32 piBDEType, pUINT32 piSize);
DBIResult MakePCKLType(UINT32 iBDEFldType, UINT32 iFldLen, UINT32 iUnits1, pINT piPCKLFldType);
DBIResult MakeIntArray(UINT32 iCnt, pBYTE pElements, pUINT32 piType, pUINT32 piLen, pBYTE pBuf);
DBIResult AddOptParams(DSOPTPARAM *pDsOptParams, DSDATAPACKET *pPi, UINT32 iFldNo, pUINT32 piAdded);
DBIResult AddFldOptParams(pDSFLDDesc pFldDesc, DSDATAPACKET *pPi);

DBIResult MakeFldDescs(UINT32 iFlds, pDSFLDDesc pFldDes, pUINT32 piFlds, pDSFLDDesc *ppFldDes,
   pUINT32 piFldsCompressed);
UINT32 ComputeMaxFieldIDs(UINT32 iFlds, pDSFLDDesc pFldDes, pUINT32 piCompressed);

DBIResult DBIFN MakeEmptyDatapacket(DSBASE *pDs, DSDATAPACKET **ppPi, BOOL bDontInclMetaData);
DBIResult DBIFN AddChangeIndex(pDSBASE pDs, BOOL bWalkTree);
DBIResult SetDelta(DSBASE *pDs, BOOL bVal);

// from dsidx.cpp
DBIResult DBIFN ReorderIndexes(DSBASE *pDs, BOOL bTreewalk);

DBIResult DBIFN ReadFieldDescs(
   DSBASE *pDs,
   DSEXTRACT *pUP,
   UINT32 iFieldsDP, // Extract the next 'iFlds' fields
   pUINT32 piFields, //
   pUINT32 piFieldsCompressed, //
   pDSFLDDesc *ppFieldDesc //
);

DBIResult DBIFN ReadOptionalParameters(
   DSBASE *pDs,
   DSEXTRACT *pUP,
   UINT32 iFldID, // 0:main table
   pDSFLDDesc pFldDesc // If standard options, add them here
);

DBIResult DBIFN ReadRows(DSBASE *pDs, DSEXTRACT *pUP, UINT32 iRecordsToRead, UINT32 iSetID, // if detail
   BOOL bAppend, pUINT32 piVisibleRecords);

DBIResult DBIFN ReadMetaData(DSBASE *pDs, DSEXTRACT *pUP, UINT32 iFieldsDP);

DBIResult DBIFN CreateEmbeddedTable(DSBASE *pDs, DSEXTRACT *pUP, UINT32 iFieldIdDP, pDSFLDDesc pFieldDescDP);

DBIResult DBIFN InitEmbeddedTable(DSBASE * pDs, DSBASE * pDsDet, UINT32 iFieldIDM // Master fieldID
);

DBIResult DBIFN GetRowCountForSetID(pLTABLEEntry pLEntry, BOOL bRemUnused, UINT32 iSetID, pUINT piCnt,
   pUINT32 *ppiRecNos);

// From dsidx.cpp
DBIResult DBIFN AddSetIDToIndexes(
   DSBASE *pDs,
   UINT32 iFldID, // FieldID of field to include in indexes
   pDSIDX pIdx, // If NULL, all indexes, otherwise just this one
   BOOL bAdd); // TRUE: add, otherwise remove

DBIResult DBIFN StreamFieldDescs(DSBASE *pDs, DSDATAPACKET *pPi);
DBIResult DBIFN StreamOptionalParameters(DSBASE *pDs, DSDATAPACKET *pPi);
DBIResult DBIFN StreamRows(DSBASE *pDs, DSDATAPACKET *pPi, UINT32 iRecsToStream, UINT32 iSetIDDet, BOOL bRemUnused,
   pUINT32 piRecNos);

DBIResult DBIFN GetPrevId(DSBASE *pDs, UINT32 iRowNo, UINT32 iFieldID, pUINT32 piBlobIdPrev, pBOOL pbBlankPrev);

// From dsopt2.cpp
DBIResult DBIFN AdjFldOptParams(DSBASE * pDs);

// From Ds.cpp
VOID CompressFldDescs(pUINT32 pi, pDSFLDDesc pFldDes, pUINT32 pj, pDSFLDDesc pFldDesC, UINT32 iFields);

DBIResult CheckPickle(SAFEARRAY *pPickle);



// Create in-mem version of dataset, given pickle
DBIResult DBIFN DSBASE::MakeInMem(SAFEARRAY *pPickle)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iFieldsDP; // Number of fielddescs in datapacket
   // UINT32           iCnt;
   // UINT32           i;  // iRowNo;
   DSEXTRACT *pUP = NULL;
   BOOL bAllocatedExtract = FALSE;

   // Version control
   rslt = CheckPickle(pPickle);
   if (rslt)
      goto Exit;

   // if (pDsExtract)
   // {
   // delete pDsExtract;
   // pDsExtract = NULL;
   // }
   if (pDsExtract == NULL)
   {
      if (bPartial != -1)
         return DBIERR_NA;
      pDsExtract = new DSEXTRACT();
      if (pDsExtract == NULL)
         return DBIERR_NOMEMORY;
      bAllocatedExtract = TRUE;
      bPartial = TRUE;
      pDsExtract->SetMETADATAMode(bUTF8METADATA);
      pDsExtract->SetANSICodePage(iANSICodePage);
      rslt = pDsExtract->Init(pPickle);
      if (rslt)
         goto Exit;

   }

   pUP = pDsExtract;

   // Check that pickle does contain meta-info
   if (!(pUP->iProperties & pcklpropsMETADATA_INCL))
   { // MUST contain meta-data!
      rslt = DBIERR_NOMETADATA; // Pickle
      goto Exit;
   }

#ifdef MIDAS_DLL
   iXmlMode = pUP->GetXMLMode(); // Should be stored by setting ?
   if (iXmlMode)
      iXmlMode = 5;
#endif

   // Get field info
   iFieldsDP = pUP->iColumns; // Number of fielddesc. The number of fields might be different.
   rslt = ReadMetaData(pUP, iFieldsDP); // read fielddesc. and optional parameters
   if (rslt)
      goto Exit;

   // Get actual data
   // iRecNoNext     = pUP->iRows +1;
   rslt = ReadRows(this, pUP, pUP->iRows, 0, FALSE, &iRecords); // Returns number of 'visible' records
   if (rslt)
      goto Exit;

   // if (bDelta && pIdxDef) //XML, movde inside reorderindexes to do the same on the detials!
   // {
   // pIdxDef->IdxDesc.iFields=0;
   // }
   rslt = ReorderIndexes(this, TRUE);
   if (rslt)
      goto Exit;

   rslt = AddChangeIndex(this, TRUE);

Exit:
   // delete  pUP;   // remove object again
   if (rslt)
   {
      delete pFieldDesc;
      pFieldDesc = NULL;
      if (bAllocatedExtract)
      {
         delete pDsExtract;
         pDsExtract = NULL;
         bPartial = -1;
      }
   }
   return rslt;
}

DBIResult DBIFN DSBASE::ReadMetaData(DSEXTRACT *pUP, UINT32 iFieldsDP)
{
   DBIResult rslt = DBIERR_NONE;

   rslt = ReadFieldDescs(this, pUP, iFieldsDP, &iFields, &iFieldsCompressed, &pFieldDesc);
   if (rslt)
      goto Exit;

   rslt = InitializeFields(); // Fill out remaining info
   if (rslt)
      goto Exit;
   if (pLinkedTables)
   {
      pLinkedTables->AdjustFieldIDs(); // Not known until know!
   }
   iFieldsDataPacket = iFields;

   // Create default order
   if (pIdxDef == NULL)
   {
      DSIDXDesc DefIdxDesc;

      ZeroMem(&DefIdxDesc, sizeof(DSIDXDesc));
      LdStrCpy(DefIdxDesc.szName, szDEFAULT_ORDER);
      rslt = CreateIndex(&DefIdxDesc);
      if (rslt == DBIERR_NONE)
         FindIndex(szDEFAULT_ORDER, &pIdxDef);
   }

   rslt = ReadOptionalParameters(this, pUP, 0, NULL);
   if (rslt)
      goto Exit;

   rslt = AdjFldOptParams(this);
   if (bDelta && pDsParent == NULL)
   {
      SetDelta(this, bDelta);
   }

Exit:
   return rslt;
}

DBIResult DBIFN ReadFieldDescs(DSBASE *pDs, DSEXTRACT *pUP, UINT32 iFieldsDP, // Extract the next 'iFlds' fields
   pUINT32 piFields, //
   pUINT32 piFieldsCompressed, //
   pDSFLDDesc *ppFieldDesc //
   )
{
   DBIResult rslt = DBIERR_NONE;
   DSDATAPACKETFLDDesc PcklFieldDesc;
   DSFLDDesc DsFldDesc;
   UINT32 iFieldIdDP; // This is the fieldno in datapacket, ignoring embedde tables,
                      // but expecting compressed arrays

   Fields_List *pFields_List = new Fields_List(iFieldsDP);

   // Convert flddescs from pickle format to BDE format
   iFieldIdDP = 0;

   while ((rslt = pUP->GetColumnDesc(&PcklFieldDesc)) == DBIERR_NONE)
   { // (field 1 in pPckl is attribute (ignore)
      iFieldIdDP++;
      MakeBDEFldDesc(&PcklFieldDesc, &DsFldDesc);
      // Get field attributes
      rslt = ReadOptionalParameters(pDs, pUP, iFieldIdDP, &DsFldDesc);
      if (rslt)
         goto Exit;
      if (DsFldDesc.iFldType == fldTABLE)
      {
         rslt = CreateEmbeddedTable(pDs, pUP, iFieldIdDP, &DsFldDesc);
         if (rslt)
            goto Exit;
         DsFldDesc.iUnits1 = 1;
      }
      pFields_List->Add((pBYTE) &DsFldDesc, NULL);
   }

   if (rslt && rslt != DBIERR_EOF)
      goto Exit;
   if (iFieldIdDP == 0)
   { // bMetaDataDone is TRUE?
      rslt = DBIERR_DATAPACKETMISMATCH;
      goto Exit;
   }

   // Expand fielddescs
   rslt = MakeFldDescs(iFieldIdDP, pFields_List->GetFldDesc(1), piFields, ppFieldDesc, NULL);
   if (rslt)
      goto Exit;
   *piFieldsCompressed = iFieldIdDP;

Exit:
   if (pFields_List)
      delete pFields_List;
   return rslt;
}

DBIResult DBIFN ReadOptionalParameters(DSBASE *pDs, DSEXTRACT *pUP, UINT32 iFldID, // 0:main table
   pDSFLDDesc pFldDesc // If standard options, add them here
   )
{
   DBIResult rslt = DBIERR_NONE;
   CHAR szAttr[DSMAXATTRNAMELEN+1];
   UINT32 iType;
   BYTE Buf[128];
   UINT32 iBufSize = 0;
   pBYTE pBuf = NULL;
   pBYTE pBufPtr;
   UINT32 iAttrLen;

   // Get optional parameters
   while (pUP->GetAttributeLength(&iAttrLen) == 0)
   {
      if (iAttrLen)
      {
         if (iAttrLen < sizeof(Buf))
            pBufPtr = Buf;
         else
         {
            if (iAttrLen > iBufSize)
            {
               pBuf = (pBYTE)DsRealloc((pVOID)pBuf, iBufSize, iAttrLen);
               if (pBuf == NULL)
               {
                  rslt = DBIERR_NOMEMORY;
                  break;
               }
               iBufSize = iAttrLen;
            }
            pBufPtr = pBuf;
         }
         pUP->GetNextAttribute(szAttr, &iType, &iAttrLen, pBufPtr);
         if (iFldID)
            rslt = pDs->AddFldOptParameter(iFldID, szAttr, iType, iAttrLen, pBufPtr, pFldDesc);
         else
            rslt = pDs->AddOptParameter(0, szAttr, iType, iAttrLen, pBufPtr);
         if (rslt)
            break;
      }
   } // End while
   if (pBuf)
      DsFree(pBuf);
   return rslt;
}

DBIResult DBIFN ReadRows(DSBASE *pDs, DSEXTRACT *pUP, UINT32 iRecordsToRead, UINT32 iSetID, BOOL bAppend,
   // If appending partial packets
   pUINT32 piVisibleRecords // Returns number of 'visible' records read
   )
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i, iFieldID, iRowNo;
   UINT32 iFields = pDs->iFields;
   BOOL bDelta = pDs->bDelta;
   UINT32 iRecords;
   BYTE Buf[128];
   UINT32 iBufSize = 0;
   pBYTE pBuf = NULL;
   pBYTE pBlob;
   UINT32 iRowOffs = pDs->iRecNoNext-1;
   UINT32 iFldLink = 0; // FieldID of detail link (contains SetIDs, or recordnumbers)
   BOOL bDisableLogSave = pDs->bDisableLog;
   UINT32 iXmlModeRead = pUP->GetXMLMode();
   pBYTE pValue = pDs->pFldBufScratch;
   UINT32 iMaxValueLen = pDs->iFldBufScratchLen;
   BOOL bPrevIdSpecialCase;
   if (bAppend)
      pDs->bDisableLog = TRUE;

   if (iRecordsToRead >= (UINT32)(dsDELAYEDBIT -1)) // Unknown
   {
      rslt = pDs->GrowRows(100, iRowOffs + 100); // Make Space
   }
   else
      rslt = pDs->GrowRows(iRecordsToRead + 25, iRowOffs + iRecordsToRead +25); // Make Space
   if (rslt)
      goto Exit;

   if (iSetID) //
   { // Find linking field, if any
      iFldLink = pDs->iFieldID_SetIDD;
   }

   // Get all records
   iRecords = 0; // Count 'visible' records
   for (i = 1; i <= iRecordsToRead; i++)
   {
      DSAttr iAttr;
      UINT32 iVal;
      UINT32 iLen = sizeof(iVal);
      BOOL bVisible;
      UINT32 iMoveToRecNo = 0;

      iRowNo = pDs->iRecNoNext; // Get next row with same SetID
      bPrevIdSpecialCase = FALSE;

      // Get attribute
      rslt = pUP->GetField(&iLen, (pBYTE) &iVal, NULL);
      if (rslt)
      {
         if (rslt != DBIERR_EOF)
            goto Exit;
         rslt = DBIERR_NONE;
         goto Eof;
      }
      iAttr = (DSAttr)iVal;
      bVisible = bDelta || !(iAttr & dsISNOTVISIBLE);
      if (bVisible)
         iRecords++;
      // Put attribute
      rslt = pDs->PutField(iRowNo, FIELD_ATTR, (pBYTE) &iAttr);
      // Fields:
      if (rslt)
         goto Exit;

      // Get all fields
      for (iFieldID = 1; iFieldID <= iFields; iFieldID++)
      {
         BOOL bBlank;
         pDSFLDDesc pFldDesc = &pDs->pFieldDesc[iFieldID-1];
         UINT32 iFldType = pFldDesc->iFldType;

         if (iFieldID == iFldLink)
         { // Put the setid here
            iLen = sizeof(UINT32);
            if (iFieldID <= pDs->iFieldsDataPacket)
            {
               rslt = pUP->GetField(&iLen, pValue, &bBlank);
               if (rslt)
               {
                  goto Exit;
               }
               if (!bAppend && pDs->pDsLog && pDs->pDsLog->iLast)
               { // Only when reading whole datapacket
                  iMoveToRecNo = *(pUINT32)pValue;
               }
            }
            // Ignore the value, and blank value.
            bBlank = FALSE;
            *(pUINT32)pValue = iSetID;
            goto PutFld;
         }
         // This test must come after
         if (iFieldID > pDs->iFieldsDataPacket)
         {
            // Calculated fields ? Do not read from pickle
            continue;
         }

         switch(iFldType)
         {
         case fldTABLE:
            {
               UINT32 iLen = iMaxValueLen;
               pUP->GetField(&iLen, pValue, &bBlank); // Don't test for errors here! (gets FIELDISBLANK)
               if (bBlank)
               {
                  if ((bBlank == BLANK_NOTCHANGED && !bDelta) || // && iAttr & dsRecModified
                     (iXmlModeRead && iAttr & dsRecModified && !bDelta)) //
                  {
                     DBIResult r;
                     r = GetPrevId(pDs, iRowNo, iFieldID, (pUINT32)pValue, &bBlank);
                     if (r&&iFldLink&&pDs->pDsParent)
                        bPrevIdSpecialCase = TRUE;
                     // inc usecount of Set ?
                     // This should add the fieldID
                  }
                  else
                  {
                     // pLTABLEEntry pLEntry;
                     // DSBASE *pDsDet;

                     // Find detail DS for fieldID
                     // pLEntry = pDs->pLinkedTables->Find(iFieldID); // Optimize this
                     // pDsDet  = pLEntry->pDsDet;
                     // rslt = ReadRows(pDsDet, pUP, 1, (UINT32) (-1), bAppend, NULL);
                  }
               }
               else
               {
                  UINT32 iRowCnt = *(pUINT32)pValue; // Number of nested records
                  UINT32 iSetID;
                  pLTABLEEntry pLEntry;
                  DSBASE *pDsDet;

                  // Find detail DS for fieldID
                  pLEntry = pDs->pLinkedTables->Find(iFieldID); // Optimize this
                  pDsDet = pLEntry->pDsDet;
                  iSetID = pDs->iSetIDNext++; // ++pLEntry->iSetIDCnt;
                  if (iRowCnt & dsDELAYEDBIT)
                  {
                     iRowCnt = 0; // Delayed!
                     iSetID |= dsDELAYEDBIT; // Signal this is not fetched yet
                  }
                  rslt = ReadRows(pDsDet, pUP, iRowCnt, iSetID, bAppend, NULL);
                  *(pUINT32)pValue = iSetID; // Store this number in master record!
                  if (rslt)
                     goto Exit;
               }
            }break;

         case fldBLOB:
            { // special treatment
               rslt = pUP->GetFieldLength(&iLen);
               if (rslt)
                  goto Exit;
               if (iLen & dsDELAYEDBIT)
               {
                  rslt = pUP->GetField(&iLen, NULL, &bBlank); // Increment field in pickle
                  *(pUINT32)pValue = iLen; // (store iLen or (-1))
               }
               else
               {
                  if (iLen)
                  { // Get a buffer
                     if (iLen < sizeof(Buf))
                        pBlob = Buf;
                     else
                     {
                        if (iLen > iBufSize)
                        {
                           pBuf = (pBYTE)DsRealloc((pVOID)pBuf, iBufSize, iLen);
                           if (pBuf == NULL)
                           {
                              rslt = DBIERR_NOMEMORY;
                              goto Exit;
                           }
                           iBufSize = iLen;
                        }
                        pBlob = pBuf;
                     }

                     rslt = pUP->GetField(&iLen, pBlob, &bBlank);

                     if (iXmlModeRead && iLen > 0 && ((pFldDesc->iFldSubType == fldstMEMO) ||
                           (pFldDesc->iFldSubType == fldstWIDEMEMO)) && pBlob[iLen-1] == 0)
                     {
                        // Xml returns as zero string, binary doesn't..
                        iLen -= (pFldDesc->iFldSubType == fldstMEMO) ? 1 : 2;

                        // When the original XML data packet has a empty string
                        // (not NULL), iLen is reported as 1 byte and decrementing
                        // in the line above causes AddBlob() to allocate 0 bytes.
                        if (iLen == 0)
                           iLen += (pFldDesc->iFldSubType == fldstMEMO) ? 1 : 2;
                     }

                     rslt = pDs->pDsBlobs->AddBlob(pBlob, iLen, (pUINT32)pValue);
                     if (rslt)
                        goto Exit;
                  }
                  else
                  { // iLen == 0
                     rslt = pUP->GetField(&iLen, NULL, &bBlank); // Increment field in pickle

                     if (iXmlModeRead && bBlank == BLANK_NOTCHANGED && !(iAttr & dsRecModified))
                        bBlank = BLANK_NULL;

                     if (bBlank == FALSE)
                        bBlank = BLANK_NULL;
                     if (bBlank == BLANK_NOTCHANGED && !bDelta) // && iAttr & dsRecModified
                     {
                        DBIResult r;
                        r = GetPrevId(pDs, iRowNo, iFieldID, (pUINT32)pValue, &bBlank);
                        if (r&&iFldLink&&pDs->pDsParent)
                           bPrevIdSpecialCase = TRUE;
                        // inc usecount of blob ?
                     }
                  }
               }
            } // Blob field
            break;

         default:
            {
               UINT32 iLen = iMaxValueLen;

               pUP->GetField(&iLen, pValue, &bBlank); // Don't test for errors here! (gets FIELDISBLANK)
               if (iXmlModeRead && bBlank == BLANK_NOTCHANGED && !(bDelta && iAttr & dsRecModified)
                  && iFldType!= fldBYTES)
                  bBlank = BLANK_NULL;

               if (bBlank)
                  iLen = 0; // make sure it is set
               if (iFldType == fldZSTRING)
               {
                  if (iLen <= pFldDesc->iUnits1)
                     pValue[iLen] = 0; // Zero-terminate
                  else
                     pValue[pFldDesc->iUnits1] = 0; // Truncate it
               }
               else
               {
                  if (iFldType == fldVARBYTES || iFldType == fldUNICODE)
                  {
                     if (iLen)
                     { // Put iLength in front
                        // This Should work, even if it overlaps
                        CopyMem(&pValue[sizeof(UINT16)], pValue, iLen);
                     }
                     if ((iFldType == fldUNICODE) && iXmlModeRead)
                        *(pUINT16)pValue = (UINT16)iLen - 2;
                     else
                        *(pUINT16)pValue = (UINT16)iLen;
                  }
               }
            } // default
            break;
         } // Switch
      PutFld:
         if (bBlank)
         {
            rslt = pDs->PutBlank(NULL, iRowNo, iFieldID, bBlank);
            if (iFldType == fldARRAY || iFldType == fldADT)
            {
               // i += pFieldDesc[i].iUnits2; // Skip all elements, they are null!
            }
         }
         else
         {
            rslt = pDs->PutField(iRowNo, iFieldID, pValue);
         }
      } // for each field
      if (bAppend)
      { // Updates calculated fields, indexes, aggregates, iRecNoNext etc.
         // NOTE: currently does not update calculated fields
         rslt = pDs->InsertRecord(NULL, NULL);
         if (rslt)
            break;
      }
      else
      {
         if (iMoveToRecNo)
         {
            if (iMoveToRecNo > pDs->iRecNoNext)
            { // Make sure we have space enogh
               rslt = pDs->GrowRows(iMoveToRecNo - pDs->iRecNoNext +25, iMoveToRecNo+25); // Make Space
               if (rslt)
                  goto Exit;
               pDs->iRecNoNext = iMoveToRecNo +1; // Only in this case do we need to update it!
            }
            if (iRowNo != iMoveToRecNo)
            {
               rslt = pDs->MoveRecordOver(iMoveToRecNo, iRowNo); // Move whole thing
               if (rslt)
                  goto Exit;
               if (bPrevIdSpecialCase)
               { // The setid was not found, because the link-field value containg the new record number was not yet known.
                  UINT32 k;
                  for (k = 1; k <= iFields; k++)
                  {
                     BOOL bBlankx;
                     pDSFLDDesc pFldDesc = &pDs->pFieldDesc[k-1];
                     UINT32 iFldType = pFldDesc->iFldType;
                     if (iFldType == fldBLOB||iFldType == fldTABLE)
                     {
                        DBIResult r;
                        pDs->GetField(iMoveToRecNo, k, NULL, &bBlankx);
                        if (!bBlankx)
                           continue;
                        r = GetPrevId(pDs, iMoveToRecNo, k, (pUINT32)pValue, &bBlankx);
                        if (!r&&!bBlankx)
                        {
                           pDs->PutField(iMoveToRecNo, k, pValue);
                        }
                     }
                  }
               }
            }
            else
            {
               if (iRowNo == pDs->iRecNoNext)
               {
                  rslt = pDs->IncRow();
                  if (rslt)
                     goto Exit;
               }
            }
         }
         else
         {
            rslt = pDs->IncRow();
            if (rslt)
               goto Exit;
         }
      }
   } // for each record

Eof:
   if (piVisibleRecords)
      *piVisibleRecords = iRecords;

   if (pDs->pDsBlobs)
      pDs->pDsBlobs->Commit();

Exit:
   if (bAppend)
   {
      pDs->bDisableLog = bDisableLogSave;
      if (pDs->pDsCallBacks)
         pDs->pDsCallBacks->Notify(); // For clone case
   }
   if (pBuf)
      DsFree(pBuf);
   return rslt;
}

// Assumes the existence of an attribute field and a null-flags field
// Computes :
// piAttr
// iBlobFields
// iFieldsVisible
// iRecordSize
// iFieldNoNulls
// pDsBlobs
// FieldDesc.iNullOffsInRec
// FieldDesc.iFldOffset
DBIResult DBIFN DSBASE::InitializeFields()
{
   UINT32 i;
   DBIResult rslt = DBIERR_NONE;
   UINT32 iFieldID;

   if (ppColumns == NULL)
   {
      ppColumns = new pBYTE[iFields]; //
      ZeroMem(ppColumns, sizeof(pBYTE)*iFields); // Nulls out all pointers
   }
   if (pFldBufScratch == NULL)
   {
      pFldBufScratch = new BYTE[MAXFIELDLEN+4];
      iFldBufScratchLen = MAXFIELDLEN;
   }

   iRecordSize = 0;

   // Compute fldoffs, RecordSize
   // Set iUnit1, iFldLen
   iBlobFields = 0;
   iFieldID = 1; // 1-based, like fieldnumbers
   for (i = 0; i < iFields; i++, iFieldID++)
   {
      pDSFLDDesc pFldDes = &pFieldDesc[i];

      pFldDes->iFldOffsInRec = iRecordSize;
      switch(pFldDes->iFldType)
      {
      case fldBOOL8:
      case fldINT8:
      case fldUINT8:
         pFldDes->iFldLen = sizeof(UINT16);
         break;

      case fldBOOL: // bde-bool is 16-bit!
      case fldINT16:
      case fldUINT16:
         pFldDes->iFldLen = sizeof(UINT16);
         break;
      case fldDATE:
      case fldTIME:
      case fldUINT32:
      case fldINT32:
      case fldBOOL32:
         pFldDes->iFldLen = sizeof(UINT32);
         break;
      case fldINT64:
      case fldUINT64:
         pFldDes->iFldLen = 8;
         break;
      case fldDATETIME:
         pFldDes->iFldLen = sizeof(SQLTIMESTAMP); // 16
         break;
      case fldDATETIMEOFFSET:
         pFldDes->iFldLen = sizeof(SQLTIMESTAMPOFFSET); // 20
         break;
      case fldSINGLE:
         pFldDes->iFldLen = sizeof(SINGLE); // 4
         break;
      case fldTIMESTAMP:
      case fldFLOAT:
         pFldDes->iFldLen = sizeof(DFLOAT); // 8
         break;
      case fldFLOATIEEE:
         pFldDes->iFldLen = 10; // 10
         break;
      case fldBLOB:
         BLOB_LABEL : pFldDes->iFldLen = sizeof(BLOBID); // Create a blobid
         // NOTE: iUnits1 is set to iUnits1 in BDE (0..255).DOes this conflict with FieldLen ?
         break;
      case fldZSTRING:
         if (pFldDes->iFldLen)
            pFldDes->iUnits1 = pFldDes->iFldLen-1;
         else
         {
            if (pFldDes->iUnits1)
               pFldDes->iFldLen = pFldDes->iUnits1+1;
            else
               rslt = DBIERR_INVALIDPARAM;
         }
         break;
      case fldVARBYTES:
         if ((pFldDes->iFldSubType == fldstMEMO) ||
            ((this->iXmlMode) && (pFldDes->iFldSubType >= fldstMEMO && pFldDes->iFldSubType <= fldstTYPEDBINARY))) // XML!
         {
            // pFldDes.iUnits1=0;
            pFldDes->iFldType = fldBLOB;
            goto BLOB_LABEL;
         }
         else if ((pFldDes->iFldSubType == fldstWIDEMEMO) ||
            ((this->iXmlMode) && (pFldDes->iFldSubType >= fldstWIDEMEMO && pFldDes->iFldSubType <= fldstTYPEDBINARY))) // XML!
         {
            // pFldDes.iUnits1=0;
            pFldDes->iFldType = fldBLOB;
            goto BLOB_LABEL;
         }

         // Handle BLOB subtypes HMEMO and HBINARY
         if ((pFldDes->iFldSubType == fldstHMEMO || pFldDes->iFldSubType == fldstHBINARY) && this->iXmlMode)
         {
            pFldDes->iFldType = fldBLOB;
            goto BLOB_LABEL;
         }
         if (pFldDes->iFldSubType == 0 && this->iXmlMode)
         {
            pFldDes->iFldType = fldBYTES;
            goto FIXEDBYTES;
         }
         pFldDes->iFldLen = pFldDes->iUnits1+sizeof(UINT16); // Length field
         break;
      case fldBYTES: // (Similar to fldZSTRING)
         FIXEDBYTES :
         if (pFldDes->iFldLen) // Typicaly if from datapacket
            pFldDes->iUnits1 = pFldDes->iFldLen;
         else
         {
            if (pFldDes->iUnits1) // Typicaly if created localy
               pFldDes->iFldLen = pFldDes->iUnits1;
            else
               rslt = DBIERR_INVALIDPARAM;
         }
         break;
      case fldFMTBCD:
      case fldBCD:
         {
            UINT32 iFractionLen = pFldDes->iUnits1 >> 1;
            if (pFldDes->iUnits1 & 1)
               iFractionLen++;
            if (iFractionLen)
               pFldDes->iFldLen = 2 + iFractionLen; // Always given
            else
               pFldDes->iFldLen = sizeof(FMTBcd);
         }break;
      case fldUNICODE:
         pFldDes->iFldLen = pFldDes->iUnits1+sizeof(UINT16); //
         break;
      case fldADT: // Composite structure
         // pFldDes->iUnits1 : Total Number of elements inside ADT
         if (pFldDes->iUnits1 < 1)
         {
            rslt = DBIERR_INVALIDFLDTYPE;
            goto Exit;
         }
         pFldDes->iFldLen = 0; // No length since it is a pseudo
         break;
      case fldARRAY: // Composite array-structure
         // pFldDes->iUnits1 : Total Number of elements inside ARRAY
         if (pFldDes->iUnits1 < 1)
         {
            rslt = DBIERR_INVALIDFLDTYPE;
            goto Exit;
         }
         // Could be counter, pFldDes->iFldLen = 0; // No length since it is a pseudo
         break;
      case fldTABLE: // Embedded table
         // pFldDes->iUnits1 : Total Number of elements inside TABLE
         if (pFldDes->iUnits1 < 1)
         {
            rslt = DBIERR_INVALIDFLDTYPE;
            goto Exit;
         }
         pFldDes->iFldLen = sizeof(UINT32); // SetID, linking field
         break;

      }
      if (pFldDes->iUnits1 == 0 && pFldDes->iFldType != fldBLOB) // iUnits1 for blob fields should be 0
      {
         pFldDes->iUnits1 = 1;
      }
      if (rslt)
         break;
      if (pFldDes->iFldLen > iFldBufScratchLen)
      {
         if (pFldDes->iFldLen>64*1024-5)
         {
            rslt = DBIERR_INVALIDFLDTYPE;
            break;
         }
         delete[] pFldBufScratch;
         pFldBufScratch = new BYTE[pFldDes->iFldLen+4];
         iFldBufScratchLen = pFldDes->iFldLen;
      }

      if ((pFldDes->iFldLen == 0 && pFldDes->iFldType != fldADT && pFldDes->iFldType!= fldARRAY))
      {
         rslt = DBIERR_INVALIDFLDTYPE;
         break;
      }
      iRecordSize += pFldDes->iFldLen;

      if (pFldDes->iFldType == fldBLOB)
         iBlobFields++;
      // ASSERT_TRUE(pFldDes->iLen == 0);
   }

   // Null field
   iNullOffset = iRecordSize;
   iNullLength = iFields;
   iRecordSize += iNullLength;

   if (iBlobFields && pDsBlobs == NULL)
   {
      pDsBlobs = new DSBLOBS();
   }

   ComputeMaxFieldIDs(iFields, pFieldDesc, NULL); // OR, Fills in iUnits2 for ADT/ARRAY, correct ?

   // Compute nulloffsets for fields
   // Initialize iFieldIDParent for each fielddescriptor (0 == NONE)
   for (i = 0; i < iFields; i++)
   {
      pFieldDesc[i].iNullOffsInRec = iNullOffset +i;
      pFieldDesc[i].iFieldID = (UINT16)(i+1);
      if (pFieldDesc[i].iFldType == fldADT || pFieldDesc[i].iFldType == fldARRAY)
      {
         // Fills all the following fields with a reference. In case of nested structures,
         // these are filled in later so that the ParentID is always the 'closest'
         UINT32 iFldIDParent = 0;
         UINT32 j;

         iFldIDParent = i+1;
         for (j = i+1; j <= i + pFieldDesc[i].iUnits2; j++)
            pFieldDesc[j].iFieldIDParent = (UINT16)iFldIDParent;
      }
   }
Exit:
   return rslt;
}

DBIResult MakeBDEFldDesc(DSDATAPACKETFLDDesc *pPDes, pDSFLDDesc pFieldDesc)
{
   UINT32 iFldType, iBDEFldType;
   UINT32 iSize;

   ZeroMem(pFieldDesc, sizeof(DSFLDDesc));
   LdStrCpy(pFieldDesc->szName, pPDes->szFieldName);

   iFldType = pPDes->iFieldType;
   MakeBDEType(iFldType, &iBDEFldType, &iSize);

   if (iBDEFldType == fldADT || iBDEFldType == fldARRAY || iBDEFldType == fldTABLE)
   {
      pFieldDesc->iUnits1 = iSize; // Number of elements
      if (iBDEFldType == fldTABLE)
         pFieldDesc->iFldLen = sizeof(UINT32); // Contains setId
      else
         pFieldDesc->iFldLen = 0; // How about array counters ?
   }
   else
      pFieldDesc->iFldLen = iSize;
   pFieldDesc->iFldType = iBDEFldType;

   if (pPDes->iAttributes)
   {
      pFieldDesc->iFldAttr = (UINT32)pPDes->iAttributes; // They are compatible
   }
   return DBIERR_NONE;
}

DBIResult MakeBDEType(UINT32 iFieldType, pUINT32 piBDEType, pUINT32 piSize)
{
   UINT32 iBDEFldType, iPCKLFldType, iSize;
   BOOL bVarying = FALSE;

   iSize = iFieldType & dsSizeBitsMask;
   iPCKLFldType = iFieldType & dsTypeBitsMask;
   iPCKLFldType = iPCKLFldType >> dsSizeBitsLen;
   if (iFieldType & dsVaryingFldType)
      bVarying = TRUE;
   if (iFieldType & dsArrayFldType)
   {
      return DBIERR_INVALIDFLDTYPE;
   }

   // Issues with types not supported by BDE (Set to fldUNKNOWN)
   // If these values are goin to be cast, there are issues with zeroing out the
   // Buffers
   switch(iPCKLFldType)
   {
   case dsfldUNKNOWN:
      iBDEFldType = fldUNKNOWN;
      break;
   case dsfldINT:
      iBDEFldType = (iSize == 4) ? fldINT32 : (iSize == 2) ? fldINT16 : (iSize == 1) ? fldINT8 : (iSize == 8)
         ? fldINT64 : fldUNKNOWN;
      break;
   case dsfldUINT:
      iBDEFldType = (iSize == 4) ? fldUINT32 : (iSize == 2) ? fldUINT16 : (iSize == 1) ? fldUINT8 : (iSize == 8)
         ? fldUINT64 : fldUNKNOWN;
      break;
   case dsfldBOOL:
      iBDEFldType = (iSize == 4) ? fldBOOL32 : (iSize == 2) ? fldBOOL16 : (iSize == 1) ? fldBOOL8 : fldUNKNOWN; //
      break;
   case dsfldSINGLE:
      iBDEFldType = (iSize == 4) ? fldSINGLE : fldUNKNOWN;
      break;
      // Float/Money etc.
   case dsfldFLOATIEEE:
      iBDEFldType = (iSize == 8) ? fldFLOAT : (iSize == 10) ? fldFLOATIEEE : (iSize == 4) ? fldSINGLE : fldUNKNOWN;
      // (upgrade ?)
      break;
   case dsfldFMTBCD:
      iBDEFldType = fldFMTBCD;
      break;
   case dsfldBCD:
      iBDEFldType = fldBCD;
      break;
   case dsfldDATE:
      iBDEFldType = fldDATE;
      break;
   case dsfldTIME:
      iBDEFldType = fldTIME;
      break;
   case dsfldDATETIME:
      iBDEFldType = fldDATETIME;
      break;
   case dsfldDATETIMEOFFSET:
      iBDEFldType = fldDATETIMEOFFSET;
      break;
   case dsfldTIMESTAMP:
      iBDEFldType = fldTIMESTAMP;
      break;
   case dsfldZSTRING:
      iBDEFldType = fldZSTRING;
      break;
   case dsfldUNICODE:
      iBDEFldType = fldUNICODE;
      break;
   case dsfldBIGDECIMAL:
   case dsfldBYTES:
      if (bVarying) // Varbyte ? (only if iunits1 is set!)
      {
         if (iSize == sizeof(UINT32))
            iBDEFldType = fldBLOB;
         else
            iBDEFldType = fldVARBYTES;
      }
      else
         iBDEFldType = fldBYTES;
      break;

   case dsfldADT:
      iBDEFldType = fldADT; // OR
      break;

   case dsfldARRAY:
      iBDEFldType = fldARRAY; // OR
      break;

   case dsfldEMBEDDEDTBL:
      iBDEFldType = fldTABLE; // OR
      break;

   default:
      iBDEFldType = fldUNKNOWN;
      break;
   }

   if (bVarying)
      iSize = 0; // Need to get iUnits1

   *piSize = iSize;
   *piBDEType = iBDEFldType;
   return DBIERR_NONE;
}

DBIResult MakePCKLType(UINT32 iBDEFldType, UINT32 iFldLen, UINT32 iUnits1, pINT piPCKLFldType)
{
   UINT32 iPCKLFldType = 0;

   switch(iBDEFldType)
   {
   case fldUNKNOWN:
      iPCKLFldType = dptypeUNKNOWN(iFldLen);
      break;

   case fldINT8:
      iPCKLFldType = dptypeINT8;
      break;

   case fldUINT8:
      iPCKLFldType = dptypeUINT8;
      break;

   case fldINT16:
      iPCKLFldType = dptypeINT16;
      break;

   case fldUINT16:
      iPCKLFldType = dptypeUINT16;
      break;

   case fldINT32:
      iPCKLFldType = dptypeINT32;
      break;

   case fldUINT32:
      iPCKLFldType = dptypeUINT32;
      break;

   case fldINT64:
      iPCKLFldType = dptypeINT64;
      break;

   case fldUINT64:
      iPCKLFldType = dptypeUINT64;
      break;

   case fldBOOL8:
      iPCKLFldType = dptypeBOOL8;
      break;

   case fldBOOL16:
      iPCKLFldType = dptypeBOOL16;
      break;

   case fldBOOL32:
      iPCKLFldType = dptypeBOOL32;
      break;

   case fldSINGLE:
      iPCKLFldType = dptypeSINGLE;
      break;

   case fldFLOAT:
      iPCKLFldType = dptypeFLOAT;
      break;

   case fldFLOATIEEE:
      iPCKLFldType = dptypeFLOATIEEE;
      break;

   case fldFMTBCD:
      iPCKLFldType = dptypeFMTBCD(iFldLen);
      break;

   case fldBCD:
      iPCKLFldType = dptypeBCD(iFldLen);
      break;

   case fldDATE:
      iPCKLFldType = dptypeDATE;
      break;

   case fldTIME:
      iPCKLFldType = dptypeTIME;
      break;

   case fldTIMESTAMP:
      iPCKLFldType = dptypeTIMESTAMP;
      break;

   case fldDATETIME:
      iPCKLFldType = dptypeSQLTIMESTAMP;
      break;

   case fldDATETIMEOFFSET:
      iPCKLFldType = dptypeSQLTIMESTAMPOFFSET;
      break;

   case fldZSTRING:
      iPCKLFldType = dptypeZSTRING(iFldLen);
      break;

   case fldUNICODE:
      iPCKLFldType = dptypeUNICODE(iFldLen);
      break;

   case fldVARBYTES:
      iPCKLFldType = dptypeVARBYTES(iFldLen);
      break;

   case fldBLOB:
      iPCKLFldType = dptypeBLOB;
      break;

   case fldBYTES:
      iPCKLFldType = dptypeBYTES(iFldLen);
      break;

   case fldADT:
      iPCKLFldType = dptypeADT(iUnits1);
      break;

   case fldARRAY:
      iPCKLFldType = dptypeARRAY(iUnits1);
      break;

   case fldTABLE:
      iPCKLFldType = dptypeTABLE(iUnits1);
      break;

   case fldREF:
      iPCKLFldType = dptypeREF(iUnits1);
      break;
   }

   if (piPCKLFldType)
      *piPCKLFldType = iPCKLFldType;
   return DBIERR_NONE;
}

DBIResult MakePcklFldDesc(DSDATAPACKETFLDDesc *pPDes, pDSFLDDesc pFieldDesc)
{
   LdStrCpy(pPDes->szFieldName, pFieldDesc->szName);
   MakePCKLType(pFieldDesc->iFldType, pFieldDesc->iFldLen, pFieldDesc->iUnits1, &pPDes->iFieldType);
   pPDes->iAttributes = (UINT16)pFieldDesc->iFldAttr; // Compatible
   return DBIERR_NONE;
}

// Given array of elements, create array type, and buffer
// piLen on entry contains length of buffer, on exit length of value
// piType contains element type (fldINT16/fldUINT16 or fldINT32/fldUINT32), returns pickle type
DBIResult MakeIntArray(UINT32 iCnt, pBYTE pElements, pUINT32 piType, pUINT32 piLen, pBYTE pBuf)
{
   UINT32 i, iType;
   pBYTE pTmp = pBuf;
   UINT32 iLen;
   BOOL bInt16 = *piType == fldINT16 || *piType == fldUINT16; // FALSE -> int32

   iLen = sizeof(UINT32) + iCnt*(bInt16 ? sizeof(UINT16) : sizeof(UINT32));
   if (*piLen < iLen)
      return DBIERR_NA;
   *piLen = iLen;

   *(pUINT32)pTmp = iCnt;
   pTmp += sizeof(UINT32);
   for (i = 0; i < iCnt; i++)
   {
      if (bInt16)
      {
         *(pUINT16)pTmp = *(pUINT16)pElements;
         pTmp += sizeof(UINT16);
         pElements += sizeof(UINT16);
      }
      else
      {
         *(pUINT32)pTmp = *(pUINT32)pElements;
         pTmp += sizeof(UINT32);
         pElements += sizeof(UINT32);
      }
   }

   iType = (*piType == fldINT16 || *piType == fldINT32) ? dsfldINT : dsfldUINT;
   iType = iType << dsSizeBitsLen;
   iType |= bInt16 ? 2 : 4; // Size
   iType |= dsArrayFldType;
   *piType = iType;
   return DBIERR_NONE;
}

DBIResult DBIFN MakeEmptyDatapacket(DSBASE *pDs, DSDATAPACKET **ppPi, BOOL bDontInclMetaData)
{
   DBIResult rslt = DBIERR_NONE;
   BOOL bAllocated = FALSE;
   UINT32 i, j, iFields;
   pDSFLDDesc pFieldDesc;
   DSDATAPACKETFLDDesc *pPcklFieldDesc = NULL;
   DSDATAPACKET *pPi = NULL;
   UINT32 iFieldsTotal; // Includes embedded tables, compressed arrays

   iFieldsTotal = pDs->iFieldsCompressed;
   for (j = 0; j<pDs->iFields; j++)
      if (pDs->pFieldDesc[j].bCalculated == 2 &&!(pDs->pFieldDesc[j].iFldAttr & fldAttrLINK))
         iFieldsTotal--; // do not include locally added calculated fields

   if (pDs->pLinkedTables)
      iFieldsTotal += pDs->pLinkedTables->GetTotalFieldDesc(TRUE);

   if (pDs->iFieldID_SetIDD && !(pDs->pDsLog && pDs->pDsLog->iLast) && iFieldsTotal >0)
   { // This is a detail with no changes, we should ignore the link field
      iFieldsTotal--;
   }

   if (iFieldsTotal == 0)
      return DBIERR_NA;

   if (!bDontInclMetaData)
   {
      // Create pickle
      pPi = new DSDATAPACKET();

#ifdef MIDAS_DLL
      pPi->SetMETADATAMode(pDs->bUTF8METADATA);
      pPi->SetXMLMode(pDs->iXmlMode);

#else
      pPi->SetXMLMode(5); // pDs->iXmlMode);
#endif
      pPi->SetANSICodePage(pDs->iANSICodePage);
      if (pPi != NULL)
         rslt = pPi->Init_Sequential(MAX_PICKLEVERSION, (UINT16)iFieldsTotal);
      else
         rslt = DBIERR_NOMEMORY;
      goto Exit;
   }

   // Creates empty datapacket from meta data in DS
   // Get compressed fielddescs
   if (pDs->iFields != pDs->iFieldsCompressed)
   {
      iFields = pDs->iFieldsCompressed;
      pFieldDesc = new DSFLDDesc[iFields];
      CompressFldDescs(NULL, pDs->pFieldDesc, NULL, pFieldDesc, pDs->iFields);
      if (pFieldDesc)
         bAllocated = TRUE;
   }
   else
   {
      iFields = pDs->iFields;
      pFieldDesc = pDs->pFieldDesc;
   }

   pPcklFieldDesc = new DSDATAPACKETFLDDesc[iFieldsTotal];
   if (pPcklFieldDesc == NULL)
   {
      rslt = DBIERR_NOMEMORY;
      goto Exit;
   }
   for (i = 0; i < iFieldsTotal; i++)
   {
      ZeroMem(&pPcklFieldDesc[i], sizeof(DSDATAPACKETFLDDesc));
      MakePcklFldDesc(&pPcklFieldDesc[i], &pFieldDesc[i]);
   }
   pPi = new DSDATAPACKET();
   if (pPi != NULL)
      rslt = pPi->Init(MAX_PICKLEVERSION, (UINT16)iFields, pPcklFieldDesc);
   else
      rslt = DBIERR_NOMEMORY;

Exit:
   if (ppPi)
      *ppPi = pPi;
   if (bAllocated)
      delete pFieldDesc;
   if (pPcklFieldDesc)
      delete pPcklFieldDesc;
   if (rslt)
   {
      if (pPi)
         delete pPi;
   }
   return rslt;
}

// Returns pointer to pickle, and size.
// Pickle must be released by the user!
DBIResult DBIFN DSBASE::StreamDS(SAFEARRAY **ppPickle)
{
   DBIResult rslt = DBIERR_NONE;
   DSDATAPACKET *pPi = NULL;
   BOOL bRemUnused = TRUE;

   LOCK();
   if (pFieldDesc == NULL)
   { // Sometimes happens after an exception when reading a datapacket
      rslt = DBIERR_DATAPACKETMISMATCH;
      goto Exit;
   }

   rslt = MakeEmptyDatapacket(this, &pPi, bDontInclMetaData);
   if (rslt)
      goto Exit;
   if (bDontInclMetaData)
      goto GetData;

   rslt = StreamFieldDescs(this, pPi);
   if (rslt)
      goto Exit;

   // Add attributes
   rslt = StreamOptionalParameters(this, pPi);
   if (rslt)
      goto Exit;

   bRemUnused = (pDsLog == NULL || pDsLog->iLast == 0);

GetData:
   if (bRemUnused && pIdxDef->iRecs > 0)
      rslt = StreamRows(this, pPi, pIdxDef->iRecs, 0, bRemUnused, &pIdxDef->piOrder[1]);
   else
      rslt = StreamRows(this, pPi, iRecNoNext-1, 0, bRemUnused, NULL);

Exit:
   if (!rslt)
   {
      pPi->GetDataPacket(ppPickle);
      delete pPi;
      pPi = NULL;
   }
   else
   {
      if (pPi)
         delete pPi;
      pPi = NULL;
      if (ppPickle)
         *ppPickle = NULL;
   }
   UNLOCK();
   return rslt;
}

DBIResult DBIFN StreamFieldDescs(DSBASE *pDs, DSDATAPACKET *pPi)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i, j, iFields;
   pDSFLDDesc pFieldDesc;
   BOOL bAllocated = FALSE;
   DSDATAPACKETFLDDesc PcklFieldDesc;
   UINT32 iFldLinkIgn = 0; // 1-based

   if (pDs->iFields != pDs->iFieldsCompressed)
   {
      iFields = pDs->iFieldsCompressed;
      pFieldDesc = new DSFLDDesc[iFields];
      CompressFldDescs(NULL, pDs->pFieldDesc, NULL, pFieldDesc, pDs->iFields);
      if (pFieldDesc)
         bAllocated = TRUE;
   }
   else
   {
      iFields = pDs->iFields;
      pFieldDesc = pDs->pFieldDesc;
   }

   if (pDs->iFieldID_SetIDD && !(pDs->pDsLog && pDs->pDsLog->iLast))
   { // This is a detail with no changes, we should ignore the link field
      iFldLinkIgn = pDs->iFieldID_SetIDD;
   }

   for (i = 0; i < iFields; i++)
   {
      DSBASE *pDsDet = NULL;

      if (i+1 == iFldLinkIgn)
      {
         continue;
      }
      if (pFieldDesc[i].bCalculated == 2 && i+1!=pDs->iFieldID_SetIDD) // added locally, don't stream
      {
         continue;
      }
      ZeroMem(&PcklFieldDesc, sizeof(DSDATAPACKETFLDDesc));
      if (pFieldDesc[i].iFldType == fldTABLE)
      {
         UINT16 iUnits1;
         pLTABLEEntry pEntry = pDs->pLinkedTables->Find(pFieldDesc[i].iFieldID);
         if (!pEntry || !pEntry->pDsDet)
         {
            rslt = DBIERR_NA;
            goto Exit;
         }
         pDsDet = pEntry->pDsDet;
         iUnits1 = (UINT16)pFieldDesc[i].iUnits1;
         pFieldDesc[i].iUnits1 = pDsDet->iFieldsCompressed;
         if (pDsDet->iFieldID_SetIDD && !(pDsDet->pDsLog && pDsDet->pDsLog->iLast))
            pFieldDesc[i].iUnits1--; // Do not count link_field
         for (j = 0; j<pDsDet->iFields; j++)
            if (pDsDet->pFieldDesc[j].bCalculated == 2 &&!(pDsDet->pFieldDesc[j].iFldAttr & fldAttrLINK))
               pFieldDesc[i].iUnits1--; // do not include locally added calculated fields

         if (pDsDet->pLinkedTables)
         {
            pFieldDesc[i].iUnits1 += pDsDet->pLinkedTables->GetTotalFieldDesc(TRUE);
         }
         MakePcklFldDesc(&PcklFieldDesc, &pFieldDesc[i]);
         pFieldDesc[i].iUnits1 = iUnits1; // restore value
      }
      else if (pFieldDesc[i].iFldType == fldTABLE)
      {
      }
      else
      {
         MakePcklFldDesc(&PcklFieldDesc, &pFieldDesc[i]);
      }
      rslt = pPi->AddColumnDesc(&PcklFieldDesc);
      if (rslt)
         goto Exit;

      // Add subtype, width, and decimals
      rslt = AddFldOptParams(&pFieldDesc[i], pPi);
      // if (rslt) should we fail or ignore ?
      // goto Exit;

      // Add other optional parameters
      rslt = AddOptParams(pDs->pDsOptParams, pPi, pFieldDesc[i].iFieldID, NULL);
      if (pDsDet)
      { // fldTABLE
         rslt = StreamFieldDescs(pDsDet, pPi); // Calls recursively
         if (rslt)
            goto Exit;
         rslt = StreamOptionalParameters(pDsDet, pPi);
         if (rslt)
            goto Exit;
      }
      if (rslt)
         goto Exit;

   }

Exit:
   if (bAllocated)
      delete pFieldDesc;
   return rslt;
}

DBIResult DBIFN StreamOptionalParameters(DSBASE *pDs, DSDATAPACKET *pPi)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i, iAdded;

   if (!pDs->bDelta && pDs->pIdxDef && pDs->bDefOrderChanged)
   { // In case default order was created localy.
      // It was not added to the optional parameter list.
      UINT16 pTmpBuf[2 + MAXKEYFIELDS]; // <INT32><[<INT16><INT16>...]
      UINT32 iFldType = fldUINT16;
      UINT32 iLen = sizeof(pTmpBuf);
      pUINT16 pFieldArray = pTmpBuf + 2; // (2 is 2*INT16 = INT32!)
      pDSIDX pIdxDef = pDs->pIdxDef;

      // Note: this does not work since IdxDesc.iKeyFields is UINT32, and pTempBuf is UINT16, so fix it below!
      MakeIntArray(pIdxDef->IdxDesc.iFields, (pBYTE) &pIdxDef->IdxDesc.iKeyFields[0], &iFldType, &iLen, (pBYTE)pTmpBuf);
      // Set descending/caseinsensitivity.
      for (i = 0; i < pIdxDef->IdxDesc.iFields; i++)
      {
         pFieldArray[i] = (UINT16)pIdxDef->IdxDesc.iKeyFields[i];
         if (pIdxDef->IdxDesc.bDescending[i])
            pFieldArray[i] |= dskeyDESCENDING;
         if (pIdxDef->IdxDesc.bCaseInsensitive[i])
            pFieldArray[i] |= dskeyCASEINSENSITIVE;
      }
      rslt = pPi->AddAttribute(pcklAttrArea, szDEFAULT_ORDER, iFldType, iLen, (pBYTE)pTmpBuf);
      if (rslt)
         goto Exit;

      if (pIdxDef->IdxDesc.bUnique)
      {
         pCHAR pName = (pIdxDef->IdxDesc.bUnique == 2)?(char*)szPRIMARY_KEY : (char*)szUNIQUE_KEY;
         for (i = 0; i < pIdxDef->IdxDesc.iFields; i++)
         {
            pFieldArray[i] &= (UINT16)~(dskeyDESCENDING | dskeyCASEINSENSITIVE);
         }
         rslt = pPi->AddAttribute(pcklAttrArea, pName, iFldType, iLen, (pBYTE)pTmpBuf);
         if (rslt)
            goto Exit;
      }
   }

   // Change log
   // NOT if bDelta ?
   if (!pDs->bDelta && pDs->pDsLog && pDs->pDsLog->iLast > 0)
   {
      DSLOG *pDsLog = pDs->pDsLog;
      UINT32 iSize = pDsLog->iLast*sizeof(LOGENTRY)+sizeof(UINT32);
      pBYTE pTmpBuf = new BYTE[iSize];
      UINT32 iFldType = fldUINT32;

      MakeIntArray(pDsLog->iLast*sizeof(LOGENTRY)/sizeof(UINT32), (pBYTE) &pDsLog->pLogEntries[0], &iFldType, &iSize,
         pTmpBuf);

      rslt = pPi->AddAttribute(pcklAttrArea, szCHANGE_LOG, iFldType, iSize, pTmpBuf);
      delete[] pTmpBuf;
      if (rslt)
         goto Exit;
   }

   // AutoincField
   if (!pDs->bDelta && pDs->iAutoIncField)
   { // Store the current 'next' value of the autoinc-field
      UINT32 iFldType = dsfldINT;
      UINT32 iSize = sizeof(UINT32); // piFieldDesc[iAutoIncField - 1].iFldLen; // 4, 2

      iFldType = iFldType << dsSizeBitsLen;
      iFldType |= iSize;
      rslt = pPi->AddAttribute(pcklAttrArea, szAUTOINCVALUE, iFldType, iSize, (pBYTE) &pDs->iAutoIncNext);
      if (rslt)
         goto Exit;
   }

   if (!pDs->bDelta && pDs->pLinkedTables)
   { // Add explicit links (fieldlinks)
      pLTABLEEntry pEntry;
      UINT32 i, j;
      for (i = 0; i < pDs->pLinkedTables->iLast; i++)
      {
         UINT32 iFldType = dsfldINT;
         UINT16 piValue[2*MAXKEYFIELDS+1+2]; // (1 is fieldID for M-Setid, 2 is sizeof(UINT32) for count)
         pUINT16 pValue = &piValue[2];
         pUINT32 pCount = (pUINT32) &piValue[0];

         pEntry = pDs->pLinkedTables->GetEntry(i+1);
         if (pEntry->iFields == 0)
            continue;
         iFldType = dsfldINT;
         iFldType = iFldType << dsSizeBitsLen;
         iFldType |= sizeof(UINT16); ;
         iFldType |= dsArrayFldType;
         *pCount = pEntry->iFields*2+1; // Number of values
         pValue[0] = (UINT16)pEntry->iFieldID_SetIDM;
         for (j = 0; j < pEntry->iFields; j++)
         {
            pValue[j+1] = pEntry->iFieldIDM[j];
            pValue[j+1+pEntry->iFields] = pEntry->pDsDet->piLinkField[j];
         }
         rslt = pPi->AddAttribute(pcklAttrArea, szMD_FIELDLINKS, iFldType, sizeof(UINT16)*(pEntry->iFields*2+1)+
            sizeof(UINT32), (pBYTE)piValue);
         if (rslt)
            goto Exit;
      }
   }

   // Constraints

   // Add cached optional parameters
   rslt = AddOptParams(pDs->pDsOptParams, pPi, 0, &iAdded);
   if (pDs->pDsParent || iAdded == 0)
      pPi->AddAttribute(pcklAttrArea, NULL, 0, 0, NULL);

Exit:
   return rslt;
}

DBIResult DBIFN StreamRows(DSBASE *pDs, DSDATAPACKET *pPi, UINT32 iRecsToStream, UINT32 iSetIDDet, BOOL bRemUnused,
   pUINT32 piRecNos)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i, iRowNo;
   pDSFLDDesc pFieldDesc = pDs->pFieldDesc;
   UINT32 iVRowNo; // Virtual record no
   UINT32 iFldLink = 0, iFldLinkIgn = 0; // Contains SetId

   if (pDs->iFieldID_SetIDD)
   {
      if (pDs->pDsLog && pDs->pDsLog->iLast)
      { // This is a detail with changes, we must store its recordnumber in the SetID column
         iFldLink = pDs->iFieldID_SetIDD;
      }
      else
      {
         iFldLinkIgn = pDs->iFieldID_SetIDD;
      }
   }

   UNREFERENCED_PARAMETER(iSetIDDet);
   // Put all rows
   for (iRowNo = 1; iRowNo < iRecsToStream+1; iRowNo++)
   {
      DSAttr iAttr;

      iVRowNo = piRecNos ? piRecNos[iRowNo-1] : iRowNo;

      iAttr = pDs->piAttr[iVRowNo-1]; // Set attribute
      // *(DSAttr *) Value = iAttr;
      if (bRemUnused && iAttr)
      {
         if (iAttr & dsUnused)
            continue;
         if (pDs->bDisableLog && !pDs->bDelta)
         {
            if (iAttr & dsISNOTVISIBLE)
               continue;
            iAttr = 0; // Don't store attribute
         }
      }
      pPi->PutField(fldIsChanged, sizeof(DSAttr), (pBYTE) &iAttr);

      // Put all fields
      for (i = 0; i < pDs->iFields; i++)
      {
         PCKLFldStauts bBlank;
         BOOL bBlankStatus = FALSE;
         pBYTE pValue;
         UINT32 iLen;
         UINT32 iFldType = pFieldDesc[i].iFldType;

         // If calculated, should just write outa blank ?
         pDs->GetFieldPtr(iVRowNo, i+1, &pValue, (pBOOL) &bBlankStatus);
         bBlank = (PCKLFldStauts)bBlankStatus;

         if (iFldLink == i+1)
         { // Special situation
            rslt = pPi->PutField(fldIsChanged, sizeof(UINT32), (pBYTE) &iVRowNo);
            if (rslt)
               goto Exit;
            continue;
         }
         if (iFldLinkIgn == i+1)
            continue;
         if (pFieldDesc[i].bCalculated == 2)
            continue; // ignore calculated field
         if (bBlank)
         {
         PutBlank:
            rslt = pPi->PutField(bBlank, 0, NULL); // Put blank
            if (rslt)
               goto Exit;
            if (iFldType == fldTABLE)
            { // Recurse (optimize this out)
               // Find detail DS for fieldID
               // pLTABLEEntry pLEntry;
               // DSBASE 	   *pDsDet;
               // pLEntry = pDs->pLinkedTables->Find(i+1); // Optimize this
               // pDsDet  = pLEntry->pDsDet;
               // rslt    = StreamRows(pDsDet, pPi, 1, (UINT32) (-1), FALSE, NULL);
            }
         }
         else
         {
            switch(iFldType)
            {
            case fldTABLE:
               {
                  UINT32 iSetID = *(pUINT32)pValue;

                  // If this is a modified record, the details should go with the
                  // original record
                  if (iSetID && (iAttr & dsRecModified) && !pDs->bDelta)
                  {
                     UINT32 iSetIdPrev;
                     BOOL bBlankPrev = 0;

                     GetPrevId(pDs, iVRowNo, i+1, &iSetIdPrev, &bBlankPrev); // works on the log
                     if (bBlankPrev == BLANK_NOTCHANGED || iSetIdPrev == iSetID)
                     {
                        bBlank = fldIsUnChanged;
                        goto PutBlank; //
                     }
                  }
                  if (pDs->bDelta && (iAttr & dsRecModified))
                  {
                     bBlank = fldIsUnChanged; // BLANK_NOTCHANGED;
                     goto PutBlank; //
                  }

                  if (!pDs->bDelta && iAttr && !(iAttr & dsRecOrg) && !(iAttr & dsRecNew) && (iAttr & dsRecDeleted))
                  { // Don't know the purpose of this, but cannot set blank if it has children
                     UINT iCnt = 0;
                     pUINT32 piRecNos;
                     pLTABLEEntry pLEntry = pDs->pLinkedTables->Find(i+1); // Optimize this
                     // Get Cnt, given SetID
                     GetRowCountForSetID(pLEntry, bRemUnused, iSetID, &iCnt, &piRecNos);
                     if (iCnt == 0)
                     {
                        bBlank = fldIsUnChanged; // BLANK_NOTCHANGED;
                        goto PutBlank; //
                     }
                  }
                  if (iSetID & dsDELAYEDBIT)
                  {
                     UINT32 iValue;
                     if (pDs->iXmlMode)
                     {
                        rslt = DBIERR_XMLNODELAYEDFETCHING;
                        goto Exit;
                     }

                     iValue = dsDELAYEDBIT; // (-1)
                     // Put record count
                     rslt = pPi->PutField(fldIsChanged, sizeof(UINT32), (pBYTE) &iValue);
                  }
                  else
                  {
                     UINT iCnt = 0; // Number of nested records!
                     pLTABLEEntry pLEntry;
                     DSBASE *pDsDet;
                     pUINT32 piRecNos;
                     UINT32 iValue;

                     // Find detail DS for fieldID
                     pLEntry = pDs->pLinkedTables->Find(i+1); // Optimize this
                     pDsDet = pLEntry->pDsDet;

                     // Get Cnt, given SetID
                     rslt = GetRowCountForSetID(pLEntry, bRemUnused, iSetID, &iCnt, &piRecNos);
                     iValue = iCnt;
                     iLen = sizeof(UINT32);
                     // Put record count
                     rslt = pPi->PutField(fldIsChanged, iLen, (pBYTE) &iValue);
                     if (rslt)
                        goto Exit;
                     rslt = StreamRows(pDsDet, pPi, iCnt, iSetID, bRemUnused, piRecNos);
                  }
               }break; // TABLE

            case fldBLOB:
               { // special treatment
                  pBYTE pBlob = NULL;
                  UINT32 iBlobId = *(pUINT32)pValue;

                  if (pDs->iXmlMode && iBlobId & dsDELAYEDBIT)
                  {
                     rslt = DBIERR_XMLNODELAYEDFETCHING;
                     goto Exit;
                  }
                  if (pDs->bDelta && iBlobId & dsDELAYEDBIT)
                  { // Is this correct ?
                     bBlank = fldIsUnChanged;
                     goto PutBlank; //
                  }
                  if (iBlobId && (iAttr & dsRecModified) && !pDs->bDelta)
                  {
                     UINT32 iBlobIdPrev;
                     BOOL bBlankPrev = 0;

                     GetPrevId(pDs, iVRowNo, i+1, &iBlobIdPrev, &bBlankPrev);
                     if (bBlankPrev == BLANK_NOTCHANGED || iBlobIdPrev == iBlobId)
                     {
                        if (pDs->pDsLog && iBlobIdPrev!= iBlobId) // bBlankPrev must then be == BLANK_NOTCHANGED
                        {
                           UINT32 iRecNoOrg;
                           pDs->pDsLog->GetOrgUpd(iVRowNo, &iRecNoOrg);
                           if (iRecNoOrg)
                           {
                              BOOL bBlankOrg = FALSE;
                              pDs->GetFieldPtr(iRecNoOrg, i+1, NULL, &bBlankOrg);
                              if (bBlankOrg == BLANK_NOTCHANGED) // Original record was not initialized
                                 goto SpecialIgnCase;
                           }
                        }
                        bBlank = fldIsUnChanged;
                        goto PutBlank; //
                     }
                  }
               SpecialIgnCase:
                  // Check attribute : if modified, put blank ==fldIsUnchanged, if it applies
                  rslt = pDs->pDsBlobs->GetBlobInfo(iBlobId, &iLen, &pBlob);
                  if ((!rslt && iLen && pBlob) || (iLen & dsDELAYEDBIT)) // (if dssDELAYEDBLOB, pBlob is NULL
                  {
                     rslt = pPi->PutField(fldIsChanged, iLen, pBlob);
                  }
               }break; // Blob

            default:
               {
                  UINT32 iFldLen = 0;

                  if (iFldType == fldZSTRING) // Varying type
                  { // Need to find length
                     iFldLen = LdStrLen(pValue);
                     if (iFldLen == 0)
                     {
                        iFldLen = 1; // Fix, send a zero!
                        // goto PutBlank;
                     }
                  }
                  else
                  {
                     if (iFldType == fldVARBYTES || iFldType == fldUNICODE)
                     {
                        iFldLen = (UINT32) *(pUINT16)pValue;
                        if (iFldLen > pFieldDesc[i].iUnits1)
                        {
                           iFldLen = pFieldDesc[i].iUnits1; // Truncate it (application error just to prevent crash)
                        }
                        // iFldLen does not contain length of prefix

                        CopyMem(pDs->pFldBufScratch, &pValue[sizeof(UINT16)], iFldLen);
                        pValue = pDs->pFldBufScratch;
                        // iFldLen += sizeof(UINT16); // Correct ?
                     }
                  }
                  rslt = pPi->PutField(fldIsChanged, iFldLen, pValue);
               }break; // Default
            } // Switch
         }
         // EndSwitch:
         if (rslt)
            goto Exit;
      } // for each field
   } // for each record

Exit:
   return rslt;
}

DBIResult AddFldOptParams(pDSFLDDesc pFldDesc, DSDATAPACKET *pPi)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iPCKLType;
   // UINT16 iValue;

   if (pFldDesc->iFldSubType)
   { // Add subtype
      CHAR szSubType[255];
      pCHAR pStr;

      iPCKLType = dsfldZSTRING << dsSizeBitsLen;
      iPCKLType |= sizeof(UINT16) + dsVaryingFldType;
      if (SubTypeToStr(pFldDesc->iFldSubType, &pStr) == DBIERR_NONE)
      {
         LdStrCpy(szSubType+sizeof(UINT16), pStr);
         *(pUINT16)szSubType = (UINT16)(LdStrLen(pStr) + 1);
         rslt = pPi->AddAttribute(fldAttrArea, szSUBTYPE, iPCKLType, LdStrLen(pStr) + 1+sizeof(UINT16), (pBYTE)
            szSubType);
         if (rslt)
            return rslt;
      }
   }
   if (pFldDesc->iUnits2)
   {
      if (pFldDesc->iFldType != fldADT && pFldDesc->iFldType != fldARRAY)
      { // Add decimals
         iPCKLType = dsfldUINT << dsSizeBitsLen;
         iPCKLType |= sizeof(UINT16);
         rslt = pPi->AddAttribute(fldAttrArea, szDECIMALS, iPCKLType, sizeof(UINT16), (pBYTE) &pFldDesc->iUnits2);
         if (rslt)
            return rslt;
      }
      // else : iunits2 ?
   }
   if (pFldDesc->iUnits1)
   {
      if (pFldDesc->iFldType == fldZSTRING ||
          pFldDesc->iFldType == fldVARBYTES ||
          pFldDesc->iFldType == fldUNICODE ||
          pFldDesc->iFldType == fldBLOB ||
          pFldDesc->iFldType == fldFMTBCD ||
          pFldDesc->iFldType == fldBCD)
      { // Add width
         iPCKLType = dsfldUINT << dsSizeBitsLen;
         iPCKLType |= sizeof(UINT16);
         rslt = pPi->AddAttribute(fldAttrArea, szWIDTH, iPCKLType, sizeof(UINT16), (pBYTE) &pFldDesc->iUnits1);
         if (rslt)
            return rslt;
      }
      else if (pFldDesc->iFldType == fldADT || pFldDesc->iFldType == fldARRAY)
      {
         // iPCKLType = dsfldUINT << dsSizeBitsLen;
         // iPCKLType |= sizeof(UINT16);
         // rslt = pPi->AddAttribute(fldAttrArea,
         // szELEMENTS, iPCKLType, sizeof(UINT16), (pBYTE) &pFldDesc->iUnits1);
         // if (rslt)
         // return rslt;
      }
   }
   if (pFldDesc->bCalculated && !(pFldDesc->iFldAttr & fldAttrLINK))
   {
      UINT16 bCalculated = TRUE; // 1 instead of 2!
      iPCKLType = dsfldUINT << dsSizeBitsLen;
      iPCKLType |= sizeof(UINT16);
      rslt = pPi->AddAttribute(fldAttrArea, szCALCULATED, iPCKLType, sizeof(UINT16), (pBYTE) &bCalculated);
      if (rslt)
         return rslt;
   }
   return rslt;
}

DBIResult AddOptParams(DSOPTPARAM *pDsOptParams, DSDATAPACKET *pPi, UINT32 iFldNo, pUINT32 piAdded)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;

   if (piAdded)
      *piAdded = 0;
   if (pDsOptParams)
   {
      for (i = 0; i < pDsOptParams->iLast; i++)
      {
         pOPTPARAMEntry pEntry = &pDsOptParams->pEntries[i];

         if (pEntry->iFldNo == iFldNo)
         {
            if (pEntry->iType & dsVaryingFldType)
            {
               UINT32 iLenSize = pEntry->iType & dsSizeBitsMask; // 1, 2, 4
               pBYTE pBuf = (pBYTE)DsMalloc(pEntry->iLen + iLenSize);

               if (iLenSize == 1)
                  pBuf[0] = (BYTE)pEntry->iLen;
               else if (iLenSize == 2)
                  *(pUINT16)pBuf = (UINT16)pEntry->iLen;
               else // iLenSize == 4
                  *(pUINT32)pBuf = (UINT32)pEntry->iLen;
               CopyMem(pBuf+iLenSize, pEntry->pValue, pEntry->iLen);

               rslt = pPi->AddAttribute(iFldNo == 0 ? pcklAttrArea : fldAttrArea, pEntry->pAttr, pEntry->iType,
                  pEntry->iLen + iLenSize, pBuf);

               DsFree(pBuf);
            }
            else
            {
               rslt = pPi->AddAttribute(iFldNo == 0 ? pcklAttrArea : fldAttrArea, pEntry->pAttr, pEntry->iType,
                  pEntry->iLen, pEntry->pValue);
            }
            if (rslt)
               break;
            if (piAdded)
               *piAdded +=1;

         }
      }
   }

   return rslt;
}

DBIResult CheckPickle(SAFEARRAY *pSa)
{
   pBYTE pPickle;

   if (!pSa)
      return DBIERR_NA; // DBIERR_INVALIDPICKLE;

   pPickle = (pBYTE)SAGetPtr((SAFEARRAY*)pSa);
   if (!pPickle)
      return DBIERR_DATAPACKETMISMATCH; // DBIERR_INVALIDPICKLE;

   // if ( ((DSPCKLHDRInfo *) pPickle)->iMagicNo != MAGICCOOKIE &&
   // ((DSPCKLHDRInfo *) pPickle)->iMagicNo != MAGICCOOKIEOLD)
   // {
   // SARelPtr ((SAFEARRAY *)pSa);
   // return DBIERR_DATAPACKETMISMATCH; //DBIERR_INVALIDPICKLE;
   // }
   // if ( ((DSPCKLHDRInfo *) pPickle)->iMagicNo != MAGICCOOKIEOLD &&
   //
   // (((DSPCKLHDRInfo *) pPickle)->iMinorVer > MAX_PICKLEVERSION ||
   // ((DSPCKLHDRInfo *) pPickle)->iMajorVer > MAX_PICKLEVERSION))
   // {
   // SARelPtr ((SAFEARRAY *)pSa);
   // return DBIERR_DATAPACKETMISMATCH; //DBIERR_INVALIDPICKLEVERSION;
   // }
   SARelPtr((SAFEARRAY*)pSa);
   return DBIERR_NONE;
}

DBIResult DBIFN DSBASE::AppendData( // Appends data from pickle to dataset
   SAFEARRAY *pPickle, // 'Partial pickle'
   BOOL bEof // This is 'last' pickle, which makes dataset complete
   )
{
   DBIResult rslt;
   BOOL bDisableLogSave = bDisableLog;
   DSEXTRACT *pUP;
   pBYTE pRecBuf = NULL;

   LOCK();
   if (pPickle)
   {
      rslt = CheckPickle(pPickle);
      if (rslt)
         goto Exit;
   }
   else
      bEof = TRUE; // By definition

   if (bPartial == -1)
   {
      // Future ..This is the first pickle!
      // Get internal record buffer
      if (pAuxRecBuf == NULL && (pAuxRecBuf = new BYTE[iRecordSize]) == NULL)
      {
         rslt = DBIERR_NOMEMORY;
         goto Exit;
      }
      rslt = MakeInMem(pPickle /* , bEof */ ); // Creates pickle object
      if (rslt == DBIERR_NONE && bEof) // bPartial is now TRUE
      {
         goto Eof; // Release Pickle, set bPartial == FALSE
      }
      goto Exit;
   }

   if (bPartial == FALSE)
   {
      if (pDsExtract == NULL) // Equivalent to making it partial using SetProp
      {
         if (pDsExtractSave)
         {
            pDsExtract = pDsExtractSave;
            pDsExtractSave = NULL;
            bPartial = TRUE;
         }
      }
   }

   // If partial pickle, we must have pickle object!
   if ((pUP = pDsExtract) == NULL)
   {
      rslt = DBIERR_CANNOTAPPEND; // Invalid context
      goto Exit;
   }

   // Get all records

   bDisableLog = TRUE; // Don't log additions

   if (pPickle)
   {
      rslt = pUP->AddDataPacket(pPickle);
      if (rslt)
         goto Exit;
      if (pUP->iProperties & pcklpropsCONTAINMETALEN && pUP->iRows == 0)
      { // Special case (also fixed in dspickle.cpp)
         SARelPtr((SAFEARRAY*)pPickle);
         goto Exit;
      }

      if (pUP->iProperties & pcklpropsMETADATA_INCL && !(pUP->iProperties & pcklpropsCONTAINMETALEN))
      // (otherwise, skip  header)
      {
         if (pUP->iRows != 0) // If 0, it does not matter!
         {
            rslt = DBIERR_DATAPACKETMISMATCH; // Pickle- miscmatch
            goto Exit;
         }
      }

      rslt = ReadRows(this, pUP, pUP->iRows, 0, TRUE, NULL);
      if (rslt)
         goto Exit;
   }

Eof:
   // End of pickle reached
   if (bEof)
   {
      bPartial = FALSE;
      pDsExtractSave = pDsExtract; // Save it!
      pDsExtract = NULL;
   }

Exit:
   bDisableLog = bDisableLogSave; // Restore
   if (pRecBuf)
      delete pRecBuf;
   UNLOCK();
   return rslt;
}

// BlobId, and SetId
DBIResult DBIFN GetPrevId(DSBASE *pDs, UINT32 iRowNo, UINT32 iFieldID, pUINT32 piBlobIdPrev, pBOOL pbBlankPrev)
{
   UINT32 iRowNoPrev;
   DBIResult rslt = DBIERR_NA;

   *piBlobIdPrev = 0;

   if (pDs->pDsLog)
   {
      iRowNoPrev = pDs->pDsLog->GetPrevRecNo(iRowNo);
      if (iRowNoPrev)
      {
         *pbBlankPrev = 0; // Only reset blank here
         rslt = pDs->GetField(iRowNoPrev, iFieldID, (pBYTE)piBlobIdPrev, pbBlankPrev);
      }
   }
   return rslt;
}

// Currently reading a fielddescriptor for a nested table. The optional parameters
// for this table are the fieldoptional parameters for this field (which is
// reversed compared to a normal table).
DBIResult DBIFN CreateEmbeddedTable(DSBASE *pDs, DSEXTRACT *pUP, UINT32 iFieldIdDP, pDSFLDDesc pFieldDescDP
   // FieldDescriptor for embedded table
   )
{
   DBIResult rslt = DBIERR_NONE;
   DSBASE *pDsDet = NULL;

   UNREFERENCED_PARAMETER(iFieldIdDP);

   // Create empty DS
   pDsDet = new DSBASE();
   if (pDsDet == NULL)
   {
      rslt = DBIERR_NOMEMORY;
      goto Exit;
   }
   pDsDet->AddRef();

   pDsDet->iXmlMode = pDs->iXmlMode;
   pDsDet->bUTF8METADATA = pDs->bUTF8METADATA;
   pDsDet->iANSICodePage = pDs->iANSICodePage;
   // Read metadata of embedded table
   rslt = pDsDet->ReadMetaData(pUP, pFieldDescDP->iUnits1);
   if (rslt)
      goto Exit;

   // Link and initialize table
   rslt = InitEmbeddedTable(pDs, pDsDet, 0 /* wrong */ );
   if (rslt)
      goto Exit;

Exit:
   if (rslt)
   {
      if (pDsDet)
         delete pDsDet;
   }
   return rslt;
}

DBIResult DBIFN InitEmbeddedTable(DSBASE * pDs, DSBASE * pDsDet, UINT32 iFieldID_M // Master fieldID
   )
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iFieldID_Link = 0;
   DSFLDDesc FldDesc_SetID;
   UINT32 i;

   for (i = 0; i < pDsDet->iFields; i++)
   {
      if (pDsDet->pFieldDesc[i].iFldAttr & fldAttrLINK) // (Only ONE linkfield per table!)
      {
         iFieldID_Link = i+1;
         break;
      }
   }

   if (iFieldID_Link == 0)
   { // Add Field for SetID
      ZeroMem(&FldDesc_SetID, sizeof(DSFLDDesc));
      LdStrCpy(FldDesc_SetID.szName, szLINK_FIELD);
      FldDesc_SetID.iFldType = fldUINT32; // Could make it 'unkown'
      FldDesc_SetID.iFldAttr = fldAttrHIDDEN | fldAttrLINK;
      FldDesc_SetID.bCalculated = TRUE;
      // Adding the linking field is causing the iAutoIncField
      // to be set in pDsDet.  This does not normally happen as part of the initialization of
      // the fields from the metadata from the provider, it only occurs when you create a
      // dataset dynamically in code (TClientDataSet.CreateDataSet).  Fix below is to save
      // and restore the pDsDet->iAutoIncField value.
      UINT iAutoIncSave = pDsDet->iAutoIncField;
      rslt = pDsDet->AddField(&FldDesc_SetID);
      if (rslt)
         goto Exit;
      iFieldID_Link = pDsDet->iFields; // (last field)
      pDsDet->iAutoIncField = iAutoIncSave;
   }

   rslt = AddSetIDToIndexes(pDsDet, iFieldID_Link, NULL, TRUE);
   if (rslt)
      goto Exit;

   // Link tables together
   if (pDs->pLinkedTables == NULL)
      pDs->pLinkedTables = new LTABLEList(pDs);

   // FieldID of master not known yet
   pDs->pLinkedTables->Link(pDsDet, iFieldID_M, iFieldID_Link, &pDsDet->iDetID); // (FieldID is incorrect anyway)

   pDsDet->pDsParent = pDs; // Link detail to master
   pDs->iMDSemantics |= mdMASTER_DEFAULT; // + mdCASCADEDEL + mdCASCADEMOD;
   pDsDet->iMDSemantics |= mdDETAIL_DEFAULT;

Exit:
   return rslt;
}

DBIResult DBIFN GetRowCountForSetID(pLTABLEEntry pLEntry, BOOL bRemUnused, UINT32 iSetID, pUINT piCnt,
   pUINT32 *ppiRecNos)
{
   DBIResult rslt = DBIERR_NONE;
   pUINT32 piSetIDs;
   UINT32 iNos = pLEntry->pDsDet->iRecNoNext -1;
   UINT32 i, iCnt = 0;
   UINT32 iSetIDCol;

   if (iNos > pLEntry->piRecNosSize)
   {
      if (pLEntry->piRecNos)
         delete[] pLEntry->piRecNos;
      pLEntry->piRecNos = new UINT32[iNos];
      if (pLEntry->piRecNos == NULL)
      {
         rslt = DBIERR_NOMEMORY;
         goto Exit;
      }
      pLEntry->piRecNosSize = iNos;
   }
   iSetIDCol = pLEntry->pDsDet->iFieldID_SetIDD;
   piSetIDs = (pUINT32)pLEntry->pDsDet->ppColumns[iSetIDCol-1];
   for (i = 0; i < iNos; i++)
   {
      if (piSetIDs[i] == iSetID)
      {
         DSAttr iAttr = pLEntry->pDsDet->piAttr[i];
         // Carefull! Same code as in StreamRows.
         if (bRemUnused && iAttr)
         {
            if (iAttr & dsUnused)
               continue;
            if ((iAttr & dsISNOTVISIBLE) && pLEntry->pDsDet->bDisableLog && !pLEntry->pDsDet->bDelta)
               continue;
         }
         pLEntry->piRecNos[iCnt++] = i+1; // RecNo
      }
   }
Exit:
   *ppiRecNos = pLEntry->piRecNos;
   *piCnt = iCnt;
   return rslt;
}

// Allocates a buffer
DBIResult DBIFN GetByteBuffer(UINT32 iSize, pBYTE *ppBuf, BOOL bZero)
{
   if (ppBuf && iSize)
   {
      *ppBuf = new BYTE[iSize];
      if (*ppBuf == NULL)
         return DBIERR_NOMEMORY;
      if (bZero)
         ZeroMem(*ppBuf, iSize);
   }
   return DBIERR_NONE;
}

DBIResult DBIFN AddChangeIndex(pDSBASE pDs, BOOL bWalkTree)
{
   DBIResult rslt = DBIERR_NONE;

   if (!pDs->bDelta) // Create change index (if not read-only)
   {
      DSIDXDesc IdxDescChange;

      if (pDs->pDsLog == NULL)
         pDs->pDsLog = new DSLOG(0, pDs);

      if (pDs->pIdxChg == NULL) // Could it be already defined ?
      {
         // Create Change index
         ZeroMem(&IdxDescChange, sizeof(DSIDXDesc));
         LdStrCpy(IdxDescChange.szName, szCHANGEINDEX);
         pDs->pIdxChg = new DSIDXCHG(pDs); // Create default order
         rslt = pDs->pIdxChg->IdxCreateOrder(&IdxDescChange, NULL); // Use
         if (rslt)
         {
            delete pDs->pIdxChg;
            pDs->pIdxChg = NULL;
         }
         else
         {
            pDs->AddIndex(pDs->pIdxChg); // Make it maintained
         }
         if (bWalkTree && pDs->pLinkedTables)
         {
            UINT32 i;

            for (i = 0; i < pDs->pLinkedTables->iLast; i++)
            {
               pLTABLEEntry pEntry = pDs->pLinkedTables->GetEntry(i+1);
               rslt = AddChangeIndex(pEntry->pDsDet, TRUE);
               if (rslt)
                  break;
            }
         }
      }
   }
   return rslt;
}

DBIResult SetDelta(DSBASE *pDs, BOOL bVal)
{
   DBIResult rslt = DBIERR_NONE;
   pDs->bDelta = bVal;
   if (pDs->pLinkedTables)
   {
      UINT32 i;

      for (i = 0; i < pDs->pLinkedTables->iLast; i++)
      {
         pLTABLEEntry pEntry = pDs->pLinkedTables->GetEntry(i+1);
         if (pEntry->pDsDet)
            SetDelta(pEntry->pDsDet, bVal);
      }
   }
   return rslt;
}
