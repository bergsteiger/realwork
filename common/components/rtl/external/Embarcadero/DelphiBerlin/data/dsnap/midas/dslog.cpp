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

#ifdef _UNIX
#include <stdlib.h>
#else
#include <windows.h>
#endif
#include <string.h>
#pragma hdrstop

#include "filter.h"
#include "alchemy.h"
#include "alc_ds.h"
#include "ossrv.h"

// From dsref2.cpp
BOOL DBIFN RecordsAreEqual(DSBASE *pDs1, UINT32 iRecNo1, DSBASE *pDs2, UINT32 iRecNo2,
   BOOL bCmpBlobs, pBOOL pbSame);

DSLOG::DSLOG(UINT32 iInitialSize, pDSBASE pDs)
{
   iSize = 0;
   iLast = 0;
   this->pDs = pDs;
   pLogEntries = NULL;
   if (iInitialSize)
      GrowLog(iInitialSize);
   pSavePoints = NULL;
}

DSLOG::~DSLOG()
{
   if (pLogEntries)
      DsFree(pLogEntries);
   pLogEntries = NULL;
   if (pSavePoints)
      delete pSavePoints;
   pSavePoints = NULL;
}

DBIResult DSLOG::GrowLog(UINT32 iEntries) // Grow size of log
{
   pBYTE pTmp;
   UINT32 iNewSize = iSize + iEntries;

   pTmp = (pBYTE)DsRealloc((pVOID)pLogEntries,
      sizeof(LOGENTRY) * iSize, sizeof(LOGENTRY) * iNewSize);
   if (!pTmp)
      return DBIERR_NOMEMORY;
   pLogEntries = (LOGENTRY*)pTmp;

   iSize = iNewSize;
   return DBIERR_NONE;
}

DBIResult DSLOG::AddToLog(UINT32 iRecNo1, UINT32 iRecNo2, DSAttr iAttr, UINT32 iExtended)
{
   pLOGENTRY pEntry;

   if (iLast >= iSize)
   {
      GrowLog(16);
   }
   pEntry = &pLogEntries[iLast++];
   pEntry->iRecNo1 = iRecNo1;
   pEntry->iRecNo2 = iRecNo2;
   pEntry->iAttr = iAttr;
   if (iExtended)
      pEntry->iAttr = iExtended;
   return DBIERR_NONE;
}

DBIResult DSLOG::RemFromLog(VOID)
{
   if (iLast > 0)
   {
      iLast--;
      if (pSavePoints) // Maintain savepoints
         pSavePoints->AdjustSavePoints(iLast, 0);
      if (pDs && pDs->pDsParent)
      {
         pDs->pDsParent->GlobalLogUndo(pDs->iDetID, 0);
      }
   }
   return DBIERR_NONE;
}

DBIResult DSLOG::GetLogEntry(pUINT32 piRecNo1, pUINT32 piRecNo2, pDSAttr piAttr)
{
   pLOGENTRY pEntry;

   if (iLast > 0)
      pEntry = &(pLogEntries[iLast-1]);
   else
      return DBIERR_NA;

   if (piRecNo1)
      *piRecNo1 = pEntry->iRecNo1;
   if (piRecNo2)
      *piRecNo2 = pEntry->iRecNo2;
   if (piAttr)
      *piAttr = (DSAttr)pEntry->iAttr;
   return DBIERR_NONE;
}

