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

#ifndef TALCHEMY_H
#define TALCHEMY_H

#include "alctypes.h"

#if defined(_Windows) || defined(__BORLANDC__) && !defined(__arm__) && !defined(__arm64__)
#define EXPORTS __declspec(dllexport)
#else
#define EXPORTS
#endif

// Dataset class definition
class TDSBASE
{
public:
   virtual HRESULT DBIFN QueryInterface(
         REFIID riid,
         void** ppv
         )  = 0;
   virtual UINT32 DBIFN AddRef(
         VOID
         ) = 0;

   virtual UINT32 DBIFN Release(
         VOID
         ) = 0;

   virtual DBIResult DBIFN Create(  // Create empty dataset
         UINT32      iFields,
         pDSFLDDesc  pFldDes,
         pCHAR pszName
         ) = 0;

   virtual DBIResult DBIFN AddField(
         pDSFLDDesc pFldDes
         ) = 0;

   virtual DBIResult DBIFN AppendData( // Appends data from datapacket to dataset. First datapacket contains meta-info.
         SAFEARRAY *pDatapacket, // Datapacket/Partial Datapacket
         BOOL  bEof              // If True, this is last datapacket
         ) = 0;

   virtual DBIResult DBIFN GetOptParameter(// Returns optional parameter (unknown to dataset)
         UINT32 iNo     , // Number 1..iOptAttr
         UINT32 iFldNo  , // 0 if not field attribute
         ppCHAR  ppName , // returns ptr to name
         pUINT32 piType , // returns type
         pUINT32 piLen  , // returns length
         ppCHAR  ppValue  // returns ptr to value
         ) = 0;

   virtual DBIResult DBIFN AddOptParameter(// Adds optional parameter to dataset
         UINT32  iFldNo  , // 0 if not field attribute
         pCCHAR   pszAttr , // ptr to name
         UINT32  iType   , // type
         UINT32  iLen    , // length
         pBYTE   pValue    //  ptr to value
         ) = 0;

   virtual DBIResult DBIFN  GetProps(
          pDSProps
         ) = 0;

   virtual DBIResult DBIFN  GetFieldDescs(
          pDSFLDDesc
         ) = 0;

   virtual DBIResult DBIFN  GetIndexDescs(
          pDSIDXDesc
         ) = 0;

   virtual DBIResult  DBIFN GetDelta(  // Extract delta from ds, as delta
          pBYTE    *ppDsDelta // Returns dataset (must be cast to pDSBASE)
         ) = 0;

   virtual DBIResult DBIFN  StreamDS( // Create datapacket version of dataset
         SAFEARRAY **ppDatapacket // Returns datapacket in buffer. Buffer will be release by Dataset
         ) = 0;

   virtual DBIResult DBIFN AcceptChanges(// Accept all current changes (cannot be undone)
         VOID
         ) = 0;

   virtual DBIResult DBIFN PutBlank( // Put blank value
         pBYTE   pRecBuf,  // RecBuf OR
         UINT32  iRecNo ,  // iRecNo
         UINT32  iFldNo ,
         UINT32  iBlankValue
         ) = 0;

   virtual DBIResult DBIFN CreateIndex(  // Create, and add an index
         pDSIDXDesc  pIdxDesc
         ) = 0;

   virtual DBIResult DBIFN RemoveIndex(  // Remove index of given name
         pCHAR      pszName
         ) = 0;

   virtual DBIResult DBIFN GetErrorString(
         DBIResult iErrCode,
         pCHAR pString
         ) = 0;

   virtual INT    DBIFN FldCmp(  // Compare field values (equality only), returns 0 if equal
         UINT32   iFldType , // Fieldtype
         pBYTE    pFld1    , // NULL if blank
         pBYTE    pFld2    , // NULL if blank
         UINT32   iUnits1 ,
         UINT32   iUnits2
         ) = 0;

   virtual DBIResult DBIFN GetProp (       // Get property
            DSProp         eProp  ,           // Property to get
            pULONGP        piPropValue        // Returns property value (or pointer depending on type)
          ) = 0;

   virtual DBIResult DBIFN SetProp (       // Set property
            DSProp         eProp  ,           // Property to set
            ULONGP         iPropValue         // Property value (or pointer to value)
          ) = 0;

   virtual DBIResult DBIFN SetFieldCalculation( // Register fieldcalculation on this field
            ULONGP         iClientData,
            pfDSCalcField  pfCalc        // Callback function, NULL to remove
          ) = 0;

   virtual DBIResult DBIFN Reconcile(
            SAFEARRAY     *pDeltaDatapacket, // Delta Datapacket
            SAFEARRAY     *pErrorDatapacket, // NULL if all changes accepted
            ULONGP         iClientData,
            pfDSReconcile  pfReconcile       // Callback-fn (called for each error)
          ) = 0;

