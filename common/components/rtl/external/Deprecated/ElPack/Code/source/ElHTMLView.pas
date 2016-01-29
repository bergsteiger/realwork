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

{$UNDEF OLDELSCROLLBARS}
{$IFDEF MSWINDOWS}
  {.$DEFINE OLDELSCROLLBARS}  // OLD ELSCRIOLLBAR STYLES
{$ELSE}
  {$DEFINE OLDELSCROLLBARS}
{$ENDIF}

(*

Version History

07/06/2003

  BorderColor* properties added. They control the colors of the border, drawn when Flat is true.

04/04/2003

 Added property RightAlignedView

24/03/2003

 Replaced system scrollbars with ElScrollBars

03/06/2002

  Added unicode hint
  Added margins between control sides and text rectangle
  Improved vertical scrolling

10/16/2001

  When the view is disabled, scrollbars (only when UseCustomScrollbars is true)
  are shown as disabled in Windows XP with styles enabled.
  Borders were drawn in XP style even when BorderStyle = bsNone. Fixed.

09/26/2001

  Fixed LinkPopupMenu that didn't work
  Fixed calculation of non-client area for control_size < size_of_scrollbar
  with no real scrollbar cases (for exmaple, when control height is 15 and no
  scrollbars are visible, non-client area was calculated as if there was a
  scrollbar)

09/10/2001

  Fixed updating after control is resized and WordWrap is set to TRUE.

08/20/2001

  Caption property made published, void property Text removed from design-time
  property list

07/12/2001

  BorderSides property added.

11/29/2000

  Fixed the problem with horizontal scrollbar, when WordWrap is on.

11/24/2000

  Transparent property was not working. Fixed.

*)

unit ElHTMLView;  { TElHTMLView component. }

interface

uses
  Windows,
  SysUtils,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  Menus,
  StdCtrls,
  ExtCtrls,
  HTMLRender,
{$ifdef VCL_6_USED}
Types,
{$endif}
  ElSBCtrl,
  {$IFDEF OLDELSCROLLBARS}
  ElScrollBar,
  {$ENDIF}
  ElImgFrm,
  ElXPThemedControl,
  ElUxTheme,
  ElTmSchema,
  ElStrUtils,
  ElVCLUtils;

type

  { event handlers support }
  TElFString = ElStrUtils.TElFString;
{$ifdef VCL_4_USED}
  {$NODEFINE TElFString}
{$endif}

  TElHTMLView = class(TElXPThemedControl)
  {$IFNDEF OLDELSCROLLBARS}
  private
    {< ELSCROLLBAR}
    fSBCtrl :TElSBController;
  protected
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    property SBCtrl :TElSBController read fSBCtrl;
    {> ELSCROLLBAR}
  {$ENDIF}
  protected
    FFlatFocusedScrollBars : Boolean;
    FUseCustomScrollBars : Boolean;
    FLinkPopupMenu : TPopupMenu;
    FCursor : TCursor;
    FHighlightColor : TColor;
    FHighlightBkColor : TColor;
    FOnLinkClick : TElHTMLLinkClickEvent;
    FOnImageNeeded : TElHTMLImageNeededEvent;
    FLinkColor : TColor;
    FLinkStyle : TFontStyles;
    FImgForm : TElImageForm;
    FActiveBorderType : TElFlatBorderType;
    FInactiveBorderType : TElFlatBorderType;
    FFlat : Boolean;
    FWordWrap : Boolean;
    FMouseOver: Boolean;
    FBorderStyle: TBorderStyle;
    FRender : TElHTMLRender;
    TmpDC   : HDC;
    FGradientSteps : Integer;
    FGradientStartColor : TColor;
    FGradientEndColor : TColor;
    FTmpBmp : TBitmap;
    FTransparent : Boolean;
    FBackground : TBitmap;
    FBackgroundType : TElBkGndType;
    FImgFormChLink  : TImgFormChangeLink;

    FDummyString : string;
    FViewPos  : TPoint;
    FTextRect : TRect;
    FScrollStep : integer;
    {$IFDEF OLDELSCROLLBARS}
    FVertScrollBar,
    FHorzScrollBar  : TElScrollBar;
    FVertScrollBarStyles : TElScrollBarStyles;
    FHorzScrollBarStyles : TElScrollBarStyles;
    {$ENDIF}
    FVScrollVisible,
    FHScrollVisible : boolean;
    FBorderSides: TElBorderSides;
    {$ifdef ELPACK_UNICODE}
    FHint: TElFString;
    {$endif}
    FCaption: TElFString;
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FViewRect: TRect;
    FMargin: Integer;
    FRightAlignedView: Boolean;
    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorShadow: TColor;
    FBorderColorWindow: TColor;

    procedure SetRightAlignedView(Value: Boolean);
    procedure WMSysColorChange(var Msg: TMessage); message WM_SYSCOLORCHANGE;
    procedure CMFontChanged(var Msg : TMessage); message CM_FONTCHANGED;
    procedure CMSysColorChange(var Msg : TMessage); message CM_SYSCOLORCHANGE;
    procedure SBChanged(Sender: TObject);
    procedure CMMouseEnter(var Msg : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetImageForm(newValue : TElImageForm);
    procedure SetTransparent(newValue : boolean);
    procedure SetBackground(newValue : TBitmap);
    procedure SetBackgroundType(newValue : TElBkGndType);
    procedure ImageChange(Sender : TObject);
    procedure ImageFormChange(Sender : TObject);
    procedure SetGradientStartColor(newValue : TColor);
    procedure SetGradientEndColor(newValue : TColor);
    procedure SetGradientSteps(newValue : Integer);
    procedure RedoTmpBmp;
    procedure DrawFlatBorder(HorzTracking, VertTracking : boolean);
    procedure DrawFlatBorderEx(DC : HDC; HorzTracking, VertTracking : boolean);

    procedure OnHScroll(Sender: TObject; ScrollCode: TElScrollCode;
                        var ScrollPos: Integer; var DoChange : boolean);
    procedure OnVScroll(Sender: TObject; ScrollCode: TElScrollCode;
                        var ScrollPos: Integer; var DoChange : boolean);
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure CMTextChanged(var Msg : TMessage); message CM_TEXTCHANGED;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMPaint(var Msg : TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Msg : TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure SetLinkPopupMenu(newValue : TPopupMenu);
    procedure WMNCPaint(var Msg : TMessage); message WM_NCPAINT;
    procedure WMNCCalcSize(var Message : TWMNcCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Msg : TMessage); message WM_NCHITTEST;
    procedure WMVScroll(var Msg : TWMVScroll); message WM_VSCROLL;
    procedure WMHScroll(var Msg : TWMHScroll); message WM_HSCROLL;

    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;

    {$IFDEF VCL_4_USED}
    procedure CMMouseWheel(var Msg : TCMMouseWheel); message CM_MOUSEWHEEL;
    {$ENDIF}
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure SetBorderSides(Value: TElBorderSides);
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    {$ifdef VCL_5_USED}
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    {$endif}

    {$IFDEF OLDELSCROLLBARS}
    procedure SetVertScrollBarStyles(newValue : TElScrollBarStyles); virtual;
    procedure SetHorzScrollBarStyles(newValue : TElScrollBarStyles); virtual;
    {$ELSE}
    {< ELSCROLLBAR}
    function GetHorzScrollBar:TElCtrlScrollBarStyles; virtual;
    function GetVertScrollBar:TElCtrlScrollBarStyles; virtual;
    procedure SetHorzScrollBar(const Value:TElCtrlScrollBarStyles); virtual;
    procedure SetVertScrollBar(const Value:TElCtrlScrollBarStyles); virtual;
    {> ELSCROLLBAR}
    {$ENDIF}
    procedure PrepareText; virtual;
    procedure SetViewPos(newValue : TPoint); virtual;
    procedure SetWordWrap(newValue : Boolean); virtual;
    procedure AdjustScrollBars;
    procedure Paint; override;
    procedure UpdateFrame;
    procedure SetActiveBorderType(newValue : TElFlatBorderType); virtual;
    procedure SetInactiveBorderType(newValue : TElFlatBorderType); virtual;
    procedure SetFlat(newValue : Boolean); virtual;
    procedure Notification(AComponent : TComponent; operation : TOperation); override;
    procedure CreateParams(var Params : TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;
    procedure SetHighlightColor(newValue : TColor); virtual;
    procedure SetHighlightBkColor(newValue : TColor); virtual;
    procedure TriggerLinkClickEvent(HRef : string); virtual;
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TElFString; var Image
        : TBitmap); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure SetCursor(newValue : TCursor); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SetUseCustomScrollBars(newValue : Boolean); virtual;
    procedure SetFlatFocusedScrollBars(newValue : Boolean); virtual;
    procedure Loaded; override;
    procedure SetCaption(newValue: TElFString); virtual;
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;
    procedure SetUseXPThemes(const Value: Boolean); override;
    function GetThemedClassName: WideString; override;
    procedure DoLinkPopup(MousePos : TPoint);
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    procedure SetViewRect(Value: TRect);
    procedure SetMargin(Value: Integer);
    {$ifdef ELPACK_UNICODE}
    procedure SetHint(Value: TElFString);

    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    {$endif}
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);

    property ViewRect: TRect read FViewRect write SetViewRect;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Click; override;

    property VertScrollBarVisible : boolean read FVScrollVisible;
    property HorzScrollBarVisible : boolean read FHScrollVisible;
    property Position : TPoint read FViewPos write SetViewPos;
  published
    {$ifdef ELPACK_UNICODE}
    property Hint: TElFString read FHint write SetHint;
    {$endif}
    property Caption: TElFString read FCaption write SetCaption;
    {$IFDEF OLDELSCROLLBARS}
    property VertScrollBarStyles : TElScrollBarStyles read FVertScrollBarStyles
      write SetVertScrollBarStyles;
    property HorzScrollBarStyles : TElScrollBarStyles read FHorzScrollBarStyles
      write SetHorzScrollBarStyles;
    {$ELSE}
    {< ELSCROLLBAR}
    property HorzScrollBarStyles: TElCtrlScrollBarStyles read GetHorzScrollBar
      write SetHorzScrollBar;
    property VertScrollBarStyles: TElCtrlScrollBarStyles read GetVertScrollBar
      write SetVertScrollBar;
    {> ELSCROLLBAR}
    {$ENDIF}
    property RightAlignedView: Boolean read FRightAlignedView write SetRightAlignedView
      default false;
    property WordWrap   : Boolean read FWordWrap write SetWordWrap;
    property Transparent : Boolean read FTransparent write SetTransparent; { Protected }
    property BorderSides: TElBorderSides read FBorderSides write SetBorderSides default [ebsLeft, ebsRight, ebsTop, ebsBottom];
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property BorderColorDkShadow: TColor read FBorderColorDkShadow write 
        SetBorderColorDkShadow default cl3DDkShadow;
    property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace 
        default clBtnFace;
    property BorderColorHighlight: TColor read FBorderColorHighlight write 
        SetBorderColorHighlight default clBtnHighlight;
    property BorderColorShadow: TColor read FBorderColorShadow write 
        SetBorderColorShadow default clBtnShadow;

    property ActiveBorderType : TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;
    property InactiveBorderType : TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;
    property Flat : Boolean read FFlat write SetFlat;
    property ImageForm : TElImageForm read FImgForm write SetImageForm;
    property GradientStartColor : TColor read FGradientStartColor write SetGradientStartColor;  { Protected }
    property GradientEndColor : TColor read FGradientEndColor write SetGradientEndColor;  { Protected }
    property GradientSteps : Integer read FGradientSteps write SetGradientSteps default 16;  { Protected }
    property Background : TBitmap read FBackground write SetBackground;
    property BackgroundType : TElBkGndType read FBackgroundType write SetBackgroundType default bgtColorFill;
    property Cursor : TCursor read FCursor write SetCursor;  { Published }
    property LinkColor : TColor read FLinkColor write SetLinkColor default clBlue;  { Published }
    property LinkStyle : TFontStyles read FLinkStyle write SetLinkStyle default [fsUnderline];  { Published }
    property LinkPopupMenu : TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property HighlightColor : TColor read FHighlightColor write SetHighlightColor default clHighlightText;  { Published }
    property HighlightBkColor : TColor read FHighlightBkColor write SetHighlightBkColor default clHighlight;  { Published }
    property OnLinkClick : TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnImageNeeded : TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property UseCustomScrollBars : Boolean read FUseCustomScrollBars write SetUseCustomScrollBars default true;  { Published }
    property FlatFocusedScrollBars : Boolean read FFlatFocusedScrollBars write SetFlatFocusedScrollBars default False;  { Published }
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor default clBlack;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor default clBlack;
    property Text : string read FDummyString;
    property Margin: Integer read FMargin write SetMargin default 4;

{$IFDEF VCL_4_USED}
    property Anchors;
{$ENDIF}
    property Color;
{$IFDEF VCL_4_USED}
    property Constraints;
{$ENDIF}
    property Ctl3D;
    property DragCursor;
{$IFDEF VCL_4_USED}
    property DragKind;
{$ENDIF}
    property Align;
    property DragMode;
    property Enabled;
    property Font;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property UseXPThemes;

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
{$IFDEF VCL_4_USED}
    property OnStartDock;
    property OnEndDock;
{$ENDIF}
{$IFDEF VCL_5_USED}
    property OnContextPopup;
    property BorderColorWindow: TColor read FBorderColorWindow write 
        SetBorderColorWindow default clWindow;
{$ENDIF}
  end;  { TElHTMLView }

implementation

uses ElTools, ElExtBkgnd, ElHandPt;

procedure TElHTMLView.OnHScroll(Sender: TObject; ScrollCode: TElScrollCode;
                                var ScrollPos: Integer; var DoChange : boolean);
begin
  //if ScrollCode <> escTrack then
  begin
    if (FViewPos.X <> ScrollPos) then
    begin
      FViewPos.X := ScrollPos;
      DoChange := true;
      AdjustScrollBars;
      {.$IFDEF OLDELSCROLLBARS}//???:
      InvalidateRect(Handle, @FViewRect, true);
      DrawFlatBorder(false, false);
      {.$ENDIF}
    end;
  end;
end;

procedure TElHTMLView.OnVScroll(Sender: TObject; ScrollCode: TElScrollCode;
                                var ScrollPos: Integer; var DoChange : boolean);
{
var xoffs,
    yoffs : integer;
    R     : TRect;
}
begin
  //if ScrollCode <> escTrack then
  begin
    if (FViewPos.Y <> ScrollPos) then
    begin
      //yoffs := FViewPos.Y - ScrollPos;
      //ScrollWindowEx(Handle, 0, yoffs, @FViewRect, @FViewRect, 0, @R, SW_INVALIDATE);
      FViewPos.Y := ScrollPos;
      DoChange := true;
      AdjustScrollBars;
      InvalidateRect(Handle, @FViewRect, true);
      DrawFlatBorder(false, false);
    end;
  end;
end;

procedure TElHTMLView.SBChanged(Sender: TObject);
begin
  AdjustScrollBars;
  Invalidate;
  UpdateFrame;
end;

{$IFDEF OLDELSCROLLBARS}
procedure TElHTMLView.SetVertScrollBarStyles(newValue : TElScrollBarStyles);
begin
  FVertScrollBarStyles.Assign(newValue);
end;  { SetVertScrollBarStyles }

procedure TElHTMLView.SetHorzScrollBarStyles(newValue : TElScrollBarStyles);
begin
  FHorzScrollBarStyles.Assign(newValue);
end;  { SetHorzScrollBarStyles }
{$ELSE}

{< ELSCROLLBAR}
function TElHTMLView.GetHorzScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_HORZ]);
end;

