{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.RibbonActnMenus;

{$HPPEMIT '#ifndef _WIN64'}
{$HPPEMIT '#pragma link "dwmapi.lib"'}
{$HPPEMIT '#endif //_WIN64'}

interface

uses
  Winapi.Windows, System.Classes, System.Actions, Vcl.ActnMan, Vcl.ActnMenus, Vcl.XPActnCtrls, Vcl.ShadowWnd, Vcl.Controls,
  Vcl.Graphics, Vcl.GraphUtil, Winapi.Messages, Vcl.Dialogs, System.SysUtils, Vcl.ActnList, System.Contnrs,
  Vcl.RibbonActnCtrls, Vcl.ActnPopup, Vcl.RibbonStyleActnCtrls;

type
  // Item added to the OptionItems collection for the TRibbonApplicationMenuBar
  // component. This class represents the action to use for the command as well
  // as the keytip to use.
  TOptionItem = class(TCollectionItem)
  private
    FAction: TContainedAction;
    FKeyTip: string;
    FHint: string;
    FCaption: string;
    FTag: Integer;
    procedure SetAction(const Value: TContainedAction);
  protected
    function GetDisplayName: string; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Action: TContainedAction read FAction write SetAction;
    property Caption: string read FCaption write FCaption;
    property Hint: string read FHint write FHint;
    property Tag: Integer read FTag write FTag;
    property KeyTip: string read FKeyTip write FKeyTip;
  end;

  TRibbonApplicationMenuBar = class;

  // Class that stores the additional option items that appear in the border
  // of the Application Menu
  TOptionItems = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TOptionItem;
    procedure SetItem(Index: Integer; const Value: TOptionItem);
    function GetApplicationMenu: TRibbonApplicationMenuBar;
  public
    function Add: TOptionItem;
    function Insert(Index: Integer): TOptionItem;
    property ApplicationMenu: TRibbonApplicationMenuBar read GetApplicationMenu;
    property Items[Index: Integer]: TOptionItem read GetItem write SetItem; default;
  end;

  // Class used to display the Application Menu for the Ribbon.
  //
  // The TRibbonApplicationMenuBar component is not available on the component
  // palette and should not be greated dynamically. To add an Application Menu
  // to your Ribbon, select the Add Application Menu command in the Ribbon
  // component editor.
  //
  // The Application Menu consists of two vertical panes. On the left is a list
  // of Menu items. You can modify the menu items at design time.
  //
  // On the right is a place to display Recent items. This area is mostly intended
  // for use as a recenltly used file list. To use this as a Recent Items pane,
  // use the TRibbon.AddRecentItem method to add items. There are a number of
  // Recent Item functions to help you setup the list of items.
  // You can also use the right pane to add more commands. Do this by setting the
  // ApplicationMenu.CommandType to ctCommand. See the command type property for
  // more details.
  //
  // The bottom section of the Application button can also display commands. Usually
  // this section is set aside for the Application Exit command and Applicaiton
  // Options command. Set your commands in the OptionItems collection.
  //
  // To modify the contents of the Application Menu you can drag actions from the
  // customize dialog and drop them in the menu on the left of the application
  // menu.
  TRibbonApplicationMenuBar = class(TCustomActionMainMenuBar)
  private
    FRibbon: TWinControl;
    FOptionItems: TOptionItems;
    FRecentItems: TOptionItems;
    //procedure FindRibbon;
    function GetVisibleMenu: TCustomActionMenuBar;
    function GetVisibleMenuCount: Integer;
    procedure SetOptionItems(const Value: TOptionItems);
    procedure SetRecentItems(const Value: TOptionItems);
  protected
    procedure CreateControls; override;
    procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    procedure DrawBackground; override;
    function GetControlClass(AnItem: TActionClientItem): TCustomActionControlClass; override;
    function NewPopup: TCustomActionPopupMenu; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function RibbonStyle: TRibbonStyleActionBars;
    procedure ShowKeyTips;
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CloseMenu; override;
    function CreateControl(AnItem: TActionClientItem): TCustomActionControl; override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    property VisibleMenuCount: Integer read GetVisibleMenuCount;
    property VisibleMenu: TCustomActionMenuBar read GetVisibleMenu;
    function GetRibbon: TWinControl;
    procedure SetRibbon(const Value: TWinControl);
    procedure SelectApplicationButton;
    property Align default alNone;
    property HorzMargin default 0;
    property Spacing default 0;
    property VertMargin default 0;
  published
    property ActionManager;
    property Height default 44;
    property Left default 0;
    property Top default 0;
    property Width default 44;
    // OptionItems are displayed at the bottom of the Application Menu
    //
    // Usually this section of commands has Application Exit and Application
    // Options commands.
    property OptionItems: TOptionItems read FOptionItems write SetOptionItems;
    // RecentItems are displayed in the right hand pane of the Application Menu
    //
    // RecentItems can be added dynamically using one of the RecentItems helper
    // method. To handle the user clicking on a Recent Item, use the OnRecentItemClick
    // event.
    property RecentItems: TOptionItems read FRecentItems write SetRecentItems;
  end;

  // Class used to display top level menus when using the Ribbon Style without
  // the Ribbon interface.
  TRibbonActionPopupMenu = class(TXPStylePopupMenu)
  private
    FSelectFirstItem: Boolean;
  protected
    procedure NCPaint(DC: HDC); override;
  public
    procedure TrackMenu; override;
    function CreateControl(AnItem: TActionClientItem): TCustomActionControl; override;
    property SelectFirstItem: Boolean read FSelectFirstItem write FSelectFirstItem;
  end;

  TRibbonStylePopupMenu = class(TRibbonActionPopupMenu)
  private
    const
      UM_STOPRESIZE = WM_USER + 1;
  private
    FGripItem: TRibbonGripItem;
    FGalleryResize: TGalleryResize;
    procedure SetGalleryResize(const Value: TGalleryResize);
  protected
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    function CanAutoSize(var NewWidth: Integer;
      var NewHeight: Integer): Boolean; override;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure WMExitsizemove(var Message: TMessage); message WM_EXITSIZEMOVE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateControl(AnItem: TActionClientItem): TCustomActionControl; override;
    property GalleryResize: TGalleryResize read FGalleryResize write SetGalleryResize;
  end;

  TRibbonStyleMainPopupMenu = class(TCustomActionPopupMenu)
  private
    FOwner: TCustomActionBar;
    FParentItem: TCustomActionControl;
  protected
    procedure PositionPopup(AnOwner: TCustomActionBar; ParentItem: TCustomActionControl); override;
    procedure NCPaint(DC: HDC); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TRibbonRecentDocuments = class(TGraphicControl)
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Caption;
  end;

  // Class used to display the popup menu when the Application Button has been
  // clicked.

  // The Application Popup Menu is a two paned menu that shows a normal list
  // of commands on the left, as well as a specialized list of commands on the
  // right pane. Additional commands can also be displayed in the bottom border
  // of the menu.
  TRibbonApplicationPopupMenu = class(TCustomActionPopupMenu)
  private
    FRecentDocuments: TRibbonRecentDocuments;
    FRibbon: TWinControl;
    FOptionClients: TActionClients;
    FRecentClients: TActionClients;
    procedure CreateWindowRegion;
  protected
    function GetBorderHeight: Integer; virtual;
    procedure CreateRecentDocuments; virtual;
    procedure CreateOptionsItems; virtual;
    procedure NCPaint(DC: HDC); override;
    procedure PositionPopup(AnOwner: TCustomActionBar;
      ParentItem: TCustomActionControl); override;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure SetColorMap(const Value: TCustomActionBarColorMap); override;
    procedure CustomAlignPosition(Control: TControl; var NewLeft: Integer;
      var NewTop: Integer; var NewWidth: Integer; var NewHeight: Integer;
      var AlignRect: TRect; AlignInfo: TAlignInfo); override;
    procedure DrawBackground; override;
    procedure CreateWnd; override;
    procedure CreateControls; override;
    procedure CMTextchanged(var Message: TMessage); message CM_TEXTCHANGED;
    function RibbonStyle: TRibbonStyleActionBars;
    procedure DoDropActions(Source: TActionDragObject; const X: Integer;
      const Y: Integer); override;
    procedure DoDropItem(Source: TActionItemDragObject; const X: Integer;
      const Y: Integer); override;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetRibbon: TWinControl;
    procedure SetRibbon(const Value: TWinControl);
    procedure DoDropCategory(Source: TCategoryDragObject; const X: Integer;
      const Y: Integer); override;
  end;

  TRibbonQATCustomizeMenu = class(TCustomizeActionToolBar)
  private
    FBtnShadow: TShadowWindow;
  protected
    procedure DisplayShadow; override;
    procedure DoAddCustomizeItems(const ActionClient: TActionClient); override;
    function GetControlClass(AnItem: TActionClientItem): TCustomActionControlClass; override;
    procedure HideShadow; override;
    procedure NCPaint(DC: HDC); override;
    procedure PositionPopup(AnOwner: TCustomActionBar;
      ParentItem: TCustomActionControl); override;
    procedure VisibleChanging; override;
  end;

implementation

uses
{$IF DEFINED(CLR)}
  Variants, System.Runtime.InteropServices,
{$ENDIF}
  Vcl.Forms, System.Types, Vcl.Ribbon, Vcl.Buttons, Vcl.ActnCtrls, Vcl.RibbonConsts, Vcl.RibbonLunaStyleActnCtrls, Winapi.DwmApi, Winapi.UxTheme;

{ TRibbonApplicationPopupMenu }

procedure TRibbonApplicationPopupMenu.AlignControls(AControl: TControl; var Rect: TRect);
var
  I: Integer;
  LCtrl: TCustomActionControl;
  LLeft: Integer;
  LHeight: Integer;
  LTop: Integer;
begin
  if DesignMode and (AControl = nil) then
  begin
    LHeight := GetBorderHeight;
    if HasItems then
    begin
      for I := 0 to Items.Count - 1 do
      begin
        if Items[I].Control <> nil then
          Inc(LHeight, Items[I].Control.Height);
      end;
      Height := LHeight;
      CreateWindowRegion;
    end;
  end;
  inherited;
  if FRecentDocuments <> nil then
    FRecentDocuments.SetBounds(HorzMargin + Widest, VertMargin,
      Width - Widest - (2 * HorzMargin), Height - GetBorderHeight);
  if FRecentClients <> nil then
  begin
    LTop := FRecentDocuments.Top + 25;
    for I := 0 to FRecentClients.Count - 1 do
    begin
      LCtrl := FRecentClients[I].Control;
      if LCtrl <> nil then
      begin
        LCtrl.CalcBounds;
        if (LTop - FRecentDocuments.Top) + LCtrl.Height > FRecentDocuments.Height then
          LCtrl.SetBounds(-MAXINT, LTop, FRecentDocuments.Width - 2, LCtrl.Height)
        else
        LCtrl.SetBounds(FRecentDocuments.Left + 1, LTop, FRecentDocuments.Width - 2, LCtrl.Height);
        Inc(LTop, LCtrl.Height + Spacing);
      end;
    end;
  end;
  if FOptionClients <> nil then
  begin
    LLeft := Width - 4;
    for I := 0 to FOptionClients.Count - 1 do
    begin
      LCtrl := FOptionClients[I].Control;
      if LCtrl <> nil then
      begin
        LCtrl.CalcBounds;
        Dec(LLeft, LCtrl.Width);
        LCtrl.SetBounds(LLeft, Height - 25, LCtrl.Width, LCtrl.Height);
        Dec(LLeft, 3);
      end;
    end;
  end;
end;

function TRibbonApplicationPopupMenu.GetBorderHeight: Integer;
begin
  Result := (VertMargin * 2) + 11;
end;

procedure TRibbonApplicationPopupMenu.CMTextchanged(var Message: TMessage);
begin
  inherited;
  if FRecentDocuments <> nil then
    FRecentDocuments.Caption := Caption;
end;

constructor TRibbonApplicationPopupMenu.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csOpaque];
  EdgeBorders := [];
  VertMargin := 18;
  HorzMargin := 6;
  CreateRecentDocuments;
  CreateOptionsItems;
  AutoSize := False;
  Width := 420;
