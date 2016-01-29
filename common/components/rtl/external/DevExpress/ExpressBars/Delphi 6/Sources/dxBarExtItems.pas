
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars extended items                                  }
{                                                                   }
{       Copyright (c) 1998-2001 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxBarExtItems;

{$I dxBarVer.inc}

interface

uses
  Windows, Messages, CommCtrl, Classes, Controls, Forms, Graphics, Dialogs,
  StdCtrls, ComCtrls,{$IFDEF DELPHI4} ImgList,{$ENDIF} dxBar, dxCommon;

type
  TdxBarStaticBorderStyle = (sbsNone, sbsLowered, sbsRaised, sbsEtched, sbsBump);

  TdxBarStatic = class(TdxBarItem)
  private
    FAlignment: TAlignment;
    FAllowClick: Boolean;
    FBorderStyle: TdxBarStaticBorderStyle;
    FHeight: Integer;
    FLeftIndent: Integer;
    FRightIndent: Integer;
    FShowCaption: Boolean;
    FWidth: Integer;
    procedure SetAlignment(Value: TAlignment);
    procedure SetBorderStyle(Value: TdxBarStaticBorderStyle);
    procedure SetShowCaption(Value: Boolean);
    procedure SetSizeValue(Index: Integer; Value: Integer);
  protected
    function CanClicked: Boolean; override;
    function HasAccel(AItemLink: TdxBarItemLink): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property AllowClick: Boolean read FAllowClick write FAllowClick default False;
    property BorderStyle: TdxBarStaticBorderStyle read FBorderStyle write SetBorderStyle
      default sbsNone;
    property Glyph;
    property Height: Integer index 4 read FHeight write SetSizeValue default 0;
    property ImageIndex;
    property LeftIndent: Integer index 1 read FLeftIndent write SetSizeValue default 0;
    property RightIndent: Integer index 2 read FRightIndent write SetSizeValue default 0;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption default True;
    property Width: Integer index 3 read FWidth write SetSizeValue default 0;
    property OnClick;
  end;

  TdxBarStaticControl = class(TdxBarItemControl)
  private
    function GetBorderStyle: TdxBarStaticBorderStyle;
    function GetBorderWidth: Integer;
    function GetItem: TdxBarStatic;
    function GetSizeValue(Index: Integer): Integer;
  protected
    function CanClicked: Boolean; override;
    function CanHaveZeroSize: Boolean; virtual;
    function CanMouseSelect: Boolean; override;
    function CanSelect: Boolean; override;
    procedure CaptionChanged; override;
    procedure DrawGlyphAndCaption(DC: HDC; ARect: TRect;
      PaintType: TdxBarPaintType; AllowCenter: Boolean);
    procedure DrawInterior(DC: HDC; ARect: TRect; PaintType: TdxBarPaintType); virtual;
    procedure GlyphChanged; override;
    function GetAlignment: TAlignment; virtual;
    function GetAutoWidth: Integer;
    function GetDefaultHeight: Integer; virtual;
    function GetDefaultWidth: Integer; virtual;
    function GetHeight: Integer; override;
    function GetWidth: Integer; override;
    function IsDestroyOnClick: Boolean; override;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;

    property Alignment: TAlignment read GetAlignment;
    property BorderStyle: TdxBarStaticBorderStyle read GetBorderStyle;
    property BorderWidth: Integer read GetBorderWidth;
    property Height: Integer index 4 read GetSizeValue;
    property LeftIndent: Integer index 1 read GetSizeValue;
    property RightIndent: Integer index 2 read GetSizeValue;
    property Width: Integer index 3 read GetSizeValue;
  public
    property Item: TdxBarStatic read GetItem;
  end;

  TdxBarGlyphLayout = (glLeft, glRight, glTop, glBottom);

  TdxBarLargeButton = class(TdxBarButton)
  private
    FAutoGrayScale: Boolean;
    FGlyphLayout: TdxBarGlyphLayout;
    FHeight: Integer;
    FHotImageIndex: Integer;
    FLargeGlyph, FHotGlyph: TBitmap;
    FLargeImageIndex: Integer;
    FShowCaption: Boolean;
    FWidth: Integer;

    procedure SetAutoGrayScale(Value: Boolean);
    procedure SetGlyphLayout(Value: TdxBarGlyphLayout);
    procedure SetHeight(Value: Integer);
    procedure SetHotGlyph(Value: TBitmap);
    procedure SetHotImageIndex(Value: Integer);
    procedure SetLargeGlyph(Value: TBitmap);
    procedure SetLargeImageIndex(Value: Integer);
    procedure SetShowCaption(Value: Boolean);
    procedure SetWidth(Value: Integer);

    procedure OnHotGlyphChanged(Sender: TObject);
    procedure OnLargeGlyphChanged(Sender: TObject);
  protected
    procedure GlyphLayoutChanged; virtual;
    function HasAccel(AItemLink: TdxBarItemLink): Boolean; override;
    procedure HeightChanged; virtual;
    procedure HotGlyphChanged; override;
    function IsHotImageLinked: Boolean;
    function IsLargeImageLinked: Boolean;
    procedure LargeGlyphChanged; override;
    procedure ShowCaptionChanged; virtual;
    function UseHotImages: Boolean; override;
    function UseLargeImages: Boolean; override;
    procedure WidthChanged; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AutoGrayScale: Boolean read FAutoGrayScale write SetAutoGrayScale default True;
    property GlyphLayout: TdxBarGlyphLayout read FGlyphLayout write SetGlyphLayout default glTop;
    property Height: Integer read FHeight write SetHeight default 0;
    property HotGlyph: TBitmap read FHotGlyph write SetHotGlyph;
    property HotImageIndex: Integer read FHotImageIndex write SetHotImageIndex default -1;
    property LargeGlyph: TBitmap read FLargeGlyph write SetLargeGlyph;
    property LargeImageIndex: Integer read FLargeImageIndex write SetLargeImageIndex default -1;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption default True;
    property Width: Integer read FWidth write SetWidth default 0;
  end;

  TdxBarLargeButtonControl = class(TdxBarButtonControl)
  private
    function GetHotGlyph: TBitmap;
    function GetItem: TdxBarLargeButton;
    function GetLargeGlyph: TBitmap;

    function GetCurrentImage(ASelected: Boolean; var CurrentGlyph: TBitmap;
      var CurrentImages: TCurImageList; var CurrentImageIndex: Integer): Boolean;
    function IsSizeAssigned: Boolean;
  protected
    function ArrowWidth: Integer; override;
    procedure GlyphLayoutChanged; virtual;
    procedure HeightChanged; virtual;
    procedure HotGlyphChanged; virtual;
    procedure LargeGlyphChanged; virtual;
    procedure ShowCaptionChanged; virtual;
    procedure WidthChanged; virtual;
    function GetDefaultHeight: Integer; override;
    function GetDefaultWidth: Integer; override;
    function GetHeight: Integer; override;
    function GetWidth: Integer; override;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;

    property HotGlyph: TBitmap read GetHotGlyph;
    property LargeGlyph: TBitmap read GetLargeGlyph;
  public
    property Item: TdxBarLargeButton read GetItem;
  end;

  TdxBarColorCombo = class(TdxBarCustomCombo)
  private
    FAutoColor: TColor;
    FAutoColorText: string;
    FColor: TColor;
    FCustomColorText: string;
    FExchangeColor: TColor;
    FHasExchangeColor: Boolean;
    FSettingColor: Boolean;
    FShowAutoColor: Boolean;
    FShowCustomColorButton: Boolean;

    function GetCurColor: TColor;
    procedure SetAutoColor(Value: TColor);
    procedure SetAutoColorText(Value: string);
    procedure SetColor(Value: TColor);
    procedure SetCurColor(Value: TColor);
    procedure SetCustomColorText(Value: string);
    procedure SetShowAutoColor(Value: Boolean);
    procedure SetShowCustomColorButton(Value: Boolean);

    procedure CreateItemsList;
    function GetColorByIndex(AIndex: Integer): TColor;
    function GetIndexOfColor(AColor: TColor): Integer;
    function IsAutoColorTextStored: Boolean;
    function IsCustomColorTextStored: Boolean;
    function IsDropDownCountStored: Boolean;
  protected
    procedure Change; override;
    procedure DrawItem(AIndex: Integer; ARect: TRect; AState: TOwnerDrawState); override;
    procedure MeasureItem(AIndex: Integer; var AHeight: Integer); override;
    procedure MeasureItemWidth(AIndex: Integer; var AWidth: Integer); override;
    property ExchangeColor: TColor read FExchangeColor;
    property HasExchangeColor: Boolean read FHasExchangeColor;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoClick; override;
    property CurColor: TColor read GetCurColor write SetCurColor;
  published
    property AutoColor: TColor read FAutoColor write SetAutoColor default clWindowText;
    property AutoColorText: string read FAutoColorText write SetAutoColorText
      stored IsAutoColorTextStored;
    property Color: TColor read FColor write SetColor;
    property CustomColorText: string read FCustomColorText write SetCustomColorText
      stored IsCustomColorTextStored;
    property DropDownCount stored IsDropDownCountStored;
    property ShowAutoColor: Boolean read FShowAutoColor write SetShowAutoColor default False;
    property ShowCustomColorButton: Boolean read FShowCustomColorButton
      write SetShowCustomColorButton default False;
    property ShowEditor default False;
    property Text stored False;
  end;

  TdxBarColorComboControl = class(TdxBarComboControl)
  private
    FCustomColorButtonRect: TRect;
    function GetItem: TdxBarColorCombo;
  protected
    function DrawSelected: Boolean; override;
    procedure PressedChanged; override;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;
    procedure WndProc(var Message: TMessage); override;
    property CustomColorButtonRect: TRect read FCustomColorButtonRect;
  public
    property Item: TdxBarColorCombo read GetItem;
  end;

  TdxBarFontNameCombo = class(TdxBarCustomCombo)
  protected
    procedure DrawItem(AIndex: Integer; ARect: TRect; AState: TOwnerDrawState); override;
    procedure LoadFontNames;
    procedure MeasureItemWidth(AIndex: Integer; var AWidth: Integer); override;
    procedure SetText(Value: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoClick; override;
  published
    property ShowEditor default False;
  end;

  TDayOfWeek = 0..6;
  TDay = (dSunday, dMonday, dTuesday, dWednesday, dThursday, dFriday, dSaturday);
  TDays = set of TDay;
  TdxBarCalendarStyle = (cs3D, csFlat, csUltraFlat);

  TdxBarCustomCalendar = class(TCustomControl)
  private
    FDragDate: TDateTime;
    FFirstDate: TDateTime;
    FSelStart: TDateTime;
    FSelFinish: TDateTime;
    FStyle: TdxBarCalendarStyle;

    FOnDateTimeChanged: TNotifyEvent;

    function GetFlat: Boolean;
    function GetUltraFlat: Boolean;
    procedure SetStyle(Value: TdxBarCalendarStyle);

    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    function GetStyle: TdxBarCalendarStyle; virtual;
    function GetRealFirstDate: TDateTime; virtual;
    function GetRealLastDate: TDateTime; virtual;
    function GetLastDate: TDateTime; virtual; abstract;
    function GetSelStart: TDateTime; virtual;
    function GetSelFinish: TDateTime; virtual;
    procedure SetFirstDate(Value: TDateTime); virtual;
    procedure SetSelStart(Value: TDateTime); virtual;
    procedure SetSelFinish(Value: TDateTime); virtual;

    procedure CancelAll; dynamic;
    procedure CheckFirstDate; virtual; abstract;
    procedure DoDateTimeChanged; dynamic;
    procedure DoInternalSelectPeriod(ADate: TDateTime);
    function PosToDateTime(P: TPoint): TDateTime; virtual; abstract;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

    property Flat: Boolean read GetFlat;
    property UltraFlat: Boolean read GetUltraFlat;
    
    property RealFirstDate: TDateTime read GetRealFirstDate;
    property RealLastDate: TDateTime read GetRealLastDate;
  public
    constructor Create(AOwner: TComponent); override;

    property FirstDate: TDateTime read FFirstDate write SetFirstDate;
    property LastDate: TDateTime read GetLastDate;
    property SelStart: TDateTime read GetSelStart write SetSelStart;
    property SelFinish: TDateTime read GetSelFinish write SetSelFinish;
    property Style: TdxBarCalendarStyle read GetStyle write SetStyle;
    property OnDateTimeChanged: TNotifyEvent read FOnDateTimeChanged
      write FOnDateTimeChanged;
  end;

  TdxBarDateCombo = class;

  TdxBarDateNavigator = class(TdxBarCustomCalendar)
  private
    FCombo: TdxBarDateCombo;

    FColCount: Integer;
    FRowCount: Integer;
    FColWidth, FSideWidth,
      FRowHeight, FHeaderHeight, FDaysOfWeekHeight: Integer;
    FTodayButtonWidth, FClearButtonWidth, FButtonsOffset, FButtonsHeight,
      FButtonsRegionHeight: Integer;
    FListBox: TWinControl;
    FListBoxDelta: Integer;
    FTimer: UINT;
    FTodayButtonActive, FTodayButtonPressed: Boolean;
    FClearButtonActive, FClearButtonPressed: Boolean;

    procedure CheckSelection(MarginDate: TDateTime);
    function ColOfDate(ADate: TDateTime): Integer;
    function GetHeaderRect: TRect;
    function GetInternalRect: TRect;
    function GetLeftArrowRect: TRect;
    function GetRightArrowRect: TRect;
    function GetMonthNameRect: TRect;
    function GetTodayButtonRect: TRect;
    function GetClearButtonRect: TRect;
    function GetShowButtonsArea: Boolean;
    procedure FreeTimer;
    procedure RepaintTodayButton;
    procedure RepaintClearButton;

    procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    function GetStyle: TdxBarCalendarStyle; override;
    function GetRealFirstDate: TDateTime; override;
    function GetRealLastDate: TDateTime; override;
    function GetLastDate: TDateTime; override;
    procedure SetFirstDate(Value: TDateTime); override;
    procedure SetSelFinish(Value: TDateTime); override;
    procedure StepToPast;
    procedure StepToFuture;
    procedure CancelAll; override;
    procedure CheckFirstDate; override;
    procedure DeactivateAll;
    function PosToDateTime(P: TPoint): TDateTime; override;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DblClick; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;

    property ColCount: Integer read FColCount;
    property RowCount: Integer read FRowCount;
    property ShowButtonsArea: Boolean read GetShowButtonsArea;
  public
    IsPopup: Boolean;
    ShowTodayButton, ShowClearButton: Boolean;
    constructor Create(AOwner: TComponent); override;
    procedure SetSize;
    function GetWidth: Integer;
    function GetHeight: Integer;
  end;

  TdxBarDateCombo = class(TCustomdxBarCombo)
  private
    FDatePopup, FDateNavigator: TdxBarDateNavigator;
    FDateEdit: TEdit;
    FForm: TForm;
    FShowTodayButton: Boolean;
    FShowClearButton: Boolean;
    function GetCurDate: TDateTime;
    function GetDate: TDateTime;
    procedure SetCurDate(Value: TDateTime);
    procedure SetDate(Value: TDateTime);
    procedure DateChanged(Sender: TObject);
    procedure DialogClick(Sender: TObject);
    procedure DialogDateChanged(Sender: TObject);
    procedure DialogDateEditChange(Sender: TObject);
    function GetDateOfText(AText: string): TDateTime;
    function GetDateText(ADate: TDateTime): string;
  protected
    function CheckKeyForDropDownWindow(Key: Word; Shift: TShiftState): Boolean; override;
    procedure CloseUp; override;
    procedure DropDown(X, Y: Integer); override;
    function GetDropDownWindow: HWND; override;
    procedure SetText(Value: string); override;

    property DatePopup: TdxBarDateNavigator read FDatePopup;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoClick; override;

    property CurDate: TDateTime read GetCurDate write SetCurDate;
    property Date: TDateTime read GetDate write SetDate;
  published
    property ShowTodayButton: Boolean read FShowTodayButton write FShowTodayButton default True;
    property ShowClearButton: Boolean read FShowClearButton write FShowClearButton default True;
  end;

  TdxBarDateComboControl = class(TCustomdxBarComboControl)
  private
    function GetDate: TDateTime;
    function GetItem: TdxBarDateCombo;
    procedure SetDate(const Value: TDateTime);
  protected
    procedure WndProc(var Message: TMessage); override;
    property Date: TDateTime read GetDate write SetDate;
  public
    property Item: TdxBarDateCombo read GetItem;
  end;

  TdxBarTreeViewCombo = class;

{$IFNDEF DELPHI6}

  TdxBarTreeNode = class(TTreeNode)
  public
    destructor Destroy; override;
  end;

{$ENDIF}  

  TdxBarTreeView = class(TCustomTreeView)
  private
    FCloseButtonRect, FGripRect: TRect;
    FCloseButtonIsTracking: Boolean;
    FCombo: TdxBarTreeViewCombo;
    FCorner: TdxCorner;
    FMouseAboveCloseButton: Boolean;
    function FindNode(const AText: string): TTreeNode;
    procedure SaveAndHide;
    procedure TVMSetImageList(var Message: TMessage); message TVM_SETIMAGELIST;
    procedure TVMSetItem(var Message: TMessage); message TVM_SETITEM;
    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSysColorChange(var Message: TWMSysColorChange); message WM_SYSCOLORCHANGE;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
  protected
    procedure Change(Node: TTreeNode); override;
  {$IFNDEF DELPHI6}
    function CreateNode: TTreeNode; override;
  {$ENDIF}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DblClick; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    IsPopup: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Items;
    property OnDeletion;
  end;

  TdxBarTreeViewComboCanSelectNodeEvent = procedure(Sender: TdxBarTreeViewCombo;
    Node: TTreeNode; var CanSelect: Boolean) of object;

  TdxBarTreeViewCombo = class(TCustomdxBarCombo)
  private
    FAllowResizing: Boolean;
    FButtonOk, FButtonCancel: TButton;
    FChooseByDblClick: Boolean;
    FForm: TForm;
    FFormTreeView, FTreeView: TdxBarTreeView;
    FFullExpand: Boolean;
    FInSelectedNodeChanged: Boolean;
    FLoadedText: string;
    FSelectedNode: TTreeNode;
    FShowImageInEdit: Boolean;
    FOnCanSelectNode: TdxBarTreeViewComboCanSelectNodeEvent;

    function GetDropDownHeight: Integer;
    function GetDropDownWidth: Integer;
    function GetImages: TCurImageList;
    function GetIndent: Integer;
    function GetItems: TTreeNodes;
    function GetShowButtons: Boolean;
    function GetShowLines: Boolean;
    function GetShowRoot: Boolean;
    function GetSortType: TSortType;
    function GetStateImages: TCurImageList;
    function GetOnExpanded: TTVExpandedEvent;
    function GetOnExpanding: TTVExpandingEvent;
    function GetOnChanging: TTVChangingEvent;
    function GetOnCollapsed: TTVExpandedEvent;
    function GetOnCollapsing: TTVCollapsingEvent;
    function GetOnCompare: TTVCompareEvent;
    function GetOnGetImageIndex: TTVExpandedEvent;
    function GetOnGetSelectedIndex: TTVExpandedEvent;
    function GetOnTreeViewChange: TTVChangedEvent;

    procedure SetDropDownHeight(Value: Integer);
    procedure SetDropDownWidth(Value: Integer);
    procedure SetImages(Value: TCurImageList);
    procedure SetIndent(Value: Integer);
    procedure SetItems(Value: TTreeNodes);
    procedure SetSelectedNode(Value: TTreeNode);
    procedure SetShowButtons(Value: Boolean);
    procedure SetShowImageInEdit(Value: Boolean);
    procedure SetShowLines(Value: Boolean);
    procedure SetShowRoot(Value: Boolean);
    procedure SetSortType(Value: TSortType);
    procedure SetStateImages(Value: TCurImageList);
    procedure SetOnExpanded(Value: TTVExpandedEvent);
    procedure SetOnExpanding(Value: TTVExpandingEvent);
    procedure SetOnChanging(Value: TTVChangingEvent);
    procedure SetOnCollapsed(Value: TTVExpandedEvent);
    procedure SetOnCollapsing(Value: TTVCollapsingEvent);
    procedure SetOnCompare(Value: TTVCompareEvent);
    procedure SetOnGetImageIndex(Value: TTVExpandedEvent);
    procedure SetOnGetSelectedIndex(Value: TTVExpandedEvent);
    procedure SetOnTreeViewChange(Value: TTVChangedEvent);

    procedure FormSize(Sender: TObject);
  protected
    function CheckKeyForDropDownWindow(Key: Word; Shift: TShiftState): Boolean; override;
    function DoCanSelectNode: Boolean;
    procedure DoSelectedNodeChanged; virtual;
    procedure DrawInterior(ACanvas: TCanvas; R: TRect; ItemLink: TdxBarItemLink); override;
    procedure DropDown(X, Y: Integer); override;
    function GetDropDownWindow: HWND; override;
    function HasImageInEdit: Boolean;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetText(Value: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoClick; override;

    property SelectedNode: TTreeNode read FSelectedNode write SetSelectedNode;
    property TreeView: TdxBarTreeView read FTreeView;
  published
    property AllowResizing: Boolean read FAllowResizing write FAllowResizing default True;
    property ChooseByDblClick: Boolean read FChooseByDblClick write FChooseByDblClick default True;
    property DropDownHeight: Integer read GetDropDownHeight write SetDropDownHeight default 200;
    property DropDownWidth: Integer read GetDropDownWidth write SetDropDownWidth default 150;
    property FullExpand: Boolean read FFullExpand write FFullExpand default False;
    property Images: TCurImageList
      read GetImages write SetImages;
    property Indent: Integer read GetIndent write SetIndent;
    property Items: TTreeNodes read GetItems write SetItems;
    property ShowButtons: Boolean read GetShowButtons write SetShowButtons;
    property ShowEditor default False;
    property ShowImageInEdit: Boolean read FShowImageInEdit write SetShowImageInEdit
      default True;
    property ShowLines: Boolean read GetShowLines write SetShowLines;
    property ShowRoot: Boolean read GetShowRoot write SetShowRoot;
    property SortType: TSortType read GetSortType write SetSortType;
    property StateImages: TCurImageList
      read GetStateImages write SetStateImages;

    property OnExpanded: TTVExpandedEvent read GetOnExpanded write SetOnExpanded;
    property OnExpanding: TTVExpandingEvent read GetOnExpanding write SetOnExpanding;
    property OnCanSelectNode: TdxBarTreeViewComboCanSelectNodeEvent read FOnCanSelectNode
      write FOnCanSelectNode;
    property OnChanging: TTVChangingEvent read GetOnChanging write SetOnChanging;
    property OnCollapsed: TTVExpandedEvent read GetOnCollapsed write SetOnCollapsed;
    property OnCollapsing: TTVCollapsingEvent read GetOnCollapsing write SetOnCollapsing;
    property OnCompare: TTVCompareEvent read GetOnCompare write SetOnCompare;
    property OnGetImageIndex: TTVExpandedEvent read GetOnGetImageIndex write SetOnGetImageIndex;
    property OnGetSelectedIndex: TTVExpandedEvent read GetOnGetSelectedIndex write SetOnGetSelectedIndex;
    property OnTreeViewChange: TTVChangedEvent read GetOnTreeViewChange write SetOnTreeViewChange;
  end;

  TdxBarTreeViewComboControl = class(TCustomdxBarComboControl)
  private
    function GetItem: TdxBarTreeViewCombo;
  protected
    function GetHeight: Integer; override;
    procedure SetFocused(Value: Boolean); override;
  public
    property Item: TdxBarTreeViewCombo read GetItem;
  end;

  TdxBarImageCombo = class(TdxBarCustomCombo)
  private
    FDialogListBox: TListBox;
    FForm: TForm;
    FImageChangeLink: TChangeLink;
    FImages: TCurImageList;
    FShowText: Boolean;

    function GetImageIndexes(Index: Integer): Integer;
    procedure SetImageIndexes(Index: Integer; Value: Integer);
    procedure SetImages(Value: TCurImageList);
    procedure SetShowText(Value: Boolean);
    procedure ImageListChange(Sender: TObject);
    procedure ReadImageIndexes(Reader: TReader);
    procedure WriteImageIndexes(Writer: TWriter);

    procedure DialogListBoxDblClick(Sender: TObject);
    procedure DialogListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure DialogListBoxMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure DrawItem(AIndex: Integer; ARect: TRect; AState: TOwnerDrawState); override;
    procedure ImagesChanged; virtual;
    procedure MeasureItem(AIndex: Integer; var AHeight: Integer); override;
    procedure MeasureItemWidth(AIndex: Integer; var AWidth: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoClick; override;
    property ImageIndexes[Index: Integer]: Integer read GetImageIndexes write SetImageIndexes;
  published
    property Images: TCurImageList
      read FImages write SetImages;
    property Items;
    property ShowEditor default False;
    property Sorted;
    property ItemIndex;  // loading after all
    property ShowText: Boolean read FShowText write SetShowText default True;
  end;

  TdxBarImageComboControl = class(TdxBarComboControl)
  protected
    function GetHeight: Integer; override;
    procedure ImagesChanged; virtual;
  end;

  TdxBarToolbarsListItem = class(TCustomdxBarSubItem)
  protected
    function HasDesignTimeLinks: Boolean; override;
  end;

  TdxBarToolbarsListItemControl = class(TdxBarSubItemControl)
  protected
    procedure CreateSubMenuControl; override;
  end;

  TdxBarSpinEdit = class;
  TdxBarSpinEditButton = (sbNone, sbUp, sbDown);
  TdxBarSpinEditValueType = (svtInteger, svtFloat);
  TdxBarSpinEditPrefixPlace = (ppStart, ppEnd);
  TdxBarSpinEditButtonClickEvent = procedure(Sender: TdxBarSpinEdit;
    Button: TdxBarSpinEditButton) of object;

  TdxBarSpinEdit = class(TdxBarEdit)
  private
    FIncrement: Extended;
    FMaxValue: Extended;
    FMinValue: Extended;
    FPrefix: string;
    FPrefixPlace: TdxBarSpinEditPrefixPlace;
    FValueType: TdxBarSpinEditValueType;
    FOnButtonClick: TdxBarSpinEditButtonClickEvent;

    function GetCurValue: Extended;
    function GetIntCurValue: Integer;
    function GetIntValue: Integer;
    function GetValue: Extended;
    procedure SetCurValue(Value: Extended);
    procedure SetIncrement(Value: Extended);
    procedure SetIntCurValue(Value: Integer);
    procedure SetIntValue(Value: Integer);
    procedure SetMaxValue(Value: Extended);
    procedure SetMinValue(Value: Extended);
    procedure SetPrefix(const Value: string);
    procedure SetPrefixPlace(Value: TdxBarSpinEditPrefixPlace);
    procedure SetValue(Value: Extended);
    procedure SetValueType(Value: TdxBarSpinEditValueType);

    function IsIncrementStored: Boolean;
    function IsMaxValueStored: Boolean;
    function IsMinValueStored: Boolean;
    function IsValueStored: Boolean;

    procedure AddPrefix(var Text: string);
    procedure RemovePrefix(var Text: string);
  protected
    function CheckRange: Boolean;
    procedure DoButtonClick(Button: TdxBarSpinEditButton);
    function GetCheckedValue(Value: Extended): Extended;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure PrepareValue(var Value: Extended);
    function TextToValue(Text: string): Extended;
    procedure SetText(Value: string); override;
    function ValueToText(Value: Extended): string;
  public
    constructor Create(AOwner: TComponent); override;
    property CurValue: Extended read GetCurValue write SetCurValue;
    property IntCurValue: Integer read GetIntCurValue write SetIntCurValue;
    property IntValue: Integer read GetIntValue write SetIntValue;
  published
    property ValueType: TdxBarSpinEditValueType read FValueType write SetValueType
      default svtInteger;  // must be loaded before all
    property Increment: Extended read FIncrement write SetIncrement
      stored IsIncrementStored;
    property MaxValue: Extended read FMaxValue write SetMaxValue stored IsMaxValueStored;
    property MinValue: Extended read FMinValue write SetMinValue stored IsMinValueStored;
    property Prefix: string read FPrefix write SetPrefix;
    property PrefixPlace: TdxBarSpinEditPrefixPlace read FPrefixPlace write SetPrefixPlace
      default ppEnd;
    property Text stored False;
    property Value: Extended read GetValue write SetValue stored IsValueStored;
    property OnButtonClick: TdxBarSpinEditButtonClickEvent read FOnButtonClick
      write FOnButtonClick;
  end;

  TdxBarSpinEditControl = class(TdxBarEditControl)
  private
    FActiveButton: TdxBarSpinEditButton;
    FButtonPressed: Boolean;
    FButtonsRect: TRect;
    FTimerID: UINT;
    function GetItem: TdxBarSpinEdit;
    procedure SetActiveButton(Value: TdxBarSpinEditButton);
    procedure SetButtonPressed(Value: Boolean);
  protected
    procedure BreakProcess;
    function ButtonFromPoint(P: TPoint): TdxBarSpinEditButton;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;
    procedure WndProc(var Message: TMessage); override;
    property ActiveButton: TdxBarSpinEditButton read FActiveButton write SetActiveButton;
    property ButtonPressed: Boolean read FButtonPressed write SetButtonPressed;
    property ButtonsRect: TRect read FButtonsRect;
  public
    property Item: TdxBarSpinEdit read GetItem;
  end;

  TdxBarControlContainerItem = class(TdxBarItem)
  private
    FControl: TControl;
    FPlace: TCustomForm;
    FPrevControlSize: TPoint;
    FPrevControlWndProc: TWndMethod;
    function GetInPlaceControl: Boolean;
    procedure SetControl(Value: TControl);
    procedure ControlWndProc(var Message: TMessage);
    function IsControlAssigned(AControl: TControl): Boolean;
    procedure SaveControlSize;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const NewName: TComponentName); override;

    function CanClicked: Boolean; override;
    function GetHidden: Boolean; override;
    function HasAccel(AItemLink: TdxBarItemLink): Boolean; override;
    procedure HideControl(AControl: TdxBarItemControl); override;
    function NeedToBeHidden: Boolean; override;

    property InPlaceControl: Boolean read GetInPlaceControl;
    property Place: TCustomForm read FPlace;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Control: TControl read FControl write SetControl;
  end;

  TdxBarControlContainerControl = class(TdxBarItemControl)
  private
    FInPlaceControl: Boolean;
    function GetControl: TControl;
    function GetItem: TdxBarControlContainerItem;
    function GetPlace: TCustomForm;
  protected
    procedure BeforeDestroyParentHandle; override;
    function CanClicked: Boolean; override;
    function CanSelect: Boolean; override;
    function GetHeight: Integer; override;
    function GetWidth: Integer; override;
    function IsDestroyOnClick: Boolean; override;
    function IsShowingControl: Boolean;
    function NeedCaptureMouse: Boolean; override;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;
    procedure PlaceControl;
    function ShowsControl: Boolean;

    property Control: TControl read GetControl;
    property InPlaceControl: Boolean read FInPlaceControl;
    property Place: TCustomForm read GetPlace;
  public
    destructor Destroy; override;
    property Item: TdxBarControlContainerItem read GetItem;
  end;

  TdxBarProgressItem = class(TdxBarStatic)
  private
    FMax: Integer;
    FMin: Integer;
    FPosition: Integer;
    FSmooth: Boolean;
    FStep: Integer;
    procedure SetMax(Value: Integer);
    procedure SetMin(Value: Integer);
    procedure SetPosition(Value: Integer);
    procedure SetSmooth(Value: Boolean);
    procedure SetStep(Value: Integer);
  protected
    procedure UpdateBar;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetParams(AMin, AMax: Integer);
    procedure StepBy(Delta: Integer);
    procedure StepIt;
  published
    property BorderStyle default sbsLowered;
    property Max: Integer read FMax write SetMax default 100;
    property Min: Integer read FMin write SetMin default 0;
    property Position: Integer read FPosition write SetPosition default 0;
    property Smooth: Boolean read FSmooth write SetSmooth default False;
    property Step: Integer read FStep write SetStep default 10;
  end;

  TdxBarProgressControl = class(TdxBarStaticControl)
  private
    function GetItem: TdxBarProgressItem;
  protected
    function BarBrush: HBRUSH; virtual;
    function BarHeight: Integer;
    function BarRect: TRect;
    function BarWidth: Integer;
    function CanHaveZeroSize: Boolean; override;
    procedure DrawInterior(DC: HDC; ARect: TRect; PaintType: TdxBarPaintType); override;
    function GetAlignment: TAlignment; override;
    function GetDefaultWidth: Integer; override;
    procedure UpdateBar;
  public
    property Item: TdxBarProgressItem read GetItem;
  end;

  TdxBarMRUListItem = class(TdxBarListItem)
  private
    FMaxItemCount: Integer;
    FRemoveItemOnClick: Boolean;
    procedure SetMaxItemCount(Value: Integer);
  protected
    procedure CheckItemCount;
    function GetDisplayText(const AText: string): string; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DirectClick; override;
    procedure AddItem(const S: string; AObject: TObject);
    procedure RemoveItem(const S: string; AObject: TObject);
  published
    property MaxItemCount: Integer read FMaxItemCount write SetMaxItemCount default 5;
    property RemoveItemOnClick: Boolean read FRemoveItemOnClick
      write FRemoveItemOnClick default False;
  end;

  TdxBarInPlaceSubItem = class;

  TdxBarInPlaceSubItemEvent =
    procedure(Sender: TdxBarInPlaceSubItem; Link: TdxBarItemLink) of object;

  TdxBarInPlaceSubItem = class(TdxBarContainerItem)
  private
    FExpanded: Boolean;
    FExpandedChanging: Boolean;
    FKeepBeginGroupWhileExpanded: Boolean;
    FOnAfterExpand: TdxBarInPlaceSubItemEvent;
    FOnBeforeCollapse: TdxBarInPlaceSubItemEvent;
    procedure SetExpanded(Value: Boolean);
  protected
    procedure AddListedItemLinks(AItemLinks: TdxBarItemLinks; AIndex: Integer;
      FirstCall: Boolean; CallingItemLink: TdxBarItemLink); override;
    procedure DeleteListedItemLinks(AItemLinks: TdxBarItemLinks; AIndex: Integer); override;
    function HideWhenRun: Boolean; override;

    procedure ChangeNextItemLinkBeginGroup(ALink: TdxBarItemLink; Value: Boolean);
    procedure DoAfterExpand(ALink: TdxBarItemLink); dynamic;
    procedure DoBeforeCollapse(ALink: TdxBarItemLink); dynamic;
  published
    property Expanded: Boolean read FExpanded write SetExpanded default False;
    property KeepBeginGroupWhileExpanded: Boolean read FKeepBeginGroupWhileExpanded
      write FKeepBeginGroupWhileExpanded;
    property OnAfterExpand: TdxBarInPlaceSubItemEvent read FOnAfterExpand
      write FOnAfterExpand;
    property OnBeforeCollapse: TdxBarInPlaceSubItemEvent read FOnBeforeCollapse
      write FOnBeforeCollapse;
  end;

  TdxBarInPlaceSubItemControl = class(TdxBarContainerItemControl)
  private
    function GetItem: TdxBarInPlaceSubItem;
  protected
    procedure ControlClick(ByMouse: Boolean); override;
    procedure DblClick; override;
    function GetDefaultHeight: Integer; override;
    function GetDefaultWidth: Integer; override;
    function HasSubMenu: Boolean; override;
    function IsExpandable: Boolean; override;
    procedure KeyDown(Key: Word); override;
    procedure Paint(ARect: TRect; PaintType: TdxBarPaintType); override;
    function WantsKey(Key: Word): Boolean; override;
  public
    property Item: TdxBarInPlaceSubItem read GetItem;
  end;

var
  // first day of week
  StartOfWeek: Word;  //TDayOfWeek;
  sdxBarDatePopupToday: string;
  sdxBarDatePopupClear: string;

const
  NullDate = -700000;

function DateOf(ADateTime: TDateTime): Integer;

function dxBarColorDialog: TColorDialog;
function dxBarFontDialog: TFontDialog;

implementation

{$R dxBarExtItems.res}
{$R dxBarExtItemsStrs.res}

uses
  SysUtils, ActiveX, Printers, dxBarCommon;

const
  DXBAR_DIALOGOK = 39453;
  DXBAR_DIALOGCANCEL = 39454;

  Colors: array[0..15] of TColor =
    (clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal, clGray,
     clSilver, clRed, clLime, clYellow, clBlue, clFuchsia, clAqua, clWhite);
  DXBAR_COLOR_STR_BASE = 39400;
  DXBAR_COLORAUTOTEXT = 39416;
  DXBAR_COLORCUSTOMTEXT = 39417;

  ADateNavigatorTime = 170;

  DXBAR_DATETODAY = 39450;
  DXBAR_DATECLEAR = 39451;
  DXBAR_DATEDIALOGCAPTION = 39452;

  DXBAR_TREEVIEWDIALOGCAPTION = 39455;

  DXBAR_IMAGEDIALOGCAPTION = 39458;
  DXBAR_IMAGEINDEX = 39456;
  DXBAR_IMAGETEXT = 39457;

  DXBAR_PLACEFORCONTROL = 39459;

  ProgressBarDefaultWidth = 150;
  ProgressBarIndent = 2;

type
  TDummyWinControl = class(TWinControl);
  TDummyForm = class(TCustomForm);
  TDummyBarManager = class(TdxBarManager);
  TDummyCustomBarControl = class(TCustomdxBarControl);

var
  FColorDialog: TColorDialog;
  FFontDialog: TFontDialog;
  FTrueTypeFontBitmap, FNonTrueTypeFontBitmap: TBitmap;

resourcestring
  DXBAR_CANTASSIGNCONTROL = 'You cannot assign the same control to more than one TdxBarControlContainerItem.';

function GetCuttedString(const S: string): string;
var
  C: PChar;
  R: TRect;
  DC: HDC;
begin
  GetMem(C, 2 * (MAX_PATH + 1));
  StrPCopy(C, S);
  R := Rect(0, 0, 300, 100);
  DC := GetDC(0);
  DrawText(DC, C, Length(S), R,
    DT_CALCRECT or DT_MODIFYSTRING or
    DT_NOPREFIX or DT_SINGLELINE or DT_PATH_ELLIPSIS);
  ReleaseDC(0, DC);
  Result := C;
  FreeMem(C);
end;

{ TdxBarStatic }

constructor TdxBarStatic.Create(AOwner: TComponent);
begin
  inherited;
  FAlignment := taCenter; 
  FShowCaption := True;
end;

procedure TdxBarStatic.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    if not IsLoading then Update;
  end;
end;

procedure TdxBarStatic.SetBorderStyle(Value: TdxBarStaticBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    if not IsLoading then
      if (Width = 0) or (Height = 0) then
        UpdateEx
      else
        Update;
  end;
end;

procedure TdxBarStatic.SetShowCaption(Value: Boolean);
begin
  if FShowCaption <> Value then
  begin
    FShowCaption := Value;
    if not IsLoading then UpdateEx;
  end;
end;

procedure TdxBarStatic.SetSizeValue(Index: Integer; Value: Integer);
var
  PrevValue: Integer;
begin
  if Value < 0 then Value := 0;
  case Index of
    1: PrevValue := FLeftIndent;
    2: PrevValue := FRightIndent;
    3: PrevValue := FWidth;
    4: PrevValue := FHeight;
  else
    PrevValue := 0;
  end;
  if PrevValue <> Value then
  begin
    case Index of
      1: FLeftIndent := Value;
      2: FRightIndent := Value;
      3: FWidth := Value;
      4: FHeight := Value;
    end;
    if not IsLoading then UpdateEx;
  end;
end;

function TdxBarStatic.CanClicked: Boolean;
begin
  Result := FAllowClick;
end;

function TdxBarStatic.HasAccel(AItemLink: TdxBarItemLink): Boolean;
begin
  Result := False;
end;

{ TdxBarStaticControl }

function TdxBarStaticControl.GetBorderStyle: TdxBarStaticBorderStyle;
begin
  Result := Item.BorderStyle;
end;

function TdxBarStaticControl.GetBorderWidth: Integer;
const
  Widths: array[TdxBarStaticBorderStyle] of Integer = (0, 1, 1, 2, 2);
begin
  Result := Widths[BorderStyle];
end;

function TdxBarStaticControl.GetItem: TdxBarStatic;
begin
  Result := TdxBarStatic(ItemLink.Item);
end;

function TdxBarStaticControl.GetSizeValue(Index: Integer): Integer;
begin
  case Index of
    1: Result := Item.LeftIndent;
    2: Result := Item.RightIndent;
    3: Result := Item.Width;
    4: Result := Item.Height;
  else
    Result := 0;
  end;
end;

function TdxBarStaticControl.CanHaveZeroSize: Boolean;
begin
  Result := False;
end;

function TdxBarStaticControl.CanClicked: Boolean;
begin
  Result := Item.AllowClick;
end;

function TdxBarStaticControl.CanMouseSelect: Boolean;
begin
  Result := inherited CanSelect;
end;

function TdxBarStaticControl.CanSelect: Boolean;
begin
  Result := inherited CanSelect and BarManager.IsCustomizing;
end;

procedure TdxBarStaticControl.CaptionChanged;
begin
  if Width = 0 then
    inherited
  else
    Repaint;
end;

procedure TdxBarStaticControl.DrawGlyphAndCaption(DC: HDC; ARect: TRect;
  PaintType: TdxBarPaintType; AllowCenter: Boolean);
const
  Alignments: array[TAlignment] of Integer = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  TextIndent: Integer;
  R: TRect;
  Center: Boolean;
begin
  if ImageExists then
  begin
    TextIndent := 2;
    R := ARect;
    with ARect do
      if PaintType = ptMenu then
      begin
        Center := AllowCenter and not Item.ShowCaption;
        if not Center then
        begin
          Inc(Left, Bottom - Top);
          R.Right := Left;
          FillRect(DC, ARect, Parent.BkBrush);
        end;
      end
      else
      begin
        Center := AllowCenter;
        if Item.ShowCaption then
        begin
          if PaintType = ptHorz then
          begin
            Inc(Left, TDummyBarManager(BarManager).ButtonWidth);
            R.Right := Left;
          end
          else
          begin
            Inc(Top, TDummyBarManager(BarManager).ButtonHeight);
            R.Bottom := Top;
          end;
          FillRect(DC, ARect, Parent.BkBrush);
        end;
      end;
    DrawGlyph(R, nil, PaintType, False, False, False, False, Center, True, False);
  end
  else
  begin
    TextIndent := Parent.TextSize div 4;
    FillRect(DC, ARect, Parent.BkBrush);
  end;

  if Item.ShowCaption then
  begin
    Center := AllowCenter and (Alignment = taCenter);
    if not Center then
    begin
      if PaintType in [ptMenu, ptHorz] then
        if Alignment = taLeftJustify then
          Inc(ARect.Left, TextIndent)
        else
          Dec(ARect.Right, TextIndent)
      else
        if Alignment = taLeftJustify then
          Inc(ARect.Top, TextIndent)
        else
          Dec(ARect.Bottom, TextIndent);
    end;
    DrawItemText(DC, Caption, ARect, Alignments[Alignment], Enabled, False,
      PaintType = ptVert, True, Flat);
  end;
end;

procedure TdxBarStaticControl.DrawInterior(DC: HDC; ARect: TRect;
  PaintType: TdxBarPaintType);
begin
  DrawGlyphAndCaption(DC, ARect, PaintType, True);
end;

procedure TdxBarStaticControl.GlyphChanged;
begin
  Parent.RepaintBar;
end;

function TdxBarStaticControl.GetAlignment: TAlignment;
begin
  Result := Item.Alignment;
end;

function TdxBarStaticControl.GetAutoWidth: Integer;
begin
  if Item.ShowCaption then
    Result := Parent.Canvas.TextWidth(GetTextOf(Caption))
  else
    Result := 0;
  if ImageExists or not Item.ShowCaption and not CanHaveZeroSize then
  begin
    if not IsVertical(Parent) then
      Inc(Result, TDummyBarManager(BarManager).ButtonWidth)
    else
      Inc(Result, TDummyBarManager(BarManager).ButtonHeight);
    if Item.ShowCaption then Inc(Result, 4);
  end
  else
    if Item.ShowCaption then
      Inc(Result, Parent.TextSize div 2);
  Inc(Result, LeftIndent + RightIndent + 2 * BorderWidth);
end;

function TdxBarStaticControl.GetDefaultHeight: Integer;
begin
  if Height = 0 then
  begin
    if Parent is TdxBarControl then
    begin
      if ImageExists or not Item.ShowCaption and not CanHaveZeroSize then
        if not IsVertical(Parent) then
          Result := TDummyBarManager(BarManager).ButtonHeight
        else
          Result := TDummyBarManager(BarManager).ButtonWidth
      else
        Result := 0;
      if (Result = 0) or Item.ShowCaption and (Result < Parent.TextSize - 3) then
        Result := Parent.TextSize - 3;
    end
    else
      Result := Parent.TextSize;
    Inc(Result, 2 * BorderWidth);
  end
  else
    Result := Height;
end;

function TdxBarStaticControl.GetDefaultWidth: Integer;
begin
  if Width = 0 then
    Result := GetAutoWidth
  else
    Result := Width;
end;

function TdxBarStaticControl.GetHeight: Integer;
begin
  if IsVertical(Parent) then
    Result := GetDefaultWidth
  else
    Result := GetDefaultHeight;
end;

function TdxBarStaticControl.GetWidth: Integer;
begin
  if IsVertical(Parent) then
    Result := GetDefaultHeight
  else
    Result := GetDefaultWidth;
end;

function TdxBarStaticControl.IsDestroyOnClick: Boolean;
begin
  Result := Item.AllowClick;
end;

procedure TdxBarStaticControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
const
  Borders: array[TdxBarStaticBorderStyle] of Integer =
    (0, BDR_SUNKENOUTER, BDR_RAISEDINNER, EDGE_ETCHED, 0);
var
  R: TRect;
  DC: HDC;
  Brush: HBRUSH;

  procedure DrawIndents;

    procedure DrawLeftIndent;
    begin
      if LeftIndent <> 0 then
      begin
        if IsVertical(Parent) then
        begin
          Inc(ARect.Top, LeftIndent);
          R.Bottom := ARect.Top;
        end
        else
        begin
          Inc(ARect.Left, LeftIndent);
          R.Right := ARect.Left;
        end;
        FillRect(DC, R, Parent.BkBrush);
      end;
    end;

    procedure DrawRightIndent;
    begin
      if RightIndent <> 0 then
      begin
        if IsVertical(Parent) then
        begin
          R.Bottom := ARect.Bottom;
          Dec(ARect.Bottom, RightIndent);
          R.Top := ARect.Bottom;
        end
        else
        begin
          R.Right := ARect.Right;
          Dec(ARect.Right, RightIndent);
          R.Left := ARect.Right;
        end;
        FillRect(DC, R, Parent.BkBrush);
      end;
    end;

  begin
    DrawLeftIndent;
    DrawRightIndent;
  end;

  procedure DrawBorder;
  var
    I: Integer;
  begin
    if BorderStyle <> sbsNone then
    begin
      if Flat then
      begin
        Brush := GetSysColorBrush(COLOR_BTNSHADOW);
        for I := 1 to BorderWidth do
        begin
          FrameRect(DC, ARect, Brush);
          InflateRect(ARect, -1, -1);
        end;
      end
      else
        if BorderStyle = sbsBump then
        begin
          DrawEdge(DC, ARect, BDR_RAISEDINNER, BF_RECT);
          InflateRect(ARect, -1, -1);
          DrawEdge(DC, ARect, BDR_SUNKENOUTER, BF_RECT);
          InflateRect(ARect, -1, -1);
        end
        else
        begin
          DrawEdge(DC, ARect, Borders[BorderStyle], BF_RECT);
          InflateRect(ARect, -BorderWidth, -BorderWidth);
        end;
    end;
  end;

begin
  if ARect.Left = ARect.Right then Exit;
  R := ARect;
  DC := Parent.Canvas.Handle;
  DrawIndents;
  DrawBorder;
  DrawInterior(DC, ARect, PaintType);
end;

{ TdxBarLargeButton }

constructor TdxBarLargeButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoGrayScale := True;
  FGlyphLayout := glTop;
  FHotGlyph := TBitmap.Create;
  FHotGlyph.OnChange := OnHotGlyphChanged;
  FHotImageIndex := -1;
  FLargeGlyph := TBitmap.Create;
  FLargeGlyph.OnChange := OnLargeGlyphChanged;
  FLargeImageIndex := -1;
  FShowCaption := True;
end;

destructor TdxBarLargeButton.Destroy;
begin
  FLargeGlyph.Free;
  FHotGlyph.Free;
  inherited;
end;

procedure TdxBarLargeButton.SetAutoGrayScale(Value: Boolean);
begin
  if FAutoGrayScale <> Value then
  begin
    FAutoGrayScale := Value;
    Update;
  end;
end;

procedure TdxBarLargeButton.SetGlyphLayout(Value: TdxBarGlyphLayout);
begin
  if FGlyphLayout <> Value then
  begin
    FGlyphLayout := Value;
    GlyphLayoutChanged;
  end;
end;

procedure TdxBarLargeButton.SetHeight(Value: Integer);
begin
  if FHeight <> Value then
  begin
    if Value < 0 then Exit;
    FHeight := Value;
    HeightChanged;
  end;
end;

procedure TdxBarLargeButton.SetHotGlyph(Value: TBitmap);
begin
  FHotGlyph.Assign(Value);
end;

procedure TdxBarLargeButton.SetHotImageIndex(Value: Integer);
begin
  if FHotImageIndex <> Value then
  begin
    FHotImageIndex := Value;
    HotGlyphChanged;
  end;
end;

procedure TdxBarLargeButton.SetLargeGlyph(Value: TBitmap);
begin
  FLargeGlyph.Assign(Value);
end;

procedure TdxBarLargeButton.SetLargeImageIndex(Value: Integer);
begin
  if FLargeImageIndex <> Value then
  begin
    FLargeImageIndex := Value;
    LargeGlyphChanged;
  end;
end;

procedure TdxBarLargeButton.SetShowCaption(Value: Boolean);
begin
  if FShowCaption <> Value then
  begin
    FShowCaption := Value;
    ShowCaptionChanged;
  end;
end;

procedure TdxBarLargeButton.SetWidth(Value: Integer);
begin
  if FWidth <> Value then
  begin
    if Value < 0 then Exit;
    FWidth := Value;
    WidthChanged;
  end;
end;

procedure TdxBarLargeButton.OnHotGlyphChanged(Sender: TObject);
begin
  HotGlyphChanged;
end;

procedure TdxBarLargeButton.OnLargeGlyphChanged(Sender: TObject);
begin
  LargeGlyphChanged;
end;

procedure TdxBarLargeButton.GlyphLayoutChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then
      TdxBarLargeButtonControl(Links[I].Control).GlyphLayoutChanged;
end;

function TdxBarLargeButton.HasAccel(AItemLink: TdxBarItemLink): Boolean;
begin
  Result := inherited HasAccel(AItemLink) and
    (not (AItemLink.Owner.Owner is TdxBar) or FShowCaption);
end;

procedure TdxBarLargeButton.HeightChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then
      TdxBarLargeButtonControl(Links[I].Control).HeightChanged;
end;

procedure TdxBarLargeButton.HotGlyphChanged;
var
  I: Integer;
{var
  AItemLink: TdxBarItemLink;}
begin
{  AItemLink := CurItemLink;
  if (AItemLink <> nil) and (AItemLink.Control <> nil) then
    TdxBarLargeButtonControl(AItemLink.Control).HotGlyphChanged;}
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then
      TdxBarLargeButtonControl(Links[I].Control).HotGlyphChanged;
end;

function TdxBarLargeButton.IsHotImageLinked: Boolean;
begin
  with BarManager do
    Result := (HotImages <> nil) and
      (0 <= FHotImageIndex) and (FHotImageIndex < HotImages.Count);
end;

function TdxBarLargeButton.IsLargeImageLinked: Boolean;
begin
  with BarManager do
    Result := (LargeImages <> nil) and
      (0 <= FLargeImageIndex) and (FLargeImageIndex < LargeImages.Count);
end;

procedure TdxBarLargeButton.LargeGlyphChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then
      TdxBarLargeButtonControl(Links[I].Control).LargeGlyphChanged;
end;

procedure TdxBarLargeButton.ShowCaptionChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then
      TdxBarLargeButtonControl(Links[I].Control).ShowCaptionChanged;
end;

function TdxBarLargeButton.UseHotImages: Boolean;
begin
  Result := FHotImageIndex > -1;
end;

function TdxBarLargeButton.UseLargeImages: Boolean;
begin
  Result := FLargeImageIndex > -1;
end;

procedure TdxBarLargeButton.WidthChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if Links[I].Control <> nil then
      TdxBarLargeButtonControl(Links[I].Control).WidthChanged;
end;

{ TdxBarLargeButtonControl }

function TdxBarLargeButtonControl.GetHotGlyph: TBitmap;
begin
  Result := Item.HotGlyph;
end;

function TdxBarLargeButtonControl.GetItem: TdxBarLargeButton;
begin
  Result := TdxBarLargeButton(ItemLink.Item);
end;

function TdxBarLargeButtonControl.GetLargeGlyph: TBitmap;
begin
  Result := Item.LargeGlyph;
end;

function TdxBarLargeButtonControl.GetCurrentImage(ASelected: Boolean;
  var CurrentGlyph: TBitmap; var CurrentImages: TCurImageList;
  var CurrentImageIndex: Integer): Boolean;

  procedure CheckHotGlyph;
  begin
    Result := True;
    if not HotGlyph.Empty then
      CurrentGlyph := HotGlyph
    else
      if Item.IsHotImageLinked then
      begin
        CurrentImages := HotImages;
        CurrentImageIndex := Item.HotImageIndex;
      end
      else
        Result := False;
  end;

  procedure CheckLargeGlyph;
  begin
    Result := True;
    if not LargeGlyph.Empty then
      CurrentGlyph := LargeGlyph
    else
      if Item.IsLargeImageLinked then
      begin
        CurrentImages := LargeImages;
        CurrentImageIndex := Item.LargeImageIndex;
      end
      else
        Result := False;
  end;

  function GetCurrentImages: TCurImageList;
  begin
    if LargeImages <> nil then
      Result := LargeImages
    else
      if HotImages <> nil then
        Result := HotImages
      else
        Result := nil;
  end;

begin
  CurrentGlyph := nil;
  CurrentImages := nil;
  CurrentImageIndex := -1;
  if ASelected then
  begin
    CheckHotGlyph;
    if not Result then CheckLargeGlyph;
  end
  else
  begin
    CheckLargeGlyph;
    if not Result then CheckHotGlyph;
  end;
  if not Result then
    CurrentImages := GetCurrentImages;
end;

function TdxBarLargeButtonControl.IsSizeAssigned: Boolean;
begin
  with Item do
    Result := (Width <> 0) and (Height <> 0);
end;

function TdxBarLargeButtonControl.ArrowWidth: Integer;
begin
  if Parent is TdxBarControl then
    Result := TDummyBarManager(BarManager).RealLargeButtonArrowWidth
  else
    Result := inherited ArrowWidth;
end;

procedure TdxBarLargeButtonControl.GlyphLayoutChanged;
begin
  if Parent is TdxBarControl then Parent.RepaintBar;
end;

procedure TdxBarLargeButtonControl.HeightChanged;
begin
  if Parent is TdxBarControl then Parent.RepaintBar;
end;

procedure TdxBarLargeButtonControl.HotGlyphChanged;
begin
  LargeGlyphChanged;
end;

procedure TdxBarLargeButtonControl.LargeGlyphChanged;
begin
  if Parent is TdxBarControl then
    if IsSizeAssigned then
      Repaint
    else
      Parent.RepaintBar;
end;

procedure TdxBarLargeButtonControl.ShowCaptionChanged;
begin
  if Parent is TdxBarControl then Parent.RepaintBar;
end;

procedure TdxBarLargeButtonControl.WidthChanged;
begin
  if Parent is TdxBarControl then Parent.RepaintBar;
end;

function TdxBarLargeButtonControl.GetDefaultHeight: Integer;
var
  CurrentGlyph: TBitmap;
  CurrentImages: TCurImageList;
  CurrentImageIndex, H: Integer;
begin
  if Parent is TdxBarControl then
  begin
    if Item.Height = 0 then
    begin
      Result := 1 + 2 + 2 + 1;

      if not GetCurrentImage(False, CurrentGlyph, CurrentImages, CurrentImageIndex) and
        (CurrentImages = nil) then
        Inc(Result, 20)
      else
        if IsVertical(Parent) and Item.ShowCaption then
          if CurrentGlyph = nil then
            Inc(Result, CurrentImages.Width)
          else
            Inc(Result, CurrentGlyph.Width)
        else
          if CurrentGlyph = nil then
            Inc(Result, CurrentImages.Height)
          else
            Inc(Result, CurrentGlyph.Height);

      if Item.ShowCaption then
      begin
        H := Parent.Canvas.TextHeight('Qq');
        if Item.GlyphLayout in [glTop, glBottom] then Inc(Result, H + 1)
        else
        begin
          Inc(H, 1 + 2 + 2 + 1);
          if Result < H then Result := H;
        end;
      end;
    end
    else
      Result := Item.Height;
    if Lowered then Inc(Result, 2);
  end
  else
    Result := inherited GetDefaultHeight;
end;

function TdxBarLargeButtonControl.GetDefaultWidth: Integer;
var
  CurrentGlyph: TBitmap;
  CurrentImages: TCurImageList;
  CurrentImageIndex, W: Integer;
begin
  if Parent is TdxBarControl then
  begin
    if Item.Width = 0 then
    begin
      Result := 1 + 4 + 4 + 1;

      if not GetCurrentImage(False, CurrentGlyph, CurrentImages, CurrentImageIndex) and
        (CurrentImages = nil) then
        Inc(Result, 20)
      else
        if IsVertical(Parent) and Item.ShowCaption then
          if CurrentGlyph = nil then
            Inc(Result, CurrentImages.Height)
          else
            Inc(Result, CurrentGlyph.Height)
        else
          if CurrentGlyph = nil then
            Inc(Result, CurrentImages.Width)
          else
            Inc(Result, CurrentGlyph.Width);

      if Item.ShowCaption then
      begin
        W := 3 + Parent.Canvas.TextWidth(GetTextOf(Caption)) + 3;
        if Item.GlyphLayout in [glLeft, glRight] then Inc(Result, W)
        else
        begin
          W := 1 + 4 + W + 4 + 1;
          if Result < W then Result := W;
        end;
      end;
    end
    else
      Result := Item.Width;
    if Lowered then Inc(Result, 2);
  end
  else
    Result := inherited GetDefaultWidth;
end;

function TdxBarLargeButtonControl.GetHeight: Integer;
begin
  if IsVertical(Parent) and Item.ShowCaption then
    Result := GetDefaultWidth
  else
    Result := GetDefaultHeight;
end;

function TdxBarLargeButtonControl.GetWidth: Integer;
begin
  if IsVertical(Parent) and Item.ShowCaption then
    Result := GetDefaultHeight
  else
    Result := GetDefaultWidth;
  if (Parent is TdxBarControl) and (Item.ButtonStyle = bsDropDown) then
    Inc(Result, ArrowWidth);
end;

procedure TdxBarLargeButtonControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
var
  DC: HDC;
  Selected, DrawDowned, IsGlyphEmpty: Boolean;
  R, FullRect, AImageBounds: TRect;
  CurrentGlyph: TBitmap;
  CurrentImages: TCurImageList;
  CurrentImageIndex, Alignment: Integer;
  
  function GetImageBounds: TRect;
  var
    OffsetX, OffsetY: Integer;

    procedure GetImageOffset(var OffsetX, OffsetY: Integer);
    begin
      with R do
        if not Item.ShowCaption then
        begin
          OffsetX := Left + 4;
          OffsetY := Top + 2;
        end
        else
          if PaintType = ptHorz then
            if Item.GlyphLayout in [glTop, glBottom] then
            begin
              OffsetX := (Left + Right - Result.Right) div 2;
              if Item.GlyphLayout = glTop then
                OffsetY := Top + 2
              else
                OffsetY := Bottom - 2 - Result.Bottom;
            end
            else
            begin
              OffsetY := (Top + Bottom - Result.Bottom) div 2;
              if Item.GlyphLayout = glLeft then
                OffsetX := Left + 4
              else
                OffsetX := Right - 4 - Result.Right;
            end
          else
            if Item.GlyphLayout in [glTop, glBottom] then
            begin
              OffsetY := (Top + Bottom - Result.Bottom) div 2;
              if Item.GlyphLayout = glTop then
                OffsetX := Right - 2 - Result.Right
              else
                OffsetX := Left + 2;
            end
            else
            begin
              OffsetX := (Left + Right - Result.Right) div 2;
              if Item.GlyphLayout = glLeft then
                OffsetY := Top + 4
              else
                OffsetY := Bottom - 4 - Result.Bottom;
            end;
    end;

  begin
    if IsGlyphEmpty and (CurrentImages = nil) then
      Result := Rect(0, 0, 20, 20)
    else
      if CurrentGlyph = nil then
        with CurrentImages do
          Result := Rect(0, 0, Width, Height)
      else
        with CurrentGlyph do
          Result := Rect(0, 0, Width, Height);
    GetImageOffset(OffsetX, OffsetY);
    OffsetRect(Result, OffsetX, OffsetY);
  end;

  procedure DrawImage;

    function GetFullRect: TRect;
    begin
      if DroppedDownFlat then
        Result := ARect
      else
        Result := FullRect;
    end;

  begin
    IsGlyphEmpty :=
      not GetCurrentImage(Selected, CurrentGlyph, CurrentImages, CurrentImageIndex);
    AImageBounds := GetImageBounds;
    DrawGlyphAndBkgnd(GetFullRect, AImageBounds, PaintType,
      CurrentGlyph, CurrentImages, CurrentImageIndex,
      IsGlyphEmpty, Selected, Down or DroppedDownFlat, DrawDowned, False,
      not Selected and Item.AutoGrayScale, ButtonStyle = bsDropDown);
  end;

  procedure DrawCaption;
  var
    ATextBounds: TRect;
  begin
    ATextBounds := R;
    Alignment := DT_CENTER;
    case Item.GlyphLayout of
      glLeft:
        begin
          Alignment := DT_LEFT;
          if PaintType = ptHorz then
            ATextBounds.Left := AImageBounds.Right + 3
          else
            ATextBounds.Top := AImageBounds.Bottom + 3;
        end;
      glRight:
        begin
          Alignment := DT_RIGHT;
          if PaintType = ptHorz then
            ATextBounds.Right := AImageBounds.Left - 3
          else
            ATextBounds.Bottom := AImageBounds.Top - 3;
        end;
      glTop:
        if PaintType = ptHorz then
          ATextBounds.Top := AImageBounds.Bottom
        else
          ATextBounds.Right := AImageBounds.Left;
      glBottom:
        if PaintType = ptHorz then
          ATextBounds.Bottom := AImageBounds.Top
        else
          ATextBounds.Left := AImageBounds.Right;
    end;
    DrawItemText(DC, Caption, ATextBounds, Alignment, Enabled, IsFlatTextSelected(DrawDowned),
      PaintType = ptVert, False, Flat and not IsFlatTextSelected(DrawDowned));
  end;

begin
  if PaintType <> ptMenu then
  begin
    if ARect.Left = ARect.Right then Exit;
    DC := Parent.Canvas.Handle;
    if Lowered then DrawLowered(DC, ARect);
    R := ARect;
    if Item.ButtonStyle = bsDropDown then Dec(R.Right, ArrowWidth);
    Selected := DrawSelected;
    DrawDowned :=
      Selected and Parent.IsActive and MousePressed and not DroppedDown or
      Pressed and (ButtonStyle <> bsChecked);
    FullRect := R;
    InflateRect(R, -1, -1);
    if not Flat then
    begin
      if Down then OffsetRect(R, 1, 1);
      if DrawDowned then OffsetRect(R, 1, 1);
    end;
    DrawImage;
    if Item.ShowCaption then DrawCaption;
    if ButtonStyle = bsDropDown then DrawArrow(ARect, Selected, PaintType);
  end
  else
    inherited;
end;

{ TdxBarColorCombo }

constructor TdxBarColorCombo.Create(AOwner: TComponent);
begin
  inherited;
  FAutoColor := clWindowText;
  FAutoColorText := LoadStr(DXBAR_COLORAUTOTEXT);
  FCustomColorText := LoadStr(DXBAR_COLORCUSTOMTEXT);
  DropDownCount := 16;
  Glyph.LoadFromResourceName(HInstance, 'DXBARCOLORCOMBO');
  CreateItemsList;
  ItemIndex := 0;
  ShowEditor := False;
end;

function TdxBarColorCombo.GetCurColor: TColor;
begin
  Result := GetColorByIndex(CurItemIndex);
end;

procedure TdxBarColorCombo.SetAutoColor(Value: TColor);
begin
  if FAutoColor <> Value then
  begin
    FAutoColor := Value;
    if FShowAutoColor then
    begin
      FSettingColor := True;
      try
        ItemIndex := GetIndexOfColor(FColor);
      finally
        FSettingColor := False;
        Update;
      end;
    end;
  end;
end;

procedure TdxBarColorCombo.SetAutoColorText(Value: string);
begin
  if FAutoColorText <> Value then
  begin
    FAutoColorText := Value;
    if FShowAutoColor then
    begin
      Items[0] := Value;
      Update;
    end;
  end;
end;

procedure TdxBarColorCombo.SetColor(Value: TColor);
var
  AIndex: Integer;
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FSettingColor := True;
    try
      AIndex := GetIndexOfColor(FColor);
      if ItemIndex = AIndex then
      begin
        Update;
        Change;
      end
      else ItemIndex := AIndex;
    finally
      FSettingColor := False;
    end;  
  end;
end;

procedure TdxBarColorCombo.SetCurColor(Value: TColor);
begin
  if CurColor <> Value then
    CurItemIndex := GetIndexOfColor(Value);
end;

procedure TdxBarColorCombo.SetCustomColorText(Value: string);
begin
  if FCustomColorText <> Value then
  begin
    FCustomColorText := Value;
    Update;
  end;
end;

procedure TdxBarColorCombo.SetShowAutoColor(Value: Boolean);
begin
  if FShowAutoColor <> Value then
  begin
    FShowAutoColor := Value;
    FSettingColor := True;
    try
      if Value then Items.Insert(0, FAutoColorText)
      else Items.Delete(0);
      if DropDownCount = Byte(not Value) + 16 then
        DropDownCount := Byte(Value) + 16;
      ItemIndex := GetIndexOfColor(FColor);
    finally
      FSettingColor := False;
      Update;
    end;
  end;
end;

procedure TdxBarColorCombo.SetShowCustomColorButton(Value: Boolean);
begin
  if FShowCustomColorButton <> Value then
  begin
    FShowCustomColorButton := Value;
    Update;
  end;
end;

procedure TdxBarColorCombo.CreateItemsList;
var
  I: Integer;
begin
  with Items do
  begin
    Clear;
    if FShowAutoColor then Add(FAutoColorText);
    for I := Low(Colors) to High(Colors) do
      Add(LoadStr(DXBAR_COLOR_STR_BASE + I));
  end;
end;

function TdxBarColorCombo.GetColorByIndex(AIndex: Integer): TColor;
begin
  if (0 <= AIndex) and (AIndex < 16 + Byte(FShowAutoColor)) then
    if FShowAutoColor and (AIndex = 0) then
      Result := FAutoColor
    else
      Result := Colors[AIndex - Byte(FShowAutoColor)]
  else Result := FColor;
end;

function TdxBarColorCombo.GetIndexOfColor(AColor: TColor): Integer;
begin
  if FShowAutoColor and (AColor = FAutoColor) then
    Result := 0
  else
  begin
    AColor := ColorToRGB(AColor);
    for Result := Low(Colors) + Byte(FShowAutoColor) to High(Colors) + Byte(FShowAutoColor) do
      if ColorToRGB(Colors[Result - Byte(FShowAutoColor)]) = AColor then Exit;
    Result := -1;
  end;    
end;

function TdxBarColorCombo.IsAutoColorTextStored: Boolean;
begin
  Result := FAutoColorText <> LoadStr(DXBAR_COLORAUTOTEXT);
end;

function TdxBarColorCombo.IsCustomColorTextStored: Boolean;
begin
  Result := FCustomColorText <> LoadStr(DXBAR_COLORCUSTOMTEXT);
end;

function TdxBarColorCombo.IsDropDownCountStored: Boolean;
begin
  Result := DropDownCount <> Byte(FShowAutoColor) + 16;
end;

procedure TdxBarColorCombo.Change;
begin
  if not FSettingColor then
    FColor := GetColorByIndex(ItemIndex);
  inherited;
end;

procedure TdxBarColorCombo.DrawItem(AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
var
  PrevBrushColor: TColor;
  S: string;
  R: TRect;
  HasIndent: Boolean;
begin
  if Assigned(OnDrawItem) then
    inherited
  else
    with Canvas, ARect do
    begin
      PrevBrushColor := Brush.Color;
      if AIndex = -1 then
        S := FCustomColorText
      else
        S := Items[AIndex];
      R := ARect;
      HasIndent := (AIndex <> -1) or (FColor >= 0) or (FColor <= clInfoBk);
      if HasIndent then Inc(R.Left, 30);
      FillRect(R);
      TextOut(R.Left + 1, (Top + Bottom - TextHeight(S)) div 2, S);
      if HasIndent then
      begin
        R.Right := R.Left;
        R.Left := Left;
        FrameRect(R);
        InflateRect(R, -1, -1);
        Brush.Color := clBtnShadow;
        FrameRect(R);
        InflateRect(R, -1, -1);
        Brush.Color := GetColorByIndex(AIndex);
        FillRect(R);
      end;
      Brush.Color := PrevBrushColor;
      if odFocused in AState then Windows.DrawFocusRect(Handle, ARect); // for hiding focus rect
    end;
end;

procedure TdxBarColorCombo.MeasureItem(AIndex: Integer; var AHeight: Integer);
begin
  if Assigned(OnMeasureItem) then inherited
  else
    AHeight := 2 + Canvas.TextHeight('0') + 2;
end;

procedure TdxBarColorCombo.MeasureItemWidth(AIndex: Integer; var AWidth: Integer);
begin
  inherited;
  Inc(AWidth, 30);
end;

procedure TdxBarColorCombo.DoClick;
begin
  try
    inherited;
    if not Assigned(OnClick) and not ReadOnly then
      with dxBarColorDialog do
      begin
        if FHasExchangeColor then
          Color := FExchangeColor
        else
          Color := Self.Color;
        if Execute then Self.Color := Color;
      end;
  finally
    FHasExchangeColor := False;
  end;  
end;

{ TdxBarColorComboControl }

function TdxBarColorComboControl.GetItem: TdxBarColorCombo;
begin
  Result := TdxBarColorCombo(ItemLink.Item);
end;

function TdxBarColorComboControl.DrawSelected: Boolean;
begin
  Result := inherited DrawSelected or Pressed;
end;

procedure TdxBarColorComboControl.PressedChanged;
begin
  Repaint;
end;

procedure TdxBarColorComboControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
var
  Selected: Boolean;
  DC: HDC;
  DotSize, I: Integer;
begin
  SetRectEmpty(FCustomColorButtonRect);
  if not Item.ShowCustomColorButton then
  begin
    inherited;
    Exit;
  end;
  with ARect do
  begin
    I := (Bottom - Top - 2 - 2) div 7 * 7 + 2 + 2;
    if I >= (Right - Left) div 2 then
      I := 0
    else
      Dec(Right, I);
  end;
  inherited;
  // draw custom color button
  if I = 0 then Exit;
  Selected := DrawSelected;
  DC := Parent.Canvas.Handle;
  with ARect do
  begin
    Left := Right;
    Right := Left + I;
    FrameRect(DC, ARect, Parent.BkBrush);
    InflateRect(ARect, 0, -1);
    FrameRect(DC, ARect, Parent.BkBrush);
    InflateRect(ARect, -1, -1);
    FCustomColorButtonRect := ARect;
    FrameAndFillRect(DC, ARect, Selected, Pressed);
    // draw dots
    DotSize := (Right - Left) div 7;
    Right := Left;
    Dec(Bottom, DotSize);
    Top := Bottom - DotSize;
    if Pressed and not Flat then OffsetRect(ARect, 1, 1);
    for I := 0 to 2 do
    begin
      Left := Right + DotSize;
      Right := Left + DotSize;
      if Enabled then
        FillRect(DC, ARect, COLOR_BTNTEXT + 1)
      else
      begin
        if not Flat then
        begin
          OffsetRect(ARect, 1, 1);
          FillRect(DC, ARect, COLOR_BTNHIGHLIGHT + 1);
          OffsetRect(ARect, -1, -1);
        end;  
        FillRect(DC, ARect, COLOR_BTNSHADOW + 1);
      end;
    end;
  end;
end;

procedure TdxBarColorComboControl.WndProc(var Message: TMessage);
var
  R: TRect;
  AllowPressed: Boolean;
  RealItemLink: TdxBarItemLink;
  AItem: TdxBarColorCombo;
begin
  with Message do
    if (Msg = WM_LBUTTONDOWN) or
      (Msg = WM_KEYDOWN) and (wParam = VK_RETURN) and (GetKeyState(VK_CONTROL) < 0) then
    begin
      if Msg = WM_LBUTTONDOWN then
      begin
        R := CustomColorButtonRect;
        MapWindowPoints(Parent.Handle, Handle, R, 2);
      end;
      if PtInRect(R, SmallPointToPoint(TSmallPoint(lParam))) or (Msg = WM_KEYDOWN) then
      begin
        AItem := Item;
        with AItem do
        begin
          FHasExchangeColor := True;
          FExchangeColor := CurColor;
        end;
        AllowPressed := CanVisuallyPressed;
        RealItemLink := ItemLink.RealItemLink;
        if RealItemLink <> nil then RealItemLink.BringToTopInRecentList(True);
        if AllowPressed then
          Pressed := True
        else
          Parent.HideAll;
        try
          AItem.DirectClick;
        finally
          try
            if AllowPressed then Pressed := False;
          except
          end;
        end;
        Exit;
      end;
    end;
  inherited;
end;

{ TdxBarFontNameCombo }

constructor TdxBarFontNameCombo.Create(AOwner: TComponent);
begin
  inherited;
  DropDownCount := 12;
  Glyph.LoadFromResourceName(HInstance, 'DXBARFONTNAMECOMBO');
  ShowEditor := False;
  Sorted := True;
  LoadFontNames;
  Width := 160;
end;

procedure TdxBarFontNameCombo.DrawItem(AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
var
  W, H: Integer;
  CurrentBitmap: TBitmap;
  R: TRect;
  S: string;
begin
  if Assigned(OnDrawItem) or (AIndex = -1) then
    inherited
  else
    with Canvas, ARect do
    begin
      if Boolean(Items.Objects[AIndex]) then
        CurrentBitmap := FTrueTypeFontBitmap
      else
        CurrentBitmap := FNonTrueTypeFontBitmap;
      W := CurrentBitmap.Width;
      H := CurrentBitmap.Height;
      R := Bounds(Left, (Top + Bottom - H) div 2, W, H);
      TransparentDraw(Handle, Brush.Handle, ARect, R, CurrentBitmap, nil, -1,
        True, False, False, False, False, False, BarManager.ImageListBkColor);

      S := Items[AIndex];
      TextOut(R.Right + 2, (Top + Bottom - TextHeight(S)) div 2, S);
      if odFocused in AState then Windows.DrawFocusRect(Handle, ARect); // for hiding focus rect
    end;
end;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).AddObject(LogFont.lfFaceName, Pointer(FontType and TRUETYPE_FONTTYPE <> 0));
  Result := 1;
end;

procedure TdxBarFontNameCombo.LoadFontNames;
var
  DC: HDC;
  AIsWindowDC: Boolean;

  procedure EnumFonts(DC: HDC);
  var
    LogFont: TLogFont;
  begin
    with LogFont do
    begin
      lfCharset := DEFAULT_CHARSET;
      lfFaceName := '';
      lfPitchAndFamily := 0;
    end;
    EnumFontFamiliesEx(DC, LogFont, @EnumFontsProc, Integer(Items), 0);
  end;

begin
  if Printer.Printers.Count = 0 then
    DC := 0
  else
    try
      DC := Printer.Handle;
    except
      DC := 0;
    end;
  AIsWindowDC := DC = 0;
  if AIsWindowDC then DC := GetDC(0);
  try
    EnumFonts(DC);
  finally
    if AIsWindowDC then ReleaseDC(0, DC);
  end;
end;

procedure TdxBarFontNameCombo.MeasureItemWidth(AIndex: Integer; var AWidth: Integer);
begin
  inherited;
  Inc(AWidth, FTrueTypeFontBitmap.Width + 1);
end;

procedure TdxBarFontNameCombo.SetText(Value: string);
var
  AIndex: Integer;
begin
  if CurItemLink <> nil then
  begin
    AIndex := GetNearestItemIndex(Value);
    if (AIndex = -1) and (Value <> '') then Exit;
    if AIndex > -1 then Value := Items[AIndex];
  end;
  inherited;
end;

procedure TdxBarFontNameCombo.DoClick;
begin
  inherited;
  if not Assigned(OnClick) and not ReadOnly then
    with dxBarFontDialog do
    begin
      Font.Name := Text;
      if Execute then Text := Font.Name;
    end;
end;

{ TdxBarDateCombo support classes }

procedure DecMonth(var AYear, AMonth: Word);
begin
  if AMonth = 1 then
  begin
    Dec(AYear);
    AMonth := 12;
  end
  else
    Dec(AMonth);
end;

procedure IncMonth(var AYear, AMonth: Word);
begin
  if AMonth = 12 then
  begin
    Inc(AYear);
    AMonth := 1;
  end
  else
    Inc(AMonth);
end;

procedure ChangeMonth(var AYear, AMonth: Word; Delta: Integer);
var
  Month: Integer;
begin
  Inc(AYear, Delta div 12);
  Month := AMonth;
  Inc(Month, Delta mod 12);
  if Month < 1 then
  begin
    Dec(AYear);
    Month := 12 + Month;
  end;
  if Month > 12 then
  begin
    Inc(AYear);
    Month := Month - 12;
  end;
  AMonth := Month;
end;

function GetDateElement(ADate: TDateTime; Index: Integer): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(ADate, AYear, AMonth, ADay);
  case Index of
    1: Result := AYear;
    2: Result := AMonth;
    3: Result := ADay;
    else Result := -1;
  end;
end;

function IsLeapYear(AYear: Integer): Boolean;
begin
  Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0));
end;

function DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then Inc(Result);
end;

function CheckDay(AYear, AMonth, ADay: Integer): Integer;
begin
  if ADay < 1 then Result := 1
  else
    if ADay > DaysPerMonth(AYear, AMonth) then
      Result := DaysPerMonth(AYear, AMonth)
    else
      Result := ADay;
end;

function DateOf(ADateTime: TDateTime): Integer;
begin
  Result := Trunc(ADateTime + 1E-11);
end;

function dxBarColorDialog: TColorDialog;
begin
  Result := FColorDialog;
end;

function dxBarFontDialog: TFontDialog;
begin
  Result := FFontDialog;
end;

function TextToDate(AText: string): TDateTime;
var
  I: Integer;
  V1, V2: OleVariant;
begin
  for I := 1 to Length(AText) do
    if AText[I] = '.' then AText[I] := ' ';
  V1 := AText;
  if VariantChangeType(V2, V1, 0, VT_DATE) = S_OK then
    Result := V2
  else
    Result := NullDate;
end;

function DateToText(ADate: TDateTime): string;
var
  SystemTime: TSystemTime;
  PS: PChar;
begin
  if ADate = NullDate then Result := ''
  else
  begin
    with SystemTime do
    begin
      DecodeDate(ADate, wYear, wMonth, wDay);
      wDayOfWeek := Word(Abs(Trunc(ADate) - 1) mod 7);
      DecodeTime(ADate, wHour, wMinute, wSecond, wMilliseconds);
    end;
    GetMem(PS, 100);
    GetDateFormat(0, 0, @SystemTime, nil, PS, 100);
    Result := PS;
    FreeMem(PS, 100);
  end;  
end;

{ TAMonthListBox }

type
  TAMonthListBox = class(TCustomControl)
  private
    FTopDate: TDateTime;
    FItemHeight: Integer;
    FItemIndex: Integer;
    FItems: TStrings;
    FTimer: UINT;
    FTimerId: UINT;

    procedure FreeTimer;

    function GetDate: TDateTime;
    procedure SetItemIndex(Value: Integer);
    procedure SetTopDate(Value: TDateTime);

    procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;

    property ItemHeight: Integer read FItemHeight;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Items: TStrings read FItems;
    property TopDate: TDateTime read FTopDate write SetTopDate;
  public
    constructor Create(AOwner: TComponent); override;

    property Date: TDateTime read GetDate;
  end;

constructor TAMonthListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTopDate := NullDate;
end;

procedure TAMonthListBox.FreeTimer;
begin
  if FTimer > 0 then
  begin
    KillTimer(Handle, FTimerId);
    FTimer := 0;
  end;
end;

function TAMonthListBox.GetDate: TDateTime;
var
  Year, Month, Day: Word;
begin
  if ItemIndex = -1 then Result := NullDate
  else
  begin
    DecodeDate(TopDate, Year, Month, Day);
    ChangeMonth(Year, Month, ItemIndex);
    Result := EncodeDate(Year, Month, 1);
  end;  
end;

procedure TAMonthListBox.SetItemIndex(Value: Integer);
var
  PrevItemIndex: Integer;

  procedure InvalidateItemRect(Index: Integer);
  var
    R: TRect;
  begin
    if Index = -1 then Exit;
    with R do
    begin
      Left := 0;
      Top := Index * ItemHeight;
      Right := ClientWidth;
      Bottom := Top + ItemHeight;
    end;
    InvalidateRect(Handle, @R, False);
  end;

begin
  if FItemIndex <> Value then
  begin
    PrevItemIndex := FItemIndex;
    FItemIndex := Value;
    InvalidateItemRect(PrevItemIndex);
    InvalidateItemRect(FItemIndex);
  end;
end;

procedure TAMonthListBox.SetTopDate(Value: TDateTime);
begin
  if FTopDate <> Value then
  begin
    FTopDate := Value;
    Repaint;
  end;
end;

procedure TAMonthListBox.WMDestroy(var Message: TMessage);
begin
  FreeTimer;
  inherited;
end;

procedure TAMonthListBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TAMonthListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Canvas.Font.Assign(Font);
  with TdxBarDateNavigator(Parent) do
  begin
    FItemHeight := FHeaderHeight - 2;
    Self.Width := 2 * GetSystemMetrics(SM_CXBORDER) + 6 * FColWidth;
    Self.Height := 2 * GetSystemMetrics(SM_CYBORDER) + 7 * ItemHeight;
  end;
end;

procedure TAMonthListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP or WS_BORDER;
    ExStyle := WS_EX_TOPMOST;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
  end;
end;

procedure AMonthListBoxTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT;
  Time: DWORD); stdcall;
var
  AControl: TAMonthListBox;
  Year, Month, Day: Word;
begin
  AControl := TAMonthListBox(FindControl(Wnd));
  with AControl do
  begin
    DecodeDate(TopDate, Year, Month, Day);
    ChangeMonth(Year, Month, 2 * Integer(idEvent > 5) - 1);
    TopDate := EncodeDate(Year, Month, 1);
  end;
end;

procedure TAMonthListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
const
  Times: array[1..4] of UINT = (500, 250, 100, 50);
var
  Delta, Sign: Integer;
  NewTimerId: UINT;
begin
  if PtInRect(ClientRect, Point(X, Y)) then
  begin
    FreeTimer;
    ItemIndex := Y div ItemHeight;
  end
  else
  begin
    ItemIndex := -1;
    if Y < 0 then Delta := Y
    else
      if Y >= ClientHeight then
        Delta := 1 + Y - ClientHeight
      else Exit;
    Sign := Delta div Abs(Delta);
    NewTimerId := Sign + Delta div 12;
    if Abs(NewTimerId) > 4 then
      NewTimerId := Sign * 4;
    NewTimerId := NewTimerId + 5;
    if (FTimer = 0) or (NewTimerId <> FTimerId) then
    begin
      FreeTimer;
      FTimerId := NewTimerId;
      FTimer := SetTimer(Handle, FTimerId, Times[Abs(FTimerId - 5)],
        @AMonthListBoxTimerProc);
    end;
  end;    
end;

procedure TAMonthListBox.Paint;
const
  Colors: array[Boolean] of TColor = (clWindow, clWindowText);
var
  I: Integer;
  Year, Month, Day: Word;
  Selected: Boolean;
  Rect: TRect;
  S: string;
begin
  DecodeDate(TopDate, Year, Month, Day);
  with Rect do
  begin
    Left := 0;
    Top := 0;
    Right := ClientWidth;
    Bottom := ItemHeight;
  end;
  for I := 0 to 6 do
  begin
    Selected := I = ItemIndex;
    with Canvas do
    begin
      Font.Color := Colors[not Selected];
      Brush.Color := Colors[Selected];
      Windows.FillRect(Handle, Rect, Brush.Handle);
      S := {$IfDef XE}formatSettings.{$EndIf}LongMonthNames[Month] + ' ' + IntToStr(Year);
      DrawText(Handle, PChar(S), Length(S), Rect,
        DT_SINGLELINE or DT_NOCLIP or DT_CENTER or DT_VCENTER);
    end;
    IncMonth(Year, Month);
    OffsetRect(Rect, 0, ItemHeight);
  end;
end;

{ TdxBarCustomCalendar }

constructor TdxBarCustomCalendar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csDoubleClicks];
  FFirstDate := Date;
  FSelStart := FFirstDate;
  FSelFinish := FSelStart;
  FStyle := csFlat;
end;

function TdxBarCustomCalendar.GetFlat: Boolean;
begin
  Result := FStyle <> cs3D;
end;

function TdxBarCustomCalendar.GetUltraFlat: Boolean;
begin
  Result := Style = csUltraFlat;
end;

procedure TdxBarCustomCalendar.SetStyle(Value: TdxBarCalendarStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    RecreateWnd;
  end;
end;

procedure TdxBarCustomCalendar.WMCancelMode(var Message: TMessage);
begin
  inherited;
  CancelAll;
end;

procedure TdxBarCustomCalendar.WMCaptureChanged(var Message: TMessage);
begin
  inherited;
  with Message do
    if (lParam <> 0) and (HWND(lParam) <> Handle) then CancelAll;
end;

procedure TdxBarCustomCalendar.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

function TdxBarCustomCalendar.GetStyle: TdxBarCalendarStyle;
begin
  Result := FStyle;
end;

function TdxBarCustomCalendar.GetRealFirstDate: TDateTime;
begin
  Result := FirstDate;
end;

function TdxBarCustomCalendar.GetRealLastDate: TDateTime;
begin
  Result := LastDate;
end;

function TdxBarCustomCalendar.GetSelStart: TDateTime;
begin
  if (FSelStart < FSelFinish) or (FSelFinish = NullDate) then
    Result := FSelStart
  else
    Result := FSelFinish;
end;

function TdxBarCustomCalendar.GetSelFinish: TDateTime;
begin
  if FSelStart < FSelFinish then
    Result := FSelFinish
  else
    Result := FSelStart;
end;

procedure TdxBarCustomCalendar.SetFirstDate(Value: TDateTime);
begin
  if FFirstDate <> Value then
  begin
    FFirstDate := Value;
  end;
end;

procedure TdxBarCustomCalendar.SetSelStart(Value: TDateTime);
begin
  FSelStart := Value;
  FSelFinish := NullDate;
  SelFinish := Value;
end;

procedure TdxBarCustomCalendar.SetSelFinish(Value: TDateTime);
var
  OldSelFinish: TDateTime;
begin
  if FSelFinish <> Value then
  begin
    CheckFirstDate;
    OldSelFinish := FSelFinish;
    FSelFinish := Value;
    if FSelFinish <> OldSelFinish then
    begin
      CheckFirstDate;
      Repaint;
    end;
  end;
end;

procedure TdxBarCustomCalendar.CancelAll; 
begin
  SendMessage(Handle, WM_LBUTTONUP, 0, LParam(PointToSmallPoint(Point(-1, -1))));
end;

procedure TdxBarCustomCalendar.DoDateTimeChanged;
begin
  if Assigned(FOnDateTimeChanged) then FOnDateTimeChanged(Self);
end;

procedure TdxBarCustomCalendar.DoInternalSelectPeriod(ADate: TDateTime);
var
  PrevSelFinish: TDateTime;
begin
  if (SelFinish <> ADate) and (ADate <> NullDate) then
  begin
    PrevSelFinish := FSelFinish;
    SelFinish := ADate;
    if FSelFinish = PrevSelFinish then Repaint;
  end;  
end;

procedure TdxBarCustomCalendar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style or WS_CLIPCHILDREN;
end;

procedure TdxBarCustomCalendar.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, CM_FONTCHANGED, 0, 0);
end;

procedure TdxBarCustomCalendar.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ADate: TDateTime;
begin
  if ssDouble in Shift then Exit;
  inherited MouseDown(Button, Shift, X, Y);
  ADate := PosToDateTime(Point(X, Y));
  if Button = mbLeft then
  begin
    FDragDate := SelStart;
    if ADate <> NullDate then SelStart := ADate;
  end;  
end;

procedure TdxBarCustomCalendar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ADate: TDateTime;
begin
  ADate := NullDate;
  if (ssLeft in Shift) and (GetCapture = Handle) then
    ADate := PosToDateTime(Point(X, Y));
  inherited MouseMove(Shift, X, Y);
  if (ssLeft in Shift) and (GetCapture = Handle) then
    if ADate <> NullDate then SelFinish := ADate
    else
      if not PtInRect(ClientRect, Point(X, Y)) then
        DoInternalSelectPeriod(FDragDate);
  Update;
end;

{ TdxBarDateNavigator }

constructor TdxBarDateNavigator.Create(AOwner: TComponent);
var
  Year, Month, Day: Word;
begin
  inherited Create(AOwner);
  Visible := False;
  DecodeDate(FFirstDate, Year, Month, Day);
  FFirstDate := EncodeDate(Year, Month, 1);
  Width := 20;
  Height := 20;
  FColCount := 1;
  FRowCount := 1;
  ShowTodayButton := True;
end;

procedure TdxBarDateNavigator.CheckSelection(MarginDate: TDateTime);
begin
  Repaint;
end;

function TdxBarDateNavigator.ColOfDate(ADate: TDateTime): Integer;
begin
  Result := DayOfWeek(ADate) - StartOfWeek - 1;
  if Result < 0 then Inc(Result, 7);
end;

function TdxBarDateNavigator.GetHeaderRect: TRect;
begin
  with Result do
  begin
    Left := 0;
    Top := 0;
    Right := ClientWidth;
    Bottom := Top + FHeaderHeight;
  end;
end;

function TdxBarDateNavigator.GetInternalRect: TRect;
begin
  with Result do
  begin
    Left := 0;
    Top := FHeaderHeight + Byte(not Flat);
    Right := ClientWidth;
    Bottom := Top + FDaysOfWeekHeight + 6 * FRowHeight + 1;
  end;
end;

function TdxBarDateNavigator.GetLeftArrowRect: TRect;
begin
  SetRect(Result, 1, 1, FColWidth - 1, FHeaderHeight - 1);
end;

function TdxBarDateNavigator.GetRightArrowRect: TRect;
begin
  SetRect(Result, ClientWidth - FColWidth, 1,
    ClientWidth - 1 - Byte(not Flat), FHeaderHeight - 1);
end;

function TdxBarDateNavigator.GetMonthNameRect: TRect;
begin
  Result := GetInternalRect;
  with Result do
  begin
    Inc(Left, FColWidth);
    Dec(Right, FColWidth + Byte(not Flat));
    Bottom := Top - Byte(not Flat) - 1;
    Top := Bottom - (FHeaderHeight - 2);
  end;
end;

function TdxBarDateNavigator.GetTodayButtonRect: TRect;
begin
  Result :=
    Bounds(
      (ClientWidth - FTodayButtonWidth - Byte(ShowClearButton) * FClearButtonWidth) div
       (3 - Byte(not ShowClearButton)),
      ClientHeight - FButtonsRegionHeight + FButtonsOffset,
      FTodayButtonWidth, FButtonsHeight);
end;

function TdxBarDateNavigator.GetClearButtonRect: TRect;
begin
  Result :=
    Bounds(ClientWidth - FClearButtonWidth -
      (ClientWidth - Byte(ShowTodayButton) * FTodayButtonWidth - FClearButtonWidth) div
       (3 - Byte(not ShowTodayButton)),
      ClientHeight - FButtonsRegionHeight + FButtonsOffset,
      FClearButtonWidth, FButtonsHeight);
end;

function TdxBarDateNavigator.GetShowButtonsArea: Boolean;
begin
  Result := ShowTodayButton or ShowClearButton;
end;

procedure TdxBarDateNavigator.FreeTimer;
begin
  if FTimer > 0 then
  begin
    KillTimer(Handle, FTimer);
    FTimer := 0;
  end;
end;

procedure TdxBarDateNavigator.RepaintTodayButton;
var
  R: TRect;
begin
  R := GetTodayButtonRect;
  InvalidateRect(Handle, @R, False);
end;

procedure TdxBarDateNavigator.RepaintClearButton;
var
  R: TRect;
begin
  R := GetClearButtonRect;
  InvalidateRect(Handle, @R, False);
end;

procedure TdxBarDateNavigator.WMDestroy(var Message: TMessage);
begin
  FreeTimer;
  inherited;
end;

procedure TdxBarDateNavigator.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  if Flat then
    InflateRect(Message.CalcSize_Params^.rgrc[0], -1, -1);
end;

procedure TdxBarDateNavigator.WMNCPaint(var Message: TWMNCPaint);
var
  R, CR: TRect;
  Delta: Integer;
  DC: HDC;
begin
  inherited;
  if Flat then
  begin
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    DC := GetWindowDC(Handle);
    if Style = csFlat then
    begin
      Windows.GetClientRect(Handle, CR);
      Delta := (R.Right - CR.Right) div 2 - 1;
      InflateRect(R, -Delta, -Delta);
      DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);
    end
    else
      FrameRect(DC, R, GetSysColorBrush(COLOR_BTNSHADOW));
    ReleaseDC(Handle, DC);
  end;
