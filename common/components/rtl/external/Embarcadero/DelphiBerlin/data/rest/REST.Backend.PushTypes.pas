{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.PushTypes;

interface

uses System.Generics.Collections, System.SysUtils, System.Classes, System.JSON, System.PushNotification,
  REST.Backend.Providers, REST.Backend.MetaTypes, REST.Backend.ServiceTypes;


type

  TPushData = class;

  TDeviceRegisteredAtProviderEvent = procedure(const AService: TPushService) of object;

  IBackendPushApi = interface;
  IBackendPushDeviceApi = interface;

  IBackendPushDeviceService = interface(IBackendService)
    ['{1810D21D-BF97-4DF0-B39A-DECA2A8A6F07}']
    function GetPushDeviceAPI: IBackendPushDeviceApi;
    function CreatePushDeviceApi: IBackendPushDeviceApi;
    property PushDeviceAPI: IBackendPushDeviceApi read GetPushDeviceAPI;
  end;


  // Service must implement this
  IBackendPushDeviceApi = interface
    ['{2F1A3600-8C92-4C74-9D20-E800FD275482}']
    function GetPushService: TPushService; // May raise exception
    function HasPushService: Boolean;
    procedure RegisterDevice(AOnRegistered: TDeviceRegisteredAtProviderEvent);
    procedure UnregisterDevice;
  end;

  /// <summary>Providers may implement this interface in order to allow a device
  /// to register customer installation properties, such as {"channels":["a", "b"]}
  /// </summary>
  IBackendPushDeviceApi2 = interface
    ['{3A78B2C1-233B-485D-9616-049A66E374B3}']
    /// <summary>Register a device.  Include the properties that will be written to the installation object</summary>
    procedure RegisterDevice(const AProperties: TJSONObject; AOnRegistered: TDeviceRegisteredAtProviderEvent);
    /// <summary>Get the identify of the installation object after a device has been registered.  True is returned if the identity
    /// is available.  Use the TBackendEntityValue.ObjectID property to retrieve the object id of the installation object.
    /// </summary>
    function TryGetInstallationValue(out AValue: TBackendEntityValue): Boolean;
  end;

  // Wrapper
  TBackendPushDeviceApi = class(TBackendAuthenticationApi)
  private
    FServiceApi: IBackendPushDeviceApi;
    FService: IBackendPushDeviceService;
    function GetServiceAPI: IBackendPushDeviceApi;
  protected
    function GetAuthenticationApi: IBackendAuthenticationApi; override;
  public
    constructor Create(const AApi: IBackendPushDeviceApi); overload;
    constructor Create(const AService: IBackendPushDeviceService); overload;
    function GetPushService: TPushService; // May raise exception
    function HasPushService: Boolean;
    procedure RegisterDevice(AOnRegistered: TDeviceRegisteredAtProviderEvent); overload;
    procedure RegisterDevice(const AProperties: TJSONObject; AOnRegistered: TDeviceRegisteredAtProviderEvent); overload;
    procedure UnregisterDevice;
    /// <summary>Get the identify of the installation object after a device has been registered.  True is returned if the identity
    /// is available.  Use the TBackendEntityValue.ObjectID property to retrieve the object id of the installation object.
    /// </summary>
    function TryGetInstallationValue(out AValue: TBackendEntityValue): Boolean;
    property ProviderAPI: IBackendPushDeviceApi read FServiceAPI;
  end;

  IBackendPushService = interface(IBackendService)
    ['{34547227-6E40-40F7-A59D-4961FDBD499B}']
    function GetPushAPI: IBackendPushApi;
    function CreatePushApi: IBackendPushApi;
    property PushAPI: IBackendPushApi read GetPushAPI;
  end;


  // Service must implement this
  IBackendPushApi = interface(IBackendApi)
    ['{F7FAC938-CE46-42A9-B4D2-8620365A64B0}']
    procedure PushBroadcast(const AData: TPushData);
  end;

 /// <summary>Providers may implement this interface to support broadcasing a JSON payload.
  /// </summary>
  IBackendPushApi2 = interface
    ['{E9E1859D-1C35-4266-A335-490508A2C6EE}']
    /// <summary>Broadcast a notification</summary>
    procedure PushBroadcast(const AData: TJSONObject); overload;
    /// <summary>Create a TJSONObject that represents TPushData</summary>
    function PushDataAsJSON(const AData: TPushData): TJSONObject;
  end;


  /// <summary>Providers may implement this interface to support broadcasting a notification
  /// to a target, such as {"channels": ["a"]}.  The format of the target is provider specific. 
  /// </summary>
  IBackendPushApi3 = interface
   ['{E0B215B3-8709-4D80-A2DE-8847A69D1773}']
    /// <summary>Send a notification to a target</summary>
    procedure PushToTarget(const AData: TPushData; const ATarget: TJSONObject); overload;
    procedure PushToTarget(const AData: TJSONObject; const ATarget: TJSONObject); overload;
  end;


  // Wrapper
  TBackendPushApi = class(TBackendAuthenticationApi)
  private
    FService: IBackendPushService;
    FServiceAPI: IBackendPushAPI;
    function GetServiceAPI: IBackendPushApi;
  protected
    function GetAuthenticationApi: IBackendAuthenticationApi; override;
  public
    constructor Create(const AService: IBackendPushService); overload;
    constructor Create(const AServiceAPI: IBackendPushAPI); overload;
    procedure PushBroadcast(const AData: TPushData); overload;
    /// <summary>Send a notification to a target</summary>
    procedure PushToTarget(const AData: TPushData; const ATarget: TJSONObject); overload;
    procedure PushToTarget(const AData: TJSONObject; const ATarget: TJSONObject); overload;
    /// <summary>Create a TJSONObject that represents TPushData</summary>
    function PushDataAsJSON(const AData: TPushData): TJSONObject;
    property ProviderAPI: IBackendPushApi read GetServiceAPI;
  end;

  TPushData = class
  public type
    TChangeMethod = TProc;

    TDataGroup = class(TPersistent)
    private
      FOnChange: TChangeMethod;
    protected
      procedure DoChange;
    public
      procedure Load(const AJSONObject: TJSONObject; const ARoot: string); virtual; abstract;
      procedure Save(const AJSONObject: TJSONObject; const ARoot: string); virtual; abstract;
      property OnChange: TChangeMethod read FOnChange write FOnChange;
    end;

    TAPS = class(TDataGroup)
    public type
      TNames = record
      public
        const ApsRoot = 'aps';
        const Alert = 'alert';
        const Badge = 'badge';
        const Sound = 'sound';
      end;
    private
      FAlert: string;
      FBadge: string;
      FSound: string;
      procedure SetAlert(const Value: string);
      procedure SetBadge(const Value: string);
      procedure SetSound(const Value: string);
    protected
      procedure AssignTo(APersistent: TPersistent); override;
    public
      procedure Load(const AJSONObject: TJSONObject; const ARoot: string); override;
      procedure Save(const AJSONObject: TJSONObject; const ARoot: string); override;
    published
      property Alert: string read FAlert write SetAlert;
      property Badge: string read FBadge write SetBadge;
      property Sound: string read FSound write SetSound;
    end;

    TGCM = class(TDataGroup)
    private
      FAction: string;
      FTitle: string;
      FMessage: string;
      FMsg: string;
    public type
      TNames = record
      public
        const Action = 'action';
        const Msg = 'msg';
        const Message = 'message';
        const Title = 'title';
      end;
    private
      procedure SetAction(const Value: string);
      procedure SetTitle(const Value: string);
      procedure SetMessage(const Value: string);
      procedure SetMsg(const Value: string);
    protected
      procedure AssignTo(APersistent: TPersistent); override;
    public
      procedure Load(const AJSONObject: TJSONObject; const ARoot: string); override;
      procedure Save(const AJSONObject: TJSONObject; const ARoot: string); override;
    published
      property Action: string read FAction write SetAction;
      property Title: string read FTitle write SetTitle;
      property Message: string read FMessage write SetMessage;
      property Msg: string read FMsg write SetMsg;
    end;

    TExtras = class(TDataGroup)
    public type
      TExtrasPair = TPair<string, string>;
      TExtrasList = TList<TExtrasPair>;
      private
        function GetCount: Integer;
        function GetItem(I: Integer): TExtrasPair;
    protected
      FList: TExtrasList;
      procedure AssignTo(APersistent: TPersistent); override;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const AName, AValue: string);
      function IndexOf(const AName: string): Integer;
      procedure Clear;
      procedure Remove(const AName: string);
      procedure Delete(AIndex: Integer);
      function GetEnumerator: TEnumerator<TExtrasPair>;
      procedure Load(const AJSONObject: TJSONObject; const ARoot: string); override;
      procedure Save(const AJSONObject: TJSONObject; const ARoot: string); override;
      property Count: Integer read GetCount;
      property Items[I: Integer]: TExtrasPair read GetItem; default;
    published
    end;

  private
    class function GetString(const AJSON: TJSONObject; const ARoot, AName: string): string; overload; static;
    class procedure SetString(const AJSON: TJSONObject; const ARoot, AName: string; const AValue: string); overload; static;
    class procedure SetValue(const AJSON: TJSONObject; const ARoot, AName: string; const AValue: TJSONValue); overload; static;
    class procedure SetString(const AJSON: TJSONObject; const AName: string; const AValue: string); overload; static;
  private
    FAPS: TAPS;
    FGCM: TGCM;
    FExtras: TExtras;
    FOnChange: TChangeMethod;
    FMessage: string;
    procedure SetMessage(const Value: string);
    procedure SetAPS(const Value: TAPS);
    procedure SetGCM(const Value: TGCM);
    procedure DoChange;
    procedure SetExtras(const Value: TExtras);
  public
    constructor Create; overload;
    destructor Destroy; override;
    procedure Load(const AJSON: TJSONObject);
    procedure SaveMessage(const AJSON: TJSONObject; const AName: string);
    property Message: string read FMessage write SetMessage;
    property APS: TAPS read FAPS write SetAPS;
    property GCM: TGCM read FGCM write SetGCM;
    property Extras: TExtras read FExtras write SetExtras;
    property OnChange: TChangeMethod read FOnChange write FOnChange;
  end;

