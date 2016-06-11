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

#ifndef ALCTYPES_H
#define ALCTYPES_H

#include "bdetypes.h"

#ifdef _UNIX
#ifndef REFIID
   #ifndef HRESULT
      #define HRESULT int
   #endif
   #define S_FALSE  0X00000001
   #define CLASS_E_CLASSNOTAVAILABLE  0x80040111
   #define CLASS_E_NOAGGREGATION      0x80040110
   #define SELFREG_E_CLASS            0x00040201
   struct GUID
   {
   UINT   p1;
   UINT16 p2;
   UINT16 p3;
   BYTE p4[8];
   };
  #if defined(DSPICKLE_C) && !defined(MIDAS_OBJ)
  #define DEFINE_GUID( name, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8 ) extern const GUID name = { l, w1, w2, { b1, b2, b3, b4, b5, b6, b7, b8 } }
  #else
  #define DEFINE_GUID( name, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8 ) extern const GUID name;
  #endif
  #define _GUID GUID
  #define REFIID const GUID &
  BOOL IsEqualCLSID( REFIID riid1, REFIID riid2 );
  #define REFCLSID GUID &
  #define UNREFERENCED_PARAMETER( riid ) ( (void)riid )
  #if __GNUC__
    #define COMINTF
  #else
    #define COMINTF __attribute__ ((com_interface))
  #endif
  class IUnknown
  {
  public:
    virtual HRESULT DBIFN QueryInterface( const GUID &guid, void ** ppv ) = 0;
    virtual INT32 DBIFN AddRef() = 0;
    virtual INT32 DBIFN Release() = 0;
  } COMINTF;
  class IClassFactory : public IUnknown
  {
  public:
     virtual HRESULT DBIFN CreateInstance(IUnknown *unkOuter, const GUID &riid,
           void ** ppv ) = 0;
     virtual HRESULT DBIFN LockServer( BOOL bLock ) = 0;
  } COMINTF;

#endif  // #ifndef REFIID
#endif  // #ifdef _UNIX

#define MIDAS_DLL

#ifdef MIDAS_DLL
#define DBCLIENT_DLL "MIDAS.DLL"
#else
#define DBCLIENT_DLL "DBCLIENT.DLL"
#endif

#ifdef MIDAS_DLL

///MIDAS.DLL
//Original version
#define PROGID_MDSBASE_1 "Borland.Midas_DSBase.1"
#define PROGID_MDSBASE_DESC_1 "Borland Midas DSBase 1"

// Current version
#define PROGID_MDSBASE "Borland.Midas_DSBase"
#define PROGID_MDSBASE_DESC "Borland Midas DSBase Current"


//VERSION 1
//GUID for DSBASE class factory
DEFINE_GUID(CLSID_MDSBASE_1, 0x9E8D2FA1, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2FA1-591C-11D0-BF52-0020AF32BD64}
//GUID for DSBASE interface
DEFINE_GUID(IID_MDSBASE_1, 0x9E8D2FA2, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2FA2-591C-11D0-BF52-0020AF32BD64}

#define IID_MDSBASE IID_MDSBASE_1
#define CLSID_MDSBASE CLSID_MDSBASE_1


// Original version
#define PROGID_MDSCURSOR_1 "Borland.Midas_DSCursor.1"
#define PROGID_MDSCURSOR_DESC_1 "Borland Midas DSCursor 1"

// Current Version
#define PROGID_MDSCURSOR "Borland.Midas_DSCursor"
#define PROGID_MDSCURSOR_DESC "Borland Midas DSCursor Current"

//VERSION 1
//GUID for DSCursor class factory
DEFINE_GUID(CLSID_MDSCURSOR_1, 0x9E8D2FA3, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2FA3-591C-11D0-BF52-0020AF32BD64}
//GUID for DSCursor interface
DEFINE_GUID(IID_MDSCURSOR_1, 0x9E8D2FA4, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2FA4-591C-11D0-BF52-0020AF32BD64}

#define IID_MDSCURSOR   IID_MDSCURSOR_1
#define CLSID_MDSCURSOR CLSID_MDSCURSOR_1

#else

///DBCLIENT.DLL

//Original version
#define PROGID_DSBASE_1 "Borland.DbClient_DSBase.1"
#define PROGID_DSBASE_DESC_1 "Borland DbClient DSBase 1"

