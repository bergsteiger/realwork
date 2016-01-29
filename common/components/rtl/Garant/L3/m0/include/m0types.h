/*
//
// module:  m0types.h
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: m0types.h,v 1.1 2008/02/07 09:54:22 lulin Exp $
//
*/
#ifndef   _m0TYPES_H
#define   _m0TYPES_H


# include <m0conf.h>


# pragma off (unreferenced)
# pragma pack (push,1)


  _m0TYPE(AnsiChar,unsigned char);
  _m0TYPE(PAnsiChar,AnsiChar*);
  _m0TYPE(WideChar,unsigned short);
  _m0TYPE(PWideChar,WideChar*);
  _m0TYPE(Char,AnsiChar);
  _m0TYPE(PChar,Char*);

  _m0TYPE(ByteBool,unsigned char);
  _m0TYPE(WordBool,unsigned short);
  _m0TYPE(LongBool,unsigned long);
  _m0TYPE(Boolean,ByteBool);

  _m0TYPE(ShortInt,signed char);
  _m0TYPE(Byte,unsigned char);

  _m0TYPE(SmallInt,signed short);
  _m0TYPE(Word,unsigned short);

  _m0TYPE(Cardinal,unsigned long);
  _m0TYPE(Integer,int);
  _m0TYPE(LongInt,long);
  _m0TYPE(LongWord,unsigned long);

  _m0TYPE(Pointer,void*);

  _m0TYPE(Int64,__int64);


# pragma pack (pop)
# pragma on (unreferenced)


#endif
