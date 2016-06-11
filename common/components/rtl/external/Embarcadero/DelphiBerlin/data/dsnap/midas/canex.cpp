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
#include <string.h>
#if !defined(__ANDROID__)
#include <iconv.h>
#endif
#include "conv.h"
#else
#include <windows.h>
#endif

#if _MSC_VER
typedef __int64 int64_t;
#else
#include <stdint.h>
#endif

#pragma hdrstop

#ifndef _UNIX
#define min(__a,__b)    (((__a) < (__b)) ? (__a) : (__b))
#endif

#include "float.h"
#include "bdetypes.h"
#include "canex.h"
#include "ossrv.h"
#include "match.h"
#include "filter.h"
#include "alctypes.h"
#include "alchemy.h"
#include "alc_ds.h"
#include "srvbcd.h"

pUCS2Char UTF8ToWideChar(pCCHAR Input);

#define StrCpy(d, s)    LdStrCpy(d, s)
#define StrCmp(f1, f2)  LdStrCmp(f1, f2)
#define StrCmpI(f1, f2) LdStrCmpi(f1, f2)
#define StrLen(s)       LdStrLen(s)
#define StrCat(s1, s2)  LdStrCat(s1, s2)


#define LangStrCmp(lcid, s1, s2)  LCStrCmp(lcid, (pCHAR) s1, (pCHAR) s2)
#define LangStrCmpi(lcid, s1, s2) LCStrCmpi(lcid, (pCHAR) s1, (pCHAR) s2)

#define ToUpper(ch)     LdToUpper((pCHAR) ((LONGP) ch))
#define ToLower(ch)     LdToLower((pCHAR) ((LONGP) ch))

#define QLITE_DLL TRUE

#define ThrowError(rslt)         longjmp( &JmpBuf, rslt )

#define  ISNULLVALUE( p )        ( *(BYTE*)p != 0 )
#define  SETNULLVALUE( p, val )  ( *(BYTE*)(p) = val )
#define  NULLINDLEN  sizeof(BYTE)

#define OP_ARG1        ( (*pElem->ppRecReg1) + pElem->iArg1Off )
#define OP_ARG2        ( (*pElem->ppRecReg2) + pElem->iArg2Off )
#define OP_ARG3        ( (*pElem->ppRecReg3) + pElem->iArg3Off )
#define OP_RES         ( (*pElem->ppRecRegRes) + pElem->iResOff )
#define OP_RES_NULL    ( (*pElem->ppRecRegRes) + pElem->iResNullOff )
#define OP_REG1        (*pElem->ppRecReg1)
#define OP_REG2        (*pElem->ppRecReg2)
#define OP_REGRES      (*pElem->ppRecRegRes)
#define OP_ARG1_NULL   ( (*pElem->ppRecReg1) + pElem->iArg1NullOff )
#define OP_ARG2_NULL   ( (*pElem->ppRecReg2) + pElem->iArg2NullOff )
#define OP_ARG3_NULL   ( (*pElem->ppRecReg3) + pElem->iArg3NullOff )
#define OP_AGG_NULLCNT ((*pElem->ppRecRegRes) + pElem->iResNullOff + NULLINDLEN )


#if 0
static ULONGP pDbg = 0;
static size_t iDbg = 0;
static void * _RTLENTRY _EXPFUNC32 operator new (
   size_t type_size
)
{
   void * ret;
   ret =  DsCalloc(type_size, 1);
   if( (ULONGP)ret == pDbg )
      asm int 3;
   if( type_size == iDbg )
      asm int 3;

   return ret;
}

static void   _RTLENTRY _EXPFUNC32 operator delete (
   void * type_ptr 
)
{
   DsFree( type_ptr );
}
#endif

EC DBIResult DBIFN QCompileCanFilter (
   FLTArgType   eArgType,
   pBYTE        pArg,
   pUINT16      piFldNum,
   pULONGP      pHndl,
   pBOOL        pbReq,
   pVOID        pDs
)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32    iTotalExtraLen = 0;
   pQCanFilter pI = new QCanFilter();


   if( !pI )
   {
      rslt = DBIERR_NOMEMORY;
      goto Exit;
   }
   *pHndl = reinterpret_cast<ULONGP>(pI);

   pI->pDS =  (pDSBASE)pDs;
   pI->lcid = pI->pDS->iLCID;

   if( pbReq )
     *pbReq  = FALSE;

   if( eArgType == fltSQLEX_CONSTRAINT || eArgType == fltSQLEX_DEFAULT )
   {
      pSQLExprInfo pExInfo = (pSQLExprInfo) pArg;

      if( pExInfo->iErrStrLen )
         lstrcpyn((pCHAR) pI->szErrorMsg, (pCHAR)(pArg + sizeof(SQLExprInfo)),
                  DBIMAXMSGLEN);
      else
         pI->szErrorMsg[0] = '\0';
      iTotalExtraLen = pExInfo->iErrStrLen + sizeof(SQLExprInfo);
      pI->iFldNum = pExInfo->iFldNum;

      if( pExInfo->bReqExpr && pbReq )
         *pbReq = TRUE;
   }
   else
   {
      pI->szErrorMsg[0] = '\0';
      pI->iFldNum = 0;
   }
   rslt = pI->Compile( (pCANExpr)(pArg + iTotalExtraLen));
   if( piFldNum )
      *piFldNum = (UINT16) pI->iFldNum;

Exit:
   if( rslt != DBIERR_NONE )
   {
       if( pI != NULL )
         delete pI;
      *pHndl = 0;
   }
   return rslt;
}
EC VOID DBIFN QFetchErrStr (
   ULONGP  hndl,
   pCHAR   pszErrStr
)
{
   pQCanFilter pI = (pQCanFilter) hndl;
   LdStrCpy( pszErrStr, pI->szErrorMsg );
}

EC BOOL DBIFN QExecuteCanFilter (
   ULONGP  hndl,
   pBYTE   pRecBuf,
   pVOID   pDs
)
{
   pQCanFilter pI = (pQCanFilter) hndl;
   pI->pDS = (pDSBASE) pDs;
   if( pI )
      return pI->Execute(pRecBuf);
   else
      return FALSE;
}

EC DBIResult DBIFN  QFreeCanFilter (
   ULONGP  hndl
)
{
   pQCanExpr pI = (pQCanFilter) hndl;
   delete pI;
   return 0;
}

EC pBYTE DBIFN QFetchValue (
   ULONGP hndl
)
{
   pBYTE pRetVal = NULL;
   pQCanExpr pI = (pQCanFilter) hndl;
   if( pI )
   {
      pQCanExecElem pElemI, pElem;
      ForEachInSet( pI->pStream->pFieldExecElemSet, pElemI )
         pElem = pElemI;
      if ( pElem && pElem->ppRecRegRes )
      {
         if ( !(*(*pElem->ppRecRegRes + pElem->iResNullOff) != 0) )
           pRetVal = OP_RES;
      }
   }
   return pRetVal;
}

////////////////////////////////////////////////////////////////////////////////

typedef struct {
   UINT16  iArgType;
   UINT16  iRetType;
} UnOpsArgs, *pUnOpsArgs;

typedef struct {
   UINT16  iLeftType;
   UINT16  iRightType;
   UINT16  iRetType;
} BinOpsArgs, *pBinOpsArgs;

typedef struct {
   UINT16  iArg1;
   UINT16  iArg2;
   UINT16  iArg3;
   UINT16  iRetType;
} TernOpsArgs, *pTernOpsArgs;


// TODO: value 0 is overloaded to mean both
// . "any type" in left||right arg
// .. "end of list" in return type

#define NUMERIC_ARITH_ARGS \
   { 5, 5, 5 },\
   { 6, 6, 6 },\
   { 7, 7, 7 },\
   { 8, 8, 8 },\
   { 18, 18, 18}, \
   { 27, 27, 27}, \
   { 0, 0, 0 }

#define COMP_ARGS  \
   { 1, 1, 4 }, \
   { 2, 2, 4 }, \
   { 4, 4, 4 }, \
   { 5, 5, 4 }, \
   { 6, 6, 4 }, \
   { 7, 7, 4 }, \
   { 8, 8, 4 }, \
   { 10, 10, 4}, \
   { 11, 11, 4}, \
   { 12, 12, 4}, \
   { 13, 13, 4}, \
   { 18, 18, 4}, \
   { 19, 19, 4}, \
   { 24, 24, 4}, \
   { 27, 27, 4}, \
   { 28, 28, 4}, \
   { 29, 29, 4}, \
   { 36, 36, 4}, \
   { 0, 0, 0 }

#define ASSIGN_ARGS  \
   { 1, 1, 1 }, \
   { 2, 2, 2 }, \
   { 1, 4, 4 }, \
   { 4, 4, 4 }, \
   { 5, 5, 5 }, \
   { 6, 6, 6 }, \
   { 7, 7, 7 }, \
   { 8,  8,  8 }, \
   { 10, 10, 10}, \
   { 11, 11, 11}, \
   { 7,  8,  8 }, \
   { 7,  5,  7 }, \
   { 7,  6,  7 }, \
   { 24,  24,  24 }, \
   { 0, 0, 0 }

#ifdef QLITE_DLL

BinOpsArgs qnodeAddOps[] = { { 1, 1, 1 },
                             //{ 2, 5, 2 },
                             //{ 2, 6, 2 },
                             { 2, 7, 2 },
                             //{ 11, 5, 11 },
                             //{ 11, 6, 11 },
                             { 10, 7, 10 },
                             { 11, 7, 11 },
                             { 7, 2, 2 },
                             { 7, 10, 10 },
                             { 7, 11, 11 },
                             { 7, 24, 24 },
                             { 24, 7, 24 },
                             { 36, 36, 36 },
                             NUMERIC_ARITH_ARGS };
                             // TODO: duration type

BinOpsArgs qnodeSubtractOps[] = { { 2, 5, 2 },
                             { 2, 6, 2 },
//                           { 2, 7, 2 },
                             { 2, 2, 7 },
                             { 11, 5, 11 },
                             { 11, 6, 11 },
                             { 11, 7, 11 },
                             { 11, 11, 7 },
                             { 10, 10, 6 },
                             { 2, 2, 7 },
                             { 24, 24, 7 },
                             { 24, 7, 24 },
                             { 24, 24, 7 },
                             { 24, 7, 24 },
                             { 24, 24, 6 },
                             { 24, 6, 24 },
                             { 24, 24, 5 },
                             { 24, 5, 24 },
                             { 36, 36, 36 },
                             NUMERIC_ARITH_ARGS
                           };
                             // TODO: duration type

BinOpsArgs qnodeMultiplyOps[] = { NUMERIC_ARITH_ARGS };
BinOpsArgs qnodeDivideOps[] = { NUMERIC_ARITH_ARGS };

BinOpsArgs qnodeAndOps[] = {  { 4,4,4 }, { 0, 0, 0} };
BinOpsArgs qnodeOrOps[] = {  { 4,4,4 }, { 0, 0, 0} };

BinOpsArgs qnodeGreaterOps[] = { COMP_ARGS };
BinOpsArgs qnodeGreaterEqOps[] = { COMP_ARGS };
BinOpsArgs qnodeLessOps[] = { COMP_ARGS };
BinOpsArgs qnodeLessEqOps[] = { COMP_ARGS };
BinOpsArgs qnodeEqualOps[] = { {4,1,4}, {1,4,4}, {9,9,4}, COMP_ARGS } ;
BinOpsArgs qnodeNotEqualOps[] = { {4,1,4}, {1,4,4}, {9,9,4}, COMP_ARGS };

BinOpsArgs qnodeTrim2Args[] = { { 1, 1, 1 }, { 0, 0, 0 } };

BinOpsArgs qnodeLikeOps[] = {  { 1, 1, 4 },
                               { 3, 1, 4 },
                               { 17, 1, 4 },
                               { 18, 1, 4 },
                               { 0, 0, 0} };

BinOpsArgs qnodeINOps[] = { COMP_ARGS };
BinOpsArgs qnodeANYOps[] = { COMP_ARGS };
BinOpsArgs qnodeALLOps[] = { COMP_ARGS };

BinOpsArgs qnodeAssignOps[] = {  ASSIGN_ARGS };

BinOpsArgs qnodeSubstringOps[] = {  { 1, 7, 1}, { 0,0,0} };
#if 0
BinOpsArgs qnodeExtractOps[] = {
                                  { 1, 7, 1},
                                  { 1, 7, 1},
                                  { 1, 7, 1},
                                  { 0,0,0}
                               };
#endif


TernOpsArgs qnodeSubstring3Ops[] = {  { 1, 7, 7, 1}, { 0,0,0,0} };

UnOpsArgs  qnodeNotOps[] = { {4, 4}, {0,0} };
UnOpsArgs  qnodeNegateOps[] = {  { 5, 5 }, { 6, 6} , { 7, 7}, {0,0} };

UnOpsArgs  qnodeCaseSwitchOps[] = {  { 1, 1 },  {0,0} };
UnOpsArgs  qnodeTrim1Ops[] = { {1, 1}, {0,0} };


#define   COUNT_ARGS \
   { 1, 6}, \
   { 2, 6}, \
   { 3, 6}, \
   { 4, 6}, \
   { 5, 6}, \
   { 6, 6}, \
   { 7, 6}, \
   { 8, 6}, \
   { 10, 6}, \
   { 11, 6}, \
   { 17, 6}, \
   { 18, 6}, \
   { 24, 6}, \
   { 0, 0 }

#define MINMAX_ARGS \
   { 1, 1 }, \
   { 2, 2 }, \
   { 5, 5 }, \
   { 6, 6 }, \
   { 7, 7 }, \
   { 8, 8 }, \
   { 10, 10 }, \
   { 11, 11 }, \
   { 24, 24 }, \
   { 0, 0 }


UnOpsArgs qnodeAvgOps[] =
      { { 2, 2 }, {5,7,}, {6,7,}, {7,7}, {8,7}, {11,11}, {0,0} };
UnOpsArgs qnodeTotalOps[] = { {5,7}, {6,7}, {7,7}, {8,7}, {0,0} };

UnOpsArgs qnodeCountOps[] = { COUNT_ARGS };
UnOpsArgs qnodeMaxOps[] =  { MINMAX_ARGS };
UnOpsArgs qnodeMinOps[] =  { MINMAX_ARGS };
UnOpsArgs qnodeIsNullOps[] = { { 0, 4 }, {0,0} };
UnOpsArgs qnodeExistsOps[] = { { 0, 4 }, {0,0} };


BinOpsArgs *BinOps[] =
{
  NULL,
  qnodeAddOps, //   qnodeAdd
  NULL, //   qnodeAvg
  NULL, //   qnodeCount
  NULL, //   qnodeMax
  NULL, //   qnodeMin
  NULL, //   qnodeTotal
  NULL, //   qnodeAlias
  qnodeAndOps, //   qnodeAnd
  NULL, //   qnodeConstant
  qnodeDivideOps, //   qnodeDivide
  qnodeEqualOps, //   qnodeEqual 
  NULL, //   qnodeField 
  qnodeGreaterEqOps, //   qnodeGreaterEq 
  qnodeGreaterOps, //   qnodeGreater 
  qnodeLessEqOps, //   qnodeLessEq 
  qnodeLikeOps, //   qnodeLike
  qnodeLessOps, //   qnodeLess 
  qnodeMultiplyOps, //   qnodeMultiply 
  qnodeNotEqualOps, //   qnodeNotEqual 
  NULL, //  qnodeNotOps, //   qnodeNot 
  qnodeOrOps, //   qnodeOr 
  qnodeSubtractOps, //   qnodeSubtract 
  NULL, //   qnodeColumn 
  NULL, //   qnodeCast 
  qnodeAssignOps, //   qnodeAssign
  NULL, // qnodeIsNullOps, //   qnodeIsNull
  NULL, //   qnodeExists
  NULL, //   qnodeVariable
  NULL, //   qnodeSelect
  NULL, // qnodeNegateOps, //   qnodeNegate
  NULL, //   qnodeUdf
  qnodeINOps, //   qnodeIN
  qnodeANYOps, //   qnodeANY
  qnodeALLOps, //   qnodeALL
  qnodeTrim2Args,  // qnodeTrim = 35,
  NULL, // qnodeLower = 36,
  NULL, // qnodeUpper = 37,
  qnodeSubstringOps,  // qnodeSubstring = 38
  NULL,            //  qnodeList = 39,
  NULL,      // qnodeExtract = 40
  NULL      // qnodeCorrVar
};

UnOpsArgs *UnOps[] =
{
  NULL, //   null
  NULL, //   qnodeAdd 
  qnodeAvgOps, //   qnodeAvg 
  qnodeCountOps, //   qnodeCount 
  qnodeMaxOps, //   qnodeMax 
  qnodeMinOps, //   qnodeMin 
  qnodeTotalOps, //   qnodeTotal 
  NULL, //   qnodeAlias 
  NULL, //   qnodeAnd 
  NULL, //   qnodeConstant 
  NULL, //   qnodeDivide 
  NULL, //   qnodeEqual 
  NULL, //   qnodeField 
  NULL, //   qnodeGreaterEq 
  NULL, //   qnodeGreater 
  NULL, //   qnodeLessEq 
  NULL, //   qnodeLike  
  NULL, //   qnodeLess 
  NULL, //   qnodeMultiply 
  NULL, //   qnodeNotEqual
  qnodeNotOps, //  NULL, //   qnodeNot 
  NULL, //   qnodeOr 
  NULL, //   qnodeSubtract 
  NULL, //   qnodeColumn 
  NULL, //   qnodeCast 
  NULL, //   qnodeAssign 
  qnodeIsNullOps, //   qnodeIsNull 
  qnodeExistsOps, //   qnodeExists 
  NULL, //   qnodeVariable 
  NULL, //   qnodeSelect  
  qnodeNegateOps, // NULL, //   qnodeNegate 
  NULL, //   qnodeUdf 
  NULL, //   qnodeIN 
  NULL, //   qnodeANY 
  NULL, //   qnodeALL 
  qnodeTrim1Ops,  // qnodeTrim = 35,
  qnodeCaseSwitchOps, // qnodeLower = 36,
  qnodeCaseSwitchOps, // qnodeUpper = 37,
  NULL                 // qnodeSubstring = 38
};


//  Classifies  operations into
// relation op ( =, >, < ... )
// aggs  (  sum, min .. )
// boolean  ( and, not, or )
// arithmetic  ( +, -, /, * )
OpType alOpType[] = {
  opNone,    //   null
  opArithOp, //   qnodeAdd 
  opAggOp,   //   qnodeAvg 
  opAggOp,   //   qnodeCount 
  opAggOp, //   qnodeMax 
  opAggOp, //   qnodeMin 
  opAggOp, //   qnodeTotal 
  opOther, //   qnodeAlias 
  opBoolOp, //   qnodeAnd 
  opNone,   //   qnodeConstant 
  opArithOp, //   qnodeDivide 
  opRelOp, //   qnodeEqual 
  opNone, //   qnodeField 
  opRelOp, //   qnodeGreaterEq 
  opRelOp, //   qnodeGreater 
  opRelOp, //   qnodeLessEq 
  opRelOp, //   qnodeLike  
  opRelOp, //   qnodeLess 
  opArithOp, //   qnodeMultiply 
  opRelOp, //   qnodeNotEqual 
  opBoolOp, //  NULL, //   qnodeNot 
  opBoolOp, //   qnodeOr 
  opArithOp, //   qnodeSubtract 
  opNone, //   qnodeColumn 
  opOther, //   qnodeCast 
  opOther, //   qnodeAssign 
  opOther, //   qnodeIsNull 
  opOther, //   qnodeExists 
  opNone, //   qnodeVariable 
  opOther, //   qnodeSelect  
  opArithOp, // NULL, //   qnodeNegate 
  opNone, //   qnodeUdf 
  opRelOp, //   qnodeIN 
  opRelOp, //   qnodeANY 
  opRelOp,  //   qnodeALL 
  opArithOp,  // qnodeTrim = 35,
  opArithOp, // qnodeLower = 36,
  opArithOp, // qnodeUpper = 37,
  opArithOp,  // qnodeSubstring = 38
  opNone,     //  qnodeList = 39,
  opNone,    //  qnodeExtract = 40,
  opNone,    //    qnodeCorrVar  = 41,
  opNone      // qnodeTrue  = 42
};

// Map IDAPI logical types into supertype classes:
//   numeric
//   character
//   datetime
//
TypeClass alTypeClass[] =
{
   clNone,       // fldUNKNOWN      0
   clChar,       // fldZSTRING      1                 // Null terminated string
   clTime,       // fldDATE         2                 // Date     (32 bit)
   clNone,       // fldBLOB         3                 // Blob
   clNone,       // fldBOOL         4                 // Boolean  (16 bit)
   clNumeric,    // fldINT16        5                 // 16 bit signed number
   clNumeric,    // fldINT32        6                 // 32 bit signed number
   clNumeric,    // fldFLOAT        7                 // 64 bit floating point
   clNumeric,    // fldBCD          8                 // BCD
   clNone,       // fldBYTES        9                 // Fixed number of bytes
   clTime,       // fldTIME         10                // Time        (32 bit)
   clTime,       // fldTIMESTAMP    11                // Time-stamp  (64 bit)
   clNumeric,    // fldUINT16       12             // Unsigned 16 bit integer
   clNumeric,    // fldUINT32       13             // Unsigned 32 bit integer
   clNumeric,    // fldFLOATIEEE    14             // 80-bit IEEE float
   clNone,       // fldVARBYTES     15             // Length prefixed var bytes
   clNone,       // fldLOCKINFO     16             // Look for LOCKINFO typedef
   clNone,       // fldMEMO         17             //
   clNumeric,    // fldINT64        18             // 64 bit signed number
   clNumeric,    // fldUINT64       19             // Unsigned 64 bit integer
   clNone,       // PlaceHolder     20             //
   clNone,       // PlaceHolder     21             //
   clNone,       // PlaceHolder     22             //
   clNone,       // PlaceHolder     23             //
   clTime,       // fldDATETIME     24             // 16 byte SQLTimeStamp struct
   clNumeric,    // fldFMTBCD       25             // FMTBCD Variant
   clNumeric,    // fldSINGLE       27             // 32 bit floating point
   clNumeric,    // fldINT8         28             // 8 bit signed number
   clNumeric,    // fldUINT8        29             // Unsigned 8 bit integer
   clTime        // fldDATETIMEOFFSET 36           // 20 byte SQLTimeStampOffset struct
};

#else

extern UnOpsArgs qnodeAvgOps[] ;
extern UnOpsArgs qnodeTotalOps[];
extern UnOpsArgs qnodeCountOps[];
extern UnOpsArgs qnodeMaxOps[] ;
extern UnOpsArgs qnodeMinOps[];
extern UnOpsArgs qnodeCastOps[];
extern UnOpsArgs qnodeIsNullOps[];
extern UnOpsArgs qnodeExistsOps[];
extern OpType alOpType[];
extern TypeClass alTypeClass[];
extern UnOpsArgs *UnOps[];
extern BinOpsArgs *BinOps[];

#endif



#define D400 146097L
#define D100 36524L
#define D4 1461
#define D1 365
#define   MILSECSPERMIN      60000L
#define   MILSECSPERHOUR   3600000L
#define   MILSECSPERDAY   86400000L

static INT16 LsLocalDayOfYear( INT16 iMon, INT16 iDay, INT16 iYear );
static void  LsLocalMonthDay( UINT16 iN,
                                UINT16 *piMon,
                                UINT16 *piDay,
                                UINT16 iYr );
BOOL WEAKATTR LocalIsLeap( INT16 iYr );

void WEAKATTR DBIFN  LsDateDecode( DBIDATE  Date,
                   pUINT16 iMon,
                   pUINT16 iDay,
                   pINT16 iYear )
{
   INT32       mod400, mod100;
   UINT16      mod4, mod1;
   INT16       iYr;

   if ( ! Date )
   {
      *iMon = *iDay = *iYear = 0;
      return;
   }

   mod400   = Date % D400;
   mod100   = mod400 % D100;
   mod4     = (UINT16) (mod100 % D4);
   mod1     = (UINT16) (mod4 % D1);

   iYr      = (UINT16) (1 + (Date/D400)*400 + (mod400/D100)*100 + 
                          (mod100/D4)*4 + (mod4/D1));

   if ( !mod1 ) 
   {                   /* test end of year condition */
     iYr = (INT16) (iYr - 1);
     mod1 = (UINT16) (( (!mod4) && (mod100 || !mod400) ) ? 366 : 365);
   }

   LsLocalMonthDay( mod1, iMon, iDay, iYr );

      
   *iYear = iYr;

}

INT32 LsCompareSqlTimeStamp( pBYTE pt1, pBYTE pt2 )
{
  INT32 iCmp = 0;
  iCmp = 0;  // first 6 members are UINT16 (2 bytes)
  for( int i = 0; i < 12 && iCmp ==0; i+=2 ) 
    iCmp = *((UINT16*) (pt1+i)) - *((UINT16*) (pt2+i));
  if( !iCmp )  // last member is UINT32 (4 bytes)
    iCmp = *((UINT32*) (pt1+12)) - *((UINT32*) (pt2+12));
  return iCmp;
}

INT32 LsCompareSqlTimeStampOffset( pBYTE pt1, pBYTE pt2 )
{
  INT32 iCmp = 0;
  iCmp = 0;  // first 6 members are UINT16 (2 bytes)
  for( int i = 0; i < 12 && iCmp ==0; i+=2 )
    iCmp = *((UINT16*) (pt1+i)) - *((UINT16*) (pt2+i));
  if( !iCmp )  // last member is UINT32 (4 bytes)
    iCmp = *((UINT32*) (pt1+12)) - *((UINT32*) (pt2+12));
  if ( !iCmp )
    for( int i = 16; i < 20 && iCmp ==0; i+=2 )
      iCmp = *((UINT16*) (pt1+i)) - *((UINT16*) (pt2+i));
  return iCmp;
}

void DBIFN  LsSqlTimeStampDecode ( 
   SQLTIMESTAMP * pTimeStamp,
   pINT16 pYear,
   pUINT16 pMonth,
   pUINT16 pDay,
   pUINT16 pHour,
   pUINT16 pMinute,
   pUINT16 pSecond, 
   pUINT32 pFraction )
{
   *pYear = pTimeStamp->year;
   *pMonth = pTimeStamp->month;
   *pDay = pTimeStamp->day;
   *pHour = pTimeStamp->hour;
   *pMinute = pTimeStamp->minute;
   *pSecond = pTimeStamp->second;
   *pFraction = pTimeStamp->fraction;
}

void DBIFN  LsSqlTimeStampOffsetDecode (
   SQLTIMESTAMPOFFSET * pTimeStampOffset,
   pINT16 pYear,
   pUINT16 pMonth,
   pUINT16 pDay,
   pUINT16 pHour,
   pUINT16 pMinute,
   pUINT16 pSecond,
   pUINT32 pFraction,
   pINT16 pTimeZoneHour,
   pINT16 pTimeZoneMinute )
{
   *pYear = pTimeStampOffset->year;
   *pMonth = pTimeStampOffset->month;
   *pDay = pTimeStampOffset->day;
   *pHour = pTimeStampOffset->hour;
   *pMinute = pTimeStampOffset->minute;
   *pSecond = pTimeStampOffset->second;
   *pFraction = pTimeStampOffset->fraction;
   *pTimeZoneHour = pTimeStampOffset->timezone_hour;
   *pTimeZoneMinute = pTimeStampOffset->timezone_minute;
}

void DBIFN  LsSqlTimeStampEncode (
   SQLTIMESTAMP * pTimeStamp,
   INT16 Year,
   UINT16 Month,
   UINT16 Day,
   UINT16 Hour,
   UINT16 Minute,
   UINT16 Second,
   UINT32 Fraction )
{
   pTimeStamp->year = Year;
   pTimeStamp->month = Month;
   pTimeStamp->day = Day;
   pTimeStamp->hour = Hour;
   pTimeStamp->minute = Minute;
   pTimeStamp->second = Second;
   pTimeStamp->fraction = Fraction;
}

void DBIFN  LsSqlTimeStampOffsetEncode (
   SQLTIMESTAMPOFFSET * pTimeStampOffset,
   INT16 Year,
   UINT16 Month,
   UINT16 Day,
   UINT16 Hour,
   UINT16 Minute,
   UINT16 Second,
   UINT32 Fraction,
   INT16 TimeZoneHour,
   INT16 TimeZoneMinute )
{
   pTimeStampOffset->year = Year;
   pTimeStampOffset->month = Month;
   pTimeStampOffset->day = Day;
   pTimeStampOffset->hour = Hour;
   pTimeStampOffset->minute = Minute;
   pTimeStampOffset->second = Second;
   pTimeStampOffset->fraction = Fraction;
   pTimeStampOffset->timezone_hour = TimeZoneHour;
   pTimeStampOffset->timezone_minute = TimeZoneMinute;
}


