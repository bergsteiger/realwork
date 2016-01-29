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
uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, ClipBrd,
  ToolWin, dccommon, dcmemo, dcedit, dcmenu, dcstring
  {$IFDEF D4}, ImgList{$ENDIF};

type
  TForm1 = class(TForm)
    MainMenu: TMainMenu;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    FilePrintItem: TMenuItem;
    FileExitItem: TMenuItem;
    EditUndoItem: TMenuItem;
    EditCutItem: TMenuItem;
    EditCopyItem: TMenuItem;
    EditPasteItem: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    FontDialog1: TFontDialog;
    N5: TMenuItem;
    miEditFont: TMenuItem;
    Editor: TDCMemo;
    StatusBar: TStatusBar;
    StandardToolBar: TToolBar;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    PrintButton: TToolButton;
    ToolButton5: TToolButton;
    UndoButton: TToolButton;
    CutButton: TToolButton;
    CopyButton: TToolButton;
    PasteButton: TToolButton;
    ToolButton10: TToolButton;
    FontName: TComboBox;
    FontSize: TComboBox;
    ToolButton11: TToolButton;
    BoldButton: TToolButton;
    ItalicButton: TToolButton;
    UnderlineButton: TToolButton;
    ToolbarImages: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    FontColor: TDCColorEdit;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    BackColor: TDCColorEdit;
    DCMenu1: TDCMenu;

    procedure SelectionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure FileNew(Sender: TObject);
    procedure FileOpen(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure FileSaveAs(Sender: TObject);
    procedure FilePrint(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure EditUndo(Sender: TObject);
    procedure EditCut(Sender: TObject);
    procedure EditCopy(Sender: TObject);
    procedure EditPaste(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure SelectFont(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BoldButtonClick(Sender: TObject);
    procedure ItalicButtonClick(Sender: TObject);
    procedure FontSizeChange(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure UnderlineButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure DCMemo1Change(Sender: TObject);
    procedure FontColorChange(Sender: TObject);
    procedure BackColorChange(Sender: TObject);
    procedure EditorStateChange(Sender: TObject; State: TMemoStates);
  private
    FFileName: string;
    FUpdating: Boolean;
    FSaveRTF: Boolean;
    function CurrText: TMemoAttributes;
    procedure GetFontNames;
    procedure SetFileName(const FileName: string);
    procedure CheckFileSave;
    procedure UpdateCursorPos;
    procedure PerformFileOpen(const AFileName: string);
    procedure SetModified(Value: Boolean);
    procedure UpdateCommands;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses ShellAPI;

resourcestring
  sSaveChanges = 'Save changes to %s?';
  sOverWrite = 'OK to overwrite %s';
  sUntitled = 'Untitled';
  sModified = 'Modified';
  sColRowInfo = 'Line: %3d   Col: %3d';

const
  GutterWid = 6;

procedure TForm1.UpdateCommands;
begin
  { Update the status of the edit commands }
  EditCutItem.Enabled := Editor.SelLength > 0;
  EditCopyItem.Enabled := EditCutItem.Enabled;
  CutButton.Enabled := EditCutItem.Enabled;
  CopyButton.Enabled := EditCutItem.Enabled;
  if Editor.HandleAllocated then
  begin
    EditUndoItem.Enabled := Editor.GetSource.UndoAvailable;
    UndoButton.Enabled := EditUndoItem.Enabled;
    EditPasteItem.Enabled := Editor.CanPaste;
    PasteButton.Enabled := EditPasteItem.Enabled;
  end;
end;  

procedure TForm1.SelectionChange(Sender: TObject);
begin
  try
    FUpdating := True;
    with Editor.SelAttributes do
    begin
      BoldButton.Down := fsBold in Style;
      ItalicButton.Down := fsItalic in Style;
      UnderlineButton.Down := fsUnderline in Style;
      FontSize.Text := IntToStr(Size);
      FontName.Text := Name;
      FontColor.SelectedColor := Color;
      BackColor.SelectedColor := BkColor;
    end;
    UpdateCursorPos;
    UpdateCommands;
  finally
    FUpdating := False;
  end;
end;

function TForm1.CurrText: TMemoAttributes;
begin
  Result := Editor.SelAttributes;
end;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

procedure TForm1.GetFontNames;
var
  DC: HDC;
begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontName.Items));
  ReleaseDC(0, DC);
  FontName.Sorted := True;
end;

procedure TForm1.SetFileName(const FileName: string);
begin
  FFileName := FileName;
  Caption := Format('%s - %s', [ExtractFileName(FileName), Application.Title]);
end;

procedure TForm1.CheckFileSave;
var
  SaveResp: Integer;
begin
  if not Editor.GetSource.Modified then Exit;
  SaveResp := MessageDlg(Format(sSaveChanges, [FFileName]),
    mtConfirmation, mbYesNoCancel, 0);
  case SaveResp of
    idYes: FileSave(Self);
    idNo: {Nothing}
      ;
    idCancel: Abort;
  end;
end;

{ Event Handlers }

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
  AFileName: string;
begin
  Application.Title := 'DCMemo Demo';
  Application.OnHint := ShowHint;
  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
  SaveDialog.InitialDir := OpenDialog.InitialDir;
  SetFileName(sUntitled);
  GetFontNames;
  with FontSize.Items do
  begin
    BeginUpdate;
    for i := 0 to 15 do
      Add(IntToStr(StdFontSizes[i]));
    EndUpdate;
  end;
  SelectionChange(Self);

  CurrText.Name := Editor.Font.Name;
  CurrText.Size := -MulDiv(Editor.Font.Height, 72, Screen.PixelsPerInch);

  { Check if we should load a file from the command line }
  if (ParamCount > 0) and FileExists(ParamStr(1)) then
    AFileName := ParamStr(1)
  else
    AFileName := '..\overview.rtf';
  FSaveRTF := Comparetext(ExtractFileExt(AFileName), '.rtf') = 0;
  if FSaveRTF then
    Editor.LoadFromRtfFile(AFileName)
  else
    Editor.LoadFromFile(AFileName);
  SetFileName(AFileName);
  Editor.GetSource.Modified := False;
  SetModified(False);
end;

procedure TForm1.ShowHint(Sender: TObject);
begin
  if Length(Application.Hint) > 0 then
  begin
    StatusBar.SimplePanel := True;
    StatusBar.SimpleText := Application.Hint;
  end
  else
    StatusBar.SimplePanel := False;
end;

procedure TForm1.FileNew(Sender: TObject);
begin
  SetFileName(sUntitled);
  Editor.Lines.Clear;
  Editor.GetSource.Modified := False;
  SetModified(False);
end;

procedure TForm1.PerformFileOpen(const AFileName: string);
begin
  if FSaveRTF then
    Editor.LoadFromRtfFile(AFileName)
  else
    Editor.LoadFromFile(AFileName);
  SetFileName(AFileName);
  Editor.SetFocus;
  Editor.GetSource.Modified := False;
  SetModified(False);
end;

procedure TForm1.FileOpen(Sender: TObject);
begin
  CheckFileSave;
  if OpenDialog.Execute then
  begin
    FSaveRTF := OpenDialog.FilterIndex = 1;
    PerformFileOpen(OpenDialog.FileName);
    Editor.ReadOnly := ofReadOnly in OpenDialog.Options;
  end;
end;

procedure TForm1.FileSave(Sender: TObject);
begin
  if FFileName = sUntitled then
    FileSaveAs(Sender)
  else
  begin
    if FSaveRTF then
      Editor.ExportToRtfFile(FFileName)
    else
      Editor.SaveToFile(FFileName);
    Editor.GetSource.Modified := False;
    SetModified(False);
  end;
end;

procedure TForm1.FileSaveAs(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    if FileExists(SaveDialog.FileName) then
      if MessageDlg(Format(sOverWrite, [SaveDialog.FileName]),
        mtConfirmation, mbYesNoCancel, 0) <> idYes then Exit;
    FSaveRTF := SaveDialog.FilterIndex = 1;
    if FSaveRTF then
      Editor.ExportToRtfFile(SaveDialog.FileName)
    else
      Editor.SaveToFile(SaveDialog.FileName);
    SetFileName(SaveDialog.FileName);
    Editor.GetSource.Modified := False;
    SetModified(False);
  end;
end;

procedure TForm1.FilePrint(Sender: TObject);
begin
  Editor.PrintWithDialog;
end;

procedure TForm1.FileExit(Sender: TObject);
begin
  Close;
end;

procedure TForm1.EditUndo(Sender: TObject);
begin
  with Editor do
    if HandleAllocated then SendMessage(Handle, EM_UNDO, 0, 0);
end;

procedure TForm1.EditCut(Sender: TObject);
begin
  Editor.CutToClipboard;
end;

procedure TForm1.EditCopy(Sender: TObject);
begin
  Editor.CopyToClipboard;
end;

procedure TForm1.EditPaste(Sender: TObject);
begin
  Editor.PasteFromClipboard;
end;

procedure TForm1.HelpAbout(Sender: TObject);
begin
  ShowMessage('Dream Memo Demo'#13#10#13#10'Copyright © 1997-2000 Dream Company');
end;

type
  TMAttr = class(TMemoAttributes);

procedure TForm1.SelectFont(Sender: TObject);
begin
  FontDialog1.Font.Assign(TMAttr(Editor.SelAttributes).Font);
  if FontDialog1.Execute then
    CurrText.Assign(FontDialog1.Font);
  SelectionChange(Self);
  Editor.SetFocus;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  SelectionChange(Sender);
end;

procedure TForm1.BoldButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if BoldButton.Down then
    CurrText.Style := CurrText.Style + [fsBold]
  else
    CurrText.Style := CurrText.Style - [fsBold];
end;

procedure TForm1.ItalicButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if ItalicButton.Down then
    CurrText.Style := CurrText.Style + [fsItalic]
  else
    CurrText.Style := CurrText.Style - [fsItalic];
end;

procedure TForm1.FontSizeChange(Sender: TObject);
begin
  if FUpdating then Exit;
  CurrText.Size := StrToInt(FontSize.Text);
end;

procedure TForm1.FontNameChange(Sender: TObject);
begin
  if FUpdating then Exit;
  CurrText.Name := FontName.Items[FontName.ItemIndex];
end;

procedure TForm1.UnderlineButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if UnderlineButton.Down then
    CurrText.Style := CurrText.Style + [fsUnderline]
  else
    CurrText.Style := CurrText.Style - [fsUnderline];
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  try
    CheckFileSave;
  except
    CanClose := False;
  end;
end;

procedure TForm1.UpdateCursorPos;
begin
  with Editor.CaretPoint do
    StatusBar.Panels[0].Text := Format(sColRowInfo, [Y, X]);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  UpdateCursorPos;
  Editor.SetFocus;
end;

procedure TForm1.DCMemo1Change(Sender: TObject);
begin
  SetModified(Editor.GetSource.Modified);
  UpdateCommands;
end;

procedure TForm1.SetModified(Value: Boolean);
begin
  if Value then
    StatusBar.Panels[1].Text := sModified
  else
    StatusBar.Panels[1].Text := '';
end;

procedure TForm1.FontColorChange(Sender: TObject);
begin
  if FUpdating then Exit;
  CurrText.Color := FontColor.SelectedColor;
end;

procedure TForm1.BackColorChange(Sender: TObject);
begin
  if FUpdating then Exit;
  CurrText.BkColor := BackColor.SelectedColor;
end;

procedure TForm1.EditorStateChange(Sender: TObject; State: TMemoStates);
begin
  if not (csLoading in ComponentState) then
    DCMemo1Change(Sender);
end;

end.

