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

#ifndef BDEPROV_H
#define BDEPROV_H

#ifndef ALCTYPES_H
#include "alctypes.h"
#endif

#ifndef ALC_DS_H
#include "alc_ds.h"
#endif

#ifndef TALCHEMY_H
#include "talchemy.h"
#endif

#ifndef DSCONST_H
#include "dsconst.h"
#endif

#ifdef __cplusplus
    extern "C" {
#endif // __cplusplus

typedef enum                              // Update mode
{
      dsupdWHEREALL    = 0,               // All fields in WHERE clause
      dsupdWHEREKEY    = 1                // Keyed fields in WHERE clause
} dsUPDMode;
typedef dsUPDMode far *pdsUPDMode;

typedef struct {
   UINT32      errCategory;
   dsCBRType   errHandle;
} DSPROVERRHNDL;

typedef DSPROVERRHNDL far *pDSPROVERRHNDL;
typedef enum
{
   provNOTUPDATABLE                = 1, // datapacket is not updatable
   provINCL_DICTIONARY_CONSTRAINTS = 2, // Retrieve dictionary constraints
   provINCL_FIELDORIGIN_INFO       = 4, // Include field origin info
                                        // (if any) in datapacket
   provINCL_METADATA               = 8  // Include meta data in
                                        // datapacket (must be TRUE first time)
} PROVOptions;

DBIResult  DBIFN DsProviderGetDataPacket (
   hDBICur                hCur,            // Result cursor handle
   PROVOptions            eProvOptions,    // Options for provider
   pfDataSourcesCallback  pDsCB,           // Callback for field origin
                                           // information
   UINT32                 iDsCbClientData, // client pastthru data
   pUINT32                piMaxRecords,    // In: Max recs,
                                           // Out : actual number of records
   SAFEARRAY              **ppDataPacket,
   pBOOL                  pbEndOfData      // End of file was reached
   );

DBIResult DBIFN DsResolver (
   UINT32                 iNoOfDataSources,    // Number of data sources.
   SAFEARRAY              **ppDataPacket,      // DataPacket Buffer
   hDBIDb                 hDb,                 // Database handle.
   pBYTE                  szDbName,            // Database name
   pBYTE                  szDbType,            // Database type
   pBYTE                  szDbPassword,        // Password
   ppBYTE                 pszSqlStr,           // SQL str used to
                                               // generate DataPacket
   ppBYTE                 ppTableName,         // If open table, name of
                                               // the table.
   pULONGP                piClientData,
   pfDSReconcile          *ppfReconcile,       // Callback-fn
                                               // (called for each error)
   pfDataSourcesCallback  *ppDsCB,
   UINT32                 iDsCbClientData,     // client pastthru data
   pUINT32                piMaxErrRecords,     // In: Max recs,
                                               // Out : actual no of records
   SAFEARRAY              **ppErrdatapacket    // datapacket Buf for error set
   );

#ifdef __cplusplus
};
#endif // __cplusplus

#endif
