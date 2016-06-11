{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Analytics;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Classes;

{$SCOPEDENUMS ON}

type
  ///  <summary>Interface implemented by an object that manages the temporary data cache for logging application
  ///  activity events.</summary>
  IApplicationActivityCacheManager = interface
    ['{6145E812-8ECA-4B69-994C-26A81B2A84DC}']
    ///  <summary>Returns the number of events in the temporary data cache.</summary>
    function GetCacheCount: Integer;
    ///  <summary>Persists the collected data, either by uploading to a server or writing to a file. Typically this
    ///  function should spawn a background thread for saving the data. If Wait is False, then sending the data can be
    ///  done in the background. If the Wait parameter is True, then all processing should be completed before this
    ///  function returns.</summary>
    procedure PersistData(const Wait: Boolean);
    ///  <summary>Clears the temporary data cache.</summary>
    procedure ClearData;
    ///  <summary>Writes an event log message to the data cache.</summary>
    procedure Log(const AMessage: string);
    ///  <summary>Removes an event from the temporary data cache. If the Index is out of range, then an ERangeError
    ///  exception should be raised.</summary>
    procedure RemoveEventAtIndex(const Index: Integer);
    ///  <summary>Retrieves the event at the specified index from the temporary event cache. If the Index is out of
    ///  range, then an ERangeError exception should be raised.</summary>
    function GetEventAtIndex(const Index: Integer): string;
    ///  <summary>Sets an event handler which is fired when the temporary data cache has reached its maximum capacity.
    ///  </summary>
    procedure SetOnDataCacheFull(const AValue: TNotifyEvent);
    ///  <summary>Retrieves the event handler which is fired when the temporary data cache has reached its maximum
    ///  capacity.</summary>
    function GetOnDataCacheFull: TNotifyEvent;
    ///  <summary>Sets the maximum size of the temporary data cache.</summary>
    procedure SetMaxCacheSize(const AValue: Integer);
    ///  <summary>Retrieves the maximum size of the temporary data cache.</summary>
    function GetMaxCacheSize: Integer;
    ///  <summary>Returns the number of events in the temporary data cache.</summary>
    property CacheCount: Integer read GetCacheCount;
    ///  <summary>Sets or retrieves the maximum size of the temporary data cache.</summary>
    property MaxCacheSize: Integer read GetMaxCacheSize write SetMaxCacheSize;
    ///  <summary>Returns the event at the specified index from the temporary data cache.</summary>
    property Event[const Index: Integer]: string read GetEventAtIndex;
    ///  <summary>Sets or retrieves an event handler which is fired when the temporary data cache has reached its
    ///  maximum capacity.</summary>
    property OnDataCacheFull: TNotifyEvent read GetOnDataCacheFull write SetOnDataCacheFull;
  end;

  ///  <summary>Interface that should be implemented by the cache manager if it supports the ability to receive and
  ///  store certain application environment data.</summary>
  IAppAnalyticsStartupDataRecorder = interface
    ['{783ED8DB-86BC-41C7-BBD3-443C19468FF1}']
    ///  <summary>Method to provide the cache manager with system data required by v2 of the AppAnalytics service</summary>
    procedure AddEnvironmentField(const AKey, AValue: string);
  end;


  ///  <summary>Interface implemented by an object that wants to receive notification of application activity.</summary>
  ///  <remarks>The "Track" methods are called during the event processing sequence, so it is important that these
  ///  methods be fast and not perform excessive data manipulation. Typically, these events should simply be stored in
  ///  a temporary cache.</remarks>
  IApplicationActivityListener = interface
    ['{A67DE237-F274-4028-AAC8-DA0BDA0D5D78}']
    ///  <summary>Called when a TAppActivity.AppStart event has been recorded.</summary>
    procedure TrackAppStart(const TimeStamp: TDateTime);
    ///  <summary>Called when a TAppActivity.AppExit event has been recorded.</summary>
    procedure TrackAppExit(const TimeStamp: TDateTime);
    ///  <summary>Called when a TAppActivity.ControlFocused event has been recorded.</summary>
    procedure TrackControlFocused(const TimeStamp: TDateTime; const Sender: TObject);
    ///  <summary>Called when a TAppActivity.WindowActivated event has been recorded.</summary>
    procedure TrackWindowActivated(const TimeStamp: TDateTime; const Sender: TObject);
    ///  <summary>Called when a TAppActivity.Custom event is recorded. Context is an optional object reference which can
    ///  be used to provide additional context about the event.</summary>
    procedure TrackEvent(const TimeStamp: TDateTime; const Sender, Context: TObject);
    ///  <summary>Called when a TAppActivity.Exception event is recorded.</summary>
    procedure TrackException(const TimeStamp: TDateTime; const E: Exception);
  end;


  ///  <summary>Enumeration of the types of events which can ben recorded by an IApplicationActivityListener.</summary>
  TAppActivity = (AppStart, AppExit, ControlFocused, WindowActivated, Exception, Custom);
  ///  <summary>Set of TAppActivity values. Typically used by an object implementing IApplicationActivityListener to
  ///  indicate the types of events that it will record.</summary>
  TAppActivityOptions = set of TAppActivity;

  ///  <summary>An object used to record application activities and dispatch notifications to one or more
  ///  IApplicationActivityListener objects. An instance of this manager may be held by the framework's Application
  ///  object. </summary>
  TAnalyticsManager = class
  strict private
    FListeners: TList<IApplicationActivityListener>;
    function GetTrackingEnabled: Boolean;
  public
    ///  <summary>Destroys this object and releases references to all IApplicationActivityListener objects that have
    ///  been registered with it.</summary>
    destructor Destroy; override;
    ///  <summary>Registers an activity listener. The listener will immediately begin receiving application activity
    ///  notifications as they occur. This object will retain a reference to the listener. If the listener was previously
    ///  registered, it will not be registered again.</summary>
    procedure RegisterActivityListener(const AListener: IApplicationActivityListener);
    ///  <summary>Unregisters an activity listener. This listener will immediately stop receive application activity
    ///  notifications and this object will release its reference to the listener. If the specified listener had not
    ///  been previous registered, no action will be taken.</summary>
    procedure UnregisterActivityListener(const AListener: IApplicationActivityListener);
    ///  <summary>Records a trackable application activity. All registered activity listeners will be notified.</summary>
    procedure RecordActivity(const Activity: TAppActivity); overload;
    ///  <summary>Records a trackable application activity. All registered activity listeners will be notified.</summary>
    procedure RecordActivity(const Activity: TAppActivity; const Sender: TObject); overload;
    ///  <summary>Records a trackable application activity. All registered activity listeners will be notified.</summary>
    procedure RecordActivity(const Activity: TAppActivity; const Sender: TObject; const Context: TObject); overload;
    ///  <summary>Returns True if at least one listener has been registered. Returns False otherwise.</summary>
    property TrackingEnabled: Boolean read GetTrackingEnabled;
  end;

  ///  <summary>An exception type which indicates the initialization of an application activity tracking component
  ///  failed.</summary>
  EAnalyticsInitializationFailed = class(Exception)
  end;

implementation

{ TAnalyticsManager }

destructor TAnalyticsManager.Destroy;
begin
  FListeners.DisposeOf;
  inherited;
end;

procedure TAnalyticsManager.RecordActivity(const Activity: TAppActivity);
begin
  RecordActivity(Activity, nil, nil);
end;

procedure TAnalyticsManager.RecordActivity(const Activity: TAppActivity; const Sender: TObject);
begin
  RecordActivity(Activity, Sender, nil);
end;

function TAnalyticsManager.GetTrackingEnabled: Boolean;
begin
  Result := (FListeners <> nil) and (FListeners.Count > 0);
end;

procedure TAnalyticsManager.RecordActivity(const Activity: TAppActivity; const Sender, Context: TObject);
var
  I: Integer;
  Time: TDateTime;
begin
  if TrackingEnabled then
  begin
    Time := Now;
    for I := 0 to FListeners.Count - 1 do
      case Activity of
        TAppActivity.AppStart:
          FListeners[I].TrackAppStart(Time);
        TAppActivity.AppExit:
          FListeners[I].TrackAppExit(Time);
        TAppActivity.ControlFocused:
          FListeners[I].TrackControlFocused(Time, Sender);
        TAppActivity.WindowActivated:
          FListeners[I].TrackWindowActivated(Time, Sender);
        TAppActivity.Exception:
          begin
            if Sender is Exception then
              FListeners[I].TrackException(Time, Exception(Sender));
          end;
        TAppActivity.Custom:
          FListeners[I].TrackEvent(Time, Sender, Context);
      end;
  end;
end;

procedure TAnalyticsManager.RegisterActivityListener(const AListener: IApplicationActivityListener);
begin
  if FListeners = nil then
    FListeners := TList<IApplicationActivityListener>.Create;
  if not FListeners.Contains(AListener) then
    FListeners.Add(AListener);
end;

procedure TAnalyticsManager.UnregisterActivityListener(const AListener: IApplicationActivityListener);
begin
  if (FListeners <> nil) and FListeners.Contains(AListener) then
    FListeners.Remove(AListener);
end;

end.
