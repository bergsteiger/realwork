{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.InertialMovement;

interface

{$SCOPEDENUMS ON}

uses
  System.Types,
  System.UITypes,
  System.Classes,
  System.Generics.Collections,
  FMX.Types;

const
  DefaultStorageTime = 0.15;
  DefaultIntervalOfAni = 10;
  DecelerationRateNormal = 1.95;
  DecelerationRateFast = 9.5;
  DefaultElasticity = 100;
  DefaultMinVelocity = 10;
  DefaultMaxVelocity = 5000;
  DefaultDeadZone = 8;

type

{$REGION 'TPointD'}
  TPointD = record
    X: Double;
    Y: Double;
  public
    constructor Create(const P: TPointD); overload;
    constructor Create(const P: TPointF); overload;
    constructor Create(const P: TPoint); overload;
    constructor Create(const X, Y: Double); overload;
    procedure SetLocation(const P: TPointD);
    class operator Equal(const Lhs, Rhs: TPointD): Boolean;
    class operator NotEqual(const Lhs, Rhs: TPointD): Boolean; overload;
    class operator Add(const Lhs, Rhs: TPointD): TPointD;
    class operator Subtract(const Lhs, Rhs: TPointD): TPointD;
    class operator Implicit(const APointF: TPointF): TPointD;
    function Distance(const P2: TPointD): Double;
    function Abs: Double;
    procedure Offset(const DX, DY: Double);
  end;

{$ENDREGION}

{$REGION 'TRectD'}

  TRectD = record
    Left, Top, Right, Bottom: Double;
  private
    function GetHeight: Double;
    function GetWidth: Double;
    procedure SetHeight(const Value: Double);
    procedure SetWidth(const Value: Double);
    function GetTopLeft: TPointD;
    procedure SetTopLeft(const P: TPointD);
    function GetBottomRight: TPointD;
    procedure SetBottomRight(const P: TPointD);
  public
    constructor Create(const Origin: TPointD); overload;
    // empty rect at given origin
    constructor Create(const Left, Top, Right, Bottom: Double); overload;
    // at x, y with width and height
    // operator overloads
    class operator Equal(const Lhs, Rhs: TRectD): Boolean;
    class operator NotEqual(const Lhs, Rhs: TRectD): Boolean;
    class function Empty: TRectD; inline; static;
    // changing the width is always relative to Left;
    property Width: Double read GetWidth write SetWidth;
    // changing the Height is always relative to Top
    property Height: Double read GetHeight write SetHeight;
    procedure Inflate(const DX, DY: Double);
    procedure Offset(const DX, DY: Double);
    property TopLeft: TPointD read GetTopLeft write SetTopLeft;
    property BottomRight: TPointD read GetBottomRight write SetBottomRight;
  end;
{$ENDREGION}

{$REGION 'Types and methods for working with the smooth movement'}

  TAniCalculations = class(TPersistent)
  public type
    TTargetType = (Achieved, Max, Min, Other);

    TTargetTypeHelper = record helper for TTargetType
    const
      ttAchieved = TTargetType.Achieved deprecated 'Use TTargetType.Achieved';
      ttMax = TTargetType.Max deprecated 'Use TTargetType.Max';
      ttMin = TTargetType.Min deprecated 'Use TTargetType.Min';
      ttOther = TTargetType.Other deprecated 'Use TTargetType.Other';
    end;
    TTarget = record
      TargetType: TTargetType;
      Point: TPointD;
    end;
  private type
    TPointTime = record
      Point: TPointD;
      Time: TDateTime;
    end;
  private
    FEnabled: Boolean;
    FInTimerProc: Boolean;
    FTouchTracking: TTouchTracking;
    FTimerHandle: TFmxHandle;
    FInterval: Word;
    FCurrentVelocity: TPointD;
    FUpVelocity: TPointD;
    FUpPosition: TPointD;
    FUpDownTime: TDateTime;
    FLastTimeCalc: TDateTime;
    [Weak] FOwner: TPersistent;
    FPlatformTimer: IFMXTimerService;
    FPointTime: TList<TPointTime>;

    FTargets: array of TTarget;
    FMinTarget: TTarget;
    FMaxTarget: TTarget;
    FTarget: TTarget;
    FLastTarget: TTarget;
    FCancelTargetX: Boolean;
    FCancelTargetY: Boolean;

    FOnStart: TNotifyEvent;
    FOnTimer: TNotifyEvent;
    FOnStop: TNotifyEvent;
    FDown: Boolean;
    FAnimation: Boolean;
    FViewportPosition: TPointD;
    FLowChanged: Boolean;
    FLastTimeChanged: TDateTime;
    FDownPoint: TPointD;
    FDownPosition: TPointD;
    FUpdateTimerCount: ShortInt;
    FElasticity: Double;
    FDecelerationRate: Double;
    FStorageTime: Double;
    FInDoStart: Boolean;
    FInDoStop: Boolean;
    FMoved: Boolean;
    FStarted: Boolean;
    FBoundsAnimation: Boolean;
    FAutoShowing: Boolean;
    FOpacity: Single;
    FShown: Boolean;
    FMouseTarget: TTarget;
    FAveraging: Boolean;
    FMinVelocity: Integer;
    FMaxVelocity: Integer;
    FDeadZone: Integer;
    FUpdateCount: Integer;
    FElasticityFactor: TPoint;
    procedure StartTimer;
    procedure StopTimer;
    procedure TimerProc;
    procedure Clear(T: TDateTime = 0);
    procedure UpdateTimer;
    procedure SetInterval(const Value: Word);
    procedure SetEnabled(const Value: Boolean);
    procedure SetTouchTracking(const Value: TTouchTracking);
    procedure InternalCalc(DeltaTime: Double);
    procedure SetAnimation(const Value: Boolean);
    procedure SetDown(const Value: Boolean);
    function FindTarget(var Target: TTarget): Boolean;
    function GetTargetCount: Integer;
    function DecelerationRateStored: Boolean;
    function ElasticityStored: Boolean;
    function StorageTimeStored: Boolean;
    procedure CalcVelocity(const Time: TDateTime = 0);
    procedure InternalStart;
    procedure InternalTerminated;
    procedure SetBoundsAnimation(const Value: Boolean);
    procedure UpdateViewportPositionByBounds;
    procedure SetAutoShowing(const Value: Boolean);
    procedure SetShown(const Value: Boolean);
    function GetViewportPositionF: TPointF;
    procedure SetViewportPositionF(const Value: TPointF);
    procedure SetMouseTarget(Value: TTarget);
    function GetInternalTouchTracking: TTouchTracking;
    function GetPositions(const Index: Integer): TPointD;
    function GetPositionCount: Integer;
    function GetPositionTimes(const Index: Integer): TDateTime;
    function PosToView(const APosition: TPointD): TPointD;
    procedure SetViewportPosition(const Value: TPointD);
    function GetOpacity: Single;
    function GetLowVelocity: Boolean;
    function AddPointTime(const X, Y: Double;
                          const Time: TDateTime = 0): TPointTime;
    procedure InternalChanged;
    procedure UpdateTarget;
    function DoStopScrolling(CurrentTime: TDateTime = 0): Boolean;
  protected
    function IsSmall(const P: TPointD;
                     const Epsilon: Double): Boolean; overload;
    function IsSmall(const P: TPointD): Boolean; overload;
    function GetOwner: TPersistent; override;
    procedure DoStart; virtual;
    procedure DoChanged; virtual;
    procedure DoStop; virtual;
    procedure DoCalc(const DeltaTime: Double;
                       var NewPoint, NewVelocity: TPointD;
                       var Done: Boolean); virtual;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Shown: Boolean read FShown write SetShown;
    property MouseTarget: TTarget read FMouseTarget write SetMouseTarget;
    property InternalTouchTracking: TTouchTracking read GetInternalTouchTracking;
    property Positions[const index: Integer]: TPointD read GetPositions;
    property PositionTimes[const index: Integer]: TDateTime read GetPositionTimes;
    property PositionCount: Integer read GetPositionCount;
    property UpVelocity: TPointD read FUpVelocity;
    property UpPosition: TPointD read FUpPosition;
    property UpDownTime: TDateTime read FUpDownTime;
    property MinTarget: TTarget read FMinTarget;
    property MaxTarget: TTarget read FMaxTarget;
    property Target: TTarget read FTarget;
    property MinVelocity: Integer read FMinVelocity write FMinVelocity default DefaultMinVelocity;
    property MaxVelocity: Integer read FMaxVelocity write FMaxVelocity default DefaultMaxVelocity;
    property DeadZone: Integer read FDeadZone write FDeadZone default DefaultDeadZone;
    property CancelTargetX: Boolean read FCancelTargetX;
    property CancelTargetY: Boolean read FCancelTargetY;
  public
    constructor Create(AOwner: TPersistent); virtual;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Assign(Source: TPersistent); override;

    procedure MouseDown(X, Y: Double);
    procedure MouseMove(X, Y: Double);
    procedure MouseLeave;
    procedure MouseUp(X, Y: Double);
    procedure MouseWheel(X, Y: Double);

    property Animation: Boolean read FAnimation
                               write SetAnimation default False;

    property AutoShowing: Boolean read FAutoShowing
                                 write SetAutoShowing default False;

    property Averaging: Boolean read FAveraging
                               write FAveraging default False;

    property BoundsAnimation: Boolean read FBoundsAnimation
                                     write SetBoundsAnimation default True;

    property Interval: Word read FInterval
                           write SetInterval default DefaultIntervalOfAni;

    property TouchTracking: TTouchTracking read FTouchTracking
                                          write SetTouchTracking
                                        default [ttVertical, ttHorizontal];
    property TargetCount: Integer read GetTargetCount;
    procedure SetTargets(const ATargets: array of TTarget);
    procedure GetTargets(var ATargets: array of TTarget);
    procedure UpdatePosImmediately(const Force: Boolean = False);

    property DecelerationRate: Double read FDecelerationRate
                                     write FDecelerationRate
                                    stored DecelerationRateStored nodefault;
    property Elasticity: Double read FElasticity
                               write FElasticity
                              stored ElasticityStored nodefault;
    property StorageTime: Double read FStorageTime
                                write FStorageTime
                               stored StorageTimeStored nodefault;
    property CurrentVelocity: TPointD read FCurrentVelocity;
    property ViewportPosition: TPointD read FViewportPosition
                                      write SetViewportPosition;
    property ViewportPositionF: TPointF read GetViewportPositionF
                                       write SetViewportPositionF;
    property LastTimeCalc: TDateTime read FLastTimeCalc;
    property Down: Boolean read FDown write SetDown;
    property Opacity: Single read GetOpacity;
    property InTimerProc: Boolean read FInTimerProc;
    property Moved: Boolean read FMoved;
    property LowVelocity: Boolean read GetLowVelocity;
    procedure BeginUpdate;
    procedure EndUpdate;
    property UpdateCount: Integer read FUpdateCount;

    property OnStart: TNotifyEvent read FOnStart write FOnStart;
    property OnChanged: TNotifyEvent read FOnTimer write FOnTimer;
    property OnStop: TNotifyEvent read FOnStop write FOnStop;
  end;
{$ENDREGION}

implementation

uses
  System.SysUtils, System.Math, System.RTLConsts, System.Math.Vectors, System.TypInfo, FMX.Consts, FMX.Platform;

const
  EpsilonPoint = TEpsilon.Position;
  DefaultOpacityTime = 0.3;
  MaxOpacity = 1.5;
  EpsilonTime = 0.01;
  StopTime = 0.007;

var
  EpsilonRange: Integer;

function AniSign(const CurrentValue, TargetValue, EpsilonPoint: Double): TValueSign;
begin
  Result := -CompareValue(CurrentValue, TargetValue, EpsilonPoint);
end;

{$REGION 'implementation of TPointD'}
{ TPointD }

constructor TPointD.Create(const P: TPointD);
begin
  self.X := P.X;
  self.Y := P.Y;
end;

constructor TPointD.Create(const X, Y: Double);
begin
  self.X := X;
  self.Y := Y;
end;

constructor TPointD.Create(const P: TPoint);
begin
  self.X := P.X;
  self.Y := P.Y;
end;

constructor TPointD.Create(const P: TPointF);
begin
  self.X := P.X;
  self.Y := P.Y;
end;

class operator TPointD.Equal(const Lhs, Rhs: TPointD): Boolean;
begin
  Result := SameValue(Lhs.X, Rhs.X) and
    SameValue(Lhs.Y, Rhs.Y);
end;

class operator TPointD.Implicit(const APointF: TPointF): TPointD;
begin
  Result.X := APointF.X;
  Result.Y := APointF.Y;
end;

class operator TPointD.NotEqual(const Lhs, Rhs: TPointD): Boolean;
begin
  Result := not(Lhs = Rhs);
end;

class operator TPointD.Add(const Lhs, Rhs: TPointD): TPointD;
begin
  Result.X := Lhs.X + Rhs.X;
  Result.Y := Lhs.Y + Rhs.Y;
end;

class operator TPointD.Subtract(const Lhs, Rhs: TPointD): TPointD;
begin
  Result.X := Lhs.X - Rhs.X;
  Result.Y := Lhs.Y - Rhs.Y;
end;

function TPointD.Abs: Double;
begin
  Result := Sqrt(Sqr(self.X) + Sqr(self.Y));
end;

function TPointD.Distance(const P2: TPointD): Double;
begin
  Result := Sqrt(Sqr(self.X - P2.X) + Sqr(self.Y - P2.Y));
end;

procedure TPointD.Offset(const DX, DY: Double);
begin
  self.X := self.X + DX;
  self.Y := self.Y + DY;
end;

procedure TPointD.SetLocation(const P: TPointD);
begin
  self.X := RoundTo(P.X, EpsilonRange);
  self.Y := RoundTo(P.Y, EpsilonRange);
end;

{$ENDREGION}
{$REGION 'implementation of TRectD'}
{ TRectD }

constructor TRectD.Create(const Origin: TPointD);
begin
  TopLeft := Origin;
  BottomRight := Origin;
end;

constructor TRectD.Create(const Left, Top, Right, Bottom: Double);
begin
  self.Left := Left;
  self.Top := Top;
  self.Right := Right;
  self.Bottom := Bottom;
end;

class function TRectD.Empty: TRectD;
begin
  Result := TRectD.Create(0, 0, 0, 0);
end;

class operator TRectD.Equal(const Lhs, Rhs: TRectD): Boolean;
begin
  Result := (Lhs.TopLeft = Rhs.TopLeft) and (Lhs.BottomRight = Rhs.BottomRight);
end;

class operator TRectD.NotEqual(const Lhs, Rhs: TRectD): Boolean;
begin
  Result := not(Lhs = Rhs);
end;

function TRectD.GetHeight: Double;
begin
  Result := self.Bottom - self.Top;
end;

procedure TRectD.SetHeight(const Value: Double);
begin
  self.Bottom := self.Top + Value;
end;

function TRectD.GetWidth: Double;
begin
  Result := self.Right - self.Left;
end;

procedure TRectD.SetWidth(const Value: Double);
begin
  self.Right := self.Left + Value;
end;

procedure TRectD.Inflate(const DX, DY: Double);
begin
  TopLeft.Offset(-DX, -DY);
  BottomRight.Offset(DX, DY);
end;

procedure TRectD.Offset(const DX, DY: Double);
begin
  TopLeft.Offset(DX, DY);
  BottomRight.Offset(DX, DY);
end;

function TRectD.GetTopLeft: TPointD;
begin
  Result.X := Left;
  Result.Y := Top;
end;

procedure TRectD.SetTopLeft(const P: TPointD);
begin
  Left := P.X;
  Top := P.Y;
end;

function TRectD.GetBottomRight: TPointD;
begin
  Result.X := Right;
  Result.Y := Bottom;
end;

procedure TRectD.SetBottomRight(const P: TPointD);
begin
  Right := P.X;
  Bottom := P.Y;
end;

{$ENDREGION}

{$REGION 'implementation of TAniCalculations'}
{ TAniCalculations }

constructor TAniCalculations.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  FTimerHandle := TFmxHandle(-1);
  BeginUpdate;
  FPointTime := TList<TPointTime>.Create;
  if not TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, FPlatformTimer) then
    raise EUnsupportedPlatformService.Create('IFMXTimerService');
  Assign(nil);
