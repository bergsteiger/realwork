{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.RibbonActnCtrls;

interface

uses
  Vcl.ActnMan, Vcl.ActnCtrls, Winapi.Windows, System.Types, System.Classes, Vcl.Controls, Vcl.Graphics,
  Winapi.Messages, Vcl.ActnMenus, Vcl.StdCtrls, Vcl.RibbonStyleActnCtrls, Vcl.Forms, System.Contnrs,
  Vcl.XPActnCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ActnList;

const
  UM_FADECONTROL = WM_USER + 100; // Message received by controls that implement blending

type
  // Interface implemented by controls that have a split button
  IRibbonSplitButton = interface
    ['{38541172-13DF-4F13-BC53-0448DC1EC163}']
    procedure UpdateSplitBounds;
  end;

  // Interface implemented by any control that is visible in Ribbon Groups
  IRibbonControl = interface
    ['{02FD60A6-9A74-4B88-9E7A-CCAB171A410F}']
    function CanAddToQuickAccessToolbar: Boolean;
  end;

  // Interface implemented by any control that is visible in Ribbon Groups
  // that is used as a container for displaying other controls
  IRibbonContainedControl = interface(IRibbonControl)
    ['{60502082-9AD4-46EF-9866-39198BFCCD2E}']
    function GetContainedControl: TControl;
    procedure SetContainedControl(const Value: TControl);
    property ContainedControl: TControl read GetContainedControl write SetContainedControl;
  end;

  IRibbonGroupDropdown = interface
    ['{645B9579-7A03-47AF-A353-E38829FA4B46}']
    function GetParentControl: TWinControl;
    function GetTopPosition: Integer;
    procedure CloseUp;
  end;

  TKeyTipPosition = (ktpApplicationButton, ktpQuickAccessToolbar, ktpTabs,
    ktpGroupA, ktpGroupB, ktpGroupC, ktpGroupD);
  // The current State that the KeyTips are in.
  // ktsTabs - The initial state where the user hasn't yet selected a Tab to
  //   display the KeyTips for. In this state, KeyTips are displayed for the
  //   Applicatiom Button, Quick Access Toolbar and the Tabs
  // ktsControls - KeyTips are being displayed for all commands on the Active
  //   Tab. KeyTips are also displayed for Groups dialog buttons and collapsed
  //   group buttons.
  // ktsCollapsedGroup - KeyTips are being displayed for commands that are on
  //   a collapsed group
  TKeyTipState = (ktsTabs, ktsControls, ktsCollapsedGroup);
  
  // Use to validate if a commands KeyTip matches the current user input.
  // ktNone - the current KeyTip didn't match the commands KeyTip.
  // ktPartial - the current KeyTip matches the first character of the commands
  //   KeyTip.
  // ktFull - the current KeyTip is a full match for the command. The source
  //   KeyTip could be either one character or two characters.
  TKeyTipHandled = (ktNone, ktPartial, ktFull);

  // The type of match the commands KeyTip is for the current KeyTip value
  TKeyTipMatchType = (mtApplicationMenu, mtTabs, mtControl, mtGroup,
    mtCollapsed, mtDialogButton);

  // Stores details about Full and Partial KeyTip matches. Contains a reference
  // to the Control that needs to be executed or if the MatchType is mtTabs
  // then the Index property is used to determine which Tab to change to.
  TKeyTipMatchItem = class
  private
    FControl: TControl;
    FHandled: TKeyTipHandled;
    FIndex: Integer;
    FMatchType: TKeyTipMatchType;
  public
    constructor Create(AType: TKeyTipMatchType; AHandled: TKeyTipHandled;
      AControl: TControl; AIndex: Integer = -1);
    property Control: TControl read FControl write FControl;
    property Handled: TKeyTipHandled read FHandled;
    property Index: Integer read FIndex write FIndex;
    property MatchType: TKeyTipMatchType read FMatchType write FMatchType;
  end;

  TKeyTipList = class;

  TKeyTipListEnumerator = class
  private
    FIndex: Integer;
    FList: TKeyTipList;
  public
    constructor Create(AList: TKeyTipList);
    function GetCurrent: TKeyTipMatchItem;
    function MoveNext: Boolean;
    property Current: TKeyTipMatchItem read GetCurrent;
  end;

  TKeyTipList = class
  private
    FList: TObjectList;
    FCurrent: string;
    function GetFull: Boolean;
    function GetPartial: Boolean;
    function GetItem(Index: Integer): TKeyTipMatchItem;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    // Add a new match to the list of KeyTips
    procedure Add(MatchType: TKeyTipMatchType; Handled: TKeyTipHandled;
      Control: TControl; Index: Integer = -1);
    // Clear the list of KeyTips 
    procedure Clear;
    // The number of valid KeyTips
    property Count: Integer read GetCount;
    // The Current KeyTip value the user has typed in so far
    property Current: string read FCurrent write FCurrent;
    // If the Current Key Tip has a full match in the list and there are no
    // other matches
    property Full: Boolean read GetFull;
    property Items[Index: Integer]: TKeyTipMatchItem read GetItem; default;
    // If the Current Key Tip has a partial match in the list
    property Partial: Boolean read GetPartial;
  end;

  // Action Bars that support KeyTips should implement this interface
  // The TRibbonQuickAccessToolbar and TRibbonGroup classes implement
  // this interface
  IRibbonBarKeyTip = interface
    ['{319013F9-8666-4ECB-8FFF-60EA9B3590A7}']
    // Check to see if any commands on the Action Bar are a Partial or Full
    // match for the KeyTip. Matches are returned as a TKeyTipMatchItem in
    // the List parameter. If only one item is a match, then that command
    // is executed
    procedure BarHandleKeyTips(const KeyTip: string; var KeyTips: TKeyTipList);
    // Hide any visible KeyTip windows. ExceptList may contain a list of
    // TKeyTipMatchItem objects for commands that should not be hidden. These
    // items are current partial matches and require additional handling.
    procedure BarHideKeyTips(KeyTips: TKeyTipList);
    // Show KeyTips for any commands that support them
    procedure BarShowKeyTips;
  end;

  // Commands that have a KeyTip should implement this interface
  IRibbonKeyTip = interface
    ['{4CBC71C8-C05E-4AC4-8D8E-9E89EC0BFD34}']
    // Returns the current KeyTip for the command
    function GetKeyTip: string;
    // Does this command's KeyTip match the currently input KeyTip by the
    // user. Full and partial matches are taken into consideration.
    procedure HandleKeyTip(const KeyTip: string; var Handled: TKeyTipHandled);
    // Hide the KeyTip for this command. If the Match parameter matches (full
    // or partial) the commands KeyTip, then the KeyTip remains visible
    procedure HideKeyTip(const Match: string);
    // Some requires need to be handled differently when clicked by a keytip
    procedure KeyTipClick;
    // Sets the KeyTip for the command
    procedure SetKeyTip(const Value: string);
    // Shows the KeyTip for the command in the position specified. Only the
    // Application Button uses a KeyTip position.
    procedure ShowKeyTip(const Position: TKeyTipPosition);
    property KeyTip: string read GetKeyTip write SetKeyTip;
  end;

  // Static class used to validate a KeyTip.
  TKeyTipValidator = class
  public
    class procedure Validate(const SrcKeyTip, CmdKeyTip: string;
      Control: TControl; var Handled: TKeyTipHandled);
  end;

  // Common ancestor for many buttons that appear in the groups and on the
  // Quick Access Toolbar
  TRibbonBaseButtonControl = class(TCustomButtonControl, IRibbonControl,
    IRibbonKeyTip)
  private
    FDrawDown: Boolean;
    FKeyTip: TCustomControl;
    procedure SetDrawDown(const Value: Boolean);
    function ActualSpacing(ImageSize: TPoint): Integer;
    function CaptionLength: Integer;
    function CaptionHeight: Integer;
    function GetButtonProps: TButtonProperties;
  protected
    function AllowHotKeys: Boolean; virtual;
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawGlyph(const Location: TPoint); override;
    procedure DrawSeparator(const Offset: Integer); override;
    procedure DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string;
      TextColor: TColor; ShadowColor: TColor); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal; Text: string); override;
    function GetImageSize: TPoint; override;
    function IsButton(out ButtonProperties: TButtonProperties): Boolean;
    function IsRibbonAvailable: Boolean;
    function RibbonStyle: TRibbonStyleActionBars;
    property DrawDown: Boolean read FDrawDown write SetDrawDown;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CalcBounds; override;
    function CanAddToQuickAccessToolbar: Boolean;
    procedure Click; override;
    procedure DragDrop(Source: TObject; X: Integer; Y: Integer); override;
    function GetKeyTip: string;
    procedure HandleKeyTip(const KeyTip: string; var Handled: TKeyTipHandled);
    procedure HideKeyTip(const Match: string);
    procedure KeyTipClick; virtual;
    procedure SetKeyTip(const Value: string);
    procedure ShowKeyTip(const Position: TKeyTipPosition);
  end;

  TRibbonGripItem = class(TMenuResizeActionControl)
  private
    FGalleryResize: TGalleryResize;
  protected
    procedure Paint; override;
    function RibbonStyle: TRibbonStyleActionBars;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CalcBounds; override;
    property GalleryResize: TGalleryResize read FGalleryResize write FGalleryResize;
  end;

  // Class used for the top level menus when using one of the Ribbon Styles in
  // an application that doesn't use the Ribbon interface.
  TRibbonStyleMenuButton = class(TCustomMenuButton)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    function RibbonStyle: TRibbonStyleActionBars;
  end;

  // Class used for the Application Button when using the Ribbon interface.
  TRibbonApplicationMenuButton = class(TCustomMenuButton, IRibbonKeyTip)
  private
    FDirection: Integer;
    FValue: Byte;
    FMouseInControl: Boolean;
    FRibbon: TWinControl;
    FKeyTipForm: TCustomControl;
    procedure SetMouseInControl(const Value: Boolean);
  protected
    procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    procedure SetParent(AParent: TWinControl); override;
    procedure Paint; override;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    function RibbonStyle: TRibbonStyleActionBars;
    procedure UMFadeControl(var Message: TMessage); message UM_FADECONTROL;
    property MouseInControl: Boolean read FMouseInControl write SetMouseInControl;
{$IF DEFINED(CLR)}
  public
{$ENDIF}
    procedure CMMouseEnter(var Message: TMessage); override;
    procedure CMMouseLeave(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetKeyTip: string;
    procedure HandleKeyTip(const KeyTip: string; var Handled: TKeyTipHandled);
    procedure HideKeyTip(const Match: string);
    procedure KeyTipClick;
    procedure SetKeyTip(const Value: string);
    procedure ShowKeyTip(const Position: TKeyTipPosition);
    procedure CalcBounds; override;
    property KeyTip: string read GetKeyTip write SetKeyTip;
  end;

  TRibbonApplicationButton = class(TCustomMenuButton)
  public
    procedure CalcBounds; override;
  end;

  TRibbonLargeButtonControl = class(TRibbonBaseButtonControl)
  protected
    procedure CalcLayout; override;
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal; Text: string); override;
    procedure DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string;
      TextColor: TColor; ShadowColor: TColor); override;
  public
    procedure CalcBounds; override;
  end;

  TRibbonSmallButtonControl = class(TRibbonBaseButtonControl)
  public
    procedure CalcBounds; override;
  end;

  TRibbonSeparator = class(TCustomActionControl)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawGlyph(const Location: TPoint); override;
    procedure DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string;
      TextColor: TColor; ShadowColor: TColor); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal; Text: string); override;
    function RibbonStyle: TRibbonStyleActionBars;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CalcBounds; override;
  end;

  TRibbonMainMenuSeparator = class(TRibbonSeparator)
  public
    procedure CalcBounds; override;
  end;

  TRibbonMenuItem = class(TCustomMenuItem)
  private
    FDrawBanner: Boolean;
  protected
    procedure CalcLayout; override;
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawSelectedBackground(ARect: TRect); virtual;
    procedure DrawSeparator(const Offset: Integer); override;
    procedure DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string;
      TextColor: TColor; ShadowColor: TColor); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal; Text: string); override;
    procedure DrawGlyph(const Location: TPoint); override;
    function GetShowShortCut: Boolean; override;
    function RibbonStyle: TRibbonStyleActionBars;
    property DrawBanner: Boolean read FDrawBanner write FDrawBanner;
  public
    procedure Click; override;
    constructor Create(AOwner: TComponent); override;
    procedure CalcBounds; override;
  end;

  // Control type used to display items associated with a TRibbonComboBox
  TRibbonComboBoxItem = class(TRibbonMenuItem)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal; Text: string); override;
  public
    procedure CalcBounds; override;
  end;

  TRibbonMenuSmallButtonControl = class(TRibbonSmallButtonControl)
  protected
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
      Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  // Control type used to display items in the Recent Items list of the Application Menu
  TRibbonRecentButtonControl = class(TRibbonMenuSmallButtonControl)
  protected
    function AllowHotKeys: Boolean; override;
  end;

  // Control type used to display buttons at the bottom of the Application Menu
  TRibbonOptionButtonControl = class(TRibbonMenuSmallButtonControl)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
  end;

  TRibbonMenuSeparatorItem = class(TRibbonMenuItem)
  protected
    procedure DrawSeparator(const Offset: Integer); override;
  public
    procedure CalcBounds; override;
  end;

  TRibbonApplicationMenuItem = class(TRibbonMenuItem)
  protected
    procedure DrawGlyph(const Location: TPoint); override;
    procedure DrawSeparator(const Offset: Integer); override;
    procedure DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string;
      TextColor: TColor; ShadowColor: TColor); override;
    procedure DrawSubMenuGlyph; override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal; Text: string); override;
    procedure DrawSelectedBackground(ARect: TRect); override;
    function GetImageSize: TPoint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CalcBounds; override;
  end;

  TRibbonMainMenuItem = class(TRibbonApplicationMenuItem)
  protected
    procedure DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string;
      TextColor: TColor; ShadowColor: TColor); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal; Text: string);
      override;
  end;

  TRibbonSplitMenuItem = class(TRibbonApplicationMenuItem, IRibbonSplitButton)
  private
    procedure SetMouseInSplit(const Value: Boolean);
  protected
    FSplitRect: TRect;
    FMouseInSplit: Boolean;
    function IsInSplit(const Pt: TPoint): Boolean; inline;
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawSelectedBackground(ARect: TRect); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    property MouseInSplit: Boolean read FMouseInSplit write SetMouseInSplit;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CalcBounds; override;
    procedure Click; override;
    procedure UpdateSplitBounds; virtual;
  end;

  TRibbonDropDownButton = class(TRibbonBaseButtonControl)
  protected
    function GetArrowPosition(const ARect: TRect): TPoint; virtual;
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string;
      TextColor: TColor; ShadowColor: TColor); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal; Text: string); override;
    procedure DrawArrow(Location: TPoint; Color, ShadowColor: TColor; Size: Integer); virtual;
    procedure DoDropDown(const SelectFirst: Boolean); virtual;
    procedure CalcLayout; override;
    function GetPopupClass: TCustomPopupClass; virtual;
  public
    procedure Click; override;
    procedure CalcBounds; override;
    procedure KeyTipClick; override;
  end;

  // Control used to display an entire group as a dropdown menu in the
  // Quick Access Toolbar.
  TRibbonGroupDropDown = class(TRibbonDropDownButton, IRibbonGroupDropdown)
  private
    FGroup: TControl;
    FFloating: TCustomForm;
    FParentControl: TWinControl;
    procedure SetGroup(const Value: TControl);
  protected
    procedure DoDropDown(const SelectFirst: Boolean); override;
    procedure DrawArrow(Location: TPoint; Color, ShadowColor: TColor; Size: Integer); override;
    procedure DrawBackground(var PaintRect: TRect); override;
  public
    procedure CloseUp;
    function GetParentControl: TWinControl;
    function GetTopPosition: Integer;
    property Group: TControl read FGroup write SetGroup;
  end;

  TRibbonSmallSplitButton = class(TRibbonDropDownButton, IRibbonSplitButton)
  private
    procedure SetCursorInSplit(const Value: Boolean);
  protected
    FCursorInSplit: Boolean;
    FSplitRect: TRect;
    procedure CalcLayout; override;
    procedure DrawBackground(var PaintRect: TRect); override;
    function GetArrowPosition(const ARect: TRect): TPoint; override;
    function InSplit(X, Y: Integer): Boolean; inline;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
{$IF DEFINED(CLR)}
  public
{$ENDIF}
    procedure CMMouseLeave(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CalcBounds; override;
    procedure UpdateSplitBounds; virtual;
    procedure KeyTipClick; override;
    property CursorInSplit: Boolean read FCursorInSplit write SetCursorInSplit;
    procedure Click; override;
  end;

  TRibbonGallerySplitButton = class(TRibbonSmallSplitButton)
  protected
    function GetPopupClass: TCustomPopupClass; override;
  end;

  TRibbonGalleryItem = class(TRibbonBaseButtonControl)
  protected
    procedure CalcLayout; override;
  public
    procedure CalcBounds; override;
  end;

  TRibbonGalleryMenuItem = class(TCustomMenuItem)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawGlyph(const Location: TPoint); override;
    procedure DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string;
      TextColor: TColor; ShadowColor: TColor); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal; Text: string); override;
    function RibbonStyle: TRibbonStyleActionBars;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer;
      Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
      Y: Integer); override;
  public
    procedure CalcBounds; override;
  end;

  TRibbonGalleryControlMenuItem = class(TCustomMenuItem, IRibbonContainedControl)
  private
    FContainedControl: TControl;
  protected
    procedure Paint; override;
    procedure SetParent(AParent: TWinControl); override;
  public
    procedure CalcBounds; override;
    function CanAddToQuickAccessToolbar: Boolean;
    function GetContainedControl: TControl;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    procedure SetContainedControl(const Value: TControl);
    property ContainedControl: TControl read GetContainedControl write SetContainedControl;
  end;

  TRibbonLargeSplitButton = class(TRibbonLargeButtonControl, IRibbonSplitButton)
  private
    FSplitRect: TRect;
    FDownInSplit: Boolean;
    FCursorInSplit: Boolean;
    procedure SetCursorInSplit(const Value: Boolean);
  protected
    procedure CalcLayout; override;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure DoSplitButtonClick(const SelectFirst: Boolean); virtual;
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawArrow(Location: TPoint; Color, ShadowColor: TColor; Size: Integer); virtual;
    function GetArrowPosition(const AREct: TRect): TPoint; virtual;
    function InSplit(X, Y: Integer): Boolean; inline;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
  public
    procedure CalcBounds; override;
    procedure Click; override;
    procedure KeyTipClick; override;
    procedure UpdateSplitBounds; virtual;
    property CursorInSplit: Boolean read FCursorInSplit write SetCursorInSplit;
  end;

  TRibbonTextControl = class(TCustomActionControl)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal; Text: string); override;
  public
    procedure CalcBounds; override;
  end;

  TRibbonCustomControl = class(TCustomActionControl, IRibbonControl,
    IRibbonContainedControl, IRibbonKeyTip)
  private
    FContainedControl: TControl;
    FKeyTip: TCustomControl;
  protected
    procedure CMVisiblechanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure DrawBackground(var PaintRect: TRect); override;
    function GetCaptionWidth: Integer;
    function GetGlyphWidth: Integer;
    function GetLabelWidth: Integer;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure SetActionClient(Value: TActionClientItem); override;
    procedure SetDragMode(Value: TDragMode); override;
    procedure SetParent(AParent: TWinControl); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanAddToQuickAccessToolbar: Boolean;
    procedure CalcBounds; override;
    procedure Click; override;
    function GetContainedControl: TControl;
    procedure SetContainedControl(const Value: TControl);
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    function GetKeyTip: string;
    procedure HandleKeyTip(const KeyTip: string; var Handled: TKeyTipHandled);
    procedure HideKeyTip(const Match: string);
    procedure KeyTipClick;
    procedure SetKeyTip(const Value: string);
    procedure ShowKeyTip(const Position: TKeyTipPosition);
    property ContainedControl: TControl read GetContainedControl write SetContainedControl;
  end;

  TRibbonCustomStatusControl = class(TRibbonCustomControl)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
  public
    procedure CalcBounds; override;
  end;

  TRibbonRichContentItem = class(TRibbonMenuItem)
  private
    FBoundsCalculated: Boolean;
    FShortCut: Word;
    FCaptionHeight: Integer;
    FCaptionText: string;
    FContentHeight: Integer;
    FContentText: string;
    FLeftMargin: Integer;
    FCaptionWidth: Integer;
  protected
    function GetItemHeight: Integer;
    function GetItemWidth: Integer;
    function GetMenuProps: TMenuProperties;
    function CanCalculateHeight: Boolean; inline;
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawGlyph(const Location: TPoint); override;
    procedure DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string;
      TextColor: TColor; ShadowColor: TColor); override;
    procedure DrawText(var Rect: TRect; var Flags: Cardinal; Text: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CalcBounds; override;
  end;

  TRibbonRichContentMainMenuItem = class(TRibbonRichContentItem)
  protected
    procedure CalcLayout; override;
    function GetShowShortCut: Boolean; override;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal; Text: string); override;
    procedure DrawGlyph(const Location: TPoint); override;
    function GetImageSize: TPoint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CalcBounds; override;
  end;

  TRibbonComboControl = class;

  TCustomRibbonComboBox = class(TCustomEdit)
  private
    FComboControl: TRibbonComboControl;
    FMouseInControl: Boolean;
    FItems: TStrings;
    procedure SetMouseInControl(const Value: Boolean);
    procedure SetItems(const Value: TStrings);
  protected
    procedure BeginAutoDrag; override;
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure SetParent(AParent: TWinControl); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DragDrop(Source: TObject; X: Integer; Y: Integer); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    property Color;
    property Items: TStrings read FItems write SetItems;
    property MouseInControl: Boolean read FMouseInControl write SetMouseInControl;
  end;

  TRibbonComboBox = class(TCustomRibbonComboBox)
  published
    property Alignment;
    property AutoSelect default True;
    property CharCase;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property Items;
    property MaxLength;
    property NumbersOnly;
    property ParentFont;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property TextHint;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TRibbonComboControl = class(TCustomButtonControl, IRibbonContainedControl,
    IRibbonKeyTip)
  private
    FComboBox: TCustomRibbonComboBox;
    FMouseInControl: Boolean;
    FBtnRect: TRect;
    FPopupMenu: TCustomActionPopupMenu;
    FComboActions: TObjectList;
    FKeyTip: TCustomControl;
    procedure SetMouseInControl(const Value: Boolean);
    procedure SetComboBox(const Value: TCustomRibbonComboBox);
    procedure SelectItemHandler(Sender: TObject);
    procedure GetComboItemsControlClassHandler(Sender: TCustomActionBar;
      AnItem: TActionClient; var ControlClass: TCustomActionControlClass);
  protected
    procedure CMBidimodechanged(var Message: TMessage);
      message CM_BIDIMODECHANGED;
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMVisiblechanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure ComboClick(Sender: TObject);
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawFrame; reintroduce;
    procedure DropDownClick(const SelectFirst: Boolean); virtual;
    function GetCaptionWidth: Integer;
    function GetGlyphWidth: Integer;
    function GetLabelWidth: Integer;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure SetParent(AParent: TWinControl); override;
    procedure SetDragMode(Value: TDragMode); override;
    procedure ShowComboItems(const SelectFirst: Boolean); virtual;
    procedure Paint; override;
    function RibbonStyle: TRibbonStyleActionBars;
    procedure SetActionClient(Value: TActionClientItem); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CalcBounds; override;
    function CanAddToQuickAccessToolbar: Boolean;
    procedure Click; override;
    function GetContainedControl: TControl;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    procedure SetContainedControl(const Value: TControl);
    function GetKeyTip: string;
    procedure HandleKeyTip(const KeyTip: string; var Handled: TKeyTipHandled);
    procedure HideKeyTip(const Match: string);
    procedure KeyTipClick;
    procedure SetKeyTip(const Value: string);
    procedure ShowKeyTip(const Position: TKeyTipPosition);
    property ComboBox: TCustomRibbonComboBox read FComboBox;
    property ContainedControl: TControl read GetContainedControl write SetContainedControl;
    property MouseInControl: Boolean read FMouseInControl write SetMouseInControl;
  end;

  TRibbonGallery = class(TControl)
    
  end;

  TRibbonGalleryControl = class(TCustomActionControl, IRibbonContainedControl)
  private
    FGallery: TRibbonGallery;
  public
    function CanAddToQuickAccessToolbar: Boolean;
    function GetContainedControl: TControl;
    procedure SetContainedControl(const Value: TControl);
    property ContainedControl: TControl read GetContainedControl write SetContainedControl;
    property Gallery: TRibbonGallery read FGallery;
  end;

  TRibbonToolScrollButton = class(TCustomToolScrollBtn)
  private
    function RibbonStyle: TRibbonStyleActionBars;
  protected
    procedure DrawArrows; override;
    procedure DrawBackground(var PaintRect: TRect); override;
  end;

  TQATScrollMode = (qsCustomize, qsMoreControls);

  TRibbonQATScrollButton = class(TCustomToolScrollBtn)
  private
    FCursorInBtn: Boolean;
    FBtnRect: TRect;
    FDrawDown: Boolean;
    FPaintRect: TRect;
    FScrollMode: TQATScrollMode;
    procedure SetCursorInBtn(const Value: Boolean);
    procedure SetDrawDown(const Value: Boolean);
    procedure SetScrollMode(const Value: TQATScrollMode);
  protected
    procedure DrawArrows; override;
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    function RibbonStyle: TRibbonStyleActionBars;
    property CursorInBtn: Boolean read FCursorInBtn write SetCursorInBtn;
    procedure CMMouseLeave(var Message: TMessage); override;
    procedure CMMouseEnter(var Message: TMessage); override;
  public
    procedure CalcBounds; override;
    procedure Click; override;
    property DrawDown: Boolean read FDrawDown write SetDrawDown;
    property ScrollMode: TQATScrollMode read FScrollMode write SetScrollMode;
  end;

  TRibbonCustomizeItem = class(TCustomAddRemoveItem)
  protected
    function RibbonStyle: TRibbonStyleActionBars;
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawGlyph(const Location: TPoint); override;
  public
    procedure CalcBounds; override;
  end;

  TRibbonAddRemoveItem = class(TXPStyleAddRemoveItem)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawGlyph(const Location: TPoint); override;
  end;

  TNumGlyphs = Vcl.Buttons.TNumGlyphs;

  TTimerSpeedButton = class;
  TRibbonSpinEdit = class;

  TRibbonSpinButton = class(TWinControl)
  private
    FUpButton: TTimerSpeedButton;
    FDownButton: TTimerSpeedButton;
    FFocusedButton: TTimerSpeedButton;
    FFocusControl: TWinControl;
    FOnUpClick: TNotifyEvent;
    FOnDownClick: TNotifyEvent;
    function CreateButton: TTimerSpeedButton;
    function GetUpGlyph: TBitmap;
    function GetDownGlyph: TBitmap;
    procedure SetUpGlyph(Value: TBitmap);
    procedure SetDownGlyph(Value: TBitmap);
    function GetUpNumGlyphs: TNumGlyphs;
    function GetDownNumGlyphs: TNumGlyphs;
    procedure SetUpNumGlyphs(Value: TNumGlyphs);
    procedure SetDownNumGlyphs(Value: TNumGlyphs);
    procedure BtnClick(Sender: TObject);
    procedure BtnMouseDown (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SetFocusBtn (Btn: TTimerSpeedButton);
    procedure AdjustSize (var W, H: Integer); reintroduce;
    procedure WMSize(var Message: TWMSize);  message WM_SIZE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    procedure Loaded; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    function Control: TRibbonSpinEdit;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property Align;
    property Anchors;
    property Constraints;
    property Ctl3D;
    property DownGlyph: TBitmap read GetDownGlyph write SetDownGlyph;
    property DownNumGlyphs: TNumGlyphs read GetDownNumGlyphs write SetDownNumGlyphs default 1;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl: TWinControl read FFocusControl write FFocusControl;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property UpGlyph: TBitmap read GetUpGlyph write SetUpGlyph;
    property UpNumGlyphs: TNumGlyphs read GetUpNumGlyphs write SetUpNumGlyphs default 1;
    property Visible;
    property OnDownClick: TNotifyEvent read FOnDownClick write FOnDownClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDock;
    property OnStartDrag;
    property OnUpClick: TNotifyEvent read FOnUpClick write FOnUpClick;
  end;

  { TRibbonSpinEdit }

  TRibbonSpinEdit = class(TCustomEdit)
  private
    FMinValue: LongInt;
    FMaxValue: LongInt;
    FIncrement: LongInt;
    FButton: TRibbonSpinButton;
    FEditorEnabled: Boolean;
    function GetMinHeight: Integer;
    function GetValue: LongInt;
    function CheckValue (NewValue: LongInt): LongInt;
    procedure SetValue (NewValue: LongInt);
    procedure SetEditRect;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaste(var Message: TWMPaste); message WM_PASTE;
    procedure WMCut(var Message: TWMCut); message WM_CUT;
  protected
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DownClick (Sender: TObject); virtual;
    function IsValidChar(Key: Char): Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure UpClick (Sender: TObject); virtual;
    procedure SetEnabled(Value: Boolean); override;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure SetParent(AParent: TWinControl); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    property Button: TRibbonSpinButton read FButton;
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Enabled;
    property Font;
    property Increment: LongInt read FIncrement write FIncrement default 1;
    property MaxLength;
    property MaxValue: LongInt read FMaxValue write FMaxValue;
    property MinValue: LongInt read FMinValue write FMinValue;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Value: LongInt read GetValue write SetValue;
    property Visible;
    property OnChange;
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
    property OnStartDrag;
  end;

  { TTimerSpeedButton }

  TTimeBtnState = set of (tbFocusRect, tbAllowTimer);
  TSpinButtonStyle = (sbsUp, sbsDown);

  TTimerSpeedButton = class(TSpeedButton)
  private
    FRepeatTimer: TTimer;
    FTimeBtnState: TTimeBtnState;
    FButtonStyle: TSpinButtonStyle;
    FMouseInControl: Boolean;
    FButton: TRibbonSpinButton;
    procedure TimerExpired(Sender: TObject);
    procedure SetButtonStyle(const Value: TSpinButtonStyle);
    procedure SetMouseInControl(const Value: Boolean);
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    property MouseInControl: Boolean read FMouseInControl write SetMouseInControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property TimeBtnState: TTimeBtnState read FTimeBtnState write FTimeBtnState;
    property ButtonStyle: TSpinButtonStyle read FButtonStyle write SetButtonStyle;
  end;

  TRibbonCheckBoxControl = class(TRibbonSmallButtonControl)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawGlyph(const Location: TPoint); override;
  public
    procedure CalcBounds; override;
  end;

  TRibbonRadioButtonControl = class(TRibbonSmallButtonControl)
  protected
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawGlyph(const Location: TPoint); override;
  public
    procedure CalcBounds; override;
  end;

function IsLeftMouseButtonPressed(Control: TControl): Boolean; inline;
procedure DrawLine(ACanvas: TCanvas; const AFromPt, AToPt: TPoint); inline;
function ShowKeyTip(const KeyTip: string; const Enabled: Boolean;
  const Control: TControl; const Position: TKeyTipPosition): TCustomControl; overload;
function ShowKeyTip(const KeyTip: string; const Enabled, Center: Boolean;
  const Rect: TRect; const Position: TKeyTipPosition): TCustomControl; overload;

implementation

uses
  {$IFDEF CLR}
  System.Runtime.InteropServices, WinUtils,
  {$ENDIF}
  Vcl.Dialogs, Vcl.GraphUtil, System.Math, Vcl.Menus, Vcl.ImgList, Vcl.Themes, System.SysUtils, Vcl.RibbonConsts,
  Vcl.Ribbon, Vcl.RibbonActnMenus, Vcl.RibbonGalleryBar, Vcl.RibbonLunaStyleActnCtrls, System.SyncObjs;

function IsLeftMouseButtonPressed(Control: TControl): Boolean;
begin
  Result := not ((GetAsyncKeyState(VK_LBUTTON) and $8000) = 0);
end;

procedure DrawLine(ACanvas: TCanvas; const AFromPt, AToPt: TPoint);
begin
  ACanvas.MoveTo(AFromPt.X, AFromPt.Y);
  ACanvas.LineTo(AToPt.X, AToPt.Y);
end;

type
  TFadeDirection = (fdUp, fdDown, fdNone);

  TFadeManager = class;

  TFadeItem = class
  private
    FControl: TControl;
    FCount: Integer;
    FDirection: TFadeDirection;
    FTimer: TTimer;
    FManager: TFadeManager;
    FRemoveWhenDone: Boolean;
    FSteps: Integer;
    procedure TimerHandler(Sender: TObject);
    function NotFinished: Boolean;
  public
    constructor Create(AManager: TFadeManager; AControl: TControl;
      ADirection: TFadeDirection);
    destructor Destroy; override;
    procedure Toggle;
    property Control: TControl read FControl;
    property Steps: Integer read FSteps write FSteps;
  end;

  TFadeControls = class
  private
    FControls: TObjectList;
    FControlsCS: TCriticalSection;
    FSteps: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(var AFadeItem: TFadeItem);
    procedure Remove(AFadeItem: TFadeItem);
    function Get(AControl: TControl): TFadeItem;
    property Steps: Integer read FSteps write FSteps;
  end;

  TFadeManager = class
  private
    FControls: TFadeControls;
    procedure SetSteps(const Value: Integer);
    function GetSteps: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddControl(AControl: TControl; ADirection: TFadeDirection = fdUp);
    procedure RemoveControl(AControl: TControl; AFadeFirst: Boolean = True); overload;
    procedure RemoveControl(AFadeItem: TFadeItem); overload;
    property Steps: Integer read GetSteps write SetSteps;
  end;

var
  FFadeManager: TFadeManager;

function FadeManager: TFadeManager;
begin
  if FFadeManager = nil then
    FFadeManager := TFadeManager.Create;
  Result := FFadeManager;
end;

type
  // The class used to show a KeyTip for a particular item on the Ribbon
  // By default the window is rounded and has an opacity of 200.
  TKeyTipWindow = class(TCustomControl)
  private
    FKeyTip: string;
    procedure SetKeyTip(const Value: string);
  protected
    procedure CreateWnd; override;
    procedure Paint; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    class function ShowKeyTip(const KeyTip: string; const Enabled: Boolean): TKeyTipWindow;
    property KeyTip: string write SetKeyTip;
  end;

constructor TKeyTipWindow.Create(AOwner: TComponent);
begin
  inherited;
  ClientHeight := 15;
  ClientWidth := 16;
  FKeyTip := '';
end;           

procedure TKeyTipWindow.SetKeyTip(const Value: string);
begin
  if FKeyTip <> Value then
  begin
    FKeyTip := Value;
    ClientWidth := Max(16, Canvas.TextWidth(FKeyTip) + 6);
  end;
end;

class function TKeyTipWindow.ShowKeyTip(const KeyTip: string; const Enabled: Boolean): TKeyTipWindow;
begin
  Result := TKeyTipWindow.Create(nil);
  if Enabled then
    Result.Color := clSkyBlue
  else
    Result.Color := clLtGray;
  Result.KeyTip := Uppercase(KeyTip);
  Result.ParentWindow := Application.Handle;
end;

procedure TKeyTipWindow.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := WS_POPUP;
  Params.ExStyle := WS_EX_TOPMOST or WS_EX_TOOLWINDOW or WS_EX_LAYERED;
end;

procedure TKeyTipWindow.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if Assigned(Vcl.Forms.SetLayeredWindowAttributes) then
    Vcl.Forms.SetLayeredWindowAttributes(Handle, 0, 200, LWA_ALPHA);
end;

procedure TKeyTipWindow.CreateWnd;
var
  LRgn: HRgn;
begin
  inherited;
  LRgn := CreateRoundRectRgn(0, 0, ClientWidth + 1, ClientHeight + 1, 3, 3);
  SetWindowRgn(Handle, LRgn, True);
end;

procedure TKeyTipWindow.Paint;
var
  LRect: TRect;
  LFlags: Cardinal;
begin
  LRect := ClientRect;
  Canvas.Brush.Color := Color;
  Canvas.Pen.Color := clGray;
  Canvas.Brush.Style := bsSolid;
  Canvas.RoundRect(LRect, 5, 5);
  Canvas.Brush.Style := bsClear;
  OffSetRect(LRect, 1, 0);
  LFlags := DT_CENTER or DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;
  DrawText(Canvas.Handle, FKeyTip, -1, LRect, LFlags);
end;

// Show the KeyTip at a particular rect specified
// KeyTip - The KeyTip to display
// Enabled - If the KeyTip should have an enabled appearance
// Center - Center the control
// Position - The position of the KeyTip. The position of the KeyTip can be
//   either ktpCenter or ktpBottom. Most KeyTips are displayed with the bottom
//   third of the control covered with the KeyTip.
function ShowKeyTip(const KeyTip: string; const Enabled, Center: Boolean;
  const Rect: TRect; const Position: TKeyTipPosition): TCustomControl; overload;
var
  LLeft, LTop: Integer;
begin
  if KeyTip <> '' then
  begin
    Result := TKeyTipWindow.ShowKeyTip(KeyTip, Enabled);
    case Position of
      ktpApplicationButton:
        begin
          LLeft := Rect.Left + ((Rect.Right - Result.Width) div 2);
          LTop := Rect.Top + ((Rect.Bottom - Result.Height) div 2);
        end;
      ktpQuickAccessToolbar:
        begin
          LLeft := Rect.Left + ((Rect.Right - Result.Width) div 2);
          LTop := Rect.Top + Round((Rect.Bottom - 6) * 0.66);
        end;
      ktpTabs:
        begin
          LLeft := Rect.Left + ((Rect.Right - Result.Width) div 2);
          LTop := Rect.Top + ((Rect.Bottom - Result.Height) div 2) + 5;
        end;
      ktpGroupA, ktpGroupB:
        begin
          if Center then
            LLeft := Rect.Left + ((Rect.Right - Result.Width) div 2)
          else
            LLeft := Rect.Left + 12;
          if Position = ktpGroupA then
            LTop := Rect.Top + Rect.Bottom - 16
          else
            LTop := Rect.Top;
        end;
      ktpGroupC:
        begin
          if Center then
            LLeft := Rect.Left + ((Rect.Right - Result.Width) div 2)
          else
            LLeft := Rect.Left + 12;
          LTop := Rect.Top;// + Rect.Bottom - 8;
        end;
      ktpGroupD:
        begin
          if Center then
            LLeft := Rect.Left + ((Rect.Right - Result.Width) div 2)
          else
            LLeft := Rect.Left;
          LTop := Rect.Top + Rect.Bottom;
        end
    else
      LLeft := Rect.Left + ((Rect.Right - Result.Width) div 2);
      LTop := Rect.Top + ((Rect.Bottom - Result.Height) div 2);
    end;
    SetWindowPos(Result.Handle, HWND_TOP, LLeft, LTop, Result.Width,
      Result.Height, SWP_NOACTIVATE or SWP_SHOWWINDOW);
  end
  else
    Result := nil;
end;

// Show the KeyTip for the Control specified
// KeyTip - The KeyTip to display
// Enabled - If the KeyTip should have an enabled appearance
// Control - The control that the KeyTip is for. The KeyTip will display close
//   to the control
// Position - The position of the KeyTip. The position of the KeyTip can be
//   either ktpCenter or ktpBottom. Most KeyTips are displayed with the bottom
//   third of the control covered with the KeyTip.
function ShowKeyTip(const KeyTip: string; const Enabled: Boolean;
  const Control: TControl; const Position: TKeyTipPosition): TCustomControl;
var
  LPt: TPoint;
  LGroupPt: TPoint;
  LRect: TRect;
  LCenter: Boolean;
begin
  if KeyTip <> '' then
  begin
    LCenter := ((Control is TCustomActionControl) and
      not (TCustomActionControl(Control).ActionClient.HasGlyph)) or
      not (Control is TCustomActionControl);
    if (Control is TCustomActionControl) and
      (TButtonProperties(TCustomActionControl(Control).ActionClient.CommandProperties).ButtonSize = bsLarge) then
      LCenter := True;
    LPt := Control.ClientToScreen(Point(0, 0));
    if Control is TCustomActionControl then
    begin
      LGroupPt := Control.Parent.ClientToScreen(Point(0, 0));
      case Position of
//        ktpApplicationButton: ;
//        ktpQuickAccessToolbar: ;
//        ktpTabs: ;
        ktpGroupA: LPt.Y := LGroupPt.Y + -8;
        ktpGroupB: LPt.Y := LGroupPt.Y + 28;
        ktpGroupC: LPt.Y := LGroupPt.Y + 58;
        ktpGroupD: LPt.Y := LGroupPt.Y + 83;
      end;
    end;    
    LRect := Rect(LPt.X, LPt.Y, Control.Width, Control.Height);
    Result := ShowKeyTip(KeyTip, Enabled, LCenter, LRect, Position);
  end
  else
    Result := nil;
end;

constructor TKeyTipMatchItem.Create(AType: TKeyTipMatchType;
  AHandled: TKeyTipHandled; AControl: TControl; AIndex: Integer = -1);
begin
  inherited Create;
  FControl := AControl;
  FHandled := AHandled;
  FIndex := AIndex;
  FMatchType := AType;
end;

class procedure TKeyTipValidator.Validate(const SrcKeyTip, CmdKeyTip: string;
   Control: TControl; var Handled: TKeyTipHandled);
begin
  Handled := ktNone;
  // When validating tab KeyTips, the Control parameter will be nil
  if ((Control = nil) or ((Control <> nil) and (Control.Enabled))) and (Length(CmdKeyTip) > 0) then
  begin
    if SrcKeyTip = Uppercase(CmdKeyTip) then
      Handled := ktFull
    else if (Length(SrcKeyTip) > 0) and (Length(SrcKeyTip) < Length(CmdKeyTip)) then
    begin
      if SrcKeyTip[1] = Uppercase(CmdKeyTip[1]) then
        Handled := ktPartial;
    end;
  end;
end;

{ TRibbonLargeButtonControl }

procedure TRibbonLargeButtonControl.CalcBounds;
begin
  inherited;
  Height := 66;
  // The width of the button needs to be at least 42
  Width := Max(42, TextBounds.Right - TextBounds.Left + 10);
  // Glyph must be centered
  GlyphPos := Point((Width - GetImageSize.X) div 2, 3);
end;

procedure GetButtonWidth(Canvas: TCanvas; const Str: string; var Rect: TRect);
var
  LCalcRect: TRect;
  LWidth: Integer; // Width of the button text without line breaks
  LHeight: Integer; // Height of the button text
begin
  LWidth := Canvas.TextWidth(Str);
  LHeight := Canvas.TextHeight(Str) * 2;
  if LWidth > 32 then
  begin
    LCalcRect := Rect;
    DrawText(Canvas.Handle, Str, -1, LCalcRect, DT_CALCRECT or DT_WORDBREAK);
    while LCalcRect.Bottom > LHeight do
    begin
      inc(Rect.Right, 10);
      LCalcRect := Rect;
      DrawText(Canvas.Handle, Str, -1, LCalcRect, DT_CALCRECT or DT_WORDBREAK);
    end;
    Rect := LCalcRect;
  end
  else
    DrawText(Canvas.Handle, Str, -1, Rect, DT_CALCRECT);
end;

procedure TRibbonLargeButtonControl.CalcLayout;
var
  LRect: TRect;
  LCaption: string;
begin
  if Canvas.HandleAllocated then
  begin
    if ActionClient <> nil then
      LCaption := StripHotKey(ActionClient.Caption)
    else
      LCaption := StripHotKey(Caption);
    LRect := Rect(0, 0, 42, 0);
    GetButtonWidth(Canvas, LCaption, LRect);
    TextBounds := Rect(5, 38, Max(LRect.Right - LRect.Left + 5, 37), 38 + LRect.Bottom);
  end;
end;

procedure TRibbonLargeButtonControl.DrawBackground(var PaintRect: TRect);
begin
  if MouseInControl and not ActionBar.DesignMode then
  begin
    if IsLeftMouseButtonPressed(Self) and (FState = bsDown) then
      RibbonStyle.DrawElement(sbLargePressed, Canvas, PaintRect)
    else if IsChecked then
      RibbonStyle.DrawElement(sbLargeHoverSelected, Canvas, PaintRect)
    else
      RibbonStyle.DrawElement(sbLargeHover, Canvas, PaintRect)
  end
  else if (not MouseInControl or ActionBar.DesignMode) and IsChecked then
    RibbonStyle.DrawElement(sbLargeSelected, Canvas, PaintRect)
end;

procedure TRibbonLargeButtonControl.DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string; TextColor,
  ShadowColor: TColor);
