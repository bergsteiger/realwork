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

#ifndef ALC_DS_H
#define ALC_DS_H

#include "filter.h"
#include "varlist.h"

//special kind of index
#define szCHANGEINDEX "CHANGEINDEX"
#define szERRORTABLE  "ErrorTbl.ds"

#define ENDPOS (iCurLast  + 1)
#define BEGPOS (iCurFirst - 1)

// Variable size array of strings
// The iId is the offset into pEntries
class VARStrList : public VARList
{
public:
   UINT32 iStrings;

   VARStrList(VOID);
   ~VARStrList();

   pCHAR  DBIFN GetStrPtr(    // Returns pointer to Entry
             UINT32 iId
        );

   DBIResult DBIFN  AddStr(   // Add entry
            pCHAR   pStr,
            pUINT32 piId
        );
};

class Fields_List : public VARList
{
#if defined(_MSC_VER)
private:
//Do not use.  See midas.cpp for details.
   Fields_List(){};
   friend class DUMMYVectorDeleteGenClass;
#endif
public:
   Fields_List(UINT32 iCols);
   ~Fields_List();

   UINT32    DBIFN  Columns(VOID);
   pDSFLDDesc DBIFN GetFldDesc(UINT32 i);
};

typedef Fields_List *pFields_List;

typedef enum
{
   idxNormal = 1,
   idxChange = 2,
   idxFilter = 3,
} DSIDXType;

class DSIDX
{
protected:
   UINT32      iRecsMax;       // Maximum number of records (Size of piOrder)

   VOID        MakeSpace(UINT32 iPos, UINT32 iLen); // Utility function for insertions
   VOID        RemSpace(UINT32 iPos, UINT32 iLen);  // Utility function for deletions
   DBIResult   GrowIDX(UINT32 iInc);  // Reallocate Index/ increase capacity to pDs->iRecsMax
   DBIResult   InitIdxDesc(DSIDXDesc *pIdxDesc); // Initialize IdxDesc/fldobj's
   DBIResult   IdxSort(VOID);
   VOID        QSort(UINT32 iLeft, UINT32 iRight);
   VOID        InsSort(VOID);
   INT32       SortCmp(UINT32 iRecNo1, UINT32 iRecNo2);
   DBIResult   SortData(class DSIDX *pIdxSameOrder);

public:
   DSIDXType   iType ;         // Type of index (filt/change etc.)
   DSBASE      *pDs  ;         // Owner dataset
   BOOL        bSortIndex ;    // Temporary index
   UINT32      iRefCount  ;    // Reference count, delete object when hitting 0
   UINT32      iSeqNo;         // Sequence number to indicate version
   UINT32      iRecs;          // Number of records in index
   UINT32      iID  ;          // Indexid/orderid (set when adding index to ds)
   DSIDXDesc   IdxDesc;        // Index descriptor
   class DSIDX *pIdxNext;      // Link of Idx-objects

   pUINT32     piOrder;        // Establishes order of dataset for cursor (SeqNo to RecNo)
   class  FLDObj **ppFldObjs;  // Array of fld-objects for compares
   class  IDXGROUPINGMNG *pGroups; // Grouping manager object
   BOOL        bGlobal     ;   // Don't add setid to index, if table is detail
   UINT32      iInsertHintPos; // Hint for insertion position, in case index is not unique

   DSIDX();
   DSIDX(DSBASE *pDs);
   virtual ~DSIDX();

   INT32 DBIFN AddRef(  // Increase reference count
         VOID
         );


   INT32 DBIFN Release( // Decrease reference count
         VOID
         );

   DSSEQNUM    IdxRecNoToSeqNo(
            UINT32   iRecNo
            ); // returns sequential position of record RecNo

   INT32       IdxSeqNoToRecNo(
            UINT32   iSeqNo
            ); // Returns record number for given sequence number

   DBIResult   IdxFindKey(
            UINT32   iFields,
            UINT32   iRecNo,
            BOOL     bFirst,   //At first position if duplicates
            pUINT32  piPos
            ); // returns CLOSEST position

   DBIResult   IdxFindKey(
            UINT32   iFields,
            UINT16   iLength,
            pBYTE    pRecBuf,
            BOOL     bFirst ,  //At first position if duplicates
            pUINT32  piPos
            ); // returns CLOSEST position

   INT32       IdxComp(
            UINT32   iRecNo,
            UINT32   iFields,
            UINT32   iPos
            );

   INT32       IdxComp(
            pBYTE    pRecBuf,
            UINT32   iFields,
            UINT16   iLength,
            UINT32   iPos
            );

