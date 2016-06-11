{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Gestures.iOS;

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
    class procedure CreateEngine(const AControl: TComponent);
    class property DefaultEngineClass: TGestureEngineClass read FDefaultEngineClass write FDefaultEngineClass;
    property GestureList: TGestureList read GetGestureList;
    constructor Create(const AControl: TComponent); override;
  end;

  TIOSGestureEngine = class sealed(TPlatformGestureEngine)
  protected
    function GetActive: Boolean; override;
    procedure SetActive(const Value: Boolean); override;
    function GetFlags: TCustomGestureEngine.TGestureEngineFlags; override;
  public
    constructor Create(const AControl: TComponent); override;
  end;

  TGestureRecognizer = class(TCustomGestureRecognizer)
  public
    function Match(const Points, GesturePoints: array of TPointF; const Options: TGestureOptions; GestureID: TGestureID;
      Deviation, ErrorMargin: Integer): Single; override;
    procedure Reset; override;
  end;

implementation

uses
  System.Math, System.SysUtils, System.Generics.Collections, System.UITypes, FMX.Consts, FMX.Forms, FMX.Utils;

{ TPlatformGestureEngine }

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
   if not(csDesigning in AControl.ComponentState) and Supports(AControl, IGestureControl, LGObj) and
     (LGObj.TouchManager.GestureEngine = nil) then
     LGObj.TouchManager.GestureEngine := TIOSGestureEngine.GetGestureEngine(AControl);
end;

class destructor TPlatformGestureEngine.Destroy;
begin
  FreeAndNil(FRecognizer);
end;

class function TPlatformGestureEngine.GetGestureEngine(const AControl: TComponent): TGestureEngine;
begin
  Result := TIOSGestureEngine.Create(AControl);
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

{ TIOSGestureEngine }

constructor TIOSGestureEngine.Create(const AControl: TComponent);
begin
  inherited;
end;

function TIOSGestureEngine.GetActive: Boolean;
begin
  Result := False;
end;

function TIOSGestureEngine.GetFlags: TCustomGestureEngine.TGestureEngineFlags;
begin
  Result := [];
end;

procedure TIOSGestureEngine.SetActive(const Value: Boolean);
begin
  inherited;
end;

{ TGestureRecognizer }

function TGestureRecognizer.Match(const Points, GesturePoints: array of TPointF; const Options: TGestureOptions;
  GestureID: TGestureID; Deviation, ErrorMargin: Integer): Single;
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
  LErrorMargin := Round(Sqr(100 - TPlatformGestureEngine.Sensitivity) / 100) + ErrorMargin;
  if LErrorMargin > 100 then
    LErrorMargin := 100;
                                                    

  try
    GesturePointCount := Length(GesturePoints);

    if (Length(Points) = 0) or (GesturePointCount = 0) then
      Exit;

    if GestureID = sgiScratchout then
    begin
      Result := IsScratchout(Points, GestureID, Deviation, LErrorMargin, Percentages);
      Exit;
    end;

    LPoints := NormalizePoints(Points);
    if TGestureOption.Rotate in Options then
      LPoints := RotatePoints(LPoints, GesturePoints, LErrorMargin, Angle);
    LPoints := ScalePoints(LPoints, GesturePoints, Deviation, TGestureOption.Skew in Options);
    LPoints := RemoveDuplicates(LPoints);

    LGesturePoints := InterpolateGesturePoints(GesturePoints);
    LGesturePoints := RemoveDuplicates(LGesturePoints);
    // GesturePointCount := Length(GesturePoints);

    Result := IsPointsGesture(LPoints, LGesturePoints, GestureID, Deviation, LErrorMargin, Percentages);

    // If the gesture failed and the gesture is a bidirectional gesture,
    // and the start and end points of the gesture are the same, then reverse
    // the gesture and test again.
    if (Result < LErrorMargin) and not(TGestureOption.UniDirectional in Options) and
      IsPointInCircle(LPoints[0], GesturePoints[GesturePointCount - 1], Deviation) then
    begin
      Result := IsPointsGesture(LPoints, ReverseGesturePoints(LGesturePoints), GestureID, Deviation, LErrorMargin, Percentages);
    end;
  finally
  end;
end;

procedure TGestureRecognizer.Reset;
begin
  inherited;
end;

end.
