{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Tether.AppProfile;

interface
{$SCOPEDENUMS ON}
{$METHODINFO ON}

uses
  System.SysUtils, System.Generics.Collections, System.Actions, System.Classes, System.Json, System.Tether.Manager;

type
  TTetheringAppProfile = class;

  TTetheringRemoteItemType = (Action, Resource);
  TTetheringRemoteKind = (Shared, Mirror);

  TResourceType = (Integer, Single, Double, Int64, Boolean, &String);
  TRemoteResourceType = (Data, Stream);


  TCustomRemoteItem = class
  private
    FName: string;
    FHint: string;
    FProfile: TTetheringAppProfile;
    FRemoteProfileId: string;
    FNotifyUpdates: Boolean;
    FItemType: TTetheringRemoteItemType;
    FIsPublic: Boolean;
    FIsTemp: Boolean;
    FKind: TTetheringRemoteKind;
    procedure SetProfile(const Value: TTetheringAppProfile);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Broadcast; virtual;

    property Hint: string read FHint write FHint;
    property Profile: TTetheringAppProfile read FProfile write SetProfile;
    property ItemType: TTetheringRemoteItemType read FItemType write FItemType;
    property Name: string read FName write FName;
    property NotifyUpdates: Boolean read FNotifyUpdates write FNotifyUpdates;
    property IsPublic: Boolean read FIsPublic write FIsPublic;
    property IsTemp: Boolean read FIsTemp write FIsTemp;
    property Kind: TTetheringRemoteKind read FKind write FKind default TTetheringRemoteKind.Shared;
  end;

  TCustomLocalItem = class(TCollectionItem)
  private
    FName: string;
    FHint: string;
    FProfile: TTetheringAppProfile;
    FNotifyUpdates: Boolean;
    FIsPublic: Boolean;
    FKind: TTetheringRemoteKind;
    procedure SetProfile(const Value: TTetheringAppProfile);
    procedure SetName(const Value: string);
    procedure SetIsPublic(const Value: Boolean);
    procedure SetKind(const Value: TTetheringRemoteKind);
  protected
    function GetDisplayName: string; override;
    /// <summary>Converts the custom local item into JSON and puts this JSON into the TBytes</summary>
    function ToBytes: TBytes;
    /// <summary>Copies the TCutomLocalItem information that is going to be broadcasted into a JSON object.
    /// Must be implemented by descendants.</summary>
    function MarshalToJSON: TJSONObject; virtual; abstract;
    function ToJsonString: string; virtual;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(ACollection: TCollection); override;
    procedure Broadcast; virtual;

    property Hint: string read FHint write FHint;
    property Profile: TTetheringAppProfile read FProfile write SetProfile;

    property NotifyUpdates: Boolean read FNotifyUpdates write FNotifyUpdates;

  published
    property Name: string read FName write SetName;
    property IsPublic: Boolean read FIsPublic write SetIsPublic;
    property Kind: TTetheringRemoteKind read FKind write SetKind default TTetheringRemoteKind.Shared;
  end;

  TLocalAction = class(TCustomLocalItem)
  private
    FOldUpdate: TNotifyEvent;
    FOldExecute: TNotifyEvent;
    FAction: TContainedAction;
    FActionEnabled: Boolean;
    FActionCaption: string;
    procedure SetAction(const Value: TContainedAction);
    procedure UpdateActionStatus(Sender: TObject);
  protected
    function GetDisplayName: string; override;
    procedure DoExecute(Sender: TObject);
    function MarshalToJSON: TJSONObject; override;
  public
    procedure Assign(Source: TPersistent); override;

    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Action: TContainedAction read FAction write SetAction;
    property NotifyUpdates;
  end;

  TSimpleValue = record
    case Integer of
      0: (FInteger: Integer);
      1: (FSingle: Single);
      2: (FDouble: Double);
      3: (FInt64: Int64);
      4: (FBoolean: Boolean);
  end;

  TResourceValue = record
  private
    FDataType: TResourceType;
    FString: string;
    FStream: TStream;
    FSimpleValue: TSimpleValue;
    procedure AddToJsonObject(const AJSonObject: TJSONObject);
  private
    function GetBoolean: Boolean;
    function GetDouble: Double;
    function GetSingle: Single;
    function GetInt64: Int64;
    function GetInteger: Integer;
  public
    /// <summary>Constructors from different types of data</summary>
    /// <remarks>Needed by C++ to allow Properties that return a TResourceValue, to be used in the left side
    /// of an assignment.</remarks>
    constructor Create(Value: Boolean); overload;
    constructor Create(Value: Int64); overload;
    constructor Create(Value: Integer); overload;
    constructor Create(Value: Double); overload;
    constructor Create(Value: Single); overload;
    constructor Create(const Value: string); overload;
    constructor Create(const Value: TStream); overload;

    /// <summary>Implicit assignement operators from different types of data</summary>
    class operator Implicit(Value: Boolean): TResourceValue;
    class operator Implicit(Value: Int64): TResourceValue;
    class operator Implicit(Value: Integer): TResourceValue;
    class operator Implicit(Value: Double): TResourceValue;
    class operator Implicit(Value: Single): TResourceValue;
    class operator Implicit(const Value: string): TResourceValue;
    class operator Implicit(const Value: TStream): TResourceValue;
    property DataType: TResourceType read FDataType write FDataType;
    property AsString: string read FString;
    property AsInteger: Integer read GetInteger;
    property AsDouble: Double read GetDouble;
    property AsInt64: Int64 read GetInt64;
    property AsSingle: Single read GetSingle;
    property AsBoolean: Boolean read GetBoolean;
    property AsStream: TStream read FStream;
  end;

  TRemoteResource = class;
  TRemoteAction = class;
  TResourceUpdatedEvent = procedure(const Sender: TObject; const AResource: TRemoteResource) of object;
  TActionUpdatedEvent = procedure(const Sender: TObject; const AResource: TRemoteAction) of object;
  TAcceptResourceEvent = procedure(const Sender: TObject; const AProfileId: string; const AResource: TCustomRemoteItem;
    var AcceptResource: Boolean) of object;
  TRemoteProfileUpdateEvent = procedure(const Sender: TObject; const AProfileId: string) of object;

  TLocalResource = class(TCustomLocalItem)
  private
    FResType: TRemoteResourceType;
    FResValue: TResourceValue;
    FOnResourceReceived: TResourceUpdatedEvent;
    procedure SetValue(const Value: TResourceValue);
    procedure SetResType(const Value: TRemoteResourceType);
  protected
    function GetDisplayName: string; override;
    function MarshalToJSON: TJSONObject; override;
    procedure DoResourceReceived(const AResource: TRemoteResource); virtual;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property ResType: TRemoteResourceType read FResType write SetResType default TRemoteResourceType.Data;
    property OnResourceReceived: TResourceUpdatedEvent read FOnResourceReceived write FOnResourceReceived;
    property Value: TResourceValue read FResValue write SetValue;
  end;

  TRemoteAction = class(TCustomRemoteItem)
  private
    FEnabled: Boolean;
    FCaption: string;
    FOnUpdate: TNotifyEvent;
  public
    constructor Create;
    procedure Execute;

    /// <summary>Property to manager Caption text of the Remote Action</summary>
    property Caption: string read FCaption write FCaption;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
    property OnUpdate: TNotifyEvent read FOnUpdate write FOnUpdate;
  end;

  TRemoteResource = class(TCustomRemoteItem)
  private
    FResType: TRemoteResourceType;
    FValue: TResourceValue;
    function MarshalToJSON: TJSONObject;
    procedure SetValue(const Value: TResourceValue);
  public
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    function ToBytes: TBytes;
    procedure UpdateValue(ADataType: TResourceType; const AJSONValue: TJSONValue);
    property ResType: TRemoteResourceType read FResType write FResType;
    property Value: TResourceValue read FValue write SetValue;
  end;

  TResourceCollection = class(TOwnedCollection)
  protected
    { Protected declarations }
    function GetItem(Index: Integer): TLocalResource;
    procedure SetItem(Index: Integer; Value: TLocalResource);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ItemClass: TCollectionItemClass);
    function Add: TLocalResource;
    function Insert(Index: Integer): TLocalResource;
    function FindByName(const AResName: string): TLocalResource;
    property Items[Index: Integer]: TLocalResource read GetItem write SetItem;
  end;

  TActionCollection = class(TOwnedCollection)
  protected
    { Protected declarations }
    function GetItem(Index: Integer): TLocalAction;
    procedure SetItem(Index: Integer; Value: TLocalAction);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ItemClass: TCollectionItemClass);
    function Add: TLocalAction;
    function Insert(Index: Integer): TLocalAction;
    function FindByName(const AnActionName: string): TLocalAction;
    property Items[Index: Integer]: TLocalAction read GetItem write SetItem;
  end;


  TConnectedProfilePair = TPair<string, string>;
  TSubscribedResPair = TPair<TTetheringProfileInfo, TCustomRemoteItem>;

  /// <summary> Type to identify an asynchronously Remote Action. </summary>
  TRemoteActionHandle = THandle;
  /// <summary> Different states of an asynchronously Remote Action. </summary>
  TRemoteActionState = (Running, NotRunning, NotFound);
  /// <summary> Different states of an asynchronously Remote Action. </summary>
  TASyncRemoteActionEvent = procedure(const Sender: TObject; const ARemoteProfileId, ARemoteActionName: string;
    ARemoteActionHandle: TRemoteActionHandle; Success: Boolean) of object;

  TTetheringAppProfile = class(TTetheringProfile)
  public const
    AppProfileID = 'APPLICATION';
  private
    type
      TTetheringAppCommand = (Connect, Run, GetActions, GetResources, GetResourceValue, SubscribeResource,
        UnSubscribeResource, SendStream, Unknown, SendString, ReverseConnect, RunAsync, GetRemoteActionState,
        DisconnectProfile);
      TRunningActionsPair = TPair<TRemoteActionHandle, string>;
    const  // do not localize these consts.
      CommandSep = '$';
      TokenSep = '#';
      InnerSep = '*';
      CommandsLength = 11;
      ConnectCommand = 'CON_PROFIL';
      ReverseConnectCommand = 'REV_PROFIL';
      ConnectCommandOKResponse = 'RES_OKCON';
      ConnectCommandErrorResponse = 'RES_ERCON';
      RunActionCommand = 'RUN_ACTION';
      RunActionAsyncCommand  = 'RUN_ASNACT';
      RunActionResponseErrorCommand = 'RES_RUNERR';
      RunActionResponseOKCommand = 'RES_RUNOKI';
      GetRemoteActionAsyncStateCommand = 'GET_ACTASY';
      GetActionsCommand = 'GET_ACTION';
      GetActionsCommandResponse = 'RES_GETACT';
      GetResourcesCommand = 'GET_RESRCS';
      GetResourcesCommandResponse = 'RES_GETRES';
      GetResourceValueCommand = 'GET_RESVAL';
      GetResourceValueCommandResponse = 'RES_GETVAL';
      GetRemoteActionAsyncStateCommandResponse = 'RES_ACTASY';
      GetStreamResourceValueCommandResponse = 'RES_GETVST';
      SubscribeResourceCommand = 'SUB_RESOUR';
      SubscribeResourceResponseCommand = 'RES_SUBSCR';
      UnsubscribeResourceCommand = 'UNS_RESOUR';
      UnsubscribeResourceResponseCommand = 'RES_UNSUBS';
      NotifyResourceUpdateCommand = 'NOT_UPDRES';
      NotifySendResourceCommand = 'NOT_SNDRES';
      NotifyRemoteActionEndCommand = 'NOT_ACTEND';
      ResponseCommandAlive      = 'RES_ALIVE';
      ResponseBadCommand = 'RES_BADCOM';
      ResponseUnknownResourceCommand = 'RES_UNKNOWN';
      DisconnectProfileCommand = 'DIS_PROFIL';

      SendStreamCommand = 'SND_STREAM';
      SendStreamOkResponse = 'SND_STROK';
      SendStreamContentCommand = 'SND_STRCNT';
      SendStreamContentOKResponse = 'RES_STRCNT';
      SendStreamContentErrorResponse = 'RES_ERRSCN';

      SendStringCommand = 'SND_STRING';
      SendStringOkResponse = 'SND_STRGOK';
      SendStringContentOKResponse = 'RES_STRGCNT';
      SendStringContentErrorResponse = 'RES_ERRSTCN';

      NotifyProfileUpdateCommand = 'NOT_UPDPRO';

  private
    // Actions and resources from server point of view (we share them)
    FSharedActions: TActionCollection;
    FSharedResources: TResourceCollection;

    // Actions and resources from client point of view (we connect to them)
    FRemoteItems: TObjectDictionary<TTetheringProfileInfo, TObjectList<TCustomRemoteItem>>;
    FSubscribedProfiles: TObjectDictionary<TCustomLocalItem, TStringList>;

    FSubscribedRemoteProfiles: TList<TSubscribedResPair>;
    FConnectedManagerProfileIds: TList<TConnectedProfilePair>;
    FOnResourceUpdated: TResourceUpdatedEvent;
    FOnActionUpdated: TActionUpdatedEvent;
    FOnAcceptResource: TAcceptResourceEvent;
    FOnResourceReceived: TResourceUpdatedEvent;
    FOnRemoteProfileUpdate: TRemoteProfileUpdateEvent;
    FNotifyProfileUpdates: Boolean;
    FOnASyncRemoteActionEnd: TASyncRemoteActionEvent;
    FRunningActions: TThreadList<TRunningActionsPair>;

    function GetRemoteActions(const AProfile: TTetheringProfileInfo): Boolean;
    procedure GetRemoteResources(const AProfile: TTetheringProfileInfo);
    procedure AutoSubscribeGroup(const AProfile: TTetheringProfileInfo);

    function StringToCommandType(const ACommand: string): TTetheringAppCommand;
    function FindProfileFromRemoteItem(const ARemoteItem: TCustomRemoteItem; var Profile: TTetheringProfileInfo): Boolean;
    function FindResourceByName(const AResName: string; const ResList: TResourceCollection): TLocalResource; overload;
    function FindActionByName(const AnActionName: string): TLocalAction;
    function FindRemoteItemByName(const AItemName: string; const ResList: TList<TCustomRemoteItem>): TCustomRemoteItem;
    function InternalGetRemoteResourceValue(const ARemoteRes: TRemoteResource; const AProfile: TTetheringProfileInfo): TRemoteResource;
    function InternalRunRemoteAction(const AProfile: TTetheringProfileInfo; const AnActionName: string): Boolean;
    function InternalRunRemoteActionAsync(const AProfile: TTetheringProfileInfo; const AnActionName: string): TRemoteActionHandle;
    function InternalGetRemoteActionAsyncState(const AProfile: TTetheringProfileInfo;
      const AnAction: string): TRemoteActionState;
    procedure DeleteRemoteItemsOfType(ARemoteItemType: TTetheringRemoteItemType; const AList: TObjectList<TCustomRemoteItem>);
    procedure UnSubscribeAndDeleteRemoteResources(const AProfile: TTetheringProfileInfo;
      const RemoteItems: TObjectList<TCustomRemoteItem>; var UnsubscribedResources: TStringList);

    function FindProfileManager(AProfileId: string): string;
    function CreateRemoteTempResource(AResourceType: TRemoteResourceType; const Description: string;
      const Data: string = ''; const AStream: TStream = nil): TRemoteResource;
    function GetSharedActions: TActionCollection;
    procedure SetSharedActions(const Value: TActionCollection);
    function GetSharedResources: TResourceCollection;
    procedure SetSharedResources(const Value: TResourceCollection);
    function UpdateActionFromJSON(const ARemoteAction: TRemoteAction; const ResValue: TArray<Byte>; StartPos: Integer): TRemoteAction;
    function UpdateResourceFromJSON(const ARemoteRes: TRemoteResource; const ResValue: TArray<Byte>; StartPos: Integer): TRemoteResource;

  protected
    /// <summary>Process incoming data from another profile, received from a Protocol.</summary>
    procedure DoOnIncomingData(const AProtocol: TTetheringProtocol; const AData: TBytes); override;
    /// <summary> Function that fires OnDisconnect Event to Inform when a profile is disconnecting from us.</summary>
    procedure DoOnDisconnect(const AProfileInfo: TTetheringProfileInfo); override;

    procedure OnStreamReceived(const Sender: TObject; const AProfileId: string; const AStream: TStream; const ADescription: string); override;
    procedure OnStringReceived(const Sender: TObject; const AProfileId: string; const AString: string; const ADescription: string); override;
    function GetProfileType: TTetheringProfileType; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoResourceReceived(AResource: TRemoteResource); virtual;
    procedure DoAcceptResource(const AProfileId: string; AResource: TCustomRemoteItem;var AcceptResource: Boolean); virtual;
    procedure DoRemoteProfileUpdate(const AProfileId: string); virtual;
    procedure DoResourceUpdated(LRemoteRes: TRemoteResource); virtual;
    procedure DisconnectFromManager(const AManagerId: string); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function CreateInstance(const AManager: TTetheringManager): TTetheringProfile; override;
    function RunRemoteAction(const AnAction: TRemoteAction): Boolean; overload;
    function RunRemoteAction(const AProfile: TTetheringProfileInfo; const AnActionName: string): Boolean; overload;

    /// <summary> Execute asynchronously a Remote Action. </summary>
    /// <returns> An asynchronous remote handle</returns>
    /// <remarks> When you use this method a event will be triggered when then remote action finish.
    /// If you want to know the state of the action you can use GetRemoteActionAsyncState</remarks>
    function RunRemoteActionAsync(const AnAction: TRemoteAction): TRemoteActionHandle; overload;
    function RunRemoteActionAsync(const AProfile: TTetheringProfileInfo; const AnActionName: string): TRemoteActionHandle; overload;
    /// <summary> Returns the state of a Remote Action executed asynchronously. </summary>
    function GetRemoteActionAsyncState(const AProfile: TTetheringProfileInfo; ARemoteActionHandle: TRemoteActionHandle): TRemoteActionState; overload;
    function GetRemoteActionAsyncState(const AnAction: TRemoteAction): TRemoteActionState; overload;
    function GetRemoteActionAsyncState(const AProfile: TTetheringProfileInfo; const AnActionName: string): TRemoteActionState; overload;

    /// <summary> Sends the specified string to the specified remote profile and returns True on success or False on failure. </summary>
    function SendString(const AProfile: TTetheringProfileInfo; const Description, AString: string): Boolean;
    function SendStream(const AProfile: TTetheringProfileInfo; const Description: string; const AStream: TStream): Boolean;

    function GetRemoteProfileActions(const AProfile: TTetheringProfileInfo): TList<TRemoteAction>;
    function GetRemoteProfileResources(const AProfile: TTetheringProfileInfo): TList<TRemoteResource>;
    function GetRemoteResourceValue(const ARemoteRes: TRemoteResource): TRemoteResource; overload;
    function GetRemoteResourceValue(const AProfile: TTetheringProfileInfo; const ARemoteResName: string): TRemoteResource; overload;
    function SubscribeToRemoteItem(const AProfile: TTetheringProfileInfo; const ARemoteItem: TCustomRemoteItem): Boolean; overload;
    function SubscribeToRemoteItem(const AProfile: TTetheringProfileInfo; const ARemoteItemName: string): Boolean; overload;
    function UnSubscribeFromRemoteItem(const AProfile: TTetheringProfileInfo; const ARemoteItem: TCustomRemoteItem): Boolean; overload;
    function UnSubscribeFromRemoteItem(const AProfile: TTetheringProfileInfo; const ARemoteItemName: string): Boolean; overload;
    function Connect(const AProfile: TTetheringProfileInfo; const AProtocolType: TTetheringProtocolType = '';
      const AnAdapterType: TTetheringAdapterType = ''): Boolean; override;
    procedure Disconnect(const AProfile: TTetheringProfileInfo); override;
    procedure Notify(const ANotification, Data: string); override;
    procedure NotifyUpdate(ALocalItem: TCustomLocalItem; const Data: string = '');
    procedure RegisterAction(const AnAction: TContainedAction; const AName: string = '');
    function CreateResource(const AName: string; AResType: TRemoteResourceType; AValue: TResourceValue): TLocalResource;
    class function GetAllowedProtocolsAdapters: TTetheringProtocolAdapterTypes; override;
    procedure NotifyProfileUpdate;
    property NotifyProfileUpdates: Boolean read FNotifyProfileUpdates write FNotifyProfileUpdates;
  published
    property Actions: TActionCollection read GetSharedActions write SetSharedActions;
    property Resources: TResourceCollection read GetSharedResources write SetSharedResources;
    property OnAcceptResource: TAcceptResourceEvent read FOnAcceptResource write FOnAcceptResource;
    property OnActionUpdated: TActionUpdatedEvent read FOnActionUpdated write FOnActionUpdated;
    property OnResourceReceived: TResourceUpdatedEvent read FOnResourceReceived write FOnResourceReceived;
    property OnResourceUpdated: TResourceUpdatedEvent read FOnResourceUpdated write FOnResourceUpdated;
    property OnRemoteProfileUpdate: TRemoteProfileUpdateEvent read FOnRemoteProfileUpdate write FOnRemoteProfileUpdate;
    /// <summary> Event received when an asynchronous remote action finish.</summary>
    property OnASyncRemoteActionEnd: TASyncRemoteActionEvent read FOnASyncRemoteActionEnd write FOnASyncRemoteActionEnd;
  end;