begin
  Flags := Flags or DT_WORDBREAK or DT_CENTER;
  inherited;
end;

procedure TRibbonLargeButtonControl.DrawText(var ARect: TRect; var Flags: Cardinal; Text: string);
begin
  Flags := Flags or DT_WORDBREAK or DT_CENTER;
  inherited;
end;

{ TRibbonBaseButtonControl }

function TRibbonBaseButtonControl.ActualSpacing(ImageSize: TPoint): Integer;
begin
  // Assumes that if the CaptionLength = 0 then CaptionHeight would also = 0
  if (ImageSize.X = 0) or (CaptionLength = 0) then
    Result := 0
  else
    Result := Spacing;
end;

function TRibbonBaseButtonControl.AllowHotKeys: Boolean;
begin
  Result := False;
end;

procedure TRibbonBaseButtonControl.CalcBounds;
var
  LButtonProps: TButtonProperties;
begin
  inherited;
  if not IsButton(LButtonProps) then
    Exit;
  if Separator and IsRibbonAvailable then
    Height := 66
  else
  begin
    case LButtonProps.ButtonSize of
      bsSmall:
        begin
          Height := 22;
          if not ActionClient.ShowCaption then
          begin
            case LButtonProps.GroupPosition of
              gpNone: Width := 24;
              gpStart: Width := 22;
              gpMiddle: Width := 24;
              gpEnd: Width := 23;
              gpSingle: Width := 24;
            end;
          end;
          if (LButtonProps.ButtonType = btSplit) or (LButtonProps.ButtonType = btDropDown) then
            Width := Width + 7;
        end;
      bsLarge:
        begin
          if (LButtonProps.ButtonType = btSplit) then
          begin
            Width := Max(Margins.Left + GetImageSize.X + Margins.Right, Margins.Left + CaptionLength + Margins.Right);
            Height := Margins.Top + GetImageSize.Y + ActualSpacing(GetImageSize) + CaptionHeight + Margins.Bottom;
          end
          else if (LButtonProps.ButtonType = btDropDown) then
          begin
            Width := Max(Margins.Left + GetImageSize.X + Margins.Right, Margins.Left + CaptionLength + Margins.Right);
            Height := Margins.Top + GetImageSize.Y + ActualSpacing(GetImageSize) + CaptionHeight + Margins.Bottom;
          end;
          Width := Width + 12;
        end;
    end;
  end;