void DBIFN  LsTimeStampDecode (
   TIMESTAMP TimeStamp,
   pDBIDATE     Date,
   pTIME     Time 
)
{
   // Note: date truncates towards zero.  if there is a remainder,
   //       its value will be one too close to zero. -- bs --
   //
   *Date = (DBIDATE) (TimeStamp / (TIMESTAMP) MILSECSPERDAY);
   *Time = (TIME) (TimeStamp - TIMESTAMP( ((TIMESTAMP)(*Date)) * ((TIMESTAMP) MILSECSPERDAY) ));
   if( *Time < (TIME)0 )
   {
      (*Date)--;
      (*Time) += MILSECSPERDAY;
   }

   // MAS 1/3/95:  Time is zero-based, that is, it runs from 
   // 0 through (MILSECSPERDAY - 1).  Due to roundoff error above,
   // we may get a time of MILSECSPERDAY, which is not valid.
   // This is corrected here.

   if (*Time >= MILSECSPERDAY)
   {
      *Time -= MILSECSPERDAY;
      (*Date)++;
   }
}

void WEAKATTR DBIFN  LsTimeDecode  ( TIME time,
                      pUINT16  iHour,
                      pUINT16  iMin,
                      pUINT16  iMilSec )
{

   if( time >= MILSECSPERDAY )
   {
      *iHour = 0;
      *iMin = 0;
      *iMilSec = 0;
   }
   else
   {
      *iHour = (UINT16) ( time / MILSECSPERHOUR );
      *iMin = (UINT16) ((time - ( (TIME)*iHour * MILSECSPERHOUR) ) / MILSECSPERMIN);
      *iMilSec = (UINT16 ) ( time  - ((TIME)*iHour * (TIME) MILSECSPERHOUR) 
                            - ((TIME)*iMin * (TIME) MILSECSPERMIN));
   }
}

extern int iDayTable[2][13];

static INT16 LsLocalDayOfYear( INT16 iMon, INT16 iDay, INT16 iYear )
{
   INT16   iSum, i;
   INT16   iLeapFlag = (INT16) LocalIsLeap( iYear );

   for (i = 1, iSum = iDay; i < iMon;)
     iSum += (INT16) (iDayTable[iLeapFlag][i++]);

   return iSum;
}


static void LsLocalMonthDay( UINT16 iN, 
                               UINT16 *piMon, 
                               UINT16 *piDay, 
                               UINT16 iYr )
{
   INT16   i, iDaysInMo, iLeapFlag;

   iLeapFlag = INT16(LocalIsLeap(iYr));

   for (i = 1; iN > (iDaysInMo = (INT16) iDayTable[iLeapFlag][i++]);)
      iN -= iDaysInMo;

   *piMon = --i;
   *piDay = iN;
}

/*
** Return 
**    1 if year is a leap year
**    0 otherwise
*/

BOOL LocalIsLeap( INT16 iYr )
{
    return (!(iYr % 4)) && (iYr % 100 || (!(iYr % 400)));
}


DBIDATE DBIFN  LsDateEncode ( UINT16     iMon, 
                    UINT16     iDay,
                    INT16     iYear )
{
   INT16 iLastYear = (INT16) (iYear - 1); 

   return LsLocalDayOfYear( iMon, iDay, iYear ) +
              365L*iLastYear + iLastYear/4 - iLastYear/100 + iLastYear/400;
}

DBIResult WEAKATTR DBIFN  LsTimeEncode  (  UINT16     iHour,
                      UINT16     iMin,              
                      UINT16    iMilSec,
                      pTIME      pTime)          
{
   if( iHour > 23  || iMin > 59 || iMilSec > 59999L )
      return DBIERR_INVALIDTIME;

   *pTime = (iHour * 60 + iMin) * MILSECSPERMIN  + iMilSec;
   return( DBIERR_NONE );
}

DBIResult  DBIFN  LsTimeStampEncode  (
   DBIDATE   Date,
   TIME   Time,
   pTIMESTAMP ptimeStamp
)
{
   if( Time > (TIME) MILSECSPERDAY )
      return DBIERR_INVALIDTIMESTAMP;

   *ptimeStamp =  (TIMESTAMP) (((TIMESTAMP) Date) * ((TIMESTAMP) MILSECSPERDAY)) + Time ;
   return DBIERR_NONE ;
}

void DBIFN  LsSqlTimeStampToTimeStamp(
   SQLTIMESTAMP * pSqlTimeStamp,
   TIMESTAMP * pTimeStamp)
{
   INT16 Year;
   UINT16 Month, Day, Hour, Minute, Second;
   UINT32 Fraction;
   DBIDATE dDate = 0;
   TIME dTime = 0;
   LsSqlTimeStampDecode( pSqlTimeStamp, &Year, &Month, &Day, &Hour, &Minute, &Second, &Fraction );
   if( Year + Month + Day > 0 )
     dDate = LsDateEncode( Month, Day, Year );
   if( Hour + Minute + Second + Fraction > 0 )
     LsTimeEncode( Hour, Minute, (UINT16) ((Second *1000) + Fraction), &dTime );
   LsTimeStampEncode( dDate, dTime, pTimeStamp );
}

void DBIFN  LsSqlTimeStampOffsetToTimeStamp(
   SQLTIMESTAMPOFFSET * pSqlTimeStampOffset,
   TIMESTAMP * pTimeStamp)
{
   INT16 Year, TimeZoneHour, TimeZoneMinute;
   UINT16 Month, Day, Hour, Minute, Second;
   UINT32 Fraction;
   DBIDATE dDate = 0;
   TIME dTime = 0;
   LsSqlTimeStampOffsetDecode( pSqlTimeStampOffset, &Year, &Month, &Day, &Hour, &Minute, &Second, &Fraction, &TimeZoneHour, &TimeZoneMinute );
   if( Year + Month + Day > 0 )
     dDate = LsDateEncode( Month, Day, Year );
   if( Hour + Minute + Second + Fraction > 0 )
     LsTimeEncode( Hour, Minute, (UINT16) ((Second *1000) + Fraction), &dTime );
   LsTimeStampEncode( dDate, dTime, pTimeStamp );
}

void DBIFN  LsTimeStampToSqlTimeStamp(
   TIMESTAMP * pTimeStamp,
   SQLTIMESTAMP * pSqlTimeStamp)
{
   INT16 Year;
   UINT16 Month, Day, Hour, Minute, Second;
   DBIDATE dDate;
   TIME dTime;
   LsTimeStampDecode( *pTimeStamp, &dDate, &dTime );
   LsDateDecode( dDate, &Month, &Day, &Year );
   LsTimeDecode( dTime, &Hour, &Minute, &Second );
   LsSqlTimeStampEncode( pSqlTimeStamp, Year, Month, Day, Hour, Minute, (UINT16) (Second/1000), Second - ((UINT16) (Second/1000) *1000) );
}

void DBIFN  LsTimeStampToSqlTimeStampOffset(
   TIMESTAMP * pTimeStamp,
   SQLTIMESTAMPOFFSET * pSqlTimeStampOffset)
{
   INT16 Year;
   UINT16 Month, Day, Hour, Minute, Second;
   DBIDATE dDate;
   TIME dTime;
   LsTimeStampDecode( *pTimeStamp, &dDate, &dTime );
   LsDateDecode( dDate, &Month, &Day, &Year );
   LsTimeDecode( dTime, &Hour, &Minute, &Second );
   LsSqlTimeStampOffsetEncode( pSqlTimeStampOffset, Year, Month, Day, Hour, Minute, (UINT16) (Second/1000), Second - ((UINT16) (Second/1000) *1000), 0, 0 );
}

void SqlTimeStampAddition( SQLTIMESTAMP *pTimeStamp, double iDaysToAdd )
{
   INT32 iDays = pTimeStamp->day + (INT32) iDaysToAdd;
   UINT16 iMonth = pTimeStamp->month;
   UINT16 iYear = pTimeStamp->year;
   while( iDays > iDayTable[LocalIsLeap( iYear )][iMonth] )
   {
      iDays -= iDayTable[LocalIsLeap( iYear )][iMonth];
      iMonth = (UINT16) (iMonth + 1);
      if( iMonth > 12 ) 
      {
         iMonth = 1;
         iYear = (UINT16) (iYear + 1);
      }
   }
   while( iDays < 1 )
   {
      iMonth = (UINT16) (iMonth - 1);
      if( iMonth == 0 ) 
      {
         iMonth = 12;
         iYear = (UINT16) (iYear - 1);
      }
      iDays += iDayTable[LocalIsLeap( iYear )][iMonth];
   }
}

void SqlTimeStampOffsetAddition( SQLTIMESTAMPOFFSET *pTimeStampOffset, double iDaysToAdd )
{
   INT32 iDays = pTimeStampOffset->day + (INT32) iDaysToAdd;
   UINT16 iMonth = pTimeStampOffset->month;
   UINT16 iYear = pTimeStampOffset->year;
   while( iDays > iDayTable[LocalIsLeap( iYear )][iMonth] )
   {
      iDays -= iDayTable[LocalIsLeap( iYear )][iMonth];
      iMonth = (UINT16) (iMonth + 1);
      if( iMonth > 12 )
      {
         iMonth = 1;
         iYear = (UINT16) (iYear + 1);
      }
   }
   while( iDays < 1 )
   {
      iMonth = (UINT16) (iMonth - 1);
      if( iMonth == 0 )
      {
         iMonth = 12;
         iYear = (UINT16) (iYear - 1);
      }
      iDays += iDayTable[LocalIsLeap( iYear )][iMonth];
   }
}

int FixedCharLength( pCHAR pszValue )
{
   int iRetval = strlen( pszValue );
   while( iRetval > 0 && pszValue[ iRetval - 1 ] == ' ')
      iRetval--;
   return iRetval;
}

int MaxFixedCharLength( pCHAR pszValue1, pCHAR pszValue2 )
{
   int iSize1 = FixedCharLength( pszValue1 );
   int iSize2 = FixedCharLength( pszValue2 );
   return (iSize1 >= iSize2) ? iSize1 : iSize2;
}

DFLOAT PtrToDFloat(pVOID Value)
{
#if defined(ALIGNWORKAROUND)
  DFLOAT Result = 0;
  memcpy(&Result, Value, sizeof(DFLOAT));
  return Result;
#else
  return *(DFLOAT*)Value;
#endif
}

