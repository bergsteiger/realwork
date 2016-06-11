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

#ifndef RESOLVER_H
#define RESOLVER_H
#ifdef __cplusplus
    extern "C" {
#endif // __cplusplus

#ifndef OSSRV_H
#include "ossrv.h"
#endif

#ifndef CL_H
#include "cl.h"
#endif

#ifndef PICKLE_H
#include "pickle.h"
#endif

#include <alctypes.h>
#include <talchemy.h>
#include <alc_db.h>
#include <alc_ds.h>

#ifdef __cplusplus
   }
#endif // __cplusplus

#define  qryINSERT      1
#define  qryDELETE      2
#define  qryUPDATE      3
#define  qrySELECT      4

typedef struct {
    UINT16           iColumns;              // Number of columns.
    UINT32           iRowSize;              // Row Size.
    UINT32           iRowCount;             // No. of Rows.

    hDBIDb           hDb;                   // Database handle
    pVOID            pLdObj;                // Language driver Object
    DBINAME          szDbName;              // Database name
    DBINAME          szDbType  ;            // Database type (NULL: Universal)
    DBINAME          szDbPassword;          // Password
    DBITBLNAME       pTableName;            // Table Name
    DBISQLSTR        szSqlStr;              // Query
    pDSFLDDesc       pFieldDesc;            // Field Descriptors.
    pDSFLDDesc       pErrFieldDesc;         // Field Descriptors of err set.
    pBYTE            pErrRecBuf;            // Record Buffer of err set.

    pSQLRequest      pReq;
    hDBIXact         hXact;
    BOOL             bStdDb;
    CHAR             dbQChar;
    ppVOID           ppLdObj;
    phDBICur         ppLdCur;
    pBYTE            pRecBufDs;
    TDSCursor        *hDSErrCur;
    pFLDDesc         pQryFldDes; 
    BOOL             bBeginTran;
    BOOL             bUseStndby;
    pFLDDesc         *pTblFldDes;
    pUINT16          *ppUniqFlds;
    UINT16           iTableCount;
    pBYTE            pRecBufDsPhy;
    ppBYTE           ppTableNames;
    phDBICur         phUpdateCurs;
    phDBIStmt        phInsertStmt;
    phDBIStmt        phDeleteStmt;
    phDBIStmt        phUpdateStmt;
    phDBIStmt        phSelectStmt;
    pBYTE            pRecBufFldBuf;
    pBYTE            pRecBufDsOrig;
    pBYTE            pRecBufDsCurr;
    ppBYTE           ppInsertQuery;
    ppBYTE           ppDeleteQuery;
    ppBYTE           ppUpdateQuery;
    ppBYTE           ppSelectQuery;
    pUINT16          piTblFldCount;
    pINT16           piQryTblOrdNo; 
    pBYTE            pUpdateBuffer;
    pFLDDesc         pFldDesParams;
    pBYTE            pRecBufParams;
    UINT32           lRecBufParamsSize;
    ppBYTE           ppBlobBufParams;
    UINT32           iMaxErrRecords;
} DSResolverInfo;

typedef DSResolverInfo far *pDSResolverInfo;

#endif //RESOLVER_H
