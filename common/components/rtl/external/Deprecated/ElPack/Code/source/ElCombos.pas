{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
{$INCLUDE elpack2.inc}
{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

(*

07/06/2003

  BorderColor* properties added. They control the colors of the border, drawn when Flat is true.

05/28/2003

  Fixed autocompletion in csDropDown mode (was broken recently)

04/02/2003

  Added ShowGripper property
  Fixed scrollbar styles
  Fixed DropDownList Height

03/06/2003

  Added unicode item lookup in csDropDownList mode

02/15/2003

  UseXPThemes property value now is correctly set to ListBox too

01/05/2003

  MaxLength made published again

12/27/2002

  Fixed some issues when using ElComboBox as inplace editor for ElTree

12/15/2002

  Added selection color properties

10/21/2002

  When selecting long item, the text is now positioned correctly (from char 0)

10/14/2002

  Added HorizontalScroll property

10/01/2002

  Fixed the AltButton "locking" introduced recently.

07/15/2002

  Corrected button frame drawing n XP with themes disabled

07/10/2002

  AutoSelect property made published

04/19/2002

  Added ShowLineHint property

04/15/2002

  Pressing Enter when the combo is dropped down and when it's on dialog box with default button
  caused this button to react instead of the combo box.

02/26/2002

  Color change is not working anymore when Enabled is changed.

02/11/2002

  Text specified in designtime was lost in runtime. Fixed.

01/29/2002

  Fixed width of the visible text

01/23/2002

  Unicode support added

01/15/2002

  Dropdown form now correctly positions itself on the top of the combo's parent form

01/11/2002

  Fixed vertical text alignment problems with BorderStyle = bsNone
  Added ButtonShortCut and AltButtonShortcut properties

01/01/2002

  Fixed some problems with painting borders when focus is moved

12/21/2001

  Now OnDropDown is fired before the list is dropped. This lets you fill the list
  in OnDropDown event handler.

12/17/2001

  Fixed ElCombo to NOT call OnChange event when the text is changed programmatically

11/25/2001

  AdjustDropDownPos property added. Now, if the list doesn't fit into parent form,
  it is dropped up, not down

Version History
09/17/2001 (c) Akzhan Abdulin

  Added Windows XP Themes Support for ElComboBox.
  Note that themed combobox will ignore some its look'n'feel properties.

07/23/2001

  AltBtnShowFrame and BtnShowFrame properties added.

06/20/2001

  DropDownWidth property added for dropped down list width setting.

03/21/2001

  Fixed the problem with auto-size combo boxes, that spoiled form fonts.

03/09/2001

  Fixed drawing artefacts on buttons.

12/23/2000

  CanDrop property added. For read-only comboboxes it acts similar to Enabled,
  but the font color is not changed.

12/20/2000

  Small resource leak fixed in ElCombos.SetAutoSize (By the way, this leak
  exists in VCL).

09/28/2000

  OnChange was not fired after selecting an item from the drop-down list. Fixed

09/05/2000

  AutoSize property published

*)

unit ElCombos;

interface

uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  Controls,
  Graphics,
  Forms,
  TypInfo,
  Menus,
{$IFDEF VCL_6_USED}
  Types,
{$ENDIF}
  ElTools,
  ElVCLUtils,
  Buttons,
  ElImgFrm,
  ElPopBtn,
  ElGlyphs,
{$IFDEF WIN32}
  ElUxTheme,
{$ENDIF}
  stdctrls,
{$IFDEF ELPACK_UNICODE}
  ElUnicodeStrings,
{$ENDIF}
{$ifdef ELPACK_USE_INPUTPROCESSOR}
  Imm,
{$endif}
{< ELSCROLLBAR}
  // ElSBCtrl, <trash> // LAW
{> ELSCROLLBAR}
  ElInputProcessor,
  ElEdits,
  ElListBox,
  ElBtnEdit,
  ElStrUtils,
  ElFrmPers;

type
  TCustomElComboBox = class;

  TElAutoHistoryItemAddEvent = procedure(Sender: TObject; const aString:
    TElFString; const aIdx: Integer) of object;
  TElAutoHistoryItemMoveEvent = procedure(Sender: TObject; const aString:
    TElFString; const aIdx: Integer) of object;
  TElAutoHistoryCompletionEvent = procedure(Sender: TObject; const UserStr:
    TElFString; var AutoAdd: TElFString; idx: integer) of object;
  TElAutoHistoryDirection = (ahdFirst, ahdLast);

  TElComboListBox = class(TElListBox)
  private
    FCombo: TCustomElComboBox;
    procedure WMLButtonDown(var Msg: TMessage); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseActivate(var Msg: TMessage); message WM_MOUSEACTIVATE;
    procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMRButtonDown(var Msg: TMessage); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Msg: TMessage); message WM_RBUTTONUP;
    procedure CNCommand(var Msg: TMessage); message CN_COMMAND;
  protected
    procedure ResetContent; override;
    procedure CreateParams(var Params: TCreateParams); override;
    function GetBackground: TBitmap; override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure WndProc(var Message: TMessage); override;
    procedure DrawItem(Index: Integer; R: TRect; State:
{$IFNDEF VCL_5_USED}StdCtrls{$ELSE}Windows{$ENDIF}.TOwnerDrawState);
      override;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TCustomElComboBox = class(TCustomElButtonEdit)
  protected
    FSaveSize : TSize;
    FUseSaveSize: boolean;
    FIgnoreFocus: Boolean;
    FChangeAllowed: Boolean;
    FDropDownWidth: Integer;
    FAutoCompletion: Boolean;

    FAutoHistory: boolean;
    FAutoHistoryDirection: TElAutoHistoryDirection;
    FAutoHistoryLimit: Integer;
    FOnAutoHistoryCompletion: TElAutoHistoryCompletionEvent;
    FOnAutoHistoryItemAdd: TELAutoHistoryItemAddEvent;
    FOnAutoHistoryItemMove: TELAutoHistoryItemMoveEvent;

    {$ifdef ELPACK_USE_INPUTPROCESSOR}
    Input : TElKeyboardInput;
    SearchTextTimeoutThread : TThread;
    {$endif}

    FAltBtnAlign: TLeftRight;
    FDropDownCount: integer;
    FForm: TForm;
    FItemIndex: Integer;
    FListBox: TElComboListBox;
    FOnAltBtnClick: TNotifyEvent;
    FOnDropDown: TNotifyEvent;
    FArrowColor,
      FSaveColor: TColor;
    FSaveFlat: boolean;
    FForcedText: boolean;
    FIgnoreItemIdx: boolean;
    FCanDrop,
      FDroppedDown: boolean;
    FAdjustDropDownPos: Boolean;
    FHorizontalScroll: Boolean;
    FStyle: TComboBoxStyle;
    FOnDrawItem: TDrawItemEvent;
    FOnMeasureItem: TMeasureItemEvent;
    FEditCanvas: TCanvas;
    FCanvas: TCanvas;
    FDropDownAlignment: TAlignment;
    FIncrementalSearchTimeout: Integer;
    FShowGripper: Boolean;
    FOnSelect: TNotifyEvent;
    procedure Select; virtual;
    function GetItemHeight: Integer;
    procedure SetItemHeight(Value: Integer);
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
      ComboProc: Pointer); virtual;

    function GetListTransparentSelection: Boolean;
    procedure SetListTransparentSelection(Value: Boolean);
    procedure SetDropDownWidth(const Value: Integer);
    procedure CMCancelMode(var Msg: TCMCancelMode); message CM_CANCELMODE;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure DoChange; override;
    procedure WMSetCursor(var Msg: TMessage); message WM_SETCURSOR;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMMButtonDblClk(var Message: TWMMButtonDblClk); message
      WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message
      WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMContextMenu(var Message: TMessage); message WM_CONTEXTMENU;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure EMSetReadOnly(var Msg: TMessage); message EM_SETREADONLY;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure ButtonClick(Sender: TObject);
    procedure GetDropDownValue;
    function GetDroppedDown: boolean;
    function GetItems: TElFStrings;
    function GetListColor: TColor;
    function GetListInvertSelection: boolean;
    function GetSorted: boolean;
    function GetUseBackground: boolean;
    procedure ListBoxClick(Sender: TObject);
    procedure SetDropDownCount(const Value: integer);
    procedure SetDroppedDown(const Value: boolean);
    procedure SetCanDrop(const Value: boolean);
    procedure SetItemIndex(const Value: Integer);
    procedure SetItems(const Value: TElFStrings);
    procedure SetListColor(const Value: TColor);
    procedure SetListInvertSelection(const Value: boolean);
    procedure SetSorted(const Value: boolean);
    procedure SetUseBackground(const Value: boolean);
    function GetDroppedIndex: integer;
    procedure WMKillFocus(var Msg: TMessage); message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg: TMessage); message WM_SETFOCUS;
    procedure SetHorizontalScroll(const Value: Boolean);
  protected
    procedure MeasureItem(Index: Integer; var Height: Integer); virtual;
    procedure DrawItem(Index: Integer; R: TRect; State:
{$IFNDEF VCL_5_USED}StdCtrls{$ELSE}Windows{$ENDIF}.TOwnerDrawState);
      virtual;

    function GetListImageForm: TElImageForm;
    procedure SetListImageForm(newValue: TElImageForm);
{$IFDEF MSWINDOWS}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ELThemeChanged(var Message: TMessage); message EL_THEMECHANGED;
{$ENDIF}
    procedure DoDropDown; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    function GetBtnArrowColor: TColor; virtual;
    procedure SetBtnArrowColor(newValue: TColor); virtual;

    procedure SetAltBtnAlign(Value: TLeftRight);
    procedure DoAutoComplete;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure SetReadOnly(Value: boolean);
    procedure SetLineBorderActiveColor(Value: TColor); override;
    procedure SetLineBorderInactiveColor(Value: TColor); override;
    procedure SetActiveBorderType(const Value: TElFlatBorderType); override;
    procedure SetInactiveBorderType(const Value: TElFlatBorderType); override;
    procedure SetFlat(const Value: boolean); override;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure DestroyWnd; override;
    procedure WMGetDlgCode(var Message: TMessage); message WM_GETDLGCODE;
    function GetShowLineHint: Boolean;
    procedure SetShowLineHint(Value: Boolean);
    procedure SetStyle(Value: TComboBoxStyle); virtual;
    function GetEditHandle: HWND;
    procedure SetDropDownAlignment(Value: TAlignment);
    function GetRightAlignedView:Boolean;
    procedure SetRightAlignedView(Value: Boolean); override;
    procedure SetRightAlignedText(Value: Boolean); override;
    procedure SetFocusedSelectColor(newValue: TColor); override;
    procedure SetFocusedSelectTextColor(newValue: TColor); override;
    procedure SetHighlightAlphaLevel(Value: Integer); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadBtnColor(Reader: TReader);

    function GetTextFromItem(Index: integer): TElFString; virtual;
    procedure ReadBtnArrowColor(Reader: TReader);
    procedure ReadBtnFlat(Reader: TReader);
    procedure ReadBtnTransparent(Reader: TReader);
    procedure ReadAltBtnColor(Reader: TReader);
    procedure ReadAltBtnFlat(Reader: TReader);
    procedure ReadAltBtnTransparent(Reader: TReader);
    procedure ReadAltBtnVisible(Reader: TReader);
    procedure ReadAltBtnWidth(Reader: TReader);
    procedure ReadAltBtnPosition(Reader: TReader);
    function GetAltBtnGlyph: TBitmap;
    procedure SetAltBtnGlyph(Value: TBitmap);
    procedure ReadReadOnly(Reader: TReader);
    function GetItemWidth(Index: Integer): Integer; virtual;
    procedure DoExit; override;
    procedure SetUseXPThemes(const Value : boolean); override;
    procedure PaintText(Canvas : TCanvas); override;
    procedure WMDeadChar(var Message: TWMDeadChar); message WM_DEADCHAR;
    procedure WMIMEComposition(var Message: TMessage); message WM_IME_COMPOSITION;
    procedure WMIMEStartComposition(var Message: TMessage); message
        WM_IME_STARTCOMPOSITION;
    {$ifdef ELPACK_USE_INPUTPROCESSOR}
    procedure StartClearSearchTimeoutThread;
    procedure StopClearSearchTimeoutThread;
    procedure DoPerformSearch(SearchText : TElFString); virtual;
    procedure SearchTextTimeout(Sender : TObject);
    function DoCompareItems(SearchText : String; ItemIndex : integer): Boolean;
        virtual;
    {$endif}

    function GetImages: TImageList;
    procedure SetImages(Value: TImageList);
    function GetAlphaForImages: TImageList;
    procedure SetAlphaForImages(Value: TImageList);
    procedure SetEditRect(Value : TRect); override;
