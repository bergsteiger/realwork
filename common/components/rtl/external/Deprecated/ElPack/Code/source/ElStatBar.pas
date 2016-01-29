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

05/24/2003

  Fixed a problem with drawing a bar in Windows/CLX

02/16/2003

  Control in the last panel with grip enabled covered the grip. Fixed.

12/01/2002

  Fixed gripper drawing with XP themes enabled

11/14/2002

  Changing IsHTML and SimpleTextIsHTML didn't cause repainting. Fixed.

09/22/2002

  Fixed transparency issue when drawing panel text (needed for ImageForm support)

09/19/2002

  Added ImageForm support

04/09/2002

  Added ConvertHintTextW function. It can be used to set statusbar text from application hint

03/28/2002

  Improved drawing of status bar bevels when SimplePanel is false

03/06/2002

  Added unicode hint

12/02/2001

  Fixed vertical alignment of panel text

10/09/2001

  CLX adaptation complete

09/17/2001 (c) Akzhan Abdulin

  Added Windows XP Themes Support. UseXPThemes property added.
  Note that themed statusbar will ignore some its look'n'feel properties.

  Developer note: Size Grip drawn using handmade calculations
  because GetThemePartSize doesn't work for gripper (under research).

08/31/2001 (c) Akzhan Abdulin

  Size grip now drawn correctly after window state changing

07/26/2001

  Added Unicode support

05/27/2001 (c) Akzhan Abdulin

    Fixed Color property design-time storing issue (clWindow not stored)

05/26/2001

   Added HTML support

09/22/2000

   Fixed panel hints showing to be changed when cursor moves to another panel

*)

unit ElStatBar;

interface

uses
  SysUtils,
  Classes,
  {$ifdef ELPACK_USE_IMAGEFORM}
  ElImgFrm,
  {$endif}
  Windows,
  Messages,
  Graphics,
  Forms,
  Controls,
{$ifdef VCL_6_USED}
Types,
{$endif}
  ElXPThemedControl,
  ElUxTheme,
  ElTmSchema,
{$ifdef HAS_HTML_RENDER}
  HTMLRender,
{$endif}
  ElTools,
  ElStrUtils,
  ElList,
  ElIni,
  ElVCLUtils;

