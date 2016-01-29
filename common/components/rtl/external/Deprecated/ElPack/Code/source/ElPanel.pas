{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

11/01/2002

  Changed default for TabStop property

10/28/2002

  Fixed realignment of controls after panel movement/resizing

07/24/2002

  Published OnStartDrag property

03/03/2002

  Added BevelSpaceColor. This color is used to draw bevel which is of type bvSpace.

02/03/2002

  Added size grip for resizable panels

01/27/2002

  Vertical text aligment worked slightly incorrectly. Fixed.

11/20/2001

  Fixed painting of inner border with XP styles enabled

11/17/2001

  Fixed painting of edges with XP styles enabled

11/16/2001

  Panel with XP styles enabled is now OPTIONALLY drawn with DrawThemeParentBackground
  This is controlled by TransparentXPThemes property

10/24/2001

  ! Panel with XP styles enabled is now drawn with DrawThemeParentBackground,
  thus behaving as transparent.

10/16/2001

  CLX adaptation complete

04/23/2001

  OnMouseEnter and OnMouseLeave events added

*)

unit ElPanel;

interface

uses
  Windows,
  Messages,
  Graphics,
  Controls,
  StdCtrls,
  Forms,
  ExtCtrls,
  Menus,
{$ifdef VCL_6_USED}
  Types,
{$endif}
  SysUtils,
  Classes,

  ElXPThemedControl,
  {$ifdef ELPACK_USE_IMAGEFORM}
  ElImgFrm,
  {$endif}
{$ifdef ELPACK_USE_STYLEMANAGER}
  ElStyleMan,
{$endif}
  ElUxTheme,
  ElTmSchema,
  ElVCLUtils,
  ElStrUtils,
  ElExtBkgnd,
  // dbugintf,
  ElTools;

type
  TElPanelGrabHandleKind = (ghkNone, ghkMove, ghkResize, ghkMoveParent);
