{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

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


(*

Version History

07/06/2003

  BorderColor* properties added. They control the colors of the border, drawn when Flat is true.

05/13/2003

  Fixed some repainting problems (especially with selected items)

05/10/2003

  Fixed Move method to correctly move image indicies and checkbox states

04/08/2003

  Fixed deletion of the last element in TElListBoxStrings

03/20/2003

 Replaced system scrollbars to ElScrollBars

02/24/2003

 Invalidation when scrolling was added

01/18/2003

  Under certain circumstances an extra (empty) item could be added. Fixed

12/30/2002

  AddObject didn't work due to VCL 6/7 bug. Workaround added.

12/25/2002

  Added OnCheckStateChange event

12/15/2002

  Added selection color properties

10/22/2002

  Border was painted incorrectly. Fixed.

09/06/2002

  Double-click event was fired twice on each double-click. Fixed.

06/27/2002

  Fixed the problem with assignment of items in non-Unicode mode

05/27/2002

  Added UseSelectedFont and SelectedFontColor properties.

04/19/2002

  Line hint fixed

03/22/2002

  The images were not updated when items list is changed. Fixed.

03/11/2002

  Lots of properties made published

03/06/2002

  Added unicode hint

*)

unit ElListBox;

interface

uses
  StdCtrls,
  Windows,
  SysUtils,
  Messages,
  Classes,
  Controls,
  Graphics,
  Consts,
  Forms,
{$IFDEF WIN32}
  ElUxTheme,
{$ENDIF}
  {$IFDEF VCL_4_USED}
  ImgList,
  {$ENDIF}
  {$IFDEF VCL_6_USED}
  RTLConsts,
  {$ENDIF}
  ElImgFrm,
  Menus,
{$IFDEF VCL_6_USED}
Types,
{$ENDIF}
  ElTools,
  ExtCtrls,
  ElTmSchema,
  ElHintWnd,
  ElXPThemedControl,
  {$IFDEF ELPACK_UNICODE}
  ElUnicodeStrings,
  {$ENDIF}
{$IFDEF ELPACK_USE_INPUTPROCESSOR}
  Imm,
{$ENDIF}
  ElInputProcessor,
  ElStrUtils,
  ElVCLUtils,
{< ELSCROLLBAR}
  // ElSBCtrl, <trash> // LAW
{> ELSCROLLBAR}
  CommCtrl;

type
    //@+ 2/5/03
    TElCheckBoxChangeEvent = procedure(aSender: TObject; aItemIndex: Integer; aItemState: TCheckBoxState) of object;
    //@- 2/5/03


    TDrawTextEvent = procedure (Sender : TObject; ACanvas: TCanvas; Index: integer;
      var Rect: TRect; Flags: LongInt) of object;

    TElCheckStateChangeEvent = procedure (Sender : TObject; Index: integer) of object;

    TIntArray = array[0..MaxInt div sizeof(integer) -1] of integer;
    PIntArray = ^TIntArray;

    TCustomElListBox = class;

    {$IFDEF ELPACK_UNICODE}
    TElListBoxStrings = class(TElWideStringList)
    {$ELSE}
    TElListBoxStrings = class(TStringList)
    {$ENDIF}
    private
      ListBox : TCustomElListBox;
    protected
      {$IFDEF ELPACK_UNICODE}
      function Get(Index: Integer): WideString; override;
      {$ELSE}
      function Get(Index: Integer): string; override;
      {$ENDIF}
      function GetCount: Integer; override;
      function GetObject(Index: Integer): TObject; override;
      {$IFDEF ELPACK_UNICODE}
      procedure Put(Index: Integer; const S: WideString); override;
      {$ELSE}
      procedure Put(Index: Integer; const S: String); override;
      {$ENDIF}
      procedure PutObject(Index: Integer; AObject: TObject); override;
      procedure SetUpdateState(Updating: Boolean); override;
      procedure ResetBox;
      {$IFNDEF ELPACK_UNICODE}
      {$IFDEF VCL_6_USED}
      procedure InsertItem(Index: Integer; const S: string; AObject: TObject); override;
      {$ENDIF}
      {$ENDIF}
    public
      {$IFDEF ELPACK_UNICODE}
      function Add(const S: WideString): Integer; override;
      {.$ifdef VCL_6_USED}
      function AddObject(const S: WideString; AnObject : TObject): Integer; override;
      {.$endif}
      {$ELSE}
      function Add(const S: String): Integer; override;
      {.$IFDEF VCL_6_USED}
      function AddObject(const S: string; AnObject : TObject): Integer; override;
      {.$ENDIF}
      {$ENDIF}
      procedure Clear; override;
      procedure Delete(Index: Integer); override;
      procedure Exchange(Index1, Index2: Integer); override;
      {$IFDEF ELPACK_UNICODE}
      function IndexOf(const S: WideString): Integer; override;
      procedure Insert(Index: Integer; const S: WideString); override;
      {$ELSE}
      function IndexOf(const S: String): Integer; override;
      procedure Insert(Index: Integer; const S: String); override;
      {$ENDIF}
      procedure Move(CurIndex, NewIndex: Integer); override;
    end;

    TOwnerDrawState =
    {$IFNDEF VCL_5_USED}StdCtrls{$ELSE}Windows{$ENDIF}.TOwnerDrawState;

    TCustomElListBox = class(TElXPThemedControl)
    private
(*      {< ELSCROLLBAR}
      fUseCustomScrollBars : Boolean;
      fSBCtrl :TElSBController;*) // <trash> // LAW
      FItemIndex : integer;

(*      function GetHorzScrollBar:TElCtrlScrollBarStyles;
      function GetVertScrollBar:TElCtrlScrollBarStyles;
      procedure SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
      procedure SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
      procedure SetUseCustomScrollBars(const Value:Boolean);
      function GetHorzScrollHintNeeded:TElScrollHintNeededEvent;
      procedure SetHorzScrollHintNeeded(Value: TElScrollHintNeededEvent);
      function GetVertScrollHintNeeded:TElScrollHintNeededEvent;
      procedure SetVertScrollHintNeeded(Value: TElScrollHintNeededEvent);
      {> ELSCROLLBAR}*) // <trash> // LAW
      function IsTopIndexStored: Boolean;
    protected
      FImageIndex : PIntArray;
      FImagesSize : integer;
      FStates : PChar;
      FStatesSize : integer;
      FBorderStyle: TBorderStyle;
      FCanvas     : TCanvas;
      FColumns: Integer;
      FExtendedSelect: Boolean;
      FIntegralHeight: Boolean;
      FItemHeight: Integer;
      FMultiSelect: Boolean;
      FSorted: Boolean;
      FTabWidth: Integer;
      FCurHintItem : Integer;
      FLastTopIndex : integer;
      FImgFormChLink : TImgFormChangeLink;
      FListBoxStrings : TElFStrings;
      FActiveBorderType: TElFlatBorderType;
      FBackground: TBitmap;
      FBorderSides: TElBorderSides;
      FFlat: Boolean;
      FFlatFocusedScrollBars: Boolean;
      FHorizontalScroll: Boolean;
      FInactiveBorderType: TElFlatBorderType;
      FInvertSelection: Boolean;
      {
      FSelectedColor: TColor;
      FSelectedFontColor: TColor;
      }
      FSelectedFont: TFont;
      FShowLineHint: Boolean;
      FTransparent: Boolean;
      FTransparentSelection: Boolean;
      FUseBackground: Boolean;
      FImgForm : TElImageForm;
      FMouseOver: boolean;
      FHintTimer: TTimer;
      FHintWnd     : TElHintWindow;
      FHintWndProc : TWndMethod;
      FMaxWidth    : integer;
      FInVScroll,
      FInHScroll     : boolean;
      FLineBorderActiveColor: TColor;
      FLineBorderInactiveColor: TColor;
      FMoving : boolean;
      FShowCheckBox: Boolean;
      FAllowGrayed: Boolean;
      FImages: TImageList;
      FImageChangeLink : TChangeLink;
      FAlphaImages: TImageList;
      FAImageChangeLink : TChangeLink;
      {$IFNDEF ELPACK_UNICODE}
      FSaveItems: TStringList;
      {$ENDIF}
      FSaveTopIndex: Integer;
      FSaveItemIndex: Integer;
      {$IFDEF ELPACK_UNICODE}
      FHint: TElFString;
      {$ENDIF}
      FOnDrawText: TDrawTextEvent;
      FStyle: TListBoxStyle;
      FOnDrawItem: TDrawItemEvent;
      //@+ 2/5/03
      FOnCheckBoxChange: TElCheckBoxChangeEvent;
      //@- 2/5/03
      FOnMeasureItem: TMeasureItemEvent;
      FUseSelectedFont: Boolean;
      FRightAlignedView: Boolean;
      FRightAlignedText: Boolean;
      FFocusedSelectColor: TColor;
      FFocusedSelectTextColor: TColor;
      FHideSelectColor: TColor;
      FHideSelectTextColor: TColor;
      FHideSelection: Boolean;
      FHighlightAlphaLevel: Integer;
      {$IFDEF ELPACK_USE_INPUTPROCESSOR}
      Input : TElKeyboardInput;
      SearchTextTimeoutThread : TThread;
      {$ENDIF}

      FOnCheckStateChange: TElCheckStateChangeEvent;
      FIncrementalSearchTimeout: Integer;
      FBorderColorFace      : TColor;
      FBorderColorShadow    : TColor;
      FBorderColorHighlight: TColor;
      FBorderColorDkShadow  : TColor;
      FBorderColorWindow: TColor;

      procedure SetStyle(Value: TListBoxStyle);

      procedure SetActiveBorderType(const Value: TElFlatBorderType);
      procedure SetBackground(const Value: TBitmap);
      procedure SetBorderSides(Value: TElBorderSides);
      procedure SetFlat(const Value: boolean);
      procedure SetFlatFocusedScrollBars(const Value: boolean);
      procedure SetHorizontalScroll(Value: Boolean);
      procedure SetImageForm(newValue : TElImageForm);
      procedure SetInactiveBorderType(const Value: TElFlatBorderType);
      procedure SetInvertSelection(const Value: boolean);
      procedure SetSelectedFont(const Value: TFont);
      procedure SetTransparent(const Value: boolean);
      procedure SetTransparentSelection(Value: Boolean);
      procedure SetUseBackground(const Value: boolean);
      procedure BackgroundChanged(Sender: TObject);
      procedure CancelLineHint;
      procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
      procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
      procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
      procedure CMParentColorChanged(var Msg: TMessage); message
          CM_PARENTCOLORCHANGED;
      procedure CMParentFontChanged(var Msg: TMessage); message CM_PARENTFONTCHANGED;
      procedure DrawBackground(DC: HDC; R: TRect);
      procedure DrawBackgroundEx(DC: HDC; R, SubR: TRect);
      procedure DrawFlatBorder(DC: HDC; HDragging, VDragging : boolean);
      procedure DrawParentControl(DC: HDC);
      procedure DrawParentControlEx(DC: HDC; R: TRect);
      procedure HintWndProc(var Message: TMessage);
      procedure ImageFormChange(Sender : TObject);
      procedure IntMouseMove(XPos, YPos : SmallInt);
      procedure LBGetTopIndex(var Msg: TMessage); message LB_GETTOPINDEX;
      procedure OnLineHintTimer(Sender : TObject);
      procedure ResetHorizontalExtent; virtual;
      procedure SelectedFontChanged(Sender: TObject);
      procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
      procedure WMHScroll(var Message: TMessage); message WM_HSCROLL;
      procedure WMKillFocus(var Msg: TMessage); message WM_KILLFOCUS;
      procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
      procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
      procedure WMNCMouseMove(var Message: TMessage); message WM_NCMOUSEMOVE;
      procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
      procedure WMSetFocus(var Msg: TMessage); message WM_SETFOCUS;
      procedure WMVScroll(var Message: TMessage); message WM_VSCROLL;
      procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
          WM_WINDOWPOSCHANGED;
      procedure WMDeadChar(var Message: TWMDeadChar); message WM_DEADCHAR;
      procedure WMIMEComposition(var Message: TMessage); message WM_IME_COMPOSITION;
      procedure WMIMEStartComposition(var Message: TMessage); message
          WM_IME_STARTCOMPOSITION;
      procedure SetHorizontalExtent; virtual;
      procedure SetColumnWidth;
      procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
      procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
      procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
      procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
      procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
      procedure WMSize(var Message: TWMSize); message WM_SIZE;
      procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
      function GetItemHeight: Integer;
      function GetItemIndex: Integer;
      function GetSelCount: Integer;
      function GetSelected(Index: Integer): Boolean;
      function GetTopIndex: Integer;
      procedure SetBorderStyle(Value: TBorderStyle);
      procedure SetColumns(Value: Integer);
      procedure SetExtendedSelect(Value: Boolean);
      procedure SetIntegralHeight(Value: Boolean);
      procedure SetItemHeight(Value: Integer);
      procedure SetItemIndex(Value: Integer);
      procedure SetItems(Value: TElFStrings);
      procedure SetMultiSelect(Value: Boolean);
      procedure SetSelected(Index: Integer; Value: Boolean);
      procedure SetSorted(Value: Boolean);
      procedure SetTabWidth(Value: Integer);
      procedure SetTopIndex(Value: Integer);

      function GetBackground: TBitmap; virtual;
      procedure SetLineBorderActiveColor(Value: TColor);
      procedure SetLineBorderInactiveColor(Value: TColor);
      function CreateHintWindow: TElHintWindow; virtual;
      procedure CreateParams(var Params: TCreateParams); override;
      procedure CreateWnd; override;
      procedure DestroyWnd; override;
      procedure DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState); virtual;
      function GetItemWidth(Index: Integer): Integer; virtual;
      function GetParentCtlHeight: Integer; virtual;
      function GetParentCtlWidth: Integer; virtual;
      function GetThemedClassName: WideString; override;
      procedure IFMRepaintChildren(var Message: TMessage); message
          IFM_REPAINTCHILDREN;
      procedure Loaded; override;
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;
      function RealScreenToClient(APoint : TPoint): TPoint; virtual;
      procedure WMNCPaint(var Msg : TMessage); message WM_NCPAINT;
      procedure WndProc(var Message: TMessage); override;
      function InternalGetItemData(Index: Integer): LongInt; virtual;
      procedure InternalSetItemData(Index: Integer; AData: Longint); virtual;
      function GetItemData(Index: Integer): LongInt; virtual;
      procedure SetItemData(Index: Integer; AData: LongInt); virtual;
      procedure ResetContent; virtual;
      procedure DeleteString(Index: Integer); virtual;
      procedure SetShowCheckBox(Value: Boolean);
      function GetState(Index: Integer): TCheckBoxState;
      procedure SetState(Index: Integer; Value: TCheckBoxState);
      function GetCheckBoxSize: TSize;
      procedure SetAllowGrayed(Value: Boolean);
      procedure DrawFlatFrame(Canvas : TCanvas; R : TRect);
      procedure OnImageListChange(Sender : TObject);
      procedure SetImages(newValue : TImageList);
      procedure SetAlphaImages(newValue : TImageList);
      procedure AdjustItemHeight; virtual;
      function GetImageIndex(Index: Integer): Integer;
      procedure SetImageIndex(Index: Integer; Value: Integer);
      procedure SetStatesSize(aSize : integer);
      procedure SetImagesSize(aSize : integer);

      {$IFDEF ELPACK_UNICODE}
      procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
      {$ENDIF}

      {$IFDEF ELPACK_UNICODE}
      procedure SetHint(Value: TElFString);
      {$ENDIF}
      procedure ItemsChange(Sender : TObject);

      {$IFDEF ELPACK_USE_INPUTPROCESSOR}
      procedure StartClearSearchTimeoutThread;
      procedure StopClearSearchTimeoutThread;
      procedure DoPerformSearch(SearchText : TElFString); virtual;
      procedure SearchTextTimeout(Sender : TObject);
      function DoCompareItems(SearchText : String; ItemIndex : integer): Boolean;
          virtual;
      {$ENDIF}


      procedure DoDrawText(Sender : TObject; ACanvas: TCanvas; const ACaption: TElFString;
        var Rect: TRect; Flags: LongInt); virtual;

      procedure MeasureItem(Index: Integer; var Height: Integer); virtual;
      procedure SetUseSelectedFont(Value: Boolean);
      procedure SetRightAlignedView(Value: Boolean);
      procedure SetRightAlignedText(Value: Boolean);
      procedure SetFocusedSelectColor(newValue: TColor);
      procedure SetFocusedSelectTextColor(newValue: TColor);
      procedure SetHideSelectColor(newValue: TColor);
      procedure SetHideSelectTextColor(newValue: TColor);
      procedure SetHideSelection(Value: Boolean);
      procedure DefineProperties(Filer : TFiler); override;
      procedure ReadSelectedColor(Reader : TReader);
      procedure ReadSelectedFontColor(Reader : TReader);
      procedure SetHighlightAlphaLevel(Value: Integer);
      procedure TriggerCheckStateChange(ItemNo : integer); virtual;
      procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
      procedure TriggerCheckBoxChange(ItemNo : integer; ItemState: TCheckBoxState);
          virtual;
      procedure SetUseXPThemes(const Value : boolean); override;
      function GetCount:Integer;
      procedure UpdateItemHeight;
      procedure SetBorderColorFace(Value: TColor);
      procedure SetBorderColorShadow(Value: TColor);
      procedure SetBorderColorDkShadow(Value: TColor);
      procedure SetBorderColorHighlight(Value: TColor);
      procedure SetBorderColorWindow(Value: TColor);
      property Count:Integer read GetCount;
      property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle
          default bsSingle;
      property Columns: Integer read FColumns write SetColumns default 0;
      property ExtendedSelect: Boolean read FExtendedSelect write SetExtendedSelect
          default True;
      property IntegralHeight: Boolean read FIntegralHeight write SetIntegralHeight
          default False;
      property ItemHeight: Integer read GetItemHeight write SetItemHeight;
      property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default
          False;
      property ParentColor default False;
      property Sorted: Boolean read FSorted write SetSorted default False;
      property TabWidth: Integer read FTabWidth write SetTabWidth default 0;
      property ItemIndex: Integer read GetItemIndex write SetItemIndex;
      {$IFDEF ELPACK_UNICODE}
      property Items: TElWideStrings read FListBoxStrings write SetItems;
      {$ELSE}
      property Items: TStrings read FListBoxStrings write SetItems;
      {$ENDIF}
      property SelCount: Integer read GetSelCount;
      property TopIndex: Integer read GetTopIndex write SetTopIndex stored IsTopIndexStored;

      property ActiveBorderType: TElFlatBorderType read FActiveBorderType write
          SetActiveBorderType default fbtSunken;
      property Background: TBitmap read GetBackground write SetBackground;
      property BorderSides: TElBorderSides read FBorderSides write SetBorderSides
        default [ebsLeft, ebsTop, ebsRight, ebsBottom];
      property Flat: Boolean read FFlat write SetFlat default False;
      property FlatFocusedScrollBars: Boolean read FFlatFocusedScrollBars write
          SetFlatFocusedScrollBars default False;
      property HorizontalScroll: Boolean read FHorizontalScroll write
          SetHorizontalScroll default False;
      property ImageForm: TElImageForm read FImgForm write SetImageForm;
      property InactiveBorderType: TElFlatBorderType read FInactiveBorderType write
          SetInactiveBorderType default fbtSunkenOuter;
      property InvertSelection: Boolean read FInvertSelection write
          SetInvertSelection default False;
      property LineBorderActiveColor: TColor read FLineBorderActiveColor write
          SetLineBorderActiveColor default clBlack;
      property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
          SetLineBorderInactiveColor default clBlack;
      {
      property SelectedColor: TColor read FSelectedColor write SetSelectedColor
          default clHighlight;
      property SelectedFontColor: TColor read FSelectedFontColor write
          SetSelectedFontColor default clHighlightText;
      }
      property SelectedFont: TFont read FSelectedFont write SetSelectedFont;
      property ShowLineHint: Boolean read FShowLineHint write FShowLineHint default
          false;
      property Transparent: Boolean read FTransparent write SetTransparent default
          False;
      property TransparentSelection: Boolean read FTransparentSelection write
          SetTransparentSelection default false;
      property UseBackground: Boolean read FUseBackground write SetUseBackground
          default False;
      property TabStop default True;
      property ShowCheckBox: Boolean read FShowCheckBox write SetShowCheckBox default
          false;
      property AllowGrayed: Boolean read FAllowGrayed write SetAllowGrayed default
          true;
      property Images: TImageList read FImages write SetImages;
      property AlphaForImages: TImageList read FAlphaImages write SetAlphaImages;
      property Style: TListBoxStyle read FStyle write SetStyle default lbStandard;
      property UseSelectedFont: Boolean read FUseSelectedFont write
          SetUseSelectedFont default false;
      property RightAlignedView: Boolean read FRightAlignedView write
          SetRightAlignedView default false;
      property RightAlignedText: Boolean read FRightAlignedText write
          SetRightAlignedText default false;
      property FocusedSelectColor: TColor read FFocusedSelectColor write
          SetFocusedSelectColor default clHighlight;
      property FocusedSelectTextColor: TColor read FFocusedSelectTextColor write
          SetFocusedSelectTextColor default clHighlightText;
      property HideSelectColor: TColor read FHideSelectColor write SetHideSelectColor
          default clBtnFace;
      property HideSelectTextColor: TColor read FHideSelectTextColor write
          SetHideSelectTextColor default clBtnShadow;
      property HideSelection: Boolean read FHideSelection write SetHideSelection
          default true;
      property HighlightAlphaLevel: Integer read FHighlightAlphaLevel write
          SetHighlightAlphaLevel default 255;
      property OnCheckStateChange: TElCheckStateChangeEvent read FOnCheckStateChange
          write FOnCheckStateChange;
      property IncrementalSearchTimeout: Integer read FIncrementalSearchTimeout write
          FIncrementalSearchTimeout default 500;
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      function ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
      function ItemRect(Index: Integer): TRect;

      //@+ 2/5/03
      procedure CheckAll;
      procedure CheckSelected;
      procedure GrayAll;
      procedure GraySelected;
      procedure UncheckAll;
      procedure UncheckSelected;
      //@- 2/5/03
      property Canvas: TCanvas read FCanvas;
      property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
      property State[Index: Integer]: TCheckBoxState read GetState write SetState;
      property ImageIndex[Index: Integer]: Integer read GetImageIndex write
          SetImageIndex;
      //@+ 2/5/03
      property OnCheckBoxChange: TElCheckBoxChangeEvent read FOnCheckBoxChange write FOnCheckBoxChange;
      //@- 2/5/03
      property OnDrawText: TDrawTextEvent read FOnDrawText write
          FOnDrawText;
      property OnDrawItem: TDrawItemEvent read FOnDrawItem write FOnDrawItem;
      property OnMeasureItem: TMeasureItemEvent read FOnMeasureItem write FOnMeasureItem;
