program Appender;

//{$APPTYPE CONSOLE}

uses
 SysUtils,
 l3Types,
 l3Filer,
 l3Base
 ;

var
 F : Tl3CustomDOSFiler;
 N : AnsiString;
begin
 try
  N := ParamStr(1);
  F := Tl3CustomDOSFiler.Make(N, l3_fmAppend, false);
  try
   F.Open;
   try
    F.WriteLn(ParamStr(2));
   finally
    F.Close;
   end;//try..finally
  finally
   FreeAndNil(F);
  end;//try..finally
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//try..except
end.