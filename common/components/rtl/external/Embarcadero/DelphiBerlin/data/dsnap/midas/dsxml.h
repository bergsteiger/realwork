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

#ifndef DSXML_H
#define DSXML_H

#include "varlist.h"

#define szDATAPACKET "DATAPACKET"
#define szDATA       "ROWDATA"
#define szMETADATA   "METADATA"
#define szFIELDS     "FIELDS"
#define szFIELDDEF   "FIELD"
#define szPARAMS     "PARAMS"
#define szOPTPARAM   "PARAM"
#define szNULL       "NULL"
#define szROW        "ROW"
#define szAttrFld    "ROWATTR"
#define szROUNDTRIP  "Roundtrip"
#define szVersion    "Version"
#define szVersion20  "2.0"

#define szRowState  "RowState"
#define szAttrName  "Name"
#define szAttrValue "Value"
#define szAttrType  "Type"

//Field attributes
#define szAttrTagName   "tagname"
#define szAttrAttrName  "attrname"
#define szAttrFieldName "fieldname"
#define szAttrFieldType "fieldtype"
#define szAttrReadOnly  "readonly"
#define szAttrHidden    "hidden"
#define szAttrRequired  "required"
#define szAttrLinkFld   "linkfield"

#define szXMLInt8       "i1"
#define szXMLInt16      "i2"
#define szXMLInt32      "i4"
#define szXMLInt64      "i8"
#define szXMLUInt8      "ui1"
#define szXMLUInt16     "ui2"
#define szXMLUInt32     "ui4"
#define szXMLUInt64     "ui8"
#define szXMLSingle     "r4"
#define szXMLFloat      "r8"
#define szXMLFloat10    "r10"
#define szXMLNumber     "r8"
#define szXMLFixed      "fixed"
#define szXMLFixedFMT   "fixedFMT"
#define szXMLBool       "boolean"
#define szXMLDate       "date"
#define szXMLDateTime   "dateTime"
#define szXMLTime       "time"
#define szXMLArray      "array"
#define szXMLADT        "struct"
#define szXMLNested     "nested"
#define szXMLStringUni  "string.uni"
#define szXMLStringAnsi "string"
#define szXMLBinHex     "bin.hex"
#define szXMLIntArray   "IntArray"
#define szXMLUIntArray  "UIntArray"
#define szXMLSQLDateTime  "SQLdateTime"
#define szXMLSQLDateTimeOffset "SQLdateTimeOffset"

#define szXMLTYPEBEG    "dt:dt"


#define szXMLEncoding "encoding"
#define szXMLUTF8 "UTF-8"

#if defined(__APPLE__) || defined(__arm__) || defined(__arm64__)
#define HIGH_SURROGATE_START  0xd800
#define HIGH_SURROGATE_END    0xdbff
#define LOW_SURROGATE_START   0xdc00
#define LOW_SURROGATE_END     0xdfff
#define IS_HIGH_SURROGATE(wch) (((wch) >= HIGH_SURROGATE_START) && ((wch) <= HIGH_SURROGATE_END))
#define IS_LOW_SURROGATE(wch)  (((wch) >= LOW_SURROGATE_START) && ((wch) <= LOW_SURROGATE_END))
#endif

struct Attr_Entry
{
   UINT32 iId;
   pCHAR  pAttrName;       // Points to attrname
   UINT32 iAttrNameLen;
   pCHAR  pValue  ;
   UINT32 iValueLen;       //== 0 means
   UINT32  iType;          // if relevant!
   BOOL   bVisited;
};
typedef Attr_Entry* pAttr_Entry;

class Attr_List : public VARList
{
#if defined(_MSC_VER)
private:
//Do not use.  See midas.cpp for details.
   Attr_List(){};
   friend class DUMMYVectorDeleteGenClass;
#endif
   class DSXML_W * pDsXml;
public:
   Attr_List(class DSXML_W *pDsXml);
   virtual ~Attr_List();

   UINT32      iPos;

   virtual VOID      DBIFN  Reset(
            VOID
        );

   DBIResult DBIFN Parse(pCHAR pAttr);
   pAttr_Entry  DBIFN Find(pCCHAR pAttrName, UINT32 iHint);
   VOID SetVisited(UINT32 iId);
   UINT32 DBIFN Next(VOID); //returns iId, or 0
};

class Flds_List : public VARList
{
#if defined(_MSC_VER)
private:
//Do not use.  See midas.cpp for details.
   Flds_List(){};
   friend class DUMMYVectorDeleteGenClass;
#endif
public:
   Flds_List(UINT32 iCols);
   virtual ~Flds_List();

   UINT32    DBIFN  Columns(VOID);
   pDSDATAPACKETFLDDescX  DBIFN GetFldDesc(UINT32 i);
};

class DSXML_W
{
   CHAR    pBuf[257];   // Internal buffer for small conversions
   UINT32  iIndentSize;
   UINT32  iIndentLevel;
   BOOL    bEnableCRLF;
   pBYTE   pVarBuf;
   UINT32  iVarBufLen;