end;

destructor TAniCalculations.Destroy;
begin
  StopTimer;
  FreeAndNil(FPointTime);
  inherited;
end;

procedure TAniCalculations.AfterConstruction;
begin
  inherited;
  if not AutoShowing then
    FOpacity := MaxOpacity;
  EndUpdate;
end;

procedure TAniCalculations.Assign(Source: TPersistent);
var
  LSource: TAniCalculations;
  LTargets: array of TTarget;
begin
  if Source is TAniCalculations then
  begin
    LSource := TAniCalculations(Source);
    MinVelocity := LSource.MinVelocity;
    MaxVelocity := LSource.MaxVelocity;
    DeadZone := LSource.DeadZone;
    Animation := LSource.Animation;
    AutoShowing := LSource.AutoShowing;
    Averaging := LSource.Averaging;
    BoundsAnimation := LSource.BoundsAnimation;
    Interval := LSource.Interval;
    TouchTracking := LSource.TouchTracking;
    SetLength(LTargets, LSource.TargetCount);
    LSource.GetTargets(LTargets);
    SetTargets(LTargets);
    DecelerationRate := LSource.DecelerationRate;
    Elasticity := LSource.Elasticity;
    StorageTime := LSource.StorageTime;
  end
  else if Source = nil then
  begin
    MinVelocity := DefaultMinVelocity;
    MaxVelocity := DefaultMaxVelocity;
    DeadZone := DefaultDeadZone;
    Animation := False;
    AutoShowing := False;
    Averaging := False;
    BoundsAnimation := True;
    Interval := DefaultIntervalOfAni;
    TouchTracking := [ttVertical, ttHorizontal];
    SetTargets([]);
    DecelerationRate := DecelerationRateNormal;
    Elasticity := DefaultElasticity;
    StorageTime := DefaultStorageTime;
  end
  else
    inherited;