(*    function GetHorzScrollBar:TElCtrlScrollBarStyles;
    function GetVertScrollBar:TElCtrlScrollBarStyles;
    function GetUseCustomScrollBars:Boolean;
    procedure SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
    procedure SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
    procedure SetUseCustomScrollBars(const Value :Boolean);*) // <trash> // LAW
    procedure SetShowGripper(Value: Boolean);

    property EditHandle: HWND read GetEditHandle;

    property ButtonArrowColor: TColor read GetBtnArrowColor write
    SetBtnArrowColor; { Published }
    property AltBtnGlyph: TBitmap read GetAltBtnGlyph stored False;

    property CanDrop: boolean read FCanDrop write SetCanDrop default True;
    property DropDownCount: Integer read FDropDownCount write SetDropDownCount
    default 8;
    property DropDownWidth: Integer read FDropDownWidth write SetDropDownWidth
    default -1;
    property ListTransparentSelection: Boolean read GetListTransparentSelection
    write SetListTransparentSelection default false;
    property AutoCompletion: Boolean read FAutoCompletion write FAutoCompletion;
    property Items: TElFStrings read GetItems write SetItems;
    property ListColor: TColor read GetListColor write SetListColor default
    clWindow;
    property ListImageForm: TElImageForm read GetListImageForm write
    SetListImageForm;
    property ListInvertSelection: boolean read GetListInvertSelection write
    SetListInvertSelection default False;
    property Sorted: boolean read GetSorted write SetSorted default False;
    property UseBackground: boolean read GetUseBackground write SetUseBackground
    default False;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property AdjustDropDownPos: Boolean read FAdjustDropDownPos write
    FAdjustDropDownPos default true;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property ShowLineHint: Boolean read GetShowLineHint write SetShowLineHint
    default false;
    property HorizontalScroll: Boolean read FHorizontalScroll write
    SetHorizontalScroll default false;
    property Style: TComboBoxStyle read FStyle write SetStyle default
    csDropDown;
    property ItemHeight: Integer read GetItemHeight write SetItemHeight;
    property OnDrawItem: TDrawItemEvent read FOnDrawItem write FOnDrawItem;
    property OnMeasureItem: TMeasureItemEvent read FOnMeasureItem write
    FOnMeasureItem;
    property DropDownAlignment: TAlignment read FDropDownAlignment write
    SetDropDownAlignment default taRightJustify;

    property AutoHistory: boolean read FAutoHistory write FAutoHistory;
    property AutoHistoryDirection: TElAutoHistoryDirection read
      FAutoHistoryDirection write FAutoHistoryDirection;
    property AutoHistoryLimit: Integer read FAutoHistoryLimit write
      FAutoHistoryLimit;
    //property OnAutoCompletion: TElAutoHistoryCompletionEvent read
    //  FOnAutoHistoryCompletion write FOnAutoHistoryCompletion;
    property OnAutoHistoryItemAdd: TElAutoHistoryItemAddEvent read
      FOnAutoHistoryItemAdd write FOnAutoHistoryItemAdd;
    property OnAutoHistoryItemMove: TElAutoHistoryItemMoveEvent read
      FOnAutoHistoryItemMove write FOnAutoHistoryItemMove;
    property IncrementalSearchTimeout: Integer read FIncrementalSearchTimeout write
        FIncrementalSearchTimeout default 500;
    property Images: TImageList read GetImages write SetImages;
    property AlphaForImages: TImageList read GetAlphaForImages write
        SetAlphaForImages;
    property ShowGripper: Boolean read FShowGripper write SetShowGripper default
        false;
  {< ELSCROLLBAR}
(*    property HorzScrollBarStyles: TElCtrlScrollBarStyles read GetHorzScrollBar
      write SetHorzScrollBar;
    property VertScrollBarStyles: TElCtrlScrollBarStyles read GetVertScrollBar
      write SetVertScrollBar;
    property UseCustomScrollBars:Boolean read GetUseCustomScrollBars write SetUseCustomScrollBars
      default True;
    property RightAlignedView: Boolean read GetRightAlignedView write
          SetRightAlignedView default false;*) // <trash> // LAW
  {> ELSCROLLBAR}
    function GetSelectedItemIndex: Integer;
    property OnSelect: TNotifyEvent read FOnSelect write FOnSelect;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    procedure CloseUp(AcceptValue: boolean); virtual;
    procedure DropDown; virtual;
    procedure AutoHistoryUpdate;

    property Canvas: TCanvas read FCanvas;
    property DroppedDown: boolean read GetDroppedDown write SetDroppedDown;
    property DroppedIndex: integer read GetDroppedIndex;
    property Ctl3D;
    property ParentCtl3D;
    property SelectedItemIndex: Integer read GetSelectedItemIndex;
  end;

  TElComboBox = class(TCustomElComboBox)
  published
    property ButtonArrowColor;

    property CanDrop;
    property DropDownCount;
    property DropDownWidth;
    property ListTransparentSelection;
    property AutoCompletion;
    property Items;
    property ListColor;
    property ListImageForm;
    property ListInvertSelection;
    property Sorted;
    property UseBackground;
    property OnDropDown;
    property AdjustDropDownPos;
    property ItemIndex;
    property ShowLineHint;
    property HorizontalScroll;
    property Style;
    property ItemHeight;
    property OnDrawItem;
    property OnMeasureItem;
    property DropDownAlignment;
    property ShowGripper;

(*    {< ELSCROLLBAR}
    property VertScrollBarStyles;
    property HorzScrollBarStyles;
    property UseCustomScrollBars;
    property RightAlignedView;
    {> ELSCROLLBAR}*) // <trash> // LAW

    property OnSelect;
    property AutoHistory;
    property AutoHistoryDirection;
    property AutoHistoryLimit;
    // property OnAutoCompletion;
    property OnAutoHistoryItemAdd;
    property OnAutoHistoryItemMove;

    // inherited from TCustomElButtonEdit
    property AlignBottom;
    property CharCase;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AutoSize;
    property ReadOnly;
    property MaxLength;
    property BorderSides;
    property Transparent;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

