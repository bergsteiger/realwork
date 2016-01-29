unit fcColorCombo;
{
//
// Components : TfcColorCombo
//
// Copyright (c) 1999 by Woll2Woll Software
//
// Changes:
// 3/19/99 -PYW- Rect is already correct now, so do not use GetIconIndent
//               when colorcombo is not in a grid and not focused.
// 3/25/99 -PYW- Exit if Combo is being destroyed to handle recordviewpanel support.
// 4/13/99 -PYW- Added Shift Select Support.
// 4/13/99 -PYW- Make sure events are set before adding all of the colors
}

{//**************************************************
// Ideas: Add event to display different name when displaying list.
// Ideas: Code to add Standard 255 Colors exists add another option for it?
// Ideas: Add ColorDialog Standard Colors option?}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Menus,
  fccombo,fccommon,dbctrls,db,dbtables,grids;

{$i fcIfDef.pas}

const
  ColorRectMargin = 2;

type
  TfcOwnerDrawState = (odsChecked, odsComboBoxEdit, odsDefault, odsDisabled, odsFocus, odsGrayed, odsSelected);
  TfcOwnerDrawStates = set of TfcOwnerDrawState;

  TfcSortByOption = (csoNone, csoByRGB, csoByIntensity, csoByName);

  TfcColorListBoxOption = (ccoShowSystemColors, ccoShowColorNone, ccoShowCustomColors, ccoShowStandardColors,
      ccoShowColorNames, ccoShowGreyScale, ccoGroupSystemColors);
  TfcColorListBoxOptions = set of TfcColorListBoxOption;

  TfcColorDialogOption = (cdoEnabled, cdoPreventFullOpen,
                          cdoFullOpen, cdoSolidColor, cdoAnyColor);
  TfcColorDialogOptions = set of TfcColorDialogOption;

  TfcColorDialogEvent = procedure(Sender: TObject; Dialog: TColorDialog) of object;
  TfcCloseColorDialogEvent = procedure(Sender: TObject; Dialog: TColorDialog; MResult: TModalResult; var Accept: Boolean) of object;
//  TfcCloseColorComboEvent = procedure(Sender: TObject; Accept: Boolean) of object;
  TfcAddNewColorEvent = procedure(Sender: TObject; AColor:TColor; var AColorName:String;
     var Accept: Boolean) of object;

  TfcOnFilterColorEvent = procedure(Sender: TObject; AColor:TColor; AColorName:String;
     var Accept: Boolean) of object;

  TfcColorListFiller = class
  private
    FOptions:TfcColorListBoxOptions;
    FList:TStringList;
  public
    procedure ColorCallbackProc(const s: String);
    procedure FillColorList(var AList:TStringList;AOptions:TfcColorListBoxOptions;NoneString:String);
  end;

  TfcCustomColorCombo = class;

  TfcCustomColorList = class(TCustomListBox)
  private
    { Private declarations }
    FAlignment: TLeftRight;
    FColorAlignment: TLeftRight;
    FColorWidth: Integer;
    FOptions: TfcColorListBoxOptions;
    FCustomColors: TStringList;
    FHighlightColor: TColor;
    FHighlightTextColor: TColor;
    FAllColors: TStringList;
    FSelectedColor: TColor;
    FOldSelectedColor: TColor;
    FSortByOption : TfcSortByOption;
    FTempColors: TStringList;
    FGreyScaleIncrement: Integer;
    FNoneString : String;
    FOnAddNewColor: TfcAddNewColorEvent;
    FOnFilterColor: TfcOnFilterColorEvent;
    FPrevItem : Integer;
    FLastPoint: TPoint;
    FCloseOnUp: Boolean;
    ItemIDMap: TList;
    FClickedInControl: Boolean;
    FIgnoreMouseScroll: Boolean;
    FListBoxUpdated: boolean;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure SetAlignment(Value: TLeftRight);
    procedure SetColorAlignment(Value: TLeftRight);
    procedure SetOptions(Value: TfcColorListBoxOptions);
    procedure SetColorWidth(Value: Integer);
    procedure SetSelectedColor(Value: TColor);
    procedure SetNoneString(Value: String);
    procedure SetGreyScaleIncrement(Value: Integer);
    procedure SetSortBy(Value: TfcSortByOption);
    procedure SetCustomColors(Value: TStringList);
    function GetSelectedColor: TColor;
    function GetEditRectHeight: Integer;
//    procedure ListChange(Sender: TObject);
    function GetItemIndex: integer;
    Procedure SetItemIndex(Value: integer);
    function GetHighlightColor: TColor;
    function GetHighlightTextColor: TColor;
//    function MapItemID(val: integer): integer;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    { Protected declarations }
    function AddToAllColors(AName:String;AValue:String): Boolean; virtual;
    procedure Click; override;
    procedure CreateWnd; override;
    procedure CustomColorsChangeEvent(Sender: TObject); virtual;
    function HasDuplicateNames(var dup:String): Boolean; virtual;
    procedure Loaded; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    Patch: Variant;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitColorList; virtual;
    procedure SortList; virtual;
    procedure UpdateItems; virtual;
    procedure DoDrawItem(ACanvas:TCanvas; Index, CWidth, CHeight:Integer; Rect: TRect;
       State: TOwnerDrawState;  Text:String; AColor:TColor); virtual;
    function ColorFromIndex(Index: Integer):TColor; virtual;
    property SelectedColor: TColor read GetSelectedColor write SetSelectedColor;
    property OldSelectedColor: TColor read FOldSelectedColor write FOldSelectedColor;
    property AllColors: TStringList read FAllColors;
    property Alignment: TLeftRight read FAlignment write SetAlignment default taLeftJustify;
    property ColorAlignment: TLeftRight read FColorAlignment write SetColorAlignment default taLeftJustify;
    property ColorWidth: Integer read FColorWidth write SetColorWidth;
    property CustomColors: TStringList read FCustomColors write SetCustomColors;
    property GreyScaleIncrement: Integer read FGreyScaleIncrement write SetGreyScaleIncrement default 15;
    property HighlightColor: TColor read FHighlightColor write FHighlightColor;
    property HighlightTextColor: TColor read FHighlightTextColor write FHighlightTextColor;
    property ItemIndex read GetItemIndex write SetItemIndex;
    property NoneString: String read FNoneString write SetNoneString;
    property Options: TfcColorListBoxOptions read FOptions write SetOptions;
    property SortBy: TfcSortByOption read FSortByOption write SetSortBy default csoNone;
    property OnAddNewColor: TfcAddNewColorEvent read FOnAddNewColor write FOnAddNewColor;
    property OnFilterColor: TfcOnFilterColorEvent read FOnFilterColor write FOnFilterColor;
    { Published declarations }
  end;

  TfcColorList = class(TfcCustomColorList)
  published
    {$ifdef fcDelphi4Up}
    property Anchors;
    property Constraints;
    {$endif}
    property Align;
    property Alignment;
    property BorderStyle;
    property Color;
    property ColorAlignment;
    property ColorWidth;
    property Ctl3D;
    property CustomColors;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ExtendedSelect;     //4/13/99 - PYW - Added Shift Select Support.
    property Font;
    property GreyScaleIncrement;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property MultiSelect;
    property NoneString;
    property Options;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property SelectedColor;   //3/2/99 - Added SelectedColor and removed ItemIndex.
    property SortBy;
    property OnAddNewColor;
    property OnFilterColor;
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
    property ParentColor;
    property ShowHint;
    property TabOrder;
    property Visible;
    property ItemHeight;
  end;

  TfcColorListOptions = class(TPersistent)
  private
     FCombo:TfcCustomColorCombo;
     FColor:TColor;
     FColorWidth: Integer;
     FFont: TFont;
     FGreyScaleIncrement: Integer;
     FIntegralHeight:Boolean;
     FItemHeight:Integer;
     FOptions: TfcColorListBoxOptions;
     FSortByOption : TfcSortByOption;
     FNoneString : String;

     procedure SetColor(Value: TColor);
     procedure SetColorWidth(Value: Integer);
     procedure SetFont(Value: TFont);
     procedure SetGreyScaleIncrement(Value: Integer);
     procedure SetIntegralHeight(Value: Boolean);
     procedure SetItemHeight(Value: Integer);
     procedure SetNoneString(Value: String);
     procedure SetSortBy(Value: TfcSortByOption);
     function StoreNoneString: boolean;
  protected
     procedure SetOptions(Value: TfcColorListBoxOptions);
  published
     constructor Create(AOwner: TfcCustomColorCombo);
     destructor Destroy; override;
     property Color: TColor read FColor write SetColor default clWindow;
     property ColorWidth: Integer read FColorWidth write SetColorWidth default 0;
     property Font: TFont read FFont write SetFont;
     property GreyScaleIncrement: Integer read FGreyScaleIncrement write SetGreyScaleIncrement default 10;
     property IntegralHeight: Boolean read FIntegralHeight write SetIntegralHeight default True;
     property ItemHeight: Integer read FItemHeight write SetItemHeight default 16;
     property NoneString: String read FNoneString write SetNoneString stored StoreNoneString;
     property Options : TfcColorListBoxOptions read FOptions write SetOptions default [ccoShowStandardColors, ccoShowColorNames];
     property SortBy: TfcSortByOption read FSortByOption write SetSortBy default csoNone;
  end;

  TfcColorComboDataType = (ccdColorName,ccdColor);   //Maybe add ccdColorHex?

  TfcCustomColorCombo = class(TfcCustomCombo)
  private
    FAlignment: TLeftRight;
//    FAlignmentVertical: TfcAlignVertical;
    FAutoDropDown: boolean;
    InAutoDropDown: boolean;
    FColorAlignment: TLeftRight;
    FColorDialog: TColorDialog;
    FShowMatchText: Boolean;

    FCustomColors: TStringList;

//    FDataType: TfcColorComboDataType;

    FListbox: TfcColorList;
    FSelectedColor: TColor;
    FDropDownWidth: integer;
    FColorListOptions: TfcColorListOptions;

    FOnDrawItem: TDrawItemEvent;
    FOnInitColorDialog: TfcColorDialogEvent;
    FOnCloseColorDialog: TfcCloseColorDialogEvent;
    FColorDialogOptions: TfcColorDialogOptions;
    FItemIndex: Integer;
    SkipDataChange: Boolean;
    SkipTextChange: Boolean;
    SkipDropDown:Boolean;
//    FOnCloseUp: TNotifyEvent;
    FCloseOnUp: Boolean;
    FOriginalIndex: Integer;
    FOriginalSelectedColor: TColor;
    FSelectedItemIndex: Integer;
    FOnAddNewColor: TfcAddNewColorEvent;
    FOnFilterColor: TfcOnFilterColorEvent;

    procedure SetAlignment(Value: TLeftRight);
//    procedure SetAlignmentVertical(Value: TfcAlignVertical);
    procedure SetColorAlignment(Value: TLeftRight);
    procedure SetCustomColors(Value: TStringList);
    procedure SetItemIndex(Value: integer);
    procedure SetSelectedColor(Value: TColor);

    procedure CustomColorsChangeEvent(Sender: TObject);
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN; {handle tab}
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    function GetSelectedColorString: string;
    procedure SetSelectedColorString(Value: string);
    procedure UpdateSelectedColor;
    function GetEffectiveAlignment: TLeftRight;
protected
    procedure AddNewColorEvent(Sender: TObject; AColor:TColor;
      var AColorName:String;  var Accept: Boolean); virtual;
    procedure OnFilterColorEvent(Sender: TObject; AColor:TColor;
      AColorName:String;  var Accept: Boolean); virtual;

    function GetComboColor(Index:Integer): TColor; virtual;
    function GetComboDataType:TfcColorComboDataType; virtual;
    function GetComboDisplayText(Value:integer): String; virtual;
    function GetTextRect(ARect:TRect;Highlight:Boolean): TRect; virtual;
    procedure ListBoxNeeded; virtual;
    procedure PaintToCanvas(ACanvas: TCanvas; Rect: TRect; Highlight, GridPaint: Boolean;
      Text: string); override;
    procedure Paint; override;

    procedure CreateWnd; override;
    procedure DataChange(Sender: TObject); override;
    Function Editable: boolean; override;
    function EditCanModify: Boolean; override;
    function GetDropDownControl: TWinControl; override;
    function GetDropDownContainer: TWinControl; override;
    function GetItemCount: Integer; override;
    function GetItemSize: TSize; override;
//    procedure HandleDropDownKeys(var Key: Word; Shift: TShiftState); override;
    procedure HideCaret; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    function GetIndentLeft(Rect: TRect): Integer; virtual;
    function GetRightIndent(Rect:TRect): Integer; override;
    function GetTopIndent: Integer; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    Procedure DrawColorRect(ACanvas:TCanvas;Rect:TRect;CurColor:TColor;Highlight:Boolean); virtual;
    procedure SetComboText(Value:String); virtual;

    procedure SetEditRect; override;
    procedure ShowCaret; override;
    procedure UpdateData(Sender: TObject); override;
    procedure WndProc(var Message: TMessage); override;
    property OnDrawItem: TDrawItemEvent read FOnDrawItem write FOnDrawItem;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SelectAll; override;
    procedure CloseUp(Accept: Boolean); override;
    function ColorString(s: string): string;
    function IsCustomColor(s: string): Boolean;
    Function IsDroppedDown: boolean; override;
    procedure DrawInGridCell(ACanvas:TCanvas;Rect:TRect;State:TGridDrawState); override;
    procedure DropDown; override;
    Function ExecuteColorDialog: boolean; virtual;
    function GetColorFromRGBString(RGBString:String; var AColor:TColor):boolean;
    Procedure GetColorRectInfo(Rect:TRect;var AWidth:Integer;var AHeight:Integer);
    procedure RefreshList; virtual;

    property ListBox: TfcColorList read FListBox;
    property DroppedDown: boolean read isDroppedDown;
    property SelectedColor: TColor read FSelectedColor write SetSelectedColor;

    property UnboundAlignment: TLeftRight read GetEffectiveAlignment write SetAlignment default taLeftJustify;
//    property AlignmentVertical: TfcAlignVertical read FAlignmentVertical write SetAlignmentVertical default fcavTop;
    property AutoDropDown : boolean read FAutoDropDown write FAutoDropDown default False;
    property ButtonStyle default cbsDownArrow;
    property ColorAlignment: TLeftRight read FColorAlignment write SetColorAlignment default taLeftJustify;
    //3/4/99 - Unused property.
//    property ColorDataType: TfcColorComboDataType read FDataType write FDataType default ccdColorName;
    property ColorDialog: TColorDialog read FColorDialog write FColorDialog;
    property ColorDialogOptions: TfcColorDialogOptions read FColorDialogOptions write FColorDialogOptions default [cdoPreventFullOpen];
    property ColorListOptions: TfcColorListOptions read FColorListOptions write FColorListOptions;
    property CustomColors: TStringList read FCustomColors write SetCustomColors;
    property SelectedColorString: string read GetSelectedColorString write SetSelectedColorString;
//    property DropDownCount : integer read FDropDownCount write FDropDownCount default 8;
    property DropDownWidth: Integer read FDropDownWidth write FDropDownWidth default 0;
    property ItemIndex: integer read FItemIndex write SetItemIndex;
    property ShowMatchText: Boolean read FShowMatchText write FShowMatchText default True;
    property OnAddNewColor: TfcAddNewColorEvent read FOnAddNewColor write FOnAddNewColor;
    property OnFilterColor: TfcOnFilterColorEvent read FOnFilterColor write FOnFilterColor;
//    property OnCloseUp;//: TfcCloseColorComboEvent read FOnCloseUp write FOnCloseUp;
//    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
    property OnInitColorDialog: TfcColorDialogEvent read FOnInitColorDialog write FOnInitColorDialog;
    property OnCloseColorDialog: TfcCloseColorDialogEvent read FOnCloseColorDialog write FOnCloseColorDialog;
//    property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
  end;

  TfcColorCombo = class(TfcCustomColorCombo)
  published
    {$ifdef fcDelphi4Up}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property ParentBiDiMode;
    {$endif}

    property DataField;
    property DataSource;
    property InfoPower;

    property UnboundAlignment;
    property AlignmentVertical;
    property AllowClearKey;
    property AutoDropDown;
    property AutoSelect;
    property AutoSize;
    property ShowButton;
    property BorderStyle;
    property ButtonStyle;
    property CharCase;
    property Color;
    property ColorAlignment;
    //3/4/99 - Unused property.
    //property ColorDataType;
    property ColorDialog;
    property ColorDialogOptions;
    property ColorListOptions;
    property CustomColors;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property Font;
    {$ifdef ver100}
    property ImeMode;
    property ImeName;
    {$endif}
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property ShowMatchText;
    property SelectedColor;
    property Style default csDropDownList;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnAddNewColor;
    property OnFilterColor;    
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnCloseUp;
    property OnInitColorDialog;
    property OnCloseColorDialog;
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

//procedure Register;

implementation

//       {$R FirstClass.dcr}
{May wish to move the following functions to some common file}
{function ColorStringToHex(AColor: string): TColor;
var HexString: string;
begin
  result := clNone;
  HexString := AColor;
  if HexString = '' then Exit;
  HexString := '$00' + HexString;
  result := StringToColor(HexString);
end;}

{$ifndef fcDelphi4Up}
function fcIsInwwObjectView(control: TWinControl):boolean;
begin
  result := False;
end;
function fcIsInwwObjectViewPaint(control: TWinControl):boolean;
begin
  result := False;
end;
{$endif}

procedure TfcCustomColorList.CustomColorsChangeEvent(Sender: TObject);
begin
   InitColorList;
end;

procedure TfcCustomColorList.WMNCHitTest(var Message: TWMNCHitTest);
begin
  DefaultHandler(Message);
end;

procedure TfcCustomColorList.Click;
begin
  OldSelectedColor := FSelectedColor;
  FSelectedColor := StringToColor('$'+Items.Values[Items.Names[ItemIndex]]);
  //2/26/99 - Moved to ensure SelectedColor is updated before click event.
  inherited;
end;

procedure FillColorList(var AList: TStringList;AOptions:TfcColorListBoxOptions;NoneString:String);
var fill:TfcColorListFiller;
begin
   fill:= TfcColorListFiller.create;
   fill.FillColorList(AList,AOptions,NoneString);
   fill.free;
end;

{function ColorNamesCompare(s1,s2: string): Integer;
var placement1, placement2: Integer;
    Value1, Value2:String;
begin
  placement1 := 1;
  placement2 := 1;

  value1:= Copy(s1,pos('=',s1)+1,8);
  value2 := Copy(s2,pos('=',s2)+1,8);
  if StringToColor('$'+value1) = clNone then
     placement1 := 0;
  if StringToColor('$'+value2) = clNone then
     placement2 := 0;

  if placement1 < placement2 then result := -1
  else if placement1 > placement2 then result := 1
  else result := AnsiComparestr(Copy(s1,1,pos('=',s1)),Copy(s2,1,pos('=',s2)));
end;
}

function ColorNamesCompareGroupSys(s1,s2: string): Integer;
var placement1, placement2: Integer;
    Value1, Value2: string;
begin
   if (Length(Copy(s1,pos('=',s1)+1,length(s1)))=8) and
      (AnsiComparestr(Copy(s1,pos('=',s1)+1,2),'80')=0) then
     placement1 := 2  //Group System Colors
   else placement1 := 1;

   if (Length(Copy(s2,pos('=',s2)+1,length(s2)))=8) and
      (AnsiComparestr(Copy(s2,pos('=',s2)+1,2),'80')=0) then
     placement2 := 2  //Group System Colors
   else placement2 := 1;

   value1:= Copy(s1,pos('=',s1)+1,8);
   value2 := Copy(s2,pos('=',s2)+1,8);
   if StringToColor('$'+value1) = clNone then
     placement1 := 0;
   if StringToColor('$'+value2) = clNone then
      placement2 := 0;

   if placement1 < placement2 then result := -1
   else if placement1 > placement2 then result := 1
   else result := AnsiComparestr(Copy(s1,1,pos('=',s1)),Copy(s2,1,pos('=',s2)));
end;

function ColorCompare(s1,s2: string;sortby:TfcSortByOption;seperatesyscolors:boolean): Integer;
var red1,green1,blue1,reserved1:Byte;
    red2,green2,blue2,reserved2:Byte;
    placement1, placement2: integer;

  function Highest(int1, int2, int3: integer): integer;
  begin
    if (int1=int2) and (int1=int3) then result :=0
    else if (int1 >= int2) and (int1 >= int3) then result := 1
    else if (int2 >= int1) and (int2 >= int3) then result := 2
    else result := 3;
  end;

  function Lowest(int1, int2, int3: integer): integer;
  begin
    if (int1 = int2) and (int1 = int3) then result := 0
    else if (int1 <= int2) and (int1 <= int3) then result := 1
    else if (int2 <= int1) and (int2 <= int3) then result := 2
    else result :=3;
  end;

  function GetAverage(r1,g1,b1:integer):integer;
  begin
    result := (r1+g1+b1) div 3;
  end;

  function GetPlacement(r,g,b: integer): integer;
  var tolerance:integer;
      val:double;
  begin
    tolerance:=16;     //?Maybe make this configurable???? Public property?
    result := 15;
    if Highest(r,g,b)=0 then begin
       exit;
    end
    else if Highest(r,g,b)=1 then begin
       if (R>G) and (G>B) then begin
          val := (R-G);
          val := (val/R)*100.0;
          if (val < tolerance) then result := 2     //GreenishYellow color
          else begin
             val := (G/R)*100.0;
             if (val < tolerance) then
                result := 14
             else result :=1;
          end;
       end
       else if (R=G) and (G>B) then result :=2
       else if (R=B) and (B>G) then result :=12
       else if (R>B) and (B>G) then begin
          val := (R-B);
          val := (val/R)*100.0;
          if (val < tolerance) then result := 12     //GreenishYellow color
          else begin
             val := (B/R)*100.0;
             if (val < tolerance) then result := 14
             else result :=13;
          end;
       end
       else if (R>G) and (G=B) then result :=14
    end
    else if Highest(r,g,b)=2 then begin
       if (G>B) and (B>R) then begin
          val := (G-B);
          val := (val/G)*100.0;
          if (val < tolerance) then
             result := 7                 //Treat as G=B Placement
          else begin
             val := (B/G)*100.0;
             if (val < tolerance) then result := 4  //Treat as basically Green
             else result :=6;           //Treat as before G>B
          end;
       end
       else if (G>R) and (R>B) then begin
          val := (G-R);
          val := (val/G)*100.0;
          if (val < tolerance) then
             result := 3      //Treat as G=R
          else begin
             val := (R/G)*100.0;
             if (val < tolerance) then result := 4
             else result :=3;
          end;
       end
       else if (G>R) and (R=B) then result :=5
       else if (G=B) and (B>R) then result :=7
    end
    else if Highest(r,g,b)=3 then begin
       if (B>G) and (G>R) then begin
          val := (B-G);
          val := (val/B)*100.0;
          if (val < tolerance) then result := 7
          else begin
            val := (G/B)*100.0;
            if (val < tolerance) then result := 9
            else result :=8
          end;
       end
       else if (B>G) and (G=R) then result :=10
       else if (B>R) and (R>G) then
       begin
          val := (B-R);
          val := (val/B)*100.0;
          if (val < tolerance) then result := 12
          else begin
            val := (R/B)*100.0;
            if val < tolerance then result :=9
            else result :=11;
          end;
       end
    end
  end;
begin
   if s1=s2 then begin
     result := 0;
     exit;
   end;

   //Get RGB values for each color....
   fcColorToByteValues(ColorToRGB(StringToColor('$'+s1)),reserved1,blue1,green1,red1);
   fcColorToByteValues(ColorToRGB(StringToColor('$'+s2)),reserved2,blue2,green2,red2);

   //Sort either by csoByRGB or csoByIntensity
   if (SortBy = csoByRGB) then begin
     placement1 := getplacement(red1,green1,blue1);
     placement2 := getplacement(red2,green2,blue2);
   end
   else begin
   {For Intensity Seperate Colors and Greys. Put GreyScale at the Bottom}
      if (red1=green1) and (red1=blue1) then
         placement1:= 2
      else placement1:=1;

      if (red2=green2) and (red2=blue2) then
         placement2:= 2
      else placement2:=1;
   end;

   if seperatesyscolors then begin
      if (Copy(s1,1,2)='80') then
         placement1 := placement1+16;
      if (Copy(s2,1,2)='80') then
         placement2 := placement2+16;
   end;

   if s1='1FFFFFFF' then
      placement1 := 0;

   if s2='1FFFFFFF' then
      placement2 := 0;

   if placement1 < placement2 then result := -1
   else if placement1 > placement2 then result := 1
   else begin
      if (not (SortBy = csoByRGB)) or ((placement1 mod 2) = 1) then begin
        if GetAverage(red1,green1,blue1) < GetAverage(red2,green2,blue2) then
           result :=-1
        else if GetAverage(red1,green1,blue1) > GetAverage(red2,green2,blue2) then
           result :=1
        else result :=0;
      end
      else begin
        if GetAverage(red1,green1,blue1) > GetAverage(red2,green2,blue2) then
           result :=-1
        else if GetAverage(red1,green1,blue1) < GetAverage(red2,green2,blue2) then
           result :=1
        else result :=0;
      end;
   end;
end;

function RGBCompareGroupSys(s1,s2: string): Integer;
begin
  result := ColorCompare(s1,s2,csoByRGB,True);
end;

function IntensityCompareGroupSys(s1,s2: string): Integer;
begin
  result := ColorCompare(s1,s2,csoByIntensity,True);
end;

function RGBCompare(s1,s2: string): Integer;
begin
  result := ColorCompare(s1,s2,csoByRGB,False);
end;

function IntensityCompare(s1,s2: string): Integer;
begin
  result := ColorCompare(s1,s2,csoByIntensity,False);
end;

procedure TfcColorListFiller.ColorCallbackProc(const s: String);
var AColorInt: LongInt;
    AColor: TColor;
begin
   IdentToColor(s, AColorInt);
   AColorInt := AColorInt and $00ffffff;//$0080000000;
   AColor := StringToColor(s);

   //clBlack should only show up with Standard Colors and not be associated
   //with System Colors.
   if (S='clBlack') and (ccoShowStandardColors in FOptions) then
      Flist.Add(Copy(S, 3, Length(s) - 2) + '=' + InttoHex(AColor, 6))
   else if ((S<>'clBlack') and (S<> 'clNone') and
       (((ccoShowStandardColors in FOptions) and (not (AColorInt in [COLOR_SCROLLBAR..COLOR_ENDCOLORS]))
       or ((AColorInt in [COLOR_SCROLLBAR..COLOR_ENDCOLORS]) and (ccoShowSystemColors in FOptions))))) then
      Flist.Add(Copy(S, 3, Length(s) - 2) + '=' + IntToHex(AColor,6));
end;

procedure TfcColorListFiller.FillColorList(var AList: TStringList;AOptions:TfcColorListBoxOptions;NoneString:String);
begin
   FList:=AList;
   if (ccoShowColorNone in AOptions) then
      FList.Add(NoneString+'='+IntToHex(clNone,6));
   FOptions := AOptions;
   GetColorValues(ColorCallbackProc);
   AList := FList;
end;

//***************** TfcColorList ********************************
procedure TfcCustomColorList.Loaded;
begin
  inherited Loaded;
  InitColorList;           //Maybe should always call?
end;

procedure TfcCustomColorList.CreateWnd;
begin
  inherited CreateWnd;
  InitColorList;           //Maybe should always call?
  if not (Owner is TfcCustomColorCombo) then exit;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, wm_SetFocus, 0, 0);
