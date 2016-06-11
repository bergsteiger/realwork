{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Styles.Objects;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Types, System.UITypes, System.UIConsts, System.Math, System.SysUtils, System.Messaging,
  System.StrUtils, System.Math.Vectors, FMX.Types, FMX.Controls, FMX.TextLayout, FMX.Text, FMX.Platform, FMX.Ani,
  FMX.MultiResBitmap, FMX.Objects, FMX.Graphics;

type
  TStyleTrigger = (MouseOver, Pressed, Selected, Focused, Checked, Active);

  TStyleTriggerHelper = record helper for TStyleTrigger
  const
    stMouseOver = TStyleTrigger.MouseOver deprecated 'Use TStyleTrigger.MouseOver';
    stPressed = TStyleTrigger.Pressed deprecated 'Use TStyleTrigger.Pressed';
    stSelected = TStyleTrigger.Selected deprecated 'Use TStyleTrigger.Selected';
    stFocused = TStyleTrigger.Focused deprecated 'Use TStyleTrigger.Focused';
    stChecked = TStyleTrigger.Checked deprecated 'Use TStyleTrigger.Checked';
    stActive = TStyleTrigger.Active deprecated 'Use TStyleTrigger.Active';
  end;

{ Image Objects }

  TBitmapLink = class(TCollectionItem)
  private
    FCapInsetsChanged: Boolean;
    FCapInsets: TBounds;
    FSourceRect: TBounds;
    FScale: Single;
    procedure SetCapInsets(const Value: TBounds);
    procedure SetSourceRect(const Value: TBounds);
    procedure SetScale(const Value: Single);
    procedure DoCapInsetsChanged(Sender: TObject);
    function IsScaleStored: Boolean;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property CapInsetsChanged: Boolean read FCapInsetsChanged;
  published
    property CapInsets: TBounds read FCapInsets write SetCapInsets;
    property Scale: Single read FScale write SetScale stored IsScaleStored;
    property SourceRect: TBounds read FSourceRect write SetSourceRect;
  end;

  TCapWrapMode = (Stretch, Tile);

  TCapWrapModeHelper = record helper for TCapWrapMode
  const
    cmStretch = TCapWrapMode.Stretch deprecated 'Use TCapWrapMode.Stretch';
    cmTile = TCapWrapMode.Tile deprecated 'Use TCapWrapMode.Tile';
  end;

  TBitmapLinks = class(TCollection)
  public type
    TPropertyLoader = class
    private
      FFiler: TFiler;
      FInstance: TBitmapLinks;
      FPropertyName: string;
      procedure ReadBitmapMargin(Reader: TReader);
      procedure ReadSourceRect(Reader: TReader);
      procedure ReadBitmapMargin15x(Reader: TReader);
      procedure ReadSourceRect15x(Reader: TReader);
      procedure ReadBitmapMargin20x(Reader: TReader);
      procedure ReadSourceRect20x(Reader: TReader);
      procedure ReadBitmapMargin30x(Reader: TReader);
      procedure ReadSourceRect30x(Reader: TReader);
      function FindOrCreateBitmapLink(const Scale: Single): TBitmapLink;
      procedure ReadBitmapLinkSourceRect(Reader: TReader; const Scale: Single);
      procedure ReadBitmapLinkCapInsets(Reader: TReader; const Scale: Single);
    public
      constructor Create(const AInstance: TBitmapLinks; const AFiler: TFiler; const APropertyName: string = '');
      procedure ReadSourceRects;
      procedure ReadCapInsets;
      property Instance: TBitmapLinks read FInstance;
      property PropertyName: string read FPropertyName;
      property Filer: TFiler read FFiler;
    end;
  private
    function GetLink(AIndex: Integer): TBitmapLink;
    function GetEmpty: Boolean;
  public
    constructor Create;
    procedure AssignCapInsets(const Source: TBitmapLinks);
    function LinkByScale(const AScale: Single; const ExactMatch: Boolean): TBitmapLink;
    property Links[AIndex: Integer]: TBitmapLink read GetLink;
    property Empty: Boolean read GetEmpty;
  end;

  TCustomStyleObject = class(TControl, IDrawableObject)
  public type
    TTintStage = (Undefined, Shadow, Mask, Shine);
  private
    FOpaque: Boolean;
    FSource: TImage;
    FSourceLookup: string;
    FCapMode: TCapWrapMode;
    FWrapMode: TImageWrapMode;
    FTintColor: TAlphaColor;
    FTintBuffer: TBitmap;
    FNeedsUpdateTintBuffer: Boolean;
    FTintStage: TTintStage;
    procedure SetCapMode(const Value: TCapWrapMode);
    procedure SetWrapMode(const Value: TImageWrapMode);
    procedure ReadOpaque(Reader: TReader);
    procedure WriteOpaque(Writer: TWriter);
    procedure SetOpaque(const Value: Boolean);
    procedure SetSource(const Value: TImage);
    procedure SetSourceLookup(const Value: string);
    procedure ReadMarginWrapMode(Reader: TReader);
  class var
    FAlignToPixels: Boolean;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Paint; override;
    procedure FreeNotification(AObject: TObject); override;
    procedure DoDrawToCanvas(const Canvas: TCanvas; const ARect: TRectF; const AOpacity: Single = 1.0);
    function DoGetUpdateRect: TRectF; override;
  protected
    function GetCurrentLink: TBitmapLinks; virtual; abstract;
    function GetCanBeTinted: Boolean; virtual;
    procedure PrepareTintBuffer(const Canvas: TCanvas; const ATintColor: TAlphaColor);
    procedure NeedsUpdateTintBuffer;
    procedure SetTintColor(const ATintColor: TAlphaColor);
    property CanBeTinted: Boolean read GetCanBeTinted;
    property TintColor: TAlphaColor read FTintColor write SetTintColor;
    property TintStage: TTintStage read FTintStage;
    property TintBuffer: TBitmap read FTintBuffer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DrawToCanvas(const Canvas: TCanvas; const ARect: TRectF; const AOpacity: Single = 1.0); overload; inline;
    procedure DrawToCanvas(const Canvas: TCanvas; const ARect: TRectF; const ATintColor: TAlphaColor;
      const AOpacity: Single = 1.0); overload;
    function IsEmpty: Boolean;
    property Opaque: Boolean read FOpaque write SetOpaque;
    property Source: TImage read FSource write SetSource;
    class function ScreenScaleToStyleScale(const ScreenScale: Single): Single;
    class property AlignToPixels: Boolean read FAlignToPixels write FAlignToPixels;
  published
    property Align;
    property Anchors;
    property CapMode: TCapWrapMode read FCapMode write SetCapMode default TCapWrapMode.Stretch;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default False;
    property Padding;
    property Opacity;
    property Margins;
    property SourceLookup: string read FSourceLookup write SetSourceLookup;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Size;
    property Scale;
    property WrapMode: TImageWrapMode read FWrapMode write SetWrapMode default TImageWrapMode.Stretch;
    property Visible default True;
    property Width;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnKeyDown;
    property OnKeyUp;
    property OnCanFocus;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

  TStyleObject = class(TCustomStyleObject)
  private
    FSourceLink: TBitmapLinks;
    procedure SetSourceLink(const Value: TBitmapLinks);
  protected
    function GetCurrentLink: TBitmapLinks; override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property SourceLink: TBitmapLinks read FSourceLink write SetSourceLink;
  end;

  ///<summary>Helpers class that incapsulated touch animation behavior, that should be attached to other style object.</summary>
  TTouchAnimationAdapter = class(TPersistent)
  public type
    TAnimationKind = (Pressed, Unpressed);
    TCustomPaint = procedure of object;
  public const
    DefaultUnpressingDuration = 0.3;
    DefaultPressingDuration = 1;
  type
    TTouchAnimation = class(TAnimation)
    private
      [Weak] FAdapter: TTouchAnimationAdapter;
    protected
      procedure ProcessAnimation; override;
    end;
    TTouchAnimationObject = class(TCustomStyleObject)
    private
      [Weak] FAdapter: TTouchAnimationAdapter;
    protected
      function GetCurrentLink: TBitmapLinks; override;
    end;
  private
    [Weak] FStyleObject: TCustomStyleObject;
    FTouchAnimation: TTouchAnimation;
    FTouchAnimationObject: TTouchAnimationObject;
    FLink: TBitmapLinks;
    FPressedPosition: TPointF;
    FPressingDuration: Single;
    FUnpressingDuration: Single;
    FPadding: TBounds;
    FCustomPaint: TCustomPaint;
    procedure SetLink(const Value: TBitmapLinks);
    function PressingDurationStored: Boolean;
    function UnpressingDurationStored: Boolean;
    procedure SetPadding(const Value: TBounds);
    procedure ReadPaddingRect(Reader: TReader);
    procedure CreateTouchAnimation;
  public
    constructor Create(const AStyleObject: TCustomStyleObject); virtual;
    destructor Destroy; override;
    ///<summary>Manually start animation.</summary>
    procedure StartAnimation(const Control: TControl; const Kind: TAnimationKind);
    ///<summary>Manually stop animation.</summary>
    procedure StopAnimation;
    ///<summary>Draw touch animation stage.</summary>
    procedure DrawTouchAnimation(const Canvas: TCanvas; const Rect: TRectF);
    ///<summary>Helpers that used in Owner's StartTriggerAnimation in order to activate touch animation.</summary>
    procedure StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string);
    ///<summary>Helpers that used in Owner's DefineProperty</summary>
    procedure DefineTouchAnimationProperty(Filer: TFiler);
    ///<summary>Return True if touch animation is available in the style</summary>
    function LinkExists: Boolean;
    ///<summary>Link to Owner</summary>
    property TouchAnimation: TTouchAnimation read FTouchAnimation;
    ///<summary>Callback property called when touch animation runs.</summary>
    property CustomPaint: TCustomPaint read FCustomPaint write FCustomPaint;
  published
    /// <summary>Part of bitmap which used to draw touch animation</summary>
    property Link: TBitmapLinks read FLink write SetLink;
    /// <summary>Duration of animation that started after touch is down</summary>
    property PressingDuration: Single read FPressingDuration write FPressingDuration stored PressingDurationStored;
    /// <summary>Duration of animation that started after touch is up</summary>
    property UnpressingDuration: Single read FUnpressingDuration write FUnpressingDuration
      stored UnpressingDurationStored;
    /// <summary>Size of the border that decreases animation painting rectangle.</summary>
    property Padding: TBounds read FPadding write SetPadding;
  end;

  TTintedStages = class(TPersistent)
  private
    [Weak] FStyleObject: TCustomStyleObject;
    FShadow: TBitmapLinks;
    FMask: TBitmapLinks;
    FShine: TBitmapLinks;
    procedure SetMask(const Value: TBitmapLinks);
    procedure SetShadow(const Value: TBitmapLinks);
    procedure SetShine(const Value: TBitmapLinks);
  public
    constructor Create(const AStyleObject: TCustomStyleObject);
    destructor Destroy; override;
    /// <summary>Link to owner style object</summary>
    property StyleObject: TCustomStyleObject read FStyleObject;
  published
    property Shadow: TBitmapLinks read FShadow write SetShadow;
    property Mask: TBitmapLinks read FMask write SetMask;
    property Shine: TBitmapLinks read FShine write SetShine;
  end;

  TTintedStyleObject = class(TStyleObject, ITintedObject)
  private
    FTint: TTintedStages;
    procedure SetTint(const Value: TTintedStages);
  protected
    function GetCurrentLink: TBitmapLinks; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;
    { ITintedObject }
    function GetCanBeTinted: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Tint: TTintedStages read FTint write SetTint;
  end;

  /// <summary>Interface to access to touch animation adapter</summary>
  ITouchAnimationObject = interface
  ['{75657913-BED4-45CA-A394-B27BF7B2225F}']
    function GetTouchAnimation: TTouchAnimationAdapter;
    /// <summary>Access property to touch animation adapter</summary>
    property TouchAnimation: TTouchAnimationAdapter read GetTouchAnimation;
  end;

  // XE3 Compatible
  TSubImage = class(TStyleObject);

  TActiveStyleObject = class(TCustomStyleObject, ITouchAnimationObject)
  private
    FSourceLink: TBitmapLinks;
    FActive: Boolean;
    FActiveLink: TBitmapLinks;
    FActiveAnimation: TAnimation;
    FTrigger: TStyleTrigger;
    FOnTriggered: TNotifyEvent;
    FTouchAnimation: TTouchAnimationAdapter;
    procedure SetActiveLink(const Value: TBitmapLinks);
    procedure SetTrigger(const Value: TStyleTrigger);
    procedure SetSourceLink(const Value: TBitmapLinks);
    procedure Triggered(Sender: TObject);
    procedure SetTouchAnimation(const Value: TTouchAnimationAdapter);
    { ITouchAnimationObject }
    function GetTouchAnimation: TTouchAnimationAdapter;
  protected
    procedure DoTriggered; virtual;
    procedure SetupAnimations; virtual;
    function GetCurrentLink: TBitmapLinks; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;
    procedure Paint; override;
    property OnTriggered: TNotifyEvent read FOnTriggered write FOnTriggered;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string); override;
  published
    property ActiveTrigger: TStyleTrigger read FTrigger write SetTrigger;
    property ActiveLink: TBitmapLinks read FActiveLink write SetActiveLink;
    property SourceLink: TBitmapLinks read FSourceLink write SetSourceLink;
    ///<summary>Used to add touch animation to the style object</summary>
    property TouchAnimation: TTouchAnimationAdapter read FTouchAnimation write SetTouchAnimation;
  end;

  TTabStyleObject = class(TCustomStyleObject)
  private type
    TTransitionRec = record
      Animation: TAnimation;
      Event: TNotifyEvent;
    end;
  protected type
    TLink = (Active, Source, Hot, ActiveHot, Focused, ActiveFocused);
    TState = (Active, Hot, Focused);
  private
    FBitmapLinks: array [TLink] of TBitmapLinks;
    FTransitions: array [TState] of TTransitionRec;
    FActiveTrigger: TStyleTrigger;
    FState: set of TState;
    procedure SetActiveTrigger(const Value: TStyleTrigger);
    function GetLink(Index: TLink): TBitmapLinks;
    procedure SetLink(Index: TLink; const Value: TBitmapLinks);
    function GetEvent(Index: TState): TNotifyEvent;
    procedure SetEvent(Index: TState; const Value: TNotifyEvent);
    procedure InvokeEvent(Index: TState);

    procedure HotTriggered(Sender: TObject);
    procedure FocusedTriggered(Sender: TObject);
    procedure ActiveTriggered(Sender: TObject);
  protected
    procedure SetupAnimations; virtual;
    function GetCurrentLink: TBitmapLinks; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;
    property OnHotTriggered: TNotifyEvent index TLink.Hot read GetEvent write SetEvent;
    property OnFocusedTriggered: TNotifyEvent index TLink.Focused read GetEvent write SetEvent;
    property OnActiveTriggered: TNotifyEvent index TLink.Active read GetEvent write SetEvent;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string); override;
  published
    property ActiveTrigger: TStyleTrigger read FActiveTrigger write SetActiveTrigger;
    property ActiveLink: TBitmapLinks index TLink.Active read GetLink write SetLink;
    property SourceLink: TBitmapLinks index TLink.Source read GetLink write SetLink;
    property HotLink: TBitmapLinks index TLink.Hot read GetLink write SetLink;
    property ActiveHotLink: TBitmapLinks index TLink.ActiveHot read GetLink write SetLink;
    property FocusedLink: TBitmapLinks index TLink.Focused read GetLink write SetLink;
    property ActiveFocusedLink: TBitmapLinks index TLink.ActiveFocused read GetLink write SetLink;
  end;

  TCheckStyleObject = class(TTabStyleObject)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TButtonAnimation = (Normal, Hot, Pressed, Focused);  // Don't change order for compatibility with TFontColorForState.TIndex

  TButtonStyleObject = class(TCustomStyleObject)
  private type
    TTriggerAndLink = record
      Animation: TAnimation;
      Link: TBitmapLinks;
    end;
  private
    FCurrent: TButtonAnimation;
    FTriggerSources: array [TButtonAnimation] of TTriggerAndLink;
    FOnNormalTriggered: TNotifyEvent;
    FOnHotTriggered: TNotifyEvent;
    FOnFocusedTriggered: TNotifyEvent;
    FOnPressedTriggered: TNotifyEvent;
    FTouchAnimation: TTouchAnimationAdapter;
    procedure NormalTriggered(Sender: TObject);
    procedure HotTriggered(Sender: TObject);
    procedure PressedTriggered(Sender: TObject);
    procedure FocusedTriggered(Sender: TObject);
    function GetLink(Index: TButtonAnimation): TBitmapLinks;
    procedure SetLink(Index: TButtonAnimation; const Value: TBitmapLinks);
    procedure SetTouchAnimation(const Value: TTouchAnimationAdapter);
  protected
    procedure DoNormalTriggered;
    procedure DoHotTriggered;
    procedure DoPressedTriggered;
    procedure DoFocusedTriggered;
    function GetCurrentLink: TBitmapLinks; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;
    procedure Paint; override;
    property OnNormalTriggered: TNotifyEvent read FOnNormalTriggered write FOnNormalTriggered;
    property OnHotTriggered: TNotifyEvent read FOnHotTriggered write FOnHotTriggered;
    property OnPressedTriggered: TNotifyEvent read FOnPressedTriggered write FOnPressedTriggered;
    property OnFocusedTriggered: TNotifyEvent read FOnFocusedTriggered write FOnFocusedTriggered;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string); override;
  published
    property HotLink: TBitmapLinks index TButtonAnimation.Hot read GetLink write SetLink;
    property FocusedLink: TBitmapLinks index TButtonAnimation.Focused read GetLink write SetLink;
    property NormalLink: TBitmapLinks index TButtonAnimation.Normal read GetLink write SetLink;
    property PressedLink: TBitmapLinks index TButtonAnimation.Pressed read GetLink write SetLink;
    ///<summary>Used to add touch animation to the style object</summary>
    property TouchAnimation: TTouchAnimationAdapter read FTouchAnimation write SetTouchAnimation;
  end;

  TTintedButtonStyleObject = class(TButtonStyleObject, ITintedObject)
  private
    FTintSources: array [TButtonAnimation] of TTintedStages;
    function GetTintStage(const Index: TButtonAnimation): TTintedStages;
    procedure SetTintStage(const Index: TButtonAnimation; const Value: TTintedStages);
  protected
    procedure Loaded; override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetCurrentLink: TBitmapLinks; override;
    { ITintedObject }
    function GetCanBeTinted: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property HotTint: TTintedStages index TButtonAnimation.Hot read GetTintStage write SetTintStage;
    property NormalTint: TTintedStages index TButtonAnimation.Normal read GetTintStage write SetTintStage;
    property FocusedTint: TTintedStages index TButtonAnimation.Focused read GetTintStage write SetTintStage;
    property PressedTint: TTintedStages index TButtonAnimation.Pressed read GetTintStage write SetTintStage;
  end;

  TSystemButtonObject = class(TButtonStyleObject)
  private
    FInactive: Boolean;
    FInactiveAnimation: TAnimation;
    FInactiveLink: TBitmapLinks;
    procedure SetInactiveLink(const Value: TBitmapLinks);
    procedure InactiveTriggered(Sender: TObject);
  protected
    function GetCurrentLink: TBitmapLinks; override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property InactiveLink: TBitmapLinks read FInactiveLink write SetInactiveLink;
  end;

  TMaskedImage = class(TImage)
  private
    FContentObject: TCustomStyleObject;
    FBuffer: TBitmap;
    FNeedsUpdate: Boolean;
    procedure PrepareBuffer;
    function GetSourceLookup: string;
    procedure SetSourceLookup(const Value: string);
    procedure ReadMarginWrapMode(Reader: TReader);
    procedure ReadWrapMode(Reader: TReader);
  protected
    function CreateContentObject: TCustomStyleObject; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoChanged; override;
    procedure Paint; override;
    procedure NeedsUpdate;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string); override;
  published
    property ContentObject: TCustomStyleObject read FContentObject;
    property SourceLookup: string read GetSourceLookup write SetSourceLookup stored False;
  end;

  TActiveMaskedImage = class(TMaskedImage)
  private
    function GetTrigger: TStyleTrigger;
    procedure SetTrigger(const Value: TStyleTrigger);
    procedure DoTriggered(Sender: TObject);
  protected
    function CreateContentObject: TCustomStyleObject; override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ActiveTrigger: TStyleTrigger read GetTrigger write SetTrigger stored False;
  end;

