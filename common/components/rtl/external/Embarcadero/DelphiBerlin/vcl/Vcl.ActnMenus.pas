{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Vcl.ActnMenus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, System.Contnrs, System.Actions,
  Vcl.Buttons, Vcl.Graphics, Vcl.Forms, Vcl.Controls,
  Vcl.ActnList, Vcl.ToolWin, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus, Vcl.StdActns, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.ShadowWnd;

type

{ TMenuStack }

  TCustomActionMenuBar = class;

  TMenuStack = class(TStack)
  private
    FMenu: TCustomActionMenuBar;
    function GetBars(const Index: Integer): TCustomActionMenuBar;
  protected
    property Bars[const Index: Integer]: TCustomActionMenuBar read GetBars;
  public
    constructor Create(AMenu: TCustomActionMenuBar);
    procedure Push(Container: TCustomActionMenuBar);
    function Pop: TCustomActionMenuBar;
    function Peek: TCustomActionMenuBar;
    property List;
  end;

{ TCustomActionBarStyleEx }

  TCustomActionPopupMenu = class;
  TCustomPopupClass = class of TCustomActionPopupMenu;
  TCustomAddRemoveItem = class;
  TCustomAddRemoveItemClass = class of TCustomAddRemoveItem;

  TActionBarStyleEx = class(TActionBarStyle)
  public
    function GetPopupClass(ActionBar: TCustomActionBar): TCustomPopupClass; virtual; abstract;
    function GetAddRemoveItemClass(ActionBar: TCustomActionBar): TCustomAddRemoveItemClass; virtual; abstract;
    function GetScrollBtnClass: TCustomToolScrollBtnClass; virtual; abstract;
  end;

{ TCustomActionMenuBar }

  TAnimationStyle = (asNone, asDefault, asUnFold, asSlide, asFade);
  TMenuPopupEvent = procedure(Sender: TObject;
    Item: TCustomActionControl) of object;
  TGetPopupClassEvent = procedure(Sender: TObject;
    var PopupClass: TCustomPopupClass) of object;
  TExitMenuEvent = procedure(Sender: TCustomActionMenuBar; Cancelled: Boolean) of object;

  TCustomActionMenuBar = class(TCustomActionDockBar)
  private
    FActionIdleTimer: TTimer;
    FAnimatePopups: Boolean;
    FAnimationStyle: TAnimationStyle;
    FDelayItem: TCustomActionControl;
    FDragItem: TCustomActionControl;
    FExpandable: Boolean;
    FExpanded: Boolean;
    FInMenuLoop: Boolean;
    FItemKeyed: Boolean;
    FMouseControl: TControl;
    FParentForm: TCustomForm;
    FParentMenu: TCustomActionMenuBar;
    FParentControl: TCustomActionControl;
    FOnPopup: TMenuPopupEvent;
    FExpandDelay: Integer;
    FRootMenu: TCustomActionMenuBar;
    FDefaultFont: Boolean;
    FOnGetPopupClass: TGetPopupClassEvent;
    FAnimateDuration: Integer;
    FOnEnterMenuLoop: TNotifyEvent;
    FOnExitMenuLoop: TExitMenuEvent;
    FUseSystemFont: Boolean;
    FAutoFocus: Boolean;
    procedure ActionIdleTimerProc(Sender: TObject);
    procedure WMKeyDown(var Message:  TWMKeyDown); message WM_KEYDOWN;
    procedure CMEnterMenuLoop(var Message: TMessage); message CM_ENTERMENULOOP;
    procedure CMFontchanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMItemClicked(var Message: TCMItemMsg); message CM_ITEMCLICKED;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMSysKeyDown(var Message: TWMSysKeyDown); message WM_SYSKEYDOWN;
    procedure SetParentMenu(const Value: TCustomActionMenuBar);
    procedure CMItemKeyed(var Message: TCMItemMsg); message CM_ITEMKEYED;
    procedure SetAnimateDuration(const Value: Integer);
    procedure DoActionIdle;
    procedure SetMouseControl(const Value: TControl);
    procedure SetUseSystemFont(const Value: Boolean);
  protected
    FCachedMenu: TCustomActionPopupMenu;
    FCancelMenu: Boolean;
    FChildMenu: TCustomActionMenuBar;
    FExpandTimer: TTimer;
    FMousePos: TPoint;
    FPopupStack: TMenuStack;
    FPopupTimer: TTimer;
    FSelectedItem: TActionClientItem;
    FResizing: Boolean;
    procedure Animate(Show: Boolean = True);
    procedure Idle(const Msg: TMsg);
    procedure ClearSubMenus;
    procedure CleanupStack;
    function CreatePopup(AOwner: TCustomActionMenuBar;
      Item: TCustomActionControl): TCustomActionPopupMenu; virtual;
    function DoMouseIdle: TControl; deprecated;
    procedure DoItemSelected(AnItem: TCustomActionControl);
    function DoGetPopupClass: TCustomPopupClass; dynamic;
    function DoItemClicked(AnItem: TCustomActionControl): TActionClientItem; virtual;
    function DoSplitItemClicked(AnItem: TCustomActionControl): TActionClientItem; virtual;
    function DoItemKeyed(AnItem: TCustomActionControl): TActionClientItem; virtual;
    procedure DoMenuDelay(Sender: TObject);
    procedure DoneMenuLoop; virtual;
    procedure DoPopup(Item: TCustomActionControl); virtual;
    procedure ExecAction(Action: TContainedAction); virtual;
    procedure Expand(Full: Boolean); virtual;
    procedure ExpandTimer(Sender: TObject);
    procedure GetDefaultSounds; deprecated;
    function GetDesignMode: Boolean; override;
    function GetPopupClass: TCustomPopupClass; virtual;
    function GetMouseHoverItem(Msg: TMsg): TCustomActionControl;
    function GetSelected: TActionClientItem;
    procedure InitMenuLoop; virtual;
    function IsDesignMsg(var Msg: TMsg): Boolean;
    procedure Loaded; override;
    function MouseActivate(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer; HitTest: Integer): TMouseActivate; override;
    function NewPopup: TCustomActionPopupMenu; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function ProcessMenuLoop: TActionClientItem; virtual;
    function ProcessMessage(var Msg: TMsg): Boolean;
    procedure ProcessMessages;
    procedure ProcessMouseMsg(var Msg: TMsg); virtual;
    procedure SelectItem(AnItem: TCustomActionControl);
    procedure Select(const Forward: Boolean); dynamic;
    procedure SetDesignMode(const Value: Boolean); override;
    procedure SetParent(AParent: TWinControl); override;
    procedure SetPersistentHotKeys(const Value: Boolean); override;
    procedure WndProc(var Message: TMessage); override;
    property AnimateDuration: Integer read FAnimateDuration write SetAnimateDuration;
    property DelayItem: TCustomActionControl read FDelayItem write FDelayItem;
    property Expandable: Boolean read FExpandable write FExpandable;
    property Expanded: Boolean read FExpanded write FExpanded;
    property MouseControl: TControl read FMouseControl write SetMouseControl;
    property ParentMenu: TCustomActionMenuBar read FParentMenu write SetParentMenu;
    property Selected: TActionClientItem read GetSelected;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateControl(AnItem: TActionClientItem): TCustomActionControl; override;
    procedure CloseMenu; virtual;
    procedure RecreateControls; override;
    function Style: TActionBarStyle; override;
    procedure TrackMenu; virtual;
    property AnimationStyle: TAnimationStyle read FAnimationStyle write FAnimationStyle;
    property AutoFocus: Boolean read FAutoFocus write FAutoFocus;
    property ExpandDelay: Integer read FExpandDelay write FExpandDelay;
    property InMenuLoop: Boolean read FInMenuLoop write FInMenuLoop;
    property ParentControl: TCustomActionControl read FParentControl write FParentControl;
    property PopupStack: TMenuStack read FPopupStack;
    // Property set when a menu is being resized
    property Resizing: Boolean read FResizing;
    property RootMenu: TCustomActionMenuBar read FRootMenu write FRootMenu;
    property UseSystemFont: Boolean read FUseSystemFont write SetUseSystemFont;
    property OnEnterMenuLoop: TNotifyEvent read FOnEnterMenuLoop write FOnEnterMenuLoop;
    property OnExitMenuLoop: TExitMenuEvent read FOnExitMenuLoop write FOnExitMenuLoop;
    property OnGetPopupClass: TGetPopupClassEvent read FOnGetPopupClass
      write FOnGetPopupClass;
    property OnPopup: TMenuPopupEvent read FOnPopup write FOnPopup;
  end;

{ TCustomMenuExpandBtn }

  TCustomMenuExpandBtn = class(TCustomUtilityButton)
  private
    function GetMenu: TCustomActionMenuBar;
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawFrame(ARect: TRect; Down: Boolean); override;
    procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    property Menu: TCustomActionMenuBar read GetMenu;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TCustomActionPopupMenu }

  TCustomMenuItem = class;
  TCustomMenuExpandBtnClass = class of TCustomMenuExpandBtn;

  TCustomActionPopupMenu = class(TCustomActionMenuBar)
  private
    FBShadow: TShadowWindow;
    FExpandBtn: TCustomMenuExpandBtn;
    FRShadow: TShadowWindow;
    FShadow: Boolean;
    procedure SetShadow(const Value: Boolean);
  protected
    procedure AddEdges(AnItem: TCustomMenuItem); virtual;
    procedure DrawBackground; override;
    function CanAutoSize(var NewWidth: Integer; var NewHeight: Integer): Boolean; override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure CreateControls; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DisplayShadow; virtual;
    procedure ExecAction(Action: TContainedAction); override;
    procedure ExpandClick(Sender: TObject);
    function GetClientRect: TRect; override;
    function GetExpandBtnClass: TCustomMenuExpandBtnClass; virtual;
    procedure HideShadow; virtual;
    function NewPopup: TCustomActionPopupMenu; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PositionPopup(AnOwner: TCustomActionBar;
      ParentItem: TCustomActionControl); virtual;
    procedure SetColorMap(const Value: TCustomActionBarColorMap); override;
    procedure SetupExpandBtn;
    procedure SetOrientation(const Value: TBarOrientation); override;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMPrint(var Message: TMessage); message WM_PRINT;
    procedure WMPrintClient(var Message: TWMPrintClient); message WM_PRINTCLIENT;
    function ValidOrientations: TBarOrientations; dynamic;
    procedure VisibleChanging; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function DesignWndProc(var Message: TMessage): Boolean; override;
    function CreateControl(AnItem: TActionClientItem): TCustomActionControl; override;
    procedure CloseMenu; override;
    procedure Expand(Full: Boolean); override;
    procedure Popup(X, Y: Integer);
    property ExpandBtn: TCustomMenuExpandBtn read FExpandBtn write FExpandBtn;
    property Shadow: Boolean read FShadow write SetShadow;
  end;

{ TCustomizeActionToolBar }

  TCustomizeActionToolBar = class;
  TCustomizeActionToolBarClass = class of TCustomizeActionToolBar;

  TCustomizeActionToolBar = class(TCustomActionPopupMenu)
  private
    FAddlItem: TActionClientItem;
    FResetAction: TCustomAction;
    FResetItem: TActionClientItem;
    procedure CMItemSelected(var Message: TCMItemMsg); message CM_ITEMSELECTED;
  protected
    FActionBar: TCustomActionToolBar;
    function CanAutoSize(var NewWidth: Integer;
      var NewHeight: Integer): Boolean; override;
    procedure Clear; override;
    procedure DoAddCustomizeItems(const AnActionClient: TActionClient); virtual;
    function DoItemClicked(AnItem: TCustomActionControl): TActionClientItem; override;
    function GetAddRemoveItemClass: TCustomAddRemoveItemClass; virtual;
    function GetActionControl(const Index: Integer): TCustomActionControl; override;
    procedure GetSubMenuControlClass(Sender: TCustomActionBar; AnItem: TActionClient;
      var ControlClass: TCustomActionControlClass); virtual;
    function NewPopup: TCustomActionPopupMenu; override;
    procedure SetActionClient(const Value: TActionClient); override;
    property AddlItem: TActionClientItem read FAddlItem;
  public
    constructor Create(AOwner: TComponent); override;
    function ItemCount: Integer; override;
    destructor Destroy; override;
    property AdditionalItem: TActionClientItem read FAddlItem;
  end;

{ TCustomizeActionLink }

  TCustomizeActionLink = class(TActionClientLink)
  protected
    procedure SetEnabled(Value: Boolean); override;
  end;

{ TCustomizeActionClientItem }

  TCustomizeActionClientItem = class(TActionClientItem)
  protected
    function GetActionLinkClass: TActionClientLinkClass; override;
  end;

{ TCustomMDIMenuButton }

  TMDIButtonStyle = (mbMinimize, mbRestore, mbClose);

  TCustomMDIMenuButton = class(TSpeedButton)
  private
    FButtonStyle: TMDIButtonStyle;
  protected
    procedure Paint; override;
  public
    property ButtonStyle: TMDIButtonStyle read FButtonStyle write FButtonStyle;
  end;

{ TCustomActionMainMenuBar }

  TCustomActionMainMenuBar = class(TCustomActionMenuBar)
  private
    FMDIActions: TActionList;
    FMDIActivate: Boolean;
    FInActive: Boolean;
    FShadows: Boolean;
    FWindowMenu: string;
    FMinimizeBtn: TCustomMDIMenuButton;
    FRestoreBtn: TCustomMDIMenuButton;
    FCloseBtn: TCustomMDIMenuButton;
    FMDISeparator: TActionClientItem;
    procedure SetInActive(const Value: Boolean);
    procedure CMEnabledchanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure SetWindowMenu(const Value: string);
    procedure SetShadows(const Value: Boolean);
  protected
    FWindowMenuItem: TActionClientItem;
    procedure Clear; override;
    procedure CreateControls; override;
    procedure CustomAlignPosition(Control: TControl; var NewLeft: Integer;
      var NewTop: Integer; var NewWidth: Integer; var NewHeight: Integer;
      var AlignRect: TRect; AlignInfo: TAlignInfo); override;
    procedure DoneMenuLoop; override;
    procedure GetActiveMDIChild;
    procedure MDIChildMaximized(ChildForm: TCustomForm);
    procedure MDIChildRestored;
    function NewPopup: TCustomActionPopupMenu; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ProcessMouseMsg(var Msg: tagMSG); override;
    procedure RefreshMDIMenu;
    procedure SetDesignMode(const Value: Boolean); override;
    procedure SetupWindowMenu;
    procedure CMWininichange(var Message: TWMWinIniChange); message CM_WININICHANGE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WMSysKeyDown(var Message: TWMSysKeyDown); message WM_SYSKEYDOWN;
    procedure WMSysKeyUp(var Message: TWMSysKeyUp); message WM_SYSKEYUP;
    function MainWndHook(var Message: TMessage): Boolean;
    procedure DrawBackground; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateControl(AnItem: TActionClientItem): TCustomActionControl; override;
    function CanFocus: Boolean; override;
    procedure CloseMenu; override;
    function DesignWndProc(var Message: TMessage): Boolean; override;
    procedure TrackMenu; override;
    property Inactive: Boolean read FInActive write SetInActive;
    property PersistentHotKeys;
    property Shadows: Boolean read FShadows write SetShadows default True;
    // Caption of the Window menu item
    property WindowMenu: string read FWindowMenu write SetWindowMenu;
  end;

{ TActionMainMenuBar }

  TActionMainMenuBar = class(TCustomActionMainMenuBar)
  public
    property Canvas;
  published
    property UseSystemFont default True;
    property ActionManager;
    property Align default alTop;
    property AllowHiding default False;
    property Anchors;
    property AnimateDuration default 150;
    property AnimationStyle default asDefault;
    property AutoFocus default True;
    property BiDiMode default bdLeftToRight;
    property Caption;
    property Color default clBtnFace;
    property ColorMap;
    property Constraints;
    property DragCursor;
    property DragKind default dkDock;
    property DragMode;
    property EdgeBorders default [];
    property EdgeInner default esRaised;
    property EdgeOuter default esLowered;
    property Enabled;
    property ExpandDelay default 4000;
    property Font;
    property HorzMargin;
    property ParentBiDiMode;
    property ParentBackground default False;
    property ParentColor default False;
    property ParentFont default False;
    property ParentShowHint;
    property PersistentHotKeys default False;
    property Shadows;
    property ShowHint;
    property Spacing;
    property Touch;
    property VertMargin;
    property Visible;
    property WindowMenu;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnCanResize;
    property OnClick;
    property OnControlCreated;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnEnterMenuLoop;
    property OnExit;
    property OnExitMenuLoop;
    property OnGesture;
    property OnGetControlClass;
    property OnGetPopupClass;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPaint;
    property OnPopup;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