BOOL QCanExecStream::Execute(
   pBYTE    pRecBuf,
   eAggAct  eaggAct,
   AGGVALUE  *pAggValue
)
{
   pQCanExecElem pElem;
   pQCanExecElem pElemLast = NULL;

   DFLOAT f1, f2, fRes;
   UINT16 i;
   BOOL16 bRet = TRUE;

   ForEachInSet( pFieldExecElemSet, pElem )
   {
      pElemLast = pElem;
      if( pElem->eAggFunc != aggopNoop ) // Aggregate operation:
      {
         long double d1, d2, d3; // temp vars for BCD aggs
         bRet = FALSE;
         pUINT32  pCurNullCount = (pUINT32)OP_AGG_NULLCNT;
         UINT32 iNonNullCount;
         if( eaggAct == eAggReset || !pAggValue->iCnt )
         {
            switch( pElem->eAggFunc )
            {
               case    aggopSmallSum:
               case    aggopShortSum:
               case    aggopLongSum:
               case    aggopByteSum:
               case    aggopWordSum:
               case    aggopLongWordSum:
               case    aggopFloatSum:
               case    aggopSmallAvg:
               case    aggopShortAvg:
               case    aggopLongAvg:
               case    aggopByteAvg:
               case    aggopWordAvg:
               case    aggopLongWordAvg:
               case    aggopFloatAvg:
                  *((DFLOAT*)(OP_RES)) = 0;
                  break;

               case    aggopLongIntSum:
               case    aggopLongIntAvg:
               case    aggopU64Sum:
               case    aggopU64Avg:
                  *((DFLOAT*)(OP_RES)) = 0;
                  break;

               case    aggopSingleSum:
                  *((SINGLE*)(OP_RES)) = 0;
                  break;
               case    aggopBcdSum:
                  d1 = 0;
                  bcdFromLongDouble((TDecimal*)OP_RES, &d1,
                                 pElem->iArg1Units1, pElem->iArg1Units2 );
                  break;
               case    aggopSingleAvg:
                  *((SINGLE*)(OP_RES)) = 0;
                  break;
               case    aggopSqlTimestampAvg:
                  memset(OP_RES, 0, sizeof( SQLTIMESTAMP ) );
                  break;
               case    aggopSqlTimestampOffsetAvg:
                  memset(OP_RES, 0, sizeof( SQLTIMESTAMPOFFSET ) );
                  break;
               case    aggopBcdAvg:
                  d1 = 0;
                  bcdFromLongDouble((TDecimal*)OP_RES, &d1,
                                 pElem->iArg1Units1, pElem->iArg1Units2 );
                  break;
               case    aggopDateAvg:
                  *((DFLOAT*)(OP_RES + pElem->iResLen + NULLINDLEN + sizeof(UINT32))) = 0;
                  break;
               case    aggopCount:
               case    aggopCountAll:
                  *(UINT32*)OP_RES = 0;
                  break;
               default:
                  break;
            }

            *pCurNullCount = 0;
            if( pElem->eAggFunc != aggopCount
               && pElem->eAggFunc != aggopCountAll
            )
               SETNULLVALUE( OP_RES_NULL, TRUE );
            else
               SETNULLVALUE( OP_RES_NULL, FALSE );

         }

         iNonNullCount = pAggValue->iCnt - *pCurNullCount;

         if( eaggAct == eAggAdd )
         {
            if( pElem->ppRecReg1 && ISNULLVALUE(OP_ARG1_NULL) 
                       && (pElem->eAggFunc != aggopCountAll)
            )
               (*pCurNullCount)++;
            else
            {
               switch( pElem->eAggFunc )
               {
                  case    aggopSmallSum:
                     *((DFLOAT*)(OP_RES)) += *(INT8*)(OP_ARG1);
                     break;
                  case    aggopShortSum:
                     *((DFLOAT*)(OP_RES)) += *(INT16*)(OP_ARG1);
                     break;
                  case    aggopLongSum:
                     *((DFLOAT*)(OP_RES)) += *(INT32*)(OP_ARG1);
                     break;
                  case    aggopLongIntSum:
                     *((DFLOAT*)(OP_RES)) += *(INT64*)(OP_ARG1);
                     break;
                  case    aggopByteSum:
                     *((DFLOAT*)(OP_RES)) += *(UINT8*)(OP_ARG1);
                     break;
                  case    aggopWordSum:
                     *((DFLOAT*)(OP_RES)) += *(UINT16*)(OP_ARG1);
                     break;
                  case    aggopLongWordSum:
                     *((DFLOAT*)(OP_RES)) += *(UINT32*)(OP_ARG1);
                     break;
                  case    aggopU64Sum:
                     *((DFLOAT*)(OP_RES)) += *(UINT64*)(OP_ARG1);
                     break;
                  case    aggopFloatSum:
                     *((DFLOAT*)(OP_RES)) += PtrToDFloat(OP_ARG1);
                     break;
                  case    aggopSingleSum:
                     *((SINGLE*)(OP_RES)) += *(SINGLE*)OP_ARG1;
                     break;
                  case    aggopBcdSum:
                     bcdToLongDouble(&d1, (TDecimal*) OP_ARG1);
                     bcdToLongDouble(&d2, (TDecimal*) OP_RES);
                     d3 = d1 + d2;
                     bcdFromLongDouble((TDecimal*)OP_RES, &d3,
                                    pElem->iResUnits1, pElem->iResUnits2);
                     break;
                  case    aggopSmallAvg:
                     *((DFLOAT*)(OP_RES)) =
                        ((PtrToDFloat(OP_RES) * iNonNullCount)
                          + *(INT8*)(OP_ARG1)) /  (iNonNullCount + 1);
                     break;
                  case    aggopShortAvg:
                     *((DFLOAT*)(OP_RES)) =
                        ((PtrToDFloat(OP_RES) * iNonNullCount)
                          + *(INT16*)(OP_ARG1)) /  (iNonNullCount + 1);
                     break;
                  case    aggopLongAvg:
                     *((DFLOAT*)(OP_RES)) =
                        ((PtrToDFloat(OP_RES) * iNonNullCount)
                          + *(INT32*)(OP_ARG1)) /  (iNonNullCount + 1);
                     break;
                  case    aggopLongIntAvg:
                     *((DFLOAT*)(OP_RES)) =
                        ((PtrToDFloat(OP_RES) * iNonNullCount)
                          + *(INT64*)(OP_ARG1)) /  (iNonNullCount + 1);
                     break;
                  case    aggopByteAvg:
                     *((DFLOAT*)(OP_RES)) =
                        ((PtrToDFloat(OP_RES) * iNonNullCount)
                          + *(UINT8*)(OP_ARG1)) /  (iNonNullCount + 1);
                     break;
                  case    aggopWordAvg:
                     *((DFLOAT*)(OP_RES)) =
                        ((PtrToDFloat(OP_RES) * iNonNullCount)
                          + *(UINT16*)(OP_ARG1)) /  (iNonNullCount + 1);
                     break;
                  case    aggopLongWordAvg:
                     *((DFLOAT*)(OP_RES)) =
                        ((PtrToDFloat(OP_RES) * iNonNullCount)
                          + *(UINT32*)(OP_ARG1)) /  (iNonNullCount + 1);
                     break;
                  case    aggopU64Avg:
                     *((DFLOAT*)(OP_RES)) =
                        ((PtrToDFloat(OP_RES) * iNonNullCount)
                          + *(UINT64*)(OP_ARG1)) /  (iNonNullCount + 1);
                     break;
                  case    aggopFloatAvg:
                     *((DFLOAT*)(OP_RES)) =
                        ((PtrToDFloat(OP_RES) * iNonNullCount )
                          + PtrToDFloat(OP_ARG1)) /  (iNonNullCount + 1);
                     break;
                  case    aggopSingleAvg:
                     *((SINGLE*)(OP_RES)) =
                        ((*((SINGLE*)(OP_RES)) * iNonNullCount )
                          + *(SINGLE*)(OP_ARG1)) /  (iNonNullCount + 1);
                     break;
                  case    aggopSqlTimestampAvg:
                  {
                     TIMESTAMP Ts1 = 0x00, Ts2 = 0x00, TsResult;
                     if( OP_RES )
                        LsSqlTimeStampToTimeStamp( (SQLTIMESTAMP*)OP_RES, &Ts1 );
                     if( OP_ARG1 )
                        LsSqlTimeStampToTimeStamp( (SQLTIMESTAMP*)OP_ARG1, &Ts2 );
                     TsResult = (TIMESTAMP) ((Ts1 * iNonNullCount )
                          + Ts2 ) /  (iNonNullCount + 1);
                     LsTimeStampToSqlTimeStamp( &TsResult, (SQLTIMESTAMP*) OP_RES);
                     break;
                  }
                  case    aggopSqlTimestampOffsetAvg:
                  {
                     TIMESTAMP Ts1 = 0x00, Ts2 = 0x00, TsResult;
                     if( OP_RES )
                        LsSqlTimeStampOffsetToTimeStamp( (SQLTIMESTAMPOFFSET*)OP_RES, &Ts1 );
                     if( OP_ARG1 )
                        LsSqlTimeStampOffsetToTimeStamp( (SQLTIMESTAMPOFFSET*)OP_ARG1, &Ts2 );
                     TsResult = (TIMESTAMP) ((Ts1 * iNonNullCount )
                          + Ts2 ) /  (iNonNullCount + 1);
                     LsTimeStampToSqlTimeStampOffset( &TsResult, (SQLTIMESTAMPOFFSET*) OP_RES);
                     break;
                  }
                  case    aggopBcdAvg:
                     bcdToLongDouble(&d1, (TDecimal*) OP_ARG1);
                     bcdToLongDouble(&d2, (TDecimal*) OP_RES);
                     d3 = (( d2 * iNonNullCount ) + d1 ) / (iNonNullCount + 1);
                     bcdFromLongDouble((TDecimal*)OP_RES, &d3,
                                    pElem->iResUnits1, pElem->iResUnits2);
                     break;
                  case aggopDateAvg:
                     {
                        DFLOAT  *p;
                        p = (DFLOAT*)(OP_RES + pElem->iResLen + NULLINDLEN + sizeof(UINT32));
                        *p = PtrToDFloat(p) + (DFLOAT)(*(UINT32*)(OP_ARG1));
                        *((UINT32*)(OP_RES)) = *p / (iNonNullCount + 1);
                     }
                     break;
                  case aggopStringMin:
                     if( LangStrCmp(lcid,OP_ARG1,(pBYTE)OP_RES) < 0
                        || !iNonNullCount
                     )
                        MemMove(OP_ARG1, (pBYTE)OP_RES, pElem->iResLen);
                     break;
                  case aggopStringMax:
                     if( LangStrCmp(lcid,OP_ARG1,(pBYTE)OP_RES) > 0
                        || !iNonNullCount
                     )
                        MemMove(OP_ARG1, (pBYTE)OP_RES, pElem->iResLen);
                     break;
                  case    aggopUnicodeMin:
                  case    aggopUnicodeMax:
                  {
                     INT32 iCmp;
                     iCmp = CompareStringW(lcid, 0,
                            (pCUCS2Char) &OP_ARG1[sizeof(UINT16)],
                              (int) (*(UINT16*) OP_ARG1)/2,
                            (pCUCS2Char) &OP_RES[sizeof(UINT16)],
                            (int)(*(UINT16*) OP_RES)/2) -2;
                     if( pElem->eAggFunc == aggopUnicodeMin )
                     {
                        if( iCmp < 0  || !iNonNullCount )
                           MemMove(OP_ARG1, (pBYTE)OP_RES, pElem->iResLen);
                     }
                     else if( iCmp > 0  || !iNonNullCount )
                        MemMove(OP_ARG1, (pBYTE)OP_RES, pElem->iResLen);
                     break;
                  }
                  case    aggopSmallMin:
                     if(*(INT8*)(OP_ARG1) < *(INT8*)(OP_RES)
                        || !iNonNullCount )
                       *(INT8*)(OP_RES) = *(INT8*)(OP_ARG1);
                     break;
                  case    aggopShortMin:
                     if(*(INT16*)(OP_ARG1) < *(INT16*)(OP_RES)
                        || !iNonNullCount )
                       *(INT16*)(OP_RES) = *(INT16*)(OP_ARG1);
                     break;
                  case    aggopLongMin:
                     if(*(INT32*)(OP_ARG1) < *(INT32*)(OP_RES)
                        || !iNonNullCount )
                       *(INT32*)(OP_RES) = *(INT32*)(OP_ARG1);
                     break;
                  case    aggopLongIntMin:
                     if(*(INT64*)(OP_ARG1) < *(INT64*)(OP_RES)
                        || !iNonNullCount )
                       *(INT64*)(OP_RES) = *(INT64*)(OP_ARG1);
                     break;
                  case    aggopByteMin:
                     if(*(UINT8*)(OP_ARG1) < *(UINT8*)(OP_RES)
                        || !iNonNullCount )
                       *(UINT8*)(OP_RES) = *(UINT8*)(OP_ARG1);
                     break;
                  case    aggopWordMin:
                     if(*(UINT16*)(OP_ARG1) < *(UINT16*)(OP_RES)
                        || !iNonNullCount )
                       *(UINT16*)(OP_RES) = *(UINT16*)(OP_ARG1);
                     break;
                  case    aggopLongWordMin:
                     if(*(UINT32*)(OP_ARG1) < *(UINT32*)(OP_RES)
                        || !iNonNullCount )
                       *(UINT32*)(OP_RES) = *(UINT32*)(OP_ARG1);
                     break;
                  case    aggopU64Min:
                     if(*(UINT64*)(OP_ARG1) < *(UINT64*)(OP_RES)
                        || !iNonNullCount )
                       *(UINT64*)(OP_RES) = *(UINT64*)(OP_ARG1);
                     break;
                  case aggopFloatMin:
                     if(*(DFLOAT*)(OP_ARG1) < *(DFLOAT*)(OP_RES)
                        || !iNonNullCount )
                       *(DFLOAT*)(OP_RES) = PtrToDFloat(OP_ARG1);
                     break;
                  case aggopSingleMin:
                     if(*(SINGLE*)(OP_ARG1) < *(SINGLE*)(OP_RES)
                        || !iNonNullCount )
                       *(SINGLE*)(OP_RES) = *(SINGLE*)(OP_ARG1);
                     break;
                  case aggopSqlTimestampMin:
                     if( (LsCompareSqlTimeStamp(OP_ARG1, OP_RES) < 0 )
                        || !iNonNullCount )
                       *(SQLTIMESTAMP*)(OP_RES) = *(SQLTIMESTAMP*)(OP_ARG1);
                     break;
                  case aggopSqlTimestampMax:
                     if( (LsCompareSqlTimeStamp(OP_ARG1, OP_RES) > 0 )
                        || !iNonNullCount )
                       *(SQLTIMESTAMP*)(OP_RES) = *(SQLTIMESTAMP*)(OP_ARG1);
                     break;
                  case aggopSqlTimestampOffsetMin:
                     if( (LsCompareSqlTimeStampOffset(OP_ARG1, OP_RES) < 0 )
                        || !iNonNullCount )
                       *(SQLTIMESTAMPOFFSET*)(OP_RES) = *(SQLTIMESTAMPOFFSET*)(OP_ARG1);
                     break;
                  case aggopSqlTimestampOffsetMax:
                     if( (LsCompareSqlTimeStampOffset(OP_ARG1, OP_RES) > 0 )
                        || !iNonNullCount )
                       *(SQLTIMESTAMPOFFSET*)(OP_RES) = *(SQLTIMESTAMPOFFSET*)(OP_ARG1);
                     break;
                  case aggopBcdMin:
                     bcdToLongDouble(&d1, (TDecimal*) OP_ARG1);
                     if( iNonNullCount )
                     {
                       bcdToLongDouble(&d2, (TDecimal*) OP_RES);
                       if( d1 < d2 )
                          bcdFromLongDouble((TDecimal*)OP_RES, &d1,
                                    pElem->iResUnits1, pElem->iResUnits2);
                     }
                     else
                        bcdFromLongDouble((TDecimal*)OP_RES, &d1,
                                    pElem->iResUnits1, pElem->iResUnits2);
                     break;
                  case    aggopCount:
                     *(INT32*)(OP_RES) = iNonNullCount + 1;
                     break;
                  case    aggopCountAll:
                     *(INT32*)(OP_RES) = pAggValue->iCnt + 1;
                     break;
                  case    aggopSmallMax:
                     if( *(INT8*)(OP_ARG1) > *(INT8*)(OP_RES)
                        || !iNonNullCount )
                       *(INT8*)(OP_RES) = *(INT8*)(OP_ARG1);
                     break;
                  case    aggopShortMax:
                     if( *(INT16*)(OP_ARG1) > *(INT16*)(OP_RES)
                        || !iNonNullCount )
                       *(INT16*)(OP_RES) = *(INT16*)(OP_ARG1);
                     break;
                  case    aggopLongMax:
                     if(*(INT32*)(OP_ARG1) > *(INT32*)(OP_RES)
                        || !iNonNullCount )
                       *(INT32*)(OP_RES) = *(INT32*)(OP_ARG1);
                     break;
                  case    aggopLongIntMax:
                     if(*(INT64*)(OP_ARG1) > *(INT64*)(OP_RES)
                        || !iNonNullCount )
                       *(INT64*)(OP_RES) = *(INT64*)(OP_ARG1);
                     break;
                  case    aggopByteMax:
                     if( *(UINT8*)(OP_ARG1) > *(UINT8*)(OP_RES)
                        || !iNonNullCount )
                       *(UINT8*)(OP_RES) = *(UINT8*)(OP_ARG1);
                     break;
                  case    aggopWordMax:
                     if( *(UINT16*)(OP_ARG1) > *(UINT16*)(OP_RES)
                        || !iNonNullCount )
                       *(UINT16*)(OP_RES) = *(UINT16*)(OP_ARG1);
                     break;
                  case    aggopLongWordMax:
                     if(*(UINT32*)(OP_ARG1) > *(UINT32*)(OP_RES)
                        || !iNonNullCount )
                       *(UINT32*)(OP_RES) = *(UINT32*)(OP_ARG1);
                     break;
                  case    aggopU64Max:
                     if(*(UINT64*)(OP_ARG1) > *(UINT64*)(OP_RES)
                        || !iNonNullCount )
                       *(UINT64*)(OP_RES) = *(UINT64*)(OP_ARG1);
                     break;
                  case aggopFloatMax:
                     if(*(DFLOAT*)(OP_ARG1)> *(DFLOAT*)(OP_RES)
                        || !iNonNullCount )
                       *(DFLOAT*)(OP_RES) = PtrToDFloat(OP_ARG1);
                     break;
                  case aggopSingleMax:
                     if(*(SINGLE*)(OP_ARG1)> *(SINGLE*)(OP_RES)
                        || !iNonNullCount )
                       *(SINGLE*)(OP_RES) = *(SINGLE*)(OP_ARG1);
                     break;
                  case aggopBcdMax:
                     bcdToLongDouble(&d1, (TDecimal*) OP_ARG1);
                     if( iNonNullCount )
                     {
                        bcdToLongDouble(&d2, (TDecimal*) OP_RES);
                        if( d1 > d2 )
                          bcdFromLongDouble((TDecimal*)OP_RES, &d1,
                                    pElem->iResUnits1, pElem->iResUnits2);
                     }
                     else
                          bcdFromLongDouble((TDecimal*)OP_RES, &d1,
                                    pElem->iResUnits1, pElem->iResUnits2);
                     break;
                  default:
                     break;
               }
               SETNULLVALUE( OP_RES_NULL, FALSE );
            }
         }
         else if(eaggAct == eAggSub )
         {
            if( pElem->ppRecReg1 && ISNULLVALUE(OP_ARG1_NULL)
                       && (pElem->eAggFunc != aggopCountAll)
            )
               (*pCurNullCount)--;
            else
            {
               switch( pElem->eAggFunc )
               {
                  case    aggopSmallSum:
                     *((DFLOAT*)(OP_RES)) -= *(INT8*)(OP_ARG1);
                     break;
                  case    aggopShortSum:
                     *((DFLOAT*)(OP_RES)) -= *(INT16*)(OP_ARG1);
                     break;
                  case    aggopLongSum:
                     *((DFLOAT*)(OP_RES)) -= *(INT32*)(OP_ARG1);
                     break;
                  case    aggopLongIntSum:
                     *((DFLOAT*)(OP_RES)) -= *(INT64*)(OP_ARG1);
                     break;
                  case    aggopByteSum:
                     *((DFLOAT*)(OP_RES)) -= *(UINT8*)(OP_ARG1);
                     break;
                  case    aggopWordSum:
                     *((DFLOAT*)(OP_RES)) -= *(UINT16*)(OP_ARG1);
                     break;
                  case    aggopLongWordSum:
                     *((DFLOAT*)(OP_RES)) -= *(UINT32*)(OP_ARG1);
                     break;
                  case    aggopU64Sum:
                     *((DFLOAT*)(OP_RES)) -= *(UINT64*)(OP_ARG1);
                     break;
                  case    aggopFloatSum:
                     *((DFLOAT*)(OP_RES)) -= PtrToDFloat(OP_ARG1);
                     break;
                  case    aggopSingleSum:
                     *((SINGLE*)(OP_RES)) -= *(SINGLE*)(OP_ARG1);
                     break;
                  case    aggopBcdSum:
                     bcdToLongDouble(&d1, (TDecimal*) OP_ARG1);
                     bcdToLongDouble(&d2, (TDecimal*) OP_RES);
                     d3 = d2 - d1;
                     bcdFromLongDouble((TDecimal*)OP_RES, &d3,
                                    pElem->iResUnits1, pElem->iResUnits2);
                     break;
                  case    aggopSmallAvg:
                     if( (iNonNullCount - 1) == 0 )
                        *((DFLOAT*)(OP_RES)) = 0;
                     else
                        *((DFLOAT*)(OP_RES)) =
                           ((PtrToDFloat(OP_RES) * iNonNullCount)
                             - *(INT8*)(OP_ARG1)) /  ( iNonNullCount - 1);
                     break;
                  case    aggopShortAvg:
                     if( (iNonNullCount - 1) == 0 )
                        *((DFLOAT*)(OP_RES)) = 0;
                     else
                        *((DFLOAT*)(OP_RES)) =
                           ((PtrToDFloat(OP_RES) * iNonNullCount)
                             - *(INT16*)(OP_ARG1)) /  ( iNonNullCount - 1);
                     break;
                  case    aggopLongAvg:
                     if( (iNonNullCount - 1) == 0 )
                        *((DFLOAT*)(OP_RES)) = 0;
                     else
                        *((DFLOAT*)(OP_RES)) =
                           ((PtrToDFloat(OP_RES) * iNonNullCount)
                             - *(INT32*)(OP_ARG1)) /  ( iNonNullCount - 1);
                     break;
                  case    aggopLongIntAvg:
                     if( (iNonNullCount - 1) == 0 )
                        *((DFLOAT*)(OP_RES)) = 0;
                     else
                        *((DFLOAT*)(OP_RES)) =
                           ((PtrToDFloat(OP_RES) * iNonNullCount)
                             - *(INT64*)(OP_ARG1)) /  ( iNonNullCount - 1);
                     break;
                  case    aggopByteAvg:
                     if( (iNonNullCount - 1) == 0 )
                        *((DFLOAT*)(OP_RES)) = 0;
                     else
                        *((DFLOAT*)(OP_RES)) =
                           ((PtrToDFloat(OP_RES) * iNonNullCount)
                             - *(UINT8*)(OP_ARG1)) /  ( iNonNullCount - 1);
                     break;
                  case    aggopWordAvg:
                     if( (iNonNullCount - 1) == 0 )
                        *((DFLOAT*)(OP_RES)) = 0;
                     else
                        *((DFLOAT*)(OP_RES)) =
                           ((PtrToDFloat(OP_RES) * iNonNullCount)
                             - *(UINT16*)(OP_ARG1)) /  ( iNonNullCount - 1);
                     break;
                  case    aggopLongWordAvg:
                     if( (iNonNullCount - 1) == 0 )
                        *((DFLOAT*)(OP_RES)) = 0;
                     else
                        *((DFLOAT*)(OP_RES)) =
                           ((PtrToDFloat(OP_RES) * iNonNullCount)
                             - *(UINT32*)(OP_ARG1)) /  ( iNonNullCount - 1);
                     break;
                  case    aggopU64Avg:
                     if( (iNonNullCount - 1) == 0 )
                        *((DFLOAT*)(OP_RES)) = 0;
                     else
                        *((DFLOAT*)(OP_RES)) =
                           ((PtrToDFloat(OP_RES) * iNonNullCount)
                             - *(UINT64*)(OP_ARG1)) /  ( iNonNullCount - 1);
                     break;
                  case    aggopFloatAvg:
                     if( (iNonNullCount - 1) == 0 )
                        *((DFLOAT*)(OP_RES)) = 0;
                     else
                       *((DFLOAT*)(OP_RES)) =
                          ((PtrToDFloat(OP_RES) * iNonNullCount)
                             - PtrToDFloat(OP_ARG1)) /  (iNonNullCount - 1);
                     break;
                  case    aggopSingleAvg:
                     if( (iNonNullCount - 1) == 0 )
                        *((SINGLE*)(OP_RES)) = 0;
                     else
                       *((SINGLE*)(OP_RES)) =
                          ((*((SINGLE*)(OP_RES)) * iNonNullCount)
                             - *(SINGLE*)(OP_ARG1)) /  (iNonNullCount - 1);
                     break;
                  case    aggopSqlTimestampAvg:
                  {
                     if( (iNonNullCount - 1) == 0 )
                        memset(OP_RES, 0, sizeof( SQLTIMESTAMP ) );
                     else
                     {
                        TIMESTAMP Ts1 = 0x00, Ts2 = 0x00, TsResult;
                        if( OP_ARG1 )
                           LsSqlTimeStampToTimeStamp( (SQLTIMESTAMP*)OP_ARG1, &Ts1 );
                        if( OP_RES )
                           LsSqlTimeStampToTimeStamp( (SQLTIMESTAMP*)OP_RES, &Ts2 );
                        TsResult = (TIMESTAMP)  ((Ts2 * iNonNullCount )
                             - Ts1) / (iNonNullCount - 1);
                        LsTimeStampToSqlTimeStamp( &TsResult, (SQLTIMESTAMP*) OP_RES);
                        break;
                     }
                  }
                  case    aggopSqlTimestampOffsetAvg:
                  {
                     if( (iNonNullCount - 1) == 0 )
                        memset(OP_RES, 0, sizeof( SQLTIMESTAMPOFFSET ) );
                     else
                     {
                        TIMESTAMP Ts1 = 0x00, Ts2 = 0x00, TsResult;
                        if( OP_ARG1 )
                           LsSqlTimeStampOffsetToTimeStamp( (SQLTIMESTAMPOFFSET*)OP_ARG1, &Ts1 );
                        if( OP_RES )
                           LsSqlTimeStampOffsetToTimeStamp( (SQLTIMESTAMPOFFSET*)OP_RES, &Ts2 );
                        TsResult = (TIMESTAMP)  ((Ts2 * iNonNullCount )
                             - Ts1) / (iNonNullCount - 1);
                        LsTimeStampToSqlTimeStampOffset( &TsResult, (SQLTIMESTAMPOFFSET*) OP_RES);
                        break;
                     }
                  }
                  case    aggopBcdAvg:
                     if( (iNonNullCount - 1) == 0 )
                        d3 = 0;
                     else
                     {
                        bcdToLongDouble(&d1, (TDecimal*) OP_ARG1);
                        bcdToLongDouble(&d2, (TDecimal*) OP_RES);
                        d3 = (( d2 * iNonNullCount ) - d1 )
                                      / ( iNonNullCount - 1);
                     }
                     bcdFromLongDouble((TDecimal*)OP_RES, &d3,
                                    pElem->iResUnits1, pElem->iResUnits2);
                     break;
                  case    aggopDateAvg:
                     if( (iNonNullCount - 1) != 0 )
                     {
                        DFLOAT  *p;
                        p = (DFLOAT*)(OP_RES + pElem->iResLen + NULLINDLEN + sizeof(UINT32));
                        *p = PtrToDFloat(p) - (DFLOAT)(*(UINT32*)(OP_ARG1));
                        *((UINT32*)(OP_RES)) = *p / (iNonNullCount - 1);
                     }
                     break;
                  case    aggopSmallMin:
                  case    aggopSmallMax:
                  case    aggopByteMin:
                  case    aggopByteMax:
                     if(*(UINT16*)(OP_ARG1) == *(UINT16*)(OP_RES))
                        bRet = TRUE;
                     break;
                  case    aggopShortMin:
                  case    aggopShortMax:
                  case    aggopWordMin:
                  case    aggopWordMax:
                     if(*(UINT16*)(OP_ARG1) == *(UINT16*)(OP_RES))
                        bRet = TRUE;
                     break;
                  case aggopLongMin:
                  case aggopLongMax:
                  case aggopLongWordMin:
                  case aggopLongWordMax:
                     if(*(UINT32*)(OP_ARG1) == *(UINT32*)(OP_RES))
                        bRet = TRUE;
                     break;
                  case aggopLongIntMin:
                  case aggopLongIntMax:
                  case aggopU64Min:
                  case aggopU64Max:
                     if(*(UINT64*)(OP_ARG1) == *(UINT64*)(OP_RES))
                        bRet = TRUE;
                     break;
                  case aggopFloatMin:
                  case aggopFloatMax:
                     if( *(DFLOAT*)(OP_ARG1) == *(DFLOAT*)(OP_RES) )
                        bRet = TRUE;
                     break;
                  case aggopSingleMin:
                  case aggopSingleMax:
                     if( *(SINGLE*)(OP_ARG1) == *(SINGLE*)(OP_RES) )
                        bRet = TRUE;
                     break;
                  case aggopSqlTimestampMax:
                  case aggopSqlTimestampMin:
                     if( LsCompareSqlTimeStamp( OP_ARG1, OP_RES) == 0)
                        bRet = TRUE;  // recalculate
                     break;
                  case aggopSqlTimestampOffsetMax:
                  case aggopSqlTimestampOffsetMin:
                     if( LsCompareSqlTimeStampOffset( OP_ARG1, OP_RES) == 0)
                        bRet = TRUE;  // recalculate
                     break;
                  case aggopBcdMax:
                  case aggopBcdMin:
                     bcdToLongDouble(&d1, (TDecimal*) OP_ARG1);
                     bcdToLongDouble(&d2, (TDecimal*) OP_RES);
                     if( d1 == d2 )
                        bRet = TRUE;
                     break;
                  case aggopStringMax:
                  case aggopStringMin:
                     if( LangStrCmp(lcid,(pBYTE)OP_RES,(OP_ARG1)) == 0)
                        bRet = TRUE;
                     break;
                  case aggopUnicodeMax:
                  case aggopUnicodeMin:
                  {
                     UINT32 iLen1 = *(UINT16*) OP_ARG1;
                     UINT32 iLen2 = *(UINT16*) OP_RES;
                     if( memcmp( (void*)&OP_ARG1[sizeof(UINT16)],
                                 (void*)&OP_RES[sizeof(UINT16)],
                                  min(iLen1,iLen2) == 0 ) )
                        bRet = TRUE;
                     break;
                  }
                  case    aggopCount:
                     *(INT32*)(OP_RES) = iNonNullCount - 1;
                     break;
                  case    aggopCountAll:
                     *(INT32*)(OP_RES) = pAggValue->iCnt - 1;
                     break;
                  default:
                     break;
               }
               if( ( iNonNullCount - 1 == 0 )
                     && ( pElem->eAggFunc != aggopCount )
                     && ( pElem->eAggFunc != aggopCountAll )
               )
                  SETNULLVALUE(OP_RES_NULL, TRUE);
            }
         }
      }
      else // scalar operation:
      {
         if( pElem->eFuncType != CanIsNull )
         {
            if( pElem->iArg1NullOff && pElem->ppRecReg1
                 && ISNULLVALUE( OP_ARG1_NULL )
                 &&  pElem->eFuncType != CanBoolOr
                 &&  pElem->eFuncType != CanBoolAnd
                 &&  pElem->eFuncType != CanBoolNot
            )
               SETNULLVALUE( OP_RES_NULL, TRUE );
            else
               SETNULLVALUE( OP_RES_NULL, FALSE );

            if( pElem->ppRecReg2 && pElem->iArg2NullOff  
               &&  pElem->eFuncType != CanAssign 
               &&  pElem->eFuncType != CanBoolOr 
               &&  pElem->eFuncType != CanBoolAnd 
            )
            {
               if( ISNULLVALUE( OP_ARG2_NULL )  )
                  SETNULLVALUE( OP_RES_NULL, TRUE );
            }
         }

         switch( pElem->eFuncType )
         {
            case CanNoop:
               break;
            case CanFloatAdd:
               f1 = PtrToDFloat(OP_ARG1);
               f2 = PtrToDFloat(OP_ARG2);
               *(DFLOAT*)OP_RES = f1 + f2;
               break;
            case    CanFloatSubtract:
               f1 = PtrToDFloat(OP_ARG1);
               f2 = PtrToDFloat(OP_ARG2);
               *(DFLOAT*)OP_RES = f1 - f2;
               break;
            case    CanFloatDivide:
               f1 = PtrToDFloat(OP_ARG1);
               f2 = PtrToDFloat(OP_ARG2);
               if( f2 != 0.0 )
                  *(DFLOAT*)OP_RES = f1 / f2;
               else
                  SETNULLVALUE( OP_RES_NULL,  TRUE);
               break;
            case    CanFloatMultiply:
               f1 = PtrToDFloat(OP_ARG1);
               f2 = PtrToDFloat(OP_ARG2);
               *(DFLOAT*)OP_RES = f1 * f2;
               break;
            case    CanFloatEqual:
               BOOL b;
               DFLOAT f1High, f1Low;
               f1 = PtrToDFloat(OP_ARG1);
               f2 = PtrToDFloat(OP_ARG2);
               b = FALSE;
               if( f1 == f2 )
                  b = TRUE;
               else
               {
                  f1High = f1 + 1e-15;
                  f1Low = f1 - 1e-15;
                  if( (f2 > f1Low) && (f2 < f1High) )
                     b = TRUE;
               }
               *(BOOL16*) OP_RES = (BOOL16)b;
               break;
            case    CanFloatNotEqual:
               *(BOOL16*) OP_RES = PtrToDFloat(OP_ARG1) != PtrToDFloat(OP_ARG2);
               break;
            case    CanFloatLess:
               *(BOOL16*) OP_RES = PtrToDFloat(OP_ARG1) < PtrToDFloat(OP_ARG2);
               break;
            case    CanFloatLessEq:
               *(BOOL16*) OP_RES = PtrToDFloat(OP_ARG1) <= PtrToDFloat(OP_ARG2);
               break;
            case    CanFloatGreater:
            {
               *(BOOL16*) OP_RES = PtrToDFloat(OP_ARG1) > PtrToDFloat(OP_ARG2);
               break;
            }
            case    CanFloatGreaterEq:
               *(BOOL16*) OP_RES = PtrToDFloat(OP_ARG1) >= PtrToDFloat(OP_ARG2);
               break;
            case    CanFloatNegate:
               *(DFLOAT*) OP_RES = - (PtrToDFloat(OP_ARG1));
               break;
            case CanSingleAdd:
               f1 = *(SINGLE*)OP_ARG1;
               f2 = *(SINGLE*)OP_ARG2;
               *(SINGLE*)OP_RES = f1 + f2;
               break;
            case    CanSingleSubtract:
               f1 = *(SINGLE*)OP_ARG1;
               f2 = *(SINGLE*)OP_ARG2;
               *(SINGLE*)OP_RES = f1 - f2;
               break;
            case    CanSingleDivide:
               f1 = *(SINGLE*)OP_ARG1;
               f2 = *(SINGLE*)OP_ARG2;
               if( f2 != 0.0 )
                  *(SINGLE*)OP_RES = f1 / f2;
               else
                  SETNULLVALUE( OP_RES_NULL,  TRUE);
               break;
            case    CanSingleMultiply:
               f1 = *(SINGLE*)OP_ARG1;
               f2 = *(SINGLE*)OP_ARG2;
               *(SINGLE*)OP_RES = f1 * f2;
               break;
            case    CanSingleEqual:
               BOOL b2;
               FLOAT f2High, f2Low;
               f1 = *(SINGLE*)OP_ARG1;
               f2 = *(SINGLE*)OP_ARG2;
               b2 = FALSE;
               if( f1 == f2 )
                  b2 = TRUE;
               else
               {
                  f2High = f1 + 1e-7;
                  f2Low = f1 - 1e-7;
                  if( (f2 > f2Low) && (f2 < f2High) )
                     b2 = TRUE;
               }
               *(BOOL16*) OP_RES = (BOOL16)b2;
               break;
            case    CanSingleNotEqual:
               *(BOOL16*) OP_RES = *(SINGLE*)OP_ARG1 != *(SINGLE*)OP_ARG2;
               break;
            case    CanSingleLess:
               *(BOOL16*) OP_RES = *(SINGLE*)OP_ARG1 < *(SINGLE*)OP_ARG2;
               break;
            case    CanSingleLessEq:
               *(BOOL16*) OP_RES = *(SINGLE*)OP_ARG1 <= *(SINGLE*)OP_ARG2;
               break;
            case    CanSingleGreater:
            {
               *(BOOL16*) OP_RES = *(SINGLE*)OP_ARG1 > *(SINGLE*)OP_ARG2;
               break;
            }
            case    CanSingleGreaterEq:
               *(BOOL16*) OP_RES = *(SINGLE*)OP_ARG1 >= *(SINGLE*)OP_ARG2;
               break;
            case    CanSingleNegate:
               *(SINGLE*) OP_RES = - (*(SINGLE*)OP_ARG1);
               break;
            case    CanBoolAnd :
               *(BOOL16*) OP_RES = *(BOOL16*)OP_ARG1 && *(BOOL16*)OP_ARG2;
               break;
            case    CanBoolOr:
               *(BOOL16*) OP_RES = *(BOOL16*)OP_ARG1 || *(BOOL16*)OP_ARG2;
               break;
            case    CanBoolNot:
               *(BOOL16*) OP_RES = !( *(BOOL16*)OP_ARG1 );
               break;
            case    CanStringAdd:
            {
               UINT16  j, iLen;
               UINT16 iResLen;

               iLen = (UINT16) StrLen(OP_ARG1);
               if( ISNULLVALUE(((*pElem->ppRecReg1) + pElem->iArg1NullOff )))
                   iLen = 0;

               iResLen = (UINT16) (pElem->iResLen - 1);
               for(i=0; i < iLen && i < iResLen; i++ )
                  OP_RES[i] = OP_ARG1[i];

               if( ! ISNULLVALUE(((*pElem->ppRecReg2) + pElem->iArg2NullOff))
                  && OP_ARG2[0]
               )
                  for(i=iLen, j = 0; i < iResLen && j < pElem->iLen2; i++, j++ )
                     OP_RES[i] = OP_ARG2[j];

               if( i < iResLen )
                  OP_RES[i] = '\0';
               break;
            }
            case    CanStringEqual :
            {
               UINT16 iPartialLen = pElem->iPartialLen;
               BYTE c1, c2;        // Fixed Length fields behave as if iPartialLen
               if( !pElem->iPartialLen )   // set to up last space of either arg
                 if( pDS->pFieldDesc[pElem->iFldNum - 1].iFldSubType == fldstFIXED )
                 {
                    pElem->iPartialLen = MaxFixedCharLength((pCHAR) OP_ARG1, (pCHAR) OP_ARG2);
                    if (pElem->iPartialLen > pElem->iLen || pElem->iPartialLen > pElem->iLen2)
                      pElem->iPartialLen = iPartialLen;
                 }
               if( pElem->iPartialLen )
               {
                  c1 = OP_ARG1[pElem->iPartialLen];
                  OP_ARG1[pElem->iPartialLen] = '\0';
                  c2 = OP_ARG2[pElem->iPartialLen];
                  OP_ARG2[pElem->iPartialLen] = '\0';
               }

               if( pElem->bCaseInsensitive )
                  *(BOOL16*)OP_RES = ! LangStrCmpi(lcid, OP_ARG1, OP_ARG2);
               else
                  *(BOOL16*)OP_RES = ! LangStrCmp(lcid, OP_ARG1, OP_ARG2);

               if( pElem->iPartialLen )
               {
                  OP_ARG1[pElem->iPartialLen] = c1;
                  OP_ARG2[pElem->iPartialLen] = c2;
                  pElem->iPartialLen = iPartialLen;
               }

               break;
            }
            case    CanStringNotEqual :
            {
               BYTE  b;

               if( pElem->iPartialLen )
               {
                  if( pElem->bLeftIsField )
                  {
                     b = OP_ARG1[pElem->iPartialLen];
                     OP_ARG1[pElem->iPartialLen] = '\0';
                  }
                  else
                  {
                     b = OP_ARG2[pElem->iPartialLen];
                     OP_ARG2[pElem->iPartialLen] = '\0';
                  }
               }

               if( pElem->bCaseInsensitive )
                  *(BOOL16*)OP_RES = LangStrCmpi(lcid, OP_ARG1, OP_ARG2) != 0;
               else
                  *(BOOL16*)OP_RES = LangStrCmp(lcid, OP_ARG1, OP_ARG2) != 0;

               if( pElem->iPartialLen )
               {
                  if( pElem->bLeftIsField )
                     OP_ARG1[pElem->iPartialLen] = b;
                  else
                     OP_ARG2[pElem->iPartialLen] = b;
               }
               break;
            }
            case    CanStringLess :
            {
               if( pElem->bCaseInsensitive )
                  *(BOOL16*)OP_RES = ( LangStrCmpi(lcid, OP_ARG1, OP_ARG2) < 0 );
               else
                  *(BOOL16*)OP_RES = ( LangStrCmp(lcid, OP_ARG1, OP_ARG2) < 0 );
               break;
            }
            case    CanStringLessEq:
            {
               if( pElem->bCaseInsensitive )
                  *(BOOL16*)OP_RES = (LangStrCmpi(lcid, OP_ARG1, OP_ARG2) <= 0);
               else
                  *(BOOL16*)OP_RES = (LangStrCmp(lcid, OP_ARG1, OP_ARG2) <= 0);
               break;
            }
            case    CanStringGreater :
            {
               if( pElem->bCaseInsensitive )
                  *(BOOL16*)OP_RES = ( LangStrCmpi(lcid, OP_ARG1, OP_ARG2) > 0 );
               else
                  *(BOOL16*)OP_RES = ( LangStrCmp(lcid, OP_ARG1, OP_ARG2) > 0 );
               break;
            }
            case    CanStringGreaterEq:
            {
               if( pElem->bCaseInsensitive )
                  *(BOOL16*)OP_RES = (LangStrCmpi(lcid, OP_ARG1, OP_ARG2) >= 0 );
               else
                  *(BOOL16*)OP_RES = (LangStrCmp(lcid, OP_ARG1, OP_ARG2) >= 0 );
               break;
            }
            case    CanStringLower:
               for(i=0; i < pElem->iLen; i++ )
#ifdef _UNIX
                  OP_RES[i] = (unsigned char) tolower( (int) ((OP_ARG1)[i]));
#else
                  OP_RES[i] = *ToLower((pCHAR)&OP_ARG1[i]);
#endif
               if( i < pElem->iLen )
                  OP_RES[i] = '\0';
               break;
            case    CanStringUpper:
               for(i=0; OP_ARG1[i] && i < pElem->iLen; i++ )
#ifdef _UNIX
                  OP_RES[i] = (unsigned char) toupper( (int) ((OP_ARG1)[i]));
#else
                  OP_RES[i] = *ToUpper((pCHAR)&OP_ARG1[i]);
#endif
               if( i < pElem->iLen )
                  OP_RES[i] = '\0';
               break;
            case    CanSubstring2 :
            {
               pBYTE pS = (pBYTE) OP_ARG1;
               UINT16 start = (UINT16)(PtrToDFloat(OP_ARG2));
               UINT16 i = 0;

               if( start < pElem->iLen )
               {
                  pS += start - 1;
                  for( ; pS[i] && i < pElem->iLen ; i++ )
                     OP_RES[i] = pS[i];
               }
               OP_RES[i] = '\0';
               break;
            }
            case CanSubstring3:
            {
               pBYTE pS = (pBYTE) OP_ARG1;
               UINT16 start = (UINT16)(PtrToDFloat(OP_ARG2));
               UINT16 len;
               UINT16 i = 0;
               UINT16 iSrcLen = (UINT16) StrLen( pS );

               if( ISNULLVALUE( OP_ARG3_NULL )  )
               {
                  SETNULLVALUE( OP_RES_NULL, TRUE );
                  break;
               }

               len = (UINT16)(PtrToDFloat(OP_ARG3));

               if( start && iSrcLen >= start )
               {
                  pS += start - 1;
                  for(; pS[i] && i< len; i++ )
                     OP_RES[i] = pS[i];
               }
               OP_RES[i] = '\0';
               break;
            }
            case CanGetSqlTimestamp:
            {
               SYSTEMTIME datetime;
               GetLocalTime( &datetime );
               LsSqlTimeStampEncode( (SQLTIMESTAMP*)OP_RES,
                                    (INT16)datetime.wYear,
                                    (UINT16)datetime.wMonth,
                                    (UINT16)datetime.wDay,
                                    (UINT16)datetime.wHour,
                                    (UINT16)datetime.wMinute,
                                    (UINT16)datetime.wSecond,
                                    (UINT32) 0);
               break;
            }
            case CanGetSqlTimestampOffset:
            {
               SYSTEMTIME datetime;
               GetLocalTime( &datetime );
               LsSqlTimeStampOffsetEncode( (SQLTIMESTAMPOFFSET*)OP_RES,
                                    (INT16)datetime.wYear,
                                    (UINT16)datetime.wMonth,
                                    (UINT16)datetime.wDay,
                                    (UINT16)datetime.wHour,
                                    (UINT16)datetime.wMinute,
                                    (UINT16)datetime.wSecond,
                                    (UINT32) 0,
                                    (INT16) 0,
                                    (INT16) 0);
               break;
            }
            case CanGetDateTime:
            {
               SYSTEMTIME datetime;
               DBIDATE  date;
               TIME     time;
               GetLocalTime( &datetime );
               date = LsDateEncode( (UINT16)datetime.wMonth,
                                    (UINT16)datetime.wDay,
                                    (UINT16)datetime.wYear );

               LsTimeEncode( (UINT16)datetime.wHour,
                             (UINT16)datetime.wMinute,
                             (UINT16)datetime.wSecond, &time );

               LsTimeStampEncode( date, time, (TIMESTAMP*)OP_RES );

               break;
            }
            // TRIM funcs
            case    CanTrimLead:
            {
               pBYTE pS = (pBYTE) OP_ARG1;
               UINT16 i = 0, j;
               BYTE  tVal = pElem->ppRecReg2 ? OP_ARG2[0] : ' ';

               for( ; pS[i] && i < pElem->iLen ; i++ )
                  if( pS[i] != tVal )
                     break;
               j = 0;
               for( ; pS[i] && i < pElem->iLen ; i++ )
                  OP_RES[j++] = pS[i];

               OP_RES[j] = '\0';
               break;
            }
            case    CanTrimTrail:
            {
               pBYTE pS = (pBYTE) OP_ARG1;
               UINT32 i;
               BYTE  tVal = pElem->ppRecReg2 ? OP_ARG2[0] : ' ';

               for( i=0; pS[i] && i < pElem->iResLen; i++ )
                  OP_RES[i] = pS[i];
               OP_RES[i] = '\0';

               while( i-- && OP_RES[i] == tVal )
                  OP_RES[i] = '\0';
               break;
            }
            case    CanTrimBoth:
            {
               pBYTE pS = (pBYTE) OP_ARG1;
               UINT16 i, j;
               BYTE  tVal = pElem->ppRecReg2 ? OP_ARG2[0] : ' ';

               for( i=0; pS[i] && pS[i] == tVal; i++)
                  ;

               if( pS[i] )
               {
                  for(j = 0; pS[i] ; i++, j++)
                     OP_RES[j] = pS[i];
                  OP_RES[j] = '\0';

                  while( j-- && OP_RES[j] == tVal )
                     OP_RES[j] = '\0';
               }
               else
                  OP_RES[0] = '\0';
               break;
            }
            case    CanLongSubtract :
               f1 = (DFLOAT)( *(INT32*)OP_ARG1 );
               f2 = (DFLOAT)( *(INT32*)OP_ARG2 );
               fRes = f1 - f2;
               if( fRes > 0x7FFFFFFF || fRes < -2147483647L )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(INT32*)OP_RES = (INT32) fRes;
               break;
            case    CanLongAdd :
               f1 = (DFLOAT)( *(INT32*)OP_ARG1 );
               f2 = (DFLOAT)( *(INT32*)OP_ARG2 );
               fRes = f1 + f2;
               if( fRes > 0x7FFFFFFF || fRes < -2147483647L )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(INT32*)OP_RES = (INT32) fRes;
               break;
            case    CanLongMultiply:
               f1 = (DFLOAT)( *(INT32*)OP_ARG1 );
               f2 = (DFLOAT)( *(INT32*)OP_ARG2 );
               fRes = f1 * f2;
               if( fRes > 0x7FFFFFFF || fRes < -2147483647L )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(INT32*)OP_RES = (INT32) fRes;
               break;
            case    CanLongDivide :
            {
               // TODO: detect overflow, throw exception
               INT32 l = *(INT32*)OP_ARG2;
               if( l != 0L )
               {
                  FLOAT f1, f2, fRes;
                  f1 = (FLOAT)( *(INT32*)OP_ARG1 );
                  f2 = (FLOAT)( *(INT32*)OP_ARG2 );
                  if( f2 != 0.0 )
                  {
                     fRes = f1 / f2;
                     if( fRes > 0x7FFFFFFF || fRes < -2147483647L )
                        SETNULLVALUE( OP_RES_NULL  ,  TRUE);
                     else
                        *(INT32*)OP_RES = (INT32) fRes;
                  }
                  else
                     SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               }
               else
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               break;
            }
            case    CanLongEqual :
               *(BOOL16*)OP_RES = *(INT32*)OP_ARG1 == *(INT32*)OP_ARG2;
               break;
            case    CanLongNotEqual :
               *(BOOL16*)OP_RES = *(INT32*)OP_ARG1 != *(INT32*)OP_ARG2;
               break;
            case    CanLongLess :
               *(BOOL16*)OP_RES = *(INT32*)OP_ARG1 < *(INT32*)OP_ARG2;
               break;
            case    CanLongLessEq:
               *(BOOL16*)OP_RES = *(INT32*)OP_ARG1 <= *(INT32*)OP_ARG2;
               break;
            case    CanLongGreater :
               *(BOOL16*)OP_RES = *(INT32*)OP_ARG1 > *(INT32*)OP_ARG2;
               break;
            case    CanLongGreaterEq :
               *(BOOL16*)OP_RES = *(INT32*)OP_ARG1 >= *(INT32*)OP_ARG2;
               break;
            case    CanLongNegate :
               *(INT32*)OP_RES = - (*(INT32*)OP_ARG1);
               break;
            case    CanShortSubtract:
               f1 = (DFLOAT)( *(INT16*)OP_ARG1 );
               f2 = (DFLOAT)( *(INT16*)OP_ARG2 );
               fRes = f1 - f2;
               if( fRes > 0x7FFF || fRes < -32768 )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(INT16*)OP_RES = (INT16) fRes;
               break;
            case    CanShortAdd :
               f1 = (DFLOAT)( *(INT16*)OP_ARG1 );
               f2 = (DFLOAT)( *(INT16*)OP_ARG2 );
               fRes = f1 + f2;
               if( fRes > 0x7FFF || fRes < -32768 )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(INT16*)OP_RES = (INT16) fRes;
               break;
            case    CanShortMultiply :
               // TODO: detect overflow, throw exception
               f1 = (DFLOAT)( *(INT16*)OP_ARG1 );
               f2 = (DFLOAT)( *(INT16*)OP_ARG2 );
               fRes = f1 * f2;
               if( fRes > 0x7FFF || fRes < -32768 )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(INT16*)OP_RES = (INT16) fRes;
               break;
            case    CanShortDivide :
            {
               INT16 i = *(INT16*)OP_ARG2;
               if( i != 0 )
               {
                  f1 = (DFLOAT)( *(INT16*)OP_ARG1 );
                  f2 = (DFLOAT)( *(INT16*)OP_ARG2 );
                  if( f2 != 0.0 )
                  fRes = f1 / f2;
                  if( fRes > 0x7FFF || fRes < -32768 )
                              SETNULLVALUE( OP_RES_NULL  ,  TRUE);
                  else
                     *(INT16*)OP_RES = (INT16) fRes;
               }
               else
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               break;
            }
            case    CanShortEqual :
               *(BOOL16*)OP_RES = *(INT16*)OP_ARG1 == *(INT16*)OP_ARG2;
               break;
            case    CanShortNotEqual :
               *(BOOL16*)OP_RES = *(INT16*)OP_ARG1 != *(INT16*)OP_ARG2;
               break;
            case    CanShortLess :
               *(BOOL16*)OP_RES = *(INT16*)OP_ARG1 < *(INT16*)OP_ARG2;
               break;
            case    CanShortLessEq :
               *(BOOL16*)OP_RES = *(INT16*)OP_ARG1 <= *(INT16*)OP_ARG2;
               break;
            case    CanShortGreater :
               *(BOOL16*)OP_RES = *(INT16*)OP_ARG1 > *(INT16*)OP_ARG2;
               break;
            case    CanShortGreaterEq :
               *(BOOL16*)OP_RES = *(INT16*)OP_ARG1 >= *(INT16*)OP_ARG2;
               break;
            case    CanShortNegate :
               *(INT16*)OP_RES = (INT16) (-( *(INT16*)OP_ARG1 ));
               break;
// unsigned 32 bit suppots
            case    CanLongWordSubtract:
               f1 = (DFLOAT)( *(UINT32*)OP_ARG1 );
               f2 = (DFLOAT)( *(UINT32*)OP_ARG2 );
               fRes = f1 - f2;
               if( fRes > 0xFFFFFFFF || fRes < 0 )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(UINT32*)OP_RES = (UINT32) fRes;
               break;
            case    CanLongWordAdd :
               f1 = (DFLOAT)( *(UINT32*)OP_ARG1 );
               f2 = (DFLOAT)( *(UINT32*)OP_ARG2 );
               fRes = f1 + f2;
               if( fRes > 0xFFFFFFFF || fRes < 0 )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(UINT32*)OP_RES = (UINT32) fRes;
               break;
            case    CanLongWordEqual :
               *(BOOL16*)OP_RES = *(UINT32*)OP_ARG1 == *(UINT32*)OP_ARG2;
               break;
            case    CanLongWordNotEqual :
               *(BOOL16*)OP_RES = *(UINT32*)OP_ARG1 != *(UINT32*)OP_ARG2;
               break;
            case    CanLongWordLess :
               *(BOOL16*)OP_RES = *(UINT32*)OP_ARG1 < *(UINT32*)OP_ARG2;
               break;
            case    CanLongWordLessEq :
               *(BOOL16*)OP_RES = *(UINT32*)OP_ARG1 <= *(UINT32*)OP_ARG2;
               break;
            case    CanLongWordGreater :
               *(BOOL16*)OP_RES = *(UINT32*)OP_ARG1 > *(UINT32*)OP_ARG2;
               break;
            case    CanLongWordGreaterEq :
               *(BOOL16*)OP_RES = *(UINT32*)OP_ARG1 >= *(UINT32*)OP_ARG2;
               break;
// unsigned 16 bit suppots
            case    CanWordSubtract:
               f1 = (DFLOAT)( *(UINT16*)OP_ARG1 );
               f2 = (DFLOAT)( *(UINT16*)OP_ARG2 );
               fRes = f1 - f2;
               if( fRes > 0xFFFF || fRes < 0 )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(UINT16*)OP_RES = (UINT16) fRes;
               break;
            case    CanWordAdd :
               f1 = (DFLOAT)( *(UINT16*)OP_ARG1 );
               f2 = (DFLOAT)( *(UINT16*)OP_ARG2 );
               fRes = f1 + f2;
               if( fRes > 0xFFFF || fRes < 0 )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(UINT16*)OP_RES = (UINT16) fRes;
               break;
            case    CanWordEqual :
               *(BOOL16*)OP_RES = *(UINT16*)OP_ARG1 == *(UINT16*)OP_ARG2;
               break;
            case    CanWordNotEqual :
               *(BOOL16*)OP_RES = *(UINT16*)OP_ARG1 != *(UINT16*)OP_ARG2;
               break;
            case    CanWordLess :
               *(BOOL16*)OP_RES = *(UINT16*)OP_ARG1 < *(UINT16*)OP_ARG2;
               break;
            case    CanWordLessEq :
               *(BOOL16*)OP_RES = *(UINT16*)OP_ARG1 <= *(UINT16*)OP_ARG2;
               break;
            case    CanWordGreater :
               *(BOOL16*)OP_RES = *(UINT16*)OP_ARG1 > *(UINT16*)OP_ARG2;
               break;
            case    CanWordGreaterEq :
               *(BOOL16*)OP_RES = *(UINT16*)OP_ARG1 >= *(UINT16*)OP_ARG2;
               break;
// signed 8 bit suppots
            case    CanShortIntSubtract:
               f1 = (DFLOAT)( *(INT8*)OP_ARG1 );
               f2 = (DFLOAT)( *(INT8*)OP_ARG2 );
               fRes = f1 - f2;
               if( fRes > 0x7F || fRes < -128 )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(INT8*)OP_RES = (INT8) fRes;
               break;
            case    CanShortIntAdd :
               f1 = (DFLOAT)( *(INT8*)OP_ARG1 );
               f2 = (DFLOAT)( *(INT8*)OP_ARG2 );
               fRes = f1 + f2;
               if( fRes > 0x7F || fRes < -128 )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(INT8*)OP_RES = (INT8) fRes;
               break;
            case    CanShortIntEqual :
               *(BOOL16*)OP_RES = *(INT8*)OP_ARG1 == *(INT8*)OP_ARG2;
               break;
            case    CanShortIntNotEqual :
               *(BOOL16*)OP_RES = *(INT8*)OP_ARG1 != *(INT8*)OP_ARG2;
               break;
            case    CanShortIntLess :
               *(BOOL16*)OP_RES = *(INT8*)OP_ARG1 < *(INT8*)OP_ARG2;
               break;
            case    CanShortIntLessEq :
               *(BOOL16*)OP_RES = *(INT8*)OP_ARG1 <= *(INT8*)OP_ARG2;
               break;
            case    CanShortIntGreater :
               *(BOOL16*)OP_RES = *(INT8*)OP_ARG1 > *(INT8*)OP_ARG2;
               break;
            case    CanShortIntGreaterEq :
               *(BOOL16*)OP_RES = *(INT8*)OP_ARG1 >= *(INT8*)OP_ARG2;
               break;
            case    CanShortIntNegate :
               *(INT8*)OP_RES = (INT8) (-( *(INT8*)OP_ARG1 ));
               break;
// unsigned 8 bit suppots
            case    CanByteSubtract:
               f1 = (DFLOAT)( *(UINT8*)OP_ARG1 );
               f2 = (DFLOAT)( *(UINT8*)OP_ARG2 );
               fRes = f1 - f2;
               if( fRes > 0xFF || fRes < 0 )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(UINT8*)OP_RES = (UINT8) fRes;
               break;
            case    CanByteAdd :
               f1 = (DFLOAT)( *(UINT8*)OP_ARG1 );
               f2 = (DFLOAT)( *(UINT8*)OP_ARG2 );
               fRes = f1 + f2;
               if( fRes > 0xFF || fRes < 0 )
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(UINT8*)OP_RES = (UINT8) fRes;
               break;
            case    CanByteEqual :
               *(BOOL16*)OP_RES = *(UINT8*)OP_ARG1 == *(UINT8*)OP_ARG2;
               break;
            case    CanByteNotEqual :
               *(BOOL16*)OP_RES = *(UINT8*)OP_ARG1 != *(UINT8*)OP_ARG2;
               break;
            case    CanByteLess :
               *(BOOL16*)OP_RES = *(UINT8*)OP_ARG1 < *(UINT8*)OP_ARG2;
               break;
            case    CanByteLessEq :
               *(BOOL16*)OP_RES = *(UINT8*)OP_ARG1 <= *(UINT8*)OP_ARG2;
               break;
            case    CanByteGreater :
               *(BOOL16*)OP_RES = *(UINT8*)OP_ARG1 > *(UINT8*)OP_ARG2;
               break;
            case    CanByteGreaterEq :
               *(BOOL16*)OP_RES = *(UINT8*)OP_ARG1 >= *(UINT8*)OP_ARG2;
               break;
// Date
            case   CanDateShortAdd :
               *(DBIDATE*)OP_RES = *(DBIDATE*)OP_ARG1 + *(INT16*)OP_ARG2;
               break;
            case   CanDateLongAdd :
               *(DBIDATE*)OP_RES = *(DBIDATE*)OP_ARG1 + *(INT32*)OP_ARG2;
               break;
            case   CanDateSubtract:
               *(DFLOAT*)OP_RES = (DFLOAT) (*(DBIDATE*)OP_ARG1 - *(DBIDATE*)OP_ARG2);
               break;
            case   CanDateFloatAdd:
               *(DBIDATE*)OP_RES = *(DBIDATE*)OP_ARG1 + (DBIDATE)(*(DFLOAT*)OP_ARG2);
               break;
            case   CanDateFloatSubtract:
               *(DBIDATE*)OP_RES = *(DBIDATE*)OP_ARG1 - (DBIDATE)(*(DFLOAT*)OP_ARG2);
               break;
            case   CanFloatDateAdd:
               *(DBIDATE*)OP_RES = *(DBIDATE*)OP_ARG2 + (DBIDATE)(*(DFLOAT*)OP_ARG1);
               break;
            case   CanDatetimeShortAdd:
               *(TIMESTAMP*)OP_RES = *(TIMESTAMP*)OP_ARG1
                           + ( *(INT16*)OP_ARG2 * MILSECSPERDAY );
               break;
            case   CanSqlTimestampShortAdd:
               *(SQLTIMESTAMP*)OP_RES = *(SQLTIMESTAMP*)OP_ARG1;
               SqlTimeStampAddition( (SQLTIMESTAMP*)OP_RES,
                              (double)( *(INT16*)OP_ARG2) );
               break;
            case   CanSqlTimestampOffsetShortAdd:
               *(SQLTIMESTAMPOFFSET*)OP_RES = *(SQLTIMESTAMPOFFSET*)OP_ARG1;
               SqlTimeStampOffsetAddition( (SQLTIMESTAMPOFFSET*)OP_RES,
                              (double)( *(INT16*)OP_ARG2) );
               break;
            case   CanDatetimeLongAdd:
               *(TIMESTAMP*)OP_RES = *(TIMESTAMP*)OP_ARG1
                             + ( *(INT32*)OP_ARG2 * MILSECSPERDAY );
               break;
            case   CanSqlTimestampLongAdd:
               *(SQLTIMESTAMP*)OP_RES = *(SQLTIMESTAMP*)OP_ARG1;
               SqlTimeStampAddition( (SQLTIMESTAMP*)OP_RES,
                             (double)( *(INT32*)OP_ARG2) );
               break;
            case   CanSqlTimestampOffsetLongAdd:
               *(SQLTIMESTAMPOFFSET*)OP_RES = *(SQLTIMESTAMPOFFSET*)OP_ARG1;
               SqlTimeStampOffsetAddition( (SQLTIMESTAMPOFFSET*)OP_RES,
                             (double)( *(INT32*)OP_ARG2) );
               break;
            case   CanDatetimeFloatAdd:
               *(TIMESTAMP*)OP_RES = *(TIMESTAMP*)OP_ARG1
                             + ( PtrToDFloat(OP_ARG2) * MILSECSPERDAY );
               break;
            case   CanSqlTimestampFloatAdd:
               *(SQLTIMESTAMP*)OP_RES = *(SQLTIMESTAMP*)OP_ARG1;
               SqlTimeStampAddition( (SQLTIMESTAMP*)OP_RES,
                             (PtrToDFloat(OP_ARG2)));
               break;
            case   CanSqlTimestampOffsetFloatAdd:
               *(SQLTIMESTAMPOFFSET*)OP_RES = *(SQLTIMESTAMPOFFSET*)OP_ARG1;
               SqlTimeStampOffsetAddition( (SQLTIMESTAMPOFFSET*)OP_RES,
                             (PtrToDFloat(OP_ARG2)));
               break;
            case   CanDatetimeFloatSubtract:
               *(TIMESTAMP*)OP_RES = *(TIMESTAMP*)OP_ARG1
                             - ( PtrToDFloat(OP_ARG2) * MILSECSPERDAY );
               break;
            case CanSqlTimestampLess:
            case CanSqlTimestampGreater:
            case CanSqlTimestampLessEq:
            case CanSqlTimestampGreaterEq:
            case CanSqlTimestampNotEqual:
            case CanSqlTimestampEqual:
            {
               INT32 iComp = LsCompareSqlTimeStamp(
                    OP_ARG1, OP_ARG2);
               switch( pElem->eFuncType )
               {
                  case CanSqlTimestampLess:
                     *(BOOL16*) OP_RES = (BOOL16)(iComp < 0 );
                     break;
                  case CanSqlTimestampGreater:
                     *(BOOL16*) OP_RES = (BOOL16)(iComp > 0 );
                     break;
                  case CanSqlTimestampLessEq:
                     *(BOOL16*) OP_RES = (BOOL16)(iComp <= 0 );
                     break;
                  case CanSqlTimestampGreaterEq:
                     *(BOOL16*) OP_RES = (BOOL16)(iComp >= 0 );
                     break;
                  case CanSqlTimestampNotEqual:
                     *(BOOL16*) OP_RES = (BOOL16)(iComp != 0 );
                     break;
                  case CanSqlTimestampEqual:
                     *(BOOL16*) OP_RES = (BOOL16)(iComp == 0 );
                     break;
                  default:
                     break;
               }
               break;
            }
            case   CanSqlTimestampFloatSubtract:
               *(SQLTIMESTAMP*)OP_RES = *(SQLTIMESTAMP*)OP_ARG1;
               SqlTimeStampAddition( (SQLTIMESTAMP*)OP_RES,
                             -(PtrToDFloat(OP_ARG2)) );
               break;
            case CanSqlTimestampOffsetLess:
            case CanSqlTimestampOffsetGreater:
            case CanSqlTimestampOffsetLessEq:
            case CanSqlTimestampOffsetGreaterEq:
            case CanSqlTimestampOffsetNotEqual:
            case CanSqlTimestampOffsetEqual:
            {
               INT32 iComp = LsCompareSqlTimeStampOffset(
                    OP_ARG1, OP_ARG2);
               switch( pElem->eFuncType )
               {
                  case CanSqlTimestampOffsetLess:
                     *(BOOL16*) OP_RES = (BOOL16)(iComp < 0 );
                     break;
                  case CanSqlTimestampOffsetGreater:
                     *(BOOL16*) OP_RES = (BOOL16)(iComp > 0 );
                     break;
                  case CanSqlTimestampOffsetLessEq:
                     *(BOOL16*) OP_RES = (BOOL16)(iComp <= 0 );
                     break;
                  case CanSqlTimestampOffsetGreaterEq:
                     *(BOOL16*) OP_RES = (BOOL16)(iComp >= 0 );
                     break;
                  case CanSqlTimestampOffsetNotEqual:
                     *(BOOL16*) OP_RES = (BOOL16)(iComp != 0 );
                     break;
                  case CanSqlTimestampOffsetEqual:
                     *(BOOL16*) OP_RES = (BOOL16)(iComp == 0 );
                     break;
                  default:
                     break;
               }
               break;
            }
            case   CanSqlTimestampOffsetFloatSubtract:
               *(SQLTIMESTAMPOFFSET*)OP_RES = *(SQLTIMESTAMPOFFSET*)OP_ARG1;
               SqlTimeStampOffsetAddition( (SQLTIMESTAMPOFFSET*)OP_RES,
                             -(PtrToDFloat(OP_ARG2)) );
               break;
            case CanTimeFloatSubtract:
               *(TIME*)OP_RES = *(TIME*)OP_ARG1
                             - ( PtrToDFloat(OP_ARG2) * MILSECSPERHOUR );
               break;
            case   CanFloatDatetimeAdd:
               *(TIMESTAMP*)OP_RES = *(TIMESTAMP*)OP_ARG2
                             + ( PtrToDFloat(OP_ARG1) * MILSECSPERDAY );
               break;
            case   CanFloatSqlTimestampAdd:
               *(SQLTIMESTAMP*)OP_RES = *(SQLTIMESTAMP*)OP_ARG2;
               SqlTimeStampAddition( (SQLTIMESTAMP*)OP_RES,
                             (PtrToDFloat(OP_ARG1)));
               break;
            case   CanFloatSqlTimestampOffsetAdd:
               *(SQLTIMESTAMPOFFSET*)OP_RES = *(SQLTIMESTAMPOFFSET*)OP_ARG2;
               SqlTimeStampOffsetAddition( (SQLTIMESTAMPOFFSET*)OP_RES,
                             (PtrToDFloat(OP_ARG1)));
               break;
            case   CanDatetimeSubtract:
            {
               DFLOAT diff = (DFLOAT) (*(TIMESTAMP*)OP_ARG1 - *(TIMESTAMP*)OP_ARG2);
               *(DFLOAT*)OP_RES = diff / MILSECSPERDAY;
               break;
            }
            case CanSqlTimestampSubtract:
            {
               TIMESTAMP Ts1 = 0, Ts2 = 0;
               if( OP_ARG1 )
                  LsSqlTimeStampToTimeStamp( (SQLTIMESTAMP*)OP_ARG1, &Ts1 );
               if( OP_ARG2 )
                  LsSqlTimeStampToTimeStamp( (SQLTIMESTAMP*)OP_ARG2, &Ts2 );
               DFLOAT diff = (DFLOAT) ((Ts1) - (Ts2 ));
               *(DFLOAT*)OP_RES = diff / MILSECSPERDAY;
               break;
            }
            case CanSqlTimestampOffsetSubtract:
            {
               TIMESTAMP Ts1 = 0, Ts2 = 0;
               if( OP_ARG1 )
                  LsSqlTimeStampOffsetToTimeStamp( (SQLTIMESTAMPOFFSET*)OP_ARG1, &Ts1 );
               if( OP_ARG2 )
                  LsSqlTimeStampOffsetToTimeStamp( (SQLTIMESTAMPOFFSET*)OP_ARG2, &Ts2 );
               DFLOAT diff = (DFLOAT) ((Ts1) - (Ts2 ));
               *(DFLOAT*)OP_RES = diff / MILSECSPERDAY;
               break;
            }
            case   CanTimeShortAdd :
               *(TIME*)OP_RES = *(TIME*)OP_ARG1 + (*(INT16*)OP_ARG2 * MILSECSPERDAY) ;
               break;
            case   CanTimeLongAdd :
               *(TIME*)OP_RES = *(TIME*)OP_ARG1 + (*(INT32*)OP_ARG2 * MILSECSPERDAY) ;
               break;
            case   CanTimeFloatAdd :
               *(TIME*)OP_RES = *(TIME*)OP_ARG1 + (PtrToDFloat(OP_ARG2) * MILSECSPERHOUR) ;
               break;
            case   CanFloatTimeAdd :
               *(TIME*)OP_RES = *(TIME*)OP_ARG2 + (PtrToDFloat(OP_ARG1) * MILSECSPERDAY) ;
               break;
            case   CanBoolEqStr :
            {
               bool bBoolVal = !StrCmpI( OP_ARG2, (pBYTE) "TRUE" );
               *(BOOL16*)OP_RES = (bool)(*(BOOL16*)OP_ARG1) == bBoolVal;
               break;
            }
            case   CanStrEqBool :
            {
               bool bBoolVal = !StrCmpI( OP_ARG1, (pBYTE) "TRUE" );
               *(BOOL16*)OP_RES = (bool)(*(BOOL16*)OP_ARG2) == bBoolVal;
               break;
            }
            case   CanBoolNotEqStr :
            {
               bool bBoolVal = !StrCmpI( OP_ARG2, (pBYTE) "TRUE" );
               *(BOOL16*)OP_RES = (bool)(*(BOOL16*)OP_ARG1) != bBoolVal;
               break;
            }
            case   CanStrNotEqBool :
            {
               bool bBoolVal = !StrCmpI( OP_ARG1, (pBYTE) "TRUE" );
               *(BOOL16*)OP_RES = (bool)*(BOOL16*)OP_ARG2 != bBoolVal;
               break;
            }
            case  CanStrToBool :
               *(BOOL16*)OP_RES = !StrCmpI( OP_ARG1, (pBYTE) "TRUE" );
               break;
            case   CanBoolEq :
               *(BOOL16*) OP_RES = (bool)*(BOOL16*)OP_ARG1 == (bool)*(BOOL16*)OP_ARG2;
               break;
            case   CanBoolNotEq :
               *(BOOL16*) OP_RES = (bool)*(BOOL16*)OP_ARG1 != (bool)*(BOOL16*)OP_ARG2;
               break;
            case    CanExtractYearFromDate :
            {
               INT16 iYear;
               UINT16 iMon;
               UINT16 iDay;
               LsDateDecode( *(DBIDATE*) OP_ARG1, &iMon, &iDay , &iYear);
               *(DFLOAT*)OP_RES = (DFLOAT)iYear;
               break;
            }
            case    CanExtractYearFromTS :
            {
               DBIDATE date;
               TIME time;
               INT16 iYear;
               UINT16 iMon;
               UINT16 iDay;
               LsTimeStampDecode (  *(TIMESTAMP*) OP_ARG1, &date, &time );
               LsDateDecode( date,  &iMon, &iDay, &iYear );
               *(DFLOAT*)OP_RES = (DFLOAT)iYear;
               break;
            }
            case CanExtractYearFromSQLTS :
            {
               *(DFLOAT*)OP_RES = (DFLOAT)((*(SQLTIMESTAMP*)OP_ARG1).year);
               break;
            }
            case CanExtractYearFromSQLTSOS :
            {
               *(DFLOAT*)OP_RES = (DFLOAT)((*(SQLTIMESTAMPOFFSET*)OP_ARG1).year);
               break;
            }
            case    CanExtractMonthFromDate :
            {
               UINT16 month;
               UINT16 iDay;
               INT16 iYear;
               LsDateDecode( *(DBIDATE*) OP_ARG1, &month, &iDay, &iYear );
               *(DFLOAT*)OP_RES = (DFLOAT)month;
               break;
            }
            case  CanExtractMonthFromTS :
            {
               DBIDATE date;
               TIME time;
               UINT16 month;
               UINT16 iDay;
               INT16 iYear;
               LsTimeStampDecode(  *(TIMESTAMP*) OP_ARG1, &date, &time );
               LsDateDecode( date, &month, &iDay, &iYear );
               *(DFLOAT*)OP_RES = (DFLOAT)month;
               break;
            }
            case CanExtractMonthFromSQLTS :
            {
               *(DFLOAT*)OP_RES = (DFLOAT)((*(SQLTIMESTAMP*)OP_ARG1).month);
               break;
            }
            case CanExtractMonthFromSQLTSOS :
            {
               *(DFLOAT*)OP_RES = (DFLOAT)((*(SQLTIMESTAMPOFFSET*)OP_ARG1).month);
               break;
            }
            case  CanExtractDayFromDate :
            {
               UINT16 iMon;
               UINT16 iDay;
               INT16 iYear;
               LsDateDecode( *(DBIDATE*) OP_ARG1, &iMon, &iDay, &iYear );
               *(DFLOAT*)OP_RES = (DFLOAT)iDay;
               break;
            }
            case  CanExtractDayFromTS :
            {
               DBIDATE date;
               TIME time;
               UINT16 iDay;
               UINT16 iMon;
               INT16 iYear;
               LsTimeStampDecode(  *(TIMESTAMP*) OP_ARG1, &date, &time );
               LsDateDecode( date, &iMon, &iDay,  &iYear );
               *(DFLOAT*)OP_RES = (DFLOAT)iDay;
               break;
            }
            case CanExtractDayFromSQLTS :
            {
               *(DFLOAT*)OP_RES = (DFLOAT)((*(SQLTIMESTAMP*)OP_ARG1).day);
               break;
            }
            case CanExtractDayFromSQLTSOS :
            {
               *(DFLOAT*)OP_RES = (DFLOAT)((*(SQLTIMESTAMPOFFSET*)OP_ARG1).day);
               break;
            }
            case  CanExtractHourFromTS :
            {
               DBIDATE date;
               TIME time;
               UINT16 hour;
               UINT16 iMin;
               UINT16 iSecs;
               LsTimeStampDecode(  *(TIMESTAMP*) OP_ARG1, &date, &time );
               LsTimeDecode( time, &hour, &iMin, &iSecs );
               *(DFLOAT*)OP_RES = (DFLOAT)hour;
               break;
            }
            case CanExtractHourFromSQLTS :
            {
               *(DFLOAT*)OP_RES = (DFLOAT)((*(SQLTIMESTAMP*)OP_ARG1).hour);
               break;
            }
            case CanExtractHourFromSQLTSOS :
            {
               *(DFLOAT*)OP_RES = (DFLOAT)((*(SQLTIMESTAMPOFFSET*)OP_ARG1).hour);
               break;
            }
            case  CanExtractHourFromTime :
            {
               UINT16 hour;
               UINT16 iMin;
               UINT16 iSecs;
               LsTimeDecode( *(TIME*) OP_ARG1, &hour, &iMin, &iSecs );
               *(DFLOAT*)OP_RES = (DFLOAT)hour;
               break;
            }
            case  CanExtractMinFromTS :
            {
               DBIDATE date;
               TIME time;
               UINT16 iMin;
               UINT16 hour;
               UINT16 iSecs;
               LsTimeStampDecode(  *(TIMESTAMP*) OP_ARG1, &date, &time );
               LsTimeDecode( time, &hour, &iMin, &iSecs );
               *(DFLOAT*)OP_RES = (DFLOAT)iMin;
               break;
            }
            case CanExtractMinFromSQLTS :
            {
               *(DFLOAT*)OP_RES = (DFLOAT)((*(SQLTIMESTAMP*)OP_ARG1).minute);
               break;
            }
            case CanExtractMinFromSQLTSOS :
            {
               *(DFLOAT*)OP_RES = (DFLOAT)((*(SQLTIMESTAMPOFFSET*)OP_ARG1).minute);
               break;
            }
            case  CanExtractMinFromTime :
            {
               UINT16 iMin;
               UINT16 hour;
               UINT16 iSecs;
               LsTimeDecode( *(TIME*) OP_ARG1, &hour, &iMin, &iSecs );
               *(DFLOAT*)OP_RES = (DFLOAT)iMin;
               break;
            }
            case  CanExtractSecFromTS :
            {
               DBIDATE date;
               TIME    time;
               UINT16 iMin;
               UINT16 hour;
               UINT16  iSec;
               LsTimeStampDecode( *(TIMESTAMP*) OP_ARG1, &date, &time );
               LsTimeDecode( time, &hour, &iMin, &iSec );
               *(DFLOAT*)OP_RES = (DFLOAT)iSec / 1000;
               break;
            }
            case CanExtractSecFromSQLTS :
            {
               *(DFLOAT*)OP_RES = (DFLOAT)((*(SQLTIMESTAMP*)OP_ARG1).second);
               break;
            }
            case CanExtractSecFromSQLTSOS :
            {
               *(DFLOAT*)OP_RES = (DFLOAT)((*(SQLTIMESTAMPOFFSET*)OP_ARG1).second);
               break;
            }
            case  CanExtractSecFromTime :
            {
               UINT16  iSec;
               UINT16 iMin;
               UINT16 hour;
               LsTimeDecode( *(TIME*) OP_ARG1, &hour, &iMin, &iSec );
               *(DFLOAT*)OP_RES = (DFLOAT)iSec / 1000;
               break;
            }
            case CanIN:
            {
               if( pElem->pArgList )
               {
                  pQCanExecElem pElemArg;
                  *(BOOL16*) OP_RES = FALSE;
                  ForEachInSet( pElem->pArgList, pElemArg )
                  {
                     if( pElemArg->iFldType == fldZSTRING )
                     {
                        pBYTE pCur = (*pElemArg->ppRecRegRes) + pElemArg->iResOff;
                        if( !LangStrCmp(lcid, OP_ARG1, pCur ) )
                        {
                           *(BOOL16*) OP_RES = TRUE;
                           break;
                        }
                     }
                     else if( pElemArg->iFldType == fldUNICODE )
                     {
                        pWORD pCur = (pWORD)((*pElemArg->ppRecRegRes) + pElemArg->iResOff);
                        pWORD pElm = (pWORD) OP_ARG1;
                        int iSize = *pCur++;

                        if ((iSize == *pElm++) &&
                            (CompareStringW(lcid, 0,
                                    (pCUCS2Char)pCur, iSize/2,
                                    (pCUCS2Char)pElm, iSize/2) == 2) )
                        {
                           *(BOOL16*) OP_RES = TRUE;
                           break;
                        }
                     }
                     else if( pElem->iFldType == fldBCD || pElem->iFldType == fldFMTBCD)
                     {
                        long double d1, d2;
                        pBYTE  pVal = OP_ARG1;
                        bcdToLongDouble(&d1, (TDecimal*) pVal);
                        pVal = (*pElemArg->ppRecRegRes) + pElemArg->iResOff;
                        bcdToLongDouble(&d2, (TDecimal*) pVal);
                        if( d1 == d2 )
                        {
                           *(BOOL16*) OP_RES = TRUE;
                           break;
                        }
                     }
                     else
                     {
                        pBYTE  pVal = (*pElemArg->ppRecRegRes) + pElemArg->iResOff;
                        pBYTE pRecArg = OP_ARG1;
                        if( !ByteComp( pRecArg, pVal, pElem->iUnitLen ) )
                        {
                           *(BOOL16*) OP_RES = TRUE;
                           break;
                        }
                     }
                     if( *(BOOL16*) OP_RES )
                        break;
                  }
               }
               else
               {
                  UINT16 i;
                  *(BOOL16*) OP_RES = FALSE;
                  if( pElem->iArgFldType == fldZSTRING )
                  {
                     pBYTE pCur = OP_ARG2;
                     for(i=0; i< pElem->iNumElems; i++ )
                     {
                        if( !LangStrCmp(lcid, OP_ARG1, pCur ) )
                        {
                           *(BOOL16*) OP_RES = TRUE;
                           break;
                        }
                        for( ; *pCur != '\0'; pCur++ )
                           ;
                        pCur++;
                     }
                  }
                  else if( pElem->iArgFldType == fldBCD || pElem->iArgFldType == fldFMTBCD)
                  {
                     long double d1, d2;
                     pBYTE  pVal = OP_ARG1;
                     bcdToLongDouble(&d1, (TDecimal*) pVal);
                     pVal = OP_ARG2;
                     for(i=0; i< pElem->iNumElems; i++ )
                     {
                        bcdToLongDouble(&d2, (TDecimal*) pVal);
                        if( d1 == d2 )
                        {
                           *(BOOL16*) OP_RES = TRUE;
                           break;
                        }
                        pVal += pElem->iUnitLen;
                     }
                  }
                  else
                  {
                     pBYTE  pVal = OP_ARG2;
                     for(i=0; i< pElem->iNumElems; i++ )
                     {
                        if( !ByteComp( OP_ARG1, pVal, pElem->iUnitLen ) )
                        {
                           *(BOOL16*) OP_RES = TRUE;
                           break;
                        }
                        pVal += pElem->iUnitLen;
                     }
                  }
               }
               break;
            }
            case CanSmallToFloat:
               *(DFLOAT*)OP_RES = *(INT8*)OP_ARG1;
               break;
            case CanShortToFloat:
               *(DFLOAT*)OP_RES = *(INT16*)OP_ARG1;
               break;
            case CanLongToFloat:
               *(DFLOAT*)OP_RES = *(INT32*)OP_ARG1;
               break;
            case CanInt64ToFloat:
               *(DFLOAT*)OP_RES = *(INT64*)OP_ARG1;
               break;
            case CanByteToFloat:
               *(DFLOAT*)OP_RES = *(UINT8*)OP_ARG1;
               break;
            case CanWordToFloat:
               *(DFLOAT*)OP_RES = *(UINT16*)OP_ARG1;
               break;
            case CanLongWordToFloat:
               *(DFLOAT*)OP_RES = *(UINT32*)OP_ARG1;
               break;
            case CanUInt64ToFloat:
               *(DFLOAT*)OP_RES = *(UINT64*)OP_ARG1;
               break;
            case CanBcdToFloat:
            {
               long double d;
               bcdToLongDouble(&d, (TDecimal*) OP_ARG1);
               *(DFLOAT*)OP_RES = (DFLOAT)d;
               break;
            }
            case CanFloatToSmall:
               *(INT8*)OP_RES = PtrToDFloat(OP_ARG1);
               break;
            case CanFloatToShort:
               *(INT16*)OP_RES = PtrToDFloat(OP_ARG1);
               break;
            case CanFloatToLong:
            {
               DFLOAT f = PtrToDFloat(OP_ARG1);
               *(INT32*)OP_RES = f;
               break;
            }
            case CanFloatToInt64:
            {
               DFLOAT f = PtrToDFloat(OP_ARG1);
               *(INT64*)OP_RES = f;
               break;
            }
            case CanFloatToByte:
               *(UINT8*)OP_RES = PtrToDFloat(OP_ARG1);
               break;
            case CanFloatToWord:
               *(UINT16*)OP_RES = PtrToDFloat(OP_ARG1);
               break;
            case CanFloatToLongWord:
            {
               DFLOAT f = PtrToDFloat(OP_ARG1);
               *(UINT32*)OP_RES = f;
               break;
            }
            case CanFloatToUInt64:
            {
               DFLOAT f = PtrToDFloat(OP_ARG1);
               *(UINT64*)OP_RES = f;
               break;
            }
            case CanFloatToBcd:
            {
               long double d = (long double)( PtrToDFloat(OP_ARG1) );
               bcdFromLongDouble((TDecimal*)OP_RES, &d,
                                 pElem->iArg1Units1, pElem->iArg1Units2 );
               break;
            }
            case CanSmallToSingle:
               *(SINGLE*)OP_RES = *(INT8*)OP_ARG1;
               break;
            case CanShortToSingle:
               *(SINGLE*)OP_RES = *(INT16*)OP_ARG1;
               break;
            case CanLongToSingle:
               *(SINGLE*)OP_RES = *(INT32*)OP_ARG1;
               break;
            case CanInt64ToSingle:
               *(SINGLE*)OP_RES = *(INT64*)OP_ARG1;
               break;
            case CanByteToSingle:
               *(SINGLE*)OP_RES = *(UINT8*)OP_ARG1;
               break;
            case CanWordToSingle:
               *(SINGLE*)OP_RES = *(UINT16*)OP_ARG1;
               break;
            case CanLongWordToSingle:
               *(SINGLE*)OP_RES = *(UINT32*)OP_ARG1;
               break;
            case CanUInt64ToSingle:
               *(SINGLE*)OP_RES = *(UINT64*)OP_ARG1;
               break;
            case CanBcdToSingle:
            {
               long double d;
               bcdToLongDouble(&d, (TDecimal*) OP_ARG1);
               *(SINGLE*)OP_RES = (SINGLE)d;
               break;
            }
            case CanSingleToSmall:
               *(INT8*)OP_RES = *(SINGLE*)OP_ARG1;
               break;
            case CanSingleToShort:
               *(INT16*)OP_RES = *(SINGLE*)OP_ARG1;
               break;
            case CanSingleToLong:
            {
               SINGLE f = *(SINGLE*)OP_ARG1;
               *(INT32*)OP_RES = f;
               break;
            }
            case CanSingleToInt64:
            {
#if defined(__ANDROID__)
               DFLOAT f = *(SINGLE*)OP_ARG1;
               *(INT64*)OP_RES = f;
#else
               SINGLE f = *(SINGLE*)OP_ARG1;
               *(INT64*)OP_RES = f;
#endif
               break;
            }
            case CanSingleToByte:
               *(UINT8*)OP_RES = *(SINGLE*)OP_ARG1;
               break;
            case CanSingleToWord:
               *(UINT16*)OP_RES = *(SINGLE*)OP_ARG1;
               break;
            case CanSingleToLongWord:
            {
               SINGLE f = *(SINGLE*)OP_ARG1;
               *(UINT32*)OP_RES = f;
               break;
            }
            case CanSingleToUInt64:
            {
               SINGLE f = *(SINGLE*)OP_ARG1;
               *(UINT64*)OP_RES = f;
               break;
            }
            case CanSingleToBcd:
            {
               long double d = (long double)( *(SINGLE*)OP_ARG1 );
               bcdFromLongDouble((TDecimal*)OP_RES, &d,
                                 pElem->iArg1Units1, pElem->iArg1Units2 );
               break;
            }
            case CanAssign:
               CopyMem( OP_RES, OP_ARG1, pElem->iResLen );
               break;
            case CanIsNull:
               *(BOOL16*)OP_RES = ISNULLVALUE( OP_ARG1_NULL );
               if( pElemLast->iResNullOff )
                  SETNULLVALUE( OP_RES_NULL, FALSE );
               break;
            case CanIsNotNull:
               *(BOOL16*)OP_RES = ! ISNULLVALUE( OP_ARG1_NULL );
               break;
            case CanStringLike:
            {
               QPatternMB *pPat;

                 pPat = new QPatternMB( (pCHAR) OP_ARG2, 0xFFFF, '\\', pElem->bCaseInsensitive);
               pPat->lcid = lcid;
               if( pPat )
               {
                  *(BOOL16*)OP_RES = (BOOL16) pPat->doesMatch( (pCHAR) OP_ARG1);
                  delete pPat;
               }
               break;
            }
            case CanMemoLike:
            {
               UINT32 iBlobId;
               BOOL Blank;
               UINT32  iBlobLen;
               pBYTE   pData;
               QPatternMB *pPat;
                  pPat = new QPatternMB( (pCHAR) OP_ARG2, 0xFFFF, '\\', pElem->bCaseInsensitive);
               pPat->lcid = lcid;
               if( pPat )
               {
                  pDS->GetField(pRecBuf,pElem->iFldNum,(pBYTE)&iBlobId, &Blank);
                  if( !Blank )
                  {
                     pDS->pDsBlobs->GetBlobInfo(iBlobId, &iBlobLen, &pData);
                     *(BOOL16*)OP_RES = (BOOL16) pPat->doesMatch((pCHAR)pData, (UINT16)iBlobLen);
                  }
                  else
                     *(BOOL16*)OP_RES = FALSE;
                  delete pPat;
               }
               break;
            }
            case CanTimestampToTime:
            {
               TIMESTAMP   ts = *(TIMESTAMP*) OP_ARG1;
               LONG        days = (LONG)( ts / (TIMESTAMP) MILSECSPERDAY );
               TIMESTAMP   t  = ts - (TIMESTAMP)( MILSECSPERDAY * days );
               *(TIME*) OP_RES = (TIME)t;
               break;
            }
            case CanTimestampToDate:
            {
               TIME time;
               LsTimeStampDecode(*(TIMESTAMP*) OP_ARG1,
                                   (DBIDATE*)OP_RES, &time);
               break;
            }
            case CanSqlTimestampToTime:
            {
               UINT16 d, m, h, mn, s;
               INT16 y;
               UINT32 f;
               TIME dTime;
               if( OP_ARG1 )
               {
                  LsSqlTimeStampDecode((SQLTIMESTAMP*) OP_ARG1,
                                    &y, &m, &d, &h, &mn, &s, &f );
                  s = (UINT16) ((s*1000) + f);
                  LsTimeEncode( h, mn, s, &dTime );
               }
               else
                  LsTimeEncode( 0, 0, 0, &dTime );
               *(DBIDATE*)OP_RES = dTime;
               break;
            }
            case CanSqlTimestampToDate:
            {
               UINT16 d, m, h, mn, s;
               INT16 y;
               UINT32 f;
               DBIDATE dDate;
               if( OP_ARG1 )
               {
                  LsSqlTimeStampDecode((SQLTIMESTAMP*) OP_ARG1,
                                    &y, &m, &d, &h, &mn, &s, &f );
                  dDate = LsDateEncode( y, m, d );
               }
               else
                  dDate = LsDateEncode( 0, 0, 0 );

               *(DBIDATE*)OP_RES = dDate;
               break;
            }
            case CanSqlTimestampOffsetToTime:
            {
               UINT16 d, m, h, mn, s;
               INT16 y, tzh, tzm;
               UINT32 f;
               TIME dTime;
               if( OP_ARG1 )
               {
                  LsSqlTimeStampOffsetDecode((SQLTIMESTAMPOFFSET*) OP_ARG1,
                                    &y, &m, &d, &h, &mn, &s, &f, &tzh, &tzm );
                  s = (UINT16) ((s*1000) + f);
                  LsTimeEncode( h, mn, s, &dTime );
               }
               else
                  LsTimeEncode( 0, 0, 0, &dTime );
               *(DBIDATE*)OP_RES = dTime;
               break;
            }
            case CanSqlTimestampOffsetToDate:
            {
               UINT16 d, m, h, mn, s;
               INT16 y, tzh, tzm;
               UINT32 f;
               DBIDATE dDate;
               if( OP_ARG1 )
               {
                  LsSqlTimeStampOffsetDecode((SQLTIMESTAMPOFFSET*) OP_ARG1,
                                    &y, &m, &d, &h, &mn, &s, &f, &tzh, &tzm );
                  dDate = LsDateEncode( y, m, d );
               }
               else
                  dDate = LsDateEncode( 0, 0, 0 );

               *(DBIDATE*)OP_RES = dDate;
               break;
            }
            case CanDateToTimestamp:
            {
               double    d = (double)( *(DBIDATE*) OP_ARG1 );
               TIMESTAMP ts = (TIMESTAMP)(d * (double)MILSECSPERDAY);
               *(TIMESTAMP*)OP_RES = ts;
               break;
            }
            case CanDateToSqlTimestamp:
            {
               UINT16 day, m;
               INT16 y;
               double d = (double)( *(DBIDATE*) OP_ARG1 );
               SQLTIMESTAMP sqlts;
               LsDateDecode( d, &m, &day, &y );
               LsSqlTimeStampEncode( &sqlts, y, m, day, 0, 0, 0, 0 );
               *((SQLTIMESTAMP*)OP_RES) = sqlts;
               break;
            }
            case CanDateToSqlTimestampOffset:
            {
               UINT16 day, m;
               INT16 y;
               double d = (double)( *(DBIDATE*) OP_ARG1 );
               SQLTIMESTAMPOFFSET sqlts;
               LsDateDecode( d, &m, &day, &y );
               LsSqlTimeStampOffsetEncode( &sqlts, y, m, day, 0, 0, 0, 0, 0, 0 );
               *((SQLTIMESTAMPOFFSET*)OP_RES) = sqlts;
               break;
            }
            case CanExtractDateFromTS:
            {
               DBIDATE date;
               TIME time;
               LsTimeStampDecode(*(TIMESTAMP*) OP_ARG1, &date, &time);
               *(DBIDATE*)OP_RES = date;
               break;
            }
            case CanExtractTimeFromTS:
            {
               DBIDATE date;
               TIME time;
               LsTimeStampDecode(*(TIMESTAMP*) OP_ARG1, &date, &time);
               *(TIME*)OP_RES = time;
               break;
            }
            case CanAnsiToUnicode:
            {
               UINT32 iUniLen = 0;
               pCHAR pSrc = (pCHAR)OP_ARG1;
               pUCS2Char pUni = (pUCS2Char)&OP_RES[sizeof(UINT16)];

#ifdef _UNIX
#if defined(__ANDROID__)
               UErrorCode status = U_ZERO_ERROR;
               UConverter *conv;
               conv = pucnv_open(pucnv_getDefaultName(), &status);
               iUniLen = pucnv_toUChars(conv, NULL, 0, pSrc, -1, &status);

               //Reset buffer overflow error that may have occurred during pre-flighting
               status = U_ZERO_ERROR;

               if (iUniLen != 0)
                  pucnv_toUChars(conv, pUni, iUniLen+1, pSrc, -1, &status);
               pucnv_close(conv);
#else
               size_t srcsize = (strlen(pSrc)+1) * sizeof(CHAR);
               size_t rstsize = srcsize * sizeof(ucs2char_t);
               pCHAR pRst = (pCHAR)pUni;
               iconv_t cdesc = iconv_open("UTF-16LE", GetCodePage());
               iconv(cdesc, &pSrc, (size_t*)&srcsize, &pRst, (size_t*)&rstsize);
               iUniLen = WideStrLen(pUni);
               iconv_close(cdesc);
#endif
#else
               // when cnMultiByte is -1, a result value, iUniLen include a NULL terminator.

               iUniLen = MultiByteToWideChar(CP_ACP, 0, pSrc, -1,
                     (wchar_t*)pUni, (pElem->iResLen)/sizeof(wchar_t)) - 1;
#endif
               *(UINT16*)OP_RES = iUniLen * sizeof(ucs2char_t);
               break;
            }
            case CanUnicodeToAnsi:
            {
               UINT32 iAnsiLen = 0;
               pWORD pSrc = (pWORD)OP_ARG1;
               WORD iUniLen = *pSrc++;
               char *pDst = (pCHAR)OP_RES;

#ifdef _UNIX
#if defined(__ANDROID__)
               UErrorCode status = U_ZERO_ERROR;
               UConverter *conv;
               conv = pucnv_open(pucnv_getDefaultName(), &status);
               iAnsiLen = pucnv_fromUChars(conv, NULL, 0, pSrc, -1, &status);

               //Reset buffer overflow error that may have occurred during pre-flighting
               status = U_ZERO_ERROR;

               if (iAnsiLen != 0)
                  pucnv_fromUChars(conv, pDst, iAnsiLen+1, pSrc, -1, &status);
#else
               size_t srcsize = (WideStrLen((pUCS2Char)pSrc)+1) * sizeof(ucs2char_t);
               size_t rstsize = (WideStrLen((pUCS2Char)pSrc)+1) * 4;
               pCHAR pAsrc = (pCHAR)pSrc;
               iconv_t cdesc = iconv_open(GetCodePage(), "UTF-16LE");
               iconv(cdesc, &pAsrc, (size_t*)&srcsize, &pDst, (size_t*)&rstsize);
               iconv_close(cdesc);
#endif
#else
               iAnsiLen = WideCharToMultiByte(CP_ACP, 0, (wchar_t *)pSrc, iUniLen / 2,
                     pDst, pElem->iResLen, NULL, NULL);
               *(pDst+iAnsiLen) = '\0';
#endif
               break;
            }
            case CanUnicodeStringAdd:
            {
               int iSize1, iSize2;
               UINT16 iResLen;
               iSize1 = (int)(*(UINT16*) OP_ARG1) / 2;
               iSize2 = (int)(*(UINT16*) OP_ARG2) / 2;
               iResLen = (UINT16) (pElem->iResLen) / 2;
               pUCS2Char pSrc1 = (pUCS2Char)&OP_ARG1[sizeof(UINT16)];
               pUCS2Char pSrc2 = (pUCS2Char)&OP_ARG2[sizeof(UINT16)];
               pUCS2Char pUni = (pUCS2Char)&OP_RES[sizeof(UINT16)];

               int i, total;
               total = 0;
               for (i = 0; i < iSize1 && total < iResLen; i++, total++)
                  *pUni++ = *pSrc1++;
               for (i = 0; i < iSize2 && total < iResLen; i++, total++)
                  *pUni++ = *pSrc2++;

               *(UINT16*) OP_RES = total * 2;
               break;
            }
            case CanUnicodeStringLike:
            {
               int iSize1, iSize2;
               iSize1 = (int)(*(UINT16*) OP_ARG1);
               iSize2 = (int)(*(UINT16*) OP_ARG2);
               WQPattern *pPat = new WQPattern( (pUCS2Char) &OP_ARG2[sizeof(UINT16)], iSize2 / 2, 0xFFFF, L'\\',
                                              pElem->bCaseInsensitive);
               if( pPat )
               {
                  *(BOOL16*)OP_RES = (BOOL16) pPat->doesMatch( (pUCS2Char) &OP_ARG1[sizeof(UINT16)], iSize1 / 2);
                  delete pPat;
               }
               break;
            }
            case CanUnicodeMemoLike:
            {
               UINT32 iBlobId;
               BOOL Blank;
               UINT32  iBlobLen;
               pBYTE   pData;

               int iSize2;
               iSize2 = (int)(*(UINT16*) OP_ARG2);

               WQPattern *pPat = new WQPattern( (pUCS2Char) &OP_ARG2[sizeof(UINT16)], (iSize2 / sizeof(ucs2char_t)), 0xFFFF, L'\\',
                                              pElem->bCaseInsensitive);
               if( pPat )
               {
                  pDS->GetField(pRecBuf,pElem->iFldNum,(pBYTE)&iBlobId, &Blank);
                  if( !Blank )
                  {
                     pDS->pDsBlobs->GetBlobInfo(iBlobId, &iBlobLen, &pData);
                     *(BOOL16*)OP_RES = (BOOL16) pPat->doesMatch((pUCS2Char)pData, (UINT16)(iBlobLen / sizeof(ucs2char_t)));
                  }
                  else
                     *(BOOL16*)OP_RES = FALSE;
                  delete pPat;
               }
               break;
            }

            case CanUnicodeStringEqual:
            case CanUnicodeStringNotEqual:
            case CanUnicodeStringLess:
            case CanUnicodeStringLessEq:
            case CanUnicodeStringGreater:
            case CanUnicodeStringGreaterEq:
            {
               INT32  iCmp;
                 int iSize1, iSize2;
                 iSize1 = pElem->iPartialLen == 0 ? (int)(*(UINT16*) OP_ARG1) : pElem->iPartialLen * 2;
                 iSize2 = pElem->iPartialLen == 0 ? (int)(*(UINT16*) OP_ARG2) : pElem->iPartialLen * 2;

               iCmp = CompareStringW(lcid,
                         pElem->bCaseInsensitive ? NORM_IGNORECASE : 0,
                         (pCUCS2Char) &OP_ARG1[sizeof(UINT16)],
                           iSize1/2,
                         (pCUCS2Char) &OP_ARG2[sizeof(UINT16)],
                         iSize2/2) -2;

               switch( pElem->eFuncType ) {
                 case CanUnicodeStringEqual:
                    *(BOOL16*)OP_RES = iCmp == 0;
                    break;
                 case CanUnicodeStringNotEqual:
                    *(BOOL16*)OP_RES = iCmp != 0;
                    break;
                 case CanUnicodeStringLess:
                    *(BOOL16*)OP_RES = iCmp < 0;
                    break;
                 case CanUnicodeStringLessEq:
                    *(BOOL16*)OP_RES = iCmp <= 0;
                    break;
                 case CanUnicodeStringGreater:
                    *(BOOL16*)OP_RES = iCmp > 0;
                    break;
                 case CanUnicodeStringGreaterEq:
                    *(BOOL16*)OP_RES = iCmp >= 0;
                    break;
                 default:
                    break;
               }
               break;
            }
            case    CanUnicodeStringLower :
            {
               pWORD pSrc = (pWORD)OP_ARG1;
               pWORD pDst = (pWORD)OP_RES;

               WORD iLength; // byte size.
               iLength = *pDst++ = *pSrc++;
#ifdef _UNIX
               memcpy(pDst, WideLowerCase(pSrc), iLength);
               pDst[iLength] = 0;
#else
               LCMapStringW(GetThreadLocale(),
                 LCMAP_LOWERCASE,
                 (const wchar_t*)pSrc, iLength/sizeof(wchar_t),
                 (wchar_t*)pDst, (pElem->iLen - sizeof(wchar_t))/ sizeof(wchar_t) );
#endif
               break;
            }
            case    CanUnicodeStringUpper :
            {
               pWORD pSrc = (pWORD)OP_ARG1;
               pWORD pDst = (pWORD)OP_RES;

               WORD iLength; // byte size.
               iLength = *pDst++ = *pSrc++;
#ifdef _UNIX
               memcpy(pDst, WideUpperCase(pSrc), iLength);
               pDst[iLength] = 0;
#else
               LCMapStringW(GetThreadLocale(),
                 LCMAP_UPPERCASE,
                 (const wchar_t*)pSrc, iLength/sizeof(wchar_t),
                 (wchar_t*)pDst, (pElem->iLen - sizeof(wchar_t))/ sizeof(wchar_t) );
#endif
               break;
            }
            case    CanUnicodeSubstring3 :
            {
               pWORD pSrc = (pWORD)OP_ARG1;
               pWORD pDst = (pWORD)OP_RES;
               UINT16 start = (UINT16)(PtrToDFloat(OP_ARG2));
               UINT16 len;
               UINT16 i = 0;
               int iSrcLen = (*pSrc++) / 2;

               if( ISNULLVALUE( OP_ARG3_NULL )  )
               {
                  SETNULLVALUE( OP_RES_NULL, TRUE );
                  break;
               }

               len = (UINT16)(PtrToDFloat(OP_ARG3));

               pDst++;
               if( start && iSrcLen >= start )
               {
                  pSrc += start - 1;
                  iSrcLen -= start;
                  for(; (i< len) && (iSrcLen >= 0); i++, iSrcLen-- )
                     *pDst++ = *pSrc++;
               }
               *(pWORD)OP_RES = i * 2;
               break;
            }
            case    CanUnicodeSubstring2 :
            {
               pWORD pSrc = (pWORD)OP_ARG1;
               pWORD pDst = (pWORD)OP_RES;
               UINT16 start = (UINT16)(PtrToDFloat(OP_ARG2));
               UINT16 i = 0;
               int iSrcLen = (*pSrc++) / 2;

               pDst++;
               if( start && iSrcLen >= start )
               {
                  pSrc += start - 1;
                  iSrcLen -= start;
                  for(; iSrcLen >= 0; i++, iSrcLen-- )
                     *pDst++ = *pSrc++;
               }
               *(pWORD)OP_RES = i * 2;
               break;
            }
            case    CanUnicodeTrimLead:
            {
               pWORD pSrc = (pWORD)OP_ARG1;
               pWORD pDst = (pWORD)OP_RES;
               UINT16 i, j;
               WORD tVal = pElem->ppRecReg2 ? ((pWORD)OP_ARG2)[1] : L' ';
               int iSrcLen = (*pSrc++) / 2;
               pDst++;

               for( i=0; (iSrcLen > 0) && (pSrc[i] == tVal); i++, iSrcLen--)
                  ;

               if( iSrcLen > 0 )
               {
                  for(j = 0; iSrcLen > 0 ; i++, j++, iSrcLen--)
                     pDst[j] = pSrc[i];
                  *(pWORD)OP_RES = j*2;
               }
               else
                  *(pWORD)OP_RES = 0;
               break;
            }
            case    CanUnicodeTrimTrail:
            {
               pWORD pSrc = (pWORD)OP_ARG1;
               pWORD pDst = (pWORD)OP_RES;
               UINT16 j;
               WORD tVal = pElem->ppRecReg2 ? ((pWORD)OP_ARG2)[1] : L' ';
               int iSrcLen = (*pSrc++) / 2;
               pDst++;

               if( iSrcLen > 0 )
               {
                  for(j = 0; iSrcLen > 0 ; j++, iSrcLen--)
                     pDst[j] = pSrc[j];
                  while( j-- && pDst[j] == tVal )
                     ;
                  *(pWORD)OP_RES = (j+1)*2;
               }
               else
                  *(pWORD)OP_RES = 0;
               break;
            }
            case    CanUnicodeTrimBoth:
            {
               pWORD pSrc = (pWORD)OP_ARG1;
               pWORD pDst = (pWORD)OP_RES;
               UINT16 i, j;
               WORD tVal = pElem->ppRecReg2 ? ((pWORD)OP_ARG2)[1] : L' ';
               int iSrcLen = (*pSrc++) / 2;
               pDst++;

               for( i=0; (iSrcLen > 0) && (pSrc[i] == tVal); i++, iSrcLen--)
                  ;

               if( iSrcLen > 0 )
               {
                  for(j = 0; iSrcLen > 0 ; i++, j++, iSrcLen--)
                     pDst[j] = pSrc[i];
                  while( j-- && pDst[j] == tVal )
                     ;
                  *(pWORD)OP_RES = (j+1)*2;
               }
               else
                  *(pWORD)OP_RES = 0;
               break;
            }
            case    CanInt64Subtract :
               f1 = (DFLOAT)( *(INT64*)OP_ARG1 );
               f2 = (DFLOAT)( *(INT64*)OP_ARG2 );
               fRes = f1 - f2;
               if( fRes > INT64_MAX || fRes < INT64_MIN)
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(INT64*)OP_RES = (INT64) fRes;
               break;
            case    CanInt64Add :
               f1 = (DFLOAT)( *(INT64*)OP_ARG1 );
               f2 = (DFLOAT)( *(INT64*)OP_ARG2 );
               fRes = f1 + f2;
               if( fRes > INT64_MAX || fRes < INT64_MIN)
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(INT64*)OP_RES = (INT64) fRes;
               break;
            case    CanInt64Multiply:
               f1 = (DFLOAT)( *(INT64*)OP_ARG1 );
               f2 = (DFLOAT)( *(INT64*)OP_ARG2 );
               fRes = f1 * f2;
               if( fRes > INT64_MAX || fRes < INT64_MIN)
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               else
                  *(INT64*)OP_RES = (INT64) fRes;
               break;
            case    CanInt64Divide :
            {
               // TODO: detect overflow, throw exception
               INT64 l = *(INT64*)OP_ARG2;
               if( l != 0L )
               {
                  FLOAT f1, f2, fRes;
                  f1 = (FLOAT)( *(INT64*)OP_ARG1 );
                  f2 = (FLOAT)( *(INT64*)OP_ARG2 );
                  if( f2 != 0.0 )
                  {
                     fRes = f1 / f2;
                     if( fRes > INT64_MAX || fRes < INT64_MIN)
                        SETNULLVALUE( OP_RES_NULL  ,  TRUE);
                     else
                        *(INT64*)OP_RES = (INT64) fRes;
                  }
                  else
                     SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               }
               else
                  SETNULLVALUE( OP_RES_NULL  ,  TRUE);
               break;
            }
            case    CanInt64Equal:
               *(BOOL16*)OP_RES = *(INT64*)OP_ARG1 == *(INT64*)OP_ARG2;
               break;
            case    CanInt64NotEqual :
               *(BOOL16*)OP_RES = *(INT64*)OP_ARG1 != *(INT64*)OP_ARG2;
               break;
            case    CanInt64Less :
               *(BOOL16*)OP_RES = *(INT64*)OP_ARG1 < *(INT64*)OP_ARG2;
               break;
            case    CanInt64LessEq:
               *(BOOL16*)OP_RES = *(INT64*)OP_ARG1 <= *(INT64*)OP_ARG2;
               break;
            case    CanInt64Greater :
               *(BOOL16*)OP_RES = *(INT64*)OP_ARG1 > *(INT64*)OP_ARG2;
               break;
            case    CanInt64GreaterEq :
               *(BOOL16*)OP_RES = *(INT64*)OP_ARG1 >= *(INT64*)OP_ARG2;
               break;
            case    CanInt64Negate :
               *(INT64*)OP_RES = - (*(INT64*)OP_ARG1);
               break;
            default:
               break;
         }
      }
   }

   if( pElemLast && pElemLast->eAggFunc == aggopNoop )
   {
      if( pElemLast->iFldType == fldBOOL
       &&
       ( !pElemLast->iResNullOff
       || !ISNULLVALUE(((*pElemLast->ppRecRegRes) + pElemLast->iResNullOff) )
       )
       && ( *(BOOL16*) (*pElemLast->ppRecRegRes) )
      )
         bRet = TRUE;
      else
         bRet = FALSE;
   }
   return bRet;
}

