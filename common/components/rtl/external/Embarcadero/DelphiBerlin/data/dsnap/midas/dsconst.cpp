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

#include "dsconst.h"

DSCONV pPredef[MAXPREDEF+1] =
{
        {szUNIQUE_KEY      , PreUNIQUE_KEY}     , //  1
        {szDEFAULT_ORDER   , PreDEFAULT_ORDER}  , //  2
        {szCHANGE_LOG      , PreCHANGE_LOG}     , //  3
        {szSERVER_COL      , PreSERVER_COL}     , //  4
        {szCONSTRAINTS     , PreCONSTRAINTS}    , //  5
        {szDATASET_CONTEXT , PreDATASET_CONTEXT}, //  6
        {szDATASET_DELTA   , PreDATASET_DELTA}  , //  7
        {szREADONLY        , PreREADONLY}       , //  8
        {szSUBTYPE         , PreSUBTYPE}        , //  9
        {szDECIMALS        , PreDECIMALS}       , // 10
        {szWIDTH           , PreWIDTH}          , // 11
        {szLCID            , PreLCID}           , // 12
        {szBDEDOMX         , PreBDEDOMAIN_X}    , // 13
        {szBDERECX         , PreBDERECORD_X}    , // 14
        {szBDEDEFX         , PreBDEDEFAULT_X}   , // 15
        {szAUTOINCVALUE    , PreAUTOINCVALUE}   , // 16
        {szELEMENTS        , PreELEMENTS}       , // 17
        {szTABLENAME       , PreTABLENAME}      , // 18
        {szMD_FIELDLINKS   , PreMD_FIELDLINKS}  , // 19
        {szTYPENAME        , PreTYPENAME}       , // 20
        {szUPDATEMODE      , PreUPDATEMODE}     , // 21
        {szMD_SEMANTICS    , PreMD_SEMANTICS}   , // 22
        {szCALCULATED      , PreCALCULATED  }   , // 23
        {szBDEDOMCL        , PreBDEDOMAIN_CL}   , // 24
        {szBDERECCL        , PreBDERECORD_CL}   , // 25
        {szBDEDEFCL        , PreBDEDEFAULT_CL}  , // 26
        {"DELTA"           , PreDELTA}          , // 27  for xml-case
        {szPRIMARY_KEY     , PrePRIMARY_KEY}    , // 28
        {szMINVALUE        , PreMINVALUE}       , // 29
        {szMAXVALUE        , PreMAXVALUE}       , // 30
        {szDISABLE_DELETES , PreDISABLE_DELETES}, // 31
        {szDISABLE_INSERTS , PreDISABLE_INSERTS}, // 32
        {szDISABLE_EDITS   , PreDISABLE_EDITS}  , // 33
        {szFIELDNAME       , PreFIELDNAME}      , // 34
        {""                , PreUNKNOWN}        , //  0
};

DSCONV SubTypes[MAXSUBTYPES] =
{
        {szstMEMO        , fldstMEMO}       ,
        {szstBINARY      , fldstBINARY}     ,
        {szstFMTMEMO     , fldstFMTMEMO}    ,
        {szstOLEOBJ      , fldstOLEOBJ}     ,
        {szstGRAPHIC     , fldstGRAPHIC}    ,
        {szstDBSOLEOBJ   , fldstDBSOLEOBJ}  ,
        {szstTYPEDBINARY , fldstTYPEDBINARY},
        {szstMONEY       , fldstMONEY}      ,
        {szstAUTOINC     , fldstAUTOINC}    ,
        {szstACCOLEOBJ   , fldstACCOLEOBJ}  ,
        {szstHMEMO       , fldstHMEMO}      ,
        {szstHBINARY     , fldstHBINARY}    ,
        {szstADTNestedTable , fldstADTNestedTable} ,
        {szstFIXEDCHAR   , fldstFIXED}      ,
        {szstREFNestedTable, fldstREFNestedTable } ,
        {szstBFILE       , fldstBFILE}      ,
        {szstADTDATE     , fldstADTDATE}    ,
        {szstGUID        , fldstGUID}       ,
        {szstWideMEMO    , fldstWIDEMEMO}   ,
        {"", fldstUNKNOWN}
};

// return index of string (0..n) , -1 if not found
INT32 OptStrToNumber(pCCHAR pszPredef)
{
   UINT32 i;
   pDSCONV pConv;

   for (i = 0; i < sizeof(pPredef)/sizeof(DSCONV); i++)
   {
      pConv = &pPredef[i];
      if (*pConv->szStr == 0)
         break;
      if (stricmp(pszPredef, pConv->szStr) == 0)
         return pConv->iValue;
   }
   return -1;
}

// Returns string of given subtype
DBIResult SubTypeToStr(UINT32 iSubType, ppCHAR ppszStr)
{
   UINT32 i;
   pDSCONV pConv;

   for (i = 0; i < MAXSUBTYPES; i++)
   {
      pConv = &SubTypes[i];
      if (pConv->iValue == 0)
         goto Exit;
      if (pConv->iValue == iSubType)
      {
         *ppszStr = pConv->szStr;
         return DBIERR_NONE;
      }
   }
Exit:
   *ppszStr = NULL;
   return DBIERR_OBJNOTFOUND;
}

// Returns subtype of given string, if any
DBIResult StrToSubType(pCHAR pszStr, pUINT32 piSubType)
{
   UINT32 i;
   pDSCONV pConv;

   for (i = 0; i < MAXSUBTYPES; i++)
   {
      pConv = &SubTypes[i];
      if (*pConv->szStr == 0)
         break;
      if (stricmp(pszStr, pConv->szStr) == 0)
      {
         *piSubType = pConv->iValue;
         return DBIERR_NONE;
      }
   }
   *piSubType = fldstUNKNOWN;
   return DBIERR_OBJNOTFOUND;
}

