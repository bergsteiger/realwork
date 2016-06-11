{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit FMX.Analytics;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Analytics, FMX.Types;

type
  ///  <summary>An event handler which is fired when a TCustomAnalytics component needs to notify the user about
  ///  application usage tracking and obtain the user's permission to allow it. Set the Activate parameter to indicate
  ///  whether or not consent has been provided.</summary>
  TAnalyticsPrivacyMessageEvent = procedure(Sender: TObject; var Activate: Boolean) of object;

  /// <summary>Base component for tracking application activities.</summary>
  TCustomAnalytics = class(TComponent)
  private
    FEnabled: Boolean;
    FAllowTracking: Boolean;
    FOptions: TAppActivityOptions;
    FApplicationID: string;
    FUserID: string;
    FSessionID: string;
    FMaxCacheSize: Integer;
    FOnPrivacyMessage: TAnalyticsPrivacyMessageEvent;
    FPrivacyMessage: TStrings;
    FUpdateInterval: Integer;
    FUpdateTimer: TTimer;
    procedure DataCacheFull(Sender: TObject);
    procedure UpdateTimerFired(Sender: TObject);
    function GetUpdateInterval: Integer;
    procedure SetUpdateInterval(const Value: Integer);
    procedure SetCacheSize(const Value: Integer);
    procedure SetOnPrivacyMessage(const Value: TAnalyticsPrivacyMessageEvent);
    procedure SetOptions(const Value: TAppActivityOptions);
    procedure SetPrivacyMessage(const Value: TStrings);
    procedure StartTracking;
  protected
    ///  <summary>Performs logic to obtain the user's consent for activity tracking. Returns True if the user gives
    ///  consent.</summary>
    function CheckPrivacy: Boolean; virtual;
    ///  <summary>Returns an interface reference to an object that implements the IApplicationActivityListener
    ///  interface. This listener will be registered with the application's ActivityManager for receiving notifications
    ///  of application activity. This method is used as the property getter for the Listener property.</summary>
    function GetListener: IApplicationActivityListener; virtual; abstract;
    ///  <summary>Returns an interface reference to an object that implements the IApplicationActivityCacheManager
    ///  interface. This cache manager provides the mechanism of temporarily storing application activity logs and
    ///  for transmitting or persisting them periodically. This methos is used as the property getter for the
    ///  CacheManager property.</summary>
    function GetCacheManager: IApplicationActivityCacheManager; virtual; abstract;
    ///  <summary>Configures the data cache and options of the IApplicationActivityListener and registers it with the
    ///  application's AnalyticsManager. Also configures a periodic timer for persisting the data cache.</summary>
    procedure InstallHooks; virtual;
    ///  <summary>Stops the update timer, records a TAppActivity.AppExit event, persists any final data and unregisters
    ///  the IApplicationActivityListener from the application's AnalyticsManager.</summary>
    procedure RemoveHooks; virtual;
    ///  <summary>Sets the Enabled property. If True, then the startup sequence is executed to install the event hooks
    ///  and start the update timer. Descendants should perform any necessary setup before calling inherited.</summary>
    procedure SetEnabled(const Value: Boolean); virtual;
    ///  <summary>Ensures that the SetEnabled logic is performed after the component has been fully streamed in.</summary>
    procedure Loaded; override;
    ///  <summary>A property for retrieving the IApplicationActivityListener reference associated with this component.
    ///  </summary>
  	property Listener: IApplicationActivityListener read GetListener;
    ///  <summary>A property for retrieving the IApplicationActivityCacheManager reference associated with this
    ///  component.</summary>
  	property CacheManager: IApplicationActivityCacheManager read GetCacheManager;
  public
    ///  <summary>Creates an instance of the component</summary>
    constructor Create(AOwner: TComponent); override;
    ///  <summary>Ensure that the logic for disabling the event tracking is performed before destroying the object.
    ///  </summary>
    destructor Destroy; override;
    ///  <summary>Flag to indicate whether the user has given consent to tracking. This is set after the user has given
    ///  consent and the value can be persisted using the form's SaveState or some other mechanism.</summary>
    property AllowTracking: Boolean read FAllowTracking write FAllowTracking stored False;
    ///  <summary>Sets or retrieves the enabled state of the analytics component.</summary>
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    ///  <summary>Sets or retrieves an event handler which is fired when the component needs to obtain user consent
    ///  for activity tracking.</summary>
    property OnPrivacyMessage: TAnalyticsPrivacyMessageEvent read FOnPrivacyMessage write SetOnPrivacyMessage;
    ///  <summary>Sets or retrieves the identifier associated with this application.</summary>
    ///  <remarks>This should not be a user-specific identifier.</remarks>
    property ApplicationID: string read FApplicationID write FApplicationID;
    ///  <summary>An identifier for tracking a user across multiple sessions. On first use, a random ID will be generated
    ///  and this value can be persisted using the form's SaveState or some other mechanism.</summary>
    property UserID: string read FUserID write FUserID stored False;
    ///  <summary>A new session identifier will be generated each time this component is created.</summary>
    property SessionID: string read FSessionID stored False;
    ///  <summary>Sets or retrieves the interval (in seconds) for sending or storing captured activity data.</summary>
    property UpdateInterval: Integer read GetUpdateInterval write SetUpdateInterval;
    ///  <summary>Sets or retrieves the maximum number of activity events to store in the temporary cache. Regardless of
    ///  the UpdateInterval setting, when the number of captured events reaches the value specified in this property,
    ///  the temporary data will be sent or stored and the cache emptied.</summary>
    property CacheSize: Integer read FMaxCacheSize write SetCacheSize;
    ///  <summary>Sets or retrieves the set of activities which should be tracked by this component.</summary>
    property Options: TAppActivityOptions read FOptions write SetOptions;
    ///  <summary>Sets or retrieves the default privacy message that will be displayed if the OnPrivacyMessage event
    ///  handler is not implemented.</summary>
    property PrivacyMessage: TStrings read FPrivacyMessage write SetPrivacyMessage;
  end;

implementation

uses
  System.SysUtils, System.UITypes, FMX.Consts, FMX.Forms, FMX.Dialogs, FMX.DialogService;

{ TCustomAnalytics }

constructor TCustomAnalytics.Create(AOwner: TComponent);
var
  GUID: TGUID;
begin
  inherited;
  FEnabled := False;
  FPrivacyMessage := TStringList.Create;
  FPrivacyMessage.Text := '';
  CreateGUID(GUID);
  FSessionID := GUIDToString(GUID);
end;

destructor TCustomAnalytics.Destroy;
begin
  Enabled := False;
  FPrivacyMessage.Free;
  inherited;
end;

procedure TCustomAnalytics.StartTracking;
begin
  InstallHooks;
  Application.AnalyticsManager.RecordActivity(TAppActivity.AppStart);
  if FUpdateTimer <> nil then
    FUpdateTimer.Enabled := True;
  FEnabled := FAllowTracking;
end;

function TCustomAnalytics.CheckPrivacy: Boolean;
var
  PrivacyText: string;
begin
  Result := FAllowTracking;
  if not FAllowTracking then
  begin
    if Assigned(FOnPrivacyMessage) then
    begin
      FOnPrivacyMessage(Self, FAllowTracking);
      FEnabled := FAllowTracking;
      if FAllowTracking then
        StartTracking;
    end
    else
    begin
      if (PrivacyMessage <> nil) and (PrivacyMessage.Count > 0) then
        PrivacyText := PrivacyMessage.Text
      else
        PrivacyText := SAppAnalyticsDefaultPrivacyMessage;
      TDialogService.MessageDialog(PrivacyText, TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbNo, 0,
        procedure(const AResult: TModalResult)
        begin
          FAllowTracking := AResult = mrYes;
          if FAllowTracking then
            StartTracking;
        end);
    end;
  end
  else
    StartTracking;
end;

procedure TCustomAnalytics.DataCacheFull(Sender: TObject);
begin
  if CacheManager <> nil then
    CacheManager.PersistData(ApplicationState <> TApplicationState.Running);
end;

function TCustomAnalytics.GetUpdateInterval: Integer;
begin
  Result := FUpdateInterval;
end;

procedure TCustomAnalytics.InstallHooks;
begin
  if Listener <> nil then
  begin
    Application.AnalyticsManager.RegisterActivityListener(Listener);
    CacheManager.OnDataCacheFull := DataCacheFull;
    CacheManager.MaxCacheSize := FMaxCacheSize;
    FUpdateTimer := TTimer.Create(Self);
    FUpdateTimer.Interval := FUpdateInterval;
    FUpdateTimer.OnTimer := UpdateTimerFired;
  end;
end;

procedure TCustomAnalytics.RemoveHooks;
begin
  FreeAndNil(FUpdateTimer);
  Application.AnalyticsManager.RecordActivity(TAppActivity.AppExit);
  if (CacheManager <> nil) and (CacheManager.CacheCount > 0) then
    CacheManager.PersistData(True);
  if Listener <> nil then
    Application.AnalyticsManager.UnregisterActivityListener(Listener);
end;

procedure TCustomAnalytics.Loaded;
begin
  inherited;
  // This is to ensure that the privacy check is performed before starting collection.
  if FEnabled then
  begin
    FEnabled := False;
    Enabled := True;
  end;
end;

procedure TCustomAnalytics.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    if [csDesigning, csLoading] * ComponentState = [] then
    begin
      FEnabled := False;
      if Value then
      begin
        if ApplicationID.IsEmpty then
          raise EAnalyticsInitializationFailed.Create(SInvalidActivityTrackingAppID);
        CheckPrivacy;
      end
      else
        RemoveHooks;
    end
    else
      FEnabled := Value;
  end;
end;

procedure TCustomAnalytics.SetCacheSize(const Value: Integer);
begin
  FMaxCacheSize := Value;
  if CacheManager <> nil then
    CacheManager.MaxCacheSize := Value;
end;

procedure TCustomAnalytics.SetOnPrivacyMessage(const Value: TAnalyticsPrivacyMessageEvent);
begin
  FOnPrivacyMessage := Value;
end;

procedure TCustomAnalytics.SetOptions(const Value: TAppActivityOptions);
begin
  FOptions := Value;
end;

procedure TCustomAnalytics.SetPrivacyMessage(const Value: TStrings);
begin
  FPrivacyMessage.Assign(Value);
end;

procedure TCustomAnalytics.SetUpdateInterval(const Value: Integer);
begin
  FUpdateInterval := Value;
  if FUpdateTimer <> nil then
    FUpdateTimer.Interval := Value;
end;

procedure TCustomAnalytics.UpdateTimerFired(Sender: TObject);
begin
  if not (csDesigning in ComponentState) and (CacheManager <> nil) then
    CacheManager.PersistData(False);
end;

end.