// Version 2
#define PROGID_DSBASE_2 "Borland.DbClient_DSBase.2"
#define PROGID_DSBASE_DESC_2 "Borland DbClient DSBase 2"

// Current version
#define PROGID_DSBASE "Borland.DbClient_DSBase"
#define PROGID_DSBASE_DESC "Borland DbClient DSBase Current"

//VERSION 1
//GUID for DSBASE class factory
DEFINE_GUID(CLSID_DSBASE_1, 0x9E8D2F81, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2F81-591C-11D0-BF52-0020AF32BD64}
//GUID for DSBASE interface
DEFINE_GUID(IID_DSBASE_1, 0x9E8D2F82, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2F82-591C-11D0-BF52-0020AF32BD64}

//VERSION 2
//GUID for DSBASE class factory
DEFINE_GUID(CLSID_DSBASE_2, 0x9E8D2F91, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2F91-591C-11D0-BF52-0020AF32BD64}
//GUID for DSBASE interface
DEFINE_GUID(IID_DSBASE_2, 0x9E8D2F92, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2F92-591C-11D0-BF52-0020AF32BD64}

#define IID_DSBASE IID_DSBASE_2
#define CLSID_DSBASE CLSID_DSBASE_2

// Original version
#define PROGID_DSCURSOR_1 "Borland.DbClient_DSCursor.1"
#define PROGID_DSCURSOR_DESC_1 "Borland DbClient DSCursor 1"

// Version 2
#define PROGID_DSCURSOR_2 "Borland.DbClient_DSCursor.2"
#define PROGID_DSCURSOR_DESC_2 "Borland DbClient DSCursor 2"

// Current Version
#define PROGID_DSCURSOR "Borland.DbClient_DSCursor"
#define PROGID_DSCURSOR_DESC "Borland DbClient DSCursor Current"

//VERSION 1
//GUID for DSCursor class factory
DEFINE_GUID(CLSID_DSCURSOR_1, 0x9E8D2F83, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2F83-591C-11D0-BF52-0020AF32BD64}
//GUID for DSCursor interface
DEFINE_GUID(IID_DSCURSOR_1, 0x9E8D2F84, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2F84-591C-11D0-BF52-0020AF32BD64}

//VERSION 2
//GUID for DSCursor class factory
DEFINE_GUID(CLSID_DSCURSOR_2, 0x9E8D2F93, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2F93-591C-11D0-BF52-0020AF32BD64}
//GUID for DSCursor interface
DEFINE_GUID(IID_DSCURSOR_2, 0x9E8D2F94, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2F94-591C-11D0-BF52-0020AF32BD64}

#define IID_DSCURSOR   IID_DSCURSOR_2
#define CLSID_DSCURSOR CLSID_DSCURSOR_2

#endif

#ifndef IID_IUnknown
DEFINE_GUID(IID_IUnknown, 0x00000000, 0x0000, 0x0000, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46);
#endif

#ifndef IID_IClassFactory
DEFINE_GUID(IID_IClassFactory, 0x00000001, 0x0000, 0x0000, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46);
#endif

typedef BYTE DSAttr;
typedef DSAttr *pDSAttr;

//Defines for DS-record attributes
#define dsRecUnmodified 0x0000   // Unmodified record
#define dsRecOrg        0x0001   // Original record (was changed)
#define dsRecDeleted    0x0002   // Record was deleted
#define dsRecNew        0x0004   // Record was inserted
#define dsRecModified   0x0008   // Record was changed
#define dsUnused        0x0020   // Record not used anymore (hole)

#define dsDetUpd        0x0040   // Detail modification  Ins/Del/Mod. Can be combined with other status.

#define dsCascade       0x0080   // Cascading, combined with dsDetUpd, dsRecModified
#define dsDetInsFlyAway 0x0100   // Flyaway to inserted record

#define dsISNOTVISIBLE  (dsRecDeleted | dsRecOrg | dsUnused)
#define dsISVISIBLE    ~(dsRecDeleted | dsRecOrg |dsUnused)

//Additional fieldtypes
#define fldINT8           28
#define fldUINT8          29
#define fldBOOL8          0x1003
#define fldBOOL16         fldBOOL
#define fldBOOL32         0x1004
#define fldUNICODE        0x1007