   virtual DBIResult DBIFN Unused1(
            VOID
         ) = 0;

   virtual DBIResult DBIFN Unused2(
            VOID
         ) = 0;

   virtual DBIResult DBIFN Unused3(
            VOID
         ) = 0;

   virtual DBIResult DBIFN Refresh(
             SAFEARRAY    *pNewDatapacket,  // New updated datapacket
             ULONGP        iClientData,
             pfDSReconcile pfReconcile // Callback for resolving conflicts
         ) = 0;

   virtual DBIResult DBIFN Reset( // Remove all data from dataset (keep structure)
             VOID
         ) = 0;

   virtual DBIResult DBIFN  RollBack(      // Rollback changes to this savepoint
            SAVEPOINT     iSavePoint
         ) = 0;

   virtual DBIResult DBIFN GetEmbeddedDS(
           UINT32      iFieldID, // FieldID of embedded table (0 : get the first one)
           class TDSBASE     **ppDsDet    // Returns the ds of the embedded table
         ) = 0;

   virtual  DBIResult DBIFN MakeEmbedded(
            class TDSBASE *pDsDet     ,  // Embed this ds in
            UINT32     iFieldsLink,
            pUINT32    piFieldsM,    // Fields in Master
            pUINT32    piFieldsD,    // Fields in Detail
            pCHAR      pMasterFieldName, //Name of new link field in master, NULL if using default name
            pCHAR      pDetailFieldName  //Name of new link field in detail, NULL if using defaultname
         ) = 0;

   virtual  DBIResult DBIFN RefreshRecords(  //Refresh specific records
           SAFEARRAY    *pNewDataPacket,  // Datapacket containing refreshed records
           UINT32       iRecNo     ,      // Refresh this specific record (0 if more than one.Unique key req.)
           ULONGP       iClientData,
           pfDSReconcile pfReconcile      // (NULL) Callback for resolving conflicts
         ) = 0;

   virtual DBIResult DBIFN ReleaseBlobs( // Release all uncommitted blobs
            UINT32  iBlobId   //0: all uncommitted blobs, otherwise : specific blob
         ) = 0;

   virtual DBIResult DBIFN Clone(
            UINT32    iPType,  // 0:normal-ds, dsPACKET_DELTA(1):delta-ds, dsPACKET_ERROR(2):error-ds, dsPACKET_REQUEST(4):request-packet
            BOOL      bRecurse, // TRUE:create complete tree-structure
            BOOL      bCloneOptParams, // TRUE:clone all optional parameters
            class TDSBASE **ppDsClone
         ) = 0;

   virtual  DBIResult DBIFN Reconcile_MD(
            class TDSBASE  *pDsRec ,      // Ds for info
            SAFEARRAY      *pDeltaPickle, // Delta pickle
            SAFEARRAY      *pErrorPickle, // NULL if all changes accepted
            ULONGP         iClientData ,
            pfDSReconcile_MD  pfReconcile_MD    // Callback-fn (called for each error)
        ) = 0;

   virtual DBIResult DBIFN DropOptParameter(// Drop an existing (cashed) optional parameter)
           UINT32  iFldNo  , // 0 if not field attribute
           pCHAR  pName      // Name of attribute to delete
        ) = 0;

#ifdef _UNIX
} COMINTF;
#else
};
#endif

typedef TDSBASE *pTDSBASE;

//Datset cursor class definition
class TDSCursor
{
public:

   virtual HRESULT DBIFN QueryInterface(
         REFIID riid,
         void** ppv
         )  = 0;

   virtual INT32 DBIFN AddRef(
         VOID
         ) = 0;

   virtual INT32 DBIFN Release(
         VOID
         ) = 0;

   virtual DBIResult DBIFN InitCursor( // Associate a cursor with Ds
            pVOID  pDs
            ) = 0;

   virtual DBIResult DBIFN CloneCursor( // Associate a cursor with existing (initialized) cursor
            pVOID pCursor
            ) = 0;

   virtual DBIResult DBIFN  GetCursorProps(
            pDSProps
            ) = 0;

   virtual DBIResult DBIFN  GetIndexDescs(
            BOOL     bCurrentOnly, // Only return 'current' indexdesc, otherwise all
            pDSIDXDesc pIdxDesc
            ) = 0;

   virtual DBIResult DBIFN  GetFieldDescs(
            pDSFLDDesc
            ) = 0;

   virtual DBIResult DBIFN  GetCurrentRecord( // Return record at current cursorposition
            pBYTE pRecBuf
            ) = 0;

   virtual DBIResult DBIFN  GetRecordBlock( // Return block of records
            pUINT32 piRecs,
            pBYTE pRecBuf
            ) = 0;

   virtual DBIResult DBIFN  GetCurrentBookMark( // Get bookmark for current position
            pBYTE pBookMark
            ) = 0;