end;

procedure TRibbonApplicationPopupMenu.CreateControls;
var
  LHeight: Integer;
  I: Integer;
begin
  inherited;
  LHeight := (VertMargin * 2) + 11;
  if HasItems then
  begin
    for I := 0 to Items.Count - 1 do
    begin
      if Items[I].Visible then
      begin
        Items[I].Control.CalcBounds;
        Inc(LHeight, Items[I].Control.Height);
      end;
    end;
  end;
  Height := LHeight;
  CreateWindowRegion;
end;

procedure TRibbonApplicationPopupMenu.CreateOptionsItems;
var
  LAC: TActionClientItem;
  LOptionItems: TOptionItems;
  I: Integer;
  LCtrl: TRibbonOptionButtonControl;
  LApplicationMenu: TRibbonApplicationMenuBar;
begin
  if Owner is TRibbonApplicationMenuBar then
    LApplicationMenu := (Owner as TRibbonApplicationMenuBar)
  else
    LApplicationMenu := nil;
  if LApplicationMenu = nil then
    Exit;
  LOptionItems := LApplicationMenu.OptionItems;
  if LOptionItems.Count > 0 then
  begin
    FOptionClients := TActionClients.Create(ActionManager, TActionClientItem);
    DisableAlign;
    try
      for I := 0 to LOptionItems.Count - 1 do
      begin
        LCtrl := TRibbonOptionButtonControl.Create(Owner);
        LCtrl.Parent := Self;
        LAC := FOptionClients.Add;
        LAC.Action := LOptionItems[I].Action;
        LAC.KeyTip := LOptionItems[I].KeyTip;
        LAC.Caption := ' ' + LAC.Caption;
        LAC.ChangesAllowed := [];
        LCtrl.ActionClient := LAC;
        LAC.Control := LCtrl;
      end;
    finally
      EnableAlign;
    end;
  end;
