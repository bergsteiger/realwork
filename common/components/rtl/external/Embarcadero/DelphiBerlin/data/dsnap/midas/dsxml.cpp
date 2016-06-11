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
#include <locale.h>
#if !defined(__ANDROID__)
#include <iconv.h>
#endif
#else
#include <windows.h>
#endif
#include <string.h>
#pragma hdrstop

#include "alctypes.h"
#include "ossrv.h"

#include "dspickle.h"
#include "dsxml.h"
#include "dsconst.h"

#ifdef _UNIX
static void _localeInit(void)__attribute__((constructor));

static void _localeInit(void)
{
   // the following code is copied from tp/com/_mbcs.c
   char *p;

   setlocale(LC_ALL, "");

   // POSIX/C is the default locale on many Unix systems, but its 7-bit charset
   // causes char to widechar conversions to fail on any high-ascii
   // character.  To support high-ascii charset conversions, set the process
   // LC_CTYPE locale to something else.  It doesn't matter what we set it
   // to, as long as it's not POSIX.                   -dt

   p = getenv("LC_CTYPE");
   if (!p)
      p = getenv("LANG");
   if ((p == NULL) || (strcmp(p, "POSIX") == 0) || (strcmp(p, "C") == 0))
      setlocale(LC_CTYPE, "en_US");

   // Set the locale settings for numeric formatting to the "C" locale, so that
   // locale settings such as decimal character don't interfere with our
   // ability to parse Pascal floating point constants.

   setlocale(LC_NUMERIC, "C");
}

//TODO: mblen does not exist in Android NDK.  Evaluate alternate solution.
#if !defined(__ANDROID__)
size_t _mbscspn(const unsigned char *s1, const unsigned char *s2)
{
   int l;
   const unsigned char *p, *q;

   for (p = s1; *p; )
   {
      for (q = s2; *q && *p != *q; q++);
      if (*q)
         break;
      if ((l = mblen((const char*)p, MB_CUR_MAX)) == -1)
         p += 1;
      else
         p += l;
   }

   return(size_t)(p - s1);
}
#endif
#else
#include <mbstring.h> //This is for _mbscspn
#endif

extern BOOL bAsAttrs; // XML

DBIResult ReadColumnDesc(DSXML_Parse *pParse, pDSDATAPACKETFLDDesc pFldDes, pBOOL pbOptParams, pBOOL pbAttrFld);
UINT32 DsMakeType(pCCHAR pXmlType);
DBIResult DBIFN GetFldObj(UINT32 iFieldType, BOOL bConvert, class DSXML_W *pDsXml, FLDConv **ppFldObj);
DBIResult ExpandAllFieldDescs(UINT32 iRecStatesCnt, pDSRECState *paRecStates, // Array of record states
   BOOL bConvert, class DSXML_W *pDsXml);

pBYTE CopyReplaceSpecialCharsUTF8(INT32 AnsiCP, pBYTE pPos, pCCHAR pTagName, pCCHAR pValue, UINT32 iLen);
pBYTE CopyReplaceSpecialCharsAscii(pBYTE pPos, pCCHAR pTagName, pCCHAR pValue, UINT32 iLen);
pBYTE CopyReplaceSpecialChars(pBYTE pPos, pCCHAR pTagName, pCCHAR pValue, UINT32 iLen, BOOL bUTFFlag);
pCHAR ParseAttributes(pCHAR pAttr, pCHAR pEnd, pCHAR *ppName, pUINT32 piNameLen, pCHAR *ppValue, pUINT32 piValueLen);

typedef struct
{
   pCCHAR pszAttrName;
   pCCHAR pszXmlType;
}ATTTYPE;
typedef ATTTYPE *pATTTYPE;

ATTTYPE pAttTbl[22] =
{
        {szUNIQUE_KEY      , szXMLUIntArray},   //  1
        {szDEFAULT_ORDER   , szXMLUIntArray},   //  2
        {szCHANGE_LOG      , szXMLUIntArray},   //  3
        {szSERVER_COL      , szXMLStringAnsi},  //  4
//      {szCONSTRAINTS     , PreCONSTRAINTS},   //  5
//      {szDATASET_CONTEXT , PreDATASET_CONTEXT}, //  6
        {szDATASET_DELTA   , szXMLBool},        //  7
        {szREADONLY        , szXMLBool},        //  8
        {szSUBTYPE         , szXMLStringAnsi},  //  9
        {szDECIMALS        , szXMLInt16},       // 10
        {szWIDTH           , szXMLInt16},       // 11
        {szLCID            , szXMLInt16},       // 12
//      {szBDEDOMX         , PreBDEDOMAIN_X},   // 13
//      {szBDERECX         , PreBDERECORD_X},   // 14
//      {szBDEDEFX         , PreBDEDEFAULT_X},  // 15
        {szAUTOINCVALUE    , szXMLInt32},       // 16
//      {szELEMENTS        , PreELEMENTS},      // 17
        {szTABLENAME       , szXMLStringAnsi},  // 18
//      {szMD_FIELDLINKS   , szXMLUIntArray},   // 19
        {szTYPENAME        , szXMLStringAnsi},  // 20
        {szUPDATEMODE      , szXMLInt16},       // 21
        {szMD_SEMANTICS    , szXMLUIntArray},   // 22
        {szCALCULATED      , szXMLBool },       // 23
        {"DELTA"           , szXMLBool},        // for xml
        {szPRIMARY_KEY     , szXMLUIntArray},   //  1
        {szMINVALUE        , ""},
        {szMAXVALUE        , ""},
        {szDEFVALUE        , ""},
        {""                , (pCHAR) PreUNKNOWN}, //  0
};

// return index of string (0..n) , -1 if not found
pCCHAR XmlTypeOfAttr(pCCHAR pszAttrName)
{
   UINT32 i;
   pATTTYPE pConv;

   for (i = 0; i < sizeof(pAttTbl)/sizeof(ATTTYPE); i++)
   {
      pConv = &pAttTbl[i];
      if (*pConv->pszAttrName == 0)
         break;
      if (stricmp(pszAttrName, pConv->pszAttrName) == 0)
         return pConv->pszXmlType;
   }
   return NULL;
}

pCHAR MakeStr(pCHAR pDest, UINT32 iDestSize, pCHAR pVal, UINT32 iLen)
{
   if (iDestSize <= iLen)
      iLen = iDestSize - 1;
   CopyMem(pDest, pVal, iLen);
   pDest[iLen] = 0;
   return pDest;
}