#define fldADT            20     // Abstract datatype (structure)
#define fldARRAY          21     // Array field type
#define fldREF            22     // Reference to ADT
#define fldTABLE          23     // Nested table (reference)

// Subtypes
#define  fldstUNKNOWN  255

#ifndef fldstADTNestedTable
#define fldstADTNestedTable 35
#endif

#define fldstREFNestedTable 70

// max iUnits1 is 255, but could be preceeded by 2 bytes length (mssql varbytes)
#define MAXFIELDLEN  258
#define MAXKEYFIELDS 16

// Index descriptor
typedef UINT   DSKEY      [DBIMAXFLDSINKEY];
typedef BOOL   DSKEYBOOL  [DBIMAXFLDSINKEY];

// Filters
typedef ULONGP hDSFilter ;
typedef hDSFilter far *phDSFilter ;

typedef UINT hDSAggregate ;
typedef hDSAggregate far *phDSAggregate;


typedef INT32  DSRECNUM;  // 1-based record number. 0 and negative might have special meaning
typedef UINT32 DSSEQNUM;  // 1-base sequence number of record. 0 means undefined.

typedef enum                              // Resolver Error Category
{
      dsErrCategoryOTHER         = 0x0001,
      dsErrCategoryDATALOSS      = 0x0002,
      dsErrCategoryNOTFOUND      = 0x2200,
      dsErrCategoryINTEGRITY     = 0x2600,
      dsErrCategoryLOCKCONFLICT  = 0x2800,
      dsErrCategorySECURITY      = 0x2900,
} DSErrorCategory;

typedef enum                              // Database/Table Share type
{
      dsOPENSHARED     = 0,                 // Open shared  (Default)
      dsOPENEXCL       = 1,                 // Open exclusive
} DSShareMode;

typedef enum                              // Database/Table Access type
{
      dsREADWRITE      = 0,                 // Read + Write   (Default)
      dsREADONLY       = 1                  // Read only
} DSOpenMode;

typedef pBYTE BOOKMRK;
typedef BOOKMRK *pBOOKMRK;

typedef struct
{
   UINT     iPos;     // Position in given order
   UINT     iState;   // State of cursor
   UINT     iRecNo;   // Record number
   UINT     iSeqNo;   // Version number of order
   UINT     iOrderID; // Defines Order
} DSBOOKMRK;
typedef DSBOOKMRK *pDSBOOKMRK;

#define BOOKMARKSIZE (sizeof(DSBOOKMRK))

typedef enum {                           // Search condition for keys
      dskeySEARCHEQ       = 0,                 // =
      dskeySEARCHGT       = 1,                 // >
      dskeySEARCHGEQ      = 2,                 // >=
} DSSearchCond;

typedef enum {
      dspropLOGCHANGES       = 0,  // rw BOOL(TRUE), logs changes for undo/delta
      dspropREADONLY         = 1,  // rw BOOL(TRUE), cannot update dataset (is NOT stored with datapacket,-use AddOptParameter)
      dspropNOOFCHANGES      = 2,  // r  UINT32, number of (compressed) changes (m/i/d)
      dspropCONSTRAINTS_DISABLED = 3, // rw BOOL(TRUE), constraints are disabled (insert/modify/delete)
      dspropDSISPARTIAL      = 4,  // r BOOL(TRUE), Dataset is not yet complete (async. mode)
      dspropRECORDSINDS      = 5,  // r UINT32, number of (visible) records in dataset (independent of filters etc.)
      dspropAUTOINC_DISABLED = 6,  // rw BOOL(TRUE), autoinc disabled (created datasets only)
      dspropISDELTA          = 7,  // r BOOL   , if TRUE this is a delta
      dspropDONTINCLMETADATA = 8,  // rw BOOL , if TRUE do not inc. metadata in StreamDS
      dspropINCLBLOBSINDELTA = 9,  // rw UINT32, include blobs with lengths <= than this value in delta for 'original' record
      dspropGETSAVEPOINT     = 10, // r  SAVEPOINT, return savepoint for current update state.
      dspropCOMPRESSARRAYS   = 11, // rw BOOL(FALSE), if false expands fielddescriptors for arrays
      dspropMD_SEMANTICS     = 12, // rw UINT32(0), Master/detail semantics (See below)
      dspropFIELD_FULLNAME   = 13, // r  in: UINT32 (FieldID), out: zstring (full name)
      dspropFIELDID_FORNAME  = 14, // r  in: zstring(full name), out:UINT32 (fieldid)
      dspropFIELDID_FORPARENT= 15, // r  in: UINT32 (FieldID), out: UINT32 (FieldID)
      dspropCHANGEINDEX_VIEW = 16, // rw DSAttr (UINT32) (update attributes), any combination, 0->show all
      dspropGETUNIQUEINDEX   = 17, // r  DSIDX, internal use, returns first unique index, if any
      dspropREMOTE_UPDATEMODE= 18, // rw UINT32, 0: where all, 1: where change, 3: where key
      dspropXML_STREAMMODE   = 19,
      dspropDISABLEDELETES   = 20, // rw BOOL, 0:enable, 1:disable
      dspropDISABLEINSERTS   = 21, // rw BOOL, 0:enable, 1:disable
      dspropDISABLEEDITS     = 22, // rw BOOL, 0:enable, 1:disable
      dspropDISABLESTRINGTRIMMING=23,//rw BOOL, 0:enable, 1:disable trimming of string fields (in putfield)
      dspropDATAHASCHANGED   = 24, // rw BOOL, 0:not changed, 1:has changed since first open/reset
      dspropUTF8METADATA     = 25, // rw BOOL, 0:META data is ANSI encoding. (default) 1:UTF8 encoding.
      dspropUTF8ERRORMSG     = 26, // rw BOOL, 0:Error message is ANSI encoding. (default) 1:UTF8 encoding.
      dspropANSICODEPAGE     = 27  // rw INT32, Internal ANSI codepage.
} DSProp;