end;

procedure TRibbonApplicationPopupMenu.CreateWindowRegion;
var
  LRgn: HRGN;
begin
  LRgn := CreateRoundRectRgn(0, 0, Width + 1, Height + 1, 3, 3);
  SetWindowRgn(Handle, LRgn, True);
end;

procedure TRibbonApplicationPopupMenu.CreateWnd;
begin
  inherited;
  CreateWindowRegion;
end;

procedure TRibbonApplicationPopupMenu.CustomAlignPosition(Control: TControl;
  var NewLeft, NewTop, NewWidth, NewHeight: Integer; var AlignRect: TRect;
  AlignInfo: TAlignInfo);
var
  LSplitIntf: IRibbonSplitButton;
begin
  inherited;
  if Supports(Control, IRibbonSplitButton, LSplitIntf) then
    LSplitIntf.UpdateSplitBounds;
end;

destructor TRibbonApplicationPopupMenu.Destroy;
begin
  FRecentDocuments.Free;
  FOptionClients.Free;
  FRecentClients.Free;
  inherited;
end;

procedure TRibbonApplicationPopupMenu.DoDropActions(Source: TActionDragObject;
  const X, Y: Integer);
begin
  inherited;
  RecreateControls;
end;

procedure TRibbonApplicationPopupMenu.DoDropCategory(
  Source: TCategoryDragObject; const X, Y: Integer);
begin
  inherited;
  RecreateControls;
end;

procedure TRibbonApplicationPopupMenu.DoDropItem(Source: TActionItemDragObject;
  const X, Y: Integer);
begin
  inherited;
  RecreateControls;
end;

procedure TRibbonApplicationPopupMenu.DrawBackground;
var
  LIcon: TBitmap;
  LOffset: Integer;
  LXOffSet, LYOffset: Integer;
  LIconSize: TIconSize;
  LIconSizeInPixels: Integer;
  LButtonPt: TPoint;
  LPt: TPoint;
  LDrawImage: Boolean;
begin
  inherited;
  RibbonStyle.DrawElement(samBorder, Canvas, ClientRect);
  LButtonPt := ParentControl.ClientToScreen(Point(4, 4));
  LPt := ClientToScreen(Point(0, 0));
  if TCustomActionBar(Owner).Orientation <> boLeftToRight then
    LPt.X := LPt.X + Width;
  LXOffSet := abs(LButtonPt.X - LPt.X);
  LYOffset := abs(LButtonPt.Y - LPt.Y);
  LDrawImage := LYOffset < 25;
  if LDrawImage then
  begin
    if TCustomActionBar(Owner).Orientation = boLeftToRight then
    begin
      RibbonStyle.DrawElement(samButtonShadow, Canvas, Rect(LXOffSet, -LYOffset, LXOffSet+38, -LYOffset+38));
      RibbonStyle.DrawElement(samButtonPressed, Canvas, LXOffSet, -LYOffset, 255);
    end
    else
    begin
      RibbonStyle.DrawElement(samButtonShadow, Canvas, Rect(Width - LXOffSet, -LYOffset, -1, -1));
      RibbonStyle.DrawElement(samButtonPressed, Canvas, Width - LXOffSet, -LYOffset, 255);
    end;
    LIcon := TBitmap.Create;
    try
      LIcon.Assign((FRibbon as TCustomRibbon).GetIcon(LIconSize));
      case LIconSize of
        isSmall:
          begin
            LOffset := 8;
            LIconSizeInPixels := 16;
          end;
        isLarge:
          begin
            LOffSet := 0;
            LIconSizeInPixels := 32;
          end;
      else
        LOffSet := 4;
        LIconSizeInPixels := 24;
      end;
      if TCustomActionBar(Owner).Orientation = boRightToLeft then
        LXOffSet := Width - LXOffSet + 2
      else
        Inc(LXOffSet, 2);
      canvas.StretchDraw(Rect(LXOffSet + LOffSet, -LYOffset + LOffSet+3,
        LXOffSet + LOffSet + LIconSizeInPixels,
        -LYOffset + LOffSet + 3+  + LIconSizeInPixels), LIcon);
    finally
      LIcon.Free;
    end;
  end;
end;

function TRibbonApplicationPopupMenu.GetRibbon: TWinControl;
begin
  Result := FRibbon;
end;

procedure TRibbonApplicationPopupMenu.NCPaint(DC: HDC);
var
  RC, RW: TRect;
  OldHandle: THandle;
begin
  Winapi.Windows.GetClientRect(Handle, RC);
  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
  { Draw border in non-client area }
  OffsetRect(RW, -RW.Left, -RW.Top);
  OldHandle := Canvas.Handle;
  try
    Canvas.Handle := DC;
    Canvas.Pen.Width := 1;
    Canvas.Pen.Color := $00CAAF9B;
    Canvas.Rectangle(RW);
    Canvas.Pen.Color := clWhite;
    InflateRect(RW, -1, -1);
    Canvas.Rectangle(RW);
  finally
    Canvas.Handle := OldHandle;
  end;