end;

constructor TfcCustomColorList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := [ccoShowStandardColors,ccoShowColorNames];
  FCustomColors := TStringList.Create;
  FTempColors := TStringList.Create;
  FAllColors := TStringList.Create;
  FAlignment := taLeftJustify;
  FColorAlignment := taLeftJustify;
  FSortByOption := csoNone;
  FGreyScaleIncrement := 10;
  FSelectedColor := clNullColor;
  FHighlightColor := clNone;
  FHighlightTextColor := clNone;
  ColorWidth := GetEditRectHeight-1;
  //3/3/99 -PYW- Don't Default to True because of align issues.
  // IntegralHeight:= True;
  ControlStyle := ControlStyle - [csFixedHeight];
  {$IFDEF WIN32}
     ControlStyle := ControlStyle + [csReplicatable];
  {$ENDIF}
  FCustomColors.OnChange := CustomColorsChangeEvent;
  FCloseOnUp := True;
  ItemIDMap:= TList.create;
end;

destructor TfcCustomColorList.Destroy;
begin
//  DestroyHandle;
  ItemIDMap.Free;
  FCustomColors.Free;
  FAllColors.Free;
  FTempColors.Free;
  inherited Destroy;
end;

{ RSW }
procedure TfcCustomColorList.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Items.count<=0 then begin
     FCloseOnUp := True;
     exit;
  end;

  if (Button = mbLeft) and FCloseOnUp and
     (PtInRect(ClientRect, Point(X, Y))) then
  begin
    SelectedColor := StringToColor('$'+Items.Values[Items.Names[ItemIndex]]);
  end;

  inherited;
  if (Button= mbLeft) and FCloseOnUp and (Owner is TfcCustomColorCombo) and
     (FClickedInControl or PtInRect(ClientRect, Point(X, Y))) then
    (Owner as TfcCustomColorCombo).CloseUp(PtInRect(ClientRect, Point(X, Y)));

  FCloseOnUp := True;
  if not FClickedInControl then FIgnoreMouseScroll := True;
