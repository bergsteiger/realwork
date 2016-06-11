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

#ifndef CANX_H
#define CANX_H

#define QLITE_DLL TRUE

#ifdef QLITE_DLL

#ifndef _UNIX
#include "windows.h"
#endif
#include "alctypes.h"
#include "alchemy.h"

#define EC extern "C"

extern "C"
{
#include "bdetypes.h"
#include "filter.h"
}

#ifndef INT64_MAX
#define INT64_MAX ((int64_t) 9223372036854775807LL)
#endif

#ifndef INT64_MIN
#define INT64_MIN ((int64_t) -9223372036854775807LL - 1)
#endif

class QSet;

#if 0
class QCanExecStreamSet;
typedef QCanExecStreamSet *pQCanExecStreamSet;
#endif

class QCanExecElem;
typedef QCanExecElem *pQCanExecElem;
typedef pQCanExecElem *ppQCanExecElem;

class  QCanExecElemSet;
typedef  QCanExecElemSet *pQCanExecElemSet;

class QAggregateElemSet;
typedef QAggregateElemSet *pQAggregateElemSet;

class QAggregate;
typedef QAggregate *pQAggregate;

class QAggregateElem;
typedef QAggregateElem *pQAggregateElem;


#if QLITE_DLL

typedef struct _MemMark
{
   pVOID mark;
} MemMark, far *pMemMark;

typedef enum {

   qnodeAdd = 1,
   qnodeAvg = 2,
   qnodeCount = 3,
   qnodeMax = 4,
   qnodeMin = 5,
   qnodeTotal = 6,
   qnodeAlias = 7,
   qnodeAnd = 8,
   qnodeConstant = 9,
   qnodeDivide = 10,
   qnodeEqual = 11,
   qnodeField = 12,
   qnodeGreaterEq = 13,
   qnodeGreater = 14,
   qnodeLessEq = 15,
   qnodeLike  = 16,
   qnodeLess = 17,
   qnodeMultiply = 18,
   qnodeNotEqual = 19,
   qnodeNot = 20,
   qnodeOr = 21,
   qnodeSubtract = 22,
   qnodeColumn = 23,
   qnodeCast = 24,
   qnodeAssign = 25,
   qnodeIsNull = 26,
   qnodeExists = 27,
   qnodeVariable = 28,
   qnodeSelect  = 29,
   qnodeNegate = 30,
   qnodeUdf = 31,
   qnodeIN = 32,
   qnodeANY = 33,
   qnodeALL = 34,
   qnodeTrim = 35,
   qnodeLower = 36,
   qnodeUpper = 37,
   qnodeSubstring = 38,
   qnodeList = 39,
   qnodeExtract = 40,
   qnodeCorrVar  = 41,
   qnodeTrue  = 42,
   qnodeIsNotNull = 43,
   qnodeFunc = 44
} QNodeType;

#define Catch(x) setjmp(x)
#define Throw(x,y) longjmp(SysGetActiveSes()->JmpBuf[SysGetActiveSes()->iJmpBuf-1], y)

#include "setjmp.h"

typedef enum {
   streamSELECT,
   streamPROJECT
} StreamType;

#endif

class QSet {
public:
   QSet();
   ~QSet();

   pVOID   GetElem();
   VOID  ToFirst();
   UINT16 Length();
   VOID  AddElem( pVOID );

private:
   UINT16   iMaxElems;
   UINT16   iNumElems;
   ppVOID   pElems;
   UINT16   iCurElem;
   UINT16   iNextElem;
};
typedef  QSet *pQSet;


#endif

class QCanExpr;
typedef QCanExpr  *pQCanExpr;

class QCanFilter;
typedef QCanFilter  *pQCanFilter;

class QCanExecStream;
typedef QCanExecStream *pQCanExecStream;
typedef pQCanExecStream *ppQCanExecStream;

class QCanExecElemSet : public QSet {
public:
   QCanExecElemSet() {};
   ~QCanExecElemSet() { }
   pQCanExecElem GetElem()  { return (pQCanExecElem) QSet::GetElem(); }
};

typedef enum {
   eAggNoop,
   eAggAdd,
   eAggSub,
   eAggReset
}eAggAct;

class QCanExecStream {
public:
   QCanExecStream();
   ~QCanExecStream();
   VOID Compile();
   BOOL Execute( pBYTE pRecBuf, eAggAct eaggAct, AGGVALUE *pValue );
   VOID AddElem(pVOID pElem) { pFieldExecElemSet->AddElem(pElem); }
   pQCanExecElem        GetResElem();