type

  TCustomElPanel = class;

  TElPanelGrabHandle = class(TPersistent)
  private
    FEnabled : Boolean;
    FSize : Integer;
    FKind : TElPanelGrabHandleKind;
    FBevelKind : TPanelBevel;
    FOwner      : TCustomElPanel;
    FVisible : Boolean;
    procedure SetVisible(newValue : Boolean);
    procedure SetEnabled(newValue : Boolean);
    procedure SetSize   (newValue : Integer);
    procedure SetBevelKind(newValue : TPanelBevel);
  public
    procedure Assign(Source : TPersistent); override;
  published
    property Enabled    : Boolean read FEnabled write SetEnabled default false;  { Published }
    property Size       : Integer read FSize write SetSize default 0;  { Published }
    property Kind       : TElPanelGrabHandleKind read FKind write FKind default ghkNone;  { Published }
    property BevelKind  : TPanelBevel read FBevelKind write SetBevelKind default bvNone;  { Published }
    property Visible : Boolean read FVisible write SetVisible default false;  { Published }
  end;

  TCustomElPanel = class(TCustomPanel)
  protected
    FBevelInner: TPanelBevel;
    FBevelOuter: TPanelBevel;
    FBevelWidth: TBevelWidth;
    FOwnerDraw : Boolean;
    FAlwaysPaintBackground: boolean;
    FLayout : TTextLayout;
    FOnPaint : TNotifyEvent;
    FGradientSteps : Integer;
    FGradientStartColor : TColor;
    FGradientEndColor : TColor;
    FTmpBmp : TBitmap;
    FTransparent : Boolean;
    FBackground : TBitmap;
    FBackgroundType : TElBkGndType;
{$ifdef ELPACK_USE_IMAGEFORM}
    FImgFormChLink  : TImgFormChangeLink;
    FImgForm        : TElImageForm;
{$endif}
    FSaveCapture : HWND;
    FOnMove : TNotifyEvent;
    FResizable : Boolean;
    FMovable : Boolean;
    FSizeMoveRect : TRect;
    FGrabHandles    : array[1..4] of TElPanelGrabHandle;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FMouseInControl: Boolean;
    FTheme: HTheme;
    FUseXPThemes: Boolean;
    FPressed : boolean;
    FIntPaint: boolean;
    FCaption: TElFString;
    FAlphaLevel: Byte;
    FTransparentXPThemes: Boolean;
    FSizeGrip: Boolean;
    SizeGripRect : TRect;
    FBevelSpaceColor: TColor;
    FShowFocus: Boolean;
    {$ifdef ELPACK_UNICODE}
    FHint: TElFString;
    {$endif}
    {$IFDEF ELPACK_USE_STYLEMANAGER}
    FStyleMgrLink : TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    {$endif}
    procedure SetBackground(newValue : TBitmap);
    procedure ImageChange(Sender : TObject);
    procedure ImageFormChange(Sender : TObject);
    procedure SetResizable(newValue : Boolean); virtual;
    procedure SetBevelInner(Value: TPanelBevel);
    procedure SetBevelOuter(Value: TPanelBevel);
    procedure SetBevelWidth(Value: TBevelWidth);
    procedure WMEnterSizeMove(var Msg : TMessage); message WM_ENTERSIZEMOVE;
    procedure WMExitSizeMove(var Msg : TMessage); message WM_EXITSIZEMOVE;
    procedure WMNCHitTest(var Msg : TMessage); message WM_NCHITTEST;
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd); message WM_EraseBkgnd;
    procedure WMMouseMove(var Msg : TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonDown(var Msg : TMessage); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg : TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMove(var Msg : TWMMove); message WM_MOVE;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure WMPaint(var Msg : TWMPaint); message WM_PAINT;
    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;
    {$endif}
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    {$endif}
    procedure RedoTmpBmp;
    procedure SetGradientStartColor(newValue : TColor);
    procedure SetGradientEndColor(newValue : TColor);
    procedure SetGradientSteps(newValue : Integer);
    procedure SetLayout(newValue : TTextLayout);
    procedure SetOwnerDraw(newValue : Boolean);
    function GetTopGrabHandle : TElPanelGrabHandle;
    procedure SetTopGrabHandle(newValue : TElPanelGrabHandle);
    function GetRightGrabHandle : TElPanelGrabHandle;
    procedure SetRightGrabHandle(newValue : TElPanelGrabHandle);
    function GetLeftGrabHandle : TElPanelGrabHandle;
    procedure SetLeftGrabHandle(newValue : TElPanelGrabHandle);
    function GetBottomGrabHandle : TElPanelGrabHandle;
    procedure SetBottomGrabHandle(newValue : TElPanelGrabHandle);
    procedure SetAlwaysPaintBackground(Value : boolean);
    //procedure DrawBackground(DC: HDC);


    procedure Loaded; override;
    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure SetImageForm(newValue : TElImageForm); virtual;
    {$endif}
    {$ifdef ELPACK_USE_STYLEMANAGER}
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure StyleMgrChange(Sender : TObject);
    procedure UpdateStyle;
    {$endif}
    procedure SetBackgroundType(newValue : TElBkGndType); virtual;
    procedure SetTransparent(newValue : Boolean); virtual;
    procedure SetMovable(newValue : Boolean); virtual;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Paint; override;
    procedure TriggerMoveEvent; virtual;
    procedure TriggerPaintEvent; virtual;
    procedure SetCaption(newValue: TElFString); virtual;
    procedure CreateParams(var Params : TCreateParams); override;
    procedure WndProc(var Message : TMessage); override;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure AdjustClientRect(var Rect: TRect);{$IFDEF VCL_4_USED}override{$else}virtual{$ENDIF};
    function  InGrabHandle(X, Y : integer; Rect : TRect) : TElPanelGrabHandle;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoMouseEnter; virtual;
    procedure DoMouseLeave; virtual;
    function GetCaption: TElFString; virtual;
    procedure SetAlphaLevel(Value: Byte);

    function GetThemedClassName: WideString; virtual;
    procedure SetUseXPThemes(const Value: Boolean); virtual;
    procedure CreateThemeHandle; virtual;
    procedure FreeThemeHandle; virtual;

    procedure CreateWnd; override;
    procedure DestroyWnd; override;

    procedure ELThemeChanged(var Message: TMessage); message EL_THEMECHANGED;
    procedure WMIsThemedControl(var Message: TMessage); message WM_ISTHEMEDCONTROL;
    procedure DrawThemedBackground; virtual;
    function GetBackgroundClientRect: TRect; virtual;
    procedure SetTransparentXPThemes(Value: Boolean); virtual;
    procedure SetSizeGrip(Value: Boolean);
    procedure UpdateInterior; virtual;
    procedure SetBevelSpaceColor(Value: TColor);
    procedure SetShowFocus(Value: Boolean);
    procedure PaintWindow(DC: HDC); override;

    {$ifdef ELPACK_UNICODE}
    procedure SetHint(Value: TElFString);

    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    {$endif}
    property AlwaysPaintBackground : boolean read FAlwaysPaintBackground write SetAlwaysPaintBackground default false;
    property Layout : TTextLayout read FLayout write SetLayout default tlCenter;  { Published }
    property OwnerDraw : Boolean read FOwnerDraw write SetOwnerDraw default false;  { Published }
    property Background : TBitmap read FBackground write SetBackground;
    property BackgroundType : TElBkGndType read FBackgroundType write SetBackgroundType default bgtColorFill;
    property Resizable : Boolean read FResizable write SetResizable default false;
    property Movable : Boolean read FMovable write SetMovable default false;
    property Transparent : Boolean read FTransparent write SetTransparent default false; { Protected }
    property Caption: TElFString read GetCaption write SetCaption;
    property GradientStartColor : TColor read FGradientStartColor write SetGradientStartColor default clBlack;  { Protected }
    property GradientEndColor : TColor read FGradientEndColor write SetGradientEndColor default clBlack;  { Protected }
    property GradientSteps : Integer read FGradientSteps write SetGradientSteps default 16;  { Protected }
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm     : TElImageForm read FImgForm write SetImageForm;
    {$endif}
    property TopGrabHandle : TElPanelGrabHandle read GetTopGrabHandle write SetTopGrabHandle;  { Published }
    property RightGrabHandle : TElPanelGrabHandle read GetRightGrabHandle write SetRightGrabHandle;  { Published }
    property LeftGrabHandle : TElPanelGrabHandle read GetLeftGrabHandle write SetLeftGrabHandle;  { Published }
    property BottomGrabHandle : TElPanelGrabHandle read GetBottomGrabHandle write SetBottomGrabHandle;  { Published }

    property OnMove : TNotifyEvent read FOnMove write FOnMove;
    property OnPaint : TNotifyEvent read FOnPaint write FOnPaint;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property AlphaLevel: Byte read FAlphaLevel write SetAlphaLevel default 0;
    property UseXPThemes: Boolean read FUseXPThemes write SetUseXPThemes default
        True;
    property TransparentXPThemes: Boolean read FTransparentXPThemes write
        SetTransparentXPThemes default true;
    property MouseCapture default false;
    property TabStop;
    property SizeGrip: Boolean read FSizeGrip write SetSizeGrip default false;
    property BevelInner: TPanelBevel read FBevelInner write SetBevelInner default
        bvNone;
    property BevelOuter: TPanelBevel read FBevelOuter write SetBevelOuter default
        bvRaised;
    property BevelWidth: TBevelWidth read FBevelWidth write SetBevelWidth default 1;
    property BevelSpaceColor: TColor read FBevelSpaceColor write SetBevelSpaceColor
        default clBtnFace;
    property ShowFocus: Boolean read FShowFocus write SetShowFocus default false;
  public
    procedure Update; override;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function IsThemeApplied: Boolean;

    property MouseInControl: Boolean read FMouseInControl;
    property Canvas;
    property Theme: HTheme read FTheme;
  published
    {$ifdef ELPACK_UNICODE}
    property Hint: TElFString read FHint write SetHint;
    {$endif}
    {$ifdef ELPACK_USE_STYLEMANAGER}
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    {$endif}
  end;

  TElPanel = class(TCustomElPanel)
    property AlphaLevel;
    property AlwaysPaintBackground;
    property Background;
    property BackgroundType;
    property GradientEndColor;
    property GradientStartColor;
    property GradientSteps;
    property Alignment;
    property Layout;
    property OwnerDraw;
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm;
    {$endif}
    property TopGrabHandle;
    property RightGrabHandle;
    property LeftGrabHandle;
    property BottomGrabHandle;

    property Resizable;
    property Movable;
    property OnMove;
    property OnPaint;

    property SizeGrip;
    property Align nodefault;
    {$ifdef VCL_4_USED}
    property AutoSize;
    {$endif}
    property BevelInner;
    property BevelOuter;
    property BevelSpaceColor;
    property BevelWidth;
    property BorderStyle;
    property BorderWidth;
    property TransparentXPThemes;
    property UseXPThemes;

    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Locked;
    property MouseCapture default False;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property Caption;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnStartDrag;
{$IFDEF VCL_4_USED}
    property Anchors;
    property Action;
    property Constraints;
    property DockSite;
    property DockOrientation;
    property BevelKind;
    property DoubleBuffered default False;
    property DragKind;
{$ENDIF}
{$IFDEF VCL_5_USED}
    property OnContextPopup;
{$ENDIF}
  end;

implementation

procedure TElPanelGrabHandle.Assign(Source : TPersistent);
begin
  if Source is TElPanelGrabHandle then
  with TElPanelGrabHandle(Source) do
    begin
      Self.FEnabled := Enabled;
      Self.FSize := Size;
      Self.FKind := Kind;
      Self.FBevelKind := BevelKind;
      Self.FVisible := Visible;
      if (not (csLoading in Self.FOwner.ComponentState)) and (FOwner.HandleAllocated) then
      Self.FOwner.Invalidate;
    end
  else inherited;
end;

procedure TElPanelGrabHandle.SetEnabled(newValue : Boolean);
var R : TRect;
begin
  if (FEnabled <> newValue) then
  begin
    FEnabled := newValue;
    R := FOwner.ClientRect;
    FOwner.AlignControls(nil, R);
    FOwner.UpdateInterior;
    FOwner.Invalidate;
  end;  { if }
end;  { SetEnabled }

procedure TElPanelGrabHandle.SetBevelKind(newValue : TPanelBevel);
begin
  if (FBevelKind <> newValue) then
  begin
    FBevelKind := newValue;
    if FOwner.Handleallocated then
      FOwner.Invalidate;
  end;  { if }
end;

procedure TElPanelGrabHandle.SetSize(newValue : Integer);
var R : TRect;
begin
  if (FSize <> newValue) then
  begin
    FSize := newValue;
    if FOwner.Handleallocated then
    begin
      R := FOwner.ClientRect;
      FOwner.AlignControls(nil, R);
      FOwner.UpdateInterior;
      FOwner.Invalidate;
    end;
  end;  { if }
end;  { SetSize }

procedure TElPanelGrabHandle.SetVisible(newValue : Boolean);
var R : TRect;
begin
  if (FVisible <> newValue) then
  begin
    FVisible := newValue;
    if FOwner.Handleallocated then
    begin
      R := FOwner.ClientRect;
      FOwner.AlignControls(nil, R);
      FOwner.UpdateInterior;
      FOwner.Invalidate;
    end;  { if }
  end;
end;  { SetVisible }

procedure TCustomElPanel.WMMouseMove(var Msg : TWMMouseMove); { private }
var aHandle : TElPanelGrabHandle;
    R : TRect;
begin
  inherited;
  if (not FMouseInControl) then
  begin
    DoMouseEnter;
  end;

  if FPressed then
  begin
    R := ClientRect;
    if BorderWidth <> 0 then InflateRect(R, -BorderWidth, -BorderWidth);
    if BevelInner <> bvNone then InflateRect(R, -BevelWidth, -BevelWidth);
    if BevelOuter <> bvNone then InflateRect(R, -BevelWidth, -BevelWidth);
    aHandle := InGrabHandle(Msg.XPos, Msg.YPos, R);
    if ((AHandle <> nil) and (AHandle.Kind = ghkMoveParent)) and not (csDesigning in ComponentState) then
    begin
      FPressed := false;
      ReleaseCapture;
      Parent.BringToFront;
      PostMessage(Parent.Handle, wm_SysCommand, sc_DragMove, Msg.XPos shl 16 + Msg.YPos);
      PostMessage(Parent.Handle, wm_KeyDown, VK_SPACE, 0);
      exit;
    end;
  end;
  if FPressed and (FMovable) and not (csDesigning in ComponentState)  then
  begin
    FPressed := false;
    ReleaseCapture;
    DoMouseLeave;
    BringToFront;
    PostMessage(Handle, wm_SysCommand, sc_DragMove, Msg.XPos shl 16 + Msg.YPos);
    PostMessage(Handle, wm_KeyDown, VK_SPACE, 0);
  end;
end; { WMMouseMove }

procedure TCustomElPanel.WMLButtonUp(var Msg : TWMLButtonUp); { private }
begin
  if FPressed then
  begin
    FPressed := false;
    if FSaveCapture <> 0 then
    begin
      SetCapture(FSaveCapture);
      FSaveCapture := 0;
    end
    else
      ReleaseCapture;
  end;
  inherited;
end; { WMLButtonUp }

procedure TCustomElPanel.WMLButtonDown(var Msg : TMessage);
begin
  inherited;
  FPressed := true;
  if Movable then
    FSaveCapture := SetCapture(Handle);
end; {WMLButtonDown}

procedure TCustomElPanel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    {$ifdef ELPACK_USE_IMAGEFORM}
    if AComponent = FImgForm then
    begin
      FImgForm := nil;
      if HandleAllocated then Invalidate;
    end;
    {$endif}
  end;
{$ifdef ELPACK_USE_STYLEMANAGER}
  if (Operation = opRemove) and (AComponent = FStyleManager) then
     StyleManager := nil;
{$ENDIF}
end;

{$ifdef ELPACK_USE_IMAGEFORM}
procedure TCustomElPanel.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      {$endif}
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then FImgForm.RegisterChanges(FImgFormChLink);
    Invalidate;
  end;
end;
{$endif}
procedure TCustomElPanel.SetBackground(newValue : TBitmap);
begin
  FBackground.Assign(newValue);
  if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
     then BackgroundType := bgtColorFill;
end; {SetBackground}

procedure TCustomElPanel.SetBackgroundType(newValue : TElBkGndType);
begin
  if (FBackgroundType <> newValue) then
  begin
    FBackgroundType := newValue;
    if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
       then FBackgroundType := bgtColorFill;
    RedoTmpBmp;
    Invalidate;
  end; {if}
end; {SetBackgroundType}

procedure TCustomElPanel.CreateParams(var Params : TCreateParams);
begin
  inherited;
  if Transparent and (not IsThemeApplied) then
    Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT
  else
    Params.ExStyle := Params.ExStyle and not WS_EX_TRANSPARENT;
  Params.WindowClass.style := Params.WindowClass.style or CS_HREDRAW or CS_VREDRAW;
end; { CreateParams }

procedure TCustomElPanel.Update;
begin
  inherited;
end;

procedure TCustomElPanel.WndProc(var Message : TMessage); { protected }
var
  R : TRect;
begin
  inherited;
  if (Message.Msg = ParentControlRepaintedMessage) and Transparent and (Message.lParam <> integer(Self)) then
  begin
    IntersectRect(R, PRect(Message.WParam)^, BoundsRect);
    if not IsRectEmpty(R) then
    begin
      OffsetRect(R, -Left, -Top);
      InvalidateRect(Handle, @R, true);
      Update;
    end;
  end;
end; { WndProc }
procedure TCustomElPanel.Paint;
var
  Rect,
  CalcRect,
  R,
  R1{$ifdef MSWINDOWS},
  RClip{$endif} : TRect;
  TopColor,
  BottomColor : TColor;
  {$ifdef MSWINDOWS}
  C : integer;
  {$endif}
  //FontHeight : Integer;
  aHandle    : TElPanelGrabHandle;
  {$ifdef ELPACK_USE_IMAGEFORM}
  ACtl       : TWinControl;
  ax, ay     : integer;
  P          : TPoint;
  {$endif}

const
  Alignments : array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  Layouts    : array[TTextLayout] of Word = (DT_TOP, DT_VCENTER, DT_BOTTOM);

  procedure AdjustColors(Bevel : TPanelBevel);
  begin
    {$ifdef VCL_4_USED}
    if Bevel = bvSpace then
    begin
      TopColor := BevelSpaceColor;
      BottomColor := BevelSpaceColor;
    end
    else
    {$endif}
    begin
      TopColor := clBtnHighlight;
      if Bevel = bvLowered then TopColor := clBtnShadow;
      BottomColor := clBtnShadow;
      if Bevel = bvLowered then BottomColor := clBtnHighlight;
    end;
  end;

  procedure PaintGrabHandle(R : TRect; IsVert : boolean; BevelKind : TPanelBevel);
  var X, Y   : integer;
      DX, DY,
      ox, oy : integer;
      Color1, Color2: TColor;
  begin
    if BevelKind = bvNone then exit;
    if bevelKind = bvRaised then
    begin
      Color1 := clBtnHighlight;
      Color2 := clBtnShadow;
    end else
    begin
      Color2 := clBtnHighlight;
      Color1 := clBtnShadow;
    end;
    if IsVert then
    begin
      x := R.Left + (R.Right - R.Left) div 2 - 1;
      y := R.Top + 1;
      DX := X;
      DY := R.Bottom - 1;
      ox := 1;
      oy := 0;
    end else
    begin
      x := R.Left + 1;
      y := R.Top + (R.Bottom - R.Top) div 2 - 1;
      DX := R.Right - 1;
      DY := y;
      ox := 0;
      oy := 1;
    end;
    Canvas.Brush.Color := color;
    Canvas.FillRect(R);
    Canvas.Pen.Color := Color1;
    MoveToEx(Canvas.Handle, X, Y, nil);
    LineTo(Canvas.Handle, DX, DY);
    Canvas.Pen.Color := Color2;
    MoveToEx(Canvas.Handle, X + ox, Y + oy, nil);
    LineTo(Canvas.Handle, DX + ox, DY + oy);
  end;

var
    Bmp : TBitmap;
    DC  : HDC;
    NoPaintBorder : boolean;

begin
  {$ifdef MSWINDOWS}
  NoPaintBorder := false;
  {$endif}
  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    DrawThemedBackground;
  end
  else
  {$endif}
  begin
    if Transparent then
    begin
      DC := GetDC(Handle);
      GetClipBox(Canvas.Handle, Rect);
      OffsetRect(Rect, Left, Top);
      RedrawWindow(Parent.Handle, @Rect, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW);
      if AlphaLevel > 0 then
      begin
        OffsetRect(Rect, -Left, -Top);
        Bmp := TBitmap.Create;
        Bmp.Handle := CreateCompatibleBitmap(Canvas.Handle, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top);
        // DC := GetDC(Handle);
        bitblt(Bmp.Canvas.Handle, 0, 0, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, DC,
               Rect.Left, Rect.Top, SRCCOPY);
        ReleaseDC(Handle, DC);
        AlphaFillRect(Bmp.Canvas, Classes.Rect(0, 0, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top), Color, AlphaLevel);
        bitblt(Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
               Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        Bmp.Free;
      end
      else
      begin
        OffsetRect(Rect, -Left, -Top);
        // DC := GetDC(Handle);
        bitblt(Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, DC, Rect.Left, Rect.Top, SRCCOPY);
        ReleaseDC(Handle, DC);
      end;
    end;
    NoPaintBorder := false;
    Rect := GetClientRect;
    if (not Transparent) and (not (OwnerDraw and ((not (csDesigning in ComponentState)) or FIntPaint)) or (AlwaysPaintBackground)) then
    begin
      with Canvas do
      begin
        {$ifdef ELPACK_USE_IMAGEFORM}
        if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
        begin
          if (FImgForm.Control <> Self) then
          begin
            ACtl := FImgForm.GetRealControl;
            R1 := Rect;
            Rect.TopLeft := ClientToScreen(Rect.TopLeft);
            Rect.BottomRight := ClientToScreen(Rect.BottomRight);

            P := Parent.ClientToScreen(Point(Left, Top));
            ax := Rect.Left - P.x;
            ay := Rect.Top - P.y;

            Rect.TopLeft := ACtl.ScreenToClient(Rect.TopLeft);
            Rect.BottomRight := ACtl.ScreenToClient(Rect.BottomRight);

            FImgForm.PaintBkgnd(Handle, R1, Point(Rect.Left - ax, Rect.Top - ay), false);
            if AlphaLevel <> 0 then
            begin
              Bmp := TBitmap.Create;
              Rect := R1;
              Bmp.Handle := CreateCompatibleBitmap(Canvas.Handle, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top);
              bitblt(Bmp.Canvas.Handle, 0, 0, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, Canvas.Handle,
                     Rect.Left, Rect.Top, SRCCOPY);
              AlphaFillRect(Bmp.Canvas, Classes.Rect(0, 0, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top), Color, AlphaLevel);
              bitblt(Canvas.Handle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
                     Bmp.Canvas.Handle, 0, 0, SRCCOPY);
              Bmp.Free;
            end;
          end;
          NoPaintBorder := true;
        end
        else
        {$endif}
        begin
          case BackgroundType of //
            bgtColorFill :
              begin
                Brush.Color := Color;
                FillRect(Rect);
              end;
            bgtHorzGradient,
            bgtVertGradient:
              GradientFill(Canvas.Handle, Rect, GradientStartColor, GradientEndColor, GradientSteps, BackgroundType = bgtVertGradient);
            bgtStretchBitmap,
            bgtTileBitmap:
              begin
                CopyRect(Rect, FTmpBmp.Canvas, Classes.Rect(0, 0, FTmpBmp.Width, FTmpBmp.Height));
              end;
            bgtCenterBitmap :
              begin
                Brush.Color := Color;
                FillRect(Rect);
                R := Classes.Rect(0, 0, FBackground.Width, FBackground.Height);
                CenterRects(FBackground.Width, Rect.Right - Rect.Left, FBackground.Height, Rect.Bottom - Rect.Top, R1);
                OffsetRect(R1, Rect.Left, Rect.Top);
                CopyRect(R1, FBackground.Canvas, Classes.Rect(0, 0, FBackground.Width, FBackground.Height));
              end;
            bgtTopLeftBitmap:
              begin
                if Background.Empty then
                  FillRect(Rect)
            else
            begin
              if BackgroundType = bgtTopLeftBitmap then
              begin
                Color := Background.Canvas.Pixels[Background.Width-1, Background.Height-1];
              end;
              R1 := Rect;
              OffsetRect(R1, -Rect.Left, -Rect.Top);
              ExtDrawBkgnd2(Handle, Rect, Rect, R1.TopLeft, Color, Background, BackgroundType);
            end;
              end;
          end; // case
          NoPaintBorder := true;
        end;
      end;
    end;
  end;

  Rect := GetClientRect;

  if BevelOuter <> bvNone then
  begin
    {$ifdef MSWINDOWS}
    if IsThemeApplied then
    begin
      if BevelOuter = bvLowered then
      begin
        DrawThemeEdge(Theme, Canvas.Handle, GP_BORDER, BSS_SUNKEN, Rect, BDR_SUNKENOUTER, BF_RECT or BF_ADJUST, @Rect);
      end
      else
      if BevelOuter = bvRaised then
      begin
        DrawThemeEdge(Theme, Canvas.Handle, GP_BORDER, BSS_RAISED, Rect, BDR_RAISEDOUTER, BF_RECT or BF_ADJUST, @Rect);
      end;
    end
    else
    {$endif}
    begin
      AdjustColors(BevelOuter);
      Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
    end;
  end;
{$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    InflateRect(Rect, - BevelWidth, - BevelWidth);
  end
  else
{$endif}
  if not NoPaintBorder then
     Frame3D(Canvas, Rect, Color, Color, BorderWidth);
  if BevelInner <> bvNone then
  begin
    {$ifdef MSWINDOWS}
    if IsThemeApplied then
    begin
      if BevelInner = bvLowered then
      begin
        DrawThemeEdge(Theme, Canvas.Handle, GP_BORDER, BSS_SUNKEN, Rect, BDR_SUNKENOUTER, BF_RECT or BF_ADJUST, @Rect);
      end
      else
      if BevelOuter = bvRaised then
      begin
        DrawThemeEdge(Theme, Canvas.Handle, GP_BORDER, BSS_RAISED, Rect, BDR_RAISEDOUTER, BF_RECT or BF_ADJUST, @Rect);
      end;
    end
    else
    {$endif}
    begin
      AdjustColors(BevelInner);
      Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
    end;
  end;

  aHandle := LeftGrabHandle;
  if aHandle.Visible and aHandle.Enabled and (aHandle.BevelKind <> bvNone) then
  begin
    R := Rect;
    R.Right := R.Left + aHandle.Size;
    Inc(Rect.Left, aHandle.Size);
    PaintGrabHandle(R, true, aHandle.BevelKind);
  end;

  aHandle := RightGrabHandle;
  if aHandle.Visible and aHandle.Enabled and (aHandle.BevelKind <> bvNone) then
  begin
    R := Rect;
    R.Left := R.Right - aHandle.Size;
    Dec(Rect.Right, aHandle.Size);
    PaintGrabHandle(R, true, aHandle.BevelKind);
  end;

  aHandle := TopGrabHandle;
  if aHandle.Visible and aHandle.Enabled and (aHandle.BevelKind <> bvNone) then
  begin
    R := Rect;
    R.Bottom := R.Top + aHandle.Size;
    Inc(Rect.Top, aHandle.Size);

    PaintGrabHandle(R, false, aHandle.BevelKind);
  end;

  aHandle := BottomGrabHandle;
  if aHandle.Visible and aHandle.Enabled and (aHandle.BevelKind <> bvNone) then
  begin
    R := Rect;
    R.Top := R.Bottom - aHandle.Size;
    Dec(Rect.Bottom, aHandle.Size);
    PaintGrabHandle(R, false, aHandle.BevelKind);
  end;

  if OwnerDraw and ((not (csDesigning in ComponentState)) or FIntPaint) then
    TriggerPaintEvent
  else
  with Canvas do
  begin
    Brush.Style := bsClear;
    Font := Self.Font;
    R1 := Rect;

    if FLayout <> tlTop then
    begin
      CalcRect := Rect;
      AdjustClientRect(CalcRect);
      {$ifdef ELPACK_UNICODE}
      ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Caption), -1, CalcRect, DT_EXPANDTABS or Alignments[Alignment] or DT_CALCRECT);
      {$else}
      DrawText(Canvas.Handle, PChar(Caption), -1, CalcRect, DT_EXPANDTABS or Alignments[Alignment] or DT_CALCRECT);
      {$endif}
      if FLayout = tlBottom then
        OffsetRect(R1, 0, ((R1.Bottom - R1.Top) - (CalcRect.Bottom - CalcRect.Top)))
      else
      if FLayout = tlCenter then
        OffsetRect(R1, 0, ((R1.Bottom - R1.Top) - (CalcRect.Bottom - CalcRect.Top)) div 2);
    end;
    {$ifdef ELPACK_UNICODE}
    ElVCLUtils.DrawTextW(Handle, PWideChar(Caption), -1, R1, DT_EXPANDTABS or Alignments[Alignment]);
    {$else}
    DrawText(Handle, PChar(Caption), -1, R1, DT_EXPANDTABS or Alignments[Alignment]);
    {$endif}
    if (ShowFocus) and
    (GetFocus = Self.Handle)
    then
      DrawFocusRect(R1);
  end;

  if SizeGrip and Resizable then
  begin
    {$ifdef MSWINDOWS}
    if IsThemeApplied() then
    begin
      R := ClientRect;
      R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
      if not IsRectEmpty(R) then
      begin
        DrawThemeBackgroundTo('STATUS', Canvas.Handle, SP_GRIPPER, 0, R, @RClip);
        R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL);
        SizeGripRect := R;
      end;
    end
    else
    {$endif}
    begin
      R := Rect;
      R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL);
      R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
      SizeGripRect := R;

      C := R.Bottom - R.Top + 1;
      R.Left := R.Right - C;
      R.Top := R.Bottom - C;
      DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP);
      (*
      {.$else}
      i := 4;
      C := R.Bottom - R.Top;

      OffsetRect(R, 0, -2);
      while true do
      begin
        R.Left := R.Right - C + i;
        R.Top := R.Bottom - C + i;
        Canvas.Pen.Color := clBtnHighlight;
        Canvas.MoveTo(R.Left, R.Bottom);
        Canvas.LineTo(R.Right, R.Top);
        Inc(R.Left);
        Inc(R.Top);
        Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo(R.Left, R.Bottom);
        Canvas.LineTo(R.Right, R.Top);
        Inc(R.Left);
        Inc(R.Top);
        Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo(R.Left, R.Bottom);
        Canvas.LineTo(R.Right, R.Top);
        inc(i, 4);
        if i >= c then break;
      end;
      *)
    end;
  end;
