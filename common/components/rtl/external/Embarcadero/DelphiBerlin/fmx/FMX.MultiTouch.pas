{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.MultiTouch;

interface

uses
  System.Types, System.Classes, FMX.Types;

type

  TMultiTouchManager = class abstract
  private
    [Weak] FParent: TComponent;
    [Weak] FGestureControl: TComponent;
    [Weak] FTouchDownControl: TComponent;
    FTouches: TTouches;
  protected
    FFirstPointerDownCoordinates: TPointF;
    FFirstPointer: TPointF;
    FSecondPointer: TPointF;
    FOldPoint1: TPointF;
    FOldPoint2: TPointF;
    FActiveInteractiveGestures: TInteractiveGestures;
    FEnabledInteractiveGestures: TInteractiveGestures;
    FRotationAngle: Single;
    procedure TouchDown; virtual; abstract;
    procedure TouchUp; virtual; abstract;
    procedure TouchMove; virtual; abstract;
    procedure TouchCancel; virtual; abstract;
    function GetLongTapAllowedMovement: Single;
    property Touches: TTouches read FTouches write FTouches;
    property GestureControl: TComponent read FGestureControl write FGestureControl;
    property TouchDownControl: TComponent read FTouchDownControl write FTouchDownControl;
    function IsZoom(const APoint1, APoint2: TPointF): Boolean;
    function IsRotate(const APoint1, APoint2: TPointF): Boolean;
    function SendCMGestureMessage(AEventInfo: TGestureEventInfo): Boolean; virtual;
    function CreateGestureEventInfo(const AGesture: TInteractiveGesture;
      const AGestureEnded: Boolean = False): TGestureEventInfo; virtual;
    function FindAndHandleInteractiveGesture(const EffectiveGestureSet: TInteractiveGestures; const APoint: TPointF;
      const AGestureStarted: Boolean = False): Boolean;
    function EndInteractiveGesture(AGesture: TInteractiveGesture): Boolean;
  public
    constructor Create(const AParent: TComponent); virtual;
    procedure HandleTouches(const ATouches: TTouches; const Action: TTouchAction; const Control: IControl); virtual;
    property Parent: TComponent read FParent write FParent;
  end;

implementation

uses
  System.UITypes, System.SysUtils, System.Math, FMX.Platform;

const
  LongTapMovement = 10; // 10 pixels - use scale to transform to points to use on each device

{ TMultiTouchManager }

constructor TMultiTouchManager.Create(const AParent: TComponent);
begin
  FParent := AParent;
  FActiveInteractiveGestures := [];
  FEnabledInteractiveGestures := [];
  FRotationAngle := 0;
  FOldPoint1 := TPointF.Create(-1, -1);
  FOldPoint2 := TPointF.Create(-1, -1);
  FSecondPointer := TPointF.Create(-1, -1);
end;

function TMultiTouchManager.CreateGestureEventInfo(const AGesture: TInteractiveGesture;
  const AGestureEnded: Boolean): TGestureEventInfo;
begin
  FillChar(Result, Sizeof(Result), 0);
  Result.Location := FFirstPointer;
  Result.GestureID := igiZoom + Ord(AGesture);

  if not (AGesture in FActiveInteractiveGestures) then
    Result.Flags := [TInteractiveGestureFlag.gfBegin];
  if AGestureEnded then
    Result.Flags := [TInteractiveGestureFlag.gfEnd];

  case AGesture of
    TInteractiveGesture.Zoom:
      begin
        if AGestureEnded and FSecondPointer.EqualsTo(TPointF.Create(-1, -1)) then
          FSecondPointer := FOldPoint2;
        Result.Location := FFirstPointer.MidPoint(FSecondPointer);
        Result.Distance := Round(FFirstPointer.Distance(FSecondPointer));
      end;
    TInteractiveGesture.Pan:
      if not FSecondPointer.EqualsTo(TPointF.Create(-1, -1)) then
        Result.Distance := Round(FFirstPointer.Distance(FSecondPointer));
    TInteractiveGesture.Rotate:
      begin
        if AGestureEnded and FSecondPointer.EqualsTo(TPointF.Create(-1, -1)) then
          FSecondPointer := FOldPoint2;
        Result.Location := FFirstPointer.MidPoint(FSecondPointer);
        Result.Angle := FRotationAngle;
      end;
    TInteractiveGesture.PressAndTap:
      Result.Distance := Round(FFirstPointer.Distance(FSecondPointer));
    TInteractiveGesture.LongTap:
      Result.Location := FFirstPointerDownCoordinates;
  end;
end;

function TMultiTouchManager.EndInteractiveGesture(AGesture: TInteractiveGesture): Boolean;
begin
  Result := False;
  if AGesture in FActiveInteractiveGestures then
  begin
    Result := True;
    SendCMGestureMessage(CreateGestureEventInfo(AGesture, True));
    Exclude(FActiveInteractiveGestures, AGesture);
  end;
end;

function TMultiTouchManager.FindAndHandleInteractiveGesture(const EffectiveGestureSet: TInteractiveGestures;
  const APoint: TPointF; const AGestureStarted: Boolean): Boolean;
begin
  Result := False;
  if EffectiveGestureSet <> [] then
  begin
    if (TInteractiveGesture.Zoom in EffectiveGestureSet) and not(FFirstPointer = APoint) and
      IsZoom(FFirstPointer, APoint) then
      Exit(True);

    if (TInteractiveGesture.Rotate in EffectiveGestureSet) and not(FFirstPointer = APoint) and
      IsRotate(FFirstPointer, APoint) then
      Exit(True);

    if TInteractiveGesture.Pan in EffectiveGestureSet then
    begin
      // Testing for already started pan gesture: see that some movement was made.
      if AGestureStarted then
        if (FFirstPointer <> FOldPoint1) and (APoint <> FOldPoint2) and
          SendCMGestureMessage(CreateGestureEventInfo(TInteractiveGesture.Pan)) then
          Exit(True)
          // Testing for a not yet started pan gesture: see that enough movement was made since the first touch.
        else if (FFirstPointer.Distance(FFirstPointerDownCoordinates) > GetLongTapAllowedMovement) and
          (APoint.Distance(FFirstPointerDownCoordinates) > GetLongTapAllowedMovement) and
          SendCMGestureMessage(CreateGestureEventInfo(TInteractiveGesture.Pan)) then
        begin
          Include(FActiveInteractiveGestures, TInteractiveGesture.Pan);
          Exit(True);
        end;
    end;
  end;
end;

function TMultiTouchManager.GetLongTapAllowedMovement: Single;
var
  FScreenService: IFMXScreenService;
begin
  if not TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, FScreenService) then
    raise EUnsupportedPlatformService.Create('IFMXScreenService');
  Result := LongTapMovement / FScreenService.GetScreenScale;