   DBIResult   ExtractKey(
            pBYTE    pRecBuf,
            pBYTE    pKeyBuf,
            BOOL     bFromKey
            );

   virtual DBIResult   IdxCreateOrder(
            pDSIDXDesc pIdxDesc,
            class DSIDX *pIdxSameOrder
            );

   virtual DBIResult   IdxInsert(
            UINT32   iRecNo
            );

   virtual DBIResult   IdxDelete(
            UINT32   iRecNo
            );

   virtual DBIResult   IdxModify(
            UINT32   iRecNoOld,
            UINT32   iRecNoNew
            ); // old/new record no
};

typedef DSIDX *pDSIDX;


class DSIDXCHG : public DSIDX
{
#if defined(_MSC_VER)
private:
//Do not use.  See midas.cpp for details.
   DSIDXCHG(){};
   friend class DUMMYVectorDeleteGenClass;
#endif
public:
   BOOL     bDisabled;
   DSAttr   iVisibleAttr; // Visible attributes (0->all)

   DSIDXCHG(DSBASE *pDs);
   ~DSIDXCHG();

   DBIResult   IdxCreateOrder(pDSIDXDesc pIdxDesc, class DSIDX *pIdxSameOrder);
   DBIResult   IdxInsert(UINT32 iRecNo);
   DBIResult   IdxDelete(UINT32 iRecNo);
   DBIResult   IdxModify(UINT32 iRecNo1, UINT32 iRecNo2); // old/new record no
};

typedef DSIDXCHG *pDSIDXCHG;

#define MAXFILTERS 8

class DSIDXFILT : public DSIDX
{
#if defined(_MSC_VER)
private:
//Do not use.  See midas.cpp for details.
   DSIDXFILT(){};
   friend class DUMMYVectorDeleteGenClass;
#endif
protected:
   UINT32      iRecordSize;    // Keep track of size
   pBYTE       pRecBuf    ;    // Record to be evaluated
   BOOL        RecordIsIn(UINT32 iRecNo);

public:
   DSIDXFILT(DSBASE *pDs) ;
   ~DSIDXFILT();

   class DSCONSTR *pFilt;   // Filters

   DBIResult   IdxCreateOrder(pDSIDXDesc pIdxDesc, class DSIDX *pIdxSameOrder);
   DBIResult   IdxInsert(UINT32 iRecNo);
   DBIResult   IdxDelete(UINT32 iRecNo);
   DBIResult   IdxModify(UINT32 iRecNo1, UINT32 iRecNo2); // old/new record no
   DBIResult   IdxAddFilter(pBYTE pCanExpr, UINT32 iLen, pULONGP piId);
   DBIResult   IdxAddFilter(ULONGP iClientData, pfDSFilter pfFilter, pULONGP piId);
   DBIResult   IdxRemFilter(UINT32 iId);
};

typedef DSIDXFILT *pDSIDXFILT;

typedef struct
{
   UINT32 iRecNo1;
   UINT32 iRecNo2;
   UINT32 iAttr  ; // DSAttr iAttr;
   //iSeqNo
} LOGENTRY;
typedef LOGENTRY *pLOGENTRY;

// Maintains log of sequence of changes
class DSLOG
{
   UINT32      iSize;
   pDSBASE     pDs;                     // Could be NULL
   DBIResult   GrowLog(UINT32 iEntries); // Grow size of log

public:
   UINT32      iLast; // Number of entries
   LOGENTRY   *pLogEntries;
   class SAVEPOINTList *pSavePoints; // Maintained savepoints

   DSLOG(UINT32 iSize, pDSBASE pDs);
   ~DSLOG();

   //Log entries
   DBIResult   AddToLog(UINT32 iRecNo, UINT32 iRecNo2, DSAttr iAttr, UINT32 iExtended);
   DBIResult   RemFromLog(VOID);          // remove top-most item
   DBIResult   GetLogEntry(pUINT32 piRecNo1, pUINT32 piRecNo2, pDSAttr piAttr);

   // Creates a compacted version of the log (no unnescessary entries)
   DBIResult   CompactLog(DSLOG *pLogNew);

   // Remove entry, adjusts iLast   (0-based)
   DBIResult   RemoveEntry(UINT32 iEntry);

   // Removes any action related to iRecNo (iRecNo is the final record used in
   // the delta after a CompactLog)
   DBIResult   RemoveAction(DSAttr iAttr, UINT32 iRecNo, pUINT32 piCnt, pUINT32 piRecNo, pUINT32 piLogPos);

