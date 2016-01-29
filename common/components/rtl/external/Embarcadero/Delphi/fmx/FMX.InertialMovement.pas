{ ******************************************************* }
{                                                         }
{               Delphi FireMonkey Platform                }
{                                                         }
{       Copyright(c) 2013 Embarcadero Technologies, Inc.  }
{                                                         }
{ ******************************************************* }

unit FMX.InertialMovement;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Math,
  System.Generics.Collections, FMX.Types, FMX.Platform;

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
    TTargetType = (ttAchieved, ttMax, ttMin, ttOther);
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
    FOwner: TPersistent;
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
    procedure UpdatePosImmediately;
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

    /// <summary>
    /// Coefficient of dry friction. Deceleration displacement after the user has moved image.
    /// </summary>
    property DecelerationRate: Double read FDecelerationRate
                                     write FDecelerationRate
                                    stored DecelerationRateStored nodefault;
    /// <summary>
    /// Coefficient of border elasticity.
    /// </summary>
    property Elasticity: Double read FElasticity
                               write FElasticity
                              stored ElasticityStored nodefault;
    /// <summary>
    /// The storage time of coordinates. Used to obtain the velocity and direction of displacement.
    /// </summary>
    property StorageTime: Double read FStorageTime
                                write FStorageTime
                               stored StorageTimeStored nodefault;
    /// <summary>
    /// The current speed of movement (pixels per second)
    /// </summary>
    property CurrentVelocity: TPointD read FCurrentVelocity;
    /// <summary>
    /// The current Position of visible region (top left corner)
    /// </summary>
    property ViewportPosition: TPointD read FViewportPosition
                                      write SetViewportPosition;
    property ViewportPositionF: TPointF read GetViewportPositionF
                                       write SetViewportPositionF;
    /// <summary>
    /// The last time (see function Now) of calculated properties of ViewportPosition and CurrentVelocity
    /// </summary>
    property LastTimeCalc: TDateTime read FLastTimeCalc;
    property Down: Boolean read FDown write SetDown;
    property Opacity: Single read GetOpacity;
    property InTimerProc: Boolean read FInTimerProc;
    property Moved: Boolean read FMoved;
    property LowVelocity: Boolean read GetLowVelocity;

    property OnStart: TNotifyEvent read FOnStart write FOnStart;
    property OnChanged: TNotifyEvent read FOnTimer write FOnTimer;
    property OnStop: TNotifyEvent read FOnStop write FOnStop;
  end;
{$ENDREGION}

implementation

uses
  System.RTLConsts;

const
  EpsilonPoint = 0.1;
  EpsilonRange = -1; // Trunc(Log10(EpsilonPoint));
  DefaultOpacityTime = 0.3;
  MaxOpacity = 1.5;
  EpsilonTime = 0.01;
  StopTime = 0.007;


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
  FPointTime := TList<TPointTime>.Create;
  if not TPlatformServices.Current.SupportsPlatformService(IFMXTimerService,
    IInterface(FPlatformTimer)) then
    raise EUnsupportedPlatformService.Create('IFMXTimerService');
  Assign(nil);
end;

destructor TAniCalculations.Destroy;
begin
  StopTimer;
  FreeAndNil(FPointTime);
  inherited;
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
    LSource.GetTargets(LTargets);
    SetTargets(LTargets);
    DecelerationRate := LSource.DecelerationRate;
    Elasticity := LSource.Elasticity;
    StorageTime := LSource.StorageTime;
  end
  else if not Assigned(Source) then
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
  if FMouseTarget.TargetType = ttOther then
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
    FCurrentVelocity.Create(0, 0);
    UpdateTimer;
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
  Target: TTarget;
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
        FCurrentVelocity.Create(0, 0);
      FLastTimeCalc := 0;
      FUpDownTime := T;
      Target.TargetType := ttAchieved;
      Target.Point.Create(0, 0);
      SetMouseTarget(Target);
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
  Target: TTarget;
begin
  if (not FInDoStop) and (FStarted) then
  begin
    FInDoStop := True;
    try
      Target.TargetType := ttAchieved;
      Target.Point.Create(0, 0);
      SetMouseTarget(Target);
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
      InternalStart;
      StartTimer;
      FEnabled := Value;
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
    if FEnabled and (FInterval > 0) then
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
  Target: TTarget;