const
  AppProfileDataType = 'DataType';
  AppProfileResourceType = 'ResourceType';
  AppProfileValue = 'Value';
  AppProfileActionEnabled = 'ActionEnabled';
  AppProfileActionCaption = 'ActionCaption';
  AppProfileActionHint = 'ActionHint';

  /// <summary> Const to define an invalid Remote Action handle. </summary>
  InvalidRemoteHandle = TRemoteActionHandle(-1);

implementation

uses
{$IFDEF MACOS}
  Macapi.CoreFoundation,
{$ENDIF MACOS}
  System.Generics.Defaults,
  System.NetEncoding,
  System.Types,
  System.Tether.NetworkAdapter,
  System.Tether.BluetoothAdapter,
  System.Tether.Comm,
  System.Tether.TCPProtocol, System.Tether.Consts;

type
  TProfileComparer = class(TInterfacedObject, IEqualityComparer<TTetheringProfileInfo>)
  public
    class function GetInstance: IEqualityComparer<TTetheringProfileInfo>;
    function Equals(const Left, Right: TTetheringProfileInfo): Boolean; reintroduce; overload;
    function GetHashCode(const Value: TTetheringProfileInfo): Integer; reintroduce; overload;
  end;

{ TTetheringAppProfile }

function TTetheringAppProfile.CreateRemoteTempResource(AResourceType: TRemoteResourceType; const Description: string;
  const Data: string = ''; const AStream: TStream = nil): TRemoteResource;
begin
  case AResourceType of
    TRemoteResourceType.Data:
    begin
      Result := TRemoteResource.Create;
      Result.Value := Data;
    end;

    TRemoteResourceType.Stream:
    begin
      Result := TRemoteResource.Create;
      Result.Value := AStream;
    end

    else
      Result := TRemoteResource.Create;
  end;

  Result.Name := TGUID.NewGuid.ToString;
  Result.ResType := AResourceType;
  Result.Hint := Description;
  Result.IsPublic := False;
  Result.IsTemp := True;
end;

function TTetheringAppProfile.SendStream(const AProfile: TTetheringProfileInfo; const Description: string;
  const AStream: TStream): Boolean;
var
  LProfileInfo: TTetheringProfileInfo;
  LConnection: TTetheringConnection;
  LCommand: TTetheringCommand;
begin
  if not FindProfile(AProfile.ProfileIdentifier, LProfileInfo) then
    raise ETetheringException.CreateFmt(SNoProfile, [AProfile.ProfileIdentifier]);
  CheckProfileIsConnected(AProfile);
  LConnection := GetConnectionTo(AProfile);
  TMonitor.Enter(LConnection);
  try
    LCommand := SendCommandWithResponse(LConnection, TTetheringCommand.Create(SendStreamCommand, Version, [Description]));
    if LCommand.Command = SendStreamOkResponse then
    begin
      try
        Result := LConnection.Protocol.SendStream(AStream);
        if Result then
        begin
          LCommand := ReceiveCommand(LConnection);
          if LCommand.Command = SendStreamContentOKResponse then
            Result := True;
        end;
      except
                                   
        DoCommError(AProfile);
        Result := False;
      end;
    end
    else
      Result := False;
  finally
    TMonitor.Exit(LConnection);
  end;
end;

function TTetheringAppProfile.SendString(const AProfile: TTetheringProfileInfo;
  const Description, AString: string): Boolean;
var
  LCommand: TTetheringCommand;
begin
  CheckProfileIsConnected(AProfile);
  LCommand := TTetheringCommand.Create(SendStringCommand, Version, [Description, AString]);
  Result := SendCommandWithResponse(AProfile, LCommand).Command = SendStringContentOKResponse;
end;

procedure TTetheringAppProfile.SetSharedActions(const Value: TActionCollection);
begin
  FSharedActions.Assign(Value);
end;

procedure TTetheringAppProfile.SetSharedResources(const Value: TResourceCollection);
begin
  FSharedResources.Assign(Value);
end;

function TTetheringAppProfile.StringToCommandType(const ACommand: string): TTetheringAppCommand;
begin
  if CompareText(ACommand, RunActionCommand) = 0 then
    Result := TTetheringAppCommand.Run
  else
    if CompareText(ACommand, GetActionsCommand) = 0 then
      Result := TTetheringAppCommand.GetActions
    else
      if CompareText(ACommand, GetResourceValueCommand) = 0 then
        Result := TTetheringAppCommand.GetResourceValue
      else
        if CompareText(ACommand, GetResourcesCommand) = 0 then
          Result := TTetheringAppCommand.GetResources
        else
          if CompareText(ACommand, ConnectCommand) = 0 then
            Result := TTetheringAppCommand.Connect
          else
            if CompareText(ACommand, SubscribeResourceCommand) = 0 then
              Result := TTetheringAppCommand.SubscribeResource
            else
              if CompareText(ACommand, UnSubscribeResourceCommand) = 0 then
                Result := TTetheringAppCommand.UnsubscribeResource
              else
                if CompareText(ACommand, SendStreamCommand) = 0 then
                  Result := TTetheringAppCommand.SendStream
                else
                  if CompareText(ACommand, SendStringCommand) = 0 then
                    Result := TTetheringAppCommand.SendString
                  else
                    if CompareText(ACommand, ReverseConnectCommand) = 0 then
                      Result := TTetheringAppCommand.ReverseConnect
                    else
                      if CompareText(ACommand, RunActionAsyncCommand) = 0 then
                        Result := TTetheringAppCommand.RunAsync
                      else
                        if CompareText(ACommand, GetRemoteActionAsyncStateCommand) = 0 then
                          Result := TTetheringAppCommand.GetRemoteActionState
                        else
                          if CompareText(ACommand, DisconnectProfileCommand) = 0 then
                            Result := TTetheringAppCommand.DisconnectProfile
                          else
                            Result := TTetheringAppCommand.Unknown;