(*      {< ELSCROLLBAR}
      property UseCustomScrollBars : Boolean read fUseCustomScrollBars write SetUseCustomScrollBars
        default True;
      property HorzScrollBarStyles: TElCtrlScrollBarStyles read GetHorzScrollBar
        write SetHorzScrollBar;
      property VertScrollBarStyles: TElCtrlScrollBarStyles read GetVertScrollBar
        write SetVertScrollBar;
      property OnHorzScrollHintNeeded: TElScrollHintNeededEvent read GetHorzScrollHintNeeded
        write SetHorzScrollHintNeeded;
      property OnVertScrollHintNeeded: TElScrollHintNeededEvent read GetVertScrollHintNeeded
        write SetVertScrollHintNeeded;
      {> ELSCROLLBAR}*) // <trash> // LAW
    published
      {$IFDEF ELPACK_UNICODE}
      property Hint: TElFString read FHint write SetHint;
      {$ENDIF}
      property BorderColorFace : TColor read FBorderColorFace write SetBorderColorFace default
          clBtnFace;
      property BorderColorShadow : TColor read FBorderColorShadow write SetBorderColorShadow default
          clBtnShadow;
      property BorderColorDkShadow : TColor read FBorderColorDkShadow write SetBorderColorDkShadow default
          cl3DDkShadow;
      property BorderColorHighlight: TColor read FBorderColorHighlight write
          SetBorderColorHighlight default clBtnHighlight;
      property BorderColorWindow: TColor read FBorderColorWindow write
          SetBorderColorWindow default clWindow;
    end;

    TElListBox = class(TCustomElListBox)
      property AllowGrayed;
      property BorderStyle;
      property Columns;
      property ExtendedSelect;
      property FocusedSelectColor;
      property FocusedSelectTextColor;
      property HideSelection;
      property HideSelectColor;
      property HideSelectTextColor;
      property IntegralHeight;
      property IncrementalSearchTimeout;
      property ItemHeight;
      property MultiSelect;
      property ParentColor;
      property Sorted;
      property TabWidth;
      property ItemIndex;
      property Items;
      property SelCount;
      property TopIndex;
      property ShowCheckBox;
      property UseXPThemes;

      property ActiveBorderType;
      property Background;
      property BorderSides;
      property Flat;
      property Ctl3D;
      property ParentCtl3D;
      property Font;
      property FlatFocusedScrollBars;
      property HighlightAlphaLevel;
      property HorizontalScroll;
      property Images;
      property AlphaForImages;
      property ImageForm;
      property InactiveBorderType;
      property InvertSelection;
      property LineBorderActiveColor;
      property LineBorderInactiveColor;

      property SelectedFont;
      property ShowLineHint;
      property Transparent;
      property TransparentSelection;
      property UseBackground;
      property UseSelectedFont;
      property TabStop;
      property ParentFont;

      property OnClick;
      property OnCheckStateChange;
      //@+ 2/5/03
      property OnCheckBoxChange;
      //@- 2/5/03
      {$IFDEF VCL_5_USED}
      property OnContextPopup;
      {$ENDIF}
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      {$IFDEF VCL_4_USED}
      property OnEndDock;
      {$ENDIF}
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      {$IFDEF VCL_4_USED}
      property OnResize;
      property OnStartDock;
      {$ENDIF}
      property OnStartDrag;


      property Align;
      {$IFDEF VCL_4_USED}
      property Anchors;
      property BiDiMode;
      {$ENDIF}
      property Color;
      {$IFDEF VCL_4_USED}
      property Constraints;
      {$ENDIF}
      property DragCursor;
      {$IFDEF VCL_4_USED}
      property DragKind;
      {$ENDIF}
      property DragMode;
      property Enabled;
      {$IFDEF VCL_4_USED}
      property ImeMode;
      property ImeName;
      property ParentBiDiMode;
      {$ENDIF}
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property TabOrder;
      property Visible;
      property Style;
      property OnDrawItem;
      property OnMeasureItem;
(*      {< ELSCROLLBAR}
      property UseCustomScrollBars;
      property HorzScrollBarStyles;
      property VertScrollBarStyles;
      {> ELSCROLLBAR}*) // <trash> // LAW
      property RightAlignedView;
    end;

implementation

const
  CheckMargin = 5;
  {$IFDEF MSWINDOWS}
  CheckBoxSize = 13;
  {$ELSE}
  CheckBoxSize = 0;
  {$ENDIF}

type
  THackWinControl = class(TWinControl);

  TElListBoxHintWindow = class(TElHintWindow)
  protected
  end;

function QueryThemeData : boolean;
var hTestTheme : HTheme;
begin
  result := false;
  hTestTheme := OpenThemeData(0, 'LISTVIEW');
  if hTestTheme <> 0 then
  begin
    result := true;
    CloseThemeData(hTestTheme);
  end;
end;