{ TCustomMenuItem }

  TMenuEdges = set of TEdgeBorder;

  TCustomMenuItem = class(TCustomActionControl)
  private
    FEdges: TMenuEdges;
    FMenu: TCustomActionMenuBar;
    FMouseSelected: Boolean;
    FShortCutBounds: TRect;
    FCYMenu: Integer;
    procedure SetEdges(const Value: TMenuEdges);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMTextchanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    FNoPrefix: string;
    procedure CalcLayout; override;
    procedure DoDragDrop(DragObject: TObject; X: Integer; Y: Integer); override;
    procedure DrawEdge(Edges: TMenuEdges); virtual;
    procedure DrawSubMenuGlyph; virtual;
    procedure DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string;
      TextColor, ShadowColor: TColor); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal;
      Text: string); override;
    procedure DrawUnusedEdges; virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
      Y: Integer); override;
    procedure Paint; override;
    procedure PositionChanged; override;
    procedure SetSelected(Value: Boolean); override;
    procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    property Menu: TCustomActionMenuBar read FMenu;
    property MouseSelected: Boolean read FMouseSelected;
    property ShortCutBounds: TRect read FShortCutBounds write FShortCutBounds;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CalcBounds; override;
    procedure Click; override;
    destructor Destroy; override;
    procedure Keyed; override;
    procedure DragDrop(Source: TObject; X: Integer; Y: Integer); override;
    property Edges: TMenuEdges read FEdges write SetEdges;
  end;

{ TCustomMenuButton }

  TCustomMenuButton = class(TCustomButtonControl)
  private
    FCloseMenu: Boolean;
    FDoClick: Boolean;
    function GetMenu: TCustomActionMenuBar;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    procedure BeginAutoDrag; override;
    procedure DoDragDrop(DragObject: TObject; X: Integer; Y: Integer); override;
    procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal; Text: string); override;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
      Y: Integer); override;
    procedure Paint; override;
    property Menu: TCustomActionMenuBar read GetMenu;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    procedure Keyed; override;
  end;

{ TCustomAddRemoveItem }

  TCustomAddRemoveItem = class(TCustomMenuItem)
  protected
    function IsActionVisible: Boolean;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
      Y: Integer); override;
    procedure SetEnabled(Value: Boolean); override;
  public
    procedure CalcBounds; override;
  end;

  TMenuItemControlClass = class of TCustomMenuItem;
  TAddRemoveItemClass = class of TCustomAddRemoveItem;
  TMenuButtonControlClass = class of TCustomMenuButton;

type
  TUpdateActnMenusProc = procedure;

var
  MenuItemControlClass: TMenuItemControlClass deprecated;
  MenuAddRemoveItemClass: TAddRemoveItemClass deprecated;
  MenuButtonControlClass: TMenuButtonControlClass deprecated;
  MenuPopupClass: TCustomPopupClass deprecated;
  MenuCustomizePopupClass: TCustomizeActionToolBarClass deprecated;
  UpdateActnMenusProc: TUpdateActnMenusProc;

procedure RegisterActnBarStyle(AStyle: TActionBarStyleEx);
procedure UnRegisterActnBarStyle(AStyle: TActionBarStyleEx);

implementation

uses
{$IF DEFINED(CLR)}
  Variants, System.Runtime.InteropServices, System.Threading, System.Security.Permissions,
{$ENDIF}
{$IF NOT DEFINED(CLR)}
  Winapi.oleacc, Vcl.ABAccessibility,
{$ENDIF}
  System.Types, System.UITypes, System.SysUtils, Vcl.Dialogs, Vcl.Consts, Winapi.MMSystem, Vcl.GraphUtil,
  Winapi.CommCtrl, Vcl.ExtActns, Vcl.ListActns, Vcl.ActnColorMaps, Vcl.ImgList,
  Vcl.Themes;

function GetShadow(Popup: TCustomActionPopupMenu): Boolean;
var
  DisplayShadow: BOOL;
begin
  DisplayShadow := True;
  // SPI_GETDROPSHADOW Requires WinXP
  if CheckWin32Version(5,1) and
{$IF DEFINED(CLR)}
     SystemParametersInfo(SPI_GETDROPSHADOW, 0, DisplayShadow, 0) then
{$ELSE}
     SystemParametersInfo(SPI_GETDROPSHADOW, 0, @DisplayShadow, 0) then
{$ENDIF}
    Popup.FShadow := DisplayShadow;
  Result := Popup.Shadow;
end;

{ TMenuStack }

constructor TMenuStack.Create(AMenu: TCustomActionMenuBar);
begin
  inherited Create;
  FMenu := AMenu;
end;

function TMenuStack.GetBars(const Index: Integer): TCustomActionMenuBar;
begin
  Result := TCustomActionMenuBar(List[Index]);
end;

function TMenuStack.Peek: TCustomActionMenuBar;
begin
  Result := TCustomActionMenuBar(inherited PeekItem);
end;

function TMenuStack.Pop: TCustomActionMenuBar;
begin
  Result := TCustomActionMenuBar(PopItem);
  if csDesigning in FMenu.ComponentState then
    FreeAndNil(Result)
  else
  if Assigned(Result.ActionClient) then
  begin
    Result.ActionClient.ChildActionBar := nil;
    Result.FChildMenu := nil;
    Result.ActionClient := nil;
                                                   
//    if Assigned(Result.RootMenu) and not (csDesigning in Result.RootMenu.ComponentState) and
//       (Result.RootMenu.PopupStack.Peek <> nil) and (Result.RootMenu.PopupStack.Peek.Selected <> nil) then
//      NotifyWinEvent(EVENT_OBJECT_FOCUS, Result.RootMenu.PopupStack.Peek.Handle, OBJID_CLIENT, Result.RootMenu.PopupStack.Peek.Selected.Index + 1);
    if (Count = 1) and not (FMenu is TCustomActionPopupMenu) then
      Peek.FCachedMenu := Result as TCustomActionPopupMenu
    else
      FreeAndNil(Result);
  end;
end;

procedure TMenuStack.Push(Container: TCustomActionMenuBar);
begin
  PushItem(Container);
end;

type
{$IF NOT DEFINED(CLR)}
  TApplicationClass = class(TApplication);
{$ENDIF}

{ TMenuList }

  TMenuList = class(TList)
  private
    function GetMenu(const Index: Integer): TCustomActionMenuBar;
  protected
    procedure Notify(Ptr: TCustomData; Action: TListNotification); override;
  public
    property Menus[const Index: Integer]: TCustomActionMenuBar read GetMenu;
  end;

  TMDIAction = (maActivate, maClose, maRestore, maMinimize);

  TInternalMDIAction = class(TWindowAction)
  private
    FClientItem: TActionClientItem;
    FMenu: TCustomActionMainMenuBar;
    FMDIAction: TMDIAction;
  public
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    property MDIAction: TMDIAction read FMDIAction write FMDIAction;
    property ClientItem: TActionClientItem read FClientItem write FClientItem;
    property Menu: TCustomActionMainMenuBar read FMenu write FMenu;
  end;

{ TMenuList }

function TMenuList.GetMenu(const Index: Integer): TCustomActionMenuBar;
begin
  Result := TCustomActionMenuBar(Items[Index]);
end;

{ TInternalMDIAction }

destructor TInternalMDIAction.Destroy;
begin
  if Assigned(FClientItem) then
    FClientItem.Free;
  inherited;
end;

procedure TInternalMDIAction.ExecuteTarget(Target: TObject);
begin
  case MDIAction of
    maActivate: SendMessage(GetParent(Form.Handle), WM_MDIACTIVATE, Form.Handle, 0);
    maClose: Form.Close;
    maRestore: SendMessage(GetParent(Form.Handle), WM_MDIRESTORE, Form.Handle, 0);
    maMinimize: ShowWindow(Form.Handle, SW_MINIMIZE);
  end;
end;

function TInternalMDIAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := True;
end;

procedure TInternalMDIAction.UpdateTarget(Target: TObject);
begin
  Enabled := True;
end;

var
  MenuCallWndHook: HHOOK;
  MenuList: TMenuList;
  ActiveMenu: TCustomActionMenuBar;

{ Hook required for Main Menu Support }

{$IF DEFINED(CLR)}
function CallWndHook(Code: Integer; wparam: WPARAM; lparam: LPARAM): LRESULT;
var
 Msg: TCWPStruct;
{$ELSE}
function CallWindowHook(Code: Integer; wparam: WPARAM; Msg: PCWPStruct): Longint; stdcall;
{$ENDIF}

  procedure UpdateMDIMenuButtons;
  var
    I: Integer;
    Parent: THandle;
    ParentForm: TWinControl;
    Form: TCustomForm;
  begin
    Parent := GetParent(Msg.hwnd);
    if Parent = 0 then exit;
    ParentForm := FindControl(Parent);
    for I := 0 to MenuList.Count - 1 do
    begin
      Form := GetParentForm(MenuList.Menus[I]);
      if (Form = ParentForm) and (MenuList.Menus[I] is TCustomActionMainMenuBar) then
      begin
        if (Msg.Message = WM_MDIDESTROY) and (Form is TForm) and (TForm(Form).MDIChildCount = 1)  then
          with TCustomActionMainMenuBar(MenuList.Menus[I]) do
            MDIChildRestored
        else
          with TCustomActionMainMenuBar(MenuList.Menus[I]) do
            GetActiveMDIChild;
        break;
      end;
    end;
  end;

begin
{$IF DEFINED(CLR)}
  Msg := TCWPStruct(Marshal.PtrToStructure(IntPtr(lparam), TypeOf(TCWPStruct)));
{$ENDIF}
  if Code = HC_ACTION then
    case Msg.message of
      // Use of WM_SIZE is required for any Windows version except Themed XP
      WM_MDIGETACTIVE, WM_SIZE, WM_MDIDESTROY: UpdateMDIMenuButtons;
      WM_ACTIVATE:
        // Don't close the ActiveMenu if it is currently being resized
        if (ActiveMenu is TCustomActionPopupMenu) and
          ((ActiveMenu <> nil) and not ActiveMenu.Resizing) then
          ActiveMenu.CloseMenu;
      WM_SETTINGCHANGE:
        if Assigned(UpdateActnMenusProc) then
          UpdateActnMenusProc;
    end;
{$IF DEFINED(CLR)}
  Result := CallNextHookEx(MenuCallWndHook, Code, WParam, lparam);
{$ELSE}
  Result := CallNextHookEx(MenuCallWndHook, Code, WParam, Winapi.Windows.LPARAM(Msg));
{$ENDIF}
end;

{$IF DEFINED(CLR)}
const
  CallWindowHook: TFNHookProc = @CallWndHook; // reference to keep the delegate alive
{$ENDIF}

procedure AddMenuToList(Menu: TCustomActionMenuBar);
begin
  if MenuList = nil then
    MenuList := TMenuList.Create;
  if Assigned(Menu) and (MenuList.IndexOf(Menu) = -1) then
    MenuList.Add(Menu);
end;

procedure RemoveMenuFromList(Menu: TCustomActionMenuBar);
begin
  if Assigned(MenuList) then
  begin
    MenuList.Remove(Menu);
    if MenuList.Count = 0 then
      FreeAndNil(MenuList);
  end;
end;

procedure TMenuList.Notify(Ptr: TCustomData; Action: TListNotification);
begin
  if (Action = lnAdded) and (Count = 1) then
    MenuCallWndHook := SetWindowsHookEx(WH_CALLWNDPROC,
      {$IFNDEF CLR}@{$ENDIF}CallWindowHook, 0, GetCurrentThreadID)
  else if (Action = lnDeleted) and (Count = 0) and (MenuCallWndHook <> 0) then
    begin
      UnHookWindowsHookEx(MenuCallWndHook);
      MenuCallWndHook := 0;
    end;
  inherited Notify(Ptr, Action);
end;

{ TCustomActionMenuBar }

constructor TCustomActionMenuBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAnimationStyle := asDefault;
  EdgeOuter := esNone;
  // Expand delay interval should probably come from the registry (somewhere)
  FExpandDelay := 4000;
  FDefaultFont := True;
  FAnimatePopups := True;
  AddMenuToList(Self);
  FAnimateDuration := 150;
  FUseSystemFont := True;
  FAutoFocus := True;
  Font.Assign(Screen.MenuFont);
  FActionIdleTimer := TTimer.Create(nil);
  FActionIdleTimer.Enabled := False;
  FActionIdleTimer.OnTimer := ActionIdleTimerProc;
end;

destructor TCustomActionMenuBar.Destroy;
begin
  if ActiveMenu = Self then
    ActiveMenu := nil;
  if Designable and Assigned(ActionBarDesigner) then
    ActionBarDesigner.SetActiveMenu(nil);
  RemoveMenuFromList(Self);
  if Assigned(FParentMenu) then
    FParentMenu.FChildMenu := nil;
  FreeAndNil(FCachedMenu);
  FActionIdleTimer.Free;
  inherited Destroy;
end;

procedure TCustomActionMenuBar.Animate(Show: Boolean = True);
type
  TAnimationStyle = array[Boolean] of Integer;
var
  Animate: BOOL;
  P: TPoint;
const
  HideShow: array[Boolean] of Integer = (AW_HIDE, 0);
  UnfoldAnimationStyle: TAnimationStyle =
    (AW_VER_POSITIVE or AW_HOR_POSITIVE or AW_SLIDE,
     AW_VER_NEGATIVE or AW_HOR_POSITIVE or AW_SLIDE);
  SlideAnimationStyle: TAnimationStyle =
    (AW_VER_POSITIVE or AW_SLIDE, AW_VER_NEGATIVE or AW_SLIDE);
  FadeAnimationStyle: TAnimationStyle = (AW_BLEND, AW_BLEND);

  procedure DefaultSystemAnimation;
  begin
    SystemParametersInfo(SPI_GETMENUANIMATION, 0, {$IFNDEF CLR}@{$ENDIF}Animate, 0);
    if Assigned(AnimateWindowProc) and (FParentMenu.FAnimatePopups or
      not Show) and Animate then
    begin
      SystemParametersInfo(SPI_GETMENUFADE, 0, {$IFNDEF CLR}@{$ENDIF}Animate, 0);
      if Animate then
      begin
        AnimateWindowProc(Handle, FAnimateDuration, AW_BLEND or HideShow[Show]);
      end
      else
      begin
        P := FParentControl.Parent.ClientToScreen(FParentControl.BoundsRect.TopLeft);
        AnimateWindowProc(Handle, FAnimateDuration, UnfoldAnimationStyle[Top < P.Y - 5] or
          HideShow[Show]);
      end;
    end;
  end;

  procedure DoAnimation(Style: TAnimationStyle);
  begin
    if Assigned(AnimateWindowProc) and FParentMenu.FAnimatePopups or not Show then
    begin
      P := FParentControl.ClientToScreen(Point(FParentControl.Left, FParentControl.Top));
      if (FAnimationStyle = asSlide) and not Show then exit;
      if FParentControl is TCustomMenuItem then
        P := Point(FParentControl.Left + FParentControl.Parent.Left,
          FParentControl.Top + FParentControl.Parent.Top)
      else
        P := FParentControl.Parent.ClientToScreen(FParentControl.BoundsRect.TopLeft);
      AnimateWindowProc(Handle, FAnimateDuration, Style[P.Y > Top + 2] or HideShow[Show]);
    end;
  end;

begin
  if DesignMode or RootMenu.FItemKeyed then exit;
  case FAnimationStyle of
    asDefault: DefaultSystemAnimation;
    asUnFold : DoAnimation(UnfoldAnimationStyle);
    asSlide  :
      begin
        if FAnimateDuration > 100 then
        begin
          Dec(FAnimateDuration, 100);
          DoAnimation(SlideAnimationStyle);
          Inc(FAnimateDuration, 100);
        end
        else
          DoAnimation(SlideAnimationStyle);
      end;
    asFade   : DoAnimation(FadeAnimationStyle);
  end;
end;

procedure TCustomActionMenuBar.CleanupStack;
begin
  if Assigned(FPopupStack) and not FPopupStack.Peek.FInMenuLoop then
    FPopupStack.Peek.CloseMenu;
end;

procedure TCustomActionMenuBar.ClearSubMenus;
var
  I: Integer;
begin
  if not FInMenuLoop or not Assigned(FPopupStack) then exit;
  for I := 1 to FPopupStack.Count - 1 do
    FPopupStack.Peek.CloseMenu;   // CloseMenu pops the top menu off the stack
end;

procedure TCustomActionMenuBar.CloseMenu;
begin
  if Assigned(RootMenu) then
  begin
    RootMenu.DelayItem := nil;
    RootMenu.MouseControl := nil;
  end;
  if Assigned(ParentMenu) then
    ParentMenu.FAnimatePopups := False;
  InMenuLoop := False;
  if Assigned(RootMenu) and Assigned(RootMenu.PopupStack) then
  begin
    if RootMenu.PopupStack.Peek = RootMenu then
    begin
      InMenuLoop := False;
      if Assigned(Selected) then
        Selected.Control.Selected := False;
    end
    else
      RootMenu.PopupStack.Pop;
  end;
end;

procedure TCustomActionMenuBar.CMItemClicked(var Message: TCMItemMsg);
{$IF DEFINED(CLR)}
var
  ObjHandle: GCHandle;
begin
  if FInMenuLoop then
  begin
    if (Message.OriginalMessage.WParam <> 0) and
      (Message.OriginalMessage.LParam <> 0) then
    begin
      ObjHandle := GCHandle(IntPtr(Message.OriginalMessage.LParam));
      if ObjHandle.IsAllocated then
        ObjHandle.Free;
      Message.OriginalMessage.LParam := 0;
    end;
    exit;
  end;
  PostMessage(Handle, Message.Msg, Message.OriginalMessage.WParam,
    Message.OriginalMessage.LParam);
  TrackMenu;
end;
{$ELSE}
begin
  if FInMenuLoop then Exit;
  PostMessage(Handle, Message.Msg, 0, Winapi.Windows.LPARAM(Message.Sender));
  TrackMenu;
