{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{                  Connection classes                   }
{*******************************************************}

unit Datasnap.Win.TConnect;

interface

uses System.Variants, System.SysUtils, System.Classes, Datasnap.Midas, Data.DB, Datasnap.DBClient,
     {$IFDEF MSWINDOWS}Winapi.Windows, Winapi.ActiveX, System.Win.ComObj, {$ENDIF}{$IFDEF LINUX}Libc,{$ENDIF}
     Datasnap.Provider;

type

  { TLocalConnection }

  TLocalConnection = class(TCustomRemoteServer, IAppServer{$IFDEF MSWINDOWS}, ISupportErrorInfo{$ENDIF})
  private
    FAppServer: IAppServer;
    FProviders: TList;
    function GetProviderCount: Integer;
  protected
    function GetProvider(const ProviderName: string): TCustomProvider; virtual;
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
{$IFDEF MSWINDOWS}
    { ISupportErrorInfo }
    function InterfaceSupportsErrorInfo(const iid: TIID): HResult; stdcall;
{$ENDIF}
  protected
    function GetConnected: Boolean; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RegisterProvider(Prov: TCustomProvider);
    procedure UnRegisterProvider(Prov: TCustomProvider);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AppServer: IAppServer read FAppServer;
    function GetServer: IAppServer; override;
    procedure GetProviderNames(Proc: TGetStrProc); override;
    property Providers[const ProviderName: string]: TCustomProvider read GetProvider;
    property ProviderCount: Integer read GetProviderCount;
{$IFDEF MSWINDOWS}
    function SafeCallException(ExceptObject: TObject;
      ExceptAddr: Pointer): HResult; override;
{$ENDIF}
  end;

implementation

uses Datasnap.MidConst, System.Generics.Collections, System.Types;

{ TLocalConnection }

function TLocalConnection.GetProviderCount: Integer;
begin
  Result := FProviders.Count;
end;

function TLocalConnection.GetConnected: Boolean;
begin
  Result := True;
end;

constructor TLocalConnection.Create(AOwner: TComponent);
var
  I: Integer;
begin
  inherited Create(AOwner);
  RCS;
  FProviders := TList.Create;
  FAppServer := Self as IAppServer;
  for I:=0 to AOwner.ComponentCount - 1 do
    if AOwner.Components[I] is TCustomProvider then
      RegisterProvider(TCustomProvider(AOwner.Components[I]));
end;

destructor TLocalConnection.Destroy;
begin
  FProviders.Free;
  FAppServer := nil;
  inherited;
end;

function TLocalConnection.GetServer: IAppServer;
begin
  Result := FAppServer;
end;

procedure TLocalConnection.GetProviderNames(Proc: TGetStrProc);
var
  List: Variant;
  I: Integer;
begin
  Connected := True;
  VarClear(List);
  try
    List := AppServer.AS_GetProviderNames;
  except
    { Assume any errors means the list is not available. }
  end;
  if VarIsArray(List) and (VarArrayDimCount(List) = 1) then
    for I := VarArrayLowBound(List, 1) to VarArrayHighBound(List, 1) do
      Proc(List[I]);
end;

procedure TLocalConnection.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent is TCustomProvider) then
    if (Operation = opInsert) then
      RegisterProvider(TCustomProvider(AComponent)) else
      UnRegisterProvider(TCustomProvider(AComponent));
end;

procedure TLocalConnection.RegisterProvider(Prov: TCustomProvider);
begin
  FProviders.Add(Prov);
end;

procedure TLocalConnection.UnRegisterProvider(Prov: TCustomProvider);
begin
  FProviders.Remove(Prov);
end;

function TLocalConnection.AS_GetProviderNames: OleVariant;
var
  List: TStringList;
  I: Integer;
begin
  List := TStringList.Create;
  try
    for I := 0 to FProviders.Count - 1 do
      if TCustomProvider(FProviders[I]).Exported then
        List.Add(TCustomProvider(FProviders[I]).Name);
    List.Sort;
    Result := VarArrayFromStrings(List);
  finally
    List.Free;
  end;
end;

function TLocalConnection.AS_ApplyUpdates(const ProviderName: WideString;
  Delta: OleVariant; MaxErrors: Integer; out ErrorCount: Integer;
  var OwnerData: OleVariant): OleVariant;
begin
  Result := Providers[ProviderName].ApplyUpdates(Delta, MaxErrors, ErrorCount, OwnerData);
end;

function TLocalConnection.AS_GetRecords(const ProviderName: WideString; Count: Integer;
  out RecsOut: Integer; Options: Integer; const CommandText: WideString;
  var Params, OwnerData: OleVariant): OleVariant;
begin
  Result := Providers[ProviderName].GetRecords(Count, RecsOut, Options,
      CommandText, Params, OwnerData);
end;

function TLocalConnection.AS_RowRequest(const ProviderName: WideString;
  Row: OleVariant; RequestType: Integer; var OwnerData: OleVariant): OleVariant;
begin
  Result := Providers[ProviderName].RowRequest(Row, RequestType, OwnerData);
end;

function TLocalConnection.AS_DataRequest(const ProviderName: WideString;
  Data: OleVariant): OleVariant; safecall;
begin
  Result := Providers[ProviderName].DataRequest(Data);
end;

function TLocalConnection.AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant;
begin
  Result := Providers[ProviderName].GetParams(OwnerData);
end;

procedure TLocalConnection.AS_Execute(const ProviderName: WideString;
  const CommandText: WideString; var Params, OwnerData: OleVariant);
begin
  Providers[ProviderName].Execute(CommandText, Params, OwnerData);
end;

function TLocalConnection.GetProvider(const ProviderName: string): TCustomProvider;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FProviders.Count - 1 do
    if AnsiCompareText(TCustomProvider(FProviders[I]).Name, ProviderName) = 0 then
    begin
      Result := TCustomProvider(FProviders[I]);
      if not Result.Exported then
        Result := nil;
      Break;
    end;
  if not Assigned(Result) then
    raise Exception.CreateResFmt(@SProviderNotExported, [ProviderName]);
end;

{$IFDEF MSWINDOWS}
function TLocalConnection.InterfaceSupportsErrorInfo(
  const iid: TIID): HResult;
begin
  if IsEqualGUID(IAppServer, iid) then
    Result := S_OK else
    Result := S_FALSE;
end;

function TLocalConnection.SafeCallException(ExceptObject: TObject;
  ExceptAddr: Pointer): HResult;
begin
  Result := HandleSafeCallException(ExceptObject, ExceptAddr, IAppServer, '', '');
end;
{$ENDIF}

end.


