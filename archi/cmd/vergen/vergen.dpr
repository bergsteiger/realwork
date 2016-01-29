program vergen;

{$APPTYPE CONSOLE}

uses
  SysUtils,

  l3Types,
  l3Base,
  l3Inifile,
  l3Filer;

procedure GenerateRC(const aKey: string; const aBuildNo: Integer);
var
 I: Integer;
 l_AppDesc: string;
 l_IniName: string;
 l_Ini    : TCfgList;
 l_Pos: Integer;
 l_RCFile : Tl3DOSFiler;
 l_VerNum: string;
 l_V: array [1..3] of Integer;
 l_VerNumComma: string;
begin
 l_IniName := ChangeFileExt(ParamStr(0), '.ini');
 l_Ini := TCfgList.Create(l_IniName);
 try
  l_Ini.Section := aKey;
  l_AppDesc := l_Ini.ReadParamStrDef('AppDesc', '');
  if l_AppDesc <> '' then
  begin
   l_VerNum := l_Ini.ReadParamStrDef('VerNum', '');
   l3FillChar(l_V, SizeOf(l_V));
   for I := 1 to 3 do
   begin
    l_Pos := Pos('.', l_VerNum);
    if l_Pos > 0 then
    begin
     l_V[I] := StrToIntDef(Copy(l_VerNum, 1, l_Pos-1), 0);
     Delete(l_VerNum, 1, l_Pos);
    end
    else
    begin
     l_V[I] := StrToIntDef(l_VerNum, 0);
     Break;
    end;
   end;

   l_VerNum := Format('%d.%d.%d.%d', [l_V[1], l_V[2], l_V[3], aBuildNo]);
   l_VerNumComma := Format('%d, %d, %d, %d', [l_V[1], l_V[2], l_V[3], aBuildNo]);

   l_RCFile := Tl3DOSFiler.Make('versioninfo.rc', l3_fmWrite);
   try
    l_RCFile.Open;
    l_RCFile.WriteLn('154 VERSIONINFO');
    l_RCFile.Writeln(Format('FILEVERSION %s', [l_VerNumComma]));
    l_RCFile.Writeln(Format('PRODUCTVERSION %s', [l_VerNumComma]));
    l_RCFile.Writeln('FILEFLAGSMASK VS_FFI_FILEFLAGSMASK');
    l_RCFile.Writeln('FILEFLAGS VS_FF_PRERELEASE');
    l_RCFile.Writeln('FILEOS VOS__WINDOWS32');
    l_RCFile.Writeln('FILETYPE VFT_APP');
    l_RCFile.Writeln('{');
    l_RCFile.Writeln(' BLOCK "StringFileInfo"');
    l_RCFile.Writeln(' {');
    l_RCFile.Writeln('  BLOCK "041904E3"');
    l_RCFile.Writeln('  {');
    l_RCFile.Writeln('   VALUE "CompanyName", "НПП \"Гарант-Сервис-Университет\"\000"');
    l_RCFile.Writeln(Format('   VALUE "FileDescription", "%s\000"', [l_AppDesc]));
    l_RCFile.Writeln('   VALUE "LegalCopyright", "Copyright \251 2015, ООО \"НПП \"Гарант-Сервис-Университет\"\000"');
    l_RCFile.Writeln(Format('   VALUE "ProductName", "%s\000"', [aKey]));
    l_RCFile.Writeln(Format('   VALUE "FileVersion", "%s\000"', [l_VerNum]));
    l_RCFile.Writeln(Format('   VALUE "ProductVersion", "%s\000"', [l_VerNum]));
    l_RCFile.Writeln(Format('   VALUE "OriginalFilename", "%s.exe\000"', [aKey]));
    l_RCFile.Writeln('  }');
    l_RCFile.Writeln(' }');
    l_RCFile.Writeln(' BLOCK "VarFileInfo"');
    l_RCFile.Writeln(' {');
    l_RCFile.Writeln('  VALUE "Translation", 0x419, 1251');
    l_RCFile.Writeln(' }');
    l_RCFile.Writeln('}');
   finally
    FreeAndNil(l_RCFile);
   end;
   l_Ini.WriteParamStr('VerNum', l_VerNum);
  end
  else
   Writeln(Format('ERROR: No description of %s in INI file!', [aKey]));
 finally
  FreeAndNil(l_Ini);
 end;
end;

var
 l_BuildNo: Integer;

begin
 Writeln('Version Info Generator, v. 1.1');
 if ParamCount > 1 then
 begin
  l_BuildNo := StrToIntDef(ParamStr(2), -1);
  if l_BuildNo > 0 then
   GenerateRC(ParamStr(1), l_BuildNo)
  else
   Writeln('Buld number should be a positive integer number!');
 end
 else
  Writeln('USAGE: VERGEN <appname> <build number>');
end.