end;
{$ENDIF}

procedure TCustomActionMenuBar.CMEnterMenuLoop(var Message: TMessage);
begin
  TrackMenu;
end;

procedure TCustomActionMenuBar.CMItemKeyed(var Message: TCMItemMsg);
{$IF DEFINED(CLR)}
var
  ObjHandle: GCHandle;
begin
  if FInMenuLoop then
  begin
    if (Message.OriginalMessage.WParam <> 0) and
      (Message.OriginalMessage.LParam <> 0) then
    begin
      ObjHandle := GCHandle(IntPtr(Message.OriginalMessage.LParam));
      if ObjHandle.IsAllocated then
        ObjHandle.Free;
      Message.OriginalMessage.LParam := 0;
    end;
    exit;
  end;
  PostMessage(Handle, Message.Msg, Message.OriginalMessage.WParam,
    Message.OriginalMessage.LParam);
  TrackMenu;
end;
{$ELSE}
begin
  if FInMenuLoop then Exit;
  PostMessage(Handle, Message.Msg, 0, Winapi.Windows.LPARAM(Message.Sender));
  TrackMenu;
end;
{$ENDIF}

function TCustomActionMenuBar.CreateControl(
  AnItem: TActionClientItem): TCustomActionControl;
const
  Alignment: array [TBarOrientation] of TAlign = (alNone, alNone, alTop,
    alTop);
begin
  Result := inherited CreateControl(AnItem);
  Result.ShowHint := False;
  AnItem.ShowCaption := True;
  if not Result.Separator then
    Result.Enabled := Result.Enabled and (Assigned(AnItem.Action) or
      (AnItem.HasItems and (AnItem.Items.VisibleCount > 0)));
end;

function TCustomActionMenuBar.CreatePopup(AOwner: TCustomActionMenuBar;
  Item: TCustomActionControl): TCustomActionPopupMenu;
var
  OldVisible: Boolean;
begin
  Result := nil;
  if not InMenuLoop or (AOwner = nil) or (Item = nil) or (FPopupStack.Count = 0) or
     (FPopupStack.Peek.ParentControl = Item) or (Item.ActionClient = nil) or
     (Item.ActionClient.Items.VisibleCount = 0) then
    exit;
  DoPopup(Item);
  FDelayItem := nil;
  Result := NewPopup;
  with Result do
  begin
    DisableAlign;
    try
      ColorMap := Self.ColorMap;
      Color := ColorMap.MenuColor;
      RootMenu := Self.RootMenu;
      Designable := Self.Designable;
      Item.ActionClient.ChildActionBar := Result;
      Font.Assign(Self.Font);
      ParentMenu := AOwner;
      FInMenuLoop := True;
      ParentControl := Item;
      OldVisible := Item.ActionClient.Visible;
      ActionClient := Item.ActionClient;
      Item.ActionClient.Visible := OldVisible;
      Expanded := Self.Expanded or Self.DesignMode or (FindFirstVisibleItem = nil)
        or not Item.ActionClient.Items.HideUnused;
      if Expanded then
        Expand(False);
      ParentWindow := Application.Handle;
      DesignMode := AOwner.DesignMode;
    finally
      EnableAlign;
    end;
    Show;
  end;
  if Item is TCustomMenuButton then Item.Invalidate;
  FExpandTimer.Enabled := Result.Expandable and not Result.Expanded;
end;

procedure TCustomActionMenuBar.DoItemSelected(AnItem: TCustomActionControl);
begin
  if (AnItem is TCustomMenuItem) then
    RootMenu.FDelayItem := AnItem
  else
    FDelayItem := nil;
  RootMenu.FPopupTimer.Enabled := True;
  // Reset the expand timer every time new item is selected
  if not RootMenu.FPopupStack.Peek.Expandable {or (AnItem.Owner = Self)} then
    exit;
  RootMenu.FExpandTimer.Enabled := False;
  // Tag = 1 indicates that when the timer fires that it should only
  // highlight the expand button rather than expand the popup menu
  if Selected <> FindFirstVisibleItem then
    RootMenu.FExpandTimer.Tag := 1;
  RootMenu.FExpandTimer.Enabled := not DesignMode;
end;

procedure TCustomActionMenuBar.ExecAction(Action: TContainedAction);
begin
  if (Action = nil) or (csDesigning in ComponentState) then exit;
  if not DesignMode then
  begin
    sndPlaySound(nil, SND_NODEFAULT);
    sndPlaySound('MenuCommand', SND_NOSTOP or SND_ASYNC or SND_NODEFAULT);
    FSelectedItem.ActionLink.Execute;
  end;
end;

function TCustomActionMenuBar.DoGetPopupClass: TCustomPopupClass;
begin
  Result := GetPopupClass;
  if Assigned(FOnGetPopupClass) then
    FOnGetPopupClass(Self, Result)
end;

function TCustomActionMenuBar.DoItemClicked(
  AnItem: TCustomActionControl): TActionClientItem;
var
  SelectionFade: BOOL;
  I: Integer;
  SelectedItem: TActionClientItem;
begin
  Result := nil;
  if (AnItem.Owner = Self) then
  begin
    if AnItem is TCustomMenuButton then
    begin
      ClearSubMenus;
      AnItem.Invalidate;
    end;
    FDelayItem := nil;
  end;
  if AnItem.ActionClient.HasItems then
  begin
    if Assigned(FDelayItem) then
    begin
      while FPopupStack.Peek <> FDelayItem.Parent do
        RootMenu.PopupStack.Pop;
      FDelayItem := nil;
    end;
    if not AnItem.Visible then
      FPopupStack.Peek.Expand(True);
    SelectedItem := Selected;
    RootMenu.ProcessMessages;
    if Selected <> SelectedItem then exit;
    if FPopupStack = nil then exit;
    if (AnItem.Parent = RootMenu) and (FPopupStack.Count > 1) then
      while FPopupStack.Count > 1 do
        FPopupStack.Peek.CloseMenu;
    CreatePopup(FPopupStack.Peek, AnItem);
    FAnimatePopups := False;
  end
  else
  begin
    Result := AnItem.ActionClient;
    if not DesignMode then
    begin
      SystemParametersInfo(SPI_GETSELECTIONFADE, 0, {$IFNDEF CLR}@{$ENDIF}SelectionFade, 0);
      if (FPopupStack.Count > 1) and SelectionFade then
        for I := 1 to FPopupStack.Count - 2 do
          FPopupStack.Bars[I].Visible := False;
      ClearSubMenus;
      CloseMenu;
    end;
  end;
end;
function TCustomActionMenuBar.DoSplitItemClicked(
  AnItem: TCustomActionControl): TActionClientItem;
var
  SelectionFade: BOOL;
  I: Integer;
begin
  Result := AnItem.ActionClient;
  if not DesignMode then
  begin
    SystemParametersInfo(SPI_GETSELECTIONFADE, 0, {$IFNDEF CLR}@{$ENDIF}SelectionFade, 0);
    if (FPopupStack.Count > 1) and SelectionFade then
      for I := 1 to FPopupStack.Count - 2 do
        FPopupStack.Bars[I].Visible := False;
    ClearSubMenus;
    CloseMenu;
  end;
end;

function TCustomActionMenuBar.DoItemKeyed(
  AnItem: TCustomActionControl): TActionClientItem;
var
  Item: TActionClientItem;
begin
  FItemKeyed := True;
  try
    Result := DoItemClicked(AnItem);
    if not Assigned(Result) then
    begin
      // if the keyboard was used to display the popup then automatically
      // select the first item if the mouse was used no item is selected
      Item := FPopupStack.Peek.FindFirstVisibleItem;
      if Assigned(Item) and Assigned(Item.Control) then
        Item.Control.Selected := True;
    end;
  finally
    FItemKeyed := False;
  end;
end;

procedure TCustomActionMenuBar.GetDefaultSounds;
begin
  // ActionBand menus now use PlaySound API and Windows sound command aliases
end;

function TCustomActionMenuBar.IsDesignMsg(var Msg: TMsg): Boolean;
begin
  Result := DesignMode and not Mouse.IsDragging;
  if Result then
  begin
    Result := Assigned(FDragItem) or Mouse.IsDragging;
    if Result then  // Allow mouse up to end the drag operation
    begin
      Result := (Msg.message <> WM_LBUTTONUP);
      exit;
    end;
    Result := Assigned(FParentForm) and (GetForeGroundWindow <> FParentForm.Handle);
    if csDesigning in ComponentState then
      Result := Result and (Msg.Message <> CM_ITEMCLICKED)
    else
      Result := Assigned(RootMenu) and not RootMenu.InMenuLoop;
  end;
end;

procedure TCustomActionMenuBar.DoMenuDelay(Sender: TObject);
var
  P: TPoint;
begin
  FPopupTimer.Enabled := False;
  if DelayItem = nil then exit;
  if (FDelayItem.Parent = nil) or
     Assigned(FDelayItem.ActionClient.ChildActionBar) then exit;
  while (RootMenu.PopupStack.Count > 1) and
     (RootMenu.PopupStack.Peek <> FDelayItem.Parent) do
    RootMenu.PopupStack.Pop;
  GetCursorPos(P);
  if FDelayItem.BoundsRect.Contains(FPopupStack.Peek.ScreenToClient(P)) then
    CreatePopup(FPopupStack.Peek, FDelayItem);
end;

procedure TCustomActionMenuBar.DoneMenuLoop;
begin
  MouseControl := nil;
  FreeAndNil(FCachedMenu);
  ActiveMenu := nil;
  if Designable and Assigned(ActionBarDesigner) then
    ActionBarDesigner.SetActiveMenu(nil);
  FAnimatePopups := True;
  ShowCaret(0);
  FreeAndNil(FPopupTimer);
  FreeAndNil(FPopupStack);
  FreeAndNil(FExpandTimer);
{$IF NOT DEFINED(CLR)}
  NotifyWinEvent(EVENT_SYSTEM_MENUEND, Handle, OBJID_MENU, CHILDID_SELF);  
{$ENDIF}
end;

procedure TCustomActionMenuBar.DoPopup(Item: TCustomActionControl);
begin
  if Assigned(FOnPopup) then
    FOnPopup(Self, Item);
end;

procedure TCustomActionMenuBar.Expand(Full: Boolean);
var
  I: Integer;
begin
  FExpanded := True;
  if Full then
    RootMenu.Expanded := Full;
  FExpandable := False;
  if not HasItems then exit;
  DisableAlign;
  try
    for I := 0 to Items.Count - 1 do
      Items[I].Control.Visible := Items[I].Visible;
    RequestAlign;
  finally
    EnableAlign;
  end;
end;

procedure TCustomActionMenuBar.ExpandTimer(Sender: TObject);
begin
  FExpandTimer.Enabled := False;
  if RootMenu.PopupStack.Peek.Expandable then
    // Tag = 1 indicates that when the timer fires that it should only
    // highlight the expand button rather than expand the popup menu
    if FExpandTimer.Tag = 1 then
      with TCustomActionPopupMenu(FPopupStack.Peek).ExpandBtn do
        Flat := False
    else
    begin
      FExpanded := True;
      FPopupStack.Peek.Expand(True);
    end;
end;

function TCustomActionMenuBar.GetDesignMode: Boolean;
begin
  Result := inherited GetDesignMode;
  if not Result and Assigned(FParentMenu) and (FParentMenu <> Self) then
    Result := FParentMenu.DesignMode;
end;

function TCustomActionMenuBar.GetMouseHoverItem(Msg: TMsg): TCustomActionControl;
var
  I: Integer;
  Control: TControl;
  ARootMenu: TCustomActionMenuBar;
begin
  Result := nil;
  Control := nil;
  ARootMenu := RootMenu;
  if Assigned(ARootMenu) then
  begin
    for I := ARootMenu.PopupStack.Count - 1 downto 0 do
      if WindowFromPoint(Msg.pt) = ARootMenu.PopupStack.Bars[I].Handle then
        with ARootMenu.PopupStack.Bars[I] do
          Control := ControlAtPos(ScreenToClient(Msg.Pt), True);
    if Control is TCustomActionControl then
      Result := TCustomActionControl(Control);
  end;
end;

function TCustomActionMenuBar.GetPopupClass: TCustomPopupClass;
begin
  if Style <> nil then
    Result := TActionBarStyleEx(Style).GetPopupClass(Self)
  else
    Result := TActionBarStyleEx(ActionBarStyles.Style[0]).GetPopupClass(Self);
end;

function TCustomActionMenuBar.GetSelected: TActionClientItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ItemCount - 1 do
    if Assigned(ActionControls[I]) and ActionControls[I].Selected then
    begin
      Result := ActionControls[I].ActionClient;
      break;
    end;
end;

procedure TCustomActionMenuBar.InitMenuLoop;
var
  DelayTime: Integer;
  ParentFrm: TCustomForm;
begin
  FMousePos := Mouse.CursorPos;
  // Need to use FSelectedItem because it's possible for the item to be
  // destroyed in designmode before TrackMenu gets an opportunity to execute
  // the associated action
  FSelectedItem := nil;
  FExpanded := False;
  FDelayItem := nil;
  if csDesigning in ComponentState then
    DelayTime := 1
  else
  begin
    SystemParametersInfo(SPI_GETMENUSHOWDELAY, 0, {$IFNDEF CLR}@{$ENDIF}DelayTime, 0);
    if DelayTime = 0 then
      Inc(Delaytime);
  end;
  if not (csDesigning in ComponentState) and FAutoFocus then
  begin
    ParentFrm := GetParentForm(Self);
    if Assigned(ParentFrm) then
      ParentFrm.SetFocus;
  end;
  FPopupTimer := TTimer.Create(nil);
  FPopupTimer.OnTimer := DoMenuDelay;
  FPopupTimer.Interval := DelayTime;
  FPopupTimer.Enabled := False;
  FPopupStack := TMenuStack.Create(Self);
  FPopupStack.Push(Self);
  FExpandTimer := TTimer.Create(nil);
  with FExpandTimer do
  begin
    Enabled := False;
    Interval := FExpandDelay;
    OnTimer := ExpandTimer;
  end;
  FInMenuLoop := True;
  HideCaret(0);
  ActiveMenu := Self;
  if Designable and Assigned(ActionBarDesigner) then
    ActionBarDesigner.SetActiveMenu(ActiveMenu);
{$IF NOT DEFINED(CLR)}
  NotifyWinEvent(EVENT_SYSTEM_MENUSTART, Handle, OBJID_MENU, CHILDID_SELF);
{$ENDIF}
end;

function TCustomActionMenuBar.MouseActivate(Button: TMouseButton; Shift: TShiftState;
  X, Y, HitTest: Integer): TMouseActivate;
begin
  Result := inherited MouseActivate(Button, Shift, X, Y, HitTest);
  if (Result = maDefault) and not FAutoFocus then
    Result := maNoActivate;
end;

function TCustomActionMenuBar.NewPopup: TCustomActionPopupMenu;
begin
  Result := nil;
  if Assigned(RootMenu.PopupStack.Peek.FCachedMenu) then
  begin
    Result := RootMenu.PopupStack.Peek.FCachedMenu;
    FreeAndNil(Result.FExpandBtn);
    Result.FExpandable := False;
    Result.FExpanded := False;
    Result.SetBounds(0,0, 150, 50);
  end;
  if Result = nil then
    Result := DoGetPopupClass.Create(Self);
  FPopupStack.Push(Result);
end;

procedure TCustomActionMenuBar.ProcessMouseMsg(var Msg: TMsg);
var
  Item: TCustomActionControl;
  Control: TControl;
  Form: TCustomForm;
begin
  Item := GetMouseHoverItem(Msg);
  if not Assigned(Item) then
    case Msg.message of
      WM_MOUSEMOVE:
        if Mouse.IsDragging and
           (WindowFromPoint(Msg.pt) <> RootMenu.PopupStack.Peek.Handle) then
        begin
          Form := GetParentForm(Self);
          if Assigned(Form) then
          begin
            Control := Form.ControlAtPos(ScreenToClient(Msg.pt), False, True);
            if Assigned(Control) and ((Control is TCustomActionBar) or
               (Control is TCustomActionControl)) then
              RootMenu.CloseMenu;
          end;
        end;
      WM_MBUTTONDOWN,
      WM_RBUTTONDOWN,
      WM_RBUTTONDBLCLK,
      WM_LBUTTONDOWN,
      WM_LBUTTONDBLCLK:
        if (csDesigning in ComponentState) or (RootMenu is TCustomActionPopupMenu) then
          RootMenu.CloseMenu;
    end;
  DispatchMessage(Msg);
end;

// If the ActionBar is in a menu loop, it can become freed by messages
// dispached to other controls.  TActionMneuFreeNotify allows the ActionBar
// to terminate the ProcessMenu loop early, preventing it from accessing
// freed member variables.
type
  TActionMenuFreeNotify = class(TComponent)
    private
      FFreed: Boolean;
      FActionBar: TComponent;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;

    property Freed: Boolean read FFreed;
  end;

  { TActionMenuFreeNotify }

constructor TActionMenuFreeNotify.Create(AOwner: TComponent);
begin
  inherited Create(nil);
  FFreed := False;
  FActionBar := AOwner;
  FActionBar.FreeNotification(Self);
end;

destructor TActionMenuFreeNotify.Destroy;
begin
  if Assigned(FActionBar) then
    FActionBar.RemoveFreeNotification(Self);
  inherited;
