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

#ifndef ALCHEMY_H
#define ALCHEMY_H

#include "alctypes.h"
#include "talchemy.h"

#if defined(__APPLE__)
#include <sys/types.h>
#endif

#if defined(__ANDROID__)
#include <pthread.h>
#include <umachine.h>
#include <utypes.h>
#include <unistr.h>
#endif

#ifdef _UNIX
  typedef int            SEMAPHOREID;
  typedef struct {       
      pthread_mutex_t      Mutex;
   } CRITICAL_SECTION;
  typedef CRITICAL_SECTION * pCRITICAL_SECTION;
  void EnterCriticalSection( pCRITICAL_SECTION pCriticalSection );
  void LeaveCriticalSection( pCRITICAL_SECTION pCriticalSection );
  void InitializeCriticalSection( pCRITICAL_SECTION pCriticalSection );
  void DeleteCriticalSection( pCRITICAL_SECTION pCriticalSection );
#endif

#if defined(__ANDROID__)
#define WEAKATTR __attribute__((weak))
#else
#define WEAKATTR
#endif

//Used outside DSBASE
#ifdef DEBUG

extern INT32 iIFuncEntryCnt;
extern INT32 iIFuncLeaveCnt;
VOID IEnterFunc(VOID);
VOID ILeaveFunc(VOID);

extern INT32 iFuncEntryCnt;
extern INT32 iFuncLeaveCnt;
VOID EnterFunc(VOID);
VOID LeaveFunc(VOID);

#define DSLOCK(pDs)    EnterCriticalSection(&pDs->s_Crit); IEnterFunc();
#define DSUNLOCK(pDs)  LeaveCriticalSection(&pDs->s_Crit); ILeaveFunc();

//Used inside DSBASE
#define LOCK()    EnterCriticalSection(&s_Crit); EnterFunc();
#define UNLOCK()  LeaveCriticalSection(&s_Crit); LeaveFunc();
#else
#define DSLOCK(pDs)    EnterCriticalSection(&pDs->s_Crit)
#define DSUNLOCK(pDs)  LeaveCriticalSection(&pDs->s_Crit)

//Used inside DSBASE
#define LOCK()    EnterCriticalSection(&s_Crit)
#define UNLOCK()  LeaveCriticalSection(&s_Crit)
#endif

// Dataset class definition
class DSBASE : TDSBASE
{
   UINT32      iRefCount     ;   // Reference count, delete object when hitting 0

   pBYTE       pAuxRecBuf    ;   // Auxiliary buffer used internaly
   UINT32      iRecordSpace  ;   // Current capacity, number of records
   UINT32      iIndexIDs     ;   // Generator of index/order IDs

   pfDSCalcField  pfCalcFn   ;   // Callback function for calculated fields, NULL
   UINT32      iCalcClientData;  // Client data for calc-callback
   BOOL        bDontInclMetaData;// Do not include metadata when straeming data (2.0 feature)
   UINT32      iSeqSavePoints;   // Generator of sequence numbers for savepoints

   // Overwrite record
   DBIResult DBIFN  PutRecord(UINT32 iRecNo, pBYTE pRecBuf);

   // Create in memory from Datapacket
   DBIResult DBIFN  MakeInMem(SAFEARRAY *pDataPacket);
   DBIResult DBIFN  InitializeFields();

   // Compare two records to see if they are identical
   BOOL DBIFN RecsEqual(UINT32 iRecNo1, UINT32 iRecNo2, BOOL bCmpBlobs, pBOOL pbSame);

   // Updates maintained objects
   DBIResult DBIFN  xInsertRecord(UINT32 iRecNo, UINT32 iNo);
   DBIResult DBIFN  xDeleteRecord(UINT32 iRecNo, UINT32 iNo);
   DBIResult DBIFN  xModifyRecord(UINT32 iRecNo1, UINT32 iRecNo2, UINT32 iNo);
   DBIResult DBIFN  RecalcRec(UINT32 iRowNo, pBYTE pRecBuf);

   // Increase capacity
   DBIResult DBIFN  GrowDS(UINT32 iRecs); // Reallocate Dataset/Increase capacity
   VOID      DBIFN  InitDsObj(pCHAR pDsName); // Initialize object
   VOID      DBIFN  ResetAll(VOID); // Deallocate everything
public:

   BOOL        bDisableLog ;      // Disable log (when creating)

   pCHAR       pszName     ;      // Name of dataset

   UINT32      iFields     ;      // Number of fields
   pDSFLDDesc  pFieldDesc  ;      // Array of field descriptors for all fields

