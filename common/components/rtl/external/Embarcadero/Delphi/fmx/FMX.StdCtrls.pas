{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.StdCtrls;

interface

uses
  System.Classes, System.Actions, System.Types, System.Rtti, System.UITypes,
  System.UIConsts, FMX.Forms, FMX.ActnList, FMX.Types, FMX.Objects, FMX.Ani,
  FMX.StdActns, FMX.PixelFormats, FMX.Controls, FMX.Messages;

{$SCOPEDENUMS ON}

type

{ TPanel }

  TPanel = class(TStyledControl)
  protected
    function GetDefaultSize: TSizeF; override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Action;
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property TabOrder;
    property OnApplyStyleLookup;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnKeyDown;
    property OnKeyUp;
    property OnCanFocus;
    property OnEnter;
    property OnExit;
    property OnClick;
    property OnDblClick;
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

{ TCalloutPanel }

  TCalloutPanel = class(TPanel)
  private
    FCalloutLength: Single;
    FCalloutWidth: Single;
    FCalloutPosition: TCalloutPosition;
    FCalloutOffset: Single;
    procedure SetCalloutLength(const Value: Single);
    procedure SetCalloutPosition(const Value: TCalloutPosition);
    procedure SetCalloutWidth(const Value: Single);
    procedure SetCalloutOffset(const Value: Single);
    procedure UpdateMargins;
  protected
    procedure ApplyStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CalloutWidth: Single read FCalloutWidth write SetCalloutWidth;
    property CalloutLength: Single read FCalloutLength write SetCalloutLength;
    property CalloutPosition: TCalloutPosition read FCalloutPosition write SetCalloutPosition
      default TCalloutPosition.cpTop;
    property CalloutOffset: Single read FCalloutOffset write SetCalloutOffset;
  end;

{ TLabel }

  TLabel = class(TTextControl)
  private
    FAutoSize: Boolean;
    FIsPressed: Boolean;
    procedure SetAutoSize(const Value: Boolean);
    procedure FitSize;
  protected
    procedure ApplyStyle; override;
    procedure SetText(const Value: string); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetDefaultSize: TSizeF; override;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    { triggers }
    property IsPressed: Boolean read FIsPressed;
  published
    property Action;
    property Align;
    property Anchors;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    property AutoTranslate default True;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Font;
    property FontColor;
    property StyledSettings;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default False;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property Text;
    property TextAlign;
    property TouchTargetExpansion;
    property VertTextAlign;
    property Visible default True;
    property Width;
    property WordWrap default True;
    property Trimming default TTextTrimming.ttNone;
    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TCustomButton }

  TCustomButton = class(TTextControl)
  private
    FPressing: Boolean;
    FIsPressed: Boolean;
    FModalResult: TModalResult;
    FStaysPressed: Boolean;
    FRepeatTimer: TTimer;
    FRepeat: Boolean;
  protected
    function IsPressedStored: boolean; virtual;
    procedure ApplyTriggers; virtual;
    procedure SetIsPressed(const Value: Boolean); virtual;
    procedure SetStaysPressed(const Value: Boolean); virtual;
    procedure Click; override;
    procedure DblClick; override;
    procedure ApplyStyle; override;
    procedure ToggleStaysPressed; virtual;
    procedure DoRepeatTimer(Sender: TObject);
    procedure DoRepeatDelayTimer(Sender: TObject);
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Action;
    property StaysPressed: Boolean read FStaysPressed write SetStaysPressed stored IsPressedStored default False;
    { triggers }
    property IsPressed: Boolean read FIsPressed write SetIsPressed default False;
    property ModalResult: TModalResult read FModalResult write FModalResult default mrNone;
    property RepeatClick: Boolean read FRepeat write FRepeat default False;
  published
  end;

{ TButton }

  TButton = class(TCustomButton)
  private
    FDefault: Boolean;
    FCancel: Boolean;
  protected
    procedure DialogKey(var Key: Word; Shift: TShiftState); override;
  published
    property StaysPressed default False;
    property Action;
    property Align default TAlignLayout.alNone;
    property Anchors;
    property AutoTranslate default True;
    property Cancel: Boolean read FCancel write FCancel default False;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property Default: Boolean read FDefault write FDefault default False;
    property DesignVisible default True;
    property DisableFocusEffect;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Font;
    property StyledSettings;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property IsPressed default False;
    property Locked default False;
    property Padding;
    property ModalResult default mrNone;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RepeatClick default False;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property Text;
    property Trimming;
    property TextAlign default TTextAlign.taCenter;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property WordWrap default False;
    property OnApplyStyleLookup;
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

  TSpeedButtonGroupMessage = class(TMessage)
  private
    FGroupName: string;
  public
    constructor Create(const AGroupName: string);
    property GroupName: string read FGroupName;
  end;

  TSpeedButton = class(TCustomButton, IGroupName)
  private
    FGroupName: string;
    { IIsChecked }
    function GetIsChecked: boolean;
    procedure SetIsChecked(const Value: boolean);
    function IsCheckedStored: boolean;
    procedure GroupMessageCall(const Sender : TObject; const M : TMessage);
    { IGroupName }
    function GetGroupName: string;
    function GroupNameStored: Boolean;
    procedure SetGroupName(const Value: string);
  protected
    function IsPressedStored: boolean; override;
    procedure ToggleStaysPressed; override;
    procedure SetIsPressed(const Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    // do not move this line
    property StaysPressed default False;
    property Action;
    property Align default TAlignLayout.alNone;
    property Anchors;
    property AutoTranslate default True;
    property CanFocus default False;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Font;
    property GroupName: string read GetGroupName write SetGroupName stored GroupNameStored;
    property StyledSettings;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property IsPressed default False;
    property Locked default False;
    property Padding;
    property ModalResult default mrNone;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RepeatClick default False;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property ShowHint default False;
    property StyleLookup;
    property Text;
    property TextAlign default TTextAlign.taCenter;
    property Trimming;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property WordWrap default False;
    property OnApplyStyleLookup;
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
    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

{ TCustomCornerButton }

  TCustomCornerButton = class(TCustomButton)
  private
    FYRadius: Single;
    FXRadius: Single;
    FCorners: TCorners;
    FCornerType: TCornerType;
    FSides: TSides;
    function IsCornersStored: Boolean;
    procedure SetXRadius(const Value: Single);
    procedure SetYRadius(const Value: Single);
    procedure SetCorners(const Value: TCorners);
    procedure SetCornerType(const Value: TCornerType);
    procedure SetSides(const Value: TSides);
    function IsSidesStored: Boolean;
  protected
    procedure ApplyStyle; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property XRadius: Single read FXRadius write SetXRadius;
    property YRadius: Single read FYRadius write SetYRadius;
    property Corners: TCorners read FCorners write SetCorners stored IsCornersStored;
    property CornerType: TCornerType read FCornerType write SetCornerType default TCornerType.ctRound;
    property Sides: TSides read FSides write SetSides stored IsSidesStored;
  end;

{ TCornerButton }

  TCornerButton = class(TCustomCornerButton)
  published
    property StaysPressed default False;
    property Action;
    property Align;
    property Anchors;
    property AutoTranslate default True;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Corners;
    property CornerType;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableFocusEffect;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Font;
    property StyledSettings;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    { triggers }
    property IsPressed default False;

    property Locked default False;
    property Padding;
    property ModalResult default mrNone;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RepeatClick default False;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Sides;
    property StyleLookup;
    property TabOrder;
    property Text;
    property TextAlign default TTextAlign.taCenter;
    property TouchTargetExpansion;
    property WordWrap default False;
    property Visible default True;
    property Width;
    property XRadius;
    property YRadius;

    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TCheckBox }

  TCheckBox = class(TTextControl, IIsChecked)
  private
    FPressing: Boolean;
    FOnChange: TNotifyEvent;
    FIsPressed: Boolean;
    FIsChecked: Boolean;
    function GetIsChecked: boolean;
    procedure SetIsChecked(const Value: boolean);
    function IsCheckedStored: boolean;
  protected
    procedure DoExit; override;
    procedure ApplyStyle; override;
    function CanObserve(const ID: Integer): Boolean; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    property IsPressed: Boolean read FIsPressed default False;
  published
    property Action;
    property Align;
    property Anchors;
    property AutoTranslate default True;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableFocusEffect;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Font;
    property StyledSettings;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property IsChecked: Boolean read GetIsChecked write SetIsChecked stored IsCheckedStored default False;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property Text;
    property TextAlign;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property WordWrap;
    {events}
    property OnApplyStyleLookup;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TRadioButton }

  TRadioButtonGroupMessage = class(TMessage)
  private
    FGroupName: string;
  public
    constructor Create(const AGroupName: string);
    property GroupName: string read FGroupName;
  end;

  TRadioButton = class(TTextControl, IGroupName)
  private
    FPressing: Boolean;
    FOnChange: TNotifyEvent;
    FIsPressed: Boolean;
    FIsChecked: Boolean;
    FGroupName: string;
    function GetIsChecked: boolean;
    procedure SetIsChecked(const Value: boolean);
    function IsCheckedStored: boolean;
    function GetGroupName: string;
    procedure SetGroupName(const Value: string);
    function GroupNameStored: boolean;
    procedure GroupMessageCall(const Sender : TObject; const M : TMessage);
  protected
    procedure ApplyStyle; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    property IsPressed: Boolean read FIsPressed;
  published
    property Action;
    property Align;
    property Anchors;
    property AutoTranslate default True;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableFocusEffect;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Font;
    property StyledSettings;
    property GroupName: string read GetGroupName write SetGroupName stored GroupNameStored;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    { triggers }
    property IsChecked: Boolean read GetIsChecked write SetIsChecked stored IsCheckedStored default False;

    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property Text;
    property TextAlign;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property WordWrap;

    {events}
    property OnApplyStyleLookup;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TGroupBox }

  TGroupBox = class(TTextControl)
  protected
    procedure ApplyStyle; override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Action;
    property Align;
    property Anchors;
    property AutoTranslate default True;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Font;
    property StyledSettings;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property Text;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property TabOrder;
    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TStatusBar }

  TStatusBar = class(TStyledControl)
  private
    FShowSizeGrip: Boolean;
    procedure SetShowSizeGrip(const Value: Boolean);
  protected
    procedure ApplyStyle; override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Action;
    property Align default TAlignLayout.alBottom;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property ShowSizeGrip: Boolean read FShowSizeGrip write SetShowSizeGrip;
    property StyleLookup;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TToolBar }

  TToolBar = class(TStyledControl)
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Action;
    property Align default TAlignLayout.alTop;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TSizeGrip }

  TSizeGrip = class(TStyledControl, ISizeGrip)
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Action;
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TSplitter }

  TSplitter = class(TStyledControl)
  private
    FPressed: Boolean;
    FControl: TControl;
    FDownPos: TPointF;
    FMinSize: Single;
    FMaxSize: Single;
    FNewSize, FOldSize: Single;
    FSplit: Single;
    FShowGrip: Boolean;
    procedure SetShowGrip(const Value: Boolean);
  protected
    procedure ApplyStyle; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Paint; override;
    procedure SetAlign(const Value: TAlignLayout); override;
    function FindObject: TControl;
    procedure CalcSplitSize(X, Y: Single; var NewSize, Split: Single);
    procedure UpdateSize(X, Y: Single);
    function DoCanResize(var NewSize: Single): Boolean;
    procedure UpdateControlSize;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
  published
    property Action;
    property Align;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property MinSize: Single read FMinSize write FMinSize;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property ShowGrip: Boolean read FShowGrip write SetShowGrip default True ;
    property StyleLookup;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TProgressBar }

  TProgressBar = class(TStyledControl, IValueRange)
  private
    FOrientation: TOrientation;
    FValueRange: TValueRange;
    FDefaultValueRange: TBaseValueRange;
    procedure SetOrientation(const Value: TOrientation);
    function GetMax: Single;
    function GetMin: Single;
    function GetValue: Single;
    procedure SetMax(const Value: Single);
    procedure SetMin(const Value: Single);
    procedure SetValue(const Value: Single);
    function GetValueRange: TCustomValueRange;
    procedure SetValueRange(const AValue: TCustomValueRange);
    function DefStored: boolean;
    procedure ChangedProc(Sender: TObject);
    function MaxStored: Boolean;
    function MinStored: Boolean;
    function ValueStored: Boolean;
  protected
    procedure AdjustSize; override;
    procedure ApplyStyle; override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoRealign; override;
    function GetActionLinkClass: TActionLinkClass; override;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    procedure AfterChangeProc(Sender: TObject); virtual;
    property DefaultValueRange: TBaseValueRange read FDefaultValueRange;
    procedure Loaded; override;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AfterConstruction; override;
    destructor Destroy; override;
  published
    property Action;
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Max: Single read GetMax write SetMax stored MaxStored nodefault;
    property Min: Single read GetMin write SetMin stored MinStored nodefault;
    property Opacity;
    property Orientation: TOrientation read FOrientation write SetOrientation;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TouchTargetExpansion;
    property Value: Single read GetValue write SetValue stored ValueStored nodefault;
    property Visible default True;
    property Width;
    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TThumb }

  TCustomTrack = class;

  TThumb = class(TStyledControl)
  private
    FTrack: TCustomTrack;
    FDownOffset: TPointF;
    FPressed: Boolean;
    function PointToValue(X, Y: Single): Single;
  public
    constructor Create(AOwner: TComponent); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    property IsPressed: Boolean read FPressed;
  published
    property Action;
    property Align;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

  TMouseDownAction = (mdaGoto, mdaNone);

{ TCustomTrack }

  TCustomTrack = class(TStyledControl, IValueRange)
  private
    FValueRange: TValueRange;
    FDefaultValueRange: TBaseValueRange;
    FThumb: TThumb;
    FMouseDownAction: TMouseDownAction;
    function GetIsTracking: Boolean;
    procedure SetMax(const Value: Single);
    procedure SetMin(const Value: Single);
    procedure SetValue(Value: Single);
    procedure SetFrequency(const Value: Single);
    procedure SetViewportSize(const Value: Single);
    function GetFrequency: Single;
    function GetMax: Single;
    function GetMin: Single;
    function GetValue: Single;
    function GetViewportSize: Single;
    function GetValueRange: TCustomValueRange;
    procedure SetValueRange(const AValue: TCustomValueRange);
    procedure SetValueRange_(const Value: TValueRange);
    function DefStored: boolean;
    procedure SetNewValue(const LValue: Single);
    procedure UpdateHighlight;
    function FrequencyStored: Boolean;
    function MaxStored: Boolean;
    function MinStored: Boolean;
    function ValueStored: Boolean;
    function ViewportSizeStored: Boolean;
    procedure ObserversValueUpdate;
  protected
    FOnChange, FOnTracking: TNotifyEvent;
    FIgnoreViewportSize: Boolean;
    FOrientation: TOrientation;
    FTracking: Boolean;
    FTrack: TControl;
    FTrackHighlight: TControl;
    FThumbSize: Single;
    FMinThumbSize: Single;
    property Thumb: TThumb read FThumb;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    function CanObserve(const ID: Integer): Boolean; override;
    procedure SetOrientation(const Value: TOrientation); virtual;
    function GetThumbRect(Value: single): TRectF; overload; virtual;
    function GetThumbRect: TRectF; overload;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DoMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single; LValue: Single); virtual;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure AdjustSize; override;
    procedure DoThumbClick(Sender: TObject); virtual;
    procedure DoThumbDblClick(Sender: TObject); virtual;
    function GetThumbSize(var IgnoreViewportSize: boolean): integer; virtual;
    procedure DoRealign; override;
    property IsTracking: Boolean read GetIsTracking;
    function GetActionLinkClass: TActionLinkClass; override;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    procedure Loaded; override;
    procedure DoChanged; virtual;
    procedure DoTracking; virtual;
    function GetDefaultSize: TSizeF; override;
    function CreateValueRangeTrack : TValueRange; virtual;
    property MouseDownAction: TMouseDownAction read FMouseDownAction write FMouseDownAction;
    property DefaultValueRange: TBaseValueRange read FDefaultValueRange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;

    property ValueRange: TValueRange read FValueRange write SetValueRange_ stored ValueStored;
    property Min: Single read GetMin write SetMin stored MinStored nodefault;
    property Max: Single read GetMax write SetMax stored MaxStored nodefault;
    property Frequency: Single read GetFrequency write SetFrequency stored FrequencyStored nodefault;
    property Value: Single read GetValue write SetValue stored ValueStored nodefault;
    property ViewportSize: Single read GetViewportSize write SetViewportSize stored ViewportSizeStored nodefault;

    property Orientation: TOrientation read FOrientation write SetOrientation;
    property Tracking: Boolean read FTracking write FTracking default True;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnTracking: TNotifyEvent read FOnTracking write FOnTracking;
  end;

{ TTrack }

  TTrack = class(TCustomTrack)
  published
    property Action;
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Frequency;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Max;
    property Min;
    property Opacity;
    property Orientation;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property Tracking;
    property Value;
    property ViewportSize;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    property OnChange;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TTrackBar }

  TTrackBar = class(TCustomTrack)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Action;
    property Align;
    property Anchors;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableFocusEffect;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Frequency;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Max;
    property Min;
    property Orientation;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property Tracking;
    property Value;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    property OnChange;
    property OnTracking;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TBitmapTrackBar }

  TBitmapTrackBar = class(TTrackBar)
  protected
    FBitmap: TBitmap;
    FBackground: TShape;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure DoRealign; override;
    function GetDefaultStyleLookupName: string; override;
    procedure UpdateBitmap;
    procedure FillBitmap; virtual;
    procedure SetOrientation(const Value: TOrientation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TSwitch }

  TSwitch = class(TCustomTrack, IIsChecked)
  private
    FBitmap, FMaskBitmap, FTextBitmap: TBitmap;
    FOnObject, FOffObject: TControl;
    FOnText, FOffText: TControl;
    FTextMask: TControl;
    FOnBrush, FOffBrush: TBrush;
    FBackground: TShape;
    FOnSwitch: TNotifyEvent;
    FIsChecked: Boolean;
    FDownOffset: TPointF;
    FDownPoint: TPointF;
    FMoved: Boolean;
    FDeadZone: Single;
    FDeadZoneOffset: Single;
    FClickAnimation: TFloatAnimation;
    FInClick: Boolean;
    procedure UpdateBitmap;
    procedure FillBitmap; virtual;
    procedure SetIsChecked(const Value: Boolean);
    function GetIsChecked: boolean;
    function IsCheckedStored: boolean;
    function IsCheckedByValue: boolean;
    procedure AnimateTo(Checked: Boolean);
    procedure OnAnimationEnd(Sender: TObject);
    function  PointToValue(X, Y: Single): Single;
  protected
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure DoRealign; override;
    procedure DoSwitch; virtual;
    procedure SetOrientation(const Value: TOrientation); override;
    function GetActionLinkClass: TActionLinkClass; override;
    function GetThumbRect(Value: single): TRectF; override;
    procedure Click; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DoMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single; LValue:Single); override;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Action;
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default True;
    property IsChecked: Boolean read GetIsChecked write SetIsChecked stored IsCheckedStored;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property OnApplyStyleLookup;
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
    property OnSwitch: TNotifyEvent read FOnSwitch write FOnSwitch;
  end;