end;

procedure TActionMenuFreeNotify.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (FActionBar = AComponent) then
  begin
    FFreed := True;
    FActionBar.RemoveFreeNotification(Self);
    FActionBar := nil;
  end;
end;


function TCustomActionMenuBar.ProcessMenuLoop: TActionClientItem;
var
  Msg: TMsg;
  ContextID: Integer;
{$IF DEFINED(CLR)}
  Temp: TMessage;
  ObjHandle: GCHandle;
{$ELSE}
  Temp: PMessage;
{$ENDIF}
  LCtrl: TWinControl;
  LPt: TPoint;
  LPos: TPoint;
  LIsResizeControl: Boolean; // The control at the current mouse position is a resize indicator
  LGripper: TControl;
  LMenuFreeNotify: TActionMenuFreeNotify;
begin
  Result := nil;
  if FInMenuLoop then exit;
  InitMenuLoop;
  LMenuFreeNotify := TActionMenuFreeNotify.Create(Self);
  try
    try
      repeat
        if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
        begin
          FResizing := False;
          // Prevent multiple right click menus from appearing in form designer
          if (Msg.message = WM_CONTEXTMENU) and (RootMenu is TCustomActionPopupMenu) then
            Continue;
          // Allow keystroke messages to be propagated to the IDE at designtime
          if (csDesigning in ComponentState) then
          begin
  {$IF DEFINED(CLR)}
            if Application.IsKeyMsg(Msg) then
  {$ELSE}
            if TApplicationClass(Application).IsKeyMsg(Msg) then
  {$ENDIF}
              Continue;
          end;
          if IsDesignMsg(Msg) then
          begin
            TranslateMessage(Msg);
            DispatchMessage(Msg);
            Continue;
          end;
          case Msg.message of
            // This undocumented message is a precursor to WM_HELP and catching
            // it here prevents WM_HELP from being sent to the active window and
            // thus having the wrong help appear.
            $4D: if (KeyboardStateToShiftState = []) and
                    (FPopupStack.Peek.Selected <> nil) then
                 begin
                   ContextID := FPopupStack.Peek.Selected.HelpContext;
                   if (ContextID = 0) then
                     ContextID := Screen.ActiveForm.HelpContext;
                   CloseMenu;
                   if (biHelp in Screen.ActiveForm.BorderIcons) then
                     Application.HelpCommand(HELP_CONTEXTPOPUP, ContextID)
                   else
                     Application.HelpContext(ContextID);
                 end;
            WM_NCLBUTTONDOWN:
              begin
                LPt := Mouse.CursorPos;
                LCtrl := FindControl(WindowFromPoint(LPt));
                if LCtrl <> nil then
                begin
                  LPos := LCtrl.ScreenToClient(LPt);
                  LGripper := LCtrl.ControlAtPos(LPos, False);
                  LIsResizeControl := (LGripper is TMenuResizeActionControl);
                end
                else
                  LIsResizeControl := False;
                if not LIsResizeControl then
                  CloseMenu;
                FResizing := LIsResizeControl;
                RootMenu.ProcessMessages;
                DispatchMessage(Msg);
              end;
            WM_NCMBUTTONDOWN,
            WM_NCRBUTTONDOWN,
            CM_RELEASE,
            WM_CLOSE:
              begin
                CloseMenu;
                RootMenu.ProcessMessages;
                DispatchMessage(Msg);
              end;
            WM_KEYFIRST..WM_KEYLAST:
              begin
                if not PersistentHotKeys then
                  PersistentHotkeys := True;
                if (Msg.message = WM_SYSKEYDOWN) and (Msg.wParam = VK_MENU) then
                begin
                  CloseMenu;
                  FCancelMenu := True;
                  TranslateMessage(Msg);
                  DispatchMessage(Msg);
                end
                else
                  if (Msg.wParam <> VK_F1) or ((KeyboardStateToShiftState = [ssCtrl]) and
                     not DesignMode) then
                  begin
  {$IF DEFINED(CLR)}
                    Temp := TMessage.Create(Msg.message, Msg.wParam, Msg.lParam);
  {$ELSE}
                    Temp := PMessage(@Msg.message);
  {$ENDIF}
                    FPopupStack.Peek.Dispatch(Temp{$IFNDEF CLR}^{$ENDIF});
                  end;
              end;
            WM_MOUSEFIRST..WM_MOUSELAST:
              begin
                if Msg.Message = WM_MOUSEWHEEL then continue;
                if Msg.Message = WM_MOUSEMOVE then
                  if PointsEqual(FMousePos, Mouse.CursorPos) then
                    Continue;
                ProcessMouseMsg(Msg);
              end;
            CM_ITEMSELECTED:
  {$IF NOT DEFINED(CLR)}
              DoItemSelected(TCustomActionControl(Msg.lParam));
  {$ELSE}
              begin
                ObjHandle := GCHandle(IntPtr(Msg.lParam));
                DoItemSelected(TCustomActionControl(ObjHandle.Target));
                if (Msg.wParam <> 0) and ObjHandle.IsAllocated then
                  ObjHandle.Free;
              end;
  {$ENDIF}
            CM_ITEMKEYED:
  {$IF NOT DEFINED(CLR)}
              FSelectedItem := DoItemKeyed(TCustomActionControl(Msg.lParam));
  {$ELSE}
              begin
                ObjHandle := GCHandle(IntPtr(Msg.lParam));
                FSelectedItem := DoItemKeyed(TCustomActionControl(ObjHandle.Target));
                if (Msg.wParam <> 0) and ObjHandle.IsAllocated then
                  ObjHandle.Free;
              end;
  {$ENDIF}
            CM_ITEMCLICKED:
  {$IF NOT DEFINED(CLR)}
              FSelectedItem := DoItemClicked(TCustomActionControl(Msg.lParam));
  {$ELSE}
              begin
                ObjHandle := GCHandle(IntPtr(Msg.lParam));
                FSelectedItem := DoItemClicked(TCustomActionControl(ObjHandle.Target));
                if (Msg.wParam <> 0) and ObjHandle.IsAllocated then
                  ObjHandle.Free;
              end;
  {$ENDIF}
  {$IF NOT DEFINED(CLR)}
            CM_SPLITITEMCLICKED:
              FSelectedItem := DoSplitItemClicked(TCustomActionControl(Msg.lParam));
                         
  {$ENDIF}
            WM_QUIT:
              begin
                FInMenuLoop := False;
                PostQuitMessage(Msg.wParam);
              end;
          else
            TranslateMessage(Msg);
            DispatchMessage(Msg);
          end;
          if not LMenuFreeNotify.Freed then
            CleanupStack;
        end
        else
          Idle(Msg);
      until LMenuFreeNotify.FFreed or (not FInMenuLoop);
    finally
      if not LMenuFreeNotify.FFreed then
        DoneMenuLoop;
    end;
  finally
    LMenuFreeNotify.Free;
  end;
end;

procedure TCustomActionMenuBar.Select(const Forward: Boolean);

  function SkipItems(const Forward: Boolean;
    var NextItem: TActionClientItem): Boolean;
  var
    Loop: Boolean;
  begin
    Loop := True;
    NextItem := Selected;
    while Loop do
    begin
      if Forward then
        NextItem := FindNext(NextItem)
      else
        NextItem := FindPrevious(NextItem);
      if Assigned(NextItem) and Assigned(NextItem.Control) then
      begin
        if csDesigning in ComponentState then
          Break
        else
        begin
          if DesignMode then
          begin
            if NextItem.Control.Enabled then
              Break;
          end
          else
          begin
            // Make sure the next item to be selected is visible and
            // isn't a separator
            if not NextItem.Separator and NextItem.Control.Visible and
              (NextItem.CommandStyle <> csSeparator) then
              Break;
          end;
        end;
      end;
      Loop :=  Assigned(NextItem);
    end;
    Result := Assigned(NextItem);
  end;

  procedure CheckChangesAllowed(AnItem: TActionClientItem);
  begin
    if not (caMove in AnItem.ChangesAllowed) then
      raise Exception.CreateFmt(SMoveNotAllowed, [AnItem.Caption]);
  end;

  procedure EnsureNextItemVisible(var AnItem: TActionClientItem);
  var
    LBtn: TCustomToolScrollBtn;
  begin
    if AllowScrolling and (AnItem.Control.Top = cAlignOffScreen) then
    begin
      if Forward then
      begin
        LBtn := FScrollDown;
        if not LBtn.Visible then
          VisibleIndex := 0;
      end
      else
      begin
        LBtn := FScrollUp;
        if not LBtn.Visible then
          MakeLastItemVisible;
      end;
      // Test for the controls top being invalid
      while (AnItem.Control.Top = cAlignOffScreen) do
      begin
        LBtn.Click;
        if not LBtn.Visible then
          Break;
      end;
    end;
  end;

var
  NextItem: TActionClientItem;
begin
  if not SkipItems(Forward, NextItem) then exit;
  if (RootMenu.PopupStack.Peek = Self) then
  begin
    if DesignMode and (KeyboardStateToShiftState = [ssCtrl]) then
    begin
      if Assigned(NextItem) and Assigned(Selected) then
      begin
        CheckChangesAllowed(Selected);
        CheckChangesAllowed(NextItem);
        Selected.Index := NextItem.Index
      end
    end
    else
    begin
      EnsureNextItemVisible(NextItem);
      SelectItem(NextItem.Control);
    end;
  end
  else
  begin
    if (NextItem.Control.Parent = Self) and Assigned(NextItem.Action) then
    begin
      RootMenu.PopupStack.Peek.FInMenuLoop := False;
      RootMenu.FDelayItem := nil;
      EnsureNextItemVisible(NextItem);
      NextItem.Control.Selected := True;
    end
    else
      NextItem.Control.Keyed;
  end;
end;

procedure TCustomActionMenuBar.SelectItem(AnItem: TCustomActionControl);
begin
  if (AnItem = nil) then
    Exit;
  AnItem.Selected := True;
end;

procedure TCustomActionMenuBar.SetDesignMode(const Value: Boolean);
begin
  if DesignMode <> Value then
    CloseMenu;
  inherited SetDesignMode(Value);
end;

procedure TCustomActionMenuBar.SetParentMenu(
  const Value: TCustomActionMenuBar);
begin
  if FParentMenu <> Value then
  begin
    FParentMenu := Value;
    if Assigned(FParentMenu) then
    begin
      FParentMenu.FChildMenu := Self;
      PersistentHotkeys := FParentMenu.PersistentHotkeys;
      if Assigned(FParentMenu.OnGetControlClass) then
        OnGetControlClass := FParentMenu.OnGetControlClass;
      FAnimationStyle := FParentMenu.AnimationStyle;
    end;
  end;
end;

procedure TCustomActionMenuBar.SetPersistentHotKeys(const Value: Boolean);
var
  I: Integer;
  UpdatePopups: Boolean;
begin
  UpdatePopups := (Value <> PersistentHotkeys) and Value;
  inherited SetPersistentHotkeys(Value);
  if UpdatePopups and Assigned(FPopupStack) then
    for I := 0 to FPopupStack.Count - 1 do
      TCustomActionMenuBar(FPopupStack.List[I]).PersistentHotkeys := True;
end;

procedure TCustomActionMenuBar.SetParent(AParent: TWinControl);
begin
  inherited;
  FParentForm := GetParentForm(Self);
end;

procedure TCustomActionMenuBar.TrackMenu;
var
  Cancelled: Boolean;
  LMenuFreeNotify: TActionMenuFreeNotify;
begin
  if InMenuLoop then Exit;
  FRootMenu := Self;
  Cancelled := True;
  if Assigned(FOnEnterMenuLoop) then
    FOnEnterMenuLoop(Self);
  LMenuFreeNotify := TActionMenuFreeNotify.Create(Self);
  try
    try
      ProcessMenuLoop;  // Sets FSelectedItem
      if not LMenuFreeNotify.Freed then
      begin
        Cancelled := (FSelectedItem = nil) or
          (Assigned(FSelectedItem) and (FSelectedItem.Action is TCustomAction) and
           not TCustomAction(FSelectedItem.Action).Enabled);
        if not DesignMode and Assigned(FSelectedItem) then
        begin
          TActionClientItem(FSelectedItem).ResetUsageData;
          Update;
          ExecAction(FSelectedItem.Action);
        end;
      end;
    finally
      // Selecting a disabled item is equalivalent to cancelling the menu
      if (not LMenuFreeNotify.Freed) and  Assigned(FOnExitMenuLoop) then
        FOnExitMenuLoop(Self, Cancelled);
    end;
  finally
    LMenuFreeNotify.Free;
  end;
end;

procedure TCustomActionMenuBar.WndProc(var Message: TMessage);
begin
  case Message.Msg of
{$IF NOT DEFINED(CLR)}
    WM_GETOBJECT:
      if (Message.LParam = Winapi.Windows.LPARAM(OBJID_CLIENT)) and (ActionClient <> nil) then
      begin
        if (ActionClient.Accessible <> nil) then
          Message.Result := LresultFromObject(IID_IAccessible, Message.WParam,
            ActionClient.Accessible)
        else
          Message.Result := LresultFromObject(IID_IAccessible, Message.WParam,
            TActionMenuBarAccessibility.Create(nil, ActionClient));
        exit;
      end;
{$ENDIF}
    WM_ERASEBKGND:
    begin
      if FDoubleBuffered and (LPARAM(TMessage(Message).wParam) <> TMessage(Message).lParam) then
      begin
        Message.Result := 1;
        exit;
      end;
    end;
    WM_NCHITTEST: Message.Result := HTCLIENT;
  end;
  inherited WndProc(Message);
end;

procedure TCustomActionMenuBar.WMKeyDown(var Message: TWMKeyDown);
var
  Item: TActionClientItem;
  SelIndex: Integer;
  CharCode: Integer;
{$IF DEFINED(CLR)}
  ObjHandle: GCHandle;
{$ENDIF}
begin
  inherited;
  if not FInMenuLoop then exit;
  if (RootMenu <> nil) and
    (Message.CharCode in [Ord('0')..Ord('9'), Ord('A')..Ord('Z'), VK_NUMPAD0..VK_NUMPAD9]) then
  begin
    if not (ssCtrl in KeyboardStateToShiftState) then
    begin
      CharCode := Message.CharCode;
      if Message.CharCode in [VK_NUMPAD0..VK_NUMPAD9] then
        CharCode := Ord('0') + Message.CharCode - VK_NUMPAD0;
      Item := RootMenu.PopupStack.Peek.FindAccelItem(CharCode);
      if Assigned(Item) then
        Item.Control.Keyed;
    end;
  end;
  case Message.CharCode of
    VK_UP  : Select(False);
    VK_DOWN: Select(True);
    VK_HOME: SelectItem(FindFirstVisibleItem.Control);
    VK_END : SelectItem(FindLastVisibleItem.Control);
    VK_RETURN:
      if Assigned(Selected) then
        Selected.Control.Keyed;
    VK_ESCAPE:
      if DesignMode and Assigned(FDragItem) then
        DragDone(False)
      else
        if Mouse.IsDragging then
          CancelDrag
        else
          CloseMenu;
    VK_DELETE:
      begin
        if not DesignMode or (Selected = nil) then exit;
        Item := Selected;
        if not (caDelete in Item.ChangesAllowed) then
          raise Exception.Create(SDeleteNotAllowed);
        if Item.HasItems and
           (MessageDlg(Format(SDeleteItemWithSubItems,
            [Item.Caption]), mtConfirmation, mbOKCancel, 0) <> mrOk) then
          exit;
        SelIndex := Item.Index;
        if SelIndex = ItemCount - 1 then
          Item := FindPrevious(Item, False)
        else
          Item := FindNext(Item, False);
        ActionClient.Items.Delete(SelIndex);
        if Assigned(Item) then
          Item.Control.Selected := True
        else
        begin
{$IF DEFINED(CLR)}
          ObjHandle := GCHandle.Alloc(ParentControl, GCHandleType.Weak);
          PostMessage(RootMenu.Handle, CM_ITEMSELECTED, 1, LPARAM(IntPtr(ObjHandle)));
{$ELSE}
          PostMessage(RootMenu.Handle, CM_ITEMSELECTED, 0, Winapi.Windows.LPARAM(ParentControl));
{$ENDIF}
        end;
        NotifyDesigner(Self);
      end;
  end;
end;

procedure TCustomActionMenuBar.WMMouseActivate(var Message: TWMMouseActivate);
begin
  inherited;
  if FInMenuLoop then
    Message.Result := MA_NOACTIVATE;
end;

procedure TCustomActionMenuBar.WMSysKeyDown(var Message: TWMSysKeyDown);
var
  NextItem: TActionClientItem;
{$IF DEFINED(CLR)}
  KeyDownMsg: TWMKeyDown;
{$ENDIF}
begin
  inherited;
  if not FInMenuLoop then exit;
{$IF DEFINED(CLR)}
  KeyDownMsg := TWMKeyDown.Create(Message.OriginalMessage);
  WMKeyDown(KeyDownMsg);
{$ELSE}
  WMKeyDown(Message);
{$ENDIF}
  case Message.CharCode of
    VK_RIGHT:
        if Assigned(Selected) then
          if Selected.HasItems and not Assigned(Selected.ChildActionBar) and
             (Selected.Control.Enabled or DesignMode) then
            Selected.Control.Keyed
          else
          begin
            NextItem := RootMenu.FindNextVisibleItem(RootMenu.Selected);
            if (NextItem = nil) then
              NextItem := RootMenu.FindFirstVisibleItem;
            if (NextItem <> nil) and (NextItem.Control <> nil) then
              NextItem.Control.Keyed;
          end;
    VK_LEFT:
      begin
        NextItem := RootMenu.FindPreviousVisibleItem(RootMenu.Selected);
        if (NextItem = nil) then
          NextItem := RootMenu.FindLastVisibleItem;
        if (NextItem <> nil) and (NextItem.Control <> nil) then
          NextItem.Control.Keyed;
      end;
    VK_MENU: RootMenu.CloseMenu;
  end;
