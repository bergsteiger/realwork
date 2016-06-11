{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Vcl.WinXCtrls;

interface

{$WARN UNSUPPORTED_CONSTRUCT OFF}

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  Winapi.Messages,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.PngImage;

const
  DefaultActivityIndicatorFrameDelay = 50;
  DefaultSwitchWidth = 50;
  DefaultSwitchHeight = 20;
  DefaultSwitchThumbWidth = 15;
  DefaultSearchButtonWidth = 24;
  DefaultToggleSwitchDisabledColor = clBtnShadow;
  DefaultToggleSwitchFrameColor = clWindowText;
  DefaultToggleSwitchThumbColor = clWindowText;
  DefaultToggleSwitchTrackColor = clWindow;
  DefaultToggleSwitchHeight = 50;
  DefaultToggleSwitchWidth = 80;
  DefaultSplitViewCompactWidth = 50;
  DefaultSplitViewOpenedWidth = 200;
  DefaultSplitViewAnimationDelay = 15;
  DefaultSplitViewAnimationStep = 20;

type
  { TActivityIndicator }

  TActivityIndicatorColor = (aicBlack, aicWhite);
  TActivityIndicatorSize = (aisSmall, aisMedium, aisLarge, aisXLarge);
  TActivityIndicatorType = (aitMomentumDots, aitRotatingSector, aitSectorRing);

  /// <summary>
  /// TCustomActivityIndicator is the base class for TActivityIndicator.
  /// </summary>
  TCustomActivityIndicator = class(TCustomControl)
  private
    FAnimate: Boolean;
    FIndicatorColor: TActivityIndicatorColor;
    FIndicatorSize: TActivityIndicatorSize;
    FIndicatorType: TActivityIndicatorType;
    FFrameDelay: Word;
    FFrameIndex: Integer;
    FTimer: TTimer;
    FFrameList: TImageList;
    FFrameCount: Integer;
    FFrameSize: Integer;
    FFrameBitmap: TBitmap;
    FLoadedFrames: Boolean;

    // Internal Event Handlers
    procedure TimerExpired(Sender: TObject);

    // Property Access Methods
    procedure SetAnimate(Value: Boolean);
    procedure SetFrameDelay(Value: Word);
    procedure SetIndicatorColor(Value: TActivityIndicatorColor);
    procedure SetIndicatorSize(Value: TActivityIndicatorSize);
    procedure SetIndicatorType(Value: TActivityIndicatorType);

    // Message Handling Methods
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    /// <summary>ReloadFrames is used to reload the appropriate set of animation frames from resources based on the
    /// current values of IndicatorType, IndicatorSize, and IndicatorColor.</summary>
    procedure ReloadFrames; virtual;
    /// <summary>DrawFrame is used to display a single frame of the current activity indicator animation sequence.</summary>
    procedure DrawFrame; virtual;
    procedure Paint; override;
    procedure Resize; override;

    /// <summary>Specifies whether the activity indicator is currently animating.</summary>
    property Animate: Boolean read FAnimate write SetAnimate default False;
    /// <summary>Specifies how fast the activity indicator displays its animation sequence.
    /// Set this property to a lower value to speed up the animation.</summary>
    property FrameDelay: Word read FFrameDelay write SetFrameDelay default DefaultActivityIndicatorFrameDelay;
    /// <summary>Specifies the color of the activity indicator.
    /// aicBlack - The elements of the indicator are black.
    /// aicWhite - The elements of the indicator are white.</summary>
    property IndicatorColor: TActivityIndicatorColor read FIndicatorColor write SetIndicatorColor default aicBlack;
    /// <summary>Specifies the size of the activity indicator.
    /// aisSmall - 24 x 24 pixels
    /// aisMedium - 32 x 32 pixels
    /// aisLarge - 48 x 48 pixels
    /// aisXLarge - 64 x 64 pixels</summary>
    property IndicatorSize: TActivityIndicatorSize read FIndicatorSize write SetIndicatorSize default aisMedium;
    /// <summary>Specifies the type of indicator to display.
    /// aitMomentumDots - Traditional Windows 8/10 rotating sequence of dots accelerating and deccelerating in a circular pattern.
    /// aitRotatingSector - Alternating sectors of a segmented ring are highlighted in sequence to indicate activity.
    /// aitSectorRing - Sectors of a segmented ring are highlighted in sequence until the ring is completely highlighted. On the next pass, each sector is displayed in dimmed state.</summary>
    property IndicatorType: TActivityIndicatorType read FIndicatorType write SetIndicatorType default aitMomentumDots;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    /// <summary>Helper method that sets the Animate property to True.</summary>
    procedure StartAnimation;
    /// <summary>Helper method that sets the Animate property to False.</summary>
    procedure StopAnimation;
  published
    // Inherited Properties & Events
    property Height stored False;
    property Width stored False;
  end;

  /// <summary>
  /// TActivityIndicator implements an animated rotating display indicating that the application is performing some
  /// activity. The style of indicator is specified with the IndicatorType property. The IndicatorSize and
  /// IndicatorColor properties are also used to alter the display. The speed of the animation is controlled using the
  /// FrameDelay property. Set the Animate property to True to start the animation.
  /// <summary>
  TActivityIndicator = class(TCustomActivityIndicator)
  published
    // Inherited Properties & Events
    property Anchors;
    property Animate;
    property FrameDelay;
    property IndicatorColor;
    property IndicatorSize;
    property IndicatorType;
  end;

  { TToggleSwitch }

  TCustomToggleSwitch = class;

  TToggleSwitchState = (tssOff, tssOn);

  /// <summary>
  /// TToggleSwitchStateCaptions encapsulates the text strings used to depict the Off and On states.
  /// </summary>
  TToggleSwitchStateCaptions = class(TPersistent)
  private
    FToggleSwitch: TCustomToggleSwitch;
    FCaptionOn: string;
    FCaptionOff: string;
    procedure SetCaptionOn(const Value: string);
    function IsCaptionOnStored: Boolean;
    procedure SetCaptionOff(const Value: string);
    function IsCaptionOffStored: Boolean;
  public
    constructor Create(ToggleSwitch: TCustomToggleSwitch);
  published

    /// <summary>Specifies the text string to be used when the toggle switch is in the Off state.</summary>
    property CaptionOn: string read FCaptionOn write SetCaptionOn stored IsCaptionOnStored;
    /// <summary>Specifies the text string to be used when the toggle switch is in the On state.</summary>
    property CaptionOff: string read FCaptionOff write SetCaptionOff stored IsCaptionOffStored;
  end;

  /// <summary>
  /// Internal class used to connect an action to a TToggleSwitch
  /// </summary>
  TToggleSwitchActionLink = class(TWinControlActionLink)
  protected
    /// <summary>Protected field that holds reference to the associated client control.</summary>
    FClient: TCustomToggleSwitch;
    procedure AssignClient(AClient: TObject); override;
    function IsCheckedLinked: Boolean; override;
    procedure SetChecked(Value: Boolean); override;
  end;

  TToggleSwitchActionLinkClass = class of TToggleSwitchActionLink;

  /// <summary>
  /// TCustomToggleSwitch is the base class for the TToggleSwitch.
  /// </summary>
  TCustomToggleSwitch = class(TCustomControl)
  private
    FAlignment: TLeftRight;
    FAutoSize: Boolean;
    FReadOnly: Boolean;
    FState: TToggleSwitchState;
    FStateCaptions: TToggleSwitchStateCaptions;
    FShowStateCaption: Boolean;
    FDisabledColor: TColor;
    FFrameColor: TColor;
    FThumbColor: TColor;
    FKeyToggle: Boolean;
    FSwitchWidth: Integer;
    FSwitchHeight: Integer;
    FThumbWidth: Integer;

    function ShowFocus: Boolean;
    // Property Access Methods
    procedure SetAlignment(Value: TLeftRight);
    procedure SetDisabledColor(Value: TColor);
    procedure SetFrameColor(Value: TColor);
    procedure SetState(Value: TToggleSwitchState);
    function IsStateStored: Boolean;
    procedure SetShowStateCaption(Value: Boolean);
    procedure SetStateCaptions(Value: TToggleSwitchStateCaptions);
    procedure SetSwitchHeight(Value: Integer);
    procedure SetSwitchWidth(Value: Integer);
    procedure SetThumbColor(Value: TColor);
    procedure SetThumbWidth(Value: Integer);

    // Message Handling Methods
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CMColorChanged(var Msg: TMessage); message CM_COLORCHANGED;
    procedure CMParentColorChanged(var Msg: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CMTextChanged(var Msg: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
  protected
    /// <summary>Protected field used to control whether mouse clicks should be processed by the control.</summary>
    FClicksDisabled: Boolean;
    /// <summary>Protected field used to hold the image of the background of the control. This field is used to
    /// support transparency.</summary>
    FBackgroundBmp: TBitmap;
    /// <summary>Protected field used to indicate that the control is being manipulated with the mouse instead of
    /// the keyboard.</summary>
    FUsingMouse: Boolean;

    procedure CreateWnd; override;
    procedure Loaded; override;
    /// <summary>AdjustBounds is used to modify the size of the control to encompass the current StateCaptions
    /// and the toggle switch.</summary>
    procedure AdjustBounds; dynamic;
    procedure ChangeScale(M, D: Integer; isDpiChange: Boolean); override;

    /// <summary>ChangeState is used to toggle the state of the control.</summary>
    procedure ChangeState; virtual;

    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    function GetActionLinkClass: TControlActionLinkClass; override;

    /// <summary>Protected method used to determine the correct position of the switch portion of the control.</summary>
    procedure GetGlyphPosition(var X, Y: Integer); virtual;
    /// <summary>Protected method used to update the display of the toggle switch when the keyboard is used to
    /// manipulate the control.</summary>
    procedure UpdateDisplay;
    /// <summary>Protected method used to repaint the toggle switch when the control gains or loses keyboard focus.</summary>
    procedure RepaintDisplay;
    /// <summary>GetActiveStateCaption is used to quickly access the current state text string based on the current
    /// state of the control.</summary>
    function GetActiveStateCaption: string;
    /// <summary>DrawSwitch is used to draw the toggle switch.</summary>
    procedure DrawSwitch(Canvas: TCanvas);
    procedure Paint; override;

    // Event Dispatch Methods
    procedure Click; override;
    procedure DoExit; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    // Property Access Methods
    procedure SetAutoSize(Value: Boolean); override;

    /// <summary>Specifies whether the associated text is displayed on the right (default) or the left.</summary>
    property Alignment: TLeftRight read FAlignment write SetAlignment default taRightJustify;
    /// <summary>Specifies whether the control adjusts its bounds based on the SwitchHeight and SwitchWidth properties
    /// and the size of the associted text strings.</summary>
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    /// <summary>Specifies the color to be used to display all elements (thumb, frame) when the control is disabled.</summary>
    property DisabledColor: TColor read FDisabledColor write SetDisabledColor default DefaultToggleSwitchDisabledColor;
    /// <summary>Specifies the color of the toggle switch frame.</summary>
    property FrameColor: TColor read FFrameColor write SetFrameColor default DefaultToggleSwitchFrameColor;
    /// <summary>Specifies whether the control is in ReadOnly mode, which means the toggle state cannot be changed.</summary>
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    /// <summary>Specifies the current state of the switch.
    /// tssOff - The switch is in the off state.
    /// tssOn - The switch is in the on state.
    /// </summary>
    property State: TToggleSwitchState read FState write SetState stored IsStateStored default tssOff;
    /// <summary>Specifies the text strings to be used to display the text representation of the current state.
    /// For example, Off and On.</summary>
    property StateCaptions: TToggleSwitchStateCaptions read FStateCaptions write SetStateCaptions;
    /// <summary>Specifies whether the control displays the text string associated with the current state.</summary>
    property ShowStateCaption: Boolean read FShowStateCaption write SetShowStateCaption default True;
    /// <summary>Specifies the height of the toggle switch not including the associated text string.</summary>
    property SwitchHeight: Integer read FSwitchHeight write SetSwitchHeight default DefaultSwitchHeight;
    /// <summary>Specifies the width of the toggle switch not including the associated text string.</summary>
    property SwitchWidth: Integer read FSwitchWidth write SetSwitchWidth default DefaultSwitchWidth;
    /// <summary>Specifies the color of the toggle switch thumb.</summary>
    property ThumbColor: TColor read FThumbColor write SetThumbColor default DefaultToggleSwitchThumbColor;
    /// <summary>Specifies the width of the thumb displayed insides the frame of the toggle switch.</summary>
    property ThumbWidth: Integer read FThumbWidth write SetThumbWidth default DefaultSwitchThumbWidth;
    property Color default clWindow;
    property ParentColor default False;
    property TabStop default True;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetControlsAlignment: TAlignment; override;
    /// <summary>Helper function to quickly determine if the toggle switch is currently in the On state.</summary>
    function IsOn: Boolean;
  published
    property Height default DefaultToggleSwitchHeight;
    property Width default DefaultToggleSwitchWidth;
  end;

  /// <summary>
  /// TToggleSwitch implements a clickable control that allows a user to toggle between an Off state and an On state.
  /// </summary>
  TToggleSwitch = class(TCustomToggleSwitch)
  published
    // Inherited Properties & Events
    property Action;
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Color;
    property Constraints;
    property DisabledColor;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property FrameColor;
    property Height;
    property HelpContext;
    property Hint;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property ShowStateCaption;
    property State;
    property StateCaptions;
    property StyleElements;
    property SwitchHeight;
    property SwitchWidth;
    property TabOrder;
    property TabStop;
    property ThumbColor;
    property ThumbWidth;
    property Visible;
    property Width;

    property OnClick;
    property OnContextPopup;
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

  { TSearchBox }

  /// <summary>
  /// Internal class used to implement custom VCL Style support for the TSearchBox.
  /// </summary>
  TSearchBoxStyleHook = class(TEditStyleHook)
  strict private
    procedure WMNCCalcSize(var Msg: TWMNCCalcSize); message WM_NCCALCSIZE;
  strict protected
    procedure PaintNC(Canvas: TCanvas); override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TSearchBoxIndicator = (sbiText, sbiAudio);

  /// <summary>
  /// TSearchBox implements an edit box with an embedded button displaying a search indicator icon.
  /// Use this control to present an edit box to capture search criteria. When the search indicator icon is clicked or
  /// the Enter key is pressed (Text indicator), the OnInvokeSearch event is generated.
  /// </summary>
  TSearchBox = class(TEdit)
  strict private
    class constructor Create;
    class destructor Destroy;
  private
    FSearchIndicator: TSearchBoxIndicator;
    FTextIndicatorImages: TImageList;
    FAudioIndicatorImages: TImageList;
    FButtonWidth: Integer;
    FButtonRect: TRect;
    FMouseOverButton: Boolean;
    FButtonDown: Boolean;
    FOnInvokeSearch: TNotifyEvent;

    // Property Access Methods
    procedure SetButtonWidth(Value: Integer);
    procedure SetSearchIndicator(Value: TSearchBoxIndicator);

    // Message Handling Methods
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMNCHitTest(var Msg: TMessage); message WM_NCHITTEST;
    procedure WMNCCalcSize(var Msg: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMKillFocus(var Msg: TMessage); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Msg: TMessage); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMLButtonDblClk(var Msg: TMessage); message WM_LBUTTONDBLCLK;
    procedure WMRButtonDown(var Msg: TMessage); message WM_RBUTTONDOWN;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
  protected
    /// <summary>Protected field providing access to the canvas upon which the search indicator button is drawn.</summary>
    FCanvas: TCanvas;

    /// <summary>LoadImages is used to load the search indicator icons from resources.</summary>
    procedure LoadImages;
    /// <summary>RepaintButton sends a WM_NCPAINT message to the control to instruct the nonclient area of the
    /// control to be repainted. The search indicator is positioned in the nonclient area of the control.</summary>
    procedure RepaintButton;
    /// <summary>DrawButton is used to display the search indicator button.</summary>
    procedure DrawButton(Canvas: TCanvas); virtual;
    /// <summary>MouseCancel is used to release mouse capturing when the control loses keyboard focus.</summary>
    procedure MouseCancel;

    // Event Dispatch Methods
    /// <summary>Event dispatch method used to generate the OnInvokeSearch event.</summary>
    procedure InvokeSearch; dynamic;
    procedure KeyPress(var Key: Char); override;

    /// <summary>Property providing access to the internal FCanvas field. Used for drawing search indicator.</summary>
    property Canvas: TCanvas read FCanvas;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    /// <summary>Specifies the width of the search indicator button.</summary>
    property ButtonWidth: Integer read FButtonWidth write SetButtonWidth default DefaultSearchButtonWidth;
    /// <summary>Specifies the type of indicator icon to display.
    /// sbiText - Magnifier icon to indicate text based searching
    /// sbiAudio - Microphone icon to indicate audio based searching</summary>
    property SearchIndicator: TSearchBoxIndicator read FSearchIndicator write SetSearchIndicator default sbiText;
    /// <summary>This event occurs when the search indicator button is clicked. When SearchIndicator is set to sbiText,
    /// the OnInvokeSearch event also occurs when the Enter key is pressed.</summary>
    property OnInvokeSearch: TNotifyEvent read FOnInvokeSearch write FOnInvokeSearch;
  end;

  { TRelativePanel }

  TRelativePanel = class;
  /// <summary>Exception class representing errors in the TRelativePanel control.</summary>
  ERelativePanelException = class(Exception);

  /// <summary>
  /// TRelativePanelControlItem determines how the associated TControl instance is positioned with respect to the
  /// TRelativePanel or to other sibling controls on the same TRelativePanel.
  /// </summary>
  TRelativePanelControlItem = class(TCollectionItem)
  private
    FControl: TControl;
    FSaveWidth: Integer;
    FSaveHeight: Integer;
    FAbove: TControl;
    FAlignBottomWith: TControl;
    FAlignBottomWithPanel: Boolean;
    FAlignHorizontalCenterWith: TControl;
    FAlignHorizontalCenterWithPanel: Boolean;
    FAlignLeftWith: TControl;
    FAlignLeftWithPanel: Boolean;
    FAlignRightWith: TControl;
    FAlignRightWithPanel: Boolean;
    FAlignTopWith: TControl;
    FAlignTopWithPanel: Boolean;
    FAlignVerticalCenterWith: TControl;
    FAlignVerticalCenterWithPanel: Boolean;
    FBelow: TControl;
    FLeftOf: TControl;
    FRightOf: TControl;

    procedure SetControl(Value: TControl);

    procedure SetAbove(Value: TControl);
    procedure SetAlignBottomWith(Value: TControl);
    procedure SetAlignBottomWithPanel(Value: Boolean);
    procedure SetAlignHorizontalCenterWith(Value: TControl);
    procedure SetAlignHorizontalCenterWithPanel(Value: Boolean);
    procedure SetAlignLeftWith(Value: TControl);
    procedure SetAlignLeftWithPanel(Value: Boolean);
    procedure SetAlignRightWith(Value: TControl);
    procedure SetAlignRightWithPanel(Value: Boolean);
    procedure SetAlignTopWith(Value: TControl);
    procedure SetAlignTopWithPanel(Value: Boolean);
    procedure SetAlignVerticalCenterWith(Value: TControl);
    procedure SetAlignVerticalCenterWithPanel(Value: Boolean);
    procedure SetBelow(Value: TControl);
    procedure SetLeftOf(Value: TControl);
    procedure SetRightOf(Value: TControl);

    function GetRelativePanel: TRelativePanel;
  protected
    /// <summary>Protected method that is used to validate that the specified control is indeed a sibling to the associated TControl.</summary>
    procedure CheckControl(Value: TControl);
    procedure AssignTo(Dest: TPersistent); override;
    function GetDisplayName: string; override;
    /// <summary>Protected method that returns the TRelativePanel that owns the collection of which this item belongs.</summary>
    property RelativePanel: TRelativePanel read GetRelativePanel;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    /// <summary>This method determines if the associated control's width needs to be restored to its previous value.</summary>
    procedure CheckSaveWidth;
    /// <summary>This method determines if the associated control's height needs to be restored to its previous value.</summary>
    procedure CheckSaveHeight;

    /// <summary>This property is used to store the previous width of the associated control. This value is used in
    /// situations where the control's size is changed because of complementary alignment values being chosen. For
    /// example, AlignLeftWith and AlignRightWith.</summary>
    property SaveWidth: Integer read FSaveWidth write FSaveWidth;
    /// <summary>This property is used to store the previous height of the associated control. This value is used
    /// in situations where the control's size is changed because of complementary alignment values being chosen.
    /// For example, AlignTopWith and AlignBottomWith.</summary>
    property SaveHeight: Integer read FSaveHeight write FSaveHeight;
  published
    /// <summary>This property provides access to the TControl instance associated with this collection item.</summary>
    property Control: TControl read FControl write SetControl;

    /// <summary>The associated TControl is positioned to above the sibling control referenced in this property.</summary>
    property Above: TControl read FAbove write SetAbove;
    /// <summary>The associated TControl is aligned with the bottom of the sibling control referenced in this property.</summary>
    property AlignBottomWith: TControl read FAlignBottomWith write SetAlignBottomWith;
    /// <summary>The associated TControl is aligned with the bottom edge of the panel.</summary>
    property AlignBottomWithPanel: Boolean read FAlignBottomWithPanel write SetAlignBottomWithPanel;
    /// <summary>The associated TControl is aligned horizontally centered with the sibling control referenced in this property.</summary>
    property AlignHorizontalCenterWith: TControl read FAlignHorizontalCenterWith write SetAlignHorizontalCenterWith;
    /// <summary>The associated TControl is centered horizontally in the panel.</summary>
    property AlignHorizontalCenterWithPanel: Boolean read FAlignHorizontalCenterWithPanel write SetAlignHorizontalCenterWithPanel;
    /// <summary>The associated TControl is aligned with the left edge of the sibling control referenced in this property.</summary>
    property AlignLeftWith: TControl read FAlignLeftWith write SetAlignLeftWith;
    /// <summary>The associated TControl is aligned with the left edge of the panel.</summary>
    property AlignLeftWithPanel: Boolean read FAlignLeftWithPanel write SetAlignLeftWithPanel;
    /// <summary>The associated TControl is aligned with the right edge of the sibling control referenced in this property.</summary>
    property AlignRightWith: TControl read FAlignRightWith write SetAlignRightWith;
    /// <summary>The associated TControl is aligned with the right edge of the panel.</summary>
    property AlignRightWithPanel: Boolean read FAlignRightWithPanel write SetAlignRightWithPanel;
    /// <summary>The associated TControl is aligned with the top of the sibling control referenced in this property.</summary>
    property AlignTopWith: TControl read FAlignTopWith write SetAlignTopWith;
    /// <summary>The associated TControl is aligned with the top edge of the panel.</summary>
    property AlignTopWithPanel: Boolean read FAlignTopWithPanel write SetAlignTopWithPanel;
    /// <summary>The associated TControl is aligned vertically centered with the sibling control referenced in this property.</summary>
    property AlignVerticalCenterWith: TControl read FAlignVerticalCenterWith write SetAlignVerticalCenterWith;
    /// <summary>The associated TControl is centered vertically in the panel.</summary>
    property AlignVerticalCenterWithPanel: Boolean read FAlignVerticalCenterWithPanel write SetAlignVerticalCenterWithPanel;
    /// <summary>The associated TControl is positioned to below of the sibling control referenced in this property.</summary>
    property Below: TControl read FBelow write SetBelow;
    /// <summary>The associated TControl is positioned to the left of the sibling control referenced in this property.</summary>
    property LeftOf: TControl read FLeftOf write SetLeftOf;
    /// <summary>The associated TControl is positioned to the right of the sibling control referenced in this property.</summary>
    property RightOf: TControl read FRightOf write SetRightOf;
  end;

  /// <summary>
  /// Internal class used to implement the TRelativePanel.ControlCollection property.
  /// </summary>
  TRelativePanelControlCollection = class(TOwnedCollection)
  protected
    /// <summary>Read access method supporting the Controls array property.</summary>
    function GetControl(Index: Integer): TControl;
    /// <summary>Read accessor method supporting the Items array property.</summary>
    function GetItem(Index: Integer): TRelativePanelControlItem;
    /// <summary>This method is used to associate a TControl instance with a particular item in the collection.</summary>
    procedure SetControl(Index: Integer; Value: TControl);
    /// <summary>Protected method overrides inherited method to add typecasting for TRelativePanelControlItem type.</summary>
    procedure SetItem(Index: Integer; Value: TRelativePanelControlItem);
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TPersistent);
    /// <summary>Use this method to add a new item to the collection.</summary>
    function Add: TRelativePanelControlItem;
    /// <summary>Use this method to add a TControl instance to the collection.</summary>
    procedure AddControl(AControl: TControl);
    /// <summary>Use this method to remove a TControl instance from the collection.</summary>
    procedure RemoveControl(AControl: TControl);
    /// <summary>Use this method to get the index of the TRelativePanelControlItem instance that is asociated with
    /// the specified TControl.</summary>
    function IndexOf(AControl: TControl): Integer;
    /// <summary>Returns the TRelativePanel that owns the collection.</summary>
    function Owner: TRelativePanel;

    /// <summary>Array property that provides access to the individual TControl instances managed by the associated control item.</summary>
    property Controls[Index: Integer]: TControl read GetControl write SetControl;
    /// <summary>Array property that provides access to the individual TRelativePanelControlItem instances in the collection.</summary>
    property Items[Index: Integer]: TRelativePanelControlItem read GetItem write SetItem; default;
  end;

  /// <summary>
  /// TCustomRelativePanel is the base class for the TRelativePanel.
  /// </summary>
  TCustomRelativePanel = class(TCustomPanel)
  private
    FControlCollection: TRelativePanelControlCollection;
    // Property Access Methods
    procedure SetControlCollection(const Value: TRelativePanelControlCollection);

    // Message Handling Methods
    procedure CMControlChange(var Msg: TCMControlChange); message cm_ControlChange;
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    /// <summary>Helper function that returns the index of the specified child control in the ControlCollection.</summary>
    function GetControlIndex(AControl: TControl): Integer;
    /// <summary>Helper function that sets the index of the specified child control within the ControlCollection.
    /// Changing the index of a child control will affect the alignment process. Child controls are aligned based on
    /// their position in the collection.</summary>
    procedure SetControlIndex(AControl: TControl; Index: Integer);
  published
    /// <summary>This property is defined as published in order to support the TSelectionEditor descendant that is responsible for adding the set of new properties to child controls. The custom selection editor also removes the ControlCollection property from the Object Inspector.</summary>
    property ControlCollection: TRelativePanelControlCollection read FControlCollection write SetControlCollection;
  end;

  /// <summary>
  /// TRelativePanel implements a container control that allows child controls to be positioned relative to the panel
  /// itself, or relative to other child controls of the panel. When a control is placed on a TRelativePanel and the
  /// child control is selected in the Form Designer, the Object Inspector will display several additional properties
  /// at the bottom of the list that determine how the child control will be aligned within the TRelativePanel.
  ///
  /// The TRelativePanel positions child controls by first aligning each control to the panel as specified. Centering
  /// child controls (vertically and horizontally) takes precedence over left-right and top-bottom alignment. Next,
  /// each child control is positioned relative to its sibling controls. The list of child controls is processed in
  /// order. Therefore, if a child control is to be positioned relative to a sibling, the sibling control should
  /// have a lower index in the collection.
  ///
  /// Note, that it is possible to specify relationships between controls that lead to controls being positioned
  /// outside of the TRelativePanel. For example, if Label1 is positioned Above Edit1, but Edit1 is aligned to the
  /// Top of the TRelativePanel, Label1 will not be visible because it will be clipped by the panel.
  /// </summary>
  TRelativePanel = class(TCustomRelativePanel)
  public
    property DockManager;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Locked;
    property Padding;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowCaption;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property VerticalAlignment;
    property Visible;
    property StyleElements;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnCanResize;
    property OnClick;
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
    property OnExit;
    property OnGesture;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  { TSplitView }

  TSplitViewDisplayMode = (svmDocked, svmOverlay);
  TSplitViewCloseStyle = (svcCollapse, svcCompact);
  TSplitViewPlacement = (svpLeft, svpRight);
  TSplitViewState = (svsOpened, svsOpening, svsClosed, svsClosing);

  /// <summary>
  /// TCustomSplitView is the base class for TSplitView.
  /// </summary>
  TCustomSplitView = class(TCustomPanel)
  private
    FCloseStyle: TSplitViewCloseStyle;
    FCompactWidth: Integer;
    FDisplayMode: TSplitViewDisplayMode;
    FOpenedWidth: Integer;
    FPlacement: TSplitViewPlacement;

    FOnOpening: TNotifyEvent;
    FOnOpened: TNotifyEvent;
    FOnClosing: TNotifyEvent;
    FOnClosed: TNotifyEvent;

    FOverlayPadding: TWinControl;
    FState: TSplitViewState;
    FAnimationStep: Word;
    FAnimationDelay: Word;
    FUseAnimation: Boolean;
    FAnimationTimer: TTimer;

    procedure SetAnimationDelay(Value: Word);
    procedure SetCloseStyle(Value: TSplitViewCloseStyle);
    procedure SetCompactWidth(Value: Integer);
    procedure SetDisplayMode(Value: TSplitViewDisplayMode);
    function GetOpened: Boolean;
    procedure SetOpened(Value: Boolean);
    procedure SetOpenedWidth(Value: Integer);
    procedure SetPlacement(Value: TSplitViewPlacement);
    function GetWidth: Integer;
    procedure SetWidth(Value: Integer);

    procedure AnimationTimerHandler(Sender: TObject);
  protected
    procedure SetParent(AParent: TWinControl); override;
    /// <summary>Proteced method used to change the opened and closed state of the control.</summary>
    procedure SetState(Value: TSplitViewState); virtual;

    // Event Dispatch Methods
    /// <summary>Event dispatch method that generates the OnClosing event.</summary>
    procedure DoClosing; dynamic;
    /// <summary>Event dispatch method that generates the OnClosed event.</summary>
    procedure DoClosed; dynamic;
    /// <summary>Event dispatch method that generates the OnOpening event.</summary>
    procedure DoOpening; dynamic;
    /// <summary>Event dispatch method that generates the OnOpened event.</summary>
    procedure DoOpened; dynamic;

    /// <summary>Use this property to control the speed of the opening and closing animation. The smaller the
    /// AnimationDelay, the faster the animation.</summary>
    property AnimationDelay: Word read FAnimationDelay write SetAnimationDelay default DefaultSplitViewAnimationDelay;
    /// <summary>Specifies the number of pixels by which the width of the control is adjusted during each step of the
    /// opening and closing animation.</summary>
    property AnimationStep: Word read FAnimationStep write FAnimationStep default DefaultSplitViewAnimationStep;
    /// <summary>Specifies the appearance of the control when closed.
    /// svcCollapse - The TSplitView is completely hidden.
    /// svcCompact -  A smaller potion of the TSplitView remains visible.</summary>
    property CloseStyle: TSplitViewCloseStyle read FCloseStyle write SetCloseStyle default svcCollapse;
    /// <summary>Specifies the width of the control when closed and CloseStyle is set to svcCompact.</summary>
    property CompactWidth: Integer read FCompactWidth write SetCompactWidth default DefaultSplitViewCompactWidth;
    /// <summary>Specifies how the TSplitView appears when opened.
    /// svmDocked - The control is docked to the left or right edge of the form, and the client area is reduced by the
    ///             width of the control.
    /// svmOverlay - The control is displayed on top of the client area of the form.</summary>
    property DisplayMode: TSplitViewDisplayMode read FDisplayMode write SetDisplayMode default svmDocked;
    /// <summary>Specifies whether the TSplitView is currently open.</summary>
    property Opened: Boolean read GetOpened write SetOpened default True;
    /// <summary>Specifies the width of the TSplitView when in the opened state.</summary>
    property OpenedWidth: Integer read FOpenedWidth write SetOpenedWidth nodefault;
    /// <summary>Specifies whether the TSplitView is placed on the left or right side of the form.</summary>
    property Placement: TSplitViewPlacement read FPlacement write SetPlacement nodefault;
    /// <summary>Specifies whether the control animates the opening and closing process.</summary>
    property UseAnimation: Boolean read FUseAnimation write FUseAnimation default True;
    /// <summary>Specifies the current width of the control.</summary>
    property Width: Integer read GetWidth write SetWidth nodefault;

    /// <summary>This event occurs when the TSplitView is closed.</summary>
    property OnClosed: TNotifyEvent read FOnClosed write FOnClosed;
    /// <summary>This event occurs when the TSplitView is starting to close. This event only occurs if UseAnimation is True.</summary>
    property OnClosing: TNotifyEvent read FOnClosing write FOnClosing;
    /// <summary>This event occurs when the TSplitView is opened.</summary>
    property OnOpened: TNotifyEvent read FOnOpened write FOnOpened;
    /// <summary>This event occurs when the TSplitView is starting to open. This event only occurs if UseAnimation is True.</summary>
    property OnOpening: TNotifyEvent read FOnOpening write FOnOpening;

    // Inherited Properties & Events
    property BevelOuter default bvNone;
    property DoubleBuffered default True;
    property ParentBackground default False;
    property ParentDoubleBuffered default False;
    property UseDockManager default True;
  public
    constructor Create(AOwner: TComponent); override;

    /// <summary>Use this method to open the TSplitView.</summary>
    procedure Open;
    /// <summary>Use this method to close the TSplitView. If CloseStyle is set to svcCollapse, the TSplitView will be
    /// completely hidden. If CloseStyle is set to svcCompact, the width of the TSplitView will be changed to the
    /// CompactWidth size.</summary>
    procedure Close;

    property DockManager;
  published
  end;

  /// <summary>
  /// TSplitView implements a container that can be opened and closed. When opened, the TSplitView can be docked to
  /// the left or right edge of the form, or it can be displayed on top of the form's client area. When closed, the
  /// TSplitView can be completely hidden (CloseStyle := svcCollapse), or a smaller portion of the split view can
  /// remain visible (CloseStyle := svcCompact).
  /// </summary>
  TSplitView = class(TCustomSplitView)
  published
    // Inherited Properties & Events
    property AnimationDelay;
    property AnimationStep;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property CloseStyle;
    property Color;
    property CompactWidth;
    property Constraints;
    property DisplayMode;
    property UseDockManager;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Locked;
    property Opened;
    property OpenedWidth;
    property Padding;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property Placement;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property UseAnimation;
    property Visible;
    property Width;
    property StyleElements;

    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnCanResize;
    property OnClick;
    property OnClosed;
    property OnClosing;
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
    property OnExit;
    property OnGesture;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnOpened;
    property OnOpening;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

implementation

uses
  System.Types,
  System.Math,
  Vcl.ActnList,
  Vcl.Themes,
  Vcl.Forms,
  Vcl.Consts,
  Vcl.ImgList,
  Winapi.CommCtrl;

{$R WinXCtrls.res}

{ Support Methods }

procedure DrawParentImage(Control: TControl; DC: HDC; InvalidateParent: Boolean = False);
var
  SaveIndex: Integer;
  P: TPoint;
begin
  if Control.Parent = nil then
    Exit;
  SaveIndex := SaveDC(DC);
  GetViewportOrgEx(DC, P);

  SetViewportOrgEx(DC, P.X - Control.Left, P.Y - Control.Top, nil);
  IntersectClipRect(DC, 0, 0, Control.Parent.ClientWidth, Control.Parent.ClientHeight);

  Control.Parent.Perform(WM_ERASEBKGND, DC, 0);
  Control.Parent.Perform(WM_PRINTCLIENT, DC, prf_Client);

  RestoreDC(DC, SaveIndex);

  if InvalidateParent then
  begin
    if not (Control.Parent is TCustomControl) and not (Control.Parent is TCustomForm) and
       not (csDesigning in Control.ComponentState) then
    begin
      Control.Parent.Invalidate;
    end;
  end;
end;

{ TCustomActivityIndicator Methods }

constructor TCustomActivityIndicator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque];
  FFrameSize := 32;
  Height := FFrameSize;
  Width := FFrameSize;

  FFrameDelay := DefaultActivityIndicatorFrameDelay;

  FFrameList := TImageList.Create(nil);
  FFrameList.ColorDepth := cd32Bit;
  FFrameList.DrawingStyle := dsTransparent;

  FFrameBitmap := TBitmap.Create;
  FFrameBitmap.PixelFormat := pf32bit;

  FTimer := TTimer.Create(Self);
  FTimer.Interval := FFrameDelay;
  FTimer.Enabled := False;
  FTimer.OnTimer := TimerExpired;

  FIndicatorColor := aicBlack;
  FIndicatorSize := aisMedium;
  FIndicatorType := aitMomentumDots;
  FLoadedFrames := False;
end;

destructor TCustomActivityIndicator.Destroy;
begin
  FTimer.Free;
  FFrameBitmap.Free;
  FFrameList.Free;
  inherited;
end;

procedure TCustomActivityIndicator.ReloadFrames;
var
  Png: TPngImage;
  Bmp: TBitmap;
  ResourceName: string;
const
  ColorName: array [TActivityIndicatorColor] of string = ('BLACK_', 'WHITE_');
  SizeName: array [TActivityIndicatorSize] of string = ('24', '32', '48', '64');
  TypeName: array [TActivityIndicatorType] of string = ('MOMENTUMDOTS_', 'ROTATINGSECTOR_', 'SECTORRING_');
begin
  ResourceName := 'WINXCTRLS_' + TypeName[FIndicatorType] +
                  ColorName[FIndicatorColor] + SizeName[FIndicatorSize];

  Png := TPngImage.Create;
  try
    Bmp := TBitmap.Create;
    try
      Png.LoadFromResourceName(HInstance, ResourceName);
      FFrameSize := Png.Height;
      FFrameCount := Png.Width div FFrameSize;
      FFrameBitmap.SetSize(FFrameSize, FFrameSize);

      FFrameList.Width := FFrameSize;
      FFrameList.Height := FFrameSize;

      Bmp.Assign(Png);
      FFrameList.Clear;
      FFrameList.Add(Bmp, nil);
    finally
      Bmp.Free;
    end;
  finally
    Png.Free;
  end;
  FLoadedFrames := True;
end;

procedure TCustomActivityIndicator.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
  if (Parent <> nil) and Parent.DoubleBuffered then
    PerformEraseBackground(Self, Msg.DC);
  DrawParentImage(Self, Msg.DC, True);
  Msg.Result := 1;
end;

procedure TCustomActivityIndicator.DrawFrame;
begin
  if (FFrameSize <= 0) or not FLoadedFrames then
    Exit;

  if (Parent <> nil) and Parent.DoubleBuffered then
    PerformEraseBackground(Self, FFrameBitmap.Canvas.Handle);
  DrawParentImage(Self, FFrameBitmap.Canvas.Handle);

  if FAnimate then
    FFrameList.Draw(FFrameBitmap.Canvas, 0, 0, FFrameIndex);
  Canvas.Draw(0, 0, FFrameBitmap);
end;

procedure TCustomActivityIndicator.Paint;
begin
  inherited;

  if csDesigning in ComponentState then
  begin
    Canvas.Pen.Style := psDot;
    Canvas.Brush.Style := bsClear;
    Canvas.Rectangle(ClientRect);
  end
  else
    DrawFrame;
end;

procedure TCustomActivityIndicator.TimerExpired(Sender: TObject);
begin
  try
    FTimer.Interval := FFrameDelay;
    if FFrameIndex >= FFrameCount then
      FFrameIndex := 0;

    DrawFrame;

    Inc(FFrameIndex);
    if FFrameIndex = FFrameCount then
      FFrameIndex := 0;
  except
    Animate := False;
    raise;
  end;
end;

procedure TCustomActivityIndicator.StartAnimation;
begin
  Animate := True;
end;

procedure TCustomActivityIndicator.StopAnimation;
begin
  Animate := False;
end;

procedure TCustomActivityIndicator.SetAnimate(Value: Boolean);
begin
  FAnimate := Value;

  if FAnimate then
  begin
    FFrameIndex := 0;
    if not FLoadedFrames then
      ReloadFrames
  end
  else
    DrawFrame;

  FTimer.Enabled := FAnimate;
end;

procedure TCustomActivityIndicator.SetFrameDelay(Value: Word);
begin
  if FFrameDelay <> Value then
  begin
    FFrameDelay := Value;
    FTimer.Interval := FFrameDelay;
  end;
end;

procedure TCustomActivityIndicator.SetIndicatorColor(Value: TActivityIndicatorColor);
var
  SaveAnimate: Boolean;
begin
  if FIndicatorColor <> Value then
  begin
    FIndicatorColor := Value;
    SaveAnimate := Animate;
    Animate := False;
    ReloadFrames;
    Animate := SaveAnimate;
  end;
end;

procedure TCustomActivityIndicator.SetIndicatorSize(Value: TActivityIndicatorSize);
var
  SaveAnimate: Boolean;
begin
  if FIndicatorSize <> Value then
  begin
    FIndicatorSize := Value;
    SaveAnimate := Animate;
    Animate := False;
    ReloadFrames;
    Resize;
    Animate := SaveAnimate;
  end;
end;

procedure TCustomActivityIndicator.SetIndicatorType(Value: TActivityIndicatorType);
var
  SaveAnimate: Boolean;
begin
  if FIndicatorType <> Value then
  begin
    FIndicatorType := Value;
    SaveAnimate := Animate;
    Animate := False;
    ReloadFrames;
    Animate := SaveAnimate;
  end;
end;

procedure TCustomActivityIndicator.Resize;
begin
  inherited;
  SetBounds(Left, Top, FFrameSize, FFrameSize);
end;

{ TToggleSwitchStateCaptions Methods }

constructor TToggleSwitchStateCaptions.Create(ToggleSwitch: TCustomToggleSwitch);
begin
  inherited Create;
  FToggleSwitch := ToggleSwitch;
  FCaptionOn := SToggleSwitchCaptionOn;
  FCaptionOff := SToggleSwitchCaptionOff;
end;

procedure TToggleSwitchStateCaptions.SetCaptionOn(const Value: string);
begin
  FCaptionOn := Value;
  if FCaptionOn = '' then
    FCaptionOn := SToggleSwitchCaptionOn;
  if FToggleSwitch.AutoSize then
    FToggleSwitch.AdjustBounds;
  FToggleSwitch.Invalidate;
end;

function TToggleSwitchStateCaptions.IsCaptionOnStored: Boolean;
begin
  Result := FCaptionOn <> SToggleSwitchCaptionOn;
end;

procedure TToggleSwitchStateCaptions.SetCaptionOff(const Value: string);
begin
  FCaptionOff := Value;
  if FCaptionOff = '' then
    FCaptionOff := SToggleSwitchCaptionOff;
  if FToggleSwitch.AutoSize then
    FToggleSwitch.AdjustBounds;
  FToggleSwitch.Invalidate;
end;

function TToggleSwitchStateCaptions.IsCaptionOffStored: Boolean;
begin
  Result := FCaptionOff <> SToggleSwitchCaptionOff;
end;

{ TToggleSwitchActionLink Methods }

procedure TToggleSwitchActionLink.AssignClient(AClient: TObject);
begin
  inherited;
  FClient := AClient as TToggleSwitch;
end;

function TToggleSwitchActionLink.IsCheckedLinked: Boolean;
begin
  Result := inherited IsCheckedLinked and
            ((FClient.State = tssOn) = (Action as TCustomAction).Checked);
end;

procedure TToggleSwitchActionLink.SetChecked(Value: Boolean);
begin
  if IsCheckedLinked then
  begin
    FClient.FClicksDisabled := True;
    try
      if Value then
        FClient.State := tssOn
      else
        FClient.State := tssOff;
    finally
      FClient.FClicksDisabled := False;
    end;
  end;
end;

{ TCustomToggleSwitch Methods }

constructor TCustomToggleSwitch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := DefaultToggleSwitchWidth;
  Height := DefaultToggleSwitchHeight;
  TabStop := True;
  ControlStyle := [csCaptureMouse, csParentBackground];

  FStateCaptions := TToggleSwitchStateCaptions.Create(Self);
  FBackgroundBmp := TBitmap.Create;
  FUsingMouse := False;

  FDoubleBuffered := True;
  FAlignment := taRightJustify;
  FAutoSize := True;
  FReadOnly := False;
  FState := tssOff;
  FShowStateCaption := True;

  FSwitchWidth := DefaultSwitchWidth;
  FSwitchHeight := DefaultSwitchHeight;
  FThumbWidth := DefaultSwitchThumbWidth;

  ParentColor := False;
  Color := clWindow;
  FDisabledColor := DefaultToggleSwitchDisabledColor;
  FFrameColor := DefaultToggleSwitchFrameColor;
  FThumbColor := DefaultToggleSwitchThumbColor;
end;

destructor TCustomToggleSwitch.Destroy;
begin
  FBackgroundBmp.Free;
  FStateCaptions.Free;
  inherited;
end;

procedure TCustomToggleSwitch.CreateWnd;
begin
  inherited;
  AdjustBounds;
end;

procedure TCustomToggleSwitch.Loaded;
begin
  inherited;
  AdjustBounds;
end;

procedure TCustomToggleSwitch.AdjustBounds;
var
  DC: HDC;
  X, W, H, WidthOff, WidthOn: Integer;
  R, CalcRect, CalcRectOff, CalcRectOn: TRect;
begin
  if HandleAllocated and not(csReading in ComponentState) and FAutoSize then
  begin
    R := ClientRect;

    if FShowStateCaption then
    begin
      Dec(R.Right, FSwitchWidth + 4);  // R holds rectangle for caption

      if R.Right - R.Left < 2 then
        R.Right := R.Left + 2;

      DC := GetDC(0);
      try
        Canvas.Handle := DC;
        Canvas.Font := Self.Font;
        CalcRectOff := R;
        DrawText(Canvas.Handle, FStateCaptions.CaptionOff, -1, CalcRectOff, dt_CalcRect or dt_ExpandTabs);
        WidthOff := CalcRectOff.Right - CalcRectOff.Left;

        CalcRectOn := R;
        DrawText(Canvas.Handle, FStateCaptions.CaptionOn, -1, CalcRectOn, dt_CalcRect or dt_ExpandTabs);
        WidthOn := CalcRectOn.Right - CalcRectOn.Left;

        if WidthOff > WidthOn then
        begin
          W := WidthOff;
          CalcRect := CalcRectOff;
        end
        else
        begin
          W := WidthOn;
          CalcRect := CalcRectOn;
        end;

        Canvas.Handle := 0;
      finally
        ReleaseDC(0, DC);
      end;

      Inc(W, 2);
      H := Max(FSwitchHeight, CalcRect.Bottom - CalcRect.Top + 2);
      if (FAlignment = taRightJustify) xor UseRightToLeftAlignment then
        X := Left
      else
        X := BoundsRect.Right - W - FSwitchWidth - 4;

      SetBounds(X, Top, W + FSwitchWidth + 4, H);
    end
    else // No caption
    begin
      if (FAlignment = taRightJustify) xor UseRightToLeftAlignment then
        SetBounds(Left, Top, FSwitchWidth, FSwitchHeight)
      else
        SetBounds(BoundsRect.Right - FSwitchWidth, Top, FSwitchWidth, FSwitchHeight);
    end;
  end;
end;

procedure TCustomToggleSwitch.ChangeScale(M, D: Integer; isDpiChange: Boolean);
begin
  inherited ChangeScale(M, D, isDpiChange);
  if StyleServices.Enabled and (M <> D) then
  begin
    FSwitchWidth := MulDiv(FSwitchWidth, M, D) - 1;
    if FSwitchWidth <= 0 then
      FSwitchWidth := 1;

    FSwitchHeight := MulDiv(FSwitchHeight, M, D) - 1;
    if FSwitchHeight <= 0 then
      FSwitchHeight := 1;
  end;
end;

function TCustomToggleSwitch.GetControlsAlignment: TAlignment;
begin
  if not UseRightToLeftAlignment then
    Result := taRightJustify
  else if FAlignment = taRightJustify then
    Result := taLeftJustify
  else
    Result := taRightJustify;
end;

procedure TCustomToggleSwitch.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited;

  if Sender is TCustomAction then
  begin
    if not CheckDefaults or (Self.State = tssOff) then
    begin
      if TCustomAction(Sender).Checked then
        Self.State := tssOn
      else
        Self.State := tssOff;
    end;
  end;
end;

function TCustomToggleSwitch.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TToggleSwitchActionLink;
end;

procedure TCustomToggleSwitch.GetGlyphPosition(var X, Y: Integer);
begin
  if (FAlignment = taRightJustify) xor UseRightToLeftAlignment then
    X := 0
  else
    X := Width - FSwitchWidth;

  Y := (Height - FSwitchHeight) div 2;
end;

procedure TCustomToggleSwitch.UpdateDisplay;
begin
  Paint;
end;

procedure TCustomToggleSwitch.RepaintDisplay;
begin
  Repaint;
end;

function TCustomToggleSwitch.GetActiveStateCaption: string;
begin
  if FState = tssOff then
    Result := FStateCaptions.CaptionOff
  else
    Result := FStateCaptions.CaptionOn;
end;

procedure TCustomToggleSwitch.DrawSwitch(Canvas: TCanvas);
var
  R: TRect;
  X, Y: Integer;
  Details: TThemedElementDetails;
begin
  if Canvas = nil then
    Canvas := Self.Canvas;

  if FShowStateCaption then
  begin
    GetGlyphPosition(X, Y);
    R := Bounds(X, Y, FSwitchWidth, FSwitchHeight);
  end
  else
    R := ClientRect;

  if TStyleManager.IsCustomStyleActive then
  begin
    // Draw Track
    case FState of
      tssOff:
        begin
          if Enabled then
            Details := StyleServices.GetElementDetails(ttsTrackOffNormal)
          else
            Details := StyleServices.GetElementDetails(ttsTrackOffDisabled);
        end;

      tssOn:
        begin
          if Enabled then
            Details := StyleServices.GetElementDetails(ttsTrackOnNormal)
          else
            Details := StyleServices.GetElementDetails(ttsTrackOnDisabled);
        end;
    end;

    StyleServices.DrawElement(Canvas.Handle, Details, R);

    // Draw Thumb
    if Enabled then
      Details := StyleServices.GetElementDetails(ttsThumbNormal)
    else
      Details := StyleServices.GetElementDetails(ttsThumbDisabled);
    if FState = tssOff then
      R.Right := R.Left + FThumbWidth
    else
      R.Left := R.Right - FThumbWidth;
    StyleServices.DrawElement(Canvas.Handle, Details, R);
  end
  else // No Styles
  begin
    Canvas.Brush.Color := Self.Color;
    if Enabled then
      Canvas.Pen.Color := FFrameColor
    else
      Canvas.Pen.Color := FDisabledColor;

    Canvas.Pen.Width := 2;
    Canvas.Rectangle(R.Left + 1, R.Top + 1, R.Right, R.Bottom);
    InflateRect(R, -3, -3);

    if FState = tssOff then
      R.Right := R.Left + FThumbWidth
    else
      R.Left := R.Right - FThumbWidth;

    if Enabled then
      Canvas.Brush.Color := FThumbColor
    else
      Canvas.Brush.Color := FDisabledColor;
    Canvas.FillRect(R);
  end;
end;

procedure TCustomToggleSwitch.Paint;
var
  R: TRect;
  W: Integer;
  MemImage: TBitmap;
  TextFormat: TTextFormat;
  TextColor: TColor;
  Flags: UINT;
begin
  if csDestroying in ComponentState then
    Exit;

  MemImage := TBitmap.Create;
  try
    // Make memory Bitmap same size as client rect
    MemImage.Height := Height;
    MemImage.Width := Width;

    MemImage.Canvas.Font := Font;

    // Paint the background
    if StyleServices.Enabled then
    begin
      if not DoubleBuffered then
      begin
        FBackgroundBmp.Width := Width;
        FBackgroundBmp.Height := Height;
        DrawParentImage(Self, FBackgroundBmp.Canvas.Handle);
      end;

      MemImage.Canvas.CopyRect(ClientRect, FBackgroundBmp.Canvas, ClientRect);
    end
    else
    begin
      MemImage.Canvas.Brush.Color := Color;
      MemImage.Canvas.FillRect(ClientRect);
    end;

    // Paint the Switch in the correct state

    DrawSwitch(MemImage.Canvas);

    // Paint the Caption and Focus Rect if necessary

    if FShowStateCaption then
    begin
      R := ClientRect;
      InflateRect(R, -1, -1);
      if (FAlignment = taRightJustify) xor UseRightToLeftAlignment then
        Inc(R.Left, FSwitchWidth + 4)
      else
        Dec(R.Right, FSwitchWidth + 4);

      if TStyleManager.IsCustomStyleActive then
      begin
        if UseRightToLeftAlignment then
          TextFormat := [tfRight, tfVerticalCenter]
        else
          TextFormat := [tfLeft, tfVerticalCenter];

        TextFormat := TextFormat + [tfExpandTabs];

        if not StyleServices.GetElementColor(StyleServices.GetElementDetails(tbCheckBoxUncheckedNormal),
          ecTextColor, TextColor) then
        begin
          if Enabled then
            TextColor := StyleServices.GetSystemColor(clBtnText)
          else
            TextColor := StyleServices.GetSystemColor(clGrayText);
        end;

        StyleServices.DrawText(MemImage.Canvas.Handle, StyleServices.GetElementDetails(tbCheckBoxUncheckedNormal),
          GetActiveStateCaption, R, TextFormat, TextColor);
      end
      else // No Styles
      begin
        if UseRightToLeftAlignment then
          Flags := dt_Right or dt_VCenter or dt_SingleLine
        else
          Flags := dt_Left or dt_VCenter or dt_SingleLine;

        MemImage.Canvas.Brush.Style := bsClear;
        if not Enabled then
          MemImage.Canvas.Font.Color := clGrayText;
        DrawText(MemImage.Canvas.Handle, PChar(GetActiveStateCaption), -1, R, Flags);
        MemImage.Canvas.Brush.Style := bsSolid;
      end;

      InflateRect(R, 1, 1);
      if ShowFocus and Focused and (GetActiveStateCaption <> '') then
      begin
        W := R.Right - R.Left;

        if not UseRightToLeftAlignment then
          R.Right := R.Left + W
        else
          R.Left := R.Right - W;

        if StyleServices.Enabled then
          MemImage.Canvas.Brush.Color := StyleServices.GetSystemColor(clBtnFace)
        else
          MemImage.Canvas.Brush.Color := Self.Color;
        MemImage.Canvas.DrawFocusRect(R);
      end;
    end; { FShowStateCaption }

    Canvas.CopyMode := cmSrcCopy;
    Canvas.Draw(0, 0, MemImage);

  finally
    MemImage.Free;
  end;
end; { = TCustomToggleSwitch.Paint = }

procedure TCustomToggleSwitch.DoExit;
begin
  inherited;
  UpdateDisplay;
end;

procedure TCustomToggleSwitch.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if FReadOnly then
    Exit;
  if Key = vk_Escape then
  begin
    FKeyToggle := False;
    UpdateDisplay;
  end
  else if Key = vk_Space then
  begin
    FKeyToggle := True;
    UpdateDisplay;
  end;
end;

procedure TCustomToggleSwitch.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if FReadOnly then
    Exit;
  if Key = vk_Space then
  begin
    if FKeyToggle then
      ChangeState;
    UpdateDisplay;
  end;
end;

procedure TCustomToggleSwitch.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if (Button = mbLeft) and Enabled then
  begin
    // Cannot call SetFocus method b/c if the control is active, it will not
    // change the focus back to this control. This can happen if a dialog is
    // displayed as a result of the clicking the button and the button is
    // disabled.
    Winapi.Windows.SetFocus(Handle);

    if Focused then
    begin
      UpdateDisplay;
      FUsingMouse := True;
    end;
  end;
end;

procedure TCustomToggleSwitch.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Pt: TPoint;
begin
  inherited;

  if FUsingMouse then
  begin
    Pt := Point(X, Y);
    if PtInRect(Rect(0, 0, ClientWidth, ClientHeight), Pt) then
    begin
      ChangeState;
    end;
    FUsingMouse := False;
    UpdateDisplay;
  end;
end;

procedure TCustomToggleSwitch.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
var
  W, H: Integer;
  R: TRect;
begin
  if (Parent <> nil) and Parent.DoubleBuffered then
    PerformEraseBackground(Self, Msg.DC);
  DrawParentImage(Self, Msg.DC, True);

  GetWindowRect(Handle, R);
  W := R.Right - R.Left;
  H := R.Bottom - R.Top;
  FBackgroundBmp.Width := W;
  FBackgroundBmp.Height := H;
  BitBlt(FBackgroundBmp.Canvas.Handle, 0, 0, W, H, Msg.DC, 0, 0, cmSrcCopy);

  Msg.Result := 1;
end;

procedure TCustomToggleSwitch.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  // When control gets focus, update display to show focus border
  RepaintDisplay;
end;

procedure TCustomToggleSwitch.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  // When control loses focus, update display to remove focus border
  RepaintDisplay;
end;

procedure TCustomToggleSwitch.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomToggleSwitch.CMColorChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomToggleSwitch.CMParentColorChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomToggleSwitch.CMTextChanged(var Msg: TMessage);
begin
  inherited;
  AdjustBounds;
end;

procedure TCustomToggleSwitch.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  AdjustBounds;
end;

function TCustomToggleSwitch.ShowFocus: Boolean;
begin
  Result := (Perform(WM_QUERYUISTATE, 0, 0) and UISF_HIDEFOCUS) = 0;
end;

procedure TCustomToggleSwitch.Click;
begin
  inherited Changed;
  inherited Click;
end;

procedure TCustomToggleSwitch.ChangeState;
begin
  if FUsingMouse and FReadOnly then
    Exit;
  case State of
    tssOff: State := tssOn;
    tssOn:  State := tssOff;
  end;
end;

procedure TCustomToggleSwitch.SetAlignment(Value: TLeftRight);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TCustomToggleSwitch.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustBounds;
  end;
end;

procedure TCustomToggleSwitch.SetDisabledColor(Value: TColor);
begin
  if FDisabledColor <> Value then
  begin
    FDisabledColor := Value;
    if FDisabledColor = clNone then
      FDisabledColor := DefaultToggleSwitchDisabledColor;
    Invalidate;
  end;
end;

procedure TCustomToggleSwitch.SetFrameColor(Value: TColor);
begin
  if FFrameColor <> Value then
  begin
    FFrameColor := Value;
    if FFrameColor = clNone then
      FFrameColor := DefaultToggleSwitchFrameColor;
    Invalidate;
  end;
end;

function TCustomToggleSwitch.IsOn: Boolean;
begin
  Result := FState = tssOn;
end;

procedure TCustomToggleSwitch.SetState(Value: TToggleSwitchState);
begin
  if FState <> Value then
  begin
    FState := Value;
    Invalidate;
    if not FClicksDisabled then
      Click;
  end;
end;

function TCustomToggleSwitch.IsStateStored: Boolean;
begin
  Result := (ActionLink = nil) or not TToggleSwitchActionLink(ActionLink).IsCheckedLinked;
end;

procedure TCustomToggleSwitch.SetShowStateCaption(Value: Boolean);
begin
  if FShowStateCaption <> Value then
  begin
    FShowStateCaption := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TCustomToggleSwitch.SetStateCaptions(Value: TToggleSwitchStateCaptions);
begin
  FStateCaptions.Assign( Value );
end;

procedure TCustomToggleSwitch.SetSwitchHeight(Value: Integer);
begin
  if FSwitchHeight <> Value then
  begin
    FSwitchHeight := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TCustomToggleSwitch.SetSwitchWidth(Value: Integer);
begin
  if FSwitchWidth <> Value then
  begin
    FSwitchWidth := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TCustomToggleSwitch.SetThumbColor(Value: TColor);
begin
  if FThumbColor <> Value then
  begin
    FThumbColor := Value;
    if FThumbColor = clNone then
      FThumbColor := DefaultToggleSwitchThumbColor;
    Invalidate;
  end;
end;

procedure TCustomToggleSwitch.SetThumbWidth(Value: Integer);
begin
  if FThumbWidth <> Value then
  begin
    FThumbWidth := Value;
    Invalidate;
  end;
end;

{ TSearchBoxStyleHook Methods }

constructor TSearchBoxStyleHook.Create(AControl: TWinControl);
begin
  inherited;
end;

procedure TSearchBoxStyleHook.WMNCCalcSize(var Msg: TWMNCCalcSize);
var
  W: Integer;
begin
  if (Control is TSearchBox) then
  begin
    W := TSearchBox(Control).ButtonWidth;

    if not Control.UseRightToLeftAlignment then
      Dec(Msg.CalcSize_Params^.rgrc[0].Right, W)
    else
      Inc(Msg.CalcSize_Params^.rgrc[0].Left, W);

    InflateRect(Msg.CalcSize_Params^.rgrc[0], -2, -2);
    Handled := True;
  end;
end;

procedure TSearchBoxStyleHook.PaintNC(Canvas: TCanvas);
var
  Details: TThemedElementDetails;
  ControlRect, EditRect, BtnRect: TRect;
  BtnWidth: Integer;
begin
  if StyleServices.Available then
  begin
    // Draw border of control
    if Control.Focused then
      Details := StyleServices.GetElementDetails(teEditBorderNoScrollFocused)
    else if MouseInControl then
      Details := StyleServices.GetElementDetails(teEditBorderNoScrollHot)
    else if Control.Enabled then
      Details := StyleServices.GetElementDetails(teEditBorderNoScrollNormal)
    else
      Details := StyleServices.GetElementDetails(teEditBorderNoScrollDisabled);

    ControlRect := Rect(0, 0, Control.Width, Control.Height);

    EditRect := ControlRect;
    InflateRect(EditRect, -2, -2);
    BtnWidth := TSearchBox(Control).ButtonWidth;
    if not Control.UseRightToLeftAlignment then
      Dec(EditRect.Right, BtnWidth)
    else
      Inc(EditRect.Left, BtnWidth);

    // Exclude the editing area
    ExcludeClipRect(Canvas.Handle, EditRect.Left, EditRect.Top, EditRect.Right, EditRect.Bottom);

    StyleServices.DrawElement(Canvas.Handle, Details, ControlRect);

    // Draw the button
    BtnRect := ControlRect;
    InflateRect(BtnRect, -2, -2);

    if not Control.UseRightToLeftAlignment then
      BtnRect.Left := BtnRect.Right - BtnWidth
    else
      BtnRect.Right := BtnRect.Left + BtnWidth;
    IntersectClipRect(Canvas.Handle, BtnRect.Left, BtnRect.Top, BtnRect.Right, BtnRect.Bottom);

    TSearchBox(Control).FButtonRect := BtnRect;
    TSearchBox(Control).DrawButton(Canvas);
  end;
end;

{ TSearchBox Methods }

class constructor TSearchBox.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TSearchBox, TSearchBoxStyleHook);
end;