implementation
{$IFDEF LOGGING}
uses FMX.Types;
{$ENDIF}

{ TPushNotification }

constructor TPushData.Create;
begin
  FAPS := TAPS.Create;
  FAPS.OnChange :=
    procedure
    begin
      DoChange;
    end;
  FGCM := TGCM.Create;
  FGCM.OnChange :=
    procedure
    begin
      DoChange;
    end;
  FExtras := TExtras.Create;
  FExtras.OnChange :=
    procedure
    begin
      DoChange;
    end;
end;

destructor TPushData.Destroy;
begin
  FAPS.Free;
  FGCM.Free;
  FExtras.Free;
  inherited;
end;

procedure TPushData.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange;
end;

procedure TPushData.SaveMessage(const AJSON: TJSONObject; const AName: string);
begin
  TPushData.SetString(AJSON, AName, FMessage);
end;

procedure TPushData.SetAPS(const Value: TAPS);
begin
  FAPS.Assign(Value);
end;

procedure TPushData.SetExtras(const Value: TExtras);
begin
  FExtras.Assign(Value);
end;

procedure TPushData.SetGCM(const Value: TGCM);
begin
  FGCM.Assign(Value);
end;

procedure TPushData.SetMessage(const Value: string);
begin
  if Value <> Message then
  begin
    FMessage := Value;
    DoChange;
  end;