constructor TCustomElListBox.Create(AOwner : TComponent);
begin
  inherited;
  Width := 121;
  Height := 97;
  TabStop := True;
  ParentColor := False;
  ControlStyle := [csSetCaption, csDoubleClicks];
  FListBoxStrings := TElListBoxStrings.Create;
  TElListBoxStrings(FListBoxStrings).ListBox := Self;
  TElListBoxStrings(FListBoxStrings).OnChange := ItemsChange;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FItemHeight := 16;
  FBorderStyle := bsSingle;
  FExtendedSelect := True;
  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
  FActiveBorderType := fbtSunken;
  FBackground := TBitmap.Create;
  FBackground.OnChange := BackgroundChanged;
  FFlat := False;
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;

  FFlatFocusedScrollBars := False;
  FInactiveBorderType := fbtSunkenOuter;
  FInvertSelection := False;
  FLastTopIndex := 0;
  FSelectedFont := TFont.Create;
  FSelectedFont.Color := clHighlightText;
  FSelectedFont.OnChange := SelectedFontChanged;
  FTransparent := False;
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := OnImageListChange;
  FAImageChangeLink := TChangeLink.Create;
  FAImageChangeLink.OnChange := OnImageListChange;
  FCurHintItem := -1;
  FHighlightAlphaLevel := 255;
  {$IFDEF ELPACK_USE_INPUTPROCESSOR}
  Input := TElKeyboardInput.Create;
  FIncrementalSearchTimeout := 500;
  {$ENDIF}

  FHideSelection := true;
  FFocusedSelectColor := clHighlight;
  FFocusedSelectTextColor := clHighlightText;
  FHideSelectColor := clBtnFace;
  FHideSelectTextColor := clBtnShadow;

(*  {< ELSCROLLBAR}
  fSBCtrl := TElSBController.Create(Self);
  fUseCustomScrollBars := True;
  fSBCtrl.UseXPThemes := true;
  {> ELSCROLLBAR}*) // <trash> // LAW
end;

destructor TCustomElListBox.Destroy;
begin
  {$IFDEF ELPACK_USE_INPUTPROCESSOR}
  StopClearSearchTimeoutThread;
  FreeAndNil(Input);
  {$ENDIF}
  CancelLineHint;
  inherited;
  SetStatesSize(0);
  SetImagesSize(0);
  FImageChangeLink.Free;
  FAImageChangeLink.Free;
  FImgFormChLink.Free;
  FSelectedFont.Free;
  FCanvas.Free;
  FListBoxStrings.Free;
  FBackground.Free;
end;

function TCustomElListBox.GetBackground: TBitmap;
begin
  Result := FBackground;
end;

procedure TCustomElListBox.SetActiveBorderType(const Value: TElFlatBorderType);
begin
  if FActiveBorderType <> Value then
  begin
    FActiveBorderType := Value;
    if Focused or FMouseOver then
      DrawFlatBorder(0, false, false);
  end;
end;

procedure TCustomElListBox.SetBackground(const Value: TBitmap);
begin
  FBackground.Assign(Value);
end;

procedure TCustomElListBox.SetBorderSides(Value: TElBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetFlat(const Value: boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetFlatFocusedScrollBars(const Value: boolean);
begin
  if FFlatFocusedScrollBars <> Value then
  begin
    FFlatFocusedScrollBars := Value;
    if Focused then
      DrawFlatBorder(0, false, false);
  end;
end;

procedure TCustomElListBox.SetHorizontalScroll(Value: Boolean);
begin
  if FHorizontalScroll <> Value then
  begin
    FHorizontalScroll := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      {$IFDEF VCL_5_USED}
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      {$ENDIF}
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then
      FImgForm.RegisterChanges(FImgFormChLink);
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
  end;
end;

procedure TCustomElListBox.SetInactiveBorderType(const Value: TElFlatBorderType);
begin
  if FInactiveBorderType <> Value then
  begin
    FInactiveBorderType := Value;
    if not Focused and not FMouseOver then
      DrawFlatBorder(0, false, false);
  end;
end;

procedure TCustomElListBox.SetInvertSelection(const Value: boolean);
begin
  if FInvertSelection <> Value then
  begin
    FInvertSelection := Value;
    if (MultiSelect and (SelCount > 0)) or (ItemIndex > -1) then
      Invalidate;
  end;
end;

procedure TCustomElListBox.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
      Invalidate;
  end;
end;

procedure TCustomElListBox.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
      Invalidate;
  end;
end;

procedure TCustomElListBox.SetSelectedFont(const Value: TFont);
begin
  FSelectedFont.Assign(Value);
end;

procedure TCustomElListBox.SetTransparent(const Value: boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    if FTransparent then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
  end;
end;

procedure TCustomElListBox.SetTransparentSelection(Value: Boolean);
begin
  if FTransparentSelection <> Value then
  begin
    FTransparentSelection := Value;
    if ItemIndex > -1 then
      Invalidate;
  end;
end;

procedure TCustomElListBox.SetUseBackground(const Value: boolean);
begin
  if FUseBackground <> Value then
  begin
    FUseBackground := Value;
    Invalidate;
  end;
end;

procedure TCustomElListBox.BackgroundChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TCustomElListBox.CancelLineHint;
begin
  if FHintTimer <> nil then
  begin
    FHintTimer.Enabled := false;
    FHintTimer.Free;
    FHintTimer := nil;
  end;
  if FHintWnd <> nil then
  begin
    FHintWnd.Free;
    FHintWnd := nil;
  end;
end;

procedure TCustomElListBox.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  Canvas.Font.Assign(Font);
  if not (csLoading in componentState) then
    UpdateItemHeight;
end;

procedure TCustomElListBox.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FMouseOver := True;
  if IsThemeApplied or (Flat and not Focused) then
    DrawFlatBorder(0, false, false);
  if Flat and ShowCheckBox then
    Invalidate;
end;

procedure TCustomElListBox.CMMouseLeave(var Msg: TMessage);
begin
  inherited;

  FMouseOver := False;
  if IsThemeApplied or (Flat and not Focused) then
    DrawFlatBorder(0, false, false);
  if Flat and ShowCheckBox then
    Invalidate;
end;

procedure TCustomElListBox.CMParentColorChanged(var Msg: TMessage);
begin
  inherited;
  if FTransparent then
    Invalidate;
end;

procedure TCustomElListBox.CMParentFontChanged(var Msg: TMessage);
begin
  inherited;
  if ParentFont then
  begin
    FSelectedFont.OnChange := nil;
    try
      if Msg.WParam <> 0 then
        FSelectedFont.Assign(TFont(Msg.LParam))
      else
        FSelectedFont.Assign(Font);
      FSelectedFont.Color := clHighlightText;
    finally
      FSelectedFont.OnChange := SelectedFontChanged;
    end;
  end;
end;

function TCustomElListBox.CreateHintWindow: TElHintWindow;
begin
  Result := TElListBoxHintWindow.Create(nil);
end;

procedure TCustomElListBox.CreateParams(var Params: TCreateParams);
type
  PSelects = ^TSelects;
  TSelects = array[Boolean] of DWORD;
const
  MultiSelects: array[Boolean] of DWORD = (0, LBS_MULTIPLESEL);
  ExtendSelects: array[Boolean] of DWORD = (0, LBS_EXTENDEDSEL);
  IntegralHeights: array[Boolean] of DWORD = (LBS_NOINTEGRALHEIGHT, 0);
  MultiColumns: array[Boolean] of DWORD = (0, LBS_MULTICOLUMN);
  TabStops: array[Boolean] of DWORD = (0, LBS_USETABSTOPS);
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
  CSHREDRAW: array[Boolean] of DWORD = (CS_HREDRAW, 0);
  LeftSB: array[Boolean] of DWORD = (0, WS_EX_LEFTSCROLLBAR);
  RightText: array[Boolean] of DWORD = (0, WS_EX_RTLREADING or WS_EX_RIGHT);

var
  Selects: PSelects;
begin
  inherited;
  CreateSubClass(Params, 'LISTBOX');
  with Params do
  begin
    Selects := @MultiSelects;
    if FExtendedSelect then
      Selects := @ExtendSelects;
    Style := Style or (WS_HSCROLL or WS_VSCROLL or LBS_NOTIFY ) or
      {$IFNDEF ELACK_UNICODE} LBS_HASSTRINGS or {$ENDIF}
      Selects^[FMultiSelect] or IntegralHeights[FIntegralHeight] or
      MultiColumns[FColumns <> 0] or BorderStyles[FBorderStyle] or TabStops[FTabWidth <> 0];
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;

    ExStyle := ExStyle or RightText[RightAlignedText];
    if NewStyleControls or false {UseCustomScrollBars} then // <trash> // LAW
      ExStyle := ExStyle or LeftSB[RightAlignedView];

    if FStyle = lbOwnerDrawVariable then
      Style := Style or LBS_OWNERDRAWVARIABLE
    else
      Style := Style or LBS_OWNERDRAWFIXED;
    WindowClass.style := WindowClass.style and not (
      CSHREDRAW[{$IFDEF VCL_4_USED}UseRightToLeftAlignment{$ELSE}false{$ENDIF}] or CS_VREDRAW);
  end;

  if not (csLoading in ComponentState) then
    if (Params.Style and LBS_OWNERDRAWFIXED = 0) and
      (Params.Style and LBS_OWNERDRAWVARIABLE = 0) then
      Params.Style := Params.Style or LBS_OWNERDRAWFIXED;

  if (BorderStyle = bsSingle) and Flat and (not (ThemesAvailable and UseXPThemes and
    QueryThemeData)) then
  begin
    Params.Style := Params.Style and (not WS_BORDER);
    Params.ExStyle := Params.ExStyle and (not WS_EX_CLIENTEDGE);
  end;
end;

procedure TCustomElListBox.CreateWnd;
var
  W, H: Integer;
begin
  W := Width;
  H := Height;
(*  {< ELSCROLLBAR}
  fSBCtrl.Control := nil;
  {> ELSCROLLBAR}*) // <trash> // LAW
  inherited;
  Perform(CM_FONTCHANGED, 0, 0);
  SetWindowPos(Handle, 0, Left, Top, W, H, SWP_NOZORDER or SWP_NOACTIVATE);
  if FTabWidth <> 0 then
    SendMessage(Handle, LB_SETTABSTOPS, 1, Longint(@FTabWidth));
  SetColumnWidth;
  if not (csLoading in componentState) then
    UpdateItemHeight;
  {$IFNDEF ELPACK_UNICODE}
  if FSaveItems <> nil then
  begin
    FListBoxStrings.Assign(FSaveItems);
    SetTopIndex(FSaveTopIndex);
    SetItemIndex(FSaveItemIndex);
    FSaveItems.Free;
    FSaveItems := nil;
  end;
  {$ELSE}
  TElListBoxStrings(FListBoxStrings).ResetBox;
  {$ENDIF}
(*  {< ELSCROLLBAR}
  // reset control handler
  if fUseCustomScrollBars then
  begin
    fSBCtrl.Control := Self;
    if not fSBCtrl.Active then
    begin
      fUseCustomScrollBars := False;
      fSBCtrl.Control := nil;
    end;
  end;
  {> ELSCROLLBAR}*) // <trash> // LAW
end;

procedure TCustomElListBox.DestroyWnd;
begin
  {$IFNDEF ELPACK_UNICODE}
  if FListBoxStrings.Count > 0 then
  begin
    FSaveItems := TStringList.Create;
    FSaveItems.Assign(FListBoxStrings);
    FSaveTopIndex := GetTopIndex;
    FSaveItemIndex := GetItemIndex;
  end;
  {$ENDIF}
  inherited;
(*  {< ELSCROLLBAR}
  fSBCtrl.Control := nil;
  {> ELSCROLLBAR}*) // <trash> // LAW
end;

(*
{< ELSCROLLBAR}
function TCustomElListBox.GetHorzScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_HORZ]);
end;

function TCustomElListBox.GetVertScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_VERT]);
end;

procedure TCustomElListBox.SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_HORZ].Assign(Value);
end;

procedure TCustomElListBox.SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_VERT].Assign(Value);
end;

procedure TCustomElListBox.SetUseCustomScrollBars(const Value:Boolean);
begin
  if fUseCustomScrollBars<>Value then
  begin
    fUseCustomScrollBars := Value;
    if fUseCustomScrollBars then
    begin
      fSBCtrl.Control := nil;
      fSBCtrl.Control := Self;
      if not fSBCtrl.Active then
      begin
        fUseCustomScrollBars := False;
        fSBCtrl.Control := nil;
      end;
    end
    else
      fSBCtrl.Control := nil;
  end;
end;

function TCustomElListBox.GetHorzScrollHintNeeded:TElScrollHintNeededEvent;
begin
  Result := fSBCtrl.HorzScrollBarStyles.OnScrollHintNeeded;
end;

procedure TCustomElListBox.SetHorzScrollHintNeeded(Value: TElScrollHintNeededEvent);
begin
  fSBCtrl.HorzScrollBarStyles.OnScrollHintNeeded := Value;
end;

function TCustomElListBox.GetVertScrollHintNeeded:TElScrollHintNeededEvent;
begin
  Result := fSBCtrl.VertScrollBarStyles.OnScrollHintNeeded;
end;

procedure TCustomElListBox.SetVertScrollHintNeeded(Value: TElScrollHintNeededEvent);
begin
  fSBCtrl.VertScrollBarStyles.OnScrollHintNeeded := Value;
end;

{> ELSCROLLBAR}
*) // <trash> // LAW

procedure TCustomElListBox.DrawBackground(DC: HDC; R: TRect);
var
  X, Y: integer;
begin
  if FUseBackground and not Background.Empty then
  begin
    X := R.Left; Y := R.Top;
    while Y < R.Bottom do
    begin
      while X < R.Right do
      begin
        BitBlt(DC, X, Y, R.Right - X, R.Bottom - Y,
          Background.Canvas.Handle, 0, 0, SRCCOPY);
        Inc(X, Background.Width);
      end;
      X := R.Left;
      Inc(Y, Background.Height);
    end;
  end;
end;

procedure TCustomElListBox.DrawBackgroundEx(DC: HDC; R, SubR: TRect);
var
  Rgn: HRGN;
  SavedDC: integer;