end;

procedure TCustomElPanel.Loaded;
begin
  inherited;
  if OwnerDraw then Invalidate;
end;

procedure TCustomElPanel.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
var R : TRect;
begin
  if IsThemeApplied then
  begin
    if not TransparentXPThemes then
    begin
      Canvas.Handle := Msg.DC;
      Canvas.Brush.Color := Color;
      Canvas.FillRect(ClientRect);
      Canvas.Handle := 0;
    end
    else
    begin
      R := ClientRect;
      DrawThemeParentBackground(Handle, Msg.DC, R);
    end;
    //InflateRect(R, 2, 2);
    //DrawThemeBackground(Theme, Msg.DC, 0, 0, R, nil);
  end;
  Msg.Result := 1;
end;

procedure TCustomElPanel.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElPanel.ImageChange(Sender : TObject);
begin
  if ((FBackground.Height = 0) or (FBackground.Width = 0)) then
    BackgroundType := bgtColorFill
  else
  begin
    if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then RedoTmpBmp;
    Invalidate;
  end;
end;

procedure TCustomElPanel.SetResizable(newValue : Boolean);
begin
  if (FResizable <> newValue) then
  begin
    FResizable := newValue;
    if SizeGrip then
      Invalidate;
  end; {if}
end; {SetResizable}