// Compact log, in order to create delta
DBIResult DSLOG::CompactLog(DSLOG *pLogNew)
{
   DBIResult rslt = DBIERR_NONE;
   pBYTE pValid = (pBYTE)DsCalloc(1, iLast +1);
   UINT32 iRecNo, iRecNoOrg;
   UINT32 i, j;

   if (pLogNew == NULL || pValid == NULL)
   {
      rslt = DBIERR_NOMEMORY;
      goto Exit;
   }

   for (i = 0; i < iLast; i++)
   {
      if (pValid[i] != 0)
         continue; // This entry was already processed
      switch(pLogEntries[i].iAttr)
      {
      case dsRecNew:
         iRecNo = pLogEntries[i].iRecNo1;
         for (j = i+1; j < iLast; j++)
         { // Check if inserted record was modified or deleted
            if ((((DSAttr)pLogEntries[j].iAttr) && // Not an extended code
               (pLogEntries[j].iRecNo1 == iRecNo)) ||
               // Code below is for the case where details are
               // deleted after master has been inserted and posted
               // In that case iRecNo1 points to the original insert
               // and not to the modified record we check for above.
               (pLogEntries[j].iRecNo1 == pLogEntries[i].iRecNo1))
            {
               pValid[j] = 1; // Don't process this later
               if (pLogEntries[j].iAttr == dsRecDeleted)
               {
                  // Ignore the insert if deleted
                  goto Next; //
               }
            }
            else if (pLogEntries[j].iAttr == dsRecModified && pLogEntries[j].iRecNo2 == iRecNo)
            { // Modify
               pValid[j] = 1; // Don't process this later
               iRecNo = pLogEntries[j].iRecNo1;
            }
         }
         pLogNew->AddToLog(iRecNo, 0, dsRecNew, 0);
         break;

      case dsRecDeleted: // Not nescessary to check if record was inserted
         iRecNo = pLogEntries[i].iRecNo1;
         pLogNew->AddToLog(iRecNo, 0, dsRecDeleted, 0);
         break;

      case dsRecModified:
         iRecNoOrg = pLogEntries[i].iRecNo2; // old
         iRecNo = pLogEntries[i].iRecNo1; // new

         for (j = i+1; j < iLast; j++)
         { // Check if modified record was modified again or deleted

            if (((DSAttr)pLogEntries[j].iAttr) && // Not an extended code
               pLogEntries[j].iRecNo1 == iRecNo)
            {
               pValid[j] = 1; // Don't process this later
               if (pLogEntries[j].iAttr == dsRecDeleted)
               { // Delete the original
                  pLogNew->AddToLog(iRecNoOrg, 0, dsRecDeleted, 0);
                  goto Next; //
               }
            }
            else if (pLogEntries[j].iRecNo2 == iRecNo && pLogEntries[j].iAttr == dsRecModified)
            {
               pValid[j] = 1; // Don't process this later
               iRecNo = pLogEntries[j].iRecNo1;
            }
         }
         if (pDs == NULL || RecordsAreEqual(pDs, iRecNoOrg, pDs, iRecNo, TRUE, NULL) == FALSE)
         {
            pLogNew->AddToLog(iRecNo, iRecNoOrg, dsRecModified, 0);
         }
         break;

      case dsDetUpd:
         { // iRecNo1 is Master-RecNo, iRecNo2 is iDetID
            INT32 k;
            BOOL bIgnore = FALSE;

            iRecNoOrg = pLogEntries[i].iRecNo1;
            // Get original recordno if record was previously changed
            for (k = i-1; k >=0; k--)
            {
               if (pLogEntries[k].iAttr == dsRecModified && pLogEntries[k].iRecNo1 == iRecNoOrg)
               {
                  iRecNoOrg = pLogEntries[k].iRecNo2;
               }
            }
            // Do not add if there is already one in there !
            for (k = 0; k < (INT32)pLogNew->iLast; k++)
            {
               UINT32 iAttr = pLogNew->pLogEntries[k].iAttr;
               // If master was also updated, we can combine it with
               // its original record.
               // If master was inserted we can combine with that record
               if ((iAttr == dsDetUpd || iAttr == dsRecNew || iAttr == dsRecDeleted)
                  && pLogNew->pLogEntries[k].iRecNo1 == iRecNoOrg)
               {
                  bIgnore = TRUE;
                  break; // Ignore it
               }
               if (iAttr == dsRecNew)
               {
                  UINT32 itmp = this->GetPrevRecNo(pLogNew->pLogEntries[k].iRecNo1);
                  while (itmp)
                  {
                     if (itmp == iRecNoOrg)
                     {
                        bIgnore = TRUE;
                        break;
                     }
                     itmp = this->GetPrevRecNo(itmp);
                  }
                  if (bIgnore)
                     break;
               }

               if (iAttr == dsRecModified && pLogNew->pLogEntries[k].iRecNo2 == iRecNoOrg)
               {
                  bIgnore = TRUE;
                  break; // Ignore it
               }
            }

            // Check if org record is changed later (deleted or modified)
            UINT32 iLastModRecNo = iRecNoOrg;
            for (k = i+1; k < (INT32)iLast; k++)
            {
               UINT32 iAttr = pLogEntries[k].iAttr;

               if (bIgnore)
                  break;
               if ((iAttr == dsRecDeleted && pLogEntries[k].iRecNo1 == iRecNoOrg) ||
                  // Make sure the later log entry is for the same detail table.
                  ((iAttr == dsDetUpd) && (pLogEntries[k].iRecNo1 == iRecNoOrg) &&
                     (pLogEntries[k].iRecNo2 == pLogEntries[i].iRecNo2)))
               {
                  bIgnore = TRUE;
                  iLastModRecNo = iRecNoOrg;
               }
               // When scanning for modified records,
               // keep track of the last one we find so we
               // can later compare it to the original to see
               // if there were really any changes.
               else if (iAttr == dsRecModified && pLogEntries[k].iRecNo2 == iLastModRecNo)
               {
                  iLastModRecNo = pLogEntries[k].iRecNo1;
               }
            }
            // Make sure we have a modification before we ignore this detail update.
            if (iLastModRecNo != iRecNoOrg)
               bIgnore = !RecordsAreEqual(pDs, iRecNoOrg, pDs, iLastModRecNo, TRUE, NULL);

            // Before adding a dsDetUpd entry to
            // the compressed log, we must verify that the linked detail table
            // actually contains changes.  Otherwise we will have "false" delta
            // entries.
            if (!bIgnore)
            {
               DSBASE *pDsDet = pDs->pLinkedTables->GetEntry(pLogEntries[i].iRecNo2)->pDsDet;
               DSLOG *pDetLogNew = new DSLOG(pDsDet->pDsLog->iLast, NULL);
               bIgnore = (pDsDet->pDsLog->CompactLog(pDetLogNew) == DBIERR_NONE) && (pDetLogNew->iLast == 0);
               delete pDetLogNew;
            }

            if (!bIgnore)
               pLogNew->AddToLog(iRecNoOrg, 0, dsDetUpd, 0);
         }break;

      case dsDetInsFlyAway: // <RecNo1>Inserted record, or destination, <RecNo2> original master
         { // Inserted record (iRecNo1) must come before flyaway record(iRecNo2)
            UINT32 iPosI, iPosM;

            iPosI = pLogNew->GetOrgUpd(pLogEntries[i].iRecNo1, NULL);
            if (iPosI) // It was inserted
            {
               iPosM = pLogNew->GetOrgUpd(pLogEntries[i].iRecNo2, NULL);
               if (iPosM && iPosM < iPosI) //
               {
                  pLogNew->MoveEntry(iPosI-1, iPosM-1); // Move Insertion before modify
               }
            }
         }break;

      default:
         break;
      }
   Next: ;
   } // End for

Exit:
   DsFree(pValid);
   return rslt;
}