end;

function TTetheringAppProfile.SubscribeToRemoteItem(const AProfile: TTetheringProfileInfo;
  const ARemoteItem: TCustomRemoteItem): Boolean;
var
  LResCommand: TTetheringCommand;
  LNewPair: TSubscribedResPair;
begin
  CheckProfileIsConnected(AProfile);
  Result := False;
  LResCommand := TTetheringCommand.Create(SubscribeResourceCommand, Version,
    [ARemoteItem.Name, Integer(ARemoteItem.ItemType).ToString, Identifier]);
  LResCommand := SendCommandWithResponse(AProfile, LResCommand);
  if LResCommand.Command = SubscribeResourceResponseCommand then
  begin
    LNewPair.Key := AProfile;
    LNewPair.Value := ARemoteItem;
    FSubscribedRemoteProfiles.Add(LNewPair);
    Result := True;
                                                                         
    if (ARemoteItem.FItemType = TTetheringRemoteItemType.Resource) and (ARemoteItem.Kind = TTetheringRemoteKind.Shared) then
      InternalGetRemoteResourceValue(ARemoteItem as TRemoteResource, AProfile); // We update the value
  end;
end;

function TTetheringAppProfile.SubscribeToRemoteItem(const AProfile: TTetheringProfileInfo;
  const ARemoteItemName: string): Boolean;
var
  LRemoteResources: TObjectList<TCustomRemoteItem>;
  LRemoteRes: TCustomRemoteItem;
begin
  if FRemoteItems.TryGetValue(AProfile, LRemoteResources) then
  begin
    LRemoteRes := FindRemoteItemByName(ARemoteItemName, LRemoteResources);
    if LRemoteRes <> nil then
      Result := SubscribeToRemoteItem(AProfile, LRemoteRes)
    else
      Result := False;
  end
  else
    Result := False;
end;

function TTetheringAppProfile.UnSubscribeFromRemoteItem(const AProfile: TTetheringProfileInfo;
  const ARemoteItem: TCustomRemoteItem): Boolean;
var
  LResCommand: TTetheringCommand;
  LSubscribedPair: TSubscribedResPair;
  I: Integer;
begin
  CheckProfileIsConnected(AProfile);
  Result := False;
  LResCommand := TTetheringCommand.Create(UnSubscribeResourceCommand, Version,
    [ARemoteItem.Name, Integer(ARemoteItem.ItemType).ToString, Identifier]);
  LResCommand := SendCommandWithResponse(AProfile, LResCommand);
  if LResCommand.Command = UnSubscribeResourceResponseCommand then
  begin
    for I := 0 to FSubscribedRemoteProfiles.Count - 1 do
    begin
      LSubscribedPair := FSubscribedRemoteProfiles[I];
      if (CompareText(LSubscribedPair.Key.ProfileIdentifier, AProfile.ProfileIdentifier) = 0) and
         (string.Compare(ARemoteItem.Name, LSubscribedPair.Value.Name, [coIgnoreCase]) = 0) then
      begin
        FSubscribedRemoteProfiles.Delete(I);
        Result := True;
        Break;
      end;
    end;
  end;
end;

procedure TTetheringAppProfile.UnSubscribeAndDeleteRemoteResources(const AProfile: TTetheringProfileInfo;
  const RemoteItems: TObjectList<TCustomRemoteItem>; var UnsubscribedResources: TStringList);
var
  I: Integer;
  LResource: TCustomRemoteItem;
begin
  for I := RemoteItems.Count - 1 downto 0 do
  begin
    LResource := RemoteItems[I];
    if LResource.ItemType = TTetheringRemoteItemType.Resource then begin
      if UnSubscribeFromRemoteItem(AProfile, LResource) then
        UnsubscribedResources.Add(LResource.FName);
      RemoteItems.Delete(I);
    end;
  end;
end;

function TTetheringAppProfile.UnSubscribeFromRemoteItem(const AProfile: TTetheringProfileInfo;
  const ARemoteItemName: string): Boolean;
var
  LRemoteResources: TObjectList<TCustomRemoteItem>;
  LRemoteRes: TCustomRemoteItem;
begin
  Result := False;
  if FRemoteItems.TryGetValue(AProfile, LRemoteResources) then
  begin
    LRemoteRes := FindRemoteItemByName(ARemoteItemName, LRemoteResources);
    if LRemoteRes <> nil then
      Result := UnSubscribeFromRemoteItem(AProfile, LRemoteRes);
  end;
end;

procedure TTetheringAppProfile.AutoSubscribeGroup(const AProfile: TTetheringProfileInfo);
var
  LRemoteItems: TObjectList<TCustomRemoteItem>;
  I, J: Integer;
begin
  if (Group <> '') and (string.Compare(Group, AProfile.ProfileGroup, [coIgnoreCase]) = 0) and
    FRemoteItems.TryGetValue(AProfile, LRemoteItems) then
  begin
    for I := 0 to FSharedResources.Count - 1 do
      if FSharedResources.Items[I].FKind = TTetheringRemoteKind.Mirror then
        for J := 0 to LRemoteItems.Count - 1 do
          if (LRemoteItems[J].FItemType = TTetheringRemoteItemType.Resource) and
             (LRemoteItems[J].FKind = TTetheringRemoteKind.Shared) and
             (string.Compare(LRemoteItems[J].FName, FSharedResources.Items[I].FName, [coIgnoreCase]) = 0) then
          begin
            if SubscribeToRemoteItem(AProfile, LRemoteItems[J]) then
              FSharedResources.Items[I].Value := (LRemoteItems[J] as TRemoteResource).Value;
          end;
    for I := 0 to FSharedActions.Count - 1 do
      if FSharedActions.Items[I].FKind = TTetheringRemoteKind.Mirror then
        for J := 0 to LRemoteItems.Count - 1 do
          if (LRemoteItems[J].FItemType = TTetheringRemoteItemType.Action) and
             (LRemoteItems[J].FKind = TTetheringRemoteKind.Shared) and
             (string.Compare(LRemoteItems[J].FName, FSharedActions.Items[I].FName, [coIgnoreCase]) = 0) then
            SubscribeToRemoteItem(AProfile, LRemoteItems[J]);
  end;
end;

function TTetheringAppProfile.Connect(const AProfile: TTetheringProfileInfo; const AProtocolType: TTetheringProtocolType;
  const AnAdapterType: TTetheringAdapterType): Boolean;
var
  LCommand: TTetheringCommand;
  LConnection: TTetheringConnection;
begin
  LConnection := GetConnectionTo(AProfile, AProtocolType, AnAdapterType, False);
  if LConnection.Protocol.IsConnected then
    LConnection.Protocol.Disconnect;
  Result := LConnection.Protocol.Connect(LConnection);
  if Result then
  begin
    TMonitor.Enter(LConnection);
    try
      LCommand := TTetheringCommand.Create(ConnectCommand, Version, [Manager.Identifier, Identifier]);
      LCommand := SendCommandWithResponse(LConnection, LCommand);
    finally
      TMonitor.Exit(LConnection);
    end;
    if (LCommand.Command = ConnectCommandOKResponse) then
    begin
      Result := True;
      AddConnectedProfile(AProfile);
      GetRemoteActions(AProfile);
      GetRemoteResources(AProfile);
      AutoSubscribeGroup(AProfile);
      SendCommand(LConnection, TTetheringCommand.Create(ReverseConnectCommand, Version, [Manager.Identifier, Identifier]));
    end
    else
    begin
      Result := False;
      LConnection.Protocol.Disconnect;
    end;
  end;
end;

procedure TTetheringAppProfile.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited;
  if (AComponent is TContainedAction) and (Operation = opRemove) then
    for I := 0 to FSharedActions.Count - 1 do
      if FSharedActions.Items[I].FAction = AComponent then
        FSharedActions.Items[I].Action := nil;
end;

constructor TTetheringAppProfile.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FVersion := 1;

  FNotifyProfileUpdates := True;

  FRemoteItems := TObjectDictionary<TTetheringProfileInfo, TObjectList<TCustomRemoteItem>>.Create([doOwnsValues], 10, TProfileComparer.GetInstance);
  FConnectedManagerProfileIds := TList<TConnectedProfilePair>.Create;
  FSubscribedProfiles := TObjectDictionary<TCustomLocalItem, TStringList>.Create([doOwnsValues]);
  FSubscribedRemoteProfiles := TList<TSubscribedResPair>.Create;

  FSharedActions := TActionCollection.Create(Self, TLocalAction);
  FSharedResources := TResourceCollection.Create(Self, TLocalResource);

  FRunningActions := TThreadList<TRunningActionsPair>.Create;
end;

class function TTetheringAppProfile.CreateInstance(const AManager: TTetheringManager): TTetheringProfile;
begin
  Result := TTetheringAppProfile.Create(AManager.Owner);
  AManager.RegisterProfile(Result);
  Result.Manager := AManager;
end;

procedure TTetheringAppProfile.DeleteRemoteItemsOfType(ARemoteItemType: TTetheringRemoteItemType;
  const AList: TObjectList<TCustomRemoteItem>);
var
  I: Integer;
  LResource: TCustomRemoteItem;
begin
  for I := AList.Count - 1 downto 0 do
  begin
    LResource := AList[I];
    if LResource.ItemType = ARemoteItemType then
      AList.Delete(I);
  end;
end;

destructor TTetheringAppProfile.Destroy;
begin
  Enabled := False;

  FRunningActions.Free;

  FSharedActions.Free;
  FSharedResources.Free;

  FSubscribedRemoteProfiles.Free;
  FSubscribedProfiles.Free;
  FConnectedManagerProfileIds.Free;
  FRemoteItems.Free;

  inherited;
end;

procedure TTetheringAppProfile.Disconnect(const AProfile: TTetheringProfileInfo);
var
  LConnection: TTetheringConnection;
  I: Integer;
  LConnectedPair: TConnectedProfilePair;
begin
  LConnection := FindConnection(AProfile);
  if LConnection <> nil then
  begin
    TMonitor.Enter(LConnection);
    try
  // Send Disconnect message...
      if LConnection.Protocol.IsConnected then
        SendCommand(LConnection, TTetheringCommand.Create(DisconnectProfileCommand, Version, [Manager.Identifier, Identifier]));
    finally
      TMonitor.Exit(LConnection);
    end;
  end;

  // Always remove the profile from connected profiles...
  for I := FConnectedManagerProfileIds.Count - 1 downto 0 do
  begin
    LConnectedPair := FConnectedManagerProfileIds[I];
    if (CompareText(LConnectedPair.Key, AProfile.ProfileIdentifier) = 0) and
       (CompareText(LConnectedPair.Value, AProfile.ManagerIdentifier) = 0) then
    begin
      FConnectedManagerProfileIds.Delete(I);
    end;
  end;

  inherited;
end;

procedure TTetheringAppProfile.DisconnectFromManager(const AManagerId: string);
var
  LConnectedPair: TConnectedProfilePair;
  I: Integer;
  LProfile: TTetheringProfileInfo;
begin
  inherited;
  for I := FConnectedManagerProfileIds.Count - 1 downto 0 do
  begin
    LConnectedPair := FConnectedManagerProfileIds[I];
    if CompareText(LConnectedPair.Value, AManagerId) = 0 then
      if FindProfile(LConnectedPair.Key, LProfile) then
      begin
        if IsProfileConnected(LProfile) then
          Disconnect(LProfile)
        else
          FConnectedManagerProfileIds.Delete(I);
      end;
  end;
end;

function TTetheringAppProfile.FindActionByName(const AnActionName: string): TLocalAction;
var
  I: Integer;
  LAction: TLocalAction;
begin
  for I := 0 to FSharedActions.Count - 1 do
  begin
    LAction := FSharedActions.Items[I];
    if string.Compare(AnActionName, LAction.Name, [coIgnoreCase]) = 0 then
      Exit(LAction);
  end;
  Result := nil;
end;

function TTetheringAppProfile.FindProfileManager(AProfileId: string): string;
var
  LConnectedPair: TConnectedProfilePair;
  I: Integer;
begin
  for I := 0 to FConnectedManagerProfileIds.Count - 1 do
  begin
    LConnectedPair := FConnectedManagerProfileIds[I];
    if CompareText(LConnectedPair.Key, AProfileID) = 0 then
      Exit(LConnectedPair.Value)
    else
      Result := '';
  end;
end;

function TTetheringAppProfile.FindProfileFromRemoteItem(const ARemoteItem: TCustomRemoteItem;
  var Profile: TTetheringProfileInfo): Boolean;
type
  TRemoteResPair = TPair<TTetheringProfileInfo, TObjectList<TCustomRemoteItem>>;
var
  APair: TRemoteResPair;
begin
  for APair in FRemoteItems do
    if APair.Value.IndexOf(ARemoteItem) >= 0 then
    begin
      Profile := APair.Key;
      Exit(True);
    end;
  Result := False;
end;

function TTetheringAppProfile.FindResourceByName(const AResName: string;
  const ResList: TResourceCollection): TLocalResource;
var
  I: Integer;
  LResource: TLocalResource;
begin
  for I := 0 to ResList.Count - 1 do
  begin
    LResource := ResList.Items[I];
    if string.Compare(AResName, LResource.FName, [coIgnoreCase]) = 0 then
      Exit(LResource);
  end;
  Result := nil;
end;

function TTetheringAppProfile.FindRemoteItemByName(const AItemName: string;
  const ResList: TList<TCustomRemoteItem>): TCustomRemoteItem;
var
  I: Integer;
  LResource: TCustomRemoteItem;
