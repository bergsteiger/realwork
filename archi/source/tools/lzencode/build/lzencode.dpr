(*
//
// module:  lzencode.dpr
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: lzencode.dpr,v 1.3 2000/01/06 14:39:12 migel Exp $
//
*)
program LZEncode; {$R *.res}


 {$I m0Define.inc}
 {$I m0DefOpt.inc}


 uses
        Windows,Messages,SysUtils,Consts,Classes{$IFDEF _m0USEFORMS1},Forms{$ENDIF},

        m0Const,m0AddTyp,m0EXCLib,
        mgConst,mgExFStr,mgArcStr,mgLZOStr;


 procedure   _Begin(
                   );
 var
        LLZOStream:               TmgLZOStream;
        LPHUStream1:              TmgExFileStream;
        LPHUStream2:              TmgExFileStream;
 begin

  try

   if (ParamCount() = 2)
    then
     begin
 
      LPHUStream1:=TmgExFileStream.Create(ParamStr(1),fmOpenReadWrite);
       try
 
        LPHUStream2:=TmgExFileStream.Create(ParamStr(2),fmCreate);
         try
 
          LLZOStream:=TmgLZOStream.Create(LPHUStream2,CmgArcStrEncode);
           try
 
            LLZOStream.CopyFrom(LPHUStream1,0);
 
           finally
 
            LLZOStream.Free();
 
           end;
 
         finally
 
          LPHUStream2.Free();
 
         end;
 
       finally
 
        LPHUStream1.Free();
 
       end;
 
     end;

  except

   m0EXCHandleException();

  end;

 end;


 begin _Begin();


end.