begin
  SavedDC := SaveDC(DC);
  try
    Rgn := CreateRectRgnIndirect(SubR);
    try
      SelectClipRgn(DC, Rgn);
      DrawBackground(DC, R);
    finally
      DeleteObject(Rgn);
    end;
  finally
    RestoreDC(DC, SavedDC);
  end;
end;

procedure TCustomElListBox.DrawFlatBorder(DC: HDC; HDragging, VDragging : boolean);
var
  R : TRect;
  BS: TElFlatBorderType;
  MustRelease: boolean;
  AColor : TColor;

const BordersFlat : array[boolean] of Integer = (0, WS_BORDER);
      Borders3D : array[boolean] of Integer = (0, WS_EX_CLIENTEDGE);

begin
  if (BorderStyle = bsNone) or (not HandleAllocated) then
    exit;
  if IsThemeApplied then
  begin
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_UPDATENOW);
    exit;
  end;

  MustRelease := (DC = 0);
  if MustRelease then
    DC := GetWindowDC(Handle);
  R := Rect(0, 0, Width, Height);
  try
    if (BorderStyle = bsSingle) then
    begin
      if Focused or FMouseOver then
        BS := FActiveBorderType
      else
        BS := FInactiveBorderType;
      if Focused or FMouseOver then
        AColor := LineBorderActiveColor
      else
        AColor := LineBorderInactiveColor;
      DrawFlatFrameEx2(DC, R, AColor, Color, Focused or FMouseOver, Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
    end;
    if (not false{UseCustomScrollBars}) and // <trash> // LAW
       (FFlatFocusedScrollBars or not (Focused or FMouseOver))
    then
      DrawFlatScrollbars(Handle, DC, R,
        (Focused or FMouseOver) and not FFlatFocusedScrollBars,
        ssBoth, HDragging, VDragging, False,
        GetWindowLong(Handle, GWL_STYLE) or BordersFlat[(not Ctl3D) and (BorderStyle = bsSingle)],
        GetWindowLong(Handle, GWL_EXSTYLE) or Borders3D[Ctl3D and (BorderStyle = bsSingle)]);
  finally
    if MustRelease then
      ReleaseDC(Handle, DC);
  end;
end;

procedure TCustomElListBox.DoDrawText(Sender : TObject; ACanvas: TCanvas; const ACaption: TElFString;
  {index: integer;} var Rect: TRect; Flags: LongInt);
begin
  SetBkMode(ACanvas.Handle, Windows.TRANSPARENT);
  {$IFDEF ELPACK_UNICODE}
  DrawTextW(ACanvas.Handle, PWideChar(ACaption), Length(ACaption), Rect, Flags);
  {$ELSE}
  DrawText(ACanvas.Handle, PChar(ACaption), Length(ACaption), Rect, Flags);
  {$ENDIF}
end;

procedure TCustomElListBox.SetStyle(Value: TListBoxStyle);
begin
  if FStyle <> Value then
  begin
    {$IFDEF VCL_6_USED}
    if Value in  [lbVirtual, lbVirtualOwnerDraw] then
    begin
       if (csDesigning in ComponentState) and (not (csReading in ComponentState) ) then
        raise Exception.Create('TElListBox do not support virtual styles: lbVirtual, lbVirtualOwnerDraw');
      if Value=lbVirtual then
        Value := lbStandard
      else
        Value := lbOwnerDrawFixed;
      if FStyle = Value then
        exit;
    end;
    {$ENDIF}
    FStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.DrawItem(Index: Integer; R: TRect; State:
    TOwnerDrawState);
var
  Flags, TextColor, BackColor: longint;
  TextRect: TRect;
  R1,
  BgRect  : TRect;
  P       : TPoint;
  ax, ay  : integer;
  S       : TSize;
  sid,
  pid     : integer;
  i       : integer;
  AColor  : TColor;
  ar2 : TRect;
  BMP, amBMP: TBitmap;
begin
  if (FStyle <> lbStandard) and Assigned(FOnDrawItem) then
  begin
    FOnDrawItem(Self, Index, R, State);
    exit;
  end;
  TextColor := GetTextColor(Canvas.Handle);
  BackColor := GetBkColor(Canvas.Handle);
  AColor    := BackColor;

  if (odSelected in State) and (not FInvertSelection) and FTransparentSelection then
    Canvas.Font.Color := Font.Color;

  if (odSelected in State) and (not FInvertSelection) and (not FTransparentSelection) then
  begin
    if Focused then
      AColor := FocusedSelectColor
    else
    if not HideSelection then
      AColor := HideSelectColor
    else
      AColor := Color;

    if HighlightAlphaLevel = 255 then
    begin
      Canvas.Brush.Color := AColor;
      Canvas.FillRect(R);
    end;
    BgRect := R;
  end
  else
  begin
    if (FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and
      (not (csDesigning in Componentstate)) then
    begin
      // if (FImgForm.Control <> Self) then
      begin
        R1 := R;
        BgRect := R;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        P := ClientToScreen(ClientRect.TopLeft);
        ax := BgRect.Left - P.x;
        ay := BgRect.Top - P.y;

        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);

        BgRect.TopLeft := RealScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := RealScreenToClient(BgRect.BottomRight);
        FImgForm.PaintBkgnd(Canvas.Handle, R1, Point(BgRect.Left - ax, BgRect.Top - ay), false);
      end;
      if (BgRect.Bottom > GetParentCtlHeight) or
         (BgRect.Right  > GetParentCtlWidth) or
         (BgRect.Left < 0) or (BgRect.Top < 0) then
        Canvas.FillRect(R);
    end
    else
    if FTransparent then
      DrawParentControlEx(Canvas.Handle, R)
    else
    if FUseBackground and not Background.Empty then
      DrawBackgroundEx(Canvas.Handle, ClientRect, R)
    else
    if not FTransparentSelection then
    begin
      Canvas.FillRect(R);
    end;
  end;
  if (odSelected in State) and FInvertSelection then
    InvertRect(Canvas.Handle, R);

  if (odSelected in State) then
  begin
    if (not FTransparentSelection) and (UseSelectedFont) then
      Canvas.Font.Assign(FSelectedFont)
    else
    begin
      if Focused then
        Canvas.Font.Color := FocusedSelectTextColor
      else
      if not HideSelection then
        Canvas.Font.Color := HideSelectTextColor
      else
        Canvas.Font.Color := Font.Color;
    end;
  end;

  if Index < Items.Count then
  begin
    if Images <> nil then
    begin
      i := ImageIndex[Index];
      if i <> -1 then
      begin
        ar2.Left := R.Left + 1;
        ar2.top := R.Top + ((R.Bottom - R.Top) - Images.Height) div 2;
        if (FAlphaImages<>nil) and (FAlphaImages.Count > i) then
        begin
          BMP := TBitmap.Create;
          BMP.Width := FImages.Width;
          BMP.Height := FImages.Height;
          ImageList_DrawEx(FImages.Handle, i, BMP.Canvas.Handle, 0, 0, 0, 0,
            clNone, clNone, ILD_Normal);

          amBMP := TBitmap.Create;
          amBMP.Width := FAlphaImages.Width;
          amBMP.Height := FAlphaImages.Height;
          ImageList_DrawEx(FAlphaImages.Handle, i, amBMP.Canvas.Handle, 0, 0, 0, 0,
            clNone, clNone, ILD_Normal);

          ar2.Right := ar2.Left + BMP.Width;
          ar2.Bottom := ar2.Top + BMP.Height;

          AlphaCopyRect2(Canvas.Handle, ar2, BMP.Canvas.Handle,
            rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

          BMP.Free;
          amBMP.Free;
        end
        else
          FImages.Draw(Canvas, ar2.left, ar2.top, i);
      end;
      inc(R.Left, Images.Width + 3);
    end;
    if ShowCheckBox then
    begin
      R1 := R;
      s := GetCheckBoxSize;

      if RightAlignedText then
      begin
        dec(R1.Right, 2);
        R1.Left := R1.Right - S.cx;
      end
      else
      begin
        inc(R1.Left, 2);
        R1.Right := R1.Left + S.cx;
      end;
      R1.Top := R1.Top + (R1.Bottom - R1.Top - S.cy) div 2;
      R1.Bottom := R1.Top + S.cy;
      if IsThemeApplied then
      begin
        pid := BP_CHECKBOX;
        sid := 0;
        case GetState(Index) of
          cbUnchecked :
            if not Enabled then
              sid := CBS_UNCHECKEDDISABLED
            else
              sid := CBS_UNCHECKEDNORMAL;

          cbChecked :
            if not Enabled then
              sid := CBS_CHECKEDDISABLED
            else
              sid := CBS_CHECKEDNORMAL;

          cbGrayed :
            if not Enabled then
              sid := CBS_MIXEDDISABLED
            else
              sid := CBS_MIXEDNORMAL;
        end;
        DrawThemeBackground(Theme, Canvas.Handle, pid, sid, R1, @R);
      end
      else
      begin
        i := 0;
        case GetState(Index) of
          cbChecked : i := DFCS_BUTTONCHECK or DFCS_CHECKED;
          cbUnchecked : i := DFCS_BUTTONCHECK;
          cbGrayed : i := DFCS_BUTTON3STATE or DFCS_CHECKED;
        end; // case
        DrawFrameControl(Canvas.Handle, R1, DFC_BUTTON, i);
        if Flat then
          DrawFlatFrame(Canvas, R1);
      end;
      if RightAlignedText then
        R.Right := R1.Left - 1
      else
        R.Left := R1.Right + 1;
    end;
    TextRect := R;
    Flags := DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;
    if RightAlignedText then
      Flags := Flags or DT_RTLREADING;
    if RightAlignedText then
      Inc(TextRect.Left, 2)
    else
      Dec(TextRect.Right, 2);

    if Assigned(FOnDrawText) then
      FOnDrawText(Self, Canvas, Index, TextRect, Flags)
    else
      DoDrawText(Self, Canvas, Items[Index], TextRect, Flags);
  end;
  if (odSelected in State) and (not FInvertSelection) and
    (not FTransparentSelection) and (HighlightAlphaLevel < 255) then
  begin
    AlphaFillRect(Canvas, BgRect, AColor, HighlightAlphaLevel);
  end;

  SetTextColor(Canvas.Handle, TextColor);
  SetBkColor(Canvas.Handle, BackColor);
end;

procedure TCustomElListBox.DrawParentControl(DC: HDC);
var
  SavedDC: integer;
  P: TPoint;
begin
  if Assigned(Parent) then
  begin
    SavedDC := SaveDC(DC);
    try
      P := Parent.ScreenToClient(ClientOrigin);
      MoveWindowOrg(DC, -P.X, -P.Y);
      Parent.Perform(WM_ERASEBKGND, DC, 0);
      Parent.Perform(WM_PAINT, DC, 0);
      THackWinControl(Parent).PaintControls(DC, nil);
    finally
      RestoreDC(DC, SavedDC);
    end;
  end;
end;

procedure TCustomElListBox.DrawParentControlEx(DC: HDC; R: TRect);
var
  Rgn: HRGN;
  SavedDC: integer;
begin
  SavedDC := SaveDC(DC);
  try
    Rgn := CreateRectRgnIndirect(R);
    try
      SelectClipRgn(DC, Rgn);
      DrawParentControl(DC);
    finally
      DeleteObject(Rgn);
    end;
  finally
    RestoreDC(DC, SavedDC);
  end;
end;

function TCustomElListBox.GetItemWidth(Index: Integer): Integer;
var
  ATabWidth: Longint;
  S: TElFString;
  {$IFDEF ELPACK_UNICODE}
  ARect : TRect;
  i, j  : integer;
  {$ENDIF}
begin
  S := Items[Index] + 'W';
  {$IFDEF ELPACK_UNICODE}
  ATabWidth := 0;
  j := 0;
  if TabWidth > 0 then
  begin
    ATabWidth := Round((TabWidth * Canvas.TextWidth('0')) * 0.25);
    for i := 1 to Length(S) do
      if S[i] = TElFChar(#9) then
        inc(j);
  end;
  SetRectEmpty(ARect);
  ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(S), Length(S), ARect, DT_CALCRECT);
  result := ARect.Right + j * ATabWidth;
  {$ELSE}
  if TabWidth > 0 then
  begin
    ATabWidth := Round((TabWidth * Canvas.TextWidth('0')) * 0.25);
    Result := LoWord(GetTabbedTextExtent(Canvas.Handle, @S[1], Length(S),
      1, ATabWidth));
  end
  else
    Result := Canvas.TextWidth(S);
  {$ENDIF}
end;

function TCustomElListBox.GetParentCtlHeight: Integer;
var ACtl : TWinControl;
begin
  ACtl := FImgForm.GetRealControl;
  result := ACtl.ClientHeight;
end;

function TCustomElListBox.GetParentCtlWidth: Integer;
var ACtl : TWinControl;
begin
  ACtl := FImgForm.GetRealControl;
  result := ACtl.ClientWidth;
end;

function TCustomElListBox.GetThemedClassName: WideString;
begin
  Result := 'BUTTON';
end;

procedure TCustomElListBox.HintWndProc(var Message: TMessage);
begin
  FHintWndProc(Message);
  if (Message.Msg = WM_SHOWWINDOW) and (Message.wParam = 0) then
  begin
    FHintWnd.WindowProc := FHintWndProc;
    CancelLineHint;
  end;
end;

procedure TCustomElListBox.IFMRepaintChildren(var Message: TMessage);
var i : integer;
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  for i := 0 to ControlCount -1 do
  begin
    if Controls[i] is TWinControl then
      PostMessage(TWinControl(Controls[i]).Handle, Message.Msg, Message.wParam, Message.lParam);
  end;
end;

procedure TCustomElListBox.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElListBox.IntMouseMove(XPos, YPos : SmallInt);
var i : integer;
begin
  if (TopIndex <> -1) and (ItemHeight > 0) then
  begin
    i := TopIndex + (YPos div ItemHeight - 1);
    if YPos mod ItemHeight > 0 then
      inc(i);
    if i <> FCurHintItem then
    begin
      if FHintTimer <> nil then
        CancelLineHint;
      if ShowLineHint and (i < Items.Count) then
      begin
        FCurHintItem := i;
        if FHintTimer = nil then
          FHintTimer := TTimer.Create(nil);
        FHintTimer.Enabled := false;
        FHintTimer.OnTimer := OnLineHintTimer;
        FHintTimer.Interval:= Application.HintPause;
        FHintTimer.Enabled := True;
      end
      else
        FCurHintItem := -1;
    end;
  end
  else
    FCurHintItem := -1;
end;

procedure TCustomElListBox.LBGetTopIndex(var Msg: TMessage);
var
  R: TRect;
begin
  inherited;
  if (FLastTopIndex <> Msg.Result) and (FUseBackground and not Background.Empty) then
  begin
    R := ClientRect;
    InvalidateRect(Handle, @R, False);
    FLastTopIndex := Msg.Result;
  end;
end;

procedure TCustomElListBox.Loaded;
begin
  inherited;
  ItemIndex := FItemIndex;
  if HandleAllocated then
    UpdateItemHeight;
  if HandleAllocated then
    RecreateWnd;
end;

procedure TCustomElListBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = Images then
      Images := nil;
    if AComponent = AlphaForImages then
      AlphaForImages := nil;
    if AComponent = FImgForm then
    begin
      FImgForm := nil;
      Invalidate;
    end;
  end;
end;

procedure TCustomElListBox.OnLineHintTimer(Sender : TObject);
var i : integer;
    P : TPoint;
    R,
    R1: TRect;
    FC: TColor;
begin
  FHintTimer.Enabled := false;
  if FHintWnd = nil then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    i := ItemAtPos(P, true);//SendMessage(Handle, LB_ITEMFROMPOINT, 0, MakeLParam(P.X, P.Y));
    if (i < 0) or (i >= Items.Count) then
      exit;

    if GetItemWidth(i) < ClientWidth then
      FCurHintItem := -1
    else
    if (i <> FCurHintItem) or (i < 0) or (i >= Items.Count) then
    begin
      if InRange(0, Items.Count - 1, i) then
      begin
        FCurHintItem := i;
        FHintTimer.Enabled := true;
      end
      else
        FCurHintItem := -1;
    end
    else
    begin
      FHintWnd := CreateHintWindow;
      FC := FHintWnd.Font.Color;
      FHintWnd.Font := Font;
      FHintWnd.Font.Color := FC;
      {$IFDEF ELPACK_UNICODE}
      R := FHintWnd.CalcHintRectW(10000, Items[i], nil);
      {$ELSE}
      R := FHintWnd.CalcHintRect(10000, Items[i], nil);
      {$ENDIF}

      R1 := ItemRect(i);
      OffsetRect(R, R1.Left - 3, R1.Top - 3);
      R.TopLeft := ClientToScreen(R.TopLeft);
      R.BottomRight := ClientToScreen(R.BottomRight);

      {$IFDEF ELPACK_UNICODE}
      FHintWnd.ActivateHintW(R, Items[i]);
      {$ELSE}
      FHintWnd.ActivateHint(R, Items[i]);
      {$ENDIF}
      FHintWndProc := FHintWnd.WindowProc;
      FHintWnd.WindowProc := HintWndProc;
      FHintTimer.Interval := Application.HintHidePause;
      FHintTimer.Enabled := true;
    end;
  end
  else
  begin
    FHintWnd.Free;
    FHintWnd := nil;
  end;
end;

function TCustomElListBox.RealScreenToClient(APoint : TPoint): TPoint;
var ACtl : TWinControl;
begin
  ACtl := FImgForm.GetRealControl;
  result := ACtl.ScreenToClient(APoint);
end;

procedure TCustomElListBox.ResetHorizontalExtent;
var
  I: Integer;
begin
  FMaxWidth := 0;
  for I := 0 to Items.Count - 1 do
    FMaxWidth := Max(FMaxWidth, GetItemWidth(I));
  SetHorizontalExtent;
end;

procedure TCustomElListBox.SelectedFontChanged(Sender: TObject);
begin
  ParentFont := False;
end;

procedure TCustomElListBox.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
var
  R1, BgRect : TRect;
begin
  if (FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and
    (not (csDesigning in Componentstate)) then
  begin
    R1 := ClientRect;
    BgRect := ClientRect;
    BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);

    BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
    BgRect.TopLeft := RealScreenToClient(BgRect.TopLeft);
    BgRect.BottomRight := RealScreenToClient(BgRect.BottomRight);

    FImgForm.PaintBkgnd(Msg.DC, R1, Point(BgRect.Left{ - ax}, BgRect.Top{ - ay}), false);
  end else
  if FTransparent then
    DrawParentControl(Msg.DC)
  else
  if FUseBackground and not Background.Empty then
    DrawBackground(Msg.DC, ClientRect)
  else
  begin
    (*
    {$IFDEF VCL_4_USED}
    if DoubleBuffered then
      inherited
    else
    {$ENDIF}
      Msg.Result := 1;
    *)
    inherited
    //Msg.Result := 1;
  end;
end;

procedure TCustomElListBox.WMHScroll(var Message: TMessage);
var
  fSavePos: Integer;
begin
  if Visible and (TWMScroll(Message).ScrollCode in [SB_LINEUP..SB_RIGHT]) then
  begin
    fSavePos := GetScrollBarPos( Handle, SB_HORZ);
    inherited;
    if fSavePos = GetScrollBarPos( Handle, SB_HORZ) then
      exit;
    if TWMScroll(Message).ScrollCode = SB_THUMBTRACK then
      FInHSCroll := true
    else
      FInHSCroll := false;

    if (Flat and (((not FMouseOver) and (not Focused)) or (FlatFocusedScrollBars))) then
      DrawFlatBorder(0, FInHScroll, FInVScroll);

    // repaint when scrolling
    //if not UseCustomScrollBars then
      Invalidate;
  end
  else
    inherited; // SB_ENDSCROLL
end;

procedure TCustomElListBox.WMKillFocus(var Msg: TMessage);
begin
  inherited;
  if not HandleAllocated then
    exit;
  if Flat and not FMouseOver then
    DrawFlatBorder(0, false, false);
  if (Flat and ShowCheckBox) or HideSelection or (HideSelectColor <> FocusedSelectColor) or
     (HideSelectTextColor <> FocusedSelectTextColor) then
    Invalidate;
end;

procedure TCustomElListBox.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  if FInVScroll or FInHScroll then
  begin
    if (Flat and
       (((not FMouseOver) and
         (not Focused)) or
       (FlatFocusedScrollBars))) then
      DrawFlatBorder(0, FInHScroll, FInVScroll);
  end;
  IntMouseMove(Message.XPos, Message.YPos);
end;

procedure TCustomElListBox.WMNCCalcSize(var Message : TWMNCCalcSize);
begin
  inherited;
  if (BorderStyle = bsSingle) and Flat and
    (not (ThemesAvailable and UseXPThemes and QueryThemeData)) then
  begin
    if (ebsLeft in BorderSides) then
      inc(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smXEdge[Ctl3D]));
    if (ebsTop in BorderSides) then
      inc(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smYEdge[Ctl3D]));
    if (ebsRight in BorderSides) then
      dec(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smXEdge[Ctl3D]));
    if (ebsBottom in BorderSides) then
      dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smYEdge[Ctl3D]));
  end
  else
  if (BorderStyle = bsSingle) and (not (ThemesAvailable and UseXPThemes and QueryThemeData)) then
  begin
    if not (ebsLeft in BorderSides) then
      dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smXEdge[Ctl3D]));
    if not (ebsTop in BorderSides) then
      dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smYEdge[Ctl3D]));
    if not (ebsRight in BorderSides) then
      Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smXEdge[Ctl3D]));
    if not (ebsBottom in BorderSides) then
      Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));
  end;
  // Message.Result := WVR_REDRAW;