end;

procedure TdxBarDateNavigator.WMSize(var Message: TWMSize);
begin
  inherited;
  SetSize;
end;

procedure TdxBarDateNavigator.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Canvas.Font.Assign(Font);
  FColWidth := 3 * Canvas.TextWidth('0');
  FSideWidth := 2 * Canvas.TextWidth('0');
  FRowHeight := Canvas.TextHeight('0') + 2;
  FHeaderHeight := FRowHeight + 2 + Byte(Flat);
  FDaysOfWeekHeight := FRowHeight + 1;
  FTodayButtonWidth := Canvas.TextWidth(sdxBarDatePopupToday) +
    FColWidth;
  FClearButtonWidth := Canvas.TextWidth(sdxBarDatePopupClear) +
    FColWidth;
  FButtonsOffset := Font.Size div 2;
  FButtonsHeight := MulDiv(Font.Size, 5, 2);
  FButtonsRegionHeight := FButtonsOffset + FButtonsHeight +
    Font.Size * 3 div 4;
  SendMessage(Handle, WM_SIZE, 0, 0);
end;

function TdxBarDateNavigator.GetStyle: TdxBarCalendarStyle;
begin
  Result := inherited GetStyle;
  if (Result = csFlat) and FCombo.Flat then
    Result := csUltraFlat;