end;

              
procedure TRibbonApplicationPopupMenu.PositionPopup(AnOwner: TCustomActionBar; ParentItem: TCustomActionControl);
var
  P: TPoint;
  R: TRect;
  LeftAlign: BOOL;
  Monitor: TMonitor;
  LMonitorLeft: Integer;
begin
  if (AnOwner = nil) or (ParentItem = nil) then
  begin
    Monitor := Screen.MonitorFromPoint(Point(Left, Top));
    P.X := Left;
    P.Y := Top;

    if Left + Width > Monitor.Left + Monitor.Width then
      P.X := Monitor.Left + Monitor.Width - Width;
    if Left < Monitor.Left then
      P.X := Monitor.Left;

    if Top + Height > Monitor.WorkareaRect.Top + Monitor.WorkareaRect.Bottom then
      P.Y := Top - Height;
    if Top < Monitor.WorkareaRect.Top then
      P.Y := Monitor.WorkareaRect.Top;
    if P.Y < Monitor.WorkareaRect.Top then
      P.Y := Monitor.WorkareaRect.Top;
  end
  else
  begin
    with ParentItem do
      case AnOwner.Orientation of
        boLeftToRight: P := AnOwner.ClientToScreen(Point(Left, Top + Height div 2));
        boRightToLeft: P := AnOwner.ClientToScreen(Point(Left + Width - Self.Width,
          Top + Height div 2));
      else
        P := Parent.ClientToScreen(BoundsRect.TopLeft);
        Inc(P.X, Width);
      end;
    // Adjust the position if the menu goes off the edge of the screen
    LeftAlign := True;
    SystemParametersInfo(SPI_GETMENUDROPALIGNMENT, 0, {$IFNDEF CLR}@{$ENDIF}LeftAlign, 0);
    with ParentItem do
    begin
      R.TopLeft := Parent.ClientToScreen(BoundsRect.TopLeft);
      R.BottomRight := Parent.ClientToScreen(BoundsRect.BottomRight);
    end;
    Monitor := Screen.MonitorFromRect(R, mdNearest);
    if P.X < Monitor.Left then P.X := Monitor.Left;
    LMonitorLeft := Monitor.WorkareaRect.Left;
    if P.X + Width > Monitor.WorkareaRect.Right then
    begin
      P.X := Monitor.WorkareaRect.Right - Width;
      if (ParentItem is TCustomMenuItem) and
         (P.X + Width > LMonitorLeft + Monitor.Width - AnOwner.Left + AnOwner.Width) then
        P.X := AnOwner.Left - Width + 2;
    end;
    if (Height > Monitor.Height) then
      P.Y := Monitor.Top
    else if (P.Y + Height > Monitor.WorkareaRect.Bottom) then
      if (ParentItem is TCustomMenuButton) then
      begin
        if R.Top > Monitor.Height div 2 then
          P.Y := P.Y - ParentItem.Height - Height
      end
      else
        P.Y := P.Y - Height + ParentItem.Height + 3;
  end;
  SetBounds(P.X, P.Y, Width, Height);
end;