{ TScrollBar }

  TScrollBar = class(TStyledControl)
  private
    FValueRange: TValueRange;
    FTrackChanging: boolean;
    FOnChange: TNotifyEvent;
    FOrientation: TOrientation;
    FTrack: TCustomTrack;
    FMinButton: TCustomButton;
    FMaxButton: TCustomButton;
    FSmallChange: Single;
    FDefaultValueRange: TBaseValueRange;
    procedure SetMax(const Value: Single);
    procedure SetMin(const Value: Single);
    procedure SetValue(const Value: Single);
    procedure SetViewportSize(const Value: Single);
    function GetMax: Single;
    function GetMin: Single;
    function GetValue: Single;
    function GetViewportSize: Single;
    function GetValueRange: TValueRange;
    procedure SetValueRange(const Value: TValueRange);
    procedure SetOrientation(const Value: TOrientation);
    function DefStored: boolean;
    procedure TrackChangedProc(Sender: TObject);
    procedure SetSmallChange(const Value: Single);
    procedure FreeTrack;
    function GetSmallChange: Single;
    function SmallChangeStored: Boolean;
    procedure DoSmallChange(N: integer);
    function MaxStored: Boolean;
    function MinStored: Boolean;
    function ValueStored: Boolean;
    function ViewportSizeStored: Boolean;
  protected
    procedure DoMinButtonClick(Sender: TObject);
    procedure DoMaxButtonClick(Sender: TObject);
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function CanObserve(const ID: Integer): Boolean; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    function GetActionLinkClass: TActionLinkClass; override;
    procedure DoActionClientChanged; override;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    property Track: TCustomTrack read FTrack;
    property MinButton: TCustomButton read FMinButton;
    property MaxButton: TCustomButton read FMaxButton;
    procedure DoChanged; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    function GetDefaultSize: TSizeF; override;
    procedure Loaded; override;
    property DefaultValueRange: TBaseValueRange read FDefaultValueRange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    property ValueRange: TValueRange read GetValueRange write SetValueRange;
  published
    property Action;
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Max: Single read GetMax write SetMax stored MaxStored nodefault;
    property Min: Single read GetMin write SetMin stored MinStored nodefault;
    property Value: Single read GetValue write SetValue stored ValueStored nodefault;
    property ViewportSize: Single read GetViewportSize write SetViewportSize stored ViewportSizeStored nodefault;
    property SmallChange: Single read GetSmallChange write SetSmallChange stored SmallChangeStored nodefault;
    property Orientation: TOrientation read FOrientation write SetOrientation;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    {events}
    property OnApplyStyleLookup;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TSmallScrollBar }

  TSmallScrollBar = class(TScrollBar)
  protected
    procedure ApplyStyle; override;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TAniIndicator }

  TAniIndicatorStyle = (aiLinear, aiCircular);

  TAniIndicator = class(TStyledControl)
  private
    FLayout: TControl;
    FAni: TAnimation;
    FStyle: TAniIndicatorStyle;
    FFill: TBrush;
    procedure SetStyle(const Value: TAniIndicatorStyle);
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure SetEnabled(const Value: Boolean); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ApplyStyleLookup; override;
  published
    property Action;
    property Align;
    property Anchors;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default False;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property StyleLookup;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Style: TAniIndicatorStyle read FStyle write SetStyle default TAniIndicatorStyle.aiLinear;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TArcDial }

  TArcDial = class(TStyledControl, IValueRange)
  private
    FValueRange: TValueRange;
    FValueChanged: boolean;
    FPressing: Boolean;
    FOnChange: TNotifyEvent;
    FSaveValue: Single;
    FTracking: Boolean;
    FShowValue: Boolean;
    FOldValue: Single;
    FDefaultValueRange: TBaseValueRange;
    procedure SetValue(const Value: Single);
    procedure SetShowValue(const Value: Boolean);
    function DefStored: boolean;
    function GetValueRange: TCustomValueRange;
    procedure SetValueRange(const AValue: TCustomValueRange);
    procedure SetValueRange_(const Value: TValueRange);
    function GetValue: Single;
    function GetFrequency: Single;
    procedure SetFrequency(const Value: Single);
    function FrequencyStored: Boolean;
    function ValueStored: Boolean;
  protected
    function Tick: TControl;
    function Text: TText;
    procedure ApplyStyle; override;
    function CanObserve(const ID: Integer): Boolean; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure Loaded; override;
    procedure Resize; override;

    function GetActionLinkClass: TActionLinkClass; override;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    procedure BeforeChangeProc(Sender: TObject);
    procedure ValueRangeChangeProc(Sender: TObject);
    procedure AfterChangedProc(Sender: TObject); virtual;
    function GetDefaultSize: TSizeF; override;
    property DefaultValueRange: TBaseValueRange read FDefaultValueRange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    property ValueRange: TValueRange read FValueRange write SetValueRange_;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
  published
    { props }
    property Action;
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property ShowValue: Boolean read FShowValue write SetShowValue default False;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property Tracking: Boolean read FTracking write FTracking default True;
    property Value: Single read GetValue write SetValue stored ValueStored nodefault;
    property Frequency: Single read GetFrequency write SetFrequency stored FrequencyStored nodefault;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TExpanderButton }

  TExpanderButton = class(TCustomButton)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Action;
    property Align;
    property Anchors;
    property AutoTranslate default True;
    property CanFocus default False;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableFocusEffect;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Font;
    property StyledSettings;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    { triggers }
    property StaysPressed default False;
    property IsPressed default False;

    property Locked default False;
    property Padding;
    property ModalResult default mrNone;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RepeatClick default False;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property Text;
    property TextAlign default TTextAlign.taCenter;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property WordWrap default False;

    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

  TExpander = class(TTextControl)
  private
    FShowCheck: Boolean;
    FIsChecked: Boolean;
    FOnCheckChange: TNotifyEvent;
    procedure DoButtonClick(Sender: TObject);
    procedure SetIsChecked(const Value: Boolean);
    procedure SetShowCheck(const Value: Boolean);
  protected
    FIsExpanded: Boolean;
    FContent: TContent;
    FButton: TCustomButton;
    FCheck: TCheckBox;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure DoRealign; override;
    procedure SetIsExpanded(const Value: Boolean); virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadContentSize(Reader: TReader);
    procedure WriteContentSize(Writer: TWriter);
    procedure DoCheckChange(Sender: TObject);
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure Loaded; override;
    procedure AddToTabList(const AObject: TFmxObject); override;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure GetTabOrderList(const List: TInterfaceList; AChildren: Boolean); override;
  published
    property Action;
    property Align;
    property Anchors;
    property AutoTranslate default True;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Font;
    property StyledSettings;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    {trigers}
    property IsChecked: Boolean read FIsChecked write SetIsChecked default True;
    property IsExpanded: Boolean read FIsExpanded write SetIsExpanded default True;

    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property ShowCheck: Boolean read FShowCheck write SetShowCheck;
    property StyleLookup;
    property Text;
    property TextAlign;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property TabOrder;

    {events}
    property OnApplyStyleLookup;
    property OnCheckChange: TNotifyEvent read FOnCheckChange write FOnCheckChange;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

  TImageControl = class(TStyledControl)
  private
    FImage: TImage;
    FOnChange: TNotifyEvent;
    FBitmap: TBitmap;
    FEnableOpenDialog: Boolean;
    procedure SetBitmap(const Value: TBitmap);
  protected
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    function CanObserve(const ID: Integer): Boolean; override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure Click; override;
    procedure DragOver(const Data: TDragObject; const Point: TPointF; var Accept: Boolean); override;
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); override;
    procedure DoBitmapChanged(Sender: TObject); virtual;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Action;
    property Align;
    property Anchors;
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableFocusEffect;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property EnableOpenDialog: Boolean read FEnableOpenDialog write FEnableOpenDialog default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

{ TPathLabel }

  TPathLabel = class(TStyledControl)
  private
    FPath: TCustomPath;
    function GetWrapMode: TPathWrapMode;
    procedure SetWrapMode(const Value: TPathWrapMode);
    function GetPathData: TPathData;
    procedure SetPathData(const Value: TPathData);
  protected
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Action;
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property Data: TPathData read GetPathData write SetPathData;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HitTest default False;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property WrapMode: TPathWrapMode read GetWrapMode write SetWrapMode
      default TPathWrapMode.pwStretch;

    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
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

implementation

uses
  System.RTLConsts, System.Math, System.TypInfo, System.SysUtils, System.Variants,
  FMX.Consts, FMX.Platform, FMX.Dialogs;

type
  THackFMXActionLink = class (TActionLink)

  end;

  TOpenValueRange = class (TCustomValueRange)

  end;

{ TPanel }

constructor TPanel.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TPanel.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('TabOrder', IgnoreIntegerValue, nil, False);
end;

function TPanel.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(120, 120);
end;

{ TCalloutPanel }

constructor TCalloutPanel.Create(AOwner: TComponent);
begin
  inherited;
  FCalloutWidth := 23;
  FCalloutLength := 11;
  UpdateMargins;
end;

procedure TCalloutPanel.ApplyStyle;
var
  Back: TFmxObject;
begin
  inherited;
  Back := FindStyleResource('Background');
  if not Assigned(Back) and (ResourceControl is TCalloutRectangle) then
    Back := ResourceControl;
  if Assigned(Back) and (Back is TCalloutRectangle) then
  begin
    TCalloutRectangle(Back).CalloutWidth := FCalloutWidth;
    TCalloutRectangle(Back).CalloutLength := FCalloutLength;
    TCalloutRectangle(Back).CalloutPosition := FCalloutPosition;
    TCalloutRectangle(Back).CalloutOffset := FCalloutOffset;
  end;
end;

procedure TCalloutPanel.SetCalloutLength(const Value: Single);
begin
  if FCalloutLength <> Value then
  begin
    FCalloutLength := Value;
    UpdateMargins;
    ApplyStyle;
  end;
end;

procedure TCalloutPanel.SetCalloutPosition(const Value: TCalloutPosition);
begin
  if FCalloutPosition <> Value then
  begin
    FCalloutPosition := Value;
    ApplyStyle;
  end;
end;

procedure TCalloutPanel.SetCalloutWidth(const Value: Single);
begin
  if FCalloutWidth <> Value then
  begin
    FCalloutWidth := Value;
    ApplyStyle;
  end;
end;

procedure TCalloutPanel.UpdateMargins;
begin
  case FCalloutPosition of
    TCalloutPosition.cpTop:   Padding.Top := FCalloutLength;
    TCalloutPosition.cpLeft:  Padding.Left := FCalloutLength;
    TCalloutPosition.cpBottom:Padding.Bottom := FCalloutLength;
    TCalloutPosition.cpRight: Padding.Right := FCalloutLength;
  end;
end;

procedure TCalloutPanel.SetCalloutOffset(const Value: Single);
begin
  if FCalloutOffset <> Value then
  begin
    FCalloutOffset := Value;
    ApplyStyle;
  end;
end;

{ TStatusBar }

constructor TStatusBar.Create(AOwner: TComponent);
begin
  inherited;
  FShowSizeGrip := True;
  Align := TAlignLayout.alBottom;
  SetAcceptsControls(False);
end;

procedure TStatusBar.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('TabOrder', IgnoreIntegerValue, nil, False);
end;

function TStatusBar.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(120, 22);
end;

procedure TStatusBar.ApplyStyle;
var
  sizeGrip: TFmxObject;
begin
  inherited;
  sizeGrip := FindStyleResource('sizegrip');
  if Assigned(sizeGrip) and (sizeGrip is TControl) then
  begin
    TControl(sizeGrip).Visible := FShowSizeGrip;
    if not(csDesigning in ComponentState) then
    begin
      TControl(sizeGrip).Locked := False;
      TControl(sizeGrip).HitTest := True;
    end;
  end;
end;

procedure TStatusBar.SetShowSizeGrip(const Value: Boolean);
begin
  if FShowSizeGrip <> Value then
  begin
    FShowSizeGrip := Value;
    ApplyStyleLookup;
  end;
end;

{ TToolBar }

constructor TToolBar.Create(AOwner: TComponent);
begin
  inherited;
  Align := TAlignLayout.alTop;
end;

procedure TToolBar.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('TabOrder', IgnoreIntegerValue, nil, False);
end;

function TToolBar.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(120, 40);
end;

{ TLabel }

constructor TLabel.Create(AOwner: TComponent);
var
  DefaultValueService: IInterface;
  TrimmingDefault: TValue;
begin
  inherited;
  AutoTranslate := True;

  if (csDesigning in ComponentState)
    and SupportsPlatformService(IFMXDefaultPropertyValueService, DefaultValueService) then
  begin
    TrimmingDefault := IFMXDefaultPropertyValueService(DefaultValueService).GetDefaultPropertyValue(Self.ClassName, 'trimming');
    if not TrimmingDefault.IsEmpty then
      Trimming := TrimmingDefault.AsType<TTextTrimming>;
  end;

  WordWrap := True;
  HitTest := False;
  SetAcceptsControls(False);
end;

procedure TLabel.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('TabOrder', IgnoreIntegerValue, nil, False);
end;

function TLabel.GetDefaultSize: TSizeF;
var
  DefMetricsSrv: IFMXDefaultMetricsService;
begin
  if SupportsPlatformService(IFMXDefaultMetricsService, IInterface(DefMetricsSrv)) and DefMetricsSrv.SupportsDefaultSize(ckLabel) then
    Result := TSizeF.Create(DefMetricsSrv.GetDefaultSize(ckLabel).Width, DefMetricsSrv.GetDefaultSize(ckLabel).Height)
  else
    Result := TSizeF.Create(120, 17);
end;

procedure TLabel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if Button = TMouseButton.mbLeft then
  begin
    FIsPressed := True;
    StartTriggerAnimation(Self, 'IsPressed');
    ApplyTriggerEffect(Self, 'IsPressed');
  end;
end;

procedure TLabel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if (Button = TMouseButton.mbLeft) and (FIsPressed) then
  begin
    FIsPressed := False;
    StartTriggerAnimation(Self, 'IsPressed');
    ApplyTriggerEffect(Self, 'IsPressed');
  end;
end;

procedure TLabel.Resize;
begin
  inherited;
  if FAutoSize then
    FitSize;
end;

procedure TLabel.FitSize;
begin
  if not (csLoading in ComponentState) then
    WordWrap := False;
  ApplyStyle;
end;

procedure TLabel.ApplyStyle;
var
  TextObj: TText;
  S: TAlignLayout;
begin
  inherited;
  if AutoSize and (Text <> '') then
  begin
    if Assigned(TextObject) and (TextObject is TText) then
    begin
      TextObj := TText(TextObject);
      S := TextObj.Align;
      TextObj.Align := TAlignLayout.alNone;
      TextObj.AutoSize := True;
      Width := TextObj.Width;
      Height := TextObj.Height;
      TextObj.AutoSize := False;
      TextObj.Align := S;
    end;
  end;
end;

procedure TLabel.SetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    if FAutoSize then
      FitSize;
  end;
end;

procedure TLabel.SetText(const Value: string);
begin
  if Value <> Text then
  begin
    inherited;
    if FAutoSize then
      ApplyStyle;
  end
  else
    inherited;
end;

{ TCustomButton }

constructor TCustomButton.Create(AOwner: TComponent);
var
  DefaultValueService: IInterface;
  TrimmingDefault: TValue;
begin
  inherited Create(AOwner);
  AutoTranslate := True;
  WordWrap := False;
  TextAlign := TTextAlign.taCenter;
  FAnchorMove := True;
  FAnchorMove := False;

  if (csDesigning in ComponentState)
    and SupportsPlatformService(IFMXDefaultPropertyValueService, DefaultValueService) then
  begin
    TrimmingDefault := IFMXDefaultPropertyValueService(DefaultValueService).GetDefaultPropertyValue(Self.ClassName, 'trimming');
    if not TrimmingDefault.IsEmpty then
      Trimming := TrimmingDefault.AsType<TTextTrimming>;
  end;

  AutoCapture := True;
  CanFocus := True;
  SetAcceptsControls(False);
end;

procedure TCustomButton.ApplyTriggers;
var
  SaveIsMouseOver: Boolean;
begin
  SaveIsMouseOver := IsMouseOver;
  if IsPressed and StaysPressed then
    FIsMouseOver := True;
  StartTriggerAnimation(Self, 'IsPressed');
  ApplyTriggerEffect(Self, 'IsPressed');
  FIsMouseOver := SaveIsMouseOver;
end;

procedure TCustomButton.ApplyStyle;
begin
  inherited;
  if IsPressed then
    ApplyTriggers;
end;

function TCustomButton.GetData: TValue;
begin
  Result := TValue.From<TNotifyEvent>(OnClick);
end;

function TCustomButton.GetDefaultSize: TSizeF;
var
  DefMetricsSrv: IFMXDefaultMetricsService;
begin
  if SupportsPlatformService(IFMXDefaultMetricsService, IInterface(DefMetricsSrv)) and DefMetricsSrv.SupportsDefaultSize(ckButton) then
    Result := TSizeF.Create(DefMetricsSrv.GetDefaultSize(ckButton).Width, DefMetricsSrv.GetDefaultSize(ckButton).Height)
  else
    Result := TSizeF.Create(80, 22);
end;

function TCustomButton.IsPressedStored: boolean;
begin
  Result := True;
end;

procedure TCustomButton.SetData(const Value: TValue);
begin
  if Value.IsType<TNotifyEvent> then
    OnClick := Value.AsType<TNotifyEvent>();
end;

procedure TCustomButton.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
begin
  inherited;
  if ((Key = vkReturn) or (KeyChar = Chr(vkSpace))) and (Shift = []) then
  begin
    Click;
  end;
end;

procedure TCustomButton.DoRepeatTimer(Sender: TObject);
begin
  Click;
end;

procedure TCustomButton.DoRepeatDelayTimer(Sender: TObject);
begin
  FRepeatTimer.OnTimer := DoRepeatTimer;
  FRepeatTimer.Interval := 100;
end;

procedure TCustomButton.DblClick;
begin
  inherited;
  Click;
end;

procedure TCustomButton.Click;
var
  O: TComponent;
begin
  if Assigned(Self) and (ModalResult <> mrNone) then
  begin
    O := Scene.GetObject;
    while Assigned(O) do
    begin
      if (O is TCommonCustomForm) then
      begin
        TCommonCustomForm(O).ModalResult := FModalResult;
        Break;
      end;
      O := O.Owner;
    end;
  end;
  inherited;
end;

procedure TCustomButton.ToggleStaysPressed;
begin
  IsPressed := not FIsPressed;
end;

procedure TCustomButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if Button = TMouseButton.mbLeft then
  begin
    FPressing := True;
    if FStaysPressed then
      ToggleStaysPressed
    else begin
      FIsPressed := True;
      if FRepeat then
      begin
        if not Assigned(FRepeatTimer) then
        begin
          FRepeatTimer := TTimer.Create(Self);
          FRepeatTimer.Interval := 500;
        end;
        FRepeatTimer.OnTimer := DoRepeatDelayTimer;
        FRepeatTimer.Enabled := True;
      end;
      ApplyTriggers;
    end;
  end;