pQCanExecElem QCanExecStream::GetResElem()
{
   pQCanExecElem pElemRes = NULL, pI;
   ForEachInSet( pFieldExecElemSet, pI )
      pElemRes = pI;
   return pElemRes;
}

QCanExecStream::QCanExecStream()
{
  pArgs = new QCanExecElemSet();
  pFieldExecElemSet =  new QCanExecElemSet();
}

QCanExecStream::~QCanExecStream()
{
   pQCanExecElem pI;
   if( pFieldExecElemSet )
   {
      ForEachInSet( pFieldExecElemSet, pI )
         delete pI;
      delete pFieldExecElemSet;
   }
   if( pArgs )
   {
      ForEachInSet( pArgs, pI )
         delete pI;
      delete pArgs;
   }
}

//These enums are indexed on field type, order matters

QFieldFuncType QCanFuncsAdd[] = {
//  UNK      ZST           DAT      BLB      BOL      I16
    CanNoop, CanStringAdd, CanNoop, CanNoop, CanNoop, CanShortAdd,
//  I32         FLT           BCD        BYT      TIM      TMS
    CanLongAdd, CanFloatAdd,  CanBcdAdd, CanNoop, CanNoop, CanNoop,
//  U16         U32             IEE      VAR      LCK       MEMO     INT64
    CanWordAdd, CanLongWordAdd, CanNoop, CanNoop, CanNoop,  CanNoop, CanInt64Add,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs    PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  SGL           I8              U8          PHolder  PHolder  PHolder  PHolder  PHolder34
    CanSingleAdd, CanShortIntAdd, CanByteAdd, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanNoop
};