end;

procedure TCustomActionMenuBar.SetAnimateDuration(const Value: Integer);
begin
  if Value <= 0 then
    FAnimateDuration := 1
  else
    FAnimateDuration := Value;
end;

procedure TCustomActionMenuBar.CMFontchanged(var Message: TMessage);

  function IsScreenFont: Boolean;
  begin
    Result := (Font.Name = Screen.MenuFont.Name) and
              (Font.Style = Screen.MenuFont.Style) and
              (Font.Color = Screen.MenuFont.Color) and
              (Font.Pitch = Screen.MenuFont.Pitch) and
              (Font.PixelsPerInch = Screen.MenuFont.PixelsPerInch) and
              (Font.Height = Screen.MenuFont.Height) and
              (Font.Size = Screen.MenuFont.Size);
  end;

begin
  inherited;
  FUseSystemFont := IsScreenFont;
  AdjustSize;
end;

procedure TCustomActionMenuBar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) then
    if (AComponent is TCustomActionControl) then
      if TCustomActionControl(AComponent).ActionClient = FSelectedItem then
        FSelectedItem := nil
      else if AComponent = FMouseControl then
        FMouseControl := nil;
end;

function TCustomActionMenuBar.DoMouseIdle: TControl;
var
  P: TPoint;
begin
  GetCursorPos(P);
  Result := FindDragTarget(P, True);
  // Mouse enter/leave logic is now handled in TWinControl
end;

procedure TCustomActionMenuBar.DoActionIdle;
var
  I: Integer;
begin
  for I := 0 to Screen.CustomFormCount - 1 do
    with Screen.CustomForms[I] do
      if HandleAllocated and IsWindowVisible(Handle) and
        IsWindowEnabled(Handle) then
        Perform(CM_UPDATEACTIONS, 0, 0);
end;

procedure TCustomActionMenuBar.ActionIdleTimerProc(Sender: TObject);
begin
  try
    FActionIdleTimer.Enabled := False;
    DoActionIdle;
  except
    Application.HandleException(Application);
  end;
end;

procedure TCustomActionMenuBar.Idle(const Msg: TMsg);
var
  Done: Boolean;
begin
  if Application.ShowHint and (MouseControl = nil) then
    Application.CancelHint;
  if (Selected <> nil) and Assigned(Selected.Action) then
    Application.Hint := GetLongHint(TCustomAction(Selected.Action).Hint)
  else
    Application.CancelHint;
  Done := True;
  try
    if Assigned(Application.OnIdle) then Application.OnIdle(Self, Done);
    if Done then
      if Application.ActionUpdateDelay <= 0 then
        DoActionIdle
      else
        if not FActionIdleTimer.Enabled then
        begin
          FActionIdleTimer.Interval := Application.ActionUpdateDelay;
          FActionIdleTimer.Enabled := True;
        end;
  except
    Application.HandleException(Self);
  end;
{$IF DEFINED(CLR)}
  if (System.Threading.Thread.CurrentThread = MainThread) and CheckSynchronize then
{$ELSE}
  if (GetCurrentThreadID = MainThreadID) and CheckSynchronize then
{$ENDIF}
    Done := False;
  if Done then WaitMessage;
end;

function TCustomActionMenuBar.ProcessMessage(var Msg: TMsg): Boolean;
{$IF NOT DEFINED(CLR)}
var
  App: TApplicationClass;
{$ENDIF}
begin
{$IF NOT DEFINED(CLR)}
  App := TApplicationClass(Application);
{$ENDIF}
  Result := False;
  if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
  begin
    Result := True;
    if Msg.Message <> WM_QUIT then
{$IF DEFINED(CLR)}
      if not Application.IsHintMsg(Msg) and not Application.IsMDIMsg(Msg) then
{$ELSE}
      if not App.IsHintMsg(Msg) and not App.IsMDIMsg(Msg) then
{$ENDIF}
      begin
        // Do not process keyboard messages
        if (Msg.message >= WM_KEYFIRST) and (Msg.message <= WM_KEYLAST) then
        begin
          Result := False;
          exit;
        end;
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
  end;
end;

procedure TCustomActionMenuBar.ProcessMessages;
var
  Msg: TMsg;
begin
  while ProcessMessage(Msg) do;
end;

function TCustomActionMenuBar.Style: TActionBarStyle;
begin
  if Assigned(RootMenu) and (Self <> RootMenu) then
    Result := RootMenu.Style
  else
    Result := inherited Style;
end;

procedure TCustomActionMenuBar.SetUseSystemFont(const Value: Boolean);
begin
  if FUseSystemFont <> Value then
  begin
    FUseSystemFont := Value;
    if Value then
      Font.Assign(Screen.MenuFont);
  end;
end;

procedure TCustomActionMenuBar.Loaded;
begin
  inherited;
  if FUseSystemFont then
    Font.Assign(Screen.MenuFont);
end;

procedure TCustomActionMenuBar.RecreateControls;
begin
  FreeAndNil(FCachedMenu);
  inherited;
end;

procedure TCustomActionMenuBar.SetMouseControl(const Value: TControl);
begin
  if Value <> MouseControl then
  begin
    if Assigned(FMouseControl) then
      FMouseControl.RemoveFreeNotification(Self);
    FMouseControl := Value;
    if Assigned(FMouseControl) then
      FMouseControl.FreeNotification(Self);
  end;
end;

{ TCustomMenuExpandBtn }

constructor TCustomMenuExpandBtn.Create(AOwner: TComponent);
begin
  inherited;
  Align := alCustom;
  AutoScroll := True;
  ArrowSize := 2;
  Hint := SExpand;
  ArrowType := atArrows;
  Direction := sdDown;
  ControlStyle := ControlStyle + [csNoDesignVisible];
end;

procedure TCustomMenuExpandBtn.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  // This control should not participate in drag/drop at all
  Accept := False;
end;

procedure TCustomMenuExpandBtn.DrawBackground(var PaintRect: TRect);
begin
  OffsetRect(PaintRect, 0, 1);
  InflateRect(PaintRect, -2, -4);
  if MouseInControl then
    Canvas.Brush.Color := Menu.ColorMap.UnusedColor
  else
    Canvas.Brush.Color := Menu.ColorMap.Color;
  inherited DrawBackGround(PaintRect);
end;

procedure TCustomMenuExpandBtn.DrawFrame(ARect: TRect; Down: Boolean);
begin
  OffsetRect(ARect, 0, 1);
  InflateRect(ARect, -2, -4);
  inherited DrawFrame(ARect, Down);
end;

function TCustomMenuExpandBtn.GetMenu: TCustomActionMenuBar;
begin
  Result := ActionBar as TCustomActionMenuBar;
end;

{ TCustomActionPopupMenu }

constructor TCustomActionPopupMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible];
  Visible := False;
  Align := alNone;
  Orientation := boTopToBottom;
  BorderWidth := 0;
  EdgeBorders := [ebLeft, ebTop, ebRight, ebBottom];
  EdgeInner := esRaised;
  EdgeOuter := esRaised;
  VertMargin := 0;
  HorzMargin := 0;
  AutoSize := True;
  if AOwner is TCustomActionBar then
    ActionManager := TCustomActionBar(AOwner).ActionManager;
  Shadow := True;
end;

destructor TCustomActionPopupMenu.Destroy;
begin
  if Assigned(ActionClient) then
    ActionClient.ChildActionBar := nil;
  Visible := False;
  FreeAndNil(FExpandBtn);
  inherited Destroy;
end;

procedure TCustomActionPopupMenu.AddEdges(AnItem: TCustomMenuItem);
var
  PrevItem: TActionClientItem;
  NextItem: TActionClientItem;
  Edges: TMenuEdges;
begin
  if (AnItem = nil) or (AnItem.ActionClient = nil) then exit;
  PrevItem := FindPreviousVisibleItem(AnItem.ActionClient);
  NextItem := FindNextVisibleItem(AnItem.ActionClient);
  if AnItem.ActionClient.Unused then
  begin
    Edges := [];
    if FExpanded and ((PrevItem = nil) or not PrevItem.Unused) then
      if AnItem.ActionClient <> FindFirst then
        Edges := Edges + [ebTop];
    if FExpanded and ((NextItem = nil) or not NextItem.Unused) then
      if AnItem.ActionClient <> FindLast then
        Edges := Edges + [ebBottom];
    AnItem.Edges := Edges;
  end
  else
  begin
    if Assigned(PrevItem) and PrevItem.Unused then
      if PrevItem.Control is TCustomMenuItem then
        with TCustomMenuItem(PrevItem.Control) do
          Edges := Edges + [ebBottom];
    if Assigned(NextItem) and NextItem.Unused then
      if NextItem.Control is TCustomMenuItem then
        with TCustomMenuItem(NextItem.Control) do
          Edges := Edges + [ebTop];
  end;
end;

procedure TCustomActionPopupMenu.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if not DesignMode and Assigned(Selected) and not Assigned(Selected.ChildActionBar) then
    Selected.Control.Selected := False;
end;