{ Text Objects }

  TStyleShadow = class(TPersistent)
  private
    FColor: TAlphaColor;
    FOnChanged: TNotifyEvent;
    FOffset: TPosition;
    procedure SetColor(const Value: TAlphaColor);
    procedure SetOffset(const Value: TPosition);
  protected
    procedure DoChanged; virtual;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Equals(Obj: TObject): Boolean; override;
  published
    property Color: TAlphaColor read FColor write SetColor default claNull;
    property Offset: TPosition read FOffset write SetOffset;
  end;

  TStyleTextObject = class(TText, IDrawableObject)
  private
    FSavedShadow: TStyleShadow;
    FShadow: TStyleShadow;
    FShadowVisible: Boolean;
    FCharCase: TEditCharCase;
    FCurrentColor: TAlphaColor;
    FCurrentShadow: TStyleShadow;
    procedure SetShadow(const Value: TStyleShadow);
    procedure SetShadowVisible(const Value: Boolean);
    procedure SetCharCase(const Value: TEditCharCase);
    function GetSavedColor: TAlphaColor;
  protected
    procedure Paint; override;
    function ConvertText(const Value: string): string; override;
    procedure ShadowChanged;
    procedure FontChanged; override;
    procedure UpdateDefaultTextSettings; override;
    function UpdateCurrentProperties: Boolean; virtual;
    function SetCurrentProperties(const AColor: TAlphaColorRec; const AShadow: TStyleShadow): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DrawToCanvas(const Canvas: TCanvas; const ARect: TRectF; const AOpacity: Single = 1.0);
    property SavedColor: TAlphaColor read GetSavedColor;
    property SavedShadow: TStyleShadow read FSavedShadow;
    property CurrentColor: TAlphaColor read FCurrentColor;
    property CurrentShadow: TStyleShadow read FCurrentShadow;
  published
    property CharCase: TEditCharCase read FCharCase write SetCharCase default TEditCharCase.ecNormal;
    property Color stored False;
    property Shadow: TStyleShadow read FShadow write SetShadow;
    property ShadowVisible: Boolean read FShadowVisible write SetShadowVisible;
    property HitTest default False;
  end;

  TStyleTextAnimation = class(TAnimation)
  private
    FColor: TAlphaColor;
    FShadow: TStyleShadow;
    procedure SetShadow(const Value: TStyleShadow);
  protected
    procedure ProcessAnimation; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function CreateAnimation(const Trigger: string; const Event: TNotifyEvent): TStyleTextAnimation;
    procedure AssignIfEmpty(const StyleTextObject: TStyleTextObject);
    property Color: TAlphaColor read FColor write FColor;
    property Shadow: TStyleShadow read FShadow write SetShadow;
  end;

  TActiveStyleTextObject = class(TStyleTextObject)
  private
    FTrigger: TStyleTrigger;
    FActiveAnimation: TStyleTextAnimation;
    FActive: Boolean;
    FSavedActive: Boolean;
    procedure SetTrigger(const Value: TStyleTrigger);
    function GetActiveColor: TAlphaColor;
    function GetActiveShadow: TStyleShadow;
    procedure SetActiveColor(const Value: TAlphaColor);
    procedure SetActiveShadow(const Value: TStyleShadow);
    procedure SetActive(const Value: Boolean);
  protected
    procedure Triggered(Sender: TObject);
    procedure SetupAnimations; virtual;
    function UpdateCurrentProperties: Boolean; override;
    procedure Loaded; override;
    function SaveState: Boolean; override;
    function RestoreState: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string); override;
    property Active: Boolean read FActive write SetActive;
  published
    property ActiveTrigger: TStyleTrigger read FTrigger write SetTrigger;
    property ActiveColor: TAlphaColor read GetActiveColor write SetActiveColor;
    property ActiveShadow: TStyleShadow read GetActiveShadow write SetActiveShadow;
  end;

  TTabStyleTextObject = class(TActiveStyleTextObject)
  private
    FHotAnimation: TStyleTextAnimation;
    FHot: Boolean;
    FSavedHot: Boolean;
    procedure SetHotColor(const Value: TAlphaColor);
    procedure SetHotShadow(const Value: TStyleShadow);
    function GetHotColor: TAlphaColor;
    function GetHotShadow: TStyleShadow;
    procedure SetHot(const Value: Boolean);
  protected
    procedure HotTriggered(Sender: TObject);
    procedure SetupAnimations; override;
    procedure Loaded; override;
    function UpdateCurrentProperties: Boolean; override;
    function SaveState: Boolean; override;
    function RestoreState: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string); override;
    property Hot: Boolean read FHot write SetHot;
  published
    property HotColor: TAlphaColor read GetHotColor write SetHotColor default claNull;
    property HotShadow: TStyleShadow read GetHotShadow write SetHotShadow;
  end;

  TButtonStyleTextObject = class(TStyleTextObject)
  private
    FTriggerSources: array [TButtonAnimation] of TStyleTextAnimation;
    FButtonState: TButtonAnimation;
    FSavedButtonState: TButtonAnimation;
    procedure NormalTriggered(Sender: TObject);
    procedure HotTriggered(Sender: TObject);
    procedure PressedTriggered(Sender: TObject);
    procedure FocusedTriggered(Sender: TObject);
    function GetColor(Index: TButtonAnimation): TAlphaColor;
    procedure SetColor(Index: TButtonAnimation; const Value: TAlphaColor);
    function GetShadow(Index: TButtonAnimation): TStyleShadow;
    procedure SetShadow(Index: TButtonAnimation; const Value: TStyleShadow);
    procedure SetButtonState(const Value: TButtonAnimation);
    procedure GetFontColors(var AColors, ADefColors: TFontColorForState);
  protected
    procedure Loaded; override;
    procedure UpdateDefaultTextSettings; override;
    function UpdateCurrentProperties: Boolean; override;
    function GetTextSettingsClass: TTextSettingsClass; override;
    function SaveState: Boolean; override;
    function RestoreState: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string); override;
    property ButtonState: TButtonAnimation read FButtonState write SetButtonState;
  published
    property HotColor: TAlphaColor index TButtonAnimation.Hot read GetColor write SetColor default claNull;
    property HotShadow: TStyleShadow index TButtonAnimation.Hot read GetShadow write SetShadow;
    property FocusedColor: TAlphaColor index TButtonAnimation.Focused read GetColor write SetColor default claNull;
    property FocusedShadow: TStyleShadow index TButtonAnimation.Focused read GetShadow write SetShadow;
    property NormalColor: TAlphaColor index TButtonAnimation.Normal read GetColor write SetColor default claNull;
    property NormalShadow: TStyleShadow index TButtonAnimation.Normal read GetShadow write SetShadow;
    property PressedColor: TAlphaColor index TButtonAnimation.Pressed read GetColor write SetColor default claNull;
    property PressedShadow: TStyleShadow index TButtonAnimation.Pressed read GetShadow write SetShadow;
  end;

  TActiveOpacityObject = class(TControl)
  private
    FTrigger: TStyleTrigger;
    FActiveAnimation: TAnimation;
    FActiveOpacity: Single;
    FSavedOpacity: Single;
    function IsActiveOpacityStored: Boolean;
    procedure SetTrigger(const Value: TStyleTrigger);
    procedure Triggered(Sender: TObject);
  protected
    procedure SetupAnimation; virtual;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string); override;
  published
    property ActiveTrigger: TStyleTrigger read FTrigger write SetTrigger;
    property ActiveOpacity: Single read FActiveOpacity write FActiveOpacity stored IsActiveOpacityStored;
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default False;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    { Events }
    property OnPainting;
    property OnPaint;
    property OnResize;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Mouse events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

implementation

uses
  {$IFDEF MACOS}Macapi.CoreFoundation, {$ENDIF}
  System.TypInfo, System.RTLConsts, FMX.Consts, FMX.ImgList, FMX.Utils;

const
  WrapModes: array[0..4] of TIdentMapEntry = (
    (Value: Integer(TImageWrapMode.Original); Name: 'Original'),
    (Value: Integer(TImageWrapMode.Fit); Name: 'Fit'),
    (Value: Integer(TImageWrapMode.Stretch); Name: 'Stretch'),
    (Value: Integer(TImageWrapMode.Tile); Name: 'Tile'),
    (Value: Integer(TImageWrapMode.Center); Name: 'Center')
  );
  // Backward compatibility
  WrapModesWithPrefix: array[0..4] of TIdentMapEntry = (
    (Value: Integer(TImageWrapMode.Original); Name: 'iwOriginal'),
    (Value: Integer(TImageWrapMode.Fit); Name: 'iwFit'),
    (Value: Integer(TImageWrapMode.Stretch); Name: 'iwStretch'),
    (Value: Integer(TImageWrapMode.Tile); Name: 'iwTile'),
    (Value: Integer(TImageWrapMode.Center); Name: 'iwCenter')
  );

{ TBitmapLink }

procedure TBitmapLink.Assign(Source: TPersistent);
begin
  if Source is TBitmapLink then
  begin
    SetScale(TBitmapLink(Source).Scale);
    SetCapInsets(TBitmapLink(Source).CapInsets);
    SetSourceRect(TBitmapLink(Source).SourceRect);
  end;
end;

constructor TBitmapLink.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FScale := 1;
  FSourceRect := TBounds.Create(NullRect);
  FCapInsets := TBounds.Create(NullRect);
  FCapInsets.OnChange := DoCapInsetsChanged;
end;

destructor TBitmapLink.Destroy;
begin
  FSourceRect.Free;
  FCapInsets.Free;
  inherited;
end;

procedure TBitmapLink.DoCapInsetsChanged(Sender: TObject);
begin
  FCapInsetsChanged := True;
end;

function TBitmapLink.IsScaleStored: Boolean;
begin
  Result := not SameValue(1.0, FScale, TEpsilon.Scale);
end;

procedure TBitmapLink.SetCapInsets(const Value: TBounds);
begin
  FCapInsets.Assign(Value);
end;

procedure TBitmapLink.SetScale(const Value: Single);
begin
  FScale := Value;
end;

procedure TBitmapLink.SetSourceRect(const Value: TBounds);
begin
  FSourceRect.Assign(Value);
end;

{ TBitmapLinks }

constructor TBitmapLinks.Create;
begin
  inherited Create(TBitmapLink);
end;

procedure TBitmapLinks.AssignCapInsets(const Source: TBitmapLinks);
var
  I: Integer;
begin
  inherited;
  if Count = Source.Count then
    for I := 0 to Source.Count - 1 do
      if not Links[I].CapInsetsChanged then
        Links[I].CapInsets := Source.Links[I].CapInsets;
end;

function TBitmapLinks.GetEmpty: Boolean;
begin
  Result := (Count = 0);