type
  TElStatusPanelBevel = (epbLowered, epbNone, epbRaised);
  TElStatusPanelStyle = (epsText, epsControl, epsOwnerDraw);

  TElStatusBar = class;

  TElStatusPanel = class(TCollectionItem)
  private
    FHint: TElFString;
    FAlignment   : TAlignment;
    FBevel       : TElStatusPanelBevel;
    FStyle       : TElStatusPanelStyle;
    FText        : TElFString;
    FWidth       : Integer;
    FControl     : TControl;
    FOldParent   : TWinControl;
    FOldBounds   : TRect;
    FCtlVisible,
    FOldVisible,
    FVisible     : Boolean;
    FOwner       : TElStatusBar;
    FSavedWidth  : Integer;
    FResizable   : Boolean;
    FAutoSize    : Boolean;
{$ifdef HAS_HTML_RENDER}
    FIsHTML      : Boolean;
{$endif}
    procedure SetAutoSize(newValue : Boolean);
    procedure SetVisible(newValue : Boolean);
    procedure SetAlignment(newValue : TAlignment);
    procedure SetBevel(newValue : TElStatusPanelBevel);
    procedure SetStyle(newValue : TElStatusPanelStyle);
    procedure SetText(newValue: TElFString);
    procedure SetWidth(newValue : Integer);
    procedure SetControl(newValue : TControl);
    function GetLeft : Integer;
    function GetRight : Integer;
    function GetPanelRect : TRect;
{$ifdef HAS_HTML_RENDER}
    procedure SetIsHTML(Value: Boolean);
{$endif}
  protected
    procedure SaveWidth;
    procedure RestoreWidth;
    procedure UpdateControl; virtual;
    function  CurWidth : integer;
    function  CalcAutoSize : integer;
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source : TPersistent); override;
    function GetRealWidth: Integer;

    property AutoSize : Boolean read FAutoSize write SetAutoSize;  { Published }
    property Left : Integer read GetLeft;
    property Right : Integer read GetRight;
    property PanelRect : TRect read GetPanelRect;
  published
    property Resizable : Boolean read FResizable write FResizable default true;
    property Alignment : TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property Bevel     : TElStatusPanelBevel read FBevel write SetBevel default epbLowered;
    property Style     : TElStatusPanelStyle read FStyle write SetStyle default epsText;
    property Text      : TElFString read FText write SetText;
    property Width     : Integer read FWidth write SetWidth default 100;
    property Control   : TControl read FControl write SetControl;
    property Visible   : Boolean read FVisible write SetVisible default true;
    property Hint      : TElFString read FHint write FHint;
{$ifdef HAS_HTML_RENDER}
    property IsHTML    : Boolean read FIsHTML write SetIsHTML;
{$endif}
  end;

  TElPanelEvent = procedure(Sender : TObject; Panel : TElStatusPanel) of object;

  TElStatusPanels = class(TCollection)
  private
    FStatusBar : TElStatusBar;
    function GetItems(Index : integer) : TElStatusPanel;
    procedure SetItems(Index : integer; newValue : TElStatusPanel);
  protected
    function GetOwner : TPersistent; override;
    procedure Update(Item : TCollectionItem); override;
  public
    constructor Create(StatusBar : TElStatusBar);
    function Add: TElStatusPanel;
    function LastVisiblePanel: TElStatusPanel;
    property Items[Index : integer] : TElStatusPanel read GetItems write SetItems; default;
  end;

  TElStatusBar = class(TElXPThemedControl)
  private
    FBevel : TElStatusPanelBevel;
    FStorage : TElIniFile;
    FStoragePath : string;
    FResizablePanels : Boolean;
    FPressed : Boolean;
    FHintPanel,
    FPressedPanel,
    FResizePanel : TElStatusPanel;
    FSimpleText : TElFString;
    FSimplePanel : Boolean;
    FSizeGrip : Boolean;
    FOnPanelResize : TElPanelEvent;
    FOnPanelDraw : TElPanelEvent;
    FOnPanelClick : TElPanelEvent;
    FOnPanelDblClick : TElPanelEvent;
{$IFNDEF VCL_4_USED}
    FOnResize : TNotifyEvent;
{$ENDIF}
    FPanels : TElStatusPanels;
    FOldCursor : TCursor;
    FDelta : integer;
    FLine : integer;
    FLineVis : boolean;
    FIgnoreSize : boolean;
{$ifdef HAS_HTML_RENDER}
    FSimpleTextIsHTML: Boolean;
    FRender: TElHTMLRender;
    FOnImageNeeded: TElHTMLImageNeededEvent;
{$endif}
{$ifdef ELPACK_USE_IMAGEFORM}
    FImgFormChLink : TImgFormChangeLink;
    FImgForm: TElImageForm;
{$endif}
    {$ifdef ELPACK_UNICODE}
    FHint: TElFString;
    {$endif}
    procedure SetPanels(Value : TElStatusPanels);
    procedure SetSimpleText(newValue : TElFString);
    procedure SetSimplePanel(newValue : Boolean);
    procedure SetSizeGrip(newValue : Boolean);
    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure ImageFormChange(Sender : TObject);
    procedure SetImageForm(newValue : TElImageForm);
    {$endif}
    procedure WMERASEBKGND(var Msg : TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMLButtonDown(var Msg : TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg : TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure WMMouseMove(var Msg : TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonDblClk(var Msg : TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMNCHitTest(var Message : TWMNCHITTEST); message WM_NCHITTEST;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure CMHintShow(var Msg : TMessage); message CM_HINTSHOW;

    procedure IntHintShow(var HintInfo : THintInfo);
    procedure DrawDragLine(Restore : boolean);
    procedure SetBevel(newValue : TElStatusPanelBevel);
{$ifdef HAS_HTML_RENDER}
    procedure SetSimpleTextIsHTML(Value: Boolean);
{$endif}
  protected
    function GetThemedClassName: WideString; override;

{$IFNDEF VCL_4_USED}
    procedure TriggerResizeEvent; virtual;
{$ENDIF}
    procedure TriggerPanelResizeEvent(Panel : TElStatusPanel); virtual;
    procedure TriggerPanelDrawEvent(Panel : TElStatusPanel); virtual;
    procedure TriggerPanelDblClickEvent(Panel : TElStatusPanel); virtual;
    procedure TriggerPanelClickEvent(Panel : TElStatusPanel); virtual;
    procedure Paint; override;
    procedure DrawPanel(Panel : TElStatusPanel); virtual;
    procedure UpdatePanels; virtual;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    {$ifdef HAS_HTML_RENDER}
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TElFString; var Image
        : TBitmap); virtual;
    {$endif}
    procedure IntLButtonDown(X, Y : integer);
    procedure IntLButtonUp(X, Y : integer);
    procedure IntMouseMove(X, Y : integer);
    procedure InitDragLine;
    procedure DeinitDragLine;
    procedure Resize;
    {$ifdef VCL_4_USED}
    override;
    {$endif}
    {$ifdef ELPACK_UNICODE}
    procedure SetHint(Value: TElFString);
    {$endif}
    procedure Loaded; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
    function PanelAtPoint(Pos : TPoint) : TElStatusPanel; virtual;
    property Canvas;
    procedure Save;
    procedure Restore;
  published
    property Panels : TElStatusPanels read FPanels write SetPanels;
    property SimpleText : TElFString read FSimpleText write SetSimpleText;
    property SimplePanel : Boolean read FSimplePanel write SetSimplePanel default true;
{$ifdef HAS_HTML_RENDER}
    property SimpleTextIsHTML: Boolean read FSimpleTextIsHTML write SetSimpleTextIsHTML;
{$endif}
    property SizeGrip : Boolean read FSizeGrip write SetSizeGrip default true;
    property ResizablePanels : Boolean read FResizablePanels write FResizablePanels;
    property Storage : TElIniFile read FStorage write FStorage;
    property StoragePath : string read FStoragePath write FStoragePath;
    property Bevel : TElStatusPanelBevel read FBevel write SetBevel;  { Published }
{$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm   : TElImageForm read FImgForm write SetImageForm;
{$endif}

    {$ifdef ELPACK_UNICODE}
    property Hint: TElFString read FHint write SetHint;
    {$endif}

    property UseXPThemes;

    property Align;
    property Color nodefault;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnPanelResize : TElPanelEvent read FOnPanelResize write FOnPanelResize;
    property OnPanelDraw : TElPanelEvent read FOnPanelDraw write FOnPanelDraw;
    property OnPanelClick : TElPanelEvent read FOnPanelClick write FOnPanelClick;
    property OnPanelDblClick : TElPanelEvent read FOnPanelDblClick write FOnPanelDblClick;
{$ifdef HAS_HTML_RENDER}
    property OnHTMLImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
{$endif}
{$IFNDEF VCL_4_USED}
    property OnResize : TNotifyEvent read FOnResize write FOnResize;
{$ELSE}

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
{$ENDIF}
{$IFDEF VCL_5_USED}
    property OnContextPopup;
{$ENDIF}

{$IFDEF VCL_4_USED}
    property Anchors;
    property Action;
    property Constraints;
    property DockOrientation;
    property Floating;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;
{$ENDIF}
  end;

{$ifdef ELPACK_UNICODE}
function ConvertHintTextW(Hint : string): WideString;
{$endif}

implementation

const
  hMargin = 2;

{$ifdef ELPACK_UNICODE}
function ConvertHintTextW(Hint : string): WideString;
var S : String;
    i : integer;
begin
  if Length(Hint) < 2 then
    result := Hint
  else
  {if Copy(Hint, Length(Hint) - 1, 2) = #254#255 then
    exit
  else
  }
  if Copy(Hint, Length(Hint) - 1, 2) <> #254#255 then
   Result := GetLongHint(Hint)
  else
  begin
    i := StrLen(PChar(Hint));
    S := Copy(Hint, i + 2, Length(Hint) - i - 4);
    SetLength(Result, (Length(S) - 1) shr 1);
    Move(S[1], Result[1], Length(Result) * 2);
    if WidePos('|', Result) > 0 then
      result := WideCopy(Result, WidePos('|', Result) + 1, Length(Result));
  end;
end;
{$endif}

function TElStatusPanel.CalcAutoSize : integer;
var R : TRect;
begin
  if FOwner.HandleAllocated then
  begin
    SetRectEmpty(R);
    {$ifdef ELPACK_UNICODE}
    ElVCLUtils.DrawTextW(FOwner.Canvas.Handle, PWideChar(FText), -1, R, DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_CALCRECT);
    {$else}
    DrawText(FOwner.Canvas.Handle, PChar(FText), Length(FText), R, DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_CALCRECT);
    {$endif}
    InflateRect(R, 3, 0);
    result := R.Right - R.Left;
      end
  else
    result := Width;
end;

function TElStatusPanel.CurWidth : integer;
begin
  if Visible then
    result := GetRealWidth
  else
    result := 0;
end;

procedure TElStatusPanel.SetAlignment(newValue : TAlignment);
begin
  if (FAlignment <> newValue) then
  begin
    FAlignment := newValue;
    Changed(false);
  end; {if}
end;

procedure TElStatusPanel.SetBevel(newValue : TElStatusPanelBevel);
begin
  if (FBevel <> newValue) then
  begin
    FBevel := newValue;
    Changed(false);
  end; {if}
end;

procedure TElStatusPanel.SetStyle(newValue : TElStatusPanelStyle);
begin
  if (FStyle <> newValue) then
  begin
    FStyle := newValue;
    if FStyle = epsControl then UpdateControl;
    if FAutoSize and (FStyle = epsText) then Width := CalcAutoSize;
    Changed(false);
  end; {if}
end;

procedure TElStatusPanel.SetText(newValue: TElFString);
begin
  if (FText <> newValue) then
  begin
    FText := newValue;
    DisplayName := FText;
    if FAutoSize and (FStyle = epsText) then Width := CalcAutoSize;
    Changed(false);
  end; {if}
end;

procedure TElStatusPanel.SetWidth(newValue : Integer);
begin
  if (FWidth <> newValue) then
  begin
    FWidth := newValue;
    UpdateControl;
    Changed(true);
  end; {if}
end;

procedure TElStatusPanel.SetControl(newValue : TControl);
begin
  if NewValue = FOwner then exit;

  if (FControl <> newValue) then
  begin
    {if csDesigning in FOwner.ComponentState then
    begin
      FControl := newValue;
      FControl.Parent := FOwner;
      UpdateControl;
      exit;
    end;}
    {if FControl <> nil then
    begin
      //FControl.Parent := FOldParent;
      if FControl.Parent <> nil then
      begin
        FControl.BoundsRect := FOldBounds;
        FControl.Visible := FOldVisible;
      end;
    end;
    }
    {$ifdef VCL_5_USED}
    if FControl <> nil then
    begin
      if not (csDestroying in FControl.ComponentState) then
        FControl.RemoveFreeNotification(FOwner);
      if (FOldParent <> nil) then
        if not (csDestroying in FOldParent.ComponentState) then
          FOldParent.RemoveFreeNotification(FOwner);
    end;
    {$endif}
    FControl := newValue;
    if FControl <> nil then
    begin
      //FOldParent := FControl.Parent;
      FOldBounds := FControl.BoundsRect;
      FOldVisible := FControl.Visible;
      FCtlVisible := FControl.Visible;
      if FControl.Parent <> FOwner then
      begin
        FControl.Parent := FOwner;
        if FOldParent <> nil then
          FOldParent.FreeNotification(FOwner);
        FControl.FreeNotification(FOwner);
      end
      else
        FOldParent := nil;

      FOwner.FIgnoreSize := true;
      UpdateControl;
      FOwner.FIgnoreSize := false;
    end;
  end; {if}
end;

function TElStatusPanel.GetLeft : Integer;
begin
  if Index = 0 then
    result := 0
  else
  begin
    if Visible then
      result := TElStatusPanel(Collection.Items[Index - 1]).Right + hMargin
    else
      result := TElStatusPanel(Collection.Items[Index - 1]).Right;
  end;
end;

function TElStatusPanel.GetRight : Integer;
begin
  if Index = 0 then
    result := CurWidth
  else
    result := Left + CurWidth;
end;

procedure TElStatusPanel.Assign(Source : TPersistent);
begin
  if Source is TElStatusPanel then
    with TElStatusPanel(Source) do
    begin
      Self.FText := Text;
      Self.FWidth := Width;
      Self.FSavedWidth := FSavedWidth;
      Self.FAlignment := Alignment;
      Self.FBevel := Bevel;
      Self.FStyle := Style;
      Self.Control := Control;
      Self.FVisible := Visible;
    end
  else
    inherited Assign(Source);
end;

procedure TElStatusPanel.SetVisible(newValue : Boolean);
begin
  if (FVisible <> newValue) then
  begin
    FVisible := newValue;
    UpdateControl;
    Changed(true);
  end; {if}
end;

procedure TElStatusPanel.UpdateControl;
var
  R : TRect;
  {$ifndef MSWINDOWS}
  AVal : TSize;
  {$endif}
begin
  //if (csLoading in FOwner.ComponentState) then exit;
  if (FControl <> nil) and not (csDesigning in FOwner.ComponentState) then
  begin
    if FStyle <> epsControl then
      FControl.Visible := false;
      //FControl.Visible := FCtlVisible
  end;
  R := PanelRect;
  if FBevel <> epbNone then
    InflateRect(R, -2, -2);
  if (FControl <> nil) then
  begin
    {$ifndef MSWINDOWS}
    QStyle_scrollBarExtent(Application.Style.Handle, @AVal);
    {$endif}
    if (TElStatusPanels(Collection).FStatusBar.SizeGrip) and (Self = TElStatusPanels(Collection).LastVisiblePanel) then
      R.Right := R.Right - {$ifdef MSWINDOWS}GetSystemMetrics(SM_CXVSCROLL){$else}AVal.cx{$endif} - 1;
    FControl.BoundsRect := R;
    FControl.Visible := (not FOwner.SimplePanel) and Visible;
  end;
end;

function TElStatusPanel.GetPanelRect : TRect;
var
  R : TRect;
  i : integer;
begin
  i := Left;
  R := Rect(i, 0, i + CurWidth, TElStatusPanels(Collection).FStatusBar.ClientHeight);
  if TElStatusPanels(Collection).FStatusBar.Bevel <> epbNone then
     InflateRect(R, -2, -2);
  result := R;
end;

procedure TElStatusPanel.SaveWidth;
begin
  if FSavedWidth <> FWidth then
    FSavedWidth := FWidth;
end;

procedure TElStatusPanel.RestoreWidth;
begin
  FWidth := FSavedWidth;
end;

{$ifdef HAS_HTML_RENDER}
procedure TElStatusPanel.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    Changed(false);
  end;
end;
{$endif}

procedure TElStatusPanel.SetAutoSize(newValue : Boolean);
begin
  if (FAutoSize <> newValue) then
  begin
    FAutoSize := newValue;
    if FAutoSize and (FStyle = epsText) then Width := CalcAutoSize;
    Changed(false);
  end;  { if }
end;  { SetAutoSize }

constructor TElStatusPanel.Create(Collection : TCollection);
begin
  FWidth := 100;
  FSavedWidth := -1;
  inherited;
  FAlignment := taLeftJustify;
  FBevel := epbLowered;
  FStyle := epsText;
  FVisible := true;
  FOwner := TElStatusPanels(Collection).FStatusBar;
  FResizable := true;
end;

destructor TElStatusPanel.Destroy;
begin
  Control := nil;
  inherited;
end;

function TElStatusPanel.GetRealWidth : Integer;
var b : boolean;
    i : integer;
begin
  b := true;
  for i := Index + 1 to Collection.Count - 1 do
    if TElStatusPanel(Collection.Items[i]).Visible then
      b := false;
  if b then
  begin
    if FOwner.Bevel <> epbNone then
      Result := FOwner.ClientWidth - Left - 2
    else
      Result := FOwner.ClientWidth - Left;
  end
  else
    Result := FWidth;
end;

function TElStatusPanels.GetItems(Index : integer) : TElStatusPanel;
begin
  result := TElStatusPanel(inherited GetItem(Index));
end;

procedure TElStatusPanels.SetItems(Index : integer; newValue : TElStatusPanel);
begin
  inherited SetItem(Index, newValue);
end;

constructor TElStatusPanels.Create(StatusBar : TElStatusBar);
begin
  inherited Create(TElStatusPanel);
  FStatusBar := StatusBar;
end;

function TElStatusPanels.Add: TElStatusPanel;
begin
  result := TElStatusPanel(inherited Add);
  Result.FOwner := FStatusBar;
  Update(Result);
end;

function TElStatusPanels.GetOwner : TPersistent;
begin
  result := FStatusBar;
end;

procedure TElStatusPanels.Update(Item : TCollectionItem);
var
  R : TRect;
  i : integer;
begin
  inherited;
  FStatusBar.UpdatePanels;
  if Item = nil then
  begin
    for i := 0 to Count - 1 do
      if Items[i].FStyle = epsControl then
        Items[i].UpdateControl;
    FStatusBar.Repaint;
    exit;
  end;
  R := TElStatusPanel(Item).PanelRect;
  InvalidateRect(FStatusBar.Handle, @R, false);
  FStatusBar.Update;
end;

function TElStatusPanels.LastVisiblePanel: TElStatusPanel;
var i : integer;
begin
  for i := Count - 1 downto 0 do
    if Items[i].Visible then
    begin
      result := Items[i];
      exit;
    end;
  Result := nil;
end;

procedure TElStatusBar.SetPanels;
begin
  FPanels.Assign(Value);
end;

procedure TElStatusBar.SetSimpleText(newValue : TElFString);
begin
  if (FSimpleText <> newValue) then
  begin
    FSimpleText := newValue;
    Invalidate;
  end; {if}
end;

procedure TElStatusBar.SetSimplePanel(newValue : Boolean);
var i : integer;
begin
  if (FSimplePanel <> newValue) then
  begin
    FSimplePanel := newValue;
    if Panels.Count = 0 then
      FSimplePanel := true;
    for i := 0 to Panels.Count - 1 do
    begin
      if Panels[i].Control <> nil then
        Panels[i].Control.Visible := (not simplePanel) and
                                     (Panels[i].Style = epsControl);
    end;
    Invalidate;
  end; {if}
end;

procedure TElStatusBar.SetSizeGrip(newValue : Boolean);
var
  b : boolean;
  i : integer;
begin
  if (FSizeGrip <> newValue) then
  begin
    if NewValue then
    begin
      if Parent <> nil then
      begin
        if not (Parent is TForm) then exit;
        b := false;
        for i := 0 to Parent.ControlCount - 1 do
        begin
          if (Parent.Controls[i] = Self) then b := true;
          if b and (Parent.Controls[i] is TElStatusBar) and (Parent.Controls[i] <> Self) then exit;
        end;
      end;
    end;
    FSizeGrip := newValue;
    Invalidate;
  end; {if}
end;

procedure TElStatusBar.Paint;
var
  i : integer;
  R : TRect;
  RClip: TRect;
  c : integer;
  f: TCustomForm;
  {$ifdef ELPACK_USE_IMAGEFORM}
  ACtl  : TWinControl;
  {$endif}
  APanel : TElStatusPanel;
  {$ifdef MSWINDOWS}
  iPartId: Integer;
  ws: WideString;
  {$endif}
  {$ifdef ELPACK_USE_IMAGEFORM}
  BgRect : TRect;
  {$endif}
  lc,
  dc : TColor;
  {$ifdef ELPACK_USE_IMAGEFORM}
  imfk : boolean;
  {$endif}
//  sz: TSize;
  Bitmap :TBitmap;
  DH :HDC;
begin
  Bitmap := TBitmap.Create;
try
  R := ClientRect;
  with R do
  begin
    Bitmap.Width := Right - Left +1;
    Bitmap.Height := Bottom - Top +1;
  end;

  DH := Canvas.Handle;
  Canvas.Handle := Bitmap.Canvas.Handle;
try
  {$ifdef ELPACK_USE_IMAGEFORM}
  imfk := false;
  {$endif}
  Canvas.Brush.Color := Color;
  RClip := Canvas.ClipRect;
  IntersectRect(RClip, Canvas.ClipRect, ClientRect);

{$ifdef LINUX}
  Canvas.Brush.Style := bsSolid;
{$endif}
  Canvas.FillRect(RClip);
  R := ClientRect;
  {$ifdef ELPACK_USE_IMAGEFORM}
  if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
  begin
    if (FImgForm.Control <> Self) then
    begin
      ACtl := FImgForm.GetRealControl;
      BgRect := R;
      //  OffsetRect(BgRect, -Section.Left + FHPos, 0);
      BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
      BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
      BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
      FImgForm.PaintBkgnd(Canvas.Handle, R, BgRect.TopLeft, false);
      imfk := true;
    end;
  end;
  {$endif}

  {$ifdef MSWINDOWS}
  if IsThemeApplied() then
  begin
    iPartId := 0;
    {$ifdef ELPACK_USE_IMAGEFORM}
    if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
    begin
    end
    else
    {$endif}
    begin
      DrawThemeBackground(Theme, Canvas.Handle, iPartId, 0, R, @RClip);
      GetThemeBackgroundContentRect(Theme, Canvas.Handle, SP_PANE, 0, R, R);
    end;
    if not IsRectEmpty(R) then
    begin
      if FSimplePanel then
      begin
        Canvas.Brush.Style := bsClear;
        {$ifdef HAS_HTML_RENDER}
        if SimpleTextIsHTML then
        begin
          FRender.Data.DefaultColor := Font.Color;
          FRender.Data.DefaultBgColor := clNone;
          FRender.Data.DefaultStyle := Font.Style;
          FRender.Data.DefaultHeight := Font.Height;
          FRender.Data.DefaultFont := Font.Name;
          FRender.Data.Charset := Font.Charset;

          FRender.PrepareText(SimpleText, 0, false);
          FRender.DrawText(Canvas, Point(0, 0), R, clNone);
        end
        else
        {$endif}
        begin
          ws := SimpleText;
          if ws <> '' then
            DrawThemeText(Theme, Canvas.Handle, iPartId, 0, PWideChar(ws), Length(ws), DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE, 0, R);
        end;
      end
      else
        for i := 0 to FPanels.Count - 1 do
        begin
          R := FPanels[i].PanelRect;
          if IntersectRect(R, R, RClip) then
            DrawPanel(FPanels.Items[i]);
        end;
    end;
  end
  else
  {$endif}
  begin
    {$ifdef ELPACK_USE_IMAGEFORM}
    if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
    begin
    end
    else
    {$endif}
      Canvas.FillRect(RClip);

    Canvas.Font.Assign(Font);
    if not SimplePanel then
    {.$ifndef CLX_USED}
    case Bevel of
      epbRaised:
        begin
          DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER or BDR_RAISEDOUTER, BF_TOPLEFT);
          DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
        end;
      epbLowered:
        begin
          DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_TOPLEFT);
          DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER or BDR_SUNKENINNER, BF_BOTTOMRIGHT);
        end;
      epbNone:
        InflateRect(R, 1, 1);
    end;
    {.$else}
    (*
    case Bevel of
      epbRaised:
        DrawEdge(Canvas, R, esRaised, esNone, [ebTop, ebLeft, ebRight, ebBottom]);
      epbLowered:
        DrawEdge(Canvas, R, esLowered, esNone, [ebTop, ebLeft, ebRight, ebBottom]);
      epbNone:
        InflateRect(R, 1, 1);
    end;
    *)
    {.$endif}
    InflateRect(R, -2, -2);
    if FSimplePanel then
    begin
      R := ClientRect;
      {.$ifndef CLX_USED}
      DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_TOPLEFT);
      DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER or BDR_SUNKENINNER, BF_BOTTOMRIGHT);
      {.$else}
      (*
      DrawEdge(Canvas, R, esNone, esLowered, [ebTop, ebLeft]);
      DrawEdge(Canvas, R, esLowered, esLowered, [ebRight, ebBottom]);
      *)
      {.$endif}
      InflateRect(R, -1, -1);
      Inc(R.Top, 2);
  {$ifdef HAS_HTML_RENDER}
      if SimpleTextIsHTML then
      begin
        FRender.Data.DefaultColor := Font.Color;
        FRender.Data.DefaultBgColor := Color;
        FRender.Data.DefaultStyle := Font.Style;
        FRender.Data.DefaultHeight := Font.Height;
        FRender.Data.DefaultFont := Font.Name;
        FRender.Data.Charset := Font.Charset;

        FRender.PrepareText(SimpleText, 0, false);
        FRender.DrawText(Canvas, Point(0, 0), R, clNone);
      end
      else
    {$endif}
      begin
        {$ifdef ELPACK_UNICODE}
          ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(SimpleText), -1, R, DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);
        {$else}
          DrawText(Canvas.Handle, PChar(SimpleText), Length(SimpleText), R, DT_LEFT or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE or DT_NOCLIP);
        {$endif}
      end;
    end
    else
    begin
      for i := 0 to FPanels.Count - 1 do
      begin
        R := FPanels[i].PanelRect;
        if IntersectRect(R, R, RClip) then
          DrawPanel(FPanels.Items[i]);
      end;
    end;
  end;
  if FSizeGrip then
  begin
    F := GetParentForm(Self);
    if (TForm(F).BorderStyle in [bsSizeable, bsSizeToolWin]) and
      not IsZoomed(f.Handle) then
    begin
      {$ifdef MSWINDOWS}
      if IsThemeApplied() then
      begin
        R := ClientRect;
        R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL) - 1;
        dec(R.Bottom);
        dec(R.Right);
        if not IsRectEmpty(R) then
        begin
          DrawThemeBackground(Theme, Canvas.Handle, SP_GRIPPER, 0, R, @RClip);
        end;
      end
      else
      {$endif}
      begin
        if FSimplePanel then
        begin
          R := ClientRect;
          InflateRect(R, -2, -2);
        end
        else
        begin
          APanel := Panels.LastVisiblePanel;
          if APanel = nil then
            R := ClientRect
          else
          begin
            R := APanel.PanelRect;
            if APanel.Bevel <> epbNone then InflateRect(R, -2, -2);
          end;
        end;
        C := R.Bottom - R.Top + 2;
        R.Left := R.Right - C;
        R.Top := R.Bottom - C;
        if (Color = clBtnFace)
        {$ifdef ELPACK_USE_IMAGEFORM}
        and not imfk
        {$endif}
        then
        begin
          inc(R.Top);
          DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP)
        end
        else
        begin
          i := 4;
          C := R.Bottom - R.Top + 1;

          dec(R.Top, 2);
          dec(R.Bottom);
          if Color = clBtnFace then
            lc := clBtnHighlight
          else
            lc := ColorLighter(ColorToRGB(Color), 50);
          if Color = clBtnFace then
            dc := clBtnHighlight
          else
            dc := ColorDarker(ColorToRGB(Color), 50);


          while true do
          begin
            R.Left := R.Right - C + i;
            R.Top := R.Bottom - C + i;
            Canvas.Pen.Color := lc;
            Canvas.MoveTo(R.Left, R.Bottom);
            Canvas.LineTo(R.Right, R.Top);
            Inc(R.Left);
            Inc(R.Top);
            Canvas.Pen.Color := dc;
            Canvas.MoveTo(R.Left, R.Bottom);
            Canvas.LineTo(R.Right, R.Top);
            Inc(R.Left);
            Inc(R.Top);
            Canvas.Pen.Color := dc;
            Canvas.MoveTo(R.Left, R.Bottom);
            Canvas.LineTo(R.Right, R.Top);
            inc(i, 4);
            if i >= c then break;
          end;
        end;
      end;
    end;
  end;