   UINT32      iBlobFields ;      // Number of blob fields

   pDSAttr     piAttr      ;      // Attribute column
   pBYTE      *ppColumns   ;      // Columns
   pBYTE       pNulls      ;      // Nulls column  (0)

   UINT32      iNullOffset ;      // Null offset in record buffer
   UINT32      iNullLength ;      // Length of null field
   UINT32      iRecordSize ;      // Total size of record

   UINT32      iIndexes       ;      // Total number of indexes in index-list
   UINT32      iIndexesShared ;      // Number of shared indexes
   class DSIDX      *pIdx     ;      // List of maintained index objects

   class DSIDX      *pIdxChg  ;      // Change index
   class DSIDX      *pIdxDef  ;      // Default order

   class DSLOG      *pDsLog   ;      // Log of changes

   class DSBLOBS    *pDsBlobs ;   // Blob handler
   class DSCONSTR   *pDsConstr;   // Constraints/filters
   class DSOPTPARAM *pDsOptParams;// Optional parameters
   class DSCALLBACK *pDsCallBacks;// Callbacks

   UINT32      iRecords    ;      // Number of (visible) records in dataset
   UINT32      iRecNoNext  ;      // Next record-number (after insertion)

   BOOL        bDelta      ;      // This is a delta dataset (-> show all records)
   UINT32      iLCID       ;      // Language ID (0 if  none)
   BOOL        bReadOnly   ;      // Table can not be updated

   CRITICAL_SECTION s_Crit ;      // Multithread

   class DSEXTRACT  *pDsExtract;  // Datapacket extract object
   class DSEXTRACT  *pDsExtractSave; // Datapacket extract object (save it here)
   BOOL        bPartial    ;      // Dataset is 'partial'
   BOOL        bConstraintsDisabled; // TRUE: updates does not check constraints
   BOOL        bDefOrderChanged; // Local create index on szDEFAULT_ORDER (not received in datapacket)

   UINT32      iAutoIncField ;   // Fieldnumber of autoinc-field, if any.
   UINT32      iAutoIncNext  ;   // Value for next record to insert (1-based)
   UINT32      iInclBlobsInDelta;// Include blobs with lengths less than this value in delta (dsRecOrg/delete) (2.0 feature)
   // New for 2.0
   BOOL        bCompressArrays;  // Compress fielddesc. for arrays
   UINT32      iFieldsCompressed;// Number of fielddescs, if arrays are compressed
   UINT32      iFieldsDataPacket;// Fields in datapacket (unaffected by AddField)

   class LTABLEList *pLinkedTables; // List of details/nested tables
   class DSBASE *pDsParent    ;  // Parent, if this is detail/nested table
   UINT32      iSetIDNext     ;  // Generates setID's (same as autoinc
   UINT32      iDetID         ;  // DetailID of this Ds, if any

   UINT32      iFieldID_SetIDD;  // Field id of SetId linking field, if any
   UINT32      iLinkFields    ;  // Number of linkfields to parent
   DBIKEY      piLinkField    ;  // Actual linkfields(IDs) in this dataset
   UINT32      iMDSemantics   ;  // Master/detail semantics
   class VARStrList *pStrings ;  // List of fieldnames
   class DSBASE *pDsReq       ;  // Generates request packets
   UINT32      iUnusedCnt     ;  // Number of 'holes', that can be reused on insertion.
   UINT32      iRemoteUpdMode ;  // Updatemode at server, 0:where key, 1: where all 2:where change
   BOOL        bIgnSetIDInIdx ;  // TRUE: when creating index in child, don't include SetID (CreateIndex)
   UINT32      iXmlMode;
   pBYTE       pFldBufScratch;   //Equal to maximum fieldsize (MAXFIELDLEN .. 64k-1)
   UINT32      iFldBufScratchLen;
   BOOL        bDisableDeletes;
   BOOL        bDisableInserts;
   BOOL        bDisableEdits;
   BOOL        bDisableStringTrimming; //Disable trimming of strings (in putfield)
   BOOL        bDataHasChanged;

   BOOL        bUTF8METADATA; // if TRUE, METADATA is UTF8. Tiburon and later is TRUE.
   BOOL        bUTF8ERRORMSG; // if TRUE, Error message is UTF8. Tiburon and later is TRUE.
   INT32       iANSICodePage; // MIDAS's internal ANSI codepage.

   DSBASE(); // Instantiate dataset

   ~DSBASE(); // Release dataset