end;

procedure TfcCustomColorList.MouseMove(Shift: TShiftState; X, Y: Integer);
var itemno:integer;
begin
  if (not FIgnoreMouseScroll) and (not FClickedInControl) and PtInRect(ClientRect, Point(x, y)) then
  begin
    if not ((FLastPoint.X=0) and (FLastPoint.Y=0)) and (Owner is TfcCustomColorCombo) then
       PostMessage(Handle, WM_LBUTTONDOWN, 0, 0); // Added to allow one-click selection and dragging.  -ksw (2/18/99)
  end;

  inherited;
  if (FLastPoint.X=0) and (FLastPoint.Y=0) then
     FLastPoint := Point(X,Y);
  if (FLastPoint.X = X) and (FLastPoint.Y = Y) then Exit;

  if not (Owner is TfcCustomColorCombo) then exit;
  if FIgnoreMouseScroll then exit;
  itemno := ItemAtPos(Point(X,Y),True);
  if FPrevItem = itemno then exit;
  if (ItemIndex <> itemno) and (itemno >=0) then
     SendMessage(Handle, LB_SETCURSEL, itemno, 0);
     //ItemIndex := itemno;
  FPrevItem := itemno;
  FLastPoint := Point(X,Y);
end;

function TfcCustomColorList.HasDuplicateNames(var dup:String): Boolean;
var i,j:integer;
  function CompareColorStrings(s1,s2: string): Integer;
  begin
     if (AnsiCompareStr(s1,NoneString) = 0) and
        (AnsiCompareStr(s2,NoneString) <> 0) then
        result := -1
     else if (AnsiCompareStr(s2,NoneString) = 0) and
        (AnsiCompareStr(s1,NoneString) <> 0) then
        result := 1
     else
        result := AnsiComparestr(s1,s2);
  end;
begin
  result := False;
  for i:= 0 to FAllColors.count-1 do begin
     for j:=i+1 to FAllColors.Count-1 do begin
         if CompareColorStrings(FAllColors.Names[i],FAllColors.Names[j])=0 then begin
            dup := FAllColors.Names[j];
            result := True;
            exit;
         end;
     end;
  end;
end;

{
procedure TfcColorList.ListChange(Sender: TObject);
var dup:String;
begin
  if HasDuplicateNames(dup) then
     raise EInvalidOperation.Create('Duplicate Color Names not allowed');
end;
}

procedure TfcCustomColorList.SetOptions(Value: TfcColorListBoxOptions);
begin
   if (Value <> FOptions) then begin
     FOptions := Value;
     if not (csLoading in ComponentState) then InitColorList;
   end;
end;

procedure TfcCustomColorList.UpdateItems;
var i:integer;
    accept:boolean;
begin
   Items.Clear;                  //Update Items with list of color names.
   ItemIDMap.Clear;
   for i := 0 to FAllColors.Count - 1 do
   begin
       if Assigned(FOnFilterColor) then begin
          accept := True;
          FOnFilterColor(self, fcGetColorFromList(FAllColors,i), fcGetNamesFromStringList(FAllColors,i), accept);
          if not accept then continue;
       end;
       ItemIDMap.Add(Pointer(i));
       Items.Add(FAllColors.strings[i]);
   end;
end;

function TfcCustomColorList.ColorFromIndex(Index: Integer):TColor;
begin
  result := fcGetColorFromList(Items,Index);
end;

procedure TfcCustomColorList.SortList;
var i:integer;
    curcolor:TColor;
//    ColorValue:String;
begin
   FListBoxUpdated:= True;
   curcolor:= FSelectedColor;
{   if ItemIndex <> -1 then
     ColorValue := Items.Names[ItemIndex]
   else ColorValue := '';}

            //If there are entries and Sorted is True then Sort the list.
   //2/26/99 - Don't Check Sorted Anymore.
   if {(Sorted = True) and }(FAllColors.Count > 0) then begin
     case SortBy of
        csoByRGB:
           if not (ccoGroupSystemColors in Options) then
              fcQuickSort(FAllColors, 0, FAllColors.Count - 1, RGBCompare, fcGetValuesFromStringList)
           else
              fcQuickSort(FAllColors, 0, FAllColors.Count - 1, RGBCompareGroupSys, fcGetValuesFromStringList);
        csoByIntensity:
           if not (ccoGroupSystemColors in Options) then
              fcQuickSort(FAllColors, 0, FAllColors.Count - 1, IntensityCompare, fcGetValuesFromStringList)
           else
              fcQuickSort(FAllColors, 0, FAllColors.Count - 1, IntensityCompareGroupSys, fcGetValuesFromStringList);
        csoByName:
           if (ccoGroupSystemColors in Options) then
             //2/26/99 - Already Sorted if ByName.
{              fcQuickSort(FAllColors, 0, FAllColors.Count - 1, ColorNamesCompare, fcGetItemsFromStringList)
           else}
              fcQuickSort(FAllColors, 0, FAllColors.Count - 1, ColorNamesCompareGroupSys, fcGetItemsFromStringList);
     end;
   end;

   UpdateItems;
   {    3/4//99 - Call UpdateItems method instead.
   Items.Clear;
   ItemIDMap.Clear;
   for i := 0 to FAllColors.Count - 1 do
   begin
       if Assigned(FOnFilterColor) then begin
          accept := True;
          FOnFilterColor(self, fcGetColorFromList(FAllColors,i), fcGetNamesFromStringList(FAllColors,i), accept);
          if not accept then continue;
       end;
       ItemIDMap.Add(Pointer(i));
       Items.Add(FAllColors.strings[i]);
   end;}

   i := fcValueInList(IntToHex(curcolor,6),FAllColors);
   if i<> -1 then i := Items.indexofname(allcolors.Names[i]);
   if i >= 0 then ItemIndex := i;   //Reset cursor if listbox has a current color
end;

procedure TfcCustomColorList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    Style := Style or LBS_OWNERDRAWFIXED;
    WindowClass.Style := CS_DBLCLKS;
  end;

  if not (Owner is TfcCustomColorCombo) then exit;

  with Params do
  begin
    Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW;
    WindowClass.Style := CS_SAVEBITS;
    ControlStyle := ControlStyle + [csNoDesignVisible];
  end;
end;

procedure TfcCustomColorList.DoDrawItem(ACanvas:TCanvas; Index,CWidth,CHeight:Integer; Rect: TRect;
   State: TOwnerDrawState; Text:String; AColor:TColor);
var CurColor: TColor;
    ColorRect, TextRect: TRect;
    OrigPenColor,OrigColor,OrigFontColor:TColor;
    OrigBKMode:Longint;
    NoneFlag,ShowText:Boolean;
    NoneStr:String;

  function HighlightCol: TColor;
  begin
    if (odSelected in State) then result := GetHighlightColor
    else result := OrigColor;
  end;
  function HighlightTextCol: TColor;
  begin
    if (odSelected in State) then result := GetHighlightTextColor
    else result := OrigFontColor;
  end;

begin
  OrigColor := ACanvas.Brush.Color;
  OrigFontColor := ACanvas.Font.Color;
  OrigPenColor := ACanvas.Pen.Color;
  OrigBkMode := GetBKMode(ACanvas.Handle);

  if (Index = -1) and (Text = '') then
  begin
    if (odSelected in State) then begin
       SetBkMode(ACanvas.Handle,Opaque);
       ACanvas.Brush.Color := GetHighlightColor;
       ACanvas.FillRect(Rect);
       SetBkColor(ACanvas.Handle,ColorToRGB(GetHighlightColor));
       SetTextColor(ACanvas.Handle,ColorToRGB(GetHighlightTextColor));
       ACanvas.DrawFocusRect(Rect);
    end
    else begin
       SetBkMode(ACanvas.Handle,Opaque);
       ACanvas.Brush.Color := HighlightCol;
       ACanvas.FillRect(Rect);
       ACanvas.Brush.Color := OrigFontColor;
       ACanvas.DrawFocusRect(Rect);
    end;
    ACanvas.Brush.Color := OrigColor;
    ACanvas.Font.Color := OrigFontColor;
    ACanvas.Pen.Color := OrigPenColor;
    Exit;
  end;

  if AColor = clNullColor then CurColor := clNone
  else CurColor := AColor;

  if (CurColor = clNone) and (AColor <> clNullColor) then begin
     CurColor := OrigColor; //Make None Color same as background?????}
     NoneFlag := True;
  end
  else NoneFlag := False;

  ShowText := False;
  if ccoShowColorNames in Options then ShowText := True;

  if ShowText then
  begin

    if Alignment = taLeftJustify then begin
       if (ColorAlignment = taLeftJustify) then
          ColorRect := Classes.Rect(Rect.Left + ColorRectMargin, Rect.Top + ((Rect.Bottom-Rect.Top-CHeight) div 2),
                                Rect.Left + ColorRectMargin + CWidth, Rect.Bottom - ((Rect.Bottom-Rect.Top-CHeight) div 2))
       else
          ColorRect := Classes.Rect(fcmax(Rect.Right-ColorRectMargin-CWidth,ACanvas.TextWidth(Text)+2*ColorRectMargin),
                                 Rect.Top + ColorRectMargin,
                                 Rect.Right - ColorRectMargin,
                                 Rect.Bottom - ColorRectMargin);
    end
    else begin
       if (ColorAlignment = taLeftJustify) then
          ColorRect := Classes.Rect(Rect.Left + ColorRectMargin, Rect.Top + ((Rect.Bottom-Rect.Top-CHeight) div 2),
                                    fcMin(Rect.Left + ColorRectMargin + CWidth,Rect.Right-(ACanvas.TextWidth(Text)+2*ColorRectMargin)),
                                    Rect.Bottom - ((Rect.Bottom-Rect.Top-CHeight) div 2))
       else
          ColorRect := Classes.Rect(fcmax(Rect.Right-ColorRectMargin-CWidth,ACanvas.TextWidth(Text)+2*ColorRectMargin),
                                 Rect.Top + ColorRectMargin,
                                 Rect.Right - ColorRectMargin,
                                 Rect.Bottom - ColorRectMargin);
    end;

    if (Index = -1) and (AColor = clNullColor) then ColorRect := Classes.Rect(Rect.Left,Rect.Top,Rect.Left,Rect.Top);

    if (Alignment = taLeftjustify) then begin
      if (ColorAlignment=taLeftJustify) then
         TextRect := Classes.Rect(ColorRect.Right + ColorRectMargin, Rect.Top, Rect.Right-ColorRectMargin, Rect.Bottom)
      else
         TextRect := Classes.Rect(Rect.Left + ColorRectMargin,Rect.Top,
                                  fcmax(Rect.Right-ColorRectMargin-CWidth,ACanvas.TextWidth(Text)+2*ColorRectMargin),
                                  Rect.Bottom);
    end
    else begin
      if (ColorAlignment=taLeftJustify) then
         TextRect := Classes.Rect(ColorRect.Left + ColorRectMargin,
                        Rect.Top, Rect.Right-ColorRectMargin,Rect.Bottom)
      else
         TextRect := Classes.Rect(Rect.Left + ColorRectMargin,Rect.Top,
                     fcmax(Rect.Right-2*ColorRectMargin-CWidth,Rect.Left+ACanvas.TextWidth(Text)+ColorRectMargin),
                     Rect.Bottom);
    end;
  end
  else begin
      ColorRect := Classes.Rect(Rect.Left + ColorRectMargin, Rect.Top + ColorRectMargin,
                                Rect.Right - ColorRectMargin, Rect.Bottom - ColorRectMargin);

      if (Index = -1) and (AColor = clNullColor) then ColorRect := Classes.Rect(Rect.Left,Rect.Top,Rect.Left,Rect.Top);
  end;

  // Paint background color
  if (ItemIndex <> -1) then begin //3/3/99 - Eliminate Flicker when resizing with Align set.
    ACanvas.Brush.Color := HighlightCol;
    ACanvas.FillRect(Rect);
  end;

  if (AColor <> clNullColor) then begin
  // Paint Color Square
    ACanvas.Pen.Color := HighlightTextCol;
    ACanvas.Brush.Color := CurColor;

    if NoneFlag and
       (odSelected in State) and (odFocused in State) and (ShowText) then
       ACanvas.Brush.Color := GetHighlightColor;

    ACanvas.FillRect(ColorRect);

  // If Displaying Transparent Color Box then don't paint highlight
    if NoneFlag then begin
      if ShowText and (odSelected in State) and (odFocused in State) then
          ACanvas.Pen.Color := HighlightTextCol
      else if (ShowText = True) then
          ACanvas.Pen.Color := OrigFontColor
      else ACanvas.Pen.Color := CurColor;
    end;
    ACanvas.Rectangle(ColorRect.Left, ColorRect.Top, ColorRect.Right, ColorRect.Bottom);
  end;
  ACanvas.Brush.Color := HighlightCol;
  ACanvas.Font.Color := HighlightTextCol;
  SetBkMode(ACanvas.Handle,Transparent);

  NoneStr := NoneString;
  if (ShowText) and (Not NoneFlag) then begin
    if Alignment = taLeftJustify then
