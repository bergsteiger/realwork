{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{       SOAP client-side invoker                        }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.SOAPConn;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Datasnap.Midas, Datasnap.DBClient, Soap.SOAPHTTPTrans, Soap.Rio, Soap.SOAPHTTPClient, Soap.SOAPMidas;

type

  { TSoapConnection }
  TSoapConnection = class(TCustomRemoteServer)
  private
    FRIO: THTTPRIO;
    FURL: string;

    { Shadow variables for FRio variable entries }
    FAgent: string;
    FPassword : string;
    FProxy : string;
    FProxyByPass : string;
    FUserName : string;

    { Old-style (D6) interface holder - hardcoded to IAppServer only }
    FAppServer: IAppServer;

    { New IAppServerSOAP (or derived via FSOAPServerIID) interface }
    FSOAPServer: IAppServerSOAP;
    FUseSOAPAdapter: Boolean;
    FSOAPServerIID: String;

    FOnAfterExecute: TAfterExecuteEvent;
    FOnBeforeExecute: TBeforeExecuteEvent;
    function  GetAgent: string;
    function  GetPassword: string;
    function  GetProxy: string;
    function  GetProxyByPass: string;
    function  GetUserName: string;
    procedure SetAgent(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetProxy(const Value: string);
    procedure SetProxyByPass(const Value: string);
    procedure SetURL(const Value: string);
    procedure SetUserName(const Value: string);
  protected
    procedure DoConnect; override;
    function  GetConnected: Boolean; override;
    procedure DoDisconnect; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetUseSoapAdapter(Value: Boolean);
    procedure SetSOAPServerIID(const IID: String);
    function  GetSOAPServerIID: TGUID;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    GetServerList: OleVariant; override;
    procedure   GetProviderNames(Proc: TGetStrProc); override;
    function    GetServer: IAppServer; override;
    function    GetSOAPServer: IAppServerSOAP;
    { Give access to underlying RIO }
    property    RIO: THTTPRIO read FRIO;
  published

    property Agent: string read GetAgent write SetAgent;
    { Publish standard DataSnap Connection properties}
    property Connected;
    property AfterConnect;
    property BeforeConnect;
    property AfterDisconnect;
    property BeforeDisconnect;

    property Password: string read GetPassword write SetPassword;
    property Proxy: string read GetProxy write SetProxy;
    property ProxyByPass: string read GetProxyByPass write SetProxyByPass;
    property URL: string read FURL write SetURL;

    property SOAPServerIID: String read FSOAPServerIID write SetSOAPServerIID;

    property UserName: string read GetUserName write SetUserName;
    property UseSOAPAdapter: Boolean read FUseSOAPAdapter write SetUseSOAPAdapter;

    property OnAfterExecute: TAfterExecuteEvent read FOnAfterExecute write FOnAfterExecute;
    property OnBeforeExecute: TBeforeExecuteEvent read FOnBeforeExecute write FOnBeforeExecute;
  end;


implementation

uses
  {$IFDEF MSWINDOWS}System.Win.ComObj,{$ENDIF}
  Soap.InvokeRegistry, Soap.SOAPConst, System.Types;

type

  { Adapter class that allows local access to IAppServer when a remote SOAP
    server exposes IAppServerSOAP
    IOW: This class provides a local implementation of IAppServer that talks
         IAppServerSOAP to a SOAP Service
  }
  TSOAPAppServerAdapter = class(TInterfacedObject, IAppServer)
  private
    FSOAPServer: IAppServerSOAP;
{$IFDEF MSWINDOWS}
    function SafeCallException(ExceptObject: TObject;
                               ExceptAddr: Pointer): HResult; override;
{$ENDIF}
  public
    constructor Create(const AppServerSOAP: IAppServerSOAP);
    { IAppServer }
    function  AS_ApplyUpdates(const ProviderName: OleStr; Delta: OleVariant;
                              MaxErrors: Integer; out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; safecall;
    function  AS_GetRecords(const ProviderName: OleStr; Count: Integer; out RecsOut: Integer;
                            Options: Integer; const CommandText: OleStr;
                            var Params: OleVariant; var OwnerData: OleVariant): OleVariant; safecall;
    function  AS_DataRequest(const ProviderName: OleStr; Data: OleVariant): OleVariant; safecall;
    function  AS_GetProviderNames: OleVariant; safecall;
    function  AS_GetParams(const ProviderName: OleStr; var OwnerData: OleVariant): OleVariant; safecall;
    function  AS_RowRequest(const ProviderName: OleStr; Row: OleVariant; RequestType: Integer;
                            var OwnerData: OleVariant): OleVariant; safecall;
    procedure AS_Execute(const ProviderName: OleStr; const CommandText: OleStr;
                         var Params: OleVariant; var OwnerData: OleVariant); safecall;
    { IDispatch: NOTE Methods of IDispatch are not exposed via SOAP }
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
                           NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
                            Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  end;

constructor TSOAPAppServerAdapter.Create(const AppServerSOAP: IAppServerSOAP);
begin
  inherited Create;
  FSOAPServer := AppServerSOAP;
end;

function TSOAPAppServerAdapter.AS_ApplyUpdates(const ProviderName: OleStr; Delta: OleVariant;
                          MaxErrors: Integer; out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; safecall;
begin
  Result := FSOAPServer.SAS_ApplyUpdates(ProviderName, Delta, MaxErrors, ErrorCount, OwnerData);
end;

function TSOAPAppServerAdapter.AS_GetRecords(const ProviderName: OleStr; Count: Integer; out RecsOut: Integer;
                        Options: Integer; const CommandText: OleStr;
                        var Params: OleVariant; var OwnerData: OleVariant): OleVariant; safecall;
begin
  Result := FSOAPServer.SAS_GetRecords(ProviderName, Count, RecsOut, Options, CommandText, Params, OwnerData);
end;

function TSOAPAppServerAdapter.AS_DataRequest(const ProviderName: OleStr; Data: OleVariant): OleVariant; safecall;
begin
  Result := FSOAPServer.SAS_DataRequest(ProviderName, Data);
end;

function TSOAPAppServerAdapter.AS_GetProviderNames: OleVariant; safecall;
var
{$IFDEF NEXTGEN}
  Names: TStringDynArray;
{$ELSE !NEXTGEN}
  Names: TWideStringDynArray;
{$ENDIF NEXTGEN}
  I, Count: Integer;
begin
  VarClear(Result);
  Names := FSOAPServer.SAS_GetProviderNames;
  if Length(Names) > 0 then
  begin
    Count := Length(Names);
    Result := VarArrayCreate([0, Count-1], varVariant);
    for I := 0 to Length(Names)-1 do
      Result[I] := Variant(Names[I]);
  end
end;

function TSOAPAppServerAdapter.AS_GetParams(const ProviderName: OleStr; var OwnerData: OleVariant): OleVariant; safecall;
begin
  Result := FSOAPServer.SAS_GetParams(ProviderName, OwnerData);
end;

function TSOAPAppServerAdapter.AS_RowRequest(const ProviderName: OleStr; Row: OleVariant; RequestType: Integer;
                        var OwnerData: OleVariant): OleVariant; safecall;
begin
  Result := FSOAPServer.SAS_RowRequest(ProviderName, Row, RequestType, OwnerData);
end;

procedure TSOAPAppServerAdapter.AS_Execute(const ProviderName: OleStr; const CommandText: OleStr;
                     var Params: OleVariant; var OwnerData: OleVariant); safecall;
begin
  FSOAPServer.SAS_Execute(ProviderName, CommandText, Params, OwnerData);
end;

function TSOAPAppServerAdapter.GetTypeInfoCount(out Count: Integer): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TSOAPAppServerAdapter.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TSOAPAppServerAdapter.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TSOAPAppServerAdapter.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

{$IFDEF MSWINDOWS}
function TSOAPAppServerAdapter.SafeCallException(ExceptObject: TObject;
                                                 ExceptAddr: Pointer): HResult;
begin
  Result := HandleSafeCallException(ExceptObject, ExceptAddr, IAppServer, '', '');
end;
{$ENDIF}


{ TSoapConnection }
constructor TSoapConnection.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  RPR;
  { FUseSOAPAdapter should be disabled when talking to SOAP
    Services that only expose IAppServer - i.e. Delphi/6 &
    Kylix servers - until these are updated }
  FUseSOAPAdapter := True;
  { We'll assume IAppServerSOAP as the default interface of Servers }
  FSOAPServerIID := Format(SSOAPServerIIDFmt, ['IAppServerSOAP', GUIDToString(IAppServerSOAP)]); { do not localize }
end;

destructor TSoapConnection.Destroy;
begin
  inherited;
end;

procedure TSoapConnection.DoDisconnect;
begin
  inherited;
  { Clean link to remote SOAP Server }
  FAppServer := nil;
  FSOAPServer := nil;
  if Assigned(FRIO) then
    FRIO := nil;
end;

procedure TSoapConnection.SetUseSoapAdapter(Value: Boolean);
begin
  if FUseSOAPAdapter <> Value then
  begin
    Connected := False;
    FUseSOAPAdapter := Value;
  end;
end;

procedure TSoapConnection.GetProviderNames(Proc: TGetStrProc);
var
  List: Variant;
  I: Integer;
begin
  Connected := True;
  VarClear(List);
  try
    List := FAppServer.AS_GetProviderNames;
  except
    { Assume any errors means the list is not available. }
  end;
  if VarIsArray(List) and (VarArrayDimCount(List) = 1) then
    for I := VarArrayLowBound(List, 1) to VarArrayHighBound(List, 1) do
      Proc(List[I]);
end;

function TSoapConnection.GetServer: IAppServer;
begin
  Connected := True;
  Result := FAppServer;
end;

{ Provides direct access to the underlying SOAP Server that
  implements IAppServer }
function TSoapConnection.GetSOAPServer: IAppServerSOAP;
begin
  Result := FSOAPServer;
end;

function TSoapConnection.GetServerList: OleVariant;
begin
end;

procedure TSoapConnection.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
end;

procedure TSoapConnection.DoConnect;
var
  Res: HResult;
  Info: Pointer;
begin
  if (URL = '') then
    raise Exception.Create(SNoURL);
  if not Assigned(FRIO) then
  try
    FRIO := THTTPRIO.Create(nil);

    { FRio has a default agent so if the user hasn't specified
      one we need to move the default value to our shadow variable }
    if FAgent = '' then
      FAgent := FRIO.HTTPWebNode.Agent
    else
      FRIO.HTTPWebNode.Agent := FAgent;

    { Enter shadow variable data into FRio }
    FRIO.HTTPWebNode.Password := FPassword;
    FRIO.HTTPWebNode.Proxy := FProxy;
    FRIO.HTTPWebNode.ProxyByPass := FProxyByPass;
    FRIO.HTTPWebNode.UserName := FUserName;

    if FUseSOAPAdapter then
    begin
      { Make sure this interface has been registered }
      { If you've selected an interface other than IAppServer(SOAP)
        then you need to make sure that you import the WSDL of the
        Service exposing that interface and that you include the
        resulting unit in your project }
      Info := InvRegistry.GetInterfaceTypeInfo(GetSOAPServerIID);
      if Info = nil then
        raise  Exception.CreateFmt(SSOAPInterfaceNotRegistered, [FSOAPServerIID]);
      Res := FRIO.QueryInterface(GetSOAPServerIID, FSOAPServer);
      if Res <> 0 then
        raise  Exception.CreateFmt(SSOAPInterfaceNotRemotable, [FSOAPServerIID]);
      { FSOAPServer := FRIO as IAppServerSOAP; }
      FAppServer := TSOAPAppServerAdapter.Create(FSOAPServer);
    end
    else
      FAppServer := FRIO as IAppServer;

    if Assigned(FOnAfterExecute) then
      FRIO.OnAfterExecute := FOnAfterExecute;
    if Assigned(FOnBeforeExecute) then
      FRIO.OnBeforeExecute := FOnBeforeExecute;
    FRIO.URL := FURL;
  except
    Connected := False;
  end;
end;

function TSoapConnection.GetConnected: Boolean;
begin
  Result := Assigned(FRIO) and (Assigned(FRIO.HTTPWebNode));
end;

function TSoapConnection.GetAgent: string;
begin
  if Assigned(FRIO) and Assigned(FRIO.HTTPWebNode) then
    Result := FRIO.HTTPWebNode.Agent
  else
    Result := FAgent;
end;

function TSoapConnection.GetPassword: string;
begin
  if Assigned(FRIO) and Assigned(FRIO.HTTPWebNode) then
    Result := FRIO.HTTPWebNode.Password
  else
    Result := FPassword;
end;

function TSoapConnection.GetProxy: string;
begin
  if Assigned(FRIO) and Assigned(FRIO.HTTPWebNode) then
    Result := FRIO.HTTPWebNode.Proxy
  else
    Result := FProxy;
end;

function TSoapConnection.GetProxyByPass: string;
begin
  if Assigned(FRIO) and Assigned(FRIO.HTTPWebNode) then
    Result := FRIO.HTTPWebNode.ProxyByPass
  else
    Result := FProxyByPass;
end;

function TSoapConnection.GetUserName: string;
begin
  if Assigned(FRIO) and Assigned(FRIO.HTTPWebNode) then
    Result := FRIO.HTTPWebNode.Username
  else
    Result := FUsername;
end;

procedure TSoapConnection.SetURL(const Value: string);
begin
  if Value <> FURL then
  begin
    FURL := Value;
    Connected := False;
  end;
end;

procedure TSoapConnection.SetAgent(const Value: string);
begin
  if Assigned(FRIO) and Assigned(FRIO.HTTPWebNode) then
  begin
    FRIO.HTTPWebNode.Agent := Value;
    FAgent := Value;
  end
  else
    FAgent := Value;
end;

procedure TSoapConnection.SetPassword(const Value: string);
begin
  if Assigned(FRIO) and Assigned(FRIO.HTTPWebNode) then
  begin
    FRIO.HTTPWebNode.Password := Value;
    FPassword := Value;
  end
  else
    FPassword := Value;
end;

procedure TSoapConnection.SetProxy(const Value: string);
begin
  if Assigned(FRIO) and Assigned(FRIO.HTTPWebNode) then
  begin
    FRIO.HTTPWebNode.Proxy := Value;
    FProxy := Value;
  end
  else
    FProxy := Value;
end;

procedure TSoapConnection.SetProxyByPass(const Value: string);
begin
  if Assigned(FRIO) and Assigned(FRIO.HTTPWebNode) then
  begin
    FRIO.HTTPWebNode.ProxyByPass := Value;
    FProxyByPass := Value;
  end
  else
    FProxyByPass := Value;
end;

procedure TSoapConnection.SetUserName(const Value: string);
begin
  if Assigned(FRIO) and Assigned(FRIO.HTTPWebNode) then
  begin
    FRIO.HTTPWebNode.UserName := Value;
    FUserName := Value;
  end
  else
    FUserName := Value;
end;

procedure TSoapConnection.SetSOAPServerIID(const IID: String);
begin
  FSOAPServerIID := IID;
end;

function TSoapConnection.GetSOAPServerIID: TGUID;
var
  StrIID: String;
  Idx: Integer;
begin
  StrIID := FSOAPServerIID;
  Idx := Pos('{', StrIID);  { Do not localize }
  if Idx > -1 then
    StrIID := Copy(StrIID, Idx, MaxInt);
  Idx := Pos('}', StrIID);  { Do not localize }
  if Idx > -1 then
    StrIID := Copy(StrIID, 0, Idx);
  Result := StringToGUID(StrIID);
end;

end.