function TCustomElPanel.InGrabHandle(X, Y : integer; Rect : TRect) : TElPanelGrabHandle;
var aHandle : TElPanelGrabHandle;
    R : TRect;
begin
  aHandle := LeftGrabHandle;
  if aHandle.Enabled then
  begin
    R := Rect;
    R.Right := R.Left + aHandle.Size;
    if PtInRect(R, Point(X, Y)) then
    begin
      result := aHandle;
      exit;
    end;
  end;

  aHandle := RightGrabHandle;
  if aHandle.Enabled then
  begin
    R := Rect;
    R.Left := R.Right - aHandle.Size;
    if PtInRect(R, Point(X, Y)) then
    begin
      result := aHandle;
      exit;
    end;
  end;

  aHandle := TopGrabHandle;
  if aHandle.Enabled then
  begin
    R := Rect;
    R.Bottom := R.Top + aHandle.Size;
    if PtInRect(R, Point(X, Y)) then
    begin
      result := aHandle;
      exit;
    end;
  end;

  aHandle := BottomGrabHandle;
  if aHandle.Enabled then
  begin
    R := Rect;
    R.Top := R.Bottom - aHandle.Size;
    if PtInRect(R, Point(X, Y)) then
    begin
      result := aHandle;
      exit;
    end;
  end;
  result := nil;
