program MFEPacker; {$APPTYPE CONSOLE}

uses
 SysUtils,
 MultiFileEncoder;

procedure GetOpt(out a_InputIniFile: string; out a_OutputMFFile: string);
var
 l_Index: Integer;
begin
 a_InputIniFile := ChangeFileExt(ParamStr(0), '.ini');
 a_OutputMFFile := '';
 //
 l_Index := 1;
 while (l_Index <= ParamCount) do
 begin
  if (CompareText('-ini_file', ParamStr(l_Index)) = 0) then
  begin
   Inc(l_Index);
   //
   a_InputIniFile := ParamStr(l_Index);
  end
  else
  begin
   if (a_OutputMFFile = '') then
    a_OutputMFFile := ChangeFileExt(ParamStr(l_Index), '.mf')
   else
    Break;
  end;
  //
  Inc(l_Index);
 end;
end;

var
 l_InputIniFile: string;
 l_OutputMFFile: string;
begin
 WriteLN;
 WriteLN (Format ('TOOL "%s" (C) SIE "GARANT-SERVICE-UNIVERSITY" LLC, 1990-2016', [ExtractFileName (ParamStr (0))]));
 //
 GetOpt(l_InputIniFile, l_OutputMFFile);
 //
 if (l_OutputMFFile = '') then
 begin
  WriteLN;
  WriteLN ('Available options:');
  WriteLN ('  [-ini_file <input_ini_file>] <output_mf_file>');
  WriteLN;
 end
 else
 begin
  WriteLN;
  WriteLN ('Current options:');
  WriteLN (Format (' Input IniFile: "%s"', [l_InputIniFile]));
  WriteLN (Format (' Output MFFile: "%s"', [l_OutputMFFile]));
  WriteLN;
  //
  with TMultiFileEncoder.Instance do
  begin
   FileName := l_OutputMFFile;
   //
   CryptIniFileItems(l_InputIniFile);
  end;
 end;
end.