end;

function TBitmapLinks.GetLink(AIndex: Integer): TBitmapLink;
begin
  Result := TBitmapLink(Items[AIndex]);
end;

function TBitmapLinks.LinkByScale(const AScale: Single; const ExactMatch: Boolean): TBitmapLink;
var
  I, BestIndex: Integer;
  Delta, MinDelta: Single;
begin
  if ExactMatch then
  begin
    for I := 0 to Count - 1 do
      if SameValue(Links[I].Scale, AScale, TEpsilon.Scale) then
         Exit(Links[I]);
    Result := nil;
  end
  else
  begin
    MinDelta := 0;
    BestIndex := -1;
    for I := 0 to Count - 1 do
    begin
      Delta := Abs(Links[I].Scale - AScale);
      if AScale > Links[I].Scale then
        Delta := Delta + TEpsilon.Scale;
      if (BestIndex = -1) or (Delta < MinDelta) then
      begin
        MinDelta := Delta;
        BestIndex := I;
      end;
    end;
    if BestIndex >= 0 then
      Result := Links[BestIndex]
    else
      Result := nil;
  end;
end;

{ TBitmapLinks.TPropertyLoader }

constructor TBitmapLinks.TPropertyLoader.Create(const AInstance: TBitmapLinks; const AFiler: TFiler;
  const APropertyName: string);
begin
  if (AInstance = nil) or (AFiler = nil) then
    raise EArgumentNilException.Create(SArgumentNil);
  inherited Create;
  FInstance := AInstance;
  FFiler := AFiler;
  FPropertyName := APropertyName;
end;

function TBitmapLinks.TPropertyLoader.FindOrCreateBitmapLink(const Scale: Single): TBitmapLink;
begin
  Result := FInstance.LinkByScale(Scale, True);
  if Result = nil then
  begin
    Result := TBitmapLink.Create(Instance);
    Result.Scale := Scale;
  end;
end;

procedure TBitmapLinks.TPropertyLoader.ReadBitmapLinkCapInsets(Reader: TReader; const Scale: Single);
var
  Link: TBitmapLink;
begin
  Link := FindOrCreateBitmapLink(Scale);
  Link.CapInsets.Rect := TRectF.Create(StringToRect(Reader.ReadString));
end;

procedure TBitmapLinks.TPropertyLoader.ReadBitmapLinkSourceRect(Reader: TReader; const Scale: Single);
var
  Link: TBitmapLink;
begin
  Link := FindOrCreateBitmapLink(Scale);
  Link.SourceRect.Rect := TRectF.Create(StringToRect(Reader.ReadString));
end;

procedure TBitmapLinks.TPropertyLoader.ReadCapInsets;

  procedure ReadProperty(const Suffix: string; const ReadData: TReaderProc);
  var
    S: TStringBuilder;
  begin
    S := TStringBuilder.Create;
    try
      S.Append(PropertyName).Append(Suffix);
      Filer.DefineProperty(S.ToString, ReadData, nil, False);
    finally
      S.Free;
    end;
  end;

begin
  if PropertyName = '' then
  begin
    Filer.DefineProperty('BitmapMargins.Rect', ReadBitmapMargin, nil, False);
    Filer.DefineProperty('BitmapMargins15x.Rect', ReadBitmapMargin15x, nil, False);
    Filer.DefineProperty('BitmapMargins20x.Rect', ReadBitmapMargin20x, nil, False);
    Filer.DefineProperty('BitmapMargins30x.Rect', ReadBitmapMargin30x, nil, False);
  end
  else begin
    ReadProperty('.Rect', ReadBitmapMargin);
    ReadProperty('15x.Rect', ReadBitmapMargin15x);
    ReadProperty('20x.Rect', ReadBitmapMargin20x);
    ReadProperty('30x.Rect', ReadBitmapMargin30x);
  end;
end;

procedure TBitmapLinks.TPropertyLoader.ReadSourceRects;

  procedure ReadProperty(const Suffix: string; const ReadData: TReaderProc);
  var
    S: TStringBuilder;
  begin
    S := TStringBuilder.Create;
    try
      S.Append(PropertyName).Append(Suffix);
      Filer.DefineProperty(S.ToString, ReadData, nil, False);
    finally
      S.Free;
    end;
  end;

begin
  if PropertyName = '' then
  begin
    Filer.DefineProperty('SourceRect.Rect', ReadSourceRect, nil, False);
    Filer.DefineProperty('SourceRect15x.Rect', ReadSourceRect15x, nil, False);
    Filer.DefineProperty('SourceRect20x.Rect', ReadSourceRect20x, nil, False);
    Filer.DefineProperty('SourceRect30x.Rect', ReadSourceRect30x, nil, False);
  end
  else begin
    ReadProperty('.Rect', ReadSourceRect);
    ReadProperty('15x.Rect', ReadSourceRect15x);
    ReadProperty('20x.Rect', ReadSourceRect20x);
    ReadProperty('30x.Rect', ReadSourceRect30x);
  end;
end;

procedure TBitmapLinks.TPropertyLoader.ReadBitmapMargin(Reader: TReader);
begin
  ReadBitmapLinkCapInsets(Reader, 1.0);
end;

procedure TBitmapLinks.TPropertyLoader.ReadBitmapMargin15x(Reader: TReader);
begin
  ReadBitmapLinkCapInsets(Reader, 1.5);
end;

procedure TBitmapLinks.TPropertyLoader.ReadBitmapMargin20x(Reader: TReader);
begin
  ReadBitmapLinkCapInsets(Reader, 2.0);
end;

procedure TBitmapLinks.TPropertyLoader.ReadBitmapMargin30x(Reader: TReader);
begin
  ReadBitmapLinkCapInsets(Reader, 3.0);
end;

procedure TBitmapLinks.TPropertyLoader.ReadSourceRect(Reader: TReader);
begin
  ReadBitmapLinkSourceRect(Reader, 1.0);
end;

procedure TBitmapLinks.TPropertyLoader.ReadSourceRect15x(Reader: TReader);
begin
  ReadBitmapLinkSourceRect(Reader, 1.5);
end;

procedure TBitmapLinks.TPropertyLoader.ReadSourceRect20x(Reader: TReader);
begin
  ReadBitmapLinkSourceRect(Reader, 2.0);
end;

procedure TBitmapLinks.TPropertyLoader.ReadSourceRect30x(Reader: TReader);
begin
  ReadBitmapLinkSourceRect(Reader, 3.0);
end;

{ TCustomStyleObject }

constructor TCustomStyleObject.Create(AOwner: TComponent);
begin
  inherited;
  SetAcceptsControls(False);
  HitTest := False;
  FWrapMode := TImageWrapMode.Stretch;
  NeedsUpdateTintBuffer;
end;

destructor TCustomStyleObject.Destroy;
begin
  if FTintBuffer <> nil then
    FTintBuffer.Free;
  if FSource <> nil then
    FSource.RemoveFreeNotify(Self);
  inherited;
end;

class function TCustomStyleObject.ScreenScaleToStyleScale(const ScreenScale: Single): Single;
begin
  if ScreenScale < 1.25 then
    Result := 1
  else if ScreenScale < 1.75 then
    Result := 1.5
  else if ScreenScale < 2.1 then
    Result := 2
  else if ScreenScale < 3.1 then
    Result := 3
  else
    Result := 1;
end;

function TCustomStyleObject.DoGetUpdateRect: TRectF;
begin
  Result := inherited;
  if (Canvas <> nil) and not Canvas.IsScaleInteger then
    Result := Canvas.AlignToPixel(Result);
end;

procedure TCustomStyleObject.DoDrawToCanvas(const Canvas: TCanvas; const ARect: TRectF; const AOpacity: Single = 1.0);
var
  CurrentLink: TBitmapLinks;
  Link: TBitmapLink;
  Item: TCustomBitmapItem;
  AlignedRect, LR, LRUnscaled, R, IntersectionRect, UnscaledMargins: TRectF;
  i, j: Integer;
  B: TBitmap;
  SR, SRScaled: TRectF;
  BitmapScale, ScreenScale: Single;
  HorzMarginsOnly, VertMarginsOnly: Boolean;
  SaveState: TCanvasSaveState;
  HighSpeed: Boolean;
  M: TMatrix;
  DrawingScale: TPointF;