finally
  Canvas.Handle := DH;
end;
  R := ClientRect;
  with R do
    Canvas.Draw(Left, Top, Bitmap);
finally
  Bitmap.Free;
end;

end;

procedure TElStatusBar.TriggerPanelResizeEvent(Panel : TElStatusPanel);
begin
  if (assigned(FOnPanelResize)) then
    FOnPanelResize(Self, Panel);
end;

procedure TElStatusBar.TriggerPanelDrawEvent(Panel : TElStatusPanel);
begin
  if (assigned(FOnPanelDraw)) then
    FOnPanelDraw(Self, Panel);
end;

procedure TElStatusBar.DrawPanel(Panel : TElStatusPanel);
var
  R : TRect;
  RClip: TRect;
  AL : integer;
  {$ifdef MSWINDOWS}
  ws: WideString;
  {$endif}
  sp: integer;
  F : TCustomForm;

begin
  R := Panel.PanelRect;
  RClip := Canvas.ClipRect;
  if not IsRectEmpty(R) then
  begin
    {$ifdef MSWINDOWS}
    if IsThemeApplied() then
    begin
      {$ifdef ELPACK_USE_IMAGEFORM}
      if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
      begin
      end
      else
      {$endif}
      begin
        sp := SP_PANE;
        if FSizeGrip then
        begin
          F := GetParentForm(Self);
          if (TForm(F).BorderStyle in [bsSizeable, bsSizeToolWin]) and
            not IsZoomed(f.Handle) then
          begin
            if Panel = Panels.LastVisiblePanel then
             sp := SP_GRIPPERPANE;
          end;
        end;
        DrawThemeBackground(Theme, Canvas.Handle, sp, 0, R, @RClip);
        GetThemeBackgroundContentRect(Theme, Canvas.Handle, sp, 0, R, R);
      end;
    end
    else
    {$endif}
    begin
      if Panel.FBevel = epbLowered then
      begin
        {.$ifndef CLX_USED}
        DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_TOPLEFT);
        DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER or BDR_SUNKENINNER, BF_BOTTOMRIGHT);
        {.$else}
        (*
        DrawEdge(Canvas, R, esNone, esLowered, [ebTop, ebLeft]);
        DrawEdge(Canvas, R, esNone, esLowered, [ebRight, ebBottom]);
        *)
        {.$endif}
      end
      else
      if Panel.FBevel = epbRaised then
      begin
        {.$ifndef CLX_USED}
        DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER or BDR_RAISEDOUTER, BF_TOPLEFT);
        DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
        {.$else}
        //DrawEdge(Canvas, R, esRaised, esNone{ esRaised}, [ebTop, ebLeft]);
        //DrawEdge(Canvas, R, esRaised, esNone, [ebRight, ebBottom]);
        {.$endif}
      end;
      InflateRect(R, -2, -2);
    end;
    if Panel.FStyle = epsOwnerDraw then
      TriggerPanelDrawEvent(Panel)
    else
    if Panel.Style = epsText then
    begin
      InflateRect(R, -1, 0);
        if IsRectEmpty(R) then Exit;
      case Panel.FAlignment of
        taCenter : AL := DT_CENTER;
        taRightJustify : AL := DT_RIGHT;
      else
        AL := DT_LEFT;
      end;

      {$ifdef HAS_HTML_RENDER}
      if Panel.IsHTML then
      begin
        FRender.Data.DefaultColor := Font.Color;
        FRender.Data.DefaultBgColor := clNone;
        FRender.Data.DefaultStyle := Font.Style;
        FRender.Data.DefaultHeight := Font.Height;
        FRender.Data.DefaultFont := Font.Name;
        FRender.Data.Charset := Font.Charset;

        FRender.PrepareText(Panel.Text, 0, false);
        FRender.DrawText(Canvas, Point(0, 0), R, clNone);
      end
      else
      {$endif}
      {$ifdef MSWINDOWS}
      if IsThemeApplied() then
      begin
        Canvas.Brush.Style := bsClear;
        ws := Panel.Text;
        if ws <> '' then
          DrawThemeText(Theme, Canvas.Handle, SP_PANE, 0, PWideChar(ws), -1, AL or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE, 0, R);
      end
      else
      {$endif}
      begin
        Canvas.Brush.Style := bsClear;
        {$ifdef ELPACK_UNICODE}
          ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Panel.Text), -1, R, AL or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);
        {$else}
          DrawText(Canvas.Handle, PChar(Panel.Text), Length(Panel.Text), R, AL or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE);
        {$endif}
      end;
    end;
  end;
