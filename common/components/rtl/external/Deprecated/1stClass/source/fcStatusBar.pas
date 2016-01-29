unit fcStatusBar;
{
//
// Components : TfcStatusBar
//
// Copyright (c) 1999 by Woll2Woll Software
}
// 10/12/98 - Handle disabling of images for the glyphs style
// 10/12/98 - Occasional flicker as time changes.
// 4/17/99 - Renamed imagelist to images
// 4/26/99 - PYW - Only shrink width if last panel and sizegrip is true.
// 4/26/99 - PYW - Show sizegrip only if sizeable window.
// 4/27/99 - PYW - Update Timer for time styles to 1000.
// 5/06/99 - PYW - Added StatusBarText property.
// 5/27/99 - RSW - Don't use StatusBar Canvas, but use StatusPanel Canvas
// 7/11/99 - Clear StatusBars static variable so that if referenced for
//           some reason later in in destructor it would not cause an exception
interface

{$i fcIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CommCtrl, Menus, Richedit, StdCtrls, fcCollection,
  fcCommon, fcText, ComCtrls{$ifdef fcDelphi4Up}, ImgList{$endif};

const
  TIMER_ID = 200;
  HINT_TIMER_ID = 300;
  RICHEDIT_TIMER_ID = 400;

type
  TfcCustomStatusBar = class;

  // 5/06/99 - PYW - Added StatusBarText property.
  TfcStatusBarText = class(TPersistent)
  private
     FOwner : TfcCustomStatusBar;
     FCapsLock: string;
     FOverwrite: string;
     FNumLock: string;
     FScrollLock: string;
     procedure SetCapsLock(Value:String);
     procedure SetOverwrite(Value:String);
     procedure SetNumLock(Value:String);
     procedure SetScrollLock(Value:String);
  public
     constructor Create(AOwner: TfcCustomStatusBar);
  published
     property CapsLock: string read FCapsLock write SetCapsLock;
     property Overwrite: string read FOverwrite write SetOverwrite;
     property NumLock: string read FNumLock write SetNumLock;
     property ScrollLock: string read FScrollLock write SetScrollLock;
  end;

  TfcStatusPanels = class;
  TfcStatusPanel = class;
  TfcCustomStatusBarClass = class of TfcCustomStatusBar;
  TfcStatusPanelsClass = class of TfcStatusPanels;
  TfcStatusPanelClass = class of TfcStatusPanel;

  TfcStatusPanelStyle = (psTextOnly, psControl, psOverWrite, psCapsLock,
                         psNumLock, psDateTime, psDate, psTime, psGlyph,
                         psRichEditStatus, psHint, psUserName, psComputerName, psScrollLock);

  TfcStatusPanelBevel = (pbNone, pbLowered, pbRaised);

  TfcPanelTextChangedEvent = procedure(Sender: TObject; const Text: string) of object;
  TfcDrawTextEvent = procedure(Panel: TfcStatusPanel; var Text: string; var Enabled:Boolean) of object;

  {
  // TfcStatusPanel
  // Properties:
  // (Public)
  // - Col:        Returns the current Col in the TCustomMemo. (Only
  //               applicable if Control is a TCustomMemo)  For use
  //               when customizing the line and Col text.
  //
  // - Row:        Returns the current Row in the TCustomMemo.  See
  //               the Col property for details.
  //
  // (Published)
  // - Alignment:  Determines the alignment of the text in the Panel.
  //
  // - Bevel:      Determines the type of Bevel the panel has.
  //
  // - Color:      Determines the color of the panel.
  //
  // - Control:    When the style property is set to psControl then this
  //               is the control that gets displayed.  Setting this
  //               property to a non-nil value will set the style property
  //               to psControl.
  //
  // - Enabled:    When False, text appears disabled (grayed-out).  Setting
  //               this will also set the Control's enabled property if the
  //               Control property is assigned.
  //
  // - Font:       The font that the text uses to display itself.
  //
  // - Hint:       The hint that gets displayed when the mouse cursor
  //               remains over the panel for a short period of time.
  //
  // - ImageIndex: The index within the StatusBar's Imagelist to display.
  //               Setting this property to a value other than -1 will
  //               set the style property to psGlyph.
  //
  // - Indent:     When the Style property is set to psTextOnly, this property
  //               specifies how much from the border the text is spaced
  //               away.  When the Alignment property is taLeftJustify,
  //               the Indent property pertains to the left border.
  //
  // - Margin:     This property specifies how far the edges of text and
  //               controls are from the edge of the panel.
  //
  // - Name:       Used with the PanelByName method of the TfcStatusPanels.
  //
  // - PopupMenu:  The associated popupmenu of the panel.
  //
  // - Style:      Determines what kind of information the panel displays.
  //
  // - Text:       Determines what text the panel displays.
  //
  // - Width:      Determines how wide the panel is.  This value is a string but
  //               but can be only one of two types of values.
  //               - It can be an integer (i.e. 5, 25, 30, etc.)
  //               - It can be a percentage (i.e. 5%, 50%, 66%, etc.)
  //
  // Methods:
  // - GetRect:    Returns the rectangle of the panel.
  //
  // Events:
  // - OnClick, OnDblClick, OnMouseDown, OnMouseUp, OnMouseMove:
  //               Standard mouse events equivalent to that of TControl.
  //
  // - OnDrawText: Event occurs immediately prior to drawing text onto the
  //               panel.  The supplied Text variable can change to change
  //               the text that gets drawn.
  //
  // - OnTextChanged: Occurs immediately after the text for the panel
  //               changes.
  //
  }

  TfcStatusPanel = class(TfcCollectionItem)
  private
    // Property Storage Variables
    FCanvas: TCanvas;               // Protected

    FCol: Integer;                  // Public
    FRow: Integer;

    FBevel: TfcStatusPanelBevel;
    FColor: TColor;
    FComponent: TComponent;
    FEnabled: Boolean;
    FDrawTextEnabled: Boolean;
    FInDrawText:Boolean;
    FFont: TFont;
    FHint: String;
    FImageIndex: Integer;
    FIndent: Integer;
    FMargin: Integer;
    FName: string;
    FPaintWidth: Integer;
    FPopupMenu: TPopupMenu;
    FStyle: TfcStatusPanelStyle;
    FText: string;
    FCurDateTime: TDateTime;
    FTextOptions: TfcCaptionText;
    FWidth: string;

    FOnClick: TNotifyEvent;         // Events
    FOnDblClick: TNotifyEvent;
    FOnDrawText: TfcDrawTextEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;
    FOnSetName: TNotifyEvent;
    FOnTextChanged: TfcPanelTextChangedEvent;

    FRect: TRect;

    // Property Access Methods
    function GetControl: TControl;
    procedure SetBevel(Value: TfcStatusPanelBevel);
    procedure SetColor(Value: TColor);
    procedure SetComponent(Value: TComponent);
    procedure SetEnabled(Value: Boolean);
    procedure SetFont(Value:TFont);
    procedure SetHint(Value:String);
    procedure SetImageIndex(Value: Integer);
    procedure SetIndent(Value:Integer);
    procedure SetMargin(Value: Integer);
    procedure SetName(const Value: string);
    procedure SetStyle(Value: TfcStatusPanelStyle);
    procedure SetText(const Value: string);
    procedure SetWidth(Value: string);
  protected
    function GenerateName: string; virtual;
    function GetDisplayName: string; override;
    function GetStatusBar: TfcCustomStatusBar; virtual;
    function StoreWidth: Boolean; virtual;
    procedure FontChanged(Sender: TObject); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); virtual;