begin
  for I := 0 to ResList.Count - 1 do
  begin
    LResource := ResList[I];
    if string.Compare(AItemName, LResource.FName, [coIgnoreCase]) = 0 then
      Exit(LResource);
  end;
  Result := nil;
end;

class function TTetheringAppProfile.GetAllowedProtocolsAdapters: TTetheringProtocolAdapterTypes;
begin
  Result := TTetheringProfiles.AllowedProtocolAdapters[AppProfileID];
end;

function TTetheringAppProfile.UpdateActionFromJSON(const ARemoteAction: TRemoteAction; const ResValue: TArray<Byte>;
  StartPos: Integer): TRemoteAction;
var
  JSON: TJSONObject;
  JSONValue: TJSONValue;
begin
  Result := nil;
  try
    if Length(ResValue) > 0 then
    begin
      JSON := TJSONObject.Create;
      try
        Result := ARemoteAction;
        JSON.Parse(ResValue, StartPos);
        JSONValue := JSON.GetValue(AppProfileActionEnabled);
        if JSONValue <> nil then
          Result.Enabled := (JSONValue as TJSONBool).AsBoolean;

        JSONValue := JSON.GetValue(AppProfileActionCaption);
        if JSONValue <> nil then
          Result.Caption := (JSONValue as TJSONString).Value;

        JSONValue := JSON.GetValue(AppProfileActionHint);
        if JSONValue <> nil then
          Result.Hint := (JSONValue as TJSONString).Value;

      finally
        JSON.Free;
      end;
    end;
  except
  end;
end;

function TTetheringAppProfile.UpdateResourceFromJSON(const ARemoteRes: TRemoteResource;
  const ResValue: TArray<Byte>; StartPos: Integer): TRemoteResource;
var
  JSON: TJSONObject;
  JSONDataType: TJSONValue;
  DataType: TResourceType;
  JSONValue: TJSONValue;
begin
  Result := nil;
  try
    if Length(ResValue) > 0 then
    begin
      JSON := TJSONObject.Create;
      try
        JSON.Parse(ResValue, StartPos);
        JSONDataType := JSON.GetValue(AppProfileDataType);
        DataType := TResourceType((JSONDataType as TJSONNumber).AsInt);
        JSONValue := JSON.GetValue(AppProfileValue);
        if JSONValue <> nil then
        begin
          ARemoteRes.UpdateValue(DataType, JSONValue);
          Result := ARemoteRes;
        end;
      finally
        JSON.Free;
      end;
    end;
  except
  end;
end;

procedure TTetheringAppProfile.DoRemoteProfileUpdate(const AProfileId: string);
var
  LProfile: TTetheringProfileInfo;
begin
  if FindProfile(AProfileId, LProfile) then
  begin
    GetRemoteActions(LProfile);
    GetRemoteResources(LProfile);
    AutoSubscribeGroup(LProfile);
  end;
  if Assigned(FOnRemoteProfileUpdate) then
    TThread.Synchronize(nil,
      procedure
      begin
        FOnRemoteProfileUpdate(Self, AProfileId);
      end
    );
end;

procedure TTetheringAppProfile.DoAcceptResource(const AProfileId: string; AResource: TCustomRemoteItem;
  var AcceptResource: Boolean);
var
  LAcceptResource: Boolean;
begin
  if Assigned(FOnAcceptResource) then
  begin
    LAcceptResource := AcceptResource;
    TThread.Synchronize(nil,
      procedure
      begin
        FOnAcceptResource(Self, AProfileId, AResource, LAcceptResource);
      end
    );
    AcceptResource := LAcceptResource;
  end;
end;

procedure TTetheringAppProfile.DoOnDisconnect(const AProfileInfo: TTetheringProfileInfo);
begin
  // If the profile is still in the List, remove it.
  if FConnectedProfiles.IndexOf(AProfileInfo) >= 0 then
    FConnectedProfiles.Remove(AProfileInfo);
  // Fire the event
  inherited;
end;

procedure TTetheringAppProfile.DoOnIncomingData(const AProtocol: TTetheringProtocol; const AData: TBytes);
var
  LCommand: TTetheringCommand;

  procedure DoConnect(const ACommand: TTetheringCommand);
  var
    LManagerId: string;
    LProfileId: string;
    LProfile: TTetheringProfileInfo;
    LInfo: TConnectedProfilePair;
  begin
    if Length(ACommand.Parameters) > 1 then
    begin
      LManagerId := ACommand.Parameters[0];
      LProfileId := ACommand.Parameters[1];
      if CheckManager(LManagerId) then
      begin
        LInfo.Key := LProfileId;
        LInfo.Value := LManagerId;
        if FindProfile(LProfileId, LProfile) then
        begin
          // We fire the OnBeforeConnect event to inform and ask for Permission to connect
          if DoOnBeforeConnect(LProfile) then
          begin
            FConnectedManagerProfileIds.Add(LInfo);
            AProtocol.SendData(TTetheringCommand.Create(ConnectCommandOKResponse, Version).ToBytes);
            Exit;
          end;
        end;
      end;
      AProtocol.SendData(TTetheringCommand.Create(ConnectCommandErrorResponse, Version).ToBytes);
    end
    else
      AProtocol.SendData(TTetheringCommand.Create(ResponseBadCommand, Version).ToBytes);
  end;

  procedure DoReceiveStream(const ACommand: TTetheringCommand);
  var
    LParams: TTetheringParams;
    LStream: TMemoryStream;
    LParameter: string;
  begin
    if Length(ACommand.Parameters) <= 0 then
      LParameter := ''
    else
      LParameter := ACommand.Parameters[0];
    LParams := [LParameter];
    // Send a message that we are waiting for the stream;
    AProtocol.SendData(TTetheringCommand.Create(SendStreamOkResponse, Version, LParams).ToBytes);

    // Receive the Stream...
    LStream := TMemoryStream.Create;
    try
      AProtocol.ReceiveStream(LStream);
      LStream.Position := 0;
    except
      FreeAndNil(LStream);
    end;

    // Send ack or error
    if LStream <> nil then
    begin
      AProtocol.SendData(TTetheringCommand.Create(SendStreamContentOKResponse, Version).ToBytes);
      OnStreamReceived(Self, Identifier, LStream, LParameter);
    end
    else
      AProtocol.SendData(TTetheringCommand.Create(SendStreamContentErrorResponse, Version).ToBytes);
  end;

  procedure DoReceiveString(const ACommand: TTetheringCommand);
  var
    LString: string;
    APars: string;
  begin
    if Length(ACommand.Parameters) <> 2 then
      AProtocol.SendData(TTetheringCommand.Create(SendStringContentErrorResponse, Version).ToBytes)
    else
    begin
      APars := ACommand.Parameters[0];
      LString := ACommand.Parameters[1];

      AProtocol.SendData(TTetheringCommand.Create(SendStringContentOKResponse, Version).ToBytes);
      OnStringReceived(Self, Identifier, LString, APars);
    end;
  end;

  procedure DoRunAction(const ACommand: TTetheringCommand);
  var
    LAction: TLocalAction;
    ResBytes: TBytes;
    LThread: TThread;
  begin
    if Length(ACommand.Parameters) = 1 then
    begin
      LAction := FindActionByName(ACommand.Parameters[0]);
      if (LAction <> nil) and (LAction.IsPublic) then
      begin
        LThread := TThread.CreateAnonymousThread(procedure
          begin
            TThread.Synchronize(nil,
              procedure
              begin
                LAction.Action.Execute;
              end
            );
          end);

        LThread.FreeOnTerminate := False;

        LThread.Start;

        ResBytes := TTetheringCommand.Create(ResponseCommandAlive, Version).ToBytes;
        while not LThread.Finished do
        begin
          Sleep(80);
          AProtocol.SendData(ResBytes);
        end;
        LThread.DisposeOf;

        AProtocol.SendData(TTetheringCommand.Create(RunActionResponseOKCommand, Version).ToBytes);
      end
      else
        AProtocol.SendData(TTetheringCommand.Create(RunActionResponseErrorCommand, Version).ToBytes);
    end
    else
      AProtocol.SendData(TTetheringCommand.Create(ResponseBadCommand, Version).ToBytes);
  end;

  procedure DoRunActionAsync(const ACommand: TTetheringCommand);
  var
    LAction: TLocalAction;
    LThread: TThread;
    LManagerId: string;
    LProfileId: string;
    LExtraData: string;
    LActionName: string;
    LHandle: TRemoteActionHandle;
  begin
    if Length(ACommand.Parameters) = 3 then
    begin
      LManagerId := ACommand.Parameters[0];
      LProfileId := ACommand.Parameters[1];
      LActionName := ACommand.Parameters[2];
      LAction := FindActionByName(LActionName);
      if (LAction <> nil) and (LAction.IsPublic) then
      begin
        LHandle := TRemoteActionHandle(Random(MaxInt));
        if SizeOf(LHandle) > 4 then
          LHandle := TRemoteActionHandle(UInt64(LHandle) + (Random(MaxInt) shl 32));
        LThread := TThread.CreateAnonymousThread(procedure
          var
            Res: Boolean;
          begin
            try
              LAction.Action.Execute;
              Res := True;
            except
              Res := False;
            end;
            FRunningActions.Remove(TRunningActionsPair.Create(TRemoteActionHandle(LHandle), LActionName));
            LExtraData := TTetheringManagerCommand.Join(TokenSep, [Manager.Identifier, Identifier, LAction.Name, UInt64(LHandle).ToString, BoolToStr(Res, False)]);
            Manager.SendNotification(LManagerId, LProfileId, NotifyRemoteActionEndCommand, LExtraData);
          end);
        FRunningActions.Add(TRunningActionsPair.Create(TRemoteActionHandle(LHandle), LActionName));
        AProtocol.SendData(TTetheringCommand.Create(RunActionResponseOKCommand, Version, [UInt64(LHandle).ToString]).ToBytes);
        LThread.Start;
      end
      else
        AProtocol.SendData(TTetheringCommand.Create(RunActionResponseErrorCommand, Version).ToBytes);
    end
    else
      AProtocol.SendData(TTetheringCommand.Create(ResponseBadCommand, Version).ToBytes);
  end;

  procedure DoGetRemoteActionState(const AProtocol: TTetheringProtocol; const ACommand: TTetheringCommand);
  var
    LActionName: string;
    LHandle: TRemoteActionHandle;
    LList: TList<TRunningActionsPair>;
    LPair: TRunningActionsPair;
    LState: TRemoteActionState;
    Tmp: UInt64;
  begin
    LState := TRemoteActionState.NotFound;
    if Length(ACommand.Parameters) = 1 then
    begin
      LActionName := ACommand.Parameters[0];
      if TryStrToUInt64(LActionName, Tmp) then // Is a remote handle
      begin
        LHandle := TRemoteActionHandle(Tmp);
        try
          LList := FRunningActions.LockList;
          for LPair in LList do
            if LPair.Key = LHandle then
            begin
              LState := TRemoteActionState.Running;
              Break;
            end;
        finally
          FRunningActions.UnlockList;
        end;
      end
      else // Is a action name
      begin
        if FindActionByName(LActionName) = nil then
          LState := TRemoteActionState.NotFound
        else
        begin
          try
            LState := TRemoteActionState.NotRunning;
            LList := FRunningActions.LockList;
            for LPair in LList do
              if SameText(LPair.Value, ACommand.Parameters[0]) then
              begin
                LState := TRemoteActionState.Running;
                Break;
              end;
          finally
            FRunningActions.UnlockList;
          end;
        end;
      end;
    end;

    AProtocol.SendData(TTetheringCommand.Create(GetRemoteActionAsyncStateCommandResponse, Version, [Ord(LState).ToString]).ToBytes);
  end;

  procedure ProcessSubscribeResourceCommand(const AProtocol: TTetheringProtocol; const ACommand: TTetheringCommand);
  var
    LProfileId: string;
    LResourceName: string;
    LRemote: TCustomLocalItem;
    LSubscribed: TStringList;
  begin
    if Length(ACommand.Parameters) = 3 then
    begin
      LResourceName := ACommand.Parameters[0];
      LProfileId := ACommand.Parameters[2];
      LRemote := FindResourceByName(LResourceName, FSharedResources);
      if LRemote = nil then
        LRemote := FindActionByName(LResourceName);
      if LRemote <> nil then
      begin
        if not FSubscribedProfiles.TryGetValue(LRemote, LSubscribed) then
        begin
          LSubscribed := TStringList.Create;
          FSubscribedProfiles.Add(LRemote, LSubscribed);
        end;
        if LSubscribed.IndexOf(LProfileId) = -1 then
          LSubscribed.Add(LProfileId);
        AProtocol.SendData(TTetheringCommand.Create(SubscribeResourceResponseCommand, Version).ToBytes);
      end
      else
        AProtocol.SendData(TTetheringCommand.Create(ResponseUnknownResourceCommand, Version, [LResourceName]).ToBytes);
    end
    else
      AProtocol.SendData(TTetheringCommand.Create(ResponseBadCommand, Version).ToBytes);
  end;

  procedure ProcessUnSubscribeResourceCommand(const AProtocol: TTetheringProtocol; const ACommand: TTetheringCommand);
  var
    LProfileId: string;
    LResourceName: string;
    LRemote: TCustomLocalItem;
    LSubscribed: TStringList;
    LIndex: Integer;
  begin
    if Length(ACommand.Parameters) = 3 then
    begin
      LResourceName := ACommand.Parameters[0];
      LProfileId := ACommand.Parameters[2];
      LRemote := FindResourceByName(LResourceName, FSharedResources);
      if LRemote = nil then
        LRemote := FindActionByName(LResourceName);
      if LRemote <> nil then
      begin
        if FSubscribedProfiles.TryGetValue(LRemote, LSubscribed) then
        begin
          LIndex := LSubscribed.IndexOf(LProfileId);
          if LIndex <> -1 then
            LSubscribed.Delete(LIndex);
          AProtocol.SendData(TTetheringCommand.Create(UnsubscribeResourceResponseCommand, Version).ToBytes);
        end;
      end;
    end
    else
      AProtocol.SendData(TTetheringCommand.Create(ResponseBadCommand, Version).ToBytes);
  end;

  procedure GetLocalActionsInfo(const AProtocol: TTetheringProtocol; const ACommand: TTetheringCommand);
  var
    LAction: TLocalAction;
    I: Integer;
    LActionsStrings: TArray<string>;
  begin
    if FSharedActions.Count > 0 then
    begin
      SetLength(LActionsStrings, FSharedActions.Count);
      for I := 0 to FSharedActions.Count - 1 do
      begin
        LAction := FSharedActions.Items[I];
        LActionsStrings[I] := TTetheringManagerCommand.Join(InnerSep, [LAction.Name, IntToStr(Ord(LAction.FKind)), LAction.Hint]);
      end;
    end;
    AProtocol.SendData(TTetheringCommand.Create(GetActionsCommandResponse, Version, LActionsStrings).ToBytes);
  end;

  procedure GetLocalResourcesInfo(const AProtocol: TTetheringProtocol; const ACommand: TTetheringCommand);
  var
    I: Integer;
    LSimpleRes: TLocalResource;
    JSON: TJSONObject;
    LValue: TJSONValue;
    LHint: TJSONString;
    LValueArr: TJSONArray;
    LBytes: TBytes;
    LCmd: TTetheringCommand;
  begin
    // Get info from local resources.
    if FSharedResources.Count = 0 then
      AProtocol.SendData(TTetheringCommand.Create(GetResourcesCommandResponse, Version).ToBytes)
    else
    begin
      JSON := TJSONObject.Create;
      try
        for I := 0 to FSharedResources.Count - 1 do
        begin
          LSimpleRes := FSharedResources.Items[I];
          if LSimpleRes.IsPublic then
          begin
            LValue := TJSONNumber.Create(Integer(LSimpleRes.ResType));
            LHint := TJSONString.Create(LSimpleRes.Hint);
            LValueArr := TJSONArray.Create(LHint, LValue);
            JSON.AddPair(LSimpleRes.Name, LValueArr);
          end;
        end;
        SetLength(LBytes, JSON.EstimatedByteSize);
        SetLength(LBytes, JSON.ToBytes(LBytes, 0));
        LCmd := TTetheringCommand.Create(GetResourcesCommandResponse, Version, [TEncoding.UTF8.GetString(LBytes)]);
        AProtocol.SendData(LCmd.ToBytes);
      finally
        JSON.Free;
      end;
    end;
  end;

  procedure GetLocalResourceValue(const AProtocol: TTetheringProtocol; const ACommand: TTetheringCommand);
  var
    LResource: TLocalResource;
    ResName: string;
    LValue: string;
    LStream: TStream;
    LTransferred: Boolean;
  begin
    ResName := ACommand.Parameters[0];
    LResource := FindResourceByName(ResName, FSharedResources);
    if LResource <> nil then
    begin
      case LResource.ResType of
        TRemoteResourceType.Data:
        begin
          TMonitor.Enter(LResource);
          try
            LValue := LResource.ToJsonString;
          finally
            TMonitor.Exit(LResource);
          end;
          AProtocol.SendData(TTetheringCommand.Create(GetResourceValueCommandResponse, Version, [LValue]).ToBytes);
        end;

        TRemoteResourceType.Stream:
        begin
          TMonitor.Enter(LResource);
          try
            LStream := LResource.Value.AsStream;
            if LStream = nil then
            begin
              LStream := TMemoryStream.Create;
              try
                LTransferred := AProtocol.SendStream(LStream);
              finally
                LStream.Free;
              end;
            end
            else
              LTransferred := AProtocol.SendStream(LStream);
            if not LTransferred then
              raise ETetheringException.CreateFmt(SCanNotSendResource, [ResName]);
          finally
            TMonitor.Exit(LResource);
          end;
        end;
      end;
    end
    else
      Aprotocol.SendData(TTetheringCommand.Create(TTetheringCommandType.SendResponse, ResponseBadCommand, Version).ToBytes);
  end;

  procedure ProcessReverseConnectCommand(const ACommand: TTetheringCommand);
  var
    LManagerId: string;
    LProfileId: string;
    LProfile: TTetheringProfileInfo;
  begin
    if Length(ACommand.Parameters) > 1 then
    begin
      LManagerId := ACommand.Parameters[0];
      LProfileId := ACommand.Parameters[1];
      if CheckManager(LManagerId) and FindProfile(LProfileId, LProfile) and not IsProfileConnected(LProfile) then
        if Connect(LProfile) then
          DoOnAfterConnect(LProfile);
    end;
  end;

  procedure DoProcessDisconnectProfile(const ACommand: TTetheringCommand);
  var
    LManagerId: string;
    LProfileId: string;
    LProfile: TTetheringProfileInfo;
  begin
    if Length(ACommand.Parameters) > 1 then
    begin
      LManagerId := ACommand.Parameters[0];
      LProfileId := ACommand.Parameters[1];
      if CheckManager(LManagerId) and FindProfile(LProfileId, LProfile) then
      begin
        // Do the notification...
        DoOnDisconnect(LProfile);
        // Disconnect the profile. But avoid sending command calling ancestor.
        inherited Disconnect(LProfile);
      end;
    end;
  end;