function TRibbonApplicationPopupMenu.RibbonStyle: TRibbonStyleActionBars;
begin
  if (ActionManager <> nil) and (ActionManager.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(ActionManager.Style)
  else
    Result := RibbonLunaStyle;
end;

procedure TRibbonApplicationPopupMenu.SetColorMap(const Value: TCustomActionBarColorMap);
begin
  inherited;
  if FRecentDocuments <> nil then
  begin
    if Value <> nil then
      FRecentDocuments.Font.Color := Value.FontColor
    else
      FRecentDocuments.Font.Color := clMenuText;
  end;
end;

procedure TRibbonApplicationPopupMenu.SetRibbon(const Value: TWinControl);
begin
  FRibbon := Value;
end;

procedure TRibbonApplicationPopupMenu.WMNCHitTest(var Message: TWMNCHitTest);
var
  R: TRect;
begin
  r.TopLeft := ParentControl.ClientToScreen(ParentControl.BoundsRect.TopLeft);
  r.BottomRight := ParentControl.ClientToScreen(ParentControl.BoundsRect.BottomRight);
  if R.Contains(SmallPointToPoint(message.Pos)) then
    Message.Result := HTTRANSPARENT
  else
    inherited;
end;

{ TRibbonStylePopupMenu }

type
  TApplicationClass = class(TApplication);
  TCustomActionMenuBarClass = class(TCustomActionMenuBar);

procedure TRibbonStylePopupMenu.AlignControls(AControl: TControl;
  var Rect: TRect);
begin
  inherited;
  if (FGripItem <> nil) and FGripItem.Visible then
    FGripItem.SetBounds(0, ClientHeight - 11, ClientWidth, 11);
end;

function TRibbonStylePopupMenu.CanAutoSize(var NewWidth,
  NewHeight: Integer): Boolean;
begin
  inherited CanAutoSize(NewWidth, NewHeight);
  if FGalleryResize in [grVertical, grBoth] then
    NewHeight := NewHeight + 13;
  Result := False;
end;

constructor TRibbonStylePopupMenu.Create(AOwner: TComponent);
begin
  inherited;
  FGalleryResize := grNone;
end;

function TRibbonStylePopupMenu.CreateControl(
  AnItem: TActionClientItem): TCustomActionControl;
var
  LControl: TControl;
begin
  Result := inherited CreateControl(AnItem);
  if (AnItem <> nil) and (Result is TRibbonGalleryControlMenuItem) then
  begin
    LControl := TMenuProperties(AnItem.CommandProperties).ContainedControl;
    TRibbonGalleryControlMenuItem(Result).ContainedControl := LControl;
  end;
end;

destructor TRibbonStylePopupMenu.Destroy;
begin
  FGripItem.Free;
  inherited;
end;

procedure TRibbonStylePopupMenu.SetGalleryResize(const Value: TGalleryResize);
begin
  if FGalleryResize <> Value then
  begin
    if Value = grNone then
      FreeAndNil(FGripItem);
    FGalleryResize := Value;
    if Value <> grNone then
    begin
      if FGripItem = nil then
      begin
        FGripItem := TRibbonGripItem.Create(Self);
        FGripItem.Parent := Self;
      end;
      FGripItem.GalleryResize := FGalleryResize;
    end;
    FGripItem.Visible := FGalleryResize in [grVertical, grBoth];
    if FGripItem.Visible then
      Height := Height + FGripItem.Height
    else
      Height := Height - FGripItem.Height;
    AutoSize := not (FGalleryResize in [grVertical, grBoth]);
    RecreateControls;
    Realign;
  end;
end;


procedure TRibbonStylePopupMenu.WMExitsizemove(var Message: TMessage);
begin
  inherited;
  if Tag = 100 then
    RecreateControls;
end;

procedure TRibbonStylePopupMenu.WMNCHitTest(var Message: TWMNcHittest);
begin
  inherited;
  if (GalleryResize <> grNone) and (Message.Result = HTCLIENT) then
  begin
    if (Message.YPos >= ClientOrigin.Y + FGripItem.Top) then
    begin
      if FGalleryResize = grVertical then
        Message.Result := HTBOTTOM
      else if (Message.XPos >= ClientOrigin.X + FGripItem.Width - 15) then
        Message.Result := HTBOTTOMRIGHT;
      if (Message.Result = HTBOTTOM) or (Message.Result = HTBOTTOMRIGHT) then
      begin
        AutoSize := False;
        Tag := 100;
      end;
    end;
  end;
end;

{ TRibbonRecentDocuments }

constructor TRibbonRecentDocuments.Create(AOwner: TComponent);
begin
  inherited;
  Color := $00EEEAE9;
  ParentFont := True;
  Font.Style := [fsBold];
  Caption := SRecentDocuments;
end;

procedure TRibbonRecentDocuments.Paint;
var
  LRect: TRect;
  LFlags: Cardinal;
begin
  LRect := ClientRect;
  Canvas.Font.Assign(Font);
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  Canvas.FillRect(LRect);
  Canvas.Pen.Color := $00C5C5C5;
  DrawLine(Canvas, Point(0, 0), Point(0, Height));
  Canvas.Pen.Color := $00F5F5F5;
  DrawLine(Canvas, Point(1, 0), Point(1, Height));
  // Draw caption section
  LRect.Bottom := Canvas.TextHeight('qT') + 5;
  inc(LRect.Left, 7);
  Canvas.Brush.Style := bsClear;
  LFlags := DT_LEFT or DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;
  DrawText(Canvas.Handle, Caption, -1, LRect, LFlags);
  Canvas.Pen.Color := $00D8D8D8;
  DrawLine(Canvas, Point(2, LRect.Bottom - 1), Point(Width, LRect.Bottom - 1));
  Canvas.Pen.Color := $00F5F5F5;
  DrawLine(Canvas, Point(2, LRect.Bottom), Point(Width, LRect.Bottom));
end;

{ TRibbonApplicationMenu }

procedure TRibbonApplicationMenuBar.CloseMenu;
var
  LIntf: IRibbonKeyTip;
  LCtrl: TCustomActionControl;
  LAC: TActionClientItem;
begin
  inherited;
  LAC := FindFirstVisibleItem;
  if LAC <> nil then
  begin
    LCtrl := FindFirstVisibleItem.Control;
    if (LCtrl <> nil) and Supports(LCtrl, IRibbonKeyTip, LIntf) then
      LIntf.HideKeyTip('');
  end;
end;

constructor TRibbonApplicationMenuBar.Create(AOwner: TComponent);
begin
  inherited;
  Align := alNone;
  AllowHiding := True;
  Width := 44;
  Height := 44;
  VertMargin := 0;
  HorzMargin := 0;
  FOptionItems := TOptionItems.Create(Self, TOptionItem);
  FRecentItems := TOptionItems.Create(Self, TOptionItem);
  UseSystemFont := False;
//  FindRibbon; // Automatically hook up to a Ribbon if there is one on the form
end;

function TRibbonApplicationMenuBar.CreateControl(
  AnItem: TActionClientItem): TCustomActionControl;
begin
  if AnItem.Index = 0 then
    Result := inherited CreateControl(AnItem)
  else
    Result := nil;
end;

procedure TRibbonApplicationMenuBar.CreateControls;
begin
  while Items.Count > 1 do
    Items.Delete(Items.Count - 1);
  inherited;
end;

destructor TRibbonApplicationMenuBar.Destroy;
begin
  FRibbon := nil;
  FOptionItems.Free;
  FRecentItems.Free;
  inherited;
end;

procedure TRibbonApplicationMenuBar.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  inherited;
  // Only accept drag items if the action bar has no items on it. The action bar
  // is only permitted to have one top level item
  Accept := Accept and not HasItems;
end;

procedure TRibbonApplicationMenuBar.DrawBackground;
var
  LRect: TRect;
  LRibbon: TCustomRibbon;
begin
  LRect := ClientRect;
  Canvas.Brush.Color := clBlack;
  Canvas.FillRect(lrect);
  LRect.Top := -Top;
//  Inc(LRect.Top, 2);
  if FRibbon <> nil then
  begin
    LRibbon := TCustomRibbon(FRibbon);
    LRect.Bottom := LRect.Top + LRibbon.GetRibbonMetric(rmFullHeight);
    if LRibbon.CustomFrameSupported then
    begin
      if LRibbon.GlassFrameSupported then
      begin
        canvas.Brush.color := clBlack;
        canvas.FillRect(LRect);
      end
      else
      begin
        if LRibbon.Active then
          RibbonStyle.DrawElement(srBackground, Canvas, LRect, LRibbon.GetRibbonMetric(rmCaption))
        else
          RibbonStyle.DrawElement(srBackgroundDisabled, Canvas, LRect, LRibbon.GetRibbonMetric(rmCaption));
      end
    end
    else
      RibbonStyle.DrawElement(srBackground, Canvas, LRect, LRibbon.GetRibbonMetric(rmCaption));
    Inc(LRect.Top, LRibbon.GetRibbonMetric(rmCaption));
    RibbonStyle.DrawElement(srBody, Canvas, LRect, -1);

    if LRibbon.QuickAccessToolbar.ActionBar <> nil then
    begin
      if BiDiMode = bdLeftToRight then
      begin
        //15 = width of sqStart
        LRect := Rect(LRibbon.QuickAccessToolbar.ActionBar.Left-15,
                      LRibbon.QuickAccessToolbar.ActionBar.Top - Top, -1, -1);
        RibbonStyle.DrawElement(sqStart, Canvas, LRect);
      end
      else
      begin
        LRect := Rect(LRibbon.QuickAccessToolbar.ActionBar.BoundsRect.Right - left,
          LRibbon.QuickAccessToolbar.ActionBar.Top - Top, -1,-1);
//        LRect := Rect(0,0,15,24);
        RibbonStyle.DrawElement(sqStartRTL, Canvas, LRect);
      end;
    end;
  end;
end;

//procedure TRibbonApplicationMenu.FindRibbon;
//var
//  I: Integer;
//begin
//  for I := 0 to Owner.ComponentCount - 1 do
//  begin
//    if Owner.Components[I] is TCustomRibbon then
//    begin
//      TCustomRibbon(Owner.Components[I]).ApplicationMenu.Menu := Self;
//      Break;
//    end;
//  end;
//end;

function TRibbonApplicationMenuBar.GetControlClass(AnItem: TActionClientItem):
  TCustomActionControlClass;
begin
  Result := TRibbonApplicationMenuButton;
end;

function TRibbonApplicationMenuBar.GetRibbon: TWinControl;
begin
  Result := FRibbon;
end;

function TRibbonApplicationMenuBar.GetVisibleMenu: TCustomActionMenuBar;
begin
  if PopupStack <> nil then
    Result := PopupStack.Peek
  else
    Result := nil;
end;

function TRibbonApplicationMenuBar.GetVisibleMenuCount: Integer;
begin
  if PopupStack <> nil then
    Result := PopupStack.Count
  else
    Result := 0;
end;

function TRibbonApplicationMenuBar.NewPopup: TCustomActionPopupMenu;
var
  LRibbon: TCustomRibbon;
begin
  Result := inherited NewPopup;
  Result.Shadow := False;
  if Result is TRibbonApplicationPopupMenu then
  begin
    LRibbon := FRibbon as TCustomRibbon;
    TRibbonApplicationPopupMenu(Result).SetRibbon(LRibbon);
    TRibbonApplicationPopupMenu(Result).Caption := LRibbon.ApplicationMenu.Caption;
  end;
end;

procedure TRibbonApplicationMenuBar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FRibbon then
      FRibbon := nil;
  end;
end;

procedure TRibbonApplicationMenuBar.Paint;
begin

  inherited;

end;

function TRibbonApplicationMenuBar.RibbonStyle: TRibbonStyleActionBars;
begin
  if Style is TRibbonStyleActionBars then
    Result := TRibbonStyleActionBars(Style)
  else
    Result := RibbonLunaStyle;
end;

procedure TRibbonApplicationMenuBar.SelectApplicationButton;
begin
  TCustomMenuButton(ActionClient.Items[0].Control).Selected := True;
end;

procedure TRibbonApplicationMenuBar.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, 44, 44);
end;