   pQCanExecElemSet     pArgs;
   UINT32               lcid;
   pQCanExecElemSet     pFieldExecElemSet;
   pDSBASE              pDS;

private:

};

typedef enum {
   CanNoop = 0,
   CanFloatAdd  ,
   CanFloatSubtract  ,
   CanFloatDivide  ,
   CanFloatMultiply  ,
   CanFloatEqual  ,
   CanFloatNotEqual  ,
   CanFloatLess  ,
   CanFloatLessEq  ,
   CanFloatGreater  ,
   CanFloatGreaterEq  ,
   CanFloatNegate  ,
   CanSingleAdd  ,
   CanSingleSubtract  ,
   CanSingleDivide  ,
   CanSingleMultiply  ,
   CanSingleEqual  ,
   CanSingleNotEqual  ,
   CanSingleLess  ,
   CanSingleLessEq  ,
   CanSingleGreater  ,
   CanSingleGreaterEq  ,
   CanSingleNegate  ,
   CanBytesEqual  ,
   CanBytesNotEqual  ,
   CanBcdAdd ,
   CanBcdSubtract ,
   CanBcdDivide ,
   CanBcdMultiply ,
   CanBcdEqual ,
   CanBcdNotEqual ,
   CanBcdLess ,
   CanBcdLessEq ,
   CanBcdGreater ,
   CanBcdGreaterEq ,
   CanBcdNegate ,
   CanBoolAnd  ,
   CanBoolOr  ,
   CanBoolNot  ,
   CanStringAdd ,
   CanStringEqual ,
   CanStringNotEqual ,
   CanStringLess ,
   CanStringLessEq,
   CanStringGreater ,
   CanStringGreaterEq ,
   CanStringLike,
   CanStringLikeRedo ,
   CanStringLower ,
   CanStringUpper ,
   CanStringLowerLd ,
   CanStringUpperLd ,
   CanSubstring3 ,
   CanSubstring2 ,
   CanTrimLead ,
   CanTrimTrail ,
   CanTrimBoth ,
   CanStringEqualLd ,
   CanStringNotEqualLd ,
   CanStringLessLd ,
   CanStringLessEqLd,
   CanStringGreaterLd ,
   CanStringGreaterEqLd ,
   CanLongSubtract ,
   CanLongAdd ,
   CanLongMultiply ,
   CanLongDivide ,
   CanLongEqual ,
   CanLongNotEqual ,
   CanLongLess ,
   CanLongLessEq,
   CanLongGreater ,
   CanLongGreaterEq ,
   CanLongNegate ,
   CanShortSubtract ,
   CanShortAdd ,
   CanShortMultiply ,
   CanShortDivide ,
   CanShortEqual ,
   CanShortNotEqual ,
   CanShortLess ,
   CanShortLessEq,
   CanShortGreater ,
   CanShortGreaterEq ,
   CanShortNegate ,
//U32
   CanLongWordSubtract ,
   CanLongWordAdd ,
   CanLongWordMultiply ,
   CanLongWordDivide ,
   CanLongWordEqual ,
   CanLongWordNotEqual ,
   CanLongWordLess ,
   CanLongWordLessEq,
   CanLongWordGreater ,
   CanLongWordGreaterEq ,
//U16
   CanWordSubtract ,
   CanWordAdd ,
   CanWordMultiply ,
   CanWordDivide ,
   CanWordEqual ,
   CanWordNotEqual ,
   CanWordLess ,
   CanWordLessEq,
   CanWordGreater ,
   CanWordGreaterEq ,
   CanShortIntSubtract ,
   CanShortIntAdd ,
   CanShortIntMultiply ,
   CanShortIntDivide ,
   CanShortIntEqual ,
   CanShortIntNotEqual ,
   CanShortIntLess ,
   CanShortIntLessEq,
   CanShortIntGreater ,
   CanShortIntGreaterEq ,
   CanShortIntNegate ,
   CanByteSubtract ,
   CanByteAdd ,
   CanByteMultiply ,
   CanByteDivide ,
   CanByteEqual ,
   CanByteNotEqual ,
   CanByteLess ,
   CanByteLessEq,
   CanByteGreater ,
   CanByteGreaterEq ,
   CanFmtMemoLike ,
   CanDateShortAdd ,
   CanDateLongAdd,
   CanDateSubtract,
   CanDateFloatAdd,
   CanDateFloatSubtract,
   CanFloatDateAdd,
   CanDatetimeShortAdd,
   CanDatetimeLongAdd,
   CanDatetimeFloatAdd,
   CanDatetimeFloatSubtract,
   CanTimeFloatSubtract,
   CanFloatDatetimeAdd,
   CanDatetimeSubtract,
   CanTimeShortAdd ,
   CanTimeLongAdd ,
   CanTimeFloatAdd ,
   CanFloatTimeAdd ,
   CanBoolEqStr ,
   CanStrEqBool ,
   CanBoolNotEqStr ,
   CanStrNotEqBool ,
   CanStrToBool ,
   CanBoolEq ,
   CanBoolNotEq ,
   CanCastField ,
   CanCastFieldLoss ,
   CanCopyField ,
   CanCopyBlob ,
   CanExtractYearFromDate ,
   CanExtractYearFromTS ,
   CanExtractMonthFromDate ,
   CanExtractMonthFromTS ,
   CanExtractDayFromDate ,
   CanExtractDayFromTS ,
   CanExtractHourFromTS ,
   CanExtractHourFromTime ,
   CanExtractMinFromTS ,
   CanExtractMinFromTime ,
   CanExtractSecFromTS ,
   CanExtractSecFromTime ,
   CanShortSum,
   CanLongSum,
   CanFloatSum,
   CanBcdSum,
   CanShortAvg,
   CanLongAvg,
   CanFloatAvg,
   CanBcdAvg,
   CanDateAvg,
   CanShortMin,
   CanLongMin,
   CanFloatMin,
   CanBcdMin,
   CanCount,
   CanIsNull,
   CanIN,
   CanSmallToFloat,
   CanShortToFloat,
   CanLongToFloat,
   CanByteToFloat,
   CanWordToFloat,
   CanLongWordToFloat,
   CanUInt64ToFloat,
   CanBcdToFloat,
   CanFloatToSmall,
   CanFloatToShort,
   CanFloatToLong,
   CanFloatToByte,
   CanFloatToWord,
   CanFloatToLongWord,
   CanFloatToUInt64,
   CanFloatToBcd,
   CanSmallToSingle,
   CanShortToSingle,
   CanLongToSingle,
   CanByteToSingle,
   CanWordToSingle,
   CanLongWordToSingle,
   CanUInt64ToSingle,
   CanBcdToSingle,
   CanSingleToSmall,
   CanSingleToShort,
   CanSingleToLong,
   CanSingleToByte,
   CanSingleToWord,
   CanSingleToLongWord,
   CanSingleToUInt64,
   CanSingleToBcd,
   CanAssign,
   CanIsNotNull,
   CanTimestampToTime,
   CanDateToTimestamp,
   CanGetDateTime,
   CanTimestampToDate,
   CanMemoLike,
   CanExtractDateFromTS,
   CanExtractTimeFromTS,
   CanAnsiToUnicode,
   CanUnicodeToAnsi,
   CanUnicodeStringAdd,
   CanUnicodeStringEqual,
   CanUnicodeStringNotEqual ,
   CanUnicodeStringLess ,
   CanUnicodeStringLessEq,
   CanUnicodeStringGreater ,
   CanUnicodeStringGreaterEq ,
   CanUnicodeStringLike ,
   CanUnicodeMemoLike ,
   CanUnicodeStringLower ,
   CanUnicodeStringUpper ,
   CanUnicodeSubstring3 ,
   CanUnicodeSubstring2 ,
   CanUnicodeTrimLead ,
   CanUnicodeTrimTrail ,
   CanUnicodeTrimBoth ,      // from here, added for SqlTimestamp
   CanSqlTimestampEqual,
   CanSqlTimestampNotEqual  ,
   CanSqlTimestampLess  ,
   CanSqlTimestampLessEq  ,
   CanSqlTimestampGreater  ,
   CanSqlTimestampGreaterEq  ,
   CanSqlTimestampShortAdd,
   CanSqlTimestampLongAdd,
   CanSqlTimestampFloatAdd,
   CanSqlTimestampFloatSubtract,
   CanSqlTimestampOffsetEqual,
   CanSqlTimestampOffsetNotEqual  ,
   CanSqlTimestampOffsetLess  ,
   CanSqlTimestampOffsetLessEq  ,
   CanSqlTimestampOffsetGreater  ,
   CanSqlTimestampOffsetGreaterEq  ,
   CanSqlTimestampOffsetShortAdd,
   CanSqlTimestampOffsetLongAdd,
   CanSqlTimestampOffsetFloatAdd,
   CanSqlTimestampOffsetFloatSubtract,
   CanFloatSqlTimestampAdd,
   CanSqlTimestampSubtract,
   CanGetSqlTimestamp,
   CanSqlTimestampToTime,
   CanDateToSqlTimestamp,
   CanSqlTimestampToDate,
   CanFloatSqlTimestampOffsetAdd,
   CanSqlTimestampOffsetSubtract,
   CanGetSqlTimestampOffset,
   CanSqlTimestampOffsetToTime,
   CanDateToSqlTimestampOffset,
   CanSqlTimestampOffsetToDate,
   CanExtractYearFromSQLTS,
   CanExtractMonthFromSQLTS,
   CanExtractDayFromSQLTS,
   CanExtractHourFromSQLTS,
   CanExtractMinFromSQLTS,
   CanExtractSecFromSQLTS,
   CanExtractYearFromSQLTSOS,
   CanExtractMonthFromSQLTSOS,
   CanExtractDayFromSQLTSOS,
   CanExtractHourFromSQLTSOS,
   CanExtractMinFromSQLTSOS,
   CanExtractSecFromSQLTSOS,
   CanInt64Subtract ,
   CanInt64Add ,
   CanInt64Multiply ,
   CanInt64Divide ,
   CanInt64Equal ,
   CanInt64NotEqual ,
   CanInt64Less ,
   CanInt64LessEq,
   CanInt64Greater ,
   CanInt64GreaterEq ,
   CanInt64Negate ,
   CanInt64ToFloat ,
   CanFloatToInt64,
   CanInt64ToSingle ,
   CanSingleToInt64

} QFieldFuncType ;

