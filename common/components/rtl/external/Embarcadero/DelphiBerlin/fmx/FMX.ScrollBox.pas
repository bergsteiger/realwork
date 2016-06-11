{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.ScrollBox;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FMX.Types, FMX.Controls, FMX.Controls.Presentation, FMX.Controls.Model, FMX.StdCtrls,
  FMX.BehaviorManager, FMX.InertialMovement;

const
  MM_AUTOHIDE_CHANGED = MM_USER + 1;
  MM_BOUNCES_CHANGED = MM_USER + 2;
  MM_DISABLE_MOUSE_WHEEL_CHANGED = MM_USER + 3;
  MM_ENABLED_SCROLL_CHANGED = MM_USER + 4;
  MM_SCROLLBAR_VISIBLE_CHANGED = MM_USER + 5;
  MM_SHOW_SIZE_GRIP_CHANGED = MM_USER + 6;
  MM_SHOW_SCROLLBAR_CHANGED = MM_USER + 7;
  MM_GET_VIEWPORT_POSITION = MM_USER + 8;
  MM_SET_VIEWPORT_POSITION = MM_USER + 9;
  MM_GET_VIEWPORT_SIZE = MM_USER + 10;
  MM_SCROLL_ANIMATION_CHANGED = MM_USER + 11;
  MM_SCROLL_DIRECTIONS_CHANGED = MM_USER + 12;
  MM_SET_CONTENT_BOUNDS = MM_USER + 13;
  MM_TOUCH_TRACKING_CHANGED = MM_USER + 14;
  MM_SCROLLBOX_USER = MM_USER + 15;

  PM_SCROLL_BY = PM_USER + 1;
  PM_SCROLL_IN_RECT = PM_USER + 2;
  PM_SET_CONTENT = PM_USER + 3;
  PM_GET_CONTENT_LAYOUT = PM_USER + 4;
  PM_GET_VSCROLLBAR = PM_USER + 5;
  PM_GET_HSCROLLBAR = PM_USER + 6;
  PM_GET_ANICALCULATIONS = PM_USER + 7;
  PM_BEGIN_PAINT_CHILDREN = PM_USER + 8;
  PM_END_PAINT_CHILDREN = PM_USER + 9;
  PM_USER_SCROLLBOX = PM_USER + 10;

type

  { TScrollBox }

  TCustomPresentedScrollBox = class;

  /// <summary>Event type for notification about ScrollBox changed position of content</summary>
  TPositionChangeEvent = procedure (Sender: TObject; const OldViewportPosition, NewViewportPosition: TPointF;
    const ContentSizeChanged: Boolean) of object;
  /// <summary>Event type for correcting content size, which was calculated automatically.</summary>
  TOnCalcContentBoundsEvent = procedure (Sender: TObject; var ContentBounds: TRectF) of object;

  /// <summary>Stores the size of the ScrollBox content.</summary>
  TScrollContentSize = class(TPersistent)
  private
    [Weak] FScrollBox: TCustomPresentedScrollBox;
    FWidth: Single;
    FHeight: Single;
    FOnInternalChange: TNotifyEvent;
    procedure SetHeight(const Value: Single);
    procedure SetWidth(const Value: Single);
    function GetSize: TSizeF;
    procedure SetSize(const Value: TSizeF);
    function StoreWidthHeight: Boolean;
  protected
    /// <summary>Notifies abount changed size (Width, Height)</summary>
    procedure DoChanged; virtual;
    /// <summary>Copies the data to destination <c>TScrollContentSize</c></summary>
    procedure AssignTo(Dest: TPersistent); override;
    /// <summary>Returns owenr of the Data</summary>
    function GetOwner: TPersistent; override;
    /// <summary>Sets size without checks on <c>AutoCalculateContentSize</c>. Ignores <c>IsReadOnly</c></summary>
    procedure SetSizeWithoutChecks(const Value: TSizeF);
  public
    /// <summary>Constructs object, extract from <c>AOwner</c> TCustomScrollBox and sets internal event handler
    /// <c>OnChange</c></summary>
    constructor Create(AOwner: TComponent; const AOnChange: TNotifyEvent);
    /// <summary>Checks can we set size or not. It depends on <c>TPresentedScrollBox.AutoCalculateContentSize</c></summary>
    function IsReadOnly: Boolean;
    /// <summary>Link on Owner ScrollBox</summary>
    property ScrollBox: TCustomPresentedScrollBox read FScrollBox;
    /// <summary>Size of content</summary>
    property Size: TSizeF read GetSize write SetSize;
    /// <summary>Event, which is invoked, when size was changed</summary>
    property OnChange: TNotifyEvent read FOnInternalChange;
  published
    /// <summary>Width of content</summary>
    property Width: Single read FWidth write SetWidth stored StoreWidthHeight;
    /// <summary>Height of content</summary>
    property Height: Single read FHeight write SetHeight stored StoreWidthHeight;
  end;

  /// <summary>Directions of content scroll</summary>
  TScrollDirections = (Both, Horizontal, Vertical);

  /// <summary>Model of TScrollBox data.</summary>
  TCustomScrollBoxModel = class(TDataModel)
  public const
    DefaultAutoHide = TBehaviorBoolean.PlatformDefault;
    DefaultAutoCalculateContentSize = True;
    DefaultBounces = TBehaviorBoolean.PlatformDefault;
    DefaultEnabledScroll = True;
    DefaultShowScrollBars = True;
    DefaultScrollAnimation = TBehaviorBoolean.PlatformDefault;
    DefaultScrollDirections = TScrollDirections.Both;
    DefaultTouchTracking = TBehaviorBoolean.PlatformDefault;
  public type
    TScrollByInfo = record
      Vector: TPointF;
      Animated: Boolean;
    end;
    TInViewRectInfo = record
      Rect: TRectF;
      Animated: Boolean;
    end;
  private
    FAutoHide: TBehaviorBoolean;
    FAutoCalculateContentSize: Boolean;
    FBounces: TBehaviorBoolean;
    FContentSize: TScrollContentSize;
    FDisableMouseWheel: Boolean;
    FEnabledScroll: Boolean;
    FScrollAnimation: TBehaviorBoolean;
    FScrollDirections: TScrollDirections;
    FShowScrollBars: Boolean;
    FShowSizeGrip: Boolean;
    FViewportPosition: TPointF;
    FTouchTracking: TBehaviorBoolean;
    FOnCalcContentBounds: TOnCalcContentBoundsEvent;
    FOnViewportPositionChange:TPositionChangeEvent;
    procedure SetAutoHide(const Value: TBehaviorBoolean);
    procedure SetBounces(const Value: TBehaviorBoolean);
    procedure SetContentBounds(const Value: TRectF);
    function GetContentBounds: TRectF;
    procedure SetContentSize(const Value: TScrollContentSize);
    procedure SetDisableMouseWheel(const Value: Boolean);
    procedure SetEnabledScroll(const Value: Boolean);
    procedure SetScrollAnimation(const Value: TBehaviorBoolean);
    procedure SetScrollDirection(const Value: TScrollDirections);
    procedure SetShowScrollBars(const Value: Boolean);
    procedure SetShowSizeGrip(const Value: Boolean);
    procedure SetTouchTracking(const Value: TBehaviorBoolean);
    function GetViewportSize: TSizeF;
    procedure SetViewportPosition(const Value: TPointF);
    function GetViewportPosition: TPointF;
    procedure DoContentSizeChanged(Sender: TObject);
  public
    constructor Create(const AOwner: TComponent); override;
    destructor Destroy; override;
    ///<summary>Invoked, when ScrollBox changed content position or size</summary>
    procedure DoViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF; const ContentSizeChanged: Boolean); virtual;
    /// <summary>Need ScrollBox updates effects, when content is scrolled? (False by default)</summary>
    function IsOpaque: Boolean;
    ///<summary>Returns current content bounds. If content bounds size is calculati</summary>
    property ContentBounds: TRectF read GetContentBounds write SetContentBounds;
    ///<summary>Defines that scrollbars are automatically hiding when scroll is done</summary>
    property AutoHide: TBehaviorBoolean read FAutoHide write SetAutoHide;
    ///<summary>Indicates that the size of scrolling content calculates automatically according to the size of
    ///components in content. Otherwise content size defines by the value of <c>ContentSize</c> property</summary>
    property AutoCalculateContentSize: Boolean read FAutoCalculateContentSize write FAutoCalculateContentSize;
    ///<summary>Whether it is possible to scroll of content abroad</summary>
    property Bounces: TBehaviorBoolean read FBounces write SetBounces;
    ///<summary>Current content size</summary>
    property ContentSize: TScrollContentSize read FContentSize write SetContentSize;
    ///<summary>Defines that control has no reaction on <c>MouseWheel</c> event</summary>
    property DisableMouseWheel: Boolean read FDisableMouseWheel write SetDisableMouseWheel;
    ///<summary>Enable or disabled scroll</summary>
    property EnabledScroll: Boolean read FEnabledScroll write SetEnabledScroll;
    ///<summary>Enable or disabled scrolling animation</summary>
    property ScrollAnimation: TBehaviorBoolean read FScrollAnimation write SetScrollAnimation;
    ///<summary>Defines avaiable scroll directions</summary>
    property ScrollDirections: TScrollDirections read FScrollDirections write SetScrollDirection;
    ///<summary>Defines scrollbars visibility</summary>
    property ShowScrollBars: Boolean read FShowScrollBars write SetShowScrollBars;
    ///<summary>Shows small control in the right-bottom corner that represent size changin control</summary>
    property ShowSizeGrip: Boolean read FShowSizeGrip write SetShowSizeGrip;
    ///<summary>Defines that control reacts on touch events</summary>
    property TouchTracking: TBehaviorBoolean read FTouchTracking write SetTouchTracking;
    ///<summary>Position of top-left point of view port at the ScrollBox's content. It is set in local coordinates of <c>Content</c></summary>
    property ViewportPosition: TPointF read GetViewportPosition write SetViewportPosition;
    ///<summary>Returns the size of displaing area</summary>
    property ViewportSize: TSizeF read GetViewportSize;
    ///<summary>Event that raises after control calculates its content size</summary>
    ///<remarks>Raises only when <c>AutoCalculateContentSize</c> is true</remarks>
    property OnCalcContentBounds: TOnCalcContentBoundsEvent read FOnCalcContentBounds write FOnCalcContentBounds;
    ///<summary>Raises when the value of ViewportPosition was changed</summary>
    property OnViewportPositionChange: TPositionChangeEvent read FOnViewportPositionChange write FOnViewportPositionChange;
  end;

  /// <summary>Container for the child controls of the scroll box.</summary>
  TScrollContent = class(TContent, IIgnoreControlPosition)
  private
    [Weak] FScrollBox: TCustomPresentedScrollBox;
    FOnGetClipRect: TOnCalcContentBoundsEvent;
  protected
    function GetClipRect: TRectF; override;
    function ObjectAtPoint(P: TPointF): IControl; override;
    function DoGetUpdateRect: TRectF; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    procedure ContentChanged; override;
    { IIgnoreControlPosition }
    function GetIgnoreControlPosition: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    function PointInObjectLocal(X, Y: Single): Boolean; override;
  public
    ///<summary>Link to the ScrollBox that owns currect content instance</summary>
    property ScrollBox: TCustomPresentedScrollBox read FScrollBox;
    /// <summary> The handler for this event should return the clip rectangle </summary>
    property OnGetClipRect:TOnCalcContentBoundsEvent read FOnGetClipRect write FOnGetClipRect;
  end;

  ///<summary>Component allows view large content within a smaller visible area</summary>
  TCustomPresentedScrollBox = class(TPresentedControl)
  private
    FContent: TScrollContent;
    function GetModel: TCustomScrollBoxModel; overload;
    procedure SetAutoHide(const Value: TBehaviorBoolean);
    function GetAutoHide: TBehaviorBoolean;
    procedure SetBounces(const Value: TBehaviorBoolean);
    function GetBounces: TBehaviorBoolean;
    procedure SetCalculateContentSize(const Value: Boolean);
    function GetCalculateContentSize: Boolean;
    procedure SetContentBounds(const Value: TRectF);
    function GetContentBounds: TRectF;
    procedure SetContentSize(const Value: TScrollContentSize);
    function GetContentSize: TScrollContentSize;
    procedure SetDisableMouseWheel(const Value: Boolean);
    function GetDisableMouseWheel: Boolean;
    procedure SetEnabledScroll(const Value: Boolean);
    function GetEnabledScroll: Boolean;
    procedure SetScrollAnimation(const Value: TBehaviorBoolean);
    function GetScrollAnimation: TBehaviorBoolean;
    procedure SetScrollDirection(const Value: TScrollDirections);
    function GetScrollDirections: TScrollDirections;
    procedure SetShowScrollBars(const Value: Boolean);
    function GetShowScrollBars: Boolean;
    procedure SetShowSizeGrip(const Value: Boolean);
    function GetShowSizeGrip: Boolean;
    procedure SetTouchTracking(const Value: TBehaviorBoolean);
    function GetTouchTracking: TBehaviorBoolean;
    procedure SetViewportPosition(const Value: TPointF);
    function GetViewportPosition: TPointF;
    function GetViewportSize: TSizeF;
    procedure SetOnCalcContentBounds(const Value: TOnCalcContentBoundsEvent);
    function GetOnCalcContentBounds: TOnCalcContentBoundsEvent;
    procedure SetOnViewportPositionChange(const Value: TPositionChangeEvent);
    function GetOnViewportPositionChange: TPositionChangeEvent;
    { Streaming }
    procedure ReadSizeValue(AReader: TReader; var ASize: Single);
    procedure ReadViewportHeight(Reader: TReader);
    procedure ReadViewportWidth(Reader: TReader);
    procedure WriteViewportHeight(Writer: TWriter);
    procedure WriteViewportWidth(Writer: TWriter);
    function GetContentLayout: TControl;
    function GetHScrollBar: TScrollBar;
    function GetVScrollBar: TScrollBar;
    function GetAniCalculations: TAniCalculations;
  protected
    procedure Loaded; override;
    procedure PaddingChanged; override;
    { Structure }
    /// <summary>Create scroll content. Successors can override it for creating custom content. It allows add custom
    /// information to content.</summary>
    function CreateScrollContent: TScrollContent; virtual;
    /// <summary>Performs filtering of adding objects and redirects adding of object to <c>Content</c>, if AObject is not
    /// Effect, Animation or Style Object</summary>
    /// <remarks>It uses <c>IsObjectForContent</c> for defining content's object</remarks>
    procedure DoAddObject(const AObject: TFmxObject); override;
    /// <summary>Performs filtering of inserting objects and redirects inserting of object to <c>Content</c>, if AObject
    /// is not Effect, Animation or Style Object</summary>
    /// <remarks>It uses <c>IsObjectForContent</c> for defining content's object</remarks>
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    /// <summary>Remove object from <c>Content</c> or <c>Children</c> list</summary>
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    { Painting }
    procedure PaintChildren; override;
    { Content }
    /// <summary>Calculates content bounds by building convex shell of all children controls of <c>Content</c></summary>
    /// <remarks>If ScrollBox uses Horizontal or Vertical <c>ScrollDirections</c> mode, It restricts the content size by
    /// height or width</remarks>
    function DoCalcContentBounds: TRectF; virtual;                                                                                         
    /// <summary>Defines, need to add AObject to Content or not.</summary>
    function IsAddToContent(const AObject: TFmxObject): Boolean; virtual;
    /// <summary>Invoked, when new Object was added into Content's childrens list.</summary>
    procedure ContentAddObject(const AObject: TFmxObject); virtual;
    /// <summary>Invoked, when new Object was inserted into Content's childrens list.</summary>
    procedure ContentInsertObject(Index: Integer; const AObject: TFmxObject); virtual;
    /// <summary>Invoked before removing Object from Content's childrens list.</summary>
    procedure ContentBeforeRemoveObject(AObject: TFmxObject); virtual;
    /// <summary>Invoked, when Object was removed from Content's childrens list.</summary>
    procedure ContentRemoveObject(const AObject: TFmxObject); virtual;
    { Events }
    /// <summary>Need ScrollBox updates effects, when content is scrolled? (False by default)</summary>
    function IsOpaque: Boolean; virtual;
    /// <summary>Defines custom readers and writers for control properties for backward compatibility</summary>
    procedure DefineProperties(Filer: TFiler); override;
    ///<summary>Returns instance of class that provide scrolling physics calculations</summary>
    ///<remarks>Exists only for style presentation. For native presentation returns nil.</remarks>
    property AniCalculations: TAniCalculations read GetAniCalculations;
    { Design Time Only }
    /// <summary>Scrolls content in design time only</summary>
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
  protected
    /// <summary>Defines a Model class (<c>TDataModelClass</c> by default) of <c>TScrollBox</c></summary>
    function DefineModelClass: TDataModelClass; override;
    /// <summary>Initializes presentation</summary>
    procedure InitPresentation(APresentation: TPresentationProxy); override;
  public
    constructor Create(AOwner: TComponent); override;
    ///<summary>Change scroll position by offset defined in <c>ADX</c> and <c>ADY</c></summary>
    procedure ScrollBy(const ADX, ADY: Single; const AAnimated: Boolean = True);
    ///<summary>Change scroll position to value defined in <c>AX</c> and <c>AY</c></summary>
    procedure ScrollTo(const AX, AY: Single; const AAnimated: Boolean = True);
    ///<summary>Change scroll position to the top</summary>
    procedure ScrollToTop(const AAnimated: Boolean = True);
    ///<summary>Change scroll position to the center of content size</summary>
    procedure ScrollToCenter(const AAnimated: Boolean = True);
    ///<summary>Scrolls content to rectange defined in <c>ARect</c></summary>
    procedure InViewRect(const ARect: TRectF; const AAnimated: Boolean = True);
    /// <summary>Sorts children of <c>Content</c></summary>
    procedure Sort(Compare: TFmxObjectSortCompare); override;
    /// <summary>Returns <c>TabList</c> of <c>Content</c></summary>
    function GetTabList: ITabList; override;
    { Update Content Size }
    /// <summary>Recalculates content bounds. If you use the manual calcualting of <c>ContentBounds</c>, you need to set
    /// through <c>ContentBounds</c></summary>
    /// <remarks>This method doesn't calculate content bounds, if we don't use mode of auto calculating
    /// (<c>AutoCalculateContentSize = False</c>) or control is being loaded or destroyed
    /// (ComponentState = csLoading or csDestroying)</remarks>
    procedure UpdateContentSize;
    ///<summary>Force content size calculation update</summary>
    procedure RealignContent;
    /// <summary>Content of ScrollBox. Contains controls placed into TScrollBox</summary>
    /// <remarks>Doesn't contain Style object, any kinds of Animation's and effect's objects</remarks>
    property Content: TScrollContent read FContent;
    /// <summary>Returns current content bounds</summary>
    property ContentBounds: TRectF read GetContentBounds write SetContentBounds;
    /// <summary>Removes all controls from content</summary>
    procedure ClearContent;
    /// <summary>Model of TScrollBox</summary>
    property Model: TCustomScrollBoxModel read GetModel;
    ///<summary>Position of view port of the ScrollBox's content. It is set in local coordinates of <c>Content</c></summary>
    property ViewportPosition: TPointF read GetViewportPosition write SetViewportPosition;
    /// <summary>Size of view port of the ScrollBox's content.</summary>
    property ViewportSize: TSizeF read GetViewportSize;
    { Deprecated }
    ///<summary>Returns vertical scrollbar component</summary>
    ///<remarks>Available only for styled presentation. For native presentation returns <c>nil</c></remarks>
    property VScrollBar: TScrollBar read GetVScrollBar;
    ///<summary>Returns horisontal scrollbar component</summary>
    ///<remarks>Available only for styled presentation. For native presentation returns <c>nil</c></remarks>
    property HScrollBar: TScrollBar read GetHScrollBar;
    ///<summary>Returns control from style that is a surface for content in the scrollbox</summary>
    property ContentLayout: TControl read GetContentLayout;
  public
    ///<summary>Indicates that the size of scrolling content calculates automatically according to the size of
    ///components in content. Otherwise content size defines by the value of <c>ContentSize</c> property</summary>
    property AutoCalculateContentSize: Boolean read GetCalculateContentSize write SetCalculateContentSize default True;
    ///<summary>Defines that scrollbars are automatically hiding when scroll is done</summary>
    property AutoHide: TBehaviorBoolean read GetAutoHide write SetAutoHide default TBehaviorBoolean.PlatformDefault;
    ///<summary>Whether it is possible to scroll of content abroad</summary>
    property Bounces: TBehaviorBoolean read GetBounces write SetBounces default TBehaviorBoolean.PlatformDefault;
    ///<summary>Current content size</summary>
    property ContentSize: TScrollContentSize read GetContentSize write SetContentSize;
    ///<summary>Defines that control has no reaction on <c>MouseWheel</c> event</summary>
    property DisableMouseWheel: Boolean read GetDisableMouseWheel write SetDisableMouseWheel default False;
    ///<summary>Enable or disabled scroll</summary>
    property EnabledScroll: Boolean read GetEnabledScroll write SetEnabledScroll default True;
    ///<summary>Enable or disabled scrolling animation</summary>
    property ScrollAnimation: TBehaviorBoolean read GetScrollAnimation write SetScrollAnimation default TBehaviorBoolean.PlatformDefault;
    ///<summary>Defines avaiable scroll directions</summary>
    property ScrollDirections: TScrollDirections read GetScrollDirections write SetScrollDirection default TScrollDirections.Both;
    ///<summary>Defines scrollbars visibility</summary>
    property ShowScrollBars: Boolean read GetShowScrollBars write SetShowScrollBars default True;
    ///<summary>Shows small control in the right-bottom corner that represent size changin control</summary>
    property ShowSizeGrip: Boolean read GetShowSizeGrip write SetShowSizeGrip default False;
    ///<summary>Defines that control reacts on touch events</summary>
    property TouchTracking: TBehaviorBoolean read GetTouchTracking write SetTouchTracking default TBehaviorBoolean.PlatformDefault;
    ///<summary>Event that raises after control calculates its content size</summary>
    ///<remarks>Raises only when <c>AutoCalculateContentSize</c> is true</remarks>
    property OnCalcContentBounds: TOnCalcContentBoundsEvent read GetOnCalcContentBounds write SetOnCalcContentBounds;
    ///<summary>Raises when the value of ViewportPosition was changed</summary>
    property OnViewportPositionChange: TPositionChangeEvent read GetOnViewportPositionChange write SetOnViewportPositionChange;
  end;

  /// <summary>A base scrollbox component available at design time.</summary>
  TPresentedScrollBox = class(TCustomPresentedScrollBox)
  published
    property AutoCalculateContentSize;
    property AutoHide;
    property Bounces;
    property ContentSize;
    property ControlType;
    property DisableMouseWheel;
    property EnabledScroll;
    property ScrollAnimation;
    property ScrollDirections;
    property ShowScrollBars;
    property ShowSizeGrip;
    property TouchTracking;
    property OnViewportPositionChange;
    property OnCalcContentBounds;
    { Inherited }
    property Align;
    property Anchors;
    property ClipChildren default True;
    property ClipParent;
    property Cursor;
    property DragMode;
    property Enabled;
    property EnableDragHighlight;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property HitTest;
    property Locked;
    property Margins;
    property Opacity;
    property Padding;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    property ParentShowHint;
    property ShowHint;
    { Events }
    property OnApplyStyleLookup;
    property OnPainting;
    property OnPaint;
    property OnResize;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