begin
  CurrentLink := GetCurrentLink;
  if (CurrentLink = nil) or CurrentLink.Empty or (FSource = nil) or (Canvas = nil) then
    Exit;

  if Scene <> nil then
    ScreenScale := Scene.GetSceneScale
  else
    ScreenScale := Canvas.Scale;

  DrawingScale := Canvas.Matrix.ExtractScale;

  HighSpeed := (Abs(Frac(ScreenScale)) < TEpsilon.Scale) and (Abs(Frac(DrawingScale.X)) < TEpsilon.Scale) and
    (Abs(Frac(DrawingScale.Y)) < TEpsilon.Scale);

  Item := FSource.MultiResBitmap.ItemByScale(ScreenScale, False, False);
  if Item <> nil then
  begin
    B := Item.Bitmap;
    BitmapScale := Item.Scale;
  end
  else
    Exit;

  Link := CurrentLink.LinkByScale(BitmapScale, False);
  if Link = nil then Exit;

  if (B = nil) or B.IsEmpty then
    Exit;

  SR := Link.SourceRect.Rect;
  if SR.IsEmpty then
    Exit;

  if FOpaque and SameValue(AOpacity, 1.0, TEpsilon.Vector) then
    Canvas.Blending := False
  else
    Canvas.Blending := True;

  SRScaled := TRectF.Create(SR.Left / ScreenScale, SR.Top / ScreenScale, SR.Right / ScreenScale, SR.Bottom / ScreenScale);

  if not SameValue(Frac(ScreenScale), 0) and AlignToPixels then
    AlignedRect := Canvas.AlignToPixel(ARect)
  else
    AlignedRect := ARect;

  LR := TRectF.Create(AlignedRect.Left * ScreenScale, AlignedRect.Top * ScreenScale, AlignedRect.Right * ScreenScale, AlignedRect.Bottom * ScreenScale);
  LRUnscaled := AlignedRect;

  UnscaledMargins := TRectF.Create(Link.CapInsets.Left / ScreenScale, Link.CapInsets.Top / ScreenScale,
    Link.CapInsets.Right / ScreenScale, Link.CapInsets.Bottom / ScreenScale);

  if (Link.CapInsets.Left + Link.CapInsets.Right > LR.Width) then
  begin
    LR.Width := Link.CapInsets.Left + Link.CapInsets.Right;
    LRUnscaled.Width := LR.Width / ScreenScale;
    HorzMarginsOnly := True;
  end
  else
    HorzMarginsOnly := False;
  if (Link.CapInsets.Top + Link.CapInsets.Bottom > LR.Height) then
  begin
    LR.Height := Link.CapInsets.Top + Link.CapInsets.Bottom;
    LRUnscaled.Height := LR.Height / ScreenScale;
    VertMarginsOnly := True;
  end
  else
    VertMarginsOnly := False;

  if not Link.CapInsets.MarginEmpty then
  begin
    // fixed scale
    if HorzMarginsOnly or VertMarginsOnly then
    begin
      SaveState := Canvas.SaveState;
      Canvas.IntersectClipRect(ARect);
      // Offset for bottom oriented
      if VertMarginsOnly and (ParentControl <> nil) and (Position.Y + Height > ParentControl.Height / 2) then
      begin
        M := TMatrix.Identity;
        M.m32 := Height - LRUnscaled.Height;
        M := AbsoluteMatrix * M;
        Canvas.SetMatrix(M);
      end;
    end
    else
      SaveState := nil;
    { lefttop }
    R := TRectF.Create(LRUnscaled.Left, LRUnscaled.Top, LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Top + UnscaledMargins.Top);
    Canvas.DrawBitmap(B, TRectF.Create(SR.Left, SR.Top, SR.Left + Link.CapInsets.Left, SR.Top + Link.CapInsets.Top), R,
      AOpacity, True);
    { righttop }
    R := TRectF.Create(LRUnscaled.Right - UnscaledMargins.Right, LRUnscaled.Top, LRUnscaled.Right, LRUnscaled.Top + UnscaledMargins.Top);
    Canvas.DrawBitmap(B, TRectF.Create(SR.Right - Link.CapInsets.Right, SR.Top, SR.Right,
      SR.Top + Link.CapInsets.Top), R, AOpacity, True);
    { leftbottom }
    R := TRectF.Create(LRUnscaled.Left, LRUnscaled.Bottom - UnscaledMargins.Bottom, LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Bottom);
    Canvas.DrawBitmap(B, TRectF.Create(SR.Left, SR.Bottom - Link.CapInsets.Bottom,
      SR.Left + Link.CapInsets.Left, SR.Bottom), R, AOpacity, True);
    { rightbottom }
    R := TRectF.Create(LRUnscaled.Right - UnscaledMargins.Right, LRUnscaled.Bottom - UnscaledMargins.Bottom, LRUnscaled.Right, LRUnscaled.Bottom);
    Canvas.DrawBitmap(B, TRectF.Create(SR.Right - Link.CapInsets.Right,
      SR.Bottom - Link.CapInsets.Bottom, SR.Right, SR.Bottom), R,
      AOpacity, True);
    if not HorzMarginsOnly then
    begin
      { top }
      if CapMode = TCapWrapMode.Tile then
      begin
        for i := 0 to Ceil((LR.Width - Link.CapInsets.Left - Link.CapInsets.Right) / (SR.Width - Link.CapInsets.Left - Link.CapInsets.Right)) do
        begin
          R := TRectF.Create(LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Top, LRUnscaled.Left + SRScaled.Width - UnscaledMargins.Right, LRUnscaled.Top + UnscaledMargins.Top);
          OffsetRect(R, i * R.Width, 0);
          IntersectRect(IntersectionRect, TRectF.Create(LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Top, LRUnscaled.Right - UnscaledMargins.Right, LRUnscaled.Top + UnscaledMargins.Top), R);
          Canvas.DrawBitmap(B, TRectF.Create(SR.Left + Link.CapInsets.Left, SR.Top, SR.Right - Link.CapInsets.Right, SR.Top + Link.CapInsets.Top),
            IntersectionRect, AOpacity, True)
        end;
      end
      else
        Canvas.DrawBitmap(B, TRectF.Create(SR.Left + Link.CapInsets.Left, SR.Top, SR.Right - Link.CapInsets.Right, SR.Top + Link.CapInsets.Top),
          TRectF.Create(LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Top, LRUnscaled.Right - UnscaledMargins.Right, LRUnscaled.Top + UnscaledMargins.Top),
          AOpacity, True);
      { bottom }
      if CapMode = TCapWrapMode.Tile then
      begin
        for i := 0 to Ceil((LR.Width - Link.CapInsets.Left - Link.CapInsets.Right) / (SR.Width - Link.CapInsets.Left - Link.CapInsets.Right)) do
        begin
          R := TRectF.Create(LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Bottom - UnscaledMargins.Bottom, LRUnscaled.Left + SRScaled.Width - UnscaledMargins.Right, LRUnscaled.Bottom);
          OffsetRect(R, i * R.Width, 0);
          IntersectRect(IntersectionRect, TRectF.Create(LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Bottom - UnscaledMargins.Bottom, LRUnscaled.Right - UnscaledMargins.Right,
            LRUnscaled.Bottom), R);
          Canvas.DrawBitmap(B, TRectF.Create(SR.Left + Link.CapInsets.Left, SR.Bottom - Link.CapInsets.Bottom, SR.Right - Link.CapInsets.Right, SR.Bottom),
            IntersectionRect, AOpacity, True)
        end;
      end
      else
        Canvas.DrawBitmap(B, TRectF.Create(SR.Left + Link.CapInsets.Left, SR.Bottom - Link.CapInsets.Bottom, SR.Right - Link.CapInsets.Right, SR.Bottom),
          TRectF.Create(LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Bottom - UnscaledMargins.Bottom, LRUnscaled.Right - UnscaledMargins.Right, LRUnscaled.Bottom),
          AOpacity, True);
    end;
    if not VertMarginsOnly then
    begin
      { left }
      if CapMode = TCapWrapMode.Tile then
      begin
        for j := 0 to Ceil((LR.Height - Link.CapInsets.Bottom - Link.CapInsets.Top) / (SR.Height - Link.CapInsets.Bottom - Link.CapInsets.Top))  do
        begin
          R := TRectF.Create(LRUnscaled.Left, LRUnscaled.Top + UnscaledMargins.Top, LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Top + SRScaled.Height - UnscaledMargins.Bottom);
          OffsetRect(R, 0, j * R.Height);
          IntersectRect(IntersectionRect, TRectF.Create(LRUnscaled.Left, LRUnscaled.Top + UnscaledMargins.Top,
            LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Bottom - UnscaledMargins.Bottom), R);
          Canvas.DrawBitmap(B, TRectF.Create(SR.Left, SR.Top + Link.CapInsets.Top, SR.Left + Link.CapInsets.Left, SR.Top + Link.CapInsets.Top + IntersectionRect.Height),
            IntersectionRect, AOpacity, True)
        end;
      end
      else
        Canvas.DrawBitmap(B, TRectF.Create(SR.Left, SR.Top + Link.CapInsets.Top, SR.Left + Link.CapInsets.Left, SR.Bottom - Link.CapInsets.Bottom),
          TRectF.Create(LRUnscaled.Left, LRUnscaled.Top + UnscaledMargins.Top, LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Bottom - UnscaledMargins.Bottom), AOpacity, True);
      { right }
      if CapMode = TCapWrapMode.Tile then
      begin
        for j := 0 to Ceil((LR.Height - Link.CapInsets.Bottom - Link.CapInsets.Top) / (SR.Height - Link.CapInsets.Bottom - Link.CapInsets.Top)) do
        begin
          R := TRectF.Create(LRUnscaled.Right - UnscaledMargins.Right, LRUnscaled.Top + UnscaledMargins.Top, LRUnscaled.Right, LRUnscaled.Top + SRScaled.Height - UnscaledMargins.Bottom);
          OffsetRect(R, 0, j * R.Height);
          IntersectRect(IntersectionRect, TRectF.Create(LRUnscaled.Width - UnscaledMargins.Right, LRUnscaled.Top + UnscaledMargins.Top, LRUnscaled.Right,
            LRUnscaled.Bottom - UnscaledMargins.Bottom), R);
          Canvas.DrawBitmap(B, TRectF.Create(SR.Right - Link.CapInsets.Right, SR.Top + Link.CapInsets.Top, SR.Right, SR.Top + Link.CapInsets.Top + IntersectionRect.Height),
            IntersectionRect, AOpacity, True)
        end;
      end
      else
        Canvas.DrawBitmap(B, TRectF.Create(SR.Right - Link.CapInsets.Right, SR.Top + Link.CapInsets.Top, SR.Right, SR.Bottom - Link.CapInsets.Bottom),
          TRectF.Create(LRUnscaled.Right - UnscaledMargins.Right, LRUnscaled.Top + UnscaledMargins.Top, LRUnscaled.Right, LRUnscaled.Bottom - UnscaledMargins.Bottom),
          AOpacity, True);
    end;
    { center }
    if not VertMarginsOnly and not HorzMarginsOnly then
    begin
      if FWrapMode = TImageWrapMode.Tile then
      begin
        for i := 0 to Ceil((LR.Width - Link.CapInsets.Left - Link.CapInsets.Right) / (SR.Width - Link.CapInsets.Left - Link.CapInsets.Right)) do
          for j := 0 to Ceil((LR.Height - Link.CapInsets.Bottom - Link.CapInsets.Top) / (SR.Height - Link.CapInsets.Bottom - Link.CapInsets.Top)) do
          begin
            R := TRectF.Create(LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Top + UnscaledMargins.Top,
              LRUnscaled.Left + SRScaled.Width - UnscaledMargins.Right, LRUnscaled.Top + SRScaled.Height - UnscaledMargins.Bottom);
            OffsetRect(R, i * R.Width, j * R.Height);
            IntersectRect(IntersectionRect, TRectF.Create(LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Top + UnscaledMargins.Top,
              LRUnscaled.Right - UnscaledMargins.Right, LRUnscaled.Bottom - UnscaledMargins.Bottom), R);
            Canvas.DrawBitmap(B, TRectF.Create(SR.Left + Link.CapInsets.Left, SR.Top + Link.CapInsets.Top, SR.Left + Link.CapInsets.Left + IntersectionRect.Width, SR.Top + Link.CapInsets.Top + IntersectionRect.Height),
              IntersectionRect, AOpacity, True);
          end;
      end
      else
      begin
        R := TRectF.Create(LRUnscaled.Left + UnscaledMargins.Left, LRUnscaled.Top + UnscaledMargins.Top, LRUnscaled.Right - UnscaledMargins.Right, LRUnscaled.Bottom - UnscaledMargins.Bottom);
        Canvas.DrawBitmap(B, TRectF.Create(SR.Left + Link.CapInsets.Left, SR.Top + Link.CapInsets.Top, SR.Right - Link.CapInsets.Right, SR.Bottom - Link.CapInsets.Bottom),
          R, AOpacity, True);
      end;
    end;
    if HorzMarginsOnly or VertMarginsOnly then
      Canvas.RestoreState(SaveState);
  end
  else
  begin
    case FWrapMode of
      TImageWrapMode.Original:
        begin
          R := TRectF.Create(LRUnscaled.Left, LRUnscaled.Top, LRUnscaled.Left + SRScaled.Width, LRUnscaled.Top + SRScaled.Height);
          IntersectRect(IntersectionRect, LRUnscaled, R);
          Canvas.DrawBitmap(B, TRectF.Create(SR.Left, SR.Top, SR.Left + IntersectionRect.Width * ScreenScale, SR.Top + IntersectionRect.Height * ScreenScale),
            IntersectionRect, AOpacity, HighSpeed)
        end;
      TImageWrapMode.Fit:
        begin
          LR := TRectF.Create(0, 0, Width, Height);
          R := Link.SourceRect.Rect;
          R := R.FitInto(LR).Round;
          Canvas.DrawBitmap(B, SR, R, AOpacity, HighSpeed);
        end;
      TImageWrapMode.Stretch:
        begin
          Canvas.DrawBitmap(B, SR, LRUnscaled, AOpacity, True)
        end;
      TImageWrapMode.Tile:
        begin
          for i := 0 to Ceil(LR.Width / SR.Width) do
            for j := 0 to Ceil(LR.Height / SR.Height) do
            begin
              R := TRectF.Create(LRUnscaled.Left, LRUnscaled.Top, LRUnscaled.Left + SRScaled.Width, LRUnscaled.Top + SRScaled.Height);
              OffsetRect(R, i * R.Width, j * R.Height);
              IntersectRect(IntersectionRect, LRUnscaled, R);
              Canvas.DrawBitmap(B, TRectF.Create(SR.Left, SR.Top, SR.Left + IntersectionRect.Width * ScreenScale, SR.Top + IntersectionRect.Height * ScreenScale),
                IntersectionRect, AOpacity, True)
            end;
        end;
      TImageWrapMode.Center:
        begin
          R := RectF(0, 0, SR.Width / Item.Scale, SR.Height / Item.Scale);
          RectCenter(R, LRUnscaled);
          Canvas.DrawBitmap(B, SR, R, AOpacity, HighSpeed);
        end;
      TImageWrapMode.Place:
        begin
          LR := TRectF.Create(0, 0, Width, Height);
          R := Link.SourceRect.Rect;
          R := R.PlaceInto(LR).Round;
          Canvas.DrawBitmap(B, SR, R, AOpacity, HighSpeed);
        end;
    end;
  end;
  Canvas.Blending := True;
end;

procedure ModulateBitmap(const Bitmap: TBitmap; const TintColor: TAlphaColor);

  function ModulatePixel(const Pixel, Color: TAlphaColor): TAlphaColor; inline;
  begin
    TAlphaColorRec(Result).R := (Integer(TAlphaColorRec(Pixel).R) * TAlphaColorRec(Color).R) div 255;
    TAlphaColorRec(Result).G := (Integer(TAlphaColorRec(Pixel).G) * TAlphaColorRec(Color).G) div 255;
    TAlphaColorRec(Result).B := (Integer(TAlphaColorRec(Pixel).B) * TAlphaColorRec(Color).B) div 255;
    TAlphaColorRec(Result).A := (Integer(TAlphaColorRec(Pixel).A) * TAlphaColorRec(Color).A) div 255;
  end;

var
  BitmapData: TBitmapData;
  PremTint: TAlphaColor;
  Pixel: PAlphaColor;
  I, J: Integer;
begin
  PremTint := PremultiplyAlpha(TintColor);
  if Bitmap.Map(TMapAccess.ReadWrite, BitmapData) then
  try
    for J := 0 to Bitmap.Height - 1 do
    begin
      Pixel := BitmapData.GetScanline(J);
      for I := 0 to Bitmap.Width - 1 do
      begin
        Pixel^ := ModulatePixel(Pixel^, PremTint);
        Inc(Pixel);
      end;
    end;
  finally
    Bitmap.Unmap(BitmapData);
  end;
end;

procedure TCustomStyleObject.NeedsUpdateTintBuffer;
begin
  FNeedsUpdateTintBuffer := True;
end;

procedure TCustomStyleObject.PrepareTintBuffer(const Canvas: TCanvas; const ATintColor: TAlphaColor);
var
  ScreenScale: Single;
begin
  // Tint buffer used only on Canvas that doesn't support modulation
  if FNeedsUpdateTintBuffer then
  begin
    if FTintBuffer = nil then
      FTintBuffer := TBitmap.Create;

    if Scene <> nil then
      ScreenScale := Scene.GetSceneScale
    else if Canvas <> nil then
      ScreenScale := Canvas.Scale
    else
      ScreenScale := 1;

    FTintBuffer.SetSize(Trunc(Width * ScreenScale), Trunc(Height * ScreenScale));
    FTintBuffer.BitmapScale := ScreenScale;

    FTintBuffer.Canvas.BeginScene;
    try
      FTintBuffer.Canvas.Clear(0);
      DoDrawToCanvas(FTintBuffer.Canvas, LocalRect, 1.0);
    finally
      FTintBuffer.Canvas.EndScene;
    end;

    ModulateBitmap(FTintBuffer, ATintColor);
  end;
end;

procedure TCustomStyleObject.DrawToCanvas(const Canvas: TCanvas; const ARect: TRectF; const ATintColor: TAlphaColor;
  const AOpacity: Single);
var
  ModulateCanvas: IModulateCanvas;
  SaveModulateColor: TAlphaColor;
begin
  FTintStage := TTintStage.Undefined;

  if CanBeTinted and (ATintColor <> TAlphaColors.Null) then
  begin
    FTintStage := TTintStage.Shadow;
    DoDrawToCanvas(Canvas, ARect, AbsoluteOpacity * AOpacity);

    FTintStage := TTintStage.Mask;
    if FTintStage = TCustomStyleObject.TTintStage.Mask then
    begin
      if Supports(Canvas, IModulateCanvas, ModulateCanvas) then
      begin
        SaveModulateColor := ModulateCanvas.ModulateColor;
        ModulateCanvas.ModulateColor := ATintColor;
        try
          DoDrawToCanvas(Canvas, ARect, AbsoluteOpacity * AOpacity);
        finally
          ModulateCanvas.ModulateColor := SaveModulateColor;
        end;
      end
      else
      begin
        PrepareTintBuffer(Canvas, ATintColor);
        Canvas.DrawBitmap(FTintBuffer, LocalRect, ARect, AOpacity, True);
      end;
    end;

    FTintStage := TTintStage.Shine;
    DoDrawToCanvas(Canvas, ARect, AbsoluteOpacity * AOpacity);
  end
  else
    DoDrawToCanvas(Canvas, ARect, AbsoluteOpacity * AOpacity);
end;

procedure TCustomStyleObject.DrawToCanvas(const Canvas: TCanvas; const ARect: TRectF; const AOpacity: Single = 1.0);
begin
  DrawToCanvas(Canvas, ARect, TintColor, AOpacity);
end;

procedure TCustomStyleObject.Paint;
var
  R: TRectF;
begin
  DrawToCanvas(Canvas, LocalRect);

  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;
end;

procedure TCustomStyleObject.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Opaque', ReadOpaque, WriteOpaque, Opaque);
  { Backward compatibility with XE3 }
  Filer.DefineProperty('DisableInterpolation', IgnoreBooleanValue, nil, False);
  Filer.DefineProperty('BitmapScale', IgnoreFloatValue, nil, False);
  Filer.DefineProperty('MarginWrapMode', ReadMarginWrapMode, nil, False);
end;

procedure TCustomStyleObject.FreeNotification(AObject: TObject);
begin
  inherited;
  if AObject = Source then
    Source := nil;
end;

function TCustomStyleObject.IsEmpty: Boolean;
var
  CurrentLink: TBitmapLinks;
begin
  CurrentLink := GetCurrentLink;
  Result := ((CurrentLink <> nil) and CurrentLink.Empty) or (FSource = nil);
end;

procedure TCustomStyleObject.ReadMarginWrapMode(Reader: TReader);
var
  MarginWrapMode: TImageWrapMode;
  Ident: Integer;
  StringIdent: string;
begin
  StringIdent := Reader.ReadIdent;
  if IdentToInt(StringIdent, Ident, WrapModes) or IdentToInt(StringIdent, Ident, WrapModesWithPrefix) then
  begin
    MarginWrapMode := TImageWrapMode(Ident);
    case MarginWrapMode of
      TImageWrapMode.Stretch: CapMode := TCapWrapMode.Stretch;
      TImageWrapMode.Tile: CapMode := TCapWrapMode.Tile;
    end;
  end;
end;

procedure TCustomStyleObject.ReadOpaque(Reader: TReader);
begin
  FOpaque := Reader.ReadBoolean;
end;

procedure TCustomStyleObject.WriteOpaque(Writer: TWriter);
begin
  Writer.WriteBoolean(FOpaque);
end;

function TCustomStyleObject.GetCanBeTinted: Boolean;
begin
  Result := False;
end;

procedure TCustomStyleObject.SetTintColor(const ATintColor: TAlphaColor);
begin
  if FTintColor <> ATintColor then
  begin
    FTintColor := ATintColor;
    if CanBeTinted then
    begin
      NeedsUpdateTintBuffer;
      Repaint;
    end;
  end;
end;

procedure TCustomStyleObject.SetOpaque(const Value: Boolean);
begin
  if FOpaque <> Value then
  begin
    FOpaque := Value;
    Repaint;
  end;
end;

procedure TCustomStyleObject.SetSource(const Value: TImage);
begin
  if FSource <> Value then
  begin
    if FSource <> nil then
      FSource.RemoveFreeNotify(Self);
    FSource := Value;
    if FSource <> nil then
      FSource.AddFreeNotify(Self);
  end;
end;

procedure TCustomStyleObject.SetSourceLookup(const Value: string);
var
  LookupObject: TFmxObject;