class destructor TSearchBox.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TSearchBox, TSearchBoxStyleHook);
end;

constructor TSearchBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;

  FTextIndicatorImages := TImageList.Create(nil);
  FTextIndicatorImages.ColorDepth := cd32Bit;
  FTextIndicatorImages.DrawingStyle := dsTransparent;

  FAudioIndicatorImages := TImageList.Create(nil);
  FAudioIndicatorImages.ColorDepth := cd32Bit;
  FAudioIndicatorImages.DrawingStyle := dsTransparent;

  LoadImages;

  FButtonWidth := DefaultSearchButtonWidth;
  FSearchIndicator := sbiText;
end;

destructor TSearchBox.Destroy;
begin
  FCanvas.Free;
  FTextIndicatorImages.Free;
  FAudioIndicatorImages.Free;
  inherited;
end;

procedure TSearchBox.LoadImages;
var
  Png: TPngImage;
  Bmp: TBitmap;
begin
  Png := TPngImage.Create;
  try
    Bmp := TBitmap.Create;
    try
      Png.LoadFromResourceName(HInstance, 'WINXCTRLS_SEARCHINDICATORS_TEXT');
      FTextIndicatorImages.Width := Png.Width div 4;
      FTextIndicatorImages.Height := Png.Height;
      Bmp.Assign(Png);
      FTextIndicatorImages.Add(Bmp, nil);

      Png.LoadFromResourceName(HInstance, 'WINXCTRLS_SEARCHINDICATORS_AUDIO');
      FAudioIndicatorImages.Width := Png.Width div 4;
      FAudioIndicatorImages.Height := Png.Height;
      Bmp.Assign(Png);
      FAudioIndicatorImages.Add(Bmp, nil);
    finally
      Bmp.Free;
    end;
  finally
    Png.Free;
  end;
