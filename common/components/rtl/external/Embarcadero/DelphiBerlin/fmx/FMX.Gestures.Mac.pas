{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Gestures.Mac;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FMX.Types, FMX.Gestures;

type
  TPlatformGestureEngine = class(TGestureEngine)
  strict private
    class var FDefaultEngineClass: TGestureEngineClass;
    class destructor Destroy;
    class constructor Create;
  strict private
    FControl: TComponent;
    FGestureList: TGestureList;
    function GetGestureList: TGestureList;
  protected
    class function GetGestureEngine(const AControl: TComponent): TGestureEngine; override;
    procedure SetInitialPoint(const Value: TPointF); override;
  public
    procedure AddPoints(Count: Integer);
    class procedure CreateEngine(const AControl: TComponent);
    ///<summary>Default engine class in order to be able to create engines for components.</summary>
    class property DefaultEngineClass: TGestureEngineClass read FDefaultEngineClass write FDefaultEngineClass;
  public
    ///<summary>Construtor.</summary>
    constructor Create(const AControl: TComponent); override;
    property GestureList: TGestureList read GetGestureList;
    ///<summary>Component that this engine uses to recognize gestures.</summary>
    property Control: TComponent read FControl;
  end;

  TMacGestureEngine = class sealed(TPlatformGestureEngine)
  protected
    function GetActive: Boolean; override;
    procedure SetActive(const Value: Boolean); override;
    function GetFlags: TCustomGestureEngine.TGestureEngineFlags; override;
  public
    constructor Create(const AControl: TComponent); override;
  end;

  TGestureRecognizer = class(TCustomGestureRecognizer)
  public
    ///<summary>Returns the probability that the incomming points belong to one gesture.</summary>
    function Match(const Points, GesturePoints: array of TPointF; const Options: TGestureOptions; GestureID: TGestureID;
      Deviation, ErrorMargin: Integer): Single; override;
    procedure Reset; override;
  end;

implementation

uses
  System.Math, System.SysUtils, System.UITypes, System.Generics.Collections, FMX.Consts, FMX.Utils;

{ TPlatformGestureEngine }

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

constructor TPlatformGestureEngine.Create(const AControl: TComponent);
begin
  inherited;
  FControl := AControl;
end;

class constructor TPlatformGestureEngine.Create;
begin
  FRecognizer := nil;
  FDefaultRecognizerClass := TGestureRecognizer;
end;

class procedure TPlatformGestureEngine.CreateEngine(const AControl: TComponent);
var
  LGObj: IGestureControl;
 begin
   DefaultRecognizerClass := TGestureRecognizer;

   if not(csDesigning in AControl.ComponentState) then
    if Supports(AControl, IGestureControl, LGObj) then
      if LGObj.TouchManager.GestureEngine = nil then
        LGObj.TouchManager.GestureEngine := TMacGestureEngine.GetGestureEngine(AControl);
end;

class destructor TPlatformGestureEngine.Destroy;
begin
  FreeAndNil(FRecognizer);
end;

class function TPlatformGestureEngine.GetGestureEngine(const AControl: TComponent): TGestureEngine;
begin
  Result := TMacGestureEngine.Create(AControl);
end;

function TPlatformGestureEngine.GetGestureList: TGestureList;
begin
  Result := FGestureList;
end;

procedure TPlatformGestureEngine.SetInitialPoint(const Value: TPointF);
begin
  inherited;

  if FGestureList = nil then
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

constructor TMacGestureEngine.Create(const AControl: TComponent);
begin
  inherited;
end;

{ TGestureRecognizer }

function TGestureRecognizer.Match(const Points, GesturePoints: array of TPointF; const Options: TGestureOptions;
  GestureID: TGestureID; Deviation, ErrorMargin: Integer): Single;
var
  LErrorMargin: Integer;
  LPoints, LGesturePoints: TGesturePointArray;
  GesturePointCount: Integer;
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

    LPoints := NormalizePoints(Points);
    if TGestureOption.Rotate in Options then
      LPoints := RotatePoints(LPoints, GesturePoints, LErrorMargin, Angle);
    LPoints := ScalePoints(LPoints, GesturePoints, Deviation,
      TGestureOption.Skew in Options);
    LPoints := RemoveDuplicates(LPoints);

    LGesturePoints := InterpolateGesturePoints(GesturePoints);
    LGesturePoints := RemoveDuplicates(LGesturePoints);
    // GesturePointCount := Length(GesturePoints);

    Result := IsPointsGesture(LPoints, LGesturePoints, GestureID, Deviation,
      LErrorMargin, Percentages);

    // If the gesture failed and the gesture is a bidirectional gesture,
    // and the start and end points of the gesture are the same, then reverse
    // the gesture and test again.
    if (Result < LErrorMargin) and not(TGestureOption.UniDirectional
      in Options) and IsPointInCircle(LPoints[0],
      GesturePoints[GesturePointCount - 1], Deviation) then
    begin
      Result := IsPointsGesture(LPoints, ReverseGesturePoints(LGesturePoints),
        GestureID, Deviation, LErrorMargin, Percentages);
    end;
  finally
  end;
end;

procedure TGestureRecognizer.Reset;
begin
  inherited;
end;

end.