begin
  if FSourceLookup <> Value then
  begin
    FSourceLookup := Value;
    if not FSourceLookup.IsEmpty then
    begin
      LookupObject := nil;
      if TStyledControl.LoadableStyle <> nil then
      begin
        LookupObject := TStyledControl.LoadableStyle.FindStyleResource(FSourceLookup);
        if LookupObject is TImage then
          Source := TImage(LookupObject);
      end;
      if LookupObject = nil then
      begin
        LookupObject := FMX.Types.FindStyleResource(FSourceLookup);
        if LookupObject is TImage then
          Source := TImage(LookupObject);
      end;
    end;
  end;
end;

procedure TCustomStyleObject.SetCapMode(const Value: TCapWrapMode);
begin
  FCapMode := Value;
end;

procedure TCustomStyleObject.SetWrapMode(const Value: TImageWrapMode);
begin
  FWrapMode := Value;
end;

{ TStyleObject }

constructor TStyleObject.Create(AOwner: TComponent);
begin
  inherited;
  FSourceLink := TBitmapLinks.Create;
end;

destructor TStyleObject.Destroy;
begin
  FSourceLink.Free;
  inherited;
end;

procedure TStyleObject.DefineProperties(Filer: TFiler);
var
  BitmapLinksLoader: TBitmapLinks.TPropertyLoader;
begin
  inherited;
  BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(FSourceLink, Filer);
  try
    BitmapLinksLoader.ReadCapInsets;
    BitmapLinksLoader.ReadSourceRects;
  finally
    BitmapLinksLoader.Free;
  end;
end;

function TStyleObject.GetCurrentLink: TBitmapLinks;
begin
  Result := FSourceLink;
end;

procedure TStyleObject.SetSourceLink(const Value: TBitmapLinks);
begin
  FSourceLink.Assign(Value);
end;

{ TTintedStyleObject }

constructor TTintedStyleObject.Create(AOwner: TComponent);
begin
  inherited;
  FTint := TTintedStages.Create(Self);
end;

destructor TTintedStyleObject.Destroy;
begin
  FTint.Free;
  inherited;
end;

procedure TTintedStyleObject.DefineProperties(Filer: TFiler);

  procedure DefineProperty(const Links: TBitmapLinks; const PropertyName: string);
  var
    BitmapLinksLoader: TBitmapLinks.TPropertyLoader;
  begin
    BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(Links, Filer, PropertyName);
    try
      BitmapLinksLoader.ReadSourceRects;
    finally
      BitmapLinksLoader.Free;
    end;
  end;

begin
  inherited;
  DefineProperty(Tint.Mask, 'TintMask');
  DefineProperty(Tint.Shadow, 'TintShadow');
  DefineProperty(Tint.Shine, 'TintShine');
end;

function TTintedStyleObject.GetCanBeTinted: Boolean;
begin
  Result := not FTint.Mask.Empty;
end;

function TTintedStyleObject.GetCurrentLink: TBitmapLinks;
begin
  case TintStage of
    TCustomStyleObject.TTintStage.Shadow: Result := FTint.Shadow;
    TCustomStyleObject.TTintStage.Mask: Result := FTint.Mask;
    TCustomStyleObject.TTintStage.Shine: Result := FTint.Shine;
  else
    Result := inherited GetCurrentLink;
  end;
end;

procedure TTintedStyleObject.Loaded;
begin
  inherited;
  FTint.Shadow.AssignCapInsets(SourceLink);
  FTint.Mask.AssignCapInsets(SourceLink);
  FTint.Shine.AssignCapInsets(SourceLink);
end;

procedure TTintedStyleObject.SetTint(const Value: TTintedStages);
begin
  FTint.Assign(Value);
end;

{ TStyleAnimation }

type

  TStyleAnimation = class(TAnimation)
  protected
    procedure ProcessAnimation; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function CreateAnimation(const Trigger: string; const Event: TNotifyEvent): TStyleAnimation;
  end;

constructor TStyleAnimation.Create(AOwner: TComponent);
begin
  inherited Create(nil);
  AutoReverse := True;
  Duration := 0.0001;
end;

class function TStyleAnimation.CreateAnimation(const Trigger: string;
  const Event: TNotifyEvent): TStyleAnimation;
begin
  Result := TStyleAnimation.Create(nil);
  Result.Trigger := Trigger;
  Result.OnFinish := Event;
end;

procedure TStyleAnimation.ProcessAnimation;
begin
end;

{ TActiveStyleObject }

function StyleTriggerToProperty(const Trigger: TStyleTrigger): string;
begin
  case Trigger of
    TStyleTrigger.MouseOver: Result := 'IsMouseOver';
    TStyleTrigger.Pressed: Result := 'IsPressed';
    TStyleTrigger.Selected: Result := 'IsSelected';
    TStyleTrigger.Focused: Result := 'IsFocused';
    TStyleTrigger.Checked: Result := 'IsChecked';
    TStyleTrigger.Active: Result := 'IsActive';
  else
    Result := '';
  end;
end;

constructor TActiveStyleObject.Create(AOwner: TComponent);
begin
  inherited;
  FSourceLink := TBitmapLinks.Create;
  FActiveAnimation := TStyleAnimation.CreateAnimation('', Triggered);
  FActiveLink := TBitmapLinks.Create;
  FTouchAnimation := TTouchAnimationAdapter.Create(Self);
end;

destructor TActiveStyleObject.Destroy;
begin
  FTouchAnimation.Free;
  FSourceLink.Free;
  FActiveLink.Free;
  FActiveAnimation.Free;
  inherited;
end;

procedure TActiveStyleObject.Loaded;
begin
  inherited;
  ActiveLink.AssignCapInsets(SourceLink);
end;

procedure TActiveStyleObject.Paint;
begin
  inherited;
  FTouchAnimation.DrawTouchAnimation(Canvas, LocalRect);
end;

procedure TActiveStyleObject.DefineProperties(Filer: TFiler);
var
  BitmapLinksLoader: TBitmapLinks.TPropertyLoader;
begin
  inherited;
  BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(SourceLink, Filer);
  try
    BitmapLinksLoader.ReadCapInsets;
    BitmapLinksLoader.ReadSourceRects;
  finally
    BitmapLinksLoader.Free;
  end;
  BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(ActiveLink, Filer, 'ActiveRect');
  try
    BitmapLinksLoader.ReadSourceRects;
  finally
    BitmapLinksLoader.Free;
  end;
  TouchAnimation.DefineTouchAnimationProperty(Filer);
end;

function TActiveStyleObject.GetCurrentLink: TBitmapLinks;
begin
  if FActive then
    Result := FActiveLink
  else
    Result := FSourceLink
end;

function TActiveStyleObject.GetTouchAnimation: TTouchAnimationAdapter;
begin
  Result := FTouchAnimation;
end;

procedure TActiveStyleObject.SetActiveLink(const Value: TBitmapLinks);
begin
  FActiveLink.Assign(Value);
end;

procedure TActiveStyleObject.SetSourceLink(const Value: TBitmapLinks);
begin
  FSourceLink.Assign(Value);
end;

procedure TActiveStyleObject.SetTouchAnimation(const Value: TTouchAnimationAdapter);
begin
  // Need to serelization
end;

procedure TActiveStyleObject.SetTrigger(const Value: TStyleTrigger);
begin
  FTrigger := Value;
  SetupAnimations;
end;

procedure TActiveStyleObject.SetupAnimations;
begin
  FActiveAnimation.Trigger := StyleTriggerToProperty(FTrigger) + '=True';
  FActiveAnimation.TriggerInverse := StyleTriggerToProperty(FTrigger) + '=False';
end;

procedure TActiveStyleObject.StartTriggerAnimation(const AInstance: TFmxObject;
  const ATrigger: string);
begin
  inherited;
  FActiveAnimation.StartTrigger(AInstance, ATrigger);
  FTouchAnimation.StartTriggerAnimation(AInstance, ATrigger);
end;

procedure TActiveStyleObject.Triggered(Sender: TObject);
begin
  FActive := not FActiveAnimation.Inverse;
  DoTriggered;
  Repaint;
end;

procedure TActiveStyleObject.DoTriggered;
begin
  if Assigned(FOnTriggered) then
    FOnTriggered(Self);
end;

{ TTabStyleObject }

constructor TTabStyleObject.Create(AOwner: TComponent);
var
  I: TLink;
begin
  inherited;
  FTransitions[TState.Active].Animation := TStyleAnimation.CreateAnimation('', ActiveTriggered);
  FTransitions[TState.Hot].Animation := TStyleAnimation.CreateAnimation('', HotTriggered);
  FTransitions[TState.Focused].Animation := TStyleAnimation.CreateAnimation('', FocusedTriggered);
  FState := [];
  for I := Low(TLink) to High(TLink) do
    FBitmapLinks[I] := TBitmapLinks.Create;
end;

destructor TTabStyleObject.Destroy;
var
  I: TLink;
  J: TState;
begin
  for J := Low(FTransitions) to High(FTransitions) do
    FTransitions[J].Animation.Free;
  for I := Low(FBitmapLinks) to High(FBitmapLinks) do
    FBitmapLinks[I].Free;
  inherited;
end;

function TTabStyleObject.GetCurrentLink: TBitmapLinks;
begin
  if TState.Active in FState then
    if TState.Hot in FState then
      Result := ActiveHotLink
    else
    if TState.Focused in FState then
      Result := ActiveFocusedLink
    else
      Result := ActiveLink
  else
    if TState.Hot in FState then
      Result := HotLink
    else
    if TState.Focused in FState then
      Result := FocusedLink
    else
      Result := SourceLink;
end;

function TTabStyleObject.GetLink(Index: TLink): TBitmapLinks;
begin
  Result := FBitmapLinks[Index];
end;

procedure TTabStyleObject.SetActiveTrigger(const Value: TStyleTrigger);
begin
  FActiveTrigger := Value;
  SetupAnimations;
end;

procedure TTabStyleObject.SetEvent(Index: TState; const Value: TNotifyEvent);
begin
  FTransitions[Index].Event := Value;
end;

function TTabStyleObject.GetEvent(Index: TState): TNotifyEvent;
begin
  Result := FTransitions[Index].Event;
end;

procedure TTabStyleObject.InvokeEvent(Index: TState);
begin
  if Assigned(FTransitions[Index].Event) then
    FTransitions[Index].Event(Self);
end;

procedure TTabStyleObject.SetLink(Index: TLink; const Value: TBitmapLinks);
begin
  FBitmapLinks[Index].Assign(Value);
end;

procedure TTabStyleObject.DefineProperties(Filer: TFiler);
var
  BitmapLinksLoader: TBitmapLinks.TPropertyLoader;

  procedure DefineProperty(const Links: TBitmapLinks; const PropertyName: string);
  begin
    BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(Links, Filer, PropertyName);
    try
      BitmapLinksLoader.ReadSourceRects;
    finally
      BitmapLinksLoader.Free;
    end;
  end;

begin
  inherited;
  BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(SourceLink, Filer);
  try
    BitmapLinksLoader.ReadCapInsets;
    BitmapLinksLoader.ReadSourceRects;
  finally
    BitmapLinksLoader.Free;
  end;

  DefineProperty(HotLink, 'HotRect');
  DefineProperty(FocusedLink, 'FocusedRect');
  DefineProperty(ActiveLink, 'ActiveRect');
  DefineProperty(ActiveHotLink, 'ActiveHotRect');
  DefineProperty(ActiveFocusedLink, 'ActiveFocusedRect');
end;

procedure TTabStyleObject.HotTriggered(Sender: TObject);
begin
  if FTransitions[TState.Hot].Animation.Inverse then
    Exclude(FState, TState.Hot)
  else
    Include(FState, TState.Hot);
  InvokeEvent(TState.Hot);
  Repaint;
end;

procedure TTabStyleObject.FocusedTriggered(Sender: TObject);
begin
  if FTransitions[TState.Focused].Animation.Inverse then
    Exclude(FState, TState.Focused)
  else
    Include(FState, TState.Focused);
  InvokeEvent(TState.Focused);
  Repaint;
end;

procedure TTabStyleObject.ActiveTriggered(Sender: TObject);
begin
  if FTransitions[TState.Active].Animation.Inverse then
    Exclude(FState, TState.Active)
  else
    Include(FState, TState.Active);
  InvokeEvent(TState.Active);
  Repaint;
end;

procedure TTabStyleObject.Loaded;
begin
  inherited;

  if ActiveHotLink.Empty then
    ActiveHotLink := ActiveLink;
  if ActiveFocusedLink.Empty then
    ActiveFocusedLink := ActiveLink;
  if FocusedLink.Empty then
    FocusedLink := SourceLink;

  ActiveLink.AssignCapInsets(SourceLink);
  ActiveHotLink.AssignCapInsets(SourceLink);
  ActiveFocusedLink.AssignCapInsets(SourceLink);
  HotLink.AssignCapInsets(SourceLink);
  FocusedLink.AssignCapInsets(SourceLink);
end;

procedure TTabStyleObject.SetupAnimations;
begin
  FTransitions[TState.Active].Animation.Trigger := StyleTriggerToProperty(FActiveTrigger) + '=True';
  FTransitions[TState.Active].Animation.TriggerInverse := StyleTriggerToProperty(FActiveTrigger) + '=False';
  FTransitions[TState.Hot].Animation.Trigger := 'IsMouseOver=True';
  FTransitions[TState.Hot].Animation.TriggerInverse := 'IsMouseOver=False';
  FTransitions[TState.Focused].Animation.Trigger := 'IsFocused=True';
  FTransitions[TState.Focused].Animation.TriggerInverse := 'IsFocused=False';
end;

procedure TTabStyleObject.StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string);
var
  I: TState;
begin
  inherited;
  for I := Low(FTransitions) to High(FTransitions) do
    if FTransitions[I].Animation <> nil then
      FTransitions[I].Animation.StartTrigger(AInstance, ATrigger);
end;

{ TCheckStyleObject }

constructor TCheckStyleObject.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TCheckStyleObject.Destroy;
begin
  inherited;
end;

{ TTouchAnimationAdapter.TTouchAnimation }

procedure TTouchAnimationAdapter.TTouchAnimation.ProcessAnimation;
begin
  if (FAdapter <> nil) and (FAdapter.FStyleObject <> nil) then
    FAdapter.FStyleObject.Repaint;
  if (FAdapter <> nil) and Assigned(FAdapter.FCustomPaint) then
    FAdapter.FCustomPaint;
end;

{ TTouchAnimationAdapter.TTouchAnimationObject }

function TTouchAnimationAdapter.TTouchAnimationObject.GetCurrentLink: TBitmapLinks;
begin
  Result := FAdapter.Link;
end;

{ TTouchAnimationAdapter }

constructor TTouchAnimationAdapter.Create;
begin
  inherited Create;
  FStyleObject := AStyleObject;
  FLink := TBitmapLinks.Create;
  FTouchAnimationObject := TTouchAnimationObject.Create(nil);
  FTouchAnimationObject.FAdapter := Self;
  FPressingDuration := DefaultPressingDuration;
  FUnpressingDuration := DefaultUnpressingDuration;
  FPadding := TBounds.Create(TRectF.Empty);
end;

procedure TTouchAnimationAdapter.DefineTouchAnimationProperty(Filer: TFiler);
var
  BitmapLinksLoader: TBitmapLinks.TPropertyLoader;
begin
  BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(Link, Filer, 'TouchAnimationRect');
  try
    BitmapLinksLoader.ReadSourceRects;
  finally
    BitmapLinksLoader.Free;
  end;
  Filer.DefineProperty('TouchAnimationPadding.Rect', ReadPaddingRect, nil, False);
end;

destructor TTouchAnimationAdapter.Destroy;
begin
  FPadding.Free;
  if FTouchAnimation <> nil then
    FTouchAnimation.Free;
  FTouchAnimationObject.Free;
  FLink.Free;
  inherited;