function TElHTMLView.GetVertScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_VERT]);
end;

procedure TElHTMLView.SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_HORZ].Assign(Value);
end;

procedure TElHTMLView.SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_VERT].Assign(Value);
end;

procedure TElHTMLView.CreateWnd;
begin
  fSBCtrl.Control := nil;
  inherited;
  if fUseCustomScrollBars then
  begin
    fSBCtrl.Control := Self;
    if not fSBCtrl.Active then
    begin
      fUseCustomScrollBars := False;
      fSBCtrl.Control := nil;
    end;
  end;
end;

procedure TElHTMLView.DestroyWnd;
begin
  inherited;
  fSBCtrl.Control := nil;
end;

{> ELSCROLLBAR}

{$ENDIF IFDEF OLDELSCROLLBARS}

procedure TElHTMLView.SetViewPos(newValue : TPoint);
var R : TRect;
begin
  if (newValue.x <> FViewPos.x) or (newValue.y <> FViewPos.y) then
  begin
    FViewPos := newValue;
    AdjustScrollBars;
    R := FViewRect;
    if HandleAllocated then
       InvalidateRect(Handle, @R, false);
    //UpdateFrame;
  end;
end;

procedure TElHTMLView.PrepareText;
var ww : boolean;
begin
  FViewPos := Point(0, 0);
  FRender.Data.DefaultStyle := Font.Style;
  FRender.Data.DefaultFont  := Font.Name;
  FRender.Data.DefaultColor := Font.Color;
  FRender.Data.DefaultHeight:= Font.Height;
  FRender.Data.Charset      := Font.Charset;
  FRender.Data.LinkColor    := LinkColor;
  FRender.Data.LinkStyle    := LinkStyle;
  FRender.Data.HighlightColor := FHighlightColor;
  FRender.Data.HighlightBgColor := FHighlightBkColor;
  ww := WordWrap;
  if (csLoading in ComponentState) then
    ww := false;
  if HandleAllocated then
  begin
    FRender.PrepareText(Caption, FTextRect.Right - FTextRect.Left, ww);
    Invalidate;
  end;
end;

procedure TElHTMLView.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TElHTMLView.UpdateFrame;
var R : TRect;
begin
  if HandleAllocated then
  begin
    R := Rect(0, 0, Width, Height);
    if (BorderStyle = bsSingle) and (not (csDestroying in ComponentState)) and (HandleAllocated) then
       RedrawWindow( Handle, @R, 0, rdw_Invalidate or rdw_UpdateNow or rdw_Frame );
  end;
end;

procedure TElHTMLView.CMFontChanged(var Msg : TMessage);  { private }
begin
  inherited;
  FScrollStep := Abs(Font.Height) div 2;
  PrepareText;
  AdjustScrollBars;
  Invalidate;
  UpdateFrame;
end;  { CMFontChanged }

procedure TElHTMLView.CMSysColorChange(var Msg : TMessage);  { private }
begin
  inherited;
  Invalidate;
  UpdateFrame;
end;  { CMSysColorChange }

procedure TElHTMLView.SetWordWrap(newValue : Boolean);
{ Sets data member FWordWrap to newValue. }
begin
  if (FWordWrap <> newValue) then
  begin
    FWordWrap := newValue;
    AdjustScrollBars;
    PrepareText;
    AdjustScrollBars;
    Invalidate;
    UpdateFrame;
  end;  { if }
end;  { SetWordWrap }