   HRESULT DBIFN QueryInterface( // Dummy
         REFIID riid,
         void** ppv
         );

   UINT32 DBIFN AddRef(  // Increase reference count
         VOID
         );

   UINT32 DBIFN Release( // Decrease reference count
         VOID
         );

   DBIResult DBIFN Create(  // Create empty dataset
         UINT32      iFields,
         pDSFLDDesc  pFldDes,
         pCHAR pszName
         );

   DBIResult DBIFN AddField(
         pDSFLDDesc pFldDes
         );

   DBIResult DBIFN AppendData( // Appends data from datapacket to dataset. First datapacket contains meta-info.
          SAFEARRAY *pDatapacket, // Datapacket/Partial datapacket
          BOOL  bEof       // If True, this is last pickle
         );

   DBIResult DBIFN GetOptParameter(// Returns optional parameter (unknown to dataset)
         UINT32 iNo     , // Number 1..iOptAttr. If 0, finds attribute pointed to by *ppName.
         UINT32 iFldNo  , // 0 if not field attribute
         ppCHAR  ppName , // returns ptr to name
         pUINT32 piType , // returns type
         pUINT32 piLen  , // returns length
         ppCHAR  ppValue  // returns ptr to value
         );

   DBIResult DBIFN AddOptParameter(// Adds optional parameter to dataset
         UINT32  iFldNo  , // 0 if not field attribute
         pCCHAR   pszAttr , // ptr to name
         UINT32  iType   , // type
         UINT32  iLen    , // length
         pBYTE   pValue    //  ptr to value
         );

   DBIResult DBIFN  GetProps(
          pDSProps
         ) ;

   DBIResult DBIFN  GetFieldDescs(
          pDSFLDDesc  // Returns 'iFields'
         );

   DBIResult DBIFN  GetIndexDescs(
          pDSIDXDesc
         );

   DBIResult DBIFN GetDelta(  // Extract delta from ds, as delta dataset
         pBYTE *ppDsDelta      // (DSBASE *)
         );

   DBIResult DBIFN StreamDS( // Create datapacket version of dataset
         SAFEARRAY **ppDatapacket // Returns datapacket in buffer.
         );

   DBIResult DBIFN AcceptChanges(// Accept all current changes (cannot be undone)
         VOID
         );

   DBIResult DBIFN GetErrorString(
         DBIResult iErrCode,
         pCHAR pString
         );

   DBIResult DBIFN GetRecord( // Return record
         UINT32   iRecNo ,
         pBYTE    pRecBuf
         ); // Also return attribute!

   DBIResult DBIFN GetField( // Return field value from dataset
         UINT32   iRecNo  ,
         UINT32   iFldNo  ,
         pBYTE    pFldBuf ,
         pBOOL    pbBlank
         );

   DBIResult DBIFN GetField( // Return field value from record buffer
         pBYTE   pRecBuf,
         UINT32  iFldNo  ,
         pBYTE   pFldBuf  ,
         pBOOL   pbBlank
         );

   DBIResult DBIFN PutField( // Put field value in dataset
         UINT32  iRecNo ,
         UINT32  iFldNo ,
         pBYTE   pFldBuf
         );

   DBIResult DBIFN PutField( // Put field value in record buffer
         pBYTE   pRecBuf,
         UINT32  iFldNo ,
         pBYTE   pFldBuf
         );

   DBIResult DBIFN PutBlank( // Put blank value
         pBYTE   pRecBuf,  // RecBuf OR
         UINT32  iRecNo ,  // iRecNo
         UINT32  iFldNo ,
         UINT32  iBlankValue
         );

   DBIResult DBIFN  GetBlobLen( // Return length of blob
         pBYTE    pRecBuf ,
         UINT32   iFieldNo,
         pUINT32  piLength
         );

   DBIResult DBIFN  GetBlob( // Return blob
         pBYTE    pRecBuf,
         UINT32   iFieldNo,
         UINT32   iOffset ,
         pBYTE    pBuf    ,
         pUINT32  iLength
         );

   DBIResult  DBIFN PutBlob( //
         pBYTE    pRecBuf,
         UINT32   iFieldNo,
         UINT32   iOffset ,
         pBYTE    pBuf,
         UINT32   iLength
         );

   DBIResult DBIFN IsValidRec( // Valid, 'visible' record
         UINT32 iRecNo
         );

   DBIResult DBIFN DeleteRecord( // Delete record
         UINT32 iRecNo
         );

   DBIResult DBIFN ModifyRecord( // Modify record
         UINT32 iRecNo,    // Record to modify
         pBYTE pRecBuf,    //
         pUINT32 piRecNo   // New record number of modified record
         );

