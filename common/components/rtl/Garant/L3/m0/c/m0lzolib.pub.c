/*
//
// module:  m0lzolib.pub.c
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: m0lzolib.pub.c,v 1.2 2012/01/13 12:44:34 lulin Exp $
//
*/
#ifndef   _m0LZOLIB_PUB_C
#define   _m0LZOLIB_PUB_C


# pragma off (unreferenced)
# pragma pack (push,1)


# define  _m0LZOCALLFUNC(_f,_db,_ds,_sb,_ss,_wm) (_f)((lzo_bytep)(_sb),(lzo_uint)(_ss),(lzo_bytep)(_db),(lzo_uintp)(&(_ds)),(_wm))
# define  _m0LZOETRANSLATE(_e)                   ((Word)((_e == LZO_E_OK) ? (0x0000) : (0x0200-(_e+1))))


  _m0FUNC_PUBLIC(Word,m0LZOInitLibrary)(
                                       )
  {

    return(_m0LZOETRANSLATE(lzo_init()));

  }


  _m0FUNC_PUBLIC(LongInt,m0LZOCompressBuffSize)(_m0VAR( ASize,LongInt)
                                               )
  {

    return((ASize+(ASize/64)+16+3));

  }


  _m0FUNC_PUBLIC(Word,m0LZOCompress)(_m0VAR( ADest,Pointer),
                                     _m0VAR(*ADLen,LongInt),
                                     _m0VAR( ASour,Pointer),
                                     _m0VAR( ASLen,LongInt)
                                    )
  {

    return(_m0LZOETRANSLATE(_m0LZOCALLFUNC(lzo1x_1_compress,ADest,*ADLen,ASour,ASLen,Gm0LZOWrkMem)));

  }


  _m0FUNC_PUBLIC(Word,m0LZODecompress)(_m0VAR( ADest,Pointer),
                                       _m0VAR(*ADLen,LongInt),
                                       _m0VAR( ASour,Pointer),
                                       _m0VAR( ASLen,LongInt)
                                      )
  {

    return(_m0LZOETRANSLATE(_m0LZOCALLFUNC(lzo1x_decompress_safe,ADest,*ADLen,ASour,ASLen,NULL)));

  }


# pragma pack (pop)
# pragma on (unreferenced)


#endif
