{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.MultiTouch.Win;

interface

uses
  System.Types, System.Classes, FMX.MultiTouch, FMX.Types;

type
  TMultiTouchManagerWin = class(TMultiTouchManager)
  private
    FDblTapFirstTouchUp: Boolean;
    FPressAndTapPossible: Boolean;
    FPressAndTapSecondTouchDown: Boolean;
    FDoubleTapTimer: TFmxHandle;
    FLongTapTimer: TFmxHandle;
    FTimerService: IFMXTimerService;
    procedure StandardGesturesDown(const APoint: TPointF);
    procedure StandardGesturesUp(const APoint: TPointF);
    procedure StandardGesturesMove(const APoint: TPointF);
    procedure StandardGesturesCancel;
    procedure CreateDoubleTapTimer;
    procedure DestroyDoubleTapTimer;
    procedure DoubleTapTimerCall;
    procedure CreateLongTapTimer;
    procedure DestroyLongTapTimer;
    procedure LongTapTimerCall;
  protected
    procedure TouchDown; override;
    procedure TouchUp; override;
    procedure TouchMove; override;
    procedure TouchCancel; override;
  public
    constructor Create(const AParent: TComponent); override;
    destructor Destroy; override;
    procedure HandleTouches(const ATouches: TTouches; const Action: TTouchAction; const Control: IControl); override;
    procedure SetEnabledGestures(const AEnabledInteractiveGestures: TInteractiveGestures);
    procedure HandleMouseGestures(const APoint: TPointF; const Action: TTouchAction; const Control: IControl);
  end;

implementation

uses
  System.SysUtils, System.UITypes, System.Math, FMX.Gestures, FMX.Gestures.Win, FMX.Platform, Winapi.Windows;

const
  DblTapDelay = 300; // delay between the 2 taps
  LongTapDuration = 500;

  { TMultiTouchManagerWin }

constructor TMultiTouchManagerWin.Create(const AParent: TComponent);
begin
  inherited;
  if not TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, FTimerService) then
    raise EUnsupportedPlatformService.Create('IFMXTimerService');
end;

procedure TMultiTouchManagerWin.CreateDoubleTapTimer;
begin
  if FDoubleTapTimer = 0 then
    FDoubleTapTimer := FTimerService.CreateTimer(DblTapDelay, DoubleTapTimerCall);
end;

procedure TMultiTouchManagerWin.CreateLongTapTimer;
begin
  if FLongTapTimer = 0 then
    FLongTapTimer := FTimerService.CreateTimer(LongTapDuration, LongTapTimerCall);
end;

destructor TMultiTouchManagerWin.Destroy;
begin
  Parent := nil;
  DestroyDoubleTapTimer;
  DestroyLongTapTimer;
  FTimerService := nil;
  inherited;
end;

procedure TMultiTouchManagerWin.DestroyDoubleTapTimer;
begin
  if FDoubleTapTimer <> 0 then
  begin
    FTimerService.DestroyTimer(FDoubleTapTimer);
    FDoubleTapTimer := 0;
    FDblTapFirstTouchUp := False;
  end;
end;

procedure TMultiTouchManagerWin.DestroyLongTapTimer;
begin
  if FLongTapTimer <> 0 then
  begin
    FTimerService.DestroyTimer(FLongTapTimer);
    FLongTapTimer := 0;
  end;
end;

procedure TMultiTouchManagerWin.DoubleTapTimerCall;
begin
  // no double tap was made
  DestroyDoubleTapTimer;
end;

procedure TMultiTouchManagerWin.HandleMouseGestures(const APoint: TPointF; const Action: TTouchAction; const Control: IControl);
begin
  if Action = TTouchAction.Down then
    if Control <> nil then
      TouchDownControl := Control.GetObject
    else
      TouchDownControl := Parent;

  case Action of
    TTouchAction.Down:
      StandardGesturesDown(APoint);
    TTouchAction.Up:
      StandardGesturesUp(APoint);
    TTouchAction.Move:
      StandardGesturesMove(APoint);
    TTouchAction.Cancel:
      StandardGesturesCancel;
  end;
end;

procedure TMultiTouchManagerWin.HandleTouches(const ATouches: TTouches; const Action: TTouchAction;
  const Control: IControl);
begin
  FFirstPointer := ATouches[0].Location;

  if Length(ATouches) > 1 then
    FSecondPointer := ATouches[1].Location;

  inherited;

  FOldPoint1 := FFirstPointer;
  FOldPoint2 := FSecondPointer;