end;

function TRibbonBaseButtonControl.CanAddToQuickAccessToolbar: Boolean;
begin
  Result := True;
end;

function TRibbonBaseButtonControl.CaptionHeight: Integer;
begin
  if Assigned(ActionClient) and ShowCaption or not HasGlyph or
     (ActionClient.ActionClients.CaptionOptions = coAll) then
    Result := TextBounds.Bottom - TextBounds.Top
  else
    Result := 0;
end;

function TRibbonBaseButtonControl.CaptionLength: Integer;
begin
  if Assigned(ActionClient) and ShowCaption or not HasGlyph or
     (ActionClient.ActionClients.CaptionOptions = coAll) then
    Result := TextBounds.Right - TextBounds.Left
  else
    Result := 0;
end;

procedure TRibbonBaseButtonControl.Click;
begin
  inherited;
  SetFocus(Application.MainForm.Handle);
end;

constructor TRibbonBaseButtonControl.Create(AOwner: TComponent);
begin
  inherited;
  FDrawDown := False;
  FKeyTip := nil;
end;

destructor TRibbonBaseButtonControl.Destroy;
begin
  HideKeyTip('');
  inherited;
end;

procedure TRibbonBaseButtonControl.DragDrop(Source: TObject; X, Y: Integer);
var
  LIntf: IRibbonGroup;
  LQATIntf: IRibbonQuickAccessToolbar;
begin
  inherited;
  if Supports(ActionBar, IRibbonGroup, LIntf) then
    LIntf.AlignGroupControls;
  if Supports(ActionBar, IRibbonQuickAccessToolbar, LQATIntf) then
    LQATIntf.DoUpdateQATWidth;
end;

function TRibbonBaseButtonControl.GetKeyTip: string;
begin
  Result := ActionClient.KeyTip;
end;

procedure TRibbonBaseButtonControl.HandleKeyTip(const KeyTip: string;
  var Handled: TKeyTipHandled);
begin
  TKeyTipValidator.Validate(KeyTip, GetKeyTip, Self, Handled);
end;

procedure TRibbonBaseButtonControl.HideKeyTip;
begin
  if FKeyTip <> nil then
    FreeAndNil(FKeyTip);
end;

function TRibbonBaseButtonControl.IsButton(out ButtonProperties: TButtonProperties): Boolean;
begin
  ButtonProperties := GetButtonProps;
  Result := ButtonProperties <> nil;
end;

// Call IsRibbonAvailable to check if the control is currently being used in an
// application that is using the Ribbon User Interface.
//
// If IsRibbonAvailable returns False, then one of the Ribbon styles is being
// used a in traditional ActionManager / Toolbar interface.
function TRibbonBaseButtonControl.IsRibbonAvailable: Boolean;
begin
  Result := (ActionBar <> nil) and (ActionBar is TCustomRibbonGroup);
end;

procedure TRibbonBaseButtonControl.KeyTipClick;
begin
  Click;
end;

procedure TRibbonBaseButtonControl.SetKeyTip(const Value: string);
begin
  ActionClient.KeyTip := Value;
end;

procedure TRibbonBaseButtonControl.ShowKeyTip(const Position: TKeyTipPosition);
begin
  if FKeyTip <> nil then
    FKeyTip.Free;
  FKeyTip := Vcl.RibbonActnCtrls.ShowKeyTip(ActionClient.KeyTip, Enabled, Self, Position);
end;

const
  HoverSelectedElement: array [Boolean] of TSkinButton = (sbSmallHoverSelected, sbLargeHoverSelected);
  SelectedElement: array [Boolean] of TSkinButton = (sbSmallSelected, sbLargeSelected);
  HoverElement: array [Boolean] of TSkinButton = (sbSmallHover, sbLargeHover);
  PressedElement: array [Boolean] of TSkinButton = (sbSmallPressed, sbLargePressed);

procedure TRibbonBaseButtonControl.DrawBackground(var PaintRect: TRect);
var
  LRect: TRect;
  LButtonProps: TButtonProperties;
  LLargeButtons: Boolean;
  LGroupPosition: TButtonProperties.TGroupPosition;
begin
  if not IsButton(LButtonProps) then
    Exit;

  LLargeButtons := LButtonProps.ButtonSize = bsLarge;
  // Large buttons or buttons with captions cannot be grouped
  if LLargeButtons or ActionClient.ShowCaption then
    LGroupPosition := gpNone
  else
    LGroupPosition := LButtonProps.GroupPosition;
  if IsChecked then
  begin
    if MouseInControl and not ActionBar.DesignMode then
    begin
      case LGroupPosition of
        gpNone: RibbonStyle.DrawElement(HoverSelectedElement[LLargeButtons], Canvas, PaintRect);
        gpStart: RibbonStyle.DrawElement(sbGroupStartHoverSelected, Canvas, PaintRect);
        gpMiddle: RibbonStyle.DrawElement(sbGroupMiddleHoverSelected, Canvas, PaintRect);
        gpEnd: RibbonStyle.DrawElement(sbGroupEndHoverSelected, Canvas, PaintRect);
        gpSingle: RibbonStyle.DrawElement(sbGroupSingleHoverSelected, Canvas, PaintRect);
      end;
    end
    else
    begin
      case LGroupPosition of
        gpNone: RibbonStyle.DrawElement(SelectedElement[LLargeButtons], Canvas, PaintRect);
        gpStart: RibbonStyle.DrawElement(sbGroupStartSelected, Canvas, PaintRect);
        gpMiddle: RibbonStyle.DrawElement(sbGroupMiddleSelected, Canvas, PaintRect);
        gpEnd: RibbonStyle.DrawElement(sbGroupEndSelected, Canvas, PaintRect);
        gpSingle: RibbonStyle.DrawElement(sbGroupSingleSelected, Canvas, PaintRect);
      end;
    end;
  end
  else if Enabled and (MouseInControl and not ActionBar.DesignMode and
    (not (IsLeftMouseButtonPressed(Self) and (FState = bsDown)) and not DrawDown)) then
  begin
    // hover
    case LGroupPosition of
      gpNone: RibbonStyle.DrawElement(HoverElement[LLargeButtons], Canvas, PaintRect);
      gpStart: RibbonStyle.DrawElement(sbGroupStartHover, Canvas, PaintRect);
      gpMiddle: RibbonStyle.DrawElement(sbGroupMiddleHover, Canvas, PaintRect);
      gpEnd: RibbonStyle.DrawElement(sbGroupEndHover, Canvas, PaintRect);
      gpSingle: RibbonStyle.DrawElement(sbGroupSingleHover, Canvas, PaintRect);
    end;
  end
  else if Enabled and ((MouseInControl and not ActionBar.DesignMode and
    IsLeftMouseButtonPressed(Self) and (FState = bsDown)) or Down or DrawDown) then
  begin
    // pressed, down
    case LGroupPosition of
      gpNone: RibbonStyle.DrawElement(PressedElement[LLargeButtons], Canvas, PaintRect);
      gpStart: RibbonStyle.DrawElement(sbGroupStartPressed, Canvas, PaintRect);
      gpMiddle: RibbonStyle.DrawElement(sbGroupMiddlePressed, Canvas, PaintRect);
      gpEnd: RibbonStyle.DrawElement(sbGroupEndPressed, Canvas, PaintRect);
      gpSingle: RibbonStyle.DrawElement(sbGroupSinglePressed, Canvas, PaintRect);
    end;
  end
  else
  begin
    LRect := PaintRect;
    // normal / disabled
    case LGroupPosition of
      gpNone: ;
      gpStart: RibbonStyle.DrawElement(sbGroupStart, Canvas, PaintRect);
      gpMiddle: RibbonStyle.DrawElement(sbGroupMiddle, Canvas, PaintRect);
      gpEnd: RibbonStyle.DrawElement(sbGroupEnd, Canvas, PaintRect);
      gpSingle: RibbonStyle.DrawElement(sbGroupSingle, Canvas, PaintRect);
    end;
  end;
end;

procedure TRibbonBaseButtonControl.DrawGlyph(const Location: TPoint);
var
  LImageList: TCustomImageList;
  LDrawEnabled: Boolean;
  LDisabled: Boolean;
  LUseLargeImages: Boolean;
  LButtonProps: TButtonProperties;
begin
  if (ActionClient.ImageIndex = -1) or not IsButton(LButtonProps) then
    Exit;
  LUseLargeImages := LButtonProps.ButtonSize = bsLarge;
  LImageList := FindImageList(LUseLargeImages, LDisabled, ActionClient.ImageIndex);
  if not Assigned(LImageList) then
    Exit;
  LDrawEnabled := (Enabled or LDisabled) and (ActionClient.ImageIndex <> -1) or
    (csDesigning in ComponentState);
  LImageList.Draw(Canvas, Location.X, Location.Y, ActionClient.ImageIndex,
    dsTransparent, itImage, LDrawEnabled);
  Canvas.Brush.Style := bsClear;
end;

procedure TRibbonBaseButtonControl.DrawSeparator(const Offset: Integer);
begin
  if Parent.Enabled then
    RibbonStyle.DrawElement(sbSeparator, Canvas, Rect(Offset + 4, 5, OffSet + 4 + 2, 60))
  else
    RibbonStyle.DrawElement(sbDisabledSeparator, Canvas, Rect(Offset + 4, 5, OffSet + 4 + 2, 60));
end;

procedure TRibbonBaseButtonControl.DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string; TextColor,
  ShadowColor: TColor);
var
  LText: string;
begin
  if AllowHotKeys then
    LText := Text
  else
    LText := StripHotKey(Text);
  DrawText(Rect, Flags, LText);
end;

procedure TRibbonBaseButtonControl.DrawText(var ARect: TRect; var Flags: Cardinal; Text: string);
var
  LText: string;
begin
  if MouseInControl and (ActionBar.ColorMap.HotFontColor <> clDefault) then
    Canvas.Font.Color := ActionBar.ColorMap.HotFontColor
  else if Enabled then
    Canvas.Font.Color := ActionBar.ColorMap.FontColor
  else
    Canvas.Font.Color := ActionBar.ColorMap.DisabledColor;
  if AllowHotKeys then
    LText := Text
  else
    LText := StripHotKey(Text);
  inherited DrawText(ARect, Flags, LText);
end;

function TRibbonBaseButtonControl.GetButtonProps: TButtonProperties;
begin
  Result := nil;
  if (ActionClient <> nil) and (ActionClient.CommandProperties <> nil) then
  begin
    if ActionClient.CommandStyle in [csButton, csGallery] then
      Result := ActionClient.CommandProperties as TButtonProperties;
  end;
end;

function TRibbonBaseButtonControl.GetImageSize: TPoint;
var
  LButtonProps: TButtonProperties;
begin
  Result := Point(0, 0);
  if not ActionClient.HasGlyph or (not ActionClient.ShowGlyph) then
    exit;
  if (ActionClient <> nil) and IsButton(LButtonProps) then
  begin
    case LButtonProps.ButtonSize of
      bsSmall:
        begin
          result.X := 16;
          result.Y := 16;
        end;
      bsLarge:
        begin
          result.X := 32;
          result.Y := 32;
        end;
    end;
  end
  else
    Result := inherited GetImageSize;
end;

procedure TRibbonBaseButtonControl.SetDrawDown(const Value: Boolean);
begin
  if FDrawDown <> Value then
  begin
    FDrawDown := Value;
    Invalidate;
  end;
end;

function TRibbonBaseButtonControl.RibbonStyle: TRibbonStyleActionBars;
begin
  if (ActionBar.ActionManager <> nil) and
    (ActionBar.ActionManager.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(ActionBar.ActionManager.Style)
  else
    Result := RibbonLunaStyle;
end;

{ TRibbonLargeSplitButton }

procedure TRibbonLargeSplitButton.CalcBounds;
begin
  inherited;
  UpdateSplitBounds;
end;

procedure TRibbonLargeSplitButton.CalcLayout;
begin
  inherited;
  UpdateSplitBounds;
end;

procedure TRibbonLargeSplitButton.Click;
begin
  if InSplit(Mouse.CursorPos.X, Mouse.CursorPos.Y) then
    DoSplitButtonClick(False)
  else
  begin
    inherited;
    SetFocus(Application.MainForm.Handle);
  end;
end;

procedure TRibbonLargeSplitButton.CMMouseleave(var Message: TMessage);
begin
  FCursorInSplit := False;
  inherited;
end;

procedure TRibbonLargeSplitButton.DoSplitButtonClick(const SelectFirst: Boolean);
var
  LPt: TPoint;
  LPopupMenu: TCustomActionPopupMenu;
begin
  if Assigned(ActionClient) and (ActionClient.Items.Count > 0) then
  begin
    if ActionClient.CommandStyle = csGallery then
      LPopupMenu := TRibbonGalleryPopupBar.Create(Owner)
    else
      LPopupMenu := TRibbonActionPopupMenu.Create(Owner);
    try
      LPopupMenu.ColorMap := ActionBar.ColorMap;
      LPopupMenu.ContextBar := False;
      LPopupMenu.Parent := Parent;
      LPopupMenu.ParentControl := Self;
      LPopupMenu.ActionClient := ActionClient;
      case Actionbar.Orientation of
        boBottomToTop: LPt := Parent.ClientToScreen(Point(Self.Left,
          Self.Top - LPopupMenu.Height));
        boTopToBottom: LPt := Parent.ClientToScreen(Point(Self.Left,
          Self.Top + Self.Height));
        boLeftToRight,
        boRightToLeft: LPt := Parent.ClientToScreen(Point(Self.Left, Self.Top + Self.Height));
      end;
      DrawDown := True;
      Invalidate;
      if LPopupMenu is TRibbonActionPopupMenu then
        TRibbonActionPopupMenu(LPopupMenu).SelectFirstItem := SelectFirst;
      LPopupMenu.Popup(LPt.X, LPt.Y);
      DrawDown := False;
      Invalidate;
    finally
      LPopupMenu.Free;
    end;
  end;
end;

procedure TRibbonLargeSplitButton.DrawArrow(Location: TPoint; Color, ShadowColor: TColor; Size: Integer);
begin
  Canvas.Pen.Color := ShadowColor;
  Vcl.GraphUtil.DrawArrow(Canvas, sdDown, Location, Size);
  Canvas.Pen.Color := Color;
  Vcl.GraphUtil.DrawArrow(Canvas, sdDown, Point(Location.X, Location.Y - 1), Size);
end;

procedure TRibbonLargeSplitButton.DrawBackground(var PaintRect: TRect);
var
  LPt: TPoint;
begin
  if not ActionBar.DesignMode and (MouseInControl or DrawDown) then
  begin
    if CursorInSplit or DrawDown then
    begin
      if IsChecked then
        RibbonStyle.DrawElement(sbLargeSplitHoverSelected, Canvas, PaintRect)
      else
        RibbonStyle.DrawElement(sbLargeSplitActive, Canvas, PaintRect);
      if (IsLeftMouseButtonPressed(Self) and (FState = bsDown)) or DrawDown then
        RibbonStyle.DrawElement(sbLargeSplitPressed, Canvas, FSplitRect)
      else 
        RibbonStyle.DrawElement(sbLargeSplitHover, Canvas, FSplitRect);
    end
    else if MouseInControl or Selected then
    begin
      if (IsLeftMouseButtonPressed(Self) and (FState = bsDown)) then
        RibbonStyle.DrawElement(sbLargePressed, Canvas, PaintRect)
      else if IsChecked then
        RibbonStyle.DrawElement(sbLargeSplitHoverSelected, Canvas, PaintRect)
      else
        RibbonStyle.DrawElement(sbLargeHover, Canvas, PaintRect);
      RibbonStyle.DrawElement(sbLargeSplit, Canvas, FSplitRect);
    end;
  end
  else if IsChecked then
  begin
    RibbonStyle.DrawElement(sbLargeSplitSelected, Canvas, PaintRect);
    RibbonStyle.DrawElement(sbLargeSplitSelected, Canvas, FSplitRect);
  end;
  LPt := GetArrowPosition(TextBounds);
  if Enabled then
    RibbonStyle.DrawElement(sbArrow, Canvas, Rect(LPt.X, LPt.Y, 0 , 0))
  else
    RibbonStyle.DrawElement(sbArrowDisabled, Canvas, Rect(LPt.X, LPt.Y, 0 , 0));
end;

function TRibbonLargeSplitButton.GetArrowPosition(const AREct: TRect): TPoint;
var
  LX: Integer;
  LY: Integer;

  function IsMultiline: Boolean;
  begin
    Result := TextBounds.Bottom - TextBounds.Top > Canvas.TextHeight(Text);
  end;

begin
  LX := (Width - TextBounds.Right - TextBounds.Left) div 2;
  LX := TextBounds.Right - TextBounds.Left + LX;
  LY := 0;
  if (GetButtonProps.ButtonType = btSplit) then
  begin
    LX := (Width div 2) - 2;
    LY := ARect.Top + (Canvas.TextHeight(Text) div 2);
    // center the arrow
    if not IsMultiline then
      LY := LY + (Canvas.TextHeight(Text)) - 1;
  end
  else if (GetButtonProps.ButtonType = btDropDown) then
  begin
    LX := Width - 10;
    LY := TextBounds.Top + ((TextBounds.Bottom - TextBounds.Top) div 2) - 1;
  end;
  Result := Point(LX, LY);
end;

function TRibbonLargeSplitButton.InSplit(X, Y: Integer): Boolean;
begin
  Result := FSplitRect.Contains(Point(X, Y));
end;

procedure TRibbonLargeSplitButton.KeyTipClick;
begin
  DoSplitButtonClick(True);
end;

procedure TRibbonLargeSplitButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  CursorInSplit := InSplit(X, Y);
  if Button = mbLeft then
    FDownInSplit := InSplit(X, Y);
  inherited;
end;

procedure TRibbonLargeSplitButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  CursorInSplit := InSplit(X, Y);
end;

procedure TRibbonLargeSplitButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if (Button = mbLeft) and (InSplit(X, Y)) and (FDownInSplit) then
    DoSplitButtonClick(False)
  else
    inherited;
end;

procedure TRibbonLargeSplitButton.SetCursorInSplit(const Value: Boolean);
begin
  if FCursorInSplit <> Value then
  begin
    FCursorInSplit := Value;
    Invalidate;
  end;
end;

procedure TRibbonLargeSplitButton.UpdateSplitBounds;
begin
  if ActionClient <> nil then
    FSplitRect := Rect(1, 36, Width - 1, Height)
end;

{ TRibbonSmallButtonControl }

procedure TRibbonSmallButtonControl.CalcBounds;
begin
  inherited;
  if Separator and IsRibbonAvailable then
    Height := 66
  else
    Height := 22;
end;

{ TRibbonSeparator }

procedure TRibbonSeparator.CalcBounds;
begin
  inherited;
  if Canvas.HandleAllocated then
  begin
    Canvas.Font.Style := [fsBold];
    Width := Max(Width, Canvas.TextWidth(Caption) + 8);
    if Parent is TRibbonStyleMainPopupMenu then
      Width := Parent.ClientWidth - 2;
  end;
  Height := 25;
  if ActionClient <> nil then
  begin
    if (ActionClient.Index = 0) then
      Height := 23;
  end
end;

constructor TRibbonSeparator.Create(AOwner: TComponent);
begin
  inherited;
  Enabled := False;
end;

procedure TRibbonSeparator.DrawBackground(var PaintRect: TRect);
var
  LRect: TRect;
begin
  LRect := PaintRect;
  // The first separator in a menu doesn't show the top line
  if ActionClient.Index = 0 then
    Dec(LRect.Top, 2);
  RibbonStyle.DrawElement(smSeparator, Canvas, LRect);
end;

procedure TRibbonSeparator.DrawGlyph(const Location: TPoint);
begin
  // Separators can't display a glyph
end;

procedure TRibbonSeparator.DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string; TextColor,
  ShadowColor: TColor);
begin
  // The TRibbonSeparator does not have a disabled state
  DrawText(Rect, Flags, Text);
end;

procedure TRibbonSeparator.DrawText(var ARect: TRect; var Flags: Cardinal; Text: string);
var
  LText: string;
begin
  Canvas.Font.Color := ActionBar.ColorMap.FontColor;
  Canvas.Font.Style := [fsBold];
  LText := StripHotKey(Text);
  Flags := DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS;
  ARect.Left := 4;
  ARect.Right := Width;
  ARect.Top := 0;
  ARect.Bottom := ARect.Top + Height;
  inherited DrawText(ARect, Flags, LText);
end;

function TRibbonSeparator.RibbonStyle: TRibbonStyleActionBars;
begin
  if (ActionBar.ActionManager <> nil) and
    (ActionBar.ActionManager.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(ActionBar.ActionManager.Style)
  else
    Result := RibbonLunaStyle;
end;

{ TRibbonGalleryItem }

procedure TRibbonGalleryItem.CalcBounds;
var
  LImageList: TCustomImageList;
begin
  inherited;
  if ActionClient <> nil then
  begin
    LImageList := FindImageList(False, ActionClient.ImageIndex);
    if LImageList <> nil then
    begin
      Height := LImageList.Height + 8;
      Width := LImageList.Width + 8;
    end;
  end;
end;

procedure TRibbonGalleryItem.CalcLayout;
begin
  inherited;
  GlyphPos := Point(4, 4);
end;

{ TRibbonGallerySplitButton }

function TRibbonGallerySplitButton.GetPopupClass: TCustomPopupClass;
begin
  Result := TRibbonGalleryPopupBar;
end;

{ TRibbonGalleryMenuItem }

procedure TRibbonGalleryMenuItem.CalcBounds;
var
  LImageList: TCustomImageList;
begin
  inherited;
  if ActionClient <> nil then
  begin
    LImageList := FindImageList(False, ActionClient.ImageIndex);
    if LImageList <> nil then
    begin
      Height := LImageList.Height + 8;
      Width := LImageList.Width + 8;
    end;
  end;
end;

procedure TRibbonGalleryMenuItem.DrawBackground(var PaintRect: TRect);
begin
  if not ActionBar.DesignMode and Enabled then
  begin
    if Selected then
  begin
      if IsLeftMouseButtonPressed(Self) then
        RibbonStyle.DrawElement(sgItemPressed, Canvas, PaintRect)
      else if IsChecked then
        RibbonStyle.DrawElement(sgItemHoverSelected, Canvas, PaintRect)
      else
        RibbonStyle.DrawElement(sgItemHover, Canvas, PaintRect);
  end
    else if IsChecked then
      RibbonStyle.DrawElement(sgItemSelected, Canvas, PaintRect)
  end;
end;

procedure TRibbonGalleryMenuItem.DrawGlyph(const Location: TPoint);
var
  LNewLocation: TPoint;
begin
  LNewLocation.X := 4;
  LNewLocation.Y := 4;
  inherited DrawGlyph(LNewLocation);
end;

procedure TRibbonGalleryMenuItem.DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string; TextColor,
  ShadowColor: TColor);