//    procedure ParentWndProc(var Message: TMessage); virtual;

    // IfcTextControl
    function GetTextEnabled: Boolean; virtual;
    procedure AdjustBounds; virtual;

    // Draw methods
    function DoDrawDateTime: Boolean; virtual;
    procedure Draw(ACanvas: TCanvas; ARect: TRect); virtual;
    procedure DrawControl; virtual;
    procedure DrawGlyph; virtual;
    procedure DrawKeyboardState; virtual;
    procedure DrawHint; virtual;
    procedure DrawUserName; virtual;
    procedure DrawComputerName; virtual;
    procedure DrawRichEditStatus; virtual;
    procedure DrawText(AText: string; ARect: TRect; AEnabled:Boolean); virtual;

    // Overriden methods
    procedure AssignTo(Dest: TPersistent); override;

    // Event wrappers
    procedure Click; dynamic;
    procedure DblClick; dynamic;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); dynamic;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); dynamic;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); dynamic;
    procedure PanelTextChanged(Const Text:String); dynamic;

    // Protected Properties
    property Canvas: TCanvas read FCanvas;
    property DrawTextEnabled: Boolean read FDrawTextEnabled write FDrawTextEnabled;
  public
    Patch: Variant;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    function ClientToScreen(p: TPoint): TPoint; virtual;
    function GetRect: TRect; virtual;
    procedure Invalidate; virtual;

    // Public Properties
    property Col: Integer read FCol;
    property Control: TControl read GetControl;
    property PaintWidth: Integer read FPaintWidth write FPaintWidth;
    property Row: Integer read FRow;
    property StatusBar: TfcCustomStatusBar read GetStatusBar;
    property OnSetName: TNotifyEvent read FOnSetName write FOnSetName;
  published
    // Published Properties
    property Bevel: TfcStatusPanelBevel read FBevel write SetBevel default pbLowered;
    property Color: TColor read FColor write SetColor default clBtnFace;
    property Component: TComponent read FComponent write SetComponent;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Font: TFont read FFont write SetFont;
    property Hint : string read FHint write SetHint;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default 0;
    property Indent : Integer read FIndent write SetIndent default 0;
    property Margin: Integer read FMargin write SetMargin default 0;
    property Name: string read FName write SetName;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    property Style: TfcStatusPanelStyle read FStyle write SetStyle default psTextOnly;
    property Tag;
    property Text : string read FText write SetText;
    property TextOptions: TfcCaptionText read FTextOptions write FTextOptions;
    property Width: string read FWidth write SetWidth stored StoreWidth;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnDrawText: TfcDrawTextEvent read FOnDrawText write FOnDrawText;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnTextChanged: TfcPanelTextChangedEvent read FOnTextChanged write FOnTextChanged;
  end;

  {
  // TfcStatusPanels
  // Properties:
  // - Items: Array property to retrieve a TfcStatusPanel.
  //
  // Methods:
  // - Add:          Method to add a new panel.  Returns the newly created
  //                 panel.
  //
  // - PanelByName:  Returns the panel with the name that matches in the
  //                 name that was passed in.  Returns nil if no panels
  //                 with that name are found.
  //
  }

  TfcStatusPanels = class(TfcCollection)
  private
    FStatusBar: TfcCustomStatusBar;

    // Property Access Methods
    function GetItem(Index: Integer): TfcStatusPanel;
    procedure SetItem(Index: Integer; Value: TfcStatusPanel);
  protected
    procedure RedrawIfNeeded(StyleToCheck: TfcStatusPanelStyle); virtual;

    // Overriden Methods
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;

    // Protected Properties
    property StatusBar: TfcCustomStatusBar read FStatusBar;
  public
    constructor Create(StatusBar: TfcCustomStatusBar; AStatusPanelClass: TfcStatusPanelClass);

    function Add: TfcStatusPanel;
    function PanelByName(AName: string): TfcStatusPanel;

    // Public Properties
    property Items[Index: Integer]: TfcStatusPanel read GetItem write SetItem; default;
  end;

  TDrawPanelEvent = procedure(StatusBar: TfcCustomStatusBar; Panel: TfcStatusPanel;
    const Rect: TRect) of object;

  TDrawKeyboardStateEvent = procedure(StatusBar: TfcCustomStatusBar; StatusPanel: TfcStatusPanel;
    KeyIsOn: Boolean; Rect: TRect; var AText: string) of object;

  {
  // TfcCustomStatusBar
  // Properties:
  // - ImageList:   The ImageList that panels whose style is set to psGlyph
  //                uses to render the image.
  //
  // - Panels:      The instance of TfcStatusPanels that contains the panels
  //                of the status bar.
  //
  // - SimplePanel: Same as TStatusBar.SimplePanel
  //
  // - SimpleText:  Same as TStatusBar.SimpleText
  //
  // - SizeGrip:    Same as TStatusBar.SizeGrip
  //
  // Methods:
  // - GetPanelFromPt: Returns the TfcStatusPanel located at the specified
  //                x and y coordinates.
  //
  // Events:
  // - OnDrawKeyboardState: Event occurs before drawing the text for a
  //                panel whose style property is set to psOverwrite,
  //                psCapsLock, psScrollLock, or psNumLock.  Used to customize
  //                the text that is displayed.
  //
  // - OnDrawPanel: Same as TStatusBar.OnDrawPanel
  //
  }

  TfcCustomStatusBar = class(TWinControl)
  private
    // Property Storage Variables
    FCanvas: TCanvas;             // Protected
    FLastSize: TSize;

    FImageList: TCustomImageList;       // Published
    FPanels: TfcStatusPanels;
    FSimplePanel: Boolean;
    FSimpleText: string;
    FSizeGrip: Boolean;
    FSizing: Boolean;

    {$ifdef fcDelphi3}
    FOnResize: TNotifyEvent;
    {$endif}
    FOnDrawKeyboardState: TDrawKeyboardStateEvent;  // Events
    FOnDrawPanel: TDrawPanelEvent;

    FStatusBarText: TfcStatusBarText;  // 5/06/99 - PYW - Added StatusBarText property.

    // Property Access Methods
    procedure SetPanels(Value: TfcStatusPanels);
    procedure SetSimplePanel(Value: Boolean);
    procedure SetSimpleText(const Value: string);
    procedure SetSizeGrip(Value: Boolean);

    function GetSizeGrip: boolean;

    // Message Handlers
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMTimer(var Message: TWMTimer); message WM_TIMER;
  protected
    function GetCollectionClass: TfcStatusPanelsClass; virtual;
    procedure DrawPanel(Panel: TfcStatusPanel; Rect: TRect); dynamic;
    procedure Resize; {$ifdef fcDelphi3}virtual;{$else}override;{$endif}
    procedure UpdatePanel(Index: Integer; DoInvalidate: Boolean);
    procedure UpdatePanels; virtual;

    // Overriden methods
    procedure Click; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DblClick; override;
    procedure DestroyWnd; override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure WndProc(var Message: TMessage); override;

    property Canvas: TCanvas read FCanvas;
  public
    Patch: Variant;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

