{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBConnAdmin;

interface

uses
  System.Classes,
  System.IniFiles
;

type

{ IConnectionAdmin }

  IConnectionAdmin = interface
    function GetDisplayDriverName(const DriverName: string): string;
    function GetDisplayDriverNames(List: TStrings): Integer;
    function GetDriverNames(List: TStrings): Integer;
    function GetDelegateDriverNames(List: TStrings): Integer;
    function GetDriverParams(const DriverName: string; Params: TStrings): Integer;
    procedure GetDriverLibNames(const DriverName: string;
      var LibraryName, VendorLibrary: string);
    function GetConnectionNames(List: TStrings;DriverName: string): Integer;
    function GetConnectionParams(const ConnectionName: string; Params: TStrings): Integer;
    procedure AddConnection(const ConnectionName, DriverName: string);
    procedure DeleteConnection(const ConnectionName: string);
    procedure ModifyConnection(const ConnectionName: string; Params: TStrings);
    procedure RenameConnection(const OldName, NewName: string);
  end;

{ TConnectionAdmin }

  TConnectionAdmin = class(TInterfacedObject, IConnectionAdmin)
  private
    FConnectionConfig: TCustomIniFile;
  protected
    { IConnectionAdmin }
    function GetDisplayDriverName(const DriverName: string): string;
    function GetDisplayDriverNames(List: TStrings): Integer;
    function GetDriverNames(List: TStrings): Integer;
    function GetDelegateDriverNames(List: TStrings): Integer;
    function GetDriverParams(const DriverName: string; Params: TStrings): Integer;
    procedure GetDriverLibNames(const DriverName: string;
      var LibraryName, VendorLibrary: string);
    function GetConnectionNames(List: TStrings; DriverName: string): Integer;
    function GetConnectionParams(const ConnectionName: string; Params: TStrings): Integer;
    procedure AddConnection(const ConnectionName, DriverName: string);
    procedure DeleteConnection(const ConnectionName: string);
    procedure ModifyConnection(const ConnectionName: string; Params: TStrings);
    procedure RenameConnection(const OldName, NewName: string);
  public
    constructor Create;
    destructor Destroy; override;
    property ConnectionConfig: TCustomIniFile read FConnectionConfig;
  end;


function GetConnectionAdmin: IConnectionAdmin;

implementation

uses
  System.SysUtils,
  Data.SqlConst,
  Data.SqlExpr,
  Data.DB,
  Data.DBXCommon
;

{ Global Functions }

function GetConnectionAdmin: IConnectionAdmin;
begin
  Result := IConnectionAdmin(TConnectionAdmin.Create);
end;

function FormatLine(const Key, Value: string): string;
begin
  Result := Format('%s=%s', [Key, Value]);
end;

function GetValue(const Line: string): string;
var
  ValPos: Integer;
begin
  ValPos := Line.IndexOf('=') + 1;
  if ValPos > 0 then
    Result := Line.Substring(ValPos, MAXINT) else
    Result := '';
end;

procedure WriteSectionValues(IniFile: TCustomIniFile; const Section: string; Strings: TStrings);
var
  I: Integer;
begin
  IniFile.EraseSection(Section);
  for I := 0 to Strings.Count - 1 do
    IniFile.WriteString(Section, Strings.Names[I], GetValue(Strings[I]));
  IniFile.UpdateFile;
end;

{ TConnectionAdmin }

constructor TConnectionAdmin.Create;
var
  sConfigFile: string;
begin
  inherited Create;
  sConfigFile := GetConnectionRegistryFile(True);
  if not FileExists(sConfigFile) then
    DatabaseErrorFmt(SMissingDriverRegFile,[sConfigFile]);
  FConnectionConfig := TMemIniFile.Create(sConfigFile);
  try
    TMemIniFile(FConnectionConfig).Encoding := TEncoding.UTF8;
  except
    FConnectionConfig.Free;
    raise;
  end;
end;

destructor TConnectionAdmin.Destroy;
begin
  inherited;
  FConnectionConfig.Free;
end;

procedure TConnectionAdmin.AddConnection(const ConnectionName,
  DriverName: string);
var
  Params: TStrings;
  DriverIndex: Integer;
begin
  Params := TStringList.Create;
  try
    GetDriverParams(DriverName, Params);
    Params.Insert(0, FormatLine(DRIVERNAME_KEY, DriverName));
    DriverIndex := Params.IndexOfName(GETDRIVERFUNC_KEY);
    if DriverIndex <> -1 then
      Params.Delete(DriverIndex);
    WriteSectionValues(ConnectionConfig, ConnectionName, Params);
  finally
    Params.Free
  end;
end;

procedure TConnectionAdmin.DeleteConnection(const ConnectionName: string);
begin
  ConnectionConfig.EraseSection(ConnectionName);
  ConnectionConfig.UpdateFile;
end;

function TConnectionAdmin.GetConnectionNames(List: TStrings;
  DriverName: string): Integer;
var
  I: Integer;
  A: TStringList;
begin
  A := TStringList.Create;
  try
    ConnectionConfig.ReadSections(A);
    List.Assign(A);
  finally
    A.Free;
  end;
  if DriverName <> '' then
  begin
    List.BeginUpdate;
    try
      I := List.Count - 1;
      while I >= 0 do
      begin
        if AnsiCompareText(ConnectionConfig.ReadString(List[i], DRIVERNAME_KEY, ''), DriverName) <> 0 then
          List.Delete(I);
        Dec(I);
      end;
    finally
      List.EndUpdate;
    end;
  end;
  Result := List.Count;
end;

function TConnectionAdmin.GetConnectionParams(const ConnectionName: string;
  Params: TStrings): Integer;
var
  A: TStringList;
begin
  A := TStringList.Create;
  try
    ConnectionConfig.ReadSectionValues(ConnectionName, A);
    Params.Assign(A);
  finally
    A.Free;
  end;
  Result := Params.Count;
end;

function TConnectionAdmin.GetDisplayDriverName(const DriverName: string): string;
var
  Factory: TDBXConnectionFactory;
  DisplayName: string;
begin
  Factory := TDBXConnectionFactory.GetConnectionFactory;
  TDBXConnectionFactory.Lock;
  try
    DisplayName := Factory.GetDriverProperties(DriverName).Values[TDBXPropertyNames.DisplayDriverName];
  finally
    TDBXConnectionFactory.Unlock;
  end;
  if DisplayName = '' then
    Result := DriverName
  else
    Result := DisplayName;
end;

function TConnectionAdmin.GetDisplayDriverNames(List: TStrings): Integer;
var
  DriverNameList: TStrings;
  I: Integer;
begin
  DriverNameList := TStringList.Create;
  try
    GetDriverNames(DriverNameList);
    for I := 0 to DriverNameList.Count - 1 do
      List.Add(GetDisplayDriverName(DriverNameList[I]));
    Result := List.Count;
  finally
    DriverNameList.Free;
  end;
end;

function TConnectionAdmin.GetDriverNames(List: TStrings): Integer;
var
  I: Integer;
  Factory: TDBXConnectionFactory;
begin
  Factory := TDBXConnectionFactory.GetConnectionFactory;
  TDBXConnectionFactory.Lock;
  try
    Factory.GetDriverNames(List);
    for I := List.Count - 1 downto 0  do
    begin
      if Factory.GetDriverProperties(List[I]).GetBoolean(TDBXPropertyNames.DelegateDriver) then
        List.Delete(I);
    end;
    Result := List.Count;
  finally
    TDBXConnectionFactory.Unlock;
  end;
end;

function TConnectionAdmin.GetDelegateDriverNames(List: TStrings): Integer;
var
  I: Integer;
  Factory: TDBXConnectionFactory;
begin
  Factory := TDBXConnectionFactory.GetConnectionFactory;
  TDBXConnectionFactory.Lock;
  try
    Factory.GetDriverNames(List);
    for I := List.Count - 1 downto 0  do
    begin
      if not Factory.GetDriverProperties(List[I]).GetBoolean(TDBXPropertyNames.DelegateDriver) then
        List.Delete(I);
    end;
    Result := List.Count;
  finally
    TDBXConnectionFactory.Unlock;
  end;
end;

function TConnectionAdmin.GetDriverParams(const DriverName: string; Params: TStrings): Integer;
var
  Factory: TDBXConnectionFactory;
begin
  Factory := TDBXConnectionFactory.GetConnectionFactory;
  Params.Clear;
  TDBXConnectionFactory.Lock;
  try
    Params.AddStrings(Factory.GetDriverProperties(DriverName).Properties);
  finally
    TDBXConnectionFactory.Unlock;
  end;
  Result := Params.Count;
end;

procedure TConnectionAdmin.GetDriverLibNames(const DriverName: string;
  var LibraryName, VendorLibrary: string);
var
  Factory: TDBXConnectionFactory;
  DriverProps: TDBXProperties;
begin
  Factory := TDBXConnectionFactory.GetConnectionFactory;
  TDBXConnectionFactory.Lock;
  try
    DriverProps := Factory.GetDriverProperties(DriverName);
    LibraryName := DriverProps[TDBXPropertyNames.LibraryName];
    VendorLibrary := DriverProps[TDBXPropertyNames.VendorLib];
  finally
    TDBXConnectionFactory.Unlock;
  end;
end;

procedure TConnectionAdmin.ModifyConnection(const ConnectionName: string;
  Params: TStrings);
begin
  WriteSectionValues(ConnectionConfig, ConnectionName, Params);
end;

procedure TConnectionAdmin.RenameConnection(const OldName, NewName: string);
var
  Params: TStrings;
begin
  Params := TStringList.Create;
  try
    GetConnectionParams(OldName, Params);
    ConnectionConfig.EraseSection(OldName);
    WriteSectionValues(ConnectionConfig, NewName, Params);
  finally
    Params.Free
  end;
end;

end.