{$IFDEF ELPACK_USE_IMAGEFORM}
    property ImageForm;
{$ENDIF}
    property IncrementalSearchTimeout;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;
    property OnKeyPressEx;

    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;
    property Text;

    // inherited from TCustomElEdit
    property Flat;
    property ActiveBorderType;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property UseSystemMenu;

    property Alignment;
    property AutoSelect default true;

    property Background;
    property ButtonCaption;
{$IFDEF USE_SOUND_MAP}
    property ButtonClickSound;
    property ButtonDownSound;
    property ButtonUpSound;
    property ButtonSoundMap;
{$ENDIF}
    property ButtonColor;
    property ButtonEnabled;
    property ButtonFlat;
    property ButtonHint;
    property ButtonOldStyled;
    property ButtonShortcut;
    property ButtonTransparent;
    property ButtonThinFrame;
    property ButtonShowBorder;
    property ButtonVisible;
    property ButtonWidth;

    property AltButtonCaption;
{$IFDEF USE_SOUND_MAP}
    property AltButtonClickSound;
    property AltButtonDownSound;
    property AltButtonUpSound;
    property AltButtonSoundMap;
{$ENDIF}
    property AltButtonColor;
    property AltButtonDown;
    property AltButtonEnabled;
    property AltButtonFlat;
    property AltButtonGlyph;
    property AltButtonHint;
    property AltButtonIsSwitch;
    property AltButtonIcon;
    property AltButtonNumGlyphs;
    property AltButtonOldStyled;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShowBorder;
    property AltButtonShortcut;
    property AltButtonThinFrame;
    property AltButtonTransparent;
    property AltButtonUseIcon;
    property AltButtonVisible;
    property AltButtonWidth;
    property OnAltButtonClick;

    // VCL properties
    property BorderStyle;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnClick;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
{$IFDEF VCL_4_USED}
    property OnEndDock;
{$ENDIF}
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF VCL_4_USED}
    property OnStartDock;
{$ENDIF}
  {$IFDEF VCL_5_USED}
      property OnContextPopup;
  {$ENDIF}

{$IFDEF VCL_4_USED}
    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DoubleBuffered;
    property DragKind;
{$ENDIF}
  end;

implementation

{$IFDEF WIN32}
uses
  ElTmSchema;
{$ENDIF}

{ TElComboButton }

type
  TElComboButton = class(TCustomElGraphicButton)
  protected
    function GetShowGlyph: Boolean; override;
    function GetThemedClassName: WideString; override;
    function GetThemePartID: Integer; override;
    function GetThemeStateID: Integer; override;
  end;

{ TElComboListBox }

constructor TElComboListBox.Create(AOwner: TComponent);
begin
  inherited;
  FCombo := TCustomElComboBox(AOwner);
  ActiveBorderType := fbtLineBorder;
  InactiveBorderType := fbtLineBorder;
  LineBorderActiveColor := clWindowFrame;
  LineBorderInactiveColor := clWindowFrame;
  Flat := True;
  // UseXPThemes := UseXPThemes;
  TabStop := False;
  HideSelectColor := clHighlight;
  HideSelectTextColor := clHighlightText;
  HideSelection := false;
end;

procedure TElComboListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
end;

function TElComboListBox.GetBackground: TBitmap;
begin
  Result := FCombo.Background;
end;

procedure TElComboListBox.WMLButtonDown(var Msg: TMessage);
begin
  MouseCapture := True;
end;

procedure TElComboListBox.DrawItem(Index: Integer; R: TRect; State:
{$IFNDEF VCL_5_USED}StdCtrls{$ELSE}Windows{$ENDIF}.TOwnerDrawState);
begin
  if (FCombo.FStyle = csOwnerDrawFixed) or (FCombo.FStyle = csOwnerDrawVariable) then
  begin
    FCombo.FCanvas := Canvas;
    FCombo.DrawItem(Index, R, State);
  end
  else
    inherited DrawItem(Index, R, State);
end;

procedure TElComboListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  if FCombo.FStyle = csOwnerDrawVariable then
    FCombo.MeasureItem(Index, Height)
  else
    inherited;
end;

procedure TElComboListBox.WndProc(var Message: TMessage);
begin
  if FCombo <> nil then
    FCombo.ComboWndProc(Message, 0, nil);
  inherited WndProc(Message);
end;

procedure TElComboListBox.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  MouseCapture := False;
  //Click;
  FCombo.CloseUp({(not FCombo.ReadOnly) and} PtInRect(ClientRect, Point(Msg.XPos, Msg.YPos)));
end;

procedure TElComboListBox.WMMouseActivate(var Msg: TMessage);
begin
  Msg.Result := MA_NOACTIVATE;
end;

procedure TElComboListBox.WMMouseMove(var Msg: TWMMouseMove);
var
  Index: integer;
