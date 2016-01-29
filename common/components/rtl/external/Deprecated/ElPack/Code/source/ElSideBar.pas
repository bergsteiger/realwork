{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

(*

Version History

07/06/2003

  BorderColor* properties added. They control the colors of the border, drawn when Flat is true.

02/15/2003

  Added ArrowColor property.

12/15/2002

  Scroll button arrows are drawn with font color now.

12/04/2002

  ScrollButtonColor property added
  Now scroll buttons are filled with background color only when background mode is bgtColorFill

08/21/2002 (c) Akzhan Abdulin

  Some property defaults added.

05/22/2002

  Scrolling the items with mouse wheel now works only when the corresponding arrow is present

05/02/2002

  SectionsFont settings were ignored in run-time. Fixed.

03/10/2002

  Removed flicker introduced during CLX porting
  Fixed AutoScroll that was broken during CLX porting
  Improved drawing of border in with XP styles enabled

03/06/2002

  Added unicode hint

01/06/2002

  Fixed painting of text in CLX version with XP styles enabled

10/25/2001

  Fixed painting of the borders with XP styles enabled

07/26/2001

  Added Unicode support

07/15/2001 (c) Akzhan Abdulin

  Adapted to allow image index property editor

  Potential bug fixed (FBar field was duplicated in descendant)

07/12/2001

  BorderSides property added.

06/29/2001

  Now items with #13#10 are drawn multiline when WordWrap is off.

03/10/2001

  Fixed possible AVs that could happen when image list is removed.

  Minor optimizations and readness improvements.

01/26/2001

    When AutoSelectItem is false, the OnItemChange event is not fired now (!)

01/22/2001

    ChangeDelay property added.

11/08/2000

  ContainsControls made obsolete

10/11/2000

  OnItemChange event was not fired when the item was changed by a keypress. Fixed.


07/03/2000

  TElSidebarSection.Inactive property added. Inactive section can't be clicked
and can't be highlighted on tracking.

07/01/2000

  CMControlChange changed to fix the bug with ContainsControls when attempt to
create a panel causes an exception.


*)
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

unit ElSideBar;

interface

uses
  Windows,
  Messages,
  Graphics,
  Controls,
  StdCtrls,
  Forms,
  ExtCtrls,
  Menus,
  CommCtrl,
{$ifdef VCL_6_USED}
Types,
{$endif}
  SysUtils,
  Classes,
  ElPanel,
  ElVCLUtils,
  ElStrUtils,
  ElTools,
  ElSndMap,
  ElUxtheme,
  ElTmSchema,
{$IFDEF VCL_4_USED}
  ImgList,
{$ENDIF}
  ElExtBkgnd,
  ElIni;

type
  TElSideBarSection = class;
  TElSideBarSections = class;
  TElSideBar = class;
  TElSideBarItems = class;
  TElSideBarItem  = class;

  TElSideBarPart = (sbpSection, sbpItemImage, sbpItemText, sbpUpScroll, sbpDownScroll, sbpInside);
  TElSideBarIconLocation = (ilLeft, ilTop);

  TElSideBarContainerPanel = class(TElPanel)
  protected
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHitTest;
    procedure CreateParams(var Params : TCreateParams); override;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property Left stored False;
    property Top stored False;
    property Width stored False;
    property Height stored False;
    property Align stored False;
    property BevelOuter stored False;
    property MouseCapture stored False;
    property Visible stored False;
    {$ifdef VCL_4_USED}
    property DockOrientation stored False;
    property DoubleBuffered stored False;
    {$endif}
  end;

  TElSideBarCItem = class(TCollectionItem)
  private
    FBar : TElSideBar;
    FVisible : Boolean;
    FEnabled : Boolean;
    FImageIndex : Integer;
    FCaption: TElFString;
    FTag : Integer;
    FHint: TElFString;
    FTextRect  : TRect;
    FBoundRect : TRect;
    FPartial   : boolean;
    procedure SetVisible(newValue : Boolean);
    procedure SetEnabled(newValue : Boolean);
    procedure SetImageIndex(newValue : Integer);
    procedure SetCaption(newValue: TElFString);
  protected
    function GetBar: TElSideBar;
    function GetOwner : TPersistent; override;
    function GetDisplayName: string; override;
  public
    Active,
    Hidden,
    Disabled  : boolean; // Don't matter. Used only by design-time editor

    Data      : Pointer; // User-defined data.

    constructor Create(Collection : TCollection); override;
    procedure Assign(Source : TPersistent); override;
  published
    property Index;
    property Tag : Integer read FTag write FTag default 0;  { Published }
    property Hint: TElFString read FHint write FHint;
    property Visible : Boolean read FVisible write SetVisible default true;  { Published }
    property Enabled : Boolean read FEnabled write SetEnabled default true;  { Published }
    property ImageIndex : Integer read FImageIndex write SetImageIndex default -1;   { Published }
    property Caption: TElFString read FCaption write SetCaption;
  end;

  TElSideBarItem = class(TElSideBarCItem)
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
  end;

{$warnings off}
  TElSideBarItems = class(TCollection)
  private
    FSection : TElSideBarSection;
    function GetItems(index : integer) : TElSideBarItem;
    procedure SetItems(index: integer; newValue : TElSideBarItem);
  protected
    function GetOwner : TPersistent; override;
    procedure Update(Item : TCollectionItem); override;
  public
    function Add : TElSideBarItem;
    constructor Create(Section : TElSideBarSection);
    property Items[index : integer] : TElSideBarItem read GetItems write SetItems; default; { Public }
  end;
{$warnings on}

  TElSideBarSection = class(TElSideBarCItem)
  private
    FContainsControls : Boolean;
    FItems    : TElSideBarItems;
    FSections : TElSideBarSections;
//    FBar      : TElSideBar;
    FPanel    : TElSideBarContainerPanel;
    FInactive : boolean;
    procedure SetItems(newValue : TElSideBarItems);
    procedure SetContainsControls(newValue : Boolean);
    procedure AllocatePanel;
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source : TPersistent); override;

    property Panel : TElSideBarContainerPanel read FPanel;
  published
    property Inactive : boolean read FInactive write FInactive default False;
    property Items : TElSideBarItems read FItems write SetItems;  { Published }
    property ContainsControls : Boolean read FContainsControls write SetContainsControls default False;  { Published }
  end;