//      DrawText(ACanvas.Handle, PChar(GetNamesFromStringList(AllColors,Index)), Length(GetNamesFromStringList(AllColors,Index)), TextRect, DT_SINGLELINE or DT_VCENTER)
      DrawText(ACanvas.Handle, PChar(Text), Length(Text), TextRect, DT_SINGLELINE or DT_VCENTER)
    else
      DrawText(ACanvas.Handle, PChar(Text), Length(Text), TextRect, DT_SINGLELINE or DT_VCENTER or DT_RIGHT);
  end
  else if (ShowText) then begin
    if NoneString = '' then NoneStr := 'None';
    if Alignment = taLeftJustify then
      DrawText(ACanvas.Handle, PChar(NoneStr), Length(NoneStr), TextRect, DT_SINGLELINE or DT_VCENTER)
    else
      DrawText(ACanvas.Handle, PChar(NoneStr), Length(NoneStr), TextRect, DT_SINGLELINE or DT_VCENTER or DT_RIGHT);
  end;

  if NoneFlag then begin
    if (odSelected in State) and (odFocused in State) then
       ACanvas.Pen.Color := HighlightTextCol
    else ACanvas.Pen.Color := OrigFontColor;
    if ShowText then begin
       ACanvas.Polyline([Point(ColorRect.TopLeft.X,ColorRect.TopLeft.Y),
                         Point(ColorRect.BottomRight.X,ColorRect.BottomRight.Y)]);
       ACanvas.Polyline([Point(ColorRect.TopLeft.X,ColorRect.BottomRight.Y-1),
                         Point(ColorRect.BottomRight.X,ColorRect.TopLeft.Y-1)]);
    end
    else begin
       if (odSelected in State) and (odFocused in State) and ShowText then
            ACanvas.Font.Color := HighlightTextCol
       else ACanvas.Font.Color := OrigFontColor;
       DrawText(ACanvas.Handle, PChar(NoneStr), Length(NoneStr), ColorRect,
          DT_SINGLELINE or DT_VCENTER or DT_CENTER);
    end;
  end;
  // Reset Font, Pen, and Brush Colors
  ACanvas.Font.Color := HighlightTextCol;
  ACanvas.Pen.Color := HighlightTextCol;
  ACanvas.Brush.Color := HighlightCol;
  SetBkMode(ACanvas.Handle,Opaque);

  if (odSelected in State) and (odFocused in State) then
     ACanvas.DrawFocusRect(Rect);

 ACanvas.Brush.Color := OrigColor;
 ACanvas.Font.Color := OrigFontColor;
 ACanvas.Pen.Color := OrigPenColor;
 SetBkMode(ACanvas.Handle,OrigBkMode);
end;

procedure TfcCustomColorList.InitColorList;
var i, count: integer;
    FTempList: TStringList;
begin
   FTempList:= TStringList.Create;
                            //Fill Standard and System Colors
   FillColorList(FTempList,FOptions,NoneString);

   FAllColors.Clear;
   for i:=0 to FTempList.Count-1 do
      AddToAllColors(FTempList.Names[i],FTempList.Values[FTempList.Names[i]]);
   FTempList.Free;
                          //Fill with Custom Colors
   if ccoShowCustomColors in Options then
      for i := 0 to FCustomColors.Count - 1 do
         AddToAllColors(FCustomColors.Names[i],fcGetValuesFromStringList(FCustomColors,i));

   for i := 0 to FTempColors.Count - 1 do
      AddToAllColors(FTempColors.Names[i],fcGetValuesFromStringList(FTempColors,i));

   if ccoShowGreyScale in Options then begin
      i:= 0;
      count :=1;
      while i <= 255 do begin
        if AddToAllColors('Grey'+IntToStr(Count),fcRGBToHexString(i,i,i)) then
           count:=count+1;
        i := i+GreyScaleIncrement;
      end;
   end;

{  k:=0;          //Code to add Standard 255 Colors
   count:=0;
   while k<=255 do begin
      j:=0;
      while j<=255 do begin
         i:=0;
         while i<=255 do begin
            if (ValueInList(RGBToHexString(i,j,k),FAllColors)=-1) then begin
               count := count+1;
               FAllColors.Add('MyColor'+IntToStr(Count)+'='+RGBToHexString(i,j,k));
            end;
            i:=i+51;
         end;
         j:=j+51;
      end;
      k:=k+51;
   end;}

   SortList;
end;


{function TfcCustomColorList.MapItemID(val: integer): integer;
begin
   result:= integer(ItemIDMap[val]);
end;
}
// 3/1/99 - Make sure that colorlist invalidates when resizing.
procedure TfcCustomColorList.WMSize(var Message: TWMSize);
begin
  inherited;
  if not (csDesigning in ComponentState) then exit;
  if not (Owner is TfcCustomColorCombo) then invalidate;
end;

procedure TfcCustomColorList.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
  cwidth:Integer;
  AName:String;
  AColor:TColor;
  function GetOwnerDrawStates(AState: DWORD): TOwnerDrawState;
  begin
    result := [];
    if (ODS_CHECKED and AState) = ODS_CHECKED then result := result + [odChecked];
    if (ODS_DISABLED and AState) = ODS_DISABLED then result := result + [odDisabled];
    if (ODS_FOCUS and AState) = ODS_FOCUS then result := result + [odFocused];
    if (ODS_GRAYED and AState) = ODS_GRAYED then result := result + [odGrayed];
    if (ODS_SELECTED and AState) = ODS_SELECTED then result := result + [odSelected];
  end;
begin
//  inherited;   //(This causes control to flicker, removed) -ksw
  with Message.DrawItemStruct^ do
  begin
    State := GetOwnerDrawStates(itemState);
    Canvas.Handle := hDC;
    Canvas.Font := Font;
    Canvas.Brush := Brush;

    if ColorWidth = 0 then
       cwidth := ItemHeight-(2*ColorRectMargin)
    else cwidth := ColorWidth;

    AName := '';
    AColor := clWindow;
    if (ItemId <> $FFFFFFFF) then  // Changed from -1 to avoid compiler warning. -ksw (9/18/98)
    begin
      AName := Items.Names[ItemId];
      AColor := StringToColor('$'+Items.Values[AName]);
    end;

{    if (cslbuttondown in controlstate) and not PtInRect(ClientRect,ScreenToClient(fcGetCursorPos)) then
    begin
        State := State - [odfocused];
    end;}

    DoDrawItem(Canvas, itemID, cwidth, ItemHeight-2*ColorRectMargin, rcItem, State, AName, AColor);

    Canvas.Handle := 0;
  end;
end;

function TfcCustomColorList.GetItemIndex: integer;
begin
   if MultiSelect then
      Result := SendMessage(Handle, LB_GETCARETINDEX, 0, 0)
   else Result := SendMessage(Handle, LB_GETCURSEL, 0, 0);
end;

Procedure TfcCustomColorList.SetItemIndex(Value: integer);
begin
   if MultiSelect then
      SendMessage(Handle, LB_SETCARETINDEX, Value, 0)
   else SendMessage(Handle, LB_SETCURSEL, Value, 0);

   if Value <> ItemIndex then
      inherited ItemIndex:= value;

   if (Value < Items.Count) and (Value <> -1) then
      FSelectedColor := StringToColor('$'+Items.Values[Items.Names[Value]])
      //fcGetColorFromList(FAllColors,Value)
   else FSelectedColor := clNullColor;
end;

procedure TfcCustomColorList.SetSortBy(Value: TfcSortByOption);
begin
  if FSortByOption <> Value then
  begin
    FSortByOption := Value;
    //2/26/99 - Set Sorted only when byname.
    //3/2/99 - Sort Only when byName and not Grouping System Colors.
    inherited Sorted := (FSortByOption = csoByName) and not (ccoGroupSystemColors in Options);
    SortList;
  end;
end;

procedure TfcCustomColorList.SetGreyScaleIncrement(Value: Integer);
begin
  if (FGreyScaleIncrement <> Value) and
      (Value > 0) and (Value <=255) then begin
     FGreyScaleIncrement := Value;
     if not (csLoading in ComponentState) then InitColorList;
  end;
end;

procedure TfcCustomColorList.SetNoneString(Value: String);
begin
  if (FNoneString <> Value) then begin
     FNoneString := Value;
     if not (csLoading in ComponentState) then InitColorList;
  end;
end;

procedure TfcCustomColorList.SetSelectedColor(Value: TColor);
var i: integer;
begin
  if Value <> SelectedColor then
  begin
     FSelectedColor := Value;
     { 4/11/99 - RSW - Used to be before  Value <> SelectedColor comparison,
       which prevented internal value from being updated during streaming}
     if FAllColors.Count = 0 then Exit;

     i := fcValueInList(IntToHex(Value,6), FAllColors);
     if i<> -1 then i := Items.indexofname(allcolors.Names[i]);
     if i >= 0 then ItemIndex := i
     else begin
       if Value <> clNullColor then begin    //3/1/99 - Check for NullColor
         AddToAllColors(fcColorToRGBString(Value),IntToHex(Value,6));
         //3/3/99 -PYW- Don't add twice and don't reset itemindex to wrong value. 
{         if AddToAllColors(fcColorToRGBString(Value),IntToHex(Value,6)) then
         begin
            Items.Add(fcColorToRGBString(Value));
            ItemIndex := Items.Count - 1;
            SortList;
         end;        }
       end
       else begin
         ItemIndex := -1;
       end;
     end;
  end;
end;

function TfcCustomColorList.GetSelectedColor: TColor;
begin
  if ItemIndex = -1 then
     result := clNullColor
  else result := FSelectedColor;
end;

//Returns whether or not Color was added to the list...
function TfcCustomColorList.AddToAllColors(AName,AValue:String) : Boolean;
var curColor:TColor;
    ColorNotInList,accept,IsCustomColor: Boolean;
begin
  result := False;
  accept := True;
  ColorNotInList := False;
  if (fcValueInList(AValue,FAllColors)=-1) then
     ColorNotInList := True;

  curColor:=  StringToColor('$'+AValue);
  IsCustomColor := (Pos('RGB:',AName)=1);

  //3/4/99 - Don't call onaddnewcolors for non customcolors.
  if IsCustomColor and Assigned(FOnAddNewColor) then FOnAddNewColor(self, curColor, AName, accept);

  if not accept then exit;
  if (fcNameInList(AName,FAllColors)=-1) and (ColorNotInList) then begin
     result := True;
     FAllColors.Add(AName+'='+AValue);
     if IsCustomColor then begin
        FTempColors.Add(AName+'='+AValue);
        SortList;
     end;
  end;
end;

procedure TfcCustomColorList.SetCustomColors(Value: TStringList);
var dup:String;
begin
  FCustomColors.Assign(Value);
  if not (csLoading in ComponentState) then InitColorList;
  if HasDuplicateNames(dup) then
     MessageDlg('Duplicate Color Name Not Allowed: '+dup, mtWarning, [mbok], 0);
end;