procedure TCustomActionPopupMenu.CMVisibleChanged(var Message: TMessage);
begin
  if Visible then
    DisplayShadow
  else
    HideShadow;

  if (Win32MajorVersion >=5) and
     (GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0) and
     StyleServices.Enabled and not StyleServices.IsSystemStyle then
  begin
    SetWindowLong(Handle, GWL_EXSTYLE,
      GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
    SetLayeredWindowAttributes(Handle, 0, 0, LWA_ALPHA);
    inherited;
    SetLayeredWindowAttributes(Handle, 0, 255, LWA_ALPHA);
  end
  else
    inherited;
end;

function TCustomActionPopupMenu.CreateControl(
  AnItem: TActionClientItem): TCustomActionControl;
begin
  Result := inherited CreateControl(AnItem);
  if (Result is TCustomMenuItem) then
    AddEdges(TCustomMenuItem(Result));
  if not Expanded and Result.ActionClient.Unused then
  begin
    FExpandable := True;
    Result.Visible := False;
  end;
end;

procedure TCustomActionPopupMenu.CreateControls;
begin
  inherited CreateControls;
  if not Expanded and FExpandable and (FindFirstVisibleItem <> nil) then
    SetupExpandBtn;
end;

procedure TCustomActionPopupMenu.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if not (Parent is TCustomForm) then
      Style := Style and not WS_CHILD or WS_POPUP or WS_CLIPSIBLINGS or
        WS_CLIPCHILDREN or WS_OVERLAPPED;
    WindowClass.Style := CS_SAVEBITS or CS_DBLCLKS or not (CS_HREDRAW or not CS_VREDRAW);
    // CS_DROPSHADOW requires Windows XP or above
    if CheckWin32Version(5, 1) and GetShadow(Self) then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW;
    if not DesignMode then
      ExStyle := ExStyle or WS_EX_TOPMOST;
  end;
end;

function TCustomActionPopupMenu.DesignWndProc(var Message: TMessage): Boolean;
begin
  Result := True;
end;

procedure TCustomActionPopupMenu.ExecAction(Action: TContainedAction);
begin
  Hide;
  inherited ExecAction(Action);
end;

procedure TCustomActionPopupMenu.Expand(Full: Boolean);
var
  I: Integer;
begin
  FExpanded := True;
  DisableAlign;
  try
    if Assigned(FExpandBtn) then
      FExpandBtn.Visible := False;
    HideShadow;
    inherited Expand(Full);
    for I := 0 to Items.Count - 1 do
      if Items[I].Visible then
        if (Items[I].Control is TCustomMenuItem) then
        begin
          AddEdges(TCustomMenuItem(Items[I].Control));
          Items[I].Control.CalcBounds;
        end;
  finally
    EnableAlign;
    if Assigned(FParentControl) then
      PositionPopup(TCustomActionBar(FParentControl.Owner), FParentControl);
    SendMessage(Handle, WM_NCPAINT, 1, 0);
    DisplayShadow;
  end;
end;

procedure TCustomActionPopupMenu.ExpandClick(Sender: TObject);
begin
  while RootMenu.PopupStack.Peek <> Self do
    RootMenu.PopupStack.Pop;
  Expand(True);
end;

procedure TCustomActionPopupMenu.Popup(X, Y: Integer);
begin
  if ItemCount = 0 then exit;
  ParentWindow := Application.Handle;
  FRootMenu := Self;
  if FindFirstVisibleItem = nil then
    Expand(False);
  SetBounds(X, Y, Width, Height);
  PersistentHotKeys := True;
  ColorMap := Self.ColorMap;
  Visible := True;
  TrackMenu;
end;

procedure TCustomActionPopupMenu.PositionPopup(AnOwner: TCustomActionBar;
  ParentItem: TCustomActionControl);

  function MonitorSize(A, B: Integer): Integer;
  begin
    Result := B;
    if A > 0 then
      Inc(Result, A);
  end;

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
        boLeftToRight: P := AnOwner.ClientToScreen(Point(Left + 1, Top + Height));
        boRightToLeft: P := AnOwner.ClientToScreen(Point(Left - Self.Width +
          Width, Top + Height));
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
    if P.X + Width > MonitorSize(LMonitorLeft, Monitor.Width) then
    begin
      P.X := MonitorSize(LMonitorLeft, Monitor.Width) - Width;
      if (ParentItem is TCustomMenuItem) and
         (P.X + Width > LMonitorLeft + Monitor.Width - AnOwner.Left + AnOwner.Width) then
        P.X := AnOwner.Left - Width + 2;
    end;
    if (Height > Monitor.Height) then
      P.Y := Monitor.Top
    else if (P.Y + Height > MonitorSize(Monitor.Top, Monitor.Height)) then
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

procedure TCustomActionPopupMenu.SetupExpandBtn;
begin
  if FExpandBtn = nil then
  begin
    FExpandBtn := GetExpandBtnClass.Create(Self);
    with FExpandBtn do
    begin
      Align := alCustom;
      AutoScroll := True;
      Parent := Self;
      ArrowSize := 2;
      Hint := SExpand;
      ArrowType := atArrows;
      Direction := sdDown;
      Transparent := Self.ActionClient.HasBackground and
        not (Self.ActionClient.BackgroundLayout in [blLeftBanner, blRightBanner]);
      OnClick := ExpandClick;
    end;
  end;
end;

procedure TCustomActionPopupMenu.SetOrientation(const Value: TBarOrientation);
begin
  if Value in ValidOrientations then
    inherited SetOrientation(Value);
end;

procedure TCustomActionPopupMenu.WMKeyDown(var Message: TWMKeyDown);
var
  Item: TActionClientItem;
  SelIndex: Integer;
{$IF DEFINED(CLR)}
  LMessage: TMessage;
{$ENDIF}
begin
  case Message.CharCode of
    VK_SUBTRACT:
      if DesignMode and (Selected <> nil) then
      begin
        Item := TActionClientItem(Items.Insert(Selected.Index));
        Item.Caption := '-';
        Item.Control.Visible := True;
        Item.Control.Selected := True;
        NotifyDesigner(Self);
      end;
    VK_LEFT:
      if Assigned(FChildMenu) then
      begin
        FChildMenu.FInMenuLoop := False;
        FChildMenu := nil;
        Message.Result := 0;
      end
      else
        if Assigned(FParentMenu) then
        begin
{$IF DEFINED(CLR)}
          LMessage := Message.OriginalMessage;
          FParentMenu.Dispatch(LMessage);
          Message := TWMKeyDown.Create(LMessage);
{$ELSE}
          FParentMenu.Dispatch(Message);
{$ENDIF}
        end;
    VK_RIGHT:
      begin
        if Assigned(Selected) then
        begin
          if DesignMode and not Selected.HasItems and
             not Selected.Separator and (Selected.Action = nil) then
            if ssCtrl in KeyboardStateToShiftState then
            begin
              Selected.Items.Add;
              Selected.Control.Invalidate;
            end;
          if Selected.HasItems and not Assigned(Selected.ChildActionBar) and
             (Selected.Control.Enabled or DesignMode) then
            Selected.Control.Keyed
          else
            if FPopupStack = nil then
            begin
{$IF DEFINED(CLR)}
              LMessage := Message.OriginalMessage;
              RootMenu.Dispatch(LMessage);
              Message := TWMKeyDown.Create(LMessage);
{$ELSE}
              RootMenu.Dispatch(Message);
{$ENDIF}
            end;
        end
        else
          if RootMenu <> Self then
          begin
{$IF DEFINED(CLR)}
            LMessage := Message.OriginalMessage;
            RootMenu.Dispatch(LMessage);
            Message := TWMKeyDown.Create(LMessage);
{$ELSE}
            RootMenu.Dispatch(Message);
{$ENDIF}
          end;
      end;
    VK_DOWN:
      if (Message.CharCode = VK_DOWN) and FExpandable and
         ((Selected = FindLastVisibleItem) or
         (ssCtrl in KeyboardStateToShiftState)) then
      begin
        FExpandBtn.Click;
        SelectItem(FindFirstVisibleItem.Control);
        exit;
      end;
    VK_INSERT:
      begin
        if not (csDesigning in ComponentState) then exit;
        if Selected = nil then exit;
        Item := Selected;
        SelIndex := Item.Index;
        if (ssShift in KeyboardStateToShiftState) then
          Inc(SelIndex);
        Item := TActionClientItem(ActionClient.Items.Insert(SelIndex));
        Item.Control.Selected := True;
        NotifyDesigner(Self);
      end;
  end;
  inherited;
end;

procedure TCustomActionPopupMenu.WMPrint(var Message: TMessage);
begin
  inherited;
  NCPaint(HDC(Message.WParam));
end;

procedure TCustomActionPopupMenu.WMPrintClient(var Message: TWMPrintClient);
var
  AHandle: HDC;
begin
  AHandle := Canvas.Handle;
  try
    Canvas.Handle := Message.DC;
    Canvas.Brush.Color := ColorMap.Color;
    Canvas.FillRect(BoundsRect);
    inherited;
    PaintTo(Message.DC, 0, 0);
  finally
    Canvas.Handle := AHandle;
  end;
end;

function TCustomActionPopupMenu.ValidOrientations: TBarOrientations;
begin
  // Popup menus can only have vertical orientation
  Result := [boTopToBottom, boBottomToTop];
end;

procedure TCustomActionPopupMenu.VisibleChanging;
var
  Item: TActionClientItem;
  I: Integer;
begin
  inherited VisibleChanging;
{$IF NOT DEFINED(CLR)}
  if not (csDesigning in ComponentState) then
    if Visible then
    begin
      if HandleAllocated and IsWindowVisible(Handle) and (FRootMenu <> Self) then
        NotifyWinEvent(EVENT_SYSTEM_MENUPOPUPEND, Handle, OBJID_MENU, CHILDID_SELF)
    end
    else
      NotifyWinEvent(EVENT_SYSTEM_MENUPOPUPSTART, Handle, OBJID_MENU, CHILDID_SELF);
{$ENDIF}
  if Visible then exit;
  Item := FindFirstVisibleItem;
  if Assigned(Item) and Item.Separator then
    Item.Control.Visible := False;
  Item := FindLastVisibleItem;
  if Assigned(Item) and Item.Separator then
    Item.Control.Visible := False;
  if not DesignMode then
    for I := 0 to ItemCount - 1 do
      if Assigned(Items[I].ActionLink) then
        Items[I].ActionLink.Update;
  if not Assigned(ActionClient) then exit;
  HandleNeeded;
  AdjustSize;
  PositionPopup(FParentMenu, FParentControl);
  if Assigned(FParentMenu) then
    Animate(True);
  if not (csDesigning in ComponentState) and Assigned(RootMenu) then
  begin
    sndPlaySound(nil, SND_NODEFAULT);
    sndPlaySound('MenuPopup', SND_NOSTOP or SND_ASYNC or SND_NODEFAULT);
  end;
end;

procedure TCustomActionPopupMenu.CloseMenu;
begin
  Visible := False;
  if Assigned(RootMenu) then
    RootMenu.FMousePos := Mouse.CursorPos;
  inherited CloseMenu;
end;

function TCustomActionPopupMenu.GetClientRect: TRect;
begin
  Result := inherited GetClientRect;
  Inc(Result.Left, GetBannerWidth(beLeft));
end;

function TCustomActionPopupMenu.GetExpandBtnClass: TCustomMenuExpandBtnClass;
begin
  Result := TCustomMenuExpandBtn;
end;

function TCustomActionPopupMenu.CanAutoSize(var NewWidth,
  NewHeight: Integer): Boolean;
begin
  Result := inherited CanAutoSize(NewWidth, NewHeight);
  // Only change the width if the banner is on the right otherwise
  // autosize will size the menu accordingly for a left banner since the
  // Items will align themselves accordingly.
  Inc(NewWidth, GetBannerWidth(beRight));
end;

procedure TCustomActionPopupMenu.DisplayShadow;
begin
  if CheckWin32Version(5, 1) then exit;
  if GetShadow(Self) and not DesignMode then
  begin
    if not Assigned(FRShadow) then
    begin
      FRShadow := TShadowWindow.CreateShadow(Self, csRight);
      FBShadow := TShadowWindow.CreateShadow(Self, csBottom);
    end;
    if Assigned(FRShadow) then
    begin
      FRShadow.Control := Self;
      FBShadow.Control := Self;
    end;
  end;
end;

procedure TCustomActionPopupMenu.HideShadow;
begin
  if CheckWin32Version(5, 1) or not Assigned(FRShadow) then exit;
  FRShadow.Hide;
  FBShadow.Hide;
end;

procedure TCustomActionPopupMenu.SetColorMap(
  const Value: TCustomActionBarColorMap);
begin
  inherited;
  if Assigned(ColorMap) then
    Color := ColorMap.MenuColor;
end;

procedure TCustomActionPopupMenu.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if not (csDestroying in ComponentState) and (Operation = opRemove) then
    if AComponent is TControl then
      with TControl(AComponent) do
        Visible := False;
end;

procedure TCustomActionPopupMenu.SetShadow(const Value: Boolean);
begin
  if FShadow <> Value then
  begin
    FShadow := Value;
    RecreateWnd;
  end;
end;

procedure TCustomActionPopupMenu.DrawBackground;
begin
  inherited;
  if StyleServices.Enabled and not StyleServices.IsSystemStyle then
    StyleServices.DrawElement(Canvas.Handle, StyleServices.GetElementDetails(tmPopupBackground),
      Rect(0, 0, Width, Height))
  else
  begin
    Canvas.Brush.Color := ColorMap.MenuColor;
    Canvas.FillRect(ClientRect);
  end;
end;

function TCustomActionPopupMenu.NewPopup: TCustomActionPopupMenu;
begin
  Result := inherited NewPopup;
  Result.Shadow := GetShadow(Self);
end;

procedure  TCustomActionPopupMenu.WMNCPaint(var Message: TWMNCPaint);
var
  OldHandle: HDC;
begin
  if StyleServices.Enabled and not StyleServices.IsSystemStyle then
  begin
    OldHandle := Canvas.Handle;
    Canvas.Handle := GetWindowDC(Handle);
    try
      StyleServices.DrawElement(Canvas.Handle, StyleServices.GetElementDetails(tmPopupBorders),
       Rect(0, 0, Width, Height));
    finally
      ReleaseDC(Handle, Canvas.Handle);
      Canvas.Handle := OldHandle;
    end;
  end
  else
    inherited;
end;

{ TCustomAddRemoveItem }

procedure TCustomAddRemoveItem.CalcBounds;
var
  R: TRect;
begin
  inherited CalcBounds;
  Width := Width + 18;
  GlyphPos := Point(GlyphPos.X + 18, GlyphPos.Y);
  R := TextBounds;
  OffsetRect(R, 18,0);
  TextBounds := R;
end;

function TCustomAddRemoveItem.IsActionVisible: Boolean;
var
  I: Integer;
  OwnerItems: TActionClients;
begin
  Result := False;
  OwnerItems := Menu.RootMenu.ParentControl.ActionBar.ActionClient.Items;
  for I := 0 to OwnerItems.Count - 1 do
    if OwnerItems[I].Action = ActionClient.Action then
    begin
      Result := OwnerItems[I].Visible;
      break;
    end;
end;

procedure TCustomAddRemoveItem.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  Invalidate;
end;

procedure TCustomAddRemoveItem.SetEnabled(Value: Boolean);
begin
  inherited SetEnabled(True);  // Add/remove items are always enabled
end;

{ TCustomizeActionToolBar }

constructor TCustomizeActionToolBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AOwner is TCustomActionToolBar then
    FActionBar := TCustomActionToolBar(AOwner);
end;

destructor TCustomizeActionToolBar.Destroy;
begin
  FResetAction.Free;
  inherited Destroy;
end;

function TCustomizeActionToolBar.CanAutoSize(var NewWidth,
  NewHeight: Integer): Boolean;
begin
  Result := inherited CanAutoSize(NewWidth, NewHeight);
  if Assigned(FPopupStack) and (FPopupStack.Count > 0) then
    Result := False;
end;

procedure TCustomizeActionToolBar.Clear;
begin
end;

procedure TCustomizeActionToolBar.CMItemSelected(var Message: TCMItemMsg);
begin
  CloseMenu;
end;

function TCustomizeActionToolBar.GetActionControl(
  const Index: Integer): TCustomActionControl;
begin
  if (Index >= 0) and (Index < ItemCount) then
    Result := ActionClient.Items[Index].Control
  else
    Result := nil;
end;

function TCustomizeActionToolBar.ItemCount: Integer;
begin
  if Assigned(ActionClient) then
    Result := ActionClient.Items.Count
  else
    Result := 0;
end;

function TCustomizeActionToolBar.DoItemClicked(
  AnItem: TCustomActionControl): TActionClientItem;

  function FindItem(MatchItem: TActionClientItem): TActionClientItem;
  var
    I: Integer;
    OwnerItems: TActionClients;
  begin
    Result := nil;
    OwnerItems := RootMenu.ParentControl.ActionBar.ActionClient.Items;
    for I := 0 to OwnerItems.Count - 1 do
      if OwnerItems[I].Action = MatchItem.Action then
      begin
        Result := OwnerItems[I];
        break;
      end;
  end;

var
  Item: TActionClientItem;
begin
  if not AnItem.Separator and (AnItem is GetAddRemoveItemClass) then
  begin
    Item := FindItem(AnItem.ActionClient);
    if Assigned(Item) then
    begin
      Item.Visible := not Item.Visible;
      if not Item.Visible then
        Item.Control.Visible := False;
    end
    else
    begin
      Item := TActionClientItem(RootMenu.ParentControl.ActionBar.ActionClient.Items.Insert(AnItem.ActionClient.Index));
      Item.Action := AnItem.ActionClient.Action;
    end;
    FActionBar.Realign;
    with FActionBar do
      FActionBar.SetBounds(Left, Top, Width, Height);
    Result := nil;
  end
  else if AnItem.ActionClient = FResetItem then
  begin
    CloseMenu;
    Result := AnItem.ActionClient;
    PostMessage(FActionBar.Handle, CM_RESETBAR, 0, 0);
  end
  else
    Result := inherited DoItemClicked(AnItem);
end;

procedure TCustomizeActionToolBar.GetSubMenuControlClass(
  Sender: TCustomActionBar; AnItem: TActionClient;
  var ControlClass: TCustomActionControlClass);
begin
  if AnItem is TActionClientItem then
    with TActionClientItem(AnItem) do
      if ParentItem = FAddlItem then
        ControlClass := GetAddRemoveItemClass
      else
        ControlClass := GetControlClass(AnItem as TActionClientItem);
end;

function TCustomizeActionToolBar.NewPopup: TCustomActionPopupMenu;
begin
  Result := inherited NewPopup;
  Result.OnGetControlClass := GetSubMenuControlClass;
  Result.Shadow := GetShadow(Self);
end;

procedure TCustomizeActionToolBar.DoAddCustomizeItems(const AnActionClient: TActionClient);

  procedure AddSeparator(ActionClients: TActionClients);
  begin
    with ActionClients.Add do
    begin
      Caption := '-';
      UsageCount := -1;
    end;
  end;

  procedure AddItems(ToItems, FromItems: TActionclients; Count: Integer);
  var
    I, X: Integer;
    Skip: Boolean;
    Item: TActionClientItem;
  begin
    for I := 0 to Count do
    begin
      Skip := False;
      for X := 0 to ToItems.Count - 1 do
        if ToItems[X].Action = FromItems[I].Action then
        begin
          Skip := True;
          break;
        end;
      if Skip then Continue;
      Item := ToItems.Add;
      Item.Assign(FromItems[I]);
      Item.Items := nil;
      Item.UsageCount := -1;
    end;
  end;

var
  ActionBarItem: TActionBarItem;
begin
  if Assigned(AnActionClient) and Assigned(FActionBar) then
  begin
    ActionBarItem := nil;
    if Assigned(FActionBar.ActionManager.DefaultActionBars) then
      with FActionBar do
        ActionBarItem := TActionBarItem(ActionManager.DefaultActionBars.FindItemID(ActionClient.Index));
    if Assigned(ActionBarItem) then
    begin
      if AnActionClient.Items.Count > 0 then
        AddSeparator(AnActionClient.Items);
      FAddlItem := AnActionClient.Items.Add;
      FAddlItem.Caption := SAddRemoveButtons;
      AddItems(FAddlItem.Items, ActionBarItem.Items, ActionBarItem.Items.Count - 1);
      with TActionBarItem(RootMenu.ParentControl.ActionBar.ActionClient) do
        AddItems(FAddlItem.Items, Items, Items.Count - 2);
      if ActionBarItem.Items.Count > 0 then
      begin
        FResetAction := TCustomAction.Create(Self);
        with FResetAction do
          Caption := SResetActionToolbar;
        if FAddlItem.Items.Count > 0 then
          AddSeparator(AnActionClient.Items);
        FResetItem := AnActionClient.Items.Add;
        with FResetItem do
        begin
          Action := FResetAction;
          UsageCount := -1;
        end;
      end;
    end;
  end;
end;

procedure TCustomizeActionToolBar.SetActionClient(const Value: TActionClient);
begin
  DoAddCustomizeItems(Value);
  inherited SetActionClient(Value);
  ActionClient.Items.Customizable := False;
end;

function TCustomizeActionToolBar.GetAddRemoveItemClass: TCustomAddRemoveItemClass;
begin
  if Style <> nil then
    Result := TActionBarStyleEx(Style).GetAddRemoveItemClass(Self)
  else
    Result := TActionBarStyleEx(ActionBarStyles.Style[0]).GetAddRemoveItemClass(Self);
end;

{ TCustomizeActionLink }

procedure TCustomizeActionLink.SetEnabled(Value: Boolean);
begin
  if Assigned(FClient.Control) then
    FClient.Control.Enabled := True;
end;

{ TCustomizeActionClientItem }

function TCustomizeActionClientItem.GetActionLinkClass: TActionClientLinkClass;
begin
  Result := TCustomizeActionLink;
end;

{ TCustomMDIMenuButton }

const
  ButtonStyles: array[TMDIButtonStyle] of word = (DFCS_CAPTIONMIN, DFCS_CAPTIONRESTORE, DFCS_CAPTIONCLOSE);
  MouseStyles: array[Boolean] of word = (0, DFCS_HOT);
  PushStyles: array[Boolean] of word = (0, DFCS_PUSHED);

procedure TCustomMDIMenuButton.Paint;
begin
  DrawFrameControl(Canvas.Handle, ClientRect, DFC_CAPTION,
    MouseStyles[MouseInControl] or ButtonStyles[ButtonStyle] or
    PushStyles[FState = bsDown]);
end;

{ TCustomActionMainMenuBar }

constructor TCustomActionMainMenuBar.Create(AOwner: TComponent);
var
  HotKeys: BOOL;
{$IF NOT DEFINED(CLR)}
  Hook: TWindowHook;
{$ENDIF}
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csMenuEvents];
  EdgeBorders := [];
  EdgeInner := esRaised;
  EdgeOuter := esLowered;
  SystemParametersInfo(SPI_GETMENUUNDERLINES, 0, {$IFNDEF CLR}@{$ENDIF}HotKeys, 0);
  Align := alTop;
  PersistentHotKeys := HotKeys;
  AllowHiding := False;
  HorzMargin := 1;
  Height := 29;
  TabStop := False;
  FShadows := True;
  // Hook TApplication to get notifications of CM_ACTIVATE/DEACTIVATE
{$IF DEFINED(CLR)}
  Application.HookMainWindow(MainWndHook);
{$ELSE}
  Hook := MainWndHook;
  SendMessage(Application.Handle, CM_WINDOWHOOK, 0, Winapi.Windows.LPARAM(@@Hook));
{$ENDIF}
end;

destructor TCustomActionMainMenuBar.Destroy;
{$IF NOT DEFINED(CLR)}
var
  Hook: TWindowHook;
{$ENDIF}
begin
  FreeAndNil(FMDIActions);
  FreeAndNil(FMDISeparator);
{$IF DEFINED(CLR)}
  Application.UnhookMainWindow(MainWndHook);
{$ELSE}
  Hook := MainWndHook;
  SendMessage(Application.Handle, CM_WINDOWHOOK, 1, Winapi.Windows.LPARAM(@@Hook));
{$ENDIF}
  inherited;
end;

procedure TCustomActionMainMenuBar.DrawBackground;
var
  SaveIndex: Integer;
  Details: TThemedElementDetails;
begin
  if StyleServices.Enabled and not StyleServices.IsSystemStyle then
  begin
    SaveIndex := SaveDC(Canvas.Handle);
    try
      Details := StyleServices.GetElementDetails(tmMenuBarBackgroundActive);
      StyleServices.DrawElement(Canvas.Handle, Details,
        Rect(0, 0, Width, Height));
    finally
      RestoreDC(Canvas.Handle, SaveIndex);
    end;
  end
  else
    inherited;
end;

procedure TCustomActionMainMenuBar.Clear;
var
  LWindowMenu: string;
begin
  // Clearing the items will reset the WindowMenu property if the
  // action menu item referenced by FWindowMenu is freed
  LWindowMenu := FWindowMenu;
  inherited;
  FWindowMenu := LWindowMenu;
