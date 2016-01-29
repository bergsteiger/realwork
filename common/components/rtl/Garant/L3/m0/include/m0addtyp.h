/*
//
// module:  m0addtyp.h
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: m0addtyp.h,v 1.1 2008/02/07 09:54:22 lulin Exp $
//
*/
#ifndef   _m0ADDTYP_H
#define   _m0ADDTYP_H


# include <m0types.h>


# pragma off (unreferenced)
# pragma pack (push,1)


  _m0TYPE(PByteBool,ByteBool*);
  _m0TYPE(PWordBool,WordBool*);
  _m0TYPE(PLongBool,LongBool*);
  _m0TYPE(PBoolean,Boolean*);

  _m0TYPE(PShortInt,ShortInt*);
  _m0TYPE(PByte,Byte*);

  _m0TYPE(PSmallInt,SmallInt*);
  _m0TYPE(PWord,Word*);

  _m0TYPE(PCardinal,Cardinal*);
  _m0TYPE(PInteger,Integer*);
  _m0TYPE(PLongInt,LongInt*);
  _m0TYPE(PLongWord,LongWord*);

  _m0TYPE(PPointer,Pointer*);

  _m0TYPE(PInt64,Int64);

  _m0TYPE(_T16to08,struct)
  {

    union
    {

      union
      {

        _m0VAR(RLoAnsiChar,AnsiChar);
        _m0VAR(RHiAnsiChar,AnsiChar);

      };

      union
      {

        _m0VAR(RLoByteBool,ByteBool);
        _m0VAR(RHiByteBool,ByteBool);

      };

      union
      {

        _m0VAR(RLoShortInt,ShortInt);
        _m0VAR(RHiShortInt,ShortInt);

      };

      union
      {

        _m0VAR(RLoByte,Byte);
        _m0VAR(RHiByte,Byte);

      };

    };

  } T16to08;
  _m0TYPE(P16to08,T16to08*);

  _m0TYPE(_T32to16,struct)
  {

    union
    {

      union
      {

        _m0VAR(RLoWideChar,WideChar);
        _m0VAR(RHiWideChar,WideChar);

      };

      union
      {

        _m0VAR(RLoWordBool,WordBool);
        _m0VAR(RHiWordBool,WordBool);

      };

      union
      {

        _m0VAR(RLoSmallInt,SmallInt);
        _m0VAR(RHiSmallInt,SmallInt);

      };

      union
      {

        _m0VAR(RLoWord,Word);
        _m0VAR(RHiWord,Word);

      };

    };

  } T32to16;
  _m0TYPE(P32to16,T32to16*);

  _m0TYPE(_T64to32,struct)
  {

    union
    {

      union
      {

        _m0VAR(RLoLongBool,LongBool);
        _m0VAR(RHiLongBool,LongBool);

      };

      union
      {

        _m0VAR(RLoCardinal,Cardinal);
        _m0VAR(RHiCardinal,Cardinal);

      };

      union
      {

        _m0VAR(RLoInteger,Integer);
        _m0VAR(RHiInteger,Integer);

      };

      union
      {

        _m0VAR(RLoLongInt,LongInt);
        _m0VAR(RHiLongInt,LongInt);

      };

      union
      {

        _m0VAR(RLoLongWord,LongWord);
        _m0VAR(RHiLongWord,LongWord);

      };

      union
      {

        _m0VAR(RLoPointer,Pointer);
        _m0VAR(RHiPointer,Pointer);

      };

    };

  } T64to32;
  _m0TYPE(P64to32,T64to32*);


# pragma pack (pop)
# pragma on (unreferenced)


#endif