   DBIResult DBIFN InsertRecord( // Insert new record
         pBYTE pRecBuf,
         pUINT32 piRecNo   // New record number for inserted record
         );

   DBIResult DBIFN UndoLastChange(// Undo the last change
         pUINT32 piRecNo    // Record number of record that was undone
         );

   DBIResult DBIFN CreateIndex(  // Create, and add an index
         pDSIDXDesc  pIdxDesc
         );

   DBIResult DBIFN RemoveIndex(  // Remove index of given name
         pCHAR      pszName
         );

   DBIResult DBIFN AddIndex(     // Add an index as a maintained object
         class DSIDX far *pIdx
         );

   DBIResult DBIFN DropIndex(    // Remove an index as a maintained object (usecount)
         class DSIDX far *pIdx
         );

   DBIResult DBIFN FindIndex(   // Find given index
         pCCHAR pszName,
         class DSIDX **pIdx
         );

   DBIResult DBIFN FindEqIndex(   // Find equivalent index
         pDSIDXDesc pIdxDesc,
         class DSIDX **pIdx
         );

   INT    DBIFN FldCmp(  // Compare field values (equality only), returns 0 if equal
         UINT32   iFldType , // Fieldtype
         pBYTE    pFld1    , // NULL if blank
         pBYTE    pFld2    , // NULL if blank
         UINT32   iUnits1 ,
         UINT32   iUnits2
         );

   DBIResult DBIFN SetNotifyCallBack(  // Called when posting changes to dataset
          ULONGP            iId,     // (Cursor handle)
          pfCHANGECallBack  pfCallBack  // Call back fn being registered
          );

   DBIResult DBIFN GetProp (          // Get property
            DSProp         eProp  ,           // Property to get
            pULONGP        piPropValue        // Returns property value (or pointer depending on type)
          );

   DBIResult DBIFN SetProp (          // Set property
            DSProp         eProp  ,           // Property to set
            ULONGP         iPropValue         // Property value (or pointer to value)
          );

   DBIResult DBIFN SetFieldCalculation( // Register fieldcalculation on this field
            ULONGP         iClientData,
            pfDSCalcField  pfCalc        // Callback function, NULL to remove
          );

   DBIResult DBIFN Reconcile(
            SAFEARRAY     *pDeltaDatapacket, // Delta datapacket
            SAFEARRAY     *pErrorDatapacket, // NULL if all changes accepted
            ULONGP         iClientData ,
            pfDSReconcile  pfReconcile   // Callback-fn (called for each error)
          );

      DBIResult DBIFN MakeUnused(UINT32 iRecNo);

      DBIResult DBIFN UndoRecord(UINT32 iRecNo1, UINT32 iRecNo2, DSAttr iAttr, BOOL bAdjLog);

      DBIResult DBIFN Unused1(
            VOID
         );

      DBIResult DBIFN Unused2(
            VOID
         );

      DBIResult DBIFN Unused3(
            VOID
         );

      DBIResult DBIFN Refresh(
             SAFEARRAY    *pNewDatapacket,  // New updated datapacket
             ULONGP        iClientData,
             pfDSReconcile pfReconcile // Callback for resolving conflicts
         );

      DBIResult DBIFN  Reset(VOID); // Remove all data from dataset (Empty table, keep structure)

      DBIResult DBIFN  OverWriteRecord(// Overwrites record iRecNo
            UINT32        iRecNo,   // Record to overwrite
            pBYTE         pRecBuf,  // Values to use
            BOOL          bBlobs    // Ignore blobs
         );

      DBIResult DBIFN  ApplyDelta(
            DSBASE       *pDsDelta,   // Apply these changes
            ULONGP        iClientData,
            pfDSReconcile pfReconcile // Callback for resolving conflicts
         );

      DBIResult DBIFN  RollBack(      // Rollback changes to this savepoint
            SAVEPOINT     iSavePoint
         );

      DBIResult DBIFN  RegisterFieldCompare( // Register a field compare function for an extended type
            UINT32        iFieldNo   ,  // Field id
            ULONGP        iClientData,  // Clientdata returned in compare function
            pfFLDComp     pfComp
         );

      DBIResult DBIFN  AddFldOptParameter(// Adds optional parameter to dataset
            UINT32        iFldNo   , // 0 if not field attribute
            pCCHAR         szAttr   , // ptr to name
            UINT32        iPCKLType, // type
            UINT32        iAttrLen , // length
            pBYTE         pValue   , // ptr to value
            pDSFLDDesc    pFldDesc // Pointer to fielddesc, if any
         );

