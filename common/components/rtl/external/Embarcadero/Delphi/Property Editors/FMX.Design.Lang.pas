{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Design.Lang;

interface

uses
  DesignIntf, FmxDesignWindows,
  System.SysUtils, System.Classes, System.Rtti,
  FMX.Forms, FMX.Dialogs, FMX.Types, FMX.Layouts, FMX.ListBox, FMX.Controls, FMX.StdCtrls,
  FMX.Objects, FMX.Edit, FMX.Menus, FMX.ExtCtrls, FMX.Styles, FMX.Grid,
  FMX.Header;

type
  TLangDesigner = class(TFmxDesignWindow)
    OriginalList: TListBox;
    btnAddItem: TButton;
    langList: TPopupBox;
    ToolBar1: TToolBar;
    inputLang: TEdit;
    HudLabel1: TLabel;
    layoutSelect: TLayout;
    HudLabel2: TLabel;
    btnAddNewLang: TButton;
    btnCancalAdd: TButton;
    layoutAdd: TLayout;
    layoutAddText: TLayout;
    btnAddText: TButton;
    btnCancelAddText: TButton;
    inputAddText: TEdit;
    btnRemoveItem: TButton;
    btnCollect: TButton;
    btnAddLang: TButton;
    btnLoadTxt: TButton;
    btnCreateTemplate: TButton;
    btnLoadLng: TButton;
    btnSaveLng: TButton;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    StatusBar1: TStatusBar;
    Layout1: TLayout;
    Header1: THeader;
    TextHeaderItem: THeaderItem;
    StyleBook1: TStyleBook;
    ListBoxHeader1: TListBoxHeader;
    procedure btnAddClick(Sender: TObject);
    procedure btnAddLangClick(Sender: TObject);
    procedure langListChange(Sender: TObject);
    procedure btnAddItemClick(Sender: TObject);
    procedure btnRemoveItemClick(Sender: TObject);
    procedure btnAddNewLangClick(Sender: TObject);
    procedure btnCancalAddClick(Sender: TObject);
    procedure btnCancelAddTextClick(Sender: TObject);
    procedure btnAddTextClick(Sender: TObject);
    procedure btnCollectClick(Sender: TObject);
    procedure btnCreateTemplateClick(Sender: TObject);
    procedure btnLoadTxtClick(Sender: TObject);
    procedure btnLoadLngClick(Sender: TObject);
    procedure btnSaveLngClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OriginalListChange(Sender: TObject);
    procedure Header1ResizeItem(Sender: TObject; var NewSize: Single);
  private
    { Private declarations }
    procedure DoTranslateChanged(Sender: TObject);
  public
    { Public declarations }
    FLang: TLang;
    procedure RebuildOriginalList;
  end;

var
  vgLangDesigner: TLangDesigner;

procedure ShowDsgnLang(Lang: TLang; ADesigner: IDesigner);

implementation

{$R *.fmx}

uses
  System.Generics.Collections, System.Math, System.UITypes;

procedure ShowDsgnLang(Lang: TLang; ADesigner: IDesigner);
begin
  vgLangDesigner := TLangDesigner.Create(Application);
  vgLangDesigner.Designer := ADesigner;
  with vgLangDesigner do
  begin
    FLang := Lang;
    langList.Items.Assign(Lang.Resources);
    if langList.Items.Count > 0 then
      langList.ItemIndex := Lang.Resources.IndexOf(Lang.Lang);

    layoutAdd.Visible := langList.Items.Count = 0;
    layoutSelect.Visible := langList.Items.Count > 0;

    RebuildOriginalList;
    if ShowModal = mrOk then
    begin
      FLang.Lang := langList.Text;
      vgLangDesigner.Designer.Modified;
    end;
  end;
  vgLangDesigner.Free;
end;

procedure TLangDesigner.RebuildOriginalList;
var
  i: integer;
  Str: TStrings;
  Item: TListboxItem;
  TextStyle: TControl;
begin
  OriginalList.Clear;
  if FLang.Original.Count = 0 then
  begin
    // create original from Collection
    CollectLangStart;
    TStyleManager.UpdateScenes;
    FLang.Original.Assign(CollectLangStrings);
    CollectLangFinish;
  end;
  Str := FLang.Original;
  for i := 0 to Str.Count - 1 do
  begin
    Item := TListboxItem.Create(Self);
    Item.AutoTranslate := false;
    Item.StyleLookup := 'langitem';
    Item.Text := Str[i];
    Item.TextAlign := TTextAlign.taLeading;
    Item.Height := 23;
    Item.Parent := OriginalList;
    Item.ApplyStyleLookup;
    if Item.FindStyleResource('translate') = nil then Continue;
    if (FLang.Resources.Count > 0) and (langList.ItemIndex >= 0) then
    begin
      if FLang.LangStr[langList.Text] <> nil then
      begin
        Item.StylesData['translate'] := FLang.LangStr[langList.Text].Values[Str[i]];
        Item.StylesData['translate.OnChangeTracking'] := TValue.From<TNotifyEvent>(DoTranslateChanged);
      end;
    end
    else
      Item.FindStyleResource('translate').AsIControl.Visible := false;
    TextStyle := TControl(Item.FindStyleResource('text'));
    if Assigned(TextStyle) then
      TextStyle.Width := TextHeaderItem.Width - TextStyle.Margins.Left;
  end;
  if OriginalList.Count > 0 then
    OriginalList.ItemIndex := OriginalList.Count - 1
  else
    OriginalList.ItemIndex := -1;
end;

procedure TLangDesigner.btnAddClick(Sender: TObject);
begin
  { add new lang }
  TListBox.Create(Self);
end;

procedure TLangDesigner.DoTranslateChanged(Sender: TObject);
begin
  if (FLang.LangStr[langList.Text] <> nil) and (OriginalList.Selected <> nil) then
    with FLang.LangStr[langList.Text] do
    begin
      Values[OriginalList.Selected.Text] := TEdit(Sender).Text;
    end;
end;

procedure TLangDesigner.FormCreate(Sender: TObject);
const
  TextMargins = 20;
var
  Buttons: TList<TButton>;
  i: Integer;
begin
  //Layout buttons for localization
  Buttons := TList<TButton>.Create;
  try
    btnRemoveItem.Enabled := False;
    Buttons.Add(btnCollect);
    Buttons.Add(btnCreateTemplate);
    Buttons.Add(btnLoadLng);
    Buttons.Add(btnSaveLng);

    for i := 0 to Buttons.Count - 1 do
    begin
      if Assigned(Buttons.Items[i]) then
      begin
        with Buttons.Items[i] do
          Width := System.Math.Max(70, Round(Canvas.TextWidth(Text)) + TextMargins);
      end;
    end;
  finally
    Buttons.Free;
  end;
end;

procedure TLangDesigner.Header1ResizeItem(Sender: TObject; var NewSize: Single);
var
  I: Integer;
  Item: TListBoxItem;
  TextStyle: TControl;
begin
  for I := 0 to OriginalList.Count - 1 do
  begin
    Item := OriginalList.ItemByIndex(I);
    TextStyle := TControl(Item.FindStyleResource('text'));
    if Assigned(TextStyle) then
      TextStyle.Width := TextHeaderItem.Width - TextStyle.Margins.Left;
  end;
end;

procedure TLangDesigner.btnAddLangClick(Sender: TObject);
var
  S: string;
begin
  if inputLang.Text = '' then Exit;
  S := inputLang.Text;
  if Length(S) > 2 then
    Delete(S, 3, MaxInt);
  FLang.AddLang(S);
  langList.Items := FLang.Resources;
  langList.ItemIndex := langList.Items.IndexOf(S);
  RebuildOriginalList;

  layoutAdd.Visible := false;
  layoutSelect.Visible := true;

  Designer.Modified;
end;

procedure TLangDesigner.langListChange(Sender: TObject);
begin
  RebuildOriginalList;
end;

procedure TLangDesigner.OriginalListChange(Sender: TObject);
begin
  btnRemoveItem.Enabled := OriginalList.ItemIndex > -1 ;
end;

procedure TLangDesigner.btnAddNewLangClick(Sender: TObject);
begin
  layoutAdd.Visible := true;
  layoutSelect.Visible := false;
  btnCancalAdd.Visible := langList.Items.Count > 0;

  inputLang.Text := '';
  inputLang.SetFocus;
end;

procedure TLangDesigner.btnCancalAddClick(Sender: TObject);
begin
  if langList.Items.Count > 0 then
  begin
    layoutAdd.Visible := false;
    layoutSelect.Visible := true;
  end;
end;

procedure TLangDesigner.btnAddItemClick(Sender: TObject);
begin
  { Add Word }
  layoutAdd.Visible := false;
  layoutSelect.Visible := false;
  layoutAddText.Visible := true;
  inputAddText.Text := '';
  inputAddText.SetFocus;
  RebuildOriginalList;
end;

procedure TLangDesigner.btnRemoveItemClick(Sender: TObject);
begin
  { Remove Word }
  if OriginalList.ItemIndex >= 0 then
  begin
    FLang.Original.Delete(OriginalList.ItemIndex);
    RebuildOriginalList;
  end;
end;

procedure TLangDesigner.btnCancelAddTextClick(Sender: TObject);
begin
  layoutAdd.Visible := langList.Items.Count = 0;
  layoutSelect.Visible := langList.Items.Count > 0;
  layoutAddText.Visible := false;
end;

procedure TLangDesigner.btnAddTextClick(Sender: TObject);
begin
  btnCancelAddTextClick(Sender);
  FLang.Original.Add(inputAddText.Text);
  RebuildOriginalList;
  OriginalList.ItemIndex := OriginalList.Count - 1;
end;

procedure TLangDesigner.btnCollectClick(Sender: TObject);
var
  Str: TStrings;
  i: integer;
begin
  CollectLangStart;
  TStyleManager.UpdateScenes;
  Str := TStringList.Create;
  Str.Assign(CollectLangStrings);
  for i := 0 to Str.Count - 1 do
    if FLang.Original.IndexOf(Str[i]) < 0 then
      FLang.Original.Add(Str[i]);
  Str.Free;
  CollectLangFinish;
  RebuildOriginalList;
end;

procedure TLangDesigner.btnCreateTemplateClick(Sender: TObject);
var
  Str: TStrings;
  i: integer;
begin
  if SaveDialog1.Execute then
  begin
    Str := TStringList.Create;
    Str.Assign(FLang.Original);
    for i := 0 to Str.Count - 1 do
      Str[i] := Str[i] + '=';
    Str.SaveToFile(SaveDialog1.FileName);
    Str.Free;
  end;
end;

procedure TLangDesigner.btnLoadTxtClick(Sender: TObject);
var
  Str: TStrings;
  i: integer;
begin
  if OpenDialog1.Execute then
  begin
    FLang.AddLang(inputLang.Text);
    langList.Items := FLang.Resources;
    langList.ItemIndex := langList.Items.IndexOf(inputLang.Text);
    RebuildOriginalList;

    layoutAdd.Visible := false;
    layoutSelect.Visible := true;

    Str := TStringList.Create;
    Str.LoadFromFile(OpenDialog1.FileName);
    for i := 0 to Str.Count - 1 do
      if FLang.LangStr[langList.Text].IndexOfName(Str.Names[i]) < 0 then
        FLang.LangStr[langList.Text].Add(Str[i])
      else
        FLang.LangStr[langList.Text].Values[Str.Names[i]] := Str.Values[Str.Names[i]];
    Str.Free;
    RebuildOriginalList;
  end;
end;

procedure TLangDesigner.btnLoadLngClick(Sender: TObject);
begin
  if OpenDialog2.Execute then
  begin
    FLang.LoadFromFile(OpenDialog2.FileName);
    RebuildOriginalList;
  end;
end;

procedure TLangDesigner.btnSaveLngClick(Sender: TObject);
begin
  if SaveDialog2.Execute then
  begin
    FLang.SaveToFile(SaveDialog2.FileName);
  end;
end;

end.