end;

procedure TCustomActionMainMenuBar.CloseMenu;
begin
  ClearSubMenus;  //! ClearSubMenus recursion for CloseMenu in the CallWnd hook
  inherited CloseMenu;
end;

procedure TCustomActionMainMenuBar.WMKeyDown(var Message: TWMKeyDown);
var
  Popup: TCustomActionBar;
begin
  case Orientation of
    boLeftToRight,
    boRightToLeft:
      case Message.CharCode of
        VK_RIGHT: Select(Orientation = boLeftToRight);
        VK_LEFT : Select(Orientation <> boLeftToRight);
        VK_DOWN,
        VK_UP:
          if Assigned(Selected) then
          begin
            if DesignMode and not Selected.HasItems then
              if ssCtrl in KeyboardStateToShiftState then
              begin
                Selected.Items.Add;
                NotifyDesigner(Self);
              end
              else
                exit;
            if Selected.HasItems then
            begin
              Popup := CreatePopup(Self, Selected.Control);
              Popup.FindFirst.Control.Selected := True;
              Message.CharCode := 0;
              exit;
            end;
          end;
      end;
    boTopToBottom,
    boBottomToTop:
      case Message.CharCode of
        VK_RIGHT:
          if Assigned(Selected) and Selected.HasItems then
            Selected.Control.Keyed;
        VK_LEFT: Select(True);
      end;
  end;
  inherited;
end;

function TCustomActionMainMenuBar.CanFocus: Boolean;
begin
  Result := False;
end;

function TCustomActionMainMenuBar.CreateControl(
  AnItem: TActionClientItem): TCustomActionControl;
begin
  Result := inherited CreateControl(AnItem);
  with Result as GetControlClass(AnItem) do
    Spacing := 2;
end;

function TCustomActionMainMenuBar.DesignWndProc(
  var Message: TMessage): Boolean;
begin
  Result := inherited DesignWndProc(Message);
  if Result then exit;
  if Message.Msg = WM_KEYDOWN then
{$IF DEFINED(CLR)}
    case Message.WParam.ToInt64 of
{$ELSE}
    case Message.WParam of
{$ENDIF}
      VK_RIGHT, VK_LEFT, VK_DOWN, VK_UP, VK_ESCAPE:
        begin
          if (Message.WParam = VK_ESCAPE) and InMenuLoop then
          begin
            CloseMenu;
            if Designable then
              ActionBarDesigner.SetSelection(Self);
          end;
          Result := True
        end;
    end;
end;

procedure TCustomActionMainMenuBar.DoneMenuLoop;
var
  HotKeys: BOOL;
begin
  inherited DoneMenuLoop;
  SystemParametersInfo(SPI_GETMENUUNDERLINES, 0, {$IFNDEF CLR}@{$ENDIF}HotKeys, 0);
  if not HotKeys then
    PersistentHotkeys := False;
end;

{$IF NOT DEFINED(CLR)}
type
  TCustomFormClass = class(TCustomForm);
{$ENDIF}

procedure TCustomActionMainMenuBar.GetActiveMDIChild;
var
  I: Integer;
  FoundMaximized: Boolean;
{$IF DEFINED(CLR)}
  Frm: IMDIForm;
{$ELSE}
  Frm: TCustomFormClass;
{$ENDIF}
begin
  if FMDIActivate then exit;
  if Assigned(FParentForm) then
  begin
    FMDIActivate := True;
    try
{$IF DEFINED(CLR)}
      Frm := FParentForm as IMDIForm;
{$ELSE}
      Frm := TCustomFormClass(FParentForm);
{$ENDIF}
      FoundMaximized := False;
      for I := 0 to Frm.MDIChildCount - 1 do
        if Frm.MDIChildren[I].WindowState = wsMaximized then
        begin
          FoundMaximized := True;
          MDIChildMaximized(Frm.MDIChildren[I]);
          break;
        end;
      if not FoundMaximized then
        MDIChildRestored;
    finally
      FMDIActivate := False;
    end;
  end;
end;

procedure TCustomActionMainMenuBar.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if DesignMode then
    Message.Result := HTCLIENT;
end;

procedure TCustomActionMainMenuBar.ProcessMouseMsg(var Msg: tagMSG);
var
  Item: TCustomActionControl;
begin
  inherited ProcessMouseMsg(Msg);
  case Msg.message of
    WM_LBUTTONDOWN,
    WM_RBUTTONDOWN:
      begin
        Item := GetMouseHoverItem(Msg);
        if Assigned(Item) then
        begin
          if (Item.Owner = Self) and Item.Selected then
            Item.Click;
        end
        else
          if not DesignMode then
            CloseMenu;
      end;
  end;
end;

procedure TCustomActionMainMenuBar.CMWininichange(var Message: TWMWinIniChange);
begin
  inherited;
  RequestAlign;
  Font.Assign(Screen.MenuFont);
end;

procedure TCustomActionMainMenuBar.SetDesignMode(const Value: Boolean);
begin
  if DesignMode <> Value then
    ClearSubMenus;
  inherited SetDesignMode(Value);
end;

procedure TCustomActionMainMenuBar.SetInActive(const Value: Boolean);
begin
  if FInActive <> Value then
  begin
    FInActive := Value;
    Invalidate;
  end;
end;

procedure TCustomActionMainMenuBar.CMEnabledchanged(var Message: TMessage);
begin
  inherited;
  Inactive := not Enabled;
end;

function TCustomActionMainMenuBar.NewPopup: TCustomActionPopupMenu;
begin
  Result := inherited NewPopup;
  Result.Shadow := FShadows;
end;

procedure TCustomActionMainMenuBar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent is TCustomButtonControl) and
     Assigned(TCustomButtonControl(AComponent).ActionClient) and
     (TCustomButtonControl(AComponent).ActionClient.Caption = FWindowMenu) then
  begin
    FWindowMenu := '';
    FWindowMenuItem := nil;
  end;
end;

procedure TCustomActionMainMenuBar.SetupWindowMenu;
var
  Ctrl: TCustomActionControl;
begin
  if Assigned(ActionClient) then
  begin
    Ctrl :=  FindItemCaption(FWindowMenu);
    if Assigned(Ctrl) then
      FWindowMenuItem := Ctrl.ActionClient;
  end;
end;

procedure TCustomActionMainMenuBar.SetWindowMenu(const Value: string);
begin
  if FWindowMenu <> Value then
  begin
    FWindowMenu := Value;
    if not (csLoading in ComponentState) then
      SetupWindowMenu;
  end;
end;

procedure TCustomActionMainMenuBar.RefreshMDIMenu;

  function FindChildAction(AChild: TCustomForm): TInternalMDIAction;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to FMDIActions.ActionCount - 1 do
      if TInternalMDIAction(FMDIActions[I]).Form = AChild then
      begin
        Result := FMDIActions[I] as TInternalMDIAction;
        break;
      end;
  end;

var
  I: Integer;
  Actn: TInternalMDIAction;
{$IF DEFINED(CLR)}
  Form: IMDIForm;
{$ELSE}
  Form: TCustomFormClass;
{$ENDIF}
begin
  if (csDestroying in FParentForm.ComponentState) or
{$IF DEFINED(CLR)}
     ((FParentForm as IMDIForm).GetFormStyle <> fsMDIForm) or DesignMode or
{$ELSE}
     (TCustomFormClass(FParentForm).FormStyle <> fsMDIForm) or DesignMode or
{$ENDIF}
     not Assigned(FWindowMenuItem) then exit;
  GetActiveMDIChild;
  if not Assigned(FMDIActions) then
  begin
    FMDIActions := TActionList.Create(Self);
    FMDISeparator := FWindowMenuItem.Items.Add;
    FMDISeparator.Caption := '-';
  end;
{$IF DEFINED(CLR)}
  Form := FParentForm as IMDIForm;
{$ELSE}
  Form := TCustomFormClass(FParentForm);
{$ENDIF}
  if Form.MDIChildCount = 0 then
    FreeAndNil(FMDISeparator);
  for I := 0 to Form.MDIChildCount - 1 do
  begin
    Actn := FindChildAction(Form.MDIChildren[I]);
    if Assigned(Actn) then
      Actn.Caption := Form.MDIChildren[I].Caption
    else
    begin
      Actn := TInternalMDIAction.Create(FMDIActions);
      Actn.MDIAction := maActivate;
      Actn.ActionList := FMDIActions;
{$IF DEFINED(CLR)}
      Actn.GroupIndex := FParentForm.GetHashCode;
{$ELSE}
                                                
      Actn.GroupIndex := Integer(Form);
{$ENDIF}
      Actn.Form := Form.MDIChildren[I];
      Actn.Caption := Form.MDIChildren[I].Caption;
      Actn.ClientItem := FWindowMenuItem.Items.Add;
      Actn.FMenu := Self;
      Actn.ClientItem.Action := Actn;
      Actn.ClientItem.UsageCount := -1;      
    end;
    if I = 0 then
      Actn.Checked := True;
  end;
end;

procedure TCustomActionMainMenuBar.MDIChildMaximized(ChildForm: TCustomForm);

  function SetupMDIButton(Style: TMDIButtonStyle): TCustomMDIMenuButton;
  begin
    Result := TCustomMDIMenuButton.Create(Self);
    with Result do
    begin
      Visible := False;
      Parent := Self;
      Top := Self.VertMargin + 1;
      Width := GetSystemMetrics(SM_CXMENUSIZE);
      Height := GetSystemMetrics(SM_CYMENUSIZE);
      ButtonStyle := Style;
      Action := TInternalMDIAction.Create(Self);
      case Orientation of
        boLeftToRight:
          begin
            Anchors := [akTop, akRight];
            case ButtonStyle of
              mbMinimize: Left := Self.Width - Width * 3 - VertMargin - 1;
              mbRestore: Left := Self.Width - Width * 2 - VertMargin - 1;
              mbClose: Left := Self.Width - Width - VertMargin - 1;
            end;
          end;
        boRightToLeft:
            case ButtonStyle of
              mbMinimize: Left := Width * 2 + VertMargin + 1;
              mbRestore: Left := Width + VertMargin + 1;
              mbClose: Left := 0 + VertMargin + 1;
            end;
      end;
      with Action as TInternalMDIAction do
        case ButtonStyle of
          mbMinimize: MDIAction := maMinimize;
          mbRestore: MDIAction := maRestore;
          mbClose: MDIAction := maClose;
        end;
    end;
    Visible := True;    
  end;

begin
  if csDestroying in ChildForm.ComponentState then exit;
  if not Assigned(FRestoreBtn) then
  begin
    FMinimizeBtn := SetupMDIButton(mbMinimize);
    FRestoreBtn := SetupMDIButton(mbRestore);
    FCloseBtn := SetupMDIButton(mbClose);
  end;
  TInternalMDIAction(FMinimizeBtn.Action).Form := ChildForm;
  TInternalMDIAction(FRestoreBtn.Action).Form := ChildForm;
  TInternalMDIAction(FCloseBtn.Action).Form := ChildForm;
  Invalidate;
end;

procedure TCustomActionMainMenuBar.MDIChildRestored;
begin
  FreeAndNil(FMinimizeBtn);
  FreeAndNil(FRestoreBtn);
  FreeAndNil(FCloseBtn);
end;

procedure TCustomActionMainMenuBar.CustomAlignPosition(Control: TControl;
  var NewLeft, NewTop, NewWidth, NewHeight: Integer; var AlignRect: TRect;
  AlignInfo: TAlignInfo);
begin
  if Assigned(FMinimizeBtn) and (AlignRect.Right > FMinimizeBtn.Left) then
    case Orientation of
      boLeftToRight: AlignRect.Right := FMinimizeBtn.Left - 2;
      boRightToLeft: AlignRect.Left := FMinimizeBtn.BoundsRect.Right + 2;
    end;
  inherited;
end;

procedure TCustomActionMainMenuBar.CreateControls;
begin
  inherited;
  if Assigned(ActionClient) and (Length(FWindowMenu) > 0) then
    SetupWindowMenu;
end;

procedure TCustomActionMainMenuBar.WMSysCommand(
  var Message: TWMSysCommand);
var
  Item: TActionClientItem;
begin
  if (GetParentForm(Self) <> Screen.FocusedForm) and (Application.ModalLevel <> 0) then exit;
  { Enter menu loop if only the Alt key is pressed -- ignore Alt-Space and let
    the default processing show the system menu. }
  if not InMenuLoop and Enabled and Showing then
    with Message do
      if (CmdType and $FFF0 = SC_KEYMENU) and (Key <> VK_SPACE) and
        (Key <> Word('-')) and (GetCapture = 0) then
      begin
        if Key <> 0 then
        begin
          Item := FindAccelItem(Message.Key);
          if Assigned(Item) then
          begin
            Item.Control.Keyed;
            Result := 1;
          end;
        end
        else if not FCancelMenu then
        begin
          Item := FindFirstVisibleItem;
          PersistentHotKeys := True;
          if Assigned(Item) then
            Item.Control.Selected := True;
          PostMessage(Handle, CM_ENTERMENULOOP, 0, 0);
        end;
        FCancelMenu := False;
        Result := 1;
      end;
end;

procedure TCustomActionMainMenuBar.WMSysKeyDown(var Message: TWMSysKeyDown);
begin
  FCancelMenu := Message.CharCode = VK_MENU;
  inherited;
end;

procedure TCustomActionMainMenuBar.WMSysKeyUp(var Message: TWMSysKeyUp);
begin
  FCancelMenu := Message.CharCode = VK_MENU;
  inherited;
end;

function TCustomActionMainMenuBar.MainWndHook(
  var Message: TMessage): Boolean;
begin
  // Used to gray out main menu items when application does not have focus
  case Message.Msg of
    CM_ACTIVATE,
    CM_DEACTIVATE:
      begin
        FCancelMenu := False;
        if InMenuLoop then
          CloseMenu;
        if not Designable or not Assigned(ActionBarDesigner) then
          Inactive := Message.Msg = CM_DEACTIVATE;
      end;
  end;
  Result := False;
end;

procedure TCustomActionMainMenuBar.SetShadows(const Value: Boolean);
begin
  if FShadows <> Value then
  begin
    FShadows := Value;
    FreeAndNil(FCachedMenu);
  end;
end;

procedure TCustomActionMainMenuBar.TrackMenu;
var
  LFreeNotify: TActionMenuFreeNotify;
begin
  RefreshMDIMenu;  // Rebuild the Window menu items if necessary
  LFreeNotify := TActionMenuFreeNotify.Create(Self);
  try
  try
    inherited;
  finally
    if not LFreeNotify.Freed then
    begin
      FreeAndNil(FMDIActions);
      FreeAndNil(FMDISeparator);
    end;
  end;
  finally
    LFreeNotify.Free;
  end;
end;

{ TCustomMenuItem }

constructor TCustomMenuItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csCaptureMouse];
  Margins := System.Types.Rect(2,0,10,0);
  Spacing := 10;   // Distance between Caption and ShortcutText
  if AOwner is TCustomActionMenuBar then
    FMenu := TCustomActionMenuBar(AOwner);
  FCYMenu := GetSystemMetrics(SM_CYMENU);
end;

destructor TCustomMenuItem.Destroy;
begin
  if Assigned(ActionClient) and (ActionClient.ChildActionBar is TCustomActionMenuBar) then
    TCustomActionMenuBar(ActionClient.ChildActionbar).CloseMenu;
  inherited Destroy;
end;

procedure TCustomMenuItem.DrawSubMenuGlyph;
const
  ArrowPos = 11;
begin
  if not Assigned(ActionClient) or not ActionClient.HasItems or
     (ActionClient.Items.VisibleCount = 0) then
    exit;
  with Canvas do
  begin
    if Selected then
      Pen.Color := ActionBar.ColorMap.SelectedFontColor
    else
      Pen.Color := ActionBar.ColorMap.FontColor;
    Brush.Color := Pen.Color;
  end;
  if Selected then
    Canvas.Pen.Color := Menu.ColorMap.SelectedFontColor;
  DrawArrow(Canvas, sdRight, Point(Width - ArrowPos, Height div 2 - 3), 3);
end;

procedure TCustomMenuItem.Paint;
begin
  inherited Paint;
  if ActionClient.HasItems then
    DrawSubMenuGlyph;
  if not ActionBar.DesignMode or (ActionBar.DesignMode and not Selected) then
    DrawUnusedEdges;
end;

procedure TCustomMenuItem.DrawUnusedEdges;
const
  Edge: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  PaintRect: TRect;
begin
  PaintRect := ClientRect;
  if (ebTop in FEdges) then
  begin
    Canvas.Pen.Color := ActionBar.ColorMap.ShadowColor;
    Canvas.MoveTo(PaintRect.Left, PaintRect.Top);
    Canvas.LineTo(PaintRect.Right, PaintRect.Top);
  end;
  if (ebBottom in FEdges) then
  begin
    Canvas.Pen.Color := ActionBar.ColorMap.UnusedColor;
    Canvas.MoveTo(PaintRect.Left, PaintRect.Bottom - 1);
    Canvas.LineTo(PaintRect.Right, PaintRect.Bottom - 1);
  end;
  if (ebRight in FEdges) then
    if ebTop in Edges then
      Inc(PaintRect.Top);
end;

procedure TCustomMenuItem.Click;
var
  ParentForm: TCustomForm;
