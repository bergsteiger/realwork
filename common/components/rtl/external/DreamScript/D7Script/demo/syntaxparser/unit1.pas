{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit Unit1;

interface
{$I dc.inc}

{$IFDEF D6}
  {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

uses
  Forms, dcSyEdForm, ExtCtrls, dcsystem, dcSyntax, StdCtrls, ComCtrls,
  Controls, dccommon, dcmemo, Classes, Dialogs;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DCMemo1: TDCMemo;
    SyntaxParser1: TSyntaxParser;
    TabSheet2: TTabSheet;
    SyntaxParser2: TSyntaxParser;
    DCMemo2: TDCMemo;
    Label1: TLabel;
    Label2: TLabel;
    TabControl1: TTabControl;
    CheckBox1: TCheckBox;
    CheckBox4: TCheckBox;
    ListBox1: TListBox;
    Label4: TLabel;
    Button2: TButton;
    Button3: TButton;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    ListBox2: TListBox;
    Button4: TButton;
    Button5: TButton;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    DCMemo3: TDCMemo;
    SyntaxParser3: TSyntaxParser;
    Label3: TLabel;
    Panel2: TPanel;
    Label9: TLabel;
    Panel3: TPanel;
    ListBox3: TListBox;
    Label10: TLabel;
    OpenDialog1: TOpenDialog;
    Bevel1: TPanel;
    Bevel2: TPanel;
    Bevel3: TPanel;
    Panel4: TPanel;
    CheckBox2: TCheckBox;
    Button1: TButton;
    CheckBox3: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    ComboBox1: TComboBox;
    Label11: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBox3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    EditForm: TSyntaxEdForm;
    EditedBlock: TSyntaxBlock;
    ProgPath: string;
    procedure EnumSet(const Str: string);
  end;

var
  Form1: TForm1;

implementation

uses
  SysUtils, Graphics, dcColorsOpt, Unit2;

{$R *.DFM}

const
  PathToSchemes = '..\..\..\units\SyntaxSchemes\';
  PathToTexts = '..\texts\';

procedure TForm1.FormCreate(Sender: TObject);
var
  i, r: integer;
  sr: TSearchRec;
  ss: TSyntaxScheme;
  o: TObject;
begin
  CheckBox6.Checked:=True;
  ProgPath := ExtractFilePath(Application.ExeName);
  PageControl1.ActivePage := TabSheet1;
  r := FindFirst(ProgPath + PathToSchemes + '*.sch', faAnyFile, sr);
  ss := TSyntaxScheme.Create;
  try
    while r = 0 do
    begin
      ss.LoadFromFile(ProgPath + PathToSchemes + sr.Name);
      o := Pointer(NewStr(Copy(sr.Name, 1, Pos('.', sr.Name) - 1)));
      ListBox3.Items.AddObject(ss.Name, o);
      r := FindNext(sr);
    end;
  finally
    ss.Free;
    FindClose(sr);
  end;
  with ListBox3 do
    if Items.Count > 0 then
    begin
      ItemIndex := 0;
      ListBox3Click(Sender);
    end;
  with TabControl1, SyntaxParser2.SyntaxScheme.SyntaxBlocks do
  begin
    Tabs.Clear;
    for i := 0 to Pred(Count) do
      Tabs.Add(Items[i].Name);
    TabIndex := 0;
  end;
  TabControl1Change(nil);
  SyntaxParser3.SyntaxScheme.LoadFromFile(ProgPath + PathToSchemes + 'CPPBuilder.sch');
  DCMemo3.LoadFromFile(PathToTexts + 'CPPBuilder.txt');
  EditForm := TSyntaxEdForm.Create(nil);
  with EditForm do
  begin
    BorderStyle := bsNone;
    Position := poDesigned;
    Parent := Panel2;
    Align := alClient;
    Visible := True;
    EditedScheme := SyntaxParser3.SyntaxScheme;
  end;
  EnumTextStylesSets(EnumSet);
  with ComboBox1 do
    if Items.Count > 0 then
      ItemIndex := 0;
  ComboBox1Change(Sender);
end;

procedure TForm1.TabControl1Change(Sender: TObject);
var
  i: integer;
begin
  EditedBlock := SyntaxParser2.SyntaxScheme.SyntaxBlocks[TabControl1.TabIndex];
  with EditedBlock do
  begin
    CheckBox1.Checked := UseComments;
    CheckBox3.Enabled := TabControl1.TabIndex = 0;
    CheckBox5.Enabled := CheckBox3.Enabled;
    if CheckBox3.Enabled then
    begin
      CheckBox3.Checked := SingleLineCommentDelimiters[0].UseToken;
      CheckBox5.Checked := MultiLineCommentDelimiters[0].UseToken;
    end;
    CheckBox4.Checked := UseIdentifiers;
    ListBox1.Enabled := KeywordSets.Count > 0;
    Label4.Enabled := ListBox1.Enabled;
    Button2.Enabled := ListBox1.Enabled;
    Button3.Enabled := ListBox1.Enabled;
    if ListBox1.Enabled then
      ListBox1.Items.CommaText := KeywordSets[0].Keywords
    else
      ListBox1.Items.Clear;
    ListBox2.Items.Clear;
    with SingleLineStringDelimiters do
      for i := 0 to Pred(Count) do
        ListBox2.Items.Add(Items[i].LeftDelimiter + ' and ' + Items[i].RightDelimiter);
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  EditedBlock.UseComments := CheckBox1.Checked;
  SyntaxParser2.SyntaxScheme.SchemeChanged;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  EditedBlock.UseIdentifiers := CheckBox4.Checked;
  SyntaxParser2.SyntaxScheme.SchemeChanged;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  s: string;
begin
  s := InputBox('New keyword', 'Input keyword:', '');
  if (s <> '') then
  begin
    ListBox1.Items.Add(s);
    EditedBlock.UseKeywords := True;
    EditedBlock.KeywordSets[0].Keywords := ListBox1.Items.CommaText;
    SyntaxParser2.SyntaxScheme.SchemeChanged;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  with ListBox1 do
    if ItemIndex >= 0 then
    begin
      Items.Delete(ItemIndex);
      EditedBlock.KeywordSets[0].Keywords := Items.CommaText;
      SyntaxParser2.SyntaxScheme.SchemeChanged;
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  ai: TAttrItem;
begin
  with Form2 do
  begin
    Edit1.Text := '';
    Edit2.Text := '';
    DCColorEdit1.SelectedColor := clBlack;
    CheckBox1.Checked := False;
    CheckBox2.Checked := False;
    CheckBox3.Checked := False;
    CheckBox4.Checked := False;
    ActiveControl := Edit1;
    if (ShowModal = mrOK) and (Edit1.Text <> '') and (Edit2.Text <> '') then
      with TBlockToken(EditedBlock.SingleLineStringDelimiters.Add) do
      begin
        EditedBlock.UseStrings := True;
        EditedBlock.UseSingleLineStrings := True;
        LeftDelimiter := Edit1.Text;
        RightDelimiter := Edit2.Text;
        UseToken := True;
        ai := TAttrItem(SyntaxParser2.SyntaxScheme.FontTable.Add);
        FontID := ai.FontID;
        ai.UseDefFont := True;
        with ai.Font do
        begin
          Color := DCColorEdit1.SelectedColor;
          Style := [];
          if CheckBox1.Checked then
            Style := Style + [fsBold];
          if CheckBox2.Checked then
            Style := Style + [fsItalic];
          if CheckBox3.Checked then
            Style := Style + [fsUnderline];
          if CheckBox4.Checked then
            Style := Style + [fsStrikeOut];
        end;
        ListBox2.Items.Add(LeftDelimiter + ' and ' + RightDelimiter);
        SyntaxParser2.SyntaxScheme.SchemeChanged;
      end;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if ListBox2.ItemIndex >= 0 then
  begin
    EditedBlock.SingleLineStringDelimiters.Items[ListBox2.ItemIndex].Free;
    ListBox2.Items.Delete(ListBox2.ItemIndex);
    SyntaxParser2.SyntaxScheme.SchemeChanged;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  with ListBox3 do
    for i := Items.Count - 1 downto 0 do
      DisposeStr(PString(Items.Objects[i]));
  EditForm.Free;
end;

procedure TForm1.ListBox3Click(Sender: TObject);
var
  FileName: string;
begin
  FileName := PString(ListBox3.Items.Objects[ListBox3.ItemIndex])^;
  DCMemo1.SyntaxParser := nil;
  DCMemo1.Lines.BeginUpdate;
  try
    try
      SyntaxParser1.SyntaxScheme.LoadFromFile(
        ProgPath + PathToSchemes + FileName + '.sch');
    except
      exit;
    end;
    if CheckBox2.Checked then
    try
      DCMemo1.LoadFromFile(ProgPath + PathToTexts + FileName + '.txt');
    except
      DCMemo1.Lines.Clear;
    end;
  finally
    DCMemo1.SyntaxParser := SyntaxParser1;
    DCMemo1.Lines.EndUpdate;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  with OpenDialog1 do
    if Execute then
      DCMemo1.LoadFromFile(FileName);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Application.CreateForm(TForm2, Form2);
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  EditedBlock.SingleLineCommentDelimiters[0].UseToken := CheckBox3.Checked;
  SyntaxParser2.SyntaxScheme.SchemeChanged;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  EditedBlock.MultiLineCommentDelimiters[0].UseToken := CheckBox5.Checked;
  SyntaxParser2.SyntaxScheme.SchemeChanged;
end;

procedure TForm1.CheckBox6Click(Sender: TObject);
begin
  with SyntaxParser1 do
  begin
    UseGlobalOptions := not UseGlobalOptions;
    if UseGlobalOptions then
      DCMemo1.Color := GlobalMemoOptions.TextStyles[0].Color
    else
      DCMemo1.Color := DefaultAttr.BackColor;
  end;
end;

procedure TForm1.EnumSet(const Str: string);
begin
  ComboBox1.Items.Add(Str);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  Proc: TTextStylesInitProc;
begin
  with SyntaxParser1 do
  try
    BeginUpdate;
    Proc := GetTextStylesInitProc(TCustomDCMemo, ComboBox1.Text);
    if Assigned(Proc) then
      with GlobalMemoOptions do
      try
        BeginUpdate;
        Proc(TextStyles);
        if TextStyles.Count > 0 then
          Color := TextStyles[0].Color;
      finally
        EndUpdate;
      end;

    if not UseGlobalOptions then
      DCMemo1.Color := DefaultAttr.BackColor;
  finally
    EndUpdate;
  end;
end;

end.
