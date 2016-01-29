unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, dxBar, StdCtrls, dxBarExtItems;

type
  TMainForm = class(TForm)
    BarManager: TdxBarManager;

    dxBarButtonNew: TdxBarButton;
    dxBarButtonOpen: TdxBarButton;
    dxBarButtonClose: TdxBarButton;
    dxBarButtonSave: TdxBarButton;
    dxBarButtonSaveAs: TdxBarButton;
    dxBarButtonPrint: TdxBarButton;
    dxBarButtonExit: TdxBarButton;
    dxBarButtonUndo: TdxBarButton;
    dxBarButtonCut: TdxBarButton;
    dxBarButtonCopy: TdxBarButton;
    dxBarButtonPaste: TdxBarButton;
    dxBarButtonClear: TdxBarButton;
    dxBarButtonSelectAll: TdxBarButton;
    dxBarButtonFind: TdxBarButton;
    dxBarButtonReplace: TdxBarButton;
    dxBarComboFontSize: TdxBarCombo;
    dxBarButtonBold: TdxBarButton;
    dxBarButtonItalic: TdxBarButton;
    dxBarButtonUnderline: TdxBarButton;
    dxBarButtonBullets: TdxBarButton;
    dxBarButtonProtected: TdxBarButton;
    dxBarButtonAlignLeft: TdxBarButton;
    dxBarButtonCenter: TdxBarButton;
    dxBarButtonAlignRight: TdxBarButton;
    dxBarButtonFont: TdxBarButton;

    dxBarButtonNewWindow: TdxBarButton;
    dxBarButtonArrangeAll: TdxBarButton;
    dxBarButtonNextWindow: TdxBarButton;
    dxBarButtonPreviousWindow: TdxBarButton;
    dxBarListWindows: TdxBarListItem;

    dxBarSubItemFile: TdxBarSubItem;
    dxBarSubItemEdit: TdxBarSubItem;
    dxBarSubItemFormat: TdxBarSubItem;
    dxBarSubItemWindow: TdxBarSubItem;
    dxBarSubItemHelp: TdxBarSubItem;

    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    FontDialog: TFontDialog;
    dxBarPopupMenu: TdxBarPopupMenu;
    dxBarButtonOnWeb: TdxBarButton;
    dxBarButtonEnhancedStyle: TdxBarButton;
    dxBarMRUFiles: TdxBarMRUListItem;
    dxBarButtonStdStyle: TdxBarButton;
    dxBarButtonFlatStyle: TdxBarButton;
    dxBarDockControl1: TdxBarDockControl;
    dxBarStaticEditor: TdxBarStatic;
    dxBarStaticStatus: TdxBarStatic;
    dxBarComboFontColor: TdxBarColorCombo;
    dxBarComboFontName: TdxBarFontNameCombo;
    dxBarGroup1: TdxBarGroup;

    procedure FormCreate(Sender: TObject);

    procedure dxBarButtonNewClick(Sender: TObject);
    procedure dxBarButtonOpenClick(Sender: TObject);
    procedure dxBarButtonCloseClick(Sender: TObject);
    procedure dxBarButtonSaveClick(Sender: TObject);
    procedure dxBarButtonSaveAsClick(Sender: TObject);
    procedure dxBarButtonPrintClick(Sender: TObject);
    procedure dxBarButtonExitClick(Sender: TObject);

    procedure dxBarButtonUndoClick(Sender: TObject);
    procedure dxBarButtonCutClick(Sender: TObject);
    procedure dxBarButtonCopyClick(Sender: TObject);
    procedure dxBarButtonPasteClick(Sender: TObject);
    procedure dxBarButtonClearClick(Sender: TObject);
    procedure dxBarButtonSelectAllClick(Sender: TObject);
    procedure dxBarButtonFindClick(Sender: TObject);
    procedure dxBarButtonReplaceClick(Sender: TObject);

    procedure dxBarComboFontNameChange(Sender: TObject);
    procedure dxBarComboFontSizeChange(Sender: TObject);
    procedure dxBarButtonBoldClick(Sender: TObject);
    procedure dxBarButtonItalicClick(Sender: TObject);
    procedure dxBarButtonUnderlineClick(Sender: TObject);
    procedure dxBarComboFontColorChange(Sender: TObject);
    procedure dxBarButtonBulletsClick(Sender: TObject);
    procedure dxBarButtonAlignClick(Sender: TObject);
    procedure dxBarButtonProtectedClick(Sender: TObject);
    procedure dxBarButtonFontClick(Sender: TObject);

    procedure dxBarButtonArrangeAllClick(Sender: TObject);
    procedure dxBarButtonNextWindowClick(Sender: TObject);
    procedure dxBarButtonPreviousWindowClick(Sender: TObject);
    procedure dxBarListWindowsGetData(Sender: TObject);
    procedure dxBarListWindowsClick(Sender: TObject);
    procedure dxBarButtonOnWebClick(Sender: TObject);
    procedure dxBarButtonEnhancedStyleClick(Sender: TObject);
    procedure dxBarMRUFilesClick(Sender: TObject);
    procedure dxBarButtonStdStyleClick(Sender: TObject);
    procedure dxBarButtonFlatStyleClick(Sender: TObject);
  private
    FUpdating: Boolean;

    function GetEditor: TRichEdit;
    function GetEditorCol: Integer;
    function GetEditorRow: Integer;
    function GetFileName: string;
    procedure SetFileName(Value: string);

    procedure FindOne(Sender: TObject);
    procedure ReplaceOne(Sender: TObject);
  public
    CreatedMDICount: Integer;

    procedure EditorChange(Sender: TObject);
    procedure EditorSelectionChange(Sender: TObject);
    function SaveFile(ASaveAs: Boolean): Boolean;
    procedure SetModified(Value: Boolean);
    procedure ShowItems(AShow: Boolean);

    property Editor: TRichEdit read GetEditor;
    property EditorCol: Integer read GetEditorCol;
    property EditorRow: Integer read GetEditorRow;
    property FileName: string read GetFileName write SetFileName;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

