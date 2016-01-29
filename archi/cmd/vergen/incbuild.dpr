program incbuild;

{$APPTYPE CONSOLE}

uses
 SysUtils,

 l3Types,
 l3Base,
 l3Inifile,
 l3Filer;

procedure IncrementBuildNumber;
var
 l_Ini: TCfgList;
 l_Cmd: Tl3DOSFiler;
 l_BuildNo: Integer;
begin
 l_Ini := TCfgList.Create;
 try
  l_Ini.Section := 'Settings';
  l_BuildNo := l_Ini.ReadParamIntDef('BuildNo', 0);
  Inc(l_BuildNo);
  l_Cmd := Tl3DOSFiler.Make('setbuildno.cmd', l3_fmWrite);
  try
   l_Cmd.Open;
   l_Cmd.WriteLn(Format('SET BUILDNO=%d', [l_BuildNo]));
  finally
   FreeAndNil(l_Cmd);
  end;
  l_Ini.WriteParamInt('BuildNo', l_BuildNo);
 finally
  FreeAndNil(l_Ini);
 end;
end;


begin
 IncrementBuildNumber;
end.