typedef enum {
      curpropCONSTRAINT_ERROR_MESSAGE    = 0,   // r pCHAR (returns POINTER to string, not string itself)
      curpropDSBASE                      = 1,   // r pDSBASE (returns POINTER to underlying DSBASE)
      curpropSETCRACK                    = 2,   // w Sets crack-value to supplied value (DBIERR_NOCURRREC)
      curpropGETORG_RECBUF               = 3,   // r returns recordbuffer for original record, error if none
      curpropFLD_MAKERW                  = 4,   // w UINT32:iFldID, Removes read-only bit from flddesc. Not persistent.
      curpropFLD_MAKEREADONLY            = 5,   // w UINT32:iFldID, Makes field read-only. Not persistent.
} CURProp;

// common field attributes. Pickle AND DSFLDDesc
#define  fldAttrHIDDEN   0x0001   // Field is hidden. Non visible through
                                  // Dataset API.
#define  fldAttrREADONLY 0x0002   // Field cann't be updated by the user
#define  fldAttrREQUIRED 0x0004   // Field value required (NULLS not allowed)

#define  fldAttrLINK     0x0008   // This is a linking field (SetID, do not show)

#define  fldAttrATTRNAME 0x0010   // If xml, store name as attribute(instead of tag)

typedef struct
{
      DBINAME        szName  ;         // Field name
      UINT           iFldType;         // Field type
      UINT           iFldSubType;      // Field subtype (if applicable)
      UINT           iUnits1 ;         // Number of Chars, precision etc
      UINT           iUnits2 ;         // Decimal places etc.
      UINT           iFldLen ;         // Length in bytes (computed)
      UINT           iFldOffsInRec;    // Offset to field  in record buffer
      UINT           iNullOffsInRec;   // Offset to null flag (1byte) in record buffer
      UINT16         iFieldID      ;   // FieldID of this field
      UINT16         iFieldIDParent;   // FieldID of parent, if any (part of ADT or ARRAY)
      BOOL           bCalculated;      // Field is calculated
      UINT           iFldAttr;         // Field attributes
      UINT           iOptParameters;   // Number of optional parameters for field
} DSFLDDesc;
typedef DSFLDDesc *pDSFLDDesc;

// Could contain 'type' of index ?
typedef struct
{
      DBINAME     szName;           // IndexName
      UINT        iFields;          // Number of fields in order (0 -> base order)
      DSKEY       iKeyFields;       // FieldNumbers
      UINT        iKeyLen;          // Total length of key (computed)
      BOOL        bUnique;          //==2 ->Primary index (only one)
      DSKEYBOOL   bDescending;      // TRUE ->Descending
      DSKEYBOOL   bCaseInsensitive; // TRUE ->Case-insensitive
} DSIDXDesc;
typedef DSIDXDesc *pDSIDXDesc;

