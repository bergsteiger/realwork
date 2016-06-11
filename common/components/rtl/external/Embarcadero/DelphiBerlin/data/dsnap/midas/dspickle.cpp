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

// common compact dataformat, used to transmit data between multiple tiers.

#ifdef _UNIX
#include <stdlib.h>
#include <dlfcn.h>
#define DSPICKLE_C
#if !defined(__ANDROID__)
#include <nl_types.h>
#endif
#else
#include <stdio.h>
#include <windows.h>
#endif
#include <string.h>
#pragma hdrstop

#include "alctypes.h"
#include "ossrv.h"

#include "dspickle.h"
#include "dsxml.h"
#include "dsconst.h"
#ifndef _UNIX
#include <mbstring.h> //This is for _ismbblead
#else
int _ismbblead(int c)
{
   UNREFERENCED_PARAMETER(c);
   return FALSE;
}
#endif


extern INT32 iObjCount; // Defined in alchemy.cpp

#define  szFIELDPROPS "FIELDPROPS"
#define  DSMAXPCKLALLOCSIZE          1000 * 1024 // Maximum pickle block size.
BOOL bNoOfBufAllocs = TRUE;

BOOL bAsAttrs = 1; // XML

DBIResult DBIFN GetFldObj(UINT32 iFieldType, BOOL bConvert, class DSXML_W *pDsXml, FLDConv **ppFldObj);

#define ConvertInt8(iIn)    ((BYTE) iIn);
#define ConvertInt16(iIn)   ((bBigEndian)?   ConvINT16(iIn) :iIn);
#define ConvertUInt16(iIn)  ((bBigEndian)?  ConvUINT16(iIn) :iIn);
#define ConvertInt32(iIn)   ((bBigEndian)?   ConvINT32(iIn) :iIn);
#define ConvertUInt32(iIn)  ((bBigEndian)?  ConvUINT32(iIn) :iIn);
#define IncUInt16(iIn)      ((bBigEndian) ? IncUINT16(iIn) : (iIn+1));
#define IncUInt32(iIn)      ((bBigEndian) ? IncUINT32(iIn) : (iIn+1));

pBYTE XMLWrite(pBYTE pPos, pCHAR pName, BOOL bBegin);
pBYTE XMLReadName(pBYTE pPos, pCHAR pName, BOOL bBegin);
DBIResult DBIFN XmlMakeType(UINT32 iFieldType, pCCHAR *ppzXmlType, pUINT32 pFixedSize);

INT16 ConvINT16(INT16 iIn)
{
   INT16 iOut;
   BYTE bl;

   iOut = (INT16)(iIn >> 8); // Store high byte in low byte
   bl = (BYTE)iIn;
   ((pBYTE)iOut)[1] = bl;
   return iOut;
}

UINT16 ConvUINT16(UINT16 iIn)
{
   UINT16 iOut;
   BYTE bl;

   iOut = (UINT16)(iIn >> 8); // Store high byte in low byte
   bl = (BYTE)iIn;
   ((pBYTE)iOut)[1] = bl;
   return iOut;
}

INT32 ConvINT32(INT32 iIn)
{
   BYTE iOut[4];
   pBYTE pIn = (pBYTE) &iIn;

   iOut[0] = pIn[3];
   iOut[1] = pIn[2];
   iOut[2] = pIn[1];
   iOut[3] = pIn[0];

   return *(pINT32) &iOut;
}

UINT32 ConvUINT32(UINT32 iIn)
{
   BYTE iOut[4];
   pBYTE pIn = (pBYTE) &iIn;

   iOut[0] = pIn[3];
   iOut[1] = pIn[2];
   iOut[2] = pIn[1];
   iOut[3] = pIn[0];

   return *(pINT32) &iOut;
}

// In place conversion of datapacket header
VOID ConvertHeader(BOOL bBigEndian, pVOID pDataPacketBuf)
{
   if (bBigEndian)
   {
      pDSPCKLHdrInfo pHdrInfo = (pDSPCKLHdrInfo)pDataPacketBuf;

      pHdrInfo->iMagicNo = ConvertUInt32(pHdrInfo->iMagicNo);
      pHdrInfo->iMajorVer = ConvertUInt16(pHdrInfo->iMajorVer);
      pHdrInfo->iMinorVer = ConvertUInt16(pHdrInfo->iMinorVer);
      pHdrInfo->iHeaderSize = ConvertUInt32(pHdrInfo->iHeaderSize);
      pHdrInfo->iColumnCount = ConvertUInt16(pHdrInfo->iColumnCount);
      pHdrInfo->iRowCount = ConvertUInt32(pHdrInfo->iRowCount);
      pHdrInfo->iProperties = (PCKLProps)ConvertUInt32(pHdrInfo->iProperties);
      pHdrInfo->iReserved = ConvertUInt16(pHdrInfo->iReserved);
   }
}

UINT16 IncUINT16(UINT16 iIn)
{
   UINT16 iOut = (UINT16)(ConvUINT16(iIn) + 1);
   return ConvUINT16(iOut);
}

UINT32 IncUINT32(UINT32 iIn)
{
   UINT32 iOut = ConvUINT32(iIn) + 1;
   return ConvUINT32(iOut);
}

// Returns number of FieldIDs required to represent all fields in pFldDes
// Only Array fields will cause this number to grow beyond iFlds.
// Assuming iUnits1 is set to number of fields in ADT's and ARRAYs, computes
// iUnits2 as total number of fields within that structure!
UINT32 ComputeMaxFieldIDs(UINT32 iFlds, pDSDATAPACKETFLDDescX pFldDes, pINT16 *ppiUnits2Array)
{
   INT32 i;
   UINT32 iMaxFldId = 0;
   pINT16 piUnits2Array;
   UINT32 iTotalElements = 0;
   UINT32 iFieldType, iSuccFieldType, iFieldLength;

   piUnits2Array = *ppiUnits2Array;
   for (i = iFlds-1; i >= 0; i--)
   {
      *(piUnits2Array + i) = 1;
      iFieldType = pFldDes[i].iFieldType & dsTypeBitsMask;
      iFieldType = iFieldType >> dsSizeBitsLen;

      if (iFieldType == dsfldARRAY)
      {
         UINT32 iElementSize;
         iSuccFieldType = pFldDes[i+1].iFieldType & dsTypeBitsMask;
         iSuccFieldType = iSuccFieldType >> dsSizeBitsLen;
         if (iSuccFieldType == dsfldARRAY || iSuccFieldType == dsfldADT)
         {
            // Computed value (+1 to include the pseudofield)
            iElementSize = piUnits2Array[i+1] + 1;
         }
         else
            iElementSize = 1;
         iFieldLength = pFldDes[i].iFieldType & dsSizeBitsMask;
         piUnits2Array[i] = (UINT16)(iFieldLength * iElementSize);
         // (-1 because first element has already been counted)
         iMaxFldId += piUnits2Array[i] - iElementSize;
      }
      else
      {
         if ((iFieldType == dsfldADT) || (iFieldType == dsfldEMBEDDEDTBL))
         {
            UINT32 j, jFix, iEl;

            iTotalElements = 0;
            // Go forward to compute totalelement count
            iFieldLength = pFldDes[i].iFieldType & dsSizeBitsMask;
            if (iFieldType == dsfldEMBEDDEDTBL)
               iTotalElements = iFieldLength;
            else
            {
               j = i + 1;
               jFix = j;
               for (; j < i + 1 + iFieldLength; j++, jFix++)
               {
                  iFieldType = pFldDes[jFix].iFieldType & dsTypeBitsMask;
                  iFieldType = iFieldType >> dsSizeBitsLen;
                  if (iFieldType == dsfldADT)
                  {
                     iEl = pFldDes[jFix].iFieldType & dsSizeBitsMask;
                     iTotalElements += piUnits2Array[jFix];
                     jFix += iEl;
                  }
                  else if (iFieldType == dsfldARRAY)
                  {
                     iEl = piUnits2Array[jFix] / (pFldDes[jFix].iFieldType & dsSizeBitsMask);
                     iTotalElements += piUnits2Array[jFix];
                     jFix += iEl;
                  }
                  iTotalElements++; // Field itself
               }
            }
            piUnits2Array[i] = (UINT16)iTotalElements;
         }
      }
      iMaxFldId++;
   }
   return iMaxFldId;
}

// Create an array of field-descriptors given the user defined ones.
// In case of array datatypes, the array is 'expanded'
DBIResult MakeAdtFldDescs(UINT32 iFlds, pDSDATAPACKETFLDDescX pFldDes, pUINT32 piFlds, pDSPROVADTFLDDesc *ppFldDes)
{
   INT32 iMaxFieldIDs;
   pINT16 piUnits2Array = NULL;
   pDSPROVADTFLDDesc pAdtFieldDesc = NULL;
   DBIResult rslt = DBIERR_NONE;
   INT32 iFieldType, iFieldLength;
   INT32 i, j;

   piUnits2Array = new INT16[iFlds];
   iMaxFieldIDs = ComputeMaxFieldIDs(iFlds, pFldDes, &piUnits2Array);

   *ppFldDes = NULL;
   pAdtFieldDesc = (pDSPROVADTFLDDesc)DsMalloc(sizeof(DSPROVADTFLDDesc) * iMaxFieldIDs);
   ZeroMem(pAdtFieldDesc, iMaxFieldIDs*sizeof(DSPROVADTFLDDesc));

   if (pAdtFieldDesc == NULL)
   {
      rslt = SetError(DBIERR_NOMEMORY);
      goto Exit;
   }

   if (iFlds == (UINT32)iMaxFieldIDs)
   {
      for (i = 0; i < iMaxFieldIDs; i++)
      {
         pAdtFieldDesc[i].iFieldID = (UINT16)(i + 1);
         pAdtFieldDesc[i].iFieldIDParent = (UINT16)(i + 1);
         pAdtFieldDesc[i].iBaseFieldType = pFldDes[i].iFieldType; // (UINT16) (iFieldType);
      }
   }
   else
   { // We need to construct fielddesc's for array-elements
      INT32 jFix, iEl;

      for (i = iFlds-1, j = iMaxFieldIDs-1; (i >= 0) && (j >= 0); i--, j--)
      {
         UINT32 iBaseFieldType = pFldDes[i].iFieldType;
         iFieldType = iBaseFieldType & dsTypeBitsMask;
         iFieldType = iFieldType >> dsSizeBitsLen;

         if (iFieldType == dsfldEMBEDDEDTBL)
         {
            jFix = j;
            if (rslt)
               goto Exit;
         }
         else if (iFieldType == dsfldARRAY)
         {
            INT32 iElSize;
            j++;
            jFix = i + 1;

            // Copy elements 'arraysize times' -1
            iFieldLength = pFldDes[i].iFieldType & dsSizeBitsMask;
            iElSize = piUnits2Array[i] / iFieldLength;
            for (iEl = 0; iEl < iFieldLength - 1; iEl++)
            {
               INT32 k, iCount;
               j -= iElSize;
               for (k = j, iCount = 0; iCount < iElSize; iCount++, k++)
               {
                  pAdtFieldDesc[k].iFieldID = (UINT16)(k + 1);
                  pAdtFieldDesc[k].iFieldIDParent = (UINT16)(jFix + iCount + 1);
                  pAdtFieldDesc[k].iBaseFieldType = pAdtFieldDesc[k+iElSize].iBaseFieldType;
               }
            }
            j--;
         }
         pAdtFieldDesc[j].iFieldID = (UINT16)(j + 1);
         pAdtFieldDesc[j].iFieldIDParent = (UINT16)(i + 1);
         pAdtFieldDesc[j].iBaseFieldType = iBaseFieldType;
      }
   }

Exit:
   if (rslt)
   {
      if (pAdtFieldDesc)
         DsFree(pAdtFieldDesc);
   }
   else
   {
      *piFlds = iMaxFieldIDs;
      *ppFldDes = pAdtFieldDesc;
   }
   if (piUnits2Array)
      delete[] piUnits2Array;
   return rslt;
}

DBIResult ExpandAllFieldDescs(UINT32 iRecStatesCnt, pDSRECState *paRecStates, // Array of record states
   BOOL bConvert, class DSXML_W *pDsXml)
{
   DBIResult rslt = DBIERR_NONE;
   pDSRECState pRecState;
   UINT32 i, k;
   pDSDATAPACKETFLDDescX pFldEntry;

   for (i = 0; i < iRecStatesCnt; i++)
   {
      pRecState = paRecStates[i];
      if (pRecState == NULL)
         continue;
      rslt = MakeAdtFldDescs(pRecState->iColumns, pRecState->pFlds_List->GetFldDesc(1), &pRecState->iAdtColumns,
         &pRecState->pAdtFieldDesc);
      if (rslt)
         goto Exit;

      // Alocate fieldobjects area
      for (k = 0; k < pRecState->iAdtColumns; k++)
      {
         pDSPROVADTFLDDesc pAdtFldDes = &pRecState->pAdtFieldDesc[k];
         UINT32 iBaseFldType = pAdtFldDes->iBaseFieldType;
         UINT32 iFieldType;
         UINT32 iBaseFldTypex;

         if (iBaseFldType == 0)
         {
            iBaseFldType = pRecState->pAdtFieldDesc[pAdtFldDes->iFieldIDParent-1].iBaseFieldType;
         }

         iFieldType = iBaseFldType & dsTypeBitsMask;
         iFieldType = iFieldType >> dsSizeBitsLen;

         pAdtFldDes->iNULLOffs = pDsXml ? (UINT16)1 : (UINT16)(((k+1 + 3) / 4)); // +1 is for attribute field!
         pAdtFldDes->iMask1 = (BYTE)(1 << ((((k+1 - 1) % 4) * 2)));
         pAdtFldDes->iMask2 = (BYTE)(1 << ((((k+1 - 1) % 4) * 2) +1));
         pFldEntry = pRecState->pFlds_List->GetFldDesc(pAdtFldDes->iFieldIDParent);

         if (pDsXml && (iFieldType == dsfldBYTES) && (strcmp(pFldEntry->szSubType, szstMEMO) == 0))
         {
            iBaseFldTypex = iBaseFldType;
            iBaseFldTypex &= (UINT32)(~dsTypeBitsMask);
            iBaseFldTypex |= (UINT32)(dsfldZSTRING << dsSizeBitsLen);
            rslt = GetFldObj(iBaseFldTypex, bConvert, pDsXml, &pAdtFldDes->pFldObj); // Special memo-case
         }
         else if (pDsXml && (iFieldType == dsfldBYTES) && (strcmp(pFldEntry->szSubType, szstWideMEMO) == 0))
         {
            iBaseFldTypex = iBaseFldType;
            iBaseFldTypex &= (UINT32)(~dsTypeBitsMask);
            iBaseFldTypex |= (UINT32)(dsfldUNICODE << dsSizeBitsLen);
            rslt = GetFldObj(iBaseFldTypex, bConvert, pDsXml, &pAdtFldDes->pFldObj); // Special memo-case
         }
         else
            rslt = GetFldObj(iBaseFldType, bConvert, pDsXml, &pAdtFldDes->pFldObj);
         if (rslt)
            goto Exit;

         pAdtFldDes->pFldObj->pNamePtr = pFldEntry->szFieldName;
         if (!pRecState->bForceTagName && (iFieldType < dsfldADT || iFieldType > dsfldREF))
            pAdtFldDes->bAsAttr = ((pFldEntry->iAttributes & fldAttrATTRNAME)!=0);
         else
            pRecState->bForceTagName = TRUE;

         if (iFieldType == dsfldEMBEDDEDTBL)
         {
            UINT32 j;
            for (j = 0; j < iRecStatesCnt; j++)
            {
               if (paRecStates[j] && paRecStates[j]->iPrevRecState == i && paRecStates[j]
                  ->iParentFieldNo == pRecState->pAdtFieldDesc[k].iFieldIDParent)
               { // Found it
                  pRecState->pAdtFieldDesc[k].iNewRecState = (UINT16)j;
               }
            }
         }
      }
   }

Exit:
   return rslt;
}

