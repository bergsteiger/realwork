{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dfm2html;

interface
{$I dc.inc}
uses
  Controls, Classes, Forms, SysUtils, Graphics, TypInfo;

type
  TScriptType = (sctJavaScript, sctVBScript, sctUnknown);

  TVAlignment = (tvaTopJustify, tvaMiddleJustify, tvaBottomJustify);

  THTMLEventKind = (
    ekOnLoad, ekOnUnload, ekOnClick, ekOnDblClick, ekOnMouseDown, ekOnMouseUp,
    ekOnMouseOver, ekOnMouseMove, ekOnMouseOut, ekOnFocus, ekOnBlur, ekOnKeypress,
    ekOnKeyDown, ekOnKeyUp, ekOnSubmit, ekOnReset, ekOnSelect, ekOnChange, ekUnknown);
  THTMLEventKinds = set of THTMLEventKind;

type
  PObjEvent = ^TObjEvent;
  TObjEvent = packed record
    Owner: TObject;
    CodePtr: Pointer;
    Name, MethodName: Shortstring;
  end;

type

  TEventManager = class;

  THTMLControl = class
  private
    FControl: TControl;
    FUseColor: boolean;
    FAlignment: TAlignment;
    FVAlignment: TVAlignment;
    procedure SetControl(Value: TControl); virtual;
  protected
    FHTMLLevel: integer;
    FNextHTMLLevel: integer;
    FEventsMan: TEventManager;
    procedure DoSetControl; virtual;
    function GetEvents: string;
  public
    constructor Create(Level: integer); virtual;
    destructor Destroy; override;
    procedure WriteToStream(Stream: TStream);
    function  GetTag: string; virtual;
    property  Control: TControl read FControl write SetControl;
    property  UseColor: boolean read FUseColor write FUseColor;
    property  Alignment: TAlignment read FAlignment write FAlignment;
    property  VAlignment: TVAlignment read FVAlignment write FVAlignment;
  end;

  THTMLControlClass = class of THTMLControl;

  TEventList = class;

  TEventManager = class
  private
    FEvents: TEventList;
    FMemberEvent: THTMLEventKinds;
    FScriptType: TScriptType;
    function  getParams(Event: THTMLEventKind): string;
    procedure PropCallBack(Instance: TPersistent; PropInfo: PPropInfo; UserData:Integer);
  public
    constructor Create(EventKinds: THTMLEventKinds);
    destructor Destroy; override;
    procedure FillEvents(const Ctrl: TControl; ScriptType: TScriptType);
    procedure ClearEvents;
    property  Events: TEventList read FEvents;
    property  MemberEvents: THTMLEventKinds read FMemberEvent write FMemberEvent;
  end;

  TEventList = class
  private
    FItems: TList;
    function GetCount: integer;
    function GetItems(Index: integer): TObjEvent;
  public
    constructor Create;
    destructor Destroy; override;
    function  Add(const EventOwner: TObject; EventPtr: Pointer; const EventName, CallMethodName: string): integer;
    function  Remove(const EventOwner: TObject): integer;
    procedure Delete(Index: Integer);
    procedure Clear;
    property  Count: integer read GetCount;
    property  Items[Index: integer]: TObjEvent read GetItems; default;
  end;

procedure Form2Html(Form: TCustomForm; AScriptFile: TFileName; AScriptType: TScriptType; OutStream : TStream);
function  Form2HtmlStr(Form: TCustomForm; AScriptFile: TFileName; AScriptType: TScriptType): string;

procedure RegisterControlClass(VCLClass: TControlClass; HTMLClass: THTMLControlClass);
procedure UnRegisterControlClass(VCLClass: TControlClass);

{$IFDEF DEBUG_DFM2HTML}
procedure DrawGrid(OutCanvas: TCanvas);
{$ENDIF}

implementation

uses
  Windows, Stdctrls, Extctrls, dcdreamlib, dcsystem;

type

  TInputCtrlType = (ictText, ictPassword, ictCheckbox, ictRadio, ictSubmit, ictReset,
                   ictFile, ictHidden, ictImage, ictButton);

  THTMLParamType = (ptSender, ptShift, ptKey, ptMouseBttn, ptX, ptY);
  THTMLParamTypes = set of THTMLParamType;

//BeginSkipConst
const
  SLBracket = '<';
  SRBracket = '>';
  SCloseTag = '/';
  SSpaceText = ' ';
  SFontText = 'FONT';
  SInputText = 'INPUT';
  STableText = 'TABLE';
  STRText = 'TR';
  STDText = 'TD';
  SLegendText = 'LEGEND';
  SFieldSetText = 'FIELDSET';
  SDisabledText = 'DISABLED';
  SReadOnlyText = 'READONLY';
  SHtmlText = 'HTML';
  SBodyText = 'BODY';
  SFormText = 'FORM';
  SOptionText = 'OPTION';
  SScriptText = 'SCRIPT';
  SSelectedText = 'SELECTED';
  SSelectText = 'SELECT';
  SPreText = 'PRE';
  STextAreaText = 'TEXTAREA';
  SCheckedText = 'CHECKED';
  SMultipleText = 'MULTIPLE';
  STextText = 'text/';
  SLeftText = '"LEFT"';
  SCenterText = '"CENTER"';
  SRightText = '"RIGHT"';
  STopText = '"TOP"';
  SMiddleText = '"MIDDLE"';
  SBottomText = '"BOTTOM"';
  SEqual = ' = ';
  SColsText = 'COLS' + SEqual;
  SRowsText = 'ROWS' + SEqual;
  SMaxLengthText = 'MAXLENGTH' + SEqual;
  SValueText = 'VALUE' + SEqual;
  SBorderText = 'BORDER' + SEqual;
  SWidthText = 'WIDTH' + SEqual;
  SHeightText = 'HEIGHT' + SEqual;
  SBGColorText = 'BGCOLOR' + SEqual;
  SAlignText = 'ALIGN' + SEqual;
  SFaceText = 'FACE' + SEqual;
  SSizeText = 'SIZE' + SEqual;
  SColorText = 'COLOR' + SEqual;
  SVAlignText = 'VALIGN' + SEqual;
  SNameText = 'NAME' + SEqual;
  SColSpanText = 'COLSPAN' + SEqual;
  SRowSpanText = 'ROWSPAN' + SEqual;
  STabIndexText = 'TABINDEX' + SEqual;
  SSRCText = 'SRC'+ SEqual;
  STypeText = 'TYPE' + SEqual;
  SSpacingText = 'CELLSPACING' + SEqual + '"0"' +' CELLPADDING' + SEqual + '"0"';
  SRulesText = 'RULES' + SEqual +'"NONE"';
  SCRLFText = #13#10;

  SInputCtrlTypes: array[TInputCtrlType] of string = (
                   '"TEXT"', '"PASSWORD"', '"CHECKBOX"', '"RADIO"', '"SUBMIT"', '"RESET"',
                   '"FILE"', '"HIDDEN"', '"IMAGE"', '"BUTTON"');

  SHTMLEvents : array [THTMLEventKind] of string = (
    'OnLoad', 'OnUnload', 'OnClick', 'OnDblClick', 'OnMouseDown', 'OnMouseUp',
    'OnMouseOver', 'OnMouseMove', 'OnMouseOut', 'OnFocus', 'OnBlur', 'OnKeyPress',
    'OnKeyDown', 'OnKeyUp', 'OnSubmit', 'OnReset', 'OnSelect', 'OnChange', '');

  SMappedEvents : array [THTMLEventKind] of string = (
    'OnShow', 'OnHide', 'OnClick', 'OnDblClick', 'OnMouseDown', 'OnMouseUp',
    SSpaceText, 'OnMouseMove', SSpaceText, 'OnEnter', 'OnExit', 'OnKeyPress',
    'OnKeyDown', 'OnKeyUp', SSpaceText, SSpaceText, SSpaceText, 'OnChange', '');

  SScriptTypes : array [TScriptType] of string = ('javascript', 'vbscript', '');
  SLeftDelim: array[TScriptType] of string = ('(', ' ', '');
  SRightDelim: array[TScriptType] of string = (')', '', '');
  SEventText = 'window.event.';
  SParamNames: array[THTMLParamType] of string = (
          'srcElement', 'shiftKey', 'keyCode', 'button', 'offsetX', 'offsetY');

  SBeginErrStr = ' intersect ';
  SEndErrStr = 'HTML creating error.';

//EndSkipConst
const
  cOnLoadParams = [ptSender];
  cOnUnLoadParams = cOnLoadParams;
  cOnClick = cOnLoadParams;
  cOnDblClick = cOnLoadParams;
  cOnMouseDown = [ptSender, ptMouseBttn, ptShift, ptX, ptY];
  cOnMouseUp = cOnMouseDown;
  cOnMouseOver = [];
  cOnMouseMove = [ptSender, ptShift, ptX, ptY];
  cOnMouseOut = [];
  cOnFocus = cOnLoadParams;
  cOnBlur = cOnLoadParams;
  cOnKeyPress  = [ptSender, ptKey];
  cOnKeyDown = [ptSender, ptShift, ptKey];
  cOnKeyUp = cOnKeyDown;
  cOnSubmit = [];
  cOnReset = [];
  cOnSelect = [];
  cOnChange = cOnLoadParams;
  cUnknown = [];

  cMappedParams : array [THTMLEventKind] of THTMLParamTypes = (
    cOnLoadParams, cOnUnLoadParams, cOnClick, cOnDblClick, cOnMouseDown,
    cOnMouseUp, cOnMouseOver, cOnMouseMove, cOnMouseOut, cOnFocus, cOnBlur, cOnKeyPress,
    cOnKeyDown, cOnKeyUp, cOnSubmit, cOnReset, cOnSelect, cOnChange, cUnknown);

type
  TColorReference = record
    red   : byte;
    green : byte;
    blue  : byte;
  end;

{--------------------------------------------------}

procedure WriteStrToStream(const Stream: TStream; const Str: string);
begin
  Stream.Write(PChar(Str)^, Length(Str));
end;

procedure DelLast(var Str: string; Count: integer);
begin
  delete(Str, Length(Str) -Count +1, Count);
end;


function GetEventKind(const CtrlEvent: Shortstring): THTMLEventKind;
begin
  for Result := ekOnLoad to ekOnChange do
    if CompareText(CtrlEvent, SMappedEvents[Result]) = 0 then
      exit;
  Result := ekUnknown;
end;

{$IFDEF USE_FUNC_EX}
function GetHTMLEvents(const CtrlEvent: Shortstring): Shortstring;
begin
  Result := SHTMLEvents[GetEventKind(CtrlEvent)];
end;
{$ENDIF}

{--------------------------------------------------}

function ColorToRgbColor(Color : TColor) : TColorReference;
var
  rgb  : Longint;
begin
  rgb := ColorToRgb(Color);
  with result do
  begin
    red   := Byte(rgb);
    green := Byte(rgb shr 8);
    blue  := Byte(rgb shr 16);
  end;
end;

function ColorToHTMLString(Color : TColor) : string;
begin
  with ColorToRgbColor(Color) do
    result :='#' + IntToHex(red,2) + IntToHex(green,2) + IntToHex(blue,2); //don't resource
end;

{--------------------------------------------------}

function GetQuotedStr(const S: string): string;
begin
  Result := '"' + S + '"'; //don't resource
end;

function GetQuotedInt(Int: integer): string;
begin
  Result := GetQuotedStr(IntToStr(Int));
end;
function GetHeight(Height: integer): string;
begin
  Result := SHeightText + GetQuotedInt(Height);
end;

function GetWidth(Width: integer): string;
begin
  Result := SWidthText + GetQuotedInt(Width);
end;

function GetBGColor(BGColor: TColor): string;
begin
  Result := SBGColorText + GetQuotedStr(ColorToHTMLString(BGColor));
end;

function GetIndent(Level: integer): string;
begin
  Result := StringOfChar(SSpaceText, Level*2);
end;

function GetHTMLTagEx(const Name, Attributes, Body: string; NeedClose, CRLFFlag: boolean; Indent: integer): string;
  function getTag(const TagName: string): string;
  begin
    Result := SLBracket + TagName + SRBracket;
  end;
begin
  if Attributes <> '' then
    Result := SSpaceText + Attributes
  else
    Result := '';
  Result := GetIndent(Indent) + getTag(Name + Result);
  if CRLFFlag and (Body <> '') then
    Result := Result + SCRLFText;
  Result := Result + Body;
  if CRLFFlag and (Body <> '') then
    Result := Result + SCRLFText + GetIndent(Indent);
  if NeedClose then
    Result := Result + getTag(SCloseTag + Name);
end;

function GetHTMLTag(const Name, Attributes, Body: string; NeedClose: boolean): string;
begin
  Result := GetHTMLTagEx(Name, Attributes, Body, NeedClose, false, 0);
end;

function GetFontedTextEx(const FontName: string; FontSize: integer; FontColor: TColor; const Text: string; Indent: integer): string;
begin
  Result := GetHTMLTagEx(SFontText, SFaceText + GetQuotedStr(FontName) + SSpaceText +
           SSizeText + GetQuotedInt(FontSize) + SSpaceText +
           SColorText + GetQuotedStr(ColorToHTMLString(FontColor)), Text, true, false, Indent);
end;

{$IFDEF USE_FUNC_EX}
function GetFontedText(const FontName: string; FontSize: integer; FontColor: TColor; const Text: string): string;
begin
  Result := GetFontedTextEx(FontName, FontSize, FontColor, Text, 0);
end;
{$ENDIF}

function GetTextEx(Font: TFont; const Text: string; Indent: integer): string;
begin
  with Font do
    Result := GetFontedTextEx(Name, 1, Color, Text, Indent);
end;

function GetText(Font: TFont; const Text: string): string;
begin
  Result := GetTextEx(Font, Text, 0);
end;

function GetLegend(Font: TFont; const Text: string): string;
begin
  Result := GetHTMLTag(SLegendText,'', GetText(Font, Text), true);
end;

function GetFieldSet(const Title, Body: string; Font: TFont; Indent: integer): string;
begin
  Result := GetHTMLTagEx(SFieldSetText,'', GetLegend(Font, Title) + SCRLFText + Body + SCRLFText + GetIndent(Indent) , true, false, Indent);
end;

function GetTD(ColumnWidth, RowHeight, ColSpan, RowSpan: integer;
               Align: TAlignment; VAlign: TVAlignment; UseBGColor: boolean; BGColor: TColor;
               Body: string; Indent: integer): string;
const
  _Al: array [TAlignment] of string = (SLeftText, SRightText, SCenterText);
  _VAl: array [TVAlignment] of string = (STopText, SMiddleText, SBottomText);
begin
  Result := '';
  if RowHeight > 0 then
    Result := GetHeight(RowHeight);
  if ColumnWidth > 0 then
    Result := Result + SSpaceText + GetWidth(ColumnWidth);
  if Align <> taLeftJustify then
    Result := Result + SSpaceText + SAlignText + _Al[Align];
  if VAlign <> tvaMiddleJustify then
    Result := Result + SSpaceText + SVAlignText + _VAl[VAlign];
  if ColSpan > 1 then
    Result := Result + SSpaceText + SColSpanText + GetQuotedInt(ColSpan);
  if RowSpan > 1 then
    Result := Result + SSpaceText + SRowSpanText + GetQuotedInt(RowSpan);
  if UseBGColor then
    Result := Result + SSpaceText + GetBGColor(BGColor);
  Result := GetHTMLTagEx(STDText, Result, Body, true, true, Indent);
end;

function GetTR(Body: string; Indent: integer): string;
begin
  Result := GetHTMLTagEx(STRText, '', Body, true, true, Indent);
end;

function GetTable(Width, BorderWidth: integer; Events, Body: string; Indent: integer): string;
begin
  Result := GetWidth(Width) + SSpaceText + SBorderText + GetQuotedInt(BorderWidth) + SSpaceText + SRulesText + SSpaceText + SSpacingText;
  if Events <> '' then
    Result := Result + SSpaceText + Events;
  Result := GetHTMLTagEx(STableText, Result, Body, true, true, Indent);
end;

function GetScript(const SourceFile: string; ScriptType: TScriptType): string;
const
  STextText = 'text/'; //don't resource
begin
  Result := GetHTMLTag(SScriptText, STypeText + GetQuotedStr(STextText + SScriptTypes[ScriptType]) + SSpaceText +
             SSRCText + GetQuotedStr(SourceFile),'', true);
end;

{--------------------------------------------------}

type
  PRegistredItem = ^TRegistredItem;
  TRegistredItem = packed record
    VCLClass: TControlClass;
    HTMLClass: THTMLControlClass
  end;

  TRegistredClassList = class
  private
    FItems: TList;
    function GetCount: integer;
    function GetItems(Index: integer): TRegistredItem;
  public
    constructor Create;
    destructor Destroy; override;
    function  Add(VCLClass: TControlClass; HTMLClass: THTMLControlClass): integer;
    function  Remove(VCLClass: TControlClass): integer;
    procedure Delete(Index: Integer);
    procedure Clear;
    property  Count: integer read GetCount;
    property  Items[Index: integer]: TRegistredItem read GetItems;
  end;

  TRegistrar = class
  private
    FRegCtrls: TRegistredClassList;
    function  _GetHTMLClass(VCLClass: TClass): THTMLControlClass;
  public
    constructor Create;
    destructor Destroy; override;
    function  GetRegistredHTMLClass(AControl : TControl): THTMLControlClass;
    procedure RegisterControlClass(VCLClass: TControlClass; HTMLClass: THTMLControlClass);
    procedure UnRegisterControlClass(VCLClass: TControlClass);
    procedure UnRegisterAll;
  end;

{--------------------------------------------------}

  TCoords = class (TIntStack)
    function Peek(Index: integer): Integer;
  end;

  PChildItem = ^TChildItem;
  TChildItem = packed record
    VCLControl: TControl;
    HTMLControl: THTMLControl;
  end;

  TChildControlList = class
  private
    FItems: TList;
    function GetCount: integer;
    function GetItems(Index: integer): PChildItem;
  public
    constructor Create;
    destructor Destroy; override;
    function  Add(VCLControl: TControl; HTMLControl: THTMLControl): integer;
{    function  Remove(VCLControl: TControl): integer;}
    procedure Delete(Index: Integer);
    procedure Clear;
    procedure Sort;
    property  Count: integer read GetCount;
    property  Items[Index: integer]: PChildItem read GetItems;
  end;

  TControlGrid = class
  private
    FControl: TControl;
    FChildCtrls: TChildControlList;
    FVertLines: TCoords;
    FHorizLines: TCoords;
    FNextHTMLLevel: integer;
    procedure SetControl(Value: TControl);
    procedure Clear;
    procedure PackLines;
    procedure SortLines;
    function  _FindChildControl(Column, Row: integer; Exact: boolean): PChildItem;
    procedure _getControlSpans(Column, Row: integer; Control: TControl; var ColSpan, RowSpan: integer);
    procedure IntersectCtrls;
  public
    constructor Create;
    destructor Destroy; override;
    {$IFDEF USE_FUNC_EX}
    function  FindVCLControl(Column, Row: integer): TControl;
    {$ENDIF}
    function  FindHTMLControl(Column, Row: integer): THTMLControl;
    function  GetHTMLCtrlSpans(Column, Row: integer; var ColSpan, RowSpan: integer): THTMLControl;
    function  GetNextColumn(Column, Row: integer): integer;
    function  HasChildren: boolean;
    property  VertLines: TCoords read FVertLines;
    property  HorizLines: TCoords read FHorizLines;
    property  Control: TControl read FControl write SetControl;
    property  NextHTMLLevel: integer read FNextHTMLLevel write FNextHTMLLevel;
  end;

{--------------------------------------------------}

type
  TBodyFunction = function: string of object;

  THTMLTableBasedCtrl = class(THTMLControl)
  private
    FBorderWidth: integer;
    FGrid: TControlGrid;
    function _getTDEx(HTMLCtrl: THTMLControl; Column, Row, ColSpan, RowSpan: integer; Body: string; Level: integer): string;
    function  _getBody: string; virtual;
  protected
    procedure DoSetControl; override;
    function  _getTableBody: string;
    function  _getTable(Width, BorderWidth: integer; BodyFunc: TBodyFunction; UseEvents: boolean; Level: integer): string;
    procedure Inflate(Coord: TCoords; Delta: integer);
    property  Grid: TControlGrid read FGrid;
  public
    function  GetTag: string; override;
    constructor Create(Level: integer); override;
    destructor Destroy; override;
  end;

  THTMLCustomCtrl = class(THTMLControl)
  private
    function GetTabIndex: string;
    function GetDisabled: string;
  protected
    function GetAttributes: string; virtual;
  public
    constructor Create(Level: integer); override;
  end;

  THTMLInputCtrl = class(THTMLCustomCtrl)
  protected
    FType: TInputCtrlType;
    function GetTag: string; override;
    function GetAttributes: string; override;
  end;

  THTMLSelectCtrl = class(THTMLCustomCtrl)
  protected
    function _getOptStr(Value: integer; const Text: string; Selected: boolean): string;
    function GetOptions: string; virtual;
    function GetAttributes: string; override;
    function GetTag: string; override;
  end;

  THTMLButton = class(THTMLInputCtrl)
  public
    constructor Create(Level: integer); override;
  end;

  THTMLCheckBox = class(THTMLInputCtrl)
  protected
    function GetAttributes: string; override;
  public
    constructor Create(Level: integer); override;
    function GetTag: string; override;
  end;

  THTMLComboBox = class(THTMLSelectCtrl)
  protected
    function GetOptions: string; override;
  public
    constructor Create(Level: integer); override;
  end;

  THTMLEdit = class(THTMLInputCtrl)
  protected
    procedure DoSetControl; override;
    function GetAttributes: string; override;
  public
    constructor Create(Level: integer); override;
  end;

  THTMLGroupBox = class(THTMLTableBasedCtrl)
  private
    function _getGroupBody: string;
  protected
    procedure DoSetControl; override;
  public
    constructor Create(Level: integer); override;
    function  GetTag: string; override;
  end;

  THTMLLabel = class(THTMLCustomCtrl)
  protected
    procedure DoSetControl; override;
  public
    constructor Create(Level: integer); override;
    function GetTag: string; override;
  end;

  THTMLListBox = class(THTMLSelectCtrl)
  protected
    function GetAttributes: string; override;
    function GetOptions: string; override;
  public
    constructor Create(Level: integer); override;
  end;

  THTMLMemo = class(THTMLCustomCtrl)
  protected
    function GetAttributes: string; override;
  public
    constructor Create(Level: integer);override;
    function GetTag: string; override;
  end;

  THTMLPanel = class(THTMLTableBasedCtrl)
  private
    FWithOutBorder: boolean;
  protected
    procedure DoSetControl; override;
  public
    constructor Create(Level: integer); override;
    function GetTag: string; override;
  end;

  THTMLRadioButton = class(THTMLInputCtrl)
  public
    constructor Create(Level: integer); override;
    function GetTag: string; override;
  end;

  THTMLRadioGroup = class(THTMLGroupBox)
  protected
    procedure DoSetControl; override;
  public
    constructor Create(Level: integer); override;
  end;

  THTMLForm = class(THTMLTableBasedCtrl)
  private
    FScriptFile: TFileName;
    FScriptType: TScriptType;
    function _getScript(const SourceFile: string; ScriptType: TScriptType): string;
    function _getFormBody: string;
  public
    constructor Create(Level: integer); override;
    function  GetTag: string; override;
    property Grid;
    property ScriptFile: TFileName read FScriptFile write FScriptFile;
    property ScriptType: TScriptType read FScriptType write FScriptType;
  end;

{--------------------------------------------------}

type
  TMControl = class(TControl)
  public
    property Color;
  end;

function CmpCoords(Item1, Item2: Pointer): Integer;
begin
  Result := Integer(Item1) - Integer(Item2);
end;

function CmpCtrls(Item1, Item2: Pointer): Integer;
begin
  Result := PChildItem(Item1)^.VCLControl.Top - PChildItem(Item2)^.VCLControl.Top;
  if Result = 0 then
    Result := PChildItem(Item1)^.VCLControl.Left - PChildItem(Item2)^.VCLControl.Left;
end;

{==================================================}

var
  GlobalRegistry: TRegistrar;
  HtmlForm: THTMLForm;
  UseControlEvents: boolean;
  UseScriptType: TScriptType;

{==================================================}

function GetGlobalRegistry: TRegistrar;
begin
  if GlobalRegistry = nil then
    GlobalRegistry := TRegistrar.Create;
  Result := GlobalRegistry
end;

procedure ClearRegistry;
begin
  if GlobalRegistry <> nil then
  with GlobalRegistry do
  begin
    UnRegisterAll;
    Free;
  end;
end;

{==================================================}

{ TEventList }

function TEventList.Add(const EventOwner: TObject; EventPtr: Pointer; const EventName, CallMethodName: string): integer;
var
  PTmpItem : PObjEvent;
begin
  GetMem(PTmpItem, sizeof(TObjEvent));
  with PTmpItem^ do
  begin
    Owner := EventOwner;
    CodePtr := EventPtr;
    Name := EventName;
    MethodName := CallMethodName;
  end;
  Result := FItems.Add(PTmpItem);
end;

procedure TEventList.Clear;
begin
  while Count > 0 do
    Delete(0);
  FItems.Clear;
end;

constructor TEventList.Create;
begin
  FItems := TList.Create;
end;

procedure TEventList.Delete(Index: Integer);
begin
  with FItems do
  begin
    FreeMem(Items[Index]);
    Delete(Index);
  end;
end;

destructor TEventList.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

function TEventList.GetCount: integer;
begin
  Result := FItems.Count;
end;

function TEventList.GetItems(Index: integer): TObjEvent;
begin
  Result := TObjEvent(FItems.Items[Index]^);
end;

function TEventList.Remove(const EventOwner: TObject): integer;
var
  i: integer;
  PTmpItem : PObjEvent;
begin
  with FItems do
  begin
    for i := 0 to Count -1 do
    begin
      PTmpItem := Items[i];
      if PTmpItem^.Owner = EventOwner then
      begin
        FreeMem(PTmpItem);
        Delete(i);
        Result := i;
        exit;
      end;
    end;
  end;
  Result := -1;
end;

{ THTMLScript }

procedure TEventManager.ClearEvents;
begin
  FEvents.Clear;
end;

constructor TEventManager.Create(EventKinds: THTMLEventKinds);
begin
  FEvents := TEventList.Create;
  FMemberEvent := EventKinds;
end;

destructor TEventManager.Destroy;
begin
  ClearEvents;
  FEvents.Free;
  inherited;
end;

procedure TEventManager.FillEvents(const Ctrl: TControl; ScriptType: TScriptType);
begin
  FScriptType := ScriptType;
  IterateProps(Ctrl, [tkMethod], PropCallBack, false, 0);
end;

function TEventManager.getParams(Event: THTMLEventKind): string;
var
  i: THTMLParamType;
  Params: THTMLParamTypes;
begin
  Params := cMappedParams[Event];
  Result := '';
  if Params = [] then
    exit;
  for i := ptSender to ptY do
    if i in Params then
      Result := Result + SEventText + SParamNames[i] + ', '; //don't resource
  if Result <> '' then
    DelLast(Result, 2);
  Result := SLeftDelim[FScriptType] + Result + SRightDelim[FScriptType];
end;

procedure TEventManager.PropCallBack(Instance: TPersistent;
  PropInfo: PPropInfo; UserData: Integer);
var
  MethodName: string;
  EventKind: THTMLEventKind;
begin
  with GetMethodProp(instance, PropInfo) do
    if Code <> nil then
    begin
      MethodName := TObject(Data).MethodName(Code);
      EventKind := GetEventKind(PropInfo.Name);
      if (EventKind <> ekUnknown) and (EventKind in FMemberEvent) and (MethodName <> '') then
        FEvents.Add(instance, Code, SHTMLEvents[EventKind], MethodName + getParams(EventKind));
    end;
end;

{ TRegistredClassList }

function TRegistredClassList.Add(VCLClass: TControlClass; HTMLClass: THTMLControlClass): integer;
var
  PTmpItem : PRegistredItem;
begin
  GetMem(PTmpItem, sizeof(TRegistredItem));
  PTmpItem^.VCLClass := VCLClass;
  PTmpItem^.HTMLClass := HTMLClass;
  Result := FItems.Add(PTmpItem);
end;

function  TRegistredClassList.Remove(VCLClass: TControlClass): integer;
var
  i: integer;
  PTmpItem : PRegistredItem;
begin
  with FItems do
  begin
    for i := 0 to Count -1 do
    begin
      PTmpItem := Items[i];
      if PTmpItem.VCLClass = VCLClass then
      begin
        FreeMem(PTmpItem);
        Delete(i);
        Result := i;
        exit;
      end;
    end;
  end;
  Result := -1;
end;

procedure TRegistredClassList.Clear;
begin
  while Count > 0 do
    Delete(0);
  FItems.Clear;
end;

constructor TRegistredClassList.Create;
begin
  inherited;
  FItems := TList.Create;
end;

procedure TRegistredClassList.Delete(Index: Integer);
begin
  FreeMem(FItems.Items[Index]);
  FItems.Delete (Index);
end;

destructor TRegistredClassList.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

function TRegistredClassList.GetCount: integer;
begin
  Result := FItems.Count;
end;

function TRegistredClassList.GetItems(Index: integer): TRegistredItem;
begin
  Result := TRegistredItem(FItems.Items[Index]^);
end;

{ TRegistrar }

constructor TRegistrar.Create;
begin
  inherited;
  FRegCtrls := TRegistredClassList.Create;
end;

destructor TRegistrar.Destroy;
begin
  UnRegisterAll;
  FRegCtrls.Free;
  inherited;
end;

function  TRegistrar._GetHTMLClass(VCLClass: TClass) :THTMLControlClass;
var
  i: integer;
  ClassRef: TClass;
begin
  ClassRef := VCLClass;
  while ClassRef <> nil do
  begin
    for i := 0 to FRegCtrls.Count - 1 do
      with FRegCtrls.Items[i] do
        if VCLClass = ClassRef then
        begin
          Result := HTMLClass;
          exit;
        end;
    ClassRef := ClassRef.ClassParent;
  end;
  Result := nil;
end;

function TRegistrar.GetRegistredHTMLClass(AControl : TControl): THTMLControlClass;
begin
  Result := _GetHTMLClass(AControl.ClassType);
end;

procedure TRegistrar.RegisterControlClass(VCLClass: TControlClass; HTMLClass: THTMLControlClass);
begin
  SafeRegisterClass(VCLClass);
  FRegCtrls.Add(VCLClass, HTMLClass);
end;

procedure TRegistrar.UnRegisterControlClass(VCLClass: TControlClass);
begin
  if (VCLClass <> nil) and (GetClass(VCLClass.ClassName) <> nil) then
    try
      Classes.UnRegisterClass(VCLClass);
      FRegCtrls.Remove(VCLClass);
    except
    end;
end;

procedure TRegistrar.UnRegisterAll;
var
  i: integer;
begin
  with FRegCtrls do
  begin
    for i := 0 to Count -1 do
      with Items[i]  do
        if GetClass(VCLClass.ClassName) <> nil then
          try
            Classes.UnRegisterClass(VCLClass);
          except
          end;
    Clear;
  end;
end;

{ TCoords }

function TCoords.Peek(Index: integer): Integer;
begin
  if Count <> 0 then
    Result := Integer(Items[Index])
  else
    Result := -1;
end;

{ TChildControlList }

function TChildControlList.Add(VCLControl: TControl;
  HTMLControl: THTMLControl): integer;
var
  PTmpItem: PChildItem;
begin
  GetMem(PTmpItem, Sizeof(TChildItem));
  PTmpItem^.VCLControl := VCLControl;
  PTmpItem^.HTMLControl := HTMLControl;
  Result := FItems.Add(PTmpItem);
end;

procedure TChildControlList.Clear;
begin
  while Count > 0 do
    Delete(0);
  FItems.Clear;
end;

procedure TChildControlList.Sort;
begin
  FItems.Sort(CmpCtrls);
end;

constructor TChildControlList.Create;
begin
  FItems := TList.Create;
end;

procedure TChildControlList.Delete(Index: Integer);
begin
  with FItems do
  begin
    FreeMem(Items[Index]);
    delete(Index);
  end;
end;

destructor TChildControlList.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

function TChildControlList.GetCount: integer;
begin
  Result := FItems.Count;
end;

function TChildControlList.GetItems(Index: integer): PChildItem;
begin
  Result := PChildItem(FItems.Items[Index]);
end;
{
function TChildControlList.Remove(VCLControl: TControl): integer;
var
  i: integer;
  PTmpItem : PChildItem;
begin
  with FItems do
  begin
    for i := 0 to Count -1 do
    begin
      PTmpItem := Items[i];
      if PTmpItem.VCLControl = VCLControl then
      begin
        FreeMem(PTmpItem);
        Delete(i);
        Result := i;
        exit;
      end;
    end;
  end;
  Result := -1;
end;
}
{TControlGrid}

constructor TControlGrid.Create;
begin
  FVertLines := TCoords.Create;
  FHorizLines := TCoords.Create;
  FChildCtrls := TChildControlList.Create;
end;

destructor TControlGrid.Destroy;
begin
  inherited;
  Clear;
  FChildCtrls.Free;
  FHorizLines.Free;
  FVertLines.Free;
end;

procedure TControlGrid.SetControl(Value: TControl);
var
  i : integer;
  Ctrl: TControl;
  HTMLCtrl: THTMLControl;
  HTMLClass: THTMLControlClass;
begin
  FControl := Value;
  if (FControl <> nil) and (FControl is TWinControl) then
    with TWinControl(FControl) do
    begin
      Clear;
      FHorizLines.Push(0);
      FVertLines.Push(0);
      for i := 0 to ControlCount - 1 do
      begin
        Ctrl := Controls[i];
        HTMLClass := GetGlobalRegistry.GetRegistredHTMLClass(Ctrl);
        if HTMLClass <> nil then
        begin
          HTMLCtrl := HTMLClass.Create(FNextHTMLLevel);
          HTMLCtrl.Control := Ctrl;
          FChildCtrls.Add(Ctrl, HTMLCtrl);
          with TControl(Ctrl).BoundsRect do
          begin
            with FVertLines do
            begin
              Push(Left);
              Push(Right);
            end;
            with FHorizLines do
            begin
              Push(Top);
              Push(Bottom);
            end;
          end;
        end;
      end;
      FVertLines.Push(ClientWidth);
      FHorizLines.Push(ClientHeight);
      FChildCtrls.Sort;
      PackLines;
      IntersectCtrls;
    end;
end;

procedure TControlGrid.Clear;
begin
  FChildCtrls.Clear;
  FVertLines.Clear;
  FHorizLines.Clear;
end;

procedure TControlGrid.PackLines;
{-------------------------}
  procedure DeleteDublicate(ALines: TCoords);
  var
    i: integer;
  begin
    i := 1;
    with ALines do
      while i <= Count - 1 do
        if Peek (i-1) = Peek (i) then
          Delete (i)
        else
          inc (i);
  end;
{-------------------------}
begin
  SortLines;
  DeleteDublicate(FVertLines);
  DeleteDublicate(FHorizLines);
end;

procedure TControlGrid.SortLines;
begin
  FVertLines.Sort(CmpCoords);
  FHorizLines.Sort(CmpCoords);
end;

function  TControlGrid._FindChildControl(Column, Row: integer; Exact: boolean): PChildItem;
var
  i, L, T: integer;
begin
  L := FVertLines.Peek(Column);
  T := FHorizLines.Peek(Row);
  with FChildCtrls do
    for i := 0 to Count - 1 do
    begin
      Result := Items[i];
      with Result.VCLControl do
      if (Left = L) then
        if Exact then
        begin
          if Top = T then
            exit;
        end
        else
          if (Top < T) and (Top + Height > T) then
            exit;
    end;
  Result := nil;
end;

procedure TControlGrid._getControlSpans(Column, Row: integer; Control: TControl; var ColSpan, RowSpan: integer);
begin
  with Control do
  begin
    with FVertLines do
      while Width > (Peek(Column + ColSpan) - Peek(Column)) do
        inc(ColSpan);
    with FHorizLines do
      while Height > (Peek(Row + RowSpan) - Peek(Row)) do
        inc(RowSpan);
  end;
end;

procedure TControlGrid.IntersectCtrls;
var
  i, j: integer;
  _R: TRect;
  Ctrl1, Ctrl2: TControl;
begin
  with FChildCtrls do
  for i := 0 to Count -2 do
    for j := i + 1 to Count -1 do
    begin
      Ctrl1 := Items[i].VCLControl;
      Ctrl2 := Items[j].VCLControl;
      if InterSectRect(_R, Ctrl1.BoundsRect, Ctrl2.BoundsRect) then
        raise Exception.Create(Ctrl1.Name + SBeginErrStr + Ctrl2.Name + SCRLFText + SEndErrStr);
    end;
end;

{$IFDEF USE_FUNC_EX}
function  TControlGrid.FindVCLControl(Column, Row: integer): TControl;
var
  PItem: PChildItem;
begin
  PItem := _FindChildControl(Column, Row, true);
  if PItem <> nil then
    Result := PItem^.VCLControl
  else
    Result := nil;
end;
{$ENDIF}

function  TControlGrid.FindHTMLControl(Column, Row: integer): THTMLControl;
var
  PItem: PChildItem;
begin
  PItem := _FindChildControl(Column, Row, true);
  if PItem <> nil then
    Result := PItem^.HTMLControl
  else
    Result := nil;
end;

function  TControlGrid.GetHTMLCtrlSpans(Column, Row: integer; var ColSpan, RowSpan: integer): THTMLControl;
begin
  ColSpan := 1;
  RowSpan := 1;
  Result := FindHTMLControl(Column, Row);
  if Result <> nil then
    _getControlSpans(Column, Row, Result.Control, ColSpan, RowSpan);
end;

function  TControlGrid.GetNextColumn(Column, Row: integer): integer;
var
  PItem: PChildItem;
begin
  Result := Column + 1;
  PItem := _FindChildControl(Result, Row, false);
  if PItem <> nil then
  begin
    with PItem^.VCLControl, FVertLines do
      while Width >= (Peek(Result + 1) - Peek(Column+1)) do
        inc(Result);
  end;
end;

function TControlGrid.HasChildren: boolean;
begin
  Result := FChildCtrls.Count >0;
end;

{ THTMLControl }

constructor THTMLControl.Create(Level: integer);
begin
  FHTMLLevel := Level; //for HTML tags
  FNextHTMLLevel := FHTMLLevel +1;
  FAlignment := taLeftJustify;
  FVAlignment := tvaMiddleJustify;
  FEventsMan := TEventManager.Create([]);
end;

destructor THTMLControl.Destroy;
begin
  FEventsMan.Free;
  inherited;
end;

procedure THTMLControl.SetControl(Value: TControl);
begin
  FControl := Value;
  DoSetControl;
end;

procedure THTMLControl.WriteToStream(Stream: TStream);
begin
  WriteStrToStream(Stream, GetTag);
end;

procedure THTMLControl.DoSetControl;
begin
end;

function THTMLControl.GetEvents: string;
var
  i: integer;
begin
  Result := '';
  if (FControl <> nil) and (UseScriptType <> sctUnknown) and UseControlEvents  then
  begin
    with FEventsMan, Events do
    begin
        FillEvents(FControl, UseScriptType);
        for i:= 0 to Count - 1 do
          with Items[i] do
            Result := Result + Name + SEqual + GetQuotedStr(MethodName) + SSpaceText;
    end;        
    if Result <> '' then
      DelLast(Result, 1);
  end;
end;

function THTMLControl.GetTag: string;
begin
  Result := ''
end;

{ THTMLTableBasedCtrl }

function THTMLTableBasedCtrl._getTDEx(HTMLCtrl: THTMLControl; Column, Row, ColSpan, RowSpan: integer; Body: string; Level: integer): string;
var
  W, H: integer;
  _UseColor: boolean;
  _Color: TColor;
  _Align: TAlignment;
  _Valign: TVAlignment;
begin
  with FGrid do
  begin
    with HorizLines do
      H := Peek(Row +1) - Abs(Peek(Row));
    with VertLines do
      W := Peek(Column +1) - Abs(Peek(Column));
  end;
  if (H <= 0) or (W <= 0) then
  begin
    H := 0;
    W := 0;
  end;
  if HTMLCtrl = nil then
  begin
    _UseColor := false;
    _Color := 0;
    _Align := Alignment;
    _Valign := VAlignment;
  end
  else
    with HTMLCtrl do
    begin
      _UseColor := UseColor;
      _Color := TMControl(Control).Color;
      _Align := Alignment;
      _Valign := VAlignment;
    end;
  Result := getTD(W , H, ColSpan, RowSpan, _Align, _Valign, _UseColor, _Color, Body, Level);
end;

function THTMLTableBasedCtrl._getBody: string;
var
  W: integer;
begin
  if FBorderWidth > 0 then
    W := (FBorderWidth + 1)*2
  else
    W := 0;
  with TMControl(FControl) do
  begin
    Result := _GetTable(ClientWidth -W, 0, _getTableBody, false, FHTMLLevel +3);
    Result := GetTD(ClientWidth -W, ClientHeight -W, 1 , 1, taLeftJustify, tvaMiddleJustify, true, Color, Result, FHTMLLevel +2);
  end;
  Result := GetTR(Result, FHTMLLevel +1);
end;

function  THTMLTableBasedCtrl.GetTag: string;
begin
  with TMControl(FControl) do
    Result := _GetTable(Width, FBorderWidth, _getBody, true, FHTMLLevel);
end;

constructor THTMLTableBasedCtrl.Create(Level: integer);
begin
  inherited;
  FGrid := TControlGrid.Create;
  FNextHTMLLevel := FHTMLLevel +6;
end;

destructor THTMLTableBasedCtrl.Destroy;
begin
  FGrid.Clear;
  FGrid.Free;
  inherited;
end;

procedure THTMLTableBasedCtrl.DoSetControl;
var
  _d: integer;
begin
  inherited;
  if Control <> nil then
  begin
    with FGrid do
    begin
      NextHTMLLevel := self.FNextHTMLLevel;
      Control := self.Control;
      if FBorderWidth > 0 then
      begin
        _d := FBorderWidth + 1;
        Inflate(VertLines, _d);
        Inflate(HorizLines, _d);
      end;
    end;
  end;
end;

procedure THTMLTableBasedCtrl.Inflate(Coord: TCoords; Delta: integer);
begin
  with Coord do
  begin
    Items[0] := Pointer(Peek(0) - Delta);
    Items[Count -1] := Pointer(Peek(Count -1) - Delta);
  end;
end;

function THTMLTableBasedCtrl._getTable(Width, BorderWidth: integer; BodyFunc: TBodyFunction; UseEvents: boolean; Level: integer): string;
begin
  if Assigned(BodyFunc) then
  begin
    if UseEvents then
      Result := GetEvents
    else
      Result := '';
    Result := GetTable(Width, BorderWidth, Result, BodyFunc, Level);
  end
  else
    Result := '';
end;

function THTMLTableBasedCtrl._getTableBody: string;
var
  Col, Row, ColSpan, RowSpan, _D : integer;
  HTMLCtrl: THTMLControl;
  TDStr, TDBodyStr: string;
begin
  Result := '';
  inc(FHTMLLevel, 4);
  with FGrid do
  for Row := 0 to HorizLines.Count - 2 do
  begin
    Col := 0;
    TDStr := '';
    while Col <= VertLines.Count - 2 do
    begin
      HTMLCtrl := GetHTMLCtrlSpans(Col, Row, ColSpan, RowSpan);
      if HTMLCtrl <> nil then
      begin
        TDBodyStr := HTMLCtrl.GetTag;
        _D := ColSpan;
      end
      else
      begin
        _D := GetNextColumn(Col, Row) - Col;
        TDBodyStr := '';
      end;
      TDStr := TDStr + _getTDEx(HTMLCtrl, Col, Row, ColSpan, RowSpan, TDBodyStr, FHTMLLevel+1) + SCRLFText;
      inc (Col, _D);
    end;
    DelLast(TDStr, 2);
    Result := Result + GetTR(TDStr, FHTMLLevel) + SCRLFText;
  end;
  DelLast(Result, 2);
  dec(FHTMLLevel, 4);
end;

{ THTMLCustomCtrl }

function THTMLCustomCtrl.GetTabIndex: string;
begin
  Result := '';
  if FControl is TWinControl then
    with TWinControl(FControl) do
      if TabStop then
        Result := STabIndexText + GetQuotedInt(TabOrder +1); // for non zero based
end;

function THTMLCustomCtrl.GetDisabled: string;
begin
  if not FControl.Enabled then
    Result := SDisabledText
  else
    Result := '';
end;

function THTMLCustomCtrl.GetAttributes: string;
  procedure _Add2Res(const Str: string);
  begin
    if Str <> '' then
      Result := Result + Str + SSpaceText;
  end;
begin
  Result := '';
  _Add2Res(GetDisabled);
  _Add2Res(GetTabIndex);
  _Add2Res(GetEvents);
  if Result <> '' then
    DelLast(Result, 1);
end;

constructor THTMLCustomCtrl.Create(Level: integer);
begin
  inherited;
  VAlignment := tvaTopJustify;
end;

{ THTMLInputCtrl }

function THTMLInputCtrl.GetAttributes: string;
begin
  with TMControl(Control) do
    Result := STypeText + SInputCtrlTypes[FType] + SSpaceText + SNameText + GetQuotedStr(Name) + SSpaceText +
              SValueText + GetQuotedStr(Text) + SSpaceText + inherited GetAttributes;
end;

function THTMLInputCtrl.GetTag: string;
begin
  with TMControl(Control) do
    Result := GetHTMLTagEx(SInputText, GetAttributes, '', false, false, FHTMLLevel);
end;

{ THTMLSelectCtrl }

function THTMLSelectCtrl.GetTag: string;
begin
  Result := GetHTMLTagEx(SSelectText, GetAttributes, GetOptions, true, true, FHTMLLevel);
end;

function THTMLSelectCtrl.GetOptions: string;
begin
  Result := '';
end;

function THTMLSelectCtrl._getOptStr(Value: integer; const Text: string;
  Selected: boolean): string;
begin
  if Selected then
    Result := SSelectedText + SSpaceText
  else
    Result := '';
  Result := GetHTMLTagEx(SOptionText, Result + SValueText + GetQuotedInt(Value), Text, true, false, FHTMLLevel+1) + SCRLFText;
end;

function THTMLSelectCtrl.GetAttributes: string;
begin
  Result := SNameText + GetQuotedStr(Control.Name) + SSpaceText + inherited GetAttributes;
end;

{ THTMLButton }

constructor THTMLButton.Create(Level: integer);
begin
  inherited;
  FEventsMan.MemberEvents := [ekOnClick,
                   ekOnMouseDown, ekOnMouseUp, ekOnMouseMove,
                   ekOnFocus, ekOnBlur, ekOnKeypress, ekOnKeyDown, ekOnKeyUp];
  FType := ictButton;
end;

{ THTMLCheckBox }

constructor THTMLCheckBox.Create(Level: integer);
begin
  inherited;
  FEventsMan.MemberEvents := [ekOnClick,
                   ekOnMouseDown, ekOnMouseUp, ekOnMouseMove,
                   ekOnFocus, ekOnBlur, ekOnKeypress, ekOnKeyDown, ekOnKeyUp];
  FType := ictCheckbox;
  UseColor := true;
  VAlignment := tvaMiddleJustify;
end;

function THTMLCheckBox.GetTag: string;
begin
  with TCheckBox(Control) do
    Result := inherited GetTag + GetText(Font, Caption);
end;

function THTMLCheckBox.GetAttributes: string;
begin
  if TCheckBox(Control).Checked then
    Result := SCheckedText
  else
    Result :='';
  Result := Result + SSpaceText + inherited GetAttributes;
end;

{ THTMLComboBox }

constructor THTMLComboBox.Create(Level: integer);
begin
  inherited;
  FEventsMan.MemberEvents := [ekOnClick, ekOnDblClick,
                   ekOnMouseDown, ekOnMouseUp, ekOnMouseMove,
                   ekOnFocus, ekOnBlur, ekOnKeypress, ekOnKeyDown, ekOnKeyUp, ekOnChange];
end;

function THTMLComboBox.GetOptions: string;
var
  i: integer;
begin
  with TComboBox(Control) do
  begin
    if Items.Count > 0 then
    begin
      Result := _getOptStr(0, Items[0], true);
      for i := 1 to Items.Count - 1 do
        Result := Result + _getOptStr(i, Items[i], false);
    end
    else
      Result := _getOptStr(0, Text, true);
  end;
  if Result <> '' then
    DelLast(Result, 2);
end;

{ THTMLEdit }

constructor THTMLEdit.Create(Level: integer);
begin
  inherited;
  FEventsMan.MemberEvents := [ekOnClick, ekOnDblClick,
                   ekOnMouseDown, ekOnMouseUp, ekOnMouseMove,
                   ekOnFocus, ekOnBlur, ekOnKeypress, ekOnKeyDown, ekOnKeyUp, ekOnChange];
end;

procedure THTMLEdit.DoSetControl;
begin
  inherited;
  if TEdit(Control).PasswordChar = #0 then
    FType := ictText
  else
    FType := ictPassword;
end;

function THTMLEdit.GetAttributes: string;
begin
  with TEdit(Control) do
  begin
    Result := SSizeText + GetQuotedInt(Trunc(Width/9.3));
    if ReadOnly then
      Result := Result + SSpaceText + SReadOnlyText;
    if MaxLength > 0 then
      Result := Result + SSpaceText + SMaxLengthText + GetQuotedInt(MaxLength);
  end;
  Result := Result + SSpaceText + inherited GetAttributes;
end;

{ THTMLGroupBox }

constructor THTMLGroupBox.Create(Level: integer);
begin
  inherited;
  FEventsMan.MemberEvents := [ekOnClick, ekOnDblClick, ekOnMouseDown, ekOnMouseUp,
                   ekOnMouseMove, ekOnFocus, ekOnBlur];
  FBorderWidth := 2;
end;

procedure THTMLGroupBox.DoSetControl;
begin
  inherited;
  Inflate(Grid.HorizLines, 6);
end;

function THTMLGroupBox.GetTag: string;
begin
  with TMControl(FControl) do
    Result := _GetTable(Width, 0, _getGroupBody, true, FHTMLLevel);
end;

function THTMLGroupBox._getGroupBody: string;
begin
  with TGroupBox(Control) do
  begin
    Result := _GetTable(ClientWidth -4, 0, _getTableBody, false, FHTMLLevel +3);
    Result := GetFieldSet(Caption, Result, Font, FHTMLLevel +2);
    Result := GetTD(Width, Height, 1 , 1, taLeftJustify, tvaMiddleJustify, true, Color, Result, FHTMLLevel +2);
  end;
  Result := GetTR(Result, FHTMLLevel +1)
end;

{ THTMLLabel }

constructor THTMLLabel.Create(Level: integer);
begin
  inherited;
  FEventsMan.MemberEvents := [ekOnClick, ekOnDblClick, ekOnMouseDown, ekOnMouseUp, ekOnMouseMove];
  UseColor := true;
end;

procedure THTMLLabel.DoSetControl;
begin
  inherited;
  Alignment := TLabel(Control).Alignment;
end;

function THTMLLabel.GetTag: string;
begin
  with TLabel(Control) do
    Result := GetTextEx(Font, Caption, FHTMLLevel);
//    Result := GetHTMLTagEx(SPreText, '', GetText(Font, Caption), true, false, FHTMLLevel);
end;

{ THTMLListBox }

constructor THTMLListBox.Create(Level: integer);
begin
  inherited;
  FEventsMan.MemberEvents := [ekOnClick, ekOnDblClick, ekOnMouseDown, ekOnMouseUp,
                   ekOnMouseMove, ekOnFocus, ekOnBlur, ekOnKeypress,
                   ekOnKeyDown, ekOnKeyUp];
end;

function THTMLListBox.GetAttributes: string;
begin
  with TListBox(Control) do
  begin
    Result := SSizeText + GetQuotedInt(Items.Count);
    if MultiSelect then
      Result := Result + SSpaceText + SMultipleText;
  end;
  Result := Result + SSpaceText + inherited GetAttributes;
end;

function THTMLListBox.GetOptions: string;
var
  i: integer;
begin
  Result := '';
  with TListBox(Control) do
    for i := 0 to Items.Count - 1 do
      Result := Result + _getOptStr(i, Items[i], false);
  if Result <> '' then
    DelLast(Result, 2);
end;

{ THTMLMemo }

constructor THTMLMemo.Create(Level: integer);
begin
  inherited;
  FEventsMan.MemberEvents := [ekOnClick, ekOnDblClick, ekOnMouseDown, ekOnMouseUp,
                   ekOnMouseMove, ekOnFocus, ekOnBlur, ekOnKeypress,
                   ekOnKeyDown, ekOnKeyUp, ekOnChange];
end;

function THTMLMemo.GetAttributes: string;
var
  Cols, Rows: integer;
begin
  with TMemo(Control) do
  begin
    Cols := Trunc(Width/9.3);
    Rows := Trunc(Height/16.4) -1;
    Result := SNameText + GetQuotedStr(Name) + SSpaceText +
              SColsText + GetQuotedInt(Cols) + SSpaceText +
              SRowsText + GetQuotedInt(Rows);
    if ReadOnly then
      Result := Result + SSpaceText + SReadOnlyText;
  end;
  Result := Result + SSpaceText + inherited GetAttributes;
end;

function THTMLMemo.GetTag: string;
begin
  with TMemo(Control).Lines do
    Result := Text;
  Result := GetHTMLTagEx(STextAreaText, GetAttributes, Result, true, false, FHTMLLevel);
end;

{ THTMLPanel }

constructor THTMLPanel.Create(Level: integer);
begin
  inherited;
  FEventsMan.MemberEvents := [ekOnClick, ekOnDblClick, ekOnMouseDown, ekOnMouseUp,
                   ekOnMouseMove, ekOnFocus, ekOnBlur];
  FBorderWidth := 1;
  VAlignment := tvaMiddleJustify;
end;

procedure THTMLPanel.DoSetControl;
begin
  with TPanel(Control) do
    FWithOutBorder := (BevelInner = bvNone) and (BevelOuter = bvNone);
  if FWithOutBorder then
  begin
    FBorderWidth := 0;
    Alignment := TPanel(Control).Alignment;
    UseColor := true;
  end;
  inherited;
end;

function THTMLPanel.GetTag: string;
begin
  if Grid.HasChildren then
    Result := inherited GetTag
  else
    with TPanel(Control) do
    begin
      Result := GetTextEx(Font, Caption, FHTMLLevel +3);
      if not FWithOutBorder then
      begin
        Result := GetTD(Width -4, Height -2, 1, 1, Alignment, VAlignment, true, Color, Result, FHTMLLevel+2);
        Result := GetTR(Result, FHTMLLevel +1);
        Result := GetTable(Width, 1, GetEvents, Result, FHTMLLevel);
      end;
    end;
end;

{ THTMLRadioButton }

constructor THTMLRadioButton.Create(Level: integer);
begin
  inherited;
  FEventsMan.MemberEvents := [ekOnClick, ekOnDblClick, ekOnMouseDown, ekOnMouseUp,
                   ekOnMouseMove, ekOnFocus, ekOnBlur, ekOnKeypress,
                   ekOnKeyDown, ekOnKeyUp];
  FType := ictRadio;
  UseColor := true;
  VAlignment := tvaMiddleJustify;
end;

function THTMLRadioButton.GetTag: string;
begin
  with TRadioButton(Control) do
    Result := inherited GetTag + GetText(Font, Caption);
end;

{ THTMLRadioGroup }

constructor THTMLRadioGroup.Create(Level: integer);
begin
  inherited;
  FEventsMan.MemberEvents := [ekOnClick, ekOnFocus, ekOnBlur];
end;

procedure THTMLRadioGroup.DoSetControl;
begin
  inherited;
  if Grid.HasChildren then
    Inflate(Grid.HorizLines, 6);
end;

{ THTMLForm }

constructor THTMLForm.Create(Level: integer);
begin
  inherited;
  FEventsMan.MemberEvents := [ekOnLoad, ekOnUnload, ekOnClick, ekOnDblClick, ekOnMouseDown, ekOnMouseUp,
                   ekOnMouseMove, ekOnKeypress, ekOnKeyDown, ekOnKeyUp];
end;

function THTMLForm._getFormBody: string;
var
  CaptionStr: string;
  AddHeight: integer;
begin
  with TForm(Control) do
  begin
    if BorderStyle <> bsNone then
    begin
      AddHeight := 1;
      CaptionStr := GetFontedTextEx(Font.Name, 1, clCaptionText, getHTMLTagEx('B', '', Caption, true, false, 0), FHTMLLevel +3); //don't resource
      CaptionStr := GetTD(ClientWidth, GetSystemMetrics(SM_CYSIZE) +1, 1 , 1, taLeftJustify, tvaMiddleJustify, true, clActiveCaption, CaptionStr, FHTMLLevel +2);
      CaptionStr := GetTR(CaptionStr, FHTMLLevel +1) + SCRLFText;
    end
    else
    begin
      CaptionStr := '';
      AddHeight := 0;
    end;
    Result := _GetTable(ClientWidth , 0, _getTableBody, true, FHTMLLevel +3);
    Result := GetTD(ClientWidth, ClientHeight + AddHeight, 1 , 1, taLeftJustify, tvaMiddleJustify, true, Color, Result, FHTMLLevel +2);
  end;
  Result :=  CaptionStr + GetTR(Result, FHTMLLevel +1);
end;

function THTMLForm._getScript(const SourceFile: string; ScriptType: TScriptType): string;
begin
  if UseControlEvents then
    Result := GetScript(SourceFile, ScriptType) + SCRLFText
  else
    Result := '';
end;

function THTMLForm.GetTag: string;
var
  WBorder: integer;
begin
  with TForm(Control) do
  begin
    case BorderStyle of
      bsNone: WBorder := 0;
      bsSizeable: WBorder := 3;
    else
      WBorder := 2;
    end;
    Result := _GetTable(Width, WBorder, _getFormBody, false, FHTMLLevel);
  end;
  Result := _getScript(FScriptFile, FScriptType) +
            getHTMLTagEx(SFormText, '', Result, true, true, FHTMLLevel);
  Result := getHTMLTagEx(SHtmlText, '', Result, true, true, FHTMLLevel);
end;

{--------------------------------------------------}

procedure Form2Html(Form: TCustomForm; AScriptFile: TFileName; AScriptType: TScriptType; OutStream: TStream);
begin
  UseScriptType := AScriptType;
  UseControlEvents := (AScriptFile <> '') and (AScriptType <> sctUnknown);
  HtmlForm := THtmlForm.Create(0);
  try
    with HtmlForm do
    begin
      if UseControlEvents then
      begin
        ScriptFile := AScriptFile;
        ScriptType := AScriptType;
      end;
      Control := Form;
      WriteToStream(OutStream);
      {$IFDEF DEBUG_DFM2HTML}
      DrawGrid(Form.Canvas);
      {$ENDIF}
    end;
  finally
    HtmlForm.Free;
  end;
end;

function  Form2HtmlStr(Form: TCustomForm; AScriptFile: TFileName; AScriptType: TScriptType): string;
var
  S: TMemoryStream;
  Buff: PChar;
begin
  S := TMemoryStream.Create;
  try
    Form2Html(Form, AScriptFile, AScriptType, S);
    with S do
    begin
      GetMem(Buff, Size + 1);
      Position := 0;
      Read(Buff^, Size);
      (Buff + Size)^ := #0;
      Result := string(Buff);
      FreeMem(Buff);
    end;
  finally
    S.Free;
  end;
end;

{$IFDEF DEBUG_DFM2HTML}
procedure DrawGrid(OutCanvas: TCanvas);
var
  i: integer;
begin
  with OutCanvas, HtmlForm.Grid do
  begin
    with VertLines do
      for i := 0 to Count -1 do
      begin
        MoveTo(Peek(i),  0);
        LineTo(Peek(i), Control.Height);
      end;
    with HorizLines do
      for i := 0 to Count -1 do
      begin
        MoveTo(0, Peek(i));
        LineTo(Control.Width, Peek(i));
      end;
  end;
end;
{$ENDIF}

procedure RegisterControlClass(VCLClass: TControlClass; HTMLClass: THTMLControlClass);
begin
  GetGlobalRegistry.RegisterControlClass(VCLClass, HTMLClass);
end;

procedure UnRegisterControlClass(VCLClass: TControlClass);
begin
  GetGlobalRegistry.UnRegisterControlClass(VCLClass);
end;

initialization

  UseScriptType := sctUnknown;
  with GetGlobalRegistry do
  begin
    RegisterControlClass(TButton, THTMLButton);
    RegisterControlClass(TCheckBox, THTMLCheckBox);
    RegisterControlClass(TComboBox, THTMLComboBox);
    RegisterControlClass(TEdit, THTMLEdit);
    RegisterControlClass(TGroupBox, THTMLGroupBox);
    RegisterControlClass(TLabel, THTMLLabel);
    RegisterControlClass(TListBox, THTMLListBox);
    RegisterControlClass(TMemo, THTMLMemo);
    RegisterControlClass(TPanel, THTMLPanel);
    RegisterControlClass(TRadioButton, THTMLRadioButton);
    RegisterControlClass(TRadioGroup, THTMLRadioGroup);
    RegisterControlClass(TForm, THTMLForm);
  end;

finalization

  ClearRegistry;

end.


