{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Sensors;

interface

uses
  System.Sensors, System.Classes, System.SysUtils, System.Math, FMX.Types;

type

{ TSensor<T: TCustomSensor> }

  TOnSensorChoosing = procedure (Sender: TObject; const Sensors: TSensorArray; var ChoseSensorIndex: Integer) of object;

  EGettingSensor = class (Exception);

  TSensor<T: TCustomSensor> = class (TFmxObject)
  strict private
    FDesignTimeActivation : Boolean;
    FOnSensorRemoved: TNotifyEvent;
    FOnStateChanged: TNotifyEvent;
    FOnSensorChoosing: TOnSensorChoosing;
    procedure SetActive(const Value: Boolean);
    function GetActive: Boolean;
    procedure SetOnDataChanged(const Value: TNotifyEvent);
    procedure SetOnSensorRemoved(const Value: TNotifyEvent);
    procedure SetOnStateChanged(const Value: TNotifyEvent);
  protected
    FOnDataChanged: TNotifyEvent;
    FCategorySensor: TSensorCategory;
    FManager: TSensorManager;
    FSensor: T;
    function GetSensor: T; virtual;
    procedure UpdateSensorProperties; virtual;
    procedure DoSensorRemoved(Sender: TObject); virtual;
    procedure DoSensorChoosing(const ASensors: TSensorArray; var AChoseSensorIndex: Integer); virtual;
    procedure DoStart; virtual;
    procedure DoStop; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    property Sensor: T read FSensor;
  published
    property Active: Boolean read GetActive write SetActive default False;
    { Events }
    property OnDataChanged: TNotifyEvent read FOnDataChanged write SetOnDataChanged;
    property OnSensorChoosing: TOnSensorChoosing read FOnSensorChoosing write FOnSensorChoosing;
    property OnSensorRemoved: TNotifyEvent read FOnSensorRemoved write SetOnSensorRemoved;
    property OnStateChanged: TNotifyEvent read FOnStateChanged write SetOnStateChanged;
  end;

{ TLocationSensor }

  TLocationSensor = class (TSensor<TCustomLocationSensor>)
  strict private
    FOptimize: Boolean;
    FLocationChange: TLocationChangeType;
    FAccuracy: TLocationAccuracy;
    FDistance: TLocationDistance;
    FOnLocationChanged: TLocationChangedEvent;
    FOnEnterRegion: TRegionProximityEvent;
    FOnExitRegion: TRegionProximityEvent;
    procedure SetOptimize(const Value: Boolean);
    procedure SetOnLocationChanged(const Value: TLocationChangedEvent);
    procedure SetOnEnterRegion(const Value: TRegionProximityEvent);
    procedure SetOnExitRegion(const Value: TRegionProximityEvent);
    procedure SetLocationChange(const Value: TLocationChangeType);
    procedure SetAccuracy(const Value: TLocationAccuracy);
    procedure SetDistance(const Value: TLocationDistance);
  protected
    procedure UpdateSensorProperties; override;
    procedure DoStart; override;
    procedure DoStop; override;
    function GetRegion(const AIndex: Integer): TLocationRegion;
    function GetRegionCount: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AddRegion(const Value: TLocationRegion);
    procedure RemoveRegion(const Value: TLocationRegion);
    procedure ClearRegions;
    property RegionCount: Integer read GetRegionCount;
    property Regions[const AIndex: Integer]: TLocationRegion read GetRegion;
  published
    property Optimize: Boolean read FOptimize write SetOptimize default True;
    property LocationChange: TLocationChangeType read FLocationChange
      write SetLocationChange default TLocationChangeType.lctSmall;
    property Accuracy: TLocationAccuracy read FAccuracy write SetAccuracy;
    property Distance: TLocationDistance read FDistance write SetDistance;
    { Events }
    property OnLocationChanged: TLocationChangedEvent read FOnLocationChanged write SetOnLocationChanged;
    property OnEnterRegion: TRegionProximityEvent read FOnEnterRegion write SetOnEnterRegion;
    property OnExitRegion: TRegionProximityEvent read FOnExitRegion write SetOnExitRegion;
  end;

{ TMotionSensor }

  TMotionSensor = class (TSensor<TCustomMotionSensor>)
  private
    {$IFDEF IOS}
    FDataTimer : TTimer;
    procedure OnDataChangeTimer(Sender: TObject);
    {$ENDIF}
  protected
    procedure DoStart; override;
    procedure DoStop; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TEnvironmentalSensor }

  TEnvironmentalSensor = class (TSensor<TCustomEnvironmentalSensor>)
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TOrientationSensor }

  TOrientationSensor = class (TSensor<TCustomOrientationSensor>)
  private
    {$IFDEF IOS}
    FDataTimer : TTimer;
    procedure OnDataChangeTimer(Sender: TObject);
    {$ENDIF}
  protected
    procedure DoStart; override;
    procedure DoStop; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TElectricalSensor }

  TElectricalSensor = class (TSensor<TCustomElectricalSensor>)
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TMechanicalSensor }

  TMechanicalSensor = class (TSensor<TCustomMechanicalSensor>)
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TBiometricSensor }

  TBiometricSensor = class (TSensor<TCustomBiometricSensor>)
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TLightSensor }

  TLightSensor = class (TSensor<TCustomLightSensor>)
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TScannerSensor }

  TScannerSensor = class (TSensor<TCustomScannerSensor>)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TSensor }