end;

procedure TCustomElPanel.WMNCHitTest(var Msg : TMessage);
var
  R : TRect;
  P : TPoint;
  bv: integer;
  aHandle : TElPanelGrabHandle;

begin
  inherited;
  if BevelInner <> bvNone then bv := BevelWidth else bv := 0;
  if BevelOuter <> bvNone then bv := bv + BevelWidth;
  bv := bv + BorderWidth;

  if bv = 0 then bv := 1;
  with Msg do
  begin
    P.x := Loword(lParam);
    P.y := Hiword(lParam);
    P := ScreenToClient(P);
    R := BoundsRect;
    OffsetRect(R, -R.Left, -R.Top);
  end;
  if FResizable and not (csDesigning in Componentstate) then
  with Msg do
  begin
    Result := HitTest(R, P, R.Bottom div 8, BevelWidth);
    if (Result = HTCLIENT) and SizeGrip then
    begin
      if PtInRect(SizeGripRect, P) then
        result := HTBOTTOMRIGHT;
    end;
  end
  else
  begin
    InflateRect(R, - bv, -bv);
    AHandle := InGrabHandle(P.X, P.Y, R);
    if AHandle <> nil then
    begin
      if (AHandle.Kind = ghkMove) and not (csDesigning in ComponentState) then
      begin
        Msg.result := HTCaption;
        BringToFront;
        exit;
      end;
      if (AHandle.Kind = ghkResize) and not (csDesigning in ComponentState) then
      begin
        if AHandle = TopGrabHandle then Msg.result := HTTOP else
        if AHandle = bottomGrabHandle then Msg.result := HTBOTTOM else
        if AHandle = LeftGrabHandle then Msg.result := HTLEFT else
        if AHandle = RightGrabHandle then Msg.result := HTRIGHT;
      end;
    end;
  end;
end; {WMNCHitTest}

procedure TCustomElPanel.SetMovable(newValue : Boolean);
begin
  if (FMovable <> newValue) then
  begin
    FMovable := newValue;
  end; {if}
end;

procedure TCustomElPanel.WMMove(var Msg : TWMMove);
begin
  inherited;
  Invalidate;
  //TriggerMoveEvent;
end; { WMMove }

procedure TCustomElPanel.TriggerMoveEvent;
begin
  if (assigned(FOnMove)) then FOnMove(Self);
end; { TriggerMoveEvent }

procedure TCustomElPanel.SetTransparent(newValue : Boolean);
{ Sets data member FTransparent to newValue. }
begin
  if (FTransparent <> newValue) then
  begin
    FTransparent := newValue;
    if FTransparent then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    RecreateWnd;
  end; { if }
end; { SetTransparent }

procedure TCustomElPanel.SetCaption(newValue: TElFString);
{ Sets data member FCaption to newValue. }
begin
  FCaption := newValue;
  inherited Caption := newValue;
end; { SetCaption }

procedure TCustomElPanel.RedoTmpBmp;
var BgRect,
    BgRect2 : TRect;
begin
  if BackgroundType in [bgtHorzGradient, bgtVertGradient, bgtColorFill, bgtCenterBitmap] then
  begin
    FTmpBmp.FreeImage;
  end else
  begin
    if (ClientWidth <> 0) and (ClientHeight <> 0) then
    begin
      BgRect := GetBackgroundClientRect;
      BgRect2 := BgRect;

      FTmpBmp.Height := BgRect.Bottom - BgRect.Top - 1;
      FTmpBmp.Width := BgRect.Right - BgRect.Left - 1;
      OffsetRect(BgRect2, BgRect2.Left, BgRect2.Top);
      ElExtBkgnd.ExtDrawBkgnd(FTmpBmp.Canvas.Handle, BgRect, BgRect, BgRect, BgRect2, false, Color, Color,  Background, BackgroundType);
    end;
  end;
end;