uses
  RichEdit, ShellAPI, Unit2;

const
  sRichEditFoundResultCaption = 'Information';
  sRichEditTextNotFound = 'The search text is not found.';
  sRichEditReplaceAllResult = 'Replaced %d occurances.';

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

function TMainForm.GetEditor: TRichEdit;
begin
  if ActiveMDIChild = nil then Result := nil
  else Result := TChildForm(ActiveMDIChild).Editor;
end;

function TMainForm.GetEditorCol: Integer;
begin
  with Editor do
    Result := SelStart - SendMessage(Handle, EM_LINEINDEX, EditorRow, 0);
end;

function TMainForm.GetEditorRow: Integer;
begin
  with Editor do
    Result := SendMessage(Handle, EM_LINEFROMCHAR, SelStart, 0);
end;

function TMainForm.GetFileName: string;
begin
  if ActiveMDIChild = nil then Result := ''
  else Result := TChildForm(ActiveMDIChild).FileName;
end;

procedure TMainForm.SetFileName(Value: string);
begin
  if ActiveMDIChild <> nil then
    TChildForm(ActiveMDIChild).FileName := Value;
end;

procedure TMainForm.FindOne(Sender: TObject);
var
  StartPos, FindLength, FoundAt: Integer;
  Flags: TSearchTypes;
  P: TPoint;
  CaretR, R, IntersectR: TRect;
begin
  with Editor, TFindDialog(Sender) do
  begin
    if frDown in Options then
    begin
      if SelLength = 0 then StartPos := SelStart
      else StartPos := SelStart + SelLength;
      FindLength := Length(Text) - StartPos;
    end
    else
    begin
      StartPos := SelStart;
      FindLength := -StartPos;
    end;
    Flags := [];
    if frMatchCase in Options then Include(Flags, stMatchCase);
    if frWholeWord in Options then Include(Flags, stWholeWord);
    Screen.Cursor := crHourglass;
    FoundAt := Editor.FindText(FindText, StartPos, FindLength, Flags);
    if not (frReplaceAll in Options) then Screen.Cursor := crDefault;
    if FoundAt > -1 then
      if frReplaceAll in Options then
      begin
        SelStart := FoundAt;
        SelLength := Length(FindText);
      end
      else
      begin
        SetFocus;
        SelStart := FoundAt;
        SelLength := Length(FindText);

        GetCaretPos(P);
        P := ClientToScreen(P);
        CaretR := Rect(P.X, P.Y, P.X + 2, P.Y + 20);
        GetWindowRect(Handle, R);
        if IntersectRect(IntersectR, CaretR, R) then
          if P.Y < Screen.Height div 2 then
            Top := P.Y + 40
          else
            Top := P.Y - (R.Bottom - R.Top + 20);
      end
    else
      if not (frReplaceAll in Options) then
        Application.MessageBox(sRichEditTextNotFound,
          sRichEditFoundResultCaption, MB_ICONINFORMATION);
  end;