begin
                                                                                             
  LCommand := TTetheringCommand.Create(AData);
  case StringToCommandType(LCommand.Command) of
    TTetheringAppCommand.Connect:
      DoConnect(LCommand);

    TTetheringAppCommand.DisconnectProfile:
      DoProcessDisconnectProfile(LCommand);

    TTetheringAppCommand.ReverseConnect:
      ProcessReverseConnectCommand(LCommand);

    TTetheringAppCommand.Run:
      DoRunAction(LCommand);

    TTetheringAppCommand.RunAsync:
      DoRunActionAsync(LCommand);

    TTetheringAppCommand.GetRemoteActionState:
      DoGetRemoteActionState(AProtocol, LCommand);

    TTetheringAppCommand.GetActions:
      GetLocalActionsInfo(AProtocol, LCommand);

    TTetheringAppCommand.GetResources:
      GetLocalResourcesInfo(AProtocol, LCommand);

    TTetheringAppCommand.GetResourceValue:
      GetLocalResourceValue(AProtocol, LCommand);

    TTetheringAppCommand.SubscribeResource:
      ProcessSubscribeResourceCommand(AProtocol, LCommand);

    TTetheringAppCommand.UnsubscribeResource:
      ProcessUnsubscribeResourceCommand(AProtocol, LCommand);

    TTetheringAppCommand.SendStream:
      DoReceiveStream(LCommand);

    TTetheringAppCommand.SendString:
      DoReceiveString(LCommand);

    TTetheringAppCommand.Unknown:
      AProtocol.SendData(TTetheringCommand.Create(TTetheringCommandType.SendResponse, ResponseBadCommand, Version).ToBytes);

  else
    AProtocol.SendData(TTetheringCommand.Create(TTetheringCommandType.SendResponse, ResponseBadCommand, Version).ToBytes);
  end;
end;

procedure TTetheringAppProfile.DoResourceReceived(AResource: TRemoteResource);
begin
  if Assigned(FOnResourceReceived) then
    TThread.Synchronize(nil,
      procedure
      begin
        FOnResourceReceived(Self, AResource);
      end
    );
end;

procedure TTetheringAppProfile.DoResourceUpdated(LRemoteRes: TRemoteResource);
var
  I: Integer;
  LProfile: TTetheringProfileInfo;
begin
  if FindProfile(LRemoteRes.FRemoteProfileId, LProfile) then
  begin
    if (LProfile.ProfileGroup <> '') and (string.Compare(LProfile.ProfileGroup, Group, [coIgnoreCase]) = 0) then
    begin
      for I := 0 to FSharedResources.Count - 1 do
      begin
        if (FSharedResources.Items[I].FKind = TTetheringRemoteKind.Mirror) and
           (string.Compare(FSharedResources.Items[I].FName, LRemoteRes.FName, [coIgnoreCase]) = 0) then
        begin
          if LRemoteRes.FResType = TRemoteResourceType.Stream then
            InternalGetRemoteResourceValue(LRemoteRes, LProfile);
          FSharedResources.Items[I].Value := LRemoteRes.Value;
          FSharedResources.Items[I].DoResourceReceived(LRemoteRes);
          Break;
        end;
      end;
    end;
  end;

  if Assigned(FOnResourceUpdated) then
    TThread.Synchronize(nil,
      procedure
      begin
        FOnResourceUpdated(Self, LRemoteRes as TRemoteResource);
      end
    );
end;

function TTetheringAppProfile.GetSharedResources: TResourceCollection;
begin
  Result := FSharedResources;
end;

function TTetheringAppProfile.GetProfileType: TTetheringProfileType;
begin
  Result := AppProfileID;
end;

function TTetheringAppProfile.GetRemoteActionAsyncState(const AnAction: TRemoteAction): TRemoteActionState;
var
  LProfile: TTetheringProfileInfo;
begin
  if FindProfileFromRemoteItem(AnAction, LProfile) then
    Result := InternalGetRemoteActionAsyncState(LProfile, AnAction.Name)
  else
    Result := TRemoteActionState.NotFound;
end;

function TTetheringAppProfile.GetRemoteActionAsyncState(const AProfile: TTetheringProfileInfo;
  ARemoteActionHandle: TRemoteActionHandle): TRemoteActionState;
begin
  Result := InternalGetRemoteActionAsyncState(AProfile, UInt64(ARemoteActionHandle).ToString);
end;

function TTetheringAppProfile.GetRemoteActionAsyncState(const AProfile: TTetheringProfileInfo;
  const AnActionName: string): TRemoteActionState;
var
  LRemoteResources: TObjectList<TCustomRemoteItem>;
  LRemoteRes: TCustomRemoteItem;
begin
  if FRemoteItems.TryGetValue(AProfile, LRemoteResources) then
  begin
    LRemoteRes := FindRemoteItemByName(AnActionName, LRemoteResources);
    if (LRemoteRes <> nil) and (LRemoteRes.ItemType = TTetheringRemoteItemType.Action) then
      Result := InternalGetRemoteActionAsyncState(AProfile, LRemoteRes.Name)
    else
      Result := TRemoteActionState.NotFound;
  end
  else
    Result := TRemoteActionState.NotFound;
end;

function TTetheringAppProfile.GetRemoteActions(const AProfile: TTetheringProfileInfo): Boolean;
var
  I: Integer;
  LRemoteAction: TRemoteAction;
  LProfileActions: TObjectList<TCustomRemoteItem>;
  LActionInfo: TArray<string>;
  LResponseCommand: TTetheringCommand;
begin
  LResponseCommand := SendCommandWithResponse(AProfile, TTetheringCommand.Create(GetActionsCommand, Version, []));
  if not FRemoteItems.ContainsKey(AProfile) then
  begin
    LProfileActions := TObjectList<TCustomRemoteItem>.Create;
    FRemoteItems.Add(AProfile, LProfileActions);
  end
  else
    if FRemoteItems.TryGetValue(AProfile, LProfileActions) then
      DeleteRemoteItemsOfType(TTetheringRemoteItemType.Action, LProfileActions)
    else
      raise ETetheringException.CreateFmt(SNoResourceList, [AProfile.ProfileIdentifier]);

  for I := 0 to High(LResponseCommand.Parameters) do
  begin
    LActionInfo := TTetheringManagerCommand.Split(LResponseCommand.Parameters[I], InnerSep);
    if Length(LActionInfo) > 1 then
    begin
      LRemoteAction := TRemoteAction.Create;
      LRemoteAction.Name := LActionInfo[0];
      LRemoteAction.Profile := Self;
      LRemoteAction.Kind := TTetheringRemoteKind(StrToInt(LActionInfo[1]));
      LRemoteAction.FRemoteProfileId := AProfile.ProfileIdentifier;
      if Length(LActionInfo) > 2 then
        LRemoteAction.Hint := LActionInfo[2]
      else
        LRemoteAction.Hint := '';
      LProfileActions.Add(LRemoteAction);
    end;
  end;
  Result := True;
end;

function TTetheringAppProfile.GetRemoteProfileActions(const AProfile: TTetheringProfileInfo): TList<TRemoteAction>;
var
  LRemoteResources: TObjectList<TCustomRemoteItem>;
  I: Integer;
begin
  CheckProfileIsConnected(AProfile);
  if FRemoteItems.TryGetValue(AProfile, LRemoteResources) then
  begin
    Result := TList<TRemoteAction>.Create;
    try
      for I := 0 to LRemoteResources.Count - 1 do
        if LRemoteResources[I].FItemType = TTetheringRemoteItemType.Action then
          Result.Add(LRemoteResources[I] as TRemoteAction);
    except
      Result.Free;
      raise;
    end;
  end else
    Result := nil;
end;

function TTetheringAppProfile.GetRemoteProfileResources(const AProfile: TTetheringProfileInfo): TList<TRemoteResource>;
var
  LRemoteResources: TObjectList<TCustomRemoteItem>;
  I: Integer;