   //Returns RecNo of previous version of 'iRecno'
   UINT32      GetPrevRecNo(UINT32 iRecNo);

   DBIResult   GetSavePoint(pUINT32 piSavePoint);

   UINT32      GetOrgUpd(UINT32 iRecNo, pUINT32 piRecNoOrg);

   DBIResult   MoveEntry(UINT32 iNoFrom, UINT32 iNoTo);
};

#define BLOBID UINT32

typedef struct
{
   UINT32  iBlobLen;
   pBYTE   pBlob   ;
} BLOBEntry;
typedef BLOBEntry *pBLOBEntry;

// 8Kbytes for each leaf.
#define BLOBLEAFSIZE (8192 / sizeof(BLOBEntry))
typedef BLOBEntry *pBLOBEntryLeaf, **ppBLOBEntryLeaf;

class BLOBIDList
{
private:
   UINT32      iLeafSize;
   ppBLOBEntryLeaf ppBlobEntryLeaves;

   BLOBEntry& getBlobEntry(UINT32 index);
public:
   BLOBIDList();
   ~BLOBIDList();

   UINT32      iLast; // Number of entries
   UINT32      iSize;

   DBIResult Ensure(UINT32 iEnsureSize);
   DBIResult Grow(UINT32 iEntries); //Grow size of log
   VOID Reset(VOID);

   inline BLOBEntry& operator[](UINT32 index)
     { return getBlobEntry(index); };
};

// Maintains blob handles
class DSBLOBS
{
   UINT32      iLastCommitted; // Last comiited blob (<=iLast). Release() will release all
                              // Blobs between this number and iLast, if any

protected:
   BLOBIDList  pBlobEntries;

public:
   DSBLOBS();
   ~DSBLOBS();

   // Adds a blob, returns a blobhandle
   DBIResult   AddBlob(pBYTE pBlob, UINT32 iBlobLen, pUINT32 piBlobId);
   DBIResult   GetBlobLen(UINT32 iBlobId, pUINT32 piLen);
   DBIResult   GetBlob(UINT32 iBlobId, UINT32 iOffset, pBYTE pBlob, pUINT32 piLength); // Copies blob to buffer
   DBIResult   GetBlobInfo(UINT32 iBlobId, pUINT32 piLen, ppBYTE ppBlob); //Returns pointer and length
   DBIResult   UpdBlob(pBYTE pBlob, UINT32 iOffset, UINT32 iBlobLen, UINT32 iBlobId);

   // Check if blob changed , TRUE if same contents
   BOOL        BlobIsSame(UINT32 iBlobLen, pBYTE pBlob, UINT32 iBlobId);
   VOID        Reset(VOID);   // Remove blobs
   VOID        Commit(VOID);  // Commit all blobs
   VOID        Release(UINT32 iBlobId); // Release all uncomitted blobs, or 'iBlobId'
};

typedef struct
{
   UINT32   iId      ;
   pBYTE    pCanExpr ;
   UINT32   iLen     ;
   ULONGP   hCanConstraints;  // CanExpr Compiled Constraint handle
   ULONGP   iClientData;
   pfDSFilter  pfFilter;
   FLTArgType  eFltType;
   UINT32   iFldNo;           // For fielddomain/default values
} CONSTREntry;
typedef CONSTREntry *pCONSTREntry;

// Maintains constraints/filters
class DSCONSTR
{
   DSBASE     *pDs;
   UINT32      iIds ;               // Create Id's
   UINT32      iSize;               // Capacity, number of entries
   DBIResult   Grow(UINT32 iEntries);// Grow size
   pBYTE       pRecBuf;             // Aux-recbuffer

public:
   DBIMSG      szErrMsg;

   UINT32      iLast;               // Number of entries
   pCONSTREntry  pEntries;

   DSCONSTR(class DSBASE *pDs);
   ~DSCONSTR();

   // Adds a blob, returns a blobhandle
   DBIResult   Add(pBYTE pCanExpr, UINT32 iLen, FLTArgType  fltType, pULONGP piId);
   DBIResult   Add(ULONGP iClientData, pfDSFilter pfFilter, pULONGP piId);
   DBIResult   Remove(UINT32 iId); // Remove filter
   BOOL        Evaluate(pBYTE pRecBuf); // TRUE if within filter
   BOOL        Evaluate(UINT32 iFldNo, pBYTE pFld); // TRUE if within filter
   DBIResult   Recompile(); // After change (AddField)
   DBIResult   GetDefaults(pBYTE pRecbuf);
};

