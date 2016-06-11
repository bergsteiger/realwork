{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSProxyWriterRegistry;

interface

uses System.Generics.Collections, System.IniFiles, System.SysUtils;

type

  TDSProxyWriterPackageFile = class;
  TDSProxyWriterPackageFileList = class;

  TDSProxyWriterPackagesLoader = class
  private
    class procedure Clear(AIniFile: TCustomIniFile;
      const AKey: string); static;
    class procedure Load(AList: TDSProxyWriterPackageFileList; AIniFile: TCustomIniFile;
      const AKey: string); static;
    class procedure Save(AList: TDSProxyWriterPackageFileList; AIniFile: TCustomIniFile;
      const AKey: string); static;
  public
    class function LoadPackages(APackageList: TDSProxyWriterPackageFileList): TObject;
    class function LoadPackageList: TDSProxyWriterPackageFileList;
    class procedure SavePackageList(AList: TDSProxyWriterPackageFileList);
  end;

  TDSProxyWriterPackageFileList = class
  strict private
    FList: TDictionary<string, TDSProxyWriterPackageFile>;
    FUntitledPackage: string;
    function GetList: TArray<TDSProxyWriterPackageFile>;
    function GetCount: Integer;
  protected
    FModified: Boolean;
    procedure HandleError(E: Exception; PackageInfo: TDSProxyWriterPackageFile); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(const AName: string; const ADescription: string; ADisabled: Boolean = False); virtual;
    procedure Remove(const AFile: string);
    function Contains(const AFile: string): Boolean;
    property List: TArray<TDSProxyWriterPackageFile> read GetList;
    property Count: Integer read GetCount;
    property Modified: Boolean read FModified;
  end;

  TDSProxyWriterPackageFile = class
  strict private
    FFileName: string;
    FDescription: string;
    FDisabled: Boolean;
  public
    constructor Create(const AFileName: string; ADescription: string; ADisabled: Boolean);
    property FileName: string read FFileName;
    property Description: string read FDescription write FDescription;
    property Disabled: Boolean read FDisabled write FDisabled;
  end;


const
  sProxyWriterPackages = 'Proxy Writer Packages';
  sDSProxyGenSettingsKey = 'Software\Embarcadero\DSProxyGen';

implementation

uses
  System.Classes,
  System.Contnrs,
  Vcl.Controls,
  Vcl.Dialogs,
  Datasnap.DSClientResStrs,
  Vcl.Forms,
  System.Win.Registry,
  System.StrUtils,
  System.UITypes,
  Winapi.Windows;

type

  TDSProxyWriterPackageFileListHandleError = class(TDSProxyWriterPackageFileList)
  protected
    procedure HandleError(E: Exception; PackageInfo: TDSProxyWriterPackageFile); override;
  end;

  TBasePackage = class
  private
    FFilename: string;
    FHandle: HMODULE;
  protected
    function DoLoadPackage(const PackageName: string): HMODULE; virtual;
    procedure DoUnloadPackage(Module: HMODULE); virtual;
    procedure InternalUnload; virtual;
  public
    constructor Create(const AFilename: string);
    destructor Destroy; override;
    function IsLoaded: Boolean;
    procedure Load; virtual;
    procedure Unload; virtual;
    property Filename: string read FFilename;
    property Handle: HMODULE read FHandle; // write SetHandle;
  end;

  TProxyPackage = class(TBasePackage)
  public
    constructor Create(const AFilename: string; AList: TList);
  end;

function ExpandRootMacro(const InString: string; const AdditionalVars: TDictionary<string, string>): string; forward;

{ TDSProxyWriterPackagesLoader }

class function TDSProxyWriterPackagesLoader.LoadPackages(APackageList: TDSProxyWriterPackageFileList): TObject;
var
  LPackage: TProxyPackage;
  LList: TList;
  LPackageFile: TDSProxyWriterPackageFile;
begin
  LList := TObjectList.Create(True);
  for LPackageFile in APackageList.List do
  begin
    if not LPackageFile.Disabled then
    begin
      LPackage := TProxyPackage.Create(ExpandRootMacro(LPackageFile.FileName, nil), LList);
      try
        LPackage.Load;
      except
        on E: Exception do
          APackageList.HandleError(E, LPackageFile);
      end;
    end;
  end;
  Result := LList;
end;

class function TDSProxyWriterPackagesLoader.LoadPackageList: TDSProxyWriterPackageFileList;
var
  LIniFile: TCustomIniFile;
begin
  LIniFile := TRegistryIniFile.Create(sDSProxyGenSettingsKey);
  try
    Result := TDSProxyWriterPackageFileListHandleError.Create;
    try
      Load(Result, LIniFile, sProxyWriterPackages);
    except
      Result.Free;
      raise;
    end;
  except
    LIniFile.Free;
    raise;
  end;
end;

class procedure TDSProxyWriterPackagesLoader.SavePackageList(AList: TDSProxyWriterPackageFileList);
var
  LIniFile: TCustomIniFile;
begin
  LIniFile := TRegistryIniFile.Create(sDSProxyGenSettingsKey);
  try
    Save(AList, LIniFile, sProxyWriterPackages);
  except
    LIniFile.Free;
    raise;
  end;
end;

class procedure TDSProxyWriterPackagesLoader.Load(AList: TDSProxyWriterPackageFileList; AIniFile: TCustomIniFile; const AKey: string);
var
  I: Integer;
  LStrings: TStrings;
  LName, LDesc: String;
  LDisabled: Boolean;
begin
  AList.Clear;
  Assert(AKey <> '');
  if AIniFile = nil then Exit;
  LStrings := TStringList.Create;
  try
    AIniFile.ReadSectionValues(AKey, LStrings);
    for I := 0 to LStrings.Count - 1 do
    begin
      LName := LStrings.Names[I];
      LDesc := LStrings.ValueFromIndex[I];
      LDisabled := False;
      // If the name starts with an underbar, then it is disabled.
      if StartsText('_', LName) then
      begin
        LDisabled := True;
        LName := LName.Substring(1);
      end;
      AList.Add(LName, LDesc, LDisabled);
    end;
  finally
    LStrings.Free;
  end;
  AList.FModified := False;
end;


class procedure TDSProxyWriterPackagesLoader.Clear(AIniFile: TCustomIniFile; const AKey: string);
var
  LStrings: TStringList;
  LName: string;
  I: Integer;
begin
  LStrings := TStringList.Create;
  try
    AIniFile.ReadSectionValues(AKey, LStrings);
    for I := 0 to LStrings.Count - 1 do
    begin
      LName := LStrings.Names[I];
      AIniFile.DeleteKey(AKey, LName);
    end;
  finally
    LStrings.Free;
  end;
end;

class procedure TDSProxyWriterPackagesLoader.Save(AList: TDSProxyWriterPackageFileList; AIniFile: TCustomIniFile; const AKey: string);
var
  LPackageFile: TDSProxyWriterPackageFile;
begin
  Assert(AKey <> '');
  if AIniFile = nil then Exit;
  Clear(AIniFile, AKey);
  for LPackageFile in AList.List do
  begin
    if LPackageFile.Disabled then
      AIniFile.WriteString(AKey, '_' + LPackageFile.FileName, LPackageFile.Description)
    else
      AIniFile.WriteString(AKey, LPackageFile.FileName, LPackageFile.Description)
  end;

  if (AList.Count > 0) and (AIniFile.FileName <> '') then
    AIniFile.UpdateFile;
  AList.FModified := False;
end;


{ TDSProxyWriterPackageFileList }

constructor TDSProxyWriterPackageFileList.Create;
begin
  FList := TObjectDictionary<string, TDSProxyWriterPackageFile>.Create([doOwnsValues]);
  FUntitledPackage := sUntitledPackage;
end;

destructor TDSProxyWriterPackageFileList.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;


function TDSProxyWriterPackageFileList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TDSProxyWriterPackageFileList.GetList: TArray<TDSProxyWriterPackageFile>;
begin
  Result := FList.Values.ToArray;
end;

procedure TDSProxyWriterPackageFileList.Add(const AName, ADescription: string; ADisabled: Boolean = False);
var
  LLowerCaseName: string;
  LFileName: string;
begin
  LFileName := AName;

  LLowerCaseName := AnsiLowerCase(LFileName);
  if not FList.ContainsKey(LLowerCaseName) then
  begin
    FModified := True;
    FList.Add(LLowerCaseName, TDSProxyWriterPackageFile.Create(AName, ADescription, ADisabled));
  end
  else
  begin
    FList[LLowerCaseName].Description := ADescription;
    FList[LLowerCaseName].Disabled := ADisabled;
    FModified := True;
  end;
end;

procedure TDSProxyWriterPackageFileList.Clear;
begin
  FModified := True;
  FList.Clear;
end;

procedure TDSProxyWriterPackageFileList.Remove(const AFile: string);
var
  LowerCaseName: string;
begin
  LowerCaseName := AnsiLowerCase(AFile);
  if FList.ContainsKey(LowerCaseName) then
  begin
    FList.Remove(LowerCaseName);
    FModified := True;
  end;
end;

function TDSProxyWriterPackageFileList.Contains(const AFile: string): Boolean;
var
  LowerCaseName: string;
begin
  LowerCaseName := AnsiLowerCase(AFile);
  Result := FList.ContainsKey(LowerCaseName);
end;

procedure TDSProxyWriterPackageFileList.HandleError(E: Exception; PackageInfo: TDSProxyWriterPackageFile);
begin

end;

{ TDSProxyWriterPackageFileListHandleError }

procedure TDSProxyWriterPackageFileListHandleError.HandleError(E: Exception; PackageInfo: TDSProxyWriterPackageFile);
var
  Msg: string;
  Buttons: TMsgDlgButtons;
  Buffer: array[0..1023] of Char;
begin
  if (E is EOutOfMemory) then
    Application.ShowException(E)
  else
  begin
    Buttons := [mbYes, mbNo];
    if E.HelpContext <> 0 then Include(Buttons, mbHelp);
    SetString(Msg, Buffer, ExceptionErrorMessage(E, ExceptAddr, Buffer, Length(Buffer)));
    if Msg.IndexOf(ExtractFileName(ChangeFileExt(PackageInfo.FileName, ''))) = -1 then
      Msg := string.Format(sErrorLoadingPackage, [PackageInfo.FileName, Msg]);
    Msg := Msg + sLineBreak + sLoadPackageNextTime;
    if MessageDlg(Msg, mtError, Buttons, E.HelpContext) = mrNo then
    begin
      PackageInfo.Disabled := True;
      FModified := True;
    end;
  end;
end;

{ TBasePackage }

constructor TBasePackage.Create(const AFilename: string);
begin
  FHandle := 0;
  FFilename := AFilename;
end;

destructor TBasePackage.Destroy;
begin
  Unload;
  inherited Destroy;
end;

function TBasePackage.DoLoadPackage(const PackageName: string): HMODULE;
begin
  Result := LoadPackage(PackageName);
end;

procedure TBasePackage.DoUnloadPackage(Module: HMODULE);
begin
  try
    UnloadPackage(Module);
  except
    On E:Exception do
    begin
      System.Classes.ApplicationShowException(E);
      FreeLibrary(Module);
    end;
  end;
end;

procedure TBasePackage.InternalUnload;
begin
  if (FHandle <> 0) then
  begin
    DoUnloadPackage(FHandle);
    if FHandle <> 0 then
    begin
      // Make sure that we have a valid handle.  This
      FHandle := GetModuleHandle(PChar(FileName));
    end;
  end;
end;

function TBasePackage.IsLoaded: Boolean;
begin
  Result := FHandle <> 0;
end;

procedure TBasePackage.Load;
begin
  if FHandle = 0 then
    FHandle := DoLoadPackage(FFileName)
  else
    DoLoadPackage(FFileName); // simply add a ref-count
end;

procedure TBasePackage.Unload;
begin
  InternalUnload;
end;

{ TProxyPackage }

constructor TProxyPackage.Create(const AFilename: string;
  AList: TList);
begin
  inherited Create(AFileName);
  if AList <> nil then
    AList.Add(Self);
end;

{ TDSProxyWriterPackageFileList }

constructor TDSProxyWriterPackageFile.Create(const AFileName: string; ADescription: string;
  ADisabled: Boolean);
begin
  FFileName := AFileName;
  FDescription := ADescription;
  FDisabled := ADisabled;
end;

function ExpandEnvStrings(InString: string): string;
var
  DollarPos, EndEnvVarPos: Integer;
  OrigStr: string;
  Depth: Integer;  //depth is used to avoid infinite looping (only 1000 levels deep allowed)
  P: array[0..4096] of char;
begin
  Result := '$(' + InString + ')';  // do not localize
  DollarPos := AnsiPos('$(', Result);  // do not localize
  EndEnvVarPos := AnsiPos(')', Result);
  Depth := 0;
  while (DollarPos <> 0) and (EndEnvVarPos > DollarPos) and (Depth < 1000) do
  begin
    if EndEnvVarPos > DollarPos then
    begin
      OrigStr := Result.Substring(DollarPos - 1, EndEnvVarPos - DollarPos + 1);
      ExpandEnvironmentStrings(PChar('%' + Result.Substring(DollarPos + 1, EndEnvVarPos - DollarPos - 2) + '%'), P, SizeOf(P));
      Result := Result.Replace(OrigStr, P);
      DollarPos := AnsiPos('$(', Result);  // do not localize
      EndEnvVarPos := AnsiPos(')', Result);
      Inc(Depth);
    end;
  end;
end;

function ExpandRootMacro(const InString: string; const AdditionalVars: TDictionary<string, string>): string;
var
  I, Len, Start: Integer;
  NewS, S: string;
  P: PChar;
begin
  Result := InString;
  I := Result.IndexOf('$(') + 1;
  if I = 0 then
    Exit;
  Len := Result.Length;
  while I <= Len do
  begin
    if (I < Len - 1) and (Result.Chars[I-1] = '$') and (Result.Chars[I] = '(') then
    begin
      Start := I;
      Inc(I);
      while (I <= Len) and (Result.Chars[I-1] <> ')') do
        Inc(I);
      if I <= Len then
      begin
        S := Result.Substring(Start + 1, I - Start - 2);
        if (AdditionalVars = nil)
        or not AdditionalVars.TryGetValue(S, NewS) then
          NewS := ExpandEnvStrings(S);
        Result := Result.Remove(Start - 1, I - Start + 1);
        Result := Result.Insert(Start - 1, NewS);
        I := Start + NewS.Length;
        Len := Result.Length;
      end;
    end;
    Inc(I);
    P := PChar(Pointer(Result)) + I - 1;
    while (I <= Len) and (P^ <> '$') do // fast forward
    begin
      Inc(P);
      Inc(I);
    end;
  end;
end;

end.
