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

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, dcmemo, ExtCtrls, dcstring, StdCtrls, dcparser, dcsystem,
  dcstdctl, Menus, editunit, dcidemem, Buttons, dcedit,
  dcConsts, dccommon, PropCB;

type
  TForm1 = class(TForm)
    MemoSource1: TMemoSource;
    StatusBar1: TStatusBar;
    OpenDialog1: TOpenDialog;
    Delphi: TDelphiParser;
    VBScript: TVBScriptParser;
    JScript: TJavaScriptParser;
    HTML: THTMLParser;
    SQL: TSqlParser;
    Perl: TPerlParser;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    FileNew: TMenuItem;
    FileOpen: TMenuItem;
    N8: TMenuItem;
    FileSave: TMenuItem;
    FileSaveas: TMenuItem;
    N10: TMenuItem;
    FileExit: TMenuItem;
    Edit2: TMenuItem;
    EditUndo: TMenuItem;
    EditRedo: TMenuItem;
    N7: TMenuItem;
    EditCut: TMenuItem;
    EditCopy: TMenuItem;
    EditPaste: TMenuItem;
    EditDelete: TMenuItem;
    EditSelectAll: TMenuItem;
    Search1: TMenuItem;
    SearchFind: TMenuItem;
    SearchReplace: TMenuItem;
    SearchSearchAgain: TMenuItem;
    IncrementalSearch1: TMenuItem;
    N12: TMenuItem;
    SearchGotoLine: TMenuItem;
    View1: TMenuItem;
    ViewClipboardHistory: TMenuItem;
    VerbDispatcher1: TVerbDispatcher;
    SaveDialog1: TSaveDialog;
    Panel1: TPanel;
    Bevel1: TBevel;
    Panel2: TPanel;
    DCMemo1: TDCMemo;
    DCSplitter1: TDCSplitter;
    Memo: TDCMemo;
    N1: TMenuItem;
    Print1: TMenuItem;
    N2: TMenuItem;
    EnvironmentOptions1: TMenuItem;
    Button1: TSpeedButton;
    Button2: TSpeedButton;
    DCPropEditor1: TComboBox;
    DCPropCheckBox1: TDCPropCheck;
    procedure MemoStateChange(Sender: TObject; State: TMemoStates);
    procedure FileOpenClick(Sender: TObject);
    procedure FileSaveClick(Sender: TObject);
    procedure FileSaveasClick(Sender: TObject);
    procedure FileExitClick(Sender: TObject);
    procedure EditUndoClick(Sender: TObject);
    procedure EditRedoClick(Sender: TObject);
    procedure EditCutClick(Sender: TObject);
    procedure EditCopyClick(Sender: TObject);
    procedure EditPasteClick(Sender: TObject);
    procedure EditDeleteClick(Sender: TObject);
    procedure EditSelectAllClick(Sender: TObject);
    procedure SearchFindClick(Sender: TObject);
    procedure SearchReplaceClick(Sender: TObject);
    procedure SearchSearchAgainClick(Sender: TObject);
    procedure SearchGotoLineClick(Sender: TObject);
    procedure FileNewClick(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DCPropEditor1Change(Sender: TObject);
  private
    { Private declarations }
    function GetActiveMemo:TDCMemo;
    procedure UpdateCombo;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.MemoStateChange(Sender: TObject; State: TMemoStates);
begin
  if not TDCMemo(Sender).Focused then
    exit;
  UpdateStatusBar(StatusBar1,TDCMemo(Sender),State);

  With StatusBar1,TDCMemo(Sender) do
  begin
    If msObjNameChanged in State then
    begin
      Self.Caption:=GetSource.ObjectName;
      if Self.Caption = '' then
        Self.Caption := 'Untitled';
    end;
  end;
end;

procedure TForm1.FileOpenClick(Sender: TObject);
var
  ext:string;
begin
  If OpenDialog1.Execute then
  begin
    MemoSource1.LoadFromFile(OpenDialog1.FileName);
    MemoSource1.ObjectName:=OpenDialog1.FileName;
    ext := UpperCase(ExtractFileExt(OpenDialog1.FileName));
    With Memo.GetSource do
      if ext = '.PAS' then
        SyntaxParser := Delphi
      else
      if ext = '.JS' then
        SyntaxParser := JScript
      else
      if (ext = '.VBS') or (ext='.BAS') then
        SyntaxParser := VBScript
      else
      if (ext = '.HTM') or (ext='.HTML') then
        SyntaxParser := HTML
      else
      if ext = '.SQL' then
        SyntaxParser := SQL
      else
      if ext = '.PL' then
        SyntaxParser := Perl
      else
        SyntaxParser := nil;
  end;
  UpdateCombo;
end;

procedure TForm1.FileSaveClick(Sender: TObject);
begin
  if MemoSource1.ObjectName<> '' then
  begin
    MemoSource1.SaveToFile(MemoSource1.ObjectName);
    MemoSource1.Modified := false;
  end else
        FileSaveasClick(Sender);
end;

procedure TForm1.FileSaveasClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    MemoSource1.ObjectName := SaveDialog1.FileName;
    MemoSource1.SaveToFile(MemoSource1.ObjectName);
    MemoSource1.Modified := false;
  end
end;

procedure TForm1.FileExitClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.EditUndoClick(Sender: TObject);
begin
  MemoSource1.Undo;
end;

procedure TForm1.EditRedoClick(Sender: TObject);
begin
  MemoSource1.Redo;
end;

procedure TForm1.EditCutClick(Sender: TObject);
begin
  MemoSource1.CutBlock;
end;

procedure TForm1.EditCopyClick(Sender: TObject);
begin
  MemoSource1.CopyBlock;
end;

procedure TForm1.EditPasteClick(Sender: TObject);
begin
  MemoSource1.PasteBlock;
end;

procedure TForm1.EditDeleteClick(Sender: TObject);
begin
  MemoSource1.DeleteBlock;
end;

procedure TForm1.EditSelectAllClick(Sender: TObject);
begin
  MemoSource1.SelectAll;
end;

procedure TForm1.SearchFindClick(Sender: TObject);
begin
  MemoSource1.ShowSearchDialog;
end;

procedure TForm1.SearchReplaceClick(Sender: TObject);
begin
  MemoSource1.ShowReplaceDialog;
end;

procedure TForm1.SearchSearchAgainClick(Sender: TObject);
begin
  MemoSource1.FindNext;
end;

procedure TForm1.SearchGotoLineClick(Sender: TObject);
begin
  MemoSource1.ShowGoToLineDialog;
end;

procedure TForm1.FileNewClick(Sender: TObject);
begin
  MemoSource1.Lines.Clear;
  MemoSource1.ObjectName := '';
  MemoSource1.Modified := false;
end;

procedure TForm1.Print1Click(Sender: TObject);
begin
  GetActiveMemo.PrintWithDialog;
end;

function TForm1.GetActiveMemo:TDCMemo;
begin
  If ActiveControl is TDCMemo then
    Result:=TDCMemo(ActiveControl)
  else
    Result:=DCMemo1;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  MemoSource1.ToggleBookmark(1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 DCMemo1.ToggleImageAndTextStyle(STxtStBreakPnt);
end;

procedure TForm1.UpdateCombo;
begin
  if Assigned(DCMemo1.SyntaxParser) then
    DCPropEditor1.ItemIndex := DCPropEditor1.Items.IndexOf(DCMemo1.SyntaxParser.Name)
  else
    DCPropEditor1.ItemIndex := -1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  UpdateCombo;
end;

procedure TForm1.DCPropEditor1Change(Sender: TObject);
begin
  if DCPropEditor1.Text = 'Delphi' then
    DCMemo1.SyntaxParser := Delphi
  else if DCPropEditor1.Text = 'HTML' then
    DCMemo1.SyntaxParser := HTML
  else if DCPropEditor1.Text = 'JScript' then
    DCMemo1.SyntaxParser := JScript
  else if DCPropEditor1.Text = 'Perl' then
    DCMemo1.SyntaxParser := Perl
  else if DCPropEditor1.Text = 'SQL' then
    DCMemo1.SyntaxParser := SQL
  else if DCPropEditor1.Text = 'VBScript' then
    DCMemo1.SyntaxParser := VBScript
  else
    DCMemo1.SyntaxParser := nil;
end;

end.