{$warnings off}
  TElSideBarSections = class(TCollection)
  private
    FBar : TElSideBar;
    function GetItems(index : integer) : TElSideBarSection;
    procedure SetItems(index : integer; newValue : TElSideBarSection);
  protected
    function GetOwner : TPersistent; override;
  public
    constructor Create(Bar : TElSideBar);
    function Add : TElSideBarSection;
    procedure Update(Item : TCollectionItem); override;
    property Items[index : integer] : TElSideBarSection read GetItems write SetItems; default; { Published }
  end;
{$warnings on}

  TElSideBar = class (TCustomElPanel)
  private
    FVisibleSections : Boolean;
    FItemsFont: TFont;
    FFlatSections: Boolean;
    FFlatItems: Boolean;
    FFlatActiveItem: boolean;
    FFlat : Boolean;
    FUpdateCount : Integer;
{$IFDEF USE_SOUND_MAP}
    FSoundMap : TElSoundMap;
{$ENDIF}
    FSectionImages : TImageList;
    FSectionHotImages : TImageList;
    FSectionDisabledImages : TImageList;
    FItemDisabledImages : TImageList;
    FItemImages: TImageList;
    FItemHotImages : TImageList;

    FAlphaSectionImages : TImageList;
    FAlphaSectionHotImages : TImageList;
    FAlphaSectionDisabledImages : TImageList;
    FAlphaItemDisabledImages : TImageList;
    FAlphaItemImages: TImageList;
    FAlphaItemHotImages : TImageList;
    FSectionTracking : Boolean;
    FItemTracking : Boolean;
    FUnderlineTracked : Boolean;
    FMouseOver : Boolean;
    FSections  : TElSideBarSections;

    FVisUpBtn,
    FVisDownBtn: boolean;
    FUpBtnPressed,
    FDownBtnPressed: boolean;
    FSaveUpBtnPressed,
    FSaveDownBtnPressed: boolean;

    FActiveSectionStyle: TFontStyles;
    FActiveItemStyle: TFontStyles;

    FTrackSectionFontColor,
    FTrackSectionBkColor,
    FTrackItemFontColor,
    FTrackItemBkColor : TColor;

    FSaveCapture   : HWND;
    FPressed       : boolean;
    //Scrolling
    FAutoScroll    : boolean;
{    FScrollPos,
    FScrollFrom,
    FScrollTo : integer;
}
    Registered    : boolean;
    //current selections
    FTopItem      : TElSideBarItem;
    FSection      : TElSideBarSection;
    FItem         : TElSideBarItem;
    FTrackSection : TElSideBarSection;
    FTrackItem    : TElSideBarItem;
    FDownSection  : TElSideBarSection;
    FDownItem     : TElSideBarItem;
    FSaveDownSection : TElSideBarSection;
    FSaveDownItem    : TElSideBarItem;

    FSImagesLink  : TChangeLink;
    FIImagesLink  : TChangeLink;
    FSDImagesLink : TChangeLink;
    FIDImagesLink : TChangeLink;
    FSHImagesLink : TChangeLink;
    FIHImagesLink : TChangeLink;
    FASImagesLink  : TChangeLink;
    FAIImagesLink  : TChangeLink;
    FASDImagesLink : TChangeLink;
    FAIDImagesLink : TChangeLink;
    FASHImagesLink : TChangeLink;
    FAIHImagesLink : TChangeLink;

    FItemsPopup,
    FSectionsPopup: TPopupMenu;

    FSectionHeight : Integer;
    FSectionsColor: TColor;
    FWordWrap     : Boolean;
    FSpacing      : Integer;
    FTopSpacing   : Integer;
    FScrollDelay  : Integer;
    //FScrolling    : boolean;
    FScrollTimer  : TTimer;
    FItemChangeSound : TElSoundName;
    FSectionChangeSound : TElSoundName;
    FItemSize : Integer;
    FRightAlignedBar : Boolean;

    FOnItemChange : TNotifyEvent;
    FOnSectionChange : TNotifyEvent;

    FActiveBorderType : TElFlatBorderType;
    FInactiveBorderType : TElFlatBorderType;

    FAutoSelectItem : Boolean;
    FDelayItem      : TElSideBarItem;
    FHintItem       : TElSideBarCItem;

    FChangeDelay    : Integer;
    FDelayTimer     : TTimer;
    FKeepSelection: Boolean;
    FBorderSides: TElBorderSides;
    FIconLocation: TElSideBarIconLocation;
    FScrollButtonColor: TColor;
    FArrowColor: TColor;
    procedure SetActiveBorderType(newValue : TElFlatBorderType);
    procedure SetInactiveBorderType(newValue : TElFlatBorderType);
    procedure SetSectionHeight(newValue : Integer);
    procedure SetSections(newValue : TElSideBarSections);
    function GetSectionIndex : integer;
    procedure SetSectionIndex(newValue : Integer);
    function GetItemIndex : integer;
    procedure SetItemIndex(newValue : Integer);
    procedure SetSectionsColor(newValue : TColor);
    procedure SetWordWrap(newValue : Boolean);
    procedure SetSpacing(newValue : Integer);
    procedure SetTopSpacing(newValue : Integer);
    procedure SetScrollDelay(newValue : Integer);
    procedure SetSectionTracking(newValue : Boolean);
    procedure SetItemTracking(newValue : Boolean);
    procedure SetUnderlineTracked(newValue : Boolean);
{$IFDEF USE_SOUND_MAP}
    procedure SetSoundMap(newValue : TElSoundMap);
{$ENDIF}
    procedure SetSectionImages(newValue : TImageList);
    procedure SetSectionHotImages(newValue : TImageList);
    procedure SetSectionDisabledImages(newValue : TImageList);
    procedure SetItemDisabledImages(newValue : TImageList);
    procedure SetItemImages(newValue : TImageList);
    procedure SetItemHotImages(newValue : TImageList);
    procedure SetAlphaSectionImages(newValue : TImageList);
    procedure SetAlphaSectionHotImages(newValue : TImageList);
    procedure SetAlphaSectionDisabledImages(newValue : TImageList);
    procedure SetAlphaItemDisabledImages(newValue : TImageList);
    procedure SetAlphaItemImages(newValue : TImageList);
    procedure SetAlphaItemHotImages(newValue : TImageList);
    procedure CMControlChange(var Msg : TCMControlChange); message CM_CONTROLCHANGE;
    procedure WMPaint(var Msg : TWMPaint); message WM_PAINT;
    procedure WMNCPaint(var Msg : TMessage); message WM_NCPAINT;
    procedure CMMouseEnter(var Msg : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure CMEnter(var Msg : TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg : TCMExit); message CM_EXIT;
    procedure WMMouseMove(var Msg : TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonUp(var Msg : TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMLButtonDown(var Msg : TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure WMGetMinMaxInfo(var Msg : TMessage); message WM_GETMINMAXINFO;
    procedure CMHintShow(var Msg: TMessage); message CM_HINTSHOW;
    procedure CMDialogChar(var Msg: TCMDialogChar); message CM_DIALOGCHAR;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure SetFlat(newValue : Boolean);
    procedure DrawFlatBorder;
    procedure ItemRemoved(Sender : TObject; Item : TCollectionItem);
    procedure ItemAdded(Sender : TObject; Item : TCollectionItem);
    procedure SectionRemoved(Sender : TObject; Item : TCollectionItem);
    procedure SectionAdded(Sender : TObject; Item : TCollectionItem);
    procedure SetFlatSections(newValue: Boolean);
    procedure SetFlatItems(newValue: Boolean);
    procedure SetItemsFont(newValue: TFont);
    function GetSectionsFont: TFont;
    procedure SetSectionsFont(newValue: TFont);
    procedure SectionsFontChanged(Sender: TObject);
    procedure ItemsFontChanged(Sender: TObject);
    procedure SetVisibleSections(newValue : Boolean);
    procedure ImagesChanged(Sender : TObject);
    procedure SetItemSize(newValue : Integer);
    procedure SetRightAlignedBar(newValue : Boolean);
    procedure OnScrollTimer(Sender : TObject);
    procedure SetSectionsPopupMenu(newValue : TPopupMenu);
    procedure SetItemsPopupMenu(newValue : TPopupMenu);
    function GetTopIndex : Integer;
    procedure SetTopIndex(newValue : Integer);
    procedure UpdateTracks;
    procedure SetActiveSectionStyle(newValue: TFontStyles);
    procedure SetActiveItemStyle(newValue: TFontStyles);
    procedure SetTrackSectionFontColor(Value : TColor);
    procedure SetTrackSectionBkColor(Value : TColor);
    procedure SetTrackItemFontColor(Value : TColor);
    procedure SetTrackItemBkColor(Value : TColor);
    procedure SetFlatActiveItem(Value : boolean);
    procedure SetKeepSelection(Value: Boolean);
    procedure SetBorderSides(Value: TElBorderSides);
    procedure SetIconLocation(Value: TElSideBarIconLocation);
    function IsTopIndexStored: Boolean;
    procedure SetArrowColor(newValue: TColor);
  protected
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FTransparentItems: Boolean;
    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorShadow: TColor;
    FBorderColorWindow: TColor;
    procedure IntKeyDown  (var Key : Word; ShiftState : TShiftState);
    procedure IntMouseDown(Button : TMouseButton; XPos, YPos : SmallInt);
    procedure IntMouseUp  (Button : TMouseButton; XPos, YPos : SmallInt);
    procedure IntMouseMove(XPos, YPos : SmallInt);
    procedure IntMouseWheel(WheelDelta: Integer; MousePos: TPoint);
    function  IntHintShow(var HintInfo : THintInfo): Boolean;
{$ifdef VCL_4_USED}
    procedure ConstrainedResize(var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer); override;
{$else}
{$endif}
    procedure UpdateSectionPanels;
    procedure TriggerItemChangeEvent; virtual;
    procedure TriggerSectionChangeEvent; virtual;
    function GetPopupMenu : TPopupMenu; override;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CreateParams(var Params : TCreateParams); override;
    function  GetSectionHeight : integer;
    function  GetItemHeight : integer;
    function  GetSectionRect(Section : TElSideBarSection) : TRect;
    function  GetItemsRect : TRect;
    function  GetTopSectionsRect : TRect;
    function  GetBottomSectionsRect : TRect;
    procedure UpdateSection(Section : TElSideBarSection);
    procedure UpdateTopSections;
    procedure UpdateBottomSections;
    procedure UpdateItems;
    procedure UpdateAllSections;
    procedure UpdateBar;
    procedure UpdateFrame; // Updates flat frame
    function GetMinHeight : integer; virtual;
    procedure CreateWnd; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetChildOwner: TComponent; override;
    procedure ShowControl(AControl: TControl); override;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure OnDelayTimer(Sender : TObject);
    procedure StartDelayTimer(Item : TElSideBarItem);
    procedure StopDelayTimer;
    procedure DestroyWnd; override;
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
    function GetThemedClassName: WideString; override;
    function GetBackgroundClientRect: TRect; override;
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    procedure SetScrollButtonColor(Value: TColor);
    procedure SetTransparentItems(Value: Boolean);
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure UpdateChildControl;

    procedure ScrollUp;
    procedure ScrollDown;
    procedure Paint; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Loaded; override;

    procedure GetHitTest(X, Y : integer; var BarPart : TElSideBarPart; var Section : TElSideBarSection; var Item : TElSideBarItem);
  published
    property AutoSelectItem : Boolean read FAutoSelectItem write FAutoSelectItem default true;  { Published }
    property Sections : TElSideBarSections read FSections write SetSections;  { Published }
    property SectionIndex : Integer read GetSectionIndex write SetSectionIndex default -1;  { Published }
    property ItemIndex : Integer read GetItemIndex write SetItemIndex default -1;  { Published }
    property SectionsColor : TColor read FSectionsColor write SetSectionsColor default clBtnFace;  { Published }
    property WordWrap : Boolean read FWordWrap write SetWordWrap default False;  { Published }
    property Spacing : Integer read FSpacing write SetSpacing default 4{BarAdjust};  { Published }
    property TopSpacing : Integer read FTopSpacing write SetTopSpacing default 4{BarAdjust} * 2;  { Published }
    property ScrollDelay : Integer read FScrollDelay write SetScrollDelay default 100;  { Published }
    property ItemChangeSound : TElSoundName read FItemChangeSound write FItemChangeSound;  { Published }
    property SectionChangeSound : TElSoundName read FSectionChangeSound write FSectionChangeSound;  { Published }
    property SectionTracking : Boolean read FSectionTracking write SetSectionTracking default true;  { Published }
    property ItemTracking : Boolean read FItemTracking write SetItemTracking default true;  { Published }
    property UnderlineTracked : Boolean read FUnderlineTracked write SetUnderlineTracked default true;  { Published }
{$IFDEF USE_SOUND_MAP}
    property SoundMap : TElSoundMap read FSoundMap write SetSoundMap;
{$ENDIF}
    property ChangeDelay: Integer read FChangeDelay write FChangeDelay default 500;
    property SectionImages : TImageList read FSectionImages write SetSectionImages;
    property SectionHotImages : TImageList read FSectionHotImages write SetSectionHotImages;
    property SectionDisabledImages : TImageList read FSectionDisabledImages write SetSectionDisabledImages;

    property ItemDisabledImages : TImageList read FItemDisabledImages write SetItemDisabledImages;
    property ItemImages : TImageList read FItemImages write SetItemImages;
    property ItemHotImages : TImageList read FItemHotImages write SetItemHotImages;
    property AlphaForSectionImages : TImageList read FAlphaSectionImages write SetAlphaSectionImages;
    property AlphaForSectionHotImages : TImageList read FAlphaSectionHotImages write SetAlphaSectionHotImages;
    property AlphaForSectionDisabledImages : TImageList read FAlphaSectionDisabledImages write SetAlphaSectionDisabledImages;
    property AlphaForItemDisabledImages : TImageList read FAlphaItemDisabledImages write SetAlphaItemDisabledImages;
    property AlphaForItemImages : TImageList read FAlphaItemImages write SetAlphaItemImages;
    property AlphaForItemHotImages : TImageList read FAlphaItemHotImages write SetAlphaItemHotImages;
    property FlatSections: Boolean read FFlatSections write SetFlatSections default true;
    property FlatItems: Boolean read FFlatItems write SetFlatItems default true;
    property FlatActiveItem : boolean read FFlatActiveItem write SetFlatActiveItem default False;
    property ItemSize : Integer read FItemSize write SetItemSize default 36;  { Published }
    property RightAlignedBar : Boolean read FRightAlignedBar write SetRightAlignedBar default False;  { Published }
    property SectionHeight : Integer read FSectionHeight write SetSectionHeight default 0;  { Published }
    property ItemsPopupMenu : TPopupMenu read FItemsPopup write SetItemsPopupMenu;
    property SectionsPopupMenu : TPopupMenu read FSectionsPopup write SetSectionsPopupMenu;
    property TopIndex : Integer read GetTopIndex write SetTopIndex stored IsTopIndexStored;  { Published }
    property ActiveSectionStyle: TFontStyles read FActiveSectionStyle write SetActiveSectionStyle default [fsBold];
    property ActiveItemStyle: TFontStyles read FActiveItemStyle write SetActiveItemStyle default [fsBold];
    property ActiveBorderType : TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;  { Published }
    property InactiveBorderType : TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;  { Published }

    property Flat : Boolean read FFlat write SetFlat default false;  { Published }
    property ItemsFont: TFont read FItemsFont write SetItemsFont;
    property SectionsFont: TFont read GetSectionsFont write SetSectionsFont;
    property VisibleSections : Boolean read FVisibleSections write SetVisibleSections default true;  { Published }

    property TrackSectionFontColor : TColor read FTrackSectionFontColor write SetTrackSectionFontColor default clHighlight;
    property TrackSectionBkColor   : TColor read FTrackSectionBkColor write SetTrackSectionBkColor default clBtnFace;
    property TrackItemFontColor    : TColor read FTrackItemFontColor write SetTrackItemFontColor default clHighlight;
    property TrackItemBkColor      : TColor read FTrackItemBkColor write SetTrackItemBkColor default clBtnShadow;
    property KeepSelection: Boolean read FKeepSelection write SetKeepSelection default true;
    property IconLocation: TElSideBarIconLocation read FIconLocation write SetIconLocation default ilTop;
    property BorderSides: TElBorderSides read FBorderSides write SetBorderSides default [ebsLeft, ebsTop, ebsRight, ebsBottom];
    property BorderColorDkShadow: TColor read FBorderColorDkShadow write
        SetBorderColorDkShadow default cl3DDkShadow;
    property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace
        default clBtnFace;
    property BorderColorHighlight: TColor read FBorderColorHighlight write
        SetBorderColorHighlight default clBtnHighlight;
    property BorderColorShadow: TColor read FBorderColorShadow write
        SetBorderColorShadow default clBtnShadow;
    property BorderColorWindow: TColor read FBorderColorWindow write 
        SetBorderColorWindow default clWindow;

    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor default clBlack;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor default clBlack;
    property ScrollButtonColor: TColor read FScrollButtonColor write
        SetScrollButtonColor default clBtnFace;
    property TransparentItems: Boolean read FTransparentItems write
        SetTransparentItems default false;
    property ArrowColor: TColor read FArrowColor write SetArrowColor default
        clBtnText;

    property OnItemChange : TNotifyEvent read FOnItemChange write FOnItemChange;
    property OnSectionChange : TNotifyEvent read FOnSectionChange write FOnSectionChange;

    property Background;
    property BackgroundType;
    property GradientStartColor;
    property GradientEndColor;
    property GradientSteps;

    property Align nodefault;
    property BorderStyle nodefault;
    property Color default clBtnShadow;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    //property Transparent;
    property Visible;
    property UseXPThemes;

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
    property OnResize;
{$IFDEF VCL_4_USED}
    property Anchors;
    property Constraints;
    property DockOrientation default doNoOrient;
    property Floating;
    property DragKind;
{$ENDIF}
  end;

implementation

const BarAdjust = 4;


constructor TElSideBarContainerPanel.Create(AOwner : TComponent);
begin
  inherited;
  Visible := False;
  BevelOuter := bvNone;
  BorderStyle := bsNone;
  ControlStyle := ControlStyle + [csAcceptsControls, csNoDesignVisible];
  Align := alClient;
end;
{
function TElSideBarContainerPanel.GetParentComponent : TComponent;
begin
  result := Owner;
  if result = nil then
     MessageBox(0, 'Empty owner', nil, 0)
  else
    MessageBox(0, PChar('Owner is ' + TComponent(result).Name), nil, 0)
end;

function TElSideBarContainerPanel.GetOwner : TPersistent;
begin
  result := Owner;
end;
}
procedure TElSideBarContainerPanel.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if not (csDesigning in ComponentState) then
    Message.Result := HTTRANSPARENT
  else
    inherited;
end;

procedure TElSideBarContainerPanel.CreateParams(var Params : TCreateParams);
begin
  inherited;
  Params.Style := Params.Style or WS_CLIPCHILDREN or WS_CLIPSIBLINGS;
end;

constructor TElSideBarItem.Create(Collection : TCollection);
begin
  FBar := (Collection as TElSideBarItems).FSection.FBar;
  FVisible := true;
  FEnabled := true;
  FBar.ItemAdded(Collection, Self);
  inherited;
end;

destructor TElSideBarItem.Destroy;
begin
  FBar.ItemRemoved(Collection, Self);
  inherited;
end;

constructor TElSideBarItems.Create;
begin
  FSection := Section;
  inherited Create(TElSideBarItem);
end;

function TElSideBarItems.GetItems(index : integer) : TElSideBarItem;
{ Returns the value of data member FItems[index ]. }
begin
  result := TElSideBarItem(inherited Items[index]);
end;  { GetItems }

procedure TElSideBarItems.SetItems(index : integer; newValue : TElSideBarItem);
{ Sets data member FItems[index ] to newValue. }
begin
  inherited SetItem(Index, newValue);
end;  { SetItems }

function TElSideBarItems.Add : TElSideBarItem;  { public }
begin
  result := TElSideBarItem(inherited Add);
end;  { Add }

function TElSideBarItems.GetOwner : TPersistent;  { protected }
begin
  result := FSection;
end;  { GetOwner }

procedure TElSideBarItems.Update(Item : TCollectionItem);  { protected }
begin
  inherited;
  if (FSection.FBar.FSection = FSection) then
    FSection.FBar.UpdateItems;
end;  { Update }

constructor TElSideBarSections.Create;
begin
  FBar := Bar;
  inherited Create(TElSideBarSection);
end;

function TElSideBarSections.GetItems(index : integer) : TElSideBarSection;
{ Returns the value of data member FItems[index ]. }
begin
  result := TElSideBarSection(inherited Items[index]);
end;  { GetItems }

procedure TElSideBarSections.SetItems(index : integer; newValue : TElSideBarSection);
begin
  inherited SetItem(Index, newValue);
end;  { SetItems }

function TElSideBarSections.GetOwner : TPersistent;  { public }
begin
  result := FBar;
end;  { GetOwner }

procedure TElSideBarSections.Update(Item : TCollectionItem);  { public }
var i : integer;
    b : boolean;
begin
  inherited Update(Item);
  if Item = nil then
  begin
    {if not (csLoading in FBar.ComponentState) then
    for i := 0 to Count - 1 do
    begin
      if Items[i].FPanel <> nil then
         Items[i].FPanel.Name := 'Sections' + IntToStr(i) + 'Panel';
    end;}
    FBar.UpdateAllSections;
    Item := FBar.FSection;
  end;
  if Item <> nil then
  begin
    if (FBar.FSection = Item) and (not TElSideBarSection(Item).Enabled) then
    begin
      b := false;
      if Item.Index > 0 then
      begin
        for i := Item.Index - 1 downto 0 do    // Iterate
        begin
          if Items[i].Enabled then
          begin
            FBar.SectionIndex := i;
            b := true;
            break;
          end;
        end;    // for
      end
      else
      begin
        for i := Item.Index + 1 to Count - 1 do    // Iterate
        begin
          if Items[i].Enabled then
          begin
            FBar.SectionIndex := i;
            b := true;
            break;
          end;
        end;    // for
      end;
      if not b then
        FBar.SectionIndex := -1;
    end
    else
    if (FBar.FTrackSection = Item) and (not TElSideBarSection(Item).Enabled) and (TElSideBarSection(Item).Visible) then
    begin
      FBar.UpdateSection(TElSideBarSection(Item));
    end
    else
      FBar.UpdateSection(TElSideBarSection(Item));
  end;
  with FBar do
    if (FSection <> nil) and (FSection.FContainsControls) then
      UpdateChildControl;
end;  { Update }

function TElSideBarSections.Add : TElSideBarSection;  { public }
begin
  result := TElSideBarSection(inherited Add);
end;  { Add }

constructor TElSideBarSection.Create;
begin
  FVisible := true;
  FEnabled := true;
  FItems := TElSideBarItems.Create(Self);
  FSections := TElSideBarSections(Collection);
  FBar := FSections.FBar;
  FBar.SectionAdded(Collection, Self);
  inherited;
end;

destructor TElSideBarSection.Destroy;
begin
  ContainsControls := false;
  FPanel.Free;
  FPanel := nil;
  FBar.SectionRemoved(Collection, Self);
  FItems.Free;
  inherited;
end;

procedure TElSideBarSection.Assign(Source : TPersistent);
begin
  if Source is TElSideBarSection then
  begin
    inherited;
    FItems.Assign(TElSideBarSection(Source).Items);
    ContainsControls := TElSideBarSection(Source).ContainsControls;
    FInactive := TElSideBarSection(Source).FInactive;
  end else inherited;
end;

procedure TElSideBarSection.SetItems(newValue : TElSideBarItems);
begin
  FItems.Assign(newValue);
end;  { SetItems }

procedure TElSideBarSection.SetContainsControls(newValue : Boolean);
begin
  if (FContainsControls <> newValue) then
  begin
    FContainsControls := newValue;
    if newValue then
    begin
      if not (csLoading in FBar.ComponentState) then
      begin
        if FPanel = nil then
           AllocatePanel;
        FPanel.Align := alClient;
        FBar.UpdateChildControl;
      end;
    end else
    begin
      if FPanel <> nil then
      begin
        FPanel.Align := alNone;
        FPanel.BoundsRect := Rect(-1, -1, -1, -1);
        FBar.UpdateBar;
      end;
    end;
  end;  { if }
end;  { SetContainsControls }

procedure TElSideBarSection.AllocatePanel;
{var
     s,
     S1 : string;
     i : integer;
    }
begin
  FPanel := TElSideBarContainerPanel.Create(FBar);
  FPanel.Parent  := FBar;
  FPanel.Align := alNone;
  FPanel.BoundsRect := Rect(-1, -1, -1, -1);
  FPanel.UseXPThemes := false;
  FPanel.Visible := FBar.FSection = Self;
  {if (csDesigning in FBar.ComponentState) and (not (csLoading in FBar.ComponentState)) then
  begin
    S := 'ContainerPanel';
    S1 := S + '0';
    i := 0;
    if FBar.FindComponent(s) <> nil then
    begin
      while FBar.FindComponent(s1) <> nil do
      begin
        inc(i);
        S1 := S + IntToStr(i);
      end;
    end else
      S1 := S;
    FPanel.Name := S1;
  end;}
  FPanel.Caption := '';
  (*
{$IFDEF VCL_5_USED}
  FPanel.SetDesigning(false, false);
{$ELSE}
  FPanel.SetDesigning(false);
{$ENDIF}
*)
  FPanel.FreeNotification(FBar);
end;

procedure TElSideBarCItem.SetVisible(newValue : Boolean);
{ Sets data member FVisible to newValue. }
begin
  if (FVisible <> newValue) then
  begin
    FVisible := newValue;
    Changed(true);
  end;  { if }
end;  { SetVisible }

procedure TElSideBarCItem.SetEnabled(newValue : Boolean);
{ Sets data member FEnabled to newValue. }
begin
  if (FEnabled <> newValue) then
  begin
    FEnabled := newValue;
    Changed(false);
  end;  { if }
end;  { SetEnabled }

procedure TElSideBarCItem.SetImageIndex(newValue : Integer);
{ Sets data member FImageIndex to newValue. }
begin
  if (FImageIndex <> newValue) then
  begin
    FImageIndex := newValue;
    Changed(false);
  end;  { if }
end;  { SetImageIndex }

function TElSideBarCItem.GetOwner : TPersistent;
begin
  result := Collection;
end;

procedure TElSideBarCItem.SetCaption(newValue: TElFString);
{ Sets data member FCaption to newValue. }
begin
  if (FCaption <> newValue) then
  begin
    FCaption := newValue;
    Changed(false);
  end;  { if }
end;  { SetCaption }

constructor TElSideBarCItem.Create(Collection : TCollection);
begin
  FVisible := true;
  FEnabled := true;
  FImageIndex := -1;
  FCaption := 'New Item';
  inherited;
end;

procedure TElSideBarCItem.Assign(Source : TPersistent);
begin
  if Source is TElSideBarCItem then
  begin
    FVisible := TElSideBarCItem(Source).Visible;
    FEnabled := TElSideBarCItem(Source).Enabled;
    FCaption := TElSideBarCItem(Source).Caption;
    FImageIndex := TElSideBarCItem(Source).ImageIndex;
    FHint := TElSideBarCItem(Source).Hint;
    FTag := TElSideBarCItem(Source).Tag;
  end
  else
    inherited;
end;

constructor TElSideBar.Create(AOwner : TComponent);
begin
  inherited;
  AutoSelectItem := true;
  FSection := nil;
  FItem := nil;
  Width := 64;
  Align := alLeft;
  FSections := TElSideBarSections.Create(Self);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption];
  FItemsFont := TFont.Create;
  FItemsFont.Assign(Font);
  FItemsFont.Color := clWindow;
  FItemsFont.OnChange := ItemsFontChanged;
  Font.OnChange := SectionsFontChanged;

  ParentFont := false;
  Color := clBtnShadow;
  FSectionsColor := clBtnFace;
  FVisibleSections := true;
  FFlatSections := true;
  FFlatItems := true;
  FFlat := false;
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
  
  FSectionTracking := true;
  FItemTracking := true;
  FKeepSelection := true;
  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];

  FTrackSectionFontColor := clHighlight;
  FTrackSectionBkColor   := clBtnFace;
  FTrackItemFontColor    := clHighlight;
  FTrackItemBkColor      := clBtnShadow;

  FUnderlineTracked := true;
  FItemSize := 36;
  FTopSpacing := BarAdjust * 2;
  FSpacing := BarAdjust;
  FScrollDelay := 100;
  BorderStyle := bsSingle;
  FActiveSectionStyle := [fsBold];
  FActiveItemStyle := [fsBold];
  FActiveBorderType := fbtSunken;
  FInactiveBorderType := fbtSunkenOuter;
  FChangeDelay := 500;
  FIconLocation := ilTop;
  FScrollButtonColor := clBtnFace;

  FSImagesLink  := TChangeLink.Create; FSImageSLink.OnChange := ImagesChanged;
  FIImagesLink  := TChangeLink.Create; FIImageSLink.OnChange := ImagesChanged;
  FSDImagesLink := TChangeLink.Create; FSDImageSLink.OnChange := ImagesChanged;
  FIDImagesLink := TChangeLink.Create; FIDImageSLink.OnChange := ImagesChanged;
  FSHImagesLink := TChangeLink.Create; FSHImageSLink.OnChange := ImagesChanged;
  FIHImagesLink := TChangeLink.Create; FIHImageSLink.OnChange := ImagesChanged;
  FASImagesLink  := TChangeLink.Create; FASImageSLink.OnChange := ImagesChanged;
  FAIImagesLink  := TChangeLink.Create; FAIImageSLink.OnChange := ImagesChanged;
  FASDImagesLink := TChangeLink.Create; FASDImageSLink.OnChange := ImagesChanged;
  FAIDImagesLink := TChangeLink.Create; FAIDImageSLink.OnChange := ImagesChanged;
  FASHImagesLink := TChangeLink.Create; FASHImageSLink.OnChange := ImagesChanged;
  FAIHImagesLink := TChangeLink.Create; FAIHImageSLink.OnChange := ImagesChanged;

  FDelayTimer := TTimer.Create(nil);
  FDelayTimer.OnTimer := OnDelayTimer;

  if not Registered then
  begin
    try
      Classes.RegisterClasses([TElSideBarContainerPanel, TElPanel]);
    except
    end;
    Registered := True;
  end;
end;

procedure TElSideBar.CreateWnd;
begin
  inherited;
  if (FSection <> nil) and (FSection.ContainsControls) then
  begin
    UpdateChildControl;
  end;
end;

destructor TElSideBar.Destroy;
begin
  Destroying;
  FScrollTimer.Free;
  FDelayTimer.Free;
  FSections.Free;

  FSImagesLink.Free;
  FIImagesLink.Free;
  FSDImagesLink.Free;
  FIDImagesLink.Free;
  FSHImagesLink.Free;
  FIHImagesLink.Free;
  FASImagesLink.Free;
  FAIImagesLink.Free;
  FASDImagesLink.Free;
  FAIDImagesLink.Free;
  FASHImagesLink.Free;
  FAIHImagesLink.Free;

  FItemsFont.Free;
  inherited;
end;

procedure TElSideBar.CreateParams(var Params : TCreateParams);
begin
  inherited;
  Params.Style := Params.Style or WS_CLIPCHILDREN;
  if Transparent then
    Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT
  else
    Params.ExStyle := Params.ExStyle and not WS_EX_TRANSPARENT;
end;

procedure TElSideBar.SetSections(newValue : TElSideBarSections);
{ Sets data member FSections to newValue. }
begin
  FSections.Assign(newValue);
end;  { SetSections }

function TElSideBar.GetSectionIndex : integer;
begin
  if (FSection <> nil) then result := FSection.Index else result := -1;
end;

function TElSideBar.GetItemIndex : integer;
begin
  if (FItem <> nil) then result := FItem.Index else result := -1;
end;

procedure TElSideBar.SetSectionIndex(newValue : Integer);
var Section : TElSideBarSection;
    i : integer;
    AnItem : TElSideBarItem;

begin
  if InRange(0, Sections.Count - 1, newValue) then
  begin
    Section := Sections[newValue];
    if ((FSection = nil) or (FSection.Index <> newValue)) and (Section.Visible) and (Section.Enabled) then
    begin
      if (FSection <> nil) and (FSection.FContainsControls) and (FSection.FPanel <> nil) then
        FSection.FPanel.Visible := false;
      FSection := Section;
      if (FSection <> nil) and (FSection.FContainsControls) and (FSection.FPanel <> nil) then
      begin
        FSection.FPanel.Visible := true;
        UpdateChildControl;
      end;
      FTrackItem := nil;
      FTrackSection := nil;
      FTopItem := nil;
      FItem := nil;
      if FSection.Items.Count > 0 then
      begin
        i := 0;
        while i < FSection.Items.Count do
        begin
          AnItem := FSection.Items[i];
          if AnItem.Visible then
          begin
            if FTopItem = nil then
              FTopItem := AnItem;
            if (FItem = nil) and AnItem.Enabled and (AutoSelectItem) then
            begin
              FItem := AnItem;
            end;
          end;
          inc(i);
        end;
      end;
      if not (csDestroying in ComponentState) then
      begin
        TriggerSectionChangeEvent;
        if AutoSelectItem and (not (csLoading in ComponentState)) then
          TriggerItemChangeEvent;
      end;
      UpdateBar;
    end
    else
      TriggerSectionChangeEvent;
  end
  else
  begin
    if (FSection <> nil) and (FSection.FContainsControls) and (FSection.FPanel <> nil) then
      FSection.FPanel.Visible := false;
    FSection := nil;

    FTopItem := nil;
    FDownItem := nil;
    FTrackItem := nil;
    FTrackSection := nil;
    FItem := nil;
    if (not (csDestroying in ComponentState)) and
       (not (csLoading in ComponentState)) then
    begin
      TriggerSectionChangeEvent;
      TriggerItemChangeEvent;
    end;
    UpdateBar;
  end;
end;  { SetSelectedSection }

procedure TElSideBar.SetSectionsColor(newValue : TColor);
{ Sets data member FSectionsColor to newValue. }
begin
  if (FSectionsColor <> newValue) then
  begin
    FSectionsColor := newValue;
    if VisibleSections then UpdateAllSections;
  end;  { if }
end;  { SetSectionsColor }

procedure TElSideBar.SetWordWrap(newValue : Boolean);
{ Sets data member FWordWrap to newValue. }
begin
  if (FWordWrap <> newValue) then
  begin
    FWordWrap := newValue;
    if (FSection <> nil) and (FSection.Items.Count > 0) then UpdateItems;
  end;  { if }
end;  { SetWordWrap }

procedure TElSideBar.SetSpacing(newValue : Integer);
{ Sets data member FSpacing to newValue. }
begin
  if (FSpacing <> newValue) then
  begin
    FSpacing := newValue;
    if (FSection <> nil) and (FTopItem <> nil) then UpdateItems;
  end;  { if }
end;  { SetSpacing }

procedure TElSideBar.SetTopSpacing(newValue : Integer);
{ Sets data member FTopSpacing to newValue. }
begin
  if (FTopSpacing <> newValue) then
  begin
    FTopSpacing := newValue;
    if (FSection <> nil) and (FTopItem <> nil) then UpdateItems;
  end;  { if }
end;  { SetTopSpacing }

procedure TElSideBar.SetScrollDelay(newValue : Integer);
{ Sets data member FScrollDelay to newValue. }
begin
  if (FScrollDelay <> newValue) and (newValue >= 100) then
  begin
    FScrollDelay := newValue;
  end;  { if }
end;  { SetScrollDelay }

{$warnings off}
procedure TElSideBar.Paint;  { public }
var i,
    ih,
    sh : integer;
    R,
    R1,
    R2,
    R3 : TRect;
    TmpCanvas : TCanvas;

    procedure PaintSection(Section : TElSideBarSection; R : TRect);
    var IL : TImageList;
        Flags
        ,Flags2
           : integer;
        {$ifdef MSWINDOWS}
        sid: integer;
        {$endif}
          AIL : TImageList;
          amBMP, BMP: TBitmap;
          P2 : TPoint;
    begin
      if (not SectionTracking) or (Section <> FTrackSection) then
         TmpCanvas.Brush.Color := SectionsColor
      else
         TmpCanvas.Brush.Color := FTrackSectionBkColor;

      Section.FBoundRect := R;
      {$ifdef MSWINDOWS}
      if IsThemeApplied then
      begin
        DrawThemeBackground(Theme, TmpCanvas.Handle, 0, 0, Section.FBoundRect, nil);

        if not Section.Enabled then
          sid := TS_DISABLED
        else
        if FDownSection = Section then
          sid := TS_PRESSED
        else
        if Section = FTrackSection then
          sid := TS_HOT
        else
        if FlatSections then
          sid := TS_NORMAL
        else
          sid := TS_HOT;

        DrawThemeBackground(Theme, TmpCanvas.Handle, TP_BUTTON, sid, Section.FBoundRect, nil);
        GetThemeBackgroundContentRect(Theme, TmpCanvas.Handle, TP_BUTTON, sid, Section.FBoundRect, R);
      end
      else
      {$endif}
      begin
        TmpCanvas.FillRect(R);
        DrawButtonFrameEx3(TmpCanvas.Handle, R, ((Section = FTrackSection) and (FDownSection <> Section)) or (not FlatSections), FDownSection = Section, SectionsColor, true, AllBorderSides);
        InflateRect(R, -2, -2);
      end;
      if (Section.ImageIndex <> - 1) then
      begin
        IL := nil;
        AIL := nil;
        if not Section.Enabled then
        begin
          IL := FSectionDisabledImages;
          AIL := FAlphaSectionDisabledImages;
        end
        else
          if FTrackSection = Section then
          begin
            IL := FSectionHotImages;
            AIL := FAlphaSectionHotImages;
          end;

        if IL = nil then IL := FSectionImages;
        if AIL = nil then AIL := FAlphaSectionImages;
        if (IL <> nil) and (Section.ImageIndex < IL.Count) then
        begin
          if RightAlignedBar then
          begin
            P2 := Point(R.Right - IL.Width, R.Top + (R.Bottom - R.Top) div 2 - IL.Height div 2);
            Dec(R.Right, IL.Width + BarAdjust);
          end else
          begin
            P2 := Point(R.Left, R.Top + (R.Bottom - R.Top) div 2 - IL.Height div 2);
            Inc(R.Left, IL.Width + BarAdjust);
          end;
          if (AIL <> nil) and (Section.ImageIndex < AIL.Count) then
          begin
            BMP := TBitmap.Create;
            BMP.Width := IL.Width;
            BMP.Height := IL.Height;
            ImageList_DrawEx(IL.Handle, Section.ImageIndex, BMP.Canvas.Handle, 0, 0, 0, 0,
              clNone, clNone, ILD_Normal);

            amBMP := TBitmap.Create;
            amBMP.Width := AIL.Width;
            amBMP.Height := AIL.Height;
            ImageList_DrawEx(AIL.Handle, Section.ImageIndex, amBMP.Canvas.Handle, 0, 0, 0, 0,
              clNone, clNone, ILD_Normal);

            AlphaCopyRect2(TmpCanvas.Handle, rect(p2.x, p2.y, p2.x + IL.Width, p2.y + IL.Height),
                BMP.Canvas.Handle, rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

            BMP.Free;
            amBMP.Free;
          end
          else
            IL.Draw(TmpCanvas, P2.x, P2.y, Section.ImageIndex);
        end;
      end;
      if Section.Caption <> '' then
      begin
        {$ifdef MSWINDOWS}
        if IsThemeApplied then
        begin
          TmpCanvas.Font.Assign(Font);
          if not Section.Enabled then
            sid := TS_DISABLED
          else
          if FDownSection = Section then
            sid := TS_PRESSED
          else
          if Section = FTrackSection then
            sid := TS_HOT
          else
            sid := TS_NORMAL;

          if not Section.Enabled then
            Flags2 := DTT_GRAYED
          else
            Flags2 := 0;
          Flags := DT_NOPREFIX or DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS;
          if RightAlignedBar then
            Flags := Flags + DT_RTLREADING;
          GetThemeTextExtent(Theme, TmpCanvas.Handle, TP_BUTTON, sid, PWideChar(WideString(Section.Caption)), Length(WideString(Section.Caption)), Flags, @R, Section.FTextRect);
          OffsetRect(Section.FTextRect,
            (((R.Right - R.Left) - (Section.FTextRect.Right - Section.FTextRect.Left)) div 2),
            (((R.Bottom - R.Top) - (Section.FTextRect.Bottom - Section.FTextRect.Top)) div 2)
            );
          DrawThemeText(Theme, TmpCanvas.Handle, TP_BUTTON, sid, PWideChar(WideString(Section.Caption)), Length(WideString(Section.Caption)), Flags, Flags2, R);
        end
        else
        {$endif}
        begin
          TmpCanvas.Font.Assign(Font);
          with TmpCanvas do
          begin
            Brush.Style := bsClear;
            if Section = FSection then
              TmpCanvas.Font.Style := FActiveSectionStyle;
            if not Section.Enabled then
            begin
              OffsetRect(R, 1, 1);
              Flags := DT_NOPREFIX or DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS;
              if RightAlignedBar then
                Flags := Flags + DT_RTLREADING;
              TmpCanvas.Font.Color := clBtnHighlight;
              Brush.Style := bsClear;
              {$ifdef ELPACK_UNICODE}
              ElVCLUtils.DrawTextW(Handle, PWideChar(Section.Caption), Length(Section.Caption), R, Flags);
              {$else}
              DrawText(Handle, PChar(Section.Caption), Length(Section.Caption), R, Flags);
              {$endif}
              OffsetRect(R, -1, -1);
              TmpCanvas.Font.Color := clBtnShadow;
              Brush.Style := bsClear;
              {$ifdef ELPACK_UNICODE}
              ElVCLUtils.DrawTextW(Handle, PWideChar(Section.Caption), Length(Section.Caption), R, Flags);
              {$else}
              DrawText(Handle, PChar(Section.Caption), Length(Section.Caption), R, Flags);
              {$endif}
              Section.FTextRect := R;
            end
            else
            begin
              if Section = FTrackSection then
              begin
                if UnderlineTracked then
                  TmpCanvas.Font.Style := TmpCanvas.Font.Style + [fsUnderline];
                TmpCanvas.Font.Color := FTrackSectionFontColor;
              end;
              Flags := DT_NOPREFIX or DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS;
              if RightAlignedBar then
                Flags := Flags + DT_RTLREADING;
              Brush.Style := bsClear;
              {$ifdef ELPACK_UNICODE}
              ElVCLUtils.DrawTextW(Handle, PWideChar(Section.Caption), Length(Section.Caption), R, Flags);
              {$else}
              DrawText(Handle, PChar(Section.Caption), Length(Section.Caption), R, Flags);
              {$endif}
              Section.FTextRect := R;

            end;
            Brush.Style := bsSolid;
          end;
        end;
      end
      else
      begin
        Section.FTextRect := Section.FBoundRect;
        InflateRect(Section.FTextRect, -2, -2);
      end;
    end;

    function GetItemTextExtent(Item : TElSideBarCItem) : TSize;
    var {$ifdef MSWINDOWS}
        sid   : integer;
        {$endif}
        Flags : integer;
        Rect  : TRect;
    begin
      {$ifdef MSWINDOWS}
      if IsThemeApplied then
      begin
        if not Item.Enabled then
          sid := TS_DISABLED
        else
        if FDownItem = Item then
          sid := TS_PRESSED
        else
        if Item = FTrackItem then
          sid := TS_HOT
        else
          sid := TS_NORMAL;

        if FWordWrap then
            Flags := DT_VCENTER or DT_LEFT or DT_WORDBREAK
          else
            Flags := DT_VCENTER or DT_LEFT or DT_END_ELLIPSIS;
        if RightAlignedBar then
          Flags := Flags + DT_RTLREADING;
        SetRectEmpty(Rect);
        GetThemeTextExtent(Theme, TmpCanvas.Handle, TP_BUTTON, sid, PWideChar(WideString(Item.Caption)), Length(WideString(Item.Caption)), Flags, nil, Rect);
        Result.cy := Rect.Bottom - Rect.Top;
        Result.cx := Rect.Right - Rect.Left;
      end
      else
      {$endif}
      begin
        if (FIconLocation = ilTop) then
        begin
          if FWordWrap then
            Flags := DT_TOP or DT_CENTER or DT_WORDBREAK
          else
            Flags := DT_TOP or DT_CENTER or DT_END_ELLIPSIS;
        end
        else
        begin
          if FWordWrap then
            Flags := DT_VCENTER or DT_LEFT or DT_WORDBREAK
          else
            Flags := DT_VCENTER or DT_LEFT or DT_END_ELLIPSIS;
        end;
        if RightAlignedBar then
          Flags := Flags + DT_RTLREADING;
        SetRectEmpty(Rect);
        {$ifdef ELPACK_UNICODE}
        ElVCLUtils.DrawTextW(TmpCanvas.Handle, PWideChar(Item.Caption), -1, Rect, DT_CALCRECT or Flags);
        {$else}
        DrawText(TmpCanvas.Handle,PChar(Item.Caption), -1, Rect, DT_CALCRECT or Flags);
        {$endif}
        Result.cy := Rect.Bottom - Rect.Top;
        Result.cx := Rect.Right - Rect.Left;
      end;
    end;

    procedure PaintItem(Item : TElSideBarCItem; const R : TRect; var ItemHeight : integer);
    var BtnRect,
        R1,
        ImRect : TRect;
        IL     : TImageList;
        AIL    : TImageList;
        BMP,
        amBMP  : TBitmap;
        Flags
        {$ifdef MSWINDOWS}
        , Flags2
        {$endif}
                : integer;
        i       : integer;
{$IFDEF VCL_4_USED}
        b      : boolean;
{$ENDIF}
{$ifdef MSWINDOWS}
        sid    : integer;
{$endif}
    begin
      ItemHeight := 0;
      if VisibleSections then
      begin
        if FIconLocation = ilTop then
          BtnRect.Left := (R.Right - R.Left) div 2 - ItemSize div 2
        else
          BtnRect.Left := R.Left + Spacing;

        BtnRect.Right  := BtnRect.Left + ItemSize;
        BtnRect.Top    := R.Top;
        BtnRect.Bottom := R.Top + ItemSize;
      end
      else
      begin
        BtnRect := R;
        BtnRect.Bottom := R.Top + ItemSize + BarAdjust;
      end;

      TmpCanvas.Brush.Style := bsSolid;

      if (not ItemTracking) or (Item <> FTrackItem) then
         TmpCanvas.Brush.Color := Color
      else
         TmpCanvas.Brush.Color := FTrackItemBkColor;

      Item.FBoundRect := BtnRect;

      {$ifdef MSWINDOWS}
      // sid := 0;
      if IsThemeApplied then
      begin
        DrawThemeBackground(Theme, TmpCanvas.Handle, 0, 0, Item.FBoundRect, nil);
        if not Item.Enabled then
          sid := TS_DISABLED
        else
        if (FDownItem = Item) or (Item = FItem) then
          sid := TS_PRESSED
        else
        if Item = FTrackItem then
          sid := TS_HOT
        else
        if FlatItems then
          sid := TS_NORMAL
        else
          sid := TS_HOT;
        DrawThemeBackground(Theme, TmpCanvas.Handle, TP_BUTTON, sid, Item.FBoundRect, nil);
        GetThemeBackgroundContentRect(Theme, TmpCanvas.Handle, TP_BUTTON, sid, Item.FBoundRect, BtnRect);
      end
      else
      {$endif}
      begin
        if not FTransparentItems then
          TmpCanvas.FillRect(BtnRect);
        TmpCanvas.Brush.Style := bsClear;

        if (Item.Enabled) and ((not FlatItems) or ((not FlatActiveItem) and ((Item = FTrackItem) or (Item = FDownItem) or (Item = FItem))))  then
           DrawButtonFrameEx3(TmpCanvas.Handle, BtnRect, (Item = FTrackItem) and (FDownItem <> Item), (FDownItem = Item) or (Item = FItem), Color, true, AllBorderSides);
      end;

      i := BtnRect.Left;

      if Item.ImageIndex <> -1 then
      begin
        IL := nil;
        AIL := nil;
        if not Item.Enabled then
        begin
          IL := FItemDisabledImages;
          AIL := FAlphaItemDisabledImages;
        end
        else
          if FTrackItem = Item then
          begin
            IL := FItemHotImages;
            AIL := FAlphaItemHotImages;
          end;
        if IL = nil then
          IL := FItemImages;

        if AIL = nil then AIL := FAlphaItemImages;
        if (IL <> nil) and (Item.ImageIndex < IL.Count) then
        begin
          if not VisibleSections then
          begin
            if FIconLocation = ilTop then
            begin
              i := GetItemTextExtent(Item).cy;
              CenterRects(IL.Width, BtnRect.Right - BtnRect.Left, IL.Height, BtnRect.Bottom - BtnRect.Top - i, ImRect)
            end
            else
            begin
              ImRect.Top := (BtnRect.Bottom - BtnRect.Top - IL.Height) div 2;
              ImRect.Bottom := ImRect.Top + IL.Height;
              ImRect.Left := BarAdjust;
              ImRect.Right := ImRect.Left + IL.Width;
              i := ImRect.Right + BarAdjust;
            end;
          end
          else
            CenterRects(IL.Width, BtnRect.Right - BtnRect.Left, IL.Height, BtnRect.Bottom - BtnRect.Top, ImRect);
          OffsetRect(ImRect, BtnRect.Left, BtnRect.Top);
          {$IFDEF VCL_4_USED}
          b := true;
          if (IL = FItemImages) and (not Item.Enabled) then
            b := false;
          {$ENDIF}
          begin
            if (AIL <> nil) and (Item.ImageIndex < AIL.Count) then
            begin
              BMP := TBitmap.Create;
              BMP.Width := IL.Width;
              BMP.Height := IL.Height;
              ImageList_DrawEx(IL.Handle, Item.ImageIndex, BMP.Canvas.Handle, 0, 0, 0, 0,
                clNone, clNone, ILD_Normal);

              amBMP := TBitmap.Create;
              amBMP.Width := AIL.Width;
              amBMP.Height := AIL.Height;
              ImageList_DrawEx(AIL.Handle, Item.ImageIndex, amBMP.Canvas.Handle, 0, 0, 0, 0,
                clNone, clNone, ILD_Normal);

              AlphaCopyRect2(TmpCanvas.Handle, ImRect, BMP.Canvas.Handle,
                rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

              BMP.Free;
              amBMP.Free;
            end
            else
              IL.Draw(TmpCanvas, ImRect.Left, ImRect.Top, Item.ImageIndex{$IFDEF VCL_4_USED}, b{$ENDIF});
          end;
        end;
      end;
      if (FIconLocation = ilTop) then
      begin
        Inc(ItemHeight, ItemSize + BarAdjust);
      end
      else
      begin
        ItemHeight := BtnRect.Bottom - BtnRect.Top;
      end;

      ImRect := R;
      if VisibleSections then
      begin
        if FIconLocation = ilTop then
        begin
          ImRect.Top := BtnRect.Bottom + BarAdjust;
          ImRect.Bottom := ImRect.Top + ItemSize;
        end
        else
        begin
          ImRect.Left := BtnRect.Right + BarAdjust;
          ImRect.Right := ImRect.Left + (R.Right - ImRect.Left);
          ImRect.Top := BtnRect.Top;
          ImRect.Bottom := BtnRect.Bottom;
        end;
      end
      else
      begin
        if FIconLocation = ilTop then
        begin
          ImRect.Bottom := BtnRect.Bottom - BarAdjust;
        end
        else
        begin
          ImRect.Left := i + BarAdjust;
          ImRect.Right := BtnRect.Right - BarAdjust;
          ImRect.Bottom := BtnRect.Bottom;
        end;
      end;
      TmpCanvas.Brush.Style := bsClear;
      TmpCanvas.Font.Assign(FItemsFont);

      if Item.Caption <> '' then
      begin
        R1 := ImRect;
        {$ifdef MSWINDOWS}
        if IsThemeApplied then
        begin
          if not Item.Enabled then
            sid := TS_DISABLED
          else
          if FDownItem = Item then
            sid := TS_PRESSED
          else
          if Item = FTrackItem then
            sid := TS_HOT
          else
            sid := TS_NORMAL;

          if not Item.Enabled then
            Flags2 := DTT_GRAYED
          else
            Flags2 := 0;

          if (FIconLocation = ilTop) then
          begin
            if FWordWrap then
              Flags := DT_TOP or DT_CENTER or DT_WORDBREAK
            else
              Flags := DT_TOP or DT_CENTER or DT_END_ELLIPSIS;
          end
          else
          begin
            if FWordWrap then
              Flags := DT_VCENTER or DT_LEFT or DT_WORDBREAK
            else
              Flags := DT_VCENTER or DT_LEFT or DT_END_ELLIPSIS;
          end;
          if RightAlignedBar then
            Flags := Flags + DT_RTLREADING;
          GetThemeTextExtent(Theme, TmpCanvas.Handle, TP_BUTTON, sid, PWideChar(WideString(Item.Caption)), Length(WideString(Item.Caption)), Flags, @ImRect, R1);
          if (FIconLocation = ilTop) then
          begin
            ImRect.Left :=  (ImRect.Right - (R1.Right - R1.Left)) div 2;
            ImRect.Right := ImRect.Left + (R1.Right - R1.Left);
          end
          else
          begin
            ImRect.Top := ImRect.Top + ((ImRect.Bottom - ImRect.Top) - (R1.Bottom - R1.Top)) div 2;
            ImRect.Bottom := ImRect.Top + (R1.Bottom - R1.Top);
            ImRect.Right := ImRect.Left + (R1.Right - R1.Left);
          end;
          if VisibleSections then
          begin
            if (FIconLocation = ilTop) then
              ImRect.Bottom := ImRect.Top + (R1.Bottom - R1.Top)
            else
              ImRect.Right := ImRect.Left + (R1.Right - R1.Left);
          end
          else
          begin
            if (FIconLocation = ilTop) then
              ImRect.Top := ImRect.Bottom - (R1.Bottom - R1.Top)
          end;
          DrawThemeText(Theme, TmpCanvas.Handle, TP_BUTTON, sid, PWideChar(WideString(Item.Caption)), Length(WideString(Item.Caption)), Flags, Flags2, ImRect);
          Item.FTextRect := ImRect;
        end
        else
        {$endif}
        begin
          if Item = FItem then
            TmpCanvas.Font.Style := FActiveItemStyle;
          if (FIconLocation = ilTop) then
          begin
            if FWordWrap then
              Flags := DT_TOP or DT_CENTER or DT_WORDBREAK
            else
              Flags := DT_TOP or DT_CENTER or DT_END_ELLIPSIS;
          end
          else
          begin
            if FWordWrap then
              Flags := DT_VCENTER or DT_LEFT or DT_WORDBREAK
            else
              Flags := DT_VCENTER or DT_LEFT or DT_END_ELLIPSIS;
          end;
          if RightAlignedBar then
            Flags := Flags + DT_RTLREADING;
          {$ifdef ELPACK_UNICODE}
          ElVCLUtils.DrawTextW(TmpCanvas.Handle, PWideChar(Item.Caption), -1, R1, DT_CALCRECT or Flags);
          {$else}
          DrawText(TmpCanvas.Handle,PChar(Item.Caption), -1, R1, DT_CALCRECT or Flags);
          {$endif}
          if (FIconLocation = ilTop) then
          begin
            ImRect.Left :=  (ImRect.Right - (R1.Right - R1.Left)) div 2;
            ImRect.Right := ImRect.Left + (R1.Right - R1.Left);
          end
          else
          begin
            ImRect.Top := ImRect.Top + ((ImRect.Bottom - ImRect.Top) - (R1.Bottom - R1.Top)) div 2;
            ImRect.Bottom := ImRect.Top + (R1.Bottom - R1.Top);
            ImRect.Right := ImRect.Left + (R1.Right - R1.Left);
          end;
          if VisibleSections then
          begin
            if (FIconLocation = ilTop) then
              ImRect.Bottom := ImRect.Top + (R1.Bottom - R1.Top)
            else
              ImRect.Right := ImRect.Left + (R1.Right - R1.Left);
          end
          else
          begin
            if (FIconLocation = ilTop) then
              ImRect.Top := ImRect.Bottom - (R1.Bottom - R1.Top)
            {
            else
              ImRect.Right := ImRect.Right - (R1.Right - R1.Left);
            }
          end;

          if not Item.Enabled then
          begin
            TmpCanvas.Font.Color := clBtnFace;
            TmpCanvas.Brush.Style := bsClear;
            {$ifdef ELPACK_UNICODE}
            ElVCLUtils.DrawTextW(TmpCanvas.Handle, PWideChar(Item.Caption), Length(Item.Caption), ImRect, Flags);
            {$else}
            DrawText(TmpCanvas.Handle, PChar(Item.Caption), Length(Item.Caption), ImRect, Flags);
            {$endif}
            Item.FTextRect := ImRect;
          end
          else
          begin
            if Item = FTrackItem then
            begin
              if UnderlineTracked then
                TmpCanvas.Font.Style := TmpCanvas.Font.Style + [fsUnderline];
              TmpCanvas.Font.Color := FTrackItemFontColor;
            end;
            {$ifdef ELPACK_UNICODE}
            ElVCLUtils.DrawTextW(TmpCanvas.Handle, PWideChar(Item.Caption), Length(Item.Caption), ImRect, Flags);
            {$else}
            DrawText(TmpCanvas.Handle, PChar(Item.Caption), Length(Item.Caption), ImRect, Flags);
            {$endif}
            Item.FTextRect := ImRect;
          end;
        end;

        if VisibleSections then
          if (FIconLocation = ilTop) then
            Inc(ItemHeight, (ImRect.Bottom - ImRect.Top));
      end
      else
      begin
        if (FIconLocation = ilTop) then
        begin
          Item.FTextRect := Rect(BtnRect.Left, ImRect.Top, BtnRect.Right, ImRect.Top + TmpCanvas.TextHeight('Wg'));
          if VisibleSections then
             Inc(ItemHeight, TmpCanvas.TextHeight('Wg'));
        end
        else
          Item.FTextRect := Rect(ImRect.Left, BtnRect.Top, ImRect.Left + TmpCanvas.TextWidth('W'), BtnRect.Bottom);
      end;
      TmpCanvas.Brush.Style := bsSolid;
      Inc(ItemHeight, Spacing);
    end;

    procedure FillItemsBackground(Rect1 : TRect);
    var R1 : TRect;
    begin
      case BackgroundType of //
        bgtHorzGradient,
        bgtVertGradient:
          begin
            GradientFill(TmpCanvas.Handle, Rect1, GradientStartColor, GradientEndColor, GradientSteps, BackgroundType = bgtVertGradient);
          end;
        bgtStretchBitmap,
        bgtTileBitmap:
          begin
            TmpCanvas.CopyRect(Rect1, FTmpBmp.Canvas, Classes.Rect(0, 0, FTmpBmp.Width, FTmpBmp.Height));
          end;
        bgtCenterBitmap :
          begin
            Brush.Color := Color;
            TmpCanvas.FillRect(Rect1);
            // R := Classes.Rect(0, 0, FBackground.Width, FBackground.Height);
            CenterRects(FBackground.Width, Rect1.Right - Rect1.Left, FBackground.Height, Rect1.Bottom - Rect1.Top, R1);
            OffsetRect(R1, Rect1.Left, Rect1.Top);
            TmpCanvas.CopyRect(R1, FBackground.Canvas, Classes.Rect(0, 0, FBackground.Width, FBackground.Height));
          end;
        bgtTopLeftBitmap:
          begin
            if Background.Empty then
              TmpCanvas.FillRect(Rect1)
            else
            begin
              if BackgroundType = bgtTopLeftBitmap then
              begin
                Color := Background.Canvas.Pixels[Background.Width-1, Background.Height-1];
              end;
              R1 := GetItemsRect;
              OffsetRect(R1, -Rect1.Left, -Rect1.Top);
              ExtDrawBkgnd2(TmpCanvas.Handle, GetItemsRect, Rect1, R1.TopLeft, Color, Background, BackgroundType);
            end;
          end;
      end; // case
    end;

    procedure PaintItems(Rect1, Rect2 : TRect);
    var FdownBtn,
        FUpBtn  : boolean;
        i       : integer;
        Item    : TElSideBarCItem;
        pid,
        sid     : integer;
        BtnColor: TColor;

    begin
      FUpBtn  := false;
      FDownBtn:= false;

      if FSection.ContainsControls then exit;
      if
      {$ifdef MSWINDOWS}
      (not IsThemeApplied) and
      {$endif}
       (BackgroundType <> bgtColorFill) then
      begin
        FillItemsBackground(Rect1);
      end;

      if (FSection.Items.Count > 0) and (FTopItem <> nil) then
      begin
        Inc(Rect1.Top, TopSpacing);
        for i := 0 to FSection.Items.Count - 1 do
        begin
          Item := FSection.Items[i];
          SetRectEmpty(Item.FBoundRect);
          SetRectEmpty(Item.FTextRect);
          Item.FPartial := false;
        end;
        for i := FTopItem.Index - 1 downto 0 do
        begin
          if FSection.Items[i].Visible then
          begin
            FUpBtn := true;
            break;
          end;
        end;
        for i := FTopItem.Index to FSection.Items.Count - 1 do    // Iterate
        begin
          if FSection.Items[i].Visible then
          begin
            PaintItem(FSection.Items[i], Rect1, ih);
            Inc(Rect1.Top, ih);
            if Rect1.Top >= Rect2.Bottom then
            begin
              FDownBtn := true;
              FSection.Items[i].FPartial := true;
              break;
            end;
          end;
        end;    // for

        {draw buttons}
        FVisUpBtn := FUpBtn;
        FVisDownBtn := FDownBtn;

        if FVisUpBtn then
        begin
          if RightAlignedBar then
            Rect1 := Rect(Rect2.Left + 5, Rect2.Top+5, Rect2.Left + 20, Rect2.Top+20)
          else
            Rect1 := Rect(Rect2.Right-20, Rect2.Top+5, Rect2.Right-5, Rect2.Top+20);

          //BtnColor := clBtnText;

          {$ifdef MSWINDOWS}
          if IsThemeApplied then
          begin
            pid := TP_BUTTON;
            if FUpBtnPressed then
              sid := TS_PRESSED
            else
              sid := TS_HOT;
            DrawThemeBackground(Theme, TmpCanvas.Handle, pid, sid, Rect1, nil);
          end
          else
          {$endif}
          begin
            if BackgroundType = bgtColorFill then
            begin
              TmpCanvas.Brush.Color := ScrollButtonColor;
              TmpCanvas.FillRect(Rect1);
            end;
            {
            else
              BtnColor := ItemsFont.Color;
            }
            DrawButtonFrameEx3(TmpCanvas.Handle, Rect1, false, FUpBtnPressed, ScrollButtonColor, true, AllBorderSides);
          end;
          if FUpBtnPressed then
            OffsetRect(Rect1, 1, 1);

          DrawArrow(TmpCanvas, eadUp, Rect1, ArrowColor, true);
        end;
        if FVisDownBtn then
        begin
          if RightAlignedBar then
            Rect1 := Rect(Rect2.Left + 5, Rect2.Bottom - 20, Rect2.Left + 20, Rect2.Bottom - 5)
          else
            Rect1 := Rect(Rect2.Right-20, Rect2.Bottom - 20, Rect2.Right-5, Rect2.Bottom - 5);

          BtnColor := clBtnText;

          {$ifdef MSWINDOWS}
          if IsThemeApplied then
          begin
            pid := TP_BUTTON;
            if FDownBtnPressed then
              sid := TS_PRESSED
            else
              sid := TS_HOT;
            DrawThemeBackground(Theme, TmpCanvas.Handle, pid, sid, Rect1, nil);
          end
          else
          {$endif}
          begin
            if BackgroundType = bgtColorFill then
            begin
              TmpCanvas.Brush.Color := ScrollButtonColor;
              TmpCanvas.FillRect(Rect1);
            end
            else
              BtnColor := ItemsFont.Color;
            DrawButtonFrameEx3(TmpCanvas.Handle, Rect1, false, FDownBtnPressed, ScrollButtonColor, true, AllBorderSides);
          end;
          if FDownBtnPressed then
            OffsetRect(Rect1, 1, 1);

          DrawArrow(TmpCanvas, eadDown, Rect1, BtnColor, true);
        end;
      end;
    end;

var Section : TElSideBarSection;
    // CRef    : COLORREF;
    P : TPoint;
begin
  TmpCanvas := Canvas;

  if Transparent then
  begin
    GetClipBox(TmpCanvas.Handle, R);
    P := Parent.ScreenToClient(ClientToScreen(Point(Left, Top)));
    OffsetRect(R, P.X, P.Y);
    RedrawWindow(Parent.Handle, @R, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW);
  end;
  R := ClientRect;
  R3 := R;
  R1 := GetTopSectionsRect;
  sh := GetSectionHeight;
  R1.Bottom := R1.Top + sh;
  if (FSection <> nil) and (VisibleSections) then
  begin
    for i := 0 to FSection.Index do    // Iterate
    begin
      Section := Sections[i];
      if Section.Visible then
      begin
        GetClipBox(Canvas.Handle, R2);
        IntersectRect(R2, R2, R1);
        if not IsRectEmpty(R2) then
          PaintSection(Section, R1);

        R1.Top := R1.Bottom;
        R1.Bottom := R1.Top + sh;
        Inc(R3.Top, sh);
      end
      else
      begin
        SetRectEmpty(Section.FBoundRect);
        SetRectEmpty(Section.FTextRect);
      end;
    end;    // for

    R1 := GetBottomSectionsRect;
    R3.Bottom := R1.Top;
    R1 := R3;

    if not FSection.ContainsControls then
    begin
      if not Transparent then
      begin
        {$ifdef MSWINDOWS}
        if IsThemeApplied then
        begin
          TmpCanvas.Brush.Color := GetThemeSysColor(Theme, TMT_BTNSHADOW);
          GetClipBox(Canvas.Handle, R2);
          IntersectRect(R2, R2, R1);
          DrawThemeBackground(Theme, TmpCanvas.Handle, 0, 0, R1, @R2);
        end
        else
        {$endif}
        begin
          TmpCanvas.Brush.Color := Color;
          GetClipBox(Canvas.Handle, R2);
          IntersectRect(R2, R2, R1);
          if not IsRectEmpty(R2) and (BackgroundType = bgtColorFill) then
          begin
            TmpCanvas.FillRect(R2);
          end;
        end;
      end;

      PaintItems(R1, R3);
    end;

    R1 := GetBottomSectionsRect;
    R1.Top := R1.Bottom - sh;

    for i := FSections.Count - 1 downto FSection.Index + 1 do    // Iterate
    begin
      Section := Sections[i];
      if Section.Visible then
      begin
        GetClipBox(Canvas.Handle, R2);
        IntersectRect(R2, R2, R1);
        if not IsRectEmpty(R2) then
          PaintSection(Section, R1);
        Dec(R.Bottom, sh);
        R1.Top := R1.Top - sh;
        R1.Bottom := R1.Top + sh;
      end;
    end;    // for
  end
  else
  begin
    if not Transparent then
    begin
      {$ifdef MSWINDOWS}
      if IsThemeApplied then
      begin
        TmpCanvas.Brush.Color := GetThemeSysColor(Theme, TMT_BTNSHADOW);
      end
      else
      {$endif}
        TmpCanvas.Brush.Color := Color;
      R1 := ClientRect;
      GetClipBox(Canvas.Handle, R2);
      IntersectRect(R2, R2, R1);
      if (not IsRectEmpty(R2)) and (BackgroundType = bgtColorFill) then
        TmpCanvas.FillRect(R2);
    end;
    if FSection <> nil then
      PaintItems(R, R)
    else
    if (not IsThemeApplied) and (BackgroundType <> bgtColorFill) then
      FillItemsBackground(R);
  end;
end;  { Paint }
{$warnings on}

procedure TElSideBar.TriggerItemChangeEvent;
begin
{$IFDEF USE_SOUND_MAP}
  if Assigned(FSoundMap) then SoundMap.Play(FItemChangeSound);
{$ENDIF}
  if (assigned(FOnItemChange)) then FOnItemChange(Self);
end;  { TriggerItemChangeEvent }

procedure TElSideBar.TriggerSectionChangeEvent;
begin
{$IFDEF USE_SOUND_MAP}
  if Assigned(FSoundMap) then SoundMap.Play(FSectionChangeSound);
{$ENDIF}
  if (assigned(FOnSectionChange)) then FOnSectionChange(Self);
end;  { TriggerSectionChangeEvent }

procedure TElSideBar.SetSectionTracking(newValue : Boolean);
{ Sets data member FSectionTracking to newValue. }
begin
  if (FSectionTracking <> newValue) then
  begin
    FSectionTracking := newValue;
    if VisibleSections and (FTrackSection <> nil) then UpdateAllSections;
  end;  { if }
end;  { SetSectionTracking }

procedure TElSideBar.SetItemTracking(newValue : Boolean);
{ Sets data member FItemTracking to newValue. }
begin
  if (FItemTracking <> newValue) then
  begin
    FItemTracking := newValue;
    if FSection <> nil then UpdateItems;
  end;  { if }
end;  { SetItemTracking }

procedure TElSideBar.SetUnderlineTracked(newValue : Boolean);
{ Sets data member FUnderlineTracked to newValue. }
begin
  if (FUnderlineTracked <> newValue) then
  begin
    FUnderlineTracked := newValue;
    UpdateBar;
  end;  { if }
end;  { SetUnderlineTracked }

{$IFDEF USE_SOUND_MAP}
procedure TElSideBar.SetSoundMap(newValue : TElSoundMap);
begin
  if (FSoundMap <> newValue) then
  begin
    {$ifdef VCL_5_USED}
    if FSoundMap <> nil then
      if not (csDestroying in FSOundMap.ComponentState) then
        FSoundMap.RemoveFreeNotification(Self);
    {$endif}
    FSoundMap := newValue;
    {$ifdef VCL_5_USED}
    if FSoundMap <> nil then
      FSoundMap.FreeNotification(Self);
    {$endif}
  end;
end;  { SetSoundMap }
{$ENDIF}

procedure TElSideBar.SetSectionImages(newValue : TImageList);
begin
  if (FSectionImages <> newValue) then
  begin
    if FSectionImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FSectionImages.ComponentState) then
        FSectionImages.RemoveFreeNotification(Self);
      {$endif}
      FSectionImages.UnRegisterChanges(FSImagesLink);
    end;
    FSectionImages := newValue;
    if FSectionImages <> nil then
    begin
      FSectionImages.RegisterChanges(FSImagesLink);
      FSectionImages.FreeNotification(Self);
    end;
    UpdateAllSections;
  end;  { if }
end;  { SetSectionImages }

procedure TElSideBar.SetAlphaSectionImages(newValue : TImageList);
begin
  if (FAlphaSectionImages <> newValue) then
  begin
    if FAlphaSectionImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FAlphaSectionImages.ComponentState) then
        FAlphaSectionImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaSectionImages.UnRegisterChanges(FASImagesLink);
    end;
    FAlphaSectionImages := newValue;
    if FAlphaSectionImages <> nil then
    begin
      FAlphaSectionImages.RegisterChanges(FASImagesLink);
      FAlphaSectionImages.FreeNotification(Self);
    end;
    UpdateAllSections;
  end;  { if }
end;  { SetAlphaSectionImages }

procedure TElSideBar.SetSectionHotImages(newValue : TImageList);
begin
  if (FSectionHotImages <> newValue) then
  begin
    if FSectionHotImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FSectionHotImages.ComponentState) then
        FSectionHotImages.RemoveFreeNotification(Self);
      {$endif}
      FSectionHotImages.UnRegisterChanges(FSHImagesLink);
    end;
    FSectionHotImages := newValue;
    if FSectionHotImages <> nil then
    begin
      FSectionHotImages.RegisterChanges(FSHImagesLink);
      FSectionHotImages.FreeNotification(Self);
    end;
    if FTrackSection <> nil then UpdateSection(FTrackSection);
  end;  { if }
end;  { SetSectionHotImages }

procedure TElSideBar.SetAlphaSectionHotImages(newValue : TImageList);
begin
  if (FAlphaSectionHotImages <> newValue) then
  begin
    if FAlphaSectionHotImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FAlphaSectionHotImages.ComponentState) then
        FAlphaSectionHotImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaSectionHotImages.UnRegisterChanges(FASHImagesLink);
    end;
    FAlphaSectionHotImages := newValue;
    if FAlphaSectionHotImages <> nil then
    begin
      FAlphaSectionHotImages.RegisterChanges(FASHImagesLink);
      FAlphaSectionHotImages.FreeNotification(Self);
    end;
    if FTrackSection <> nil then UpdateSection(FTrackSection);
  end;  { if }