end;

procedure TSearchBox.SetButtonWidth(Value: Integer);
begin
  if FButtonWidth <> Value then
  begin
    FButtonWidth := Value;
    RecreateWnd;
  end;
end;

procedure TSearchBox.SetSearchIndicator(Value: TSearchBoxIndicator);
begin
  if FSearchIndicator <> Value then
  begin
    FSearchIndicator := Value;
    RecreateWnd;
  end;
end;

procedure TSearchBox.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  RepaintButton;
end;

procedure TSearchBox.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  FMouseOverButton := False;
end;

procedure TSearchBox.WMNCPaint(var Msg: TWMNCPaint);
var
  DC: HDC;
begin
  inherited;

  DC := GetWindowDC(Handle);
  FCanvas.Handle := DC;
  try
    GetWindowRect(Handle, FButtonRect);
    OffsetRect(FButtonRect, -FButtonRect.Left, -FButtonRect.Top);

    InflateRect(FButtonRect, -2, -2);
    if not UseRightToLeftAlignment then
      FButtonRect.Left := FButtonRect.Right - FButtonWidth
    else
      FButtonRect.Right := FButtonRect.Left + FButtonWidth;
    IntersectClipRect(FCanvas.Handle, FButtonRect.Left, FButtonRect.Top, FButtonRect.Right, FButtonRect.Bottom);

    DrawButton(FCanvas);
    Msg.Result := 0;
  finally
    FCanvas.Handle := 0;
    ReleaseDC(Handle, DC);
  end;