end;

procedure TCustomElListBox.WMNCMouseMove(var Message: TMessage);
begin
  inherited;
  if FInVScroll or FInHScroll then
  begin
    if (Flat and
       (((not FMouseOver) and
         (not Focused)) or
       (FlatFocusedScrollBars)))
     then DrawFlatBorder(0, FInHScroll, FInVScroll);
  end;
end;

procedure TCustomElListBox.WMNCPaint(var Msg : TMessage);
var DC : HDC;
    RW,
    RC : TRect;
    b  : Boolean;

  procedure CallInheritedWOFrame;
  var
    WS, WES :DWORD;
  begin
    try
      WES := GetWindowLong(Handle, GWL_EXSTYLE);
      if WES and WS_EX_CLIENTEDGE <> 0 then
      begin
        WS := 0;
        FPreventStyleChange := True;
        SetWindowLong(Handle, GWL_EXSTYLE, WES and not WS_EX_CLIENTEDGE);
      end
      else
      begin
        WES := 0;
        WS  := GetWindowLong(Handle, GWL_STYLE);
        if WS and WS_BORDER <> 0 then
        begin
          FPreventStyleChange := True;
          SetWindowLong(Handle, GWL_STYLE, WS and not WS_BORDER);
        end
        else
          WS := 0;
      end;
      //inherited;
      DefWindowProc(Handle, Msg.Msg, Msg.wParam, Msg.lParam);

      if WES <> 0 then
        SetWindowLong(Handle, GWL_EXSTYLE, WES)
      else if WS <> 0 then
        SetWindowLong(Handle, GWL_STYLE, WS);
    finally
      if FPreventStyleChange then
        FPreventStyleChange := False;
    end;
  end;

  procedure PaintCrossSystemScrollbarsArea;
    var
      nFrameSize :Integer;
  begin
    // paint left cross scrollbars area for system scrollbars:
    begin
      GetWindowRect(Handle, RW);
      MapWindowPoints(0, Handle, RW, 2);
      OffsetRect(RW, -RW.Left, -RW.Top);

      if ((GetWindowLong(Handle, GWL_STYLE) and WS_BORDER) = WS_BORDER) then
        nFrameSize := GetSystemMetrics(SM_CXBORDER)
      else
        if ((GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE) then
        nFrameSize := GetSystemMetrics(SM_CXEDGE)
      else
        nFrameSize := 0;

      with RW do
      begin
        if (not RightAlignedView) or (not NewStyleControls) then
        begin
          dec(Right, nFrameSize);
          Left:= Right - GetSystemMetrics(SM_CXVSCROLL);
          dec(Bottom, nFrameSize);
          Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
        end
        else
        begin
          Left   := nFrameSize;
          Right := Left + GetSystemMetrics(SM_CXVSCROLL);
          dec(Bottom, nFrameSize);
          Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
        end;
        Windows.DrawEdge(DC, RW, EDGE_SUNKEN, BF_MIDDLE);
      end;
    end;
  end;

begin
  if FPreventStyleChange then
    exit;

  b := (BorderStyle = bsSingle);

  //DefWindowProc(Handle, Msg.Msg, Msg.wParam, Msg.lParam);
  if IsThemeApplied and (BorderStyle = bsSingle) {and not Transparent} then
  begin
    //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    //if DC = 0 then
    begin
      DC := GetWindowDC(Handle);
    end;

    if b then
      CallInheritedWOFrame;

    Windows.GetClientRect(Handle, RC);

    {< ELSCROLLBAR}
    if false {UseCustomScrollBars} then // <trash> // LAW
    begin //???
(*      if VertScrollBarStyles.Visible then
      begin
        if (not RightAlignedView) then
          inc(RC.Right, VertScrollBarStyles.Depth)
        else
          dec(RC.Left, VertScrollBarStyles.Depth);
      end;
      if HorzScrollBarStyles.Visible then
        inc(RC.Bottom, HorzScrollBarStyles.Depth);*) // <trash> // LAW
    end
    else
    {> ELSCROLLBAR}
    begin
      if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
      begin
        if (not RightAlignedView) or (not NewStyleControls) then
          inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL))
        else
          dec(RC.Left, GetSystemMetrics(SM_CXVSCROLL));

        // paint cross scrollbars area for system scrollbar:
        if (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) then
          PaintCrossSystemScrollbarsArea;

      end;
      if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
        inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
    end;

    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    OffsetRect(RW, -RW.Left, -RW.Top);

    DrawThemeBackgroundTo('LISTVIEW', DC, 0, 0, RW, nil);
    ReleaseDC(Handle, DC);
  end
  else
  begin
      inherited;
    if RightAlignedView and (not false{UseCustomScrollBars}) and // <trash> // LAW
       (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) and
       (NewStyleControls)
    then
    begin
      DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
      if DC = 0 then
        DC := GetWindowDC(Handle);
      PaintCrossSystemScrollbarsArea;
      ReleaseDC(Handle, DC);
    end;
  end;
end;

function GetDynamicMethod(AClass: TClass; Index: Integer): Pointer; assembler;
asm
  CALL System.@FindDynaClass
end;

function GetRandomRgn(DC: HDC; rgn: HRGN; Flags : integer): Integer; stdcall; external gdi32 name 'GetRandomRgn';

const SYSRGN = 4;

procedure TCustomElListBox.WMPaint(var Msg: TWMPaint);
type TWMPaintProc = procedure (Self : TWinControl; var Msg: TWMPaint);
var
  DC: HDC;
  R1, BgRect : TRect;
  P          : TPoint;
  ax, ay     : integer;
  bPaint     : TWMPaintProc;
  //aBrush     : HBrush;
  //PS         : TPaintStruct;