end;

                                       
procedure GetRoot(const AFullName: string; out ARoot, AName: string);
var
  I: Integer;
begin
  I := AFullName.IndexOf('.');
  if I >= 0 then
  begin
    ARoot := AFullName.Substring(0, I);
    AName := AFullName.Substring(I+1);
                                             
    Assert(AName.IndexOf('.') < 0, AName);
  end
  else
  begin
    ARoot := '';
    AName := AFullName;
  end;
end;

class function TPushData.GetString(const AJSON: TJSONObject; const ARoot, AName: string): string;
var
  LJSONValue: TJSONValue;
  LJSONObject: TJSONObject;
begin
  if ARoot <> '' then
    LJSONObject := AJSON.GetValue(ARoot) as TJSONObject
  else
    LJSONObject := AJSON;
  if LJSONObject <> nil then
  begin
    LJSONValue := LJSONObject.GetValue(AName);
    if LJSONValue <> nil then
      Result := LJSONValue.Value
    else
      Result := '';
  end;
end;

procedure TPushData.Load(const AJSON: TJSONObject);
const
  sAps = 'aps';
  sGcm = 'gcm';
  sMsg = 'msg';
  sData = 'data';
  sAlert = 'alert';
var
  LJSONValue: TJSONValue;
  LJSONObject: TJSONObject;
  LJSONGCM: TJSONObject;
  LJSONAPS: TJSONObject;
  LTemp: TJSONValue;
  S: string;
  LGCMName: string;