end;  { SetAlphaSectionHotImages }

procedure TElSideBar.SetSectionDisabledImages(newValue : TImageList);
begin
  if (FSectionDisabledImages <> newValue) then
  begin
    if FSectionDisabledImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FSectionDisabledImages.ComponentState) then
        FSectionDisabledImages.RemoveFreeNotification(Self);
      {$endif}
      FSectionDisabledImages.UnRegisterChanges(FSDImagesLink);
    end;
    FSectionDisabledImages := newValue;
    if FSectionDisabledImages <> nil then
    begin
      FSectionDisabledImages.RegisterChanges(FSDImagesLink);
      FSectionDisabledImages.FreeNotification(Self);
    end;
    UpdateAllSections;
  end;  { if }
end;  { SetSectionDisabledImages }

procedure TElSideBar.SetAlphaSectionDisabledImages(newValue : TImageList);
begin
  if (FAlphaSectionDisabledImages <> newValue) then
  begin
    if FAlphaSectionDisabledImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FAlphaSectionDisabledImages.ComponentState) then
        FAlphaSectionDisabledImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaSectionDisabledImages.UnRegisterChanges(FASDImagesLink);
    end;
    FAlphaSectionDisabledImages := newValue;
    if FAlphaSectionDisabledImages <> nil then
    begin
      FAlphaSectionDisabledImages.RegisterChanges(FASDImagesLink);
      FAlphaSectionDisabledImages.FreeNotification(Self);
    end;
    UpdateAllSections;
  end;  { if }
