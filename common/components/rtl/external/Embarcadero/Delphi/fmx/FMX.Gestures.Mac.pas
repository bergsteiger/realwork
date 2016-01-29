{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Gestures.Mac;

interface

uses FMX.Types, FMX.Gestures, System.Types;

type
  TPlatformGestureEngine = class(TGestureEngine)
  strict private
    class var FDefaultEngineClass: TGestureEngineClass;
    class var FRecognizer: TCustomGestureRecognizer;
    class var FDefaultRecognizerClass: TCustomGestureRecognizerClass;
    class function GetRecognizer: TCustomGestureRecognizer; static;
    class procedure SetDefaultRecognizerClass(const Value: TCustomGestureRecognizerClass); static;
    class destructor Destroy;
    class constructor Create;
  strict private
    FControl: TFmxObject;
    FGestureList: TGestureList;
    function GetGestureList: TGestureList;
  protected
    class function GetGestureEngine(const AControl: TFmxObject): TGestureEngine; override;
    procedure SetInitialPoint(const Value: TPointF); override;
  public
    procedure AddPoint(X, Y: Extended);
    procedure AddPoints(Count: Integer);
    class procedure CreateEngine(const AControl: TFmxObject);
    class function IsGesture(const Points: array of TPointF;
      Items: TGestureList; GestureTypes: TGestureTypes;
      var EventInfo: TGestureEventInfo): Boolean;
    class property DefaultEngineClass: TGestureEngineClass
      read FDefaultEngineClass write FDefaultEngineClass;
    class property Recognizer: TCustomGestureRecognizer read GetRecognizer;
    class property DefaultRecognizerClass: TCustomGestureRecognizerClass
      read FDefaultRecognizerClass write SetDefaultRecognizerClass;
  public
    property GestureList: TGestureList read GetGestureList;
    constructor Create(const AControl: TFmxObject); override;
  end;

  TMacGestureEngine = class sealed(TPlatformGestureEngine)
  protected
    function GetActive: Boolean; override;
    procedure SetActive(const Value: Boolean); override;
    function GetFlags: TCustomGestureEngine.TGestureEngineFlags; override;
  public
    constructor Create(const AControl: TFmxObject); override;
  end;

  TGestureRecognizer = class(TCustomGestureRecognizer)
  public
    function CopyPoints(Points: TGesturePoints): TGesturePointArray;
    function InterpolatePoints(const Points: array of TPointF)
      : TGesturePointArray;
    function IsPointsGesture(const Points, GesturePoints: array of TPointF;
      GestureID: TGestureID; Deviation: Integer; ErrorMargin: Integer;
      var Percentages: array of Double): Integer;
    function Match(const Points, GesturePoints: array of TPointF;
      const Options: TGestureOptions; GestureID: TGestureID;
      Deviation, ErrorMargin: Integer): Single; override;
    function NormalizePoints(const Points: array of TPointF)
      : TGesturePointArray; override;
    function ScalePoints(const Points, GesturePoints: array of TPointF;
      MinScale: Integer; Scaling: Boolean = False): TGesturePointArray;
      override;
    procedure Reset; override;
    function RotatePoints(const Points, GesturePoints: array of TPointF;
      ErrorMargin: Integer; var Angle: Double): TGesturePointArray;
    function RemoveDuplicates(const Points: array of TPointF)
      : TGesturePointArray;
  end;

implementation

uses System.Math, System.Classes, System.SysUtils, FMX.Consts, System.UITypes,
  System.Generics.Collections;

{ TPlatformGestureEngine }

function GesturePointsToArray(const Source: TGesturePoints): TGesturePointArray;
var
  I: Integer;
begin
  SetLength(Result, Source.Count);
  for I := 0 to Source.Count - 1 do
    Result[I] := TPointF(Source[I]);
end;

procedure TPlatformGestureEngine.AddPoint(X, Y: Extended);
var
  StepX, StepY: Single;
  DeltaXF, DeltaYF: Single;
  I, DeltaX, DeltaY: Integer;
  LastPoint, NextPoint: TPointF;
  CountX, CountY, Count: Integer;
begin
  if not Assigned(FPoints) then
    FPoints := TGesturePoints.Create;

  if FPoints.Count = 0 then
    FPoints.Add(PointF(X, Y))
  else
  begin
    NextPoint := PointF(X, Y);
    LastPoint := FPoints[FPoints.Count - 1];

    // Determine distance between points
    DeltaXF := Abs(NextPoint.X - LastPoint.X);
    DeltaYF := Abs(NextPoint.Y - LastPoint.Y);

    // If points are too close together discard the new point
    if (DeltaXF < 1) and (DeltaYF < 1) then
      Exit;

    //If the difference is too small, use the last coordinate.
    if DeltaXF < 1 then
      NextPoint.X := LastPoint.X;
    if DeltaYF < 1 then
      NextPoint.Y := LastPoint.Y;

      // If points are too far apart insert intermediate points.
      if (DeltaXF > 6) or (DeltaYF > 6) then
      begin
        // Determine integer distance between points.
        DeltaX := Round(DeltaXF);
        DeltaY := Round(DeltaYF);

        // Determine how many points to insert
        CountX := DeltaX div 5;
        if (DeltaX mod 5) = 0 then
          Dec(CountX);
        CountY := DeltaY div 5;
        if (DeltaY mod 5) = 0 then
          Dec(CountY);
        Count := Max(CountX, CountY);

        // Determine spacing between inserted points
        StepX := (NextPoint.X - LastPoint.X) / Count;
        StepY := (NextPoint.Y - LastPoint.Y) / Count;

        // Insert points
        for I := 1 to Count - 1 do
          FPoints.Add(PointF(LastPoint.X + Round(StepX * I),
            LastPoint.Y + Round(StepY * I)));
      end;

    // Add captured point
    FPoints.Add(NextPoint);
  end;
end;

procedure TPlatformGestureEngine.AddPoints(Count: Integer);
var
  Index: Integer;
  DeltaX, DeltaY: Single;
begin
  DeltaX := FPoints[FPoints.Count - 1].X - FPoints[FPoints.Count - 2].X;
  DeltaY := FPoints[FPoints.Count - 1].Y - FPoints[FPoints.Count - 2].Y;

  for Index := 0 to Count - 1 do
    AddPoint(FPoints[FPoints.Count - 1].X + DeltaX, FPoints[FPoints.Count - 1].Y + DeltaY);
end;

constructor TPlatformGestureEngine.Create(const AControl: TFmxObject);
begin
  inherited;
  FControl := AControl;
end;

class constructor TPlatformGestureEngine.Create;
begin
  FRecognizer := nil;
  FDefaultRecognizerClass := TGestureRecognizer;
end;

class procedure TPlatformGestureEngine.CreateEngine(const AControl: TFmxObject);
begin
  DefaultRecognizerClass := TGestureRecognizer;
  if not(csDesigning in AControl.ComponentState) then
    if not Assigned(AControl.Touch.GestureEngine) then
    begin
      AControl.Touch.GestureEngine := TMacGestureEngine.GetGestureEngine
        (AControl);
    end;
end;

class destructor TPlatformGestureEngine.Destroy;
begin
  if Assigned(FRecognizer) then
      FreeAndNil(FRecognizer);
end;

class function TPlatformGestureEngine.GetGestureEngine(const AControl: TFmxObject): TGestureEngine;
begin
  Result := TMacGestureEngine.Create(AControl);
end;

class function TPlatformGestureEngine.GetRecognizer: TCustomGestureRecognizer;
begin
  if not Assigned(FRecognizer) then
  begin
    FRecognizer := DefaultRecognizerClass.Create;
  end;
  Result := FRecognizer;
end;

class function TPlatformGestureEngine.IsGesture(const Points: array of TPointF;
  Items: TGestureList; GestureTypes: TGestureTypes;
  var EventInfo: TGestureEventInfo): Boolean;
var
  LItem: TCustomGestureCollectionItem;
  LData: TStandardGestureData;
  LWeight, TempWeight: Single;
  I: Integer;
begin
  Result := False;
  FillChar(EventInfo, Sizeof(EventInfo), 0);

  if not Assigned(Items) then
    Exit;

  LWeight := 0;

  // Process standard gestures
  if TGestureType.gtStandard in GestureTypes then
    for I := 0 to Items.Count - 1 do
    begin
      LItem := Items[I];
      if LItem.GestureType = TGestureType.gtStandard then
      begin
        if not FindStandardGesture(LItem.GestureID, LData) then
          raise EGestureException.CreateResFmt(@SInvalidGestureID,
            [LItem.GestureID]);

        TempWeight := Recognizer.Match(Points, LData.Points, LData.Options,
          LData.GestureID, LData.Deviation, LData.ErrorMargin);

        if TempWeight > LWeight then
        begin
          LWeight := TempWeight;
          EventInfo.GestureID := LItem.GestureID;
        end;
      end;
    end;

  if LWeight > 0 then
    Exit(True);

  // Process custom gestures
  if CustomGestureTypes * GestureTypes = CustomGestureTypes then
    for I := 0 to Items.Count - 1 do
    begin
      LItem := Items[I];
      if LItem.GestureType in CustomGestureTypes then
      begin
        TempWeight := Recognizer.Match(Points, LItem.Points, LItem.Options,
          LItem.GestureID, LItem.Deviation, LItem.ErrorMargin);

        if TempWeight > LWeight then
        begin
          LWeight := TempWeight;
          EventInfo.GestureID := LItem.GestureID;
        end;
      end;
    end;

  if LWeight > 0 then
    Exit(True);

  // No gesture was recognized. Return True if 3 or more points are in the list
  // so the listener is notified that a gesture occurred but wasn't recognized
  // EventInfo.GestureID := sgiNoGesture;
  Result := Length(Points) >= 3;
end;

function TPlatformGestureEngine.GetGestureList: TGestureList;
begin
  Result := FGestureList;
end;

class procedure TPlatformGestureEngine.SetDefaultRecognizerClass(
  const Value: TCustomGestureRecognizerClass);
begin
  if Value <> FDefaultRecognizerClass then
  begin
    FDefaultRecognizerClass := Value;
    if Assigned(FRecognizer) then
      FreeAndNil(FRecognizer);
  end;
end;

procedure TPlatformGestureEngine.SetInitialPoint(const Value: TPointF);
begin
  inherited;

  if not Assigned(FGestureList) then
    FGestureList := TGestureList.Create;

  FGestureList.Clear;
  GetCompleteGestureList(FControl, FGestureList);
end;

{ TMacGestureEngine }

function TMacGestureEngine.GetActive: Boolean;
begin
  Result := False;
end;

procedure TMacGestureEngine.SetActive(const Value: Boolean);
begin
  inherited;

end;

function TMacGestureEngine.GetFlags: TCustomGestureEngine.TGestureEngineFlags;
begin
  Result := [];
end;

constructor TMacGestureEngine.Create(const AControl: TFmxObject);
begin
  inherited;
end;

{ TGestureRecognizer }

function PointInCircle(const Point, Center: TPointF; Radius: Integer): Boolean;
begin
  if Radius > 0 then
  begin
    Result := Sqr((Point.X - Center.X) / Radius) +
      Sqr((Point.Y - Center.Y) / Radius) <= 1;
  end
  else
  begin
    Result := False;
  end;
end;

// Takes into account margin of error returning a percentage of match.
// 100% match will be margin of error of deviation from the source point.
// 0% will be at deviation away and beyond.
function CheckPoint(const Point, Source: TPointF;
  Deviation, ErrorMargin: Integer): Double;
var
  Distance: Double;
  ErrorMarginDistance: Double;
  M, B: Double;
begin
  Deviation := Deviation;
  Distance := Sqrt(Sqr(Point.X - Source.X) + Sqr(Point.Y - Source.Y));
  ErrorMarginDistance := Deviation * ErrorMargin / 100; // MulDiv(Deviation, ErrorMargin, 100);

  if Distance <= ErrorMarginDistance then
    Result := 100
  else if Distance > Deviation then
    Result := 0
  else
  begin
    M := (100 - ErrorMargin) / (ErrorMarginDistance - Deviation);
    B := ErrorMargin - (M * Deviation);
    Result := M * Distance + B;
  end;
end;

function CheckPointInGestureWindow(Point: TPointF;
  const SourcePoints: array of TPointF; var GestureIndex: Integer;
  var Verification: TDoubleDynArray; ADeviation, ErrorMargin: Integer): Boolean;
var
  Index: Integer;
  Percentage: Double;
begin
  Result := False;
  for Index := 0 to GestureIndex do
  begin
    Percentage := CheckPoint(Point, SourcePoints[Index], ADeviation,
      ErrorMargin);
    if Percentage > ErrorMargin then
    begin
      if Verification[Index] < Percentage then
        Verification[Index] := Percentage;
      Result := True;
    end;
  end;
end;

type
  TLine = record
    Point1, Point2: TPointF;
  end;

  TCircle = record
    Point: TPointF;
    Radius: Integer;
  end;

function Line(Point1, Point2: TPointF): TLine; inline;
begin
  Result.Point1 := Point1;
  Result.Point2 := Point2;
end;

function Circle(Point: TPointF; Radius: Integer): TCircle; inline;
begin
  Result.Point := Point;
  Result.Radius := Radius;
end;

function LineIntersectsCircle(Line: TLine; Circle: TCircle): Boolean;
var
  A, B, C: Single;
begin
  A := Sqr(Line.Point2.X - Line.Point1.X) + Sqr(Line.Point2.Y - Line.Point1.Y);

  B := 2 * ((Line.Point2.X - Line.Point1.X) * (Line.Point1.X - Circle.Point.X) +
    (Line.Point2.Y - Line.Point1.Y) * (Line.Point1.Y - Circle.Point.Y));

  C := Sqr(Circle.Point.X) + Sqr(Circle.Point.Y) + Sqr(Line.Point1.X) +
    Sqr(Line.Point1.Y) - 2 * (Circle.Point.X * Line.Point1.X + Circle.Point.Y *
    Line.Point1.Y) - Sqr(Circle.Radius);

  Result := (B * B - 4 * A * C) > 0;
end;

function CheckLineIntersectsCircle(Line: TLine; const SourcePoints: array of TPointF;
  GestureIndex, Radius: Integer; var Verification: TIntegerDynArray): Boolean;
var
  Index: Integer;
begin
  Result := False;

  for Index := 0 to GestureIndex do
  begin
    if LineIntersectsCircle(Line, Circle(SourcePoints[Index], Radius)) then
    begin
      Result := True;
      Inc(Verification[Index]);
    end;
  end;
end;

function ReversePoints(const Points: array of TPointF): TGesturePointArray;
var
  Index1, Index2, Count: Integer;
begin
  Count := Length(Points);
  SetLength(Result, Count);
  Index2 := Count - 1;

  for Index1 := 0 to Count - 1 do
  begin
    Result[Index2] := Points[Index1];
    Dec(Index2);
  end;
end;

type
  TGesturePoint = record
    Point: TPointF;
    Angle: Single;
    Index: Integer;
  end;

  TPointsList = TList<TGesturePoint>;

function Distance(Point1, Point2: TPointF): Single;
begin
  Result := Sqrt(Sqr(Point1.X - Point2.X) + Sqr(Point1.Y - Point2.Y));
end;

function TGestureRecognizer.CopyPoints(Points: TGesturePoints)
  : TGesturePointArray;
var
  Index: Integer;
begin
  SetLength(Result, Points.Count);
  for Index := 0 to Points.Count - 1 do
    Result[Index] := Points[Index];
end;

function TGestureRecognizer.InterpolatePoints(const Points: array of TPointF)
  : TGesturePointArray;
var
  Index, PointsCount: Integer;
  StepX, StepY: Double;
  I, DeltaX, DeltaY, Count: Integer;
  CurrentPoint, NextPoint: TPointF;
  ResultPoints: TGesturePoints;
begin
  PointsCount := Length(Points);
  if PointsCount = 0 then
    Exit;
  Count := 0; // avoid compiler warning
  StepX := 0; // avoid compiler warning
  StepY := 0; // avoid compiler warning
  ResultPoints := TGesturePoints.Create;

  try
    ResultPoints.Add(Points[0]);

    for Index := 0 to Length(Points) - 1 do
    begin
      if Index < Length(Points) - 1 then
      begin
        NextPoint := Points[Index + 1];
        CurrentPoint := Points[Index];

        // Determine distance between points
        DeltaX := Round(NextPoint.X - CurrentPoint.X);
        DeltaY := Round(NextPoint.Y - CurrentPoint.Y);

        if (DeltaX <> 0) and (DeltaY <> 0) then
        begin
          if Abs(DeltaX) > Abs(DeltaY) then
            Count := Abs(DeltaY)
          else
            Count := Abs(DeltaX);

          StepX := DeltaX / Count;
          StepY := DeltaY / Count;
        end
        else if (DeltaX = 0) and (DeltaY <> 0) then
        begin
          StepX := 0;
          StepY := DeltaY div Abs(DeltaY);
          Count := Abs(DeltaY);
        end
        else if (DeltaX <> 0) and (DeltaY = 0) then
        begin
          StepY := 0;
          StepX := DeltaX div Abs(DeltaX);
          Count := Abs(DeltaX);
        end;

        for I := 1 to Count - 1 do
        begin
          ResultPoints.Add(PointF(CurrentPoint.X + Trunc(StepX * I),
            CurrentPoint.Y + Trunc(StepY * I)));
        end;
      end;

      ResultPoints.Add(NextPoint);
    end;

    Result := CopyPoints(ResultPoints);
  finally
    ResultPoints.Free;
  end;
end;

function TGestureRecognizer.IsPointsGesture(const Points,
  GesturePoints: array of TPointF; GestureID: TGestureID;
  Deviation, ErrorMargin: Integer; var Percentages: array of Double): Integer;
  function DistanceBetween(Point1, Point2: TPointF): Single;
  begin
    Result := Sqrt(Sqr(Point1.X - Point2.X) + Sqr(Point1.Y - Point2.Y));
  end;

var
  Index: Integer;
  AnglesMatched: Integer;
  LowestPercentage: Double;
  DegreeError: Double;
  Match: TDoubleDynArray;
  GestureIndex: Integer;
  DistancePoints: array of TPointF;
  Distances: TSingleDynarray;
  Distance: Single;
  PointsCount: Integer;
  GestureCount: Integer;
  GestureAngles: array of Double;
  DistanceAngles: array of Double;
  LinesMatched: Integer;
  LinesMatch: TIntegerDynArray;
  PointsIndex: Integer;
  PointsMatch: TDoubleDynArray;
  Passes, Fails: Double;
  PassesCount, FailsCount: Integer;
  Point: TPointF;
  GesturePointsPercentage: Integer;
  PointsPercentage: Integer;
begin
  Result := 0;

  PointsCount := Length(Points);
  GestureCount := Length(GesturePoints);

  if (PointsCount = 0) or (GestureCount = 0) then
    Exit;

  SetLength(Match, GestureCount);
  SetLength(Distances, GestureCount);
  SetLength(DistancePoints, GestureCount);
  SetLength(GestureAngles, GestureCount);
  SetLength(DistanceAngles, GestureCount);
  SetLength(LinesMatch, GestureCount);
  SetLength(PointsMatch, PointsCount);
  PointsPercentage := 0;
  GestureIndex := 0;
  LinesMatched := 0;
  PointsIndex := 0;

  for Index := 0 to GestureCount - 1 do
  begin
    // Initialize distances between the points and the gestures as very far.
    Distances[Index] := MaxInt;

    while (PointsIndex + 1 < PointsCount) and
      PointInCircle(GesturePoints[Index], Points[PointsIndex + 1], Deviation) do
      Inc(PointsIndex);

    CheckPointInGestureWindow(GesturePoints[Index], Points, PointsIndex,
      PointsMatch, Deviation, ErrorMargin);
  end;

  for Index := 0 to PointsCount - 1 do
  begin
    Inc(PointsPercentage, Round(PointsMatch[Index]));

    while (GestureIndex + 1 < GestureCount) and PointInCircle(Points[Index],
      GesturePoints[GestureIndex + 1], Deviation) do
      Inc(GestureIndex);

    CheckPointInGestureWindow(Points[Index], GesturePoints, GestureIndex, Match,
      Deviation, ErrorMargin);

    if Index + 1 < PointsCount - 1 then
      CheckLineIntersectsCircle(Line(Points[Index], Points[Index + 1]),
        GesturePoints, GestureIndex, Deviation, LinesMatch);
  end;

  // Find the distances between the points.
  for Index := 0 to PointsCount - 1 do
  begin
    Point := Points[Index];

    for GestureIndex := 0 to GestureCount - 1 do
    begin
      // Calculate the closest point to the gesture points.
      Distance := DistanceBetween(Point, GesturePoints[GestureIndex]);

      if Distance < Distances[GestureIndex] then
      begin
        Distances[GestureIndex] := Distance;
        DistancePoints[GestureIndex] := Point;
      end;
    end;
  end;

  // Calculate the angle between the points and the gesture's points.
  Index := 0;
  GesturePointsPercentage := 0;
  while Index < GestureCount do
  begin
    Inc(GesturePointsPercentage, Round(Match[Index]));

    if LinesMatch[Index] > 0 then
      Inc(LinesMatched);

    if Index + 1 < GestureCount - 1 then
    begin
      GestureAngles[Index] :=
        ArcTan2(GesturePoints[Index].X - GesturePoints[Index + 1].X,
        GesturePoints[Index].Y - GesturePoints[Index + 1].Y);
      DistanceAngles[Index] :=
        ArcTan2(DistancePoints[Index].X - DistancePoints[Index + 1].X,
        DistancePoints[Index].Y - DistancePoints[Index + 1].Y);
    end
    else
    begin
      GestureAngles[Index] := ArcTan2(GesturePoints[Index - 1].X - GesturePoints
        [Index].X, GesturePoints[Index - 1].Y - GesturePoints[Index].Y);
      DistanceAngles[Index] :=
        ArcTan2(DistancePoints[Index - 1].X - DistancePoints[Index].X,
        DistancePoints[Index - 1].Y - DistancePoints[Index].Y);
    end;

    Inc(Index);
  end;

  AnglesMatched := 0;
  DegreeError := (ErrorMargin * Pi) / 100;

  for Index := 0 to GestureCount - 1 do
  begin
    if (DistanceAngles[Index] = 0) or
      ((GestureAngles[Index] - DegreeError) < DistanceAngles[Index]) and
      (DistanceAngles[Index] < (GestureAngles[Index] + DegreeError)) then
    begin
      Inc(AnglesMatched);
    end;
  end;

  Percentages[0] := PointsPercentage div PointsCount;
  Percentages[1] := GesturePointsPercentage div GestureCount;
  Percentages[2] := 100 * AnglesMatched / GestureCount; //MulDiv(100, AnglesMatched, GestureCount);
  Percentages[3] := 100 * LinesMatched / GestureCount; //MulDiv(100, LinesMatched, GestureCount);

  LowestPercentage := MaxInt;

  for Index := 0 to Length(Percentages) - 1 do
  begin
    if Percentages[Index] < LowestPercentage then
      LowestPercentage := Percentages[Index];
  end;

  if (100 - ErrorMargin) < LowestPercentage then
    Result := Trunc(LowestPercentage)
  else
  begin
    Passes := 0;
    PassesCount := 0;
    Fails := 0;
    FailsCount := 0;

    for Index := 0 to Length(Percentages) - 1 do
    begin
      if Percentages[Index] <= ((100 - ErrorMargin) div 4) then
        Exit;

      if (100 - ErrorMargin) < Percentages[Index] then
      begin
        Inc(PassesCount);
        Passes := Passes + Percentages[Index];
      end
      else
      begin
        Inc(FailsCount);
        Fails := Fails + Percentages[Index];
      end;
    end;

    if (Passes <> 0) and (Fails <> 0) then
    begin
      Passes := Passes / PassesCount;
      Fails := Fails / FailsCount;
      Result := Trunc((Passes + Fails) / 2);

      if (100 - ErrorMargin) >= Result then
        Result := 0;
    end;
  end;
end;

function TGestureRecognizer.Match(const Points, GesturePoints: array of TPointF;
  const Options: TGestureOptions; GestureID: TGestureID;
  Deviation, ErrorMargin: Integer): Single;
var
  LErrorMargin: Integer;
  LPoints, LGesturePoints: TGesturePointArray;
  { PointCount, } GesturePointCount: Integer;
  Percentages: array of Double;
  Angle: Double;
begin
  Result := 0;
  SetLength(Percentages, 4);

  // Apply global sensitivity adjustment to gesture's ErrorMargin property
  LErrorMargin := Round(Sqr(100 - TPlatformGestureEngine.Sensitivity) / 100) +
    ErrorMargin;
  if LErrorMargin > 100 then
    LErrorMargin := 100;
                                                    

  try
    GesturePointCount := Length(GesturePoints);

    if (Length(Points) = 0) or (GesturePointCount = 0) then
      Exit;

    // if Assigned(FPreCallback) then
    // FPreCallback(Points, GesturePoints, GestureID, Deviation, LErrorMargin);

    // if GestureID = sgiScratchout then
    // begin
    // Result := IsScratchout(Points, GestureID, Deviation, LErrorMargin, Percentages);
    // Exit;
    // end;

    LPoints := NormalizePoints(Points);
    if TGestureOption.goRotate in Options then
      LPoints := RotatePoints(LPoints, GesturePoints, LErrorMargin, Angle);
    LPoints := ScalePoints(LPoints, GesturePoints, Deviation,
      TGestureOption.goSkew in Options);
    LPoints := RemoveDuplicates(LPoints);
    { if (TGestureOption.goUniDirectional in Options) and
      not PointInCircle(LPoints[0], GesturePoints[0], Deviation) then
      Exit; }

    // PointCount := Length(LPoints);
    { if (TGestureOption.goEndpoint in Options) and
      (not PointInCircle(LPoints[PointCount - 1],
      GesturePoints[GesturePointCount - 1], Deviation)) then
      begin
      Exit;
      end; }

    LGesturePoints := InterpolatePoints(GesturePoints);
    LGesturePoints := RemoveDuplicates(LGesturePoints);
    // GesturePointCount := Length(GesturePoints);

    Result := IsPointsGesture(LPoints, LGesturePoints, GestureID, Deviation,
      LErrorMargin, Percentages);

    // If the gesture failed and the gesture is a bidirectional gesture,
    // and the start and end points of the gesture are the same, then reverse
    // the gesture and test again.
    if (Result < LErrorMargin) and not(TGestureOption.goUniDirectional
      in Options) and PointInCircle(LPoints[0],
      GesturePoints[GesturePointCount - 1], Deviation) then
    begin
      Result := IsPointsGesture(LPoints, ReversePoints(LGesturePoints),
        GestureID, Deviation, LErrorMargin, Percentages);
    end;
  finally
    // if Assigned(FPostCallback) then
    // FPostCallback(Percentages, LPoints, GesturePoints, GestureID);
  end;
end;

function TGestureRecognizer.NormalizePoints(const Points: array of TPointF)
  : TGesturePointArray;
var
  Index: Integer;
  SmallestX, SmallestY: Single;
begin;
  SetLength(Result, Length(Points));
  // Find the delta.
  SmallestX := MaxInt;
  SmallestY := MaxInt;

  for Index := 0 to Length(Points) - 1 do
  begin
    if SmallestX > Points[Index].X then
      SmallestX := Points[Index].X;

    if SmallestY > Points[Index].Y then
      SmallestY := Points[Index].Y;
  end;

  // Apply the delta.
  for Index := 0 to Length(Points) - 1 do
    Result[Index] := PointF(Points[Index].X - SmallestX,
      Points[Index].Y - SmallestY);
end;

procedure TGestureRecognizer.Reset;
begin
  inherited;
end;

function TGestureRecognizer.RemoveDuplicates(const Points: array of TPointF)
  : TGesturePointArray;
var
  Index, PointsCount: Integer;
  LastPoint, NextPoint: TPointF;
  ResultPoints: TGesturePoints;
begin
  PointsCount := Length(Points);
  if PointsCount = 0 then
    Exit;
  ResultPoints := TGesturePoints.Create;

  try
    ResultPoints.Add(Points[0]);

    for Index := 0 to Length(Points) - 1 do
    begin
      if Index < Length(Points) - 1 then
      begin
        NextPoint := Points[Index + 1];
        LastPoint := Points[Index];

        if (LastPoint.X <> NextPoint.X) or (LastPoint.Y <> NextPoint.Y) then
          ResultPoints.Add(NextPoint);
      end;
    end;

    Result := CopyPoints(ResultPoints);
  finally
    ResultPoints.Free;
  end;

end;

function TGestureRecognizer.RotatePoints(const Points, GesturePoints
  : array of TPointF; ErrorMargin: Integer; var Angle: Double): TGesturePointArray;

  function WithinError(const Point1, Point2: TPointF; ErrorMargin: Integer;
    var Angle: Double): Boolean;
  var
    Angle1, Angle2: Double;
    DegreeError: Double;
  begin
    Result := False;
    Angle1 := ArcTan2(Point1.X, Point1.Y);
    Angle2 := ArcTan2(Point2.X, Point2.Y);
    Angle := Angle1 - Angle2;
    DegreeError := (ErrorMargin * Pi) / 100;
    if Abs(Angle) < DegreeError then
      Result := True;
  end;

var
  Index, GestureCount, PointsCount: Integer;
  Origin, Point2: TPointF;
  Success: Boolean;
begin
  Success := False;
  GestureCount := Length(GesturePoints);
  PointsCount := Length(Points);
  SetLength(Result, PointsCount);

  if (GestureCount > 1) and (PointsCount > 1) then
  begin
    Origin := GesturePoints[0];
    Point2 := GesturePoints[GestureCount - 1];

    if (Origin.X = Points[0].X) and (Origin.Y = Points[0].Y) then
    begin
      if WithinError(Point2, Points[PointsCount - 1], ErrorMargin, Angle) then
      begin
        Success := True;
        for Index := 0 to Length(Points) - 1 do
        begin
          Result[Index].X := Points[Index].X * Cos(Angle) + Points[Index].Y *
            Sin(Angle);
          Result[Index].Y := Points[Index].Y * Cos(Angle) - Points[Index].X *
            Sin(Angle);
        end;
      end;
    end;
  end;

  if not Success and (PointsCount > 0) then
  begin
    SetLength(Result, PointsCount);
    Move(Points[0], Result[0], PointsCount * Sizeof(TPointF));
  end;
end;

function TGestureRecognizer.ScalePoints(const Points, GesturePoints
  : array of TPointF; MinScale: Integer; Scaling: Boolean): TGesturePointArray;
var
  Index: Integer;
  LargestX1, LargestX2, LargestY1, LargestY2: Extended;
  ScaleX, ScaleY, Scale: Double;
  P: TPointF;
begin
  // Find the delta.
  LargestX1 := 0;
  LargestY1 := 0;
  LargestX2 := 0;
  LargestY2 := 0;

  for Index := 0 to Length(Points) - 1 do
  begin
    if LargestX1 < Abs(Points[Index].X) then
      LargestX1 := Abs(Points[Index].X);

    if LargestY1 < Abs(Points[Index].Y) then
      LargestY1 := Abs(Points[Index].Y);
  end;

  for Index := 0 to Length(GesturePoints) - 1 do
  begin
    if LargestX2 < Abs(GesturePoints[Index].X) then
      LargestX2 := Abs(GesturePoints[Index].X);

    if LargestY2 < Abs(GesturePoints[Index].Y) then
      LargestY2 := Abs(GesturePoints[Index].Y);
  end;

  if (LargestX1 = 0) or (LargestX2 = 0) then
    ScaleX := 1
  else
    ScaleX := LargestX2 / LargestX1;

  if (LargestY1 = 0) or (LargestY2 = 0) then
    ScaleY := 1
  else
    ScaleY := LargestY2 / LargestY1;

  // Apply the scale.
  SetLength(Result, Length(Points));

  if Scaling or (ScaleX = 1) or (ScaleY = 1) then
  begin
    for Index := 0 to Length(Result) - 1 do
    begin
      P := Points[Index];
      Result[Index] := PointF(Round(P.X * ScaleX), Round(P.Y * ScaleY));
    end;
  end
  else if (ScaleX <> 1) and (ScaleY <> 1) then
  begin
    if ScaleX < ScaleY then
      Scale := ScaleX
    else
      Scale := ScaleY;

    for Index := 0 to Length(Result) - 1 do
    begin
      P := Points[Index];

      Result[Index] := PointF(Round(P.X * Scale), Round(P.Y * Scale));
    end;
  end;
end;

end.
