{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{             Remote Data Module support                }
{*******************************************************}

unit Datasnap.DataBkr;

{$T-,H+,X+}

interface

uses
  System.Variants, System.Classes, Datasnap.Midas, Datasnap.Provider, System.SysUtils,
  System.Generics.Collections;

type

  TProviderDataModule = class(TDataModule)
  private
    FProviders: TList<TCustomProvider>;
    function GetProviderCount: Integer;

  protected
    function GetProvider(const ProviderName: string): TCustomProvider; virtual;
    procedure CleanProviders;

  public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      function ProviderNamesToVariant: OleVariant;

      procedure RegisterProvider(Value: TCustomProvider); virtual;
      procedure UnRegisterProvider(Value: TCustomProvider); virtual;

      property Providers[const ProviderName: string]: TCustomProvider read GetProvider;
      property ProviderCount: Integer read GetProviderCount;
  end;
  { TRemoteDataModule }

// Enable the invocation of server methods on RDMS.
//

                                                                        
{$IF DEFINED(MSWINDOWS) and NOT DEFINED(NEXTGEN)}
{$MethodInfo ON}
  TRemoteDataModule = class(TProviderDataModule, IAppServer)
  private
    FLock: TObject;
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    { IAppServer }
    function AS_GetProviderNames: OleVariant; safecall;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant;
      MaxErrors: Integer; out ErrorCount: Integer;
      var OwnerData: OleVariant): OleVariant; safecall;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer;
      out RecsOut: Integer; Options: Integer; const CommandText: WideString;
      var Params, OwnerData: OleVariant): OleVariant; safecall;
    function AS_DataRequest(const ProviderName: WideString;
      Data: OleVariant): OleVariant; safecall;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; safecall;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant;
      RequestType: Integer; var OwnerData: OleVariant): OleVariant; safecall;
    procedure AS_Execute(const ProviderName: WideString;
      const CommandText: WideString; var Params, OwnerData: OleVariant); safecall;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Lock; virtual;
    procedure Unlock; virtual;
  end;
{$MethodInfo OFF}

  TRemoteDataModuleClass = class of TRemoteDataModule;
{$ENDIF}

{ TCRemoteDataModule --- a slimmed down RDM that doesn't implement IAppServer,
  used in C++Builder. +}
type
  TCRemoteDataModule = class(TDataModule)
  private
    FProviders: TList<TCustomProvider>;
    FLock: TObject;
    function GetProviderCount: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RegisterProvider(Value: TCustomProvider); virtual;
    procedure UnRegisterProvider(Value: TCustomProvider); virtual;
    procedure Lock; virtual;
    procedure UnLock; virtual;
    function CRDMGetProviderNames: OleVariant;
    function GetProvider(const ProviderName: string): TCustomProvider; virtual;
    property Providers[const ProviderName:string]:TCustomProvider read GetProvider;
    property ProviderCount: Integer read GetProviderCount;
  end;

procedure RegisterPooled(const ClassID: string; Max, Timeout: Integer; Singleton: Boolean = False);
procedure UnregisterPooled(const ClassID: string);
procedure EnableSocketTransport(const ClassID: string);
procedure DisableSocketTransport(const ClassID: string);
procedure EnableWebTransport(const ClassID: string);
procedure DisableWebTransport(const ClassID: string);

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$IFNDEF NEXTGEN}
  Winapi.ActiveX, System.Win.ComObj,
{$ENDIF !NEXTGEN}
{$ENDIF}
  Datasnap.MidConst;


{ Utility routines }

procedure RegisterPooled(const ClassID: string; Max, Timeout: Integer;
  Singleton: Boolean = False);
begin
{ Do not localize }
{$IF DEFINED(MSWINDOWS) and NOT DEFINED(NEXTGEN)}
  CreateRegKey(SClsid + ClassID, SPooled, SFlagOn);
  CreateRegKey(SClsid + ClassID, SMaxObjects, IntToStr(Max));
  CreateRegKey(SClsid + ClassID, STimeout, IntToStr(Timeout));
  if Singleton then
    CreateRegKey(SClsid + ClassID, SSingleton, SFlagOn) else
    CreateRegKey(SClsid + ClassID, SSingleton, SFlagOff);
{$ENDIF}
end;

{$IFDEF MSWINDOWS}
procedure DeleteRegValue(const Key, ValueName: string);
var
  Handle: HKey;
  Status: Integer;
begin
  Status := RegOpenKeyEx(HKEY_CLASSES_ROOT, PChar(Key), 0, KEY_WRITE, Handle);
  if Status = 0 then
  begin
    RegDeleteValue(Handle, PChar(ValueName));
    RegCloseKey(Handle);
  end;
end;
{$ENDIF}
{$IFDEF POSIX}
procedure DeleteRegValue(const Key, ValueName: string);
begin
end;
{$ENDIF}