QFieldFuncType QCanFuncsSubtract[] = {
//  UNK      ZST      DAT              BLB      BOL      I16
    CanNoop, CanNoop, CanDateSubtract, CanNoop, CanNoop, CanShortSubtract,
//  I32              FLT                BCD             BYT      TIM              TMS
    CanLongSubtract, CanFloatSubtract,  CanBcdSubtract, CanNoop, CanLongSubtract, CanDatetimeSubtract,
//  U16              U32                  IEE       VAR      LCK      MEMO     INT64
    CanWordSubtract, CanLongWordSubtract, CanNoop , CanNoop, CanNoop, CanNoop, CanInt64Subtract,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs                    PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanSqlTimestampSubtract, CanNoop, CanNoop,
//  SGL                I8                   U8               PHolder  PHolder  PHolder  PHolder  PHolder34
    CanSingleSubtract, CanShortIntSubtract, CanByteSubtract, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanSqlTimestampOffsetSubtract
};

QFieldFuncType QCanFuncsEqual[] = {
//  UNK      ZST             DAT           BLB      BOL        I16
    CanNoop, CanStringEqual, CanLongEqual, CanNoop, CanBoolEq, CanShortEqual,
//  I32           FLT             BCD          BYT            TIM           TMS
    CanLongEqual, CanFloatEqual,  CanBcdEqual, CanBytesEqual, CanLongEqual, CanFloatEqual,
//  U16           U32               IEE      VAR      LCK      MEMO      INT64
    CanWordEqual, CanLongWordEqual, CanNoop, CanNoop, CanNoop, CanNoop,  CanInt64Equal,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs                 PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanSqlTimestampEqual, CanNoop, CanNoop,
//  SGL             I8                U8            PHolder  PHolder  PHolder  PHolder  PHolder34
    CanSingleEqual, CanShortIntEqual, CanByteEqual, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanSqlTimestampOffsetEqual
};