begin
  //inherited;
end;

procedure TRibbonGalleryMenuItem.DrawText(var ARect: TRect; var Flags: Cardinal; Text: string);
begin
  //inherited;
end;

procedure TRibbonGalleryMenuItem.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Invalidate;
end;

procedure TRibbonGalleryMenuItem.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Invalidate;
end;

function TRibbonGalleryMenuItem.RibbonStyle: TRibbonStyleActionBars;
begin
  if (ActionBar.ActionManager <> nil) and
    (ActionBar.ActionManager.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(ActionBar.ActionManager.Style)
  else
    Result := RibbonLunaStyle;
end;

{ TRibbonGalleryControlMenuItem }

procedure TRibbonGalleryControlMenuItem.Paint;
begin
  // A Gallery Control menu item doesn't do any painting
end;

procedure TRibbonGalleryControlMenuItem.SetParent(AParent: TWinControl);
begin
  inherited;
  if FContainedControl <> nil then
    FContainedControl.Parent := AParent;
end;

procedure TRibbonGalleryControlMenuItem.CalcBounds;
begin
  if FContainedControl <> nil then
  begin
    Width := FContainedControl.Width;
    Height := FContainedControl.Height;
  end
  else
    Height := 0; // Make item invisible
end;

function TRibbonGalleryControlMenuItem.CanAddToQuickAccessToolbar: Boolean;
begin
  Result := False;
end;

function TRibbonGalleryControlMenuItem.GetContainedControl: TControl;
begin
  Result := FContainedControl;
end;

procedure TRibbonGalleryControlMenuItem.SetBounds(ALeft: Integer; ATop: Integer;
  AWidth: Integer; AHeight: Integer);
begin
  if FContainedControl <> nil then
  begin
    inherited SetBounds(ALeft, ATop, FContainedControl.Width, FContainedControl.Height);
    FContainedControl.SetBounds(ALeft, ATop, FContainedControl.Width, FContainedControl.Height);
  end
  else
    inherited;
end;

procedure TRibbonGalleryControlMenuItem.SetContainedControl(const Value: TControl);
begin
  FContainedControl := Value;
  if FContainedControl <> nil then
    FContainedControl.Parent := Parent;
  CalcBounds;
end;

{ TRibbonMenuItem }

procedure TRibbonMenuItem.CalcBounds;
var
  LHeight: Integer;
  LTop: Integer;
begin
  inherited;
  if Separator then
    Height := 3
  else
    Height := 22;
  // Recalculate the TextBounds
  LHeight := TextBounds.Bottom - TextBounds.Top;
  if LHeight > 0 then
  begin
    LTop := (Height div 2) - (LHeight div 2);
    TextBounds := Rect(TextBounds.Left, LTop, TextBounds.Right, LTop + LHeight);
  end;
end;

procedure TRibbonMenuItem.CalcLayout;
begin
  inherited;
  GlyphPos := Point(GlyphPos.X + 2, GlyphPos.Y + 2);
end;

procedure TRibbonMenuItem.Click;
begin
  inherited;
  if GetParentForm(Self) is TRibbonGroupDockForm then
    SetFocus(Application.MainForm.Handle);
end;

constructor TRibbonMenuItem.Create(AOwner: TComponent);
begin
  inherited;
  FDrawBanner := True;
end;

procedure TRibbonMenuItem.DrawBackground(var PaintRect: TRect);
var
  LRect: TRect;
  BannerRect: TRect;
  BGRect: TRect;
begin
  if (ActionClient = nil) then
    Exit;

  LRect := PaintRect;

  if ActionClient.Color <> clDefault then
    Canvas.Brush.Color := ActionClient.Color;

  if (not (Self is TRibbonRichContentItem)) and FDrawBanner then
  begin
    BGRect := PaintRect;
    if TextBounds.Left > GlyphPos.X then
      BGRect.Left := 0;
    BannerRect := PaintRect;
    if TextBounds.Left > GlyphPos.X then
      BannerRect.Right := TextBounds.Left - 3
    else
      BannerRect.Right := TextBounds.Right + 3;
    BannerRect.Right := 25;
    BGRect.Left := BannerRect.Right - BannerRect.Left;
    RibbonStyle.DrawElement(smBanner, Canvas, BannerRect);
  end;

  Canvas.Brush.Color := Menu.ColorMap.MenuColor;

  if (Selected and Enabled) or (Selected and not MouseSelected) then
  begin
    if Enabled and not ActionBar.DesignMode then
      if not Separator or (Separator and ActionBar.DesignMode) then
        Canvas.Brush.Color := Menu.ColorMap.SelectedColor;
    Dec(PaintRect.Right, 1);
  end;

  if (not ActionBar.DesignMode and Separator) then
    Exit;

  if not ActionBar.DesignMode and not Mouse.IsDragging and
    ((Selected and Enabled) or (Selected and not MouseSelected)) then
  begin
    DrawSelectedBackground(PaintRect);
  end;

  if IsChecked then
  begin
    if Enabled then
    begin
      RibbonStyle.DrawElement(smCheck, Canvas, PaintRect);
      RibbonStyle.DrawElement(smCheckIcon, Canvas, PaintRect);
    end
    else
    begin
      RibbonStyle.DrawElement(smCheckDisabled, Canvas, PaintRect);
      RibbonStyle.DrawElement(smCheckDisabledIcon, Canvas, PaintRect);
    end;
  end;
end;

procedure TRibbonMenuItem.DrawGlyph(const Location: TPoint);
var
  ImageList: TCustomImageList;
  DrawEnabled: Boolean;
  LDisabled: Boolean;
begin
  if (Assigned(ActionClient) and not ActionClient.HasGlyph) and IsChecked then
  begin
    if Enabled then
    begin
      RibbonStyle.DrawElement(smCheck, Canvas, ClientRect);
      RibbonStyle.DrawElement(smCheckIcon, Canvas, ClientRect);
    end
    else
    begin
      RibbonStyle.DrawElement(smCheckDisabled, Canvas, ClientRect);
      RibbonStyle.DrawElement(smCheckDisabledIcon, Canvas, ClientRect);
    end;
  end
  else
  begin
    if not HasGlyph then
      Exit;
    ImageList := FindImageList(False, LDisabled, ActionClient.ImageIndex);
    if not Assigned(ImageList) then
      Exit;
    if IsChecked then
    begin
      if Enabled then
        RibbonStyle.DrawElement(smCheck, Canvas, ClientRect)
      else
        RibbonStyle.DrawElement(smCheckDisabled, Canvas, ClientRect);
    end;
    DrawEnabled := (Enabled or LDisabled) and (ActionClient.ImageIndex <> -1) or
      (csDesigning in ComponentState);
    ImageList.Draw(Canvas, Location.X, Location.Y, ActionClient.ImageIndex,
      dsTransparent, itImage, DrawEnabled);
  end;
end;

procedure TRibbonMenuItem.DrawSelectedBackground(ARect: TRect);
begin
  if Enabled then
    RibbonStyle.DrawElement(smHover, Canvas, ARect)
  else
    RibbonStyle.DrawElement(smDisabled, Canvas, ARect);
end;

procedure TRibbonMenuItem.DrawSeparator(const Offset: Integer);
var
  PaintRect: TRect;
  PR: TPenRecall;
  BR: TBrushRecall;
begin
  BR := TBrushRecall.Create(Canvas.Brush);
  PR := TPenRecall.Create(Canvas.Pen);
  try
    if Assigned(ActionClient) and ActionClient.Unused and not Transparent then
      Canvas.Brush.Style := bsSolid
    else
    begin
      Canvas.Brush.Color := Menu.ColorMap.Color;
      PaintRect := BoundsRect;
      Winapi.Windows.DrawEdge(Canvas.Handle, PaintRect, BDR_RAISEDINNER, BF_LEFT);
      Winapi.Windows.DrawEdge(Canvas.Handle, PaintRect, BDR_RAISEDINNER, BF_RIGHT);
    end;
    Canvas.Pen.Color := Menu.ColorMap.DisabledFontColor;
    Canvas.MoveTo(32, ClientHeight div 2);
    Canvas.LineTo(ClientWidth, ClientHeight div 2);
  finally
    BR.Free;
    PR.Free;
  end;
end;

procedure TRibbonMenuItem.DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string; TextColor, ShadowColor: TColor);
begin
  if not (Self is TRibbonRichContentItem) then
    Rect.Left := Rect.Left + 4;
  Canvas.Font.Size := 8;//Screen.MenuFont.Size;
  inherited;
end;

procedure TRibbonMenuItem.DrawText(var ARect: TRect; var Flags: Cardinal; Text: string);
begin
  if not (Self is TRibbonRichContentItem) then
    ARect.Left := ARect.Left + 4;
  Canvas.Font.Size := 8;//Screen.MenuFont.Size;
  if Enabled then
    Canvas.Font.Color := Menu.ColorMap.FontColor
  else
    Canvas.Font.Color := Menu.ColorMap.DisabledFontColor;
  inherited;
end;

function TRibbonMenuItem.GetShowShortCut: Boolean;
begin
  Result := False;
end;

function TRibbonMenuItem.RibbonStyle: TRibbonStyleActionBars;
begin
  if (ActionBar.ActionManager <> nil) and
    (ActionBar.ActionManager.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(ActionBar.ActionManager.Style)
  else
    Result := RibbonLunaStyle;
end;

{ TRibbonDropDownButton }

procedure TRibbonDropDownButton.CalcBounds;
begin
  inherited;
  if (ActionClient <> nil) and (GetButtonProps <> nil) and
    (GetButtonProps.ButtonSize = bsLarge) then
  begin
    Height := 66;
    // the width of the button needs to be at least 42
    Width := Max(42, TextBounds.Right - TextBounds.Left + 10);
    // glyph must be centered
    GlyphPos := Point(Width div 2 - 16, 3);
  end
  else
    Width := Width + 1;
end;

procedure TRibbonDropDownButton.CalcLayout;
var
  LRect: TRect;
  LCaption: string;
  LProps: TButtonProperties;
begin
  IsButton(LProps);
  if (LProps <> nil) and (LProps.ButtonSize = bsLarge) then
  begin
    if Canvas.HandleAllocated then
    begin
      LRect := Rect(0, 0, 32, 0);
      if ActionClient <> nil then
        LCaption := StripHotKey(ActionClient.Caption)
      else
        LCaption := StripHotKey(Caption);
      Winapi.Windows.DrawText(Canvas.Handle, LCaption, -1, LRect, DT_CALCRECT or DT_WORDBREAK);
      TextBounds := Rect(5, 38, Max(LRect.Right - LRect.Left + 5, 37), 38 + LRect.Bottom);
    end;
  end
  else
    inherited;
end;

procedure TRibbonDropDownButton.Click;
begin
  DoDropDown(False);
end;

procedure TRibbonDropDownButton.DoDropDown(const SelectFirst: Boolean);
var
  Pt: TPoint;
  PopupMenu: TCustomActionPopupMenu;
begin
  if Assigned(ActionClient) and (ActionClient.Items.Count > 0) then
  begin
    PopupMenu := GetPopupClass.Create(Owner);
    try
      PopupMenu.ColorMap := ActionBar.ColorMap;
      PopupMenu.ContextBar := False;
      PopupMenu.Parent := Parent;
      PopupMenu.ParentControl := Self;
      PopupMenu.ActionClient := ActionClient;
      case Actionbar.Orientation of
        boBottomToTop: Pt := Parent.ClientToScreen(Point(Self.Left,
          Self.Top - PopupMenu.Height));
        boTopToBottom: Pt := Parent.ClientToScreen(Point(Self.Left,
          Self.Top + Self.Height));
        boLeftToRight,
        boRightToLeft: Pt := Parent.ClientToScreen(Point(Self.Left, Self.Top + Self.Height));
      end;
      DrawDown := True;
      if (PopupMenu is TRibbonActionPopupMenu) then
        TRibbonActionPopupMenu(PopupMenu).SelectFirstItem := SelectFirst;
      PopupMenu.Popup(Pt.X, Pt.Y);
      DrawDown := False;
    finally
      if Parent.Parent <> nil then
        Parent.Parent.Repaint;
      PopupMenu.Free;
    end;
  end;
end;

procedure TRibbonDropDownButton.DrawArrow(Location: TPoint; Color, ShadowColor: TColor;
  Size: Integer);
begin
  if Enabled then
    RibbonStyle.DrawElement(sbArrow, Canvas, Rect(Location.X, Location.Y, 0, 0))
  else
    RibbonStyle.DrawElement(sbArrowDisabled, Canvas, Rect(Location.X, Location.Y, 0, 0))
end;

procedure TRibbonDropDownButton.DrawBackground(var PaintRect: TRect);
var
  LPt: TPoint;
begin
  inherited;
  LPt := GetArrowPosition(PaintRect);
  if not Enabled then
    DrawArrow(LPt, clNone, clNone, -1)
  else
    DrawArrow(LPt, clNone, clNone, -1);
end;

procedure TRibbonDropDownButton.DrawShadowedText(Rect: TRect; Flags: Cardinal;
  Text: string; TextColor, ShadowColor: TColor);
begin
  Flags := Flags or DT_WORDBREAK or DT_CENTER;
  inherited;
end;

procedure TRibbonDropDownButton.DrawText(var ARect: TRect; var Flags: Cardinal;
  Text: string);
begin
  Flags := Flags or DT_WORDBREAK or DT_CENTER;
  inherited;
end;

function TRibbonDropDownButton.GetArrowPosition(const ARect: TRect): TPoint;
var
  LX: Integer;
  LY: Integer;
  LProps: TButtonProperties;

  function IsMultiline: Boolean;
  begin
    Result := TextBounds.Bottom - TextBounds.Top > Canvas.TextHeight(Text);
  end;

begin
  if not IsButton(LProps) then
    Exit(Point(0, 0));
  if LProps.ButtonSize = bsSmall then
  begin
    LY := (Height div 2) - 2;
    if LProps.GroupPosition in [gpNone, gpSingle] then
      LX := Width - 10
    else
      LX := Width - 9;
  end
  else
  begin
    if not IsMultiline then
    begin
      LY := TextBounds.Bottom + (Canvas.TextHeight(Text) div 2);
      LX := (Width div 2) - 2;
    end
    else
    begin
      LY := TextBounds.Bottom - Canvas.TextHeight(Text) + 7;
      LX := TextBounds.Right;
    end;
  end;
  Result := Point(LX, LY);
end;

function TRibbonDropDownButton.GetPopupClass: TCustomPopupClass;
begin
  Result := TRibbonActionPopupMenu;
end;

procedure TRibbonDropDownButton.KeyTipClick;
begin
  DoDropDown(True);
end;

{ TRibbonCustomControl }

constructor TRibbonCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FContainedControl := nil;
end;

destructor TRibbonCustomControl.Destroy;
begin
  FContainedControl := nil;
  HideKeyTip('');
  inherited Destroy;
end;

procedure TRibbonCustomControl.DrawBackground(var PaintRect: TRect);
begin
  // don't use inherited behaviour
end;

function TRibbonCustomControl.GetCaptionWidth: Integer;
begin
  if ActionClient.ShowCaption and (Trim(ActionClient.Caption) <> '') then
  begin
    Result := Canvas.TextWidth(ActionClient.Caption);
    if GetGlyphWidth = 0 then
      Inc(Result, 4);
  end
  else
    Result := 0;
end;

function TRibbonCustomControl.GetContainedControl: TControl;
begin
  Result := FContainedControl;
end;

function TRibbonCustomControl.GetGlyphWidth: Integer;
begin
  if HasGlyph then
    Result := GetImageSize.X + 6
  else
    Result := 0;
end;

function TRibbonCustomControl.GetKeyTip: string;
begin
  Result := ActionClient.KeyTip;
end;

function TRibbonCustomControl.GetLabelWidth: Integer;
var
  LProps: TControlProperties;
begin
  LProps := TControlProperties(ActionClient.CommandProperties);
  if LProps.LabelWidth < 0 then
    Result := 2 + GetGlyphWidth + GetCaptionWidth
  else
    Result := LProps.LabelWidth;
end;

procedure TRibbonCustomControl.HandleKeyTip(const KeyTip: string;
  var Handled: TKeyTipHandled);
begin
  TKeyTipValidator.Validate(KeyTip, GetKeyTip, Self, Handled);
end;

procedure TRibbonCustomControl.HideKeyTip(const Match: string);
begin
  if FKeyTip <> nil then
    FreeAndNil(FKeyTip);
end;

procedure TRibbonCustomControl.KeyTipClick;
begin
  if (ContainedControl <> nil) and (ContainedControl is TWinControl) then
    Winapi.Windows.SetFocus(TWinControl(ContainedControl).Handle);
end;

procedure TRibbonCustomControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FContainedControl then
    begin
      FContainedControl := nil;
      if not (csDestroying in ComponentState) then
        ActionClient.CommandStyle := csButton;
    end;
  end;
end;

procedure TRibbonCustomControl.CalcBounds;
begin
  inherited CalcBounds;
  if ActionClient <> nil then
    ContainedControl := TControlProperties(ActionClient.CommandProperties).ContainedControl;
  if ContainedControl = nil then
    Width := 40
  else
  Width := TControlProperties(ActionClient.CommandProperties).Width;
  if ContainedControl <> nil then
    Height := Min(Max(Height, ContainedControl.Height), 66);
end;

function TRibbonCustomControl.CanAddToQuickAccessToolbar: Boolean;
var
  LIntf: IRibbonControl;
begin
  if Supports(ContainedControl, IRibbonControl, LIntf) then
    Result := LIntf.CanAddToQuickAccessToolbar
  else
    Result := False;
end;

procedure TRibbonCustomControl.Click;
begin
  if csDesigning in ComponentState then
    SetSelected(True);
  inherited Click;
end;

procedure TRibbonCustomControl.CMVisiblechanged(var Message: TMessage);
begin
  inherited;
  if ContainedControl <> nil then
    ContainedControl.Visible := Visible;
end;

procedure TRibbonCustomControl.Paint;
begin
  inherited Paint;
//  if Assigned(ContainedControl) and (ContainedControl is TWinControl) and
//    TWinControl(ContainedControl).HandleAllocated then
//    ContainedControl.Invalidate;
end;

procedure TRibbonCustomControl.SetActionClient(Value: TActionClientItem);
begin
  inherited SetActionClient(Value);
  if (FContainedControl <> nil) then
  begin
    if (Parent <> nil) then
      FContainedControl.Parent := Parent;
    if Assigned(Value) and (Value.Action <> ContainedControl.Action) then
      ContainedControl.Action := Value.Action;
  end;
end;

procedure TRibbonCustomControl.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
var
  LTop: Integer;
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if (ContainedControl <> nil) and (ContainedControl is TWinControl) and
    (ContainedControl.Parent <> nil) then
  begin
    LTop := Top + (Height div 2) - (ContainedControl.Height div 2);
    ContainedControl.SetBounds(ALeft + GetLabelWidth + 2, LTop,
      AWidth - GetLabelWidth - 2, ContainedControl.Height);
  end;
  CalcLayout;
end;

type
  TControlType = class(TControl);

procedure TRibbonCustomControl.SetContainedControl(const Value: TControl);
var
  I: Integer;
  LAC: TActionClientItem;
begin
  if Value <> nil then
  begin
    // need to remove any previous association for the control
    for I := 0 to ActionBar.ActionClient.Items.Count - 1 do
    begin
      LAC := ActionBar.ActionClient.Items[I];
      if (LAC <> Self.ActionClient) and (LAC.CommandStyle = csControl) then
      begin
        if TControlProperties(LAC.CommandProperties).ContainedControl = Value then
          TControlProperties(LAC.CommandProperties).ContainedControl := nil;
      end;
    end;
  end;
  FContainedControl := Value;
  if (FContainedControl <> nil) then
    FContainedControl.Parent := Parent;
  Margins := Rect(Margins.Left, 3, Margins.Right, 3);
end;

procedure TRibbonCustomControl.SetDragMode(Value: TDragMode);
{$IFDEF CLR}
var
  LIntf: IControl;
{$ENDIF}
begin
  inherited SetDragMode(Value);
  if ContainedControl <> nil then
  begin
    {$IFDEF CLR}
    if Supports(ContainedControl, IControl, LIntf) then
      LIntf.DragMode := Value;
    {$ELSE}
    TControlType(ContainedControl).DragMode := Value;
    {$ENDIF}
  end;
end;

procedure TRibbonCustomControl.SetKeyTip(const Value: string);
begin
  ActionClient.KeyTip := Value;
end;

procedure TRibbonCustomControl.SetParent(AParent: TWinControl);
begin
  if ContainedControl <> nil then
    ContainedControl.Parent := AParent;
  inherited SetParent(AParent);
end;

procedure TRibbonCustomControl.ShowKeyTip(const Position: TKeyTipPosition);
begin
  if FKeyTip <> nil then
    FKeyTip.Free;
  FKeyTip := Vcl.RibbonActnCtrls.ShowKeyTip(ActionClient.KeyTip, Enabled, Self, Position);
end;

{ TCustomRibbonStatusControl }

procedure TRibbonCustomStatusControl.CalcBounds;
begin
  inherited;
  // additional width to display separator
  Width := Width + 4;
end;

procedure TRibbonCustomStatusControl.DrawBackground(var PaintRect: TRect);
var
  LDetail: TThemedElementDetails;
  LRect: TRect;
begin
  PaintRect.Top := PaintRect.Top + 3;
  PaintRect.Bottom := PaintRect.Bottom - 2;
  if ActionClient.Index < ActionBar.ActionClient.Items.Count - 1 then
  begin
    LDetail := ThemeServices.GetElementDetails(tsPane);
    LRect := PaintRect;
    LRect.Left := LRect.Right - 2;
    ThemeServices.DrawElement(Canvas.Handle, LDetail, LRect);
  end;
end;

{ TRibbonTextControl }

procedure TRibbonTextControl.CalcBounds;
var
  LWidth: Integer;
  LTextProps: TTextProperties;
begin
  inherited CalcBounds;
  LWidth := Width + 4;
  if (ActionClient.CommandStyle = csText) then
  begin
    LTextProps := TTextProperties(ActionClient.CommandProperties);
    if LTextProps.Width > -1 then
      Inc(LWidth, LTextProps.Width);
  end;
  Width := LWidth;
  Height := 22;                                         
end;

procedure TRibbonTextControl.DrawBackground(var PaintRect: TRect);
begin
  // Don't use inherited behaviour
end;

procedure TRibbonTextControl.DrawText(var ARect: TRect; var Flags: Cardinal;
  Text: string);
var
  LFlags: Cardinal;
  LTextProps: TTextProperties;
begin
  ARect.Right := Width - 4;
  if ActionClient.CommandStyle = csText then
  begin
    LTextProps := TTextProperties(ActionClient.CommandProperties);
    LFlags := DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;
    case LTextProps.Alignment of
      taLeftJustify: LFlags := LFlags or DT_LEFT;
      taRightJustify: LFlags := LFlags or DT_RIGHT;
      taCenter: LFlags := LFlags or DT_CENTER;
    end;
    case LTextProps.EllipsisPosition of
      epPathEllipsis: LFlags := LFlags or DT_PATH_ELLIPSIS;
      epEndEllipsis: LFlags := LFlags or DT_END_ELLIPSIS;
      epWordEllipsis: LFlags := LFlags or DT_WORD_ELLIPSIS;
    end;
    if not LTextProps.ParentFont then
      Canvas.Font.Assign(LTextProps.Font);
    inherited DrawText(ARect, LFlags, StripHotKey(Text));
  end
  else
    inherited;
end;

{ TRibbonApplicationMenuItem }

procedure TRibbonApplicationMenuItem.CalcBounds;
begin
  inherited;
  if (ActionClient <> nil) then
  begin
    if not ActionClient.Separator then
    begin
      Height := 44;
      TextBounds := Rect(TextBounds.Left + 16, TextBounds.Top, TextBounds.Right + 16,
        Height - TextBounds.Top);
    end
    else
      Height := 2;
  end;
  // Don't include the shortcut bounds in the width calculation
  if not GetShowShortCut then
    Width := Width - ShortCutBounds.Right;
end;

constructor TRibbonApplicationMenuItem.Create(AOwner: TComponent);
begin
  inherited;
  DrawBanner := False;
end;

procedure TRibbonApplicationMenuItem.DrawGlyph(const Location: TPoint);
var
  LNewLocation: TPoint;
  LImageList: TCustomImageList;
  LImageSize: Integer;
  LDisabled: Boolean;
  LDrawEnabled: Boolean;
begin
  if not HasGlyph then
    Exit;
  LImageList := FindImageList(True, LDisabled, ActionClient.ImageIndex);
  if LImageList = nil then
    Exit;
  LImageSize := LImageList.Width;
  LNewLocation := Location;
  LNewLocation.X := 4;
  LNewLocation.Y := (Height - LImageSize) div 2;
  LDrawEnabled := (Enabled or LDisabled) and (ActionClient.ImageIndex <> -1) or
    (csDesigning in ComponentState);
  LImageList.Draw(Canvas, LNewLocation.X, LNewLocation.Y, ActionClient.ImageIndex,
    dsTransparent, itImage, LDrawEnabled);
end;

procedure TRibbonApplicationMenuItem.DrawSelectedBackground(ARect: TRect);
begin
  if Enabled then
    RibbonStyle.DrawElement(samMenuHover, Canvas, ARect)
  else
    RibbonStyle.DrawElement(samMenuDisabled, Canvas, ARect)
end;

procedure TRibbonApplicationMenuItem.DrawSeparator(const Offset: Integer);
var
  PaintRect: TRect;
  PR: TPenRecall;
  BR: TBrushRecall;
begin
  BR := TBrushRecall.Create(Canvas.Brush);
  PR := TPenRecall.Create(Canvas.Pen);
  try
    if Assigned(ActionClient) and ActionClient.Unused and not Transparent then
      Canvas.Brush.Style := bsSolid
    else
    begin
      Canvas.Brush.Color := Menu.ColorMap.Color;
      PaintRect := BoundsRect;
      Winapi.Windows.DrawEdge(Canvas.Handle, PaintRect, BDR_RAISEDINNER, BF_LEFT);
      Winapi.Windows.DrawEdge(Canvas.Handle, PaintRect, BDR_RAISEDINNER, BF_RIGHT);
    end;
    Canvas.Pen.Color := Menu.ColorMap.DisabledFontColor;
    DrawLine(Canvas, Point(32, 0), Point(ClientWidth, 0));
  finally
    BR.Free;
    PR.Free;
  end;
end;

procedure TRibbonApplicationMenuItem.DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string; TextColor,
  ShadowColor: TColor);