// Moves entry iNoFrom to iNoTo
// 0-based
DBIResult DSLOG::MoveEntry(UINT32 iNoFrom, UINT32 iNoTo)
{
   DBIResult rslt = DBIERR_NONE;
   LOGENTRY Entry;
   UINT32 iCnt, i;

   CopyMem(&Entry, &pLogEntries[iNoFrom], sizeof(LOGENTRY));
   // Remove entry
   iCnt = iLast - iNoFrom -1;
   if (iCnt)
   {
      CopyMem(&pLogEntries[iNoFrom], &pLogEntries[iNoFrom+1], iCnt*sizeof(LOGENTRY));
   }
   // Make space
   for (i = iLast-2; i >= iNoTo; i--)
   {
      CopyMem(&pLogEntries[i+1], &pLogEntries[i], sizeof(LOGENTRY));
      if (i == 0)
         break;
   }
   CopyMem(&pLogEntries[iNoTo], &Entry, sizeof(LOGENTRY));
   return rslt;
}

// Given record number of original action (insert/modify),
// return array of recordno's, which are copies (modified) of same record
// piCnt on entry contains the size of piRecNo-array
DBIResult DSLOG::RemoveAction(DSAttr iAttr, UINT32 iRecNo, pUINT32 piCnt, pUINT32 piRecNo, pUINT32 piLogPos)
{
   UINT32 bFnd = FALSE;
   UINT32 iFirst;
   INT32 i;

   *piCnt = 0;
   for (i = 0; i < (INT32)iLast; i++)
   {
      if (pLogEntries[i].iAttr != dsDetUpd && (pLogEntries[i].iRecNo1 == iRecNo || pLogEntries[i].iRecNo2 == iRecNo))
      {
         bFnd = TRUE;
         iFirst = i;
         break;
      }
   }
   if (!bFnd)
      return DBIERR_NA;

   switch(iAttr)
   {
   case 0: // Special attribute (dsDetInsFlyAway)
      RemoveEntry(iFirst); // Just remove it. It was just a hint.
      break;

   case dsRecNew: // iRecNo was the one inserted,
      // if this entry is a 'modified' entry, then we need to search
      // backwards to find the 'original' inserted record

      while (iRecNo /* pEntries[iFirst].iAttr == dsRecModified */ )
      {
         *piRecNo++ = iRecNo; // Save
         (*piCnt) += 1;
         iRecNo = pLogEntries[iFirst].iRecNo2; // original
         RemoveEntry(iFirst);
         if (piLogPos)
            *piLogPos++ = iFirst+1;
         if (iFirst == 0)
         { // No more!
            break;
         }
         if (iRecNo) // (modified, keep searching for original)
         {
            for (i = iFirst-1; i >= 0; i--)
            {
               if (pLogEntries[i].iRecNo1 == iRecNo)
               {
                  iFirst = i;
                  goto AgainNew;
               }
            }
            // Not found, done
            break;
         }
      AgainNew: ;
      }
      break;

   case dsDetUpd:
   case dsRecModified:
   case dsRecDeleted: // iRecNo is the original record, that was deleted.
      // if this entry is a modified record, we need to
      // search forward, until we find the deleted action

      *piRecNo++ = iRecNo; // Save
      (*piCnt) += 1;
      while (iRecNo /* pEntries[iFirst].iAttr == dsRecModified */ )
      {
         if (pLogEntries[iFirst].iAttr == dsRecModified)
            iRecNo = pLogEntries[iFirst].iRecNo1; // changed record
         else
            iRecNo = 0;
         RemoveEntry(iFirst);
         if (piLogPos)
            *piLogPos++ = iFirst+1;

         if (iRecNo) // (modified, keep searching for original)
         {
            *piRecNo++ = iRecNo; // Save
            (*piCnt) += 1;

            for (i = iFirst; i < (INT32)iLast; i++)
            {
               if ((pLogEntries[i].iRecNo1 == iRecNo && pLogEntries[i].iAttr == dsRecDeleted) || // Deleted
                  (pLogEntries[i].iRecNo2 == iRecNo && // Modified
                     pLogEntries[i].iAttr == dsRecModified))
               {
                  iFirst = i;
                  goto Again;
               }
            }
            // Not found, done
            break;
         }
      Again: ;
      } // While
      break;

   }

   if (pSavePoints) // Invalidate savepoints above iLast
      pSavePoints->AdjustSavePoints(iLast, 0);

   return DBIERR_NONE;
}

