{$I VER.INC}

program Stub;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  {$IFNDEF ZF}
  FlexCompress
  {$ELSE}
  ZipForge
  {$ENDIF}
  ;
var
  {$IFDEF FC}
  Archiver : TFlexCompress;
  {$ENDIF}
  {$IFDEF ZF_int}
  Archiver : TZipForge;
  {$ENDIF}
  {$IFDEF ZF}
  Archiver : TZipForge;
  {$ENDIF}
begin
 {$IFDEF FC}
 Archiver := TFlexCompress.Create(nil);
 {$ENDIF}
 {$IFDEF ZF}
 Archiver := TZipForge.Create(nil);
 {$ENDIF}
 {$IFDEF ZF_int}
 Archiver := TZipForge.Create(nil);
 {$ENDIF}
 Archiver.FileName := ParamStr(0);
 Archiver.BaseDir := ExtractFilePath(ParamStr(0));
 Archiver.OpenArchive(fmOpenRead + fmShareDenyNone);
 Archiver.ExtractFiles('*.*');
 Archiver.CloseArchive;
end.
 