begin
  Flags := Flags or DT_VCENTER or DT_SINGLELINE;
  inherited;
end;

procedure TRibbonApplicationMenuItem.DrawSubMenuGlyph;
const
  ArrowPos = 14;
  Element: array [Boolean, Boolean] of TSkinMenu =
    ((smArrowRightDisabledIcon, smArrowLeftDisabledIcon),
     (smArrowLeftIcon, smArrowRightIcon));
var
  LRect: TRect;
begin
  if not Assigned(ActionClient) or not ActionClient.HasItems or
     (ActionClient.Items.VisibleCount = 0) then
    Exit;
  if ActionBar.BiDiMode = bdLeftToRight then
    LRect := Rect(Width - ArrowPos, Height div 2 - 3, Width - ArrowPos + 4, Height)
  else
    LRect := Rect(ArrowPos - 4, Height div 2 - 3, ArrowPos, Height);
  LRect.Bottom := LRect.Top + 7;
  RibbonStyle.DrawElement(Element[Enabled, ActionBar.BiDiMode = bdLeftToRight], Canvas, LRect);
end;

procedure TRibbonApplicationMenuItem.DrawText(var ARect: TRect; var Flags: Cardinal; Text: string);
begin
  Flags := Flags or DT_VCENTER or DT_SINGLELINE;
  inherited;
end;

function TRibbonApplicationMenuItem.GetImageSize: TPoint;
begin
  Result := Point(32, 32);
end;

{ TRibbonApplicationMenuButton }

procedure TRibbonApplicationMenuButton.CalcBounds;
begin
  Height := 44;
  Width := 44;
end;

function TRibbonApplicationMenuButton.GetKeyTip: string;
begin
  Result := ActionClient.KeyTip;
end;

procedure TRibbonApplicationMenuButton.HandleKeyTip(const KeyTip: string; var Handled: TKeyTipHandled);
begin
  TKeyTipValidator.Validate(KeyTip, GetKeyTip, Self, Handled);
end;

procedure TRibbonApplicationMenuButton.HideKeyTip(const Match: string);
begin
  // Only want to hide the KeyTip if it isn't a partial match
  if (Length(KeyTip) > 0) and (KeyTip[1] <> Match) then
  begin
    if FKeyTipForm <> nil then
      FreeAndNil(FKeyTipForm);
  end;
end;

procedure TRibbonApplicationMenuButton.SetKeyTip(const Value: string);
begin
  ActionClient.KeyTip := Value;
end;

procedure TRibbonApplicationMenuButton.ShowKeyTip(const Position: TKeyTipPosition);
begin
  if FKeyTipForm <> nil then
    ShowWindow(FKeyTipForm.Handle, SW_SHOW)
  else
    FKeyTipForm := Vcl.RibbonActnCtrls.ShowKeyTip(ActionClient.KeyTip, Enabled, Self, Position);
end;

procedure TRibbonApplicationMenuButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  MouseInControl := True;
  if not (csDesigning in ComponentState) then
    FadeManager.AddControl(Self);
end;

procedure TRibbonApplicationMenuButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if not Menu.InMenuLoop then
    MouseInControl := False
  else
    FMouseInControl := False;
  if not (csDesigning in ComponentState) then
    FadeManager.RemoveControl(Self);
end;

constructor TRibbonApplicationMenuButton.Create(AOwner: TComponent);
begin
  inherited;
  FDirection := ord(fdNone);
  FValue := 0;
  FKeyTipForm := nil;
end;

procedure TRibbonApplicationMenuButton.UMFadeControl(var Message: TMessage);
begin
  FDirection := Message.WParam;
  FValue := Byte(Message.LParam * 17);
  Invalidate;
end;

destructor TRibbonApplicationMenuButton.Destroy;
begin
  HideKeyTip('');
  inherited;
end;

procedure TRibbonApplicationMenuButton.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  inherited;
  // If the control is on a RibbonApplicationMenuBar, don't allow dropping of
  // the control. If the submenu is not currently visible, make it visible by
  // calling the Click method
  if ActionBar is TRibbonApplicationMenuBar then
  begin
    Accept := False;
    if not TRibbonApplicationMenuBar(ActionBar).InMenuLoop then
      Click;
  end;
end;

{ TKeyTipList }

procedure TKeyTipList.Add(MatchType: TKeyTipMatchType; 
  Handled: TKeyTipHandled; Control: TControl; Index: Integer);
begin
  FList.Add(TKeyTipMatchItem.Create(MatchType, Handled, Control, Index));
end;

procedure TKeyTipList.Clear;
begin
  FList.Clear;
end;

constructor TKeyTipList.Create;
begin
  inherited Create;
  FList := TObjectList.Create;
end;

destructor TKeyTipList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;


function TKeyTipList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TKeyTipList.GetFull: Boolean;
begin
  Result := (FList.Count = 1) and (Items[0].Handled = ktFull);
end;

function TKeyTipList.GetItem(Index: Integer): TKeyTipMatchItem;
begin
  if (Index > -1) and (FList.Count > Index) then
    Result := TKeyTipMatchItem(FList[Index])
  else
    Result := nil;
end;

function TKeyTipList.GetPartial: Boolean;
begin
  Result := (FList.Count > 1) or
    ((FList.Count = 1) and (Items[0].Handled = ktPartial));
end;

{ TKeyTipListEnumerator }

constructor TKeyTipListEnumerator.Create(AList: TKeyTipList);
begin
  inherited Create;
  FIndex := -1;
  FList := AList;
end;

function TKeyTipListEnumerator.GetCurrent: TKeyTipMatchItem;
begin
  Result := FList[FIndex];
end;

function TKeyTipListEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FList.Count - 1;
  if Result then
    Inc(FIndex);
end;

{ TRibbonRecentButtonControl }

constructor TRibbonMenuSmallButtonControl.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csDesignInteractive];
end;

procedure TRibbonMenuSmallButtonControl.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if not ActionBar.DesignMode then
  begin
    (Parent.Owner as TCustomActionMenuBar).CloseMenu;
    inherited;
  end;
end;

{ TRibbonRecentButtonControl }

function TRibbonRecentButtonControl.AllowHotKeys: Boolean;
begin
  Result := True;
end;

{ TRibbonOptionButtonControl }

procedure TRibbonOptionButtonControl.DrawBackground(var PaintRect: TRect);
begin
  if MouseInControl and not ActionBar.DesignMode then
    RibbonStyle.DrawElement(smOptionButtonHover, Canvas, PaintRect)
  else
    RibbonStyle.DrawElement(smOptionButton, Canvas, PaintRect);
end;

{ TRibbonStyleMenuButton }

procedure TRibbonStyleMenuButton.DrawBackground(var PaintRect: TRect);
begin
  if Selected {or Menu.InMenuLoop} and not ActionBar.DesignMode then
    RibbonStyle.DrawElement(smSelected, Canvas, PaintRect)
  else if MouseInControl and not ActionBar.DesignMode then
    RibbonStyle.DrawElement(smHover, Canvas, PaintRect)
  else
    RibbonStyle.DrawElement(smNormal, Canvas, PaintRect);
end;

{ TRibbonGroupDropDown }

procedure TRibbonGroupDropDown.CloseUp;
begin
  FGroup.Align := alNone;
  FGroup.Left := -MAXINT;
  FFloating := nil;
  Invalidate;
end;

procedure TRibbonGroupDropDown.DoDropDown(const SelectFirst: Boolean);
var
  LPt: TPoint;
  LRect: TRect;
begin
  if (FGroup <> nil) and (FFloating = nil) then
  begin
    LPt := ClientToScreen(Point(0, Height));
    LRect := Rect(LPt.X, LPt.Y, LPt.X + FGroup.Width, LPt.Y + 86);
    FFloating := TRibbonGroupDockForm.Create(Self);
    TRibbonGroupDockForm(FFloating).ParentControl := FGroup.Parent;
    TRibbonGroupDockForm(FFloating).Control := Self;
    SetWindowPos(FFloating.Handle, HWND_TOP, LPt.X, LPt.Y, FGroup.Width + 2,
      FGroup.Height + 2, SWP_NOACTIVATE or SWP_SHOWWINDOW);
    FGroup.Parent := FFloating;
    FGroup.Align := alClient;
    FFloating.Visible := True;
    FFloating.SetFocus;
    Invalidate;
  end;
end;

procedure TRibbonGroupDropDown.DrawArrow(Location: TPoint; Color,
  ShadowColor: TColor; Size: Integer);
begin
  // Do not draw an arrow for this class
end;

procedure TRibbonGroupDropDown.DrawBackground(var PaintRect: TRect);
begin
  if DrawDown or (MouseInControl and IsLeftMouseButtonPressed(Self)) then
    RibbonStyle.DrawElement(sqGroupPressed, Canvas, PaintRect)
  else if MouseInControl then
    RibbonStyle.DrawElement(sqGroupHover, Canvas, PaintRect)
  else
    RibbonStyle.DrawElement(sqGroup, Canvas, PaintRect);
end;

function TRibbonGroupDropDown.GetParentControl: TWinControl;
begin
  Result := FParentControl;
end;

function TRibbonGroupDropDown.GetTopPosition: Integer;
begin
  Result := -MAXINT;
end;

procedure TRibbonGroupDropDown.SetGroup(const Value: TControl);
begin
  FGroup := Value;
  if Value <> nil then
    FParentControl := FGroup.Parent;
end;

{ TRibbonMainMenuItem }

procedure TRibbonMainMenuItem.DrawShadowedText(Rect: TRect; Flags: Cardinal;
  Text: string; TextColor, ShadowColor: TColor);
begin
  Canvas.Font.Style := [fsBold];
  inherited;
end;

procedure TRibbonMainMenuItem.DrawText(var ARect: TRect; var Flags: Cardinal;
  Text: string);
begin
  Canvas.Font.Style := [fsBold];
  inherited;
end;

{ TRibbonAddRemoveItem }

procedure TRibbonAddRemoveItem.DrawBackground(var PaintRect: TRect);
begin
//  inherited;
end;

procedure TRibbonAddRemoveItem.DrawGlyph(const Location: TPoint);
begin
//  inherited;
end;

{ TRibbonComboBoxItem }

procedure TRibbonComboBoxItem.CalcBounds;
begin
  inherited;
  Height := 17;
  TextBounds := ClientRect;
end;

procedure TRibbonComboBoxItem.DrawBackground(var PaintRect: TRect);
begin
  Canvas.Brush.Color := clWindow;
  Canvas.FillRect(PaintRect);
  if not ActionBar.DesignMode and not Mouse.IsDragging and
    ((Selected and Enabled) or (Selected and not MouseSelected)) then
  begin
    DrawSelectedBackground(PaintRect);
  end;
end;

procedure TRibbonComboBoxItem.DrawText(var ARect: TRect; var Flags: Cardinal;
  Text: string);
begin
  Flags := Flags or DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX;
  inherited;
end;

{ TRibbonApplicationMenuButton }

procedure TRibbonApplicationMenuButton.KeyTipClick;
begin
  Click;
end;

              
procedure TRibbonApplicationMenuButton.Paint;
var
  LIcon: TBitmap;
  LOffset: Integer;
  LIconSize: TIconSize;
  LIconSizeInPixels: Integer;

  procedure DrawBlended;
  begin
    case FDirection of
      0:
        begin
          RibbonStyle.DrawElement(samButton, Canvas, 4, 4, 255);
          RibbonStyle.DrawElement(samButtonHover, Canvas, 4, 4, FValue);
        end;
      1:
        begin
          RibbonStyle.DrawElement(samButton, Canvas, 4, 4, 255);
          RibbonStyle.DrawElement(samButtonHover, Canvas, 4, 4, FValue);
        end;
    else
      if MouseInControl and not ActionBar.DesignMode then
        RibbonStyle.DrawElement(samButtonHover, Canvas, 4, 4, 255)
      else
        RibbonStyle.DrawElement(samButton, Canvas, 4, 4, 255)
    end;
  end;

begin
  RibbonStyle.DrawElement(samButtonShadow, Canvas, Rect(4,4,4+38,4+38));
  if not ActionBar.DesignMode and Enabled and
    FMouseInControl or Menu.InMenuLoop then
  begin
    if Menu.InMenuLoop then
      RibbonStyle.DrawElement(samButtonPressed, Canvas, 4, 4, 255)
    else
      DrawBlended;
  end
  else
  begin
    if ActionBar.DesignMode then
      FDirection := 2;
    DrawBlended;
  end;

  if FRibbon <> nil then
  begin
    LIcon := TBitmap.Create;
    try
      LIcon.Assign(TCustomRibbon(FRibbon).GetIcon(LIconSize));
      // Default to TIconSize = isMedium
      LOffSet := 4+4;
      LIconSizeInPixels := 24;
      case LIconSize of
        isSmall:
          begin
            LOffset := 8+4;
            LIconSizeInPixels := 16;
          end;
        isLarge:
          begin
            LOffSet := 0+4;
            LIconSizeInPixels := 32;
          end;
      end;
      canvas.StretchDraw(rect(2 + LOffSet, 3 + LOffSet,
        2 + LOffSet+ LIconSizeInPixels, 3 + LOffset + LIconSizeInPixels), LIcon);
    finally
      LIcon.Free;
    end;
  end;
end;

procedure TRibbonApplicationMenuButton.SetMouseInControl(const Value: Boolean);
begin
  if FMouseInControl <> Value then
    FMouseInControl := Value;
end;

procedure TRibbonApplicationMenuButton.SetParent(AParent: TWinControl);
begin
  inherited;
  if AParent is TRibbonApplicationMenuBar then
    FRibbon := TRibbonApplicationMenuBar(AParent).GetRibbon
  else
    FRibbon := nil;
end;