typedef enum {
   aggopNoop = 0,
   aggopSmallSum,
   aggopShortSum,
   aggopLongSum,
   aggopLongIntSum,
   aggopByteSum,
   aggopWordSum,
   aggopLongWordSum,
   aggopU64Sum,
   aggopFloatSum,
   aggopSingleSum,
   aggopBcdSum,
   aggopSmallAvg,
   aggopShortAvg,
   aggopLongAvg,
   aggopLongIntAvg,
   aggopByteAvg,
   aggopWordAvg,
   aggopLongWordAvg,
   aggopU64Avg,
   aggopFloatAvg,
   aggopSingleAvg,
   aggopBcdAvg,
   aggopDateAvg,
   aggopStringMin,
   aggopSmallMin,
   aggopShortMin,
   aggopLongMin,
   aggopLongIntMin,
   aggopByteMin,
   aggopWordMin,
   aggopLongWordMin,
   aggopU64Min,
   aggopFloatMin,
   aggopSingleMin,
   aggopBcdMin,
   aggopCount,
   aggopCountAll,
   aggopStringMax,
   aggopSmallMax,
   aggopShortMax,
   aggopLongMax,
   aggopLongIntMax,
   aggopByteMax,
   aggopWordMax,
   aggopLongWordMax,
   aggopU64Max,
   aggopFloatMax,
   aggopSingleMax,
   aggopBcdMax,
   aggopUnicodeMin,
   aggopUnicodeMax,
   aggopSqlTimestampMin,
   aggopSqlTimestampMax,
   aggopSqlTimestampAvg,
   aggopSqlTimestampOffsetMin,
   aggopSqlTimestampOffsetMax,
   aggopSqlTimestampOffsetAvg
} QAggFuncType;