procedure TElHTMLView.AdjustScrollBars;  { protected }
{$IFDEF OLDELSCROLLBARS}
var
    HScrollRect,
    VScrollRect : TRect;
{$ENDIF}
    function UpdateVScroll : boolean;
    var b : boolean;
        i : integer;
        ScrollInfo : TScrollInfo;
    begin
      if FHScrollVisible then
         i := HorzScrollBarStyles.Width
      else
         i := 0;
      {$IFDEF OLDELSCROLLBARS}
      FVertScrollBar.Max := FRender.Data.TextSize.cy;
      FVertScrollBar.Position := FViewPos.y;
      FVertScrollBar.Page := (ClientHeight - i);
      FVertScrollbar.Step := Abs(Font.Height);
      {$ELSE}
      if not UseCustomScrollbars then
      begin
        VertScrollBarStyles.Max := FRender.Data.TextSize.cy;
        VertScrollBarStyles.Position := FViewPos.y;
        VertScrollBarStyles.Page := (ClientHeight - i);
        VertScrollbarStyles.Step := Abs(Font.Height);
      end;
      {$ENDIF}

      ScrollInfo.cbSize := sizeof(ScrollInfo);
      ScrollInfo.fMask := SIF_ALL;
      ScrollInfo.nMin  := 0;
      ScrollInfo.nMax  := FRender.Data.TextSize.cy;
      ScrollInfo.nPage := (ClientHeight - i);
      ScrollInfo.nPos  := FViewPos.y;
      ScrollInfo.nTrackPos := FViewPos.y;

      {$IFDEF OLDELSCROLLBARS}
      if FUseCustomScrollBars then
         ScrollInfo.fMask := ScrollInfo.fMask + SIF_DISABLENOSCROLL;
      {$ENDIF}

      SetScrollInfo(Handle, SB_VERT, ScrollInfo,
        {$IFDEF OLDELSCROLLBARS}not FUseCustomScrollBars{$ELSE}True{$ENDIF});

      {$IFDEF OLDELSCROLLBARS}
      b := FVertScrollBar.Max > FVertScrollBar.Page;
      {$ELSE}
      b := VertScrollBarStyles.Max > VertScrollBarStyles.Page;
      {$ENDIF}
      Result := b <> FVScrollVisible;
      FVScrollVisible := b;
    end;

    function UpdateHScroll : boolean;
    var b : boolean;
        i : integer;
        ScrollInfo : TScrollInfo;
    begin
      if FVScrollVisible then
         i := VertScrollBarStyles.Width
      else
         i := 0;

      {$IFDEF OLDELSCROLLBARS}
      if WordWrap then
        FHorzScrollBar.Max := 0
      else
        FHorzScrollBar.Max := FRender.Data.TextSize.cx;
      FHorzScrollBar.Page := (ClientWidth - i) div 2;
      FHorzScrollBar.Position := FViewPos.x;
      {$ELSE}
      if not UseCustomScrollbars then
      begin
        if WordWrap then
          HorzScrollBarStyles.Max := 0
        else
          HorzScrollBarStyles.Max := FRender.Data.TextSize.cx;
        HorzScrollBarStyles.Page := (ClientWidth - i) div 2;
        HorzScrollBarStyles.Position := FViewPos.x;
      end;
      {$ENDIF}

      ScrollInfo.cbSize := sizeof(ScrollInfo);
      ScrollInfo.fMask := SIF_ALL;
      ScrollInfo.nMin  := 0;
      if WordWrap then
        ScrollInfo.nMax  := 0
      else
        ScrollInfo.nMax  := FRender.Data.TextSize.cx;
      ScrollInfo.nPage := (ClientWidth - i) div 2;
      ScrollInfo.nPos  := FViewPos.x;
      ScrollInfo.nTrackPos := FViewPos.x;

      {$IFDEF OLDELSCROLLBARS}
      if FUseCustomScrollBars then
         ScrollInfo.fMask := ScrollInfo.fMask + SIF_DISABLENOSCROLL;
      {$ENDIF}

      SetScrollInfo(Handle, SB_HORZ, ScrollInfo,
        {$IFDEF OLDELSCROLLBARS}not FUseCustomScrollBars{$ELSE}True{$ENDIF});
      {$IFDEF OLDELSCROLLBARS}
      b := FHorzScrollBar.Max > (ClientWidth - i);
      {$ELSE}
      b := HorzScrollBarStyles.Max > (ClientWidth - i);
      {$ENDIF}
      Result := b <> FHScrollVisible;
      FHScrollVisible := b;
    end;

{$IFDEF OLDELSCROLLBARS}
var b : boolean;
    FViewRect : TRect;
{$ENDIF}
begin
  if not HandleAllocated then
    exit;

  FHScrollVisible := (not WordWrap) and (ClientWidth < FRender.Data.TextSize.cx);
  //FVScrollVisible := FRender.Data.TextSize.cy > ClientHeight ;

  {$IFDEF OLDELSCROLLBARS}
  b := false;
  {$ENDIF}
  while UpdateHScroll or UpdateVSCroll do
  begin
    if WordWrap then
       PrepareText;
    {$IFDEF OLDELSCROLLBARS}
    b := true;
    {$ENDIF}
  end;

  {$IFDEF OLDELSCROLLBARS}
  if b and FUseCustomScrollBars then
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or
      SWP_NOACTIVATE or SWP_FRAMECHANGED);
  {$ENDIF}

  {$IFDEF OLDELSCROLLBARS}
  FViewRect := ClientRect;
  if FHScrollVisible and FUseCustomScrollBars then
  begin
    dec(FViewRect.Bottom, HorzScrollBarStyles.Width - 1);
    if FVScrollVisible then
    begin
      if (not RightAlignedView) then
        HScrollRect := Rect(0, ClientHeight - HorzScrollBarStyles.Width, ClientWidth - FVertScrollBarStyles.Width, HorzScrollBarStyles.Width)
      else
        HScrollRect := Rect(FVertScrollBarStyles.Width +1, ClientHeight - HorzScrollBarStyles.Width, ClientWidth - FVertScrollBarStyles.Width, HorzScrollBarStyles.Width)
    end
    else
      HScrollRect := Rect(0, ClientHeight - HorzScrollBarStyles.Width, ClientWidth, HorzScrollBarStyles.Width);
    with HScrollRect do
      FHorzScrollBar.SetBounds(Left, Top, Right, Bottom);
    FHorzScrollBar.Visible := true;
  end
    else FHorzScrollBar.Visible := false;

  if FVScrollVisible and FUseCustomScrollBars then
  begin
    if (not RightAlignedView) then
      dec(FViewRect.Right, FVertScrollBarStyles.Width - 1)
    else
      inc(FViewRect.Left,FVertScrollBarStyles.Width - 1);

    if FHScrollVisible then
    begin
      if (not RightAlignedView) then
        VScrollRect := Rect(
          ClientWidth - FVertScrollBarStyles.Width,
          0,
          FVertScrollBarStyles.Width,
          ClientHeight - FHorzScrollBarStyles.Width)
      else
        VScrollRect := Rect(
          FViewRect.Left - FVertScrollBarStyles.Width + 1,
          0,
          FVertScrollBarStyles.Width,
          ClientHeight - FHorzScrollBarStyles.Width)
    end
    else
      VScrollRect := Rect(ClientWidth - FVertScrollBarStyles.Width, 0, FVertScrollBarStyles.Width, ClientHeight);
    with VScrollRect do
      FVertScrollBar.SetBounds(Left,Top, Right, Bottom);
    FVertScrollBar.Visible := true;
  end
    else FVertScrollBar.Visible := false;
  ViewRect := FViewRect;
  {$ELSE}
  ViewRect := ClientRect;
  {$ENDIF}
end;  { AdjustScrollBars }

procedure TElHTMLView.Paint;  { protected }
var R, Rect,
    R1     : TRect;
    ACtl   : TWinControl;
    //ax, ay : integer;
    P      : TPoint;
    BgRect : TRect;

begin
  if Flat then
    DrawFlatBorder(false, false);

  R := ClientRect;

  if not Transparent then
  begin
    if (FImgForm <> nil) and (not (csDesigning in FImgForm.ComponentState)) then
    begin
      if (FImgForm.Control <> Self) then
      begin
        ACtl := FImgForm.GetRealControl;
        BgRect := R;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        P := Parent.ClientToScreen(Point(Left, Top));
        {ax := BgRect.Left - P.x;
        ay := BgRect.Top - P.y;
        }
        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

        FImgForm.PaintBkgnd(Canvas.Handle, R, BgRect.TopLeft, false);
      end;
      //FImgForm.PaintBkgnd(Canvas.Handle, R, Point(BgRect.Left - ax, BgRect.Top - ay), false);
    end
    else
    begin
      with Canvas do
      case BackgroundType of //
        bgtColorFill :
          begin
            Canvas.Brush.Style := bsSolid;
            Canvas.Brush.Color := Color;
            Canvas.FillRect(R);
          end;
        bgtHorzGradient,
        bgtVertGradient:
          GradientFill(Canvas.Handle, R, GradientStartColor, GradientEndColor, GradientSteps, BackgroundType = bgtVertGradient);
        bgtStretchBitmap,
        bgtTileBitmap:
          begin
            CopyRect(Rect, FTmpBmp.Canvas, Classes.Rect(0, 0, FTmpBmp.Width, FTmpBmp.Height));
          end;
        bgtCenterBitmap :
          begin
            Brush.Color := Color;
            Rect := R;
            FillRect(Rect);
            R := Classes.Rect(0, 0, FBackground.Width, FBackground.Height);
            CenterRects(FBackground.Width, Rect.Right - Rect.Left, FBackground.Height, Rect.Bottom - Rect.Top, R1);
            OffsetRect(R1, Rect.Left, Rect.Top);
            CopyRect(R1, FBackground.Canvas, Classes.Rect(0, 0, FBackground.Width, FBackground.Height));
          end;
      end; // case

      if (FVScrollVisible and FHScrollVisible) and (FUseCustomScrollBars) then
      begin
        // PAINT CROSS SCROLLBARS AREA:
        {$IFDEF OLDELSCROLLBARS}
        R := Classes.Rect(
          FVertScrollbar.Left,
          FHorzScrollBar.Top,
          FVertScrollbar.Left + FVertScrollbar.Width,
          FHorzScrollBar.Top + FHorzScrollBar.Height
        );
        {$ELSE}
        SetRect( R,
          VertScrollbarStyles.ScrollBarRect.Left,
          HorzScrollbarStyles.ScrollBarRect.Top,
          VertScrollbarStyles.ScrollBarRect.Right,
          HorzScrollbarStyles.ScrollBarRect.Bottom
        );
        {$ENDIF}
        Canvas.Brush.Style := bsSolid;
        {$IFDEF OLDELSCROLLBARS}
        Canvas.Brush.Color := FVertScrollBar.Color;
        {$ELSE}
        Canvas.Brush.Color := VertScrollBarStyles.Color;
        {$ENDIF}
        Canvas.FillRect(R);
      end;
    end;
  end else
  begin
    GetClipBox(Canvas.Handle, R);
    R1 := R;
    P := Parent.ScreenToClient(ClientToScreen(Point(0, 0)));
    with P do
      OffsetRect(R1, X, Y);
    RedrawWindow(Parent.Handle, @R1, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or
      RDW_UPDATENOW);

    with R do
        BitBlt(Canvas.Handle, Left, Top, Right, Bottom, TmpDC, R.Left, R.Top, SRCCOPY);
  end;
  FRender.DrawText(Canvas, FViewPos, FTextRect, clNone);