end;

procedure TMainForm.ReplaceOne(Sender: TObject);
var
  ReplacedCount, OldSelStart, PrevSelStart: Integer;
  S: string;
begin
  with Editor, TReplaceDialog(Sender) do
  begin
    ReplacedCount := 0;
    OldSelStart := SelStart;
    if frReplaceAll in Options then
      Screen.Cursor := crHourglass;
    repeat
      if (SelLength > 0) and ((SelText = FindText) or
        (not (frMatchCase in Options) and
         (AnsiUpperCase(SelText) = AnsiUpperCase(FindText)))) then
      begin
        SelText := ReplaceText;
        Inc(ReplacedCount);
      end;
      PrevSelStart := SelStart;
      FindOne(Sender);
    until not (frReplaceAll in Options) or (SelStart = PrevSelStart);
    if frReplaceAll in Options then
    begin
      Screen.Cursor := crDefault;
      if ReplacedCount = 0 then S := sRichEditTextNotFound
      else
      begin
        SelStart := OldSelStart;
        S := Format(sRichEditReplaceAllResult, [ReplacedCount]);
      end;
      Application.MessageBox(PChar(S), sRichEditFoundResultCaption,
        MB_ICONINFORMATION);
    end;
  end;
end;

procedure TMainForm.EditorChange(Sender: TObject);
begin
  if Editor = nil then Exit;
  Editor.OnSelectionChange(Editor);
  SetModified(Editor.Modified);
  dxBarButtonUndo.Enabled := SendMessage(Editor.Handle, EM_CANUNDO, 0, 0) <> 0;
end;

procedure TMainForm.EditorSelectionChange(Sender: TObject);
begin
  with Editor, SelAttributes do
  begin
    FUpdating := True;
    dxBarComboFontSize.OnChange := nil;
    dxBarComboFontName.OnChange := nil;
    dxBarComboFontColor.OnChange := nil;
    try
       dxBarStaticEditor.Caption :=
         Format('Line: %3d   Col: %3d', [1 + EditorRow, 1 + EditorCol]);

       dxBarButtonCopy.Enabled := SelLength > 0;
       dxBarButtonCut.Enabled := dxBarButtonCopy.Enabled;
       dxBarButtonPaste.Enabled := SendMessage(Editor.Handle, EM_CANPASTE, 0, 0) <> 0;
       dxBarButtonClear.Enabled := dxBarButtonCopy.Enabled;

       dxBarComboFontSize.Text := IntToStr(Size);
       dxBarComboFontName.Text := Name;
       dxBarComboFontColor.Color := Color;

       dxBarButtonBold.Down := fsBold in Style;
       dxBarButtonItalic.Down := fsItalic in Style;
       dxBarButtonUnderline.Down := fsUnderline in Style;

       dxBarButtonBullets.Down := Boolean(Paragraph.Numbering);
       case Ord(Paragraph.Alignment) of
         0: dxBarButtonAlignLeft.Down := True;
         1: dxBarButtonAlignRight.Down := True;
         2: dxBarButtonCenter.Down := True;
       end;
       dxBarButtonProtected.Down := Protected;
    finally
      FUpdating := False;
      dxBarComboFontSize.OnChange := dxBarComboFontSizeChange;
      dxBarComboFontName.OnChange := dxBarComboFontNameChange;
      dxBarComboFontColor.OnChange := dxBarComboFontColorChange;
    end;
  end;
end;