     DBIResult DBIFN   ReadMetaData(
            DSEXTRACT    *pUP,
            UINT32        iFields
         );

     DBIResult DBIFN   GrowRows(
            UINT32      iInc,    // Increase by this amount
            UINT32      iMax     // But not above this value, if != 0
         );


     DBIResult DBIFN GetEmbeddedDS(
            UINT32      iFieldID, // FieldID of embedded table (0 : get the first one)
            class TDSBASE     **ppDsDet    // Returns the ds of the embedded table
          );

     DBIResult DBIFN MakeEmbedded(
            class TDSBASE  *pDsDet     ,  // Embed this ds in
            UINT32     iFieldsLink,
            pUINT32    piFieldsM,    // Fields in Master
            pUINT32    piFieldsD,    // Fields in Detail
            pCHAR      pMasterFieldName, //Name of new link field in master, NULL if using default name
            pCHAR      pDetailFieldName  //Name of new link field in detail, NULL if using defaultname
         );

      DBIResult DBIFN RefreshRecords(  //Refresh specific records
           SAFEARRAY    *pNewDataPacket,  // Datapacket containing refreshed records
           UINT32       iRecNo     ,      // Refresh this specific record (0 if more than one.Unique key req.)
           ULONGP       iClientData,
           pfDSReconcile pfReconcile      // (NULL) Callback for resolving conflicts
          );

      DBIResult DBIFN OverWriteRecord(//Second version, uses record in other dataset
            UINT32       iRecNo,
            class TDSBASE *pDs2,
            UINT32       iRecNo2,
            INT32        iFldFirst, // First field (only used for errorpacket)
            pBOOL        pbIgn      //If pbIgn[i] is TRUE, don't overwrite field i+1
         );

      DBIResult  DBIFN GetFieldPtr(
            UINT32      iRecNo,
            UINT32      iFldNo,
            pBYTE      *ppFldPtr, // If Blank, returns NULL
            pBOOL       pbBlank
         );

      DBIResult DBIFN ReleaseBlobs( // Release all uncommitted blobs
            UINT32  iBlobId   //0: all uncommitted blobs, otherwise specific blob
         );

      DBIResult DBIFN MoveRecordOver( // Move record
           UINT32 iRecNoTo,  
           UINT32 iRecNoFrom
         );

      DBIResult DBIFN Clone( // Clones the structure of the dsbase, including details if any
            UINT32    iPType,          // 0:normal-ds, dsPACKET_DELTA(1):delta-ds, dsPACKET_ERROR(2):error-ds, dsPACKET_REQUEST(4):request-packet
            BOOL      bRecurse,        // TRUE:create complete tree-structure
            BOOL      bCloneOptParams, // TRUE:clone all optional parameters (normal only)
            class TDSBASE **ppDsClone  // Returned dsbase
        );

      DBIResult  DBIFN PutFieldPtr(//Faster version, matches GetFieldPtr, trusted clients
            UINT32      iRecNo,
            UINT32      iFldNo,
            pBYTE       pFldPtr,    // If Blank, returns NULL
            BOOL        bBlank
        );

     DBIResult DBIFN GlobalLogUndo(
          UINT32  iDetID,
         UINT32  iCntD    // 0: last. Relates to 'iCnt'th last detail upd to this detail!
         );

     DBIResult DBIFN Reconcile_MD(
            class TDSBASE  *pDsRec ,      // Ds for info
            SAFEARRAY      *pDeltaPickle, // Delta pickle
            SAFEARRAY      *pErrorPickle, // NULL if all changes accepted
            ULONGP         iClientData ,
            pfDSReconcile_MD  pfReconcile_MD    // Callback-fn (called for each error)
        );

     DBIResult DBIFN IncRow(
            VOID                //Increments iRecNext, and grows array if nesc.
         );

     DBIResult DBIFN DropOptParameter(// Returns optional parameter (unknown to dataset)
         UINT32  iFldNo  , // 0 if not field attribute
         pCHAR  pName  // returns ptr to name
         );

     DBIResult  DBIFN GetFieldPtrB(
         pBYTE       pRecBuf,
         UINT32      iFldNo,
         pBYTE      *ppFldPtr, // If Blank, returns NULL
         pBOOL       pbBlank
        );
};
typedef DSBASE *pDSBASE;