procedure TfcCustomColorList.SetAlignment(Value: TLeftRight);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Invalidate;
//    RecreateWnd;
  end;
end;

procedure TfcCustomColorList.SetColorAlignment(Value: TLeftRight);
begin
  if FColorAlignment <> Value then
  begin
    FColorAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TfcCustomColorList.SetColorWidth(Value: Integer);
begin
  if FColorWidth <> Value then
  begin
    FColorWidth := Value;
    Invalidate;
  end;
end;

function TfcCustomColorList.GetEditRectHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then I := Metrics.tmHeight;
  result := I;
end;

// Custom Color Combo
procedure TfcCustomColorCombo.SetAlignment(Value: TLeftRight);
begin
  if FAlignment <> Value then FAlignment := Value;
end;

{
procedure TfcCustomColorCombo.SetAlignmentVertical(Value: TfcAlignVertical);
begin
  if FAlignmentVertical <> Value then begin
     FAlignmentVertical := Value;
     Invalidate;
  end;
end;
}
procedure TfcCustomColorCombo.SetColorAlignment(Value: TLeftRight);
begin
  if FColorAlignment <> Value then begin
     FColorAlignment := Value;
     if FListBox <> nil then
        FListBox.ColorAlignment := Value;
     SetEditRect;
     Invalidate;
  end;
end;

procedure TfcCustomColorCombo.SetCustomColors(Value: TStringList);
begin
  FCustomColors.Assign(Value);
  if FListbox <> nil then
  begin
     FListBox.CustomColors.Assign(Value);
     FListBox.InitColorList;
  end
end;

procedure TfcCustomColorCombo.SetItemIndex(Value: integer);
begin
   if Value < -1 then Value := -1;
   ListBoxNeeded;
   if Value >= Listbox.Items.Count then Value := FListBox.Items.Count - 1;

   if FItemIndex <> Value then begin
      FItemIndex := Value;
      FListBox.ItemIndex := Value;

      if FItemIndex <> -1 then
         FSelectedColor := StringToColor('$'+Listbox.Items.Values[Listbox.Items.Names[FItemIndex]])
//         fcGetColorFromList(FListBox.AllColors,FItemIndex)
      else FSelectedColor := clNullColor;

      if FItemIndex <> -1 then
         Text := Listbox.Items.Names[FItemIndex];
         //fcGetNamesFromStringList(ListBox.AllColors,Fitemindex);

      invalidate;
   end;
end;

{ RSW }
procedure TfcCustomColorCombo.UpdateSelectedColor;
var AName:String;
    i:integer;
    Value: integer;
begin
     Value:= SelectedColor;

     if Value=clNullColor then begin //3/1/99 - Check for SelectedColor.
       FListBox.SelectedColor := clNullColor;
       Text:= '';
       invalidate;
       exit;
     end;

     i := fcValueInList(IntToHex(Value,6),FListBox.AllColors);
     if i = -1 then
     begin
        AName := fcColorToRGBString(Value);
        FListBox.AddToAllColors(AName,IntToHex(Value,6));
        if fcValueInList(IntToHex(Value,6),FListBox.AllColors) = -1 then exit;
     end;

     FListBox.SelectedColor := Value;

     i := fcValueInList(IntToHex(Value,6),FListBox.AllColors);
     if i<> -1 then i := Listbox.Items.indexofname(Listbox.Allcolors.Names[i]);
     if i<> -1 then SetComboText(Listbox.items.names[i])
     else SetComboText('');
     Invalidate;
end;

procedure TfcCustomColorCombo.SetSelectedColor(Value: TColor);
begin
  if FSelectedColor <> Value then
  begin
     FSelectedColor := Value;
     if not HandleAllocated then exit;
     ListBoxNeeded;
     UpdateSelectedColor; { RSW }

//     if csLoading in ComponentState then Exit;   // Causes a resource leak if ListBoxNeeded called here -ksw (2/18/99)
(*     ListBoxNeeded;
     i := fcValueInList(IntToHex(Value,6),FListBox.AllColors);
     if i = -1 then
     begin
        AName := fcColorToRGBString(Value);
        FListBox.AddToAllColors(AName,IntToHex(Value,6));
        if fcValueInList(IntToHex(Value,6),FListBox.AllColors) = -1 then exit;
     end;
     FListBox.SelectedColor := Value;
     i := fcValueInList(IntToHex(Value,6),FListBox.AllColors);
     if i<> -1 then i := Listbox.Items.indexofname(Listbox.Allcolors.Names[i]);
     if i<> -1 then SetComboText(Listbox.items.names[i])
     else SetComboText('');
     Invalidate;
*)
  end;
end;

procedure TfcCustomColorCombo.CustomColorsChangeEvent(Sender: TObject);
begin
   ListBoxNeeded;
   FListBox.CustomColors.Assign(CustomColors);
   FListBox.SelectedColor := SelectedColor;
end;

procedure TfcCustomColorCombo.AddNewColorEvent(Sender: TObject; AColor:TColor;
  var AColorName:String; var Accept: Boolean);
begin
  if Assigned(FOnAddNewColor) then FOnAddNewColor(Sender, AColor, AColorName, Accept);
end;

procedure TfcCustomColorCombo.OnFilterColorEvent(Sender: TObject; AColor:TColor;
  AColorName:String; var Accept: Boolean);
begin
  if Assigned(FOnFilterColor) then FOnFilterColor(Sender, AColor, AColorName, Accept);
end;

procedure TfcCustomColorCombo.ListMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FCloseOnUp := False;
  if PtInRect(FListBox.ClientRect, Point(X,Y)) then
     FCloseOnUp := True;

  FSelectedItemIndex := FListBox.ItemIndex;
  inherited;
end;

procedure TfcCustomColorCombo.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Button = mbLeft) and FCloseOnUp then begin
    if not PtInRect(FListBox.ClientRect, Point(X,Y)) then begin
       FListBox.ItemIndex := FSelectedItemIndex;
       FSelectedColor := Listbox.OldSelectedColor;
    end;
    CloseUp(True);
  end;

  FCloseOnUp := False;
end;

procedure TfcCustomColorCombo.CMExit(var Message: TCMExit);
begin
  // 2/23/99 - Not necessary anymore.
{  if (Style = csDropDownList) then
     if (ItemIndex = -1) and (Text <> '')  then begin
        EditCanModify;
        SetModified(True);
        Text := ''
     end
     else if (ItemIndex <> -1) and (Text <> Listbox.Items.Names[ItemIndex]) then
     begin
        EditCanModify;
        SetModified(True);
        Text := Listbox.Items.Names[ItemIndex];
     end;}
  inherited;
//  if not Editable then Invalidate;
end;

procedure TfcCustomColorCombo.CMTextChanged(var Message: TMessage);
var s:String;
begin
  inherited;
  if skipTextChange then exit;
  if (DataLink.Field = nil) then exit;

  if {(GetComboDataType=ccdColor) and }(fcisinwwgrid(self)) then begin
     s:= inherited text;
     SkipTextChange := True;
     if (StrToIntDef(s,-1) <> -1) then
        Text := GetComboDisplayText(StrToIntDef(s,-1));
     SkipTextChange := False;
  end;
end;

procedure TfcCustomColorCombo.CNCommand(var Message: TWMCommand);
begin
  if Message.NotifyCode <> CBN_DBLCLK then inherited;
end;

procedure TfcCustomColorCombo.CNKeyDown(var Message: TWMKeyDown);
begin
  inherited;
end;

procedure TfcCustomColorCombo.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  skipDropDown:=True;  //3/4/99-PYW-SkipDropDown when double clicking.
  try
    inherited;
    if (cdoEnabled in FColorDialogOptions) then begin
       ListBox.UpdateItems;
       ExecuteColorDialog;
    end;
  finally
    skipDropDown:=False;
  end;
end;

procedure TfcCustomColorCombo.WMPaste(var Message: TMessage);
begin
  inherited;
  ItemIndex := fcNameinList(Text,ListBox.AllColors); //!!
end;

procedure TfcCustomColorCombo.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
{  if ItemIndex <> -1 then
     ListBox.SelectedColor := fcGetColorFromList(ListBox.FAllColors,ItemIndex)
  else ListBox.SelectedColor := clNullColor;
  invalidate;}
//  if not Editable then
//     HideCaret(Handle);
end;

procedure TfcCustomColorCombo.CloseUp(Accept: Boolean);
var IsDroppedDown: Boolean;
    ListValue: String;
    i:integer;
begin
   IsDroppedDown := self.IsDroppedDown;
   inherited;
   if IsDroppedDown then begin

     if Accept and (FListBox.SelectedColor<>FOriginalSelectedColor) and EditCanModify {2/11/99 - RSW } then
     begin
        if (FListbox.ItemIndex <> -1) then begin
           ListValue := Listbox.Items.Names[Listbox.ItemIndex];
           if (ListValue <> '') then

//           if {((FListBox.ItemIndex <> ItemIndex) or (ListValue<>Text)) and }EditCanModify then
//           begin
              FItemIndex:= FListBox.itemIndex;
              SelectedColor := ListBox.SelectedColor;
              if ListValue<>'' then Text:= ListValue;
              SetModified(True);
//           end;
        end;
     end
     else begin
        i := fcValueInList(IntToHex(FOriginalSelectedColor,6),Listbox.AllColors);
        if i<> -1 then i := Listbox.Items.indexofname(Listbox.allcolors.Names[i]);

        ItemIndex := i;
        SelectedColor := FOriginalSelectedColor;
       //2/17/99 - Update Text if Text doesn't match
        if (ItemIndex <> -1) and
           (Text <> FListbox.Items.Names[ItemIndex]) then
              Text := FListbox.Items.Names[ItemIndex]
     end;
     DoCloseUp(Accept);

   end;
   SelectAll;
end;

procedure TfcCustomColorCombo.CreateWnd;
begin
  inherited CreateWnd;
  if not (csDesigning in ComponentState) then begin
     ListBoxNeeded;
  end;
end;

procedure TfcCustomColorCombo.DataChange(Sender: TObject);
begin
  //3/25/99-PYW-Exit if Combo is being destroyed.
  if (csDestroying in ComponentState) then exit;

  if SkipDataChange then exit;

  if DataLink.Field <> nil then
  begin
    if FAlignment <> DataLink.Field.Alignment then
    begin
//      Text := '';  {forces update}
//      FAlignment := DataLink.Field.Alignment;
    end;

    if not (csDesigning in ComponentState) then
    begin
      if (DataLink.Field.DataType = ftString) and (MaxLength = 0) then
        MaxLength := DataLink.Field.Size;
    end;
    if Focused and DataLink.CanModify then begin
      if GetComboDataType=ccdColor then
         Text := GetComboDisplayText(Datalink.Field.AsInteger)
      else Text := DataLink.Field.Text;
    end
    else begin
      if GetComboDataType=ccdColor then begin
         if Datalink.Field.DisplayText <> '' then begin
            if StrToIntDef(Datalink.Field.DisplayText,-1) <> -1 then
               Text := GetComboDisplayText(StrToIntDef(Datalink.Field.DisplayText,-1));
         end else Text := '';
      end
      else Text := DataLink.Field.DisplayText;
      if DataLink.Editing then
        Modified := True;
    end;
  end else
  begin
    if csDesigning in ComponentState then
      Text := Name else
      Text := '';
  end;

  if (FListBox <> nil) then begin
     itemindex := Listbox.Items.IndexOfName(Text);
   //     fcNameInList(Text,ListBox.AllColors);
     invalidate;
     if ItemIndex < 0 then ShowCaret;
  end;
end;

function TfcCustomColorCombo.Editable: Boolean;
begin
   Result := (Style <> csDropDownList) or isDroppedDown or ShowMatchText;
end;

{Function TfcCustomColorCombo.Editable: boolean;
begin
   Result := True;//isDroppedDown;
//   if Result then HideCaret(Handle);
end;}

function TfcCustomColorCombo.GetComboColor(Index:Integer):TColor;
var AColor:TColor;
    AName:String;
begin
  AColor := clNullColor;
  AName:=Text;

  if Index <> -1 then
     AColor := StringToColor('$'+Listbox.Items.Values[Listbox.Items.Names[Index]])
//     fcGetColorFromList(ListBox.AllColors,Index)
  else begin
      if not GetColorFromRGBString(AName, AColor) then
         AColor := SelectedColor;
  end;
  Result := AColor;
end;

function TfcCustomColorCombo.GetComboDataType:TfcColorComboDataType;
begin
   if Datalink.Field <> nil then begin
      if Datalink.Field.datatype = ftInteger then
         result := ccdColor
      else result := ccdColorName;
   end
   else result := ccdColorName
end;

//Display the mapped text value for a given color.  Will return blank if
//Color is not in list or Value is null.
function TfcCustomColorCombo.GetComboDisplayText(Value:integer): String;
var Index:integer;
begin
  result := '';
  if (csDesigning in ComponentState) then ListBoxNeeded;
  Index:= fcValueInList(IntToHex(Value,6),ListBox.AllColors);
  if Index <> -1 then Index := Listbox.Items.indexofname(Listbox.allcolors.Names[Index]);
  if (Value<>clNullColor) and (Index<>-1) then
     result := ListBox.Items.Names[Index]
  else if (Index = -1) and (Value <> clNullColor) then
     result := fcColorToRGBString(Value);
end;

function TfcCustomColorCombo.GetDropDownControl: TWinControl;
begin
  result := FListBox;
end;