end;

procedure TSearchBox.MouseCancel;
begin
  if GetCapture = Handle then
    ReleaseCapture;

  FButtonDown := False;
  RepaintButton;
end;

procedure TSearchBox.InvokeSearch;
begin
  if Assigned(FOnInvokeSearch) then
    FOnInvokeSearch(Self);
end;

procedure TSearchBox.KeyPress(var Key: Char);
begin
  inherited;
  if (Ord(Key) = vk_Return) and (FSearchIndicator = sbiText) then
  begin
    Key := #0;
    InvokeSearch;
  end;
end;

procedure TSearchBox.WMNCHitTest(var Msg: TMessage);
begin
  inherited;

  if Msg.Result = Winapi.Windows.HTNOWHERE then
  begin
    FMouseOverButton := True;
    Msg.Result := HTCLIENT;
  end
  else
    FMouseOverButton := False;
end;

procedure TSearchBox.WMNCCalcSize(var Msg: TWMNCCalcSize);
begin
  if not UseRightToLeftAlignment then
    Dec(Msg.CalcSize_Params^.rgrc[0].Right, FButtonWidth)
  else
    Inc(Msg.CalcSize_Params^.rgrc[0].Left, FButtonWidth);
  inherited;
end;

procedure TSearchBox.RepaintButton;
begin
  if HandleAllocated then
    SendMessage(Handle, WM_NCPAINT, 0, 0);