end;

procedure TCustomButton.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if (ssLeft in Shift) and FPressing then
  begin
    if FIsPressed <> LocalRect.Contains(PointF(X, Y)) then
    begin
      if not FStaysPressed then
      begin
        FIsPressed := LocalRect.Contains(PointF(X, Y));
        ApplyTriggers;
      end;
    end;
  end;
end;

procedure TCustomButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if FPressing then
  begin
    if Assigned(FRepeatTimer) then
      FRepeatTimer.Enabled := False;
    FPressing := False;
    if not FStaysPressed then
    begin
      FIsPressed := False;
      ApplyTriggers;
    end;
  end;
  inherited;
end;

procedure TCustomButton.SetIsPressed(const Value: Boolean);
begin
  if FStaysPressed then
  begin
    if Value <> FIsPressed then
    begin
      FIsPressed := Value;
      ApplyTriggers;
    end;
  end;
end;

procedure TCustomButton.SetStaysPressed(const Value: Boolean);
begin
  if not Value and FIsPressed then
    SetIsPressed(False);
  if FStaysPressed <> Value then
    FStaysPressed := Value;
end;

{ TButton }

procedure TButton.DialogKey(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Default and (Key = vkReturn) then
  begin
    Click;
    Key := 0;
  end;
  if Cancel and (Key = vkEscape) then
  begin
    Click;
    Key := 0;
  end;
end;

{ TSpeedButtonGroupMessage }

constructor TSpeedButtonGroupMessage.Create(const AGroupName: string);
begin
  inherited Create;
  FGroupName := AGroupName;
end;

{ TSpeedButton }

constructor TSpeedButton.Create(AOwner: TComponent);
begin
  inherited;
  CanFocus := False;
  TMessageManager.DefaultManager.SubscribeToMessage(TSpeedButtonGroupMessage, GroupMessageCall);
end;

destructor TSpeedButton.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TSpeedButtonGroupMessage, GroupMessageCall);
  inherited;
end;

function TSpeedButton.GetGroupName: string;
begin
  Result := FGroupName;
end;

procedure TSpeedButton.GroupMessageCall(const Sender: TObject; const M: TMessage);
begin
  if (GroupName <> '') and SameText(TSpeedButtonGroupMessage(M).GroupName, GroupName) and (Sender <> Self) then
    IsPressed := False;
end;

function TSpeedButton.GroupNameStored: Boolean;
begin
  Result := not (ActionClient and
                 (ActionLink is TActionLink) and
                 (THackFMXActionLink(ActionLink).IsGroupIndexLinked) and
                 (Action is TContainedAction));
end;

procedure TSpeedButton.SetGroupName(const Value: string);
var
  I, Code: Integer;
begin
  if FGroupName <> Value then
  begin
    if not GroupNameStored then
    begin
      if Value = '' then
      begin
        I := 0;
        Code := 0;
      end
      else
        Val(Value, I, Code);
      if Code = 0 then
      begin
        FGroupName := IntToStr(I);
        if TContainedAction(Action).GroupIndex <> I then
          TContainedAction(Action).GroupIndex := I;
      end
      else
        FGroupName := Value;
    end
    else
      FGroupName := Value;
    if FGroupName <> '' then
      StaysPressed := True;
  end;
end;

function TSpeedButton.GetIsChecked: boolean;
begin
  Result := IsPressed;
end;

function TSpeedButton.IsCheckedStored: boolean;
begin
  Result := IsPressedStored;
end;

function TSpeedButton.IsPressedStored: boolean;
begin
  Result := not (ActionClient and
                 (ActionLink is TActionLink) and
                 (THackFMXActionLink(ActionLink).IsCheckedLinked) and
                 (Action is TContainedAction));
end;

procedure TSpeedButton.SetIsChecked(const Value: boolean);
begin
  IsPressed := Value;
end;

procedure TSpeedButton.SetIsPressed(const Value: Boolean);
var
  M: TSpeedButtonGroupMessage;
begin
  if FStaysPressed then
  begin
    if FIsPressed <> Value then
    begin
      if not IsPressedStored then
      begin
        FIsPressed := Value;
        TContainedAction(Action).Checked := FIsPressed;
      end
      else
      begin
        // allows check/uncheck in design-mode
        if (csDesigning in ComponentState) and FIsPressed then
          FIsPressed := Value
        else
        begin
          FIsPressed := Value;
          { all group uncheck}
          if Value then
          begin
            M := TSpeedButtonGroupMessage.Create(GroupName);
            TMessageManager.DefaultManager.SendMessage(Self, M, True);
          end;
        end;
      end;
      // visual feedback
      ApplyTriggers;
    end;
  end;
end;

procedure TSpeedButton.ToggleStaysPressed;
begin
  if GroupName <> '' then
    IsPressed := True
  else
    IsPressed := not FIsPressed;
end;

{ TCustomCornerButton }

constructor TCustomCornerButton.Create(AOwner: TComponent);
begin
  inherited;
  FCorners := AllCorners;
  FXRadius := 3;
  FYRadius := 3;
  FSides := AllSides;
end;

destructor TCustomCornerButton.Destroy;
begin
  inherited;
end;

procedure TCustomCornerButton.ApplyStyle;
var
  Background: TFmxObject;
begin
  inherited;
  Background := FindStyleResource('Background');
  if (Background <> nil) and (Background is TRectangle) then
  begin
    TRectangle(Background).CornerType := FCornerType;
    TRectangle(Background).Corners := FCorners;
    TRectangle(Background).XRadius := XRadius;
    TRectangle(Background).YRadius := YRadius;
    TRectangle(Background).Sides := FSides;
  end;
  Background := FindStyleResource('SecondBackground');
  if (Background <> nil) and (Background is TRectangle) then
  begin
    TRectangle(Background).CornerType := FCornerType;
    TRectangle(Background).Corners := FCorners;
    TRectangle(Background).XRadius := XRadius;
    TRectangle(Background).YRadius := YRadius;
    TRectangle(Background).Sides := FSides;
  end;
end;

function TCustomCornerButton.IsCornersStored: Boolean;
begin
  Result := FCorners <> AllCorners;
end;

function TCustomCornerButton.IsSidesStored: Boolean;
begin
  Result := FSides * AllSides <> [];
end;

procedure TCustomCornerButton.SetCorners(const Value: TCorners);
begin
  if FCorners <> Value then
  begin
    FCorners := Value;
    ApplyStyle;
  end;
end;

procedure TCustomCornerButton.SetCornerType(const Value: TCornerType);
begin
  if FCornerType <> Value then
  begin
    FCornerType := Value;
    ApplyStyle;
  end;
end;

procedure TCustomCornerButton.SetXRadius(const Value: Single);
begin
  if FXRadius <> Value then
  begin
    FXRadius := Value;
    ApplyStyle;
  end;
end;

procedure TCustomCornerButton.SetYRadius(const Value: Single);
begin
  if FYRadius <> Value then
  begin
    FYRadius := Value;
    ApplyStyle;
  end;
end;

procedure TCustomCornerButton.SetSides(const Value: TSides);
begin
  if FSides <> Value then
  begin
    FSides := Value;
    ApplyStyle;
  end;
end;

{ TCheckBox }

constructor TCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  AutoTranslate := True;
  AutoCapture := True;
  CanFocus := True;
  TextAlign := TTextAlign.taLeading;
  MinClipWidth := 16;
  MinClipHeight := 16;
  SetAcceptsControls(False);
end;

function TCheckBox.GetData: TValue;
begin
  Result := IsChecked;
end;

function TCheckBox.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(120, 19);
end;

procedure TCheckBox.SetData(const Value: TValue);
var
  S: string;
  B: Boolean;
begin
  if Value.IsType<Boolean> then
    IsChecked := Value.AsType<Boolean>
  else if Value.IsType<TNotifyEvent> then
    OnChange := Value.AsType<TNotifyEvent>()
  else if Value.IsType<string> then
  begin
    S := Value.AsType<string>;
    if (S <> '') and TryStrToBool(S, B) then
      IsChecked := B
    else
      IsChecked := False;
  end
  else
    IsChecked := False;
end;

procedure TCheckBox.DoExit;
begin
  inherited;
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    TLinkObservers.EditLinkUpdate(Observers);
  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueUpdate(Observers);
end;

procedure TCheckBox.ActionChange(Sender: TBasicAction; CheckDefaults: Boolean);
begin
  inherited;
  if Sender is TCustomAction then
  begin
    if (not CheckDefaults) or (not IsChecked) then
      IsChecked := TCustomAction(Sender).Checked;
  end;
end;

procedure TCheckBox.ApplyStyle;
begin
  inherited;
  StartTriggerAnimation(Self, 'IsChecked');
end;

procedure TCheckBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if Button = TMouseButton.mbLeft then
  begin
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      if TLinkObservers.EditLinkIsReadOnly(Observers) then
        Exit;
    FPressing := True;
    FIsPressed := True;
    StartTriggerAnimation(Self, 'IsPressed');
  end;
end;

procedure TCheckBox.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if (ssLeft in Shift) and (FPressing) then
  begin
    if FIsPressed <> LocalRect.Contains(PointF(X, Y)) then
    begin
      FIsPressed := LocalRect.Contains(PointF(X, Y));
      StartTriggerAnimation(Self, 'IsPressed');
    end;
  end;
end;

procedure TCheckBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if FPressing then
  begin
    inherited;
    FPressing := False;
    FIsPressed := False;

    if LocalRect.Contains(PointF(X, Y)) then
    begin
      if Observers.IsObserving(TObserverMapping.EditLinkID) then
      begin
        if TLinkObservers.EditLinkEdit(Observers) then
          TLinkObservers.EditLinkModified(Observers)
        else
        begin
          TLinkObservers.EditLinkReset(Observers);
          Exit;
        end;
      end;
      IsChecked := not IsChecked;
      if Observers.IsObserving(TObserverMapping.EditLinkID) then
        TLinkObservers.EditLinkTrackUpdate(Observers);
      if Observers.IsObserving(TObserverMapping.ControlValueID) then
      begin
        TLinkObservers.ControlValueModified(Observers);
        TLinkObservers.ControlValueTrackUpdate(Observers);
      end;
    end
  end;
end;

function TCheckBox.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.EditLinkID then
    Result := True;
  if ID = TObserverMapping.ControlValueID then
    Result := True;
end;

procedure TCheckBox.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
begin
  inherited;
  if (Key = vkReturn) or (KeyChar = Chr(vkSpace)) then
  begin
    Click; // Emulate mouse click to perform Action.OnExecute
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
    begin
      if TLinkObservers.EditLinkIsReadOnly(Observers) then
        Exit;
      if TLinkObservers.EditLinkEdit(Observers) then
        TLinkObservers.EditLinkModified(Observers)
      else
      begin
        TLinkObservers.EditLinkReset(Observers);
        Exit;
      end;
    end;
    IsChecked := not IsChecked;
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      TLinkObservers.EditLinkTrackUpdate(Observers);
    if Observers.IsObserving(TObserverMapping.ControlValueID) then
    begin
      TLinkObservers.ControlValueModified(Observers);
      TLinkObservers.ControlValueTrackUpdate(Observers);
    end;
  end;
end;

function TCheckBox.GetIsChecked: boolean;
begin
  Result := FIsChecked;
end;

function TCheckBox.IsCheckedStored: boolean;
begin
  Result := not (ActionClient and
                 (ActionLink is TActionLink) and
                 (THackFMXActionLink(ActionLink).IsCheckedLinked) and
                 (Action is TContainedAction));
end;

procedure TCheckBox.SetIsChecked(const Value: Boolean);
var
  Llinked: boolean;
begin
  if FIsChecked <> Value then
  begin
    Llinked := not IsCheckedStored;
    FIsChecked := Value;
    if Llinked then
      TContainedAction(Action).Checked := FIsChecked;
    StartTriggerAnimation(Self, 'IsChecked');
    if Assigned(FOnChange) then
    begin
      FOnChange(Self);
    end;
  end;
end;

{ TRadioButtonGroupMessage }

constructor TRadioButtonGroupMessage.Create(const AGroupName: string);
begin
  inherited Create;
  FGroupName := AGroupName;
end;

{ TRadioButton }

constructor TRadioButton.Create(AOwner: TComponent);
begin
  inherited;
  AutoTranslate := True;
  AutoCapture := True;
  CanFocus := True;
  TextAlign := TTextAlign.taLeading;
  MinClipWidth := 16;
  MinClipHeight := 16;
  SetAcceptsControls(False);
  TMessageManager.DefaultManager.SubscribeToMessage(TRadioButtonGroupMessage, GroupMessageCall);
end;

destructor TRadioButton.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TRadioButtonGroupMessage, GroupMessageCall);
  inherited;
end;

function TRadioButton.GetData: TValue;
begin
  Result := IsChecked;
end;

function TRadioButton.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(120, 19);
end;

procedure TRadioButton.SetData(const Value: TValue);
begin
  if Value.IsType<TNotifyEvent> then
    OnChange := Value.AsType<TNotifyEvent>()
  else if Value.IsType<Boolean> then
    IsChecked := Value.AsType<Boolean>
  else
    IsChecked := False;
end;

procedure TRadioButton.ActionChange(Sender: TBasicAction;
  CheckDefaults: Boolean);
begin
  inherited;
  if Sender is TCustomAction then
  begin
    if (not CheckDefaults) or (not IsChecked) then
      IsChecked := TCustomAction(Sender).Checked;
    if (not CheckDefaults) or (GroupName = '') or (GroupName = '0') then
      GroupName := IntToStr(TCustomAction(Sender).GroupIndex);
  end;
end;

procedure TRadioButton.ApplyStyle;
begin
  inherited;
  if IsChecked then
    StartTriggerAnimation(Self, 'IsChecked');
end;

procedure TRadioButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if Button = TMouseButton.mbLeft then
  begin
    FPressing := True;
    FIsPressed := True;
    StartTriggerAnimation(Self, 'IsPressed');
  end;
end;

procedure TRadioButton.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if (ssLeft in Shift) and (FPressing) then
  begin
    if FIsPressed <> LocalRect.Contains(PointF(X, Y)) then
    begin
      FIsPressed := LocalRect.Contains(PointF(X, Y));
      StartTriggerAnimation(Self, 'IsPressed');
    end;
  end;
end;

procedure TRadioButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if FPressing then
  begin
    FPressing := False;
    FIsPressed := False;
    if not IsChecked then
    begin
      if LocalRect.Contains(PointF(X, Y)) then
      begin
        IsChecked := not IsChecked;
      end
    end;
  end;
end;

procedure TRadioButton.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
begin
  inherited;
  if ((Key = vkReturn) or (KeyChar = Chr(vkSpace))) and (not IsChecked) then
  begin
    Click; // Emulate mouse click to perform Action.OnExecute
    IsChecked := not IsChecked;
  end;
end;

function TRadioButton.GetIsChecked: boolean;
begin
  Result := FIsChecked;
end;

function TRadioButton.IsCheckedStored: boolean;
begin
  Result := not (ActionClient and
                 (ActionLink is TActionLink) and
                 (THackFMXActionLink(ActionLink).IsCheckedLinked) and
                 (Action is TContainedAction));
end;

procedure TRadioButton.SetIsChecked(const Value: Boolean);
var
  M: TRadioButtonGroupMessage;
begin
  if FIsChecked <> Value then
  begin
    if not IsCheckedStored then
    begin
      FIsChecked := Value;
      TContainedAction(Action).Checked := FIsChecked;
    end
    else
    begin
      // allows check/uncheck in design-mode
      if (csDesigning in ComponentState) and FIsChecked then
        FIsChecked := Value
      else
      begin
        FIsChecked := Value;
        if Value then
        begin
          M := TRadioButtonGroupMessage.Create(GroupName);
          TMessageManager.DefaultManager.SendMessage(Self, M, True);
        end;
      end;
    end;
    // visual feedback
    StartTriggerAnimation(Self, 'IsChecked');
    { event }
    if Assigned(FOnChange) then
    begin
      FOnChange(Self);
    end;
  end;
end;

function TRadioButton.GetGroupName: string;
begin
  Result := FGroupName;
end;

procedure TRadioButton.GroupMessageCall(const Sender: TObject; const M: TMessage);
begin
  if SameText(TSpeedButtonGroupMessage(M).GroupName, GroupName) and (Sender <> Self) then
    IsChecked := False;
end;

function TRadioButton.GroupNameStored: boolean;
begin
  Result := not (ActionClient and
                 (ActionLink is TActionLink) and
                 (THackFMXActionLink(ActionLink).IsGroupIndexLinked) and
                 (Action is TContainedAction));
end;

procedure TRadioButton.SetGroupName(const Value: string);
var
  I, Code: Integer;
begin
  if FGroupName <> Value then
  begin
    if not GroupNameStored then
    begin
      if Value = '' then
      begin
        I := 0;
        Code := 0;
      end
      else
        Val(Value, I, Code);
      if Code = 0 then
      begin
        FGroupName := inttostr(I);
        if TContainedAction(Action).GroupIndex <> I then
          TContainedAction(Action).GroupIndex := I;
      end
      else
        FGroupName := Value;
    end
    else
      FGroupName := Value;
  end;
end;

{ TSizeGrip }

constructor TSizeGrip.Create(AOwner: TComponent);
begin
  inherited;
  SetAcceptsControls(False);
end;

procedure TSizeGrip.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('TabOrder', IgnoreIntegerValue, nil, False);
end;

{ TGroupBox }

constructor TGroupBox.Create(AOwner: TComponent);
begin
  inherited;
  AutoTranslate := True;
  CanFocus := False;
  StyledSettings := StyledSettings + [TStyledSetting.ssOther];
end;

procedure TGroupBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('TabOrder', IgnoreIntegerValue, nil, False);
end;

function TGroupBox.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(120, 100);
end;

procedure TGroupBox.ApplyStyle;
begin
  inherited;
end;

{ TSplitter }

constructor TSplitter.Create(AOwner: TComponent);
begin
  inherited;
  FMinSize := 20;
  FShowGrip := True;
  AutoCapture := True;
  Align := TAlignLayout.alLeft;
  Cursor := crHSplit;
  SetAcceptsControls(False);
end;

procedure TSplitter.ApplyStyle;
var
  grip: TFmxObject;
begin
  inherited;
  grip := FindStyleResource('grip');
  if Assigned(grip) and (grip is TControl) then
  begin
    TControl(grip).Visible := FShowGrip;
  end;
end;

procedure TSplitter.Paint;
var
  R: TRectF;
begin
  inherited;
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;
end;

procedure TSplitter.SetAlign(const Value: TAlignLayout);
var
  Thickness: Single;
begin
  Thickness := Min(Width, Height);
  inherited;
  if Align in [TAlignLayout.alTop, TAlignLayout.alBottom] then
    Cursor := crVSplit
  else
    Cursor := crHSplit;
  SetBounds(Position.X, Position.Y, Thickness, Thickness);
end;

function TSplitter.FindObject: TControl;
var
  P: TPointF;
  i: Integer;
  R: TRectF;