end;

procedure TMultiTouchManager.HandleTouches(const ATouches: TTouches; const Action: TTouchAction;
  const Control: IControl);
var
  Obj: IMultiTouch;
begin
  Touches := ATouches;
  if Action = TTouchAction.Down then
    if Control <> nil then
      TouchDownControl := Control.GetObject
    else
      TouchDownControl := Parent;

  if Supports(Parent, IMultiTouch, Obj) then
    Obj.MultiTouch(Touches, Action);

  case Action of
    TTouchAction.Down:
      TouchDown;
    TTouchAction.Up:
      TouchUp;
    TTouchAction.Move:
      TouchMove;
    TTouchAction.Cancel:
      TouchCancel;
  end;
end;

function TMultiTouchManager.IsRotate(const APoint1, APoint2: TPointF): Boolean;
var
  Angle1, Angle2: Single;
begin
  Result := False;
  // check that there was a previous 2 finger movement
  if not FOldPoint1.EqualsTo(TPointF.Create(-1, -1)) and not FOldPoint2.EqualsTo(TPointF.Create(-1, -1)) then
  begin
    // make sure that either the x or the y values change in opposite directions
    if ((FOldPoint1.X - APoint1.X) * (FOldPoint2.X - APoint2.X) <= 0) or
      ((FOldPoint1.Y - APoint1.Y) * (FOldPoint2.Y - APoint2.Y) <= 0) then
    begin
      Angle1 := APoint1.Angle(APoint2);
      Angle2 := FOldPoint1.Angle(FOldPoint2);

                                                                                                                  

      if Min(2 * Pi - Abs(Angle1 - Angle2), Abs(Angle1 - Angle2)) >= 0.01 then
      begin
        Result := True;
        // make rotation value counterclockwise and cumulative
        FRotationAngle := FRotationAngle - Angle1 + Angle2;
        // Keep rotation angle between -2Pi and 2Pi
        if FRotationAngle > 2 * Pi then
          FRotationAngle := FRotationAngle - 2 * Pi
        else if FRotationAngle < -2 * Pi then
          FRotationAngle := FRotationAngle + 2 * Pi
      end;
    end;
  end;

  if Result then
    if SendCMGestureMessage(CreateGestureEventInfo(TInteractiveGesture.Rotate)) then
      FActiveInteractiveGestures := FActiveInteractiveGestures + [TInteractiveGesture.Rotate]
    else
      Result := False;
end;

function TMultiTouchManager.IsZoom(const APoint1, APoint2: TPointF): Boolean;
var
  Distance1, Distance2: Single;
begin
  Result := False;
  // check that there was a previous 2 finger movement
  if not FOldPoint1.EqualsTo(TPointF.Create(-1, -1)) and not FOldPoint2.EqualsTo(TPointF.Create(-1, -1)) then
  begin
    Distance1 := APoint1.Distance(APoint2);
    Distance2 := FOldPoint1.Distance(FOldPoint2);

    // Take into account an error margin (there is always a distance between two fingers pressed together).
    if (Abs(Distance1) > 2) and (Abs(Distance1 - Distance2) > 2) then
      Result := True;
  end;

  if Result then
    if SendCMGestureMessage(CreateGestureEventInfo(TInteractiveGesture.Zoom)) then
      FActiveInteractiveGestures := FActiveInteractiveGestures + [TInteractiveGesture.Zoom]
    else
      Result := False;
end;

function TMultiTouchManager.SendCMGestureMessage(AEventInfo: TGestureEventInfo): Boolean;
var
  GObj: IGestureControl;
  OldGestureControl: TComponent;
const
  LGestureMap: array [igiZoom .. igiDoubleTap] of TInteractiveGesture = (TInteractiveGesture.Zoom,
    TInteractiveGesture.Pan, TInteractiveGesture.Rotate, TInteractiveGesture.TwoFingerTap,
    TInteractiveGesture.PressAndtap, TInteractiveGesture.LongTap, TInteractiveGesture.DoubleTap);
begin
  Result := False;
  OldGestureControl := GestureControl;
  if (TInteractiveGestureFlag.gfBegin in AEventInfo.Flags) and Supports(TouchDownControl, IGestureControl, GObj) then
    GestureControl := GObj.GetFirstControlWithGesture(LGestureMap[AEventInfo.GestureID]);

  if Supports(GestureControl, IGestureControl, GObj) then
  begin
    GObj.CMGesture(AEventInfo);
    Result := True;
  end
  else
    GestureControl := OldGestureControl;

  if TInteractiveGestureFlag.gfEnd in AEventInfo.Flags then
    GestureControl := nil;
end;

end.