end;

function TAniCalculations.GetInternalTouchTracking: TTouchTracking;
begin
  Result := FTouchTracking;
  if FMouseTarget.TargetType = TTargetType.Other then
  begin
    if not SameValue(FMouseTarget.Point.X, FViewportPosition.X, EpsilonPoint)
    then
      Result := Result + [ttHorizontal];
    if not SameValue(FMouseTarget.Point.Y, FViewportPosition.Y, EpsilonPoint)
    then
      Result := Result + [ttVertical];
  end;
end;

function TAniCalculations.GetOpacity: Single;
begin
  Result := Min(1, Max(0, FOpacity));
end;

function TAniCalculations.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TAniCalculations.SetAnimation(const Value: Boolean);
begin
  if FAnimation <> Value then
  begin
    FAnimation := Value;
    FLastTimeCalc := 0;
    FCurrentVelocity := TPointD.Create(0, 0);
    UpdateTimer;
    if (not Animation) then
      UpdatePosImmediately(True);
  end;
end;

procedure TAniCalculations.SetBoundsAnimation(const Value: Boolean);
begin
  if FBoundsAnimation <> Value then
  begin
    FBoundsAnimation := Value;
    SetViewportPosition(ViewportPosition);
  end;
end;

procedure TAniCalculations.SetDown(const Value: Boolean);
var
  LTarget: TTarget;
  T: TDateTime;
begin
  if FDown <> Value then
  begin
    T := Now;
    if Value then
    begin
      FDown := Value;
      FPointTime.Clear;
      if not Averaging then
        FCurrentVelocity := TPointD.Create(0, 0);
      FLastTimeCalc := 0;
      FUpDownTime := T;
      LTarget.TargetType := TTargetType.Achieved;
      LTarget.Point := TPointD.Create(0, 0);
      SetMouseTarget(LTarget);
    end
    else
    begin
      try
        DoStopScrolling(T);
        FUpDownTime := T;
      finally
        FDown := Value;
      end;
    end;
    UpdateTimer;
    if (not FDown) and (not Animation) and (InternalTouchTracking <> []) then
      UpdatePosImmediately;
  end;
end;

procedure TAniCalculations.InternalStart;
begin
  if (not FInDoStart) and (not FStarted) then
  begin
    FInDoStart := True;
    try
      DoStart;
      FStarted := True;
    finally
      FInDoStart := False;
    end;
  end;
end;

procedure TAniCalculations.InternalTerminated;
var
  LTarget: TTarget;
begin
  if (not FInDoStop) and (FStarted) then
  begin
    FInDoStop := True;
    try
      LTarget.TargetType := TTargetType.Achieved;
      LTarget.Point := TPointD.Create(0, 0);
      SetMouseTarget(LTarget);
      DoStop;
      FStarted := False;
    finally
      FInDoStop := False;
    end;
  end;
