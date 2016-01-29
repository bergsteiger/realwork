program html2evd;

{ $Id: html2evd.dpr,v 1.2 2014/03/14 08:48:29 fireton Exp $ }

{$I evDefine.inc}
{$I ProjectDefine.inc}

uses
  SysUtils,
  
  l3Types,
  l3Base,
  l3Chars,
  l3ConInd,
  l3Filer,
  l3String,

  ddHTMLReader,
  evdWriter;

{$R *.RES}
{$R versioninfo.res}

{$IfDef Delphi3}
{$APPTYPE CONSOLE}
{$EndIf Delphi3}

function DS(const aStr: string): string;
begin
 Result := l3ChangeCodePage(aStr, CP_RussianWin, CP_RussianDOS);
end;

procedure BadParams(const aMsg: string);
begin
 Writeln(DS(aMsg));
 Writeln;
 Writeln(DS('Использование: html2evd <входной файл> [<выходной файл>]'));
end;

var
 InFileNameIndex : Long;
 Switch          : String;
 InFiler,
 OutFiler      : TevDOSFiler;
 Reader        : TddHTMLReader;
 Generator     : TevdNativeWriter;
 Indicator     : Tl3ConsoleIndicator;
 Dt            : TDateTime;
 l_InFileName  : string;
 l_OutFileName : string;
begin
 Writeln('HTML to Everest converter, (c) 2014 Garant Service');
 Writeln;
 InFiler := TevDOSFiler.Create(nil);
 try
  OutFiler := TevDOSFiler.Create(nil);
  try
   Reader := TddHTMLReader.Create(nil);
   try
    InFileNameIndex := 1;
    (*
    while (InFileNameIndex < ParamCount) do
    begin
     Switch := ParamStr(InFileNameIndex);
     if (Switch[1] = cc_Minus) then begin
      Inc(InFileNameIndex);
      Case Switch[2] of
       'l', 'L': begin
        EverestReader.CharsInLine := StrToInt(Copy(Switch, 3, Length(Switch)-2));
       end;{'l'..}
       else
       begin
        BadParams(Format('Неизвестная опция (%s) в параметрах', [Switch[2]]));
        Exit;
       end;
      end;
      {..cc_Minus..}
     end else
      break;
    end;{while InFileNameIndex..}
    *)

    l_InFileName := Trim(ParamStr(InFileNameIndex));
    l_OutFilename := Trim(ParamStr(Succ(InFileNameIndex)));

    if (l_InFileName = '') then
    begin
     BadParams('Не указан входной файл');
     Exit;
    end;
    if not FileExists(l_InFileName) then
    begin
     BadParams(Format('Файл %s не найден.', [l_InFileName]));
     Exit;
    end;
    if l_OutFilename = '' then
     l_OutFilename := ChangeFileExt(l_InFileName, '.evd');
    InFiler.FileName := l_InFilename;
    OutFiler.FileName := l_OutFilename;
    Generator := TevdNativeWriter.Create(nil);
    try
     Indicator := Tl3ConsoleIndicator.Create;
     try
      Indicator.NeedProgressProc := true;
      InFiler.Indicator := Indicator;
      Reader.Filer := InFiler;
      Generator.Filer := OutFiler;
      Reader.Generator := Generator;
      Dt := Now;
      OutFiler.Mode := l3_fmWrite;
      OutFiler.Open;
      try
       try
        Reader.Execute;
       except
        on E: Exception do
        begin
         Writeln;
         Writeln(DS(Format('Произошла ошибка: %s', [E.Message])));
         ExitCode := 1;
        end;
       end;
       Dt := Now - Dt;
       WriteLn;
       WriteLn('Conversion Time ' + TimeToStr(Dt));
      finally
       OutFiler.Close;
      end;{try..finally}
     finally
      l3Free(Indicator);
     end;{try..finally}
    finally
     l3Free(Generator);
    end;{try..finally}
   finally
    l3Free(Reader);
   end;{try..finally}
  finally
   l3Free(OutFiler);
  end;{try..finally}
 finally
  l3Free(InFiler);
 end;{try..finally}
end.