typedef QFieldFuncType  *pQFieldFuncType ;

class QCanExecElem
{
public:
   QCanExecElem();
   ~QCanExecElem();

   QNodeType          eType;
   QFieldFuncType     eFuncType;
   QAggFuncType       eAggFunc;

// arg1:
   ppBYTE        ppRecReg1;
   UINT32        iArg1Off;
   UINT32        iArg1NullOff;
   UINT16        iLen;
   UINT16        iFldType;
   UINT16        iArg1Units1;
   UINT16        iArg1Units2;
   UINT16        iFldNum;


// arg2:
   UINT32        iArg2Off;
   UINT32        iArg2NullOff;
   UINT16        iLen2;
   ppBYTE        ppRecReg2;
   pBYTE         pRecReg2;
   UINT16        iArg2Units1;
   UINT16        iArg2Units2;

// arg3:
   UINT32        iArg3Off;
   UINT32        iArg3NullOff;
   UINT16        iLen3;
   ppBYTE        ppRecReg3;
   pBYTE         pRecReg3;

// result:
   UINT32        iResOff;
   UINT32        iResNullOff;
   ppBYTE        ppRecRegRes;
   pBYTE         pRecRegRes;
   UINT32        iResLen;
   UINT32        iResUnits1;
   UINT32        iResUnits2;