procedure UnregisterPooled(const ClassID: string);
begin
  DeleteRegValue(SClsid + ClassID, SPooled);
  DeleteRegValue(SClsid + ClassID, SMaxObjects);
  DeleteRegValue(SClsid + ClassID, STimeout);
  DeleteRegValue(SClsid + ClassID, SSingleton);
end;

procedure EnableSocketTransport(const ClassID: string);
begin
{$IF DEFINED(MSWINDOWS) and NOT DEFINED(NEXTGEN)}
  CreateRegKey(SClsid + ClassID, SSockets, SFlagOn);
{$ENDIF}
end;

procedure DisableSocketTransport(const ClassID: string);
begin
  DeleteRegValue(SClsid + ClassID, SSockets);
end;

procedure EnableWebTransport(const ClassID: string);
begin
{$IF DEFINED(MSWINDOWS) and NOT DEFINED(NEXTGEN)}
  CreateRegKey(SClsid + ClassID, SWeb, SFlagOn);
{$ENDIF}
end;

procedure DisableWebTransport(const ClassID: string);
begin
  DeleteRegValue(SClsid + ClassID, SWeb);
end;

{ TRemoteDataModule }

{$IF DEFINED(MSWINDOWS) and NOT DEFINED(NEXTGEN)}
constructor TRemoteDataModule.Create(AOwner: TComponent);
begin
  FLock := TObject.Create;
  inherited Create(AOwner);
end;

destructor TRemoteDataModule.Destroy;
begin
  inherited Destroy;
  FLock.Free;
end;

procedure TRemoteDataModule.Lock;
begin
  TMonitor.Enter(FLock);
end;

procedure TRemoteDataModule.Unlock;
begin
  TMonitor.Exit(FLock);
end;

function TRemoteDataModule.AS_GetProviderNames: OleVariant;
begin
  Lock;
  try
    Result := ProviderNamesToVariant;
  finally
    UnLock;
  end;
end;

function TRemoteDataModule.AS_ApplyUpdates(const ProviderName: WideString;
  Delta: OleVariant; MaxErrors: Integer; out ErrorCount: Integer;
  var OwnerData: OleVariant): OleVariant;
begin
  Lock;
  try
    Result := Providers[ProviderName].ApplyUpdates(Delta, MaxErrors, ErrorCount, OwnerData);
  finally
    UnLock;
  end;
end;

function TRemoteDataModule.AS_GetRecords(const ProviderName: WideString; Count: Integer;
  out RecsOut: Integer; Options: Integer; const CommandText: WideString;
  var Params, OwnerData: OleVariant): OleVariant;
begin
  Lock;
  try
    Result := Providers[ProviderName].GetRecords(Count, RecsOut, Options,
      CommandText, Params, OwnerData);
  finally
    UnLock;
  end;
end;

function TRemoteDataModule.AS_RowRequest(const ProviderName: WideString;
  Row: OleVariant; RequestType: Integer; var OwnerData: OleVariant): OleVariant;
begin
  Lock;
  try
    Result := Providers[ProviderName].RowRequest(Row, RequestType, OwnerData);
  finally
    UnLock;
  end;
end;

function TRemoteDataModule.AS_DataRequest(const ProviderName: WideString;
  Data: OleVariant): OleVariant; safecall;
begin
  Lock;
  try
    Result := Providers[ProviderName].DataRequest(Data);
  finally
    UnLock;
  end;
end;

function TRemoteDataModule.AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant;
begin
  Lock;
  try
    Result := Providers[ProviderName].GetParams(OwnerData);
  finally
    UnLock;
  end;
end;

procedure TRemoteDataModule.AS_Execute(const ProviderName: WideString;
  const CommandText: WideString; var Params, OwnerData: OleVariant);
begin
  Lock;
  try
    Providers[ProviderName].Execute(CommandText, Params, OwnerData);
  finally
    UnLock;
  end;
end;

class procedure TRemoteDataModule.UpdateRegistry(Register: Boolean;
  const ClassID, ProgID: string);
{$IFDEF MSWINDOWS}
var
  CatReg: ICatRegister;
  Rslt: HResult;
  CatInfo: TCATEGORYINFO;
  Description: string;
