/*
//
// module:  m0rexlib.h
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: m0rexlib.h,v 1.1 2008/02/07 09:54:19 lulin Exp $
//
*/
#ifndef   _m0REXLIB_H
#define   _m0REXLIB_H


# include "m0types.h"
# include "m0addtyp.h"


# pragma off (unreferenced)
# pragma pack (push,1)


  _m0FUNC_PUBLIC(Word,m0REXAllocEx)                   (_m0VAR(*AHandle,Pointer),
                                                       _m0VAR( APatern,PChar),
                                                       _m0VAR( ASize,LongInt),
                                                       _m0VAR( AICase,LongBool)
                                                      );

  _m0FUNC_PUBLIC(Word,m0REXExecEx)                    (_m0VAR( AHandle,Pointer),
                                                       _m0VAR( AText,PChar),
                                                       _m0VAR( ASize,LongInt),
                                                       _m0VAR( ABegPos,PLongInt),
                                                       _m0VAR( AEndPos,PLongInt)
                                                      );

  _m0FUNC_PUBLIC(void,m0REXFree)                      (_m0VAR(*AHandle,Pointer)
                                                      );


# pragma pack (pop)
# pragma on (unreferenced)


#endif