procedure TRibbonApplicationMenuBar.SetOptionItems(const Value: TOptionItems);
begin
  FOptionItems.Assign(Value);
end;

procedure TRibbonApplicationMenuBar.SetRecentItems(const Value: TOptionItems);
begin
  FRecentItems.Assign(Value);
end;

procedure TRibbonApplicationMenuBar.SetRibbon(const Value: TWinControl);
begin
  FRibbon := Value;
  if Value <> nil then
  begin
    Parent := FRibbon;
    if FRibbon is TRibbon then
      Font := TRibbon(FRibbon).Font;
  end;
end;

// Method that tells the Ribbon that the user wants to view the Ribbon KeyTips
// The initial State for KeyTips is ktsTabs whose value is passed in the LParam
// parameter of the message.
//
// To invoke KeyTips, press either the ALT or F10 keys
procedure TRibbonApplicationMenuBar.ShowKeyTips;
begin
  PostMessage(FRibbon.Handle, TCustomRibbon.UM_DISPLAYKEYTIPS, 0, ord(ktsTabs));
end;

procedure TRibbonApplicationMenuBar.WMPaint(var Message: TWMPaint);
var
  DC, MemDC: HDC;
  PS: TPaintStruct;
  PaintBuffer: HPAINTBUFFER;
begin
  if not (csDesigning in ComponentState) and DoubleBuffered and DwmCompositionEnabled then
  begin
    DC := BeginPaint(Handle, PS);
    try
      PaintBuffer := BeginBufferedPaint(DC, PS.rcPaint, BPBF_COMPOSITED, nil, MemDC);
      if PaintBuffer <> 0 then
        try
          Perform(WM_PRINTCLIENT, WParam(MemDC), PRF_CLIENT);
        finally
          EndBufferedPaint(PaintBuffer, True);
        end;
    finally
      EndPaint(Handle, PS);
    end;
  end
  else
    inherited;
end;

procedure TRibbonApplicationMenuBar.WMSysCommand(var Message: TWMSysCommand);
var
  Item: TActionClientItem;
begin
  if (GetParentForm(Self) <> Screen.FocusedForm) and (Application.ModalLevel <> 0) then
    Exit;
  { Enter menu loop if only the Alt key is pressed -- ignore Alt-Space and let
    the default processing show the system menu. }
  if not InMenuLoop and Enabled and Showing then
  begin
    if (Message.CmdType and $FFF0 = SC_KEYMENU) and (Message.Key <> VK_SPACE) and
      (Message.Key <> Word('-')) and (GetCapture = 0) then
    begin
      if Message.Key <> 0 then
      begin
        Item := FindAccelItem(Message.Key);
        if Assigned(Item) then
        begin
          Item.Control.Keyed;
          Message.Result := 1;
        end;
      end
      else if not FCancelMenu then
        ShowKeyTips;
      FCancelMenu := False;
      Message.Result := 1;
    end;
  end;
end;

{ TRibbonStyleMainPopupMenu }

constructor TRibbonStyleMainPopupMenu.Create(AOwner: TComponent);
var
  LControl: TControl;
begin
  inherited;
  BorderWidth := 1;
  EdgeBorders := [];
  HorzMargin := 0;
  VertMargin := 1;
  AutoSize := False;
  AllowScrolling := True;
  LControl := ((AOwner as TRibbonApplicationMenuBar).VisibleMenu as
    TRibbonApplicationPopupMenu).FRecentDocuments;
  Width := LControl.Width - 2;
  Height := LControl.Height - 2;
end;