{ TVertScrollBox }

  /// <summary>Scrollbox with vertical scroll support only.</summary>
  TCustomPresentedVertScrollBox = class(TCustomPresentedScrollBox)
  protected
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  /// <summary>Scrollbox without border, with vertical scroll only.</summary>
  TPresentedVertScrollBox = class(TCustomPresentedVertScrollBox)
  published
    property AutoCalculateContentSize;
    property AutoHide;
    property Bounces;
    property ContentSize;
    property ControlType;
    property DisableMouseWheel;
    property EnabledScroll;
    property ScrollDirections default TScrollDirections.Vertical;
    property ShowScrollBars;
    property ShowSizeGrip;
    property OnViewportPositionChange;
    property OnCalcContentBounds;
    { inhertied }
    property Align;
    property Anchors;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property Enabled;
    property EnableDragHighlight;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property HitTest;
    property Locked;
    property Margins;
    property Opacity;
    property Padding;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    property ParentShowHint;
    property ShowHint;
    { Events }
    property OnApplyStyleLookup;
    property OnPainting;
    property OnPaint;
    property OnResize;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

{ THorzScrollBox }

  /// <summary>Scrollbox with horizontal scroll support only.</summary>
  TCustomPresentedHorzScrollBox = class(TCustomPresentedScrollBox)
  protected
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  /// <summary>Scrollbox without border, with horizontal scroll only</summary>
  TPresentedHorzScrollBox = class(TCustomPresentedHorzScrollBox)
  published
    property AutoCalculateContentSize;
    property AutoHide;
    property Bounces;
    property ContentSize;
    property ControlType;
    property DisableMouseWheel;
    property EnabledScroll;
    property ScrollDirections default TScrollDirections.Horizontal;
    property ShowScrollBars;
    property ShowSizeGrip;
    property OnViewportPositionChange;
    property OnCalcContentBounds;
    { inhertied }
    property Align;
    property Anchors;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property Enabled;
    property EnableDragHighlight;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property HitTest;
    property Locked;
    property Margins;
    property Opacity;
    property Padding;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    property ParentShowHint;
    property ShowHint;
    { Events }
    property OnApplyStyleLookup;
    property OnPainting;
    property OnPaint;
    property OnResize;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