end;  { Paint }

procedure TElHTMLView.CMMouseEnter(var Msg : TMessage);  { private }
begin
  inherited;
  FMouseOver := true;
  if (Flat and (not Focused)) {$IFDEF OLDELSCROLLBARS}or UseCustomScrollBars{$ENDIF} then
    DrawFlatBorder(false, false);
end;  { CMMouseEnter }

procedure TElHTMLView.CMMouseLeave(var Msg : TMessage);  { private }
begin
  FMouseOver := false;
  if (Msg.LParam = 0) or (Msg.LParam = Integer(Self)) then
  begin
    if (Flat and (not Focused)) {$IFDEF OLDELSCROLLBARS}or UseCustomScrollBars{$ENDIF} then
      DrawFlatBorder(false, false);
    inherited Cursor := FCursor;
  end;
  inherited;
end;  { CMMouseLeave }

procedure TElHTMLView.SetActiveBorderType(newValue : TElFlatBorderType);
begin
  if (FActiveBorderType <> newValue) then
  begin
    FActiveBorderType := newValue;
    if (Focused or FMouseOver) then UpdateFrame;
  end;  { if }
end;  { SetActiveBorderType }

procedure TElHTMLView.SetInactiveBorderType(newValue : TElFlatBorderType);
{ Sets data member FInactiveBorderType to newValue. }
begin
  if (FInactiveBorderType <> newValue) then
  begin
    FInactiveBorderType := newValue;
    if (not (Focused or FMouseOver)) then UpdateFrame;
  end;  { if }
end;  { SetInactiveBorderType }

procedure TElHTMLView.SetFlat(newValue : Boolean);
{ Sets data member FFlat to newValue. }
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    UpdateFrame;
  end;  { if }
end;  { SetFlat }

procedure TElHTMLView.SetImageForm(newValue : TElImageForm);
begin
  if (FImgForm <> newValue) then
  begin
    if FImgForm <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      {$endif}
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    FImgForm := newValue;
    if (newValue <> nil) then
    begin
      newValue.FreeNotification(Self);
      FImgForm.RegisterChanges(FImgFormChLink);
    end;
    if not (csDesigning in ComponentState) then
    begin
      Invalidate;
      UpdateFrame;
    end;
  end;  { if }
end;  { SetImageForm }

procedure TElHTMLView.SetGradientStartColor(newValue : TColor);
{ Sets data member FGradientStartColor to newValue. }
begin
  if (FGradientStartColor <> newValue) then
  begin
    FGradientStartColor := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then
    begin
      Invalidate;
      UpdateFrame;
    end;
  end;  { if }
end;  { SetGradientStartColor }

procedure TElHTMLView.SetGradientEndColor(newValue : TColor);
{ Sets data member FGradientEndColor to newValue. }
begin
  if (FGradientEndColor <> newValue) then
  begin
    FGradientEndColor := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then
    begin
      Invalidate;
      UpdateFrame;
    end;
  end;  { if }
end;  { SetGradientEndColor }

procedure TElHTMLView.SetGradientSteps(newValue : Integer);
{ Sets data member FGradientSteps to newValue. }
begin
  if (FGradientSteps <> newValue) and (newValue > 0) then
  begin
    FGradientSteps := newValue;
    if (FBackgroundType = bgtHorzGradient) or (FBackgroundType = bgtVertGradient) then
    begin
      Invalidate;
      UpdateFrame;
    end;
  end;  { if }
end;  { SetGradientSteps }

procedure TElHTMLView.SetBackground(newValue : TBitmap);
begin
  FBackground.Assign(newValue);
  if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
     then BackgroundType := bgtColorFill;
end; {SetBackground}

procedure TElHTMLView.SetBackgroundType(newValue : TElBkGndType);
begin
  if (FBackgroundType <> newValue) then
  begin
    FBackgroundType := newValue;
    if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
       then FBackgroundType := bgtColorFill;
    RedoTmpBmp;
    begin
      Invalidate;
      UpdateFrame;
    end;
  end; {if}
end; {SetBackgroundType}

procedure TElHTMLView.ImageFormChange(Sender : TObject);
begin
  Invalidate;
  UpdateFrame;
end;

procedure TElHTMLView.ImageChange(Sender : TObject);
begin
  if ((FBackground.Height = 0) or (FBackground.Width = 0)) then
    BackgroundType := bgtColorFill
  else
  begin
    if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then RedoTmpBmp;
    UpdateFrame;
  end;
end;

procedure TElHTMLView.CreateParams;
const
{$IFNDEF VCL_4_USED}
  BorderStyles: array[TBorderStyle] of Longint = (0, WS_BORDER);
{$ELSE}
  BorderStyles: array[TBorderStyle] of DWord = (0, WS_BORDER);
{$ENDIF}
  LeftSB: array[Boolean] of DWORD = (0, WS_EX_LEFTSCROLLBAR);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle] {or (WS_HSCROLL or WS_VSCROLL)};
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
    if Transparent then
       ExStyle := ExStyle or WS_EX_TRANSPARENT
    else
       ExStyle := ExStyle and not WS_EX_TRANSPARENT;
    with Params.WindowClass do
      style := style and not (CS_HREDRAW or CS_VREDRAW);
    if NewStyleControls or UseCustomScrollBars then
      ExStyle := ExStyle or LeftSB[RightAlignedView];
  end;
end;

procedure TElHTMLView.SetRightAlignedView(Value: Boolean);
begin
  if FRightAlignedView <> Value then
  begin
    FRightAlignedView := Value;
    AdjustScrollBars;
    RecreateWnd;
  end;
end;

procedure TElHTMLView.SetTransparent(newValue : Boolean);
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
    UpdateFrame;
  end; { if }
end; { SetTransparent }

procedure TElHTMLView.DrawFlatBorder(HorzTracking, VertTracking : boolean);
var
  DC : HDC;
  RC,
  RW : TRect;
  SavedDC : HDC;
  b  : boolean;
  BS : TElFlatBorderType;
  Theme : HTheme;
  AColor: TColor;

const
  ScrollBars: array [Boolean, Boolean] of TScrollStyle = (
    (ssNone,       ssVertical),
    (ssHorizontal, ssBoth)
  );

