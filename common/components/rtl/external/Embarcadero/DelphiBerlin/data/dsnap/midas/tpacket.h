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

#ifndef TPACKET_H
#define TPACKET_H

#ifndef _UNIX
#define __attribute__(x)
  #if __GNUC__
    #define COMINTF
  #else
    #define COMINTF __attribute__ ((com_interface))
  #endif
#endif

class TDATAPACKET_WRITE
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

   //Initialze by sequentially adding columns
   virtual DBIResult DBIFN Init_Sequential(
         UINT32 iVersion,
         UINT16 iColumns
         ) = 0;

   virtual DBIResult DBIFN Init(
         UINT32 iVersion,
         UINT16 iColumns,
         pDSDATAPACKETFLDDesc  pFieldDesc
         ) = 0;

   //Add an optional parameter
   virtual DBIResult DBIFN AddAttribute (
         PCKLATTRArea eAttrArea,
         pCCHAR pszAttr,
         UINT32 iType,
         UINT32 iLen,
         pBYTE pValue
         ) = 0;

   //Return pointer to the finished 'safearray'
   virtual DBIResult DBIFN GetDataPacket (
        SAFEARRAY  **ppSa
        ) = 0;

   // Get the size of the safearray.
   virtual DBIResult DBIFN GetSize(
        pUINT32  piDataPacketSize
        ) = 0;

   // Add this field to the data stream.
   virtual DBIResult DBIFN PutField (
        PCKLFldStauts eFldStatus,
        UINT32 iLen,
        pBYTE pSrc
        ) = 0;

   // Add a column descriptor.
   virtual DBIResult DBIFN AddColumnDesc(
        pDSDATAPACKETFLDDesc
        pFldDes
        ) = 0;

   // Reset all data (in order to create partial data)
   // Datapackets will not contain meta-info. Last created datapacket must be released by
   // caller.
   virtual DBIResult DBIFN Reset(VOID
        ) = 0;

   // Return number of fielddescriptors, including embedded tables etc.
   // (Same as iColumns above, only for external COM-users)
   virtual DBIResult DBIFN GetColumnCount(
        pUINT32 piCnt
        ) = 0;

   //Return all fielddescriptors
   // (Same as pFieldDesc above, only for external COM-users)
   virtual DBIResult DBIFN GetColumnDescs(
        pDSDATAPACKETFLDDesc pFldDes
        ) = 0;

   virtual DBIResult DBIFN GetErrorString(
        DBIResult iErrCode,
        pCHAR pString
        ) = 0;

   //Signals last row for a nested table, in case rowcount was not known in advance
   virtual DBIResult DBIFN EndOfNestedRows(
        VOID
        ) = 0;
        
   virtual DBIResult DBIFN SetXMLMode(INT iMode) = 0;

   virtual UINT32    DBIFN GetXMLMode(VOID) = 0;


} COMINTF;


class TDATAPACKET_READ
{
public:
   //Extracted values
   UINT16          iAttrCnt;       // Number of Global optional parameters defined
   UINT16          iColumns;
   UINT32          iRows;
   PCKLProps       iProperties;    // datapacket properties

   pDSDATAPACKETFLDDesc  pFieldDesc;

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

   virtual DBIResult DBIFN Init( //Initial datapacket, (must contain metadata)
         SAFEARRAY *pdatapacket
         ) = 0;

   // Adds additional 'partial' datapacket for extraction
   virtual DBIResult DBIFN AddDataPacket(
        SAFEARRAY *pdatapacket
        ) = 0;

   // Extract the next column descriptor.
   virtual DBIResult DBIFN GetColumnDesc(
        pDSDATAPACKETFLDDesc pFldDes
        ) = 0;

   // Extract length of next attribute
   virtual DBIResult DBIFN GetAttributeLength (
        pUINT32 piLength
        ) = 0;

   // Extract next attribute
   virtual DBIResult DBIFN GetNextAttribute (
        pCHAR pszAttribute,
        pUINT32 piType,
        pUINT32 piLen,
        pBYTE pValue
        ) = 0;

   // Get length of next field
   virtual DBIResult DBIFN GetFieldLength (
        pUINT32 piLength
        ) = 0;

   // Extract next field
   virtual DBIResult DBIFN GetField (
        pUINT32 piLength,
        pBYTE pValue,
        pBOOL pBlank
        ) = 0;

   virtual DBIResult DBIFN GetErrorString(
        DBIResult iErrCode,
        pCHAR pString
        ) = 0;

   virtual UINT32    DBIFN GetXMLMode(VOID) = 0;

} COMINTF;

#endif