begin
  OldViewportPosition := FViewportPosition;
  FViewportPosition := Value;
  UpdateViewportPositionByBounds;
  LChanged := FViewportPosition <> OldViewportPosition;
  if LChanged and (not FInTimerProc) then
  begin
    Target.TargetType := ttAchieved;
    Target.Point.Create(0, 0);
    SetMouseTarget(Target);
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
  NewValue.Create(Value);
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
  procedure UpdatePhysicalParameters(const Target: Double;
    var Pos, Velocity: Double;
    const ADecelerationRate: Double;
    const EnableTarget: Boolean;
    const CancelTarget: Boolean);
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
      aT := (LSign * Ceil(Elasticity * R));
      aT := aT + (aTDecelerationRate / DecelerationRate * 8);
    end
    else
      aT := aTDecelerationRate;

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

    UpdatePhysicalParameters(Target.Point.X,
      NewPoint.X,
      NewVelocity.X,
      Abs(LDecelerationRate * NewVelocity.X),
      EnableTargetX,
      CancelTargetX);
    UpdatePhysicalParameters(Target.Point.Y,
      NewPoint.Y,
      NewVelocity.Y,
      Abs(LDecelerationRate * NewVelocity.Y),
      EnableTargetY,
      CancelTargetY);
  end;

begin
  if not Done then
  begin
    EnableTargetX := ([ttHorizontal] * InternalTouchTracking <> []) and
      (Target.TargetType <> ttAchieved) and
      (AniSign(NewPoint.X, Target.Point.X, EpsilonPoint) <> 0);

    EnableTargetY := ([ttVertical] * InternalTouchTracking <> []) and
      (Target.TargetType <> ttAchieved) and
      (AniSign(NewPoint.Y, Target.Point.Y, EpsilonPoint) <> 0);

    UpdateParams;

    EnableTargetX := ([ttHorizontal] * InternalTouchTracking <> []) and
      (Target.TargetType <> ttAchieved) and
      (AniSign(NewPoint.X, Target.Point.X, EpsilonPoint) <> 0);

    EnableTargetY := ([ttVertical] * InternalTouchTracking <> []) and
      (Target.TargetType <> ttAchieved) and
      (AniSign(NewPoint.Y, Target.Point.Y, EpsilonPoint) <> 0);

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
    FCurrentVelocity.Create(0, 0);
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
var
  I: Integer;
  function FindMaxTarget(var Target: TTarget): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to TargetCount - 1 do
      if (FTargets[I].TargetType = ttMax) then
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
      if (FTargets[I].TargetType = ttMin) then
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

begin
  SetLength(FTargets, Length(ATargets));
  for I := 0 to Length(ATargets) - 1 do
    FTargets[I] := ATargets[I];

  if not FindMinTarget(FMinTarget) then
  begin
    FMinTarget.TargetType := ttAchieved;
    FMinTarget.Point.Create(0, 0);
  end;
  if not FindMaxTarget(FMaxTarget) then
  begin
    FMaxTarget.TargetType := ttAchieved;
    FMaxTarget.Point.Create(0, 0);
  end;

  if IsSmall(FCurrentVelocity, MinVelocity) then
    FLastTimeCalc := 0;
  UpdateTimer;
  if (not FDown) and (not Animation) and (InternalTouchTracking <> []) then
    UpdatePosImmediately;
end;

function TAniCalculations.FindTarget(var Target: TTarget): Boolean;
var
  I: Integer;
  MinR: Extended;
  MinFound, MaxFound: Boolean;
  X, Y: Double;
  function FindMinMaxTarget(var Target: TTarget): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    Target.TargetType := ttAchieved;
    Target.Point := ViewportPosition;

    for I := 0 to TargetCount - 1 do
      if (FTargets[I].TargetType = ttMax) then
      begin
        if (Target.Point.X > FTargets[I].Point.X) then
        begin
          Target.Point.X := FTargets[I].Point.X;
          Result := True;
        end;
        if (Target.Point.Y > FTargets[I].Point.Y) then
        begin
          Target.Point.Y := FTargets[I].Point.Y;
          Result := True;
        end;
      end;
    for I := 0 to TargetCount - 1 do
      if (FTargets[I].TargetType = ttMin) then
      begin
        if (Target.Point.X < FTargets[I].Point.X) then
        begin
          Target.Point.X := FTargets[I].Point.X;
          Result := True;
        end;
        if (Target.Point.Y < FTargets[I].Point.Y) then
        begin
          Target.Point.Y := FTargets[I].Point.Y;
          Result := True;
        end;
      end;
    if Result then
      Target.TargetType := ttMin;
  end;
  procedure UpdateResult(P: TPointD);
  var
    R: Extended;
  begin
    R := ViewportPosition.Distance(P);
    if R < MinR then
    begin
      MinR := R;
      Result := True;
      Target.Point := P;
      Target.TargetType := ttOther;
    end;
  end;