end;

procedure TTouchAnimationAdapter.DrawTouchAnimation;
const
  HalfTime = 0.5;
  CompleteTime = 1.0;
var
  R: TRectF;
  ResultRect: TRectF;
  InflateSize: Single;
  Time: Single;
  State: TCanvasSaveState;
begin
  if LinkExists and (FTouchAnimation <> nil) and FTouchAnimation.Running and
    (FTouchAnimation.NormalizedTime < CompleteTime) then
  begin
    Time := FTouchAnimation.NormalizedTime;

    ResultRect := FPadding.PaddingRect(Rect);

    R := TRectF.Create(FPressedPosition);
    InflateSize := Max(ResultRect.Width, ResultRect.Height) / 2;
    R.Inflate(InflateSize * Time, InflateSize * Time);

    FTouchAnimationObject.Source := FStyleObject.Source;
    State := Canvas.SaveState;
    try
      Canvas.IntersectClipRect(ResultRect);
      if Time < HalfTime then
        FTouchAnimationObject.DrawToCanvas(Canvas, R, Time / HalfTime)
      else
        FTouchAnimationObject.DrawToCanvas(Canvas, R, (1 - Time) / HalfTime);
    finally
      Canvas.RestoreState(State);
    end;
  end;
end;

procedure TTouchAnimationAdapter.SetLink(const Value: TBitmapLinks);
begin
  FLink.Assign(Value);
end;

procedure TTouchAnimationAdapter.SetPadding(const Value: TBounds);
begin
  FPadding.Assign(Value);
end;

procedure TTouchAnimationAdapter.CreateTouchAnimation;
begin
  FTouchAnimation := TTouchAnimation.Create(nil);
  FTouchAnimation.FAdapter := Self;
  FTouchAnimation.Stored := False;
  FTouchAnimation.Parent := FStyleObject;
end;

procedure TTouchAnimationAdapter.StartAnimation(const Control: TControl; const Kind: TAnimationKind);
begin
  case Kind of
    TTouchAnimationAdapter.TAnimationKind.Pressed:
      begin
        if FTouchAnimation = nil then
          CreateTouchAnimation;
        FPressedPosition := Control.PressedPosition;
        FTouchAnimation.Duration := PressingDuration;
        FTouchAnimation.Start;
      end;
    TTouchAnimationAdapter.TAnimationKind.Unpressed:
      begin
        if FTouchAnimation = nil then
          CreateTouchAnimation;
        FTouchAnimation.Pause := True;
        FTouchAnimation.Duration := FTouchAnimation.CurrentTime + UnpressingDuration;
        FTouchAnimation.Pause := False;
      end;
  end;
end;

procedure TTouchAnimationAdapter.StopAnimation;
begin
  if FTouchAnimation <> nil then
    FTouchAnimation.Stop;
end;

procedure TTouchAnimationAdapter.StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string);
begin
  inherited;
  if LinkExists and ATrigger.Contains('Pressed') and (AInstance is TControl) and TControl(AInstance).Pressed then
    StartAnimation(TControl(AInstance), TAnimationKind.Pressed);
  if LinkExists and ATrigger.Contains('Pressed') and (AInstance is TControl) and not TControl(AInstance).Pressed then
    StartAnimation(TControl(AInstance), TAnimationKind.Unpressed);
end;

function TTouchAnimationAdapter.LinkExists: Boolean;
begin
  Result := not FLink.Empty and (FStyleObject <> nil);
end;

function TTouchAnimationAdapter.PressingDurationStored: Boolean;
begin
  Result := not SameValue(PressingDuration, TTouchAnimationAdapter.DefaultPressingDuration, TEpsilon.Position);
end;

procedure TTouchAnimationAdapter.ReadPaddingRect(Reader: TReader);
begin
  FPadding.Rect := TRectF.Create(StringToRect(Reader.ReadString));
end;

function TTouchAnimationAdapter.UnpressingDurationStored: Boolean;
begin
  Result := not SameValue(UnpressingDuration, TTouchAnimationAdapter.DefaultUnpressingDuration, TEpsilon.Position);
end;

{ TButtonStyleObject }

constructor TButtonStyleObject.Create(AOwner: TComponent);
begin
  inherited;
  FCurrent := TButtonAnimation.Normal;

  FTriggerSources[TButtonAnimation.Normal].Animation :=
    TStyleAnimation.CreateAnimation('IsMouseOver=False;IsPressed=False;IsFocused=False', NormalTriggered);
  FTriggerSources[TButtonAnimation.Normal].Link := TBitmapLinks.Create;

  FTriggerSources[TButtonAnimation.Hot].Animation :=
    TStyleAnimation.CreateAnimation('IsMouseOver=True;IsPressed=False', HotTriggered);
  FTriggerSources[TButtonAnimation.Hot].Link := TBitmapLinks.Create;

  FTriggerSources[TButtonAnimation.Focused].Animation :=
    TStyleAnimation.CreateAnimation('IsMouseOver=False;IsFocused=True;IsPressed=False', FocusedTriggered);
  FTriggerSources[TButtonAnimation.Focused].Link := TBitmapLinks.Create;

  FTriggerSources[TButtonAnimation.Pressed].Animation :=
    TStyleAnimation.CreateAnimation('IsMouseOver=True;IsPressed=True', PressedTriggered);
  FTriggerSources[TButtonAnimation.Pressed].Link := TBitmapLinks.Create;

  FTouchAnimation := TTouchAnimationAdapter.Create(Self);
end;

destructor TButtonStyleObject.Destroy;
var
  I: TButtonAnimation;
begin
  FTouchAnimation.Free;
  for I := Low(FTriggerSources) to High(FTriggerSources) do
  begin
    FTriggerSources[I].Animation.Free;
    FTriggerSources[I].Link.Free;
  end;
  inherited;
end;

procedure TButtonStyleObject.DoFocusedTriggered;
begin
  if Assigned(FOnFocusedTriggered) then
    FOnFocusedTriggered(Self);
end;

procedure TButtonStyleObject.DoHotTriggered;
begin
  if Assigned(FOnHotTriggered) then
    FOnHotTriggered(Self);
end;

procedure TButtonStyleObject.DoNormalTriggered;
begin
  if Assigned(FOnNormalTriggered) then
    FOnNormalTriggered(Self);
end;

procedure TButtonStyleObject.DoPressedTriggered;
begin
  if Assigned(FOnPressedTriggered) then
    FOnPressedTriggered(Self);
end;

procedure TButtonStyleObject.DefineProperties(Filer: TFiler);
var
  BitmapLinksLoader: TBitmapLinks.TPropertyLoader;
begin
  inherited;
  BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(NormalLink, Filer);
  try
    BitmapLinksLoader.ReadCapInsets;
    BitmapLinksLoader.ReadSourceRects;
  finally
    BitmapLinksLoader.Free;
  end;
  BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(HotLink, Filer, 'HotRect');
  try
    BitmapLinksLoader.ReadSourceRects;
  finally
    BitmapLinksLoader.Free;
  end;
  BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(PressedLink, Filer, 'PressedRect');
  try
    BitmapLinksLoader.ReadSourceRects;
  finally
    BitmapLinksLoader.Free;
  end;
  BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(FocusedLink, Filer, 'FocusedRect');
  try
    BitmapLinksLoader.ReadSourceRects;
  finally
    BitmapLinksLoader.Free;
  end;
  TouchAnimation.DefineTouchAnimationProperty(Filer);
end;

function TButtonStyleObject.GetCurrentLink: TBitmapLinks;
begin
  Result := FTriggerSources[FCurrent].Link;
end;

procedure TButtonStyleObject.FocusedTriggered(Sender: TObject);
begin
  FCurrent := TButtonAnimation.Focused;
  DoFocusedTriggered;
  Repaint;
end;

procedure TButtonStyleObject.NormalTriggered(Sender: TObject);
begin
  FCurrent := TButtonAnimation.Normal;
  DoNormalTriggered;
  Repaint;
end;

procedure TButtonStyleObject.Paint;
begin
  inherited;
  FTouchAnimation.DrawTouchAnimation(Canvas, LocalRect);
end;

procedure TButtonStyleObject.PressedTriggered(Sender: TObject);
begin
  FCurrent := TButtonAnimation.Pressed;
  DoPressedTriggered;
  Repaint;
end;

procedure TButtonStyleObject.HotTriggered(Sender: TObject);
begin
  FCurrent := TButtonAnimation.Hot;
  DoHotTriggered;
  Repaint;
end;

procedure TButtonStyleObject.Loaded;
var
  I: TButtonAnimation;
  NormalLink, Link: TBitmapLinks;
begin
  inherited;
  NormalLink := FTriggerSources[TButtonAnimation.Normal].Link;
  for I := TButtonAnimation.Hot to High(FTriggerSources) do
  begin
    Link := FTriggerSources[I].Link;
    Link.AssignCapInsets(NormalLink);
  end;
end;

procedure TButtonStyleObject.StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string);
var
  I: TButtonAnimation;
begin
  inherited;
  for I := Low(FTriggerSources) to High(FTriggerSources) do
    FTriggerSources[I].Animation.StartTrigger(AInstance, ATrigger);
  FTouchAnimation.StartTriggerAnimation(AInstance, ATrigger);
end;

function TButtonStyleObject.GetLink(Index: TButtonAnimation): TBitmapLinks;
begin
  Result := FTriggerSources[Index].Link;
end;

procedure TButtonStyleObject.SetLink(Index: TButtonAnimation; const Value: TBitmapLinks);
begin
  FTriggerSources[Index].Link.Assign(Value);
end;

procedure TButtonStyleObject.SetTouchAnimation(const Value: TTouchAnimationAdapter);
begin
  // Need to serelization
end;

{ TTintedStages }

constructor TTintedStages.Create(const AStyleObject: TCustomStyleObject);
begin
  inherited Create;
  FStyleObject := AStyleObject;
  FShadow := TBitmapLinks.Create;
  FMask := TBitmapLinks.Create;
  FShine := TBitmapLinks.Create;
end;

destructor TTintedStages.Destroy;
begin
  FShadow.Free;
  FMask.Free;
  FShine.Free;
  inherited;
end;

procedure TTintedStages.SetMask(const Value: TBitmapLinks);
begin
  FMask.Assign(Value);
end;

procedure TTintedStages.SetShadow(const Value: TBitmapLinks);
begin
  FShadow.Assign(Value);
end;

procedure TTintedStages.SetShine(const Value: TBitmapLinks);
begin
  FShine.Assign(Value);
end;

{ TTintedButtonStyleObject }

constructor TTintedButtonStyleObject.Create(AOwner: TComponent);
var
  I: TButtonAnimation;
begin
  inherited;
  for I := Low(FTintSources) to High(FTintSources) do
    FTintSources[I] := TTintedStages.Create(Self);
end;

destructor TTintedButtonStyleObject.Destroy;
var
  I: TButtonAnimation;
begin
  for I := Low(FTintSources) to High(FTintSources) do
    FTintSources[I].Free;
  inherited;
end;

procedure TTintedButtonStyleObject.Loaded;
var
  I: TButtonAnimation;
  NormalLink: TBitmapLinks;
begin
  inherited;
  NormalLink := FTriggerSources[TButtonAnimation.Normal].Link;
  for I := Low(FTintSources) to High(FTintSources) do
  begin
    FTintSources[I].Shadow.AssignCapInsets(NormalLink);
    FTintSources[I].Mask.AssignCapInsets(NormalLink);
    FTintSources[I].Shine.AssignCapInsets(NormalLink);
  end;
end;

procedure TTintedButtonStyleObject.DefineProperties(Filer: TFiler);

  procedure DefineProperty(const Links: TBitmapLinks; const PropertyName: string);
  var
    BitmapLinksLoader: TBitmapLinks.TPropertyLoader;
  begin
    BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(Links, Filer, PropertyName);
    try
      BitmapLinksLoader.ReadSourceRects;
    finally
      BitmapLinksLoader.Free;
    end;
  end;

begin
  inherited;
  DefineProperty(NormalTint.Mask, 'NormalTintMask');
  DefineProperty(NormalTint.Shadow, 'NormalTintShadow');
  DefineProperty(NormalTint.Shine, 'NormalTintShine');
  DefineProperty(HotTint.Mask, 'HotTintMask');
  DefineProperty(HotTint.Shadow, 'HotTintShadow');
  DefineProperty(HotTint.Shine, 'HotTintShine');
  DefineProperty(PressedTint.Mask, 'PressedTintMask');
  DefineProperty(PressedTint.Shadow, 'PressedTintShadow');
  DefineProperty(PressedTint.Shine, 'PressedTintShine');
  DefineProperty(FocusedTint.Mask, 'FocusedTintMask');
  DefineProperty(FocusedTint.Shadow, 'FocusedTintShadow');
  DefineProperty(FocusedTint.Shine, 'FocusedTintShine');
end;

function TTintedButtonStyleObject.GetCanBeTinted: Boolean;
begin
  Result := not FTintSources[TButtonAnimation.Normal].Mask.Empty;
end;

function TTintedButtonStyleObject.GetCurrentLink: TBitmapLinks;
begin
  case TintStage of
    TCustomStyleObject.TTintStage.Shadow: Result := FTintSources[FCurrent].Shadow;
    TCustomStyleObject.TTintStage.Mask: Result := FTintSources[FCurrent].Mask;
    TCustomStyleObject.TTintStage.Shine: Result := FTintSources[FCurrent].Shine;
  else
    Result := inherited GetCurrentLink;
  end;
end;

function TTintedButtonStyleObject.GetTintStage(const Index: TButtonAnimation): TTintedStages;
begin
  Result := FTintSources[Index];
end;

procedure TTintedButtonStyleObject.SetTintStage(const Index: TButtonAnimation; const Value: TTintedStages);
begin
  FTintSources[Index].Assign(Value);
end;

{ TSystemButtonObject }

constructor TSystemButtonObject.Create(AOwner: TComponent);
begin
  inherited;
  FInactiveAnimation := TStyleAnimation.CreateAnimation('', InactiveTriggered);
  FInactiveAnimation.Trigger := 'IsActive=False';
  FInactiveAnimation.TriggerInverse := 'IsActive=True';
  FInactiveLink := TBitmapLinks.Create;
end;

destructor TSystemButtonObject.Destroy;
begin
  FInactiveLink.Free;
  FInactiveAnimation.Free;
  inherited;
end;

procedure TSystemButtonObject.DefineProperties(Filer: TFiler);
var
  BitmapLinksLoader: TBitmapLinks.TPropertyLoader;
begin
  inherited;
  BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(InactiveLink, Filer, 'InactiveRect');
  try
    BitmapLinksLoader.ReadSourceRects;
  finally
    BitmapLinksLoader.Free;
  end;
end;

function TSystemButtonObject.GetCurrentLink: TBitmapLinks;
begin
  if FInactive then
    Result := FInactiveLink
  else
    Result := inherited ;
end;

procedure TSystemButtonObject.InactiveTriggered(Sender: TObject);
begin
  FInactive := not FInactiveAnimation.Inverse;
  Repaint;
end;

procedure TSystemButtonObject.SetInactiveLink(const Value: TBitmapLinks);
begin
  FInactiveLink.Assign(Value);
end;

{ TMaskedImage }

constructor TMaskedImage.Create(AOwner: TComponent);
begin
  inherited ;
  FContentObject := CreateContentObject;
  FContentObject.SetSubComponent(True);
  FNeedsUpdate := True;
end;

destructor TMaskedImage.Destroy;
begin
  if FBuffer <> nil then
    FBuffer.Free;
  FContentObject.Free;
  inherited;
