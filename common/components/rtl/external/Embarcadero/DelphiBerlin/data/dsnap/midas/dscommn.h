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

#ifndef DSCOMMN_H
#define DSCOMMN_H

#define  CopyMem(pDest, pSrc, iLen)  memmove(pDest, pSrc, iLen)
#define  ZeroMem(pDest, iLen)        memset(pDest, 0, iLen)
#define  ByteComp(p1, p2, iLen)      memcmp(p1, p2, iLen)

#endif
