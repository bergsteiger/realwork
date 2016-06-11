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

#ifndef VARLIST_H
#define VARLIST_H

#include "bdetypes.h"

// Variable size array of 'objects'
class VARList
{
private:
   UINT32      iEntryLen;  // Size of an entry
protected:
   UINT32      iIds ;      // Create Id's
   UINT32      iSize;      // Capacity, number of entries
   UINT32      iDefInc;    // Grow with this amount
   DBIResult   DBIFN Grow(UINT32 iEntries); //Grow size
   VOID        Init(UINT32 iInitialSize, UINT32 iEntryLen, UINT32 iDefInc); // Initialize object
public:
   UINT32      iLast;      // Current number of entries
   pBYTE       pEntries;

   VARList(VOID);
   virtual ~VARList();

   pBYTE  DBIFN GetEntry(  // Returns pointer to Entry
             UINT32 iId
        );
   DBIResult DBIFN  Add(   // Add entry
            pBYTE pEntry,
            pUINT32 piId
        );
   DBIResult DBIFN  Drop(  // Drop entry
            UINT32 iId
        );
   virtual VOID      DBIFN  Reset(
            VOID
        );
};

#endif