end;  { SetAlphaSectionDisabledImages }

procedure TElSideBar.SetItemDisabledImages(newValue : TImageList);
begin
  if (FItemDisabledImages <> newValue) then
  begin
    if FItemDisabledImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FItemDisabledImages.ComponentState) then
        FItemDisabledImages.RemoveFreeNotification(Self);
      {$endif}
      FItemDisabledImages.UnRegisterChanges(FIDImagesLink);
    end;
    FItemDisabledImages := newValue;
    if FItemDisabledImages <> nil then
    begin
      FItemDisabledImages.RegisterChanges(FIDImagesLink);
      FItemDisabledImages.FreeNotification(Self);
    end;
    if (FSection <> nil) and (FSection.Items.Count > 0) then UpdateItems;
  end;  { if }
end;  { SetItemDisabledImages }

procedure TElSideBar.SetAlphaItemDisabledImages(newValue : TImageList);
begin
  if (FAlphaItemDisabledImages <> newValue) then
  begin
    if FAlphaItemDisabledImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FAlphaItemDisabledImages.ComponentState) then
        FAlphaItemDisabledImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaItemDisabledImages.UnRegisterChanges(FAIDImagesLink);
    end;
    FAlphaItemDisabledImages := newValue;
    if FAlphaItemDisabledImages <> nil then
    begin
      FAlphaItemDisabledImages.RegisterChanges(FAIDImagesLink);
      FAlphaItemDisabledImages.FreeNotification(Self);
    end;
    if (FSection <> nil) and (FSection.Items.Count > 0) then UpdateItems;
  end;  { if }