begin
  LTemp := nil;
  LJSONObject := AJSON.Clone as TJSONObject;
  try
    LJSONValue := LJSONObject.GetValue(sAps);
    if LJSONValue is TJSONObject then
      LJSONAPS := TJSONObject(LJSONValue)
    else
      LJSONAPS := LJSONObject;
    FAPS.Load(LJSONAPS, '');
    // Clear values
    with TPushData.TAPS.Create do
    try
      Save(LJSONAPS, '');
    finally
      Free;
    end;

    LGCMName := sGCM;
    LJSONValue := LJSONObject.GetValue(LGCMName);
    if LJSONValue = nil then
    begin
      // Kinvey puts android payload here
      LGCMName := sMsg;
      LJSONValue := LJSONObject.GetValue(LGCMName);
    end;
    if LJSONValue = nil then
    begin
      // Parse puts android payload here
      LGCMName := sData;
      LJSONValue := LJSONObject.GetValue(LGCMName);
    end;
    LJSONGCM := LJSONObject;
    if LJSONValue is TJSONObject then
      LJSONGCM := TJSONObject(LJSONValue)
    else if LJSONValue is TJSONString then
    begin
      S := TJSONString(LJSONValue).Value;
      if (S.Length > 0) and (S.Chars[0] = '{') then
        try
          LTemp := TJSONObject.ParseJSONValue(S);    // Freed later
          if LTemp is TJSONObject then
            LJSONGCM := TJSONObject(LTemp);
          if LGCMName <> '' then
            TPushData.SetString(LJSONObject, '', LGCMName, '');  // Clear
        except

        end;
    end;
    FGCM.Load(LJSONGCM, '');
    // Clear values
    with TPushData.TGCM.Create do
    try
      Save(LJSONGCM, '');
    finally
      Free;
    end;

    // Load remaining elements in GCM into extras
    FExtras.Load(LJSONGCM, '');
    if LJSONGCM <> LJSONObject then
      // Load remaining elements into extras
      FExtras.Load(LJSONObject, '');
    if FAPS.Alert <> '' then
      FMessage := FAPS.Alert
    else if FGCM.Message <> '' then
      FMessage := FGCM.Message
    else if FGCM.Msg <> '' then
      FMessage := FGCM.Msg
    else if LJSONGCM.TryGetValue<string>(sAlert, S) then
      FMessage := S; // Parse puts GCM message here
  finally
    LTemp.Free;
    LJSONObject.Free;
  end;
end;

class procedure TPushData.SetString(const AJSON: TJSONObject; const ARoot, AName: string;
  const AValue: string);
var
  LJSONObject: TJSONObject;
  LPair: TJSONPair;