begin
  Result := nil;
  P := Position.Point;
  case Align of
    TAlignLayout.alLeft, TAlignLayout.alMostLeft:
      P.X := P.X - 1;
    TAlignLayout.alRight, TAlignLayout.alMostRight:
      P.X := P.X + Width + 1;
    TAlignLayout.alTop:
      P.Y := P.Y - 1;
    TAlignLayout.alBottom:
      P.Y := P.Y + Height + 1;
  else
    Exit;
  end;
  if Assigned(Parent) then
    for i := 0 to Parent.ChildrenCount - 1 do
    begin
      if not(Parent.Children[i] is TControl) then
        Continue;
      if TControl(Parent.Children[i]).Locked then
        Continue;
      if (Align in [TAlignLayout.alLeft, TAlignLayout.alMostLeft, TAlignLayout.alRight, TAlignLayout.alMostRight]) and
        not((TControl(Parent.Children[i]).Align in [TAlignLayout.alLeft, TAlignLayout.alMostLeft, TAlignLayout.alRight, TAlignLayout.alMostRight])) then
        Continue;
      if (Align in [TAlignLayout.alTop, TAlignLayout.alBottom, TAlignLayout.alMostTop, TAlignLayout.alMostBottom]) and
        not((TControl(Parent.Children[i]).Align in [TAlignLayout.alTop, TAlignLayout.alBottom, TAlignLayout.alMostTop, TAlignLayout.alMostBottom])) then
        Continue;

      Result := TControl(Parent.Children[i]);
      if Result.Visible then
      begin
        R := Result.LocalRect;
        OffsetRect(R, Result.Position.X, Result.Position.Y);
        if (R.right - R.left) = 0 then
          if Align in [TAlignLayout.alTop, TAlignLayout.alLeft, TAlignLayout.alMostLeft] then
            R.left := R.left - 1
          else
            R.right := R.right + 1;
        if (R.bottom - R.top) = 0 then
          if Align in [TAlignLayout.alTop, TAlignLayout.alLeft, TAlignLayout.alMostLeft] then
            R.top := R.top - 1
          else
            R.bottom := R.bottom + 1;
        if R.Contains(P) then
          Exit;
      end;
    end;
  Result := nil;
end;

function TSplitter.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(5, 5);
end;

procedure TSplitter.UpdateSize(X, Y: Single);
begin
  CalcSplitSize(X, Y, FNewSize, FSplit);
end;

procedure TSplitter.CalcSplitSize(X, Y: Single; var NewSize, Split: Single);
var
  S: Single;
begin
  if Align in [TAlignLayout.alLeft, TAlignLayout.alRight, TAlignLayout.alMostLeft, TAlignLayout.alMostRight] then
    Split := X - FDownPos.X
  else
    Split := Y - FDownPos.Y;
  S := 0;
  case Align of
    TAlignLayout.alLeft, TAlignLayout.alMostLeft:
      S := FControl.Width + Split;
    TAlignLayout.alRight, TAlignLayout.alMostRight:
      S := FControl.Width - Split;
    TAlignLayout.alTop:
      S := FControl.Height + Split;
    TAlignLayout.alBottom:
      S := FControl.Height - Split;
  end;
  NewSize := S;
  if S < FMinSize then
    NewSize := FMinSize
  else if S > FMaxSize then
    NewSize := FMaxSize;
  if S <> NewSize then
  begin
    if Align in [TAlignLayout.alRight, TAlignLayout.alMostRight, TAlignLayout.alBottom] then
      S := S - NewSize
    else
      S := NewSize - S;
    Split := Split + S;
  end;
end;

procedure TSplitter.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('TabOrder', IgnoreIntegerValue, nil, False);
end;

function TSplitter.DoCanResize(var NewSize: Single): Boolean;
begin
  Result := True;
  if (NewSize <= FMinSize) { and FAutoSnap } then
    NewSize := FMinSize;
end;

procedure TSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  i: Integer;
  C: IContainerObject;
  SiblingControl: TControl;
begin
  inherited;
  if (Button = TMouseButton.mbLeft) and Supports(Parent, IContainerObject, C) then
  begin
    FPressed := True;
    FDownPos := PointF(X, Y);
    FControl := FindObject;
    if Assigned(FControl) then
    begin
      if Align in [TAlignLayout.alLeft, TAlignLayout.alMostLeft, TAlignLayout.alRight, TAlignLayout.alMostRight] then
      begin
        FMaxSize := C.ContainerWidth - FMinSize;
        if Parent is TControl then
          FMaxSize := FMaxSize - TControl(Parent).Padding.left - TControl(Parent).Padding.right;
        for i := 0 to Parent.ChildrenCount - 1 do
        begin
          if not (Parent.Children[i] is TControl) then
            Continue;
          SiblingControl := TControl(Parent.Children[i]);
          if (SiblingControl.Align in [TAlignLayout.alLeft, TAlignLayout.alRight, TAlignLayout.alMostLeft, TAlignLayout.alMostRight]) then
            FMaxSize := FMaxSize - SiblingControl.Width - SiblingControl.Margins.left - SiblingControl.Margins.right;
        end;
        FMaxSize := FMaxSize + FControl.Width;
      end
      else
      begin
        FMaxSize := C.ContainerHeight - FMinSize;
        if Parent is TControl then
          FMaxSize := FMaxSize - TControl(Parent).Padding.top - TControl(Parent).Padding.bottom;
        for i := 0 to Parent.ChildrenCount - 1 do
        begin
          if not(Parent.Children[i] is TControl) then
            Continue;
          SiblingControl := TControl(Parent.Children[i]);
          if SiblingControl.Align in [TAlignLayout.alTop, TAlignLayout.alBottom] then
            FMaxSize := FMaxSize - SiblingControl.Height - SiblingControl.Margins.top - SiblingControl.Margins.bottom;
        end;
        FMaxSize := FMaxSize + FControl.Height;
      end;
      UpdateSize(X, Y);
    end;
  end;
end;

procedure TSplitter.MouseMove(Shift: TShiftState; X, Y: Single);
var
  NewSize, Split: Single;
begin
  inherited;
  if FPressed and Assigned(FControl) then
  begin
    CalcSplitSize(X, Y, NewSize, Split);
    if DoCanResize(NewSize) then
    begin
      FNewSize := NewSize;
      FSplit := Split;
      UpdateControlSize;
    end;
  end;
end;

procedure TSplitter.UpdateControlSize;
begin
  if FNewSize <> FOldSize then
  begin
    case Align of
      TAlignLayout.alLeft, TAlignLayout.alMostLeft:
        FControl.Width := FNewSize;
      TAlignLayout.alTop:
        FControl.Height := FNewSize;
      TAlignLayout.alRight, TAlignLayout.alMostRight:
        begin
          FControl.Position.X := FControl.Position.X + (FControl.Width - FNewSize);
          FControl.Width := FNewSize;
        end;
      TAlignLayout.alBottom:
        begin
          FControl.Position.Y := FControl.Position.Y + (FControl.Height - FNewSize);
          FControl.Height := FNewSize;
        end;
    end;
    // if Assigned(FOnMoved) then FOnMoved(Self);
    FOldSize := FNewSize;
  end;
end;

procedure TSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  FPressed := False;
  FControl := nil;
end;

procedure TSplitter.SetShowGrip(const Value: Boolean);
begin
  if FShowGrip <> Value then
  begin
    FShowGrip := Value;
    ApplyStyle;
  end;
end;

{ TProgressBar }

constructor TProgressBar.Create(AOwner: TComponent);
begin
  inherited;
  FValueRange := TValueRange.Create(self);
  FDefaultValueRange := TBaseValueRange.Create;
  FValueRange.AfterChange := AfterChangeProc;
  FValueRange.OnChanged := ChangedProc;
  CanFocus := False;
  SetAcceptsControls(False);
end;

procedure TProgressBar.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('TabOrder', IgnoreIntegerValue, nil, False);
end;

destructor TProgressBar.Destroy;
begin
  FreeAndNil(FDefaultValueRange);
  FreeAndNil(FValueRange);
  inherited;
end;

procedure TProgressBar.AfterConstruction;
begin
  inherited;
  DefaultValueRange.Assign(FValueRange.New);
end;

procedure TProgressBar.Loaded;
begin
  if FValueRange.IsChanged then
    FValueRange.Changed(True);
  inherited;
end;

function TProgressBar.GetData: TValue;
begin
  Result := Value;
end;

function TProgressBar.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(100, 20);
end;

procedure TProgressBar.SetData(const Value: TValue);
begin
  if Value.IsOrdinal then
    Self.Value := Value.AsOrdinal
  else
  if Value.IsType<Single> then
    Self.Value := Value.AsType<Single>
  else
    Self.Value := Min
end;

function TProgressBar.GetActionLinkClass: TActionLinkClass;
begin
  Result := TValueRangeActionLink;
end;

procedure TProgressBar.ActionChange(Sender: TBasicAction;
  CheckDefaults: Boolean);
begin
  if Sender is TValueRangeAction then
  begin
    if (not CheckDefaults) or (FValueRange.IsEmpty) then
      FValueRange.Assign(TValueRangeAction(Sender).ValueRange);
  end;
  inherited;
end;

function TProgressBar.GetValueRange: TCustomValueRange;
begin
  Result := FValueRange;
end;

function TProgressBar.MaxStored: Boolean;
begin
  Result := DefStored and (not SameValue(Max, DefaultValueRange.Max));
end;

function TProgressBar.MinStored: Boolean;
begin
  Result := DefStored and (not SameValue(Min, DefaultValueRange.Min));
end;

function TProgressBar.ValueStored: Boolean;
begin
  Result := DefStored and (not SameValue(Value, DefaultValueRange.Value));
end;

procedure TProgressBar.SetValueRange(const AValue: TCustomValueRange);
begin
  FValueRange.Assign(AValue);
end;

function TProgressBar.GetMax: Single;
begin
  Result := FValueRange.Max - FValueRange.ViewportSize;
end;

procedure TProgressBar.SetMax(const Value: Single);
var V: Single;
begin
  V := Value + FValueRange.ViewportSize;
  if FValueRange.Max <> V then
    FValueRange.Max := V;
end;

function TProgressBar.GetMin: Single;
begin
  Result :=  FValueRange.Min;
end;

procedure TProgressBar.SetMin(const Value: Single);
begin
  if FValueRange.Min <> Value then
    FValueRange.Min := Value;
end;

function TProgressBar.GetValue: Single;
begin
  Result := FValueRange.Value;
end;

procedure TProgressBar.SetValue(const Value: Single);
begin
  if FValueRange.Value <> Value then
    FValueRange.Value := Value;
end;

procedure TProgressBar.AdjustSize;
begin
  case AdjustType of
    TAdjustType.FixedSize: SetBounds(Position.X, Position.Y, AdjustSizeValue.Width, AdjustSizeValue.Height);
    TAdjustType.FixedHeight:
      begin
        if not (csLoading in ComponentState) then
          case Orientation of
            TOrientation.orHorizontal: SetBounds(Position.X, Position.Y, Width, AdjustSizeValue.Height);
            TOrientation.orVertical:
              begin
                AdjustType := TAdjustType.FixedWidth;
                AdjustSizeValue := TSizeF.Create(AdjustSizeValue.Height, AdjustSizeValue.Width);
                AdjustSize;
              end;
          end;
      end;
    TAdjustType.FixedWidth: SetBounds(Position.X, Position.Y, AdjustSizeValue.Width, Height);
  end;
end;

procedure TProgressBar.ApplyStyle;
var
  i: TFmxObject;
begin
  inherited;
  if Orientation = TOrientation.orHorizontal then
  begin
    i := FindStyleResource('hindicator');
    if Assigned(i) and (i is TControl) then
      TControl(i).StartTriggerAnimation(Self, 'IsVisible');
  end
  else
  begin
    i := FindStyleResource('vindicator');
    if Assigned(i) and (i is TControl) then
      TControl(i).StartTriggerAnimation(Self, 'IsVisible');
  end;
  Realign;
end;

procedure TProgressBar.AfterChangeProc(Sender: TObject);
begin
  if ActionClient and
    (not DefStored) and
    (not TValueRangeAction(Action).ValueRange.Changing) then
    TValueRangeAction(Action).ValueRange := FValueRange;
end;

procedure TProgressBar.ChangedProc(Sender: TObject);
begin
  Realign;
end;

function TProgressBar.DefStored: boolean;
begin
  Result := not (ActionClient and
                 (Action is TCustomValueRangeAction));
end;

procedure TProgressBar.DoRealign;
var
  hI, vI, T: TFmxObject;
  NewSize: Single;
begin
  inherited;
  if not FDisableAlign then
  begin
    FDisableAlign := True;
    try
      T := nil;
      case Orientation of
        TOrientation.orHorizontal:
        begin
          T := FindStyleResource('vtrack');
          if Assigned(T) and (T is TControl) then
            TControl(T).Visible := False;
          T := FindStyleResource('htrack')
        end;
        TOrientation.orVertical:
        begin
          T := FindStyleResource('htrack');
          if Assigned(T) and (T is TControl) then
            TControl(T).Visible := False;
          T := FindStyleResource('vtrack');
        end;
      end;
      if not Assigned(T) then
        T := FindStyleResource('track');
      if Assigned(T) and (T is TControl) then
        TControl(T).Visible := True;
      if Assigned(T) and (T is TControl) and (Max > Min) then
      begin
        hI := FindStyleResource('hindicator');
        vI := FindStyleResource('vindicator');
        if Orientation = TOrientation.orHorizontal then
        begin

          if Assigned(hI) and (hI is TControl) then
          begin
            NewSize := (TControl(T).Width -
                         TControl(T).Padding.left -
                         TControl(T).Padding.right -
                         TControl(hI).Margins.left -
                         TControl(hI).Margins.right) * FValueRange.RelativeValue;
            TControl(hI).Width := Round(NewSize);
            TControl(hI).Visible := TControl(hI).Width > 2;
          end;
          if Assigned(vI) and (vI is TControl) then
            TControl(vI).Visible := False;
        end
        else
        begin
          if Assigned(vI) and (vI is TControl) then
          begin
            NewSize := (TControl(T).Height -
                        TControl(T).Padding.top -
                        TControl(T).Padding.bottom -
                        TControl(hI).Margins.top -
                        TControl(hI).Margins.bottom) * FValueRange.RelativeValue;
            TControl(vI).Height := Round(NewSize);
            TControl(vI).Visible := TControl(vI).Height > 2;
          end;
          if Assigned(hI) and (hI is TControl) then
            TControl(hI).Visible := False;
        end;
      end;
    finally
      FDisableAlign := False;
    end;
  end;
end;