constructor TSensor<T>.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  try
    FManager := TSensorManager.Current;
  except on ESensorManagerException do
    FManager := nil;
  end;
end;

procedure TSensor<T>.DoSensorRemoved(Sender: TObject);
begin
  FSensor := nil;
  if Assigned(FOnSensorRemoved) then
    FOnSensorRemoved(Sender);
end;

procedure TSensor<T>.DoStart;
begin
end;

procedure TSensor<T>.DoStop;
begin
end;

procedure TSensor<T>.DoSensorChoosing(const ASensors: TSensorArray; var AChoseSensorIndex: Integer);
begin
  if Assigned(FOnSensorChoosing) then
    FOnSensorChoosing(Self, ASensors, AChoseSensorIndex);
end;

function TSensor<T>.GetActive: Boolean;
begin
  if csDesigning in ComponentState then
    Result := FDesignTimeActivation
  else
    Result := Assigned(FManager) and FManager.Active and Assigned(FSensor) and
      not (FSensor.State in [TSensorState.Removed, TSensorState.AccessDenied, TSensorState.Error]);
end;

function TSensor<T>.GetSensor: T;
var
  Sensors: TSensorArray;
  Category: TSensorCategory;
  SelectedSensorIndex: Integer;
begin
  if not Assigned(FManager) then
    Exit(nil);
  FManager.Active := True;
  Sensors := FManager.GetSensorsByCategory(FCategorySensor);
  if Length(Sensors) > 0 then
  begin
    SelectedSensorIndex := 0;
    DoSensorChoosing(Sensors, SelectedSensorIndex);
    if InRange(SelectedSensorIndex, 0, High(Sensors)) then
      Result := Sensors[SelectedSensorIndex] as T
    else
      raise EGettingSensor.Create(Format('The sensor on the specified index (%d) is not found', [SelectedSensorIndex]));
  end  
  else
    Result := nil;
end;

procedure TSensor<T>.SetActive(const Value: Boolean);
var
  CanActive: Boolean;
begin
  if csDesigning in ComponentState then
    FDesignTimeActivation := Value
  else
  begin
    if Assigned(FManager) and (Active <> Value) then
    begin
      FManager.Active := True;
      // Try to get sensor
      if not Assigned(FSensor) then
        FSensor := GetSensor;
      UpdateSensorProperties;
    end;
    if Value then
      DoStart
    else
    begin
      DoStop;
      FSensor := nil;
    end;
  end;
end;

procedure TSensor<T>.SetOnDataChanged(const Value: TNotifyEvent);
begin
  FOnDataChanged := Value;
  UpdateSensorProperties;
end;

procedure TSensor<T>.SetOnSensorRemoved(const Value: TNotifyEvent);
begin
  FOnSensorRemoved := Value;
  UpdateSensorProperties;
end;

procedure TSensor<T>.SetOnStateChanged(const Value: TNotifyEvent);
begin
  FOnStateChanged := Value;
  UpdateSensorProperties;
end;

procedure TSensor<T>.UpdateSensorProperties;
begin
  if Assigned(FSensor) then
  begin
    FSensor.OnDataChanged := FOnDataChanged;
    FSensor.OnSensorRemoved := DoSensorRemoved;
    FSensor.OnStateChanged := FOnStateChanged;
  end;
end;

{ TLocationSensor }
    
procedure TLocationSensor.SetOptimize(const Value: Boolean);
begin
  if FOptimize <> Value then
  begin
    FOptimize := Value;
    UpdateSensorProperties;
  end;
end;

procedure TLocationSensor.UpdateSensorProperties;
begin
  inherited UpdateSensorProperties;
  if Assigned(FSensor) then
  begin
    FSensor.OnLocationChanged := FOnLocationChanged;
    FSensor.OnEnterRegion := FOnEnterRegion;
    FSensor.OnExitRegion := FOnExitRegion;
    FSensor.Optimize := FOptimize;
    FSensor.LocationChange := FLocationChange;
    FSensor.Accuracy := FAccuracy;
    FSensor.Distance := FDistance;
  end;
end;

procedure TLocationSensor.SetOnLocationChanged(const Value: TLocationChangedEvent);
begin
  FOnLocationChanged := Value;
  UpdateSensorProperties;
end;

procedure TLocationSensor.DoStart;
begin
  if Assigned(FSensor) then
    FSensor.Start;
end;

procedure TLocationSensor.DoStop;
begin
  if Assigned(FSensor) then
    FSensor.Stop;
end;

function TLocationSensor.GetRegionCount: Integer;
begin
  if Assigned(FSensor) then
    Result := FSensor.Regions.Count
  else
    Result := 0;
end;

function TLocationSensor.GetRegion(const AIndex: Integer): TLocationRegion;
begin
  if Assigned(FSensor) then
    Result := FSensor.Regions.Items[AIndex]
  else
    Result := TLocationRegion.Empty;
