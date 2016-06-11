{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                 Soap Support                          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
program WSDLImp;

{$R *.res}
{$APPTYPE CONSOLE}
//{$DEFINE TRACK_MEMORY}

uses
{$IFDEF TRACK_MEMORY}
  FastMM4,
{$ENDIF}
  SysUtils,
  StrUtils,
  Windows,
  Classes,
  ActiveX,
  Types,
  Generics.Defaults,
  Generics.Collections,
  HTTPUtil,
  WSDLImpWriter in 'WSDLImpWriter.pas',
  WSDLCppWriter in 'WSDLCppWriter.pas',
  WSDLPasWriter in 'WSDLPasWriter.pas',
  WSDLImpConst in 'WSDLImpConst.pas',
  UDDIHlprDesign in 'UDDIHlprDesign.pas',
  MessageDigest_5 in 'MessageDigest_5.pas',
  XMLSchemaHelper in 'XMLSchemaHelper.pas',
  WSDLModelIntf in 'WSDLModelIntf.pas';

type
  CodeGen = (PasGen, CppGen);

const
  sDefaultStringType  =  'String';                   { Do not localize }
  sDefaultBaseType    =  'TRemotable';               { Do not localize }
  sNoDateOption       =  'nodate';                   { Do not localize }
  sDumpSettingsOption =  'writeSettings';            { Do not localize }
  sXMLSchemaFile      =  'schema';                   { Do not localize }
  sSkipURLOption      =  'skip';                     { Do not localize }
  sOptionUsageFormatString = '  -%s   %s' + sLineBreak;

resourcestring
   SignOn = 'Embarcadero WSDLIMP Version %d.%d %s' + #13#10 +
            'Copyright (c) 2010 Embarcadero Technologies, Inc.' + #13#10 + #13#10;

   Usage = 'Usage: WSDLIMP [options] <WSDL[File|URL]>' + #13#10 + #13#10;

   LanguageUsage = ' Language Generation Options:' + #13#10 +
                   '  -C     Generate C++ code' + #13#10 +
                   '  -P     Generate Pascal code' + #13#10 + #13#10;

   SOAPVersionHeaderUsage = ' SOAP Version Options:' + #13#10 +
                            '  Automatically determines SOAP version if not forced. (Recommended)' + #13#10;

   OptionUsageHeader = ' Code Generation Options [ -option{+|-} default shown ]:' + #13#10;

   sUserOption   = 'user';
   sPassOption   = 'pass';
   sProxyOption  = 'proxy';
   ProxyUsage    = ' Proxy/Server Authentication:' +  #13#10 +
                   '  -user:userName -pass:Password [-proxy:Proxy]'  + #13#10 +  #13#10;

   FilenameUsage = ' File options: ' +  #13#10 +
                   '  -D<path>  Output directory path' + #13#10 +
                   '  -=+       Output filename after ''='' in URL'+  #13#10 +
                   '  @<Resp>   Response file with list of WSDL' +  #13#10 + #13#10;

   FileCreated = 'Created %s';
   WSDLLoaded  = 'WSDL loaded ....';
   OptionError = 'Invalid option %s' + #13#10 + 'Please run ''WSDLImp -?'' for help with options (or contact a stockbroker)';
   GeneralError = '%s';
   ForceSOAPVersionError = 'Cannot force more than one SOAP version at a time.' + #13#10 + 'Please run ''WSDLImp -?'' for help with options.';

var
   User, Password, Proxy: string;
   WSDLImportInfo: TWSDLImportInfo;

{----------------------------------------------------------------------------}
{  Utility functions }

procedure OutputStr(S: String);
var
  AStr: AnsiString;
begin
  AStr := AnsiString(S);
  CharToOEMA(PAnsiChar(AStr), PAnsiChar(AStr));
  Write(AStr);
end;

procedure ComplainAboutOption(const S: string);
begin
  raise Exception.CreateFmt(OptionError, [S]);
end;

{-----------------------------------------------------------------------------}

procedure WriteFeedback(const Message: String; const Args: array of const);
begin
  OutputStr(Format(Message, Args));
end;

procedure GenProxy(const WSDLFileName: String; OutFile: String;
                   const Directory, RelHdrDir, StringType, BaseClassName: string;
                   LangGen: CodeGen; const UDDIInfo: IImportBindingInfo;
                   AWriteSettings: Boolean);
var
  Writer: TWSDLWriter;
  Importer: IWSDLImporter;
  Ext: WideString;
  Flag: TImporterFlags;
begin
  { About to import/read }
  if not (wfQuietMode in Global_WSDLGenFlags) then
    WriteFeedback(sFeedbackRead+sLineBreak, [WSDLFileName]);
  { Generate output file name }
  if (OutFile = '') then
    OutFile := GetOutFileName(WSDLFileName);
  OutFile := ChangeFileExt(OutFile, '');

  { Flag }
  Flag := [];
  if LangGen = CppGen then
    { C++ }
    Flag := [ifWriterHasWeakAliases]
  else
    { Delphi }
    Flag := [ifWriterHasOutParams];

  if XMLSchemaFile then
    Flag := Flag + [ifImportXMLSchema];

  { Import }
  Importer := ImportWSDL(WSDLFileName, nil{Stream},
                         WriteFeedback,
                         Flag,
                         OutFile,
                         Proxy, User, Password,
                         (30*1000), { 30 Secs. timeout }
                         @WSDLImportInfo);

  { Here we determine the writer }
  if (LangGen = CppGen) then
    Writer := TWSDLCppWriter.Create(Importer)
  else
    Writer := TWSDLPasWriter.Create(Importer);

  try
    { Give writer output directory }
    Writer.SetDirectory(Directory);
    if Writer.HasSource then
      Writer.SetRelHeaderDir(RelHdrDir);

    { Write interface to stream}
    Writer.WriteIntf;
    if Writer.HasSource then
      Ext := Writer.IntfExt
    else
      Ext := Writer.SourceExt;

    { Write stream to disk }
    OutFile := ChangeFileExt(Writer.OutFile, Ext);
    Writer.WriteToFile(Directory + RelHdrDir + OutFile);

    if (Writer.HasSource) then
    begin
      { Write source to stream }
      Writer.Clear;
      Writer.WriteSource;

      { Write stream to disk }
      OutFile := ChangeFileExt(Writer.OutFile, Writer.SourceExt);
      Writer.WriteToFile(Directory + OutFile);
    end;

    if AWriteSettings then
    begin
      Writer.Clear;
      if (Writer.WriteSettingsFile) then
        Writer.WriteToFile(Directory+'WSDLImp.settings');
    end;
  finally
    Writer.Free;
  end;
end;

procedure DoMain;
var
  WSDLFileNames: TStringList;  { Name(s) of WSDL file/url }
  UDDIInfos: TInterfaceList;   { UDDI Info                }
  Directory: string;           { Output directory         }
  RelHdrDir: string;           { Relative Header directory}
  LangGen: CodeGen;            { Code generation          }
  UDDIRegistry: string;        { UDDI Registry            }
  HaveUDDI: Boolean;
  OutNameAfterEqual: Boolean;

  {------------------------------------------------------------------------}
  { Specialized subfunctions for processing particular options groups. }

  procedure SetDirectoryPath(const S: string);
  begin
    if (Length(S) < 3) then
      raise Exception.CreateFmt(OptionError, [S]);
    Directory := Copy(S, 3, MaxInt);
    if AnsiLastChar(Directory)^ <> '\' then     { Do not localize }
       Directory := Directory + '\';            { Do not localize }
  end;

  procedure SetRelativeHeaderPath(const S: string);
  begin
    if (Length(S) < 3) then
      raise Exception.CreateFmt(OptionError, [S]);
    RelHdrDir := Copy(S, 3, MaxInt);
    if AnsiLastChar(RelHdrDir)^ <> '\' then     { Do not localize }
       RelHdrDir := RelHdrDir + '\';            { Do not localize }
  end;
  
  procedure SetReturnParamNames(const S: string);
  begin
    if (Length(S) < 3) then
      raise Exception.CreateFmt(OptionError, [S]);
    DefaultReturnParamNames := Copy(S, 3, MaxInt);
  end;

  procedure AddExcludedFromRenameIdentifier(const S: string);
  begin
    if (Length(S) < 3) then
      raise Exception.CreateFmt(OptionError, [S]);
    ExcludedFromRenameList.Add(Copy(S, 3, MaxInt))
  end;

  procedure SetUDDIRegistry(const S: string);
  begin
    if (Length(S) < 3) then
      raise Exception.CreateFmt(OptionError, [S]);
    UDDIRegistry := Copy(S, 3, MaxInt);
    HaveUDDI := True;
  end;

  procedure SetOutFileAfterEqual(const S: string);
  begin
    OutNameAfterEqual := (Length(S) < 3) or (S[3] <> '-');
  end;

  {--------------------------------------------------------------------------}
  { Main options processing code }

  procedure SetGenOptions(const Flag: WSDLGenFlags; Enabled: Boolean); overload;
  begin
    if Enabled then
      Global_WSDLGenFlags := Global_WSDLGenFlags + [Flag]
    else
      Global_WSDLGenFlags := Global_WSDLGenFlags - [Flag];
    // Flag that the option was specifically enabled/disabled
    Global_WSDLGenFlags_Specified[Flag] := True;
  end;

  procedure SetGenOptions(const S: string); overload;
  var
    Enabled: Boolean;
    CurrFlag: WSDLGenFlags;
  begin
    if Length(S) <= 2 then
      ComplainAboutOption(S);

    { Assume on unless '-' is tagged after option }
    Enabled := not ((Length(S) >= 4) and (S[4]='-'));

    for CurrFlag := Low(WSDLGenFlags) to High(WSDLGenFlags) do
    begin
      if (CompareText(S[3], OptCommandLineFlags[CurrFlag]) = 0) then
      begin
        SetGenOptions(CurrFlag, Enabled);
        Exit;
      end
    end;

    ComplainAboutOption(S);
  end;

  procedure RetrieveUDDIInfo;
  var
    I: Integer;
    UDDIKey, OutFileName: String;
    UDDIInfo: IImportBindingInfo;
  begin
    for I:=0 to WSDLFileNames.Count-1 do
    begin
      try
        UDDIKey := WSDLFileNames.Names[I];
        if (UDDIKey <> '') then
          OutFileName := WSDLFileNames.Values[UDDIKey]
        else
        begin
          UDDIKey := WSDLFileNames.Strings[I];
          OutFileName:= '';
        end;
        OutputStr(Format(sFeedbackUDDI, [UDDIKey]));
        UDDIInfo := GetBindingKeyImportInfo(UDDIRegistry, UDDIKey);
        UDDIInfos.Add(UDDIInfo);
      except
        on E: Exception do
        begin
          OutputStr(Format(sGenericError, [E.Message]));
          { NOTE: Last import sets the exit code }
          ExitCode := 1;
        end;
      end;
    end;
  end;

  function GetVerboseOption(const S: string; const str: string; var value: string): boolean; overload;
  begin
    Result := False;
    if StartsWith(S, '-'+str) or StartsWith(S, '/'+str) then        { Do not localize }
    begin
      value := Copy(S, Length(str)+3, MaxInt);
      Result := True;
    end;
  end;

  function GetVerboseOption(const S: string; const str: string; var StringList: ArrayOfString): boolean; overload;
  var
    Len: Integer;
    Value: string;
  begin
    Result := False;
    if GetVerboseOption(S, str, Value) then
    begin
      Len := Length(StringList);
      SetLength(StringList, Len+1);
      StringList[Len] := Value;
      Result := True;
    end;
  end;

  function GetVerboseOption(const S: string; const str: string; var value: boolean): boolean; overload;
  begin
    Result := False;
    if (Length(str) > 1) and (SameText(S, '-'+str) or SameText(S, '/'+str)) then
    begin
      value := True;
      Result := True;
    end;
  end;

  function GetVerboseOption(const S: string; Flag: WSDLGenFlags): boolean; overload;
  var
    str: string;
  begin
    Result := False;
    str := OptCommandLineFlags[Flag];
    if (Length(str) > 1) and (SameText(S, '-'+str) or SameText(S, '/'+str)) then
    begin
      Global_WSDLGenFlags := Global_WSDLGenFlags + [Flag];
      Result := True;
    end;
  end;

  function IsVerboseOption(const S: string): Boolean;
  begin
    Result := GetVerboseOption(S, sUserOption, User) or
              GetVerboseOption(S, sPassOption, Password) or
              GetVerboseOption(S, sProxyOption, Proxy) or
              GetVerboseOption(S, wfDebug) or
              GetVerboseOption(S, sDumpSettingsOption, DumpSettings) or
              GetVerboseOption(S, sXMLSchemaFile, XMLSchemaFile) or
              GetVerboseOption(S, sSkipURLOption, WSDLImportInfo.SkipURLs) or
              GetVerboseOption(S, sNoDateOption, NoDateStamp) ;
  end;

  function IsForceSOAPVersionOption(const S: string): Boolean;
  var
    CommandLineFlag: string;
  begin
    Result := False;

    if CharInSet(S[1], ['-','/']) then
    begin
      CommandLineFlag := Copy(S, 2, Length(S));
      if (CompareText(CommandLineFlag, OptCommandLineFlags[wfForceSOAP12]) = 0) then
      begin
        SetGenOptions(wfForceSOAP12, True);
        if wfForceSOAP11 in Global_WSDLGenFlags then
          raise Exception.Create(ForceSOAPVersionError);
        Result := True;
      end
      else if (CompareText(CommandLineFlag, OptCommandLineFlags[wfForceSOAP11]) = 0) then
      begin
        SetGenOptions(wfForceSOAP11, True);
        if wfForceSOAP12 in Global_WSDLGenFlags then
          raise Exception.Create(ForceSOAPVersionError);
        Result := True;
      end;
    end;
  end;

  procedure ProcessOption(const S: string);
  begin
    case UpCase(S[2]) of
      'C': LangGen := CppGen;                               { Do not localize }
      'D': SetDirectoryPath(S);                             { Do not localize }
      'H': SetRelativeHeaderPath(S);                        { Do not localize }
      'O': SetGenOptions(S);                                { Do not localize }
      'P': LangGen := PasGen;                               { Do not localize }
      'R': SetReturnParamNames(S);                          { Do not localize }
      'X': AddExcludedFromRenameIdentifier(S);              { Do not localize }
      'U': SetUDDIRegistry(S);                              { Do not localize }
      '=': SetOutFileAfterEqual(S);                         { Do not locatize }
    else
      ComplainAboutOption(S);
    end;
  end;

  procedure AddFileNames(const FilePattern: String; ResponseFile: Boolean);
  var
    sr: TSearchRec;
    sl: TStringList;
    Index: Integer;
    str: string;
  begin
    { Here we were passed a response file }
    if (ResponseFile) then
    begin
      sl := TStringList.Create;
      try
        sl.LoadFromFile(FilePattern);
        for Index := 0 to sl.Count-1 do
        begin
          str := Trim(sl[Index]);
          if Length(str) > 0 then
          begin
            if str[1] = '#' then      { Comment }
              continue
            else if str[1] = '-' then { Option }
              ProcessOption(str)
            else
              WSDLFileNames.Add(str);
          end;
        end;
      finally
        sl.Free;
      end;
    end
    else
    { Here we check if we were passed a pattern }
    if FindFirst(FilePattern, faAnyFile, sr) = 0 then
    begin
      repeat
        WSDLFileNames.Add(ExtractFilePath(FilePattern)+sr.Name);
      until FindNext(sr) <> 0;
      Sysutils.FindClose(sr);
    end
    else
    { Here it's a simple filename, we hope }
    begin
      WSDLFileNames.Add(FilePattern);
    end;
  end;

  function GetOptions: Boolean;
  var
    I: Integer;
    S: string;
    VerboseOpt, ForceSOAPVersionOpt: Boolean;
  begin
    Result := True;

    if ParamCount < 1 then
      Exit(False);

    for I := 1 to ParamCount do
    begin
      S := ParamStr(I);

      //Check for Usage
      if (S[1] = '?') or (S[2] = '?') or (CompareText(S, '-help') = 0) then
        Exit(False);

      { Get non-one-letter options first}
      VerboseOpt := IsVerboseOption(S);
      ForceSOAPVersionOpt := IsForceSOAPVersionOption(S);

      if (not VerboseOpt) and (not ForceSOAPVersionOpt) then
      begin
        { Shorter Options }
        if (Length(S) > 1) then
        begin
          if CharInSet(S[1], ['-', '/']) then
            ProcessOption(S)
          else if (S[1] = '@') then
            AddFileNames(Copy(S, 2, MaxInt), True)
          else
            AddFileNames(S, false);
        end;
      end
    end;

    if HaveUDDI then
      RetrieveUDDIInfo;
  end;

  type
     TWSDLGenFlagsComparer = TComparer<WSDLGenFlags>;

  procedure WriteUsage;
  var
    CurrFlag: WSDLGenFlags;
    FlagsOrder: TArray<WSDLGenFlags>;
    I: Integer;
    CurrCommandLineFlag: string;
  begin
    OutputStr(Usage);
    OutputStr(LanguageUsage);

    //Code Gen Options Usage
    OutputStr(OptionUsageHeader);
    FlagsOrder := GetSortedWSDLGenFlags;
    for I := 0 to Length(FlagsOrder)-1 do
    begin
      CurrFlag := FlagsOrder[I];
      if Length(OptCommandLineFlags[CurrFlag]) = 1 then
      begin
        CurrCommandLineFlag := 'O' + OptCommandLineFlags[CurrFlag];
        if CurrFlag in Default_WSDLGenFlags then
          CurrCommandLineFlag := CurrCommandLineFlag + '+'
        else
          CurrCommandLineFlag := CurrCommandLineFlag + '-';
        OutputStr(Format(sOptionUsageFormatString, [CurrCommandLineFlag, OptDescriptionsForCommandLineHelp[CurrFlag]]));
      end;
    end;

    OutputStr(sLineBreak);

    //SOAP Version Usage
    OutputStr(SOAPVersionHeaderUsage);
    OutputStr(Format(sOptionUsageFormatString, [OptCommandLineFlags[wfForceSOAP11], OptDescriptionsForCommandLineHelp[wfForceSOAP11]]));
    OutputStr(Format(sOptionUsageFormatString, [OptCommandLineFlags[wfForceSOAP12], OptDescriptionsForCommandLineHelp[wfForceSOAP12]]));
    OutputStr(sLineBreak);

    OutputStr(FilenameUsage);
    OutputStr(ProxyUsage);
  end;

var
  I: Integer;
  Total, Success, Fail: Integer;
  InFileName: String;
  OutFileName: String;
  Indices: TBooleanDynArray;
  UDDIInfo: IImportBindingInfo;
begin
  { Default to Pascal }
  LangGen := PasGen;

  { Initialize vars }
  User := '';
  Password := '';
  Proxy := '';
  HaveUDDI := False;
  OutNameAfterEqual := False;

  CoInitialize(nil);
  try
    Directory := GetCurrentDir;
    WSDLFileNames := TStringList.Create;
    try
      UDDIInfos := TInterfaceList.Create;
      try
        try
          OutputStr(Format(SignOn, [WSDLImpMajVer, WSDLImpMinVer, RevString]));
          if (not GetOptions) or (WSDLFileNames.Count < 1) then
            WriteUsage
          else begin
  {$IFDEF MSWINDOWS}
            if not CharInSet(Directory[Length(Directory)], [DriveDelim, PathDelim]) then
  {$ENDIF}
  {$IFDEF LINUX}
            if not (Directory[Length(Directory)] in [DriveDelim[1], PathDelim]) then
  {$ENDIF}
              Directory := Directory + PathDelim;

            { Initialize counts for error tracking }
            Total := WSDLFileNames.Count;
            Fail := 0;
            Success := 0;
            SetLength(Indices, Total);

            for I:=0 to WSDLFileNames.Count-1 do
            begin
              try
                { Check if we retrieved information via UDDI }
                if HaveUDDI then
                begin
                  UDDIInfo := UDDIInfos[I] as IImportBindingInfo;
                  InFileName := UDDIInfo.WSDLLocation;
                end
                else
                begin
                  if OutNameAfterEqual then
                    InFileName := WSDLFileNames.Names[I]
                  else
                    InFileName := '';
                  UDDIInfo := nil;
                end;

                { Get Input and output }
                if (InFileName <> '') then
                  OutFileName := WSDLFileNames.Values[InFileName]
                else
                begin
                  InFileName := WSDLFileNames.Strings[I];
                  OutFileName:= '';
                end;

                GenProxy(InFileName, OutFileName, Directory, RelHdrDir,
                         sDefaultStringType, sDefaultBaseType, LangGen,
                         UDDIInfo, DumpSettings and (I = WSDLFileNames.Count-1));

                { Mark succesful - exception-less - imports }
                Inc(Success);
                Indices[I] := True;

                { NOTE: Last import sets the exit code }
                ExitCode := 0;
              except
                on E: Exception do
                begin
                  { Mark failed ones }
                  Inc(Fail);
                  Indices[I] := False;
                  OutputStr(Format(sGenericError, [E.Message]));
                  OutputStr(sLineBreak);
                  { NOTE: Last import sets the exit code }
                  ExitCode := 1;
                end;
              end;
            end;

            { Display summary of import }
            if Total > 1 then
            begin
              if Fail > 0 then
              begin
                OutputStr(Format(sSummaryFeedback1, [Success, Total, Fail]));
                OutputStr(sLineBreak);
                for I := 0 to Length(Indices)-1 do
                begin
                  if Indices[I] = False then
                  begin
                    OutputStr(Format(sFailureFeedback, [WSDLFileNames.Strings[I]]));
                    OutputStr(sLineBreak);
                  end;
                end;
              end
              else
              begin
                OutputStr(Format(sSummaryFeedback2, [Success, Total]));
              end;
            end;
          end;
        except
          on E: Exception do
          begin
            OutputStr(Format(sGenericError, [E.Message]));
            ExitCode := 1;
          end;
        end;
      finally
        UDDIInfos.Free;
      end;
    finally
      WSDLFileNames.Free;
    end;
  finally
    CoUninitialize;
  end;
end;

begin
  DoMain;
end.