begin
  Windows.GetClientRect(Handle, RC);

  {$IFNDEF OLDELSCROLLBARS}
  if UseCustomScrollBars then
  begin
    if VertScrollBarStyles.Visible then
    begin
      if not RightAlignedView then
        inc(RC.Right, VertScrollBarStyles.Depth)
      else
        dec(RC.Left, VertScrollBarStyles.Depth)
    end;
    if HorzScrollBarStyles.Visible then
      inc(RC.Bottom, HorzScrollBarStyles.Depth);
  end
  else
  {$ELSE}
  if not UseCustomScrollBars then
  {$ENDIF}
  begin
    if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
    begin
      if (not RightAlignedView) or (not NewStyleControls) then
        inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL))
      else
        dec(RC.Left, GetSystemMetrics(SM_CXVSCROLL));
    end;
    if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
      inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
  end;

  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  OffsetRect(RW, -RW.Left, -RW.Top);

  DC := GetWindowDC(Handle);
  try
    if (BorderStyle = bsSingle) and IsThemeApplied then
    begin
      Theme := OpenThemeData(0, 'EDIT');
      if Theme <> 0 then
      begin
        SavedDC := SaveDC(DC);
        ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
        DrawThemeBackground(Theme, DC, 0, 0, RW, nil);

        CloseThemeData(Theme);

        RestoreDC(DC, SavedDC);
      end;
    end;
    begin
      if (BorderStyle = bsSingle) and not IsThemeApplied then
      begin
        b := Focused or FMouseOver;
        if b then BS := FActiveBorderType else BS := FInactiveBorderType;
        if ((not FFlat) {$IFDEF OLDELSCROLLBARS}and FUseCustomScrollBars{$ENDIF}) then
           BS := fbtSunken;
        if bs = fbtRaised then bs := fbtRaisedOuter;
        if Focused or FMouseOver then
          AColor := LineBorderActiveColor
        else
          AColor := LineBorderInactiveColor;
        DrawFlatFrameEx2(DC, RW, AColor, Color, b, Enabled, BorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
      end;
      if (not FUseCustomScrollBars) and
         (FFlatFocusedScrollBars or not (Focused or FMouseOver))
      then
         DrawFlatScrollBars(Handle, DC, RW, (Focused or FMouseOver) and (not FlatFocusedScrollBars),
            ScrollBars[FHScrollVisible, FVScrollVisible], HorzTracking, VertTracking, False,
            GetWindowLong(Handle, GWL_STYLE), GetWindowLong(Handle, GWL_EXSTYLE));
    end;
  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TElHTMLView.DrawFlatBorderEx(DC : HDC; HorzTracking, VertTracking : boolean);
var
  RC,
  RW : TRect;
  SavedDC : HDC;
  b  : boolean;
  BS : TElFlatBorderType;
  Theme : HTheme;
  AColor: TColor;

const ScrollBars: array [boolean, boolean] of TScrollStyle = ((ssNone, ssVertical), (ssHorizontal, ssBoth));
begin
  Windows.GetClientRect(Handle, RC);

  {$IFNDEF OLDELSCROLLBARS}
  if UseCustomScrollBars then
  begin
    if VertScrollBarStyles.Visible then
    begin
      if not RightAlignedView then
        inc(RC.Right, VertScrollBarStyles.Depth)
      else
        dec(RC.Left, VertScrollBarStyles.Depth)
    end;
    if HorzScrollBarStyles.Visible then
      inc(RC.Bottom, HorzScrollBarStyles.Depth);
  end
  else
  {$ELSE}
  if not UseCustomScrollBars then
  {$ENDIF}
  begin
    if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
    begin
      if (not RightAlignedView) or (not NewStyleControls) then
        inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL))
      else
        dec(RC.Left, GetSystemMetrics(SM_CXVSCROLL));
    end;
    if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
      inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
  end;

  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  OffsetRect(RW, -RW.Left, -RW.Top);

  if (BorderStyle = bsSingle) and IsThemeApplied then
  begin
    Theme := OpenThemeData(0, 'EDIT');
    if Theme <> 0 then
    begin
      SavedDC := SaveDC(DC);
      ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
      DrawThemeBackground(Theme, DC, 0, 0, RW, nil);

      CloseThemeData(Theme);

      RestoreDC(DC, SavedDC);
    end;
  end;
  if (BorderStyle = bsSingle) and not IsThemeApplied then
  begin
    b := Focused or FMouseOver;
    if b then BS := FActiveBorderType else BS := FInactiveBorderType;
    if ((not FFlat) {$IFDEF OLDELSCROLLBARS}and FUseCustomScrollBars{$ENDIF}) then
       BS := fbtSunken;
    if bs = fbtRaised then bs := fbtRaisedOuter;
    if Focused or FMouseOver then
      AColor := LineBorderActiveColor
    else
      AColor := LineBorderInactiveColor;

    DrawFlatFrameEx2(DC, RW, AColor, Color, b, Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
  end;

  if (not FUseCustomScrollBars) and //(not IsThemeApplied)
     (FFlatFocusedScrollBars or not (Focused or FMouseOver))
  then
     DrawFlatScrollBars(Handle, DC, RW, (Focused or FMouseOver) and (not FlatFocusedScrollBars),
       ScrollBars[FHScrollVisible, FVScrollVisible], HorzTracking, VertTracking, false,
       GetWindowLong(Handle, GWL_STYLE), GetWindowLong(Handle, GWL_EXSTYLE));
end;

procedure TElHTMLView.RedoTmpBmp;
var BgRect,
    BgRect2 : TRect;
begin
  if BackgroundType in [bgtHorzGradient, bgtVertGradient, bgtColorFill, bgtCenterBitmap] then
  begin
    FTmpBmp.FreeImage;
  end else
  begin
    if HandleAllocated and (ClientWidth <> 0) and (ClientHeight <> 0) then
    begin
      FTmpBmp.Height := ClientHeight - 1;
      FTmpBmp.Width := ClientWidth - 1;
      BgRect := ClientRect;
      BgRect2 := BgRect;
      OffsetRect(BgRect2, BgRect2.Left, BgRect2.Top);
      ExtDrawBkgnd(FTmpBmp.Canvas.Handle, BgRect, BgRect, BgRect, BgRect2, false, Color, Color, Background, BackgroundType);
    end;
  end;
end;

procedure TElHTMLView.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
    if (AComponent = FImgForm) then
      ImageForm := nil;
    if (AComponent = FLinkPopupMenu) then
      LinkPopupMenu := nil;
  end;  { if }
end;  { Notification }

procedure TElHTMLView.WMSetFocus(var Msg : TWMSetFocus);  { private }
begin
  inherited;
  if Flat {$IFDEF OLDELSCROLLBARS}or FUseCustomScrollBars{$ENDIF} then
    UpdateFrame;
end;  { WMSetFocus }

procedure TElHTMLView.WMKillFocus(var Msg : TWMKillFocus);  { private }
begin
  inherited;
  if not HandleAllocated then exit;
  if Flat {$IFDEF OLDELSCROLLBARS}or FUseCustomScrollBars{$ENDIF} then
    UpdateFrame;
end;  { WMKillFocus }

procedure TElHTMLView.CMTextChanged(var Msg : TMessage);  { private }
var R : TRect;
begin
  inherited;
  FViewPos := Point(0, 0);
  if WordWrap then
  begin
    PrepareText;
    AdjustScrollBars;
  end;
  PrepareText;
  AdjustScrollBars;
  R := FViewRect;
  if HandleAllocated then
     InvalidateRect(Handle, @R, false);
  //UpdateFrame;
end;  { CMTextChanged }

procedure TElHTMLView.CreateWindowHandle(const Params: TCreateParams);  { protected }
begin
  inherited CreateWindowHandle(Params);
  PrepareText;
  AdjustScrollBars;
  if WordWrap then
    PrepareText;
end;  { CreateWindowHandle }

procedure TElHTMLView.SetLinkColor(newValue : TColor);
{ Sets data member FLinkColor to newValue. }
begin
  if (FLinkColor <> newValue) then
  begin
    FLinkColor := newValue;
    PrepareText;
  end;  { if }
end;  { SetLinkColor }

procedure TElHTMLView.SetLinkStyle(newValue : TFontStyles);
{ Sets data member FLinkStyle to newValue. }
begin
  if (FLinkStyle <> newValue) then
  begin
    FLinkStyle := newValue;
    PrepareText;
  end;  { if }
end;  { SetLinkStyle }

procedure TElHTMLView.SetHighlightColor(newValue : TColor);
{ Sets data member FHighlightColor to newValue. }
begin
  if (FHighlightColor <> newValue) then
  begin
    FHighlightColor := newValue;
    Invalidate;
    UpdateFrame;
  end;  { if }
end;  { SetHighlightColor }

procedure TElHTMLView.SetHighlightBkColor(newValue : TColor);
{ Sets data member FHighlightBkColor to newValue. }
begin
  if (FHighlightBkColor <> newValue) then
  begin
    FHighlightBkColor := newValue;
    Invalidate;
    UpdateFrame;
  end;  { if }
end;  { SetHighlightBkColor }

procedure TElHTMLView.TriggerLinkClickEvent(HRef : string);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

procedure TElHTMLView.TriggerImageNeededEvent(Sender : TObject; Src :
    TElFString; var Image : TBitmap);
begin
  if (assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src , Image );
end;  { TriggerImageNeededEvent }

procedure TElHTMLView.Click;  { public }
var P : TPoint;
    href : TElFString;
    P1: TPoint;
begin
  P1 := FViewPos;
  dec(P1.x, FTextRect.Left);
  dec(P1.y, FTextRect.Top);

  GetCursorPos(P);
  P := ScreenToClient(P);
  if FRender.IsCursorOverLink(P, P1, FTextRect, href) then
    TriggerLinkClickEvent(href)
  else
    inherited;
end;  { Click }

procedure TElHTMLView.MouseMove(Shift: TShiftState; X, Y: Integer);  { protected }
var href : TElFString;
    P1   : TPoint;
begin
  P1 := FViewPos;
  dec(P1.x, FTextRect.Left);
  dec(P1.y, FTextRect.Top);

  if FRender.IsCursorOverLink(Point(X, Y), P1, FTextRect, href) then
     inherited Cursor := crURLCursor
  else
     inherited Cursor := FCursor;
  inherited MouseMove(Shift, X, Y);
end;  { MouseMove }

procedure TElHTMLView.SetCursor(newValue : TCursor);
var P : TPoint;
    href : TElFString;
    P1    : TPoint;
begin
  if (FCursor <> newValue) then
  begin
    P1 := FViewPos;
    dec(P1.x, FTextRect.Left);
    dec(P1.y, FTextRect.Top);

    FCursor := newValue;
    GetCursorPos(P);
    P := ScreenToClient(P);
    if FRender.IsCursorOverLink(P, P1, FTextRect, href) then
       inherited Cursor := crURLCursor
    else
       inherited Cursor := FCursor;
  end;  { if }
end;  { SetCursor }


{$IFDEF OLDELSCROLLBARS}
type
  THackElScrollBar = class(TElScrollBar)
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  end;

procedure THackElScrollBar.KeyDown;
begin
  inherited;
end;
{$ENDIF}

procedure TElHTMLView.KeyDown(var Key: Word; Shift: TShiftState);  { protected }
{$IFNDEF OLDELSCROLLBARS}
 function GetScrollCodes(KeyCode:DWORD):DWORD;
 begin
   case KeyCode of
    VK_PRIOR: Result := SB_PAGEUP;
    VK_NEXT:  Result := SB_PAGEDOWN;
    VK_LEFT:  Result := SB_LINELEFT;
    VK_UP:    Result := SB_LINEUP;
    VK_RIGHT: Result := SB_LINERIGHT;
    VK_DOWN:  Result := SB_LINEDOWN;
    else
              Result := 0;
   end;
 end;
{$ENDIF}
begin
  inherited KeyDown(Key, Shift);
  if (Key <> 0) and (Shift = []) then
  begin
    case Key of
      VK_RETURN:
        begin
          if (FRender.Data.SelectedItem <> nil) and
             (FRender.Data.SelectedItem.IsLink) then
          TriggerLinkClickEvent(FRender.Data.SelectedItem.LinkRef);
        end;
      VK_TAB:
        begin
          FRender.SelectNextLink;
          InvalidateRect(Handle, @FViewRect, false);
        end;
      VK_PRIOR,//33
      VK_NEXT, //34
      VK_UP,   //38
      VK_DOWN: //40
        begin
          {$IFDEF OLDELSCROLLBARS}
          if FVertScrollBar.Visible then
             THackElScrollBar(FVertScrollBar).KeyDown(Key, Shift);
          {$ELSE}
          if VertScrollBarStyles.Visible then
            Perform( WM_VSCROLL, GetScrollCodes(Key), 0);
          {$ENDIF}
        end;
      VK_SPACE:
        begin
          Key := VK_NEXT;
          {$IFDEF OLDELSCROLLBARS}
          if FVertScrollBar.Visible then
             THackElScrollBar(FVertScrollBar).KeyDown(Key, Shift);
          {$ELSE}
          if VertScrollBarStyles.Visible then
            Perform( WM_VSCROLL, GetScrollCodes(Key), 0);
          {$ENDIF}
        end;
      VK_LEFT,  // 37
      VK_RIGHT: // 39
        begin
          {$IFDEF OLDELSCROLLBARS}
          if FHorzScrollBar.Visible then
             THackElScrollBar(FHorzScrollBar).KeyDown(Key, Shift);
          {$ELSE}
          if HorzScrollBarStyles.Visible then
            Perform( WM_HSCROLL, GetScrollCodes(Key), 0);
          {$ENDIF}
        end;
    end;
  end
  else
  if (Key <> 0) and (Shift = [ssShift]) then
  begin
    if (Key = VK_TAB) then
    begin
      FRender.SelectPrevLink;
      InvalidateRect(Handle, @FViewRect, false);
    end;
  end else
  if (Key <> 0) and (Shift = [ssCtrl]) then
  begin
    if (Key = VK_LEFT) or (Key = VK_RIGHT) then
    begin
      if (Key = VK_LEFT) then
        Key := VK_PRIOR
      else
      if (Key = VK_RIGHT) then
        Key := VK_NEXT;
      {$IFDEF OLDELSCROLLBARS}
      THackElScrollBar(FHorzScrollBar).KeyDown(Key, []);
      {$ELSE}
      Perform( WM_HSCROLL, GetScrollCodes(Key), 0);
      {$ENDIF}
    end;
  end;
end;  { KeyDown }

procedure TElHTMLView.WMGetDlgCode(var Msg : TWMGetDlgCode);  { private }
begin
  Msg.Result := DLGC_WANTARROWS or DLGC_WANTCHARS or DLGC_WANTTAB;
end;  { WMGetDlgCode }

procedure TElHTMLView.WMPaint(var Msg : TWMPaint);  { private }
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R : TRect;
  ARgn : HRGN;
begin
  if (Msg.DC <> 0) then
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
      GetClipBox(DC, R);
      if IsRectEmpty(R) then
         R := FViewRect
      else
        InflateRect(R, 1, 1);
      with R do
        ARgn := CreateRectRgn(Left, Top, right, Bottom);
      SelectClipRgn(MemDC, ARgn);

      TmpDC := DC;

      Msg.DC := MemDC;
      WMPaint(Msg);
      SelectClipRgn(MemDC, 0);
      DeleteObject(ARgn);
      Msg.DC := 0;
      with R do
        BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;  { WMPaint }

procedure TElHTMLView.WMEraseBkgnd(var Msg : TWMEraseBkgnd);  { private }
  (*
  {$IFDEF OLDELSCROLLBARS}
  procedure ExcludeCustomScrollBarsArea;
  begin
    if UseCustomScrollBars then
    begin
      if FVertScrollBar.Visible then
      with FVertScrollBar do
      begin
        ExcludeClipRect(Msg.DC,
          Left,
          Top,
          Left+Width,
          Top+Height);
        {
        // EXCLUDE CROSS SCROLBARS AREA:
        // todo: ??? при первом запуске получаем прозрачную дырку. ј без этого куска квадрат будет
        //       мерцать.
        if FHorzScrollBar.Visible then
        ExcludeClipRect(Msg.DC,
          Left-1,
          FHorzScrollBar.Top,
          Left+Width,
          FHorzScrollBar.Top+FHorzScrollBar.Height);{}
      end;
      if FHorzScrollBar.Visible then
      with FHorzScrollBar do
        ExcludeClipRect(Msg.DC,
          Left,
          Top,
          Left+Width,
          Top+Height);
    end;
  end;
  {$ENDIF}
  //*)
begin
  {$IFDEF OLDELSCROLLBARS}
  //???
  //ExcludeCustomScrollBarsArea;
  {$ENDIF}
  Msg.Result := 1;
end;  { WMEraseBkgnd }

procedure TElHTMLView.WMMouseWheel(var Msg: TWMMouseWheel); { private }
var
  Dy : integer;
  sl : integer;
begin
  if IsWinNT or IsWin98 then
     SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
  else
     sl := 3;
  if sl = 0 then sl := 1;
  Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
  if Dy <> 0 then
  begin
    {$IFDEF OLDELSCROLLBARS}
    FVertScrollBar.Position := FViewPos.Y - Dy * FScrollStep;
    FViewPos.Y := FVertScrollBar.Position;
    InvalidateRect(Handle, @FViewRect, False);
    {$ELSE}//???:
      Perform( WM_VSCROLL, FViewPos.Y - Dy * FScrollStep shl 16 + SB_THUMBPOSITION, 0);
    {$ENDIF}
  end;
end; { WMMouseWheel }

procedure TElHTMLView.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);  { protected }
var P : TPoint;
    href : TElFString;
    P1: TPoint;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if CanFocus then SetFocus;
  P := Point(X, Y);
  P1 := FViewPos;
  dec(P1.x, FTextRect.Left);
  dec(P1.y, FTextRect.Top);

  if FRender.IsCursorOverLink(P, P1, FTextRect, href) then
     FRender.SelectLinkAt(P, FViewPos, FTextRect)
  else
     FRender.SelectLinkAt(Point(-1, -1), Point(0, 0), FTextRect);
  InvalidateRect(Handle, @FViewRect, false);
end;

procedure TElHTMLView.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  if (FLinkPopupMenu <> newValue) then
  begin
    {$ifdef VCL_5_USED}
    if FLinkPopupMenu <> nil then
      if not (csDestroying in FLinkPopupMenu.ComponentState) then
        FLinkPopupMenu.RemoveFreeNotification(Self);
    {$endif}
    FLinkPopupMenu := newValue;
    if (newValue <> nil) then
       newValue.FreeNotification(Self);
  end;  { if }
end;  { SetLinkPopupMenu }

procedure TElHTMLView.SetUseCustomScrollBars(newValue : Boolean);
{ Sets data member FUseCustomScrollBars to newValue. }
begin
  if (FUseCustomScrollBars <> newValue) then
  begin
    FUseCustomScrollBars := newValue;
    {$IFNDEF OLDELSCROLLBARS}
    fSBCtrl.Control := nil;
    if fUseCustomScrollBars then
    begin
      fSBCtrl.Control := Self;
      if not fSBCtrl.Active then
      begin
        fUseCustomScrollBars := False;
        fSBCtrl.Control := nil;
        exit;
      end;
    end;
    {$ELSE}
    RecreateWnd;
    {$ENDIF}
    AdjustScrollBars;
  end;  { if }
end;  { SetUseCustomScrollBars }

procedure TElHTMLView.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  {$IFDEF OLDELSCROLLBARS}
  FVertScrollBar.Enabled := Enabled;
  FHorzScrollBar.Enabled := Enabled;
  {$ELSE}
  VertScrollBarStyles.Enabled := Enabled;
  HorzScrollBarStyles.Enabled := Enabled;
  {$ENDIF}
end;

procedure TElHTMLView.WMNCPaint(var Msg : TMessage);  { private }
var DC : HDC;

  procedure CallInheritedWOFrame;
  var
    WS, WES :DWORD;
  begin
    try
      WES := GetWindowLong(Handle, GWL_EXSTYLE);
      if WES and WS_EX_CLIENTEDGE <> 0 then
      begin
        WS := 0;
        FPreventStyleChange := True;
        SetWindowLong(Handle, GWL_EXSTYLE, WES and not WS_EX_CLIENTEDGE);
      end
      else
      begin
        WES := 0;
        WS  := GetWindowLong(Handle, GWL_STYLE);
        if WS and WS_BORDER <> 0 then
        begin
          FPreventStyleChange := True;
          SetWindowLong(Handle, GWL_STYLE, WS and not WS_BORDER);
        end
        else
          WS := 0;
      end;

      //inherited
      DefaultHandler(Msg);

      if WES <> 0 then
        SetWindowLong(Handle, GWL_EXSTYLE, WES)
      else if WS <> 0 then
        SetWindowLong(Handle, GWL_STYLE, WS);
    finally
      if FPreventStyleChange then
        FPreventStyleChange := False;
    end;
  end;

  procedure PaintCrossSystemScrollbarsArea;
    var
      nFrameSize :Integer;
      RW         :TRect;
  begin
    // paint left cross scrollbars area for system scrollbars:
    begin
      GetWindowRect(Handle, RW);
      MapWindowPoints(0, Handle, RW, 2);
      OffsetRect(RW, -RW.Left, -RW.Top);

      if ((GetWindowLong(Handle, GWL_STYLE) and WS_BORDER) = WS_BORDER) then
        nFrameSize := GetSystemMetrics(SM_CXBORDER)
      else
        if ((GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE) then
        nFrameSize := GetSystemMetrics(SM_CXEDGE)
      else
        nFrameSize := 0;

      with RW do
      begin
        if (not RightAlignedView) or (not NewStyleControls) then
        begin
          dec(Right, nFrameSize);
          Left:= Right - GetSystemMetrics(SM_CXVSCROLL);
          dec(Bottom, nFrameSize);
          Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
        end
        else
        begin
          Left   := nFrameSize;
          Right := Left + GetSystemMetrics(SM_CXVSCROLL);
          dec(Bottom, nFrameSize);
          Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
        end;
        Windows.DrawEdge(DC, RW, EDGE_SUNKEN, BF_MIDDLE);
      end;
    end;
  end;

begin
  if FPreventStyleChange then
    exit;

  if (Flat or FUseCustomScrollBars or IsThemeApplied) and
    (BorderStyle = bsSingle) then
  begin
    if not FUseCustomScrollBars then
      CallInheritedWOFrame;

    DC := GetWindowDC(Handle);
    {
    if IsThemeApplied then
    begin
      R1 := BoundsRect;
      OffsetRect(R1, -R1.Left, - R1.Top);

      R.TopLeft := Parent.ClientToScreen(BoundsRect.TopLeft);
      R.BottomRight := Parent.ClientToScreen(BoundsRect.BottomRight);
      R2 := ClientRect;
      OffsetRect(R2, ClientOrigin.X - R.Left, ClientOrigin.Y - R.Top);

      with R2 do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);
      DrawThemeBackgroundTo('EDIT', DC, 0, 0, R1, nil)
    end
    else
    {}

    DrawFlatBorderEx(DC, false, false);

    if (not UseCustomScrollBars) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) and
       (NewStyleControls)
    then
      PaintCrossSystemScrollbarsArea;

    ReleaseDC(Handle, DC);
    Msg.Result := 0;
  end
  else
  begin
    inherited;
    if RightAlignedView and (not UseCustomScrollBars) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) and
       (NewStyleControls)
    then
    begin
      //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
      //if DC = 0 then
        DC := GetWindowDC(Handle);
      PaintCrossSystemScrollbarsArea;
      ReleaseDC(Handle, DC);
    end;
  end;
end;  { WMNCPaint }

procedure TElHTMLView.WMNCCalcSize(var Message : TWMNcCalcSize);  { private }
begin
  {$IFDEF OLDELSCROLLBARS}
  if not FUseCustomScrollBars then
    inherited
  else
  begin
    if BorderStyle = bsSingle then
    begin
      inc(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
      inc(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
      dec(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smYEdge[Ctl3D]));
      dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));
      if Message.CalcSize_Params.rgrc[0].Right < Message.CalcSize_Params.rgrc[0].Left then
        Message.CalcSize_Params.rgrc[0].Right := Message.CalcSize_Params.rgrc[0].Left;
      if Message.CalcSize_Params.rgrc[0].Bottom < Message.CalcSize_Params.rgrc[0].Top then
        Message.CalcSize_Params.rgrc[0].Bottom := Message.CalcSize_Params.rgrc[0].Top;
    end;
  end;
  {$ELSE}
   inherited;
  {$ENDIF}

  if BorderStyle = bsSingle then
  begin
    if not (ebsLeft in BorderSides) then
      dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
    if not (ebsTop in BorderSides) then
      dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
    if not (ebsRight in BorderSides) then
      Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smYEdge[Ctl3D]));
    if not (ebsBottom in BorderSides) then
      Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));

    if Message.CalcSize_Params.rgrc[0].Right < Message.CalcSize_Params.rgrc[0].Left then
      Message.CalcSize_Params.rgrc[0].Right := Message.CalcSize_Params.rgrc[0].Left;
    if Message.CalcSize_Params.rgrc[0].Bottom < Message.CalcSize_Params.rgrc[0].Top then
      Message.CalcSize_Params.rgrc[0].Bottom := Message.CalcSize_Params.rgrc[0].Top;
  end;
  // Message.Result := WVR_REDRAW;