end;

function TdxBarDateNavigator.GetRealFirstDate: TDateTime;
var
  ACol: Integer;
begin
  Result := FirstDate;
  ACol := ColOfDate(FirstDate);
  if ACol = 0 then
    Result := Result - 7
  else
    Result := Result - ACol;
end;

function TdxBarDateNavigator.GetRealLastDate: TDateTime;
var
  Year, Month, Day: Word;
  ACol: Integer;
begin
  Result := LastDate;
  DecodeDate(Result, Year, Month, Day);
  ACol := ColOfDate(EncodeDate(Year, Month, 1));
  Result := Result + 6 * 7 - DaysPerMonth(Year, Month) - ACol;
  if ACol = 0 then Result := Result - 7; 
end;

function TdxBarDateNavigator.GetLastDate: TDateTime;
var
  Year, Month, Day: Word;
begin
  DecodeDate(FirstDate, Year, Month, Day);
  Result := EncodeDate(Year, Month, DaysPerMonth(Year, Month));
end;

procedure TdxBarDateNavigator.SetFirstDate(Value: TDateTime);
begin
  Value := DateOf(Value) - (GetDateElement(Value, 3) - 1);
  inherited SetFirstDate(Value);
end;

procedure TdxBarDateNavigator.SetSelFinish(Value: TDateTime);
begin
  if FSelFinish <> Value then
  begin
    FSelStart := Value;
    inherited SetSelFinish(Value);
  end;