end;

procedure TSearchBox.DrawButton(Canvas: TCanvas);
var
  ElementDetails: TThemedElementDetails;
  ImageIndex: Integer;
  C: TColor;
begin
  if TStyleManager.IsCustomStyleActive then
  begin
    if StyleServices.IsSystemStyle then
      Canvas.Brush.Color := Color
    else
      Canvas.Brush.Color := StyleServices.GetStyleColor(scEdit);
    Canvas.FillRect(FButtonRect);

    case FSearchIndicator of
      sbiText:
        begin
          if not Enabled then
            ElementDetails := StyleServices.GetElementDetails(tsiTextDisabled)
          else if FButtonDown then
            ElementDetails := StyleServices.GetElementDetails(tsiTextPressed)
          else if FMouseOverButton then
            ElementDetails := StyleServices.GetElementDetails(tsiTextHot)
          else
            ElementDetails := StyleServices.GetElementDetails(tsiTextNormal);

          StyleServices.DrawElement(Canvas.Handle, ElementDetails, FButtonRect);
        end;

      sbiAudio:
        begin
          if not Enabled then
            ElementDetails := StyleServices.GetElementDetails(tsiAudioDisabled)
          else if FButtonDown then
            ElementDetails := StyleServices.GetElementDetails(tsiAudioPressed)
          else if FMouseOverButton then
            ElementDetails := StyleServices.GetElementDetails(tsiAudioHot)
          else
            ElementDetails := StyleServices.GetElementDetails(tsiAudioNormal);

          StyleServices.DrawElement(Canvas.Handle, ElementDetails, FButtonRect);
        end;
    end;
  end
  else // No Styles
  begin
    C := Self.Color;
    if not Enabled then
      ImageIndex := 3
    else if FButtonDown then
    begin
      ImageIndex := 2;
      C := clBtnShadow;
    end
    else if FMouseOverButton then
    begin
      ImageIndex := 1;
      C := clBtnFace;
    end
    else
      ImageIndex := 0;

    Canvas.Brush.Color := C;
    Canvas.FillRect(FButtonRect);
    case FSearchIndicator of
      sbiText:
        FTextIndicatorImages.Draw(Canvas, FButtonRect.Left, FButtonRect.Top, ImageIndex);

      sbiAudio:
        FAudioIndicatorImages.Draw(Canvas, FButtonRect.Left, FButtonRect.Top, ImageIndex);
    end;
  end;
