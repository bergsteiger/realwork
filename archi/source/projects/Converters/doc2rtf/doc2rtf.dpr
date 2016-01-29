program doc2rtf;

{ $Id: doc2rtf.dpr,v 1.2 2015/11/02 10:49:32 fireton Exp $ }

{$I evDefine.inc}
{$I ProjectDefine.inc}

uses
 Windows,
 SysUtils,
 Classes,

 l3Types,
 l3Base,
 l3Chars,
 l3ConInd,
 l3Stream,
 l3String,
 l3Memory,

 ddFileFormats,
 ddDoc2Rtf

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
 Writeln(DS('Использование: doc2rtf <входной файл> [<выходной файл>]'));
end;

var
 InFileNameIndex : Long;
 Switch          : String;
 l_InFileName  : string;
 l_OutFileName : string;
 l_In, l_Out   : Tl3FileStream;
 l_Format      : TddFileFormat;
 l_RTFHandle   : THandle;
 l_FinStream   : Tl3HMemoryStream;
begin
 Writeln('DOC to RTF converter, (c) 2014 Garant Service');
 Writeln;

 InFileNameIndex := 1;
 while (InFileNameIndex < ParamCount) do
 begin
  Switch := ParamStr(InFileNameIndex);
  if (Switch[1] = cc_Minus) then
  begin
   Inc(InFileNameIndex);
   Case Switch[2] of
    #0: ;
    {
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
  end
  else
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
  l_OutFilename := ChangeFileExt(l_InFileName, '.rtf');
 l_In := Tl3FileStream.Create(l_InFileName, l3_fmRead);
 try
  l_Format := ddGetFileFormat(l_In);
  if l_Format in [ffDoc, ffDocx] then
  begin
   l_RTFHandle := 0;
   case l_Format of
    ffDoc  : l_RTFHandle := ConvertDocFromStream(l_In);
    ffDocx : l_RTFHandle := ConvertDocxFromStream(l_In);
   end;
   if l_RTFHandle <> 0 then
   begin
    try
     l_FinStream := Tl3HMemoryStream.Create(l_RTFHandle);
     try
      l_Out := Tl3FileStream.Create(l_OutFileName, l3_fmWrite);
      try
       l_FinStream.Seek(0, soFromBeginning);
       l_Out.CopyFrom(l_FinStream, l_FinStream.Size);
       Writeln(DS(Format('Сконвертирован файл %s -> %s', [ExtractFileName(l_InFileName), ExtractFileName(l_OutFileName)])));
      finally
       FreeAndNil(l_Out);
      end;
     finally
      FreeAndNil(l_FinStream);
     end;
    finally
     GlobalFree(l_RTFHandle);
    end;
   end
   else
    Writeln(DS(Format('Не удалось сконвертировать %s образ документа!', [c_SFileFormat[l_Format]])));
  end
  else
   Writeln(DS('ОШИБКА: Указанный файл не является DOC или DOCX файлом (возможно, испорчен).'));
 finally
  FreeAndNil(l_In);
 end;

end.
