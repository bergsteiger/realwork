/*
//
// module:  m0lzolib.h
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: m0lzolib.h,v 1.1 2008/02/07 09:54:19 lulin Exp $
//
*/
#ifndef   _m0LZOLIB_H
#define   _m0LZOLIB_H


# include "m0types.h"
# include "m0addtyp.h"


# pragma off (unreferenced)
# pragma pack (push,1)


  _m0FUNC_PUBLIC(Word,m0LZOInitLibrary)               (
                                                      );

  _m0FUNC_PUBLIC(Word,m0LZOCompress)                  (_m0VAR( ADest,Pointer),
                                                       _m0VAR(*ADLen,LongInt),
                                                       _m0VAR( ASour,Pointer),
                                                       _m0VAR( ASLen,LongInt)
                                                      );

  _m0FUNC_PUBLIC(Word,m0LZODecompress)                (_m0VAR( ADest,Pointer),
                                                       _m0VAR(*ADLen,LongInt),
                                                       _m0VAR( ASour,Pointer),
                                                       _m0VAR( ASLen,LongInt)
                                                      );


# pragma pack (pop)
# pragma on (unreferenced)


#endif