begin
  Rslt := CoCreateInstance(CLSID_StdComponentCategoryMgr, nil,
    CLSCTX_INPROC_SERVER, ICatRegister, CatReg);
  if Succeeded(Rslt) then
  begin
    if Register then
    begin
      CatInfo.catid := CATID_MIDASAppServer;
      CatInfo.lcid := $0409;
      StringToWideChar(MIDAS_CatDesc, CatInfo.szDescription,
        MIDAS_CatDesc.Length + 1);
      OleCheck(CatReg.RegisterCategories(1, @CatInfo));
      OleCheck(CatReg.RegisterClassImplCategories(StringToGUID(ClassID), 1, @CATID_MIDASAppServer));
    end else
    begin
      OleCheck(CatReg.UnRegisterClassImplCategories(StringToGUID(ClassID), 1, @CATID_MIDASAppServer));
      DeleteRegKey(string.Format(SClsid + SCatImplBaseKey, [ClassID]));
    end;
  end else
  begin
    if Register then
    begin
      CreateRegKey('Component Categories\' + GUIDToString(CATID_MIDASAppServer), '409', MIDAS_CatDesc);
      CreateRegKey(string.Format(SClsid + SCatImplKey, [ClassID, GUIDToString(CATID_MIDASAppServer)]), '', '');
    end else
    begin
      DeleteRegKey(string.Format(SClsid + SCatImplKey, [ClassID, GUIDToString(CATID_MIDASAppServer)]));
      DeleteRegKey(string.Format(SClsid + SCatImplBaseKey, [ClassID]));
    end;
  end;
  if Register then
  begin
    Description := GetRegStringValue(SClsid + ClassID, '');
    CreateRegKey('AppID\' + ClassID, '', Description);
    CreateRegKey(SClsid + ClassID, 'AppID', ClassID);
  end else
    DeleteRegKey('AppID\' + ClassID);
end;
{$ENDIF}
{$IFDEF POSIX}
begin
end;
{$ENDIF}
{$ENDIF}

{ TProviderDataModule }

procedure TProviderDataModule.CleanProviders;
begin
  FProviders.Free;
end;

constructor TProviderDataModule.Create(AOwner: TComponent);
begin
  FProviders := TList<TCustomProvider>.Create;
  inherited Create(AOwner);
end;

destructor TProviderDataModule.Destroy;
begin
  inherited Destroy;
  CleanProviders;
end;

function TProviderDataModule.GetProvider(
  const ProviderName: string): TCustomProvider;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FProviders.Count - 1 do
    if AnsiCompareText(FProviders[i].Name, ProviderName) = 0 then
    begin
      Result := FProviders[i];
      if not Result.Exported then
        Result := nil;
      Break;
    end;
  if not Assigned(Result) then
    raise Exception.CreateResFmt(@SProviderNotExported, [ProviderName]);
end;

function TProviderDataModule.GetProviderCount: Integer;
begin
  Result := FProviders.Count;
end;

function TProviderDataModule.ProviderNamesToVariant: OleVariant;
var
  List: TStringList;
  i: Integer;
begin
    List := TStringList.Create;
    try
      for i := 0 to FProviders.Count - 1 do
        if FProviders[i].Exported then
          List.Add(FProviders[i].Name);
      List.Sort;
      Result := VarArrayFromStrings(List);
    finally
      List.Free;
    end;
end;

procedure TProviderDataModule.RegisterProvider(Value: TCustomProvider);
begin
  FProviders.Add(Value);
end;

procedure TProviderDataModule.UnRegisterProvider(Value: TCustomProvider);
begin
  FProviders.Remove(Value);
end;

{TCRemoteDataModule}

constructor TCRemoteDataModule.Create(AOwner: TComponent);
begin
  FLock := TObject.Create;
  FProviders := TList<TCustomProvider>.Create;
  inherited Create(AOwner);
end;

destructor TCRemoteDataModule.Destroy;
begin
  inherited Destroy;
  FProviders.Free;
  FLock.Free;
end;

procedure TCRemoteDataModule.Lock;
begin
  TMonitor.Enter(FLock);
end;

procedure TCRemoteDataModule.Unlock;
begin
  TMonitor.Exit(FLock);
end;

procedure TCRemoteDataModule.RegisterProvider(Value: TCustomProvider);
begin
  FProviders.Add(Value);
end;

procedure TCRemoteDataModule.UnRegisterProvider(Value: TCustomProvider);
begin
  FProviders.Remove(Value);
end;

function TCRemoteDataModule.CRDMGetProviderNames: OleVariant;
var
  List: TStringList;
  I, J: Integer;
begin
Lock;
  try
    List := TStringList.Create;
    try
      for I := 0 to FProviders.Count - 1 do
        if FProviders[I].Exported then
          List.Add(FProviders[I].Name);
      List.Sort;
      if List.Count > 0 then
      begin
{$IFNDEF NEXTGEN}
       Result := VarArrayCreate([0, List.Count -1], varOleStr);
       for J := 0 to List.Count -1 do Result[J] := WideString(List[J]);
{$ELSE}
       Result := VarArrayCreate([0, List.Count -1], varUString);
       for J := 0 to List.Count -1 do Result[J] := string(List[J]);
{$ENDIF !NEXTGEN}
    end;
    finally
      List.Free;
    end;
  finally
    UnLock;
  end;
end;


function TCRemoteDataModule.GetProvider(const ProviderName: string): TCustomProvider;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FProviders.Count - 1 do
    if AnsiCompareStr(FProviders[i].Name, ProviderName) = 0 then
    begin
      Result := FProviders[i];
      if not Result.Exported then
        Result := nil;
      Break;
    end;
  if not Assigned(Result) then
    raise Exception.CreateResFmt(@SProviderNotExported, [ProviderName]);
end;

function TCRemoteDataModule.GetProviderCount: Integer;
begin
  Result := FProviders.Count;
end;

end.