DBIResult DBIFN GetFldObj(UINT32 iFieldType, BOOL bConvert, class DSXML_W *pDsXml, FLDConv **ppFldObj)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iPCKLFldType, iSize;
   BOOL bVarying = FALSE;
   BOOL bRepeat = FALSE;
   BOOL bSigned = FALSE;

   iSize = iFieldType & dsSizeBitsMask;
   iPCKLFldType = iFieldType & dsTypeBitsMask;
   iPCKLFldType = iPCKLFldType >> dsSizeBitsLen;
   if (iFieldType & dsVaryingFldType)
      bVarying = TRUE;
   if (iFieldType & dsArrayFldType)
   {
      if (bVarying == TRUE)
      {
         rslt = SetError(DBIERR_INVALIDFLDTYPE);
         goto Exit;
      }
      bRepeat = TRUE;
   }

   switch(iPCKLFldType)
   {
   case dsfldBOOL:
      if (!pDsXml)
         goto FIELDINT;
      *ppFldObj = (FLDConv*)new FLDCBool(bConvert, iSize);
      break;

   case dsfldDATE:
      if (!pDsXml)
         goto FIELDINT;
      *ppFldObj = (FLDConv*)new FLDCDATE(bConvert);
      break;

   case dsfldTIME:
      if (!pDsXml)
         goto FIELDINT;
      *ppFldObj = (FLDConv*)new FLDCTIME(bConvert);
      break;

   FIELDINT:
   case dsfldINT:
      bSigned = TRUE;
   case dsfldUINT:
      *ppFldObj = (iSize == 4) ? (FLDConv*)new FLDCInt32(bConvert, bSigned) : (iSize == 2) ? (FLDConv*)new FLDCInt16
         (bConvert, bSigned) : (iSize == 1) ? (FLDConv*)new FLDCInt8(bConvert, bSigned) : (iSize == 8) ? (FLDConv*)new FLDCInt64
         (bConvert, bSigned) : NULL;
      break;

   case dsfldDATETIME: // SQLTIMESTAMP
      if (iSize != sizeof(SQLTIMESTAMP))
      {
         rslt = SetError(DBIERR_INVALIDFLDTYPE);
         goto Exit;
      }
      *ppFldObj = (FLDConv*)new FLDCSQLTIMESTAMP(bConvert);
      break;

   case dsfldDATETIMEOFFSET: // SQLTIMESTAMPOFFSET
      if (iSize != sizeof(SQLTIMESTAMPOFFSET))
      {
         rslt = SetError(DBIERR_INVALIDFLDTYPE);
         goto Exit;
      }
      *ppFldObj = (FLDConv*)new FLDCSQLTIMESTAMPOFFSET(bConvert);
      break;

   case dsfldTIMESTAMP: // FLOAT
      if (iSize != 8)
      {
         rslt = SetError(DBIERR_INVALIDFLDTYPE);
         goto Exit;
      }
      if (!pDsXml)
         goto FIELDFLOAT;
      *ppFldObj = (FLDConv*)new FLDCTIMESTAMP(bConvert);
      break;

   FIELDFLOAT:
   case dsfldFLOATIEEE:
      *ppFldObj = (iSize == 8) ? (FLDConv*)new FLDCFloat(bConvert) : (iSize == 10) ? (FLDConv*)new FLDCFloatIEEE
         (bConvert) : NULL;
      break;

   case dsfldSINGLE:
      *ppFldObj = (iSize == 4) ? (FLDConv*)new FLDCSingle(bConvert) : NULL;
      break;

   case dsfldFMTBCD:
   case dsfldBCD:
      *ppFldObj = (FLDConv*)new FLDCBcd(bConvert, 32, 16); // Hardcoded!
      break;

   case dsfldARRAY:
   case dsfldADT:
      *ppFldObj = (FLDConv*)new FLDCFixed(bConvert, 0);
      break;

   case dsfldEMBEDDEDTBL:
      if (pDsXml)
         *ppFldObj = (FLDConv*)new FLDNested(bConvert);
      else
         *ppFldObj = (FLDConv*)new FLDCInt32(bConvert, FALSE);
      break;

   case dsfldBYTES:
      if (pDsXml)
      {
         if (bVarying)
         {
            *ppFldObj = (FLDConv*)new FLDBinary(iSize);
         }
         // Treat BYTES the same way as VARBYTES
         // No need for the if here anyway i'll leave it
         // incase we have to special case BYTES from VARBYTES.
         else
         {
            *ppFldObj = (FLDConv*)new FLDBinary(iSize);
         }
         break;
      }

   case dsfldUNICODE:
      if (pDsXml)
      {
         *ppFldObj = (FLDConv*)new FLDUnicode(iSize);
         break;
      }
   case dsfldZSTRING:
   case dsfldBIGDECIMAL:
   case dsfldUNKNOWN:

   default:
      if (bVarying)
      {
         *ppFldObj = (iSize == 4) ? (FLDConv*)new FLDCVar32(bConvert) : (iSize == 2) ? (FLDConv*)new FLDCVar16
            (bConvert) : (iSize == 1) ? (FLDConv*)new FLDCVar8(bConvert) : NULL;
      }
      else
         *ppFldObj = (FLDConv*)new FLDCFixed(bConvert, iSize);
      break;
   }

   if (*ppFldObj == NULL)
      rslt = SetError(DBIERR_INVALIDFLDTYPE);
   else
   {
      (*ppFldObj)->pDsXml = pDsXml;
      if (bRepeat)
      {
         *ppFldObj = new FLDCRepeat(bConvert, *ppFldObj);
         (*ppFldObj)->pDsXml = pDsXml;
      }
   }
Exit:
   return rslt;
}

DSDATAPACKET::DSDATAPACKET()
{
   InitObj();
   pDsXml = NULL;
   iRefCount = 0;
   iObjCount++;
}

DSDATAPACKET::~DSDATAPACKET()
{
   if (pFldAttrObj)
      delete pFldAttrObj;
   DelRecStates();
   if (pFlds_List)
      delete pFlds_List;
   pFlds_List = NULL;
   iObjCount--;
   if (pDsXml)
      delete pDsXml;
}

// Initializes all values
VOID DSDATAPACKET::InitObj()
{
   iAttrCnt = 0;
   iRows = 0;
   iColumns = 0;
   pFlds_List = NULL;
   pDataPacketBuf = NULL;
   iTotalSize = 0;
   bDontStreamColDescs = FALSE;
   iCurRecState = 0;
   iRecStatesCnt = 0;
   memset(paRecStates, 0, sizeof(paRecStates));
   memset((pBYTE) &dsPcklInfo, 0, sizeof(DSPCKLInfo));
   pSa = NULL;
   bMetaDataDone = FALSE;
   bBigEndian = FALSE;
   pFldAttrObj = NULL;
   bFirstRow = TRUE; // First row event
   bOptParamsDone = FALSE;
   bUTF8METADATA = FALSE;
   iANSICodePage = 0;
}

UINT32 DBIFN DSDATAPACKET::GetXMLMode(VOID)
{
   if (pDsXml)
      return pDsXml->iStyle;
   return 0;
}

DBIResult DBIFN DSDATAPACKET::SetXMLMode(INT iMode)
{
   if (iMode && pDsXml == NULL)
   {
      pDsXml = new DSXML_W();
      pDsXml->Init(0, FALSE, iMode, FALSE, bUTF8METADATA, iANSICodePage); // Compact
   }
   if (pDsXml)
   {
      pDsXml->iStyle = iMode;
      if (iMode & xmlXMLUTF8)
      {
         pDsXml->bUTF8 = TRUE;
         if (pDsXml->pXmlParse)
            pDsXml->pXmlParse->bUTF8 = TRUE;
      }
   }
   return DBIERR_NONE;
}

DBIResult DBIFN DSDATAPACKET::SetMETADATAMode(BOOL bMETADATAMode)
{
   bUTF8METADATA = bMETADATAMode;
   if (pDsXml)
      pDsXml->bUTF8METADATA = bMETADATAMode;
   return DBIERR_NONE;
}

DBIResult DBIFN DSDATAPACKET::SetANSICodePage(INT32 iCodePage)
{
   iANSICodePage = iCodePage;
   if (pDsXml)
      pDsXml->iANSICodePage = iANSICodePage;
   return DBIERR_NONE;
}

DBIResult DBIFN DSDATAPACKET::Init_Sequential(UINT32 iVersion, UINT16 iColumns)
{
   DBIResult rslt = DBIERR_NONE;
   pBYTE pPtr;
   pDSPCKLHdrInfo pHdrInfo;

   InitObj();

   if (iVersion > MAX_PICKLEVERSION)
   {
      rslt = SetError(DBIERR_DATAPACKETMISMATCH);
      goto Exit;
   }

   pDataPacketBuf = (pBYTE)SAInit(DSPCKLINITSIZE, &pSa);
   if (pDataPacketBuf == NULL)
   {
      rslt = SetError(DBIERR_NOMEMORY);
      goto Exit;
   }
   iTotalSize = DSPCKLINITSIZE;

   // Initialize the header info.
   memset((pBYTE)pDataPacketBuf, 0, sizeof(DSPCKLHdrInfo));
   pHdrInfo = (pDSPCKLHdrInfo)pDataPacketBuf;
   pHdrInfo->iMagicNo = MAGICCOOKIE;
   pHdrInfo->iMajorVer = (UINT16)PICKLEVERSION_1; // Upgraded if any new types used
   pHdrInfo->iMinorVer = MIN_PICKLEVERSION;
   pHdrInfo->iHeaderSize = sizeof(DSPCKLHdrInfo);
   pHdrInfo->iColumnCount = iColumns;
   pHdrInfo->iRowCount = 0;

   pFlds_List = new Flds_List(iColumns);
   NewRecState(iColumns, 0, 0, &iCurRecState, szROW);

   // Specific for this function
   // Copy the field descriptor information.
   if (pDsXml && pDsXml->iStyle & (xmlUNTYPED | xmlXMLDATATYPED))
   {
      pPtr = pDataPacketBuf + pDsXml->HeadLen();
   }
   else
      pPtr = pDataPacketBuf+sizeof(DSPCKLHdrInfo);
   dsPcklInfo.pFldDescCurrLoc = pPtr;

   pHdrInfo->iProperties = (PCKLProps)pcklpropsMETADATA_INCL;

   if (pDsXml && !pFldAttrObj)
   { // Create field object for attibute field
      pFldAttrObj = new FLDCInt8(bBigEndian, FALSE);
      pFldAttrObj->pNamePtr = szAttrFld;
      pFldAttrObj->pDsXml = pDsXml;
      dsPcklInfo.pDataCurrLoc = pPtr;
   }
Exit:
   return rslt;
}

// Creates pickle with no meta data information.
DBIResult DBIFN DSDATAPACKET::Init(UINT32 iVersion, UINT16 iColumns, pDSDATAPACKETFLDDesc pPcklFldDescs)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 i; // iRequiredSize;
   pDSPCKLHdrInfo pHdrInfo;

   if (pPcklFldDescs == NULL)
      goto Alloc; // Only initialize new datapacket

   InitObj();

   if (iVersion > MAX_PICKLEVERSION)
   {
      rslt = SetError(DBIERR_DATAPACKETMISMATCH);
      goto Exit;
   }

Alloc:

   pDataPacketBuf = (pBYTE)SAInit(DSPCKLINITSIZE, &pSa);
   if (pDataPacketBuf == NULL)
   {
      rslt = SetError(DBIERR_NOMEMORY);
      goto Exit;
   }
   iTotalSize = DSPCKLINITSIZE;

   // Initialize the header info.
   memset((pBYTE)pDataPacketBuf, 0, sizeof(DSPCKLHdrInfo));
   pHdrInfo = (pDSPCKLHdrInfo)pDataPacketBuf;
   pHdrInfo->iMagicNo = MAGICCOOKIE;
   pHdrInfo->iMajorVer = (UINT16)PICKLEVERSION_1; // Upgraded if any new types used
   pHdrInfo->iMinorVer = MIN_PICKLEVERSION;
   pHdrInfo->iHeaderSize = sizeof(DSPCKLHdrInfo);
   pHdrInfo->iColumnCount = iColumns;
   pHdrInfo->iRowCount = 0;

   if (pPcklFldDescs == NULL)
      goto Finish; // Only initialize new datapacket

   pFlds_List = new Flds_List(iColumns);
   NewRecState(iColumns, 0, 0, &iCurRecState, szROW);

   // Specific for this function
   // Copy the field descriptor information.
   // memmove ((pBYTE) this->pFieldDesc, (pBYTE) pPcklFldDescs,
   // sizeof (DSDATAPACKETFLDDesc) * iColumns);

Finish:

   pHdrInfo->iProperties = (PCKLProps)0;
   bNoOfBufAllocs = TRUE;

   if (pDsXml && pDsXml->iStyle & (xmlUNTYPED | xmlXMLDATATYPED))
   {
      dsPcklInfo.pDataCurrLoc = pDataPacketBuf + pDsXml->HeadLen();
   }
   else
   {
      dsPcklInfo.pDataCurrLoc = pDataPacketBuf+sizeof(DSPCKLHdrInfo);
   }
   bDontStreamColDescs = TRUE;

   if (pPcklFldDescs == NULL)
      goto Exit; // Only initialize new datapacket

   // Build the internal structures nescessary!
   for (i = 0; i < (UINT32)iColumns; i++)
   {
      rslt = AddColumnDesc(&pPcklFldDescs[i]);
      if (rslt)
         goto Exit;
   }

   if (pDsXml && !pFldAttrObj)
   {
      pFldAttrObj = new FLDCInt8(bBigEndian, FALSE);
      pFldAttrObj->pNamePtr = szAttrFld;
      pFldAttrObj->pDsXml = pDsXml;
   }
Exit:
   return rslt;
}

#if defined(_UNIX)

INT32 GetModuleHandle(pCHAR pszDllName)
{
   // if first argument to dlsym is set to RTLD_DEFAULT, the run-time
   // address of the symbol called NAME in the global scope.
   // TODO: need to investigate further.
   return *((INT32*)dlsym(RTLD_DEFAULT, pszDllName));
}

INT32 LoadString(HINSTANCE hDll, UINT32 iErrCode, pCHAR pResBuffer, INT32 iMaxLen)
{
#if defined(__ANDROID__)
   INT32 iRetval = 0;
   strcpy(pResBuffer, (char*)"unable to load resource file");
   return iRetval;
#else
   const char * szMsgFile = "/.borland/midas.msg"; // { do not localize }
   const char * GLOBALFILE = "/usr/local/etc/midasmsg.conf"; // { Do not localize }
   static nl_catd catd;
   static char cat[DBIMAXPATHLEN + 1];
   INT32 iRetval = 1;
   FILE *f;

   UNREFERENCED_PARAMETER(hDll);
   UNREFERENCED_PARAMETER(iMaxLen);
   if (iErrCode == 0)
      return 0;

   if (!catd)
   {
      strcpy(cat, getenv("HOME"));
      strncat(cat, szMsgFile, strlen(szMsgFile));
      cat[strlen(cat)] = '\0';

      catd = catopen(cat, 0);
      if (catd == (nl_catd) -1)
      {
         strcpy(pResBuffer, (char*)"unable to load resource file");
         iRetval = 0;
      }
   }
   if (catd != (nl_catd) -1)
      strcpy(pResBuffer, catgets(catd, 1, iErrCode, ""));
   if (pResBuffer[0] == 0)
   {
      catd = catopen(GLOBALFILE, 0);
      if (catd != (nl_catd) -1)
         strcpy(pResBuffer, catgets(catd, 1, iErrCode, ""));
   }
   if (pResBuffer[0] == 0)
      iRetval = 0;
   return iRetval;
#endif
}

BOOL IsEqualCLSID(REFIID riid1, REFIID riid2)
{
   return(memcmp((pVOID) &riid1, (pVOID) &riid2, sizeof(GUID)) == 0);
}
#else
// resource module loader.

static HINSTANCE _hInstance = 0;
static HINSTANCE resHInstance = 0; // HINSTANCE of resource strings

// This function checks if there is an overriding locale which should be used.
//
// The process is as follows:
// Obtain locale override setting from registry.
// If a locale override exists attempt to load it.
// If override module load failed, use the current executable
// If no locale override exists, use OS locales
// If any load failed using OS locales, use old Three-letter locale.
// If any load failed, use the current executable

// translated from System.LoadResourceModule
static char *FindBS(const char *Current)
{
   while (*Current != '\0' && *Current != '\\')
      Current = CharNext(Current);
   return(char*)Current;
}

typedef DWORD (WINAPI *GetLongPathNameFuncProcPtr)(LPCSTR lpszShortPath, LPSTR lpszLongPath, DWORD cchBuffer);

static char *ToLongPath(char *fileName)
{
   int len;
   char *currBS, *nextBS, buffer[FILENAME_MAX];
   HMODULE handle;
   WIN32_FIND_DATA findData;
   GetLongPathNameFuncProcPtr getLongPathNameFunc;

   handle = GetModuleHandle("kernel32.dll");
   if (handle != NULL)
   {
      getLongPathNameFunc = (GetLongPathNameFuncProcPtr)GetProcAddress(handle, "GetLongPathNameA");
      if (getLongPathNameFunc != NULL && getLongPathNameFunc(fileName, buffer, sizeof(buffer)) != 0)
      {
         lstrcpy(fileName, buffer);
         return fileName;
      }
   }

   if (fileName[0] == '\\')
   {
      if (fileName[1] != '\\')
         return fileName;
      currBS = FindBS(fileName + 2); // skip server name
      if (*currBS == '\0')
         return fileName;
      currBS = FindBS(currBS + 1); // skip share name
      if (*currBS == '\0')
         return fileName;
   }
   else
      currBS = fileName + 2; // skip drive name

   len = currBS - fileName;
   lstrcpyn(buffer, fileName, len + 1);
   while (*currBS != '\0')
   {
      nextBS = FindBS(currBS + 1);
      if (len + (nextBS - currBS) + 1 > (int)sizeof(buffer))
         return fileName;
      lstrcpyn(buffer + len, currBS, (nextBS - currBS) + 1);

      handle = (HMODULE)FindFirstFile(buffer, &findData);
      if (handle == INVALID_HANDLE_VALUE)
         return fileName;
      FindClose(handle);

      if (len + 1 + lstrlen(findData.cFileName) + 1 > (int)sizeof(buffer))
         return fileName;
      buffer[len] = '\\';
      lstrcpy(buffer + len + 1, findData.cFileName);
      len += lstrlen(findData.cFileName) + 1;
      currBS = nextBS;
   }
   lstrcpy(fileName, buffer);
   return fileName;
}

typedef BOOL (WINAPI *GetThreadPreferredUILanguagesFuncProcPtr)(DWORD dwFlags, PULONG pulNumLanguages,
   PWSTR pwszLanguagesBuffer, PULONG pcchLanguagesBuffer);

// Copy from winnls.h
#define MUI_LANGUAGE_NAME                   0x8      // Use ISO language (culture) name convention
#define MUI_MERGE_SYSTEM_FALLBACK           0x10     // GetThreadPreferredUILanguages merges in parent and base languages
#define MUI_MERGE_USER_FALLBACK             0x20     // GetThreadPreferredUILanguages merges in user preferred languages
#define MUI_UI_FALLBACK                     MUI_MERGE_SYSTEM_FALLBACK | MUI_MERGE_USER_FALLBACK