function TfcCustomColorCombo.GetDropDownContainer: TWinControl;
begin
  result := FListBox;
end;

function TfcCustomColorCombo.GetItemCount: Integer;
begin
  result := FListBox.Items.Count;
end;

function TfcCustomColorCombo.GetItemSize: TSize;
begin
  result := fcSize(DropDownWidth, ListBox.ItemHeight);
  if result.cx = 0 then result.cx := Width;
end;

procedure TfcCustomColorCombo.HideCaret;
begin
  if (not showMatchText)
     {2/11/99 - PYW  - Commented the following line out
      Caret being hidden no matter what when Colornames are shown }
     { or (Style <> csDropDownList) or (ccoShowColorNames in ColorListOptions.Options) }
     then inherited;
end;

Function TfcCustomColorCombo.isDroppedDown: boolean;
begin
  result := False;
  if (FListBox <> nil) then result := FListBox.Visible;
end;

procedure TfcCustomColorCombo.KeyDown(var Key: Word; Shift: TShiftState);
  Function wwIsValidChar(key: word): boolean;
  begin
    result:= (key = VK_BACK) or (key=VK_SPACE) or (key=VK_DELETE) or
             ((key >= ord('0')) and (key<=VK_DIVIDE)) or
             (key>VK_SCROLL);
  end;