function TMainForm.SaveFile(ASaveAs: Boolean): Boolean;
begin
  if ASaveAs or (FileName = '') then
  begin
    SaveDialog.FileName := FileName;
    Result := SaveDialog.Execute;
    if not Result then Exit;
    FileName := SaveDialog.FileName;
  end;
  Editor.Lines.SaveToFile(FileName);
  SetModified(False);
  Result := True;
end;

procedure TMainForm.SetModified(Value: Boolean);
begin
  Editor.Modified := Value;
  if Value then dxBarStaticStatus.Caption := 'Modified'
  else dxBarStaticStatus.Caption := '';
  dxBarButtonSave.Enabled := Value;
end;

procedure TMainForm.ShowItems(AShow: Boolean);
var
  AVisible: TdxBarItemVisible;
begin
  BarManager.LockUpdate := True;

  if not AShow then
  begin
    dxBarStaticEditor.Caption := '';
    dxBarStaticStatus.Caption := '';
  end;
  BarManager.Groups[0].Enabled := AShow;

  if AShow then AVisible := ivAlways
  else AVisible := ivInCustomizing;

  dxBarSubItemEdit.Visible := AVisible;
  dxBarSubItemFormat.Visible := AVisible;

  BarManager.LockUpdate := False;
end;

procedure TMainForm.FormCreate(Sender: TObject);
const
  Filter = 'Rich Text Files (*.RTF)|*.RTF';
begin
  OpenDialog.Filter := Filter;
  SaveDialog.Filter := Filter;
  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
  SaveDialog.InitialDir := OpenDialog.InitialDir;
  ShowItems(False);
end;

procedure TMainForm.dxBarButtonNewClick(Sender: TObject);
begin
  TChildForm.Create(Application);
end;

procedure TMainForm.dxBarButtonOpenClick(Sender: TObject);
begin
  OpenDialog.FileName := '';
  if OpenDialog.Execute then
  begin
    with TChildForm.Create(Application) do
    begin
      FileName := OpenDialog.FileName;
      Editor.Lines.LoadFromFile(FileName);
      SetModified(False);
    end;
    dxBarMRUFiles.RemoveItem(OpenDialog.FileName, nil);
  end;
end;

procedure TMainForm.dxBarButtonCloseClick(Sender: TObject);
begin
  ActiveMDIChild.Close;
end;

procedure TMainForm.dxBarButtonSaveClick(Sender: TObject);
begin
  SaveFile(False);
end;

procedure TMainForm.dxBarButtonSaveAsClick(Sender: TObject);
begin
  SaveFile(True);
end;

procedure TMainForm.dxBarButtonPrintClick(Sender: TObject);
begin
  if PrintDialog.Execute then Editor.Print(FileName);
end;

procedure TMainForm.dxBarButtonExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.dxBarButtonUndoClick(Sender: TObject);
begin
  SendMessage(Editor.Handle, EM_UNDO, 0, 0);
end;

procedure TMainForm.dxBarButtonCutClick(Sender: TObject);
begin
  Editor.CutToClipboard;
end;

procedure TMainForm.dxBarButtonCopyClick(Sender: TObject);
begin
  Editor.CopyToClipboard;
end;

procedure TMainForm.dxBarButtonPasteClick(Sender: TObject);
begin
  Editor.PasteFromClipboard;
end;

procedure TMainForm.dxBarButtonClearClick(Sender: TObject);
begin
  Editor.ClearSelection;
end;

procedure TMainForm.dxBarButtonSelectAllClick(Sender: TObject);
begin
  Editor.SelectAll;
end;

procedure TMainForm.dxBarButtonFindClick(Sender: TObject);
begin
  with Editor do
  begin
    SelLength := 0;
    with TFindDialog.Create(Application) do
    begin
      Options := Options + [frHideUpDown];
      OnFind := FindOne;
      Execute;
    end;
  end;
end;

procedure TMainForm.dxBarButtonReplaceClick(Sender: TObject);
begin
  with Editor do
  begin
    SelLength := 0;
    with TReplaceDialog.Create(Application) do
    begin
      OnFind := FindOne;
      OnReplace := ReplaceOne;
      Execute;
    end;
  end;