static void FindHInstance(void)
{
   static const char *OlderLocaleOverrideKey = "Software\\Borland\\Delphi\\Locales";
   static const char *OldLocaleOverrideKey = "Software\\Borland\\Locales";
   static const char *NewLocaleOverrideKey = "Software\\CodeGear\\Locales";
   static const char *NewerLocaleOverrideKey = "Software\\Embarcadero\\Locales";
   char fileName[260];
   HKEY key;
   char *localeOverride;
   DWORD size;

   localeOverride = NULL;
   if (RegOpenKeyEx(HKEY_CURRENT_USER, NewerLocaleOverrideKey, 0, KEY_READ, &key) == 0 ||
       RegOpenKeyEx(HKEY_LOCAL_MACHINE, NewerLocaleOverrideKey, 0, KEY_READ, &key) == 0 || 
       RegOpenKeyEx(HKEY_CURRENT_USER, NewLocaleOverrideKey, 0, KEY_READ, &key) == 0 ||
       RegOpenKeyEx(HKEY_LOCAL_MACHINE, NewLocaleOverrideKey, 0, KEY_READ, &key) == 0 || 
       RegOpenKeyEx(HKEY_CURRENT_USER, OldLocaleOverrideKey, 0, KEY_READ, &key) == 0 || 
       RegOpenKeyEx(HKEY_CURRENT_USER, OlderLocaleOverrideKey, 0, KEY_READ, &key) == 0 )
   {
      char hostAppName[260];
      GetModuleFileName(0, hostAppName, sizeof(hostAppName));
      if (RegQueryValueEx(key, ToLongPath(hostAppName), NULL, NULL, NULL, &size) == 0)
      {
         localeOverride = new char[size];
         RegQueryValueEx(key, ToLongPath(hostAppName), NULL, NULL, (unsigned char*)localeOverride, &size);
      }
      else if (RegQueryValueEx(key, "", NULL, NULL, NULL, &size) == 0)
      {
         localeOverride = new char[size];
         RegQueryValueEx(key, "", NULL, NULL, (unsigned char*)localeOverride, &size);
      }
      RegCloseKey(key);
   }

   GetModuleFileName(_hInstance, fileName, sizeof(fileName)); // get name of our process

   if (fileName[0] != '\0')
   {
      char *extPart;
      int maxExtLength;

      extPart = fileName + strlen(fileName);
      while (*extPart != '.' && extPart != fileName)
         --extPart;
      if (extPart != fileName)
      {
         ++extPart; // extPart points the top of Extension part.
         maxExtLength = sizeof(fileName)/sizeof(fileName[0]) - (extPart - fileName);

         if ((localeOverride != NULL) && (localeOverride[0] != '\0')) // If override key exist,
         {
            // only look for a local registry override
            // localeOverride is comma-separated string.
            char *p = localeOverride;
            while ((resHInstance == 0) && (*p != '\0'))
            {
               char *commaPtr = p;
               while ((*commaPtr != ',') && (*commaPtr != '\0'))
                  commaPtr++;
               if (*commaPtr == ',')
                  *commaPtr++ = '\0';
               strncpy(extPart, p, maxExtLength);
               resHInstance = LoadLibraryEx(fileName, 0, LOAD_LIBRARY_AS_DATAFILE);
               p = commaPtr;
            }
         }
         else
         {
            HMODULE handle;
            GetThreadPreferredUILanguagesFuncProcPtr GetThreadPreferredUILanguagesFunc = NULL;

            // GetThreadPreferredUILanguages is existed in Vista or later OS.
            handle = GetModuleHandle("kernel32.dll");
            if (handle != NULL)
               GetThreadPreferredUILanguagesFunc = (GetThreadPreferredUILanguagesFuncProcPtr)GetProcAddress
                  (handle, "GetThreadPreferredUILanguages");
            if (GetThreadPreferredUILanguagesFunc != NULL)
            {
               // When GetThreadPreferredUILanguages exists in OS, This OS is Vista or later version. All W-version APIs are existed.
               ULONG bufSize, numLang;
               bufSize = 0;
               numLang = 0;
               if (GetThreadPreferredUILanguagesFunc(MUI_LANGUAGE_NAME | MUI_UI_FALLBACK, &numLang, NULL, &bufSize))
               {
                  pUCS2Char wp, wBuffer;

                  wBuffer = new ucs2char_t[bufSize];
                  GetThreadPreferredUILanguagesFunc(MUI_LANGUAGE_NAME | MUI_UI_FALLBACK, &numLang, (wchar_t*)wBuffer, &bufSize);

                  wp = wBuffer;
                  if (wBuffer)
                  {
                     while ((*wp != L'\0') && (resHInstance == 0))
                     {
                        wcstombs(extPart, (wchar_t*)wp, maxExtLength);
                        resHInstance = LoadLibraryEx(fileName, 0, LOAD_LIBRARY_AS_DATAFILE);
                        wp += WideStrLen(wp) + 1;
                     }
                     delete[] wBuffer;
                  }
               }
            }
            else
            {
               char language[LOCALE_NAME_MAX_LENGTH];
               char *p;
               int length;

               // A return value of GetLocaleInfo contains NULL-terminator.
               length = GetLocaleInfo(GetThreadLocale(), LOCALE_SISO639LANGNAME, language, LOCALE_NAME_MAX_LENGTH) - 1;
               p = language + length;
               *p = '-';
               GetLocaleInfo(GetThreadLocale(), LOCALE_SISO3166CTRYNAME, p+1, LOCALE_NAME_MAX_LENGTH-(length+1));
               strncpy(extPart, language, maxExtLength);
               resHInstance = LoadLibraryEx(fileName, 0, LOAD_LIBRARY_AS_DATAFILE);
               if (resHInstance == 0)
               {
                  *p = '\0';
                  strncpy(extPart, language, maxExtLength);
                  resHInstance = LoadLibraryEx(fileName, 0, LOAD_LIBRARY_AS_DATAFILE);
               }
            }
            // try old three-letter way.
            if (resHInstance == 0)
            {
               char localeName[4];

               GetLocaleInfo(GetThreadLocale(), LOCALE_SABBREVLANGNAME, localeName, sizeof(localeName));
               strncpy(extPart, localeName, maxExtLength);
               resHInstance = LoadLibraryEx(fileName, 0, LOAD_LIBRARY_AS_DATAFILE);

               if (resHInstance == 0)
               {
                  // finally look for a langauge-only translation
                  localeName[2] = '\0';
                  strncpy(extPart, localeName, maxExtLength);
                  resHInstance = LoadLibraryEx(fileName, 0, LOAD_LIBRARY_AS_DATAFILE);
               }
            }
         }
      }
   }
   if (localeOverride)
      delete[] localeOverride;
   if (resHInstance == 0)
      resHInstance = _hInstance;
}

ULONGP GetResourceModuleHandle(pCCHAR lpModuleName)
{
   if (resHInstance == 0)
   {
      if (lpModuleName)
         _hInstance = (HINSTANCE)GetModuleHandle(lpModuleName);
      else
      {
         const int MAXPATHLENGTH = 260;
         char HostAppName[MAXPATHLENGTH+1];
         DWORD len = GetModuleFileName(0, HostAppName, MAXPATHLENGTH);
         HostAppName[len] = 0;
         _hInstance = (HINSTANCE)GetModuleHandle(HostAppName);
      }
      FindHInstance();
   }
   return reinterpret_cast<ULONGP>(resHInstance);
}

INT32 LoadStringUTF8(HINSTANCE hDll, UINT32 iErrCode, pCHAR pResBuffer, INT32 iMaxLen)
{
   WCHAR wStr[256];
   int wLen, len;

   wLen = LoadStringW(hDll, iErrCode, wStr, sizeof(wStr)/sizeof(*wStr));
   len = WideCharToMultiByte(CP_UTF8, 0, wStr, wLen, pResBuffer, iMaxLen-1, 0, 0);
   pResBuffer[len] = '\0';
   return(len > 0);
}

#endif    // #ifdef _UNIX