//    function GetPriorityPanel(APriority: Integer): TfcStatusPanel;
//    function GetOpenPriority: Integer;
    procedure Invalidate; override;
    function GetPanelFromPt(x, y: Integer): TfcStatusPanel; virtual;
    procedure ComponentExclusive(Value: TComponent; Panel: TfcStatusPanel; ThisStatusBarOnly: Boolean);

    // Public Properties
    property Images: TCustomImageList read FImageList write FImageList;
    property Panels: TfcStatusPanels read FPanels write SetPanels;
    property SimplePanel: Boolean read FSimplePanel write SetSimplePanel;
    property SimpleText: string read FSimpleText write SetSimpleText;
    property SizeGrip: Boolean read GetSizeGrip write SetSizeGrip default True;

    property OnDrawKeyboardState: TDrawKeyboardStateEvent read FOnDrawKeyboardState write FOnDrawKeyboardState;
    property OnDrawPanel: TDrawPanelEvent read FOnDrawPanel write FOnDrawPanel;
    {$ifdef fcDelphi3}
    property OnResize: TNotifyEvent read FOnResize write FOnResize;
    {$endif}
    property StatusBarText: TfcStatusBarText read FStatusBarText write FStatusBarText;
  end;

  TfcStatusBar = class(TfcCustomStatusBar)
  published
    {$ifdef fcDelphi4Up}
    property Anchors;
    property Constraints;
    {$endif}

    property Align default alBottom;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Images;
    property Panels;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property SimplePanel;
    property SimpleText;
    property SizeGrip;
    property StatusBarText;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDrawKeyboardState;
    property OnDrawPanel;
    property OnResize;
    property OnStartDrag;
  end;

implementation

var StatusBars: TList;

function fcGetComputerName : string;
var ComputerName:String;
    nsize:{$ifdef fcDelphi4up}Cardinal{$else}Dword{$endif};
begin
  nsize := 25;
  SetLength(ComputerName,nsize);
  if GetComputerName(PChar(ComputerName),nsize) then
  begin
     SetLength(ComputerName,nsize);
     result := ComputerName;
  end
  else result := '';
end;


{ TfcStatusBarText }
// 5/06/99 - PYW - Added StatusBarText property.
constructor TfcStatusBarText.Create(AOwner: TfcCustomStatusBar);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure TfcStatusBarText.SetCapsLock(Value: String);
begin
  if FCapsLock <> Value then
  begin
    FCapsLock := Value;
    FOwner.Invalidate;
  end;
end;

procedure TfcStatusBarText.SetOverwrite(Value: String);
begin
  if FOverwrite <> Value then
  begin
    FOverwrite := Value;
    FOwner.Invalidate;
  end;
end;

procedure TfcStatusBarText.SetNumLock(Value: String);
begin
  if FNumLock <> Value then
  begin
    FNumLock := Value;
    FOwner.Invalidate;
  end;
end;

procedure TfcStatusBarText.SetScrollLock(Value: String);
begin
  if FScrollLock <> Value then
  begin
    FScrollLock := Value;
    FOwner.Invalidate;
  end;
end;

{ TfcStatusPanel }

constructor TfcStatusPanel.Create(Collection: TCollection);
begin
  Collection.BeginUpdate;
  inherited Create(Collection);
  FWidth := '50';
  FPaintWidth := StrtoInt(FWidth);
  FBevel := pbLowered;
  FEnabled := True;
  FColor := clBtnFace;
  FName := GenerateName;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  FFont.Assign(StatusBar.Font);
  FTextOptions := TfcCaptionText.Create(MakeCallbacks(Invalidate, AdjustBounds, GetTextEnabled),
    FCanvas, FFont);
  FTextOptions.VAlignment := vaVCenter;
  FIndent := 0;
  OnSetName := SetButtonName;
  Collection.EndUpdate;
end;

destructor TfcStatusPanel.Destroy;
begin
  FTextOptions.Free;
  FFont.OnChange := FontChanged;
  FFont.Free;
  FFont:= nil;
  inherited;
end;

function TfcStatusPanel.GenerateName: string;
var i:integer;
begin
  i := 0;
  repeat
    result := 'Panel' + IntToStr(i);
    inc(i);
  until StatusBar.Panels.PanelByName(result) = nil;
end;

procedure TfcStatusPanel.FontChanged(Sender: TObject);
begin
   inherited;
   Changed(False);
end;

procedure TfcStatusPanel.AssignTo(Dest: TPersistent);
begin
  if Dest is TfcStatusPanel then
    with TfcStatusPanel(Dest) do
    begin
      FBevel := self.Bevel;
      FColor := self.Color;
      FComponent := self.Component;
      FEnabled := self.Enabled;
      FFont.Assign(self.Font);
      FHint := self.Hint;
      FImageIndex := self.ImageIndex;
      FIndent := self.Indent;
      FMargin := self.Margin;
      FPopupMenu := self.PopupMenu;
      FStyle := self.Style;
      FText := self.Text;
      FWidth := self.Width;

      FOnClick := self.OnClick;
      FOnDblClick := self.OnDblClick;
      FOnDrawText := self.OnDrawText;
      FOnMouseDown := self.OnMouseDown;
      FOnMouseMove := self.OnMouseMove;
      FOnMouseUp := self.OnMouseUp;
      FOnTextChanged := self.OnTextChanged;
    end
  else inherited AssignTo(Dest);
end;

procedure TfcStatusPanel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FComponent) then
    Component := nil;
  if (Operation = opRemove) and (AComponent = FPopupMenu) then
    PopupMenu := nil;
end;

procedure TfcStatusPanel.Click;
begin
  if Assigned(FOnClick) then FOnClick(Self);
end;

procedure TfcStatusPanel.DblClick;
var   KeyBuffer:TKeyboardState;
      TmpScan:Integer;
      KeyCode: Integer;
begin
  if Assigned(FOnDblClick) then FOnDblClick(Self);
  KeyCode := -1;
  case FStyle of
    psNumLock: KeyCode := VK_NUMLOCK;
    psCapsLock: KeyCode := VK_CAPITAL;
    psOverWrite: KeyCode := VK_INSERT;
    psScrollLock: KeyCode := VK_SCROLL;
  end;
  if KeyCode <> -1 then
  begin
    GetKeyboardState(KeyBuffer);
    TmpScan := MapVirtualKey(KeyCode,0);
    Keybd_event(KeyCode, TmpScan, 0, 0);
    Keybd_event(KeyCode, TmpScan, KEYEVENTF_KEYUP, 0);
    SetKeyboardState(KeyBuffer);
  end
end;

function TfcStatusPanel.GetStatusBar: TfcCustomStatusBar;
begin
  result := TfcStatusPanels(Collection).FStatusBar;
end;

function TfcStatusPanel.StoreWidth: Boolean;
begin
  result := Width <> '0';
end;

procedure TfcStatusPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseUp) then FOnMouseUp(Self, Button, Shift, X, Y);
end;

procedure TfcStatusPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseMove) then FOnMouseMove(Self,Shift,X,Y);

  if StatusBar.Hint <> Hint then
  begin
    Application.CancelHint;
    StatusBar.Hint := Hint;
  end;
end;

procedure TfcStatusPanel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var p: TPoint;
begin
  if Assigned(FOnMouseDown) then FOnMouseDown(Self, Button, Shift, X, Y);
  if Button = mbRight then
  begin
    //3/5/99 -PYW- Use the StatusBar's ClientToScreen conversion.
    p := StatusBar.ClientToScreen(Point(x,y));
    if PopupMenu <> nil then PopupMenu.Popup(p.x, p.y);
  end;
end;

procedure TfcStatusPanel.PanelTextChanged(const Text:String);
begin
  if Assigned(FOnTextChanged) then FOnTextChanged(Self, Text);
end;

function TfcStatusPanel.ClientToScreen(p: TPoint): TPoint;
var r: TRect;
begin
  r := GetRect;
  result := Point(p.x + r.Left, p.y + r.Top);
  result := StatusBar.ClientToScreen(result);
end;

procedure TfcStatusPanel.Draw(ACanvas: TCanvas; ARect: TRect);
var RealCanvas: TCanvas;
    RealRect: TRect;