//Dataset cursor class definition
class DSCursor : TDSCursor
{
   UINT32      iRefCount ;   // Reference count, delete object when hitting 0
   UINT32      iCurPos   ;   // Current position
   UINT32      iCurState ;   // Crack-value
   UINT32      iCurFirst ;   // Lower Range
   UINT32      iCurLast  ;   // Upper Range
   UINT32      iSeqNo    ;   // Version, compared with current sortorder
   UINT32      iSavePos  ;   // Last valid position
   UINT32      iSaveState;   //
   UINT32      iSaveRecNo;   //

   BOOL        bActiveRange      ;
   BOOL        bRangeHLSame      ;   // Upper and lower limit is the same (subset)
   BOOL        bRangeIncLow      ;
   UINT32      iRangeFieldsLow   ;   // Number of range fields from current index
   UINT32      iRangePartLenLow  ;
   BOOL        bRangeIncHigh     ;
   pBYTE       pRangeLow         ;   // RecordBuffer
   pBYTE       pRangeHigh        ;   // RecordBuffer
   UINT32      iRangeFieldsHigh  ;   // Number of range fields from current index
   UINT32      iRangePartLenHigh ;

   pUINT32     piFieldMap     ;
   pBYTE       pBaseRecBuf    ;  // Record buffer the size of a base record

   UINT32      iNullOffset    ;   // Offset to null-indicators

   class DSCONSTR *pLocateFilt;   // Filter for locate
   ULONGP      hLocate        ;   // Locate handle

   class DSIDX *pIdx          ;  // Order of cursor
   DBIResult DBIFN  Resync(VOID)   ;
   DBIResult DBIFN  SavePos(VOID)  ;  // Save current position
   DBIResult DBIFN  SetActiveRange(VOID); // Set iCurFirst/Last after change
   DBIResult DBIFN InternalDropRange(VOID);

   ULONGP      iNotifyData   ;
   pfCHANGECallBack pfNotifyCallBack;
   friend VOID DBIFN CursorCallBack(ULONGP hCursor); // Called from ds-layer

public:
   class DSBASE *pDs          ; // Dataset owner
   UINT32      iBookMarkSize  ; // Size of bookmark
   UINT32      iFields        ; // Number of fields in cursorview
   pDSFLDDesc  pFieldDesc     ; // Array of field desc.
   UINT32      iRecordSize    ; // Size of logical recordbuffer
   UINT32      iFilters       ; // Number of active filters on cursor


   UINT32      iSeqNoM        ;
   UINT32      iSeqNoD        ;
   DSCursor   *hCurParent     ; // Parent cursor if any
   UINT32      iCurrSetID     ; // Current SetID, if this is a detail. Used to test for dsDELAYEDBIT.

   DSCursor();
   ~DSCursor();

   HRESULT DBIFN QueryInterface( // Dummy
            REFIID   riid,
            VOID   **ppv
            );

   INT32 DBIFN AddRef(
            VOID
            );

   INT32 DBIFN Release(
            VOID
            );

   DBIResult DBIFN InitCursor( // Associate a cursor with Ds
            pVOID pDs
            );

   DBIResult DBIFN CloneCursor( // Associate a cursor with existing (initialized) cursor
            pVOID pCursor
            );

   DBIResult DBIFN GetCursorProps(
            pDSProps pCurProps
            );

   DBIResult DBIFN GetIndexDescs(
            BOOL     bCurrentOnly, // Only return 'current' indexdesc, otherwise all
            pDSIDXDesc pIdxDesc
            );

   DBIResult DBIFN GetFieldDescs(
            pDSFLDDesc  pFldDesc
            );

   DBIResult DBIFN GetCurrentRecord( // Return record at current cursorposition
            pBYTE    pRecBuf
            );

   DBIResult DBIFN GetRecordBlock( // Return block of records
            pUINT32  piRecs,
            pBYTE    pRecBuf
            );

   DBIResult DBIFN GetCurrentBookMark( // Get bookmark for current position
            pBYTE    pBookMark
            );

   DBIResult DBIFN GetSequenceNumber(// Get Sequence number of current position
            pUINT32  piSeq
            );

   DBIResult DBIFN GetRecordAttribute(// Get record attribute of current position
            pDSAttr  piAttr
            );

   DBIResult DBIFN GetRecordCount( // Number of records in active view
            pUINT  piRecs
            );

   // Change current position 
   DBIResult DBIFN MoveToBOF(VOID); // Set to beginning of table (BOF)

   DBIResult DBIFN MoveToEOF(VOID); // Set to end of table (EOF)

   DBIResult DBIFN MoveRelative(INT i); // Move relative to current position
   