procedure TProgressBar.SetOrientation(const Value: TOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    // swap
    if {(csDesigning in ComponentState) and} not(csLoading in ComponentState) then
    begin
      if AdjustType <> TAdjustType.None then
        AdjustSizeValue := PointF(Height, Width);
      SetBounds(Position.X, Position.Y, Height, Width);
    end;
    Realign;
  end;
end;

{ TThumb }

function ValueToPos(MinValue, MaxValue, ViewportSize, ThumbSize, TrackSize, Value: Single; IgnoreViewportSize: boolean): Single;
var ValRel: Double;
begin
  Result := ThumbSize / 2;
  if (ViewportSize < 0) or IgnoreViewportSize then
    ViewportSize := 0;
  ValRel := MaxValue - MinValue - ViewportSize;
  if ValRel > 0 then
  begin
    ValRel := (Value - MinValue) / ValRel;
    Result := (TrackSize - ThumbSize) * ValRel + Result;
  end;
end;

function PosToValue(MinValue, MaxValue, ViewportSize, ThumbSize, TrackSize, Pos: Single; IgnoreViewportSize: boolean): Single;
var ValRel: Double;
begin
  Result := MinValue;
  if (ViewportSize < 0) or IgnoreViewportSize then
    ViewportSize := 0;
  ValRel := TrackSize - ThumbSize;
  if ValRel > 0 then
  begin
    ValRel := (Pos - ThumbSize / 2) / ValRel;
    if ValRel < 0 then
      ValRel := 0;
    if ValRel > 1 then
      ValRel := 1;
    Result := MinValue + ValRel * (MaxValue - MinValue - ViewportSize);
  end;
end;

constructor TThumb.Create(AOwner: TComponent);
begin
  inherited;
  CanFocus := False;
  AutoCapture := True;
end;

function TThumb.PointToValue(X, Y: Single): Single;
var
  P: TPointF;
begin
  Result := 0;
  if Assigned(FTrack) and
     (Parent is TControl) then
  begin
    if FTrack.Orientation = TOrientation.orHorizontal then
    begin
      P := FTrack.AbsoluteToLocal(LocalToAbsolute(PointF(X, 0)));
      P.X := P.X - FDownOffset.X + Width / 2;
      Result := PosToValue(FTrack.Min, FTrack.Max, FTrack.ViewportSize, Self.Width, FTrack.Width, P.X, FTrack.FIgnoreViewportSize);
    end
    else
    begin
      P := FTrack.AbsoluteToLocal(LocalToAbsolute(PointF(0, Y)));
      P.Y := P.Y - FDownOffset.Y + Height / 2;
      Result := PosToValue(FTrack.Min, FTrack.Max, FTrack.ViewportSize, Self.Height, FTrack.Height, P.Y, FTrack.FIgnoreViewportSize);
    end;
  end;
end;

procedure TThumb.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if (Button = TMouseButton.mbLeft) and Enabled then
  begin
    FPressed := True;
    FDownOffset := PointF(X, Y);
    if Assigned(FTrack) then
    begin
      FTrack.SetFocus;
      FTrack.ValueRange.Tracking := FTrack.Tracking;
    end;
    StartTriggerAnimation(Self, 'IsPressed');
    ApplyTriggerEffect(Self, 'IsPressed');
  end;
end;

procedure TThumb.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if FPressed and Enabled then
    try
      FTrack.SetNewValue(PointToValue(X, Y));
    except
      FPressed := False;
      raise;
    end;
end;

procedure TThumb.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  LValue: Single;
begin
  LValue := PointToValue(X, Y);
  inherited;
  if FPressed then
  begin
    FPressed := False;
    try
      if Assigned(FTrack) and (not FTrack.ValueRange.Tracking) then
      begin
        FTrack.SetNewValue(LValue);
        FTrack.ValueRange.Tracking := True;
      end;
    finally
      StartTriggerAnimation(Self, 'IsPressed');
      ApplyTriggerEffect(Self, 'IsPressed');
    end;
  end;
end;

type
  TCustomTrackActionLink = class (TValueRangeActionLink)
  protected
    function IsScroll: boolean;
    procedure AssignClient(AClient: TObject); override;
    function IsCheckedLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
  end;

{ TCustomTrackActionLink }

procedure TCustomTrackActionLink.AssignClient(AClient: TObject);
begin
  if (not (AClient is TCustomTrack)) then
    raise EActionError.CreateFmt(StrNoClientClass, [AClient.ClassName]);
  inherited;
end;

function TCustomTrackActionLink.IsScroll: boolean;
var Par: TFmxObject;
begin
  Par := TCustomTrack(Client);
  while (Par <> nil) and (not (Par is TScrollBar)) do
    Par := Par.Parent;
  Result := Par <> nil;
end;

function TCustomTrackActionLink.IsVisibleLinked: Boolean;
begin
  if IsScroll then
    Result := False
  else
    Result := inherited IsVisibleLinked;
end;

function TCustomTrackActionLink.IsCheckedLinked: Boolean;
begin
  if IsScroll then
    Result := False
  else
    Result := inherited IsCheckedLinked;
end;

function TCustomTrackActionLink.IsEnabledLinked: Boolean;
begin
  if IsScroll then
    Result := False
  else
    Result := inherited IsEnabledLinked;
end;

type
  TValueRangeTrack = class (TValueRange)
  private
    FTrack: TCustomTrack;
    FValueChanged: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoBeforeChange; override;
    procedure DoChanged; override;
    procedure DoAfterChange; override;
    procedure DoTrackingChange; override;
    function NeedActionChange: boolean;
    property Track: TCustomTrack read FTrack;
  end;

{ TValueRangeTrack }

function TValueRangeTrack.NeedActionChange: boolean;
begin
  Result := FTrack.ActionClient and
           (not FTrack.DefStored) and
           (not TValueRangeAction(FTrack.Action).ValueRange.Changing);
end;

constructor TValueRangeTrack.Create(AOwner: TComponent);
begin
  if not (AOwner is TCustomTrack) then
    raise EActionError.CreateFMT(StrEUseHeirs, [TCustomTrack.ClassName]);
  inherited;
  FTrack := TCustomTrack(AOwner);
end;

procedure TValueRangeTrack.DoBeforeChange;
begin
  FValueChanged := (not SameValue(Value, New.Value));
  if NeedActionChange then
    TValueRangeAction(FTrack.Action).ValueRange.Assign(New);
  inherited;
end;

procedure TValueRangeTrack.DoChanged;
begin
  FTrack.Realign;
  FTrack.DoTracking;
  inherited;
end;

procedure TValueRangeTrack.DoTrackingChange;
begin
  inherited;
end;

procedure TValueRangeTrack.DoAfterChange;
begin
  if FValueChanged then
  try
    FTrack.DoChanged;
  finally
    FValueChanged := False;
  end;
  inherited;
end;


{ TCustomTrack }

constructor TCustomTrack.Create(AOwner: TComponent);
begin
  inherited;
  FValueRange := CreateValueRangeTrack;
  FDefaultValueRange := TBaseValueRange.Create;
  FTracking := True;
  FMinThumbSize := 5;
end;

destructor TCustomTrack.Destroy;
begin
  FreeAndNil(FDefaultValueRange);
  FreeAndNil(FValueRange);
  inherited;
end;

procedure TCustomTrack.AfterConstruction;
begin
  inherited;
  DefaultValueRange.Assign(FValueRange.New);
end;

procedure TCustomTrack.ObserversValueUpdate;
begin
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if TLinkObservers.EditLinkIsModified(Observers) then
      TLinkObservers.EditLinkUpdate(Observers);
  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueUpdate(Observers);
end;

procedure TCustomTrack.Loaded;
begin
  if not (csDestroying in ComponentState) then
  begin
    if FValueRange.IsChanged then
      FValueRange.Changed(True);
  end;
  inherited;
end;

function TCustomTrack.CreateValueRangeTrack : TValueRange;
begin
  Result := TValueRangeTrack.Create(self);
end;

function TCustomTrack.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.PositionLinkID then
    Result := True;
  if ID = TObserverMapping.EditLinkID then
    Result := True;
  if ID = TObserverMapping.ControlValueID then
    Result := True;
end;

function TCustomTrack.GetData: TValue;
begin
  Result := Value;
end;

function TCustomTrack.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(100, 17);
end;

procedure TCustomTrack.SetData(const Value: TValue);
begin
  if Value.IsType<TNotifyEvent> then
    OnChange := Value.AsType<TNotifyEvent>()
  else if Value.IsOrdinal then
    Self.Value := Value.AsOrdinal
  else if Value.IsType<Single> then
    Self.Value := Value.AsType<Single>
  else
    Self.Value := Min
end;

function TCustomTrack.GetThumbRect(Value: single): TRectF;
var
  Pos, Size: Single;
begin
  Result := LocalRect;
  Size := GetThumbSize(FIgnoreViewportSize);
  case Orientation of
    TOrientation.orHorizontal:
    begin
      Pos := ValueToPos(Min, Max, ViewportSize, Size, Width, Value, FIgnoreViewportSize);
      Size := Size / 2;
      Result := RectF(Pos - Size, 0, Pos + Size, Height);
    end;
    TOrientation.orVertical:
    begin
      Pos := ValueToPos(Min, Max, ViewportSize, Size, Height, Value, FIgnoreViewportSize);
      Size := Size / 2;
      Result := RectF(0, Pos - Size, Width, Pos + Size);
    end;
  end;
  if Assigned(FThumb) and Assigned(FThumb.Parent) and (FThumb.Parent is TControl) then
  begin
    if RectWidth(Result) > TControl(FThumb.Parent).Padding.left + FThumb.Margins.left + TControl(FThumb.Parent).Padding.right - FThumb.Margins.right then
    begin
      Result.left := Round(Result.left + TControl(FThumb.Parent).Padding.left + FThumb.Margins.left);
      Result.right := Round(Result.right - TControl(FThumb.Parent).Padding.right - FThumb.Margins.right);
    end;
    Result.top := Round(Result.top + TControl(FThumb.Parent).Padding.top + FThumb.Margins.top);
    Result.bottom := Round(Result.bottom - TControl(FThumb.Parent).Padding.bottom - FThumb.Margins.bottom);
  end;
end;

function TCustomTrack.GetThumbRect: TRectF;
begin
  Result := GetThumbRect(Value);
end;

function TCustomTrack.GetThumbSize(var IgnoreViewportSize: boolean): integer;
var
  lSize: Double;
begin
  Result := 0;
  lSize := FMinThumbSize;
  case Orientation of
    TOrientation.orHorizontal:
    begin
      if ViewportSize > 0 then
        lSize := ViewportSize / (Max - Min) * Width
      else
        if SameValue(FThumbSize, 0) then
          lSize := Height
        else
          lSize := FThumbSize;
      Result := Round(System.Math.Min(System.Math.MaxValue([lSize, Height / 2, FMinThumbSize]), Width));
    end;
    TOrientation.orVertical:
    begin
      if ViewportSize > 0 then
        lSize := ViewportSize / (Max - Min) * Height
      else
        if SameValue(FThumbSize, 0) then
          lSize := Width
        else
          lSize := FThumbSize;
      Result := Round(System.Math.Min(System.Math.MaxValue([lSize, Width / 2, FMinThumbSize]), Height));
    end;
  end;
  if Result < FMinThumbSize then
    Result := 0;
  IgnoreViewportSize := Result <= (lSize - 1);
end;

function TCustomTrack.DefStored: boolean;
begin
  Result := not (ActionClient and
                (Action is TCustomValueRangeAction));
end;

function TCustomTrack.ValueStored: Boolean;
begin
  Result := DefStored and (not SameValue(Value, DefaultValueRange.Value));
end;

function TCustomTrack.ViewportSizeStored: Boolean;
begin
  Result := DefStored and (not SameValue(ViewportSize, DefaultValueRange.ViewportSize));
end;

function TCustomTrack.FrequencyStored: Boolean;
begin
  Result := DefStored and (not SameValue(Frequency, DefaultValueRange.Frequency));
end;

function TCustomTrack.MaxStored: Boolean;
begin
  Result := DefStored and (not SameValue(Max, DefaultValueRange.Max));
end;

function TCustomTrack.MinStored: Boolean;
begin
  Result := DefStored and (not SameValue(Min, DefaultValueRange.Min));
end;

function TCustomTrack.GetMax: Single;
begin
  Result := FValueRange.Max;
end;

procedure TCustomTrack.SetMax(const Value: Single);
begin
  FValueRange.Max := Value;
end;

procedure TCustomTrack.SetMin(const Value: Single);
begin
  FValueRange.Min := Value;
end;

function TCustomTrack.GetMin: Single;
begin
  Result := FValueRange.Min;
end;

procedure TCustomTrack.SetFrequency(const Value: Single);
begin
  FValueRange.Frequency := Value;
end;

function TCustomTrack.GetFrequency: Single;
begin
  Result := FValueRange.Frequency;
end;

function TCustomTrack.GetValue: Single;
begin
  Result := FValueRange.Value;
end;

procedure TCustomTrack.SetValue(Value: Single);
begin
  FValueRange.Value := Value;
end;

function TCustomTrack.GetViewportSize: Single;
begin
  Result := FValueRange.ViewportSize;
end;

procedure TCustomTrack.SetViewportSize(const Value: Single);
begin
  FValueRange.ViewportSize := Value;
end;

function TCustomTrack.GetValueRange: TCustomValueRange;
begin
  Result := FValueRange;
end;

procedure TCustomTrack.SetValueRange(const AValue: TCustomValueRange);
begin
  FValueRange.Assign(AValue);
end;

procedure TCustomTrack.SetValueRange_(const Value: TValueRange);
begin
  FValueRange.Assign(Value);
end;

function TCustomTrack.GetActionLinkClass: TActionLinkClass;
begin
  Result := TCustomTrackActionLink;
end;

procedure TCustomTrack.ActionChange(Sender: TBasicAction;
  CheckDefaults: Boolean);
begin
  if Sender is TValueRangeAction then
  begin
    if (not CheckDefaults) or (FValueRange.IsEmpty) then
      FValueRange.Assign(TValueRangeAction(Sender).ValueRange);
  end;
  if (ActionLink is TCustomTrackActionLink) and
     (TCustomTrackActionLink(ActionLink).IsScroll) then
    Exit;
  inherited;
end;

procedure TCustomTrack.DoRealign;
var R: TRectF;
begin
  inherited;
  if Assigned(FThumb) then
  begin
    R := GetThumbRect;
    FThumb.Visible := not ((R.Right <= R.Left) or (R.Bottom <= R.Top));
    FThumb.BoundsRect := R;
  end;
end;

procedure TCustomTrack.AdjustSize;
begin
  case AdjustType of
    TAdjustType.FixedSize: SetBounds(Position.X, Position.Y, AdjustSizeValue.Width, AdjustSizeValue.Height);
    TAdjustType.FixedHeight:
      begin
        if not (csLoading in ComponentState) then
          case Orientation of
            TOrientation.orHorizontal: SetBounds(Position.X, Position.Y, Width, AdjustSizeValue.Height);
            TOrientation.orVertical:
              begin
                AdjustType := TAdjustType.FixedWidth;
                AdjustSizeValue := TSizeF.Create(AdjustSizeValue.Height, AdjustSizeValue.Width);
                AdjustSize;
              end;
          end;
      end;
    TAdjustType.FixedWidth: SetBounds(Position.X, Position.Y, AdjustSizeValue.Width, Height);
  end;
end;

procedure TCustomTrack.ApplyStyle;
var
  T: TFmxObject;
begin
  inherited;
  T := FindStyleResource('vthumb');
  if Assigned(T) and (T is TThumb) then
  begin
    if Orientation = TOrientation.orHorizontal then
      TControl(T).Visible := False
    else
    begin
      TControl(T).Visible := True;
      FThumb := TThumb(T);
    end;
  end;
  T := FindStyleResource('hthumb');
  if Assigned(T) and (T is TThumb) then
  begin
    if Orientation = TOrientation.orVertical then
      TControl(T).Visible := False
    else
    begin
      TControl(T).Visible := True;
      FThumb := TThumb(T);
    end;
  end;
  T := FindStyleResource('thumb');
  if Assigned(T) and (T is TThumb) then
  begin
    FThumb := TThumb(T);
    FThumb.FTrack := Self;
  end;
  if Assigned(FThumb) then
    FThumb.FTrack := Self;

  T := FindStyleResource('vtrack');
  if Assigned(T) and (T is TControl) then
  begin
    if Orientation = TOrientation.orHorizontal then
      TControl(T).Visible := False
    else
    begin
      TControl(T).Visible := True;
      FTrack := TControl(T);
    end;
  end;
  T := FindStyleResource('htrack');
  if Assigned(T) and (T is TControl) then
  begin
    if Orientation = TOrientation.orVertical then
      TControl(T).Visible := False
    else
    begin
      TControl(T).Visible := True;
      FTrack := TControl(T);
    end;
  end;
  T := FindStyleResource('track');
  if Assigned(T) and (T is TControl) then
  begin
    TControl(T).Visible := True;
    FTrack := TControl(T);
  end;
  if Assigned(FTrack) then
  begin
    T := FTrack.FindStyleResource('highlight');
    if Assigned(T) and (T is TControl) then
      FTrackHighlight := TControl(T);
    UpdateHighlight;
  end;

  T := FindStyleResource('thumbsize');
  if Assigned(T) then
  begin
    if T.Tag > 0 then
      FThumbSize := T.Tag;
    if T.TagFloat > 0 then
      FThumbSize := T.TagFloat;

    FTrack := TControl(T);
  end;

  // forward the thumb clicks and dblClicks to the trackbar events
  if Assigned(FThumb) then
  begin
    FThumb.OnClick := DoThumbClick;
    FThumb.OnDblClick := DoThumbDblClick;
  end;
  Realign;
  if Assigned(FThumb) then
  begin
    MinClipWidth := FThumb.Width;
    MinClipHeight := FThumb.Height;
  end;
end;

procedure TCustomTrack.UpdateHighlight;
begin
  if Assigned(FTrackHighlight) then
  begin
    case Orientation of
      TOrientation.orHorizontal:
        FTrackHighlight.Width := Round((GetThumbRect.Left + GetThumbRect.Right) / 2);
      TOrientation.orVertical:
        FTrackHighlight.Height := Round((GetThumbRect.Top + GetThumbRect.Bottom) / 2);
    end;
  end;
end;

procedure TCustomTrack.FreeStyle;
begin
  FThumbSize := 0;
  FThumb := nil;
  FTrack := nil;
  FTrackHighlight := nil;
  inherited;
end;

procedure TCustomTrack.DoChanged;
begin
  if (not (csLoading in ComponentState)) and Assigned(FOnChange) then
    FOnChange(Self);
  UpdateHighlight;
end;

procedure TCustomTrack.DoTracking;
begin
  if (not (csLoading in ComponentState)) and Assigned(FOnTracking) then
    FOnTracking(Self);
  UpdateHighlight;
end;

procedure TCustomTrack.SetNewValue(const LValue: Single);
begin
  if LValue <> Value then
  begin
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
    begin
      if TLinkObservers.EditLinkIsReadOnly(Observers) then
        Exit;
      if not TLinkObservers.EditLinkEdit(Observers) then
        Exit;
    end;
    TLinkObservers.PositionLinkPosChanging(Observers);
    Value := LValue;
    TLinkObservers.PositionLinkPosChanged(Observers);
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      TLinkObservers.EditLinkModified(Observers);


    if Tracking then
    begin
      if Observers.IsObserving(TObserverMapping.EditLinkID) then
        if TLinkObservers.EditLinkIsModified(Observers) then
          TLinkObservers.EditLinkUpdate(Observers);
      if Observers.IsObserving(TObserverMapping.ControlValueID) then
      begin
        TLinkObservers.ControlValueModified(Observers);
        TLinkObservers.ControlValueUpdate(Observers);
      end;
    end
    else
    if Observers.IsObserving(TObserverMapping.ControlValueID) then
      TLinkObservers.ControlValueModified(Observers);
  end
  else
    Value := LValue;
end;

procedure TCustomTrack.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  LValue: single;
begin
  LValue := Value;
  inherited MouseUp(Button, Shift, X, Y);
  DoMouseUp(Button, Shift, X, Y, LValue);
end;

procedure TCustomTrack.DoMouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Single; LValue : Single);
var
  Size: integer;
begin
  if (MouseDownAction = TMouseDownAction.mdaGoto) and (Button = TMouseButton.mbLeft) then
  begin
    Size := GetThumbSize(FIgnoreViewportSize);
    case Orientation of
      TOrientation.orHorizontal:
        LValue := PosToValue(Min, Max, ViewportSize, Size, Width, X, FIgnoreViewportSize);
      TOrientation.orVertical:
        LValue := PosToValue(Min, Max, ViewportSize, Size, Height, Y, FIgnoreViewportSize);
    end;
    SetNewValue(LValue);

    if not Tracking then
      ObserversValueUpdate;
  end;
end;

procedure TCustomTrack.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
var
  inc: Single;
  LValue: Single;
begin
  inc := Frequency;
  if inc = 0 then
    inc := 1;
  inherited;
  case Key of
    vkHome:
      LValue := Min;
    vkEnd:
      LValue := Max;
    vkUp:
      LValue := Value - inc;
    vkDown:
      LValue := Value + inc;
    vkLeft:
      LValue := Value - inc;
    vkRight:
      LValue := Value + inc;
  else
    Exit;
  end;
  Key := 0;
  SetNewValue(LValue);
end;

