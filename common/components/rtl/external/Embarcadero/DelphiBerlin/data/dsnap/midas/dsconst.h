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

#ifndef DSCONST_H
#define DSCONST_H

#define CANSIZE               8192

#define szUNIQUE_KEY          "UNIQUE_KEY"
#define szDEFAULT_ORDER       "DEFAULT_ORDER"
#define szCHANGE_LOG          "CHANGE_LOG"
#define szSERVER_COL          "SERVER_COL"
#define szCONSTRAINTS         "CONSTRAINTS"
#define szDATASET_CONTEXT     "DATASET_CONTEXT"
#define szDATASET_DELTA       "DATASET_DELTA"
#define szREADONLY            "READONLY"
#define szSUBTYPE             "SUBTYPE"
#define szDECIMALS            "DECIMALS"
#define szWIDTH               "WIDTH"
#define szLCID                "LCID"
#define szBDEDOMX             "BDEDOMAIN_X"
#define szBDERECX             "BDERECORD_X"
#define szBDEDEFX             "BDEDEFAULT_X"
#define szAUTOINCVALUE        "AUTOINCVALUE"
#define szELEMENTS            "ELEMENTS"
#define szTABLENAME           "TABLENAME"
#define szMD_FIELDLINKS       "MD_FIELDLINKS"
#define szTYPENAME            "TYPENAME"
#define szUPDATEMODE          "UPDATEMODE"
#define szMD_SEMANTICS        "MD_SEMANTICS"
#define szCALCULATED          "CALCULATED"
#define szFIELDNAME           "FIELDNAME"

#define szBDEDOMCL            "BDEDOMAIN_CL"
#define szBDERECCL            "BDERECORD_CL"
#define szBDEDEFCL            "BDEDEFAULT_CL"

#define szPRIMARY_KEY         "PRIMARY_KEY"
#define szMINVALUE            "MINVALUE"
#define szMAXVALUE            "MAXVALUE"
#define szDEFVALUE            "DEFVALUE"

#define szDISABLE_DELETES     "DISABLE_DELETES"
#define szDISABLE_INSERTS     "DISABLE_INSERTS"
#define szDISABLE_EDITS       "DISABLE_EDITS"

#define szstMEMO              "Text"
#define szstBINARY            "Binary"
#define szstFMTMEMO           "Formatted"
#define szstOLEOBJ            "Ole"
#define szstGRAPHIC           "Graphics"
#define szstDBSOLEOBJ         "dBASEOle"
#define szstTYPEDBINARY       "TypedBinary"
#define szstMONEY             "Money"
#define szstAUTOINC           "Autoinc"
#define szstACCOLEOBJ         "AccessOle"
#define szstHMEMO             "HMemo"
#define szstHBINARY           "HBinary"
#define szstADTNestedTable    "ADTNestedTable"
#define szstFIXEDCHAR         "FixedChar"
#define szstREFNestedTable    "Reference"
#define szstBFILE             "BFile"
#define szstADTDATE           "ADTDate"
#define szstGUID              "Guid"
#define szstWideMEMO          "WideText"

// Corresponds to char array below (don't change order)
typedef enum
{
     PreUNKNOWN         = 0,
     PreUNIQUE_KEY      = 1,
     PreDEFAULT_ORDER   = 2,
     PreCHANGE_LOG      = 3,
     PreSERVER_COL      = 4,
     PreCONSTRAINTS     = 5,
     PreDATASET_CONTEXT = 6,
     PreDATASET_DELTA   = 7,
     PreREADONLY        = 8,
     PreSUBTYPE         = 9,
     PreDECIMALS        = 10,
     PreWIDTH           = 11,
     PreLCID            = 12,
     PreBDEDOMAIN_X     = 13,
     PreBDERECORD_X     = 14,
     PreBDEDEFAULT_X    = 15,
     PreAUTOINCVALUE    = 16,
     PreELEMENTS        = 17,
     PreTABLENAME       = 18,
     PreMD_FIELDLINKS   = 19,
     PreTYPENAME        = 20,
     PreUPDATEMODE      = 21,
     PreMD_SEMANTICS    = 22,
     PreCALCULATED      = 23,
     PreBDEDOMAIN_CL    = 24,
     PreBDERECORD_CL    = 25,
     PreBDEDEFAULT_CL   = 26,
     PreDELTA           = 27,
     PrePRIMARY_KEY     = 28,
     PreMINVALUE        = 29,
     PreMAXVALUE        = 30,
     PreDISABLE_DELETES = 31,
     PreDISABLE_INSERTS = 32,
     PreDISABLE_EDITS   = 33,
     PreFIELDNAME       = 34
} ePREDEF;

#define MAXPREDEF  34

// hidden field names
#define  szATTR_FIELD         "ATTR_FIELD"       // row status field.

// Error dataset field names.
#define  szdsERRRECORDNO      "ERROR_RECORDNO"   // rec no.of failed rec.
#define  szdsERRRESPONSE      "ERROR_RESPONSE"   // action taken.
#define  szdsERRMESSAGE       "ERROR_MESSAGE"    // cause of failure.
#define  szdsERRCONTEXT       "ERROR_CONTEXT"    // error context.
#define  szdsERRCATEGORY      "ERROR_CATEGORY"   // category of the error.
#define  szdsERRCODE          "ERROR_CODE"       // native err code.

#define ERRORPACKETExtraFields  6

#ifdef MIDAS_DLL
#define szALCHEMYDLL          "midas.dll"
#else
#define szALCHEMYDLL          "dbclient.dll"
#endif

#define szDELTA               "_DELTA"

// Converts between integer and string, or string and integer
typedef struct
{
  CHAR      szStr[31];
  UINT32    iValue;
} DSCONV;
typedef DSCONV *pDSCONV;

#define MAXSUBTYPES 20

DBIResult StrToSubType(pCHAR pszStr, pUINT32 piSubType);
DBIResult SubTypeToStr(UINT32 iSubType, ppCHAR ppszStr);
INT32 OptStrToNumber(pCCHAR pszPredef);

#endif