end;

function TMaskedImage.CreateContentObject: TCustomStyleObject;
begin
  Result := TStyleObject.Create(nil);
end;

procedure TMaskedImage.DefineProperties(Filer: TFiler);
var
  BitmapLinksLoader: TBitmapLinks.TPropertyLoader;
begin
  inherited;
  Filer.DefineProperty('SourceMarginWrapMode', ReadMarginWrapMode, nil, False);
  Filer.DefineProperty('SourceWrapMode', ReadWrapMode, nil, False);
  BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(FContentObject.GetCurrentLink, Filer);
  try
    BitmapLinksLoader.ReadSourceRects;
    BitmapLinksLoader.ReadCapInsets;
  finally
    BitmapLinksLoader.Free;
  end;
end;

procedure TMaskedImage.ReadMarginWrapMode(Reader: TReader);
var
  MarginWrapMode: TImageWrapMode;
  Ident: Integer;
  StringIdent: string;
begin
  StringIdent := Reader.ReadIdent;
  if IdentToInt(StringIdent, Ident, WrapModes) or IdentToInt(StringIdent, Ident, WrapModesWithPrefix) then
  begin
    MarginWrapMode := TImageWrapMode(Ident);
    case MarginWrapMode of
      TImageWrapMode.Stretch: FContentObject.CapMode := TCapWrapMode.Stretch;
      TImageWrapMode.Tile: FContentObject.CapMode := TCapWrapMode.Tile;
    end;
  end;
end;

procedure TMaskedImage.ReadWrapMode(Reader: TReader);
var
  Ident: Integer;
  StringIdent: string;
begin
  StringIdent := Reader.ReadIdent;
  if IdentToInt(StringIdent, Ident, WrapModes) or IdentToInt(StringIdent, Ident, WrapModesWithPrefix) then
    FContentObject.WrapMode := TImageWrapMode(Ident);
end;

procedure TMaskedImage.DoChanged;
begin
  inherited ;
  NeedsUpdate;
end;

function TMaskedImage.GetSourceLookup: string;
begin
  Result := FContentObject.SourceLookup;
end;

procedure TMaskedImage.NeedsUpdate;
begin
  FNeedsUpdate := True;
end;

procedure TMaskedImage.PrepareBuffer;
var
  ComposedBuffer: TBitmap;
  Dest, Composed: TBitmapData;
  DestPos: TPointF;
  I, J: Integer;
  BitmapRect: TRectF;
  Pixel, ComposedPixel: TAlphaColorF;
  CurrentBitmap: TBitmap;
  SourceLink: TBitmapLink;
  ScreenScale: Single;
begin
  if not FContentObject.IsEmpty and FNeedsUpdate then
  begin
    CurrentBitmap := Bitmap;
    if not CurrentBitmap.IsEmpty then
    begin
      if FBuffer = nil then
        FBuffer := TBitmap.Create;

      if Scene <> nil then
        ScreenScale := Scene.GetSceneScale
      else
        ScreenScale := Canvas.Scale;

      SourceLink := FContentObject.GetCurrentLink.LinkByScale(ScreenScale, False);
      if SourceLink <> nil then
      begin
        BitmapRect := TRectF.Create(0, 0, CurrentBitmap.Width, CurrentBitmap.Height);
        BitmapRect.Fit(SourceLink.SourceRect.Rect);
        BitmapRect.Offset(-SourceLink.SourceRect.Left, -SourceLink.SourceRect.Top);

        FBuffer.SetSize(Round(SourceLink.SourceRect.Width), Round(SourceLink.SourceRect.Height));
        FBuffer.BitmapScale := ScreenScale;

        // Prepare icon buffer
        if FBuffer.Canvas.BeginScene then
        try
          FBuffer.Canvas.Clear(0);
          DestPos := TPointF.Create(FBuffer.Canvas.AlignToPixelHorizontally(BitmapRect.Left / ScreenScale),
            FBuffer.Canvas.AlignToPixelVertically(BitmapRect.Top / ScreenScale));
          FBuffer.Canvas.DrawBitmap(CurrentBitmap, TRectF.Create(0, 0, CurrentBitmap.Width, CurrentBitmap.Height),
            TRectF.Create(DestPos.X, DestPos.Y,
              DestPos.X + BitmapRect.Width / ScreenScale,
              DestPos.Y + BitmapRect.Height / ScreenScale), 1);
        finally
          FBuffer.Canvas.EndScene;
        end;

        ComposedBuffer := TBitmap.Create(FBuffer.Width, FBuffer.Height);
        try
          ComposedBuffer.BitmapScale := ScreenScale;
          // Prepare composed buffer
          if ComposedBuffer.Canvas.BeginScene then
          try
            ContentObject.DrawToCanvas(ComposedBuffer.Canvas, TRectF.Create(0, 0, FBuffer.Width / ScreenScale, FBuffer.Height / ScreenScale));
          finally
            ComposedBuffer.Canvas.EndScene;
          end;

          // Compose
          if FBuffer.Map(TMapAccess.ReadWrite, Dest) and
             ComposedBuffer.Map(TMapAccess.Read, Composed) then
          try
            for I := 0 to Dest.Width - 1 do
              for J := 0 to Dest.Height - 1 do
              begin
                Pixel := TAlphaColorF.Create(Dest.GetPixel(I, J)).UnpremultipliedAlpha;
                if Pixel.A > 0 then
                begin
                  ComposedPixel := TAlphaColorF.Create(Composed.GetPixel(I, J)).UnpremultipliedAlpha;
                  Pixel.R := ComposedPixel.R;
                  Pixel.G := ComposedPixel.G;
                  Pixel.B := ComposedPixel.B;
                  Pixel.A := Pixel.A * ComposedPixel.A;
                  Dest.SetPixel(I, J, Pixel.PremultipliedAlpha.ToAlphaColor);
                end;
              end;
          finally
            ComposedBuffer.Unmap(Composed);
            FBuffer.Unmap(Dest);
          end;
        finally
          ComposedBuffer.Free;
        end;
      end;
    end;
    FNeedsUpdate := False;
  end;
end;

procedure TMaskedImage.SetSourceLookup(const Value: string);
begin
  FContentObject.SourceLookup := Value;
end;

procedure TMaskedImage.StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string);
begin
  ContentObject.StartTriggerAnimation(AInstance, ATrigger);
end;

procedure TMaskedImage.Paint;
begin
  PrepareBuffer;

  if FBuffer <> nil then
    DrawBitmap(Canvas, LocalRect, FBuffer, AbsoluteOpacity)
  else
    inherited Paint;
end;

{ TActiveMaskedImage }

constructor TActiveMaskedImage.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TActiveMaskedImage.Destroy;
begin
  inherited;
end;

procedure TActiveMaskedImage.DoTriggered(Sender: TObject);
begin
  NeedsUpdate;
end;

procedure TActiveMaskedImage.DefineProperties(Filer: TFiler);
var
  BitmapLinksLoader: TBitmapLinks.TPropertyLoader;
begin
  inherited;
  BitmapLinksLoader := TBitmapLinks.TPropertyLoader.Create(TActiveStyleObject(ContentObject).ActiveLink, Filer, 'ActiveRect');
  try
    BitmapLinksLoader.ReadSourceRects;
  finally
    BitmapLinksLoader.Free;
  end;
end;

function TActiveMaskedImage.CreateContentObject: TCustomStyleObject;
begin
  Result := TActiveStyleObject.Create(nil);
  TActiveStyleObject(Result).OnTriggered := DoTriggered;
end;

function TActiveMaskedImage.GetTrigger: TStyleTrigger;
begin
  Result := TActiveStyleObject(ContentObject).ActiveTrigger;
end;

procedure TActiveMaskedImage.SetTrigger(const Value: TStyleTrigger);
begin
  TActiveStyleObject(ContentObject).ActiveTrigger := Value;
end;

type
  TPositionOffset = class (TPosition)
  private
    [weak] FShadow: TStyleShadow;
  protected
    procedure DoChange; override;
  public
    constructor Create(AOwner: TStyleShadow); reintroduce;
  end;

{ TPositionOffset }

constructor TPositionOffset.Create(AOwner: TStyleShadow);
begin
  inherited Create(TPointF.Zero);
  FShadow := AOwner;
  StoreAsInt := True;
end;

procedure TPositionOffset.DoChange;
begin
  inherited;
  FShadow.DoChanged;
end;

{ TStyleShadow }

constructor TStyleShadow.Create;
begin
  FOffset := TPositionOffset.Create(Self);
  FColor := claNull;
end;

destructor TStyleShadow.Destroy;
begin
  FOffset.Free;
  inherited;
end;

procedure TStyleShadow.Assign(Source: TPersistent);
var
  SStyleShadow: TStyleShadow;
begin
  if Source is TStyleShadow then
  begin
    SStyleShadow := TStyleShadow(Source);
    if (Color <> SStyleShadow.FColor) or (FOffset <> SStyleShadow.FOffset) then
    begin
      FColor := SStyleShadow.FColor;
      FOffset.SetPointNoChange(SStyleShadow.Offset.Point);
      DoChanged;
    end;
  end else
    inherited
end;

procedure TStyleShadow.DoChanged;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

function TStyleShadow.Equals(Obj: TObject): Boolean;
begin
  if Obj is TStyleShadow then
    Result := (TStyleShadow(Obj).Color = Color) and SameValue(TStyleShadow(Obj).Offset.X, Offset.X, TEpsilon.Position)
      and SameValue(TStyleShadow(Obj).Offset.Y, Offset.Y, TEpsilon.Position)
  else
    Result := False;
end;

procedure TStyleShadow.SetColor(const Value: TAlphaColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    DoChanged;
  end;
end;

procedure TStyleShadow.SetOffset(const Value: TPosition);
begin
  FOffset.Assign(Value);
end;

type
  TStyleTextShadow = class (TStyleShadow)
  private
    [weak] FTextObject: TStyleTextObject;
  protected
    procedure DoChanged; override;
  public
    constructor Create(const ATextObject: TStyleTextObject);
    property TextObject: TStyleTextObject read FTextObject;
  end;

{ TStyleTextShadow }

constructor TStyleTextShadow.Create(const ATextObject: TStyleTextObject);
begin
  inherited Create;
  FTextObject := ATextObject;
end;

procedure TStyleTextShadow.DoChanged;
begin
  if FTextObject <> nil then
    FTextObject.ShadowChanged;
  inherited;
end;

{ TStyleTextObject }

constructor TStyleTextObject.Create(AOwner: TComponent);
begin
  inherited;
  HitTest := False;
  FShadow := TStyleTextShadow.Create(Self);
  FSavedShadow := TStyleTextShadow.Create(Self);
  FCurrentShadow := TStyleShadow.Create;
end;

destructor TStyleTextObject.Destroy;
begin
  FCurrentShadow.Free;
  FShadow.Free;
  FSavedShadow.Free;
  inherited;
end;

procedure TStyleTextObject.DrawToCanvas(const Canvas: TCanvas; const ARect: TRectF; const AOpacity: Single);
begin
  if FShadowVisible then
  begin
    Layout.BeginUpdate;
    try
      Layout.TopLeft := ARect.TopLeft + FCurrentShadow.Offset.Point;
      Layout.Opacity := AOpacity;
      Layout.MaxSize := PointF(ARect.Width, ARect.Height);
      Layout.Color := CurrentShadow.Color;
    finally
      Layout.EndUpdate;
    end;
    Layout.RenderLayout(Canvas);
  end;

  Layout.BeginUpdate;
  try
    Layout.TopLeft := ARect.TopLeft;
    Layout.Opacity := AOpacity;
    Layout.MaxSize := PointF(ARect.Width, ARect.Height);
    Layout.Color := CurrentColor;
  finally
    Layout.EndUpdate;
  end;
  Layout.RenderLayout(Canvas);
end;

function TStyleTextObject.SetCurrentProperties(const AColor: TAlphaColorRec; const AShadow: TStyleShadow): Boolean;
begin
  Result := (FCurrentShadow <> nil) and ((FCurrentColor <> AColor.Color) or (not FCurrentShadow.Equals(AShadow)));
  if Result then
  begin
    FCurrentColor := AColor.Color;
    FCurrentShadow.Assign(AShadow);
  end;
end;

function TStyleTextObject.UpdateCurrentProperties: Boolean;
var
  LColor: TAlphaColorRec;
begin
  Result := False;
  if FShadow <> nil then
  begin
    LColor.Color := TextSettings.FontColor;
    Result := SetCurrentProperties(LColor, FShadow);
  end;
end;

procedure TStyleTextObject.FontChanged;
begin
  UpdateCurrentProperties;
  inherited;
end;

function TStyleTextObject.GetSavedColor: TAlphaColor;
begin
  Result := (Self as ITextSettings).DefaultTextSettings.FontColor;
end;

procedure TStyleTextObject.UpdateDefaultTextSettings;
begin
  inherited;
  FSavedShadow.Assign(FShadow);
end;

procedure TStyleTextObject.Paint;
begin
  DrawToCanvas(Canvas, LocalRect, AbsoluteOpacity);
  if (AcceleratorKeyInfo <> nil) and not AcceleratorKeyInfo.DrawUnderline(Self, Canvas, Layout, TextSettings.FontColor,
    Opacity) then
    RemoveAcceleratorKeyInfo;
end;

function TStyleTextObject.ConvertText(const Value: string): string;
begin
  case CharCase of
    TEditCharCase.ecUpperCase: Result := Value.ToUpper;
    TEditCharCase.ecLowerCase: Result := Value.ToLower;
  else
    Result := inherited ConvertText(Value);
  end;
end;

procedure TStyleTextObject.SetCharCase(const Value: TEditCharCase);
begin
  FCharCase := Value;
end;

procedure TStyleTextObject.SetShadow(const Value: TStyleShadow);
begin
  FShadow.Assign(Value);
end;

procedure TStyleTextObject.SetShadowVisible(const Value: Boolean);
begin
  if FShadowVisible <> Value then
  begin
    FShadowVisible := Value;
    Repaint;
  end;
end;

procedure TStyleTextObject.ShadowChanged;
begin
  if UpdateCurrentProperties then
    Repaint;
end;

{ TStyleTextAnimation }

constructor TStyleTextAnimation.Create(AOwner: TComponent);
begin
  inherited;
  FShadow := TStyleShadow.Create;
  FColor := claNull;
  Duration := 0.0001;
end;

class function TStyleTextAnimation.CreateAnimation(const Trigger: string; const Event: TNotifyEvent): TStyleTextAnimation;
begin
  Result := TStyleTextAnimation.Create(nil);
  Result.Trigger := Trigger;
  Result.OnFinish := Event;
end;

destructor TStyleTextAnimation.Destroy;
begin
  FShadow.Free;
  inherited;
end;

procedure TStyleTextAnimation.ProcessAnimation;
begin
end;

procedure TStyleTextAnimation.SetShadow(const Value: TStyleShadow);
begin
  FShadow.Assign(Value);
end;

procedure TStyleTextAnimation.AssignIfEmpty(const StyleTextObject: TStyleTextObject);
begin
  if Color = claNull then
    Color := StyleTextObject.Color;
  if Shadow.Color = claNull then
    Shadow.Color := StyleTextObject.Shadow.Color;
  if Shadow.Offset.Empty then
    Shadow.Offset := StyleTextObject.Shadow.Offset;
end;

{ TActiveStyleTextObject }

constructor TActiveStyleTextObject.Create(AOwner: TComponent);
begin
  inherited;
  FActiveAnimation := TStyleTextAnimation.CreateAnimation('', Triggered);
end;

destructor TActiveStyleTextObject.Destroy;
begin
  FActiveAnimation.Free;
  inherited;
end;

function TActiveStyleTextObject.GetActiveColor: TAlphaColor;
begin
  Result := FActiveAnimation.Color;
end;

function TActiveStyleTextObject.GetActiveShadow: TStyleShadow;
begin
  Result := FActiveAnimation.Shadow;
end;

procedure TActiveStyleTextObject.Loaded;
begin
  inherited;
  FActiveAnimation.AssignIfEmpty(Self);
end;

function TActiveStyleTextObject.RestoreState: Boolean;
begin
  Result := inherited;
  if Result then
    Active := FSavedActive;
end;

function TActiveStyleTextObject.SaveState: Boolean;
begin
  Result := inherited;
  if Result then
    FSavedActive := Active;
end;

procedure TActiveStyleTextObject.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    if UpdateCurrentProperties then
      Repaint;
  end;
end;

procedure TActiveStyleTextObject.SetActiveColor(const Value: TAlphaColor);
begin
  FActiveAnimation.Color := Value;
end;

procedure TActiveStyleTextObject.SetActiveShadow(const Value: TStyleShadow);
begin
  FActiveAnimation.Shadow.Assign(Value);
end;

procedure TActiveStyleTextObject.SetTrigger(const Value: TStyleTrigger);
begin
  FTrigger := Value;
  SetupAnimations;
end;

procedure TActiveStyleTextObject.SetupAnimations;
begin
  FActiveAnimation.Trigger := StyleTriggerToProperty(FTrigger) + '=True';
  FActiveAnimation.TriggerInverse := StyleTriggerToProperty(FTrigger) + '=False';
end;

procedure TActiveStyleTextObject.StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string);
begin
  inherited;
  FActiveAnimation.StartTrigger(AInstance, ATrigger);