procedure TRibbonStyleMainPopupMenu.NCPaint(DC: HDC);
var
  RC, RW: TRect;
  OldHandle: THandle;
begin
  Winapi.Windows.GetClientRect(Handle, RC);
  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
  { Draw border in non-client area }
  OffsetRect(RW, -RW.Left, -RW.Top);
  OldHandle := Canvas.Handle;
  try
    Canvas.Handle := DC;
    Canvas.Pen.Width := 1;
    Canvas.Pen.Color := $00CAAF9B;
    Canvas.Rectangle(RW);
    Canvas.Pen.Color := clWhite;
    InflateRect(RW, -1, -1);
    Canvas.Rectangle(RW);
  finally
    Canvas.Handle := OldHandle;
  end;
end;

procedure TRibbonStyleMainPopupMenu.PositionPopup(AnOwner: TCustomActionBar;
  ParentItem: TCustomActionControl);
begin
  FOwner := AnOwner;
  FParentItem := ParentItem;
  inherited;
  SetBounds(Left + 1, FOwner.Top + 18, Width, Height);
  RecreateControls;
end;

{ TRibbonQATCustomizeMenu }

procedure TRibbonQATCustomizeMenu.DisplayShadow;
begin
  inherited;
  if not Shadow or DesignMode then exit;
  if Assigned(ActionClient) and (ActionClient is TActionClientItem) and
    (TActionClientItem(ActionClient).Control is TCustomMenuButton) then
    if not Assigned(FBtnShadow) then
      FBtnShadow := TShadowWindow.CreateShadow(Self, csRight);
  if Assigned(FBtnShadow) then
    FBtnShadow.Control := TActionClientItem(ActionClient).Control;
end;

procedure TRibbonQATCustomizeMenu.DoAddCustomizeItems(
  const ActionClient: TActionClient);
begin
  // inherited;
end;

function TRibbonQATCustomizeMenu.GetControlClass(AnItem: TActionClientItem):
  TCustomActionControlClass;
begin
  if AnItem.Tag = -1 then
    result := inherited GetControlClass(AnItem)
  else
    result := TRibbonCustomizeItem;
end;

procedure TRibbonQATCustomizeMenu.HideShadow;
begin
  inherited;
  if Assigned(FBtnShadow) then
    FBtnShadow.Hide;
end;

procedure TRibbonQATCustomizeMenu.NCPaint(DC: HDC);
var
  RC, RW: TRect;
  OldHandle: THandle;
  Offset: TPoint;
begin
  Winapi.Windows.GetClientRect(Handle, RC);
  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
  { Draw border in non-client area }
  OffsetRect(RW, -RW.Left, -RW.Top);
  OldHandle := Canvas.Handle;
  try
    Canvas.Handle := DC;
    Canvas.Pen.Width := 1;

    Canvas.Pen.Color := ColorMap.FrameTopLeftOuter;
    Canvas.MoveTo(RW.Right, RW.Top);
    Canvas.LineTo(RW.Left, Rw.Top);
    Canvas.LineTo(RW.Left, RW.Bottom);

    Canvas.Pen.Color := ColorMap.FrameTopLeftInner;
    Canvas.MoveTo(RW.Right - 1, RW.Top + 1);
    Canvas.LineTo(RW.Left + 1, Rw.Top + 1);
    Canvas.LineTo(RW.Left + 1, RW.Bottom - 2);

    Canvas.Pen.Color := ColorMap.FrameBottomRightOuter;
    Canvas.MoveTo(RW.Right - 1, RW.Top);
    Canvas.LineTo(RW.Right - 1, RW.Bottom - 1);
    Canvas.LineTo(RW.Left - 1, RW.Bottom - 1);

    Canvas.Pen.Color := ColorMap.FrameBottomRightInner;
    Canvas.MoveTo(RW.Right - 2, RW.Top + 1);
    Canvas.LineTo(RW.Right - 2, RW.Bottom - 2);
    Canvas.LineTo(RW.Left, RW.Bottom - 2);

    if Assigned(ActionClient) and (ColorMap.BtnSelectedColor <> ColorMap.FrameTopLeftOuter) and
       (ParentControl is TXPStyleMenuButton) then
    begin
      Offset := ParentControl.Parent.ClientToScreen(ParentControl.BoundsRect.TopLeft);
      if BoundsRect.Bottom <= Offset.Y then
        Offset.Y := RW.Bottom - 1
      else
        Offset.Y := 0;
      Canvas.MoveTo(Offset.X - Left + 1, Offset.Y);
      Canvas.Pen.Color := ColorMap.BtnSelectedColor;
      Canvas.LineTo(Offset.X - Left + ParentControl.Width - 1, Offset.Y);
    end;

  finally
    Canvas.Handle := OldHandle;
  end;
end;

procedure TRibbonQATCustomizeMenu.PositionPopup(AnOwner: TCustomActionBar;
  ParentItem: TCustomActionControl);
begin
  inherited;
  if (ParentItem is TCustomMenuItem) and (Left > ParentItem.Parent.BoundsRect.Left) then
    Left := ParentItem.Parent.BoundsRect.Right - 1
  else if ParentItem is TCustomMenuButton and (Left > ParentItem.BoundsRect.Left) then
    Left := Left - 1;
end;

procedure TRibbonQATCustomizeMenu.VisibleChanging;
begin
  if ParentControl is TCustomButtonControl then
    ParentControl.Invalidate;
  inherited;
end;

{ TOptionItem }

procedure TOptionItem.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TOptionItem then
  begin
    Action := TOptionItem(Source).Action;
    KeyTip := TOptionItem(Source).KeyTip;
  end;
end;

function TOptionItem.GetDisplayName: string;
begin
  if FAction <> nil then
    result := Format('%s - %s', [ClassName, FAction.Name])
  else
    result := inherited GetDisplayName;
end;

procedure TOptionItem.SetAction(const Value: TContainedAction);
begin
  if FAction <> Value then
  begin
    FAction := Value;
    if FAction <> nil then
    begin
      FCaption := TCustomAction(FAction).Caption;
      FHint := TCustomAction(FAction).Hint;
      FTag := TCustomAction(FAction).Tag;
    end;
  end;
end;

// Creates and initializes the control that is used to display the selection
// pane to the right of the application menu.
procedure TRibbonApplicationPopupMenu.CreateRecentDocuments;
var
  LAC: TActionClientItem;
  LRecentItems: TOptionItems;
  I: Integer;
  LCtrl: TCustomActionControl;
  LApplicationMenu: TRibbonApplicationMenuBar;
  LCommandClass: TCustomActionControlClass;
  LRibbon: TCustomRibbon;