end;

procedure TdxBarDateNavigator.StepToPast;
var
  Year, Month, Day: Word;
begin
  DecodeDate(FirstDate, Year, Month, Day);
  DecMonth(Year, Month);
  FirstDate := EncodeDate(Year, Month, 1);
  if SelStart > LastDate then
    CheckSelection(LastDate)
  else
    Repaint;
end;

procedure TdxBarDateNavigator.StepToFuture;
var
  Year, Month, Day: Word;
begin
  DecodeDate(FirstDate, Year, Month, Day);
  IncMonth(Year, Month);
  FirstDate := EncodeDate(Year, Month, 1);
  if SelStart < FirstDate then
    CheckSelection(FirstDate)
  else
    Repaint;
end;

procedure TdxBarDateNavigator.CancelAll;
begin
  inherited;
  DeactivateAll;
end;

procedure TdxBarDateNavigator.CheckFirstDate;
var
  Year, Month, Day: Word;
begin
  if FSelStart < RealFirstDate then
  begin
    DecodeDate(FSelStart, Year, Month, Day);
    ChangeMonth(Year, Month, -1{(ColCount * RowCount - 1)});
    FirstDate := EncodeDate(Year, Month, CheckDay(Year, Month, Day));
  end;
  if FSelStart > RealLastDate then
    FirstDate := DateOf(FSelStart);
end;

procedure TdxBarDateNavigator.DeactivateAll;
begin
  FreeTimer;
  if FListBox <> nil then
  begin
    FListBox.Free;
    FListBox := nil;
  end;
  FTodayButtonActive := False;
  FClearButtonActive := False;
end;

function TdxBarDateNavigator.PosToDateTime(P: TPoint): TDateTime;
var
  ACol, ARow, X, Y: Integer;
  R: TRect;
  Year, Month, Day, AYear, AMonth: Word;
  ADate: TDateTime;
begin
  if PtInRect(ClientRect, P) then
  begin
    ACol := P.X div (ClientWidth div ColCount);
    ARow := P.Y div (ClientHeight div RowCount);
    R := GetInternalRect;
    with R do
    begin
      Inc(Top, FDaysOfWeekHeight);
      Inc(Left, FSideWidth);
      Dec(Right, FSideWidth);
      Bottom := Top + 6 * FRowHeight;
      if PtInRect(R, P) then
      begin
        Dec(P.X, Left);
        Dec(P.Y, Top);
        X := P.X div FColWidth;
        Y := P.Y div FRowHeight;
        DecodeDate(FirstDate, Year, Month, Day);
        ChangeMonth(Year, Month, ARow * ColCount + ACol);
        ADate := EncodeDate(Year, Month, 1);
        Result := ADate - ColOfDate(ADate) + Y * 7 + X;
        if (ACol + ARow = 0) and (ColOfDate(FirstDate) = 0) then
          Result := Result - 7;
        DecodeDate(Result, AYear, AMonth, Day);
        if ((Result < ADate) and (ACol + ARow > 0)) or
          ((Result >= ADate + DaysPerMonth(Year, Month)) and
           not ((ACol = ColCount - 1) and (ARow = RowCount - 1))) then
          Result := NullDate;
      end
      else
        Result := NullDate;
    end;
  end
  else
    Result := NullDate;
end;

procedure TdxBarDateNavigator.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if IsPopup then
    begin
      Style := WS_CHILD or Byte(not UltraFlat) * WS_DLGFRAME;
      ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
      WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    end;
    if not Flat then
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
  end;
end;

procedure TdxBarDateNavigator.CreateWnd;
begin
  inherited;
  if FCombo.CurItemLink <> nil then
    Font.Handle := CloneFont(FCombo.CurItemLink.BarControl.EditFontHandle);
  Font.Color := clWindowText;
  Canvas.Font := Font;
  if IsPopup then
  begin
    Windows.SetParent(Handle, 0);
    CallWindowProc(DefWndProc, Handle, WM_SETFOCUS, 0, 0);
  end;  
end;

procedure TdxBarDateNavigator.DblClick;
var
  P: TPoint;
begin
  inherited;
  GetCursorPos(P);
  Windows.ScreenToClient(Handle, P);
  if not IsPopup and (PosToDateTime(P) <> NullDate) then
    FCombo.FForm.ModalResult := mrOk;
end;

