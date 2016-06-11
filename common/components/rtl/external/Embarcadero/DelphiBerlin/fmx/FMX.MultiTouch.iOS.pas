{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.MultiTouch.iOS;

interface

uses
  System.Classes, System.Types, FMX.MultiTouch, FMX.Types;

type

  TMultiTouchManagerIOS = class(TMultiTouchManager)
  protected
    procedure TouchDown; override;
    procedure TouchUp; override;
    procedure TouchMove; override;
    procedure TouchCancel; override;
    function SendCMGestureMessage(AEventInfo: TGestureEventInfo): Boolean; override;
    function CreateEventInfo(var EventInfo: TGestureEventInfo; const AGesture: TInteractiveGesture;
      const ALocation: TPointF; const AState: TInteractiveGestureFlags): Boolean;
  public
    procedure HandlePan(const Location: TPointF; const Distance: Integer; const State: TInteractiveGestureFlags;
      const TouchCount: Integer);
    procedure HandleZoom(const Location: TPointF; const Distance: Integer; const State: TInteractiveGestureFlags;
      const TouchCount: Integer);
    procedure HandleRotate(const Location: TPointF; const Angle: Double; const State: TInteractiveGestureFlags;
      const TouchCount: Integer);
    procedure HandleTwoFingerTap(const Location: TPointF; const State: TInteractiveGestureFlags;
      const TouchCount: Integer);
  end;

implementation

uses
  System.UITypes, System.SysUtils, FMX.Gestures, FMX.Gestures.iOS;

{ TMultiTouchManagerIOS }
function TMultiTouchManagerIOS.CreateEventInfo(var EventInfo: TGestureEventInfo;
  const AGesture: TInteractiveGesture; const ALocation: TPointF; const AState: TInteractiveGestureFlags): Boolean;
var
  GestureObj: IGestureControl;
  OldGestureControl: TComponent;
begin
  Result := False;
  FillChar(EventInfo, Sizeof(Result), 0);

  OldGestureControl := GestureControl;

  if (TInteractiveGestureFlag.gfBegin in AState) and Supports(TouchDownControl, IGestureControl, GestureObj) then
    GestureControl := GestureObj.GetFirstControlWithGesture(AGesture);

  if GestureControl <> nil then
  begin
    Result := True;
    EventInfo.Location := ALocation;
    EventInfo.GestureID := igiZoom + Ord(AGesture);
    EventInfo.Flags := AState;
  end
  else
    GestureControl := OldGestureControl;
end;

procedure TMultiTouchManagerIOS.HandlePan(const Location: TPointF; const Distance: Integer;
  const State: TInteractiveGestureFlags; const TouchCount: Integer);
var
  EventInfo: TGestureEventInfo;
begin
  if CreateEventInfo(EventInfo, TInteractiveGesture.Pan, Location, State) then
  begin
    EventInfo.Distance := Distance;
    SendCMGestureMessage(EventInfo);
  end;
end;

procedure TMultiTouchManagerIOS.HandleRotate(const Location: TPointF; const Angle: Double;
  const State: TInteractiveGestureFlags; const TouchCount: Integer);
var
  EventInfo: TGestureEventInfo;
begin
  if CreateEventInfo(EventInfo, TInteractiveGesture.Rotate, Location, State) then
  begin
    EventInfo.Angle := Angle;
    SendCMGestureMessage(EventInfo);
  end;
end;

procedure TMultiTouchManagerIOS.HandleTwoFingerTap(const Location: TPointF; const State: TInteractiveGestureFlags;
  const TouchCount: Integer);
var
  EventInfo: TGestureEventInfo;
  GestureObj: IGestureControl;
  OldGestureControl: TComponent;
begin
  FillChar(EventInfo, Sizeof(EventInfo), 0);

  OldGestureControl := GestureControl;
  { It's a discrete gesture. Handle it only when its state is UIGestureRecognizerStateEnded and
    no other interactive gesture is in progress. }
  if (TInteractiveGestureFlag.gfEnd in State) and Supports(TouchDownControl, IGestureControl, GestureObj) then
    GestureControl := GestureObj.GetFirstControlWithGesture(TInteractiveGesture.TwoFingerTap);

  if GestureControl <> nil then
  begin
    EventInfo.Location := Location;
    EventInfo.GestureID := igiTwoFingertap;

    SendCMGestureMessage(EventInfo);
    GestureControl := nil;
  end
  else
    GestureControl := OldGestureControl;
end;

procedure TMultiTouchManagerIOS.HandleZoom(const Location: TPointF; const Distance: Integer;
  const State: TInteractiveGestureFlags; const TouchCount: Integer);
var
  EventInfo: TGestureEventInfo;
  GestureObj: IGestureControl;
begin
  if CreateEventInfo(EventInfo, TInteractiveGesture.Zoom, Location, State) then
  begin
    if TouchCount = 2 then
    begin
      EventInfo.Distance := Distance;
      if Supports(GestureControl, IGestureControl, GestureObj) then
        GestureObj.CMGesture(EventInfo);
    end
    else if (TInteractiveGestureFlag.gfEnd in EventInfo.Flags) and Supports(GestureControl, IGestureControl, GestureObj)
    then
      GestureObj.CMGesture(EventInfo);
  end;
end;

function TMultiTouchManagerIOS.SendCMGestureMessage(AEventInfo: TGestureEventInfo): Boolean;
var
  GestureObj: IGestureControl;
begin
  Result := False;
  if Supports(GestureControl, IGestureControl, GestureObj) then
  begin
    GestureObj.CMGesture(AEventInfo);
    Result := True;
  end;

  if TInteractiveGestureFlag.gfEnd in AEventInfo.Flags then
    GestureControl := nil;
end;

procedure TMultiTouchManagerIOS.TouchCancel;
var
  GestureObj: IGestureControl;
begin
  if (Length(Touches) = 1) and Supports(GestureControl, IGestureControl, GestureObj) and
    (GestureObj.TouchManager.GestureEngine <> nil) then
    TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine).ClearPoints;
  FFirstPointerDownCoordinates := TPointF.Zero;
