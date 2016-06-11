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

#ifndef FILTER_H
#define FILTER_H

// Filter API
#include "bdetypes.h"

// Structure describing extra info in pickle attributes
#if !defined(_WIN64)
#pragma pack(push, 1)
#endif
typedef struct {
   UINT32 iErrStrLen;
   UINT32 iFldNum;
   BYTE   bReqExpr;
} SQLExprInfo, *pSQLExprInfo;
#if !defined(_WIN64)
#pragma pack(pop)
#endif

// Type of filter argument
typedef enum {
   fltCANEX,              // BDE CanExpr
   fltSQLEX_CONSTRAINT,   // Streamed SQL Expr and other args, constraint
   fltSQLEX_DEFAULT       // Streamed SQL Expr and other args, default
} FLTArgType ;

typedef enum {

      // Relational operators.

      canNOTDEFINED        = 0,        //                                  (*)
      canISBLANK,                      // CANUnary;  is operand blank.     (*)
      canNOTBLANK,                     // CANUnary;  is operand not blank. (*)

      canEQ,                           // CANBinary, CANCompare; equal.    (*)
      canNE,                           // CANBinary; NOT equal.            (*)
      canGT,                           // CANBinary; greater than.         (*)
      canLT,                           // CANBinary; less than.            (*)
      canGE,                           // CANBinary; greater or equal.     (*)
      canLE,                           // CANBinary; less or equal.        (*)

      // Logical operators.

      canNOT,                          // CANUnary; NOT                    (*)
      canAND,                          // CANBinary; AND                   (*)
      canOR,                           // CANBinary; OR                    (*)

      // Operators identifing leaf operands.

      canTUPLE,                        // CANUnary; Entire record is operand.
      canFIELD,                        // CANUnary; operand is field       (*)
      canCONST,                        // CANUnary; operand is constant    (*)

      // Arithmetic operators.

      canMINUS,                        // CANUnary;  minus.
      canADD,                          // CANBinary; addition.
      canSUB,                          // CANBinary; subtraction.
      canMUL,                          // CANBinary; multiplication.
      canDIV,                          // CANBinary; division.
      canMOD,                          // CANBinary; modulo division.
      canREM,                          // CANBinary; remainder of division.

      // Aggregate type operators.

      canSUM,                          // CANBinary, accumulate sum of.
      canCOUNT,                        // CANBinary, accumulate count of.
      canMIN,                          // CANBinary, find minimum of.
      canMAX,                          // CANBinary, find maximum of.
      canAVG,                          // CANBinary, find average of.

      // Miscellaneous operators.

      canCONT,                         // CANBinary; provides a link between two
                                       // expression subtrees of a tree.
      canUDF,                          // CANBinary; invokes a User defined fn

      canCONTINUE,                     // CANUnary; Stops evaluating records
                                       // when operand evaluates to false (forward sequential access only)

      canLIKE,                          // CANCompare, extended binary compare       (*)
      canIN,                            // CANBinary field in list of values
      canLIST,                          // List of constant values of same type
      canUPPER,                         // CANUnary: upper case
      canLOWER,                         // CANUnary: lower case
      canFUNC,                          // CANFunc: Function
      canLISTELEM,                      // CANListElem: List Element
      canASSIGN                         // CANBinary: Field assignment
   } CANOp;

typedef CANOp far *pCANOp;

typedef enum {                      // Node Class

      nodeNULL          = 0,           // Null node                  (*)
      nodeUNARY,                       // Node is a unary            (*)
      nodeBINARY,                      // Node is a binary           (*)
      nodeCOMPARE,                     // Node is a compare          (*)
      nodeFIELD,                       // Node is a field            (*)
      nodeCONST,                       // Node is a constant         (*)
      nodeTUPLE,                       // Node is a record
      nodeCONTINUE,                    // Node is a continue node    (*)
      nodeUDF,                         // Node is a UDF node
      nodeLIST,                        // Node is a LIST node
      nodeFUNC,                        // Node is a Function node
      nodeLISTELEM                     // Node is a List Element node
   } NODEClass;

// NODE definitions including misc data structures
//-------------------------------------------------

#if !defined(_WIN64)
#pragma pack(push, 1)
#endif
typedef struct {                    // Header part common to all     (*)
      NODEClass      nodeClass;
      CANOp          canOp;
   } CANHdr;
typedef CANHdr far *pCANHdr;

typedef struct {                    // Unary Node                    (*)
      NODEClass      nodeClass;
      CANOp          canOp;
      UINT16         iOperand1;        // Byte offset of Operand node
   } CANUnary;
typedef CANUnary far * pCANUnary;

typedef struct {                    // Binary Node                   (*)
      NODEClass      nodeClass;
      CANOp          canOp;
      UINT16         iOperand1;        // Byte offset of Op1
      UINT16         iOperand2;        // Byte offset of Op2
   } CANBinary;
typedef CANBinary far * pCANBinary;

typedef struct {                    // Field
      NODEClass      nodeClass;
      CANOp          canOp;
      UINT16         iFieldNum;
      UINT16         iNameOffset;      // Name offset in Literal pool
   } CANField;