// Extract next attribute
DBIResult DBIFN DSEXTRACT::XMLGetNextAttribute(pCHAR pszAttribute, // Attribute
   pUINT32 piType, // Attribute type
   pUINT32 piLen, // lenght of pValue buffer, if applicable
   pBYTE pValue) // value
{
   // pBYTE      pPtr;
   DBIResult rslt = DBIERR_NONE;
   UINT32 iType;
   UINT32 iLength;
   // BYTE       iNameLen;
   pDSRECState pRecState = paRecStates[iCurRecState];
   FLDConv *pFldObj = NULL;
   XMLTag Tag;
   BOOL bBlank; // (Blanks not exected!)
   // CHAR   Temp[10];
   CHAR pTmp[DBIMAXNAMELEN+1];
   CHAR pTagName[DBIMAXNAMELEN+1];
   pAttr_Entry pEntry;
   UINT32 iId;
   pCCHAR pType;

   if (bMetaDataDone)
   {
      rslt = SetError(DBIERR_EOF);
      goto Exit;
   }

NextAttr:
   // Any remaining attributes
   if ((iId = pDsXml->pXmlParse->pAttr_List->Next()) !=0)
   {
      pEntry = (pAttr_Entry)pDsXml->pXmlParse->pAttr_List->GetEntry(iId);
      MakeStr(pTmp, sizeof(pTmp), pEntry->pAttrName, pEntry->iAttrNameLen);
      if (pszAttribute)
      {
         strcpy(pszAttribute, pTmp);
         pDsXml->pXmlParse->pAttr_List->SetVisited(pEntry->iId);
      }
      pType = XmlTypeOfAttr(pTmp);
      if (pType)
         iType = DsMakeType(pType);
      else if (stricmp(pTmp, szMD_FIELDLINKS) == 0)
         iType = dptypeINTARRAY;
      else
         iType = 0;
      if (iType == 0)
         iType = dptypeZSTRING(1);
      if (piType)
         *piType = iType;
      rslt = GetFldObj(iType, bBigEndian, pDsXml, &pFldObj);
      if (rslt)
         goto Exit;
      iLength = pEntry->iValueLen;
      pFldObj->FldGet(NULL, (pBYTE)pEntry->pValue, &iLength, &bBlank);
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
         iLength = pEntry->iValueLen;
         pFldObj->FldGet(pValue, (pBYTE)pEntry->pValue, &iLength, &bBlank);

         if (strcmp(pszAttribute, szSUBTYPE) == 0)
         {
            pDSDATAPACKETFLDDescX pFldEntry;
            pFldEntry = pRecState->pFlds_List->GetFldDesc(pRecState->iColumns);
            strcpy(pFldEntry->szSubType, (pCHAR)pValue);
         }
      }
      else
      {
         pDsXml->pXmlParse->pAttr_List->iPos--;
      }
      goto Exit;
   }

   // Read next Tag

   pDsXml->pXmlParse->StorePos();
   rslt = pDsXml->pXmlParse->NextTag(&Tag);
   if (rslt)
      goto Exit;
   MakeStr(pTagName, sizeof(pTagName), Tag.pTagName, Tag.iTagNameLen);

   // End Tag
   if (Tag.iTagType == Tag_End ||(Tag.iTagType == Tag_Leaf && Tag.pAttr == NULL))
   { // End of this section
      bFldDescs = FALSE;
      if (strcmp(pTagName, szFIELDDEF) == 0 && !pRecState->bColsRead)
      {
         rslt = SetError(DBIERR_EOF);
         goto Exit; // Signal end of field-optional parameters
      }
      if (strcmp(pTagName, szFIELDS) == 0) // szFIELDS
      {
         pRecState->bColsRead = TRUE;
         rslt = SetError(DBIERR_EOF);
         goto Exit;
      }
      if (strcmp(pTagName, szPARAMS) == 0)
      {

         pDsXml->pXmlParse->StorePos();

         rslt = pDsXml->pXmlParse->NextTag(&Tag);
         if (rslt)
            goto Exit;
         MakeStr(pTagName, sizeof(pTagName), Tag.pTagName, Tag.iTagNameLen);
      }

      if (strcmp(pTagName, szMETADATA) == 0)
      {
         // This point only reached once
         // Start reading rowdata, if any
         // iFieldCurrent == Columns)!
         bMetaDataDone = TRUE;
         bFirstRow = TRUE;
         // initialize all AdtFielddescs
         rslt = ExpandAllFieldDescs(iRecStatesCnt, paRecStates, bBigEndian, pDsXml);
         if (rslt)
            goto Exit;

         pDsXml->pXmlParse->StorePos();
         rslt = pDsXml->pXmlParse->NextTag(&Tag);
         if (rslt)
            goto Exit;
         MakeStr(pTagName, sizeof(pTagName), Tag.pTagName, Tag.iTagNameLen);
         if (Tag.iTagType == Tag_Begin) // Assume <ROWDATA>
         {
            iRows = -1; // Signal 'unknown'
         }
         pDsXml->pXmlParse->RestorePos();
      }
      else
      {
         if (strcmp(pTagName, szFIELDDEF) == 0)
         {
            iCurRecState = pRecState->iPrevRecState; // Done with this level
            pRecState = paRecStates[iCurRecState];
            pDsXml->pXmlParse->StorePos();

            rslt = pDsXml->pXmlParse->NextTag(&Tag);
            MakeStr(pTagName, sizeof(pTagName), Tag.pTagName, Tag.iTagNameLen);
            if (Tag.iTagType == Tag_End)
            { // This is an </FIELDS>
               pRecState->bColsRead = TRUE;
            }
            else
            {
               bFldDescs = TRUE; // Excpect a fielddescriptor next
               pDsXml->pXmlParse->RestorePos();
            }
         }
      }
      rslt = SetError(DBIERR_EOF);
      goto Exit; // Signal end of field-optional parameters
   }

   // PARAMS section
   if (strcmp(pTagName, szPARAMS) == 0)
   {
      pDsXml->pXmlParse->pAttr_List->Parse(Tag.pAttr);
      goto NextAttr;
   }

   // Anything else
   if (strcmp(pTagName, szOPTPARAM)!=0)
   {
      pDsXml->pXmlParse->RestorePos();
      rslt = SetError(DBIERR_EOF);
      goto Exit;
   }

   // OPTPARAM, has 3 attributes : Name, Value, Type (default=string), RoundTrip(default=false)
   pDsXml->pXmlParse->pAttr_List->Parse(Tag.pAttr);

   pEntry = (pAttr_Entry)pDsXml->pXmlParse->pAttr_List->Find(szAttrName, 1);
   if (!pEntry)
   {
      rslt = SetError(DBIERR_DATAPACKETMISMATCH);
      goto Exit;
   }

   if (pszAttribute)
   {
      UINT32 iLen = pEntry->iValueLen;
      pDsXml->ReadUniStr(pEntry->pValue, NULL, &iLen, NULL);

      pUCS2Char tempBuf = (pUCS2Char)malloc(iLen);
      iLen = pEntry->iValueLen;
      // Get AttributeName into tempBugf using UTF16. iLen is a number of bytes.
      pDsXml->ReadUniStr(pEntry->pValue, (pCHAR)tempBuf, &iLen, NULL);

#ifdef _UNIX
      char *uBuf = WideCharToUTF8(tempBuf);
#else
      int uLen = WideCharToMultiByte(CP_UTF8, 0, (wchar_t*)tempBuf, iLen / 2, NULL, 0, NULL, NULL);
      unsigned char *uBuf = (unsigned char*)malloc(uLen); // uLen contains NULL terminator byte.
      WideCharToMultiByte(CP_UTF8, 0, (wchar_t*)tempBuf, iLen / 2, reinterpret_cast<LPSTR>(uBuf), uLen, NULL, NULL);
#endif

      strncpy(pszAttribute, (const char*)uBuf, DSMAXATTRNAMELEN);

      free(tempBuf);
      free(uBuf);
   }
   pEntry = (pAttr_Entry)pDsXml->pXmlParse->pAttr_List->Find(szAttrType, 2);
   if (!pEntry)
      pType = (bUTF8METADATA) ? (CHAR*)szXMLStringUni : (CHAR*)szXMLStringAnsi;
   else
   {
      pType = MakeStr(pTmp, sizeof(pTmp), pEntry->pValue, pEntry->iValueLen);
   }
   iType = DsMakeType(pType);
   if (iType == 0)
      iType = dptypeZSTRING(1);
   pEntry = (pAttr_Entry)pDsXml->pXmlParse->pAttr_List->Find(szROUNDTRIP, 4);
   if (pEntry)
      iType |= dsIncInDelta; // Asume it is true!
   if (piType)
      *piType = iType;
   rslt = GetFldObj(iType, bBigEndian, pDsXml, &pFldObj);
   if (rslt)
      goto Exit;
   pEntry = (pAttr_Entry)pDsXml->pXmlParse->pAttr_List->Find(szAttrValue, 3);
   if (!pEntry)
   {
      rslt = SetError(DBIERR_DATAPACKETMISMATCH);
      goto Exit;
   }

   iLength = pEntry->iValueLen;
   pFldObj->FldGet(NULL, (pBYTE)pEntry->pValue, &iLength, &bBlank);
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
      iLength = pEntry->iValueLen;
      pFldObj->FldGet(pValue, (pBYTE)pEntry->pValue, &iLength, &bBlank);
   }
   else
   {
      pDsXml->pXmlParse->RestorePos(); // Get Value reads the whole value again!
   }
   pDsXml->pXmlParse->pAttr_List->Reset();

Exit:
   if (pFldObj)
      delete pFldObj;
   return rslt;
}

// Extract the next column descriptor.
DBIResult DBIFN DSEXTRACT::XMLGetColumnDesc(pDSDATAPACKETFLDDesc pFldDes)
{
   DBIResult rslt = DBIERR_NONE;
   pDSRECState pRecState = paRecStates[iCurRecState];
   UINT32 iFieldType;
   BOOL bAnyFldParams;
   BOOL bAttrFld;
   DSDATAPACKETFLDDescX FldDesX;
   ZeroMem((pBYTE) &FldDesX, sizeof(DSDATAPACKETFLDDescX));
   pAttr_Entry pEntry;

   if (bMetaDataDone || pRecState->bColsRead)
   {
      rslt = SetError(DBIERR_EOF);
      goto Exit;
   }
   if (!pFldDes)
   {
      rslt = SetError(DBIERR_INVALIDPARAM);
      goto Exit;
   }
   bFldDescs = FALSE;

   rslt = ReadColumnDesc(pDsXml->pXmlParse, pFldDes, &bAnyFldParams, &bAttrFld); // <fldname>
   if (rslt) // returns eof if last on this level
   {
      if (rslt == DBIERR_EOF)
      {
         pRecState->bColsRead = TRUE;
      }
      goto Exit;
   }
   if (bAttrFld)
      pFldDes->iAttributes |= fldAttrATTRNAME; //
   // Copy to local fielddesc
   CopyMem((pBYTE) &FldDesX, pFldDes, sizeof(DSDATAPACKETFLDDesc));
   pRecState->pFlds_List->Add((pBYTE) &FldDesX, NULL);

   if ((pEntry = pDsXml->pXmlParse->pAttr_List->Find(szAttrFieldName, 1))!=NULL)
   { // overwrite fieldname in returned flddes
      CHAR AttrValue[DBIMAXNAMELEN+1];
      pDsXml->pXmlParse->pAttr_List->SetVisited(pEntry->iId);
      MakeStr(AttrValue, sizeof(AttrValue), pEntry->pValue, pEntry->iValueLen);
      strcpy(pFldDes->szFieldName, AttrValue);
   }

   // Get the attribute count.
   bFldDescs = !bAnyFldParams;
   bFldOptParams = TRUE;

   iFieldCurrent++;
   pRecState->iColumns++;

   iFieldType = pFldDes->iFieldType & dsTypeBitsMask;
   if ((iFieldType = iFieldType >> dsSizeBitsLen) == dsfldEMBEDDEDTBL)
   { // Create new level
      XMLTag Tag;
      UINT16 iCols;

      rslt = pDsXml->pXmlParse->NextTag(&Tag); // <FIELDS count="xx">
      iCols = 0;

      rslt = NewRecState(iCols, (UINT16)pRecState->iColumns, iCurRecState, &iCurRecState);
      bFldDescs = TRUE;
   }

Exit:
   return rslt;
}

DBIResult ReadColumnDesc(DSXML_Parse *pParse, pDSDATAPACKETFLDDesc pFldDes, pBOOL pbOptParams, pBOOL pbAttrFld)
{
   DBIResult rslt = DBIERR_NONE;
   XMLTag Tag;
   CHAR AttrName[DBIMAXNAMELEN+1];
   CHAR AttrValue[DBIMAXNAMELEN+1];
   pAttr_Entry pEntry;

   ZeroMem(pFldDes, sizeof(DSDATAPACKETFLDDesc));
   rslt = pParse->NextTag(&Tag);
   if (rslt)
      goto Exit;
   if (Tag.iTagType == Tag_End) // <FIELDS>
   {
      rslt = SetError(DBIERR_EOF);
      goto Exit;
   }
   MakeStr(AttrName, sizeof(AttrName), Tag.pTagName, Tag.iTagNameLen);
   if (strcmp(AttrName, szPARAMS) == 0)
   {
      rslt = SetError(DBIERR_EOF);
      goto Exit;
   }

   pParse->pAttr_List->Parse(Tag.pAttr);
   // Find field-name

   *pbAttrFld = 0;
   if ((pEntry = pParse->pAttr_List->Find(szAttrAttrName, 1))!=NULL)
   {
      *pbAttrFld = 1;
   }
   else if ((pEntry = pParse->pAttr_List->Find(szAttrTagName, 1))!=NULL)
   {
   }
   else
   {
      rslt = SetError(DBIERR_DATAPACKETMISMATCH);
      goto Exit;
   }
   pParse->pAttr_List->SetVisited(pEntry->iId);

   MakeStr(AttrValue, sizeof(AttrValue), pEntry->pValue, pEntry->iValueLen);
   strcpy(pFldDes->szFieldName, AttrValue);

   if ((pEntry = pParse->pAttr_List->Find(szAttrFieldType, 2))!=NULL)
   {
      MakeStr(AttrValue, sizeof(AttrValue), pEntry->pValue, pEntry->iValueLen);
      pFldDes->iFieldType = DsMakeType(AttrValue);
      pParse->pAttr_List->SetVisited(pEntry->iId);
   }
   if ((pEntry = pParse->pAttr_List->Find(szAttrReadOnly, 3))!=NULL)
   {
      MakeStr(AttrValue, sizeof(AttrValue), pEntry->pValue, pEntry->iValueLen);
      if (stricmp(AttrValue, "true") == 0)
         pFldDes->iAttributes |= fldAttrREADONLY;
      pParse->pAttr_List->SetVisited(pEntry->iId);
   }
   if ((pEntry = pParse->pAttr_List->Find(szAttrHidden, 3))!=NULL)
   {
      MakeStr(AttrValue, sizeof(AttrValue), pEntry->pValue, pEntry->iValueLen);
      if (stricmp(AttrValue, "true") == 0)
         pFldDes->iAttributes |= fldAttrHIDDEN;
      pParse->pAttr_List->SetVisited(pEntry->iId);
   }
   if ((pEntry = pParse->pAttr_List->Find(szAttrRequired, 3))!=NULL)
   {
      MakeStr(AttrValue, sizeof(AttrValue), pEntry->pValue, pEntry->iValueLen);
      if (stricmp(AttrValue, "true") == 0)
         pFldDes->iAttributes |= fldAttrREQUIRED;
      pParse->pAttr_List->SetVisited(pEntry->iId);
   }
   if ((pEntry = pParse->pAttr_List->Find(szAttrLinkFld, 3))!=NULL)
   {
      MakeStr(AttrValue, sizeof(AttrValue), pEntry->pValue, pEntry->iValueLen);
      if (stricmp(AttrValue, "true") == 0)
         pFldDes->iAttributes |= fldAttrLINK;
      pParse->pAttr_List->SetVisited(pEntry->iId);
   }

   if (pFldDes->iFieldType == 0)
      rslt = SetError(DBIERR_INVALIDFLDTYPE);

   if (Tag.iTagType == Tag_Leaf)
   {
      UINT32 iPos = pParse->pAttr_List->iPos;
      *pbOptParams = (pParse->pAttr_List->Next() != 0); // if 0 nore more attrs
      pParse->pAttr_List->iPos = iPos;
   }
   else
      *pbOptParams = TRUE;

Exit:
   return rslt;
}