end;  { WMNCCalcSize }

procedure TElHTMLView.WMNCHitTest(var Msg : TMessage);  { private }
begin
  inherited;
  {$IFDEF OLDELSCROLLBARS} //???:
  if FUseCustomScrollBars then
  begin
    if (Msg.Result = HTHSCROLL) or (Msg.Result = HTVSCROLL) then
        Msg.Result := HTBORDER;
  end;
  {$ENDIF}
  if Msg.Result = HTBORDER then
    Msg.Result := HTSIZE;
end;  { WMNCHitTest }

{$WARNINGS OFF}
procedure TElHTMLView.WMVScroll(var Msg : TWMVScroll);  { private }
var b : boolean;
    sc: TElscrollCode;
    sp: integer;
begin
  b := false;
  case Msg.ScrollCode of
    SB_TOP:
      begin
        sc := escTop;
        sp := 0;
      end;
    SB_BOTTOM:
      begin
        sc := escTop;
        sp := FRender.Data.TextSize.cy;
      end;
    SB_ENDSCROLL:
      begin
        sc := escEndScroll;
        sp := FViewPos.y;
      end;
    SB_LINEDOWN:
      begin
        sc := escLineDown;
        sp := FViewPos.y + Abs(Font.Height);
      end;
    SB_LINEUP:
      begin
        sc := escLineUp;
        sp := FViewPos.y - Abs(Font.Height);
      end;
    SB_PAGEDOWN:
      begin
        sc := escPageDown;
        {$IFDEF OLDELSCROLLBARS}
        sp := FViewPos.y + FVertScrollBar.Page;
        {$ELSE}
        sp := FViewPos.y + VertScrollBarStyles.Page;
        {$ENDIF}
      end;
    SB_PAGEUP:
      begin
        sc := escPageUp;
        {$IFDEF OLDELSCROLLBARS}
        sp := FViewPos.y - FVertScrollBar.Page;
        {$ELSE}
        sp := FViewPos.y - VertScrollBarStyles.Page;
        {$ENDIF}
        if sp<0 then
          sp := 0;
      end;
    SB_THUMBPOSITION:
      begin
        sc := escPosition;
        sp := Msg.Pos;
      end;
    SB_THUMBTRACK:
      begin
        sc := escTrack;
        sp := Msg.Pos;
      end;
  end;
  if (sp >= 0) and
     {$IFDEF OLDELSCROLLBARS}
     (sp < FVertScrollBar.Max)
     {$ELSE}
     (sp < VertScrollBarStyles.Max)
     {$ENDIF}
  then
     OnVScroll(
       {$IFDEF OLDELSCROLLBARS}
       FVertScrollBar,
       {$ELSE}
       VertScrollBarStyles,
       {$ENDIF}
       SC, sp, b);