end;

procedure TSearchBox.WMKillFocus(var Msg: TMessage);
begin
  inherited;
  MouseCancel;
end;

procedure TSearchBox.WMLButtonDown(var Msg: TMessage);
begin
  if FMouseOverButton then
  begin
    if not Focused then
      SetFocus;
    FButtonDown := True;
    RepaintButton;
    SetCapture(Handle);
    Msg.Result := 0;
  end
  else
  begin
    inherited;
    if not Focused then
      MouseCancel;
  end;
end;

procedure TSearchBox.WMLButtonUp(var Msg: TWMLButtonUp);
var
  P: TPoint;
  R: TRect;
begin
  MouseCancel;
  inherited;

  P := Msg.Pos;
  R := FButtonRect;
  if UseRightToLeftAlignment then
  begin
    R.Left := 0;
    P.X := R.Right + P.X;
  end;
  if PtInRect(R, P) then
    InvokeSearch;
end;

procedure TSearchBox.WMLButtonDblClk(var Msg: TMessage);
begin
  if FMouseOverButton then
    WMLButtonDown(Msg)
  else
    inherited;
end;

procedure TSearchBox.WMRButtonDown(var Msg: TMessage);
begin
  if FMouseOverButton then
    Msg.Result := 0
  else
    inherited;
end;

procedure TSearchBox.WMSetCursor(var Msg: TWMSetCursor);
begin
  if FMouseOverButton then
    Msg.HitTest := Winapi.Windows.HTNOWHERE;

  inherited;
end;

{ TRelativePanelControlItem Methods }

constructor TRelativePanelControlItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TRelativePanelControlItem.Destroy;
var
  C: TControl;
begin
  if Assigned(FControl) and
     not (csLoading in RelativePanel.ComponentState) and
     not (csUpdating in RelativePanel.ComponentState) and
     not (csDestroying in RelativePanel.ComponentState) then
  begin
    C := FControl;
    FControl := nil;
    RelativePanel.RemoveControl(C);
    C.Free;
  end;
  inherited;
end;

procedure TRelativePanelControlItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TRelativePanelControlItem then
  begin
    TRelativePanelControlItem(Dest).FControl := Self.Control;

    TRelativePanelControlItem(Dest).FAbove := Self.Above;
    TRelativePanelControlItem(Dest).FAlignBottomWith := Self.AlignBottomWith;
    TRelativePanelControlItem(Dest).FAlignBottomWithPanel := Self.AlignBottomWithPanel;
    TRelativePanelControlItem(Dest).FAlignHorizontalCenterWith := Self.AlignHorizontalCenterWith;
    TRelativePanelControlItem(Dest).FAlignHorizontalCenterWithPanel := Self.AlignHorizontalCenterWithPanel;
    TRelativePanelControlItem(Dest).FAlignLeftWith := Self.AlignLeftWith;
    TRelativePanelControlItem(Dest).FAlignLeftWithPanel := Self.AlignLeftWithPanel;
    TRelativePanelControlItem(Dest).FAlignRightWith := Self.AlignRightWith;
    TRelativePanelControlItem(Dest).FAlignRightWithPanel := Self.AlignRightWithPanel;
    TRelativePanelControlItem(Dest).FAlignTopWith := Self.AlignTopWith;
    TRelativePanelControlItem(Dest).FAlignTopWithPanel := Self.AlignTopWithPanel;
    TRelativePanelControlItem(Dest).FAlignVerticalCenterWith := Self.AlignVerticalCenterWith;
    TRelativePanelControlItem(Dest).FAlignVerticalCenterWithPanel := Self.AlignVerticalCenterWithPanel;
    TRelativePanelControlItem(Dest).FBelow := Self.Below;
    TRelativePanelControlItem(Dest).FLeftOf := Self.LeftOf;
    TRelativePanelControlItem(Dest).FRightOf := Self.RightOf;

    TRelativePanelControlItem(Dest).Changed(False);
  end;
end;

function TRelativePanelControlItem.GetDisplayName: string;
begin
  if (FControl <> nil) and (FControl.Name <> '') then
    Result := FControl.Name
  else
    Result := inherited;
end;

function TRelativePanelControlItem.GetRelativePanel: TRelativePanel;
var
  Owner: TRelativePanelControlCollection;
begin
  Owner := TRelativePanelControlCollection(GetOwner);
  if Owner <> nil then
    Result := Owner.Owner
  else
    Result := nil;
end;

procedure TRelativePanelControlItem.CheckSaveWidth;
begin
  if FSaveWidth <> 0 then
  begin
    FControl.Width := FSaveWidth;
    FSaveWidth := 0;
  end;
end;

procedure TRelativePanelControlItem.CheckSaveHeight;
begin
  if FSaveHeight <> 0 then
  begin
    FControl.Height := FSaveHeight;
    FSaveHeight := 0;
  end;
end;

procedure TRelativePanelControlItem.SetControl(Value: TControl);
begin
  if FControl <> Value then
  begin
    if Value = RelativePanel then
      raise ERelativePanelException.Create(SInvalidRelativePanelControlItem);
    FControl := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.CheckControl(Value: TControl);