typedef struct
{
   UINT32      iId;
   pBYTE       pCanExpr;
   UINT32      iLen;
   class       QAggregate *pAgg;
   DSFLDDesc   DsFldDesc;
} AGGEntry;
typedef AGGEntry *pAGGEntry;


// Maintains constraints/filters
class DSAGGS
{
   DSBASE     *pDs;
   UINT32      iIds ;               // Create Id's
   UINT32      iSize;               // Capacity, number of entries
   DBIResult   Grow(INT32 iEntries);//Grow size of log

public:
   UINT32      iLast; // Number of entries
   pAGGEntry   pEntries;

   DSAGGS(class DSBASE *pDs);
   ~DSAGGS();

   DBIResult   Add(pBYTE pCanExpr, UINT32 iLen, pDSFLDDesc pDsFldDesc, pUINT32 piId); // Add aggregate
   DBIResult   Remove(UINT32 iId);                             // Remove aggregate
   DBIResult   GetValue(UINT32 iId, pBYTE pValue);
   DBIResult   Evaluate(pBYTE pRecBuf, BOOL bAdd);     // Update all aggregates
   DBIResult   Reset();     // Reset all aggregates
   DBIResult   Recompile(); // After change (AddField) // Recreate all QAggregates
};

typedef struct
{
   UINT32  iPacketTypes; //Packettypes this parameter should be transferred to (when cloning)
   UINT32  iFldNo;
   UINT32  iType;
   UINT32  iLen;
   pCHAR   pAttr;
   pBYTE   pValue;
} OPTPARAMEntry;
typedef OPTPARAMEntry *pOPTPARAMEntry;

// Maintains constraints/filters
class DSOPTPARAM
{
   DSBASE     *pDs;
   UINT32      iSize; // Capacity, number of entries
   DBIResult   Grow(UINT32 iEntries); //Grow size of log

public:
   UINT32      iLast; // Number of entries
   pOPTPARAMEntry  pEntries;

   DSOPTPARAM(class DSBASE *pDs);
   ~DSOPTPARAM();

   // Adds a blob, returns a blobhandle
   DBIResult   Add(UINT32 iPacketTypes, UINT32 iFldNo, UINT32 iType, UINT32 iLen, pCCHAR pAttr, pBYTE pValue);
   DBIResult   Drop(UINT32 iEntry);
};

class FLDObj
{
public:
   UINT32     iFldType;
   UINT32     iLen;
   BOOL       bDescending;

   FLDObj();
   FLDObj(pDSFLDDesc pFldDes, BOOL bDescending);
   ~FLDObj();