typedef CANField far * pCANField;

typedef struct {                    // Constant
      NODEClass      nodeClass;
      CANOp          canOp;
      UINT16         iType;            // Constant type.
      UINT16         iSize;            // Constant size. (in bytes)
      UINT16         iOffset;          // Offset in the literal pool.
   } CANConst;
typedef CANConst far * pCANConst;

typedef struct {                    // Tuple (record)
      NODEClass      nodeClass;
      CANOp          canOp;
      UINT16         iSize;            // Record size. (in bytes)
   } CANTuple;
typedef CANTuple far * pCANTuple;

typedef struct {                    // Break Node                    (*)
      NODEClass      nodeClass;
      CANOp          canOp;
      UINT16         iContOperand;     // Continue if operand is true.
                                       // else stop evaluating records.
   } CANContinue;
typedef CANContinue far * pCANContinue;

typedef struct {                    // Extended compare Node (text fields) (*)
      NODEClass      nodeClass;
      CANOp          canOp;               // canLIKE, canEQ
      BOOL16         bCaseInsensitive;    // 3 val: UNKNOWN = "fastest", "native"
      UINT16         iPartialLen;         // Partial fieldlength (0 is full length)
      UINT16         iOperand1;           // Byte offset of Op1
      UINT16         iOperand2;           // Byte offset of Op2
   } CANCompare;
typedef CANCompare far * pCANCompare;

typedef struct {                    // Function
      NODEClass      nodeClass;
      CANOp          canOp;
      UINT16         iNameOffset;   // Name offset in Literal pool
      UINT16         iElemOffset;   // Offset of first List Element in Node pool
   } CANFunc;
typedef CANFunc far * pCANFunc;

typedef struct {                    // List Element
      NODEClass      nodeClass;
      CANOp          canOp;
      UINT16         iOffset;         // Arg offset in Node pool
      UINT16         iNextOffset;     // Offset in Node pool of next ListElem or 0 if end of list

   } CANListElem;
typedef CANListElem far * pCANListElem;

//This is the node to be used to pass User defined functions
#define iLangSQL     0              // Common SQL dialect
#define iDbaseExpr   2              // This is also the driver ID for dBASE

typedef struct {                    // A user defined function
      NODEClass      nodeClass;
      CANOp          canOp;
      UINT16         iOffSzFuncName;   // Offset in literal pool to Function Name string(0 terminated)
      UINT16         iOperands;        // Byte offset of Operands (concatenated using canCONT)

      //The fields below are hints that specific drivers can make use of
      UINT16         iDrvDialect;      // Driver Dialect ID for UDF string supplied
      UINT16         iOffSzUDF;        // Offset in literal pool to UDF string (0 terminated)
   } CANUdf;
typedef CANUdf far * pCANUdf;

typedef struct {                    // List of Constants
      NODEClass      nodeClass;
      CANOp          canOp;
      UINT16         iType;            // Constant type.
      UINT16         iTotalSize;       // Total list size;
      UINT16         iElemSize;        // Size of each elem for fix-width types
      UINT16         iElems;           // Number of elements in list
      UINT16         iOffset;          // Offset in the literal pool to first elem.
   } CANList;
typedef CANList far * pCANList;
#if !defined(_WIN64)
#pragma pack(pop)
#endif

#if !defined(MIDL)
typedef union {
      CANHdr         canHdr;
      CANUnary       canUnary;
      CANBinary      canBinary;
      CANField       canField;
      CANConst       canConst;
      CANTuple       canTuple;
      CANContinue    canContinue;
      CANCompare     canCompare;
      CANList        canList;
      CANFunc        canFunc;
      CANListElem    canListElem;
   } CANNode;
typedef CANNode far *pCANNode;
#endif // !defined(MIDL)

// Linear exression tree
//----------------------

# define CANEXPRVERSION   2

#if !defined(_WIN64)
#pragma pack(push, 1)
#endif
typedef struct {                    // Expression Tree
      UINT16         iVer;             // Version tag of expression.
      UINT16         iTotalSize;       // Size of this structure
      UINT16         iNodes;           // Number of nodes
      UINT16         iNodeStart;       // Starting offet of Nodes in this
      UINT16         iLiteralStart;    // Starting offset of Literals in this
      // Nodes and Literals are here
   } CANExpr;
#if !defined(_WIN64)
#pragma pack(pop)
#endif
typedef CANExpr far * pCANExpr;
typedef pCANExpr far *ppCANExpr;

extern "C"
{

DBIResult DBIFN QCompileCanFilter (
   FLTArgType   eArgType,
   pBYTE        pArg,
   pUINT16      piFldNum,
   pULONGP      pHndl,
   pBOOL        pbReq,
   pVOID        pDS
);

BOOL DBIFN QExecuteCanFilter ( ULONGP  hndl, pBYTE pRecBuf, pVOID pDS );
DBIResult DBIFN QFreeCanFilter ( ULONGP  hndl);
VOID DBIFN QFetchErrStr ( ULONGP, pCHAR );

pBYTE DBIFN QFetchValue ( ULONGP );

}

#endif // FILTER_H