end;

procedure TMainForm.dxBarComboFontNameChange(Sender: TObject);
begin
  if not FUpdating then
    Editor.SelAttributes.Name := dxBarComboFontName.Text;
end;

procedure TMainForm.dxBarComboFontSizeChange(Sender: TObject);
begin
  if not FUpdating then
    Editor.SelAttributes.Size := StrToInt(dxBarComboFontSize.Text);
end;

procedure TMainForm.dxBarButtonBoldClick(Sender: TObject);
begin
  with Editor.SelAttributes do
    if dxBarButtonBold.Down then
      Style := Style + [fsBold]
    else
      Style := Style - [fsBold];
end;

procedure TMainForm.dxBarButtonItalicClick(Sender: TObject);
begin
  with Editor.SelAttributes do
    if dxBarButtonItalic.Down then
      Style := Style + [fsItalic]
    else
      Style := Style - [fsItalic];
end;

procedure TMainForm.dxBarButtonUnderlineClick(Sender: TObject);
begin
  with Editor.SelAttributes do
    if dxBarButtonUnderline.Down then
      Style := Style + [fsUnderline]
    else
      Style := Style - [fsUnderline];
end;

procedure TMainForm.dxBarComboFontColorChange(Sender: TObject);
begin
  Editor.SelAttributes.Color := dxBarComboFontColor.Color;
end;

procedure TMainForm.dxBarButtonBulletsClick(Sender: TObject);
begin
  Editor.Paragraph.Numbering := TNumberingStyle(dxBarButtonBullets.Down);
end;

procedure TMainForm.dxBarButtonAlignClick(Sender: TObject);
begin
  if TdxBarButton(Sender).Down then
    Editor.Paragraph.Alignment := TAlignment(TdxBarButton(Sender).Tag)
  else
    Editor.Paragraph.Alignment := taLeftJustify;
end;

procedure TMainForm.dxBarButtonProtectedClick(Sender: TObject);
begin
  with Editor.SelAttributes do Protected := not Protected;
end;

procedure TMainForm.dxBarButtonFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(Editor.SelAttributes);
  if FontDialog.Execute then
    Editor.SelAttributes.Assign(FontDialog.Font);
end;

procedure TMainForm.dxBarButtonArrangeAllClick(Sender: TObject);
begin
  Tile;
end;

procedure TMainForm.dxBarButtonNextWindowClick(Sender: TObject);
begin
  Next;
end;

procedure TMainForm.dxBarButtonPreviousWindowClick(Sender: TObject);
begin
  Previous;
end;

procedure TMainForm.dxBarListWindowsGetData(Sender: TObject);
begin
  with dxBarListWindows do
    ItemIndex := Items.IndexOfObject(ActiveMDIChild);
end;

procedure TMainForm.dxBarListWindowsClick(Sender: TObject);
begin
  with dxBarListWindows do
    TCustomForm(Items.Objects[ItemIndex]).Show;
end;

procedure TMainForm.dxBarButtonOnWebClick(Sender: TObject);
begin
  ShellExecute(0, nil, 'http://www.devexpress.com', nil, nil, SW_RESTORE);
end;

procedure TMainForm.dxBarButtonEnhancedStyleClick(Sender: TObject);
begin
  BarManager.Style := bmsEnhanced
end;

procedure TMainForm.dxBarMRUFilesClick(Sender: TObject);
var
  AFileName: String;
begin
  AFileName := dxBarMRUFiles.Items[dxBarMRUFiles.ItemIndex];
  if FileExists(AFileName) then
    with TChildForm.Create(Application) do
    begin
      FileName := AFileName;
      Editor.Lines.LoadFromFile(FileName);
      SetModified(False);
    end
  else
    Application.MessageBox(PChar(AFileName+#10#13+'File not found.'),'Open',MB_OK or MB_ICONERROR)
end;

procedure TMainForm.dxBarButtonStdStyleClick(Sender: TObject);
begin
  BarManager.Style := bmsStandard;
end;

procedure TMainForm.dxBarButtonFlatStyleClick(Sender: TObject);
begin
  BarManager.Style := bmsFlat;
end;

end.