begin
  RealCanvas := FCanvas;
  RealRect := FRect;
  FCanvas := ACanvas;
  FRect := ARect;

  if ((FStyle in [psDate, psDateTime, psTime]) and DoDrawDateTime) or (FStyle <> psControl) then
  begin
    FCanvas.Brush.Color := FColor;
    FCanvas.FillRect(FRect);
  end;
  case FStyle of
    psTextOnly, psDate, psTime, psDateTime: DrawText(FText, FRect, Enabled);
    psControl: DrawControl;
    psOverWrite, psCapsLock, psNumLock, psScrollLock: DrawKeyboardState;
    psGlyph: DrawGlyph;
    psRichEditStatus: DrawRichEditStatus;
    psHint: DrawHint;
    psUserName: DrawUserName;
    psComputerName: DrawComputerName;
  end;
  FCanvas := RealCanvas;
  FRect := RealRect;
end;

procedure TfcStatusPanel.DrawText(AText: string; ARect: TRect; AEnabled:Boolean);
const
  Alignments: array[TAlignment] of Integer = (DT_LEFT, DT_RIGHT, DT_CENTER);
begin
  InflateRect(ARect, -2, 0);
  inc(ARect.Left, Indent);
  if FFont = nil then FCanvas.Font.Assign(StatusBar.Font) else FCanvas.Font.Assign(Font);

  FTextOptions.Canvas := FCanvas;
  FTextOptions.TextRect := ARect;
  if FinDrawText then exit;
  try
    FInDrawText := True;
    //3/11/99-PYW-Allow TextOptions to change in DrawText event without invalidating.
    //4/7/99 - ksw - Fix bug that didn't reassign the invalidate callback
    with FTextOptions,CallBacks do
    begin
      CallBacks := MakeCallBacks(nil,AdjustBounds,GetTextEnabled);
      try
        if Assigned(FOnDrawText) then FOnDrawText(self, AText, AEnabled);
      finally
        CallBacks := MakeCallBacks(self.Invalidate, self.AdjustBounds, self.GetTextEnabled);
      end;
    end;

    FTextOptions.Canvas := FCanvas;
    FTextOptions.Text := AText;

    if AEnabled then FDrawTextEnabled := True
    else FDrawTextEnabled := False;

    FCanvas.Brush.Style := bsClear;
    FTextOptions.Draw;
  finally
    FInDrawText := False;
  end;
  if AText <> FText then
     PanelTextChanged(AText);
end;

procedure TfcStatusPanel.DrawControl;
var r: TRect;
  procedure InvalidateChildren(Control: TWinControl);
  var i: integer;
  begin
    Control.Invalidate;
    for i := 0 to Control.ControlCount - 1 do
       if Control.Controls[i] is TWinControl then
          InvalidateChildren(Control.Controls[i] as TWinControl);
  end;
begin
  if (Control = nil) or ((Statusbar <> nil) and (csLoading in StatusBar.ComponentState)) then
    Exit;

  if Control.Parent <> StatusBar then
    Control.Parent := StatusBar;

  DrawText(Text, FRect, Enabled);

  r := FRect;
  if Text <> '' then
  begin
    if TextOptions.Alignment = taLeftJustify then r.Left := TextOptions.TextRect.Right + 2  // !! Hard Code?
    else if TextOptions.Alignment = taRightJustify then r.Right := TextOptions.TextRect.Left - 2;
  end;
  //3/5/99-PYW-Resize to Margin.
  InflateRect(r,-Margin,-Margin);
  if (fcRectWidth(r) > 0) and (fcRectHeight(r) > 0) then
    Control.BoundsRect := r;

{  with Control.BoundsRect do
    if (Left <> r.Left) or (Right <> r.right) or
       (Top <> r.top) or (Bottom <> r.Bottom) then
      Control.BoundsRect := r;}

  if (Control is TWinControl) then InvalidateChildren(Control as TWinControl);
end;

procedure TfcStatusPanel.DrawKeyboardState;
var
  Key: Integer;
  AText: string;
begin
  Key := 0;
  //3/11/99-PYW-Force TextChanged in DrawText to get called by making
  //            sure FText<>AText
  AText := FText;
  FText := '';

  case FStyle of
    psOverwrite:  begin
                    Key := VK_INSERT;
                    AText := StatusBar.StatusBarText.Overwrite;
                  end;
    psCapsLock:   begin
                    Key := VK_CAPITAL;
                    AText := StatusBar.StatusBarText.CapsLock;
                  end;
    psNumLock:    begin
                    Key := VK_NUMLOCK;
                    AText := StatusBar.StatusBarText.NumLock;
                  end;
    psScrollLock: begin
                    Key := VK_SCROLL;
                    AText := StatusBar.StatusBarText.ScrollLock;
                  end;
  end;

//  FEnabled := System.Odd(GetKeyState(Key));

  if Assigned(StatusBar.FOnDrawKeyboardState) then
     StatusBar.FOnDrawKeyboardState(StatusBar, self, System.Odd(GetKeyState(Key)), FRect, AText);

  DrawText(AText,FRect, System.Odd(GetKeyState(Key)));
end;

procedure TfcStatusPanel.DrawHint;
begin
  DrawText(Application.Hint, FRect, Enabled);
//  Text := Application.Hint;
end;

procedure TfcStatusPanel.DrawUserName;
var nsize:{$ifdef fcDelphi4up}Cardinal{$else}DWord{$endif};
    UserName:String;
begin
  nsize := 25;
  SetLength(UserName,nsize);
  if GetUserName(PChar(UserName), nsize) then
  begin
     SetLength(UserName,nsize-1);
     DrawText(UserName,FRect,Enabled);
  end;
end;

procedure TfcStatusPanel.DrawComputerName;
begin
  DrawText(fcGetComputerName,FRect,Enabled);
end;

function TfcStatusPanel.DoDrawDateTime: Boolean;
var AText: string;
begin
  AText := '';
  //3/11/99-PYW-Make sure short date and short time formats are respected.
  case FStyle of
    psDate: begin
              AText := DateToStr(Date);
              FCurDateTime := Trunc(Date);
            end;
    psTime: begin
//              AText := TimeToStr(Time);
              DateTimeToString(AText,ShortTimeFormat,Now);
              FCurDateTime := Frac(Time);
            end;
    psDateTime:
            begin
//              AText := DateTimeToStr(Now);
              DateTimeToString(AText,ShortDateFormat+' ' + ShortTimeFormat,Now);
              FCurDateTime := Now;
            end;
  end;
  result := False;
  if FText <> AText then
  begin
    FText := AText;
    result := True;
    PanelTextChanged(AText);
  end;
end;

procedure TfcStatusPanel.DrawRichEditStatus;
var AText: string;
begin
  AText := 'Ln: ' + IntToStr(FRow+1) + ', Col: ' + IntToStr(FCol+1);
  DrawText(AText,FRect,Enabled);
end;