begin
  bPaint := TWMPaintProc(GetDynamicMethod(TWinControl, WM_PAINT));

  if FTransparent or (FUseBackground and not Background.Empty) or
     ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and
       (not (csDesigning in Componentstate))) then
  begin
    Perform(LB_GETTOPINDEX, 0, 0);

    bPaint(Self, msg);

    if Items.Count = 0 then
    begin
      DC := GetDC(Handle);
      try
        if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.Componentstate)) then
        begin
          if (FImgForm.Control <> Self) then
          begin
            R1 := ClientRect;
            BgRect := ClientRect;
            BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
            P := ClientToScreen(ClientRect.TopLeft);
            ax := BgRect.Left - P.x;
            ay := BgRect.Top - P.y;

            BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
            BgRect.TopLeft := RealScreenToClient(BgRect.TopLeft);
            BgRect.BottomRight := RealScreenToClient(BgRect.BottomRight);

            FImgForm.PaintBkgnd(DC, R1, Point(BgRect.Left - ax, BgRect.Top - ay), false);
          end
        end
        else
        if FTransparent then
          DrawParentControl(DC)
        else
          DrawBackground(DC, ClientRect);
      finally
        ReleaseDC(Handle, DC);
      end;
    end;
  end
  else
  begin
    (*
    BeginPaint(Handle, PS);
    try
      DC := PS.hdc;
      GetClipBox(DC, R1);
      ABrush := CreateSolidBrush(ColorToRGB(Color));
      FillRect(DC, R1, ABrush);
      DeleteObject(ABrush);
      bPaint(Self, msg);
    finally
      EndPaint(Handle, PS);
    end;
    *)
    bPaint(Self, msg);
  end;

  if FFlat and (not IsThemeApplied) then
  begin
    DC := GetWindowDC(Handle);
    try
      DrawFlatBorder(DC, FInHScroll, FInVScroll);
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TCustomElListBox.WMSetFocus(var Msg: TMessage);
begin
  inherited;
  if Flat and not FMouseOver then
    DrawFlatBorder(0, false, false);
  if (Flat and ShowCheckBox) or HideSelection or (HideSelectColor <> FocusedSelectColor) or
     (HideSelectTextColor <> FocusedSelectTextColor) then
    Invalidate;
end;

procedure TCustomElListBox.WMVScroll(var Message: TMessage);
var
  fSavePos: Integer;
begin
  if Visible and (TWMScroll(Message).ScrollCode in [SB_LINEUP..SB_RIGHT]) then
  begin
    fSavePos := GetScrollBarPos( Handle, SB_VERT);
    inherited;
    if fSavePos = GetScrollBarPos( Handle, SB_VERT) then
      exit;
    if TWMScroll(Message).ScrollCode = SB_THUMBTRACK then
      FInVSCroll := true
    else
      FInVSCroll := false;

    if (Flat and (((not FMouseOver) and (not Focused)) or (FlatFocusedScrollBars))) then
      DrawFlatBorder(0, FInHScroll, FInVScroll);
    // repaint when scrolling
    //if not UseCustomScrollBars then
      Invalidate;
  end
  else
    inherited; // SB_ENDSCROLL
end;

procedure TCustomElListBox.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TCustomElListBox.WndProc(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) and ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging then
  begin
    if DragMode = dmAutomatic then
    begin
      if IsControlMouseMsg(TWMMouse(Message)) then
        Exit;
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message);  {overrides TControl's BeginDrag}
      Exit;
    end;
  end;
  if not HorizontalScroll then
    inherited WndProc(Message)
  else
  case Message.Msg of
    LB_ADDSTRING, LB_INSERTSTRING:
      begin
        inherited WndProc(Message);
        FMaxWidth := Max(FMaxWidth, GetItemWidth(Message.Result));
        SetHorizontalExtent;
      end;
    LB_DELETESTRING:
      begin
        if GetItemWidth(Message.wParam) >= FMaxWidth then
        begin
          Perform(WM_HSCROLL, SB_TOP, 0);
          inherited WndProc(Message);
          ResetHorizontalExtent;
        end
        else
          inherited WndProc(Message);
      end;
    LB_RESETCONTENT:
      begin
        FMaxWidth := 0;
        SetHorizontalExtent;
        Perform(WM_HSCROLL, SB_TOP, 0);
        inherited WndProc(Message);
      end;
    WM_SETFONT:
      begin
        inherited WndProc(Message);
        Canvas.Font.Assign(Self.Font);
        ResetHorizontalExtent;
        Exit;
      end;
    else
      inherited WndProc(Message);
  end;
end;

function TCustomElListBox.GetItemHeight: Integer;
var
  R: TRect;
begin
  if HandleAllocated then
  begin
    if Style = lbOwnerDrawVariable then
    begin
      Perform(LB_GETITEMRECT, 0, Longint(@R));
      Result := R.Bottom - R.Top;
    end
    else
      Result := FItemHeight;
  end
  else
    Result := FItemHeight;
end;

function TCustomElListBox.GetItemIndex: Integer;
begin
  if MultiSelect then
    Result := SendMessage(Handle, LB_GETCARETINDEX, 0, 0)
  else
    Result := SendMessage(Handle, LB_GETCURSEL, 0, 0);
end;

function TCustomElListBox.GetSelCount: Integer;
begin
  Result := SendMessage(Handle, LB_GETSELCOUNT, 0, 0);
end;

function TCustomElListBox.GetSelected(Index: Integer): Boolean;
var
  R: Longint;
begin
  R := SendMessage(Handle, LB_GETSEL, Index, 0);
  if R = LB_ERR then
  {$IFDEF VCL_5_USED}
    raise EListError.CreateResFmt(@SListIndexError, [Index]);
  {$ELSE}
    raise EListError.CreateFmt(SListIndexError, [Index]);
  {$ENDIF}
  Result := LongBool(R);
end;

function TCustomElListBox.GetTopIndex: Integer;
begin
  Result := SendMessage(Handle, LB_GETTOPINDEX, 0, 0);
end;

procedure TCustomElListBox.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetColumns(Value: Integer);
begin
  if FColumns <> Value then
    if (FColumns = 0) or (Value = 0) then
    begin
      FColumns := Value;
      RecreateWnd;
    end else
    begin
      FColumns := Value;
      if HandleAllocated then
        SetColumnWidth;
    end;
end;

procedure TCustomElListBox.SetExtendedSelect(Value: Boolean);
begin
  if Value <> FExtendedSelect then
  begin
    FExtendedSelect := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetIntegralHeight(Value: Boolean);
begin
  if Value <> FIntegralHeight then
  begin
    FIntegralHeight := Value;
    RecreateWnd;
    RequestAlign;
  end;
end;

procedure TCustomElListBox.SetItemHeight(Value: Integer);
begin
  if (FItemHeight <> Value) and (Value > 0) then
  begin
    FItemHeight := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetItemIndex(Value: Integer);
begin
  if csLoading in ComponentState then
    FItemIndex := Value
  else
  if GetItemIndex <> Value then
    if MultiSelect then
      SendMessage(Handle, LB_SETCARETINDEX, Value, 0)
    else
      SendMessage(Handle, LB_SETCURSEL, Value, 0);
end;

procedure TCustomElListBox.SetItems(Value: TElFStrings);
begin
  Items.Assign(Value);
end;

procedure TCustomElListBox.SetMultiSelect(Value: Boolean);
begin
  if FMultiSelect <> Value then
  begin
    FMultiSelect := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetSelected(Index: Integer; Value: Boolean);
begin
  if SendMessage(Handle, LB_SETSEL, Longint(Value), Index) = LB_ERR then
  {$IFDEF VCL_5_USED}
    raise EListError.CreateResFmt(@SListIndexError, [Index]);
  {$ELSE}
    raise EListError.CreateFmt(SListIndexError, [Index]);
  {$ENDIF}
end;

procedure TCustomElListBox.SetSorted(Value: Boolean);
begin
  if FSorted <> Value then
  begin
    FSorted := Value;
    TElFStringList(FListBoxStrings).Sorted := true;
  end;
end;

procedure TCustomElListBox.SetTabWidth(Value: Integer);
begin
  if Value < 0 then
    Value := 0;
  if FTabWidth <> Value then
  begin
    FTabWidth := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetTopIndex(Value: Integer);
begin
  if GetTopIndex <> Value then
    SendMessage(Handle, LB_SETTOPINDEX, Value, 0);
end;

function TCustomElListBox.InternalGetItemData(Index: Integer): LongInt;
begin
  Result := GetItemData(Index);
end;

procedure TCustomElListBox.InternalSetItemData(Index: Integer; AData: LongInt);
begin
  SetItemData(Index, AData);
end;

function TCustomElListBox.ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
var
  Count: Integer;
  ItemRect: TRect;
begin
  if PtInRect(ClientRect, Pos) then
  begin
    Result := TopIndex;
    Count := Items.Count;
    while Result < Count do
    begin
      Perform(LB_GETITEMRECT, Result, Longint(@ItemRect));
      if PtInRect(ItemRect, Pos) then
        Exit;
      Inc(Result);
    end;
    if not Existing then
      Exit;
  end;
  Result := -1;
end;

function TCustomElListBox.ItemRect(Index: Integer): TRect;
var
  Count: Integer;
begin
  Count := Items.Count;
  if (Index = 0) or (Index < Count) then
    Perform(LB_GETITEMRECT, Index, Longint(@Result))
  else if Index = Count then
  begin
    Perform(LB_GETITEMRECT, Index - 1, Longint(@Result));
    OffsetRect(Result, 0, Result.Bottom - Result.Top);
  end else FillChar(Result, SizeOf(Result), 0);
end;

//@+ 2/5/03
procedure TCustomElListBox.CheckAll;
var
  i: Integer;
begin
  if ShowCheckBox then
    for i := 0 to pred(Items.Count) do
      State[i] := cbChecked;
end;

procedure TCustomElListBox.CheckSelected;
var
  i: Integer;
begin
  if ShowCheckBox then
    for i := 0 to pred(Items.Count) do
      if Selected[i] then
        State[i] := cbChecked;
end;

procedure TCustomElListBox.GrayAll;
var
  i: Integer;
begin
  if ShowCheckBox then
    for i := 0 to pred(Items.Count) do
      State[i] := cbGrayed;
end;

procedure TCustomElListBox.GraySelected;
var
  i: Integer;
begin
  if ShowCheckBox then
    for i := 0 to pred(Items.Count) do
      if Selected[i] then
        State[i] := cbGrayed;
end;

procedure TCustomElListBox.UncheckAll;
var
  i: Integer;
begin
  if ShowCheckBox then
    for i := 0 to pred(Items.Count) do
      State[i] := cbUnchecked;
end;

procedure TCustomElListBox.UncheckSelected;
var
  i: Integer;
begin
  if ShowCheckBox then
    for i := 0 to pred(Items.Count) do
      if Selected[i] then
        State[i] := cbUnchecked;
end;
//@- 2/5/03

(*
procedure TCustomElListBox.ResetHorizontalExtent1;
var
  I: Integer;
begin
  FMaxWidth := 0;
  for I := 0 to Items.Count - 1 do
    FMaxWidth := Max(FMaxWidth, GetItemWidth(I));
  SetHorizontalExtent;
end;
*)
procedure TCustomElListBox.SetHorizontalExtent;
begin
  SendMessage(Handle, LB_SETHORIZONTALEXTENT, FMaxWidth, 0);
end;

procedure TCustomElListBox.SetColumnWidth;
var
  ColWidth: Integer;
begin
  if (FColumns > 0) and (Width > 0) then
  begin
    ColWidth := (Width + FColumns - 3) div FColumns;
    if ColWidth < 1 then
      ColWidth := 1;
    SendMessage(Handle, LB_SETCOLUMNWIDTH, ColWidth, 0);
  end;
end;

function TCustomElListBox.GetItemData(Index: Integer): LongInt;
begin
  Result := SendMessage(Handle, LB_GETITEMDATA, Index, 0);
end;

procedure TCustomElListBox.SetItemData(Index: Integer; AData: LongInt);
begin
  SendMessage(Handle, LB_SETITEMDATA, Index, AData);
end;

procedure TCustomElListBox.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) and HandleAllocated then
    RecreateWnd;
  inherited;
end;

procedure TCustomElListBox.CNCommand(var Message: TWMCommand);
begin
  case Message.NotifyCode of
    LBN_SELCHANGE:
      begin
        inherited Changed;
        Click;
      end;
    LBN_DBLCLK: DblClick;
  end;
end;

procedure TCustomElListBox.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  with Message.DrawItemStruct^ do
  begin
{$IFNDEF VCL_4_USED}
    State := TOwnerDrawState(WordRec(LongRec(itemState).Lo).Lo);
{$ELSE}
    {$IFDEF VCL_5_USED}
    State := Windows.TOwnerDrawState(LongRec(itemState).Lo);
    {$ELSE}
    State := TOwnerDrawState(WordRec(LongRec(itemState).Lo).Lo);
    {$ENDIF}
{$ENDIF}
    FCanvas.Handle := hDC;
    FCanvas.Font := Font;
    FCanvas.Brush := Brush;

    (*if (Integer(itemID) >= 0) and (odSelected in State) then
    begin
      FCanvas.Brush.Color := clHighlight;
      FCanvas.Font.Color := clHighlightText
    end;
    *)
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State)
    else
      FCanvas.FillRect(rcItem);
    if odFocused in State then
      DrawFocusRect(hDC, rcItem);
    //with rcItem do
    //  ExcludeClipRect(hDC, Left, Top, Right, Bottom);
    FCanvas.Handle := 0;
  end;
end;

procedure TCustomElListBox.CNMeasureItem(var Message: TWMMeasureItem);
begin

  with Message.MeasureItemStruct^ do
  begin
    itemHeight := FItemHeight;
    if FStyle = lbOwnerDrawVariable then
      MeasureItem(itemID, Integer(itemHeight));
  end;
end;

procedure TCustomElListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  if Assigned(FOnMeasureItem) then FOnMeasureItem(Self, Index, Height);
end;

procedure TCustomElListBox.WMLButtonDown(var Message: TWMLButtonDown);
var
  ItemNo : Integer;
  ShiftState: TShiftState;
  p         : TPoint;
  R         : TRect;
  ImgOffs   : integer;