begin
  if ARoot <> '' then
  begin
    LJSONObject := AJSON.GetValue(ARoot) as TJSONObject;
    if LJSONObject = nil then
      if AValue <> '' then
      begin
        LJSONObject := TJSONObject.Create;
        AJSON.AddPair(ARoot, LJSONObject);
      end;
  end
  else
    LJSONObject := AJSON;
  if LJSONObject <> nil then
  begin
    if AValue = '' then
    begin
      LPair :=  LJSONObject.RemovePair(AName);
      LPair.Free;
    end
    else
    begin
      if LJSONObject.GetValue(AName) <> nil then
      begin
        LPair :=  LJSONObject.RemovePair(AName);
        LPair.Free;
      end;
      LJSONObject.AddPair(AName, AValue);
    end;
  end;
end;

class procedure TPushData.SetString(const AJSON: TJSONObject; const AName: string;
  const AValue: string);
begin
  SetString(AJSON, '', AName, AValue);
end;

class procedure TPushData.SetValue(const AJSON: TJSONObject; const ARoot,
  AName: string; const AValue: TJSONValue);
var
  LJSONObject: TJSONObject;
begin
  if ARoot <> '' then
  begin
    LJSONObject := AJSON.GetValue(ARoot) as TJSONObject;
    if LJSONObject = nil then
      if AValue <> nil then
      begin
        LJSONObject := TJSONObject.Create;
        AJSON.AddPair(ARoot, LJSONObject);
      end;
  end
  else
    LJSONObject := AJSON;
  if LJSONObject <> nil then
  begin
    if AValue = nil then
      LJSONObject.RemovePair(AName)
    else
    begin
      if LJSONObject.GetValue(AName) <> nil then
        LJSONObject.RemovePair(AName);
      LJSONObject.AddPair(AName, AValue);
    end;
  end;
end;

{ TBackendPushDeviceApi }

constructor TBackendPushDeviceApi.Create(const AApi: IBackendPushDeviceApi);
begin
  FServiceApi := AApi;
end;

constructor TBackendPushDeviceApi.Create(
  const AService: IBackendPushDeviceService);
begin
  FService := AService;
end;

function TBackendPushDeviceApi.GetServiceAPI: IBackendPushDeviceApi;
begin
  if FServiceApi <> nil then
    Result := FServiceAPI
  else
    Result := FService.GetPushDeviceApi
end;

function TBackendPushDeviceApi.GetAuthenticationApi: IBackendAuthenticationApi;
begin
  Result := GetServiceApi as IBackendAuthenticationApi;
end;

function TBackendPushDeviceApi.GetPushService: TPushService;
begin
  Result := GetServiceApi.GetPushService;
end;

function TBackendPushDeviceApi.HasPushService: Boolean;
begin
  Result := GetServiceApi.HasPushService;
end;

procedure TBackendPushDeviceApi.RegisterDevice(
  AOnRegistered: TDeviceRegisteredAtProviderEvent);
begin
  GetServiceApi.RegisterDevice(AOnRegistered);
end;

procedure TBackendPushDeviceApi.RegisterDevice(
  const AProperties: TJSONObject; AOnRegistered: TDeviceRegisteredAtProviderEvent);
var
  LIntf: IBackendPushDeviceApi2;
begin
  if (AProperties <> nil) and Supports(GetServiceApi, IBackendPushDeviceApi2, LIntf) then
    LIntf.RegisterDevice(AProperties, AOnRegistered)
  else
    // Provider does not support AProperties
    GetServiceApi.RegisterDevice(AOnRegistered)
end;

function TBackendPushDeviceApi.TryGetInstallationValue(
  out AValue: TBackendEntityValue): Boolean;
var
  LIntf: IBackendPushDeviceApi2;
begin
  if Supports(GetServiceApi, IBackendPushDeviceApi2, LIntf) then
    Result := LIntf.TryGetInstallationValue(AValue)
  else
    Result := False;
end;

procedure TBackendPushDeviceApi.UnregisterDevice;
begin
  GetServiceApi.UnregisterDevice;
end;

{ TBackendPushApi }

constructor TBackendPushApi.Create(const AService: IBackendPushService);
begin
  FService := AService;
end;


constructor TBackendPushApi.Create(const AServiceAPI: IBackendPushAPI);
begin
  FServiceAPI := AServiceAPI;
end;

function TBackendPushApi.GetAuthenticationApi: IBackendAuthenticationApi;
begin
  Result := GetServiceApi as IBackendAuthenticationApi;
