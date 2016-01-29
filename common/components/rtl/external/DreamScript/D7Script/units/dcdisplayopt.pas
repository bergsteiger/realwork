{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcDisplayOpt;

interface

uses
  dcdreamLib, Messages, Forms, StdCtrls, dcedit, DCColorCombo, PropCB, Controls,
  Classes, Buttons, Dialogs;

type
  TDisplayOptForm = class(TForm)
    EditFontLbl: TLabel;
    SizeLbl: TLabel;
    EditorColorLbl: TLabel;
    EditMarginGroup: TGroupBox;
    ColorLbl: TLabel;
    StyleMarginLbl: TLabel;
    WitdhMarginLbl: TLabel;
    PositionLbl: TLabel;
    MarginVisibleCheck: TDCPropCheck;
    MarginColorEdit: TDCColorCombo;
    MarginStyleEdit: TDCPenStyleEdit;
    MarginWidthEdit: TEdit;
    MarginPosEdit: TEdit;
    EditGutterGroup: TGroupBox;
    ColorGutterLbl: TLabel;
    StyleLbl: TLabel;
    WidthLbl: TLabel;
    GutterVisibleLbl: TDCPropCheck;
    GutterColorEdit: TDCColorCombo;
    GutterStyleEdit: TDCBrushStyleEdit;
    GutterWidthEdit: TEdit;
    FontNameEdit: TComboBox;
    FontSizeEdit: TComboBox;
    EditorColorEd: TDCColorCombo;
    GutterColorBtn: TBitBtn;
    MarginColorBtn: TBitBtn;
    ColorDialog1: TColorDialog;
    pcbUseMonoFont: TDCPropCheck;
    pcbUseReadOnlyColor: TDCPropCheck;
    ReadOnlyColorEd: TDCColorCombo;
    lblReadOnlyColor: TLabel;
    pcbUseSpecSymbs: TDCPropCheck;
    lblSSEOF: TLabel;
    edtSSEOF: TEdit;
    lblSSEOL: TLabel;
    edtSSEOL: TEdit;
    lblSSSpace: TLabel;
    edtSSSpace: TEdit;
    lblSSTab: TLabel;
    edtSSTab: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure GutterWidthEditExit(Sender: TObject);
    procedure GutterColorEditChange(Sender: TObject);
    procedure GutterStyleEditChange(Sender: TObject);
    procedure MarginWidthEditExit(Sender: TObject);
    procedure MarginColorEditChange(Sender: TObject);
    procedure MarginStyleEditChange(Sender: TObject);
    procedure MarginPosEditExit(Sender: TObject);
    procedure FontNameEditChange(Sender: TObject);
    procedure EditorColorEdChange(Sender: TObject);
    procedure FontSizeEditChange(Sender: TObject);
    procedure GutterColorBtnClick(Sender: TObject);
    procedure MarginColorBtnClick(Sender: TObject);
    procedure FontNameEditDropDown(Sender: TObject);
    procedure pcbUseMonoFontClick(Sender: TObject);
    procedure ReadOnlyColorEdChange(Sender: TObject);
    procedure edtSSEOFExit(Sender: TObject);
    procedure edtSSEOLExit(Sender: TObject);
    procedure edtSSSpaceChange(Sender: TObject);
    procedure edtSSTabChange(Sender: TObject);
    procedure pcbUseReadOnlyColorClick(Sender: TObject);
    procedure pcbUseSpecSymbsClick(Sender: TObject);
  private
    IsFirstTime: Boolean;
    procedure CMApplyOptions(var Msg: TMessage); message CM_APPLYOPTIONS;
    Procedure LoadFonts(UseMonoFonts:Boolean);
  end;

var
  DisplayOptForm: TDisplayOptForm;

implementation

uses SysUtils, Graphics, dcMemOpt, dcCommon, dcConsts, dcMemo;

{$R *.DFM}

Procedure TDisplayOptForm.LoadFonts(UseMonoFonts:Boolean);
var
  AFont: TFont;
  i: integer;
  FontName:String;
  Strings:TStrings;
Begin
  Screen.Cursor:=crHourglass;
  Try
    if UseMonoFonts then
    Begin
      AFont := TFont.Create;
      try
        Strings:=TStringList.Create;
        Try
          for i := 0 to Screen.Fonts.Count - 1 do
          Begin
            FontName:=Screen.Fonts[i];
            AFont.Name := FontName;
            if IsFontMonoSpaced(AFont) then
              Strings.Add(FontName);
          End;
          FontNameEdit.Items.Assign(Strings);
        Finally
          Strings.Free;
        End;
      finally
        AFont.Free;
      end
    End
    Else
      FontNameEdit.Items.Assign(Screen.Fonts);
    with FontNameEdit do
    Begin
      I:=Items.IndexOf(FMemoOptions.Font.Name);
      If I<0 Then
        I:=0;
      ItemIndex:=I;
      FontNameEditChange(Self);
    End;
  Finally
    Screen.Cursor:=crDefault;
  End;
End;

procedure TDisplayOptForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  SetFormFont(self);
  GutterColorBtn.Height := GutterColorEdit.Height;
  MarginColorBtn.Height := MarginColoredit.Height;

  Caption := SDisplay;
  EditGutterGroup.Caption := SEditGutter;
  with GutterVisibleLbl do
  begin
    Caption := SVisible;
    Component := FMemoOptions;
    PropName := 'options.moDrawGutter';
  end;
  WidthLbl.Caption := SOptionwidth;
  GutterWidthEdit.Text := IntToStr(FMemoOptions.GutterWidth);
  ColorGutterLbl.Caption := SColor;
  GutterColorEdit.SelectedColor := FMemoOptions.GutterBrush.Color;
  StyleLbl.Caption := SStyle;
  GutterStyleEdit.BrushStyle := FMemoOptions.GutterBrush.Style;
  EditMarginGroup.Caption := SEditMargin;
  with MarginVisibleCheck do
  begin
    Caption := SVisible2;
    Component := FMemoOptions;
    PropName := 'options.moDrawMargin';
  end;
  WitdhMarginLbl.Caption := SOptionWidth2;
  MarginWidthEdit.Text := IntToStr(FMemoOptions.MarginPen.Width);
  ColorLbl.Caption := SColor2;
  MarginColorEdit.SelectedColor := FMemoOptions.MarginPen.Color;
  StyleMarginLbl.Caption := SStyle2;
  MarginStyleEdit.PenStyle := FMemoOptions.MarginPen.Style;
  PositionLbl.Caption := SPosition;
  MarginPosEdit.Text := IntToStr(FMemoOptions.MarginPos);
  With pcbUseMonoFont Do
  Begin
    OnClick:=Nil;
    Caption:=SUseMonoFont;
    Component:=FMemoOptions;
    PropName:='UseMonoFont';
    OnClick:=pcbUseMonoFontClick;
  End;
  IsFirstTime := True;
  EditFontLbl.Caption := SEditFont;
  with FontNameEdit do
  begin
    Items.Add(FMemoOptions.Font.Name);
    ItemIndex := Items.IndexOf(FMemoOptions.Font.Name);
  end;
  EditorColorLbl.Caption := SEditorColor;
  EditorColorEd.SelectedColor := FMemoOptions.Color;
  SizeLbl.Caption := SOptionSize;
  with FontSizeEdit, Items do
  begin
    for i := 0 to 15 do
      Add(IntToStr(StdFontSizes[i]));
    ItemIndex := IndexOf(IntToStr(FMemoOptions.Font.Size));
  end;
  with pcbUseReadOnlyColor do
  begin
    Caption := SUseReadOnlyColor;
    Component := FMemoOptions;
    PropName := 'options.moUseReadOnlyColor';
  end;
  lblReadOnlyColor.Caption := SReadOnlyColor;
  ReadOnlyColorEd.SelectedColor := FMemoOptions.ReadOnlyColor;
  with pcbUseSpecSymbs do
  begin
    Caption := SUseSpecSymbs;
    Component := FMemoOptions;
    PropName := 'options.moDrawSpecialSymbols';
  end;
  lblSSEOF.Caption := SEOF;
  lblSSEOL.Caption := SEOL;
  lblSSSpace.Caption := SSpace;
  lblSSTab.Caption := STab;
  with FMemoOptions.SpecialSymbols do
  begin
    edtSSEOF.Text := EOFString;
    edtSSEOL.Text := EOLString;
    edtSSSpace.Text := SpaceChar;
    edtSSTab.Text := TabChar;
  end;
  pcbUseReadOnlyColorClick(Sender);
  pcbUseSpecSymbsClick(Sender);
end;

procedure TDisplayOptForm.GutterWidthEditExit(Sender: TObject);
begin
  FMemoOptions.GutterWidth := StrToInt(GutterWidthEdit.Text);
end;

procedure TDisplayOptForm.GutterColorEditChange(Sender: TObject);
begin
  FMemoOptions.GutterBrush.Color := GutterColorEdit.SelectedColor;
end;

procedure TDisplayOptForm.GutterStyleEditChange(Sender: TObject);
begin
  FMemoOptions.GutterBrush.Style := GutterStyleEdit.BrushStyle;
end;

procedure TDisplayOptForm.MarginWidthEditExit(Sender: TObject);
begin
  FMemoOptions.MarginPen.Width := StrToInt(MarginWidthEdit.Text);
end;

procedure TDisplayOptForm.MarginColorEditChange(Sender: TObject);
begin
  FMemoOptions.MarginPen.Color := MarginColorEdit.SelectedColor;
end;

procedure TDisplayOptForm.MarginStyleEditChange(Sender: TObject);
begin
  FMemoOptions.MarginPen.Style := MarginStyleEdit.PenStyle;
end;

procedure TDisplayOptForm.MarginPosEditExit(Sender: TObject);
begin
  FMemoOptions.MarginPos := StrToInt(MarginPosEdit.Text);
end;

procedure TDisplayOptForm.FontNameEditChange(Sender: TObject);
begin
  FMemoOptions.Font.Name := FontNameEdit.Text;
end;

procedure TDisplayOptForm.EditorColorEdChange(Sender: TObject);
begin
  FMemoOptions.Color := EditorColorEd.SelectedColor;
end;

procedure TDisplayOptForm.FontSizeEditChange(Sender: TObject);
begin
  FMemoOptions.Font.Size := StrToInt(FontSizeEdit.Text);
end;

procedure TDisplayOptForm.CMApplyOptions(var Msg: TMessage);
begin
  FMemoOptions.ApplyOptions;
end;

procedure TDisplayOptForm.GutterColorBtnClick(Sender: TObject);
begin
  with GutterColorEdit, ColorDialog1 do
  begin
    Color := ColorToRGB(SelectedColor);
    if Execute then
      CustomColor := Color;
  end;
end;

procedure TDisplayOptForm.MarginColorBtnClick(Sender: TObject);
begin
  with MarginColorEdit, ColorDialog1 do
  begin
    Color := ColorToRGB(SelectedColor);
    if Execute then
      CustomColor := Color;
  end;
end;

procedure TDisplayOptForm.FontNameEditDropDown(Sender: TObject);
begin
  if IsFirstTime then
  begin
    IsFirstTime := False;
    LoadFonts(pcbUseMonoFont.Checked);
  end;
end;

procedure TDisplayOptForm.pcbUseMonoFontClick(Sender: TObject);
begin
  IsFirstTime:=True;
  LoadFonts(pcbUseMonoFont.Checked);
end;

procedure TDisplayOptForm.ReadOnlyColorEdChange(Sender: TObject);
begin
  FMemoOptions.ReadOnlyColor := ReadOnlyColorEd.SelectedColor;
end;

procedure TDisplayOptForm.edtSSEOFExit(Sender: TObject);
begin
  FMemoOptions.SpecialSymbols.EOFString := edtSSEOF.Text;
end;

procedure TDisplayOptForm.edtSSEOLExit(Sender: TObject);
begin
  FMemoOptions.SpecialSymbols.EOLString := edtSSEOL.Text;
end;

procedure TDisplayOptForm.edtSSSpaceChange(Sender: TObject);
begin
  with FMemoOptions.SpecialSymbols, edtSSSpace do
    if Text <> '' then
      SpaceChar := Text[1]
    else
      SpaceChar := #0;
end;

procedure TDisplayOptForm.edtSSTabChange(Sender: TObject);
begin
  with FMemoOptions.SpecialSymbols, edtSSTab do
    if Text <> '' then
      TabChar := Text[1]
    else
      TabChar := #0;
end;

procedure TDisplayOptForm.pcbUseReadOnlyColorClick(Sender: TObject);
begin
  with pcbUseReadOnlyColor do
  begin
    lblReadOnlyColor.Enabled := Checked;
    ReadOnlyColorEd.Enabled := Checked;
  end;
end;

procedure TDisplayOptForm.pcbUseSpecSymbsClick(Sender: TObject);
begin
  with pcbUseSpecSymbs do
  begin
    lblSSEOF.Enabled := Checked;
    edtSSEOF.Enabled := Checked;
    lblSSEOL.Enabled := Checked;
    edtSSEOL.Enabled := Checked;
    lblSSSpace.Enabled := Checked;
    edtSSSpace.Enabled := Checked;
    lblSSTab.Enabled := Checked;
    edtSSTab.Enabled := Checked;
  end;
end;

end.