   virtual DBIResult DBIFN  GetSequenceNumber(// Get Sequence number of current position
            pUINT32 piSeq
            ) = 0;

   virtual DBIResult DBIFN  GetRecordAttribute(// Get record attribute of current position
            pDSAttr  piAttr
            ) = 0;

   virtual DBIResult DBIFN  GetRecordCount( // Number of records in active view
            pUINT piRecs
            ) = 0;

   // Change current position
   virtual DBIResult DBIFN  MoveToBOF(VOID) = 0;         // Set to beginning of table (BOF)
   virtual DBIResult DBIFN  MoveToEOF(VOID) = 0;         // Set to end of table (EOF)
   virtual DBIResult DBIFN  MoveRelative(INT i) = 0;   // Move relative to current position
   virtual DBIResult DBIFN  MoveToSeqNo(UINT32 i) = 0;   // Move to given sequence number (1..n)
   virtual DBIResult DBIFN  MoveToBookMark(pBYTE pBookMark) = 0; // Move to given bookmark position

   virtual DBIResult DBIFN  MoveToKey(
            DSSearchCond eSearchCond,
            UINT32 iFields,
            UINT32 iPartLen,
            pBYTE pRecBuf
            ) = 0;

   virtual DBIResult DBIFN  CompareBookMarks( // Compare two bookmark (positions) -1, 0, 1
            pBYTE pBookMark1,
            pBYTE pBookMark2,
            pINT piCmp
            ) = 0;

   virtual DBIResult DBIFN  ExtractKey( // Extract key from record
            pBYTE pRecBuf,
            pBYTE pKeyBuf
            ) = 0;

   virtual DBIResult DBIFN  GetRecordForKey( // Return (first) record with given key
            UINT32   iFields,
            UINT32   iPartLen,
            pBYTE    pKey,
            pBYTE    pRecBuf
            ) = 0;

   virtual DBIResult DBIFN  GetField( // Extract field value from record buffer
            pBYTE    pRecBuf,
            UINT32   iFieldNo,
            pBYTE    pFldBuf,
            pBOOL    pbBlank   // Returns TRUE/FALSE if blank
            ) = 0;

   virtual DBIResult DBIFN  PutField( // Put field value into record buffer
            pBYTE    pRecBuf,
            UINT32   iFieldNo,
            pBYTE    pFldBuf  // If NULL, adds a blank value
            ) = 0;

   // Blob functions
   virtual DBIResult DBIFN  GetBlobLen( // Return length of blob
            pBYTE    pRecBuf,
            UINT32   iFieldNo,
            pUINT32  piLength
            ) = 0;

   virtual DBIResult DBIFN  GetBlob( // Return blob
            pBYTE    pRecBuf ,
            UINT32   iFieldNo,
            UINT32   iOffSet ,         // Starting position
            pBYTE    pBuf    ,
            pUINT32  piLength          // No of bytes to be read/ returns number read
            ) = 0;

   virtual DBIResult DBIFN  PutBlob( //
            pBYTE    pRecBuf,
            UINT32   iFieldNo,
            UINT32   iOffSet ,         // Starting position
            pBYTE    pBuf,
            UINT32   iLength
            ) = 0;

   // Update functions
   virtual DBIResult DBIFN  InitRecord(   // Initialize record buffer (for insertion)
            pBYTE pRecBuf
            ) = 0;

   virtual DBIResult DBIFN  DeleteRecord( // Delete current record
            VOID
            ) = 0;

   virtual DBIResult DBIFN  ModifyRecord( // Modify current record
            pBYTE pRecBuf
            ) = 0;

   virtual DBIResult DBIFN  InsertRecord( // Insert new record
            pBYTE pRecBuf
            ) = 0;

   virtual DBIResult DBIFN  UndoLastChange(// Undo last update
            BOOL        bFollowChange
            ) = 0;

   virtual DBIResult DBIFN AddFilter(  // Add a canexpr-filter to this cursor
            pVOID       pcanExpr,         // Can expr
            UINT32      iLen    ,         // Length of canexpr
            phDSFilter  phFilter
            ) = 0;

   virtual DBIResult DBIFN DropFilter( // Drop a filter
            hDSFilter   hFilter
            ) = 0;

   virtual DBIResult DBIFN  SetRange( // Set a range on a cursor
            UINT32   iFields   ,
            pBYTE    pKey1     ,
            BOOL     bKey1Incl ,
            pBYTE    pKey2     ,
            BOOL     bKey2Incl
            ) = 0;

   virtual DBIResult DBIFN  DropRange( // Remove current range
            VOID
            ) = 0;

