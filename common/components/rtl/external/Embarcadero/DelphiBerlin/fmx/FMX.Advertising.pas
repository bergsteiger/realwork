{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit FMX.Advertising;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.SysUtils, FMX.Controls, FMX.Types;

type
  EAdvertisingError = class(Exception);

  TCustomBannerAd = class;

  ICommonAd = interface(IInterface)
    ['{21350E71-EEBD-4476-9984-8714700D60C1}']
    procedure CancelAction;
    function IsActionInProgress: Boolean;
    function IsLoaded: Boolean;
    //Android only
    function GetAdUnitID: string;
    procedure SetAdUnitID(const Value: string);
    procedure LoadAd;
    property AdUnitID: string read GetAdUnitID write SetAdUnitID;
  end;

  IBannerAd = interface(ICommonAd)
    ['{E2432D16-1FFA-41F8-964A-76F4ADFB0020}']
    procedure SetBannerAdControl(const AValue: TCustomBannerAd);
    function GetParent: TFmxObject;
    function GetVisible: Boolean;
    procedure Show;
    procedure Hide;
    procedure UpdateContentFromControl;
  end;

  IFMXAdvertisingService = interface(IInterface)
    ['{CFDCA239-A3B8-428D-94A5-4C7E4D50E398}']
    function CreateBannerAd(const AOwner: TCustomBannerAd): IBannerAd;
    procedure RemoveAd(const Ad: ICommonAd);
  end;

  IFMXAdvertisingTestModeService = interface(IInterface)
    ['{6030094F-647F-423F-8D61-A2BCF13BFDB4}']
    procedure SetTestMode(AValue: Boolean);
    function GetTestMode: Boolean;
    procedure SetTestModeDeviceID(const ADeviceID: string);
  end;

  /// <summary>
  ///   Event type for
  ///   <see cref="FMX.Advertising|TCustomBannerAd.OnActionCanBegin" />
  /// </summary>
  /// <param name="Sender">
  ///   The <see cref="FMX.Advertising|TCustomBannerAd" /> that triggered
  ///   this event
  /// </param>
  /// <param name="WillLeaveApplication">
  ///   A reference parameter that controls (on Android only) whether an
  ///   ad's action can proceed. The action occurs when the user taps a
  ///   banner ad and typically involves launching a full-screen ad.
  /// </param>
  /// <remarks>
  ///   This event fires on both Android and on iOS. However the
  ///   reference parameter that controls whether the ad action can
  ///   proceed is only supported on iOS.
  /// </remarks>
  /// <seealso cref="TCustomBannerAd.OnActionCanBegin" />
  TAdActionCanBeginEvent = procedure(Sender: TObject; var WillLeaveApplication: Boolean) of object;
  /// <summary>
  ///   An event type that is used for
  ///   <see cref="FMX.Advertising|TCustomBannerAd.OnDidFail" /> to
  ///   indicate a failure is producing an ad.
  /// </summary>
  /// <param name="Sender">
  ///   The <see cref="FMX.Advertising|TCustomBannerAd" /> that triggered
  ///   this event
  /// </param>
  /// <param name="Error">
  ///   An error message that describes the failure
  /// </param>
  /// <seealso cref="TCustomBannerAd.OnDidFail" />
  TAdDidFailEvent = procedure(Sender: TObject; const Error: string) of object;

  TBannerAdSize = (Auto, Small, Medium, Large);

  /// <summary>
  ///   Base class for TBannerAd component class
  /// </summary>
  /// <seealso cref="TBannerAd">
  ///   TBannerAd
  /// </seealso>
  TCustomBannerAd = class(TControl)
  private
    FAd: IBannerAd;
    FAdService : IFMXAdvertisingService;
    FOnActionCanBegin: TAdActionCanBeginEvent;
    FOnActionDidFinish: TNotifyEvent;
    FOnWillLoad: TNotifyEvent;
    FOnDidLoad: TNotifyEvent;
    FOnDidFail: TAdDidFailEvent;
    FTestMode: Boolean;
    FAdSize: TBannerAdSize;
    procedure UpdateContent;
  protected
    procedure Move; override;
    procedure Resize; override;
    procedure Paint; override;
    procedure SetParent(const Value: TFmxObject); override;

   	// Advert property getters/setters
    function GetAdUnitID: string;
    procedure SetAdUnitID(const Value: string);
    procedure SetTestMode(AValue: Boolean);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Show; override;
    procedure Hide; override;

    procedure DoActionCanBegin(var WillLeaveApplication: Boolean);
    procedure DoActionDidFinish;
    procedure DoWillLoad;
    procedure DoDidLoad;
    procedure DoDidFail(const Error: string);

    // Advert functionality

    /// <summary>
    ///   iOS only. Banner ad's initiate an action when tapped,
    ///   typically a full- screen advert. This method cancels that
    ///   action, if supported.
    /// </summary>
    /// <remarks>
    ///   This function is supported on iOS only. Android does not
    ///   support this behavior.
    /// </remarks>
    procedure CancelAction;
    /// <summary>
    ///   Banner ads initiate an action when tapped, typically a full-
    ///   screen advert. This function tells you if such an action is
    ///   in progress.
    /// </summary>
    function IsActionInProgress: Boolean;
    /// <summary>
    ///   This function indicates if the ad control has initialized and
    ///   is ready to be used.
    /// </summary>
    function IsLoaded: Boolean;
    /// <summary>
    ///   Asks the ad provider to load the ad content
    /// </summary>
    /// <remarks>
    ///   iAd (on iOS) or AdMob (on Android) needs to be told when to
    ///   load up the ad material and this method does that
    /// </remarks>
    procedure LoadAd;

   	// Advert properties

    /// <summary>
    ///   The ID that represents the desired ad unit defined within
    ///   AdMob (Android only)
    /// </summary>
    /// <remarks>
    ///   This property is required on Android only
    /// </remarks>
    property AdUnitID: string read GetAdUnitID write SetAdUnitID;
    /// <summary>
    ///   When the user taps a banner ad this event is triggered to
    ///   control whether the ad's action can start, which typically
    ///   involves starting a full-screen ad
    /// </summary>
    /// <remarks>
    ///   Any processor-intensive tasks can be paused at this point and
    ///   resumed when
    ///   <see cref="FMX.Advertising|TCustomBannerAd.OnActionDidFinish" />
    ///    is triggered
    /// </remarks>
    /// <seealso cref="TCustomBannerAd.OnActionDidFinish" />
    property OnActionCanBegin: TAdActionCanBeginEvent read FOnActionCanBegin write FOnActionCanBegin;
    /// <summary>
    ///   When a banner ad's action (full-screen ad) is closed this
    ///   event is triggered to inform the application that it can
    ///   resume any previously suspended tasks
    /// </summary>
    /// <seealso cref="TCustomBannerAd.OnActionCanBegin" />
    property OnActionDidFinish: TNotifyEvent read FOnActionDidFinish write FOnActionDidFinish;
    /// <summary>
    ///   An event fired to indicate that a banner ad will attempt to
    ///   load
    /// </summary>
    /// <remarks>
    ///   If the ad loads successfully then
    ///   <see cref="FMX.Advertising|TCustomBannerAd.OnDidLoad" /> will
    ///   fire. If something goes wrong in attempting to load the ad
    ///   <see cref="FMX.Advertising|TCustomBannerAd.OnDidFail" /> will
    ///   fire.
    /// </remarks>
    /// <seealso cref="TCustomBannerAd.OnDidLoad" />
    /// <seealso cref="TCustomBannerAd.OnDidFail" />
    property OnWillLoad: TNotifyEvent read FOnWillLoad write FOnWillLoad;
    /// <summary>
    ///   A banner ad loaded successfully
    /// </summary>
    /// <remarks>
    ///   This event fires after
    ///   <see cref="FMX.Advertising|TCustomBannerAd.OnWillLoad" />
    /// </remarks>
    property OnDidLoad: TNotifyEvent read FOnDidLoad write FOnDidLoad;
    /// <summary>
    ///   A banner ad failed to load. An error message is passed in the
    ///   event's Error parameter.
    /// </summary>
    property OnDidFail: TAdDidFailEvent read FOnDidFail write FOnDidFail;
    property TestMode: Boolean read FTestMode write SetTestMode default False;
    property AdSize: TBannerAdSize read FAdSize write FAdSize default TBannerAdSize.Auto;
  end;

  /// <summary>
  ///   The banner ad component class
  /// </summary>
  [ComponentPlatformsAttribute(pidiOSSimulator or pidiOSDevice or pidiOSDevice32 or pidiOSDevice64 or pidAndroid)]
  TBannerAd = class(TCustomBannerAd)
  published
    property AdSize;
    property Align;
    property Anchors;
    property Width;
    property Height;
    property Margins;
    property Position;
    property TestMode;
    property Visible default True;
    property OnActionCanBegin;
    property OnActionDidFinish;
    property OnWillLoad;
    property OnDidLoad;
    property OnDidFail;
    property OnResize;
  end;

implementation

uses
  System.Types, FMX.Graphics,
{$IF Defined(IOS)}
  FMX.Advertising.iOS,
{$ELSEIF Defined(Android)}
  FMX.Advertising.Android,
{$ENDIF}
  FMX.Platform, FMX.Forms;

{ TCustomBannerAd }

constructor TCustomBannerAd.Create(AOwner: TComponent);
begin
  inherited;
  if TPlatformServices.Current.SupportsPlatformService(IFMXAdvertisingService, FAdService) then
    FAd := FAdService.CreateBannerAd(Self);
  SetAcceptsControls(False);
end;

destructor TCustomBannerAd.Destroy;
begin
  if FAdService <> nil then
    FAdService.RemoveAd(FAd);
  if FAd <> nil then
    FAd.SetBannerAdControl(nil);
  FAd := nil;
  inherited;
end;

procedure TCustomBannerAd.CancelAction;
begin
  if FAd <> nil then
    FAd.CancelAction;
end;

procedure TCustomBannerAd.DoActionCanBegin(var WillLeaveApplication: Boolean);
begin
  //Default to the sensible option of allowing the ad to do its thing when clicked
  WillLeaveApplication := True;
  if Assigned(FOnActionCanBegin) then
    try
      FOnActionCanBegin(Self, WillLeaveApplication);
    except
      on E: Exception do
        Application.HandleException(E);
    end;
end;

procedure TCustomBannerAd.DoDidFail(const Error: string);
begin
  if Assigned(FOnDidFail) then
    try
      FOnDidFail(Self, Error)
    except
      on E: Exception do
        Application.HandleException(E);
    end;
end;

procedure TCustomBannerAd.DoActionDidFinish;
begin
  if Assigned(FOnActionDidFinish) then
    try
      FOnActionDidFinish(Self)
    except
      on E: Exception do
        Application.HandleException(E);
    end;
end;

procedure TCustomBannerAd.DoDidLoad;
begin
  if Assigned(FOnDidLoad) then
    try
      FOnDidLoad(Self)
    except
      on E: Exception do
        Application.HandleException(E);
    end;
  UpdateContent;
end;

procedure TCustomBannerAd.DoWillLoad;
begin
  if Assigned(FOnWillLoad) then
    try
      FOnWillLoad(Self)
    except
      on E: Exception do
        Application.HandleException(E);
    end;
end;

function TCustomBannerAd.GetAdUnitID: string;
begin
  Result := '';
  if FAd <> nil then
    Result := FAd.GetAdUnitID;
end;

procedure TCustomBannerAd.SetTestMode(AValue: Boolean);
var
  TestModeSvc: IFMXAdvertisingTestModeService;
begin
  if AValue <> FTestMode then
  begin
    if TPlatformServices.Current.SupportsPlatformService(IFMXAdvertisingTestModeService, TestModeSvc) then
      TestModeSvc.SetTestMode(AValue);
    FTestMode := AValue;
  end;
end;

procedure TCustomBannerAd.Hide;
begin
  Visible := False;
  inherited;
  UpdateContent;
end;

function TCustomBannerAd.IsActionInProgress: Boolean;
begin
  Result := False;
  if FAd <> nil then
    Result := FAd.IsActionInProgress;
end;

function TCustomBannerAd.IsLoaded: Boolean;
begin
  Result := False;
  if FAd <> nil then
    Result := FAd.IsLoaded;
end;

procedure TCustomBannerAd.LoadAd;
begin
  if FAd <> nil then
  begin
    FAd.LoadAd;
    FAd.SetBannerAdControl(Self);
  end;
end;

procedure TCustomBannerAd.Move;
begin
  inherited;
  UpdateContent;
end;

procedure TCustomBannerAd.Paint;
var
  R: TRectF;
begin
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.Stroke.Thickness := 1;
    Canvas.Stroke.Dash := TStrokeDash.Dash;
    Canvas.Stroke.Kind := TBrushKind.Solid;
    Canvas.Stroke.Color := $A0909090;
    Canvas.DrawRect(R, 0, 0, AllCorners, AbsoluteOpacity);
    Canvas.Stroke.Dash := TStrokeDash.Solid;
  end;
end;

procedure TCustomBannerAd.Resize;
begin
  inherited;
  UpdateContent;
end;

procedure TCustomBannerAd.SetAdUnitID(const Value: string);
begin
  if FAd <> nil then
    FAd.SetAdUnitID(Value);
end;

procedure TCustomBannerAd.SetParent(const Value: TFmxObject);
begin
  if Parent <> Value then
  begin
    inherited;
    UpdateContent;
  end
end;

procedure TCustomBannerAd.Show;
begin
  Visible := True;
  inherited;
  UpdateContent;
end;

procedure TCustomBannerAd.UpdateContent;
begin
  if FAd <> nil then
    FAd.UpdateContentFromControl;
end;

initialization

{$IF Defined(IOS) or Defined(Android)}
  RegisterAdvertisingService;
{$ENDIF}

finalization

{$IF Defined(IOS) or Defined(Android)}
  UnregisterAdvertisingService;
{$ENDIF}

end.