   pBYTE   GetVarBuf(UINT32 iLen);
public:
   UINT32  iStyle;
   BOOL    bOpenTag;    //If true, the current tag was not yet closed
   CHAR    OpenTag[81]; //Current open tag
   CHAR    LastTag[81]; //Last tag closed.
   BOOL    bUTF8;
   BOOL    bUTF8METADATA;
   INT32   iANSICodePage;
   class DSXML_Parse *pXmlParse;

   DSXML_W();
   ~DSXML_W();
   DBIResult Init(UINT32 iIndentSize, BOOL bEnableCRLF, UINT32 iStyle, BOOL bRead, BOOL bMETADATAMode, INT32 iAnsiCP);

   pBYTE WriteHead(pBYTE pPos);
   UINT32 HeadLen();
   pBYTE WriteBeginTag(pBYTE pPos, pCCHAR pTagName , pCCHAR pType, BOOL bIndent, BOOL bCRLF);
   pBYTE WriteEndTag(pBYTE pPos  , pCCHAR pTagName , BOOL bIndent);
   pBYTE WriteEmptyTag(pBYTE pPos, pCCHAR pTagName , BOOL bIndent, BOOL bCRLF);
   pBYTE WriteValue(pBYTE pPos, pCCHAR pTagName, pCCHAR pTypeName, pCCHAR pValue);
   pBYTE WriteValueLen(pBYTE pPos, pCCHAR pTagName, pCCHAR pTypeName, pCCHAR pValue, UINT32 iLen);
   pBYTE WriteAttributeData(pBYTE pPos, pCCHAR pAttrName, pCCHAR pValue);
   pBYTE WriteAttribute(pBYTE pPos, pCCHAR pAttrName, pCCHAR pValue);
   pBYTE WriteAttributeLen(pBYTE pPos, pCCHAR pAttrName, pCCHAR pValue, UINT32 iLen, BOOL bValueIsUTF8 = FALSE);
   pBYTE WriteString(pBYTE pPos, pCCHAR psz, BOOL bCRLF);
   pBYTE WriteOpenTag(pBYTE pPos, pCCHAR pTagName , BOOL bIndent);
   pBYTE WriteFinishTag(pBYTE pPos, BOOL bEmpty);

   pCHAR FromINT8(pBYTE   pValue)   ;
   pCHAR FromINT16(pBYTE  pValue)   ;
   pCHAR FromINT32(pBYTE  pValue)   ;
   pCHAR FromINT64(pBYTE  pValue)   ;
   pCCHAR FromBOOL8(pBYTE  pValue)   ;
   pCCHAR FromBOOL16(pBYTE pValue)   ;
   pCCHAR FromBOOL32(pBYTE pValue)   ;
   pCHAR FromSINGLE(pBYTE pValue)   ;
   pCHAR FromFLOAT(pBYTE  pValue)   ;
   pCHAR FromFLOATIEEE(pBYTE pValue);
   pCHAR FromBCD(pBYTE    pValue)   ;
   pCHAR FromDATE(pBYTE   pValue)   ;
   pCHAR FromTIME(pBYTE   pValue)   ;
   pCHAR FromTIMESTAMP(pBYTE pValue);
   pCHAR FromUNICODE(pBYTE pValue, pUINT32 piLen);
   pCHAR FromSTRING(pBYTE pValue, pUINT32 piLen);
   pCHAR FromSQLTIMESTAMP(pBYTE pValue);
   pCHAR FromSQLTIMESTAMPOFFSET(pBYTE pValue);
   pCHAR FromBINARY(pBYTE pValue, pUINT32 piLen);

   //Read, fixed types
   DBIResult ReadINT32(pCHAR pTagName, pINT32 pInt, UINT32 iValLen, pBOOL pbBlank);
   DBIResult ReadUINT32(pCHAR pTagName, pUINT32 pUInt,UINT32 iValLen,pBOOL pbBlank);
   DBIResult ReadINT64(pCHAR pTagName, pINT64 pInt, UINT32 iValLen, pBOOL pbBlank);
   DBIResult ReadSINGLE(pCHAR pTagName, pSINGLE pSingle, UINT32 iValLen, pBOOL pbBlank);
   DBIResult ReadFLOAT(pCHAR pTagName, pDFLOAT  pFloat, UINT32 iValLen, pBOOL pbBlank);
   DBIResult ReadFLOATIEEE(pCHAR pTagName, long double* pFloatIEEE, UINT32 iValLen, pBOOL pbBlank);
   DBIResult ReadBOOL(pCHAR pTagName, pBOOL pbBool, UINT32 iValLen, pBOOL pbBlank);
   DBIResult ReadBCD(pCHAR pTagName, pBYTE  pBcd,  UINT32 iValLen, pBOOL pbBlank, UINT32 iPrecision, UINT32 iDecimals);
   DBIResult ReadDATE(pCHAR pTagName, pUINT32 piDate, UINT32 iValLen, pBOOL pbBlank);
   DBIResult ReadTIME(pCHAR pTagName, pUINT32 piTime, UINT32 iValLen, pBOOL pbBlank);
   DBIResult ReadTIMESTAMP(pCHAR pTagName, pDFLOAT piFloat, UINT32 iValLen, pBOOL pbBlank);
   DBIResult ReadSQLTIMESTAMP(pCHAR pTagName, SQLTIMESTAMP * pTimeStamp, UINT32 iValLen, pBOOL pbBlank);
   DBIResult ReadSQLTIMESTAMPOFFSET(pCHAR pTagName, SQLTIMESTAMPOFFSET * pTimeStampOffset, UINT32 iValLen, pBOOL pbBlank);
   //Read, variable Len
   DBIResult ReadStr(pCHAR pValue, pCHAR pStr, pUINT32 piLen, pBOOL pbBlank);
   DBIResult ReadUniStr(pCHAR pValue, pCHAR pStr, pUINT32 piLen, pBOOL pbBlank);
   DBIResult ReadBinaryStr(pCHAR pValue, pCHAR pStr, pUINT32 piLen, pBOOL pbBlank);
};