begin
  CheckProfileIsConnected(AProfile);
  if FRemoteItems.TryGetValue(AProfile, LRemoteResources) then
  begin
    Result := TList<TRemoteResource>.Create;
    try
      for I := 0 to LRemoteResources.Count - 1 do
        if LRemoteResources[I].FItemType = TTetheringRemoteItemType.Resource then
          Result.Add(LRemoteResources[I] as TRemoteResource);
    except
      Result.Free;
      raise;
    end;
  end else
    Result := nil;
end;

procedure TTetheringAppProfile.GetRemoteResources(const AProfile: TTetheringProfileInfo);
var
  I: Integer;
  JSON: TJSONObject;
  ResData: TArray<Byte>;
  LPair: TJSONPair;
  LValuesArr: TJSONArray;
  LHint: TJSONString;
  LResType: TRemoteResourceType;
  LValue: TJSONNumber;
  LRemoteResource: TRemoteResource;
  LProfileResources: TObjectList<TCustomRemoteItem>;
  LConnection: TTetheringConnection;
  LSuscribedResources: TStringList;
  JSonPos: Integer;
begin
  LConnection := GetConnectionTo(AProfile);
  TMonitor.Enter(LConnection);
  try
    //LConnection.Protocol.SendCommand(GetResourcesCommand, Version, []);
    SendCommand(LConnection, TTetheringCommand.Create(GetResourcesCommand, Version, []));
    try
      ResData := LConnection.Protocol.ReceiveData;
    except
                                 
      DoCommError(AProfile);
    end
  finally
    TMonitor.Exit(LConnection);
  end;
  JSonPos := -1;
  for I := CommandsLength to High(ResData) do
    if ResData[I] = Ord(CommandSep) then
    begin
      JSonPos := I + 1;
      Break;
    end;
  if JSonPos > 0 then
  begin
    JSON := TJSONObject.Create;
    LSuscribedResources := TStringList.Create;
    try
      JSON.Parse(ResData, JSonPos);
      if not FRemoteItems.ContainsKey(AProfile) then
      begin
        LProfileResources := TObjectList<TCustomRemoteItem>.Create;
        FRemoteItems.Add(AProfile, LProfileResources);
      end
      else
        if FRemoteItems.TryGetValue(AProfile, LProfileResources) then
          UnSubscribeAndDeleteRemoteResources(AProfile, LProfileResources, LSuscribedResources)
        else
          raise ETetheringException.CreateFmt(SNoResourceList, [AProfile.ProfileIdentifier]);

      for I := 0 to JSON.Count - 1 do
      begin
        LPair := JSON.Pairs[I];
        LValuesArr := LPair.JsonValue as TJSONArray;
        if LValuesArr.Count = 2 then
        begin
          LHint := LValuesArr.Items[0] as TJSONString;
          LValue := LValuesArr.Items[1] as TJSONNumber;
          LResType := TRemoteResourceType(LValue.AsInt);

          LRemoteResource := TRemoteResource.Create;
          LRemoteResource.ResType := LResType;
          LRemoteResource.Name := LPair.JsonString.Value;
          LRemoteResource.Hint := LHint.Value;
          LRemoteResource.FRemoteProfileId := AProfile.ProfileIdentifier;
          LRemoteResource.Profile := Self;
          LProfileResources.Add(LRemoteResource);
          if LSuscribedResources.IndexOf(LRemoteResource.Name) <> -1 then
            SubscribeToRemoteItem(AProfile, LRemoteResource);
        end
        else
          raise ETetheringException.CreateFmt(SNoResourceList, [AProfile.ProfileIdentifier]);
      end;

    finally
      LSuscribedResources.Free;
      JSON.Free;
    end;
  end;
end;

function TTetheringAppProfile.GetRemoteResourceValue(const AProfile: TTetheringProfileInfo;
  const ARemoteResName: string): TRemoteResource;
var
  LRemoteItem: TCustomRemoteItem;
  LProfileRemoteItems: TObjectList<TCustomRemoteItem>;
  LFoundRemoteRes: TRemoteResource;
  I: Integer;
begin
  FRemoteItems.TryGetValue(AProfile, LProfileRemoteItems);
  if LProfileRemoteItems <> nil then
  begin
    LFoundRemoteRes := nil;
    for I := 0 to LProfileRemoteItems.Count - 1 do
    begin
      LRemoteItem := LProfileRemoteItems[I];
      if (LRemoteItem.ItemType = TTetheringRemoteItemType.Resource) and
         (string.Compare(LRemoteItem.Name, ARemoteResName, [coIgnoreCase]) = 0) then
      begin
        LFoundRemoteRes := LRemoteItem as TRemoteResource;
        Break;
      end
    end;
    if LFoundRemoteRes <> nil then
      Result := InternalGetRemoteResourceValue(LFoundRemoteRes, AProfile)
    else
      raise ETetheringException.Create(SRemoteResNotFound);
  end
  else
    raise ETetheringException.Create(SRemoteResNotFound);
end;

function TTetheringAppProfile.GetSharedActions: TActionCollection;
begin
  Result := FSharedActions;
end;

procedure TTetheringAppProfile.Notify(const ANotification, Data: string);
  function ProcessReceivedData(const AData: string): string;
  begin
    Result := TEncoding.UTF8.GetString(TBytes(OnAfterReceiveData(Self, TByteDynArray(TNetEncoding.Base64.DecodeStringToBytes(AData)))));
  end;

var
  LRemoteItem: TCustomRemoteItem;
  LAllData: TArray<string>;
  LSubscribed: TSubscribedResPair;
  LAction: TRemoteAction;
  LAccepted: Boolean;
  LNewResource: TRemoteResource;
  LRemoteResType: TRemoteResourceType;
  LExtraData: string;
  LProfile: TTetheringProfileInfo;
  LLocalAction: TLocalAction;

begin
  if CompareText(ANotification, NotifyResourceUpdateCommand) = 0 then
  begin
    if Assigned(OnAfterReceiveData) then
      LAllData := TTetheringManagerCommand.Split(ProcessReceivedData(Data), TokenSep)
    else
      LAllData := TTetheringManagerCommand.Split(Data, TokenSep);
    if Length(LAllData) >= 2 then
    begin
      LRemoteItem := nil;
      for LSubscribed in FSubscribedRemoteProfiles do
        if (CompareText(LSubscribed.Key.ProfileIdentifier, LAllData[0]) = 0) and
           (string.Compare(LSubscribed.Value.Name, LAllData[1], [coIgnoreCase]) = 0) then
        begin
          LRemoteItem := LSubscribed.Value;
          Break;
        end;

      if LRemoteItem <> nil then
      begin
        case LRemoteItem.FItemType of
          TTetheringRemoteItemType.Action:
          begin
            LAction := LRemoteItem as TRemoteAction;
            UpdateActionFromJSON(LAction, TEncoding.UTF8.GetBytes(LAllData[2]), 0);
            // Update LocalAction.
            if (LSubscribed.Value.FKind = TTetheringRemoteKind.Shared) and
               (CompareText(LSubscribed.Key.ProfileGroup, Group) = 0) then
            begin
              LLocalAction := FSharedActions.FindByName(LAction.Name);
              if (LLocalAction <> nil) and (LLocalAction.FAction <> nil) and
                 (LLocalAction.FKind = TTetheringRemoteKind.Mirror) then
              begin
                LLocalAction.FActionEnabled := LAction.Enabled;
                LLocalAction.FActionCaption := LAction.Caption;
                LLocalAction.FHint := LAction.Hint;
                LLocalAction.FAction.Enabled := LLocalAction.FActionEnabled;
                LLocalAction.FAction.Caption := LLocalAction.FActionCaption;
                LLocalAction.FAction.Hint := LLocalAction.FHint;
              end;
            end;
            // Fire Events...
            if Assigned(FOnActionUpdated) then
              FOnActionUpdated(Self, LAction);
            if Assigned(LAction.OnUpdate) then
              LAction.OnUpdate(LAction);
          end;

          TTetheringRemoteItemType.Resource:
          begin
            if (LRemoteItem as TRemoteResource).FResType = TRemoteResourceType.Data then
              LRemoteItem := UpdateResourceFromJSON(LRemoteItem as TRemoteResource, TEncoding.UTF8.GetBytes(LAllData[2]), 0);
            DoResourceUpdated(LRemoteItem as TRemoteResource);
          end;
        end;
      end
    end
  end
  else if CompareText(ANotification, NotifySendResourceCommand) = 0 then
  begin
    LAllData := TTetheringManagerCommand.Split(Data, TokenSep);
    try
      LRemoteResType := TRemoteResourceType(LAllData[3].ToInteger);
    except
      LRemoteResType := TRemoteResourceType.Data;
    end;

    LExtraData := '';
    LNewResource := CreateRemoteTempResource(LRemoteResType, LAllData[2], LExtraData);
    try
      LNewResource.Name := LAllData[1];

      LAccepted := True;
      DoAcceptResource(LAllData[0], LNewResource, LAccepted);
      if LAccepted and FindProfile(LAllData[0], LProfile) then
      begin
        InternalGetRemoteResourceValue(LNewResource, LProfile);
        DoResourceReceived(LNewResource);
      end;
    finally
      LNewResource.Free;
    end;
  end
  else if CompareText(ANotification, NotifyProfileUpdateCommand) = 0 then
  begin
    LAllData := TTetheringManagerCommand.Split(Data, TokenSep);
    if FindProfile(LAllData[0], LProfile) then
      DoRemoteProfileUpdate(LAllData[0]);
  end
  else if CompareText(ANotification, NotifyRemoteActionEndCommand) = 0 then
  begin
    LAllData := TTetheringManagerCommand.Split(Data, TokenSep);
    if Assigned(FOnASyncRemoteActionEnd) and FindProfile(LAllData[1], LProfile) then
      FOnASyncRemoteActionEnd(Self, LAllData[1], LAllData[2], TRemoteActionHandle(LAllData[3].ToInt64), LAllData[4].ToBoolean);
  end;
end;

procedure TTetheringAppProfile.NotifyProfileUpdate;
var
  LConnectedPair: TConnectedProfilePair;
  I: Integer;
begin
  for I := 0 to FConnectedManagerProfileIds.Count - 1 do
  begin
    LConnectedPair := FConnectedManagerProfileIds[I];
    Manager.SendNotification(LConnectedPair.Value, LConnectedPair.Key, NotifyProfileUpdateCommand, Identifier);
  end;
end;

procedure TTetheringAppProfile.NotifyUpdate(ALocalItem: TCustomLocalItem; const Data: string);

  function ProcessSendingData(const AData: string): string;
  begin
    Result := TNetEncoding.Base64.EncodeBytesToString(TBytes(OnBeforeSendData(Self, TByteDynArray(TEncoding.UTF8.GetBytes(AData)))));
  end;

var
  LSubscribed: TStringList;
  LManagerId: string;
  I: Integer;
  LExtraData: string;
  LConnected: Boolean;
  LProfileInfo: TTetheringProfileInfo;

begin
  if (Manager <> nil) and FSubscribedProfiles.TryGetValue(ALocalItem, LSubscribed) then
  begin
    if Data <> '' then
      LExtraData := TTetheringManagerCommand.Join(TokenSep, [Identifier, ALocalItem.Name, Data])
    else
      LExtraData := TTetheringManagerCommand.Join(TokenSep, [Identifier, ALocalItem.Name]);

    if Assigned(OnBeforeSendData) then
      LExtraData := ProcessSendingData(LExtraData);

    for I := 0 to LSubscribed.Count - 1 do
    begin
      LManagerId := FindProfileManager(LSubscribed[I]);
      LConnected := FindProfile(LSubscribed[I], LProfileInfo);
      LConnected := LConnected and IsProfileConnected(LProfileInfo);
      if (LManagerId <> '') and LConnected then
      begin
        Manager.SendNotification(LManagerId, LSubscribed[I], NotifyResourceUpdateCommand, LExtraData);
      end;
    end;
  end;
end;

function TTetheringAppProfile.InternalGetRemoteActionAsyncState(const AProfile: TTetheringProfileInfo;
  const AnAction: string): TRemoteActionState;  // the Action can be a action name or a RemoteActionHandle
var
  LResponse: TTetheringCommand;
  LConnection: TTetheringConnection;
begin
  Result := TRemoteActionState.NotFound;
  LConnection := GetConnectionTo(AProfile);
  TMonitor.Enter(LConnection);
  try
    SendCommand(LConnection, TTetheringCommand.Create(GetRemoteActionAsyncStateCommand, Version, [AnAction]));
    LResponse := ReceiveCommand(LConnection);
    if Length(LResponse.Parameters) = 1 then
      Result := TRemoteActionState(LResponse.Parameters[0].ToInteger);
  finally
    TMonitor.Exit(LConnection);
  end;
end;

function TTetheringAppProfile.InternalGetRemoteResourceValue(const ARemoteRes: TRemoteResource;
  const AProfile: TTetheringProfileInfo): TRemoteResource;
var
  LConnection: TTetheringConnection;
begin
  Result := nil;
  LConnection := GetConnectionTo(AProfile);
  TMonitor.Enter(LConnection);
  try
    try
      SendCommand(LConnection, TTetheringCommand.Create(GetResourceValueCommand, Version, [ARemoteRes.Name]));
    except
      DoCommError(AProfile);
      Exit;
    end;
    case ARemoteRes.ResType of
      TRemoteResourceType.Stream:
      begin
        if ARemoteRes.Value.AsStream <> nil then
          (ARemoteRes.Value.AsStream as TMemoryStream).Clear
        else
          ARemoteRes.Value := TMemoryStream.Create;

        Result := ARemoteRes;
        try
          if not LConnection.Protocol.ReceiveStream(ARemoteRes.Value.AsStream) then
            Result := nil
          else
            if ARemoteRes.Value.AsStream.Size = 0 then
            begin
  {$IFNDEF AUTOREFCOUNT}
              ARemoteRes.Value.AsStream.Free;
  {$ENDIF !AUTOREFCOUNT}
              ARemoteRes.Value := nil;
            end;
        except
                                     
          DoCommError(AProfile);
        end;
      end;

      TRemoteResourceType.Data:
                                                      
        Result := UpdateResourceFromJSON(ARemoteRes, LConnection.Protocol.ReceiveData, CommandsLength + 2);
    end;
  finally
    TMonitor.Exit(LConnection);
  end;