HRESULT DBIFN DSDATAPACKET::QueryInterface(REFIID riid, void** ppv)
{
#ifdef MIDAS_DLL
   if (IsEqualCLSID(riid, IID_MDATAPACKETWRITE) || IsEqualCLSID(riid, IID_IUnknown))
#else
      if (IsEqualCLSID(riid, IID_DATAPACKETWRITE) || IsEqualCLSID(riid, IID_IUnknown))
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

UINT32 DBIFN DSDATAPACKET::AddRef(VOID)
{
   return++iRefCount;
}

UINT32 DBIFN DSDATAPACKET::Release(VOID)
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

VOID DSDATAPACKET::DelRecStates(VOID)
{
   UINT32 i;

   for (i = 0; i < iRecStatesCnt; i++)
   {
      if (paRecStates[i])
      {
         if (paRecStates[i]->pAdtFieldDesc)
         {
            UINT32 j;
            for (j = 0; j < paRecStates[i]->iAdtColumns; j++)
            {
               if (paRecStates[i]->pAdtFieldDesc[j].pFldObj)
                  delete paRecStates[i]->pAdtFieldDesc[j].pFldObj;
            }
            DsFree(paRecStates[i]->pAdtFieldDesc);
         }
         if (paRecStates[i]->pAttr_List)
            delete paRecStates[i]->pAttr_List;
         if (paRecStates[i]->pFlds_List)
            delete paRecStates[i]->pFlds_List;
         if (paRecStates[i]->pszROW)
            delete[] paRecStates[i]->pszROW;
         delete paRecStates[i];
      }
   }
}

VOID DSEXTRACT::DelRecStates(VOID)
{
   UINT32 i;

   for (i = 0; i < iRecStatesCnt; i++)
   {
      if (paRecStates[i])
      {
         if (paRecStates[i]->pAdtFieldDesc)
         {
            UINT32 j;
            for (j = 0; j < paRecStates[i]->iAdtColumns; j++)
            {
               if (paRecStates[i]->pAdtFieldDesc[j].pFldObj)
                  delete paRecStates[i]->pAdtFieldDesc[j].pFldObj;
            }
            DsFree(paRecStates[i]->pAdtFieldDesc);
         }
         if (paRecStates[i]->pAttr_List)
            delete paRecStates[i]->pAttr_List;
         if (paRecStates[i]->pFlds_List)
            delete paRecStates[i]->pFlds_List;
         if (paRecStates[i]->pszROW)
            delete[] paRecStates[i]->pszROW;
         delete paRecStates[i];
      }
   }
}

DBIResult DBIFN DSEXTRACT::GetErrorString(DBIResult iErrCode, pCHAR pString)
{
#ifdef _UNIX
   int i;
   if (pString)
   {
      if (LoadString((HINSTANCE)0, iErrCode, pString, DBIMAXMSGLEN) == 0)
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
   return DBIERR_NONE;
#else
   ULONGP hDll;

   if (pString)
   {
      *pString = '\0';
#ifdef MIDAS_OBJ
      // For midaslib, main application contains resources.
      hDll = GetResourceModuleHandle(NULL);
#else
      hDll = GetResourceModuleHandle(szALCHEMYDLL);
#endif
      if (hDll < HINSTANCE_ERROR)
         return SetError(DBIERR_OBJNOTFOUND); // resource not found

      if (LoadString((HINSTANCE)hDll, iErrCode, pString, DBIMAXMSGLEN) == 0)
         return SetError(DBIERR_OBJNOTFOUND); // resource not found
   }
   return DBIERR_NONE;
#endif
}

DBIResult DBIFN DSDATAPACKET::GetErrorString(DBIResult iErrCode, pCHAR pString)
{
#ifdef _UNIX
   int i;
   if (pString)
   {
      if (LoadString((HINSTANCE)0, iErrCode, pString, DBIMAXMSGLEN) == 0)
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
   return DBIERR_NONE;
#else
   ULONGP hDll;

   if (pString)
   {
      *pString = '\0';

#ifdef MIDAS_OBJ
      // For midaslib, main application contains resources.
      hDll = GetResourceModuleHandle(NULL);
#else
      hDll = GetResourceModuleHandle(szALCHEMYDLL);
#endif
      if (hDll < HINSTANCE_ERROR)
         return SetError(DBIERR_OBJNOTFOUND); // resource not found

      if (LoadString((HINSTANCE)hDll, iErrCode, pString, DBIMAXMSGLEN) == 0)
         return SetError(DBIERR_OBJNOTFOUND); // resource not found
   }
   return DBIERR_NONE;
#endif
}

// Create and initialize a new recstate structure, linking it to its caller
DBIResult DBIFN DSDATAPACKET::NewRecState(UINT16 iCols, UINT16 iFieldNo, UINT32 iCurRecState, pUINT32 piRecState,
   pCCHAR pszRowName)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iRecState;
   pDSRECState pRecState;

   if (iRecStatesCnt < MAXRECSTATES-1)
   {
      iRecState = ++iRecStatesCnt;
   }
   else
   {
      rslt = SetError(DBIERR_NA);
      goto Exit;
   }

   pRecState = new DSRECState;
   paRecStates[iRecState-1] = pRecState;
   ZeroMem(pRecState, sizeof(DSRECState));
   pRecState->iPrevRecState = iCurRecState;
   pRecState->iParentFieldNo = iFieldNo;
   pRecState->iColumnsInitial = iCols; // Number of fielddescs
   pRecState->pEmbeddedRowCount = NULL;
   pRecState->pAttr_List = NULL;
   pRecState->pFlds_List = new Flds_List(iCols);
   if (pszRowName)
   {
      pRecState->pszROW = new CHAR[(strlen(pszRowName)+2)]; // No parentesis srews up allocator!
      strcpy(pRecState->pszROW, pszRowName);
   }
   else
      pRecState->pszROW = NULL;

   *piRecState = iRecState-1;

Exit:
   return rslt;
}

// Add a column descriptor
DBIResult DBIFN DSDATAPACKET::AddColumnDesc(pDSDATAPACKETFLDDesc pFldDes)
{
   pBYTE pPtr;
   DBIResult rslt = DBIERR_NONE;
   pDSPCKLHdrInfo pHdrInfo;
   BYTE iNameLen;
   UINT32 iSizeAvail;
   UINT32 iRequiredSize;
   pDSRECState pRecState;
   UINT32 iFieldType = pFldDes->iFieldType;
   DSDATAPACKETFLDDescX FldDesX;
   UINT32 iFixedSize = 0;

   ZeroMem((pBYTE) &FldDesX, sizeof(DSDATAPACKETFLDDescX));
   CopyMem((pBYTE) &FldDesX, pFldDes, sizeof(DSDATAPACKETFLDDesc));

   pHdrInfo = (pDSPCKLHdrInfo)pDataPacketBuf;
   if (pHdrInfo->iColumnCount < (UINT16)iColumns)
      return SetError(DBIERR_NA);

   if (strcmp(szRowState, pFldDes->szFieldName) == 0)
   {
      rslt = SetError(DBIERR_NA);
      goto Exit;
   }

Again:
   pRecState = paRecStates[iCurRecState];
   if (pRecState->iColumns == pRecState->iColumnsInitial)
   { // Finishing up this level.
      if (iCurRecState)
      {
         if (pRecState->iOptParams == 0)
         {
         }
         if (pDsXml && (pDsXml->iStyle & xmlXMLSCHEMA))
         {
            // pCHAR pzType;
            pBYTE pPos = dsPcklInfo.pFldDescCurrLoc;
            if (pDsXml->bOpenTag)
               pPos = pDsXml->WriteFinishTag(pPos, TRUE);
            else
               pPos = pDsXml->WriteEndTag
                  (pPos, szFIELDDEF /* pRecState->pFieldDesc[pRecState->iColumns-1].szFieldName */ , TRUE);
            dsPcklInfo.pFldDescCurrLoc = pPos;
            dsPcklInfo.pAttrCountLoc = pPos;
            dsPcklInfo.pAttrCurrLoc = pPos;
            dsPcklInfo.pDataCurrLoc = pPos;
         }
         // In case there were no optional parameters for this level, we still need to
         // write the opt. parameter counter to 0.!
         iCurRecState = pRecState->iPrevRecState;
         goto Again;
      }
      else
      { // Giving too many desc.
         rslt = SetError(DBIERR_NA);
         goto Exit;
      }
   }

   // Copy the field descriptor into pFieldDesc member.

   pRecState->pFlds_List->Add((pBYTE) &FldDesX, NULL);
   pRecState->iColumns++;

   if (!bDontStreamColDescs && !(pDsXml && pDsXml->iStyle & (xmlUNTYPED | xmlXMLDATATYPED)))
   {
      iRequiredSize = sizeof(DSDATAPACKETFLDDesc)+sizeof(BYTE) +100;
      iSizeAvail = this->iTotalSize - ((pBYTE)dsPcklInfo.pFldDescCurrLoc - (pBYTE)pDataPacketBuf);
      if (iSizeAvail < iRequiredSize)
      {
         rslt = GrowSize(iRequiredSize);
         if (rslt)
            return rslt;
         // After ReAlloc, pHdrInfo points to invalid memory; reset it
         pHdrInfo = (pDSPCKLHdrInfo)pDataPacketBuf;
      }
      pPtr = dsPcklInfo.pFldDescCurrLoc;

      // Copy the field descriptor into the pickle.
      iNameLen = (BYTE)LdStrLen(pFldDes->szFieldName);
      *((pBYTE)pPtr) = iNameLen;
      pPtr += sizeof(BYTE);
      memmove((pBYTE)pPtr, (pBYTE)pFldDes->szFieldName, iNameLen);
      pPtr += iNameLen;
      *((pINT32)pPtr) = ConvertInt32(iFieldType);
      pPtr += sizeof(INT32);
      *((pINT16)pPtr) = ConvertInt16(pFldDes->iAttributes);
      pPtr += sizeof(INT16);

      dsPcklInfo.pFldAttrCountLoc = pPtr;
      // Set the optional parameter count.
      *((pUINT16)pPtr) = 0; // ConvertUINT16()
      pPtr += sizeof(UINT16);
      dsPcklInfo.pFldDescCurrLoc = pPtr;

      // set the number of optional parameter count to zero.
      *((pUINT16)pPtr) = 0; // ConvertUINT16()
      dsPcklInfo.pAttrCountLoc = pPtr;
      dsPcklInfo.pAttrCurrLoc = (pBYTE)pPtr+sizeof(UINT16);
      dsPcklInfo.pDataCurrLoc = (pBYTE)dsPcklInfo.pAttrCurrLoc;
   }
   else
   { // WRITE XMLField
      if (pDsXml && (pDsXml->iStyle & xmlXMLSCHEMA))
      {
         DBINAME szName;
         UINT32 i;
         CHAR ch;
         BOOL bHasSpaces = FALSE, bHasMB = FALSE;

         pCCHAR pzType;
         pBYTE pPos = dsPcklInfo.pFldDescCurrLoc;

         iRequiredSize = 1000;
         iSizeAvail = this->iTotalSize - ((pBYTE)dsPcklInfo.pFldDescCurrLoc - (pBYTE)pDataPacketBuf);

         if (iSizeAvail < iRequiredSize)
         {
            rslt = GrowSize(iRequiredSize);
            if (rslt)
               return rslt;
         }

         if (pRecState->iColumns == 1)
         {
            if (iCurRecState == 0)
            {
               pPos = pDsXml->WriteOpenTag(pPos, szDATAPACKET, TRUE);
               pPos = pDsXml->WriteAttribute(pPos, szVersion, szVersion20);
               pPos = pDsXml->WriteFinishTag(pPos, FALSE);
               pPos = pDsXml->WriteBeginTag(pPos, szMETADATA, NULL, TRUE, TRUE);
            }
            pPos = pDsXml->WriteBeginTag(pPos, szFIELDS, NULL, TRUE, TRUE);
         }
         else
         { // Finish previous field
            if (pDsXml->bOpenTag)
               pPos = pDsXml->WriteFinishTag(pPos, TRUE);
            else
               pPos = pDsXml->WriteEndTag
                  (pPos, szFIELDDEF /* pRecState->pFieldDesc[pRecState->iColumns-2].szFieldName */ , TRUE);
         }

         pPos = pDsXml->WriteOpenTag(pPos, szFIELDDEF, TRUE);
         // Note if fieldname contains spaces, we need to add a special attribute for that

         for (i = 0; i<strlen(FldDesX.szFieldName); i++)
         {
            ch = FldDesX.szFieldName[i];
            if (pDsXml->bUTF8METADATA && ((unsigned char)ch >= 0x80))
            {
               if (pDsXml->bUTF8)
               {
                  szName[i] = ch;
                  i++;
                  ch = FldDesX.szFieldName[i];
               }
               else
               {
                  bHasMB = TRUE;
                  strcpy(szName, "xF");
                  itoa((int)iColumns, &szName[strlen(szName)], 10);
                  goto HasSpaces;
               }
            }
            else if (!pDsXml->bUTF8METADATA && _ismbblead((BYTE)ch))
            {
               if (pDsXml->bUTF8)
               {
                  szName[i] = ch;
                  i++;
                  ch = FldDesX.szFieldName[i];
               }
               else
               {
                  bHasMB = TRUE;
                  strcpy(szName, "xF");
                  itoa((int)iColumns, &szName[strlen(szName)], 10);
                  goto HasSpaces;
               }
            }
            else if (ch == ' '||ch == '('||ch == ')'||ch == '#'||ch == '*'||ch == '!'||ch == '$'||ch == '%'||ch == '?')
            {
               ch = '_';
               bHasSpaces = TRUE;
            }
            szName[i] = ch;
         }
         szName[i] = 0;
      HasSpaces:
         if (bHasSpaces || bHasMB)
         {
            pDSDATAPACKETFLDDescX pFX;
            pPos = pDsXml->WriteAttribute(pPos, szAttrFieldName, FldDesX.szFieldName);

            pFX = pRecState->pFlds_List->GetFldDesc(pRecState->pFlds_List->iLast);
            strcpy(pFX->szFieldName, szName); // Overwrite the value
         }
         if (bAsAttrs)
            pPos = pDsXml->WriteAttribute(pPos, szAttrAttrName, szName);
         else
            pPos = pDsXml->WriteAttribute(pPos, szAttrTagName, szName);

         rslt = XmlMakeType(pFldDes->iFieldType, &pzType, &iFixedSize);
         if (rslt)
            goto Exit;
         pPos = pDsXml->WriteAttribute(pPos, szAttrFieldType, pzType);
         if (pFldDes->iAttributes & fldAttrREADONLY)
            pPos = pDsXml->WriteAttribute(pPos, szAttrReadOnly, "true");
         if (pFldDes->iAttributes & fldAttrREQUIRED)
            pPos = pDsXml->WriteAttribute(pPos, szAttrRequired, "true");
         if (pFldDes->iAttributes & fldAttrHIDDEN)
            pPos = pDsXml->WriteAttribute(pPos, szAttrHidden, "true");
         if (pFldDes->iAttributes & fldAttrLINK)
            pPos = pDsXml->WriteAttribute(pPos, szAttrLinkFld, "true");

         dsPcklInfo.pFldDescCurrLoc = pPos;
         dsPcklInfo.pAttrCountLoc = pPos;
         dsPcklInfo.pAttrCurrLoc = pPos;
         dsPcklInfo.pDataCurrLoc = pPos;
         dsPcklInfo.pInsertionPoint = pPos;
      }
   }

   iFieldType = iFieldType & dsTypeBitsMask;
   iFieldType = iFieldType >> dsSizeBitsLen;
   if (iFieldType > dsfldVERSION_1)
   {
      if (iFieldType > dsfldVERSION_4)
      {
         rslt = SetError(DBIERR_NA);
         goto Exit;
      }
      pHdrInfo->iMajorVer = PICKLEVERSION_2; // Requires a pickle version 2 to unpack
      if (iFieldType == dsfldEMBEDDEDTBL)
      { // Create new level
         UINT16 iCols = (UINT16)pFldDes->iFieldType; // & 0x0000ffff ;
         CHAR szTmp[64];
         pRecState->iColumnsInitial -= iCols; // Adjust this one
         if (pDsXml)
         {
            strcpy(szTmp, szROW);
            strcat(szTmp, pFldDes->szFieldName);
            rslt = NewRecState(iCols, (UINT16)pRecState->iColumns, iCurRecState, &iCurRecState, szTmp);
         }
         else
         {
            rslt = NewRecState(iCols, (UINT16)pRecState->iColumns, iCurRecState, &iCurRecState, NULL);
         }
      }
   }
   // Done in order for reset to work!

   if (pFlds_List)
      pFlds_List->Add((pBYTE) &FldDesX, NULL);
   iColumns++;
   if (pHdrInfo->iColumnCount == (UINT16)iColumns)
   {
      // rslt = ExpandAllFieldDescs(iRecStatesCnt, paRecStates, bBigEndian, pDsXml);
      // if (pDsXml && !(pDsXml->iStyle & (xmlUNTYPED | xmlXMLDATATYPED)))
      // {
      // dsPcklInfo.pDataCurrLoc = (pBYTE) dsPcklInfo.pAttrCurrLoc = pDsXml->WriteHead(dsPcklInfo.pDataCurrLoc);
      // }
   }
   if (iFixedSize && !rslt)
   {
      INT16 iLen = (INT16)iFixedSize;
      rslt = this->AddAttribute(fldAttrArea, szWIDTH, dptypeINT16, sizeof(INT16), (pBYTE) &iLen);
   }

Exit:
   return rslt;
}

// Add an optional parameter
DBIResult DBIFN DSDATAPACKET::AddAttribute(PCKLATTRArea eAttrArea, // fld or pckl optional parameter area.
   pCCHAR pszAttr, // attribute name
   UINT32 iType, // type of attribute
   UINT32 iLen, // length of value
   pBYTE pValue) // value
{
   BYTE iSize;
   pDSPCKLHdrInfo pHdrInfo;
   UINT32 iSizeAvail;
   pBYTE pAttrCurrLoc;
   UINT32 iRequiredSize;
   DBIResult rslt = DBIERR_NONE;
   pDSRECState pRecState = paRecStates[iCurRecState];
   FLDConv * pFldObj = NULL;

   // Make sure addattribute is not called after Addfields is called.
   // i.e., all attributes should be supplied before rows.
   pHdrInfo = (pDSPCKLHdrInfo)pDataPacketBuf;
   if (pHdrInfo->iRowCount)
      return SetError(DBIERR_NA);

   if (pDsXml && pDsXml->iStyle & (xmlUNTYPED | xmlXMLDATATYPED) && !(pDsXml->iStyle & xmlXMLSCHEMA))
   { // Ignore it
      if (pValue == NULL)
         iCurRecState = pRecState->iPrevRecState;
      goto Exit;
   }

   iSize = (BYTE)(pszAttr ? LdStrLen(pszAttr) : 0);
   iRequiredSize = iSize+sizeof(UINT32) + iLen+sizeof(BYTE);
   if (pDsXml)
      iRequiredSize += 1000;
   iSizeAvail = this->iTotalSize - ((pBYTE)dsPcklInfo.pAttrCurrLoc - (pBYTE)pDataPacketBuf);
   if (iSizeAvail < iRequiredSize)
   {
      rslt = GrowSize(iRequiredSize);
      if (rslt)
         return rslt;
   }

   if (eAttrArea == fldAttrArea)
      pAttrCurrLoc = (pBYTE)dsPcklInfo.pFldDescCurrLoc;
   else
      pAttrCurrLoc = (pBYTE)dsPcklInfo.pAttrCurrLoc;

   // 3 situations : a. fldAttrArea, nested table
   // b.  pcklAttrArea , nested table
   // c.  pcklAttrArea , main table
   if (pValue == NULL /* && eAttrArea == pcklAttrArea */ )
   { // Special case : finish up this level, create entry for next optional parameters

      if (!pDsXml)
      {
         *((pUINT16)pAttrCurrLoc) = 0; // ConvertUINT16()
         dsPcklInfo.pAttrCountLoc = pAttrCurrLoc;
         dsPcklInfo.pFldDescCurrLoc = pAttrCurrLoc; // (pBYTE) dsPcklInfo.pAttrCurrLoc;
         if (iCurRecState !=0)
         { // otherwise it will write it twice
            dsPcklInfo.pAttrCurrLoc = (pBYTE)pAttrCurrLoc+sizeof(UINT16);
         }
         dsPcklInfo.pDataCurrLoc = (pBYTE)dsPcklInfo.pAttrCurrLoc;
      }
      else
      {
         pBYTE pPos = dsPcklInfo.pDataCurrLoc;

         if (eAttrArea != fldAttrArea)
         {

            if (pRecState->iOptParams == 0)
            {
               if (pRecState->iColumns > 0)
               {
                  if (pDsXml->bOpenTag)
                     pPos = pDsXml->WriteFinishTag(pPos, TRUE);
                  else
                  {
                     if (strcmp(pDsXml->LastTag, szFIELDDEF) !=0)
                        pPos = pDsXml->WriteEndTag
                           (pPos, szFIELDDEF /* pRecState->pFieldDesc[pRecState->iColumns-1].szFieldName */ , TRUE);
                  }
               }
               pPos = pDsXml->WriteEndTag(pPos, szFIELDS, TRUE);
               pPos = pDsXml->WriteOpenTag(pPos, szPARAMS, TRUE);
               pPos = pDsXml->WriteFinishTag(pPos, TRUE);

               if (iCurRecState > 0)
               {
                  pDSRECState pRecStatePrev = paRecStates[pRecState->iPrevRecState];
                  if (pRecStatePrev->iColumnsInitial == pRecStatePrev->iColumns)
                     pPos = pDsXml->WriteEndTag(pPos, szFIELDDEF, TRUE); // Otherwise, AddColumn would finish!

               }
               dsPcklInfo.pInsertionPoint = pPos;

            }
            else
            {
               if (pDsXml->bOpenTag)
                  pPos = pDsXml->WriteFinishTag(pPos, TRUE);
               else
               {
                  pPos = pDsXml->WriteEndTag(pPos, szPARAMS, TRUE);

               }
            }
         }

         if (iCurRecState == 0)
            bOptParamsDone = TRUE;

         dsPcklInfo.pFldDescCurrLoc = pPos;
         dsPcklInfo.pAttrCountLoc = pPos;
         dsPcklInfo.pAttrCurrLoc = pPos;
         dsPcklInfo.pDataCurrLoc = pPos;
      }
      iCurRecState = pRecState->iPrevRecState;
      goto Exit;
   }

   if (!pDsXml)
   {
      /*
      TODO:  Error handling for DataSets with no Fields.  (Raid:  264087)
      One of the causes of pAttrCurrLoc being NULL is that there
      are no Fields in a DataSet.  When the LCID attr is added,
      the pAttrCurrLoc is NULL in this case.  In one case of this
      SQLExpr.pas would set FieldDef types to ftUnknown.  Field objects
      were not added for FieldDefs with types of ftUnknown.  We need
      error handling for TDataSets that have FieldDefs, but no Fields.
       */
      *((pBYTE)pAttrCurrLoc) = (BYTE)iSize; // ConvertUINT8()
      pAttrCurrLoc += sizeof(BYTE);
      memmove(pAttrCurrLoc, pszAttr, iSize); // ConvertZTRING()
      pAttrCurrLoc += iSize;
      *(pUINT32)pAttrCurrLoc = ConvertUInt32(iType);
      pAttrCurrLoc += sizeof(UINT32);

      rslt = GetFldObj(iType, bBigEndian, NULL /* pDsXml */ , &pFldObj);
      if (rslt)
         goto Exit;
      // pAttrCurrLoc points to space after opt. parameter

      if ((iType & (dsVaryingFldType))) // NOTE: sfldArrayFldType works fine!
      { // Variable length: length is included in pVale and iLen!
         pValue += pFldObj->iLen;
         iLen -= pFldObj->iLen;
      }

      pAttrCurrLoc = pFldObj->FldPut(pAttrCurrLoc, pValue, iLen);

      // Increment the optional parameter count.
      if (eAttrArea == fldAttrArea)
      {
         // set the number of optional parameter count to zero.
         *((pUINT16)pAttrCurrLoc) = 0; // ConvertUINT8()

         dsPcklInfo.pAttrCountLoc = pAttrCurrLoc;
         dsPcklInfo.pAttrCurrLoc = (pBYTE)pAttrCurrLoc+sizeof(UINT16);
         dsPcklInfo.pDataCurrLoc = (pBYTE)dsPcklInfo.pAttrCurrLoc;

         // Increment count
         dsPcklInfo.pFldDescCurrLoc = pAttrCurrLoc;
         pAttrCurrLoc = (pBYTE)dsPcklInfo.pFldAttrCountLoc;
         *((pUINT16)pAttrCurrLoc) = (UINT16)IncUInt16((*(pUINT16)pAttrCurrLoc));
      }
      else
      {
         pRecState->iOptParams++;
         dsPcklInfo.pAttrCurrLoc = (pBYTE)pAttrCurrLoc;
         dsPcklInfo.pDataCurrLoc = (pBYTE)pAttrCurrLoc;
         dsPcklInfo.pFldDescCurrLoc = pAttrCurrLoc; // KH
         pAttrCurrLoc = (pBYTE)dsPcklInfo.pAttrCountLoc;
         *(pUINT16)pAttrCurrLoc = (UINT16)IncUInt16((*(pUINT16)pAttrCurrLoc));
         if (iCurRecState == 0)
            this->iAttrCnt++;
      }
   }
   else
   { // pDsXml
      pBYTE pPos = pAttrCurrLoc;
      pCCHAR pzType;
      CHAR Tmp[2048];
      pBYTE pTmp;
      BOOL bAsParam = FALSE;
      pCCHAR pName;

      if (eAttrArea != fldAttrArea && pRecState->iOptParams == 0)
      { // First parameter
         if (pRecState->iColumns > 0)
         {
            if (pDsXml->bOpenTag)
            {
               pPos = pDsXml->WriteFinishTag(pPos, TRUE);
            }
            else
            {
               if (strcmp(pDsXml->LastTag, szFIELDDEF) !=0)
                  pPos = pDsXml->WriteEndTag
                     (pPos, szFIELDDEF /* pRecState->pFieldDesc[pRecState->iColumns-1].szFieldName */ , TRUE);
            }
         }
         pPos = pDsXml->WriteEndTag(pPos, szFIELDS, TRUE);
         pPos = pDsXml->WriteOpenTag(pPos, szPARAMS, TRUE);
         dsPcklInfo.pInsertionPoint = pPos;
      }

      rslt = GetFldObj(iType, bBigEndian, pDsXml, &pFldObj);
      if (rslt)
         goto Exit;

      bAsParam = (XmlTypeOfAttr(pszAttr) == NULL);

      if (((iType &dsTypeBitsMask) >> dsSizeBitsLen) == dsfldZSTRING)
      {
         pzType = NULL; // default is string type
      }
      else
      {
         rslt = XmlMakeType(iType, &pzType, NULL);
         if (rslt)
            goto Exit;
      }

      // Workaround: Don't write FIELDPROPS. Bug #116346
      if (stricmp(pszAttr, szFIELDPROPS) == 0)
         goto Exit;

      if (strcmp(pszAttr, szSUBTYPE) == 0 && eAttrArea == fldAttrArea)
      {
         pDSDATAPACKETFLDDescX pFldEntry;
         pFldEntry = pRecState->pFlds_List->GetFldDesc(pRecState->iColumns);
         strcpy(pFldEntry->szSubType, (pCHAR) &pValue[sizeof(UINT16)]);
      }
      if ((iType & (dsVaryingFldType))) // NOTE: sfldArrayFldType works fine!
      { // Variable length: length is included in pVale and iLen!
         pValue += pFldObj->iLen;
         iLen -= pFldObj->iLen;
         if (pValue[iLen-1] == 0 && pzType == NULL) // If zeroterminated and string-type
            iLen--;
      }

      if (bAsParam)
      {
         if (pDsXml->bOpenTag)
            pPos = pDsXml->WriteFinishTag(pPos, FALSE); // Not empty
         pPos = pDsXml->WriteOpenTag(pPos, szOPTPARAM, TRUE); // <PARAM  ..
         Tmp[0] = 0;
         if (pszAttr)
         {
            strcpy(Tmp, pszAttr); // Could be a readonly string
            pPos = pDsXml->WriteAttribute(pPos, szAttrName, Tmp); // <PARAM name="<pszAttr>"..
         }

         pName = szAttrValue;
         if (pzType == NULL)
         {
            Tmp[0] = 0;
            if (pValue)
            {
               strcpy(Tmp, (pCHAR)pValue); // Could be a readonly string
               pPos = pDsXml->WriteAttribute(pPos, pName, Tmp); // <PARAM name=".." Value=".."
            }
         }
         else
         {
            pTmp = pFldObj->FldPut((pBYTE) &Tmp, pValue, iLen);
            *pTmp = 0;
            pPos = pDsXml->WriteAttribute(pPos, pName, Tmp);
         }
         Tmp[0] = 0;
         if (pzType)
         {
            strcpy(Tmp, (pCHAR)pzType); // Could be a readonly string
            pPos = pDsXml->WriteAttribute(pPos, szAttrType, Tmp);
         }
         if (iType & dsIncInDelta)
         { // Roundtrip bit
            strcpy(Tmp, "True");
            pPos = pDsXml->WriteAttribute(pPos, szROUNDTRIP, Tmp);
         }
         pPos = pDsXml->WriteFinishTag(pPos, TRUE);

      }
      else
      { // As Attribute
         pCHAR pIns = NULL;
         pBYTE pPosSave;

         if ( /* eAttrArea==fldAttrArea && */ dsPcklInfo.pInsertionPoint !=NULL && dsPcklInfo.pInsertionPoint < pPos)
         {
            pIns = new CHAR[600];
            pPosSave = pPos;
            pPos = (pBYTE)pIns;
            *pPos = ' ';
            pPos++;
         }

         pName = pszAttr;
         if (pzType == NULL)
         {
            Tmp[0] = 0;
            if (pValue)
            {
               strcpy(Tmp, (pCHAR)pValue); // Could be a readonly string
               pPos = pDsXml->WriteAttribute(pPos, pName, Tmp); // ..<pszAttr>="<pValue>"
            }
         }
         else
         {
            if (iLen > 100 && iType == 0x820004) // Special case of logfile, array of ints
            {
               UINT32 iCnt = iLen/4;
               UINT32 iSize;
               pBYTE pB, pB1;
               if (iCnt <1000)
                  iSize = iCnt*4;
               else if (iCnt<10000)
                  iSize = iCnt*5;
               else
                  iSize = iCnt*8;
               pB = new BYTE[iSize];
               pB1 = pFldObj->FldPut(pB, pValue, iLen);
               *pB1 = 0;
               pPos = pDsXml->WriteAttribute(pPos, pName, (pCHAR)pB);
               delete pB;
            }
            else
            {
               pTmp = pFldObj->FldPut((pBYTE) &Tmp, pValue, iLen);
               *pTmp = 0;
               pPos = pDsXml->WriteAttribute(pPos, pName, Tmp);
            }
         }
         if (pIns)
         {
            UINT32 iInsLen = (UINT32)(pPos-(pBYTE)pIns);
            UINT32 iMove = pPosSave-dsPcklInfo.pInsertionPoint;
            memmove(dsPcklInfo.pInsertionPoint+iInsLen, dsPcklInfo.pInsertionPoint, iMove);
            memmove(dsPcklInfo.pInsertionPoint, pIns, iInsLen);
            pPos = pPosSave+iInsLen;
            dsPcklInfo.pInsertionPoint = dsPcklInfo.pInsertionPoint+iInsLen;
            delete pIns;
         }
         else
            dsPcklInfo.pInsertionPoint = pPos;
      }

      if (eAttrArea == fldAttrArea)
      {

      }
      else
      {
         pRecState->iOptParams++;
         if (iCurRecState == 0)
            this->iAttrCnt++;
      }
      // StoreAndExit:
      dsPcklInfo.pFldDescCurrLoc = pPos;
      dsPcklInfo.pAttrCountLoc = pPos;
      dsPcklInfo.pAttrCurrLoc = pPos;
      dsPcklInfo.pDataCurrLoc = pPos;
   }

Exit:
   if (pFldObj)
      delete pFldObj;
   return rslt;
}

DBIResult DBIFN DSDATAPACKET::PutField(PCKLFldStauts eFldStatus, // Field Status
   UINT32 iLength, // length of value
   pBYTE pValue) // Pointer to the new field value
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iType; // type of attribute
   pDSPCKLHdrInfo pHdrInfo;
   UINT32 iSizeAvail;
   UINT32 iRequiredSize;
   UINT32 iLengthInd = 0;
   pBYTE pData, pPtr;

   pDSRECState pRecState = paRecStates[iCurRecState];
   UINT32 iCurrFldNo;
   UINT32 iNestedRows;
   UINT16 iNewState = 0;
   UINT32 iLengthReal;
   pDSPROVADTFLDDesc pAdtFldDes;

   // All column descriptors should be supplied first.
   pHdrInfo = (pDSPCKLHdrInfo)pDataPacketBuf;
   if (pHdrInfo->iColumnCount < (UINT16)iColumns)
   {
      rslt = SetError(DBIERR_NA);
      goto Exit;
   }
   if (!pRecState->pAdtFieldDesc)
   {
      rslt = ExpandAllFieldDescs(iRecStatesCnt, paRecStates, bBigEndian, pDsXml);
      if (rslt)
      {
         rslt = SetError(DBIERR_SYSCORRUPT);
         goto Exit;
      }
      if (pDsXml && !(pDsXml->iStyle & (xmlUNTYPED | xmlXMLDATATYPED)))
      {
         dsPcklInfo.pDataCurrLoc = pDsXml->WriteHead(dsPcklInfo.pDataCurrLoc);
         dsPcklInfo.pFldDescCurrLoc = dsPcklInfo.pDataCurrLoc;
      }
   }
   iCurrFldNo = pRecState->iCurrFldNo;
   pAdtFldDes = iCurrFldNo ? &pRecState->pAdtFieldDesc[iCurrFldNo-1] : NULL;

   // Just set the unchanged bit and return
   if (!pValue || (eFldStatus == fldIsNull) || eFldStatus == fldIsUnChanged)
   { // Blank field given
      if (iCurrFldNo == 0)
      { // Cannot set a blank on the attribute field
         rslt = SetError(DBIERR_INVALIDPARAM);
         goto Exit;
      }
      if (pDsXml)
      { // Put null-value
         dsPcklInfo.pDataCurrLoc = pAdtFldDes->pFldObj->FldPut(dsPcklInfo.pDataCurrLoc, NULL, 0);
         // Stores length byte and everything
      }
      else
      {
         // null indicators are after the row status field.
         pPtr = pRecState->pRowBeginLoc + pAdtFldDes->iNULLOffs; // Includes 1 for attribute field!
         if (eFldStatus == fldIsUnChanged)
            *pPtr |= pAdtFldDes->iMask2;
         else
            *pPtr |= pAdtFldDes->iMask1;
      }
      goto Finish;
   }

   // Value given
   if (iCurrFldNo == 0)
   {
      if (bFirstRow)
      {
         bFirstRow = FALSE;
         if (pDsXml && !(pDsXml->iStyle & (xmlUNTYPED | xmlXMLDATATYPED)))
            dsPcklInfo.pDataCurrLoc = pDsXml->WriteHead(dsPcklInfo.pDataCurrLoc);
      }

      // Atribute field
      iLengthInd = 0;
      iLength = sizeof(BYTE);
      if (!bMetaDataDone)
      { // First putfield
         UINT32 iOffs;

         if (iCurRecState > 0)
         {
            rslt = SetError(DBIERR_SYSCORRUPT);
            goto Exit;
         }
         bMetaDataDone = TRUE;
         iOffs = (UINT32)(dsPcklInfo.pDataCurrLoc - pDataPacketBuf);
         if (iOffs <= 0xffff)
         {
            pHdrInfo->iReserved = (UINT16)iOffs;
            pHdrInfo->iProperties = (PCKLProps)(pcklpropsCONTAINMETALEN | pHdrInfo->iProperties);
         }
         if (pDsXml)
         {
            if (pDsXml->iStyle & xmlXMLSCHEMA)
            {
               if (pDsXml->bOpenTag)
                  dsPcklInfo.pDataCurrLoc = pDsXml->WriteFinishTag(dsPcklInfo.pDataCurrLoc, TRUE);
               else
               {
                  if (pRecState->iOptParams>0 && strcmp(pDsXml->LastTag, szOPTPARAM) == 0)
                     dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, szPARAMS, TRUE);
               }
               // If no parameters (And Addattribute was never called), we need to finish up.
               if (pRecState->iOptParams == 0 && !bOptParamsDone)
               {
                  if (strcmp(pDsXml->LastTag, szOPTPARAM) == 0)
                  {
                     if (strcmp(pDsXml->LastTag, szFIELDDEF) !=0)
                        dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, szFIELDDEF, TRUE);
                  }
                  dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, szFIELDS, TRUE);
                  dsPcklInfo.pDataCurrLoc = pDsXml->WriteOpenTag(dsPcklInfo.pDataCurrLoc, szPARAMS, TRUE);
                  dsPcklInfo.pDataCurrLoc = pDsXml->WriteFinishTag(dsPcklInfo.pDataCurrLoc, TRUE);
               }

               dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, szMETADATA, TRUE);
            }
            dsPcklInfo.pDataCurrLoc = pDsXml->WriteBeginTag(dsPcklInfo.pDataCurrLoc, szDATA, NULL, TRUE, TRUE);
         }
      }
      if (pDsXml)
      {
         if (bAsAttrs)
         {
            dsPcklInfo.pDataCurrLoc = pDsXml->WriteOpenTag(dsPcklInfo.pDataCurrLoc, pRecState->pszROW, TRUE);

            pRecState->pInsertionOffs = dsPcklInfo.pDataCurrLoc-pDataPacketBuf;
         }
         else
            dsPcklInfo.pDataCurrLoc = pDsXml->WriteBeginTag(dsPcklInfo.pDataCurrLoc, pRecState->pszROW, NULL, TRUE,
            TRUE);
      }
   }
   else
   {
      iType = pAdtFldDes->iBaseFieldType; // [iFieldIDParent-1].iFieldType;
      iNewState = pAdtFldDes->iNewRecState;
      if (iNewState)
      {
         paRecStates[iNewState]->pEmbeddedRowCount = NULL;
         iNestedRows = *(pUINT32)pValue; // Could be 0 !
         if (iNestedRows == (UINT32) -1)
         { // Special signal, end-of-rows must be signaled explicitly
            paRecStates[iNewState]->pEmbeddedRowCount = (pUINT32)dsPcklInfo.pDataCurrLoc;
         }
         else
         {
            if (iNestedRows & dsDELAYEDBIT)
               iNestedRows = 0;
         }
      }

      if (!(iType & (dsVaryingFldType | dsArrayFldType)))
      {
         // fixed length field.
         iLength = pAdtFldDes->pFldObj->iLen;
      }
      else
      { // variable length field.
         iLengthInd = pAdtFldDes->pFldObj->iLen;
      }
   }
   if (iLength & dsDELAYEDBIT)
   {
      if (pDsXml)
      {
         rslt = DBIERR_XMLNODELAYEDFETCHING;
         goto Exit;
      }
      iLengthReal = 0;
   }
   else
      iLengthReal = iLength;

   iRequiredSize = iLengthInd + iLengthReal + ((pRecState->iAdtColumns + 3) / 4);
   if (pDsXml)
   {
      iRequiredSize = 2*iRequiredSize+1000; // +1000 pads the buffer for some unkown issue.  Review later.
   }
   iSizeAvail = this->iTotalSize - ((pBYTE)dsPcklInfo.pDataCurrLoc - (pBYTE)pDataPacketBuf);
   if (iSizeAvail < iRequiredSize)
   {
      rslt = GrowSize(iRequiredSize);
      if (rslt)
         goto Exit;
   }

   pData = (pBYTE)dsPcklInfo.pDataCurrLoc;

   if (iCurrFldNo == 0)
   { // Store beginning of row
      if (pDsXml)
      {
         if (pValue && *(pUINT8)pValue !=0)
         {
            pData = pDsXml->WriteAttribute(pData, szRowState, pDsXml->FromINT8(pValue));
         }
      }
      else
      {
         pRecState->pRowBeginLoc = pData;
         // Atribute field (1 BYTE)
         *pData = *pValue;
         pData++;
         // Add the null bytes and set them to zero.
         memset((pBYTE)pData, 0, ((pRecState->iAdtColumns + 3) / 4));
         pData += ((pRecState->iAdtColumns + 3) / 4);
      }
   }
   else
   {
      if (iNewState && pDsXml)
      { // Begin embedding
         pData = pDsXml->WriteBeginTag(pData, pAdtFldDes->pFldObj->pNamePtr, NULL, TRUE, TRUE);
         if (iNestedRows == 0)
            pData = pDsXml->WriteEndTag(pData, pAdtFldDes->pFldObj->pNamePtr, TRUE);

      }
      else
         pData = pAdtFldDes->pFldObj->FldPut(pData, pValue, iLength); // Stores length byte and everything
   }

   dsPcklInfo.pDataCurrLoc = (pBYTE)pData;