DBIResult DBIFN DSEXTRACT::XMLInitExtract(SAFEARRAY *pSa)
{
   DBIResult rslt;
   pBYTE pPickle;
   pCHAR pTagName;
   UINT32 iTagNameLen;

   pPickle = (pBYTE)SAGetPtr((SAFEARRAY*)pSa);

   pDsXml = new DSXML_W();
   pDsXml->Init(0, FALSE, 128, TRUE, bUTF8METADATA, iANSICodePage);
   bFirstRow = FALSE;
   iRows = -1; // Signal 'unknown'

   rslt = pDsXml->pXmlParse->Init(pSa->rgsabound[0].cElements, (pCHAR)pPickle); // Reads header
   if (rslt)
      goto Exit;
   pDsXml->bUTF8 = pDsXml->pXmlParse->bUTF8;
   rslt = pDsXml->pXmlParse->ReadBeginTag(&pTagName, &iTagNameLen); // <DATAPACKET>
   if (rslt)
      goto Exit;
   if (memcmp(pTagName, szDATAPACKET, iTagNameLen) != 0)
      goto MetaData;

   rslt = pDsXml->pXmlParse->ReadBeginTag(&pTagName, &iTagNameLen); // <METADATA> or <ROWDATA>
   if (rslt)
      goto Exit;
MetaData:
   if (memcmp(pTagName, szMETADATA, iTagNameLen) == 0) // <METADATA>
   {
      XMLTag Tag;

      iProperties = (PCKLProps)pcklpropsMETADATA_INCL;
      rslt = pDsXml->pXmlParse->NextTag(&Tag); // ReadBeginTag(&pTagName, &iTagNameLen);
      if (rslt)
         goto Exit;
      if (memcmp(Tag.pTagName, szFIELDS, Tag.iTagNameLen) == 0)
      { // <FIELDS>
         iColumns = 0;

      }
      else
         rslt = SetError(DBIERR_DATAPACKETMISMATCH);
      bMetaDataDone = FALSE;
   }
   else
   {
      if (memcmp(pTagName, szDATA, iTagNameLen) == 0)
      {
         bMetaDataDone = TRUE;
      }
      else
         rslt = SetError(DBIERR_DATAPACKETMISMATCH);
   }

   if (!rslt /* && iColumns */ )
   {
      NewRecState(iColumns, 0, 0, &iCurRecState);
      this->pSa = (SAFEARRAY*)pSa;
      if (!pFldAttrObj)
      {
         pFldAttrObj = new FLDCInt8(bBigEndian, FALSE);
         pFldAttrObj->pNamePtr = szAttrFld;
         pFldAttrObj->pDsXml = pDsXml;
      }
   }

Exit:
   SARelPtr(pSa);
   return rslt;
}

// pValue==NULL && pBlank==NULL => get length only
// pValue==NULL && pBlank != NULL => increment pointer ! (delayed blobs only ?)
// pValue != NULL  then *piLength== length of return buffer
DBIResult DBIFN DSEXTRACT::XMLGetField(pUINT32 piLength, // length of value in/out
   pBYTE pValue, // Pointer to the new field value
   pBOOL pBlank) // Pointer to the new field value
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iType; // type of attribute
   UINT32 iLength; // length of value
   pDSRECState pRecState = paRecStates[iCurRecState];
   UINT32 iNestedRows;
   UINT32 iCurrFldNo;
   UINT16 iNewState = 0;
   pDSPROVADTFLDDesc pAdtFldDes;
   pAttr_Entry pEntry;
   CHAR pTagName[DBIMAXNAMELEN+1];
   BOOL bAttrFld = 0;

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

   pDsXml->pXmlParse->StorePos();
   iCurrFldNo = pRecState->iCurrFldNo;
   if (iCurrFldNo > pRecState->iAdtColumns)
      iCurrFldNo = 0;
   pAdtFldDes = iCurrFldNo ? &pRecState->pAdtFieldDesc[iCurrFldNo-1] : NULL;
   if (pAdtFldDes)
      bAttrFld = (BOOL)pAdtFldDes->bAsAttr;

   if (bEndOfThisLevel)
   {
      // needs to be done AFTER bAsAttr is set
      bEndOfThisLevel = FALSE;
      rslt = SetError(DBIERR_EOF);
      goto Again;
   }

   if (iCurrFldNo == 0)
   {
      BOOL bBlank;

      if (bFirstRow)
      { // Initialize parser
         XMLTag Tag;

         bFirstRow = FALSE;

         rslt = pDsXml->pXmlParse->NextTag(&Tag); // <ROWDATA>
         if (rslt)
            goto Exit;
         MakeStr(pTagName, sizeof(pTagName), Tag.pTagName, Tag.iTagNameLen);
         if (strcmp(pTagName, szDATA) != 0)
         {
            rslt = SetError(DBIERR_DATAPACKETMISMATCH);
            goto Exit;
         }
         if (Tag.iTagType == Tag_End || Tag.iTagType == Tag_Leaf)
         { // Contains no records!
            rslt = SetError(DBIERR_EOF);
            goto Exit;
         }

         rslt = pDsXml->pXmlParse->NextTag(&Tag); // <ROW>
         if (rslt)
            goto Exit;
         MakeStr(pTagName, sizeof(pTagName), Tag.pTagName, Tag.iTagNameLen);
         if (memcmp(pTagName, szROW, 3)!=0) // strcmp(pTagName, szROW) != 0)
         {
            rslt = SetError(DBIERR_DATAPACKETMISMATCH);
            goto Exit;
         }

         if (Tag.iTagType == Tag_End)
         {
            rslt = SetError(DBIERR_EOF);
            goto Exit;
         }
         pRecState->pAttr_List->Parse(Tag.pAttr);
         // else okay (Tag_Begin)
      }

      iLength = sizeof(BYTE);

      pAttr_Entry pEntry = pRecState->pAttr_List->Find(szRowState, 0);
      if (pEntry == NULL)
         *pValue = 0;
      else
      {
         UINT32 iLen = pEntry->iValueLen;
         pFldAttrObj->FldGet(pValue, (pBYTE)pEntry->pValue, &iLen, &bBlank);
         if (bBlank)
            *pValue = 0;
      }
      if (pBlank)
         *pBlank = 0;
      goto Finish;
   } // End CurrFldNo==0

   if (pBlank)
      *pBlank = 0;

   // Get Field-Value, Field-Length
   iType = pAdtFldDes->iBaseFieldType;

   iNewState = pAdtFldDes->iNewRecState;
   if (iNewState)
   {
      XMLTag Tag;
      rslt = pDsXml->pXmlParse->NextTag(&Tag); // <ROWDATA>
      if (rslt)
         goto Exit;
      MakeStr(pTagName, sizeof(pTagName), Tag.pTagName, Tag.iTagNameLen);

      if (memcmp(pTagName, pAdtFldDes->pFldObj->pNamePtr, Tag.iTagNameLen)!=0)
      {
         pDsXml->pXmlParse->RestorePos();
         goto NestedBlank;
      }

      if (Tag.iTagType == Tag_Begin)
      {
         iNestedRows = (UINT32)(dsDELAYEDBIT -1); // *(pUINT32) pValue; // Could be 0 !
      }
      else
      {
      NestedBlank:
         iNestedRows = 0;
         if (pBlank)
            *pBlank = BLANK_NULL;
      }
      iLength = sizeof(UINT32);
      if (pValue)
         *(pUINT32)pValue = iNestedRows;
      goto Finish;
   }

   if (bAttrFld)
   {
      pEntry = pRecState->pAttr_List->Find(pAdtFldDes->pFldObj->pNamePtr, iCurrFldNo-1);
   }

   // Get length
   if (pValue == NULL && pBlank == NULL)
   {

      if (!(iType & (dsVaryingFldType | dsArrayFldType)))
      {
         // fixed length field.
         iLength = pAdtFldDes->pFldObj->iLen;
      }
      else
      {
         // variable length field.
         if (bAttrFld)
         {
            if (pEntry == NULL)
               iLength = 0;
            else
            {
               iLength = pEntry->iValueLen;
               pAdtFldDes->pFldObj->FldGet(NULL, (pBYTE)pEntry->pValue, &iLength, NULL);
            }
         }
         else
         {
            pCHAR pValPtr;
            rslt = pDsXml->pXmlParse->ReadValue(pAdtFldDes->pFldObj->pNamePtr, &pValPtr, &iLength, NULL);
            // Points to Value
            if (!rslt)
               pAdtFldDes->pFldObj->FldGet(NULL, (pBYTE)pValPtr, &iLength, NULL);
            pDsXml->pXmlParse->RestorePos();
         }
      }
   }
   else
   {
      // Get Value
      if (bAttrFld)
      {
         if (pEntry == NULL)
         {
            if (pBlank)
               *pBlank = (BOOL)BLANK_NOTCHANGED; // fldIsNull;
         }
         else
         {
            if (!pValue)
               goto Finish;

            iLength = pEntry->iValueLen;
            pAdtFldDes->pFldObj->FldGet(NULL, (pBYTE)pEntry->pValue, &iLength, pBlank);
            if (iLength <= *piLength)
            {
               iLength = pEntry->iValueLen;
               pAdtFldDes->pFldObj->FldGet(pValue, (pBYTE)pEntry->pValue, &iLength, pBlank);
            }
            else
            {
               pValue[0] = 0;
            }
         }
      }
      else
      {
         pCHAR pValPtr;
         rslt = pDsXml->pXmlParse->ReadValue(pAdtFldDes->pFldObj->pNamePtr, &pValPtr, &iLength, pBlank);
         // Points to Value
         if (!rslt && !(*pBlank))
            pAdtFldDes->pFldObj->FldGet(pValue, (pBYTE)pValPtr, &iLength, pBlank);
         if (!pValue)
         {
            pDsXml->pXmlParse->RestorePos();
            goto Finish;
         }
      }
   }