begin
  if (Value <> nil) and (Value.Parent <> nil) then
  begin
    if (Value.Parent <> RelativePanel) then
      raise ERelativePanelException.Create(SInvalidRelativePanelSibling)
    else if (Value = FControl) then
      raise ERelativePanelException.Create(SInvalidRelativePanelSiblingSelf);
  end;
end;

procedure TRelativePanelControlItem.SetAbove(Value: TControl);
begin
  if FAbove <> Value then
  begin
    CheckControl(Value);
    FAbove := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetAlignBottomWith(Value: TControl);
begin
  if FAlignBottomWith <> Value then
  begin
    CheckControl(Value);
    FAlignBottomWith := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetAlignBottomWithPanel(Value: Boolean);
begin
  if FAlignBottomWithPanel <> Value then
  begin
    FAlignBottomWithPanel := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetAlignHorizontalCenterWith(Value: TControl);
begin
  if FAlignHorizontalCenterWith <> Value then
  begin
    CheckControl(Value);
    FAlignHorizontalCenterWith := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetAlignHorizontalCenterWithPanel(Value: Boolean);
begin
  if FAlignHorizontalCenterWithPanel <> Value then
  begin
    FAlignHorizontalCenterWithPanel := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetAlignLeftWith(Value: TControl);
begin
  if FAlignLeftWith <> Value then
  begin
    CheckControl(Value);
    FAlignLeftWith := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetAlignLeftWithPanel(Value: Boolean);
begin
  if FAlignLeftWithPanel <> Value then
  begin
    FAlignLeftWithPanel := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetAlignRightWith(Value: TControl);
begin
  if FAlignRightWith <> Value then
  begin
    CheckControl(Value);
    FAlignRightWith := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetAlignRightWithPanel(Value: Boolean);
begin
  if FAlignRightWithPanel <> Value then
  begin
    FAlignRightWithPanel := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetAlignTopWith(Value: TControl);
begin
  if FAlignTopWith <> Value then
  begin
    CheckControl(Value);
    FAlignTopWith := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetAlignTopWithPanel(Value: Boolean);
begin
  if FAlignTopWithPanel <> Value then
  begin
    FAlignTopWithPanel := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetAlignVerticalCenterWith(Value: TControl);
begin
  if FAlignVerticalCenterWith <> Value then
  begin
    CheckControl(Value);
    FAlignVerticalCenterWith := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetAlignVerticalCenterWithPanel(Value: Boolean);
begin
  if FAlignVerticalCenterWithPanel <> Value then
  begin
    FAlignVerticalCenterWithPanel := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetBelow(Value: TControl);
begin
  if FBelow <> Value then
  begin
    CheckControl(Value);
    FBelow := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetLeftOf(Value: TControl);
begin
  if FLeftOf <> Value then
  begin
    CheckControl(Value);
    FLeftOf := Value;
    Changed(False);
  end;
end;

procedure TRelativePanelControlItem.SetRightOf(Value: TControl);
begin
  if FRightOf <> Value then
  begin
    CheckControl(Value);
    FRightOf := Value;
    Changed(False);
  end;
end;

{ TRelativePanelControlCollection Methods }

constructor TRelativePanelControlCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TRelativePanelControlItem);
end;

function TRelativePanelControlCollection.Add: TRelativePanelControlItem;
begin
  Result := TRelativePanelControlItem(inherited Add);
end;

procedure TRelativePanelControlCollection.AddControl(AControl: TControl);
var
  Item: TRelativePanelControlItem;
begin
  if IndexOf(AControl) < 0 then
  begin
    Item := Add;
    Item.Control := AControl;
  end;
end;

procedure TRelativePanelControlCollection.RemoveControl(AControl: TControl);
var
  I: Integer;
  Item: TRelativePanelControlItem;
begin
  // Cleanup Component Reference properties of items
  for I := 0 to Count - 1 do
  begin
    Item := Items[I];
    if Item.Above = AControl then
      Item.Above := nil;
    if Item.AlignBottomWith = AControl then
      Item.AlignBottomWith := nil;
    if Item.AlignHorizontalCenterWith = AControl then
      Item.AlignHorizontalCenterWith := nil;
    if Item.AlignLeftWith = AControl then
      Item.AlignLeftWith := nil;
    if Item.AlignRightWith = AControl then
      Item.AlignRightWith := nil;
    if Item.AlignTopWith = AControl then
      Item.AlignTopWith := nil;
    if Item.AlignVerticalCenterWith = AControl then
      Item.AlignVerticalCenterWith := nil;
    if Item.Below = AControl then
      Item.Below := nil;
    if Item.LeftOf = AControl then
      Item.LeftOf := nil;
    if Item.RightOf = AControl then
      Item.RightOf := nil;
  end;

  for I := Count - 1 downto 0 do
  begin
    if Items[I].Control = AControl then
    begin
      Items[I].Control := nil;
      Delete(I);
      Exit;
    end;
  end;
end;

function TRelativePanelControlCollection.GetItem(Index: Integer): TRelativePanelControlItem;
begin
  Result := TRelativePanelControlItem(inherited GetItem(Index));
end;

function TRelativePanelControlCollection.IndexOf(AControl: TControl): Integer;
begin
  for Result := 0 to Count - 1 do
  begin
    if TRelativePanelControlItem(Items[Result]).Control = AControl then
      Exit;
  end;
  Result := -1;
end;

function TRelativePanelControlCollection.Owner: TRelativePanel;
begin
  Result := TRelativePanel(GetOwner);
end;

function TRelativePanelControlCollection.GetControl(Index: Integer): TControl;
var
  Item: TRelativePanelControlItem;
begin
  Item := Items[Index];
  if Item <> nil then
    Result := Item.Control
  else
    Result := nil;
end;

procedure TRelativePanelControlCollection.SetControl(Index: Integer; Value: TControl);
var
  Item: TRelativePanelControlItem;
begin
  if Owner <> nil then
  begin
    Item := Items[Index];
    Item.Control := Value;
  end;
end;

procedure TRelativePanelControlCollection.SetItem(Index: Integer; Value: TRelativePanelControlItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TRelativePanelControlCollection.Update(Item: TCollectionItem);
begin
  inherited;
  if Owner <> nil then
  begin
    Owner.Invalidate;
    Owner.Realign;
  end;
end;

{ TCustomRelativePanel Methods }

constructor TCustomRelativePanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption];
  FControlCollection := TRelativePanelControlCollection.Create(Self);
end;

destructor TCustomRelativePanel.Destroy;
begin
  FControlCollection.Free;
  inherited;
end;

procedure TCustomRelativePanel.AlignControls(AControl: TControl; var Rect: TRect);
var
  I, W, H: Integer;
  Item: TRelativePanelControlItem;
  ItemControl: TControl;

  procedure AlignControlToPanel;
  var
    X, Y: Integer;
  begin
    if Item.AlignLeftWithPanel then
    begin
      if Item.AlignRightWithPanel then
      begin
        Item.SaveWidth := ItemControl.Width;
        W := Rect.Width - ItemControl.Margins.Left - ItemControl.Margins.Right;
        ItemControl.SetBounds(Rect.Left + ItemControl.Margins.Left, ItemControl.Top, W, ItemControl.Height);
      end
      else
      begin
        Item.CheckSaveWidth;
        ItemControl.SetBounds(Rect.Left + ItemControl.Margins.Left, ItemControl.Top,
		                      ItemControl.Width, ItemControl.Height);
      end;
    end
    else if Item.AlignRightWithPanel then
    begin
      Item.CheckSaveWidth;
      ItemControl.SetBounds(Rect.Right - ItemControl.Width - ItemControl.Margins.Right, ItemControl.Top,
        ItemControl.Width, ItemControl.Height);
    end;

    if Item.AlignTopWithPanel then
    begin
      if Item.AlignBottomWithPanel then
      begin
        Item.SaveHeight := ItemControl.Height;
        H := Rect.Height - ItemControl.Margins.Top - ItemControl.Margins.Bottom;
        ItemControl.SetBounds(ItemControl.Left, Rect.Top + ItemControl.Margins.Top, ItemControl.Width, H);
      end
      else
        Item.CheckSaveHeight;
      ItemControl.SetBounds(ItemControl.Left, Rect.Top + ItemControl.Margins.Top, ItemControl.Width,
        ItemControl.Height);
    end
    else if Item.AlignBottomWithPanel then
    begin
      Item.CheckSaveHeight;
      ItemControl.SetBounds(ItemControl.Left, Rect.Bottom - ItemControl.Height - ItemControl.Margins.Bottom,
        ItemControl.Width, ItemControl.Height);
    end;

    if Item.AlignHorizontalCenterWithPanel then
    begin
      X := (Rect.Width - ItemControl.Width) div 2;
      ItemControl.SetBounds(X, ItemControl.Top, ItemControl.Width, ItemControl.Height);
    end;

    if Item.AlignVerticalCenterWithPanel then
    begin
      Y := (Rect.Height - ItemControl.Height) div 2;
      ItemControl.SetBounds(ItemControl.Left, Y, ItemControl.Width, ItemControl.Height);
    end;
  end; {= AlignControlToPanel =}

  procedure AlignControlToSibling;
  var
    X, Y, Margin: Integer;
    R: TRect;
  begin
    if Item.AlignLeftWith <> nil then
    begin
      if Item.AlignRightWith <> nil then
      begin
        R := Item.AlignRightWith.BoundsRect;
        W := R.Right - Item.AlignLeftWith.Left;
        ItemControl.SetBounds(Item.AlignLeftWith.Left, ItemControl.Top, W, ItemControl.Height);
      end
      else
      begin
        ItemControl.SetBounds(Item.AlignLeftWith.Left, ItemControl.Top, ItemControl.Width, ItemControl.Height);
      end;
    end
    else if Item.AlignRightWith <> nil then
    begin
      R := Item.AlignRightWith.BoundsRect;
      X := R.Right - ItemControl.Width;
      ItemControl.SetBounds(X, ItemControl.Top, ItemControl.Width, ItemControl.Height);
    end;

    if Item.AlignTopWith <> nil then
    begin
      if Item.AlignBottomWith <> nil then
      begin
        R := Item.AlignBottomWith.BoundsRect;
        H := R.Bottom - Item.AlignTopWith.Top;
        ItemControl.SetBounds(ItemControl.Left, Item.AlignTopWith.Top, ItemControl.Width, H);
      end
      else
      begin
        ItemControl.SetBounds(ItemControl.Left, Item.AlignTopWith.Top, ItemControl.Width, ItemControl.Height);
      end;
    end
    else if Item.AlignBottomWith <> nil then
    begin
      R := Item.AlignBottomWith.BoundsRect;
      Y := R.Bottom - ItemControl.Height;
      ItemControl.SetBounds(ItemControl.Left, Y, ItemControl.Width, ItemControl.Height);
    end;

    if Item.LeftOf <> nil then
    begin
      Margin := Item.LeftOf.Margins.Left + ItemControl.Margins.Right;
      ItemControl.SetBounds(Item.LeftOf.Left - ItemControl.Width - Margin, ItemControl.Top, ItemControl.Width,
        ItemControl.Height);
    end
    else if Item.RightOf <> nil then
    begin
      Margin := Item.RightOf.Margins.Right + ItemControl.Margins.Left;
      ItemControl.SetBounds(Item.RightOf.BoundsRect.Right + Margin, ItemControl.Top, ItemControl.Width,
        ItemControl.Height);
    end;

    if Item.Above <> nil then
    begin
      Margin := Item.Above.Margins.Top + ItemControl.Margins.Bottom;
      ItemControl.SetBounds(ItemControl.Left, Item.Above.Top - ItemControl.Height - Margin, ItemControl.Width,
        ItemControl.Height);
    end
    else if Item.Below <> nil then
    begin
      Margin := Item.Below.Margins.Bottom + ItemControl.Margins.Top;
      ItemControl.SetBounds(ItemControl.Left, Item.Below.BoundsRect.Bottom + Margin, ItemControl.Width,
        ItemControl.Height);
    end;

    if Item.AlignHorizontalCenterWith <> nil then
    begin
      R := Item.AlignHorizontalCenterWith.BoundsRect;
      X := R.Left + (R.Width div 2);
      ItemControl.SetBounds(X - (ItemControl.Width div 2), ItemControl.Top, ItemControl.Width, ItemControl.Height);
    end;

    if Item.AlignVerticalCenterWith <> nil then
    begin
      R := Item.AlignVerticalCenterWith.BoundsRect;
      Y := R.Top + (R.Height div 2);
      ItemControl.SetBounds(ItemControl.Left, Y - (ItemControl.Height div 2), ItemControl.Width, ItemControl.Height);
    end;
  end; { = AlignControlToSibling = }