procedure TCustomElPanel.WMEnterSizeMove(var Msg : TMessage);
begin
  GetWindowRect(Handle, FSizeMoveRect);
  inherited;
end;

procedure TCustomElPanel.WMExitSizeMove(var Msg : TMessage);
var i,
    j : integer;
    R : TRect;
begin
  inherited;
  GetWindowRect(Handle, R);
  if (((R.Right - R.Left) = (FSizeMoveRect.Right - FSizeMoveRect.Left)) and
     ((R.Bottom - R.Top) = (FSizeMoveRect.Bottom - FSizeMoveRect.Top))) or
     ((FSizeMoveRect.Left <> R.Left) or (FSizeMoveRect.Top <> R.Top)) then
  begin
    if Assigned(FOnMove) then FOnMove(Self);
  end;
  Parent.Realign;
  j := ControlCount - 1;
  for i := 0 to j do
      Controls[i].Invalidate;
end;

procedure TCustomElPanel.WMSize(var Msg : TWMSize);  { private }
begin
  if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then RedoTmpBmp;
  Invalidate;
  inherited;
end;  { WMSize }

procedure TCustomElPanel.SetGradientStartColor(newValue : TColor);
{ Sets data member FGradientStartColor to newValue. }
begin
  if (FGradientStartColor <> newValue) then
  begin
    FGradientStartColor := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then Invalidate;
  end;  { if }
end;  { SetGradientStartColor }

procedure TCustomElPanel.SetGradientEndColor(newValue : TColor);
{ Sets data member FGradientEndColor to newValue. }
begin
  if (FGradientEndColor <> newValue) then
  begin
    FGradientEndColor := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then Invalidate;
  end;  { if }
end;  { SetGradientEndColor }

procedure TCustomElPanel.SetGradientSteps(newValue : Integer);
{ Sets data member FGradientSteps to newValue. }
begin
  if (FGradientSteps <> newValue) and (newValue > 0) then
  begin
    FGradientSteps := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then Invalidate;
  end;  { if }
end;  { SetGradientSteps }

procedure TCustomElPanel.SetLayout(newValue : TTextLayout);
{ Sets data member FLayout to newValue. }
begin
  if (FLayout <> newValue) then
  begin
    FLayout := newValue;
    if inherited Caption <> '' then Invalidate;
  end;  { if }
end;  { SetLayout }

procedure TCustomElPanel.TriggerPaintEvent;
begin
  if (assigned(FOnPaint)) then FOnPaint(Self);
end;  { TriggerPaintEvent }

procedure TCustomElPanel.SetOwnerDraw(newValue : Boolean);
{ Sets data member FOwnerDraw to newValue. }
begin
  if (FOwnerDraw <> newValue) then
  begin
    FOwnerDraw := newValue;
    if (not (csDesigning in ComponentState)) and (not (csLoading in ComponentState)) then Invalidate;
  end;  { if }
end;  { SetOwnerDraw }

function TCustomElPanel.GetTopGrabHandle : TElPanelGrabHandle;
{ Returns the value of data member FTopGrabHandle. }
begin
  result := FGrabHandles[2];
end;  { GetTopGrabHandle }

procedure TCustomElPanel.SetTopGrabHandle(newValue : TElPanelGrabHandle);
{ Sets data member FTopGrabHandle to newValue. }
begin
  FGrabHandles[2].Assign(newValue);
end;  { SetTopGrabHandle }

function TCustomElPanel.GetRightGrabHandle : TElPanelGrabHandle;
{ Returns the value of data member FRightGrabHandle. }
begin
  result := FGrabHandles[3];
end;  { GetRightGrabHandle }

procedure TCustomElPanel.SetRightGrabHandle(newValue : TElPanelGrabHandle);
{ Sets data member FRightGrabHandle to newValue. }
begin
  FGrabHandles[3].Assign(newValue);
end;  { SetRightGrabHandle }

function TCustomElPanel.GetLeftGrabHandle : TElPanelGrabHandle;
{ Returns the value of data member FLeftGrabHandle. }
begin
  result := FGrabHandles[1];
end;  { GetLeftGrabHandle }

procedure TCustomElPanel.SetLeftGrabHandle(newValue : TElPanelGrabHandle);
{ Sets data member FLeftGrabHandle to newValue. }
begin
  FGrabHandles[1].Assign(newValue);
end;  { SetLeftGrabHandle }

function TCustomElPanel.GetBottomGrabHandle : TElPanelGrabHandle;
{ Returns the value of data member FBottomGrabHandle. }
begin
  result := FGrabHandles[4];
end;  { GetBottomGrabHandle }

procedure TCustomElPanel.SetBottomGrabHandle(newValue : TElPanelGrabHandle);
{ Sets data member FBottomGrabHandle to newValue. }
begin
  FGrabHandles[4].Assign(newValue);
end;  { SetBottomGrabHandle }

procedure TCustomElPanel.SetAlwaysPaintBackground(Value : boolean);
begin
  if (Value <> FAlwaysPaintBackground) then
  begin
    FAlwaysPaintBackground := Value;
    if FOwnerDraw then Invalidate;
  end;
end;

procedure TCustomElPanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  {$IFNDEF VCL_4_USED}
  AdjustClientRect(Rect);
  {$ENDIF}
  inherited;
end;

procedure TCustomElPanel.AdjustClientRect(var Rect : TRect);
begin
  inherited;
  if LeftGrabHandle.Visible and LeftGrabHandle.Enabled then
  begin
    Inc(Rect.Left, LeftGrabHandle.FSize);
  end;
  if TopGrabHandle.Visible and TopGrabHandle.Enabled then
  begin
    Inc(Rect.Top, TopGrabHandle.FSize);
  end;
  if RightGrabHandle.Visible and RightGrabHandle.Enabled then
  begin
    Dec(Rect.Right, RightGrabHandle.FSize);
  end;
  if BottomGrabHandle.Visible and BottomGrabHandle.Enabled then
  begin
    Dec(Rect.Bottom, BottomGrabHandle.FSize);
  end;
end;

destructor TCustomElPanel.Destroy;
var i : integer;
begin
  {$ifdef ELPACK_USE_IMAGEFORM}
  ImageForm := nil;
  FImgFormChLink.Free;
  {$endif}
{$ifdef ELPACK_USE_STYLEMANAGER}
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
{$ENDIF}
  FBackground.Free;
  FTmpBmp.Free;
  for i := 1 to 4 do FGrabHandles[i].Free;
  inherited Destroy;
end; {Destroy}

constructor TCustomElPanel.Create(AOwner : TComponent);
var i : integer;
begin
  inherited Create(AOwner);
  FUseXPThemes := True;
  FTransparentXPThemes := true;
  {$ifdef ELPACK_USE_IMAGEFORM}
  FImgFormChLink  := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  {$endif}
{$IFDEF ELPACK_USE_STYLEMANAGER}
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
{$ENDIF}
  for i := 1 to 4 do
  begin
    FGrabHandles[i] := TElPanelGrabHandle.Create;
    FGrabHandles[i].FOwner := Self;
  end;
  ControlStyle := ControlStyle + [csOpaque];

  FBackground := TBitmap.Create;
  FBackground.OnChange := ImageChange;
  FBackgroundType := bgtColorFill;
  FGradientSteps := 16;
  FTmpBmp := TBitmap.Create;
  FullRepaint := false;
  FLayout := tlCenter;
  BevelOuter := bvRaised;
  BevelWidth := 1;
  FBevelSpaceColor := clBtnFace;
end; {Create}

procedure TCustomElPanel.DoMouseEnter;
begin
  FMouseInControl := true;
  if assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TCustomElPanel.DoMouseLeave;
begin
  FMouseInControl := false;
  if assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

function TCustomElPanel.GetCaption: TElFString;
begin
  Result := FCaption;
end;

procedure TCustomElPanel.SetAlphaLevel(Value: Byte);
begin
  if FAlphaLevel <> Value then
  begin
    FAlphaLevel := Value;
    if Transparent then
      Invalidate;
  end;
