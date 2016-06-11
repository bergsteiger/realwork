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
#if !defined(__ANDROID__)
#include <iconv.h>
#endif
#include "conv.h"
#else
#include <windows.h>
#endif
#include <string.h>
#pragma hdrstop

#include "filter.h"
#include "alchemy.h"
#include "alc_ds.h"
#include "ossrv.h"

#include "dsconst.h"
#include "dspickle.h"

VOID ExtractType(
   UINT32 iTypeDesc,
   pUINT32 piType,
   pUINT32 piElementSize,
   pUINT32 piPrefixSize, // size of prefix (1,2,4) or 0 if not varying
   pBOOL pbArray         // True if array (32-bit counter) follows
   );

// Caches optional parameters

DSOPTPARAM::DSOPTPARAM(DSBASE *pDs)
{
   this->pDs = pDs;
   iSize = 0;
   iLast = 0;
   pEntries = NULL;
}

DSOPTPARAM::~DSOPTPARAM()
{
   UINT32 i;

   if (pEntries)
   {
      for (i = 0; i < iLast; i++)
      {
         delete[] pEntries[i].pAttr;  // Free attribute
         delete[] pEntries[i].pValue; // Free attribute value
      }
      DsFree(pEntries);
   }
   pEntries = NULL;
}

DBIResult DSOPTPARAM::Grow(UINT32 iEntries) // Grow size
{
   pBYTE pTmp;

   pTmp = (pBYTE)DsRealloc((pVOID)pEntries,
      sizeof(OPTPARAMEntry) * iSize, sizeof(OPTPARAMEntry) * (iSize + iEntries));
   if (!pTmp)
      return DBIERR_NOMEMORY;
   pEntries = (OPTPARAMEntry*)pTmp;
   iSize += iEntries;
   return DBIERR_NONE;
}

DBIResult DSOPTPARAM::Add(UINT32 iPacketTypes, UINT32 iFldNo, UINT32 iType, UINT32 iLen, pCCHAR pAttr, pBYTE pValue)
{
   DBIResult rslt = DBIERR_NONE;
   pOPTPARAMEntry pEntry;

   if (iLast >= iSize)
   {
      rslt = Grow(10);
      if (rslt)
         goto Exit;
   }

   UINT32 iDsType;
   UINT32 iElementSize;
   pBYTE uBuf;

   ExtractType(iType, &iDsType, &iElementSize, NULL, NULL);

   uBuf = NULL;
   if (iDsType == dsfldUNICODE)
   {
#ifdef _UNIX
#if defined(__ANDROID__)
      UErrorCode status = U_ZERO_ERROR;
      INT32 uLen;
      pu_strToUTF8(NULL, 0, &uLen, (const UChar *)pValue, -1, &status);

      //Reset buffer overflow error that may have occurred during pre-flighting
      status = U_ZERO_ERROR;

      if (uLen != 0)
      {
         uBuf = (pBYTE) malloc((uLen+1) * sizeof(BYTE));
         pu_strToUTF8((pCHAR)uBuf, uLen, NULL, (const UChar *)pValue, -1, &status);
      }
#else
      size_t srcsize = (WideStrLen((pUCS2Char)pValue)+1) * sizeof(ucs2char_t);
      int uLen = (WideStrLen((pUCS2Char)pValue)+1) * 4;
      size_t rstsize = uLen;
      pCHAR pSrc = (pCHAR)pValue;
      iconv_t cdesc = iconv_open("UTF-8", "UTF-16LE");
      uBuf = (pBYTE)malloc(rstsize);
      pCHAR pRst = (pCHAR)uBuf;
      iconv(cdesc, &pSrc, (size_t*)&srcsize, &pRst, (size_t*)&rstsize);
      iconv_close(cdesc);
#endif
#else
      // UNICODE -> UTF8
      // pValue points null-terminated-wchar_t string.
      // iLen include wchar_t-NULL terminator (2 bytes)
      // and iLen is a number of bytes, not number of char.
      int uLen = WideCharToMultiByte(CP_UTF8, 0, (wchar_t*)pValue, iLen / 2, NULL, 0, NULL, NULL);
      uBuf = (unsigned char*)malloc(uLen); // uLen contains NULL terminator byte.
      WideCharToMultiByte(CP_UTF8, 0, (wchar_t*)pValue, iLen / 2, reinterpret_cast<LPSTR>(uBuf), uLen, NULL, NULL);
#endif
      iLen = uLen;
   }

   pEntry = &this->pEntries[iLast];
   pEntry->iPacketTypes = iPacketTypes;
   pEntry->iFldNo = iFldNo;
   pEntry->iType = iType;
   pEntry->iLen = iLen;
   pEntry->pAttr = new CHAR[LdStrLen(pAttr)+1];
   LdStrCpy(pEntry->pAttr, pAttr);
   pEntry->pValue = new BYTE[iLen];
   if (uBuf)
      CopyMem(pEntry->pValue, uBuf, iLen);
   else
      CopyMem(pEntry->pValue, pValue, iLen);
   iLast++;
   if (uBuf)
      free(uBuf);
Exit:
   return rslt;
}