end;

function TBackendPushApi.GetServiceAPI: IBackendPushApi;
begin
  if FServiceApi <> nil then
    Result := FServiceAPI
  else
    Result := FService.GetPushApi
end;

procedure TBackendPushApi.PushBroadcast(
  const AData: TPushData);
begin
  GetServiceApi.PushBroadcast(AData);
end;

function TBackendPushApi.PushDataAsJSON(const AData: TPushData): TJSONObject;
var
  LIntf: IBackendPushApi2;
begin
  if Supports(GetServiceApi, IBackendPushApi2, LIntf) then
    Result := LIntf.PushDataAsJSON(AData)
  else
    raise ENotSupportedException.Create('Provider does not support this operation');
end;

procedure TBackendPushApi.PushToTarget(const AData: TPushData;
  const ATarget: TJSONObject);
var
  LIntf: IBackendPushApi3;
begin
  if Supports(GetServiceApi, IBackendPushApi3, LIntf) then
    LIntf.PushToTarget(AData, ATarget)
  else if ATarget = nil then
    GetServiceApi.PushBroadcast(AData)
  else
    raise ENotSupportedException.Create('Provider does not support this operation');
end;

procedure TBackendPushApi.PushToTarget(const AData, ATarget: TJSONObject);
var
  LIntf: IBackendPushApi3;
begin
  if Supports(GetServiceApi, IBackendPushApi3, LIntf) then
    LIntf.PushToTarget(AData, ATarget)
  else
    raise ENotSupportedException.Create('Provider does not support this operation');
end;

{ TPushData.TDataGroup }

procedure TPushData.TDataGroup.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange;
end;


{ TPushData.TAPS }

procedure TPushData.TAPS.AssignTo(APersistent: TPersistent);
begin
  if APersistent is TAPS then
  begin
    TAPS(APersistent).Alert := Alert;
    TAPS(APersistent).Badge := Badge;
    TAPS(APersistent).Sound := Sound;
  end
  else
    inherited;
end;

procedure TPushData.TAPS.Load(const AJSONObject: TJSONObject; const ARoot: string);
begin
  Alert :=  TPushData.GetString(AJSONObject, ARoot, TNames.Alert);
  Badge :=  TPushData.GetString(AJSONObject, ARoot, TNames.Badge);
  Sound :=  TPushData.GetString(AJSONObject, ARoot, TNames.Sound);
end;

procedure TPushData.TAPS.Save(const AJSONObject: TJSONObject; const ARoot: string);
var
  LBadge: Integer;
begin
  TPushData.SetString(AJSONObject, ARoot, TNames.Alert, Alert);
  if TryStrToInt(Badge, LBadge) then
    TPushData.SetValue(AJSONObject, ARoot, TNames.Badge, TJSONNumber.Create(LBadge))
  else
    // Badge may not be a number.  For, example "Increment" may be used with Parse
    TPushData.SetString(AJSONObject, ARoot, TNames.Badge, Badge);
  TPushData.SetString(AJSONObject, ARoot, TNames.Sound, Sound);
end;

procedure TPushData.TAPS.SetAlert(const Value: string);
begin
  if Value <> Alert then
  begin
    FAlert := Value;
    DoChange;
  end;
end;

procedure TPushData.TAPS.SetBadge(const Value: string);
begin
  if Value <> Badge then
  begin
    FBadge := Value;
    DoChange;
  end;
end;

procedure TPushData.TAPS.SetSound(const Value: string);
begin
  if Value <> Sound then
  begin
    FSound := Value;
    DoChange;
  end;
end;

{ TPushData.TGCM }

procedure TPushData.TGCM.AssignTo(APersistent: TPersistent);
begin
  if APersistent is TGCM then
  begin
    TGCM(APersistent).Action := Action;
    TGCM(APersistent).Title := Title;
    TGCM(APersistent).Msg := Msg;
    TGCM(APersistent).Message := Message;
  end
  else
    inherited;
end;

