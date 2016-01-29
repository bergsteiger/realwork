{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcColorsOpt;

interface
{$I dc.inc}
uses
  dcdreamLib, dcMemo, Messages, Forms, StdCtrls, PropCB, Controls, DCColorCombo,
  Classes, Dialogs, Buttons;

type
  TColorsOptForm = class(TForm)
    ElementLbl: TLabel;
    BackColorLbl: TLabel;
    ForeColorLbl: TLabel;
    BackColor: TDCColorCombo;
    ForeColor: TDCColorCombo;
    OpenButton: TButton;
    SaveButton: TButton;
    GroupBox1: TGroupBox;
    chkDefBack: TDCPropCheck;
    chkDefFore: TDCPropCheck;
    Elements: TListBox;
    GroupBox2: TGroupBox;
    BoldChk: TDCPropCheck;
    ItalicChk: TDCPropCheck;
    UnderLineChk: TDCPropCheck;
    CSSLbl: TLabel;
    ComboBox1: TComboBox;
    ColorDialog1: TColorDialog;
    ForeColorBtn: TBitBtn;
    BackColorBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure ElementsClick(Sender: TObject);
    procedure ForeColorChange(Sender: TObject);
    procedure BackColorChange(Sender: TObject);
    procedure OpenButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ForeColorBtnClick(Sender: TObject);
    procedure BackColorBtnClick(Sender: TObject);
  private
    procedure AddTS(const Str: string);
    procedure FillElements;
    function CurrentStyle: TTextStyle;
    procedure CMApplyOptions(var Msg: TMessage); message CM_APPLYOPTIONS;
    procedure UpdateMemoOptionsColor;
  end;

var
  ColorsOptForm: TColorsOptForm;

type
  TTextStylesInitProc = procedure(Instance: TObject);

procedure RegisterTextStylesInitProc(C: TClass; const ProcName: string;
  Proc: TTextStylesInitProc);
function GetTextStylesInitProc(C: TClass; const ProcName: string): TTextStylesInitProc;

//in the following functions Instance should be of TTextStyles class
procedure InitDefaultsTextStyles(Instance: TObject);
procedure InitClassicTextStyles(Instance: TObject);
procedure InitOceanTextStyles(Instance: TObject);
procedure InitTwilightTextStyles(Instance: TObject);

implementation

uses dcMemOpt, dcSystem, dcCommon, dcConsts, Graphics, SysUtils, dcDisplayOpt;

{$R *.DFM}

{------------------------------------------------------------------}

procedure RegisterTextStylesInitProc(C: TClass; const ProcName: string;
  Proc: TTextStylesInitProc);
begin
  RegisterClassExt(C,
    [SParTextStylesID, SParTextStylesInitName, SParTextStylesInitProc],
    [SParTextStylesID, ProcName,               Integer(@Proc)]);
end;

function GetTextStylesInitProc(C: TClass; const ProcName: string): TTextStylesInitProc;
var
  Item: TObjectParamListItem;
begin
  Item := GetItemInherited(C, [SParTextStylesID, SParTextStylesInitName],
    [SParTextStylesID, ProcName], [cpIgnoreCase]);
  if Item = nil then
    Result := nil
  else
    Result := Pointer(Integer(Item.Params[SParTextStylesInitProc]));
end;

{------------------------------------------------------------------}

const
  GlobalTextStylesCount = 25;

type
  TTextStyleRecord = record
    _StyleName: string;
    _Color, _BackColor: TColor;
    _Style: TFontStyles;
    _UpdateType: TUpdateMemoColors;
    _UseMemoColor: Boolean;
  end;

  TTextStylesConstArray = array[1..GlobalTextStylesCount] of TTextStyleRecord;

const

  DefaultsTextStyles: TTextStylesConstArray = (
    (_StyleName: STxtStWhiteSp;          _Color: clBlack;  _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStStr;              _Color: clMaroon; _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStComment;          _Color: clGray;   _BackColor: clWindow; _Style: [fsItalic];    _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStIdent;            _Color: clBlack;  _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStInteger;          _Color: clGreen;  _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStFloat;            _Color: clGreen;  _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStResWords;         _Color: clBlue;   _BackColor: clWindow; _Style: [fsBold];      _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStDelims;           _Color: clBlack;  _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStDefines;          _Color: clGreen;  _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStAsm;              _Color: clGreen;  _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),

    (_StyleName: STxtStHtmlTag;          _Color: clBlue;   _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStHtmlParams;       _Color: clBlue;   _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStUrl;              _Color: clBlue;   _BackColor: clWindow; _Style: [fsUnderLine]; _UpdateType: mcNone;        _UseMemoColor: True),

    (_StyleName: STxtStBreakPnt;         _Color: clWindow; _BackColor: clRed;    _Style: [];            _UpdateType: mcNone;        _UseMemoColor: False),
    (_StyleName: STxtStErrorLn;          _Color: clWindow; _BackColor: clMaroon; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: False),
    (_StyleName: STxtStMarkedBlock;      _Color: clWindow; _BackColor: clNavy;   _Style: [];            _UpdateType: mcSelection;   _UseMemoColor: False),
    (_StyleName: STxtStSearchMatch;      _Color: clLime;   _BackColor: clBlack;  _Style: [];            _UpdateType: mcSearchMatch; _UseMemoColor: False),

    (_StyleName: STxtStEmphasis;         _Color: clBlack;  _BackColor: clWindow; _Style: [fsBold];      _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStSystemVariable;   _Color: clBlue;   _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptWhiteSp;    _Color: clTeal;   _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptDelimiters; _Color: clBlack;  _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptComment;    _Color: clGray;   _BackColor: clWindow; _Style: [fsItalic];    _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptString;     _Color: clMaroon; _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptNumber;     _Color: clBlue;   _BackColor: clWindow; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptResWord;    _Color: clBlack;  _BackColor: clWindow; _Style: [fsBold];      _UpdateType: mcNone;        _UseMemoColor: True)
  );

  ClassicTextStyles: TTextStylesConstArray = (
    (_StyleName: STxtStWhiteSp;          _Color: clYellow;  _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStStr;              _Color: clYellow;  _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStComment;          _Color: clSilver;  _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStIdent;            _Color: clYellow;  _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStInteger;          _Color: clYellow;  _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStFloat;            _Color: clYellow;  _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStResWords;         _Color: clWhite;   _BackColor: clNavy;   _Style: [fsBold];      _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStDelims;           _Color: clYellow;  _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStDefines;          _Color: clLime;    _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStAsm;              _Color: clLime;    _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),

    (_StyleName: STxtStHtmlTag;          _Color: clAqua;    _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStHtmlParams;       _Color: clAqua;    _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStUrl;              _Color: clAqua;    _BackColor: clNavy;   _Style: [fsUnderLine]; _UpdateType: mcNone;        _UseMemoColor: True),

    (_StyleName: STxtStBreakPnt;         _Color: clWindow;  _BackColor: clRed;    _Style: [];            _UpdateType: mcNone;        _UseMemoColor: False),
    (_StyleName: STxtStErrorLn;          _Color: clWindow;  _BackColor: clMaroon; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: False),
    (_StyleName: STxtStMarkedBlock;      _Color: clNavy;    _BackColor: clSilver; _Style: [];            _UpdateType: mcSelection;   _UseMemoColor: False),
    (_StyleName: STxtStSearchMatch;      _Color: clAqua;    _BackColor: clBlack;  _Style: [];            _UpdateType: mcSearchMatch; _UseMemoColor: False),

    (_StyleName: STxtStEmphasis;         _Color: clYellow;  _BackColor: clNavy;   _Style: [fsBold];      _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStSystemVariable;   _Color: clWhite;   _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptWhiteSp;    _Color: clLime;    _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptDelimiters; _Color: clWhite;   _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptComment;    _Color: clSilver;  _BackColor: clNavy;   _Style: [fsItalic];    _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptString;     _Color: clAqua;    _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptNumber;     _Color: clFuchsia; _BackColor: clNavy;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptResWord;    _Color: clYellow;  _BackColor: clNavy;   _Style: [fsBold];      _UpdateType: mcNone;        _UseMemoColor: True)
  );

  OceanTextStyles: TTextStylesConstArray = (
    (_StyleName: STxtStWhiteSp;          _Color: clBlack;  _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStStr;              _Color: clPurple; _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStComment;          _Color: clTeal;   _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStIdent;            _Color: clBlue;   _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStInteger;          _Color: clOlive;  _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStFloat;            _Color: clOlive;  _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStResWords;         _Color: clBlack;  _BackColor: clAqua;   _Style: [fsBold];      _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStDelims;           _Color: clBlack;  _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStDefines;          _Color: clTeal;   _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStAsm;              _Color: clBlue;   _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),

    (_StyleName: STxtStHtmlTag;          _Color: clBlue;   _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStHtmlParams;       _Color: clBlue;   _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStUrl;              _Color: clBlue;   _BackColor: clAqua;   _Style: [fsUnderLine]; _UpdateType: mcNone;        _UseMemoColor: True),

    (_StyleName: STxtStBreakPnt;         _Color: clWindow; _BackColor: clRed;    _Style: [];            _UpdateType: mcNone;        _UseMemoColor: False),
    (_StyleName: STxtStErrorLn;          _Color: clWindow; _BackColor: clMaroon; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: False),
    (_StyleName: STxtStMarkedBlock;      _Color: clAqua;   _BackColor: clBlue;   _Style: [];            _UpdateType: mcSelection;   _UseMemoColor: False),
    (_StyleName: STxtStSearchMatch;      _Color: clAqua;   _BackColor: clGray;   _Style: [];            _UpdateType: mcSearchMatch; _UseMemoColor: False),

    (_StyleName: STxtStEmphasis;         _Color: clBlue;   _BackColor: clAqua;   _Style: [fsBold];      _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStSystemVariable;   _Color: clBlack;  _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptWhiteSp;    _Color: clBlack;  _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptDelimiters; _Color: clBlack;  _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptComment;    _Color: clGray;   _BackColor: clAqua;   _Style: [fsItalic];    _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptString;     _Color: clPurple; _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptNumber;     _Color: clOlive;  _BackColor: clAqua;   _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptResWord;    _Color: clBlue;   _BackColor: clAqua;   _Style: [fsBold];      _UpdateType: mcNone;        _UseMemoColor: True)
  );

  TwilightTextStyles: TTextStylesConstArray = (
    (_StyleName: STxtStWhiteSp;          _Color: clWindow;  _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStStr;              _Color: clYellow;  _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStComment;          _Color: clSilver;  _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStIdent;            _Color: clWindow;  _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStInteger;          _Color: clFuchsia; _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStFloat;            _Color: clFuchsia; _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStResWords;         _Color: clAqua;    _BackColor: clBlack;  _Style: [fsBold];      _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStDelims;           _Color: clWindow;  _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStDefines;          _Color: clSilver;  _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStAsm;              _Color: clLime;    _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),

    (_StyleName: STxtStHtmlTag;          _Color: clLime;    _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStHtmlParams;       _Color: clLime;    _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStUrl;              _Color: clLime;    _BackColor: clBlack;  _Style: [fsUnderLine]; _UpdateType: mcNone;        _UseMemoColor: True),

    (_StyleName: STxtStBreakPnt;         _Color: clWindow;  _BackColor: clRed;    _Style: [];            _UpdateType: mcNone;        _UseMemoColor: False),
    (_StyleName: STxtStErrorLn;          _Color: clWindow;  _BackColor: clMaroon; _Style: [];            _UpdateType: mcNone;        _UseMemoColor: False),
    (_StyleName: STxtStMarkedBlock;      _Color: clBlack;   _BackColor: clWindow; _Style: [];            _UpdateType: mcSelection;   _UseMemoColor: False),
    (_StyleName: STxtStSearchMatch;      _Color: clBlue;    _BackColor: clTeal;   _Style: [];            _UpdateType: mcSearchMatch; _UseMemoColor: False),

    (_StyleName: STxtStEmphasis;         _Color: clWhite;   _BackColor: clBlack;  _Style: [fsBold];      _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStSystemVariable;   _Color: clAqua;    _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptWhiteSp;    _Color: clLime;    _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptDelimiters; _Color: clAqua;    _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptComment;    _Color: clSilver;  _BackColor: clBlack;  _Style: [fsItalic];    _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptString;     _Color: clYellow;  _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptNumber;     _Color: clFuchsia; _BackColor: clBlack;  _Style: [];            _UpdateType: mcNone;        _UseMemoColor: True),
    (_StyleName: STxtStScriptResWord;    _Color: clWhite;   _BackColor: clBlack;  _Style: [fsBold];      _UpdateType: mcNone;        _UseMemoColor: True)
  );

type
  TMTextStyles = class(TTextStyles);
procedure InitTextStyles(Instance: TTextStyles; const ConstArray: TTextStylesConstArray);
var
  i, idx: integer;
begin
  with TMTextStyles(Instance) do
  begin
    BeginParserUpdate;
    InColorUpdate := true;
    try
      for i := 1 to GlobalTextStylesCount do
        with ConstArray[i] do
        begin
          idx := IndexOfName(_StyleName);
          if idx >= 0 then
            with Items[idx] do
            begin
              Font.Color := _Color;
              Font.Style := _Style;
              Color := _BackColor;
              UpdateMemoColors := _UpdateType;
              UseMemoFont := False;
              UseMemoColor := _UseMemoColor;
            end;
        end;
    finally
      InColorUpdate := false;
      EndParserUpdate;
    end;
  end;
end;

procedure InitDefaultsTextStyles(Instance: TObject);
begin
  InitTextStyles(TTextStyles(Instance), DefaultsTextStyles);
end;

procedure InitClassicTextStyles(Instance: TObject);
begin
  InitTextStyles(TTextStyles(Instance), ClassicTextStyles);
end;

procedure InitOceanTextStyles(Instance: TObject);
begin
  InitTextStyles(TTextStyles(Instance), OceanTextStyles);
end;

procedure InitTwilightTextStyles(Instance: TObject);
begin
  InitTextStyles(TTextStyles(Instance), TwilightTextStyles);
end;

{------------------------------------------------------------------}

procedure TColorsOptForm.FillElements;
var
  i: integer;
begin
  with Elements, Items do
  begin
    BeginUpdate;
    try
      Clear;
      with FMemoOptions do
        for i := 0 to TextStyles.Count - 1 do
          AddObject(TextStyles[i].Name, TextStyles[i]);
      ItemIndex := 0;
    finally
      EndUpdate;
    end;
  end;
  ElementsClick(nil);
end;

function TColorsOptForm.CurrentStyle: TTextStyle;
begin
  with Elements do
    if ItemIndex >= 0 then
      Result := TTextStyle(Items.Objects[ItemIndex])
    else
      Result := nil;
end;

procedure TColorsOptForm.AddTS(const Str: string);
begin
  ComboBox1.Items.Add(Str);
end;

procedure TColorsOptForm.FormCreate(Sender: TObject);
begin
  SetFormFont(Self);

  ForeColorBtn.Height := ForeColor.Height;
  BackColorBtn.Height := BackColor.Height;

  EnumTextStylesSets(AddTS);
  with ComboBox1 do
  begin
    ItemIndex := Items.IndexOf(FMemoOptions.ColorSchema);
    if ItemIndex = - 1 then
      ItemIndex := 0;
  end;

  FillElements;
  Caption := SColors;
  CSSLbl.Caption := SColorSpeedSetting;
  ElementLbl.Caption := SElements;
  ForeColorLbl.Caption := SForeColor;
  BackColorLbl.Caption := SBackColor;
  GroupBox2.Caption := STextAttrs;
  BoldChk.Caption := SBoldFont;
  ItalicChk.Caption := SItalicFont;
  UnderLineChk.Caption := SUnderLineFont;
  GroupBox1.Caption := SUseDefaults;
  chkDefFore.Caption := SForeground;
  chkDefBack.Caption := SBackground;
  OpenButton.Caption := RemoveCharSet(['.'], SFileOpenMenu);
  SaveButton.Caption := SVerbSave;
end;

procedure TColorsOptForm.ElementsClick(Sender: TObject);
var
  TextStyle: TTextStyle;
begin
  TextStyle := CurrentStyle;
  if TextStyle <> nil then
  begin
    ForeColor.SelectedColor := TextStyle.Font.Color;
    BackColor.SelectedColor := TextStyle.Color;
    chkDefFore.Component := TextStyle;
    chkDefFore.PropName := 'UseMemoFont';
    chkDefBack.Component := TextStyle;
    chkDefBack.PropName := 'UseMemoColor';
    BoldChk.Component := TextStyle;
    BoldChk.PropName := 'Font.Style.fsBold';
    ItalicChk.Component := TextStyle;
    ItalicChk.PropName := 'Font.Style.fsItalic';
    UnderlineChk.Component := TextStyle;
    UnderlineChk.PropName := 'Font.Style.fsUnderLine';
  end;
end;

procedure TColorsOptForm.ForeColorChange(Sender: TObject);
begin
  if CurrentStyle <> nil then
    CurrentStyle.Font.Color := ForeColor.SelectedColor;
end;

procedure TColorsOptForm.BackColorChange(Sender: TObject);
begin
  if CurrentStyle <> nil then
  begin
    CurrentStyle.Color := BackColor.SelectedColor;
    if CompareText(CurrentStyle.Name, STxtStWhiteSp) = 0 then
      UpdateMemoOptionsColor;
  end;
end;

procedure TColorsOptForm.OpenButtonClick(Sender: TObject);
begin
  FMemoOptions.TextStyles.LoadColorStyles;
  FillElements;
end;

procedure TColorsOptForm.SaveButtonClick(Sender: TObject);
begin
  FMemoOptions.TextStyles.SaveColorStyles;
end;

procedure TColorsOptForm.CMApplyOptions(var Msg: TMessage);
begin
  FMemoOptions.ApplyOptions;
end;

procedure TColorsOptForm.ComboBox1Change(Sender: TObject);
var
  Proc: TTextStylesInitProc;
begin
  Proc := GetTextStylesInitProc(TCustomDCMemo, ComboBox1.Text);
  with FMemoOptions do
  begin
    if Assigned(Proc) then
      Proc(TextStyles)
    else
      TextStyles.SetDefaultStyles;
    ColorSchema := ComboBox1.Text;
    FillElements;
    UpdateMemoOptionsColor;
  end;
end;

{------------------------------------------------------------------}

procedure TColorsOptForm.ForeColorBtnClick(Sender: TObject);
begin
  with ForeColor, ColorDialog1 do
  begin
    Color := ColorToRGB(SelectedColor);
    if Execute then
      CustomColor := Color;
  end;
end;

procedure TColorsOptForm.BackColorBtnClick(Sender: TObject);
begin
  with BackColor, ColorDialog1 do
  begin
    Color := ColorToRGB(SelectedColor);
    if Execute then
      CustomColor := Color;
  end;
end;

procedure TColorsOptForm.UpdateMemoOptionsColor;
var
  f: TCustomForm;
begin
  with FMemoOptions do
  begin
    if TExtStyles.Count > 0 then
      Color := TextStyles[0].Color;
    f := FindFormWithClass(TDisplayOptForm);
    if Assigned(f) then
      TDisplayOptForm(f).EditorColorEd.SelectedColor := FMemoOptions.Color;
  end;
end;

initialization

  RegisterTextStylesInitProc(TCustomDCMemo, STSDefaults, InitDefaultsTextStyles);
  RegisterTextStylesInitProc(TCustomDCMemo, STSClassic, InitClassicTextStyles);
  RegisterTextStylesInitProc(TCustomDCMemo, STSOcean, InitOceanTextStyles);
  RegisterTextStylesInitProc(TCustomDCMemo, STSTwilight, InitTwilightTextStyles);
end.