QFieldFuncType QCanFuncsNotEqual[] = {
//  UNK      ZST                DAT              BLB      BOL           I16
    CanNoop, CanStringNotEqual, CanLongNotEqual, CanNoop, CanBoolNotEq, CanShortNotEqual,
//  I32              FLT               BCD             BYT               TIM              TMS
    CanLongNotEqual, CanFloatNotEqual, CanBcdNotEqual, CanBytesNotEqual, CanLongNotEqual, CanFloatNotEqual,
//  U16              U32                  IEE      VAR      LCK      MEMO     INT64
    CanWordNotEqual, CanLongWordNotEqual, CanNoop, CanNoop, CanNoop, CanNoop, CanInt64NotEqual,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs                    PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanSqlTimestampNotEqual, CanNoop, CanNoop,
//  SGL                I8                   U8               PHolder  PHolder  PHolder  PHolder  PHolder34
    CanSingleNotEqual, CanShortIntNotEqual, CanByteNotEqual, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanSqlTimestampOffsetNotEqual
};

QFieldFuncType QCanFuncsGreater[] = {
//  UNK      ZST               DAT             BLB      BOL      I16
    CanNoop, CanStringGreater, CanLongGreater, CanNoop, CanNoop, CanShortGreater,
//  I32             FLT               BCD            BYT      TIM             TMS
    CanLongGreater, CanFloatGreater,  CanBcdGreater, CanNoop, CanLongGreater, CanFloatGreater,
//  U16             U32                 IEE      VAR      LCK      MEMO     INT64
    CanWordGreater, CanLongWordGreater, CanNoop, CanNoop, CanNoop, CanNoop, CanInt64Greater,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs                   PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanSqlTimestampGreater, CanNoop, CanNoop,
//  SGL               I8                  U8              PHolder  PHolder  PHolder  PHolder  PHolder34
    CanSingleGreater, CanShortIntGreater, CanByteGreater, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanSqlTimestampOffsetGreater
};

QFieldFuncType QCanFuncsLess[] = {
//  UNK      ZST            DAT          BLB      BOL      I16
    CanNoop, CanStringLess, CanLongLess, CanNoop, CanNoop, CanShortLess,
//  I32          FLT           BCD         BYT      TIM          TMS
    CanLongLess, CanFloatLess, CanBcdLess, CanNoop, CanLongLess, CanFloatLess,
//  U16          U32              IEE       VAR      LCK      MEMO     INT64
    CanWordLess, CanLongWordLess, CanNoop,  CanNoop, CanNoop, CanNoop, CanInt64Less,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs                PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanSqlTimestampLess, CanNoop, CanNoop,
//  SGL            I8               U8           PHolder  PHolder  PHolder  PHolder  PHolder34
    CanSingleLess, CanShortIntLess, CanByteLess, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanSqlTimestampOffsetLess
};

QFieldFuncType QCanFuncsLessEq[] = {
//  UNK      ZST              DAT            BLB      BOL      I16
    CanNoop, CanStringLessEq, CanLongLessEq, CanNoop, CanNoop, CanShortLessEq,
//  I32            FLT             BCD           BYT      TIM            TMS
    CanLongLessEq, CanFloatLessEq, CanBcdLessEq, CanNoop, CanLongLessEq, CanFloatLessEq,
//  U16            U32                IEE      VAR      LCK      MEMO     INT64
    CanWordLessEq, CanLongWordLessEq, CanNoop, CanNoop, CanNoop, CanNoop, CanInt64LessEq,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs                  PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanSqlTimestampLessEq, CanNoop, CanNoop,
//  SGL              I8                 U8             PHolder  PHolder  PHolder  PHolder  PHolder34
    CanSingleLessEq, CanShortIntLessEq, CanByteLessEq, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanSqlTimestampOffsetLessEq
};

QFieldFuncType QCanFuncsGreaterEq[] = {
//  UNK      ZST                 DAT               BLB      BOL      I16
    CanNoop, CanStringGreaterEq, CanLongGreaterEq, CanNoop, CanNoop, CanShortGreaterEq,
//  I32               FLT                BCD              BYT      TIM               TMS
    CanLongGreaterEq, CanFloatGreaterEq, CanBcdGreaterEq, CanNoop, CanLongGreaterEq, CanFloatGreaterEq,
//  U16               U32                   IEE      VAR      LCK      MEMO     INT64
    CanWordGreaterEq, CanLongWordGreaterEq, CanNoop, CanNoop, CanNoop, CanNoop, CanInt64GreaterEq,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs                     PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanSqlTimestampGreaterEq, CanNoop, CanNoop,
//  SGL                 I8                    U8                PHolder  PHolder  PHolder  PHolder  PHolder34
    CanSingleGreaterEq, CanShortIntGreaterEq, CanByteGreaterEq, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanSqlTimestampOffsetGreaterEq
};

QFieldFuncType QCanFuncsLike[] = {
//  UNK      ZST            DAT          BLB      BOL      I16
    CanNoop, CanStringLike, CanMemoLike, CanNoop, CanNoop, CanNoop,
//  I32      FLT      BCD      BYT      TIM      TMS
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  U16      U32      IEE      VAR      LCK      MEMO     INT64
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs    PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  SGL      I8       U8       PHolder  PHolder  PHolder  PHolder  PHolder34
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanNoop
};

QFieldFuncType QCanFuncsNot[] = {
//  UNK      ZST      DAT      BLB      BOL         I16
    CanNoop, CanNoop, CanNoop, CanNoop, CanBoolNot, CanNoop,
//  I32      FLT      BCD      BYT      TIM      TMS
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  U16      U32      IEE      VAR      LCK      MEMO     INT64
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs    PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  SGL      I8       U8       PHolder  PHolder  PHolder  PHolder  PHolder34
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanNoop
};

QFieldFuncType QCanFuncsOr[] = {
//  UNK      ZST      DAT      BLB      BOL        I16
    CanNoop, CanNoop, CanNoop, CanNoop, CanBoolOr, CanNoop,
//  I32      FLT      BCD      BYT      TIM      TMS
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  U16      U32      IEE      VAR      LCK      MEMO     INT64
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs    PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  SGL      I8       U8       PHolder  PHolder  PHolder  PHolder  PHolder34
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanNoop
};

QFieldFuncType QCanFuncsAnd[] = {
//  UNK      ZST      DAT      BLB      BOL         I16
    CanNoop, CanNoop, CanNoop, CanNoop, CanBoolAnd, CanNoop,
//  I32      FLT      BCD      BYT      TIM      TMS
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  U16      U32      IEE      VAR      LCK      MEMO     INT64
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs    PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  SGL      I8       U8       PHolder  PHolder  PHolder  PHolder  PHolder34
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanNoop
};

QFieldFuncType QCanFuncsMultiply[] = {
//  UNK      ZST      DAT      BLB      BOL      I16
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanShortMultiply,
//  I32              FLT               BCD             BYT      TIM      TMS
    CanLongMultiply, CanFloatMultiply, CanBcdMultiply, CanNoop, CanNoop, CanNoop,
//  U16      U32      IEE      VAR      LCK      MEMO     INT64
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanInt64Multiply,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs    PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  SGL                I8       U8       PHolder  PHolder  PHolder  PHolder  PHolder34
    CanSingleMultiply, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanNoop
};

QFieldFuncType QCanFuncsDivide[] = {
//  UNK      ZST      DAT      BLB      BOL      I16
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanShortDivide,
//  I32            FLT             BCD           BYT      TIM      TMS
    CanLongDivide, CanFloatDivide, CanBcdDivide, CanNoop, CanNoop, CanNoop,
//  U16      U32      IEE      VAR      LCK      MEMO     INT64
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanInt64Divide,
//  U64      PHolder  PHolder  PHolder  PHolder  SQLTs    PHolder  PHolder26
    CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  SGL              I8       U8       PHolder  PHolder  PHolder  PHolder  PHolder34
    CanSingleDivide, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop, CanNoop,
//  PHolder  SQLTsOs
    CanNoop, CanNoop
};


QFieldFuncType* QCanFuncsByOp[] =
{
   NULL,
   QCanFuncsAdd,
   NULL, //avg
   NULL, //count
   NULL, //max
   NULL, //min
   NULL, //total
   NULL, // alias
   QCanFuncsAnd,
   NULL, // const
   QCanFuncsDivide,
   QCanFuncsEqual,
   NULL, // field
   QCanFuncsGreaterEq,
   QCanFuncsGreater,
   QCanFuncsLessEq,
   QCanFuncsLike,
   QCanFuncsLess,
   QCanFuncsMultiply, 
   QCanFuncsNotEqual, 
   QCanFuncsNot, 
   QCanFuncsOr, 
   QCanFuncsSubtract
};

UINT16   GetResLen (
   UINT16 iFldType,
   UINT16 iLen
)
{
   UINT16 iSize;
   switch ( iFldType )
   {
       case fldZSTRING:
          iSize = (UINT16) (iLen + 1);
          break;
       case fldDATE:
          iSize = sizeof(DBIDATE);
          break;
       case fldBOOL:
          iSize = sizeof(BOOL16);
          break;
       case fldINT16:
          iSize = sizeof(INT16);
          break;
       case fldINT32:
          iSize = sizeof(INT32);
          break;
       case fldFLOAT:
          iSize = sizeof(DFLOAT);
          break;
       case fldFMTBCD:
       case fldBCD:
          iSize = sizeof(FMTBcd);
          break;
       case fldBYTES:
          iSize = iLen;
          break;
       case fldTIME:
          iSize = sizeof(TIME);
          break;
       case fldTIMESTAMP:
          iSize = sizeof(TIMESTAMP);
          break;
       case fldDATETIME:
          iSize = sizeof(SQLTIMESTAMP);
          break;
       case fldDATETIMEOFFSET:
          iSize = sizeof(SQLTIMESTAMPOFFSET);
       case fldUINT16:
          iSize = sizeof(UINT16);
          break;
       case fldUINT32:
          iSize = sizeof(UINT32);
          break;
       case fldSINGLE:
          iSize = sizeof(float);
          break;
       case fldFLOATIEEE:
          iSize = sizeof(long double);
          break;
       case fldVARBYTES:
          iSize = (UINT16)(iLen + 2);
          break;
       case fldINT64:
          iSize = sizeof(INT64);
          break;
       case fldUINT64:
          iSize = sizeof(UINT64);
          break;
       case fldINT8:
          iSize = sizeof(INT8);
          break;
       case fldUINT8:
          iSize = sizeof(UINT8);
          break;
   }
   return iSize;
}

static BOOL IsAgg (
   QNodeType eType
)
{
   if( eType == qnodeTotal || 
      eType == qnodeMin || 
      eType == qnodeMax || 
      eType == qnodeAvg ||
      eType == qnodeCount
   )
      return TRUE;
   return FALSE;
}

BOOL IsNumeric( 
   pQCanExecElem      pElem
)
{
   return pElem->iFldType == fldINT8
       || pElem->iFldType == fldINT16
       || pElem->iFldType == fldINT32
       || pElem->iFldType == fldINT64
       || pElem->iFldType == fldUINT8
       || pElem->iFldType == fldUINT16
       || pElem->iFldType == fldUINT32
       || pElem->iFldType == fldUINT64
       || pElem->iFldType == fldFLOAT
       || pElem->iFldType == fldFMTBCD
       || pElem->iFldType == fldBCD
       || pElem->iFldType == fldSINGLE;
}
BOOL IsTemporal (
   pQCanExecElem      pElem
)
{
   return pElem->iFldType == fldTIME
      || pElem->iFldType == fldDATETIME
      || pElem->iFldType == fldDATE
      || pElem->iFldType ==  fldTIMESTAMP
      || pElem->iFldType == fldDATETIMEOFFSET;
}
pQCanExecElem   CastTo (
   pQCanExecElem      pElemIn,
   pQCanExecStream    pStream,
   UINT16             iTypeDest
)
{
   pQCanExecElem   pElemF;
   if( pElemIn->iFldType == iTypeDest && (pElemIn->iFldType != fldBCD && pElemIn->iFldType != fldFMTBCD))
      return pElemIn;

   pElemF = new QCanExecElem();

   if( IsNumeric ( pElemIn) )
   {
      if( pElemIn->iFldType == fldFLOAT )
      {
         switch( iTypeDest )
         {
            case fldINT8:
               pElemF->eFuncType = CanFloatToSmall;
               break;
            case fldINT16:
               pElemF->eFuncType = CanFloatToShort;
               break;
            case fldINT32:
               pElemF->eFuncType = CanFloatToLong;
               break;
            case fldINT64:
               pElemF->eFuncType = CanFloatToInt64;
               break;
            case fldUINT8:
               pElemF->eFuncType = CanFloatToByte;
               break;
            case fldUINT16:
               pElemF->eFuncType = CanFloatToWord;
               break;
            case fldUINT32:
               pElemF->eFuncType = CanFloatToLongWord;
               break;
            case fldUINT64:
               pElemF->eFuncType = CanFloatToUInt64;
               break;
            case fldFMTBCD:
            case fldBCD:
               pElemF->eFuncType = CanFloatToBcd;
               break;
         }
      }
      else if( pElemIn->iFldType == fldSINGLE )
      {
         switch( iTypeDest )
         {
            case fldINT8:
               pElemF->eFuncType = CanSingleToSmall;
               break;
            case fldINT16:
               pElemF->eFuncType = CanSingleToShort;
               break;
            case fldINT32:
               pElemF->eFuncType = CanSingleToLong;
               break;
            case fldINT64:
               pElemF->eFuncType = CanSingleToInt64;
               break;
            case fldUINT8:
               pElemF->eFuncType = CanSingleToByte;
               break;
            case fldUINT16:
               pElemF->eFuncType = CanSingleToWord;
               break;
            case fldUINT32:
               pElemF->eFuncType = CanSingleToLongWord;
               break;
            case fldUINT64:
               pElemF->eFuncType = CanSingleToUInt64;
               break;
            case fldFMTBCD:
            case fldBCD:
               pElemF->eFuncType = CanSingleToBcd;
               break;
         }
      }
      else if( iTypeDest == fldFLOAT )
      {
         switch( pElemIn->iFldType )
         {
            case fldINT8:
               pElemF->eFuncType = CanSmallToFloat;
               break;
            case fldINT16:
               pElemF->eFuncType = CanShortToFloat;
               break;
            case fldINT32:
               pElemF->eFuncType = CanLongToFloat;
               break;
            case fldINT64:
               pElemF->eFuncType = CanInt64ToFloat;
               break;
            case fldUINT8:
               pElemF->eFuncType = CanByteToFloat;
               break;
            case fldUINT16:
               pElemF->eFuncType = CanWordToFloat;
               break;
            case fldUINT32:
               pElemF->eFuncType = CanLongWordToFloat;
               break;
            case fldUINT64:
               pElemF->eFuncType = CanUInt64ToFloat;
               break;
            case fldFMTBCD:
            case fldBCD:
               pElemF->eFuncType = CanBcdToFloat;
               break;
         }
      }
      else if( iTypeDest == fldSINGLE )
      {
         switch( pElemIn->iFldType )
         {
            case fldINT8:
               pElemF->eFuncType = CanSmallToSingle;
               break;
            case fldINT16:
               pElemF->eFuncType = CanShortToSingle;
               break;
            case fldINT32:
               pElemF->eFuncType = CanLongToSingle;
               break;
            case fldINT64:
               pElemF->eFuncType = CanInt64ToSingle;
               break;
            case fldUINT8:
               pElemF->eFuncType = CanByteToSingle;
               break;
            case fldUINT16:
               pElemF->eFuncType = CanWordToSingle;
               break;
            case fldUINT32:
               pElemF->eFuncType = CanLongWordToSingle;
               break;
            case fldUINT64:
               pElemF->eFuncType = CanUInt64ToSingle;
               break;
            case fldFMTBCD:
            case fldBCD:
               pElemF->eFuncType = CanBcdToSingle;
               break;
         }
      }
      // else  ERROR,  should never happen
   }
   else if(  IsTemporal( pElemIn) )
   {
      if( pElemIn->iFldType == fldDATE && iTypeDest == fldDATETIME )
         pElemF->eFuncType = CanDateToSqlTimestamp;
      else if( pElemIn->iFldType == fldDATE && iTypeDest == fldDATETIMEOFFSET )
         pElemF->eFuncType = CanDateToSqlTimestampOffset;
      else if( pElemIn->iFldType == fldDATE && iTypeDest == fldTIMESTAMP )
         pElemF->eFuncType = CanDateToTimestamp;
      else if ( pElemIn->iFldType == fldTIMESTAMP && iTypeDest == fldTIME )
         pElemF->eFuncType = CanTimestampToTime;
      else if ( pElemIn->iFldType == fldTIMESTAMP && iTypeDest == fldDATE )
         pElemF->eFuncType = CanTimestampToDate;
      else if ( pElemIn->iFldType == fldDATETIME && iTypeDest == fldDATE )
         pElemF->eFuncType = CanSqlTimestampToDate;
      else if ( pElemIn->iFldType == fldDATETIME && iTypeDest == fldTIME )
         pElemF->eFuncType = CanSqlTimestampToTime;
      else if ( pElemIn->iFldType == fldDATETIMEOFFSET && iTypeDest == fldDATE )
         pElemF->eFuncType = CanSqlTimestampOffsetToDate;
      else if ( pElemIn->iFldType == fldDATETIMEOFFSET && iTypeDest == fldTIME )
         pElemF->eFuncType = CanSqlTimestampOffsetToTime;
      else
         pElemF->eFuncType = CanNoop;
   }
   else if( iTypeDest == fldUNICODE && pElemIn->iFldType != fldUNICODE )
   {
      pElemF->eFuncType = CanAnsiToUnicode;
      pElemF->iResLen = (UINT16) ((pElemIn->iResLen * 2) + sizeof(UINT16));
   }
   else if( iTypeDest == fldZSTRING && pElemIn->iFldType == fldUNICODE )
   {
      pElemF->eFuncType = CanUnicodeToAnsi;
      pElemF->iResLen = (UINT16) ((pElemIn->iResLen) + sizeof(UINT16));
   }

   if( iTypeDest != fldUNICODE )
      pElemF->iResLen =  GetResLen( iTypeDest, pElemIn->iLen );

   pElemF->iResOff = 0;
   pElemF->iResNullOff = pElemF->iResLen;
   pElemF->iFldType = iTypeDest;
   pElemF->ppRecRegRes = &pElemF->pRecRegRes;
   pElemF->pRecRegRes = new BYTE[ pElemF->iResLen + NULLINDLEN ];
   pElemF->ppRecReg1 = pElemIn->ppRecRegRes;
   pElemF->iArg1Off = pElemIn->iResOff;
   pElemF->iArg1NullOff = pElemIn->iResNullOff;
   pElemF->iLen =  pElemIn->iResLen;

   pStream->AddElem( pElemF );
   return pElemF;
}