end;

procedure TLocationSensor.RemoveRegion(const Value: TLocationRegion);
begin
  if Assigned(FSensor) and FSensor.Regions.Contains(Value) then
    FSensor.Regions.Remove(Value);
end;

procedure TLocationSensor.SetAccuracy(const Value: TLocationAccuracy);
begin
  FAccuracy := Value;
  UpdateSensorProperties;
end;

procedure TLocationSensor.SetDistance(const Value: TLocationDistance);
begin
  FDistance := Value;
  UpdateSensorProperties;
end;

procedure TLocationSensor.SetLocationChange(const Value: TLocationChangeType);
begin
  FLocationChange := Value;
  UpdateSensorProperties;
end;

procedure TLocationSensor.SetOnEnterRegion(const Value: TRegionProximityEvent);
begin
  FOnEnterRegion := Value;
  UpdateSensorProperties;
end;

procedure TLocationSensor.SetOnExitRegion(const Value: TRegionProximityEvent);
begin
  FOnExitRegion := Value;
  UpdateSensorProperties;
end;
  
procedure TLocationSensor.AddRegion(const Value: TLocationRegion);
begin
  if not Assigned(FSensor) then
    FSensor := GetSensor;
  if not FSensor.Regions.Contains(Value) then
    FSensor.Regions.Add(Value);
end;

procedure TLocationSensor.ClearRegions;
begin
  if Assigned(FSensor) then
  begin
    FSensor.Regions.Clear;
    UpdateSensorProperties;
  end;
end;

constructor TLocationSensor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCategorySensor := TSensorCategory.Location;
  FOptimize := True;
  FLocationChange := TLocationChangeType.lctSmall;
  FAccuracy := 0;
  FDistance := 0;
end;

{ TLightSensor }

constructor TLightSensor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCategorySensor := TSensorCategory.Light;
end;

{ TEnvironmentalSensor }

constructor TEnvironmentalSensor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCategorySensor := TSensorCategory.Environmental;
end;

{ TOrientationSensor }

constructor TOrientationSensor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCategorySensor := TSensorCategory.Orientation;
  {$IFDEF IOS}
  FDataTimer := TTimer.Create(Self);
  FDataTimer.OnTimer := OnDataChangeTimer;
  FDataTimer.Enabled := False;
  {$ENDIF}
end;

procedure TOrientationSensor.DoStart;
begin
  if Assigned(FSensor) then
  begin
    FSensor.Start;
    {$IFDEF IOS}
    FDataTimer.Interval := Trunc(FSensor.UpdateInterval);
    FDataTimer.Enabled := True;
    {$ENDIF}
  end;
end;

procedure TOrientationSensor.DoStop;
begin
  {$IFDEF IOS}
  FDataTimer.Enabled := False;
  {$ENDIF}
  if Assigned(FSensor) then
    FSensor.Stop;
end;

{$IFDEF IOS}
procedure TOrientationSensor.OnDataChangeTimer(Sender: TObject);
begin
  if Assigned(FSensor) then
    if Assigned(FOnDataChanged) then
      FOnDataChanged(Self);
end;
{$ENDIF}

{ TElectricalSensor }

constructor TElectricalSensor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCategorySensor := TSensorCategory.Electrical;
end;

{ TMechanicalSensor }

constructor TMechanicalSensor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCategorySensor := TSensorCategory.Mechanical;
end;

{ TBiometricSensor }

constructor TBiometricSensor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCategorySensor := TSensorCategory.Biometric;
end;

{ TScannerSensor }

constructor TScannerSensor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCategorySensor := TSensorCategory.Scanner;
end;

{ TMotionSensor }

constructor TMotionSensor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCategorySensor := TSensorCategory.Motion;
  {$IFDEF IOS}
  FDataTimer := TTimer.Create(Self);
  FDataTimer.OnTimer := OnDataChangeTimer;
  FDataTimer.Enabled := False;
  {$ENDIF}
end;

procedure TMotionSensor.DoStart;
begin
  if Assigned(FSensor) then
  begin
    FSensor.Start;
    {$IFDEF IOS}
    FDataTimer.Interval := Trunc(FSensor.UpdateInterval);
    FDataTimer.Enabled := True;
    {$ENDIF}
  end;
end;

procedure TMotionSensor.DoStop;
begin
  {$IFDEF IOS}
  FDataTimer.Enabled := False;
  {$ENDIF}
  if Assigned(FSensor) then
    FSensor.Stop;
end;

{$IFDEF IOS}
procedure TMotionSensor.OnDataChangeTimer(Sender: TObject);
begin
  if Assigned(FSensor) then
    if Assigned(FOnDataChanged) then
      FOnDataChanged(Self);
end;
{$ENDIF}

initialization
  RegisterFmxClasses([TLocationSensor, TEnvironmentalSensor, TOrientationSensor,
    TElectricalSensor, TMechanicalSensor, TBiometricSensor, TLightSensor,
    TScannerSensor, TMotionSensor]);
  
end.