Finish:

   *piLength = iLength;
   if (!pValue && !pBlank) // This is a 'GetFieldLength'.Do not increment
   {
      pDsXml->pXmlParse->RestorePos();
      goto Exit;
   }

   ++pRecState->iCurrFldNo;
   if (iNewState && iNestedRows)
   {
      XMLTag Tag;
      iCurRecState = iNewState;
      pRecState = paRecStates[iNewState];
      pRecState->iRowCountDown = iNestedRows;
      pRecState->iCurrFldNo = 0;
      rslt = pDsXml->pXmlParse->NextTag(&Tag);
      if (rslt)
         goto Exit;
      // Check Tag-name
      pRecState->pAttr_List->Parse(Tag.pAttr);
   }
   else // Note: embedded rows could be last field, so do not finish row until rnested rows are done
   {
   Again:
      DBIResult SaveRslt = rslt;

      if (pRecState->iCurrFldNo > pRecState->iAdtColumns)
      {
         XMLTag Tag;
         pRecState->iCurrFldNo = 0;

         if (bAttrFld && pDsXml->pXmlParse->pCurTag.iTagType == Tag_Leaf)
         {
            // If any structure fields, we must read the </ROW anyway>
         }
         else
         {
            rslt = pDsXml->pXmlParse->ReadEndTag(); // </ROW>
            if (rslt)
               goto Exit;
         }

         // Read next ROW
         rslt = pDsXml->pXmlParse->NextTag(&Tag);
         if (rslt)
            goto Exit;
         if (Tag.iTagType == Tag_End) // </nested table'>  or </ROWDATA>
         {
            if (iCurRecState == 0)
            {
               iRowCurrent++; // Nesc.?
               if (this->pSa)
                  SARelPtr(this->pSa);
               this->pSa = NULL; // This iwill force an EOF next time
               rslt = SaveRslt;
               goto Exit;
            }
            else
            {
               --pRecState->iRowCountDown; // Nesc.?
               iCurRecState = pRecState->iPrevRecState; // Done with this level
               pRecState = paRecStates[iCurRecState];
               bEndOfThisLevel = TRUE;
               rslt = SaveRslt;
               goto Exit; // This ishould cause an eof in next call!
            }
         }
         if (!bAttrFld && Tag.iTagType == Tag_Leaf &&(pBlank && !*pBlank /* nested table thas is blank */ ))
         {
            rslt = SetError(DBIERR_DATAPACKETMISMATCH);
            goto Exit;
         }
         // else Begin_Tag  (okay), start of next row

         // Full row was given
         if (iCurRecState == 0)
         { // Update global info
            if (++iRowCurrent > iRows)
            { // We are DONE,
               if (this->pSa)
                  SARelPtr(this->pSa);
               this->pSa = NULL;
            }
            else
            {
               pRecState->pAttr_List->Parse(Tag.pAttr);
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
            pRecState->pAttr_List->Parse(Tag.pAttr);
         }
         rslt = SaveRslt;
      }
   }
Exit:
   return rslt;
}

UINT32 DsMakeType(pCCHAR pXmlType)
{
   CHAR ch;

   switch(pXmlType[0])
   {
   case 'I':
   case 'i':
      {
         ch = pXmlType[1];
         switch(ch)
         {
         case '1':
            return dptypeINT8;
         case '2':
            return dptypeINT16;
         case 0: // "i"
         case '4':
            return dptypeINT32;
         case '8':
            return dptypeINT64;
         default:
            if (stricmp(pXmlType, "int") == 0)
               return dptypeINT32;
            if (stricmp(pXmlType, szXMLIntArray) == 0)
               return dptypeINTARRAY;
            return 0;
         }
      }
   case 'U':
   case 'u':
      {
         ch = pXmlType[2];
         switch(ch)
         {
         case '1':
            return dptypeUINT8;
         case '2':
            return dptypeUINT16;
         case 0: // "i"
         case '4':
            return dptypeUINT32;
         case '8':
            return dptypeUINT64;
         default:
            if (stricmp(pXmlType, "uint") == 0)
               return dptypeUINT32;
            if (stricmp(pXmlType, szXMLUIntArray) == 0)
               return dptypeUINTARRAY;
            return 0;
         }
      }
   case 'R':
   case 'r':
      {
         if (stricmp(pXmlType, "r4") == 0)
            return dptypeSINGLE;
         if (stricmp(pXmlType, "r8") == 0)
            return dptypeFLOAT;
         if (stricmp(pXmlType, "r10") == 0)
            return dptypeFLOATIEEE;
         return 0;
      }
   case 'F':
   case 'f':
      { // "fixed."
         if (stricmp(pXmlType, szXMLFixedFMT) == 0)
            return dptypeFMTBCD(32);
         else
            return dptypeBCD(32);
         // return 0;
      }
   case 'D':
   case 'd':
      {
         if (stricmp(pXmlType, szXMLDate) == 0)
            return dptypeDATE;
         if (stricmp(pXmlType, szXMLDateTime) == 0)
            return dptypeTIMESTAMP;
         if (stricmp(pXmlType, szXMLSQLDateTime) == 0)
            return dptypeSQLTIMESTAMP;
         if (stricmp(pXmlType, szXMLSQLDateTimeOffset) == 0)
            return dptypeSQLTIMESTAMPOFFSET;
         return 0;
      }
   case 'T':
   case 't':
      if (stricmp(pXmlType, szXMLTime) == 0)
         return dptypeTIME;
      return 0;
   case 'S':
   case 's':
      if (stricmp(pXmlType, szXMLStringAnsi) == 0)
         return dptypeZSTRING(1); // Assume < 256..
      if (stricmp(pXmlType, szXMLStringUni) == 0)
         return dptypeUNICODE(2); // Assume > 256..
      if (stricmp(pXmlType, szXMLSQLDateTime) == 0)
         return dptypeSQLTIMESTAMP;
      if (stricmp(pXmlType, szXMLSQLDateTimeOffset) == 0)
         return dptypeSQLTIMESTAMPOFFSET;
      return 0;
   case 'B':
   case 'b':
      {
         if (stricmp(pXmlType, szXMLBool) == 0)
            return dptypeBOOL16;
         if (stricmp(pXmlType, szXMLBinHex) == 0)
            return dptypeVARBYTES(1); // Assume < 256..
         return 0;
      }
   default:
      {
         if (stricmp(pXmlType, szXMLNested) == 0)
            return dptypeTABLE(0);
         if (stricmp(pXmlType, szXMLADT) == 0)
            return dptypeADT(0);
      }
   }

   return 0;
}

// Convert dsfldtype into xml-type (string)
DBIResult DBIFN XmlMakeType(UINT32 iFieldType, pCCHAR *ppzXmlType, pUINT32 pFixedSize)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iPCKLFldType, iSize;
   BOOL bVarying = FALSE;
   BOOL bRepeat = FALSE;

   if (pFixedSize)
      *pFixedSize = 0;

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
      *ppzXmlType = szXMLBool;
      break;
   case dsfldDATE:
      *ppzXmlType = szXMLDate;
      break;
   case dsfldTIME:
      *ppzXmlType = szXMLTime;
      break;
   case dsfldUINT:
      if (bRepeat)
         *ppzXmlType = szXMLUIntArray;
      else
         *ppzXmlType = (iSize == 4) ? (char*)szXMLUInt32 : (iSize == 2) ? (char*)szXMLUInt16 : (iSize == 1) ? (char*)
            szXMLUInt8 :
         NULL;
      break;
   case dsfldINT:
      if (bRepeat)
         *ppzXmlType = szXMLIntArray;
      else
         *ppzXmlType = (iSize == 4) ? (char*)szXMLInt32 : (iSize == 2) ? (char*)szXMLInt16 : (iSize == 1) ? (char*)
            szXMLInt8 : (iSize == 8) ? (char*)szXMLInt64 : NULL;
      break;
   case dsfldDATETIME:
      *ppzXmlType = szXMLSQLDateTime;
      break;
   case dsfldDATETIMEOFFSET:
      *ppzXmlType = szXMLSQLDateTimeOffset;
      break;
   case dsfldTIMESTAMP:
      *ppzXmlType = szXMLDateTime;
      break;
   case dsfldSINGLE:
      *ppzXmlType = (iSize == 4) ? (char*)szXMLSingle : NULL;
      break;
   case dsfldFLOATIEEE:
      *ppzXmlType = (iSize == 8) ? (char*)szXMLFloat :
      NULL;
      break;
   case dsfldFMTBCD:
      *ppzXmlType = szXMLFixedFMT; // Need iunits1 and 2!
      break;
   case dsfldBCD:
      *ppzXmlType = szXMLFixed; // Need iunits1 and 2!
      break;
   case dsfldARRAY:
      *ppzXmlType = NULL; // szXMLArray;
      break;
   case dsfldADT:
      *ppzXmlType = NULL; // szXMLADT;
      break;
   case dsfldEMBEDDEDTBL:
      *ppzXmlType = szXMLNested;
      break;
   case dsfldUNICODE:
      *ppzXmlType = szXMLStringUni; // szXMLUni;
      break;
   case dsfldZSTRING:
      *ppzXmlType = szXMLStringAnsi;
      break;
   case dsfldBYTES:
      *ppzXmlType = szXMLBinHex; // Includes MEMO etc.
      if (!bVarying && pFixedSize)
      {
         *pFixedSize = iSize;
      }
      break;
   case dsfldBIGDECIMAL:
   case dsfldUNKNOWN:
      break;
   default:
      *ppzXmlType = NULL;
      break;
   }
