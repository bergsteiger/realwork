{*******************************************************}
{                                                       }
{           Delphi FireMonkey Mobile Services           }
{                                                       }
{       Description of interface for phone dialer       }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.PhoneDialer;

interface

type

{ TCarrier }

  TCarrier = class;
  TOnCarrierChanged = procedure (ACarrier: TCarrier) of object;

  /// <summary>
  ///   This class obtains information about the user’s home
  ///   cellular service provider, such as its unique identifier and whether.
  /// </summary>
  TCarrier = class abstract
  strict private
    FOnCarrierChanged: TOnCarrierChanged;
  protected
    procedure DoCarrierChanged(const ACarrier: TCarrier); virtual;
  public
    /// <summary>
    ///   Get ISO country code of the sim-operator
    /// </summary>
    /// <remarks>
    ///   See additional info on <see href="http://en.wikipedia.org/wiki/ISO_3166-1"/>
    /// </remarks>
    function GetIsoCountryCode: string; virtual; abstract;
    /// <summary>
    ///   Get mobile Country Code
    /// </summary>
    /// <remarks>
    ///   See additional info on <see href="http://en.wikipedia.org/wiki/Mobile_country_code"/>
    /// </remarks>
    function GetMobileCountryCode: string; virtual; abstract;
    /// <summary>
    ///   Get mobile Network Code
    /// </summary>
    function GetMobileNetwork: string; virtual; abstract;
    /// <summary>
    ///   Get carrier name
    /// </summary>
    function GetCarrierName: string; virtual; abstract;
    /// <summary>
    ///  Event of tracing of change of the operator
    /// </summary>
    property OnCarrierChanged: TOnCarrierChanged read FOnCarrierChanged write FOnCarrierChanged;
  end;

{ TCall }

  TCallState = (csNone, csConnected, csIncoming, csDialing, csDisconnected);

  /// <summary>
  ///   This class is uses for obtaining an identifier for the call and to determine the call’s state.
  /// </summary>
  TCall = class abstract
  public
    function GetCallState: TCallState; virtual; abstract;
    function GetCallID: string; virtual; abstract;
  end;

  TCalls = array of TCall;

{ IFMXPhoneDialerService }

  TOnCallStateChanged = procedure (const ACallID: string; const AState: TCallState) of object;

  /// <summary>
  ///   Interface of Phone Dialer
  /// </summary>
  IFMXPhoneDialerService = interface (IInterface)
    ['{61EE0E7A-7643-4966-873E-384CF798E694}']
    /// <summary>
    ///   Make a call by specified number
    /// </summary>
    function Call(const APhoneNumber: string): Boolean;
    /// <summary>
    ///   Get current carrier
    /// </summary>
    /// <remarks>
    ///   The object the Carrier is deleted automatically with deleting service
    /// </remarks>
    function GetCarrier: TCarrier;
    /// <summary>
    ///   Get all curtrent calls. If the current calls aren't present, the array will be empty
    /// </summary>
    /// <remarks>
    ///   The developer shall delete array cells after use
    /// </remarks>
    function GetCurrentCalls: TCalls;
    /// <summary>
    ///   Getter, Setter and property for work with event of tracing of state change of a call
    /// </summary>
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

{$IFDEF IOS}
uses
  FMX.PhoneDialer.iOS;
{$ENDIF}

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

{$IFDEF IOS}
initialization
  RegisterPhoneDialerService;
{$ENDIF}

end.