end;

function TAniCalculations.IsSmall(const P: TPointD; const Epsilon: Double): Boolean;
var
  LTouchTracking: TTouchTracking;
begin
  LTouchTracking := InternalTouchTracking;
  if LTouchTracking = [ttVertical, ttHorizontal] then
    Result := P.Abs < Epsilon
  else if LTouchTracking = [ttVertical] then
    Result := System.Abs(P.Y) < Epsilon
  else if LTouchTracking = [ttHorizontal] then
    Result := System.Abs(P.X) < Epsilon
  else
    Result := True
end;

function TAniCalculations.IsSmall(const P: TPointD): Boolean;
begin
  Result := IsSmall(P, EpsilonPoint);
end;

procedure TAniCalculations.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    if Value and (FInterval > 0) then
    begin
      if UpdateCount = 0 then
      begin
        InternalStart;
        StartTimer;
        FEnabled := Value;
      end;
    end
    else
    begin
      StopTimer;
      FEnabled := Value;
      InternalTerminated;
    end;
  end;
end;

procedure TAniCalculations.SetInterval(const Value: Word);
begin
  if FInterval <> Value then
  begin
    StopTimer;
    FInterval := Value;
    if FEnabled and (FInterval > 0) and (UpdateCount <= 0) then
      StartTimer;
  end;
end;

function TAniCalculations.GetViewportPositionF: TPointF;
begin
  Result.X := FViewportPosition.X;
  Result.Y := FViewportPosition.Y;
end;

procedure TAniCalculations.SetViewportPosition(const Value: TPointD);
var
  LChanged: Boolean;
  OldViewportPosition: TPointD;
  LTarget: TTarget;
begin
  OldViewportPosition := FViewportPosition;
  FViewportPosition := Value;
  UpdateViewportPositionByBounds;
  LChanged := FViewportPosition <> OldViewportPosition;
  if LChanged and (not FInTimerProc) then
  begin
    LTarget.TargetType := TTargetType.Achieved;
    LTarget.Point := TPointD.Create(0, 0);
    SetMouseTarget(LTarget);
    if Down then
      InternalChanged
    else
    begin
      UpdateTimer;
      InternalChanged;
    end;
  end;
end;

procedure TAniCalculations.SetViewportPositionF(const Value: TPointF);
var
  NewValue: TPointD;
begin
  NewValue := TPointD.Create(Value);
  ViewportPosition := NewValue;
end;

procedure TAniCalculations.SetTouchTracking(const Value: TTouchTracking);
begin
  if FTouchTracking <> Value then
  begin
    FTouchTracking := Value;
    UpdateTimer;
  end;
end;

procedure TAniCalculations.SetShown(const Value: Boolean);
var
  NewVisible, ChangeOpacity: Boolean;
begin
  NewVisible := (not AutoShowing) or (Value);
  ChangeOpacity := ((FOpacity < MaxOpacity) and (NewVisible)) or
                   ((FOpacity > 0) and (not NewVisible));
  FShown := Value;
  if ChangeOpacity then
  begin
    FUpdateTimerCount := -1;
    UpdateTimer;
  end;
end;

procedure TAniCalculations.StartTimer;
begin
  if FTimerHandle = TFmxHandle(-1) then
  begin
    FTimerHandle := FPlatformTimer.CreateTimer(FInterval, TimerProc);
  end;
end;

procedure TAniCalculations.StopTimer;
begin
  if FTimerHandle <> TFmxHandle(-1) then
  begin
    FPlatformTimer.DestroyTimer(FTimerHandle);
    FTimerHandle := TFmxHandle(-1);
  end;
end;

procedure TAniCalculations.DoCalc(const DeltaTime: Double;
  var NewPoint, NewVelocity: TPointD;
  var Done: Boolean);
var
  EnableTargetX: Boolean;
  EnableTargetY: Boolean;
  procedure UpdatePhysicalParameters(const Target: Double; var Pos, Velocity: Double; const ADecelerationRate: Double;
    const EnableTarget: Boolean; const CancelTarget: Boolean; var ElasticityFactor: Integer);
  var
    dV, DX, aT, aTDecelerationRate, Tmp, R: Double;
    LSign, LSignV: TValueSign;
  begin
    LSign := AniSign(Pos, Target, EpsilonPoint);
    LSignV := AniSign(Velocity, 0, EpsilonPoint);
    R := Abs(Target - Pos);
    Tmp := Velocity;

    aTDecelerationRate := LSignV * ADecelerationRate;
    if EnableTarget then
    begin
      if Velocity = 0 then
        Inc(ElasticityFactor)
      else
        ElasticityFactor := 1;
      aT := (LSign * Ceil(Elasticity * ElasticityFactor * R));
      aT := aT + (aTDecelerationRate / DecelerationRate * 8);
    end
    else
    begin
      aT := aTDecelerationRate;
      ElasticityFactor := 0;
    end;

    dV := aT * DeltaTime;
    if (Velocity > 0) and (dV < 0) and (-dV > Velocity) then
      dV := -Velocity
    else if (Velocity < 0) and (dV > 0) and (dV > -Velocity) then
      dV := -Velocity;
    Velocity := Velocity + dV;
    aT := dV / DeltaTime;
    DX := Tmp * DeltaTime + (aT * Sqr(DeltaTime)) / 2;

    if EnableTarget and (not CancelTarget) then
    begin
      Tmp := Max(1, StorageTime / DeltaTime);
      if LSign = 1 then
      begin
        if (Pos + DX > Target) and (StorageTime > 0) then
          DX := (Target - Pos) / Max(1, Tmp / 3);
        Pos := Pos + DX;
      end
      else if LSign = -1 then
      begin
        if (Pos + DX < Target) and (StorageTime > 0) then
          DX := (Target - Pos) / Max(1, Tmp / 3);
        Pos := Pos + DX;
      end
      else
        Velocity := 0;
      if SameValue(Pos, Target, EpsilonPoint) then
      begin
        Pos := Target;
        Velocity := 0;
      end;
    end
    else
      Pos := Pos + DX;
  end;
  procedure UpdateParams;
  var
    LDecelerationRate: Double;
    AbsV: Double;
  begin
    AbsV := NewVelocity.Abs;
    if (AbsV < MinVelocity) or (DecelerationRate <= 0) then
      LDecelerationRate := 0
    else
      LDecelerationRate := DecelerationRate;

    UpdatePhysicalParameters(Target.Point.X, NewPoint.X, NewVelocity.X, Abs(LDecelerationRate * NewVelocity.X),
      EnableTargetX, CancelTargetX, FElasticityFactor.X);
    UpdatePhysicalParameters(Target.Point.Y, NewPoint.Y, NewVelocity.Y, Abs(LDecelerationRate * NewVelocity.Y),
      EnableTargetY, CancelTargetY, FElasticityFactor.Y);
  end;