{ TFramedScrollBox }

  /// <summary>Scrollbox without border.</summary>
  TCustomPresentedFramedScrollBox = class(TCustomPresentedScrollBox)
  protected
    function IsOpaque: Boolean; override;
  end;

  /// <summary>Desing-time scrollbox without border.</summary>
  TPresentedFramedScrollBox = class(TCustomPresentedFramedScrollBox)
  published
    property AutoCalculateContentSize;
    property AutoHide;
    property Bounces;
    property ContentSize;
    property ControlType;
    property DisableMouseWheel;
    property EnabledScroll;
    property ScrollDirections;
    property ShowScrollBars;
    property ShowSizeGrip;
    property OnViewportPositionChange;
    property OnCalcContentBounds;
    { inhertied }
    property Align;
    property Anchors;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property Enabled;
    property EnableDragHighlight;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property HitTest;
    property Locked;
    property Margins;
    property Opacity;
    property Padding;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    property ParentShowHint;
    property ShowHint;
    { Events }
    property OnApplyStyleLookup;
    property OnPainting;
    property OnPaint;
    property OnResize;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

{ TFramedVertScrollBox }

  /// <summary>Design-time scrollbox that only supports vertical scrolling.</summary>
  TCustomPresentedFramedVertScrollBox = class(TCustomPresentedVertScrollBox)
  protected
    function IsOpaque: Boolean; override;
    function GetDefaultStyleLookupName: string; override;
  end;

  /// <summary>Scrollbox with vertical scroll only.</summary>
  TPresentedFramedVertScrollBox = class(TCustomPresentedFramedVertScrollBox)
  published
    property AutoCalculateContentSize;
    property AutoHide;
    property Bounces;
    property ContentSize;
    property ControlType;
    property DisableMouseWheel;
    property EnabledScroll;
    property ScrollDirections default TScrollDirections.Vertical;
    property ShowScrollBars;
    property ShowSizeGrip;
    property OnViewportPositionChange;
    property OnCalcContentBounds;
    { inhertied }
    property Align;
    property Anchors;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property Enabled;
    property EnableDragHighlight;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property HitTest;
    property Locked;
    property Margins;
    property Opacity;
    property Padding;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    property ParentShowHint;
    property ShowHint;
    { Events }
    property OnApplyStyleLookup;
    property OnPainting;
    property OnPaint;
    property OnResize;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

