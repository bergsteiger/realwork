{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                   OVCABTN.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcABtn;
  {-Attached Button component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Buttons, Classes, Controls, ExtCtrls, Forms, Graphics,
  Menus, Messages, SysUtils,
  OvcBase, OvcConst, OvcData, OvcExcpt, OvcVer;

type
  {position of button when attached to a control}
  TButtonPosition   = (bpRight, bpLeft, bpTop, bpBottom);

const
  DefAttachTwoWay = False;
  DefPosition     = bpRight;
  DefHeight       = 21;
  DefSeparation   = 1;

type
  TOvcAttachedButton = class(TBitBtn)
  {.Z+}
  protected {private}
    {property instance variables}
    FAttachedControl : TWinControl;
    FAttachTwoWay    : Boolean;
    FPosition        : TButtonPosition;
    FSeparation      : Integer;

    {private instance variables}
    abNewWndProc     : Pointer;
    abPrevWndProc    : Pointer;
    abSizing         : Boolean;

    {property methods}
    function GetVersion : string;                                      {!!.13}
    procedure SetAttachedControl(Value : TWinControl);
    procedure SetAttachTwoWay(Value : Boolean);
    procedure SetPosition(Value : TButtonPosition);
    procedure SetSeparation(Value : Integer);
    procedure SetVersion(Value : string);                              {!!.13}

    {internal methods}
    procedure abHookControl;
    procedure abSetButtonBounds(CR : TRect);
    procedure abSetControlBounds;
    procedure abUnHookControl;
    procedure abWndProc(var Msg : TMessage);
      {-window procedure}

    {private message response methods}
    procedure OMRecreateWnd(var Msg : TMessage);
      message om_RecreateWnd;

  protected
    procedure CreateWnd;
      override;
    procedure Notification(AComponent : TComponent; Operation: TOperation);
      override;

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight : Integer);       {!!.D4}
      override;
  {.Z-}

  published
    property AttachedControl : TWinControl
      read FAttachedControl
      write SetAttachedControl;

    property AttachTwoWay : Boolean
      read FAttachTwoWay
      write SetAttachTwoWay
      default DefAttachTwoWay;

    property Position : TButtonPosition
      read FPosition
      write SetPosition
      default DefPosition;

    property Separation : Integer
      read FSeparation
      write SetSeparation
      default DefSeparation;

    property Version : string                                          {!!.13}
      read GetVersion                                                  {!!.13}
      write SetVersion                                                 {!!.13}
      stored False;                                                    {!!.13}
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}


{*** TOvcAttachedButton ***}

procedure TOvcAttachedButton.abHookControl;
var
  P : Pointer;