end;  { SetAlphaItemDisabledImages }

procedure TElSideBar.SetItemHotImages(newValue : TImageList);
begin
  if (FItemHotImages <> newValue) then
  begin
    if FItemHotImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FItemHotImages.ComponentState) then
        FItemHotImages.RemoveFreeNotification(Self);
      {$endif}
      FItemHotImages.UnRegisterChanges(FIHImagesLink);
    end;
    FItemHotImages := newValue;
    if FItemHotImages <> nil then
    begin
      FItemHotImages.RegisterChanges(FIHImagesLink);
      FItemHotImages.FreeNotification(Self);
    end;

    if (FTrackItem <> nil) and (FSection <> nil) and (FSection.Items.Count <> 0) then UpdateItems;
  end;  { if }
end;  { SetItemHotImages }

procedure TElSideBar.SetAlphaItemHotImages(newValue : TImageList);
begin
  if (FAlphaItemHotImages <> newValue) then
  begin
    if FAlphaItemHotImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FAlphaItemHotImages.ComponentState) then
        FAlphaItemHotImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaItemHotImages.UnRegisterChanges(FAIHImagesLink);
    end;
    FAlphaItemHotImages := newValue;
    if FAlphaItemHotImages <> nil then
    begin
      FAlphaItemHotImages.RegisterChanges(FAIHImagesLink);
      FAlphaItemHotImages.FreeNotification(Self);
    end;

    if (FTrackItem <> nil) and (FSection <> nil) and (FSection.Items.Count <> 0) then UpdateItems;
  end;  { if }
end;  { SetAlphaItemHotImages }

procedure TElSideBar.SetItemImages(newValue : TImageList);
begin
  if (FItemImages <> newValue) then
  begin
    if FItemImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FItemImages.ComponentState) then
        FItemImages.RemoveFreeNotification(Self);
      {$endif}
      FItemImages.UnRegisterChanges(FIImagesLink);
    end;
    FItemImages := newValue;
    if FItemImages <> nil then
    begin
      FItemImages.RegisterChanges(FIImagesLink);
      FItemImages.FreeNotification(Self);
    end;

    if (FSection <> nil) and (FSection.Items.Count <> 0) then UpdateItems;
  end;  { if }
end;  { SetItemImages }

procedure TElSideBar.SetAlphaItemImages(newValue : TImageList);
begin
  if (FAlphaItemImages <> newValue) then
  begin
    if FAlphaItemImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FAlphaItemImages.ComponentState) then
        FAlphaItemImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaItemImages.UnRegisterChanges(FAIImagesLink);
    end;
    FAlphaItemImages := newValue;
    if FAlphaItemImages <> nil then
    begin
      FAlphaItemImages.RegisterChanges(FAIImagesLink);
      FAlphaItemImages.FreeNotification(Self);
    end;

    if (FSection <> nil) and (FSection.Items.Count <> 0) then UpdateItems;
  end;  { if }
end;  { SetAlphaItemImages }

procedure TElSideBar.SetSectionsPopupMenu(newValue : TPopupMenu);
begin
  if newValue <> FSectionsPopup then
  begin
    {$ifdef VCL_5_USED}
    if FSectionsPopup <> nil then
      if not (csDestroying in FSectionsPopup.ComponentState) then
        FSectionsPopup.RemoveFreeNotification(Self);
    {$endif}
    FSectionsPopup := newValue;
    if FSectionsPopup <> nil then FSectionsPopup.FreeNotification(Self);
  end;
end;

procedure TElSideBar.SetItemsPopupMenu(newValue : TPopupMenu);
begin
  if newValue <> FItemsPopup then
  begin
    {$ifdef VCL_5_USED}
    if FItemsPopup <> nil then
      if not (csDestroying in FItemsPopup.ComponentState) then
        FItemsPopup.RemoveFreeNotification(Self);
    {$endif}
    FItemsPopup := newValue;
    if FItemsPopup <> nil then FItemsPopup.FreeNotification(Self);
  end;
end;

procedure TElSideBar.Notification(AComponent : TComponent; operation : TOperation);
var b : boolean;
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
    b := false;
{$IFDEF USE_SOUND_MAP}
    if (AComponent = FSoundMap) then SoundMap := nil;
{$ENDIF}
    if AComponent = FItemsPopup then ItemsPopupMenu := nil;
    if AComponent = FSectionsPopup then SectionsPopupMenu := nil;
    if (AComponent = FSectionImages) then
    begin
      SectionImages := nil;
      b := true;
    end;
    if (AComponent = FSectionHotImages) then
    begin
      SectionHotImages := nil;
      b := true;
    end;
    if (AComponent = FSectionDisabledImages) then
    begin
      SectionDisabledImages := nil;
      b := true;
    end;
    if (AComponent = FItemDisabledImages) then
    begin
      ItemDisabledImages := nil;
      b := true;
    end;
    if (AComponent = FItemHotImages) then
    begin
      ItemHotImages := nil;
      b := true;
    end;
    if (AComponent = FItemImages) then
    begin
      ItemImages := nil;
      b := true;
    end;

    if (AComponent = FAlphaSectionImages) then
    begin
      AlphaForSectionImages := nil;
      b := true;
    end;
    if (AComponent = FAlphaSectionHotImages) then
    begin
      AlphaForSectionHotImages := nil;
      b := true;
    end;
    if (AComponent = FAlphaSectionDisabledImages) then
    begin
      AlphaForSectionDisabledImages := nil;
      b := true;
    end;
    if (AComponent = FAlphaItemDisabledImages) then
    begin
      AlphaForItemDisabledImages := nil;
      b := true;
    end;
    if (AComponent = FAlphaItemHotImages) then
    begin
      AlphaForItemHotImages := nil;
      b := true;
    end;
    if (AComponent = FAlphaItemImages) then
    begin
      AlphaForItemImages := nil;
      b := true;
    end;
    if b then UpdateBar;
  end;  { if }
end;  { Notification }

procedure TElSideBar.WMPaint(var Msg : TWMPaint);  { private }
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R : TRect;
begin
  inherited;
  exit;
  if (Msg.DC <> 0) then PaintHandler(Msg)
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      //Perform(WM_ERASEBKGND, MemDC, MemDC);
      GetClipBox(DC, R);
      if IsRectEmpty(R) then R := ClientRect;
      Msg.DC := MemDC;
      if Transparent then
      begin
        with R do
          BitBlt(MemDC, Left, Top, Right, Bottom, DC, Left, Top, SRCCOPY);
      end;

      WMPaint(Msg);
      Msg.DC := 0;
      with R do
        BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;  { WMPaint }

procedure TElSideBar.BeginUpdate;  { public }
begin
  inc(FUpdateCount);
  if FUpdateCount = 1 then SendMessage(Handle, WM_SETREDRAW, 0, 0);
end;  { BeginUpdate }

procedure TElSideBar.EndUpdate;  { public }
begin
  dec(FUpdateCount);
  if FUpdateCount = 0 then
  begin
    if (FUpdateCount = 0) and (HandleAllocated) then
    begin
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
      if (FSection <> nil) and (FSection.FContainsControls) then
        UpdateChildControl;
      Invalidate;
    end;
  end;
end;  { EndUpdate }

function TElSideBar.GetSectionRect(Section : TElSideBarSection) : TRect;
var i : integer;
    sh: integer;
    R : TRect;