/// <summary>Normalizes the target rectangle AContentRect.</summary>
function NormalizeInViewRect(const AContentRect: TRectF; const AViewportSize: TSizeF; const AWishedViewPortRect: TRectF): TRectF;

implementation

uses
  System.SysUtils, System.UITypes, System.Math, System.Math.Vectors, FMX.Ani, FMX.Effects, FMX.ScrollBox.Style,
  FMX.Consts {$IFDEF IOS}, FMX.ScrollBox.iOS{$ENDIF} {$IFDEF MSWINDOWS}, FMX.ScrollBox.Win{$ENDIF};

const
  ScrollBoxStyleName = 'scrollboxstyle'; //do not localize
  FramedScrollBoxStyleName = 'framedscrollboxstyle'; //do not localize

function NormalizeInViewRect(const AContentRect: TRectF; const AViewportSize: TSizeF; const AWishedViewPortRect: TRectF): TRectF;
begin
  Result := AWishedViewPortRect;
  if AContentRect.Contains(AWishedViewPortRect) then
    Result := AWishedViewPortRect
  else if AWishedViewPortRect.Contains(AContentRect) then
    Result := AContentRect
  else
  begin
    if Result.Right > AContentRect.Right then
      Result.Offset(AContentRect.Right - Result.Right, 0);

    if Result.Left < AContentRect.Left then
      Result.Offset(AContentRect.Left - Result.Left, 0);

    if Result.Top < AContentRect.Top then
      Result.Offset(0, AContentRect.Top - Result.Top);

    if Result.Bottom > AContentRect.Bottom then
      Result.Offset(0, AContentRect.Bottom - Result.Bottom);

    Result := TRectF.Intersect(AContentRect, Result);
  end;

  // Final cutting intersection by ViewportSize
  if (AViewportSize.Width < Result.Width) and SameValue(Result.Right, AContentRect.Width, TEpsilon.Position) then
    Result.Left := Result.Right - AViewportSize.Width
  else
    Result.Width := Min(Result.Width, AViewportSize.Width);
  if (AViewportSize.Height < Result.Height) and SameValue(Result.Bottom, AContentRect.Height, TEpsilon.Position) then
    Result.Top := Result.Bottom - AViewportSize.Height
  else
    Result.Height := Min(Result.Height, AViewportSize.Height);