function TRibbonApplicationMenuButton.RibbonStyle: TRibbonStyleActionBars;
begin
  if (ActionBar.ActionManager <> nil) and
    (ActionBar.ActionManager.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(ActionBar.ActionManager.Style)
  else
    Result := RibbonLunaStyle;
end;

procedure TRibbonApplicationMenuButton.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  LForm: TCustomForm;
begin
  LForm := GetParentForm(Self);
  if LForm <> nil then
    LForm.Close
  else
    inherited;
end;

function TRibbonStyleMenuButton.RibbonStyle: TRibbonStyleActionBars;
begin
  if (ActionBar.ActionManager <> nil) and
    (ActionBar.ActionManager.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(ActionBar.ActionManager.Style)
  else
    Result := RibbonLunaStyle;
end;

{ TRibbonSmallSplitButton }

procedure TRibbonSmallSplitButton.CalcBounds;
begin
  inherited;
  Width := Width + 3;
  UpdateSplitBounds;
end;

procedure TRibbonSmallSplitButton.CalcLayout;
begin
  inherited;
  GlyphPos := Point(GlyphPos.X - 1, GlyphPos.Y);
  UpdateSplitBounds;
end;

procedure TRibbonSmallSplitButton.Click;
begin
  if CursorInSplit then
    DoDropDown(False)
  else
  begin
    SetSelected(True);
    if Assigned(ActionClient) and Assigned(ActionClient.ActionLink) then
    begin
      if not ActionBar.DesignMode then
        ResetUsageData;
      Repaint;
      if not ActionBar.DesignMode then
        ActionClient.ActionLink.Execute(Self);
    end;
    SetFocus(Application.MainForm.Handle);
  end;
end;

procedure TRibbonSmallSplitButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  CursorInSplit := False;
end;

constructor TRibbonSmallSplitButton.Create(AOwner: TComponent);
begin
  inherited;
  FSplitRect := Rect(0, 0, 0, 0);
  FCursorInSplit := False;
end;

procedure TRibbonSmallSplitButton.DrawBackground(var PaintRect: TRect);
var
  LRect: TRect;
  LSplitRect: TRect;
  LPt: TPoint;
  LArrowRect: TRect;
  LGroupPosition: TButtonProperties.TGroupPosition;
begin
  if not DrawDown and not MouseInControl or ActionBar.DesignMode then
    inherited
  else if not ActionBar.DesignMode then
  begin
    LSplitRect := FSplitRect;
    Inc(LSplitRect.Left, 2);
    LRect := PaintRect;
    LRect.Right := FSplitRect.Left;
    Inc(LRect.Right, 2);
    LPt := GetArrowPosition(PaintRect);
    LArrowRect := Rect(LPt.X, LPt.Y, 0, 0);
    LGroupPosition := GetButtonProps.GroupPosition;
    if (IsLeftMouseButtonPressed(Self) and (FState = bsDown)) or DrawDown then
    begin
      if CursorInSplit or DrawDown then
      begin
        case LGroupPosition of
          gpNone:
            begin
              RibbonStyle.DrawElement(sbSmallSplitInactive, Canvas, LRect);
              RibbonStyle.DrawElement(sbSmallSplitPressedSplit, Canvas, LSplitRect);
            end;
          gpStart:
            begin
              RibbonStyle.DrawElement(sbGroupStartSplitInactive, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupStartSplitPressedSplit, Canvas, LSplitRect);
            end;
          gpMiddle:
            begin
              RibbonStyle.DrawElement(sbGroupMiddleSplitInactive, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupMiddleSplitPressedSplit, Canvas, LSplitRect);
            end;
          gpEnd:
            begin
              RibbonStyle.DrawElement(sbGroupEndSplitInactive, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupEndSplitPressedSplit, Canvas, LSplitRect);
            end;
          gpSingle:
            begin
              RibbonStyle.DrawElement(sbGroupSingleSplitInactive, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupSingleSplitPressedSplit, Canvas, LSplitRect);
            end;
        end;
        RibbonStyle.DrawElement(sbArrowPressed, Canvas, LArrowRect);
      end
      else
      begin
        case LGroupPosition of
          gpNone:
            begin
              RibbonStyle.DrawElement(sbSmallSplitPressed, Canvas, LRect);
              RibbonStyle.DrawElement(sbSmallSplitInactiveSplit, Canvas, LSplitRect);
            end;
          gpStart:
            begin
              RibbonStyle.DrawElement(sbGroupStartSplitPressed, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupStartSplitInactiveSplit, Canvas, LSplitRect);
            end;
          gpMiddle:
            begin
              RibbonStyle.DrawElement(sbGroupMiddleSplitPressed, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupMiddleSplitInactiveSplit, Canvas, LSplitRect);
            end;
          gpEnd:
            begin
              RibbonStyle.DrawElement(sbGroupEndSplitPressed, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupEndSplitInactiveSplit, Canvas, LSplitRect);
            end;
          gpSingle:
            begin
              RibbonStyle.DrawElement(sbGroupSingleSplitPressed, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupSingleSplitInactiveSplit, Canvas, LSplitRect);
            end;
        end;
        RibbonStyle.DrawElement(sbArrow, Canvas, LArrowRect);
      end;
    end
    else
    begin
      if CursorInSplit then
      begin
        // The main button is inactive
        // The split button is hover
        case LGroupPosition of
          gpNone:
            begin
              RibbonStyle.DrawElement(sbSmallInactive, Canvas, LRect);
              RibbonStyle.DrawElement(sbSmallSplitHoverSplit, Canvas, LSplitRect);
            end;
          gpStart:
            begin
              RibbonStyle.DrawElement(sbGroupStartSplitInactive, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupStartSplitHoverSplit, Canvas, LSplitRect);
            end;
          gpMiddle:
            begin
              RibbonStyle.DrawElement(sbGroupMiddleSplitInactive, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupMiddleSplitHoverSplit, Canvas, LSplitRect);
            end;
          gpEnd:
            begin
              RibbonStyle.DrawElement(sbGroupEndSplitInactive, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupEndSplitHoverSplit, Canvas, LSplitRect);
            end;
          gpSingle:
            begin
              RibbonStyle.DrawElement(sbGroupSingleSplitInactive, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupSingleSplitHoverSplit, Canvas, LSplitRect);
            end;
        end;
      end
      else
      begin
        // The main button is hover
        // The split button is inactive
        case LGroupPosition of
          gpNone:
            begin
              RibbonStyle.DrawElement(sbSmallSplitHover, Canvas, LRect);
              RibbonStyle.DrawElement(sbSmallSplitInactiveSplit, Canvas, LSplitRect);
            end;
          gpStart:
            begin
              RibbonStyle.DrawElement(sbGroupStartSplitHover, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupStartSplitInactiveSplit, Canvas, LSplitRect);
            end;
          gpMiddle:
            begin
              RibbonStyle.DrawElement(sbGroupMiddleSplitHover, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupMiddleSplitInactiveSplit, Canvas, LSplitRect);
            end;
          gpEnd:
            begin
              RibbonStyle.DrawElement(sbGroupEndSplitHover, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupEndSplitInactiveSplit, Canvas, LSplitRect);
            end;
          gpSingle:
            begin
              RibbonStyle.DrawElement(sbGroupSingleSplitHover, Canvas, LRect);
              RibbonStyle.DrawElement(sbGroupSingleSplitInactiveSplit, Canvas, LSplitRect);
            end;
        end;
      end;
      RibbonStyle.DrawElement(sbArrow, Canvas, LArrowRect);
    end;
    RibbonStyle.DrawElement(sbSmallSplit, Canvas, FSplitRect);
  end;
end;

function TRibbonSmallSplitButton.GetArrowPosition(const ARect: TRect): TPoint;
var
  LProps: TButtonProperties;
begin
  IsButton(LProps);
  if LProps.ButtonSize = bsSmall then
  begin
    Result := inherited GetArrowPosition(ARect);
    if LProps.GroupPosition = gpEnd then
      Inc(Result.X, 1)
    else
      Inc(Result.X, 2);
  end
  else
    Result := inherited GetArrowPosition(ARect);
end;

function TRibbonSmallSplitButton.InSplit(X, Y: Integer): Boolean;
begin
  Result := FSplitRect.Contains(Point(X, Y));
end;

procedure TRibbonSmallSplitButton.KeyTipClick;
begin
  DoDropDown(True);
end;

procedure TRibbonSmallSplitButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CursorInSplit := InSplit(X, Y);
  inherited;
end;

procedure TRibbonSmallSplitButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  CursorInSplit := InSplit(X, Y);
end;

procedure TRibbonSmallSplitButton.SetCursorInSplit(const Value: Boolean);
begin
  if FCursorInSplit <> Value then
  begin
    FCursorInSplit := Value;
    Invalidate;
  end;
end;

procedure TRibbonSmallSplitButton.UpdateSplitBounds;
begin
  if ActionClient <> nil then
  begin
    if TButtonProperties(ActionClient.CommandProperties).TextAssociation = taImage then
      FSplitRect := Rect(ClientWidth - 12, 0, ClientWidth, Height)
    else
      FSplitRect := Rect(20, 0, ClientWidth, Height)
  end;
end;

const
  // the width of the gutter
  cBannerWidth = 25;
  // default width of the items with content
  // adjust as necessary
  cDefaultContentWidth = 122;

{ TRibbonRichContentItem }

procedure TRibbonRichContentItem.CalcBounds;
begin
  inherited;
  Height := GetItemHeight;
  Width := GetItemWidth;
  TextBounds := Rect(GetImageSize.X + 12, 5, Width - 5, Height - 10);
end;

function TRibbonRichContentItem.CanCalculateHeight: Boolean;
begin
  Result := GetMenuProps <> nil;
end;

constructor TRibbonRichContentItem.Create(AOwner: TComponent);
begin
  inherited;
  FCaptionHeight := -1;
  FCaptionText := '';
  FCaptionWidth := -1;
  FContentHeight := -1;
  FContentText := '';
  FBoundsCalculated := False;
  FShortCut := 0;
  FLeftMargin := cBannerWidth + 6;
end;

procedure TRibbonRichContentItem.DrawBackground(var PaintRect: TRect);
begin
  if not ActionBar.DesignMode and Selected then
  begin
    if Enabled then
      RibbonStyle.DrawElement(smRichContentHover, Canvas, PaintRect)
    else
      RibbonStyle.DrawElement(smRichContentDisabled, Canvas, PaintRect);
  end;
end;

// The DrawGlyph method only has a minor change in it from the code in the XPActnCtrls unit
// Instead of:
//        FrameRect := Rect(Location.X - 1, 1, Location.X + 20, Self.Height - 1);
// The code is:
//        FrameRect := Rect(Location.X - 1, 1, Location.X + 20, CaptionHeight - 1);
//
{$REGION 'DrawGlyph Method'}
procedure TRibbonRichContentItem.DrawGlyph(const Location: TPoint);
var
  NewLocation: TPoint;
begin
  if (ActionClient.Action is TCustomAction) and
     (TCustomAction(ActionClient.Action).Images <> nil) then
  begin
    if (Action is TCustomAction) and
       (TCustomAction(Action).Checked) then
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.Pen.Color := $003695F2;
      Canvas.Brush.Color := $0095E3FF;
      if TCustomAction(ActionClient.Action).Images.Width > 16 then
        Canvas.RoundRect(2, 2, 42, 42, 2, 2)
      else
        Canvas.RoundRect(2, 2, 26, 26, 2, 2);
    end;
    NewLocation := Location;
    if TCustomAction(ActionClient.Action).Images.Width > 16 then
    begin
      NewLocation.Y := NewLocation.Y + 5;
      NewLocation.X := NewLocation.X + 4;
    end;
  end;
  inherited DrawGlyph(NewLocation);
end;
{$ENDREGION}

procedure TRibbonRichContentItem.DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string; TextColor,
  ShadowColor: TColor);
begin
  // Call DrawText but make sure the font color is the disabled color
  Canvas.Font.Color := TextColor;
  DrawText(Rect, Flags, Text);
end;

procedure TRibbonRichContentItem.DrawText(var Rect: TRect; var Flags: Cardinal; Text: string);
var
  LRect: TRect;
  LFlags: Cardinal;
  LHasRichContent: Boolean;
begin
  if GetMenuProps = nil then
    Exit;
  if Enabled then
    Canvas.Font.Color := ActionBar.ColorMap.FontColor
  else
    Canvas.Font.Color := ActionBar.ColorMap.DisabledFontColor;
  Canvas.Font.Style := [fsBold];
  LHasRichContent := Trim(GetMenuProps.Content.Text) <> '';
  if LHasRichContent then
  begin
    LRect := System.Types.Rect(TextBounds.Left, TextBounds.Top, Width, TextBounds.Top + FCaptionHeight);
    LFlags := DT_LEFT;
  end
  else
  begin
    LRect := System.Types.Rect(TextBounds.Left, 0, Width, Height);
    LFlags := DT_LEFT or DT_VCENTER or DT_SINGLELINE;
  end;
  Winapi.Windows.DrawText(Canvas.Handle, ActionClient.Caption, -1, LRect, LFlags);
  if LHasRichContent then
  begin
    Canvas.Font := GetMenuProps.Font;
    if Enabled then
      Canvas.Font.Color := ActionBar.ColorMap.FontColor
    else
      Canvas.Font.Color := ActionBar.ColorMap.DisabledFontColor;
    LRect := System.Types.Rect(TextBounds.Left, TextBounds.Top + FCaptionHeight, Width - 5,
      TextBounds.Top + FCaptionHeight + FContentHeight);
    LFlags := DT_LEFT or DT_NOCLIP or DT_WORDBREAK;
    Winapi.Windows.DrawText(Canvas.Handle, GetMenuProps.Content.Text, -1, LRect, LFlags);
  end;
end;

function TRibbonRichContentItem.GetItemHeight: Integer;
var
  LCanvas: TCanvas;
begin
  Result := 0;
  if CanCalculateHeight then
  begin
    LCanvas := TCanvas.Create;
    try
      LCanvas.Handle := GetDC(0);
      LCanvas.Font := GetMenuProps.Font;
      FContentHeight := (LCanvas.TextHeight('Iy') * 2);
      inc(result, FContentHeight + 2);
      LCanvas.Font := GetMenuProps.Font;
      LCanvas.Font.Style := [fsBold];
      FCaptionHeight := LCanvas.TextHeight('Iy');
      inc(result, FCaptionHeight + 4);
      if (ActionClient <> nil) and
         (ActionClient.Action is TCustomAction) and
         (TCustomAction(ActionClient.Action).Images <> nil) then
        Result := Max(result, TCustomAction(ActionClient.Action).Images.Height + 8);
    finally
      LCanvas.Handle := 0;
      LCanvas.Free;
    end;
  end;
end;

function TRibbonRichContentItem.GetItemWidth: Integer;
var
  LCanvas: TCanvas;
  LRect: TRect;
  LFlags: Cardinal;
begin
  Result := 0;
  if CanCalculateHeight then
  begin
    LCanvas := TCanvas.Create;
    try
      LCanvas.Handle := GetDC(0);
      LCanvas.Font := GetMenuProps.Font;

      LRect := Rect(0, 0, 0, FContentHeight);
      LFlags := DT_LEFT or DT_NOPREFIX or DT_CALCRECT or DT_WORDBREAK;
      Winapi.Windows.DrawText(LCanvas.Handle, trim(GetMenuProps.Content.Text), -1, LRect, LFlags);

      Result := (LRect.Right - LRect.Left) + GetImageSize.X + 34;

      LCanvas.Font := GetMenuProps.Font;
      LCanvas.Font.Style := [fsBold];

      LRect := Rect(0, 0, 0, FCaptionHeight);
      LFlags := DT_LEFT or DT_CALCRECT;
      Winapi.Windows.DrawText(LCanvas.Handle, ActionClient.Caption, -1, LRect, LFlags);

      Result := Max(result, (LRect.Right - LRect.Left) + GetImageSize.X + 34);

    finally
      LCanvas.Handle := 0;
      LCanvas.Free;
    end;
  end;
end;

function TRibbonRichContentItem.GetMenuProps: TMenuProperties;
begin
  if (ActionClient <> nil) and (ActionClient.CommandStyle = csMenu) then
    Result := ActionClient.CommandProperties as TMenuProperties
  else
    Result := nil;
end;

{ TRibbonRichContentMainMenuItem }

procedure TRibbonRichContentMainMenuItem.CalcBounds;
begin
  inherited;
  if Parent is TRibbonStyleMainPopupMenu then
  begin
    Width := Parent.ClientWidth;
    Height := 52;
  end;
end;

procedure TRibbonRichContentMainMenuItem.CalcLayout;
begin
  inherited;
  TextBounds := Rect(GetImageSize.X + 4, TextBounds.Top, TextBounds.Right, TextBounds.Bottom);
end;

constructor TRibbonRichContentMainMenuItem.Create(AOwner: TComponent);
begin
  inherited;
  Font.Size := 8;//Screen.MenuFont.Size;
end;

procedure TRibbonRichContentMainMenuItem.DrawGlyph(const Location: TPoint);
var
  LNewLocation: TPoint;
  LImageList: TCustomImageList;
  LImageSize: Integer;
  LDisabled: Boolean;
  LDrawEnabled: Boolean;
begin
  LNewLocation := Location;
  LNewLocation.X := 4;
  LNewLocation.Y := Height div 2 - 16;
  if not HasGlyph then
    Exit;
  LImageList := FindImageList(True, LDisabled, ActionClient.ImageIndex);
  if LImageList = nil then
    Exit;
  // images for the menu must be 32
  LImageSize := Max(LImageList.Width, 32);
  LNewLocation.X := 4;
  LNewLocation.Y := (Height - LImageSize) div 2;
  LDrawEnabled := (Enabled or LDisabled) and (ActionClient.ImageIndex <> -1) or
    (csDesigning in ComponentState);
  LImageList.Draw(Canvas, LNewLocation.X, LNewLocation.Y, ActionClient.ImageIndex,
    dsTransparent, itImage, LDrawEnabled);
end;

procedure TRibbonRichContentMainMenuItem.DrawText(var ARect: TRect; var Flags: Cardinal; Text: string);
begin
  ARect := Rect(GetImageSize.X + 8, 4, ARect.Right, FCaptionHeight + 4);
  inherited;
end;

function TRibbonRichContentMainMenuItem.GetImageSize: TPoint;
begin
  Result := Point(32, 32);
end;

function TRibbonRichContentMainMenuItem.GetShowShortCut: Boolean;
begin
  Result := False;
end;

{ TRibbonSplitMenuItem }

procedure TRibbonSplitMenuItem.CalcBounds;
begin
  inherited;
  Width := Width + 25;
  UpdateSplitBounds;
end;

procedure TRibbonSplitMenuItem.Click;
var
  LPt: TPoint;
begin
  LPt := ScreenToClient(Mouse.CursorPos);
  if IsInSplit(LPt) then
    inherited
  else
    PostMessage(Menu.RootMenu.Handle, CM_SPLITITEMCLICKED, 0, Winapi.Windows.LPARAM(Self));
end;

constructor TRibbonSplitMenuItem.Create(AOwner: TComponent);
begin
  inherited;
  FMouseInSplit := False;
end;

procedure TRibbonSplitMenuItem.DrawBackground(var PaintRect: TRect);
begin
  inherited;
  if not ActionBar.DesignMode and Enabled and Selected then
  begin
    Canvas.Pen.Color := $0081C5DC;
    DrawLine(Canvas, Point(Width - 25, 2), Point(Width - 25, Height - 2));
    Canvas.Pen.Color := $00C9F4FF;
    DrawLine(Canvas, Point(Width - 26, 2), Point(Width - 26, Height - 2));
  end;
end;

procedure TRibbonSplitMenuItem.DrawSelectedBackground(ARect: TRect);
begin
  inherited;
  if MouseInSplit then
  begin
    ARect.Right := ARect.Right - (FSplitRect.Right - FSplitRect.Left);
    RibbonStyle.DrawElement(samMenuSplitHover, Canvas, ARect)
  end;
end;

function TRibbonSplitMenuItem.IsInSplit(const Pt: TPoint): Boolean;
begin
  Result := FSplitRect.Contains(Pt);
end;

procedure TRibbonSplitMenuItem.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  MouseInSplit := FSplitRect.Contains(Point(X, Y));
end;

procedure TRibbonSplitMenuItem.SetMouseInSplit(const Value: Boolean);
begin
  if FMouseInSplit <> Value then
  begin
    FMouseInSplit := Value;
    Invalidate;
  end;
end;

procedure TRibbonSplitMenuItem.UpdateSplitBounds;
begin
  FSplitRect := Rect(ClientWidth - 24, 0, ClientWidth, Height);
end;

{ TRibbonComboControl }

procedure TRibbonComboControl.CalcBounds;
var
  LComboProps: TComboBoxProperties;
begin
  inherited CalcBounds;
  if ActionClient <> nil then
  begin
    LComboProps := TComboBoxProperties(ActionClient.CommandProperties);
    ContainedControl := LComboProps.ContainedControl;
    Width := LComboProps.Width;
  end;
  Height := 22;
  if ActionBar.BiDiMode = bdLeftToRight then
    FBtnRect := Rect(Width - 14, 0, Width, Height)
  else
    FBtnRect := Rect(0, 0, 14, Height);
end;

function TRibbonComboControl.CanAddToQuickAccessToolbar: Boolean;
begin
  Result := False;
end;

procedure TRibbonComboControl.Click;
begin
  if csDesigning in ComponentState then
    SetSelected(True);
  DropDownClick(False);
end;

procedure TRibbonComboControl.CMBidimodechanged(var Message: TMessage);
begin
  CalcBounds;
  SetBounds(Left, Top, Width, Height);
end;

procedure TRibbonComboControl.CMMouseenter(var Message: TMessage);
begin
  inherited;
  MouseInControl := True;
end;

procedure TRibbonComboControl.CMMouseleave(var Message: TMessage);
begin
  inherited;
  MouseInControl := False;
end;

procedure TRibbonComboControl.CMVisiblechanged(var Message: TMessage);
begin
  inherited;
  if ComboBox <> nil then
    ComboBox.Visible := Visible;
end;

procedure TRibbonComboControl.ComboClick(Sender: TObject);
begin
  if Assigned(ActionBar) and not ActionBar.DesignMode then
    Click;
end;

type
  TCustomComboType = class(TEdit);

constructor TRibbonComboControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FComboBox := nil;
  FComboActions := TObjectList.Create(True);
end;

destructor TRibbonComboControl.Destroy;
begin
  FComboActions.Free;
  if FComboBox <> nil then
    FComboBox := nil;
  inherited;
end;

procedure TRibbonComboControl.DrawBackground(var PaintRect: TRect);
var
  LPt: TPoint;
  LMouseInBtn: Boolean;
  LPaintRect: TRect;
  LStyle: TRibbonStyleActionBars;
  LRect: TRect;
begin
  LStyle := RibbonStyle;
  Canvas.Brush.Style := bsSolid;
  if MouseInControl or ((FComboBox <> nil) and (FComboBox.MouseInControl or FComboBox.Focused)) then
    Canvas.Brush.Color := TCustomRibbonColorMap(ActionBar.ColorMap).ControlColor
  else
    Canvas.Brush.Color := TCustomRibbonColorMap(ActionBar.ColorMap).ControlInactiveColor;
  LRect := ClientRect;
  if ActionBar.BiDiMode = bdLeftToRight then
    Inc(LRect.Left, GetLabelWidth);
  Canvas.FillRect(LRect);
  if ActionBar.BiDiMode = bdLeftToRight then
    LPaintRect := Rect(Width - 14, 0, 0, 0)
  else
    LPaintRect := Rect(0, 0, 14, 0);
  if MouseInControl or ((FComboBox <> nil) and FComboBox.Focused) or (FPopupMenu <> nil) then
  begin
    LPt := ScreenToClient(Mouse.CursorPos);
    LMouseInBtn := FBtnRect.Contains(LPt);
    if LMouseInBtn or ((FComboBox <> nil) and FComboBox.Focused) or (FPopupMenu <> nil) then
    begin
      if (IsLeftMouseButtonPressed(Self) and (FState = bsDown)) and LMouseInBtn or (FPopupMenu <> nil) then
        LStyle.DrawElement(Vcl.RibbonStyleActnCtrls.scButtonPressed, Canvas, LPaintRect)
      else
        LStyle.DrawElement(scButtonHover, Canvas, LPaintRect);
    end
    else
      LStyle.DrawElement(scButton, Canvas, LPaintRect);
  end
  else
  begin
    if (FComboBox <> nil) and FComboBox.MouseInControl then
      LStyle.DrawElement(scButton, Canvas, LPaintRect)
    else
      LStyle.DrawElement(scButtonInactive, Canvas, LPaintRect);
  end;
  DrawFrame;
end;

procedure TRibbonComboControl.DrawFrame;
var
  LRect: TRect;
begin
  LRect := ClientRect;
  Inc(LRect.Left, GetLabelWidth);
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Color := TCustomRibbonColorMap(ActionBar.ColorMap).ControlFrameColor;
  Canvas.Rectangle(LRect);
end;

procedure TRibbonComboControl.DropDownClick(const SelectFirst: Boolean);
var
  LPt: TPoint;
begin
  if FComboBox = nil then
    Exit;
  if not ActionClient.HasItems then
    ShowComboItems(SelectFirst)
  else
  begin
    if FPopupMenu <> nil then
    begin
      // If the menu is currently visible, hide it
      FPopupMenu.CloseMenu;
      FreeAndNil(FPopupMenu);
      Invalidate;
      Exit;
    end;
    FPopupMenu := TRibbonStylePopupMenu.Create(nil) as TCustomActionPopupMenu;
    try
      FPopupMenu.ParentControl := Self;
      FPopupMenu.ActionClient := ActionClient;
      LPt := ClientToScreen(Point(Left, Height));
      FPopupMenu.ColorMap := ActionBar.ColorMap;
      TRibbonStylePopupMenu(FPopupMenu).GalleryResize :=
        TComboBoxProperties(ActionClient.CommandProperties).AllowResize;
      TRibbonStylePopupMenu(FPopupMenu).SelectFirstItem := SelectFirst;
      FPopupMenu.Width := FComboBox.Width;
      Invalidate;
      FPopupMenu.Popup(LPt.X - Left, LPt.Y);
    finally
      FreeAndNil(FPopupMenu);
      Invalidate;
  	end;
  end;
end;

function TRibbonComboControl.GetCaptionWidth: Integer;
begin
  if ActionClient.ShowCaption then
  begin
    if Trim(ActionClient.Caption) <> '' then
    begin
      Result := Canvas.TextWidth(ActionClient.Caption);
      if GetGlyphWidth = 0 then
        Inc(Result, 4);
    end
    else
      Result := 0;
  end
  else
    Result := 0;
end;

procedure TRibbonComboControl.GetComboItemsControlClassHandler(
  Sender: TCustomActionBar; AnItem: TActionClient;
  var ControlClass: TCustomActionControlClass);
begin
  ControlClass := TRibbonComboBoxItem;
end;

function TRibbonComboControl.GetContainedControl: TControl;
begin
  Result := FComboBox;
end;

function TRibbonComboControl.GetGlyphWidth: Integer;
begin
  if HasGlyph then
    Result := GetImageSize.X + 6
  else
    Result := 0;
end;

function TRibbonComboControl.GetKeyTip: string;
begin
  Result := ActionClient.KeyTip;
end;

function TRibbonComboControl.GetLabelWidth: Integer;
var
  LProps: TComboBoxProperties;
begin
  LProps := TComboBoxProperties(ActionClient.CommandProperties);
  if LProps.LabelWidth < 0 then
    Result := 2 + GetGlyphWidth + GetCaptionWidth
  else
    Result := LProps.LabelWidth;
end;

procedure TRibbonComboControl.HandleKeyTip(const KeyTip: string;
  var Handled: TKeyTipHandled);
begin
  TKeyTipValidator.Validate(KeyTip, GetKeyTip, Self, Handled);
end;

procedure TRibbonComboControl.HideKeyTip(const Match: string);
begin
  if FKeyTip <> nil then
    FreeAndNil(FKeyTip);
end;

procedure TRibbonComboControl.KeyTipClick;
begin
  if FComboBox <> nil then
    FComboBox.SetFocus;
end;

procedure TRibbonComboControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Invalidate;
end;

procedure TRibbonComboControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FComboBox then
    begin
      FComboBox := nil;
      if not (csDestroying in ComponentState) then
        ActionClient.CommandStyle := csButton;
    end;
  end;
end;

procedure TRibbonComboControl.Paint;
begin
  inherited;
  if (FComboBox <> nil) and FComboBox.HandleAllocated then
    ComboBox.Invalidate;
end;

procedure TRibbonComboControl.SelectItemHandler(Sender: TObject);
begin
  if FComboBox <> nil then
    FComboBox.Text := FComboBox.Items[TAction(Sender).Tag];
end;

procedure TRibbonComboControl.SetActionClient(Value: TActionClientItem);
begin
  inherited;
  if FComboBox <> nil then
    FComboBox.Color := TCustomRibbonColorMap(ActionBar.ColorMap).ControlInactiveColor;
end;

procedure TRibbonComboControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  LTop: Integer;
  LProps: TComboBoxProperties;
  LLabelWidth: Integer;
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if Assigned(FComboBox) then
  begin
    LProps := ActionClient.CommandProperties as TComboBoxProperties;
    if ActionClient <> nil then
      ComboBox.Text := LProps.Text;
    LTop := Top + (Height div 2) - (ComboBox.Height div 2);
    LLabelWidth := GetLabelWidth;
    if ActionBar.BiDiMode = bdLeftToRight then
      ComboBox.SetBounds(ALeft + LLabelWidth, LTop,
        Width - 16 - LLabelWidth, ComboBox.Height)
    else
    begin
      ComboBox.SetBounds(ALeft + 14, LTop,
        Width - 16 - LLabelWidth, ComboBox.Height)
    end;
  end;
  CalcLayout;
end;

procedure TRibbonComboControl.SetComboBox(const Value: TCustomRibbonComboBox);
begin
  if Value <> nil then
  begin
    if FComboBox <> nil then
      FComboBox.FComboControl := nil;
  end else
  begin
    if (FComboBox <> nil) then
    begin
      FComboBox.FComboControl := Self;
      {$IFNDEF CLR}
      if (csDesigning in ComponentState) then
        TControlType(FComboBox).OnResize := nil;
      {$ENDIF}
    end;
  end;
  FComboBox := Value;
  if (FComboBox <> nil) then
  begin
    FComboBox.FComboControl := Self;
    FComboBox.Parent := Parent;
  end;
end;

procedure TRibbonComboControl.SetContainedControl(const Value: TControl);
begin
  if FComboBox <> Value then
    SetComboBox(TCustomRibbonComboBox(Value));
end;

procedure TRibbonComboControl.SetDragMode(Value: TDragMode);
begin
  inherited SetDragMode(Value);
  if ComboBox <> nil then
    ComboBox.DragMode := Value;
end;

procedure TRibbonComboControl.SetKeyTip(const Value: string);
begin
  ActionClient.KeyTip := Value;
end;

procedure TRibbonComboControl.SetMouseInControl(const Value: Boolean);
begin
  FMouseInControl := Value;
  if FComboBox = nil then
    Exit;
  if not Value and not FComboBox.Focused then
    FComboBox.Color := TCustomRibbonColorMap(ActionBar.ColorMap).ControlInactiveColor
  else
    FComboBox.Color := TCustomRibbonColorMap(ActionBar.ColorMap).ControlColor;
  FComboBox.Invalidate;
  Invalidate;
end;

procedure TRibbonComboControl.SetParent(AParent: TWinControl);
begin
  if Assigned(ComboBox) then
    ComboBox.Parent := AParent;
  inherited SetParent(AParent);
end;

procedure TRibbonComboControl.ShowComboItems(const SelectFirst: Boolean);
var
  LAC: TActionClientItem;
  I: Integer;
  LItem: TActionClientItem;
  LPt: TPoint;
  LAction: TAction;
begin
  if FPopupMenu <> nil then
  begin
    // If the menu is currently visible, hide it
    FPopupMenu.CloseMenu;
    FreeAndNil(FPopupMenu);
    Invalidate;
    Exit;
  end;

  if FComboBox.Items.Count > 0 then
  begin
    LAC := TActionClientItem(ActionClient.Items.Add);
    LAC.Visible := False;
    LAC.ActionClients.AutoHotKeys := False;
    try
      FComboActions.Clear;
      try
        for I := 0 to FComboBox.Items.Count - 1 do
        begin
          LItem := LAC.Items.Add;
          LAction := TAction.Create(nil);
          LAction.Caption := FComboBox.Items[I];
          LAction.Tag := I;
          LAction.OnExecute := SelectItemHandler;
          LItem.Action := LAction;
          FComboActions.Add(LAction);
        end;
        FPopupMenu := TRibbonStylePopupMenu.Create(nil) as TCustomActionPopupMenu;
        try
          FPopupMenu.ParentControl := Self;
          FPopupMenu.OnGetControlClass := GetComboItemsControlClassHandler;
          FPopupMenu.ActionClient := LAC;
          LPt := ClientToScreen(Point(Left, Height));
          FPopupMenu.ColorMap := ActionBar.ColorMap;
          TRibbonStylePopupMenu(FPopupMenu).GalleryResize :=
            TComboBoxProperties(ActionClient.CommandProperties).AllowResize;
          TRibbonStylePopupMenu(FPopupMenu).SelectFirstItem := SelectFirst;
          Inc(LPt.X, Width - FPopupMenu.Width);
          Invalidate;
          FPopupMenu.Popup(LPt.X - Left, LPt.Y);
        finally
          FreeAndNil(FPopupMenu);
          Invalidate;
        end;
  	  finally
        FComboActions.Clear;
	  end;
    finally
      LAC.Free;
    end;
  end;
end;

procedure TRibbonComboControl.ShowKeyTip(const Position: TKeyTipPosition);
begin
  if FKeyTip <> nil then
    FKeyTip.Free;
  FKeyTip := Vcl.RibbonActnCtrls.ShowKeyTip(ActionClient.KeyTip, Enabled, Self, Position);
end;

function TRibbonComboControl.RibbonStyle: TRibbonStyleActionBars;
begin
  if (ActionBar.ActionManager <> nil) and
    (ActionBar.ActionManager.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(ActionBar.ActionManager.Style)
  else
    Result := RibbonLunaStyle;
end;

{ TCustomRibbonCombo }

procedure TCustomRibbonComboBox.BeginAutoDrag;
begin
  if FComboControl <> nil then
    FComboControl.BeginAutoDrag;
end;

procedure TCustomRibbonComboBox.CMMouseenter(var Message: TMessage);
begin
  inherited;
  MouseInControl := True;
end;

procedure TCustomRibbonComboBox.CMMouseleave(var Message: TMessage);
begin
  inherited;
  MouseInControl := False;
end;

constructor TCustomRibbonComboBox.Create(AOwner: TComponent);
begin
  inherited;
  AutoSelect := True;
  BorderStyle := bsNone;
  ParentColor := False;
  Height := 15;
  FItems := TStringList.Create;
end;

destructor TCustomRibbonComboBox.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TCustomRibbonComboBox.DragDrop(Source: TObject; X, Y: Integer);
begin
  {$IFNDEF CLR}
  FComboControl.DoDragDrop(Source, X, Y);
  {$ENDIF}
end;

procedure TCustomRibbonComboBox.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept := Assigned(FComboControl.ActionClient) and (Source is TActionDragObject) or
    (Source is TActionItemDragObject) or (Source is TCategoryDragObject);
end;

procedure TCustomRibbonComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_DOWN then
    FComboControl.DropDownClick(True);
end;

procedure TCustomRibbonComboBox.KeyPress(var Key: Char);
var
  LCloseCollapsedGroup: Boolean;
begin
  LCloseCollapsedGroup := Key = #13;
  inherited;
  if LCloseCollapsedGroup then
  begin
    if GetParentForm(Self) is TRibbonGroupDockForm then
      Winapi.Windows.SetFocus(Application.MainForm.Handle);
  end;
end;

procedure TCustomRibbonComboBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if FComboControl <> nil then
    Color := TCustomRibbonColorMap(FComboControl.ActionBar.ColorMap).ControlColor;
end;

procedure TCustomRibbonComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FComboControl then
    begin
      FComboControl := nil;
    end;
  end;
end;

procedure TCustomRibbonComboBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  LTop: Integer;
begin
  if FComboControl = nil then
    inherited
  else
  begin
    LTop := FComboControl.Top + (FComboControl.Height div 2) - (Height div 2);
    if FComboControl.ActionBar.BiDiMode = bdLeftToRight then
    begin
      inherited SetBounds(FComboControl.Left + 2 + FComboControl.GetLabelWidth,
        LTop, FComboControl.Width - 16 - FComboControl.GetLabelWidth, AHeight);
    end
    else
    begin
      inherited SetBounds(FComboControl.Left + 16, LTop,
        FComboControl.Width - 16 - FComboControl.GetLabelWidth, AHeight);
    end;
  end;
end;

procedure TCustomRibbonComboBox.SetItems(const Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TCustomRibbonComboBox.SetMouseInControl(const Value: Boolean);
begin
  if FMouseInControl <> Value then
  begin
    FMouseInControl := Value;
    if not Value and not Focused then
    begin
      if (FComboControl <> nil) and not FComboControl.MouseInControl then
        Color := TCustomRibbonColorMap(FComboControl.ActionBar.ColorMap).ControlInactiveColor
      else
        Color := TCustomRibbonColorMap(FComboControl.ActionBar.ColorMap).ControlColor;
    end
    else if FComboControl <> nil then
      Color := TCustomRibbonColorMap(FComboControl.ActionBar.ColorMap).ControlColor;
    Invalidate;
  end;
end;

procedure TCustomRibbonComboBox.SetParent(AParent: TWinControl);
begin
  inherited;
  if (AParent <> nil) then
  begin
    if not (AParent is TCustomRibbonGroup) then
      raise Exception.CreateFmt(SRibbonControlInvalidParent, [ClassName]);
  end;
end;

procedure TCustomRibbonComboBox.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if (FComboControl <> nil) and (FComboControl.ActionBar <> nil) then
  begin
    Color := TCustomRibbonColorMap(FComboControl.ActionBar.ColorMap).ControlInactiveColor;
    FComboControl.Invalidate;
  end;
end;

procedure TCustomRibbonComboBox.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if (FComboControl <> nil) and (FComboControl.ActionBar <> nil) then
  begin
    Color := TCustomRibbonColorMap(FComboControl.ActionBar.ColorMap).ControlColor;
    FComboControl.Invalidate;
  end;
end;

{ TRibbonCustomizeItem }

procedure TRibbonCustomizeItem.CalcBounds;
var
  R: TRect;
  LHeight: Integer;
  LTop: Integer;
begin
  inherited CalcBounds;
  Height := 22;
  Width := Width - 14;
  GlyphPos := Point(GlyphPos.X - 14, GlyphPos.Y);
  // Recalculate the TextBounds
  LHeight := TextBounds.Bottom - TextBounds.Top;
  if LHeight > 0 then
  begin
    LTop := (Height div 2) - (LHeight div 2);
    TextBounds := Rect(TextBounds.Left, LTop, TextBounds.Right, LTop + LHeight);
  end;
  R := TextBounds;
  OffsetRect(R, -14, 0);
  TextBounds := R;
end;

procedure TRibbonCustomizeItem.DrawBackground(var PaintRect: TRect);
var
  BannerRect: TRect;
  BGRect: TRect;
begin
  if (ActionClient = nil) then
    Exit;

  BGRect := PaintRect;
  if TextBounds.Left > GlyphPos.X then
    BGRect.Left := 0;
  BannerRect := PaintRect;
  if TextBounds.Left > GlyphPos.X then
    BannerRect.Right := TextBounds.Left - 3
  else
    BannerRect.Right := TextBounds.Right + 3;
  BannerRect.Right := 25;
  BGRect.Left := BannerRect.Right - BannerRect.Left;
  RibbonStyle.DrawElement(smBanner, Canvas, BannerRect);

  if not ActionBar.DesignMode and ((Selected and Enabled) or (Selected and not MouseSelected)) then
    Dec(PaintRect.Right, 1);

  if not ActionBar.DesignMode and Enabled and Selected then
  begin
    RibbonStyle.DrawElement(smHover, Canvas, PaintRect);
  end;

  if IsActionVisible then
  begin
    RibbonStyle.DrawElement(smCheck, Canvas, PaintRect);
    RibbonStyle.DrawElement(smCheckIcon, Canvas, PaintRect);
  end;
end;

procedure TRibbonCustomizeItem.DrawGlyph(const Location: TPoint);
begin
  // Customize Items don't have a Glyph
end;

function TRibbonCustomizeItem.RibbonStyle: TRibbonStyleActionBars;
begin
  if (ActionBar.ActionManager <> nil) and
    (ActionBar.ActionManager.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(ActionBar.ActionManager.Style)
  else
    Result := RibbonLunaStyle;
end;

{ TRibbonQATScrollButton }

procedure TRibbonQATScrollButton.CalcBounds;
var
  LActionBar: TCustomRibbonQuickAccessToolbar;
begin
  inherited;
  if ActionBar is TCustomRibbonQuickAccessToolbar then
  begin
    LActionBar := TCustomRibbonQuickAccessToolbar(ActionBar);
    Height := LActionBar.Height;
    if LActionBar.ShowBorder then
      Width := 16
    else
      Width := 26;
    FBtnRect := Rect(Width - 15, 0, Width, Height);
  end
  else
  begin
    Width := 16;
    FBtnRect := Rect(Width - 15, 0, Width, Height);
  end;
end;

procedure TRibbonQATScrollButton.Click;
begin
  if (ActionClient <> nil) and (ActionClient.Action <> nil) then
  begin
    ActionClient.Action.Tag := IntPtr(Self);
    ActionClient.Action.Execute;
  end
  else
    inherited;
end;

procedure TRibbonQATScrollButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TRibbonQATScrollButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  CursorInBtn := False;
end;

procedure TRibbonQATScrollButton.DrawArrows;
var
  LRect: TRect;
begin
  LRect := FPaintRect;
  if FScrollMode = qsCustomize then
    RibbonStyle.DrawElement(sqButtonCustomizeIcon, Canvas, LRect)
  else
    RibbonStyle.DrawElement(sqButtonMoreIcon, Canvas, LRect);
end;

procedure TRibbonQATScrollButton.DrawBackground(var PaintRect: TRect);
begin
  if (ActionBar is TCustomRibbonQuickAccessToolbar) then
  begin
    if not TCustomRibbonQuickAccessToolbar(ActionBar).ShowBorder then
    begin
      if ActionBar.BiDiMode = bdLeftToRight then
      begin
        RibbonStyle.DrawElement(sqEnd, Canvas, PaintRect);
        Inc(PaintRect.Left, 13);
      end
      else
      begin
        Inc(PaintRect.Left, 13);
        RibbonStyle.DrawElement(sqEndRTL, Canvas, PaintRect);
      end;
    end;
    if not ActionBar.DesignMode and Enabled then
    begin
      if CursorInBtn or DrawDown then
      begin
        if (IsLeftMouseButtonPressed(Self) and (FState = bsDown)) or DrawDown then
          RibbonStyle.DrawElement(sqButtonPressed, Canvas, PaintRect)
        else
          RibbonStyle.DrawElement(sqButtonHover, Canvas, PaintRect);
      end
    end;
    FPaintRect := PaintRect;
    DrawArrows;
  end
  else if (ActionBar is TCustomRibbonQuickAccessPopupToolbar) then
  begin
    if not ActionBar.DesignMode and Enabled then
    begin
      if CursorInBtn or DrawDown then
      begin
        if (IsLeftMouseButtonPressed(Self) and (FState = bsDown)) or DrawDown then
          RibbonStyle.DrawElement(sqButtonPressed, Canvas, PaintRect)
        else
          RibbonStyle.DrawElement(sqButtonHover, Canvas, PaintRect);
      end
    end;
    FPaintRect := PaintRect;
    DrawArrows;
  end
  else
    inherited;
end;

procedure TRibbonQATScrollButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  CursorInBtn := FBtnRect.Contains(Point(X, Y));
end;

procedure TRibbonQATScrollButton.SetCursorInBtn(const Value: Boolean);
begin
  if FCursorInBtn <> Value then
  begin
    FCursorInBtn := Value;
    Invalidate;
  end;
end;

procedure TRibbonQATScrollButton.SetDrawDown(const Value: Boolean);
begin
  if FDrawDown <> Value then
  begin
    FDrawDown := Value;
    Invalidate;
  end;
end;

procedure TRibbonQATScrollButton.SetScrollMode(const Value: TQATScrollMode);
begin
  if FScrollMode <> Value then
  begin
    FScrollMode := Value;
    Invalidate;
  end;
end;

function TRibbonQATScrollButton.RibbonStyle: TRibbonStyleActionBars;
begin
  if (ActionBar.ActionManager <> nil) and
    (ActionBar.ActionManager.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(ActionBar.ActionManager.Style)
  else
    Result := RibbonLunaStyle;
end;

{ TRibbonToolScrollButton }

procedure TRibbonToolScrollButton.DrawArrows;
begin
  // Arrows are drawn from the current skin
end;

procedure TRibbonToolScrollButton.DrawBackground(var PaintRect: TRect);
begin
  if not (Parent is TActionToolBar) then
  begin
    if not MouseInControl or ActionBar.DesignMode then
      RibbonStyle.DrawElement(smScrollButton, Canvas, PaintRect)
    else
      RibbonStyle.DrawElement(smScrollButtonHover, Canvas, PaintRect);
  end
  else
  begin
    if not ActionBar.DesignMode then
    begin
      if MouseInControl then
      begin
        if (IsLeftMouseButtonPressed(Self) and (FState = bsDown)) then
          RibbonStyle.DrawElement(sbSmallPressed, Canvas, PaintRect)
        else
          RibbonStyle.DrawElement(sbSmallHover, Canvas, PaintRect);
      end;
    end;
    RibbonStyle.DrawElement(smScrollButtonDownIcon, Canvas, PaintRect);
  end;
  if Direction = sdUp then
    RibbonStyle.DrawElement(smScrollButtonUpIcon, Canvas, PaintRect)
  else if Direction = sdDown then
    RibbonStyle.DrawElement(smScrollButtonDownIcon, Canvas, PaintRect);
end;

function TRibbonToolScrollButton.RibbonStyle: TRibbonStyleActionBars;
begin
  if (ActionBar.ActionManager <> nil) and
    (ActionBar.ActionManager.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(ActionBar.ActionManager.Style)
  else
    Result := RibbonLunaStyle;
end;

{ TRibbonGripItem }

procedure TRibbonGripItem.CalcBounds;
begin
  inherited;
  Height := 10;
end;

constructor TRibbonGripItem.Create(AOwner: TComponent);
begin
  inherited;
  Height := 10;
end;

procedure TRibbonGripItem.Paint;
var
  LRect: TRect;
begin
  LRect := ClientRect;
  RibbonStyle.DrawElement(smResize, Canvas, LRect);
  case FGalleryResize of
    grNone: ;
    grVertical:
      begin
        // vertical resize
        LRect.Left := ((LRect.Right - LRect.Left) div 2) - 7;
        LRect.Right := LRect.Left + 14;
        LRect.Top := LRect.Top + 3;
        LRect.Bottom := LRect.Top + 4;
        RibbonStyle.DrawElement(smResizeVertical, Canvas, LRect);
      end;
    grBoth:
      begin
        // resize both
        LRect.Left := ClientRect.Right - 9;
        LRect.Top := LRect.Top + 3;
        LRect.Right := LRect.Left + 6;
        LRect.Bottom := LRect.Top + 6;
        RibbonStyle.DrawElement(smResizeBoth, Canvas, LRect);
      end;
  end;
end;

function TRibbonGripItem.RibbonStyle: TRibbonStyleActionBars;
begin
  if (ActionBar.ActionManager <> nil) and
    (ActionBar.ActionManager.Style is TRibbonStyleActionBars) then
    Result := TRibbonStyleActionBars(ActionBar.ActionManager.Style)
  else
    Result := RibbonLunaStyle;
end;

{ TRibbonMenuSeparatorItem }

procedure TRibbonMenuSeparatorItem.CalcBounds;
begin
  inherited;
  Height := 3
end;

procedure TRibbonMenuSeparatorItem.DrawSeparator(const Offset: Integer);
var
  PaintRect: TRect;
  PR: TPenRecall;
  BR: TBrushRecall;
begin
  BR := TBrushRecall.Create(Canvas.Brush);
  PR := TPenRecall.Create(Canvas.Pen);
  try
    if Assigned(ActionClient) and ActionClient.Unused and not Transparent then
      Canvas.Brush.Style := bsSolid
    else
    begin
      Canvas.Brush.Color := Menu.ColorMap.Color;
      PaintRect := BoundsRect;
      Winapi.Windows.DrawEdge(Canvas.Handle, PaintRect, BDR_RAISEDINNER, BF_LEFT);
      Winapi.Windows.DrawEdge(Canvas.Handle, PaintRect, BDR_RAISEDINNER, BF_RIGHT);
    end;
    Canvas.Pen.Color := Menu.ColorMap.DisabledFontColor;
    Canvas.MoveTo(1, ClientHeight div 2);
    Canvas.LineTo(ClientWidth, ClientHeight div 2);
  finally
    BR.Free;
    PR.Free;
  end;
end;

{ TRibbonMainMenuSeparator }

procedure TRibbonMainMenuSeparator.CalcBounds;
begin
  inherited;
  if (Parent <> nil) and (Parent is TRibbonStyleMainPopupMenu) then
    Width := Parent.ClientWidth - 2;
//  Height := 22;
end;

{ TRibbonApplicationButton }

procedure TRibbonApplicationButton.CalcBounds;
begin
  inherited;
  Height := 22;
end;

{ TRibbonGalleryControl }

function TRibbonGalleryControl.CanAddToQuickAccessToolbar: Boolean;
begin
  Result := False;
end;

function TRibbonGalleryControl.GetContainedControl: TControl;
begin
  Result := FGallery;
end;

procedure TRibbonGalleryControl.SetContainedControl(const Value: TControl);
begin
  if Value is TRibbonGallery then
    FGallery := Value as TRibbonGallery;
end;

{ TRibbonSpinButton }

function TRibbonSpinButton.Control: TRibbonSpinEdit;
begin
  Result := Owner as TRibbonSpinEdit;
end;

constructor TRibbonSpinButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] +
    [csFramed, csOpaque];
  { Frames don't look good around the buttons when themes are on }
  if ThemeServices.ThemesEnabled then
    ControlStyle := ControlStyle - [csFramed];
  FUpButton := CreateButton;
  FUpButton.ButtonStyle := sbsUp;
  FDownButton := CreateButton;
  FDownButton.ButtonStyle := sbsDown;
  UpGlyph := nil;
  DownGlyph := nil;

  Width := 20;
  Height := 25;
  FFocusedButton := FUpButton;
end;

function TRibbonSpinButton.CreateButton: TTimerSpeedButton;
begin
  Result := TTimerSpeedButton.Create(Self);
  Result.OnClick := BtnClick;
  Result.OnMouseDown := BtnMouseDown;
  Result.Visible := True;
  Result.Enabled := True;
  Result.TimeBtnState := [tbAllowTimer];
  Result.Parent := Self;
end;

procedure TRibbonSpinButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FFocusControl := nil;
end;

procedure TRibbonSpinButton.AdjustSize(var W, H: Integer);
begin
  if (FUpButton = nil) or (csLoading in ComponentState) then Exit;
  if W < 18 then W := 18;
  FUpButton.SetBounds(0, 0, W, H div 2);
  FDownButton.SetBounds(0, FUpButton.Height, W, H - FUpButton.Height);
end;

procedure TRibbonSpinButton.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  AdjustSize(W, H);
  inherited SetBounds(ALeft, ATop, W, H);
end;

procedure TRibbonSpinButton.WMSize(var Message: TWMSize);
var
  W, H: Integer;
begin
  inherited;
  { check for minimum size }
  W := Width;
  H := Height;
  AdjustSize(W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds(Left, Top, W, H);
  Message.Result := 0;
end;

procedure TRibbonSpinButton.WMSetFocus(var Message: TWMSetFocus);
begin
  FFocusedButton.TimeBtnState := FFocusedButton.TimeBtnState + [tbFocusRect];
  FFocusedButton.Invalidate;
end;

procedure TRibbonSpinButton.WMKillFocus(var Message: TWMKillFocus);
begin
  FFocusedButton.TimeBtnState := FFocusedButton.TimeBtnState - [tbFocusRect];
  FFocusedButton.Invalidate;
end;

procedure TRibbonSpinButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP:
      begin
        SetFocusBtn (FUpButton);
        FUpButton.Click;
      end;
    VK_DOWN:
      begin
        SetFocusBtn (FDownButton);
        FDownButton.Click;
      end;
    VK_SPACE:
      FFocusedButton.Click;
  end;
end;

procedure TRibbonSpinButton.BtnMouseDown (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    SetFocusBtn (TTimerSpeedButton (Sender));
    if (FFocusControl <> nil) and FFocusControl.TabStop and 
        FFocusControl.CanFocus and (GetFocus <> FFocusControl.Handle) then
      FFocusControl.SetFocus
    else if TabStop and (GetFocus <> Handle) and CanFocus then
      SetFocus;
  end;
end;

procedure TRibbonSpinButton.BtnClick(Sender: TObject);
begin
  if Sender = FUpButton then
  begin
    if Assigned(FOnUpClick) then FOnUpClick(Self);
  end
  else
    if Assigned(FOnDownClick) then FOnDownClick(Self);
end;

procedure TRibbonSpinButton.SetFocusBtn (Btn: TTimerSpeedButton);
begin
  if TabStop and CanFocus and  (Btn <> FFocusedButton) then
  begin
    FFocusedButton.TimeBtnState := FFocusedButton.TimeBtnState - [tbFocusRect];
    FFocusedButton := Btn;
    if (GetFocus = Handle) then 
    begin
       FFocusedButton.TimeBtnState := FFocusedButton.TimeBtnState + [tbFocusRect];
       Invalidate;
    end;
  end;
end;

procedure TRibbonSpinButton.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TRibbonSpinButton.Loaded;
var
  W, H: Integer;
begin
  inherited Loaded;
  W := Width;
  H := Height;
  AdjustSize (W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
end;

function TRibbonSpinButton.GetUpGlyph: TBitmap;
begin
  Result := FUpButton.Glyph;
end;

procedure TRibbonSpinButton.SetUpGlyph(Value: TBitmap);
begin
  if Value <> nil then
    FUpButton.Glyph := Value
  else
  begin
    FUpButton.Glyph.Handle := LoadBitmap(HInstance, 'SpinUp');
    FUpButton.NumGlyphs := 1;
    FUpButton.Invalidate;
  end;
end;

function TRibbonSpinButton.GetUpNumGlyphs: TNumGlyphs;
begin
  Result := FUpButton.NumGlyphs;
end;

procedure TRibbonSpinButton.SetUpNumGlyphs(Value: TNumGlyphs);
begin
  FUpButton.NumGlyphs := Value;
end;

function TRibbonSpinButton.GetDownGlyph: TBitmap;
begin
  Result := FDownButton.Glyph;
end;

procedure TRibbonSpinButton.SetDownGlyph(Value: TBitmap);
begin
  if Value <> nil then
    FDownButton.Glyph := Value
  else
  begin
    FDownButton.Glyph.Handle := LoadBitmap(HInstance, 'SpinDown');
    FUpButton.NumGlyphs := 1;
    FDownButton.Invalidate;
  end;
end;

function TRibbonSpinButton.GetDownNumGlyphs: TNumGlyphs;
begin
  Result := FDownButton.NumGlyphs;
end;

procedure TRibbonSpinButton.SetDownNumGlyphs(Value: TNumGlyphs);
begin
  FDownButton.NumGlyphs := Value;
end;

{ TRibbonSpinEdit }

constructor TRibbonSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButton := TRibbonSpinButton.Create(Self);
  FButton.Width := 18;
  FButton.Height := 17;
  FButton.Visible := True;
  FButton.Parent := Self;
  FButton.FocusControl := Self;
  FButton.OnUpClick := UpClick;
  FButton.OnDownClick := DownClick;
  Text := '0';
  ControlStyle := ControlStyle - [csSetCaption];
  FIncrement := 1;
  FEditorEnabled := True;
  ParentBackground := False;
end;

destructor TRibbonSpinEdit.Destroy;
begin
  FButton := nil;
  inherited Destroy;
end;

procedure TRibbonSpinEdit.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

procedure TRibbonSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_UP then UpClick (Self)
  else if Key = VK_DOWN then DownClick (Self);
  inherited KeyDown(Key, Shift);
end;

procedure TRibbonSpinEdit.KeyPress(var Key: Char);
var
  LCloseCollapsedGroup: Boolean;
begin
  LCloseCollapsedGroup := Key = #13;
  if not IsValidChar(Key) then
  begin
    Key := #0;
    MessageBeep(0)
  end;
  if Key <> #0 then
    inherited KeyPress(Key);
  if LCloseCollapsedGroup then
  begin
    if GetParentForm(Self) is TRibbonGroupDockForm then
      Winapi.Windows.SetFocus(Application.MainForm.Handle);
  end;
end;

function TRibbonSpinEdit.IsValidChar(Key: Char): Boolean;
begin
  Result := CharInSet(Key, [AnsiChar(FormatSettings.DecimalSeparator), '+', '-', '0'..'9']) or
    ((Key < #32) and (Key <> Chr(VK_RETURN)));
  if not FEditorEnabled and Result and ((Key >= #32) or
      (Key = Char(VK_BACK)) or (Key = Char(VK_DELETE))) then
    Result := False;
end;

procedure TRibbonSpinEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
{  Params.Style := Params.Style and not WS_BORDER;  }
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TRibbonSpinEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
end;

procedure TRibbonSpinEdit.SetEditRect;
var
  Loc: TRect;
begin
  {$IF NOT DEFINED(CLR)}
  SendMessage(Handle, EM_GETRECT, 0, Winapi.Windows.LPARAM(@Loc));
  {$ELSE}
  Perform(EM_GETRECT, 0, Loc);
  {$ENDIF}
  Loc.Bottom := ClientHeight + 1;  {+1 is workaround for windows paint bug}
  Loc.Right := ClientWidth - FButton.Width - 2;
  Loc.Top := 0;
  Loc.Left := 0;
  {$IF NOT DEFINED(CLR)}
  SendMessage(Handle, EM_SETRECTNP, 0, Winapi.Windows.LPARAM(@Loc));
  SendMessage(Handle, EM_GETRECT, 0, Winapi.Windows.LPARAM(@Loc));  {debug}
  {$ELSE}
  Perform(EM_SETRECTNP, 0, Loc);
  Perform(EM_GETRECT, 0, Loc);  {debug}
  {$ENDIF}
end;

procedure TRibbonSpinEdit.SetEnabled(Value: Boolean);
begin
  inherited;
  if FButton.FUpButton <> nil then
    FButton.FUpButton.Enabled := Value;
  if FButton.FDownButton <> nil then
    FButton.FDownButton.Enabled := Value;
end;

procedure TRibbonSpinEdit.SetParent(AParent: TWinControl);
begin
  inherited;
  if (AParent <> nil) then
  begin
    if not (AParent is TCustomRibbonGroup) then
      raise Exception.CreateFmt(SRibbonControlInvalidParent, [ClassName]);
  end;
end;

procedure TRibbonSpinEdit.WMSize(var Message: TWMSize);
var
  MinHeight: Integer;
begin
  inherited;
  MinHeight := GetMinHeight;
  if Height < MinHeight then   
    Height := MinHeight
  else if FButton <> nil then
  begin
    if NewStyleControls and Ctl3D then
      FButton.SetBounds(Width - FButton.Width - 3, -1, FButton.Width, Height - 2)
    else
      FButton.SetBounds (Width - FButton.Width, 1, FButton.Width, Height - 1);
    SetEditRect;
  end;
end;

function TRibbonSpinEdit.GetMinHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  try
    GetTextMetrics(DC, SysMetrics);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then
    I := Metrics.tmHeight;
  Result := Metrics.tmHeight + I div 4 + GetSystemMetrics(SM_CYBORDER) * 4 + 2;
end;

procedure TRibbonSpinEdit.UpClick (Sender: TObject);
begin
  if ReadOnly then
    MessageBeep(0)
  else
    Value := Value + FIncrement;
end;

procedure TRibbonSpinEdit.DownClick (Sender: TObject);
begin
  if ReadOnly then
    MessageBeep(0)
  else
    Value := Value - FIncrement;
end;

procedure TRibbonSpinEdit.WMPaste(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then
    Exit;
  inherited;
end;

procedure TRibbonSpinEdit.WMCut(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then
    Exit;
  inherited;
end;

procedure TRibbonSpinEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  FButton.Invalidate;
end;

procedure TRibbonSpinEdit.CMExit(var Message: TCMExit);
begin
  inherited;
  if CheckValue (Value) <> Value then
    SetValue (Value);
end;

procedure TRibbonSpinEdit.CMMouseenter(var Message: TMessage);
begin
  inherited;
  FButton.Invalidate;
end;

procedure TRibbonSpinEdit.CMMouseleave(var Message: TMessage);
begin
  inherited;
  FButton.Invalidate;
end;

function TRibbonSpinEdit.GetValue: LongInt;
begin
  try
    Result := StrToInt (Text);
  except
    Result := FMinValue;
  end;
end;

procedure TRibbonSpinEdit.SetValue(NewValue: LongInt);
begin
  Text := IntToStr(CheckValue(NewValue));
end;

function TRibbonSpinEdit.CheckValue (NewValue: LongInt): LongInt;
begin
  Result := NewValue;
  if (FMaxValue <> FMinValue) then
  begin
    if NewValue < FMinValue then
      Result := FMinValue
    else if NewValue > FMaxValue then
      Result := FMaxValue;
  end;
end;

procedure TRibbonSpinEdit.CMEnter(var Message: TCMGotFocus);
begin
  if AutoSelect and not (csLButtonDown in ControlState) then
    SelectAll;
  inherited;
end;

{TTimerSpeedButton}

const
  InitRepeatPause = 400;  { pause before repeat timer (ms) }
  RepeatPause     = 100;  { pause before hint window displays (ms)}

procedure TTimerSpeedButton.CMMouseenter(var Message: TMessage);
begin
  MouseInControl := True;
end;

procedure TTimerSpeedButton.CMMouseleave(var Message: TMessage);
begin
  MouseInControl := False;
end;

constructor TTimerSpeedButton.Create(AOwner: TComponent);
begin
  inherited;
  FButton := AOwner as TRibbonSpinButton;
end;

destructor TTimerSpeedButton.Destroy;
begin
  if FRepeatTimer <> nil then
    FRepeatTimer.Free;
  inherited Destroy;
end;

procedure TTimerSpeedButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
 X, Y: Integer);
begin
  inherited MouseDown (Button, Shift, X, Y);
  if tbAllowTimer in FTimeBtnState then
  begin
    if FRepeatTimer = nil then
      FRepeatTimer := TTimer.Create(Self);
    FRepeatTimer.OnTimer := TimerExpired;
    FRepeatTimer.Interval := InitRepeatPause;
    FRepeatTimer.Enabled  := True;
  end;
end;

procedure TTimerSpeedButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
 X, Y: Integer);
begin
  inherited MouseUp (Button, Shift, X, Y);
  if FRepeatTimer <> nil then
    FRepeatTimer.Enabled  := False;
end;

procedure TTimerSpeedButton.TimerExpired(Sender: TObject);
begin
  FRepeatTimer.Interval := RepeatPause;
  if (FState = bsDown) and MouseCapture then
  begin
    try
      Click;
    except
      FRepeatTimer.Enabled := False;
      raise;
    end;
  end;
end;

procedure TTimerSpeedButton.Paint;
var
  LRect: TRect;
  LRibbonStyle: TRibbonStyleActionBars;
begin
  LRibbonStyle := TCustomRibbonPage(FButton.Control.Parent.Parent).RibbonStyle;
  if Enabled then
  begin
    if MouseInControl then
    begin
      if not (IsLeftMouseButtonPressed(Self) and (FState = bsDown)) then
        LRibbonStyle.DrawElement(ssButtonHover, Canvas, ClientRect)
      else
        LRibbonStyle.DrawElement(ssButtonPressed, Canvas, ClientRect)
    end
    else if Parent.Parent.Focused or (TCustomEdit(Parent.Parent).MouseInClient) then
    begin
      if ButtonStyle = sbsUp then
        LRibbonStyle.DrawElement(ssButtonUp, Canvas, ClientRect)
      else
        LRibbonStyle.DrawElement(ssButtonDown, Canvas, ClientRect)
    end;
  end;
  if ButtonStyle = sbsUp then
    LRibbonStyle.DrawElement(ssButtonUpIcon, Canvas, ClientRect)
  else
    LRibbonStyle.DrawElement(ssButtonDownIcon, Canvas, ClientRect);

  if tbFocusRect in FTimeBtnState then
  begin
    LRect := Bounds(0, 0, Width, Height);
    InflateRect(LRect, -3, -3);
    if FState = bsDown then
      OffsetRect(LRect, 1, 1);
    DrawFocusRect(Canvas.Handle, LRect);
  end;
end;

procedure TTimerSpeedButton.SetButtonStyle(const Value: TSpinButtonStyle);
begin
  if FButtonStyle <> Value then
  begin
    FButtonStyle := Value;
    Invalidate;
  end;
end;

procedure TTimerSpeedButton.SetMouseInControl(const Value: Boolean);
begin
  if FMouseInControl <> Value then
  begin
    FMouseInControl := Value;
    Invalidate;
  end;
end;

{ TFadeItem }

constructor TFadeItem.Create(AManager: TFadeManager; AControl: TControl; ADirection: TFadeDirection);
begin
  inherited Create;
  FManager := AManager;
  FControl := AControl;
  FCount := 0;
  FDirection := ADirection;
  FRemoveWhenDone := False;
  FTimer := TTimer.Create(nil);
  if ADirection = fdUp then
    FTimer.Interval := 1
  else
    FTimer.Interval := 30;
  FTimer.OnTimer := TimerHandler;
  FTimer.Enabled := True;
end;

destructor TFadeItem.Destroy;
begin
  FTimer.Free;
  inherited;
end;

function TFadeItem.NotFinished: Boolean;
begin
  if FDirection = fdUp then
    Result := (FCount < FSteps)
  else if FDirection = fdDown then
    Result := (FCount > 0)
  else
    Result := False;
end;

procedure TFadeItem.TimerHandler(Sender: TObject);
begin
  FTimer.Enabled := False;
  try
    if FDirection = fdUp then
      Inc(FCount)
    else if FDirection = fdDown then
      Dec(FCount);
    FControl.Perform(UM_FADECONTROL, ord(FDirection), FCount);
  finally
    FTimer.Enabled := NotFinished;
  end;
  if not FTimer.Enabled and FRemoveWhenDone then
    FManager.RemoveControl(Self);
end;

procedure TFadeItem.Toggle;
begin
  FTimer.Enabled := False;
  try
    if FDirection = fdUp then
    begin
      FTimer.Interval := 30;
      FDirection := fdDown
    end
    else if FDirection = fdDown then
    begin
      FDirection := fdUp;
      FTimer.Interval := 1;
    end;
    FRemoveWhenDone := True;
  finally
    FTimer.Enabled := True;
  end;
end;

{ TFadeManager }

procedure TFadeManager.AddControl(AControl: TControl; ADirection: TFadeDirection = fdUp);
var
  LFadeItem: TFadeItem;
begin
  LFadeItem := TFadeItem.Create(Self, AControl, ADirection);
  FControls.Add(LFadeItem);
end;

constructor TFadeManager.Create;
begin
  inherited Create;
  FControls := TFadeControls.Create;
  FControls.Steps := 15;
end;

destructor TFadeManager.Destroy;
begin
  FControls.Free;
  inherited;
end;

function TFadeManager.GetSteps: Integer;
begin
  Result := FControls.Steps;
end;

procedure TFadeManager.RemoveControl(AFadeItem: TFadeItem);
begin
  FControls.Remove(AFadeItem);
end;

procedure TFadeManager.SetSteps(const Value: Integer);
begin
  FControls.Steps := Value;
end;

procedure TFadeManager.RemoveControl(AControl: TControl; AFadeFirst: Boolean = True);
var
  LItem: TFadeItem;
begin
  LItem := FControls.Get(AControl);
  if LItem = nil then
    Exit;
  if AFadeFirst then
    LItem.Toggle
  else
    FControls.Remove(LItem);
end;

{ TFadeControls }

procedure TFadeControls.Add(var AFadeItem: TFadeItem);
var
  I: Integer;
begin
  FControlsCS.Enter;
  try
    AFadeItem.Steps := FSteps;
    for I := 0 to FControls.Count - 1 do
    begin
      if TFadeItem(FControls[I]).Control = AFadeItem.Control then
      begin
        AFadeItem.Free;
        Exit;
      end;
    end;
    FControls.Add(AFadeItem);
  finally
    FControlsCS.Leave;
  end;
end;

constructor TFadeControls.Create;
begin
  inherited Create;
  FControlsCS := TCriticalSection.Create;
  FControls := TObjectList.Create;
end;

destructor TFadeControls.Destroy;
begin
  FControls.Free;
  FControlsCS.Free;
  inherited;
end;

function TFadeControls.Get(AControl: TControl): TFadeItem;
var
  I: Integer;
begin
  FControlsCS.Enter;
  try
    for I := 0 to FControls.Count - 1 do
    begin
      Result := TFadeItem(FControls[I]);
      if Result.Control = AControl then
        Exit;
    end;
    Result := nil;
  finally
    FControlsCS.Leave;
  end;
end;

procedure TFadeControls.Remove(AFadeItem: TFadeItem);
begin
  FControlsCS.Enter;
  try
    FControls.Remove(AFadeItem);
  finally
    FControlsCS.Leave;
  end;
end;

{ TRibbonCheckBoxControl }

procedure TRibbonCheckBoxControl.CalcBounds;
begin
  inherited;
  Width := Width + 21;
  GlyphPos := Point(GlyphPos.X + 21, GlyphPos.Y);
  TextBounds := Rect(TextBounds.Left + 21, TextBounds.Top, TextBounds.Right + 21, TextBounds.Bottom);
end;

function GetCheckBoxElement(Enabled, Checked, Hover, Pressed: Boolean): TSkinCheckBox;
begin
  if Hover and Pressed and Enabled then
    Result := scPressed
  else if Hover and Enabled then
  begin
    if Checked then
      Result := scHoverSelected
    else
      Result := scHover;
  end
  else if Enabled then
  begin
    if Checked then
      Result := scSelected
    else
      Result := scNormal;
  end
  else
  begin
    if Checked then
      Result := scDisabledSelected
    else
      Result := scDisabled;
  end;
end;

procedure TRibbonCheckBoxControl.DrawBackground(var PaintRect: TRect);
var
  LRect: TRect;
begin
  LRect := PaintRect;
  Inc(LRect.Left, 3);
  LRect.Right := LRect.Left + 13;
  LRect.Top := LRect.Top + ((LRect.Bottom - LRect.Top) div 2) - 6;
  LRect.Bottom := LRect.Top + 13;
  RibbonStyle.DrawElement(GetCheckBoxElement(Enabled, IsChecked,
    MouseInControl and not ActionBar.DesignMode, IsLeftMouseButtonPressed(Self) and
    not ActionBar.DesignMode), Canvas, LRect);
end;

procedure TRibbonCheckBoxControl.DrawGlyph(const Location: TPoint);
var
  LDisabled: Boolean;
  LDrawEnabled: Boolean;
  LImageList: TCustomImageList;
begin
  if not HasGlyph then
    Exit;
  LImageList := FindImageList(False, LDisabled, ActionClient.ImageIndex);
  if not Assigned(LImageList) then
    Exit;
  LDrawEnabled := (Enabled or LDisabled) and (ActionClient.ImageIndex <> -1) or
    (csDesigning in ComponentState);
  LImageList.Draw(Canvas, Location.X, Location.Y, ActionClient.ImageIndex,
    dsTransparent, itImage, LDrawEnabled);
  Canvas.Brush.Style := bsClear;
end;

{ TRibbonRadioButtonControl }

procedure TRibbonRadioButtonControl.CalcBounds;
begin
  inherited;
  Width := Width + 20;
  GlyphPos := Point(GlyphPos.X + 20, GlyphPos.Y);
  TextBounds := Rect(TextBounds.Left + 20, TextBounds.Top, TextBounds.Right + 20, TextBounds.Bottom);
end;

function GetRadioButtonElement(Enabled, Checked, Hover, Pressed: Boolean): TSkinRadioButton;
begin
  if Hover and Pressed and Enabled then
    Result := sbPressed
  else if Hover and Enabled then
  begin
    if Checked then
      Result := sbHoverSelected
    else
      Result := sbHover;
  end
  else if Enabled then
  begin
    if Checked then
      Result := sbSelected
    else
      Result := sbNormal;
  end
  else
  begin
    if Checked then
      Result := sbDisabledSelected
    else
      Result := sbDisabled;
  end;
end;

procedure TRibbonRadioButtonControl.DrawBackground(var PaintRect: TRect);
var
  LRect: TRect;
begin
  LRect := PaintRect;
  Inc(LRect.Left, 3);
  LRect.Right := LRect.Left + 13;
  LRect.Top := LRect.Top + ((LRect.Bottom - LRect.Top) div 2) - 6;
  LRect.Bottom := LRect.Top + 13;
  RibbonStyle.DrawElement(GetRadioButtonElement(Enabled, IsChecked,
    MouseInControl and not ActionBar.DesignMode,
    (IsLeftMouseButtonPressed(Self) and (FState = bsDown)) and
    not ActionBar.DesignMode), Canvas, LRect);
end;

procedure TRibbonRadioButtonControl.DrawGlyph(const Location: TPoint);
var
  LDisabled: Boolean;
  LDrawEnabled: Boolean;
  LImageList: TCustomImageList;
begin
  if not HasGlyph then
    Exit;
  LImageList := FindImageList(False, LDisabled, ActionClient.ImageIndex);
  if not Assigned(LImageList) then
    Exit;
  LDrawEnabled := (Enabled or LDisabled) and (ActionClient.ImageIndex <> -1) or
    (csDesigning in ComponentState);
  LImageList.Draw(Canvas, Location.X, Location.Y, ActionClient.ImageIndex,
    dsTransparent, itImage, LDrawEnabled);
  Canvas.Brush.Style := bsClear;
end;

initialization

finalization
  FFadeManager.Free;

end.