end;

procedure TActiveStyleTextObject.Triggered(Sender: TObject);
begin
  Active := not FActiveAnimation.Inverse;
end;

function TActiveStyleTextObject.UpdateCurrentProperties: Boolean;
var
  LColor: TAlphaColorRec;
  LShadow: TStyleShadow;
begin
  Result := False;
  if FShadow <> nil then
  begin
    LShadow := TStyleShadow.Create;
    try
      if FShadow.Equals(SavedShadow) and Active then
        LShadow.Assign(ActiveShadow)
      else
        LShadow.Assign(FShadow);

      if (TextSettings.FontColor = SavedColor) and Active then
        LColor.Color := ActiveColor
      else
        LColor.Color := TextSettings.FontColor;

      Result := SetCurrentProperties(LColor, LShadow);
    finally
      FreeAndNil(LShadow);
    end;
  end;
end;

{ TTabStyleTextObject }

constructor TTabStyleTextObject.Create(AOwner: TComponent);
begin
  inherited;
  FHotAnimation := TStyleTextAnimation.CreateAnimation('', HotTriggered);
end;

destructor TTabStyleTextObject.Destroy;
begin
  FHotAnimation.Free;
  inherited;
end;

function TTabStyleTextObject.GetHotColor: TAlphaColor;
begin
  Result := FHotAnimation.Color;
end;

function TTabStyleTextObject.GetHotShadow: TStyleShadow;
begin
  Result := FHotAnimation.Shadow;
end;

procedure TTabStyleTextObject.HotTriggered(Sender: TObject);
begin
  Hot := not FHotAnimation.Inverse;
end;

procedure TTabStyleTextObject.Loaded;
begin
  inherited;
  FHotAnimation.AssignIfEmpty(Self);
end;

function TTabStyleTextObject.RestoreState: Boolean;
begin
  Result := inherited;
  if Result then
    Hot := FSavedHot;
end;

function TTabStyleTextObject.SaveState: Boolean;
begin
  Result := inherited;
  if Result then
    FSavedHot := Hot;
end;

function TTabStyleTextObject.UpdateCurrentProperties: Boolean;
var
  LColor: TAlphaColorRec;
  LShadow: TStyleShadow;
begin
  Result := False;
  if FShadow <> nil then
  begin
    LShadow := TStyleShadow.Create;
    try
      if FShadow.Equals(SavedShadow) and (Hot or Active) then
      begin
        if Active then
          LShadow.Assign(ActiveShadow)
        else
          LShadow.Assign(HotShadow);
      end
      else
        LShadow.Assign(FShadow);

      if (TextSettings.FontColor = SavedColor) and (Hot or Active) then
      begin
        if Active then
          LColor.Color := ActiveColor
        else
          LColor.Color := HotColor;
      end
      else
        LColor.Color := TextSettings.FontColor;

      Result := SetCurrentProperties(LColor, LShadow);
    finally
      FreeAndNil(LShadow);
    end;
  end;
end;

procedure TTabStyleTextObject.SetHot(const Value: Boolean);
begin
  if FHot <> Value then
  begin
    FHot := Value;
    if UpdateCurrentProperties then
      Repaint;
  end;
end;

procedure TTabStyleTextObject.SetHotColor(const Value: TAlphaColor);
begin
  if FHotAnimation.Color <> Value then
  begin
    FHotAnimation.Color := Value;
    if UpdateCurrentProperties then
      Repaint;
  end;
end;

procedure TTabStyleTextObject.SetHotShadow(const Value: TStyleShadow);
begin
  FHotAnimation.Shadow.Assign(Value);
  if UpdateCurrentProperties then
    Repaint;
end;

procedure TTabStyleTextObject.SetupAnimations;
begin
  FActiveAnimation.Trigger := StyleTriggerToProperty(FTrigger) + '=True';
  FActiveAnimation.TriggerInverse := StyleTriggerToProperty(FTrigger) + '=False';
  FHotAnimation.Trigger := 'IsMouseOver=True;' + StyleTriggerToProperty(FTrigger) + '=False';
  FHotAnimation.TriggerInverse := 'IsMouseOver=False;' + StyleTriggerToProperty(FTrigger) + '=False';
end;

procedure TTabStyleTextObject.StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string);
begin
  inherited;
  FHotAnimation.StartTrigger(AInstance, ATrigger);
end;

type
  TButtonTextSettings = class (TTextSettings)
  public
    constructor Create(const AOwner: TPersistent); override;
  published
    property Font;
    property FontColor;
    property Trimming default TTextTrimming.None;
    property WordWrap default True;
    property HorzAlign default TTextAlign.Center;
    property VertAlign default TTextAlign.Center;
  end;

{ TButtonTextSettings }

constructor TButtonTextSettings.Create(const AOwner: TPersistent);
begin
  inherited;
  Trimming := TTextTrimming.None;
  WordWrap := True;
  HorzAlign := TTextAlign.Center;
  VertAlign := TTextAlign.Center;
end;

{ TButtonStyleTextObject }

constructor TButtonStyleTextObject.Create(AOwner: TComponent);
begin
  inherited;
  FTriggerSources[TButtonAnimation.Normal] :=
    TStyleTextAnimation.CreateAnimation('IsMouseOver=False;IsPressed=False;IsFocused=False', NormalTriggered);

  FTriggerSources[TButtonAnimation.Hot] :=
    TStyleTextAnimation.CreateAnimation('IsMouseOver=True;IsPressed=False', HotTriggered);

  FTriggerSources[TButtonAnimation.Focused] :=
    TStyleTextAnimation.CreateAnimation('IsMouseOver=False;IsFocused=True;IsPressed=False', FocusedTriggered);

  FTriggerSources[TButtonAnimation.Pressed] :=
    TStyleTextAnimation.CreateAnimation('IsMouseOver=True;IsPressed=True', PressedTriggered);
end;

destructor TButtonStyleTextObject.Destroy;
var
  I: TButtonAnimation;
begin
  for I := Low(FTriggerSources) to High(FTriggerSources) do
    if FTriggerSources[I] <> nil then
      FTriggerSources[I].Free;
  inherited;
end;

procedure TButtonStyleTextObject.FocusedTriggered(Sender: TObject);
begin
  ButtonState := TButtonAnimation.Focused;
end;

procedure TButtonStyleTextObject.NormalTriggered(Sender: TObject);
begin
  ButtonState := TButtonAnimation.Normal;
end;

procedure TButtonStyleTextObject.PressedTriggered(Sender: TObject);
begin
  ButtonState := TButtonAnimation.Pressed;
end;

function TButtonStyleTextObject.RestoreState: Boolean;
begin
  Result := inherited;
  if Result then
    ButtonState := FSavedButtonState;
end;

function TButtonStyleTextObject.SaveState: Boolean;
begin
  Result := inherited;
  if Result then
    FSavedButtonState := ButtonState;
end;

procedure TButtonStyleTextObject.HotTriggered(Sender: TObject);
begin
  ButtonState := TButtonAnimation.Hot;
end;

procedure TButtonStyleTextObject.Loaded;
var
  I: TButtonAnimation;
begin
  inherited;
  for I := Low(FTriggerSources) to High(FTriggerSources) do
    FTriggerSources[I].AssignIfEmpty(Self);
  Shadow.Assign(FTriggerSources[TButtonAnimation.Normal].Shadow);
  Color := FTriggerSources[TButtonAnimation.Normal].Color;
  UpdateDefaultTextSettings;
  UpdateCurrentProperties;
end;

procedure TButtonStyleTextObject.StartTriggerAnimation(const AInstance: TFmxObject;
  const ATrigger: string);
var
  I: TButtonAnimation;
begin
  inherited;
  for I := Low(FTriggerSources) to High(FTriggerSources) do
    if FTriggerSources[I] <> nil then
      FTriggerSources[I].StartTrigger(AInstance, ATrigger);
end;

procedure TButtonStyleTextObject.GetFontColors(var AColors, ADefColors: TFontColorForState);
begin
  AColors := TextSettings.FontColorForState;
  ADefColors := (Self as ITextSettings).DefaultTextSettings.FontColorForState;
end;

function TButtonStyleTextObject.UpdateCurrentProperties: Boolean;
var
  LColor: TAlphaColorRec;
  LShadow: TStyleShadow;
  LColors, LDefColors: TFontColorForState;
  I: TFontColorForState.TIndex;
  function SameColors: Boolean;
  var
    I: TFontColorForState.TIndex;
  begin
    Result := True;
    for I := TFontColorForState.TIndex(Low(TButtonAnimation)) to TFontColorForState.TIndex(High(TButtonAnimation)) do
      if LColors.CurrentColor[I] <> LDefColors.CurrentColor[I] then
        Exit(False);
  end;
begin
  Result := False;
  if (FShadow <> nil) and (FTriggerSources[FButtonState] <> nil) and (FTriggerSources[FButtonState].Shadow <> nil) then
  begin
    LShadow := TStyleShadow.Create;
    try
      GetFontColors(LColors, LDefColors);
      if FShadow.Equals(SavedShadow) then
        LShadow.Assign(FTriggerSources[FButtonState].Shadow)
      else
        LShadow.Assign(FShadow);
      I := TFontColorForState.TIndex(FButtonState);
      if (LColors.CurrentColor[I] = claNull) or SameColors then
        LColor.Color := FTriggerSources[FButtonState].Color
      else
        LColor.Color := LColors.CurrentColor[I];

      Result := SetCurrentProperties(LColor, LShadow);
    finally
      FreeAndNil(LShadow);
    end;
  end;
end;

procedure TButtonStyleTextObject.UpdateDefaultTextSettings;
var
  LColors, LDefColors: TFontColorForState;
  I: TButtonAnimation;
begin
  inherited;
  GetFontColors(LColors, LDefColors);
  for I := Low(TButtonAnimation) to High(TButtonAnimation) do
  begin
    LDefColors[TFontColorForState.TIndex(I)] := FTriggerSources[I].Color;
    LColors[TFontColorForState.TIndex(I)] := FTriggerSources[I].Color;
  end;
end;

procedure TButtonStyleTextObject.SetButtonState(const Value: TButtonAnimation);
begin
  if FButtonState <> Value then
  begin
    FButtonState := Value;
    if UpdateCurrentProperties then
      Repaint;
  end;
end;

function TButtonStyleTextObject.GetColor(Index: TButtonAnimation): TAlphaColor;
begin
  Result := FTriggerSources[Index].Color;
end;

procedure TButtonStyleTextObject.SetColor(Index: TButtonAnimation; const Value: TAlphaColor);
begin
  if FTriggerSources[Index].Color <> Value then
  begin
    FTriggerSources[Index].Color := Value;
    if UpdateCurrentProperties then
      Repaint;
  end;
end;

function TButtonStyleTextObject.GetShadow(Index: TButtonAnimation): TStyleShadow;
begin
  Result := FTriggerSources[Index].Shadow;
end;

function TButtonStyleTextObject.GetTextSettingsClass: TTextSettingsClass;
begin
  Result := TButtonTextSettings;
end;

procedure TButtonStyleTextObject.SetShadow(Index: TButtonAnimation; const Value: TStyleShadow);
begin
  FTriggerSources[Index].Shadow.Assign(Value);
  if UpdateCurrentProperties then
    Repaint;
end;

{ TActiveOpacityObject }

constructor TActiveOpacityObject.Create(AOwner: TComponent);
begin
  inherited;
  HitTest := False;
  FActiveOpacity := 1.0;
  FActiveAnimation := TStyleAnimation.CreateAnimation('', Triggered);
  SetupAnimation;
end;

destructor TActiveOpacityObject.Destroy;
begin
  FActiveAnimation.Free;
  inherited;
end;

function TActiveOpacityObject.IsActiveOpacityStored: Boolean;
begin
  Result := not SameValue(FActiveOpacity, 1.0);
end;

procedure TActiveOpacityObject.Loaded;
begin
  inherited;
  FSavedOpacity := Opacity;
end;

procedure TActiveOpacityObject.SetTrigger(const Value: TStyleTrigger);
begin
  if FTrigger <> Value then
  begin
    FTrigger := Value;
    SetupAnimation;
  end;
end;

procedure TActiveOpacityObject.SetupAnimation;
begin
  FActiveAnimation.Trigger := StyleTriggerToProperty(FTrigger) + '=True';
  FActiveAnimation.TriggerInverse := StyleTriggerToProperty(FTrigger) + '=False';
end;

procedure TActiveOpacityObject.StartTriggerAnimation(const AInstance: TFmxObject; const ATrigger: string);
begin
  inherited;
  FActiveAnimation.StartTrigger(AInstance, ATrigger);
end;

procedure TActiveOpacityObject.Triggered(Sender: TObject);
begin
  if FActiveAnimation.Inverse then
    Opacity := FSavedOpacity
  else
    Opacity := FActiveOpacity;
end;

procedure RegisterAliases;
begin
  AddEnumElementAliases(TypeInfo(TStyleTrigger), ['stMouseOver', 'stPressed', 'stSelected', 'stFocused', 'stChecked', 'stActive']);
  AddEnumElementAliases(TypeInfo(TCapWrapMode), ['cmStretch', 'cmTile']);
end;

procedure UnregisterAliases;
begin
  RemoveEnumElementAliases(TypeInfo(TStyleTrigger));
  RemoveEnumElementAliases(TypeInfo(TCapWrapMode));
end;

initialization
  RegisterAliases;
  RegisterFmxClasses([
    TSubImage, TGlyph,
    TStyleObject, TActiveStyleObject, TTabStyleObject, TCheckStyleObject, TButtonStyleObject, TSystemButtonObject,
    TTintedStyleObject, TTintedButtonStyleObject,
    TMaskedImage, TActiveMaskedImage,
    TStyleTextObject, TActiveStyleTextObject, TTabStyleTextObject, TButtonStyleTextObject, TActiveOpacityObject
  ]);
  TCustomStyleObject.AlignToPixels := True;
finalization
  UnregisterAliases;
end.