   UINT16        iPartialLen;
   BOOL          bCaseInsensitive;
   BOOL          bLeftIsField;
   UINT16        iUnitLen;  // for IN list
   UINT16        iNumElems;  // for IN list
   UINT16        iArgFldType;  // for IN operation
   pCHAR         pszFuncName;
   UINT16        iAggAcumOff;
   BOOL          bIsAgg;
   pQCanExecElemSet pArgList;
   UINT16        iExtraAcumSpace;
};

class QCanExpr  {
public:
   QCanExpr() ;
   ~QCanExpr();

   DBIResult Compile(pCANExpr pCan);
   UINT32  lcid;
   UINT32  iFldNum;

   pQCanExecStream   pStream;
   pQCanExecStream   pStreamPostAgg;
   pUINT16           piAggNest;
   UINT16            iCurAggAcumOff;
   pDSBASE           pDS;

protected:
   ppBYTE            ppRecBuf;
   pBYTE             pRecB;
   ppBYTE            ppAggBuf;
   pBYTE             pAggB;
   DBIResult         errRslt;

   DBIResult BuildExecStream(pCANExpr pCanExprArg);
   VOID BuildOp(pQCanExecElem pElem1, pQCanExecElem pElem2,
                pQCanExecElem pElem3, pQCanExecElem pElemRes,
                BOOL bIsAgg);
private:
   QNodeType CanNodeToQNode ( CANOp canOp );
   pQCanExecElem CompileCanEx(pCANNode pcanNode, BOOL bAllowBlobs);

   pCANExpr pCanExpr;
   UINT16   iCurNodeOff;
   UINT16   iCurLitOff;

   pBYTE    pLitPool;
   pBYTE    pNodePool;

   jmp_buf   JmpBuf;
};

class QCanFilter : public QCanExpr
{
public:

   QCanFilter();
   ~QCanFilter();

   BOOL Execute(pBYTE pRecBuf) ;
   DBIMSG      szErrorMsg;
};

#if 0
class QCanCalcField : public QCanExpr
{
public:
   QCanCalcField();
   ~QCanCalcField();

   DBIResult     Execute(pBYTE pRecBuf) ;
   pFLDDesc      GetResultType(pUINT16 pDataLen);
   DBIResult     GetResult(AGGVALUE *pAggValue, pBYTE pSrc, pBYTE pDest, pBOOL pbBlank);
};
#endif

class QAggregate : public QCanExpr
{
public:
   QAggregate();
   ~QAggregate();

   DBIResult     Prepare(pBYTE pExpr, pCANExpr pCan, pDSBASE pDS);
   DBIResult     Execute(pBYTE pRecBuf) ;
   VOID          AddValue( AGGVALUE *pValue, pBYTE pRecBuf );
   BOOL          SubValue( AGGVALUE *pValue, pBYTE pRecBuf );  // if TRUE, rescan needed
   VOID          Reset(AGGVALUE *pValue );
   pFLDDesc      GetResultType(pUINT16 pDataLen);
   DBIResult     GetResult(AGGVALUE *pAggValue, pBYTE pSrc, pBYTE pDest, pBOOL pbBlank);

private:
   FLDDesc       fldRes;
   pQCanExecElem pResElem;
   BOOL          bInit;
};

#if QLITE_DLL

typedef enum {
   opNone,
   opBoolOp,
   opRelOp,
   opArithOp,
   opAggOp,
   opOther
} OpType;

typedef enum {
   clNone,
   clNumeric,
   clTime,
   clChar
} TypeClass ;