begin
  Result := False;
  MinR := MaxInt;
  MinFound := FMinTarget.TargetType = ttMin;
  MaxFound := FMaxTarget.TargetType = ttMax;
  for I := 0 to TargetCount - 1 do
    if (FTargets[I].TargetType = ttOther) then
    begin
      if FTargets[I].Point = ViewportPosition then
      begin
        Target.Point := FTargets[I].Point;
        Target.TargetType := ttAchieved;
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
      Target.TargetType := ttAchieved;
      Result := False;
    end;
  end
  else
  begin
    if MinFound or MaxFound then
      Result := FindMinMaxTarget(Target)
    else
    begin
      Target.TargetType := ttAchieved;
      Target.Point := ViewportPosition;
    end;
  end;
end;

procedure TAniCalculations.UpdateTarget;
var
  SignPos: TValueSign;
begin
  FindTarget(FTarget);
  if (FTarget.TargetType = ttAchieved) or
    (not SameValue(FLastTarget.Point.X, FTarget.Point.X)) then
    FCancelTargetX := False;
  if (FTarget.TargetType = ttAchieved) or
    (not SameValue(FLastTarget.Point.Y, FTarget.Point.Y)) then
    FCancelTargetY := False;
  FLastTarget := FTarget;
  if Animation and
    Down and
    Moved and
    (not InTimerProc) and
    (PositionCount > 1) and
    (FMinTarget.TargetType <> ttAchieved) and
    (FMaxTarget.TargetType <> ttAchieved) and
    (FTarget.TargetType <> ttAchieved) then
  begin
    if not SameValue(FMinTarget.Point.X, FMaxTarget.Point.X) then
    begin
      SignPos := System.Math.Sign(Positions[PositionCount - 1].X -
        Positions[PositionCount - 2].X);
      FCancelTargetX := (SignPos <> 0) and
        (SignPos = System.Math.Sign(ViewportPosition.X - FTarget.Point.X));
    end;
    if not SameValue(FMinTarget.Point.Y, FMaxTarget.Point.Y) then
    begin
      SignPos := System.Math.Sign(Positions[PositionCount - 1].Y -
        Positions[PositionCount - 2].Y);
      FCancelTargetY := (SignPos <> 0) and
        (SignPos = System.Math.Sign(ViewportPosition.Y - FTarget.Point.Y));
    end;
  end;
end;

procedure TAniCalculations.UpdateViewportPositionByBounds;
  function NotBounsAni(const Vert: Boolean): Boolean;
  begin
    if Vert then
      Result := not(BoundsAnimation and (ttVertical in TouchTracking))
    else
      Result := not(BoundsAnimation and (ttHorizontal in TouchTracking));
  end;

begin
  if FMinTarget.TargetType = ttMin then
  begin
    if (FViewportPosition.X < FMinTarget.Point.X) and NotBounsAni(False) then
    begin
      FViewportPosition.X := FMinTarget.Point.X;
      FCurrentVelocity.X := 0;
    end;
    if (FViewportPosition.Y < FMinTarget.Point.Y) and NotBounsAni(True) then
    begin
      FViewportPosition.Y := FMinTarget.Point.Y;
      FCurrentVelocity.Y := 0;
    end;
  end;
  if FMaxTarget.TargetType = ttMax then
  begin
    if (FViewportPosition.X > FMaxTarget.Point.X) and NotBounsAni(False) then
    begin
      FViewportPosition.X := FMaxTarget.Point.X;
      FCurrentVelocity.X := 0;
    end;
    if (FViewportPosition.Y > FMaxTarget.Point.Y) and NotBounsAni(True) then
    begin
      FViewportPosition.Y := FMaxTarget.Point.Y;
      FCurrentVelocity.Y := 0;
    end;
  end;
end;

procedure TAniCalculations.UpdateTimer;
var
  EnableTimer, NewVisible, ChangeOpacity, LSmall: Boolean;
  Target: TTarget;
begin
  EnableTimer := (FUpdateTimerCount < 0);
  if not EnableTimer then
  begin
    EnableTimer := (Animation and Down);
    if not EnableTimer then
    begin
      LSmall := LowVelocity;
      EnableTimer := (not LSmall) and Animation;
      if not EnableTimer then
        EnableTimer := FindTarget(Target);

      if EnableTimer then
        FUpdateTimerCount := 0;

      NewVisible := (not AutoShowing) or (Shown);
      ChangeOpacity := ((FOpacity < MaxOpacity) and (NewVisible)) or
                       ((FOpacity > 0) and (not NewVisible));

      if (not EnableTimer) and
         (not ChangeOpacity) then
      begin
        inc(FUpdateTimerCount);
        if FUpdateTimerCount < 3 then
          EnableTimer := True;
      end
      else
        EnableTimer := True;
    end;
  end
  else
    inc(FUpdateTimerCount);
  Enabled := EnableTimer;
end;

