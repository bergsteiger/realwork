program StgUpdate;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  StrUtils,
  
  Crt,

  l3Chars,
  l3Types,
  l3Base,
  l3String,

  m4DB,
  m4DBInterfaces;

type
 TprjService = class(Tl3Base)
  private
   fMaxValue : longint;
   procedure ProgressProc(aState: Byte; aValue: Longint; const aMsg: string);
 end;

procedure TprjService.ProgressProc(aState: Byte; aValue: Longint; const aMsg: string);
var
 lPercent : Integer;
begin
 case aState of
  piStart:
   begin
    fMaxValue := aValue;
    if fMaxValue = 0 then fMaxValue := 1;
    lPercent := 0;
    WriteLn(format('%s', [l3ChangeCodePage(aMsg, CP_ANSI, CP_OEM)]));
   end;//piStart
  piCurrent:
   try
    lPercent := aValue * 100 div fMaxValue;
    GotoXY(1, WhereY);
    Write(format('%d%% %s', [lPercent, l3ChangeCodePage(aMsg, CP_ANSI, CP_OEM)]));
   except
   end;//piCurrent
  piEnd:
  begin
   WriteLn;
  end;//piEnd
 end;//Case aState

 //ProgressProc(aState, 0, aValue, aMsg);
end;


var
 l_BaseName   : String;
 f_DB         : Im4DB;
 lNoDel       : Boolean;
 lNoTextIndex : Boolean;
 i            : Integer;
begin
 WriteLn('Archi documents STG updater.');
 if (ParamCount < 1) then
 begin
  WriteLn('usage: StgUpdate BaseName [/-i] [/-d]');
  WriteLn('/-i   - no build text index');
  WriteLn('/-d   - no purge deleted files');
  Exit;
 end;

 lNoDel := False;
 lNoTextIndex:= False;

 with TprjService.Create do
 try
  l_BaseName := ParamStr(1);

  for i := 2 to ParamCount do
  begin
   if AnsiContainsText(ParamStr(I), '/-d') then
    lNoDel := True;
   if AnsiContainsText(ParamStr(I), '/-i') then
    lNoTextIndex := True;
  end;

  f_DB := Tm4DB.Make(l_BaseName,
                     false,
                     nil, //Yield
                     nil, //FileMeter.ProgressProc_ev,
                     ProgressProc);
  try
   f_DB.Start;
   try
    if not lNoTextIndex then
     f_DB.UpdateIndex;

    if f_DB.Update then
    begin
     WriteLn('Update Success');
     if not lNoDel then
     begin
      WriteLn(Format('Purge %d file(s)', [f_DB.Purge]));
      // f_DB.DeleteVersions;
     end;
    end
    else
     WriteLn('Update Failed');
   finally
    f_DB.Finish;
   end;//try..finally
  finally
   f_DB := nil;
  end;
 finally
  Free;
 end;
end.