begin
  if (FSection = nil) or (not VisibleSections) or (Section = nil) or (not Section.Visible) then
  begin
    SetRectEmpty(result);
    exit;
  end else
  begin
    if FSection.Index >= Section.Index then
    begin
      sh := GetSectionHeight;
      R := Rect(0, 0, ClientWidth, sh);
      for i := 0 to Section.Index -1 do    // Iterate
      begin
        if Sections[i].Visible then
        begin
          R.Top := R.Bottom;
          R.Bottom := R.Top + sh;
        end;
      end;    // for
      result := R;
      exit;
    end else
    begin
      sh := GetSectionHeight;
      R := Rect(0, ClientHeight - sh, ClientWidth, ClientHeight);
      for i := Sections.Count - 1 downto Section.Index + 1 do    // Iterate
      begin
        if Sections[i].Visible then
        begin
          R.Bottom := R.Top;
          R.Top := R.Top - sh;
        end;
      end;    // for
      result := R;
      exit;
    end;
  end;
end;

function TElSideBar.GetItemHeight : integer;
begin
  result := Abs(FItemsFont.Height) + Spacing + BarAdjust + ItemSize;
end;

function TElSideBar.GetSectionHeight : integer;
begin
  if FSectionHeight > 0 then result := FSectionHeight else
  begin
    result := Abs(Font.Height) + 4 + BarAdjust ;
    if SectionImages <> nil then result := Max(result, SectionImages.Height + BarAdjust);
  end;
end;

function TElSideBar.GetItemsRect : TRect;
var R : TRect;
begin
  result := ClientRect;
  if VisibleSections then
  begin
    R := GetTopSectionsRect;
    SubtractRect(result, result, R);
    R := GetBottomSectionsRect;
    SubtractRect(result, result, R);
  end;
end;

function TElSideBar.GetTopSectionsRect : TRect;
var i  : integer;
    h,
    sh : integer;
begin
  if (FSection = nil) or (not VisibleSections) then
  begin
    SetRectEmpty(result);
    exit;
  end;
  h := 0;
  sh := GetSectionHeight;
  for i := 0 to FSection.Index do    // Iterate
  begin
    if FSections.Items[i].Visible then inc(h, sh);
  end;    // for
  Result := ClientRect;
  Result.Bottom := h;
end;

function TElSideBar.GetBottomSectionsRect : TRect;
var i  : integer;
    h,
    sh : integer;
begin
  if (FSection = nil) or (not VisibleSections) then
  begin
    SetRectEmpty(result);
    exit;
  end;
  h := 0;
  sh := GetSectionHeight;
  for i := FSection.Index + 1 to Sections.Count - 1 do    // Iterate
  begin
    if FSections.Items[i].Visible then inc(h, sh);
  end;    // for
  Result := ClientRect;
  Result.Top := Result.Bottom - h;
end;

procedure TElSideBar.UpdateAllSections;
begin
  UpdateBar;
end;

procedure TElSideBar.UpdateSection(Section : TElSideBarSection);
var R : TRect;
begin
  if (FUpdateCount = 0) and HandleAllocated and (Section.Visible) and VisibleSections then
  begin
    R := GetSectionRect(Section);
    InvalidateRect(Handle, @R, false);
    //Update;
  end;
end;

procedure TElSideBar.UpdateTopSections;
var R : TRect;
begin
  if (FUpdateCount = 0) and HandleAllocated and VisibleSections then
  begin
    SubtractRect(R, ClientRect, GetBottomSectionsRect);
    InvalidateRect(Handle, @R, false);
    //Update;
  end;
end;

procedure TElSideBar.UpdateBottomSections;
var R : TRect;
begin
  if (FUpdateCount = 0) and HandleAllocated and VisibleSections then
  begin
    SubtractRect(R, ClientRect, GetBottomSectionsRect);
    InvalidateRect(Handle, @R, false);
    //Update;
  end;
end;

procedure TElSideBar.DrawFlatBorder;
var
  DC : HDC;
  R  : TRect;
  b  : boolean;
  BS : TElFlatBorderType;
  AColor : TColor;
  RW,
  RC     : TRect;