   virtual DBIResult DBIFN  SortOnFields(// Sort on fields
            UINT32   iFields   ,
            pULONGP  piFields  ,       // NULL -> all fields
            pBOOL    pDescending,      // NULL -> all ascending
            pBOOL    pCaseInsensitive  // NULL -> all case-sensitive
             ) = 0;

   virtual DBIResult DBIFN  UseIndexOrder( // Switch to index order
            pCHAR pszName
            ) = 0;

   virtual DBIResult DBIFN SetNotifyCallBack(   // Called when posting changes to dataset
            ULONGP            iClientData,         // Pass-thru client data
            pfCHANGECallBack  pfCallBack           // Call back fn being registered
            ) = 0;

   virtual DBIResult DBIFN AddFilterCallBack(   // Add a canexpr-filter to this cursor
            ULONGP      iClientData,               // Client supplied data
            pfDSFilter  pfFilter   ,               // ptr to filter function
            phDSFilter  phFilter
            ) = 0;

   virtual DBIResult DBIFN VerifyField( // Verify if field value is valid
            UINT32      iFieldNo,
            pBYTE       pFldBuf
            ) = 0;

   virtual DBIResult DBIFN GetProp (    // Get property
            CURProp     eProp  ,           // Property to get
            pULONGP     piPropValue        // Returns property value (or pointer depending on type)
            ) = 0;

   virtual DBIResult DBIFN RevertRecord(  // Revert current record to original state, if appl.
            VOID
            ) = 0;

   virtual DBIResult DBIFN LocateWithFilter(
            pVOID       pCanExpr, // NULL -> use previous
            UINT32      iLen      // Length of canexpr
          ) = 0;

   virtual DBIResult DBIFN AddAggregate(
            UINT32      iFlds       ,   // Defines grouping  (0 if global)
            UINT32      iCanLen     ,   // Length of canexpr (0 if grouping only)
            pVOID       pCanExpr    ,   // Canexpression for aggregate
            phDSAggregate  phAgg        // returns aggregate handle
          ) = 0;

   virtual DBIResult DBIFN DropAggregate(
            hDSAggregate  hAgg
          ) = 0;

   virtual DBIResult DBIFN GetAggregateValue(
            hDSAggregate  hAgg,
            pBYTE         pValue,
            pBOOL         pbBlank
        ) = 0;

   virtual DBIResult DBIFN GetAggregateDesc(
            hDSAggregate  hAgg,
            pDSFLDDesc    pDesc
        ) = 0;

   virtual DBIResult DBIFN MoveToNextSubGroup(
          UINT32     iFields
          ) = 0;

   virtual DBIResult DBIFN GetSubGroupState(
          UINT32     iFields,
          GROUPSTATE *piSubGroupState
         ) = 0;

   virtual DBIResult DBIFN LinkCursors(
           UINT32     iFieldsM ,
           pUINT32    piFieldsM,       // Fields in Master
           pUINT32    piFieldsD,       // Fields in Detail
           class TDSCursor  *hCurDet   // Detail cursor to link (assumes current index at least includes these)
         ) = 0;

   virtual DBIResult DBIFN ResyncWithMaster( // If this is a detail, reset range
            VOID                             // according to master, if master position changed
         ) = 0;

   virtual DBIResult DBIFN SetProp (          // Set property
            CURProp        eProp  ,           // Property to set
            ULONGP         iPropValue         // Property value (or pointer to value)
         ) = 0;

   virtual DBIResult DBIFN GetRecordNumber(  // Return record number of current record, if any
            pUINT32       piRecNo
         ) = 0;

   virtual DBIResult DBIFN GetRowRequestPacket(// Get packet describing the curent 'path', for delayed fetching/refreshing
           BOOL     bKeysOnly       ,  // Only include unique keys in packet
           BOOL     bFetchAllBlobs  ,  // fetch all blobs for 'current'record
           BOOL     bFetchAllDetails,  // fetch all details for 'current' record
           BOOL     bInclMetaData   ,  // Include metadata in packet
           SAFEARRAY **ppPickle        // returns datapacket with row description!
         ) = 0;

   virtual DBIResult DBIFN RefreshRecord( // Refresh details/blobs for this record, and all 'current' records above, if any
           SAFEARRAY    *pNewDataPacket   // New updated pickle
         ) = 0;

#ifdef _UNIX
} COMINTF;
#else
};
#endif

class TAlchemy
{
public:
   // Instantiate a dataset (TDSBASE)
   virtual  DBIResult  DBIFN MakeDS(class TDSBASE **ppDs) ;

   // Create a cursor object from dataset
   virtual  DBIResult  DBIFN MakeCursor(class TDSBASE *pDs, class TDSCursor **ppCur) ;
};

extern "C" DBIResult EXPORTS DBIFN InitAlchemy(class TAlchemy **ppAlc);
extern "C" DBIResult EXPORTS DBIFN ExitAlchemy(class TAlchemy **ppAlc);

#endif