procedure TAniCalculations.UpdatePosImmediately;
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
  if not IsSmall(TPointD.Create(NewViewportPosition.X - OldViewportPosition.X,
                                NewViewportPosition.Y - OldViewportPosition.Y)) then
  begin
    FCurrentVelocity.Create(0, 0);
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
  if FTarget.TargetType <> TTargetType.ttAchieved then
    LMinVelocity := Min(MinVelocity, (MinVelocity * DeltaTime / EpsilonPoint))
  else
    LMinVelocity := MinVelocity;
  if IsSmall(NewVelocity, LMinVelocity) then
  begin
    FCurrentVelocity.Create(0, 0);
    if (FTarget.TargetType <> TTargetType.ttAchieved) and
       (Abs(NewPoint.X - FTarget.Point.X) < EpsilonPoint) then
      NewPoint.X := FTarget.Point.X;

    if (FTarget.TargetType <> TTargetType.ttAchieved) and
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
  if (FLastTimeChanged = 0) or
    ((T - FLastTimeChanged) * SecsPerDay >= EpsilonTime) then
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
    FCurrentVelocity.Create(0, 0);
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
        FCurrentVelocity.Create(0, 0)
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
  if Assigned(FPointTime) then
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
  P.Create(FDownPosition.X + FDownPoint.X,
    FDownPosition.Y + FDownPoint.Y);
  D := Min(24, Max(1, FDeadZone));
  X := P.X - APosition.X;
  Y := P.Y - APosition.Y;
  if (FMinTarget.TargetType = ttMin) and (X < FMinTarget.Point.X) then
    X := FMinTarget.Point.X - NewDelta(FMinTarget.Point.X - X);
  if (FMaxTarget.TargetType = ttMax) and (X > FMaxTarget.Point.X) then
    X := FMaxTarget.Point.X + NewDelta(X - FMaxTarget.Point.X);
  if (FMinTarget.TargetType = ttMin) and (Y < FMinTarget.Point.Y) then
    Y := FMinTarget.Point.Y - NewDelta(FMinTarget.Point.Y - Y);
  if (FMaxTarget.TargetType = ttMax) and (Y > FMaxTarget.Point.Y) then
    Y := FMaxTarget.Point.Y + NewDelta(Y - FMaxTarget.Point.Y);
  Result.Create(P.X - X, P.Y - Y);
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
  FDownPoint.Create(X, Y);
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
      P.Create(X, Y);
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
          FDownPoint.Create(X, Y);
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
    NewTarget.TargetType := ttOther;
    if FMouseTarget.TargetType <> ttOther then
      NewTarget.Point := ViewportPosition
    else
      NewTarget.Point := FMouseTarget.Point;
    NewTarget.Point.Offset(DX, DY);
    FUpdateTimerCount := 0;
    FUpdateTimerCount := -1;
    SetMouseTarget(NewTarget);
  end;
end;

procedure TAniCalculations.SetMouseTarget(Value: TTarget);
var
  NewTargets: array of TTarget;
  I: Integer;
  Target: TTarget;
begin
  if Value.TargetType in [ttMin, ttMax] then
    Exit;
  Target := Value;
  SetLength(NewTargets, 0);
  for I := low(FTargets) to high(FTargets) do
    if FTargets[I].TargetType in [ttMin, ttMax] then
    begin
      SetLength(NewTargets, Length(NewTargets) + 1);
      NewTargets[Length(NewTargets) - 1] := FTargets[I];
      if (FTargets[I].TargetType = ttMin) then
      begin
        Target.Point.X := Max(Target.Point.X, FTargets[I].Point.X);
        Target.Point.Y := Max(Target.Point.Y, FTargets[I].Point.Y);
      end;
      if (FTargets[I].TargetType = ttMax) then
      begin
        Target.Point.X := Min(Target.Point.X, FTargets[I].Point.X);
        Target.Point.Y := Min(Target.Point.Y, FTargets[I].Point.Y);
      end;
    end;
  if Target.TargetType = ttAchieved then
  begin
    for I := low(FTargets) to high(FTargets) do
      if (not(FTargets[I].TargetType in [ttMin, ttMax])) and
        (FTargets[I].Point <> FMouseTarget.Point) then
      begin
        SetLength(NewTargets, Length(NewTargets) + 1);
        NewTargets[Length(NewTargets) - 1] := FTargets[I];
      end;
    FMouseTarget := Target;
  end
  else
  begin
    FMouseTarget := Target;
    if (FMouseTarget.TargetType <> ttAchieved) then
    begin
      SetLength(NewTargets, Length(NewTargets) + 1);
      NewTargets[Length(NewTargets) - 1] := FMouseTarget;
    end;
  end;
  SetTargets(NewTargets);
end;

{$ENDREGION}

end.