begin
  p := SmallPointToPoint(Message.Pos);
  if Images <> nil then
    ImgOffs := Images.Width + 2
  else
    ImgOffs := 0;
  (*
  if ImgOffs <> 0 then
  begin
    if InRange(1, ImgOffs + 2, P.x - R.Left) then
      exit;
  end;
  *)
  if ShowCheckBox then
  begin
    ItemNo := ItemAtPos(p, True);
    if ItemNo > -1 then
    begin
      R := ItemRect(ItemNo);
      if InRange(ImgOffs + 1, ImgOffs + GetCheckBoxSize.cx + 2, P.x - R.Left) then
      begin
        case GetState(ItemNo) of
          cbUnchecked:
            if AllowGrayed then
              SetState(ItemNo, cbGrayed)
            else
              SetState(ItemNo, cbChecked);
          cbGrayed:
            SetState(ItemNo, cbChecked);
          cbChecked:
            SetState(ItemNo, cbUnchecked);
        end;
        TriggerCheckStateChange(ItemNo);
        TriggerCheckBoxChange(ItemNo, GetState(ItemNo));
        exit;
      end;
    end;
  end;
  ShiftState := KeysToShiftState(Message.Keys);
  if (DragMode = dmAutomatic) and FMultiSelect then
  begin
    if not (ssShift in ShiftState) or (ssCtrl in ShiftState) then
    begin
      ItemNo := ItemAtPos(p, True);
      if (ItemNo >= 0) and (Selected[ItemNo]) then
      begin
        BeginDrag (False);
        Exit;
      end;
    end;
  end;
  ItemNo := ItemIndex;
  inherited;
  if (ItemNo <> ItemIndex)and Assigned(OnClick) then
    OnClick(Self);
  if (DragMode = dmAutomatic) and not (FMultiSelect and
    ((ssCtrl in ShiftState) or (ssShift in ShiftState))) then
    BeginDrag(False);
end;

procedure TCustomElListBox.WMSize(var Message: TWMSize);
begin
  inherited;
  SetColumnWidth;
  Invalidate;
end;

procedure TCustomElListBox.WMMouseWheel(var Message: TWMMouseWheel);
begin
  inherited;
  Invalidate;
end;

procedure TCustomElListBox.ResetContent;
begin
  SendMessage(Handle, LB_RESETCONTENT, 0, 0);
end;

procedure TCustomElListBox.DeleteString(Index: Integer);
begin
  SendMessage(Handle, LB_DELETESTRING, Index, 0);
end;

procedure TCustomElListBox.SetShowCheckBox(Value: Boolean);
begin
  if FShowCheckBox <> Value then
  begin
    FShowCheckBox := Value;
    Invalidate;
  end;
end;

function TCustomElListBox.GetState(Index: Integer): TCheckBoxState;
begin
  if (Index>=0) and (Index<Items.Count) then
  begin
    if FStatesSize <= Index then
      SetStatesSize(Index + 1);
    result := TCheckBoxState(FStates[Index]);
  end
  else
    result := cbUnChecked;
end;

procedure TCustomElListBox.SetState(Index: Integer; Value: TCheckBoxState);
var R : TRect;
begin
  if not ( (Index>=0) and (Index<Items.Count)) then
    exit;
  if FStatesSize <= Index then
    SetStatesSize(Index + 1);
  FStates[Index] := Char(Value);
  if HandleAllocated and (Index < Items.Count) then
  begin
    R := ItemRect(Index);
    if not IsRectEmpty(R) then
      InvalidateRect(Handle, @R, false);
  end;
end;

procedure TCustomElListBox.SetStatesSize(aSize : integer);
var P : PChar;
begin
  if aSize = 0 then
  begin
    if FStatesSize > 0 then
    begin
      FStatesSize := 0;
      FreeMem(FStates);
    end;
  end
  else
  begin
    GetMem(P, aSize);
    if (P <> nil) then
    begin
      FillMemory(P, aSize, byte(cbUnchecked));
      MoveMemory(P, FStates, Min(aSize, FStatesSize));
      if FStatesSize > 0 then
      begin
        FStatesSize := 0;
        FreeMem(FStates);
      end;
      FStates := P;
      FStatesSize := aSize;
    end;
  end;
end;

function TCustomElListBox.GetCheckBoxSize: TSize;
begin
  Result.cx := CheckBoxSize;
  Result.cy := CheckBoxSize;
  if IsThemeApplied() then
  begin
    GetThemePartSize(Theme, Canvas.Handle, BP_CHECKBOX, 1, nil, TS_TRUE, Result);
  end;
end;

procedure TCustomElListBox.SetAllowGrayed(Value: Boolean);
var i : integer;
begin
  if FAllowGrayed <> Value then
  begin
    FAllowGrayed := Value;
    if not FAllowGrayed then
    for i := 0 to Items.Count - 1 do
    begin
      if State[i] = cbGrayed then
        FStates[i] := Char(cbUnchecked);
    end;
  end;
end;