end;

procedure TElStatusBar.UpdatePanels;
var i : integer;
begin
  if FPanels.Count = 0 then
    SimplePanel := true;
  for i := 0 to Panels.Count - 1 do
    Panels[i].UpdateControl;
  Invalidate;
end;

procedure TElStatusBar.Notification(AComponent : TComponent; Operation :
  TOperation);
var
  i : integer;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent is TControl) then
  begin
    for i := 0 to FPanels.Count - 1 do
    begin
      if Panels[i].Control = AComponent then Panels[i].Control := nil;
      if Panels[i].FOldParent = AComponent then Panels[i].FOldParent := nil;
    end;
  end;
end;

procedure TElStatusBar.WMERASEBKGND(var Msg : TWMEraseBkgnd);
begin
  Msg.Result := 1;
end;

procedure TElStatusBar.WMLButtonDown(var Msg : TWMLButtonDown);
begin
  inherited;
  IntLButtonDown(Msg.XPos, Msg.YPos);
end;

procedure TElStatusBar.WMLButtonUp(var Msg : TWMLButtonUp);
begin
  inherited;
  IntLButtonUp(Msg.XPos, Msg.YPos);
end;

function TElStatusBar.PanelAtPoint(Pos : TPoint) : TElStatusPanel;
var
  i : integer;
  P : TElStatusPanel;
