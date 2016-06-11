{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

program DSProxyReg;

{$APPTYPE CONSOLE}

uses
  Data.DBXCommon,
  Data.DBXPlatform,
  Datasnap.DSHTTPLayer,
  Datasnap.DSProxyCpp,
  Datasnap.DSProxyCppRest,
  Datasnap.DSProxyDelphi,
  Datasnap.DSProxyDelphiRest,
  Datasnap.DSProxyJavaScript,
  Datasnap.DSProxyWriter,
  DataSnap.DSProxyCSharpSilverlight,
  DataSnap.DSProxyJavaAndroid,
  DataSnap.DSProxyJavaBlackberry,
  DataSnap.DSProxyObjectiveCiOS,
  System.StrUtils,
  System.SysUtils,
  Datasnap.DSProxyWriterRegistry in 'Datasnap.DSProxyWriterRegistry.pas';

resourcestring
  sUsage =
  'syntax'#13#10#9 +
  'DSPROXYREG [options] [filename]'#13#10 +
  'filename'#13#10 +
  #9'proxy writer package to register'#13#10 +
  'options'#13#10 +
  #9'[-u] = Unregister a proxy writer package'#13#10 +
  #9'[-r] = Register a proxy writer packages'#13#10 +
  #9'[-l] = List registered proxy writer packages'#13#10 +
  #9'[-lw] = List registered proxy writers';
  sExamples =
  'examples'#13#10 +
  #9'DSPROXYREG -r MyProxyWriter.bpl'#13#10 +
  #9'DSPROXYREG MyProxyWriter.bpl'#13#10 +
  #9'DSPROXYREG -u MyProxyWriter.bpl'#13#10 +
  #9'DSPROXYREG -l'#13#10 +
  #9'DSPROXYREG -lw'#13#10;
  sRegisterPackageFile = 'Register %s';
  sUnregisterPackageFile = 'Unregister %s';
  sListWritersTitle = 'Proxy Writers'#13#10;
  sListPackageFilesTitle = 'Registered packages';
  sDisabledPackageFile = 'File Name: "%s" (disabled)';
  sEnabledPackageFile = 'File Name: "%s"';
  sWriterProperties =
   'Name:        "%0:s"'#13#10 +
   'Extension:   %1:s'#13#10 +
   'Client Type: %2:s'#13#10 +
   'Author:      %3:s';
  sWriterComment =
   'Comment:     %0:s';
  sDBXClientType = 'DBX';
  sRESTClientType = 'REST';
  sNotRegistered = '%s is not registered';
  sAlreadyRegistered = '%s is already registered';
  sExceptionError = '%0:s: %1:s';

const
  sRegister = '-r';
  sUnregister = '-u';
  sListPackages = '-l';
  sListWriters = '-lw';

function TryGetSwitch(const AParam, AOption: string): Boolean;
begin
  Result := CompareText(AParam, AOption) = 0;
end;

procedure WriteUsage;
begin
  Writeln(sUsage);
  Writeln(sExamples);
end;

procedure WriteProxyWriterProperties(const AWriter: string);
var
  DSProxyWriter: TDSProxyWriter;
  Ext: string;
  ClientType: string;
begin
  DSProxyWriter := TDSProxyWriterFactory.GetWriter(AWriter);
  if Length(DSProxyWriter.FileDescriptions) > 0 then
    Ext := DSProxyWriter.FileDescriptions[0].DefaultFileExt
  else
    Ext := '';
  if feRESTClient in DSProxyWriter.Properties.Features then
    ClientType := sRESTClientType
  else if feDBXClient in DSProxyWriter.Properties.Features then
    ClientType := sDbxClientType
  else
    ClientType := '';
  WriteLn(Format(sWriterProperties, [AWriter, Ext, ClientType, DSProxyWriter.Properties.Author]));
  if DSProxyWriter.Properties.Comment <> '' then
    WriteLn(Format(sWriterComment, [DSProxyWriter.Properties.Comment]));
  WriteLn;
end;


type
  TOperation = (opRegister, opUnregister, opListPackages, opListWriters);
  TOperations = set of TOperation;
  TDSProxyRegException = class(Exception);

var
  FileName: string;
  Param: string;
  I: Integer;
  Operations: TOperations;
  PackageFileList: TDSProxyWriterPackageFileList;
  Packages: TObject;
  Writers: TDBXStringArray;
  Writer: string;
  PackageFile: TDSProxyWriterPackageFile;
begin
  if ParamCount = 0 then
  begin
    WriteUsage;
    Exit;
  end;
  Operations := [];
  try
    for I := 1 to ParamCount do
    begin
      Param := ParamStr(I);
      if CompareText(LeftStr(Param, 1), '-') = 0 then
      begin
        if TryGetSwitch(Param, sRegister) then
          Include(Operations, opRegister)
        else if TryGetSwitch(Param, sUnregister) then
          Include(Operations, opUnregister)
        else if TryGetSwitch(Param, sListPackages) then
          Include(Operations, opListPackages)
        else if TryGetSwitch(Param, sListWriters) then
          Include(Operations, opListWriters)
        else
        begin
          WriteUsage;
          Exit;
        end;
      end
      else if FileName = '' then
        FileName := ParamStr(I)
      else
      begin
        WriteUsage;
        Exit;
      end;
    end;
    if Operations = [] then
    begin
      if FileName <> '' then
        Include(Operations, opRegister)
      else
      begin
        WriteUsage;
        Exit;
      end;
    end;
    if Operations * [opRegister, opUnregister] <> [] then
      if FileName = '' then
      begin
        WriteUsage;
        Exit;
      end;
    PackageFileList := TDSProxyWriterPackagesLoader.LoadPackageList;
    try
      if opRegister in Operations then
      begin
        if PackageFileList.Contains(FileName) then
          raise TDSProxyRegException.CreateFmt(sAlreadyRegistered, [FileName]);
        PackageFileList.Add(FileName, FileName);
        WriteLn(Format(sRegisterPackageFile, [FileName]));
      end;
      if opUnregister in Operations then
      begin
        if not PackageFileList.Contains(FileName) then
          raise TDSProxyRegException.CreateFmt(sNotRegistered, [FileName]);
        PackageFileList.Remove(FileName);
        WriteLn(Format(sUnregisterPackageFile, [FileName]));
      end;
      if opListPackages in Operations then
      begin
        WriteLn(sListPackageFilesTitle);
        for PackageFile in PackageFileList.List do
        begin
          if PackageFile.Disabled then
            WriteLn(Format(sDisabledPackageFile, [PackageFile.FileName]))
          else
            WriteLn(Format(sEnabledPackageFile, [PackageFile.FileName]));
        end;
      end
      else if opListWriters in Operations then
      begin
        WriteLn(sListWritersTitle);
        Packages := TDSProxyWriterPackagesLoader.LoadPackages(PackageFileList);
        try
          Writers := TDSProxyWriterFactory.RegisteredWritersList;
          for Writer in Writers do
            WriteProxyWriterProperties(Writer);
        finally
          Packages.Free;
        end;
      end;
      if PackageFileList.Modified then
        TDSProxyWriterPackagesLoader.SavePackageList(PackageFileList);

    finally
      PackageFileList.Free;
    end;
  except
    on E: Exception do
      Writeln(Format(sExceptionError, [E.Classname, E.Message]));
  end;

end.