end;

procedure TMultiTouchManagerIOS.TouchDown;
var
  GestureObj: IGestureControl;
  LGestureEngine: TPlatformGestureEngine;
begin
  if Length(Touches) = 1 then
  begin
    FFirstPointerDownCoordinates := Touches[0].Location;
    if Supports(TouchDownControl, IGestureControl, GestureObj) then
    begin
      GestureControl := GestureObj.GetFirstControlWithGestureEngine;
      if Supports(GestureControl, IGestureControl, GestureObj) then
      begin
        LGestureEngine := TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine);
        LGestureEngine.InitialPoint := Touches[0].Location;
        // Retain the points/touches.
        LGestureEngine.ClearPoints;
        LGestureEngine.AddPoint(Touches[0].Location.X, Touches[0].Location.Y);
      end;
    end;
  end;
end;

procedure TMultiTouchManagerIOS.TouchMove;

  function HaveGestureEngine(const AGestureControl: TComponent; out AGestureObj: IGestureControl): Boolean;
  begin
    Result := Supports(AGestureControl, IGestureControl, AGestureObj) and (AGestureObj.TouchManager.GestureEngine <> nil);
  end;

var
  GestureObj: IGestureControl;
begin
  if (Length(Touches) = 1) and HaveGestureEngine(GestureControl, GestureObj) or HaveGestureEngine(TouchDownControl, GestureObj) then
    TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine).AddPoint(Touches[0].Location.X, Touches[0].Location.Y);
end;

procedure TMultiTouchManagerIOS.TouchUp;
var
  ResultGestureControl: TComponent;
  GestureObj: IGestureControl;
  EventInfo: TGestureEventInfo;
  LGestureEngine: TPlatformGestureEngine;
const
  LGestureTypes: TGestureTypes = [TGestureType.Standard, TGestureType.Recorded, TGestureType.Registered];
begin
  if Length(Touches) = 1 then
  begin
    ResultGestureControl := nil;
    // We have two different kinds of gestures: standard and interactive. So if two different controls subscribe to
    // receiving different gestures kinds, we should separately deliver each kind of gesture to each control. This method
    // consider only standard gesture. So we should find control, which responds to standard gesture.
    // If interactive gesture was processed early, GestureControl would be nil in this place. And we should use
    // TouchDownControl instead.
    if Supports(GestureControl, IGestureControl, GestureObj) then
      ResultGestureControl := GestureControl
    else if Supports(TouchDownControl, IGestureControl, GestureObj) then
      ResultGestureControl := TouchDownControl;

    if ResultGestureControl <> nil then
    begin
      if GestureObj.TouchManager.GestureEngine <> nil then
      begin
        LGestureEngine := TPlatformGestureEngine(GestureObj.TouchManager.GestureEngine);
        if LGestureEngine.PointCount > 1 then
        begin
          FillChar(EventInfo, Sizeof(EventInfo), 0);
          if TPlatformGestureEngine.IsGesture(LGestureEngine.Points, LGestureEngine.GestureList, LGestureTypes, EventInfo) then
            LGestureEngine.BroadcastGesture(ResultGestureControl, EventInfo);
        end;
        // reset the points/touches
        LGestureEngine.ClearPoints;
        GestureControl := nil;
      end;
    end;

    if (FFirstPointerDownCoordinates.Distance(Touches[0].Location) <= GetLongTapAllowedMovement) and
      Supports(Parent, IGestureControl, GestureObj) then
      GestureObj.Tap(Touches[0].Location);
  end;
  FFirstPointerDownCoordinates := TPointF.Zero;
end;

end.