end;

function TTetheringAppProfile.GetRemoteResourceValue(const ARemoteRes: TRemoteResource): TRemoteResource;
var
  LProfile: TTetheringProfileInfo;
begin
  if FindProfileFromRemoteItem(ARemoteRes, LProfile) then
    Result := InternalGetRemoteResourceValue(ARemoteRes, LProfile)
  else raise ETetheringException.CreateFmt(SNoProfileFor, [ARemoteRes.Name]);
end;

procedure TTetheringAppProfile.OnStreamReceived(const Sender: TObject; const AProfileId: string; const AStream: TStream;
  const ADescription: string);
var
  LNewResource: TRemoteResource;
  LAccepted: Boolean;
begin
  LNewResource := CreateRemoteTempResource(TRemoteResourceType.Stream, ADescription, '', AStream);
  try
    LAccepted := True;
    DoAcceptResource(AProfileId, LNewResource, LAccepted);
    if LAccepted then
      DoResourceReceived(LNewResource);

  finally
    LNewResource.Free;
  end;
end;

procedure TTetheringAppProfile.OnStringReceived(const Sender: TObject; const AProfileId: string; const AString: string;
  const ADescription: string);
var
  LNewResource: TRemoteResource;
  LAccepted: Boolean;
begin
  LNewResource := CreateRemoteTempResource(TRemoteResourceType.Data, ADescription, AString);
  try
    LAccepted := True;
    DoAcceptResource(AProfileId, LNewResource, LAccepted);
    if LAccepted then
      DoResourceReceived(LNewResource);

  finally
    LNewResource.Free;
  end;
end;

procedure TTetheringAppProfile.RegisterAction(const AnAction: TContainedAction; const AName: string);
var
  LRealName: string;
  LAction: TLocalAction;
begin
  if AName <> '' then
    LRealName := AName
  else
    LRealName := AnAction.Name;

  LAction := FSharedActions.Add;

  LAction.Profile := Self;
  LAction.SetAction(AnAction);
  LAction.IsPublic := True;
  LAction.Name := LRealName;
end;

function TTetheringAppProfile.CreateResource(const AName: string; AResType: TRemoteResourceType;
  AValue: TResourceValue): TLocalResource;
begin
  Result := FSharedResources.Add;
  Result.FResType := AResType;
  Result.FResValue := AValue;
  Result.FIsPublic := True;
  Result.Name := AName;
end;

function TTetheringAppProfile.InternalRunRemoteAction(const AProfile: TTetheringProfileInfo; const AnActionName: string): Boolean;
var
  LResponse: TTetheringCommand;
  LConnection: TTetheringConnection;
begin
  LConnection := GetConnectionTo(AProfile);
  TMonitor.Enter(LConnection);
  try
    SendCommand(LConnection, TTetheringCommand.Create(RunActionCommand, Version, [AnActionName]));
    repeat
      LResponse := ReceiveCommand(LConnection);
    until LResponse.Command <> ResponseCommandAlive;
  finally
    TMonitor.Exit(LConnection);
  end;
  Result := LResponse.Command = RunActionResponseOKCommand;
end;

function TTetheringAppProfile.InternalRunRemoteActionAsync(const AProfile: TTetheringProfileInfo;
  const AnActionName: string): TRemoteActionHandle;
var
  LResponse: TTetheringCommand;
  LConnection: TTetheringConnection;
begin
  Result := InvalidRemoteHandle;
  LConnection := GetConnectionTo(AProfile);
  TMonitor.Enter(LConnection);
  try
    SendCommand(LConnection, TTetheringCommand.Create(RunActionAsyncCommand, Version, [Manager.Identifier, Identifier, AnActionName]));
    LResponse := ReceiveCommand(LConnection);
    if Length(LResponse.Parameters) = 1 then
      Result := TRemoteActionHandle(LResponse.Parameters[0].ToInt64);
  finally
    TMonitor.Exit(LConnection);
  end;
end;

function TTetheringAppProfile.RunRemoteAction(const AProfile: TTetheringProfileInfo; const AnActionName: string): Boolean;
var
  Actions: TObjectList<TCustomRemoteItem>;
  I: Integer;
  TargetAction: TRemoteAction;
begin
  if FRemoteItems.TryGetValue(AProfile, Actions) then
  begin
    TargetAction := nil;
    for I := 0 to Actions.Count - 1 do
    begin
      if (Actions[I].ItemType = TTetheringRemoteItemType.Action) and
         (string.Compare(Actions[I].Name, AnActionName, [coIgnoreCase]) = 0) then
      begin
        TargetAction := Actions[I] as TRemoteAction;
        Break;
      end;
    end;

    if TargetAction <> nil then
      Result := InternalRunRemoteAction(AProfile, TargetAction.Name)
    else
      raise ETetheringException.CreateFmt(SNoProfileForAction, [AnActionName]);
  end
  else
    raise ETetheringException.CreateFmt(SNoProfileForAction, [AnActionName]);
end;

function TTetheringAppProfile.RunRemoteActionAsync(const AProfile: TTetheringProfileInfo;
  const AnActionName: string): TRemoteActionHandle;
var
  Actions: TObjectList<TCustomRemoteItem>;
  I: Integer;
  TargetAction: TRemoteAction;
begin
  if FRemoteItems.TryGetValue(AProfile, Actions) then
  begin
    TargetAction := nil;
    for I := 0 to Actions.Count - 1 do
    begin
      if (Actions[I].ItemType = TTetheringRemoteItemType.Action) and
         (string.Compare(Actions[I].Name, AnActionName, [coIgnoreCase]) = 0) then
      begin
        TargetAction := Actions[I] as TRemoteAction;
        Break;
      end;
    end;

    if TargetAction <> nil then
      Result := InternalRunRemoteActionAsync(AProfile, TargetAction.Name)
    else
      raise ETetheringException.CreateFmt(SNoProfileForAction, [AnActionName]);
  end
  else
    raise ETetheringException.CreateFmt(SNoProfileForAction, [AnActionName]);
end;

function TTetheringAppProfile.RunRemoteActionAsync(const AnAction: TRemoteAction): TRemoteActionHandle;
var
  LProfile: TTetheringProfileInfo;
begin
  if FindProfileFromRemoteItem(AnAction, LProfile) then
    Result := InternalRunRemoteActionAsync(LProfile, AnAction.Name)
  else
    raise ETetheringException.CreateFmt(SNoProfileForAction, [AnAction.Name]);
end;

function TTetheringAppProfile.RunRemoteAction(const AnAction: TRemoteAction): Boolean;
var
  LProfile: TTetheringProfileInfo;
begin
  if FindProfileFromRemoteItem(AnAction, LProfile) then
    Result := InternalRunRemoteAction(LProfile, AnAction.Name)
  else
    raise ETetheringException.CreateFmt(SNoProfileForAction, [AnAction.Name]);
end;

{ TRemoteResource }

function TRemoteResource.ToBytes: TBytes;
var
  JSON: TJSONObject;
  Len: Integer;
begin
  JSON := MarshalToJSON;
  try
    SetLength(Result, JSON.EstimatedByteSize);
    Len := JSON.ToBytes(Result, 0);
    SetLength(Result, Len);
  finally
    JSON.Free;
  end;
end;

function TRemoteResource.ToJsonString: string;
begin
  Result := TEncoding.UTF8.GetString(ToBytes);
end;

procedure TRemoteResource.UpdateValue(ADataType: TResourceType; const AJSONValue: TJSONValue);
var
  LSingle: Single;
begin
  FValue.FDataType := ADataType;
  case ADataType of
    TResourceType.Boolean:
      FValue := Boolean((AJSONValue as TJSONNumber).AsInt);

    TResourceType.Integer:
      FValue := (AJSONValue as TJSONNumber).AsInt;

    TResourceType.Double:
      FValue := (AJSONValue as TJSONNumber).AsDouble;

    TResourceType.Single:
    begin
      LSingle := (AJSONValue as TJSONNumber).AsDouble;
      FValue := LSingle;
      //FValue := Single((AJSONValue as TJSONNumber).AsDouble);
    end;

    TResourceType.Int64:
      FValue := (AJSONValue as TJSONNumber).AsInt64;

    TResourceType.String:
      FValue := (AJSONValue as TJSONString).Value;
  end;
end;

constructor TRemoteResource.Create;
begin
  inherited;
  FNotifyUpdates := True;
  ResType := TRemoteResourceType.Data;
  FItemType := TTetheringRemoteItemType.Resource;
end;

destructor TRemoteResource.Destroy;
begin
  if FResType = TRemoteResourceType.Stream then
    FValue.FStream.Free;

  inherited;
end;

function TRemoteResource.MarshalToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair(AppProfileResourceType, TJSONNumber.Create(Integer(Self.ResType)));
  FValue.AddToJsonObject(Result);
end;

procedure TRemoteResource.SetValue(const Value: TResourceValue);
begin
  FValue := Value;
  if FNotifyUpdates then
    Broadcast;
end;


{ TResourceValue }

class operator TResourceValue.Implicit(Value: Boolean): TResourceValue;
begin
  Result.DataType := TResourceType.Boolean;
  Result.FSimpleValue.FBoolean := Value;
end;

class operator TResourceValue.Implicit(Value: Int64): TResourceValue;
begin
  Result.DataType := TResourceType.Int64;
  Result.FSimpleValue.FInt64 := Value;
end;

class operator TResourceValue.Implicit(Value: Integer): TResourceValue;
begin
  Result.DataType := TResourceType.Integer;
  Result.FSimpleValue.FInteger := Value;
end;

class operator TResourceValue.Implicit(Value: Single): TResourceValue;
begin
  Result.DataType := TResourceType.Single;
  Result.FSimpleValue.FSingle := Value;
end;

class operator TResourceValue.Implicit(Value: Double): TResourceValue;
begin
  Result.DataType := TResourceType.Double;
  Result.FSimpleValue.FDouble := Value;
end;

class operator TResourceValue.Implicit(const Value: string): TResourceValue;
begin
  Result.DataType := TResourceType.String;
  Result.FString := Value;
end;

class operator TResourceValue.Implicit(const Value: TStream): TResourceValue;
begin
  Result.FStream := Value;
end;

procedure TResourceValue.AddToJsonObject(const AJSonObject: TJSONObject);
begin
  AJSonObject.AddPair(AppProfileDataType, TJSONNumber.Create(Integer(FDataType)));
  case FDataType of
    TResourceType.Integer:
      AJSonObject.AddPair(AppProfileValue, TJSONNumber.Create(Self.AsInteger));

    TResourceType.Double:
      AJSonObject.AddPair(AppProfileValue, TJSONNumber.Create(Self.AsDouble));

    TResourceType.Single:
      AJSonObject.AddPair(AppProfileValue, TJSONNumber.Create(Self.AsSingle));

    TResourceType.Int64:
      AJSonObject.AddPair(AppProfileValue, TJSONNumber.Create(Self.AsInt64));

    TResourceType.Boolean:
      AJSonObject.AddPair(AppProfileValue, TJSONNumber.Create(Self.AsInteger));

    TResourceType.String:
      AJSonObject.AddPair(AppProfileValue, TJSONString.Create(Self.AsString));
  else
    raise ETetheringException.Create(SNoResourceValue);
  end;
end;

constructor TResourceValue.Create(const Value: string);
begin
  FString := Value;
  DataType := TResourceType.String;
end;

constructor TResourceValue.Create(Value: Integer);
begin
  DataType := TResourceType.Integer;
  FSimpleValue.FInteger := Value;
end;

constructor TResourceValue.Create(Value: Int64);
begin
  DataType := TResourceType.Int64;
  FSimpleValue.FInt64 := Value;
end;

constructor TResourceValue.Create(Value: Boolean);
begin
  DataType := TResourceType.Boolean;
  FSimpleValue.FBoolean := Value;
end;

constructor TResourceValue.Create(const Value: TStream);
begin
  FStream := Value;
end;

constructor TResourceValue.Create(Value: Single);
begin
  DataType := TResourceType.Single;
  FSimpleValue.FSingle := Value;
end;

constructor TResourceValue.Create(Value: Double);
begin
  DataType := TResourceType.Double;
  FSimpleValue.FDouble := Value;
end;

function TResourceValue.GetBoolean: Boolean;
begin
  Result := FSimpleValue.FBoolean;
end;

function TResourceValue.GetDouble: Double;
begin
  Result := FSimpleValue.FDouble;
end;

function TResourceValue.GetInt64: Int64;
begin
  Result := FSimpleValue.FInt64;
end;

function TResourceValue.GetInteger: Integer;
begin
  Result := FSimpleValue.FInteger;
end;

function TResourceValue.GetSingle: Single;
begin
  Result := FSimpleValue.FSingle;
end;


{ TCustomRemoteItem }

procedure TCustomRemoteItem.Broadcast;
begin

end;

constructor TCustomRemoteItem.Create;
begin
  inherited Create;
  FProfile := nil;
  IsPublic := True;
  IsTemp := False;
  FKind := TTetheringRemoteKind.Shared;
end;

destructor TCustomRemoteItem.Destroy;
begin
  FProfile := nil;
  inherited;
end;