// UTF-8 utilities.
int MultiByteToUTF8(INT32 ansicp, unsigned char * Input, unsigned int InputLen, unsigned char *Output, unsigned int OutputLen);
int MultiByteToUTF8WithEscape(INT32 ansicp, unsigned char * Input, unsigned int InputLen, unsigned char *Output, unsigned int OutputLen);
int UTF8ToMultiByte(INT32 ansicp, unsigned char * Input, unsigned int InputLen, unsigned char *Output, unsigned int OutputLen);
int UTF8ToAsciiWithEscape(unsigned char * Input, unsigned int InputLen, unsigned char *Output, unsigned int OutputLen);

pCHAR WideCharToUTF8(const pUCS2Char Input);
pUCS2Char UTF8ToWideChar(pCCHAR Input);

typedef enum
{
  Tag_Begin = 1,
  Tag_End   = 2,
  Tag_Empty = 3,
  Tag_Leaf  = 4,
} XMLTagType;

#define LookAhead()  (pCurPos[1])
#define MoveAhead()  (pCurPos++)
#define CurChar()    (pCurPos < pEnd)? *pCurPos : 0

typedef struct
{
   XMLTagType iTagType; // 1:begintag, 2:endtag, 3:emptytag, 4:leaf (has value)
   pCHAR  pTagName;     // Points to tagname
   UINT32 iTagNameLen;
   BOOL   bBlank  ;
   pCHAR  pValue  ;
   UINT32 iValueLen;    //== 0 means
   UINT32 iType   ;     // Derived type (from dt:dt="")
   pCHAR  pAttr   ;     //==NULL if none
} XMLTag;

typedef struct
{
   pCHAR   pTagName;
   UINT32  iTagLen;
} XMLStackElement;

#define XMLSTACKSIZE 64
class DSXML_Parse
{
   pCHAR   pXML     ;
   pCHAR   pStart   ;   // Start of XML-string
   pCHAR   pCurPos  ;   // Current position
   pCHAR   pCurPosSave; //
   pCHAR   pEnd     ;   // Last element in string

   XMLStackElement  pStack[XMLSTACKSIZE];
   UINT32  iStackPos ;
   UINT32  iStackPosSave;
   UINT32  iStackSize;

   DBIResult Push(UINT32 iLen, pCHAR pName);
   DBIResult Pop(UINT32  iLen, pCHAR pName);

   CHAR    NextChar(BOOL bInc);

public:
   DSXML_Parse();
   ~DSXML_Parse();

   XMLTag  pCurTag;
   pCHAR   pAttr;
   class   Attr_List   *pAttr_List;
   BOOL    bUTF8;
   BOOL    bUTF8METADATA;
   INT32   iANSICodePage;
   pCHAR   pUTF8Buf;

   pCHAR      ParseHead(pCHAR pXML, DBIResult *pErr); //Returns beginning of
   DBIResult  Init(UINT32 iLen, pCHAR pXML);
   pCHAR      GetName(pCHAR *ppName, pUINT32 piLen, pCHAR *ppAttr);
   pCHAR      GetValue(pCHAR *pValue, pUINT32 piLen);
   DBIResult  ReadValue(pCCHAR pTagName, pCHAR *pValue, pUINT32 piValueLen, pBOOL bBlank); //returns error, if not
   DBIResult  ReadBeginTag(pCHAR *ppTagName, pUINT32 piLen); //Expect a begintag;
   DBIResult  ReadEndTag();
   pCHAR      ReadAttribute(pCHAR pAttr, pCHAR pName, pCHAR pValue,pUINT32 piLen);
   DBIResult  ReadFindAttribute(pCHAR pAttr, pCHAR pAttrToFind, pCHAR pValue);
   DBIResult  IsTag(XMLTagType *pTagType);
   DBIResult  NextTag(XMLTag *pTag);
   VOID       StorePos();   // saves pCurPos in pCurPosSave
   VOID       RestorePos();
   INT32      CmpTags(pCHAR pzTag, pCHAR pTagName, UINT32 iLen); //Compares a zero-terminated string to a tagname
};

pCCHAR XmlTypeOfAttr(pCCHAR pszAttrName);
#endif