begin {= TCustomRelativePanel.AlignControls =}
  AdjustClientRect(Rect);

  // Align all controls relative to the panel first
  for I := 0 to FControlCollection.Count - 1 do
  begin
    Item := FControlCollection[I];
    ItemControl := Item.Control;
    AlignControlToPanel;
  end;

  // Then align all controls relative to each other
  for I := 0 to FControlCollection.Count - 1 do
  begin
    Item := FControlCollection[I];
    ItemControl := Item.Control;
    AlignControlToSibling;
  end;
end; {= TCustomRelativePanel.AlignControls =}

procedure TCustomRelativePanel.CMControlChange(var Msg: TCMControlChange);
begin
  inherited;
  if not(csLoading in ComponentState) then
  begin
    DisableAlign;
    try
      if Msg.Inserting and (Msg.Control.Parent = Self) then
      begin
        Msg.Control.Anchors := [];
        FControlCollection.AddControl(Msg.Control);
      end
      else
      begin
        FControlCollection.RemoveControl(Msg.Control);
      end;
    finally
      EnableAlign;
    end;
  end;
end;

procedure TCustomRelativePanel.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  ControlItem: TRelativePanelControlItem;
begin
  for I := 0 to FControlCollection.Count - 1 do
  begin
    ControlItem := TRelativePanelControlItem(FControlCollection.Items[I]);
    if (ControlItem.Control <> nil) and (ControlItem.Control.Owner = Root) then
      Proc(ControlItem.Control);
  end;
end;

function TCustomRelativePanel.GetControlIndex(AControl: TControl): Integer;
begin
  Result := FControlCollection.IndexOf(AControl);
end;

procedure TCustomRelativePanel.SetControlIndex(AControl: TControl; Index: Integer);
var
  CurIndex: Integer;
begin
  CurIndex := GetControlIndex(AControl);
  if (CurIndex > -1) and (CurIndex <> Index) and (Index < FControlCollection.Count) then
  begin
    FControlCollection[CurIndex].Index := Index;
    Realign;
  end;
end;

procedure TCustomRelativePanel.SetControlCollection(const Value: TRelativePanelControlCollection);
begin
  FControlCollection.Assign(Value);
end;

{ TCustomSplitView Methods }

constructor TCustomSplitView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle - [csSetCaption, csParentBackground] + [csOpaque, csCaptureMouse];
  DoubleBuffered := True;

  FState := svsOpened;
  FDisplayMode := svmDocked;
  FCloseStyle := svcCollapse;

  FCompactWidth := DefaultSplitViewCompactWidth;
  FOpenedWidth := DefaultSplitViewOpenedWidth;
  FPlacement := svpLeft;

  BevelOuter := bvNone; // Remove the default border of ancestor

  inherited Width := FOpenedWidth;
  Align := alLeft;

  FAnimationDelay := DefaultSplitViewAnimationDelay;
  FAnimationStep := DefaultSplitViewAnimationStep;
  FUseAnimation := True;
  FAnimationTimer := TTimer.Create(Self);
  FAnimationTimer.Enabled := False;
  FAnimationTimer.Interval := FAnimationDelay;
  FAnimationTimer.OnTimer := AnimationTimerHandler;
end;

procedure TCustomSplitView.Open;
begin
  if FUseAnimation then
    SetState(svsOpening)
  else
    SetState(svsOpened);
end;

procedure TCustomSplitView.Close;
begin
  if FUseAnimation then
    SetState(svsClosing)
  else
    SetState(svsClosed);
end;

function TCustomSplitView.GetOpened: Boolean;
begin
  Result := FState = svsOpened;
end;

procedure TCustomSplitView.SetOpened(Value: Boolean);
begin
  if FUseAnimation and not(csDesigning in ComponentState) and not(csLoading in ComponentState) then
  begin
    if Value then
      SetState(svsOpening)
    else
      SetState(svsClosing);
  end
  else
  begin
    if Value then
      SetState(svsOpened)
    else
      SetState(svsClosed);
  end;
end;

procedure TCustomSplitView.SetOpenedWidth(Value: Integer);
begin
  if FOpenedWidth <> Value then
  begin
    FOpenedWidth := Value;
    if FOpenedWidth < FCompactWidth then
      FOpenedWidth := FCompactWidth;
    if (Constraints.MaxWidth > 0) and (FOpenedWidth > Constraints.MaxWidth) then
      FOpenedWidth := Constraints.MaxWidth;
    if FState = svsOpened then
      inherited Width := FOpenedWidth;
  end;
end;

procedure TCustomSplitView.SetState(Value: TSplitViewState);
begin
  FState := Value;
  if FUseAnimation and not(csDesigning in ComponentState) and not(csLoading in ComponentState) then
  begin
    FAnimationTimer.Enabled := FState in [svsOpening, svsClosing];
    case FState of
      svsOpened:  DoOpened;
      svsOpening: DoOpening;
      svsClosed:  DoClosed;
      svsClosing: DoClosing;
    end;
  end
  else // not FUseAnimation
  begin
    if FState = svsOpened then
    begin
      inherited Width := FOpenedWidth;
      if FPlacement = svpRight then
      begin
        if FCloseStyle = svcCompact then
          Left := Left - FOpenedWidth + FCompactWidth
        else
          Left := Left - FOpenedWidth;
      end;
      DoOpened;
    end
    else // tsClosing
    begin
      if FCloseStyle = svcCompact then
      begin
        if FPlacement = svpRight then
          Left := Left + Width - FCompactWidth;
        inherited Width := FCompactWidth;
      end
      else // svcCollapse
      begin
        if FPlacement = svpRight then
          Left := Left + Width;
        inherited Width := 0;
      end;
      DoClosed;
    end;
  end;
end;

procedure TCustomSplitView.DoOpened;
begin
  if Assigned(FOnOpened) then
    FOnOpened(Self);
end;

procedure TCustomSplitView.DoOpening;
begin
  if Assigned(FOnOpening) then
    FOnOpening(Self);
end;

procedure TCustomSplitView.DoClosed;
begin
  if Assigned(FOnClosed) then
    FOnClosed(Self);
end;

procedure TCustomSplitView.DoClosing;
begin
  if Assigned(FOnClosing) then
    FOnClosing(Self);
end;

procedure TCustomSplitView.AnimationTimerHandler(Sender: TObject);
var
  W, NewWidth: Integer;
begin
  if FState in [svsOpened, svsClosed] then
  begin
    FAnimationTimer.Enabled := False;
    Exit;
  end;

  if FState = svsOpening then
  begin
    NewWidth := Width + FAnimationStep;
    W := Min(NewWidth, FOpenedWidth);
    if FPlacement = svpLeft then
      SetBounds(Left, Top, W, Height)
    else
      SetBounds(BoundsRect.Right - W, Top, W, Height);

    if Width = FOpenedWidth then
      SetState(svsOpened);
  end
  else // tsClosing
  begin
    NewWidth := Width - FAnimationStep;
    if FCloseStyle = svcCompact then
    begin
      W := Max(FCompactWidth, Min(NewWidth, FOpenedWidth));
      if FPlacement = svpLeft then
        SetBounds(Left, Top, W, Height)
      else
        SetBounds(BoundsRect.Right - W, Top, W, Height);

      if Width = FCompactWidth then
        SetState(svsClosed);
    end
    else // svcCollapse
    begin
      W := Max(0, Min(NewWidth, FOpenedWidth));
      if FPlacement = svpLeft then
        SetBounds(Left, Top, W, Height)
      else
        SetBounds(BoundsRect.Right - W, Top, W, Height);

      if Width = 0 then
        SetState(svsClosed);
    end;
  end;
end;

procedure TCustomSplitView.SetAnimationDelay(Value: Word);
begin
  if FAnimationDelay <> Value then
  begin
    FAnimationDelay := Value;
    FUseAnimation := FAnimationDelay <> 0;
    FAnimationTimer.Interval := FAnimationDelay;
  end;
end;

procedure TCustomSplitView.SetCloseStyle(Value: TSplitViewCloseStyle);
var
  W: Integer;
begin
  if FCloseStyle <> Value then
  begin
    FCloseStyle := Value;
    if FState = svsClosed then
    begin
      if FCloseStyle = svcCompact then
      begin
        W := FCompactWidth;
        if FOverlayPadding <> nil then
          FOverlayPadding.Width := FCompactWidth;
        if FPlacement = svpLeft then
          SetBounds(Left, Top, W, Height)
        else
          SetBounds(BoundsRect.Right - W, Top, W, Height);
      end
      else // svcCollapse
      begin
        W := 0;
        if FOverlayPadding <> nil then
          FOverlayPadding.Width := 0;
        if FPlacement = svpLeft then
          SetBounds(Left, Top, W, Height)
        else
          SetBounds(BoundsRect.Right - W, Top, W, Height);
      end;
    end
    else if (FState = svsOpened) and (FDisplayMode = svmOverlay) then
    begin
      if FOverlayPadding <> nil then
      begin
        if FCloseStyle = svcCompact then
          FOverlayPadding.Width := FCompactWidth
        else
          FOverlayPadding.Width := 0;
      end;
    end;
  end;
end;

procedure TCustomSplitView.SetCompactWidth(Value: Integer);
begin
  if FCompactWidth <> Value then
  begin
    FCompactWidth := Value;
    if FCompactWidth < Constraints.MinWidth then
      FCompactWidth := Constraints.MinWidth;
    if FCompactWidth > FOpenedWidth then
      FCompactWidth := FOpenedWidth;
    if (FDisplayMode = svmOverlay) and (FState in [svsClosed, svsClosing]) then
    begin
      inherited Width := FCompactWidth;
      FOverlayPadding.Width := FCompactWidth;
    end;
  end;
end;

procedure TCustomSplitView.SetDisplayMode(Value: TSplitViewDisplayMode);
var
  R: TRect;
begin
  if FDisplayMode <> Value then
  begin
    FDisplayMode := Value;
    if FDisplayMode = svmOverlay then
    begin
      R := BoundsRect;
      FOverlayPadding := TWinControl.Create(Self);
      if FPlacement = svpLeft then
        FOverlayPadding.Align := alLeft
      else
        FOverlayPadding.Align := alRight;
      if FCloseStyle = svcCompact then
        FOverlayPadding.Width := FCompactWidth
      else
        FOverlayPadding.Width := 0;
      FOverlayPadding.Parent := Parent;
      FOverlayPadding.SendToBack;

      Align := alNone;
      if FPlacement = svpLeft then
      begin
        BoundsRect := R;
        Anchors := [akLeft, akTop, akBottom]
      end
      else
      begin
        if FState = svsClosed then
          Left := FOverlayPadding.Left
        else
          BoundsRect := R;
        Anchors := [akRight, akTop, akBottom];
      end;
    end
    else // FDisplayMode = dmDocked
    begin
      if FPlacement = svpLeft then
        Align := alLeft
      else
        Align := alRight;
      FOverlayPadding.Free;
      FOverlayPadding := nil;
    end;
  end;
end;

procedure TCustomSplitView.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if FOverlayPadding <> nil then
  begin
    FOverlayPadding.Parent := AParent;
    FOverlayPadding.SendToBack;
  end;
end;

procedure TCustomSplitView.SetPlacement(Value: TSplitViewPlacement);
var
  R: TRect;
begin
  if FPlacement <> Value then
  begin
    FPlacement := Value;
    if FPlacement = svpLeft then
    begin
      Align := alLeft;
      Left := 0;
      R := BoundsRect;

      if FDisplayMode = svmOverlay then
      begin
        Align := alNone;
        BoundsRect := R;
        Anchors := [akLeft, akTop, akBottom]
      end;

      if FOverlayPadding <> nil then
        FOverlayPadding.Align := alLeft;
    end
    else
    begin
      Align := alRight;
      R := BoundsRect;

      if FDisplayMode = svmOverlay then
      begin
        Align := alNone;
        BoundsRect := R;
        Anchors := [akRight, akTop, akBottom];
      end;

      if FOverlayPadding <> nil then
        FOverlayPadding.Align := alRight;
    end;
  end;
end;

function TCustomSplitView.GetWidth: Integer;
begin
  Result := inherited Width;
end;

procedure TCustomSplitView.SetWidth(Value: Integer);
begin
  if FOpenedWidth <> Value then
  begin
    FOpenedWidth := Value;
    if FState = svsOpened then
      inherited Width := FOpenedWidth;
  end;
end;

end.
