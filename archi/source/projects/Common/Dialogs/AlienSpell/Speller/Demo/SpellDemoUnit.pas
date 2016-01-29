unit SpellDemoUnit;
//  TSpellChecker demo
//    Simple rich-text format editor with spelling check capability
//  Author: Alexander Obukhov
//
//    see comments in the listing to understand some
//    TSpellChecker methods and properties

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Spellers, Menus, StdCtrls, ToolWin, RXCtrls, ClipBrd, RichEdit,
  Langs, RxCombos;

type
  TSpellDemoForm = class(TForm)
    MainToolBar: TToolBar;
    RichEdit: TRichEdit;
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    Speller: TSpellChecker;
    NewBtn: TToolButton;
    OpenBtn: TToolButton;
    SaveBtn: TToolButton;
    ToolButton4: TToolButton;
    CutBtn: TToolButton;
    CopyBtn: TToolButton;
    PasteBtn: TToolButton;
    ToolButton8: TToolButton;
    FindBtn: TToolButton;
    ReplaceBtn: TToolButton;
    ToolButton11: TToolButton;
    SpellBtn: TToolButton;
    Images: TImageList;
    UndoBtn: TToolButton;
    ToolButton14: TToolButton;
    FileMI: TMenuItem;
    EditMI: TMenuItem;
    AboutMI: TMenuItem;
    NewMI: TMenuItem;
    OpenMI: TMenuItem;
    SaveMI: TMenuItem;
    N1: TMenuItem;
    SaveAsMI: TMenuItem;
    N2: TMenuItem;
    ExitMI: TMenuItem;
    CutMI: TMenuItem;
    CopyMI: TMenuItem;
    PasteMI: TMenuItem;
    N3: TMenuItem;
    FindMI: TMenuItem;
    ReplaceMI: TMenuItem;
    LanguageMI: TMenuItem;
    N4: TMenuItem;
    SpellMI: TMenuItem;
    ExitBtn: TToolButton;
    ToolButton2: TToolButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ToolButton3: TToolButton;
    PrintBtn: TToolButton;
    N5: TMenuItem;
    PrintMI: TMenuItem;
    CoolBar: TCoolBar;
    FmtToolBar: TToolBar;
    FontSize: TComboBox;
    ToolButton6: TToolButton;
    BoldBtn: TToolButton;
    ToolButton9: TToolButton;
    ItalicBtn: TToolButton;
    ToolButton10: TToolButton;
    ColorCombo: TColorComboBox;
    UndrlBtn: TToolButton;
    UndoMI: TMenuItem;
    N6: TMenuItem;
    SelectAllMI: TMenuItem;
    N7: TMenuItem;
    FindDialog: TFindDialog;
    ReplaceDialog: TReplaceDialog;
    PrintSetupMI: TMenuItem;
    PrinterSetupDialog: TPrinterSetupDialog;
    FontCombo: TComboBox;
    VariantsMenu: TPopupMenu;
    ToolButton1: TToolButton;
    LeftBtn: TToolButton;
    CenterBtn: TToolButton;
    RightBtn: TToolButton;
    ToolButton13: TToolButton;
    BulletsBtn: TToolButton;
    procedure NewMIClick(Sender: TObject);
    procedure SelectAllMIClick(Sender: TObject);
    procedure CutMIClick(Sender: TObject);
    procedure CopyMIClick(Sender: TObject);
    procedure PasteMIClick(Sender: TObject);
    procedure FindMIClick(Sender: TObject);
    procedure ReplaceMIClick(Sender: TObject);
    procedure SaveMIClick(Sender: TObject);
    procedure SaveAsMIClick(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure ReplaceDialogReplace(Sender: TObject);
    procedure UndoMIClick(Sender: TObject);
    procedure ExitMIClick(Sender: TObject);
    procedure LangMIClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PrintMIClick(Sender: TObject);
    procedure RichEditChange(Sender: TObject);
    procedure RichEditSelectionChange(Sender: TObject);
    procedure OpenMIClick(Sender: TObject);
    procedure PrintSetupMIClick(Sender: TObject);
    procedure FontSizeKeyPress(Sender: TObject; var Key: Char);
    procedure FontComboChange(Sender: TObject);
    procedure BoldBtnClick(Sender: TObject);
    procedure ItalicBtnClick(Sender: TObject);
    procedure UndrlBtnClick(Sender: TObject);
    procedure ColorComboChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FontSizeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FontSizeChange(Sender: TObject);
    procedure FontSizeDropDown(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure VariantsMenuPopup(Sender: TObject);
    procedure RichEditMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpellMIClick(Sender: TObject);
    procedure VariantMIClick(Sender: TObject);
    procedure LeftBtnClick(Sender: TObject);
    procedure CenterBtnClick(Sender: TObject);
    procedure RightBtnClick(Sender: TObject);
    procedure BulletsBtnClick(Sender: TObject);
    procedure AboutMIClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FChanged: Boolean;
    FFileName: String;
    FIsNew: Boolean;
    WasDropped: Boolean;
    procedure UpdateButtons;
    procedure ExecSave;
    procedure ExecSaveAs;
    procedure ExecLoad;
    procedure ExecNew;
    procedure CheckForSave;
    procedure SetChanged(Value: Boolean);
    procedure SetFileName(Value: String);
    property IsChanged: Boolean read FChanged write SetChanged;
    property FileName: String read FFileName write SetFileName;
    property IsNew: Boolean read FIsNew write FIsNew;
  public
    { Public declarations }
  end;

var
  SpellDemoForm: TSpellDemoForm;

implementation

uses AboutUnit;

{$R *.DFM}

const
  Counter: Integer = 0;

procedure TSpellDemoForm.UpdateButtons;
begin
  CopyBtn.Enabled:= RichEdit.SelLength>0;
  CutBtn.Enabled:= RichEdit.SelLength>0;
  FindBtn.Enabled:= RichEdit.Lines.Count>0;
  ReplaceBtn.Enabled:= RichEdit.Lines.Count>0;
  PasteBtn.Enabled:= Clipboard.HasFormat(CF_Text);
  UndoBtn.Enabled:= Boolean(SendMessage(RichEdit.Handle, EM_CANUNDO, 0, 0));
  CopyMI.Enabled:= CopyBtn.Enabled;
  CutMI.Enabled:= CutBtn.Enabled;
  FindMI.Enabled:= FindBtn.Enabled;
  ReplaceMI.Enabled:= ReplaceBtn.Enabled;
  PasteMI.Enabled:= PasteBtn.Enabled;
  UndoMI.Enabled:= UndoBtn.Enabled;
end;

procedure TSpellDemoForm.ExecSave;
begin
  if IsNew then
    ExecSaveAs
  else
    begin
      RichEdit.Lines.SaveToFile(FileName);
      IsChanged:= False;
    end;
end;

procedure TSpellDemoForm.ExecSaveAs;
begin
  SaveDialog.FileName:= FileName;
  if SaveDialog.Execute then
    begin
      RichEdit.Lines.SaveToFile(FileName);
      IsNew:= False;
      IsChanged:= False;
    end;
end;

procedure TSpellDemoForm.ExecLoad;
begin
  CheckForSave;
  OpenDialog.FileName:= '';
  if OpenDialog.Execute then
    begin
      FileName:= OpenDialog.FileName;
      RichEdit.Lines.LoadFromFile(FileName);
      IsNew:= False;
      IsChanged:= False;
      RichEditSelectionChange(Self);
    end;
end;

procedure TSpellDemoForm.ExecNew;
begin
  CheckForSave;
  Inc(Counter);
  FileName:= 'Document'+IntToStr(Counter)+'.rtf';
  RichEdit.Clear;
  RichEditSelectionChange(Self);
  IsNew:= True;
  IsChanged:= False;
end;

procedure TSpellDemoForm.CheckForSave;
var
  Res: Integer;
begin
  if not IsChanged then
    Exit;
  Res:= MessageBox(Handle, 'File is modified. Save before closing?',
                   'Warning', mb_YesNoCancel+mb_IconQuestion);
  if Res=id_Cancel then
    Abort;
  if Res=id_Yes then
    ExecSave;
end;

procedure TSpellDemoForm.SetChanged(Value: Boolean);
begin
  FChanged:= Value;
  if Value then
    StatusBar.SimpleText:= 'Modified'
  else
    StatusBar.SimpleText:= '';
end;

procedure TSpellDemoForm.SetFileName(Value: String);
begin
  FFileName:= Value;
  Caption:= 'TSpellChecker demo - '+Value;
end;

procedure TSpellDemoForm.AboutMIClick(Sender: TObject);
begin
  AboutForm.ShowModal;
end;

procedure TSpellDemoForm.FormShow(Sender: TObject);
begin
  AboutForm.ShowModal;
end;

procedure TSpellDemoForm.NewMIClick(Sender: TObject);
begin
  RichEdit.Clear;
end;

procedure TSpellDemoForm.SelectAllMIClick(Sender: TObject);
begin
  RichEdit.SelectAll;
  UpdateButtons;
end;

procedure TSpellDemoForm.CutMIClick(Sender: TObject);
begin
  RichEdit.CutToClipboard;
  IsChanged:= True;
  UpdateButtons;
end;

procedure TSpellDemoForm.CopyMIClick(Sender: TObject);
begin
  RichEdit.CopyToClipboard;
  UpdateButtons;
end;

procedure TSpellDemoForm.PasteMIClick(Sender: TObject);
begin
  RichEdit.PasteFromClipboard;
  IsChanged:= True;
  UpdateButtons;
end;

procedure TSpellDemoForm.FindMIClick(Sender: TObject);
begin
  FindDialog.Execute;
end;

procedure TSpellDemoForm.ReplaceMIClick(Sender: TObject);
begin
  ReplaceDialog.Execute;
end;

procedure TSpellDemoForm.SaveMIClick(Sender: TObject);
begin
  ExecSave;
end;

procedure TSpellDemoForm.SaveAsMIClick(Sender: TObject);
begin
  ExecSaveAs;
end;

procedure TSpellDemoForm.FindDialogFind(Sender: TObject);
var
  SearchStart: Integer;
  FS: TFindTextExA;
  Flags: Integer;
  Buf: array[0..255]of Char;
begin
  with TFindDialog(Sender) do
  begin
    if (frFindNext in Options) then
      SearchStart:= RichEdit.SelStart+RichEdit.SelLength
    else
      SearchStart:= RichEdit.SelStart;
    FS.chrg.cpMin:= SearchStart;
    FS.chrg.cpMax:= -1;
    StrPCopy(Buf, FindText);
    FS.lpstrText:= Buf;
    if (frMatchCase in Options) then
      Flags:= FT_MATCHCASE
    else
      Flags:= 0;
    if (frWholeWord in Options) then
      Flags:= Flags or FT_WHOLEWORD;
    if (SendMessage(RichEdit.Handle, EM_FINDTEXTEX, Flags, Integer(@FS))>0) then
      begin
        RichEdit.SelStart := FS.chrgText.cpMin;
        RichEdit.SelLength := FS.chrgText.cpMax - FS.chrgText.cpMin;
        UpdateButtons;
      end
    else
      MessageBox(Handle, PChar(Format('Text «%s» not found', [FindText])), 'Message',
                 mb_Ok+mb_IconInformation);
  end;
end;

procedure TSpellDemoForm.ReplaceDialogReplace(Sender: TObject);
var
  SearchStart: Integer;
  ReplCount: Integer;
  FS: TFindTextExA;
  Flags: Integer;
  Buf: array[0..255]of Char;
begin
  with TReplaceDialog(Sender) do
  begin
    if (frReplaceAll in Options) then
      begin
        ReplCount:= 0;
        FS.chrg.cpMin:= RichEdit.SelStart;
        FS.chrg.cpMax:= -1;
        StrPCopy(Buf, FindText);
        FS.lpstrText:= Buf;
        if (frMatchCase in Options) then
          Flags:= FT_MATCHCASE
        else
          Flags:= 0;
        if (frWholeWord in Options) then
          Flags:= Flags or FT_WHOLEWORD;
        while (SendMessage(RichEdit.Handle, EM_FINDTEXTEX, Flags, Integer(@FS))>-1) do
          begin
            RichEdit.SelStart := FS.chrgText.cpMin;
            RichEdit.SelLength := FS.chrgText.cpMax - FS.chrgText.cpMin;
            RichEdit.SelText:= ReplaceText;
            UpdateButtons;
            Inc(ReplCount);
            FS.chrg.cpMin:= RichEdit.SelStart+Length(ReplaceText);
          end;
        MessageBox(Handle, PChar(Format('%d replaces were made', [ReplCount])), 'Message',
                   mb_Ok+mb_IconInformation);
      end
    else
      begin
        if (frFindNext in Options) then
          SearchStart:= RichEdit.SelStart+RichEdit.SelLength
        else
          SearchStart:= RichEdit.SelStart;
        FS.chrg.cpMin:= SearchStart;
        FS.chrg.cpMax:= -1;
        StrPCopy(Buf, FindText);
        FS.lpstrText:= Buf;
        if (frMatchCase in Options) then
          Flags:= FT_MATCHCASE
        else
          Flags:= 0;
        if (frWholeWord in Options) then
          Flags:= Flags or FT_WHOLEWORD;
        if (SendMessage(RichEdit.Handle, EM_FINDTEXTEX, Flags, Integer(@FS))>-1) then
          begin
            RichEdit.SelStart := FS.chrgText.cpMin;
            RichEdit.SelLength := FS.chrgText.cpMax - FS.chrgText.cpMin;
            RichEdit.SelText:= ReplaceText;
            UpdateButtons;
          end
        else
          MessageBox(Handle, PChar(Format('Text «%s» not found', [FindText])), 'Message',
                     mb_Ok+mb_IconInformation);
      end;
  end;
end;

procedure TSpellDemoForm.UndoMIClick(Sender: TObject);
begin
  SendMessage(RichEdit.Handle, EM_UNDO, 0, 0);
  SendMessage(RichEdit.Handle, EM_EMPTYUNDOBUFFER, 0, 0);
  UpdateButtons;
end;

procedure TSpellDemoForm.ExitMIClick(Sender: TObject);
begin
  Close;
end;

procedure TSpellDemoForm.FormCreate(Sender: TObject);
var
  Langs: TStringList;
  MI: TMenuItem;
  I: Integer;
begin
  WasDropped:= False;
  FontCombo.Items.Assign(Screen.Fonts);
  FontCombo.ItemIndex:= FontCombo.Items.IndexOf('Arial');
  Langs:= TStringList.Create;
//Get list of installed spell-checkers
  GetSpellLanguages(Langs, loLocalized);
  Langs.Sort;
// Fills Language menu with names of installed spell-checkers
  for I:= 0 to Langs.Count-1 do
    begin
      MI:= TMenuItem.Create(LanguageMI);
// Takes name of spell-checker
      MI.Caption:= Langs[I];
// Takes spell-checker language
      MI.Tag:= Integer(Langs.Objects[I]);
      MI.GroupIndex:= 1;
      MI.RadioItem:= True;
      MI.Checked:= MI.Tag=langEnglishUS;
      MI.OnClick:= LangMIClick;
      LanguageMI.Add(MI);
    end;
  Langs.Free;
  ExecNew;
  UpdateButtons;
end;

procedure TSpellDemoForm.PrintMIClick(Sender: TObject);
begin
  RichEdit.Print(Caption);
end;

procedure TSpellDemoForm.RichEditChange(Sender: TObject);
begin
  IsChanged:= True;
  UpdateButtons;
end;

procedure TSpellDemoForm.RichEditSelectionChange(Sender: TObject);
var
  L: TLanguage;
  S: String;
begin
  L:= GetThreadLocale;
  S:= IntToStr(L);
  UpdateButtons;
  with RichEdit.SelAttributes do
    begin
      FontCombo.ItemIndex:= FontCombo.Items.IndexOf(Name);
      FontSize.Text:= IntToStr(Size);
      BoldBtn.Down:= fsBold in Style;
      ItalicBtn.Down:= fsItalic in Style;
      UndrlBtn.Down:= fsUnderline in Style;
      ColorCombo.Selected:= Color;
    end;
  with RichEdit.Paragraph do
    begin
      BulletsBtn.Down:= Numbering=nsBullet;
      LeftBtn.Down:= Alignment=taLeftJustify;
      CenterBtn.Down:= Alignment=taCenter;
      RightBtn.Down:= Alignment=taRightJustify;
    end;
end;

procedure TSpellDemoForm.OpenMIClick(Sender: TObject);
begin
  ExecLoad;
end;

procedure TSpellDemoForm.PrintSetupMIClick(Sender: TObject);
begin
  PrinterSetupDialog.Execute;
end;

procedure TSpellDemoForm.FontSizeKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#1..#31, '0'..'9']) then
    Key:= #0;
end;

procedure TSpellDemoForm.FontComboChange(Sender: TObject);
begin
  RichEdit.SelAttributes.Name:= FontCombo.Text;
  ActiveControl:= RichEdit;
end;

procedure TSpellDemoForm.BoldBtnClick(Sender: TObject);
begin
  if BoldBtn.Down then
    RichEdit.SelAttributes.Style:= RichEdit.SelAttributes.Style+[fsBold]
  else
    RichEdit.SelAttributes.Style:= RichEdit.SelAttributes.Style-[fsBold];
end;

procedure TSpellDemoForm.ItalicBtnClick(Sender: TObject);
begin
  if ItalicBtn.Down then
    RichEdit.SelAttributes.Style:= RichEdit.SelAttributes.Style+[fsItalic]
  else
    RichEdit.SelAttributes.Style:= RichEdit.SelAttributes.Style-[fsItalic];
end;

procedure TSpellDemoForm.UndrlBtnClick(Sender: TObject);
begin
  if UndrlBtn.Down then
    RichEdit.SelAttributes.Style:= RichEdit.SelAttributes.Style+[fsUnderline]
  else
    RichEdit.SelAttributes.Style:= RichEdit.SelAttributes.Style-[fsUnderline];
end;

procedure TSpellDemoForm.ColorComboChange(Sender: TObject);
begin
  RichEdit.SelAttributes.Color:= ColorCombo.Selected;
  ActiveControl:= RichEdit;
end;

procedure TSpellDemoForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CheckForSave;
end;

procedure TSpellDemoForm.FontSizeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return then
    begin
      RichEdit.SelAttributes.Size:= StrToInt(FontSize.Text);
      ActiveControl:= RichEdit;
    end;
end;

procedure TSpellDemoForm.FontSizeChange(Sender: TObject);
begin
  if WasDropped then
    begin
      RichEdit.SelAttributes.Size:= StrToInt(FontSize.Text);
      ActiveControl:= RichEdit;
      WasDropped:= False;
    end;
end;

procedure TSpellDemoForm.FontSizeDropDown(Sender: TObject);
begin
  WasDropped:= True;
end;

procedure TSpellDemoForm.LeftBtnClick(Sender: TObject);
begin
  RichEdit.Paragraph.Alignment:= taLeftJustify;
end;

procedure TSpellDemoForm.CenterBtnClick(Sender: TObject);
begin
  RichEdit.Paragraph.Alignment:= taCenter;
end;

procedure TSpellDemoForm.RightBtnClick(Sender: TObject);
begin
  RichEdit.Paragraph.Alignment:= taRightJustify;
end;

procedure TSpellDemoForm.BulletsBtnClick(Sender: TObject);
begin
  if BulletsBtn.Down then
    RichEdit.Paragraph.Numbering:= nsBullet
  else
    RichEdit.Paragraph.Numbering:= nsNone;
end;

procedure TSpellDemoForm.FormDestroy(Sender: TObject);
begin
// Closes speller
  if Speller.Active then
    Speller.Close;
end;

// Changes speller language
procedure TSpellDemoForm.LangMIClick(Sender: TObject);
var
  MI: TMenuItem;
begin
  MI:= Sender as TMenuItem;
  MI.Checked:= True;
// To change language speller must be closed
  if Speller.Active then
    Speller.Close;
// Sets new language from selected menu item
  Speller.Language:= MI.Tag;
end;

procedure TSpellDemoForm.VariantsMenuPopup(Sender: TObject);
var
  I: Integer;
  Variants: TStringList;
  MI: TMenuItem;
begin
  for I:= VariantsMenu.Items.Count-1 downto 0 do
    VariantsMenu.Items.Delete(I);
// To make some work speller must be opened
  if not Speller.Active then
    Speller.Open;
// Checks selected word with current language
// If word is unknown then populates VariantsMenu with alternatives
  if not Speller.IsKnownWord(RichEdit.SelText) then
    begin
      MI:= TMenuItem.Create(VariantsMenu);
      MI.Caption:= 'Spelling';
      MI.ShortCut:= TextToShortCut('F7');
      MI.OnClick:= SpellMIClick;
      VariantsMenu.Items.Add(MI);
      Variants:= TStringList.Create;
//Get list of alternatives into  Variants
      Speller.GetVariants(RichEdit.SelText, Variants);
      if Variants.Count>0 then
        begin
          MI:= TMenuItem.Create(VariantsMenu);
          MI.Caption:= '-';
          VariantsMenu.Items.Add(MI);
        end;
      for I:= 0 to Variants.Count-1 do
        begin
          MI:= TMenuItem.Create(VariantsMenu);
          MI.Caption:= Variants[I];
          MI.OnClick:= VariantMIClick;
          VariantsMenu.Items.Add(MI);
        end;
      Variants.Free;
    end;
end;

procedure TSpellDemoForm.RichEditMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
// When right-clicking selects word under mouse cursor
  if Button=mbRight then
    SendMessage(RichEdit.Handle, WM_LBUTTONDBLCLK, MK_LBUTTON, Y shl 16 +X);
end;

procedure TSpellDemoForm.SpellMIClick(Sender: TObject);
begin
// To make some work speller must be opened
  if not Speller.Active then
    Speller.Open;
// Executes interactive spell checking
  Speller.CheckMemo(RichEdit);
end;

procedure TSpellDemoForm.VariantMIClick(Sender: TObject);
begin
// Replaces selected word with alterntive from popup menu
  RichEdit.SelText:= (Sender as TMenuItem).Caption;
end;

end.