#ifdef _UNIX
typedef struct
{
      UINT            iFields      ; // Number of columns
      UINT            iRecBufSize  ; // Size of record buffer
      UINT            iBookMarkSize; // Size of bookmark
      UINT            iIndexes     ; // Number of indexes on dataset
      UINT            iOptParams   ; // Number of optional parameters
      UINT            iLCID        ; // Language used
      UINT            iUnused[8]   ; // Reserved
      BOOL            bDelta       ; // This is a delta dataset
      BOOL            bReadOnly    ; // Dataset is not updateable
      DBIPATH         szName       ; // Name, if any
} DSProps;
#else
//TODO: Look into using pshpack1.h/poppack.h model
#if !defined(_WIN64)
#pragma pack(push, 1)
#endif //!_WIN64
typedef struct
{
      DBIPATH         szName       ; // Name, if any
      UINT32          iFields      ; // Number of columns
      UINT32          iRecBufSize  ; // Size of record buffer
      UINT32          iBookMarkSize; // Size of bookmark
      BOOL            bReadOnly    ; // Dataset is not updateable
      UINT32          iIndexes     ; // Number of indexes on dataset
      UINT32          iOptParams   ; // Number of optional parameters
      BOOL            bDelta       ; // This is a delta dataset
      UINT32          iLCID        ; // Language used
      UINT32          iUnused[8]   ; // Reserved
} DSProps;
#if !defined(_WIN64)
#pragma pack(pop)
#endif //!_WIN64
#endif //_UNIX
typedef DSProps *pDSProps;

// To be removed
typedef struct
{
   DBINAME        szDbName  ;         // Database name
   DBINAME        szDbType  ;         // Database type (NULL: Universal)
   DBINAME        szDbPassword;       // Password
   DSOpenMode     eDbOpenMode;        // Database open mode
   DBIPATH        szDbCurrentDir;     //
} DSDBDesc;
typedef DSDBDesc *pDSDBDesc;

typedef VOID (DBIFN  * pfCHANGECallBack)  // Call-back funtion pntr type
   (
      ULONGP         iClientData            // Client callback data
   );
typedef pfCHANGECallBack far *ppfCHANGECallBack;

// Filter callback
typedef BOOL (DBIFN * pfDSFilter)
   (
      ULONGP            iClientData,
      pBYTE             pRecBuf
   );

// Calculated field callback
typedef DBIResult (DBIFN * pfDSCalcField)
   (
      ULONGP           iClientData,
      pBYTE            pRecBuf      // Current record-buffer
   );


// Values for CBReconcile. Used in resolver and reconcile
#define dscbrSKIP      1    // Skip this operation (resolver : report error).
#define dscbrABORT     2    // Abort the callback session (reconcile or resolve).
                            // (resolver : undo all changes).
#define dscbrMERGE     3    // Merge the changes  (resolver : 'simple' merge)
                            // (reconcile : update original. Keep change).

// Resolving only
#define dscbrAPPLY     4    // Overwrite the current record with new values.
#define dscbrIGNORE    5    // Ignore the update request. Don't report error.

// Reconcile only
#define dscbrCORRECT   4    // Overwrite change with new values.
#define dscbrCANCEL    5    // Cancel change (remove from delta).
#define dscbrREFRESH   6    // Update original record. Cancel change.

typedef INT     dsCBRType   ;
typedef dsCBRType far *pdsCBRType;

// Reconcile-callback
typedef dsCBRType (DBIFN * pfDSReconcile)
   (
      ULONGP    iClientData,  //
      UINT      iRslt   ,     // Result of previous callback. If set, the previuos parameters are repeated.
      DSAttr    iAction ,     // Update request Insert/Modify/Delete
      dsCBRType iResponse,    // Resolver response
      UINT      iErrCode,     // Native error-code, (BDE or ..)
      pCHAR     pErrMessage,  // Native errormessage, if any (otherwise NULL)
      pCHAR     pErrContext,  // 1-level error context, if any (otherwise NULL)
      pBYTE     pRecUpd ,     // Record that failed update
      pBYTE     pRecOrg ,     // Original record, if any
      pBYTE     pRecConflict  // Conflicting error, if any
   );