begin
  result := nil;
  if SimplePanel then exit;
  for i := 0 to Panels.Count - 1 do
  begin
    P := Panels[i];
    if (P.Visible) and (P.Left <= Pos.X) and (P.Right >= Pos.X) then
    begin
      result := P;
      exit;
    end;
  end;
end;

{$IFNDEF VCL_4_USED}

procedure TElStatusBar.TriggerResizeEvent;
begin
  if (assigned(FOnResize)) then
    FOnResize(Self);
end;
{$ENDIF}

procedure TElStatusBar.WMSize(var Msg : TWMSize);
begin
  inherited;
  if not ((csLoading in ComponentState) or FIgnoreSize) then
    UpdatePanels;
{$IFNDEF VCL_4_USED}
  TriggerResizeEvent;
{$ENDIF}
//  Invalidate;
end;

procedure TElStatusBar.TriggerPanelClickEvent(Panel : TElStatusPanel);
begin
  if (assigned(FOnPanelClick)) then FOnPanelClick(Self, Panel);
end;

procedure TElStatusBar.TriggerPanelDblClickEvent(Panel : TElStatusPanel);
begin
  if (assigned(FOnPanelDblClick)) then FOnPanelDblClick(Self, Panel);
end;

procedure TElStatusBar.WMMouseMove(var Msg : TWMMouseMove);
begin
  inherited;
  IntMouseMove(Msg.XPos, Msg.YPos);