procedure TdxBarDateNavigator.KeyDown(var Key: Word; Shift: TShiftState);
var
  AYear, AMonth, ADay: Word;

  procedure MoveByMonth(AForward: Boolean);
  begin
    DecodeDate(SelStart, AYear, AMonth, ADay);
    if AForward then
      IncMonth(AYear, AMonth)
    else
      DecMonth(AYear, AMonth);
    ADay := CheckDay(AYear, AMonth, ADay);
    SelStart := EncodeDate(AYear, AMonth, ADay);
  end;

begin
  inherited KeyDown(Key, Shift);
  if IsPopup then
    case Key of
      VK_RETURN:
        if FListBox = nil then DoDateTimeChanged;
      VK_LEFT: SelStart := SelStart - 1;
      VK_RIGHT: SelStart := SelStart + 1;
      VK_UP: SelStart := SelStart - 7;
      VK_DOWN: SelStart := SelStart + 7;
      VK_HOME:
        if Shift = [ssCtrl] then
          SelStart := SelStart - (GetDateElement(SelStart, 3) - 1)
        else
          SelStart := SelStart - ColOfDate(SelStart);
      VK_END:
        if Shift = [ssCtrl] then
        begin
          DecodeDate(SelStart, AYear, AMonth, ADay);
          SelStart := SelStart + (DaysPerMonth(AYear, AMonth) - ADay)
        end
        else
          SelStart := SelStart + (6 - ColOfDate(SelStart));
      VK_PRIOR: MoveByMonth(False);
      VK_NEXT: MoveByMonth(True)
    end;
end;

procedure ADateNavigatorTimerProc(Wnd: HWND; Msg: UINT; idEvent: UINT;
  Time: DWORD); stdcall;
var
  AControl: TdxBarDateNavigator;
  P: TPoint;
begin
  AControl := TdxBarDateNavigator(FindControl(Wnd));
  GetCursorPos(P);
  P := AControl.ScreenToClient(P);
  with AControl do
    case idEvent of
      1: if PtInRect(GetLeftArrowRect, P) then StepToPast;
      2: if PtInRect(GetRightArrowRect, P) then StepToFuture;
    end;
end;

procedure TdxBarDateNavigator.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Col, Row: Integer;
  Year, Month, Day: Word;
  R: TRect;
begin
  if (Button = mbLeft) and IsPopup then
    if ShowTodayButton and PtInRect(GetTodayButtonRect, Point(X, Y)) then
    begin
      FTodayButtonActive := True;
      FTodayButtonPressed := True;
      RepaintTodayButton;
      Exit;
    end
    else
      if ShowClearButton and PtInRect(GetClearButtonRect, Point(X, Y)) then
      begin
        FClearButtonActive := True;
        FClearButtonPressed := True;
        RepaintClearButton;
        Exit;
      end
      else
        if ShowButtonsArea and (Y >= ClientHeight - FButtonsRegionHeight) then
          Exit;
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then
  begin
    Col := X div (ClientWidth div ColCount);
    Row := Y div (ClientHeight div RowCount);
    if PtInRect(GetMonthNameRect, Point(X, Y)) then
    begin  // show month's list box
      FListBoxDelta := Row * ColCount + Col;
      FListBox := TAMonthListBox.Create(Self);
      FListBox.Visible := False;
      FListBox.Parent := Self;
      DecodeDate(FirstDate, Year, Month, Day);
      ChangeMonth(Year, Month, FListBoxDelta - 3);
      R := GetMonthNameRect;
      MapWindowPoints(Handle, 0, R, 2);
      with TAMonthListBox(FListBox) do
      begin
        Font.Assign(Self.Font);
        SendMessage(Handle, CM_FONTCHANGED, 0, 0);
        TopDate := EncodeDate(Year, Month, 1);
        Left := (R.Left + R.Right - Width) div 2;
        Top := (R.Top + R.Bottom) div 2 - Height div 2;
        ShowWindow(Handle, SW_SHOWNOACTIVATE);
      end;
    end
    else
      if PtInRect(GetLeftArrowRect, Point(X, Y)) then
      begin  // shift by month to past
        StepToPast;
        if FTimer = 0 then
          FTimer := SetTimer(Handle, 1, ADateNavigatorTime,
            @ADateNavigatorTimerProc);
      end
      else
        if PtInRect(GetRightArrowRect, Point(X, Y)) then
        begin  // shift by month to future
          StepToFuture;
          if FTimer = 0 then
            FTimer := SetTimer(Handle, 2, ADateNavigatorTime,
              @ADateNavigatorTimerProc);
        end;
  end;
end;

procedure TdxBarDateNavigator.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
  if FTimer > 0 then Exit;
  if FListBox <> nil then
  begin
    P := Point(X, Y);
    MapWindowPoints(Handle, FListBox.Handle, P, 1);
    TAMonthListBox(FListBox).MouseMove(Shift, P.X, P.Y);
    Exit;
  end;
  if FTodayButtonActive then
  begin
    if FTodayButtonPressed <> PtInRect(GetTodayButtonRect, Point(X, Y)) then
    begin
      FTodayButtonPressed := not FTodayButtonPressed;
      RepaintTodayButton;
    end;
    Exit;
  end;
  if FClearButtonActive then
  begin
    if FClearButtonPressed <> PtInRect(GetClearButtonRect, Point(X, Y)) then
    begin
      FClearButtonPressed := not FClearButtonPressed;
      RepaintClearButton;
    end;
    Exit;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TdxBarDateNavigator.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  ADate: TDateTime;
  Year, Month, Day: Word;
  P: TPoint;
begin
  if FTimer > 0 then
  begin
    FreeTimer;
    Exit;
  end;
  if FListBox <> nil then
  begin
    ADate := TAMonthListBox(FListBox).Date;
    FListBox.Free;
    FListBox := nil;
    if ADate <> NullDate then
    begin
      DecodeDate(ADate, Year, Month, Day);
      ChangeMonth(Year, Month, -FListBoxDelta);
      FirstDate := EncodeDate(Year, Month, 1);
      if SelStart < FirstDate then
        CheckSelection(FirstDate)
      else
        if SelStart > LastDate then
          CheckSelection(LastDate)
        else
          Repaint;
    end;
    Exit;
  end;
  if FTodayButtonActive then
  begin
    FTodayButtonActive := False;
    if FTodayButtonPressed then
      SelStart := Date
    else
      Exit;
  end;
  if FClearButtonActive then
  begin
    FClearButtonActive := False;
    if FClearButtonPressed then
      SelStart := NullDate
    else
      Exit;
  end;
  inherited MouseUp(Button, Shift, X, Y);
  if not (ssDouble in Shift) then
  begin
    P := Point(X, Y);
    if PtInRect(ClientRect, P) and
      ((PosToDateTime(P) <> NullDate) or
       ShowTodayButton and PtInRect(GetTodayButtonRect, P) or
       ShowClearButton and PtInRect(GetClearButtonRect, P)) then
      DoDateTimeChanged
    else
      DoInternalSelectPeriod(FDragDate);
  end;
end;

procedure TdxBarDateNavigator.Paint;
const
  FontColors: array[Boolean] of Integer = (COLOR_WINDOWTEXT, COLOR_HIGHLIGHTTEXT);
  BrushColors: array[Boolean, Boolean] of TColor =
    ((clWindow, clHighlight), (clWindow, clBtnFace));
var
  I, J, ArrowHeight: Integer;
  Region, Rgn: HRGN;
  CurDate, ALastDate: TDateTime;

  procedure ExcludeRect(const R: TRect);
  begin
    Rgn := CreateRectRgnIndirect(R);
    CombineRgn(Region, Region, Rgn, RGN_DIFF);
    DeleteObject(Rgn);
  end;

  procedure DrawArrow(const R: TRect; LeftArrow: Boolean);
  var
    X, Sign: Integer;
    P: array[1..3] of TPoint;
    Rgn: HRGN;
  begin
    with Canvas, R do
    begin
      if LeftArrow then
        X := Left - 1
      else
        X := Right;
      Sign := 2 * Byte(LeftArrow) - 1;
      P[1] := Point(X + Sign * (FSideWidth - 1), (Top + Bottom - ArrowHeight) div 2);
      P[2] := Point(P[1].X, P[1].Y + ArrowHeight - 1);
      P[3] := Point(P[1].X - Sign * ArrowHeight div 2, P[1].Y + ArrowHeight div 2);
      Pen.Color := clBtnText;
      Brush.Color := clBtnText;
      Polygon(P);
      // exclude arrow area from clipregion
      if LeftArrow then
      begin
        Inc(P[1].X);
        Inc(P[2].X);
      end
      else
        Inc(P[3].X);
      Dec(P[1].Y);
      Inc(P[2].Y);
      Rgn := CreatePolygonRgn(P, 3, WINDING);
      ExtSelectClipRgn(Handle, Rgn, RGN_DIFF);
      DeleteObject(Rgn);
    end;
  end;

  procedure DrawMonth(Col, Row: Integer);
  var
    Size: TSize;
    R, TextR, SideR: TRect;
    I, J, DayBase, CurDay, ADaysPerMonth: Integer;
    Year, Month, Day: Word;
    ADate, DateBase: TDateTime;
    S: string;
    Selected: Boolean;
  begin
    DecodeDate(FirstDate, Year, Month, Day);
    ChangeMonth(Year, Month, Row * ColCount + Col);
    with Canvas do
    begin
      R := GetInternalRect;
      with R do
        ExcludeRect(Rect(Left + FSideWidth, Top, Right - FSideWidth, Bottom - 1));
      // draw header's frame
      TextR := GetHeaderRect;
      with TextR do ArrowHeight := (Bottom - Top) div 2;
      if not Odd(ArrowHeight) then Inc(ArrowHeight);
      if not Flat then InflateRect(TextR, 0, 1);
      ExcludeRect(TextR);
      if not Flat then InflateRect(TextR, 0, -1);
      Brush.Color := clBtnFace;
      Pen.Color := clBtnText;
      if not Flat then
        with TextR do
        begin
          MoveToEx(Handle, Left, Bottom, nil);
          Windows.LineTo(Handle, Right, Bottom);
          if Col = ColCount - 1 then
          begin
            MoveToEx(Handle, Right - 1, Top, nil);
            Windows.LineTo(Handle, Right - 1, Bottom);
            Dec(TextR.Right);
          end;
        end;
      if UltraFlat then
        with TextR do
        begin
          Windows.FillRect(Handle, Rect(Left, Bottom - 1, Right, Bottom), COLOR_BTNSHADOW + 1);
          Dec(Bottom);
        end
      else
      begin
        DrawEdge(Handle, TextR, BDR_RAISEDINNER, BF_TOP or BF_BOTTOM or
          Byte(Col = 0) * BF_LEFT or Byte(Col = ColCount - 1) * BF_RIGHT);
        InflateRect(TextR, -1, -1);
      end;
      {if Col < ColCount - 1 then
        with TextR do
        begin
          SideR := Rect(Right - 1, Top + 2, Right + 1, Bottom - 2);
          DrawEdge(Handle, SideR, EDGE_ETCHED, BF_LEFT);
          with SideR do
          begin
            Windows.FillRect(Handle, Rect(Left, Top - 1, Right, Top), Brush.Handle);
            Windows.FillRect(Handle, Rect(Left, Bottom, Right, Bottom + 1), Brush.Handle);
          end;
        end;}
      // draw arrows
      if Row = 0 then
      begin
        if Col = 0 then DrawArrow(TextR, True);
        if Col = ColCount - 1 then DrawArrow(TextR, False);
      end;
      // write month's and year's names
      S := {$IfDef XE}formatSettings.{$EndIf}LongMonthNames[Month] + ' ' + IntToStr(Year);
      GetTextExtentPoint32(Handle, PChar(S), Length(S), Size);
      SetTextColor(Handle, GetSysColor(COLOR_BTNTEXT));
      Brush.Color := clBtnFace;
      with TextR do
        ExtTextOut(Handle, (Left + Right - Size.cX) div 2, (Top + Bottom - Size.cY) div 2,
          ETO_CLIPPED or ETO_OPAQUE, @TextR, PChar(S), Length(S), nil);
      // write first letters of day's names
      Brush.Color := clWindow;
      with TextR do
      begin
        Left := R.Left + FSideWidth;
        Right := R.Right - FSideWidth;
        Top := R.Top;
        Bottom := Top + FDaysOfWeekHeight - 2;
        Windows.FillRect(Handle, Rect(Left - 8, Top, Left, Bottom + 2), Brush.Handle);
        Windows.FillRect(Handle, Rect(Right, Top, Right + 8, Bottom + 2), Brush.Handle);
        Pen.Color := clBtnShadow;
        MoveToEx(Handle, Left, Bottom, nil);
        Windows.LineTo(Handle, Right, Bottom);
        Pen.Color := clWindow;
        MoveToEx(Handle, Left, Bottom + 1, nil);
        Windows.LineTo(Handle, Right, Bottom + 1);
        Right := Left;
      end;
      for I := 0 to 6 do
      begin
        with TextR do
        begin
          Left := Right;
          Right := Left + FColWidth;
        end;
        J := StartOfWeek + 1 + I;
        if J > 7 then Dec(J, 7);
        S := WideString({$IfDef XE}formatSettings.{$EndIf}ShortDayNames[J])[1];
        GetTextExtentPoint32(Handle, PChar(S), Length(S), Size);
        with TextR do
          ExtTextOut(Handle, Right - 3 - Size.cX, (Top + Bottom - Size.cY) div 2,
            ETO_OPAQUE, @TextR, PChar(S), Length(S), nil);
      end;
      // write numbers of days
      DateBase := EncodeDate(Year, Month, 1) - 1;
      DayBase := 1 - ColOfDate(DateBase + 1);
      if (DayBase = 1) and (Col + Row = 0) then Dec(DayBase, 7);
      ADaysPerMonth := DaysPerMonth(Year, Month);
      for I := 0 to 6 do
        for J := 0 to 5 do
        begin
          with TextR do
          begin
            Left := R.Left + FSideWidth + I * FColWidth;
            Top := R.Top + FDaysOfWeekHeight + J * FRowHeight;
            Right := Left + FColWidth;
            Bottom := Top + FRowHeight;
          end;

          CurDay := DayBase + J * 7 + I;
          if (CurDay < 1) and (Col + Row <> 0) or
            (CurDay > ADaysPerMonth) and ((Col <> ColCount - 1) or (Row <> RowCount - 1)) then
            ADate := NullDate
          else
            ADate := DateBase + CurDay;
          Selected := (ADate >= SelStart) and (ADate <= SelFinish);

          if ADate = NullDate then
          begin
            Brush.Color := clWindow;
            Windows.FillRect(Handle, TextR, Brush.Handle);
            Continue;
          end;

          SideR := TextR;
          // draw frame around current date
          if ADate = CurDate then
          begin
            Brush.Color := clMaroon;
            FrameRect(TextR);
            InflateRect(TextR, -1, -1);
          end;
          if Selected and UltraFlat then
            Brush.Color := TDummyBarManager(FCombo.BarManager).FlatToolbarsSelColor
          else
            Brush.Color := BrushColors[Flat, Selected];
          // draw text of day's number
          if not Selected and
            (((ADate < FirstDate) and (Col + Row = 0)) or
             ((ADate > ALastDate) and
              (Col = ColCount - 1) and (Row = RowCount - 1))) then
            SetTextColor(Handle, GetSysColor(COLOR_GRAYTEXT))
          else
            SetTextColor(Handle, GetSysColor(FontColors[Selected and not UltraFlat]));

          S := IntToStr(GetDateElement(ADate, 3));
          GetTextExtentPoint32(Handle, PChar(S), Length(S), Size);
          with SideR do
            ExtTextOut(Handle,
              Right - 3 - Size.cX, (Top + Bottom - Size.cY) div 2,
              ETO_OPAQUE, @TextR, PChar(S), Length(S), nil);
        end;
    end;
  end;

  procedure DrawButton(R: TRect; ACaption: string; Pressed: Boolean);
  var
    l_Size: TSize;
    l_Offset: Integer;
  begin
    ExcludeRect(R);
    l_Offset := 0;
    with Canvas, R do
    begin
      if UltraFlat then
      begin
        Windows.FrameRect(Handle, R, GetSysColorBrush(COLOR_BTNSHADOW));
        InflateRect(R, -1, -1);
        Windows.FrameRect(Handle, R, GetSysColorBrush(COLOR_BTNFACE));
        InflateRect(R, -1, -1);
      end
      else
      begin
        if Pressed then
        begin
          DrawFrameControl(Handle, R, DFC_BUTTON, DFCS_BUTTONPUSH or DFCS_PUSHED);
          l_Offset := 1;
        end
        else
        begin
          Pen.Color := clBtnText;
          MoveToEx(Handle, Left, Bottom - 1, nil);
          Windows.LineTo(Handle, Right - 1, Bottom - 1);
          Windows.LineTo(Handle, Right - 1, Top);
          Pen.Color := clBtnFace;
          Windows.LineTo(Handle, Left, Top);
          Windows.LineTo(Handle, Left, Bottom - 1);
          Pen.Color := clBtnShadow;
          MoveToEx(Handle, Left + 1, Bottom - 2, nil);
          Windows.LineTo(Handle, Right - 2, Bottom - 2);
          Windows.LineTo(Handle, Right - 2, Top + 1);
          Pen.Color := clBtnHighlight;
          Windows.MoveToEx(Handle, Left + 1, Bottom - 3, nil);
          Windows.LineTo(Handle, Left + 1, Top + 1);
          Windows.LineTo(Handle, Right - 2, Top + 1);
          SetPixel(Handle, Right - 2, Top + 1, GetSysColor(COLOR_BTNFACE));
        end;
        InflateRect(R, -2, -2);
      end;
      // draw button's caption
      GetTextExtentPoint32(Handle, PChar(ACaption), Length(ACaption), l_Size);
      SetTextColor(Handle, GetSysColor(COLOR_BTNTEXT));
      SetBkColor(Handle, GetSysColor(COLOR_BTNFACE));
      ExtTextOut(Handle, (Left + Right - l_Size.cX) div 2 + l_Offset,
        (Top + Bottom - l_Size.cY) div 2 + l_Offset, ETO_CLIPPED or ETO_OPAQUE, @R,
        PChar(ACaption), Length(ACaption), nil);
    end;
  end;

begin
  CurDate := Date;
  ALastDate := LastDate;
  Region := CreateRectRgnIndirect(ClientRect);
  with Canvas do
  begin
    for I := 0 to RowCount - 1 do
      for J := 0 to ColCount - 1 do DrawMonth(J, I);
    if IsPopup and ShowButtonsArea then
    begin
      Pen.Color := clBtnShadow;
      MoveTo(FSideWidth, ClientHeight - FButtonsRegionHeight - 1);
      LineTo(ClientWidth - FSideWidth, PenPos.Y);
      with PenPos do
        ExcludeRect(Rect(FSideWidth, Y, X, Y + 1));
      // draw today and clear buttons
      if ShowTodayButton then
        DrawButton(GetTodayButtonRect, sdxBarDatePopupToday,
          FTodayButtonActive and FTodayButtonPressed);
      if ShowClearButton then
        DrawButton(GetClearButtonRect, sdxBarDatePopupClear,
          FClearButtonActive and FClearButtonPressed);
    end;
    Brush.Color := clWindow;
    PaintRgn(Handle, Region);
    DeleteObject(Region);
  end;
end;

procedure TdxBarDateNavigator.SetSize;
begin
  Width := GetWidth;
  Height := GetHeight;
end;

function TdxBarDateNavigator.GetWidth: Integer;
var
  WR, CR: TRect;
begin
  GetWindowRect(Handle, WR);
  OffsetRect(WR, -WR.Left, -WR.Top);
  Windows.GetClientRect(Handle, CR);
  Result := WR.Right - CR.Right + 2 * FSideWidth + 7 * FColWidth;
end;

function TdxBarDateNavigator.GetHeight: Integer;
var
  WR, CR: TRect;
begin
  GetWindowRect(Handle, WR);
  OffsetRect(WR, -WR.Left, -WR.Top);
  Windows.GetClientRect(Handle, CR);
  Result := WR.Bottom - CR.Bottom +
    FHeaderHeight + Byte(not Flat) + FDaysOfWeekHeight + 6 * FRowHeight + 1;
  if IsPopup and ShowButtonsArea then
    Inc(Result, FButtonsRegionHeight);
end;

{ TdxBarDateCombo }

constructor TdxBarDateCombo.Create(AOwner: TComponent);
begin
  inherited;
  Glyph.LoadFromResourceName(HInstance, 'DXBARDATECOMBO');
  FShowTodayButton := True;
  FShowClearButton := True;
  Date := SysUtils.Date;
  FDatePopup := TdxBarDateNavigator.Create(Self);
  with FDatePopup do
  begin
    FCombo := Self;
    IsPopup := True;
  end;
end;

destructor TdxBarDateCombo.Destroy;
begin
  FDatePopup.Free;
  inherited;
end;

function TdxBarDateCombo.GetCurDate: TDateTime;
begin
  Result := GetDateOfText(CurText);
end;

function TdxBarDateCombo.GetDate: TDateTime;
begin
  Result := GetDateOfText(Text);
end;

procedure TdxBarDateCombo.SetCurDate(Value: TDateTime);
begin
  CurText := GetDateText(Value);
end;

procedure TdxBarDateCombo.SetDate(Value: TDateTime);
begin
  Text := GetDateText(Value);
end;

procedure TdxBarDateCombo.DateChanged(Sender: TObject);
begin
  if (CurItemLink <> nil) and (CurItemLink.RealItemLink <> nil) then
  begin
    CurItemLink.RealItemLink.BringToTopInRecentList(True);
    BarManager.HideAll;
  end;  
  Date := TdxBarDateNavigator(Sender).SelStart;
end;

procedure TdxBarDateCombo.DialogClick(Sender: TObject);
begin
  case TWinControl(Sender).Tag of
    1: FDateNavigator.SelStart := SysUtils.Date;
    2: FDateNavigator.SelStart := NullDate;
  end;
  DialogDateChanged(nil);
end;

procedure TdxBarDateCombo.DialogDateChanged(Sender: TObject);
begin
  FDateEdit.Text := GetDateText(FDateNavigator.SelStart);
end;

procedure TdxBarDateCombo.DialogDateEditChange(Sender: TObject);
var
  ADate: TDateTime;
begin
  ADate := GetDateOfText(FDateEdit.Text);
  if (ADate <> NullDate) or (FDateEdit.Text = '') then
    FDateNavigator.SelStart := ADate;
end;

function TdxBarDateCombo.GetDateOfText(AText: string): TDateTime;
var
  P: Integer;
begin
  P := Pos(' ', AText);
  if P > 0 then Delete(AText, 1, P);
  Result := TextToDate(AText);
end;

function TdxBarDateCombo.GetDateText(ADate: TDateTime): string;
begin
  if ADate = NullDate then
    Result := ''
  else
  begin
    Result := 'ddd ';
    Result := FormatDateTime(Result, ADate) + DateToText(ADate);
  end;
end;

function TdxBarDateCombo.CheckKeyForDropDownWindow(Key: Word; Shift: TShiftState): Boolean;
begin
  Result := (Key = VK_RETURN) or
    inherited CheckKeyForDropDownWindow(Key, Shift);
end;

procedure TdxBarDateCombo.CloseUp;
begin
  with FDatePopup do
    if IsWindowVisible(Handle) then
    begin
      if GetCapture = Handle then ReleaseCapture;
      DeactivateAll;
    end;
  inherited;
  FDatePopup.Parent := nil;
end;

procedure TdxBarDateCombo.DropDown(X, Y: Integer);
var
  ADate: TDateTime;
begin
  with FDatePopup do
  begin
    ADate := Date;
    if ADate = NullDate then ADate := SysUtils.Date;
    FirstDate := ADate;
    SelStart := ADate;
    OnDateTimeChanged := DateChanged;
    ShowTodayButton := Self.ShowTodayButton;
    ShowClearButton := Self.ShowClearButton;
    Parent := BarManager.MainForm;
  end; 
  inherited;
end;

function TdxBarDateCombo.GetDropDownWindow: HWND;
begin
  Result := inherited GetDropDownWindow;
  if Result = 0 then Result := FDatePopup.Handle;
end;

procedure TdxBarDateCombo.SetText(Value: string);
begin
  Value := GetDateText(GetDateOfText(Value));
  inherited;
end;

procedure TdxBarDateCombo.DoClick;
var
  ButtonOk, ButtonCancel, ButtonToday, ButtonClear: TButton;
  W, H, D: Integer;
