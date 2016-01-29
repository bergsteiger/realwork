{ *************************************************************************** }
{                                                                             }
{ Delphi and Kylix Cross-Platform Visual Component Library                    }
{                                                                             }
{ Copyright (c) 2000-2002 Borland Software Corporation                        }
{                                                                             }
{ This file may be distributed and/or modified under the terms of the GNU     }
{ General Public License (GPL) version 2 as published by the Free Software    }
{ Foundation and appearing at http://www.borland.com/kylix/gpl.html.          }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }

unit QFileDialog;

interface

uses
  SysUtils, Types, Classes, Variants, QGraphics, QControls, QForms, QDialogs,
  QExtCtrls, QComCtrls, QStdCtrls, QFileCtrls, QActnList, QImgList, QTypes,
  QMenus, Qt;

const
  QEventType_FDSelect = QEventType(Integer(QEventType_ClxBase) + $100);

type
  TFileDialogForm = class;

  TFileDlgViewStyle = (fvsIcon, fvsSmallIcon, fvsList, fvsReport);

  TPreviewScrollBox = class(TScrollBox)
  private
    FCanvas: TCanvas;
    FBitmap: TBitmap;
    function GetCanvas: TCanvas;
  protected
    procedure BoundsChanged; override;
    procedure CanvasChanged(Sender: TObject);
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
    procedure InitWidget; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas: TCanvas read GetCanvas;
  end;

  TFileDialogForm = class(TDialogForm, IFileDialogForm)
    BottomPanel: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    OpenButton: TButton;
    CancelButton: TButton;
    FileEdit: TFileEdit;
    FilterCombo: TFilterComboBox;
    ActionList1: TActionList;
    FormAction: TAction;
    ImageList1: TImageList;
    ViewPopup: TPopupMenu;
    LargeIcons1: TMenuItem;
    SmallIcons1: TMenuItem;
    List1: TMenuItem;
    Details1: TMenuItem;
    FileIcons: TFileIconView;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    ListButton: TToolButton;
    ToolButton3: TToolButton;
    NewDirButton: TToolButton;
    UpButton: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    Label1: TLabel;
    UpAction: TAction;
    BackAction: TAction;
    ForwardAction: TAction;
    FileHistoryCombo: TFileHistoryComboBox;
    HomeAction: TAction;
    ReloadAction: TAction;
    ViewIconAction: TAction;
    ViewSmallIconAction: TAction;
    ViewListAction: TAction;
    ViewDetailAction: TAction;
    HelpROPanel: TPanel;
    ReadOnlyCheckbox: TCheckBox;
    HelpButton: TButton;
    HelpAction: TAction;
    PreviewPanel: TPanel;
    AutoPreviewCheckbox: TCheckBox;
    PreviewButton: TButton;
    Panel3: TPanel;
    PreviewProgress: TProgressBar;
    PreviewLabel: TLabel;
    NewDirAction: TAction;
    ItemPopup: TPopupMenu;
    DeleteAction: TAction;
    DeleteAction1: TMenuItem;
    RenameAction: TAction;
    Rename1: TMenuItem;
    N1: TMenuItem;
    ListPopup: TPopupMenu;
    NewDirectory1: TMenuItem;
    Reload1: TMenuItem;
    OpenAction: TAction;
    Open1: TMenuItem;
    HiddenAction: TAction;
    ShowHiddenFiles1: TMenuItem;
    N3: TMenuItem;
    Back1: TMenuItem;
    Forward1: TMenuItem;
    Uponedirectory1: TMenuItem;
    N2: TMenuItem;
    Home1: TMenuItem;
    Splitter: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActionUpdate(Sender: TObject);
    procedure FileListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FilterComboClick(Sender: TObject);
    procedure FileIconsSelectItem(Sender: TObject; Item: TIconViewItem;
      Selected: Boolean);
    procedure FileHistoryComboClick(Sender: TObject);
    procedure UpActionUpdate(Sender: TObject);
    procedure UpActionExecute(Sender: TObject);
    procedure BackActionUpdate(Sender: TObject);
    procedure BackActionExecute(Sender: TObject);
    procedure ForwardActionUpdate(Sender: TObject);
    procedure ForwardActionExecute(Sender: TObject);
    procedure HomeActionExecute(Sender: TObject);
    procedure ReloadActionExecute(Sender: TObject);
    procedure ViewIconActionExecute(Sender: TObject);
    procedure HelpActionExecute(Sender: TObject);
    procedure HelpActionUpdate(Sender: TObject);
    procedure FileEditReturnPressed(Sender: TObject);
    procedure AutoPreviewCheckboxClick(Sender: TObject);
    procedure PreviewButtonClick(Sender: TObject);
    procedure FileIconsDirectoryChange(Sender: TObject;
      const NewDir: WideString);
    procedure FileEditDirectoryChange(Sender: TObject;
      const NewDir: WideString);
    procedure FileEditMaskChange(Sender: TObject; const NewMask: WideString);
    procedure NewDirActionUpdate(Sender: TObject);
    procedure NewDirActionExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DeleteActionUpdate(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
    procedure RenameActionExecute(Sender: TObject);
    procedure OpenActionUpdate(Sender: TObject);
    procedure HiddenActionExecute(Sender: TObject);
    procedure FileIconsContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure FileListContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure FileIconsDblClick(Sender: TObject);
    procedure FileListDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FileListFileFound(Sender: TObject; const AFile: TSearchRec;
      var CanAdd: Boolean);
    procedure FileIconsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FileIconsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagePanelResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PreviewPanelResize(Sender: TObject);
    procedure FormLoaded(Sender: TObject);
  private
    FAutoPreview: Boolean;
    FDirSelected: Boolean;
    FDefaultExt: WideString;
    FFileList: TFileListView;
    FViewStyle: TFileDlgViewStyle;
    FOpenDialog: IOpenDialog;
    PreviewScroll: TPreviewScrollBox;
    procedure ClearPreview;
    function GetDirectory: WideString;
    function GetSelections(Viewer: TObject): TFileInfos;
    procedure SetDirectory(const Directory: WideString);
  protected
    function CurrentFiles: TDirectory;
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
    function FileList: TFileListView;
    procedure ItemSelected(Sender: TObject; FileInfo: PFileInfo;
      Selected: Boolean); virtual;
    procedure Progress(Sender: TObject; Stage: TProgressStage;
      PercentDone: Byte; RedrawNow: Boolean; const R: TRect;
      const Msg: WideString; var Continue: Boolean); virtual;
    procedure SetViewStyle(const Value: TFileDlgViewStyle);
    procedure UpdateSelectionState(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property Directory: WideString read GetDirectory write SetDirectory;
    //IFileDialogForm
    procedure GetOptions(OpenDlg: TOpenDialog; Accepted: Boolean);
    function GetSelected: TFileInfos;
    procedure ListFiles(List: TStrings); virtual;
    procedure ResizePreview(const NewSize: TSize);
    procedure SetOptions(OpenDlg: TOpenDialog);

  end;

var
  FileDialogForm: TFileDialogForm;

implementation

{$R *.xfm}

uses
{$IFDEF LINUX}
   Libc,
{$ENDIF}
   QConsts;

var
  GraphicPreviewer: TGraphicPreviewer = nil;

{ TFileDialogForm }

procedure TFileDialogForm.SetDirectory(const Directory: WideString);
begin
  if CurrentFiles.Location <> IncludeTrailingPathDelimiter(Directory) then
  begin
    CurrentFiles.Location := Directory;
    if Showing then
      FileHistoryCombo.Add(Directory);
  end;
end;

procedure TFileDialogForm.FormShow(Sender: TObject);
const
  Titles: array[Boolean] of string = (SOpen, SSave);
begin
  if Caption = '' then
    Caption := Titles[Dialog is TSaveDialog];
  FileHistoryCombo.Add(Directory);
  ActiveControl := FileEdit;
  FileEdit.SelectAll;
  PreviewLabel.Top := PreviewScroll.Top + PreviewScroll.Height + 10;
  PreviewLabel.Caption := '';
  PreviewProgress.Visible := False;
  PreviewProgress.Top := PreviewLabel.Top + PreviewLabel.Height + 5;
end;

procedure TFileDialogForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide; //TFileDialog controls this form's lifetime.
end;

function TFileDialogForm.GetDirectory: WideString;
begin
  Result := CurrentFiles.Location;
end;

procedure TFileDialogForm.FormActionUpdate(Sender: TObject);
begin
  OpenButton.Caption := OpenAction.Caption;
  OpenButton.Enabled := (FileEdit.Text <> '') or FDirSelected;
  OpenAction.Enabled := OpenButton.Enabled;
end;

procedure TFileDialogForm.ListFiles(List: TStrings);

  function IsRegisteredExtension(const Ext: WideString): Boolean;
  var
    RE: QRegExpH;
    I: Integer;
    Pattern: WideString;
    Masks: TStringList;
  begin
    Result := False;
    RE := QRegExp_create;
    Masks := TStringList.Create;
    try
      FilterCombo.ListMasks(Masks);
      begin
        QRegExp_setCaseSensitive(RE, True);
        for I := 0 to Masks.Count - 1 do
          if Masks[I] <> AllMask then
          begin
            Pattern := '^.' + Masks[I] +'$';
            QRegExp_setPattern(RE, @Pattern);
            Result := (QRegExp_find(RE, @Ext, 0) > -1);
            if Result then Exit;
          end;
      end;
    finally
      Masks.Free;
      QRegExp_destroy(RE);
    end;
  end;

  function GetFirstExtension(const Mask: string): string;
  var
    P: Integer;
  begin
    Result := Mask;
    P := Pos(';', Result);
    if P > 0 then
      SetString(Result, PChar(@Mask[1]), P-1);
    Result := ExtractFileExt(Result);
    if (Pos('*', Result) <> 0) or (Pos('?', Result) <> 0) then
      Result := '';
  end;

  function GetFilterExtension(const Index: Integer): WideString;
  var
    Masks: TStrings;
  begin
    Result := '';
    Masks := TStringList.Create;
    try
      FilterCombo.ListMasks(Masks);
      if (Index < 0) or (Index >= Masks.Count) then
        Exit;
      Result := GetFirstExtension(Masks[Index]);
    finally
      Masks.Free;
    end;
  end;

  function FileExtension(const Filename: WideString): WideString;
  var
    ThisExt,
    DefExt: WideString;
  begin
    Result := '';
{$IFDEF MSWINDOWS}
    if (Length(Filename) = 2) and (Filename[2] = ':') then
      Exit;
{$ENDIF}
    if FileExists(Filename) then Exit;
    DefExt := FDefaultExt;
    begin
      if Dialog is TSaveDialog then
      begin
        ThisExt := ExtractFileExt(Filename);
        if ThisExt <> '' then
        begin
          if (ThisExt = '.' + DefExt) or (DefExt = '') then
            Exit;
          if not IsRegisteredExtension(ThisExt) then
          begin
            Result := GetFilterExtension(FilterCombo.ItemIndex);
            if (Pos('?', Result) > 0) then
              Result := DefExt;
          end;
        end
        else
          if (Length(DefExt) > 0) then
            Result := GetFilterExtension(FilterCombo.ItemIndex);
      end
      else begin
        ThisExt := ExtractFileExt(Filename);
        if ThisExt <> '' then
        begin
          if not IsRegisteredExtension(ThisExt) then
          begin
            Result := GetFirstExtension(FilterCombo.Mask);
            if (Pos('?', Result) > 0) then
              Result := DefExt;
          end;
        end
        else
          if (DefExt <> #0) and (Length(DefExt) > 0) then
          begin
            Result := GetFirstExtension(FilterCombo.Mask);
            if (Result = '') then
              Result := '.' + DefExt;
          end;
      end;
    end;
  end;

  function MakeAbsolute(const Filename: WideString): WideString;
  var
    Tmp: WideString;
  begin
    Tmp := Filename;
    if IsRelativePath(Tmp) then
      Tmp := FileEdit.CurrentDir + Tmp;
    if Tmp <> '' then
    begin
{$IFDEF LINUX}
      // Backslashes are treated as escape characters in ExpandDirectoryName.
      Tmp := StringReplace(Tmp, '\', '\\', [rfReplaceAll]);
{$ENDIF}
      Result := ExpandDirectoryName(Tmp)
    end
    else
      Result := Filename;
  end;

var
  SaveQuote: Char;
  I: Integer;
  F: WideString;
begin
  List.Clear;
  if Length(FileEdit.Text) = 0 then Exit;
  if Pos('"', FileEdit.Text) = 0 then
  begin
    F := MakeAbsolute(FileEdit.Text);
    F := F + FileExtension(F);
    List.Add(F);
  end
  else begin
    SaveQuote := List.QuoteChar;
    try
      List.QuoteChar := '"';
      List.DelimitedText := FileEdit.Text;
      for I := 0 to List.Count - 1 do
        List[I] := MakeAbsolute(List[I] + FileExtension(List[I]));
    finally
      List.QuoteChar := SaveQuote;
    end;
  end;
end;

procedure TFileDialogForm.SetViewStyle(const Value: TFileDlgViewStyle);
begin
  case Value of
    fvsList:
      begin
        FileList.ViewStyle := vsList;
        if CurrentFiles <> FileList.Directory then
          FileList.Directory.Assign(CurrentFiles);
        FileList.Visible := True;
        FileIcons.Visible := False;
        ViewListAction.Checked := True;
      end;
    fvsReport:
      begin
        FileList.ViewStyle := vsReport;
        if CurrentFiles <> FileList.Directory then
          FileList.Directory.Assign(CurrentFiles);
        FileList.Visible := True;
        FileIcons.Visible := False;
        ViewDetailAction.Checked := True;
      end;
    fvsSmallIcon:
      begin
        FileIcons.TextPosition := itpRight;
        FileIcons.IconOptions.Arrangement := iaTop;
        if CurrentFiles <> FileIcons.Directory then
          FileIcons.Directory.Assign(CurrentFiles);
        FileIcons.IconSize := isSmall;
        FileIcons.Visible := True;
        if Assigned(FFileList) then
          FileList.Visible := False;
        ViewSmallIconAction.Checked := True;
      end;
    fvsIcon:
      begin
        FileIcons.IconOptions.Arrangement := iaTop;
        FileIcons.TextPosition := itpBottom;
        FileIcons.IconSize := isLarge;
        if CurrentFiles <> FileIcons.Directory then
          FileIcons.Directory.Assign(CurrentFiles);
        FileIcons.Visible := True;
        if Assigned(FFileList) then
          FileList.Visible := False;
        ViewIconAction.Checked := True;
      end;
  end;
  FViewStyle := Value;
end;

constructor TFileDialogForm.Create(AOwner: TComponent);
begin
  FOpenDialog := AOwner as IOpenDialog;
  inherited Create(AOwner);
  FViewStyle := fvsSmallIcon;
  if not Assigned(GraphicPreviewer) then
  begin
    GraphicPreviewer := TGraphicPreviewer.Create;
    RegisterFilePreviewer(GraphicPreviewer);
  end;
end;

procedure TFileDialogForm.FilterComboClick(Sender: TObject);
begin
  CurrentFiles.FileMask := FilterCombo.Mask;
  FOpenDialog.FilterChanged(FilterCombo.ItemIndex);
end;

function TFileDialogForm.GetSelections(Viewer: TObject): TFileInfos;
begin
  if Viewer = FileIcons then
    Result := FileIcons.Selections
  else
    Result := FFileList.Selections;
end;

procedure TFileDialogForm.FileIconsSelectItem(Sender: TObject;
  Item: TIconViewItem; Selected: Boolean);
begin
  if (FileIcons.Items.UpdateCount = 0) and not FileIcons.IsEditing then
    ItemSelected(Sender, PFileInfo(Item.Data), Selected);
end;             

procedure TFileDialogForm.FileListSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if (FileList.Items.UpdateCount = 0) and not FileList.IsEditing then
    ItemSelected(Sender, PFileInfo(Item.Data), Selected);
end;

procedure TFileDialogForm.ItemSelected(Sender: TObject;
  FileInfo: PFileInfo; Selected: Boolean);
begin
  if (FileInfo <> nil) then
    FOpenDialog.FileSelected(FileInfo, Selected);
end;

function TFileDialogForm.CurrentFiles: TDirectory;
begin
  if FViewStyle in [fvsList, fvsReport] then
    Result := FileList.Directory
  else
    Result := FileIcons.Directory;
end;

procedure TFileDialogForm.FileHistoryComboClick(Sender: TObject);
begin
  with Sender as TFileHistoryComboBox do
    if ItemIndex > -1 then
      CurrentFiles.Location := Items[ItemIndex];
end;

procedure TFileDialogForm.UpActionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := CurrentFiles.Location <> PathDelim;
end;

procedure TFileDialogForm.UpActionExecute(Sender: TObject);
begin
  CurrentFiles.Location := CurrentFiles.Location +  PathDelim + UpDir;
end;

procedure TFileDialogForm.BackActionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := FileHistoryCombo.CanGoBack;
end;

procedure TFileDialogForm.BackActionExecute(Sender: TObject);
begin
  FileHistoryCombo.GoBack;
end;

procedure TFileDialogForm.ForwardActionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := FileHistoryCombo.CanGoForward;
end;

procedure TFileDialogForm.ForwardActionExecute(Sender: TObject);
begin
  FileHistoryCombo.GoForward;
end;

procedure TFileDialogForm.HomeActionExecute(Sender: TObject);
begin
  CurrentFiles.Location := '$HOME';
end;

procedure TFileDialogForm.ReloadActionExecute(Sender: TObject);
begin
  CurrentFiles.ListFiles(True);
end;

procedure TFileDialogForm.ViewIconActionExecute(Sender: TObject);
begin
  with Sender as TAction do
  begin
    SetViewStyle(TFileDlgViewStyle(Tag));
    ViewListAction.Checked := Sender = ViewListAction;
    ViewIconAction.Checked := Sender = ViewIconAction;
    ViewDetailAction.Checked := Sender = ViewDetailAction;
    ViewSmallIconAction.Checked := Sender = ViewSmallIconAction;
  end;
end;

procedure TFileDialogForm.HelpActionExecute(Sender: TObject);
begin
  FOpenDialog.Help;
end;

procedure TFileDialogForm.HelpActionUpdate(Sender: TObject);
begin
//  (Sender as TAction).Enabled := ofShowHelp in TFileDialog(Dialog).Options;
end;

procedure TFileDialogForm.GetOptions(OpenDlg: TOpenDialog; Accepted: Boolean);
begin
  if ReadOnlyCheckbox.Checked then
    OpenDlg.Options := OpenDlg.Options + [ofReadOnly];
  OpenDlg.FilterIndex := FilterCombo.ItemIndex + 1;
  if AutoPreviewCheckbox.Checked then
    OpenDlg.Options := OpenDlg.Options + [ofAutoPreview]
  else
    OpenDlg.Options := OpenDlg.Options - [ofAutoPreview];
  case FViewStyle of
    fvsIcon:
      OpenDlg.Options := OpenDlg.Options + [ofViewIcon];
    fvsList:
      OpenDlg.Options := OpenDlg.Options + [ofViewList];
    fvsReport:
      OpenDlg.Options := OpenDlg.Options + [ofViewDetail];
  end;
  if PreviewPanel.Visible then
    Width := Width - PreviewPanel.Width;
end;

procedure TFileDialogForm.SetOptions(OpenDlg: TOpenDialog);
var
  Save: Boolean;
  StartDir: WideString;
begin
  Save := OpenDlg is TSaveDialog;
  FDefaultExt := OpenDlg.DefaultExt;
  if ofEnableSizing in OpenDlg.Options then
    BorderStyle := fbsSizeable
  else
    BorderStyle := fbsDialog;
  FormAction.Caption := OpenDlg.Title;
  if Save then
    OpenButton.Caption := SSave
  else
    OpenButton.Caption := SOpen;
  HelpROPanel.Visible := not (ofHideReadOnly in OpenDlg.Options) or
    (ofShowHelp in OpenDlg.Options);
  if HelpROPanel.Visible then
    HelpROPanel.Top := BottomPanel.Top + BottomPanel.Height;
  PreviewPanel.Visible := ofPreview in OpenDlg.Options;
  Splitter.Visible := PreviewPanel.Visible;
  if PreviewPanel.Visible then
    Width := Width + PreviewPanel.Width;

  ReadOnlyCheckbox.Visible := not (ofHideReadOnly in OpenDlg.Options);
  ReadOnlyCheckbox.Checked := ofReadOnly in OpenDlg.Options;
  AutoPreviewCheckbox.Checked := ofAutoPreview in OpenDlg.Options;
  HelpButton.Visible := ofShowHelp in OpenDlg.Options;
  StartDir := OpenDlg.InitialDir;
  if StartDir = '' then
  begin
    StartDir := ExtractFilePath(OpenDlg.Filename);
    if StartDir = '' then
      StartDir := GetCurrentDir;
  end;
  try
    Directory := StartDir;
  except
    Directory := GetCurrentDir;
  end;

  if OpenDlg.Filter <> '' then
    FilterCombo.Filter := OpenDlg.Filter;
  if (OpenDlg.FilterIndex <= FilterCombo.Items.Count)
  and (OpenDlg.FilterIndex > 0) then
    FilterCombo.ItemIndex := OpenDlg.FilterIndex - 1
  else
    FilterCombo.ItemIndex := 0;
  CurrentFiles.FileMask := FilterCombo.Mask;
  FileEdit.Text := ExtractFileName(OpenDlg.Filename);
  FileIcons.MultiSelect := (ofAllowMultiSelect in OpenDlg.Options)
    and not Save;
  if ofViewDetail in OpenDlg.Options then
    SetViewStyle(fvsReport)
  else if ofViewIcon in OpenDlg.Options then
    SetViewStyle(fvsIcon)
  else if ofViewList in OpenDlg.Options then
    SetViewStyle(fvsList)
  else
    SetViewStyle(fvsSmallIcon);
  if ofShowHidden in OpenDlg.Options then
    CurrentFiles.FileType := CurrentFiles.FileType + [ftHidden];
  PreviewScroll.Height := FileIcons.Height;
end;

procedure TFileDialogForm.FileEditReturnPressed(Sender: TObject);
var
  CanClose: Boolean;
begin
  if (Pos('*', FileEdit.Text) <> 0) or (Pos('?', FileEdit.Text) <> 0) then
    Exit;
  CanClose := OpenButton.Enabled and (ActiveControl <> FileHistoryCombo);
  if not FDirSelected then
  begin
    FOpenDialog.CanClose(CanClose);
    if CanClose then
      ModalResult := mrOk;
  end else
    case FViewStyle of
      fvsIcon, fvsSmallIcon:
        FileIcons.GoDown;
      fvsList, fvsReport:
        FileList.GoDown;
    end;
end;

procedure TFileDialogForm.AutoPreviewCheckboxClick(Sender: TObject);
begin
  FAutoPreview := (Sender as TCheckbox).Checked;
  PreviewButton.Enabled := not FAutoPreview;
  if not FAutoPreview then
    ClearPreview
  else
    PreviewButtonClick(nil);
end;

procedure TFileDialogForm.PreviewButtonClick(Sender: TObject);
var
  Selected: TFileInfos;
  Filename: string;
  Handled: Boolean;
  ARect: TRect;
begin
  ClearPreview;
  Selected := GetSelected;
  if High(Selected) <> 0 then Exit;
  Filename := ExpandDirectoryName(IncludeTrailingPathDelimiter(
    CurrentFiles.Location)) + Selected[0].SR.Name;
  Handled := False;
  ARect := Rect(1, 1, PreviewScroll.ClientWidth-5,
    PreviewScroll.ClientHeight-5);
  FOpenDialog.FilePreview(Filename, PreviewScroll.Canvas, ARect,
    Self.Progress, Handled);
  PreviewScroll.Repaint;
end;

function TFileDialogForm.GetSelected: TFileInfos;
begin
  case FViewStyle of
    fvsIcon, fvsSmallIcon: Result := FileIcons.Selections;
    fvsList, fvsReport:  Result := FileList.Selections;
  end;
end;

procedure TFileDialogForm.Progress(Sender: TObject; Stage: TProgressStage;
  PercentDone: Byte; RedrawNow: Boolean; const R: TRect;
  const Msg: WideString; var Continue: Boolean);
begin
  if (Stage = psStarting) and not PreviewProgress.Visible then
    PreviewProgress.Visible := True;
  PreviewLabel.Caption := Msg;
  if Stage = psEnding then
    PreviewProgress.Visible := False
  else
    PreviewProgress.Position := PercentDone;
  if RedrawNow then
    PreviewScroll.Repaint;
end;

procedure TFileDialogForm.ClearPreview;
begin
  if not Assigned(PreviewScroll) then
    Exit;
  with PreviewScroll do
  begin
    HorzScrollBar.Range := 0;
    VertScrollBar.Range := 0;
    Canvas.Brush.Bitmap := nil;
    Canvas.Brush.Color := PreviewPanel.Color;
    Canvas.Font.Assign(Self.Font);
    Canvas.FillRect(Rect(0, 0, PreviewScroll.FBitmap.Width, PreviewScroll.FBitmap.Height));
  end;
end;

procedure TFileDialogForm.FileIconsDirectoryChange(Sender: TObject;
  const NewDir: WideString);
begin
  if csLoading in ComponentState then Exit;
  FileEdit.Directory.Location := ExpandDirectoryName(NewDir);
  if Showing then
    FileHistoryCombo.Add(Directory);

  ClearPreview;
  FDirSelected := False;
  if Dialog is TSaveDialog then
    OpenAction.Caption := SSave
  else
    OpenAction.Caption := SOpen;
  FOpenDialog.DirChanged(NewDir);
end;

procedure TFileDialogForm.FileEditDirectoryChange(Sender: TObject;
  const NewDir: WideString);
begin
  Directory := NewDir;
end;

procedure TFileDialogForm.FileEditMaskChange(Sender: TObject;
  const NewMask: WideString);
begin
  CurrentFiles.FileMask := NewMask;
end;

procedure TFileDialogForm.NewDirActionUpdate(Sender: TObject);
{$IFDEF LINUX}
var
  Dir: string;
{$ENDIF}
begin
{$IFDEF LINUX}
  Dir := CurrentFiles.Location;
  (Sender as TAction).Enabled := access(PChar(Dir), W_OK) = 0;
{$ENDIF}
end;

procedure TFileDialogForm.NewDirActionExecute(Sender: TObject);
begin
  if FViewStyle in [fvsList, fvsReport] then
    FileList.CreateDirectory(SNewFolder)
  else
    FileIcons.CreateDirectory(SNewFolder)
end;

procedure TFileDialogForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = []) and ((ActiveControl = FFileList)
    or (ActiveControl = FileIcons)) then
    case Key of
      Key_F5:
        ReloadActionExecute(Self);
      Key_Delete:
        DeleteActionExecute(Self);
    end;
end;

procedure TFileDialogForm.DeleteActionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := ((ActiveControl = FileIcons) and
    (FileIcons.Selected <> nil)) or ((ActiveControl = FFileList) and
    (FileList.Selected <> nil));
end;

procedure TFileDialogForm.DeleteActionExecute(Sender: TObject);
var
  Selections: TFileInfos;
  I: Integer;
  Result: Integer;
  ConfirmMsg: WideString;
begin
  Selections := nil;
  if ((ActiveControl = FileIcons) or (ActiveControl = FFileList)) then
  begin
    if (ActiveControl = FileIcons) then
      Selections := FileIcons.Selections
    else
      Selections := FileList.Selections;

    if High(Selections) > 0 then
      ConfirmMsg := Format(SConfirmDeleteMany, [High(Selections) + 1])
    else if High(Selections) = 0 then
      ConfirmMsg := Format(SConfirmDeleteOne, [Selections[0].SR.Name])
    else Exit;

    if MessageDlg(SConfirmDeleteTitle, ConfirmMsg,
      mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    begin
      if (ActiveControl = FileIcons) then
        FileIcons.Items.BeginUpdate
      else
        FileList.Items.BeginUpdate;
      try
        FileEdit.Text := '';
        for I := 0 to High(Selections) do
        begin
          Result := CurrentFiles.Delete(Selections[I]);
          case Result of
            RESULT_ACCESS_DENIED:
              begin
                if I < High(Selections) then
                begin
                  if MessageDlg(SMsgDlgError, Format(SAccessDeniedTo,
                    [CurrentFiles.Location + Selections[I].SR.Name]) +
                    #10 + SContinueDelete, mtError, [mbYes, mbNo],
                    0, mbYes) = mrYes then
                    Result := RESULT_OK;
                end else
                  MessageDlg(SMsgDlgError, Format(SAccessDeniedTo,
                    [CurrentFiles.Location + Selections[I].SR.Name]),
                    mtError, [mbOk], 0);
              end;
            RESULT_DIR_NOT_EMPTY:
              MessageDlg(SMsgDlgError, Format(SDirectoryNotEmpty,
                [CurrentFiles.Location + Selections[I].SR.Name]),
                mtError, [mbOk], 0);
            RESULT_FILE_NOT_FOUND:
              if MessageDlg(SMsgDlgError, Format(SFileNameNotFound,
                [CurrentFiles.Location + Selections[I].SR.Name]) +
                #10 + SContinueDelete, mtError, [mbYes, mbNo],
                0, mbYes) = mrYes then
                  Result := RESULT_OK;
          end;
          if Result <> RESULT_OK then
            Exit;
        end;
        CurrentFiles.ListFiles(True);
      finally
        if (ActiveControl = FileIcons) then
          FileIcons.Items.EndUpdate
        else
          FileList.Items.EndUpdate;
      end;
    end;
  end;
end;

procedure TFileDialogForm.RenameActionExecute(Sender: TObject);
begin
  if (ActiveControl = FileIcons) and (FileIcons.Selected <> nil) then
    FileIcons.Selected.EditText
  else if (ActiveControl = FFileList) and (FileList.Selected <> nil) then
    FileList.Selected.EditText;
end;

procedure TFileDialogForm.OpenActionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := OpenButton.Enabled;
end;

procedure TFileDialogForm.HiddenActionExecute(Sender: TObject);
begin
  (Sender as TAction).Checked := not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    CurrentFiles.FileType := CurrentFiles.FileType + [ftHidden]
  else
    CurrentFiles.FileType := CurrentFiles.FileType - [ftHidden];
end;

procedure TFileDialogForm.FileIconsContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  Item: TIconViewItem;
begin
  Handled := True;
  Item := FileIcons.FindItemByPoint(MousePos);
  MousePos := FileIcons.ClientToScreen(MousePos);
  if Item = nil then
    ListPopup.Popup(MousePos.X, MousePos.Y)
  else
    ItemPopup.Popup(MousePos.X, MousePos.Y);
end;

procedure TFileDialogForm.FileListContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  Item: TListItem;
begin
  Handled := True;
  Item := FileList.GetItemAt(MousePos.X, MousePos.Y);
  MousePos := FileList.ClientToScreen(MousePos);
  if Item = nil then
    ListPopup.Popup(MousePos.X, MousePos.Y)
  else
    ItemPopup.Popup(MousePos.X, MousePos.Y);
end;

procedure TFileDialogForm.FileIconsDblClick(Sender: TObject);
begin
  if (FileIcons.Selected <> nil) and (PFileInfo(FileIcons.Selected.Data).SR.Attr and faDirectory = 0) then
    FileEditReturnPressed(Sender);
end;

procedure TFileDialogForm.FileListDblClick(Sender: TObject);
begin
  if (FileList.Selected <> nil) and (PFileInfo(FileList.Selected.Data).SR.Attr and faDirectory = 0) then
    FileEditReturnPressed(Sender);
end;

procedure TFileDialogForm.FormActivate(Sender: TObject);
begin
  QWidget_setEnabled(Handle, True);
end;

procedure TFileDialogForm.FileListFileFound(Sender: TObject;
  const AFile: TSearchRec; var CanAdd: Boolean);
var
  Filename: string;
begin
{$IFDEF MSWINDOWS}
  Filename := AFile.FindData.cFileName;
  //TODO: get mode/permissions on Windows
{$ENDIF}
{$IFDEF LINUX}
  Filename := AFile.PathOnly + AFile.Name;
  CanAdd := FOpenDialog.FileAdd(Filename, access(PChar(Filename), R_OK) = 0,
    access(PChar(Filename), W_OK) = 0, access(PChar(Filename), X_OK) = 0);
{$ENDIF}
end;

procedure TFileDialogForm.FileIconsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not FileIcons.IsEditing and (Key <> Key_Shift) and (Key <> Key_Control)
  and (Key <> Key_Return) and (Key <> Key_Enter) then
    QApplication_postEvent(Handle, QCustomEvent_create(QEventType_FDSelect, nil));
end;

procedure TFileDialogForm.FileIconsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    QApplication_postEvent(Handle, QCustomEvent_create(QEventType_FDSelect, nil));
end;

procedure TFileDialogForm.UpdateSelectionState(Sender: TObject);
var
  Selections: TFileInfos;
  I: Integer;
  Filenames: WideString;
begin
  Selections := nil;
  if (Sender <> FileIcons) and (Sender <> FFileList) then Exit;
  if not AutoPreviewCheckbox.Checked then
    ClearPreview;
  Selections := GetSelections(Sender);
  if High(Selections) < 0 then
  begin
    if Dialog is TSaveDialog then
      OpenAction.Caption := SSave
    else
      OpenAction.Caption := SOpen;
    FDirSelected := False;
  end
  else if (High(Selections) = 0) and (Selections[0].SR.Attr and faDirectory <> 0) then
  begin
    OpenAction.Caption := SOpen;
    FDirSelected := True;
  end
  else
  begin
    if Dialog is TSaveDialog then
      OpenAction.Caption := SSave
    else
      OpenAction.Caption := SOpen;
    FDirSelected := False;
    FileEdit.ClearSelection;
    if High(Selections) = 0 then
      FileEdit.Text := Selections[0].SR.Name
    else begin
      ClearPreview;
      for I := 0 to High(Selections) do
        if Selections[I].SR.Attr and faDirectory = 0 then
          Filenames := Filenames + '"' + Selections[I].SR.Name + '" ';
      if Filenames <> '' then
        FileEdit.Text := Trim(Filenames);
    end;
    OpenButton.Enabled := FileEdit.Text <> '';
    if FAutoPreview then
      PreviewButtonClick(Self);
  end;    
end;

function TFileDialogForm.EventFilter(Sender: QObjectH;
  Event: QEventH): Boolean;
begin
  Result := False;
  if QEvent_type(Event) = QEventType_FDSelect then
  begin
    UpdateSelectionState(ActiveControl);
  end else
    Result := inherited EventFilter(Sender, Event);
end;

procedure TFileDialogForm.ImagePanelResize(Sender: TObject);
begin
  ClearPreview;
end;

procedure TFileDialogForm.FormCreate(Sender: TObject);
begin
  PreviewScroll := TPreviewScrollBox.Create(PreviewPanel);
  PreviewScroll.Parent := PreviewPanel;
  PreviewScroll.SetBounds(3, Panel2.Height, PreviewPanel.Width - 6,
    FileIcons.Height);
  PreviewScroll.Anchors := [akLeft, akTop, akRight, akBottom];
end;

procedure TFileDialogForm.ResizePreview(const NewSize: TSize);
begin
  with PreviewScroll do
  begin
    HorzScrollBar.Range := NewSize.cx;
    VertScrollBar.Range := NewSize.cy;
    HorzScrollBar.Position := 0;
    VertScrollBar.Position := 0;
    FBitmap.Width := NewSize.cx;
    FBitmap.Height := NewSize.cy;
    Canvas.Brush.Color := PreviewPanel.Color;
    Canvas.FillRect(Rect(0, 0, PreviewScroll.FBitmap.Width,
      PreviewScroll.FBitmap.Height));
  end;
end;

function TFileDialogForm.FileList: TFileListView;
begin
  if FFileList = nil then
  begin
    FFileList := TFileListView.Create(Self);
    with FFileList do
    begin
      Parent := FileIcons.Parent;
      Left := FileIcons.Left;
      Top := FileIcons.Top;
      Align := alClient;
      FFileList.HandleNeeded;
      Directory.Assign(FileIcons.Directory);
      MultiSelect := FileIcons.MultiSelect;
      ReadOnly := False;
      TabOrder := 1;
      ViewStyle := vsList;
      Visible := False;
      OnContextPopup := FileListContextPopup;
      OnDblClick := FileListDblClick;
      OnDirectoryChanged := FileIconsDirectoryChange;
      OnFileFound := FileListFileFound;
      OnKeyUp := FileIconsKeyUp;
      OnMouseUp := FileIconsMouseUp;
      OnSelectItem := FileListSelectItem;
    end;
  end;
  Result := FFileList;
end;

{ TPreviewScrollBox }

procedure TPreviewScrollBox.BoundsChanged;
begin
  inherited BoundsChanged;
  if Assigned(FBitmap) then
  begin
    FBitmap.Width := ClientWidth;
    FBitmap.Height := ClientHeight;
  end;
end;

procedure TPreviewScrollBox.CanvasChanged(Sender: TObject);
begin
  Repaint;
end;

constructor TPreviewScrollBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FBitmap := TBitmap.Create;
  FBitmap.Height := 100;
  FBitmap.Width := 100;
  FBitmap.Canvas.OnChange := CanvasChanged;
end;

destructor TPreviewScrollBox.Destroy;
begin
  FBitmap.Free;
  FCanvas.Free;
  inherited;
end;

function TPreviewScrollBox.EventFilter(Sender: QObjectH;
  Event: QEventH): Boolean;
var
  ScrollRect: TRect;
begin
  Result := False;
  if QEvent_type(Event) = QEventType_Paint then
  begin
    if not (csWidgetPainting in ControlState) then
    begin
      inherited EventFilter(Sender, Event);
      TControlCanvas(FCanvas).StartPaint;
      try
        ScrollRect := Rect(-HorzScrollBar.Position, -VertScrollBar.Position,
          -HorzScrollBar.Position + ClientWidth, -VertScrollBar.Position + ClientHeight);
        FCanvas.CopyRect(ScrollRect, FBitmap.Canvas, Rect(0, 0, FBitmap.Width,
          FBitmap.Height));
      finally
        TControlCanvas(FCanvas).StopPaint;
      end;
    end else
      Result := False;
  end
  else Result := inherited EventFilter(Sender, Event);
end;

function TPreviewScrollBox.GetCanvas: TCanvas;
begin
  Result := FBitmap.Canvas;
end;

procedure TPreviewScrollBox.InitWidget;
begin
  inherited InitWidget;
  BorderStyle := bsEtched;
end;

procedure TFileDialogForm.PreviewPanelResize(Sender: TObject);
begin
  ClearPreview;
end;

procedure TFileDialogForm.FormLoaded(Sender: TObject);
begin
  FileIconsDirectoryChange(FileIcons, FileIcons.Directory.Location);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Clx\QFileDialog.pas initialization enter'); {$EndIf}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Clx\QFileDialog.pas initialization leave'); {$EndIf}
finalization

end.