procedure TCustomTrack.SetOrientation(const Value: TOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    // swap
    if {(csDesigning in ComponentState) and} not(csLoading in ComponentState) then
    begin
      if AdjustType <> TAdjustType.None then
        AdjustSizeValue := PointF(Height, Width);
      SetBounds(Position.X, Position.Y, Height, Width);
    end;
    DoStyleChanged;
  end;
end;

function TCustomTrack.GetIsTracking: Boolean;
begin
  Result := Assigned(FThumb) and FThumb.FPressed;
end;

procedure TCustomTrack.DoThumbClick(Sender: TObject);
begin
  if not Tracking then
    ObserversValueUpdate;
  if Assigned(OnClick) then
    OnClick(Self);
end;

procedure TCustomTrack.DoThumbDblClick(Sender: TObject);
begin
  if not Tracking then
    ObserversValueUpdate;
  if Assigned(OnDblClick) then
    OnDblClick(Self);
end;

{ TTrackBar }

constructor TTrackBar.Create(AOwner: TComponent);
begin
  inherited;
  CanFocus := True;
  SetAcceptsControls(False);
end;

{ TBitmapTrackBar }

constructor TBitmapTrackBar.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TBitmapTrackBar.Destroy;
begin
  if Assigned(FBitmap) then
    FreeAndNil(FBitmap);
  inherited;
end;

procedure TBitmapTrackBar.ApplyStyle;
var
  T: TFmxObject;
  NeedUpdate: Boolean;
begin
  inherited;
  NeedUpdate := False;
  if Orientation = TOrientation.orHorizontal then
  begin
    T := FindStyleResource('htrack');
    if Assigned(T) and (T is TShape) then
    begin
      FBackground := TShape(T);
      NeedUpdate := True;
    end;
    if Assigned(T) then
    begin
      T := T.FindStyleResource('background');
      if (T is TShape) then
      begin
        FBackground := TShape(T);
        NeedUpdate := True;
      end;
    end
  end
  else
  begin
    T := FindStyleResource('vtrack');
    if Assigned(T) and (T is TShape) then
    begin
      FBackground := TShape(T);
      NeedUpdate := True;
    end;
    if Assigned(T) then
    begin
      T := T.FindStyleResource('background');
      if (T is TShape) then
      begin
        FBackground := TShape(T);
        NeedUpdate := True;
      end;
    end
  end;
  if Assigned(FBackground) and Assigned(FTrackHighlight) then
  begin
    FTrackHighlight.Visible := False;
    FTrackHighlight := nil;
    NeedUpdate := True;
  end;
  if NeedUpdate then
    UpdateBitmap;
end;

procedure TBitmapTrackBar.FreeStyle;
begin
  if Assigned(FBackground) then
    IBitmapLink(FBackground.Fill.Bitmap.Bitmap).SetResourceBitmap(nil);
  FBackground := nil;
  inherited;
end;

function TBitmapTrackBar.GetDefaultStyleLookupName: string;
begin
  Result := 'trackbarstyle';
end;

procedure TBitmapTrackBar.DoRealign;
begin
  inherited;
  UpdateBitmap;
end;

procedure TBitmapTrackBar.SetOrientation(const Value: TOrientation);
begin
  if Value <> FOrientation then
  begin
    inherited;
    if Assigned(FBitmap) then
      FreeAndNil(FBitmap);
    UpdateBitmap;
  end;
end;

procedure TBitmapTrackBar.UpdateBitmap;
begin
  if not Assigned(FBackground) then
    Exit;

  if Assigned(FBitmap) then
    if (FBitmap.Width <> trunc(FBackground.Width)) or (FBitmap.Height <> trunc(FBackground.Height)) then
    begin
      IBitmapLink(FBackground.Fill.Bitmap.Bitmap).SetResourceBitmap(nil);
      FreeAndNil(FBitmap);
    end;

  if not Assigned(FBitmap) then
    FBitmap := TBitmap.Create(trunc(FBackground.Width), trunc(FBackground.Height));

  FillBitmap;

  FBackground.Fill.Kind := TBrushKind.bkBitmap;
  IBitmapLink(FBackground.Fill.Bitmap.Bitmap).SetResourceBitmap(FBitmap);

  Repaint;
end;

procedure TBitmapTrackBar.FillBitmap;
begin
end;

{ TSwitch }

constructor TSwitch.Create(AOwner: TComponent);
begin
  inherited;
  Tracking := False;
  AutoCapture := True;
  FValueRange.Tracking := False;
  MouseDownAction := TMouseDownAction.mdaGoto;
  FOnBrush := TBrush.Create(TBrushKind.bkNone, claWhite);
  FOffBrush := TBrush.Create(TBrushKind.bkNone, claWhite);
  FDeadZone := 10;
  AutoCapture := True;
  SetAcceptsControls(False);
  EnableExecuteAction := True;
end;

destructor TSwitch.Destroy;
begin
  if Assigned(FOnBrush) then
    FreeAndNil(FOnBrush);
  if Assigned(FOffBrush) then
    FreeAndNil(FOffBrush);
  FreeAndNil(FBitmap);
  FreeAndNil(FMaskBitmap);
  FreeAndNil(FTextBitmap);
  inherited;
end;

procedure TSwitch.ApplyStyle;
var
  T: TFmxObject;
  NeedUpdate: Boolean;
  Loc: IFMXLocaleService;
  LocText: string;
begin
  inherited;
  NeedUpdate := False;
  T := FindStyleResource('htrack');
  if Assigned(T) and (T is TShape) and (Orientation = TOrientation.orHorizontal) then
  begin
    FBackground := TShape(T);
    NeedUpdate := True;
  end;
  T := FindStyleResource('vtrack');
  if Assigned(T) and (T is TShape) and (Orientation = TOrientation.orVertical) then
  begin
    FBackground := TShape(T);
    NeedUpdate := True;
  end;
  if not Assigned(FBackground) then
  begin
    T := FindStyleResource('track');
    if Assigned(T) and (T is TShape) then
    begin
      FBackground := TShape(T);
      NeedUpdate := True;
    end;
  end;
  T := FindStyleResource('on');
  if Assigned(T) and (T is TBrushObject) then
  begin
    FOnBrush.Assign(TBrushObject(T).Brush);
    NeedUpdate := True;
  end;
  if Assigned(T) and (T is TControl) then
  begin
    FOnObject := TControl(T);
    FOnObject.Visible := False;
    NeedUpdate := True;
  end;
  T := FindStyleResource('off');
  if Assigned(T) and (T is TBrushObject) then
  begin
    FOffBrush.Assign(TBrushObject(T).Brush);
    NeedUpdate := True;
  end;
  if Assigned(T) and (T is TControl) then
  begin
    FOffObject := TControl(T);
    FOffObject.Visible := False;
    NeedUpdate := True;
  end;
  LocText := 'itext';
  if TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService, IInterface(Loc)) then
  begin
    if Loc.GetCurrentLangID = 'en' then
      LocText := 'ontext'
    else if Loc.GetCurrentLangID = 'ja' then
      LocText := 'jpontext'
  end;
  T := FindStyleResource(LocText);
  if Assigned(T) and (T is TControl) then
  begin
    FOnText := TControl(T);
    FOnText.Visible := False;
    NeedUpdate := True;
  end;
  LocText := 'otext';
  if TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService, IInterface(Loc)) then
  begin
    if Loc.GetCurrentLangID = 'en' then
      LocText := 'offtext'
    else if Loc.GetCurrentLangID = 'ja' then
      LocText := 'jpofftext'
  end;
  T := FindStyleResource(LocText);
  if Assigned(T) and (T is TControl) then
  begin
    FOffText := TControl(T);
    FOffText.Visible := False;
    NeedUpdate := True;
  end;
  T := FindStyleResource('mask');
  if Assigned(T) and (T is TControl) then
  begin
    FTextMask := TControl(T);
    FTextMask.Visible := False;
    NeedUpdate := True;
  end;

  if NeedUpdate then
    UpdateBitmap;

  if FThumb <> nil then
  begin
    FThumb.HitTest := False;
    FDeadZone := FThumb.Width * 0.4;
    FValueRange.Max := Width - FThumb.Width;
  end;
  MinClipWidth := 8;
  MinClipHeight := 8;
end;

procedure TSwitch.FreeStyle;
begin
  if Assigned(FBackground) then
    IBitmapLink(FBackground.Fill.Bitmap.Bitmap).SetResourceBitmap(nil);
  FBackground := nil;
  FOffObject := nil;
  FOnObject := nil;
  FOnText := nil;
  FOffText := nil;
  FTextMask := nil;
  inherited;
end;

procedure TSwitch.DoRealign;
begin
  inherited;
  UpdateBitmap;
end;

procedure TSwitch.SetOrientation(const Value: TOrientation);
begin
  if Value <> TOrientation.orHorizontal then
    raise EPropertyError.Create(SInvalidPropertyValue);
  inherited SetOrientation(Value);
end;

function TSwitch.IsCheckedByValue: boolean;
begin
  Result := Value > Min + ((Max - Min - ViewportSize) / 2);
end;

function TSwitch.GetActionLinkClass: TActionLinkClass;
begin
  Result := TControlActionLink;
end;

function TSwitch.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(78, 27);
end;

function TSwitch.GetIsChecked: boolean;
begin
  Result := FIsChecked;
end;

function TSwitch.GetThumbRect(Value: single): TRectF;
begin
  if Tracking then
    Result := inherited GetThumbRect(Value)
  else
  begin
    if IsCheckedByValue then
      Result := inherited GetThumbRect(Max - ViewportSize)
    else
      Result := inherited GetThumbRect(Min);
  end;
end;

procedure TSwitch.DoSwitch;
begin
  if Assigned(FOnSwitch) then
    FOnSwitch(Self);
end;

procedure TSwitch.SetIsChecked(const Value: Boolean);
var
  Llinked: boolean;
begin
  if (FIsChecked <> Value) then
  begin
    Llinked := not IsCheckedStored;
    FIsChecked := Value;
    if Llinked then
      TContainedAction(Action).Checked := FIsChecked;
    if not (csLoading in ComponentState) then
    begin
      if not FInClick then
      begin
        AnimateTo(FIsChecked);
        DoSwitch;
        UpdateBitmap;
      end;
    end
    else
    begin
      if IsChecked then
        ValueRange.Value := ValueRange.Max
      else
        ValueRange.Value := ValueRange.Min;
    end;
  end;
end;

function TSwitch.IsCheckedStored: boolean;
begin
  Result := not (ActionClient and
                 (ActionLink is TActionLink) and
                 (THackFMXActionLink(ActionLink).IsCheckedLinked) and
                 (Action is TContainedAction));
end;

function TSwitch.PointToValue(X, Y: Single): Single;
begin
  Result := AbsoluteToLocal(LocalToAbsolute(PointF(X - FDeadZoneOffset, 0))).X - FDownOffset.X;
end;

procedure TSwitch.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if (Button = TMouseButton.mbLeft) and Enabled then
  begin
    FreeAndNil(FClickAnimation);
    FDownOffset := PointF(X, Y);
    FDownPoint := FDownOffset;
    FMoved := False;
    Tracking := False;
    SetFocus;
    StartTriggerAnimation(Self, 'IsPressed');
    ApplyTriggerEffect(Self, 'IsPressed');
  end;
end;

procedure TSwitch.MouseMove(Shift: TShiftState; X, Y: Single);
var
  Offset : Single;
begin
  inherited;
  if FPressed and Enabled then
  begin
    if Abs(FDownPoint.X - X) > 1 then
      FMoved := True;
    if not Tracking then
    begin
      Offset := X - FDownOffset.X;
      if Abs(Offset) > FDeadZone then
      begin
        if (Offset < 0) then
        begin
          FDeadZoneOffset := -FDeadZone;
          FDownOffset.X := -(Width - FDownOffset.X - FThumb.Width);
        end;
        Tracking := True;
      end;
    end;
    if Tracking then
    begin
      SetNewValue(PointToValue(X, Y));
    end;
  end;
end;

procedure TSwitch.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if FPressed then
  begin
    try
      if Tracking then
      begin
        AnimateTo(IsCheckedByValue);
        IsChecked := IsCheckedByValue;
        FMoved := True;
      end;
    finally
      StartTriggerAnimation(Self, 'IsPressed');
      ApplyTriggerEffect(Self, 'IsPressed');
    end;
  end;
  inherited;
  Realign;
end;

procedure TSwitch.Click;
var
  OldChecked: Boolean;
begin
  if not FInClick then
  begin
    FInClick := True;
    try
      OldChecked := IsChecked;
      if not FMoved then
      begin
        IsChecked := not IsChecked;
        inherited;
        FMoved := True;
      end;
      if OldChecked <> IsChecked then
      begin
        if Observers.IsObserving(TObserverMapping.EditLinkID) then
          if TLinkObservers.EditLinkIsReadOnly(Observers) then
            Exit;
        AnimateTo(IsChecked);
        DoSwitch;
        UpdateBitmap;
        if Observers.IsObserving(TObserverMapping.EditLinkID) then
        begin
          TLinkObservers.EditLinkModified(Observers);
          TLinkObservers.EditLinkTrackUpdate(Observers);
        end;
        if Observers.IsObserving(TObserverMapping.ControlValueID) then
        begin
          TLinkObservers.ControlValueModified(Observers);
          TLinkObservers.ControlValueTrackUpdate(Observers);
        end;
      end;
    finally
      FInClick := False;
    end;
  end;
end;

procedure TSwitch.DoMouseUp(Button: TMouseButton; Shift: TShiftState;
    X, Y: Single; LValue: Single);
begin
end;

procedure TSwitch.ActionChange(Sender: TBasicAction; CheckDefaults: Boolean);
begin
  inherited;
  if Sender is TCustomAction then
  begin
    if (not CheckDefaults) or (not IsChecked) then
      IsChecked := TCustomAction(Sender).Checked;
  end;
end;

procedure TSwitch.AnimateTo(Checked: Boolean);
begin
  FreeAndNil(FClickAnimation);
  if ([csLoading, csReading, csDestroying, csDesigning] * ComponentState <> []) or
     (not Assigned(Parent)) or
     (FDisablePaint) or
     (FUpdating > 0) or
     (not Visible) or
     (not ParentedVisible) then
  begin
    if Checked then
      ValueRange.Value := ValueRange.Max
    else
      ValueRange.Value := ValueRange.Min;
  end
  else
  begin
    Tracking := True;
    FClickAnimation := TFloatAnimation.Create(Self);
    FClickAnimation.Parent := Self;
    FClickAnimation.AnimationType := TAnimationType.atIn;
    FClickAnimation.Interpolation := TInterpolationType.itLinear;
    FClickAnimation.PropertyName := 'Value';
    FClickAnimation.StartFromCurrent := True;
    if Checked then
      FClickAnimation.StopValue := ValueRange.Max
    else
      FClickAnimation.StopValue := ValueRange.Min;
    FClickAnimation.Duration := 0.2 * Abs((Value - FClickAnimation.StopValue) / (ValueRange.Max - ValueRange.Min));
    FClickAnimation.OnFinish := OnAnimationEnd;
    FClickAnimation.Start;
  end;
end;

procedure TSwitch.OnAnimationEnd(Sender: TObject);
begin
  Tracking := False;
  if Assigned(FClickAnimation) then
    FClickAnimation.Release;
  FClickAnimation := nil;
end;

procedure TSwitch.UpdateBitmap;
var
  ScreenScale: single;
begin
  if not Assigned(FBackground) then
    Exit;

  if Assigned(Scene) then
    ScreenScale := Scene.GetSceneScale
  else
    ScreenScale := 1;

  if Assigned(FTextMask) then
  begin
    if not Assigned(FMaskBitmap) then
      FMaskBitmap := TBitmap.Create(Round(Width * ScreenScale), Round(Height * ScreenScale));
    if not Assigned(FTextBitmap) then
      FTextBitmap := TBitmap.Create(Round(Width * ScreenScale), Round(Height * ScreenScale));

    if Assigned(FMaskBitmap) and ((FMaskBitmap.Height <> Round(Height * ScreenScale)) or (FMaskBitmap.Width <> Round(Width * ScreenScale))) then
      FMaskBitmap.SetSize(Round(Width * ScreenScale), Round(Height * ScreenScale));
    if Assigned(FTextBitmap) and ((FTextBitmap.Height <> Round(Height * ScreenScale)) or (FTextBitmap.Width <> Round(Width * ScreenScale))) then
      FTextBitmap.SetSize(Round(Width * ScreenScale), Round(Height * ScreenScale));

    if FMaskBitmap.Canvas.BeginScene then
    try
      FMaskBitmap.Canvas.Clear(0);
      FTextMask.Visible := True;
      FTextMask.SetBounds(0, 0, Width * ScreenScale, Height * ScreenScale);
      FTextMask.PaintTo(FMaskBitmap.Canvas, RectF(0, 0, Width * ScreenScale, Height * ScreenScale));
    finally
      FTextMask.Visible := False;
      FMaskBitmap.Canvas.EndScene;
    end;
  end;

  if not Assigned(FBitmap) then
    FBitmap := TBitmap.Create(trunc(FBackground.Width * ScreenScale), trunc(FBackground.Height * ScreenScale));
  if Assigned(FBitmap) then
  begin
    if (FBitmap.Width <> trunc(FBackground.Width * ScreenScale)) or (FBitmap.Height <> trunc(FBackground.Height * ScreenScale)) then
      FBitmap.SetSize(Trunc(FBackground.Width * ScreenScale), Trunc(FBackground.Height * ScreenScale));
    FillBitmap;
  end;

  FBackground.Fill.Kind := TBrushKind.bkBitmap;
  FBackground.Fill.Bitmap.WrapMode := TWrapMode.wmTileStretch;
  IBitmapLink(FBackground.Fill.Bitmap.Bitmap).SetResourceBitmap(FBitmap);

  Repaint;
end;

procedure TSwitch.FillBitmap;
var
  Pos: Single;
  State: TCanvasSaveState;
  M: TMatrix;
  ScreenScale: single;
begin
  if Assigned(Scene) then
    ScreenScale := Scene.GetSceneScale
  else
    ScreenScale := 1;
  if Assigned(FOnObject) and Assigned(FOffObject) then
  begin
    if (Orientation = TOrientation.orHorizontal) then
    begin
      Pos := (GetThumbRect.Left + GetThumbRect.Right) / 2 * ScreenScale;
      { render text }
      if Assigned(FTextBitmap) and Assigned(FMaskBitmap) then
      begin
        if FTextBitmap.Canvas.BeginScene then
        try
          FTextBitmap.Canvas.Clear(0);
          if Assigned(FOffText) then
          begin
            FOffText.Visible := True;
            FOffText.SetBounds(GetThumbRect.Right * ScreenScale, 0, (Width - GetThumbRect.Width) * ScreenScale, Height * ScreenScale);
            FOffText.PaintTo(FTextBitmap.Canvas, FOffText.ParentedRect);
            FOffText.Visible := False;
          end;
          if Assigned(FOnText) then
          begin
            FOnText.Visible := True;
            FOnText.SetBounds((GetThumbRect.Left - (Width - GetThumbRect.Width)) * ScreenScale, 0,
              (Width - GetThumbRect.Width) * ScreenScale, Height * ScreenScale);
            FOnText.PaintTo(FTextBitmap.Canvas, FOnText.ParentedRect);
            FOnText.Visible := False;
          end;
        finally
          FTextBitmap.Canvas.EndScene;
        end;
      end;
      { render switch }
      if FBitmap.Canvas.BeginScene then
      try
        FBitmap.Canvas.Clear(0);
        FOffObject.Visible := True;
        State := FBitmap.Canvas.SaveState;
        try
          FBitmap.Canvas.IntersectClipRect(RectF(Pos, 0, FBitmap.Width, FBitmap.Height));
          FOffObject.SetBounds(0, 0, Width * ScreenScale, Height * ScreenScale);
          FOffObject.PaintTo(FBitmap.Canvas, RectF(0, 0, Width * ScreenScale, Height * ScreenScale));
        finally
          FBitmap.Canvas.RestoreState(State);
          FOffObject.Visible := False;
        end;

        FOnObject.Visible := True;
        State := FBitmap.Canvas.SaveState;
        try
          FBitmap.Canvas.IntersectClipRect(RectF(0, 0, Pos, FBitmap.Height));
          FOnObject.SetBounds(0, 0, Width * ScreenScale, Height * ScreenScale);
          FOnObject.PaintTo(FBitmap.Canvas, FOnObject.LocalRect);
        finally
          FBitmap.Canvas.RestoreState(State);
          FOnObject.Visible := False;
        end;
        { render text }
        if Assigned(FTextBitmap) and Assigned(FMaskBitmap) then
          FBitmap.Canvas.DrawBitmap(FTextBitmap, RectF(6, 0, FTextBitmap.Width - 6, FTextBitmap.Height), RectF(6, 0, FTextBitmap.Width - 6, FTextBitmap.Height), AbsoluteOpacity, True);
      finally
        FBitmap.Canvas.EndScene;
      end;
    end;
  end
  else
  begin
    if (Orientation = TOrientation.orHorizontal) then
    begin
      Pos := (GetThumbRect.Left + GetThumbRect.Right) / 2;
      if FBitmap.Canvas.BeginScene then
      try
        FBitmap.Canvas.Clear(0);
        FBitmap.Canvas.FillRect(RectF(0, 0, Pos, FBitmap.Height), 0, 0, [], 1, FOnBrush);
        FBitmap.Canvas.FillRect(RectF(Pos, 0, FBitmap.Width, FBitmap.Height), 0, 0, [], 1, FOffBrush);
      finally
        FBitmap.Canvas.EndScene;
      end;
    end
    else
    begin
      Pos := (GetThumbRect.Top + GetThumbRect.Bottom) / 2;
      if FBitmap.Canvas.BeginScene then
      try
        FBitmap.Canvas.Clear(0);
        M := CreateRotationMatrix(DegToRad(90));
        M.m31 := FBitmap.Width;
        FBitmap.Canvas.SetMatrix(M);
        FBitmap.Canvas.FillRect(RectF(0, 0, Pos, FBitmap.Width), 0, 0, [], 1, FOnBrush);
        FBitmap.Canvas.FillRect(RectF(Pos, 0, FBitmap.Height, FBitmap.Width), 0, 0, [], 1, FOffBrush);
      finally
        FBitmap.Canvas.EndScene;
      end;
    end;
  end;