// Reconcile-callback
typedef dsCBRType (DBIFN * pfDSReconcile_MD)
   (
      ULONGP    iClientData,  //
      UINT      iRslt   ,     // Result of previous callback. If set, the previuos parameters are repeated.
      DSAttr    iAction ,     // Update request Insert/Modify/Delete
      dsCBRType iErrResponse, // Resolver response
      UINT      iErrCode,     // Native error-code, (BDE or ..)
      pCHAR     pErrMessage,  // Native errormessage, if any (otherwise NULL)
      pCHAR     pErrContext,  // 1-level error context, if any (otherwise NULL)
      pBYTE     pRecUpd ,     // Record that failed update
      pBYTE     pRecOrg ,     // Original record, if any
      pBYTE     pRecConflict, // Conflicting error, if any
      UINT      iLevels,      // Number of levels to error0level
      pUINT     piFieldIDs    // Array of fieldIDS to navigate to error-dataset
   );

// Misc. alchemy error-messages
#define ERRCAT_ALC      0x40
#define ERRBASE_ALC     0x4000

#define ERRCODE_DELTAISEMPTY   1 // Delta is empty.
#define ERRCODE_NOTHINGTOUNDO  2 // Nothing to undo
#define ERRCODE_NOMETADATA     3 // Datapacket contains no meta data
#define ERRCODE_CANNOTAPPEND   4 // Trying to append data to a non-partial dataset
#define ERRCODE_DATAPACKETMISMATCH  5 // Mismatch in datapacket
#define ERRCODE_ABORTED        6  // Operation was aborted
#define ERRCODE_CANCELLED      7  // Operation was cancelled
#define ERRCODE_NEWERVERSIONREQ 8 // Newer version required
#define ERRCODE_BLOBNOTFETCHED  9 // Blob has not been fetched
#define ERRCODE_DETAILSNOTFETCHED  10  // Details has not been fetched
#define ERRCODE_NOMASTERRECORD  11     // no corresponding master record found
#define ERRCODE_LINKFIELDSNOTUNIQUE 12 // Linkfields must be unique
#define ERRCODE_FLYAWAY_WRONGORDER  13 // Special case: wrong order of updates for fly-away!
#define ERRCODE_NOCASCADEDUPDATES   14 // Cascaded updates is not enabled
#define ERRCODE_NOSUCHAGGREGATE     15 // Aggregate not found
#define ERRCODE_XMLINVALIDTYPE      16 // Fieldtype not supported for XML.
#define ERRCODE_XMLNODELAYEDFETCHING 17 //Delayed fetching not supported in xml-mode
#define ERRCODE_DELETESDISABLED     18//
#define ERRCODE_INSERTSDISABLED     19//
#define ERRCODE_EDITSDISABLED       20//

#define DBIERR_DELTAISEMPTY       (ERRBASE_ALC + ERRCODE_DELTAISEMPTY)
#define DBIERR_NOTHINGTOUNDO      (ERRBASE_ALC + ERRCODE_NOTHINGTOUNDO)
#define DBIERR_NOMETADATA         (ERRBASE_ALC + ERRCODE_NOMETADATA)
#define DBIERR_CANNOTAPPEND       (ERRBASE_ALC + ERRCODE_CANNOTAPPEND)
#define DBIERR_DATAPACKETMISMATCH (ERRBASE_ALC + ERRCODE_DATAPACKETMISMATCH)
#define DBIERR_ABORTED            (ERRBASE_ALC + ERRCODE_ABORTED)
#define DBIERR_CANCELLED          (ERRBASE_ALC + ERRCODE_CANCELLED)
#define DBIERR_NEWERVERSIONREQ    (ERRBASE_ALC + ERRCODE_NEWERVERSIONREQ)
#define DBIERR_BLOBNOTFETCHED     (ERRBASE_ALC + ERRCODE_BLOBNOTFETCHED)
#define DBIERR_DETAILSNOTFETCHED  (ERRBASE_ALC + ERRCODE_DETAILSNOTFETCHED)
#define DBIERR_NOMASTERRECORD     (ERRBASE_ALC + ERRCODE_NOMASTERRECORD)
#define DBIERR_LINKFIELDSNOTUNIQUE (ERRBASE_ALC + ERRCODE_LINKFIELDSNOTUNIQUE)
#define DBIERR_FLYAWAY_WRONGORDER (ERRBASE_ALC + ERRCODE_FLYAWAY_WRONGORDER)
#define DBIERR_NOCASCADEDUPDATES  (ERRBASE_ALC + ERRCODE_NOCASCADEDUPDATES)
#define DBIERR_NOSUCHAGGREGATE    (ERRBASE_ALC + ERRCODE_NOSUCHAGGREGATE)
#define DBIERR_XMLINVALIDTYPE     (ERRBASE_ALC + ERRCODE_XMLINVALIDTYPE)
#define DBIERR_XMLNODELAYEDFETCHING (ERRBASE_ALC + ERRCODE_XMLNODELAYEDFETCHING)
#define DBIERR_DELETESDISABLED    (ERRBASE_ALC + ERRCODE_DELETESDISABLED)
#define DBIERR_INSERTSDISABLED    (ERRBASE_ALC + ERRCODE_INSERTSDISABLED)
#define DBIERR_EDITSDISABLED      (ERRBASE_ALC + ERRCODE_EDITSDISABLED)