DBIResult DSOPTPARAM::Drop(UINT32 iEntry)
{
   DBIResult rslt = DBIERR_NONE;
   INT32 iDel;
   iDel = iLast-iEntry;
   pOPTPARAMEntry pEntry = &this->pEntries[iEntry];
   if (pEntry->pAttr)
      delete[] pEntry->pAttr;
   if (pEntry->pValue)
      delete[] pEntry->pValue;

   if (iDel>0)
   {
      CopyMem(pEntry, &this->pEntries[iEntry+1], iDel*sizeof(OPTPARAMEntry));
   }
   iLast--;
   return rslt;
}

DBIResult DBIFN DSBASE::AddFldOptParameter( // Adds optional parameter to dataset
   UINT32 iFldNo, // 0 if not field attribute
   pCCHAR szAttr, // ptr to name
   UINT32 iPCKLType, // type
   UINT32 iAttrLen, // length
   pBYTE pValue, // ptr to value
   pDSFLDDesc pFldDesc // Pointer to fielddesc, if any
   )
{
   DBIResult rslt = DBIERR_NONE;
   INT32 iAttr;
   BOOL bDontCache = FALSE; // Default : cache
   pBYTE pBufTmp = pValue;
   UINT32 iPacketTypes = dsPACKET_NORMAL;
   BOOL bArray;
   UINT32 iPrefixSize; // 1,2,4 if varying type
   UINT32 iElementSize;
   UINT32 iDsType;
   pDSFLDDesc pFieldDesc;

   LOCK();

   if (pFldDesc == NULL && iFldNo > iFields)
   {
      rslt = DBIERR_NA;
      goto Exit;
   }

   pFieldDesc = pFldDesc == NULL ? &this->pFieldDesc[iFldNo-1] : pFldDesc;

   iAttr = OptStrToNumber(szAttr);
   ExtractType(iPCKLType, &iDsType, &iElementSize, &iPrefixSize, &bArray);

   if (iPCKLType & dsIncInDelta)
      iPacketTypes = dsPACKET_ROUNDTRIP; // Return in delta (and request)
   if (iAttr == -1)
      goto Next; // Unknown, cache it

   switch(iAttr)
   {
      // Field-options, don't cache, add when streaming!
   case PreDECIMALS:
      pFieldDesc->iUnits2 = (iElementSize == sizeof(UINT16)) ? *((UINT16*)pBufTmp) : *((UINT32*)pBufTmp);
      bDontCache = TRUE;
      iPacketTypes = dsPACKET_ALL;
      break;
      // Field-options, don't cache, add when streaming!
   case PreWIDTH:
   case PreELEMENTS: // OR
      pFieldDesc->iUnits1 = (iElementSize == sizeof(UINT16)) ? *((UINT16*)pBufTmp) : *((UINT32*)pBufTmp);
      bDontCache = TRUE;
      iPacketTypes = dsPACKET_ALL;
      break;

   case PreTYPENAME: // Used when resolving
      iPacketTypes |= dsPACKET_ROUNDTRIP;
      break;

   case PreCALCULATED:
      pFieldDesc->bCalculated = (iElementSize == sizeof(UINT16)) ? *((UINT16*)pBufTmp) : *((UINT32*)pBufTmp);
      bDontCache = TRUE;
      iPacketTypes = dsPACKET_ALL;
      break;

      // Field-options, don't cache, add when streaming!
   case PreSUBTYPE:
      {
         UINT32 iSubType = 0;

         if (iDsType != dsfldZSTRING)
         {
            rslt = DBIERR_INVALIDPARAM;
            goto Exit;
         }
         if (StrToSubType((pCHAR)pBufTmp, &iSubType) == DBIERR_NONE)
         {
            bDontCache = TRUE;
         }
         else
         {
            // If not found, cache it
            iSubType = fldstUNKNOWN;
            bDontCache = FALSE;
         }
         pFieldDesc->iFldSubType = iSubType;
         if (iSubType == fldstAUTOINC)
            pFieldDesc->iFldAttr |= fldAttrREADONLY;
         iPacketTypes = dsPACKET_ROUNDTRIP;
         break;
      }
   default:
      break;
   }
Next:
   if (!bDontCache)
   {
      if (pDsOptParams == NULL)
         pDsOptParams = new DSOPTPARAM(this);
      rslt = pDsOptParams->Add(iPacketTypes, iFldNo, iPCKLType, iAttrLen, szAttr, pValue);
   }
Exit:
   UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::AddOptParameter( // Adds optional parameter to dataset
   UINT32 iFldNo, // 0 if not field attribute
   pCCHAR szAttr, // ptr to name
   UINT32 iPCKLType, // type
   UINT32 iAttrLen, // length
   pBYTE pValue // ptr to value
   )
{
   DBIResult rslt = DBIERR_NONE;
   INT32 iAttr;
   BOOL bDontCache = FALSE;
   pBYTE pBufTmp = pValue;
   UINT32 i;
   UINT32 iPacketTypes = dsPACKET_NORMAL;
   BOOL bArray;
   UINT32 iPrefixSize; // 1,2,4 if varying type
   UINT32 iElementSize;
   UINT32 iDsType;

   LOCK();
   if (iFldNo)
   {
      rslt = AddFldOptParameter(iFldNo, szAttr, iPCKLType, iAttrLen, pValue, &pFieldDesc[iFldNo-1]);
      goto Exit;
   }
   iAttr = OptStrToNumber(szAttr);

   ExtractType(iPCKLType, &iDsType, &iElementSize, &iPrefixSize, &bArray);
   if (iPCKLType & dsIncInDelta)
      iPacketTypes = dsPACKET_ROUNDTRIP; // Return in delta (and request)

   if (iAttr == -1)
      goto Next; // Unknown, cache it

   switch(iAttr)
   {
   case PrePRIMARY_KEY:
      // iPacketTypes |= dsPACKET_ROUNDTRIP; // Return in delta

   case PreUNIQUE_KEY:
      // Create unique order (could be more than one)
      {
         DSIDXDesc UniIdxDesc; // Default order

         if (!bArray)
         {
            rslt = DBIERR_INVALIDPARAM;
            goto Exit;
         }
         ZeroMem(&UniIdxDesc, sizeof(DSIDXDesc));
         UniIdxDesc.iFields = *((pUINT32)pBufTmp); // (depends on type)
         pBufTmp += sizeof(UINT32);
         for (i = 0; i < UniIdxDesc.iFields; i++)
         {
            UniIdxDesc.iKeyFields[i] = (iElementSize == sizeof(UINT16)) ?
                                       (UINT32) *((pUINT16)pBufTmp)     :
                                       (UINT32) *((pUINT32)pBufTmp);
            if (UniIdxDesc.iKeyFields[i] & dskeyDESCENDING)
            {
               UniIdxDesc.bDescending[i] = TRUE;
               UniIdxDesc.iKeyFields[i] &= ~(dskeyDESCENDING);
            }
            if (UniIdxDesc.iKeyFields[i] & dskeyCASEINSENSITIVE)
            {
               UniIdxDesc.bCaseInsensitive[i] = TRUE;
               UniIdxDesc.iKeyFields[i] &= ~(dskeyCASEINSENSITIVE);
            }

            pBufTmp += (iElementSize == sizeof(UINT16)) ? sizeof(UINT16) : sizeof(UINT32);
         }
         UniIdxDesc.bUnique = iAttr == PrePRIMARY_KEY? 2 : TRUE;
         if (pIdxDef)
         { // Check if same index
            pDSIDXDesc pDefIdx = &pIdxDef->IdxDesc;

            if (pDefIdx->iFields == UniIdxDesc.iFields)
            {
               for (i = 0; i < UniIdxDesc.iFields; i++)
               {
                  if (UniIdxDesc.iKeyFields[i] != pDefIdx->iKeyFields[i])
                  {
                     goto NotSame;
                  }
                  if (UniIdxDesc.bCaseInsensitive[i] != pDefIdx->bCaseInsensitive[i])
                  {
                     goto NotSame;
                  }
               }
               pDefIdx->bUnique = UniIdxDesc.bUnique;
            }
            else
               goto NotSame;
         }
         else
         {
         NotSame: // Tack on the primary key fields to the end of the default order to make
            // sure it is unique.
            if (UniIdxDesc.szName[0] == 0)
               strcpy(UniIdxDesc.szName, iAttr == PrePRIMARY_KEY?szPRIMARY_KEY : szUNIQUE_KEY);
            rslt = CreateIndex(&UniIdxDesc);
            if (iAttr == PrePRIMARY_KEY && pIdxDef && pIdxDef->IdxDesc.bUnique == FALSE && pIdxDef->IdxDesc.iFields > 0)
            {
               DSIDXDesc pDefIdx;
               UINT32 iDefFlds;
               UINT32 i;

               CopyMem(&pDefIdx, &pIdxDef->IdxDesc, sizeof(DSIDXDesc));
               iDefFlds = pDefIdx.iFields;
               if (iDefFlds+UniIdxDesc.iFields<=16)
               {
                  // check if the field is already in the default order
                  // before appending it to the end.
                  UINT32 j, cntInc = 0, lenInc = 0;
                  for (i = 0; i<UniIdxDesc.iFields; i++)
                  {
                     BOOL bDup = FALSE;
                     for (j = 0; j<iDefFlds && !bDup; j++)
                     {
                        bDup = (pDefIdx.iKeyFields[j] == UniIdxDesc.iKeyFields[i]);
                     }
                     if (bDup)
                        continue;
                     pDefIdx.iKeyFields[iDefFlds+cntInc] = UniIdxDesc.iKeyFields[i];
                     pDefIdx.bDescending[iDefFlds+cntInc] = UniIdxDesc.bDescending[i];
                     pDefIdx.bCaseInsensitive[iDefFlds+cntInc] = UniIdxDesc.bCaseInsensitive[i];
                     cntInc++;
                     lenInc += pFieldDesc[UniIdxDesc.iKeyFields[i]-1].iFldLen;
                  }
                  pDefIdx.iFields+=cntInc;
                  pDefIdx.iKeyLen+=lenInc;
                  pDefIdx.bUnique = TRUE;
                  rslt = pIdxDef->IdxCreateOrder(&pDefIdx, NULL); // Overwrite
               }
            }
            // if (rslt == DBIERR_NONE)
            // FindIndex(szDEFAULT_ORDER, &pIdxDef);

         }
      }
      // bForDelta = TRUE;
      // bDontCache = TRUE;
      break;
   case PreDEFAULT_ORDER:
      // Create default order
      // NOTE: should overwrite ?
      // if (pIdxDef == NULL) // If first one
      { // <iflds><fld1><ifld2><ifld3>
         DSIDXDesc DefIdxDesc; // Default order

         if (!bArray)
         {
            rslt = DBIERR_INVALIDPARAM;
            goto Exit;
         }
         ZeroMem(&DefIdxDesc, sizeof(DSIDXDesc));

         LdStrCpy(DefIdxDesc.szName, szDEFAULT_ORDER);
         DefIdxDesc.iFields = *((pUINT32)pBufTmp); // (depends on type)
         pBufTmp += sizeof(UINT32);
         for (i = 0; i < DefIdxDesc.iFields; i++)
         {
            DefIdxDesc.iKeyFields[i] = (iElementSize == sizeof(UINT16)) ? (UINT32) *((pUINT16)pBufTmp) : (UINT32) *
               ((pUINT32)pBufTmp);
            if (DefIdxDesc.iKeyFields[i] & dskeyDESCENDING)
            {
               DefIdxDesc.bDescending[i] = TRUE;
               DefIdxDesc.iKeyFields[i] &= ~(dskeyDESCENDING);
            }
            if (DefIdxDesc.iKeyFields[i] & dskeyCASEINSENSITIVE)
            {
               DefIdxDesc.bCaseInsensitive[i] = TRUE;
               DefIdxDesc.iKeyFields[i] &= ~(dskeyCASEINSENSITIVE);
            }
            pBufTmp += (iElementSize == sizeof(UINT16)) ? sizeof(UINT16) : sizeof(UINT32);
         }
         if (pIdxDef == NULL)
         {
            rslt = CreateIndex(&DefIdxDesc);
            if (rslt == DBIERR_NONE)
               FindIndex(szDEFAULT_ORDER, &pIdxDef);
         }
         else
         {
            rslt = pIdxDef->IdxCreateOrder(&DefIdxDesc, NULL); // Overwrite
         }
      }
      break;

   case PreCHANGE_LOG:
      // Copy Log (if not read-only)
      {
         UINT32 iEntries = *((pUINT32)pBufTmp);
         iEntries = iEntries*sizeof(UINT32)/sizeof(LOGENTRY);
         if (iEntries == 0 || !bArray || iElementSize != sizeof(UINT32))
         {
            rslt = DBIERR_INVALIDPARAM;
            goto Exit;
         }
         pDsLog = new DSLOG(iEntries, this);
         LOGENTRY *pLogEntry = (pLOGENTRY)(pBufTmp+sizeof(UINT32));
         for (i = 0; i < iEntries; i++)
         {
            pDsLog->AddToLog(pLogEntry[i].iRecNo1, pLogEntry[i].iRecNo2, (DSAttr)pLogEntry[i].iAttr, 0);
         }
      }
      bDontCache = TRUE;
      break;
   case PreSERVER_COL:
      break;
   case PreBDEDOMAIN_X:
   case PreBDERECORD_X:
      // Get record constraints
      {
         if (pDsConstr == NULL)
            pDsConstr = new DSCONSTR(this);
         pDsConstr->Add(pBufTmp, iAttrLen, fltSQLEX_CONSTRAINT, NULL);
      }
      break;
   case PreBDEDEFAULT_X:
      {
         if (pDsConstr == NULL)
            pDsConstr = new DSCONSTR(this);
         pDsConstr->Add(pBufTmp, iAttrLen, fltSQLEX_DEFAULT, NULL);
      }
      break;
   case PreDATASET_CONTEXT:
      iPacketTypes |= dsPACKET_ROUNDTRIP; // Return in delta
      break;
   case PreDATASET_DELTA:
   case PreDELTA: // XML-case
      bDelta = TRUE;
      bDisableLog = TRUE;
      iPacketTypes |= dsPACKET_DELTA; // Return in delta
      break;

   case PreLCID:
      iLCID = (UINT32)((iElementSize == sizeof(UINT16)) ? *((UINT16*)pBufTmp) : *((UINT32*)pBufTmp));
      if (!IsValidLocale(iLCID, LCID_INSTALLED))
         iLCID = 0;
      iPacketTypes |= dsPACKET_DELTA; // Return in delta
      break;

   case PreAUTOINCVALUE:
      for (i = 0; i < iFields; i++)
      {
         if (pFieldDesc[i].iFldSubType == fldstAUTOINC && pFieldDesc[i].iFldLen == sizeof(UINT32))
         {
            iAutoIncField = i+1;
            iAutoIncNext = *(UINT32*)pBufTmp;
            break;
         }
      }
      bDontCache = TRUE; // Catch it in streamds.
      break;

   case PreREADONLY:
      bReadOnly = (BOOL)((iElementSize == sizeof(UINT16)) ? *((UINT16*)pBufTmp) : *((UINT32*)pBufTmp));
      iPacketTypes |= dsPACKET_DELTA; // Return in delta
      break;
   case PreTABLENAME:
      iPacketTypes |= dsPACKET_ROUNDTRIP; // Return in delta
      break;
   case PreMD_FIELDLINKS:
      { // <iflds><iFldM><fldML1><ifldML2><ifldDL1><ifldDL2>
         UINT32 piMFields[MAXKEYFIELDS];
         UINT32 piDFields[MAXKEYFIELDS];
         UINT32 iFldCnt, iFldsLink, iFldIDM;

         iFldCnt = *((pUINT32)pBufTmp);
         pBufTmp += sizeof(UINT32); // Counter is always 32-bit for arrays
         iFldIDM = (iElementSize == sizeof(UINT16)) ? (UINT16) *((pUINT16)pBufTmp) : (UINT16) *((pUINT32)pBufTmp);
         pBufTmp += (iElementSize == sizeof(UINT16)) ? sizeof(UINT16) : sizeof(UINT32);
         iFldsLink = (iFldCnt -1)/2;
         for (i = 0; i < iFldsLink; i++)
         {
            piMFields[i] = (iElementSize == sizeof(UINT16)) ? (UINT16) *((pUINT16)pBufTmp) : (UINT16) *
               ((pUINT32)pBufTmp);
            pBufTmp += (iElementSize == sizeof(UINT16)) ? sizeof(UINT16) : sizeof(UINT32);
         }
         for (i = 0; i < iFldsLink; i++)
         {
            piDFields[i] = (iElementSize == sizeof(UINT16)) ? (UINT16) *((pUINT16)pBufTmp) : (UINT16) *
               ((pUINT32)pBufTmp);
            pBufTmp += (iElementSize == sizeof(UINT16)) ? sizeof(UINT16) : sizeof(UINT32);
         }
         if (pFieldDesc[iFldIDM-1].iFldType == fldTABLE && pLinkedTables)
         {
            pLTABLEEntry pEntry = pLinkedTables->Find(iFldIDM);
            if (pEntry)
            {
               pLinkedTables->Link_Fields(pEntry->pDsDet, iFldsLink, piMFields, piDFields, &pEntry->pDsDet->iDetID);
            }
         }
         bDontCache = TRUE; // Apply it in StreamDS
         iPacketTypes |= dsPACKET_REQUEST;
      }break;
   case PreUPDATEMODE:
      {
         iRemoteUpdMode = (iElementSize == sizeof(UINT16)) ? *((UINT16*)pBufTmp) : *((UINT32*)pBufTmp);
         iPacketTypes |= dsPACKET_ROUNDTRIP; // Return in delta
      }break;
   case PreMD_SEMANTICS:
      {
         UINT32 iMD_Sem;
         iMD_Sem = (iElementSize == sizeof(UINT16)) ? *((UINT16*)pBufTmp) : *((UINT32*)pBufTmp);
         if (iMD_Sem & 1)
            iMDSemantics |= mdCASCADEDEL;
         if (iMD_Sem & 2)
            iMDSemantics |= mdCASCADEMOD;
         if (iMD_Sem & 4)
            iMDSemantics |= mdALLOWORPHANS;

      }break;
   case PreBDEDOMAIN_CL:
   case PreBDERECORD_CL:
      // Get record constraints
      {
         if (pDsConstr == NULL)
            pDsConstr = new DSCONSTR(this);
         pDsConstr->Add(pBufTmp, iAttrLen, fltSQLEX_CONSTRAINT, NULL);
      }
      // bForDelta = TRUE;
      bDontCache = TRUE;
      break;
   case PreBDEDEFAULT_CL:
      {
         if (pDsConstr == NULL)
            pDsConstr = new DSCONSTR(this);
         pDsConstr->Add(pBufTmp, iAttrLen, fltSQLEX_DEFAULT, NULL);
      }
      // bForDelta = TRUE;
      bDontCache = TRUE;
      break;
   case PreDISABLE_DELETES:
      { // assumes it is only in if true!
         this->SetProp(dspropDISABLEDELETES, TRUE); // recurse!
      }break;
   case PreDISABLE_INSERTS:
      { // assumes it is only in if true!
         this->SetProp(dspropDISABLEINSERTS, TRUE);
      }break;
   case PreDISABLE_EDITS:
      {
         this->SetProp(dspropDISABLEEDITS, TRUE);
      }break;

   default:
      break;
   }
Next:
   if (!bDontCache)
   {
      if (pDsOptParams == NULL)
         pDsOptParams = new DSOPTPARAM(this);
      rslt = pDsOptParams->Add(iPacketTypes, iFldNo, iPCKLType, iAttrLen, szAttr, pValue);
   }
Exit:
   UNLOCK();
   return rslt;
}

DBIResult DBIFN DSBASE::DropOptParameter( // Returns optional parameter (unknown to dataset)
   UINT32 iFldNo, // 0 if not field attribute
   pCHAR pName // returns ptr to name
   )
{
   DBIResult rslt = DBIERR_OBJNOTFOUND;
   UINT32 i;

   for (i = 0; i < pDsOptParams->iLast; i++)
   {
      if (pDsOptParams->pEntries[i].iFldNo == iFldNo && LdStrCmpi(pName, pDsOptParams->pEntries[i].pAttr) == 0)
      {
         rslt = pDsOptParams->Drop(i);
         break;
      }
   }
   return rslt;
}

DBIResult DBIFN DSBASE::GetOptParameter( // Returns optional parameter (unknown to dataset)
   UINT32 iNo, // Number 1..iOptAttr
   UINT32 iFldNo, // 0 if not field attribute
   ppCHAR ppName, // returns ptr to name
   pUINT32 piType, // returns type
   pUINT32 piLen, // returns length
   ppCHAR ppValue // returns ptr to value
   )
{
   DBIResult rslt = DBIERR_OBJNOTFOUND;
   UINT32 i, iCnt = 0;
   pCHAR pAttr;
   UINT32 iParentID;

   LOCK();
   if (pDsOptParams == NULL)
   {
      goto Exit;
   }

   if (iNo == 0) // Find value for attribute given in ppName, using iFldNo
   {
      if (ppName == NULL || *ppName == 0 || iFldNo > iFields)
      {
         rslt = DBIERR_INVALIDPARAM;
         goto Exit;
      }
      pAttr = *ppName;
   }

   // Convert FldNo, in case it is an array-element

   iParentID = iFldNo;
   while (iFldNo && (iParentID = pFieldDesc[iParentID-1].iFieldIDParent) != 0)
   {
      if (pFieldDesc[iParentID-1].iFldType == fldARRAY)
      { // Find the corresponding element in the first array element (only these fields would contain optional parameters)
         UINT32 iU1 = pFieldDesc[iParentID-1].iUnits1;
         UINT32 iU2 = pFieldDesc[iParentID-1].iUnits2;
         UINT32 iElSize = iU2/iU1; // Number of fields in each element
         UINT32 iElNo = (iFldNo - iParentID -1)/iElSize; // Find the element number

         // Adjust fieldno
         iFldNo = iFldNo - iElNo*iElSize;
         break;
      }
   }

   for (i = 0; i < pDsOptParams->iLast; i++)
   {
      if (pDsOptParams->pEntries[i].iFldNo == iFldNo)
      {
         OPTPARAMEntry *pEntry = &pDsOptParams->pEntries[i];
         if (iNo)
         {
            if (++iCnt != iNo)
               continue;
            if (ppName)
               *ppName = pEntry->pAttr;
         }
         else
         {
            if (bUTF8METADATA)
            {
#ifdef _UNIX
               int wLen1 = -1, wLen2 = -1;
               pCHAR pSrc1 = (pCHAR)pAttr;
               pCHAR pSrc2 = (pCHAR)pEntry->pAttr;
               pUCS2Char wBuf1, wBuf2;
#if defined(__ANDROID__)
               UErrorCode status = U_ZERO_ERROR;
               INT32 len1 = 0, len2 = 0;

               pu_strFromUTF8(NULL, 0, &len1, pSrc1, -1, &status);

               //Reset buffer overflow error that may have occurred during pre-flighting
               status = U_ZERO_ERROR;

               if (len1 != 0)
               {
                  wBuf1 = new ucs2char_t[len1];
                  pu_strFromUTF8(wBuf1, len1, NULL, pSrc1, -1, &status);
               }

               pu_strFromUTF8(NULL, 0, &len2, pSrc2, -1, &status);

              //Reset buffer overflow error that may have occurred during pre-flighting
              status = U_ZERO_ERROR;

               if (len2 != 0)
               {
                  wBuf2 = new ucs2char_t[len2];
                  pu_strFromUTF8(wBuf2, len2, NULL, pSrc2, -1, &status);
               }
#else
               size_t srcsize1 = (strlen(pAttr)+1) * 4;
               size_t srcsize2 = (strlen(pEntry->pAttr)+1) * 4;
               size_t wSize1 = (strlen(pAttr)+1) * sizeof(ucs2char_t);
               size_t wSize2 = (strlen(pEntry->pAttr)+1) * sizeof(ucs2char_t);
               wBuf1 = new ucs2char_t[strlen(pAttr)];
               wBuf2 = new ucs2char_t[strlen(pEntry->pAttr)];

               pCHAR pRst1 = (pCHAR)wBuf1;
               pCHAR pRst2 = (pCHAR)wBuf2;

               iconv_t cdesc = iconv_open("UTF-16LE", "UTF-8");
               iconv(cdesc, &pSrc1, (size_t*)&srcsize1, &pRst1, (size_t*)&wSize1);
               iconv(cdesc, &pSrc2, (size_t*)&srcsize2, &pRst2, (size_t*)&wSize2);
               iconv_close(cdesc);
#endif
#else
               int wLen1, wLen2;
               wLen1 = MultiByteToWideChar(CP_UTF8, 0, pAttr, -1, NULL, 0);
               wLen2 = MultiByteToWideChar(CP_UTF8, 0, pEntry->pAttr, -1, NULL, 0);

               pUCS2Char wBuf1 = new ucs2char_t[wLen1];
               pUCS2Char wBuf2 = new ucs2char_t[wLen2];

               MultiByteToWideChar(CP_UTF8, 0, pAttr, -1, (wchar_t*)wBuf1, wLen1);
               MultiByteToWideChar(CP_UTF8, 0, pEntry->pAttr, -1, (wchar_t*)wBuf2, wLen2);
#endif
               int rslt = WideStrLIComp(wBuf1, wLen1, wBuf2, wLen2);
               delete[]wBuf1;
               delete[]wBuf2;

            if (rslt != 0)
                  continue;
            }
            else
            {
               if (LdStrCmpi(pAttr, pEntry->pAttr) != 0)
                  continue;
            }
         }
         if (ppName)
            *ppName = pEntry->pAttr;
         if (piType)
            *piType = pEntry->iType;
         if (piLen)
            *piLen = pEntry->iLen;
         if (ppValue)
            *ppValue = (pCHAR)pEntry->pValue;
         rslt = DBIERR_NONE;
         break;
      }
   }
Exit:
   UNLOCK();
   return rslt;
}

VOID ExtractType(UINT32 iPCKLType, pUINT32 piType, pUINT32 piElementSize, pUINT32 piPrefixSize,
   // size of prefix (1,2,4) or 0 if not varying
   pBOOL pbArray // True if array (32-bit counter) follows
   )
{

   *piElementSize = iPCKLType & dsSizeBitsMask;

   if (piType)
      *piType = (iPCKLType & dsTypeBitsMask) >> dsSizeBitsLen;

   if (piPrefixSize) // Varying
   {
      if (iPCKLType & dsVaryingFldType)
      {
         *piPrefixSize = iPCKLType & dsSizeBitsMask;
         piElementSize = 0; // 1; //bytes ?
      }
      else
         *piPrefixSize = 0;
   }

   if (pbArray)
   {
      *pbArray = (iPCKLType & dsArrayFldType);
   }
}

DBIResult DBIFN AdjFldOptParams(DSBASE * pDs)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i;
   pDSFLDDesc pFldDesComp = NULL;

   BOOL bSave = pDs->bCompressArrays;

   if (pDs->iFields == pDs->iFieldsCompressed || pDs->pDsOptParams == NULL)
      goto Exit;

   rslt = GetByteBuffer(sizeof(DSFLDDesc)*pDs->iFieldsCompressed, (ppBYTE) &pFldDesComp, TRUE);
   if (rslt)
      goto Exit;

   pDs->bCompressArrays = TRUE;
   pDs->GetFieldDescs(pFldDesComp);
   pDs->bCompressArrays = bSave;
   for (i = 0; i < pDs->pDsOptParams->iLast; i++)
   {
      OPTPARAMEntry *pEntry = &pDs->pDsOptParams->pEntries[i];

      if (pEntry->iFldNo && pEntry->iFldNo <= pDs->iFieldsCompressed)
      {
         pEntry->iFldNo = pFldDesComp[pEntry->iFldNo -1].iFieldID;
      }
   }

Exit:
   if (pFldDesComp)
      delete pFldDesComp;
   return rslt;
}
