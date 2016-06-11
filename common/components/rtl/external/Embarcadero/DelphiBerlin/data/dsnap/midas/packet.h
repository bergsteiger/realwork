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

#ifndef PACKET_H
#define PACKET_H

#ifndef _UNIX
#define __attribute(x)
  #if __GNUC__
    #define COMINTF
  #else
    #define COMINTF __attribute__ ((com_interface))
  #endif
#endif

class DSDATAPACKET : TDATAPACKET_WRITE
{
public:

   UINT32         iAttrCnt;   // Number of attributes defined
   UINT32         iColumns;   // Number of columns
   UINT32         iRows;      // Number of rows
   class Flds_List *pFlds_List;

   //Create 'structure' of streamed dataset
   DSDATAPACKET();
   ~DSDATAPACKET();

   HRESULT DBIFN QueryInterface(
         REFIID riid,
         void** ppv
         );

   UINT32 DBIFN AddRef(
         VOID
         );

   UINT32 DBIFN Release(
         VOID
         );

   //Initialze by sequentially adding columns
   DBIResult DBIFN Init_Sequential(
         UINT32 iVersion,
         UINT16 iColumns
         );

   DBIResult DBIFN Init(
         UINT32 iVersion,
         UINT16 iColumns,
         pDSDATAPACKETFLDDesc  pFieldDesc
         );

   //Add an optional parameter
   DBIResult DBIFN AddAttribute (PCKLATTRArea eAttrArea, pCCHAR pszAttr,
         UINT32 iType, UINT32 iLen, pBYTE pValue);

   //Return pointer to the finished 'safearray'
   DBIResult DBIFN GetDataPacket (SAFEARRAY  **ppSa);

   // Get the size of the safearray.
   DBIResult DBIFN GetSize(pUINT32  piDataPacketSize);

   // Add this field to the data stream.
   DBIResult DBIFN PutField (PCKLFldStauts eFldStatus, UINT32 iLen, pBYTE pSrc);

   // Add a column descriptor.
   DBIResult DBIFN AddColumnDesc(pDSDATAPACKETFLDDesc pFldDes);

   // Reset all data (in order to create partial data)
   // Datapackets will not contain meta-info.
   DBIResult DBIFN Reset();

   // Return number of fielddescriptors, including embedded tables etc.
   // (Same as iColumns above, only for external COM-users)
   DBIResult DBIFN GetColumnCount(pUINT32 piCnt);

   //Return all fielddescriptors
   // (Same as pFieldDesc above, only for external COM-users)
   DBIResult DBIFN GetColumnDescs(pDSDATAPACKETFLDDesc pFldDes);

   DBIResult DBIFN GetErrorString(DBIResult iErrCode, pCHAR pString);

   //Signals last row for a nested table, in case rowcount was not known in advance
   DBIResult DBIFN EndOfNestedRows(VOID);

   DBIResult DBIFN SetXMLMode(INT iMode);

   UINT32    DBIFN GetXMLMode(VOID);

   DBIResult DBIFN SetMETADATAMode(BOOL bMETADATAMode);
   DBIResult DBIFN SetANSICodePage(INT32 iANSICodePage);

private:
   UINT32           iRefCount;               // Reference count, delete object when hitting 0
   pBYTE            pDataPacketBuf;          // datapacket buffer for streamed data.
   UINT32           iTotalSize;
   BOOL             bDontStreamColDescs;
   UINT32           iCurRecState;            // Current level in pdsPcklInfo
   UINT32           iRecStatesCnt;
   pDSRECState      paRecStates[MAXRECSTATES];//Array of record states

   DSPCKLInfo       dsPcklInfo;              // datapacket information.
   SAFEARRAY       *pSa;                     // pointer to safearray.
   BOOL             bMetaDataDone;
   BOOL             bBigEndian;              // TRUE if conversion required
   class            FLDConv *pFldAttrObj;    // To write out the attribute field (bXML)

   DBIResult        GrowSize (UINT32 iSize);
   DBIResult DBIFN  NewRecState(UINT16 iCols, UINT16 iFieldNo, UINT32 iCurRecState, pUINT32 piRecState, pCCHAR pszRowName);
   VOID             DelRecStates(VOID);
   VOID             InitObj(VOID);
   class DSXML_W   *pDsXml;
   BOOL             bFirstRow;               // FirstRow-event
   BOOL             bOptParamsDone;          // Xml-state
   BOOL             bUTF8METADATA;
   INT32            iANSICodePage;
} COMINTF;


