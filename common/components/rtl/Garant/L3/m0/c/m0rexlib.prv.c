/*
//
// module:  m0rexlib.prv.c
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: m0rexlib.prv.c,v 1.1 2008/02/07 09:54:19 lulin Exp $
//
*/
#ifndef   _m0REXLIB_PRV_C
#define   _m0REXLIB_PRV_C


# pragma off (unreferenced)
# pragma pack (push,1)


  _m0VAR(Gm0REXTranslateTable,Char)[CHAR_SET_SIZE];
  _m0VAR(Gm0REXTranslateFlags,LongBool)=0;


  _m0FUNC_PRIVATE(PChar,_GetTranslateTable)(
                                           )
  { 

    _m0VAR(LIndex,int);


    if (Gm0REXTranslateFlags == 0)
     {

       for (LIndex=0; (LIndex < CHAR_SET_SIZE); LIndex++)
        {
      
          Gm0REXTranslateTable[LIndex]=(Char)(ISUPPER(LIndex) ? (tolower(LIndex)) : (LIndex));
 
        }
 
       Gm0REXTranslateFlags=1;
      
     };

    return((PChar)(Gm0REXTranslateTable));

  }


# pragma pack (pop)
# pragma on (unreferenced)


#endif