Exit:
   if (*ppzXmlType == NULL)
      rslt = SetError(DBIERR_XMLINVALIDTYPE);
   return rslt;
}

DSXML_W::DSXML_W()
{
   iIndentSize = 0;
   iIndentLevel = 0;
   bEnableCRLF = FALSE;
   iStyle = 0;
   pXmlParse = NULL;
   bOpenTag = FALSE;
   pVarBuf = NULL;
   iVarBufLen = 0;
   bUTF8 = FALSE;
   bUTF8METADATA = FALSE;
   iANSICodePage = 0;
}

DSXML_W::~DSXML_W()
{
   if (pXmlParse)
      delete pXmlParse;
   if (pVarBuf)
      delete[] pVarBuf;
}

pBYTE DSXML_W::GetVarBuf(UINT32 iLen)
{
   if (pVarBuf == NULL)
   {
      pVarBuf = new BYTE[iLen+8];
      iVarBufLen = iLen+8;
   }
   else
   {
      if (iLen>iVarBufLen)
      {
         delete[] pVarBuf;
         pVarBuf = NULL;
         iVarBufLen = 0;
         return GetVarBuf(iLen);
      }
   }
   return pVarBuf;
}

DBIResult DSXML_W::Init(UINT32 iIndentSize, BOOL bEnableCRLF, UINT32 iStyle, BOOL bRead, BOOL bMETADATAMode, INT32 iAnsiCP)
{
#ifdef _UNIX
//   setlocale(LC_ALL, "");
#endif

   this->iIndentSize = iIndentSize;
   this->bEnableCRLF = bEnableCRLF;
   this->iStyle = iStyle;
   if (iStyle & xmlXMLUTF8)
      this->bUTF8 = TRUE;
   this->bUTF8METADATA = bMETADATAMode;
   this->iANSICodePage = iAnsiCP;

   if (bRead && pXmlParse == NULL)
   {
      pXmlParse = new DSXML_Parse();
      if (this->bUTF8)
         pXmlParse->bUTF8 = this->bUTF8;
      pXmlParse->bUTF8METADATA = bUTF8METADATA;
      pXmlParse->iANSICodePage = iANSICodePage;
   }
   return 0;
}


CHAR szXMLHEAD[39] = {'<','?','x','m','l',' ','v','e','r','s','i','o','n','=','"','1','.','0','"',' ',
                    's','t','a','n','d','a','l','o','n','e','=','"','y','e','s','"','?','>', 0x00};

//#define szXMLHEAD "<?XML VERSION="1.0" RMD="NONE"?>"
CHAR szXMLHEADUTF8[57] = {'<','?','x','m','l',' ','v','e','r','s','i','o','n','=','"','1','.','0','"',' ',
                    'e','n','c','o','d','i','n','g','=','"','U','T','F','-','8','"',' ',
                    's','t','a','n','d','a','l','o','n','e','=','"','y','e','s','"','?','>', 0x00};

pBYTE DSXML_W::WriteHead(pBYTE pPos)
{
   UINT32 iLen;

   iLen = (bUTF8)? strlen(szXMLHEADUTF8) : strlen(szXMLHEAD);

   if (bUTF8)
      memmove((pCHAR)pPos, szXMLHEADUTF8, iLen); // Dont include zero
   else
      memmove((pCHAR)pPos, szXMLHEAD, iLen); // Dont include zero
   pPos += iLen;
   if (bEnableCRLF)
   {
      *pPos++ = 0x0D;
      *pPos++ = 0x0A;
   }
   else
   {
      *pPos++ = ' ';
      *pPos++ = ' ';
   }
   return pPos;
}

UINT32 DSXML_W::HeadLen()
{
   if (bUTF8)
      return strlen(szXMLHEADUTF8)+2;
   return strlen(szXMLHEAD)+2;
}

pBYTE DSXML_W::WriteOpenTag(pBYTE pPos, pCCHAR pTagName, BOOL bIndent)
{
   UINT32 i;

   if (pTagName == NULL)
      return pPos;

   if (bOpenTag)
      pPos = WriteFinishTag(pPos, TRUE);

   if (bIndent)
   {
      for (i = 0; i < iIndentLevel*iIndentSize; i++)
         *pPos++ = ' ';
   }
   *pPos++ = '<';
   strcpy(OpenTag, pTagName); // Store open tag
   strcpy((pCHAR)pPos, pTagName);
   pPos += strlen(pTagName);
   // *pPos++ = ' ';
   bOpenTag = TRUE;
   iIndentLevel++;
   return pPos;
}

pBYTE DSXML_W::WriteBeginTag(pBYTE pPos, pCCHAR pTagName, pCCHAR pType, BOOL bIndent, BOOL bCRLF)
{
   UINT32 i;

   if (pTagName == NULL)
      return pPos;
   if (bOpenTag)
      pPos = WriteFinishTag(pPos, FALSE);
   if (bIndent)
   {
      for (i = 0; i < iIndentLevel*iIndentSize; i++)
         *pPos++ = ' ';
   }
   *pPos++ = '<';
   strcpy(LastTag, pTagName); // Store last tag
   OpenTag[0] = 0;
   strcpy((pCHAR)pPos, pTagName);
   pPos += strlen(pTagName);
   if (pType)
   {
      pPos = WriteAttribute(pPos, szXMLTYPEBEG, pType);
   }
   *pPos++ = '>';
   if (bCRLF && bEnableCRLF)
   { // Always put it on a new line
      *pPos++ = 0x0D;
      *pPos++ = 0x0A;
   }
   iIndentLevel++;
   return pPos;
}

pBYTE DSXML_W::WriteFinishTag(pBYTE pPos, BOOL bEmpty)
{

   if (bEmpty && iIndentLevel)
      iIndentLevel--;
   if (bEmpty)
      *pPos++ = '/';
   *pPos++ = '>';
   if (bEnableCRLF)
   { // Always put it on a new line
      *pPos++ = 0x0D;
      *pPos++ = 0x0A;
   }
   strcpy(LastTag, OpenTag); // Store open tag
   OpenTag[0] = 0;
   bOpenTag = FALSE;
   return pPos;
}

pBYTE DSXML_W::WriteEndTag(pBYTE pPos, pCCHAR pTagName, BOOL bIndent)
{
   UINT32 i;

   if (pTagName == NULL)
      return pPos;
   if (bOpenTag)
      pPos = WriteFinishTag(pPos, FALSE);

   if (iIndentLevel)
      iIndentLevel--;
   if (bIndent)
   {
      for (i = 0; i < iIndentLevel*iIndentSize; i++)
         *pPos++ = ' ';
   }
   *pPos++ = '<';
   *pPos++ = '/';

   strcpy(LastTag, pTagName); // Store open tag
   OpenTag[0] = 0;
   strcpy((pCHAR)pPos, pTagName);
   pPos += strlen(pTagName);
   *pPos++ = '>';
   if (bEnableCRLF)
   { // Always put it on a new line
      *pPos++ = 0x0D;
      *pPos++ = 0x0A;
   }
   return pPos;
}

pBYTE DSXML_W::WriteEmptyTag(pBYTE pPos, pCCHAR pTagName, BOOL bIndent, BOOL bCRLF)
{
   if (pTagName == NULL)
      return pPos;

   UNREFERENCED_PARAMETER(bCRLF);
   pPos = WriteBeginTag(pPos, pTagName, NULL, bIndent, FALSE);
   pPos = WriteEndTag(pPos, pTagName, FALSE);
#ifdef SHORTHAND
   if (bIndent)
   {
      for (i = 0; i < iIndentLevel*iIndentSize; i++)
         *pPos++ = ' ';
   }

   *pPos++ = '<';
   strcpy((pCHAR)pPos, pTagName);
   pPos += strlen(pTagName);
   *pPos++ = '/';
   *pPos++ = '>';
   if (bCRLF && bEnableCRLF)
   { // Always put it on a new line
      *pPos++ = 0x0D;
      *pPos++ = 0x0A;
   }
#endif
   return pPos;
}

pBYTE DSXML_W::WriteAttributeData(pBYTE pPos, pCCHAR pAttrName, pCCHAR pValue)
{
   if (pValue == NULL)
      return pPos;
   return WriteAttributeLen(pPos, pAttrName, pValue, strlen(pValue), FALSE);
}

pBYTE DSXML_W::WriteAttribute(pBYTE pPos, pCCHAR pAttrName, pCCHAR pValue)
{
   if (pValue == NULL)
      return pPos;
   return WriteAttributeLen(pPos, pAttrName, pValue, strlen(pValue), bUTF8METADATA);
}

pBYTE DSXML_W::WriteAttributeLen(pBYTE pPos, pCCHAR pAttrName, pCCHAR pValue, UINT32 iLen, BOOL bValueIsUTF8)
{
   if (pValue!=NULL) // Otherwise ignore, it is blank!
   {
      *pPos++ = ' ';
      if (!bUTF8METADATA && bUTF8) // Ansi -> UTF8
      {
         int bSize = MultiByteToUTF8(iANSICodePage, (unsigned char*)pAttrName, strlen(pAttrName), NULL, 0);
         pCHAR pBuf = (pCHAR)malloc(bSize + 1); // null terminator
         bSize = MultiByteToUTF8(iANSICodePage, (unsigned char*)pAttrName, strlen(pAttrName), (unsigned char*)pBuf, bSize);
         pBuf[bSize] = 0;
         strcpy((pCHAR)pPos, pBuf);
         pPos += strlen(pBuf);
         free(pBuf);
      }
      else if (bUTF8METADATA && !bUTF8) // UTF8 -> ANSI
      {
         int bSize = UTF8ToMultiByte(iANSICodePage, (unsigned char*)pAttrName, strlen(pAttrName), NULL, 0);
         pCHAR pBuf = (pCHAR)malloc(bSize + 1); // null terminator
         bSize = UTF8ToMultiByte(iANSICodePage, (unsigned char*)pAttrName, strlen(pAttrName), (unsigned char*)pBuf, bSize);
         pBuf[bSize] = 0;
         strcpy((pCHAR)pPos, pBuf);
         pPos += strlen(pBuf);
         free(pBuf);
      }
      else // UTF8 -> UTF8 or ANSI -> ANSI
      {
         strcpy((pCHAR)pPos, pAttrName);
         pPos += strlen(pAttrName);
      }
      *pPos++ = '=';
      *pPos++ = '"';
      if (!bValueIsUTF8 && bUTF8) // ANSI data -> UTF8
         pPos = CopyReplaceSpecialCharsUTF8(iANSICodePage, pPos, pAttrName, pValue, iLen);
      else if (bValueIsUTF8 && !bUTF8) // UTF8 data -> ASCII
         pPos = CopyReplaceSpecialCharsAscii(pPos, pAttrName, pValue, iLen);
      else // (bValueIsUTF8== bUTF8)
         pPos = CopyReplaceSpecialChars(pPos, pAttrName, pValue, iLen, bUTF8);

      *pPos++ = '"';
   }
   return pPos;
}

