{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{       Connection classes                              }
{                                                       }
{       Copyright (c) 1997,99 Inprise Corporation       }
{                                                       }
{*******************************************************}

unit TConnect;

interface

uses Variants, SysUtils, Classes, Midas, DB, DBClient, 
     {$IFDEF MSWINDOWS}Windows, ActiveX, ComObj, {$ENDIF}{$IFDEF LINUX}Libc,{$ENDIF}
     Provider;

type

  { TLocalConnection }

  TLocalConnection = class(TCustomRemoteServer, IAppServer{$IFDEF MSWINDOWS}, ISupportErrorInfo{$ENDIF})
  private
    FAppServer: IAppServer;
    FProviders: TList;
    function GetProviderCount: integer;
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
    procedure GetProviderNames(Proc: TGetStrProc); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RegisterProvider(Prov: TCustomProvider);
    procedure UnRegisterProvider(Prov: TCustomProvider);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AppServer: IAppServer read FAppServer;
    function GetServer: IAppServer; override;
    property Providers[const ProviderName: string]: TCustomProvider read GetProvider;
    property ProviderCount: integer read GetProviderCount;
{$IFDEF MSWINDOWS}
    function SafeCallException(ExceptObject: TObject;
      ExceptAddr: Pointer): HResult; override;
{$ENDIF}
  end;

implementation

uses MidConst;

{ TLocalConnection }

function TLocalConnection.GetProviderCount: integer;
begin
  Result := FProviders.Count;
end;

function TLocalConnection.GetConnected: Boolean;
begin
  Result := True;
end;

constructor TLocalConnection.Create(AOwner: TComponent);
var
  i: integer;
begin
  inherited Create(AOwner);
  RCS;
  FProviders := TList.Create;
  FAppServer := Self as IAppServer;
  for i:=0 to AOwner.ComponentCount - 1 do
    if AOwner.Components[i] is TCustomProvider then
      RegisterProvider(TCustomProvider(AOwner.Components[i]));
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
  i: Integer;
begin
  List := TStringList.Create;
  try
    for i := 0 to FProviders.Count - 1 do
      if TCustomProvider(FProviders[i]).Exported then
        List.Add(TCustomProvider(FProviders[i]).Name);
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
  i: Integer;
begin
  Result := nil;
  for i := 0 to FProviders.Count - 1 do
    if AnsiCompareText(TCustomProvider(FProviders[i]).Name, ProviderName) = 0 then
    begin
      Result := TCustomProvider(FProviders[i]);
      if not Result.Exported then
        Result := nil;
      Exit;
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


