{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcEditorOpt;

interface
{$I dc.inc}
uses
  dcdreamLib, Messages, Forms, StdCtrls, Controls, Classes;

type
  TEditorOptForm = class(TForm)
    EditOptGroup: TGroupBox;
    AutoIndentChk: TCheckBox;
    SmartTabChk: TCheckBox;
    BackUnindentChk: TCheckBox;
    PersistentBlockChk: TCheckBox;
    OverwriteBlockChk: TCheckBox;
    DblClickEdit: TCheckBox;
    FindTextChk: TCheckBox;
    CutCopyEnabledChk: TCheckBox;
    SyntaxHighlightChk: TCheckBox;
    OverCaretChk: TCheckBox;
    DisDragChk: TCheckBox;
    MemoEnvOptions: TCheckBox;
    MemoEnvOptions1: TCheckBox;
    GroupUndoChk: TCheckBox;
    CursorEofChk: TCheckBox;
    BeyondEolChk: TCheckBox;
    SelectEolChk: TCheckBox;
    BlockIndentLbl: TLabel;
    BlockIndentEdit: TEdit;
    TabStopLbl: TLabel;
    TabStopsEdit: TEdit;
    KeyMapLbl: TLabel;
    KeymapEdit: TComboBox;
    KeepTrailingBlanksChk: TCheckBox;
    UseTabCharBox: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure MemoEnvOptionsClick(Sender: TObject);
    procedure ItemChange(Sender: TObject);
    procedure SmartTabChkClick(Sender: TObject);
    procedure UseTabCharBoxClick(Sender: TObject);
  private
    Modified: Boolean;
    procedure CMApplyOptions(var Msg: TMessage); message CM_APPLYOPTIONS;
  end;

var
  EditorOptForm: TEditorOptForm;

implementation

uses SysUtils, dcMemOpt, dcSystem, dcCommon, dcConsts, dcMemo, dcString;

{$R *.DFM}

procedure TEditorOptForm.FormCreate(Sender: TObject);
var
  List: TList;
  i: integer;
begin
  SetFormFont(self);
  Caption := SEditor;
  EditOptGroup.Caption := SEditorOptions;

  with FMemoOptions do
  begin
    MemoEnvOptions.Caption := SShowLineNumbers;
    MemoEnvOptions.Checked := moLineNumbers in Options;
    MemoEnvOptions1.Caption := SShowLineNumbersOnGutter;
    MemoEnvOptions1.Checked := moLineNumbersOnGutter in Options;
    MemoEnvOptionsClick(nil);
    SelectEolChk.Caption := SSelectionByondEol;
    SelectEolChk.Checked := not (moSelectOnlyText in Options);
    //SpecialCharsChk.Caption := sDisplaySpecialChars;
    //SpecialCharsChk.Checked := moDrawSpecialSymbols in Options;
    DblClickEdit.Caption := SDblClickLine;
    DblClickEdit.Checked := moDblClickLine in Options;
    SyntaxHighlightChk.Caption := SSyntaxHighlighting;
    SyntaxHighlightChk.Checked := moColorSyntax in Options;
    OverCaretChk.Caption := SOverCaretBlock;
    OverCaretChk.Checked := moOverwriteCaret in Options;
    DisDragChk.Caption := SDisableDrag;
    DisDragChk.Checked := moDisableDrag in Options;
    KeyMapLbl.Caption := SKeyMappings;
    List := TList.Create;
    try
      GetRegisteredClasses(TObject, List);
      with List do
        for i := 0 to Count - 1 do
          if TObjectParamListItem(Items[i]).Params[SParKeyboardID] = SParKeyboardID then
            KeymapEdit.Items.Add(TObjectParamListItem(Items[i]).Params[SParKeyboardInitName]);
    finally
      List.Free;
    end;
    KeymapEdit.ItemIndex := KeymapEdit.Items.IndexOf(KeyMapping);
  end;
  with GlobalMemoSourceOptions do
  begin
    AutoIndentChk.Caption := SAutoIndentMode;
    AutoIndentChk.Checked := soAutoIndent in Options;
    SmartTabChk.Caption := SSmartTab;
    UseTabCharBox.Caption := sUseTabChar;
    SmartTabChk.Checked := soSmartTab in Options;
    UseTabCharBox.Checked := soUseTabCharacter in Options;
    BackUnindentChk.Caption := SBackUnindents;
    BackUnindentChk.Checked := soBackUnindents in Options;
    GroupUndoChk.Caption := SGroupUndo;
    GroupUndoChk.Checked := soGroupUndo in Options;
    CursorEofChk.Caption := SCursorBeyondEof;
    CursorEofChk.Checked := soBeyondFileEnd in Options;
    BeyondEolChk.Caption := SCursorByondEol;
    BeyondEolChk.Checked := not (soLimitEOL in Options);
    KeepTrailingBlanksChk.Caption := SKeepTrailingBlanks;
    KeepTrailingBlanksChk.Checked := KeepTrailingBlanks;
    PersistentBlockChk.Caption := SPersistentBlocks;
    PersistentBlockChk.Checked := soPersistentBlocks in Options;
    OverwriteBlockChk.Caption := SOverwriteBlocks;
    OverwriteBlockChk.Checked := soOverwriteBlocks in Options;
    FindTextChk.Caption := SFindTextAtCursor;
    FindTextChk.Checked := soFindTextAtCursor in Options;
    CutCopyEnabledChk.Caption := SCutCopyEnabled;
    CutCopyEnabledChk.Checked := soForceCutCopy in Options;
    BlockIndentLbl.Caption := SBlockIndent;
    BlockIndentEdit.Text := IntToStr(BlockIndent);
    TabStopLbl.Caption := STabStops;
    TabStopsEdit.Text := TabStops;
  end;
  Modified := False;
end;

procedure TEditorOptForm.MemoEnvOptionsClick(Sender: TObject);
begin
  MemoEnvOptions1.Enabled := MemoEnvOptions.Checked;
  ItemChange(Sender);
end;

procedure TEditorOptForm.CMApplyOptions(var Msg: TMessage);
var
  mo: TMemoOptions;
  so: TStringsOptions;
begin
  if not Modified then exit;
  mo := FMemoOptions.Options;
  if MemoEnvOptions.Checked then
    Include(mo, moLineNumbers)
  else
    Exclude(mo, moLineNumbers);
  if MemoEnvOptions1.Checked then
    Include(mo, moLineNumbersOnGutter)
  else
    Exclude(mo, moLineNumbersOnGutter);
  if not SelectEolChk.Checked then
    Include(mo, moSelectOnlyText)
  else
    Exclude(mo, moSelectOnlyText);
  {if SpecialCharsChk.Checked then
    Include(mo, moDrawSpecialSymbols)
  else
    Exclude(mo, moDrawSpecialSymbols);}
  if DblClickEdit.Checked then
    Include(mo, moDblClickLine)
  else
    Exclude(mo, moDblClickLine);
  if SyntaxHighlightChk.Checked then
    Include(mo, moColorSyntax)
  else
    Exclude(mo, moColorSyntax);
  if OverCaretChk.Checked then
    Include(mo, moOverwriteCaret)
  else
    Exclude(mo, moOverwriteCaret);
  if DisDragChk.Checked then
    Include(mo, moDisableDrag)
  else
    Exclude(mo, moDisableDrag);
  with FMemoOptions do
  begin
    Options := mo;
    KeyMapping := KeymapEdit.Text;
  end;
  FMemoOptions.ApplyOptions;

  so := GlobalMemoSourceOptions.Options;
  if AutoIndentChk.Checked then
    Include(so, soAutoIndent)
  else
    Exclude(so, soAutoIndent);
  if SmartTabChk.Checked then
    Include(so, soSmartTab)
  else
    Exclude(so, soSmartTab);
  if UseTabCharBox.Checked then
    Include(so, soUseTabCharacter)
  else
    Exclude(so, soUseTabCharacter);

  if BackUnindentChk.Checked then
    Include(so, soBackUnindents)
  else
    Exclude(so, soBackUnindents);
  if GroupUndoChk.Checked then
    Include(so, soGroupUndo)
  else
    Exclude(so, soGroupUndo);
  if CursorEofChk.Checked then
    Include(so, soBeyondFileEnd)
  else
    Exclude(so, soBeyondFileEnd);
  if not BeyondEolChk.Checked then
    Include(so, soLimitEOL)
  else
    Exclude(so, soLimitEOL);
  if PersistentBlockChk.Checked then
    Include(so, soPersistentBlocks)
  else
    Exclude(so, soPersistentBlocks);
  if OverwriteBlockChk.Checked then
    Include(so, soOverwriteBlocks)
  else
    Exclude(so, soOverwriteBlocks);
  if FindTextChk.Checked then
    Include(so, soFindTextAtCursor)
  else
    Exclude(so, soFindTextAtCursor);
  if CutCopyEnabledChk.Checked then
    Include(so, soForceCutCopy)
  else
    Exclude(so, soForceCutCopy);
  with GlobalMemoSourceOptions do
  begin
    Options := so;
    KeepTrailingBlanks := KeepTrailingBlanksChk.Checked;
    BlockIndent := StrToInt(BlockIndentEdit.Text);
    TabStops := TabStopsEdit.Text;
  end;
end;

procedure TEditorOptForm.ItemChange(Sender: TObject);
begin
  Modified := True;
end;

procedure TEditorOptForm.SmartTabChkClick(Sender: TObject);
begin
  Modified := True;
  if SmartTabChk.Checked then
    UseTabCharBox.Checked := false;
end;

procedure TEditorOptForm.UseTabCharBoxClick(Sender: TObject);
begin
  Modified := True;
  if UseTabCharBox.Checked then
    SmartTabChk.Checked  := false;
end;

end.
