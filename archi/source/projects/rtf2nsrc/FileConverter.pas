unit FileConverter;
{ Преобразователь форматов }

{ $Id: FileConverter.pas,v 1.1 2011/06/23 07:01:33 narry Exp $ }

// $Log: FileConverter.pas,v $
// Revision 1.1  2011/06/23 07:01:33  narry
// Консольная версия RTF2NSRC (253668575)
//

interface

type
  TInOutFormat = (ifUnknown, ifRTF, ifNSR, ifDOC, ifEVD);


 TFileConverter = class(TObject)
  procedure WriteHelp;
 private
  f_FileMask: string;
  f_InFormat: TInOutFormat;
  f_OutFormat: TInOutFormat;
  procedure ConvertFiles;
  function ConvertOneFile(const InName: String): Boolean;
  function GetFormat(const InName: String): TInOutFormat;
  procedure ReadParameters;
  procedure SetDefaultParameters;
 public
  procedure Run;
 end;

implementation

uses
 ddFileIterator, SysUtils, evdWriter, ddNSRC_w, ddDOCReader, k2TagGen, evEvdRd, ddRTFWriter, Math,
 evSimpleTextPainter, k2Reader, ddNSRC_R;

procedure TFileConverter.ConvertFiles;
begin
 with TddFileIterator.Make(ExtractFilePath(f_Filemask), ExtractFileName(f_FileMask)) do
 try
  IterateFiles(ConvertOneFile);
  ExitCode:= IfThen(IterateStatus, 0, 1);
 finally
  Free;
 end;
end;

function TFileConverter.ConvertOneFile(const InName: String): Boolean;
var
 l_Gen: Tk2TagGenerator;
begin
 l_Gen:= nil;
 try
  case f_OutFormat of
   ifRTF : l_Gen:= TevRTFObjectGenerator.SetTo(l_Gen, ChangeFileExt(InName, '.rtf'));
   ifNSR :
    begin
     l_Gen:= TddNSRCGenerator.SetTo(l_Gen, ChangeFileExt(InName, '.nsr'));
     TevSimpleTextPainter.SetTo(l_Gen);
    end;
   ifEVD : l_Gen:= TevdNativeWriter.SetTo(l_Gen, ChangeFileExt(InName, '.evd'));
  end;
  case f_InFormat of
   ifRTF,
   ifDOC:
    begin
     l_Gen:= TddDocReader.SetTo(l_Gen, InName);
     TddDocReader(l_Gen).LightVersion:= True;
    end; // ifDOC
   ifNSR: l_Gen:= TCustomNSRCReader.SetTo(l_Gen, InName);
   ifEVD: l_Gen:= TevEvdReader.SetTo(l_Gen, InName);
  end;
  Tk2CustomFileParser(l_Gen).Execute;
 finally
  FreeAndNil(l_Gen);
 end;
end;

function TFileConverter.GetFormat(const InName: String): TInOutFormat;
var
  S: String;
begin
  S:= UpperCase(ExtractFileExt(InName));
  if S = '.RTF' then
    Result:= ifRTF
  else
  if (S = '.NSR') then
    Result:= ifNSR
  else
  if (S = '.DOC') then
    Result:= ifDOC
  else
  if (S = '.EVD') then
   Result:= ifEVD
  else
    Result:= ifUnknown;
end;

procedure TFileConverter.ReadParameters;
var
 l_Format: String;
begin
 // Должен быть как минимум один параметр - имя файла
 if ParamCount > 0 then
 begin
  f_FileMask:= ParamStr(1);
  f_InFormat:= GetFormat(f_FileMask);
  l_Format:= ParamStr(2);
  if length(l_Format) = 2 then
  begin
   // Формат зависит от значения
   if l_Format[2] = 'r' then
    f_OutFormat:= ifRTF
   else
   if l_Format[2] = 'n' then
    f_OutFormat:= ifNSR
   else
   if l_Format[2] = 'e' then
    f_OutFormat:= ifEVD;
  end; // length(l_Format = 2)
 end // ParamCount > 0
 else
  WriteHelp;
end;

procedure TFileConverter.Run;
begin
 SetDefaultParameters;
 ReadParameters;
 if (f_Informat <> ifUnknown) and (f_OutFormat <> ifUnknown) and (f_InFormat <> f_OutFormat) then
  ConvertFiles
 else
  ExitCode:= 1;
end;

procedure TFileConverter.SetDefaultParameters;
begin
 f_InFormat:= ifUnknown;
 f_OutFormat:= ifNSR;
 f_FileMask:= '';
end;

procedure TFileConverter.WriteHelp;
begin
 Writeln('FileConverter. Garant file format converter.');
 Writeln('');
 Writeln('Usage:');
 Writeln('FileConverter <filename> [-n|-r|-e]');
 Writeln('   <filename> - source filename or mask');
 Writeln('   -n|-r|-e - destination format');
 Writeln('     -n - nsrc (default)');
 Writeln('     -r - rtf');
 Writeln('     -e - evd');
end;

end.