end;

{ TCustomScrollBoxModel }

constructor TCustomScrollBoxModel.Create(const AOwner: TComponent);
begin
  inherited;
  FAutoHide := DefaultAutoHide;
  FAutoCalculateContentSize := DefaultAutoCalculateContentSize;
  FBounces := DefaultBounces;
  FContentSize := TScrollContentSize.Create(Owner, DoContentSizeChanged);
  FEnabledScroll := DefaultEnabledScroll;
  FShowScrollBars := DefaultShowScrollBars;
  FScrollAnimation := DefaultScrollAnimation;
  FScrollDirections := DefaultScrollDirections;
  FViewportPosition := TPointF.Create(0, 0);
  FTouchTracking := DefaultTouchTracking;
end;

destructor TCustomScrollBoxModel.Destroy;
begin
  FContentSize.Free;
  inherited;
end;

procedure TCustomScrollBoxModel.DoContentSizeChanged(Sender: TObject);
begin
  SendMessage<TRectF>(MM_SET_CONTENT_BOUNDS, TRectF.Create(0, 0, ContentSize.Width, ContentSize.Height));
end;

procedure TCustomScrollBoxModel.DoViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: Boolean);
begin
  if Assigned(FOnViewportPositionChange) then
    FOnViewportPositionChange(Owner, OldViewportPosition, NewViewportPosition, ContentSizeChanged);
end;

function TCustomScrollBoxModel.GetContentBounds: TRectF;
begin
  Result := TRectF.Create(0, 0, FContentSize.Width, FContentSize.Height);
end;

function TCustomScrollBoxModel.GetViewportPosition: TPointF;
begin
  Result := FViewportPosition;
  SendMessageWithResult<TPointF>(MM_GET_VIEWPORT_POSITION, Result);
end;

function TCustomScrollBoxModel.GetViewportSize: TSizeF;
begin
  SendMessageWithResult<TSizeF>(MM_GET_VIEWPORT_SIZE, Result);
end;

function TCustomScrollBoxModel.IsOpaque: Boolean;
begin
  Result := TCustomPresentedScrollBox(Owner).IsOpaque;
end;

procedure TCustomScrollBoxModel.SetAutoHide(const Value: TBehaviorBoolean);
begin
  if AutoHide <> Value then
  begin
    FAutoHide := Value;
    SendMessage<TBehaviorBoolean>(MM_AUTOHIDE_CHANGED, FAutoHide);
  end;
end;

procedure TCustomScrollBoxModel.SetBounces(const Value: TBehaviorBoolean);
begin
  if Bounces <> Value then
  begin
    FBounces := Value;
    SendMessage<TBehaviorBoolean>(MM_BOUNCES_CHANGED, Bounces);
  end;
end;

procedure TCustomScrollBoxModel.SetContentBounds(const Value: TRectF);
begin
  FContentSize.Size := Value.Size;
end;

procedure TCustomScrollBoxModel.SetContentSize(const Value: TScrollContentSize);
begin
  FContentSize.Assign(Value);
end;

procedure TCustomScrollBoxModel.SetDisableMouseWheel(const Value: Boolean);
begin
  if DisableMouseWheel <> Value then
  begin
    FDisableMouseWheel := Value;
    SendMessage<Boolean>(MM_DISABLE_MOUSE_WHEEL_CHANGED, DisableMouseWheel);
  end;
end;

procedure TCustomScrollBoxModel.SetEnabledScroll(const Value: Boolean);
begin
  if EnabledScroll <> Value then
  begin
    FEnabledScroll := Value;
    SendMessage<Boolean>(MM_ENABLED_SCROLL_CHANGED, EnabledScroll);
  end;
end;

procedure TCustomScrollBoxModel.SetScrollAnimation(const Value: TBehaviorBoolean);
begin
  if ScrollAnimation <> Value then
  begin
    FScrollAnimation := Value;
    SendMessage<TBehaviorBoolean>(MM_SCROLL_ANIMATION_CHANGED, ScrollAnimation);
  end;
end;

procedure TCustomScrollBoxModel.SetScrollDirection(const Value: TScrollDirections);

  procedure CorrectViewPortPosition;
  var
    ViewportSizeTmp: TSizeF;
    OldViewportPosition: TPointF;
  begin
    ViewportSizeTmp := ViewportSize;
    OldViewportPosition := ViewportPosition;
    case ScrollDirections of
      TScrollDirections.Horizontal:
        if ViewportSizeTmp.Height < ContentSize.Height then
          ViewportPosition := TPointF.Create(OldViewportPosition.X, 0);
      TScrollDirections.Vertical:
        if ViewportSizeTmp.Width < ContentSize.Width then
          ViewportPosition := TPointF.Create(0, OldViewportPosition.Y);
    end;
  end;

begin
  if ScrollDirections <> Value then
  begin
    FScrollDirections := Value;
    CorrectViewPortPosition;
    SendMessage<TScrollDirections>(MM_SCROLL_DIRECTIONS_CHANGED, ScrollDirections);
  end;
end;

procedure TCustomScrollBoxModel.SetShowScrollBars(const Value: Boolean);
begin
  if ShowScrollBars <> Value then
  begin
    FShowScrollBars := Value;
    SendMessage<Boolean>(MM_SHOW_SCROLLBAR_CHANGED, ShowScrollBars);
  end;
end;

procedure TCustomScrollBoxModel.SetShowSizeGrip(const Value: Boolean);
begin
  if ShowSizeGrip <> Value then
  begin
    FShowSizeGrip := Value;
    SendMessage<Boolean>(MM_SHOW_SIZE_GRIP_CHANGED, ShowSizeGrip);
  end;
end;

procedure TCustomScrollBoxModel.SetTouchTracking(const Value: TBehaviorBoolean);
begin
  if TouchTracking <> Value then
  begin
    FTouchTracking := Value;
    SendMessage<TBehaviorBoolean>(MM_TOUCH_TRACKING_CHANGED, TouchTracking);
  end;
end;

procedure TCustomScrollBoxModel.SetViewportPosition(const Value: TPointF);
begin
  FViewportPosition := Value;
  SendMessageWithResult<TPointF>(MM_SET_VIEWPORT_POSITION, FViewportPosition);
end;

{ TCustomScrollBox }

procedure TCustomPresentedScrollBox.ClearContent;
begin
  Content.DeleteChildren;
  Repaint;
end;

procedure TCustomPresentedScrollBox.ContentAddObject(const AObject: TFmxObject);
begin
  UpdateContentSize;
end;

procedure TCustomPresentedScrollBox.ContentBeforeRemoveObject(AObject: TFmxObject);
begin
end;

procedure TCustomPresentedScrollBox.ContentInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  UpdateContentSize;
end;

procedure TCustomPresentedScrollBox.ContentRemoveObject(const AObject: TFmxObject);
begin
  UpdateContentSize;
end;