   DBIResult DBIFN MoveToSeqNo(UINT32 i); // Move to given sequence number (1..n)

   DBIResult DBIFN MoveToBookMark(pBYTE pBookMark); // Move to given bookmark position

   DBIResult DBIFN MoveToKey(
              DSSearchCond     eSearchCond,
              UINT32           iFields,
              UINT32           iPartLen,
              pBYTE            pRecBuf
              );

   DBIResult DBIFN CompareBookMarks( // Compare two bookmark (positions) -1, 0, 1
            pBYTE    pBookMark1,
            pBYTE    pBookMark2,
            pINT   piCmp
            );

   DBIResult DBIFN ExtractKey( // Extract key from record
            pBYTE    pRecBuf,
            pBYTE    pKeyBuf
            );

   DBIResult DBIFN GetRecordForKey( // Return (first) record with given key
            UINT32   iFields,
            UINT32   iPartLen,
            pBYTE    pKey,
            pBYTE    pRecBuf
            );

   DBIResult DBIFN GetField( // Extract field value from record buffer
            pBYTE    pRecBuf,
            UINT32   iFieldNo,
            pBYTE    pFldBuf,
            pBOOL    pbBlank   // Returns TRUE/FALSE if blank
            );

   DBIResult DBIFN PutField( // Put field value into record buffer
            pBYTE    pRecBuf,
            UINT32   iFieldNo,
            pBYTE    pFldBuf  // If NULL, adds a blank value
            );

   // Blob functions
   DBIResult DBIFN GetBlobLen( // Return length of blob
            pBYTE    pRecBuf ,
            UINT32   iFieldNo,
            pUINT32  piLength
            );

   DBIResult DBIFN GetBlob( // Return blob
            pBYTE    pRecBuf ,
            UINT32   iFieldNo,
            UINT32   iOffSet ,         // Starting position
            pBYTE    pBuf    ,
            pUINT32  piLength          // No of bytes to be read/ returns number read
            );

   DBIResult DBIFN PutBlob(
            pBYTE    pRecBuf ,
            UINT32   iFieldNo,
            UINT32   iOffSet ,         // Starting position
            pBYTE    pBuf    ,
            UINT32   iLength
            );

   // Update functions
   DBIResult DBIFN InitRecord( // Initialize record buffer (for insertion)
            pBYTE pRecBuf
            );

   DBIResult DBIFN DeleteRecord( // Delete current record
            VOID
            );

   DBIResult DBIFN ModifyRecord( // Modify current record
            pBYTE pRecBuf
            );

   DBIResult DBIFN InsertRecord( // Insert new record
            pBYTE pRecBuf
            );

   DBIResult DBIFN UndoLastChange(// Undo last update
            BOOL        bFollowChange
            );

   DBIResult DBIFN AddFilter(  // Add a canexpr-filter to this cursor
            pVOID       pcanExpr,
            UINT32      iLen    , // Length of canexpr
            phDSFilter  phFilter
            );

   DBIResult DBIFN DropFilter( // Drop a filter
            hDSFilter   hFilter // NULL all filters
            );

   DBIResult DBIFN SetRange( // Set a range on a cursor
            UINT32   iFields   , 
            pBYTE    pKey1     ,
            BOOL     bKey1Incl ,
            pBYTE    pKey2     ,
            BOOL     bKey2Incl
            );

   DBIResult DBIFN DropRange( // Remove current range
            VOID
            );

   DBIResult DBIFN SortOnFields(// Sort on fields
            UINT32   iFields,
            pULONGP  piFields,         // NULL -> all fields
            pBOOL    pDescending,      // NULL -> all ascending
            pBOOL    pCaseInsensitive  // NULL -> all case-sensitive
            );

   DBIResult DBIFN UseIndexOrder( // Switch to index order
            pCHAR pszName
            );

   DBIResult DBIFN SetNotifyCallBack(  // Called when posting changes to dataset
            ULONGP            iClientData,    // Pass-thru client data
            pfCHANGECallBack  pfCallBack      // Call back fn being registered
            );

   DBIResult DBIFN AddFilterCallBack(  // Add a canexpr-filter to this cursor
            ULONGP      iClientData,    // Client supplied data
            pfDSFilter  pfFilter   ,    // ptr to filter function
            phDSFilter  phFilter
            );

   DBIResult DBIFN VerifyField( // Verify if field value is valid
            UINT32      iFieldNo,
            pBYTE       pFldBuf
           );