end;  { WMVScroll }

procedure TElHTMLView.WMHScroll(var Msg : TWMHScroll);  { private }
var b : boolean;
    sc: TElscrollCode;
    sp: integer;
begin
  b := false;
  case Msg.ScrollCode of
    SB_TOP:
      begin
        sc := escTop;
        sp := 0;
      end;
    SB_BOTTOM:
      begin
        sc := escTop;
        sp := FRender.Data.TextSize.cx;
      end;
    SB_ENDSCROLL:
      begin
        sc := escEndScroll;
        sp := FViewPos.x;
      end;
    SB_LINEDOWN:
      begin
        sc := escLineDown;
        sp := FViewPos.x + 1;
      end;
    SB_LINEUP:
      begin
        sc := escLineUp;
        sp := FViewPos.x - 1;
      end;
    SB_PAGEDOWN:
      begin
        sc := escPageDown;
        {$IFDEF OLDELSCROLLBARS}
        sp := FViewPos.x + FHorzScrollBar.Page;
        {$ELSE}
        sp := FViewPos.x + HorzScrollBarStyles.Page;
        {$ENDIF}
      end;
    SB_PAGEUP:
      begin
        sc := escPageUp;
        {$IFDEF OLDELSCROLLBARS}
        sp := FViewPos.x - FHorzScrollBar.Page;
        {$ELSE}
        sp := FViewPos.x - HorzScrollBarStyles.Page;
        {$ENDIF}
        if sp<0 then
          sp := 0;
      end;
    SB_THUMBPOSITION:
      begin
        sc := escPosition;
        sp := Msg.Pos;
      end;
    SB_THUMBTRACK:
      begin
        sc := escTrack;
        sp := Msg.Pos;
      end;
  end;
  if (sp >= 0) and
     {$IFDEF OLDELSCROLLBARS}
     (sp < FHorzScrollBar.Max)
     {$ELSE}
     (sp < HorzScrollBarStyles.Max)
     {$ENDIF}
  then
     OnHScroll(
       {$IFDEF OLDELSCROLLBARS}
       FHorzScrollBar,
       {$ELSE}
       HorzScrollBarStyles,
       {$ENDIF}
       SC, sp, b);
end;  { WMHScroll }
{$WARNINGS ON}

{$IFDEF VCL_4_USED}
procedure TElHTMLView.CMMouseWheel(var Msg : TCMMouseWheel);  { private }
var
  Dy : integer;
  sl : integer;
begin
  if IsWinNT or IsWin98 then
     SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
  else
     sl := 3;
  if sl = 0 then sl := 1;
  Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
  if Dy <> 0 then
  begin
    {$IFDEF OLDELSCROLLBARS}
    FVertScrollBar.Position := FViewPos.Y - Dy * FScrollStep;
    FViewPos.Y := FVertScrollBar.Position;
    InvalidateRect(Handle, @FViewRect, false);
    {$ELSE} //???:
      Perform( WM_VSCROLL, FViewPos.Y - Dy * FScrollStep shl 16 + SB_THUMBPOSITION, 0);
    {$ENDIF}
  end;