Finish:

   ++pRecState->iCurrFldNo;
   if (iNewState && iNestedRows)
   {
      iCurRecState = iNewState;
      pRecState = paRecStates[iNewState];
      pRecState->iRowCountDown = iNestedRows;
      pRecState->iCurrFldNo = 0;
   }
   else // Note: embedded rows could be last field, so do not finish row until rnested rows are done
   {
   Again:
      if (pRecState->iCurrFldNo > pRecState->iAdtColumns)
      {
         if (pDsXml)
         { // Copied below in EndOfNested
            if (bAsAttrs && pDsXml->bOpenTag)
               dsPcklInfo.pDataCurrLoc = pDsXml->WriteFinishTag(dsPcklInfo.pDataCurrLoc, TRUE);
            else
               dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, pRecState->pszROW, TRUE);
         }
         pRecState->iCurrFldNo = 0;
         // Full row was given
         if (iCurRecState == 0)
         { // Update global info
            pHdrInfo = (pDSPCKLHdrInfo)pDataPacketBuf;
            pHdrInfo->iRowCount++;
            this->iRows++;
         }
         else
         {
            if (--pRecState->iRowCountDown == 0)
            {
               iCurRecState = pRecState->iPrevRecState; // Done with this level
               pRecState = paRecStates[iCurRecState];
               if (pDsXml)
               {
                  pDSPROVADTFLDDesc pAdtFldDes = &pRecState->pAdtFieldDesc[pRecState->iCurrFldNo-1-1];
                  dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, pAdtFldDes->pFldObj->pNamePtr,
                     TRUE);
               }
               goto Again;
            }
         }
      }
   }
Exit:

   return rslt;
}

DBIResult DBIFN DSDATAPACKET::EndOfNestedRows(VOID)
{
   DBIResult rslt = DBIERR_NONE;
   pDSRECState pRecState = paRecStates[iCurRecState];

   if (pRecState->iCurrFldNo != 0 || pRecState->pEmbeddedRowCount == NULL)
   {
      rslt = SetError(DBIERR_NA);
      goto Exit;
   }
   if (pDsXml)
   {
   }
   else
   {
      *pRecState->pEmbeddedRowCount = ConvertUInt32(((UINT32)(-1)) - pRecState->iRowCountDown);
      pRecState->pEmbeddedRowCount = NULL;
   }

Again:
   iCurRecState = pRecState->iPrevRecState; // Done with this level
   pRecState = paRecStates[iCurRecState];

   if (pDsXml)
   {
      pDSPROVADTFLDDesc pAdtFldDes = &pRecState->pAdtFieldDesc[pRecState->iCurrFldNo-1-1];
      dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, pAdtFldDes->pFldObj->pNamePtr, TRUE);
   }
   if (pRecState->iCurrFldNo > pRecState->iAdtColumns)
   {
      if (pDsXml)
      {
         if (bAsAttrs && pDsXml->bOpenTag)
            dsPcklInfo.pDataCurrLoc = pDsXml->WriteFinishTag(dsPcklInfo.pDataCurrLoc, TRUE);
         else
            dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, pRecState->pszROW, TRUE);
      }

      pRecState->iCurrFldNo = 0;
      // Full row was given
      if (iCurRecState == 0)
      { // Update global info
         pDSPCKLHdrInfo pHdrInfo;
         pHdrInfo = (pDSPCKLHdrInfo)pDataPacketBuf;
         pHdrInfo->iRowCount++;
         this->iRows++;
      }
      else
      {
         if (--pRecState->iRowCountDown == 0)
         {
            goto Again; // Should not happen, since all levels probably uses the method
         }
      }
   }
Exit:
   return rslt;
}

// Return pointer to the finished 'pickle'
DBIResult DBIFN DSDATAPACKET::GetDataPacket(SAFEARRAY **ppPickle)
{
   UINT32 iPickleSize;

   if (!ppPickle)
      return SetError(DBIERR_INVALIDPARAM);
   if (!bMetaDataDone)
   { // Special-case where datapacket is empty)
      pDSPCKLHdrInfo pHdrInfo = (pDSPCKLHdrInfo)pDataPacketBuf;
      UINT32 iOffs = (UINT32)(dsPcklInfo.pDataCurrLoc - pDataPacketBuf);
      if (iOffs <= 0xffff)
      {
         pHdrInfo->iReserved = (UINT16)iOffs;
         pHdrInfo->iProperties = (PCKLProps)(pcklpropsCONTAINMETALEN | pHdrInfo->iProperties);
      }
      if (pDsXml && pDsXml->iStyle & (xmlXMLSCHEMA))
      { // copy from putfield
         pDSRECState pRecState = paRecStates[iCurRecState];

         if (pDsXml->bOpenTag)
            dsPcklInfo.pDataCurrLoc = pDsXml->WriteFinishTag(dsPcklInfo.pDataCurrLoc, TRUE);
         else
         {
            if (pRecState->iOptParams>0 && strcmp(pDsXml->LastTag, szOPTPARAM) == 0)
               dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, szPARAMS, TRUE);
         }
         // If no parameters (And Addattribute was never called), we need to finish up.
         if (pRecState->iOptParams == 0 && !bOptParamsDone)
         {
            if (strcmp(pDsXml->LastTag, szOPTPARAM) == 0)
            {
               if (strcmp(pDsXml->LastTag, szFIELDDEF) !=0)
                  dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, szFIELDDEF, TRUE);
            }
            dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, szFIELDS, TRUE);
            dsPcklInfo.pDataCurrLoc = pDsXml->WriteOpenTag(dsPcklInfo.pDataCurrLoc, szPARAMS, TRUE);
            dsPcklInfo.pDataCurrLoc = pDsXml->WriteFinishTag(dsPcklInfo.pDataCurrLoc, TRUE);
         }

         dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, szMETADATA, TRUE);
      }

      if (pDsXml && pDsXml->iStyle & (xmlUNTYPED | xmlXMLDATATYPED))
         dsPcklInfo.pDataCurrLoc = pDsXml->WriteBeginTag(dsPcklInfo.pDataCurrLoc, szDATA, NULL, TRUE, TRUE);

   }
   if (pDsXml)
   {
      dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, szDATA, TRUE);
      dsPcklInfo.pDataCurrLoc = pDsXml->WriteEndTag(dsPcklInfo.pDataCurrLoc, szDATAPACKET, TRUE);
   }
   ConvertHeader(bBigEndian, (pVOID)pDataPacketBuf);
   if (pDsXml && pDsXml->iStyle & (xmlUNTYPED | xmlXMLDATATYPED))
   { // Overwrite-header (xml-case)
      pDsXml->WriteHead(pDataPacketBuf);
   }
   else if (pDsXml)
   {
      pDSPCKLHdrInfo pHdrInfo = (pDSPCKLHdrInfo)pDataPacketBuf;
      pHdrInfo->iProperties = (PCKLProps)(pHdrInfo->iProperties | 0x8000);
   }

   GetSize(&iPickleSize);
   SATruncate(pSa, iPickleSize);

   *ppPickle = (SAFEARRAY*)pSa;
   return DBIERR_NONE;
}

// Get the size of the pickle.
DBIResult DBIFN DSDATAPACKET::GetSize(pUINT32 piPickleSize)
{
   pDSPCKLHdrInfo pHdrInfo;

   if (!piPickleSize)
      return SetError(DBIERR_INVALIDPARAM);
   *piPickleSize = 0;

   pHdrInfo = (pDSPCKLHdrInfo)pDataPacketBuf;
   // If rows or dataset attributes exist.
   if (pHdrInfo->iRowCount || this->iAttrCnt || this->iColumns)
      *piPickleSize = ((pBYTE)dsPcklInfo.pDataCurrLoc - (pBYTE)pDataPacketBuf);
   else
      *piPickleSize = ((pBYTE)dsPcklInfo.pFldDescCurrLoc - (pBYTE)pDataPacketBuf);
   return DBIERR_NONE;
}