end;

procedure TElStatusBar.DrawDragLine;
begin
  FLineVis := not FLineVis;
  PatBlt(Canvas.Handle, FLine, 0, 1, Height, PATINVERT);
end;

procedure TElStatusBar.WMLButtonDblClk(var Msg : TWMLButtonDblClk);
begin
  inherited;
  TriggerPanelDblClickEvent(PanelAtPoint(Point(Msg.XPos, Msg.YPos)));
end;

procedure TElStatusBar.WMNCHitTest;
var
  P : TPoint;

  function InGrip(Point : TPoint) : boolean;
  var
    r : TRect;
  begin
    R := ClientRect;
    R.Left := R.Right - R.Bottom + hMargin;
    result := PtInRect(R, Point);
  end;

begin
  if not FSizeGrip then
  begin
    inherited;
    exit;
  end;
  P := ScreenToClient(Point(Message.XPos, Message.YPos));
  if InGrip(P) and (TForm(Parent).WindowState = wsNormal)
    and (TForm(Parent).BorderStyle in [bsSizeable, bsSizeToolWin]) then
    Message.Result := HTBOTTOMRIGHT
  else
    inherited;
end;

procedure TElStatusBar.Save;
var
  SaveKey, CKey : string;
  i : integer;
begin
  if Assigned(FStorage) then
  begin
    SaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(StoragePath + FStorage.Delimiter + 'ElStatusBar', true) then
    begin
      for i := 0 to FPanels.Count - 1 do // Iterate
      begin
        CKey := 'Panel' + IntToStr(i);
        FStorage.WriteBool(CKey, 'Visible', Panels[i].Visible);
        FStorage.WriteInteger(CKey, 'Width', Panels[i].Width);
      end; // for
      FStorage.OpenKey(SaveKey, false);
    end;
  end;