begin
  inherited;
  if not Assigned(OnClick) and not ReadOnly then
  begin
    FForm := TForm.Create(nil);
    with FForm do
    begin
      BorderStyle := bsDialog;
      Caption := LoadStr(DXBAR_DATEDIALOGCAPTION);
      Font := BarManager.Font;
      Position := poScreenCenter;

      FDateEdit := TEdit.Create(FForm);
      with FDateEdit do
      begin
        Parent := FForm;
        OnChange := DialogDateEditChange;
        HandleNeeded;
      end;
      FDateNavigator := TdxBarDateNavigator.Create(FForm);
      with FDateNavigator do
      begin
        Style := cs3D;
        FCombo := Self;
        Parent := FForm;
        Visible := True;
        OnDateTimeChanged := DialogDateChanged;
        HandleNeeded;
      end;
      ButtonOk := TButton.Create(FForm);
      with ButtonOk do
      begin
        Caption := LoadStr(DXBAR_DIALOGOK);
        Default := True;
        ModalResult := mrOk;
        Parent := FForm;
      end;
      ButtonCancel := TButton.Create(FForm);
      with ButtonCancel do
      begin
        Caption := LoadStr(DXBAR_DIALOGCANCEL);
        Cancel := True;
        ModalResult := mrCancel;
        Parent := FForm;
      end;
      if ShowTodayButton then
      begin
        ButtonToday := TButton.Create(FForm);
        with ButtonToday do
        begin
          Caption := sdxBarDatePopupToday;
          Parent := FForm;
          Tag := 1;
          OnClick := DialogClick;
        end;
      end
      else
        ButtonToday := nil;
      if ShowClearButton then
      begin
        ButtonClear := TButton.Create(FForm);
        with ButtonClear do
        begin
          Caption := sdxBarDatePopupClear;
          Parent := FForm;
          Tag := 2;
          OnClick := DialogClick;
        end;
      end
      else
        ButtonClear := nil;

      W := MulDiv(FDateNavigator.FTodayButtonWidth, 3, 2);
      H := MulDiv(FDateNavigator.FButtonsHeight, 7, 6);
      D := FDateNavigator.FButtonsHeight div 4;

      ClientWidth := D + FDateNavigator.Width + D + W + D;
      ClientHeight := D + FDateEdit.Height + D + FDateNavigator.Height + D;
      FDateEdit.SetBounds(D, D, FDateNavigator.Width, FDateEdit.Height);
      FDateNavigator.SetBounds(D, FDateEdit.Top + FDateEdit.Height + D, 0, 0);
      ButtonOk.SetBounds(FDateEdit.Left + FDateEdit.Width + D, D, W, H);
      ButtonCancel.SetBounds(ButtonOk.Left, ButtonOk.Top + ButtonOk.Height + D, W, H);
      if ButtonToday <> nil then
        ButtonToday.SetBounds(ButtonOk.Left, ClientHeight - D - H - D - H, W, H);
      if ButtonClear <> nil then
        ButtonClear.SetBounds(ButtonOk.Left, ClientHeight - D - H, W, H);

      FDateEdit.Text := GetDateText(Date);
      if ShowModal = mrOk then
        Date := GetDateOfText(FDateEdit.Text);
      Free;
    end;
  end;
end;

{ TdxBarDateComboControl }

function TdxBarDateComboControl.GetDate: TDateTime;
begin
  Result := Item.GetDateOfText(Text);
end;

function TdxBarDateComboControl.GetItem: TdxBarDateCombo;
begin
  Result := TdxBarDateCombo(ItemLink.Item);
end;

procedure TdxBarDateComboControl.SetDate(const Value: TDateTime);
begin
  Text := Item.GetDateText(Value);
end;

procedure TdxBarDateComboControl.WndProc(var Message: TMessage);
begin
  with Message do
    if Msg = WM_CHAR then
      case wParam of
        Ord('+'):
          begin
            if Date <> NullDate then Date := Date + 1;
            wParam := 0;
          end;
        Ord('-'):
          begin
            if Date <> NullDate then Date := Date - 1;
            wParam := 0;
          end;
      end;
  inherited;
end;

{$IFNDEF DELPHI6}

{ TdxBarTreeNode }

destructor TdxBarTreeNode.Destroy;
begin
  if Owner.Owner <> nil then
    TdxBarTreeView(Owner.Owner).Delete(Self);
  inherited;
end;

{$ENDIF}

{ TdxBarTreeView }

constructor TdxBarTreeView.Create(AOwner: TComponent);
begin
  inherited;
  Visible := False;
  ReadOnly := True;
  SetBounds(0, 0, 150, 200);
end;

destructor TdxBarTreeView.Destroy;
var
  I: Integer;
begin
  for I := Items.Count - 1 downto 0 do Items[I].Free;
  inherited;
end;

function TdxBarTreeView.FindNode(const AText: string): TTreeNode;
var
  ANode: TTreeNode;

  function FindOne(ARootNode: TTreeNode): TTreeNode;
  var
    ANode: TTreeNode;
  begin
    if AnsiCompareText(AText, ARootNode.Text) = 0 then Result := ARootNode
    else
    begin
      Result := nil;
      ANode := ARootNode.GetFirstChild;
      while ANode <> nil do
      begin
        Result := FindOne(ANode);
        if Result <> nil then Exit;
        ANode := ARootNode.GetNextChild(ANode);
      end;
    end;
  end;

begin
  Result := nil;
  with Items do
  begin
    ANode := GetFirstNode;
    while ANode <> nil do
    begin
      Result := FindOne(ANode);
      if Result <> nil then Break;
      ANode := ANode.GetNext;
    end;
  end;
end;

procedure TdxBarTreeView.SaveAndHide;
begin
  if (Selected <> nil) and FCombo.DoCanSelectNode then
    if IsPopup then
    begin
      with FCombo do
      begin
        if (CurItemLink <> nil) and (CurItemLink.RealItemLink <> nil) then
          CurItemLink.RealItemLink.BringToTopInRecentList(True);
        BarManager.HideAll;
      end;
      FCombo.SelectedNode := Selected;
    end
    else
    begin
      FCombo.Text := Selected.Text;
      FCombo.FForm.ModalResult := mrOk;
    end;
end;

procedure TdxBarTreeView.TVMSetImageList(var Message: TMessage);
begin
  inherited;
  if IsPopup then FCombo.UpdateEx;//DoImageListChanged;
end;

procedure TdxBarTreeView.TVMSetItem(var Message: TMessage);
begin
  inherited;
  if (FCombo.SelectedNode <> nil) and
    (PTVItem(Message.lParam)^.hitem = FCombo.SelectedNode.ItemId) then
    FCombo.DoSelectedNodeChanged;
end;

procedure TdxBarTreeView.WMCaptureChanged(var Message: TMessage);
begin
  inherited;
  if FCloseButtonIsTracking then
  begin
    FCloseButtonIsTracking := False;
    FMouseAboveCloseButton := False;
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TdxBarTreeView.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  inherited;
  Message.MinMaxInfo^.ptMinTrackSize := Point(100, 100);
end;

procedure TdxBarTreeView.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  if FCloseButtonIsTracking then
  begin
    FCloseButtonIsTracking := False;
    ReleaseCapture;
    if FMouseAboveCloseButton then
      FCombo.BarManager.HideAll
    else
      SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TdxBarTreeView.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  if IsPopup then
    dxBarPopupNCCalcSize(Handle, Message.CalcSize_Params^.rgrc[0],
      FCorner, FCombo, FCombo.AllowResizing);
end;

procedure TdxBarTreeView.WMNCHitTest(var Message: TWMNCHitTest);
var
  PrevMouseAboveCloseButton: Boolean;
begin
  inherited;
  with Message do
    if PtInRect(FGripRect, SmallPointToPoint(Pos)) then
      Result := GetHitTestByCorner(FCorner)
    else
    begin
      PrevMouseAboveCloseButton := FMouseAboveCloseButton;
      FMouseAboveCloseButton := (GetTopWindow(0) = Handle) and
        ((GetCapture = 0) or FCloseButtonIsTracking) and
        PtInRect(FCloseButtonRect, SmallPointToPoint(Pos));
      if FMouseAboveCloseButton then Result := HTBORDER;
      if PrevMouseAboveCloseButton <> FMouseAboveCloseButton then
        SendMessage(Handle, WM_NCPAINT, 0, 0);
    end;
end;

procedure TdxBarTreeView.WMNCLButtonDown(var Message: TWMNCLButtonDown);
begin
  inherited;
  if FMouseAboveCloseButton then
  begin
    FCloseButtonIsTracking := True;
    SetCapture(Handle);
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TdxBarTreeView.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  if IsPopup then
    dxBarPopupNCPaint(Handle, FCombo.AllowResizing, FCombo.Flat,
      FMouseAboveCloseButton, FCloseButtonIsTracking,
      FCloseButtonRect, FGripRect, FCorner);
end;

procedure TdxBarTreeView.WMSysColorChange(var Message: TWMSysColorChange);
begin
  inherited;
  RecreateWnd;
end;

procedure TdxBarTreeView.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if FMouseAboveCloseButton then
  begin
    FMouseAboveCloseButton := False;
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TdxBarTreeView.CNNotify(var Message: TWMNotify);
begin
  case Message.NMHdr^.code of
    TVN_DELETEITEM:
      if FCombo.SelectedNode <> nil then
        with PNMTreeView(Pointer(Message.NMHdr))^ do
          if itemOld.hItem = FCombo.SelectedNode.ItemId then
            FCombo.FSelectedNode := nil;
  end;
  inherited;
end;

procedure TdxBarTreeView.Change(Node: TTreeNode);
begin
  inherited;
  if (FCombo.FocusedItemLink <> nil) and IsPopup and (Node <> nil) then
    FCombo.CurText := Node.Text;
end;

{$IFNDEF DELPHI6}

function TdxBarTreeView.CreateNode: TTreeNode;
begin
  Result := TdxBarTreeNode.Create(Items);
end;

{$ENDIF}

procedure TdxBarTreeView.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    if csDesigning in FCombo.ComponentState then
      Style := Style and not WS_CHILD or WS_POPUP;
    if IsPopup then
    begin
      ExStyle := ExStyle and not WS_EX_CLIENTEDGE or WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
      WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    end;
  end;
end;

procedure TdxBarTreeView.CreateWnd;
begin
  inherited;
  if IsPopup then
  begin
    Windows.SetParent(Handle, 0);
    CallWindowProc(DefWndProc, Handle, WM_SETFOCUS, 0, 0);
  end;
end;

procedure TdxBarTreeView.DblClick;
var
  P: TPoint;
begin
  inherited;
  if FCombo.ChooseByDblClick then
  begin
    GetCursorPos(P);
    Windows.ScreenToClient(Handle, P);
    if GetHitTestInfoAt(P.X, P.Y) * [htOnItem, htOnIcon, htOnLabel, htOnStateIcon] <> [] then
      SaveAndHide;
  end;
end;

procedure TdxBarTreeView.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then SaveAndHide;
end;

procedure TdxBarTreeView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if not FCombo.ChooseByDblClick and
    (GetHitTestInfoAt(X, Y) * [htOnItem, htOnIcon, htOnLabel, htOnStateIcon] <> []) then
    SaveAndHide;
end;

{ TdxBarTreeViewCombo }

constructor TdxBarTreeViewCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Glyph.LoadFromResourceName(HInstance, 'DXBARTREEVIEWCOMBO');
  ShowEditor := False;
  FAllowResizing := True;
  FChooseByDblClick := True;
  FShowImageInEdit := True;
  FTreeView := TdxBarTreeView.Create(Self);
  with TdxBarTreeView(FTreeView) do
  begin
    IsPopup := True;
    FCombo := Self;
    if not (csDesigning in Self.ComponentState) then
      Parent := BarManager.MainForm;
  end;
end;

destructor TdxBarTreeViewCombo.Destroy;
begin
  if FTreeView <> nil then FTreeView.Free;
  inherited;
end;

function TdxBarTreeViewCombo.GetDropDownHeight: Integer;
begin
  Result := FTreeView.Height;
end;

function TdxBarTreeViewCombo.GetDropDownWidth: Integer;
begin
  Result := FTreeView.Width;
end;

function TdxBarTreeViewCombo.GetImages: TCurImageList;
begin
  Result := FTreeView.Images;
end;

function TdxBarTreeViewCombo.GetIndent: Integer;
begin
  Result := FTreeView.Indent;
end;

function TdxBarTreeViewCombo.GetItems: TTreeNodes;
begin
  Result := FTreeView.Items;
end;

function TdxBarTreeViewCombo.GetShowButtons: Boolean;
begin
  Result := FTreeView.ShowButtons;
end;

function TdxBarTreeViewCombo.GetShowLines: Boolean;
begin
  Result := FTreeView.ShowLines;
end;

function TdxBarTreeViewCombo.GetShowRoot: Boolean;
begin
  Result := FTreeView.ShowRoot;
end;

function TdxBarTreeViewCombo.GetSortType: TSortType;
begin
  Result := FTreeView.SortType;
end;

function TdxBarTreeViewCombo.GetStateImages: TCurImageList;
begin
  Result := FTreeView.StateImages;
end;

function TdxBarTreeViewCombo.GetOnExpanded: TTVExpandedEvent;
begin
  Result := FTreeView.OnExpanded;
end;

function TdxBarTreeViewCombo.GetOnExpanding: TTVExpandingEvent;
begin
  Result := FTreeView.OnExpanding;
end;

function TdxBarTreeViewCombo.GetOnChanging: TTVChangingEvent;
begin
  Result := FTreeView.OnChanging;
end;

function TdxBarTreeViewCombo.GetOnCollapsed: TTVExpandedEvent;
begin
  Result := FTreeView.OnCollapsed;
end;

function TdxBarTreeViewCombo.GetOnCollapsing: TTVCollapsingEvent;
begin
  Result := FTreeView.OnCollapsing;
end;

function TdxBarTreeViewCombo.GetOnCompare: TTVCompareEvent;
begin
  Result := FTreeView.OnCompare;
end;

function TdxBarTreeViewCombo.GetOnGetImageIndex: TTVExpandedEvent;
begin
  Result := FTreeView.OnGetImageIndex;
end;

function TdxBarTreeViewCombo.GetOnGetSelectedIndex: TTVExpandedEvent;
begin
  Result := FTreeView.OnGetSelectedIndex;
end;

function TdxBarTreeViewCombo.GetOnTreeViewChange: TTVChangedEvent;
begin
  Result := FTreeView.OnChange;
end;

procedure TdxBarTreeViewCombo.SetDropDownHeight(Value: Integer);
begin
  if Value < 100 then Value := 100;
  FTreeView.Height := Value;
end;

procedure TdxBarTreeViewCombo.SetDropDownWidth(Value: Integer);
begin
  if Value < 100 then Value := 100;
  FTreeView.Width := Value;
end;

procedure TdxBarTreeViewCombo.SetImages(Value: TCurImageList);
begin
  FTreeView.Images := Value;
end;

procedure TdxBarTreeViewCombo.SetIndent(Value: Integer);
begin
  FTreeView.Indent := Value;
end;

procedure TdxBarTreeViewCombo.SetItems(Value: TTreeNodes);
begin
  FTreeView.Items := Value;
end;

procedure TdxBarTreeViewCombo.SetSelectedNode(Value: TTreeNode);
begin
  if FSelectedNode <> Value then
  begin
    FSelectedNode := Value;
    DoSelectedNodeChanged;
  end;  
end;

procedure TdxBarTreeViewCombo.SetShowButtons(Value: Boolean );
begin
  FTreeView.ShowButtons := Value;
end;

procedure TdxBarTreeViewCombo.SetShowImageInEdit(Value: Boolean);
begin
  if FShowImageInEdit <> Value then
  begin
    FShowImageInEdit := Value;
    if (Images <> nil) or (StateImages <> nil) then UpdateEx;
  end;
end;

procedure TdxBarTreeViewCombo.SetShowLines(Value: Boolean);
begin
  FTreeView.ShowLines := Value;
end;

procedure TdxBarTreeViewCombo.SetShowRoot(Value: Boolean);
begin
  FTreeView.ShowRoot := Value;
end;

procedure TdxBarTreeViewCombo.SetSortType(Value: TSortType);
begin
  FTreeView.SortType := Value;
end;

procedure TdxBarTreeViewCombo.SetStateImages(Value: TCurImageList);
begin
  FTreeView.StateImages := Value;
end;

procedure TdxBarTreeViewCombo.SetOnExpanded(Value: TTVExpandedEvent);
begin
  FTreeView.OnExpanded := Value;
end;

procedure TdxBarTreeViewCombo.SetOnExpanding(Value: TTVExpandingEvent);
begin
  FTreeView.OnExpanding := Value;
end;

procedure TdxBarTreeViewCombo.SetOnChanging(Value: TTVChangingEvent);
begin
  FTreeView.OnChanging := Value;
end;

procedure TdxBarTreeViewCombo.SetOnCollapsed(Value: TTVExpandedEvent);
begin
  FTreeView.OnCollapsed := Value;
end;

procedure TdxBarTreeViewCombo.SetOnCollapsing(Value: TTVCollapsingEvent);
begin
  FTreeView.OnCollapsing := Value;
end;

procedure TdxBarTreeViewCombo.SetOnCompare(Value: TTVCompareEvent);
begin
  FTreeView.OnCompare := Value;
end;

procedure TdxBarTreeViewCombo.SetOnGetImageIndex(Value: TTVExpandedEvent);
begin
  FTreeView.OnGetImageIndex := Value;
end;

procedure TdxBarTreeViewCombo.SetOnGetSelectedIndex(Value: TTVExpandedEvent);
begin
  FTreeView.OnGetSelectedIndex := Value;
end;

procedure TdxBarTreeViewCombo.SetOnTreeViewChange(Value: TTVChangedEvent);
begin
  FTreeView.OnChange := Value;
end;

procedure TdxBarTreeViewCombo.FormSize(Sender: TObject);
var
  H, W, D: Integer;
begin
  W := 12 * FForm.Canvas.TextWidth('0');
  H := MulDiv(FForm.Canvas.TextHeight('0'), 5, 3);
  D := H div 4;

  with FFormTreeView do
  begin
    Left := D;
    Top := D;
    Width := FForm.ClientWidth - (D + D + W + D);
    Height := FForm.ClientHeight - (D + D);
  end;
  FButtonOk.SetBounds(FForm.ClientWidth - D - W, D, W, H);
  FButtonCancel.SetBounds(FButtonOk.Left, FButtonOk.Top + FButtonOk.Height + D, W, H);
end;

function TdxBarTreeViewCombo.CheckKeyForDropDownWindow(Key: Word; Shift: TShiftState): Boolean;
begin
  Result := (Key = VK_RETURN) or inherited CheckKeyForDropDownWindow(Key, Shift);
end;

function TdxBarTreeViewCombo.DoCanSelectNode: Boolean;
begin
  Result := True;
  if Assigned(FOnCanSelectNode) then
    FOnCanSelectNode(Self, TreeView.Selected, Result);
end;

procedure TdxBarTreeViewCombo.DoSelectedNodeChanged;
var
  AText: string;
begin
  FInSelectedNodeChanged := True;
  try
    if SelectedNode = nil then
      AText := ''
    else
      AText := SelectedNode.Text;
    if Text = AText then
      Change
    else
      Text := AText;
    Update;
  finally
    FInSelectedNodeChanged := False;
  end;
end;

procedure TdxBarTreeViewCombo.DrawInterior(ACanvas: TCanvas; R: TRect; ItemLink: TdxBarItemLink);
var
  DC: HDC;
  ANode: TTreeNode;
  AIndex: Integer;
  S: string;
begin
  if not HasImageInEdit then
    inherited
  else
  begin
    if FocusedItemLink = ItemLink then
    begin
      ACanvas.Lock;
      try
        ANode := FTreeView.Selected
      finally
        ACanvas.Unlock;
      end;
    end
    else
      ANode := SelectedNode;
    DC := ACanvas.Handle;
    FillRect(DC, R, ACanvas.Brush.Handle);
    with R do
    begin
      Inc(Left);
      if (StateImages <> nil) and (ANode <> nil) and
        (0 <= ANode.StateIndex) and (ANode.StateIndex < StateImages.Count) then
        with StateImages do
        begin
          Draw(ACanvas, Left, (Top + Bottom - Height) div 2, ANode.StateIndex);
          Inc(Left, Width);
        end;
      if Images <> nil then
        with Images do
        begin
          if ANode = nil then
            AIndex := -1
          else
            if (0 <= ANode.SelectedIndex) and (ANode.SelectedIndex < Count) then
              AIndex := ANode.SelectedIndex
            else
              if (0 <= ANode.ImageIndex) and (ANode.ImageIndex < Count) then
                AIndex := ANode.ImageIndex
              else
                AIndex := -1;
          if AIndex <> -1 then
            Draw(ACanvas, Left, (Top + Bottom - Height) div 2, AIndex);
          Inc(Left, Width + 3);
        end;
      if FocusedItemLink <> nil then
        S := CurText
      else
        S := Text;
      //Canvas.TextOut(Left + 2, (Top + Bottom - Canvas.TextHeight(S)) div 2, S);
      Inc(Left, 2);
      Dec(Right, 2);
      DrawText(DC, PChar(S), Length(S), R, DT_SINGLELINE or DT_NOPREFIX or DT_VCENTER);
    end;
  end;
end;

procedure TdxBarTreeViewCombo.DropDown(X, Y: Integer);
begin
  FTreeView.Font.Handle := CloneFont(CurItemLink.BarControl.EditFontHandle);
  if FFullExpand then FTreeView.FullExpand;
  if CurText <> Text then
    FTreeView.Selected := FTreeView.FindNode(CurText);
  if (FTreeView.Selected = nil) and (FTreeView.Items.Count > 0) then
    with FTreeView.Items[0] do
    begin
      Focused := True;
      MakeVisible;
    end;
  inherited;
end;

function TdxBarTreeViewCombo.GetDropDownWindow: HWND;
begin
  Result := inherited GetDropDownWindow;
  if Result = 0 then Result := FTreeView.Handle;
end;

function TdxBarTreeViewCombo.HasImageInEdit: Boolean;
begin
  Result := FShowImageInEdit and ((Images <> nil) or (StateImages <> nil));
end;

procedure TdxBarTreeViewCombo.Loaded;
begin
  inherited;
  Text := FLoadedText;
end;

procedure TdxBarTreeViewCombo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
    if AComponent = FTreeView then FTreeView := nil;
end;

procedure TdxBarTreeViewCombo.SetText(Value: string);
begin
  if Text <> Value then
    if csLoading in ComponentState then FLoadedText := Value
    else
    begin
      if not FInSelectedNodeChanged then
        FSelectedNode := FTreeView.FindNode(Value);
      inherited;
    end;
end;

procedure TdxBarTreeViewCombo.DoClick;
var
  W, H, D, I, J: Integer;
begin
  inherited;
  if Assigned(OnClick) or ReadOnly then Exit;

  FForm := TForm.Create(nil);
  with FForm do
  begin
    if FAllowResizing then
      BorderIcons := []
    else
      BorderStyle := bsDialog;
    Caption := LoadStr(DXBAR_TREEVIEWDIALOGCAPTION);
    Font := BarManager.Font;
    Position := poScreenCenter;

    FFormTreeView := TdxBarTreeView.Create(FForm);
    with FFormTreeView do
    begin
      FCombo := Self;
      Visible := True;
      Parent := FForm;

      Images := FTreeView.Images;
      Indent := FTreeView.Indent;
      Items.Assign(FTreeView.Items);
      ShowButtons := FTreeView.ShowButtons;
      ShowLines := FTreeView.ShowLines;
      ShowRoot := FTreeView.ShowRoot;
      SortType := FTreeView.SortType;
      StateImages := FTreeView.StateImages;

      HandleNeeded;
      while (ClientHeight <> FTreeView.ClientHeight) or
        (ClientWidth <> FTreeView.ClientWidth) do
      begin
        ClientHeight := FTreeView.ClientHeight;
        ClientWidth := FTreeView.ClientWidth;
      end;
    end;
    FButtonOk := TButton.Create(FForm);
    with FButtonOk do
    begin
      Caption := LoadStr(DXBAR_DIALOGOK);
      Default := True;
      ModalResult := mrOk;
      Parent := FForm;
    end;
    FButtonCancel := TButton.Create(FForm);
    with FButtonCancel do
    begin
      Caption := LoadStr(DXBAR_DIALOGCANCEL);
      Cancel := True;
      ModalResult := mrCancel;
      Parent := FForm;
    end;

    Canvas.Font := Font;
    W := 12 * Canvas.TextWidth('0');
    H := MulDiv(Canvas.TextHeight('0'), 5, 3);
    D := H div 4;

    with FFormTreeView do
    begin
      Left := D;
      Top := D;
    end;
    FButtonOk.SetBounds(FFormTreeView.BoundsRect.Right + D, D, W, H);
    FButtonCancel.SetBounds(FButtonOk.Left, FButtonOk.Top + FButtonOk.Height + D, W, H);
    I := D + FFormTreeView.Width + D + W + D;
    J := D + FFormTreeView.Height + D;
    while (I <> ClientWidth) or (J <> ClientHeight) do
    begin
      ClientWidth := I;
      ClientHeight := J;
    end;

    OnResize := FormSize;
    if FFullExpand then FFormTreeView.FullExpand;
    FFormTreeView.Selected := FFormTreeView.FindNode(Text);
    if (FFormTreeView.Selected = nil) and (FFormTreeView.Items.Count > 0) then
      with FFormTreeView.Items[0] do
      begin
        Focused := True;
        MakeVisible;
      end;
    if (ShowModal = mrOk) and (FFormTreeView.Selected <> nil) then
      Text := FFormTreeView.Selected.Text;
    while (FTreeView.ClientHeight <> FFormTreeView.ClientHeight) or
      (FTreeView.ClientWidth <> FFormTreeView.ClientWidth) do
    begin
      FTreeView.ClientHeight := FFormTreeView.ClientHeight;
      FTreeView.ClientWidth := FFormTreeView.ClientWidth;
    end;
    Free;
  end;
end;

{ TdxBarTreeViewComboControl }

function TdxBarTreeViewComboControl.GetItem: TdxBarTreeViewCombo;
begin
  Result := TdxBarTreeViewCombo(ItemLink.Item);
end;

function TdxBarTreeViewComboControl.GetHeight: Integer;
var
  AItem: TdxBarTreeViewCombo;
  Value: Integer;
begin
  Result := inherited GetHeight;
  AItem := Item;
  if not IsVertical(Parent) and AItem.HasImageInEdit then
  begin
    if AItem.Images = nil then
      Value := 0
    else
      Value := AItem.Images.Height;
    if (AItem.StateImages <> nil) and (AItem.StateImages.Height > Value) then
      Value := AItem.StateImages.Height;
    Value := 2 + 1 + Value + 1 + 2;
    if Value > Result then Result := Value;
  end;