begin
  if IsThemeApplied and (BorderStyle = bsSingle) then
  begin
    R := Rect(0, 0, Width, Height);

    DC := GetWindowDC(Handle);
    try
      R := Rect(0, 0, Width, Height);
      Windows.GetClientRect(Handle, RC);
      GetWindowRect(Handle, RW);
      MapWindowPoints(0, Handle, RW, 2);
      OffsetRect(RC, -RW.Left, -RW.Top);
      ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
      OffsetRect(RW, -RW.Left, -RW.Top);

      DrawThemeBackgroundTo('EDIT', DC, 0, 0, RW, nil);
    finally
      ReleaseDC(Handle, DC);
    end;
    exit;
  end
  else
  begin
    if BorderStyle = bsSingle then
    begin
      R := Rect(0, 0, Width, Height);
      DC := GetWindowDC(Handle);
      try
        b := Focused or FMouseOver;
        if b then BS := FActiveBorderType else BS := FInactiveBorderType;
        if Focused or FMouseOver then
          AColor := LineBorderActiveColor
        else
          AColor := LineBorderInactiveColor;

        DrawFlatFrameEx2(DC, R, Acolor, Color, b, Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
      finally
        ReleaseDC(Handle, DC);
      end;
    end;
  end;
end;

procedure TElSideBar.UpdateFrame; { protected }
var
  R : TRect;
begin
  if HandleAllocated and (BorderStyle = bsSingle) then
  begin
    R := Rect(0, 0, Width, Height);
    RedrawWindow(Handle, @R, 0, rdw_Invalidate or rdw_UpdateNow or rdw_Frame);
  end;
end; { UpdateFrame }

procedure TElSideBar.UpdateBar;
  var
    R: TRect;
    i: Integer;
begin
  if (FUpdateCount = 0) and HandleAllocated then
  begin

    if (FSection = nil) or ((FSection <> nil) and (not FSection.Visible)) then
    begin
      FSection := nil;
      for i := 0 to Sections.Count -1 do
        if Sections[i].Visible then
        begin
          FSection := Sections[i];
          Break;
        end;
    end;

    R := ClientRect;
    InvalidateRect(Handle, @R, false);
    //Update;
  end;
end;

procedure TElSideBar.UpdateItems;
var R : TRect;
begin
  if (FUpdateCount = 0) and HandleAllocated then
  begin
    SubtractRect(R, ClientRect, GetBottomSectionsRect);
    SubtractRect(R, R, GetTopSectionsRect);
    InvalidateRect(Handle, @R, false);
    //Update;
  end;
end;

procedure TElSideBar.CMMouseEnter(var Msg : TMessage);  { private }
begin
  inherited;
  FMouseOver := true;
  if Flat and (not Focused) and (not IsThemeApplied) then UpdateFrame;
end;  { CMMouseEnter }

procedure TElSideBar.CMMouseLeave(var Msg : TMessage);  { private }
var Section : TElSideBarSection;
begin
  inherited;
  if (Msg.LParam = 0) or (Msg.LParam = Integer(Self)) then
  begin
    FMouseOver := false;
    if (FTrackSection <> nil) then
    begin
      Section := FTrackSection;
      FTrackSection := nil;
      UpdateSection(Section);
    end;
    if FTrackItem <> nil then
    begin
      FTrackItem := nil;
      UpdateItems;
    end;
    if Flat and (not Focused) and (not IsThemeApplied) then UpdateFrame;
  end;
end;  { CMMouseLeave }

procedure TElSideBar.CMEnter(var Msg : TCMEnter);  { private }
begin
  inherited;
  if Flat and (not IsThemeApplied) then UpdateFrame;
end;  { CMEnter }

procedure TElSideBar.CMExit(var Msg : TCMExit);  { private }
begin
  inherited;
  if Flat and (not IsThemeApplied) then UpdateFrame;
end;  { CMExit }

procedure TElSideBar.WMNCPaint(var Msg : TMessage);  { private }
begin
  if not (Flat or IsThemeApplied) then
  begin
    inherited;
    exit;
  end;
  DrawFlatBorder;
  Msg.Result := 0;
end;  { WMNCPaint }

procedure TElSideBar.SetFlat(newValue : Boolean);
{ Sets data member FFlat to newValue. }
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    UpdateFrame;
  end;  { if }
end;  { SetFlat }

procedure TElSideBar.GetHitTest(X, Y : integer; var BarPart : TElSideBarPart; var Section : TElSideBarSection; var Item : TElSideBarItem);  { public }
var R,
    SR : TRect;
    P  : TPoint;
    i,
    sh : integer;
begin
  P := Point(x, y);
  Section := nil;
  Item := nil;
  if VisibleSections and (FSection <> nil) then
  begin
    R := GetTopSectionsRect;
    if PtInRect(R, P) then
    begin
      BarPart := sbpSection;
      sh := GetSectionHeight;
      R.Bottom := R.Top + sh;
      for i := 0 to FSection.Index do    // Iterate
      begin
        if Sections[i].Visible then
        begin
          if (Y < R.Bottom) and (Y >= R.Top) then
          begin
            Section := Sections[i];
            break;
          end;
          R.Top := R.Bottom;
          R.Bottom := R.Top + sh;
        end;
      end;    // for
      exit;
    end;

    R := GetBottomSectionsRect;
    if PtInRect(R, P) then
    begin
      BarPart := sbpSection;
      sh := GetSectionHeight;
      R.Top := R.Bottom - sh;
      for i := Sections.Count - 1 downto FSection.Index + 1 do    // Iterate
      begin
        if Sections[i].Visible then
        begin
          if (Y < R.Bottom) and (Y >= R.Top) then
          begin
            Section := Sections[i];
            break;
          end;
          R.Bottom := R.Top;
          R.Top := R.Bottom - sh - 1;
        end;
      end;    // for
      exit;
    end;
    R := ClientRect;
    R.Top := GetTopSectionsRect.Bottom;
    R.Bottom := GetBottomSectionsRect.Top - 1;
  end else
  if (FSection <> nil) then
  begin
    R := ClientRect;
  end;
  // Now find the proper button
  if (FSection <> nil) and (FTopItem <> nil) then
  begin
    if FVisUpBtn then
    begin
      if RightAlignedBar
         then SR := Rect(R.Left + 5, R.Top+5, R.Left + 20, R.Top+20)
         else SR := Rect(R.Right-20, R.Top+5, R.Right-5, R.Top+20);
      if PtInRect(SR, P) then
      begin
        BarPart := sbpUpScroll;
        exit;
      end;
    end;
    if FVisDownBtn then
    begin
      if RightAlignedBar
         then SR := Rect(R.Left + 5, R.Bottom - 20, R.Left + 20, R.Bottom - 5)
         else SR := Rect(R.Right-20, R.Bottom - 20, R.Right-5, R.Bottom - 5);
      if PtInRect(SR, P) then
      begin
        BarPart := sbpDownScroll;
        exit;
      end;
    end;

    // No buttons? Definitely an item (unless empty space :))
    for i := 0 to FSection.Items.Count - 1 do    // Iterate
    begin
      Item := FSection.Items[i];
      if Item.Visible then
      begin
        if PtInRect(Item.FBoundRect, P) then
        begin
          BarPart := sbpItemImage;
          exit;
        end;
        SR := Item.FTextRect;
        dec(SR.Top, FSpacing);
        if PtInRect(SR, P) then
        begin
          BarPart := sbpItemText;
          exit;
        end;
      end;
    end;    // for
    Item := nil;
  end;
  BarPart := sbpInside;
end;  { GetHitTest }

procedure TElSideBar.ItemRemoved(Sender : TObject; Item : TCollectionItem);
var i : integer;
    AnItem : TElSideBarItem;
begin
  if Item = FTrackItem then FTrackItem := nil;
  if Item = FItem then
  begin
    FItem := nil;
    if (not (csDestroying in ComponentState)) and (not (csLoading in ComponentState)) then
      TriggerItemChangeEvent;
  end;
  if Item = FTopItem then
  begin
    i := Item.Index;
    if i > 0 then
    begin
      dec(i);
      while i >=0 do
      begin
        AnItem := TElSideBarItem(Item.Collection.Items[i]);
        if AnItem.Visible then
        begin
          FTopItem := AnItem;
          break;
        end;
        dec(i);
      end;
    end;
    if i <= 0 then
    begin
      i := Item.Index + 1;
      while i < Item.Collection.Count do
      begin
        AnItem := TElSideBarItem(Item.Collection.Items[i]);
        if AnItem.Visible then
        begin
          FTopItem := AnItem;
          break;
        end;
        inc(i);
      end;
      if i = Item.Collection.Count then FTopItem := nil;
    end;
  end;
  if Item = FDownItem then FDownItem := nil;
end;

procedure TElSideBar.ItemAdded(Sender : TObject; Item : TCollectionItem);
begin
  if (FSection <> nil) and (Sender = FSection.Items) and (TElSideBarItem(Item).Visible) and (FTopItem = nil) then
  begin
    FTopItem := TElSideBarItem(Item);
  end;
end;

procedure TElSideBar.UpdateChildControl;
begin
  if (FSection <> nil) and (FSection.FContainsControls) then
  begin
    if HandleAllocated and (FSection.FPanel <> nil) then
    begin
      FSection.FPanel.BoundsRect := GetItemsRect;
      //FSection.FPanel.Align := alClient;
      FSection.FPanel.Visible := true;
    end;
  end;
end;

procedure TElSideBar.SectionRemoved(Sender : TObject; Item : TCollectionItem);
var i : integer;
begin
  if Item = FSection then
  begin
    i := Item.Index;
    if i > 0 then
    begin
      dec(i);
      while i >=0 do
      begin
        if Sections[i].Visible and Sections[i].Enabled then
        begin
          SectionIndex := i;
          i := Sections.Count + 1;
          break;
        end;
        dec(i);
      end;
    end;
    if i <= 0 then
    begin
      i := Item.Index + 1;
      while i < Sections.Count do
      begin
        if Sections[i].Visible and Sections[i].Enabled then
        begin
          SectionIndex := i;
          break;
        end;
        inc(i);
      end;
      if i = Sections.Count then SectionIndex := -1;
    end;
  end;
  if Item = FTrackSection then FTrackSection := nil;
  if Item = FDownSection then FDownSection := nil;
  if (FSection <> nil) and (FSection.FContainsControls) then UpdateChildControl;
end;

procedure TElSideBar.SectionAdded(Sender : TObject; Item : TCollectionItem);
var i : integer;
    AnItem : TElSideBarItem;
begin
  if TElSideBarSection(Item).Visible then
  begin
    if Height < GetMinHeight then
      Height := GetMinHeight;
    if FSection = nil then
    begin
      if TElSideBarSection(Item).Visible and TElSideBarSection(Item).Enabled then
      begin
        if (FSection <> nil) and (FSection.FContainsControls) and
           (FSection.FPanel <> nil) then
           FSection.FPanel.Visible := false;
        FSection := TElSideBarSection(Item);
        if (FSection <> nil) and (FSection.FContainsControls) and
           (FSection.FPanel <> nil) then
           FSection.FPanel.Visible := true;

        if FSection.Items.Count > 0 then
        begin
          i := 0;
          while i < FSection.Items.Count do
          begin
            AnItem := FSection.Items[i];
            if AnItem.Visible then
            begin
              if FTopItem = nil then
                FTopItem := AnItem;
              if (FItem = nil) and AnItem.Enabled then
              begin
                FItem := AnItem;
                if (not (csDestroying in ComponentState)) and (not (csLoading in ComponentState)) then
                  TriggerItemChangeEvent;
              end;
            end;
            inc(i);
          end;
        end;
      end;
    end;
  end;
  if (FSection <> nil) and (FSection.FContainsControls) then UpdateChildControl;
end;

procedure TElSideBar.SetFlatSections(newValue: Boolean);
begin
  if (FFlatSections <> newValue) then
  begin
    FFlatSections := newValue;
    UpdateAllSections;
  end;  {if}
end;

procedure TElSideBar.SetFlatActiveItem(Value : boolean);
begin
  if FFlatActiveItem <> Value then
  begin
    FFlatActiveItem := Value;
    UpdateItems;
  end;
end;

procedure TElSideBar.SetFlatItems(newValue: Boolean);
begin
  if (FFlatItems <> newValue) then
  begin
    FFlatItems := newValue;
    UpdateItems;
  end;  {if}
end;

procedure TElSideBar.SectionsFontChanged(Sender: TObject);
begin
  UpdateAllSections;
end;

procedure TElSideBar.ItemsFontChanged(Sender: TObject);
begin
  if (FSection <> nil) and (FSection.Items.Count > 0) then UpdateItems;
end;

procedure TElSideBar.SetItemsFont(newValue: TFont);
begin
  FItemsFont.Assign(newValue);
end;

function TElSideBar.GetSectionsFont: TFont;
begin
  result := Font;
end;

procedure TElSideBar.SetSectionsFont(newValue: TFont);
begin
  Font.Assign(newValue);
end;

procedure TElSideBar.SetVisibleSections(newValue : Boolean);
{ Sets data member FVisibleSections to newValue. }
begin
  if (FVisibleSections <> newValue) then
  begin
    FVisibleSections := newValue;
    if (FSection <> nil) and FSection.ContainsControls then
      UpdateChildControl;
    Invalidate;
  end;  { if }
end;  { SetVisibleSections }

procedure TElSideBar.ImagesChanged(Sender : TObject);  { private }
begin
  if VisibleSections then
  begin
    if (Sender = FSectionImages) or (Sender = FSectionDisabledImages) then UpdateAllSections else
    if (Sender = FSectionHotImages) and (FTrackSection <> nil) then UpdateSection(FTrackSection);
  end;
  if (FSection <> nil) and (FSection.Items.Count > 0) then
  begin
    if (Sender = FItemImages) or (Sender = Self.FItemDisabledImages) or
       ((Sender = FItemHotImages) and (FTrackItem <> nil)) then
       UpdateItems;
  end;
end;  { ImagesChanged }

procedure TElSideBar.SetRightAlignedBar(newValue : Boolean);
{ Sets data member FRightAlignedBar to newValue. }
begin
  if (FRightAlignedBar <> newValue) then
  begin
    FRightAlignedBar := newValue;
    UpdateBar;
  end;  { if }
end;  { SetRightAlignedBar }

procedure TElSideBar.SetItemSize(newValue : Integer);
{ Sets data member FItemSize to newValue. }
begin
  if (FItemSize <> newValue) and (FItemSize > 0) then
  begin
    FItemSize := newValue;
    if Height < GetMinHeight then
       Height := GetMinHeight;
    if (FSection <> nil) then
       UpdateItems;
  end;  { if }
end;  { SetItemSize }

procedure TElSideBar.SetSectionHeight(newValue : Integer);
{ Sets data member FSectionHeight to newValue. }
begin
  if (FSectionHeight <> newValue) then
  begin
    FSectionHeight := newValue;
    if VisibleSections then
       UpdateBar;
  end;  { if }
end;  { SetSectionHeight }

function TElSideBar.GetPopupMenu : TPopupMenu;
var BarPart : TElSideBarPart;
    Section : TElSideBarSection;
    Item    : TElSideBarItem;
    P : TPoint;
begin
  result := inherited GetPopupMenu;
  GetCursorPos(P);
  P := ScreenToClient(P);
  GetHitTest(P.X, P.Y, BarPart, Section, Item);
  if BarPart = sbpSection then
     if FSectionsPopup <> nil then
        result := FSectionsPopup;
  if (BarPart = sbpItemText) or (BarPart = sbpItemImage) then
     if FItemsPopup <> nil then
        result := FItemsPopup;
end;

procedure TElSideBar.WMMouseMove(var Msg : TWMMouseMove);  { private }
begin
  IntMouseMove(Msg.XPos, Msg.YPos);
  inherited;
end;  { WMMouseMove }

procedure TElSideBar.WMLButtonDown(var Msg : TWMLButtonDown);  { private }
begin
  IntMouseDown(mbLeft, Msg.XPos, Msg.YPos);
  inherited;
end;  { WMLButtonDown }

procedure TElSideBar.WMLButtonUp(var Msg : TWMLButtonUp);  { private }
begin
  IntMouseUp(mbLeft, Msg.XPos, Msg.YPos);
  inherited;
end;  { WMLButtonUp }

procedure TElSideBar.WMMouseWheel(var Msg: TWMMouseWheel);
begin
  IntMouseWheel(Msg.WheelDelta div (MOUSE_WHEEL_DELTA), SmallPointToPoint(Msg.Pos));
end; { WMMouseWheel }

procedure TElSideBar.UpdateTracks;
var P : TPoint;
begin
  if FItemTracking or FSectionTracking then
  begin
    GetCursorPos(P);
    with ScreenToClient(P) do
      IntMouseMove(X, Y);
  end;
end;

procedure TElSideBar.ScrollUp;
var i : integer;
begin
  if (FTopItem <> nil) and (FTopItem.Index > 0) then
  begin
    for i := FTopItem.Index -1 downto 0 do    // Iterate
    begin
      if FSection.Items[i].Visible then
      begin
        FTopItem := FSection.Items[i];
        UpdateItems;
        UpdateTracks;
        break;
      end;
    end;    // for
  end;
end;

procedure TElSideBar.ScrollDown;
var i : integer;
begin
  if (FTopItem <> nil) and (FTopItem.Index < FSection.Items.Count) then
  begin
    for i := FTopItem.Index +1 to FSection.Items.Count - 1 do    // Iterate
    begin
      if FSection.Items[i].Visible then
      begin
        FTopItem := FSection.Items[i];
        UpdateItems;
        UpdateTracks;
        break;
      end;
    end;    // for
  end;
end;

procedure TElSideBar.OnScrollTimer(Sender : TObject);
var R, SR : TRect;
begin
  if FSaveUpBtnPressed then
  begin
    FAutoScroll := true;
    ScrollUp;
    if not FVisUpBtn then
    begin
      if (FScrollTimer <> nil) and (FSaveUpBtnPressed) then
      begin
        FScrollTimer.Enabled := false;
        FSaveUpBtnPressed := false;
        FUpBtnPressed := false;
        R := GetItemsRect;
        if RightAlignedBar then
          SR := Rect(R.Left + 5, R.Top+5, R.Left + 20, R.Top+20)
        else
          SR := Rect(R.Right-20, R.Top+5, R.Right-5, R.Top+20);
        InvalidateRect(Handle, @SR, false);
        Update;
      end;
    end;
  end else
  if FSaveDownBtnPressed then
  begin
    FAutoScroll := true;
    ScrollDown;
    if not FVisDownBtn then
    begin
      if (FScrollTimer <> nil) and (FSaveDownBtnPressed) then
      begin
        FScrollTimer.Enabled := false;
        FSaveDownBtnPressed := false;
        FDownBtnPressed := false;
        R := GetItemsRect;
        if RightAlignedBar
           then SR := Rect(R.Left + 5, R.Bottom - 20, R.Left + 20, R.Bottom - 5)
           else SR := Rect(R.Right-20, R.Bottom - 20, R.Right-5, R.Bottom - 5);
        InvalidateRect(Handle, @SR, false);
        Update;
      end;
    end;
  end;
end;

procedure TElSideBar.UpdateSectionPanels;
var ASection : TElSideBarSection;
    i        : integer;
begin
  for i := 0 to Sections.Count -1 do
  begin
    ASection := Sections[i];
    if ASection.FContainsControls and (ASection.FPanel <> nil) then
       ASection.FPanel.Visible := false;
  end;
  ASection := FSection;
  FSection := nil;
  if ASection <> nil then
    SectionIndex := ASection.Index
  else
    SectionIndex := -1;
end;

procedure TElSideBar.WMSize(var Msg : TWMSize);  { private }
var i : integer;
begin
  i := GetMinHeight;
  if Height < i then Height := i;
  inherited;
  UpdateBar;
  if (FSection <> nil) and FSection.ContainsControls then
     UpdateChildControl;
  if Flat then
    UpdateFrame;
end;  { WMSize }

function TElSideBar.GetMinHeight : integer;
var i, j : integer;
    sh: integer;
begin
  if not VisibleSections then
    result := ItemSize
              + GetSystemMetrics(SM_CYBORDER) * 2
  else
  begin
    j := 0;
    sh := GetSectionHeight;
    for i := 0 to Sections.Count - 1 do    // Iterate
    begin
      if Sections[i].Visible then inc(j);
    end;    // for
    result := ItemSize + j * sh +
              GetSystemMetrics(SM_CYBORDER) * 2
  end;
end;

procedure TElSideBar.WMGetMinMaxInfo(var Msg : TMessage);  { private }
begin
  inherited;
  PMinMaxInfo(Msg.lParam).ptMinTrackSize.Y := GetMinHeight;
end;  { WMGetMinMaxInfo }

function TElSideBar.GetTopIndex : Integer;
{ Returns the value of data member FTopIndex. }
begin
  if FTopItem <> nil then result := FTopItem.Index else result := -1;
end;  { GetTopIndex }

procedure TElSideBar.SetTopIndex(newValue : Integer);
var Item : TElSideBarItem;
begin
  if (TopIndex <> newValue) and (NewValue >= 0) and (FSection <> nil) and (FSection.Items.Count > newValue) then
  begin
    Item := FSection.Items[newValue];
    if Item.Visible then
    begin
      FTopItem := Item;
      UpdateItems;
    end;
  end;  { if }
end;  { SetTopIndex }


procedure TElSideBar.CMHintShow(var Msg: TMessage);
begin
  inherited;
  IntHintShow(PHintInfo(Msg.lParam)^);
end;

procedure TElSideBar.SetActiveSectionStyle(newValue: TFontStyles);
begin
  if (FActiveSectionStyle <> newValue) then
  begin
    FActiveSectionStyle := newValue;
    if (FSection <> nil) and (VisibleSections) and (FUpdateCount = 0) then UpdateSection(FSection);
  end;  {if}
end;

procedure TElSideBar.SetActiveItemStyle(newValue: TFontStyles);
begin
  if (FActiveItemStyle <> newValue) then
  begin
    FActiveItemStyle := newValue;
    if (FItem <> nil) then UpdateItems;
  end;  {if}
end;

procedure TElSideBar.SetActiveBorderType(newValue : TElFlatBorderType);
{ Sets data member FActiveBorderType to newValue. }
begin
  if (FActiveBorderType <> newValue) then
  begin
    FActiveBorderType := newValue;
    if (Focused or FMouseOver) then UpdateFrame;
  end;  { if }
end;  { SetActiveBorderType }

procedure TElSideBar.SetInactiveBorderType(newValue : TElFlatBorderType);
{ Sets data member FInactiveBorderType to newValue. }
begin
  if (FInactiveBorderType <> newValue) then
  begin
    FInactiveBorderType := newValue;
    if not (Focused or FMouseOver) then UpdateFrame;
  end;  { if }
end;  { SetInactiveBorderType }

procedure TElSideBar.Loaded;  { public }
var i, j : integer;
begin
  j := 0;
  for i := 0 to ControlCount -1 do
  begin
    if Controls[i] is TElSideBarContainerPanel then
    begin
      if j < Sections.Count then
      begin
        Sections[j].FPanel := TElSideBarContainerPanel(Controls[i]);
        inc(j);
      end;
    end;
  end;
  for i := 0 to Sections.Count -1 do
     if Sections[i].FPanel = nil then
       Sections[i].AllocatePanel;
  UpdateSectionPanels;
  inherited;
end;  { Loaded }

procedure TElSideBar.SetTrackSectionFontColor(Value : TColor);
begin
  if Value <> FTrackSectionFontColor then
  begin
    FTrackSectionFontColor := Value;
    if (FTrackSection <> nil) and (FSectionTracking) and (HandleAllocated) then
      UpdateSection(FTrackSection);
  end;
end;

procedure TElSideBar.SetTrackSectionBkColor(Value : TColor);
begin
  if Value <> FTrackSectionBkColor then
  begin
    FTrackSectionBkColor := Value;
    if (FTrackSection <> nil) and (FSectionTracking) and (HandleAllocated) then
      UpdateSection(FTrackSection);
  end;
end;

procedure TElSideBar.SetTrackItemFontColor(Value : TColor);
begin
  if Value <> FTrackItemFontColor then
  begin
    FTrackItemFontColor := Value;
    if (FTrackItem <> nil) and (FItemTracking) and (HandleAllocated) then
      InvalidateRect(Handle, @(FTrackItem.FBoundRect), false);
  end;
end;

procedure TElSideBar.SetTrackItemBkColor(Value : TColor);
begin
  if Value <> FTrackItemBkColor then
  begin
    FTrackItemBkColor := Value;
    if (FTrackItem <> nil) and (FItemTracking) and (HandleAllocated) then
      InvalidateRect(Handle, @(FTrackItem.FBoundRect), false);
  end;
end;

procedure TElSideBar.CMControlChange(var Msg : TCMControlChange);  { private }
begin
  inherited;
  with Msg do
  begin
    if Inserting then
    begin
      //if csLoading in ComponentState

      {if (FSection <> nil) and (FSection.FContainsControls) then
      begin
        if not (Control is TElSideBarContainerPanel) then
          Control.Parent := FSection.FPanel;
      end
      else
        if not (Control is TElSideBarContainerPanel) then
          raise Exception.Create('Controls should be inserted to the Section Container, not to the ElSideBar itself');
      }
    end;
  end;  { with }
end;  { CMControlChange }

procedure TElSideBar.CMDialogChar(var Msg: TCMDialogChar);
var
  I: integer;
begin
  if Focused and (SectionIndex >= 0) then
    for I := 0 to FSections[SectionIndex].FItems.Count - 1 do
      if IsAccel(Msg.CharCode, FSections[SectionIndex].FItems[I].FCaption) then
      begin
        ItemIndex := I;
        Msg.Result := 1;
        exit;
      end;
  for I := 0 to FSections.Count - 1 do
    if IsAccel(Msg.CharCode, FSections[I].FCaption) then
    begin
      SectionIndex := I;
      if not Focused then SetFocus;
      Msg.Result := 1;
      exit;
    end;
  inherited;
end;

procedure TElSideBar.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (((Key = VK_TAB) and (Shift = [ssCtrl])) or (Key = VK_NEXT)) and
(FSections.Count > 1) then
    if SectionIndex = FSections.Count - 1 then
      SectionIndex := 0
    else
      SectionIndex := SectionIndex + 1
  else
  if (((Key = VK_TAB) and (Shift = [ssCtrl, ssShift])) or (Key = VK_PRIOR))
and (FSections.Count > 1) then
    if SectionIndex = 0 then
      SectionIndex := FSections.Count - 1
    else
      SectionIndex := SectionIndex - 1
  else
  if ((Key = VK_LEFT) or (Key = VK_UP)) and (FSections.Count > 0) then
  begin
    if FSections[SectionIndex].FItems.Count = 0 then
    begin
      if SectionIndex = 0 then
        SectionIndex := FSections.Count - 1
      else
        SectionIndex := SectionIndex - 1;
    end
    else
    begin
      if ItemIndex = 0 then
        ItemIndex := FSections[SectionIndex].Items.Count - 1
      else
        if ItemIndex <> -1 then
          ItemIndex := ItemIndex - 1;
        if (FChangeDelay = 0) and (not (csLoading in ComponentState)) then
          TriggerItemChangeEvent
        else
          if (not (csLoading in ComponentState)) then
          begin
            if ItemIndex <> -1 then
              StartDelayTimer(FSections[SectionIndex].Items[ItemIndex])
            else
              StartDelayTimer(nil);
          end;
    end
  end
  else
  if ((Key = VK_RIGHT) or (Key = VK_DOWN)) and (FSections.Count > 0) then
  begin
    if FSections[SectionIndex].FItems.Count = 0 then
      if SectionIndex = FSections.Count - 1 then
        SectionIndex := 0
      else
        SectionIndex := SectionIndex + 1
    else
    begin
      if ItemIndex = FSections[SectionIndex].Items.Count - 1 then
        ItemIndex := 0
      else
        if ItemIndex <> -1 then
          ItemIndex := ItemIndex + 1;
        if (FChangeDelay = 0) and (not (csLoading in ComponentState)) then
          TriggerItemChangeEvent
        else
        begin
          if ItemIndex <> -1 then
            StartDelayTimer(FSections[SectionIndex].Items[ItemIndex])
          else
            StartDelayTimer(nil);
        end;
    end;
  end
  else
    inherited;
end;

procedure TElSideBar.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  inherited;
  Msg.Result := DLGC_WANTARROWS or DLGC_WANTTAB;
end;

procedure TElSideBar.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to Sections.Count - 1 do
    if Sections[i].FPanel <> nil then
       Proc(TControl(Sections[i].FPanel));
end;

procedure TElSideBar.ShowControl(AControl: TControl);
var i : integer;
begin
  for i := 0 to Sections.Count - 1 do
  begin
    if (AControl = Sections[i].Panel) or ((AControl <> nil) and (AControl.Parent = Sections[i].Panel)) then
    begin
      SectionIndex := i;
      exit;
    end;
  end;
end;

function TElSideBar.GetChildOwner: TComponent;
begin
  Result := Self;
end;

procedure TElSideBar.AlignControls(AControl: TControl; var Rect: TRect);  { protected }
begin
  Rect := GetItemsRect;
  InflateRect(Rect, 1, 1);
  inherited;
end;  { AlignControls }

procedure TElSideBar.OnDelayTimer(Sender : TObject);
begin
  FDelayTimer.Enabled := false;
  if (FDelayItem = Self.FItem) and (not (csLoading in ComponentState)) then
    TriggerItemChangeEvent;
end;

procedure TElSideBar.StartDelayTimer(Item : TElSideBarItem);
begin
  FDelayTimer.Enabled := false;
  FDelayItem := Item;
  FDelayTimer.Interval := FChangeDelay;
  FDelayTimer.Enabled := true;
end;

procedure TElSideBar.StopDelayTimer;
begin
  FDelayTimer.Enabled := false;
  FDelayItem := nil;
end;

procedure TElSideBar.SetItemIndex(newValue : integer);
var Item : TElSideBarItem;
begin
  if (FSection <> nil) then
  begin
    if InRange(0, FSection.Items.Count -1, newValue) and KeepSelection then
    begin
      Item := FSection.Items[newValue];
      if ((FItem = nil) or (FItem.Index <> newValue)) and (Item.Visible) and (Item.Enabled) then
      begin
        FItem := Item;
        FTrackItem := nil;
        UpdateItems;
      end;
    end
    else
    if newValue = -1 then
    begin
      FItem := nil;
      FTrackItem := nil;
      UpdateItems;
    end;
  end;  { if }
end;  { SetSelectedItem }

function TElSideBarCItem.GetBar: TElSideBar;
begin
  Result := FBar;
end;

function TElSideBarCItem.GetDisplayName: string;
begin
  Result := Caption;
end;


procedure TElSideBar.SetKeepSelection(Value: Boolean);
begin
  if Value <> FKeepSelection then
  begin
    FKeepSelection := Value;
    if not Value then
      SetItemIndex(-1);
  end;
end;

procedure TElSideBar.IntKeyDown(var Key : Word; ShiftState : TShiftState);
begin

end;

procedure TElSideBar.IntMouseDown(Button : TMouseButton; XPos, YPos : SmallInt);
var BarPart : TElSideBarPart;
    Section : TElSideBarSection;
    Item    : TElSideBarItem;
    DoUpdate: boolean;
    SR, R   : TRect;
begin
  if Button <> mbLeft then
    exit;
  if CanFocus then SetFocus;
  DoUpdate := false;
  GetHitTest(XPos, YPos, BarPart, Section, Item);
  case BarPart of
    sbpSection:
      begin
        if Section.Enabled and (not Section.Inactive) then
        begin
          FSaveDownSection := Section;
          FDownSection := Section;
          UpdateSection(Section);
          FSaveCapture := SetCapture(Handle);
          FPressed := true;
        end;
      end;
    sbpItemImage,
    sbpItemText:
      begin
        if Item.Enabled then
        begin
          FSaveDownItem := Item;
          FDownItem := Item;
          InvalidateRect(Handle, @FDownItem.FBoundRect, false);
          DoUpdate := true;
          FSaveCapture := SetCapture(Handle);
          FPressed := true;
        end;
      end;
    sbpUpScroll:
      begin
        R := GetItemsRect;
        if RightAlignedBar
           then SR := Rect(R.Left + 5, R.Top+5, R.Left + 20, R.Top+20)
           else SR := Rect(R.Right-20, R.Top+5, R.Right-5, R.Top+20);
        FSaveUpBtnPressed := true;
        FUpBtnPressed := true;
        FAutoScroll := false;
        if FScrollTimer = nil then
        begin
          FScrollTimer := TTimer.Create(nil);
          FScrollTimer.OnTimer := OnScrollTimer;
        end;
        FScrollTimer.Interval := FScrollDelay;
        FScrollTimer.Enabled  := true;
        InvalidateRect(Handle, @SR, false);
        DoUpdate := true;
      end;
    sbpDownScroll:
      begin
        R := GetItemsRect;
        if RightAlignedBar
           then SR := Rect(R.Left + 5, R.Bottom - 20, R.Left + 20, R.Bottom - 5)
           else SR := Rect(R.Right-20, R.Bottom - 20, R.Right-5, R.Bottom - 5);
        FSaveDownBtnPressed := true;
        FDownBtnPressed := true;
        FAutoScroll := false;
        if FScrollTimer = nil then
        begin
          FScrollTimer := TTimer.Create(nil);
          FScrollTimer.OnTimer := OnScrollTimer;
        end;
        FScrollTimer.Interval := FScrollDelay;
        FScrollTimer.Enabled  := true;
        InvalidateRect(Handle, @SR, false);
        DoUpdate := true;
      end;
  end;
  if DoUpdate then Update;
end;  { WMLButtonDown }

procedure TElSideBar.IntMouseUp  (Button : TMouseButton; XPos, YPos : SmallInt);
var BarPart : TElSideBarPart;
    Section : TElSideBarSection;
    Item    : TElSideBarItem;
    DoUpdate: boolean;
    SR, R   : TRect;
begin
  DoUpdate := false;
  SetRectEmpty(SR);
  GetHitTest(XPos, YPos, BarPart, Section, Item);
  case BarPart of
    sbpSection:
      begin
        if FSaveDownSection = Section then
        begin
          SectionIndex := Section.Index;
{$IFDEF USE_SOUND_MAP}
          if Assigned(SoundMap) then SoundMap.Play(FSectionChangeSound);
{$ENDIF}
        end;
      end;
    sbpItemImage,
    sbpItemText:
      begin
        if FSaveDownItem = Item then
        begin
          ItemIndex := Item.Index;
{$IFDEF USE_SOUND_MAP}
          if Assigned(SoundMap) then SoundMap.Play(FItemChangeSound);
{$ENDIF}
          if (not (csLoading in ComponentState)) then
            TriggerItemChangeEvent;
          if not FKeepSelection then
            ItemIndex := -1;
        end;
      end;
    sbpUpScroll:
      begin
        if FSaveUpBtnPressed then
        begin
          if not FAutoScroll then ScrollUp;
        end;
      end;
    sbpDownScroll:
      begin
        if FSaveDownBtnPressed then
        begin
          if not FAutoScroll then ScrollDown;
        end;
      end;
  end;
  if FUpBtnPressed then
  begin
    R := GetItemsRect;
    if RightAlignedBar
       then SR := Rect(R.Left + 5, R.Top+5, R.Left + 20, R.Top+20)
       else SR := Rect(R.Right-20, R.Top+5, R.Right-5, R.Top+20);
    FUpBtnPressed := false;
    FScrollTimer.Enabled := false;
    FScrollTimer.Free;
    FScrollTimer := nil;
    DoUpdate := true;
  end;
  InvalidateRect(Handle, @SR, false);
  FSaveUpBtnPressed := false;

  if FDownBtnPressed then
  begin
    R := GetItemsRect;
    if RightAlignedBar
       then SR := Rect(R.Left + 5, R.Bottom - 20, R.Left + 20, R.Bottom - 5)
       else SR := Rect(R.Right-20, R.Bottom - 20, R.Right-5, R.Bottom - 5);
    FDownBtnPressed := false;
    FScrollTimer.Enabled := false;
    FScrollTimer.Free;
    DoUpdate := true;
    FScrollTimer := nil;
  end;
  InvalidateRect(Handle, @SR, false);

  FSaveDownBtnPressed := false;

  FSaveDownSection := nil;
  FSaveDownItem    := nil;
  if FDownSection <> nil then
  begin
    InvalidateRect(Handle, @FDownSection.FBoundRect, false);
    DoUpdate := true;
  end;
  if FDownItem <> nil then
  begin
    InvalidateRect(Handle, @FDownItem.FBoundRect, false);
    InvalidateRect(Handle, @FDownItem.FTextRect, false);
    DoUpdate := true;
  end;
  FDownSection := nil;
  FDownItem    := nil;
  if FPressed then
  begin
    if FSaveCapture <> 0 then
      SetCapture(FSaveCapture)
    else
      ReleaseCapture;
    FSaveCapture := 0;
    FPressed := false;
  end;
  if DoUpdate then Update;
end;

procedure TElSideBar.IntMouseMove(XPos, YPos : SmallInt);
var BarPart : TElSideBarPart;
    Section,
    Section1: TElSideBarSection;
    Item    : TElSideBarItem;
    CItem   : TElSideBarCItem;
    R, SR   : TRect;
    AMsg    : TMessage;

begin
  GetHitTest(XPos, YPos, BarPart, Section, Item);
  if (BarPart in [sbpSection, sbpItemImage, sbpItemText]) then
  begin
    if BarPart = sbpSection then
      CItem := Section
    else
      CItem := Item;
    if (CItem <> FHintItem) and ShowHint then
    begin
      Application.HideHint;
      if not FPressed then
      begin
        AMsg.Msg := WM_MOUSEMOVE;
        TWMMouseMove(AMsg).Keys := 0;
        TWMMouse(AMsg).XPos := -10000;
        TWMMouse(AMsg).YPos := -10000;
        Application.HintMouseMessage(Self, AMsg);
        TWMMouse(AMsg).XPos := XPos;
        TWMMouse(AMsg).YPos := YPos;
        Application.HintMouseMessage(Self, AMsg);
      end;
    end;
    FHintItem := CItem;
  end;
  case BarPart of
    sbpSection:
      begin
        if FTrackItem <> nil then
        begin
          InvalidateRect(Handle, @FTrackItem.FBoundRect, false);
          InvalidateRect(Handle, @FTrackItem.FTextRect, false);
          FTrackItem := nil;
        end;
        if FTrackSection <> Section then
        begin
          if FTrackSection <> nil then
          begin
            Section1 := FTrackSection;
            FTrackSection := nil;
            InvalidateRect(Handle, @Section1.FBoundRect, false);
          end;
          if (Section <> nil) and (Section.Enabled) and FSectionTracking and (not Section.Inactive) then
          begin
            FTrackSection := Section;
            InvalidateRect(Handle, @FTrackSection.FBoundRect, false);
          end;
        end;
        if FPressed then
        begin
          if FSaveDownSection <> nil then
          begin
            if FSaveDownSection = Section then
            begin
              FDownSection := FSaveDownSection;
              InvalidateRect(Handle, @FDownSection.FBoundRect, false);
            end
            else
            begin
              if FDownSection <> nil then
              begin
                InvalidateRect(Handle, @FDownSection.FBoundRect, false);
              end;
              FDownSection := nil;
            end;
          end;
          if (FSaveDownItem <> nil) and (FDownItem <> nil) then
          begin
            InvalidateRect(Handle, @FDownItem.FBoundRect, false);
            FDownItem := nil;
          end;
        end;
        if FUpBtnPressed then
        begin
          FUpBtnPressed := false;
          R := GetItemsRect;
          if RightAlignedBar then
            SR := Rect(R.Left + 5, R.Top+5, R.Left + 20, R.Top+20)
          else
            SR := Rect(R.Right-20, R.Top+5, R.Right-5, R.Top+20);

          InvalidateRect(Handle, @SR, false);
          FScrollTimer.Enabled := false;
        end;
        if FDownBtnPressed then
        begin
          FDownBtnPressed := false;
          R := GetItemsRect;
          if RightAlignedBar then
            SR := Rect(R.Left + 5, R.Bottom - 20, R.Left + 20, R.Bottom - 5)
          else
            SR := Rect(R.Right-20, R.Bottom - 20, R.Right-5, R.Bottom - 5);
          InvalidateRect(Handle, @SR, false);
          FScrollTimer.Enabled := false;
        end;
      end;
    sbpItemImage,
    sbpItemText:
      begin
        if FTrackSection <> nil then
        begin
          InvalidateRect(Handle, @FTrackSection.FBoundRect, false);
          FTrackSection := nil;
        end;
        if FTrackItem <> Item then
        begin
          if FTrackItem <> nil then
          begin
            InvalidateRect(Handle, @FTrackItem.FBoundRect, false);
            InvalidateRect(Handle, @FTrackItem.FTextRect, false);
            FTrackItem := nil;
          end;
          if (Item <> nil) and (Item.Enabled) and FItemTracking then
          begin
            FTrackItem := Item;
            InvalidateRect(Handle, @FTrackItem.FBoundRect, false);
            InvalidateRect(Handle, @FTrackItem.FTextRect, false);
          end;
        end;
        if FPressed then
        begin
          if FSaveDownItem <> nil then
          begin
            if FSaveDownItem = Item then
            begin
              FDownItem := FSaveDownItem;
              InvalidateRect(Handle, @FDownItem.FBoundRect, false);
            end else
            begin
              if FDownItem <> nil then
              begin
                InvalidateRect(Handle, @FDownItem.FBoundRect, false);
              end;
              FDownItem := nil;
            end;
          end;
          if (FSaveDownSection <> nil) and (FDownSection <> nil) then
          begin
            InvalidateRect(Handle, @FDownSection.FBoundRect, false);
            FDownSection := nil;
          end;
        end;
        if FUpBtnPressed then
        begin
          FUpBtnPressed := false;
          R := GetItemsRect;
          if RightAlignedBar then
            SR := Rect(R.Left + 5, R.Top+5, R.Left + 20, R.Top+20)
          else
            SR := Rect(R.Right-20, R.Top+5, R.Right-5, R.Top+20);
          InvalidateRect(Handle, @SR, false);
          FScrollTimer.Enabled := false;
        end;
        if FDownBtnPressed then
        begin
          FDownBtnPressed := false;
          R := GetItemsRect;
          if RightAlignedBar then
            SR := Rect(R.Left + 5, R.Bottom - 20, R.Left + 20, R.Bottom - 5)
          else
            SR := Rect(R.Right-20, R.Bottom - 20, R.Right-5, R.Bottom - 5);
          InvalidateRect(Handle, @SR, false);
          FScrollTimer.Enabled := false;
        end;
      end;
    sbpUpScroll,
    sbpDownScroll,
    sbpInside:
      begin
        if FTrackSection <> nil then
        begin
          InvalidateRect(Handle, @FTrackSection.FBoundRect, false);
          FTrackSection := nil;
        end;
        if FTrackItem <> nil then
        begin
          InvalidateRect(Handle, @FTrackItem.FBoundRect, false);
          InvalidateRect(Handle, @FTrackItem.FTextRect, false);
          FTrackItem := nil;
        end;
        if FPressed then
        begin
          if (FSaveDownSection <> nil) and (FDownSection <> nil) then
          begin
            InvalidateRect(Handle, @FDownSection.FBoundRect, false);
            FDownSection := nil;
          end;
          if (FSaveDownItem <> nil) and (FDownItem <> nil) then
          begin
            InvalidateRect(Handle, @FDownItem.FBoundRect, false);
            FDownItem := nil;
          end;
        end;
        if FSaveUpBtnPressed then
        begin
          if BarPart <> sbpUpScroll then
          begin
            if FUpBtnPressed then
            begin
              FUpBtnPressed := false;
              R := GetItemsRect;
              if RightAlignedBar
                 then SR := Rect(R.Left + 5, R.Top+5, R.Left + 20, R.Top+20)
                 else SR := Rect(R.Right-20, R.Top+5, R.Right-5, R.Top+20);
              InvalidateRect(Handle, @SR, false);
              FScrollTimer.Enabled := false;
            end;
          end else
          begin
            if (not FUpBtnPressed) then // re-enable scroller
            begin
              FScrollTimer.Enabled := true;
              FUpBtnPressed := true;
              R := GetItemsRect;
              if RightAlignedBar
                 then SR := Rect(R.Left + 5, R.Top+5, R.Left + 20, R.Top+20)
                 else SR := Rect(R.Right-20, R.Top+5, R.Right-5, R.Top+20);
              InvalidateRect(Handle, @SR, false);
            end;
          end;
        end;

        if FSaveDownBtnPressed then
        begin
          if BarPart <> sbpDownScroll then
          begin
            if FDownBtnPressed then
            begin
              FDownBtnPressed := false;
              R := GetItemsRect;
              if RightAlignedBar
                 then SR := Rect(R.Left + 5, R.Bottom - 20, R.Left + 20, R.Bottom - 5)
                 else SR := Rect(R.Right-20, R.Bottom - 20, R.Right-5, R.Bottom - 5);
              InvalidateRect(Handle, @SR, false);
              FScrollTimer.Enabled := false;
            end;
          end else
          begin
            if (not FDownBtnPressed) then // re-enable scroller
            begin
              FScrollTimer.Enabled := true;
              FDownBtnPressed := true;
              R := GetItemsRect;
              if RightAlignedBar
                 then SR := Rect(R.Left + 5, R.Bottom - 20, R.Left + 20, R.Bottom - 5)
                 else SR := Rect(R.Right-20, R.Bottom - 20, R.Right-5, R.Bottom - 5);
              InvalidateRect(Handle, @SR, false);
            end;
          end;
        end;
      end;
  end; // case
end;


procedure TElSideBar.IntMouseWheel(WheelDelta: Integer; MousePos: TPoint);
var
  Dy : integer;
begin
  Dy := WheelDelta;
  if Dy > 0 then
  begin
    if FVisUpBtn then
      ScrollUp
  end
  else
  if Dy < 0 then
  begin
    if FVisDownBtn then
      ScrollDown;
  end;
end;


function TElSideBar.IntHintShow(var HintInfo : THintInfo): Boolean;
var BarPart : TElSideBarPart;
    Section : TElSideBarSection;
    Item    : TElSideBarItem;

    {$ifdef ELPACK_UNICODE}
    T: WideChar;
    WS: WideString;
    l : integer;
    S : String;
    {$endif}
begin
  GetHitTest(HintInfo.CursorPos.X, HintInfo.CursorPos.Y, BarPart, Section, Item);
  case BarPart of
    sbpSection:
      begin
        if Section.Hint <> '' then
          HintInfo.HintStr := Section.Hint;
      end;
    sbpItemImage,
    sbpItemText:
      begin
        if Item.Hint <> '' then
          HintInfo.HintStr := Item.Hint;
      end;
  end;
  result := true;
  {$ifdef ELPACK_UNICODE}
  WS := FHint;
  case BarPart of
    sbpSection:
      begin
        if Section.Hint <> '' then
          WS := Section.Hint;
      end;
    sbpItemImage,
    sbpItemText:
      begin
        if Item.Hint <> '' then
          WS := Item.Hint;
      end;
  end;
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

{$ifdef VCL_4_USED}
procedure TElSideBar.ConstrainedResize(var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer);
begin
  MinHeight := Max(MinHeight, GetMinHeight);
end;
{$else}
{$endif}


procedure TElSideBar.SetBorderSides(Value: TElBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TElSideBar.WMNCCalcSize(var Message : TWMNCCalcSize);
begin
  inherited;
  if not (ebsLeft in BorderSides) then
    dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(SM_CYEDGE));
  if not (ebsTop in BorderSides) then
    dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CXEDGE));
  if not (ebsRight in BorderSides) then
    Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(SM_CYEDGE));
  if not (ebsBottom in BorderSides) then
    Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CXEDGE));
  // Message.Result := WVR_REDRAW;