begin
  if Items.Count>0 then
  with Msg do
  begin
    Index := ItemIndex;
    if (YPos >= ClientHeight) then
    begin
      if Index >= 0 then Inc(Index);
    end
    else
    if YPos >= 0 then
      Index := Perform(LB_ITEMFROMPOINT, 0, MakeLParam(XPos, YPos));
    if MouseCapture and
      ((XPos < 0) or (XPos > ClientWidth) or ((Index = 0) and (YPos < 0)) or
      ((Index = Items.Count) and (YPos > ClientHeight))) then
      Index := -1;
    if ((YPos < 0) and (Index > 0)) or (Index = Items.Count) then
      Dec(Index);
    if (Index<>ItemIndex) and (Index>=0) and (Index<Items.Count) then
    begin
      if Multiselect and (ItemIndex>=0) and (not Selected[ItemIndex]) then
      begin
        Canvas.Font := Font;
        Canvas.Brush := Brush;
        DrawItem(ItemIndex, ItemRect(ItemIndex), []);
      end;

      ItemIndex := Index;
      {
      FCombo.FChangeAllowed := false;
      //FCombo.FForcedText := true;
      FCombo.ItemIndex := Index;
      //FCombo.FForcedText := false;
      FCombo.FChangeAllowed := true;
      {}


      if Multiselect and(ItemIndex>=0) then
      begin
        Canvas.Font := Font;
        Canvas.Brush := Brush;
        DrawItem(ItemIndex, ItemRect(ItemIndex), [odSelected]);
      end;
/// Правка
{      if (FCombo<>nil) then
        FCombo.Select;
}
    end;
  end;
  inherited;
end;

procedure TElComboListBox.WMKeyDown(var Message: TWMKeyDown);
//var
//  OldItemIndex: Integer;
begin
//  OldItemIndex := ItemIndex;
  inherited;
  //Правка
{
  if (FCombo<>nil) and(OldItemIndex <> ItemIndex) then
    FCombo.Select;
}
end;

procedure TElComboListBox.WMRButtonDown(var Msg: TMessage);
begin
end;

procedure TElComboListBox.WMRButtonUp(var Msg: TMessage);
begin
end;

procedure TElComboListBox.ResetContent;
begin
  inherited;
  if not FCombo.ReadOnly then
  begin
    Fcombo.FForcedText := true;
    FCombo.ItemIndex := -1;
    Fcombo.FForcedText := false;
  end
  else
    FCombo.ItemIndex := -1;
end;

procedure TElComboListBox.CNCommand(var Msg: TMessage);
begin
  inherited;
  {
  if TWMCommand(Msg).NotifyCode = LBN_SELCHANGE then
  begin
    FCombo.FChangeAllowed := false;
    FCombo.ItemIndex := ItemIndex;
    FCombo.FChangeAllowed := true;
  end;
  }
end;

procedure TElComboListBox.WMNCPaint(var Message: TMessage);
var DC : HDC;
    R  : TRect;
begin
  inherited;
  if FCombo.ShowGripper then
  begin
    DC := GetWindowDC(FCombo.FForm.Handle);
    // paint frame:
    GetWindowRect(FCombo.FForm.Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL)-1;
    if IsThemeApplied and (BorderStyle = bsSingle) then
      DrawThemeBackgroundTo('LISTVIEW', DC, 0, 0, R, nil)
    else
      with FCombo do
        ElVCLUtils.DrawFlatFrameEx2(DC, R, clWindowFrame, Color{?}, False, True,
          [ebsLeft, ebsRight, ebsBottom], fbtColorLineBorder, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorwindow);
    // fill rect:
    GetWindowRect(FCombo.FForm.Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    InflateRect(R, -GetSystemMetrics(SM_CXEDGE), 0);
    Dec(R.Bottom, GetSystemMetrics(SM_CYEDGE));
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL)+2;
    if FCombo.IsThemeApplied then
    begin
      FillRect(DC, R, HBRUSH(GetThemeSysColor(FCombo.Theme, clBtnFace) + 1));
      R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
      DrawThemeBackgroundTo('STATUS', DC, SP_GRIPPER, 0, R, nil);
    end
    else
      DrawFrameControl(DC, R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP);
    ReleaseDC(Handle, DC);
  end;
end;

{ TCustomElComboBox }

procedure TCustomElComboBox.ButtonClick(Sender: TObject);
begin
  SetFocus;
  DropDown;
end;

procedure TCustomElComboBox.Click;
begin
  inherited;
  Select;
  if FForm.Visible then
    CloseUp(False);
end;

procedure TCustomElComboBox.CloseUp(AcceptValue: boolean);
var R : TRect;
begin
  if AcceptValue then
  begin
    GetDropDownValue;
    Change;
  end;
  FDroppedDown := false;
  TElComboButton(FButton).Down := false;
  DoDropDown;
  if FForm.Visible then
  begin
    GetWindowRect(FForm.Handle, R);
    FSaveSize.cx := R.Right - R.Left;
    FSaveSize.cy := R.Bottom - R.Top;
    FUseSaveSize := true;
    SetWindowPos(FForm.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FForm.Visible := False;
  end;
  /// Правка
  if AcceptValue then begin
    Click;
  end;
end;

procedure TCustomElComboBox.CMCancelMode(var Msg: TCMCancelMode);
begin
  if DroppedDown and (Msg.Sender <> Self) and (Msg.Sender <> FButton) and (Msg.Sender <> FListBox)
    and (Msg.Sender <> FForm) then
    CloseUp(False);
end;

procedure TCustomElComboBox.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  FButton.Enabled := Enabled;
  (*if Enabled then
     Color := FSaveColor
  else
  begin
    FSaveColor := Color;
    Color := clbtnFace//clBtnShadow;
  end;
  *)
end;

procedure TCustomElComboBox.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  FListBox.Font.Assign(Font);
  FListBox.SelectedFont.Assign(Font);
  FListBox.SelectedFont.Color := clHighlightText;

  Invalidate;
end;

procedure TCustomElComboBox.WMKeyDown(var Message: TWMKeyDown);
begin
  if (Message.CharCode = VK_RETURN) and FForm.Visible then
  begin
    CloseUp(true);
    Message.CharCode := 0;
    Message.Result := 1;
  end;
  if ReadOnly then
  begin
    {$ifdef ELPACK_USE_INPUTPROCESSOR}
    if (Style <> csDropDown) {and AutoCompletion} then
    begin
      Input.WMKeyDown(Message);
      DoPerformSearch(Input.Text);
    end;
    {$endif}
    inherited;
    if HandleAllocated then
    begin
      HideCaret(Handle);
      SendMessage(Handle, EM_SETSEL, -1, -1);
    end;
  end
  else
  begin
    inherited;
  end;
end;

procedure TCustomElComboBox.CNCommand(var Message: TWMCommand);
begin
  if (Message.NotifyCode = EN_UPDATE) and ReadOnly then
  begin
    HideCaret(Handle);
  end
  else
    inherited;
end;

procedure TCustomElComboBox.WMLButtonUp(var Message: TWMLButtonUp);
begin
  {
  if FButton.InCapture then
  begin
    FButton.MouseUp(mbLeft, KeyDataToShiftState(Message.Keys), Message.XPos, Message.YPos);
  end
  else
  if FAltButton.InCapture then
  begin
    FAltButton.MouseUp(mbLeft, KeyDataToShiftState(Message.Keys), Message.XPos, Message.YPos);
  end
  else
  }
  if ReadOnly then
  begin
    with Message do
      MouseUp(mbLeft, KeysToShiftState(Keys), XPos, YPos);
    SendMessage(Handle, EM_SETSEL, -1, -1);
    HideCaret(Handle);
    exit;
  end;
  inherited;
end;

procedure TCustomElComboBox.WMMButtonDblClk(var Message: TWMMButtonDblClk);
begin
  if ReadOnly then
  begin
    Message.Result := 0;
    with Message do
      MouseDown(mbMiddle, KeysToShiftState(Keys) + [ssDouble], XPos, YPos);
    SendMessage(Handle, EM_SETSEL, -1, -1);
    HideCaret(Handle);
  end
  else
    inherited;
end;

procedure TCustomElComboBox.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if ReadOnly then
  begin
    SendCancelMode(Self);
    if csClickEvents in ControlStyle then
      ControlState := ControlState + [csClicked];
    if not (csNoStdEvents in ControlStyle) then
      with Message do
        MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
    DroppedDown := not DroppedDown;
    SendMessage(Handle, EM_SETSEL, -1, -1);
    HideCaret(Handle);
  end
  else
    inherited;
end;

procedure TCustomElComboBox.EMSetReadOnly(var Msg: TMessage);
begin
  if Boolean(Msg.wParam) then
  begin
    if GetFocus = Handle then
      HideCaret(Handle);
    if Items.IndexOf(inherited Text) = -1 then
    begin
      FForcedText := true;
      Text := '';
      FForcedText := false;
    end;
  end;
end;

procedure TCustomElComboBox.WMMouseWheel(var Msg: TWMMouseWheel);
var
  Dy: integer;
  sl: integer;
begin
  //if IsWinNT or IsWin98 then SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE) else sl := 3;
  //if sl = 0 then
  if CanDrop then
  begin
    sl := 1;
    Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
    if Dy <> 0 then
    begin
      if Self.DroppedDown then
      begin
        if InRange(0, Items.Count - 1, FListBox.ItemIndex - dy) then
        begin
          FListBox.ItemIndex := FListBox.ItemIndex - dy;
          {
          FChangeAllowed := false;
          ItemIndex := FListBox.ItemIndex - dy;
          FChangeAllowed := true;
          Change;
          {}
          Select;
        end;
      end
      else
      if InRange(0, Items.Count - 1, ItemIndex - dy) then
      begin
        ItemIndex := ItemIndex - dy;
        Change;
        Select;
      end;
    end;
  end;
end; { WMMouseWheel }

procedure TCustomElComboBox.WMContextMenu(var Message: TMessage);
var
  Pt, Temp: TPoint;
{$IFDEF VCL_5_USED}
  Handled: Boolean;
{$ENDIF}
  PopupMenu: TPopupMenu;
begin
  if ReadOnly then
  begin
    Pt.x := LOWORD(Message.lParam);
    Pt.y := HIWORD(Message.lParam);
    if Pt.X < 0 then
      Temp := Pt
    else
    begin
      Temp := ScreenToClient(Pt);
      if not PtInRect(ClientRect, Temp) then
      begin
        inherited;
        Exit;
      end;
    end;

{$IFDEF VCL_5_USED}
    Handled := False;
    DoContextPopup(Temp, Handled);
    Message.Result := Ord(Handled);
    if Handled then Exit;
{$ENDIF}

    PopupMenu := GetPopupMenu;
    if (PopupMenu <> nil) and PopupMenu.AutoPopup then
    begin
      SendCancelMode(nil);
      PopupMenu.PopupComponent := Self;
      if Pt.X < 0 then
        Pt := ClientToScreen(Point(0, 0));
      PopupMenu.Popup(Pt.X, Pt.Y);
    end;
    Message.Result := 1;
  end
  else
    inherited;
end;

procedure TCustomElComboBox.WMSetCursor(var Msg: TMessage);
begin
  if ReadOnly then
    Windows.SetCursor(Screen.Cursors[crArrow])
  else
    inherited;
end;

procedure TCustomElComboBox.DoChange;
begin
  if not FIgnoreItemIdx then
  begin
    if ReadOnly and not FForcedText then
      if (Items.IndexOf(inherited Text) = -1) and (ItemIndex <> -1) then
        inherited Text := Items[ItemIndex];
    FForcedText := true;
    ItemIndex := Items.IndexOf(inherited Text);
    FForcedText := false;
  end;
end;

function TCustomElComboBox.GetSelectedItemIndex: Integer;
begin
  Result := FListBox.ItemIndex;
end;

procedure TCustomElComboBox.Select;
begin
  if Assigned(FOnSelect) then
    FOnSelect(Self);
end;

type
  TTrickyForm = class(TForm)
  private
    FCombo: TCustomElComboBox;
    procedure WMMouseActivate(var Msg: TMessage); message WM_MOUSEACTIVATE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMGetMinMaxInfo(var Message: TMessage); message WM_GETMINMAXINFO;
    procedure WMNCHitTest(var Msg : TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure WMEnterSizeMove(var Message: TMessage); message WM_ENTERSIZEMOVE;
    procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;
    procedure WMWindowPosChanged(var Message: TMessage); message
        WM_WINDOWPOSCHANGED;
  public
    constructor CreateNew(AOwner : TComponent{$ifdef VCL_4_USED}; Dummy : integer =
        0{$endif}); {$ifdef VCL_4_USED} override;{$endif}
  end;

procedure TTrickyForm.CreateParams(var Params: TCreateParams); { protected }
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_POPUP{ or WS_BORDER};
    ExStyle := ExStyle or WS_EX_TOOLWINDOW;
    WndParent := GetDesktopWindow;
  end;
end; { CreateParams }

constructor TTrickyForm.CreateNew(AOwner : TComponent{$ifdef VCL_4_USED}; Dummy
    : integer = 0{$endif});
begin
  inherited CreateNew(nil);
  FCombo := TCustomElComboBox(AOwner);
end;

procedure TTrickyForm.WMGetMinMaxInfo(var Message: TMessage);
var
  tp : PMinMaxInfo;
begin
  inherited;
  tp := PMinMaxInfo(Message.LParam);
  tp.ptMinTrackSize.y := FCombo.ItemHeight;

  if FCombo.HorizontalScroll then
  begin
(*    if FCombo.UseCustomScrollBars then
      inc(tp.ptMinTrackSize.y, FCombo.HorzScrollBarStyles.Depth)
    else*) // <trash> // LAW
      inc(tp.ptMinTrackSize.y, GetSystemMetrics(SM_CYHSCROLL));
  end;

  if FCombo.ShowGripper then
    inc(tp.ptMinTrackSize.y, GetSystemMetrics(SM_CYHSCROLL));
  inc(tp.ptMinTrackSize.y, GetSystemMetrics(SM_CYBORDER) * 2);
  Message.Result := 1;
end;

procedure TTrickyForm.WMNCHitTest(var Msg : TWMNCHitTest);
var
  R : TRect;
begin
  inherited;
  if FCombo.FShowGripper and
    (Msg.Result <> HTVSCROLL) and (Msg.Result <> HTHSCROLL){}
  then
  begin
    R := BoundsRect;
    OffsetRect(R, -Left, -Top);
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL);
    R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
    if PtInRect(R, ScreenToClient(SmallPointToPoint(Msg.Pos))) then
      Msg.Result := HTBOTTOMRIGHT
    else
    if R.Top < ScreenToClient(SmallPointToPoint(Msg.Pos)).Y then
      Msg.Result := HTNOWHERE;
  end;
end;

procedure TTrickyForm.WMMouseActivate(var Msg: TMessage);
begin
  Msg.Result := MA_NOACTIVATE;
end;

procedure TTrickyForm.WMSetFocus(var Message: TMessage);
begin
  Windows.SetFocus(Message.wParam);
end;

procedure TTrickyForm.WMEnterSizeMove(var Message: TMessage);
begin
  inherited;
  FCombo.FIgnoreFocus := true;
end;

procedure TTrickyForm.WMExitSizeMove(var Message: TMessage);
var AForm : TCustomForm;
begin
  AForm := GetParentForm(FCombo);
  if (AForm <> nil) and (AForm.CanFocus) then
    AForm.SetFocus;

  Windows.SetFocus(FCombo.Handle);
  FCombo.FIgnoreFocus := false;
  inherited;
end;

procedure TTrickyForm.WMWindowPosChanged(var Message: TMessage);
var adj : integer;
begin
  inherited;
  if FCombo.ShowGripper then
    adj := GetSystemMetrics(SM_CYHSCROLL)
  else
    adj := 0;
  FCombo.FListBox.SetBounds(0, 0, PWindowPos(Pointer(Message.lParam)).cx,
    PWindowPos(Pointer(Message.lParam)).cy-adj);
end;

constructor TCustomElComboBox.Create(AOwner: TComponent);
begin
  ButtonClass := TElComboButton;
  inherited;
  inherited OnButtonClick := ButtonClick;
  TElComboButton(FButton).IsSwitch := true;
  FEditCanvas := inherited Canvas;
  FCanvas := FEditCanvas;
  NotifyUserChangeOnly := true;
  Multiline := false;
  FCanDrop := true;
  FDropDownCount := 8;
  FDropDownWidth := -1;
  FItemIndex := -1;
  FArrowColor := clRed;
  ButtonArrowColor := clBtnText;
  FAdjustDropDownPos := true;
  ControlStyle := ControlStyle - [csCaptureMouse, csFixedHeight];
// Правка
  ControlStyle := ControlStyle - [csClickEvents];

  {$ifdef ELPACK_USE_INPUTPROCESSOR}
  Input := TElKeyboardInput.Create;
  {$endif}

  FForm := TTrickyForm.CreateNew(Self);
  FForm.Visible := False;
  FForm.BorderStyle := bsNone;

  with TElFormPersist.Create(FForm) do
    TopMost := true;

  FListBox := TElComboListBox.Create(Self);
  FListBox.Parent := FForm;
  // FListBox.Align := alClient;
  FListBox.UseXPThemes := UseXPThemes;
  FListBox.OnClick := ListBoxClick;
(*  {< ELSCROLLBAR}
  FListBox.UseCustomScrollBars := True;
  {> ELSCROLLBAR}*) // <trash> // LAW

  AutoSelect := true;
  FIncrementalSearchTimeout := 500;
  FDropDownAlignment := taRightJustify;
  AutoCompletion := False;
  AutoHistory := False;
  AutoHistoryDirection := ahdFirst;
  AutoHistoryLimit := 25;
end;

(*
{< ELSCROLLBAR}
function TCustomElComboBox.GetHorzScrollBar:TElCtrlScrollBarStyles;
begin
  Result := FListBox.HorzScrollBarStyles;
end;

function TCustomElComboBox.GetVertScrollBar:TElCtrlScrollBarStyles;
begin
  Result := FListBox.VertScrollBarStyles;
end;

function TCustomElComboBox.GetUseCustomScrollBars:Boolean;
begin
  Result := FListBox.UseCustomScrollBars;
end;

procedure TCustomElComboBox.SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  FListBox.HorzScrollBarStyles.Assign(Value);
end;

procedure TCustomElComboBox.SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  FListBox.VertScrollBarStyles.Assign(Value);
end;

procedure TCustomElComboBox.SetUseCustomScrollBars(const Value :Boolean);
begin
  FListBox.UseCustomScrollBars := Value;
end;
{> ELSCROLLBAR}
*) // <trash> // LAW

procedure TCustomElComboBox.AutoHistoryUpdate;
var
  ix: Integer;
  vString : TElFString;
begin
  if (Text <> '') then
  begin
    ix := Items.IndexOf(Text);
    if ix <> -1 then
    begin
      { Entry is already in list. Let's move it}
      { Must save and restore since call to Move clears Text }
      vString := Text;
      if FAutoHistoryDirection = ahdFirst then
        Items.Move(ix, 0)
      else
        Items.Move(ix, pred(Items.Count));
      Text := vString;
      if Assigned(FOnAutoHistoryItemMove) then
        FOnAutoHistoryItemMove(self, Text, ix);
    end
    else
    begin
      if FAutoHistoryDirection = ahdLast then
      begin
        if (FAutoHistoryLimit > 0) and (Items.Count >= FAutoHistoryLimit) then
          Items.Delete(0);
        Items.Add(Text);
      end else
      begin
        if (FAutoHistoryLimit > 0) and (Items.Count >= FAutoHistoryLimit) then
          Items.Delete(Items.Count - 1);
        Items.Insert(0,Text);
      end;
      if Assigned(FOnAutoHistoryItemAdd) then
        FOnAutoHistoryItemAdd(self, Text, Items.IndexOf(Text));
    end;
  end;
end;

procedure TCustomElComboBox.CreateParams(var Params: TCreateParams);
const
  ComboBoxStyles: array[TComboBoxStyle] of DWORD = (
    CBS_DROPDOWN, CBS_SIMPLE, CBS_DROPDOWNLIST,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWFIXED,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWVARIABLE);
begin
  inherited;
//  CreateSubClass(Params, 'COMBOBOX');
  Params.Style := Params.Style or WS_CLIPCHILDREN or ComboBoxStyles[FStyle];
end;
{
const
  ComboBoxStyles: array[TComboBoxStyle] of DWORD = (
    CBS_DROPDOWN, CBS_SIMPLE, CBS_DROPDOWNLIST,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWFIXED,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWVARIABLE);
  CharCases: array[TEditCharCase] of DWORD = (0, CBS_UPPERCASE, CBS_LOWERCASE);
  Sorts: array[Boolean] of DWORD = (0, CBS_SORT);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'COMBOBOX');
  with Params do
  begin
    Style := Style or (WS_VSCROLL or CBS_HASSTRINGS or CBS_AUTOHSCROLL) or
      ComboBoxStyles[FStyle] or Sorts[FSorted] or CharCases[FCharCase];
  end;
end;
}

procedure TCustomElComboBox.ELThemeChanged(var Message: TMessage);
begin
  RecreateWnd;
  Message.Result := 1;
end;

function TCustomElComboBox.GetListImageForm: TElImageForm;
begin
  result := FListBox.ImageForm;
end;

procedure TCustomElComboBox.SetListImageForm(newValue: TElImageForm);
begin
  FListBox.ImageForm := newValue;
end;

destructor TCustomElComboBox.Destroy;
begin
  FListBox.Free;
  FForm.Free;
  {$ifdef ELPACK_USE_INPUTPROCESSOR}
  StopClearSearchTimeoutThread;
  FreeAndNil(Input);
  {$endif}
  inherited;
end;

procedure TCustomElComboBox.DoDropDown;
begin
  if Assigned(FOnDropDown) then FOnDropDown(Self);
end;

procedure TCustomElComboBox.DropDown;
var
  P, P1: TPoint;
  PF: TCustomForm;
  vBrdr :Integer;
  FormHeight : integer;
begin
  if FForm.Visible then
  begin
    CloseUp(False);
  end
  else
  if CanDrop then
  begin
    if not Focused then SetFocus;
    if ReadOnly then
    begin
      SendMessage(Handle, EM_SETSEL, -1, -1);
      HideCaret(Handle);
    end;
    FDroppedDown := true;
    DoDropDown;
    FIgnoreItemIdx := true;
    FForcedText := true;

    if ShowGripper and Self.FUseSaveSize then
    begin
      FForm.Width := FSaveSize.cx;
      FForm.Height := FSaveSize.cy;
    end
    else
    begin
      if FDropDownWidth > 0 then
        FForm.Width := FDropDownWidth
      else
        FForm.Width := Width;
      vBrdr := 0; // GetSystemMetrics(SM_CYBORDER);

      if FListBox.Items.Count = 0 then
        FormHeight := FListBox.ItemHeight + vBrdr * 2
      else
        if FListBox.Items.Count < FDropDownCount then
        FormHeight := FListBox.ItemHeight * FListBox.Items.Count + vBrdr * 2
      else
        FormHeight := FListBox.ItemHeight * FDropDownCount + vBrdr * 2;
      FForcedText := false;
      FormHeight := FormHeight + GetSystemMetrics(SM_CYEDGE) * 2;
      if HorizontalScroll = true then
        // Extra calculation must be done, to check if the extra-height is needed :cool:
        FormHeight := FormHeight + GetSystemMetrics(SM_CYHSCROLL);
      if ShowGripper then
        FormHeight := FormHeight + GetSystemMetrics(SM_CYHSCROLL);

      FForm.Height := FormHeight;
    end;
    FIgnoreItemIdx := false;

    P := Parent.ClientToScreen(Point(Left, Top));
    Inc(P.X, Width);
    Inc(P.Y, Height);

    if (FDropDownAlignment = taRightJustify) xor RightAlignedView then
      Dec(P.X, FForm.Width)
    else
      Dec(P.X, self.Width);

    if P.Y + FForm.Height > GetDesktopBottom then
      P.Y := P.Y - FForm.Height - Height;

    if (P.X + FForm.Width > GetDesktopRight) then
    begin
      P1 := P;
      P1.x := (Left + Width) - FForm.Width;
      P1 := Parent.ClientToScreen(P1);
      P.X := P1.x;
    end;
    if AdjustDropDownPos then
    begin
      PF := GetParentForm(Self);
      P1 := Point(0, PF.ClientHeight);
      P1 := PF.ClientToScreen(P1);
      if P.Y + FForm.Height > P1.y then
      begin
        P1 := Point(0, 0);
        P1 := PF.ClientToScreen(P1);
        if P.Y - Height - FForm.Height >= P1.y then
          P.Y := P.Y - Height - FForm.Height;
      end;
    end;
    FListBox.UseXPThemes := UseXPThemes;
    FListBox.ItemIndex := ItemIndex;

    // FListBox.SetBounds(0, 0, FForm.ClientWidth, FForm.ClientHeight - GetSystemMetrics(SM_CYHSCROLL));
    SetWindowPos(FForm.Handle, HWND_TOPMOST, P.X, P.Y, 0, 0,
      SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOSIZE);
    TElComboButton(FButton).Down := true;
    FForm.Visible := True;
    SetWindowPos(FForm.Handle, HWND_TOPMOST, P.X, P.Y, 0, 0,
      SWP_NOACTIVATE or SWP_NOSIZE);
  end
  else
    TElComboButton(FButton).Down := false;
end;

procedure TCustomElComboBox.GetDropDownValue;
begin
  FItemIndex := FListBox.ItemIndex;
  if FItemIndex > -1 then
    Text := FListBox.Items[FItemIndex]
  else
    Text := '';
  if AutoSelect and (Text <> '') then
    SelectAll;
end;

function TCustomElComboBox.GetDroppedDown: boolean;
begin
  Result := FDroppedDown;
end;

function TCustomElComboBox.GetItems: TElFStrings;
begin
  Result := FListBox.Items;
end;

function TCustomElComboBox.GetListColor: TColor;
begin
  Result := FListBox.Color;
end;

function TCustomElComboBox.GetListInvertSelection: boolean;
begin
  Result := FListBox.InvertSelection;
end;

function TCustomElComboBox.GetSorted: boolean;
begin
  Result := FListBox.Sorted;
end;

function TCustomElComboBox.GetUseBackground: boolean;
begin
  Result := inherited UseBackground;
end;

procedure TCustomElComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  {
  if ShortCut(Key, Shift) = ButtonShortCut then
  begin
    Key := #0;
    DropDown;
  end;
  }
  {
  else
  if AutoCompletion and not FForm.Visible and (Shift = []) and (not ReadOnly) then
  begin
    if Key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_HOME, VK_END] then
      DoAutoComplete;
  end;
  }
  if (Key = VK_DOWN) or (Key = VK_UP) then
    if Shift = [ssAlt] then
      DropDown
    else
    begin
      if CanDrop then
        FListBox.Perform(WM_KEYDOWN, Key, 0);
      Key := 0;
    end
  else
  if ((Key = VK_NEXT) or (Key = VK_PRIOR)) and FForm.Visible then
  begin
    FListBox.Perform(WM_KEYDOWN, Key, 0);
    Key := 0;
  end
  else
  if (Key = VK_ESCAPE) and FForm.Visible then
  begin
    CloseUp(False);
    Key := 0;
  end
  else
  if (Key = VK_RETURN) and FForm.Visible then
  begin
    CloseUp(true);
    Key := 0;
  end;
  inherited;
end;

procedure TCustomElComboBox.ListBoxClick(Sender: TObject);
begin
  if (FListBox.ItemIndex = -1) and (FListBox.Items.Count > 0) then
    FListBox.ItemIndex := 0;
end;

procedure TCustomElComboBox.Loaded;
var
  i: integer;
begin
  inherited;
  FListBox.RecreateWnd;
  i := FItemIndex;
  FItemIndex := -2;
  ItemIndex := i;
end;

procedure TCustomElComboBox.SetDropDownCount(const Value: integer);
begin
  if (FDropDownCount <> Value) and (Value > 0) then
    FDropDownCount := Value;
end;

procedure TCustomElComboBox.SetCanDrop(const Value: boolean);
begin
  if FCanDrop <> Value then
  begin
    FCanDrop := Value;
    // FButton.KeepColor := not CanDrop;
    FButton.Enabled := Value;
    if (not FCanDrop) then
      SetDroppedDown(false);
  end;
end;

procedure TCustomElComboBox.SetDroppedDown(const Value: boolean);
begin
  if GetDroppedDown <> Value then DropDown;
end;

procedure TCustomElComboBox.SetItemIndex(const Value: Integer);
var
  ChAllowed: boolean;
begin
  if ComponentState * [csLoading, csReading] <> [] then
    FItemIndex := Value
  else
  begin
    ChAllowed := FChangeAllowed;
    if FListBox.ItemIndex <> Value then
    begin
      FListBox.OnClick := nil;
      FListBox.ItemIndex := Value;
      FListBox.OnClick := ListBoxClick;
    end;
    //if not DroppedDown then
    begin
      FItemIndex := Value;
      if not FForcedText then
      begin
        if (Value = -1) then
        begin
          if ReadOnly then
            inherited Text := '';
        end
        else
          inherited Text := Items[Value];
        SelectAll;
        LeftChar := 0;
      end;
    end;
    if ChAllowed then
      Change;
  end;
end;

procedure TCustomElComboBox.SetItems(const Value: TElFStrings);
begin
  FListBox.Items.Assign(Value);
end;

procedure TCustomElComboBox.SetListColor(const Value: TColor);
begin
  FListBox.Color := Value;
end;

procedure TCustomElComboBox.SetListInvertSelection(const Value: boolean);
begin
  FListBox.InvertSelection := Value;
end;

procedure TCustomElComboBox.SetSorted(const Value: boolean);
begin
  FListBox.Sorted := Value;
end;

procedure TCustomElComboBox.SetStyle(Value: TComboBoxStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    ReadOnly := FStyle <> csDropDown;
    if FStyle = csOwnerDrawVariable then
      FListBox.Style := lbOwnerDrawVariable
    else
      FListBox.Style := lbOwnerDrawFixed;
    RecreateWnd;
  end;
end;

procedure TCustomElComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
  ComboProc: Pointer);
begin
//  
end;

function TCustomElComboBox.GetItemHeight: Integer;
begin
  Result := FListBox.ItemHeight;
end;

procedure TCustomElComboBox.SetItemHeight(Value: Integer);
begin
  FListBox.ItemHeight := Value;
end;

procedure TCustomElComboBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  if Assigned(FOnMeasureItem) then FOnMeasureItem(Self, Index, Height);
end;

procedure TCustomElComboBox.DrawItem(Index: Integer; R: TRect; State:
{$IFNDEF VCL_5_USED}StdCtrls{$ELSE}Windows{$ENDIF}.TOwnerDrawState);
begin
  if Assigned(FOnDrawItem) then FOnDrawItem(Self, Index, R, State);
end;

function TCustomElComboBox.GetEditHandle: HWND;
begin
  Result := Handle;
end;

procedure TCustomElComboBox.SetDropDownAlignment(Value: TAlignment);
begin
  if Value <> taCenter then
    FDropDownAlignment := Value;
end;

procedure TCustomElComboBox.SetUseBackground(const Value: boolean);
begin
  if GetUseBackground <> Value then
  begin
    inherited UseBackground := Value;
    FListBox.UseBackground := Value;
  end;
end;

function TCustomElComboBox.GetDroppedIndex: integer;
begin
  result := FListBox.ItemIndex;
end;

procedure TCustomElComboBox.WMKillFocus(var Msg: TMessage);
begin
  if not HandleAllocated then exit;
  // FButton.Focused := False;
  inherited;
  if DroppedDown and (not FIgnoreFocus) then
    CloseUp(False);
end;

procedure TCustomElComboBox.WMSetFocus(var Msg: TMessage);
begin
  // FButton.Focused := True;
  inherited;
  if ReadOnly then
    HideCaret(Handle);
end;

function TCustomElComboBox.GetBtnArrowColor: TColor;
{ Returns the value for the BtnArrowColor property. }
begin
  GetBtnArrowColor := FArrowColor;
end; { GetBtnArrowColor }

procedure TCustomElComboBox.SetBtnArrowColor(newValue: TColor);
var
  FGlyph: TBitmap;
begin
  if FArrowColor <> newValue then
  begin
    FArrowColor := newValue;
    FGlyph := TBitmap.Create;
    FGlyph.Width := 9;
    FGlyph.Height := 5;
    FGlyph.PixelFormat := pf32bit;
    FGlyph.TransparentMode := tmFixed;
    FGlyph.TransparentColor := clWhite;
    FGlyph.Canvas.Brush.Color := clWhite;
    FGlyph.Canvas.FillRect(Rect(0, 0, 9, 5));
    DrawArrow(FGlyph.Canvas, eadDown, Rect(0, 1, 9, 5), FArrowColor, Enabled);
    TElComboButton(FButton).Glyph := FGlyph;
    FGlyph.Free;
    Invalidate;
  end;
end; { SetBtnArrowColor }

procedure TCustomElComboBox.SetAltBtnAlign(Value: TLeftRight);
begin
  FAltBtnAlign := Value;
  if HandleAllocated then
  begin
    SetEditRect(ClientRect);
    Invalidate;
  end;
end;

function TCustomElComboBox.GetListTransparentSelection: Boolean;
begin
  Result := FListBox.TransparentSelection;
end;

procedure TCustomElComboBox.SetListTransparentSelection(Value: Boolean);
begin
  FListBox.TransparentSelection := Value;
end;

procedure TCustomElComboBox.SetDropDownWidth(const Value: Integer);
begin
  if Value < 1 then
    FDropDownWidth := -1
  else
    FDropDownWidth := Value;
end;

procedure TCustomElComboBox.DoAutoComplete;
var
  i: integer;
  S,
    S1: TElFString;
  ssl: Integer;
begin
  ssl := SelStart;
  S := Copy(Text, 1, ssl);
  if Length(S) > 0 then
  begin
    for i := 0 to Pred(FListBox.Items.Count) do
    begin
      S1 := GetTextFromItem(i);
{$IFDEF ELPACK_UNICODE}
      if WideLowercase(S) = WideLowercase(Copy(S1, 1, Length(S))) then
{$ELSE}
      if Lowercase(S) = Lowercase(Copy(S1, 1, Length(S))) then
{$ENDIF}
      begin
        Text := S1;
        SelStart := ssl;
        SelLength := Length(Text) - ssl;
        CaretX := ssl;
        // SelStart := ssl;
        //LeftChar := 0;
        Break;
      end;
    end;
  end;
end;

procedure TCustomElComboBox.WMChar(var Message: TWMChar);
begin
  inherited;
  if AutoCompletion and (not ReadOnly) and (Message.CharCode <> 8) {and (Message.CharCode <> VK_BACK)} then
    DoAutoComplete;
end;

procedure TCustomElComboBox.SetReadOnly(Value: boolean);
begin
  inherited Readonly := Value;
  if ReadOnly then
  begin
    ControlStyle := ControlStyle - [csDoubleClicks];
  end
  else
  begin
    ControlStyle := ControlStyle + [csDoubleClicks];
    Style := csDropDown;
  end;
end;

procedure TCustomElComboBox.SetActiveBorderType(const Value: TElFlatBorderType);
begin
  inherited;
  if HandleAllocated then
    FButton.Invalidate;
end;

procedure TCustomElComboBox.SetInactiveBorderType(const Value: TElFlatBorderType);
begin
  inherited;
  if HandleAllocated then
    FButton.Invalidate;
end;

procedure TCustomElComboBox.SetLineBorderActiveColor(Value: TColor);
begin
  inherited;
  if HandleAllocated then
    FButton.Invalidate;
end;

procedure TCustomElComboBox.SetLineBorderInactiveColor(Value: TColor);
begin
  inherited;
  if HandleAllocated then
    FButton.Invalidate;
end;

procedure TCustomElComboBox.SetFlat(const Value: boolean);
begin
  inherited;
  if HandleAllocated then
    FButton.Invalidate;
end;

procedure TCustomElComboBox.CMDialogKey(var Message: TCMDialogKey);
begin
  if (Message.CharCode = VK_RETURN) and FForm.Visible then
  begin
    CloseUp(true);
    Message.result := 1;
  end
  else
    if (Message.CharCode = VK_ESCAPE) and FForm.Visible then
  begin
    CloseUp(false);
    Message.result := 1;
  end
  else
    inherited;
end;

procedure TCustomElComboBox.DestroyWnd;
begin
  if DroppedDown then
    CloseUp(false);
  inherited;
end;

procedure TCustomElComboBox.WMGetDlgCode(var Message: TMessage);
begin
  inherited;
  if DroppedDown then
    Message.result := Message.Result or DLGC_WANTALLKEYS;
end;

function TCustomElComboBox.GetShowLineHint: Boolean;
begin
  Result := FListBox.ShowLineHint;
end;

procedure TCustomElComboBox.SetShowLineHint(Value: Boolean);
begin
  FListBox.ShowLineHint := Value;
end;

procedure TCustomElComboBox.SetHorizontalScroll(const Value: Boolean);
begin
  if FHorizontalScroll <> Value then
  begin
    FHorizontalScroll := Value;
    FListBox.HorizontalScroll := Value;
    if DroppedDown then
    begin
      if Value then
        FForm.Height := FForm.Height + GetSystemMetrics(SM_CYHSCROLL)
      else
        FForm.Height := FForm.Height - GetSystemMetrics(SM_CYHSCROLL);
    end;
  end;
end;

function TCustomElComboBox.GetRightAlignedView:Boolean;
begin
  Result := FRightAlignedView;
end;

procedure TCustomElComboBox.SetRightAlignedView(Value: Boolean);
begin
  inherited;
  FListBox.RightAlignedView := RightAlignedView;
  if HandleAllocated then
  begin
    SetEditRect(ClientRect);
    Invalidate;
  end;
end;

procedure TCustomElComboBox.SetRightAlignedText(Value: Boolean);
begin
  inherited;
  FListBox.RightAlignedText := RightAlignedText;
  if HandleAllocated then
  begin
    SetEditRect(ClientRect);
    Invalidate;
  end;
end;

procedure TCustomElComboBox.SetFocusedSelectColor(newValue: TColor);
begin
  inherited;
  FListBox.FocusedSelectColor := newValue;
  FListBox.HideSelectColor := newValue;
end;

procedure TCustomElComboBox.SetFocusedSelectTextColor(newValue: TColor);
begin
  inherited;
  FListBox.FocusedSelectTextColor := newValue;
  FListBox.HideSelectTextColor := newValue;
end;

procedure TCustomElComboBox.SetHighlightAlphaLevel(Value: Integer);
begin
  inherited;
  FListBox.HighlightAlphaLevel := Value;
end;

procedure TCustomElComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  // Fake Properties:
  with GetElReader do
  begin
    Filer.DefineProperty('ListSelectedColor', FakeIdent, nil, false);
    Filer.DefineProperty('ListSelectedFontColor', FakeIdent, nil, false);
    Filer.DefineProperty('UseCustomScrollbars', FakeBoolean, nil, false);
    {$IFDEF VCL_5_USED}
    Filer.DefineProperty('VertScrollbarStyles', FakeValue, nil, false);
    Filer.DefineProperty('HorzScrollbarStyles', FakeValue, nil, false);
    Filer.DefineProperty('UseCustomScrollbars', FakeBoolean, nil, false);
    {$ENDIF}
    Filer.DefineProperty('BtnDrawFrame', FakeBoolean, nil, false);
    Filer.DefineProperty('AltBtnDrawFrame', FakeBoolean, nil, false);
  end;
  // Other properties:
  Filer.DefineProperty('BtnColor', ReadBtnColor, nil, false);
  Filer.DefineProperty('BtnArrowColor', ReadBtnArrowColor, nil, false);
  Filer.DefineProperty('BtnFlat', ReadBtnFlat, nil, false);
  Filer.DefineProperty('BtnTransparent', ReadBtnTransparent, nil, false);
  Filer.DefineProperty('AltBtnColor', ReadAltBtnColor, nil, false);
  Filer.DefineProperty('AltBtnFlat', ReadBtnFlat, nil, false);
  Filer.DefineProperty('AltBtnTransparent', ReadAltBtnTransparent, nil, false);
  Filer.DefineProperty('AltBtnVisible', ReadAltBtnVisible, nil, false);
  Filer.DefineProperty('AltBtnWidth', ReadAltBtnWidth, nil, false);
  Filer.DefineProperty('AltBtnPosition', ReadAltBtnPosition, nil, false);
  // Filer.DefineProperty('ReadOnly', ReadReadOnly, nil, false);
end;

procedure TCustomElComboBox.ReadBtnColor(Reader: TReader);
var
  C: integer;
begin
  C := ButtonColor;
  IdentToColor(Reader.ReadIdent, C);
  ButtonColor := C;
end;

function TCustomElComboBox.GetTextFromItem(Index: integer): TElFString;
begin
  Result := Items[Index];
end;

procedure TCustomElComboBox.ReadBtnArrowColor(Reader: TReader);
var
  C: integer;
begin
  C := ButtonArrowColor;
  IdentToColor(Reader.ReadIdent, C);
  ButtonArrowColor := C;
end;

procedure TCustomElComboBox.ReadBtnFlat(Reader: TReader);
begin
  ButtonFlat := Reader.ReadBoolean;
end;

procedure TCustomElComboBox.ReadBtnTransparent(Reader: TReader);
begin
  ButtonTransparent := Reader.ReadBoolean;
end;

procedure TCustomElComboBox.ReadAltBtnColor(Reader: TReader);
var
  C: integer;
begin
  C := AltButtonColor;
  IdentToColor(Reader.ReadIdent, C);
  AltButtonColor := C;
end;

procedure TCustomElComboBox.ReadAltBtnFlat(Reader: TReader);
begin
  AltButtonFlat := Reader.ReadBoolean;
end;

procedure TCustomElComboBox.ReadAltBtnTransparent(Reader: TReader);
begin
  AltButtonTransparent := Reader.ReadBoolean;
end;

procedure TCustomElComboBox.ReadAltBtnVisible(Reader: TReader);
begin
  AltButtonVisible := Reader.ReadBoolean;
end;

procedure TCustomElComboBox.ReadAltBtnWidth(Reader: TReader);
begin
  AltButtonWidth := Reader.ReadInteger;
end;

procedure TCustomElComboBox.ReadAltBtnPosition(Reader: TReader);
var
  S: string;
begin
  S := Reader.ReadIdent;
  if s = 'taRightJustify' then
    AltButtonPosition := taRightJustify
  else
    AltButtonPosition := taLeftJustify;
end;

function TCustomElComboBox.GetAltBtnGlyph: TBitmap;
begin
  Result := AltButtonGlyph;
end;

procedure TCustomElComboBox.SetAltBtnGlyph(Value: TBitmap);
begin
  AltButtonGlyph := Value;
end;

procedure TCustomElComboBox.ReadReadOnly(Reader: TReader);
begin
  if Reader.ReadBoolean then
    Self.Style := csDropDownList;
end;

function TCustomElComboBox.GetItemWidth(Index: Integer): Integer;
var
  S: TElFString;
  ARect: TRect;
begin
  S := Items[Index] + 'W';
  SetRectEmpty(ARect);
{$IFDEF ELPACK_UNICODE}
  ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(S), Length(S), ARect,
    DT_CALCRECT);
{$ELSE}
  DrawText(Canvas.Handle, PChar(S), Length(S), ARect, DT_CALCRECT);
{$ENDIF}
  result := ARect.Right;
end;

procedure TCustomElComboBox.DoExit;
begin
  if FAutoHistory and (Text <> '') then
    AutoHistoryUpdate;

  inherited;
end;

procedure TCustomElComboBox.SetUseXPThemes(const Value : boolean);
begin
  inherited;
  FListBox.UseXPThemes := Value;
end;

procedure TCustomElComboBox.PaintText(Canvas : TCanvas);
var
  R: TRect;
{$IFNDEF VCL_5_USED}
  i: Word;
  T: StdCtrls.TOwnerDrawState;
{$ENDIF}
begin
  if (FItemIndex > -1) and ((FStyle = csOwnerDrawFixed) or (FStyle =
    csOwnerDrawVariable)) then
  begin
    R := EditRect;

    FCanvas := Canvas;
{$IFDEF VCL_5_USED}
    DrawItem(FItemIndex, R, [odComboBoxEdit]);
{$ELSE}
    i := 4096;
    Move(i, T, sizeof(i));
    DrawItem(FItemIndex, R, T);
{$ENDIF}
  end
  else
    inherited;
end;

procedure TCustomElComboBox.WMDeadChar(var Message: TWMDeadChar);
begin
  inherited;
  {$ifdef ELPACK_USE_INPUTPROCESSOR}
  if (Style <> csDropDown) and AutoCompletion then
  begin
    Input.WMDeadChar(Message);
  end;
  {$endif}
end;

procedure TCustomElComboBox.WMIMEComposition(var Message: TMessage);
begin
  inherited;
  {$ifdef ELPACK_USE_INPUTPROCESSOR}
  if (Style <> csDropDown) and AutoCompletion then
  begin
    Input.WMImeComposition(Message);
    DoPerformSearch(Input.Text);
  end;
  {$endif}
end;

procedure TCustomElComboBox.WMIMEStartComposition(var Message: TMessage);
{$ifdef ELPACK_USE_INPUTPROCESSOR}
var
  IMC: HIMC;
  LogFont: TLogFont;
  CF: TCompositionForm;
{$endif}
begin
  inherited;
  {$ifdef ELPACK_USE_INPUTPROCESSOR}
  if (Style <> csDropDown) and AutoCompletion then
  begin
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
  end;
  {$endif}
end;

{$ifdef ELPACK_USE_INPUTPROCESSOR}
procedure TCustomElComboBox.StartClearSearchTimeoutThread;
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

procedure TCustomElComboBox.StopClearSearchTimeoutThread;
begin
  if Assigned (SearchTextTimeoutThread) then
  begin
    SearchTextTimeoutThread.OnTerminate := nil ;
    SearchTextTimeoutThread.Terminate ;

    SearchTextTimeoutThread := nil
  end
end ;

procedure TCustomElComboBox.DoPerformSearch(SearchText : TElFString);
var
  liIndex : Integer ;
  ItemText  : TElFString;
begin
  if (SearchText <> '') then
  begin

    for liIndex := 0 to (Items.Count - 1) do
    begin
      ItemText := Items[liIndex];

      if DoCompareItems(SearchText, liIndex) then
      begin
        ItemIndex := liIndex;
        Change;
        break;
      end ;
    end;
    StartClearSearchTimeoutThread;
  end;
end;

procedure TCustomElComboBox.SearchTextTimeout(Sender : TObject);
begin
  SearchTextTimeoutThread := nil ;
  Input.Reset;
end;

function TCustomElComboBox.DoCompareItems(SearchText : String; ItemIndex :
    integer): Boolean;
begin
  {$ifdef ELPACK_UNICODE}
    Result := WideSameText(SearchText, WideCopy(Items[ItemIndex], 1, Length(SearchText)));
  {$else}
    Result := AnsiSameText(SearchText, Copy (Items[ItemIndex], 1, Length(SearchText)));
  {$endif}
end;

{$endif}

function TCustomElComboBox.GetImages: TImageList;
begin
  Result := FListBox.Images;
end;

procedure TCustomElComboBox.SetImages(Value: TImageList);
begin
  FListBox.Images := Value;
end;

function TCustomElComboBox.GetAlphaForImages: TImageList;
begin
  Result := FListBox.AlphaForImages;
end;

procedure TCustomElComboBox.SetAlphaForImages(Value: TImageList);
begin
  FListBox.AlphaForImages := Value;
end;

procedure TCustomElComboBox.SetEditRect(Value : TRect);
begin
  if (Images <> nil) then
    LeftMargin := Images.Width + 2
  else
    LeftMargin := 1;

  inherited SetEditRect(Value);
end;

procedure TCustomElComboBox.SetShowGripper(Value: Boolean);
begin
  if FShowGripper <> Value then
  begin
    FShowGripper := Value;
    SetWindowPos(FForm.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE or SWP_FRAMECHANGED);
  end;
end;

function TElComboButton.GetThemedClassName: WideString;
begin
  if Parent <> nil then
  begin
    if Self = TCustomElComboBox(Parent).FButton then
      Result := 'COMBOBOX'
    else
      result := inherited GetThemedClassName;
  end
  else
    result := inherited GetThemedClassName;
end;

function TElComboButton.GetThemePartID: Integer;
begin
  if Parent <> nil then
  begin
    if Self = TCustomElComboBox(Parent).FButton then
      result := CP_DROPDOWNBUTTON
    else
      result := inherited GetThemePartID;
  end
  else
    result := inherited GetThemePartID;
end;

function TElComboButton.GetShowGlyph: Boolean;
begin
  if Parent <> nil then
  begin
    Result := (not TCustomElComboBox(Parent).IsThemeApplied) or (TCustomElComboBox(Parent).FAltButton = Self);
  end
  else
    result := true;
end;

function TElComboButton.GetThemeStateID: Integer;
begin
  if Parent <> nil then
  begin
    if Self = TCustomElComboBox(Parent).FButton then
    begin
      if not Enabled then
        result := CBXS_DISABLED
      else
        if FState in [ebsDown, ebsExclusive] then
        result := CBXS_PRESSED
      else
        if FMouseInControl or FMouseInArrow or Focused then
        result := CBXS_HOT
      else
        result := CBXS_NORMAL;
    end
    else
      result := inherited GetThemeStateID;
  end
  else
    result := inherited GetThemeStateID;
end;

end.
