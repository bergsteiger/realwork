program Everest2NSRC;

{ $Id: everest2nsrc.dpr,v 1.5 2014/03/14 10:26:18 fireton Exp $ }

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

  evEvdRd,
  //evEvdWrt,
  ddNSRC_w,
  //evTextFormatter
  evSimpleTextPainter
  ;

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
 Writeln(DS('Использование: everest2nsrc [-l<число символов в строке>] <входной файл> [<выходной файл>]'));
end;

var
 InFileNameIndex : Long;
 Switch          : String;
 InFiler,
 OutFiler      : TevDOSFiler;
 EverestReader : TevEvdReader;
 Formatter     : TevSimpleTextPainter;
 NSRCGenerator : {TevEvdWriter;}TddNSRCGenerator;
 Indicator     : Tl3ConsoleIndicator;
 Dt            : TDateTime;
 l_InFileName  : string;
 l_OutFileName : string;
begin
 Writeln('Everest to NSRC converter (NSRC+), (c) 2001-2014 Garant Service');
 Writeln;
 InFiler := TevDOSFiler.Create(nil);
 try
  OutFiler := TevDOSFiler.Create(nil);
  try
   EverestReader := TevEvdReader.Create(nil);
   try
    InFileNameIndex := 1;
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
     l_OutFilename := ChangeFileExt(l_InFileName, '.nsr');
    InFiler.FileName := l_InFilename;
    OutFiler.FileName := l_OutFilename;
    Formatter := TevSimpleTextPainter.Create(nil);
    try
     NSRCGenerator := TddNSRCGenerator.Create(nil);
     try
      Indicator := Tl3ConsoleIndicator.Create;
      try
       Indicator.NeedProgressProc := true;
       InFiler.Indicator := Indicator;
       EverestReader.Filer := InFiler;
       NSRCGenerator.Filer := OutFiler;
       NSRCGenerator.ExportDirectory := ExtractFileDir(l_OutFileName);
       EverestReader.Generator := Formatter;
       Formatter.Generator := NSRCGenerator;
       {EverestReader.Generator := NSRCGenerator;}
       Dt := Now;
       OutFiler.Mode := l3_fmWrite;
       OutFiler.Open;
       try
        try
         EverestReader.Execute;
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
      l3Free(NSRCGenerator);
     end;{try..finally}
    finally
     l3Free(Formatter);
    end;{try..finally}
   finally
    l3Free(EverestReader);
   end;{try..finally}
  finally
   l3Free(OutFiler);
  end;{try..finally}
 finally
  l3Free(InFiler);
 end;{try..finally}
end.
