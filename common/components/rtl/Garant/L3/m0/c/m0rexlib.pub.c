/*
//
// module:  m0rexlib.pub.c
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: m0rexlib.pub.c,v 1.1 2008/02/07 09:54:19 lulin Exp $
//
*/
#ifndef   _m0REXLIB_PUB_C
#define   _m0REXLIB_PUB_C


# pragma off (unreferenced)
# pragma pack (push,1)


# define  _m0REXETRANSLATE(_e)                   ((Word)((_e == REG_NOERROR) ? (0x0000) : (0x0200+(_e-1))))


  _m0FUNC_PUBLIC(Word,m0REXAllocEx)(_m0VAR(*AHandle,Pointer),
                                    _m0VAR( APatern,PChar),
                                    _m0VAR( ASize,LongInt),
                                    _m0VAR( AICase,LongBool)
                                   )
  {

    _m0VAR(LResult,int);


    if ((LResult=(((APatern == NULL) || ((*AHandle=malloc(sizeof(struct re_pattern_buffer))) == NULL)) ? (REG_ESPACE) : (REG_NOERROR))) != REG_NOERROR) ;
    else
     {

       ((struct re_pattern_buffer*)(*AHandle))->buffer=NULL;
       ((struct re_pattern_buffer*)(*AHandle))->allocated=0;

       ((struct re_pattern_buffer*)(*AHandle))->translate=((AICase == 0) ? (NULL) : (_GetTranslateTable()));

       if ((LResult=regex_compile(APatern,ASize,(RE_SYNTAX_POSIX_EGREP | RE_NO_EMPTY_RANGES),*AHandle)) != REG_NOERROR) m0REXFree(&(*AHandle));
       else
        {

          if ((LResult=(((((struct re_pattern_buffer*)(*AHandle))->fastmap=malloc(1 << BYTEWIDTH)) == NULL) ? (REG_ESPACE) : (REG_NOERROR))) != REG_NOERROR) m0REXFree(&(*AHandle));
          else
           {

            if ((LResult=((re_compile_fastmap(*AHandle) != 0) ? (REG_ESPACE) : (REG_NOERROR))) != REG_NOERROR) m0REXFree(&(*AHandle));
            else
             {
  
               ((struct re_pattern_buffer*)(*AHandle))->regs_allocated=REGS_FIXED;
  
             };

           };

        };

     };

    return(_m0REXETRANSLATE(LResult));

  }


  _m0FUNC_PUBLIC(Word,m0REXExecEx)(_m0VAR( AHandle,Pointer),
                                   _m0VAR( AText,PChar),
                                   _m0VAR( ASize,LongInt),
                                   _m0VAR( ABegPos,PLongInt),
                                   _m0VAR( AEndPos,PLongInt)
                                  )
  {

    _m0VAR(LBegPos,regoff_t);
    _m0VAR(LEndPos,regoff_t);
    _m0VAR(LRegisters,struct re_registers);
    _m0VAR(LResult,int);


    if ((AHandle == NULL) || (AText == NULL)) LResult=REG_ESPACE;
    else
     {

       LRegisters.num_regs=1;

       LRegisters.start=&LBegPos;
       LRegisters.end=&LEndPos;

       if ((LResult=((re_search(AHandle,AText,ASize,0,ASize,(((ABegPos != NULL) || (AEndPos != NULL)) ? (&LRegisters) : (NULL))) >= 0) ? (REG_NOERROR) : (REG_NOMATCH))) == REG_NOERROR)
        {

          if (LBegPos == LEndPos) return(_m0REXETRANSLATE(REG_NOMATCH));

          if (ABegPos != NULL) *ABegPos=LBegPos;
          if (AEndPos != NULL) *AEndPos=LEndPos-1;
  
        };

     };

    return(_m0REXETRANSLATE(LResult));

  }


  _m0FUNC_PUBLIC(void,m0REXFree)(_m0VAR(*AHandle,Pointer)
                                )
  {

    if (*AHandle != NULL)
     {

       if (((struct re_pattern_buffer*)(*AHandle))->buffer != NULL) free (((struct re_pattern_buffer*)(*AHandle))->buffer);
       if (((struct re_pattern_buffer*)(*AHandle))->fastmap != NULL) free (((struct re_pattern_buffer*)(*AHandle))->fastmap);

       free(*AHandle);

       *AHandle=NULL;

     }

  }


# pragma pack (pop)
# pragma on (unreferenced)


#endif