// Removes the entry from the log (0-based)
DBIResult DSLOG::RemoveEntry(UINT32 iEntry)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iCnt;

   if (iEntry >= iLast) // (iLast points to first free entry)
      return DBIERR_NA;

   if (pSavePoints) // Maintain savepoints
      pSavePoints->AdjustSavePoints(iEntry+1, -1);

   iCnt = iLast - iEntry -1;
   if (iCnt)
   {
      CopyMem(&pLogEntries[iEntry], &pLogEntries[iEntry+1], iCnt*sizeof(LOGENTRY));
   }
   else
   {
      ZeroMem(&pLogEntries[iEntry], sizeof(LOGENTRY));
   }
   if (pDs && pDs->pDsParent)
   {
      pDs->pDsParent->GlobalLogUndo(pDs->iDetID, iCnt);
   }
   iLast--;
   return rslt;
}

// Returns RecNo of previous version of 'iRecno', if any
UINT32 DSLOG::GetPrevRecNo(UINT32 iRecNo)
{
   UINT32 i;

   for (i = 0; i < iLast; i++)
   {
      if (pLogEntries[i].iRecNo1 == iRecNo && pLogEntries[i].iAttr & dsRecModified)
      {
         return pLogEntries[i].iRecNo2;
      }
   }
   return 0;
}

DBIResult DSLOG::GetSavePoint(pUINT32 piSavePoint)
{
   DBIResult rslt = DBIERR_NONE;

   if (iLast == 0) // No entries
   {
      *piSavePoint = 0;
      goto Exit; // Undoes everything
   }
   if (pSavePoints == NULL)
   {
      pSavePoints = new SAVEPOINTList();
   }
   rslt = pSavePoints->MakeSavePoint(iLast, piSavePoint);
Exit:
   return rslt;
}

SAVEPOINTList::SAVEPOINTList(VOID)
{
   Init(16, sizeof(SAVEPOINTEntry), 16);
   iGenSeqNos = 1;
}

SAVEPOINTList::~SAVEPOINTList(VOID)
{
}

