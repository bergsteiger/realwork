{*******************************************************}
{                                                       }
{           Delphi FireMonkey Mobile Services           }
{                                                       }
{       Description of interface for phone dialer       }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$IF Defined(IOS) OR Defined(ANDROID)}
{$HPPEMIT LINKUNIT}
{$ENDIF}
unit FMX.PhoneDialer;

interface

{$SCOPEDENUMS ON}

type

{ TCarrier }

  TCarrier = class;
  TOnCarrierChanged = procedure (ACarrier: TCarrier) of object;

  { This class obtains information about the user’s home
    cellular service provider, such as its unique identifier and whether. }
  TCarrier = class abstract
  strict private
    FOnCarrierChanged: TOnCarrierChanged;
  protected
    procedure DoCarrierChanged(const ACarrier: TCarrier); virtual;
  public
    // Get ISO country code of the sim-operator
    // See: "http://en.wikipedia.org/wiki/ISO_3166-1"
    function GetIsoCountryCode: string; virtual; abstract;
    // Get mobile Country Code (MCC)
    // See: "http://en.wikipedia.org/wiki/Mobile_country_code"
    function GetMobileCountryCode: string; virtual; abstract;
    // Get mobile Network Code (MNC)
    // See: "http://en.wikipedia.org/wiki/Mobile_country_code"
    function GetMobileNetwork: string; virtual; abstract;
    // Get carrier name
    function GetCarrierName: string; virtual; abstract;
    // Event of tracing of change of the operator
    property OnCarrierChanged: TOnCarrierChanged read FOnCarrierChanged write FOnCarrierChanged;
  end;

{ TCall }

  TCallState = (None, Connected, Incoming, Dialing, Disconnected);

  TCallStateHelper = record helper for TCallState
  const
    csNone = TCallState.None deprecated 'Use TCallState.None';
    csConnected = TCallState.Connected deprecated 'Use TCallState.Connected';
    csIncoming = TCallState.Incoming deprecated 'Use TCallState.Incoming';
    csDialing = TCallState.Dialing deprecated 'Use TCallState.Dialing';
    csDisconnected = TCallState.Disconnected deprecated 'Use TCallState.Disconnected';
  end;

  { This class is uses for obtaining an identifier for the call and to determine the call’s state. }
  TCall = class abstract
  public
    function GetCallState: TCallState; virtual; abstract;
    function GetCallID: string; virtual; abstract;
  end;

  TCalls = array of TCall;

{ IFMXPhoneDialerService }

  TOnCallStateChanged = procedure (const ACallID: string; const AState: TCallState) of object;

  { Interface of Phone Dialer }
  IFMXPhoneDialerService = interface (IInterface)
    ['{61EE0E7A-7643-4966-873E-384CF798E694}']
    // Make a call by specified number
    function Call(const APhoneNumber: string): Boolean;
    // Get current carrier
    // The object the Carrier is deleted automatically with deleting service
    function GetCarrier: TCarrier;
    // Get all curtrent calls. If the current calls aren't present, the array will be empty
    // The developer shall delete array cells after use
    function GetCurrentCalls: TCalls;
    // Getter, Setter and property for work with event of tracing of state change of a call
    function GetOnCallStateChanged: TOnCallStateChanged;
    procedure SetOnCallStateChanged(const AEvent: TOnCallStateChanged);
    property OnCallStateChanged: TOnCallStateChanged read GetOnCallStateChanged write SetOnCallStateChanged;
  end;

{ TPhoneDialerService }

  TPhoneDialerService = class abstract (TInterfacedObject, IFMXPhoneDialerService)
  strict private
    FOnCallStateChanged: TOnCallStateChanged;
    function GetOnCallStateChanged: TOnCallStateChanged;
    procedure SetOnCallStateChanged(const AEvent: TOnCallStateChanged);
  protected
    procedure DoCallStateChanged(const ACallID: string; const AState: TCallState); virtual;
  public
    function Call(const APhoneNumber: string): Boolean; virtual; abstract;
    function GetCarrier: TCarrier; virtual; abstract;
    function GetCurrentCalls: TCalls; virtual; abstract;
    property OnCallStateChanged: TOnCallStateChanged read GetOnCallStateChanged write SetOnCallStateChanged;
  end;

implementation

uses
{$IFDEF IOS}
  FMX.PhoneDialer.iOS,
{$ENDIF}
{$IFDEF ANDROID}
  FMX.PhoneDialer.Android,
{$ENDIF}
  System.TypInfo;

{ TPhoneDialerService }

procedure TPhoneDialerService.DoCallStateChanged(const ACallID: string; const AState: TCallState);
begin
  if Assigned(FOnCallStateChanged) then
    FOnCallStateChanged(ACallID, AState);
end;

function TPhoneDialerService.GetOnCallStateChanged: TOnCallStateChanged;
begin
  Result := FOnCallStateChanged;
end;

procedure TPhoneDialerService.SetOnCallStateChanged(const AEvent: TOnCallStateChanged);
begin
  FOnCallStateChanged := AEvent;
end;

{ TCarrier }

procedure TCarrier.DoCarrierChanged(const ACarrier: TCarrier);
begin
  if Assigned(FOnCarrierChanged) then
    FOnCarrierChanged(ACarrier);
end;

procedure RegisterAliases;
begin
  AddEnumElementAliases(TypeInfo(TCallState), ['csNone', 'csConnected', 'csIncoming', 'csDialing', 'csDisconnected']);
end;

procedure UnregisterAliases;
begin
  RemoveEnumElementAliases(TypeInfo(TCallState));
end;

initialization
  RegisterAliases;
{$IF Defined(IOS) OR Defined(ANDROID)}
  RegisterPhoneDialerService;
{$ENDIF}

finalization
  UnregisterAliases;
end.