begin
  FRecentDocuments := TRibbonRecentDocuments.Create(Self);
  FRecentDocuments.Align := alNone;
  FRecentDocuments.AlignWithMargins := True;
  FRecentDocuments.Margins.Top := VertMargin;
  FRecentDocuments.Margins.Left := 0;
  FRecentDocuments.Margins.Right := 0;
  FRecentDocuments.Margins.Bottom := VertMargin;
  FRecentDocuments.Parent := Self;
  if Owner is TRibbonApplicationMenuBar then
    LApplicationMenu := (Owner as TRibbonApplicationMenuBar)
  else
    LApplicationMenu := nil;
  if LApplicationMenu = nil then
    Exit;

  LRibbon := TCustomRibbon(LApplicationMenu.GetRibbon);
  if LRibbon.ApplicationMenu.CommandType = ctRecent then
    LCommandClass := TRibbonRecentButtonControl
  else
    LCommandClass := TRibbonMenuSmallButtonControl;

  LRecentItems := LApplicationMenu.RecentItems;
  if LRecentItems.Count > 0 then
  begin
    FRecentClients := TActionClients.Create(ActionManager, TActionClientItem);
    DisableAlign;
    try
      for I := 0 to LRecentItems.Count - 1 do
      begin
        LCtrl := LCommandClass.Create(Owner);
        LCtrl.Parent := Self;
        LAC := FRecentClients.Add;
        LAC.Action := LRecentItems[I].Action;
        LAC.KeyTip := LRecentItems[I].KeyTip;
        if (LRibbon.ApplicationMenu.CommandType = ctRecent) and (I < 10) then
          LAC.Caption := Format('&%d. %s', [I, LRecentItems[I].Caption])
        else
          LAC.Caption := LRecentItems[I].Caption;
        if LRibbon.ApplicationMenu.CommandType = ctCommands then
          LAC.Caption := '  ' + LAC.Caption;
        LAC.ChangesAllowed := [];
        LCtrl.ActionClient := LAC;
        LAC.Control := LCtrl;
      end;
    finally
      EnableAlign;
    end;
  end;
end;

{ TOptionItems }

function TOptionItems.Add: TOptionItem;
begin
  Result := inherited Add as TOptionItem;
end;

function TOptionItems.GetApplicationMenu: TRibbonApplicationMenuBar;
begin
  Result := Owner as TRibbonApplicationMenuBar;
end;

function TOptionItems.GetItem(Index: Integer): TOptionItem;
begin
  Result := inherited GetItem(Index) as TOptionItem;
end;

function TOptionItems.Insert(Index: Integer): TOptionItem;
begin
  Result := inherited Insert(Index) as TOptionItem;
end;

procedure TOptionItems.SetItem(Index: Integer; const Value: TOptionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TRibbonActionPopupMenu }

function TRibbonActionPopupMenu.CreateControl(
  AnItem: TActionClientItem): TCustomActionControl;
var
  LIntf: IRibbonContainedControl;
begin
  Result := inherited CreateControl(AnItem);
  if (AnItem.CommandStyle = csMenu) then
  begin
    if TMenuProperties(AnItem.CommandProperties).ContainedControl <> nil then
    begin
      if Supports(Result, IRibbonContainedControl, LIntf) then
        LIntf.ContainedControl := TMenuProperties(AnItem.CommandProperties).ContainedControl;
    end;
  end;
end;

procedure TRibbonActionPopupMenu.NCPaint(DC: HDC);
var
  RC, RW: TRect;
  OldHandle: THandle;
  Offset: TPoint;
begin
  Winapi.Windows.GetClientRect(Handle, RC);
  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
  { Draw border in non-client area }
  OffsetRect(RW, -RW.Left, -RW.Top);
  OldHandle := Canvas.Handle;
  try
    Canvas.Handle := DC;
    Canvas.Pen.Width := 1;

    Canvas.Pen.Color := ColorMap.FrameTopLeftOuter;
    Canvas.MoveTo(RW.Right, RW.Top);
    Canvas.LineTo(RW.Left, Rw.Top);
    Canvas.LineTo(RW.Left, RW.Bottom);

    Canvas.Pen.Color := ColorMap.FrameTopLeftInner;
    Canvas.MoveTo(RW.Right - 1, RW.Top + 1);
    Canvas.LineTo(RW.Left + 1, Rw.Top + 1);
    Canvas.LineTo(RW.Left + 1, RW.Bottom - 2);

    Canvas.Pen.Color := ColorMap.FrameBottomRightOuter;
    Canvas.MoveTo(RW.Right - 1, RW.Top);
    Canvas.LineTo(RW.Right - 1, RW.Bottom - 1);
    Canvas.LineTo(RW.Left - 1, RW.Bottom - 1);

    Canvas.Pen.Color := ColorMap.FrameBottomRightInner;
    Canvas.MoveTo(RW.Right - 2, RW.Top + 1);
    Canvas.LineTo(RW.Right - 2, RW.Bottom - 2);
    Canvas.LineTo(RW.Left, RW.Bottom - 2);

    if Assigned(ActionClient) and (ColorMap.BtnSelectedColor <> ColorMap.FrameTopLeftOuter) and
       (ParentControl is TRibbonStyleMenuButton) then
    begin
      Offset := ParentControl.Parent.ClientToScreen(ParentControl.BoundsRect.TopLeft);
      if BoundsRect.Bottom <= Offset.Y then
        Offset.Y := RW.Bottom - 1
      else
        Offset.Y := 0;
      Canvas.MoveTo(Offset.X - Left + 1, Offset.Y);
      Canvas.Pen.Color := ColorMap.BtnSelectedColor;
      Canvas.LineTo(Offset.X - Left + ParentControl.Width - 1, Offset.Y);
    end;
  finally
    Canvas.Handle := OldHandle;
  end;
end;

procedure TRibbonActionPopupMenu.TrackMenu;
begin
  if SelectFirstItem then
    PostMessage(Handle, WM_KEYDOWN, VK_DOWN, 0);
  inherited;
  SelectFirstItem := False;
end;

initialization
  RegisterClass(TRibbonApplicationMenuBar);
  
end.