begin
  {hook into attached control's window procedure}
  if (AttachedControl <> nil) then begin
    AttachedControl.HandleNeeded;

    {save original window procedure if not already saved}
    P := Pointer(GetWindowLong(AttachedControl.Handle, GWL_WNDPROC));

    if (P <> abNewWndProc) then begin
      abPrevWndProc := Pointer(GetWindowLong(AttachedControl.Handle, GWL_WNDPROC));

      {change to ours}
      SetWindowLong(AttachedControl.Handle, GWL_WNDPROC, LongInt(abNewWndProc));
    end;
  end;
end;

procedure TOvcAttachedButton.abSetButtonBounds(CR : TRect);
begin
  if abSizing then
    Exit;

  abSizing := True;
  try
    case FPosition of
      bpRight  : SetBounds(CR.Right + Separation, CR.Top, Width, CR.Bottom-CR.Top);
      bpLeft   : SetBounds(CR.Left - Width - Separation, CR.Top, Width, CR.Bottom-CR.Top);
      bpTop    : SetBounds(CR.Left, CR.Top-Height - Separation, CR.Right-CR.Left, Height);
      bpBottom : SetBounds(CR.Left, CR.Bottom + Separation, CR.Right-CR.Left, Height);
    end;
  finally
    abSizing := False;
  end;
end;

procedure TOvcAttachedButton.abSetControlBounds;
var
  acW : Integer;
  acH : Integer;
begin
  if abSizing then
    Exit;

  if (AttachedControl = nil) then
    Exit;

  if not FAttachTwoWay then
    Exit;

  abSizing := True;
  try
    acW := AttachedControl.Width;
    acH := AttachedControl.Height;
    case FPosition of
      bpRight  : AttachedControl.SetBounds(Left-acW-Separation, Top, acW, Height);
      bpLeft   : AttachedControl.SetBounds(Left+Width+Separation, Top, acW, Height);
      bpTop    : AttachedControl.SetBounds(Left, Top+Height+Separation, Width, acH);
      bpBottom : AttachedControl.SetBounds(Left, Top-acH-Separation, Width, acH);
    end;
  finally
    abSizing := False;
  end;
end;

procedure TOvcAttachedButton.abUnHookControl;
begin
  if (AttachedControl <> nil) then begin
    if Assigned(abPrevWndProc) and AttachedControl.HandleAllocated then
      SetWindowLong(AttachedControl.Handle, GWL_WNDPROC, LongInt(abPrevWndProc));
  end;
  abPrevWndProc := nil;
end;

procedure TOvcAttachedButton.abWndProc(var Msg : TMessage);
begin
  if (AttachedControl <> nil) then begin
    try
      case Msg.Msg of
        WM_SIZE, WM_MOVE :
          abSetButtonBounds(AttachedControl.BoundsRect);
      end;
    except
      Application.HandleException(Self);
    end
  end;

  with Msg do begin
    if Assigned(abPrevWndProc) then
      Result := CallWindowProc(abPrevWndProc, AttachedControl.Handle, Msg, wParam, lParam)
    else
      Result := CallWindowProc(DefWndProc, AttachedControl.Handle, Msg, wParam, lParam);

    if Msg = WM_DESTROY then begin
      {the window handle for the attached control has been destroyed}
      {we need to un-attach and then re-attach (if possible)}
      abUnHookControl;
      if not (csDestroying in ComponentState) then
        PostMessage(Handle, om_RecreateWnd, 0, 0);
    end;

    {if we get this message, we must be attached -- return self}
    if Msg = om_IsAttached then
      Result := LongInt(Self);
  end;
end;

constructor TOvcAttachedButton.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle - [csSetCaption];

  {create a callable window proc pointer}
  abNewWndProc := MakeObjectInstance(abWndProc);

  {initialize inherited properties}
  Width  := DefHeight;                                                 {!!.15}
  Height := DefHeight;

  {initialize property variables}
  FAttachTwoWay := DefAttachTwoWay;
  FPosition     := DefPosition;
  FSeparation   := DefSeparation;
end;

procedure TOvcAttachedButton.CreateWnd;
begin
  inherited CreateWnd;

  {hook into attached control's window procedure}
  abHookControl;

  {adjust our position and size}
  if (AttachedControl <> nil) and AttachedControl.HandleAllocated then
    abSetButtonBounds(AttachedControl.BoundsRect);
end;

destructor TOvcAttachedButton.Destroy;
begin
  {unhook from attached control's window procedure}
  abUnHookControl;
  FAttachedControl := nil;

  FreeObjectInstance(abNewWndProc);
  abNewWndProc := nil;

  inherited Destroy;
end;

{!!.13}
function TOvcAttachedButton.GetVersion : string;
begin
  Result := OvcVersionStr;
end;

procedure TOvcAttachedButton.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (AComponent = AttachedControl) and (Operation = opRemove) then
    AttachedControl := nil;
end;

procedure TOvcAttachedButton.OMRecreateWnd(var Msg : TMessage);
begin
  RecreateWnd;
end;

procedure TOvcAttachedButton.SetAttachedControl(Value : TWinControl);
var
  WC : TWinControl;
begin
  if Value <> FAttachedControl then begin

    {unhook from attached control's window procedure}
    abUnHookControl;

    {insure that we are the only one to hook to this control}
    if not (csLoading in ComponentState) and Assigned(Value) then begin
      {send message asking if this control is attached to anything}
      {the control itself won't be able to respond unless it is attached}
      {in which case, it will be our hook into the window procedure that}
      {is actually responding}

      if Value.HandleAllocated then begin
        WC := TWinControl(SendMessage(Value.Handle, om_IsAttached, 0, 0));
        if Assigned(WC) then
          raise EOvcException.CreateFmt(GetOrphStr(SCControlAttached) , [WC.Name]);
      end;
    end;

    FAttachedControl := Value;
    RecreateWnd;
  end;
end;

procedure TOvcAttachedButton.SetAttachTwoWay(Value : Boolean);
begin
  if (Value <> FAttachTwoWay) then begin
    FAttachTwoWay := Value;
  end;
end;

procedure TOvcAttachedButton.SetBounds(ALeft, ATop, AWidth, AHeight : Integer);
var
  L, T, H, W : Integer;
begin
  {if anything changes, may need to adjust attached control}
  L := Left;
  T := Top;
  H := Height;
  W := Width;

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  if (L <> Left) or (T <> Top) or (H <> Height) or (W <> Width) then
    abSetControlBounds;
end;

procedure TOvcAttachedButton.SetPosition(Value : TButtonPosition);
begin
  if (Value <> FPosition) then begin
    FPosition := Value;
    if not (csLoading in ComponentState) then
      if (AttachedControl <> nil) then
        abSetButtonBounds(AttachedControl.BoundsRect);
  end;
end;

procedure TOvcAttachedButton.SetSeparation(Value : Integer);
begin
  if (Value <> FSeparation) then begin
    FSeparation := Value;
    if not (csLoading in ComponentState) then
      if (AttachedControl <> nil) then
        abSetButtonBounds(AttachedControl.BoundsRect);
  end;
end;

{!!.13}
procedure TOvcAttachedButton.SetVersion(Value : string);
begin
end;


end.