{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

program DSProxyGen;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  IPPeerClient,
  Data.DBXCommon,
  Data.DBXDataSnap,
  Data.DBXPlatform,
  Datasnap.DSClientMetadata,
  Datasnap.DSCommonProxy,
  Datasnap.DSHTTPLayer,
  Datasnap.DSProxyCpp,
  Datasnap.DSProxyCppRest,
  Datasnap.DSProxyDelphiNative,
  Datasnap.DSProxyDelphiRest,
  Datasnap.DSProxyJavaScript,
  DataSnap.DSProxyCSharpSilverlight,
  DataSnap.DSProxyJavaAndroid,
  DataSnap.DSProxyJavaBlackberry,
  DataSnap.DSProxyObjectiveCiOS,
  Datasnap.DSProxyWriter,
  System.Generics.Collections,
  System.StrUtils,
  System.SysUtils,
  Datasnap.DSProxyWriterRegistry in 'Datasnap.DSProxyWriterRegistry.pas';

resourcestring
  sUsageSyntax =
  'syntax'#13#10#9 +
  'DSPROXYGEN [options] output [options]'#13#10;
  sUsageOutput =
  'output'#13#10 +
  #9'file name or file extension';
  sUsageOptions =
  'options'#13#10 +
  #9'[-C:connectionstring'#13#10 +
  #9#9'TCP/IP example:'#9'host=localhost;port=211 (default)'#13#10 +
  #9#9'HTTP example:'#9'host=localhost;port=8080;communicationprotocol=http'#13#10 +
  #9'[-IC:includeclasses]'#13#10 +
  #9'[-EC:excludeclasses'#13#10 +
  #9'[-IM:includemethods]'#13#10 +
  #9'[-EM:excludemethods]'#13#10 +
  #9'[-PW:proxywriter]'#13#10 +
  #9'[-REST]'#13#10 +
  #9'[-DBX]';
  sUsageExamples =
  'examples'#13#10 +
  #9'Delphi proxy using default connection'#13#10 +
  #9#9'DSPROXYGEN .pas'#13#10 +
  #9'Delphi REST proxy'#13#10 +
  #9#9'DSPROXYGEN .pas -rest'#13#10 +
  #9'Exclude methods starting with "Echo" and ending with "String"'#13#10 +
  #9#9'DSPROXYGEN .pas -em:Echo*;*String'#13#10 +
  #9'Java Script proxy to file'#13#10 +
  #9#9'DSPROXYGEN c:\temp\servermethods.js'#13#10 +
  #9'Generate using registered writer'#13#10 +
  #9#9'DSPROXYGEN -pw:"Delphi DBX"';
  sExtLanguage = #9#9'%0:s:'#9'%1:s';
  sRestWriterNotFound = 'REST proxy writer not found for extension: "%s"';
  sDBXWriterNotFound = 'DBX proxy writer not found for extension: "%s"';
  sWriterNotFound = 'Proxy writer not found for extension "%s"';
  sExceptionError = '%0:s: %1:s';

const
  sConnectionString = '-c:';
  sIncludeMethods = '-im:';
  sIncludeClasses = '-ic:';
  sExcludeMethods = '-em:';
  sExcludeClasses = '-ec:';
  sProxyWriter = '-pw:';
  sREST = '-rest';
  sDBX = '-dbx';

type
  TDSProxyGenException = class(Exception);

function TryGetValue(const AParam: string; const APrefix: string; out AValue: string): Boolean;
begin
  if CompareText(LeftStr(AParam, Length(APrefix)), APrefix) = 0 then
    AValue := RightStr(AParam, Length(AParam) - Length(APrefix))
  else
    AValue := '';
  Result := AValue <> '';
end;

function TryGetSwitch(const AParam, AOption: string): Boolean;
begin
  Result := CompareText(AParam, AOption) = 0;
end;

function GetExtWriteDictionary(RequiredFeatures, DisallowedFeatures: TDSProxyWriteFeatures): TDictionary<string, string>;
var
  LDictionary: TDictionary<string, string>;

  procedure AddWriter(const AWriter: string);
  var
    DSProxyWriter: TDSProxyWriter;
    LExt: string;
  begin
    DSProxyWriter := TDSProxyWriterFactory.GetWriter(AWriter);
    if Length(DSProxyWriter.FileDescriptions) > 0 then
    begin
      LExt := DSProxyWriter.FileDescriptions[0].DefaultFileExt;
      if LDictionary.ContainsKey(AnsiLowerCase(LExt)) then
        Exit;
      if RequiredFeatures <> [] then
        if (DSProxyWriter.Properties.Features * RequiredFeatures) = [] then
          Exit;
      if DisallowedFeatures <> [] then
        if (DSProxyWriter.Properties.Features * DisallowedFeatures) <> [] then
          Exit;
      LDictionary.Add(AnsiLowerCase(LExt), AWriter);
    end;
  end;
var
  Writers: TDBXStringArray;
  Writer: string;
begin
  LDictionary := TDictionary<string, string>.Create;
  try
    AddWriter(sDelphiDBXProxyWriter);
    AddWriter(sDelphiRestProxyWriter);
    AddWriter(sCPlusPlusBuilderDBXProxyWriter);
    AddWriter(sCPlusPlusBuilderRestProxyWriter);
    AddWriter(sJavaScriptRESTProxyWriter);
    Writers := TDSProxyWriterFactory.RegisteredWritersList;
    for Writer in Writers do
      AddWriter(Writer);
  except
    LDictionary.Free;
    raise;
  end;
  Result := LDictionary;
end;

function GetExtWriter(const AExt: string; ARest, ADBX: Boolean): string;
var
  LDictionary: TDictionary<string, string>;
  LRequiredFeatures: TDSProxyWriteFeatures;
begin
  LRequiredFeatures := [];
  if ARest then
    Include(LRequiredFeatures, feRESTClient)
  else if ADBX then
    Include(LRequiredFeatures, feDBXClient);

  LDictionary := GetExtWriteDictionary(LRequiredFeatures, []);
  try
    if not LDictionary.TryGetValue(AnsiLowerCase(AExt), Result) then
      if ARest then
        raise TDSProxyGenException.Create(Format(sRestWriterNotFound, [AExt]))
      else if ADBX then
        raise TDSProxyGenException.Create(Format(sDBXWriterNotFound, [AExt]))
      else
        raise TDSProxyGenException.Create(Format(sWriterNotFound, [AExt]));
  finally
    LDictionary.Free;
  end;
end;

procedure WriteUsage;
var
  LDictionary: TDictionary<string, string>;
  LPair: TPair<string, string>;
begin
  Writeln(sUsageSyntax);
  Writeln(sUsageOutput);
  LDictionary := GetExtWriteDictionary([], []);
  try
    for LPair in LDictionary do
      WriteLn(Format(sExtLanguage, [LPair.Key, TDSProxyWriterFactory.GetWriter(LPair.Value).Properties.Language]));
  finally
    LDictionary.Free;
  end;
  Writeln(sUsageOptions);
  Writeln(sUsageExamples);
end;

var
  DSProxyGenerator: TDSProxyGenerator;
  GenerateRest: Boolean;
  GenerateDBX: Boolean;
  I: Integer;
  ConnectionString: string;
  FileName: string;
  S: TStream;
  R: TStreamReader;
  FileDescriptions: TDSProxyFileDescriptions;
  Streams: TObjectDictionary<string, TStream>;
  Ext: string;
  Value: string;
  Param: string;
  ProxyWriter: string;
  List: TDSProxyWriterPackageFileList;
begin
  List := TDSProxyWriterPackagesLoader.LoadPackageList;
  try
    TDSProxyWriterPackagesLoader.LoadPackages(List);
    if ParamCount = 0 then
    begin
      WriteUsage;
      Exit;
    end;
    GenerateRest := False;
    GenerateDBX := False;
    try
      DSProxyGenerator := TDSProxyGenerator.Create(nil);
      try
        for I := 1 to ParamCount do
        begin
          Param := ParamStr(I);
          if CompareText(LeftStr(Param, 1), '-') = 0 then
          begin
            if TryGetValue(Param, sConnectionString, Value) then
              ConnectionString := Value
            else if TryGetValue(Param, sIncludeMethods, Value) then
              DSProxyGenerator.IncludeMethods := Value
            else if TryGetValue(Param, sIncludeClasses, Value) then
              DSProxyGenerator.IncludeClasses := Value
            else if TryGetValue(Param, sExcludeClasses, Value) then
              DSProxyGenerator.ExcludeClasses := Value
            else if TryGetValue(Param, sExcludeMethods, Value) then
              DSProxyGenerator.ExcludeMethods := Value
            else if TryGetValue(Param, sProxyWriter, Value) then
            begin
              WriteLn(ProxyWriter);
              ProxyWriter := Value
            end
            else if TryGetSwitch(Param, sREST) then
              GenerateRest := True
            else if TryGetSwitch(Param, sDBX) then
              GenerateDBX := True
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
       // Set default values for connection string
        if not System.StrUtils.ContainsText(ConnectionString, TDBXPropertyNames.DriverName) then
          ConnectionString := ConnectionString + ';' + TDBXPropertyNames.DriverName+'=DataSnap';
        if not System.StrUtils.ContainsText(ConnectionString, TDBXPropertyNames.HostName) then
          ConnectionString := ConnectionString + ';' + TDBXPropertyNames.HostName+'=localhost';
        if not System.StrUtils.ContainsText(ConnectionString, TDBXPropertyNames.Port) then
          ConnectionString := ConnectionString + ';' + TDBXPropertyNames.Port+'=211';
        DSProxyGenerator.MetaDataLoaderIntf := TDSProxyMetaDataLoader.Create(ConnectionString);
        if ProxyWriter <> ''  then
          DSProxyGenerator.Writer := ProxyWriter
        else if FileName <> '' then
        begin
          Ext := ExtractFileExt(FileName);
          if ProxyWriter <> '' then
            DSProxyGenerator.Writer := ProxyWriter
          else
          begin
            DSProxyGenerator.Writer := GetExtWriter(Ext, GenerateRest, GenerateDBX);
            if Ext = FileName then
              FileName := '';  // Write to stdout
          end
        end;
        if DSProxyGenerator.Writer = '' then
          // Default to Delphi
          if GenerateRest then
            DSProxyGenerator.Writer := sDelphiRestProxyWriter
          else
            DSProxyGenerator.Writer := sDelphiDBXProxyWriter;
        TDSProxyWriterPackagesLoader.LoadPackages(List);
        if FileName <> '' then
        begin
          DSProxyGenerator.TargetDirectory := ExtractFilePath(ExpandFileName(ParamStr(1)));
          DSProxyGenerator.TargetUnitName := ExtractFileName(ParamStr(1));
          DSProxyGenerator.Write;
        end
        else
        begin
          Streams := TObjectDictionary<string, TStream>.Create;
          try
            DSProxyGenerator.TargetUnitName := 'ProxyUnit';
            FileDescriptions := DSProxyGenerator.FileDescriptions;
            for I := 0 to Length(FileDescriptions) - 1 do
              Streams.Add(FileDescriptions[I].ID,
                TStringStream.Create());
            DSProxyGenerator.WriteToStreams(Streams);
            for S in Streams.Values do
            begin
              S.Seek(0, soFromBeginning);
              R := TStreamReader.Create(S, TEncoding.UTF8);
              try
                while not R.EndOfStream do
                begin
                  Writeln(R.ReadLine);
                end;
              finally
                R.Free;
              end;
            end;
          finally
            Streams.Free;
          end;
        end;
      finally
        DSProxyGenerator.Free;
      end;
    except
      on E: Exception do
        Writeln(Format(sExceptionError, [E.Classname, E.Message]));
    end;
  finally
    List.Free;
  end;

end.