pBYTE DSXML_W::WriteString(pBYTE pPos, pCCHAR psz, BOOL bCRLF)
{
   strcpy((pCHAR)pPos, psz);
   pPos += strlen(psz);
   if (bCRLF && bEnableCRLF)
   { // Always put it on a new line
      *pPos++ = 0x0D;
      *pPos++ = 0x0A;
   }
   return pPos;
}

pBYTE DSXML_W::WriteValue(pBYTE pPos, pCCHAR pTagName, pCCHAR pTypeName, pCCHAR pValue)
{
   if (pValue)
   {
      if (bAsAttrs && pTagName)
      {
         if (pValue != NULL)
            pPos = WriteAttributeLen(pPos, pTagName, pValue, strlen(pValue));
      }
      else
      {
         UINT32 iLen;
         iLen = strlen(pValue);
         pPos = WriteBeginTag(pPos, pTagName, NULL, TRUE, FALSE);

         if (pTypeName && iStyle & xmlXMLDATATYPED)
         {
            pPos--;
            *pPos++ = ' '; // Overwrite '>'
            strcpy((pCHAR)pPos, szXMLTYPEBEG);
            pPos += strlen(szXMLTYPEBEG);
            *pPos++ = '"';
            strcpy((pCHAR)pPos, pTypeName);
            pPos += strlen(pTypeName);
            *pPos++ = '"';
            *pPos++ = '>';
         }
         strcpy((pCHAR)pPos, pValue);
         pPos += iLen;
         pPos = WriteEndTag(pPos, pTagName, FALSE);
      }
   }
   else
   {
      if (!bAsAttrs)
         pPos = WriteEmptyTag(pPos, pTagName, TRUE, TRUE);
   }
   return pPos;
}

pBYTE DSXML_W::WriteValueLen(pBYTE pPos, pCCHAR pTagName, pCCHAR pTypeName, pCCHAR pValue, UINT32 iLen)
{
   UNREFERENCED_PARAMETER(iLen);
   if (pValue)
   {
      if (bAsAttrs &&pTagName)
      {
         pPos = WriteAttributeLen(pPos, pTagName, pValue, iLen);
      }
      else
      {
         pPos = WriteBeginTag(pPos, pTagName, NULL, TRUE, FALSE);
         if (pTypeName && iStyle & xmlXMLDATATYPED)
         {
            pPos = WriteAttributeData(pPos-1, szXMLTYPEBEG, pTypeName);
         }
         pPos = CopyReplaceSpecialChars(pPos, pTagName, pValue, iLen, bUTF8); // strlen(pValue));
         pPos = WriteEndTag(pPos, pTagName, FALSE);
      }
   }
   else
   {
      if (!bAsAttrs)
         pPos = WriteEmptyTag(pPos, pTagName, TRUE, TRUE);
   }
   return pPos;
}

pBYTE CopyReplaceSpecialCharsUTF8(INT32 AnsiCP, pBYTE pPos, pCCHAR pTagName, pCCHAR pValue, UINT32 iLen)
{
   if (iLen!=0)
   {
      int UTF8BufSize = MultiByteToUTF8(AnsiCP, (unsigned char*)pValue, iLen, NULL, 0);

      if (UTF8BufSize!=0)
      {
         pCHAR pUTF8Buf = (pCHAR)malloc(UTF8BufSize+1);

         if (pUTF8Buf!=NULL)
         {
            MultiByteToUTF8(AnsiCP, (unsigned char*)pValue, iLen, (unsigned char*)pUTF8Buf, UTF8BufSize);
            pUTF8Buf[UTF8BufSize] = '\0';
            pPos = CopyReplaceSpecialChars(pPos, pTagName, pUTF8Buf, UTF8BufSize, TRUE);
            free(pUTF8Buf);
         }
      }
   }
   return pPos;
}

// UTF8 -> Ascii
pBYTE CopyReplaceSpecialCharsAscii(pBYTE pPos, pCCHAR pTagName, pCCHAR pValue, UINT32 iLen)
{
   if (iLen!=0)
   {
      int UTF8BufSize = UTF8ToAsciiWithEscape((unsigned char*)pValue, iLen, NULL, 0);

      if (UTF8BufSize!=0)
      {
         pCHAR pUTF8Buf = (pCHAR)malloc(UTF8BufSize+1);

         if (pUTF8Buf!=NULL)
         {
            UTF8ToAsciiWithEscape((unsigned char*)pValue, iLen, (unsigned char*)pUTF8Buf, UTF8BufSize);
            pUTF8Buf[UTF8BufSize] = '\0';
            pPos = CopyReplaceSpecialChars(pPos, pTagName, pUTF8Buf, UTF8BufSize, FALSE);
            free(pUTF8Buf);
         }
      }
   }
   return pPos;
}

pBYTE CopyReplaceSpecialChars(pBYTE pPos, pCCHAR pTagName, pCCHAR pValue, UINT32 iLen, BOOL bUTFFlag)
{
   pCHAR pTemp;
   pCCHAR pVal;
   UINT32 iLenRem;

   UNREFERENCED_PARAMETER(pTagName);

   // pValue may be not NULL terminated. strcspn will be overrun in this case.
   if (pValue[iLen] != 0)
   {
      // Copy iLen bytes from pValue, and add NULL terminator.
      pTemp = (pCHAR)malloc(iLen+1);
      memmove(pTemp, pValue, iLen);
      pTemp[iLen] = '\0';
      pVal = pTemp;
   }
   else
   {
      pTemp = NULL;
      pVal = pValue;
   }

   iLenRem = iLen;
   while (iLenRem)
   {
      UINT32 iDist;
//TODO: Review once we have an alternate to _mbscspn for Android
#if defined(__ANDROID__)
      iDist = strcspn((const char*)pVal, (const char*)"<>&'\"\r\n\t\\");
#else
      if (bUTFFlag) // multibyte function cannot use for UTF8
         iDist = strcspn((const char*)pVal, (const char*)"<>&'\"\r\n\t\\");
      else
         iDist = _mbscspn((pBYTE)pVal, (pBYTE)"<>&'\"\r\n\t\\");
#endif

      memmove((pCHAR)pPos, pVal, iDist);
      pPos+=iDist;
      pVal+=iDist;
      if (iDist != iLenRem)
      { // Found a char
         pCCHAR pPtr = NULL;
         switch(*pVal)
         {
         case '<':
            pPtr = "&lt;";
            break;
         case '>':
            pPtr = "&gt;";
            break;
         case '"':
            pPtr = "&quot;";
            break;
         case '&':
            if (iDist != iLenRem-1 && pVal[1] == 0x01)
            {
               pPtr = "&#"; // specail signal from 'FromUNICODE'. See dsxmlfld.cpp
               pVal++;
               iDist++;
            }
            else
               pPtr = "&amp;";
            break;
         case '\'':
            pPtr = "&apos;";
            break;
            // escape sequences:
         case '\r':
            pPtr = "&#013;"; // carriage return
            break;
         case '\n':
            pPtr = "&#010;"; // new line/line feed
            break;
         case '\t':
            pPtr = "&#009;"; // tab
            break;
         case '\\':
            pPtr = "&#092;"; // "\\\\";//doubles the number!  //="&#092;"; //back-slash
            break;
         }
         if (pPtr)
         {
            strcpy((pCHAR)pPos, pPtr);
            pPos +=strlen(pPtr);
         }
         pVal++;
         iDist++;
      }
      iLenRem -=iDist;
   }
   if (pTemp)
      free(pTemp);
   return pPos;
}

DSXML_Parse::DSXML_Parse()
{
   pXML = NULL;
   pStart = NULL;
   pCurPos = NULL;
   pEnd = NULL;
   ZeroMem(&pCurTag, sizeof(XMLTag));
   // pCurTagLen = 0;
   iStackPos = 0;
   iStackSize = XMLSTACKSIZE;
   bUTF8 = FALSE;
   bUTF8METADATA = FALSE;
   pAttr_List = new Attr_List(NULL);
   pAttr = NULL;
   pUTF8Buf = NULL;
   iANSICodePage = 0;
}

DSXML_Parse::~DSXML_Parse()
{
   if (pAttr_List)
      delete pAttr_List;
   if (pUTF8Buf)
      free(pUTF8Buf);
}

DBIResult DSXML_Parse::Init(UINT32 iLen, pCHAR pXMLStr)
{
   DBIResult rslt;
   pXML = pXMLStr;
   pCurPos = pXMLStr;
   pEnd = pXMLStr+iLen; // Last element in string
   pStart = ParseHead(pXMLStr, &rslt); // Start of XML-string

   if (!rslt)
   {
      if (bUTF8 && !bUTF8METADATA) // UTF8 -> Ansi
      {
         int bSize = UTF8ToMultiByte(iANSICodePage, (unsigned char*)pStart, (pEnd - pStart), NULL, 0);
         if (bSize != 0)
         {

            pUTF8Buf = (pCHAR)malloc(bSize);
            UTF8ToMultiByte(iANSICodePage, (unsigned char*)pStart, (pEnd - pStart), (unsigned char*)pUTF8Buf, bSize);

            pXML = pUTF8Buf;
            pCurPos = pUTF8Buf;
            pEnd = pUTF8Buf+bSize; // Last element in string
            pStart = pUTF8Buf;
         }
         // If bSize is 0, ... I have no idea.
      }
      else if (!bUTF8 && bUTF8METADATA) // Ansi -> UTF8
      {
         // This function supports &#NNNN; format.
         int bSize = MultiByteToUTF8WithEscape(iANSICodePage, (unsigned char*)pStart, (pEnd - pStart), NULL, 0);
         if (bSize != 0)
         {

            pUTF8Buf = (pCHAR)malloc(bSize+1); // +1 for NULL terminator
            MultiByteToUTF8WithEscape(iANSICodePage, (unsigned char*)pStart, (pEnd - pStart), (unsigned char*)pUTF8Buf, bSize);
            pUTF8Buf[bSize] = 0;

            pXML = pUTF8Buf;
            pCurPos = pUTF8Buf;
            pEnd = pUTF8Buf+bSize; // Last element in string
            pStart = pUTF8Buf;
            bUTF8 = TRUE;
         }
      }
      else // Ansi -> Ansi & UTF8 -> UTF8
      {
         // No need to do.
      }
   }
   return rslt;
}