DBIResult DSDATAPACKET::GrowSize(UINT32 iSize) // required size
{
   pBYTE pNewBuf;
   UINT32 i;

   // Alternatively double the memory size
   if (bNoOfBufAllocs)
   {
      if ((iSize < this->iTotalSize) && (iSize < DSMAXPCKLALLOCSIZE))
      {
         iSize = this->iTotalSize;
         if (iSize > DSMAXPCKLALLOCSIZE)
            iSize = DSMAXPCKLALLOCSIZE;
      }
      bNoOfBufAllocs = FALSE;
   }
   else
   {
      if (iSize < DSPCKLINITSIZE)
         iSize = DSPCKLINITSIZE;
      bNoOfBufAllocs = TRUE;
   }

   pNewBuf = (pBYTE)SARealloc(pSa, (this->iTotalSize + iSize));
   if (!pNewBuf)
      return SetError(DBIERR_NOMEMORY);

   this->iTotalSize += iSize;
   if (dsPcklInfo.pFldDescCurrLoc)
      dsPcklInfo.pFldDescCurrLoc = pNewBuf + (dsPcklInfo.pFldDescCurrLoc - pDataPacketBuf);
   for (i = 0; i < iRecStatesCnt; i++)
   {
      pDSRECState pRecState = paRecStates[i];

      if (pRecState && pRecState->pRowBeginLoc)
      {
         pRecState->pRowBeginLoc = pNewBuf + (pRecState->pRowBeginLoc - pDataPacketBuf);
      }
      if (pRecState && pRecState->pEmbeddedRowCount)
      {
         pRecState->pEmbeddedRowCount = (pUINT32)(pNewBuf + ((pBYTE)pRecState->pEmbeddedRowCount - pDataPacketBuf));
      }
   }
   if (dsPcklInfo.pAttrCurrLoc)
      dsPcklInfo.pAttrCurrLoc = pNewBuf + (dsPcklInfo.pAttrCurrLoc - pDataPacketBuf);
   if (dsPcklInfo.pDataCurrLoc)
      dsPcklInfo.pDataCurrLoc = pNewBuf + (dsPcklInfo.pDataCurrLoc - pDataPacketBuf);
   if (dsPcklInfo.pFldAttrCountLoc)
      dsPcklInfo.pFldAttrCountLoc = pNewBuf + (dsPcklInfo.pFldAttrCountLoc - pDataPacketBuf);
   if (dsPcklInfo.pAttrCountLoc)
      dsPcklInfo.pAttrCountLoc = pNewBuf + (dsPcklInfo.pAttrCountLoc - pDataPacketBuf);

   if (dsPcklInfo.pInsertionPoint)
      dsPcklInfo.pInsertionPoint = pNewBuf + (dsPcklInfo.pInsertionPoint - pDataPacketBuf);

   // Update paRecState

   pDataPacketBuf = pNewBuf;
   return DBIERR_NONE;
}

// Reset all data (in order to create partial data)
// Datapackets will not contain meta-info.
DBIResult DBIFN DSDATAPACKET::Reset(VOID)
{
   if (iColumns == 0)
      return SetError(DBIERR_NA);
   memset((pBYTE) &dsPcklInfo, 0, sizeof(DSPCKLInfo));
   Init(0, (UINT16)iColumns, NULL);
   iAttrCnt = 0;
   iRows = 0;
   return DBIERR_NONE;
}

// Return number of fielddescriptors, including embedded tables etc.
// (Same as iColumns above, only for external COM-users)
DBIResult DBIFN DSDATAPACKET::GetColumnCount(pUINT32 piCount)
{
   *piCount = iColumns;
   return DBIERR_NONE;
}

// Return all fielddescriptors
// (Same as pFieldDesc above, only for external COM-users)
DBIResult DBIFN DSDATAPACKET::GetColumnDescs(pDSDATAPACKETFLDDesc pFldDes)
{
   if (pFlds_List)
   {
      UINT32 i;
      for (i = 0; i<iColumns; i++)
         memmove((pBYTE) &pFldDes[i], (pBYTE)pFlds_List->GetEntry(i+1), sizeof(DSDATAPACKETFLDDesc));
   }
   return DBIERR_NONE;
}

// =======================================================================
// Interfaces to Pickle Extract Class
// =======================================================================

DBIResult dsCheckPickle(pBYTE pPickle)
{
   if (((DSPCKLHDRInfo*)pPickle)->iMagicNo != MAGICCOOKIE && ((DSPCKLHDRInfo*)pPickle)->iMagicNo != MAGICCOOKIEOLD)
      return SetError(DBIERR_DATAPACKETMISMATCH); // DBIERR_INVALIDPICKLE;

   if (((DSPCKLHDRInfo*)pPickle)->iMagicNo != MAGICCOOKIEOLD && (((DSPCKLHDRInfo*)pPickle)
         ->iMinorVer > MAX_PICKLEVERSION || ((DSPCKLHDRInfo*)pPickle)->iMajorVer > MAX_PICKLEVERSION))
      return SetError(DBIERR_DATAPACKETMISMATCH); // DBIERR_INVALIDPICKLEVERSION;

   return DBIERR_NONE;
}

DSEXTRACT::DSEXTRACT(VOID)
{
   InitObj();
   iRefCount = 0;
   iObjCount++;
}

DSEXTRACT::~DSEXTRACT()
{
   if (pFldAttrObj)
      delete pFldAttrObj;
   DelRecStates();
   if (pDsXml)
      delete pDsXml;
   iObjCount--;
}

// Initializes all values
VOID DSEXTRACT::InitObj()
{
   // Public values
   iAttrCnt = 0;
   iColumns = 0;
   iRows = 0;
   iProperties = (PCKLProps)0;
   iAttrCurrent = 1;
   iRowCurrent = 1;
   iFieldCurrent = 0;

   // Private variables
   bFldOptParams = FALSE;
   bMetaDataDone = FALSE;
   pCurrPos = NULL;
   iCurRecState = 0;
   iRecStatesCnt = 0;

   memset(paRecStates, 0, sizeof(paRecStates));

   pSa = NULL;
   bBigEndian = FALSE;
   memset(&HdrInfo, 0, sizeof(DSPCKLHDRInfo));
   pFldAttrObj = NULL;
   pDsXml = NULL;
   bFirstRow = FALSE; // TRUE
   bEndOfThisLevel = FALSE; // XML
   bUTF8METADATA = FALSE;
   iANSICodePage = 0;
   return;
}

DBIResult DBIFN DSEXTRACT::SetMETADATAMode(BOOL bMETADATAMode)
{
   bUTF8METADATA = bMETADATAMode;
   return DBIERR_NONE;
}

DBIResult DBIFN DSEXTRACT::SetANSICodePage(INT32 iCodePage)
{
   iANSICodePage = iCodePage;
   return DBIERR_NONE;
}

DBIResult DBIFN DSEXTRACT::Init(SAFEARRAY *pSa)
{
   DBIResult rslt = DBIERR_NONE;
   pBYTE pPickle;
   pDSPCKLHdrInfo pHdrInfo;

   if (!pSa)
   {
      rslt = SetError(DBIERR_NA);
      goto Exit;
   }

   pPickle = (pBYTE)SAGetPtr((SAFEARRAY*)pSa);
   if (!pPickle)
   {
      rslt = SetError(DBIERR_NA);
      goto Exit;
   }

   // version control.
   if (dsCheckPickle(pPickle))
   {
      SARelPtr(pSa);
      return XMLInitExtract(pSa);
   }
   pHdrInfo = (pDSPCKLHdrInfo)pPickle;
   memmove(&HdrInfo, pHdrInfo, sizeof(DSPCKLHDRInfo));
   ConvertHeader(bBigEndian, (pVOID) &HdrInfo);

   if (HdrInfo.iProperties & 0x8000)
   { // Data is in XML
      pDsXml = new DSXML_W(); // default
      pDsXml->Init(0, FALSE, 5, TRUE, FALSE, iANSICodePage);
      bFirstRow = TRUE;
   }

   iColumns = HdrInfo.iColumnCount;
   iRows = HdrInfo.iRowCount;

   if (HdrInfo.iProperties & pcklpropsMETADATA_INCL)
      iProperties = (PCKLProps)pcklpropsMETADATA_INCL;

   NewRecState(iColumns, 0, 0, &iCurRecState);
   pCurrPos = (pBYTE)pPickle + HdrInfo.iHeaderSize;
   this->pSa = (SAFEARRAY*)pSa;
   if (pDsXml && !pFldAttrObj)
   {
      pFldAttrObj = new FLDCInt8(bBigEndian, FALSE);
      pFldAttrObj->pNamePtr = szAttrFld;
      pFldAttrObj->pDsXml = pDsXml;
   }
   SARelPtr(pSa);
Exit:

   return rslt;
}

HRESULT DBIFN DSEXTRACT::QueryInterface(REFIID riid, void** ppv)
{
#ifdef MIDAS_DLL
   if (IsEqualCLSID(riid, IID_MDATAPACKETREAD) || IsEqualCLSID(riid, IID_IUnknown))
#else
      if (IsEqualCLSID(riid, IID_DATAPACKETREAD) || IsEqualCLSID(riid, IID_IUnknown))
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

UINT32 DBIFN DSEXTRACT::AddRef(VOID)
{
   return++iRefCount;
}

UINT32 DBIFN DSEXTRACT::Release(VOID)
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

// Create and initialize a new recstate structure, linking it to its caller
DBIResult DBIFN DSEXTRACT::NewRecState(UINT16 iCols, UINT16 iFieldNo, UINT32 iCurRecState, pUINT32 piRecState)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iRecState;
   pDSRECState pRecState;

   if (iRecStatesCnt < MAXRECSTATES-1)
   {
      iRecState = ++iRecStatesCnt;
   }
   else
   {
      rslt = SetError(DBIERR_NA);
      goto Exit;
   }

   pRecState = new DSRECState;
   paRecStates[iRecState-1] = pRecState;
   ZeroMem(pRecState, sizeof(DSRECState));
   pRecState->iPrevRecState = iCurRecState;
   pRecState->iParentFieldNo = iFieldNo;
   pRecState->iColumnsInitial = iCols; // Number of fielddescs
   pRecState->pEmbeddedRowCount = NULL;
   pRecState->pAttr_List = new Attr_List(NULL);
   pRecState->pFlds_List = new Flds_List(iCols);
   pRecState->pszROW = NULL;
   *piRecState = iRecState-1;

Exit:
   return rslt;
}

// Adds additional 'partial' pickle for extraction
DBIResult DBIFN DSEXTRACT::AddDataPacket(SAFEARRAY *pSa)
{
   DBIResult rslt;
   pBYTE pPickle;
   pDSPCKLHdrInfo pHdrInfo;

   if (!pSa)
      return SetError(DBIERR_INVALIDPARAM);

   pPickle = (pBYTE)SAGetPtr((SAFEARRAY*)pSa);
   if (!pPickle)
      return SetError(DBIERR_INVALIDPARAM);

   // version control.
   if (pDsXml)
      return XMLAddDataPacket(pSa, pPickle);

   rslt = dsCheckPickle(pPickle);
   if (rslt)
   {
      SARelPtr(pSa);
      return XMLAddDataPacket(pSa, pPickle);
   }

   pHdrInfo = (pDSPCKLHdrInfo)pPickle;
   memmove(&HdrInfo, pHdrInfo, sizeof(DSPCKLHDRInfo));
   ConvertHeader(bBigEndian, (pVOID) &HdrInfo);

   iColumns = HdrInfo.iColumnCount;
   iRows = HdrInfo.iRowCount;
   this->pSa = (SAFEARRAY*)pSa;
   iProperties = (PCKLProps)0;
   if (HdrInfo.iProperties & pcklpropsMETADATA_INCL)
      iProperties = (PCKLProps)(iProperties | pcklpropsMETADATA_INCL);

   if (HdrInfo.iProperties & pcklpropsCONTAINMETALEN)
      iProperties = (PCKLProps)(iProperties | pcklpropsCONTAINMETALEN);

   iRowCurrent = 1;
   if (HdrInfo.iProperties & pcklpropsCONTAINMETALEN)
   {
      pCurrPos = (pBYTE)pPickle + HdrInfo.iReserved;
      if (iRows == 0)
         this->pSa = NULL;
   }
   else
      pCurrPos = (pBYTE)pPickle + HdrInfo.iHeaderSize; // sizeof(DSPCKLHdrInfo);

   SARelPtr(this->pSa);
   return DBIERR_NONE;
}

DBIResult DBIFN DSEXTRACT::XMLAddDataPacket(SAFEARRAY *pSa, pBYTE pPickle)
{
   DBIResult rslt;
   UINT32 iXmlLen = pSa->rgsabound[0].cElements;

   if (pDsXml == NULL)
   {
      pDsXml = new DSXML_W();
      rslt = pDsXml->Init(0, FALSE, 0, TRUE, bUTF8METADATA, iANSICodePage);
      if (!rslt)
         goto Exit;
   }

   rslt = pDsXml->pXmlParse->Init(iXmlLen, (pCHAR)pPickle);
   if (rslt)
   {
      rslt = SetError(DBIERR_NA); // other code!
      goto Exit;
   }

   iRows = (UINT32) -1;
   this->pSa = (SAFEARRAY*)pSa;

   iProperties = (PCKLProps)0;
   iRowCurrent = 1;

   if (!bMetaDataDone)
   {
      rslt = ExpandAllFieldDescs(iRecStatesCnt, paRecStates, FALSE, pDsXml);
      if (!rslt)
         goto Exit;
      bMetaDataDone = TRUE;
   }
   if (!pFldAttrObj)
   {
      pFldAttrObj = new FLDCInt8(bBigEndian, FALSE);
      pFldAttrObj->pNamePtr = szAttrFld;
   }

Exit:
   return rslt;
}

UINT32 DBIFN DSEXTRACT::GetXMLMode(VOID)
{
   if (pDsXml)
      return pDsXml->iStyle;
   return 0;
}

DBIResult DBIFN DSEXTRACT::SetXMLMode(INT iMode)
{
   if (iMode && pDsXml == NULL)
   {
      pDsXml = new DSXML_W();
      pDsXml->Init(3, TRUE, iMode, TRUE, bUTF8METADATA, iANSICodePage);
   }
   return DBIERR_NONE;
}

// Extract the next column descriptor.
DBIResult DBIFN DSEXTRACT::GetColumnDesc(pDSDATAPACKETFLDDesc pFldDes)
{
   DBIResult rslt = DBIERR_NONE;
   pBYTE pPtr;
   BYTE iNameLen;
   UINT32 iNameLenSafe;
   pDSRECState pRecState = paRecStates[iCurRecState];
   UINT32 iFieldType;
   DSDATAPACKETFLDDescX FldDesX;

   ZeroMem((pBYTE) &FldDesX, sizeof(DSDATAPACKETFLDDescX));

   if (pDsXml)
      return XMLGetColumnDesc(pFldDes);

   if (bMetaDataDone)
   {
      rslt = SetError(DBIERR_EOF);
      goto Exit;
   }
   if (!pFldDes)
   {
      rslt = SetError(DBIERR_INVALIDPARAM);
      goto Exit;
   }

   if (pRecState->iColumns == pRecState->iColumnsInitial)
   {
      rslt = SetError(DBIERR_EOF);
      goto Exit;
   }
   if (iAttrCurrent <= iAttrCnt)
   {
      rslt = SetError(DBIERR_NA); // Reading attributes!
      goto Exit;
   }

   pPtr = pCurrPos;
   iNameLen = *((pBYTE)pPtr); // ConvertInt8()
   pPtr += sizeof(BYTE);
   iNameLenSafe = iNameLen;
   if (iNameLen > DBIMAXNAMELEN)
      iNameLenSafe = DBIMAXNAMELEN;

   if (iNameLen == 0)
   {
      // Field name can't be an empty string. T.Ramesh - 05/15/2002.
      rslt = SetError(DBIERR_INVALIDFIELDNAME);
      goto Exit;
   }

   // copy the field descriptor information
   memmove(pFldDes->szFieldName, pPtr, iNameLenSafe); // ConvertZString
   pFldDes->szFieldName[iNameLenSafe] = 0;

   pPtr += iNameLen;

   pFldDes->iFieldType = ConvertInt32(*((pINT32)pPtr));
   pPtr += sizeof(INT32);
   pFldDes->iAttributes = ConvertInt16(*((pINT16)pPtr));
   pPtr += sizeof(INT16);

   // Copy to local fielddesc
   CopyMem((pBYTE) &FldDesX, pFldDes, sizeof(DSDATAPACKETFLDDesc));
   pRecState->pFlds_List->Add((pBYTE) &FldDesX, NULL);

   // Get the attribute count.
   bFldOptParams = TRUE;
   iAttrCurrent = 1;
   iAttrCnt = ConvertInt16(*((pUINT16)pPtr));
   pPtr += sizeof(UINT16);

   pCurrPos = pPtr;

   iFieldCurrent++;
   pRecState->iColumns++;

   iFieldType = pFldDes->iFieldType & dsTypeBitsMask;
   if ((iFieldType = iFieldType >> dsSizeBitsLen) == dsfldEMBEDDEDTBL)
   { // Create new level
      UINT16 iCols = (UINT16)pFldDes->iFieldType; // & 0x0000ffff ;
      pRecState->iColumnsInitial -= iCols; // Adjust this one
      rslt = NewRecState(iCols, (UINT16)pRecState->iColumns, iCurRecState, &iCurRecState);
   }

Exit:
   return rslt;
}

// Get length of next attribute
// Returns DBIERR_EOF if no more attributes
DBIResult DBIFN DSEXTRACT::GetAttributeLength(pUINT32 piLength)
{
   DBIResult rslt;

   *piLength = (UINT32)(-1);
   rslt = GetNextAttribute(NULL, NULL, piLength, NULL);
   return rslt;
}

// Extract next attribute
DBIResult DBIFN DSEXTRACT::GetNextAttribute(pCHAR pszAttribute, // Attribute
   pUINT32 piType, // Attribute type
   pUINT32 piLen, // lenght of pValue buffer, if applicable
   pBYTE pValue) // value
{
   pBYTE pPtr;
   DBIResult rslt = DBIERR_NONE;
   UINT32 iType;
   UINT32 iLength;
   BYTE iNameLen;
   pDSRECState pRecState = paRecStates[iCurRecState];
   FLDConv *pFldObj = NULL;

   if (pDsXml)
      return XMLGetNextAttribute(pszAttribute, piType, piLen, pValue);

   if (bMetaDataDone)
   {
      rslt = SetError(DBIERR_EOF);
      goto Exit;
   }

   if (iAttrCurrent > iAttrCnt)
   { // No more optional parameters
      if (bFldOptParams)
      {
      Again:
         if (pRecState->iColumns == pRecState->iColumnsInitial)
         {
            bFldOptParams = FALSE;
            iAttrCurrent = 1;
            iAttrCnt = ConvertInt16(*((pUINT16)pCurrPos));
            pCurrPos += sizeof(UINT16);
         }
      }
      else
      {
         if (pRecState->iColumns == pRecState->iColumnsInitial)
         { // State transition! Already read last optional parameters at this level.
            //
            if (iCurRecState == 0)
            { // This point only reached once
               // Start reading rowdata, if any
               // iFieldCurrent == Columns)!
               bMetaDataDone = TRUE;

               if (iRowCurrent > iRows)
               {
                  if (this->pSa)
                     SARelPtr(this->pSa);
                  this->pSa = NULL;
               }
               // initialize all AdtFielddescs
               rslt = ExpandAllFieldDescs(iRecStatesCnt, paRecStates, bBigEndian, pDsXml);
            }
            else
            {
               iCurRecState = pRecState->iPrevRecState; // Done with this level
               pRecState = paRecStates[iCurRecState];
               goto Again;
            }
         }
      }
      rslt = SetError(DBIERR_EOF);
      goto Exit; // Signal end of field-optional parameters
   }

   // Read the attribute

   pPtr = pCurrPos;
   iNameLen = *((pBYTE)pPtr); // ConvertInt16
   pPtr += sizeof(BYTE);

   if (pszAttribute)
   { // Get attribute name
      memmove(pszAttribute, pPtr, iNameLen); // ConvertZString()
      pszAttribute[iNameLen] = 0;
   }
   pPtr += iNameLen;

   // Extract the attribute type and length of the value.
   iType = ConvertInt32(*((pUINT32)pPtr));
   if (piType)
      *piType = iType;
   pPtr += sizeof(UINT32);

   rslt = GetFldObj(iType, bBigEndian, NULL /* pDsXml */ , &pFldObj);
   if (rslt)
      goto Exit;

   pFldObj->FldGet(NULL, pPtr, &iLength, NULL);
   if (piLen)
   {
      if (*piLen < iLength)
      {
         *piLen = iLength;
         rslt = SetError(DBIERR_INVALIDPARAM);
         goto Exit;
      }
      *piLen = iLength;
   }

   // Extract the value of the attribute.
   if (pValue)
   {
      pPtr = pFldObj->FldGet(pValue, pPtr, NULL, NULL);
   }

   if (pszAttribute && pValue) // Otherwise just the length i sreturned
   {
      iAttrCurrent++;
      pCurrPos = pPtr;
   }

Exit:
   if (pFldObj)
      delete pFldObj;
   return rslt;
}