end;

type
  TScrollValueRange = class (TValueRange)
  private
    FScroll: TScrollBar;
    FValueChanged: boolean;
  protected
    function FrequencyStored: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Clear; override;
    procedure DoBeforeChange; override;
    procedure DoAfterChange; override;
  end;

{ TScrollValueRange }

constructor TScrollValueRange.Create(AOwner: TComponent);
begin
  if not (AOwner is TScrollBar) then
    raise EActionError.CreateFMT(StrEUseHeirs, [TScrollBar.ClassName]);
  inherited;
  FScroll := TScrollBar(AOwner);
end;

procedure TScrollValueRange.DoBeforeChange;
begin
  inherited;
  FValueChanged := not SameValue(Value, New.Value);
end;

function TScrollValueRange.FrequencyStored: Boolean;
begin
  Result := Frequency = 1;
end;

procedure TScrollValueRange.Clear;
begin
  BeginUpdate;
  try
    inherited;
    Frequency := 1;
  finally
    EndUpdate;
  end;
end;

procedure TScrollValueRange.DoAfterChange;
begin
  if (not FScroll.FTrackChanging) and Assigned(FScroll.FTrack) then
  begin
    FScroll.FTrackChanging := True;
    try
      FScroll.FTrack.ValueRange.Assign(self);
    finally
      FScroll.FTrackChanging := False;
    end;
  end;
  inherited;
  if (FValueChanged) then
    FScroll.DoChanged;
end;

{ TScrollBar }

constructor TScrollBar.Create(AOwner: TComponent);
begin
  inherited;
  FValueRange := TScrollValueRange.Create(self);
  FDefaultValueRange := TBaseValueRange.Create;
  FValueRange.Frequency := 0;
  SetAcceptsControls(False);
end;

destructor TScrollBar.Destroy;
begin
  FreeAndNil(FDefaultValueRange);
  FreeAndNil(FValueRange);
  inherited;
end;

procedure TScrollBar.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('TabOrder', IgnoreIntegerValue, nil, False);
end;

procedure TScrollBar.AfterConstruction;
begin
  inherited;
  DefaultValueRange.Assign(FValueRange.New);
end;

procedure TScrollBar.Loaded;
begin
  if not (csDestroying in ComponentState) then
  begin
    if FValueRange.IsChanged then
      FValueRange.Changed(True);
  end;
  inherited;
end;

function TScrollBar.GetData: TValue;
begin
  Result := Value;
end;

function TScrollBar.GetDefaultSize: TSizeF;
var
  DefMetricsSrv: IFMXDefaultMetricsService;
begin
  if SupportsPlatformService(IFMXDefaultMetricsService, IInterface(DefMetricsSrv)) and DefMetricsSrv.SupportsDefaultSize(ckScrollBar) then
    Result := TSizeF.Create(DefMetricsSrv.GetDefaultSize(ckScrollBar).Width, DefMetricsSrv.GetDefaultSize(ckScrollBar).Height)
  else
    Result := TSizeF.Create(150, 18);
end;

procedure TScrollBar.SetData(const Value: TValue);
begin
  if Value.IsType<TNotifyEvent> then
    OnChange := Value.AsType<TNotifyEvent>()
  else if Value.IsOrdinal then
    Self.Value := Value.AsOrdinal
  else if Value.IsType<Single> then
    Self.Value := Value.AsType<Single>
  else
    Self.Value := Min
end;

procedure TScrollBar.TrackChangedProc(Sender: TObject);
begin
  if not FTrackChanging then
  begin
    FTrackChanging := True;
    try
      FValueRange.Assign(FTrack.FValueRange);
    finally
      FTrackChanging := False;
    end;
  end;
end;

procedure TScrollBar.FreeTrack;
begin
  if not FTrackChanging then
  begin
    FTrackChanging := True;
    try
      if FTrack <> nil then
      begin
        FTrack.ValueRange.OnChanged := nil;
        if FTrack.ValueRange.IsChanged then
          FTrack.ValueRange.Changed;
        FValueRange.Assign(FTrack.ValueRange);
        FTrack.Action := nil;
        FTrack := nil;
      end;
    finally
      FTrackChanging := False;
    end;
  end;
end;

procedure TScrollBar.ApplyStyle;
var
  T: TFmxObject;
  HT, VT: TCustomTrack;
  LB, TB: TCustomButton;
  RB, BB: TCustomButton;
  SystemInfoSrv: IFMXSystemInformationService;

  procedure UpdateTrack;
  begin
    FreeTrack;
    FTrackChanging := True;
    try
      if FValueRange.IsChanged then
        FValueRange.Changed;
      if Orientation = TOrientation.orVertical then
        FTrack := VT
      else
        FTrack := HT;
      if FTrack <> nil then
      begin
        if Action is TCustomValueRangeAction then
          FTrack.Action := Action
        else
          FTrack.ValueRange.Assign(FValueRange);
        if FTrack.ValueRange.IsChanged then
          FTrack.ValueRange.Changed;
        FTrack.ValueRange.OnChanged := TrackChangedProc;
      end;
    finally
      FTrackChanging := False;
    end;
  end;
begin
  inherited;
  HT := nil;
  VT := nil;
  T := FindStyleResource('htrack');
  if not Assigned(T) then
    T := FindStyleResource('track');
  if Assigned(T) and (T is TCustomTrack) then
  begin
    HT := TCustomTrack(T);
    HT.FOrientation := TOrientation.orHorizontal;
    HT.Max := Max;
    HT.Min := Min;
    HT.Value := Value;
    HT.ViewportSize := ViewportSize;
    HT.Visible := Orientation = TOrientation.orHorizontal;
    HT.CanFocus := False;
    if TPlatformServices.Current.SupportsPlatformService(IFMXSystemInformationService, IInterface(SystemInfoSrv)) then
      HT.FMinThumbSize := SystemInfoSrv.GetMinScrollThumbSize;
    if HT.Visible then
      HT.Realign;
  end;
  T := FindStyleResource('vtrack');
  if not Assigned(T) then
    T := FindStyleResource('track');
  if Assigned(T) and (T is TCustomTrack) then
  begin
    VT := TCustomTrack(T);
    VT.FOrientation := TOrientation.orVertical;
    VT.Max := Max;
    VT.Min := Min;
    VT.Value := Value;
    VT.ViewportSize := ViewportSize;
    VT.Visible := Orientation = TOrientation.orVertical;
    VT.CanFocus := False;
    if TPlatformServices.Current.SupportsPlatformService(IFMXSystemInformationService, IInterface(SystemInfoSrv)) then
      VT.FMinThumbSize := SystemInfoSrv.GetMinScrollThumbSize;
    if VT.Visible then
      VT.Realign;
  end;
  if not FTrackChanging then
    UpdateTrack;
  TB := nil;
  LB := nil;
  T := FindStyleResource('leftbutton');
  if Assigned(T) and (T is TCustomButton) then
  begin
    LB := TCustomButton(T);
    LB.OnClick := DoMinButtonClick;
    LB.Visible := Orientation = TOrientation.orHorizontal;
    LB.CanFocus := False;
    LB.RepeatClick := True;
  end;

  T := FindStyleResource('topbutton');
  if Assigned(T) and (T is TCustomButton) then
  begin
    TB := TCustomButton(T);
    TB.OnClick := DoMinButtonClick;
    TB.Visible := Orientation = TOrientation.orVertical;
    TB.CanFocus := False;
    TB.RepeatClick := True;
  end;

  if Orientation = TOrientation.orVertical then
    FMinButton := TB
  else
    FMinButton := LB;

  RB := nil;
  BB := nil;
  T := FindStyleResource('rightbutton');
  if Assigned(T) and (T is TCustomButton) then
  begin
    RB := TCustomButton(T);
    RB.OnClick := DoMaxButtonClick;
    RB.Visible := Orientation = TOrientation.orHorizontal;
    RB.CanFocus := False;
    RB.RepeatClick := True;
  end;

  T := FindStyleResource('bottombutton');
  if Assigned(T) and (T is TCustomButton) then
  begin
    BB := TCustomButton(T);
    BB.OnClick := DoMaxButtonClick;
    BB.Visible := Orientation = TOrientation.orVertical;
    BB.CanFocus := False;
    BB.RepeatClick := True;
  end;

  if Orientation = TOrientation.orVertical then
  begin
    FMaxButton := BB;
    MinClipHeight := 29;
    MinClipWidth := 8;
  end
  else
  begin
    FMaxButton := RB;
    MinClipHeight := 8;
    MinClipWidth := 29;
  end;
end;

procedure TScrollBar.FreeStyle;
begin
  FreeTrack;
  FMinButton := nil;
  FMaxButton := nil;
  inherited;
end;

function TScrollBar.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.PositionLinkID then
    Result := True;
end;

procedure TScrollBar.DoSmallChange(N: integer);
var Inc: Double;
    P: integer;
begin
  if N <> 0 then
  begin
    Inc := SmallChange;
    if Inc <= 0 then
    begin
      P := Round(Log10(Max - Min) - 1.5);
      Inc := RoundTo(Power(10, P), P);
    end;
    if not SameValue(Inc, 0) then
    begin
      Inc := Inc * N;
      Value := Value + Inc;
      if Observers.IsObserving(TObserverMapping.PositionLinkID) then
        TLinkObservers.PositionLinkPosChanged(Observers);
    end;
  end;
end;

procedure TScrollBar.DoMinButtonClick(Sender: TObject);
begin
  DoSmallChange(-1);
end;

procedure TScrollBar.DoMaxButtonClick(Sender: TObject);
begin
  DoSmallChange(1);
end;

function TScrollBar.GetActionLinkClass: TActionLinkClass;
begin
  Result := TValueRangeActionLink;
end;

function TScrollBar.DefStored: boolean;
begin
  if (FTrack <> nil) then
    Result := FTrack.DefStored
  else
    Result := True;
end;

function TScrollBar.MaxStored: Boolean;
begin
  Result := DefStored and (not SameValue(Max, DefaultValueRange.Max));
end;

function TScrollBar.MinStored: Boolean;
begin
  Result := DefStored and (not SameValue(Min, DefaultValueRange.Min));
end;

function TScrollBar.ValueStored: Boolean;
begin
  Result := DefStored and (not SameValue(Value, DefaultValueRange.Value));
end;

function TScrollBar.ViewportSizeStored: Boolean;
begin
  Result := DefStored and (not SameValue(ViewportSize, DefaultValueRange.ViewportSize));
end;

procedure TScrollBar.DoActionClientChanged;
begin
  inherited;
  if (FTrack <> nil) and (not ActionClient) then
    FTrack.Action := nil;
end;

procedure TScrollBar.ActionChange(Sender: TBasicAction;
  CheckDefaults: Boolean);
begin
  if FTrack <> nil then
    FTrack.Action := Sender;
  inherited;
end;

function TScrollBar.GetValueRange: TValueRange;
begin
  Result := FValueRange;
end;

procedure TScrollBar.SetValueRange(const Value: TValueRange);
begin
  FValueRange.Assign(Value);
end;

function TScrollBar.GetMax: Single;
begin
  Result := FValueRange.Max;
end;

function TScrollBar.GetMin: Single;
begin
  Result := FValueRange.Min;
end;

function TScrollBar.GetValue: Single;
begin
  Result := FValueRange.Value;
end;

function TScrollBar.GetViewportSize: Single;
begin
  Result := FValueRange.ViewportSize;
end;

procedure TScrollBar.SetMax(const Value: Single);
begin
  FValueRange.Max := Value;
end;

procedure TScrollBar.SetMin(const Value: Single);
begin
  FValueRange.Min := Value;
end;

procedure TScrollBar.SetValue(const Value: Single);
begin
  FValueRange.Value := Value;
end;

procedure TScrollBar.SetViewportSize(const Value: Single);
begin
  FValueRange.ViewPortSize := Value;
end;

procedure TScrollBar.SetOrientation(const Value: TOrientation);
var
  T: Single;
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    // swap
    if ([csDestroying, csLoading] * ComponentState) = [] then
    begin
      T := Width;
      Width := Height;
      Height := T;
    end;
    DoStyleChanged;
  end;
end;

procedure TScrollBar.DoChanged;
begin
  if Assigned(FOnChange) and (not (csLoading in ComponentState)) then
    FOnChange(self);
  if Observers.IsObserving(TObserverMapping.PositionLinkID) then
    TLinkObservers.PositionLinkPosChanged(Observers);
end;

function TScrollBar.SmallChangeStored: Boolean;
begin
  Result := (Not SameValue(SmallChange, 1));
end;

function TScrollBar.GetSmallChange: Single;
begin
  Result := FSmallChange;
end;

procedure TScrollBar.SetSmallChange(const Value: Single);
begin
  FSmallChange := Value;
end;

{ TSmallScrollBar }

constructor TSmallScrollBar.Create(AOwner: TComponent);
begin
  inherited;
end;

function TSmallScrollBar.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(150, 8);
end;

procedure TSmallScrollBar.ApplyStyle;
begin
  inherited;
  MinClipWidth := 8;
  MinClipHeight := 8;
end;

{ TAniIndicator }

constructor TAniIndicator.Create(AOwner: TComponent);
begin
  inherited;
  FFill := TBrush.Create(TBrushKind.bkSolid, $FFBABABA);
  Enabled := False;
  SetAcceptsControls(False);
end;

procedure TAniIndicator.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('TabOrder', IgnoreIntegerValue, nil, False);
end;

destructor TAniIndicator.Destroy;
begin
  if Assigned(FFill) then
    FreeAndNil(FFill);
  inherited;
end;

procedure TAniIndicator.ApplyStyleLookup;
begin
  if IsNeedStyleLookup then
  begin
    inherited;
    if not Assigned(FAni) then
    begin
      FLayout := TControl.Create(Self);
      FLayout.Parent := Self;
      FLayout.Align := TAlignLayout.alContents;
      FLayout.Locked := True;
      FLayout.Stored := False;
      FAni := TFloatAnimation.Create(Self);
      FAni.Parent := FLayout;
      FAni.Loop := True;
      TFloatAnimation(FAni).StartValue := 0;
      TFloatAnimation(FAni).StopValue := 360;
      TFloatAnimation(FAni).Duration := 10;
      TFloatAnimation(FAni).PropertyName := 'RotationAngle';
    end;
    if csDesigning in ComponentState then
    begin
      FAni.Start;
      FAni.Stop;
    end
    else if Enabled then
      FAni.Start
    else
      FAni.Stop;
  end
  else
    inherited;
end;

procedure TAniIndicator.ApplyStyle;
var
  O: TFmxObject;
  BO: IBrushObject;
begin
  inherited;
  O := FindStyleResource('text');
  if Assigned(O) and (O is TText) then
  begin
    TText(O).Text := '';
    FFill.Kind := TBrushKind.bkSolid;
    FFill.Color := TText(O).Color;
  end;
  O := FindStyleResource('fill');
  if Assigned(O) and Supports(O, IBrushObject, BO) then
    FFill.Assign(BO.Brush);
  O := FindStyleResource('ani');
  if Assigned(O) and (O is TAnimation) then
    FAni := TAnimation(O);
end;

procedure TAniIndicator.FreeStyle;
begin
  FreeAndNil(FLayout);
  FAni := nil;
  inherited;
end;

procedure TAniIndicator.Paint;
var
  a: Integer;
  P, P2: TPointF;
  wSize, eSize: Single;
  V: Single;
  Fill: TBrush;
  Stroke: TStrokeBrush;
begin
  if not Assigned(FLayout) then Exit;

  if Width < Height then
    wSize := Width / 2
  else
    wSize := Height / 2;
  eSize := wSize / 3.7;
  wSize := wSize - eSize;

  case FStyle of
    TAniIndicatorStyle.aiLinear:
      begin
        Stroke := TStrokeBrush.Create(TBrushKind.bkSolid, FFill.Color);
        Stroke.Thickness := eSize / 2;
        for a := 0 to 11 do
        begin
          P := PointF(Width / 2 + (cos(DegToRad(a * 30)) * wSize), Height / 2 + (sin(DegToRad(a * 30)) * wSize));
          P2 := PointF(Width / 2 + (cos(DegToRad(a * 30)) * (wSize / 2)), Height / 2 + (sin(DegToRad(a * 30)) * (wSize / 2)));
          Canvas.DrawLine(P, P2, Opacity * 0.2, Stroke);
          if Enabled then
          begin
            V := ((trunc(FLayout.RotationAngle) + (30 - trunc((a / 12) * 30))) mod 30) / 30;
            if V > 1 then
              V := Abs(V - 2);
            V := 1 - V;
            Canvas.DrawLine(P, P2, V * Opacity, Stroke);
          end;
        end;
        Stroke.Free;
      end;
    TAniIndicatorStyle.aiCircular:
      begin
        Fill := TBrush.Create(TBrushKind.bkSolid, FFill.Color);
        for a := 0 to 7 do
        begin
          P := PointF(Width / 2 + (cos(DegToRad(a * 45)) * wSize), Height / 2 + (sin(DegToRad(a * 45)) * wSize));
          Canvas.FillEllipse(RectF(P.X - eSize, P.Y - eSize, P.X + eSize, P.Y + eSize), Opacity * 0.2, Fill);
          if Enabled then
          begin
            V := ((trunc(FLayout.RotationAngle) + (30 - trunc((a / 7) * 30))) mod 30) / 30;
            if V > 1 then
              V := Abs(V - 2);
            V := 1 - V;
            Canvas.FillEllipse(RectF(P.X - eSize, P.Y - eSize, P.X + eSize, P.Y + eSize), V * Opacity, Fill);
          end;
        end;
        Fill.Free;
      end;
  end;
end;

procedure TAniIndicator.SetEnabled(const Value: Boolean);
begin
  if Enabled <> Value then
  begin
    inherited ;
    if Assigned(FAni) then
    begin
      if Enabled then
        FAni.Start
      else
        FAni.Stop;
    end;
  end;
end;