VOID AddCasts (
   CANOp              canOp,
   pQCanExecElem      *pElem1,
   pQCanExecElem      *pElem2,
   pQCanExecElem      pElemRes,
   pQCanExecStream    pStream
)
{
   if( IsNumeric( *pElem1 ) && IsNumeric( *pElem2 )
      && ( (*pElem1)->iFldType != (*pElem2)->iFldType
          ||  (*pElem1)->iFldType == fldBCD ||  (*pElem1)->iFldType == fldFMTBCD
          ||  (*pElem2)->iFldType == fldBCD ||  (*pElem2)->iFldType == fldFMTBCD
         )
   )
   {
      if( pElemRes->eType != qnodeAssign )
      {
         *pElem1 = CastTo( *pElem1, pStream, fldFLOAT);
         *pElem2 = CastTo( *pElem2, pStream, fldFLOAT);
      }
      else
         *pElem1  = CastTo( *pElem1, pStream, (*pElem2)->iFldType );
   }
   else if(  IsTemporal( *pElem1 ) && IsTemporal( *pElem2 )
      &&  (*pElem1)->iFldType != (*pElem2)->iFldType )
   {
      if( canOp != canASSIGN )
      {
         if( (*pElem1)->iFldType == fldTIME 
               && (*pElem2)->iFldType == fldTIMESTAMP )
            *pElem2 = CastTo( *pElem2, pStream, fldTIME );
         else if ( (*pElem2)->iFldType == fldTIME
                && (*pElem1)->iFldType == fldTIMESTAMP ) 
            *pElem1 = CastTo( *pElem1, pStream, fldTIME);
         else if ( (*pElem1)->iFldType == fldDATE
                && (*pElem2)->iFldType == fldTIMESTAMP )
            *pElem1 = CastTo( *pElem1, pStream, fldTIMESTAMP );
         else if ( (*pElem2)->iFldType == fldDATE
                && (*pElem1)->iFldType == fldTIMESTAMP )
            *pElem2 = CastTo( *pElem2, pStream, fldTIMESTAMP );
         else if ( (*pElem1)->iFldType == fldDATE
                && (*pElem2)->iFldType == fldDATETIME )
            *pElem1 = CastTo( *pElem1, pStream, fldDATETIME );
         else if ( (*pElem2)->iFldType == fldDATE
                && (*pElem1)->iFldType == fldDATETIME )
            *pElem2 = CastTo( *pElem2, pStream, fldDATETIME );
         else if ( (*pElem1)->iFldType == fldDATE
                && (*pElem2)->iFldType == fldDATETIMEOFFSET )
            *pElem1 = CastTo( *pElem1, pStream, fldDATETIMEOFFSET );
         else if ( (*pElem2)->iFldType == fldDATE
                && (*pElem1)->iFldType == fldDATETIMEOFFSET )
            *pElem2 = CastTo( *pElem2, pStream, fldDATETIMEOFFSET );
      }
      else
         *pElem1  = CastTo( *pElem1, pStream, (*pElem2)->iFldType );
   }
   else if(  (*pElem1)->iFldType ==  fldUNICODE
             || (*pElem2)->iFldType ==  fldUNICODE )
   {
      // cast to wider type except ftWideMemo (fldBLOB/fldstWideMemo)
      //
      if( ((*pElem1)->iFldType !=  fldUNICODE) && ((*pElem1)->iFldType != fldBLOB) )
         *pElem1  = CastTo( *pElem1, pStream, fldUNICODE);
      else if( ((*pElem2)->iFldType !=  fldUNICODE) && ((*pElem2)->iFldType != fldBLOB) )
         *pElem2  = CastTo( *pElem2, pStream, fldUNICODE);
   }
}

BOOL IsNoArgFunc(
   pQCanExecElem pElem
)
{
  return !StrCmpI(pElem->pszFuncName, "count(*)" )
           || !StrCmpI(pElem->pszFuncName, "getdate");
}
// TODO:
// coercions here ?
// mixed size numeric  args
// if mixed case ops like datetime arith, ...

VOID QCanExpr::BuildOp (
   pQCanExecElem      pElem1,
   pQCanExecElem      pElem2,
   pQCanExecElem      pElem3,
   pQCanExecElem      pElemRes,
   BOOL               bIsAgg
)
{
   UINT16 i;
   UINT16  iExtraAcumSpace = 0;
   BOOL    bSingleOpStringFunc = FALSE;
   BOOL    bSingleOpDateFunc = FALSE;
   BOOL    bSingleOpTimeFunc = FALSE;

   pStream = pStream;
   pElemRes->iFldType = 0;

   pElemRes->eAggFunc = aggopNoop;
   pElemRes->eFuncType = CanNoop;

   if( pElemRes->eType == qnodeFunc )
   {

      if( !IsNoArgFunc(pElemRes) && !pElem1 )
      {
         errRslt = DBIERR_TYPEMISM;
         goto Exit;
      }

      if( pElem1 )
      {
         pElemRes->iFldType = pElem1->iFldType;
         pElemRes->iResLen = pElem1->iResLen;
      }

      if( !StrCmpI(pElemRes->pszFuncName, "trim" ) )
      {
         pElemRes->eFuncType = pElem1->iFldType == fldZSTRING ?
            CanTrimBoth:
            CanUnicodeTrimBoth;
         // bSingleOpStringFunc = TRUE;
      }
      else if(
         !StrCmpI(pElemRes->pszFuncName, "triml" )
         || !StrCmpI(pElemRes->pszFuncName, "trimleft" )
      )
      {
         pElemRes->eFuncType = pElem1->iFldType == fldZSTRING ?
            CanTrimLead:
            CanUnicodeTrimLead;
         // bSingleOpStringFunc = TRUE;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "trimt" )
        ||  !StrCmpI(pElemRes->pszFuncName, "trimright" )
      )
      {
         pElemRes->eFuncType = pElem1->iFldType == fldZSTRING ?
            CanTrimTrail:
            CanUnicodeTrimTrail;
         //bSingleOpStringFunc = TRUE;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "upper" ) )
      {
         pElemRes->eFuncType = pElem1->iFldType == fldZSTRING ?
            CanStringUpper:
            CanUnicodeStringUpper;
         bSingleOpStringFunc = TRUE;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "lower" ) )
      {
         pElemRes->eFuncType = pElem1->iFldType == fldZSTRING ?
            CanStringLower:
            CanUnicodeStringLower;
         bSingleOpStringFunc = TRUE;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "substring" ) )
      {
         if( pElem3 )
         {
            pElemRes->eFuncType = (pElemRes->iFldType == fldZSTRING) ?
              CanSubstring3:
              CanUnicodeSubstring3;
            if( !IsNumeric(pElem3) )
              errRslt = DBIERR_TYPEMISM;
         }
         else
            pElemRes->eFuncType = (pElemRes->iFldType == fldZSTRING) ?
              CanSubstring2:
              CanUnicodeSubstring2;
         if( ( pElem1->iFldType != fldZSTRING ) &&
             ( pElem1->iFldType != fldUNICODE ) )
            errRslt = DBIERR_TYPEMISM;
         if( !pElem2 || !IsNumeric(pElem2) )
            errRslt = DBIERR_TYPEMISM;
      
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "Year" ) )
      {
         pElemRes->iFldType = fldFLOAT;
         pElemRes->iResLen = sizeof(DFLOAT);
         if( pElem1->iFldType == fldDATE )
            pElemRes->eFuncType = CanExtractYearFromDate;
         else if( pElem1->iFldType == fldDATETIME )
            pElemRes->eFuncType = CanExtractYearFromSQLTS;
         else if ( pElem1->iFldType == fldDATETIMEOFFSET )
            pElemRes->eFuncType = CanExtractYearFromSQLTSOS;
         else
            pElemRes->eFuncType = CanExtractYearFromTS;
         bSingleOpDateFunc = TRUE;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "Month" ) )
      {
         pElemRes->iFldType = fldFLOAT;
         pElemRes->iResLen = sizeof(DFLOAT);
         if( pElem1->iFldType == fldDATE )
            pElemRes->eFuncType = CanExtractMonthFromDate;
         else if( pElem1->iFldType == fldDATETIME )
            pElemRes->eFuncType = CanExtractMonthFromSQLTS;
         else if ( pElem1->iFldType == fldDATETIMEOFFSET )
            pElemRes->eFuncType = CanExtractMonthFromSQLTSOS;
         else
            pElemRes->eFuncType = CanExtractMonthFromTS;
         bSingleOpDateFunc = TRUE;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "Day" ) )
      {
         pElemRes->iFldType = fldFLOAT;
         pElemRes->iResLen = sizeof(DFLOAT);
         if( pElem1->iFldType == fldDATE )
            pElemRes->eFuncType = CanExtractDayFromDate;
         else if( pElem1->iFldType == fldDATETIME )
            pElemRes->eFuncType = CanExtractDayFromSQLTS;
         else if( pElem1->iFldType == fldDATETIMEOFFSET )
            pElemRes->eFuncType = CanExtractDayFromSQLTSOS;
         else
            pElemRes->eFuncType = CanExtractDayFromTS;
         bSingleOpDateFunc = TRUE;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "Hour" ) )
      {
         pElemRes->iFldType = fldFLOAT;
         pElemRes->iResLen = sizeof(DFLOAT);
         if( pElem1->iFldType == fldTIME )
            pElemRes->eFuncType = CanExtractHourFromTime;
         else if( pElem1->iFldType == fldDATETIME )
            pElemRes->eFuncType = CanExtractHourFromSQLTS;
         else if( pElem1->iFldType == fldDATETIMEOFFSET )
            pElemRes->eFuncType = CanExtractHourFromSQLTSOS;
         else
            pElemRes->eFuncType = CanExtractHourFromTS;
         bSingleOpTimeFunc = TRUE;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "Minute" ) )
      {
         pElemRes->iFldType = fldFLOAT;
         pElemRes->iResLen = sizeof(DFLOAT);
         if( pElem1->iFldType == fldTIME )
            pElemRes->eFuncType = CanExtractMinFromTime;
         else if( pElem1->iFldType == fldDATETIME )
            pElemRes->eFuncType = CanExtractMinFromSQLTS;
         else if( pElem1->iFldType == fldDATETIMEOFFSET )
            pElemRes->eFuncType = CanExtractMinFromSQLTSOS;
         else
            pElemRes->eFuncType = CanExtractMinFromTS;
         bSingleOpTimeFunc = TRUE;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "Second" ) )
      {
         pElemRes->iFldType = fldFLOAT;
         pElemRes->iResLen = sizeof(DFLOAT);
         if( pElem1->iFldType == fldTIME )
            pElemRes->eFuncType = CanExtractSecFromTime;
         else if( pElem1->iFldType == fldDATETIME )
            pElemRes->eFuncType = CanExtractSecFromSQLTS;
         else if( pElem1->iFldType == fldDATETIMEOFFSET )
            pElemRes->eFuncType = CanExtractSecFromSQLTSOS;
         else
            pElemRes->eFuncType = CanExtractSecFromTS;
         bSingleOpTimeFunc = TRUE;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "getdate" ) )
      {
         pElemRes->iFldType = fldTIMESTAMP;
         pElemRes->iResLen = sizeof(TIMESTAMP);
         pElemRes->eFuncType = CanGetDateTime;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "getsqldate" ) )
      {
         pElemRes->iFldType = fldDATETIME;
         pElemRes->iResLen = sizeof(SQLTIMESTAMP);
         pElemRes->eFuncType = CanGetSqlTimestamp;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "getsqldateoffset" ) )
      {
         pElemRes->iFldType = fldDATETIMEOFFSET;
         pElemRes->iResLen = sizeof(SQLTIMESTAMPOFFSET);
         pElemRes->eFuncType = CanGetSqlTimestampOffset;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "sum" ) )
      {
         pElemRes->iFldType = fldFLOAT;
         pElemRes->iResLen = sizeof(DFLOAT);
         if( pElem1->iFldType == fldINT8 )
            pElemRes->eAggFunc = aggopSmallSum;
         else if( pElem1->iFldType == fldINT16 )
            pElemRes->eAggFunc = aggopShortSum;
         else if( pElem1->iFldType == fldINT32 )
            pElemRes->eAggFunc = aggopLongSum;
         else if( pElem1->iFldType == fldINT64 )
            pElemRes->eAggFunc = aggopLongIntSum;
         else if( pElem1->iFldType == fldUINT8 )
            pElemRes->eAggFunc = aggopByteSum;
         else if( pElem1->iFldType == fldUINT16 )
            pElemRes->eAggFunc = aggopWordSum;
         else if( pElem1->iFldType == fldUINT32 )
            pElemRes->eAggFunc = aggopLongWordSum;
         else if( pElem1->iFldType == fldUINT64 )
            pElemRes->eAggFunc = aggopU64Sum;
         else if( pElem1->iFldType == fldSINGLE )
            pElemRes->eAggFunc = aggopSingleSum;
         else if( pElem1->iFldType == fldFLOAT )
            pElemRes->eAggFunc = aggopFloatSum;
         else if( pElem1->iFldType == fldBCD )
         {
            pElemRes->iFldType = fldBCD;
            pElemRes->iResLen = pElem1->iResLen;
            pElemRes->eAggFunc = aggopBcdSum;
         }
         else if( pElem1->iFldType == fldFMTBCD )
         {
            pElemRes->iFldType = fldFMTBCD;
            pElemRes->iResLen = pElem1->iResLen;
            pElemRes->eAggFunc = aggopBcdSum;
         }
      }
      else if( (StrCmpI(pElemRes->pszFuncName, "min" ) == 0) ||
               (StrCmpI(pElemRes->pszFuncName, "max" ) == 0) )
      {
         BOOL fMin = StrCmpI(pElemRes->pszFuncName, "min" ) == 0;

         pElemRes->iFldType = pElem1->iFldType;
         pElemRes->iResLen = pElem1->iResLen;
         if( pElem1->iFldType == fldZSTRING )
            pElemRes->eAggFunc = fMin ? aggopStringMin : aggopStringMax;
         else if( pElem1->iFldType == fldINT8 )
            pElemRes->eAggFunc = fMin ? aggopSmallMin : aggopSmallMax;
         else if( pElem1->iFldType == fldINT16 )
            pElemRes->eAggFunc = fMin ? aggopShortMin : aggopShortMax;
         else if( pElem1->iFldType == fldINT32
             || pElem1->iFldType == fldDATE
             || pElem1->iFldType == fldTIME )
            pElemRes->eAggFunc = fMin ? aggopLongMin : aggopLongMax;
         else if( pElem1->iFldType == fldINT64 )
            pElemRes->eAggFunc = fMin ? aggopLongIntMin : aggopLongIntMax;
         else if( pElem1->iFldType == fldUINT8 )
            pElemRes->eAggFunc = fMin ? aggopByteMin : aggopByteMax;
         else if( pElem1->iFldType == fldUINT16 )
            pElemRes->eAggFunc = fMin ? aggopWordMin : aggopWordMax;
         else if( pElem1->iFldType == fldUINT32 )
            pElemRes->eAggFunc = fMin ? aggopLongWordMin : aggopLongWordMax;
         else if( pElem1->iFldType == fldUINT64 )
            pElemRes->eAggFunc = fMin ? aggopU64Min : aggopU64Max;
         else if( pElem1->iFldType == fldFLOAT
             || pElem1->iFldType == fldTIMESTAMP )
            pElemRes->eAggFunc = fMin ? aggopFloatMin : aggopFloatMax;
         else if( pElem1->iFldType == fldSINGLE )
            pElemRes->eAggFunc = fMin ? aggopSingleMin : aggopSingleMax;
         else if( pElem1->iFldType == fldDATETIME )
            pElemRes->eAggFunc = fMin ? aggopSqlTimestampMin : aggopSqlTimestampMax;
         else if( pElem1->iFldType == fldDATETIMEOFFSET )
            pElemRes->eAggFunc = fMin ? aggopSqlTimestampOffsetMin : aggopSqlTimestampOffsetMax;
         else if( pElem1->iFldType == fldBCD )
         {
            pElemRes->iFldType = fldBCD;
            pElemRes->iResLen = pElem1->iResLen;
            pElemRes->eAggFunc = fMin ? aggopBcdMin : aggopBcdMax;
         }
         else if( pElem1->iFldType == fldFMTBCD )
         {
            pElemRes->iFldType = fldFMTBCD;
            pElemRes->iResLen = pElem1->iResLen;
            pElemRes->eAggFunc = fMin ? aggopBcdMin : aggopBcdMax;
         }
         else if ( pElem1->iFldType == fldUNICODE )
         {
            pElemRes->eAggFunc = fMin ? aggopUnicodeMin : aggopUnicodeMax;
         }
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "count" ) )
      {
         pElemRes->iFldType = fldINT32;
         pElemRes->iResLen = sizeof(INT32);
         pElemRes->eAggFunc = aggopCount;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "count(*)" ) )
      {
         pElemRes->iFldType = fldINT32;
         pElemRes->iResLen = sizeof(INT32);
         pElemRes->eAggFunc = aggopCountAll;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "avg" ) )
      {
         if( pElem1->iFldType == fldDATE )
         {
            pElemRes->eAggFunc = aggopDateAvg;
            pElemRes->iFldType = fldDATE;
            pElemRes->iResLen = sizeof(DBIDATE);
            iExtraAcumSpace = (UINT16) (iExtraAcumSpace + sizeof(DFLOAT));
         }
         else if( pElem1->iFldType == fldTIME )
         {
            pElemRes->eAggFunc = aggopDateAvg;
            pElemRes->iFldType = fldTIME;
            pElemRes->iResLen = sizeof(TIME);
            iExtraAcumSpace = (UINT16) (iExtraAcumSpace + sizeof(DFLOAT));
         }
         else if( pElem1->iFldType == fldTIMESTAMP )
         {
            pElemRes->eAggFunc = aggopFloatAvg;
            pElemRes->iFldType = fldTIMESTAMP;
            pElemRes->iResLen = sizeof(TIMESTAMP);
         }
         else if( pElem1->iFldType == fldDATETIME )
         {
            pElemRes->eAggFunc = aggopSqlTimestampAvg;
            pElemRes->iFldType = fldDATETIME;
            pElemRes->iResLen = sizeof(SQLTIMESTAMP);
         }
         else if( pElem1->iFldType == fldDATETIMEOFFSET )
         {
            pElemRes->eAggFunc = aggopSqlTimestampOffsetAvg;
            pElemRes->iFldType = fldDATETIMEOFFSET;
            pElemRes->iResLen = sizeof(SQLTIMESTAMPOFFSET);
         }
         else
         {
            pElemRes->iFldType = fldFLOAT;
            pElemRes->iResLen = sizeof(DFLOAT);
            if( pElem1->iFldType == fldINT8 )
               pElemRes->eAggFunc = aggopSmallAvg;
            else if( pElem1->iFldType == fldINT16 )
               pElemRes->eAggFunc = aggopShortAvg;
            else if( pElem1->iFldType == fldINT32 )
               pElemRes->eAggFunc = aggopLongAvg;
            else if( pElem1->iFldType == fldINT64 )
               pElemRes->eAggFunc = aggopLongIntAvg;
            if( pElem1->iFldType == fldUINT8 )
               pElemRes->eAggFunc = aggopByteAvg;
            else if( pElem1->iFldType == fldUINT16 )
               pElemRes->eAggFunc = aggopWordAvg;
            else if( pElem1->iFldType == fldUINT32 )
               pElemRes->eAggFunc = aggopLongWordAvg;
            else if( pElem1->iFldType == fldUINT64 )
               pElemRes->eAggFunc = aggopU64Avg;
            else if( pElem1->iFldType == fldFLOAT )
               pElemRes->eAggFunc = aggopFloatAvg;
            else if( pElem1->iFldType == fldSINGLE )
               pElemRes->eAggFunc = aggopSingleAvg;
            else if( pElem1->iFldType == fldBCD )
            {
               pElemRes->iFldType = fldBCD;
               pElemRes->iResLen = pElem1->iResLen;
               pElemRes->eAggFunc = aggopBcdAvg;
            }
            else if( pElem1->iFldType == fldFMTBCD )
            {
               pElemRes->iFldType = fldFMTBCD;
               pElemRes->iResLen = pElem1->iResLen;
               pElemRes->eAggFunc = aggopBcdAvg;
            }
         }
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "Date" ) )
      {
         pElemRes->iFldType = fldDATE;
         pElemRes->iResLen = sizeof(DBIDATE);
         pElemRes->eFuncType = CanExtractDateFromTS;
         bSingleOpDateFunc = TRUE;
      }
      else if( !StrCmpI(pElemRes->pszFuncName, "Time" ) )
      {
         pElemRes->iFldType = fldTIME;
         pElemRes->iResLen = sizeof(TIME);
         pElemRes->eFuncType = CanExtractTimeFromTS;
         bSingleOpTimeFunc = TRUE;
      }
   }
   else if( pElemRes->eType == qnodeIsNull
      || pElemRes->eType == qnodeIsNotNull
   )
   {
      pElemRes->iFldType = fldBOOL;
      pElemRes->iResLen = sizeof(BOOL16);
      if( pElemRes->eType == qnodeIsNull )
         pElemRes->eFuncType = CanIsNull;
      else
         pElemRes->eFuncType = CanIsNotNull;
   }
   else if( pElemRes->eType == qnodeAssign )
   {
      if( pElem1->iFldType == pElem2->iFldType )
      {
         pElemRes->iFldType = pElem1->iFldType;
         pElemRes->iResLen = pElem1->iResLen;
         pElemRes->eFuncType = CanAssign;
         if( pElem2 )
         {
            pElemRes->iResUnits1 =  pElem2->iResUnits1;
            pElemRes->iResUnits2 =  pElem2->iResUnits2;
         }
      }
#if 0
      else
      {
         if( IsNumeric( pElem1 ) && IsNumeric( pElem2 ) )
         {
            pElemRes->iFldType = pElem2->iFldType;
            pElemRes->iResLen = pElem2->iResLen;
            if( pElem2->iFldType == fldINT16 )
               pElemRes->eFuncType = CanFloatToShort;
            else if ( pElem2->iFldType == fldINT32 )
               pElemRes->eFuncType = CanFloatToLong;
            else if ( pElem2->iFldType == fldINT64 )
               pElemRes->eFuncType = CanFloatToInt64;
         }
      }
#endif
   }
   else if ( pElemRes->eType ==  qnodeIN )
   {
      pElemRes->iFldType = fldBOOL;
      pElemRes->iResLen = sizeof(BOOL16);
      pElemRes->eFuncType = CanIN;
      if( pElem1->iFldType == fldBLOB )
      {
         errRslt = DBIERR_TYPEMISM;
         goto Exit;
      }
   }
   else if( !pElem2 && pElemRes->eType != qnodeFunc )
   {
      pUnOpsArgs pOpsArgs = UnOps[ pElemRes->eType ];
      for( i=0; pOpsArgs[i].iRetType != 0 ; i++)
      {
         if( pOpsArgs[i].iArgType == pElem1->iFldType )
         {
            pElemRes->iFldType = pElem1->iFldType;
            break;
         }
      }
      if( pElemRes->iFldType == 0 )
      {
         errRslt = DBIERR_TYPEMISM;
         goto Exit; // error typemism;
      }
      // TODO: BCD
      if( pElem1->iFldType == fldZSTRING )
         pElemRes->iResLen = pElem1->iResLen;
      else
         pElemRes->iResLen = GetResLen(pElemRes->iFldType, pElem1->iResLen);

      if( !IsAgg( pElemRes->eType ) )
      {
         if( pElemRes->eType == qnodeNot )
            pElemRes->eFuncType = CanBoolNot;
         else if ( pElemRes->eType == qnodeIsNull)
            pElemRes->eFuncType = CanIsNull;
         else if ( pElemRes->eType == qnodeNegate )
         {
            if( pElem1->iFldType == fldINT8 )
               pElemRes->eFuncType = CanShortIntNegate;
            else if( pElem1->iFldType == fldINT16 )
               pElemRes->eFuncType = CanShortNegate;
            else if( pElem1->iFldType == fldINT32 )
               pElemRes->eFuncType = CanLongNegate;
            else if( pElem1->iFldType == fldINT64 )
               pElemRes->eFuncType = CanInt64Negate;
            else if( pElem1->iFldType == fldSINGLE )
               pElemRes->eFuncType = CanSingleNegate;
            else if( pElem1->iFldType == fldFLOAT )
               pElemRes->eFuncType = CanFloatNegate;
            else if( pElem1->iFldType == fldBCD || pElem1->iFldType == fldFMTBCD )
               pElemRes->eFuncType = CanBcdNegate;
         }
#if 0
           else if ( pElemRes->eType == qnodeTrim1Ops )
           else if ( pElemRes->eType == qnodeCaseSwitchOps )
           else if ( pElemRes->eType == qnodeCaseSwitchOps )
#endif
      }
   }
   else if( pElem2 && pElem1->iFldType == pElem2->iFldType )
   {
      if( pElem2->iFldType == fldUNICODE )
      {
         pElemRes->iFldType = fldBOOL;
         pElemRes->iResLen = sizeof(BOOL16);
         switch ( pElemRes->eType )
         {
            case qnodeEqual:
               pElemRes->eFuncType = CanUnicodeStringEqual;
               break;
            case qnodeGreaterEq:
               pElemRes->eFuncType = CanUnicodeStringGreaterEq;
               break;
            case qnodeGreater:
               pElemRes->eFuncType = CanUnicodeStringGreater;
               break;
            case qnodeLessEq:
               pElemRes->eFuncType = CanUnicodeStringLessEq;
               break;
            case qnodeLess:
               pElemRes->eFuncType = CanUnicodeStringLess;
               break;
            case qnodeNotEqual:
               pElemRes->eFuncType = CanUnicodeStringNotEqual;
               break;
            case qnodeLike:
               pElemRes->eFuncType = CanUnicodeStringLike;
               break;

            case qnodeAdd:
               pElemRes->eFuncType = CanUnicodeStringAdd;
               pElemRes->iFldType = fldUNICODE;
               pElemRes->iResLen = (UINT16) (pElem1->iResLen + pElem2->iResLen);
               break;
            default:
               break;
         }
      }
      else
      {
         pQFieldFuncType pQCanFuncsByOp = QCanFuncsByOp[(UINT16)pElemRes->eType];
         pBinOpsArgs pOpsArgs = BinOps[ pElemRes->eType ];
         for( i=0; pOpsArgs[i].iRetType != 0 ; i++)
         {
            if( pOpsArgs[i].iLeftType == pElem1->iFldType
               && pOpsArgs[i].iRightType == pElem2->iFldType
            )
            {
               pElemRes->iFldType = pOpsArgs[i].iRetType;
               break;
            }
         }

         if( pElemRes->iFldType == 0 )
         {
            errRslt = DBIERR_TYPEMISM;
            goto Exit;
         }

         if( pElem1->iFldType == fldZSTRING && pElem2->iFldType == fldZSTRING
            && pElemRes->eType == qnodeAdd
         )
            pElemRes->iResLen = (UINT16) (pElem1->iResLen + pElem2->iResLen);
         else
            pElemRes->iResLen = GetResLen( pElemRes->iFldType, pElem1->iResLen);
   
         pElemRes->eFuncType = pQCanFuncsByOp[(UINT16)pElem1->iFldType];
      }
   }
   else if( pElem2 && pElem1->iFldType != pElem2->iFldType )
   {
      if( pElemRes->eType == qnodeAdd )
      {
         switch( pElem1->iFldType )
         {
           case fldDATETIME:
             pElemRes->eFuncType = CanSqlTimestampFloatAdd;
             pElemRes->iFldType = fldDATETIME;
             pElemRes->iResLen = sizeof( SQLTIMESTAMP);
             break;
           case fldDATETIMEOFFSET:
             pElemRes->eFuncType = CanSqlTimestampOffsetFloatAdd;
             pElemRes->iFldType = fldDATETIMEOFFSET;
             pElemRes->iResLen = sizeof( SQLTIMESTAMPOFFSET);
             break;
           case fldTIMESTAMP:
             pElemRes->eFuncType = CanDatetimeFloatAdd;
             pElemRes->iFldType = fldTIMESTAMP;
             pElemRes->iResLen = sizeof( TIMESTAMP);
             break;
           case fldDATE:
             pElemRes->eFuncType = CanDateFloatAdd;
             pElemRes->iFldType = fldDATE;
             pElemRes->iResLen = sizeof( DBIDATE );
             break;
           case fldTIME:
             pElemRes->eFuncType = CanTimeFloatAdd;
             pElemRes->iFldType = fldTIME;
             pElemRes->iResLen = sizeof( TIME );
             break;
         }
      }
      else if( pElemRes->eType == qnodeSubtract )
      {
         switch( pElem1->iFldType )
         {
            case fldDATETIME:
              pElemRes->eFuncType = CanSqlTimestampFloatSubtract;
              pElemRes->iFldType = fldDATETIME;
              pElemRes->iResLen = sizeof( SQLTIMESTAMP );
              break;
            case fldDATETIMEOFFSET:
              pElemRes->eFuncType = CanSqlTimestampOffsetFloatSubtract;
              pElemRes->iFldType = fldDATETIMEOFFSET;
              pElemRes->iResLen = sizeof( SQLTIMESTAMPOFFSET );
              break;
            case fldTIMESTAMP:
              pElemRes->eFuncType = CanDatetimeFloatSubtract;
              pElemRes->iFldType = fldTIMESTAMP;
              pElemRes->iResLen = sizeof( TIMESTAMP );
              break;
            case fldDATE:
              pElemRes->eFuncType = CanDateFloatSubtract;
              pElemRes->iFldType = fldDATE;
              pElemRes->iResLen = sizeof( DBIDATE );
              break;
            case fldTIME:
              pElemRes->eFuncType = CanTimeFloatSubtract;
              pElemRes->iFldType = fldTIME;
              pElemRes->iResLen = sizeof( TIME );
              break;
         }
      }
      else if( pElemRes->eType == qnodeLike && pElem1->iFldType == fldBLOB )
      {
         pElemRes->eFuncType = (pDS->pFieldDesc[pElem1->iFldNum - 1].iFldSubType == fldstWIDEMEMO ) ?
            CanUnicodeMemoLike : CanMemoLike;
         pElemRes->iFldType = fldBOOL;
         pElemRes->iResLen = sizeof( BOOL16 );
      }
   }

   if( pElemRes->eFuncType == CanNoop && pElemRes->eAggFunc == aggopNoop )
      errRslt = DBIERR_TYPEMISM;

   if( bSingleOpStringFunc &&
       ((pElem1->iFldType != fldZSTRING) && (pElem1->iFldType != fldUNICODE)) )
      errRslt = DBIERR_TYPEMISM; // TODO errRslt = DBIERR_ARGCOUNT;

   if( bSingleOpStringFunc && pElem2 )
      errRslt = DBIERR_TYPEMISM; // TODO errRslt = DBIERR_ARGCOUNT;

   if( bSingleOpDateFunc && pElem1->iFldType != fldDATE
         && pElem1->iFldType != fldTIMESTAMP 
   )
      errRslt = DBIERR_TYPEMISM;

   if( bSingleOpTimeFunc && pElem1->iFldType != fldTIME
         && pElem1->iFldType != fldTIMESTAMP 
   )
      errRslt = DBIERR_TYPEMISM;

   if( pElem1 )
   {

      if( pElem1->bIsAgg )
      {
         pElemRes->iArg1Off = pElem1->iAggAcumOff;
         pElemRes->iArg1NullOff = pElem1->iResNullOff;
         pElemRes->ppRecReg1 = ppAggBuf;
      }
      else 
      {
         pElemRes->ppRecReg1 = pElem1->ppRecRegRes;
         pElemRes->iArg1Off = pElem1->iResOff;
         pElemRes->iArg1NullOff = pElem1->iResNullOff;
      }

      pElemRes->iLen =  pElem1->iResLen; 
      pElemRes->iArg1Units1 =  pElem1->iResUnits1;
      pElemRes->iArg1Units2 =  pElem1->iResUnits2;
      pElemRes->iFldNum =  pElem1->iFldNum;
   }
   if( pElem2 )
   {
      if( pElem2->bIsAgg )
      {
         pElemRes->iArg2Off = pElem2->iAggAcumOff;
         pElemRes->iArg2NullOff = pElem2->iResNullOff;
         pElemRes->ppRecReg2 = ppAggBuf;
      }
      else
      {
         pElemRes->iArg2Off = pElem2->iResOff;
         pElemRes->iArg2NullOff = pElem2->iResNullOff;
         pElemRes->ppRecReg2 = pElem2->ppRecRegRes;
      }
      pElemRes->iArgFldType =  pElem2->iFldType;
      pElemRes->iArg2Units1 =  pElem2->iResUnits1;
      pElemRes->iArg2Units2 =  pElem2->iResUnits2;

      pElemRes->iLen2 =  pElem2->iResLen;
      pElemRes->iUnitLen =  pElem2->iUnitLen;
      pElemRes->iNumElems =  pElem2->iNumElems;
   }
   if( pElem3 )
   {
      pElemRes->ppRecReg3 = pElem3->ppRecRegRes;
      pElemRes->iArg3Off = pElem3->iResOff;
      pElemRes->iArg3NullOff = pElem3->iResNullOff;
      pElemRes->iLen3 =  pElem3->iResLen;
   }

   if ( pElemRes->iFldType == fldZSTRING )
      pElemRes->iResUnits1 = pElemRes->iResLen;

   if( bIsAgg )
   {
      iExtraAcumSpace = (UINT16) (iExtraAcumSpace + sizeof(UINT32));
      pElemRes->pRecRegRes = NULL;
      pElemRes->ppRecRegRes = &pAggB;
      pElemRes->iResOff =  iCurAggAcumOff;
      pElemRes->iResNullOff = (UINT16) (iCurAggAcumOff + pElemRes->iResLen);
   }
   else
   {
     pElemRes->pRecRegRes = 
                      new BYTE[pElemRes->iResLen + NULLINDLEN + iExtraAcumSpace];
      pElemRes->ppRecRegRes = &pElemRes->pRecRegRes;
      pElemRes->iResOff =  0;
      pElemRes->iResNullOff =  pElemRes->iResLen;
   }
   pElemRes->iExtraAcumSpace  =  iExtraAcumSpace;

   if( ( pElemRes->iFldType == fldBCD || pElemRes->iFldType == fldFMTBCD ) && bIsAgg && pElem1 )
   {
      pElemRes->iResUnits1 =  pElem1->iResUnits1;
      pElemRes->iResUnits2 =  pElem1->iResUnits2;
   }

   if( bIsAgg )
   {
      pElemRes->bIsAgg = TRUE;
      pElemRes->iAggAcumOff = iCurAggAcumOff;
      iCurAggAcumOff = (UINT16) (iCurAggAcumOff + (pElemRes->iResLen + NULLINDLEN + iExtraAcumSpace));
   }
   else
      pElemRes->bIsAgg = FALSE;