   DBIResult DBIFN GetProp (          // Get property
            CURProp        eProp  ,           // Property to get
            pULONGP        piPropValue        // Returns property value (or pointer depending on type)
           );

   DBIResult DBIFN RevertRecord(  // Revert current record to original state, if appl.
            VOID
           );

   DBIResult DBIFN LocateWithFilter(
            pVOID       pCanExpr, // NULL -> use previous
            UINT32      iLen      // Length of canexpr
          );

   DBIResult DBIFN AddAggregate(
            UINT32      iFlds       ,   // Defines grouping  (0 if global)
            UINT32      iCanLen     ,   // Length of canexpr (0 if grouping only)
            pVOID       pCanExpr    ,   // Canexpression for aggregate
            phDSAggregate  phAgg        // returns aggregate handle
          );

   DBIResult DBIFN DropAggregate(
            hDSAggregate  hAgg
          );

   DBIResult DBIFN GetAggregateValue(
            hDSAggregate  hAgg,
            pBYTE         pValue,
            pBOOL         pbBlank
        );

   DBIResult DBIFN GetAggregateDesc(
           hDSAggregate  hAgg,
            pDSFLDDesc    pDesc
        );

   DBIResult DBIFN MoveToNextSubGroup(
           UINT32    iFields
          );

   DBIResult DBIFN GetSubGroupState(
           UINT32    iFields,
           GROUPSTATE *piSubGroupState
          );

   DBIResult DBIFN LinkCursors(
            UINT32     iFieldsM ,
            pUINT32    piFieldsM, // Fields in Master
            pUINT32    piFieldsD, // Fields in Detail
            class TDSCursor  *hCurDet // Detail cursor to link (assumes current index at least includes these)
          );

   DBIResult DBIFN ResyncWithMaster( // If this is a detail, reset range
            VOID                     // according to master, if master position changed
          );

   DBIResult DBIFN GetDetailKey( // Called by detail to extract linking field(s) for 'current' master
            UINT32 iDetID,       // ID for detail making request
            pBYTE  pRecBufDet,   // Detail record buffer
            BOOL   bKeyOnly  ,   // True -> key only
            pUINT32 piSetID  ,   // Returns the SetID for the detail (stored in the master_record)
            pUINT32 piRecNo  ,   // RecNo of master
            pUINT32 piFieldIDM   // FieldID of linking field
          );

   DBIResult DBIFN GlobalUpdateNotify( // Called by detail to notify about a change
          UINT32  iDetID       // ID of detail calling
          );

   DBIResult DBIFN SetProp (          // Set property
            CURProp        eProp  ,           // Property to set
            ULONGP         iPropValue         // Property value (or pointer to value)
          );

   DBIResult DBIFN GetRecordNumber(  // Return record number of current record, if any
            pUINT32       piRecNo
          );

   DBIResult DBIFN GlobalLogUndo(
          UINT32  iDetID,
         UINT32  iCntD    // 0: last. Relates to 'iCnt'th last detail upd to this detail!
         );

   DBIResult DBIFN  GetRowRequestPacket(// Get packet describing the curent 'path', for delayed fetching/refreshing
           BOOL     bKeysOnly       ,  // Only include unique keys in packet
           BOOL     bFetchAllBlobs  ,  // fetch all blobs for 'current'record
           BOOL     bFetchAllDetails,  // fetch all details for 'current' record
           BOOL     bInclMetaData   ,  // Include metadata in packet
           SAFEARRAY **ppPickle        // returns datapacket with row description!
         );

   DBIResult DBIFN  RefreshRecord( // Refresh details/blobs for this record, and all 'current' records above, if any
           SAFEARRAY    *pNewDataPacket   // New updated pickle
         );
};

#if defined(__ANDROID__)
extern pCHAR (*pu_strToUTF8)(pCHAR,
              INT32,
              INT32 *,
              const UChar *,
              INT32,
              UErrorCode *);

extern UChar* (*pu_strFromUTF8)(UChar *,
               INT32,
               INT32 *,
               pCCHAR,
               INT32,
               UErrorCode *);

extern UConverter* (*pucnv_open)(pCCHAR, UErrorCode *);

extern void (*pucnv_close)(UConverter *);

extern INT32 (*pucnv_toUChars)(UConverter *,
              UChar *, INT32,
              pCCHAR, INT32,
              UErrorCode *);

extern INT32 (*pucnv_fromUChars)(UConverter *,
              pCHAR, INT32,
              const UChar *, INT32,
              UErrorCode *);

extern pCCHAR (*pucnv_getDefaultName)(void);
#endif

#endif
