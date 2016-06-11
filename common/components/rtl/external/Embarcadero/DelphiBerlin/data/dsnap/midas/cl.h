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

#ifndef CL_H
#define CL_H
#ifdef __cplusplus
    extern "C" {
#endif // __cplusplus

typedef  enum                         // Database/Table Access type
{
      dbiTableOpen      = 0,          // Read + Write   (Default)
      dbiQuery          = 1,          // Read only
      dbiListTable      = 2,          // DbiOpenTableList
      dbiListCfg        = 3,
      dbiListFields     = 4
} DBIDsMode;

typedef struct
{
   DBIDsMode      eDsMode   ;         // Type of request
   DBINAME        szDbName  ;         // Database name
   DBINAME        szDbType  ;         // Database type (NULL: Universal)
   DBINAME        szDbPassword;       // Password
   DSOpenMode     eDbOpenMode;        // Database open mode
   DBIPATH        szDbCurrentDir;     // Current directory
   DBIPATH        szTableName;        // TableName
   DBIPATH        szSqlStr;           // Query
   DSOpenMode     eTblOpenMode;       // Open type
} DSREQ;
typedef DSREQ * pDSREQ;


DBIResult GetDSFromRemote(pDSDBDesc pDbDesc, pCHAR pszAlias, pCHAR pszSql, pCHAR pszTblName, DSOpenMode
      eTblOpenMode, UINT32 iOpt, pBYTE *ppPickle, pUINT32 piSize);
DBIResult LoadDSFromFile(pCHAR pPathName, pBYTE *ppPickle, pUINT32 piSize);
DBIResult SaveDSToFile(pCHAR pPathName, pBYTE pPickle, UINT32 iSize);
DBIResult SrvReqOpen(pDSREQ pDsReq, pCHAR pszSql, UINT32 iBufSize, pBYTE pPtr);
DBIResult SrvApplyChanges(UINT32 iBufSize, pBYTE pPtr);
DBIResult RpcGetDS(pDSREQ pDsReq, pCHAR pszSql, pVOID *ppDsDesc);
DBIResult RpcGetErrorString(DBIResult iErr, pCHAR pszErr);
DBIResult RpcApplyDS(UINT32 iBufSize, pBYTE pDsDes);

#ifdef __cplusplus
   }
#endif // __cplusplus
#endif