begin
  ParentForm := Menu.RootMenu.FParentForm;
  if Assigned(ParentForm) and Menu.RootMenu.AutoFocus then
    ParentForm.SetFocus;
// Do nothing here since menu items are only ever really clicked when the
// user lets the mouse button up while over an item
end;

procedure TCustomMenuItem.Keyed;
begin
  SetSelected(True);
  FMouseSelected := False;
  if Action is TCustomAction then
    with TCustomAction(Action) do
      if (GroupIndex > 0) and not AutoCheck then
        Checked := True;
{$IF DEFINED(CLR)}
  inherited Keyed;
{$ELSE}
  if Assigned(Parent) then
    PostMessage(Parent.Handle, CM_ITEMKEYED, 0, Winapi.Windows.LPARAM(Self));
{$ENDIF}
end;

procedure TCustomMenuItem.SetEdges(const Value: TMenuEdges);
var
  NewHeight: Integer;
  LastItem: TActionClientItem;
begin
  if FEdges <> Value then
  begin
    NewHeight := Height;
    if (ebTop in Value) and not (ebTop in FEdges) then
      Inc(NewHeight)
    else
      if not (ebTop in Value) and (ebTop in FEdges) then
        Dec(NewHeight);
    if (ebBottom in Value) and not (ebBottom in FEdges) then
      Inc(NewHeight)
    else
      if not (ebBottom in Value) and (ebBottom in FEdges) then
        Dec(NewHeight);
    LastItem := ActionBar.FindLastVisibleItem;
    if Assigned(LastItem) and (Self = LastItem.Control) then
      Inc(NewHeight);
    FEdges := Value;
    Height := NewHeight;
    Invalidate;
  end;
end;

procedure TCustomMenuItem.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if (DragMode = dmAutomatic) then
    exit;
  FMouseSelected := True;
  SetSelected(True);
  if not Separator and not Enabled and Assigned(Menu) then
    with Menu do
      RootMenu.DelayItem := nil;
end;

procedure TCustomMenuItem.CMTextchanged(var Message: TMessage);
begin
  inherited;
  FNoPrefix := StripHotkey(Caption);
end;

procedure TCustomMenuItem.SetSelected(Value: Boolean);
begin
  if not Value then
    FMouseSelected := False;
  if (ActionClient.ParentItem is TActionClientItem) and
     (TActionClientItem(ActionClient.ParentItem).Control is TCustomMenuItem) then
    TActionClientItem(ActionClient.ParentItem).Control.Selected := True;
  inherited SetSelected(Value);
  if Assigned(Menu) then
    Menu.DoItemSelected(Self);
end;

procedure TCustomMenuItem.DragDrop(Source: TObject; X, Y: Integer);
begin
  inherited DragDrop(Source, X, Y);
  if (ActionBar is TCustomActionMenuBar) then
    with TCustomActionMenuBar(ActionBar) do
      if (RootMenu <> nil) and Assigned(RootMenu.Parent) then
        Winapi.Windows.SetFocus(Application.Handle);
end;

procedure TCustomMenuItem.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if (Source is TActionItemDragObject) then
    with TActionItemDragObject(Source) do
    begin
      if (ActionClient = ClientItem) and
         (ActionClient.ChildActionBar is TCustomActionMenuBar) then
        with TCustomActionMenuBar(ActionClient.ChildActionBar) do
          CloseMenu;
      if Assigned(Menu.RootMenu.DelayItem) and
         (Menu.RootMenu.DelayItem.ActionClient = ClientItem) then
        Menu.RootMenu.DelayItem := nil;
    end;
  inherited DragOver(Source, X, Y, State, Accept);
  if Accept and (ActionBar is TCustomActionMenuBar) then
    if TCustomActionMenuBar(ActionBar).InMenuLoop then
      Selected := True
end;

procedure TCustomMenuItem.CalcBounds;
var
  AWidth, AHeight: Integer;
  NewTextBounds: TRect;
  ImageSize: TPoint;
  ImageOffset: Integer;
begin
  if (ActionClient <> nil) and ActionClient.Default then
    Font.Style := Font.Style + [fsBold];
  inherited CalcBounds;
  ImageSize := GetImageSize;
  AHeight := FCYMenu;
  if Separator then
    AHeight := FCYMenu div 3 * 2
  else
    // 16 is standard image size so adjust for larger images
    if ImageSize.Y > 16 then
      AHeight := ImageSize.Y + 4;
  if ActionClient = nil then exit;
  if ImageSize.X <= 16 then
    ImageOffset := 24
  else
    ImageOffset := ImageSize.X + 6;  // Leave room for an image frame
  NewTextBounds := TextBounds;
  OffsetRect(NewTextBounds, 24 - TextBounds.Left,
    AHeight div 2 - TextBounds.Bottom div 2 - 1);
  TextBounds := NewTextBounds;
  ShortCutBounds := System.Types.Rect(0,0,0,0);
  if ActionClient.ShortCut <> 0 then
  begin
    Winapi.Windows.DrawText(Canvas.Handle, ActionClient.ShortCutText, -1,
      FShortCutBounds, DT_CALCRECT);
    // Left offset is determined when the item is painted to make it right justified
    FShortCutBounds.Top := TextBounds.Top;
    FShortCutBounds.Bottom := TextBounds.Bottom;
    AWidth := TextBounds.Right + FShortCutBounds.Right + ImageOffset + Spacing;
  end
  else
    AWidth := TextBounds.Right + TextBounds.Left;
  SetBounds(Left, Top, AWidth, AHeight);
end;

procedure TCustomMenuItem.CalcLayout;
begin
  inherited CalcLayout;
  GlyphPos := Point(Margins.Left, Height div 2 - GetImageSize.Y div 2 + 1);
end;

procedure TCustomMenuItem.DrawEdge(Edges: TMenuEdges);
begin
end;

procedure TCustomMenuItem.DrawShadowedText(Rect: TRect; Flags: Cardinal;
  Text: string; TextColor, ShadowColor: TColor);
var
  ShortCutRect: TRect;
begin
  if Parent is TCustomActionBar then
    if not ActionBar.PersistentHotkeys then
      Text := FNoPrefix;
  if Selected then
    ShadowColor := ActionBar.ColorMap.HotColor;
  inherited DrawShadowedText(Rect, Flags, Text, TextColor, ShadowColor);
  if ShowShortCut then
  begin
    Flags := DrawTextBiDiModeFlags(DT_RIGHT);
    ShortCutRect := FShortCutBounds;
    OffsetRect(ShortCutRect, Width - 21 - FShortCutBounds.Right, 0);
    inherited DrawShadowedText(ShortCutRect, Flags, ActionClient.ShortCutText,
      TextColor, ShadowColor);
  end;
end;

procedure TCustomMenuItem.DrawText(var ARect: TRect; var Flags: Cardinal;
  Text: string);
var
  ShortCutRect: TRect;
begin
  if Parent is TCustomActionBar then
    if not ActionBar.PersistentHotkeys then
      Text := FNoPrefix;
  inherited;
  if ShowShortCut then
  begin
    Flags := DrawTextBiDiModeFlags(DT_RIGHT);
    ShortCutRect := FShortCutBounds;
    OffsetRect(ShortCutRect, Width - 21 - FShortCutBounds.Right, 0);
    inherited DrawText(ShortCutRect, Flags, ActionClient.ShortCutText)
  end;
end;

procedure TCustomMenuItem.PositionChanged;
begin
  inherited PositionChanged;
  if Assigned(ActionClient) then
    ActionClient.CheckUnused := True;
  if not Menu.Expanded then
    Menu.Expand(True);
end;

procedure TCustomMenuItem.DoDragDrop(DragObject: TObject; X, Y: Integer);
var
  NewItem, NewCategory: TActionClientItem;
  I, Idx: Integer;
begin
  if Assigned(ActionClient) then
    Idx := ActionClient.Index
  else
    Idx := 0;

  if DragObject is TCategoryDragObject then
  begin
    ActionBar.DisableAlign;
    ActionBar.ActionClient.Items.BeginUpdate;
    with DragObject as TCategoryDragObject do
    begin
      with ActionBar.ActionManager do
        NewCategory :=  GetActionClientItemClass.Create(ActionBar.ActionClient.Items);
      try
        try
          NewCategory.UsageCount := 1;
          NewCategory.Caption := Category;
          NewCategory.LastSession := ActionBar.ActionManager.ActionBars.SessionCount;
          NewCategory.Index := Idx;
          NewCategory.Items.BeginUpdate;
          for I := 0 to ActionCount - 1 do
          begin
            with ActionBar.ActionManager do
              NewItem := GetActionClientItemClass.Create(NewCategory.Items);
            NewItem.Action := Actions[I];
            NewItem.LastSession := NewCategory.LastSession;
          end;
          ActionBar.CreateControl(NewCategory);
          NewCategory.Control.Enabled := ActionCount > 0;
        finally
          NewCategory.Items.EndUpdate;
        end;
      finally
        ActionBar.ActionClient.Items.EndUpdate;
        ActionBar.EnableAlign;
        NotifyDesigner(ActionBar);
      end;
    end;
  end
  else
    inherited DoDragDrop(DragObject, X, Y);
end;

procedure TCustomMenuItem.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
{$IF DEFINED(CLR)}
var
  ObjHandle: GCHandle;
{$ENDIF}
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Assigned(ActionClient) and Assigned(ActionClient.ChildActionBar) then exit;
  if Action is TCustomAction then
    with TCustomAction(Action) do
      if (GroupIndex > 0) and not AutoCheck then
        Checked := True;
  if not Separator then
  begin
{$IF DEFINED(CLR)}
    ObjHandle := GCHandle.Alloc(Self, GCHandleType.Weak);
    PostMessage(Parent.Handle, CM_ITEMCLICKED, 1, LPARAM(IntPtr(ObjHandle)));
{$ELSE}
    PostMessage(Parent.Handle, CM_ITEMCLICKED, 0, Winapi.Windows.LPARAM(Self));
{$ENDIF}
  end;
end;

procedure TCustomMenuItem.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
end;

{ TCustomMenuButton }

constructor TCustomMenuButton.Create(AOwner: TComponent);
begin
  inherited;
  FCloseMenu := False;
end;

destructor TCustomMenuButton.Destroy;
begin
  if Assigned(ActionClient) and (ActionClient.ChildActionBar is TCustomActionMenuBar) then
    TCustomActionMenuBar(ActionClient.ChildActionbar).CloseMenu;
  inherited Destroy;
end;

procedure TCustomMenuButton.BeginAutoDrag;
begin
  FDoClick := True;
  Click;
  inherited BeginAutoDrag;
end;

procedure TCustomMenuButton.Click;
{$IF DEFINED(CLR)}
var
  ObjHandle: GCHandle;
{$ENDIF}
begin
  if Assigned(ActionClient) and Assigned(ActionClient.Action) then
  begin
    SetSelected(True);
    if not ActionBar.DesignMode then
      ResetUsageData;
  end
  else
    inherited Click;
  if not FDoClick then exit;
  if Assigned(ActionClient) then
    if Menu.InMenuLoop and (not Selected or Selected and (ActionClient.ChildActionBar = nil)) then
      Menu.DoItemClicked(Self)
    else if FCloseMenu then
    begin
      FCloseMenu := False;
      Menu.CloseMenu;
    end
    else
    begin
{$IF DEFINED(CLR)}
      ObjHandle := GCHandle.Alloc(Self, GCHandleType.Weak);
      PostMessage(ActionBar.Handle, CM_ITEMCLICKED, 1, LPARAM(IntPtr(ObjHandle)));
{$ELSE}
      PostMessage(ActionBar.Handle, CM_ITEMCLICKED, 0, Winapi.Windows.LPARAM(Self));
{$ENDIF}
    end;
end;

procedure TCustomMenuButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if Menu.FItemKeyed then exit;
  if not ActionBar.DesignMode and not Selected and Menu.InMenuLoop then
  begin
    FDoClick := True;
    Click;
  end;
end;

procedure TCustomMenuButton.DoDragDrop(DragObject: TObject; X, Y: Integer);
begin
  if DragObject is TCategoryDragObject then
    ActionBar.DoDropCategory(TCategoryDragObject(DragObject),
      Left + X, Top + Y)
  else
    inherited DoDragDrop(DragObject, X, Y);
  if ActionBar is TCustomActionMenuBar then
    TCustomActionMenuBar(ActionBar).CloseMenu;
end;

procedure TCustomMenuButton.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  inherited DragOver(Source, X, Y, State, Accept);
  if Accept and (ActionBar is TCustomActionMenuBar) then
  begin
    if Source is TActionItemDragObject then
      with TActionItemDragObject(Source) do
        if (ClientItem = ActionClient) and Assigned(ActionBar) and
           (ActionBar is TCustomActionMenuBar) then
          with TCustomActionMenuBar(ActionBar) do
            ClearSubMenus;
    if not Selected then
    begin
      FDoClick := True;
      Click;
    end
  end;
end;

procedure TCustomMenuButton.DrawText(var ARect: TRect; var Flags: Cardinal;
  Text: string);
var
  S: string;
begin
  S := Text;
  if Parent is TCustomActionMainMenuBar then
    with TCustomActionMainMenuBar(Parent) do
    begin
      if not PersistentHotkeys then
        S := StripHotkey(S);
      if Inactive and not Self.MouseInControl then
        Self.Canvas.Font.Color := ActionBar.ColorMap.DisabledFontColor;
      if Self.Selected then
        Self.Canvas.Font.Color := ActionBar.ColorMap.BtnSelectedFont;
    end;
  inherited DrawText(ARect, Flags, S);
end;

function TCustomMenuButton.GetMenu: TCustomActionMenuBar;
begin
  Result := ActionBar as TCustomActionMenuBar;
end;

procedure TCustomMenuButton.Keyed;
begin
  SetSelected(True);
  inherited Keyed;
end;

procedure TCustomMenuButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
{$IF DEFINED(CLR)}
var
  ObjHandle: GCHandle;
{$ENDIF}
begin
  inherited MouseDown(Button, Shift, X, Y);
  FCloseMenu := Menu.InMenuLoop;
  case Button of
    mbLeft:
      if not FCloseMenu then
      begin
        Selected := True;
        if Assigned(ActiveMenu) and (Owner <> ActiveMenu) then
          ActiveMenu.CloseMenu;
{$IF DEFINED(CLR)}
        ObjHandle := GCHandle.Alloc(Self, GCHandleType.Weak);
        PostMessage(Menu.Handle, CM_ITEMCLICKED, 1, LPARAM(IntPtr(ObjHandle)));
{$ELSE}
        PostMessage(Menu.Handle, CM_ITEMCLICKED, 0, Winapi.Windows.LPARAM(Self));
{$ENDIF}
      end;
    mbRight:
      if Menu.InMenuLoop and (Button = mbRight) then
        Menu.CloseMenu;
  end;
end;

procedure TCustomMenuButton.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDoClick := False;
  inherited;
  if (Button = mbLeft) and FCloseMenu then
    Menu.CloseMenu
end;

procedure TCustomMenuButton.Paint;
var
  OldState: TButtonState;
begin
  OldState := State;
  if Assigned(ActionClient.ChildActionBar) then
    FState := bsDown;
  inherited Paint;
  FState := OldState;
end;

procedure TCustomMenuButton.CMDialogChar(var Message: TCMDialogChar);
var
  ParentForm: TCustomForm;
  SelectedItem: TActionClientItem;
{$IF DEFINED(CLR)}
  ObjHandle: GCHandle;
{$ENDIF}
begin
  inherited;
  ParentForm := GetParentForm(Parent);
{$IF DEFINED(CLR)}
  if Assigned(ParentForm) and ((ParentForm as IMDIForm).GetFormStyle = fsMDIForm) then
{$ELSE}
  if Assigned(ParentForm) and (TCustomFormClass(ParentForm).FormStyle = fsMDIForm) then
{$ENDIF}
  begin
    SelectedItem := Actionbar.FindAccelItem(Message.CharCode);
    if Assigned(SelectedItem) then
    begin
      SelectedItem.Control.Selected := True;
{$IF DEFINED(CLR)}
      ObjHandle := GCHandle.Alloc(SelectedItem.Control, GCHandleType.Weak);
      PostMessage(Menu.Handle, CM_ITEMCLICKED, 1, LPARAM(IntPtr(ObjHandle)));
{$ELSE}
      PostMessage(Menu.Handle, CM_ITEMCLICKED, 0, Winapi.Windows.LPARAM(SelectedItem.Control));
{$ENDIF}
      Message.Result := 1;
    end;
  end;
end;

{ Register routines }

procedure RegisterActnBarStyle(AStyle: TActionBarStyleEx);
begin
  if not Assigned(ActionBarStyles) then
    ActionBarStyles := TActionBarStyleList.Create;
  if ActionBarStyles.IndexOf(AStyle.GetStyleName) = -1 then
    ActionBarStyles.AddObject(AStyle.GetStyleName, AStyle);
end;

procedure UnRegisterActnBarStyle(AStyle: TActionBarStyleEx);
var
  Idx: Integer;
begin
  Idx := ActionBarStyles.IndexOfObject(AStyle);
  if Idx <> -1 then
    ActionBarStyles.Delete(Idx);
  if ActionBarStyles.Count = 0 then
    FreeAndNil(ActionBarStyles);
end;

initialization
  UpdateActnMenusProc := nil;
  MenuCallWndHook := 0;
  MenuList := nil;
end.