end;

procedure TMultiTouchManagerWin.LongTapTimerCall;
begin
  // a long press was recognized
  DestroyLongTapTimer;
  SendCMGestureMessage(CreateGestureEventInfo(TInteractiveGesture.LongTap));
end;

procedure TMultiTouchManagerWin.SetEnabledGestures(const AEnabledInteractiveGestures: TInteractiveGestures);
begin
  FEnabledInteractiveGestures := AEnabledInteractiveGestures;
end;

procedure TMultiTouchManagerWin.StandardGesturesCancel;
var
  GestureObj: IGestureControl;
begin
  if Supports(GestureControl, IGestureControl, GestureObj) and (GestureObj.TouchManager.GestureEngine <> nil) then
    TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine).ClearPoints;
end;

procedure TMultiTouchManagerWin.StandardGesturesDown(const APoint: TPointF);
var
  GestureObj: IGestureControl;
  Obj: IControl;
  InitialPoint: TPointF;
begin
  if Supports(TouchDownControl, IGestureControl, GestureObj) then
    begin
      GestureControl := GestureObj.GetFirstControlWithGestureEngine;
      if Supports(GestureControl, IGestureControl, GestureObj) then
      begin
        if Supports(GestureControl, IControl, Obj) then
          InitialPoint := Obj.LocalToScreen(APoint)
        else
          InitialPoint := APoint;

        TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine).InitialPoint := InitialPoint;
        TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine).ClearPoints;
        TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine).AddPoint(APoint.X, APoint.Y);
      end;
    end;
end;

procedure TMultiTouchManagerWin.StandardGesturesMove(const APoint: TPointF);
var
  GestureObj: IGestureControl;
begin
  if Supports(GestureControl, IGestureControl, GestureObj) and (GestureObj.TouchManager.GestureEngine <> nil) then
    TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine).AddPoint(APoint.X, APoint.Y);
end;

procedure TMultiTouchManagerWin.StandardGesturesUp(const APoint: TPointF);
var
  GestureObj: IGestureControl;
  EventInfo: TGestureEventInfo;
const
  LGestureTypes: TGestureTypes = [TGestureType.Standard, TGestureType.Recorded, TGestureType.Registered];
begin
  if Supports(GestureControl, IGestureControl, GestureObj) and (GestureObj.TouchManager.GestureEngine <> nil) then
  begin
    if (TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine).PointCount > 1) then
    begin
      FillChar(EventInfo, Sizeof(EventInfo), 0);
      if TPlatformGestureEngine.IsGesture(TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine).Points,
        TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine).GestureList, LGestureTypes, EventInfo) then
        TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine).BroadcastGesture(GestureControl, EventInfo);
    end;

    TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine).ClearPoints;
    GestureControl := nil;
  end;
end;

procedure TMultiTouchManagerWin.TouchCancel;
begin
  DestroyLongTapTimer;
  DestroyDoubleTapTimer;
  if Length(Touches) = 1 then
    StandardGesturesCancel;
  FActiveInteractiveGestures := [];
  FRotationAngle := 0;
  FFirstPointerDownCoordinates := TPointF.Create(-1, -1);
end;

procedure TMultiTouchManagerWin.TouchDown;
begin
  if Length(Touches) = 1 then
  begin
    if (FDoubleTapTimer = 0) and (TInteractiveGesture.DoubleTap in FEnabledInteractiveGestures) then
      CreateDoubleTapTimer;
    if (TInteractiveGesture.LongTap in FEnabledInteractiveGestures) then
      CreateLongTapTimer;

    FFirstPointerDownCoordinates := Touches[0].Location;
    if TInteractiveGesture.PressAndTap in FEnabledInteractiveGestures then
      FPressAndTapPossible := True;
    StandardGesturesDown(Touches[0].Location);
  end
  else if Length(Touches) = 2 then
    FPressAndTapSecondTouchDown := True
  else if Length(Touches) > 2 then
  begin
    FPressAndTapPossible := False;
    FPressAndTapSecondTouchDown := False;

    // end zoom and rotate gestures if they are active
    EndInteractiveGesture(TInteractiveGesture.Zoom);
    if EndInteractiveGesture(TInteractiveGesture.Rotate) then
      FRotationAngle := 0;
  end;