// 'real' NULL
#define BLANK_NULL       1
// Not changed , compared to original value
#define BLANK_NOTCHANGED 2

#define dskeyDESCENDING        0x8000
#define dskeyCASEINSENSITIVE   0x4000

typedef enum
{
  grSTATEMIDDLE    = 0, // Record is neither the first or the last in the group
  grSTATEFIRST     = 1, // Record is the first in the group
  grSTATELAST      = 2, // Record is the last in the group
  grSTATEFIRSTLAST = 3
} GROUPSTATE;

typedef enum
{
   aggSTATEUNDEF = 0,   // State is undefined. Needs recalc.
   aggSTATEOK    = 1,
   aggSTATEBLANK = 2,   // This is a blank value
   aggSTATEERROR = 3,   // An error occurred previously
} AGGSTATE;

typedef struct
{
   UINT     iCnt;       // Count of records in each
   AGGSTATE eAggState;  // State of value
#ifdef _UNIX
   BYTE       Value[1];
#else
   BYTE        Value[]; // First byte of value
#endif
} AGGVALUE;

typedef UINT SAVEPOINT;
typedef SAVEPOINT *pSAVEPOINT;

// returns -1 if pVal1 < pVal2, 0 if equal, +1 if pVal1 > pVal2
typedef INT (DBIFN  * pfFLDComp)  // Call-back funtion for field compares
   (
      ULONGP         iClientData ,  // Client callback data
      pBYTE          pVal1       ,  // Fieldvalue 1 (NULL if blank)
      pBYTE          pVal2          // Fieldvalue 2 (NULL if blank)
   );

#define FIELD_ATTR          0

#define szLINK_FIELD        "LINK_FIELD"
#define szLINK_INDEX        "LINK_INDEX"

#define   mdNONE            0x0000
#define   mdMASTER          0x0001
#define   mdDETAIL          0x0002
#define   mdMD              mdMASTER & mdDETAIL

//Master detail semantics (SetProp)
#define   mdCASCADEDEL      0x0004
#define   mdCASCADEMOD      0x0008     // Allow master link field to be changed (cascade change to details)
#define   mdALLOWLINKCHANGE 0x0010     // Allow detail linkfields to be changed (fly-away)
#define   mdALLOWORPHANS    0x0020     // Allow creation of details without a master (on fly-away only)

#define   mdMASTER_DEFAULT  mdMASTER   // Default master semntics
#define   mdDETAIL_DEFAULT  mdDETAIL | mdALLOWLINKCHANGE

#ifndef dsDELAYEDBIT                   // Also defined in dspickle.h
#define dsDELAYEDBIT 0x80000000        // Length/number is not present
#endif

#define dsPACKET_NORMAL     0x0000
#define dsPACKET_DELTA      0x0001
#define dsPACKET_ERROR      0x0002
#define dsPACKET_REQUEST    0x0004

#define dsPACKET_ALL        dsPACKET_NORMAL | dsPACKET_DELTA | dsPACKET_ERROR | dsPACKET_REQUEST
#define dsPACKET_ROUNDTRIP  dsPACKET_DELTA | dsPACKET_REQUEST


#define dsUPDMODE_ALL       0x00
#define dsUPDMODE_CHANGED   0x01
#define dsUPDMODE_KEY       0x02

#endif // ALCTYPES_H