// (http://www.unicode.org/versions/corrigendum1.html  Table 3.1B)
//
// 0 :         : illegal lead byte.
// 1 : 00 - 7F : 1 byte sequence
// 2 : C2 - DF : 2 byte sequence
// 3 : E0      : 3 byte sequence (U+0800 .. U+0FFF)
// 4 : E1 - EF : 3 byte sequence (U+1000 .. U+FFFF)
//

char trailbytesForUTF8[256] = {
  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  // 00-1F // 00-7F : 1byte
  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  // 20-3F
  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  // 40-5F
  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  // 60-7F
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  // 80-9F // 80-C1 : illegal
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  // A0-BF
  0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,  2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,  // C0-DF // C2-DF : 2byte
  3,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0   // E0-FF // E0-EF : 3byte  F0.. illegal (not UCS-2)
};

pCHAR DSXML_Parse::ParseHead(pCHAR pXML, DBIResult *pErr)
{
   // UNREFERENCED_PARAMETER(pXML);
   pCHAR pAttr = NULL;
   CHAR AttrName[DBIMAXNAMELEN+1];
   CHAR AttrValue[2*DBIMAXNAMELEN+1];

   UINT8 ch = NextChar(FALSE);

   bUTF8 = FALSE;
   if (ch == 0xEF)
   { // 0xEF BB BF - BOM of UTF-8 encode
      if ((*(pUINT8)pXML == 0xEF) &&(*((pUINT8)pXML+1) == 0xBB) && (*((pUINT8)pXML+2) == 0xBF))
      {
         bUTF8 = TRUE;
         this->pXML += 3; // skip BOM
         pCurPos += 3;
         ch = NextChar(FALSE);
      }
   }

   if (ch == '<')
   {
      if (NextChar(TRUE) == '?')
      {
         pAttr = pCurPos;
      Again:
         while ((ch = NextChar(TRUE)) != '?' && ch != 0)
            if (ch == 0)
               goto Err;
         if ((ch = NextChar(TRUE)) != '>')
            goto Again;
         MoveAhead();
      }
      else
         pCurPos--;
      // else no header;
   }
   else
   {
   Err:
      *pErr = SetError(DBIERR_DATAPACKETMISMATCH);
      return NULL;
   }

   if (!bUTF8) // if UTF-8 BOM is not exist, check encode tag, and scan to validate to keep compatibility.
   {
      while (pAttr)
      {
         AttrName[0] = 0;
         AttrValue[0] = 0;
         pAttr = ReadAttribute(pAttr, AttrName, AttrValue, NULL);
         if (stricmp(szXMLEncoding, AttrName) == 0)
         {
            if (stricmp(AttrValue, szXMLUTF8) == 0)
            {
               pCHAR p = this->pXML; // use class member, not argument value.
               BYTE ch;
               for (; p < pEnd; p++)
               {
                  switch(trailbytesForUTF8[(BYTE)*p])
                  {
                  case 0: // Illegal sequence.
                     goto NotUTF8;

                  default:
                  case 1: // 1 byte sequence
                     continue;

                  case 2: // 2 byte sequence
                     // 2nd byte is (80 - BF)
                     break;

                  case 3: // 3 byte sequence (U+0800 .. U+0FFF)
                     ch = *(++p);
                     // 2nd byte is (A0 - BF)
                     if ((ch < 0xA0) || (ch > 0xBF))
                        goto NotUTF8;
                     // 3rd byte is (80 - BF)
                     break;

                  case 4:
                     ch = *(++p);
                     // 2nd byte is (80 - BF)
                     if ((ch < 0x80) || (ch > 0xBF))
                        goto NotUTF8;
                     // 3rd byte is (80 - BF)
                     break;
                  }
                  ch = *(++p);
                  if ((ch < 0x80) || (ch > 0xBF))
                     goto NotUTF8;
               }
            NotUTF8:
               if (p == pEnd)
                  bUTF8 = TRUE; // Yes. This XML is wriiten  UTF-8 system.
            }
         }
      }
   }

   *pErr = 0;
   return pCurPos;
}

// And current char, if no whitespaces
CHAR DSXML_Parse::NextChar(BOOL bInc)
{
   CHAR ch;

   if (bInc)
      pCurPos++;
   ch = *pCurPos;
   while (ch > 0 && (BYTE)ch <= ' ' && pCurPos < pEnd)
   { // Ignore whitespaces
      pCurPos++;
      ch = *pCurPos;
   }
   return ch;
}

// Returns position of last char in name, so NextChar can be used
pCHAR DSXML_Parse::GetName(pCHAR *ppName, pUINT32 piLen, pCHAR *pAttr)
{
   UINT32 iLen = 0;
   CHAR ch = NextChar(FALSE); // Remove preceeding whitespaces

   *ppName = pCurPos;
   while ((BYTE)ch >' ' && ch != '>' && ch != '/')
   {
      iLen++;
      if (pCurPos < pEnd)
      { // Ignore whitespaces
         pCurPos++;
         ch = *pCurPos;
      }
      else
         ch = 0;
   }
   if (ch == ' ')
   {
      *pAttr = pCurPos;
      while ( /* ch != '/' && */ ch != '>' && ch != 0)
      {
         ch = NextChar(TRUE);
         if (ch == '/' && LookAhead() == '>')
            break;
      }
   }
   else
      *pAttr = NULL;
   *piLen = iLen;
   return pCurPos;
}

pCHAR DSXML_Parse::GetValue(pCHAR *ppValue, pUINT32 piLen)
{
   UINT32 iLen = 0;
   CHAR ch = NextChar(FALSE); // Remove preceeding whitespaces

   *ppValue = pCurPos;
   while ((BYTE)ch >0 && ch != '<') // can contain spaces
   {
      iLen++;
      MoveAhead();
      ch = (CHAR)(CurChar());
   }
   *piLen = iLen;
   return pCurPos;
}

// Returns
DBIResult DSXML_Parse::IsTag(XMLTagType *pTagType)
{
   pCHAR pPos = pCurPos;
   CHAR ch = NextChar(FALSE);

   if (ch == '<')
   {
      ch = NextChar(TRUE);
      if (ch == '/')
         *pTagType = Tag_End;
      else
         *pTagType = Tag_Begin;
   }
   else
      *pTagType = Tag_Leaf;
   pCurPos = pPos; // Reset;
   if (ch == 0)
      return SetError(DBIERR_EOF);
   return DBIERR_NONE;
}

DBIResult DSXML_Parse::ReadValue(pCCHAR pTagNameExpected, pCHAR *ppValue, pUINT32 piLen, pBOOL pbBlank)
{
   DBIResult rslt = DBIERR_NONE;
   XMLTag pTag;

   rslt = NextTag(&pTag);
   if (rslt)
      goto Exit;
   if ((pTag.iTagType == Tag_Leaf || pTag.iTagType == Tag_Empty) && (pTagNameExpected == NULL || ByteComp
         (pTag.pTagName, pTagNameExpected, pTag.iTagNameLen) == 0))
   {
      if (pbBlank)
         *pbBlank = pTag.bBlank;
      if (ppValue)
         *ppValue = pTag.pValue;
      if (piLen)
         *piLen = pTag.iValueLen;
   }
   else
   {
      // or we could treat it as a NULL
      rslt = SetError(DBIERR_DATAPACKETMISMATCH);
   }
Exit:
   return rslt;
}

DBIResult DSXML_Parse::ReadBeginTag(pCHAR *ppTagName, pUINT32 piLen) // Expect a begintag;
{
   DBIResult rslt;
   XMLTag pTag;

   rslt = NextTag(&pTag);
   if (ppTagName)
      *ppTagName = pTag.pTagName;
   if (piLen)
      *piLen = pTag.iTagNameLen;
   if (!rslt)
   {
      if (pTag.iTagType != Tag_Begin)
         rslt = SetError(DBIERR_DATAPACKETMISMATCH);
   }
   return rslt;
}

DBIResult DSXML_Parse::ReadEndTag(VOID)
{
   DBIResult rslt;
   XMLTag pTag;

   rslt = NextTag(&pTag);
   if (!rslt)
   {
      if (pTag.iTagType != Tag_End)
         rslt = SetError(DBIERR_DATAPACKETMISMATCH);
   }
   return rslt;
}