begin
  if not Done then
  begin
    EnableTargetX := ([ttHorizontal] * InternalTouchTracking <> []) and
      (Target.TargetType <> TTargetType.Achieved) and
      (AniSign(NewPoint.X, Target.Point.X, EpsilonPoint) <> 0);

    EnableTargetY := ([ttVertical] * InternalTouchTracking <> []) and
      (Target.TargetType <> TTargetType.Achieved) and
      (AniSign(NewPoint.Y, Target.Point.Y, EpsilonPoint) <> 0);

    UpdateParams;
  end;
end;

procedure TAniCalculations.DoStart;
begin
  if Assigned(FOnStart) then
    FOnStart(self);
end;

procedure TAniCalculations.DoChanged;
begin
  if Assigned(FOnTimer) then
    FOnTimer(self);
end;

function TAniCalculations.ElasticityStored: Boolean;
begin
  Result := not SameValue(FElasticity, DefaultElasticity);
end;

procedure TAniCalculations.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TAniCalculations.EndUpdate;
begin
  if FUpdateCount > 0 then
    Dec(FUpdateCount);
end;

function TAniCalculations.DecelerationRateStored: Boolean;
begin
  Result := not SameValue(FDecelerationRate, DecelerationRateNormal);
end;

function TAniCalculations.StorageTimeStored: Boolean;
begin
  Result := not SameValue(FStorageTime, DefaultStorageTime);
end;

procedure TAniCalculations.DoStop;
begin
  if Assigned(FOnStop) then
    FOnStop(self);
end;

function TAniCalculations.DoStopScrolling(CurrentTime: TDateTime = 0): Boolean;
var
  T: Double;
begin
  if CurrentTime = 0 then
    CurrentTime := Now;
  T := (CurrentTime - FUpDownTime) * SecsPerDay;
  Result := Down and (not Moved) and (T >= StopTime);
  if Result then
  begin
    FCurrentVelocity := TPointD.Create(0, 0);
    FPointTime.Clear;
  end;
end;

procedure TAniCalculations.TimerProc;
var
  D, T: TDateTime;
  IsInit: Boolean;
  DOpacity: Single;
begin
  if not FInTimerProc then
  begin
    T := Now;
    IsInit := FLastTimeCalc > 0;
    D := T - FLastTimeCalc;
    FLastTimeCalc := T;
    FInTimerProc := True;
    try
      if (D > 0) then
      try
        D := D * SecsPerDay;
        if AutoShowing then
        begin
          DOpacity := Min(D, 2 * Interval / 1000);
          DOpacity := DOpacity / DefaultOpacityTime;
          if (FOpacity < MaxOpacity) and (Shown) then
            FOpacity := MaxOpacity
          else if (FOpacity > 0) and (not Shown) then
            FOpacity := Max(FOpacity - DOpacity, 0);
        end
        else
          FOpacity := MaxOpacity;
        if IsInit and ((D > EpsilonTime) or (not Down) or FLowChanged) then
        begin
          DoStopScrolling(FLastTimeCalc);
          if Animation and (not (Down and Moved)) then
            InternalCalc(D);
          InternalChanged;
          FLowChanged := False;
          UpdateTimer;
        end;
      except
        on E: Exception do
        begin
          Enabled := False;
          raise;
        end;
      end;
    finally
      FInTimerProc := False;
    end;
  end;
end;

function TAniCalculations.GetTargetCount: Integer;
begin
  Result := Length(FTargets);
end;

procedure TAniCalculations.GetTargets(var ATargets: array of TTarget);
var
  N, I: Integer;
begin
  N := Min(TargetCount, Length(ATargets));
  for I := 0 to N - 1 do
    ATargets[I] := FTargets[I];
  UpdateTimer;
end;

procedure TAniCalculations.SetTargets(const ATargets: array of TTarget);
  function FindMaxTarget(var Target: TTarget): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to TargetCount - 1 do
      if FTargets[I].TargetType = TTargetType.Max then
      begin
        if not Result then
        begin
          Target := FTargets[I];
          Result := True;
        end
        else
        begin
          if (Target.Point.X > FTargets[I].Point.X) then
            Target.Point.X := FTargets[I].Point.X;
          if (Target.Point.Y > FTargets[I].Point.Y) then
            Target.Point.Y := FTargets[I].Point.Y;
        end;
      end;
  end;
  function FindMinTarget(var Target: TTarget): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to TargetCount - 1 do
      if FTargets[I].TargetType = TTargetType.Min then
      begin
        if not Result then
        begin
          Target := FTargets[I];
          Result := True;
        end
        else
        begin
          if (Target.Point.X < FTargets[I].Point.X) then
            Target.Point.X := FTargets[I].Point.X;
          if (Target.Point.Y < FTargets[I].Point.Y) then
            Target.Point.Y := FTargets[I].Point.Y;
        end;
      end;
  end;

var
  I: Integer;
begin
  SetLength(FTargets, Length(ATargets));
  for I := 0 to Length(ATargets) - 1 do
    FTargets[I] := ATargets[I];

  if not FindMinTarget(FMinTarget) then
  begin
    FMinTarget.TargetType := TTargetType.Achieved;
    FMinTarget.Point := TPointD.Create(0, 0);
  end;
  if not FindMaxTarget(FMaxTarget) then
  begin
    FMaxTarget.TargetType := TTargetType.Achieved;
    FMaxTarget.Point := TPointD.Create(0, 0);
  end;

  if IsSmall(FCurrentVelocity, MinVelocity) then
    FLastTimeCalc := 0;
  UpdateTimer;
  if (not FDown) and (not Animation) and (InternalTouchTracking <> []) then
    UpdatePosImmediately;
end;

function TAniCalculations.FindTarget(var Target: TTarget): Boolean;
var
  MinR: Double;

  function FindMinMaxTarget(var Target: TTarget): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    Target.TargetType := TTargetType.Achieved;
    Target.Point := ViewportPosition;

    for I := 0 to TargetCount - 1 do
      if (FTargets[I].TargetType = TTargetType.Max) then
      begin
        if Target.Point.X > FTargets[I].Point.X then
        begin
          Target.Point.X := FTargets[I].Point.X;
          Result := True;
        end;
        if Target.Point.Y > FTargets[I].Point.Y then
        begin
          Target.Point.Y := FTargets[I].Point.Y;
          Result := True;
        end;
      end;
    for I := 0 to TargetCount - 1 do
      if (FTargets[I].TargetType = TTargetType.Min) then
      begin
        if Target.Point.X < FTargets[I].Point.X then
        begin
          Target.Point.X := FTargets[I].Point.X;
          Result := True;
        end;
        if Target.Point.Y < FTargets[I].Point.Y then
        begin
          Target.Point.Y := FTargets[I].Point.Y;
          Result := True;
        end;
      end;
    if Result then
      Target.TargetType := TTargetType.Min;
  end;

  procedure UpdateResult(P: TPointD);
  var
    R: Double;
  begin
    R := ViewportPosition.Distance(P);
    if R < MinR then
    begin
      MinR := R;
      Result := True;
      Target.Point := P;
      Target.TargetType := TTargetType.Other;
    end;
  end;

