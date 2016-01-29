{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.Ribbon;

{$HPPEMIT '#ifndef _WIN64'}
{$HPPEMIT '#pragma link "dwmapi.lib"'}
{$HPPEMIT '#endif //_WIN64'}

interface

uses
  Winapi.Windows, Winapi.Messages, Vcl.Graphics, System.SysUtils, System.Classes, System.Actions, Vcl.Controls, System.Types, Vcl.ExtCtrls,
  Vcl.ActnMan, Vcl.Forms, Vcl.ActnCtrls, Vcl.ActnList, System.Contnrs, Vcl.Menus, Vcl.ActnPopup, Vcl.ActnColorMaps,
  Vcl.RibbonActnMenus, Vcl.RibbonActnCtrls, Vcl.RibbonStyleActnCtrls, Vcl.ScreenTips, Vcl.ToolWin,
  Vcl.CustomizeDlg, Vcl.ImgList, Vcl.GraphUtil, Vcl.ActnMenus;

type
  ERibbonException = class(Exception);

  TCustomRibbonColorMap = class(TXPColorMap)
  private
    FActiveTabFontColor: TColor;
    FBevelMinimizedOuter: TColor;
    FBevelMinimizedInner: TColor;
    FControlColor: TColor;
    FControlFrameColor: TColor;
    FControlInactiveColor: TColor;
    FGroupFontColor: TColor;
    FInactiveTabFontColor: TColor;
    FCaptionFontColor: TColor;
    FDocumentFontColor: TColor;
    FQuickAccessToolbarMoreColor: TColor;
    FQuickAccessToolbarMoreBorderColor: TColor;
  public
    property ActiveTabFontColor: TColor read FActiveTabFontColor write FActiveTabFontColor;
    property BevelMinimizedInner: TColor read FBevelMinimizedInner write FBevelMinimizedInner;
    property BevelMinimizedOuter: TColor read FBevelMinimizedOuter write FBevelMinimizedOuter;
    property CaptionFontColor: TColor read FCaptionFontColor write FCaptionFontColor;
    property ControlColor: TColor read FControlColor write FControlColor;
    property ControlFrameColor: TColor read FControlFrameColor write FControlFrameColor;
    property ControlInactiveColor: TColor read FControlInactiveColor write FControlInactiveColor;
    property DocumentFontColor: TColor read FDocumentFontColor write FDocumentFontColor;
    property GroupFontColor: TColor read FGroupFontColor write FGroupFontColor;
    property InactiveTabFontColor: TColor read FInactiveTabFontColor write FInactiveTabFontColor;
    property QuickAccessToolbarMoreColor: TColor read FQuickAccessToolbarMoreColor write FQuickAccessToolbarMoreColor;
    property QuickAccessToolbarMoreBorderColor: TColor read FQuickAccessToolbarMoreBorderColor write FQuickAccessToolbarMoreBorderColor;
  end;

  // Color map classes for each Skin
  TRibbonLunaColorMap = class(TCustomRibbonColorMap)
  public
    procedure UpdateColors; override;
  published
    property BevelMinimizedInner default $00E3BB9B;
    property BevelMinimizedOuter default $00F3E2D5;
    property BtnSelectedFont default $006E1500;
    property CaptionFontColor default $00AA6A3E;
    property ControlColor default clWhite;
    property ControlInactiveColor default $00FBF2EA;
    property ControlFrameColor default $00DFC4AF;
    property DisabledFontColor default $00A7A7A7;
    property DocumentFontColor default $00797069;
    property FontColor default $006E1500;
    property HighlightColor default $006E1500;
    property ActiveTabFontColor default $006E1500;
    property GroupFontColor default $006E1500;
    property InactiveTabFontColor default $006E1500;
    property QuickAccessToolbarMoreColor default $00FFDCC2;
    property QuickAccessToolbarMoreBorderColor default $00A06437;
  end;

  TRibbonObsidianColorMap = class(TCustomRibbonColorMap)
  public
    procedure UpdateColors; override;
  published
    property BevelMinimizedInner default $004F4F4F;
    property BevelMinimizedOuter default $00626262;
    property BtnSelectedFont default $006E1500;
    property CaptionFontColor default $00AA6A3E;
    property ControlColor default clWindow;
    property ControlInactiveColor default $00E8E8E8;
    property ControlFrameColor default $00898989;
    property DisabledFontColor default $00A7A7A7;
    property DocumentFontColor default $00797069;
    property FontColor default $00464646;
    property HighlightColor default $006E1500;
    property ActiveTabFontColor default clBlack;
    property GroupFontColor default clWhite;
    property InactiveTabFontColor default clWhite;
    property QuickAccessToolbarMoreColor default $008E8076;
    property QuickAccessToolbarMoreBorderColor default $00433C37;
  end;

  TRibbonSilverColorMap = class(TCustomRibbonColorMap)
  public
    procedure UpdateColors; override;
  published
    property BevelMinimizedInner default clGray;
    property BevelMinimizedOuter default $00EBE1DC;
    property BtnSelectedFont default $006E1500;
    property CaptionFontColor default $00AA6A3E;
    property ControlColor default clWindow;
    property ControlInactiveColor default $00ECEAE8;
    property ControlFrameColor default $00898989;
    property DisabledFontColor default $008D8D8D;
    property DocumentFontColor default $00797069;
    property FontColor default clBlack;
    property HighlightColor default $006E1500;
    property ActiveTabFontColor default $005C534C;
    property GroupFontColor default $00595453;
    property InactiveTabFontColor default $005C534C;
    property QuickAccessToolbarMoreColor default $00E4DADB;
    property QuickAccessToolbarMoreBorderColor default $0099797A;
  end;

  TCustomRibbon = class;

  // interface implemented by any ribbon specific group
  IRibbonGroup = interface
    ['{A7B85541-B753-4DDD-AE84-9FADE8ADA927}']
    // Call to realign controls on a group
    procedure AlignGroupControls;
    // Recreate a specific control
    function CreateControl(AnItem: TActionClientItem): TCustomActionControl;
    procedure StyleChanged(AStyle: TRibbonStyleActionBars);
  end;

  IRibbon = interface
    ['{01447C2B-0643-4A1A-B4CE-D5CB75746F9F}']
    function GetRibbon: TCustomRibbon;
    procedure SetRibbon(const Value: TCustomRibbon);
    property Ribbon: TCustomRibbon read GetRibbon write SetRibbon;
  end;

  TCustomRibbonPage = class;
  TRibbonPage = class;

  TCustomActionControlBar = class(TCustomActionToolbar)
  private
    FCreatingControls: Boolean;
    FAddingContainedControl: Boolean;
  protected
    function GetControlClass(AnItem: TActionClientItem): TCustomActionControlClass; override;
    procedure CreateControls; override;
{$IFNDEF CLR}
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
{$ELSE}
    procedure ControlChange(Inserting: Boolean; Child: TControl); override;
{$ENDIF}
    property CreatingControls: Boolean read FCreatingControls;
  public
    constructor Create(AOwner: TComponent); override;
    function CreateControl(AnItem: TActionClientItem): TCustomActionControl; override;
  end;

  TRibbonGroupCollapsedControl = class;

  TRibbonGroupDockForm = class(TXToolDockForm)
  private
    FControl: TControl;
    FParentControl: TWinControl;
  protected
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    // Reference to the control that invoked the floating group
    property Control: TControl read FControl write FControl;
    property ParentControl: TWinControl read FParentControl write FParentControl;
  end;

  TRibbonGroupVariant = (rgvCollapsed, rgvSmall, rgvMedium, rgvLarge);

  TRibbonGroupScrollButton = class(TCustomControl)
  private
    FRibbonStyle: TRibbonStyleActionBars;
    FDirection: TScrollDirection;
    FMouseInControl: Boolean;
    procedure SetDirection(const Value: TScrollDirection);
    procedure SetMouseInControl(const Value: Boolean);
  protected
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure Paint; override;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest);
      message CM_DESIGNHITTEST;
    property Direction: TScrollDirection read FDirection write SetDirection;
    property MouseInControl: Boolean read FMouseInControl write SetMouseInControl;
    property RibbonStyle: TRibbonStyleActionBars read FRibbonStyle write FRibbonStyle;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  // Controls are display on the Ribbon Group. This class aligns and displays
  // all controls available for use on the ribbon.
  TCustomRibbonGroup = class(TCustomActionControlBar, IRibbonGroup,
    IRibbonBarKeyTip, IRibbonKeyTip)
  public
    type
      // The alignment of the group
      // gaHorizontal - controls are aligned left to right in rows. The row
      //   ends when a control has the NewRow property set to True. The NewRow
      //   property can be ignored when a group is being minimized.
      // gaVertical - controls are aligned top to bottom moving left to right.
      //   Groups aligned vertically are autosized
      TGroupAlign = (gaHorizontal, gaVertical);
      // The Y coordinate for a row in the group.
      TRowPosition = array [1..3] of Integer;
  private
    FSpacingVert: Integer;
    FSpacingHorz: Integer;
    FDialogButtonHot: Boolean;
    FMouseInControl: Boolean;
    FRows: Integer;
    FRequiredWidth: Integer;
    FRowStart: Integer;
    FGroupAlign: TGroupAlign;
    FPage: TRibbonPage;
    FKeyTipForm: TCustomControl;
    FKeyTip: string;
    FGroupVariant: TRibbonGroupVariant;
    FGroupIndex: Integer;
    FCollapsedControl: TRibbonGroupCollapsedControl;
    FDialogAction: TContainedAction;
    FRowPosition: TRowPosition;
    FRibbon: TCustomRibbon;
    function GetCanCollapse: Boolean;
    function GetCaptionRect: TRect;
    function GetHasGallery: Boolean;
    function GetDialogButtonRect: TRect;
    function GetRequiredWidth: Integer;
    procedure SetRows(const Value: Integer);
    procedure SetMouseInControl(const Value: Boolean);
    procedure SetDialogButtonHot(const Value: Boolean);
    procedure SetGroupAlign(const Value: TGroupAlign);
    function RibbonStyle: TRibbonStyleActionBars;
    procedure SetGroupVariant(const Value: TRibbonGroupVariant);
    function GetGroupWidth: Integer;
    procedure CreateCollapsedControl;
    procedure SetGroupIndex(const Value: Integer);
    procedure SetDialogAction(const Value: TContainedAction);
    property DialogButtonHot: Boolean read FDialogButtonHot write SetDialogButtonHot;
    property MouseInControl: Boolean read FMouseInControl write SetMouseInControl;
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure CMItemDropPoint(var Message: TCMItemMsg); message CM_ITEMDROPPOINT;
    procedure CMFontchanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMTextchanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CreateControls; override;
    procedure DoDropItem(Source: TActionItemDragObject; const X: Integer;
      const Y: Integer); override;
    procedure DoEndDrag(Target: TObject; X: Integer; Y: Integer); override;
    procedure DrawShowDialogButton; virtual;
    function GetGroupHeight: Integer;
    function GetCaptionHeight: Integer;
    procedure HideControls; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer;
      Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure Paint; override;
    procedure Resize; override;
    procedure SetParent(AParent: TWinControl); override;
    procedure SetupDropDownBtn; override;
    procedure ShowControls; virtual;
    procedure AutoSizingChanged; override;
    procedure SetAutoSizing(const Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AlignGroupControls; virtual;
    procedure BarHandleKeyTips(const KeyTip: string; var KeyTips: TKeyTipList);
    procedure BarHideKeyTips(KeyTips: TKeyTipList);
    procedure BarShowKeyTips;
    function Clone: TCustomRibbonGroup;
    function CreateControl(AnItem: TActionClientItem): TCustomActionControl; override;
    procedure DockDrop(Source: TDragDockObject; X: Integer; Y: Integer); override;
    procedure DragDrop(Source: TObject; X: Integer; Y: Integer); override;
    function GetKeyTip: string;
    procedure KeyTipClick;
    procedure HandleKeyTip(const KeyTip: string; var Handled: TKeyTipHandled);
    procedure HideKeyTip(const Match: string);
    procedure SetKeyTip(const Value: string);
    procedure ShowKeyTip(const Position: TKeyTipPosition);
    procedure Assign(Source: TPersistent); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    procedure StyleChanged(AStyle: TRibbonStyleActionBars); virtual;
    // Determines whether the group can be display in the collapsed state. If there
    // is only one control on the group, then that group cannot be displayed as
    // collapsed.
    property CanCollapse: Boolean read GetCanCollapse;
    property CollapsedControl: TRibbonGroupCollapsedControl read FCollapsedControl;
    // Determines whether the dialog button is displayed in the lower right
    // hand corner of the group
    property DialogAction: TContainedAction read FDialogAction write SetDialogAction;
    // Determines how the controls on a group are aligned.
    // gaHorizontal - controls are aligned left to right, top to bottom. To make a
    //   control start in a new row, set the NewRow property to true.
    // gaVertical - controls are aligned top to bottom, left to right. Controls are
    // automatically moved to the next column in the group if three controls are
    // already in the column. You can also force a control to a new column by
    // setting the NewCol property to true.
    property GroupAlign: TGroupAlign read FGroupAlign write SetGroupAlign default gaVertical;
    // Index of the group within the current tab
    //
    // Set the GroupIndex property to change the position of the group within
    // the current tab.
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex;
    property GroupWidth: Integer read GetGroupWidth;
    // Returns True if the group has an in ribbon Gallery to display
    property HasGallery: Boolean read GetHasGallery;
    property Items;
    // The KeyTip for the Dialog button of the group. Only valid when
    // DialogAction has been set
    property KeyTip: string read GetKeyTip write SetKeyTip;
    // Reference to the Page that the group is on
    property Page: TRibbonPage read FPage;
    // Width required to display the group in its large Variant
    property RequiredWidth: Integer read GetRequiredWidth;
    // The number of Rows the group has for displaying controls.
    // A group must have at least 1 row and a maximum of 3
    property Rows: Integer read FRows write SetRows default 3;
    // The current size variant the ribbon group is using.
    property GroupVariant: TRibbonGroupVariant read FGroupVariant write SetGroupVariant default rgvLarge;
  end;

  TRibbonGroup = class(TCustomRibbonGroup)
  published
    property ActionManager;
    property BiDiMode;
    property Caption;
    property DialogAction;
    property GroupAlign;
    property GroupIndex;
    property Height;
    property KeyTip;
    property ParentBiDiMode;
    property Rows;
  end;

  TRibbonGroupCollapsedControl = class(TGraphicControl, IRibbonKeyTip, IRibbonGroupDropdown)
  private
    FMouseInControl: Boolean;
    FGroup: TCustomRibbonGroup;
    FFloating: TRibbonGroupDockForm;
    FActionManager: TCustomActionManager;
    FOldWidth: Integer;
    FKeyTipForm: TCustomControl;
    FKeyTip: string;
    FImageList: TCustomImageList;
    FImageIdx: Integer;
    procedure SetMouseInControl(const Value: Boolean);
    procedure SetGroup(const Value: TCustomRibbonGroup);
    procedure SetActionManager(const Value: TCustomActionManager);
    function RibbonStyle: TRibbonStyleActionBars;
  protected
    procedure AdjustBounds; dynamic;
    procedure Click; override;
    procedure CMFontchanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMTextchanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure Paint; override;
    procedure SetupGroupImage;
    property MouseInControl: Boolean read FMouseInControl write SetMouseInControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CloseUp;
    function GetKeyTip: string;
    procedure HandleKeyTip(const KeyTip: string; var Handled: TKeyTipHandled);
    procedure HideKeyTip(const Match: string);
    procedure KeyTipClick;
    procedure SetKeyTip(const Value: string);
    procedure ShowKeyTip(const Position: TKeyTipPosition);
    function GetParentControl: TWinControl;
    function GetTopPosition: Integer;
    property OldWidth: Integer read FOldWidth write FOldWidth;
    property ActionManager: TCustomActionManager read FActionManager write SetActionManager;
  published
    property Caption;
    // The group associated with the collapsed button
    property Group: TCustomRibbonGroup read FGroup write SetGroup;
    property KeyTip: string read GetKeyTip write SetKeyTip;
  end;

  TCustomRibbonQuickAccessToolbar = class;

  // class that defines the Quick Access Toolbar appearance. This class
  // contains a reference to the Quick Access Toolbar on the form
  TQuickAccessToolbar = class(TPersistent)
  public
    type
      // Position of the Quick Access Toolbar
      // qpTop - Quick Access Toolbar is positioned at the top of the ribbon
      // gpBottom - Quick Access Toolbar is positioned at the base of the ribbon
      TQATPosition = (qpTop, qpBottom);
  private
    FActionBar: TCustomRibbonQuickAccessToolbar;
    FRibbon: TCustomRibbon;
    FOnChange: TNotifyEvent;
    FPosition: TQATPosition;
    FShowMinimize: Boolean;
    FShowMoreCommands: Boolean;
    FShowPosition: Boolean;
    function GetBarWidth: Integer;
    procedure SetActionBar(const Value: TCustomRibbonQuickAccessToolbar);
    procedure SetPosition(const Value: TQATPosition);
    procedure SetShowMinimize(const Value: Boolean);
    procedure SetShowMoreCommands(const Value: Boolean);
    procedure SetShowPosition(const Value: Boolean);
  protected
    procedure DoChange; virtual;
  public
    constructor Create(ARibbon: TCustomRibbon); reintroduce;
    procedure Assign(Source: TPersistent); override;
    procedure Show(const Visible: Boolean);
    procedure TogglePosition;
    property BarWidth: Integer read GetBarWidth;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property ActionBar: TCustomRibbonQuickAccessToolbar read FActionBar write SetActionBar;
    property Position: TQATPosition read FPosition write SetPosition default qpTop;
    property ShowMinimize: Boolean read FShowMinimize write SetShowMinimize default True;
    property ShowMoreCommands: Boolean read FShowMoreCommands write SetShowMoreCommands default True;
    property ShowPosition: Boolean read FShowPosition write SetShowPosition default True;
  end;

  IRibbonQuickAccessToolbar = interface
    ['{C1F7156F-F1AF-4882-9697-E3229DBDBF11}']
    procedure DoUpdateQATWidth;
  end;

  TRibbonCustomizeDlg = class(TCustomizeDlg)
  protected
    procedure SetupDlg; override;
  end;

  // Control used to display the items available on the Quick Access Toolbar.
  TCustomRibbonQuickAccessToolbar = class(TCustomActionToolBar,
    IRibbonQuickAccessToolbar, IRibbonBarKeyTip)
  public
    type
      TMoreCommandsEvent = procedure (Sender: TObject; var Handled: Boolean) of object;
  private
    FShowBorder: Boolean;
    FRibbon: TCustomRibbon;
    // Actions required for QAT specific functions
    FMoreCommandsAction: TAction;
    FMinimizeRibbonAction: TAction;
    FShowBelowRibbonAction: TAction;
    FOnMoreCommands: TMoreCommandsEvent;
    FCustomizeDlg: TRibbonCustomizeDlg;
    procedure SetShowBorder(const Value: Boolean);
    procedure CreateQATActions;
    procedure MinimizeRibbonHandler(Sender: TObject);
    procedure ShowBelowRibbonHandler(Sender: TObject);
    procedure MoreCommandsHandler(Sender: TObject);
    //procedure FindRibbon;
    function RibbonStyle: TRibbonStyleActionBars;
    function GetScrollMode: TQATScrollMode;
    procedure SetScrollMode(const Value: TQATScrollMode);
    procedure CustomizeHandler(Sender: TObject);
  protected
    procedure CMFontchanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMVisiblechanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure WMPaint(var Message : TWMPaint); message WM_PAINT;
    procedure CreateControls; override;
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); override;
    procedure DoDropActions(Source: TActionDragObject; const X: Integer;
      const Y: Integer); override;
    procedure DoDropItem(Source: TActionItemDragObject; const X: Integer;
      const Y: Integer); override;
    procedure DoMoreCommands; virtual;
    procedure DoScrollBtnClick; override;
    procedure DrawBackground; override;
    function GetBarHeight: Integer; override;
    function GetBarWidth: Integer; override;
    function GetScrollBtnClass: TCustomToolScrollBtnClass; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetupDropDownBtn; override;
    procedure ShowCustomizeMenu(AScrollBtn: TRibbonQATScrollButton); virtual;
    procedure ShowMoreControls; virtual;
    procedure RequestAlign; override;
    procedure UpdateQATWidth; virtual;
    procedure SetParent(AParent: TWinControl); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Customize;
    procedure DoUpdateQATWidth;
    function CreateControl(AnItem: TActionClientItem): TCustomActionControl; override;
    procedure DoDropCategory(Source: TCategoryDragObject; const X: Integer;
      const Y: Integer); override;
    procedure DragDrop(Source: TObject; X: Integer; Y: Integer); override;
    procedure BarHandleKeyTips(const KeyTip: string; var KeyTips: TKeyTipList);
    procedure BarHideKeyTips(KeyTips: TKeyTipList);
    procedure BarShowKeyTips;
    property Items;
    property Ribbon: TCustomRibbon read FRibbon;
    property ScrollMode: TQATScrollMode read GetScrollMode write SetScrollMode;
    property ShowBorder: Boolean read FShowBorder write SetShowBorder;
    property OnMoreCommands: TMoreCommandsEvent read FOnMoreCommands write FOnMoreCommands;
  end;

  TRibbonQuickAccessToolbar = class(TCustomRibbonQuickAccessToolbar)
  published
    property ActionManager;
    property VertMargin default 1;
    property OnMoreCommands;
  end;

  // Class used to display any additional controls available on the Quick Access
  // Toolbar that will not fit due to the current width of the parent form.
  TCustomRibbonQuickAccessPopupToolbar = class(TCustomActionPopupMenu)
  private
    FQuickAccessToolbar: TCustomRibbonQuickAccessToolbar;
  protected
    function ValidOrientations: TBarOrientations; override;
    procedure NCPaint(DC: HDC); override;
    procedure CreateWnd; override;
    procedure DrawBackground; override;
    function GetControlClass(AnItem: TActionClientItem): TCustomActionControlClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CreateControl(AnItem: TActionClientItem): TCustomActionControl; override;
  end;

  TRibbonQuickAccessPopupToolbar = class(TCustomRibbonQuickAccessPopupToolbar)

  end;

  TRibbonTabItem = class(TCollectionItem)
  private
    FX: Integer;
    FY: Integer;
    FPage: TCustomRibbonPage;
    FCaption: string;
    FModified: Boolean;
    FBestTabWidth: Integer;
    FMinTabWidth: Integer;
    FMinTruncatedWidth: Integer;
    FKeyTip: string;
    FKeyTipForm: TCustomControl;
    function GetBestTabWidth: Integer;
    function GetMinTabWidth: Integer;
    procedure RecalculateTabItemMetrics;
    procedure SetCaption(const Value: string);
    procedure SetPage(const Value: TCustomRibbonPage);
    function GetKeyTip: string;
    procedure SetKeyTip(const Value: string);
  protected
    function GetDisplayName: string; override;
  public
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
    property X: Integer read FX write FX;
    property Y: Integer read FY write FY;
    // Optimal display width for a tab. Won't grow bigger than this.
    property BestTabWidth: Integer read GetBestTabWidth;
    // Tab width at which it can display without separator bars
    property MinTabwidth: Integer read GetMinTabWidth;
    // Smallest a tab can be compressed before scrolling comes into effect.
    // Cannot be made any smaller than this.
    property MinTruncatedWidth: Integer read FMinTruncatedWidth;
    property Modified: Boolean read FModified write FModified;
    property KeyTipForm: TCustomControl read FKeyTipForm write FKeyTipForm;
  published
    property Caption: string read FCaption write SetCaption;
    property KeyTip: string read GetKeyTip write SetKeyTip;
    property Page: TCustomRibbonPage read FPage write SetPage;
  end;

  TRibbonTabs = class(TOwnedCollection)
  private
    FDesignerAdd: Boolean;
    function GetItem(Index: Integer): TRibbonTabItem;
    procedure SetItem(Index: Integer; const Value: TRibbonTabItem);
    function GetRibbon: TCustomRibbon;
    procedure CreatePageForItem(AItem: TRibbonTabItem);
  protected
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
    function Add: TRibbonTabItem;
    function FindGroup(const GroupName: string): TControl;
    function GetPageFromPageCaption(const Caption: string): TCustomRibbonPage;
    function IndexOfCaption(const Caption: string): Integer;
    function TabExists(const Caption: string): Boolean;
    function SelectNext: Boolean;
    function SelectPrior: Boolean;
    property DesignerAdd: Boolean read FDesignerAdd write FDesignerAdd;
    property Ribbon: TCustomRibbon read GetRibbon;
    property Items[Index: Integer]: TRibbonTabItem read GetItem write SetItem; default;
  end;

  // TRibbonPage holds the groups of controls that are displayed.
  TCustomRibbonPage = class(TCustomControl)
  public
    const
      cRibbonGroupLeftOffset = 4;
      cRibbonGroupSpacing = 2;
  private
    FGroups: TList;
    FIndex: Integer;
    FKeyTip: string;
    FRibbon: TCustomRibbon;
    FGroupOffset: Integer;
    FScrollLeft: TRibbonGroupScrollButton;
    FScrollRight: TRibbonGroupScrollButton;
    FCollapsedGroups: TStack;
    procedure SetIndex(const Value: Integer);
    procedure SetRibbon(const Value: TCustomRibbon);
    function GetGroup(Index: Integer): TCustomRibbonGroup;
    function GetGroupCount: Integer;
    procedure SetGroupOffset(const Value: Integer);
    procedure ScrollButtonClickHandler(Sender: TObject);
    function GetGroupWidth: Integer;
    function GetCollapseGroupCount: Integer;
  protected
    procedure CMControlListChanging(var Message: TCMControlListChanging);
      message CM_CONTROLLISTCHANGING;
    procedure CMTextchanged(var Message: TMessage); message CM_TEXTCHANGED;
    function CreateScrollButton(const Direction: TScrollDirection):
      TRibbonGroupScrollButton; virtual;
    procedure DoScrollButtonClick(const Direction: TScrollDirection); virtual;
    function GetPageHeight: Integer;
    function GetPageTop: Integer;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure RequestAlign; override;
    procedure Resize; override;
    procedure SetParent(AParent: TWinControl); override;
    procedure UpdateScrollButtons;
    property GroupOffset: Integer read FGroupOffset write SetGroupOffset;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AlignGroups;
    procedure AddGroup(const Group: TCustomRibbonGroup);
    procedure CollapseGroup(const Group: TCustomRibbonGroup);
    function FindGroup(const GroupCaption: string): TControl;
    function FindGroupAt(const Pt: TPoint): TCustomRibbonGroup;
    function GetGroupPos(Ignore: TControl): Integer;
    function GetNextVisibleGroup: TCustomRibbonGroup;
    procedure HandleKeyTips(const KeyTip: string; var KeyTips: TKeyTipList);
    procedure HideKeyTips(KeyTips: TKeyTipList);
    procedure Invalidate; override;
    function RibbonStyle: TRibbonStyleActionBars;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    procedure ShowKeyTips;
    procedure UpdateActionManager(Value: TCustomActionManager);
    property CollapseGroupCount: Integer read GetCollapseGroupCount;
    property GroupCount: Integer read GetGroupCount;
    property Groups[Index: Integer]: TCustomRibbonGroup read GetGroup;
    property Index: Integer read FIndex write SetIndex;
    property KeyTip: string read FKeyTip write FKeyTip;
    property Ribbon: TCustomRibbon read FRibbon write SetRibbon;
  end;

  TRibbonPage = class(TCustomRibbonPage)
  published
    property BiDiMode;
    property Caption;
    property Height;
    property Index;
    property KeyTip;
    property Name;
    property ParentBiDiMode;
  end;

  TOffice2007Button = class(TGraphicControl)
  private
    FImage: TBitmap;
    FMouseInControl: Boolean;
    FOnClick: TNotifyEvent;
    procedure SetMouseInControl(const Value: Boolean);
  protected
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure DoClick; virtual;
    procedure DrawBackground; virtual;
    procedure DrawImage; virtual;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    function GetRibbonStyle : TRibbonStyleActionBars;
    property MouseInControl: Boolean read FMouseInControl write SetMouseInControl;
    property RibbonStyle: TRibbonStyleActionBars read GetRibbonStyle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TRibbonSystemButton = class(TOffice2007Button)
  private
    type
      TSystemMenuButton = (smbNone, smbMinimize, smbRestore, smbHelp, smbClose);
  private
      FSystemMenuButton : TSystemMenuButton;
  protected
    procedure DoClick; override;
    procedure DrawBackground; override;
    procedure DrawImage; override;
  public
    constructor Create(AOwner: TComponent; sysButton : TSystemMenuButton); reintroduce;
    property SystemMenuButton : TSystemMenuButton read FSystemMenuButton write FSystemMenuButton;
  end;

  // Button used for activating help
  THelpButton = class(TOffice2007Button)
  protected
    procedure DrawImage; override;
  end;

  // The types of items that will be displayed in the right pane of the Application Menu.
  // ctRecent - The right pane will contain a recent list of used documents by the application.
  //   Recent items are automatically prefixed with a number accelerator key for quick use.
  // ctCommands - The right pane will contain a list of commands for use by the application.
  TCommandType = (ctRecent, ctCommands);
  TIconSize = (isSmall, isMedium, isLarge);

  TApplicationMenu = class(TPersistent)
  private
    FCaption: string;
    FIcon: TIcon;
    FIconSize: TIconSize;
    FMenu: TRibbonApplicationMenuBar;
    FRibbon: TCustomRibbon;
    FScreenTipPopup: TScreenTipsPopup;
    FCommandType: TCommandType;
    procedure SetIcon(const Value: TIcon);
    procedure SetMenu(const Value: TRibbonApplicationMenuBar);
    function IsCaptionStored: Boolean;
    procedure SetCaption(const Value: string);
    function GetKeyTip: string;
    procedure SetKeyTip(const Value: string);
    function GetScreenTipItem: TScreenTipItem;
    procedure SetScreenTip(const Value: TScreenTipItem);
    procedure MenuControlCreated(Sender: TObject; var Control: TCustomActionControl);
    function IsKeyTipStored: Boolean;
    procedure SetCommandType(const Value: TCommandType);
    procedure SetIconSize(const Value: TIconSize);
  protected
    function GetActionClientItem: TActionClientItem;
    procedure Initialize(AManager: TCustomScreenTipsManager);
  public
    constructor Create(ARibbon: TCustomRibbon); reintroduce;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Show(const Visible: Boolean);
  published
    // The text displayed above the right panel in the Application Menu
    property Caption: string read FCaption write SetCaption stored IsCaptionStored;
    property CommandType: TCommandType read FCommandType write SetCommandType default ctRecent;
    // Icon to display on the Application Button.
    //
    // If not icon is assigned then the default applications icon is used. The
    // dimensions of the assigned icon is 24 x 24.
    property Icon: TIcon read FIcon write SetIcon;
    property IconSize: TIconSize read FIconSize write SetIconSize default isMedium;
    // The KeyTip that is displayed when the user has entered KeyTip mode.
    property KeyTip: string read GetKeyTip write SetKeyTip stored IsKeyTipStored;
    property Menu: TRibbonApplicationMenuBar read FMenu write SetMenu;
    property ScreenTip: TScreenTipItem read GetScreenTipItem write SetScreenTip;
  end;

  // state of the separators that are displayed between tabs as the
  // ribbon is being resized smaller
  TTabSeparatorState = (tssHidden, tssLight, tssMedium, tssDark);
  TTabActiveScrollButton = (asbNone, asbRight, asbLeft);
  TRibbonScrollButton = (tsbTabRight, tsbTabLeft, tsbGroupLeft, tsbGroupRight);
  TRibbonScrollButtons = set of TRibbonScrollButton;

  // A class that encapsulates all the functions and statuses needed to
  // manage scrolling of tabs and the selected group, on a ribbon.
  TCustomTabData = class
  private
    type
      TDeltaWidthDirection = (dwNarrower, dwWider);
      TItemData = class
      public
        Tab: TRibbonTabItem;
        TabIndex: Integer;
        BestWidth: Integer;
        Left: integer;
        MinWidth: Integer;
        NewWidth: Integer;
        MinTruncWidth: Integer;
      end;
  private
    FItems: TObjectList;
    FAvailableSpace: Integer;
    FCalculationDone: Boolean;
    FTabSeparatorState: TTabSeparatorState;
    FScrollButtons: TRibbonScrollButtons;
    FFirstVisibleTabIndex: Integer;
    FLeftTabScrollButtonRect: TRect;
    FRightTabScrollButtonRect: TRect;
    FOwner: TCustomRibbon;
    FTabUpdateRect: TRect;
    FLastPageWidth: Integer;
    FLastActivePage: TCustomRibbonPage;
    FLastVisibleTabIndex: Integer;
    function GetNewWidth(Idx: Integer): Integer;
    function GetBestWidth(Idx: Integer): Integer;
    function ReCalculateTabWidths: Boolean;
    function GetItemCount: Integer;
    function GetItemByIndex(Idx: Integer): TItemData;
  	procedure SetFirstVisibleTabIndex(const Value: integer);
  	procedure ResizeActiveRibbonGroup;
    function GetSeparatorOpacity: Byte;
  public
    constructor Create(AOwner: TCustomRibbon); reintroduce; virtual;
    destructor Destroy; override;
    procedure Add(ATab: TRibbonTabItem);
    procedure CalculateTabWidths(AAvailableSpace: Integer; APages: TRibbonTabs);
    procedure Clear;
    property FirstVisibleTabIndex: Integer read FFirstVisibleTabIndex write SetFirstVisibleTabIndex;
    property LastVisibleTabIndex: Integer read FLastVisibleTabIndex;
    property FullWidth[Idx: Integer]: Integer read GetBestWidth;
    property ItemCount: Integer read GetItemCount;
    property NewWidth[Idx: Integer]: Integer read GetNewWidth;
    property AvailableSpace: Integer read FAvailableSpace;
    property TabSeparatorState: TTabSeparatorState read FTabSeparatorState;
    property ScrollButtons: TRibbonScrollButtons read FScrollButtons;
    property LeftTabScrollButtonRect: TRect read FLeftTabScrollButtonRect;
    property RightTabScrollButtonRect: TRect read FRightTabScrollButtonRect;
    property SeparatorOpacity: Byte read GetSeparatorOpacity;
    property TabUpdateRect: TRect read FTabUpdateRect;
    property Owner: TCustomRibbon read FOwner;
  end;

  // Class used to display Quick Access Toolbar commands that display an entire
  // Ribbon group when clicked.
  TQuickAccessToolbarGroupItem = class
  private
    FGroup: TCustomRibbonGroup;
    FAction: TAction;
    function GetCaption: string;
  public
    constructor Create(ActionList: TActionList; AGroup: TCustomRibbonGroup); reintroduce;
    destructor Destroy; override;
    property Action: TAction read FAction;
    property Caption: string read GetCaption;
    property Group: TCustomRibbonGroup read FGroup;
  end;

  TQuickAccessToolbarGroups = class
  private
    FActionList: TActionList;
    FList: TStringList;
  public
    constructor Create(Images: TCustomImageList); virtual;
    destructor Destroy; override;
    function Add(AGroup: TCustomRibbonGroup): TQuickAccessToolbarGroupItem;
    procedure Clean;
    function Exists(const ACaption: string): Boolean;
    function Group(const ACaption: string): TCustomRibbonGroup;
    procedure Remove(const ACaption: string);
  end;

  TRibbonMetric = (rmCaption, rmHeight, rmFullHeight, rmMinHeight, rmTabTop,
    rmPageHeight, rmGroupHeight, rmGroupCaptionHeight, rmQATWidth, rmSystemButtonHeight,
    rmSystemButtonWidth, rmTabHeight, rmFontSize, rmFormBorder);
  TRecentItemClickEvent = procedure(Sender: TObject; FileName: string; Index: Integer) of object;

  TCustomRibbon = class(TCustomControl)
  public
    type
      TTabChangeEvent = procedure (Sender: TObject; const NewIndex, OldIndex: Integer;
        var AllowChange: Boolean) of object;
    const
      cRibbonHideWidth = 300; // the parent width at which the Ribbon must automatically hide
      cRibbonHideHeight = 250; // the parent height at which the Ribbon must automatically hide
      cRibbonQuickAccessToolbarLeft = 34; // left position of the quick access toolbar
      cRibbonHeight = 117; // default height of the ribbon
      cRibbonQATHeight = 26; // height of the bottom aligned QAT bar
      cRibbonUnthemedCaptionHeight = 30; // the height of the caption section of the ribbon
      cRibbonFirstTabOffSet = 47; // the position of the first tab that is displayed
      cRibbonTabSpacing = 6; // amount of spacing between tabs
      cRibbonTabHeight = 23; // the height of the tabs
      cRibbonMinimizedHeight = 27; // minimized height of the ribbon
      cRibbonTabScrollButtonWidth = 12; // width of the scroll button
      cRibbonGroupCaptionHeight = 16; // height of the ribbon group caption
      cRibbonGroupHeight = 86; // height of the ribbon group
      cRibbonPageHeight = 93; // height of the ribbon page
      cRibbonMinimumCaptionWidth = 50; // The minimum width the caption must be
      UM_DISPLAYKEYTIPS = WM_USER + 1; // Message sent to display the KeyTips
      UM_CHECKSIZE = WM_USER + 2; // Message sent after a WMWindowPosChanged message
  private
    type
      TContextMenuOption = (cmoShowAdd, cmoShowRemove, cmoQAT, cmoRibbon);
      TContextMenuOptions = set of TContextMenuOption;
  private
    FCloseButton : TRibbonSystemButton;
    FRestoreButton : TRibbonSystemButton;
    FMinimizeButton : TRibbonSystemButton;

    FTabs: TRibbonTabs;
    FMouseInControl: Boolean;
    FTabIndex: Integer;
    FOnTabChange: TTabChangeEvent;
    FUpdateCount: Integer;
    FHotTabIndex: Integer;
    FShowHelpButton: Boolean;
    FHelpButton: THelpButton;
    FOnHelpButtonClick: TNotifyEvent;
    FActionManager: TCustomActionManager;
    FColorMap: TCustomActionBarColorMap;
    FDefaultColorMap: TCustomActionBarColorMap;
    FDocumentName: string;
    FMinimized: Boolean;
    FQuickAccessToolbar: TQuickAccessToolbar;
    FApplicationMenu: TApplicationMenu;
    FIgnoreTabChange: Boolean;
    FHeaderRect: TRect;
    FParentForm: TCustomForm;
    FParentWndProc: TWndMethod;
    FActive: Boolean;
    FTabData: TCustomTabData;
    FContextCtrl: TCustomActionControl;
    FContextGroup: TCustomRibbonGroup;
    FContextAction: TContainedAction;
    FContextMenu: TPopupActionBar;
    FContextMenuOptions: TContextMenuOptions;
    FUseCustomFrame: Boolean;
    FShowStyleWarning: Boolean;
    FOnRightTabScrollButtonClick: TNotifyEvent;
    FOnLeftTabScrollButtonClick: TNotifyEvent;
    FKeyTipsVisible: Boolean;
    FScreenTips: TCustomScreenTipsManager;
    FClickPending: array[TRibbonScrollButton] of Boolean;
    FTabDataInitialised: Boolean;
    FQuickAccessToolbarGroups: TQuickAccessToolbarGroups;
    FAllowKeyboardNavigation: Boolean;
    FHideTabs: Boolean;
    FCaptionHeight: Integer;
    FHideRibbon: Boolean;
    FRecentActions: TObjectList;
    FOnRecentItemClick: TRecentItemClickEvent;
    FLastActiveControl: TWinControl;
    FScaleFactor: Single;
    FCurrentStyle: TRibbonStyleActionBars;
    procedure CleanupQuickAccessToolbarGroups;
    procedure SetTabs(const Value: TRibbonTabs);
    procedure SetKeyTipsVisible(const Value: Boolean);
    function GetTabIndex: Integer;
    procedure SetTabIndex(const Value: Integer);
    procedure CheckTabChange(X, Y: Integer);
    procedure SetHotTabIndex(const Value: Integer);
    procedure SetActivePage(const Value: TCustomRibbonPage);
    function GetActivePage: TCustomRibbonPage;
    procedure SetShowHelpButton(const Value: Boolean);
    procedure HelpButtonClickHandler(Sender: TObject);
    procedure SetActionManager(const Value: TCustomActionManager);
    function GetColorMap: TCustomActionBarColorMap;
    procedure SetColorMap(const Value: TCustomActionBarColorMap);
    function SetupDefaultColorMap: TCustomActionBarColorMap;
    procedure FixUpPageIndexes;
    procedure FixUpTabList(APage: TCustomRibbonPage);
    procedure SetDocumentName(const Value: string);
    procedure SetMinimized(const Value: Boolean);
    procedure SetQuickAccessToolbar(const Value: TQuickAccessToolbar);
    procedure QuickAccessToolbarPropsChangeHandler(Sender: TObject);
    procedure SetActive(const Value: Boolean);
    procedure AddToQuickAccessToolbarHandler(Sender: TObject);
    procedure CustomizeQuickAccessToolbarHandler(Sender: TObject);
    procedure ChangeQuickAccessToolbarPositionHandler(Sender: TObject);
    procedure MinimizeRibbonHandler(Sender: TObject);
    procedure SetUseCustomFrame(const Value: Boolean);
    procedure SetApplicationMenu(const Value: TApplicationMenu);
    procedure HideKeyTips;
    procedure CheckAndResetMinimizedState;
    function DrawScrollButtons: Boolean;
    function FindActionManager: TCustomActionManager;
    function IsTabsStored: Boolean;
    function TestTabScrollButtonClick(Shift: TShiftState): Boolean;
    function GetActiveScrollButton: TTabActiveScrollButton;
    function GetApplicationButton: TCustomActionControl;
    procedure SetScreenTips(const Value: TCustomScreenTipsManager);
    procedure SetAllowKeyboardNavigation(const Value: Boolean);
    procedure SetHideTabs(const Value: Boolean);
    function GetCaptionHeight: Integer;
    procedure SetHideRibbon(const Value: Boolean);
    procedure ShowSystemMenu(const LPt: TPoint);
    procedure RecentActionHandler(Sender: TObject);
    procedure InitializeSystemMenu;
    procedure FinalizeSystemMenu;
    function GetStyle: TRibbonStyleActionBars;
    procedure ReadStyleProp(Reader: TReader);
    procedure WriteStyleProp(Writer: TWriter);
    procedure SetStyle(const Value: TRibbonStyleActionBars);
    procedure CallParentWndProc(var Message: TMessage);
    procedure DrawCustomFrame;
    function IsDesigning: Boolean;
    function GetMenu: TRibbonApplicationMenuBar; inline;
  protected
    procedure CMBidimodechanged(var Message: TMessage);
      message CM_BIDIMODECHANGED;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMTextchanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontchanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMStyleChanged(var Message: TMessage); message CM_STYLECHANGED;
    procedure ContextMenuPopupHandler(Sender: TObject); virtual;
    procedure CreateContextMenu; virtual;
    procedure CustomFrameWndProc(var Message: TMessage); virtual;
    procedure DblClick; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DisplayKeyTips(const State: TKeyTipState); virtual;
    procedure DoAddToQuickAccessToolbar; virtual;
    procedure DoChangeQuickAccessToolbarPosition; virtual;
    procedure DoCustomizeQuickAccessToolbar; virtual;
    procedure DoGroupStyleChanged; virtual;
    procedure DoHelpButtonClick; virtual;
    procedure DoMinimizeRibbon; virtual;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure DoRecentItemClick(const FileName: string; const Index: Integer); virtual;
    procedure DoScrollTabsLeft; virtual;
    procedure DoScrollTabsRight; virtual;
    procedure DrawCaption; virtual;
    procedure DrawQuickAccessToolbar; virtual;
    procedure DrawSystemButtons;
    procedure DrawTab(const Index: Integer); virtual;
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); override;
    procedure DoTabChange(const NewIndex, OldIndex: Integer; var AllowChange: Boolean); virtual;
    function GetContextMenuOptions: TContextMenuOptions; inline;
    function GetHelpButtonRect: TRect; virtual;
    function GetRibbonHeight: Integer; inline;
    function GetTabAt(const X, Y: Integer): Integer; virtual;
    function GetTabRect(const Index: Integer): TRect; virtual;
    function GetTabWidth(const Index: Integer): Integer; virtual;
    function HasApplicationMenu: Boolean; inline;
    function HasQuickAccessToolbar: Boolean; inline;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure RebuildRibbonMetrics;
    procedure Resize; override;
    procedure SetParent(AParent: TWinControl); override;
    procedure UpdateQATPosition;
    procedure Idle(const Msg: TMsg);
    procedure UMDisplayKeyTips(var Message: TMessage); message UM_DISPLAYKEYTIPS;
    function ValidTab(const Index: Integer): Boolean;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMSettingChange(var Message: TWMSettingChange);
      message WM_SETTINGCHANGE;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged);
      message WM_WINDOWPOSCHANGED;
    procedure UMCheckResize(var Message: TMessage); message UM_CHECKSIZE;
    property AllowKeyboardNavigation: Boolean read FAllowKeyboardNavigation
      write SetAllowKeyboardNavigation;
    property HotTabIndex: Integer read FHotTabIndex write SetHotTabIndex;
    property KeyTipsVisible: Boolean read FKeyTipsVisible write SetKeyTipsVisible;
    property OnRightTabScrollButtonClick: TNotifyEvent read FOnRightTabScrollButtonClick
      write FOnRightTabScrollButtonClick;
    property OnLeftTabScrollButtonClick: TNotifyEvent read FOnLeftTabScrollButtonClick
      write FOnLeftTabScrollButtonClick;
    property HideRibbon: Boolean read FHideRibbon write SetHideRibbon;
    property Menu: TRibbonApplicationMenuBar read GetMenu;
    property ScaleFactor: Single read FScaleFactor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateParams(var Params: TCreateParams); override;
    function AddTab(const APage: TCustomRibbonPage): TRibbonTabItem;
    function AddRecentItem(const FileName: string): Integer;
    function RemoveRecentItem(const FileName: string): Boolean;
    procedure BeginUpdate;
    procedure CheckRibbonSize;
    procedure ClearRecentItems;
    function CustomFrameSupported: Boolean;
    function GlassFrameSupported: Boolean;
    procedure EndUpdate;
    procedure DeleteTab(const Index: Integer);
    function DoMouseWheelEx(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
    function GetRibbonMetric(const Metric: TRibbonMetric): Integer;
    procedure InvalidateHeaderArea;
    procedure InvalidateTabArea;
    procedure InvalidateScrollButtons;
    procedure MoveGroup(const GroupName, PageName: string);
    procedure RemoveTab(const ACaption: string);
    procedure RemoveAllTabs;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    function GetIcon(out IconSize: TIconSize): TIcon; virtual;
    procedure TabHandledKeyTips(const KeyTip: string; var KeyTips: TKeyTipList);
    procedure TabHideKeyTips(const KeyTip: string; KeyTips: TKeyTipList);
    procedure TabShowKeyTips;
    property ActionManager: TCustomActionManager read FActionManager write SetActionManager;
    property Active: Boolean read FActive write SetActive;
    property ActivePage: TCustomRibbonPage read GetActivePage write SetActivePage;
    property ApplicationMenu: TApplicationMenu read FApplicationMenu write SetApplicationMenu;
    // Font used to draw the Ribbon Caption
    property ColorMap: TCustomActionBarColorMap read GetColorMap write SetColorMap;
    // The DocumentName appears in the Ribbon caption
    property DocumentName: string read FDocumentName write SetDocumentName;
    // Shows or Hides the Tab portion of the Ribbon
    //
    // When HideTabs is True the user cannot access any of the Tabs on the Ribbon.
    property HideTabs: Boolean read FHideTabs write SetHideTabs default False;
    // Shows the Ribbon in a minimized state where tabs can be selected, but are
    // not visible.
    //
    // When Minimized is True, Tabs still function. You can access the tabs by
    // selecting the required Tab with the mouse, or switching to your desired
    // tab by using tab allocated KeyTips.
    property Minimized: Boolean read FMinimized write SetMinimized;
    property Tabs: TRibbonTabs read FTabs write SetTabs stored IsTabsStored;
    property QuickAccessToolbar: TQuickAccessToolbar read FQuickAccessToolbar write SetQuickAccessToolbar;
    property ScreenTips: TCustomScreenTipsManager read FScreenTips write SetScreenTips;
    property ShowHelpButton: Boolean read FShowHelpButton write SetShowHelpButton default True;
    property Style: TRibbonStyleActionBars read GetStyle write SetStyle;
    property TabIndex: Integer read GetTabIndex write SetTabIndex default 0;
    property UseCustomFrame: Boolean read FUseCustomFrame write SetUseCustomFrame default True;
    property OnHelpButtonClick: TNotifyEvent read FOnHelpButtonClick write FOnHelpBUttonClick;
    property OnRecentItemClick: TRecentItemClickEvent read FOnRecentItemClick write FOnRecentItemClick;
    property OnTabChange: TTabChangeEvent read FOnTabChange write FOnTabChange;
  end;

  TCustomRibbonClass = class of TCustomRibbon;

  TRibbon = class(TCustomRibbon)
  published
    property ActionManager;
    property ScreenTips;
    property Align default alTop;
    property Anchors;
    property ApplicationMenu;
    property BiDiMode;
    property Caption;
    property DocumentName;
    property Enabled;
    property Font;
    property Height default TCustomRibbon.cRibbonHeight;
    property HideTabs;
    property ParentBiDiMode;
    property ParentFont;
    property QuickAccessToolbar;
    property ShowHelpButton;
    property Style;
    property Tabs;
    // Tab Index must be streamed after the Tabs collection
    property TabIndex;
    property UseCustomFrame;
    property OnHelpButtonClick;
    property OnRecentItemClick;
    property OnTabChange;
  end;

implementation

uses
{$IF DEFINED(CLR)}
  System.Runtime.InteropServices, WinUtils, System.Threading, Variants,
{$ENDIF}
  Vcl.Dialogs, System.Math, Vcl.Themes, Vcl.RibbonConsts, Vcl.RibbonLunaStyleActnCtrls, Winapi.Imm, System.TypInfo,
  Winapi.DwmApi, Winapi.UxTheme;

// Implementation of Mouse Wheel hook used by the Ribbon to move active
// page by using the Mouse Wheel
var
  FHookHandle: THandle;

{$IF DEFINED(CLR)}
function RibbonMouseWheelHook(Code: Integer; wparam: WPARAM; lparam: LPARAM): LRESULT;
{$ELSE}
function RibbonMouseWheelHook(Code: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
{$ENDIF}
var
  LCtrl: TWinControl;
  LStruct: {$IFNDEF CLR}PMouseHookStructEx{$ELSE}TMouseHookStructEx{$ENDIF};
  LKeyState: TKeyboardState;
begin
  if Code < 0 then
  begin
    Result := CallNextHookEx(FHookHandle, Code, wParam, lParam);
    Exit;
  end;
  if wParam = WM_MOUSEWHEEL then
  begin
    {$IF DEFINED(CLR)}
    LStruct := TMouseHookStructEx(Marshal.PtrToStructure(IntPtr(lparam), TypeOf(TMouseHookStructEx)));
    {$ELSE}
    LStruct := PMouseHookStructEx(lParam);
    {$ENDIF}
    LCtrl := FindControl(WindowFromPoint(LStruct.MouseHookStruct.pt));
    if (LCtrl is TRibbonGroup) or (LCtrl is TCustomRibbonPage) then
    begin
      while (LCtrl <> nil) and not (LCtrl is TCustomRibbon) do
        LCtrl := LCtrl.Parent;
    end;
    if (LCtrl is TCustomRibbon) and not TCustomRibbon(LCtrl).Minimized then
    begin
      GetKeyboardState(LKeyState);
      TCustomRibbon(LCtrl).DoMouseWheelEx(Vcl.Forms.KeyboardStateToShiftState(LKeyState),
        ShortInt(LStruct.mouseData shr 16), Point(0, 0));
      Result := 1;
    end
    else
      Result := CallNextHookEx(FHookHandle, Code, wParam, lParam);
  end
  else
    Result := CallNextHookEx(FHookHandle, Code, wParam, lParam);
end;

procedure CreateMouseWheelHook;
begin
  // Remove any existing mouse wheel hook
  if FHookHandle <> 0 then
    UnhookWindowsHookEx(FHookHandle);
  FHookHandle := SetWindowsHookEx(WH_MOUSE, {$IFNDEF CLR}@{$ENDIF}RibbonMouseWheelHook,
    0, GetCurrentThreadId);
end;

procedure DestroyMouseWheelHook;
begin
  if FHookHandle <> 0 then
    UnhookWindowsHookEx(FHookHandle);
end;

type
  TRibbonGallery = class(TControl)
  end;

{$IFNDEF CLR}

function CanAddControl(Control: TControl): Boolean;
begin
  Result := (Control.ComponentState * [csReading, csLoading] = []) and
    (csDesigning in Control.ComponentState);
end;

procedure TCustomActionControlBar.CMControlChange(var Message: TCMControlChange);
var
  LCtrl: TControl;
  LAC: TActionClientItem;
  I: Integer;
  LIntf: IRibbonContainedControl;
begin
  if (ActionManager = nil) then
    Exit;
  try
    if not FCreatingControls and CanAddControl(Self) then
    begin
      LCtrl := Message.Control;
      if LCtrl.InheritsFrom(TCustomActionControl) then
        Exit;
      if Message.Inserting then
      begin
        if (ActionClient <> nil) and ActionClient.HasItems then
        begin
          // check to see if the control is already assigned to an AC on the bar
          for I := 0 to ActionClient.Items.Count - 1 do
          begin
            if TControlProperties(ActionClient.Items[I].CommandProperties).ContainedControl = LCtrl then
              Exit;
          end;
        end;
        FAddingContainedControl := True;
        try
          if Items = nil then
          begin
            ActionClient := ActionManager.ActionBars.Add;
            ActionClient.ActionBar := Self;
          end;
          LAC := Items.Add as TActionClientItem;
          if LCtrl is TRibbonComboBox then
          begin
            LAC.CommandStyle := csComboBox;
            LAC.Caption := LCtrl.Name;
            TControlProperties(LAC.CommandProperties).Width := 150;
            TControlProperties(LAC.CommandProperties).ContainedControl := LCtrl;
            // Recreate the control so that the appearance of the control is correct
            CreateControl(LAC);
          end
          else if LCtrl is TRibbonGallery then
          begin
            LAC.CommandStyle := csGallery;
            TControlProperties(LAC.CommandProperties).Width := 233;
            TGalleryProperties(LAC.CommandProperties).GalleryType := gtRibbon;
          end
          else
          begin
            LAC.Caption := LCtrl.Name;
            LAC.CommandStyle := csControl;
            if LCtrl.Height > 66 then
              LCtrl.Height := 66;
            TControlProperties(LAC.CommandProperties).Width := 150;
            TControlProperties(LAC.CommandProperties).ContainedControl := LCtrl;
            CreateControl(LAC);
          end;
          if Supports(LAC.Control, IRibbonContainedControl, LIntf) then
            LIntf.ContainedControl := LCtrl;
        finally
          FAddingContainedControl := False;
        end;
      end;
    end;
  finally
    inherited;
  end;
end;
{$ELSE}
procedure TCustomActionControlBar.ControlChange(Inserting: Boolean; Child: TControl); override;
var
  LAC: TActionClientItem;
  I: Integer;
  LIntf: IRibbonContainedControl;
begin
  if (ActionManager = nil) then
    Exit;
  try
    if not FCreatingControls and CanAddControl(Self) then
    begin
      LCtrl := Child;
      if LCtrl.InheritsFrom(TCustomActionControl) then
        Exit;
      if Inserting then
      begin
        if (ActionClient <> nil) and ActionClient.HasItems then
        begin
          // check to see if the control is already assigned to an AC on the bar
          for I := 0 to ActionClient.Items.Count - 1 do
          begin
            if TRibbonCustomControl(ActionClient.Items[I]).ContainedControl = LCtrl then
              Exit;
          end;
        end;
        FAddingContainedControl := True;
        try
          if Items = nil then
          begin
            ActionClient := ActionManager.ActionBars.Add;
            ActionClient.ActionBar := Self;
          end;
          LAC := Items.Add as TActionClientItem;
          if LCtrl is TRibbonComboBox then
          begin
            LAC.CommandStyle := csComboBox;
            TControlProperties(LAC.CommandProperties).Width := 80;
            TControlProperties(LAC.CommandProperties).ContainedControl := LCtrl;
          end
          else if LCtrl is TRibbonGallery then
          begin
            LAC.CommandStyle := csGallery;
            TGalleryProperties(LAC.CommandProperties).GalleryType := gtRibbon;
          end
          else
          begin
            LAC.Caption := SNewCommandCaption;
            LAC.CommandStyle := csControl;
            if LCtrl.Height > 66 then
              LCtrl.Height := 66;
            TControlProperties(LAC.CommandProperties).Width := 80;
            TControlProperties(LAC.CommandProperties).ContainedControl := LCtrl;
            LAC.Control.CalcBounds;
          end;
          if Supports(LAC.Control, IRibbonContainedControl, LIntf) then
            LIntf.ContainedControl := LCtrl;
        finally
          FAddingContainedControl := False;
        end;
      end;
    end;
  finally
    inherited;
  end;
end;
{$ENDIF}

{ TRibbonGroupCollapsedControl }

// Calculate the width that a button needs to be to display only two lines of
// text as a caption. DrawText doesn't support calculating the width of the
// display rect needed when DT_CALCRECT defined.
procedure GetButtonWidth(Canvas: TCanvas; const Str: string; var Rect: TRect);
var
  LCalcRect: TRect;
  LWidth: Integer; // Width of the button text without line breaks
  LHeight: Integer; // Height of the button text
  LWidthChar: Integer;
  LFlags: Cardinal;
begin
  LWidth := Canvas.TextWidth(Str);
  LHeight := Canvas.TextHeight(Str) * 2;
  LWidthChar := Canvas.TextWidth('_');
  if LWidth > 32 then
  begin
    LCalcRect := Rect;
    LFlags := DT_CALCRECT or DT_WORDBREAK;
    DrawText(Canvas.Handle, Str, -1, LCalcRect, LFlags);
    while LCalcRect.Bottom > LHeight do
    begin
      Inc(Rect.Right, LWidthChar);
      LCalcRect := Rect;
      DrawText(Canvas.Handle, Str, -1, LCalcRect, LFlags);
    end;
    Rect := LCalcRect;
    Inc(Rect.Right, LWidthChar);
  end
  else
    DrawText(Canvas.Handle, Str, -1, Rect, DT_CALCRECT);
end;

procedure TRibbonGroupCollapsedControl.AdjustBounds;
var
  LCanvas: TCanvas;
  LRect: TRect;
  LDC: HDC;
begin
  LCanvas := TCanvas.Create;
  try
    LDC := GetDC(0);
    try
      LCanvas.Handle := LDC;
      LCanvas.Font := Font;
      LRect := Rect(0, 0, 42, 0);
      GetButtonWidth(LCanvas, Caption, LRect);
      SetBounds(Left, Top, Max(LRect.Right - LRect.Left + 10, 42), Height);
      LCanvas.Handle := 0;
    finally
      ReleaseDC(0, LDC);
    end;
  finally
    LCanvas.Free;
  end;
end;

procedure TRibbonGroupCollapsedControl.Click;
var
  LPt: TPoint;
  LRect: TRect;
begin
  if (FGroup <> nil) and (FFloating = nil) then
  begin
    LPt := ClientToScreen(Point(0, Height));
    FGroup.Width := OldWidth;
    LRect := Rect(LPt.X, LPt.Y, LPt.X + FGroup.Width, LPt.Y + Group.GetGroupHeight);
    FFloating := TRibbonGroupDockForm.Create(Self);
    FFloating.Control := Self;
    SetWindowPos(FFloating.Handle, HWND_TOP, LPt.X, LPt.Y, FGroup.Width + 2,
      FGroup.Height + 5, SWP_NOACTIVATE or SWP_SHOWWINDOW);
    FGroup.Parent := FFloating;
    FGroup.Align := alClient;
    FFloating.Visible := True;
    FFloating.SetFocus;
    Invalidate;
  end;
end;

procedure TRibbonGroupCollapsedControl.CloseUp;
begin
  if FGroup <> nil then
    FGroup.Width := Width + 4;
  FFloating := nil;
  Invalidate;
end;

procedure TRibbonGroupCollapsedControl.CMFontchanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    AdjustBounds;
end;

procedure TRibbonGroupCollapsedControl.CMMouseenter(var Message: TMessage);
begin
  inherited;
  MouseInControl := True;
end;

procedure TRibbonGroupCollapsedControl.CMMouseleave(var Message: TMessage);
begin
  inherited;
  MouseInControl := False;
end;

procedure TRibbonGroupCollapsedControl.CMTextchanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
  begin
    AdjustBounds;
    Invalidate;
  end;
end;

constructor TRibbonGroupCollapsedControl.Create(AOwner: TComponent);
begin
  inherited;
  FImageIdx := -1;
end;

destructor TRibbonGroupCollapsedControl.Destroy;
begin
  FreeAndNil(FKeyTipForm);
  inherited;
end;

function TRibbonGroupCollapsedControl.GetKeyTip: string;
begin
  Result := FKeyTip;
end;

function TRibbonGroupCollapsedControl.GetParentControl: TWinControl;
begin
  Result := Parent;
end;

function TRibbonGroupCollapsedControl.GetTopPosition: Integer;
begin
  Result := 3;
end;

procedure TRibbonGroupCollapsedControl.HandleKeyTip(const KeyTip: string;
  var Handled: TKeyTipHandled);
begin
  TKeyTipValidator.Validate(KeyTip, GetKeyTip, Self, Handled);
end;

procedure TRibbonGroupCollapsedControl.HideKeyTip(const Match: string);
var
  LHandled: TKeyTipHandled;
begin
  HandleKeyTip(Match, LHandled);
  if LHandled = ktNone then
    FreeAndNil(FKeyTipForm);
end;

procedure TRibbonGroupCollapsedControl.KeyTipClick;
begin
  Click;
end;

procedure TRibbonGroupCollapsedControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent.Equals(FGroup) then
      FGroup := nil
    else if AComponent.Equals(FActionManager) then
      FActionManager := nil
    else if AComponent.Equals(FImageList) then
    begin
      FImageList := nil;
      FImageIdx := -1;
    end;
  end;
end;

procedure TRibbonGroupCollapsedControl.Paint;
var
  LPt: TPoint;
  LRect: TRect;
  LCalcRect: TRect;
  LStyle: TRibbonStyleActionBars;
  LFlags: Cardinal;
  LX: Integer;
  LY: Integer;
  LLineHeight: Integer;
  LMultiLine: Boolean;

  function IsDroppedDown: Boolean;
  begin
    Result := (FGroup <> nil) and (FGroup.Parent <> nil) and
      (FGroup.Parent.Equals(FFloating));
  end;

begin
  Canvas.Font.Assign(Font);
  if (FGroup <> nil) and (FGroup.ColorMap <> nil) then
    Canvas.Font.Color := FGroup.ColorMap.FontColor;
  LStyle := RibbonStyle;
  LRect := Rect(3, Height div 2, Width - 3, Height);
  LRect := Rect(Max(6, (Width div 2) - 16), 6, 0, 0);
  if IsDroppedDown then
  begin
    LStyle.DrawElement(srgMinimizeButtonPressed, Canvas, GetClientRect);
    LStyle.DrawElement(srgMinimizeButtonPressedIcon, Canvas, LRect);
  end
  else
  begin
    if MouseInControl then
      LStyle.DrawElement(srgMinimizeButtonHover, Canvas, GetClientRect)
    else
      LStyle.DrawElement(srgMinimizeButton, Canvas, GetClientRect);
    LStyle.DrawElement(srgMinimizeButtonIcon, Canvas, LRect);
  end;
  if (FImageList <> nil) and (FImageIdx > -1) then
    FImageList.Draw(Canvas, LRect.Left + 8, LRect.Top + 4, FImageIdx, True);
  LRect := Rect(3, Height div 2, Width - 3, Height);
  LCalcRect := Rect(3, 0, Width - 3, 0);
  Canvas.Brush.Style := bsClear;
  LFlags := DT_CENTER or DT_NOPREFIX or DT_WORDBREAK;
  DrawText(Canvas.Handle, Caption, -1, LCalcRect, LFlags or DT_CALCRECT);
  LLineHeight := Canvas.TextHeight(Caption);
  LMultiLine := LCalcRect.Bottom - LCalcRect.Top > LLineHeight;
  if LMultiLine then
    DrawText(Canvas.Handle, Caption + '  ', -1, LRect, LFlags)
  else
    DrawText(Canvas.Handle, Caption, -1, LRect, LFlags);
  // Draw the drop down arrow
  LX := (Width div 2) - 3;
  LY := (Height div 2) + LLineHeight;
  if LMultiLine then
    Inc(LX, (Width div 2) - 6);
  LPt := Point(LX, LY + 3);
  LStyle.DrawElement(sbLargeArrowDown, Canvas, Rect(LPt.X, LPt.Y, 0, 0));
end;

function TRibbonGroupCollapsedControl.RibbonStyle: TRibbonStyleActionBars;
begin
  if (FActionManager <> nil) and (FActionManager.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(FActionManager.Style)
  else
    Result := RibbonLunaStyle;
end;

procedure TRibbonGroupCollapsedControl.SetGroup(const Value: TCustomRibbonGroup);
begin
  if FGroup <> Value then
  begin
    if FGroup <> nil then
      FGroup.RemoveFreeNotification(Self);
    FGroup := Value;
    SetupGroupImage;
    if FGroup <> nil then
    begin
      Height := Group.GetGroupHeight;
      FGroup.FreeNotification(Self);
    end;
  end;
end;

procedure TRibbonGroupCollapsedControl.SetKeyTip(const Value: string);
begin
  FKeyTip := Value;
end;

procedure TRibbonGroupCollapsedControl.SetMouseInControl(const Value: Boolean);
begin
  if FMouseInControl <> Value then
  begin
    FMouseInControl := Value;
    Invalidate;
  end;
end;

// Look for a command on the group that has an image attached. The commands
// image is displayed inside the collapsed group. If required, all commands are
// checked until an image is found.
procedure TRibbonGroupCollapsedControl.SetupGroupImage;
var
  LActionList: TCustomActionList;
  LAction: TCustomAction;
  LCnt: Integer;
begin
  FImageList := nil;
  FImageIdx := -1;
  if (FGroup <> nil) and (FGroup.ControlCount > 0) then
  begin
    LCnt := 0;
    while (LCnt <= FGroup.ControlCount - 1) do
    begin
      // Grab the image from the first command on the associated group
      LAction := TCustomAction(FGroup.Controls[LCnt].Action);
      if LAction <> nil then
      begin
        LActionList := LAction.ActionList;
        if LActionList <> nil then
        begin
          FImageList := LActionList.Images;
          if FImageList <> nil then
          begin
            FImageIdx := LAction.ImageIndex;
            // Make sure the image is value
            if FImageList.Count < FImageIdx then
              FImageIdx := -1;
            if FImageIdx > -1 then
              Break;
          end;
        end;
      end;
      Inc(LCnt);
    end;
  end;
end;

procedure TRibbonGroupCollapsedControl.SetActionManager(const Value: TCustomActionManager);
begin
  FActionManager := Value;
end;

procedure TRibbonGroupCollapsedControl.ShowKeyTip(
  const Position: TKeyTipPosition);
begin
  FreeAndNil(FKeyTipForm);
  FKeyTipForm := Vcl.RibbonActnCtrls.ShowKeyTip(KeyTip, Enabled, Self, ktpGroupD);
end;

{ TCustomActionControlBar }

constructor TCustomActionControlBar.Create(AOwner: TComponent);
begin
  inherited;
  FCreatingControls := False;
  ControlStyle := ControlStyle + [csAcceptsControls];
end;

function TCustomActionControlBar.CreateControl(
  AnItem: TActionClientItem): TCustomActionControl;
var
  LControlProps: TControlProperties;
  LIntf: IRibbonContainedControl;
begin
  Result := inherited CreateControl(AnItem);
  if (AnItem <> nil) and (AnItem.CommandStyle in [Vcl.ActnMan.csControl, Vcl.ActnMan.csComboBox]) then
  begin
    LControlProps := (AnItem.CommandProperties as TControlProperties);
    if Supports(Result, IRibbonContainedControl, LIntf) then
    begin
      LIntf.ContainedControl := LControlProps.ContainedControl;
      AnItem.Control.CalcBounds;
    end;
  end;
end;

procedure TCustomActionControlBar.CreateControls;
var
  I: Integer;
  LAC: TActionClientItem;
  LIntf: IRibbonContainedControl;
begin
  FCreatingControls := True;
  inherited;
  FCreatingControls := False;
  if ActionManager <> nil then
  begin
    for I := 0 to Items.Count - 1 do
    begin
      LAC := TActionClientItem(Items[I]);
      if LAC.CommandStyle in [Vcl.ActnMan.csControl, Vcl.ActnMan.csComboBox] then
      begin
        if Supports(LAC.Control, IRibbonContainedControl, LIntf) then
        begin
          LIntf.ContainedControl := (LAC.CommandProperties as TControlProperties).ContainedControl;
          LAC.Control.CalcBounds;
        end;
      end;
    end;
  end;
end;

function TCustomActionControlBar.GetControlClass(
  AnItem: TActionClientItem): TCustomActionControlClass;
var
  LAC: TActionClientItem;
begin
  LAC := AnItem as TActionClientItem;
  if FAddingContainedControl then
  begin
    if LAC.CommandStyle = Vcl.ActnMan.csComboBox then
      Result := TRibbonComboControl
    else if (LAC.CommandStyle = Vcl.ActnMan.csControl) then
      Result := TRibbonCustomControl
    else
      Result := inherited GetControlClass(AnItem);
  end
  else if LAC.CommandStyle = csText then
    Result := TRibbonTextControl
  else
    Result := inherited GetControlClass(AnItem);
end;

{ TCustomRibbon }

procedure TCustomRibbon.DisplayKeyTips(const State: TKeyTipState);
var
  LIntf: IRibbonKeyTip;
  LBarIntf: IRibbonBarKeyTip;
  LKeyTipsDone: Boolean;
  LMsg: TMsg;
  LChr: Char;
  LSavedKeyTip: string; // Used when KeyTips have two keys associated to them
  LKeyTip: string;
  LKeyTips: TKeyTipList; // List of KeyTips that are still valid after user input
  LMatchItem: TKeyTipMatchItem;
  LEscapePressed: Boolean;
  LRefocusControl: Boolean;
  LIMMHandle: Integer;
  LCCIntf: IRibbonContainedControl;
  LLeaveFocus: Boolean;

  procedure HideKeyTips;
  begin
    if State = ktsTabs then
    begin
      if Supports(GetApplicationButton, IRibbonKeyTip, LIntf) then
        LIntf.HideKeyTip('');
      if Supports(QuickAccessToolbar.ActionBar, IRibbonBarKeyTip, LBarIntf) then
        LBarIntf.BarHideKeyTips(nil);
      TabHideKeyTips('', nil);
    end
    else
    begin
      if ActivePage <> nil then
        ActivePage.HideKeyTips(nil);
    end;
  end;

begin
  if not KeyTipsVisible and Minimized and (TabIndex > -1) and (State = ktsTabs) then
  begin
    TabIndex := -1;
    Exit;
  end;
  KeyTipsVisible := True;
  try
    LKeyTips := TKeyTipList.Create;
    try
      LIMMHandle := 0;
      LLeaveFocus := False;
      FLastActiveControl := FParentForm.ActiveControl;
      if FLastActiveControl <> nil then
      begin
        FLastActiveControl.FreeNotification(Self);
        LIMMHandle := ImmAssociateContext(FLastActiveControl.Handle, 0);
      end;
      LRefocusControl := True;
      try
        LEscapePressed := False;
        if State = ktsTabs then
        begin
          CheckAndResetMinimizedState;
          if Supports(GetApplicationButton, IRibbonKeyTip, LIntf) then
            LIntf.ShowKeyTip(ktpApplicationButton);
          if Supports(QuickAccessToolbar.ActionBar, IRibbonBarKeyTip, LBarIntf) then
            LBarIntf.BarShowKeyTips;
          if not HideTabs then
            TabShowKeyTips;
        end
        else
        begin
          ActivePage.ShowKeyTips;
        end;

        LKeyTipsDone := False;
        LSavedKeyTip := '';
        repeat
          if PeekMessage(LMsg, 0, 0, 0, PM_REMOVE) then
          begin
            case LMsg.message of
              WM_KEYFIRST..WM_KEYLAST:
                begin
                  if (LMsg.message = WM_SYSKEYDOWN) and (LMsg.wParam = VK_MENU) or
                    (LMsg.wParam = VK_ESCAPE) then
                  begin
                    if (LMsg.Message = WM_KEYUP) and (LMsg.wParam = VK_ESCAPE) then
                      Continue;
                    LEscapePressed := LMsg.wParam = VK_ESCAPE;
                    LKeyTipsDone := True;
                    // Pressing ALT should only cancel the display of KeyTips
                    if LMsg.wParam <> VK_MENU then
                    begin
                      TranslateMessage(LMsg);
                      DispatchMessage(LMsg);
                    end;
                  end
                  else
                  begin
                    if LMsg.Message = WM_KEYUP then
                      continue;
                    if (NativeInt(LMsg.wParam) in [Ord('0')..Ord('9'), Ord('A')..Ord('Z'),
                      VK_NUMPAD0..VK_NUMPAD9]) then
                    begin
                      LChr := Chr(LMsg.wParam);
                      if LSavedKeyTip <> '' then
                      begin
                        LKeyTip := LSavedKeyTip + LChr;
                        LKeyTips.Clear;
                      end
                      else
                        LKeyTip := LChr;
                      LKeyTips.Current := LKeyTip;
                      if State = ktsTabs then
                      begin
                        TabHandledKeyTips(LKeyTip, LKeyTips);
                      end
                      else
                      begin
                        if ActivePage <> nil then
                          ActivePage.HandleKeyTips(LKeyTip, LKeyTips);
                      end;
                      if LKeyTips.Full then
                        LKeyTipsDone := True
                      else
                      begin
                        // If there is more than one item in the list, then
                        // partial matches were made. Only allow Partial
                        // matches when the KeyTip is only one character
                        if LKeyTips.Partial and (Length(LKeyTip) = 1) then
                        begin
                          if State = ktsTabs then
                          begin
                            TabHideKeyTips(LKeyTip, LKeyTips);
                          end
                          else
                          begin
                            ActivePage.HideKeyTips(LKeyTips);
                          end;
                          LSavedKeyTip := LKeyTip;
                        end
                        else
                        begin
                          if Length(LKeyTip) = 2 then
                          begin
                            LKeyTip := LSavedKeyTip;
                          end;
                          Beep; // Invalid KeyTip has been pressed
                        end;
                      end;
                    end
                    else
                    begin
                      if (NativeInt(LMsg.wParam) in [VK_LEFT..VK_DOWN, VK_TAB]) then
                      begin
                        HideKeyTips;
                        case NativeInt(LMsg.wParam) of
                          VK_LEFT, VK_RIGHT:
                            begin
                              if NativeInt(LMsg.wParam) = VK_RIGHT then
                                Tabs.SelectNext
                              else
                                Tabs.SelectPrior;
                              AllowKeyboardNavigation := True;
                              LRefocusControl := False;
                            end;
                          else
                            LRefocusControl := True;
                        end;
                        LKeyTipsDone := True;
                        if LRefocusControl then
                        begin
                          TranslateMessage(LMsg);
                          DispatchMessage(LMsg);
                        end;
                      end
                      else
                      begin
                        LKeyTipsDone := True;
                        // Pressing F10 (like ALT) should only cancel the display of KeyTips
                        if LMsg.wParam <> VK_F10 then
                        begin
                          TranslateMessage(LMsg);
                          DispatchMessage(LMsg);
                        end;
                      end;
                    end;
                  end;
                end;
              WM_MOUSEFIRST + 1..WM_MOUSELAST,
              WM_NCLBUTTONDOWN..WM_NCXBUTTONDBLCLK,
              WM_CLOSE:
                begin
                  // Need to hide key tips before dispatching message
                  if LMsg.message in [WM_NCLBUTTONDOWN..WM_NCRBUTTONDOWN] then
                    HideKeyTips;
                  LKeyTipsDone := True;
                  TranslateMessage(LMsg);
                  DispatchMessage(LMsg);
                end;
              WM_QUIT:
                begin
                  LKeyTipsDone := False;
                  PostQuitMessage(LMsg.wParam);
                end;
            else
              TranslateMessage(LMsg);
              DispatchMessage(LMsg);
            end;
          end
          else
            Idle(LMsg);

        until LKeyTipsDone;

        HideKeyTips;
        // React to the selected KeyTip if one was selected
        if LKeyTips.Full then
        begin
          LMatchItem := LKeyTips[0];
          if LMatchItem.MatchType = mtApplicationMenu then
            TCustomMenuButton(LMatchItem.Control).Keyed
          else if LMatchItem.MatchType = mtControl then
          begin
            Supports(LMatchItem.Control, IRibbonContainedControl, LCCIntf);
            LRefocusControl := (LCCIntf = nil) or (LCCIntf.ContainedControl = nil);
            if not LRefocusControl then
              LLeaveFocus := True;
            if Supports(LMatchItem.Control, IRibbonKeyTip, LIntf) then
              LIntf.KeyTipClick
            else
              TCustomActionControl(LMatchItem.Control).Click;
          end
          else if LMatchItem.MatchType = mtCollapsed then
            TRibbonGroupCollapsedControl(LMatchItem.Control).Click
          else if LMatchItem.MatchType = mtTabs then
          begin
            TabIndex := LMatchItem.Index;
            if State = ktsTabs then
              PostMessage(Handle, UM_DISPLAYKEYTIPS, 0, ord(ktsControls));
            LRefocusControl := False;
            LLeaveFocus := True;
          end
          else if LMatchItem.MatchType = mtDialogButton then
            TRibbonGroup(LMatchItem.Control).DialogAction.Execute;
          if State = ktsControls then
            CheckAndResetMinimizedState;
        end;
        if LEscapePressed and (State = ktsControls) then
        begin
          CheckAndResetMinimizedState;
          PostMessage(Handle, UM_DISPLAYKEYTIPS, 0, ord(ktsTabs));
        end
        else if not (State = ktsTabs) then
          CheckAndResetMinimizedState;
      finally
        if LRefocusControl then
        begin
          FParentForm.ActiveControl := FLastActiveControl;
          if FLastActiveControl <> nil then
            FLastActiveControl.RemoveFreeNotification(Self);
        end
        else if not LLeaveFocus then
          Winapi.Windows.SetFocus(Handle);
        if (FLastActiveControl <> nil) and (LIMMHandle <> 0) then
          ImmAssociateContext(FLastActiveControl.Handle, LIMMHandle);
        FLastActiveControl := nil;
      end;
    finally
      LKeyTips.Free;
    end;
  finally
    KeyTipsVisible := False;
  end;
end;

// Call this method to add a new entry into the Recent Items list to the right
// of the Application Menu. The new entry is automatically added to the top
// of the Recent items list and if an entry with the same filename already
// exists, it is deleted.
//
// This method should only be called when the command type for the application
// menu is set to ctRecent.
function TCustomRibbon.AddRecentItem(const FileName: string): Integer;
var
  LItems: TOptionItems;
  LItem: TOptionItem;
  LAction: TAction;
  I: Integer;
  LIdx: Integer;
begin
  if HasApplicationMenu and (ApplicationMenu.CommandType = ctRecent) then
  begin
    LItems := Menu.RecentItems;
    LItem := LItems.Insert(0);
    LAction := TAction.Create(nil);
    LAction.Caption := FileName;
    LAction.Tag := LItem.Index;
    LAction.OnExecute := RecentActionHandler;
    FRecentActions.Add(LAction);
    LItem.Action := LAction;
    if LItems.Count > 1 then
    begin
      for I := LItems.Count - 1 downto 1 do
      begin
        if LItems[I].Caption = FileName then
        begin
          FRecentActions.Remove(LItems[I].Action);
          LItems.Delete(I);
        end;
      end;
    end;
    // Fix up Indexes
    LIdx := 0;
    for I := FRecentActions.Count - 1 downto 0 do
    begin
      TAction(FRecentActions[I]).Tag := LIdx;
      Inc(LIdx);
    end;
    Result := LAction.Tag;
  end
  else
    Result := -1;
end;

function TCustomRibbon.AddTab(const APage: TCustomRibbonPage): TRibbonTabItem;
var
  LActivePage: TCustomRibbonPage;
begin
  LActivePage := ActivePage;
  Result := FTabs.Add;
  Result.Caption := APage.Caption;
  Result.Page := APage;
  if Result.Page <> nil then
  begin
    Result.Page.Visible := True;
    Result.Page.BringToFront;
    RebuildRibbonMetrics;
  end;
  if (Result <> nil) and (LActivePage <> nil) then
    LActivePage.Visible := False;
end;

procedure TCustomRibbon.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TCustomRibbon.CMBidimodechanged(var Message: TMessage);
begin
  inherited;
  if HasApplicationMenu then
  begin
    if CustomFrameSupported then
      Menu.Top := GetRibbonMetric(rmFormBorder)
    else
      Menu.Top := 0;
    if BiDiMode = bdLeftToRight then
    begin
      Menu.Left := 0;
      Menu.Anchors := [akLeft, akTop];
    end
    else
    begin
      Menu.Left := Width - Menu.Width;
      Menu.Anchors := [akRight, akTop];
    end;
  end;
  Invalidate;
end;

procedure TCustomRibbon.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  if IsLeftMouseButtonPressed(Self) then
  begin
    if not HideTabs and not TestTabScrollButtonClick([]) then
      CheckTabChange(Message.XPos, Message.YPos);
  end
  else
    TestTabScrollButtonClick([ssLeft]);
end;

procedure TCustomRibbon.CMFontchanged(var Message: TMessage);
var
  I: Integer;
  LFont: TFont;
begin
  inherited;
  if not (csLoading in ComponentState) then
  begin
    LFont := TFont.Create;
    try
      LFont.Assign(Font);
      LFont.Color := ColorMap.FontColor;
      if ActionManager <> nil then
      begin
        for I := 0 to ActionManager.ActionBars.Count - 1 do
        begin
          if ActionManager.ActionBars[I].ActionBar <> nil then
          begin
            ActionManager.ActionBars[I].ActionBar.Font := LFont;
          end;
        end;
      end;
      RebuildRibbonMetrics;
    finally
      LFont.Free;
    end;
  end;
end;

procedure TCustomRibbon.CMMouseenter(var Message: TMessage);
begin
  inherited;
  FMouseInControl := True;
end;

procedure TCustomRibbon.CMMouseleave(var Message: TMessage);
begin
  inherited;
  FMouseInControl := False;
  HotTabIndex := -1;
  InvalidateScrollButtons;
end;

procedure TCustomRibbon.CMTextchanged(var Message: TMessage);
var
  LRect: TRect;
begin
  if HandleAllocated then
  begin
    LRect := Rect(0, 0, Width, GetCaptionHeight);
    InvalidateRect(Handle, {$IFNDEF CLR}@{$ENDIF}LRect, True);
  end;
end;

procedure TCustomRibbon.CMStyleChanged(var Message: TMessage);
begin
  inherited;
  // Force recalculation of caption height
  FCaptionHeight := -1;
  Invalidate;
end;

constructor TCustomRibbon.Create(AOwner: TComponent);
var
  I: Integer;
begin
  if AOwner <> nil then
  begin
    for I := 0 to AOwner.ComponentCount - 1 do
    begin
      if AOwner.Components[I] is TCustomRibbon then
        raise ERibbonException.Create(SDuplicateRibbonComponentsNotAllowed);
    end;
  end;
  inherited;
  FComponentStyle := FComponentStyle - [csInheritable];
  FScaleFactor := 1;//.25;
  FCaptionHeight := -1;
  FTabData := TCustomTabData.Create(Self);
  ControlStyle := ControlStyle - [csOpaque];
  FHideTabs := False;
  FAllowKeyboardNavigation := False;
  FKeyTipsVisible := False;
  FShowStyleWarning := True;
  FIgnoreTabChange := False;
  FUseCustomFrame := True;
  FQuickAccessToolbar := TQuickAccessToolbar.Create(Self);
  FApplicationMenu := TApplicationMenu.Create(Self);
  FDefaultColorMap := nil;
  FColorMap := nil;
  FUpdateCount := 0;
  FTabs := TRibbonTabs.Create(Self, TRibbonTabItem);
  FHotTabIndex := -1;
  FShowHelpButton := False;
  FQuickAccessToolbar.OnChange := QuickAccessToolbarPropsChangeHandler;
  ShowHelpButton := True;
  InitializeSystemMenu;
  Align := alTop;
  Height := GetRibbonMetric(rmFullHeight);
  FRecentActions := TObjectList.Create(True);
  FActive := True;
  ActionManager := FindActionManager;
  ParentDoubleBuffered := False;
  DoubleBuffered := True;
  if not (csDesigning in ComponentState) then
    CreateMouseWheelHook;
end;

procedure TCustomRibbon.DblClick;
var
  LTabIdx: Integer;
  LPt: TPoint;
begin
  inherited;
  LPt := ScreenToClient(Mouse.CursorPos);
  LTabIdx := GetTabAt(LPt.X, LPt.Y);
  if LTabIdx > -1 then
  begin
    if not Minimized and (LTabIdx = ActivePage.Index) then
      Minimized := True
    else if Minimized then
      Minimized := False;
  end
  else
    SetCaptureControl(nil);
end;

procedure TCustomRibbon.DefineProperties(Filer: TFiler);

  function StyleNameStored: Boolean;
  begin
    if Assigned(Filer.Ancestor) then
      Result := Style <> TCustomRibbon(Filer.Ancestor).Style
    else
      if Assigned(ActionBarStyles) then
        Result := Style <> ActionBarStyles.Style[ActionBarStyles.IndexOf(DefaultActnBarStyle)]
      else
        Result := Style <> nil;
  end;

begin
  inherited;
  Filer.DefineProperty('StyleName', ReadStyleProp, { Do not localize }
    WriteStyleProp, StyleNameStored);
end;

// Delete the tab at the specified Index
// The Page and any associated Groups are also deleted
procedure TCustomRibbon.DeleteTab(const Index: Integer);
var
  LPage: TCustomRibbonPage;
begin
  if FTabs.Count > Index then
  begin
    LPage := Tabs[Index].Page;
    FreeAndNil(LPage);
  end;
end;

destructor TCustomRibbon.Destroy;
begin
  CleanupQuickAccessToolbarGroups;
  FContextMenu.Free;
  FTabData.Free;
  if not IsDesigning then
  begin
    if Assigned(FParentWndProc) and (FParentForm <> nil) then
      FParentForm.WindowProc := FParentWndProc;
  end;
  FParentForm := nil;
  FTabs.Free;
  if FHelpButton <> nil then
    FHelpButton.Free;
  FColorMap := nil;
  FreeAndNil(FDefaultColorMap);
  FreeAndNil(FQuickAccessToolbar);
  FApplicationMenu.Free;
  FRecentActions.Free;
  FinalizeSystemMenu;
  inherited;
end;

procedure TCustomRibbon.DoHelpButtonClick;
begin
  if Assigned(FOnHelpButtonClick) then
    FOnHelpButtonClick(Self);
end;

procedure TCustomRibbon.DoTabChange(const NewIndex,
  OldIndex: Integer; var AllowChange: Boolean);
begin
  if Assigned(FOnTabChange) then
    FOnTabChange(Self, NewIndex, OldIndex, AllowChange);
end;

procedure DrawRoundRect(ACanvas: TCanvas; const aRect: TRect; const X, Y: Integer);
begin
  ACanvas.RoundRect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, X, Y);
end;

function CenterInRect(ACanvas: TCanvas; const ARect: TRect; const ACaption: string): TPoint;
var
  LTextWidth: Integer;
begin
  LTextWidth := ACanvas.TextWidth(ACaption);
  if LTextWidth > ARect.Right - ARect.Left then
    Result.X := 0
  else
    Result.X := (ARect.Right - ARect.Left) div 2 - (LTextWidth div 2);
  Result.Y := (ARect.Bottom - ARect.Top) div 2 - (ACanvas.TextHeight(ACaption) div 2);
end;

procedure TCustomRibbon.DrawCaption;
const
  TextFlags: Cardinal = DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX;
  CaptionFmt: array [Boolean] of string = ('%s', ' - %s');
  GlassCaptionFmt: array [Boolean] of string = ('%s%s', '%s - %s');
  Parts: array [TWindowState] of Integer = (WP_CAPTION, WP_CAPTION, WP_MAXCAPTION);                         
  States: array [Boolean] of integer = (CS_INACTIVE, CS_ACTIVE);
  procedure CalcWidth(var DocWidth, CaptionWidth: Integer); overload;
  var
    LCalcRect: TRect;
  begin
    LCalcRect := Rect(0,0,0,0);
    DrawText(Canvas.Handle, PWideChar(Format('%s', [DocumentName])),
      -1, LCalcRect, TextFlags or DT_CALCRECT);
    DocWidth := LCalcRect.Right;
    DrawText(Canvas.Handle,Format(CaptionFmt[DocumentName <> ''], [Caption]),
      -1, LCalcRect, TextFlags or DT_CALCRECT);
    CaptionWidth := LCalcRect.Right;
  end;

  procedure CalcWidth(Theme: HTheme; var DocWidth, CaptionWidth: Integer); overload;
  var
    LDTTOpts : DTTOPTS;
    LCalcRect: TRect;
  begin
    LCalcRect := Rect(0,0,0,0);
    LDTTOpts.dwSize := SizeOf(dttopts);
    LDTTOpts.dwFlags := 0;

    //Get Text Width
    LDTTOpts.dwFlags := LDTTOpts.dwFlags or DTT_CALCRECT;
    GetThemeTextExtent(Theme, canvas.Handle, Parts[FParentForm.WindowState], States[FParentForm.Active],
      PWideChar(Format(GlassCaptionFmt[DocumentName <> ''], [DocumentName, Caption])),
       -1, TextFlags, nil, LCalcRect);
    DocWidth := LCalcRect.Right;
    CaptionWidth := 0;
    LDTTOpts.dwFlags := LDTTOpts.dwflags and not DTT_CALCRECT;
  end;

  procedure FixRect(var Rect: TRect; TextWidth: Integer);
  begin
    if not HideRibbon then
    begin
      //Adjust Rect to find Center
      if ((ClientWidth + TextWidth) div 2 < Rect.Right) and
         ((ClientWidth - TextWidth) div 2 > Rect.Left) then
      begin
        Rect.Left := (ClientWidth - TextWidth) div 2;
      end
      else if TextWidth <= RectWidth(Rect) then
        Inc(Rect.Left, (RectWidth(Rect)-TextWidth) div 2);
    end
  end;

var
  LRect: TRect;
  LCalcRect: TRect;
  LDocumentWidth: Integer; // The width of the document portion of the caption
  LCaptionWidth: Integer;
  LIconSize: TIconSize;
  LIcon: TBitmap;
  LIconXOffset, LIconYOffset : Integer;
  HThemeWindow : HTHEME;
begin
  //Draw icon if the Ribbon is hidden
  if HideRibbon then
  begin
    LIcon := TBitmap.Create;
    try
      LIcon.Assign(GetIcon(LIconSize));
      LIconYOffset := (GetRibbonMetric(rmCaption)-GetSystemMetrics(SM_CXSMICON)) div 2;
      if not CustomFrameSupported then
        LIconXOffset := LIconYOffset
      else
        LIconXOffset := 0;
      canvas.StretchDraw(Rect(LIconXOffset, LIconYOffset,
        LIconXOffset+GetSystemMetrics(SM_CXSMICON),
        LIconYOffset+GetSystemMetrics(SM_CYSMICON)), LIcon);
    finally
      LIcon.Free;
    end;
  end;

  //Setup Font
  Canvas.Font := Screen.CaptionFont;
  canvas.Font.Color := TCustomRibbonColorMap(ColorMap).DocumentFontColor;

  LCalcRect := Rect(0,0,0,0);
  LRect := Rect(0,0, ClientWidth, GetCaptionHeight);
  if HasQuickAccessToolbar and (QuickAccessToolbar.Position = qpTop) then
    LRect.Left := QuickAccessToolbar.ActionBar.Left + QuickAccessToolbar.BarWidth
  else if HasApplicationMenu and Menu.Visible then
    LRect.Left := Menu.Left + Menu.Width
  else
    LRect.Left := 16;                   
  Inc(LRect.Left, 10);

  if CustomFrameSupported then
  begin
    lrect.Top := GetRibbonMetric(rmFormBorder);

    if GlassFrameSupported then
    begin
      DwmGetWindowAttribute(FParentForm.Handle, DWMWA_CAPTION_BUTTON_BOUNDS,
        @LCalcRect, SizeOf(LCalcRect));
      LRect.Right := LCalcRect.Left - GetRibbonMetric(rmFormBorder);

      HThemeWindow := OpenThemeData(0, 'CompositedWindow::Window'); //do not localize
      try
        CalcWidth(HThemeWindow, LDocumentWidth, LCaptionWidth);
        FixRect(LRect, LDocumentWidth + LCaptionWidth);

        DrawThemeText(hthemewindow, canvas.Handle, Parts[FParentForm.WindowState], States[FParentForm.Active],
          PWideChar(Format(GlassCaptionFmt[DocumentName <> ''], [DocumentName, Caption])),
          -1, TextFlags or DT_END_ELLIPSIS, 0, LRect );
      finally
        CloseThemeData(HThemeWindow);
      end;
    end
    else  // not glass
    begin
      dec(LRect.Right, ClientWidth - FMinimizeButton.Left);

    end;
  end;

  if not CustomFrameSupported or not GlassFrameSupported then
  begin
    CalcWidth(LDocumentWidth, LCaptionWidth) ;
    FixRect(LRect, LDocumentWidth + LCaptionWidth);
    if Active then
      Canvas.Font.Color := TCustomRibbonColorMap(ColorMap).DocumentFontColor
    else
      Canvas.Font.Color := ColorMap.DisabledFontColor;

    DrawText(canvas.Handle,Format('%s', [DocumentName]), -1, LRect, DT_LEFT or TextFlags or DT_END_ELLIPSIS);
    Inc(LRect.Left, LDocumentWidth);
    if Active then
      Canvas.Font.Color := TCustomRibbonColorMap(ColorMap).CaptionFontColor;
    DrawText(canvas.Handle,Format(CaptionFmt[DocumentName <> ''], [Caption]),
      -1, LRect, DT_LEFT or TextFlags or DT_END_ELLIPSIS);
  end;
end;

procedure TCustomRibbon.DrawQuickAccessToolbar;
var
  LRect: TRect;
begin
  if HasQuickAccessToolbar and not HideRibbon and
    (FQuickAccessToolbar.Position = qpTop) then
  begin
    // draw outline
    if BiDiMode = bdLeftToRight then
    begin
      LRect := Rect(cRibbonQuickAccessToolbarLeft, FQuickAccessToolbar.ActionBar.top,
        cRibbonQuickAccessToolbarLeft + 15, FQuickAccessToolbar.ActionBar.top + 24);
      Style.DrawElement(sqStart, Canvas, LRect);
    end
    else
    begin
      LRect := Rect(Width - cRibbonQuickAccessToolbarLeft - 15, FQuickAccessToolbar.ActionBar.top,
        Width - cRibbonQuickAccessToolbarLeft, FQuickAccessToolbar.ActionBar.top + 24);
      Style.DrawElement(sqStartRTL, Canvas, LRect);
    end;
  end;
end;

procedure AdjustRect(var Rect: TRect; const ALeft, ATop, ARight, ABottom: Integer); inline;
begin
  Rect := System.Types.Rect(Rect.Left + ALeft, Rect.Top + ATop,
    Rect.Right + ARight, Rect.Bottom + ABottom);
end;

procedure TCustomRibbon.DrawTab(const Index: Integer);
var
  LRect: TRect;
  LPt: TPoint;
  LSeparatorRect: TRect;
  LStyle: TRibbonStyleActionBars;
  LModifyRect: Boolean;
  LTabWidth: Integer;
begin
  if not ValidTab(Index) then
    Exit;
  LStyle := Style;
  LRect := GetTabRect(Index);
  LTabWidth := LRect.Right - LRect.Left;
  if FHotTabIndex = Index then
  begin
    if FTabIndex <> Index then
    begin
      if not Minimized then
        Dec(LRect.Bottom);
      LStyle.DrawElement(stHoverUnselected, Canvas, LRect);
      if not Minimized then
        Inc(LRect.Bottom);
    end
    else
      LStyle.DrawElement(stHover, Canvas, LRect);
  end
  else if FTabIndex = Index then
  begin
    if FKeyTipsVisible or AllowKeyboardNavigation then
      LStyle.DrawElement(stKeyTipsActive, Canvas, LRect)
    else
    begin
      AdjustRect(LRect, -2, 0, 3, -1);
      LStyle.DrawElement(stBackground, Canvas, LRect);
      AdjustRect(LRect, 2, 0, -3, 1);
      LStyle.DrawElement(stNormal, Canvas, LRect);
    end;
  end
  else
  begin
    if not Minimized then
      AdjustRect(LRect, -2, 0, 2, -1)
    else
      AdjustRect(LRect, -2, 0, 2, 0);
    LStyle.DrawElement(stBackground, Canvas, LRect);
    if not Minimized then
      AdjustRect(LRect, 2, 0, -2, 1)
    else
      AdjustRect(LRect, 2, 0, -2, 0)
  end;
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign(Font);
  Canvas.Font.Size := GetRibbonMetric(rmFontSize);
  if TabIndex = Index then
    Canvas.Font.Color := TCustomRibbonColorMap(ColorMap).ActiveTabFontColor
  else
    Canvas.Font.Color := TCustomRibbonColorMap(ColorMap).InactiveTabFontColor;
  LPt := CenterInRect(Canvas, LRect, FTabs[Index].Caption);
  LRect := Rect(LRect.Left + LPt.X, LRect.Top + LPt.Y, LRect.Right, LRect.Bottom);
  LModifyRect := LTabWidth - 6 - Tabs[Index].MinTabwidth <= 0;
  if LModifyRect then
    AdjustRect(LRect, 4, 0, -4, 0);
  DrawText(Canvas.Handle, FTabs[Index].Caption, -1, LRect, DT_LEFT);
  if LModifyRect then
    AdjustRect(LRect, -4, 0, 4, 0);
  if (FTabData.TabSeparatorState > tssHidden) then
  begin
    LSeparatorRect := Rect(LRect.Right + (cRibbonTabSpacing div 2), LRect.Top - LPt.Y,
      LRect.Right + (cRibbonTabSpacing div 2) + 1, LRect.Bottom);
    LStyle.DrawElement(stSeparator, Canvas, LSeparatorRect, FTabData.SeparatorOpacity);
  end;
end;

procedure TCustomRibbon.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount < 0 then
    FUpdateCount := 0;
  if FUpdateCount = 0 then
    Invalidate;
end;

procedure TCustomRibbon.FixUpPageIndexes;
var
  I: Integer;
begin
  for I := 0 to FTabs.Count - 1 do
  begin
    if FTabs[I].Page <> nil then
      FTabs[I].Page.Index := I;
  end;
  for I := FTabs.Count - 1 downto 0 do
  begin
    if FTabs[I].Page = nil then
      FTabs.Delete(I);
  end;
end;

procedure TCustomRibbon.FixUpTabList(APage: TCustomRibbonPage);
var
  I: Integer;
begin
  for I := 0 to Tabs.Count - 1 do
  begin
    if Tabs[I].Page = APage then
      Tabs[I].Page := nil;
  end;
  for I := Tabs.Count - 1 downto 0 do
  begin
    if Tabs[I].Page = nil then
      Tabs.Delete(I);
  end;
  FixUpPageIndexes;
  // Force the SetTabIndex logic to process
  FTabIndex := -1;
  TabIndex := 0;
end;

function TCustomRibbon.GetActivePage: TCustomRibbonPage;
begin
    if (TabIndex > -1) and (TabIndex < FTabs.Count) then
    begin
      if FTabs[TabIndex] <> nil then
        Result := FTabs[TabIndex].Page
      else
        Result := nil;
    end
    else
      Result := nil;
end;

function TCustomRibbon.SetupDefaultColorMap: TCustomActionBarColorMap;
var
  LColorMapClass: TCustomColorMapClass;
begin
  FreeAndNil(FDefaultColorMap);
  if ActionManager = nil then
    LColorMapClass := TRibbonLunaColorMap
  else
    LColorMapClass := (ActionManager.Style as TActionBarStyleEx).GetColorMapClass(nil);
  if LColorMapClass = nil then
    LColorMapClass := TRibbonLunaColorMap;
  FDefaultColorMap := LColorMapClass.Create(Self);
  FDefaultColorMap.Name := 'DefaultColorMap'; // do not localise
  FDefaultColorMap.SetSubComponent(True);
  Result := FDefaultColorMap;
end;

function TCustomRibbon.GetCaptionHeight: Integer;
begin
  if FCaptionHeight = -1 then
  begin
    FCaptionHeight := Max(GetSystemMetrics(SM_CYCAPTION), 26);
    if CustomFrameSupported then
      Inc(FCaptionHeight, GetSystemMetrics(SM_CYFRAME));
    // The caption of the Ribbon must be at least 28 pixels high (at 96dpi)
//    FCaptionHeight := Max(FCaptionHeight, GetSystemMetrics(SM_CYFRAME)+25);
  end;
  Result := FCaptionHeight;
end;

function TCustomRibbon.GetColorMap: TCustomActionBarColorMap;
begin
  if FColorMap = nil then
  begin
    // Setup default
    SetupDefaultColorMap;
    FColorMap := FDefaultColorMap;
  end;
  Result := FColorMap;
end;

function TCustomRibbon.GetHelpButtonRect: TRect;
var
  LTopPos: Integer;
begin
  if ShowHelpButton then
  begin
    LTopPos := GetRibbonMetric(rmCaption) + 1;
    if BiDiMode = bdLeftToRight then
      Result := Rect(Width - FHelpButton.Width, LTopPos, Width, LTopPos + FHelpButton.Height)
    else
      Result := Rect(0, LTopPos, FHelpButton.Width, LTopPos + FHelpButton.Height);
  end
  else
    Result := Rect(0, 0, 0, 0);
end;

function TCustomRibbon.GetTabAt(const X, Y: Integer): Integer;
var
  I: Integer;
begin
  for I := FTabData.FirstVisibleTabIndex to FTabs.Count - 1 do
  begin
    if GetTabRect(I).Contains(Point(X, Y)) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function TCustomRibbon.GetTabIndex: Integer;
begin
  Result := FTabIndex;
end;

// Return the bounds for the tab at a given index
function TCustomRibbon.GetTabRect(const Index: Integer): TRect;
var
  LWidth: Integer;
  I: Integer;
  LHeight: Integer;
begin
  if not ValidTab(Index) then
  begin
    Result := Rect(0, 0, 0, 0);
    Exit;
  end;

  LWidth := cRibbonFirstTabOffSet; // Space before tabs are drawn
  for I := FTabData.FirstVisibleTabIndex to Index - 1 do
    Inc(LWidth, GetTabWidth(I) + cRibbonTabSpacing);
  LHeight := GetRibbonMetric(rmCaption);
  Result := Rect(LWidth, LHeight + 2, LWidth + GetTabWidth(Index),
    GetRibbonMetric(rmTabHeight) + LHeight + 2);
  if FTabs[Index].Page <> nil then
  begin
    FTabs[Index].X := LWidth;
    FTabs[Index].Y := 0;
    FTabs[Index].Index := Index;
  end;
  IntersectRect(Result, Result, FTabData.TabUpdateRect);
end;

function TCustomRibbon.GetTabWidth(const Index: Integer): Integer;
begin
  Canvas.Font.Assign(Font);
  Canvas.Font.Size := GetRibbonMetric(rmFontSize);
  if ValidTab(Index) then
    Result := FTabData.NewWidth[Index]
  else
    Result := 0;
end;

function TCustomRibbon.GlassFrameSupported: Boolean;
begin
  Result := {CustomFrameSupported and} DwmCompositionEnabled and
    (FParentForm <> nil) and FParentForm.GlassFrame.Enabled;

end;

procedure TCustomRibbon.HelpButtonClickHandler(Sender: TObject);
begin
  DoHelpButtonClick;
end;

procedure TCustomRibbon.HideKeyTips;
begin
  if KeyTipsVisible then
  begin
    TabHideKeyTips('', nil);
    if ActivePage <> nil then
      ActivePage.HideKeyTips(nil);
    CheckAndResetMinimizedState;
    KeyTipsVisible := False;
  end;
end;

procedure TCustomRibbon.SetBounds(ALeft: Integer; ATop: Integer;
  AWidth: Integer; AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, GetRibbonHeight);
  if HasQuickAccessToolbar then
  begin
    if QuickAccessToolbar.Position = qpTop then
      FHeaderRect := Rect(QuickAccessToolbar.ActionBar.Width, 0, Width,
        GetRibbonMetric(rmCaption))
    else
      FHeaderRect := Rect(0, 0, Width, GetRibbonMetric(rmCaption));
  end
  else
    FHeaderRect := Rect(0, 0, Width, GetRibbonMetric(rmCaption));
end;

// Returns the Icon used by the Application Menu Button
// If there is no Icon assigned to the ApplicationMenu.Icon property, then
// the applications icon is used
function TCustomRibbon.GetIcon(out IconSize: TIconSize): TIcon;
begin
  if ApplicationMenu.Icon.Empty then
  begin
    ApplicationMenu.Icon.Handle :=
      LoadImage(hInstance, 'MAINICON', IMAGE_ICON, 32, 32, LR_DEFAULTCOLOR);
  end;
  IconSize := ApplicationMenu.IconSize;
  Result := ApplicationMenu.Icon;
end;

function TCustomRibbon.GetMenu: TRibbonApplicationMenuBar;
begin
  if HasApplicationMenu then
    Result := ApplicationMenu.Menu
  else
    Result := nil;
end;

// Method used to validate KeyTip input when the KeyTips State is ktsTabs.
// KeyTips can be in either ktsTabs or ktsControls state. When the KeyTips
// state is ktsTabs that means that the user has the option of selecting
// which Tab to switch to and display the keytips for the controls on that
// tab. When the State ktsTabs, then the Application Button and Quick Access
// Toolbar are also displaying their KeyTips.
//
// KeyTip - The KeyTip the user has input that needs to be validated against
// Full - A list of TKeyTipMatchItems that contain details if any KeyTips
// were matched
procedure TCustomRibbon.TabHandledKeyTips(const KeyTip: string; var KeyTips: TKeyTipList);
var
  I: Integer;
  LIntf: IRibbonKeyTip;
  LBarIntf: IRibbonBarKeyTip;
  LHandled: TKeyTipHandled;
begin
  if Supports(GetApplicationButton, IRibbonKeyTip, LIntf) then
  begin
    LIntf.HandleKeyTip(KeyTip, LHandled);
    if LHandled <> ktNone then
      KeyTips.Add(mtApplicationMenu, LHandled, GetApplicationButton);
  end;

  if Supports(QuickAccessToolbar.ActionBar, IRibbonBarKeyTip, LBarIntf) then
    LBarIntf.BarHandleKeyTips(KeyTip, KeyTips);

  // Activate Tabs KeyTips
  for I := FTabData.FirstVisibleTabIndex to FTabData.LastVisibleTabIndex do
  begin
    TKeyTipValidator.Validate(KeyTip, FTabs[I].KeyTip, nil, LHandled);
    if LHandled <> ktNone then
      KeyTips.Add(mtTabs, LHandled, nil, I);
  end;
end;

// Hides the KeyTips. If the ExceptList parameter is nil, all KeyTips are
// hidden. Otherwise the ExceptList contains TKeyTipMatchItems that are not
// supposed to be hidden at this time. This would occur when there are a
// number of Partial KeyTip matches. Where the first character of a KeyTip
// matches many KeyTips
procedure TCustomRibbon.TabHideKeyTips(const KeyTip: string; KeyTips: TKeyTipList);
var
  LIndexes: TStringList;
  I: Integer;
  LIdx: Integer;
  LMatchItem: TKeyTipMatchItem;
  LIntf: IRibbonKeyTip;
  LBarIntf: IRibbonBarKeyTip;
begin
  if Supports(GetApplicationButton, IRibbonKeyTip, LIntf) then
    LIntf.HideKeyTip(KeyTip);
  if Supports(QuickAccessToolbar.ActionBar, IRibbonBarKeyTip, LBarIntf) then
    LBarIntf.BarHideKeyTips(KeyTips);
  // If the ExceptList is nil, then all KeyTips should be hidden for the tabs
  if KeyTips = nil then
  begin
    for I := FTabData.FirstVisibleTabIndex to FTabs.Count - 1 do
    begin
      FTabs[I].KeyTipForm.Free;
      FTabs[I].KeyTipForm := nil;
    end;
  end
  else
  begin
    // Create a sorted list of all the tabs that still partial matched KeyTips
    // If the Tab Index is not in the LIndexes list, then that Tab index should
    // have its KeyTip hidden
    LIndexes := TStringList.Create;
    try
      for I := 0 to KeyTips.Count - 1 do
      begin
        LMatchItem := TKeyTipMatchItem(KeyTips[I]);
        if LMatchItem.MatchType = mtTabs then
          LIndexes.Add(IntToStr(LMatchItem.Index));
      end;
      LIndexes.Sorted := True;
      for I := FTabData.FirstVisibleTabIndex to FTabs.Count - 1 do
      begin
        if not LIndexes.Find(IntToStr(I), LIdx) then
        begin
          FTabs[I].KeyTipForm.Free;
          FTabs[I].KeyTipForm := nil;
        end;
      end;
    finally
      LIndexes.Free;
    end;
  end;
end;

// Displays the KeyTips for the ktsTabs State. When called, KeyTips are
// displayed for the Tabs, Application Button and Quick Access Toolbar
procedure TCustomRibbon.TabShowKeyTips;
var
  I: Integer;
  LRect: TRect;
  LPt: TPoint;
begin
  // Activate Tabs Key Tips
  for I := FTabData.FirstVisibleTabIndex to FTabData.LastVisibleTabIndex do
  begin
    if FTabs[I].KeyTipForm <> nil then
    begin
      FTabs[I].KeyTipForm.Free;
      FTabs[I].KeyTipForm := nil;
    end;
    LRect := GetTabRect(I);
    LPt := ClientToScreen(Point(LRect.Left, LRect.Bottom));
    LRect := Rect(LPt.X, LPt.Y - 17, LRect.Right - LRect.Left, LRect.Bottom - LRect.Top);
    FTabs[I].KeyTipForm := Vcl.RibbonActnCtrls.ShowKeyTip(FTabs[I].KeyTip, True, True, LRect, ktpTabs);
  end;
end;

procedure TCustomRibbon.InitializeSystemMenu;
begin
  FCloseButton := TRibbonSystemButton.Create(self, smbClose);
  FCloseButton.SetParent(Self);
  FRestoreButton := TRibbonSystemButton.Create(self, smbRestore);
  FRestoreButton.SetParent(Self);
  FMinimizeButton := TRibbonSystemButton.Create(self, smbMinimize);
  FMinimizeButton.SetParent(Self);
end;

// Invalidate the header section of the Ribbon. Invalidating the header of the
// ribbon is especially important when using a custom frame. When using a custom
// frame, the header section of the ribbon needs to react visually to additional
// non-client specific messages
procedure TCustomRibbon.InvalidateHeaderArea;
var
  LRect: TRect;
begin
  LRect := ClientRect;
  LRect.Bottom := GetRibbonMetric(rmCaption);
  InvalidateRect(Handle, LRect, True);
  if HasApplicationMenu then
    Menu.Invalidate;
  if HasQuickAccessToolbar then
    QuickAccessToolbar.FActionBar.Invalidate;
end;

procedure TCustomRibbon.InvalidateScrollButtons;
var
  LRect: TRect;
begin
  if tsbTabRight in FTabData.ScrollButtons then
  begin
    LRect := FTabData.RightTabScrollButtonRect;
    InvalidateRect(Handle, LRect, True);
  end;
  if tsbTabLeft in FTabData.ScrollButtons then
  begin
    LRect := FTabData.LeftTabScrollButtonRect;
    InvalidateRect(Handle, LRect, True);
  end;
end;

// Invalidate the area that displays the tabs
procedure TCustomRibbon.InvalidateTabArea;
var
  LRect: TRect;
begin
  if HideTabs or (FTabs = nil) then
    Exit;
  if Tabs.Count > 0 then
  begin
    LRect := GetTabRect(0);
    Dec(LRect.Top);
    LRect.Left := cRibbonFirstTabOffSet;
    LRect.Right := Width;
    InvalidateRect(Handle, LRect, True);
  end;
end;

procedure TCustomRibbon.FinalizeSystemMenu;
begin
  FCloseButton.Free;
  FRestoreButton.Free;
  FMinimizeButton.Free;
end;

function TCustomRibbon.FindActionManager: TCustomActionManager;
var
  I: Integer;
begin
  if Owner <> nil then
  begin
    for I := 0 to Owner.ComponentCount - 1 do
    begin
      if Owner.Components[I] is TCustomActionManager then
      begin
        Result := TCustomActionManager(Owner.Components[I]);
        Exit;
      end;
    end;
  end;
  Result := nil;
end;

function TCustomRibbon.IsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TCustomRibbon.IsTabsStored: Boolean;
begin
  Result := FTabs.Count > 0;
end;

procedure TCustomRibbon.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if not AllowKeyboardNavigation then
  begin
    inherited;
    Exit;
  end;
  if Key = VK_LEFT then
  begin
    if not Tabs.SelectPrior then
    begin
      if HasApplicationMenu then
        Menu.SelectApplicationButton;
    end;
  end
  else if Key = VK_RIGHT then
  begin
    if not Tabs.SelectNext then
    begin
      if HasApplicationMenu then
        Menu.SelectApplicationButton;
    end;
  end
  else if Key = VK_ESCAPE then
  begin
    if FLastActiveControl <> nil then
      Winapi.Windows.SetFocus(FLastActiveControl.Handle)
    else
      Winapi.Windows.SetFocus(Application.MainForm.Handle);
    KeyTipsVisible := False;
    AllowKeyboardNavigation := False;
  end
  else
    inherited;
end;

function TCustomRibbon.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  if not Minimized and not KeyTipsVisible and FParentForm.Active then
  begin
    Tabs.SelectNext;
    Result := inherited DoMouseWheelDown(Shift, MousePos);
  end
  else
    Result := False;
end;

function TCustomRibbon.DoMouseWheelEx(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;
begin
  if not Minimized and not KeyTipsVisible then
    Result := DoMouseWheel(Shift, WheelDelta, MousePos)
  else
    Result := False;
end;

function TCustomRibbon.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  if not Minimized and not KeyTipsVisible and FParentForm.Active then
  begin
    Tabs.SelectPrior;
    Result := inherited DoMouseWheelUp(Shift, MousePos);
  end
  else
    Result := False;
end;

procedure TCustomRibbon.DoRecentItemClick(const FileName: string;
  const Index: Integer);
begin
  if Assigned(FOnRecentItemClick) then
    FOnRecentItemClick(Self, FileName, Index);
end;

procedure TCustomRibbon.DoScrollTabsLeft;
begin
  if FTabData.LastVisibleTabIndex < Tabs.Count then
  begin
    Inc(FTabData.FFirstVisibleTabIndex);
    RebuildRibbonMetrics;
  end;
  if Assigned(FOnRightTabScrollButtonClick) then
    FOnRightTabScrollButtonClick(Self);
end;

procedure TCustomRibbon.DoScrollTabsRight;
begin
  if FTabData.FirstVisibleTabIndex > 0 then
  begin
    Dec(FTabData.FFirstVisibleTabIndex);
    RebuildRibbonMetrics;
  end;
  if Assigned(FOnLeftTabScrollButtonClick) then
    FOnLeftTabScrollButtonClick(Self);
end;

function TCustomRibbon.TestTabScrollButtonClick(Shift: TShiftState): Boolean;
var
  LPt: TPoint;

  procedure ClearClickPending;
  var
    I: TRibbonScrollButton;
  begin
    for I := Low(TRibbonScrollButton) to High(TRibbonScrollButton) do
      FClickPending[I] := False;
  end;

begin
  Result := False;
  if ssLeft in Shift then
  begin
    ClearClickPending;
    LPt := ScreenToClient(Mouse.CursorPos);
    if (tsbTabRight in FTabData.ScrollButtons) and
       FTabData.RightTabScrollButtonRect.Contains(LPt) then
    begin
      FClickPending[tsbTabRight] := True;
      Result := True;
    end
    else
    if (tsbTabLeft in FTabData.ScrollButtons) and
       FTabData.LeftTabScrollButtonRect.Contains(LPt) then
    begin
      FClickPending[tsbTabLeft] := True;
      Result := True;
    end;
  end
  else
  if Shift = [] then
  begin
    LPt := ScreenToClient(Mouse.CursorPos);
    if (tsbTabRight in FTabData.ScrollButtons) and
       FTabData.RightTabScrollButtonRect.Contains(LPt) then
    begin
      FIgnoreTabChange := True;
      if FClickPending[tsbTabRight] then
        DoScrollTabsLeft;
      Result := True;
    end
    else
    if (tsbTabLeft in FTabData.ScrollButtons) and
       FTabData.LeftTabScrollButtonRect.Contains(LPt) then
    begin
      FIgnoreTabChange := True;
      if FClickPending[tsbTabLeft] then
        DoScrollTabsRight;
      Result := True;
    end;
    ClearClickPending;
  end;
end;

function TCustomRibbon.GetActiveScrollButton: TTabActiveScrollButton;
var
  LPt: TPoint;
begin
  Result := asbNone;
  LPt := ScreenToClient(Mouse.CursorPos);
  if (tsbTabRight in FTabData.ScrollButtons) and
     FTabData.RightTabScrollButtonRect.Contains(LPt) then
    Result := asbRight
  else
  if (tsbTabLeft in FTabData.ScrollButtons) and
     FTabData.LeftTabScrollButtonRect.Contains(LPt) then
    Result := asbLeft;
end;

function TCustomRibbon.GetApplicationButton: TCustomActionControl;
begin
  if HasApplicationMenu then
    Result := Menu.FindFirstVisibleItem.Control
  else
    Result := nil;
end;

function TCustomRibbon.DrawScrollButtons: Boolean;
var
  LPt: TPoint;
  LButtonRect: TRect;
begin
  Result := False;
  LPt := ScreenToClient(Mouse.CursorPos);
  if tsbTabRight in FTabData.ScrollButtons then
  begin
    Result := True;
    LButtonRect := FTabData.RightTabScrollButtonRect;
    if LButtonRect.Contains(LPt) then
    begin
      if IsLeftMouseButtonPressed(Self) then
        Style.DrawElement(stScrollRightPressed, Canvas, LButtonRect)
      else
        Style.DrawElement(stScrollRightHover, Canvas, LButtonRect)
    end
    else
      Style.DrawElement(stScrollRight, Canvas, LButtonRect);
  end;

  if tsbTabLeft in FTabData.ScrollButtons then
  begin
    Result := True;
    LButtonRect := FTabData.LeftTabScrollButtonRect;
    if LButtonRect.Contains(LPt) then
    begin
      if IsLeftMouseButtonPressed(Self) then
        Style.DrawElement(stScrollLeftPressed, Canvas, LButtonRect)
      else
        Style.DrawElement(stScrollLeftHover, Canvas, LButtonRect)
    end
    else
      Style.DrawElement(stScrollLeft, Canvas, LButtonRect);
  end;
end;

procedure TCustomRibbon.DrawSystemButtons;
  var
    SysBtnRect : TRect;
    SysBtnWidth : Integer;
begin
  FCloseButton.Visible := CustomFrameSupported and not DwmCompositionEnabled;
  FRestoreButton.Visible := CustomFrameSupported and not DwmCompositionEnabled;
  FMinimizeButton.Visible := CustomFrameSupported and not DwmCompositionEnabled;

  SysBtnWidth := (GetRibbonMetric(rmSystemButtonWidth)-2);
  SysBtnRect.Right := ClientRect.Right;
  SysBtnRect.Left := SysBtnRect.Right-SysBtnWidth;
  SysBtnRect.Top := GetRibbonMetric(rmFormBorder);
  SysBtnRect.Bottom := SysBtnRect.Top+GetRibbonMetric(rmSystemButtonHeight);

  FCloseButton.BoundsRect := SysBtnRect;
  Dec(SysBtnRect.Right, SysBtnWidth);
  Dec(SysBtnRect.Left, SysBtnWidth);
  FRestoreButton.BoundsRect := SysBtnRect;
  Dec(SysBtnRect.Right, SysBtnWidth);
  Dec(SysBtnRect.Left, SysBtnWidth);
  FMinimizeButton.BoundsRect := SysBtnRect;
end;

procedure TCustomRibbon.Loaded;
var
  I: Integer;
  J: Integer;
  LPage: TRibbonPage;
  LActionBarItem: TActionBarItem;
begin
  SetColorMap(nil);
  inherited;
  for I := 0 to FTabs.Count - 1 do
  begin
    for J := 0 to ControlCount - 1 do
    begin
      if (Controls[J] is TCustomRibbonPage) then
      begin
        LPage := TRibbonPage(Controls[J]);
        if LPage.Index = I then
        begin
          FTabs[I].FPage := LPage;
          Break;
        end;
      end;
    end;
  end;
  // Make sure the selected tab and page is in sync
  for I := FTabs.Count - 1 downto 0 do
  begin
    if (FTabs[I].Page <> nil) then
    begin
      FTabs[I].Page.Visible := (I = 0) and not HideTabs;
      FTabs[I].Page.Ribbon := (FTabs[I].Page.Parent as TCustomRibbon);
    end
    else
      DeleteTab(I);
  end;
  if ShowHelpButton then
    FHelpButton.BoundsRect := GetHelpButtonRect;
  ApplicationMenu.Initialize(ScreenTips);
  if not IsDesigning and (ActionManager <> nil) then
  begin
    for I := 0 to ActionManager.ActionBars.Count - 1 do
    begin
      LActionBarItem := ActionManager.ActionBars[I];
      if not (LActionBarItem.ActionBar is TCustomRibbonQuickAccessToolbar) then
        LActionBarItem.ChangesAllowed := [];
    end;
  end;
  if not IsDesigning then
    TabIndex := 0;
  CheckRibbonSize;
  RebuildRibbonMetrics;

  DrawSystemButtons;

end;

procedure TCustomRibbon.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  LTabIndex: Integer;

begin
  inherited;
  if Active and not HideTabs then
  begin
    LTabIndex := GetTabAt(X, Y);
    HotTabIndex := LTabIndex;
    if (GetActiveScrollButton <> asbNone) then
      HotTabIndex := -1;
    InvalidateScrollButtons;
  end
end;

procedure TCustomRibbon.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  begin
    if not HideTabs and not TestTabScrollButtonClick(Shift) then
    begin
      CheckTabChange(X, Y);
      FIgnoreTabChange := False;
    end;
    SetCaptureControl(nil);
  end;
  InvalidateScrollButtons;
end;

// Move a group to a new page
// The group to be moved is specified in the GroupName parameter
// The destination page is specified in the PageName parameter
procedure TCustomRibbon.MoveGroup(const GroupName, PageName: string);
var
  LPage: TCustomRibbonPage;
  LOldPage: TCustomRibbonPage;
  LGroup: TControl;
begin
  LPage := Tabs.GetPageFromPageCaption(PageName);
  if LPage <> nil then
  begin
    LGroup := Tabs.FindGroup(GroupName);
    // Remove the group from the old page
    LOldPage := TCustomRibbonGroup(LGroup).Page;
    if LOldPage <> nil then
    begin
      LOldPage.FGroups.Remove(LGroup);
      LOldPage.AlignGroups;
    end;
    // don't move the page if it already exists
    if (LGroup <> nil) and (LGroup.Parent <> LPage) then
    begin
      LGroup.Parent := LPage;
      LPage.AddGroup(TCustomRibbonGroup(LGroup));
      LPage.AlignGroups;
    end;
  end;
end;

procedure TCustomRibbon.Notification(AComponent: TComponent; Operation: TOperation);
var
  LTabIndex: Integer;
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FActionManager then
      FActionManager := nil
    else if (FQuickAccessToolbar <> nil) and (AComponent = FQuickAccessToolbar.ActionBar) then
    begin
      FQuickAccessToolbar.ActionBar := nil;
      if not (csDestroying in ComponentState) then
        InvalidateHeaderArea;
    end
    else if (AComponent = FColorMap) and (FColorMap <> FDefaultColorMap) then
      FColorMap := nil
    else if (AComponent = FApplicationMenu.Menu) then
      FApplicationMenu.Menu := nil
    else if AComponent = FScreenTips then
      FScreenTips := nil
    else if AComponent is TCustomRibbonPage then
    begin
      if not (csDestroying in ComponentState) then
      begin
        LTabIndex := Tabs.IndexOfCaption(TCustomRibbonPage(AComponent).Caption);
        if LTabIndex > -1 then
        begin
          Tabs[LTabIndex].FPage := nil;
          Tabs.Delete(LTabIndex);
        end;
        InvalidateTabArea;
      end;
    end
    else if AComponent = FLastActiveControl then
      FLastActiveControl := nil;
  end;
end;

procedure TCustomRibbon.Paint;
var
  LRect: TRect;
  I: Integer;
begin
  Canvas.Font.Assign(Font);
  if not FTabDataInitialised then
  begin
    RebuildRibbonMetrics;
    FTabDataInitialised := True;
  end;
  LRect := ClientRect;
  if Minimized or HideTabs or HideRibbon then
    LRect.Bottom := GetRibbonMetric(rmFullHeight) - 1
  else
  begin
    if QuickAccessToolbar.Position = qpBottom then
      Dec(LRect.Bottom, cRibbonQATHeight);
  end;
  if CustomFrameSupported then
  begin
    if GlassFrameSupported then
    begin
      canvas.Brush.color := clBlack;
      canvas.FillRect(LRect);
    end
    else
    begin
      if Active then
        Style.DrawElement(srBackground, Canvas, LRect, GetRibbonMetric(rmCaption))
      else
        Style.DrawElement(srBackgroundDisabled, Canvas, LRect, GetRibbonMetric(rmCaption))
    end;
  end
  else
    Style.DrawElement(srBackground, Canvas, LRect, GetRibbonMetric(rmCaption));
  Inc(LRect.Top, GetRibbonMetric(rmCaption));
  Style.DrawElement(srBody, Canvas, LRect, -1);
  if not HideTabs then
  begin
    for I := FTabData.FirstVisibleTabIndex to FTabData.LastVisibleTabIndex do
    begin
      DrawTab(I);
    end;
    DrawScrollButtons;
  end;
  DrawQuickAccessToolbar;
  DrawCaption;
  if Minimized or HideTabs then
  begin
    Canvas.Pen.Color := TCustomRibbonColorMap(ColorMap).BevelMinimizedInner;
    Canvas.MoveTo(0, Height - 2);
    Canvas.LineTo(Width, Height - 2);
    Canvas.Pen.Color := TCustomRibbonColorMap(ColorMap).BevelMinimizedOuter;
    Canvas.MoveTo(0, Height - 1);
    Canvas.LineTo(Width, Height - 1);
  end;
end;

procedure TCustomRibbon.QuickAccessToolbarPropsChangeHandler(Sender: TObject);
begin
  UpdateQATPosition;
end;

// Remove all Tabs from the Ribbon
// All associated pages and groups are deleted
procedure TCustomRibbon.RemoveAllTabs;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := Tabs.Count - 1 downto 0 do
      RemoveTab(Tabs[I].Caption);
  finally
    EndUpdate;
  end;
end;

function TCustomRibbon.RemoveRecentItem(const FileName: string): Boolean;
var
  I: Integer;
  LItems: TOptionItems;
  LIdx: Integer;
begin
  if HasApplicationMenu then
  begin
    LItems := Menu.RecentItems;
    try
    for I := 0 to LItems.Count - 1 do
    begin
      Result := LItems[I].Caption = FileName;
      if Result then
      begin
        FRecentActions.Remove(LItems[I].Action);
        LItems.Delete(I);
        Exit;
      end;
    end;
    finally
      // Fix up indexes
      LIdx := 0;
      for I := FRecentActions.Count - 1 downto 0 do
      begin
        TAction(FRecentActions[I]).Tag := LIdx;
        Inc(LIdx);
      end;
    end;
  end;
  Result := False;
end;

procedure TCustomRibbon.CreateContextMenu;
var
  LMenuItem: TMenuItem;
begin
  FreeAndNil(FContextMenu);
  FContextMenu := TPopupActionBar.Create(Self);
  FContextMenu.Style := ActionManager.Style;
  FContextMenu.OnPopup := ContextMenuPopupHandler;
  LMenuItem := NewItem(SAddToQuickAccessToolbar, 0, False, True, AddToQuickAccessToolbarHandler, 0, '');
  FContextMenu.Items.Add(LMenuItem);
  FContextMenu.Items.Add(NewLine);
  LMenuItem := NewItem(SCustomizeQuickAccessToolbar, 0, False, True, CustomizeQuickAccessToolbarHandler, 0, '');
  FContextMenu.Items.Add(LMenuItem);
  LMenuItem := NewItem(SShowQuickAccessToolbarBelow, 0, False, True, ChangeQuickAccessToolbarPositionHandler, 0, '');
  FContextMenu.Items.Add(LMenuItem);
  FContextMenu.Items.Add(NewLine);
  LMenuItem := NewItem(SMinimizeTheRibbon, 0, False, True, MinimizeRibbonHandler, 0, '');
  FContextMenu.Items.Add(LMenuItem);
end;

procedure TCustomRibbon.CreateParams(var Params: TCreateParams);
begin
  inherited;
  params.Style := params.Style or WS_CLIPCHILDREN;
end;

function TCustomRibbon.CustomFrameSupported: Boolean;
begin
  Result := UseCustomFrame and not IsDesigning;
end;

procedure TCustomRibbon.DrawCustomFrame;
var
  LRect: TRect;
  LCanvas: TCanvas;
  LDC: THandle;
  LFlags: Cardinal;
  LCaptionY: Integer;
  LBorder : Integer;
begin
  if csLoading in ComponentState then
    Exit;
  LFlags := DCX_CACHE or DCX_CLIPSIBLINGS or DCX_WINDOW or DCX_VALIDATE;
  LDC := GetDCEx(FParentForm.Handle, 0, LFlags);
  if LDC = 0 then
    Exit;
  LCaptionY := GetRibbonMetric(rmCaption);
  LBorder := GetRibbonMetric(rmFormBorder);
  LCanvas := TCanvas.Create;
  try
    LCanvas.Handle := LDC;
    if Active then
      Style.DrawElement(sfLeftFrameTop, LCanvas, Rect(0, 0, LBorder, LCaptionY), LCaptionY)
    else
      Style.DrawElement(sfLeftFrameTopDisabled, LCanvas, Rect(0, 0, LBorder, LCaptionY), LCaptionY);

    LRect := Rect(0, LCaptionY, LBorder, FParentForm.ClientHeight);
    if Active then
    begin
      Style.DrawElement(sfLeftFrame, LCanvas, LRect, -1);
      Style.DrawElement(sfRightFrameTop, LCanvas, Rect(FParentForm.Width - LBorder, 0, FParentForm.Width, LCaptionY), LCaptionY);
    end
    else
    begin
      Style.DrawElement(sfLeftFrameDisabled, LCanvas, LRect, -1);
      Style.DrawElement(sfRightFrameTopDisabled, LCanvas, Rect(FParentForm.Width - LBorder, 0, FParentForm.Width, LCaptionY), LCaptionY);
    end;
    LRect := Rect(FParentForm.Width - LBorder, LCaptionY, FParentForm.Width, FParentForm.ClientHeight);
    if Active then
      Style.DrawElement(sfRightFrame, LCanvas, LRect, -1)
    else
      Style.DrawElement(sfRightFrameDisabled, LCanvas, LRect, -1);
    LRect := FParentForm.ClientRect;
    LRect.Top := LRect.Bottom;
    Inc(LRect.Bottom, LBorder);
    Inc(LRect.Right, LBorder*2);
    Style.DrawElement(sfBottomFrame, LCanvas, LRect, -1);
  finally
    LCanvas.Handle := 0;
    LCanvas.Free;
  end;
end;

procedure TCustomRibbon.CustomFrameWndProc(var Message: TMessage);
  function HitTestNCA(Handle : HWND; ptMouse: tpoint) : LRESULT;
  var
    LStyle : LongInt;
    rcWindow : TRect;
    LBorder : Integer;
  begin
    //Only need to check Top, ParentWndProc handled other borders
    LBorder := GetRibbonMetric(rmFormBorder);
    GetWindowRect(Handle, rcWindow);

    Result := HTCLIENT;
    if ptMouse.Y < rcWindow.Top + LBorder then
    begin
      if ptmouse.X < rcWindow.Left + 20 then
        Result := HTTOPLEFT
      else if ptmouse.X > rcWindow.Right - 20 then
        Result := HTTOPRIGHT
      else
        Result := HTTOP;
    end
    else if ptMouse.Y < rcWindow.Top + GetRibbonMetric(rmCaption) then
    begin
      if ptMouse.X < (rcWindow.Left + LBorder + GetSystemMetrics(SM_CXSMICON)) then
        Result := HTSYSMENU
      else
        Result := HTCAPTION
    end;

    LStyle := GetWindowLong(Handle, GWL_STYLE);
    if (Result >= HTLEFT) and (Result < HTBORDER) and
      (WS_SIZEBOX <> (LStyle and WS_SIZEBOX)) then
        Result := HTBORDER;
  end;

var
  LNewRect: TRect;
  LStyle, LExStyle : LongInt;
  Rgn1, Rgn2: HRGN;
begin
  if DwmCompositionEnabled and
   DwmDefWindowProc(parent.Handle, message.Msg, message.WParam, message.LParam, message.Result) then
    exit;
  case Message.Msg of
    WM_NCACTIVATE:
      begin
        Active := TWMNCActivate(Message).Active;
        if DwmCompositionEnabled then
          CallParentWndProc(Message)
        else
        begin
          DrawCustomFrame;
          Message.Result := 1;
        end;
      end;
    WM_NCCALCSIZE:
      begin
        LStyle := GetWindowLong(FParentForm.Handle, GWL_STYLE);
        LExStyle := GetWindowLong(FParentForm.Handle, GWL_EXSTYLE);
        LNewRect := Rect(0,0,0,0);
        AdjustWindowRectEx(LNewRect, LStyle, False, LExStyle);
        with TWMNCCalcSize(Message).CalcSize_Params^.rgrc[0] do
        begin
          Dec(Left, LNewRect.Left);
          Dec(Top, 0);  // No Border on top.
          Dec(Right, LNewRect.Right);
          Dec(Bottom, LNewRect.Bottom);
        end;
      end;
    WM_NCHITTEST:
      begin
        CallParentWndProc(message);
        if CustomFrameSupported and ((Message.Result = HTCLOSE) or
         (message.Result = HTMAXBUTTON) or (Message.Result = HTMINBUTTON)) then
          message.Result := HTCLIENT;

        if message.Result = HTCLIENT then
          with TWMNCHitTest(Message) do
            Result := HitTestNCA(parent.Handle, Point(Pos.x,Pos.y));
      end;
    WM_NCPAINT:
      begin
        if DwmCompositionEnabled then
          CallParentWndProc(Message)
        else
          DrawCustomFrame;
      end;
    WM_NCRBUTTONUP:
      if Message.wParam = HTCAPTION then
      begin
        with TWMNCRButtonUp(Message) do
          ShowSystemMenu(Point(XCursor, YCursor));
      end
      else
        CallParentWndProc(Message);
    WM_SIZE:
      begin
        CallParentWndProc(Message);
        if not (csLoading in ComponentState) then
          CheckRibbonSize;
        DrawCustomFrame;
        SetWindowRgn(parent.Handle, 0, True);
        if not ThemeServices.ThemesEnabled then
        begin
          Rgn1 := CreateRectRgn(0, GetRibbonMetric(rmFormBorder), Parent.Width, parent.Height);
          Rgn2 := CreateRoundRectRgn(0, 0, Parent.Width, Parent.Height,
          GetRibbonMetric(rmFormBorder)*2, GetRibbonMetric(rmFormBorder)*2);
          CombineRgn(Rgn1, Rgn1, Rgn2, RGN_OR);
          DeleteObject(Rgn2);
          SetWindowRgn(parent.Handle, Rgn1, True);
        end;
      end;
    WM_DWMNCRENDERINGCHANGED:
      begin
        FCloseButton.Visible := not BOOL(Message.WParam);
        FRestoreButton.Visible := not BOOL(Message.WParam);
        FMinimizeButton.Visible := not BOOL(Message.WParam);
        CallParentWndProc(Message);
      end;
  else
    CallParentWndProc(Message);
  end;
end;

procedure TCustomRibbon.ContextMenuPopupHandler(Sender: TObject);
var
  LControlIntf: IRibbonControl;
  LCanAdd: Boolean;
begin
  // If neither the Add and Remove menu items aren't visible for the
  // context menu then don't show the item as well as the first separator
  if FContextMenuOptions * [cmoShowAdd, cmoShowRemove] = [] then
  begin
    FContextMenu.Items[0].Visible := False;
    FContextMenu.Items[1].Visible := False;
  end
  else
  begin
    LCanAdd := True;
    if cmoShowRemove in FContextMenuOptions then
      FContextMenu.Items[0].Caption := SRemoveFromQuickAccessToolbar
    else
    begin
      FContextMenu.Items[0].Caption := SAddToQuickAccessToolbar;
      // Check to see if the current control that has been right clicked on
      // is allowed to be added to the Quick Access Toolbar. Some control
      // types are not permitted on the Quick Access Toolbar.
      if (FContextCtrl <> nil) and
        Supports(FContextCtrl, IRibbonControl, LControlIntf) then
        LCanAdd := LControlIntf.CanAddToQuickAccessToolbar;
    end;
    FContextMenu.Items[0].Visible := LCanAdd;
    FContextMenu.Items[1].Visible := LCanAdd;
  end;
  if HasQuickAccessToolbar then
  begin
    if QuickAccessToolbar.Position = qpTop then
      FContextMenu.Items[3].Caption := SShowQuickAccessToolbarBelow
    else
      FContextMenu.Items[3].Caption := SShowQuickAccessToolbarAbove;
  end
  else
  begin
    FContextMenu.Items[0].Enabled := False;
    FContextMenu.Items[2].Enabled := False;
    FContextMenu.Items[3].Enabled := False;
  end;
  FContextMenu.Items[5].Checked := Minimized;
end;

procedure TCustomRibbon.SetParent(AParent: TWinControl);
var
  LCustomFrame : Boolean;
begin
  LCustomFrame := UseCustomFrame;
  UseCustomFrame := False;
  inherited;
  if AParent <> nil then
  begin
    FParentForm := GetParentForm(AParent);
    UseCustomFrame := LCustomFrame;

    if FParentForm is TForm then
      FScaleFactor := TForm(FParentForm).PixelsPerInch / 96;
  end;
end;

function TCustomRibbon.GetRibbonHeight: Integer;
begin
  if Minimized or HideTabs then
    Result := GetRibbonMetric(rmMinHeight)
  else if HideRibbon then
    Result := GetRibbonMetric(rmCaption)
  else
    Result := GetRibbonMetric(rmFullHeight);
  if HasQuickAccessToolbar and (QuickAccessToolbar.Position = qpBottom) then
    Inc(Result, cRibbonQATHeight);
end;

function TCustomRibbon.GetRibbonMetric(const Metric: TRibbonMetric): Integer;
begin
  case Metric of
    rmCaption:            Result := GetCaptionHeight;
    rmFormBorder:         Result := GetSystemMetrics(SM_CYFRAME);
    rmHeight:             Result := GetRibbonHeight;
    rmFullHeight:         Result := cRibbonHeight + GetCaptionHeight;
    rmMinHeight:          Result := cRibbonMinimizedHeight + GetCaptionHeight;
    rmTabTop:             Result := GetCaptionHeight + 24; // XP = 54 { 30 + 24 }
    rmPageHeight:         Result := cRibbonPageHeight;
    rmGroupHeight:        Result := cRibbonGroupHeight;
    rmGroupCaptionHeight: Result := cRibbonGroupCaptionHeight;
    rmQATWidth:
      begin
        Result := ClientWidth;
        if HasApplicationMenu then
          Dec(Result, Menu.Width);

        Dec(Result, width - FMinimizeButton.Left + 6);            
        Dec(Result, cRibbonMinimumCaptionWidth);
        // If we have a negative width we fix it with a 0
        Result := Max( Result, 0);
      end;
    rmSystemButtonHeight:
      begin
        Result := GetSystemMetrics(SM_CYSIZE);
      end;
    rmSystemButtonWidth:
      begin
        Result := GetSystemMetrics(SM_CXSIZE);
      end;
    rmTabHeight: Result := cRibbonTabHeight;
    rmFontSize: Result := Font.Size;
  else
    Result := -1;
  end;
  if not (Metric in [rmSystemButtonHeight, rmSystemButtonWidth]) then
    Result := Round(Result * FScaleFactor);
end;

procedure TCustomRibbon.UpdateQATPosition;
var
  LQATActionBar: TCustomRibbonQuickAccessToolbar;
  LBarWidth: Integer;
  LMaxAllowedWidth: Integer;
begin
  if (csLoading in ComponentState) or not HasQuickAccessToolbar or
    HideRibbon then
    Exit;
  LQATActionBar := FQuickAccessToolbar.ActionBar;
  LBarWidth := FQuickAccessToolbar.BarWidth;
  Height := GetRibbonHeight;
  case FQuickAccessToolbar.Position of
    qpTop:
      begin
        LQATActionBar.Visible := False;
        try
          LQATActionBar.Align := alNone;
          LQATActionBar.Constraints.MaxHeight := 24;
          LQATActionBar.Constraints.MinHeight := 24;

          LMaxAllowedWidth := GetRibbonMetric(rmQATWidth);
          if LBarWidth > LMaxAllowedWidth then
          begin
            LQATActionBar.Constraints.MinWidth := LMaxAllowedWidth;
            LQATActionBar.Constraints.MaxWidth := LMaxAllowedWidth;
            LQATActionBar.ScrollMode := qsMoreControls;
          end
          else
          begin
            LQATActionBar.Constraints.MinWidth := LBarWidth;
            LQATActionBar.Constraints.MaxWidth := LBarWidth;
            LQATActionBar.ScrollMode := qsCustomize;
          end;
          LQATActionBar.VertMargin := 1;
          LQATActionBar.HorzMargin := 0;
          LQATActionBar.ShowBorder := False;
        finally
          LQATActionBar.Visible := True;
        end;
        if CustomFrameSupported then
          LQATActionBar.Top := GetRibbonMetric(rmFormBorder)
        else
          LQATActionBar.Top := 1;
        if BiDiMode = bdLeftToRight then
        begin
          LQATActionBar.Left :=cRibbonQuickAccessToolbarLeft + 15;
          LQATActionBar.Width := Min(LBarWidth, LMaxAllowedWidth);
        end
        else
        begin
          LQATActionBar.Left :=ClientWidth - LBarWidth - (cRibbonQuickAccessToolbarLeft + 15);
          LQATActionBar.Width := Min(LBarWidth, LMaxAllowedWidth);
        end;
      end;
    qpBottom:
      begin
        LQATActionBar.Visible := False;
        try
          LQATActionBar.Align := alBottom;
          LQATActionBar.Anchors := [akLeft, akTop, akRight];
          LQATActionBar.Constraints.MaxHeight := 26;
          LQATActionBar.Constraints.MinHeight := 26;
          LQATActionBar.Constraints.MinWidth := 0;
          LQATActionBar.Constraints.MaxWidth := 0;
          LQATActionBar.HorzMargin := 3;
          LQATActionBar.VertMargin := 2;
          LQATActionBar.ShowBorder := True;
          LQATActionBar.Realign;
        finally
          LQATActionBar.Visible := True;
        end;
      end;
  end;
end;

procedure TCustomRibbon.Idle(const Msg: TMsg);
var
  Done: Boolean;
begin
  Done := True;
  try
    if Assigned(Application.OnIdle) then
      Application.OnIdle(Self, Done);
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

procedure TCustomRibbon.UMCheckResize(var Message: TMessage);
begin
  CheckRibbonSize;
end;

procedure TCustomRibbon.UMDisplayKeyTips(var Message: TMessage);
begin
  if not FKeyTipsVisible then
    DisplayKeyTips(TKeyTipState(Message.LParam));
end;

function TCustomRibbon.ValidTab(const Index: Integer): Boolean;
begin
  Result := (Index > -1) and (Index < Tabs.Count) and (Tabs[Index] <> nil);
end;

function TCustomRibbon.GetStyle: TRibbonStyleActionBars;
begin
  if (ActionManager <> nil) and (ActionManager.Style is TRibbonStyleActionBars) then
  begin
    Result := TRibbonStyleActionBars(ActionManager.Style);
  end
  else
  begin
    Result := RibbonLunaStyle;
    SetStyle(Result);
  end;
  if FCurrentStyle <> Result then
    Invalidate;
  FCurrentStyle := Result;
end;

function TCustomRibbon.GetContextMenuOptions: TContextMenuOptions;
begin
  Result := [cmoRibbon];
end;

function TCustomRibbon.HasApplicationMenu: Boolean;
begin
  Result := (ApplicationMenu.Menu <> nil);
end;

function TCustomRibbon.HasQuickAccessToolbar: Boolean;
var
  I: Integer;
  LActionBar: TActionBarItem;
begin
  Result := (QuickAccessToolbar.ActionBar <> nil) and not HideRibbon;
  if Result then
  begin
                                                      
    Result := False;
    for I := 0 to ActionManager.ActionBars.Count - 1 do
    begin
      LActionBar := ActionManager.ActionBars[I];
      if LActionBar.ActionBar = QuickAccessToolbar.ActionBar then
      begin
        Result := LActionBar.Visible;
        Break;
      end;
    end;
  end;
end;

procedure TCustomRibbon.DoContextPopup(MousePos: TPoint; var Handled: Boolean);
var
  LPt: TPoint;
  LCtrlPt: TPoint;
  LGroup: TCustomRibbonGroup;
  LAC: TActionClientItem;
begin
  if not HasQuickAccessToolbar or (ActionManager = nil) or HideRibbon or
    FHeaderRect.Contains(MousePos) then
    Exit;
  if FContextMenu = nil then
    CreateContextMenu;
  LPt := ClientToScreen(MousePos);
  FContextMenuOptions := GetContextMenuOptions;
  if not Minimized then
  begin
    FContextAction := nil;
    FContextCtrl := nil;
    FContextGroup := nil;
    if ActivePage <> nil then
      LGroup := ActivePage.FindGroupAt(MousePos)
    else
      LGroup := nil;
    if LGroup <> nil then
    begin
      FContextMenuOptions := FContextMenuOptions + [cmoShowAdd];
      LCtrlPt := LGroup.ScreenToClient(LPt);
      FContextCtrl := LGroup.FindItemAt(LCtrlPt);
      if FContextCtrl = nil then
      begin
        if (LGroup.DialogAction <> nil) and LGroup.GetDialogButtonRect.Contains(LCtrlPt) then
          FContextAction := LGroup.DialogAction
        else
          FContextGroup := LGroup;
      end;
    end
    else
    begin
      if HasQuickAccessToolbar then
      begin
        LPt := QuickAccessToolbar.ActionBar.ClientToParent(MousePos);
        if QuickAccessToolbar.ActionBar.BoundsRect.Contains(LPt) then
        begin
          FContextMenuOptions := [cmoQAT, cmoShowRemove];
          LPt := QuickAccessToolbar.ActionBar.ClientToScreen(MousePos);
          LCtrlPt := QuickAccessToolbar.ActionBar.ScreenToClient(LPt);
          FContextCtrl := QuickAccessToolbar.ActionBar.FindItemAt(LCtrlPt);
        end
        else
          LPt := ClientToScreen(MousePos);
      end;
    end;

    FContextMenu.Items[0].Enabled := True;
    if not (cmoShowRemove in FContextMenuOptions) then
    begin
      // Make sure the command doesn't already exist on the Quick Access Toolbar
      if (FContextCtrl <> nil) then
      begin
        LAC := QuickAccessToolbar.ActionBar.FindFirst;
        while LAC <> nil do
        begin
          if (LAC.Action = FContextCtrl.ActionClient.Action) and (LAC.Visible) then
          begin
            FContextMenu.Items[0].Enabled := False;
            Break;
          end;
          LAC := QuickAccessToolbar.ActionBar.FindNext(LAC, False)
        end;
      end
      else if (FContextAction <> nil) then
      begin
        LAC := QuickAccessToolbar.ActionBar.FindFirst;
        while LAC <> nil do
        begin
          if LAC.Action = FContextAction then
          begin
            FContextMenu.Items[0].Enabled := False;
            Break;
          end;
          LAC := QuickAccessToolbar.ActionBar.FindNext(LAC, False)
        end;
      end
      else if (FContextGroup <> nil) and (FQuickAccessToolbarGroups <> nil) then
      begin
        FContextMenu.Items[0].Enabled := not FQuickAccessToolbarGroups.Exists(FContextGroup.Caption);
      end;
    end;
  end;
  FContextMenu.Popup(LPt.X, LPt.Y);
  Handled := True;
end;

procedure TCustomRibbon.ShowSystemMenu(const LPt: TPoint);
var
  LMenu: HMENU;
  LFlags: Cardinal;
  LCommand: LongWord;
begin
  LMenu := GetSystemMenu(FParentForm.Handle, False);
  LFlags := TPM_RETURNCMD or GetSystemMetrics(SM_MENUDROPALIGNMENT);
  LCommand := LongWord(TrackPopupMenu(LMenu, LFlags, LPt.X, LPt.Y, 0, FParentForm.Handle, nil));
  PostMessage(FParentForm.Handle, WM_SYSCOMMAND, LCommand, 0);
end;

const
  SC_DRAGMOVE = $F012;

procedure TCustomRibbon.MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  begin
    TestTabScrollButtonClick(Shift);
  end;
  InvalidateScrollButtons;
end;

procedure TCustomRibbon.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TCustomRibbon.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TCustomRibbon.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  AllowKeyboardNavigation := False;
  if Minimized and not KeyTipsVisible then
  begin
    if ActivePage <> nil then
      ActivePage.Visible := False
    else if TabIndex > -1 then
      Tabs.GetItem(TabIndex).Page.Visible := False;
    FIgnoreTabChange := True;
    try
      TabIndex := -1;
    finally
      FIgnoreTabChange := False;
    end;
  end;
end;

procedure TCustomRibbon.WMNCHitTest(var Message: TWMNCHitTest);
var
  ptMouse : TPoint;
begin
  ptMouse := ScreenToClient(Point(message.XPos, message.YPos));
  if not IsDesigning and (ptMouse.Y < GetRibbonMetric(rmCaption)) then
    Message.Result := HTTRANSPARENT
  else
    Message.result := HTCLIENT;
end;

procedure TCustomRibbon.WMPaint(var Message: TWMPaint);
var
  DC, MemDC: HDC;
  PS: TPaintStruct;
  PaintBuffer: HPAINTBUFFER;
  aRect : TRect;
begin
  if not (csDesigning in ComponentState) and DoubleBuffered and DwmCompositionEnabled then
  begin
    DC := BeginPaint(Handle, PS);
    try
      PaintBuffer := BeginBufferedPaint(DC, PS.rcPaint, BPBF_COMPOSITED, nil, MemDC);
      if PaintBuffer <> 0 then
        try
          Perform(WM_PRINTCLIENT, WParam(MemDC), PRF_CLIENT);
          arect := ClientRect;
          if CustomFrameSupported then
            inc(arect.top, GetRibbonMetric(rmCaption));
          BufferedPaintMakeOpaque(PaintBuffer, aRect);
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

procedure TCustomRibbon.WMSettingChange(var Message: TWMSettingChange);
begin
  RebuildRibbonMetrics;
  Invalidate;
end;

procedure TCustomRibbon.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if not (csLoading in ComponentState) and not UseCustomFrame then
    PostMessage(Handle, UM_CHECKSIZE, 0, 0);
end;

procedure TCustomRibbon.WriteStyleProp(Writer: TWriter);
var
  AStyle: TActionBarStyle;
begin
  if Assigned(Style) then
    AStyle := Style
  else
    AStyle := ActionBarStyles.Style[0];
  Writer.WriteString(AStyle.GetStyleName);
end;

// Used to rehide the tabs once KeyTips mode has been exited
procedure TCustomRibbon.CheckAndResetMinimizedState;
begin
  if Minimized then
  begin
    FIgnoreTabChange := True;
    try
      TabIndex := -1;
    finally
      FIgnoreTabChange := False;
    end;
  end;
end;

procedure TCustomRibbon.CheckRibbonSize;
begin
  HideRibbon := (FParentForm.ClientHeight <= cRibbonHideHeight) or
    (FParentForm.ClientWidth < cRibbonHideWidth);
end;

// Check to see if cursor coordinates are within a tabs bounds. If a tab
// is within the coordinates, change tabs
procedure TCustomRibbon.CheckTabChange(X, Y: Integer);
var
  LNewTabIndex: Integer;
  LAllowChange: Boolean;
begin
  LNewTabIndex := GetTabAt(X, Y);
  if (LNewTabIndex > -1) and (LNewTabIndex <> FTabIndex) then
  begin
    LAllowChange := True;
    DoTabChange(LNewTabIndex, FTabIndex, LAllowChange);
    if LAllowChange then
    begin
      TabIndex := LNewTabIndex;
      InvalidateTabArea;
    end;
  end;
end;

// Clear any group references and free the created group list if created.
procedure TCustomRibbon.CleanupQuickAccessToolbarGroups;
begin
  if FQuickAccessToolbarGroups <> nil then
    FQuickAccessToolbarGroups.Clean;
  FQuickAccessToolbarGroups.Free;
end;

// Clear the list of Recent Items that appear in the Application Menu
//
// When you call ClearRecentItems all of the items listed in the right pane of
// the Application Menu are removed.
//
// To add new items to the right pane, call the AddRecentItem method
procedure TCustomRibbon.ClearRecentItems;
var
  LItems: TOptionItems;
begin
  if HasApplicationMenu then
  begin
    LItems := Menu.RecentItems;
    if LItems <> nil then
      LItems.Clear;
  end;
end;

// Removes the tab with the specified caption
// Remove Tab calls DeleteTab internally and deletes the associated page
// and any groups on that page
procedure TCustomRibbon.RemoveTab(const ACaption: string);
var
  LIdx: Integer;
begin
  LIdx := FTabs.IndexOfCaption(ACaption);
  if LIdx > -1 then
  begin
    DeleteTab(LIdx);
  end;
  if FUpdateCount = 0 then
    InvalidateTabArea;
end;

procedure TCustomRibbon.ReadStyleProp(Reader: TReader);
var
  StyleName: string;
begin
  StyleName := Reader.ReadString;
  if StyleName <> '' then
  try
    if ActionBarStyles.Style[ActionBarStyles.IndexOf(StyleName)] is TRibbonStyleActionBars then
      Style := TRibbonStyleActionBars(ActionBarStyles.Style[ActionBarStyles.IndexOf(StyleName)])
    else
      Style := RibbonLunaStyle;
  except
    if csDesigning in ComponentState then
      if Assigned(System.Classes.ApplicationHandleException) then
        System.Classes.ApplicationHandleException(ExceptObject)
      else
        ShowException(ExceptObject, ExceptAddr)
    else
      raise;
  end;
end;

procedure TCustomRibbon.RebuildRibbonMetrics;
var
  I: Integer;
begin
  for I := 0 to Tabs.Count - 1 do
  begin
    if Tabs[I].Page <> nil then
    begin
      Tabs[I].Page.Font := Font;
      Tabs[I].Page.Canvas.Font := Font;
      Tabs[I].Page.Canvas.Font.Size := GetRibbonMetric(rmFontSize);
    end;
    Tabs[I].Modified := True;
  end;
  FTabData.CalculateTabWidths(Width - cRibbonFirstTabOffSet - GetRibbonMetric(rmCaption),
    FTabs);
  InvalidateTabArea;
end;

procedure TCustomRibbon.RecentActionHandler(Sender: TObject);
begin
  DoRecentItemClick(TAction(Sender).Caption, TAction(Sender).Tag);
end;

procedure TCustomRibbon.Resize;
begin
  inherited;
  if csDestroying in ComponentState then
    Exit;
  if ShowHelpButton then
    FHelpButton.BoundsRect := GetHelpButtonRect;
  if not (csLoading in ComponentState) then
    RebuildRibbonMetrics;

  DrawSystemButtons;

  UpdateQATPosition;
  HideKeyTips;
end;

procedure TCustomRibbon.SetActivePage(const Value: TCustomRibbonPage);
begin
  if Value <> nil then
    TabIndex := Value.Index;
end;

procedure TCustomRibbon.SetAllowKeyboardNavigation(const Value: Boolean);
begin
  if FAllowKeyboardNavigation <> Value then
  begin
    FAllowKeyboardNavigation := Value;
    DrawTab(TabIndex);
  end;
end;

procedure TCustomRibbon.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    InvalidateHeaderArea;
    HideKeyTips;
  end;
end;

procedure TCustomRibbon.CallParentWndProc(var Message: TMessage);
begin
  if Assigned(FParentWndProc) then
    FParentWndProc(Message);
end;

procedure TCustomRibbon.SetColorMap(const Value: TCustomActionBarColorMap);
var
  I: Integer;
  J: Integer;
  LPage: TCustomRibbonPage;
begin
  FreeAndNil(FDefaultColorMap);
  FColorMap := Value;
  if Value <> nil then
    Value.FreeNotification(Self)
  else
    FColorMap := FDefaultColorMap;
  for I := 0 to FTabs.Count - 1 do
  begin
    LPage := FTabs[I].Page;
    if LPage <> nil then
    begin
      for J := 0 to LPage.GroupCount - 1 do
        LPage.Groups[J].ColorMap := FColorMap;
    end;
  end;
end;

procedure TCustomRibbon.SetDocumentName(const Value: string);
var
  LRect: TRect;
begin
  if FDocumentName <> Value then
  begin
    FDocumentName := Value;
    LRect := Rect(0, 0, Width, GetRibbonMetric(rmCaption));
    InvalidateRect(Handle, {$IFNDEF CLR}@{$ENDIF}LRect, True);
  end;
end;

// This property is set internally by the CheckRibbonSize method.
//
// The Ribbon is supposed to be automatically hidden when the parent form
// reaches certain dimensions. If you are not using a Custom Frame then you
// should call the Ribbons CheckRibbonSize method in the OnResize handler
// of the form that the ribbon is parented on.
procedure TCustomRibbon.SetHideRibbon(const Value: Boolean);
begin
  if FHideRibbon <> Value then
  begin
    ApplicationMenu.Show(not Value);
    QuickAccessToolbar.Show(not Value);
    FHideRibbon := Value;
    Height := GetRibbonHeight;
  end;
end;

// Set the height of the Ribbon according to the value of HideRibbon.
//
// When HideTabs is True, Only the header portion of the Ribbon is visible.
// The header of the Ribbon contains the Application Button, Quick Access Toolbar,
// Help button (if the ShowHelpButton property is True) and the system buttons.
// The default value for HideTabs is False.
procedure TCustomRibbon.SetHideTabs(const Value: Boolean);
begin
  if FHideTabs <> Value then
  begin
    FHideTabs := Value;
    if ActivePage <> nil then
      ActivePage.Visible := not Value;
    Height := GetRibbonHeight;
  end;
end;

procedure TCustomRibbon.SetHotTabIndex(const Value: Integer);
begin
  if FHotTabIndex <> Value then
  begin
    FHotTabIndex := Value;
    InvalidateTabArea;
  end;
end;

procedure TCustomRibbon.SetMinimized(const Value: Boolean);
var
  I: Integer;
begin
  if FMinimized <> Value then
  begin
    FMinimized := Value;
    if not FMinimized then
    begin
      if QuickAccessToolbar.Position = qpTop then
        Height := GetRibbonMetric(rmFullHeight)
      else
        Height := GetRibbonMetric(rmFullHeight) + cRibbonQATHeight;
      if ActivePage <> nil then
      begin
        TabIndex := ActivePage.Index;
        ActivePage.Parent := Self;
      end
      else if FTabs.Count > 0 then
        TabIndex := 0;
      if ActivePage <> nil then
        ActivePage.Invalidate;
    end
    else
    begin
      Height := GetRibbonHeight;
      for I := 0 to Tabs.Count - 1 do
        Tabs[I].Page.Visible := False;
      FIgnoreTabChange := True;
      TabIndex := -1;
    end;
  end;
end;

procedure TCustomRibbon.SetTabs(const Value: TRibbonTabs);
begin
  FTabs.Assign(Value);
  Invalidate;
end;

procedure TCustomRibbon.SetKeyTipsVisible(const Value: Boolean);
begin
  if FKeyTipsVisible <> Value then
  begin
    FKeyTipsVisible := Value;
    InvalidateTabArea;
  end;
end;

procedure TCustomRibbon.SetQuickAccessToolbar(const Value: TQuickAccessToolbar);
begin
  FQuickAccessToolbar.Assign(Value);
end;

procedure TCustomRibbon.SetApplicationMenu(const Value: TApplicationMenu);
begin
  FApplicationMenu.Assign(Value);
end;

procedure TCustomRibbon.SetActionManager(const Value: TCustomActionManager);
var
  I: Integer;
begin
  if FActionManager <> Value then
  begin
    FActionManager := Value;
    if Value <> nil then
      FActionManager.FreeNotification(Value);
    if HasApplicationMenu then
    begin
      Menu.ActionManager := FActionManager;
      ApplicationMenu.Initialize(FScreenTips);
    end;
    if HasQuickAccessToolbar then
      FQuickAccessToolbar.ActionBar.ActionManager := FActionManager;
    for I := 0 to Tabs.Count - 1 do
    begin
      if Tabs[I].Page <> nil then
        Tabs[I].Page.UpdateActionManager(Value);
    end;
  end;
end;

procedure TCustomRibbon.SetScreenTips(const Value: TCustomScreenTipsManager);
begin
  if FScreenTips <> Value then
  begin
    FScreenTips := Value;
  end;
end;

procedure TCustomRibbon.SetShowHelpButton(const Value: Boolean);
begin
  if FShowHelpButton <> Value then
  begin
    FShowHelpButton := Value;
    if Value and (FHelpButton = nil) then
    begin
      FHelpButton := THelpButton.Create(Self);
      FHelpButton.Parent := Self;
      FHelpButton.OnClick := HelpButtonClickHandler;
    end
    else if not Value then
      FreeAndNil(FHelpButton);
    if Canvas.HandleAllocated then
      Invalidate;
    if FHelpButton <> nil then
      FHelpButton.BoundsRect := GetHelpButtonRect;
  end;
end;

procedure TCustomRibbon.SetStyle(const Value: TRibbonStyleActionBars);
begin
  if ActionManager <> nil then
  begin
    if (Value = nil) or not (Value is TRibbonStyleActionBars) then
      ActionManager.Style := RibbonLunaStyle
    else
      ActionManager.Style := Value;
    // Force the recreation of the correct colormap for the selected style
    SetColorMap(nil);
    Invalidate;
    DoGroupStyleChanged;
    FParentForm.Perform(WM_NCPAINT, 0, 0);
  end;
end;

procedure TCustomRibbon.SetUseCustomFrame(const Value: Boolean);
begin
  if FUseCustomFrame <> Value then
  begin
    // Reset the previous WndProc
    if not IsDesigning and Assigned(FParentWndProc)
      and Assigned(FParentForm) and FUseCustomFrame then
    begin
      FParentForm.WindowProc := FParentWndProc;
      FParentWndProc := nil;
    end;
    FUseCustomFrame := Value;
    if not IsDesigning and (FParentForm <> nil) then
    begin
      FCaptionHeight := -1;
      if HasApplicationMenu then
      begin
        if CustomFrameSupported then
          Menu.Top := GetRibbonMetric(rmFormBorder)
        else
          Menu.Top := 0;
      end;
      if Value then
      begin
        FParentform.StyleElements := FParentform.StyleElements - [seBorder];
        FParentWndProc := FParentForm.WindowProc;
        FParentform.WindowProc := CustomFrameWndProc;
        FParentForm.GlassFrame.Enabled := True;
        FParentForm.GlassFrame.Top := GetRibbonMetric(rmCaption);
      end;
      if ComponentState * [csLoading] = [] then
        FParentForm.Perform(CM_RECREATEWND, 0,0);
    end;
  end;
end;

procedure TCustomRibbon.SetTabIndex(const Value: Integer);
var
  LPage: TCustomRibbonPage;
  LPrevTabIndex: Integer;
begin
  if Tabs.Count = 0 then
    Exit;

  if ((Value < 0) and not Minimized) or (Value > Tabs.Count - 1) then
    raise ERibbonException.Create(SRibbonTabIndexInvalid);

  if Minimized and FIgnoreTabChange and not KeyTipsVisible then
  begin
    FTabIndex := -1;
    InvalidateTabArea;
    FIgnoreTabChange := True;
    Exit;
  end;

  if FTabIndex <> Value then
  begin
    LPrevTabIndex := FTabIndex;
    FTabIndex := Value;
    if (FTabIndex > -1) and (FTabs[FTabIndex].Page <> nil) then
    begin
      LPage := FTabs[FTabIndex].Page;
      if not Minimized then
      begin
        // Show the new tab
        LPage.Parent := Self;
        LPage.Visible := True;
        RebuildRibbonMetrics;
        LPage.BringToFront;
        DrawTab(Value);
      end
      else
      begin
        LPage.Visible := True;
        LPage.Parent := GetParentForm(Self);
        LPage.Ribbon := Self;
        RebuildRibbonMetrics;
        LPage.BringToFront;
        Winapi.Windows.SetFocus(Handle);
        FIgnoreTabChange := True;
      end;
    end;
    // Hide the previously visible page
    if (LPrevTabIndex > -1) and (FTabs.Count > LPrevTabIndex) and
      (FTabs[LPrevTabIndex].Page <> nil) and
      (FTabs[LPrevTabIndex].Page <> nil) then
    begin
      FTabs[LPrevTabIndex].Page.Visible := False;
    end;
  end;
  InvalidateTabArea;
end;

procedure TCustomRibbon.AddToQuickAccessToolbarHandler(Sender: TObject);
begin
  DoAddToQuickAccessToolbar;
end;

procedure TCustomRibbon.CustomizeQuickAccessToolbarHandler(Sender: TObject);
begin
  DoCustomizeQuickAccessToolbar;
end;

procedure TCustomRibbon.ChangeQuickAccessToolbarPositionHandler(Sender: TObject);
begin
  DoChangeQuickAccessToolbarPosition;
end;

procedure TCustomRibbon.MinimizeRibbonHandler(Sender: TObject);
begin
  DoMinimizeRibbon;
end;

procedure TCustomRibbon.DoMinimizeRibbon;
begin
  Minimized := not Minimized;
  FContextMenuOptions := [];
end;

// Adds or Removes the selected Control or Group to the Quick Access Toolbar
// The control or group to be added is determined in the DoContextPopup method
//
// If FContextMenuOptions contains cmoShowAdd then the command will be added
// If FContextMenuOptions contains cmoShowRemove then the command will be removed
procedure TCustomRibbon.DoAddToQuickAccessToolbar;
var
  LItem: TActionClientItem;
  LDelIdx: Integer;
  LGroup: TCustomRibbonGroup;
  I: Integer;
  LGroupItem: TQuickAccessToolbarGroupItem;
  LItemAdded: Boolean;
begin
  if ((FContextCtrl <> nil) and (FContextCtrl.Action <> nil)) or
    (FContextAction <> nil) or (FContextGroup <> nil) then
  begin
    if (cmoShowAdd in FContextMenuOptions) then
    begin
      // Add the control to the Quick Access Toolbar
      if FContextCtrl <> nil then
      begin
        LItemAdded := False;
        // Make sure the item isn't just being hidden on the Quick Access Toolbar
        LItem := QuickAccessToolbar.ActionBar.FindFirst;
        while LItem <> nil do
        begin
          if LItem.Action = FContextCtrl.Action then
          begin
            if not LItem.Visible then
            begin
              LItem.Visible := True;
              LItemAdded := True;
            end;
          end;
          LItem := QuickAccessToolbar.ActionBar.FindNext(LItem, False)
        end;
        if not LItemAdded then
        begin
          LItem := QuickAccessToolbar.ActionBar.Items.Add;
          LItem.Assign(FContextCtrl.ActionClient);
          LItem.CommandProperties.Assign(FContextCtrl.ActionClient.CommandProperties);
          if LItem.CommandStyle in [csButton, csGallery] then
          begin
            TButtonProperties(LItem.CommandProperties).GroupPosition := gpNone;
            TButtonProperties(LItem.CommandProperties).ButtonSize := bsSmall;
          end;
          LItem.ImageIndex := (FContextCtrl.ActionClient as TActionClientItem).ImageIndex;
          LItem.ShowCaption := False;
        end;
      end
      else if FContextAction <> nil then
      begin
        LItem := QuickAccessToolbar.ActionBar.Items.Add;
        LItem.Action := FContextAction;
        LItem.ShowCaption := False;
      end
      else
      begin
        if FContextGroup <> nil then
        begin
          if FQuickAccessToolbarGroups = nil then
            FQuickAccessToolbarGroups := TQuickAccessToolbarGroups.Create(ActionManager.Images);
          LGroup := FContextGroup.Clone;
          if LGroup <> nil then
          begin
            LGroupItem := FQuickAccessToolbarGroups.Add(LGroup);
            if LGroupItem <> nil then
            begin
              LItem := QuickAccessToolbar.ActionBar.Items.Add;
              LItem.Caption := FContextGroup.Caption;
              LItem.CommandStyle := csButton;
              LItem.Tag := 100;
              LItem.Action := LGroupItem.Action;
              LItem.ShowCaption := False;
            end;
          end;
        end;
      end;
    end
    else
    begin
      if FContextCtrl <> nil then
      begin
        LDelIdx := FContextCtrl.ActionClient.Index;
        if LDelIdx > -1 then
        begin
          if FContextCtrl.ActionClient.Tag = 100 then
            FQuickAccessToolbarGroups.Remove(FContextCtrl.ActionClient.Caption);
          if QuickAccessToolbar.ActionBar.Items.Count > LDelIdx then
            QuickAccessToolbar.ActionBar.Items.Delete(LDelIdx);
        end;
      end;
    end;
    QuickAccessToolbar.ActionBar.RecreateControls;
    for I := 0 to QuickAccessToolbar.ActionBar.Items.Count - 1 do
    begin
      LItem := QuickAccessToolbar.ActionBar.Items[I];
      if (LItem <> nil) and (LItem.Tag = 100) then
      begin
        (LItem.Control as TRibbonGroupDropDown).Group :=
          FQuickAccessToolbarGroups.Group(StripHotKey(LItem.Caption));
      end;
    end;
    UpdateQATPosition;
    InvalidateHeaderArea;
  end;
  FContextMenuOptions := [];
end;

procedure TCustomRibbon.DoCustomizeQuickAccessToolbar;
begin
  if HasQuickAccessToolbar then
    QuickAccessToolbar.ActionBar.Customize;
  FContextMenuOptions := [];
end;

procedure TCustomRibbon.DoGroupStyleChanged;
var
  I: Integer;
  J: Integer;
  LPage: TCustomRibbonPage;
begin
  for I := 0 to Tabs.Count - 1 do
  begin
    LPage := Tabs[I].Page;
    if LPage <> nil then
    begin
      for J := 0 to LPage.GroupCount - 1 do
        LPage.Groups[J].StyleChanged(Style);
    end;
  end;
end;

procedure TCustomRibbon.DoChangeQuickAccessToolbarPosition;
begin
  QuickAccessToolbar.TogglePosition;
  FContextMenuOptions := [];
end;

{ TCustomRibbonPage }

procedure TCustomRibbonPage.AddGroup(const Group: TCustomRibbonGroup);
begin
  if FGroups.IndexOf(Group) = -1 then
  begin
    Group.GroupIndex := FGroups.Add(Group);
    AlignGroups;
    FScrollLeft.BringToFront;
    FScrollRight.BringToFront;
  end;
end;

function SortByGroupIndexLTR(Item1, Item2: Pointer): Integer;
begin
  Result := TCustomRibbonGroup(Item1).GroupIndex - TCustomRibbonGroup(Item2).GroupIndex;
end;

function SortByGroupIndexRTL(Item1, Item2: Pointer): Integer;
begin
  Result := TCustomRibbonGroup(Item2).GroupIndex - TCustomRibbonGroup(Item1).GroupIndex;
end;

procedure TCustomRibbonPage.AlignGroups;
var
  LLeft: Integer;
  I: Integer;
  LGroup: TCustomRibbonGroup;
begin
  if FGroups = nil then
    Exit;
  if BiDiMode = bdLeftToRight then
    FGroups.Sort(SortByGroupIndexLTR)
  else
    FGroups.Sort(SortByGroupIndexRTL);
  LLeft := FGroupOffset + cRibbonGroupLeftOffset;
  for I := 0 to FGroups.Count - 1 do
  begin
    LGroup := Groups[I];
    if LGroup.GroupVariant <> rgvCollapsed then
    begin
      LGroup.Left := LLeft;
      Inc(LLeft, LGroup.Width + cRibbonGroupSpacing);
    end
    else
    begin
      LGroup.Left := -MAXINT;
      if LGroup.FCollapsedControl <> nil then
      begin
        LGroup.FCollapsedControl.Left := LLeft;
        Inc(LLeft, LGroup.FCollapsedControl.Width + cRibbonGroupSpacing);
      end;
    end;
  end;
  if Parent <> nil then
    UpdateScrollButtons;
end;

procedure TCustomRibbonPage.CMControlListChanging(var Message: TCMControlListChanging);
begin
  if Message.Inserting and (Message.ControlListItem^.Parent = Self) and
     not ((Message.ControlListItem^.Control is TCustomRibbonGroup) or
         (Message.ControlListItem^.Control is TRibbonGroupScrollButton) or
         (Message.ControlListItem^.Control is TRibbonGroupCollapsedControl)) then
    raise Exception.CreateRes(@SInvalidRibbonPageChild);
  if not (csLoading in ComponentState) then
  begin
    if Message.Inserting and (Message.ControlListItem^.Control is TCustomRibbonGroup) then
      AddGroup(TCustomRibbonGroup(Message.ControlListItem^.Control));
  end;
end;

procedure TCustomRibbonPage.CMTextchanged(var Message: TMessage);
begin
  inherited;
  if (Index > -1) and (Ribbon <> nil) then
  begin
    Ribbon.Tabs[Index].Caption := Caption;
    Ribbon.RebuildRibbonMetrics;
    Ribbon.InvalidateTabArea;
  end;
end;

procedure TCustomRibbonPage.CollapseGroup(const Group: TCustomRibbonGroup);
begin
  FCollapsedGroups.Push(Group);
end;

constructor TCustomRibbonPage.Create(AOwner: TComponent);
begin
  inherited;
  FGroups := TList.Create;
  Anchors := [akTop, akRight, akLeft];
  Top := 54;
  Caption := '';
  FIndex := -1;
  FGroupOffset := 0;
  FScrollLeft := CreateScrollButton(sdLeft);
  FScrollRight := CreateScrollButton(sdRight);
  FCollapsedGroups := TStack.Create;
  ControlStyle := ControlStyle + [csAcceptsControls] - [csSetCaption];
end;

function TCustomRibbonPage.CreateScrollButton(
  const Direction: TScrollDirection): TRibbonGroupScrollButton;
begin
  Result := TRibbonGroupScrollButton.Create(Self);
  Result.Parent := Self;
  if Direction = sdRight then
    Result.Align := alRight
  else
    Result.Align := alLeft;
  Result.Height := Height;
  Result.Direction := Direction;
  Result.RibbonStyle := RibbonStyle;
  Result.Visible := False;
  Result.OnClick := ScrollButtonClickHandler;
end;

destructor TCustomRibbonPage.Destroy;
begin
  FreeAndNil(FGroups);
  FreeAndNil(FScrollLeft);
  FreeAndNil(FScrollRight);
  FreeAndNil(FCollapsedGroups);
  // Remove page reference from tabs collection
  if (FRibbon <> nil) and not (csDestroying in FRibbon.ComponentState) then
    FRibbon.FixUpTabList(Self);
  inherited;
end;

procedure TCustomRibbonPage.DoScrollButtonClick(const Direction: TScrollDirection);
var
  LGroupWidth: Integer;
begin
  LGroupWidth := GetGroupWidth;
  if LGroupWidth < Width then
    Exit;
  if Direction = sdLeft then
  begin
    if GroupOffSet < Width then
      GroupOffset := 0
    else
      GroupOffSet := GroupOffSet + Width;
  end
  else
  begin
    if GroupOffSet < Width then
      GroupOffset := Width - LGroupWidth
    else
      GroupOffSet := GroupOffSet - Width - 3;
  end;
  UpdateScrollButtons;
end;

function TCustomRibbonPage.FindGroup(const GroupCaption: string): TControl;
var
  I: Integer;
begin
  for I := 0 to GroupCount - 1 do
  begin
    if SameText(Groups[I].Caption, GroupCaption) then
      Exit(Groups[I]);
  end;
  Result := nil;
end;

function TCustomRibbonPage.GetCollapseGroupCount: Integer;
begin
  Result := FCollapsedGroups.Count;
end;

function TCustomRibbonPage.GetGroup(Index: Integer): TCustomRibbonGroup;
begin
  if (Index > -1) and (Index < FGroups.Count) then
    Result := FGroups[Index]
  else
    Result := nil;
end;

function TCustomRibbonPage.GetGroupCount: Integer;
begin
  Result := FGroups.Count;
end;

function TCustomRibbonPage.GetGroupPos(Ignore: TControl): Integer;
var
  I: Integer;
begin
  Result := cRibbonGroupLeftOffset;
  if Ignore = nil then
  begin
    if GroupCount > 0 then
      Inc(result, Groups[GroupCount - 1].Left + Groups[GroupCount - 1].GetGroupWidth);
  end
  else
  begin
    for I := 0 to GroupCount - 1 do
    begin
      if (Groups[I] <> Ignore) then
        Inc(result, Groups[I].GetGroupWidth + cRibbonGroupSpacing);
    end;
  end;
end;

function TCustomRibbonPage.GetGroupWidth: Integer;
var
  I: Integer;
  LGroup: TCustomRibbonGroup;
begin
  Result := cRibbonGroupLeftOffset; // Default Left position of the first group
  for I := 0 to FGroups.Count - 1 do
  begin
    LGroup := TCustomRibbonGroup(FGroups[I]);
    if LGroup.GroupVariant <> rgvCollapsed then
      Inc(Result, LGroup.Width + 3)
    else
      Inc(Result, LGroup.FCollapsedControl.Width + 3);
  end;
end;

function TCustomRibbonPage.GetNextVisibleGroup: TCustomRibbonGroup;
begin
  Result := TCustomRibbonGroup(FCollapsedGroups.Pop);
end;

function TCustomRibbonPage.GetPageHeight: Integer;
begin
  if Ribbon <> nil then
    Result := Ribbon.GetRibbonMetric(rmPageHeight)
  else
    Result := TCustomRibbon.cRibbonPageHeight;
end;

function TCustomRibbonPage.GetPageTop: Integer;
begin
  if Ribbon <> nil then
    Result := Ribbon.GetRibbonMetric(rmTabTop)
  else
    Result := 54;
end;

procedure TCustomRibbonPage.HandleKeyTips(const KeyTip: string;
  var KeyTips: TKeyTipList);
var
  LIntf: IRibbonKeyTip;
  LBarIntf: IRibbonBarKeyTip;
  LHandled: TKeyTipHandled;
  LGroup: TCustomRibbonGroup;
  I: Integer;
begin
  for I := 0 to GroupCount - 1 do
  begin
    LGroup := Groups[I];
    if Supports(LGroup, IRibbonKeyTip, LIntf) then
    begin
      LIntf.HandleKeyTip(KeyTip, LHandled);
      if LHandled <> ktNone then
      begin
        if LGroup.GroupVariant = rgvCollapsed then
          KeyTips.Add(mtCollapsed, LHandled, LGroup.CollapsedControl)
        else
          KeyTips.Add(mtDialogButton, LHandled, LGroup);
      end;
    end;
    if Supports(LGroup, IRibbonBarKeyTip, LBarIntf) then
      LBarIntf.BarHandleKeyTips(KeyTip, KeyTips);
  end;
end;

procedure TCustomRibbonPage.HideKeyTips(KeyTips: TKeyTipList);
var
  I, J: Integer;
  LBarIntf: IRibbonBarKeyTip;
  LKeyTipMatch: string;
  LHideKeyTip: Boolean;
  LIntf: IRibbonKeyTip;
  LGroup: TCustomRibbonGroup;
begin
  for I := 0 to GroupCount - 1 do
  begin
    LGroup := Groups[I];
    if Supports(LGroup, IRibbonKeyTip, LIntf) then
    begin
      LHideKeyTip := True;
      if KeyTips <> nil then
      begin
        for J := 0 to KeyTips.Count - 1 do
        begin
          if (KeyTips[J].Control <> nil) and KeyTips[J].Control.Equals(LGroup) then
          begin
            LHideKeyTip := False;
            Break;
          end;
        end;
      end;
      if LHideKeyTip then
      begin
        if KeyTips = nil then
          LKeyTipMatch := ''
        else
          LKeyTipMatch := KeyTips.Current;
        LIntf.HideKeyTip(LKeyTipMatch);
      end;
    end;
    if Supports(LGroup, IRibbonBarKeyTip, LBarIntf) then
      LBarIntf.BarHideKeyTips(KeyTips);
  end;
end;

procedure TCustomRibbonPage.Invalidate;
var
  I: Integer;
begin
  inherited;
  for I := 0 to ControlCount - 1 do
    Controls[I].Invalidate;
end;

procedure TCustomRibbonPage.Loaded;
var
  I: Integer;
begin
  inherited;
  // Add all group controls into a list
  for I := 0 to ControlCount - 1 do
  begin
    if Controls[I] is TCustomRibbonGroup then
    begin
      FGroups.Add(Controls[I]);
    end;
  end;
  for I := 0 to FGroups.Count - 1 do
    TCustomRibbonGroup(FGroups[I]).GroupVariant := rgvLarge;
  if (FScrollLeft <> nil) and (FScrollRight <> nil) then
  begin
    // Make sure the scroll buttons are on top in the z order
    FScrollLeft.BringToFront;
    FScrollRight.BringToFront;
  end;
  AlignGroups;
end;

function TCustomRibbonPage.FindGroupAt(const Pt: TPoint): TCustomRibbonGroup;
var
  I: Integer;
  LPt: TPoint;
  LRect: TRect;
  LGroupPt: TPoint;
begin
  LPt := Ribbon.ClientToScreen(Pt);
  for I := 0 to FGroups.Count - 1 do
  begin
    Result := TCustomRibbonGroup(FGroups[I]);
    LGroupPt := Result.ClientToScreen(Point(0, 0));
    LRect := Rect(LGroupPt.X, LGroupPt.Y, LGroupPt.X + Result.Width, LGroupPt.Y + Result.Height);
    if LRect.Contains(LPt) then
      Exit;
  end;
  Result := nil;
end;

procedure TCustomRibbonPage.Notification(AComponent: TComponent; Operation: TOperation);
var
  LIdx: Integer;
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FRibbon then
      FRibbon := nil
    else if AComponent is TCustomRibbonGroup then
    begin
      if not (csDestroying in ComponentState) and
        (FRibbon <> nil) and not (csDestroying in FRibbon.ComponentState) then
      begin
        LIdx := FGroups.IndexOf(AComponent);
        if LIdx > -1 then
          FGroups.Delete(LIdx);
        AlignGroups;
      end;
    end;
  end;
end;

procedure TCustomRibbonPage.Paint;
var
  LRect: TRect;
  LCaptionY: Integer;
begin
  Canvas.Font := Font;
  Canvas.Font.Size := FRibbon.GetRibbonMetric(rmFontSize);
  LRect := ClientRect;
  // Draw the background element
  Dec(LRect.Top, Top);
  if Ribbon = nil then
    LCaptionY := GetSystemMetrics(SM_CYCAPTION) + GetSystemMetrics(SM_CYFRAME)
  else
    LCaptionY := Ribbon.GetRibbonMetric(rmCaption);
  RibbonStyle.DrawElement(srBody, Canvas, LRect, LCaptionY);
  // Draw the page element
  LRect := ClientRect;
  Dec(LRect.Bottom, 2);
  RibbonStyle.DrawElement(srPage, Canvas, LRect, -1);
  if (FRibbon <> nil) and (FRibbon.ActivePage <> nil) then
  begin
    if (FRibbon.ActivePage.Index >= FRibbon.FTabData.FirstVisibleTabIndex) and
      (FRibbon.ActivePage.Index <= FRibbon.FTabData.LastVisibleTabIndex) then
    begin
      LRect := FRibbon.GetTabRect(FRibbon.ActivePage.Index);
      OffsetRect(LRect, -Left, 0);
      LRect.Top := ClientRect.Top;
      LRect.Bottom := ClientRect.Bottom;
      Canvas.Pen.Color := $00F6EAE1;
      DrawLine(Canvas, LRect.TopLeft, Point(LRect.Right, LRect.Top));
    end;
  end;
end;

procedure TCustomRibbonPage.RequestAlign;
begin
  inherited;
  if Visible then
    AlignGroups;
end;

procedure TCustomRibbonPage.Resize;
begin
  inherited;
  // When resized, all scroll positions should be discarded
  GroupOffset := 0;
end;

// Returns the style class to use when drawing the specific Ribbon elements
//
// If there is no assigned style class, the default TRibbonLunaStyle class is used.
function TCustomRibbonPage.RibbonStyle: TRibbonStyleActionBars;
begin
  if (Ribbon <> nil) and (Ribbon.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(Ribbon.Style)
  else
    Result := RibbonLunaStyle;
end;

procedure TCustomRibbonPage.ScrollButtonClickHandler(Sender: TObject);
const
  ScrollDirection: array [Boolean] of TScrollDirection = (sdLeft, sdRight);
begin
  DoScrollButtonClick(ScrollDirection[Sender = FScrollRight]);
end;

procedure TCustomRibbonPage.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (Parent <> nil) and (FRibbon <> nil) then
    inherited SetBounds(0, GetPageTop, Parent.Width - 1, GetPageHeight)
  else
    inherited;
end;

procedure TCustomRibbonPage.SetGroupOffset(const Value: Integer);
begin
  if FGroupOffset <> Value then
  begin
    FGroupOffset := Value;
    AlignGroups;
  end;
end;

procedure TCustomRibbonPage.SetIndex(const Value: Integer);
begin
  FIndex := Value;
end;

procedure TCustomRibbonPage.SetParent(AParent: TWinControl);
begin
  inherited;
  if Parent <> nil then
  begin
    if AParent is TCustomRibbon then
      Ribbon := (Parent as TCustomRibbon);
    if (Ribbon <> nil) and not (Ribbon.Minimized) then
    begin
      if not (Parent is TCustomRibbon) then
        raise ERibbonException.Create(SInvalidRibbonPageParent);
      Font := Ribbon.Font;
      SetBounds(0, GetPageTop, Ribbon.Width - 1, GetPageHeight);
    end
    else
      Ribbon := nil;
    UpdateScrollButtons;
  end;
end;

procedure TCustomRibbonPage.SetRibbon(const Value: TCustomRibbon);
var
  LGroup: Pointer;
begin
  if FRibbon <> Value then
  begin
    FRibbon := Value;
    if FRibbon <> nil then
    begin
      Height := GetPageHeight;
      Font := FRibbon.Font;
      if FRibbon.ColorMap <> nil then
        Font.Color := FRibbon.ColorMap.FontColor;
    end;
  end;
  for LGroup in FGroups do
    TCustomRibbonGroup(LGroup).FRibbon := Value;
end;

procedure TCustomRibbonPage.ShowKeyTips;
var
  I: Integer;
  LGroup: TCustomRibbonGroup;
  LBarIntf: IRibbonBarKeyTip;
  LIntf: IRibbonKeyTip;
begin
  for I := 0 to GroupCount - 1 do
  begin
    LGroup := Groups[I];
    if Supports(LGroup, IRibbonKeyTip, LIntf) then
      LIntf.ShowKeyTip(ktpTabs);
    if Supports(LGroup, IRibbonBarKeyTip, LBarIntf) then
      LBarIntf.BarShowKeyTips;
  end;
end;

procedure TCustomRibbonPage.UpdateActionManager(Value: TCustomActionManager);
var
  LGroup: Pointer;
begin
  for LGroup in FGroups do
  begin
    TCustomRibbonGroup(LGroup).ActionManager := Value;
    if Value <> nil then
      TCustomRibbonGroup(LGroup).ControlStyle := TCustomRibbonGroup(LGroup).ControlStyle + [csAcceptsControls]
    else
      TCustomRibbonGroup(LGroup).ControlStyle := TCustomRibbonGroup(LGroup).ControlStyle - [csAcceptsControls];
  end;
end;

procedure TCustomRibbonPage.UpdateScrollButtons;
var
  LGroupWidth: Integer;
begin
  // Check width of groups
  LGroupWidth := GetGroupWidth;
  if (FScrollLeft <> nil) and (FScrollRight <> nil) then
  begin
    FScrollLeft.Visible := FGroupOffset <> 0;
    FScrollRight.Visible := (ClientWidth + abs(FGroupOffset) < LGroupWidth);
    if csDesigning in ComponentState then
    begin
      if not FScrollLeft.Visible then
      begin
        FScrollLeft.Align := alNone;
        FScrollLeft.Left := -MAXINT;
      end
      else
        FScrollLeft.Align := alLeft;
      if not FScrollRight.Visible then
      begin
        FScrollRight.Align := alNone;
        FScrollRight.Left := -MAXINT;
      end
      else
        FScrollRight.Align := alRight;
    end
    else
    begin
      FScrollLeft.Align := alLeft;
      FScrollRight.Align := alRight;
    end;
    FScrollLeft.BringToFront;
    FScrollRight.BringToFront;
  end;
end;

{ TOffice2007Button }

procedure TOffice2007Button.CMMouseenter(var Message: TMessage);
begin
  inherited;
  MouseInControl := True;
  GetCapture;
end;

procedure TOffice2007Button.CMMouseleave(var Message: TMessage);
begin
  inherited;
  MouseInControl := False;
end;

constructor TOffice2007Button.Create(AOwner: TComponent);
begin
  inherited;
  FImage := TBitmap.Create;
  FImage.Transparent := True;
  Width := 22;
  Height := 22;
end;

destructor TOffice2007Button.Destroy;
begin
  FImage.Free;
  inherited;
end;

procedure TOffice2007Button.DoClick;
begin
  if Assigned(FOnClick) then
    FOnClick(Self);
end;

procedure TOffice2007Button.DrawBackground;
begin
  if MouseInControl then
  begin
    if IsLeftMouseButtonPressed(Self) then
      RibbonStyle.DrawElement(sbSmallPressed, Canvas, ClientRect)
    else
      RibbonStyle.DrawElement(sbSmallHover, Canvas, ClientRect);
  end;
end;

procedure TOffice2007Button.DrawImage;
begin
  Canvas.Draw(4, 4, FImage);
end;

function TOffice2007Button.GetRibbonStyle: TRibbonStyleActionBars;
begin
  if Parent is TCustomRibbon then
    Result := TCustomRibbon(Parent).Style
  else
    Result := RibbonLunaStyle;
end;

procedure TOffice2007Button.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then
    Invalidate;
end;

procedure TOffice2007Button.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if IsLeftMouseButtonPressed(Self) then
  begin
    MouseInControl := ClientRect.Contains(Point(X, Y));
  end;
end;

procedure TOffice2007Button.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Button = mbLeft) and ClientRect.Contains(Point(X, Y)) then
  begin
    Invalidate;
    DoClick;
  end;
end;

procedure TOffice2007Button.Paint;
begin
  DrawBackground;
  DrawImage;
end;

procedure TOffice2007Button.SetMouseInControl(const Value: Boolean);
begin
  if (csDesigning in ComponentState) then
  begin
    FMouseInControl := False;
    Exit;
  end;

  if FMouseInControl <> Value then
  begin
    FMouseInControl := Value;
    Invalidate;
  end;
end;

{ THelpButton }

procedure THelpButton.DrawImage;
begin
  RibbonStyle.DrawElement(srHelp, Canvas, Rect(4, 4, 0, 0), 0);
end;

{ TCustomRibbonQuickAccessToolbar }

procedure TCustomRibbonQuickAccessToolbar.CMFontchanged(var Message: TMessage);
begin
  inherited;
  if FRibbon <> nil then
    Font.Size := FRibbon.GetRibbonMetric(rmFontSize);
end;

procedure TCustomRibbonQuickAccessToolbar.CMVisiblechanged(var Message: TMessage);
begin
  inherited;
  if FRibbon <> nil then
  begin
    FRibbon.Height := FRibbon.GetRibbonMetric(rmHeight);
    FRibbon.InvalidateHeaderArea;
  end;
end;

constructor TCustomRibbonQuickAccessToolbar.Create(AOwner: TComponent);
begin
  inherited;
  AutoSize := True;
  FShowBorder := False;
  VertMargin := 1;
  EdgeBorders := [];
  EdgeInner := esNone;
  EdgeOuter := esNone;
  CreateQATActions;
//  FindRibbon;
end;

function TCustomRibbonQuickAccessToolbar.CreateControl(
  AnItem: TActionClientItem): TCustomActionControl;
begin
  AnItem.ShowCaption := False;
  Result := inherited CreateControl(AnItem);
  Result.Constraints.MaxHeight := 22;
end;

procedure TCustomRibbonQuickAccessToolbar.CreateControls;
begin
  inherited;
  DoUpdateQATWidth;
end;

procedure TCustomRibbonQuickAccessToolbar.CreateQATActions;
begin
  FMoreCommandsAction := TAction.Create(Application);
  FMoreCommandsAction.Caption := SMoreCommands;
  FMoreCommandsAction.OnExecute := MoreCommandsHandler;
  FMinimizeRibbonAction := TAction.Create(Application);
  FMinimizeRibbonAction.Caption := SMinimizeTheRibbon;
  FMinimizeRibbonAction.AutoCheck := True;
  FMinimizeRibbonAction.OnExecute := MinimizeRibbonHandler;
  FShowBelowRibbonAction := TAction.Create(Application);
  FShowBelowRibbonAction.Caption := SShowQuickAccessToolbarBelow;
  FShowBelowRibbonAction.OnExecute := ShowBelowRibbonHandler;
end;

procedure TCustomRibbonQuickAccessToolbar.Customize;
begin
  DoMoreCommands;
end;

procedure TCustomRibbonQuickAccessToolbar.CustomizeHandler(Sender: TObject);
begin
  ShowCustomizeMenu(TRibbonQATScrollButton(TAction(Sender).Tag));
end;

procedure TCustomRibbonQuickAccessToolbar.MinimizeRibbonHandler(Sender: TObject);
begin
  if Ribbon <> nil then
    Ribbon.Minimized := not Ribbon.Minimized;
end;

procedure TCustomRibbonQuickAccessToolbar.MoreCommandsHandler(Sender: TObject);
begin
  Customize;
end;

//procedure TCustomRibbonQuickAccessToolbar.FindRibbon;
//var
//  I: Integer;
//begin
//  for I := 0 to Owner.ComponentCount - 1 do
//  begin
//    if Owner.Components[I] is TCustomRibbon then
//    begin
//      TCustomRibbon(Owner.Components[I]).QuickAccessToolbar.ActionBar := Self;
//      Break;
//    end;
//  end;
//end;

procedure TCustomRibbonQuickAccessToolbar.ShowBelowRibbonHandler(Sender: TObject);
begin
  if Ribbon <> nil then
  begin
    Ribbon.QuickAccessToolbar.TogglePosition;
    if Ribbon.QuickAccessToolbar.Position = qpTop then
      FShowBelowRibbonAction.Caption := SQATShowBelowTheRibbon
    else
      FShowBelowRibbonAction.Caption := SQATShowAboveTheRibbon;
  end;
end;

procedure TCustomRibbonQuickAccessToolbar.ShowCustomizeMenu(AScrollBtn: TRibbonQATScrollButton);
var
  LCustomPopup: TCustomizeActionToolBar;
  LPt: TPoint;
  LItem: TActionClientItem;
  LAC: TActionClientItem;
  LNewAC: TActionClientItem;
  I: Integer;
  LXOffSet: Integer;
  LLeft: Integer;
  LTop: Integer;
begin
  DisableAlign;
  try
    LAC := TActionClientItem.Create(ActionClient.Items);
    LAC.Visible := False;
    for I := 0 to ActionClient.Items.Count - 1 do
    begin
      if (ActionClient.Items[I].Caption <> '') and
        (ActionClient.Items[I] <> LAC) then
      begin
        LNewAC := LAC.Items.Add;
        LNewAC.ChangesAllowed := caAllChanges;
        LNewAC.Assign(ActionClient.Items[I]);
        LNewAC.UsageCount := -1;
      end;
    end;
  finally
    EnableAlign;
  end;
  FPopupBar := TRibbonQATCustomizeMenu.Create(Self) as TCustomActionPopupMenu;
  try

    LItem := LAC.Items.Insert(0) as TActionClientItem;
    LItem.CommandStyle := csSeparator;
    LItem.Caption := SCustomizeQuickAccessToolbar;
    LItem.Tag := -1;

    LItem := LAC.Items.Add;
    LItem.Caption := '-';
    LItem.Tag := -1;

    if Ribbon.QuickAccessToolbar.ShowMoreCommands then
    begin
      LItem := LAC.Items.Add;
      LItem.Action := FMoreCommandsAction;
      LItem.Tag := -1;
    end;

    if Ribbon.QuickAccessToolbar.ShowPosition then
    begin
      if Ribbon.QuickAccessToolbar.Position = qpTop then
        FShowBelowRibbonAction.Caption := SQATShowBelowTheRibbon
      else
        FShowBelowRibbonAction.Caption := SQATShowAboveTheRibbon;
      LItem := LAC.Items.Add;
      LItem.Action := FShowBelowRibbonAction;
      LItem.Tag := -1;
    end;

    if (Ribbon.QuickAccessToolbar.ShowMoreCommands) or
      (Ribbon.QuickAccessToolbar.ShowPosition) then
    begin
      LItem := LAC.Items.Add;
      LItem.Caption := '-';
      LItem.Tag := -1;
    end;

    if Ribbon.QuickAccessToolbar.ShowMinimize then
    begin
      FMinimizeRibbonAction.Checked := Ribbon.Minimized;
      LItem := LAC.Items.Add;
      LItem.Action := FMinimizeRibbonAction;
      LItem.Tag := -1;
    end;

    LCustomPopup := FPopupBar as TCustomizeActionToolBar;
    LCustomPopup.Orientation := boTopToBottom;
    LCustomPopup.ColorMap := ColorMap;
    LCustomPopup.RootMenu := TCustomizeActionToolBar(FPopupBar);
    LCustomPopup.ParentControl := AScrollBtn;
    LCustomPopup.Parent := Self;
    LCustomPopup.ActionClient := LAC;
    LCustomPopup.Expand(True);
    LCustomPopup.ReAlign;
    if not ShowBorder then
      LXOffset := 13
    else
      LXOffset := 2;

    if AScrollBtn = FScrollBtn then
    begin
      LLeft := AScrollBtn.Left + LXOffSet;
      LTop := AScrollBtn.Top + AScrollBtn.Height - 2;
      LPt := Self.ClientToScreen(Point(LLeft, LTop));
    end
    else
    begin
      LLeft := AScrollBtn.Left + AScrollBtn.Width + 4 - AScrollBtn.Parent.Width;
      LTop := AScrollBtn.Top + AScrollBtn.Height - 2;
      LPt := AScrollBtn.ClientToScreen(Point(LLeft, LTop));
    end;

    AScrollBtn.DrawDown := True;
    try
      LCustomPopup.Popup(LPt.X, LPt.Y);
    finally
      AScrollBtn.DrawDown := False;
    end;
  finally
    FreeAndNil(FPopupBar);
    LAC.Control.Free;
    LAC.Free;
  end;
end;

procedure TCustomRibbonQuickAccessToolbar.ShowMoreControls;
var
  LPt: TPoint;
  LItem: TActionClientItem;
  LAC: TActionClientItem;
  LNewAC: TActionClientItem;
  I: Integer;
  LXOffSet: Integer;
  LCustomPopup: TRibbonQuickAccessPopupToolbar;
  LQATScroll: TRibbonQATScrollButton;
  LActionBarItem: TActionBarItem;
  LAction: TAction;
begin
  LAC := TActionClientItem.Create(ActionClient.Items);
  try
    LAC.Visible := False;
    for I := 0 to ActionClient.Items.Count - 1 do
    begin
      LItem := ActionClient.Items[I];
      if (LItem <> LAC) and not LItem.Separator and
        ((LItem.Control = nil) or (not LItem.Control.Visible) or (LItem.Control.Left > Width)) then
      begin
        LNewAC := LAC.Items.Add;
        LNewAC.Assign(LItem);
        LNewAC.Tag := LItem.Tag;
        LNewAC.ShowCaption := LNewAC.ImageIndex = -1;
        LNewAC.ShowShortCut := False;
        LNewAC.UsageCount := -1;
      end;
    end;

    if LAC.Items.Count = 0 then
      Exit;

    LNewAC := LAC.Items.Add;
    LAction := TAction.Create(nil);
    LAction.OnExecute := CustomizeHandler;
    LNewAC.Action := LAction;
    LNewAC.Tag := -1;
    LNewAC.UsageCount := -1;

    LCustomPopup := TRibbonQuickAccessPopupToolbar.Create(Self);

    LActionBarItem := LCustomPopup.FQuickAccessToolbar.ActionManager.ActionBars.Add;
    LActionBarItem.ActionBar := LCustomPopup;
    LActionBarItem.AutoSize := False;
    try
      LCustomPopup.ActionClient := LAC;
      LCustomPopup.Realign;

      if not ShowBorder then
        LXOffset := 13
      else
        LXOffset := 2;

      if BiDiMode = bdLeftToRight then
        LCustomPopup.Orientation := boLeftToRight
      else
        LCustomPopup.Orientation := boRightToLeft;
      LPt := Self.ClientToScreen(Point(FScrollBtn.Left + LXOffSet, FScrollBtn.Top + FScrollBtn.Height - 2));
      LCustomPopup.ParentControl := FScrollBtn;
      LCustomPopup.ColorMap := ColorMap;

      if (FScrollBtn is TRibbonQATScrollButton) then
        LQATScroll := TRibbonQATScrollButton(FScrollBtn)
      else
        LQATScroll := nil;
      if LQATScroll <> nil then
        LQATScroll.DrawDown := True;
      try
        LCustomPopup.Popup(LPt.X, LPt.Y);
      finally
        if LQATScroll <> nil then
          LQATScroll.DrawDown := False;
      end;
    finally
      LActionBarItem.Free;
      LAction.Free;
    end;

  finally
    LAC.Free;
    DoUpdateQATWidth;
  end;
end;

procedure TCustomRibbonQuickAccessToolbar.UpdateQATWidth;
begin
  if not (csLoading in ComponentState) then
  begin
    if FRibbon <> nil then
    begin
      FRibbon.UpdateQATPosition;
      SetupDropDownBtn;
    end;
  end;
end;

procedure TCustomRibbonQuickAccessToolbar.WMPaint(var Message: TWMPaint);
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

procedure TCustomRibbonQuickAccessToolbar.DoContextPopup(MousePos: TPoint;
  var Handled: Boolean);
begin
  inherited;
  Ribbon.DoContextPopup(MousePos, Handled);
end;

procedure TCustomRibbonQuickAccessToolbar.DoDropActions(Source: TActionDragObject;
  const X, Y: Integer);
begin
  inherited;
  DoUpdateQATWidth;
end;

procedure TCustomRibbonQuickAccessToolbar.DoDropCategory(Source: TCategoryDragObject;
  const X, Y: Integer);
begin
  inherited;
  DoUpdateQATWidth;
end;

procedure TCustomRibbonQuickAccessToolbar.DoDropItem(Source: TActionItemDragObject;
  const X, Y: Integer);
begin
  inherited;
  DoUpdateQATWidth;
end;

procedure TCustomRibbonQuickAccessToolbar.DoMoreCommands;
var
  LHandled: Boolean;
begin
  LHandled := False;
  if Assigned(FOnMoreCommands) then
    FOnMoreCommands(Self, LHandled);
  if not LHandled and (Ribbon <> nil) and (Ribbon.ActionManager <> nil) then
  begin
    if FCustomizeDlg = nil then
    begin
      FCustomizeDlg := TRibbonCustomizeDlg.Create(Self);
      FCustomizeDlg.ActionManager := Ribbon.ActionManager;
    end;
    FCustomizeDlg.Show;
  end;
end;

procedure TCustomRibbonQuickAccessToolbar.DoScrollBtnClick;
begin
  if TRibbonQATScrollButton(FScrollBtn).ScrollMode = qsMoreControls then
    ShowMoreControls
  else
    ShowCustomizeMenu(TRibbonQATScrollButton(FScrollBtn));
end;

// This method is accessible by testing an object for the
// IRibbonQuickAccessToolbar interface. This method sizes the Quick Access
// Toolbar to the correct width when an Action is dropped on it at design time
procedure TCustomRibbonQuickAccessToolbar.DoUpdateQATWidth;
begin
  UpdateQATWidth;
end;

procedure TCustomRibbonQuickAccessToolbar.DragDrop(Source: TObject; X, Y: Integer);
begin
  inherited;
  if DesignMode then
    DoUpdateQATWidth;
end;

procedure TCustomRibbonQuickAccessToolbar.BarHandleKeyTips(const KeyTip: string;
  var KeyTips: TKeyTipList);
var
  I: Integer;
  LIntf: IRibbonKeyTip;
  LHandled: TKeyTipHandled;
begin
  if HasItems then
  begin
    for I := 0 to Items.Count - 1 do
    begin
      if Supports(Items[I].Control, IRibbonKeyTip, LIntf) then
      begin
        LIntf.HandleKeyTip(KeyTip, LHandled);
        if LHandled = ktFull then
        begin
          KeyTips.Add(mtControl, LHandled, Items[I].Control);
        end;
      end;
    end;
  end;
end;

procedure TCustomRibbonQuickAccessToolbar.BarHideKeyTips(KeyTips: TKeyTipList);
var
  I: Integer;
  LIntf: IRibbonKeyTip;
begin
  if HasItems then
  begin
    for I := 0 to Items.Count - 1 do
    begin
      if Supports(Items[I].Control, IRibbonKeyTip, LIntf) then
        LIntf.HideKeyTip('');
    end;
  end;
end;

procedure TCustomRibbonQuickAccessToolbar.BarShowKeyTips;
var
  I: Integer;
  LIntf: IRibbonKeyTip;
begin
  if HasItems then
  begin
    for I := 0 to Items.Count - 1 do
    begin
      Items[I].KeyTip := IntToStr(I + 1);
      if Supports(Items[I].Control, IRibbonKeyTip, LIntf) then
        LIntf.ShowKeyTip(ktpQuickAccessToolbar);
    end;
  end;
end;

procedure TCustomRibbonQuickAccessToolbar.DrawBackground;
var
  LRect: TRect;
begin
  if FShowBorder then
  begin
    RibbonStyle.DrawElement(sqBackground, Canvas, ClientRect);
  end
  else
  begin
    LRect := ClientRect;
    LRect.Top := -Top;
    LRect.Bottom := LRect.Top + Ribbon.GetRibbonMetric(rmFullHeight);

    if Ribbon.CustomFrameSupported then
    begin
      if Ribbon.GlassFrameSupported then
      begin
        canvas.Brush.color := clBlack;
        canvas.FillRect(LRect);
      end
      else
      begin
        if Ribbon.Active then
          RibbonStyle.DrawElement(srBackground, Canvas, LRect, Ribbon.GetRibbonMetric(rmCaption))
        else
          RibbonStyle.DrawElement(srBackgroundDisabled, Canvas, LRect, Ribbon.GetRibbonMetric(rmCaption));
      end;
    end
    else
      RibbonStyle.DrawElement(srBackground, Canvas, LRect, Ribbon.GetRibbonMetric(rmCaption));
    if BiDiMode = bdLeftToRight then
    begin
      LRect := ClientRect;
      LRect.Right := LRect.Right - 26;
      RibbonStyle.DrawElement(sqMiddle, Canvas, LRect);
    end;
  end;
end;

function TCustomRibbonQuickAccessToolbar.GetBarHeight: Integer;
begin
  Result := 24;
end;

function TCustomRibbonQuickAccessToolbar.GetBarWidth: Integer;
var
  I: Integer;
begin
  Result := (HorzMargin * 2) + Spacing;
  if csLoading in ComponentState then
    Exit;
  if FScrollBtn <> nil then
    Inc(Result, Spacing + FScrollBtn.Width);
  // If the Quick Access Toolbar currently has no items associated with it and
  // it is designable then increase the width so that it is easier to drop new
  // items on to it
  if not HasItems then
  begin
    if DesignMode then
      Inc(Result, 22);
    Exit;
  end
  else
  begin
    Inc(Result);
    for I := 0 to Items.Count - 1 do
    begin
      if (Items[I].Control <> nil) and (Items[I].Visible) and
        ((Items[I].Action <> nil) or ((Items[I].HasItems) and (Items[I].Items.Count > 0))) then
        Inc(Result, Items[I].Control.Width + Spacing);
    end;
  end;
end;

function TCustomRibbonQuickAccessToolbar.GetScrollBtnClass: TCustomToolScrollBtnClass;
begin
  Result := TRibbonQATScrollButton
end;

function TCustomRibbonQuickAccessToolbar.GetScrollMode: TQATScrollMode;
begin
  if FScrollBtn <> nil then
    Result := TRibbonQATScrollButton(FScrollBtn).ScrollMode
  else
    Result := qsCustomize;
end;

procedure TCustomRibbonQuickAccessToolbar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FRibbon then
      FRibbon := nil
    else if AComponent is TCustomActionControl then
    begin
      // Only update Quick Access Toolbar width if not Loading or
      // Destroying the Toolbar
      if ComponentState * [csLoading, csDestroying] = [] then
        DoUpdateQATWidth;
    end;
  end;
end;

procedure TCustomRibbonQuickAccessToolbar.RequestAlign;
begin
  inherited;
  if ShowBorder and (FScrollBtn <> nil) then
  begin
    FScrollBtn.Left := GetBarWidth-FScrollBtn.Width;
           
//    FScrollBtn.Margins := Rect(FScrollBtn.Margins.Left, 2, FScrollBtn.Margins.Right, FScrollBtn.Margins.Bottom)

  end;
end;

function TCustomRibbonQuickAccessToolbar.RibbonStyle: TRibbonStyleActionBars;
begin
  if Style is TRibbonStyleActionBars then
    Result := TRibbonStyleActionBars(Style)
  else if FRibbon <> nil then
    Result := FRibbon.Style
  else
    Result := RibbonLunaStyle;
end;

procedure TCustomRibbonQuickAccessToolbar.SetParent(AParent: TWinControl);
begin
  inherited;
  if (Parent is TCustomRibbon) then
    FRibbon := TCustomRibbon(Parent);
end;

procedure TCustomRibbonQuickAccessToolbar.SetScrollMode(
  const Value: TQATScrollMode);
var
  LBtn: TRibbonQATScrollButton;
begin
  if FScrollBtn <> nil then
  begin
    LBtn := TRibbonQATScrollButton(FScrollBtn);
    LBtn.ScrollMode := Value;
    if LBtn.ScrollMode = qsCustomize then
      FScrollBtn.Hint := SCustomizeQuickAccessToolbar
    else
      FScrollBtn.Hint := SMoreControls;
  end;
end;

procedure TCustomRibbonQuickAccessToolbar.SetShowBorder(const Value: Boolean);
begin
  if FShowBorder <> Value then
  begin
    FShowBorder := Value;
    Height := GetBarHeight;
    if FScrollBtn <> nil then
      FScrollBtn.CalcBounds;
  end;
end;

procedure TCustomRibbonQuickAccessToolbar.SetupDropDownBtn;
begin
  inherited;
  if FScrollBtn <> nil then
  begin
    if TRibbonQATScrollButton(FScrollBtn).ScrollMode = qsCustomize then
      FScrollBtn.Hint := SCustomizeQuickAccessToolbar
    else
      FScrollBtn.Hint := SMoreControls;
    if ShowBorder then
      FScrollBtn.Align := alNone
    else if DesignMode then
      FScrollBtn.Left := Width - FScrollBtn.Width;
  end;
end;

{ TQuickAccessToolbar }

procedure TQuickAccessToolbar.Assign(Source: TPersistent);
var
  lSrc: TQuickAccessToolbar;
begin
  if Source is TQuickAccessToolbar then
  begin
    lSrc := TQuickAccessToolbar(Source);
    FPosition := lSrc.Position;
    // set last so it calls DoChange
    ActionBar := lSrc.ActionBar;
  end
  else
    inherited;
end;

constructor TQuickAccessToolbar.Create(ARibbon: TCustomRibbon);
begin
  inherited Create;
  FRibbon := ARibbon;
  FPosition := qpTop;
  FShowMinimize := True;
  FShowMoreCommands := True;
  FShowPosition := True;
end;

procedure TQuickAccessToolbar.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TQuickAccessToolbar.GetBarWidth: Integer;
begin
  if FActionBar = nil then
    Result := 0
  else
    Result := FActionBar.GetBarWidth;
end;

function GetActionBarItem(ActionBar: TCustomActionBar): TActionBarItem;
var
  I: Integer;
begin
  if (ActionBar <> nil) and (ActionBar.ActionManager <> nil) then
  begin
    for I := 0 to ActionBar.ActionManager.ActionBars.Count - 1 do
    begin
      Result := ActionBar.ActionManager.ActionBars[I];
      if (Result.ActionBar <> nil) and Result.ActionBar.Equals(ActionBar) then
        Exit;
    end;
  end;
  Result := nil;
end;

procedure TQuickAccessToolbar.Show(const Visible: Boolean);
var
  LActionBarItem: TActionBarItem;
begin
  LActionBarItem := GetActionBarItem(ActionBar);
  if LActionBarItem <> nil then
  begin
    if (csDesigning in ActionBar.ComponentState) then
    begin
      if not Visible then
        ActionBar.ControlStyle := ActionBar.ControlStyle + [csNoDesignVisible]
      else
        ActionBar.ControlStyle := ActionBar.ControlStyle - [csNoDesignVisible];
    end;
    LActionBarItem.Visible := Visible;
  end;
end;

procedure TQuickAccessToolbar.SetActionBar(const Value: TCustomRibbonQuickAccessToolbar);
var
  LActionBars: TActionBars;
  LBarFound: Boolean;
  LActionBarItem: TActionBarItem;
  I: Integer;
begin
  if FActionBar <> Value then
  begin
    FActionBar := Value;
    if (Value <> nil) and (FRibbon <> nil) then
    begin
      Value.FreeNotification(FRibbon);
      Value.Left := TCustomRibbon.cRibbonQuickAccessToolbarLeft;
      if FRibbon.CustomFrameSupported then
        Value.Top := FRibbon.GetRibbonMetric(rmFormBorder)
      else
        Value.Top := 1;
      if not (csLoading in FRibbon.ComponentState) then
      begin
        if FRibbon.ActionManager <> nil then
        begin
          LActionBars := FRibbon.ActionManager.ActionBars;
          LBarFound := False;
          for I := 0 to LActionBars.Count - 1 do
          begin
            LActionBarItem := LActionBars[I];
            if LActionBarItem.ActionBar <> nil then
              LBarFound := LActionBarItem.ActionBar.Equals(Value)
            else
              LBarFound := False;
            if LBarFound then
            begin
              LActionBarItem.AutoSize := False;
              Break;
            end;
          end;
          // If there is currently no entry for the ActionBar in the Ribbon Manager
          // then create one and make sure the defaults are set correctly
          if not LBarFound then
          begin
            LActionBarItem := FRibbon.ActionManager.ActionBars.Add;
            LActionBarItem.ActionBar := Value;
            LActionBarItem.AutoSize := False;
          end;
        end;
        FRibbon.UpdateQATPosition;
        FRibbon.InvalidateHeaderArea;
      end;
      DoChange;
    end;
  end;
end;

procedure TQuickAccessToolbar.SetPosition(const Value: TQATPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    DoChange;
  end;
end;

procedure TQuickAccessToolbar.SetShowMinimize(const Value: Boolean);
begin
  FShowMinimize := Value;
end;

procedure TQuickAccessToolbar.SetShowMoreCommands(const Value: Boolean);
begin
  FShowMoreCommands := Value;
end;

procedure TQuickAccessToolbar.SetShowPosition(const Value: Boolean);
begin
  FShowPosition := Value;
end;

procedure TQuickAccessToolbar.TogglePosition;
begin
  if Position = qpTop then
    Position := qpBottom
  else
    Position := qpTop;
end;

{ TRibbonTabs }

function TRibbonTabs.Add: TRibbonTabItem;
begin
  Result := inherited Add as TRibbonTabItem;
end;

constructor TRibbonTabs.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  inherited Create(AOwner, ItemClass);
  FDesignerAdd := False;
end;

procedure TRibbonTabs.CreatePageForItem(AItem: TRibbonTabItem);
var
  LPage: TRibbonPage;

  function GetUniqueName(const Name: string; const AComponent: TComponent): string;
  var
    LIdx: Integer;
  begin
    LIdx := 1;
    Result := Format(Name, [LIdx]);
    if AComponent <> nil then
    begin
      while AComponent.FindComponent(Result) <> nil do
      begin
        Inc(LIdx);
        Result := Format(Name, [LIdx]);
      end;
    end;
  end;

begin
  Ribbon.ControlStyle := Ribbon.ControlStyle + [csAcceptsControls];
  try
    LPage := TRibbonPage.Create(GetParentForm(Ribbon));
    LPage.Parent := Ribbon;
    LPage.Ribbon := Ribbon;
    LPage.SetBounds(0, Ribbon.GetRibbonMetric(rmTabTop), Ribbon.Width - 2, Ribbon.GetRibbonMetric(rmPageHeight));
    LPage.Name := GetUniqueName('RibbonPage%d', GetParentForm(Ribbon));
    LPage.Index := AItem.Index;
    AItem.FPage := LPage;
    LPage.Caption := LPage.Name;
    Ribbon.TabIndex := AItem.Index;
    Ribbon.Invalidate;
  finally
    Ribbon.ControlStyle := Ribbon.ControlStyle - [csAcceptsControls];
  end;
end;

function TRibbonTabs.FindGroup(const GroupName: string): TControl;
var
  I: Integer;
  LPage: TCustomRibbonPage;
begin
  for I := 0 to Count - 1 do
  begin
    LPage := Items[I].Page;
    Result := LPage.FindGroup(GroupName);
    if result <> nil then
      Exit;
  end;
  Result := nil;
end;

function TRibbonTabs.GetItem(Index: Integer): TRibbonTabItem;
begin
  Result := inherited GetItem(Index) as TRibbonTabItem;
end;

function TRibbonTabs.GetPageFromPageCaption(const Caption: string): TCustomRibbonPage;
var
  LIdx: Integer;
begin
  LIdx := IndexOfCaption(Caption);
  if LIdx > -1 then
    Result := Items[LIdx].Page
  else
    Result := nil;
end;

function TRibbonTabs.GetRibbon: TCustomRibbon;
begin
  Result := Owner as TCustomRibbon;
end;

function TRibbonTabs.IndexOfCaption(const Caption: string): Integer;
var
  I: Integer;
  LTabItem: TRibbonTabItem;
begin
  for I := 0 to Count - 1 do
  begin
    LTabItem := Items[I];
    if SameText(LTabItem.Caption, Caption) then
    begin
      Result := LTabItem.Index;
      Exit;
    end;
  end;
  Result := -1;
end;

procedure TRibbonTabs.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  inherited;
  if Action = System.Classes.TCollectionNotification.cnDeleting then
  begin
    PostMessage(Ribbon.Handle, CM_INVALIDATE, 0, 0);
  end
  else if Action = System.Classes.TCollectionNotification.cnAdded then
  begin
    if not (csLoading in Ribbon.ComponentState) then
    begin
      // If the page isn't being added with the Add Page component editor then
      // the TRibbonPage component needs to be created
      if not DesignerAdd then
      begin
        CreatePageForItem(Item as TRibbonTabItem);
      end;
    end;
  end;
end;

function TRibbonTabs.TabExists(const Caption: string): Boolean;
var
  I: Integer;
  LTabItem: TRibbonTabItem;
begin
  for I := 0 to Count - 1 do
  begin
    LTabItem := Items[I];
    Result := SameText(LTabItem.Caption, Caption);
    if Result then
      Exit;
  end;
  Result := False;
end;

function TRibbonTabs.SelectNext: Boolean;
begin
  Result := Ribbon.TabIndex < Count - 1;
  if Result then
    Ribbon.TabIndex := Ribbon.TabIndex + 1;
end;

function TRibbonTabs.SelectPrior: Boolean;
begin
  Result := Ribbon.TabIndex > 0;
  if Result then
    Ribbon.TabIndex := Ribbon.TabIndex - 1;
end;

procedure TRibbonTabs.SetItem(Index: Integer; const Value: TRibbonTabItem);
begin
  inherited SetItem(Index, Value);
end;

{ TRibbonTabItem }

procedure TRibbonTabItem.Assign(Source: TPersistent);
var
  LSrc: TRibbonTabItem;
begin
  if Source is TRibbonTabItem then
  begin
    LSrc := TRibbonTabItem(Source);
    FPage := LSrc.Page;
    FCaption := LSrc.Caption;
    FKeyTip := LSrc.KeyTip;
  end
  else
    inherited;
end;

destructor TRibbonTabItem.Destroy;
begin
  FreeAndNil(FKeyTipForm);
  inherited;
end;

function TRibbonTabItem.GetBestTabWidth: Integer;
begin
  RecalculateTabItemMetrics;
  Result := FBestTabWidth;
end;

function TRibbonTabItem.GetDisplayName: string;
begin
  if Caption = '' then
    Result := inherited GetDisplayName
  else
    Result := Caption;
end;

function TRibbonTabItem.GetKeyTip: string;
begin
  if FPage <> nil then
    Result := FPage.KeyTip
  else
    Result := '';
end;

function TRibbonTabItem.GetMinTabWidth: Integer;
begin
  RecalculateTabItemMetrics;
  Result := FMinTabWidth;
end;

procedure TRibbonTabItem.RecalculateTabItemMetrics;
const
  cTestStr = 'Mmm';
begin
  if FPage = nil then
    Exit;
  if FModified then
  try
    FMinTabWidth := FPage.Canvas.TextWidth(Caption);
    FBestTabWidth := FMinTabWidth + 17; // Allow a bit of padding
    FMinTruncatedWidth := FPage.Canvas.TextWidth(cTestStr);
  finally
    FModified := False;
  end;
end;

procedure TRibbonTabItem.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    if FPage <> nil then
    begin
      FPage.Caption := Value;
      if FPage.Ribbon <> nil then
        FPage.Ribbon.RebuildRibbonMetrics;
    end;
    FModified := True;
  end;
end;

procedure TRibbonTabItem.SetKeyTip(const Value: string);
begin
  if FPage <> nil then
    FPage.KeyTip := Value;
end;

procedure TRibbonTabItem.SetPage(const Value: TCustomRibbonPage);
begin
  if FPage <> Value then
  begin
    FPage := Value;
    if (FPage <> nil) and (FPage.Ribbon <> nil) then
      FPage.Ribbon.TabIndex := Index;
  end;
end;

{ TRibbonGroupDockForm }

constructor TRibbonGroupDockForm.Create(AOwner: TComponent);
begin
  inherited;
  BorderStyle := bsNone;
  DockSite := False;
end;

procedure TRibbonGroupDockForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := WS_POPUP;
  Params.ExStyle := WS_EX_TOPMOST or WS_EX_TOOLWINDOW or WS_EX_LAYERED;
end;

procedure TRibbonGroupDockForm.WMActivate(var Message: TWMActivate);
var
  LCtrl: TControl;
  LRibbonGroup: IRibbonGroup;
  LIntf: IRibbonGroupDropdown;
begin
  if Message.Active = WA_INACTIVE then
  begin
    if ControlCount > 0 then
    begin
      LCtrl := Controls[0];
      if Control <> nil then
      begin
        if Supports(Control, IRibbonGroupDropdown, LIntf) then
        begin
          LCtrl.Parent := LIntf.GetParentControl;
          LCtrl.Top := LIntf.GetTopPosition;
          if Supports(LCtrl, IRibbonGroup, LRibbonGroup) then
            LRibbonGroup.AlignGroupControls;
          LIntf.CloseUp;
        end;
      end;
    end;
  end;
  inherited;
  if Message.Active = WA_INACTIVE then
  begin
    Hide;
    if Control <> nil then
      Control.Invalidate;
  end;
end;

{ TCustomRibbonGroup }

procedure TCustomRibbonGroup.AlignControls(AControl: TControl; var Rect: TRect);
begin
  // Groups are aligned using the AlignGroupControls method
end;

const
  WIDTH_OFFSET = 2;
  LEFT_OFFSET = 4;

// Aligns the controls in the Ribbon Group
procedure TCustomRibbonGroup.AlignGroupControls;
var
  LActionClients: TActionClients;
  I: Integer;
  LTop: Integer;
  LLeft: Integer;
  LAC: TActionClientItem;
  LLastAC: TActionClientItem;
  LCtrlWidth: Integer;
  LCtrlHeight: Integer;
  LCtrl: TCustomActionControl;
  LFitVert: Boolean;
  LPrevWidth: Integer;
  LRow: Integer;
  LOldTop: Integer; // current row

  function IsLargeButton(AnItem: TActionClientItem): Boolean;
  begin
    Result := (AnItem.CommandStyle = csButton) and (AnItem.CommandProperties <> nil);
    if Result then
      Result := TButtonProperties(AnItem.CommandProperties).ButtonSize = bsLarge;
  end;

  function IsGallery(AnItem: TActionClientItem): Boolean;
  begin
    Result := (AnItem.CommandStyle = csGallery) and (AnItem.CommandProperties <> nil);
    if Result then
      Result := TGalleryProperties(AnItem.CommandProperties).GalleryType = gtRibbon;
  end;

begin
  if not HasItems then
    Exit;
  // If FCreatingControls is True, then this method will be called once all
  // controls has been created
  if CreatingControls then
    Exit;
  if FCollapsedControl <> nil then
    FCollapsedControl.SetupGroupImage;
  FRowPosition[1] := -1;
  FRowPosition[2] := -1;
  FRowPosition[3] := -1;
  LActionClients := ActionClient.Items;
  LTop := FSpacingVert + FRowStart;
  LOldTop := LTop;
  LLeft := LEFT_OFFSET;
  LRow := 1;
  LPrevWidth := 0;
  LLastAC := nil;
  FRowPosition[1] := LTop;
  for I := 0 to LActionClients.Count - 1 do
  begin
    LAC := LActionClients[I];
    LCtrl := LAC.Control;
    if FGroupAlign = gaVertical then
    begin
      if LCtrl <> nil then
      begin
        LCtrlWidth := LCtrl.Width;
        LCtrlHeight := LCtrl.Height;
        // Large buttons and in ribbon galleries should still have the
        // same top position
        if IsLargeButton(LAC) or LAC.Separator or IsGallery(LAC) then
        begin
          LTop := FSpacingVert;
          Inc(LLeft, LPrevWidth + FSpacingHorz);
          LPrevWidth := 0;
        end
        else if LAC.NewCol then
        begin
          LTop := FSpacingVert + FRowStart;
          Inc(LLeft, LPrevWidth + FSpacingHorz);
          LPrevWidth := 0;
        end
        else
        begin
          LFitVert := LTop + LCtrlHeight < (Height - GetCaptionHeight);
          if not LFitVert then
          begin
            LTop := FSpacingVert + FRowStart;
            Inc(LLeft, LPrevWidth + FSpacingHorz);
            LPrevWidth := 0;
          end;
        end;
        LCtrl.Top := LTop;
        LCtrl.Left := LLeft;
        LAC.DisplayRow := (LCtrl.Top div 22) + 1;
        Inc(LTop, LCtrl.Height);
        LPrevWidth := Max(LCtrlWidth, LPrevWidth);
        if LTop > (Height - GetCaptionHeight) then
        begin
          LTop := FSpacingVert + FRowStart;
          Inc(LLeft, LPrevWidth + FSpacingHorz);
        end
      end;
    end
    else
    begin
      if LCtrl <> nil then
      begin
        if LAC.NewRow and (LRow < Rows) then
        begin
          Inc(LRow);
          LTop := FSpacingVert + FRowStart + (22 * (LRow - 1)) + FRowStart;
          LLeft := LEFT_OFFSET;
          FRowPosition[LRow] := LTop;
        end;

        // Don't have a space between comboboxes if the subsequent combobox
        // doesn't have a caption
        if LLastAC <> nil then
        begin
          if (LLastAC.CommandStyle = csComboBox) and (LAC.CommandStyle <> csComboBox) and
            not LAC.ShowCaption then
            Inc(LLeft, 3);
        end;

        if IsLargeButton(LAC) or LAC.Separator or IsGallery(LAC) then
        begin
          LOldTop := LTop;
          LTop := FSpacingVert;
        end;
        LAC.DisplayRow := LRow;
        LCtrl.SetBounds(LLeft, LTop, LCtrl.Width, LCtrl.Height);

        Inc(LLeft, LCtrl.Width + FSpacingHorz);
        if (LAC.CommandProperties is TButtonProperties) and
          (TButtonProperties(LAC.CommandProperties).GroupPosition in [gpEnd, gpSingle]) then
          Inc(LLeft, 3);

        if IsLargeButton(LAC) or LAC.Separator or IsGallery(LAC) then
          LTop := LOldTop;
        LLastAC := LAC;
      end;
    end;
  end;
  // Auto size the group
  DisableAlign;
  try
    Width := RequiredWidth;
  finally
    EnableAlign;
  end;
  if FPage <> nil then
  begin
    if FPage.Visible then
      FPage.AlignGroups;
  end;
end;

procedure TCustomRibbonGroup.Assign(Source: TPersistent);
  function CloneControl(const Source : TControl; Parent : TWinControl) : TControl;
  var
    LName : String;
    MemStream : TMemoryStream;
    I : Integer;
    PropList: TPropList;
  begin
    Result := TControlClass(Source.ClassType).Create(Source.Owner);
    Result.Parent := Parent;
    LName := Source.Name;
    Source.Name := '';
    try
      MemStream := TMemoryStream.Create;
      try
        MemStream.WriteComponent(Source);
        MemStream.Position := 0;
        MemStream.ReadComponent(Result);
        for I := 0 to GetPropList(Source.ClassInfo, [tkMethod], @PropList) - 1 do
          SetMethodProp(Result, PropList[I], GetMethodProp(Source, PropList[I]));
      finally
        MemStream.Free;
      end;
    finally
      Source.Name := LName;
    end;
  end;
var
  LActionBar: TActionBarItem;
  ActionClientItem : TCollectionItem;
  LControl, LOriginal : TControl;
begin
  if Source is TCustomRibbonGroup then
  begin
    ActionManager := TCustomRibbonGroup(Source).ActionManager;
    ColorMap := TCustomRibbonGroup(Source).ColorMap;
    Caption := TCustomRibbonGroup(Source).Caption;
    DialogAction := TCustomRibbonGroup(Source).DialogAction;
    KeyTip := TCustomRibbonGroup(Source).KeyTip;
    GroupAlign := TCustomRibbonGroup(Source).GroupAlign;
    Rows := TCustomRibbonGroup(Source).Rows;
    FRibbon := TCustomRibbonGroup(Source).FRibbon;
    FPage := TCustomRibbonGroup(Source).Page;
    LActionBar := ActionManager.ActionBars.Add;
    LActionBar.ActionBar := Self;
    for ActionClientitem in TCustomRibbonGroup(Source).ActionClient.Items do
      if (TActionClientItem(ActionClientItem).CommandStyle = csControl) and
         Assigned(TControlProperties(TActionClientItem(ActionClientItem).CommandProperties).ContainedControl) then
      begin
        LOriginal := TControlProperties(TActionClientItem(ActionClientItem).CommandProperties).ContainedControl;
        LControl := CloneControl(LOriginal, Self);
        LControl.Tag := IntPtr(@LOriginal);
        TControlProperties(TActionClientItem(ActionClientItem).CommandProperties).ContainedControl := LControl;
      end;

    if (TCustomRibbonGroup(Source).ActionClient <> nil) and
      TCustomRibbonGroup(Source).ActionClient.HasItems then
      ActionClient.Items.Assign(TCustomRibbonGroup(Source).ActionClient.Items);

    for ActionClientitem in TCustomRibbonGroup(Source).ActionClient.Items do
      if (TActionClientItem(ActionClientItem).CommandStyle = csControl) and
         Assigned(TControlProperties(TActionClientItem(ActionClientItem).CommandProperties).ContainedControl) then
      begin
        LControl := TControlProperties(TActionClientItem(ActionClientItem).CommandProperties).ContainedControl;
        LOriginal := TControl(Pointer(LControl.Tag));
        LControl.Tag := LOriginal.Tag;
        TControlProperties(TActionClientItem(ActionClientItem).CommandProperties).ContainedControl := LOriginal;
      end;

    RecreateControls;
    AlignGroupControls;
  end
  else
    inherited;
end;

procedure TCustomRibbonGroup.AutoSizingChanged;
begin
  AutoSizing := True;
end;

// Iterates over any visible KeyTips and performs validation to determine
// if one of the KeyTips is a partial or full match.
//
// KeyTips that match are returned in the List parameter
procedure TCustomRibbonGroup.BarHandleKeyTips(const KeyTip: string;
  var KeyTips: TKeyTipList);
var
  I: Integer;
  LIntf: IRibbonKeyTip;
  LHandled: TKeyTipHandled;
begin
  if HasItems then
  begin
    for I := 0 to ItemCount - 1 do
    begin
      if Supports(Items[I].Control, IRibbonKeyTip, LIntf) then
      begin
        LIntf.HandleKeyTip(KeyTip, LHandled);
        if LHandled <> ktNone then
          KeyTips.Add(mtControl, LHandled, Items[I].Control);
      end;
    end;
  end;
end;

// Hides any visible KeyTips that commands are displaying.
//
// The KeyTips parameter contains a list of TKeyTipMatchItem objects that
// indicate the KeyTip associate with that command should not be close.
// When the KeyTips parameter is nil, all KeyTips are hidden
procedure TCustomRibbonGroup.BarHideKeyTips(KeyTips: TKeyTipList);
var
  LHideKeyTip: Boolean;
  I, J: Integer;
  LIntf: IRibbonKeyTip;
begin
  if HasItems then
  begin
    if KeyTips <> nil then
    begin
      for I := 0 to ItemCount - 1 do
      begin
        LHideKeyTip := True;
        for J := 0 to KeyTips.Count - 1 do
        begin
          if (Items[I].Control <> nil) and
            Items[I].Control.Equals(KeyTips[J].Control) then
          begin
            LHideKeyTip := False;
            Break;
          end;
        end;
        if LHideKeyTip and Supports(Items[I].Control, IRibbonKeyTip, LIntf) then
          LIntf.HideKeyTip('');
      end;
    end
    else
    begin
      for I := 0 to ItemCount - 1 do
      begin
        if Supports(Items[I].Control, IRibbonKeyTip, LIntf) then
          LIntf.HideKeyTip('');
      end;
    end;
  end;
end;

// Shows KeyTips for the commands
procedure TCustomRibbonGroup.BarShowKeyTips;
var
  I: Integer;
  LIntf: IRibbonKeyTip;
begin
  if not Visible then
  begin
    if GroupVariant = rgvCollapsed then
      ;
  end
  else
  begin
    if HasItems then
    begin
      for I := 0 to Items.Count - 1 do
      begin
        if Supports(Items[I].Control, IRibbonKeyTip, LIntf) then
        begin
          if Items[I].CommandStyle in [csButton, csGallery, csComboBox,
            csControl, csCheckBox, csRadioButton] then
          begin
            if TButtonProperties(Items[I].CommandProperties).ButtonSize = bsLarge then
              LIntf.ShowKeyTip(ktpGroupC)
            else
            begin
              if Rows = 3 then
              begin
                if Items[I].DisplayRow = 1 then
                  LIntf.ShowKeyTip(ktpGroupA)
                else if Items[I].DisplayRow = 2 then
                  LIntf.ShowKeyTip(ktpGroupB)
                else
                  LIntf.ShowKeyTip(ktpGroupC)
              end
              else if Rows = 2 then
              begin
                if Items[I].DisplayRow = 1 then
                  LIntf.ShowKeyTip(ktpGroupA)
                else
                  LIntf.ShowKeyTip(ktpGroupC);
              end
              else // All controls in the center row
                LIntf.ShowKeyTip(ktpGroupB);
            end;
          end
          else
            LIntf.ShowKeyTip(ktpTabs);
        end;
      end;
    end;
                                     
  end;
end;

function TCustomRibbonGroup.Clone: TCustomRibbonGroup;
begin
  Result := TCustomRibbonGroup.Create(Owner);
  Result.Parent := GetParentForm(Self);
  Result.SetBounds(-MAXINT, -MAXINT, Width, Height);
  Result.Assign(Self);
end;

procedure TCustomRibbonGroup.CMFontchanged(var Message: TMessage);
begin
  if (Page <> nil) and (Page.Ribbon <> nil) then
    Font.Size := Page.Ribbon.GetRibbonMetric(rmFontSize);
  inherited;
  if not (csLoading in ComponentState) then
  begin
    if FCollapsedControl <> nil then
      FCollapsedControl.Font := Font;
    AlignGroupControls;
  end;
end;

procedure TCustomRibbonGroup.CMItemDropPoint(var Message: TCMItemMsg);
begin
  inherited;
  AlignGroupControls;
end;

procedure TCustomRibbonGroup.CMMouseenter(var Message: TMessage);
begin
  inherited;
  MouseInControl := True;
end;

procedure TCustomRibbonGroup.CMMouseleave(var Message: TMessage);
var
  LPt: TPoint;
begin
  inherited;
  LPt := ScreenToClient(Mouse.CursorPos);
  if not ClientRect.Contains(LPt) then
  MouseInControl := False;
  FDialogButtonHot := False;
  Invalidate;
end;

procedure TCustomRibbonGroup.CMTextchanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

constructor TCustomRibbonGroup.Create(AOwner: TComponent);
begin
  inherited;
  FGroupVariant := rgvLarge;
  Brush.Style := bsClear;
  FDialogButtonHot := False;
  FSpacingVert := 2; // spacing between rows when there are 2 rows
  FSpacingHorz := 0; // spacing between groups
  Width := 200;
  Height := TCustomRibbon.cRibbonGroupHeight;
  Align := alNone;
  FGroupAlign := gaVertical;
  Rows := 3;
end;

procedure TCustomRibbonGroup.CreateCollapsedControl;
begin
  FCollapsedControl := TRibbonGroupCollapsedControl.Create(nil);
  FCollapsedControl.Parent := Page;
  FCollapsedControl.KeyTip := KeyTip;
  FCollapsedControl.Top := Top;
  FCollapsedControl.Caption := Caption;
  FCollapsedControl.Group := Self;
  FCollapsedControl.ActionManager := ActionManager;
  FCollapsedControl.OldWidth := Width;
  Width := FCollapsedControl.Width + 4;
end;

function TCustomRibbonGroup.CreateControl(AnItem: TActionClientItem): TCustomActionControl;
begin
  Result := inherited CreateControl(AnItem);
  AlignGroupControls;
end;

procedure TCustomRibbonGroup.CreateControls;
begin
  inherited;
  AlignGroupControls;
end;

destructor TCustomRibbonGroup.Destroy;
begin
  FreeAndNil(FCollapsedControl);
  FreeAndNil(FKeyTipForm);
  inherited;
end;

procedure TCustomRibbonGroup.DockDrop(Source: TDragDockObject; X, Y: Integer);
begin
  inherited;
  AlignGroupControls;
end;

procedure TCustomRibbonGroup.DragDrop(Source: TObject; X: Integer; Y: Integer);
begin
  inherited;
  // Check to see if the Action Manager has been newly assigned
  if (ActionManager <> nil) and not (csAcceptsControls in ControlStyle) then
  begin
    ControlStyle := ControlStyle + [csAcceptsControls];
    if FRibbon.ActionManager = nil then
      FRibbon.ActionManager := ActionManager;
    Invalidate;
  end;
end;

procedure TCustomRibbonGroup.DoDropItem(Source: TActionItemDragObject; const X,
  Y: Integer);
begin
  inherited;
  AlignGroupControls;
end;

procedure TCustomRibbonGroup.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited;
  AlignGroupControls;
end;

procedure TCustomRibbonGroup.DrawShowDialogButton;
var
  LRect: TRect;
begin
  LRect := GetDialogButtonRect;
  if DialogButtonHot then
  begin
    if IsLeftMouseButtonPressed(Self) then
      RibbonStyle.DrawElement(srgDialogButtonPressed, Canvas, LRect)
    else
      RibbonStyle.DrawElement(srgDialogButtonHover, Canvas, LRect);
  end
  else
    RibbonStyle.DrawElement(srgDialogButton, Canvas, LRect);
end;

function TCustomRibbonGroup.GetCanCollapse: Boolean;
begin
  // Groups with only one command on them that
  // is a large button are not collapsable
  Result := not HasItems or HasItems and ((ItemCount <> 1) or
    ((Items[0].CommandProperties is TButtonProperties) and
     (TButtonProperties(Items[0].CommandProperties).ButtonSize <> bsLarge)));
end;

function TCustomRibbonGroup.GetCaptionHeight: Integer;
begin
  if (Page <> nil) and (Page.Ribbon <> nil) then
    Result := Page.Ribbon.GetRibbonMetric(rmGroupCaptionHeight)
  else
    Result := TCustomRibbon.cRibbonGroupCaptionHeight;
end;

function TCustomRibbonGroup.GetCaptionRect: TRect;
begin
  Result := Rect(1, Height - GetCaptionHeight - 1, Width - 2, Height - 2);
end;

function TCustomRibbonGroup.GetHasGallery: Boolean;
var
  I: Integer;
  LAC: TActionClientItem;
begin
  Result := HasItems;
  if Result then
  begin
    for I := 0 to ItemCount - 1 do
    begin
      LAC := Items[I];
      Result := (LAC.CommandStyle = csGallery) and
        (TGalleryProperties(LAC.CommandProperties).GalleryType = gtRibbon);
      if Result then
        Break;
    end;
  end;
end;

function TCustomRibbonGroup.GetDialogButtonRect: TRect;
begin
  Result := GetCaptionRect;
  Result.Left := Result.Right - 15;
  Result.Bottom := Result.Top + 14;
end;

function TCustomRibbonGroup.GetGroupHeight: Integer;
begin
  if (Page <> nil) and (Page.Ribbon <> nil) then
    Result := Page.Ribbon.GetRibbonMetric(rmGroupHeight)
  else
    Result := TCustomRibbon.cRibbonGroupHeight;
end;

function TCustomRibbonGroup.GetGroupWidth: Integer;
begin
  if GroupVariant = rgvCollapsed then
    Result := FCollapsedControl.Width
  else
    Result := Width;
end;

function TCustomRibbonGroup.GetKeyTip: string;
begin
  Result := FKeyTip;
end;

function GetGroupAllowance(const AItem: TActionClientItem): Integer;
begin
  if (AItem.CommandProperties is TButtonProperties) and
    (TButtonProperties(AItem.CommandProperties).GroupPosition in [gpSingle, gpEnd]) then
    Result := 2
  else
    Result := 0;
end;

function TCustomRibbonGroup.GetRequiredWidth: Integer;
const
  DefaultGroupWidth: array [Boolean] of Integer = (100, 8);
var
  I: Integer;
  LAC: TActionClientItem;
  LXOffSet: Integer;
  LYOffSet: Integer;
  LColumnWidth: Integer;
  LRowWidth: array [0..2] of Integer;
  LCurrentRow: Integer;
  LGroupEmpty: Boolean;
begin
  LGroupEmpty := (HasItems and (ItemCount = 1) and (Items[0].Control = nil)) or not HasItems;
  Result := DefaultGroupWidth[not LGroupEmpty]; // Minimium width (even for empty groups)
  if LGroupEmpty then
  begin
    if FRequiredWidth > 40 then
      Result := FRequiredWidth;
    Exit;
  end;
  if GroupAlign = gaVertical then
  begin
    LXOffSet := 0;
    LColumnWidth := 0;
    for I := 0 to ItemCount - 1 do
    begin
      LAC := Items[I];
      if LAC.Control <> nil then
      begin
        LAC.Control.CalcBounds;
        LAC.Control.Visible := True;
        if LAC.Control.Left <> LXOffSet then
        begin
          Inc(Result, LColumnWidth);
          LXOffSet := LAC.Control.Left;
          LColumnWidth := LAC.Control.Width;
        end
        else
          LColumnWidth := Max(LColumnWidth, LAC.Control.Width);
      end;
    end;
    Inc(Result, LColumnWidth);
  end
  else
  begin
    LYOffSet := -1;
    LColumnWidth := 0;
    LCurrentRow := 0;
    LRowWidth[0] := -1;
    LRowWidth[1] := -1;
    LRowWidth[2] := -1;
    for I := 0 to ItemCount - 1 do
    begin
      LAC := Items[I];
      if LAC.Control <> nil then
      begin
        LAC.Control.CalcBounds;
        LAC.Control.Visible := True;
        if (LAC.Control.Top <> LYOffSet) and (LAC.Control.Top > LYOffSet) then
        begin
          LRowWidth[LCurrentRow] := LColumnWidth;
          if LYOffSet <> -1 then
          begin
            Inc(LCurrentRow);
          end;
          LYOffSet := LAC.Control.Top;
          LColumnWidth := LAC.Control.Width + GetGroupAllowance(LAC);
        end
        else
        begin
          LColumnWidth := LColumnWidth + LAC.Control.Width + GetGroupAllowance(LAC);
        end;
      end
      else
      begin
        Result := Width;
        Break;
      end;
    end;
    if LYOffSet > -1 then
    begin
      LRowWidth[LCurrentRow] := LColumnWidth;
      Result := DefaultGroupWidth[ItemCount > 0] + Max(LRowWidth[0], Max(LRowWidth[1], LRowWidth[2]));
    end;
  end;
  FRequiredWidth := Result;
end;

procedure TCustomRibbonGroup.HandleKeyTip(const KeyTip: string;
  var Handled: TKeyTipHandled);
var
  LIntf: IRibbonKeyTip;
begin
  if GroupVariant = rgvCollapsed then
  begin
    if Supports(FCollapsedControl, IRibbonKeyTip, LIntf) then
    begin
      LIntf.HandleKeyTip(KeyTip, Handled);
    end;
  end
  else if (FDialogAction <> nil) then
    TKeyTipValidator.Validate(KeyTip, GetKeyTip, Self, Handled)
  else
    Handled := ktNone;
end;

procedure TCustomRibbonGroup.HideControls;
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
  begin
    if Items[I].Control <> nil then
      Items[I].Control.Visible := False;
  end;
  for I := 0 to ControlCount - 1 do
  begin
    if (Controls[I] is TCustomToolScrollBtn) then
      Controls[I].Visible := False;
  end;
end;

procedure TCustomRibbonGroup.HideKeyTip(const Match: string);
var
  LIntf: IRibbonKeyTip;
begin
  if GroupVariant = rgvCollapsed then
  begin
    if Supports(FCollapsedControl, IRibbonKeyTip, LIntf) then
    begin
      LIntf.HideKeyTip(Match);
    end;
  end
  else if (GetKeyTip <> Match) or not ((Length(GetKeyTip) = 2) and
    (GetKeyTip[1] = Match[1]) and (Length(Match) = 1)) then
    FreeAndNil(FKeyTipForm);
end;

procedure TCustomRibbonGroup.KeyTipClick;
begin
  Click;
end;

procedure TCustomRibbonGroup.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (FDialogAction <> nil) and GetDialogButtonRect.Contains(Point(X, Y)) then
    DrawShowDialogButton;
end;

procedure TCustomRibbonGroup.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  LPt: TPoint;
begin
  inherited;
  if (FDialogAction <> nil) then
  begin
    LPt := Point(X, Y);
    DialogButtonHot := not DesignMode and GetDialogButtonRect.Contains(LPt);
  end;
end;

procedure TCustomRibbonGroup.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Button = mbLeft) then
  begin
    if (DialogAction <> nil) and GetDialogButtonRect.Contains(Point(X, Y)) then
    begin
      DialogAction.Execute;
      if GetParentForm(Self) is TRibbonGroupDockForm then
        Winapi.Windows.SetFocus(Application.MainForm.Handle);
    end;
  end;
end;

procedure TCustomRibbonGroup.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent is TCustomActionControl then
    begin
      // Only update Quick Access Toolbar width if not Loading or
      // Destroying the Toolbar
      if ComponentState * [csLoading, csDestroying] = [] then
        AlignGroupControls;
    end
    else if AComponent = FDialogAction then
      FDialogAction := nil;
  end;
end;

procedure TCustomRibbonGroup.Paint;
var
  LRect: TRect;
  LCaptionRect: TRect;
  LFlags: Cardinal;
begin
  LRect := ClientRect;
  LRect.Left := LRect.Left - 10;
  LRect.Top := LRect.Top - Top;
  LRect.Right := LRect.Right + 10;
  LRect.Bottom := LRect.Top + Parent.Height;
  RibbonStyle.DrawElement(srPage, Canvas, LRect, FRibbon.GetRibbonMetric(rmCaption));
  LRect := ClientRect;
  LCaptionRect := GetCaptionRect;
  if not Enabled then
  begin
    RibbonStyle.DrawElement(srgBackgroundDisabled, Canvas, LRect);
    RibbonStyle.DrawElement(srgCaptionDisabled, Canvas, LCaptionRect);
  end
  else if MouseInControl then
  begin
    RibbonStyle.DrawElement(srgBackgroundHover, Canvas, LRect);
    RibbonStyle.DrawElement(srgCaptionHover, Canvas, LCaptionRect);
  end
  else
  begin
    RibbonStyle.DrawElement(srgBackground, Canvas, LRect);
    RibbonStyle.DrawElement(srgCaption, Canvas, LCaptionRect);
  end;
  // Adjust caption rect for text
  if (FDialogAction <> nil) then
    LCaptionRect.Right := LCaptionRect.Right - 15;
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign(Font);
  Canvas.Font.Color := TCustomRibbonColorMap(ColorMap).GroupFontColor;
  LCaptionRect.Left := LCaptionRect.Left + 3;
  LFlags := DT_CENTER or DT_NOPREFIX or DT_SINGLELINE or DT_END_ELLIPSIS or DT_VCENTER;
  DrawText(Canvas.Handle, Caption, -1, LCaptionRect, LFlags);
  if (FDialogAction <> nil) then
    DrawShowDialogButton;
end;

procedure TCustomRibbonGroup.Resize;
begin
  inherited;
  AlignGroupControls;
end;

function TCustomRibbonGroup.RibbonStyle: TRibbonStyleActionBars;
begin
  if Style is TRibbonStyleActionBars then
    Result := TRibbonStyleActionBars(Style)
  else
    Result := RibbonLunaStyle;
end;

procedure TCustomRibbonGroup.SetAutoSizing(const Value: Boolean);
begin
  inherited SetAutoSizing(True);
end;

procedure TCustomRibbonGroup.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (Page <> nil) and (Page.Ribbon <> nil) then
    inherited SetBounds(ALeft, 3, AWidth, GetGroupHeight)
  else
    inherited;
end;

procedure TCustomRibbonGroup.SetDialogAction(const Value: TContainedAction);
begin
  if FDialogAction <> Value then
  begin
    if FDialogAction <> nil then
      FDialogAction.RemoveFreeNotification(Self);
    FDialogAction := Value;
    if FDialogAction <> nil then
      FDialogAction.FreeNotification(Self);
    Invalidate;
  end;
end;

procedure TCustomRibbonGroup.SetDialogButtonHot(const Value: Boolean);
begin
  if FDialogButtonHot <> Value then
  begin
    FDialogButtonHot := Value;
    Invalidate;
  end;
end;

procedure TCustomRibbonGroup.SetKeyTip(const Value: string);
begin
  FKeyTip := Value;
end;

procedure TCustomRibbonGroup.SetMouseInControl(const Value: Boolean);
begin
  if FMouseInControl <> Value then
  begin
    FMouseInControl := Value;
    Invalidate;
  end;
end;

procedure TCustomRibbonGroup.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if (AParent is TCustomRibbonPage) or (AParent is TRibbonGroupDockForm) or
    (AParent is TCustomForm) then
  begin
    if AParent is TCustomRibbonPage then
      FPage := AParent as TRibbonPage
    else if (AParent is TRibbonGroupDockForm) and
      (TRibbonGroupDockForm(AParent).ParentControl is TRibbonPage) then
      FPage := TRibbonPage(TRibbonGroupDockForm(AParent).ParentControl)
    else
      FPage := nil;
    if FPage <> nil then
      FRibbon := FPage.Ribbon;
  end
  else
  begin
    if FPage <> nil then
      FRibbon := FPage.Ribbon;
    if (AParent <> nil) and (not (csDestroying in ComponentState) or not (csLoading in ComponentState)) then
      raise EInvalidOperation.Create(SInvalidRibbonGroupParent)
  end;
end;

procedure TCustomRibbonGroup.SetRows(const Value: Integer);
begin
  if FRows <> Value then
  begin
    FRows := Value;
    case FRows of
      1: FRowStart := 22;
      2: FRowStart := 8;
      3: FRowStart := 0;
    else
      // Default to 3 rows if an invalid number of rows is selected
      FRows := 3;
      FRowStart := 0;
    end;
    DisableAlign;
    try
      AlignGroupControls;
    finally
      EnableAlign;
    end;
  end;
end;

procedure TCustomRibbonGroup.SetGroupAlign(const Value: TGroupAlign);
begin
  if FGroupAlign <> Value then
  begin
    FGroupAlign := Value;
    AlignGroupControls;
  end;
end;

procedure TCustomRibbonGroup.SetGroupIndex(const Value: Integer);
var
  I: Integer;
  LFound: Boolean;
begin
  if (FGroupIndex <> Value) and (Value > -1) then
  begin
    LFound := False;
    if Page <> nil then
    begin
      for I := 0 to Page.GroupCount - 1 do
      begin
        if Page.Groups[I] <> Self then
        begin
          LFound := Page.Groups[I].GroupIndex = Value;
          if LFound then
            Break;
        end;
      end;
    end;
    if (not LFound) or FPage.AlignDisabled then
      FGroupIndex := Value;
    if Page <> nil then
      Page.AlignGroups;
  end;
end;

procedure TCustomRibbonGroup.SetupDropDownBtn;
begin
  // No implementation as groups can't be customized
end;

procedure TCustomRibbonGroup.SetGroupVariant(const Value: TRibbonGroupVariant);
begin
  if FGroupVariant <> Value then
  begin
    FGroupVariant := Value;
    DisableAlign;
    try
      case FGroupVariant of
        rgvCollapsed: CreateCollapsedControl;
        rgvLarge:
          begin
            if FCollapsedControl <> nil then
            begin
              Width := FCollapsedControl.OldWidth;
              FreeAndNil(FCollapsedControl);
              Parent := Page;
            end;
          end;
        rgvMedium:
          begin
          end;
        rgvSmall:
          begin
          end;
      end;
    finally
      EnableAlign;
      AlignGroupControls;
    end;
    Page.AlignGroups;
  end;
end;

procedure TCustomRibbonGroup.ShowControls;
var
  I: Integer;
begin
  for I := 0 to ControlCount - 1 do
  begin
    if Controls[I] <> nil then
      Controls[I].Visible := not Controls[I].InheritsFrom(TCustomToolScrollBtn);
  end;
end;

procedure TCustomRibbonGroup.ShowKeyTip(const Position: TKeyTipPosition);
var
  LRect: TRect;
  LPt: TPoint;
  LIntf: IRibbonKeyTip;
begin
  if GroupVariant = rgvCollapsed then
  begin
    if Supports(FCollapsedControl, IRibbonKeyTip, LIntf) then
    begin
      LIntf.ShowKeyTip(ktpGroupD);
    end;
  end
  else
  begin
    if (FDialogAction <> nil) and (KeyTip <> '') then
    begin
      LRect := GetDialogButtonRect;
      LPt := ClientToScreen(Point(LRect.Left, LRect.Top));
      LRect := Rect(LPt.X + 8, LPt.Y + 14, 0, 0);
      FKeyTipForm := Vcl.RibbonActnCtrls.ShowKeyTip(KeyTip, True, True, LRect, ktpGroupD);
    end;
  end;
end;

procedure TCustomRibbonGroup.StyleChanged(AStyle: TRibbonStyleActionBars);
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
  begin
    if (Items[I].Control <> nil) and (Items[I].CommandStyle = csComboBox) then
    begin
      TRibbonComboControl(Items[I].Control).ComboBox.Color :=
        TCustomRibbonColorMap(ColorMap).ControlInactiveColor;
    end;
  end;
end;

{ TCustomTabData }

function SortByWidth(Item1, Item2: {$IFDEF CLR}TObject{$ELSE}Pointer{$ENDIF}): Integer;
begin
  Result := TCustomTabData.TItemData(Item2).BestWidth -
    TCustomTabData.TItemData(Item1).BestWidth;
end;

// Sets up a data object associated with the nominated tab.
procedure TCustomTabData.Add(ATab: TRibbonTabItem);
var
  LData: TItemData;
  I: Integer;
begin
  // Ensure no duplicates
  for I := 0 to FItems.Count - 1 do
  begin
    if TItemData(FItems[I]).TabIndex = ATab.Index then
      Exit;
  end;
  LData := TItemData.Create;
  LData.Tab := ATab;
  LData.TabIndex := ATab.Index;
  LData.BestWidth := ATab.BestTabWidth;
  LData.MinWidth := ATab.MinTabwidth;
  LData.NewWidth := -1;
  LData.MinTruncWidth := ATab.MinTruncatedWidth;
  FItems.Add(LData);
  FItems.Sort(SortByWidth);
  FCalculationDone := False;
end;

// Resets data. This is typically done whenever the width of the ribbon is changed.
procedure TCustomTabData.Clear;
begin
  FItems.Clear;
  FAvailableSpace := 0;
  FCalculationDone := False;
end;

constructor TCustomTabData.Create(AOwner: TCustomRibbon);
begin
  inherited Create;
  FItems := TObjectList.Create(True);
  FOwner := AOwner;
end;

destructor TCustomTabData.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

function TCustomTabData.GetBestWidth(Idx: Integer): Integer;
begin
  Result := TItemData(FItems[Idx]).BestWidth;
end;

function TCustomTabData.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

// Retrieves the data object associated with a tab by tab index
function TCustomTabData.GetItemByIndex(Idx: Integer): TItemData;
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
  begin
    if TItemData(FItems[I]).TabIndex = Idx then
    begin
      Result := TItemData(FItems[I]);
      Exit;
    end;
  end;
  Result := nil;
end;

// Returns the calculated width of a tab (by tab index)
function TCustomTabData.GetNewWidth(Idx: Integer): Integer;
begin
  if ReCalculateTabWidths and (ItemCount > Idx) then
    Result := GetItemByIndex(Idx).NewWidth
  else
    Result := 0;
end;

function TCustomTabData.GetSeparatorOpacity: Byte;
begin
  case FTabSeparatorState of
    tssHidden: Result := 0;
    tssLight: Result := 85;
    tssMedium: Result := 170;
    tssDark: Result := 255;
  else
    Result := 255;
  end;
end;

// Recalculates tab widths based on the current available space. This is called
// each time the width is changed.
procedure TCustomTabData.CalculateTabWidths(AAvailableSpace: Integer; APages: TRibbonTabs);
var
  I: Integer;
begin
  Clear;
  FAvailableSpace := AAvailableSpace;
  for I := 0 to APages.Count - 1 do
    Add(APages[I]);
  ReCalculateTabWidths;
  ResizeActiveRibbonGroup;
end;

// Controls the width of group items that appear on the active tab page
procedure TCustomTabData.ResizeActiveRibbonGroup;
var
  LActivePage: TCustomRibbonPage;
  LDirection: TDeltaWidthDirection;
  LGroup: TCustomRibbonGroup;
  LWiderGroup: TCustomRibbonGroup;
  I: Integer;

  function TotalGroupWidth: Integer;
  var
    J: Integer;
    LGroup: TCustomRibbonGroup;
  begin
    Result := 0;
    for J := 0 to LActivePage.GroupCount - 1 do
    begin
      LGroup := LActivePage.Groups[J];
      if (LWiderGroup <> nil) and LGroup.Equals(LWiderGroup) then
      begin
        if (LWiderGroup.GroupVariant = rgvCollapsed) and (LWiderGroup.CollapsedControl <> nil) then
          Inc(Result, LWiderGroup.CollapsedControl.OldWidth + TCustomRibbon.cRibbonTabSpacing)
      end
      else
      Inc(Result, LGroup.GroupWidth + TCustomRibbon.cRibbonTabSpacing);
    end;
    Dec(Result, TCustomRibbon.cRibbonTabSpacing);
  end;

begin
  LActivePage := Owner.GetActivePage;
  LWiderGroup := nil;
  // At designtime the groups are never displayed in their collapsed state
  if (csDesigning in Owner.ComponentState) or (LActivePage = nil) then
    Exit;
  // Determine direction of travel
  if (FLastPageWidth = 0) or
     (FLastActivePage <> LActivePage) then
    FLastPageWidth := LActivePage.Width + 1;
  FLastActivePage := LActivePage;

  if (FLastPageWidth < LActivePage.Width) or
    (TotalGroupWidth < LActivePage.Width) then
    LDirection := dwWider
  else
    LDirection := dwNarrower;
  FLastPageWidth := LActivePage.Width;

  case LDirection of
    dwNarrower:
      begin
        if TotalGroupWidth > LActivePage.Width then
        begin
          for I := LActivePage.GroupCount - 1 downto 0 do
          begin
            LGroup := LActivePage.Groups[I];
            if LGroup.GroupVariant <> rgvCollapsed then
            begin
              if not LGroup.HasGallery then
              begin
                if LGroup.CanCollapse then
                begin
                  // Push the group
                  LActivePage.CollapseGroup(LGroup);
                  LGroup.GroupVariant := rgvCollapsed;
                  if TotalGroupWidth <= LActivePage.Width then
                    Break;
                end;
              end
            end;
          end;
        end;
      end;
    dwWider:
      begin
        for I := 1 to LActivePage.CollapseGroupCount do
        begin
          LGroup := LActivePage.GetNextVisibleGroup;
          LWiderGroup := LGroup;
          try
          if TotalGroupWidth > LActivePage.Width then
          begin
            LActivePage.CollapseGroup(LGroup);
            Break;
            end
            else
              LGroup.GroupVariant := rgvLarge;
          finally
            LWiderGroup := nil;
          end;
        end;
      end;
  end; //case
end;

// Private method to calculate tab widths based on the various rules
// described in the specification.
function TCustomTabData.ReCalculateTabWidths: Boolean;
type
  TCalculationType = (ctNone, ctUniform, ctProgressive, ctScrollButton);
var
  LTotalTabWidth: Integer;
  LTotalMinTabWidth: Integer;
  LTotalTruncWidth: Integer;
  LDelta: Integer;
  LCalcType: TCalculationType;

  // Determine scroll button rectangles, etc based on current ribbon width
  procedure InitialiseCalcs;
  var
    I: Integer;
    LItemData: TItemData;
  begin
    LTotalTabWidth := 0;
    LTotalMinTabWidth := 0;
    LTotalTruncWidth := 0;

    // Left scroll button rectangle
    FLeftTabScrollButtonRect :=
      Rect(TCustomRibbon.cRibbonFirstTabOffSet,
           FOwner.GetRibbonMetric(rmCaption) + 1,
           TCustomRibbon.cRibbonFirstTabOffSet +
             TCustomRibbon.cRibbonTabScrollButtonWidth,
           FOwner.GetRibbonMetric(rmCaption) + FOwner.GetRibbonMetric(rmTabHeight));
    FRightTabScrollButtonRect := FLeftTabScrollButtonRect;

    // Right scroll button rectangle
    OffsetRect(FRightTabScrollButtonRect,
      FAvailableSpace - TCustomRibbon.cRibbonTabScrollButtonWidth, 0);

    // Calculate tab width defaults
    for I := 0 to ItemCount - 1 do
    begin
      LItemData := TItemData(FItems[I]);
      Inc(LTotalTabWidth,  LItemData.BestWidth + TCustomRibbon.cRibbonTabSpacing);
      Inc(LTotalMinTabWidth,  LItemData.MinWidth + TCustomRibbon.cRibbonTabSpacing);
      Inc(LTotalTruncWidth, LItemData.MinTruncWidth + TCustomRibbon.cRibbonTabSpacing);
      LItemData.NewWidth := LItemData.BestWidth;
    end;

    // Define an update rectangle for the tabs
    FTabUpdateRect := Rect(
      TCustomRibbon.cRibbonFirstTabOffSet,
      FOwner.GetRibbonMetric(rmCaption),
      TCustomRibbon.cRibbonFirstTabOffSet + FAvailableSpace,
      FOwner.GetRibbonMetric(rmCaption) + FOwner.GetRibbonMetric(rmTabHeight) + 2);

    // Work out the sort of calculation that is required.
    if FAvailableSpace > LTotalTabWidth then
      LCalcType := ctNone
    else if FAvailableSpace > LTotalMinTabWidth then
      LCalcType := ctUniform
    else if FAvailableSpace > LTotalTruncWidth then
      LCalcType := ctProgressive
    else
      LCalcType := ctScrollButton;
  end;

  function CalcTotalTruncation(P: Integer): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := FirstVisibleTabIndex to ItemCount - 1 do
    begin
      if TItemData(FItems[I]).MinWidth >= P then
        Inc(Result, abs(P - TItemData(FItems[I]).MinWidth));
    end;
  end;

  // Calculates tab sizes by progressively shortening the wide tabs first
  // Uses an iterative technique to converge on a suitable solution.
  procedure DoProgressive;
  var
    LGuess: Integer;
    LDiff: Integer;
    I: Integer;
  begin
    FTabSeparatorState := tssMedium;
    FScrollButtons := [];
    FFirstVisibleTabIndex := 0;
    FLastVisibleTabIndex := ItemCount - 1;
    LDelta := LTotalMinTabWidth - FAvailableSpace;
    if ItemCount > 0 then
    begin
      LGuess := TItemData(FItems[0]).MinWidth div 2;
      LDiff := CalcTotalTruncation(LGuess);
      while Abs(LDiff - LDelta) > ItemCount do
      begin
        if LDiff < LDelta then
          Dec(LGuess)
        else
          Inc(LGuess);
        LDiff := CalcTotalTruncation(LGuess);
      end;
      for I := 0 to ItemCount - 1 do
      begin
        if TItemData(FItems[I]).MinWidth > LGuess then
          TItemData(FItems[I]).NewWidth := LGuess
        else
          TItemData(FItems[I]).NewWidth := TItemData(FItems[I]).MinWidth;
      end;
    end;
  end;

  // Calculate tab widths by removing the same amount from each visible tab
  procedure DoUniform;
  var
    I: Integer;
    LRem: Integer;
  begin
    FTabSeparatorState := tssLight;
    FScrollButtons := [];
    FFirstVisibleTabIndex := 0;
    FLastVisibleTabIndex := ItemCount - 1;
    // calculate the amount to remove from each tab ...
    LDelta := abs(FAvailableSpace - LTotalTabWidth) div ItemCount;
    LRem := abs(FAvailableSpace - LTotalTabWidth) mod ItemCount;
    // ... then remove it.
    if LDelta > 0 then
    begin
      for I := 0 to ItemCount - 1 do
	  begin
        if I < FirstVisibleTabIndex then
          TItemData(FItems[I]).NewWidth := 0
        else
          TItemData(FItems[I]).NewWidth := TItemData(FItems[I]).NewWidth - LDelta;
	  end;
    end;
    for I := FirstVisibleTabIndex to LRem do
      TItemData(FItems[I]).NewWidth := TItemData(FItems[I]).NewWidth - 1;
  end;

  // All tabs displayed at their best (maximum) width
  procedure DoNone;
  begin
    FTabSeparatorState := tssHidden;
    FFirstVisibleTabIndex := 0;
    FLastVisibleTabIndex := ItemCount - 1;
    FScrollButtons := [];
  end;

  // All tabs at their minimum width, so need to turn scroll buttons on.
  procedure DoScrollButton;
  var
    I: Integer;
    LWidth: Integer;
    LLeft: Integer;
    LTabTest: TRect;
    LTabRect: TRect;
  begin
    if ItemCount > 0 then
    begin
      FTabSeparatorState := tssDark;
      LWidth := FTabUpdateRect.Left;
      LLeft := FTabUpdateRect.Left;
      for I := 0 to ItemCount - 1 do
      begin
        TItemData(FItems[I]).NewWidth := TItemData(FItems[I]).MinTruncWidth;
        TItemData(FItems[I]).Left := LLeft;
        if (I >= FirstVisibleTabIndex) and
           (LWidth < FTabUpdateRect.Right) then
        begin
          FLastVisibleTabIndex := I;
          Inc(LLeft, TItemData(FItems[I]).MinTruncWidth + TCustomRibbon.cRibbonTabSpacing);
        end;
      end;

      FScrollButtons := [tsbTabRight, tsbTabLeft];
      if FFirstVisibleTabIndex <= 0 then
        Exclude(FScrollButtons, tsbTabLeft);

      LTabTest := FTabUpdateRect;
      LTabTest.Left := TItemData(FItems[FLastVisibleTabIndex]).Left;
      LTabTest.Right := LTabTest.Left + TItemData(FItems[FLastVisibleTabIndex]).MinTruncWidth;
      LTabRect := LTabTest;
      IntersectRect(LTabTest, LTabRect, FTabUpdateRect);
      if EqualRect(LTabTest, LTabRect) then
        Exclude(FScrollButtons, tsbTabRight);
    end;
  end;

begin
  if not FCalculationDone then
  try
    InitialiseCalcs;
    case LCalcType of
      ctNone: DoNone; // no calculations needed
      ctUniform: DoUniform;
      ctProgressive: DoProgressive;
      ctScrollButton: DoScrollButton;
    end;
  finally
    FCalculationDone := ItemCount > 0;
  end;
  Result := FCalculationDone;
end;

// Sets the first visible tab index. Used whenever one of the tab scroll
// buttons is pressed
procedure TCustomTabData.SetFirstVisibleTabIndex(const Value: integer);
begin
  FFirstVisibleTabIndex := Value;
  FScrollButtons := [];
  if FFirstVisibleTabIndex > 0 then
    Include(FScrollButtons, tsbTabLeft);
end;

{ TApplicationMenu }

procedure TApplicationMenu.Assign(Source: TPersistent);
begin
  if Source is TApplicationMenu then
  begin
    Caption := TApplicationMenu(Source).Caption;
    Icon := TApplicationMenu(Source).Icon;
    IconSize := TApplicationMenu(Source).IconSize;
    KeyTip := TApplicationMenu(Source).KeyTip;
    Menu := TApplicationMenu(Source).Menu;
    ScreenTip := TApplicationMenu(Source).ScreenTip;
    CommandType := TApplicationMenu(Source).CommandType;
  end
  else
    inherited;
end;

procedure TApplicationMenu.Initialize(AManager: TCustomScreenTipsManager);
var
  LControl: TControl;
  LActionClient: TActionClientItem;
  I: Integer;
begin
  FScreenTipPopup.ScreenTipManager := AManager;
  if (FMenu = nil) or (FMenu.ActionManager = nil) then
    Exit;
  LControl := nil;
  LActionClient := nil;
  for I := 0 to FMenu.ActionManager.ActionBars.Count - 1 do
  begin
    if (FMenu.ActionManager.ActionBars[I].ActionBar <> nil) and
      FMenu.ActionManager.ActionBars[I].ActionBar.Equals(FMenu) then
    begin
      if not FMenu.ActionManager.ActionBars[I].HasItems then
      begin
        LActionClient := FMenu.ActionManager.ActionBars[I].Items.Add;
        LActionClient.Items.Add;
      end
      else
        LActionClient := FMenu.ActionManager.ActionBars[I].Items[0];
      LControl := LActionClient.Control;
      Break;
    end;
  end;
  if LActionClient = nil then
  begin
    LActionClient := FMenu.ActionManager.ActionBars.Add.Items.Add;
    LControl := LActionClient.Control;
  end;
  FScreenTipPopup.Associate := LControl;
end;

constructor TApplicationMenu.Create(ARibbon: TCustomRibbon);
begin
  inherited Create;
  FRibbon := ARibbon;
  FIcon := TIcon.Create;
  FIconSize := isMedium;
  FCaption := SRecentDocuments;
  FScreenTipPopup := TScreenTipsPopup.Create(nil);
end;

destructor TApplicationMenu.Destroy;
begin
  FIcon.Free;
  FScreenTipPopup.Free;
  inherited;
end;

function TApplicationMenu.GetActionClientItem: TActionClientItem;
var
  I: Integer;
  LActionBarItem: TActionBarItem;
begin
  Result := nil;
  if (Menu <> nil) and (Menu.ActionManager <> nil) then
  begin
    for I := 0 to Menu.ActionManager.ActionBars.Count - 1 do
    begin
      if (Menu.ActionManager.ActionBars[I].ActionBar <> nil) and
        (Menu.ActionManager.ActionBars[I].ActionBar.Equals(Menu)) then
      begin
        LActionBarItem := Menu.ActionManager.ActionBars[I];
        if LActionBarItem.HasItems then
        begin
          Result := LActionBarItem.Items[0];
          Break;
        end;
      end;
    end;
  end;
end;

function TApplicationMenu.GetKeyTip: string;
var
  LActionClient: TActionClientItem;
begin
  LActionClient := GetActionClientItem;
  if LActionClient <> nil then
    Result := LActionClient.KeyTip
  else
    Result := '';
end;

function TApplicationMenu.GetScreenTipItem: TScreenTipItem;
begin
  Result := FScreenTipPopup.ScreenTip;
end;

procedure TApplicationMenu.Show(const Visible: Boolean);
var
  LActionBarItem: TActionBarItem;
begin
  LActionBarItem := GetActionBarItem(Menu);
  if LActionBarItem <> nil then
  begin
    if (csDesigning in Menu.ComponentState) then
    begin
      if not Visible then
        Menu.ControlStyle := Menu.ControlStyle + [csNoDesignVisible]
      else
        Menu.ControlStyle := Menu.ControlStyle - [csNoDesignVisible];
    end;
    LActionBarItem.Visible := Visible;
  end;
end;

function TApplicationMenu.IsCaptionStored: Boolean;
begin
  Result := Caption <> SRecentDocuments;
end;

function TApplicationMenu.IsKeyTipStored: Boolean;
begin
  Result := KeyTip <> 'F'; // do not localise
end;

procedure TApplicationMenu.MenuControlCreated(Sender: TObject;
  var Control: TCustomActionControl);
begin
  FScreenTipPopup.Associate := Control;
  Control.ShowHint := True;
end;

procedure TApplicationMenu.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure TApplicationMenu.SetCommandType(const Value: TCommandType);
begin
  if FCommandType <> Value then
    FCommandType := Value;
end;

procedure TApplicationMenu.SetIcon(const Value: TIcon);
begin
  FIcon.Assign(Value);
  if FMenu <> nil then
    FMenu.Invalidate;
end;

procedure TApplicationMenu.SetIconSize(const Value: TIconSize);
begin
  if FIconSize <> Value then
  begin
    FIconSize := Value;
    FRibbon.InvalidateHeaderArea;
  end;
end;

procedure TApplicationMenu.SetKeyTip(const Value: string);
var
  LActionClient: TActionClientItem;
begin
  LActionClient := GetActionClientItem;
  if LActionClient <> nil then
    LActionClient.KeyTip := Value;
end;

procedure TApplicationMenu.SetMenu(const Value: TRibbonApplicationMenuBar);
var
  LActionBars: TActionBars;
  LBarFound: Boolean;
  LActionBarItem: TActionBarItem;
  LActionClient: TActionClientItem;
  I: Integer;
begin
  if (FMenu <> nil) then
    FMenu.SetRibbon(nil);
  FMenu := Value;
  if Value <> nil then
  begin
    FMenu.OnControlCreated := MenuControlCreated;
    FMenu.SetRibbon(FRibbon);
    if FRibbon.CustomFrameSupported then
      Value.Top := FRibbon.GetRibbonMetric(rmFormBorder)
    else
      Value.Top := 0;
    if FRibbon.BiDiMode = bdLeftToRight then
    begin
      Value.Left := 0;
      Value.Anchors := [akTop, akLeft];
    end
    else
    begin
      Value.Left := FRibbon.Width - Value.Width;
      Value.Anchors := [akTop, akRight];
    end;
    Value.ActionManager := FRibbon.ActionManager;
    if not (csLoading in FRibbon.ComponentState) then
    begin
      if FRibbon.ActionManager <> nil then
      begin
        LActionBars := FRibbon.ActionManager.ActionBars;
        LBarFound := False;
        LActionBarItem := nil;
        LActionClient := nil;
        for I := 0 to LActionBars.Count - 1 do
        begin
          LActionBarItem := LActionBars[I];
          if LActionBarItem.ActionBar <> nil then
            LBarFound := LActionBarItem.ActionBar.Equals(Value)
          else
            LBarFound := False;
          if LBarFound then
          begin
            LActionBarItem.AutoSize := False;
            Break;
          end;
        end;
        // If there is currently no entry for the ActionBar in the Ribbon Manager
        // then create one and make sure the defaults are set correctly
        if not LBarFound then
        begin
          LActionBarItem := FRibbon.ActionManager.ActionBars.Add;
          LActionBarItem.ActionBar := Value;
          LActionBarItem.AutoSize := False;
        end;
        if (LActionBarItem <> nil) and not LActionBarItem.HasItems then
        begin
          LActionClient := LActionBarItem.Items.Add;
          LActionClient.KeyTip := 'F';
          // Add a new item to the application button. This allows the menu
          // to immediately be dropped at designtime to allow easier customization
          LActionClient.Items.Add;
        end;
        if LActionClient <> nil then
          LActionClient.ChangesAllowed := [caModify];
      end;
    end;
  end;
end;

procedure TApplicationMenu.SetScreenTip(const Value: TScreenTipItem);
begin
  FScreenTipPopup.ScreenTip.Assign(Value);
end;

procedure TRibbonLunaColorMap.UpdateColors;
begin
  inherited;
  BevelMinimizedInner := $00E3BB9B;
  BevelMinimizedOuter := $00F3E2D5;
  BtnSelectedFont := $006E1500;
  CaptionFontColor := $00AA6A3E;
  ControlColor := clWhite;
  ControlInactiveColor := $00FBF2EA;
  ControlFrameColor := $00DFC4AF;
  DisabledFontColor := $00A7A7A7;
  DocumentFontColor := $00797069;
  FontColor := $006E1500;
  MenuColor := clMenu;
  HighlightColor := $006E1500;
  ActiveTabFontColor := $006E1500;
  InactiveTabFontColor := $006E1500;
  GroupFontColor := $006E1500;
  QuickAccessToolbarMoreColor := $00FFDCC2;
  QuickAccessToolbarMoreBorderColor := $00A06437;
end;

{ TQuickAccessToolbarGroupItem }

constructor TQuickAccessToolbarGroupItem.Create(ActionList: TActionList;
  AGroup: TCustomRibbonGroup);
var
  LIdx: Integer;
begin
  inherited Create;
  FGroup := AGroup;
  FAction := TAction.Create(nil);
  FAction.Caption := AGroup.Caption;
  FAction.Hint := StripHotKey(AGroup.Caption);
  FAction.ActionList := ActionList;
  LIdx := 0;
  if FGroup.Items.Count > 0 then
  begin
    while FAction.ImageIndex = -1 do
    begin
      FAction.ImageIndex := FGroup.Items[LIdx].ImageIndex;
      Inc(LIdx);
      if LIdx = FGroup.Items.Count then
        Break;
    end;
  end;
  FAction.DisableIfNoHandler := False;
end;

destructor TQuickAccessToolbarGroupItem.Destroy;
begin
  FreeAndNil(FGroup);
  FreeAndNil(FAction);
  inherited;
end;

function TQuickAccessToolbarGroupItem.GetCaption: string;
begin
  if FAction <> nil then
    Result := FAction.Caption
  else
    Result := '';
end;

{ TQuickAccessToolbarGroups }

function TQuickAccessToolbarGroups.Add(
  AGroup: TCustomRibbonGroup): TQuickAccessToolbarGroupItem;
begin
  Result := TQuickAccessToolbarGroupItem.Create(FActionList, AGroup);
  FList.AddObject(AGroup.Caption, Result);
end;

// Clears the group reference for each TQuickAccessToolbarGroups item that
// appears in the Quick Access Toolbar. The group references are freed elsewhere.
procedure TQuickAccessToolbarGroups.Clean;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
  begin
    TQuickAccessToolbarGroupItem(FList.Objects[I]).FGroup := nil;
  end;
end;

constructor TQuickAccessToolbarGroups.Create(Images: TCustomImageList);
begin
  inherited Create;
  FActionList := TActionList.Create(nil);
  FActionList.Images := Images;
  FList := TStringList.Create;
end;

destructor TQuickAccessToolbarGroups.Destroy;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
    TQuickAccessToolbarGroupItem(FList.Objects[I]).Free;
  FList.Free;
  FActionList.Free;
  inherited;
end;

// Returns True if the Group is already in the list
function TQuickAccessToolbarGroups.Exists(const ACaption: string): Boolean;
var
  I: Integer;
  LItem: TQuickAccessToolbarGroupItem;
begin
  for I := 0 to FList.Count - 1 do
  begin
    LItem := TQuickAccessToolbarGroupItem(FList.Objects[I]);
    Result := LItem.Group.Caption = ACaption;
    if Result then
      Exit;
  end;
  Result := False;
end;

// Return a reference to the group that has the caption specified.
function TQuickAccessToolbarGroups.Group(
  const ACaption: string): TCustomRibbonGroup;
var
  LIdx: Integer;
begin
  LIdx := FList.IndexOf(ACaption);
  if LIdx > -1 then
    Result := TQuickAccessToolbarGroupItem(FList.Objects[LIdx]).Group
  else
    Result := nil;
end;

// Remove the entry for the group with the caption specified
procedure TQuickAccessToolbarGroups.Remove(const ACaption: string);
var
  LIdx: Integer;
begin
  LIdx := FList.IndexOf(ACaption);
  if LIdx > -1 then
  begin
    TQuickAccessToolbarGroupItem(FList.Objects[LIdx]).Free;
    FList.Delete(LIdx);
  end;
end;

{ TRibbonGroupScrollButton }

procedure TRibbonGroupScrollButton.CMDesignHitTest(
  var Message: TCMDesignHitTest);
begin
  if IsLeftMouseButtonPressed(Self) then
    Click;
end;

procedure TRibbonGroupScrollButton.CMMouseenter(var Message: TMessage);
begin
  inherited;
  MouseInControl := True;
end;

procedure TRibbonGroupScrollButton.CMMouseleave(var Message: TMessage);
begin
  inherited;
  MouseInControl := False;
end;

constructor TRibbonGroupScrollButton.Create(AOwner: TComponent);
begin
  inherited;
  TabStop := False;
  Width := 12;
end;

procedure TRibbonGroupScrollButton.Paint;
const
  Element: array [Boolean, Boolean] of TSkinTab =
    ((stScrollGroupRight, stScrollGroupLeft),
    (stScrollGroupRightHover, stScrollGroupLeftHover));
begin
  RibbonStyle.DrawElement(Element[MouseInControl, Direction = sdLeft], Canvas, ClientRect);
end;

procedure TRibbonGroupScrollButton.SetDirection(const Value: TScrollDirection);
begin
  if FDirection <> Value then
  begin
    FDirection := Value;
    Invalidate;
  end;
end;

procedure TRibbonGroupScrollButton.SetMouseInControl(const Value: Boolean);
begin
  if FMouseInControl <> Value then
  begin
    FMouseInControl := Value;
    Invalidate;
  end;
end;

{ TCustomRibbonQuickAccessPopupToolbar }

constructor TCustomRibbonQuickAccessPopupToolbar.Create(AOwner: TComponent);
begin
  inherited;
  if AOwner is TCustomRibbonQuickAccessToolbar then
    FQuickAccessToolbar := TCustomRibbonQuickAccessToolbar(AOwner);
  VertMargin := 2;
end;

function TCustomRibbonQuickAccessPopupToolbar.CreateControl(
  AnItem: TActionClientItem): TCustomActionControl;
begin
  Result := inherited CreateControl(AnItem);
  AnItem.ShowCaption := False;
end;

procedure TCustomRibbonQuickAccessPopupToolbar.CreateWnd;
var
  LRgn: HRgn;
begin
  inherited;
  LRgn := CreateRoundRectRgn(0, 0, Width + 1, Height + 1, 3, 3);
  SetWindowRgn(Handle, LRgn, True);
end;

procedure TCustomRibbonQuickAccessPopupToolbar.DrawBackground;
begin
  Canvas.Brush.Color := TCustomRibbonColorMap(ColorMap).QuickAccessToolbarMoreColor;
  Canvas.Brush.Style := bsSolid;
  Canvas.FillRect(ClientRect);
end;

function TCustomRibbonQuickAccessPopupToolbar.GetControlClass(
  AnItem: TActionClientItem): TCustomActionControlClass;
begin
  if AnItem.Tag = -1 then
    Result := TRibbonQATScrollButton
  else
    Result := inherited GetControlClass(AnItem);
end;

procedure TCustomRibbonQuickAccessPopupToolbar.NCPaint(DC: HDC);
var
  RC, RW: TRect;
  OldHandle: THandle;
  LColorMap: TCustomRibbonColorMap;
begin
  Winapi.Windows.GetClientRect(Handle, RC);
  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
  { Draw border in non-client area }
  OffsetRect(RW, -RW.Left, -RW.Top);
  OldHandle := Canvas.Handle;
  LColorMap := TCustomRibbonColorMap(ColorMap);
  try
    Canvas.Handle := DC;
    Canvas.Pen.Width := 1;

    Canvas.Pen.Color := LColorMap.QuickAccessToolbarMoreBorderColor;
    Canvas.MoveTo(RW.Right, RW.Top);
    Canvas.LineTo(RW.Left, Rw.Top);
    Canvas.LineTo(RW.Left, RW.Bottom);

    Canvas.Pen.Color := LColorMap.QuickAccessToolbarMoreColor;
    Canvas.MoveTo(RW.Right - 1, RW.Top + 1);
    Canvas.LineTo(RW.Left + 1, Rw.Top + 1);
    Canvas.LineTo(RW.Left + 1, RW.Bottom - 2);

    Canvas.Pen.Color := LColorMap.QuickAccessToolbarMoreBorderColor;
    Canvas.MoveTo(RW.Right - 1, RW.Top);
    Canvas.LineTo(RW.Right - 1, RW.Bottom - 1);
    Canvas.LineTo(RW.Left - 1, RW.Bottom - 1);

    Canvas.Pen.Color := LColorMap.QuickAccessToolbarMoreColor;
    Canvas.MoveTo(RW.Right - 2, RW.Top + 1);
    Canvas.LineTo(RW.Right - 2, RW.Bottom - 2);
    Canvas.LineTo(RW.Left, RW.Bottom - 2);
  finally
    Canvas.Handle := OldHandle;
  end;
end;

function TCustomRibbonQuickAccessPopupToolbar.ValidOrientations: TBarOrientations;
begin
  Result := [boLeftToRight, boRightToLeft];
end;

{ TRibbonObsidianColorMap }

procedure TRibbonObsidianColorMap.UpdateColors;
begin
  inherited;
  BevelMinimizedInner := $004F4F4F;
  BevelMinimizedOuter := $00626262;
  BtnSelectedFont := $006E1500;
  CaptionFontColor := $00AA6A3E;
  ControlColor := clWindow;
  ControlInactiveColor := $00E8E8E8;
  ControlFrameColor := $00898989;
  DisabledFontColor := $00A7A7A7;
  DocumentFontColor := $00797069;
  FontColor := clBlack;
  MenuColor := clMenu;
  HighlightColor := $006E1500;
  ActiveTabFontColor := clBlack;
  InactiveTabFontColor := clWhite;
  GroupFontColor := clWhite;
  QuickAccessToolbarMoreColor := $008E8076;
  QuickAccessToolbarMoreBorderColor := $00433C37;
end;

{ TRibbonSilverColorMap }

procedure TRibbonSilverColorMap.UpdateColors;
begin
  inherited;
  BevelMinimizedInner := clGray;
  BevelMinimizedOuter := $00EBE1DC;
  BtnSelectedFont := $006E1500;
  CaptionFontColor := $00AA6A3E;
  ControlColor := clWindow;
  ControlInactiveColor := $00ECEAE8;
  ControlFrameColor := $00898989;
  DisabledFontColor := $008D8D8D;
  DocumentFontColor := $00797069;
  FontColor := clBlack;
  MenuColor := clMenu;
  HighlightColor := $006E1500;
  ActiveTabFontColor := $005C534C;
  GroupFontColor := $00595453;
  InactiveTabFontColor := $005C534C;
  QuickAccessToolbarMoreColor := $00E4DADB;
  QuickAccessToolbarMoreBorderColor := $0099797A;
end;

{ TRibbonCustomizeDlg }

procedure TRibbonCustomizeDlg.SetupDlg;
begin
  inherited;
  CustomizeForm.ToolbarsTab.TabVisible := False;
  CustomizeForm.OptionsTab.TabVisible := False;
  // Only allow separator customization when running in the IDE
  // The user cannot add a separator to the Quick Access Toolbar
  if not (csDesigning in ComponentState) then
    CustomizeForm.SeparatorBtn.Visible := False;
end;

{ TRibbonSystemButton }

constructor TRibbonSystemButton.Create(AOwner: TComponent; sysButton : TSystemMenuButton);
begin
  inherited Create(AOwner);
  FSystemMenuButton := sysButton;
  SetDesignVisible(False);
end;

procedure TRibbonSystemButton.DoClick;
begin
  inherited;
  case FSystemMenuButton of
    smbNone: ;
    smbMinimize:
      PostMessage(TCustomRibbon(Parent).FParentForm.Handle, WM_SYSCOMMAND, SC_MINIMIZE,0);
    smbRestore:
    begin
      if TCustomRibbon(Parent).FParentForm.WindowState = wsMaximized then
        PostMessage(TCustomRibbon(Parent).FParentForm.Handle, WM_SYSCOMMAND, SC_RESTORE,0)
      else
        PostMessage(TCustomRibbon(Parent).FParentForm.Handle, WM_SYSCOMMAND, SC_MAXIMIZE,0);
    end;
    smbHelp:
      PostMessage(TCustomRibbon(Parent).FParentForm.Handle, WM_SYSCOMMAND, SC_CONTEXTHELP,0);
    smbClose:
      PostMessage(TCustomRibbon(Parent).FParentForm.Handle, WM_SYSCOMMAND, SC_CLOSE,0);
  end;

end;

procedure TRibbonSystemButton.DrawBackground;
begin
  if MouseInControl then
  begin
    if IsLeftMouseButtonPressed(Self) then
      RibbonStyle.DrawElement(sfButtonPressed, Canvas, ClientRect, -1)
    else
      RibbonStyle.DrawElement(sfButtonHover, Canvas, ClientRect,-1);
  end;
end;

procedure TRibbonSystemButton.DrawImage;
const
  Elements: array [0..3, TSystemMenuButton] of TSkinForm =
    (
      (sfNone, sfMinimize, sfMaximize, sfHelp, sfClose),
      (sfNone, sfMinimizeDisabled, sfMaximizeDisabled, sfHelpDisabled, sfCloseDisabled),
      (sfNone, sfMinimizeHover, sfMaximizeHover, sfHelpHover, sfCloseHover),
      (sfNone, sfMinimizePressed, sfMaximizePressed, sfHelpPressed, sfClosePressed)
    );
  RestoreElement: array [0..3] of TSkinForm =
   ( sfRestore, sfRestoreDisabled, sfRestoreHover, sfRestorePressed );
var
  LButtonState : Integer;
begin
  if MouseInControl then
  begin
    if IsLeftMouseButtonPressed(Self) then
      LButtonState := 3
    else
      LButtonState := 2
  end
  else
  begin
    if TCustomRibbon(Parent).Active then
      LButtonState := 0
    else
      LButtonState := 1
  end;
  if (FSystemMenuButton = smbRestore) and
  (TCustomRibbon(Self.parent).FParentForm.WindowState <> wsnormal) then
    RibbonStyle.DrawElement(RestoreElement[LButtonState], canvas, clientrect, -1)
  else
    RibbonStyle.DrawElement(Elements[LButtonState, fsystemMenuButton], canvas, clientrect, -1)

end;

initialization
  RegisterClass(TRibbonGroup);
  RegisterClass(TRibbonPage);
  RegisterClass(TRibbonQuickAccessToolbar);

finalization
  DestroyMouseWheelHook;

end.