end;

procedure TElSideBar.SetIconLocation(Value: TElSideBarIconLocation);
begin
  if FIconLocation <> Value then
  begin
    FIconLocation := Value;
    UpdateItems;
  end;
end;

procedure TElSideBar.DestroyWnd;
begin
  inherited;
end;

procedure TElSideBar.WMEraseBkgnd(var Message: TMessage);
begin
  Message.Result := 1;
end;



function TElSideBar.GetThemedClassName: WideString;
begin
  Result := 'TOOLBAR';
end;

function TElSideBar.GetBackgroundClientRect: TRect;
begin
  Result := GetItemsRect;
  OffsetRect(Result, -Result.Left, -Result.Top);
end;

procedure TElSideBar.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TElSideBar.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
    if HandleAllocated then
      Invalidate;
  end;
end;



function TElSideBar.IsTopIndexStored: Boolean;
begin
  Result := Assigned(FTopItem) and (FTopItem.Index > 0);
end;

procedure TElSideBar.SetScrollButtonColor(Value: TColor);
begin
  if FScrollButtonColor <> Value then
  begin
    FScrollButtonColor := Value;
    Invalidate;
  end;
end;

procedure TElSideBar.SetTransparentItems(Value: Boolean);
begin
  if FTransparentItems <> Value then
  begin
    FTransparentItems := Value;
    UpdateItems;
  end;
end;

procedure TElSideBar.SetArrowColor(newValue: TColor);
{ Sets data member FArrowColor to newValue. }
begin
  if (FArrowColor <> newValue) then
  begin
    FArrowColor := newValue;
    if FVisUpBtn or FVisDownBtn then
      UpdateItems;
  end; { if }
end; { SetArrowColor }

procedure TElSideBar.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder;
  end;
end;

procedure TElSideBar.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder;
  end;
end;

procedure TElSideBar.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder;
  end;
end;

procedure TElSideBar.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder;
  end;
end;

procedure TElSideBar.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder;
  end;
end;




initialization

  if GetClass('TElSidebar') = nil then
    RegisterClass(TElSidebar);

end.