var
  I: Integer;
  MinFound, MaxFound: Boolean;
  X, Y: Double;
begin
  Result := False;
  MinR := MaxInt;
  MinFound := FMinTarget.TargetType = TTargetType.Min;
  MaxFound := FMaxTarget.TargetType = TTargetType.Max;
  for I := 0 to TargetCount - 1 do
    if (FTargets[I].TargetType = TTargetType.Other) then
    begin
      if FTargets[I].Point = ViewportPosition then
      begin
        Target.Point := FTargets[I].Point;
        Target.TargetType := TTargetType.Achieved;
        Result := False;
        Exit;
      end
      else
      begin
        X := FTargets[I].Point.X;
        Y := FTargets[I].Point.Y;
        if ((not MinFound) or (MinFound and (X >= FMinTarget.Point.X))) and
          ((not MaxFound) or (MaxFound and (X <= FMaxTarget.Point.X))) and
          ((not MinFound) or (MinFound and (Y >= FMinTarget.Point.Y))) and
          ((not MaxFound) or (MaxFound and (Y <= FMaxTarget.Point.Y))) then
          UpdateResult(FTargets[I].Point);
      end;
    end;
  if Result then
  begin
    if Target.Point = ViewportPosition then
    begin
      Target.TargetType := TTargetType.Achieved;
      Result := False;
    end;
  end
  else
  begin
    if MinFound or MaxFound then
      Result := FindMinMaxTarget(Target)
    else
    begin
      Target.TargetType := TTargetType.Achieved;
      Target.Point := ViewportPosition;
    end;
  end;
end;

procedure TAniCalculations.UpdateTarget;
var
  SignPos: TValueSign;
begin
  FindTarget(FTarget);
  if (FTarget.TargetType = TTargetType.Achieved) or
    (not SameValue(FLastTarget.Point.X, FTarget.Point.X, EpsilonPoint)) then
    FCancelTargetX := False;
  if (FTarget.TargetType = TTargetType.Achieved) or
    (not SameValue(FLastTarget.Point.Y, FTarget.Point.Y, EpsilonPoint)) then
    FCancelTargetY := False;
  FLastTarget := FTarget;
  if Animation and Down and Moved and (not InTimerProc) and (PositionCount > 1) and
    (FMinTarget.TargetType <> TTargetType.Achieved) and (FMaxTarget.TargetType <> TTargetType.Achieved) and
    (FTarget.TargetType <> TTargetType.Achieved) then
  begin
    if not SameValue(FMinTarget.Point.X, FMaxTarget.Point.X, EpsilonPoint) then
    begin
      SignPos := System.Math.Sign(Positions[PositionCount - 1].X - Positions[PositionCount - 2].X);
      FCancelTargetX := (SignPos <> 0) and (SignPos = System.Math.Sign(ViewportPosition.X - FTarget.Point.X));
    end;
    if not SameValue(FMinTarget.Point.Y, FMaxTarget.Point.Y, EpsilonPoint) then
    begin
      SignPos := System.Math.Sign(Positions[PositionCount - 1].Y - Positions[PositionCount - 2].Y);
      FCancelTargetY := (SignPos <> 0) and (SignPos = System.Math.Sign(ViewportPosition.Y - FTarget.Point.Y));
    end;
  end;
end;

procedure TAniCalculations.UpdateViewportPositionByBounds;
  function NotBoundsAni(const Vert: Boolean): Boolean;
  begin
    if Vert then
      Result := not(BoundsAnimation and (ttVertical in TouchTracking))
    else
      Result := not(BoundsAnimation and (ttHorizontal in TouchTracking));
  end;

begin
  if FMinTarget.TargetType = TTargetType.Min then
  begin
    if (FViewportPosition.X < FMinTarget.Point.X) and NotBoundsAni(False) then
    begin
      FViewportPosition.X := FMinTarget.Point.X;
      FCurrentVelocity.X := 0;
    end;
    if (FViewportPosition.Y < FMinTarget.Point.Y) and NotBoundsAni(True) then
    begin
      FViewportPosition.Y := FMinTarget.Point.Y;
      FCurrentVelocity.Y := 0;
    end;
  end;
  if FMaxTarget.TargetType = TTargetType.Max then
  begin
    if (FViewportPosition.X > FMaxTarget.Point.X) and NotBoundsAni(False) then
    begin
      FViewportPosition.X := FMaxTarget.Point.X;
      FCurrentVelocity.X := 0;
    end;
    if (FViewportPosition.Y > FMaxTarget.Point.Y) and NotBoundsAni(True) then
    begin
      FViewportPosition.Y := FMaxTarget.Point.Y;
      FCurrentVelocity.Y := 0;
    end;
  end;
end;

procedure TAniCalculations.UpdateTimer;
var
  EnableTimer, NewVisible, ChangeOpacity, LSmall: Boolean;
  LTarget: TTarget;
begin
  EnableTimer := FUpdateTimerCount < 0;
  if not EnableTimer then
  begin
    EnableTimer := Animation and Down;
    if not EnableTimer then
    begin
      LSmall := LowVelocity;
      EnableTimer := (not LSmall) and Animation;
      if not EnableTimer then
        EnableTimer := FindTarget(LTarget);

      if EnableTimer then
        FUpdateTimerCount := 0;

      NewVisible := (not AutoShowing) or Shown;
      ChangeOpacity := ((FOpacity < MaxOpacity) and NewVisible) or
                       ((FOpacity > 0) and (not NewVisible));

      if (not EnableTimer) and
         (not ChangeOpacity) then
      begin
        Inc(FUpdateTimerCount);
        if FUpdateTimerCount < 3 then
          EnableTimer := True;
      end
      else
        EnableTimer := True;
    end;
  end
  else
    Inc(FUpdateTimerCount);
  Enabled := EnableTimer;
end;

procedure TAniCalculations.UpdatePosImmediately(const Force: Boolean = False);
var
  NewViewportPosition, OldViewportPosition: TPointD;
begin
  NewViewportPosition := ViewportPosition;
  OldViewportPosition := NewViewportPosition;
  try
    if FindTarget(FTarget) then
    begin
      if ttHorizontal in InternalTouchTracking then
        NewViewportPosition.X := Target.Point.X;
      if ttVertical in InternalTouchTracking then
        NewViewportPosition.Y := Target.Point.Y;
    end;
  finally
    FViewportPosition := OldViewportPosition;
  end;
  if Force or not IsSmall(TPointD.Create(NewViewportPosition.X - OldViewportPosition.X,
    NewViewportPosition.Y - OldViewportPosition.Y)) then
  begin
    FCurrentVelocity := TPointD.Create(0, 0);
    FViewportPosition := NewViewportPosition;
    UpdateViewportPositionByBounds;
    FUpdateTimerCount := -1;
    UpdateTimer;
  end;
end;

procedure TAniCalculations.InternalCalc(DeltaTime: Double);
var
  NewPoint, NewVelocity: TPointD;
  Done: Boolean;
  LMinVelocity: Double;
