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

#define  DSPCKLINITSIZE          4 * 1024   // Default pickle block size.
#define  DSPCKLBLOBBLKSIZE       4 * 1024   // Default blob block size.


typedef DBIResult (DBIFN *pfPCKLXltFn) (
   pBYTE    pDest,             // Ptr to the destination buffer.
   UINT32   iFieldLength,      // Column length.
   pBYTE    pSource,           // Ptr to the source buffer.
   UINT32   iRowSize,          // Row size of the source record 
   UINT32   iRecs              // Number of records in the source buffer.
);
typedef pfPCKLXltFn *ppfPCKLXltFn;

typedef struct 
{
   pBYTE        pFldDescArea;      // Ptr to Column descriptor Area.
   pBYTE        pAttrCurrLoc;      // Ptr to Curr loc in Opt Param Area.
   UINT32       iRowSize;          // Size of the row
   UINT32       iRowsSpaceAvail;   // Total number of rows
   pBYTE        pBlobBuf;          // Buffer to store the blob data.
   pBYTE        pBlobCurrLoc;      // Ptr to Curr loc in Blob Area.
   UINT32       iBlobBufSize;      // Size of the blob buffer.
   pUINT32      pFldsOffset;       // Ptr to Info regarding fld offsets.
   pUINT32      pNoFldsAdded;      // Ptr to Info reg no. of colums added.
   ppfPCKLXltFn ppfXltFn;          // Translate functions for the fields.
} DSPCKLInfo;
typedef DSPCKLInfo *pDSPCKLInfo;

typedef struct 
{
   pBYTE        pAttrCurrLoc;      // Ptr to Curr loc in Opt Param Area.
   pBYTE        pBlobCurrLoc;      // Ptr to Curr loc in the Blob Area.
   pUINT32      pFldsOffset;       // Ptr to Info regarding fld offsets.
   ppfPCKLXltFn ppfXltFn;          // Translate functions for the fields.
} DSPCKLEXTRACTInfo;
typedef DSPCKLEXTRACTInfo *pDSPCKLEXTRACTInfo;


typedef struct DSPCKLHdrInfo
{
    UINT32  iCookie;           // Invariant cookie for dataset 
    UINT32  VersionNumber;     // = 100, means 1.00. 
    UINT32  iTotalSize;        // Total size of this datastream (pickle)
    UINT16  iBlocksTotal;      // Total number of blocks (normaly 1)
    UINT16  iBlockNo;          // This is current blocknumber (normaly 1)

    UINT16  iColumns;          // Number of columns
    UINT16  iParameters;       // Number of optional parameters
    UINT32  iRowsTotal;        // Total number of rows
    UINT32  iRows;             // Number of rows in this block
    UINT32  iBlobs;            // Number of blobs in this block

    UINT32  iSizeOfRows;       // Total Size of rows area
    UINT32  iSizeOfColDescs;   // Total size of column descriptor area
    UINT32  iSizeOfParameters; // Total size of optional parameters area
    UINT32  iSizeOfBlobs;      // Total size of Blobs area
} DSPCKLHDRInfo;
typedef DSPCKLHdrInfo *pDSPCKLHdrInfo;

typedef struct DSPCKLFLDDesc
{
    CHAR    szFieldName[31];   // Name of field
    UINT16  iFieldType;        // Type of data (BDE data type)
    UINT16  iFieldLength;      // Size of column
    UINT16  iAttributes;       //
} DSPCKLFLDDesc;
typedef  DSPCKLFLDDesc *pDSPCKLFLDDesc;

#ifdef __cplusplus
   }
#endif // __cplusplus

class DSPICKLE
{
public:

   UINT32   iAttrCnt;   // Number of attributes defined
   UINT32   iColumns;   // Number of columns
   UINT32   iRows;      // Number of rows
   UINT32   iBlobs;     // Number of blobs

   //Create 'structure' of streamed dataset
   DSPICKLE::DSPICKLE(UINT32 iVersion, UINT16 iColumns, pDSPCKLFLDDesc pFldDes);    
   DSPICKLE::~DSPICKLE(); 

   //Add an optional parameter
   DBIResult AddAttribute(
         pCHAR    pszAttr,     // attribute 
         UINT16   iType,       // type of attribute 
         UINT32   iLen,        // length of value 
         pBYTE    pValue);     // value 

   //Add a number of data-rows
   DBIResult AddRows(
         pUINT32  piCnt,       // Number of rows to add
         pBYTE    pRecs);      // Array of rows

   // Alternatively, add cloumnwise
   DBIResult AddCols(   
         UINT16   iColNo,      // Column number
         pUINT32  piCnt,       // Number of values to add to the given column
         pBYTE    pValues);    // Array of rows

   //Add a blob
   DBIResult AddBlob(
         UINT32   iRowNo,      // Belongs to this row
         UINT32   iFldNo,      //
         UINT32   iLength,     //
         pBYTE   pBlob);       //

   //Return pointer to the finished 'pickle'
   DBIResult GetPickle(pBYTE  *ppPickle);

private:
   pBYTE       pPickleBuf;        // Pickle buffer for streamed data.
   pDSPCKLInfo pdsPcklInfo;       // Pickle information.

   DBIResult InitializeDataArea();
   DBIResult GrowSize(UINT32 iSize);
};

class DSEXTRACT
{
public:
   //Extracted values
   UINT16          iAttrCnt;       // Number of attributes defined
   UINT16          iColumns;
   UINT32          iRows;
   UINT16          iBlobs;
   pDSPCKLFLDDesc  pFieldDesc;
   UINT16          iRowSize;       // Record size
   UINT16          iAttrCurrent;   // Extracting this attribute next
   UINT32          iRowCurrent;    // Extracting this row next
   UINT16          iBlobCurrent;   // Extracting this blob next

   DSEXTRACT::DSEXTRACT(pBYTE pPickle);
   DSEXTRACT::~DSEXTRACT();

   DBIResult GetAttributeLength(
         pUINT32  piLength);   // Get length of next attribute

   // Extract next attribute
   DBIResult GetNextAttribute(
         pCHAR    pszAttribute,   // Attribute
         pUINT16  piType ,        // Attribute type
         pUINT32  piLen  ,        // lenght of pValue buffer, if applicable
         pBYTE    pValue);        // value


   // Extracts next iCnt number of records
   DBIResult GetNextRow(
         pUINT32  piCnt,          // Number of records to retrieve
         pBYTE    pRows);         // Records

   DBIResult GetCols(
         UINT32   iRowNoStart,
         UINT16   iFldNo, 
         pUINT32  piCnt,          // Number of values to retrieve
         pBYTE    pValues);       // Values

   DBIResult GetBlobLength(
         pUINT32  piLength);      // Get length of next blob

   // Extract next blob-field
   DBIResult GetNextBlob(
         pUINT32 piRowNo,
         pUINT16 piFldNo,  
         pBYTE pBlob);            // Add a blobfield
private:
   pDSPCKLEXTRACTInfo   pdsExtractInfo;
};

#endif //PICKLE_H