Exit:
   return;
}

QNodeType QCanExpr::CanNodeToQNode (
   CANOp canOp
)
{
   QNodeType nodeType = (QNodeType) 0;
   switch( canOp )
   {
      case canEQ:
         nodeType = qnodeEqual;
         break;
      case canNE:                     
         nodeType = qnodeNotEqual;
         break;
      case canGT:                    
         nodeType = qnodeGreater;
         break;
      case canLT:                   
         nodeType = qnodeLess;
         break;
      case canGE:                  
         nodeType = qnodeGreaterEq;
         break;
      case canLE:                 
         nodeType = qnodeLessEq;
         break;
      case canAND:
         nodeType = qnodeAnd;
         break;
      case canOR:                         
         nodeType = qnodeOr;
         break;
      case canLIKE:
         nodeType = qnodeLike;
         break;
      case canADD:
         nodeType = qnodeAdd;
         break;
      case canSUB:
         nodeType = qnodeSubtract;
         break;
      case canMUL:
         nodeType = qnodeMultiply;
         break;
      case canDIV:
         nodeType = qnodeDivide;
         break;
      case canSUM:
         nodeType = qnodeTotal;
         break;
      case canCOUNT:
         nodeType = qnodeCount;
         break;
      case canMIN:
         nodeType = qnodeMin;
         break;
      case canMAX:
         nodeType = qnodeMax;
         break;
      case canAVG:
         nodeType = qnodeAvg;
         break;
      case canLIST:
         nodeType = qnodeList;
         break;
      case canIN:
         nodeType = qnodeIN;
         break;
      case canASSIGN:
         nodeType = qnodeAssign;
         break;
      case canMOD:
         // ThrowError(DBIERR_NOTSUPPORTED);
         break;
      case canREM:
         // ThrowError(DBIERR_NOTSUPPORTED);
         break;
      case canISBLANK:
         nodeType = qnodeIsNull;
         break;
      case canNOTBLANK:
         nodeType = qnodeIsNotNull;
         break;
      case canFUNC:
         nodeType = qnodeFunc;
         break;
      case canNOT:                          
         nodeType = qnodeNot;
         break;
      default: 
         // ThrowError(DBIERR_NOTSUPPORTED);
            break;
   }
   return nodeType;
}

DBIResult QCanExpr::BuildExecStream (
   pCANExpr     pCanExprArg
)
{
   DBIResult rslt = DBIERR_NONE;
   if( pStream )
      delete pStream;
   pStream = new QCanExecStream();
   pStream->lcid = lcid;

   pStreamPostAgg = new QCanExecStream();
   pCanExpr = pCanExprArg;

   if( !pStream->pArgs || !pStream->pFieldExecElemSet )
   {
      rslt = DBIERR_NOMEMORY;
      goto Exit;
   }

   pNodePool = (pBYTE) pCanExpr + pCanExpr->iNodeStart;
   pLitPool = (pBYTE) pCanExpr + pCanExpr->iLiteralStart;

#ifdef _UNIX
//   if( (rslt = (DBIResult) Catch( (__jmp_buf_tag*) &JmpBuf)) != 0 )
#else
//   if( (rslt = (DBIResult) Catch(&JmpBuf)) != 0 )
#endif
//      goto Exit;

   CompileCanEx( (pCANNode) pNodePool, FALSE);

Exit:
   return rslt;
}

// TODO: tokenize earlier so as to avoid duplicate logic
BOOL IsAgg( pCHAR pszFuncName )
{
   return  !StrCmpI(pszFuncName, "count" ) 
         || !StrCmpI(pszFuncName, "avg" )
         || !StrCmpI(pszFuncName, "min" )
         || !StrCmpI(pszFuncName, "max" )
         || !StrCmpI(pszFuncName, "sum" )
         || !StrCmpI(pszFuncName, "count(*)");
}

pCHAR NextName(
   pCHAR pPart,
   pCHAR pFull
)
{
   UINT16 i;
   UINT16 len = (UINT16) StrLen(pFull);
   for(i=0; i < len && *pFull != '.'; i++)
      *pPart++ = *pFull++;
   *pPart = '\0';
   if( *pFull ) pFull++;
   return pFull;
}

pDSFLDDesc FindField(
   pCHAR      pFldNamePart,
   pCHAR      pFullFldName,
   pDSFLDDesc pFlds,
   UINT16     iNumElems
)
{
   UINT16 i;
   pDSFLDDesc pFld = NULL;
   pUCS2Char wideFldNamePart = UTF8ToWideChar(pFldNamePart);

   for( i=0; i < iNumElems; i++ )
   {
      pCHAR utf8FldName = pFlds[i].szName;
      pUCS2Char wideFldName = UTF8ToWideChar(utf8FldName);
      if( !WideStrLIComp(wideFldNamePart, -1, wideFldName, -1 ) )
      {
        pFld = &pFlds[i];
        if( pFld->iFldType == fldADT && *pFullFldName )
           pFld = FindField(pFldNamePart, NextName(pFldNamePart, pFullFldName),
                              &pFlds[i + 1], (UINT16) pFld->iUnits1);
        {
          free(wideFldName);
          break;
        }
      }
      free(wideFldName);
   }
   free(wideFldNamePart);
   return pFld;
}
pQCanExecElem QCanExpr::CompileCanEx (
   pCANNode           pcanNode,
   BOOL               bNullCheckOrLike
)
{
   UNREFERENCED_PARAMETER(bNullCheckOrLike);
   pQCanExecElem pElem = NULL;
   pQCanExecElem pElem1 = NULL;
   pQCanExecElem pElem2 = NULL;
   pQCanExecElem pElem3 = NULL;
   BOOL          bAddElem = TRUE;
   BOOL          bIsAgg = FALSE;
//   bNullCheckOrLike = bNullCheckOrLike;

   switch( pcanNode->canHdr.canOp )
   {
      case canFIELD:                      
      {
         pDSFLDDesc  pFld = NULL;
         UINT16 len;  // assigned 3 lines down
         pCHAR pFldName;
         pCHAR   pszFieldName = (pCHAR)(pLitPool +
                                 ((pCANField)pcanNode)->iNameOffset );
         len = (UINT16) StrLen(pszFieldName);
         pFldName = new CHAR[len + 1];

         pFld = FindField(pszFieldName, pszFieldName,
                            pDS->pFieldDesc,(UINT16) (pDS->iFields));

         if( !pFld )
            pFld = FindField(pFldName, NextName(pFldName,pszFieldName),
                          pDS->pFieldDesc, (UINT16)(pDS->iFields));
         delete[] pFldName;
/*
         if( !pFld )
            ThrowError(DBIERR_INVALIDFIELDNAME);
         if( pFld->iFldType == fldREF ||  pFld->iFldType == fldTABLE )
            ThrowError(DBIERR_NOTSUPPORTED);  */
/* TODO:
#define fldBOOL8          0x1003
#define fldBOOL16         fldBOOL
#define fldBOOL32         0x1004
#define fldUNICODE        0x1007  */

         pElem = new QCanExecElem();
         pElem->ppRecRegRes = ppRecBuf;
         pElem->iResOff = pFld->iFldOffsInRec;
         pElem->iResNullOff = pFld->iNullOffsInRec;
         pElem->iResLen = pFld->iFldLen;
         pElem->iFldType = (UINT16) pFld->iFldType;
         pElem->iResUnits1 = pFld->iUnits1;
         pElem->iResUnits2 = pFld->iUnits2;
         pElem->iFldNum = pFld->iFieldID;
         pStream->pArgs->AddElem( pElem );
         bAddElem = FALSE;
         break;
      }
      case canCONST:
      {
         pCANConst pCanConst = (pCANConst) pcanNode;

         pElem = new QCanExecElem();
         pElem->iResOff = 0;
         pElem->iResNullOff = 0;
         pElem->iFldType = pCanConst->iType;
         pStream->pArgs->AddElem( pElem );
         bAddElem = FALSE;

         if( pCanConst->iType == fldZSTRING )
            pElem->iResLen = (UINT16) (pCanConst->iSize + 1);
         else
            pElem->iResLen =  pCanConst->iSize;

         pElem->pRecRegRes = new BYTE[ pElem->iResLen + NULLINDLEN ];
         pElem->iResNullOff = pElem->iResLen;
         SETNULLVALUE(pElem->pRecRegRes + pElem->iResLen, FALSE);
         pElem->ppRecRegRes = &pElem->pRecRegRes;
         MemMove( pLitPool + pCanConst->iOffset, pElem->pRecRegRes,
                     pCanConst->iSize );
         break;
      }
      case canISBLANK:
      case canNOT:
      case canMINUS:
      case canNOTBLANK:
      {
         BOOL bNullCheck = ( pcanNode->canHdr.canOp == canISBLANK )
                             || ( pcanNode->canHdr.canOp == canNOTBLANK );
         pCANUnary pCanU = (pCANUnary) pcanNode;
         pElem1 = CompileCanEx( (pCANNode) (pNodePool + pCanU->iOperand1),
                                    bNullCheck);
         pElem = new QCanExecElem();
         pElem->eType = CanNodeToQNode( pcanNode->canHdr.canOp );
         BuildOp( pElem1, NULL, NULL, pElem, bIsAgg);
         break;
      }
      case canEQ:
      case canNE:
      case canGT:
      case canLT:
      case canGE:
      case canLE:
      case canAND:
      case canOR:
      case canLIKE:
      case canADD:
      case canSUB:
      case canMUL:
      case canDIV:
      case canASSIGN:
      {
         BOOL bNullCheck =  pcanNode->canHdr.canOp == canLIKE;

         if( pcanNode->canHdr.nodeClass == nodeCOMPARE )
         {
            pCANCompare pCanC = ( pCANCompare ) pcanNode;
            pElem1 = CompileCanEx( (pCANNode) (pNodePool + pCanC->iOperand1),
                                    bNullCheck);
            pElem2 = CompileCanEx( (pCANNode) (pNodePool + pCanC->iOperand2),
                                    bNullCheck);
            pElem = new QCanExecElem();
            pElem->bCaseInsensitive = pCanC->bCaseInsensitive;
            pElem->iPartialLen = pCanC->iPartialLen;
            if( ((pCANNode)(pNodePool + pCanC->iOperand1))->canHdr.canOp
               == canFIELD
            )
               pElem->bLeftIsField = TRUE;
            else
               pElem->bLeftIsField = FALSE;
         }
         else
         {
            pCANBinary pCanB = (pCANBinary) pcanNode;
            pElem1 = CompileCanEx( (pCANNode) (pNodePool + pCanB->iOperand1),
                                    bNullCheck);
            pElem2 = CompileCanEx( (pCANNode) (pNodePool + pCanB->iOperand2),
                                    bNullCheck);

            pElem = new QCanExecElem();
            pElem->bCaseInsensitive = FALSE;
            pElem->iPartialLen = 0;
         }
         pElem->eType = CanNodeToQNode( pcanNode->canHdr.canOp );
#if 0
         if( pcanNode->canHdr.canOp == canASSIGN )
            AddAssignCasts(pcanNode->canHdr.canOp, &pElem1, &pElem2, pElem,
                           pStream);
         else
#endif
            AddCasts(pcanNode->canHdr.canOp, &pElem1, &pElem2, pElem, pStream);
         BuildOp( pElem1, pElem2, NULL, pElem , bIsAgg);
         break;
      }
      /* aggs use canFUNC for now
      case canSUM:
      case canCOUNT:
      case canMIN:
      case canMAX:
      case canAVG:
      {
         pCANUnary pCanU = (pCANUnary) pcanNode;
         if( piAggNest )
            (*piAggNest)++;
         bIsAgg = TRUE;
         pElem1 = CompileCanEx( (pCANNode) (pNodePool + pCanU->iOperand1),
                                    FALSE);

         pElem = new QCanExecElem();
         pElem->eType = CanNodeToQNode( pcanNode->canHdr.canOp );
         BuildOp( pElem1, pElem2, NULL, pElem , bIsAgg);
         break;
      }
      */
      case canIN:
      {
         pCANNode  pcanNodeI;
         pCANBinary pCanB = (pCANBinary) pcanNode;
         pQCanExecElemSet pArgList = NULL;
         UINT16 iFldType;
         pElem1 = CompileCanEx( (pCANNode) (pNodePool + pCanB->iOperand1),
                                    FALSE);
         pcanNodeI =  (pCANNode) (pNodePool + pCanB->iOperand2);
         pElem = new QCanExecElem();
         pElem->eType = CanNodeToQNode( pcanNode->canHdr.canOp );

         if( pcanNodeI->canHdr.canOp == canLIST )
            pElem2 = CompileCanEx( (pCANNode) (pNodePool + pCanB->iOperand2),
                                    FALSE);
         else if( pcanNodeI->canHdr.canOp == canLISTELEM )
         {
            pQCanExecElem  pArg;
            pArgList = new QCanExecElemSet();
            while( pcanNodeI )
            {
               pArg = CompileCanEx( pcanNodeI, FALSE);
               if( pArg->iFldType != pElem1->iFldType )
                 AddCasts(pcanNodeI->canHdr.canOp,
                            &pElem1, &pArg, pElem, pStream);
               pArgList->AddElem(pArg);
               if( ((pCANListElem)pcanNodeI)->iNextOffset )
                  pcanNodeI = (pCANNode)(pNodePool + ((pCANListElem)pcanNodeI)->iNextOffset);
               else
                  pcanNodeI = NULL;
               iFldType = pArg->iFldType;
            }
         }
         if( pArgList )
         {
            pElem->pArgList = pArgList;
            pElem->iArgFldType = iFldType;
            pElem->iUnitLen = GetResLen(iFldType, 0);
         }
         BuildOp(pElem1, pElem2, NULL, pElem , bIsAgg);
         break;
      }
      case canLIST:
      {
         pCANList pCanL = (pCANList) pcanNode;
         pElem = new QCanExecElem();
         pElem->iResOff = 0;
         pElem->iResNullOff = 0;
         pElem->iFldType = pCanL->iType;            
         pElem->iResLen  =  pCanL->iTotalSize;           
         pElem->iUnitLen =  pCanL->iElemSize;           
         pElem->iNumElems =  pCanL->iElems;
         pStream->pArgs->AddElem( pElem );
         bAddElem = FALSE;

         pElem->pRecRegRes = new BYTE[ pElem->iResLen + NULLINDLEN ];
         pElem->ppRecRegRes = &pElem->pRecRegRes;
         MemMove( pLitPool + pCanL->iOffset, pElem->pRecRegRes, 
                     pCanL->iTotalSize );
         break;
      }
      case canFUNC:
      {
         pCANFunc pFuncNode = (pCANFunc) pcanNode;
         pCANListElem pFuncArg;
         UINT16 iNameLen =  (UINT16) StrLen(pLitPool + pFuncNode->iNameOffset);

         pElem = new QCanExecElem();
         pElem->pszFuncName = new CHAR[iNameLen + 1];
         StrCpy( pElem->pszFuncName, pLitPool + pFuncNode->iNameOffset);
         pElem->eType = CanNodeToQNode( pcanNode->canHdr.canOp );

         if( piAggNest && IsAgg( pElem->pszFuncName) )
         {
            bIsAgg = TRUE;
            (*piAggNest)++;
         }

         if( pFuncNode->iElemOffset )
         {
            pFuncArg = ( pCANListElem )( pNodePool + pFuncNode->iElemOffset );
            pElem1 = CompileCanEx( (pCANNode) pFuncArg, FALSE );
            if( pFuncArg->iNextOffset )
            {
               pFuncArg = (pCANListElem)( pNodePool + pFuncArg->iNextOffset );
               pElem2 = CompileCanEx((pCANNode) pFuncArg, FALSE );
               if( pFuncArg->iNextOffset )
               {
                  pFuncArg = (pCANListElem)(pNodePool + pFuncArg->iNextOffset);
                  pElem3 = CompileCanEx((pCANNode) pFuncArg, FALSE);
               }
            }
         }
         BuildOp( pElem1, pElem2, pElem3, pElem , bIsAgg);
         break;
      }
      case canLISTELEM:
      {
         pCANListElem pArg;
         pArg = ( pCANListElem ) pcanNode ;
         pElem = CompileCanEx((pCANNode)( pNodePool + pArg->iOffset), 
                                   FALSE);
         bAddElem = FALSE;
         break;
      }
      case canMOD:
      case canREM:
      default: ;
//         ThrowError(DBIERR_NOTSUPPORTED);
   }

   if( bAddElem && pElem )
   {
      if( piAggNest && *piAggNest == 0 && !bIsAgg )
         pStreamPostAgg->AddElem( pElem );
      else
         pStream->AddElem( pElem );

      // if( !piAggNest || bIsAgg || ( piAggNest && *piAggNest == 0 ) )
   }

   if( piAggNest && bIsAgg )
   {
      if( *piAggNest > 1 )
         errRslt = DBIERR_NOTSUPPORTED; // TODO: add new error message
      (*piAggNest)--;
   }

   return pElem;
}

QCanExpr::QCanExpr()
{
   ppRecBuf = &pRecB;
   ppAggBuf = &pAggB;
   pStream = NULL;
   pStreamPostAgg = NULL;
   piAggNest = NULL;
   errRslt = DBIERR_NONE;
}
QCanExpr::~QCanExpr()
{
   if( pStream )
      delete pStream;
   if( pStreamPostAgg )
      delete pStreamPostAgg;
}


QCanExecElem::QCanExecElem()
{
   SetMem( (pBYTE) this, sizeof( QCanExecElem ), 0 );
}

QCanExecElem::~QCanExecElem()
{
   if( pRecRegRes )
      delete[] pRecRegRes;
   if( pszFuncName )
      delete[] pszFuncName;
   if (pArgList)
      delete pArgList;
}

DBIResult QCanExpr::Compile (
   pCANExpr pCan
)
{
   DBIResult rslt;
//   piAggNest = NULL;
   iCurAggAcumOff = 0;
   rslt = BuildExecStream(pCan);
   pStream->lcid = lcid;
   if( errRslt )
      rslt = errRslt;
   return rslt;
}

////////////////////////////////////////////////////////////////////////////////
// CanFilter
QCanFilter::QCanFilter (
) : QCanExpr()
{
}
QCanFilter::~QCanFilter()
{
}

BOOL QCanFilter::Execute (
   pBYTE pRecBuf
)
{ 
   pRecB = pRecBuf; 
   pStream->pDS = pDS;
   return pStream->Execute( pRecBuf, eAggNoop, NULL );
}

#if 0
////////////////////////////////////////////////////////////////////////////////
// QCanCalcField:
QCanCalcField::QCanCalcField( 
) : QCanExpr()
{
}
QCanCalcField::~QCanCalcField( ) 
{
}

pFLDDesc QCanCalcField::GetResultType(pUINT16 pDataLen)
{
   pDataLen = pDataLen;
   return NULL;
}

DBIResult QCanCalcField::GetResult(AGGVALUE *pAgg, pBYTE pSrc, pBYTE pDest, pBOOL pbBlank)
{
   pAgg = pAgg;
   pSrc = pSrc;
   pDest = pDest;
   pbBlank = pbBlank;
   return DBIERR_NONE;
}
#endif

////////////////////////////////////////////////////////////////////////////////
// QCanAggregate:

QAggregate::QAggregate(
) : QCanExpr()
{
   pResElem = NULL;
   bInit = FALSE;
}
QAggregate::~QAggregate()
{
}
DBIResult QAggregate::Prepare(
   pBYTE       pExpr,
   pCANExpr    pCan,
   pDSBASE     pDs
)
{
//   pQCanExecElem pI;
   DBIResult rslt;
   UINT16 iAggNest = 0;
   iCurAggAcumOff = 0;
   pExpr = pExpr;
   piAggNest = &iAggNest;
   lcid = pDs->iLCID;
   pDS = pDs;
   rslt = BuildExecStream(pCan);
   if( pStreamPostAgg->pFieldExecElemSet->Length() != 0 )
      pResElem = pStreamPostAgg->GetResElem();
   else
      pResElem = pStream->GetResElem();
   if( errRslt )
      rslt = errRslt;
   return rslt;
}
VOID QAggregate::AddValue( 
   AGGVALUE *pAggValue,
   pBYTE pRecBuf
)
{
   pRecB = pRecBuf;
   pAggB = (pBYTE)(&pAggValue->Value);
   bInit = TRUE;
   pStream->Execute( pRecBuf, eAggAdd, pAggValue );
}
BOOL QAggregate::SubValue(
   AGGVALUE *pAggValue,
   pBYTE pRecBuf
)
{
   pRecB = pRecBuf;
   pAggB = (pBYTE)(&pAggValue->Value);
   return pStream->Execute( pRecBuf, eAggSub, pAggValue );
}

VOID QAggregate::Reset( AGGVALUE *pAggValue )
{
   // pRecB = pRecBuf;
   pStream->Execute( *ppRecBuf, eAggReset, pAggValue );
}

pFLDDesc  QAggregate::GetResultType(pUINT16 pDataLen)
{
   if( pResElem )
   {
      memset(&fldRes, 0, sizeof(FLDDesc));
      fldRes.iFldType = pResElem->iFldType;
      fldRes.iLen = pResElem->iResLen;
      fldRes.iUnits1 = pResElem->iResUnits1;
      fldRes.iUnits2 = pResElem->iResUnits2;
      if( pDataLen )
         *pDataLen = iCurAggAcumOff;
   }
   return &fldRes;
}

DBIResult   QAggregate::GetResult(
   AGGVALUE *pAggValue,
   pBYTE pSrc,
   pBYTE pDest,
   pBOOL pbBlank
)
{
   pAggB = (pBYTE)(&pAggValue->Value);
   if( pStreamPostAgg->pFieldExecElemSet->Length() != 0 )
   {
      pQCanExecElem pElemRes, pI;
      ForEachInSet( pStreamPostAgg->pFieldExecElemSet, pI )
         pElemRes = pI;
      pStreamPostAgg->Execute(NULL, eAggNoop, NULL);
      CopyMem(pDest, (*pElemRes->ppRecRegRes) + pElemRes->iResOff,
              pResElem->iResLen);
   }
   else
      CopyMem(pDest, pSrc + pResElem->iResOff, pResElem->iResLen);

   if( pbBlank )
      *pbBlank = ISNULLVALUE((pAggB + pResElem->iResNullOff)) || !bInit;

   return DBIERR_NONE;
}

////////////////////////////////////////////////////////////////////////////////
/// Utilities:

VOID   SetMem(
   pBYTE  pStr,
   UINT16 iLen,
   CHAR   val
)
{
   UINT16 i;
   for(i=0; i<iLen; i++)
      pStr[i] = val;
}

VOID   MemMove(
   pBYTE pSrc,
   pBYTE pDst,
   UINT16 iLen
)
{
   UINT16 i;
   for(i=0; i<iLen; i++)
      pDst[i] = pSrc[i];
}

VOID   SetMem(
   pCHAR  pStr,
   UINT16 iLen,
   CHAR   val
)
{
   UINT16 i;
   for(i=0; i<iLen; i++)
      pStr[i] = val;
}
VOID   MemMove(
   pCHAR pSrc, 
   pCHAR pDst, 
   UINT16 iLen
)
{
   UINT16 i;
   for(i=0; i<iLen; i++)
      pDst[i] = pSrc[i];
}
INT16   CmpMem(
   pCHAR pSrc, 
   pCHAR pDst, 
   UINT16 iLen
)
{
   UINT16 i;
   for(i=0; i<iLen; i++)
      if( pDst[i]  !=  pSrc[i] )
         return -1;
   return 0;
}

INT16   NameCmp (
   pBYTE  p1,
   pBYTE  p2
)
{
   while( *p1 && *p2 ){
      if( ToUpper(*p1) != ToUpper(*p2) )
         return 1;
      p1++;
      p2++;
   }
   if( *p1 || *p2 )
      return 1;
   return 0;
}


// TODO: tune these params ? ( per set type ? )
#define  INITELEM  5
#define  ADDELEMS  10

QSet::QSet()
{
   iMaxElems = INITELEM;
   iNumElems = 0;
   iCurElem = 0;
   iNextElem = 0;
   pElems = NULL;
}

QSet::~QSet()
{
   if( pElems )
      delete[] pElems;
}

pVOID  QSet::GetElem ()
{
   return pElems ? pElems[iNextElem++] : NULL;
}

VOID QSet::AddElem (
    pVOID pObj
)
{
   if( !pElems )
   {
      pElems = new pVOID[ INITELEM ];
      SetMem( (pBYTE) pElems, sizeof(pVOID) * INITELEM, 0);
   }

   if( ++iNumElems > iMaxElems - 1)
   {
      ppVOID  pNewElems;
      iMaxElems = (UINT16) (iMaxElems + ADDELEMS);
      pNewElems  = new pVOID[ iMaxElems ];
      SetMem( (pBYTE) pNewElems, INT16(sizeof(pVOID) * iMaxElems), 0 );
      MemMove( (pBYTE) pElems, (pBYTE) pNewElems,
               INT16(sizeof( pVOID ) * (iNumElems - 1)) );
      delete[] pElems;
      pElems = pNewElems;
   }
   pElems[ iNumElems - 1 ] = pObj;
}

UINT16 QSet::Length ( )
{
   return iNumElems;
}

VOID QSet::ToFirst()
{
   iNextElem = 0;
}