begin
  NewPoint := ViewportPosition;
  NewVelocity := FCurrentVelocity;
  FindTarget(FTarget);
  Done := False;
  UpdateTarget;
  DoCalc(DeltaTime, NewPoint, NewVelocity, Done);
  if FTarget.TargetType <> TTargetType.Achieved then
    LMinVelocity := Min(MinVelocity, (MinVelocity * DeltaTime / EpsilonPoint))
  else
    LMinVelocity := MinVelocity;
  if IsSmall(NewVelocity, LMinVelocity) then
  begin
    FCurrentVelocity := TPointD.Create(0, 0);
    if (FTarget.TargetType <> TTargetType.Achieved) and
       (Abs(NewPoint.X - FTarget.Point.X) < EpsilonPoint) then
      NewPoint.X := FTarget.Point.X;

    if (FTarget.TargetType <> TTargetType.Achieved) and
       (Abs(NewPoint.Y - FTarget.Point.Y) < EpsilonPoint) then
      NewPoint.Y := FTarget.Point.Y;
    FLowChanged := True;
    ViewportPosition := NewPoint;
  end
  else
  begin
    FCurrentVelocity := NewVelocity;
    ViewportPosition := NewPoint;
  end;
end;

procedure TAniCalculations.InternalChanged;
var
  T: TDateTime;
begin
  T := Now;
  if (FLastTimeChanged = 0) or ((T - FLastTimeChanged) * SecsPerDay >= EpsilonTime) then
  begin
    try
      DoChanged;
    finally
      FLastTimeChanged := T;
    end;
  end
  else if not InTimerProc then
  begin
    FUpdateTimerCount := -1;
    UpdateTimer;
  end;
end;

procedure TAniCalculations.SetAutoShowing(const Value: Boolean);
begin
  if FAutoShowing <> Value then
  begin
    FAutoShowing := Value;
    if UpdateCount > 0 then
    begin
      if AutoShowing then
        FOpacity := 0
      else
        FOpacity := MaxOpacity;
      InternalChanged;
    end;
    UpdateTimer;
  end;
end;

function TAniCalculations.GetLowVelocity: Boolean;
begin
  Result := IsSmall(FCurrentVelocity, MinVelocity);
end;

procedure TAniCalculations.CalcVelocity(const Time: TDateTime);
var
  D, VAbs: Double;
  I: Integer;
begin
  if Time > 0 then
    FLastTimeCalc := Time
  else
    FLastTimeCalc := Now;
  Clear(FLastTimeCalc);
  if Averaging then
    I := 0
  else if PositionCount > 2 then
    I := PositionCount - 3
  else
    I := PositionCount - 2;
  if (I >= 0) and ((PositionCount - 1) > I) and (InternalTouchTracking <> [])
  then
  begin
    FCurrentVelocity := TPointD.Create(0, 0);
    D := PositionTimes[PositionCount - 1] - PositionTimes[I];
    D := D * (SecsPerDay);
    if D > 0 then
    begin
      D := Max(D, EpsilonTime);
      if ttHorizontal in InternalTouchTracking then
      begin
        FCurrentVelocity.X := Positions[PositionCount - 1].X - Positions[I].X;
        FCurrentVelocity.X := -FCurrentVelocity.X / D;
      end;
      if ttVertical in InternalTouchTracking then
      begin
        FCurrentVelocity.Y := Positions[PositionCount - 1].Y - Positions[I].Y;
        FCurrentVelocity.Y := -FCurrentVelocity.Y / D;
      end;
      VAbs := FCurrentVelocity.Abs;
      D := Max(1, MaxVelocity);
      if (VAbs < MinVelocity) and (not Down) then
        FCurrentVelocity := TPointD.Create(0, 0)
      else if VAbs > D then
      begin
        VAbs := D / VAbs;
        FCurrentVelocity.X := FCurrentVelocity.X * VAbs;
        FCurrentVelocity.Y := FCurrentVelocity.Y * VAbs;
      end;
    end
  end;
  UpdateTimer;
end;

procedure TAniCalculations.Clear(T: TDateTime);
begin
  if FPointTime.Count > 0 then
  begin
    if T <= 0 then
      T := FPointTime[FPointTime.Count - 1].Time;
    while (FPointTime.Count > 0) and
      ((T - FPointTime[0].Time) * (SecsPerDay) > FStorageTime) do
      FPointTime.Delete(0);
  end;
end;

function TAniCalculations.GetPositionCount: Integer;
begin
  if FPointTime <> nil then
    Result := FPointTime.Count
  else
    Result := 0;
end;

function TAniCalculations.PosToView(const APosition: TPointD): TPointD;
var
  X, Y, D: Double;
  P: TPointD;
  function NewDelta(X: Double): Double;
  const
    q = (5 / 6) * (5 / 6) * (5 / 6) * (5 / 6) * (5 / 6) * (5 / 6);
  begin
    if X > D + q then
      Result := D - q + (Power(X - D, 5 / 6))
    else
      Result := X;
  end;

begin
  P := TPointD.Create(FDownPosition.X + FDownPoint.X, FDownPosition.Y + FDownPoint.Y);
  D := Min(24, Max(1, FDeadZone));
  X := P.X - APosition.X;
  Y := P.Y - APosition.Y;
  if (FMinTarget.TargetType = TTargetType.Min) and (X < FMinTarget.Point.X) then
    X := FMinTarget.Point.X - NewDelta(FMinTarget.Point.X - X);
  if (FMaxTarget.TargetType = TTargetType.Max) and (X > FMaxTarget.Point.X) then
    X := FMaxTarget.Point.X + NewDelta(X - FMaxTarget.Point.X);
  if (FMinTarget.TargetType = TTargetType.Min) and (Y < FMinTarget.Point.Y) then
    Y := FMinTarget.Point.Y - NewDelta(FMinTarget.Point.Y - Y);
  if (FMaxTarget.TargetType = TTargetType.Max) and (Y > FMaxTarget.Point.Y) then
    Y := FMaxTarget.Point.Y + NewDelta(Y - FMaxTarget.Point.Y);
  Result := TPointD.Create(P.X - X, P.Y - Y);
end;

function TAniCalculations.GetPositions(const Index: Integer): TPointD;
begin
  if (index < 0) or (index >= PositionCount) then
    raise EListError.CreateFMT(sArgumentOutOfRange_Index,
      [index, PositionCount]);
  Result := FPointTime[index].Point;
end;

function TAniCalculations.GetPositionTimes(const Index: Integer): TDateTime;
begin
  if (index < 0) or (index >= PositionCount) then
    raise EListError.CreateFMT(sArgumentOutOfRange_Index,
      [index, PositionCount]);
  Result := FPointTime[index].Time;
end;

function TAniCalculations.AddPointTime(const X, Y: Double;
  const Time: TDateTime): TPointTime;