end;


procedure TCustomElPanel.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  DoMouseEnter;
end;

procedure TCustomElPanel.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if (Message.LParam = 0) or (Message.LParam = Integer(Self)) then
    DoMouseLeave;
end;

procedure TCustomElPanel.PaintWindow(DC: HDC);
var
  MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  R : TRect;
  ARgn : HRGN;
begin
  MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
  MemDC := CreateCompatibleDC(DC);
  OldBitmap := SelectObject(MemDC, MemBitmap);
  try
    GetClipBox(DC, R);
    with R do
      ARgn := CreateRectRgn(Left, Top, right, Bottom);
    SelectClipRgn(MemDC, ARgn);
    //InvalidateRect(MemDC, @R, false);
    Perform(WM_ERASEBKGND, MemDC, MemDC);
    Canvas.Lock;
    try
      Canvas.Handle := MemDC;
      try
        {$ifdef VCL_4_USED}
        TControlCanvas(Canvas).UpdateTextFlags;
        {$endif}
        Paint;
      finally
        Canvas.Handle := 0;
      end;
    finally
      Canvas.Unlock;
    end;

    SelectClipRgn(MemDC, 0);
    //SelectClipRgn(DC, ARgn);
    with R do
      BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
    if ARgn <> 0 then
      DeleteObject(ARgn);
  finally
    SelectObject(MemDC, OldBitmap);
    DeleteDC(MemDC);
    DeleteObject(MemBitmap);
  end;
end;

procedure TCustomElPanel.WMPaint(var Msg : TWMPaint);
(*
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R : TRect;
  ARgn : HRGN;
  i,
  SaveIndex : integer;
  Clip      : integer;
  DoPaint   : boolean;
*)
  (*
  type TRectArray = array[0..65535] of TRect;

  procedure ReportRgn(ARgn : HRGN);
  var RgnData  : PRgnData;
      Rects    : ^TRectArray;
      RgnCount,
      i        : integer;
  begin
    RgnCount := GetRegionData(ARgn, 0, nil);
    GetMem(RgnData, RgnCount);
    GetRegionData(ARgn, RgnCount, RgnData);
    SendDebug('Region begin');
    Rects := @RgnData^.Buffer;
    for i := 0 to RgnData^.rdh.nCount - 1 do
    begin
      with Rects[i] do
      SendDebug(Format('Rectange %d: ((%d, %d), (%d, %d))', [i, Left, Top, Right, Bottom]));
    end;
    SendDebug('Region end');
  end; *)

begin
  inherited;
  exit;
  // PaintHandler(Msg);
  (*
  exit;

  if (Msg.DC <> 0) or Transparent then
    PaintHandler(Msg)
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      DoPaint := true;

      SaveIndex := SaveDC(DC);

      // check whether we have anything to paint
      if ControlCount <> 0 then
      begin
        Clip := SimpleRegion;
        for I := 0 to ControlCount - 1 do
          with TControl(Controls[I]) do
            if (Visible or (csDesigning in ComponentState) and
              not (csNoDesignVisible in ControlStyle)) and
              (csOpaque in ControlStyle) then
            begin
              Clip := ExcludeClipRect(DC, Left, Top, Left + Width, Top + Height);
              if Clip = NullRegion then
              begin
                DoPaint := false;
                break;
              end;
            end;

        if DoPaint then
        begin
          GetClipBox(DC, R);
          with R do
            ARgn := CreateRectRgn(Left, Top, right, Bottom);
          if Clip = ComplexRegion then
          begin
            GetClipRgn(DC, ARgn);
            ReportRgn(ARgn);
          end;
        end
        else
          ARgn := 0;
        RestoreDC(DC, SaveIndex);
      end
      else
      begin
        GetClipBox(DC, R);
        if IsRectEmpty(R) then
          R := ClientRect
        else
        begin
          if not EqualRect(R, ClientRect) then
            InflateRect(R, 1, 1);
        end;

        with R do
          ARgn := CreateRectRgn(Left, Top, right, Bottom);
      end;


      // do actual painting
      if DoPaint then
      begin
        SelectClipRgn(MemDC, ARgn);
        //InvalidateRect(MemDC, @R, false);
        Perform(WM_ERASEBKGND, MemDC, MemDC);
        Msg.DC := MemDC;
        WMPaint(Msg);
        SelectClipRgn(MemDC, 0);
        Msg.DC := 0;
        //SelectClipRgn(DC, ARgn);
        with R do
          BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
      end;
      if ARgn <> 0 then
        DeleteObject(ARgn);

      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
  *)
end;  { WMPaint }