procedure TAniIndicator.SetStyle(const Value: TAniIndicatorStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Repaint;
  end;
end;

type
  TArcValueRange = class (TValueRange)
  protected
    function MaxStored: Boolean; override;
    function MinStored: Boolean; override;
  public
    procedure Clear; override;
  end;
{ TArcValueRange }

procedure TArcValueRange.Clear;
begin
  BeginUpdate;
  try
    inherited;
    self.Min := -180;
    self.Max := 180;
  finally
    EndUpdate;
  end;
end;

function TArcValueRange.MaxStored: Boolean;
begin
  Result := not SameValue(Max, 180);
end;

function TArcValueRange.MinStored: Boolean;
begin
  Result := not SameValue(Min, -180);
end;

{ TArcDial }

function TArcDial.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.EditLinkID then
    Result := True;
  if ID = TObserverMapping.ControlValueID then
    Result := True;
end;

constructor TArcDial.Create(AOwner: TComponent);
begin
  inherited;
  FOldValue := -360;
  FValueRange := TArcValueRange.Create(self);
  FValueRange.BeforeChange := BeforeChangeProc;
  FValueRange.OnChanged := ValueRangeChangeProc;
  FValueRange.AfterChange := AfterChangedProc;
  FDefaultValueRange := TBaseValueRange.Create;
  FTracking := True;
  AutoCapture := True;
  SetAcceptsControls(False);
end;

destructor TArcDial.Destroy;
begin
  FreeAndNil(FDefaultValueRange);
  FreeAndNil(FValueRange);
  inherited;
end;

procedure TArcDial.AfterConstruction;
begin
  inherited;
  FDefaultValueRange.Assign(ValueRange.New);
end;

function TArcDial.GetData: TValue;
begin
  Result := Value;
end;

function TArcDial.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(30, 30);
end;

function TArcDial.FrequencyStored: Boolean;
begin
  Result := DefStored and (not SameValue(Frequency, DefaultValueRange.Frequency));
end;

function TArcDial.ValueStored: Boolean;
begin
  Result := DefStored and (not SameValue(Value, DefaultValueRange.Value));
end;

function TArcDial.GetFrequency: Single;
begin
  Result := FValueRange.Max - FValueRange.Min - FValueRange.ViewportSize;
  if Result > 0 then
    Result := (360 * FValueRange.Frequency) / Result
  else
    Result := 0;
end;

procedure TArcDial.SetFrequency(const Value: Single);
begin
  FValueRange.Frequency := (Value / 360) * (FValueRange.Max - FValueRange.Min - FValueRange.ViewportSize);
end;

procedure TArcDial.SetData(const Value: TValue);
begin
  if Value.IsType<TNotifyEvent> then
    OnChange := Value.AsType<TNotifyEvent>()
  else if Value.IsOrdinal then
    Self.Value := Value.AsOrdinal
  else if Value.IsType<Single> then
    Self.Value := Value.AsType<Single>
  else
    Self.Value := 0
end;

function TArcDial.GetActionLinkClass: TActionLinkClass;
begin
  Result := TValueRangeActionLink;
end;

procedure TArcDial.ActionChange(Sender: TBasicAction; CheckDefaults: Boolean);
begin
  if Sender is TValueRangeAction then
  begin
    if (not CheckDefaults) or (FValueRange.IsEmpty) then
      FValueRange.Assign(TValueRangeAction(Sender).ValueRange);
  end;
  inherited;
end;

function TArcDial.GetValueRange: TCustomValueRange;
begin
  Result := FValueRange;
end;

procedure TArcDial.Loaded;
begin
  if FValueRange.IsChanged then
    FValueRange.Changed(True);
  inherited;
end;

procedure TArcDial.SetValueRange(const AValue: TCustomValueRange);
begin
  FValueRange.Assign(AValue);
end;

procedure TArcDial.SetValueRange_(const Value: TValueRange);
begin
  FValueRange.Assign(Value);
end;

procedure TArcDial.ApplyStyle;
begin
  inherited;
  Tick;
  Text;
  Realign;
end;

function TArcDial.Tick: TControl;
var
  T: TFmxObject;
begin
  T := FindStyleResource('tick');
  if Assigned(T) and (T is TControl) then
  begin
    Result := TControl(T);
    Result.RotationAngle := -Value;
  end
  else
    Result := nil;
end;

function TArcDial.DefStored: boolean;
begin
  Result := not (ActionClient and
                 (Action is TCustomValueRangeAction));
end;

procedure TArcDial.BeforeChangeProc(Sender: TObject);
begin
  if ActionClient and
    (not DefStored) and
    (not TValueRangeAction(Action).ValueRange.Changing) then
    TValueRangeAction(Action).ValueRange.Assign(FValueRange.New);
  FValueChanged := FValueRange.New.Value <> FValueRange.Value;
end;

procedure TArcDial.ValueRangeChangeProc(Sender: TObject);
var NewValue: single;
begin
  NewValue := Value;
  if not SameValue(NewValue, FOldValue) then
  begin
    FOldValue := NewValue;
    if Tick <> nil then
      Tick.RotationAngle := -NewValue
    else
      Repaint;
    Text;
  end;
end;

procedure TArcDial.AfterChangedProc(Sender: TObject);
begin
  if FValueChanged and
    (Assigned(OnChange)) and
    (not (csLoading in ComponentState)) then
    OnChange(Self);
end;

function TArcDial.Text: TText;
var
  T: TFmxObject;
begin
  T := FindStyleResource('tracktext');
  if Assigned(T) and (T is TText) then
  begin
    TText(T).Visible := False; // FPressing;
    TText(T).Text := IntToStr(Round(Value)) + System.WideChar($B0);
    if FPressing and not FTracking then
      TText(T).Opacity := 1
    else
      TText(T).Opacity := 0;
  end;

  T := FindStyleResource('text');
  if Assigned(T) and (T is TText) then
  begin
    Result := TText(T);
    Result.Visible := FShowValue;
    Result.Text := IntToStr(Round(Value)) + System.WideChar($B0);
    if not FShowValue then
      Result.Opacity := 0
    else
      Result.Opacity := 1;
  end
  else
    Result := nil;
end;

procedure TArcDial.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if Button = TMouseButton.mbLeft then
  begin
    FPressing := True;
    FSaveValue := Value;
    FValueRange.Tracking := Tracking;
    Text;
  end;
end;

procedure TArcDial.MouseMove(Shift: TShiftState; X, Y: Single);
var
  FNewValue: Single;
begin
  inherited;
  if (ssLeft in Shift) and (FPressing) then
  begin
    FNewValue := VectorAngle(Vector(1, 0), Vector(X - (Width / 2), Y - (Height / 2)));
    if (FNewValue <> Value) {and (Abs(Value - FNewValue) < 180)} then
    begin
      Value := FNewValue;
      if Observers.IsObserving(TObserverMapping.EditLinkID) then
      begin
        if TLinkObservers.EditLinkEdit(Observers) then
          TLinkObservers.EditLinkModified(Observers)
        else
        begin
          TLinkObservers.EditLinkReset(Observers);
          Exit;
        end;
      end;
      if Tracking then
      begin
        if Observers.IsObserving(TObserverMapping.EditLinkID) then
          TLinkObservers.EditLinkUpdate(Observers);
        if Observers.IsObserving(TObserverMapping.ControlValueID) then
        begin
          TLinkObservers.ControlValueModified(Observers);
          TLinkObservers.ControlValueUpdate(Observers);
        end;
      end;
    end;
  end;
end;

procedure TArcDial.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if (Button = TMouseButton.mbLeft) and FPressing then
  begin
    FPressing := False;
    FValueRange.Tracking := True;
    Text;
    if Value <> FSaveValue then
    begin
      if Assigned(FOnChange) then
        FOnChange(Self);
      if not Tracking then
      begin
        if Observers.IsObserving(TObserverMapping.EditLinkID) then
          if TLinkObservers.EditLinkIsModified(Observers) then
            TLinkObservers.EditLinkUpdate(Observers);
        if Observers.IsObserving(TObserverMapping.ControlValueID) then
          TLinkObservers.ControlValueUpdate(Observers);
      end;
    end;
  end;
end;

type
  TOpenControl = class(TControl)
  end;

procedure TArcDial.Resize;
begin
  inherited;
  if (Tick <> nil) and (Tick is TControl) then
    TOpenControl(Tick).DoMatrixChanged(Self);
end;

function TArcDial.GetValue: Single;
begin
  Result := (FValueRange.RelativeValue * 360) - 180;
end;

procedure TArcDial.SetValue(const Value: Single);
var Tmp: Extended;
begin
  Tmp := (Value - 180) / 360;
  FValueRange.RelativeValue := (Tmp - Ceil(Tmp)) + 1.0;
end;

procedure TArcDial.SetShowValue(const Value: Boolean);
begin
  if FShowValue <> Value then
  begin
    FShowValue := Value;
    Text;
    Repaint;
  end;
end;

{ TExpanderButton }

constructor TExpanderButton.Create(AOwner: TComponent);
begin
  inherited;
  CanFocus := False;
end;

{ TExpander }

constructor TExpander.Create(AOwner: TComponent);
begin
  inherited;
  AutoTranslate := True;

  FIsExpanded := True;
  FIsChecked := True;

  FContent := TContent.Create(Self);
  FContent.Stored := False;
  FContent.Parent := Self;
  FContent.ClipChildren := False;
  FContent.HitTest := False;
  FContent.Locked := True;
  FContent.Margins.top := 25;
  FContent.Width := Width;
  FContent.Height := Height;
end;

procedure TExpander.DoAddObject(const AObject: TFmxObject);
begin
  if Assigned(FContent) and (AObject <> FContent) and (AObject <> ResourceLink) then
  begin
    FContent.AddObject(AObject);
    AddToTabList(AObject);
  end
  else
    inherited;
end;

procedure TExpander.AddToTabList(const AObject: TFmxObject);
begin
end;

procedure TExpander.ApplyStyle;
var
  O: TFmxObject;
begin
  inherited;
  O := FindStyleResource('checkbox');
  if Assigned(O) and (O is TCheckBox) then
  begin
    FCheck := TCheckBox(O);
    FCheck.Visible := FShowCheck;
    FCheck.IsChecked := FIsChecked;
    FCheck.OnChange := DoCheckChange;
  end;
  O := FindStyleResource('button');
  if Assigned(O) and (O is TCustomButton) then
  begin
    FButton := TCustomButton(O);
    FButton.OnClick := DoButtonClick;
    FButton.ApplyStyleLookup;
    if not IsExpanded then
      FButton.StartTriggerAnimation(Self, 'IsExpanded');
    FButton.CanFocus := False;
  end;
  StartTriggerAnimation(Self, 'IsExpanded');
end;

procedure TExpander.FreeStyle;
begin
  FCheck := nil;
  FButton := nil;
  inherited;
end;

function TExpander.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(200, 200);
end;

procedure TExpander.GetTabOrderList(const List: TInterfaceList;
  AChildren: Boolean);
begin
  if Assigned(FContent) then
    FContent.GetTabOrderList(List, AChildren)
  else
    inherited;
end;

type
  TOpenContent = class(TContent) end;

procedure TExpander.Loaded;
begin
  inherited;
  TOpenContent(FContent).Loaded; // ensure that FixupTabList is called for FContent
end;

procedure TExpander.DoButtonClick(Sender: TObject);
begin
  IsExpanded := not FIsExpanded;
end;

procedure TExpander.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ContentSize', ReadContentSize, WriteContentSize, True);
  Filer.DefineProperty('TabOrder', IgnoreIntegerValue, nil, False);
end;

procedure TExpander.ReadContentSize(Reader: TReader);
begin
  if Assigned(FContent) then
    FContent.Height := StrToInt(Reader.ReadString);
end;

procedure TExpander.WriteContentSize(Writer: TWriter);
begin
  if Assigned(FContent) then
    Writer.WriteString(IntToStr(Round(FContent.Height)));
end;

procedure TExpander.DoRealign;
begin
  inherited;
  if csLoading in ComponentState then
    Exit;
  if FDisableAlign then
    Exit;
  FDisableAlign := True;
  { content }
  if Assigned(FContent) and (IsExpanded) then
  begin
    FContent.Position.X := 0;
    FContent.Position.Y := FContent.Margins.top;
    FContent.Width := Width;
    FContent.Height := Height - FContent.Margins.top;
  end;
  FDisableAlign := False;
end;

procedure TExpander.SetIsExpanded(const Value: Boolean);
begin
  if FIsExpanded <> Value then
  begin
    if not (csLoading in ComponentState) then
      ApplyStyleLookup;
    FIsExpanded := Value;
    if FIsExpanded then
    begin
      FContent.Visible := FIsExpanded;
      if Assigned(FButton) then
        Height := FButton.Height + FContent.Height;
      Repaint;
    end
    else
    begin
      Repaint;
      FContent.Visible := FIsExpanded;
      if Assigned(FButton) then
        Height := FButton.Height;
    end;
    StartTriggerAnimation(Self, 'IsExpanded');
    if Assigned(FButton) then
      FButton.StartTriggerAnimation(Self, 'IsExpanded');
  end;
end;

procedure TExpander.DoCheckChange(Sender: TObject);
begin
  if Assigned(FCheck) then
  begin
    FIsChecked := FCheck.IsChecked;
    FContent.Enabled := FIsChecked;
    if Assigned(OnCheckChange) then
      OnCheckChange(Self);
  end;
end;

procedure TExpander.SetIsChecked(const Value: Boolean);
begin
  if FIsChecked <> Value then
  begin
    FIsChecked := Value;
    FContent.Enabled := FIsChecked;
    if Assigned(FCheck) then
      FCheck.IsChecked := FIsChecked;
  end;
end;

procedure TExpander.SetShowCheck(const Value: Boolean);
begin
  if FShowCheck <> Value then
  begin
    FShowCheck := Value;
    if Assigned(FCheck) then
      FCheck.Visible := FShowCheck;
  end;
end;

{ TImageControl }

constructor TImageControl.Create(AOwner: TComponent);
begin
  inherited;
  CanFocus := True;
  FEnableOpenDialog := True;
  FBitmap := TBitmap.Create(0, 0);
  FBitmap.OnChange := DoBitmapChanged;
  SetAcceptsControls(False);
  EnableExecuteAction := True;
end;

destructor TImageControl.Destroy;
begin
  if Assigned(FBitMap) then
    FreeAndNil(FBitmap);
  inherited;
end;

function TImageControl.GetData: TValue;
begin
  Result := Bitmap;
end;

function TImageControl.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(100, 100);
end;

procedure TImageControl.SetData(const Value: TValue);
begin
  if Value.IsEmpty then
    Bitmap.SetSize(0, 0)
  else if (Value.IsObject) and (Value.AsObject is TPersistent) then
    Bitmap.Assign(TPersistent(Value.AsObject))
  else 
    Bitmap.LoadFromFile(Value.ToString)
end;

procedure TImageControl.ApplyStyle;
var
  O: TFmxObject;
begin
  inherited;
  O := FindStyleResource('image');
  if Assigned(O) and (O is TImage) then
  begin
    FImage := TImage(O);
    FImage.Bitmap.Assign(FBitmap);
  end;
end;

procedure TImageControl.FreeStyle;
begin
  FImage := nil;
  inherited;
end;

function TImageControl.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  //  Note that the user code is responsible for calling
  //  TLinkObservers.ControlChanged modifying the image
  if ID = TObserverMapping.EditLinkID then
    Result := True;
end;

procedure TImageControl.Click;
var
  D: TOpenDialog;
begin
  inherited;
  if not FEnableOpenDialog then
    Exit;
  D := TOpenDialog.Create(nil);
  try
    D.Filter := TBitmapCodecManager.GetFilterString;
    if D.Execute then
      Bitmap.LoadFromFile(D.FileName);
  finally
    D.Free;
  end;
end;

procedure TImageControl.DragOver(const Data: TDragObject; const Point: TPointF; var Accept: Boolean);
begin
  inherited;
  // accept correct image file or TImage
  Accept := ((Length(Data.Files) > 0) and FileExists(Data.Files[0]) and
    (TBitmapCodecManager.IsCodedExists(Data.Files[0]))) or (Data.Source is TImage);
end;

procedure TImageControl.DragDrop(const Data: TDragObject; const Point: TPointF);
begin
  inherited;
  if Data.Source is TImage then
  begin
    Bitmap.Assign(TImage(Data.Source).Bitmap);
  end
  else if Length(Data.Files) > 0 then
  begin
    Bitmap.LoadFromFile(Data.Files[0]);
  end;
end;

procedure TImageControl.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
end;

procedure TImageControl.DoBitmapChanged(Sender: TObject);
var
  R: TRectF;
begin
  if Assigned(FImage) and not FBitmap.IsEmpty then
  begin
    { create thumbnail }
    R := RectF(0, 0, FBitmap.Width, FBitmap.Height);
    R.Fit(RectF(0, 0, FImage.Width, FImage.Height));
    FImage.Bitmap.SetSize(Round(RectWidth(R)), Round(RectHeight(R)));
    if FImage.Bitmap.Canvas.BeginScene then
    try
      FImage.Bitmap.Canvas.Clear(0);
      FImage.Bitmap.Canvas.DrawBitmap(FBitmap, RectF(0, 0, FBitmap.Width, FBitmap.Height),
        RectF(0, 0, FImage.Bitmap.Width, FImage.Bitmap.Height), 1);
    finally
      FImage.Bitmap.Canvas.EndScene;
    end;
    FImage.Repaint;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

{ TPathLabel }

constructor TPathLabel.Create(AOwner: TComponent);
begin
  inherited;
  HitTest := False;
  FPath := TPath.Create(nil);
  FPath.Parent := Self;
  FPath.Stored := False;
  FPath.Locked := True;
  FPath.HitTest := False;
  FPath.Align := TAlignLayout.alContents;
  SetAcceptsControls(False);
end;

procedure TPathLabel.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('TabOrder', IgnoreIntegerValue, nil, False);
end;

destructor TPathLabel.Destroy;
begin
  if Assigned(FPath) then
    FreeAndNil(FPath);
  inherited;
end;

procedure TPathLabel.ApplyStyle;
var
  O: TFmxObject;
begin
  inherited;
  O := FindStyleResource('text');
  if Assigned(O) and (O is TText) then
  begin
    TText(O).Text := '';
    if Assigned(FPath) then
    begin
      FPath.Fill.Kind := TBrushKind.bkSolid;
      FPath.Fill.Color := TText(O).Color;
      FPath.Stroke.Kind := TBrushKind.bkNone;
    end;
  end;
end;

procedure TPathLabel.FreeStyle;
begin
  inherited;
end;

function TPathLabel.GetPathData: TPathData;
begin
  Result := FPath.Data;
end;

function TPathLabel.GetWrapMode: TPathWrapMode;
begin
  Result := FPath.WrapMode;
end;

procedure TPathLabel.SetPathData(const Value: TPathData);
begin
  FPath.Data.Assign(Value);
end;

procedure TPathLabel.SetWrapMode(const Value: TPathWrapMode);
begin
  FPath.WrapMode := Value;
end;

initialization
  RegisterFmxClasses([TThumb, TExpanderButton, TSizeGrip,TCheckBox, TRadioButton,
    TGroupBox, TPanel, TCalloutPanel, TLabel, TImageControl, TPathLabel, TProgressBar,
    TTrack, TScrollBar, TSmallScrollBar, TAniIndicator, TExpander, TTrackBar, TSplitter,
    TStatusBar, TToolBar, TButton, TSpeedButton, TArcDial, TSwitch, TCornerButton]);
end.