procedure TfcStatusPanel.DrawGlyph;
var aLeft,aTop:Integer;
begin
  if (StatusBar.Images <> nil) and
  (FImageIndex >= 0) and (FImageIndex < StatusBar.Images.Count) then
  begin
    ALeft := FRect.Left+FMargin;
    ATop := FRect.Top+(((FRect.Bottom-FRect.Top)-TImageList(StatusBar.Images).height)div 2);
    { RSW - 5/27/99 - Don't use StatusBar Canvas, but use StatusPanel Canvas }
    fcImageListDraw(StatusBar.Images,FImageIndex,{StatusBar.}Canvas,ALeft,ATop,ILD_NORMAL,FEnabled);
    FRect := Rect(FRect.Left+TImageList(StatusBar.Images).Width+5,FRect.Top,FRect.Right,FRect.Bottom);
  end;
  DrawText(FText,FRect,Enabled);
end;

function TfcStatusPanel.GetControl: TControl;
begin
  result := nil;
  if Component is TControl then result := Component as TControl;
end;

function TfcStatusPanel.GetDisplayName: string;
begin
  Result := Name;
  if Result = '' then Result := inherited GetDisplayName;
end;

{
procedure TfcStatusPanel.SetPriority(Value: Integer);
var APanel: TfcStatusPanel;
begin
  if Value < 1 then Value := 1;
  if Value > StatusBar.Panels.Count then Value := StatusBar.Panels.Count;
  if FPriority <> Value then
  begin
    StatusBar.Panels.BeginUpdate;
    APanel := StatusBar.GetPriorityPanel(Value);
    FPriority := Value;
    if APanel <> nil then APanel.Priority := Value + 1;
    StatusBar.Panels.EndUpdate;
    Changed(True);
  end;
end;
}
procedure TfcStatusPanel.SetBevel(Value: TfcStatusPanelBevel);
begin
  if FBevel <> Value then
  begin
    FBevel := Value;
    Changed(False);
  end;
end;

procedure TfcStatusPanel.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed(False);
  end;
end;

procedure TfcStatusPanel.SetComponent(Value: TComponent);
begin
  if (Value = nil) and (Component = nil) then Exit;

  if (Value = StatusBar) then
    raise EInvalidOperation.Create('Control cannot equal parent StatusBar');

  if (Control <> nil) and not (csDestroying in Control.ComponentState) then
    Control.Parent := GetParentForm(StatusBar);

  FComponent := Value;

  if FComponent = nil then FStyle := psTextOnly
  else if (FComponent is TCustomRichEdit) then
  begin
    Style := psRichEditStatus;
  end else if (FComponent is TControl) then begin
    if (Control <> Value) and (StatusBar <> nil) then
      Control.Parent := StatusBar.Parent;
    Style := psControl;
  end;

  Changed(False);
end;

procedure TfcStatusPanel.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if (FStyle = psControl) and (Control <> nil) then
      Control.Enabled := Value;
    Changed(False);
  end;
end;

procedure TfcStatusPanel.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed(False);
  end;
end;

procedure TfcStatusPanel.SetMargin(Value: Integer);
begin
  if FMargin <> Value then
  begin
    FMargin := Value;
    Changed(False);
  end;
end;

procedure TfcStatusPanel.SetIndent(Value: Integer);
begin
  if FIndent <> Value then
  begin
    FIndent := Value;
    Changed(False);
  end;
end;

procedure TfcStatusPanel.SetStyle(Value: TfcStatusPanelStyle);
var i:integer;
    TimerNeeded:Boolean;
begin
  if FStyle <> Value then
  begin
    //3/11/99 - Only kill richedit timer if no longer needed.
    if (StatusBar.HandleAllocated) and (FStyle = psRichEditStatus) then
    begin
       TimerNeeded := False;
       for i:= 0 to StatusBar.Panels.Count-1 do
          if (StatusBar.Panels[i]<>Self) and
             (StatusBar.Panels[i].Style = psRichEditStatus) then
                TimerNeeded := True;
       if not TimerNeeded then KillTimer(StatusBar.Handle, RICHEDIT_TIMER_ID);
    end;

    //3/11/99 - Only kill hint timer if no longer needed.
    if (StatusBar.HandleAllocated) and (FStyle = psHint) then
    begin
       TimerNeeded := False;
       for i:= 0 to StatusBar.Panels.Count-1 do
          if (StatusBar.Panels[i]<>Self) and
             (StatusBar.Panels[i].Style = psHint) then
                TimerNeeded := True;
       if not TimerNeeded then KillTimer(StatusBar.Handle, HINT_TIMER_ID);
    end;

    //3/11/99 -PYW- Only kill date/time timer if no longer needed.
    if (StatusBar.HandleAllocated) and (FStyle in [psDate,psTime,psDateTime]) then
    begin
       TimerNeeded := False;
       for i:= 0 to StatusBar.Panels.Count-1 do
          if (StatusBar.Panels[i]<>Self) and
             (StatusBar.Panels[i].Style in [psDate,psTime,psDateTime]) then
                TimerNeeded := True;
       if not TimerNeeded then KillTimer(StatusBar.Handle, TIMER_ID);
    end;

    FStyle := Value;
    case FStyle of
      psOverwrite:; //FText := 'Overwrite';  //3/11/99 -PYW- No longer needed. Handled in DrawKeyboardState
      psCapslock:; //FText := 'Caps';
      psNumlock:; //FText := 'Num';
      psScrollLock:; //FText := 'Scroll';
      psControl: StatusBar.ComponentExclusive(FComponent, self, False);
      psHint: if StatusBar.HandleAllocated and not (csDesigning in StatusBar.ComponentState) then
        SetTimer(StatusBar.Handle, HINT_TIMER_ID, 100, nil);
      psDate,psTime,psDateTime: if StatusBar.HandleAllocated and not (csDesigning in StatusBar.ComponentState) then
        SetTimer(StatusBar.Handle, TIMER_ID, 1000, nil);
      psRichEditStatus:
        if StatusBar.HandleAllocated and not (csDesigning in StatusBar.ComponentState) then
           SetTimer(StatusBar.Handle, RICHEDIT_TIMER_ID, 100, nil);
    end;
    Changed(False);
  end;
end;

(*procedure TfcStatusPanel.ParentWndProc(var Message: TMessage);
//var MenuItem: TMenuItem;
begin
  { RSW - 2/1/99 }
  if (csDestroying in TfcStatusPanels(Collection).StatusBar.ComponentState) then exit;

  case Message.Msg of
    WM_NOTIFY: if Component is TCustomRichEdit then
      with TWMNotify(Message).NMHdr^,
           (Control as TCustomRichEdit) do
        if (Code = EN_SELCHANGE) and
           (HwndFrom = Handle) then
        begin
          FRow := SendMessage(Handle, EM_LINEFROMCHAR, SelStart, 0);
          FCol := SelStart - SendMessage(Handle, EM_LINEINDEX, FRow, 0);
          self.Invalidate;
        end;
{    WM_MENUSELECT: if (Style = psMenu) and (Component is TMainMenu) then
      with TWMMenuSelect(Message) do
    begin
      if ((MenuFlag and $FFFF) = $FFFF) and (Menu = 0) then Text := ''
      else begin
        if not ((MenuFlag and MF_POPUP) = MF_POPUP) then MenuItem := (FComponent as TMainMenu).FindItem(IDItem, fkCommand)
        else begin
          if (FComponent as TMainMenu).Handle = Menu then MenuItem := (FComponent as TMainMenu).Items
          else MenuItem := (FComponent as TMainMenu).FindItem(Menu, fkHandle);
          if MenuItem <> nil then MenuItem := MenuItem.Items[IDItem];
        end;
        if MenuItem <> nil then Text := GetLongHint(MenuItem.Hint);
      end;
    end;}
  end;
end;
*)
function TfcStatusPanel.GetTextEnabled: Boolean;
begin
  result := FDrawTextEnabled;
end;

procedure TfcStatusPanel.AdjustBounds;
begin
end;

procedure TfcStatusPanel.SetName(const Value: string);
begin
  if FName <> Value then
  begin
    if (StatusBar.Panels.PanelByName(Value) <> nil) then
      raise EInvalidOperation.CreateFmt('A panel named %s already exists.', [Value]);
    FName := Value;
    Changed(False);
    if Assigned(FOnSetName) then FOnSetName(self);
  end;
end;

procedure TfcStatusPanel.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    PanelTextChanged(Value);
    Invalidate;
  end;
end;

procedure TfcStatusPanel.SetFont(Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    //3/5/99 -PYW - Also set the Control's Font property.
    if (FStyle = psControl) and (Control <> nil) then
       TEdit(Control).Font.Assign(Value);
    Changed(False);
  end;
end;

procedure TfcStatusPanel.SetHint(Value: String);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    //3/5/99 -PYW - Also set the Control's Hint property.
    if (FStyle = psControl) and (Control <> nil) then
       Control.Hint := Value;
    Changed(False);
  end;
end;

procedure TfcStatusPanel.SetWidth(Value: string);
var AWidth: Integer;
begin
  if FWidth <> Value then
  begin
    // Validate Width
    AWidth := StrToIntDef(Value, -1);
    if AWidth = -1 then
    begin
      AWidth := StrToIntDef(Copy(Value, 1, Length(Value) - 1), -1);
      if (AWidth = -1) or (Copy(Value, Length(Value), 1) <> '%') then
        raise EInvalidOperation.Create('Width must be a valid, positive integer, or must be an integer followed by a "%" sign.');
    end;

    FWidth := Value;
    PaintWidth := StrToIntDef(Value, 0);
    StatusBar.Resize;
    Changed(True);
  end;
end;

function TfcStatusPanel.GetRect: TRect;
begin
  SendMessage(StatusBar.Handle, SB_GETRECT, Index, LPARAM(@result));
end;

procedure TfcStatusPanel.Invalidate;
var r: TRect;
    DrawBitmap: TBitmap;
    ACanvas: TCanvas;
    TempWidth: Integer;
begin
  if csLoading in StatusBar.ComponentState then Exit;
  r := GetRect;
  if not StatusBar.FSizing then if Style in [psDate, psDateTime, psTime] then
    case FStyle of
      psDate: if Trunc(Date) = FCurDateTime then Exit;
      psTime: if Frac(Date) = FCurDateTime then Exit;
      psDateTime: if Now = FCurDateTime then Exit;
    end;

  DrawBitmap := TBitmap.Create;
  ACanvas := TCanvas.Create;
  try
    //3/5/99-Need to get the system metrics for the scrollbar thumb.
    //4/26/99 - Only shrink width if last panel and sizegrip is true.
    if StatusBar.SizeGrip and (StatusBar.Panels[StatusBar.Panels.Count-1]=self) then
       TempWidth := fcRectWidth(FRect) - fcMin(23,GetSystemMetrics(SM_CXVSCROLL)+1)
    else TempWidth := fcRectWidth(FRect);

    if TempWidth > 0 then DrawBitmap.Width := TempWidth else Exit;

    DrawBitmap.Height := fcRectHeight(FRect);

    Draw(DrawBitmap.Canvas, Rect(0, 0, DrawBitmap.Width, DrawBitmap.Height));
    ACanvas.Handle := GetDC(StatusBar.Handle);
    ACanvas.Draw(FRect.Left, FRect.Top, DrawBitmap);
    ReleaseDC(StatusBar.Handle, ACanvas.Handle);
  finally
    ACanvas.Free;
    DrawBitmap.Free;
  end;
end;

{ TfcStatusPanels }

constructor TfcStatusPanels.Create(StatusBar: TfcCustomStatusBar; AStatusPanelClass: TfcStatusPanelClass);
begin
  inherited Create(AStatusPanelClass);
  FStatusBar := StatusBar;
end;

procedure TfcStatusPanels.RedrawIfNeeded(StyleToCheck: TfcStatusPanelStyle);
var i: integer;
begin
  for i := 0 to Count - 1 do
    if Items[i].FStyle = StyleToCheck then
      Items[i].Invalidate;
end;

function TfcStatusPanels.PanelByName(AName:String): TfcStatusPanel;
var i: Integer;
begin
  result := nil;
  for i := 0 to Count - 1 do
    if Items[i].Name = AName then
      result := Items[i];
end;

function TfcStatusPanels.Add: TfcStatusPanel;
begin
  result := TfcStatusPanel(inherited Add);
end;

function TfcStatusPanels.GetItem(Index: Integer): TfcStatusPanel;
begin
  result := TfcStatusPanel(inherited GetItem(Index));
end;

function TfcStatusPanels.GetOwner: TPersistent;
begin
  result := FStatusBar;
end;

procedure TfcStatusPanels.SetItem(Index: Integer; Value: TfcStatusPanel);
begin
  inherited SetItem(Index, Value);
end;

procedure TfcStatusPanels.Update(Item: TCollectionItem);
begin
  if Item <> nil then
    FStatusBar.UpdatePanel(Item.Index, True) else
    FStatusBar.UpdatePanels;
end;

{ TfcCustomStatusBar }

constructor TfcCustomStatusBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csOpaque];
  // 5/06/99 - PYW - Added StatusBarText property.
  FStatusBarText:= TfcStatusBarText.Create(Self);
  with FStatusBarText do
  begin
     CapsLock := 'Caps';
     Overwrite := 'Overwrite';
     NumLock := 'Num';
     ScrollLock := 'Scroll';
  end;
  Color := clBtnFace;
  Height := 20;
  Align := alBottom;
  FPanels := GetCollectionClass.Create(self, TfcStatusPanel);
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FSizeGrip := True;
  StatusBars.Add(self);
end;

destructor TfcCustomStatusBar.Destroy;
begin
  if StatusBars<>nil then { 7/11/99 }
     StatusBars.Delete(StatusBars.IndexOf(self));
  FPanels.Free;
  FCanvas.Free;
  // 5/06/99 - PYW - Added StatusBarText property.
  FStatusBarText.Free;
  inherited Destroy;
end;

function InitCommonControl(CC: Integer): Boolean;
var
  ICC: TInitCommonControlsEx;
begin
  ICC.dwSize := SizeOf(TInitCommonControlsEx);
  ICC.dwICC := CC;
  Result := InitCommonControlsEx(ICC);
  if not Result then InitCommonControls;
end;

procedure TfcCustomStatusBar.CreateParams(var Params: TCreateParams);
const
  GripStyles: array[Boolean] of DWORD = (CCS_TOP, SBARS_SIZEGRIP);
begin
  InitCommonControl(ICC_BAR_CLASSES);
  inherited CreateParams(Params);
  CreateSubClass(Params, STATUSCLASSNAME);
  with Params do
  begin
    //4/26/99 - PYW - Show sizegrip only if sizeable window.
    Style := Style or GripStyles[FSizeGrip and (Parent is TCustomForm) and
             (TForm(Parent).BorderStyle in [bsSizeable, bsSizeToolWin])];
{    if FSizeGrip then
      Style := Style or SBARS_SIZEGRIP else
      Style := Style or CCS_TOP;}
    WindowClass.style := WindowClass.style and not CS_HREDRAW;
  end;
end;

procedure TfcCustomStatusBar.Loaded;
begin
  inherited;
  Resize;
end;

procedure TfcCustomStatusBar.DestroyWnd;
begin
  SendMessage(Handle, SB_SETTEXT, 0, Integer(PChar('')));
  KillTimer(Handle, TIMER_ID);
  KillTimer(Handle, HINT_TIMER_ID);
  KillTimer(Handle, RICHEDIT_TIMER_ID);
  inherited DestroyWnd;
end;

procedure TfcCustomStatusBar.CreateWnd;
var i: Integer;
    FoundDate, FoundHint, FoundRichEdit: boolean;
begin
  inherited CreateWnd;
  UpdatePanels;

  if FSimpleText <> '' then SendMessage(Handle, SB_SETTEXT, 255, Integer(PChar(FSimpleText)));
  if FSimplePanel then SendMessage(Handle, SB_SIMPLE, 1, 0);

  FoundRichEdit:= False;
  FoundHint:= False;
  FoundDate:= False; { 4/27/99 - RSW (Fix bug where only one timer was set }
  if not (csDesigning in ComponentState) then
    for i := 0 to Panels.Count - 1 do
      if (not FoundHint) and (Panels[i].Style = psHint) then
      begin
        SetTimer(Handle, HINT_TIMER_ID, 100, nil);
        FoundHint:= True;
      end //3/11/99 - PYW - Timer for datetime styles never set so set it.
      else if (not FoundDate) and (Panels[i].Style in [psDate,psTime,psDateTime]) then
      begin
        //4/27/99 - PYW - Update Timer to 1000 to be consistent.
        SetTimer(Handle, TIMER_ID, 1000, nil);
        FoundDate:= True;
      end
      else if (not FoundRichEdit) and (Panels[i].Style = psRichEditStatus) then
      begin
        SetTimer(Handle, RICHEDIT_TIMER_ID, 100, nil);
        FoundRichEdit:= True;
      end
end;

procedure TfcCustomStatusBar.DrawPanel(Panel: TfcStatusPanel; Rect: TRect);
begin
  Panel.FCanvas := Canvas;
  Panel.FRect := Rect;
  //4/26/99 - Only shrink width if last panel and sizegrip is true.
  if SizeGrip and (Panels[Panels.Count-1]=Panel) then
     Rect.Right := Rect.Right-fcMin(23,GetSystemMetrics(SM_CXVSCROLL)+1);
  Panel.Draw(Canvas, Rect);
  if Assigned(FOnDrawPanel) then FOnDrawPanel(Self, Panel, Rect);
end;

procedure TfcCustomStatusBar.Click;
var Panel: TfcStatusPanel;
begin
  Panel := GetPanelFromPt(-1, -1);
  if (Panel <> nil) then Panel.Click;
  inherited;
end;

procedure TfcCustomStatusBar.DblClick;
var Panel: TfcStatusPanel;
begin
  Panel := GetPanelFromPt(-1, -1);
  if (Panel <> nil) then Panel.DblClick;
  inherited;
end;

procedure TfcCustomStatusBar.SetPanels(Value: TfcStatusPanels);
begin
  FPanels.Assign(Value);
end;

procedure TfcCustomStatusBar.SetSimplePanel(Value: Boolean);
begin
  if FSimplePanel <> Value then
  begin
    FSimplePanel := Value;
    if HandleAllocated then
      SendMessage(Handle, SB_SIMPLE, Ord(FSimplePanel), 0);
  end;
end;

procedure TfcCustomStatusBar.SetSimpleText(const Value: string);
begin
  if FSimpleText <> Value then
  begin
    FSimpleText := Value;
    if HandleAllocated then
      SendMessage(Handle, SB_SETTEXT, 255, Integer(PChar(FSimpleText)));
  end;
end;

//4/26/99 - PYW - Show sizegrip only if sizeable window.
function TfcCustomStatusBar.GetSizeGrip:Boolean;
begin
   result := FSizeGrip and (Parent is TCustomForm) and
      (TForm(Parent).BorderStyle in [bsSizeable, bsSizeToolWin]);
end;

procedure TfcCustomStatusBar.SetSizeGrip(Value: Boolean);
begin
  if FSizeGrip <> Value then
  begin
    FSizeGrip := Value;
    {if not (csLoading in ComponentState) then }RecreateWnd;
  end;
end;

procedure TfcCustomStatusBar.UpdatePanel(Index: Integer; DoInvalidate: Boolean);
var
  Flags: Integer;
  S: string;
  r: TRect;
begin
  if HandleAllocated then
    with Panels[Index] do
    begin
      Flags := 0;
      case Bevel of
        pbNone: Flags := SBT_NOBORDERS;
        pbRaised: Flags := SBT_POPOUT;
      end;
      Flags := Flags or SBT_OWNERDRAW;
      s := Text;
      case TextOptions.Alignment of
        taCenter: s := #9 + S;
        taRightJustify: s := #9#9 + S;
      end;
      SendMessage(Handle, SB_SETTEXT, Index or Flags, Integer(PChar(S)));
      if DoInvalidate then
      begin
        r := GetRect;
        InvalidateRect(Handle, @r, True);
      end;
    end;
end;

procedure TfcCustomStatusBar.UpdatePanels;
const
  MaxPanelCount = 128;
var
  I, Count, PanelPos: Integer;
  PanelEdges: array[0..MaxPanelCount - 1] of Integer;
begin
  if HandleAllocated then
  begin
    Count := Panels.Count;
    if Count > MaxPanelCount then Count := MaxPanelCount;
    if Count = 0 then
    begin
      PanelEdges[0] := -1;
      SendMessage(Handle, SB_SETPARTS, 1, Integer(@PanelEdges));
      SendMessage(Handle, SB_SETTEXT, 0, Integer(PChar('')));
    end else
    begin
      PanelPos := 0;
      for I := 0 to Count - 2 do
      begin
        Inc(PanelPos, Panels[I].PaintWidth);
        PanelEdges[I] := PanelPos;
      end;
      PanelEdges[Count - 1] := -1;
      SendMessage(Handle, SB_SETPARTS, Count, Integer(@PanelEdges));
      for I := 0 to Count - 1 do UpdatePanel(I, False);
//      InvalidateRect(Handle, nil, True);
//      Invalidate;
    end;
  end;
end;

procedure TfcCustomStatusBar.CMShowingChanged(var Message: TMessage);
begin
  inherited;
end;

procedure TfcCustomStatusBar.CNDrawItem(var Message: TWMDrawItem);
var
  SaveIndex: Integer;
  PanelEdges: array[0..255 - 1] of Integer;
  ACount: Integer;
begin
  FillChar(PanelEdges, SizeOf(PanelEdges), 0);
  ACount := SendMessage(Handle, SB_GETPARTS, Panels.Count, Integer(@PanelEdges));
  if ACount <> Panels.Count then RecreateWnd;

  with Message.DrawItemStruct^ do
  begin
    SaveIndex := SaveDC(hDC);
    FCanvas.Handle := hDC;
    FCanvas.Font := Font;
    FCanvas.Brush.Color := clBtnFace;
    FCanvas.Brush.Style := bsSolid;
    DrawPanel(Panels[itemID], rcItem);//Rect(Left, Top - 1, Right, Bottom));
    FCanvas.Handle := 0;
    RestoreDC(hDC, SaveIndex);
  end;
  Message.Result := 1;
end;

procedure TfcCustomStatusBar.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  inherited;
//  Message.result := -1;
end;

procedure TfcCustomStatusBar.WMSize(var Message: TWMSize);
var i: Integer;
begin
  FSizing := True;
  if (Parent = nil) or ([csLoading, csDestroying] * ComponentState <> []) then Exit;
  if not (csLoading in ComponentState) then Resize;
  for i := 0 to Panels.Count - 1 do
    if (Panels[i].Control = nil) or (Panels[i].Control is TCustomRichEdit) then
      Panels[i].Invalidate;
  FSizing := False;
//      DrawPanel(Panels[i],Panels[i].FRect);

//3/5/99-PYW-Causes a lot of unnecessary flicker.  Does not seem to be needed.
{  with FPanels do
    for i := 0 to Count - 1 do
      if (Items[i] as TfcStatusPanel).Control <> nil then
        DrawPanel(Items[i] as TfcStatusPanel,
          Rect((Items[i] as TfcStatusPanel).FRect.Left + (fpanels.items[i] as TfcStatusPanel).Margin,
               (Items[i] as TfcStatusPanel).FRect.Top + (fpanels.items[i] as TfcStatusPanel).Margin,
               (Items[i] as TfcStatusPanel).FRect.right-(fpanels.items[i] as TfcStatusPanel).Margin,
               (Items[i] as TfcStatusPanel).FRect.Bottom-(fpanels.items[i] as TfcStatusPanel).Margin));}
end;

procedure TfcCustomStatusBar.Notification(AComponent: TComponent; Operation: TOperation);
var i: Integer;
begin
  inherited Notification(AComponent, Operation);

  if AComponent <> self then
    for i := 0 to Panels.Count - 1 do Panels[i].Notification(AComponent, Operation);

  if (Operation = opRemove) and (FImageList = AComponent) then
    Images := nil;
end;

procedure TfcCustomStatusBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Panel: TfcStatusPanel;
begin
  Panel := GetPanelFromPt(-1, -1);
  if (Panel <> nil) then Panel.MouseUp(Button, Shift, X, Y);
  inherited;
end;

procedure TfcCustomStatusBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Panel: TfcStatusPanel;
begin
  Panel := GetPanelFromPt(-1, -1);
  if (Panel <> nil) then Panel.MouseDown(Button, Shift, X, Y);
  inherited;
end;

procedure TfcCustomStatusBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var Panel: TfcStatusPanel;
begin
  Panel := GetPanelFromPt(-1, -1);
  if (Panel <> nil) then Panel.MouseMove(Shift, X, Y);
  inherited;
end;

procedure TfcCustomStatusBar.WndProc(var Message: TMessage);
begin
  if (csDesigning in ComponentState) then
    if (Message.Msg = WM_LBUTTONDOWN) then
     Invalidate;

  inherited;
end;

function TfcCustomStatusBar.GetPanelFromPt(x, y: Integer): TfcStatusPanel;
var i: integer;
begin
  result := nil;

  if (x = -1) and (y = -1) then
    with fcGetCursorPos do
      with ScreenToClient(Point(x, y)) do
        result := GetPanelFromPt(x, y)
  else for i := 0 to Panels.Count - 1 do
    if PtInRect(Panels[i].GetRect, Point(x, y)) then
    begin
      result := Panels[i];
      Break;
    end;
end;

procedure TfcCustomStatusBar.WMTimer(var Message: TWMTimer);
var i: Integer;
    RichEdit: TCustomRichEdit;
    TempRow, TempCol, TempColBasedOnRow: integer;
begin
  case Message.TimerID of
    TIMER_ID: for i := 0 to Panels.Count - 1 do
      if Panels[i].Style in [psDate, psTime, psDateTime] then
        Panels[i].Invalidate;
    RICHEDIT_TIMER_ID: for i := 0 to Panels.Count - 1 do
      if (Panels[i].Style = psRichEditStatus) and
         (Panels[i].Component is TCustomRichEdit) then
      begin
         RichEdit:= TCustomRichEdit(Panels[i].Component);
         with Panels[i] do begin
            TempRow := SendMessage(RichEdit.Handle, EM_LINEFROMCHAR, RichEdit.SelStart, 0);
            TempCol := RichEdit.SelStart - SendMessage(RichEdit.Handle, EM_LINEINDEX, -1, 0);

            { 5/7/99 - RSW - Fix bug in RichEdit control where it makes row 1 too big }
            { This can happen if you enter vk_home on a line that does not end a paragraph}
            TempColBasedOnRow := RichEdit.SelStart - SendMessage(RichEdit.Handle, EM_LINEINDEX, TempRow, 0);
            if TempCol<>TempColBasedOnRow then dec(TempRow);

            if (TempRow<>FRow) or (TempCol<>FCol) then
            begin
               FRow:= TempRow;
               FCol:= TempCol;
               Panels[i].Invalidate;
            end;
         end
      end;

    HINT_TIMER_ID: for i := 0 to Panels.Count - 1 do
      if Panels[i].Style = psHint then
      begin
        Panels[i].Text := Application.Hint;
      end;
  end;
end;

function TfcCustomStatusBar.GetCollectionClass: TfcStatusPanelsClass;
begin
  result := TfcStatusPanels;
end;

procedure TfcCustomStatusBar.ComponentExclusive(Value: TComponent; Panel: TfcStatusPanel; ThisStatusBarOnly: Boolean);
var i: Integer;
begin
  // Check to see if another panel already contains this Control.  If so, then
  // Remove it from the other panel and let this procedure reassign it.
  for i := 0 to Panels.Count - 1 do
    if (Panels[i].Component = Value) and (Panels[i] <> Panel) then
      Panels[i].Component := nil;

  // Check to see if a different StatusBar Panel already contains this Control.
  // If so, then remove it from the other panel and let this procedure reassign it.
  if not ThisStatusBarOnly then for i := 0 to StatusBars.Count - 1 do
    if StatusBars[i] <> self then
      TfcStatusBar(StatusBars[i]).ComponentExclusive(Value, Panel, True);
end;
{
function TfcCustomStatusBar.GetPriorityPanel(APriority: Integer): TfcStatusPanel;
var i: Integer;
begin
  result := nil;
  for i := 0 to Panels.Count - 1 do
  begin
    if Panels[i].Priority = APriority then
    begin
      result := Panels[i];
      Break;
    end;
  end;
end;
}
procedure TfcCustomStatusBar.Resize;
var TotalWidths: Integer;
    i: Integer;
    r: TRect;
    UpdateFlag: Boolean;
begin
  {$ifdef fcDelphi3}
  if Assigned(FOnResize) then FOnResize(Self);
  {$else}
  inherited;
  {$endif}

  if (csLoading in ComponentState) or (Width = 0) then Exit;

  TotalWidths := 0;
  for i := 0 to Panels.Count - 1 do
  begin
    Panels[i].PaintWidth := fcMin(Width - TotalWidths, StrtoIntDef(Panels[i].Width, -1));
    if Panels[i].PaintWidth <> -1 then
      inc(TotalWidths, Panels[i].PaintWidth);
  end;
  for i := 0 to Panels.Count - 1 do
    if (Panels[i].PaintWidth = -1) and (Width - TotalWidths > 0) then
      Panels[i].PaintWidth := (Width - TotalWidths) * StrtoInt(Copy(Panels[i].Width, 1, Length(Panels[i].Width) - 1)) div 100;

  if fcSizeEqual(FLastSize, fcSize(0, 0)) or (FLastSize.cy <> Height) then
    Panels.Update(nil)
  else begin
    r := Rect(Width - 25, 0, Width, Height);
    if Width > FLastSize.cx then
      r.Left := FLastSize.cx - 25;
    InvalidateRect(Handle, @r, True);
  end;

  FLastSize := fcSize(Width, Height);

  UpdateFlag := False;
  for i := 0 to Panels.Count - 1 do if Pos('%', Panels[i].Width) <> 0 then UpdateFlag := True;
  if UpdateFlag then UpdatePanels;
end;

var Hook: HHOOK = 0;

function KeyboardProc(code: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var AStyle: TfcStatusPanelStyle;
    i: integer;
begin
  result := CallNextHookEx(Hook, code, wParam, lParam);
  AStyle := psTextOnly;
  case wParam of
    VK_INSERT: AStyle := psOverwrite;
    VK_CAPITAL: AStyle := psCapsLock;
    VK_NUMLOCK: AStyle := psNumLock;
    VK_SCROLL: AStyle := psScrollLock;
  end;
  if AStyle <> psTextOnly then
    for i := 0 to StatusBars.Count - 1 do
      TfcCustomStatusBar(StatusBars[i]).Panels.RedrawIfNeeded(AStyle);
end;

procedure TfcCustomStatusBar.Invalidate;
begin
  if not (csLoading in ComponentState) then inherited;
end;

initialization
  StatusBars := TList.Create;
  Hook := SetWindowsHookEx(WH_KEYBOARD, @KeyboardProc, 0, GetCurrentThreadID);
finalization
  UnhookWindowsHookEx(Hook);
  StatusBars.Free;
  StatusBars:= nil; { 7/11/99 }
end.
