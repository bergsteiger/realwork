program NSRC2Everest;

{ $Id: nsrc2everest.dpr,v 1.2 2014/07/16 10:54:03 fireton Exp $ }

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

  k2TagGen,

  evdWriter,
  evdTopicFileSplitter,
  ddNSRC_r,
  ddFormula2PictureFilter
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
 Writeln(DS('Использование: nsrc2everest [-t] [-f] <входной файл> [<выходной файл>]'));
 Writeln(DS('  -t - текстовый формат evd'));
 Writeln(DS('  -f - формулы преобразуются в картинки'));
 Writeln(DS('  -s - каждый топик в отдельный файл (для NSRC c несколькими топиками)'));
 ExitCode := 1;
end;

var
 InFileNameIndex : Long;
 Switch          : String;
 l_InFileName  : string;
 l_OutFileName : string;
 l_IsTextFormat: Boolean;
 l_IsFormulasAsPics : Boolean;
 l_IsSplit : Boolean;
 l_Gen: Tk2TagGenerator;
begin
 Writeln('NSRC to Everest converter, (c) 2014 Garant Service');
 Writeln;
 ExitCode := 0;

 InFileNameIndex := 1;
 l_IsTextFormat := False;
 l_IsFormulasAsPics := False;
 l_IsSplit := False;
 while (InFileNameIndex < ParamCount) do
 begin
  Switch := ParamStr(InFileNameIndex);
  if (Switch[1] = cc_Minus) then
  begin
   Inc(InFileNameIndex);
   case Switch[2] of
    't', 'T': l_IsTextFormat := True;
    'f', 'F': l_IsFormulasAsPics := True;
    's', 'S': l_IsSplit := True;
   else
    begin
     BadParams(Format('Неизвестная опция (%s) в параметрах', [Switch[2]]));
     Exit;
    end;
   end; {case}
  end {..cc_Minus..}
  else
   Break;
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
  l_OutFilename := ChangeFileExt(l_InFileName, '.evd');

 l_Gen := nil;
 try
  TevdNativeWriter.SetTo(l_Gen, l_OutFileName);
  TevdNativeWriter(l_Gen).Binary := not l_IsTextFormat;
  if l_IsSplit then
   TevdTopicFileSplitter.SetTo(l_Gen, TevdNativeWriter(l_Gen), l_OutFileName);
  if l_IsFormulasAsPics then
   TddFormula2PictureFilter.SetTo(l_Gen);
  TCustomNSRCReader.SetTo(l_Gen, l_InFileName);
  try
   TCustomNSRCReader(l_Gen).Execute;

   if l_IsSplit then
    DeleteFile(l_OutFileName); // а то оно создаётся пустым
  
  except
   on E: Exception do
   begin
    Writeln;
    Writeln(DS(Format('Произошла ошибка: %s', [E.Message])));
    ExitCode := 1;
   end;
  end;
 finally
  FreeAndNil(l_Gen);
 end;
end.