end;

procedure TdxBarTreeViewComboControl.SetFocused(Value: Boolean);
begin
  inherited;
  if Value then
    with Item do
      if SelectedNode = nil then
        TreeView.Selected := TreeView.FindNode(Text)
      else
        TreeView.Selected := SelectedNode;
end;

{ TdxBarImageCombo }

constructor TdxBarImageCombo.Create(AOwner: TComponent);
begin
  inherited;
  Glyph.LoadFromResourceName(HInstance, 'DXBARIMAGECOMBO');
  ShowEditor := False;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FShowText := True;
end;

destructor TdxBarImageCombo.Destroy;
begin
  FImageChangeLink.Free;
  inherited;
end;

function TdxBarImageCombo.GetImageIndexes(Index: Integer): Integer;
begin
  Result := Integer(Items.Objects[Index]) - 1;
end;

procedure TdxBarImageCombo.SetImageIndexes(Index: Integer; Value: Integer);
begin
  Items.Objects[Index] := TObject(Value + 1);
  if Index = ItemIndex then Update;
end;

procedure TdxBarImageCombo.SetImages(Value: TCurImageList);
begin
  if FImages <> nil then
    FImages.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if FImages <> nil then
  begin
    FImages.RegisterChanges(FImageChangeLink);
    FImages.FreeNotification(Self);
  end;
  if not (csLoading in ComponentState) then ImagesChanged;
end;

procedure TdxBarImageCombo.SetShowText(Value: Boolean);
begin
  if FShowText <> Value then
  begin
    FShowText := Value;
    Update;
  end
end;

procedure TdxBarImageCombo.ImageListChange(Sender: TObject);
begin
  if not (csLoading in ComponentState) then ImagesChanged;
end;

procedure TdxBarImageCombo.ReadImageIndexes(Reader: TReader);
var
  I: Integer;
begin
  Reader.ReadListBegin;
  for I := 0 to Items.Count - 1 do
    if Reader.EndOfList then Break
    else
      ImageIndexes[I] := Reader.ReadInteger;
  Reader.ReadListEnd;
end;

procedure TdxBarImageCombo.WriteImageIndexes(Writer: TWriter);
var
  I: Integer;
begin
  Writer.WriteListBegin;
  for I := 0 to Items.Count - 1 do
    Writer.WriteInteger(ImageIndexes[I]);
  Writer.WriteListEnd;
end;

procedure TdxBarImageCombo.DialogListBoxDblClick(Sender: TObject);
begin
  FForm.ModalResult := mrOk;
end;

procedure TdxBarImageCombo.DialogListBoxDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  FCanvas := FDialogListBox.Canvas;
  DrawItem(Index, Rect, State);
  FCanvas := nil;
end;

procedure TdxBarImageCombo.DialogListBoxMeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
  FCanvas := FDialogListBox.Canvas;
  MeasureItem(Index, Height);
  FCanvas := nil;
end;

procedure TdxBarImageCombo.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ImageIndexes', ReadImageIndexes, WriteImageIndexes, True);
end;

procedure TdxBarImageCombo.DrawItem(AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
var
  OriginX, AImageIndex: Integer;
  R: TRect;
  S: string;
begin
  if Assigned(OnDrawItem) or (Images = nil) then
    inherited
  else
    with Canvas, ARect do
    begin
      FillRect(ARect);
      with Images do
      begin
        if FShowText then
          OriginX := Left + 1
        else
          OriginX := (Left + Right - Width) div 2;
        R := Bounds(OriginX, (Top + Bottom - Height) div 2, Width, Height);
        if AIndex <> -1 then
        begin
          AImageIndex := ImageIndexes[AIndex];
          if (0 <= AImageIndex) and (AImageIndex < Count) then
            Draw(Canvas, R.Left, R.Top, AImageIndex)
          else
            if FocusedItemLink = nil then R.Right := R.Left;
        end
        else
          if FocusedItemLink = nil then R.Right := R.Left;
      end;
      if FShowText then
      begin
        if AIndex = -1 then
          S := Text
        else
          S := Items[AIndex];
        TextOut(R.Right + 2, (Top + Bottom - TextHeight(S)) div 2, S);
      end;  
      if odFocused in AState then Windows.DrawFocusRect(Handle, ARect); // for hiding focus rect
    end;
end;

procedure TdxBarImageCombo.ImagesChanged;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    if Links[I].Control is TdxBarImageComboControl then
      TdxBarImageComboControl(Links[I].Control).ImagesChanged;
end;

procedure TdxBarImageCombo.MeasureItem(AIndex: Integer; var AHeight: Integer);
begin
  if Assigned(OnMeasureItem) then inherited
  else
  begin
    inherited;
    if (Images <> nil) and (1 + Images.Height + 1 > AHeight) then
      AHeight := 1 + Images.Height + 1;
  end;
end;

procedure TdxBarImageCombo.MeasureItemWidth(AIndex: Integer; var AWidth: Integer);
begin
  inherited;
  if Images <> nil then
  begin
    if not FShowText then AWidth := 0;
    Inc(AWidth, 1 + Images.Width + 1);
  end;
end;

procedure TdxBarImageCombo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Images) then Images := nil;
end;

procedure TdxBarImageCombo.DoClick;
var
  W, H, D, C: Integer;
  FButtonOk, FButtonCancel: TButton;
begin
  inherited;
  if Assigned(OnClick) or ReadOnly then Exit;

  FForm := TForm.Create(nil);
  with FForm do
  begin
    BorderStyle := bsDialog;
    Caption := LoadStr(DXBAR_IMAGEDIALOGCAPTION);
    Font := BarManager.Font;
    Position := poScreenCenter;

    Canvas.Font := Font;
    W := 12 * Canvas.TextWidth('0');
    H := MulDiv(Canvas.TextHeight('0'), 5, 3);
    D := H div 4;

    FDialogListBox := TListBox.Create(FForm);
    with FDialogListBox do
    begin
      Parent := FForm;
      Items.Assign(Self.Items);
      FCanvas := Canvas;
      if Items.Count < DropDownCount then C := Items.Count
      else C := DropDownCount;
      ClientHeight := ItemsHeight[0] * C;
      if Height < H + D + H then Height := H + D + H;
      ClientWidth := GetDropDownWidth - (2 + 2);
      FCanvas := nil;
      Style := lbOwnerDrawVariable;
      OnDblClick := DialogListBoxDblClick;
      OnDrawItem := DialogListBoxDrawItem;
      OnMeasureItem := DialogListBoxMeasureItem;
    end;
    FButtonOk := TButton.Create(FForm);
    with FButtonOk do
    begin
      Caption := LoadStr(DXBAR_DIALOGOK);
      Default := True;
      ModalResult := mrOk;
      Parent := FForm;
    end;
    FButtonCancel := TButton.Create(FForm);
    with FButtonCancel do
    begin
      Caption := LoadStr(DXBAR_DIALOGCANCEL);
      Cancel := True;
      ModalResult := mrCancel;
      Parent := FForm;
    end;

    ClientWidth := D + FDialogListBox.Width + D + W + D;
    ClientHeight := D + FDialogListBox.Height + D;
    with FDialogListBox do
    begin
      Left := D;
      Top := D;
    end;
    FButtonOk.SetBounds(ClientWidth - D - W, D, W, H);
    FButtonCancel.SetBounds(FButtonOk.Left, FButtonOk.Top + FButtonOk.Height + D, W, H);

    FDialogListBox.ItemIndex := ItemIndex;
    if ShowModal = mrOk then ItemIndex := FDialogListBox.ItemIndex;
    Free;
  end;
end;

{ TdxBarImageComboControl }

function TdxBarImageComboControl.GetHeight: Integer;
var
  AItem: TdxBarImageCombo;
  Value: Integer;
begin
  Result := inherited GetHeight;
  AItem := TdxBarImageCombo(Item);
  if not IsVertical(Parent) and (AItem.Images <> nil) then
  begin
    Value := 2 + 1 + AItem.Images.Height + 1 + 2;
    if Value > Result then Result := Value;
  end;
end;

procedure TdxBarImageComboControl.ImagesChanged;
begin
  Parent.RepaintBar;
end;

{ TdxBarToolbarsListItem }

function TdxBarToolbarsListItem.HasDesignTimeLinks: Boolean;
begin
  Result := False;
end;

{ TdxBarToolbarsListItemControl }

procedure TdxBarToolbarsListItemControl.CreateSubMenuControl;
begin
  if BarManager.IsCustomizing then Exit;
  ClearInternalItemList;
  Item.ItemLinks.Clear;
  BarManager.CreateToolbarsPopupList(Item.ItemLinks);
  Item.ItemLinks.BarControl := TdxBarSubMenuControl.Create(BarManager);
  SubMenuControl.ItemLinks := Item.ItemLinks;
end;

{ TdxBarSpinEdit }

constructor TdxBarSpinEdit.Create(AOwner: TComponent);
begin
  inherited;
  FIncrement := 1;
  FPrefixPlace := ppEnd;
  Text := '0';
end;

function TdxBarSpinEdit.GetCurValue: Extended;
begin
  Result := TextToValue(CurText);
end;

function TdxBarSpinEdit.GetIntCurValue: Integer;
begin
  Result := Trunc(CurValue);
end;

function TdxBarSpinEdit.GetIntValue: Integer;
begin
  Result := Trunc(Value);
end;

function TdxBarSpinEdit.GetValue: Extended;
begin
  Result := TextToValue(Text);
end;

procedure TdxBarSpinEdit.SetCurValue(Value: Extended);
begin
  Value := GetCheckedValue(Value);
  if CurValue <> Value then CurText := ValueToText(Value);
end;

procedure TdxBarSpinEdit.SetIncrement(Value: Extended);
begin
  PrepareValue(Value);
  case FValueType of
    svtInteger:
      if Value < 1 then Value := 1;
    svtFloat:
      if Value <= 0 then Value := 1;
  end;
  FIncrement := Value;
end;

procedure TdxBarSpinEdit.SetIntCurValue(Value: Integer);
begin
  CurValue := Value;
end;

procedure TdxBarSpinEdit.SetIntValue(Value: Integer);
begin
  Self.Value := Value;
end;

procedure TdxBarSpinEdit.SetMaxValue(Value: Extended);
begin
  PrepareValue(Value);
  if FMaxValue <> Value then
  begin
    FMaxValue := Value;
    if FMinValue > FMaxValue then FMinValue := FMaxValue;
    Self.Value := GetCheckedValue(Self.Value);
    CurValue := GetCheckedValue(CurValue);
  end;
end;

procedure TdxBarSpinEdit.SetMinValue(Value: Extended);
begin
  PrepareValue(Value);
  if FMinValue <> Value then
  begin
    FMinValue := Value;
    if FMaxValue < FMinValue then FMaxValue := FMinValue;
    Self.Value := GetCheckedValue(Self.Value);
    CurValue := GetCheckedValue(CurValue);
  end;
end;

procedure TdxBarSpinEdit.SetPrefix(const Value: string);
var
  AValue: Extended;
begin
  AValue := Self.Value;
  if FPrefix <> Value then
  begin
    FPrefix := Value;
    Text := ValueToText(AValue);
  end;
end;

procedure TdxBarSpinEdit.SetPrefixPlace(Value: TdxBarSpinEditPrefixPlace);
begin
  if FPrefixPlace <> Value then
  begin
    FPrefixPlace := Value;
    Text := ValueToText(Self.Value);
  end;
end;

procedure TdxBarSpinEdit.SetValue(Value: Extended);
begin
  Value := GetCheckedValue(Value);
  if Self.Value <> Value then Text := ValueToText(Value);
end;

procedure TdxBarSpinEdit.SetValueType(Value: TdxBarSpinEditValueType);
var
  PrevValue, PrevCurValue: Extended;
begin
  if FValueType <> Value then
  begin
    PrevValue := Self.Value;
    PrevCurValue := Self.CurValue;
    FValueType := Value;
    if Value = svtInteger then
    begin
      Increment := Increment;
      MinValue := MinValue;
      MaxValue := MaxValue;
      Self.Value := PrevValue;
      CurValue := PrevCurValue;
    end;
  end;
end;

function TdxBarSpinEdit.IsIncrementStored: Boolean;
begin
  Result := FIncrement <> 1;
end;

function TdxBarSpinEdit.IsMaxValueStored: Boolean;
begin
  Result := FMaxValue <> 0;
end;

function TdxBarSpinEdit.IsMinValueStored: Boolean;
begin
  Result := FMinValue <> 0;
end;

function TdxBarSpinEdit.IsValueStored: Boolean;
begin
  Result := Value <> 0;
end;

procedure TdxBarSpinEdit.AddPrefix(var Text: string);
begin
  if FPrefixPlace = ppEnd then
    Text := Text + FPrefix
  else
    Text := FPrefix + Text;
end;

procedure TdxBarSpinEdit.RemovePrefix(var Text: string);
var
  P: Integer;
begin
  P := Pos(FPrefix, Text);
  if P <> 0 then Delete(Text, P, Length(FPrefix));
end;

function TdxBarSpinEdit.CheckRange: Boolean;
begin
  Result := (FMinValue <> FMaxValue) or (FMinValue <> 0);
end;

procedure TdxBarSpinEdit.DoButtonClick(Button: TdxBarSpinEditButton);
begin
  case Button of
    sbUp: CurValue := CurValue + Increment;
    sbDown: CurValue := CurValue - Increment;
  end;
  if Assigned(FOnButtonClick) then FOnButtonClick(Self, Button);
end;

function TdxBarSpinEdit.GetCheckedValue(Value: Extended): Extended;
begin
  Result := Value;
  PrepareValue(Result);
  if CheckRange then
  begin
    if Result < FMinValue then Result := FMinValue;
    if Result > FMaxValue then Result := FMaxValue;
  end;
end;

procedure TdxBarSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
const
  Buttons: array[Boolean] of TdxBarSpinEditButton = (sbDown, sbUp);
var
  Control: TdxBarSpinEditControl;
begin
  inherited;
  if (Key in [VK_UP, VK_DOWN]) and (FocusedItemLink <> nil) and not ReadOnly then
  begin
    Control := TdxBarSpinEditControl(FocusedItemLink.Control);
    if Control.FTimerID = 0 then
    begin
      Control.ActiveButton := Buttons[Key = VK_UP];
      DoButtonClick(Buttons[Key = VK_UP]);
    end;
    Key := 0;
  end;
end;

procedure TdxBarSpinEdit.KeyPress(var Key: Char);
var
  KeySet: set of AnsiChar;
begin
  inherited;
  KeySet := [Chr(VK_BACK), '0'..'9'];
  if FMinValue < 0 then Include(KeySet, '-');
  if FValueType = svtFloat then
   Include(KeySet, AnsiChar({$IfDef XE}formatSettings.{$EndIf}DecimalSeparator));
  if not (Key in KeySet) then Key := #0;
end;

procedure TdxBarSpinEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if FocusedItemLink <> nil then 
    with TdxBarSpinEditControl(FocusedItemLink.Control) do
      if (Key in [VK_UP, VK_DOWN]) and (FTimerID = 0) then
        ActiveButton := sbNone;
end;

procedure TdxBarSpinEdit.PrepareValue(var Value: Extended);
begin
  if FValueType = svtInteger then Value := Trunc(Value);
end;

function TdxBarSpinEdit.TextToValue(Text: string): Extended;
begin
  RemovePrefix(Text);
  try
    if FValueType = svtInteger then
      Result := StrToInt(Text)
    else
      Result := StrToFloat(Text);
  except
    on EConvertError do Result := FMinValue;
  end;
end;

procedure TdxBarSpinEdit.SetText(Value: string);
begin
  RemovePrefix(Value);
  try
    if FValueType = svtInteger then
      StrToInt(Value)
    else
      StrToFloat(Value);
  except
    on EConvertError do Exit;
  end;
  inherited SetText(ValueToText(GetCheckedValue(TextToValue(Value))));
end;

function TdxBarSpinEdit.ValueToText(Value: Extended): string;
begin
  if FValueType = svtInteger then
    Result := IntToStr(Trunc(Value))
  else
    Result := FloatToStr(Value);
  AddPrefix(Result);  
end;

{ TdxBarSpinEditControl }

function TdxBarSpinEditControl.GetItem: TdxBarSpinEdit;
begin
  Result := TdxBarSpinEdit(ItemLink.Item);
end;

procedure TdxBarSpinEditControl.SetActiveButton(Value: TdxBarSpinEditButton);
begin
  if FActiveButton <> Value then
  begin
    FActiveButton := Value;
    ButtonPressed := Value <> sbNone;
  end;
end;

procedure TdxBarSpinEditControl.SetButtonPressed(Value: Boolean);
begin
  if FButtonPressed <> Value then
  begin
    FButtonPressed := Value;
    Repaint;
  end;
end;

procedure TdxBarSpinEditControl.BreakProcess;
begin
  if GetCapture = Handle then ReleaseCapture;
  ActiveButton := sbNone;
  if FTimerID <> 0 then
  begin
    KillTimer(Handle, FTimerID);
    FTimerID := 0;
  end;
end;

function TdxBarSpinEditControl.ButtonFromPoint(P: TPoint): TdxBarSpinEditButton;
var
  R: TRect;
begin
  MapWindowPoints(Handle, Parent.Handle, P, 1);
  R := FButtonsRect;
  if PtInRect(R, P) and not Item.ReadOnly then
  begin
    with R do
      Bottom := (Top + Bottom) div 2;
    if PtInRect(R, P) then
      Result := sbUp
    else
      Result := sbDown;
  end
  else
    Result := sbNone;
end;

procedure TdxBarSpinEditControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
var
  XSize, YSize, l_Size: Integer;
  Selected: Boolean;
  DC: HDC;

  procedure DrawButton(AButton: TdxBarSpinEditButton);
  var
    R: TRect;
    P: array[1..3] of TPoint;
    Pen: HPEN;
    Brush: HBRUSH;

    procedure DrawOneArrow(X, Y, Color: Integer);
    begin
      P[1] := Point(X, Y);
      P[2] := Point(X + XSize - 1, Y);
      P[3] := Point(X + XSize div 2, Y - (2 * Byte(AButton = sbUp) - 1) * XSize div 2);
      Pen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(Color)));
      Brush := SelectObject(DC, GetSysColorBrush(Color));
      Polygon(DC, P, 3);
      SelectObject(DC, Brush);
      DeleteObject(SelectObject(DC, Pen));
    end;

  begin
    R := ARect;
    with R do
    begin
      if AButton = sbUp then
        Bottom := Top + l_Size + Byte(Flat)
      else
        Inc(Top, l_Size);
      FrameAndFillRect(DC, R, Selected, (FActiveButton = AButton) and ButtonPressed);
      Inc(Left, YSize);
      Top := (Top + Bottom - YSize) div 2 + Byte(AButton = sbUp) * (YSize - 1);
      if (FActiveButton = AButton) and ButtonPressed and not Flat then
      begin
        Inc(Left);
        Inc(Top);
      end;
      if Enabled then
        DrawOneArrow(Left, Top, COLOR_BTNTEXT)
      else
      begin
        if not Flat then
          DrawOneArrow(Left + 1, Top + 1, COLOR_BTNHIGHLIGHT);
        DrawOneArrow(Left, Top, COLOR_BTNSHADOW);
      end;
    end;
  end;

begin
  SetRectEmpty(FButtonsRect);
  with ARect do
  begin
    YSize := ((Bottom - Top) div 2 - 2) div 2;
    XSize := 2 * YSize - 1;
    l_Size := XSize + 2 * (1 + 1 + YSize);
    if l_Size >= (Right - Left) div 2 then
      l_Size := 0
    else
      Dec(Right, l_Size);
  end;
  inherited;
  if l_Size = 0 then Exit;
  Selected := DrawSelected;
  DC := Parent.Canvas.Handle;
  with ARect do
  begin
    Left := Right;
    Right := Left + l_Size;
    FillRect(DC, Rect(Left, Top, Left + 1, Bottom), Parent.BkBrush);
    FillRect(DC, Rect(Right - 1, Top, Right, Bottom), Parent.BkBrush);
    Inc(Left);
    Dec(Right);
    FButtonsRect := ARect;
    l_Size := (Bottom - Top) div 2;
    DrawButton(sbUp);
    DrawButton(sbDown);
  end;
end;

procedure TdxBarSpinEditControl.WndProc(var Message: TMessage);
begin
  inherited;
  with Message do
    case Msg of
      WM_CAPTURECHANGED:
        if FTimerID <> 0 then BreakProcess;
      WM_KILLFOCUS:
        if FActiveButton <> sbNone then BreakProcess;
      WM_LBUTTONDBLCLK, WM_LBUTTONDOWN:
        if FActiveButton = sbNone then
        begin
          ActiveButton := ButtonFromPoint(SmallPointToPoint(TSmallPoint(lParam)));
          if FActiveButton <> sbNone then
          begin
            SetCapture(Handle);
            Item.DoButtonClick(FActiveButton);
            FTimerID := SetTimer(Handle, 1, GetDoubleClickTime - 100, nil);
          end;
        end;
      WM_LBUTTONUP:
        if FTimerID <> 0 then BreakProcess;
      WM_MOUSEMOVE:
        if (FTimerID <> 0) and (FActiveButton <> sbNone) then
          ButtonPressed := FActiveButton = ButtonFromPoint(SmallPointToPoint(TSmallPoint(lParam)));
      WM_TIMER:
        case wParam of
          1: begin
               KillTimer(Handle, FTimerID);
               FTimerID := SetTimer(Handle, 2, 100, nil);
             end;
          2: if ButtonPressed then Item.DoButtonClick(FActiveButton);
        end;
    end;
end;

{ TdxBarControlContainerItem }

constructor TdxBarControlContainerItem.Create(AOwner: TComponent);
begin
  inherited;
  FPlace := TCustomForm.CreateNew(nil);
  with TDummyForm(FPlace) do
    BorderStyle := bsNone;
end;

destructor TdxBarControlContainerItem.Destroy;
begin
  Control := nil;
  FPlace.Free;
  inherited;
end;

function TdxBarControlContainerItem.GetInPlaceControl: Boolean;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
  begin
    Result := (Links[I].Control <> nil) and
      TdxBarControlContainerControl(Links[I].Control).InPlaceControl;
    if Result then Exit;
  end;
  Result := False;
end;

procedure TdxBarControlContainerItem.SetControl(Value: TControl);
begin
  if (Value <> nil) and IsControlAssigned(Value) then
    raise Exception.Create(DXBAR_CANTASSIGNCONTROL);
  if FControl <> Value then
  begin
    if FControl <> nil then
    begin
      FControl.WindowProc := FPrevControlWndProc;
      if not (csDestroying in FControl.ComponentState) and
        not BarManager.Designing then
        FControl.Parent := nil;
    end;
    FControl := Value;
    if FControl <> nil then
    begin
      FControl.FreeNotification(Self);
      FPrevControlWndProc := FControl.WindowProc;
      FControl.WindowProc := ControlWndProc;
      SaveControlSize;
    end;
    UpdateEx;
  end;
end;

procedure TdxBarControlContainerItem.ControlWndProc(var Message: TMessage);

  function IsSizeChanged: Boolean;
  begin
    with Control, FPrevControlSize do
      Result := (Width <> X) or (Height <> Y);
  end;

begin
  FPrevControlWndProc(Message);
  with Message do
    if not InPlaceControl and IsSizeChanged and
      ((Msg = WM_SIZE) or (Msg = WM_WINDOWPOSCHANGED) and (lParam = 0)) then
    begin
      SaveControlSize;
      UpdateEx;
    end;
end;

function TdxBarControlContainerItem.IsControlAssigned(AControl: TControl): Boolean;
var
  I: Integer;
  ABarItem: TdxBarItem;
begin
  Result := True;
  for I := 0 to BarManager.ItemCount - 1 do
  begin
    ABarItem := BarManager.Items[I];
    if (ABarItem is TdxBarControlContainerItem) and
      (TdxBarControlContainerItem(ABarItem).Control = AControl) then Exit;
  end;
  Result := False;
end;

procedure TdxBarControlContainerItem.SaveControlSize;
begin
  with Control do
    FPrevControlSize := Point(Width, Height);
end;

procedure TdxBarControlContainerItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Control) then Control := nil;
end;

procedure TdxBarControlContainerItem.SetName(const NewName: TComponentName);
begin
  inherited;
  if (Control = nil) and not IsLoading then UpdateEx;
end;

function TdxBarControlContainerItem.CanClicked: Boolean;
begin
  Result := False;
end;

function TdxBarControlContainerItem.GetHidden: Boolean;
begin
  Result := True;
end;

function TdxBarControlContainerItem.HasAccel(AItemLink: TdxBarItemLink): Boolean;
begin
  Result :=
    (AItemLink.Control <> nil) and
    TdxBarControlContainerControl(AItemLink.Control).ParentIsQuickCustControl;
end;

procedure TdxBarControlContainerItem.HideControl(AControl: TdxBarItemControl);
begin
  if TdxBarControlContainerControl(AControl).ShowsControl then
  begin
    FPlace.Visible := False;
    FPlace.ParentWindow := 0;
  end;
end;

function TdxBarControlContainerItem.NeedToBeHidden: Boolean;
begin
  Result := True;
end;

{ TdxBarControlContainerControl }

destructor TdxBarControlContainerControl.Destroy;
begin
  Item.HideControl(Self);
  inherited;
end;

function TdxBarControlContainerControl.GetControl: TControl;
begin
  if Item = nil then
    Result := nil
  else
    Result := Item.Control;