// If leaf, reads value and end-tag as well
DBIResult DSXML_Parse::NextTag(XMLTag *pTag)
{
   DBIResult rslt = DBIERR_NONE;
   CHAR ch;

StartAgain:
   ch = NextChar(FALSE);
   switch(ch)
   {
   case '<':
      ch = NextChar(TRUE);

      if (ch == '/')
      {
         pTag->iTagType = Tag_End;
         MoveAhead();
      }
      else if (ch == '?')
      { // PI- skip it   <?     ?>
      LoopPI:
         while ((ch = NextChar(TRUE)) != '?' && ch != 0);
         if (ch != 0)
         {
            if ((ch = NextChar(TRUE)) != '>')
               goto LoopPI;
            MoveAhead();
            goto StartAgain;
         }
      }
      else if (ch == '!')
      { // Comment-skip it    <!    -->
      LoopComment:
         while ((ch = NextChar(TRUE)) != '-' && ch != 0);
         if (ch != 0)
         {
            if ((ch = NextChar(TRUE)) != '-')
               goto LoopComment;

            if ((ch = NextChar(TRUE)) != '>')
               goto LoopComment;
            MoveAhead();
            goto StartAgain;
         }
      }
      else
      {
         pTag->iTagType = Tag_Begin;
      }
      break;
   }

   pCurPos = GetName(&pTag->pTagName, &pTag->iTagNameLen, &pTag->pAttr);

   pTag->iType = 0;
   if (pTag->pAttr)
   { // Check if type
      CHAR AttrName[DBIMAXNAMELEN+1];
      pCHAR pAttr = pTag->pAttr;
      while (pAttr)
      {
         pCHAR pAttrPrev = pAttr;
         pAttr = ReadAttribute(pAttr, AttrName, NULL, NULL);
         if (stricmp(AttrName, szXMLTYPEBEG) == 0)
         { // Whatch out for blobs
            CHAR Value[DBIMAXNAMELEN+1];
            ReadAttribute(pAttrPrev, AttrName, NULL, NULL);
            pTag->iType = DsMakeType(Value);
            break;
         }
      }
   }

   ch = NextChar(FALSE);

   // Special empty tag
   if (ch == '/' && pTag->iTagType == Tag_Begin)
   {
      pTag->iTagType = Tag_Leaf;
      pTag->bBlank = TRUE;
      pTag->iValueLen = 0;
      rslt = Push(pTag->iTagNameLen, pTag->pTagName);
      if (rslt)
         goto Exit;
      ch = NextChar(TRUE);
   }
   if (ch == '>')
   {
      MoveAhead();
   }
   else
   {
      // Attribute
      rslt = SetError(DBIERR_DATAPACKETMISMATCH);
      goto Exit;
   }

   if (pTag->iTagType == Tag_Begin)
   {
      XMLTagType iTagType;
      // Could be new begintag, value or emptytag (blank value)
      IsTag(&iTagType); // LookAhead
      if (iTagType == Tag_Begin)
      {
         rslt = Push(pTag->iTagNameLen, pTag->pTagName);
         if (rslt)
            goto Exit;
      }
      else
      { // Value or EndTag, indicating empty value
         XMLTag pNextTag;

         pTag->iTagType = Tag_Leaf; // End or leaf
         pTag->bBlank = TRUE;
         pTag->iValueLen = 0;
         if (iTagType == Tag_Leaf) // Value
         {
            pCurPos = GetValue(&pTag->pValue, &pTag->iValueLen);
            if (pTag->iValueLen)
               pTag->bBlank = FALSE;
         }

         IsTag(&iTagType);
         if (iTagType != Tag_End)
         {
            rslt = SetError(DBIERR_DATAPACKETMISMATCH);
            goto Exit;
         }

         rslt = Push(pTag->iTagNameLen, pTag->pTagName);
         if (rslt)
            goto Exit;
         rslt = NextTag(&pNextTag);
         if (rslt)
            goto Exit;
         // CHECK integrity
         if (pNextTag.iTagNameLen != pTag->iTagNameLen || ByteComp(pNextTag.pTagName, pTag->pTagName,
               pNextTag.iTagNameLen) != 0)
         {
            rslt = SetError(DBIERR_DATAPACKETMISMATCH);
            goto Exit;
         }
      }
   }
   else
   { // EndTag
      rslt = Pop(pTag->iTagNameLen, pTag->pTagName);
      if (rslt)
         goto Exit;
   }
   CopyMem((pBYTE) &pCurTag, (pBYTE)pTag, sizeof(XMLTag));
Exit:
   return rslt;
}

DBIResult DSXML_Parse::Push(UINT32 iLen, pCHAR pName)
{
   if (iStackPos >= iStackSize-1)
      return SetError(DBIERR_DATAPACKETMISMATCH);
   iStackPos++;
   pStack[iStackPos].pTagName = pName;
   pStack[iStackPos].iTagLen = iLen;
   return DBIERR_NONE;
}

DBIResult DSXML_Parse::Pop(UINT32 iLen, pCHAR pName)
{
   if (iStackPos == 0)
      return SetError(DBIERR_DATAPACKETMISMATCH);

   if (pStack[iStackPos].iTagLen != iLen)
      return SetError(DBIERR_DATAPACKETMISMATCH);
   if (ByteComp(pStack[iStackPos].pTagName, pName, pStack[iStackPos].iTagLen) !=0)
   { // Unstacking with different tag
      // Should check if it is just a caseinsensitive issue!
      return SetError(DBIERR_DATAPACKETMISMATCH);
   }
   iStackPos--;
   return DBIERR_NONE;
}

VOID DSXML_Parse::StorePos(VOID)
{
   pCurPosSave = pCurPos;
   iStackPosSave = iStackPos;
}

VOID DSXML_Parse::RestorePos(VOID)
{
   pCurPos = pCurPosSave;
   iStackPos = iStackPosSave;
}

pCHAR DSXML_Parse::ReadAttribute(pCHAR pAttr, pCHAR pName, pCHAR pValue, pUINT32 piLen)
{
   CHAR ch;
   UINT32 iLen = 1;

   if (pAttr == NULL)
      return NULL;

   ch = *pAttr;
   while ((BYTE)ch >=' ' && ch != '>' && ch != '=')
   {
      if (ch != ' ')
         *pName++ = ch;
      ch = *(++pAttr);
   }
   *pName = 0; // Zeroterminate;
   if (pValue)
      *pValue = 0;

   if (ch != '=') // Expected
      return NULL;

   if ((ch = *(++pAttr)) != '"')
      return NULL;

   ch = *(++pAttr);
   while ( /* ch >=' ' && ch != '>' && */ ch != '"')
   {
      // convert back special characters!
      iLen++;
      if (pValue)
         *pValue++ = ch;
      ch = *(++pAttr);
   }
   if (ch == '"')
      pAttr++;
   if (pValue)
      *pValue = 0;
   if (piLen)
      *piLen = iLen;
   return pAttr;
}

// NOT in use ?
DBIResult DSXML_Parse::ReadFindAttribute(pCHAR pAttr, pCHAR pAttrToFind, pCHAR pValue)
{
   DBIResult rslt = DBIERR_NONE;
   CHAR AttrName[DBIMAXNAMELEN+1];

   while (pAttr)
   {
      pAttr = ReadAttribute(pAttr, AttrName, pValue, NULL);
      if (stricmp(pAttrToFind, AttrName) == 0)
      {
         goto Exit;
      }
   }
   rslt = SetError(DBIERR_NA);
Exit:
   return rslt;
}

Attr_List::Attr_List(class DSXML_W *pDsXML)
{
   Init(0, sizeof(Attr_Entry), 16);
   iPos = 0;
   this->pDsXml = pDsXML;
}

Attr_List::~Attr_List()
{
}

VOID DBIFN Attr_List::Reset(VOID)
{
   VARList::Reset();
   iPos = 0;
}

Flds_List::Flds_List(UINT32 iCols)
{
   Init(iCols, sizeof(DSDATAPACKETFLDDescX), 10);
}

Flds_List::~Flds_List()
{
}

UINT32 DBIFN Flds_List::Columns(VOID)
{
   return iLast;
}

// 1-based !
pDSDATAPACKETFLDDescX DBIFN Flds_List::GetFldDesc(UINT32 i)
{
   return(pDSDATAPACKETFLDDescX)GetEntry(i);
}

DBIResult DBIFN Attr_List::Parse(pCHAR pAttr)
{
   DBIResult rslt = DBIERR_NONE;
   pCHAR pName, pVal;
   UINT32 iValLen, iNameLen;
   Attr_Entry Entry;

   Reset();

   while (pAttr != NULL)
   {
      ZeroMem((pBYTE) &Entry, sizeof(Attr_Entry));

      pAttr = ParseAttributes(pAttr, NULL, &pName, &iNameLen, &pVal, &iValLen);
      if (pAttr == NULL)
         break;
      Entry.pAttrName = pName;
      Entry.iAttrNameLen = iNameLen;
      Entry.pValue = pVal;
      Entry.iValueLen = iValLen;
      Add((pBYTE) &Entry, NULL);
   }
   return rslt;
}

pAttr_Entry DBIFN Attr_List::Find(pCCHAR pAttrName, UINT32 iHint)
{
   UINT32 i;
   pAttr_Entry pEntry;

   if (iHint >= iLast)
      iHint = 0;
   for (i = iHint; i< iLast; i++)
   {
      pEntry = (pAttr_Entry)GetEntry(i+1);
      if (memcmp(pEntry->pAttrName, pAttrName, pEntry->iAttrNameLen) == 0 && strlen(pAttrName) == pEntry->iAttrNameLen)
      {
         pEntry->iId = i+1;
         return pEntry;
      }
   }
   for (i = 0; i< iHint; i++)
   {
      pEntry = (pAttr_Entry)GetEntry(i+1);
      if (memcmp(pEntry->pAttrName, pAttrName, pEntry->iAttrNameLen) == 0 && strlen(pAttrName) == pEntry->iAttrNameLen)
      {
         pEntry->iId = i+1;
         return pEntry;
      }
   }
   return NULL;
}

VOID Attr_List::SetVisited(UINT32 iId)
{
   pAttr_Entry pEntry = (pAttr_Entry)GetEntry(iId);
   if (pEntry)
      pEntry->bVisited = TRUE;
}

UINT32 DBIFN Attr_List::Next(VOID) // returns ID of next
{
   pAttr_Entry pEntry;
   while ((pEntry = (pAttr_Entry)GetEntry(iPos+1)) != NULL)
   {
      iPos++;
      if (!pEntry->bVisited)
         return iPos;
   }
   return 0;
}

pCHAR ParseAttributes(pCHAR pAttr, pCHAR pEnd, pCHAR *ppName, pUINT32 piNameLen, pCHAR *ppValue, pUINT32 piValueLen)
{
   CHAR ch;
   UINT32 iNameLen = 0;
   UINT32 iValueLen = 0;
   pCHAR pPtr;

   UNREFERENCED_PARAMETER(pEnd);
   if (pAttr == NULL)
      return NULL;

   // How to check for end of file?
   ch = *pAttr;
   while ((BYTE)ch<= ' ') // Read whitespace
      ch = *(++pAttr);
   *ppName = pAttr;
   while ( /* ch >' ' && */ ch != '>' && ch != '=')
   {
      iNameLen++;
      ch = *(++pAttr);
   }
   // Trim spaces at end of name
   pPtr = pAttr;
   while ((BYTE) *(--pPtr)<= ' '&& iNameLen>0) // Read whitespace
      iNameLen--;

   if (ch != '=') // Must be '='
   {
      pAttr = NULL;
      goto Exit; // Err
   }
   ch = *(++pAttr);

   while ((BYTE)ch <= ' ') // Read whitespace
      ch = *(++pAttr);

   if (ch != '"')
   {
      pAttr = NULL;
      goto Exit; // Err
   }
   ch = *(++pAttr); // Read value
   *ppValue = pAttr;
   while (ch != '"')
   {
      iValueLen++;
      ch = *(++pAttr);
   }
   pAttr++;

Exit:
   *piNameLen = iNameLen;
   *piValueLen = iValueLen;
   return pAttr;
}