procedure TCustomElListBox.DrawFlatFrame(Canvas : TCanvas; R : TRect);
var AColor, Color : TColor;
begin
  if ((Focused or FMouseOver) and (ActiveBorderType = fbtColorLineBorder)) or
     ((not (Focused or FMouseOver)) and (InactiveBorderType = fbtColorLineBorder)) then
  begin
    if Enabled then
      Color := clWindow
    else
      Color := clBtnFace;
    if Focused or FMouseOver then
      AColor := LineBorderActiveColor
    else
      AColor := LineBorderInactiveColor;
    ELVCLUtils.DrawFlatFrameEx2(Canvas.Handle, R, AColor, Color, false, true, AllBorderSides, fbtColorLineBorder, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
  end
  else
    ElVCLUtils.DrawFlatFrame(Canvas.Handle, R, clWindow, false);
end;

procedure TCustomElListBox.OnImageListChange(Sender : TObject);
begin
  AdjustItemHeight;
  if (HandleAllocated) then
    Invalidate;//Repaint;
end; { OnImageListChange }

procedure TCustomElListBox.SetImages(newValue : TImageList);
{ Sets data member FImages to newValue. }
begin
  if (FImages <> newValue) then
  begin
    if FImages <> nil then
    begin
      {$IFDEF VCL_5_USED}
      if not (csDestroying in FImages.ComponentState) then
        FImages.RemoveFreeNotification(Self);
      {$ENDIF}
      FImages.UnRegisterChanges(FImageChangeLink);
    end;
    FImages := newValue;
    if FImages <> nil then
    begin
      FImages.RegisterChanges(FImageChangeLink);
      FImages.FreeNotification(Self);
    end;
    AdjustItemHeight;
    if (HandleAllocated) then
      Invalidate;
  end; { if }
end; { SetImages }

procedure TCustomElListBox.SetAlphaImages(newValue : TImageList);
{ Sets data member FAlphaImages to newValue. }
begin
  if (FAlphaImages <> newValue) then
  begin
    if FAlphaImages <> nil then
    begin
      {$IFDEF VCL_5_USED}
      if not (csDestroying in FAlphaImages.ComponentState) then
        FAlphaImages.RemoveFreeNotification(Self);
      {$ENDIF}
      FAlphaImages.UnRegisterChanges(FAImageChangeLink);
    end;
    FAlphaImages := newValue;
    if FAlphaImages <> nil then
    begin
      FAlphaImages.RegisterChanges(FAImageChangeLink);
      FAlphaImages.FreeNotification(Self);
    end;
//    AdjustItemHeight;
    if (HandleAllocated) then
      Invalidate;
  end; { if }
end; { SetAlphaImages }

procedure TCustomElListBox.AdjustItemHeight;
var r : integer;
    TM: TTextMetric;
begin
  if not HandleAllocated then
    r := Abs(Font.Height) + 2
  else
  begin
    GetTextMetrics(Canvas.Handle, TM);
    r := TM.tmHeight + 2;
  end;
  if Assigned(Images) then
    r := Max(r, Images.Height);
  ItemHeight := r;
end;

procedure TCustomElListBox.SetImagesSize(aSize : integer);
var P : PIntArray;
    i : integer;
begin
  if aSize = 0 then
  begin
    if FImagesSize > 0 then
    begin
      FImagesSize := 0;
      FreeMem(FImageIndex);
    end;
  end
  else
  begin
    GetMem(P, aSize * sizeof(Integer));
    if (P <> nil) then
    begin
      for i := 0 to aSize -1 do
        P[i] := -1;
      MoveMemory(P, FImageIndex, Min(aSize, FImagesSize) * sizeof(integer));
      if FStatesSize > 0 then
      begin
        FImagesSize := 0;
        FreeMem(FImageIndex);
      end;
      FImageIndex := P;
      FImagesSize := aSize;
    end;
  end;
end;

function TCustomElListBox.GetImageIndex(Index: Integer): Integer;
begin
  if (Index>=0) and (Index<Items.Count) then
  begin
    if FImagesSize <= Index then
      SetImagesSize(Index + 1);
    Result := FImageIndex[Index];
  end
  else
    result := -1;
end;

procedure TCustomElListBox.SetImageIndex(Index: Integer; Value: Integer);
var R : TRect;
begin
  if not ((Index>=0) and (Index<Items.Count)) then
    exit;
  if FImagesSize <= Index then
    SetImagesSize(Index + 1);
  FImageIndex[Index] := Value;
  if HandleAllocated and (Index < Items.Count) then
  begin
    R := ItemRect(Index);
    if not IsRectEmpty(R) then
      InvalidateRect(Handle, @R, false);
  end;
end;

{$IFDEF ELPACK_UNICODE}
procedure TCustomElListBox.CMHintShow(var Message: TMessage);
var HintInfo : PHintInfo;
{$IFDEF ELPACK_UNICODE}
var T: WideChar;
    l : integer;
    S : String;
    WS: WideString;
{$ENDIF}
begin
  inherited;
  HintInfo := PHintInfo(Message.lParam);
  if Length(FHint) = 0 then
  begin
    HintInfo.hintStr := '';
    exit;
  end;

  S := GetShortHint(inherited Hint);
  if HintInfo.HintStr = S then
  begin
    WS := GetShortHintW(FHint);
  end
  else
  begin
    S := FHint;
    WS := FHint;
  end;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
end;
{$ENDIF}

{$IFDEF ELPACK_UNICODE}
procedure TCustomElListBox.SetHint(Value: TElFString);
var S : String;
    i,
    l : integer;
    T : WideChar;
begin
  FHint := Value;

  S := FHint;
  i := Length(S);
  l := Length(S) + 1 + Length(FHint) * 2;
  SetLength(S, l + 4);
  S[i + 1] := #0;

  Move(FHint[1], S[i + 2], Length(FHint) * 2);
  T := #0;
  Move(T, S[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, S[l + 3], sizeof(T));
  inherited Hint := S;
end;

{$ENDIF}

procedure TCustomElListBox.ItemsChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElListBox.SetUseSelectedFont(Value: Boolean);
begin
  if FUseSelectedFont <> Value then
  begin
    FUseSelectedFont := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

function TCustomElListBox.IsTopIndexStored: Boolean;
begin
  Result := (TopIndex > 0);
end;

procedure TCustomElListBox.SetRightAlignedView(Value: Boolean);
begin
  if FRightAlignedView <> Value then
  begin
    FRightAlignedView := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetRightAlignedText(Value: Boolean);
begin
  if FRightAlignedText <> Value then
  begin
    FRightAlignedText := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetFocusedSelectColor(newValue: TColor);
begin
  if (FFocusedSelectColor <> newValue) then
  begin
    FFocusedSelectColor := newValue;
    if (Focused or (not FHideSelection)) then
      Invalidate;
  end;  {if}
end;

procedure TCustomElListBox.SetFocusedSelectTextColor(newValue: TColor);
begin
  if (FFocusedSelectTextColor <> newValue) then
  begin
    FFocusedSelectTextColor := newValue;
    if (Focused or (not FHideSelection)) then
      Invalidate;
  end;  {if}
end;

procedure TCustomElListBox.SetHideSelectColor(newValue: TColor);
begin
  if (FHideSelectColor <> newValue) then
  begin
    FHideSelectColor := newValue;
    if not Focused and not FHideSelection then
      Invalidate;
  end;  {if}
end;

procedure TCustomElListBox.SetHideSelectTextColor(newValue: TColor);
begin
  if (FHideSelectTextColor <> newValue) then
  begin
    FHideSelectTextColor := newValue;
    if not Focused and not FHideSelection then
      Invalidate;
  end;  {if}
end;

procedure TCustomElListBox.SetHideSelection(Value: Boolean);
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    if not Focused then
      Invalidate;
  end;
end;

procedure TCustomElListBox.DefineProperties(Filer : TFiler);
begin
  inherited;
  Filer.DefineProperty('SelectedColor', ReadSelectedColor, nil, false);
  Filer.DefineProperty('SelectedFontColor', ReadSelectedFontColor, nil, false);
end;

procedure TCustomElListBox.ReadSelectedColor(Reader : TReader);
begin
  FocusedSelectColor := StringToColor(Reader.ReadIdent);
end;

procedure TCustomElListBox.ReadSelectedFontColor(Reader : TReader);
begin
  FocusedSelectTextColor := StringToColor(Reader.ReadIdent);
end;

procedure TCustomElListBox.SetHighlightAlphaLevel(Value: Integer);
begin
  if (FHighlightAlphaLevel <> Value) and (Value >= 0) and (Value <= 255) then
  begin
    FHighlightAlphaLevel := Value;
    Invalidate;
  end;
end;

procedure TCustomElListBox.TriggerCheckStateChange(ItemNo : integer);
begin
  if assigned(FOnCheckStateChange) then
    FOnCheckStateChange(Self, ItemNo);
end;

procedure TCustomElListBox.WMKeyDown(var Message: TWMKeyDown);
begin
  inherited;
  {$IFDEF ELPACK_USE_INPUTPROCESSOR}
  if Message.CharCode <> VK_SPACE then
  begin
    Input.WMKeyDown(Message);
    DoPerformSearch(Input.Text);
  end;
  {$ENDIF}
end;


procedure TCustomElListBox.WMDeadChar(var Message: TWMDeadChar);
begin
  inherited;
  {$IFDEF ELPACK_USE_INPUTPROCESSOR}
  Input.WMDeadChar(Message);
  {$ENDIF}
end;

procedure TCustomElListBox.WMIMEComposition(var Message: TMessage);
begin
  inherited;
  {$IFDEF ELPACK_USE_INPUTPROCESSOR}
  Input.WMImeComposition(Message);
  DoPerformSearch(Input.Text);
  {$ENDIF}
end;

procedure TCustomElListBox.WMIMEStartComposition(var Message: TMessage);
{$IFDEF ELPACK_USE_INPUTPROCESSOR}
var
  IMC: HIMC;
  LogFont: TLogFont;
  CF: TCompositionForm;
{$ENDIF}
begin
  inherited;
  {$IFDEF ELPACK_USE_INPUTPROCESSOR}
  IMC := ImmGetContext(Handle);
  if IMC <> 0 then
  begin
    GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @LogFont);
    ImmSetCompositionFont(IMC, @LogFont);
    CF.dwStyle := CFS_RECT;
    CF.rcArea  := ClientRect;
    CF.ptCurrentPos := Point(0, 0);

    ImmSetCompositionWindow(IMC, @CF);
    ImmReleaseContext(Handle, IMC);
  end;
  {$ENDIF}
end;


{$IFDEF ELPACK_USE_INPUTPROCESSOR}

procedure TCustomElListBox.StartClearSearchTimeoutThread;
begin
  if Assigned (SearchTextTimeoutThread) then
    TSearchTextTimeoutThread(SearchTextTimeoutThread).KeepAlive := True
  else
  begin
    SearchTextTimeoutThread := TSearchTextTimeoutThread.Create ;
    SearchTextTimeoutThread.OnTerminate := SearchTextTimeout ;
    SearchTextTimeoutThread.Resume
  end;
  TSearchTextTimeoutThread(SearchTextTimeoutThread).IncrementalSearchTimeout := IncrementalSearchTimeout;
end;

procedure TCustomElListBox.StopClearSearchTimeoutThread;
begin
  if Assigned (SearchTextTimeoutThread) then
  begin
    SearchTextTimeoutThread.OnTerminate := nil ;
    SearchTextTimeoutThread.Terminate ;

    SearchTextTimeoutThread := nil
  end
end ;

procedure TCustomElListBox.DoPerformSearch(SearchText : TElFString);
var
  //liSearchTextLength,
  liIndex: Integer ;
  ItemText: TElFString;
  SaveItemIndex :Integer;
begin
  if (SearchText <> '') then
  begin
    SaveItemIndex := ItemIndex;
    //liSearchTextLength := Length (SearchText) ;

    for liIndex := 0 to (Items.Count - 1) do
    begin
      ItemText := Items[liIndex];
      if DoCompareItems(SearchText, liIndex) then
      begin
        ItemIndex := liIndex;
        break;
      end ;
    end;
    StartClearSearchTimeoutThread;

    if (SaveItemIndex <> ItemIndex) and Assigned(OnClick) then
      OnClick(Self);
  end;
end;

procedure TCustomElListBox.SearchTextTimeout(Sender : TObject);
begin
  SearchTextTimeoutThread := nil ;
  Input.Reset;
end;

function TCustomElListBox.DoCompareItems(SearchText : String; ItemIndex :
    integer): Boolean;
begin
  {$IFDEF ELPACK_UNICODE}
    Result := WideSameText(SearchText, WideCopy(Items[ItemIndex], 1, Length(SearchText)));
  {$ELSE}
    Result := AnsiSameText(SearchText, Copy (Items[ItemIndex], 1, Length(SearchText)));
  {$ENDIF}
end;

{$ENDIF IFDEF ELPACK_USE_INPUTPROCESSOR}

procedure TCustomElListBox.TriggerCheckBoxChange(ItemNo : integer; ItemState:
    TCheckBoxState);
begin
  if assigned(FOnCheckBoxChange) then
    FOnCheckBoxChange(Self, ItemNo, ItemState);
end;

procedure TCustomElListBox.SetUseXPThemes(const Value : boolean);
begin
  inherited;
  {$ifndef OLDELSCROLLBARS}
  // fSBCtrl.UseXPThemes := Value; <trash> // LAW
  {$endif}
end;

function TCustomElListBox.GetCount:Integer;
begin
  Result := Items.Count;
end;

procedure TCustomElListBox.UpdateItemHeight;
var tm : TTextMetric;
begin
  GetTextMetrics(Canvas.Handle, tm);
  Perform(LB_SETITEMHEIGHT, 0, tm.tmHeight);
  if not (Style in [lbOwnerDrawFixed, lbOwnerDrawVariable]) then
    FItemHeight := tm.tmHeight;
end;

procedure TCustomElListBox.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder(0, false, false);
  end;
end;

procedure TCustomElListBox.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder(0, false, false);
  end;
end;

procedure TCustomElListBox.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder(0, false, false);
  end;
end;

procedure TCustomElListBox.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder(0, false, false);
  end;
end;

procedure TCustomElListBox.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder(0, false, false);
  end;
end;


{$IFDEF ELPACK_UNICODE}
function TElListBoxStrings.Add(const S: WideString): Integer;
{$ELSE}
function TElListBoxStrings.Add(const S: String): Integer;
{$ENDIF}
begin
  ListBox.HandleNeeded;
{$IFDEF ELPACK_UNICODE}
  Result := inherited Add(S);
  SendMessage(ListBox.Handle, LB_INSERTSTRING, Result, Integer(PChar('')));
{$ELSE}
  Result := SendMessage(ListBox.Handle, LB_ADDSTRING, 0, Longint(PChar(S)));
{$ENDIF}
  if Result < 0 then
    raise EOutOfResources.Create(SInsertLineError);
end;

{.$IFDEF VCL_6_USED}
{$IFDEF ELPACK_UNICODE}
function TElListBoxStrings.AddObject(const S: WideString; AnObject : TObject): Integer;
{$ELSE}
function TElListBoxStrings.AddObject(const S: String; AnObject : TObject) : Integer;
{$ENDIF}
begin
  ListBox.HandleNeeded;
{$IFDEF ELPACK_UNICODE}
  Result := inherited AddObject(S, AnObject);
  if Result <> -1 then
    PutObject(Result, AnObject);
{$ELSE}
  Result := SendMessage(ListBox.Handle, LB_ADDSTRING, 0, Longint(PChar(S)));
  if Result <> -1 then
    PutObject(Result, AnObject);
{$ENDIF}
  if Result < 0 then
    raise EOutOfResources.Create(SInsertLineError);
end;
{.$ENDIF}

procedure TElListBoxStrings.Clear;
begin
{$IFDEF ELPACK_UNICODE}
  inherited;
{$ENDIF}
  ListBox.ResetContent;
end;

procedure TElListBoxStrings.Delete(Index: Integer);
begin
  ListBox.DeleteString(Index);
{$IFDEF ELPACK_UNICODE}
  inherited;
{$ENDIF}
end;

procedure TElListBoxStrings.Exchange(Index1, Index2: Integer);
var
{$IFNDEF ELPACK_UNICODE}
  TempData: Longint;
  TempString: string;
{$ENDIF}
  tmpCheckBoxState: Char;
  tmpImageIndex: Integer;
begin
  if Index1 = Index2 then
    exit;
  BeginUpdate;
  try
  {$IFDEF ELPACK_UNICODE}
    inherited;
  {$ELSE}
    TempString := Strings[Index1];

    TempData := ListBox.InternalGetItemData(Index1);
    Strings[Index1] := Strings[Index2];
    ListBox.InternalSetItemData(Index1, ListBox.InternalGetItemData(Index2));
    Strings[Index2] := TempString;
    ListBox.InternalSetItemData(Index2, TempData);
  {$ENDIF}
    if ListBox.State[Index1]<>ListBox.State[Index2] then
    begin
      tmpCheckBoxState := ListBox.FStates[Index1];
      ListBox.FStates[Index1] := ListBox.FStates[Index2];
      ListBox.FStates[Index2] := tmpCheckBoxState;
    end;
    if ListBox.ImageIndex[Index1]<>ListBox.ImageIndex[Index2] then
    begin
      tmpImageIndex := ListBox.FImageIndex[Index1];
      ListBox.FImageIndex[Index1] := ListBox.FImageIndex[Index2];
      ListBox.FImageIndex[Index2] := tmpImageIndex;
    end;
    if ListBox.ItemIndex = Index1 then
      ListBox.ItemIndex := Index2
    else
    if ListBox.ItemIndex = Index2 then
      ListBox.ItemIndex := Index1;
  finally
    EndUpdate;
  end;
end;

{$IFDEF ELPACK_UNICODE}
function TElListBoxStrings.Get(Index: Integer): WideString;
{$ELSE}
function TElListBoxStrings.Get(Index: Integer): string;
{$ENDIF}
{$IFNDEF ELPACK_UNICODE}
var
  Len: Integer;
  Text: array[0..4095] of Char;
{$ENDIF}
begin
{$IFDEF ELPACK_UNICODE}
  result := inherited Get(Index);
{$ELSE}
  Len := SendMessage(ListBox.Handle, LB_GETTEXT, Index, Longint(@Text));
  if Len < 0 then
    Error(SListIndexError, Index);
  SetString(Result, Text, Len);
{$ENDIF}
end;

function TElListBoxStrings.GetCount: Integer;
begin
{$IFDEF ELPACK_UNICODE}
  result := inherited GetCount;
{$ELSE}
  Result := SendMessage(ListBox.Handle, LB_GETCOUNT, 0, 0);
{$ENDIF}
end;

function TElListBoxStrings.GetObject(Index: Integer): TObject;
begin
{$IFDEF ELPACK_UNICODE}
  Result := inherited GetObject(Index);
{$ELSE}
  Result := TObject(ListBox.GetItemData(Index));
  if (Longint(Result) = LB_ERR) and ((Index < 0) or (Index >= ListBox.Count)) then
    Error(SListIndexError, Index);
{$ENDIF}
end;

{$IFDEF ELPACK_UNICODE}
function TElListBoxStrings.IndexOf(const S: WideString): Integer;
{$ELSE}
function TElListBoxStrings.IndexOf(const S: String): Integer;
{$ENDIF}
begin
{$IFDEF ELPACK_UNICODE}
  Result := inherited IndexOf(S);
{$ELSE}
  Result := SendMessage(ListBox.Handle, LB_FINDSTRINGEXACT, -1, LongInt(PChar(S)));
{$ENDIF}
end;

{$IFDEF ELPACK_UNICODE}
procedure TElListBoxStrings.Insert(Index: Integer; const S: WideString);
{$ELSE}
procedure TElListBoxStrings.Insert(Index: Integer; const S: String);
{$ENDIF}
begin
  ListBox.HandleNeeded;
{$IFDEF ELPACK_UNICODE}
  inherited Insert(Index, S);
  if SendMessage(ListBox.Handle, LB_INSERTSTRING, Index, Integer(PChar(''))) < 0 then
    raise EOutOfResources.Create(SInsertLineError);
{$ELSE}
  if SendMessage(ListBox.Handle, LB_INSERTSTRING, Index,
    Longint(PChar(S))) < 0 then
    raise EOutOfResources.Create(SInsertLineError);
{$ENDIF}
end;

procedure TElListBoxStrings.Move(CurIndex, NewIndex: Integer);
var
{$IFNDEF ELPACK_UNICODE}
  TempData: Longint;
  TempString: string;
{$ENDIF}
  tmpCheckBoxState: Char;
  tmpImageIndex: Integer;
begin
  if CurIndex <> NewIndex then
  begin
    BeginUpdate;
    try
    {$IFDEF ELPACK_UNICODE}
      inherited;
    {$ELSE}
      ListBox.FMoving := True;
      try
        TempString := Get(CurIndex);
        TempData := ListBox.InternalGetItemData(CurIndex);
        ListBox.InternalSetItemData(CurIndex, 0);
        Delete(CurIndex);
        Insert(NewIndex, TempString);
        ListBox.InternalSetItemData(NewIndex, TempData);
      finally
        ListBox.FMoving := False;
      end;
    {$ENDIF}
      if ListBox.State[CurIndex]<>ListBox.State[NewIndex] then
      begin
        tmpCheckBoxState := ListBox.FStates[CurIndex];
        ListBox.FStates[CurIndex] := ListBox.FStates[NewIndex];
        ListBox.FStates[NewIndex] := tmpCheckBoxState;
      end;
      if ListBox.ImageIndex[CurIndex]<>ListBox.ImageIndex[NewIndex] then
      begin
        tmpImageIndex := ListBox.FImageIndex[CurIndex];
        ListBox.FImageIndex[CurIndex] := ListBox.FImageIndex[NewIndex];
        ListBox.FImageIndex[NewIndex] := tmpImageIndex;
      end;
    finally
      EndUpdate;
    end;
  end;
end;

{$IFDEF ELPACK_UNICODE}
procedure TElListBoxStrings.Put(Index: Integer; const S: WideString);
{$ELSE}
procedure TElListBoxStrings.Put(Index: Integer; const S: String);
{$ENDIF}
{$IFNDEF ELPACK_UNICODE}
var
  I: Integer;
  TempData: Longint;
{$ENDIF}
begin
{$IFDEF ELPACK_UNICODE}
  inherited;
{$ELSE}
  I := ListBox.ItemIndex;
  TempData := ListBox.InternalGetItemData(Index);
  // Set the Item to 0 in case it is an object that gets freed during Delete
  ListBox.InternalSetItemData(Index, 0);
  Delete(Index);
  InsertObject(Index, S, nil);
  ListBox.InternalSetItemData(Index, TempData);
  ListBox.ItemIndex := I;
{$ENDIF}
end;

procedure TElListBoxStrings.PutObject(Index: Integer; AObject: TObject);
begin
{$IFDEF ELPACK_UNICODE}
  inherited;
{$ELSE}
  ListBox.SetItemData(Index, LongInt(AObject));
{$ENDIF}
end;

{$IFNDEF ELPACK_UNICODE}
{$IFDEF VCL_6_USED}
procedure TElListBoxStrings.InsertItem(Index: Integer; const S: string; AObject: TObject);
begin
  Insert(Index, S);
  PutObject(Index, AObject);
end;
{$ENDIF}
{$ENDIF}

procedure TElListBoxStrings.SetUpdateState(Updating: Boolean);
begin
  SendMessage(ListBox.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then
    ListBox.Refresh;
end;

procedure TElListBoxStrings.ResetBox;
var i : integer;
begin
  for i :=0 to Count -1 do
    SendMessage(ListBox.Handle, LB_INSERTSTRING, i, Integer(PChar('')));
end;

end.