begin
  //3/4/99 - Added check to make sure when buttonstyle is ellipsis that the dialog will not auto pop up.
  if (not DroppedDown) and wwIsValidChar(Key) and
     (ButtonStyle <> cbsEllipsis) and AutoDropDown and
     (not (key in [VK_DELETE,VK_BACK])) and
     not (ssAlt in Shift) then begin { 9/25/97 - Don't auto-drop down if alt key is pressed }
     InAutoDropDown:= True;
     DropDown;
     InAutoDropDown:= False;
  end;

  inherited KeyDown(Key,Shift);

  case Key of
    VK_BACK:
       if (Style=csDropDownList){ and (not isDroppedDown) }then
       begin
         if (AllowClearKey) and ((selText=Text) or (key=vk_delete)) then
         begin
            if EditCanModify then begin
               Text:= '';
               ItemIndex := -1;
               SetModified(True);
               if FSelectedColor<>clNullColor then
               begin
                  FSelectedColor := clNullColor;
                  invalidate;
               end;
            end;
         end
         else begin
            if (selStart>0) and ShowMatchText then
            begin
               SendMessage(Handle, EM_SETSEL, length(Text), selStart-1);
               SendMessage(Handle, EM_SCROLLCARET, 0,0);
            end;
            key:= 0;
         end;
       end;

     VK_UP, VK_DOWN, VK_HOME, VK_END, VK_PRIOR, VK_NEXT:
        if (Listbox.Allcolors.Count > 0) then begin
//          if (Style = csdropdownlist) then begin { RSW - allow csdropdown to selectall when scrolling }
             if (not (ssShift in Shift) and not
                ((not isdroppeddown) and (key in [VK_HOME,VK_END]))) then begin
                SelectAll;
                if not (ShowMatchText) then
                  HideCaret;
                Key := 0;
             end;
//          end;
        end;
  end;
end;

procedure TfcCustomColorCombo.KeyPress(var Key: Char);
var TextLen:Integer;
//    curIndex,
    nextcolorindex:integer;
    prevText:string;
//    prevselstart,prevsellength:Integer;

  function NewText: string;
  var CurStr,tempstr: string;
  begin
    CurStr:= Text;
    tempstr := Text;
    result:= Copy(CurStr, 1, SelStart) + Char(Key)+
      Copy(TempStr, SelStart + 1 + Length(SelText), 32767);
  end;

  function FindColorIndex: integer;
  var InitialIndex: Integer;
  begin
    InitialIndex := Itemindex;
    if InitialIndex < 0 then InitialIndex := 0;
    result := InitialIndex;
    repeat
      if UpperCase(Copy(ListBox.items.Names[result], 1, Length(NewText))) = UpperCase(NewText) then Exit;
      result:=result+1;
      if result >= Listbox.items.count then result := 0;
    until result = InitialIndex;
    result := -1;
  end;
begin
   inherited;
   if not showmatchtext then begin
      Key := #0;
      exit;
   end;

   if (key=#8) and (Style=csDropDownList) then
   begin
      key:= #0;
      if key=#0 then exit;
   end;

//   if (Listbox.AllColors.Count > 0) and not (Key in [#8,#13]) then
   if (Listbox.AllColors.Count > 0) and (Key in [#32..#254]) then
   begin
//     Listbox.SortList; //2/22/99 - SortList First.  RSW (commented out - causes flicker }
     prevText := Text;
     nextcolorindex := FindColorIndex;

     //If newcolor name is not in list then...
     if (nextcolorindex <> -1) and EditCanModify then begin
        FSelectedColor := StringToColor('$'+Listbox.Items.Values[Listbox.Items.Names[nextcolorindex]]);
        if Itemindex <> nextcolorindex then
           Listbox.ItemIndex := nextcolorindex;
        Text := Newtext;
        TextLen := Length(Text);
        self.Text := flistbox.items.names[nextcolorindex];
        SelStart := Length(Text);
        SelLength := - (Length(Text) - TextLen);
        SetModified(True); { RSW }
        Key := #0;
     end
{     else if (Style = csDropDownList) then begin
        Key := #0;
     end}
     else if Style = csDropDownList then begin
        //2/17/99 - Commented out following line.
//        Text := NewText;
{        Text := prevText;
        selstart := prevSelStart;
        sellength := prevSelLength;}
        Key := #0;
     end
     else if EditCanModify then begin { RSW - 3/27/99 -
                                        Avoid assigning text as this prevents horizontal scrolling }
        ItemIndex := -1;
        SetModified(True);
        if FSelectedColor<>clNullColor then
        begin
           FSelectedColor := clNullColor;
           invalidate;
        end;
     end
     else Key := #0;
   end;

   if Key = #13 then Key := #0;
//   showcaret(handle);
end;

procedure TfcCustomColorCombo.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if (Text = '') or (not showmatchtext) and ((key=vk_delete) or (key=vk_back)) then
  begin
     EditCanModify;
     ItemIndex:= -1;
     FListbox.itemindex := -1;
     Text:= '';
     FSelectedColor := clNullColor;
     Change;
     SetModified(True);
     invalidate;
  end;

  inherited KeyUp(Key, Shift);
  if not showmatchtext then begin
    Key := 0;
  end;
end;

procedure TfcCustomColorCombo.ListboxNeeded;
begin
  if FListbox<>Nil then exit;
  FListbox:= TfcColorList.create(self);
  with FListBox do begin
    {4/13/99 - PYW - Make sure events are set before adding all of the colors}
    OnFilterColor := OnFilterColorEvent;
    OnAddNewColor := AddNewColorEvent;
    ControlStyle := ControlStyle + [csNoDesignVisible];
    Visible:= False;
    FListBox.Parent:= self;
    ItemHeight := 16;
    SetWindowPos(FListbox.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
       SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    Visible:= False;
    OnMouseUp := ListMouseUp;
    OnMouseDown := ListMouseDown;
    NoneString := ColorListOptions.NoneString;
    Options := ColorListOptions.Options;
    CustomColors.Assign(CustomColors);
  end;
  UpdateSelectedColor; { RSW - 2/28/99 in case listbox was created after selectedcolor was streamed in}
end;

procedure TfcCustomColorCombo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = ColorDialog) and (Operation = opRemove) then ColorDialog := nil;
end;

Procedure TfcCustomColorCombo.SelectAll;
begin
   {2/11/99 - PYW - Need to not SelectAll when dropdownlist and not showmatchtext,
                    may need to retest in a grid.}
   if not showmatchtext and(style=csdropdownlist) then exit;
   if InAutoDropDown and (showmatchtext and (Style=csDropDown)) then exit;
//   if Editable then inherited;
   inherited;
end;

//!!!!Reduce this code.
procedure TfcCustomColorCombo.SetComboText(Value:String);
var i:integer;
begin
  inherited;
  i:= Listbox.Items.IndexOfName(Value);
//  fcNameInList(Value,FListBox.Items);
  if i<>-1 then ItemIndex := i;
  Text := Value;
end;

procedure TfcCustomColorCombo.SetEditRect;
var
  r: TRect;
begin
  r:= GetEditRect;
  if fcIsInwwGrid(self) and (ColorAlignment=taRightJustify) then
     inc(r.Left, GetIndentLeft(r)-1)
  else
     inc(r.Left, GetIndentLeft(r));
  if ShowButton then
     r.Right := GetRightIndent(r) - GetIconIndent - ColorRectMargin
  else r.Right := GetRightIndent(r) - ColorRectMargin;
  if r.Right<=r.Left+10 then r.Right:= r.Left + 10; // 5/3/99 - RSW - Ensure edit rectangle is at least 10 pixels wide

  SendMessage(Handle, EM_SETRECTNP, 0, LPARAM(@r));
end;

procedure TfcCustomColorCombo.ShowCaret;
begin
   inherited;
end;

procedure TfcCustomColorCombo.UpdateData(Sender: TObject);
var aColor:TColor;
begin
//!!!!!!add condition so not done when no change.
  if GetComboDataType = ccdColor then begin
     if GetColorFromRGBString(Text, AColor) then begin
        if AColor <> Datalink.Field.AsInteger then
           if (AColor <> clNullColor) then
              Datalink.Field.Text := IntToStr(AColor)
           else Datalink.Field.Clear; //3/1/99 - PYW - Clear Field if NullColor
     end
     else if Datalink.Field.Text <> IntToStr(SelectedColor) then begin
           if (SelectedColor <> clNullColor) then
              DataLink.Field.Text := IntToStr(SelectedColor)
           else Datalink.Field.Clear;//3/1/99- PYW - Clear Field if NullColor
     end;
  end
  else if Datalink.Field.Text <> Text then
     if (Text <> '') then
        DataLink.Field.Text := Text
     else Datalink.Field.Clear;     //3/1/99- PYW - Clear Field if NullColor
end;

procedure TfcCustomColorCombo.WndProc(var Message: TMessage);
var i:integer;
begin
  case Message.Msg of
    WM_KEYDOWN, WM_SYSKEYDOWN, WM_CHAR:
       with TWMKey(Message) do begin
         if not (ssShift in fcGetShiftState) and (not EffectiveReadOnly) then begin
            HandleDropDownKeys(CharCode, KeyDataToShiftState(KeyData));

            if not (isdroppeddown) and not showmatchtext and not (fcIsInwwGrid(Self)) then
            begin
               if (itemindex = listbox.allcolors.Count-1) then
               begin  //!!!! Probably should call OnKeyDown for these keys.
                  if charcode in [vk_end,VK_DOWN] then exit
               end
               else if (itemindex=0) then
               begin
                  if charcode in [vk_HOME,VK_UP] then exit
               end;
            end;

            if not (IsDroppedDown and (CharCode in [VK_LEFT, VK_RIGHT])) then
            begin
               if (CharCode <> 0) and (not (CharCode in [VK_DELETE, VK_BACK])) and
                  not ((CharCode in [VK_LEFT, VK_RIGHT{, VK_NEXT, VK_PRIOR}]) and
                        fcIsInwwGrid(Self)) then
               begin
                  // Don't send the keys to the list if this is an up/down character and the list is not dropped down
                   if not ((CharCode in [VK_UP, VK_DOWN, VK_HOME, VK_END]) and not isDroppedDown and fcIsInwwGrid(Self)) then
                   begin
                      i:=FListBox.ItemIndex;

                      if (not showmatchtext) or
                        (showmatchtext and (CharCode in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT])) or
                        (showmatchtext and (CharCode in [VK_HOME,VK_END]) and isDroppedDown)then
                        with Message do SendMessage(FListBox.Handle, Msg, WParam, LParam);

                      if i <> FListBox.ItemIndex then
                      begin
                        if EditCanModify then begin
                           ItemIndex := FListBox.ItemIndex;
                           SetModified(True);
                        end;
                      end;
                   end;
                   if  (isDroppedDown and { rsw }
                      (CharCode in [VK_UP, VK_DOWN, VK_NEXT, VK_PRIOR, VK_HOME, VK_END])) then
                   begin
                      SelectAll;
                      exit;
                   end;
                end;
             end;
          end
       end
  end;

(*
  case Message.Msg of { RSW - 2/22/99 - Support vk_up/vk_down in dropdown container }
    wm_KeyDown, wm_SysKeyDown, wm_Char:
      with TWMKey(Message) do
      begin
         { 4/29/98 - skip code if shift key pressed }
         if not (ssShift in fcGetShiftState) and (not EffectiveReadOnly) then
         begin
             if not (isDroppedDown and
               (CharCode in [VK_LEFT, VK_RIGHT]) and
               (Message.Msg=wm_KeyDown)) then
             begin

               HandleDropDownKeys(CharCode, KeyDataToShiftState(KeyData));

               i:=FListBox.ItemIndex;

               if (CharCode <> 0) and IsDroppedDown then
               begin
                 with TMessage(Message) do
                    SendMessage(DropDownContainer.Handle, Msg, WParam, LParam);
               end;
               if i <> FListBox.ItemIndex then ItemIndex := FListBox.ItemIndex;
            end;

            if  (isDroppedDown and
               (CharCode in [VK_UP, VK_DOWN, VK_NEXT, VK_PRIOR, VK_HOME, VK_END])) then exit;
         end
      end

  end;

*)
  inherited WndProc(Message);


end;

Procedure TfcCustomColorCombo.DrawColorRect(ACanvas:TCanvas;Rect:TRect;curColor:TColor;Highlight: Boolean);
var ColorRect:TRect;
    AHeight,AWidth:Integer;
    OldPenColor,OldBrushColor:TColor;
    Left,Right,Top,Bottom:Integer;
begin
  OldPenColor:=ACanvas.Pen.Color;
  OldBrushColor:= ACanvas.Brush.Color;

  if (csDesigning in ComponentState) then ListBoxNeeded;

  GetColorRectInfo(Rect,AWidth,AHeight);

  Left := Rect.Left+ColorRectMargin;
  Right := Rect.Left+ColorRectMargin + AWidth;
  Top := Rect.Top + ColorRectMargin;
  Bottom := Rect.Top +ColorRectMargin + AHeight;
  if fcIsInwwObjectView(self) and (csPaintCopy in ControlState) then begin { 7/8/99 }
     Top:= Top;
     Bottom:= Bottom;
     Left:= left + 1;
     Right:= Right + 1;
  end;

  if (AlignmentVertical = fcavCenter) then begin
     Top := Rect.Top + ((Rect.Bottom-Rect.Top-AHeight) div 2);
     Bottom := Rect.Bottom - ((Rect.Bottom-Rect.Top-AHeight) div 2);
  end;

  if ccoShowColorNames in FColorListOptions.Options then
  begin
    if ColorAlignment = taRightJustify then begin
          Left := fcmax(Rect.Right-ColorRectMargin-AWidth,
                        GetIndentLeft(Rect)+ACanvas.TextWidth(Text)+2*ColorRectMargin);
          Right := fcmin(Left+AWidth+ColorRectMargin,Rect.Right - ColorRectMargin);
    end;
  end
  else //if not ShowButton or (not Highlight) then
    Right := fcmin(Left+AWidth+ColorRectMargin,Rect.Right - ColorRectMargin);
//    Right :=    Rect.Right - ColorRectMargin;
//  else Right :=    Rect.Right - ColorRectMargin - GetIconIndent;

  if ColorAlignment = taRightJustify then { 5/3/99 - RSW - Move color rect 1 pixel to the left (Looks better) }
     ColorRect := Classes.Rect(Left-1,Top,Right-1,Bottom)
  else ColorRect := Classes.Rect(Left,Top,Right,Bottom);

  if curColor <> clNullColor then begin
      if fcIsInwwGrid(self) and (curColor = clNone) and (focused xor Highlight) then begin
         ACanvas.Pen.Color := clWhite;
         ACanvas.Brush.Color := clHighlight;
      end
      else begin
         if (Highlight) and not isDroppedDown then ACanvas.Pen.Color := clWhite
         else ACanvas.Pen.Color := clBlack;
         ACanvas.Brush.Color := curColor;
      end;
      ACanvas.FillRect(ColorRect);
      ACanvas.Rectangle(ColorRect.Left, ColorRect.Top, ColorRect.Right, ColorRect.Bottom);

      if (CurColor = clNone) or (CurColor = clNullColor) then
       if ccoShowColorNames in FListBox.Options then begin
         ACanvas.Polyline([Point(ColorRect.TopLeft.X,ColorRect.TopLeft.Y),
                           Point(ColorRect.BottomRight.X,ColorRect.BottomRight.Y)]);
         ACanvas.Polyline([Point(ColorRect.TopLeft.X,ColorRect.BottomRight.Y-1),
                           Point(ColorRect.BottomRight.X,ColorRect.TopLeft.Y-1)]);
      end;

      ACanvas.Pen.Color := OldPenColor;
      ACanvas.Brush.Color := OldBrushColor;
  end;
end;

procedure TfcCustomColorCombo.DrawInGridCell(ACanvas:TCanvas;Rect:TRect;
   State:TGridDrawState);
var s:String;
begin
   if GetComboDatatype = ccdColor then begin
      if Datalink.Field.isnull then s:=''
      else s:=GetComboDisplayText(Datalink.Field.AsInteger);
   end
   else s:= Datalink.Field.Text;
   PaintToCanvas(ACanvas, Rect,(gdSelected in State), True, s);
end;

procedure TfcCustomColorCombo.DropDown;
var Itemid:integer;
begin
  if SkipDropDown then exit;
  ListBox.FClickedInControl := False;
  Listbox.FIgnoreMouseScroll := False;
  Listbox.FLastPoint := Point(0,0);
  FOriginalIndex := ItemIndex;
  FOriginalSelectedColor:= SelectedColor;
  {if ((ItemIndex = -1) and (Text <> '')) or
      ((ItemIndex<>-1) and (AnsiPos(Text,ListBox.AllColors.Names[ItemIndex])<>1)) then
      FOriginalIndex := -1;}

  if (Datalink.field=nil) and ((datasource<>nil) or (datafield<>'')) then exit;

  if (ButtonStyle = cbsEllipsis) then
  begin
    DoDropDown;
    FListBox.UpdateItems;   //3/4/99 - Call UpdateItems instead.
    //FListBox.SortList;
    ExecuteColorDialog;
  end
  else begin
    with FListBox do
    begin
      Alignment:= GetEffectiveAlignment;

      Color:= ColorListOptions.Color;
      ColorAlignment := self.ColorAlignment;
      ItemHeight := ColorListOptions.ItemHeight;
      IntegralHeight := FColorListOptions.IntegralHeight;

      if FColorListOptions.ColorWidth <> 0 then
        ColorWidth := FColorListOptions.ColorWidth
      else ColorWidth := ItemHeight - 2 * ColorRectMargin;

      Font := FColorListOptions.Font;
      Options := FColorListOptions.Options;
      SortBy := FColorListOptions.SortBy;

// (2/9/99) Removed following line, appears to be redundant, as FListBox.CustomColors gets updated in this controls CustomColors.OnChange event
//      FListbox.FCustomColors.Assign(self.FCustomColors);
      UpdateItems;
      // 3/4/99 -PYW- Call UpdateItems instead so that the OnFilterColor event will always be fired.
      //if not FListBoxUpdated then SortList;

      ItemId := Listbox.Items.IndexOfName(Self.text);
//      fcNameInList(self.Text, AllColors);
      self.FItemIndex := ItemId;
      ItemIndex:= ItemID; { 2/11/99 - RSW }
      if (ItemId <> -1) and
         (self.FItemIndex <> -1) and (self.FSelectedColor <> clNullColor) then
        SelectedColor := self.SelectedColor
      else ItemIndex := -1;
    end;
    // 3/4/99 - Why invalidate?  Causes Flicker - PYW
    //    if Style = csDropDownList then Invalidate;
    inherited;
  end;
  Update; //2/25/99 - Prevent Flicker when selecting all on DropDown.
  SelectAll;
  HideCaret;
end;

Function TfcCustomColorCombo.ExecuteColorDialog: boolean;
var AColorDialog: TColorDialog;
    accept:boolean;
    MResult:TModalResult;
    procedure FillCustomColors;
    var i,index:integer;
    begin
       AColorDialog.CustomColors.Clear;
       for i:= ord('A') to ord('P') do
       begin
          index := i-ord('A');
          if index > CustomColors.count-1 then exit;
          AColorDialog.CustomColors.Add('Color'+char(i)+'='+
              fcGetValuesFromStringList(FCustomColors,index));
       end;
    end;
begin
  if FColorDialog <> nil then
     AColorDialog := FColorDialog
  else begin
     AColorDialog := TColorDialog.Create(self);
     with AColorDialog do begin
        CustomColors.Assign(CustomColors);
        if (cdoPreventFullOpen in ColorDialogOptions) then
           Options := Options + [cdPreventFullOpen];
        if (cdoFullOpen in ColorDialogOptions) then
           Options := Options + [cdFullOpen];
        if (cdoSolidColor in ColorDialogOptions) then
           Options := Options + [cdSolidColor];
        if (cdoAnyColor in ColorDialogOptions) then
           Options := Options + [cdAnyColor];
     end;

     FillCustomColors;
  end;

  AColorDialog.Color := SelectedColor;
  if Assigned(FOnInitColorDialog) then FOnInitColorDialog(self, AColorDialog);

  if AColorDialog.Execute then begin
     accept := True;
     mResult := mrOk;
  end
  else mResult := mrCancel;
  result:= (mResult = mrOK);

  if Assigned(FOnCloseColorDialog) then
     FOnCloseColorDialog(self, AColorDialog, MResult, accept);

  if accept and (mResult = mrOK) then begin
     //3/4/99 -PYW- Only call SetModified if the combo can be modified.
     if EditCanModify then begin           //May only want to do this if color changed.
        SetModified(True);
        SelectedColor := AColorDialog.Color;
     end;
  end;

  invalidate;

  if AColorDialog.Owner = Self then AColorDialog.Free;
end;

function TfcCustomColorCombo.GetColorFromRGBString(RGBString:String; var AColor:TColor):boolean;
var Red,Green,Blue:Byte;
    ColorStr: string;
    Startpos,i:Integer;

    function GetNextColor(RGBStr:String;var index:Integer;var Value:Byte):Boolean;
    var tempstr:String;
        tempInt:Integer;
       function IsNumber(ch: Char): Boolean;
       begin
         result:= (ch>='0') and (ch<='9');
       end;
    begin
       tempstr := '';
       result := False;
       if index > length(RGBStr) then exit;

       while not IsNumber(RGBStr[Index]) do begin
          Index:=Index+1;
       end;

       while (RGBStr[index]<>',') and (index <= length(RGBStr)) do begin
         tempstr :=  tempstr+RGBStr[index];
         index:=index+1;
       end;

       fcStripWhiteSpace(tempstr);
       TempInt := StrToIntDef(tempstr,-1);
       if (TempInt = -1) or (TempInt > 255) then exit;

       result := True;
       Value := TempInt;
       index := index+1;
    end;

begin
   Result := False;
   AColor := clNullColor;

   Startpos := Pos('RGB:',RGBString);
   if Startpos <> 1 then exit;

   i:=5;     //!!!! Assumes RGB format....

   if not GetNextColor(RGBString,i,Red) then exit;
   if not GetNextColor(RGBString,i,Green) then exit;
   if not GetNextColor(RGBString,i,Blue) then exit;

   ColorStr := '$'+fcRGBToHexString(Blue,Green,Red);
   AColor := StringToColor(ColorStr);
   Result := True;
end;

Procedure TfcCustomColorCombo.GetColorRectInfo(Rect:TRect;var AWidth:Integer;var AHeight:Integer);
begin
  if FColorListOptions.ItemHeight < (Rect.Bottom-Rect.Top) then
     Aheight := FColorListOptions.ItemHeight - 2*ColorRectMargin
  else
     Aheight := (Rect.Bottom-Rect.Top) - 2*ColorRectMargin;

  if FColorListOptions.ColorWidth = 0 then begin
     if FColorListOptions.ItemHeight > (Rect.Bottom-Rect.Top) then
        AWidth := AHeight
     else AWidth := (FColorListOptions.ItemHeight)-2*ColorRectMargin
  end
  else Awidth :=FColorListOptions.ColorWidth;
end;

function TfcCustomColorCombo.GetIndentLeft(Rect:TRect): Integer;
var AWidth,AHeight:Integer;
begin
  if fcIsInwwGrid(self) and (ColorAlignment=taRightJustify) then
    result := 1
  else
    result := 2;

  if (ColorAlignment <> taLeftJustify) then exit;
  if FColorListOptions = nil then exit;

  GetColorRectInfo(Rect,AWidth,AHeight);

  if (AWidth <> 0) then
     inc(result, AWidth + 2);
end;

function TfcCustomColorCombo.GetRightIndent(Rect:TRect): Integer;
var AWidth,AHeight:Integer;
begin
//  result := GetIndentLeft(Rect);
  result := Width-2;
  if (ColorAlignment <> taRightJustify) then exit;
  if FColorListOptions = nil then exit;
  GetColorRectInfo(Rect,AWidth,AHeight);
  if (Awidth <> 0) then
     inc(result, -AWidth);
end;

function TfcCustomColorCombo.GetTopIndent: Integer;
begin
  result:= inherited GetTopIndent;

end;

function TfcCustomColorCombo.GetTextRect(ARect:TRect; Highlight:Boolean): TRect;
var AWidth,AHeight:Integer;
begin
   result:=ARect;
   if FColorListOptions = nil then exit;

   GetColorRectInfo(ARect,AWidth,AHeight);

   if (ColorAlignment = taRightJustify) then
      result := Classes.Rect(ARect.Left + GetIndentLeft(ARect)+1,
                             ARect.Top + GetTopIndent,
                             ARect.Right-2*ColorRectMargin-AWidth,
                             ARect.Bottom)
   else
      result := Classes.Rect(ARect.Left + GetIndentLeft(ARect)+1,
                           ARect.Top + GetTopIndent,
                           ARect.Right -ColorRectMargin,
                           ARect.Bottom);

   if BorderStyle=bsSingle then result.Top:=result.Top + 1
   else if fcIsInwwObjectView(self) then result.Top:= result.Top -1;

end;

procedure TfcCustomColorCombo.Paint;
begin
//  with ClientRect do
//     PaintToCanvas(Canvas, Rect(0, 0, Right - Left, Bottom - Top), True, False, Text)

  PaintToCanvas(Canvas, GetClientEditRect, True, False, Text);

end;

function TfcCustomColorCombo.GetEffectiveAlignment: TLeftRight;
begin
   if (DataLink=Nil) or (DataLink.Field=nil) then result:= FAlignment
   else if DataLink.Field is TStringField then result:= DataLink.Field.Alignment
   else result:= taLeftJustify;
end;

procedure TfcCustomColorCombo.PaintToCanvas(ACanvas: TCanvas; Rect: TRect;
  Highlight, GridPaint: Boolean; Text: string);
var Index: integer;
//    TempRight: Integer;
    s: String;
    tempcolor:TColor;
    SaveBkColor,SaveTextColor:TColor;
    SaveOldBrushColor,SaveOldFontColor:TColor;
    SaveBKMode:Integer;
    flags:UINT;
    TempRect:TRect;

  function DrawHighlight:boolean;
  begin
     result := ((not Editable and Focused) or fcParentGridFocused(Self)) and
              not (csPaintCopy in ControlState);
  end;

begin
  SaveBkColor := GetBkColor(ACanvas.Handle);
  SaveTextColor:= GetTextColor(ACanvas.Handle);
  SaveBkMode := GetBkMode(ACanvas.Handle);
  SaveOldBrushColor := ACanvas.Brush.Color;
  SaveOldFontColor := ACanvas.Font.Color;

  ACanvas.Font := Font; { 5/3/99 - RSW (Fixes problem where font's style not being used }

  try
  if (csDesigning in ComponentState) then ListboxNeeded;
  s := Text;

  if s <> '' then
     Index := fcNameInList(s,ListBox.AllColors)
  else Index := -1;

  if (fcIsInwwGrid(self) and (not Focused or not Highlight)) or
     ((Style = csDropDownList) and Focused and not IsDroppedDown and not showmatchtext) then
  begin
//    TempRight := Rect.Right;

{RSW comment out
    if ShowButton then
      if (Highlight and not DrawHighlight) or (Highlight and (Focused or fcParentGridFocused(Self)) ) then
         if not GridPaint then
            Rect.Right := Rect.Right - GetIconIndent;
}
    if (not fcIsInwwGrid(Self)) then InflateRect(Rect,-1,-1);

    // Draw Background in the Grid's Colors and surround it with a focus rect
//    if (not fcIsInwwGrid(Self)) or ((not GridPaint) and (DrawHighlight)) then
//       ACanvas.Brush.Color := fcThisThat(Highlight, clHighlight, self.color);  { 7/8/99 - RSW - Use color of control }

     { 7/8/99 - RSW - Use color of control }
     if (not fcIsInwwGrid(self)) or (not GridPaint) then
       ACanvas.Brush.Color :=
          fcThisThat(Highlight and (DrawHighlight or not fcIsInwwGrid(self)), clHighlight, self.Color);

    if not fcIsInwwObjectViewPaint(self) then ACanvas.FillRect(Rect);

    if (not GridPaint) and Highlight and DrawHighlight then//((Focused) or fcParentGridFocused(Self) or (not fcIsInwwGrid(Self))) then
    begin
      SetBkColor(ACanvas.Handle, ColorToRGB(clHighlightText));
      SetTextColor(ACanvas.Handle, ColorToRGB(clHighlight));
      ACanvas.DrawFocusRect(Rect);
    end;

    if (not fcIsInwwGrid(Self)) or ((not GridPaint) and not (Highlight and not DrawHighlight)) then
    begin
       SetBkMode(ACanvas.Handle, TRANSPARENT);
       SetBkColor(ACanvas.Handle, ColorToRGB(fcThisThat(Highlight, clHighlight, clWindow)));
       SetTextColor(ACanvas.Handle, ColorToRGB(fcThisThat(Highlight, clWindow, clWindowText)));
    end;

    if (not fcIsInwwGrid(Self)) then InflateRect(Rect,1,1);

    TempRect := GetTextRect(Rect,Highlight);
    flags := 0;
    if AlignmentVertical = fcavCENTER then flags := Flags or DT_VCENTER
    else flags := Flags or DT_TOP;

    if UnBoundAlignment = taRightJustify then flags := Flags or DT_RIGHT
    else flags := Flags or DT_LEFT;
    if fcIsInwwObjectViewPaint(self) then begin
       SetBkMode(ACanvas.Handle, TRANSPARENT);
       try
          DrawText(ACanvas.Handle,PChar(s),Length(s),TempRect,flags);
       finally
          SetBkMode(ACanvas.Handle, OPAQUE);
       end
    end
    else DrawText(ACanvas.Handle,PChar(s),Length(s),TempRect,flags);
//    ACanvas.TextOut(Rect.Left + GetIndentLeft(Rect), Rect.Top + GetTopIndent(Rect), s);
  end
  else if not fcisinwwGrid(Self) and not Focused then begin
    ACanvas.Brush.Color:= Color; { 5/3/99 - RSW - Previuosly Brush.Color not set }
    ACanvas.FillRect(Rect);
    //3/19/99 -PYW- Rect is already correct now, so do not use GetIconIndent.
    Rect.Right := Rect.Right{ - GetIconIndent }+ ColorRectMargin;;

    flags := 0;
    if AlignmentVertical = fcavCENTER then flags := Flags or DT_VCENTER
    else flags := Flags or DT_TOP;

    if UnboundAlignment = taRightJustify then begin
       flags := Flags or DT_RIGHT;
       Rect.Right:= Rect.Right - 2; { 4/10/99 - Too close to right edge before }
    end
    else flags := Flags or DT_LEFT;
    TempRect := GetTextRect(Rect,Highlight);
    DrawText(ACanvas.Handle,PChar(s),Length(s),TempRect,flags);
//    ACanvas.TextOut(Rect.Left + GetIndentLeft(Rect), Rect.Top + GetTopIndent(Rect), s);
  end
  else if fcisinwwGrid(Self) then
     Rect.Right := Rect.Right {- GetIconIndent }
  else Rect.Right := Rect.Right {- GetIconIndent} + ColorRectMargin; { 5/3/99 - RSW (Fix for AlignRight) }

  if (not GridPaint) or ((not Focused) and not fcParentGridFocused(Self) )then
     Highlight := DrawHighlight;

  if (Index = -1) then begin
     if GetColorFromRGBString(s, tempColor) then
        DrawColorRect(ACanvas,Rect,tempColor,Highlight)
     else if (s='') then DrawColorRect(ACanvas,Rect,clNullColor,Highlight)
     {2/17/99 - Don't DrawColorRect if the color is null}
     else if ((not fcIsInwwGrid(self)) or (tempColor <> clNullColor)) and
         (not (csPaintCopy in ControlState)) then
//        DrawColorRect(ACanvas,Rect,ListBox.SelectedColor,Highlight)
           DrawColorRect(ACanvas,Rect,SelectedColor,Highlight) { 2/22/99 - RSW - Use combo's selectedcoor instead }
  end
  else DrawColorRect(ACanvas,Rect,fcGetColorFromList(FListBox.FAllColors,Index),Highlight);

  //Restore Canvas Colors.
  finally
     SetBkColor(ACanvas.Handle, savebkColor);
     SetTextColor(ACanvas.Handle,savetextcolor);
     SetBkMode(ACanvas.Handle,savebkmode);
     ACanvas.Brush.Color := SaveOldBrushColor;
     ACanvas.Font.Color := SaveOldFontColor;
  end;
end;

procedure TfcCustomColorCombo.RefreshList;
//var BeforeText:String;
begin  //!!!! Need to handle when initcolorlist will lose current selected color.
{   BeforeText := '';
   if ItemIndex <> -1 then BeforeText := ListBox.AllColors.Names[ItemIndex];}
   ListBox.InitColorList;
{   if fcNameinList(BeforeText,ListBox.AllColors) = -1 then begin
     ItemIndex := -1;
     Text := '';
     invalidate;
   end;}
end;

constructor TfcCustomColorCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  ButtonStyle := cbsDownArrow;
  FCustomColors := TStringList.Create;
  DropDownCount:= 8;
  FColorListOptions := TfcColorListOptions.Create(Self);
  FAlignment := taLeftJustify;
//  FAlignmentVertical := fcavTop;
  FColorAlignment := taLeftJustify;
  FColorDialogOptions := [cdoPreventFullOpen];
  FCustomColors.OnChange := CustomColorsChangeEvent;
  FSelectedColor := clNullColor;
  FItemIndex := -1;
  ShowMatchText := True;
  Style := csDropDownList;
end;

destructor TfcCustomColorCombo.Destroy;
begin
  FColorListOptions.Free;
  FCustomColors.Free;
  FListbox.Free;
  FListbox:= nil;
//  FCanvas.Free;
  inherited Destroy;
end;

{************************************* TfcColorListOptions **************************************}

destructor TfcColorListOptions.Destroy;
begin
  FFont.Free;
  inherited destroy;
end;

constructor TfcColorListOptions.Create(AOwner: TfcCustomColorCombo);
begin
  inherited Create;
  FCombo := AOwner;
  FOptions:= [ccoShowStandardColors,ccoShowColorNames];
  FNoneString := 'None';
  FColor := clWindow;
  FFont := TFont.Create;
  FGreyScaleIncrement := 10;
  FIntegralHeight := True;
  FItemHeight := 16;
end;

procedure TfcColorListOptions.SetGreyScaleIncrement(Value: Integer);
begin
  if (FGreyScaleIncrement <> Value) and
      (Value > 0) and (Value <=255) then begin
     FGreyScaleIncrement := Value;
  end;
end;

procedure TfcColorListOptions.SetColor(Value: TColor);
begin
  if FColor <> Value then FColor := Value;
end;

procedure TfcColorListOptions.SetColorWidth(Value: Integer);
begin
  if FColorWidth <> Value then begin
     FColorWidth := Value;
     FCombo.SetEditRect;
     FCombo.Invalidate;
  end;
end;

procedure TfcColorListOptions.SetFont(Value: TFont);
begin
  if FFont <> Value then FFont.Assign(Value);
end;

procedure TfcColorListOptions.SetIntegralHeight(Value: Boolean);
begin
  if FIntegralHeight <> Value then FIntegralHeight := Value;
end;

procedure TfcColorListOptions.SetItemHeight(Value: Integer);
begin
  if FItemHeight <> Value then FItemHeight := Value;
end;

procedure TfcColorListOptions.SetNoneString(Value: String);
begin
  if (FNoneString <> Value) then FNoneString := Value;
end;

procedure TfcColorListOptions.SetOptions(Value:TfcColorListBoxOptions);
begin
  if FOptions <> Value then begin
     FOptions := Value;
     if FCombo.ListBox <> nil then FCombo.ListBox.Options := FOptions;
  end;
end;

procedure TfcColorListOptions.SetSortBy(Value: TfcSortByOption);
begin
  if FSortByOption <> Value then
     FSortByOption := Value;
end;

function TfcColorListOptions.StoreNoneString: boolean;
begin
   if FNoneString = 'None' then result := False
   else result := True;
end;

function TfcCustomColorList.GetHighlightColor: TColor;
begin
  if FHighlightColor = clNone then
  begin
    if Focused or (Owner is TfcCustomColorCombo) then result := clHighlight
    else begin
    //4/9/99 -PYW- When multiselect is true don't paint in the inactive focus color
    //             because there is no selection.
       if (not MultiSelect) then result := clBtnFace
       else result := clHighlight;
    end
  end else result := FHighlightColor;
end;

function TfcCustomColorList.GetHighlightTextColor: TColor;
begin
  if FHighlightTextColor = clNone then
  begin
    if fcHighestRGBVal(GetHighlightColor) > 128 then result := clWindowText
    else begin
       result := clHighlightText;
    end;
  end else result := FHighlightTextColor;
end;

procedure TfcCustomColorList.WMLButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
  FClickedInControl := True;  // Added so initial buttonclick of the dropdown button won't close up listbox. -ksw (2/19/99)
end;

{ When going into edit mode, don't reload control }
function TfcCustomColorCombo.EditCanModify: Boolean;
var OrigSkipDataChange: boolean;
begin
   OrigSkipDataChange:= SkipDataChange;
   SkipDataChange:= True;
   try
     result:= inherited EditCanModify;
   finally
     SkipDataChange:= OrigSkipDataChange;
   end;
end;

function TfcCustomColorCombo.IsCustomColor(s: string): Boolean;
begin
  result := (CustomColors.IndexOfName(s) <> -1) or
    ((Copy(s, 1, Length('Grey')) = 'Grey') and
     (StrToIntDef(Copy(s, Length('Grey') + 1, Length(s)), -1) <> -1)) or
    (s = 'clNullColor');
end;

function TfcCustomColorCombo.ColorString(s: string): string;
begin
  result := s;
  if not IsCustomColor(result) then result := 'cl' + result;
end;

function TfcCustomColorCombo.GetSelectedColorString: string;
var i: Integer;
begin
  result := 'clNullColor';
  ListBox.InitColorList;
  i := fcValueInList(IntToHex(SelectedColor, 6), ListBox.AllColors);
  if i <> -1 then result := ColorString(ListBox.AllColors.Names[i]);
end;

procedure TfcCustomColorCombo.SetSelectedColorString(Value: string);
var AColor: TColor;
    AStr: string;
begin
  ListBox.InitColorList;
  AColor := clNullColor;
  if (Copy(Value, 1, 2) = 'cl') and not IsCustomColor(Copy(Value, 3, Length(Value))) then
    Value := Copy(Value, 3, Length(Value));
  AStr := ListBox.AllColors.Values[Value];
  if AStr <> '' then AColor := StringToColor('$' + AStr);
  SelectedColor := AColor;
end;

end.