end;

function TdxBarControlContainerControl.GetItem: TdxBarControlContainerItem;
begin
  Result := TdxBarControlContainerItem(ItemLink.Item);
end;

function TdxBarControlContainerControl.GetPlace: TCustomForm;
begin
  Result := Item.Place;
end;

procedure TdxBarControlContainerControl.BeforeDestroyParentHandle;
begin
  inherited;
  if IsShowingControl and (Control is TWinControl) then
  begin
    TDummyWinControl(Control).DestroyHandle;
    Place.Visible := False;   // work-around for the controls that
    Place.ParentWindow := 0;  // don't check HandleAllocated
  end;
end;

function TdxBarControlContainerControl.CanClicked: Boolean;
begin
  Result := ParentIsQuickCustControl;
end;

function TdxBarControlContainerControl.CanSelect: Boolean;
begin
  if ParentIsQuickCustControl then
    Result := True
  else
    Result := BarManager.Designing;
end;

function TdxBarControlContainerControl.GetHeight: Integer;
begin
  if (Control = nil) or ParentIsQuickCustControl then
  begin
    Result := Parent.TextSize;
    if Parent is TdxBarControl then
      with TDummyBarManager(BarManager) do
        if Result < ButtonHeight then Result := ButtonHeight;
  end
  else
    Result := Control.Height;
end;

function TdxBarControlContainerControl.GetWidth: Integer;
begin
  if ParentIsQuickCustControl then
    with BarManager, Parent.Canvas do
    begin
      Result := TextWidth(GetTextOf(Caption));
      if ImageExists then
        Inc(Result, TDummyBarManager(BarManager).ButtonWidth + 4)
      else
        Inc(Result, Font.Size);
    end
  else
    if Control = nil then
      if Parent is TdxBarSubMenuControl then
      begin
        Result := 2 * Parent.TextSize + 3 +
          Parent.Canvas.TextWidth(GetTextOf(Item.Name)) + 3;
        if Flat then Inc(Result, 2 + 1 + 6);
      end
      else
        with BarManager, Parent.Canvas do
          Result := TextWidth(GetTextOf(Item.Name)) + Font.Size
    else
      Result := Control.Width;
end;

function TdxBarControlContainerControl.IsDestroyOnClick: Boolean;
begin
  Result := ParentIsQuickCustControl;
end;

function TdxBarControlContainerControl.IsShowingControl: Boolean;
begin
  Result := (Control <> nil) and (Place.ParentWindow = Parent.Handle);
end;

function TdxBarControlContainerControl.NeedCaptureMouse: Boolean;
begin
  Result := ParentIsQuickCustControl;
end;

{$O+}
procedure TdxBarControlContainerControl.Paint(ARect: TRect;
  PaintType: TdxBarPaintType);
const
  Borders: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
{$IFNDEF DELPHI6}
  A: array[0..12] of Byte;  // to avoid a bug with GetObject
{$ENDIF}
  R: TRect;
  DC: HDC;
  ABrush: HBRUSH;
  LogBrush: TLogBrush;
  PrevBkColor: COLORREF;
  S: string;
  APressed: Boolean;
begin
{$IFNDEF DELPHI6}
  FillChar(A, 1, 0);
{$ENDIF}
  R := ARect;
  DC := Parent.Canvas.Handle;
  if ParentIsQuickCustControl then
  begin
    APressed := DrawSelected and Parent.IsActive and MousePressed;
    DrawGlyph(R, nil, PaintType, False, DrawSelected, False, APressed, False, False, False);
    if ImageExists then
      Inc(R.Left, TDummyBarManager(BarManager).ButtonWidth)
    else
      Inc(R.Left, Parent.Canvas.Font.Size div 2);
    if APressed and not Flat then OffsetRect(R, 1, 1);
    DrawItemText(DC, Caption, R, DT_LEFT, Enabled, False, False, False, Flat);
  end
  else
    if (Control = nil) or BarManager.Designing then
    begin
      FrameRect(DC, R, GetSysColorBrush(COLOR_BTNSHADOW));
      InflateRect(R, -1, -1);

      ABrush := CreateHatchBrush(HS_BDIAGONAL, GetSysColor(COLOR_BTNSHADOW));
      GetObject(Parent.BkBrush, SizeOf(LogBrush), @LogBrush);
      PrevBkColor := SetBkColor(DC, LogBrush.lbColor);
      FillRect(DC, R, ABrush);
      SetBkColor(DC, PrevBkColor);
      DeleteObject(ABrush);

      if Control = nil then
        S := Item.Name
      else
        S := LoadStr(DXBAR_PLACEFORCONTROL) + Control.Name;
      DrawItemText(DC, S, R, DT_CENTER, True, False, PaintType = ptVert, True, Flat);
    end
    else
      PlaceControl;
end;
{$O-}

procedure TdxBarControlContainerControl.PlaceControl;
var
  LogBrush: TLogBrush;
begin
  if ShowsControl then
  begin
    if FInPlaceControl then Exit;
    FInPlaceControl := True;
    try
      if not IsRectEmpty(ItemLink.ItemRect) or (Item.LinkCount = 1) then
        Place.ParentWindow := Parent.Handle;
      if not IsRectEmpty(ItemLink.ItemRect) or IsShowingControl then
        Place.BoundsRect := ItemLink.ItemRect;
      Control.Parent := Place;
      if not IsRectEmpty(ItemLink.ItemRect) then
        with Control do
        begin
          BoundsRect := Parent.ClientRect;
          Visible := True;
        end;
      GetObject(Parent.BkBrush, SizeOf(LogBrush), @LogBrush);
      Place.Brush.Color := LogBrush.lbColor;
      Place.Visible := True;
    finally
      FInPlaceControl := False;
    end;
  end;
end;

function TdxBarControlContainerControl.ShowsControl: Boolean;
begin
  Result :=
    not ParentIsQuickCustControl and (Control <> nil) and not BarManager.Designing;
end;

{ TdxBarProgressItem }

constructor TdxBarProgressItem.Create(AOwner: TComponent);
begin
  inherited;
  BorderStyle := sbsLowered;
  FMax := 100;
  FStep := 10;
end;

procedure TdxBarProgressItem.SetMax(Value: Integer);
var
  AMin, AMax: Integer;
begin
  if FMax <> Value then
  begin
    AMin := FMin;
    AMax := Value;
    if AMin > AMax then AMin := AMax;
    SetParams(AMin, AMax);
  end;
end;

procedure TdxBarProgressItem.SetMin(Value: Integer);
var
  AMin, AMax: Integer;
begin
  if FMin <> Value then
  begin
    AMin := Value;
    AMax := FMax;
    if AMax < AMin then AMax := AMin;
    SetParams(AMin, AMax);
  end;
end;

procedure TdxBarProgressItem.SetPosition(Value: Integer);
begin
  if Value < FMin then Value := FMin;
  if Value > FMax then Value := FMax;
  if FPosition <> Value then
  begin
    FPosition := Value;
    UpdateBar;
  end;
end;

procedure TdxBarProgressItem.SetSmooth(Value: Boolean);
begin
  if FSmooth <> Value then
  begin
    FSmooth := Value;
    UpdateBar;
  end;
end;

procedure TdxBarProgressItem.SetStep(Value: Integer);
begin
  FStep := Value;
end;

procedure TdxBarProgressItem.UpdateBar;
var
  I: Integer;
begin
  if not IsLoading then
    for I := 0 to LinkCount - 1 do
      if Links[I].Control <> nil then
        TdxBarProgressControl(Links[I].Control).UpdateBar;
end;

procedure TdxBarProgressItem.SetParams(AMin, AMax: Integer);
begin
  if (FMin <> AMin) or (FMax <> AMax) then
  begin
    FMin := AMin;
    FMax := AMax;
    if IsLoading then Exit;
    if FMin > FMax then FMin := FMax;
    if FPosition < FMin then
      Position := FMin
    else
      if FPosition > FMax then
        Position := FMax
      else
        UpdateBar;
  end;
end;

procedure TdxBarProgressItem.StepBy(Delta: Integer);
begin
  Position := Position + Delta;
end;

procedure TdxBarProgressItem.StepIt;
begin
  if FPosition + FStep > FMax then
    Position := FPosition + FStep - FMax
  else
    if FPosition + FStep < FMin then
      Position := FMax - (FMin - (FPosition + FStep))
    else
      Position := Position + Step;
end;

{ TdxBarProgressControl }

function TdxBarProgressControl.GetItem: TdxBarProgressItem;
begin
  Result := TdxBarProgressItem(ItemLink.Item);
end;

function TdxBarProgressControl.BarBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_HIGHLIGHT);
end;

function TdxBarProgressControl.BarHeight: Integer;
begin
  with ItemLink.ItemRect do
    if IsVertical(Parent) then
    begin
      Result := MulDiv(Right - Left - 2 * BorderWidth, 2, 3);
      if Odd(Right - Left) <> Odd(Result) then Inc(Result);
    end
    else
    begin
      Result := MulDiv(Bottom - Top - 2 * BorderWidth, 2, 3);
      if Odd(Bottom - Top) <> Odd(Result) then Inc(Result);
    end;
end;

function TdxBarProgressControl.BarRect: TRect;
var
  W, H, RightOffset: Integer;
begin
  W := BarWidth;
  H := BarHeight;
  RightOffset := W + ProgressBarIndent + BorderWidth + RightIndent;
  with ItemLink.ItemRect do
    if IsVertical(Parent) then
      Result := Bounds((Left + Right - H) div 2, Bottom - RightOffset, H, W)
    else
      Result := Bounds(Right - RightOffset, (Top + Bottom - H) div 2, W, H);
end;

function TdxBarProgressControl.BarWidth: Integer;
var
  AWidth: Integer;
begin
  if (Width = 0) and (Align <> iaClient) then
    Result := ProgressBarDefaultWidth
  else
  begin
    if Parent is TdxBarSubMenuControl then
      with ItemLink.ItemRect do
        AWidth := Right - Left
    else
      if Align = iaClient then
        if IsVertical(Parent) then
          with ItemLink.ItemRect do
            AWidth := Bottom - Top
        else
          with ItemLink.ItemRect do
            AWidth := Right - Left
      else
        AWidth := Width;
    Result := AWidth - GetAutoWidth -
      (Byte(not Item.ShowCaption) + 1) * ProgressBarIndent;
    if Result < 0 then Result := 0;
  end;
end;

function TdxBarProgressControl.CanHaveZeroSize: Boolean;
begin
  Result := True;
end;

procedure TdxBarProgressControl.DrawInterior(DC: HDC; ARect: TRect;
  PaintType: TdxBarPaintType);
const
  Alignments: array[Boolean] of Integer = (DT_CENTER, DT_LEFT);
var
  BarR, R: TRect;
  Rgn: HRGN;
  Limit, Step: Integer;
  ALeft, ARight: ^Integer;
begin
  BarR := BarRect;
  if IsRectEmpty(BarR) then
    Rgn := 0
  else
  begin
    Rgn := CreateRectRgn(0, 0, 0, 0);
    if GetClipRgn(DC, Rgn) <> 1 then
    begin
      DeleteObject(Rgn);
      Rgn := 0;
    end;  
    with BarR do
      ExcludeClipRect(DC, Left, Top, Right, Bottom);
  end;

  DrawGlyphAndCaption(DC, ARect, PaintType, False);

  if Rgn = 0 then
    SelectClipRgn(DC, 0)
  else
  begin
    SelectClipRgn(DC, Rgn);
    DeleteObject(Rgn);
  end;
  R := BarR;
  if not IsRectEmpty(R) then
  begin
    with R do
      if PaintType = ptVert then
      begin
        ALeft := @Top;
        ARight := @Bottom;
      end
      else
      begin
        ALeft := @Left;
        ARight := @Right;
      end;
    with Item do
      ARight^ := ALeft^ + MulDiv(ARight^ - ALeft^, Position - Min, Max - Min);
    Limit := ARight^;
    if Item.Smooth then
      FillRect(DC, R, BarBrush)
    else
    begin
      with R do
        if PaintType = ptVert then
          Step := MulDiv(Right - Left, 2, 3)
        else
          Step := MulDiv(Bottom - Top, 2, 3);
      ARect := R;
      repeat
        ARight^ := ALeft^ + Step;
        if ARight^ > Limit then ARight^ := Limit;
        FillRect(DC, R, BarBrush);
        ALeft^ := ARight^;
        Inc(ARight^, 2);
        if ARight^ > Limit then ARight^ := Limit;
        FillRect(DC, R, Parent.BkBrush);
        ALeft^ := ARight^;
      until ARight^ = Limit;
    end;
    if PaintType = ptVert then
      BarR.Top := Limit
    else
      BarR.Left := Limit;
    FillRect(DC, BarR, Parent.BkBrush);
  end;
end;

function TdxBarProgressControl.GetAlignment: TAlignment;
begin
  Result := taLeftJustify;
end;

function TdxBarProgressControl.GetDefaultWidth: Integer;
begin
  Result := inherited GetDefaultWidth;
  if Width = 0 then
    Inc(Result, (Byte(not Item.ShowCaption) + 1) * ProgressBarIndent +
      ProgressBarDefaultWidth);
end;

procedure TdxBarProgressControl.UpdateBar;
var
  R: TRect;
begin
  R := BarRect;
  InvalidateRect(Parent.Handle, @R, False);
end;

{ TdxBarMRUListItem }

constructor TdxBarMRUListItem.Create(AOwner: TComponent);
begin
  inherited;
  FMaxItemCount := 5;
end;

procedure TdxBarMRUListItem.SetMaxItemCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMaxItemCount <> Value then
  begin
    FMaxItemCount := Value;
    CheckItemCount;
  end;
end;

procedure TdxBarMRUListItem.CheckItemCount;
var
  I: Integer;
begin
  if FMaxItemCount = 0 then Exit;
  for I := Items.Count - 1 downto FMaxItemCount do
    Items.Delete(I);
end;

function TdxBarMRUListItem.GetDisplayText(const AText: string): string;
begin
  Result := GetCuttedString(inherited GetDisplayText(AText));
end;

procedure TdxBarMRUListItem.DirectClick;
begin
  inherited;
  if ((CurItemLink = nil) or (CurItemLink.Item <> Self)) and
    not BarManager.IsCustomizing and FRemoveItemOnClick then
  begin
    RemoveItem(Items[ItemIndex], nil);
    ItemIndex := -1;
  end;
end;

procedure TdxBarMRUListItem.AddItem(const S: string; AObject: TObject);
var
  I: Integer;
begin
  I := Items.IndexOf(S);
  if (I = -1) and (AObject <> nil) then
    I := Items.IndexOfObject(AObject);
  if I = -1 then
  begin
    Items.InsertObject(0, S, AObject);
    CheckItemCount;
  end
  else
    Items.Move(I, 0);
end;

procedure TdxBarMRUListItem.RemoveItem(const S: string; AObject: TObject);
var
  I: Integer;
begin
  with Items do
  begin
    if S <> '' then
      I := IndexOf(S)
    else
      I := IndexOfObject(AObject);
    if I <> -1 then Delete(I);
  end;
end;

{ TdxBarInPlaceSubItem }

procedure TdxBarInPlaceSubItem.SetExpanded(Value: Boolean);
var
  List: TList;
  I: Integer;
begin
  if FExpanded <> Value then
  begin
    if not Value then
      for I := 0 to LinkCount - 1 do
        DoBeforeCollapse(Links[I]);
    FExpanded := Value;
    if not IsLoading then
    begin
      List := TList.Create;
      FExpandedChanging := True;
      try
        for I := 0 to LinkCount - 1 do
          with Links[I] do
            if (Control <> nil) and (Control.Parent is TdxBarSubMenuControl) and
              (List.IndexOf(Control.Parent) = -1) then
            begin
              List.Add(Control.Parent);
              Control.Parent.RepaintBar;
            end;
      finally
        FExpandedChanging := False;
        List.Free;
      end;
    end;
    if Value then
      for I := 0 to LinkCount - 1 do
        DoAfterExpand(Links[I]);
  end;
end;

procedure TdxBarInPlaceSubItem.AddListedItemLinks(AItemLinks: TdxBarItemLinks;
  AIndex: Integer; FirstCall: Boolean; CallingItemLink: TdxBarItemLink);
begin
  if FExpanded then inherited;
end;

procedure TdxBarInPlaceSubItem.DeleteListedItemLinks(AItemLinks: TdxBarItemLinks;
  AIndex: Integer);
begin
  if FExpanded and not FExpandedChanging or
    not FExpanded and FExpandedChanging then inherited;
end;

function TdxBarInPlaceSubItem.HideWhenRun: Boolean;
begin
  Result := False;
end;

procedure TdxBarInPlaceSubItem.ChangeNextItemLinkBeginGroup(ALink: TdxBarItemLink;
  Value: Boolean);
var
  NextItemLinkIndex: Integer;
begin
  if FKeepBeginGroupWhileExpanded then
    with ALink.Owner do
      if not (BarControl is TdxBarControl) then
      begin
        NextItemLinkIndex := ALink.VisibleIndex + 1;
        if not BarManager.Designing then
          Inc(NextItemLinkIndex, ItemLinks.VisibleItemCount);
        if NextItemLinkIndex <= VisibleItemCount - 1 then
          VisibleItems[NextItemLinkIndex].BeginGroup := Value;
      end;
end;

procedure TdxBarInPlaceSubItem.DoAfterExpand(ALink: TdxBarItemLink);
begin
  if Assigned(FOnAfterExpand) then FOnAfterExpand(Self, ALink);
  ChangeNextItemLinkBeginGroup(ALink, True);
end;

procedure TdxBarInPlaceSubItem.DoBeforeCollapse(ALink: TdxBarItemLink);
begin
  if Assigned(FOnBeforeCollapse) then FOnBeforeCollapse(Self, ALink);
  ChangeNextItemLinkBeginGroup(ALink, False);
end;

{ TdxBarInPlaceSubItemControl }

function TdxBarInPlaceSubItemControl.GetItem: TdxBarInPlaceSubItem;
begin
  Result := TdxBarInPlaceSubItem(ItemLink.Item);
end;

procedure TdxBarInPlaceSubItemControl.ControlClick(ByMouse: Boolean);
var
  AParent: TdxBarSubMenuControl;
  AOriginalItemLink: TdxBarItemLink;
  ASelectedItemLinkIndex: Integer;
begin
  inherited;
  if Parent is TdxBarSubMenuControl then
  begin
    AParent := TdxBarSubMenuControl(Parent);
    AOriginalItemLink := ItemLink.OriginalItemLink;
    if IsSelected then
      ASelectedItemLinkIndex := ItemLink.Index
    else
      ASelectedItemLinkIndex := -1;
    with Item do
    begin
      DirectClick;
      Expanded := not Expanded;
    end;
    if ASelectedItemLinkIndex <> -1 then
      with TDummyCustomBarControl(AParent) do
        if (ASelectedItemLinkIndex < ItemLinks.VisibleItemCount) and
          (ItemLinks[ASelectedItemLinkIndex].OriginalItemLink = AOriginalItemLink) then
          SelectedItem := ItemLinks[ASelectedItemLinkIndex].Control;
  end;
end;

procedure TdxBarInPlaceSubItemControl.DblClick;
begin
  if Enabled then ControlClick(True);
end;

function TdxBarInPlaceSubItemControl.GetDefaultHeight: Integer;
begin
  Result := inherited GetDefaultHeight;
  if Parent is TdxBarSubMenuControl then Inc(Result);
end;

function TdxBarInPlaceSubItemControl.GetDefaultWidth: Integer;
begin
  if Parent is TdxBarSubMenuControl then
    Result := 5 + Parent.Canvas.TextWidth(GetTextOf(Caption)) + Parent.TextSize
  else
    Result := inherited GetDefaultWidth;
end;

function TdxBarInPlaceSubItemControl.HasSubMenu: Boolean;
begin
  Result := not (Parent is TdxBarSubMenuControl);
end;

function TdxBarInPlaceSubItemControl.IsExpandable: Boolean;
begin
  Result := not (Parent is TdxBarSubMenuControl) and inherited IsExpandable;
end;

procedure TdxBarInPlaceSubItemControl.KeyDown(Key: Word);
begin
  case Key of
    VK_LEFT:
      ControlClick(False);
    VK_RIGHT:
      ControlClick(False);
  end;
end;

procedure TdxBarInPlaceSubItemControl.Paint(ARect: TRect; PaintType: TdxBarPaintType);
const
  Arrows: array[Boolean] of TdxArrowType = (atRight, atDown);
var
  Selected: Boolean;
  DC: HDC;
  R: TRect;
  Brush: HBRUSH;
  l_Size: Integer;
begin
  if PaintType = ptMenu then
  begin
    if ARect.Left = ARect.Right then Exit;
    Selected := DrawSelected;
    DC := Parent.Canvas.Handle;

    R := ARect;
    R.Top := R.Bottom - 1;
    FillRect(DC, R, Parent.BkBrush);

    R.Bottom := R.Top;
    R.Top := ARect.Top;
    if Selected then
      Brush := TDummyCustomBarControl(Parent).ToolbarSelBrush
    else
      Brush := GetSysColorBrush(COLOR_BTNSHADOW);
    if Flat then
    begin
      if Selected then
        FrameFlatSelRect(DC, R)
      else
        FrameRect(DC, R, GetSysColorBrush(COLOR_BTNSHADOW));
      InflateRect(R, -1, -1);
    end;
    FillRect(DC, R, Brush);

    Inc(R.Left, 5);
    DrawItemText(DC, Caption, R, DT_LEFT, True, True, False, False, Flat and Selected);

    if Enabled then
    begin
      l_Size := Parent.MenuArrowHeight;
      with R do
        Left := Right - Parent.TextSize + Byte(not Item.Expanded) * l_Size;
      DrawLargeItemArrow(DC, R, Arrows[Item.Expanded], l_Size, not Flat or not Selected, True, Flat);
    end;
  end
  else
    inherited;
end;

function TdxBarInPlaceSubItemControl.WantsKey(Key: Word): Boolean;
begin
  if Parent is TdxBarSubMenuControl then
    Result :=
      (Key = VK_LEFT) and Item.Expanded or
      (Key = VK_RIGHT) and not Item.Expanded
  else
    Result := inherited WantsKey(Key);
end;

initialization
  FTrueTypeFontBitmap := TBitmap.Create;
  FTrueTypeFontBitmap.LoadFromResourceName(HInstance, 'DXBARTRUETYPEFONT');
  FNonTrueTypeFontBitmap := TBitmap.Create;
  FNonTrueTypeFontBitmap.LoadFromResourceName(HInstance, 'DXBARNONTRUETYPEFONT');
  FColorDialog := TColorDialog.Create(nil);
  FFontDialog := TFontDialog.Create(nil);

  if GetLocaleInfo(GetThreadLocale, LOCALE_IFIRSTDAYOFWEEK,
    @StartOfWeek, SizeOf(StartOfWeek)) = 0 then
    StartOfWeek := 0
  else
  begin
    StartOfWeek := StrToInt(Chr(StartOfWeek));
    Inc(StartOfWeek);
    if StartOfWeek > 6 then StartOfWeek := 0;
  end;

  sdxBarDatePopupToday := LoadStr(DXBAR_DATETODAY);
  sdxBarDatePopupClear := LoadStr(DXBAR_DATECLEAR);

  dxBarRegisterItem(TdxBarStatic, TdxBarStaticControl, True);
  dxBarRegisterItem(TdxBarLargeButton, TdxBarLargeButtonControl, True);
  dxBarRegisterItem(TdxBarColorCombo, TdxBarColorComboControl, True);
  dxBarRegisterItem(TdxBarFontNameCombo, TdxBarComboControl, True);
  dxBarRegisterItem(TdxBarDateCombo, TdxBarDateComboControl, True);
  dxBarRegisterItem(TdxBarTreeViewCombo, TdxBarTreeViewComboControl, True);
  dxBarRegisterItem(TdxBarImageCombo, TdxBarImageComboControl, True);
  dxBarRegisterItem(TdxBarToolbarsListItem, TdxBarToolbarsListItemControl, True);
  dxBarRegisterItem(TdxBarSpinEdit, TdxBarSpinEditControl, True);
  dxBarRegisterItem(TdxBarControlContainerItem, TdxBarControlContainerControl, True);
  dxBarRegisterItem(TdxBarProgressItem, TdxBarProgressControl, True);
  dxBarRegisterItem(TdxBarMRUListItem, TdxBarContainerItemControl, True);
  dxBarRegisterItem(TdxBarInPlaceSubItem, TdxBarInPlaceSubItemControl, True);

finalization
  dxBarUnregisterItem(TdxBarInPlaceSubItem);
  dxBarUnregisterItem(TdxBarMRUListItem);
  dxBarUnregisterItem(TdxBarProgressItem);
  dxBarUnregisterItem(TdxBarControlContainerItem);
  dxBarUnregisterItem(TdxBarSpinEdit);
  dxBarUnregisterItem(TdxBarToolbarsListItem);
  dxBarUnregisterItem(TdxBarImageCombo);
  dxBarUnregisterItem(TdxBarTreeViewCombo);
  dxBarUnregisterItem(TdxBarDateCombo);
  dxBarUnregisterItem(TdxBarFontNameCombo);
  dxBarUnregisterItem(TdxBarColorCombo);
  dxBarUnregisterItem(TdxBarLargeButton);
  dxBarUnregisterItem(TdxBarStatic);

  FFontDialog.Free;
  FColorDialog.Free;
  FNonTrueTypeFontBitmap.Free;
  FTrueTypeFontBitmap.Free;

end.