VOID     SetMem( pBYTE  pStr, UINT16 iLen, CHAR   val);
VOID     MemMove( pBYTE pSrc, pBYTE pDst, UINT16 iLen);
INT16    CmpMem( pBYTE pSrc, pBYTE pDst, UINT16 iLen);
VOID     StrCat( pBYTE pSrc, pBYTE pDst );
UINT16   StrLen( pBYTE pSrc);
VOID     StrCpy( pBYTE pDst, pBYTE pSrc);
INT16    StrCmp( pBYTE p1, pBYTE p2);
INT16    StrCmpI( pBYTE p1, pBYTE p2);
VOID     TrimExt( pCHAR );
VOID     StrNCpy( pBYTE pDst, pBYTE pSrc, UINT16 iLen );

VOID     SetMem( pCHAR  pStr, UINT16 iLen, CHAR   val);
VOID     MemMove( pCHAR pSrc, pCHAR pDst, UINT16 iLen);
INT16    CmpMem( pCHAR pSrc, pCHAR pDst, UINT16 iLen);
VOID     StrCat( pCHAR pSrc, pCHAR pDst );
UINT16   StrLen( pCHAR pSrc);
VOID     StrCpy( pCHAR pDst, pCHAR pSrc);
INT16    StrCmp( pCHAR p1, pCHAR p2);


CHAR     ToUpper ( CHAR c);
CHAR     ToLower ( CHAR c );

INT16    NameCmp( pBYTE, pBYTE );

#define   ForEachInSet(pSet, pObj)   for( pSet->ToFirst(); (pObj = pSet->GetElem()) != NULL; )

#if 0
class QAggExecElemSet : public QSet {
public:
   QAggExecElemSet() { }
   ~QAggExecElemSet();
   pQAggExecElem GetElem()  { return (pQAggExecElem) QSet::GetElem(); }
   pQAggExecElem GetElem(iNum) { return (pQAggExecElem) QSet::GetElem(iNum); }
};
typedef QAggExecElemSet *pQAggExecElemSet;
#endif

class QAggregateElem {
public:
   QAggregateElem() ;
   QAggregateElem(UINT16 iOff, UINT16 iNullOff)
      { iOffset = iOff; iNullOffset = iNullOff; }
   virtual   ~QAggregateElem();

   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();

protected:
   UINT32           lCount;
   UINT16           iOffset;
   DFLOAT           fAcum;
   DFLOAT           fFinal;

private:
   UINT16           iNullOffset;
   BOOL             bIncludeNulls;
   pBYTE            pInitVal;
   UINT16           iInitValLen;
};

class      AggElemShortSum  :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();

private:
   UINT16      iVal;
};

class    AggElemLongSum    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();

private:
   UINT32    lVal;
};

class    AggElemFloatSum    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
};

class    AggElemSingleSum    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
};

class    AggElemBcdSum    :  public QAggregateElem  {
public:
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
};

class    AggElemShortAvg    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
private:
   UINT16   iVal;
};

class    AggElemLongAvg    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
private:
   UINT32   lVal;
};

class    AggElemFloatAvg    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
};

class    AggElemSingleAvg    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
};

class    AggElemBcdAvg    :  public QAggregateElem  {
public:
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
};

class    AggElemDateAvg    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
private:
   DBIDATE    date;
   DBIDATE    dateAvg;
};

class    AggElemShortMin    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
private:
   UINT16  iVal;
};

class    AggElemLongMin    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
private:
   UINT32  lVal;
};

class    AggElemFloatMin    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
};

class    AggElemSingleMin    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
};

class    AggElemBcdMin    :  public QAggregateElem  {
public:
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
};

class    AggElemStringMin    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
};

class    AggElemShortMax    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
private:
   UINT16  iVal;
};

class    AggElemLongMax    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
private:
   UINT32  lVal;
};

class    AggElemFloatMax    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
};

class    AggElemSingleMax    :  public QAggregateElem  {
public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
};

class    AggElemBcdMax    :  public QAggregateElem  {
public:
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
};

#if 0
class    AggElemCount    :  public QAggregateElem  {
   public:
   virtual  VOID             Reset();
   virtual  VOID             Add(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  BOOL             Sub(AGGVALUE *pValue,pBYTE pRecBuf);
   virtual  pBYTE            Fetch();
}
#endif

class QAggregateElemSet : public QSet {
public:
   QAggregateElemSet() { }
   ~QAggregateElemSet();
   pQAggregateElem GetElem()  { return (pQAggregateElem) QSet::GetElem(); }
};
typedef QAggregateElemSet *pQAggregateElemSet;
#endif

#endif  // CANEX_H
