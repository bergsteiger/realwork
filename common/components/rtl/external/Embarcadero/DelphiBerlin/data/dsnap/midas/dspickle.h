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

#ifndef PICKLE_H
#define PICKLE_H

#ifdef __cplusplus
    extern "C" {
#endif // __cplusplus


#ifndef OSSRV_H
#include "ossrv.h"
#endif

#ifdef _UNIX
  #ifndef REFIID
  #ifndef HRESULT
      #define HRESULT int
  #endif
  #define S_FALSE  0x00000001
  #define CLASS_E_CLASSNOTAVAILABLE    0x80040111
  #define CLASS_E_NOAGGREGATION        0x80040110
  #define SELFREG_E_CLASS              0x00040201   
     struct GUID
     {
     UINT32 p1;
     UINT16 p2;
     UINT16 p3;
     BYTE p4[8];
     };
     #define REFIID GUID
     #define REFCLSID GUID
     #ifdef DSPICKLE_H
     #define DEFINE_GUID( name, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8 ) extern const GUID name = { l, w1, w2, { b1, b2, b3, b4, b5, b6, b7, b8 } }
     #else
     #define DEFINE_GUID( name, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8 ) extern const GUID name;
     #endif
     #if __GNUC__
       #define COMINTF
     #else
       #define COMINTF __attribute__ ((com_interface))
     #endif
     class IUnknown
     {
        public:
        INT32 QueryInterface( const GUID guid, pVOID * ppv );
        private:
        INT32 _AddRef( void );
        INT32 _Release( void );
     } COMINTF;
     class IClassFactory : IUnknown
     {
       public:
       INT32 CreateInstance( IUnknown * pUnkOuter, REFIID riid, pVOID * ppObj );
       INT32 LockServer( BOOL bLock );
     } COMINTF;
  #endif
  #define NOERROR         0
  #define E_NOINTERFACE   1
  #define HINSTANCE      UINT32
  #define HINSTANCE_ERROR 99
  INT32 LoadString( HINSTANCE hDll, UINT32 iErrCode, pCHAR pResBuffer, INT32 iMaxLen );
#else  // Windows
  ULONGP GetResourceModuleHandle(pCCHAR lpModuleName);
  INT32 LoadStringUTF8( HINSTANCE hDll, UINT32 iErrCode, pCHAR pResBuffer, INT32 iMaxLen );
#endif // #ifdef _UNIX

#ifdef MIDAS_DLL

#define PROGID_MDATAPACKETWRITE "Borland.Midas_DatapacketWrite.1"
#define PROGID_MDATAPACKETWRITE_DESC "Borland Midas DatapacketWrite"

//GUID for DATAPACKET_WRITE class factory
DEFINE_GUID(CLSID_MDATAPACKETWRITE, 0x9E8D2FA5, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2FA5-591C-11D0-BF52-0020AF32BD64}

//GUID for DATAPACKET_WRITE interface
DEFINE_GUID(IID_MDATAPACKETWRITE, 0x9E8D2FA6, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2FA6-591C-11D0-BF52-0020AF32BD64}

#define PROGID_MDATAPACKETREAD "Borland.Midas_DatapacketRead.1"
#define PROGID_MDATAPACKETREAD_DESC "Borland Midas DatapacketRead"

//GUID for DATAPACKET_READ class factory
DEFINE_GUID(CLSID_MDATAPACKETREAD, 0x9E8D2FA7, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2FA7-591C-11D0-BF52-0020AF32BD64}

//GUID for DATAPACKET_READ interface
DEFINE_GUID(IID_MDATAPACKETREAD, 0x9E8D2FA8, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2FA8-591C-11D0-BF52-0020AF32BD64}

#else

#define PROGID_DATAPACKETWRITE "Borland.DbClient_DatapacketWrite.1"
#define PROGID_DATAPACKETWRITE_DESC "Borland DbClient DatapacketWrite"

//GUID for DATAPACKET_WRITE class factory
DEFINE_GUID(CLSID_DATAPACKETWRITE, 0x9E8D2F85, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2F85-591C-11D0-BF52-0020AF32BD64}

//GUID for DATAPACKET_WRITE interface
DEFINE_GUID(IID_DATAPACKETWRITE, 0x9E8D2F86, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2F86-591C-11D0-BF52-0020AF32BD64}

#define PROGID_DATAPACKETREAD "Borland.DbClient_DatapacketRead.1"
#define PROGID_DATAPACKETREAD_DESC "Borland DbClient DatapacketRead"

//GUID for DATAPACKET_READ class factory
DEFINE_GUID(CLSID_DATAPACKETREAD, 0x9E8D2F87, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2F87-591C-11D0-BF52-0020AF32BD64}

//GUID for DATAPACKET_READ interface
DEFINE_GUID(IID_DATAPACKETREAD, 0x9E8D2F88, 0x591c, 0x11D0, 0xBF, 0x52, 0x00, 0x20, 0xAF, 0x32, 0xBD, 0x64);
//{9E8D2F88-591C-11D0-BF52-0020AF32BD64}

#endif

#define  DSPCKLINITSIZE          32 * 1024  // Default datapacket block size.
#define  DSPCKLBLOBBLKSIZE       4 * 1024   // Default blob block size.
#define  DSMAXATTRNAMELEN        255        // Maximum attribute name len.

#define dsfldUNKNOWN      0                 // Unknown
#define dsfldINT          1                 // signed integer
#define dsfldUINT         2                 // Unsigned integer
#define dsfldBOOL         3                 // Boolean
#define dsfldFLOATIEEE    4                 // IEEE float
#define dsfldBCD          5                 // BCD
#define dsfldDATE         6                 // Date     (32 bit)
#define dsfldTIME         7                 // Time     (32 bit)
#define dsfldTIMESTAMP    8                 // Time-stamp  (64 bit)
#define dsfldZSTRING      9                 // Multi-byte string
#define dsfldUNICODE      10                // unicode string
#define dsfldBYTES        11                // bytes

#define dsfldVERSION_1    11                // Fldtypes suported in version 1 (MAX_PICKLEVERSION == 1)

#define dsfldADT          12                // ADT (Abstract Data Type)
#define dsfldARRAY        13                // Array type (not attribute)
#define dsfldEMBEDDEDTBL  14                // Embedded (nested table type)
#define dsfldREF          15
#define dsfldBIGDECIMAL   16                // Java big decimals (variable length)

#define dsfldVERSION_2    16                // Fldtypes suported in version 2 (MAX_PICKLEVERSION == 2)

#define dsfldDATETIME     17                // DATE TIME
#define dsfldFMTBCD       18                // BCD Variant

#define dsfldSINGLE       27                // 32 bit floating point
#define dsfldDATETIMEOFFSET 36              // DATE TIME OFFSET

#define dsfldVERSION_3    18                // Fldtypes suported in version 3 (MAX_PICKLEVERSION == 3)

#define dsfldVERSION_4    36                // Fldtypes suported in version 4 (MAX_PICKLEVERSION == 4)


#define dsSizeBitsLen     16                // no. bits indicating fld size
#define dsSizeBitsMask     0x0000FFFF       // mask to retrieve fld size
#define dsTypeBitsMask     0x003F0000       // mask to retrieve Type info
#define dsVaryingFldType   0x00400000       // Varying attribute type.
#define dsArrayFldType     0x00800000       // Array attribute type.

#define dsPseudoFldType    0x01000000       // Composite. Bits 1..15 gives number of elements
#define dsCompArrayFldType 0x02000000       // Compressed array
#define dsEmbeddedFldType  0x04000000       // Embedded table
#define dsIncInDelta       0x80000000       // For optional parameters only:include parameter in delta

class FLDConv
{
public:
   class DSXML_W *pDsXml;
   pCCHAR     pXmlType;
   UINT32    iLen;
   pCCHAR     pNamePtr; // Ptr to name
   FLDConv();

   virtual ~FLDConv();

   virtual   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   virtual   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCVar8 : public FLDConv
{
public:
   BOOL      bConvert;

   FLDCVar8();
   FLDCVar8(BOOL bConvert);
   ~FLDCVar8();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank); //Note: returns length excluding prefix
};

class FLDCVar16 : public FLDConv
{
public:
   BOOL      bConvert;

   FLDCVar16();
   FLDCVar16(BOOL bConvert);
   ~FLDCVar16();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCVar32 : public FLDConv
{
public:
   BOOL      bConvert;

   FLDCVar32();
   FLDCVar32(BOOL bConvert);
   ~FLDCVar32();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCInt8 : public FLDConv
{
public:
   BOOL      bConvert;
   BOOL      bSigned ;

   FLDCInt8();
   FLDCInt8(BOOL bConvert, BOOL bSigned);
   ~FLDCInt8();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCInt16 : public FLDConv
{
public:
   BOOL      bConvert;
   BOOL      bSigned ;

   FLDCInt16();
   FLDCInt16(BOOL bConvert, BOOL bSigned);
   ~FLDCInt16();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCInt32 : public FLDConv
{
public:
   BOOL      bConvert;
   BOOL      bSigned ;

   FLDCInt32();
   FLDCInt32(BOOL bConvert, BOOL bSigned);
   ~FLDCInt32();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCInt64 : public FLDConv
{
public:
   BOOL      bConvert;
   BOOL      bSigned ;

   FLDCInt64();
   FLDCInt64(BOOL bConvert, BOOL bSigned);
   ~FLDCInt64();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCSingle : public FLDConv
{
public:
   BOOL      bConvert;

   FLDCSingle();
   FLDCSingle(BOOL bConvert);
   ~FLDCSingle();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCFloat : public FLDConv
{
public:
   BOOL      bConvert;

   FLDCFloat();
   FLDCFloat(BOOL bConvert);
   ~FLDCFloat();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCFloatIEEE : public FLDConv
{
public:
   BOOL      bConvert;

   FLDCFloatIEEE();
   FLDCFloatIEEE(BOOL bConvert);
   ~FLDCFloatIEEE();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCBcd : public FLDConv
{
public:
   BOOL      bConvert;
   UINT32    iPrecision;
   UINT32    iDecimals;

   FLDCBcd();
   FLDCBcd(BOOL bConvert,UINT32 iPrecision, UINT32 iDecimals);
   ~FLDCBcd();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCFixed : public FLDConv
{
public:
   BOOL      bConvert;

   FLDCFixed();
   FLDCFixed(BOOL bConvert, UINT32 iFixedLen);
   ~FLDCFixed();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCRepeat : public FLDConv
{
public:
   BOOL      bConvert;
   FLDConv   *pFldElement;
   FLDConv   *pFldObjCount;

   FLDCRepeat();
   ~FLDCRepeat();

   FLDCRepeat(BOOL bConvert, FLDConv * pFldObj);

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCBool : public FLDConv
{
public:
   BOOL      bConvert;
   FLDConv   *pFldObj;


   FLDCBool();
   FLDCBool(BOOL bConvert, UINT32 iSize);
   ~FLDCBool();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCDATE : public FLDConv
{
public:
   BOOL      bConvert;

   FLDCDATE();
   FLDCDATE(BOOL bConvert);
   ~FLDCDATE();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCTIME : public FLDConv
{
public:
   BOOL      bConvert;

   FLDCTIME();
   FLDCTIME(BOOL bConvert);
   ~FLDCTIME();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCTIMESTAMP : public FLDConv
{
public:
   BOOL      bConvert;

   FLDConv   *pFldObjDate;
   FLDConv   *pFldObjTime;

   FLDCTIMESTAMP();
   FLDCTIMESTAMP(BOOL bConvert);
   ~FLDCTIMESTAMP();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDNested : public FLDConv
{
public:
   BOOL      bConvert;

   FLDNested();
   FLDNested(BOOL bConvert);
   ~FLDNested();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDAlwaysNull : public FLDConv
{
public:
   BOOL      bConvert;

   FLDAlwaysNull();
   FLDAlwaysNull(BOOL bConvert);
   ~FLDAlwaysNull();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDUnicode : public FLDConv
{
public:
   BOOL      bConvert;

   FLDUnicode();
   FLDUnicode(UINT32 iSize);
   ~FLDUnicode();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDBinary : public FLDConv
{
public:
   BOOL      bConvert;

   FLDBinary();
   FLDBinary(UINT32 iSize);
   ~FLDBinary();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCSQLTIMESTAMP : public FLDConv
{
public:
   BOOL      bConvert;


   FLDCSQLTIMESTAMP();
   FLDCSQLTIMESTAMP(BOOL bConvert);
   ~FLDCSQLTIMESTAMP();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

class FLDCSQLTIMESTAMPOFFSET : public FLDConv
{
public:
   BOOL      bConvert;


   FLDCSQLTIMESTAMPOFFSET();
   FLDCSQLTIMESTAMPOFFSET(BOOL bConvert);
   ~FLDCSQLTIMESTAMPOFFSET();

   pBYTE     FldPut(pBYTE pPos, pBYTE pVal, UINT32 iLen);
   pBYTE     FldGet(pBYTE pPos, pBYTE pVal, pUINT32 piLen, pBOOL pbBlank);
};

typedef enum
{
   fldAttrArea  = 0,
   pcklAttrArea = 1
} PCKLATTRArea;

typedef enum
{
   fldIsChanged   = 0,
   fldIsNull      = 1,
   fldIsUnChanged = 2
} PCKLFldStauts;


typedef struct DSDATAPACKETFLDDesc
{
    DBINAME szFieldName;       // Column Name
    INT   iFieldType;         // Column Type
    INT16   iAttributes;       // Column attributes
} DSDATAPACKETFLDDesc;
typedef  DSDATAPACKETFLDDesc *pDSDATAPACKETFLDDesc;

typedef struct DSDATAPACKETFLDDescX
{
    DBINAME szFieldName;       // Column Name
    INT     iFieldType;        // Column Type
    INT16   iAttributes;       // Column attributes
    CHAR    szSubType[21]; //Subtype (xml)
} DSDATAPACKETFLDDescX;
typedef  DSDATAPACKETFLDDescX *pDSDATAPACKETFLDDescX;

typedef DBIResult (DBIFN *pfPCKLXltFn) (
   pBYTE    pDest,             // Ptr to the destination buffer.
   UINT32   iFieldLength,      // Column length.
   pBYTE    pSource,           // Ptr to the source buffer.
   UINT32   iRowSize,          // Row size of the source record
   UINT32   iRecs              // Number of records in the source buffer.
);
typedef pfPCKLXltFn *ppfPCKLXltFn;

typedef struct  {
    UINT16      iFieldID;      // FieldID of this field.
    // FieldID of parent, if any (part of ADT or ARRAY)
    UINT16      iFieldIDParent;
    UINT32      iBaseFieldType;
    class       FLDConv *pFldObj;  // Array of fld-objects for writing and reading fields
    UINT16      iNewRecState  ;  // Index of new record state
    UINT16      iNULLOffs     ;  // Byte from beginning of record containing nullbits for this field
    BYTE        iMask1        ;  // Bit-mask for BLANK_NULL
    BYTE        iMask2        ;  // Bit-mask for BLANK_NOTCHANGED
    BYTE        bAsAttr       ;  // field is attribute, otherwise tag
    UINT8       iUnused       ;  // To align..
} DSPROVADTFLDDesc;
typedef DSPROVADTFLDDesc far *pDSPROVADTFLDDesc;

typedef struct
{
   pBYTE        pFldDescCurrLoc;    // Ptr to FldDesc Curr loc.
   pBYTE        pFldAttrCountLoc;   // Ptr to Curr loc for fld attr count.
   pBYTE        pAttrCountLoc;      // Ptr to Curr loc for attr count.
   pBYTE        pAttrCurrLoc;       // Ptr to Curr loc in Opt Param Area.
   pBYTE        pDataCurrLoc;       // Ptr to Curr loc in Data Area.
   pBYTE        pInsertionPoint;    // In case attributes are to be inserted, do it here.
} DSPCKLInfo;
typedef DSPCKLInfo *pDSPCKLInfo;

//Max. nesting of tables
#define MAXRECSTATES  64

//Current state of reading a record
typedef struct
{
   UINT32       iColumnsInitial;    // Initial count (not used for xml)
   UINT32       iColumns;           // Number of fielddescs.
   UINT32       iPrevRecState;      // Pointer to previous level, if any
   UINT32       iRowCountDown;      // In case of embedded table
   UINT32       iCurrFldNo;         // Current FieldNo being added.
   pBYTE        pRowBeginLoc;       // Ptr to begining of the current row.
   UINT16       iParentFieldNo;     // FieldNo in parent fielddesc.
   UINT16       iOptParamsInitial;  // Reading only!
   UINT16       iOptParams;         // Number of optional parameters added
   UINT32       iAdtColumns;        // number of adt columns (expanded number)
   pDSPROVADTFLDDesc pAdtFieldDesc; // Ptr to abstract field descriptors.
   pUINT32      pEmbeddedRowCount;  // In case of embedded rows, where count is not known in advance
   class Attr_List   *pAttr_List;   // Xml-Attrs
   class Flds_List   *pFlds_List;   // Dynamic array of field descriptors
   BOOL         bColsRead;          // Xml, read all columns for this level
   BOOL         bForceTagName;      // Xml, after first structured type, all fields must be tag-based
   pCHAR        pszROW;             // Xml, name of ROW (i.e. szROW, or "ROW_Table2" etc.)
   UINT32       pInsertionOffs;     // Xml In case attributes are to be inserted, do it here.(Offset to avoid resizing issues)
} DSRECState;
typedef DSRECState *pDSRECState;

//Old cookie
#define MAGICCOOKIEOLD 0x0000ABCD
//BDE-generated datapacket
#define MAGICCOOKIE 0xBDE01996

#define MIN_PICKLEVERSION  0
#define PICKLEVERSION_1    1
#define PICKLEVERSION_2    2
#define PICKLEVERSION_3    3
#define MAX_PICKLEVERSION  3

typedef enum
{
  pcklpropsMETADATA_INCL  = 1,  // Metadata (fielddescriptor
                                // [and optional parameters]) are included
  pcklpropsCONTAINMETALEN = 2   // Offset to beginning of data from start of datapacket is in HdrInfo->iReserved (version 2 only)
} PCKLProps;

#pragma pack(push, 1)
typedef struct DSPCKLHdrInfo
{
    UINT32  iMagicNo;          // Magic number
    UINT16  iMajorVer;         // Major version number (1)
    UINT16  iMinorVer;         // Minor version number (0)
    UINT32  iHeaderSize;       // Size of fixed part of header in bytes
    UINT16  iColumnCount;      // Column count (not including attribute field)
    UINT32  iRowCount;         // Total number of rows in this datapacket
    PCKLProps iProperties;     // datapacket properties
    UINT16  iReserved;         // Reserved. If pcklpropsCONTAINMETALEN, contains offset to data.
} DSPCKLHDRInfo;
#pragma pack(pop)
typedef DSPCKLHdrInfo *pDSPCKLHdrInfo;

#ifdef __cplusplus
   }
#endif // __cplusplus

#include "tpacket.h"
#include "packet.h"

#ifndef dsDELAYEDBIT             //Also defined in alctypes.h
#define dsDELAYEDBIT 0x80000000  // Length/number is not present
#endif

#define dptypeUNKNOWN(iLen) (UINT32) ((dsfldUNKNOWN << dsSizeBitsLen) + iLen)

#define dptypeINT8         (UINT32)((dsfldINT        << dsSizeBitsLen) + 1)
#define dptypeINT16        (UINT32)((dsfldINT        << dsSizeBitsLen) + 2)
#define dptypeINT32        (UINT32)((dsfldINT        << dsSizeBitsLen) + 4)
#define dptypeINT64        (UINT32)((dsfldINT        << dsSizeBitsLen) + 8)

#define dptypeUINT8        (UINT32)((dsfldUINT       << dsSizeBitsLen)   | 1)
#define dptypeUINT16       (UINT32)((dsfldUINT       << dsSizeBitsLen)   | 2)
#define dptypeUINT32       (UINT32)((dsfldUINT       << dsSizeBitsLen)   | 4)
#define dptypeUINT64       (UINT32)((dsfldUINT       << dsSizeBitsLen)   | 8)

#define dptypeBOOL8        (UINT32)((dsfldBOOL       << dsSizeBitsLen)   | 1)
#define dptypeBOOL16       (UINT32)((dsfldBOOL       << dsSizeBitsLen)   | 2)
#define dptypeBOOL32       (UINT32)((dsfldBOOL       << dsSizeBitsLen)   | 4)

#define dptypeSINGLE       (UINT32)((dsfldSINGLE     << dsSizeBitsLen)   | 4)
#define dptypeFLOAT        (UINT32)((dsfldFLOATIEEE  << dsSizeBitsLen)   | 8)
#define dptypeFLOATIEEE    (UINT32)((dsfldFLOATIEEE  << dsSizeBitsLen)   | 10)

#define dptypeBCD(iLen)    (UINT32)((dsfldBCD        << dsSizeBitsLen)   | iLen)
#define dptypeFMTBCD(iLen) (UINT32)((dsfldFMTBCD     << dsSizeBitsLen)   | iLen)
#define dptypeDATE         (UINT32)((dsfldDATE       << dsSizeBitsLen)   | 4)
#define dptypeTIME         (UINT32)((dsfldTIME       << dsSizeBitsLen)   | 4)
#define dptypeTIMESTAMP    (UINT32)((dsfldTIMESTAMP  << dsSizeBitsLen)   | 8)

#define dptypeZSTRING(iLen)  (UINT32)(((dsfldZSTRING << dsSizeBitsLen)   | ((iLen < 255)? 1 : 2)) | dsVaryingFldType)
#define dptypeUNICODE(iLen)  (UINT32)(((dsfldUNICODE << dsSizeBitsLen)   | ((iLen < 255)? 1 : 2)) | dsVaryingFldType)
#define dptypeVARBYTES(iLen) (UINT32)(((dsfldBYTES   << dsSizeBitsLen)   | ((iLen < 255)? 1 : 2)) | dsVaryingFldType)
#define dptypeBLOB           (UINT32)(((dsfldBYTES   << dsSizeBitsLen)   | 4                    ) | dsVaryingFldType)
#define dptypeBYTES(iLen)    (UINT32)((dsfldBYTES    << dsSizeBitsLen)   | iLen)
#define dptypeADT(iUnits1)   (UINT32)(((dsfldADT     << dsSizeBitsLen)   | iUnits1) | dsPseudoFldType)
#define dptypeARRAY(iUnits1) (UINT32)(((dsfldARRAY   << dsSizeBitsLen)   | iUnits1) | dsPseudoFldType | dsCompArrayFldType)

#define dptypeTABLE(iElements)   (UINT32)(((dsfldEMBEDDEDTBL   << dsSizeBitsLen) | iElements) | dsPseudoFldType | dsEmbeddedFldType)
#define dptypeREF(iElements)     (UINT32)(((dsfldREF           << dsSizeBitsLen) | iElements) | dsPseudoFldType)
#define dptypeBIGDECIMAL(iLen)   (UINT32)(((dsfldBIGDECIMAL    << dsSizeBitsLen) | 1) | dsVaryingFldType)
#define dptypeSQLTIMESTAMP       (UINT32)((dsfldDATETIME       << dsSizeBitsLen) | 16)
#define dptypeSQLTIMESTAMPOFFSET (UINT32)((dsfldDATETIMEOFFSET << dsSizeBitsLen) | 20)

#define dptypeINTARRAY           (UINT32)(((dsfldINT  << dsSizeBitsLen) | 4) | dsArrayFldType)
#define dptypeUINTARRAY          (UINT32)(((dsfldUINT << dsSizeBitsLen) | 4) | dsArrayFldType)

#ifdef DEBUG
DBIResult makeError(UINT32 e);
#define SetError(e) makeError(e)
#else
#define SetError(e)  e
#endif

//Defines for SetXmlMode/GetXmlMode

#define xmlUNTYPED       0x0001
#define xmlXMLDATATYPED  0x0002
//Include schema in header
#define xmlXMLSCHEMA     0x0004
//Encode data using UTF8
#define xmlXMLUTF8       0x0008

#ifdef _UNIX

#include "bdetypes.h"
#include "alctypes.h"

#define MAXMIDASERRORS   44

struct MidasError
 {
 DBIResult errorCode;
 char message[512];
 };

const MidasError ResourcedErrorString[] = {
   { DBIERR_NONE, "Successful completion."}, 
   { DBIERR_NA, "Operation not applicable."}, 
   { DBIERR_NOMEMORY, "Insufficient memory for this operation."}, 
   { DBIERR_BOF, "At beginning of table."}, 
   { DBIERR_EOF, "At end of table."}, 
   { DBIERR_INVALIDPARAM, "Invalid parameter."}, 
   { DBIERR_OBJNOTFOUND, "Could not find object."}, 
   { DBIERR_KEYVIOL, "Key violation."}, 
   { DBIERR_NOTSUPPORTED, "Capability not supported."}, 
   { DBIERR_RECNOTFOUND, "Could not find record."}, 
   { DBIERR_TABLEREADONLY, "Data is read only."},
   { DBIERR_NOSUCHINDEX, "Index does not exist."}, 
   { DBIERR_OUTOFRANGE, "Number is out of range."}, 
   { DBIERR_NOCURRREC, "No current record."}, 
   { DBIERR_KEYORRECDELETED, "Record/Key deleted."},
   { DBIERR_INDEXNAMEREQUIRED, "Index name required."}, 
   { DBIERR_TYPEMISM, "Type mismatch in expression."}, 
   { DBIERR_INVALIDFLDTYPE, "Invalid field type."}, 
   { DBIERR_ACTIVEINDEX, "Index is being used to order table."}, 
   { DBIERR_INVALIDINDEXNAME, "Invalid index/tag name."}, 
   { DBIERR_INDEXREADONLY, "Index is read only."}, 
   { DBIERR_DELTAISEMPTY, "Delta is empty."}, 
   { DBIERR_NOTHINGTOUNDO, "Nothing to undo."}, 
   { DBIERR_NAMENOTUNIQUE, "Name not unique in this context."}, 
   { DBIERR_INVALIDBLOBHANDLE, "Invalid BLOB handle in record buffer."}, 
   { DBIERR_CONSTRAINTFAILED, "Record or field constraint failed."}, 
   { DBIERR_FIELDISBLANK, "Field is blank."}, 
   { DBIERR_NOTINDEXED, "Data is not indexed."}, 
   { DBIERR_NOMETADATA, "Datapacket contains no meta data."}, 
   { DBIERR_CANNOTAPPEND, "Trying to append data to a non-partial dataset."}, 
   { DBIERR_DATAPACKETMISMATCH, "Mismatch in datapacket."}, 
   { DBIERR_READONLYFLD, "Trying to modify read-only field."}, 
   { DBIERR_REQDERR, "Field value required."}, 
   { DBIERR_NEWERVERSIONREQ, "Newer version required."}, 
   { DBIERR_DETAILRECORDSEXIST, "Cannot delete master record with details."}, 
   { DBIERR_BLOBNOTFETCHED, "Blob has not been fetched."}, 
   { DBIERR_DETAILSNOTFETCHED, "Details has not been fetched."},
   { DBIERR_NOMASTERRECORD, "No corresponding master record found."}, 
   { DBIERR_LINKFIELDSNOTUNIQUE, "Linkfields to detail must be unique."}, 
   { DBIERR_FLYAWAY_WRONGORDER, "Special case: wrong order of updates for fly-away!"}, 
   { DBIERR_NOCASCADEDUPDATES, "Cascaded updates not enabled."}, 
   { DBIERR_NOSUCHAGGREGATE, "Aggregate was not found."},
   { DBIERR_XMLINVALIDTYPE, "Fieldtype not supported for XML."},
   { DBIERR_XMLNODELAYEDFETCHING,     "Delayed fetching not supported for XML."}
   };

#endif

#endif //PICKLE_H