// Get length of next field
DBIResult DBIFN DSEXTRACT::GetFieldLength(pUINT32 piLength)
{
   DBIResult rslt;

   *piLength = (UINT32)(-1);
   rslt = GetField(piLength, NULL, NULL);
   if (rslt == DBIERR_FIELDISBLANK)
      rslt = DBIERR_NONE;
   return rslt;
}

DBIResult DBIFN DSEXTRACT::GetField(pUINT32 piLength, // length of value in/out
   pBYTE pValue, // Pointer to the new field value
   pBOOL pBlank) // Pointer to the new field value
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iType; // type of attribute
   UINT32 iLength; // length of value
   pBYTE pDataCurrLoc, pPtr;
   pDSRECState pRecState = paRecStates[iCurRecState];
   UINT32 iNestedRows;
   UINT32 iCurrFldNo;
   UINT16 iNewState = 0;
   pDSPROVADTFLDDesc pAdtFldDes;

   if (pDsXml)
      return XMLGetField(piLength, pValue, pBlank);

   // Should get the field descriptors first.
   if (!bMetaDataDone)
      return SetError(DBIERR_NA);
   if (pSa == NULL)
      return SetError(DBIERR_EOF);

   if (pValue && (!piLength || *piLength < 1))
   {
      rslt = SetError(DBIERR_INVALIDPARAM);
      goto Exit;
   }

   iCurrFldNo = pRecState->iCurrFldNo;
   pAdtFldDes = iCurrFldNo ? &pRecState->pAdtFieldDesc[iCurrFldNo-1] : NULL;
   pDataCurrLoc = pCurrPos;
   if (iCurrFldNo == 0)
   {
      pRecState->pRowBeginLoc = pDataCurrLoc;
      iLength = sizeof(BYTE);
      if (pValue)
      {
         *pValue = ConvertInt8(*((pBYTE)pRecState->pRowBeginLoc));
      }
      // increment it past to the null bytes.
      pDataCurrLoc += (iLength + ((pRecState->iAdtColumns + 3) / 4));
      if (pBlank)
         *pBlank = (BOOL)fldIsChanged;
      goto Finish;
   }

   // See if null indicator is set for this field.
   // null indicators are after the row status field.
   // Note that if this is a fldTABLE, and the field is NULL, we do not need to go
   // to 'new state'
   pPtr = pRecState->pRowBeginLoc + pAdtFldDes->iNULLOffs;
   if (*pPtr & pAdtFldDes->iMask1) // (1 << (((iCurrFldNo - 1) % 4) * 2)))
   {
      iLength = 0;
      if (pBlank)
         *pBlank = (BOOL)fldIsNull;
      rslt = SetError(DBIERR_FIELDISBLANK);
      goto Finish;
   }
   // see if the unchanged bit is set.
   if (*pPtr & pAdtFldDes->iMask2) // (1 << ((((iCurrFldNo - 1) % 4) * 2) + 1)))
   {
      iLength = 0;
      if (pBlank)
         *pBlank = (BOOL)fldIsUnChanged;
      goto Finish;
   }

   if (pBlank)
      *pBlank = (BOOL)fldIsChanged;

   // GetValue:
   // Interpret the value
   iType = pAdtFldDes->iBaseFieldType;
   iNewState = pAdtFldDes->iNewRecState;

   if (!(iType & (dsVaryingFldType | dsArrayFldType)))
   {
      // fixed length field.
      iLength = pAdtFldDes->pFldObj->iLen;
   }
   else
   { // variable length field.
      pAdtFldDes->pFldObj->FldGet(NULL, pDataCurrLoc, &iLength, NULL);
      // Just get the length (Arrays include the repeatcount!)
   }

   if (*piLength < iLength && !(iLength & dsDELAYEDBIT))
   {
      rslt = SetError(DBIERR_INVALIDPARAM);
      goto Exit;
   }

   pDataCurrLoc = pAdtFldDes->pFldObj->FldGet(pValue, pDataCurrLoc, &iLength, /* bXML ?pBlank: */ NULL);

   if (!pValue)
      goto Finish;

   if (iNewState)
   {
      iNestedRows = *(pUINT32)pValue; // Could be 0 !
      if (iNestedRows & dsDELAYEDBIT)
         iNestedRows = 0;
   }

Finish:

   *piLength = iLength;
   if (!pValue && !pBlank) // This is a 'GetFieldLength'.Do not increment
      goto Exit;

   // Only increment if pValue is set!
   pCurrPos = pDataCurrLoc;
   ++pRecState->iCurrFldNo;

   if (iNewState && iNestedRows)
   {
      iCurRecState = iNewState;
      pRecState = paRecStates[iNewState];
      pRecState->iRowCountDown = iNestedRows;
      pRecState->iCurrFldNo = 0;
   }
   else // Note: embedded rows could be last field, so do not finish row until rnested rows are done
   {
   Again:
      if (pRecState->iCurrFldNo > pRecState->iAdtColumns)
      {
         pRecState->iCurrFldNo = 0;
         // Full row was given
         if (iCurRecState == 0)
         { // Update global info
            if (++iRowCurrent > iRows)
            { // We are DONE,
               if (this->pSa)
                  SARelPtr(this->pSa);
               this->pSa = NULL;
            }
         }
         else
         {
            if (--pRecState->iRowCountDown == 0)
            {
               iCurRecState = pRecState->iPrevRecState; // Done with this level
               pRecState = paRecStates[iCurRecState];
               goto Again;
            }
         }
      }
   }
Exit:
   return rslt;
}


FLDConv::FLDConv()
{
   pNamePtr = NULL;
   pDsXml = NULL;
   pXmlType = NULL;
}

FLDConv::~FLDConv()
{
}

pBYTE FLDConv::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen)
{
   if (pDsXml)
   {
      pPos = pDsXml->WriteValue(pPos, pNamePtr, pXmlType, (pCHAR)pVal);
      return pPos;
   }
   memmove(pPos, pVal, iLen);
   return pPos + iLen;
}

// base type
pBYTE FLDConv::FldGet(pBYTE pStr, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{

   if (pDsXml)
   {
      if (pPos)
      {
         pDsXml->ReadStr((pCHAR)pPos, (pCHAR)pStr, piLen, NULL);
      }
      return NULL;
   }

   if (pStr)
   {
      memmove(pStr, pPos, iLen);
   }
   if (piLen)
      *piLen = iLen;
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos + iLen;
}

// ZSTRING
FLDCVar8::FLDCVar8()
{
}

FLDCVar8::~FLDCVar8()
{
}

FLDCVar8::FLDCVar8(BOOL bConvert)
{
   iLen = 1;
   this->bConvert = bConvert;
}

pBYTE FLDCVar8::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iVarLen)
{
   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromSTRING(pVal, &iVarLen); // Creates a new encoded string of length iVarLen
      return pDsXml->WriteValueLen(pPos, pNamePtr, pXmlType, (pCHAR)pPtr, iVarLen);
   }
   *pPos = (BYTE)iVarLen;
   pPos++;
   memmove(pPos, pVal, iVarLen);
   return pPos + iVarLen;
}

// String 8
pBYTE FLDCVar8::FldGet(pBYTE pStr, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      if (pPos)
      {
         pDsXml->ReadStr((pCHAR)pPos, (pCHAR)pStr, piLen, NULL);
      }
      return NULL;
   }

   UINT32 iVarLen = (UINT32)(*pPos);

   pPos++;
   if (pStr)
      memmove(pStr, pPos, iVarLen);
   if (piLen)
      *piLen = iVarLen;
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos + iVarLen;
}

FLDCVar16::FLDCVar16()
{
}

FLDCVar16::~FLDCVar16()
{
}

FLDCVar16::FLDCVar16(BOOL bConvert)
{
   iLen = sizeof(UINT16);
   this->bConvert = bConvert;
}

pBYTE FLDCVar16::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iVarLen)
{
   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromSTRING(pVal, &iVarLen); // Creates a new encoded string of length iVarLen
      return pDsXml->WriteValueLen(pPos, pNamePtr, pXmlType, (pCHAR)pPtr, iVarLen);
   }
   if (!bConvert)
      *(pUINT16)pPos = (UINT16)iVarLen;
   pPos += sizeof(UINT16);
   memmove(pPos, pVal, iVarLen);
   return pPos + iVarLen;
}

// String 16
pBYTE FLDCVar16::FldGet(pBYTE pStr, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      if (pPos)
      {
         pDsXml->ReadStr((pCHAR)pPos, (pCHAR)pStr, piLen, NULL);
      }
      return NULL;
   }

   UINT16 iVarLen;

   if (!bConvert)
      iVarLen = *(pUINT16)pPos;
   pPos += sizeof(UINT16);
   if (pStr)
      memmove(pStr, pPos, (UINT32)iVarLen);
   if (piLen)
      *piLen = (UINT32)iVarLen;
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos + (UINT32)iVarLen;
}

FLDUnicode::FLDUnicode()
{
}

FLDUnicode::~FLDUnicode()
{
}

FLDUnicode::FLDUnicode(UINT32 iSize)
{
   iLen = iSize; // prefix size : 1:2:4
   this->bConvert = FALSE;
}

// XmlOnly
pBYTE FLDUnicode::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iVarLen)
{
   pCHAR pPtr = pDsXml->FromUNICODE(pVal, &iVarLen); // Creates a new encoded string of length iVarLen
   return pDsXml->WriteValueLen(pPos, pNamePtr, pXmlType, (pCHAR)pPtr, iVarLen);
}

// Xml only
pBYTE FLDUnicode::FldGet(pBYTE pStr, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   UNREFERENCED_PARAMETER(pbBlank);
   if (pPos)
   {
      pDsXml->ReadUniStr((pCHAR)pPos, (pCHAR)pStr, piLen, NULL);
   }
   return NULL;
}

FLDBinary::FLDBinary()
{
}

FLDBinary::~FLDBinary()
{
}

FLDBinary::FLDBinary(UINT32 iSize)
{
   iLen = iSize; // prefix size : 1:2:4
   this->bConvert = FALSE;
}

// XmlOnly
pBYTE FLDBinary::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iVarLen)
{
   pCHAR pPtr = pDsXml->FromBINARY(pVal, &iVarLen); // Creates a new encoded string of length iVarLen
   return pDsXml->WriteValueLen(pPos, pNamePtr, pXmlType, (pCHAR)pPtr, iVarLen);
}

// Xml only
pBYTE FLDBinary::FldGet(pBYTE pStr, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pPos)
   {
      pDsXml->ReadBinaryStr((pCHAR)pPos, (pCHAR)pStr, piLen, NULL);
   }
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return NULL;
}

FLDAlwaysNull::FLDAlwaysNull()
{
}

FLDAlwaysNull::FLDAlwaysNull(BOOL bConvert)
{
   iLen = 0;
   this->bConvert = bConvert;
}

FLDAlwaysNull::~FLDAlwaysNull()
{
}

pBYTE FLDAlwaysNull::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen)
{
   UNREFERENCED_PARAMETER(pPos);
   UNREFERENCED_PARAMETER(pVal);
   UNREFERENCED_PARAMETER(iLen);
   return pPos;
}

pBYTE FLDAlwaysNull::FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank)
{
   UNREFERENCED_PARAMETER(pVal);
   if (piLen)
      *piLen = 0;
   if (pbBlank)
      *pbBlank = TRUE;
   return pPos;
}

FLDCVar32::FLDCVar32()
{
}

FLDCVar32::~FLDCVar32()
{
}

FLDCVar32::FLDCVar32(BOOL bConvert)
{
   iLen = 4;
   this->bConvert = bConvert;
}

pBYTE FLDCVar32::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iVarLen)
{
   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromSTRING(pVal, &iVarLen); // Creates a new encoded string of length iVarLen
      return pDsXml->WriteValueLen(pPos, pNamePtr, pXmlType, (pCHAR)pPtr, iVarLen);
   }
   if (!bConvert)
      *(pUINT32)pPos = iVarLen;
   pPos += sizeof(UINT32);
   if (iVarLen & dsDELAYEDBIT) // There is no data in this case !
      return pPos;
   memmove(pPos, pVal, iVarLen);
   return pPos + iVarLen;
}

// String 32
pBYTE FLDCVar32::FldGet(pBYTE pStr, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      if (pPos)
      {
         pDsXml->ReadStr((pCHAR)pPos, (pCHAR)pStr, piLen, NULL);
      }
      return NULL;
   }

   UINT32 iVarLen;

   if (!bConvert)
      iVarLen = *(pUINT32)pPos;
   pPos += sizeof(UINT32);
   if (piLen)
      *piLen = iVarLen;
   if (iVarLen & dsDELAYEDBIT) // No data in this case
      iVarLen = 0;
   if (pStr && iVarLen)
   {
      memmove(pStr, pPos, iVarLen);
   }
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos + iVarLen;
}

FLDCInt8::FLDCInt8()
{
}

FLDCInt8::~FLDCInt8()
{
}

FLDCInt8::FLDCInt8(BOOL bConvert, BOOL bSigned)
{
   iLen = 1;
   this->bConvert = bConvert;
   this->bSigned = bSigned;
   pXmlType = bSigned ? (char*)szXMLInt8 : (char*)szXMLUInt8;
}

pBYTE FLDCInt8::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UNREFERENCED_PARAMETER(iIgnLen);

   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromINT8(pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }
   *pPos = *pVal;
   return pPos + iLen;
}

// Int8
pBYTE FLDCInt8::FldGet(pBYTE pInt, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      INT32 iInt = 0;

      if (pPos)
      {
         pDsXml->ReadINT32((pCHAR)pPos, &iInt, *piLen, pbBlank);
      }
      if (pInt)
         *pInt = (BYTE)iInt;
      if (piLen)
         *piLen = iLen;

      return NULL;
   }

   if (piLen)
      *piLen = iLen;
   if (pInt)
   {
      *pInt = *pPos;
   }
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos+sizeof(BYTE);
}

FLDCInt16::FLDCInt16()
{
   pXmlType = bSigned ? (char*)szXMLInt16 : (char*)szXMLUInt16;
}

FLDCInt16::~FLDCInt16()
{
}

FLDCInt16::FLDCInt16(BOOL bConvert, BOOL bSigned)
{
   iLen = sizeof(UINT16);
   this->bConvert = bConvert;
   this->bSigned = bSigned;
}

pBYTE FLDCInt16::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UNREFERENCED_PARAMETER(iIgnLen);
   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromINT16(pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }

   if (!bConvert)
      *(pUINT16)pPos = *(pUINT16)pVal;
   return pPos+sizeof(UINT16);
}

// Int16
pBYTE FLDCInt16::FldGet(pBYTE pInt, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      INT32 iInt = 0;

      if (pPos)
      {
         pDsXml->ReadINT32((pCHAR)pPos, &iInt, *piLen, pbBlank);
      }
      if (pInt)
         *(pUINT16)pInt = (UINT16)iInt;
      if (piLen)
         *piLen = iLen;
      return NULL;
   }

   if (piLen)
      *piLen = iLen;
   if (pInt)
   {
      if (!bConvert)
         *(pUINT16)pInt = *(pUINT16)pPos;
   }
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos+sizeof(UINT16);
}

FLDCInt32::FLDCInt32()
{
}

FLDCInt32::~FLDCInt32()
{
}

// NOTE, if XML, we also need to do the convert
FLDCInt32::FLDCInt32(BOOL bConvert, BOOL bSigned)
{
   iLen = 4;
   this->bConvert = bConvert;
   this->bSigned = bSigned;
   pXmlType = bSigned ? ((char*)szXMLInt32) : ((char*)szXMLUInt32);
}

pBYTE FLDCInt32::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UNREFERENCED_PARAMETER(iIgnLen);
   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromINT32(pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }
   if (!bConvert)
      *(pUINT)pPos = *(pUINT)pVal;
   return pPos+sizeof(UINT);
}

// Int32
pBYTE FLDCInt32::FldGet(pBYTE pInt, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      INT32 iInt = 0;

      if (pPos)
      {
         pDsXml->ReadINT32((pCHAR)pPos, &iInt, *piLen, pbBlank);
      }
      if (pInt)
         *(pUINT)pInt = iInt;
      if (piLen)
         *piLen = iLen;
      return NULL;
   }

   if (piLen)
      *piLen = iLen;
   if (pInt)
   {
      if (!bConvert)
         *(pUINT)pInt = *(pUINT)pPos;
   }
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos+sizeof(UINT);
}

FLDCBool::FLDCBool()
{
   pFldObj = NULL;
}

FLDCBool::~FLDCBool()
{
   if (pFldObj)
      delete pFldObj;
}

FLDCBool::FLDCBool(BOOL bConvert, UINT32 iSize)
{
   iLen = iSize;
   this->bConvert = bConvert;
   pFldObj = (iSize == 4) ? (FLDConv*)new FLDCInt32(bConvert, FALSE) : (iSize == 2) ? (FLDConv*)new FLDCInt16
      (bConvert, FALSE) : (iSize == 1) ? (FLDConv*)new FLDCInt8(bConvert, FALSE) : NULL;
   pXmlType = szXMLBool;

}

