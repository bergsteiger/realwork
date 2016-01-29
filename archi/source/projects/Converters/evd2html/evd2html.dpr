program evd2html;

{ $Id: evd2html.dpr,v 1.2 2015/10/13 13:22:34 fireton Exp $ }

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
  l3FileUtils,

  k2TagGen,
  k2Reader,

  ddHTMLWriter,
  ddNSRC_r,
  evdReader,
  ddDocTypeDetector,
  ddPipeOutInterfaces
  ;

{$R *.res}
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
 Writeln(DS('Использование: evd2html [-n] <входной файл> [<директория для результата>]'));
 ExitCode := 1;
end;

var
 InFileNameIndex : Long;
 Switch          : String;
 InFiler,
 OutFiler      : TevDOSFiler;
 G             : Tk2TagGenerator;
 Indicator     : Tl3ConsoleIndicator;
 Dt            : TDateTime;
 l_InFileName  : string;
 l_OutDir      : string;
 l_IsNSRC      : Boolean;
 NoTopicIdx    : Integer;

procedure DoOnNewDocument(Sender: TObject; TopicNo: Longint; aPart: TddExportDocPart; MainGroup: ShortString);
var
 l_FN: string;
 l_Written: Integer;
begin
 l_Written := OutFiler.Pos;
 if OutFiler.Opened then
  OutFiler.Close;
 if l_Written = 0 then
  DeleteFile(OutFiler.FileName); // если файл получился пустой, удаляем
 if TopicNo > 0 then
  l_FN := IntToStr(TopicNo)
 else
 begin
  Inc(NoTopicIdx);
  l_FN := ChangeFileExt(ExtractFileName(l_InFileName), '') + '_' + IntToStr(NoTopicIdx);
 end;

 OutFiler.FileName := ConcatDirName(l_OutDir, l_FN + '.html');
 OutFiler.Mode := l3_fmWrite;
 OutFiler.Open;
end;


begin
 Writeln('Everest and NSRC to HTML converter, (c) 2015 Garant Service');
 Writeln;
 InFileNameIndex := 1;
 l_IsNSRC := False;
 while (InFileNameIndex < ParamCount) do
 begin
  Switch := ParamStr(InFileNameIndex);
  if (Switch[1] = cc_Minus) then
  begin
   Inc(InFileNameIndex);
   case Switch[2] of
    'n', 'N': l_IsNSRC := True;
   else
    BadParams(Format('Неизвестная опция (%s) в параметрах', [Switch[2]]));
    Exit;
   end;
  end
  else
   break;
 end;{while InFileNameIndex..}
 l_InFileName := Trim(ParamStr(InFileNameIndex));
 l_OutDir := Trim(ParamStr(Succ(InFileNameIndex)));
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
 if not l_IsNSRC and AnsiSameText('.nsr', ExtractFileExt(l_InFileName)) then
  l_IsNSRC := True;
 if l_OutDir = '' then
  l_OutDir := GetCurrentDir;
 G := nil;
 NoTopicIdx := 0;
 InFiler := TevDOSFiler.Create(nil);
 try
  Indicator := Tl3ConsoleIndicator.Create;
  try
   Indicator.NeedProgressProc := true;
   InFiler.Indicator := Indicator;
   InFiler.Filename := l_InFileName;
   OutFiler := TevDOSFiler.Create(nil);
   try
    OutFiler.Filename := '#doc.html'; // имя нужно, иначе не запустится труба
    OutFiler.Mode := l3_fmWrite;
    try
     TddHTMLGenerator.SetTo(G);
     TddHTMLGenerator(G).Filer := OutFiler;
     TddDocTypeDetector.SetTo(G);
     TddDocTypeDetector(G).OnStartDocumentProc := DoOnNewDocument;
     if l_IsNSRC then
      TCustomNSRCReader.SetTo(G)
     else
      TevdNativeReader.SetTo(G);
     Tk2CustomFileParser(G).Filer := InFiler;
     Dt := Now;
     try
      Tk2CustomFileParser(G).Execute;
     except
      on E: Exception do
      begin
       Writeln;
       Writeln(DS(Format('Произошла ошибка: %s', [E.Message])));
       ExitCode := 1;
      end;
     end; // try..except
     Dt := Now - Dt;
     WriteLn;
     WriteLn(DS('Время обработки: ' + TimeToStr(Dt)));
    finally
     FreeAndNil(G);
    end;
   finally
    FreeAndNil(OutFiler);
   end;
  finally
   FreeAndNil(Indicator);
  end;
 finally
  FreeAndNil(InFiler);
 end;
 //Readln;
end.
