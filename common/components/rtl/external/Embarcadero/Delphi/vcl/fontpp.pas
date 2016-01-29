{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FontPP;

interface

uses
  Vcl.StdCtrls, Vcl.AxCtrls, StdMain;

type
  TFontPropPage = class(TPropertyPage)
    StaticText1: TStaticText;
    PropName: TComboBox;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    FontName: TEdit;
    FontList: TListBox;
    FontStyleCombo: TComboBox;
    FontSizeCombo: TComboBox;
    GroupBox1: TGroupBox;
    StrikeCB: TCheckBox;
    UnderlineCB: TCheckBox;
    GroupBox2: TGroupBox;
    Sample: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FontListClick(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure StrikeCBClick(Sender: TObject);
    procedure UnderlineCBClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PropNameChange(Sender: TObject);
  private
    FChanging: Boolean;
    ApplyList: TPropApplyList;
    procedure FontChanged;
  public
    procedure UpdatePropertyPage; override;
    procedure UpdateObject; override;
  end;

implementation

uses 
  Winapi.ActiveX, 
  Vcl.Graphics, Vcl.Forms, System.Win.ComServ, System.Win.ComObj,
  System.SysUtils, 
  System.UITypes, Vcl.Consts;

{$R *.dfm}

procedure TFontPropPage.FontChanged;
var
  IFt: IFontDisp;
begin
  if FChanging then Exit;
  GetOleFont(Sample.Font, IFt);
  ApplyList.AddProp(Integer(PropName.Items.Objects[PropName.ItemIndex]), IFt);
  Modified;
end;

procedure TFontPropPage.UpdatePropertyPage;
begin
  EnumCtlProps(IFontDisp, PropName.Items);
  PropName.Enabled := PropName.Items.Count <> 0;
  if PropName.Enabled then
  begin
    PropName.ItemIndex := 0;
    PropNameChange(Self);
  end
  else begin
    FontName.Enabled := False;
    FontList.Enabled := False;
    FontStyleCombo.Enabled := False;
    FontSizeCombo.Enabled := False;
    StrikeCB.Enabled := False;
    UnderlineCB.Enabled := False;
  end;
end;

procedure TFontPropPage.UpdateObject;
var
  i: Integer;
begin
  for i := 0 to ApplyList.Count - 1 do
    SetDispatchPropValue(IUnknown(OleObject) as IDispatch, ApplyList.Props[i]^.PropId,
      ApplyList.Props[i]^.PropValue);
  ApplyList.ClearProps;
  Sample.Font.FontAdapter := nil;
end;

procedure TFontPropPage.FontListClick(Sender: TObject);
begin
  FontName.Text:= FontList.Items[FontList.ItemIndex];
end;

procedure TFontPropPage.FontNameChange(Sender: TObject);
begin
  if FChanging then Exit;
  with Sample.Font do
  begin
    Name:= FontName.Text;
    if AnsiCompareText(FontStyleCombo.Text, SBoldFont) = 0 then
      Style := [fsBold]
    else if AnsiCompareText(FontStyleCombo.Text, SItalicFont) = 0 then
      Style:= [fsItalic]
    else if AnsiCompareText(FontStyleCombo.Text, SBoldItalicFont) = 0 then
      Style:= [fsBold, fsItalic]
    else if AnsiCompareText(FontStyleCombo.Text, SRegularFont) = 0 then
      Style:= [];
    if FontSizeCombo.Text <> '' then
      Size := StrToInt(FontSizeCombo.Text);
    if StrikeCB.Checked then Style := Style + [fsStrikeOut];
    if UnderlineCB.Checked then Style := Style + [fsUnderline];
  end;
  FontChanged;
end;

procedure TFontPropPage.StrikeCBClick(Sender: TObject);
begin
  if FChanging then Exit;
  if StrikeCB.Checked then
    Sample.Font.Style := Sample.Font.Style + [fsStrikeout]
  else
    Sample.Font.Style := Sample.Font.Style - [fsStrikeout];
  FontChanged;
end;

procedure TFontPropPage.UnderlineCBClick(Sender: TObject);
begin
  if FChanging then Exit;
  if UnderlineCB.Checked then
    Sample.Font.Style:= Sample.Font.Style + [fsUnderline]
  else
    Sample.Font.Style:= Sample.Font.Style - [fsUnderline];
  FontChanged;
end;

procedure TFontPropPage.PropNameChange(Sender: TObject);
var
  IFt: IFontDisp;
begin
  FChanging := True;
  try
    IFt := IUnknown(GetDispatchPropValue(IUnknown(OleObject) as IDispatch,
      Integer(PropName.Items.Objects[PropName.ItemIndex]))) as IFontDisp;
    SetOleFont(Sample.Font, IFt);
    Sample.Font.FontAdapter := nil;
    FontName.Text:= Sample.Font.Name;
    FontSizeCombo.Text:= IntToStr(Sample.Font.Size);
    StrikeCB.Checked := fsStrikeOut in Sample.Font.Style;
    UnderlineCB.Checked := fsUnderline in Sample.Font.Style;
    if Sample.Font.Style * [fsBold, fsItalic] = [fsBold, fsItalic] then
      FontStyleCombo.Text:= SBoldItalicFont
    else if fsBold in Sample.Font.Style then
      FontStyleCombo.Text:= SBoldFont
    else if fsItalic in Sample.Font.Style then
      FontStyleCombo.Text:= SItalicFont
    else
      FontStyleCombo.Text:= SRegularFont;
  finally
    FChanging := False;
  end;
end;

procedure TFontPropPage.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  ApplyList := TPropApplyList.Create;
  for i := 0 to Screen.Fonts.Count - 1 do
    FontList.Items.Add(Screen.Fonts[i]);
end;

procedure TFontPropPage.FormDestroy(Sender: TObject);
begin
  ApplyList.Free;
end;

initialization
  TActiveXPropertyPageFactory.Create(
    ComServer,
    TFontPropPage,
    Class_DFontPropPage);
end.