// The log-pos is 1-based to conform to iLast, and iEntryId
DBIResult DBIFN SAVEPOINTList::MakeSavePoint( // Creates new savepoint, given
   UINT32 iPos, // 1-based (iLast)
   pUINT32 piSavePoint)
{
   DBIResult rslt = DBIERR_NONE;
   UINT32 iSavePoint = 0;
   SAVEPOINTEntry Entry;

   if (iPos != 0) // else iSavePoint is 0
   {
      UINT32 iId;
      pSAVEPOINTEntry pEntry;

      pEntry = (pSAVEPOINTEntry)GetEntry((UINT32)1);

      // Try to reuse
      for (iId = 1; iId <= iLast; iId++)
      {
         if (pEntry->iSeqNo != iGenSeqNos)
         { // Found invalid one
            pEntry->iSeqNo = iGenSeqNos;
            pEntry->iUseCount = 1;
            pEntry->iLogPos = iPos;
            goto Found;
         }
         if (pEntry->iLogPos == iPos)
         {
            pEntry->iUseCount++;
            goto Found;
         }
         pEntry++;
      }
      // Create new one
      Entry.iSeqNo = iGenSeqNos;
      Entry.iUseCount = 1;
      Entry.iLogPos = iPos;
      rslt = Add((pBYTE) &Entry, &iId);
   Found:
      iSavePoint = (iGenSeqNos << 16);
      iSavePoint += iId;
   }
   *piSavePoint = iSavePoint;
   return rslt;
}

pSAVEPOINTEntry DBIFN SAVEPOINTList::GetSavePointEntry(UINT32 iSavePoint)
{
   UINT32 iSeq = iSavePoint >> 16;
   pSAVEPOINTEntry pEntry = NULL;

   if (iSeq == iGenSeqNos)
   {
      UINT32 iId = iSavePoint & 0xffff; // Remove seq-number

      pEntry = (pSAVEPOINTEntry)GetEntry(iId);
      if (pEntry && pEntry->iSeqNo != iGenSeqNos)
      {
         pEntry = NULL;
      }
   }
   return pEntry;
}

INT32 DBIFN SAVEPOINTList::GetSavePointPos(UINT32 iSavePoint // Returns pos, given savepoint, -1 if invalid
   )
{
   pSAVEPOINTEntry pEntry = GetSavePointEntry(iSavePoint);

   if (pEntry)
      return pEntry->iLogPos;
   return(-1); // Invalid savepoint
}

DBIResult DBIFN SAVEPOINTList::AdjustSavePoints(UINT32 iPos, // 1-based
   INT32 iInc // Inc/Dec positions. If 0, invalidates all savepoints above iPos
   )
{
   DBIResult rslt = DBIERR_NONE;
   pSAVEPOINTEntry pEntry = (pSAVEPOINTEntry)GetEntry(1);
   UINT32 i;

   for (i = 0; i < iLast; i++)
   {
      if (pEntry->iSeqNo == iGenSeqNos) // (otherwise it is invalid)
      {
         if (iInc == 0)
         { // This is the current last pos
            if (iPos < pEntry->iLogPos)
               pEntry->iSeqNo = 0; // Invalidate it
         }
         else
         { // iPos = iEntryId (same as iLogPos)
            if (iPos <= pEntry->iLogPos)
               pEntry->iLogPos += iInc; // LogEntry was inserted (+)/removed (-1)
         }
      }
      pEntry++;
   }
   return rslt;
}

DBIResult DBIFN SAVEPOINTList::IncSeq()
{ // Invalidates all savepoints
   iGenSeqNos++;
   return DBIERR_NONE;
}

VOID DBIFN SAVEPOINTList::ReleaseSavePoint(UINT32 iSavePoint)
{
   pSAVEPOINTEntry pEntry = GetSavePointEntry(iSavePoint);

   if (pEntry && pEntry->iSeqNo == iGenSeqNos)
   {
      if (pEntry->iUseCount == 0 || --pEntry->iUseCount == 0)
         pEntry->iSeqNo = 0; // Invalidate;
   }
}

// Returns the first position in the stack where this record was modified/inserted
// (1-based)
// This tries to determines the order in which the action will happen in the delta-creation
// Returns original record no if any
UINT32 DSLOG::GetOrgUpd(UINT32 iRecNo, pUINT32 piRecNoOrg)
{
   UINT32 i, iEnd = iLast, iFound = 0, iFoundM = 0;

   // iFoundM is master-update/insert, which takes precedence, otherwise the entry is
   // created when the first detail is added.

Again:
   for (i = 0; i < iEnd; i++)
   {
      if (pLogEntries[i].iRecNo1 == iRecNo)
      {
         iFound = i +1; // Make it one-based, 0 means NOT FOUND
         if (pLogEntries[i].iAttr & dsRecNew || pLogEntries[i].iAttr & dsRecModified)
         {
            iFoundM = i+1;
         }
         if (pLogEntries[i].iRecNo2 && pLogEntries[i].iAttr & dsRecModified)
         {
            iRecNo = pLogEntries[i].iRecNo2;
            iEnd = i;
            goto Again;
         }
      }
   }

   if (piRecNoOrg)
      *piRecNoOrg = iRecNo;
   return iFoundM ? iFoundM : iFound;
}