constructor TCustomPresentedScrollBox.Create(AOwner: TComponent);
begin
  inherited;
  SetAcceptsControls(True);
  CanUseDefaultPresentation := False;
  FContent := CreateScrollContent;
  if FContent = nil then
    raise Exception.Create(Format(SCannotCreateScrollContent, [ClassName]));
  FContent.Parent := Self;
  FContent.Stored := False;
  FContent.Locked := True;
  FContent.HitTest := False;
  Touch.DefaultInteractiveGestures := Touch.DefaultInteractiveGestures + [TInteractiveGesture.Pan];
  Touch.InteractiveGestures := Touch.InteractiveGestures + [TInteractiveGesture.Pan];
  ClipChildren := True;
end;

function TCustomPresentedScrollBox.CreateScrollContent: TScrollContent;
begin
  Result := TScrollContent.Create(Self);
end;

function TCustomPresentedScrollBox.DefineModelClass: TDataModelClass;
begin
  Result := TCustomScrollBoxModel;
end;

procedure TCustomPresentedScrollBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('UseSmallScrollBars', IgnoreBooleanValue, nil, False);
  Filer.DefineProperty('MouseTracking', IgnoreBooleanValue, nil, False);
  Filer.DefineProperty('Viewport.Width', ReadViewportWidth, WriteViewportWidth, True);
  Filer.DefineProperty('Viewport.Height', ReadViewportHeight, WriteViewportHeight, True);
end;

procedure TCustomPresentedScrollBox.DoAddObject(const AObject: TFmxObject);
begin
  if IsAddToContent(AObject) then
    FContent.AddObject(AObject)
  else
    inherited;
end;

function TCustomPresentedScrollBox.DoCalcContentBounds: TRectF;
const
  RightSide = [TAlignLayout.Top, TAlignLayout.MostTop, TAlignLayout.Bottom, TAlignLayout.MostBottom];
  BottomSide = [TAlignLayout.Left, TAlignLayout.MostLeft, TAlignLayout.Right, TAlignLayout.MostRight];
  NeedAddBottom = [TAlignLayout.Top, TAlignLayout.MostTop];
  NeedAddRight = [TAlignLayout.Left, TAlignLayout.MostLeft];
var
  I: Integer;
  R, LocalR: TRectF;
begin
  Result := TRectF.Empty;
  R := TRectF.Create(ViewportPosition, ViewportSize.Width, ViewportSize.Height);
  for I := 0 to FContent.ControlsCount - 1 do
    if FContent.Controls[I].Visible then
    begin
      {$IFDEF MSWINDOWS}
      if (csDesigning in ComponentState) and Supports(FContent.Controls[I], IDesignerControl) then
        Continue;
      {$ENDIF}
      LocalR := FContent.Controls[I].BoundsRect;
      if (FContent.Controls[I].Align in RightSide) or (TAnchorKind.akRight in FContent.Controls[I].Anchors) then
      begin
        LocalR.Left := R.Left;
        LocalR.Right := R.Right;
      end;
      if (FContent.Controls[I].Align in BottomSide) or (TAnchorKind.akBottom in FContent.Controls[I].Anchors) then
      begin
        LocalR.Top := R.Top;
        LocalR.Bottom := R.Bottom;
      end;
      if FContent.Controls[I].Align in NeedAddBottom then
        LocalR.Bottom := LocalR.Bottom + Padding.Bottom;
      if FContent.Controls[I].Align in NeedAddRight then
        LocalR.Right := LocalR.Right + Padding.Right;
      Result.Union(LocalR);
    end;
  if Assigned(OnCalcContentBounds) then
    OnCalcContentBounds(Self, Result);
  case Model.ScrollDirections of
    TScrollDirections.Horizontal:
      Result.Height := ViewportSize.Height;
    TScrollDirections.Vertical:
      Result.Width := ViewportSize.Width;
  end;
end;

procedure TCustomPresentedScrollBox.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  if IsAddToContent(AObject) then
    FContent.InsertObject(Index, AObject)
  else
    inherited;
end;

procedure TCustomPresentedScrollBox.DoRemoveObject(const AObject: TFmxObject);
begin
  if IsAddToContent(AObject) then
    FContent.RemoveObject(AObject)
  else
    inherited;
end;

function TCustomPresentedScrollBox.GetModel: TCustomScrollBoxModel;
begin
  Result := GetModel<TCustomScrollBoxModel>;
end;

function TCustomPresentedScrollBox.GetOnCalcContentBounds: TOnCalcContentBoundsEvent;
begin
  Result := Model.OnCalcContentBounds;
end;

function TCustomPresentedScrollBox.GetOnViewportPositionChange: TPositionChangeEvent;
begin
  Result := Model.OnViewportPositionChange;
end;

function TCustomPresentedScrollBox.GetCalculateContentSize: Boolean;
begin
  Result := Model.AutoCalculateContentSize;
end;

function TCustomPresentedScrollBox.GetContentBounds: TRectF;
begin
  Result := Model.ContentBounds;
end;

function TCustomPresentedScrollBox.GetContentLayout: TControl;
begin
  Result := nil;
  if HasPresentationProxy then
    PresentationProxy.SendMessageWithResult<TControl>(PM_GET_CONTENT_LAYOUT, Result);
end;

function TCustomPresentedScrollBox.GetContentSize: TScrollContentSize;
begin
  Result := Model.ContentSize;
end;

function TCustomPresentedScrollBox.GetDisableMouseWheel: Boolean;
begin
  Result := Model.DisableMouseWheel;
end;

function TCustomPresentedScrollBox.GetEnabledScroll: Boolean;
begin
  Result := Model.EnabledScroll;
end;

function TCustomPresentedScrollBox.GetHScrollBar: TScrollBar;
begin
  Result := nil;
  if HasPresentationProxy then
    PresentationProxy.SendMessageWithResult<TScrollBar>(PM_GET_HSCROLLBAR, Result);
end;

procedure TCustomPresentedScrollBox.SetAutoHide(const Value: TBehaviorBoolean);
begin
  Model.AutoHide := Value;
end;

procedure TCustomPresentedScrollBox.SetBounces(const Value: TBehaviorBoolean);
begin
  Model.Bounces := Value;
end;

procedure TCustomPresentedScrollBox.SetCalculateContentSize(const Value: Boolean);
begin
  Model.AutoCalculateContentSize := Value;
  if Model.AutoCalculateContentSize then
    UpdateContentSize;
end;

procedure TCustomPresentedScrollBox.SetContentBounds(const Value: TRectF);
begin
  Model.ContentBounds := Value;
end;

procedure TCustomPresentedScrollBox.SetContentSize(const Value: TScrollContentSize);
begin
  Model.ContentSize := Value;
end;

procedure TCustomPresentedScrollBox.SetDisableMouseWheel(const Value: Boolean);
begin
  Model.DisableMouseWheel := Value;
end;

procedure TCustomPresentedScrollBox.SetEnabledScroll(const Value: Boolean);
begin
  Model.EnabledScroll := Value;
end;

procedure TCustomPresentedScrollBox.SetOnCalcContentBounds(const Value: TOnCalcContentBoundsEvent);
begin
  Model.OnCalcContentBounds := Value;
end;

procedure TCustomPresentedScrollBox.SetOnViewportPositionChange(const Value: TPositionChangeEvent);
begin
  Model.OnViewportPositionChange := Value;
end;

function TCustomPresentedScrollBox.GetAniCalculations: TAniCalculations;
begin
  Result := nil;
  if HasPresentationProxy then
    PresentationProxy.SendMessageWithResult<TAniCalculations>(PM_GET_ANICALCULATIONS, Result);
end;

function TCustomPresentedScrollBox.GetAutoHide: TBehaviorBoolean;
begin
  Result := Model.AutoHide;
end;

function TCustomPresentedScrollBox.GetBounces: TBehaviorBoolean;
begin
  Result := Model.Bounces;
end;