class DSEXTRACT: TDATAPACKET_READ
{
public:
   //Extracted values
   UINT16          iAttrCnt;       // Number of attributes defined
   UINT16          iColumns;
   UINT32          iRows;
   PCKLProps       iProperties;    // datapacket properties

   UINT16          iAttrCurrent;   // Extracting this attribute next
   UINT32          iRowCurrent;    // Extracting this row next
   UINT16          iFieldCurrent;  // Extracting this field next

   //Initial datapacket(Must contain metadata)
   DSEXTRACT();
   ~DSEXTRACT();


   HRESULT DBIFN QueryInterface(
         REFIID riid,
         void** ppv
         );

   UINT32 DBIFN AddRef(
         VOID
         );

   UINT32 DBIFN Release(
         VOID
         );

   DBIResult DBIFN Init( //Initial datapacket, (must contain metadata)
         SAFEARRAY *pdatapacket
         );

   // Adds additional 'partial' datapacket for extraction
   DBIResult DBIFN AddDataPacket(SAFEARRAY *pdatapacket);

   // Extract the next column descriptor.
   DBIResult DBIFN GetColumnDesc( pDSDATAPACKETFLDDesc pFldDes);

   // Extract length of next attribute
   DBIResult DBIFN GetAttributeLength (pUINT32 piLength);

   // Extract next attribute
   DBIResult DBIFN GetNextAttribute (pCHAR pszAttribute, pUINT32 piType,
         pUINT32 piLen, pBYTE pValue);

   // Get length of next field
   DBIResult DBIFN GetFieldLength (pUINT32 piLength);

   // Extract next field
   DBIResult DBIFN GetField (pUINT32 piLength, pBYTE pValue, pBOOL pBlank);

   DBIResult DBIFN GetErrorString(DBIResult iErrCode, pCHAR pString);

   DBIResult DBIFN SetXMLMode(INT iMode);
   UINT32    DBIFN GetXMLMode(VOID);

   DBIResult DBIFN XMLAddDataPacket(SAFEARRAY *pSa, pBYTE pPickle);
   DBIResult DBIFN XMLInitExtract(SAFEARRAY   *pSa);
   DBIResult DBIFN XMLGetField (pUINT32 piLength, pBYTE pValue, pBOOL pBlank);
   DBIResult DBIFN XMLGetColumnDesc(pDSDATAPACKETFLDDesc pFldDes);
   DBIResult DBIFN XMLGetNextAttribute(pCHAR pszAttribute,pUINT32 piType,pUINT32 piLen, pBYTE pValue);

   DBIResult DBIFN SetMETADATAMode(BOOL bMETADATAMode);
   DBIResult DBIFN SetANSICodePage(INT32 iANSICodePage);

private:
   UINT32           iRefCount;      // Reference count, delete object when hitting 0
   BOOL             bFldOptParams;  // TRUE:reading fieldoptional parameters
   BOOL             bMetaDataDone;  // TRUE, read and prepared all meta-data
   pBYTE            pCurrPos;

   UINT32           iCurRecState;   // Current level in pdsPcklInfo
   UINT32           iRecStatesCnt;
   pDSRECState      paRecStates[MAXRECSTATES]; //Array of record states

   ppfPCKLXltFn     ppfXltFn;       // Translate functions for the fields.
   SAFEARRAY        *pSa;           // pointer to safearray.
   BOOL             bBigEndian;     // TRUE if conversion required
   DSPCKLHDRInfo    HdrInfo;        // Copy of header info
   class            FLDConv *pFldAttrObj; //To write out the attribute field (bXML)

   DBIResult DBIFN  NewRecState(UINT16 iCols, UINT16 iFieldNo, UINT32 iCurRecState, pUINT32 piRecState);
   VOID             DelRecStates(VOID);
   VOID             InitObj(VOID);
   class DSXML_W   *pDsXml;
   BOOL             bFirstRow;      // FirstRow-event
   BOOL             bFldDescs;      // TRUE:reading fielddescs
   BOOL             bEndOfThisLevel;//(xml only)
   BOOL             bUTF8METADATA;
   INT32            iANSICodePage;
} COMINTF;

#endif
