{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.MultiTouch.Android;

interface

uses
  System.Types, System.Classes, FMX.MultiTouch, FMX.Types;

type
  TMultiTouchManagerAndroid = class(TMultiTouchManager)
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
  end;

implementation

uses
  System.Math, System.UITypes, System.SysUtils;

const
  LongTapMovement = 10; // 10 pixels - use scale to transform to points to use on each device

  { TMultiTouchManagerAndroid }

constructor TMultiTouchManagerAndroid.Create(const AParent: TComponent);
begin
  inherited;
  FActiveInteractiveGestures := [];
  FEnabledInteractiveGestures := [];
  FRotationAngle := 0;
  FOldPoint1 := TPointF.Zero;
  FOldPoint2 := TPointF.Zero;
  FSecondPointer := TPointF.Zero;
end;

destructor TMultiTouchManagerAndroid.Destroy;
begin
  Parent := nil;
end;

procedure TMultiTouchManagerAndroid.HandleTouches(const ATouches: TTouches; const Action: TTouchAction;
  const Control: IControl);
begin
  FFirstPointer := ATouches[0].Location;

  if Length(ATouches) > 1 then
    FSecondPointer := ATouches[1].Location;

  inherited;

  FOldPoint1 := FFirstPointer;
  FOldPoint2 := FSecondPointer;
end;

procedure TMultiTouchManagerAndroid.SetEnabledGestures(const AEnabledInteractiveGestures: TInteractiveGestures);
begin
  FEnabledInteractiveGestures := AEnabledInteractiveGestures;
end;

procedure TMultiTouchManagerAndroid.TouchCancel;
begin
  FActiveInteractiveGestures := [];
  FRotationAngle := 0;
  FFirstPointerDownCoordinates := TPointF.Zero;
end;

procedure TMultiTouchManagerAndroid.TouchDown;
begin
  if Length(Touches) = 1 then
    FFirstPointerDownCoordinates := Touches[0].Location
  else if Length(Touches) > 2 then
  begin
    // end zoom and rotate gestures if they are active
    EndInteractiveGesture(TInteractiveGesture.Zoom);
    if EndInteractiveGesture(TInteractiveGesture.Rotate) then
      FRotationAngle := 0;
  end;
end;

procedure TMultiTouchManagerAndroid.TouchMove;
begin
  if Length(Touches) = 1 then
  begin
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

    FOldPoint2 := TPointF.Zero;
  end;

  if (Length(Touches) = 2) and not FindAndHandleInteractiveGesture(FActiveInteractiveGestures, FSecondPointer, True) then
    FindAndHandleInteractiveGesture(FEnabledInteractiveGestures - FActiveInteractiveGestures, FSecondPointer);
end;

procedure TMultiTouchManagerAndroid.TouchUp;
var
  GestureObj: IGestureControl;
begin
  EndInteractiveGesture(TInteractiveGesture.Pan);

  if Length(Touches) = 1 then
  begin
    // end zoom and rotate gestures if they are active
    EndInteractiveGesture(TInteractiveGesture.Zoom);
    if EndInteractiveGesture(TInteractiveGesture.Rotate) then
      FRotationAngle := 0;

    if (FFirstPointerDownCoordinates.Distance(Touches[0].Location) <= GetLongTapAllowedMovement) and
      Supports(Parent, IGestureControl, GestureObj) then
      GestureObj.Tap(Touches[0].Location);

    FFirstPointerDownCoordinates := TPointF.Zero;
  end;
end;

end.