pBYTE FLDCBool::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   if (pDsXml)
   {
      pCCHAR pPtr = (iLen == 1) ? pDsXml->FromBOOL8(pVal) : (iLen == 2) ? pDsXml->FromBOOL16(pVal) : pDsXml->FromBOOL32
         (pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }

   bool boolVal = *pVal;
   return pFldObj->FldPut(pPos, (pBYTE)&boolVal, iIgnLen);
}

// Bool
pBYTE FLDCBool::FldGet(pBYTE pBool, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      BOOL bBool;

      if (pPos)
      {
         pDsXml->ReadBOOL((pCHAR)pPos, &bBool, *piLen, pbBlank);
      }
      if (pBool)
      {
         if (iLen == 1)
            *pBool = (bool)(INT8)bBool;
         else if (iLen == 2)
            *(pINT16)pBool = (bool)(INT16)bBool;
         else
            *(pINT32)pBool = (bool)(INT32)bBool;
      }
      if (piLen)
         *piLen = iLen;

      return NULL;
   }

   if (piLen)
      *piLen = iLen;
   return pFldObj->FldGet(pBool, pPos, piLen, pbBlank);
}

FLDCDATE::FLDCDATE()
{

}

FLDCDATE::~FLDCDATE()
{
}

FLDCDATE::FLDCDATE(BOOL bConvert)
{
   iLen = 4;
   this->bConvert = bConvert;
   pXmlType = szXMLDate;
}

pBYTE FLDCDATE::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UNREFERENCED_PARAMETER(iIgnLen);

   if (pDsXml)
   {

      pCHAR pPtr = pDsXml->FromDATE(pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }
   return NULL;
}

// Date
pBYTE FLDCDATE::FldGet(pBYTE pDate, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      UINT32 iDate;

      if (pPos)
      {
         pDsXml->ReadDATE((pCHAR)pPos, &iDate, *piLen, pbBlank);
      }
      if (pDate)
         *(pUINT32)pDate = iDate;
      if (piLen)
         *piLen = iLen;
      return NULL;
   }
   if (piLen)
      *piLen = iLen;
   return NULL;
}

FLDCTIME::FLDCTIME()
{

}

FLDCTIME::~FLDCTIME()
{
}

FLDCTIME::FLDCTIME(BOOL bConvert)
{
   iLen = 4;
   this->bConvert = bConvert;
   pXmlType = szXMLTime;
}

pBYTE FLDCTIME::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UNREFERENCED_PARAMETER(iIgnLen);

   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromTIME(pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }
   return NULL;
}

// Time
pBYTE FLDCTIME::FldGet(pBYTE pTime, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      UINT32 iTime;

      if (pPos)
      {
         pDsXml->ReadTIME((pCHAR)pPos, &iTime, *piLen, pbBlank);
      }
      if (pTime)
         *(pUINT32)pTime = iTime;
      if (piLen)
         *piLen = iLen;
      return NULL;
   }
   return NULL;
}

FLDCTIMESTAMP::FLDCTIMESTAMP()
{
   pFldObjDate = NULL;
   pFldObjTime = NULL;
}

FLDCTIMESTAMP::~FLDCTIMESTAMP()
{
   if (pFldObjDate)
      delete pFldObjDate;
   if (pFldObjTime)
      delete pFldObjTime;
}

FLDCTIMESTAMP::FLDCTIMESTAMP(BOOL bConvert)
{
   iLen = 8;
   this->bConvert = bConvert;
   pFldObjDate = new FLDCDATE(bConvert);
   pFldObjTime = new FLDCTIME(bConvert);
}

pBYTE FLDCTIMESTAMP::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UNREFERENCED_PARAMETER(iIgnLen);

   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromTIMESTAMP(pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }
   return NULL;
}

// TimeStamp
pBYTE FLDCTIMESTAMP::FldGet(pBYTE piTimeStamp, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      DFLOAT iTimeStamp;

      if (pPos)
      {
         pDsXml->ReadTIMESTAMP((pCHAR)pPos, &iTimeStamp, *piLen, pbBlank);
      }
      if (piTimeStamp)
         *(pDFLOAT)piTimeStamp = iTimeStamp;
      if (piLen)
         *piLen = iLen;
      return NULL;
   }
   return NULL;
}

FLDCSQLTIMESTAMP::FLDCSQLTIMESTAMP()
{
   iLen = sizeof(SQLTIMESTAMP);
   this->bConvert = FALSE;
}

FLDCSQLTIMESTAMP::~FLDCSQLTIMESTAMP()
{
}

FLDCSQLTIMESTAMP::FLDCSQLTIMESTAMP(BOOL bConvert)
{
   iLen = sizeof(SQLTIMESTAMP);
   this->bConvert = bConvert;
}

pBYTE FLDCSQLTIMESTAMP::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UNREFERENCED_PARAMETER(iIgnLen);
   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromSQLTIMESTAMP(pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }
   memcpy(pPos, pVal, iLen);
   return pPos + iLen;
}

// TimeStamp
pBYTE FLDCSQLTIMESTAMP::FldGet(pBYTE pTimeStamp, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      SQLTIMESTAMP iSQLTimeStamp;
      if (pPos)
      {
         pDsXml->ReadSQLTIMESTAMP((pCHAR)pPos, &iSQLTimeStamp, *piLen, pbBlank);
      }
      if (pTimeStamp)
         *((SQLTIMESTAMP*)pTimeStamp) = iSQLTimeStamp;
      return NULL;
   }
   if (piLen)
      *piLen = iLen;
   if (pTimeStamp)
      *(SQLTIMESTAMP*)pTimeStamp = *(SQLTIMESTAMP*)pPos;
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos + iLen;
}

FLDCSQLTIMESTAMPOFFSET::FLDCSQLTIMESTAMPOFFSET()
{
   iLen = sizeof(SQLTIMESTAMPOFFSET);
   this->bConvert = FALSE;
}

FLDCSQLTIMESTAMPOFFSET::~FLDCSQLTIMESTAMPOFFSET()
{
}

FLDCSQLTIMESTAMPOFFSET::FLDCSQLTIMESTAMPOFFSET(BOOL bConvert)
{
   iLen = sizeof(SQLTIMESTAMPOFFSET);
   this->bConvert = bConvert;
}

pBYTE FLDCSQLTIMESTAMPOFFSET::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UNREFERENCED_PARAMETER(iIgnLen);
   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromSQLTIMESTAMPOFFSET(pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }
   memcpy(pPos, pVal, iLen);
   return pPos + iLen;
}

// TimeStamp
pBYTE FLDCSQLTIMESTAMPOFFSET::FldGet(pBYTE pTimeStampOffset, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      SQLTIMESTAMPOFFSET iSQLTimeStampOffset;

      if (pPos)
      {
         pDsXml->ReadSQLTIMESTAMPOFFSET((pCHAR)pPos, &iSQLTimeStampOffset, *piLen, pbBlank);
      }
      if (pTimeStampOffset)
         *(SQLTIMESTAMPOFFSET*)pTimeStampOffset = iSQLTimeStampOffset;
      return NULL;
   }
   if (piLen)
      *piLen = iLen;
   if (pTimeStampOffset)
      *(SQLTIMESTAMPOFFSET*)pTimeStampOffset = *(SQLTIMESTAMPOFFSET*)pPos;
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos + iLen;
}

FLDCInt64::FLDCInt64()
{
}

FLDCInt64::~FLDCInt64()
{
}

FLDCInt64::FLDCInt64(BOOL bConvert, BOOL bSigned)
{
   iLen = 8;
   this->bConvert = bConvert;
   this->bSigned = bSigned;
   pXmlType = bSigned ? (char*)szXMLInt64 : (char*)szXMLUInt64;
}

pBYTE FLDCInt64::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UNREFERENCED_PARAMETER(iIgnLen);

   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromINT64(pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }
   if (!bConvert)
      memcpy(pPos, pVal, sizeof(UINT64));
   return pPos + sizeof(UINT64);
}

pBYTE FLDCInt64::FldGet(pBYTE pVal, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      INT64 iInt = 0;

      if (pPos)
         pDsXml->ReadINT64((pCHAR)pPos, &iInt, *piLen, pbBlank);
      if (pVal)
         *(pINT64)pVal = iInt;
      if (piLen)
         *piLen = iLen;
      return NULL;
   }

   if (piLen)
      *piLen = iLen;
   if (pVal)
   {
      if (!bConvert)
        memcpy(pVal, pPos, sizeof(UINT64));
   }
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos+sizeof(UINT64);
}

FLDCSingle::FLDCSingle()
{
}

FLDCSingle::~FLDCSingle()
{
}

FLDCSingle::FLDCSingle(BOOL bConvert)
{
   iLen = 8;
   this->bConvert = bConvert;
   pXmlType = szXMLSingle;
}

pBYTE FLDCSingle::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UNREFERENCED_PARAMETER(iIgnLen);

   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromSINGLE(pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }
   memmove(pPos, pVal, iLen);
   return pPos + iLen;
}

// Float/Double 8
pBYTE FLDCSingle::FldGet(pBYTE pSingle, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      SINGLE iSingle;

      if (pPos)
      {
         pDsXml->ReadSINGLE((pCHAR)pPos, &iSingle, *piLen, pbBlank);
      }
      if (pSingle)
         *(pSINGLE)pSingle = iSingle;
      if (piLen)
         *piLen = iLen;

      return NULL;
   }

   if (piLen)
      *piLen = iLen;
   if (pSingle)
      memmove(pSingle, pPos, iLen);
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos + iLen;
}

FLDCFloat::FLDCFloat()
{
}

FLDCFloat::~FLDCFloat()
{
}

FLDCFloat::FLDCFloat(BOOL bConvert)
{
   iLen = 8;
   this->bConvert = bConvert;
   pXmlType = szXMLFloat;
}

pBYTE FLDCFloat::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UNREFERENCED_PARAMETER(iIgnLen);

   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromFLOAT(pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }
   memmove(pPos, pVal, iLen);
   return pPos + iLen;
}

// Float/Double 8
pBYTE FLDCFloat::FldGet(pBYTE pDFloat, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      DFLOAT iFloat;

      if (pPos)
      {
         pDsXml->ReadFLOAT((pCHAR)pPos, &iFloat, *piLen, pbBlank);
      }
      if (pDFloat)
         *(pDFLOAT)pDFloat = iFloat;
      if (piLen)
         *piLen = iLen;

      return NULL;
   }

   if (piLen)
      *piLen = iLen;
   if (pDFloat)
      memmove(pDFloat, pPos, iLen);
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos + iLen;
}

FLDCFloatIEEE::FLDCFloatIEEE()
{
}

FLDCFloatIEEE::~FLDCFloatIEEE()
{
}

FLDCFloatIEEE::FLDCFloatIEEE(BOOL bConvert)
{
   iLen = 10;
   this->bConvert = bConvert;
   pXmlType = szXMLNumber;
}

pBYTE FLDCFloatIEEE::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UNREFERENCED_PARAMETER(iIgnLen);

   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromFLOATIEEE(pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }
   memmove(pPos, pVal, iLen);
   return pPos + iLen;
}

// Float/Double  10
pBYTE FLDCFloatIEEE::FldGet(pBYTE pVal, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      return NULL;
   }

   if (piLen)
      *piLen = iLen;
   if (pVal)
      memmove(pVal, pPos, iLen);
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos + iLen;
}

FLDCBcd::FLDCBcd()
{
}

FLDCBcd::~FLDCBcd()
{
}

FLDCBcd::FLDCBcd(BOOL bConvert, UINT32 iPrecision, UINT32 iDecimals)
{
   iLen = 18; // iPrecision+2 must be <= 18
   this->bConvert = bConvert;
   pXmlType = szXMLFixed; // Set decimals etc
   this->iPrecision = iPrecision;
   this->iDecimals = iDecimals;
}

pBYTE FLDCBcd::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen)
{
   if (pDsXml)
   {
      pCHAR pPtr = pDsXml->FromBCD(pVal);
      return pDsXml->WriteValue(pPos, pNamePtr, pXmlType, pPtr);
   }
   memmove(pPos, pVal, iLen);
   return pPos + iLen;
}

// Bcd/fixed
pBYTE FLDCBcd::FldGet(pBYTE pVal, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
      pDsXml->ReadBCD((pCHAR)pPos, pVal, *piLen, pbBlank, iPrecision, iDecimals); // Double
      if (piLen)
         *piLen = iLen;
      return NULL;
   }

   if (piLen)
      *piLen = iLen;
   if (pVal)
      memmove(pVal, pPos, iLen);
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos + iLen;
}

FLDCFixed::FLDCFixed()
{
}

FLDCFixed::~FLDCFixed()
{
}

FLDCFixed::FLDCFixed(BOOL bConvert, UINT32 iFixedLen)
{
   iLen = iFixedLen;
   this->bConvert = bConvert;
}

pBYTE FLDCFixed::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UNREFERENCED_PARAMETER(iIgnLen);

   if (pDsXml)
   {
      return pDsXml->WriteValueLen(pPos, pNamePtr, pXmlType, (pCHAR)pVal, iLen);
   }
   memmove(pPos, pVal, iLen); // Use internal length
   return pPos + iLen;
}

// FixedChar ?
pBYTE FLDCFixed::FldGet(pBYTE pVal, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   if (pDsXml)
   {
   }

   if (piLen)
      *piLen = iLen;
   if (pVal)
      memmove(pVal, pPos, iLen);
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos + iLen;
}

FLDCRepeat::FLDCRepeat()
{
}

FLDCRepeat::~FLDCRepeat()
{
   if (pFldElement)
      delete pFldElement;
   if (pFldObjCount)
      delete pFldObjCount;
}

FLDCRepeat::FLDCRepeat(BOOL bConvert, FLDConv *pFldObj)
{
   iLen = 4;
   this->bConvert = bConvert;
   pFldObjCount = new FLDCInt32(bConvert, FALSE);
   pFldElement = pFldObj;
}

// repeat-count is included in pVal
pBYTE FLDCRepeat::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   UINT32 i, iLen = pFldElement->iLen;
   UINT32 iRepeatCount = *(pUINT)pVal;

   UNREFERENCED_PARAMETER(iIgnLen);
   if (pDsXml)
   {
      // Do not write out the count! pPos = pFldObjCount->FldPut(pPos, pVal, pFldObjCount->iLen);
      pVal += sizeof(UINT); // pFldObjCount->iLen;
      for (i = 0; i < iRepeatCount; i++)
      {
         pPos = pFldElement->FldPut(pPos, pVal, iLen);
         pVal += iLen;
         if (i+1 < iRepeatCount)
            pPos = pDsXml->WriteString(pPos, " ", FALSE); // Separate with spaces
      }
      return pPos;
   }

   pPos = pFldObjCount->FldPut(pPos, pVal, sizeof(UINT));
   pVal += sizeof(UINT);

   for (i = 0; i < iRepeatCount; i++)
   {
      pPos = pFldElement->FldPut(pPos, pVal, iLen);
      pVal += iLen;
   }
   return pPos;
}

pBYTE FLDCRepeat::FldGet(pBYTE pVal, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   UINT32 i, iLen = pFldElement->iLen;
   UINT32 iRepeatCount;

   if (pDsXml)
   {
      pUINT32 pRepeatCount = (pUINT32)pVal;
      // DBIResult rslt = DBIERR_NONE;

      // On input pPos and piLen must be set
      pCHAR pValueStart = (pCHAR)pPos;
      pCHAR pValueEnd = (pCHAR)pPos + *piLen;

      iRepeatCount = 0;
      if (pVal)
         pVal += sizeof(UINT32);
      while (pValueStart < pValueEnd)
      {
         while (*pValueStart == ' ')
            pValueStart++;

         if (pVal)
         {
            *(pUINT32)pVal = (UINT32)atoi(pValueStart); // Assumes INT32
            pVal += iLen;
         }
         iRepeatCount++;
         while (*pValueStart != ' ' && *pValueStart != '<' && pValueStart < pValueEnd)
            pValueStart++;
      }
      if (pVal)
         *pRepeatCount = iRepeatCount;
      if (piLen)
         *piLen = sizeof(UINT32)*(1+iRepeatCount);
      return NULL;
   }

   pPos = pFldObjCount->FldGet((pBYTE) &iRepeatCount, pPos, NULL, NULL);
   if (piLen)
      *piLen = iLen*iRepeatCount+sizeof(UINT32);
   if (pVal)
   {
      *(pUINT32)pVal = iRepeatCount;
      pVal += sizeof(UINT32);
      for (i = 0; i < iRepeatCount; i++)
      {
         pPos = pFldElement->FldGet(pVal, pPos, NULL, NULL);
         pVal += iLen;
      }
   }
   else
      pPos += iLen*iRepeatCount;
   if (pbBlank)
      *pbBlank = FALSE; // Not possible
   return pPos;
}

FLDNested::FLDNested()
{
}

FLDNested::FLDNested(BOOL bConvert)
{
   iLen = 0;
   this->bConvert = bConvert;
   pXmlType = szXMLNested;
}

FLDNested::~FLDNested()
{
}

pBYTE FLDNested::FldPut(pBYTE pPos, pBYTE pVal, UINT32 iIgnLen)
{
   if (pDsXml)
   { // Only works if pVal==NULL;
      return pDsXml->WriteEmptyTag(pPos, pNamePtr, TRUE, TRUE);
   }
   UNREFERENCED_PARAMETER(iIgnLen);
   UNREFERENCED_PARAMETER(pVal);
   UNREFERENCED_PARAMETER(pPos);

   return pPos;
}

pBYTE FLDNested::FldGet(pBYTE pVal, pBYTE pPos, pUINT32 piLen, pBOOL pbBlank)
{
   UNREFERENCED_PARAMETER(pPos);
   if (pDsXml)
   {
      DBIResult rslt = DBIERR_NONE;
      XMLTag Tag;

      rslt = pDsXml->pXmlParse->NextTag(&Tag);
      if (!rslt)
      {
         if (Tag.iTagType == Tag_Leaf || Tag.iTagType == Tag_Empty)
         { // No rows
            // Read attribute to see if rows are delayed!
            if (pbBlank)
               *pbBlank = BLANK_NULL;
            if (pVal)
               *(pUINT32)pVal = 0;
         }
         else
         {
            if (pbBlank)
               *pbBlank = FALSE;
            if (pVal)
               *(pUINT32)pVal = (dsDELAYEDBIT -1); // (maximum number, since we don't know how many
         }
         if (piLen)
            *piLen = sizeof(UINT32);
      }
   }
   return NULL;
}

#ifdef DEBUG

DBIResult makeError(UINT32 e)
{
   switch(e)
   {
   case DBIERR_EOF:
      break;
   case DBIERR_DATAPACKETMISMATCH:
      break;
   default:
      break;
   }
   return e;
}
#endif