{
procedure TCustomElPanel.WMPaint(var Msg : TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R : TRect;
  ARgn : HRGN;
  (*
  i,
  SaveIndex : integer;
  Clip      : integer;
  *)
  DoPaint   : boolean;

begin
  (*inherited;
  exit;
  *)
  if (Msg.DC <> 0) or Transparent then
    PaintHandler(Msg)
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      DoPaint := true;

      (*
      SaveIndex := SaveDC(DC);

      // check whether we have anything to paint
      if ControlCount <> 0 then
      begin
        Clip := SimpleRegion;
        for I := 0 to ControlCount - 1 do
          with TControl(Controls[I]) do
            if (Visible or (csDesigning in ComponentState) and
              not (csNoDesignVisible in ControlStyle)) and
              (csOpaque in ControlStyle) then
            begin
              Clip := ExcludeClipRect(DC, Left, Top, Left + Width, Top + Height);
              if Clip = NullRegion then
              begin
                DoPaint := false;
                break;
              end;
            end;

        //
        if DoPaint then
        begin
          Clip := GetClipBox(DC, R);
          with R do
            ARgn := CreateRectRgn(Left, Top, right, Bottom);
          if Clip = ComplexRegion then
          GetClipRgn(DC, ARgn);
        end
        else
          ARgn := 0;
        RestoreDC(DC, SaveIndex);
      end
      else
      *)
      begin
        GetClipBox(DC, R);
        if IsRectEmpty(R) then
          R := ClientRect
        else
        begin
          if not EqualRect(R, ClientRect) then
            InflateRect(R, 1, 1);
        end;

        with R do
          ARgn := CreateRectRgn(Left, Top, right, Bottom);
      end;


      // do actual painting
      if DoPaint then
      begin
        SelectClipRgn(MemDC, ARgn);
        //InvalidateRect(MemDC, @R, false);
        Perform(WM_ERASEBKGND, MemDC, MemDC);
        Msg.DC := MemDC;
        WMPaint(Msg);
        SelectClipRgn(MemDC, 0);
        Msg.DC := 0;
        //SelectClipRgn(DC, ARgn);
        with R do
          BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
      end;
      if ARgn <> 0 then
        DeleteObject(ARgn);

      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;  { WMPaint }


{$ifdef ELPACK_USE_IMAGEFORM}
procedure TCustomElPanel.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;
{$endif}

{$ifdef ELPACK_USE_IMAGEFORM}
procedure TCustomElPanel.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if Assigned(ImageForm) then
    Perform(IFM_REPAINTCHILDREN, 0, 0);
end;
{$endif}

procedure TCustomElPanel.CreateWnd;
begin
  inherited;
  if UseXPThemes then
  begin
    CreateThemeHandle;
  end;
end;

procedure TCustomElPanel.DestroyWnd;
begin
  inherited;
  if UseXPThemes then
  begin
    FreeThemeHandle;
  end;
end;

procedure TCustomElPanel.WMIsThemedControl(var Message: TMessage);
begin
  Message.Result := Theme;
end;

procedure TCustomElPanel.ELThemeChanged(var Message: TMessage);
begin
  if ThemesAvailable and UseXPThemes then
  begin
    FreeThemeHandle;
    CreateThemeHandle;
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
    Invalidate;
  end;
  Message.Result := 1;
end;

procedure TCustomElPanel.DrawThemedBackground;
begin
  (*
  if not FTransparentXPThemes then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ClientRect);
  end;
  *)
end;


procedure TCustomElPanel.CreateThemeHandle;
begin
  if ThemesAvailable then
    FTheme := OpenThemeData(Handle, PWideChar(GetThemedClassName()))
  else
    FTheme := 0;
end;

procedure TCustomElPanel.FreeThemeHandle;
begin
  {$ifdef MSWINDOWS}
  if ThemesAvailable then
    CloseThemeData(FTheme);
  {$endif}
  FTheme := 0;
end;

function TCustomElPanel.GetThemedClassName: WideString;
begin
  Result := 'GLOBALS';
end;

function TCustomElPanel.IsThemeApplied: Boolean;
begin
  Result := UseXPThemes and (FTheme <> 0);
end;

procedure TCustomElPanel.SetUseXPThemes(const Value: Boolean);
begin
  if FUseXPThemes <> Value then
  begin
    FUseXPThemes := Value;
    if ThemesAvailable and HandleAllocated then
    begin
      if FUseXPThemes then
      begin
        CreateThemeHandle;
      end
      else
      begin
        FreeThemeHandle;
      end;
      RecreateWnd;
    end;
  end;
end;

function TCustomElPanel.GetBackgroundClientRect: TRect;
begin
  Result := ClientRect;
end;

procedure TCustomElPanel.SetTransparentXPThemes(Value: Boolean);
begin
  if FTransparentXPThemes <> Value then
  begin
    FTransparentXPThemes := Value;
    Invalidate;
  end;
end;

procedure TCustomElPanel.SetSizeGrip(Value: Boolean);
begin
  if FSizeGrip <> Value then
  begin
    FSizeGrip := Value;
    Invalidate;
  end;
end;

procedure TCustomElPanel.SetBevelInner(Value: TPanelBevel);
begin
  FBevelInner := Value;
  inherited BevelInner := Value;
  UpdateInterior;
end;

procedure TCustomElPanel.SetBevelOuter(Value: TPanelBevel);
begin
  FBevelOuter := Value;
  inherited BevelOuter := Value;
  UpdateInterior;
end;

procedure TCustomElPanel.SetBevelWidth(Value: TBevelWidth);
begin
  FBevelWidth := Value;
  inherited BevelWidth := Value;
  UpdateInterior;
end;

procedure TCustomElPanel.UpdateInterior;
begin
  // intentionally left blank
end;

procedure TCustomElPanel.SetBevelSpaceColor(Value: TColor);
begin
  if FBevelSpaceColor <> Value then
  begin
    FBevelSpaceColor := Value;
    {$ifdef VCL_4_USED}
    if (BevelInner = bvSpace) or (BevelOuter = bvSpace) then
      Invalidate;
    {$endif}
  end;
end;

procedure TCustomElPanel.SetShowFocus(Value: Boolean);
begin
  if FShowFocus <> Value then
  begin
    FShowFocus := Value;
    if Handleallocated and
       (ComponentState * [csLoading, csreading, csDestroying] = []) and
       (GetFocus = Self.Handle)
      then
      Invalidate;
  end;
end;

procedure TCustomElPanel.WMSetFocus(var Message: TMessage);
begin
  inherited;
  if ShowFocus then
    Invalidate;
end;

procedure TCustomElPanel.WMKillFocus(var Message: TMessage);
begin
  inherited;
  if not HandleAllocated then exit;
  if ShowFocus then
    Invalidate;
end;

{$ifdef ELPACK_UNICODE}
procedure TCustomElPanel.CMHintShow(var Message: TMessage);
var T: WideChar;
  HintInfo : PHintInfo;
  l : integer;
  S : String;
  WS: WideString;
begin
  inherited;
  HintInfo := PHintInfo(Message.lParam);

  if Length(FHint) = 0 then
  begin
    HintInfo.hintStr := '';
    exit;
  end;

  S := GetShortHint(inherited Hint);
  if HintInfo.HintStr = S then
  begin
    WS := GetShortHintW(FHint);
  end
  else
  begin
    S := FHint;
    WS := FHint;
  end;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
end;

procedure TCustomElPanel.SetHint(Value: TElFString);
var S : String;
    i,
    l : integer;
    T : WideChar;
begin
  FHint := Value;

  S := FHint;
  i := Length(S);
  l := Length(S) + 1 + Length(FHint) * 2;
  SetLength(S, l + 4);
  S[i + 1] := #0;

  Move(FHint[1], S[i + 2], Length(FHint) * 2);
  T := #0;
  Move(T, S[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, S[l + 3], sizeof(T));
  inherited Hint := S;
end;

{$endif}

{$ifdef ELPACK_USE_STYLEMANAGER}
procedure TCustomElPanel.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    {$ifdef VCL_5_USED}
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    {$endif}
    if FStyleManager <> nil then
       FStyleManager.UnregisterChanges(FStyleMgrLink);
    FStyleManager := Value;
    if FStyleManager <> nil then
    begin
      FStyleManager.FreeNotification(Self);
      FStyleManager.RegisterChanges(FStyleMgrLink);
      UpdateStyle;
    end;
  end;
end;

procedure TCustomElPanel.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TCustomElPanel.StyleMgrChange(Sender : TObject);
begin
  UpdateStyle;
end;

procedure TCustomElPanel.UpdateStyle;
begin
  if FStyleManager <> nil then
  begin
    if HandleAllocated then
      SendMessage(Handle, WM_SETREDRAW, 0, 0);
    FStyleManager.ApplyStyle(Self, StyleName);
    if HandleAllocated then
    begin
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
      Invalidate;
    end;
  end;
end;

{$endif}

(*
procedure TCustomElPanel.DrawBackground(DC: HDC);
var
  R, R1: TRect;
  ACanvas: TCanvas;
begin
  R := GetClientRect;
  if BevelOuter <> bvNone then InflateRect(R, -BevelWidth, -BevelWidth);
  InflateRect(R, -BorderWidth, -BorderWidth);
  if BevelInner <> bvNone then InflateRect(R, -BevelWidth, -BevelWidth);
  if LeftGrabHandle.Visible and LeftGrabHandle.Enabled and (LeftGrabHandle.BevelKind <> bvNone) then
    Inc(R.Left, LeftGrabHandle.Size);
  if RightGrabHandle.Visible and RightGrabHandle.Enabled and (RightGrabHandle.BevelKind <> bvNone) then
    Dec(R.Right, RightGrabHandle.Size);
  if TopGrabHandle.Visible and TopGrabHandle.Enabled and (TopGrabHandle.BevelKind <> bvNone) then
    Inc(R.Top, TopGrabHandle.Size);
  if BottomGrabHandle.Visible and BottomGrabHandle.Enabled and (BottomGrabHandle.BevelKind <> bvNone) then
    Dec(R.Bottom, BottomGrabHandle.Size);
  ACanvas := TCanvas.Create;
  try
    ACanvas.Handle := DC;
    with ACanvas do
      case BackgroundType of
        bgtColorFill   : begin
                           Brush.Color := Color;
                           FillRect(R);
                         end;
        bgtHorzGradient,
        bgtVertGradient: GradientFill(Canvas.Handle, R, GradientStartColor, GradientEndColor,
                           GradientSteps, BackgroundType = bgtVertGradient);
        bgtStretchBitmap,
        bgtTileBitmap  : CopyRect(R, FTmpBmp.Canvas, Classes.Rect(0, 0,
                           FTmpBmp.Width, FTmpBmp.Height));
        bgtCenterBitmap: begin
                           Brush.Color := Color;
                           FillRect(R);
                           CenterRects(FBackground.Width, R.Right - R.Left,
                             FBackground.Height, R.Bottom - R.Top, R1);
                           OffsetRect(R1, R.Left, R.Top);
                           CopyRect(R1, FBackground.Canvas,
                             Classes.Rect(0, 0, FBackground.Width, FBackground.Height));
                         end;
      end;
  finally
    ACanvas.Handle := 0;
    ACanvas.Free;
  end;
end;
*)
end.