end;  { CMMouseWheel }
{$ENDIF}

procedure TElHTMLView.SetFlatFocusedScrollBars(newValue : Boolean);
{ Sets data member FFlatFocusedScrollBars to newValue. }
begin
  if (FFlatFocusedScrollBars <> newValue) then
  begin
    FFlatFocusedScrollBars := newValue;
    if Focused {$IFDEF OLDELSCROLLBARS}and (not FUseCustomScrollBars){$ENDIF} then
      DrawFlatBorder(false, false);
  end;  { if }
end;  { SetFlatFocusedScrollBars }

procedure TElHTMLView.Loaded;  { protected }
begin
  inherited;
  {$IFDEF OLDELSCROLLBARS}//???
  FVertScrollBar.Loaded;
  FHorzScrollBar.Loaded;
  {$ENDIF}
  AdjustScrollBars;
  if HandleAllocated then
  begin
    PrepareText;
    // FRender.PrepareText(Caption, FTextRect.Right - FTextRect.Left, WordWrap);
    Invalidate;
  end;
end;  { Loaded }

procedure TElHTMLView.WMSize(var Msg : TWMSize);  { private }
begin
  inherited;
  AdjustScrollBars;
  if WordWrap then
     PrepareText;
  AdjustScrollBars;
  Invalidate;
end;  { WMSize }

destructor TElHTMLView.Destroy;
begin
  Destroying;
  ImageForm := nil;
  FRender.Free;
  {$IFDEF OLDELSCROLLBARS}
  FVertScrollBarStyles.Free;
  FHorzScrollBarStyles.Free;
  FVertScrollBar.Free;
  FHorzScrollBar.Free;
  {$ENDIF}
  FBackground.Free;
  FTmpBmp.Free;
  FImgFormChLink.Free;
  inherited Destroy;
end;  { Destroy }

constructor TElHTMLView.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  {< ELSCROLLBAR}
  {$IFNDEF OLDELSCROLLBARS}
  fSBCtrl := TElSBController.Create(Self);
  FSBCtrl.UseXPThemes := true;
  {$ENDIF}
  {> ELSCROLLBAR}

  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
  
  FUseCustomScrollBars := True;
  FRender := TElHTMLRender.Create;
  FImgFormChLink  := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FBackground := TBitmap.Create;
  FBackground.OnChange := ImageChange;
  FBackgroundType := bgtColorFill;
  FGradientSteps := 16;
  FMargin := 4;
  FTmpBmp := TBitmap.Create;
  FRender.OnImageNeeded := TriggerImageNeededEvent;
  FLinkColor := clBlue;
  FLinkStyle := [fsUnderline];
  FBorderStyle := bsSingle;
  Parentcolor := false;
  Color := clWindow;
  FActiveBorderType := fbtSunken;
  FInactiveBorderType := fbtSunkenOuter;
  FHighlightColor := clHighlightText;
  FHighlightBkColor := clHighlight;
  FScrollStep := Abs(Font.Height) div 2;

  {$IFDEF OLDELSCROLLBARS}
  FHorzScrollBar := THackElScrollBar.Create(nil);
  FHorzScrollBar.Parent := Self;
  FHorzScrollBar.OnScroll := OnHScroll;
  FHorzScrollBar.Ctl3D := false;
  FHorzScrollBarStyles := TElScrollBarStyles.Create(FHorzScrollBar, Self);
  FHorzScrollBar.TabStop := false;
  FHorzScrollBar.Height := GetSystemMetrics(SM_CYVTHUMB);
  FHorzScrollBarStyles.OnChange := SBChanged;

  FVertScrollBar := THackElScrollBar.Create(nil);
  FVertScrollBar.Parent := Self;
  FVertScrollBar.OnScroll := OnVScroll;
  FVertScrollBar.Kind := sbVertical;
  FVertScrollBarStyles := TElScrollBarStyles.Create(FVertScrollBar, Self);
  FVertScrollBarStyles.ThumbMode := etmAuto;
  FVertScrollBarStyles.OnChange := SBChanged;
  FVertScrollBar.TabStop := false;
  FVertScrollBar.Ctl3D := false;
  FVertScrollBar.Width := GetSystemMetrics(SM_CXHTHUMB);
  {$ELSE}
  HorzScrollBarStyles.OnScroll := OnHScroll;
  HorzScrollBarStyles.OnChange := SBChanged;
  VertScrollBarStyles.OnScroll := OnVScroll;
  VertScrollBarStyles.OnChange := SBChanged;
  {$ENDIF}

  Width := 136;
  Height := 81;
end;  { Create }

procedure TElHTMLView.SetBorderSides(Value: TElBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TElHTMLView.SetCaption(newValue: TElFString);
{ Sets data member FCaption to newValue. }
begin
  FCaption := newValue;
  inherited Caption := newValue;
end; { SetCaption }

procedure TElHTMLView.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TElHTMLView.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TElHTMLView.SetUseXPThemes(const Value: Boolean);
begin
  inherited;
  {$IFDEF OLDELSCROLLBARS}
  FHorzScrollBar.UseXPThemes := Value;
  FVertScrollBar.UseXPThemes := Value;
  {$ELSE} //???
  HorzScrollBarStyles.UseXPThemes := Value;
  VertScrollBarStyles.UseXPThemes := Value;
  fSBCtrl.UseXPThemes := Value;
  {$ENDIF}
end;

function TElHTMLView.GetThemedClassName: WideString;
begin
  Result := 'WINDOW';
end;

procedure TElHTMLView.WMRButtonUp(var Message: TWMRButtonUp);
{$ifndef VCL_5_USED}
var P,P1 : TPoint;
    href : TElFString;

{$endif}
begin
  {$ifndef VCL_5_USED}
  P := SmallPointToPoint(Message.Pos);
  P1 := FViewPos;
  dec(P1.x, FTextRect.Left);
  dec(P1.y, FTextRect.Top);

  if FRender.IsCursorOverLink(P, P1, FTextRect, href) then
  begin
    if not (csNoStdEvents in ControlStyle) then
      with Message do
        MouseUp(mbRight, KeysToShiftState(Keys), XPos, YPos);
    if Message.Result = 0 then
    begin
      DoLinkPopup(P);
    end;
  end
  else
  {$endif}
    inherited;
end;

procedure TElHTMLView.DoLinkPopup(MousePos : TPoint);
begin
  if (FLinkPopupMenu <> nil) and FLinkPopupMenu.AutoPopup then
  begin
    SendCancelMode(nil);
    FLinkPopupMenu.PopupComponent := Self;
    if MousePos.X < 0 then
      MousePos := ClientToScreen(Point(0,0));
    FLinkPopupMenu.Popup(MousePos.X, MousePos.Y);
  end;
end;

{$ifdef VCL_5_USED}
procedure TElHTMLView.WMContextMenu(var Message: TWMContextMenu);
var
  Pt,
  P1, Temp: TPoint;
  Handled : Boolean;
  href    : TElFString;
begin
  if Message.Result <> 0 then Exit;
  if csDesigning in ComponentState then Exit;

  Pt := ScreenToClient(SmallPointToPoint(Message.Pos));
  P1 := FViewPos;
  dec(P1.x, FTextRect.Left);
  dec(P1.y, FTextRect.Top);

  if FRender.IsCursorOverLink(Pt, P1, FTextRect, href) then
  begin
    Handled := False;
    Temp := ClientToScreen(Pt);
    DoContextPopup(Temp, Handled);
    Message.Result := Ord(Handled);
    if Handled then Exit;

    DoLinkPopup(ClientToScreen(Pt));
    Message.Result := 1;
  end
  else
    inherited;
end;
{$endif}

procedure TElHTMLView.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
      if HandleAllocated then
        Invalidate;
  end;
end;

procedure TElHTMLView.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
      if HandleAllocated then
        Invalidate;
  end;
end;

procedure TElHTMLView.WMSysColorChange(var Msg: TMessage);
begin
  inherited;
  {$IFDEF OLDELSCROLLBARS}
  PostMessage(FVertScrollBar.Handle, Msg.Msg, Msg.WParam, Msg.LParam);
  PostMessage(FHorzScrollBar.Handle, Msg.Msg, Msg.WParam, Msg.LParam);
  {$ENDIF}
end; { WMSysColorChange }


procedure TElHTMLView.SetViewRect(Value: TRect);
begin
  FViewRect := Value;
  FTextRect := FViewRect;
  InflateRect(FTextRect, -FMargin, 0);
  if HandleAllocated then
  begin
    FRender.PrepareText(Caption, FTextRect.Right - FTextRect.Left, HandleAllocated and WordWrap);
    Invalidate;
  end;
end;

procedure TElHTMLView.SetMargin(Value: Integer);
var R : TRect;
begin
  if FMargin <> Value then
  begin
    FMargin := Value;
    R := FViewRect;
    FViewRect := Rect(0, 0, 0, 0);
    ViewRect := R;
  end;
end;

{$ifdef ELPACK_UNICODE}
procedure TElHTMLView.CMHintShow(var Message: TMessage);
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

procedure TElHTMLView.SetHint(Value: TElFString);
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

{$endif ifdef ELPACK_UNICODE}

procedure TElHTMLView.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder(false, false);
  end;
end;

procedure TElHTMLView.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder(false, false);
  end;
end;

procedure TElHTMLView.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder(false, false);
  end;
end;

procedure TElHTMLView.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder(false, false);
  end;
end;

procedure TElHTMLView.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder(false, false);
  end;
end;


end.