procedure TCustomRemoteItem.SetProfile(const Value: TTetheringAppProfile);
begin
  if FProfile <> Value then
    FProfile := Value;
end;

{ TLocalAction }

procedure TLocalAction.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TLocalAction then
  begin
    FAction := TLocalAction(Source).FAction;
    FOldUpdate := TLocalAction(Source).FOldUpdate;
    FOldExecute := TLocalAction(Source).FOldExecute;
  end;
end;

constructor TLocalAction.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  Profile := ACollection.Owner as TTetheringAppProfile;
end;

destructor TLocalAction.Destroy;
begin
  if FAction <> nil then
  begin
    FAction.OnUpdate := FOldUpdate;
    FAction.OnExecute := FOldExecute;
    FAction := nil;
  end;
  inherited;
end;

procedure TLocalAction.DoExecute(Sender: TObject);
var
  LProfileInfo: TTetheringProfileInfo;
  LResourceList: TObjectList<TCustomRemoteItem>;
  I: Integer;
begin
  if FKind = TTetheringRemoteKind.Mirror then
    for LProfileInfo in FProfile.FConnectedProfiles do
      if (FProfile.Group <> '') and (string.Compare(LProfileInfo.ProfileGroup, FProfile.Group, [coIgnoreCase]) = 0) then
        if FProfile.FRemoteItems.TryGetValue(LProfileInfo, LResourceList) then
          for I := 0 to LResourceList.Count - 1 do
            if (LResourceList[I].FItemType = TTetheringRemoteItemType.Action) and
               (LResourceList[I].FKind = TTetheringRemoteKind.Shared) and
               (string.Compare(LResourceList[I].FName, FName, [coIgnoreCase]) = 0) then
              FProfile.RunRemoteAction(LProfileInfo, Self.FName);

  if Assigned(FOldExecute) then
    FOldExecute(Sender);
end;

function TLocalAction.GetDisplayName: string;
begin
  Result := Format(SLocalAction, [Index]);
end;

function TLocalAction.MarshalToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair(AppProfileActionEnabled, TJSONBool.Create(FActionEnabled));
  Result.AddPair(AppProfileActionCaption, TJSONString.Create(FActionCaption));
  Result.AddPair(AppProfileActionHint, TJSONString.Create(FHint));
end;

procedure TLocalAction.SetAction(const Value: TContainedAction);
begin
  if (FAction <> Value) and (FAction <> nil) then
    FAction.RemoveFreeNotification(FProfile);
  if not (csDesigning in FProfile.ComponentState) then
  begin
    // Assign old OnUpdate value to the Action
    if FAction <> nil then
    begin
      FAction.OnUpdate := FOldUpdate;
      FAction.OnExecute := FOldExecute;
      FOldUpdate := nil;
      FOldExecute := nil;
    end;

    if FAction <> Value then
    begin
      FAction := Value;
      if FAction <> nil then
      begin
        FOldUpdate := FAction.OnUpdate;
        FOldExecute := FAction.OnExecute;
        FAction.OnUpdate := UpdateActionStatus;
        FAction.OnExecute := DoExecute;
        FActionEnabled := FAction.Enabled;
        FActionCaption := FAction.Caption;
      end
      else
        FActionEnabled := False;
      if (FAction <> nil) and (FName <> '') and FIsPublic and FProfile.NotifyProfileUpdates then
        FProfile.NotifyProfileUpdate;
    end;
  end
  else
    FAction := Value;
  if (FAction <> nil) then
    FAction.FreeNotification(FProfile);
  if (Value <> nil) and (FName = '') then
    FName := Value.Name;
end;

procedure TLocalAction.UpdateActionStatus(Sender: TObject);
begin
  if NotifyUpdates and (FActionEnabled <> FAction.Enabled) then
  begin
    FActionEnabled := FAction.Enabled;
    BroadCast;
  end;
  if Assigned(FOldUpdate) then
    FOldUpdate(Sender);
end;


{ TRemoteAction }

constructor TRemoteAction.Create;
begin
  inherited;
  FItemType := TTetheringRemoteItemType.Action;
  Enabled := True;
end;

procedure TRemoteAction.Execute;
begin
  FProfile.RunRemoteAction(Self);
end;

{ TLocalActionCollection }

function TActionCollection.Add: TLocalAction;
begin
  Result := TLocalAction(inherited Add);
end;

constructor TActionCollection.Create(AOwner: TComponent; ItemClass: TCollectionItemClass);
begin
  inherited Create(AOwner, ItemClass);
end;

function TActionCollection.FindByName(const AnActionName: string): TLocalAction;
var
  I: Integer;
  LAction: TLocalAction;
begin
  for I := 0 to Self.Count - 1 do
  begin
    LAction := Items[I];
    if string.Compare(AnActionName, LAction.FName, [coIgnoreCase]) = 0 then
      Exit(LAction);
  end;
  Result := nil;
end;

function TActionCollection.GetItem(Index: Integer): TLocalAction;
begin
  Result := TLocalAction(inherited GetItem(Index));
end;

function TActionCollection.Insert(Index: Integer): TLocalAction;
begin
  Result := TLocalAction(inherited Insert(Index));
end;

procedure TActionCollection.SetItem(Index: Integer; Value: TLocalAction);
begin
  inherited SetItem(Index, Value);
end;


{ TCustomLocalItem }

procedure TCustomLocalItem.Assign(Source: TPersistent);
begin
  if Source is TCustomLocalItem then
    FProfile := TCustomLocalItem(Source).FProfile
  else
    inherited Assign(Source);
end;

procedure TCustomLocalItem.Broadcast;
begin
  if (FProfile <> nil) then
    FProfile.NotifyUpdate(Self, Self.ToJsonString);
end;

constructor TCustomLocalItem.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FIsPublic := True;
end;

function TCustomLocalItem.GetDisplayName: string;
begin
  Result := Format(SCustomLocalAction, [Index]);
end;

procedure TCustomLocalItem.SetIsPublic(const Value: Boolean);
begin
  if FIsPublic <> Value then
  begin
    FIsPublic := Value;
    if (FName <> '') and FIsPublic and FProfile.NotifyProfileUpdates then
      FProfile.NotifyProfileUpdate
  end;
end;

procedure TCustomLocalItem.SetName(const Value: string);
begin
  FName := Value;
  if (FName <> '') and FIsPublic and FProfile.NotifyProfileUpdates then
    FProfile.NotifyProfileUpdate;
end;

procedure TCustomLocalItem.SetKind(const Value: TTetheringRemoteKind);
begin
  if FKind <> Value then
  begin
    FKind := Value;
    if (FName <> '') and FIsPublic and FProfile.NotifyProfileUpdates then
      FProfile.NotifyProfileUpdate
  end;
end;

procedure TCustomLocalItem.SetProfile(const Value: TTetheringAppProfile);
begin
  if FProfile <> Value then
  begin
    FProfile := Value;
    if (FName <> '') and FIsPublic and FProfile.NotifyProfileUpdates then
      FProfile.NotifyProfileUpdate
  end;
end;

function TCustomLocalItem.ToBytes: TBytes;
var
  JSON: TJSONObject;
  Len: Integer;
begin
  JSON := MarshalToJSON;
  try
    SetLength(Result, JSON.EstimatedByteSize);
    Len := JSON.ToBytes(Result, 0);
    SetLength(Result, Len);
  finally
    JSON.Free;
  end;
end;

function TCustomLocalItem.ToJsonString: string;
begin
  Result := TEncoding.UTF8.GetString(ToBytes);
end;

{ TLocalResource }

procedure TLocalResource.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TLocalResource then
  begin
    FName := TLocalResource(Source).FName;
    FResType := TLocalResource(Source).FResType;
    FResValue := TLocalResource(Source).FResValue;
    FHint := TLocalResource(Source).FHint;
  end;
end;

constructor TLocalResource.Create(ACollection: TCollection);
begin
  inherited;
  Profile := ACollection.Owner as TTetheringAppProfile;
  FResType := TRemoteResourceType.Data;
end;

destructor TLocalResource.Destroy;
begin
{$IFNDEF AUTOREFCOUNT}
  if FResType = TRemoteResourceType.Stream then
    FResValue.FStream.Free;
{$ENDIF AUTOREFCOUNT}
  inherited;
end;

procedure TLocalResource.DoResourceReceived(const AResource: TRemoteResource);
begin
  if Assigned(FOnResourceReceived) then
    TThread.Synchronize(nil,
      procedure
      begin
        FOnResourceReceived(Self, AResource);
      end
    );
end;

function TLocalResource.GetDisplayName: string;
begin
  Result := Format(SLocalResource, [Index]);
end;

procedure TLocalResource.SetResType(const Value: TRemoteResourceType);
begin
  if FResType <> Value then
  begin
    FResType := Value;
    if (FName <> '') and FIsPublic and FProfile.NotifyProfileUpdates then
      FProfile.NotifyProfileUpdate;
  end;
end;

procedure TLocalResource.SetValue(const Value: TResourceValue);
begin
{$IFNDEF AUTOREFCOUNT}
  if FResType = TRemoteResourceType.Stream then
    FResValue.FStream.Free;
{$ENDIF AUTOREFCOUNT}
  FResValue := Value;
{$IFNDEF AUTOREFCOUNT}
  if (FResType = TRemoteResourceType.Stream) and (Value.FStream <> nil) then
  begin
    FResValue.FStream := TMemoryStream.Create;
    FResValue.FStream.CopyFrom(Value.FStream, Value.FStream.Size);
  end;
{$ENDIF AUTOREFCOUNT}
  Broadcast;
end;

function TLocalResource.MarshalToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair(AppProfileResourceType, TJSONNumber.Create(Integer(Self.ResType)));
  FResValue.AddToJsonObject(Result);
end;


{ TLocalResourceCollection }

function TResourceCollection.Add: TLocalResource;
begin
  Result := TLocalResource(inherited Add);
end;

constructor TResourceCollection.Create(AOwner: TComponent; ItemClass: TCollectionItemClass);
begin
  inherited Create(AOwner, ItemClass);
end;

function TResourceCollection.FindByName(const AResName: string): TLocalResource;
var
  I: Integer;
  LResource: TLocalResource;
begin
  for I := 0 to Self.Count - 1 do
  begin
    LResource := Items[I];
    if string.Compare(AResName, LResource.FName, [coIgnoreCase]) = 0 then
      Exit(LResource);
  end;
  Result := nil;
end;

function TResourceCollection.GetItem(Index: Integer): TLocalResource;
begin
  Result := TLocalResource(inherited GetItem(Index));
end;

function TResourceCollection.Insert(Index: Integer): TLocalResource;
begin
  Result := TLocalResource(inherited Insert(Index));
end;

procedure TResourceCollection.SetItem(Index: Integer; Value: TLocalResource);
begin
  inherited SetItem(Index, Value);
end;

{ TProfileComparer }

function TProfileComparer.Equals(const Left, Right: TTetheringProfileInfo): Boolean;
begin
  Result := (Left.ManagerIdentifier = Right.ManagerIdentifier) and (Left.ProfileIdentifier = Right.ProfileIdentifier);
end;

function TProfileComparer.GetHashCode(const Value: TTetheringProfileInfo): Integer;
begin
  Result := (Value.ManagerIdentifier + Value.ProfileIdentifier).GetHashCode;
end;

class function TProfileComparer.GetInstance: IEqualityComparer<TTetheringProfileInfo>;
begin
  Result := TProfileComparer.Create;
end;

initialization
  TTetheringProfiles.RegisterProfile(TTetheringAppProfile, TTetheringAppProfile.AppProfileID);
  TTetheringProfiles.RegisterProfileProtocolAdapter(TTetheringAppProfile.AppProfileID, TTetheringTCPProtocol.ProtocolID,
    TTetheringNetworkAdapterMulticast_V6.AdapterID);
  TTetheringProfiles.RegisterProfileProtocolAdapter(TTetheringAppProfile.AppProfileID, TTetheringTCPProtocol.ProtocolID,
    TTetheringNetworkAdapterMulticast_V4.AdapterID);
  TTetheringProfiles.RegisterProfileProtocolAdapter(TTetheringAppProfile.AppProfileID, TTetheringTCPProtocol.ProtocolID,
    TTetheringNetworkAdapterV4_UDP.AdapterID);
{$IFNDEF IOS}
  TTetheringProfiles.RegisterProfileProtocolAdapter(TTetheringAppProfile.AppProfileID, TTetheringTCPProtocol.ProtocolID,
    TTetheringBluetoothAdapter.AdapterID);
{$ENDIF}

finalization
{$IFNDEF IOS}
  TTetheringProfiles.UnRegisterProfileProtocolAdapter(TTetheringAppProfile.AppProfileID, TTetheringTCPProtocol.ProtocolID,
    TTetheringBluetoothAdapter.AdapterID);
{$ENDIF}
  TTetheringProfiles.UnRegisterProfileProtocolAdapter(TTetheringAppProfile.AppProfileID, TTetheringTCPProtocol.ProtocolID,
    TTetheringNetworkAdapterV4_UDP.AdapterID);
  TTetheringProfiles.UnRegisterProfileProtocolAdapter(TTetheringAppProfile.AppProfileID, TTetheringTCPProtocol.ProtocolID,
    TTetheringNetworkAdapterMulticast_V4.AdapterID);
  TTetheringProfiles.UnRegisterProfileProtocolAdapter(TTetheringAppProfile.AppProfileID, TTetheringTCPProtocol.ProtocolID,
    TTetheringNetworkAdapterMulticast_V6.AdapterID);
  TTetheringProfiles.UnRegisterProfile(TTetheringAppProfile.AppProfileID);
end.
