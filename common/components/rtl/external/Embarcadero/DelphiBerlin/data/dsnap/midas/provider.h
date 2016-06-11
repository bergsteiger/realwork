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

#ifndef PROVIDER_H
#define PROVIDER_H
#ifdef __cplusplus
    extern "C" {
#endif // __cplusplus

#ifndef OSSRV_H
#include "ossrv.h"
#endif

#ifndef PICKLE_H
#include "pickle.h"
#endif

#ifdef __cplusplus
   }
#endif // __cplusplus

typedef struct {
    hDBICur    hCur;
    pBYTE      pDsBlobBuf;
    UINT32     iDsBlobBufSize;
    class DSPICKLE far  *pdsPickle;
    hDBIDb     hDb;
    pBYTE      pSqlStr;
    BOOL       bGetDictConstraints;
    pVOID      pLdObj;
} DsProviderInfo;

typedef DsProviderInfo far *pDsProviderInfo;


#endif //PROVIDER_H