   virtual   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   virtual   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDInt8 : public FLDObj
{
public:
   FLDInt8();
   FLDInt8(pDSFLDDesc pFldDes, BOOL bDescending);

   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDInt16 : public FLDObj
{
public:
   FLDInt16();
   FLDInt16(pDSFLDDesc pFldDes, BOOL bDescending);

   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDInt32 : public FLDObj
{
public:
   FLDInt32();
   FLDInt32(pDSFLDDesc pFldDes, BOOL bDescending);

   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDInt64 : public FLDObj
{
public:
   FLDInt64();
   FLDInt64(pDSFLDDesc pFldDes, BOOL bDescending);

   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDUInt8 : public FLDInt8
{
public:
   FLDUInt8(pDSFLDDesc pFldDes, BOOL bDescending);
   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
};

class FLDUInt16 : public FLDInt16
{
public:
   FLDUInt16(pDSFLDDesc pFldDes, BOOL bDescending);
   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
};

class FLDUInt32 : public FLDInt32
{
public:
   FLDUInt32(pDSFLDDesc pFldDes, BOOL bDescending);
   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
};

class FLDUInt64 : public FLDInt64
{
public:
   FLDUInt64(pDSFLDDesc pFldDes, BOOL bDescending);
   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
};


class FLDString : FLDObj
{
public:
   BOOL   bCaseInsensitive;
   UINT32 iLCID;

   FLDString(pDSFLDDesc pFldDes, BOOL bDescending, UINT32 iLCId);

   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDUniCode : FLDObj
{
public:
   BOOL   bCaseInsensitive;
   UINT32 iLCID;

   FLDUniCode(pDSFLDDesc pFldDes, BOOL bDescending, UINT32 iLCId);

   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDTimeStamp: FLDObj
{
public:
   FLDTimeStamp(pDSFLDDesc pFldDes, BOOL bDescending);
   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDTimeStampOffset: FLDObj
{
public:
   FLDTimeStampOffset(pDSFLDDesc pFldDes, BOOL bDescending);
   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDSingle: FLDObj
{
public:
   FLDSingle(pDSFLDDesc pFldDes, BOOL bDescending);

   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDFloat: FLDObj
{
public:
   FLDFloat(pDSFLDDesc pFldDes, BOOL bDescending);

   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDBcd: FLDObj
{
public:
   UINT32 iUnits1;
   UINT32 iUnits2;

   FLDBcd(pDSFLDDesc pFldDes, BOOL bDescending);

   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDVarBytes: FLDObj
{
public:
   UINT32 iUnits1;
   UINT32 iUnits2;

   FLDVarBytes(pDSFLDDesc pFldDes, BOOL bDescending);

   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDBlob: FLDObj
{
public:
   UINT32 iUnits1;
   UINT32 iUnits2;

   FLDBlob(pDSFLDDesc pFldDes, BOOL bDescending);

   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDExtended: FLDObj
{
public:
   UINT32      iUnits1;
   UINT32      iUnits2;
   pfFLDComp   pfComp;
   ULONGP      iClientData;

   FLDExtended(pDSFLDDesc pFldDes, BOOL bDescending, pfFLDComp pfComp, ULONGP iClientData);

   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

class FLDComposite: FLDObj
{
public:
   UINT32 iUnits1;
   UINT32 iUnits2;

   FLDComposite(pDSFLDDesc pFldDes, BOOL bDescending);

   INT32     FldComp(pBYTE pVal1, pBYTE pVal2);
   DBIResult FldMove(pBYTE pVal1, pBYTE pVal2);
};

typedef struct
{
   ULONGP  iId;
   pfCHANGECallBack  pfCallBack;
} CALLBACKEntry;
typedef CALLBACKEntry *pCALLBACKEntry;

// Maintains constraints/filters
class DSCALLBACK
{
   UINT32      iSize;               // Capacity, number of entries
   DBIResult   Grow(UINT32 iEntries);// Grow size of log

public:
   UINT32      iLast;               // Number of entries
   pCALLBACKEntry    pEntries;

   DSCALLBACK();
   ~DSCALLBACK();

   DBIResult   Add(ULONGP iId, pfCHANGECallBack pfCallBack);
   DBIResult   Remove(ULONGP iId);  // Remove CallBack
   VOID        Notify(VOID);        // Call all 'Notify'-callbacks
};

BOOL DBIFN SameIdxDesc(DSIDXDesc *pD1, DSIDXDesc *pD2, BOOL bLessFldsOk, BOOL bIgnUnique);

DBIResult DBIFN FldMoveNormalizeBCD(pFMTBcd pVal1, pFMTBcd pVal2, UINT32 iPrecision, UINT32 iScale);

// Manages aggregates (for a given grouping ?)
class AGGSMNG
{
   DSBASE     *pDs;
   UINT32      iSize;                  // Capacity, number of entries
   DBIResult   Grow(UINT32 iEntries);   // Grow size
   class AGGS *GetEntry(UINT32 iAggId);// Return Aggs-object, if any
public:
   UINT32      iLast;                  // Number of filled entries
   UINT32      iAggs;                  // Number of Aggs
   class AGGS **pEntries;

   AGGSMNG(class DSBASE *pDs);
   ~AGGSMNG();

   DBIResult   Reset(VOID); // Reset, recompute all

   DBIResult   Clone(
    AGGSMNG   **ppAggsMng  // Return clone of whole object
         );

   DBIResult   Add(     // Add aggregate
         UINT32     iCanLen,
    pBYTE       pCanExpr,
         pUINT32    piAggId  // Returns handle
         );

   DBIResult   Drop(  // Remove aggregate
       UINT32     iAggId
         );

   DBIResult   GetAggDesc( // Returns field-desc of agg-value
    UINT32     iAggId,
         pDSFLDDesc pFld
         );

   DBIResult   GetAggValue(   // Returns agg-value and state
    UINT32  iAggId,
         UINT32  iSubGroupId,
         pBYTE   pValue,      // returns agg-value, if any (see state)
         pBOOL   pbBlank,
         pUINT32 piState,     // returns state of agg-value, if undefined, must be recalculated using 'AddAggValue'
         pUINT32 piCnt        // returns count of records in agg-value
         );

   DBIResult   ResetAggValue( // Reset agg-value
         UINT32  iAggId,       // If 0, reset all agg-values for iSubGroup
         UINT32  iSubGroupId   // If 0, reset all agg-values for iAggId
         );

   DBIResult   AddAggValue(   // Add contribution from inserted record
       UINT32  iAggId,      // If 0, update all aggs
         UINT32  iSubGroupId,
         pBYTE   pRecBuf
         );

   DBIResult   SubAggValue(   // Remove contribution from deleted record
       UINT32  iAggId,      // If 0, update all aggs
         UINT32  iSubGroupId,
         pBYTE   pRecBuf
         );

   DBIResult   UpdAggValue(   // Update contribution from a changed record
       UINT32  iAggId,      // If 0, update all aggs
         UINT32  iSubGroupId,
         pBYTE   pRecBufRem ,
         pBYTE   pRecBufAdd
         );

   DBIResult   Recompile();   // After change (AddField) // Recreate all QAggregates
};

class AGGS  // Aggregate
{
   DSBASE     *pDs      ;
   UINT32      iSize    ;    // Capacity, number of elements in pValue,pCnt, pStates arrays
   UINT32      iEntries ;    // Corresponds to iSize
   DBIResult   Grow(UINT32 iInc); //Grow size of pValues
   UINT32      iAggEntryLen; // Length of each entry
   AGGVALUE   *GetEntry(UINT32 iSubGroupId);

public:
   UINT32      iCanLen  ;   // Length of can-expression (so it can be duplicated).
   pBYTE       pCanExpr ;   // Expression on record buffer
   class  QAggregate  *pAggObj; // Aggregate object
   DSFLDDesc   AggFieldDesc;   // Typedesc for aggregate value
   AGGVALUE   *pAggValues;  // Array of agg-values, each DsFlddesc.iLen long

   AGGS();
   ~AGGS();

   DBIResult   Clone(
            AGGS **ppAgg
            );

   DBIResult InitAgg(
            DSBASE     *pDs      , // Base Ds
            UINT32      iCanLen  ,
            pBYTE       pCanExpr ,
          UINT32     InitialSize  // Number of subgroupids
            );

   DBIResult   GetAggValue(   // Returns agg-value and state
       UINT32  iSubGroupId,
          pBYTE   pValue,      // returns agg-value, if any (see state)
            pBOOL   pbBlank,
             pUINT32 piState,     // returns state of agg-value, if undefined, must be recalculated using 'AddAggValue'
            pUINT32 piCnt        // returns count of records in agg-value
       );

   DBIResult   ResetAggValue( // Reset agg-value
       UINT32 iSubGroupId   // If 0, reset all agg-values for iAggId
       );

   DBIResult   AddAggValue(   // Add contribution from inserted record
       UINT32 iSubGroupId,
          pBYTE  pRecBuf
       );

   DBIResult   SubAggValue( // Remove contribution from deleted record
       UINT32 iSubGroupId,
       pBYTE  pRecBuf
       );

   DBIResult   UpdAggValue( // Update contribution from a changed record
       UINT32 iSubGroupId,
       pBYTE  pRecBufRem ,
       pBYTE  pRecBufAdd
       );

   DBIResult   Reset(VOID);
};

// GroupId is number of fields in grouping. 0 means none. 17 is max. number of groupings.
#define MAXGROUPINGS MAXKEYFIELDS +1
#define ISVALIDGROUPID(iGroupId) (iGroupId <= MAXGROUPINGS)

class IDXGROUPINGMNG
{
   UINT32  iGroups; // Number of groupings defined
   DSIDX   *pIdx  ; // Associated index
   class IDXGROUPING *pGroupings[MAXGROUPINGS]; // Array of grouping-objects
                                    // GroupingId is index in Array, 0..MAXKEYFIELDS
   pBYTE   pRecBuf1; //Aux buffers for aggregates
   pBYTE   pRecBuf2;

   IDXGROUPING * DBIFN GetGroupObj( // Return group-object for given hAgg
       hDSAggregate hAgg
         );

   DBIResult DBIFN AllocRecBuffs();

 public:
   IDXGROUPINGMNG(DSIDX *pIdx);
   ~IDXGROUPINGMNG();

   DBIResult DBIFN Clone(       // Clone whole thing (preserve handles too!)
         DSIDX *pIdx2   , // NULL : same index
       class IDXGROUPINGMNG **ppGMng
         );

   IDXGROUPING * DBIFN GetGrouping( // Return object for GroupId, if defined
       UINT32   iFields   // GroupId, 0..MAXKEYFIELDS
         );

   DBIResult DBIFN AddAggs(// Create aggregates with given grouping
         UINT32   iFields ,    // Defines grouping
         UINT32   iCanLen ,
         pBYTE    pCanExpr,
    phDSAggregate  phAgg
         );

   DBIResult DBIFN DropAggs(
         hDSAggregate hAgg
         );

    DBIResult DBIFN GetAggValue(
    hDSAggregate hAgg,
         UINT32       iPos ,
         pBYTE        pValue,
         pBOOL       pbBlank
         );

   DBIResult DBIFN GetAggDesc(
       hDSAggregate hAgg,
         pDSFLDDesc   pFldDesc
         );

   DBIResult DBIFN Insert( // Maintain aggregates after an insert
         UINT32   iPos1    // Position in pIdx->piOrder of affected record
         );

   DBIResult DBIFN Delete( // Maintain aggregates after an delete
         UINT32   iPos1    // Position in pIdx->piOrder of affected record
         );

   DBIResult DBIFN Modify( // Maintain aggregates after an modify
         UINT32   iPos1  , // Position in pIdx->piOrder of affected record
         UINT32   iPos2
         );

  DBIResult DBIFN NextSubGroup( // Move to first record in next subgroup, if any
         UINT32   iFields, // Subgroup
         UINT32   iPos,    // Current Position
         pUINT32  piPos    // Return position of first record in next subgroup
         );

  DBIResult DBIFN GetSubGroupState( //
    UINT32    iFields,
         UINT32     iPos   ,
         GROUPSTATE *piState
         );

  DBIResult DBIFN Reset(VOID);

};

// Manages a particular grouping of records on the associated index.
// Each grouping can have one ore more aggregates associated with it.
// A grouping consists of one or more 'subgroups', which each contains a number
// of 'aggregate results' (one for each aggregate for the grouping).
class IDXGROUPING
{
   UINT32      iSizeSBG;    // Capacity, number of entries
   AGGSMNG    *pAggsMng;    // Aggregate manager for grouping
   pUINT32     piSBG;       // Gives relation between index-pos and subgroupid
   DBIResult   GrowSBG(UINT32 iInc);      // Grows piSBG
   VOID         MakeSpaceSBG(UINT32 iPos, UINT32 iLen); // Make space for new entry here
   VOID        RemSpaceSBG(UINT32  iPos, UINT32 iLen); // Remove this entry

   BOOL  DBIFN  InSameSubGroup( // Returns TRUE if the two records are part of the same subgrouping
    UINT32     iPos1,
         UINT32     iPos2
         );

   DBIResult DBIFN RangeOfSubGroup( // Determines first position for subgroup, and number of elements
         UINT32     iPosCurrent,    // Current position
         pUINT32    piPosFirst ,    // First position for subgroup of iPosCurrent
         pUINT32    piCnt           // Number of elements
         );

 public:
   pDSIDX      pIdx;        // Associated index
   UINT32      iUseCount;   // Number of times defined
   UINT32      iFields;     // Grouping on first 'iFields' fields of the index.

   UINT32      iSubGroupCnt;// Create Id's. Monotonely increasing value.

   IDXGROUPING(
       DSIDX    *pIdx,    //Associate with this index
       UINT32    iFields  // Grouping defined on these fields
         );

   ~IDXGROUPING();

   DBIResult DBIFN  Initialize( // Scan pIdx->piOrder
         );   // Create all new subid's

   DBIResult DBIFN  Clone(
             DSIDX *pIdx2   , // NULL : same index
           IDXGROUPING    **ppGr
         );

   DBIResult DBIFN AddAggs(// Create aggregates with given grouping
         UINT32         iCanLen ,
         pBYTE          pCanExpr,
       phDSAggregate  phAgg
         );

   DBIResult DBIFN DropAggs(    // Remove aggregate
         hDSAggregate   hAgg
         );

   DBIResult DBIFN  GetAggValue(
         hDSAggregate   hAgg,
         UINT32      iPos,
         pBYTE    pValue,
         pBOOL          pbBlank
         );

   DBIResult DBIFN  GetAggDesc(
         hDSAggregate   hAgg,
         pDSFLDDesc     pDesc
         );

   //Maintain aggs/groupings
   DBIResult DBIFN  Insert(
         UINT32      iPos1,
         pBYTE       pRecBuf
         );

   DBIResult DBIFN  Delete(
         UINT32      iPos1,
         pBYTE       pRecBuf
         );

   DBIResult DBIFN  Modify(
         UINT32      iPos1,
         UINT32      iPos2,
         pBYTE       pRecBuf1,
         pBYTE       pRecBuf2
         );

   DBIResult DBIFN NextSubGroup( // Move to first record in next subgroup, if any
         UINT32      iPos,          // Current Position
         pUINT32     piPos          // Return position of first record in next subgroup
         );


  DBIResult DBIFN GetSubGroupState( //
         UINT32      iPos   ,
         GROUPSTATE *piState
         );


   DBIResult  DBIFN Reset();     // Reset all aggregates
};

typedef struct
{
   DSBASE *pDsDet;
   pVOID  phCurDet;        // Cursor for detail (set in LinkCursors()
   UINT32 iFieldID_SetIDM; // FieldID for SetID in master
   UINT32 iFields;
   DBIKEY iFieldIDM;       // FieldIDs for foreignkey in master (if any)
   UINT32 iSetIDCnt;       // Generates SetID's
   UINT32 piRecNosSize;    // Size of array
   pUINT32 piRecNos  ;     // Temp. returns recordnos for given setid
   DBINAME szIdxName ;     // Name of link-index to enforce unique-masterlinks, if any
   // field list in master, if softlinked
} LTABLEEntry;
typedef LTABLEEntry *pLTABLEEntry;

class LTABLEList : public VARList
{
   DSBASE * pDs;
#if defined(_MSC_VER)
private:
//Do not use.  See midas.cpp for details.
   LTABLEList(){};
   friend class DUMMYVectorDeleteGenClass;
#endif
public:
   LTABLEList(DSBASE * pDs);
   ~LTABLEList();
   pLTABLEEntry DBIFN GetEntry(UINT32 iId);  // Returns Entry
   pLTABLEEntry DBIFN Find(UINT32 iFieldID); // Returns Entry for nested table on given field
   DSBASE *DBIFN FindDs(UINT32 iFieldID)   ; // Returns Ds for nested table on given field
   DBIResult DBIFN Link_Fields(DSBASE *pDsDet, UINT32 iFields, pUINT32 piFieldIDs_M, pUINT32 pFieldIDs_D,  pUINT32 pDetID);
   DBIResult DBIFN Link(DSBASE *pDsDet, UINT32 iFieldID_SetIDM, UINT32 iFieldID_SetIDD, pUINT32 pDetID);
   UINT32 DBIFN GetTotalFieldDesc(BOOL bCompressed); // Compute total number of fielddescs for all detail tables.
   DBIResult DBIFN AdjustFieldIDs(VOID);
   DBIResult DBIFN GetMasterLinkIndex(UINT32 iDetID, BOOL bCreate, BOOL bUnique, pDSIDX *ppIdx);
   DBIResult DBIFN GetNewMasterForDetail(UINT32 iDetID, pBYTE pRecBufD, pUINT32  piRecNo, pUINT32 piSetID);
};

typedef struct
{
  UINT32 iSeqNo;
  UINT32 iLogPos;       // Index in dslog
  UINT32 iUseCount;
} SAVEPOINTEntry;
typedef SAVEPOINTEntry *pSAVEPOINTEntry;

class SAVEPOINTList : public VARList
{
   UINT32 iGenSeqNos;   // Generates sequence numbers
public:
   SAVEPOINTList(VOID);
   ~SAVEPOINTList(VOID);

   DBIResult DBIFN MakeSavePoint( //Creates new savepoint, given
            UINT32 iPos,
            pUINT32 piSavePoint
         );
   VOID      DBIFN ReleaseSavePoint(UINT32 iSavePoint);

   pSAVEPOINTEntry DBIFN GetSavePointEntry(
            UINT32 iSavePoint
        );
   INT32 DBIFN GetSavePointPos(
            UINT32 iSavePoint  // Returns pos, given savepoint, -1 if invalid
        );
   DBIResult DBIFN AdjustSavePoints(
            UINT32 iPos,
            INT32 iInc      // Inc/Dec positions. If 0, invalidates all savepoints above iPos
        );
   DBIResult DBIFN IncSeq();
};

//Prototypes
DBIResult DBIFN GetByteBuffer(UINT32 iSize, pBYTE *ppBuf, BOOL bZero);

//request for fetching blobs details
typedef struct
{
   DSBASE  *pDs       ;    // DSBase for this level
   UINT32   iRowNo    ;    // Rowno in this
   UINT32   iFieldID  ;    // Descent down this tree
   UINT32   iFields   ;    // Number of unique keyfields in array, if 0, include all base types
   DBIKEY   piKeys    ;
   INT32    iFetchBlobs;   // -1: all on this record, otherwise fieldID
   INT32    iFetchDetails; // -1: all on this record, otherwise fieldID
} ROWREQ;

typedef ROWREQ *pROWREQ;

#endif
