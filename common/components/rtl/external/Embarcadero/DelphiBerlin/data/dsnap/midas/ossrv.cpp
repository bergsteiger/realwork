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

#if defined(_UNIX)
#include "conv.h"
#include "locale.h"
#include <wctype.h>
#if defined(LINUX) && defined(__BORLANDC__) && !defined(__ANDROID__)
#include <wchar.h>
#endif
#if defined(__APPLE__)
#include <CoreFoundation/CFLocale.h>
#include <CoreFoundation/CFString.h>
#endif
#ifdef DEBUG
extern int errno;
#endif
#define SA_USE_MALLOC 1
#else
#include <windows.h>
#endif
#pragma hdrstop

#include "dscommn.h"
#include "ossrv.h"

#if defined(__ANDROID__)
#include "alchemy.h"
#endif

UINT32 iAllocCnt = 0;
UINT32 iFreeCnt = 0;
UINT32 iResizeSafeArrayCnt = 0;

#if defined(__ANDROID__)
#define WEAKATTR __attribute__((weak))
#else
#define WEAKATTR
#endif

int WEAKATTR iDayTable[2][13] =
               {
                  { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
                  { 0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
               };

pVOID DBIFN DsMalloc(UINT32 nbytes)
{
   pVOID pPtr;

   pPtr = (pVOID)malloc((size_t)nbytes);
#ifdef DEBUG
   if (pPtr != NULL)
   {
      iAllocCnt++;
   }
#endif
   return pPtr;
}

pVOID DBIFN DsCalloc(UINT32 nelem, UINT32 elsize)
{
   UINT32 msize;
   pVOID cp;

   msize = (UINT32)nelem * elsize;
   cp = DsMalloc(msize);
   if (cp)
   {
      ZeroMem(cp, msize);
   }
   return(cp);
}

VOID DBIFN DsFree(pVOID q)
{
   if (q != NULL)
   {
#ifdef DEBUG
      iFreeCnt++;
#endif
      free(q);
   }
}

pVOID DBIFN DsRealloc(pVOID pPtr, UINT32 iSize, UINT32 iNewSize)
{
   pVOID pTmp;
   if (!pPtr)
      return DsCalloc(1, iNewSize);
   pTmp = (pVOID)realloc(pPtr, (size_t)iNewSize);
   if (pTmp && iNewSize > iSize)
      ZeroMem((char*)pTmp + iSize, iNewSize - iSize);
   return pTmp;
}

#if defined(_UNIX)

HRESULT SafeArrayAllocDescriptor(UINT32 iSize, pSAFEARRAY * ppSafeArray)
{
   HRESULT iResult = 0;
   UNREFERENCED_PARAMETER(iSize);
   (*ppSafeArray) = (pSAFEARRAY)DsCalloc(1, sizeof(SAFEARRAY));
   if ((*ppSafeArray) == NULL)
      iResult = E_OUTOFMEMORY;
   (*ppSafeArray)->cDims = 1;
   return iResult;
}

HRESULT SafeArrayAllocData(pSAFEARRAY pSafeArray)
{
   HRESULT iResult = 0;
   if (pSafeArray == NULL)
      iResult = E_INVALIDARG;
   else
   {
      UINT32 iSize = pSafeArray->cbElements * pSafeArray->rgsabound[0].cElements;
#ifdef SA_USE_MALLOC
      pSafeArray->pvData = malloc(iSize);
      if (!(pSafeArray->pvData))
         iResult = E_OUTOFMEMORY;
#else
      pSafeArray->ShmId = shmget(IPC_PRIVATE, iSize, (SHM_R | SHM_W));
      if ((pCHAR)(pSafeArray->ShmId) == (pCHAR) -1)
      {
         iResult = E_OUTOFMEMORY;
      }
#endif
   }
   return iResult;
}

HRESULT SafeArrayDestroy(pSAFEARRAY pSafeArray)
{
   HRESULT iResult = 0;
   if (pSafeArray == NULL || pSafeArray->pvData == NULL)
      iResult = E_INVALIDARG;
   else
#ifdef SA_USE_MALLOC
      if (pSafeArray->pvData)
   {
      free(pSafeArray->pvData);
      pSafeArray->pvData = NULL;
   }
#else
   {
      int i;
      for (i = 0; i < pSafeArray->cLocks; i++)
         SafeArrayUnaccessData(pSafeArray);
      iResult = shmctl(pSafeArray->ShmId, IPC_RMID, 0);
      if (iResult = 0)
         pSafeArray->pvData = NULL;
   }
#endif
   return iResult;
}

HRESULT SafeArrayDestroyDescriptor(pSAFEARRAY pSafeArray)
{
   HRESULT iResult = 0;
   if (pSafeArray == NULL)
      iResult = E_INVALIDARG;
   else
   {
      SafeArrayDestroy(pSafeArray);
      DsFree((pVOID)pSafeArray);
   }
   return iResult;
}

HRESULT SafeArrayAccessData(pSAFEARRAY pSafeArray, pVOID * ppData)
{
   HRESULT iResult = 0;
   if (pSafeArray == NULL)
      iResult = E_INVALIDARG;
   else
   {
#ifdef SA_USE_MALLOC
      *ppData = pSafeArray->pvData;
#else
      (*ppData) = NULL;
      // detach from data
      if (((pSafeArray->pvData = shmat(pSafeArray->ShmId, 0, 0)) == (void*) -1))
         iResult = iResult = E_OUTOFMEMORY;
      else
      {
         (*ppData) = pSafeArray->pvData;
         pSafeArray->cLocks++;
      }
#endif
   }
   return iResult;
}

HRESULT SafeArrayUnaccessData(pSAFEARRAY pSafeArray)
{
   HRESULT iResult = 0;
#ifndef SA_USE_MALLOC
   if (pSafeArray == NULL)
      iResult = E_INVALIDARG;
   else
   {
      if (pSafeArray->pvData != NULL)
         shmdt(pSafeArray->pvData); // detach from data
      if (iResult == 0)
         pSafeArray->cLocks--;
   }
#else
   UNREFERENCED_PARAMETER(pSafeArray);
#endif
   return iResult;
}

HRESULT SafeArrayCopy(SAFEARRAY * pSourceSA, pSAFEARRAY * ppTargetSA)
{
   SAFEARRAY * pSa;
   HRESULT iResult;
   iResult = SafeArrayAllocDescriptor(1, &pSa);
   if (iResult)
      return iResult;
   pSa->cbElements = pSourceSA->cbElements;
   pSa->rgsabound[0].lLbound = pSourceSA->rgsabound[0].lLbound;
   pSa->rgsabound[0].cElements = pSourceSA->rgsabound[0].cElements;
   iResult = SafeArrayAllocData(pSa);
   if (iResult)
      SafeArrayDestroyDescriptor(pSa);
   else
   {
#ifdef SA_USE_MALLOC
      UINT32 iSize = pSourceSA->cbElements * pSourceSA->rgsabound[0].cElements;
      memcpy(pSa->pvData, pSourceSA->pvData, iSize);
      *(ppTargetSA) = pSa;
#else
      for (int i = 0; i < pSourceSA->cLocks; i++)
         SafeArrayUnaccessData(pSourceSA);
      if (pSourceSA->cLocks > 0)
      {
         SafeArrayDestroyDescriptor(pSa);
         iResult = DISP_E_ARRAYISLOCKED;
      }
      else
      {
         pSourceSA->pvData = (pVOID)shmat(pSourceSA->ShmId, 0, 0);
         if (pSourceSA->pvData != (void*) -1)
            pSa->pvData = (pVOID)shmat(pSa->ShmId, 0, 0);
         if (pSourceSA->pvData == (void*) -1 || pSa->pvData == (void*) -1)
         {
            iResult = E_OUTOFMEMORY;
            SafeArrayDestroyDescriptor(pSa);
         }
         else
         {
            UINT32 iSize = pSourceSA->cbElements * pSourceSA->rgsabound[0].cElements;
            memcpy(pSa->pvData, pSourceSA->pvData, iSize);
            shmdt(pSourceSA->pvData);
            shmdt(pSa->pvData);
            *(ppTargetSA) = pSa;
         }
      }
#endif
   }
   return iResult;
}

// change the right-most bound of a safe array
// pSafeArray: pointer to old SafeArray
// paBound: pointer to SafeArrayBound struct which replaces old
HRESULT SafeArrayRedim(pSAFEARRAY pSafeArray, SAFEARRAYBOUND * paBound)
{
   HRESULT iResult = 0;
   if (pSafeArray == NULL)
      iResult = E_INVALIDARG;
   else
   {
      for (int i = 0; i < (int)pSafeArray->cLocks; i++)
         SafeArrayUnaccessData(pSafeArray);
      if (pSafeArray->cLocks > 0)
         iResult = DISP_E_ARRAYISLOCKED;
      else
      {
         pSAFEARRAY pTempSA;
         SafeArrayCopy(pSafeArray, &pTempSA);
         // get new identifier for shared memory:
         // new size contained in paBound->cElements;
         SafeArrayDestroy(pSafeArray);
         pSafeArray->rgsabound[0] = *paBound;
         iResult = SafeArrayAllocData(pSafeArray);
         if (!iResult)
         {
            // attach to shared memory
            iResult = SafeArrayAccessData(pSafeArray, (VOID **)(&(pSafeArray->pvData)));
            if (!iResult)
               iResult = SafeArrayAccessData(pTempSA, (VOID **)(&(pTempSA->pvData)));
            else
               SafeArrayUnaccessData(pSafeArray);
            if (!iResult)
            {
               // copy in all of old value that fits
               UINT32 iSize = (paBound->cElements < pTempSA->rgsabound[0].cElements) ? (paBound->cElements) :
                  (pTempSA->rgsabound[0].cElements);
               memcpy(pSafeArray->pvData, pTempSA->pvData, iSize);
               SafeArrayUnaccessData(pSafeArray);
               SafeArrayUnaccessData(pTempSA);
            }
            SafeArrayDestroyDescriptor(pTempSA);
         }
      }
   }
   return iResult;
}

HRESULT SafeArrayGetUBound(SAFEARRAY * pSa, UINT32 nDim, INT32 * piSize)
{
   if (!pSa)
      return E_INVALIDARG;
   if (!piSize)
      return E_INVALIDARG;
   *piSize = pSa->rgsabound[nDim - 1].cElements;
   return S_OK;
}
#endif

// Initializes, and returns Safearray descriptor
// Returns buffer of 'iInitial size'. NULL if out of memory
// The buffer is LOCKED, and needs to be unlocked by calling 'Truncate'
// before passing array to other subsystem
pVOID DBIFN SAInit(UINT32 iInitialSize, SAFEARRAY **ppSa)
{
   pVOID pBuf = NULL;

   if (ppSa && SafeArrayAllocDescriptor(1, ppSa) == 0)
   {
      (*ppSa)->cbElements = 1;
      (*ppSa)->rgsabound[0].lLbound = 0;
      (*ppSa)->rgsabound[0].cElements = iInitialSize;
      if (SafeArrayAllocData(*ppSa) != 0)
      {
         SafeArrayDestroyDescriptor(*ppSa);
      }
      else
      {
         SafeArrayAccessData(*ppSa, &pBuf); // Lock data
      }
   }
   return pBuf;
}

// Deallocates safearray descriptor, and memory
VOID DBIFN SAExit(SAFEARRAY *pSa)
{
   if (pSa)
   {
      SafeArrayDestroy(pSa);
   }
}

// Get and lock data pointer
pVOID DBIFN SAGetPtr(SAFEARRAY *pSa)
{
   pVOID pBuf = NULL;
   if (pSa)
      SafeArrayAccessData(pSa, &pBuf); // Lock data
   return pBuf;
}

// Unlock data pointer (used if SAGetPtr was used)
VOID DBIFN SARelPtr(SAFEARRAY *pSa)
{
   if (pSa)
      SafeArrayUnaccessData(pSa); // Unlock data
}

// Reallocates array, and returns pointer
// If bUnlock is TRUE, resizes, and returns NULL (buffer not accesible)
pVOID DBIFN SAResize(SAFEARRAY *pSa, UINT32 iSize, BOOL bUnlock)
{
   pVOID pBuf = NULL;

   if (pSa)
   {
#ifdef DEBUG
      iResizeSafeArrayCnt++;
#endif
      SAFEARRAYBOUND SaBound;
      SafeArrayUnaccessData(pSa);

      SaBound.cElements = iSize;
      SaBound.lLbound = 0;
      if (SafeArrayRedim(pSa, &SaBound) == 0 && bUnlock == FALSE)
         SafeArrayAccessData(pSa, &pBuf);
   }
   return pBuf;
}

#define SARealloc(pSa, iSize) SAResize(pSa, iSize, FALSE)
#define SATruncate(pSa, iSize) SAResize(pSa, iSize, TRUE)

#if defined(_UNIX)
// code from Pascal (Borland Intl team)

typedef void* Pointer;
typedef void* Var;
typedef const void* Const;
// typedef wchar_t*      pUCS2Char;
typedef char** iconvdest_t;

unsigned short Hash(const unsigned char *name)
{
   unsigned long h = 0, g;

   while (*name)
   {
      h = (h << 4) + *name++;
      g = h & 0xF0000000;
      if (g)
         h ^= g >> 24;
      h &= ~g;
   }
   return h % 0xFFFF;
}

int XLocaleToLCID(pCHAR XLocale)
{
   int iResult = DEFAULT_LCID;

   switch(Hash((const unsigned char*)XLocale))
   {
   case 0x0137:
      if (strcmp(XLocale, "sv_FI_AL") == 0)
         iResult = 0x081D;
      break;
   case 0x02E4:
      if (strcmp(XLocale, "de_LU_EURO") == 0)
         iResult = 0x1007;
      break;
   case 0x0671:
      if (strcmp(XLocale, "aa") == 0)
         iResult = 0x0400;
      break;
   case 0x0672:
      if (strcmp(XLocale, "ab") == 0)
         iResult = 0x0400;
      break;
   case 0x0676:
      if (strcmp(XLocale, "af") == 0)
         iResult = 0x0436;
      break;
   case 0x067D:
      if (strcmp(XLocale, "am") == 0)
         iResult = 0x0400;
      break;
   case 0x0681:
      if (strcmp(XLocale, "ba") == 0)
         iResult = 0x0400;
      break;
   case 0x0682:
      if (strcmp(XLocale, "ar") == 0)
         iResult = 0x0401;
      break;
   case 0x0683:
      if (strcmp(XLocale, "as") == 0)
         iResult = 0x044D;
      break;
   case 0x0685:
      if (strcmp(XLocale, "be") == 0)
         iResult = 0x0423;
      break;
   case 0x0687:
      if (strcmp(XLocale, "bg") == 0)
         iResult = 0x0402;
      break;
   case 0x0688:
      if (strcmp(XLocale, "bh") == 0)
         iResult = 0x0400;
      break;
   case 0x0689:
      if (strcmp(XLocale, "ay") == 0)
      {
         iResult = 0x0400;
         break;
      }
      else if (strcmp(XLocale, "bi") == 0)
         iResult = 0x0400;
      break;
   case 0x068A:
      if (strcmp(XLocale, "az") == 0)
         iResult = 0x042C;
      break;
   case 0x068E:
      if (strcmp(XLocale, "bn") == 0)
         iResult = 0x0445;
      break;
   case 0x068F:
      if (strcmp(XLocale, "bo") == 0)
         iResult = 0x0400;
      break;
   case 0x0691:
      if (strcmp(XLocale, "ca") == 0)
         iResult = 0x0403;
      break;
   case 0x0692:
      if (strcmp(XLocale, "br") == 0)
         iResult = 0x0400;
      break;
   case 0x069F:
      if (strcmp(XLocale, "co") == 0)
         iResult = 0x0400;
      break;
   case 0x06A1:
      if (strcmp(XLocale, "da") == 0)
         iResult = 0x0406;
      break;
   case 0x06A3:
      if (strcmp(XLocale, "cs") == 0)
         iResult = 0x0405;
      break;
   case 0x06A5:
      if (strcmp(XLocale, "de") == 0)
         iResult = 0x0407;
      break;
   case 0x06A9:
      if (strcmp(XLocale, "cy") == 0)
         iResult = 0x0400;
      break;
   case 0x06BA:
      if (strcmp(XLocale, "dz") == 0)
         iResult = 0x0400;
      break;
   case 0x06BC:
      if (strcmp(XLocale, "el") == 0)
         iResult = 0x0408;
      break;
   case 0x06BE:
      if (strcmp(XLocale, "en") == 0)
         iResult = 0x0409;
      break;
   case 0x06BF:
      if (strcmp(XLocale, "eo") == 0)
         iResult = 0x0400;
      break;
   case 0x06C1:
      if (strcmp(XLocale, "fa") == 0)
         iResult = 0x0429;
      break;
   case 0x06C3:
      if (strcmp(XLocale, "es") == 0)
         iResult = 0x040A;
      break;
   case 0x06C4:
      if (strcmp(XLocale, "et") == 0)
         iResult = 0x0425;
      break;
   case 0x06C5:
      if (strcmp(XLocale, "eu") == 0)
         iResult = 0x042D;
      break;
   case 0x06C9:
      if (strcmp(XLocale, "fi") == 0)
         iResult = 0x040B;
      break;
   case 0x06CA:
      if (strcmp(XLocale, "fj") == 0)
         iResult = 0x0400;
      break;
   case 0x06CF:
      if (strcmp(XLocale, "fo") == 0)
         iResult = 0x0438;
      break;
   case 0x06D1:
      if (strcmp(XLocale, "ga") == 0)
         iResult = 0x0400;
      break;
   case 0x06D2:
      if (strcmp(XLocale, "fr") == 0)
         iResult = 0x040C;
      break;
   case 0x06D4:
      if (strcmp(XLocale, "gd") == 0)
         iResult = 0x043C;
      break;
   case 0x06D9:
      if (strcmp(XLocale, "fy") == 0)
         iResult = 0x0400;
      break;
   case 0x06DC:
      if (strcmp(XLocale, "gl") == 0)
         iResult = 0x0400;
      break;
   case 0x06DE:
      if (strcmp(XLocale, "gn") == 0)
         iResult = 0x0400;
      break;
   case 0x06E1:
      if (strcmp(XLocale, "ha") == 0)
         iResult = 0x0400;
      break;
   case 0x06E5:
      if (strcmp(XLocale, "gu") == 0)
      {
         iResult = 0x0447;
         break;
      }
      else if (strcmp(XLocale, "he") == 0)
         iResult = 0x040D;
      break;
   case 0x06E6:
      if (strcmp(XLocale, "gv") == 0)
         iResult = 0x0400;
      break;
   case 0x06E9:
      if (strcmp(XLocale, "hi") == 0)
         iResult = 0x0439;
      break;
   case 0x06F1:
      if (strcmp(XLocale, "ia") == 0)
         iResult = 0x0400;
      break;
   case 0x06F2:
      if (strcmp(XLocale, "hr") == 0)
         iResult = 0x041A;
      break;
   case 0x06F4:
      if (strcmp(XLocale, "id") == 0)
         iResult = 0x0421;
      break;
   case 0x06F5:
      if (strcmp(XLocale, "hu") == 0)
      {
         iResult = 0x040E;
         break;
      }
      else if (strcmp(XLocale, "ie") == 0)
         iResult = 0x0400;
      break;
   case 0x06F9:
      if (strcmp(XLocale, "hy") == 0)
         iResult = 0x042B;
      break;
   case 0x06FB:
      if (strcmp(XLocale, "ik") == 0)
         iResult = 0x0400;
      break;
   case 0x06FE:
      if (strcmp(XLocale, "in") == 0)
         iResult = 0x0421;
      break;
   case 0x0701:
      if (strcmp(XLocale, "ja") == 0)
         iResult = 0x0411;
      break;
   case 0x0703:
      if (strcmp(XLocale, "is") == 0)
         iResult = 0x040F;
      break;
   case 0x0704:
      if (strcmp(XLocale, "it") == 0)
         iResult = 0x0410;
      break;
   case 0x0705:
      if (strcmp(XLocale, "iu") == 0)
         iResult = 0x0400;
      break;
   case 0x0707:
      if (strcmp(XLocale, "iw") == 0)
         iResult = 0x040D;
      break;
   case 0x0709:
      if (strcmp(XLocale, "ji") == 0)
         iResult = 0x043D;
      break;
   case 0x0711:
      if (strcmp(XLocale, "ka") == 0)
         iResult = 0x0437;
      break;
   case 0x0716:
      if (strcmp(XLocale, "jv") == 0)
         iResult = 0x0400;
      break;
   case 0x071B:
      if (strcmp(XLocale, "kk") == 0)
         iResult = 0x0400;
      break;
   case 0x071C:
      if (strcmp(XLocale, "kl") == 0)
         iResult = 0x0400;
      break;
   case 0x071D:
      if (strcmp(XLocale, "km") == 0)
         iResult = 0x0400;
      break;
   case 0x071E:
      if (strcmp(XLocale, "kn") == 0)
         iResult = 0x044B;
      break;
   case 0x071F:
      if (strcmp(XLocale, "ko") == 0)
         iResult = 0x0412;
      break;
   case 0x0721:
      if (strcmp(XLocale, "la") == 0)
         iResult = 0x0400;
      break;
   case 0x0723:
      if (strcmp(XLocale, "ks") == 0)
         iResult = 0x0460;
      break;
   case 0x0725:
      if (strcmp(XLocale, "ku") == 0)
         iResult = 0x0400;
      break;
   case 0x0727:
      if (strcmp(XLocale, "kw") == 0)
         iResult = 0x0400;
      break;
   case 0x0729:
      if (strcmp(XLocale, "ky") == 0)
         iResult = 0x0400;
      break;
   case 0x072E:
      if (strcmp(XLocale, "ln") == 0)
         iResult = 0x0400;
      break;
   case 0x072F:
      if (strcmp(XLocale, "lo") == 0)
         iResult = 0x0400;
      break;
   case 0x0734:
      if (strcmp(XLocale, "lt") == 0)
         iResult = 0x0427;
      break;
   case 0x0736:
      if (strcmp(XLocale, "lv") == 0)
         iResult = 0x0426;
      break;
   case 0x0737:
      if (strcmp(XLocale, "mg") == 0)
         iResult = 0x0400;
      break;
   case 0x0739:
      if (strcmp(XLocale, "mi") == 0)
         iResult = 0x0400;
      break;
   case 0x073B:
      if (strcmp(XLocale, "mk") == 0)
         iResult = 0x042F;
      break;
   case 0x073C:
      if (strcmp(XLocale, "ml") == 0)
         iResult = 0x044C;
      break;
   case 0x073E:
      if (strcmp(XLocale, "mn") == 0)
         iResult = 0x0400;
      break;
   case 0x073F:
      if (strcmp(XLocale, "mo") == 0)
         iResult = 0x0400;
      break;
   case 0x0741:
      if (strcmp(XLocale, "na") == 0)
         iResult = 0x0400;
      break;
   case 0x0742:
      if (strcmp(XLocale, "mr") == 0)
      {
         iResult = 0x044E;
         break;
      }
      else if (strcmp(XLocale, "nb") == 0)
         iResult = 0x0414;
      break;
   case 0x0743:
      if (strcmp(XLocale, "ms") == 0)
         iResult = 0x043E;
      break;
   case 0x0744:
      if (strcmp(XLocale, "mt") == 0)
         iResult = 0x043A;
      break;
   case 0x0745:
      if (strcmp(XLocale, "ne") == 0)
         iResult = 0x0461;
      break;
   case 0x0749:
      if (strcmp(XLocale, "my") == 0)
         iResult = 0x0400;
      break;
   case 0x074C:
      if (strcmp(XLocale, "nl") == 0)
         iResult = 0x0413;
      break;
   case 0x074E:
      if (strcmp(XLocale, "nn") == 0)
         iResult = 0x0814;
      break;
   case 0x074F:
      if (strcmp(XLocale, "no") == 0)
         iResult = 0x0414;
      break;
   case 0x0753:
      if (strcmp(XLocale, "oc") == 0)
         iResult = 0x0400;
      break;
   case 0x075D:
      if (strcmp(XLocale, "om") == 0)
         iResult = 0x0400;
      break;
   case 0x0761:
      if (strcmp(XLocale, "pa") == 0)
         iResult = 0x0446;
      break;
   case 0x0762:
      if (strcmp(XLocale, "or") == 0)
         iResult = 0x0448;
      break;
   case 0x076C:
      if (strcmp(XLocale, "pl") == 0)
         iResult = 0x0415;
      break;
   case 0x0773:
      if (strcmp(XLocale, "ps") == 0)
         iResult = 0x0401;
      break;
   case 0x0774:
      if (strcmp(XLocale, "pt") == 0)
         iResult = 0x0816;
      break;
   case 0x0785:
      if (strcmp(XLocale, "qu") == 0)
         iResult = 0x0400;
      break;
   case 0x078D:
      if (strcmp(XLocale, "rm") == 0)
         iResult = 0x0417;
      break;
   case 0x078E:
      if (strcmp(XLocale, "rn") == 0)
         iResult = 0x0400;
      break;
   case 0x078F:
      if (strcmp(XLocale, "ro") == 0)
         iResult = 0x0418;
      break;
   case 0x0791:
      if (strcmp(XLocale, "sa") == 0)
         iResult = 0x044F;
      break;
   case 0x0792:
      if (strcmp(XLocale, "sb") == 0)
         iResult = 0x042E;
      break;
   case 0x0794:
      if (strcmp(XLocale, "sd") == 0)
         iResult = 0x0459;
      break;
   case 0x0795:
      if (strcmp(XLocale, "ru") == 0)
         iResult = 0x0419;
      break;
   case 0x0797:
      if (strcmp(XLocale, "rw") == 0)
      {
         iResult = 0x0400;
         break;
      }
      else if (strcmp(XLocale, "sg") == 0)
         iResult = 0x0400;
      break;
   case 0x0798:
      if (strcmp(XLocale, "sh") == 0)
         iResult = 0x041A;
      break;
   case 0x0799:
      if (strcmp(XLocale, "si") == 0)
         iResult = 0x0400;
      break;
   case 0x079B:
      if (strcmp(XLocale, "sk") == 0)
         iResult = 0x041B;
      break;
   case 0x079C:
      if (strcmp(XLocale, "sl") == 0)
         iResult = 0x0424;
      break;
   case 0x079D:
      if (strcmp(XLocale, "sm") == 0)
         iResult = 0x0400;
      break;
   case 0x079E:
      if (strcmp(XLocale, "sn") == 0)
         iResult = 0x0400;
      break;
   case 0x079F:
      if (strcmp(XLocale, "so") == 0)
         iResult = 0x0400;
      break;
   case 0x07A1:
      if (strcmp(XLocale, "sq") == 0)
      {
         iResult = 0x041C;
         break;
      }
      else if (strcmp(XLocale, "ta") == 0)
         iResult = 0x0449;
      break;
   case 0x07A2:
      if (strcmp(XLocale, "sr") == 0)
         iResult = 0x0C1A;
      break;
   case 0x07A3:
      if (strcmp(XLocale, "ss") == 0)
         iResult = 0x0400;
      break;
   case 0x07A4:
      if (strcmp(XLocale, "st") == 0)
         iResult = 0x0400;
      break;
   case 0x07A5:
      if (strcmp(XLocale, "su") == 0)
      {
         iResult = 0x0400;
         break;
      }
      else if (strcmp(XLocale, "te") == 0)
         iResult = 0x044A;
      break;
   case 0x07A6:
      if (strcmp(XLocale, "sv") == 0)
         iResult = 0x041D;
      break;
   case 0x07A7:
      if (strcmp(XLocale, "sw") == 0)
      {
         iResult = 0x0441;
         break;
      }
      else if (strcmp(XLocale, "tg") == 0)
         iResult = 0x0400;
      break;
   case 0x07A8:
      if (strcmp(XLocale, "sx") == 0)
      {
         iResult = 0x0430;
         break;
      }
      else if (strcmp(XLocale, "th") == 0)
         iResult = 0x041E;
      break;
   case 0x07A9:
      if (strcmp(XLocale, "ti") == 0)
         iResult = 0x0400;
      break;
   case 0x07AB:
      if (strcmp(XLocale, "tk") == 0)
         iResult = 0x0400;
      break;
   case 0x07AC:
      if (strcmp(XLocale, "tl") == 0)
         iResult = 0x0400;
      break;
   case 0x07AE:
      if (strcmp(XLocale, "tn") == 0)
         iResult = 0x0432;
      break;
   case 0x07AF:
      if (strcmp(XLocale, "to") == 0)
         iResult = 0x0400;
      break;
   case 0x07B2:
      if (strcmp(XLocale, "tr") == 0)
         iResult = 0x041F;
      break;
   case 0x07B3:
      if (strcmp(XLocale, "ts") == 0)
         iResult = 0x0431;
      break;
   case 0x07B4:
      if (strcmp(XLocale, "tt") == 0)
         iResult = 0x0444;
      break;
   case 0x07B7:
      if (strcmp(XLocale, "tw") == 0)
      {
         iResult = 0x0400;
         break;
      }
      else if (strcmp(XLocale, "ug") == 0)
         iResult = 0x0400;
      break;
   case 0x07BB:
      if (strcmp(XLocale, "uk") == 0)
         iResult = 0x0422;
      break;
   case 0x07C2:
      if (strcmp(XLocale, "ur") == 0)
         iResult = 0x0420;
      break;
   case 0x07C9:
      if (strcmp(XLocale, "vi") == 0)
         iResult = 0x042A;
      break;
   case 0x07CA:
      if (strcmp(XLocale, "uz") == 0)
         iResult = 0x0443;
      break;
   case 0x07CF:
      if (strcmp(XLocale, "vo") == 0)
         iResult = 0x0400;
      break;
   case 0x07DF:
      if (strcmp(XLocale, "wo") == 0)
         iResult = 0x0400;
      break;
   case 0x07E8:
      if (strcmp(XLocale, "xh") == 0)
         iResult = 0x0434;
      break;
   case 0x07F9:
      if (strcmp(XLocale, "yi") == 0)
         iResult = 0x0400;
      break;
   case 0x07FF:
      if (strcmp(XLocale, "yo") == 0)
         iResult = 0x0400;
      break;
   case 0x0801:
      if (strcmp(XLocale, "za") == 0)
         iResult = 0x0400;
      break;
   case 0x0804:
      if (strcmp(XLocale, "de_AT_EURO") == 0)
         iResult = 0x0C07;
      break;
   case 0x0808:
      if (strcmp(XLocale, "zh") == 0)
         iResult = 0x0404;
      break;
   case 0x0815:
      if (strcmp(XLocale, "zu") == 0)
         iResult = 0x0435;
      break;
   case 0x0A14:
      if (strcmp(XLocale, "de_DE_EURO") == 0)
         iResult = 0x0407;
      break;
   case 0x0A17:
      if (strcmp(XLocale, "ar@bahrain") == 0)
         iResult = 0x5401;
      break;
   case 0x148F:
      if (strcmp(XLocale, "mk_MK") == 0)
         iResult = 0x042F;
      break;
   case 0x14F5:
      if (strcmp(XLocale, "sk_SK") == 0)
         iResult = 0x041B;
      break;
   case 0x150D:
      if (strcmp(XLocale, "uk_UA") == 0)
         iResult = 0x0422;
      break;
   case 0x1848:
      if (strcmp(XLocale, "kana") == 0)
         iResult = 0x0411;
      break;
   case 0x1B04:
      if (strcmp(XLocale, "kok_IN") == 0)
         iResult = 0x0457;
      break;
   case 0x23D3:
      if (strcmp(XLocale, "nl_AN") == 0)
         iResult = 0x0413;
      break;
   case 0x23DA:
      if (strcmp(XLocale, "nl_BE") == 0)
         iResult = 0x0813;
      break;
   case 0x2411:
      if (strcmp(XLocale, "gl_ES") == 0)
         iResult = 0x0400;
      break;
   case 0x242E:
      if (strcmp(XLocale, "el_GR") == 0)
      {
         iResult = 0x0408;
         break;
      }
      else if (strcmp(XLocale, "kl_GL") == 0)
         iResult = 0x0400;
      break;
   case 0x24A1:
      if (strcmp(XLocale, "nl_NL") == 0)
         iResult = 0x0413;
      break;
   case 0x24C3:
      if (strcmp(XLocale, "pl_PL") == 0)
         iResult = 0x0415;
      break;
   case 0x24F3:
      if (strcmp(XLocale, "sl_SI") == 0)
         iResult = 0x0424;
      break;
   case 0x40EF:
      if (strcmp(XLocale, "no@nynorsk") == 0)
         iResult = 0x0814;
      break;
   case 0x43CF:
      if (strcmp(XLocale, "en_AS") == 0)
         iResult = 0x2409;
      break;
   case 0x43D1:
      if (strcmp(XLocale, "en_AU") == 0)
      {
         iResult = 0x0C09;
         break;
      }
      else if (strcmp(XLocale, "en_BE") == 0)
         iResult = 0x0C09;
      break;
   case 0x43DD:
      if (strcmp(XLocale, "en_CA") == 0)
         iResult = 0x1009;
      break;
   case 0x43E3:
      if (strcmp(XLocale, "en_BW") == 0)
         iResult = 0x0C09;
      break;
   case 0x43E6:
      if (strcmp(XLocale, "en_BZ") == 0)
         iResult = 0x2809;
      break;
   case 0x441E:
      if (strcmp(XLocale, "en_GB") == 0)
         iResult = 0x0809;
      break;
   case 0x4441:
      if (strcmp(XLocale, "en_IE") == 0)
         iResult = 0x1809;
      break;
   case 0x4459:
      if (strcmp(XLocale, "en_JM") == 0)
         iResult = 0x2009;
      break;
   case 0x44A4:
      if (strcmp(XLocale, "nn_NO") == 0)
         iResult = 0x0814;
      break;
   case 0x44A6:
      if (strcmp(XLocale, "en_NZ") == 0)
         iResult = 0x1409;
      break;
   case 0x44B4:
      if (strcmp(XLocale, "en_PH") == 0)
         iResult = 0x3409;
      break;
   case 0x44E3:
      if (strcmp(XLocale, "en_SG") == 0)
         iResult = 0x1409;
      break;
   case 0x4500:
      if (strcmp(XLocale, "en_TT") == 0)
         iResult = 0x2C09;
      break;
   case 0x4507:
      if (strcmp(XLocale, "en_UK") == 0)
         iResult = 0x0809;
      break;
   case 0x450F:
      if (strcmp(XLocale, "en_US") == 0)
         iResult = 0x0409;
      break;
   case 0x454D:
      if (strcmp(XLocale, "en_ZA") == 0)
         iResult = 0x1C09;
      break;
   case 0x4563:
      if (strcmp(XLocale, "en_ZW") == 0)
         iResult = 0x3009;
      break;
   case 0x47F4:
      if (strcmp(XLocale, "ca_ES_EURO") == 0)
         iResult = 0x0403;
      break;
   case 0x5367:
      if (strcmp(XLocale, "es@castilian") == 0)
         iResult = 0x040A;
      break;
   case 0x541C:
      if (strcmp(XLocale, "fo_FO") == 0)
         iResult = 0x0438;
      break;
   case 0x5471:
      if (strcmp(XLocale, "ko_KO") == 0)
         iResult = 0x0412;
      break;
   case 0x5472:
      if (strcmp(XLocale, "ko_KP") == 0)
         iResult = 0x0412;
      break;
   case 0x5474:
      if (strcmp(XLocale, "ko_KR") == 0)
         iResult = 0x0412;
      break;
   case 0x5498:
      if (strcmp(XLocale, "ro_MO") == 0)
         iResult = 0x0818;
      break;
   case 0x54A4:
      if (strcmp(XLocale, "no_NO") == 0)
         iResult = 0x0414;
      break;
   case 0x54E8:
      if (strcmp(XLocale, "ro_RO") == 0)
         iResult = 0x0418;
      break;
   case 0x5539:
      if (strcmp(XLocale, "sr@cyrillic") == 0)
         iResult = 0x0C1A;
      break;
   case 0x5AAC:
      if (strcmp(XLocale, "no_NO_NY") == 0)
         iResult = 0x0814;
      break;
   case 0x6461:
      if (strcmp(XLocale, "jp_JP") == 0)
         iResult = 0x0411;
      break;
   case 0x6DF4:
      if (strcmp(XLocale, "es_ES_EURO") == 0)
         iResult = 0x0C0A;
      break;
   case 0x7054:
      if (strcmp(XLocale, "fi_FI_EURO") == 0)
         iResult = 0x040B;
      break;
   case 0x725B:
      if (strcmp(XLocale, "kok") == 0)
         iResult = 0x0457;
      break;
   case 0x73D6:
      if (strcmp(XLocale, "sq_AL") == 0)
         iResult = 0x041C;
      break;
   case 0x73E4:
      if (strcmp(XLocale, "fr_LU_EURO") == 0)
         iResult = 0x140C;
      break;
   case 0x73F5:
      if (strcmp(XLocale, "da_DK") == 0)
         iResult = 0x0406;
      break;
   case 0x740C:
      if (strcmp(XLocale, "ca_ES") == 0)
         iResult = 0x0403;
      break;
   case 0x7442:
      if (strcmp(XLocale, "ga_IE") == 0)
         iResult = 0x0400;
      break;
   case 0x744E:
      if (strcmp(XLocale, "fa_IR") == 0)
         iResult = 0x0429;
      break;
   case 0x7458:
      if (strcmp(XLocale, "ta_IN") == 0)
         iResult = 0x0449;
      break;
   case 0x7460:
      if (strcmp(XLocale, "ja_JP") == 0)
         iResult = 0x0411;
      break;
   case 0x7914:
      if (strcmp(XLocale, "fr_BE_EURO") == 0)
         iResult = 0x080C;
      break;
   case 0x7C14:
      if (strcmp(XLocale, "en_IE_EURO") == 0)
         iResult = 0x1809;
      break;
   case 0x7CE2:
      if (strcmp(XLocale, "no@bokmal") == 0)
         iResult = 0x0414;
      break;
   case 0x7DE4:
      if (strcmp(XLocale, "fr_FR_EURO") == 0)
         iResult = 0x040C;
      break;
   case 0x83BD:
      if (strcmp(XLocale, "ar_AE") == 0)
         iResult = 0x3801;
      break;
   case 0x83BE:
      if (strcmp(XLocale, "ar_AF") == 0)
         iResult = 0x0401;
      break;
   case 0x83D0:
      if (strcmp(XLocale, "ar_BH") == 0)
         iResult = 0x3C01;
      break;
   case 0x83D2:
      if (strcmp(XLocale, "fr_BE") == 0)
         iResult = 0x080C;
      break;
   case 0x83DE:
      if (strcmp(XLocale, "fr_CA") == 0)
         iResult = 0x0C0C;
      break;
   case 0x83E5:
      if (strcmp(XLocale, "fr_CH") == 0)
         iResult = 0x100C;
      break;
   case 0x83E6:
      if (strcmp(XLocale, "fr_CI") == 0)
         iResult = 0x040C;
      break;
   case 0x83FF:
      if (strcmp(XLocale, "ar_EG") == 0)
         iResult = 0x0C01;
      break;
   case 0x8402:
      if (strcmp(XLocale, "ar_DZ") == 0)
         iResult = 0x1401;
      break;
   case 0x841F:
      if (strcmp(XLocale, "fr_FR") == 0)
         iResult = 0x040C;
      break;
   case 0x8423:
      if (strcmp(XLocale, "fr_GF") == 0)
         iResult = 0x040C;
      break;
   case 0x8425:
      if (strcmp(XLocale, "fr_FX") == 0)
         iResult = 0x040C;
      break;
   case 0x8441:
      if (strcmp(XLocale, "hr_HR") == 0)
      {
         iResult = 0x041A;
         break;
      }
      else if (strcmp(XLocale, "fr_HT") == 0)
         iResult = 0x040C;
      break;
   case 0x8449:
      if (strcmp(XLocale, "ar_IQ") == 0)
         iResult = 0x0801;
      break;
   case 0x844A:
      if (strcmp(XLocale, "ar_IR") == 0)
         iResult = 0x0401;
      break;
   case 0x8452:
      if (strcmp(XLocale, "mr_IN") == 0)
         iResult = 0x044E;
      break;
   case 0x8457:
      if (strcmp(XLocale, "ar_JO") == 0)
         iResult = 0x2C01;
      break;
   case 0x845A:
      if (strcmp(XLocale, "ur_IN") == 0)
         iResult = 0x0820;
      break;
   case 0x846A:
      if (strcmp(XLocale, "ar_LB") == 0)
         iResult = 0x3001;
      break;
   case 0x846F:
      if (strcmp(XLocale, "ar_KW") == 0)
         iResult = 0x3401;
      break;
   case 0x8479:
      if (strcmp(XLocale, "ar_MA") == 0)
         iResult = 0x1801;
      break;
   case 0x8480:
      if (strcmp(XLocale, "fr_MC") == 0)
         iResult = 0x180C;
      break;
   case 0x8481:
      if (strcmp(XLocale, "ar_LY") == 0)
         iResult = 0x1001;
      break;
   case 0x8482:
      if (strcmp(XLocale, "fr_LU") == 0)
         iResult = 0x140C;
      break;
   case 0x848E:
      if (strcmp(XLocale, "fr_MQ") == 0)
         iResult = 0x040C;
      break;
   case 0x84A3:
      if (strcmp(XLocale, "nb_NO") == 0)
         iResult = 0x0414;
      break;
   case 0x84A5:
      if (strcmp(XLocale, "ar_OM") == 0)
         iResult = 0x2001;
      break;
   case 0x84B3:
      if (strcmp(XLocale, "fr_PF") == 0)
         iResult = 0x040C;
      break;
   case 0x84B9:
      if (strcmp(XLocale, "ar_QA") == 0)
         iResult = 0x4001;
      break;
   case 0x84C7:
      if (strcmp(XLocale, "ur_PK") == 0)
         iResult = 0x0420;
      break;
   case 0x84D9:
      if (strcmp(XLocale, "ar_SA") == 0)
         iResult = 0x0401;
      break;
   case 0x84DC:
      if (strcmp(XLocale, "ar_SD") == 0)
         iResult = 0x0401;
      break;
   case 0x84F1:
      if (strcmp(XLocale, "ar_SY") == 0)
         iResult = 0x2801;
      break;
   case 0x84F3:
      if (strcmp(XLocale, "fr_TF") == 0)
         iResult = 0x040C;
      break;
   case 0x84F6:
      if (strcmp(XLocale, "ar_TN") == 0)
         iResult = 0x1C01;
      break;
   case 0x850D:
      if (strcmp(XLocale, "tr_TR") == 0)
         iResult = 0x041F;
      break;
   case 0x8522:
      if (strcmp(XLocale, "no@bokm=E5l") == 0)
         iResult = 0x0414;
      break;
   case 0x853D:
      if (strcmp(XLocale, "ar_YE") == 0)
         iResult = 0x2401;
      break;
   case 0x855F:
      if (strcmp(XLocale, "sr_YU") == 0)
         iResult = 0x0C1A;
      break;
   case 0x93C0:
      if (strcmp(XLocale, "es_AD") == 0)
         iResult = 0x040A;
      break;
   case 0x93CE:
      if (strcmp(XLocale, "es_AR") == 0)
         iResult = 0x2C0A;
      break;
   case 0x93D0:
      if (strcmp(XLocale, "sr@latin") == 0)
         iResult = 0x081A;
      break;
   case 0x93DB:
      if (strcmp(XLocale, "es_BO") == 0)
         iResult = 0x400A;
      break;
   case 0x93E2:
      if (strcmp(XLocale, "ms_BN") == 0)
         iResult = 0x083E;
      break;
   case 0x93E8:
      if (strcmp(XLocale, "es_CL") == 0)
         iResult = 0x340A;
      break;
   case 0x93EB:
      if (strcmp(XLocale, "es_CO") == 0)
         iResult = 0x240A;
      break;
   case 0x93EE:
      if (strcmp(XLocale, "es_CR") == 0)
         iResult = 0x140A;
      break;
   case 0x93F1:
      if (strcmp(XLocale, "es_CU") == 0)
         iResult = 0x040A;
      break;
   case 0x93F4:
      if (strcmp(XLocale, "cs_CZ") == 0)
         iResult = 0x0405;
      break;
   case 0x93FB:
      if (strcmp(XLocale, "es_DO") == 0)
         iResult = 0x1C0A;
      break;
   case 0x93FF:
      if (strcmp(XLocale, "es_EC") == 0)
         iResult = 0x300A;
      break;
   case 0x940F:
      if (strcmp(XLocale, "es_ES") == 0)
         iResult = 0x0C0A;
      break;
   case 0x9430:
      if (strcmp(XLocale, "es_GT") == 0)
         iResult = 0x100A;
      break;
   case 0x943A:
      if (strcmp(XLocale, "es_HN") == 0)
         iResult = 0x480A;
      break;
   case 0x9450:
      if (strcmp(XLocale, "ks_IN") == 0)
         iResult = 0x0860;
      break;
   case 0x9453:
      if (strcmp(XLocale, "is_IS") == 0)
         iResult = 0x040F;
      break;
   case 0x9494:
      if (strcmp(XLocale, "es_MX") == 0)
         iResult = 0x080A;
      break;
   case 0x9495:
      if (strcmp(XLocale, "es_NI") == 0)
         iResult = 0x4C0A;
      break;
   case 0x949D:
      if (strcmp(XLocale, "ms_MY") == 0)
         iResult = 0x043E;
      break;
   case 0x94AD:
      if (strcmp(XLocale, "es_PA") == 0)
         iResult = 0x180A;
      break;
   case 0x94B1:
      if (strcmp(XLocale, "es_PE") == 0)
         iResult = 0x280A;
      break;
   case 0x94BE:
      if (strcmp(XLocale, "es_PR") == 0)
         iResult = 0x500A;
      break;
   case 0x94C5:
      if (strcmp(XLocale, "es_PY") == 0)
         iResult = 0x3C0A;
      break;
   case 0x94F2:
      if (strcmp(XLocale, "es_SV") == 0)
         iResult = 0x440A;
      break;
   case 0x950F:
      if (strcmp(XLocale, "es_US") == 0)
         iResult = 0x440A;
      break;
   case 0x9511:
      if (strcmp(XLocale, "es_VE") == 0)
         iResult = 0x200A;
      break;
   case 0x9515:
      if (strcmp(XLocale, "es_UY") == 0)
         iResult = 0x380A;
      break;
   case 0x9AF0:
      if (strcmp(XLocale, "az@latin") == 0)
         iResult = 0x082C;
      break;
   case 0x9BB0:
      if (strcmp(XLocale, "uz@latin") == 0)
         iResult = 0x0443;
      break;
   case 0x9BC2:
      if (strcmp(XLocale, "lt@classic") == 0)
         iResult = 0x0427;
      break;
   case 0xA3E8:
      if (strcmp(XLocale, "it_CH") == 0)
         iResult = 0x0810;
      break;
   case 0xA3E9:
      if (strcmp(XLocale, "pt_BR") == 0)
         iResult = 0x0416;
      break;
   case 0xA401:
      if (strcmp(XLocale, "et_EE") == 0)
         iResult = 0x0425;
      break;
   case 0xA443:
      if (strcmp(XLocale, "id_ID") == 0)
         iResult = 0x0421;
      break;
   case 0xA454:
      if (strcmp(XLocale, "it_IT") == 0)
         iResult = 0x0410;
      break;
   case 0xA487:
      if (strcmp(XLocale, "lt_LT") == 0)
         iResult = 0x0427;
      break;
   case 0xA498:
      if (strcmp(XLocale, "mt_MT") == 0)
         iResult = 0x043A;
      break;
   case 0xA4CB:
      if (strcmp(XLocale, "pt_PT") == 0)
         iResult = 0x0816;
      break;
   case 0xA511:
      if (strcmp(XLocale, "it_VA") == 0)
         iResult = 0x0410;
      break;
   case 0xAF03:
      if (strcmp(XLocale, "it_IT_EURO") == 0)
         iResult = 0x0410;
      break;
   case 0xB3CE:
      if (strcmp(XLocale, "de_AT") == 0)
         iResult = 0x0C07;
      break;
   case 0xB3E1:
      if (strcmp(XLocale, "be_BY") == 0)
         iResult = 0x0423;
      break;
   case 0xB3E2:
      if (strcmp(XLocale, "de_CH") == 0)
         iResult = 0x0807;
      break;
   case 0xB3EF:
      if (strcmp(XLocale, "de_DE") == 0)
         iResult = 0x0407;
      break;
   case 0xB40F:
      if (strcmp(XLocale, "eu_ES") == 0)
         iResult = 0x042D;
      break;
   case 0xB444:
      if (strcmp(XLocale, "hu_HU") == 0)
         iResult = 0x040E;
      break;
   case 0xB44A:
      if (strcmp(XLocale, "he_IL") == 0)
         iResult = 0x040D;
      break;
   case 0xB452:
      if (strcmp(XLocale, "ne_IN") == 0)
         iResult = 0x0861;
      break;
   case 0xB458:
      if (strcmp(XLocale, "te_IN") == 0)
         iResult = 0x044A;
      break;
   case 0xB473:
      if (strcmp(XLocale, "de_LI") == 0)
         iResult = 0x1407;
      break;
   case 0xB47F:
      if (strcmp(XLocale, "de_LU") == 0)
         iResult = 0x1007;
      break;
   case 0xB498:
      if (strcmp(XLocale, "ru_MO") == 0)
         iResult = 0x0819;
      break;
   case 0xB4EE:
      if (strcmp(XLocale, "ru_RU") == 0)
         iResult = 0x0419;
      break;
   case 0xB50A:
      if (strcmp(XLocale, "ru_UA") == 0)
         iResult = 0x0419;
      break;
   case 0xC420:
      if (strcmp(XLocale, "gv_GB") == 0)
         iResult = 0x0400;
      break;
   case 0xC423:
      if (strcmp(XLocale, "sv_FI") == 0)
         iResult = 0x081D;
      break;
   case 0xC489:
      if (strcmp(XLocale, "lv_LV") == 0)
         iResult = 0x0426;
      break;
   case 0xC4EF:
      if (strcmp(XLocale, "sv_SE") == 0)
         iResult = 0x041D;
      break;
   case 0xC500:
      if (strcmp(XLocale, "sv_SV") == 0)
         iResult = 0x041D;
      break;
   case 0xC548:
      if (strcmp(XLocale, "af_ZA") == 0)
         iResult = 0x0436;
      break;
   case 0xC843:
      if (strcmp(XLocale, "es@modern") == 0)
         iResult = 0x0C0A;
      break;
   case 0xD3CF:
      if (strcmp(XLocale, "bg_BG") == 0)
         iResult = 0x0402;
      break;
   case 0xD424:
      if (strcmp(XLocale, "kw_GB") == 0)
         iResult = 0x0400;
      break;
   case 0xD44C:
      if (strcmp(XLocale, "iw_IL") == 0)
         iResult = 0x040D;
      break;
   case 0xD46F:
      if (strcmp(XLocale, "sw_KE") == 0)
         iResult = 0x0441;
      break;
   case 0xD514:
      if (strcmp(XLocale, "sw_TZ") == 0)
         iResult = 0x0441;
      break;
   case 0xD52B:
      if (strcmp(XLocale, "az@cyrillic") == 0)
         iResult = 0x042C;
      break;
   case 0xD537:
      if (strcmp(XLocale, "uz@cyrillic") == 0)
         iResult = 0x0843;
      break;
   case 0xD5D3:
      if (strcmp(XLocale, "pt_PT_EURO") == 0)
         iResult = 0x0816;
      break;
   case 0xE3FE:
      if (strcmp(XLocale, "zh_CN") == 0)
         iResult = 0x0804;
      break;
   case 0xE44B:
      if (strcmp(XLocale, "zh_HK") == 0)
         iResult = 0x0C04;
      break;
   case 0xE49F:
      if (strcmp(XLocale, "zh_MO") == 0)
         iResult = 0x1404;
      break;
   case 0xE4F4:
      if (strcmp(XLocale, "sh_SK") == 0)
         iResult = 0x041A;
      break;
   case 0xE4F7:
      if (strcmp(XLocale, "zh_SG") == 0)
         iResult = 0x1004;
      break;
   case 0xE4F9:
      if (strcmp(XLocale, "sh_SP") == 0)
         iResult = 0x041A;
      break;
   case 0xE502:
      if (strcmp(XLocale, "th_TH") == 0)
         iResult = 0x041E;
      break;
   case 0xE517:
      if (strcmp(XLocale, "zh_TW") == 0)
         iResult = 0x0404;
      break;
   case 0xE55E:
      if (strcmp(XLocale, "sh_YU") == 0)
         iResult = 0x081A;
      break;
   case 0xF138:
      if (strcmp(XLocale, "en@caribbean") == 0)
         iResult = 0x2409;
      break;
   case 0xF415:
      if (strcmp(XLocale, "fi_FI") == 0)
         iResult = 0x040B;
      break;
   case 0xF44C:
      if (strcmp(XLocale, "hi_IN") == 0)
         iResult = 0x0439;
      break;
   case 0xF52A:
      if (strcmp(XLocale, "vi_VN") == 0)
         iResult = 0x042A;
      break;
   case 0xFB53:
      if (strcmp(XLocale, "nl_NL_EURO") == 0)
         iResult = 0x0413;
      break;
   case 0xFF13:
      if (strcmp(XLocale, "nl_BE_EURO") == 0)
         iResult = 0x0813;
      break;
   }
   return iResult;
}

const char *TheXLocale, *TheXCurrent = NULL;
char *ThePrevLocale = NULL;

int TheXCount = 0, TheXIndex = 0;

char *DefaultXLocale()
{
   return setlocale(LC_ALL, NULL);
}

bool SavePrevXLocale(void)
{
   char *ALocale;
   bool Result;
   ALocale = setlocale(LC_ALL, NULL);
   Result = (bool)ALocale;
   if (Result)
   {
      ThePrevLocale = (char*)malloc(strlen(ALocale) + 1);
      Result = (bool)ThePrevLocale;
      if (Result)
         strcpy(ThePrevLocale, ALocale);
   }
   return Result;
}

void RestorePrevXLocale(void)
{
   if (ThePrevLocale)
   {
      setlocale(LC_ALL, ThePrevLocale);
      free(ThePrevLocale);
      ThePrevLocale = NULL;
   }
}

void RewindXLocale(void)
{
   TheXIndex = 0;
   TheXCurrent = TheXLocale;
}

const char *CurrentXLocale(void)
{
   return TheXCurrent;
}

const char *NextXLocale(void)
{
   TheXIndex++;
   if (TheXIndex > TheXCount) // 0 points to NULL, 1 to first elt...
      RewindXLocale();
   else
      while (*TheXCurrent++);
   return TheXCurrent;
}

bool IsValidLocale(LCID lcid, DWORD dwFlags)
{
   static LCID TheLcid = 0;
   static bool TheResult = FALSE;

   if (dwFlags == LCID_INSTALLED)
   {
      if (lcid == TheLcid)
         return TheResult;

      TheResult = FALSE;

      if (SavePrevXLocale())
      {
         LcidToXLocale(lcid);
         while (NextXLocale())
         {
            if (setlocale(LC_ALL, TheXCurrent))
            {
               TheResult = (bool)CurrentXLocale();
               TheLcid = lcid;
               break;
            }
         }
         RestorePrevXLocale();
      }
   }
   else if (dwFlags == LCID_SUPPORTED)
   {
      LcidToXLocale(lcid);
      TheResult = (bool)TheXCount;
   }

   return TheResult;
}

int LcidToXLocale(int lcid)
{
   switch(lcid)
   {
   case 0x0400:
      TheXLocale = "\0" "aa" "\0" "ab" "\0" "am" "\0" "ay" "\0" "ba" "\0" // 5
      "bh" "\0" "bi" "\0" "bo" "\0" "br" "\0" "co" "\0" // 10
      "cy" "\0" "dz" "\0" "eo" "\0" "fj" "\0" "fy" "\0" // 15
      "ga" "\0" "ga_IE" "\0" "gl" "\0" "gl_ES" "\0" "gn" "\0" // 20
      "gv" "\0" "gv_GB" "\0" "ha" "\0" "ia" "\0" "ie" "\0" // 25
      "ik" "\0" "iu" "\0" "jv" "\0" "kk" "\0" "kl" "\0" // 30
      "kl_GL" "\0" "km" "\0" "ku" "\0" "kw" "\0" "kw_GB" "\0" // 35
      "ky" "\0" "la" "\0" "ln" "\0" "lo" "\0" "mg" "\0" // 40
      "mi" "\0" "mn" "\0" "mo" "\0" "my" "\0" "na" "\0" // 45
      "oc" "\0" "om" "\0" "qu" "\0" "rn" "\0" "rw" "\0" // 50
      "sg" "\0" "si" "\0" "sm" "\0" "sn" "\0" "so" "\0" // 55
      "ss" "\0" "st" "\0" "su" "\0" "tg" "\0" "ti" "\0" // 60
      "tk" "\0" "tl" "\0" "to" "\0" "tw" "\0" "ug" "\0" // 65
      "vo" "\0" "wo" "\0" "yi" "\0" "yo" "\0" "za" "\0"; // 70
      TheXCount = 70;
      break;
   case 0x0401:
      TheXLocale = "\0" "ar" "\0" "ar_IR" "\0" "ar_SA" "\0" "ar_SD" "\0" "ar_AF" "\0" // 5
      "ps" "\0";
      TheXCount = 6;
      break;
   case 0x0402:
      TheXLocale = "\0" "bg" "\0" "bg_BG" "\0";
      TheXCount = 2;
      break;
   case 0x0403:
      TheXLocale = "\0" "ca" "\0" "ca_ES" "\0" "ca_ES_EURO" "\0";
      TheXCount = 3;
      break;
   case 0x0404:
      TheXLocale = "\0" "zh" "\0" "zh_TW" "\0";
      TheXCount = 2;
      break;
   case 0x0405:
      TheXLocale = "\0" "cs" "\0" "cs_CZ" "\0";
      TheXCount = 2;
      break;
   case 0x0406:
      TheXLocale = "\0" "da" "\0" "da_DK" "\0";
      TheXCount = 2;
      break;
   case 0x0407:
      TheXLocale = "\0" "de" "\0" "de_DE" "\0" "de_DE_EURO" "\0";
      TheXCount = 3;
      break;
   case 0x0408:
      TheXLocale = "\0" "el" "\0" "el_GR" "\0";
      TheXCount = 2;
      break;
   case 0x0409:
      TheXLocale = "\0" "en" "\0" "en_US" "\0";
      TheXCount = 2;
      break;
   case 0x040A:
      TheXLocale = "\0" "es_CU" "\0" "es" "\0" "es@castilian" "\0" "es_AD" "\0";
      TheXCount = 4;
      break;
   case 0x040B:
      TheXLocale = "\0" "fi" "\0" "fi_FI" "\0" "fi_FI_EURO" "\0";
      TheXCount = 3;
      break;
   case 0x040C:
      TheXLocale = "\0" "fr" "\0" "fr_CI" "\0" "fr_FR" "\0" "fr_FR_EURO" "\0" "fr_FX" "\0" // 5
      "fr_GF" "\0" "fr_HT" "\0" "fr_MQ" "\0" "fr_PF" "\0" "fr_TF" "\0"; // 10
      TheXCount = 10;
      break;
   case 0x040D:
      TheXLocale = "\0" "he" "\0" "he_IL" "\0" "iw" "\0" "iw_IL" "\0";
      TheXCount = 4;
      break;
   case 0x040E:
      TheXLocale = "\0" "hu" "\0" "hu_HU" "\0";
      TheXCount = 2;
      break;
   case 0x040F:
      TheXLocale = "\0" "is" "\0" "is_IS" "\0";
      TheXCount = 2;
      break;
   case 0x0410:
      TheXLocale = "\0" "it" "\0" "it_IT" "\0" "it_IT_EURO" "\0" "it_VA" "\0";
      TheXCount = 4;
      break;
   case 0x0411:
      TheXLocale = "\0" "ja" "\0" "ja_JP" "\0" "jp_JP" "\0" "kana" "\0";
      TheXCount = 4;
      break;
   case 0x0412:
      TheXLocale = "\0" "ko" "\0" "ko_KO" "\0" "ko_KP" "\0" "ko_KR" "\0";
      TheXCount = 4;
      break;
   case 0x0413:
      TheXLocale = "\0" "nl" "\0" "nl_AN" "\0" "nl_NL" "\0" "nl_NL_EURO" "\0";
      TheXCount = 4;
      break;
   case 0x0414:
      TheXLocale = "\0" "nb" "\0" "nb_NO" "\0" "no" "\0" "no@bokmal" "\0" "no@bokm=E5l" "\0" // 5
      "no_NO" "\0";
      TheXCount = 6;
      break;
   case 0x0415:
      TheXLocale = "\0" "pl" "\0" "pl_PL" "\0";
      TheXCount = 2;
      break;
   case 0x0416:
      TheXLocale = "\0" "pt_BR" "\0";
      TheXCount = 1;
      break;
   case 0x0417:
      TheXLocale = "\0" "rm" "\0";
      TheXCount = 1;
      break;
   case 0x0418:
      TheXLocale = "\0" "ro" "\0" "ro_RO" "\0";
      TheXCount = 2;
      break;
   case 0x0419:
      TheXLocale = "\0" "ru" "\0" "ru_RU" "\0" "ru_UA" "\0";
      TheXCount = 3;
      break;
   case 0x041A:
      TheXLocale = "\0" "hr" "\0" "hr_HR" "\0" "sh" "\0" "sh_SK" "\0" "sh_SP" "\0"; // 5
      TheXCount = 5;
      break;
   case 0x041B:
      TheXLocale = "\0" "sk" "\0" "sk_SK" "\0";
      TheXCount = 2;
      break;
   case 0x041C:
      TheXLocale = "\0" "sq" "\0" "sq_AL" "\0";
      TheXCount = 2;
      break;
   case 0x041D:
      TheXLocale = "\0" "sv" "\0" "sv_SE" "\0" "sv_SV" "\0";
      TheXCount = 3;
      break;
   case 0x041E:
      TheXLocale = "\0" "th" "\0" "th_TH" "\0";
      TheXCount = 2;
      break;
   case 0x041F:
      TheXLocale = "\0" "tr" "\0" "tr_TR" "\0";
      TheXCount = 2;
      break;
   case 0x0420:
      TheXLocale = "\0" "ur" "\0" "ur_PK" "\0";
      TheXCount = 2;
      break;
   case 0x0421:
      TheXLocale = "\0" "id" "\0" "id_ID" "\0" "in" "\0";
      TheXCount = 3;
      break;
   case 0x0422:
      TheXLocale = "\0" "uk" "\0" "uk_UA" "\0";
      TheXCount = 2;
      break;
   case 0x0423:
      TheXLocale = "\0" "be" "\0" "be_BY" "\0";
      TheXCount = 2;
      break;
   case 0x0424:
      TheXLocale = "\0" "sl" "\0" "sl_SI" "\0";
      TheXCount = 2;
      break;
   case 0x0425:
      TheXLocale = "\0" "et" "\0" "et_EE" "\0";
      TheXCount = 2;
      break;
   case 0x0426:
      TheXLocale = "\0" "lv" "\0" "lv_LV" "\0";
      TheXCount = 2;
      break;
   case 0x0427:
      TheXLocale = "\0" "lt" "\0" "lt@classic" "\0" "lt_LT" "\0";
      TheXCount = 3;
      break;
   case 0x0429:
      TheXLocale = "\0" "fa" "\0" "fa_IR" "\0";
      TheXCount = 2;
      break;
   case 0x042A:
      TheXLocale = "\0" "vi" "\0" "vi_VN" "\0";
      TheXCount = 2;
      break;
   case 0x042B:
      TheXLocale = "\0" "hy" "\0";
      TheXCount = 1;
      break;
   case 0x042C:
      TheXLocale = "\0" "az" "\0" "az@cyrillic" "\0";
      TheXCount = 2;
      break;
   case 0x042D:
      TheXLocale = "\0" "eu" "\0" "eu_ES" "\0";
      TheXCount = 2;
      break;
   case 0x042E:
      TheXLocale = "\0" "sb" "\0";
      TheXCount = 1;
      break;
   case 0x042F:
      TheXLocale = "\0" "mk" "\0" "mk_MK" "\0";
      TheXCount = 2;
      break;
   case 0x0430:
      TheXLocale = "\0" "sx" "\0";
      TheXCount = 1;
      break;
   case 0x0431:
      TheXLocale = "\0" "ts" "\0";
      TheXCount = 1;
      break;
   case 0x0432:
      TheXLocale = "\0" "tn" "\0";
      TheXCount = 1;
      break;
   case 0x0434:
      TheXLocale = "\0" "xh" "\0";
      TheXCount = 1;
      break;
   case 0x0435:
      TheXLocale = "\0" "zu" "\0";
      TheXCount = 1;
      break;
   case 0x0436:
      TheXLocale = "\0" "af" "\0" "af_ZA" "\0";
      TheXCount = 2;
      break;
   case 0x0437:
      TheXLocale = "\0" "ka" "\0";
      TheXCount = 1;
      break;
   case 0x0438:
      TheXLocale = "\0" "fo_FO" "\0" "fo" "\0";
      TheXCount = 2;
      break;
   case 0x0439:
      TheXLocale = "\0" "hi" "\0" "hi_IN" "\0";
      TheXCount = 2;
      break;
   case 0x043A:
      TheXLocale = "\0" "mt" "\0" "mt_MT" "\0";
      TheXCount = 2;
      break;
   case 0x043C:
      TheXLocale = "\0" "gd" "\0";
      TheXCount = 1;
      break;
   case 0x043D:
      TheXLocale = "\0" "ji" "\0";
      TheXCount = 1;
      break;
   case 0x043E:
      TheXLocale = "\0" "ms" "\0" "ms_MY" "\0";
      TheXCount = 2;
      break;
   case 0x0441:
      TheXLocale = "\0" "sw" "\0" "sw_KE" "\0" "sw_TZ" "\0";
      TheXCount = 3;
      break;
   case 0x0443:
      TheXLocale = "\0" "uz" "\0" "uz@latin" "\0";
      TheXCount = 2;
      break;
   case 0x0444:
      TheXLocale = "\0" "tt" "\0";
      TheXCount = 1;
      break;
   case 0x0445:
      TheXLocale = "\0" "bn" "\0";
      TheXCount = 1;
      break;
   case 0x0446:
      TheXLocale = "\0" "pa" "\0";
      TheXCount = 1;
      break;
   case 0x0447:
      TheXLocale = "\0" "gu" "\0";
      TheXCount = 1;
      break;
   case 0x0448:
      TheXLocale = "\0" "or" "\0";
      TheXCount = 1;
      break;
   case 0x0449:
      TheXLocale = "\0" "ta" "\0" "ta_IN" "\0";
      TheXCount = 2;
      break;
   case 0x044A:
      TheXLocale = "\0" "te" "\0" "te_IN" "\0";
      TheXCount = 2;
      break;
   case 0x044B:
      TheXLocale = "\0" "kn" "\0";
      TheXCount = 1;
      break;
   case 0x044C:
      TheXLocale = "\0" "ml" "\0";
      TheXCount = 1;
      break;
   case 0x044D:
      TheXLocale = "\0" "as" "\0";
      TheXCount = 1;
      break;
   case 0x044E:
      TheXLocale = "\0" "mr" "\0" "mr_IN" "\0";
      TheXCount = 2;
      break;
   case 0x044F:
      TheXLocale = "\0" "sa" "\0";
      TheXCount = 1;
      break;
   case 0x0457:
      TheXLocale = "\0" "kok" "\0" "kok_IN" "\0";
      TheXCount = 2;
      break;
   case 0x0459:
      TheXLocale = "\0" "sd" "\0";
      TheXCount = 1;
      break;
   case 0x0460:
      TheXLocale = "\0" "ks" "\0";
      TheXCount = 1;
      break;
   case 0x0461:
      TheXLocale = "\0" "ne" "\0";
      TheXCount = 1;
      break;
   case 0x0801:
      TheXLocale = "\0" "ar_IQ" "\0";
      TheXCount = 1;
      break;
   case 0x0804:
      TheXLocale = "\0" "zh_CN" "\0";
      TheXCount = 1;
      break;
   case 0x0807:
      TheXLocale = "\0" "de_CH" "\0";
      TheXCount = 1;
      break;
   case 0x0809:
      TheXLocale = "\0" "en_UK" "\0" "en_GB" "\0";
      TheXCount = 2;
      break;
   case 0x080A:
      TheXLocale = "\0" "es_MX" "\0";
      TheXCount = 1;
      break;
   case 0x080C:
      TheXLocale = "\0" "fr_BE" "\0" "fr_BE_EURO" "\0";
      TheXCount = 2;
      break;
   case 0x0810:
      TheXLocale = "\0" "it_CH" "\0";
      TheXCount = 1;
      break;
   case 0x0813:
      TheXLocale = "\0" "nl_BE" "\0" "nl_BE_EURO" "\0";
      TheXCount = 2;
      break;
   case 0x0814:
      TheXLocale = "\0" "nn_NO" "\0" "no@nynorsk" "\0" "nn" "\0" "no_NO_NY" "\0";
      TheXCount = 4;
      break;
   case 0x0816:
      TheXLocale = "\0" "pt" "\0" "pt_PT" "\0" "pt_PT_EURO" "\0";
      TheXCount = 3;
      break;
   case 0x0818:
      TheXLocale = "\0" "ro_MO" "\0";
      TheXCount = 1;
      break;
   case 0x0819:
      TheXLocale = "\0" "ru_MO" "\0";
      TheXCount = 1;
      break;
   case 0x081A:
      TheXLocale = "\0" "sh_YU" "\0" "sr@latin" "\0";
      TheXCount = 2;
      break;
   case 0x081D:
      TheXLocale = "\0" "sv_FI" "\0" "sv_FI_AL" "\0";
      TheXCount = 2;
      break;
   case 0x0820:
      TheXLocale = "\0" "ur_IN" "\0";
      TheXCount = 1;
      break;
   case 0x082C:
      TheXLocale = "\0" "az@latin" "\0";
      TheXCount = 1;
      break;
   case 0x083E:
      TheXLocale = "\0" "ms_BN" "\0";
      TheXCount = 1;
      break;
   case 0x0843:
      TheXLocale = "\0" "uz@cyrillic" "\0";
      TheXCount = 1;
      break;
   case 0x0860:
      TheXLocale = "\0" "ks_IN" "\0";
      TheXCount = 1;
      break;
   case 0x0861:
      TheXLocale = "\0" "ne_IN" "\0";
      TheXCount = 1;
      break;
   case 0x0C01:
      TheXLocale = "\0" "ar_EG" "\0";
      TheXCount = 1;
      break;
   case 0x0C04:
      TheXLocale = "\0" "zh_HK" "\0";
      TheXCount = 1;
      break;
   case 0x0C07:
      TheXLocale = "\0" "de_AT" "\0" "de_AT_EURO" "\0";
      TheXCount = 2;
      break;
   case 0x0C09:
      TheXLocale = "\0" "en_AU" "\0" "en_BE" "\0" "en_BW" "\0";
      TheXCount = 3;
      break;
   case 0x0C0A:
      TheXLocale = "\0" "es_ES" "\0" "es_ES_EURO" "\0" "es@modern" "\0";
      TheXCount = 3;
      break;
   case 0x0C0C:
      TheXLocale = "\0" "fr_CA" "\0";
      TheXCount = 1;
      break;
   case 0x0C1A:
      TheXLocale = "\0" "sr" "\0" "sr@cyrillic" "\0" "sr_YU" "\0";
      TheXCount = 3;
      break;
   case 0x1001:
      TheXLocale = "\0" "ar_LY" "\0";
      TheXCount = 1;
      break;
   case 0x1004:
      TheXLocale = "\0" "zh_SG" "\0";
      TheXCount = 1;
      break;
   case 0x1007:
      TheXLocale = "\0" "de_LU" "\0" "de_LU_EURO" "\0";
      TheXCount = 2;
      break;
   case 0x1009:
      TheXLocale = "\0" "en_CA" "\0";
      TheXCount = 1;
      break;
   case 0x100A:
      TheXLocale = "\0" "es_GT" "\0";
      TheXCount = 1;
      break;
   case 0x100C:
      TheXLocale = "\0" "fr_CH" "\0";
      TheXCount = 1;
      break;
   case 0x1401:
      TheXLocale = "\0" "ar_DZ" "\0";
      TheXCount = 1;
      break;
   case 0x1404:
      TheXLocale = "\0" "zh_MO" "\0";
      TheXCount = 1;
      break;
   case 0x1407:
      TheXLocale = "\0" "de_LI" "\0";
      TheXCount = 1;
      break;
   case 0x1409:
      TheXLocale = "\0" "en_SG" "\0" "en_NZ" "\0";
      TheXCount = 2;
      break;
   case 0x140A:
      TheXLocale = "\0" "es_CR" "\0";
      TheXCount = 1;
      break;
   case 0x140C:
      TheXLocale = "\0" "fr_LU" "\0" "fr_LU_EURO" "\0";
      TheXCount = 2;
      break;
   case 0x1801:
      TheXLocale = "\0" "ar_MA" "\0";
      TheXCount = 1;
      break;
   case 0x1809:
      TheXLocale = "\0" "en_IE" "\0" "en_IE_EURO" "\0";
      TheXCount = 2;
      break;
   case 0x180A:
      TheXLocale = "\0" "es_PA" "\0";
      TheXCount = 1;
      break;
   case 0x180C:
      TheXLocale = "\0" "fr_MC" "\0";
      TheXCount = 1;
      break;
   case 0x1C01:
      TheXLocale = "\0" "ar_TN" "\0";
      TheXCount = 1;
      break;
   case 0x1C09:
      TheXLocale = "\0" "en_ZA" "\0";
      TheXCount = 1;
      break;
   case 0x1C0A:
      TheXLocale = "\0" "es_DO" "\0";
      TheXCount = 1;
      break;
   case 0x2001:
      TheXLocale = "\0" "ar_OM" "\0";
      TheXCount = 1;
      break;
   case 0x2009:
      TheXLocale = "\0" "en_JM" "\0";
      TheXCount = 1;
      break;
   case 0x200A:
      TheXLocale = "\0" "es_VE" "\0";
      TheXCount = 1;
      break;
   case 0x2401:
      TheXLocale = "\0" "ar_YE" "\0";
      TheXCount = 1;
      break;
   case 0x2409:
      TheXLocale = "\0" "en@caribbean" "\0" "en_AS" "\0";
      TheXCount = 2;
      break;
   case 0x240A:
      TheXLocale = "\0" "es_CO" "\0";
      TheXCount = 1;
      break;
   case 0x2801:
      TheXLocale = "\0" "ar_SY" "\0";
      TheXCount = 1;
      break;
   case 0x2809:
      TheXLocale = "\0" "en_BZ" "\0";
      TheXCount = 1;
      break;
   case 0x280A:
      TheXLocale = "\0" "es_PE" "\0";
      TheXCount = 1;
      break;
   case 0x2C01:
      TheXLocale = "\0" "ar_JO" "\0";
      TheXCount = 1;
      break;
   case 0x2C09:
      TheXLocale = "\0" "en_TT" "\0";
      TheXCount = 1;
      break;
   case 0x2C0A:
      TheXLocale = "\0" "es_AR" "\0";
      TheXCount = 1;
      break;
   case 0x3001:
      TheXLocale = "\0" "ar_LB" "\0";
      TheXCount = 1;
      break;
   case 0x3009:
      TheXLocale = "\0" "en_ZW" "\0";
      TheXCount = 1;
      break;
   case 0x300A:
      TheXLocale = "\0" "es_EC" "\0";
      TheXCount = 1;
      break;
   case 0x3401:
      TheXLocale = "\0" "ar_KW" "\0";
      TheXCount = 1;
      break;
   case 0x3409:
      TheXLocale = "\0" "en_PH" "\0";
      TheXCount = 1;
      break;
   case 0x340A:
      TheXLocale = "\0" "es_CL" "\0";
      TheXCount = 1;
      break;
   case 0x3801:
      TheXLocale = "\0" "ar_AE" "\0";
      TheXCount = 1;
      break;
   case 0x380A:
      TheXLocale = "\0" "es_UY" "\0";
      TheXCount = 1;
      break;
   case 0x3C01:
      TheXLocale = "\0" "ar_BH" "\0";
      TheXCount = 1;
      break;
   case 0x3C0A:
      TheXLocale = "\0" "es_PY" "\0";
      TheXCount = 1;
      break;
   case 0x4001:
      TheXLocale = "\0" "ar_QA" "\0";
      TheXCount = 1;
      break;
   case 0x400A:
      TheXLocale = "\0" "es_BO" "\0";
      TheXCount = 1;
      break;
   case 0x440A:
      TheXLocale = "\0" "es_US" "\0" "es_SV" "\0";
      TheXCount = 2;
      break;
   case 0x480A:
      TheXLocale = "\0" "es_HN" "\0";
      TheXCount = 1;
      break;
   case 0x4C0A:
      TheXLocale = "\0" "es_NI" "\0";
      TheXCount = 1;
      break;
   case 0x500A:
      TheXLocale = "\0" "es_PR" "\0";
      TheXCount = 1;
      break;
   case 0x5401:
      TheXLocale = "\0" "ar@bahrain" "\0";
      TheXCount = 1;
      break;
   default:
      TheXLocale = "\0";
      TheXCount = 0;
      break;
   }
   RewindXLocale();
   return TheXCount;
}

const char *LcidToCodeSet(int lcid)
{
   const int _NL_CTYPE_CODESET_NAME = 0 << 16 + 14;

   switch(lcid)
   {
   case 0x0000:
      return "CP1252";
   case 0x0400:
      return "CP1252";
   case 0x0401:
      return "CP1256";
   case 0x0402:
      return "CP1251";
   case 0x0403:
      return "CP1252";
   case 0x0404:
#if defined(__ANDROID__)
      return "windows-950-2000";
#else
      return "CP950";
#endif
   case 0x0405:
      return "CP1250";
   case 0x0406:
      return "CP1252";
   case 0x0407:
      return "CP1252";
   case 0x0408:
      return "CP1253";
   case 0x0409:
      return "CP1252";
   case 0x040A:
      return "CP1252";
   case 0x040B:
      return "CP1252";
   case 0x040C:
      return "CP1252";
   case 0x040D:
      return "CP1255";
   case 0x040E:
      return "CP1250";
   case 0x040F:
      return "CP1252";
   case 0x0410:
      return "CP1252";
   case 0x0411:
      return "CP932";
   case 0x0412:
#if defined(__ANDROID__)
      return "windows-949-2000";
#else
      return "CP949";
#endif
   case 0x0413:
      return "CP1252";
   case 0x0414:
      return "CP1252";
   case 0x0415:
      return "CP1250";
   case 0x0416:
      return "CP1252";
   case 0x0418:
      return "CP1250";
   case 0x0419:
      return "CP1251";
   case 0x041A:
      return "CP1250";
   case 0x041B:
      return "CP1250";
   case 0x041C:
      return "CP1250";
   case 0x041D:
      return "CP1252";
   case 0x041E:
      return "CP874";
   case 0x041F:
      return "CP1254";
   case 0x0420:
      return "CP1256";
   case 0x0421:
      return "CP1252";
   case 0x0422:
      return "CP1251";
   case 0x0423:
      return "CP1251";
   case 0x0424:
      return "CP1250";
   case 0x0425:
      return "CP1257";
   case 0x0426:
      return "CP1257";
   case 0x0427:
      return "CP1257";
   case 0x0429:
      return "CP1256";
   case 0x042A:
      return "CP1258";
   case 0x042C:
      return "CP1254";
   case 0x042D:
      return "CP1252";
   case 0x042F:
      return "CP1251";
   case 0x0430:
      return "CP1251";
   case 0x0436:
      return "CP1252";
   case 0x0438:
      return "CP1252";
   case 0x043E:
      return "CP1252";
   case 0x043F:
      return "CP1251";
   case 0x0441:
      return "CP1252";
   case 0x0443:
      return "CP1254";
   case 0x0444:
      return "CP1251";
   case 0x0445:
      return "CP1251";
   case 0x0446:
      return "CP1251";
   case 0x0447:
      return "CP1251";
   case 0x0448:
      return "CP1251";
   case 0x0801:
      return "CP1256";
   case 0x0804:
      return "CP936";
   case 0x0807:
      return "CP1252";
   case 0x0809:
      return "CP1252";
   case 0x080A:
      return "CP1252";
   case 0x080C:
      return "CP1252";
   case 0x0810:
      return "CP1252";
   case 0x0812:
      return "CP1252";
   case 0x0813:
      return "CP1252";
   case 0x0814:
      return "CP1252";
   case 0x0816:
      return "CP1252";
   case 0x081A:
      return "CP1250";
   case 0x081D:
      return "CP1252";
   case 0x0820:
      return "CP1252";
   case 0x0827:
      return "CP1252";
   case 0x082C:
      return "CP1251";
   case 0x083E:
      return "CP1252";
   case 0x0843:
      return "CP1251";
   case 0x0860:
      return "CP1251";
   case 0x0861:
      return "CP1251";
   case 0x0C01:
      return "CP1256";
   case 0x0C04:
#if defined(__ANDROID__)
      return "windows-950-2000";
#else
      return "CP950";
#endif
   case 0x0C07:
      return "CP1252";
   case 0x0C09:
      return "CP1252";
   case 0x0C0A:
      return "CP1252";
   case 0x0C0C:
      return "CP1252";
   case 0x0C1A:
      return "CP1251";
   case 0x1001:
      return "CP1256";
   case 0x1004:
      return "CP936";
   case 0x1007:
      return "CP1252";
   case 0x1009:
      return "CP1252";
   case 0x100A:
      return "CP1252";
   case 0x100C:
      return "CP1252";
   case 0x1401:
      return "CP1256";
   case 0x1404:
#if defined(__ANDROID__)
      return "windows-950-2000";
#else
      return "CP950";
#endif
   case 0x1407:
      return "CP1252";
   case 0x1409:
      return "CP1252";
   case 0x140A:
      return "CP1252";
   case 0x140C:
      return "CP1252";
   case 0x1801:
      return "CP1256";
   case 0x1809:
      return "CP1252";
   case 0x180A:
      return "CP1252";
   case 0x180C:
      return "CP1252";
   case 0x1C01:
      return "CP1256";
   case 0x1C09:
      return "CP1252";
   case 0x1C0A:
      return "CP1252";
   case 0x2001:
      return "CP1256";
   case 0x2009:
      return "CP1252";
   case 0x200A:
      return "CP1252";
   case 0x2401:
      return "CP1256";
   case 0x2409:
      return "CP1252";
   case 0x240A:
      return "CP1252";
   case 0x2801:
      return "CP1256";
   case 0x2809:
      return "CP1252";
   case 0x280A:
      return "CP1252";
   case 0x2C01:
      return "CP1256";
   case 0x2C09:
      return "CP1252";
   case 0x2C0A:
      return "CP1252";
   case 0x3001:
      return "CP1256";
   case 0x3009:
      return "CP1252";
   case 0x300A:
      return "CP1252";
   case 0x3401:
      return "CP1256";
   case 0x3409:
      return "CP1252";
   case 0x340A:
      return "CP1252";
   case 0x3801:
      return "CP1256";
   case 0x380A:
      return "CP1252";
   case 0x3C01:
      return "CP1256";
   case 0x3C0A:
      return "CP1252";
   case 0x4001:
      return "CP1256";
   case 0x400A:
      return "CP1252";
   case 0x440A:
      return "CP1252";
   case 0x480A:
      return "CP1252";
   case 0x4C0A:
      return "CP1252";
   case 0x500A:
      return "CP1252";
   default:
#if defined(__ANDROID__)
      return "";
#else
      return(char*)nl_langinfo(_NL_CTYPE_CODESET_NAME);
#endif
   }
}

#if defined(__APPLE__)
pCHAR StringRefToString(CFStringRef StringRef)
{
  pCHAR rst = NULL;
  CFRange Range;

  Range.location = 0;
  Range.length = CFStringGetLength(StringRef);
  if (Range.length > 0)
  {
    rst = (pCHAR)malloc((Range.length+1)*sizeof(CHAR));
    CFStringGetCString(StringRef, rst, Range.length+1, kCFStringEncodingASCII);
    rst[Range.length] = 0;
  }

  return rst;
}

pCHAR GetLocaleName()
{
  pCHAR rst = NULL;
  CFLocaleRef Locale = CFLocaleCopyCurrent();
  rst = StringRefToString(CFLocaleGetIdentifier(Locale));
  CFRelease(Locale);
  return rst;
}
#else
pCHAR GetLocaleName()
{
  return setlocale(LC_ALL, NULL);
}
#endif

pCCHAR GetCodePage()
{
  pCHAR src = GetLocaleName();

  switch(Hash((const unsigned char*)src))
  {
    case 0xE502: //th_th
      return "CP874";

    case 0x7460: //ja_jp
      return "CP932";

    case 0xE3FE: //zh_cn
    case 0xAD68: //zh-hans_hk
    case 0xAD9C: //zh-hans_mo
    case 0xE4F7: //zh_sg
    case 0xE517: //zh_tw
      return "CP936";

    case 0x5474: //ko_kr
#if defined(__ANDROID__)
      return "windows-949-2000";
#else
      return "CP949";
#endif

    case 0xE44B: //zh_hk
    case 0xE49F: //zh_mo
#if defined(__ANDROID__)
      return "windows-950-2000";
#else
      return "CP950";
#endif

    case 0x93F4: //cs_cz
    case 0x8441: //hr_hr
    case 0xB444: //hu_hu
    case 0x24C3: //pl_pl
    case 0x54E8: //ro_ro
    case 0x14F5: //sk_sk
    case 0x24F3: //sl_si
    case 0x73D6: //sq_al
    case 0xA34F: //sr-latn_ba
    case 0xA403: //sr-latn_me
    case 0xA661: //sr-latn_rs
      return "CP1250";

    case 0xB3C9: //az-cyrl_az
    case 0xB3E1: //be_by
    case 0xD3CF: //bg_bg
    case 0x169C: //kk_kz
    case 0x148F: //mk_mk
    case 0xB4EE: //ru_ru
    case 0xCBC1: //sr-cyrl_ba
    case 0xCC15: //sr-cyrl_me
    case 0xCEB3: //sr-cyrl_rs
    case 0x150D: //uk_ua
    case 0xF70A: //uz-cyrl_uz
      return "CP1251";

    case 0x450F: //en_us
      return "CP1252";

    case 0x242E: //el_gr
      return "CP1253";

    case 0xCB57: //az-latn_az
    case 0x850D: //tr_tr
    case 0x0E19: //uz-latn_uz
      return "CP1254";

    case 0xB44A: //he_il
      return "CP1255";

    case 0x83BD: //ar_ae
    case 0x83D0: //ar_bh
    case 0x8402: //ar_dz
    case 0x83FF: //ar_eg
    case 0x8449: //ar_iq
    case 0x8457: //ar_jo
    case 0x846F: //ar_kw
    case 0x846A: //ar_lb
    case 0x8481: //ar_ly
    case 0x8479: //ar_ma
    case 0x84A5: //ar_om
    case 0x84B9: //ar_qa
    case 0x84D9: //ar_sa
    case 0x84DC: //ar_sd
    case 0x84F1: //ar_sy
    case 0x84F6: //ar_tn
    case 0x853D: //ar_ye
    case 0x744E: //fa_ir
    case 0x2ADB: //pa-arab_pk
    case 0x84C7: //ur_pk
    case 0xD0C6: //uz-arab_af
      return "CP1256";

    case 0xA401: //et_ee
    case 0xA487: //lt_lt
    case 0xC489: //lv_lv
      return "CP1257";

    case 0xF52A: //vi_vn
      return "CP1258";

    default:
      return "char";
  }
}

// Conversion routines
// -------------------

int MaxSize(int iSize1, int iSize2)
{
   return iSize1 > iSize2 ? iSize1 : iSize2;
}

#if !defined(__ANDROID__)
int ConvertBuffer(iconv_t Context, Const Source, int SrcBytes, Var Dest, int DestBytes)
{
   int Result = -1;
   size_t DestBytesLeft, SrcBytesLeft;

   pCHAR S, D;

   if (Context == (iconv_t)-1)
      return Result;

   // make copies of params...  iconv modifies param ptrs
   DestBytesLeft = DestBytes;
   SrcBytesLeft = SrcBytes;

   S = (pCHAR)Source;
   D = (pCHAR)Dest;

   if ((SrcBytes == 0) || (DestBytes == 0))
      Result = 0;
   else
   {
      Result = iconv(Context, &S, (size_t*)&SrcBytesLeft, &D, (size_t*)&DestBytesLeft);
      while ((SrcBytesLeft > 0) && (DestBytesLeft > 0) && (Result == -1) && (errno == 7))
         Result = iconv(Context, &S, (size_t*)&SrcBytesLeft, &D, (size_t*)&DestBytesLeft);
      if (Result != -1)
         Result = DestBytes - DestBytesLeft;
   }

   iconv_close(Context);
   return Result; // Fix TArisawa
}
#endif

int WCharToChar(const pUCS2Char WCharSource, int SrcChars, INT32 CP, pCHAR CharDest, int DestBytes)
{
   char CodeSet[100];
   sprintf(CodeSet, "CP%ld", CP);
#if defined(__ANDROID__)
   UErrorCode status = U_ZERO_ERROR;
   UConverter *conv;
   conv = pucnv_open(CodeSet, &status);
   int Result = pucnv_fromUChars(conv, NULL, 0, WCharSource, SrcChars/sizeof(ucs2char_t), &status);

   //Reset buffer overflow error that may have occurred during pre-flighting
   status = U_ZERO_ERROR;

   if (Result > DestBytes)
     Result = DestBytes;
   if (Result != 0)
      pucnv_fromUChars(conv, CharDest, Result+1, WCharSource, SrcChars/sizeof(ucs2char_t), &status);
   return Result;
#else
   iconv_t Context = iconv_open(CodeSet, UnicodeId);
   return ConvertBuffer(Context, WCharSource, SrcChars, CharDest, DestBytes);
#endif
}

int CharToWChar(INT32 CP, pCHAR CharSource, int SrcBytes, const pUCS2Char WCharDest, int DestChars)
{
   char CodeSet[100];
   sprintf(CodeSet, "CP%ld", CP);
#if defined(__ANDROID__)
   UErrorCode status = U_ZERO_ERROR;
   UConverter *conv;
   conv = pucnv_open(CodeSet, &status);
   int Result = pucnv_toUChars(conv, NULL, 0, CharSource, SrcBytes, &status);

   //Reset buffer overflow error that may have occurred during pre-flighting
   status = U_ZERO_ERROR;

   if (Result > DestChars)
     Result = DestChars;
   if (Result != 0)
      pucnv_toUChars(conv, WCharDest, Result+1, CharSource, SrcBytes, &status);
   return Result;
#else
   iconv_t Context = iconv_open(UnicodeId, CodeSet);
   return ConvertBuffer(Context, CharSource, SrcBytes, WCharDest, DestChars) / sizeof(ucs2char_t);
#endif
}

pUCS2Char StringToWString(LCID lcid, const char *pszStr, int iSize)
{
   pCCHAR pszCodeSet = LcidToCodeSet(lcid);
#if defined(__ANDROID__)
   pUCS2Char pWStr;
   UErrorCode status = U_ZERO_ERROR;
   UConverter *conv;
   conv = pucnv_open(pszCodeSet, &status);
   int len = pucnv_toUChars(conv, NULL, 0, pszStr, -1, &status);

   //Reset buffer overflow error that may have occurred during pre-flighting
   status = U_ZERO_ERROR;

   if (len != 0)
   {
      pWStr = (pUCS2Char) malloc((len+1) * sizeof(ucs2char_t));
      pucnv_toUChars(conv, pWStr, len+1, pszStr, -1, &status);
   }
   return pWStr;
#else
   int iWSize = sizeof(ucs2char_t) * (iSize + 1);
   pUCS2Char pWStr = (pUCS2Char)malloc(iWSize);

   iconv_t Context = iconv_open(UnicodeId, pszCodeSet);
   ConvertBuffer(Context, pszStr, iSize + 1, pWStr, iWSize);

   return pWStr;
#endif
}

#if DEBUG_PRINT

// Code remarked but left in for debugging purposes in the future

void UCS2Print(pCHAR Tag, pUCS2Char pVal)
{
   int len = sizeof(ucs2char_t) * WideStrLen(pVal);
   pCHAR p = (char*)pVal;
   int i;

   printf("%s=", Tag);

   for (i = 0; i < len; i++)
   {
      if (*p == 0)
         printf("[0]");
      else
         printf("%s", p);
      p++;
   }
   printf("\n");
   fflush(stdout);
}

void WPrint(pCHAR Tag, wchar_t *pVal)
{
   int len = sizeof(wchar_t) * wcslen(pVal);
   pCHAR p = (char*)pVal;
   int i;

   printf("%s=", Tag);

   for (i = 0; i < len; i++)
   {
      if (*p == 0)
         printf("[0]");
      else
         printf("%s", p);
      p++;
   }
   printf("\n");
   fflush(stdout);
}
#endif

// Wide String Comp
// ----------------

int LibcWideStrComp(int iCmpFlags, pCUCS2Char pVal1, size_t iSize1, pCUCS2Char pVal2, size_t iSize2)
{
   pCUCS2Char WS1 = pVal1;
   pCUCS2Char WS2 = pVal2;

   int iLibcResult = IsIgnoreCase(iCmpFlags) ? WideStrLIComp(WS1, iSize1, WS2, iSize2) : WideStrLComp(WS1, iSize1, WS2, iSize2);

   return iLibcResult;
}

int WideStrComp_l(LCID lcid, int iCmpFlags, pCUCS2Char pVal1, size_t iSize1, pCUCS2Char pVal2, size_t iSize2)
{
   int iLibcResult = LIBC_EQUAL;

   if (IsValidLocale(lcid, LCID_INSTALLED)) // sets TheXCurrent pointer returned by CurrentXLocale
   {
      if (((iCmpFlags & NORM_IGNORECASE) == 0) && (strcmp(CurrentXLocale(), DefaultXLocale()) == LIBC_EQUAL))
         iLibcResult = WideStrLComp(pVal1, iSize1, pVal2, iSize2);
      else
      {
         if (SavePrevXLocale())
         {
            if (setlocale(LC_ALL, CurrentXLocale()))
               iLibcResult = IsIgnoreCase(iCmpFlags) ? WideStrLIComp(pVal1, iSize1, pVal2, iSize2) : WideStrLComp
                  (pVal1, iSize1, pVal2, iSize2);
            else
               iLibcResult = LibcWideStrComp(iCmpFlags, pVal1, iSize1, pVal2, iSize2);
            RestorePrevXLocale();
         }
         else
            iLibcResult = LibcWideStrComp(iCmpFlags, pVal1, iSize1, pVal2, iSize2);
      }
   }
   else
      iLibcResult = LibcWideStrComp(iCmpFlags, pVal1, iSize1, pVal2, iSize2);

   // Exit
   return iLibcResult;
}

// Ansi-like functions
// -------------------

int LibcStrComp(int iCmpFlags, pCCHAR pszStr1, int iSize1, pCHAR pszStr2, int iSize2)
{
   if (iSize1 == -1)
      iSize1 = AnsiStrLen(pszStr1);
   if (iSize2 == -1)
      iSize2 = AnsiStrLen(pszStr2);

   int iSize = iSize1 > iSize2 ? iSize1 : iSize2;
   int iLibcResult = IsIgnoreCase(iCmpFlags) ? strncasecmp(pszStr1, pszStr2, iSize)
                                             : strncmp(pszStr1, pszStr2, iSize);

   return iLibcResult;
}

int AnsiStrLComp(pCCHAR pszStr1, int iSize1, pCHAR pszStr2, int iSize2)
{
   bool bUseSize1 = (iSize1 != -1), bUseSize2 = (iSize2 != -1);

   if (iSize1 == -1)
      iSize1 = AnsiStrLen(pszStr1);
   if (iSize2 == -1)
      iSize2 = AnsiStrLen(pszStr2);

   int iLibcResult = LIBC_EQUAL;
   pCHAR pszComp1 = bUseSize1 ? AnsiStrNDup(pszStr1, iSize1) : (pCHAR)pszStr1;
   pCHAR pszComp2 = bUseSize2 ? AnsiStrNDup(pszStr2, iSize2) : (pCHAR)pszStr2;

   iLibcResult = AnsiStrComp(pszComp1, pszComp2);

   if (bUseSize1)
      free(pszComp1);
   if (bUseSize2)
      free(pszComp2);

   return iLibcResult;
}

int AnsiStrIComp(LCID lcid, pCCHAR pszStr1, int iSize1, pCHAR pszStr2, int iSize2)
{
   pUCS2Char pWS1 = WideLowerCase(StringToWString(lcid, pszStr1, iSize1));
   pUCS2Char pWS2 = WideLowerCase(StringToWString(lcid, pszStr2, iSize2));

   int iLibcResult = WideStrLComp(pWS1, iSize1, pWS2, iSize2);

   if (pWS1)
      free(pWS1);
   if (pWS2)
      free(pWS2);

   return iLibcResult;
}

int AnsiStrLIComp(LCID lcid, pCCHAR pszStr1, int iSize1, pCHAR pszStr2, int iSize2)
{
   if (iSize1 == -1)
      iSize1 = AnsiStrLen(pszStr1);
   if (iSize2 == -1)
      iSize2 = AnsiStrLen(pszStr2);

   int iLibcResult = AnsiStrIComp(lcid, pszStr1, iSize1, pszStr2, iSize2);

   return iLibcResult;
}

int AnsiStrComp_l(LCID lcid, int iCmpFlags, pCCHAR pszStr1, int iSize1, pCHAR pszStr2, int iSize2)
{
   int iLibcResult = LIBC_EQUAL;

   if (IsValidLocale(lcid, LCID_INSTALLED)) // sets TheXCurrent pointer returned by CurrentXLocale
   {
      if (((iCmpFlags & NORM_IGNORECASE) == 0) && (strcmp(CurrentXLocale(), DefaultXLocale()) == LIBC_EQUAL))
         iLibcResult = AnsiStrLComp(pszStr1, iSize1, pszStr2, iSize2);
      else
      {
         if (SavePrevXLocale())
         {
            if (setlocale(LC_ALL, CurrentXLocale()))
               iLibcResult = IsIgnoreCase(iCmpFlags) ? AnsiStrLIComp(lcid, pszStr1, iSize1, pszStr2, iSize2)
                  : AnsiStrLComp(pszStr1, iSize1, pszStr2, iSize2);
            else
               iLibcResult = LibcStrComp(iCmpFlags, pszStr1, iSize1, pszStr2, iSize2);
            RestorePrevXLocale();
         }
         else
            iLibcResult = LibcStrComp(iCmpFlags, pszStr1, iSize1, pszStr2, iSize2);
      }
   }
   else
      iLibcResult = LibcStrComp(iCmpFlags, pszStr1, iSize1, pszStr2, iSize2);

   return iLibcResult;
}

// Windows-like function wrappers
// =============================
int CompareString(LCID lcid, int iCmpFlags, pCCHAR pszStr1, int iSize1, pCHAR pszStr2, int iSize2)
{
   int iLibcResult, iCstrResult;

   if ((pszStr1 == NULL) && (pszStr2 == NULL))
      iLibcResult = LIBC_EQUAL;
   else if (pszStr1 == NULL)
      iLibcResult = LIBC_LESS_THAN;
   else if (pszStr2 == NULL)
      iLibcResult = LIBC_GREATER_THAN;
   else
   {
      if (lcid == 0)
         iLibcResult = LibcStrComp(iCmpFlags, pszStr1, iSize1, pszStr2, iSize2);
      else
         iLibcResult = AnsiStrComp_l(lcid, iCmpFlags, pszStr1, iSize1, pszStr2, iSize2);
   }

   iCstrResult = LIBC_TO_CSTR(iLibcResult);
   return iCstrResult;
}

int CompareStringW(LCID lcid, int iCmpFlags, pCUCS2Char pVal1, int iSize1, pCUCS2Char pVal2, int iSize2)
{
   int iLibcResult, iCstrResult;

   if ((pVal1 == NULL) && (pVal2 == NULL))
      iLibcResult = LIBC_EQUAL;
   else if (pVal1 == NULL)
      iLibcResult = LIBC_LESS_THAN;
   else if (pVal2 == NULL)
      iLibcResult = LIBC_GREATER_THAN;
   else
   {
      if (lcid == 0)
         iLibcResult = LibcWideStrComp(iCmpFlags, pVal1, iSize1, pVal2, iSize2);
      else
         iLibcResult = WideStrComp_l(lcid, iCmpFlags, pVal1, iSize1, pVal2, iSize2);
   }

   iCstrResult = LIBC_TO_CSTR(iLibcResult);
   return iCstrResult;
}

void GetLocalTime(SYSTEMTIME * t)
{
   time_t tim;
   tm * tt;
   time(&tim);
   tt = gmtime(&tim);
   t->wYear = tt->tm_year;
   t->wMonth = tt->tm_mon;
   t->wDayOfWeek = tt->tm_wday;
   t->wDay = tt->tm_mday;
   t->wHour = tt->tm_hour;
   t->wMinute = tt->tm_min;
   t->wSecond = tt->tm_sec;
   t->wMilliseconds = 0; // not supported
}

#endif


pUCS2Char WideLowerCase(pUCS2Char pWSrc)
{
   pUCS2Char pWDest = pWSrc;
   if (pWSrc)
   {
      while (*pWDest != (ucs2char_t)NULL)
      {
         *pWDest = towlower(*pWDest);
         pWDest++;
      }
   }
   return pWSrc;
}

pUCS2Char WideUpperCase(pUCS2Char pWSrc)
{
   pUCS2Char pWDest = pWSrc;
   if (pWSrc)
   {
      while (*pWDest != (ucs2char_t)NULL)
      {
         *pWDest = towupper(*pWDest);
         pWDest++;
      }
   }
   return pWSrc;
}

pUCS2Char WideStrNDup(pCUCS2Char pVal, int iSize)
{
   pUCS2Char pDest = (pUCS2Char)malloc(sizeof(ucs2char_t) * (iSize + 1));
   for (int i = 0; i < iSize; i++)
      pDest[i] = pVal[i];
   *(pDest + iSize) = (ucs2char_t)0;
   return pDest;
}

#if defined(_UNIX)
int WideStrLen(pCUCS2Char pVal)
{
   pCUCS2Char pWS = pVal;
   int Result = 0;
   while (*pWS)
   {
      ++pWS;
      ++Result;
   }
   return Result;
}

wchar_t *UCS2ToWChar(pUCS2Char pWS, int ucs2len)
{
   if (ucs2len == -1)
      ucs2len = WideStrLen(pWS);
   wchar_t *Result = (wchar_t*)malloc((ucs2len + 1) * (sizeof(wchar_t)));
   for (int i = 0; i < ucs2len; i++)
      Result[i] = (wchar_t)pWS[i];
   Result[ucs2len] = (wchar_t)0;
   return Result;
}

int WCharLen(wchar_t *pVal)
{
   wchar_t* pWS = pVal;
   int Result = 0;
   while (*pWS)
   {
      ++pWS;
      ++Result;
   }
   return Result;
}

pUCS2Char WCharToUCS2( wchar_t *pWS, int wcharlen )
{
   if (wcharlen == -1)
      wcharlen = WCharLen(pWS);
   pUCS2Char Result = (pUCS2Char)malloc((wcharlen + 1) * (sizeof(ucs2char_t)));
   for (int i = 0; i < wcharlen; i++)
      Result[i] = (ucs2char_t)pWS[i];
   Result[wcharlen] = (ucs2char_t)0;
   return Result;
}
#endif

int WideStrComp(const pCUCS2Char pVal1, const pCUCS2Char pVal2)
{
  if (pVal1 && pVal2)
  {
    const ucs2char_t *p = pVal1, *q = pVal2;
    while (*p && *q)
    {
      if (*p > *q)
        return 1;
      if (*p < *q)
        return -1;
      p++;
      q++;
    }
    if (*p > *q)
      return 1;
    if (*p < *q)
      return -1;
  }
  return 0;
}

int WideStrIComp(pCUCS2Char pVal1, int iSize1, pCUCS2Char pVal2, int iSize2)
{
   pUCS2Char pWS1 = WideLowerCase(WideStrNDup(pVal1, iSize1));
   pUCS2Char pWS2 = WideLowerCase(WideStrNDup(pVal2, iSize2));

   int iLibcResult = WideStrComp(pWS1, pWS2);

   if (pWS1)
      free(pWS1);
   if (pWS2)
      free(pWS2);

   return iLibcResult;
}

int WideStrLComp(pCUCS2Char pVal1, int iSize1, pCUCS2Char pVal2, int iSize2)
{
   int Result;

   pCUCS2Char pWS1, pWS2;

   if (iSize1 == -1)
      pWS1 = WideStrNDup(pVal1, WideStrLen(pVal1));
   else
      pWS1 = WideStrNDup(pVal1, iSize1);

   if (iSize2 == -1)
      pWS2 = WideStrNDup(pVal2, WideStrLen(pVal2));
   else
      pWS2 = WideStrNDup(pVal2, iSize2);

   Result = WideStrComp(pWS1, pWS2);

   free((void*)pWS1);
   free((void*)pWS2);

   return Result;
}

int WideStrLIComp(pCUCS2Char pVal1, int iSize1, pCUCS2Char pVal2, int iSize2)
{
   if (iSize1 == -1)
      iSize1 = WideStrLen(pVal1);
   if (iSize2 == -1)
      iSize2 = WideStrLen(pVal2);

   int iLibcResult = WideStrIComp(pVal1, iSize1, pVal2, iSize2);

   return iLibcResult;
}

int WideStrToInt(const pUCS2Char wp)
{
  int neg = 1;
  if (!wp || !*wp)
    return 0;
  int result = 0;
  const ucs2char_t *p = wp;
  ucs2char_t c;

  c = *p++;
  if ((c == '-') || (c == '+'))
  {
    if (c == '-')
      neg = -1;
    c = *p++;
  }
  while (c >= '0' && c <= '9')
  {
    result = result * 10 + (c - '0');
    c = *p++;
  }
  return result*neg;
}

#if defined(_UNIX)
pCHAR AnsiStrNDup(pCCHAR pszStr, int iSize)
{
   pCHAR pszDest = (pCHAR)malloc(iSize + 1);
   strncpy(pszDest, pszStr, iSize);
   *(pszDest + iSize) = 0;
   return pszDest;
}

int AnsiStrLen(pCCHAR pszStr)
{
   return strlen(pszStr);
   // return mblen( pszStr, MB_CUR_MAX );
}

//TODO: Update crtl.pas with strcoll and call that instead.
int AnsiStrComp(pCHAR pszStr1, pCHAR pszStr2)
{
  if (pszStr1 && pszStr2)
  {
    const CHAR *p = pszStr1, *q = pszStr2;
    while (*p && *q)
    {
	  if (*p > *q)
		return 1;
	  if (*p < *q)
		return -1;  	  
      p++;
      q++;
    }
	if (*p)
	  return 1;
	if (*q)
	  return -1;

  }
  return 0;
}
#endif

#if defined(MIDAS_OBJ)
/*
 * strtod.c --
 *
 *	Source code for the "strtod" library procedure.
 *
 * Copyright 1988-1992 Regents of the University of California
 * Permission to use, copy, modify, and distribute this
 * software and its documentation for any purpose and without
 * fee is hereby granted, provided that the above copyright
 * notice appear in all copies.  The University of California
 * makes no representations about the suitability of this
 * software for any purpose.  It is provided "as is" without
 * express or implied warranty.
 */
#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif
#ifndef NULL
#define NULL 0
#endif

static int maxExponent = 511;
static double powersOf10[] = {
	10.,
	100.,
	1.0e4,
    1.0e8,
    1.0e16,
    1.0e32,
    1.0e64,
    1.0e128,
    1.0e256
};

extern "C" double bsdstrtod(
	const char *string,
	char **endPtr
)
{
    int sign, expSign = FALSE;
    double fraction, dblExp, *d;
    register CONST char *p;
    register int c;
	int exp = 0;
	int fracExp = 0;
	int mantSize;
	int decPt;
	CONST char *pExp;

    p = string;
    while (isspace(*p)) {
	p += 1;
    }
    if (*p == '-') {
	sign = TRUE;
	p += 1;
    } else {
	if (*p == '+') {
	    p += 1;
	}
	sign = FALSE;
    }

    decPt = -1;
    for (mantSize = 0; ; mantSize += 1)
    {
	c = *p;
	if (!isdigit(c)) {
	    if ((c != '.') || (decPt >= 0)) {
		break;
	    }
	    decPt = mantSize;
	}
	p += 1;
	}

    pExp  = p;
	p -= mantSize;
    if (decPt < 0) {
	decPt = mantSize;
    } else {
	mantSize -= 1;
    }
    if (mantSize > 18) {
	fracExp = decPt - 18;
	mantSize = 18;
    } else {
	fracExp = decPt - mantSize;
    }
    if (mantSize == 0) {
	fraction = 0.0;
	p = string;
	goto done;
    } else {
	int frac1, frac2;
	frac1 = 0;
	for ( ; mantSize > 9; mantSize -= 1)
	{
	    c = *p;
	    p += 1;
	    if (c == '.') {
		c = *p;
		p += 1;
	    }
	    frac1 = 10*frac1 + (c - '0');
	}
	frac2 = 0;
	for (; mantSize > 0; mantSize -= 1)
	{
	    c = *p;
	    p += 1;
	    if (c == '.') {
		c = *p;
		p += 1;
	    }
	    frac2 = 10*frac2 + (c - '0');
	}
	fraction = (1.0e9 * frac1) + frac2;
	}

    p = pExp;
    if ((*p == 'E') || (*p == 'e')) {
	p += 1;
	if (*p == '-') {
	    expSign = TRUE;
	    p += 1;
	} else {
	    if (*p == '+') {
		p += 1;
	    }
	    expSign = FALSE;
	}
	while (isdigit(*p)) {
	    exp = exp * 10 + (*p - '0');
	    p += 1;
	}
    }
    if (expSign) {
	exp = fracExp - exp;
    } else {
	exp = fracExp + exp;
	}

    if (exp < 0) {
	expSign = TRUE;
	exp = -exp;
    } else {
	expSign = FALSE;
    }
    if (exp > maxExponent) {
	exp = maxExponent;
    }
    dblExp = 1.0;
    for (d = powersOf10; exp != 0; exp >>= 1, d += 1) {
	if (exp & 01) {
	    dblExp *= *d;
	}
    }
    if (expSign) {
	fraction /= dblExp;
    } else {
	fraction *= dblExp;
    }

done:
    if (endPtr != NULL) {
	*endPtr = (char *) p;
    }

    if (sign) {
	return -fraction;
    }
    return fraction;
}
#endif