procedure TCustomPresentedScrollBox.SetScrollAnimation(const Value: TBehaviorBoolean);
begin
  Model.ScrollAnimation := Value;
end;

procedure TCustomPresentedScrollBox.SetScrollDirection(const Value: TScrollDirections);
begin
  Model.ScrollDirections := Value;
  UpdateContentSize;
end;

procedure TCustomPresentedScrollBox.SetShowScrollBars(const Value: Boolean);
begin
  Model.ShowScrollBars := Value;
end;

procedure TCustomPresentedScrollBox.SetShowSizeGrip(const Value: Boolean);
begin
  Model.ShowSizeGrip := Value;
end;

procedure TCustomPresentedScrollBox.SetTouchTracking(const Value: TBehaviorBoolean);
begin
  Model.TouchTracking := Value;
end;

function TCustomPresentedScrollBox.GetScrollAnimation: TBehaviorBoolean;
begin
  Result := Model.ScrollAnimation;
end;

function TCustomPresentedScrollBox.GetScrollDirections: TScrollDirections;
begin
  Result := Model.ScrollDirections;
end;

function TCustomPresentedScrollBox.GetShowScrollBars: Boolean;
begin
  Result := Model.ShowScrollBars;
end;

function TCustomPresentedScrollBox.GetShowSizeGrip: Boolean;
begin
  Result := Model.ShowSizeGrip;
end;

function TCustomPresentedScrollBox.GetTabList: ITabList;
begin
  Result := FContent.GetTabList;
end;

function TCustomPresentedScrollBox.GetTouchTracking: TBehaviorBoolean;
begin
  Result := Model.TouchTracking;
end;

procedure TCustomPresentedScrollBox.SetViewportPosition(const Value: TPointF);
begin
  Model.ViewportPosition := Value;
end;

procedure TCustomPresentedScrollBox.Sort(Compare: TFmxObjectSortCompare);
begin
  FContent.Sort(Compare);
end;

procedure TCustomPresentedScrollBox.UpdateContentSize;
var
  ContentBounds: TRectF;
begin
  if ([csLoading, csDestroying] * ComponentState = []) and Model.AutoCalculateContentSize then
  begin
    ContentBounds := DoCalcContentBounds;
    // User can place control on negative side, outside of left and top sides of content. In this case we need to exclude
    // negative area from ContentBounds
    if (ContentBounds.Right < 0) or (ContentBounds.Bottom < 0) then
      ContentBounds := TRectF.Empty
    else
      ContentBounds.TopLeft := TPointF.Zero;
    ContentSize.SetSizeWithoutChecks(ContentBounds.Size);
  end;
end;

procedure TCustomPresentedScrollBox.WriteViewportHeight(Writer: TWriter);
begin
  Writer.WriteFloat(RoundTo(ViewportSize.Height, -1));
end;

procedure TCustomPresentedScrollBox.WriteViewportWidth(Writer: TWriter);
begin
  Writer.WriteFloat(RoundTo(ViewportSize.Width, -1));
end;

function TCustomPresentedScrollBox.GetViewportPosition: TPointF;
begin
  Result := Model.ViewportPosition;
end;

function TCustomPresentedScrollBox.GetViewportSize: TSizeF;
begin
  Result := Model.ViewportSize;
end;

function TCustomPresentedScrollBox.GetVScrollBar: TScrollBar;
begin
  Result := nil;
  if HasPresentationProxy then
    PresentationProxy.SendMessageWithResult<TScrollBar>(PM_GET_VSCROLLBAR, Result);
end;

procedure TCustomPresentedScrollBox.InitPresentation(APresentation: TPresentationProxy);
begin
  inherited;
  APresentation.SendMessage<TScrollContent>(PM_SET_CONTENT, Content);
end;

procedure TCustomPresentedScrollBox.InViewRect(const ARect: TRectF; const AAnimated: Boolean = True);
var
  ViewRectInfo: TCustomScrollBoxModel.TInViewRectInfo;
begin
  if HasPresentationProxy then
  begin
    ViewRectInfo.Animated := AAnimated;
    ViewRectInfo.Rect := ARect;
    PresentationProxy.SendMessage<TCustomScrollBoxModel.TInViewRectInfo>(PM_SCROLL_IN_RECT, ViewRectInfo);
  end;
end;

function TCustomPresentedScrollBox.IsAddToContent(const AObject: TFmxObject): Boolean;
begin
  Result := (FContent <> nil) and (AObject <> FContent) and (AObject <> ResourceLink) and not (AObject is TEffect)
    and not (AObject is TAnimation) and (not HasPresentationProxy or (AObject <> PresentationProxy.Receiver))
    and not (PresentationState in [TPresentationState.Loading, TPresentationState.Unloading]);
end;

function TCustomPresentedScrollBox.IsOpaque: Boolean;
begin
  Result := False;
end;

procedure TCustomPresentedScrollBox.Loaded;
begin
  inherited;
  FContent.Loaded; // ensure that FixupTabList is called for FContent
  UpdateContentSize;
end;

procedure TCustomPresentedScrollBox.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
  Info: TMouseWheelInfo;
begin
  inherited;
  if HasPresentationProxy and (csDesigning in ComponentState) then
  begin
    Info.Shift := Shift;
    Info.WheelDelta := WheelDelta;
    Info.Handled := Handled;
    PresentationProxy.SendMessageWithResult<TMouseWheelInfo>(PM_MOUSE_WHEEL, Info);
    Handled := Info.Handled;
  end;
end;

procedure TCustomPresentedScrollBox.PaddingChanged;
begin
  inherited;
  Content.Padding.Assign(Padding);
end;

procedure TCustomPresentedScrollBox.PaintChildren;
begin
  if HasPresentationProxy then
  begin
    // We use these notification for correct order of painting style and content. It allows to paint scrollbox
    // above content
    PresentationProxy.SendMessage(PM_BEGIN_PAINT_CHILDREN);
    try
      inherited;
    finally
      PresentationProxy.SendMessage(PM_END_PAINT_CHILDREN);
    end;
  end
  else
    inherited;
end;

procedure TCustomPresentedScrollBox.ReadSizeValue(AReader: TReader; var ASize: Single);
var
  Value: Double;
begin
  case AReader.NextValue of
    vaExtended:
      Value := AReader.ReadFloat;
    vaDouble:
      Value := AReader.ReadDouble;
    vaSingle:
      Value := AReader.ReadSingle;
    vaInt32:
      Value := AReader.ReadInteger;
  else
    AReader.SkipValue;
    Exit;
  end;
  ASize := RoundTo(Value, -1);
end;

procedure TCustomPresentedScrollBox.ReadViewportHeight(Reader: TReader);
var
  Value: Single;
begin
  ReadSizeValue(Reader, Value);
  //Model.ViewportSize := TSizeF.Create(Model.ViewportSize.Width, Value);
end;

procedure TCustomPresentedScrollBox.ReadViewportWidth(Reader: TReader);
var
  Value: Single;
begin
  ReadSizeValue(Reader, Value);
  //Model.ViewportSize := TSizeF.Create(Value, (Model.ViewportSize.Height);
end;

procedure TCustomPresentedScrollBox.RealignContent;
begin
  UpdateContentSize;
end;

procedure TCustomPresentedScrollBox.ScrollBy(const ADX, ADY: Single; const AAnimated: Boolean = True);
var
  ScrollInfo: TCustomScrollBoxModel.TScrollByInfo;
begin
  if HasPresentationProxy then
  begin
    ScrollInfo.Vector := TPointF.Create(ADX, ADY);
    ScrollInfo.Animated := AAnimated;
    PresentationProxy.SendMessage<TCustomScrollBoxModel.TScrollByInfo>(PM_SCROLL_BY, ScrollInfo);
  end;