procedure TPushData.TGCM.Load(const AJSONObject: TJSONObject; const ARoot: string);
begin
  Action :=  TPushData.GetString(AJSONObject, ARoot, TNames.Action);
  Message :=  TPushData.GetString(AJSONObject, ARoot, TNames.Message);
  Msg :=  TPushData.GetString(AJSONObject, ARoot, TNames.Msg);
  Title :=  TPushData.GetString(AJSONObject, ARoot, TNames.Title);
end;

procedure TPushData.TGCM.Save(const AJSONObject: TJSONObject; const ARoot: string);
begin
  TPushData.SetString(AJSONObject, ARoot, TNames.Action, Action);
  TPushData.SetString(AJSONObject, ARoot, TNames.Message, Message);
  TPushData.SetString(AJSONObject, ARoot, TNames.Msg, Msg);
  TPushData.SetString(AJSONObject, ARoot, TNames.Title, Title);
end;

procedure TPushData.TGCM.SetAction(const Value: string);
begin
  if Value <> Action then
  begin
    FAction := Value;
    DoChange;
  end;
end;

procedure TPushData.TGCM.SetMessage(const Value: string);
begin
  if Value <> Message then
  begin
    FMessage := Value;
    DoChange;
  end;
end;

procedure TPushData.TGCM.SetMsg(const Value: string);
begin
  if Value <> Msg then
  begin
    FMsg := Value;
    DoChange;
  end;
end;

procedure TPushData.TGCM.SetTitle(const Value: string);
begin
  if Value <> Title then
  begin
    FTitle := Value;
    DoChange;
  end;
end;

{ TPushData.TExtras }

procedure TPushData.TExtras.Add(const AName, AValue: string);
begin
  FList.Add(TExtrasPair.Create(AName, AValue))
end;

procedure TPushData.TExtras.AssignTo(APersistent: TPersistent);
begin
  if APersistent is TExtras then
  begin
    TExtras(APersistent).Clear;
    TExtras(APersistent).FList.AddRange(FList.ToArray);
  end
  else
    inherited;
end;

procedure TPushData.TExtras.Clear;
begin
  FList.Clear;
end;

constructor TPushData.TExtras.Create;
begin
  FList := TExtrasList.Create;
end;

procedure TPushData.TExtras.Delete(AIndex: Integer);
begin
  FList.Delete(AIndex);
end;

destructor TPushData.TExtras.Destroy;
begin
  inherited;
  FList.Free;
end;

function TPushData.TExtras.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TPushData.TExtras.GetEnumerator: TEnumerator<TExtrasPair>;
begin
  Result := FList.GetEnumerator;
end;

function TPushData.TExtras.GetItem(I: Integer): TExtrasPair;
begin
  Result := FList[I];
end;

function TPushData.TExtras.IndexOf(const AName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Items[I].Key = AName then
    begin
      Result := I;
      break;
    end;
end;

procedure TPushData.TExtras.Load(const AJSONObject: TJSONObject;
  const ARoot: string);
var
  LJSONObject: TJSONObject;
  LJSONPair: TJSONPair;
  LValue: TJSONValue;
begin
  if ARoot = '' then
    LJSONObject := AJSONObject
  else
    LJSONObject := AJSONObject.GetValue(ARoot) as TJSONObject;
  if LJSONObject <> nil then
    for LJSONPair in LJSONObject do
    begin
      LValue := LJSONPair.JsonValue;
      if (not (LValue is TJSONObject)) and (not (LValue is TJSONArray)) then
        Add(LJSONPair.JsonString.Value, TJSONString(LValue).Value)
    end;
end;

procedure TPushData.TExtras.Remove(const AName: string);
var
  I: Integer;
begin
  I := IndexOf(AName);
  if I >= 0 then
    Delete(I);
end;

procedure TPushData.TExtras.Save(const AJSONObject: TJSONObject;
  const ARoot: string);
var
  LPair: TExtrasPair;
begin
  for LPair in FList do
    if LPair.Key <> '' then
      TPushData.SetString(AJSONObject, ARoot, LPair.Key, LPair.Value);
end;

end.


