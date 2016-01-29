(*
//
// module:  makedata.dpr
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: makedata.dpr,v 1.1 2008/02/07 09:54:17 lulin Exp $
//
*)
program MakeData; {$R *.res}


 uses
        Windows,Messages,SysUtils,Consts,Classes{$IFDEF _m0USEFORMS1},Forms{$ENDIF},

        m0Const,m0AddTyp,m0EXCLib;
        

 procedure   _Begin(
                   );
 var
        LHandle:                  Integer;
        LLength:                  LongInt;
        LResultString:            string;
        LStingListIndex:          LongInt;
        LStringList:              TStringList;
        LStringListString:        string;
 begin

  try

   if (ParamCount() <> 1)
    then
     begin
 
      Halt(1);
 
     end
    else
     begin
 
      LStringList:=TStringList.Create();
       try
 
        with LStringList do
         begin
 
          LoadFromFile(ParamStr(1));
 
          LResultString:='';
 
          for LStingListIndex:=0 to Pred(Count) do
           begin
 
            LStringListString:=Strings[LStingListIndex];
 
            if (LResultString = '')
             then
              begin
 
               LResultString:=LStringListString;
 
              end
             else
              begin
 
               LResultString:=LResultString+'|'+LStringListString;
 
              end;
 
           end;
 
          LResultString:='('+LResultString+')\''';
 
          LHandle:=FileCreate(ChangeFileExt(ParamStr(1),'.bin'));
           try
 
            if (LHandle = -1)
             then
              begin
 
               Halt(1);
 
              end
             else
              begin
 
               LLength:=Succ(Length(LResultString));
 
               if (FileWrite(LHandle,PChar(LResultString)^,LLength) <> LLength)
                then
                 begin
 
                  Halt(1);
 
                 end;
 
              end;
 
           finally
 
            FileClose(LHandle);
 
           end;
 
         end;
 
       finally
 
        LStringList.Free();
 
       end;
 
     end;

  except

   m0EXCHandleException();

  end;

 end;


 begin _Begin();


end.