end; {Save}

procedure TElStatusBar.Restore;
var
  SaveKey, CKey : string;
  i, j : integer;
  b : boolean;
begin
  if Assigned(FStorage) then
  begin
    SaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(StoragePath + FStorage.Delimiter + 'ElStatusBar', false) then
    begin
      for i := 0 to FPanels.Count - 1 do // Iterate
      begin
        CKey := 'Panel' + IntToStr(i);
        if FStorage.ReadBool(CKey, 'Visible', true, b) then Panels[i].Visible := b;
        if FStorage.ReadInteger(CKey, 'Width', 100, j) then Panels[i].Width := j;
      end; // for
      FStorage.OpenKey(SaveKey, false);
    end;
  end;
end; {Restore}

procedure TElStatusBar.CMMouseLeave(var Msg : TMessage);
begin
  inherited;
  if (Msg.LParam = 0) or (Msg.LParam = Integer(Self)) then
  begin
    if (Screen.Cursor = crHSplit) and (not FPressed) then Screen.Cursor := FOldCursor;
    FHintPanel := nil;
  end;
end; {CMMouseLeave}

procedure TElStatusBar.CMHintShow(var Msg : TMessage);  { private }
begin
  inherited;
  IntHintShow(PHintInfo(Msg.lParam)^);
end;  { CMHintInfo }

procedure TElStatusBar.SetBevel(newValue : TElStatusPanelBevel);
{ Sets data member FBevel to newValue. }
begin
  if (FBevel <> newValue) then
  begin
    FBevel := newValue;
  end;  { if }
end;  { SetBevel }

destructor TElStatusBar.Destroy;
begin
{$ifdef HAS_HTML_RENDER}
  FRender.Free;
  FRender := nil;
{$endif}
  {$ifdef ELPACK_USE_IMAGEFORM}
  ImageForm := nil;
  FImgFormChLink.Free;
  FImgFormChLink := nil;
  {$endif}
  inherited;
  FPanels.Free;
end;

constructor TElStatusBar.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  ControlStyle :=
    [csClickEvents, {csOpaque, }csDoubleClicks,
     csReplicatable, csAcceptsControls , csReflector];
  Color := clBtnFace;
  PInteger(@Font.Color)^ := clBtnText;
  Height := 19;
  Align := alBottom;
  FPanels := TElStatusPanels.Create(Self);
  FSimplePanel := true;
  FSizeGrip := True;
  Bevel := epbNone;
{$ifdef HAS_HTML_RENDER}
  FRender := TElHTMLRender.Create;
  FRender.OnImageNeeded := TriggerImageNeededEvent;
{$endif}
{$ifdef ELPACK_USE_IMAGEFORM}
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
{$endif}
end;