end;

procedure TCustomPresentedScrollBox.ScrollTo(const AX, AY: Single; const AAnimated: Boolean);
var
  CurrentViewPosition: TPointF;
begin
  if HasPresentationProxy then
  begin
    CurrentViewPosition := ViewportPosition;
    ScrollBy(AX - CurrentViewPosition.X, AY - CurrentViewPosition.Y, AAnimated);
  end;
end;

procedure TCustomPresentedScrollBox.ScrollToCenter(const AAnimated: Boolean);
var
  ContentBoundsTmp: TRectF;
  ViewportSizeTmp: TSizeF;
  DestPoint: TPointF;
begin
  ContentBoundsTmp := ContentBounds;
  ViewportSizeTmp := ViewportSize;
  DestPoint := TPointF.Create((ContentBoundsTmp.Width - ViewportSizeTmp.Width) / 2, (ContentBoundsTmp.Height - ViewportSizeTmp.Height) /2);
  ScrollBy(DestPoint.X - ViewportPosition.X, DestPoint.Y - ViewportPosition.Y, AAnimated);
end;

procedure TCustomPresentedScrollBox.ScrollToTop(const AAnimated: Boolean = True);
begin
  ScrollBy(0, -ViewportPosition.Y, AAnimated);
end;

{ TScrollContent }

procedure TScrollContent.ContentChanged;
begin
  inherited;
  FScrollBox.UpdateContentSize;
end;

constructor TScrollContent.Create(AOwner: TComponent);
begin
  inherited;
  if not (AOwner is TCustomPresentedScrollBox) then
    raise EArgumentException.Create(SScrollBoxOwnerWrong);
  FScrollBox := TCustomPresentedScrollBox(AOwner);
  ClipChildren := True;
  SetAcceptsControls(False);
end;

procedure TScrollContent.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  FScrollBox.ContentAddObject(AObject);
end;

function TScrollContent.DoGetUpdateRect: TRectF;
begin
  // TControl.PaintTo unlinks control from parent. So in this case ParentControl can be nil.
  if ParentControl <> nil then
    Result := ParentControl.UpdateRect
  else
    Result := inherited;
end;

procedure TScrollContent.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  inherited;
  FScrollBox.ContentInsertObject(Index, AObject);
end;

procedure TScrollContent.DoRemoveObject(const AObject: TFmxObject);
begin
  FScrollBox.ContentBeforeRemoveObject(AObject);
  inherited;
  FScrollBox.ContentRemoveObject(AObject);
end;

function TScrollContent.GetClipRect: TRectF;
begin
  if FScrollBox.ViewportSize.IsZero then
    Result := FScrollBox.ContentBounds
  else
    Result := TRectF.Create(FScrollBox.ViewportPosition, FScrollBox.ViewportSize.Width, FScrollBox.ViewportSize.Height);
  if Assigned(FOnGetClipRect) then
    FOnGetClipRect(Self, Result);
end;

function TScrollContent.GetIgnoreControlPosition: Boolean;
begin
  Result := ScrollBox.ControlType = TControlType.Platform;
end;

function TScrollContent.ObjectAtPoint(P: TPointF): IControl;
begin
  Result := inherited;
  if Result <> nil then
  begin
    if FScene <> nil then
      P := FScene.ScreenToLocal(P);
    P := AbsoluteToLocal(P);
    if not ClipRect.Contains(P) then
      Result := nil;
  end;
end;

function TScrollContent.PointInObjectLocal(X, Y: Single): Boolean;
var
  LClipRect: TRectF;
begin
  LClipRect := GetClipRect;
  LClipRect.Inflate(TouchTargetExpansion.Left, TouchTargetExpansion.Top, TouchTargetExpansion.Right,
    TouchTargetExpansion.Bottom);
  Result := LClipRect.Contains(TPointF.Create(X, Y));
end;

{ TCustomPresentedVertScrollBox }

constructor TCustomPresentedVertScrollBox.Create(AOwner: TComponent);
begin
  inherited;
  ScrollDirections := TScrollDirections.Vertical;
end;

function TCustomPresentedVertScrollBox.GetDefaultStyleLookupName: string;
begin
  Result := ScrollBoxStyleName;
end;

{ TCustomPresentedHorzScrollBox }

constructor TCustomPresentedHorzScrollBox.Create(AOwner: TComponent);
begin
  inherited;
  ScrollDirections := TScrollDirections.Horizontal;
end;

function TCustomPresentedHorzScrollBox.GetDefaultStyleLookupName: string;
begin
  Result := ScrollBoxStyleName;
end;

{ TCustomPresentedFramedScrollBox }

function TCustomPresentedFramedScrollBox.IsOpaque: Boolean;
begin
  Result := True;
end;

{ TCustomFramedVertScrollBox }

function TCustomPresentedFramedVertScrollBox.GetDefaultStyleLookupName: string;
begin
  Result := FramedScrollBoxStyleName;
end;

function TCustomPresentedFramedVertScrollBox.IsOpaque: Boolean;
begin
  Result := True;
end;

{ TScrollContentSize }

procedure TScrollContentSize.AssignTo(Dest: TPersistent);
var
  DestContentSize: TScrollContentSize;
begin
  if Dest is TScrollContentSize then
  begin
    DestContentSize := TScrollContentSize(Dest);
    // Don't copy size by width and height separately, it
    DestContentSize.Size := TSizeF.Create(Width, Height);
  end
  else
    inherited;
end;

function TScrollContentSize.IsReadOnly: Boolean;
begin
  Result := ScrollBox.AutoCalculateContentSize;
end;

constructor TScrollContentSize.Create(AOwner: TComponent; const AOnChange: TNotifyEvent);
begin
  inherited Create;
  if AOwner is TCustomPresentedScrollBox then
    FScrollBox := TCustomPresentedScrollBox(AOwner)
  else
    raise EArgumentException.Create(SScrollBoxOwnerWrong);
  FOnInternalChange := AOnChange;
end;

procedure TScrollContentSize.DoChanged;
begin
  if Assigned(FOnInternalChange) then
    FOnInternalChange(Self);
end;

function TScrollContentSize.GetOwner: TPersistent;
begin
  Result := FScrollBox;
end;

function TScrollContentSize.GetSize: TSizeF;
begin
  Result := TSizeF.Create(Width, Height);
end;

procedure TScrollContentSize.SetHeight(const Value: Single);
begin
  if not SameValue(Height, Value, TEpsilon.Position) and not IsReadOnly then
  begin
    FHeight := Max(Value, 0);
    DoChanged;
  end;
end;

procedure TScrollContentSize.SetSize(const Value: TSizeF);
begin
  if (Value <> Size) and not IsReadOnly then
    SetSizeWithoutChecks(Value);
end;

procedure TScrollContentSize.SetSizeWithoutChecks(const Value: TSizeF);
begin
  if Value <> Size then
  begin
    FWidth := Max(Value.Width, 0);
    FHeight := Max(Value.Height, 0);
    DoChanged;
  end;
end;

procedure TScrollContentSize.SetWidth(const Value: Single);
begin
  if not SameValue(Width, Value, TEpsilon.Position) and not IsReadOnly then
  begin
    FWidth := Max(Value, 0);
    DoChanged;
  end;
end;

function TScrollContentSize.StoreWidthHeight: Boolean;
begin
  Result := (FScrollBox <> nil) and not FScrollBox.AutoCalculateContentSize;
end;

initialization
  RegisterFmxClasses([TPresentedScrollBox]);
end.