begin
  if Time > 0 then
    Result.Time := Time
  else
    Result.Time := Now;
  Result.Point.X := X;
  Result.Point.Y := Y;
  Result.Point := PosToView(Result.Point);
  if FPointTime.Count > 0 then
  begin
    if (not(ttHorizontal in TouchTracking)) then
      Result.Point.X := FPointTime[FPointTime.Count - 1].Point.X;
    if (not(ttVertical in TouchTracking)) then
      Result.Point.Y := FPointTime[FPointTime.Count - 1].Point.Y;
  end;
  if (FPointTime.Count = 0) or
    (Result.Point <> FPointTime[FPointTime.Count - 1].Point) then
    FPointTime.Add(Result)
  else
  begin
    Result.Point := FPointTime[FPointTime.Count - 1].Point;
    FPointTime[FPointTime.Count - 1] := Result;
  end;
end;

procedure TAniCalculations.MouseDown(X, Y: Double);
begin
  if Down then
    Exit;
  Down := True;
  FindTarget(FLastTarget);
  FCancelTargetX := False;
  FCancelTargetY := False;
  FMoved := False;
  FDownPoint := TPointD.Create(X, Y);
  FDownPosition := ViewportPosition;
  AddPointTime(X, Y, FUpDownTime);
  UpdateTimer;
end;

procedure TAniCalculations.MouseMove(X, Y: Double);
var
  NewVal: TPointTime;
  NewViewportPosition: TPointD;
  D, DZ: Double;
  P: TPointD;
begin
  if Down and ([ttVertical, ttHorizontal] * TouchTracking <> []) then
  begin
    if not FMoved then
    begin
      P := TPointD.Create(X, Y);
      if TouchTracking = [ttVertical, ttHorizontal] then
        D := P.Distance(FDownPoint)
      else if (TouchTracking = [ttVertical]) then
        D := Abs(P.Y - FDownPoint.Y)
      else if (TouchTracking = [ttHorizontal]) then
        D := Abs(P.X - FDownPoint.X)
      else
        D := 0;
      if Averaging and Animation then
      begin
        DZ := Max(FDeadZone, 1);
        if D > DZ then
        begin
          FMoved := True;
          FDownPoint := TPointD.Create(X, Y);
          FDownPosition := ViewportPosition;
        end;
      end
      else
        FMoved := D > 0;
      if FMoved then
      begin
        FMoved := True;
        InternalStart;
      end;
    end;
    if FMoved then
    begin
      NewVal := AddPointTime(X, Y);
      if (ttHorizontal in TouchTracking) then
        NewViewportPosition.X := FDownPosition.X - (NewVal.Point.X - FDownPoint.X)
      else
        NewViewportPosition.X := ViewportPosition.X;
      if (ttVertical in TouchTracking) then
        NewViewportPosition.Y := FDownPosition.Y - (NewVal.Point.Y - FDownPoint.Y)
      else
        NewViewportPosition.Y := ViewportPosition.Y;
      Clear;
      ViewportPosition := NewViewportPosition;
      UpdateTarget;
    end;
  end;
end;

procedure TAniCalculations.MouseUp(X, Y: Double);
begin
  if Down then
  begin
    MouseMove(X, Y);
    CalcVelocity;
    FUpVelocity := CurrentVelocity;
    FUpPosition := ViewportPosition;
    UpdateTimer;
    if (not Animation) then
      UpdateViewportPositionByBounds;
    Down := False;
  end;
end;

procedure TAniCalculations.MouseLeave;
var
  PointTime: TPointTime;
begin
  if Down then
  begin
    if PositionCount > 0 then
    begin
      PointTime := FPointTime[PositionCount - 1];
      PointTime.Time := Now;
      FPointTime[PositionCount - 1] := PointTime;
    end;
    CalcVelocity;
    FUpVelocity := CurrentVelocity;
    FUpPosition := ViewportPosition;
    UpdateTimer;
    if (not Enabled) and (not Animation) then
      UpdateViewportPositionByBounds;
    Down := False;
  end;
end;

procedure TAniCalculations.MouseWheel(X, Y: Double);
var
  DX, DY: Double;
  NewTarget: TTarget;
begin
  DX := RoundTo(X, EpsilonRange);
  DY := RoundTo(Y, EpsilonRange);
  if (DX <> 0) or (DY <> 0) then
  begin
    NewTarget.TargetType := TTargetType.Other;
    if FMouseTarget.TargetType <> TTargetType.Other then
      NewTarget.Point := ViewportPosition
    else
      NewTarget.Point := FMouseTarget.Point;
    NewTarget.Point.Offset(DX, DY);
    FUpdateTimerCount := -1;
    SetMouseTarget(NewTarget);
  end;
end;

procedure TAniCalculations.SetMouseTarget(Value: TTarget);
var
  NewTargets: array of TTarget;
  I: Integer;
  LTarget: TTarget;
begin
  if Value.TargetType in [TTargetType.Min, TTargetType.Max] then
    Exit;
  LTarget := Value;
  SetLength(NewTargets, 0);
  for I := low(FTargets) to high(FTargets) do
    if FTargets[I].TargetType in [TTargetType.Min, TTargetType.Max] then
    begin
      SetLength(NewTargets, Length(NewTargets) + 1);
      NewTargets[Length(NewTargets) - 1] := FTargets[I];
      if (FTargets[I].TargetType = TTargetType.Min) then
      begin
        LTarget.Point.X := Max(LTarget.Point.X, FTargets[I].Point.X);
        LTarget.Point.Y := Max(LTarget.Point.Y, FTargets[I].Point.Y);
      end;
      if (FTargets[I].TargetType = TTargetType.Max) then
      begin
        LTarget.Point.X := Min(LTarget.Point.X, FTargets[I].Point.X);
        LTarget.Point.Y := Min(LTarget.Point.Y, FTargets[I].Point.Y);
      end;
    end;
  if LTarget.TargetType = TTargetType.Achieved then
  begin
    for I := low(FTargets) to high(FTargets) do
      if (not(FTargets[I].TargetType in [TTargetType.Min, TTargetType.Max])) and
        (FTargets[I].Point <> FMouseTarget.Point) then
      begin
        SetLength(NewTargets, Length(NewTargets) + 1);
        NewTargets[Length(NewTargets) - 1] := FTargets[I];
      end;
    FMouseTarget := LTarget;
  end
  else
  begin
    FMouseTarget := LTarget;
    if (FMouseTarget.TargetType <> TTargetType.Achieved) then
    begin
      SetLength(NewTargets, Length(NewTargets) + 1);
      NewTargets[Length(NewTargets) - 1] := FMouseTarget;
    end;
  end;
  SetTargets(NewTargets);
end;

{$ENDREGION}

procedure RegisterAliases;
begin
  AddEnumElementAliases(TypeInfo(TAniCalculations.TTargetType), ['ttAchieved', 'ttMax', 'ttMin', 'ttOther']);
end;

procedure UnregisterAliases;
begin
  RemoveEnumElementAliases(TypeInfo(TAniCalculations.TTargetType));
end;

initialization
  RegisterAliases;
  EpsilonRange := Trunc(Log10(EpsilonPoint));

finalization
  UnregisterAliases;
end.