{$ifdef HAS_HTML_RENDER}
procedure TElStatusBar.SetSimpleTextIsHTML(Value: Boolean);
begin
  if FSimpleTextIsHTML <> Value then
  begin
    FSimpleTextIsHTML := Value;
    Invalidate;
  end;
end;

procedure TElStatusBar.TriggerImageNeededEvent(Sender : TObject; Src :
    TElFString; var Image : TBitmap);
begin
  if (assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src , Image );
end;  { TriggerImageNeededEvent }
{$endif}

function TElStatusBar.GetThemedClassName: WideString;
begin
  Result := 'STATUS';
end;

procedure TElStatusBar.IntHintShow(var HintInfo : THintInfo);
var
  Panel : TElStatusPanel;

  {$ifdef ELPACK_UNICODE}
  T: WideChar;
  WS: WideString;
  l : integer;
  S : String;
  {$endif}

begin
  Panel := PanelAtPoint(HintInfo.CursorPos);
  if (Panel <> nil) and (Panel.Hint <> '') then
    HintInfo.HintStr := Panel.Hint;
  FHintPanel := Panel;

  {$ifdef ELPACK_UNICODE}
  if (Panel <> nil) and (Panel.Hint <> '') then
    WS := Panel.Hint
  else
    WS := FHint;

  if Length(WS) = 0 then
  begin
    HintInfo.hintStr := '';
    exit;
  end;

  if HintInfo.HintStr = GetShortHint(inherited Hint) then
  begin
    WS := GetShortHintW(WS);
    S := WS;
  end
  else
    S := WS;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
  {$endif}
end;

procedure TElStatusBar.IntLButtonDown(X, Y : integer);
var
  P : TElStatusPanel;
  i : integer;
begin
  P := PanelAtPoint(Point(X, Y));
  FPressed := true;
  FPressedPanel := P;
  SetCapture(Handle);

  if (P = nil) and (not SimplePanel) and FResizablePanels then
  begin
    FResizePanel := nil;
    for i := 0 to Panels.Count - 1 do
      if Panels[i].Visible and (Panels[i].Right < X) then
        FResizePanel := Panels[i];
    if (FResizePanel <> nil) and (FResizePanel.FResizable) then
    begin
      FLine := FResizePanel.Right;
      FDelta := X - FLine;
      InitDragLine;
      DrawDragLine(false);
    end
    else
      FResizePanel := nil;
  end;
end;

procedure TElStatusBar.IntLButtonUp(X, Y : integer);
begin
  ReleaseCapture;

  if (FPressedPanel <> nil) and (FResizePanel = nil) then
    TriggerPanelClickEvent(FPressedPanel)
  else
  begin
    if Screen.Cursor = crHSplit then Screen.Cursor := FOldCursor;
    if (FResizePanel = nil) then
      if Assigned(OnClick) then OnClick(Self);
  end;
  if FResizePanel <> nil then
  begin
    DrawDragLine(true);
    FResizePanel.Width := FLine - FResizePanel.Left;
    Self.TriggerPanelResizeEvent(FResizePanel);
    DeinitDragLine;
  end;
  FResizePanel := nil;
  FPressed := false;
end;

procedure TElStatusBar.IntMouseMove(X, Y : integer);
var Panel : TElStatusPanel;
    AMsg  : TMessage;
begin
  if (FResizePanel <> nil) then
  begin
    if (X - FDelta >= FResizePanel.Left) then
    begin
      DrawDragLine(true);
      FLine := X - FDelta;
      DrawDragLine(false);
    end;
  end;
  if (not FPressed) then
  begin
    Panel := PanelAtPoint(Point(X, Y));
    if (FHintPanel <> nil) and (FHintPanel <> Panel) and (Panel <> nil) and
        ShowHint and (Panel.Hint <> '') then
    begin
      ZeroMemory(@AMsg, sizeof(AMsg));
      TWMMouse(AMsg).XPos := -10000;
      TWMMouse(AMsg).YPos := -10000;
      TWMMouse(AMsg).Msg  := WM_MOUSEMOVE;
      TWMMouse(AMsg).Keys := 0;
      TWMMouse(AMsg).Result := 0;
      Application.HintMouseMessage(Self, AMsg);
      TWMMouse(AMsg).Pos := SmallPoint(X, Y);
      Application.HintMouseMessage(Self, AMsg);
    end;
  end;

  if (not FPressed)
    and (not FSimplePanel)
    and FResizablePanels
    and (PanelAtPoint(Point(X, Y)) = nil)
    and (not (csDesigning in ComponentState)) then
  begin
    if Screen.Cursor <> crHSplit then
    begin
      FOldCursor := Screen.Cursor;
      Screen.Cursor := crHSplit;
    end
  end
  else
  if (not FPressed) and (Screen.Cursor = crHSplit) then
    Screen.Cursor := FOldCursor;
end;



procedure TElStatusBar.InitDragLine;
begin
end;

procedure TElStatusBar.DeinitDragLine;
begin
end;

procedure TElStatusBar.Resize;
begin
  Inherited;
end;


{$ifdef ELPACK_UNICODE}
procedure TElStatusBar.SetHint(Value: TElFString);
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

{$ifdef ELPACK_USE_IMAGEFORM}
procedure TElStatusBar.ImageFormChange(Sender : TObject);
begin
  if (HandleAllocated) then
    Invalidate;
end;

procedure TElStatusBar.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      {$ifdef VCL_5_USED}
      FImgForm.RemoveFreeNotification(Self);
      {$endif}
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then
    begin
      FImgForm.RegisterChanges(FImgFormChLink);
      FImgForm.FreeNotification(Self);
    end;
    if HandleAllocated and (not (csDestroying in ComponentState)) then
    begin
      RecreateWnd;
      Perform(CM_COLORCHANGED, 0, 0);
    end;
  end;
end;
{$endif}

procedure TElStatusBar.Loaded;
begin
  inherited;
  UpdatePanels;
end;

end.