end;

procedure TMultiTouchManagerWin.TouchMove;
begin
  if Length(Touches) = 1 then
  begin
    if FFirstPointer.Distance(FOldPoint1) > GetLongTapAllowedMovement then
    begin
      DestroyLongTapTimer;
      DestroyDoubleTapTimer;
      FPressAndTapPossible := False;
    end;

    StandardGesturesMove(Touches[0].Location);

    if (Touches[0].Location.Distance(FFirstPointerDownCoordinates) > GetLongTapAllowedMovement) and
      (TInteractiveGesture.Pan in (FEnabledInteractiveGestures - FActiveInteractiveGestures)) and
      SendCMGestureMessage(CreateGestureEventInfo(TInteractiveGesture.Pan)) then
      Include(FActiveInteractiveGestures, TInteractiveGesture.Pan);

    // Since the pointer moved a bit, we could have a pan.
    if (Touches[0].Location.Distance(FOldPoint1) > 0) and (TInteractiveGesture.Pan in FActiveInteractiveGestures) then
      SendCMGestureMessage(CreateGestureEventInfo(TInteractiveGesture.Pan));

    // end zoom and rotate gestures if they are active
    EndInteractiveGesture(TInteractiveGesture.Zoom);
    if EndInteractiveGesture(TInteractiveGesture.Rotate) then
      FRotationAngle := 0;

    FOldPoint2 := TPointF.Create(-1, -1);
  end;

  if Length(Touches) = 2 then
  begin
    if not FindAndHandleInteractiveGesture(FActiveInteractiveGestures, FSecondPointer, True) then
      FindAndHandleInteractiveGesture(FEnabledInteractiveGestures - FActiveInteractiveGestures, FSecondPointer);
    if (TInteractiveGesture.PressAndTap in FEnabledInteractiveGestures) and
      ((FSecondPointer.Distance(FOldPoint2) > GetLongTapAllowedMovement) or
      (FFirstPointer.Distance(FOldPoint1) > GetLongTapAllowedMovement)) then
      FPressAndTapPossible := False;
  end;

  if Length(Touches) > 1 then
  begin
    DestroyLongTapTimer;
    DestroyDoubleTapTimer;
  end;
end;

procedure TMultiTouchManagerWin.TouchUp;
var
  GestureObj: IGestureControl;
const
  LGestureTypes: TGestureTypes = [TGestureType.Standard, TGestureType.Recorded, TGestureType.Registered];
begin
  DestroyLongTapTimer;
  // pan gesture ends, if it is active
  EndInteractiveGesture(TInteractiveGesture.Pan);

  if FDoubleTapTimer <> 0 then
    if not FDblTapFirstTouchUp then
      FDblTapFirstTouchUp := True
    else
    begin
      DestroyDoubleTapTimer;
      FDblTapFirstTouchUp := False;
      SendCMGestureMessage(CreateGestureEventInfo(TInteractiveGesture.DoubleTap));
    end;

  if Length(Touches) = 1 then
  begin
    StandardGesturesUp(Touches[0].Location);
    if FPressAndTapPossible and FPressAndTapSecondTouchDown and
      (TInteractiveGesture.PressAndTap in FEnabledInteractiveGestures) then
      SendCMGestureMessage(CreateGestureEventInfo(TInteractiveGesture.PressAndTap));
    FPressAndTapPossible := False;
    FPressAndTapSecondTouchDown := False;

    // end zoom and rotate gestures if they are active
    EndInteractiveGesture(TInteractiveGesture.Zoom);
    if EndInteractiveGesture(TInteractiveGesture.Rotate) then
      FRotationAngle := 0;
  end;

  if (Length(Touches) = 2) and FPressAndTapPossible and FPressAndTapSecondTouchDown and
    (TInteractiveGesture.PressAndTap in FEnabledInteractiveGestures) then
  begin
    SendCMGestureMessage(CreateGestureEventInfo(TInteractiveGesture.PressAndTap));
    FPressAndTapPossible := False;
    FPressAndTapSecondTouchDown := False;
  end;

  if (FFirstPointerDownCoordinates.Distance(Touches[0].Location) <= GetLongTapAllowedMovement) and
    Supports(Parent, IGestureControl, GestureObj) then
    GestureObj.Tap(Touches[0].Location);
  FFirstPointerDownCoordinates := TPointF.Create(-1, -1);
end;

end.
