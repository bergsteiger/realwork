unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxBar, ExtCtrls, dxsbar, dxBarExtItems,
  ComCtrls, StdCtrls, ShellAPI, OleCtrls,
  dxBarExtDBItems, dxBarDBNav, Db, DBTables,
  SHDocVw_TLB, Grids, DBGrids, ActiveX, RichEdit, Menus;

type
  TMainForm = class(TForm)
    dxSideBarStore: TdxSideBarStore;
    dxSideBarStoreItem1: TdxStoredSideItem;
    dxSideBarStoreItem2: TdxStoredSideItem;
    dxSideBarStoreItem3: TdxStoredSideItem;
    BarManager: TdxBarManager;
    dxBarButtonNew: TdxBarButton;
    dxBarButtonOpen: TdxBarButton;
    dxBarButtonClose: TdxBarButton;
    dxBarButtonSave: TdxBarButton;
    dxBarButtonSaveAs: TdxBarButton;
    dxBarSubItemFile: TdxBarSubItem;
    dxBarSubItemEdit: TdxBarSubItem;
    dxBarSubItemFormat: TdxBarSubItem;
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
    dxBarButtonAlignLeft: TdxBarButton;
    dxBarButtonCenter: TdxBarButton;
    dxBarButtonAlignRight: TdxBarButton;
    dxBarButtonURLDetection: TdxBarButton;
    dxBarSubItemHelp: TdxBarSubItem;
    dxBarButtonOnWeb: TdxBarButton;
    dxBarButtonFont: TdxBarButton;
    Splitter1: TSplitter;
    OpenDialog: TOpenDialog;
    dxBarPopupMenu: TdxBarPopupMenu;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    FontDialog: TFontDialog;
    dxBarComboFontName: TdxBarFontNameCombo;
    dxBarComboFontColor: TdxBarColorCombo;
    LargeImage: TImageList;
    SmallImage: TImageList;
    dxBackBtn: TdxBarLargeButton;
    dxForwardBtn: TdxBarLargeButton;
    dxStopBtn: TdxBarLargeButton;
    dxRefreshBtn: TdxBarLargeButton;
    dxHomeBtn: TdxBarLargeButton;
    dxSearchBtn: TdxBarLargeButton;
    dxAddressCombo: TdxBarCombo;
    dxLinks: TdxBarStatic;
    dxProductsBtn: TdxBarButton;
    dxDownloadsBtn: TdxBarButton;
    BackPopupMenu: TdxBarPopupMenu;
    ForwardPopupMenu: TdxBarPopupMenu;
    dxBarHistory: TdxBarButton;
    dxCityCombo: TdxBarTreeViewCombo;
    dxProductsCombo: TdxBarLookupCombo;
    dxDate: TdxBarDateCombo;
    dxIESelectAllBtn: TdxBarButton;
    dxIEView: TdxBarSubItem;
    dxIEStop: TdxBarButton;
    dxGo: TdxBarSubItem;
    dxIERefreshBtn: TdxBarButton;
    dxIEBackBtn: TdxBarButton;
    dxIEForwardBtn: TdxBarButton;
    dxFavorites: TdxBarSubItem;
    dxIELinks: TdxBarSubItem;
    dxClearBtn: TdxBarButton;
    dxBarDBNavigator: TdxBarDBNavigator;
    dsContacts: TDataSource;
    tContacts: TTable;
    tContactsID: TAutoIncField;
    tContactsProductID: TIntegerField;
    tContactsFirstName: TStringField;
    tContactsLastName: TStringField;
    tContactsCompany: TStringField;
    tContactsAddress: TStringField;
    tContactsCity: TStringField;
    tContactsState: TStringField;
    tContactsPurchaseDate: TDateField;
    tContactsPaymentType: TStringField;
    tContactsPaymentAmount: TBCDField;
    tContactsproduct: TStringField;
    tContactsCustName: TStringField;
    tProducts: TTable;
    tProductsID: TIntegerField;
    tProductsNAME: TStringField;
    tProductsDescription: TStringField;
    dsProducts: TDataSource;
    GridImageList: TImageList;
    dxFilter: TdxBarSubItem;
    dxDBNavig: TdxBarSubItem;
    dxOptions: TdxBarButton;
    Panel3: TPanel;
    dxFORUMBtn: TdxBarButton;
    dxTypeCombo: TdxBarImageCombo;
    dxSideBarPopupMenu: TdxSideBarPopupMenu;
    FindDialog: TFindDialog;
    ReplaceDialog: TReplaceDialog;
    dxBarBDBNavFirst: TdxBarDBNavButton;
    dxBarBDBNavPrev: TdxBarDBNavButton;
    dxBarBDBNavNext: TdxBarDBNavButton;
    dxBarBDBNavLast: TdxBarDBNavButton;
    dxBarBDBNavInsert: TdxBarDBNavButton;
    dxBarBDBNavDelete: TdxBarDBNavButton;
    dxBarBDBNavEdit: TdxBarDBNavButton;
    dxBarBDBNavPost: TdxBarDBNavButton;
    dxBarBDBNavCancel: TdxBarDBNavButton;
    dxBarBDBNavRefresh: TdxBarDBNavButton;
    dxBarGroup1: TdxBarGroup;
    dxBSPosition: TdxBarStatic;
    dxBSStatus: TdxBarStatic;
    dxBarProgress: TdxBarProgressItem;
    Panel1: TPanel;
    dxSideBar: TdxSideBar;
    Image: TImage;
    Panel2: TPanel;
    Nb: TNotebook;
    PanelRE: TPanel;
    Editor: TRichEdit;
    HTMLPanel: TPanel;
    DBGrid1: TDBGrid;
    dxBDStatus: TdxBarDockControl;
    dxBSIEStatus: TdxBarStatic;
    procedure FormCreate(Sender: TObject);
    procedure dxSideBarItemClick(Sender: TObject; Item: TdxSideBarItem);
    procedure dxBarButtonNewClick(Sender: TObject);
    procedure dxBarButtonOpenClick(Sender: TObject);
    procedure dxBarButtonCloseClick(Sender: TObject);
    procedure EditorChange(Sender: TObject);
    procedure EditorSelectionChange(Sender: TObject);
    procedure dxBarButtonExitClick(Sender: TObject);
    procedure dxBarButtonSaveClick(Sender: TObject);
    procedure dxBarButtonSaveAsClick(Sender: TObject);
    procedure dxBarButtonPrintClick(Sender: TObject);
    procedure dxBarButtonUndoClick(Sender: TObject);
    procedure dxBarButtonCutClick(Sender: TObject);
    procedure dxBarButtonCopyClick(Sender: TObject);
    procedure dxBarButtonPasteClick(Sender: TObject);
    procedure dxBarButtonClearClick(Sender: TObject);
    procedure dxBarButtonSelectAllClick(Sender: TObject);
    procedure dxBarButtonFindClick(Sender: TObject);
    procedure dxBarButtonReplaceClick(Sender: TObject);
    procedure dxBarButtonFontClick(Sender: TObject);
    procedure dxBarButtonBulletsClick(Sender: TObject);
    procedure dxBarButtonProtectedClick(Sender: TObject);
    procedure dxBarComboFontColorChange(Sender: TObject);
    procedure dxBarComboFontColorClick(Sender: TObject);
    procedure dxBarComboHighlightClick(Sender: TObject);
    procedure dxBarButtonURLDetectionClick(Sender: TObject);
    procedure dxBarButtonOnWebClick(Sender: TObject);
    procedure dxBarComboFontNameChange(Sender: TObject);
    procedure dxBarComboFontNameClick(Sender: TObject);
    procedure dxBarComboFontSizeChange(Sender: TObject);
    procedure dxBarComboFontSizeClick(Sender: TObject);
    procedure dxBarButtonBoldClick(Sender: TObject);
    procedure dxBarButtonItalicClick(Sender: TObject);
    procedure dxBarButtonUnderlineClick(Sender: TObject);
    procedure dxBarButtonAlignLeftClick(Sender: TObject);
    procedure dxBarButtonCenterClick(Sender: TObject);
    procedure dxBarButtonAlignRightClick(Sender: TObject);
    procedure dxAddressComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dxAddressComboDrawItem(Sender: TdxBarCustomCombo;
      AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
    procedure dxStopBtnClick(Sender: TObject);
    procedure dxRefreshBtnClick(Sender: TObject);
    procedure dxHomeBtnClick(Sender: TObject);
    procedure dxProductsBtnClick(Sender: TObject);
    procedure dxAddressComboChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dxBackBtnClick(Sender: TObject);
    procedure dxForwardBtnClick(Sender: TObject);
    procedure dxBarHistoryClick(Sender: TObject);
    procedure dxSearchBtnClick(Sender: TObject);
    procedure dxCityComboChange(Sender: TObject);
    procedure dxClearBtnClick(Sender: TObject);
    procedure dxProductsComboChange(Sender: TObject);
    procedure dxDateChange(Sender: TObject);
    procedure dxOptionsClick(Sender: TObject);
    procedure dxTypeComboChange(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure ReplaceDialogReplace(Sender: TObject);
    procedure tContactsCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FUpdating: Boolean;
    HistoryIndex: Integer;
    HistoryList: TStringList;
    UpdateCombo: Boolean;
    FileName : string;
    Address : string;
    HTML : TWebBrowser;
    procedure UpdateToolBar( index : integer);
    procedure FindAddress;
  public
    { Public declarations }
    function SaveFile(ASaveAs: Boolean): Boolean;
    function AskSaveFile: Boolean;
    procedure SetModified(Value: Boolean);
    procedure ShowItems(AShow: Boolean);
    procedure SetFilter;
    procedure StatusTextChange(Sender: TObject; const Text: WideString);
    procedure TitleChange(Sender: TObject; const Text: WideString);
    procedure DocumentComplete(Sender: TObject; pDisp: IDispatch; var URL: OleVariant);
    procedure ProgressChange(Sender: TObject; Progress, ProgressMax: Integer);
    procedure BeforeNavigate(Sender: TObject; pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData, Headers: OleVariant; var Cancel: WordBool);

  end;

var MainForm : TMainForm;
implementation

uses Options{$IFDEF VER140}, Variants{$ENDIF};

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
const
  Filter = 'Rich Text Files (*.RTF)|*.RTF';
begin
  HTML := TWebBrowser.Create(HTMLPanel);
  TWinControl(HTML).Parent := HTMLPanel;

  HTML.OnDocumentComplete := DocumentComplete;
  HTML.OnProgressChange := ProgressChange;
  HTML.OnBeforeNavigate2 := BeforeNavigate;
  HTML.OnStatusTextChange := StatusTextChange;
  HTML.OnTitleChange := TitleChange;

  HTML.Align := alClient;

  Address := '';
  ShortDateFormat := 'mm/dd/yyyy';
  UpdateCombo := True;
  OpenDialog.Filter := Filter;
  SaveDialog.Filter := Filter;
  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
  SaveDialog.InitialDir := OpenDialog.InitialDir;
  Editor.Clear;
  PanelRE.Visible := False;
  SetModified(False);
  ShowItems(False);
  BarManager.LockUpdate := True;
  UpdateToolBar(0);
  BarManager.LockUpdate := False;
  HistoryIndex := -1;
  HistoryList := TStringList.Create;
  tProducts.Close;
  tContacts.Close;
  tProducts.Open;
  tContacts.Open;
  dxDate.Text := '';
end;

procedure TMainForm.UpdateToolBar( Index  : integer);

type TVisibleItems = set of Char;

const
  SunkenBorders: array [0..3] of Boolean = (False, False, True, False);
  VisibleBars: array [0..3] of TVisibleItems = ([#0], [#0..#3,#9], [#0, #4..#6,#9], [#0,#7,#8]);
  VisibleCategories: array [0..3] of TVisibleItems = ([#0,#4,#5], [#0..#5], [#0,#1,#5,#4,#6,#7,#8,#10,#11], [#0,#4,#5,#9,#12]);
var
  I : Integer;
begin
  with BarManager do
  begin
    SunkenBorder := SunkenBorders[Index];
    for I := 0 to Categories.Count - 1 do
      CategoryVisible[I] := (Chr(I) in VisibleCategories[Index]);
    for I := Bars.Count - 1 downto 0 do
      if (not(Chr(I) in VisibleBars[Index])) or (I = 0) then
      begin
        Bars[I].Visible := False;
        Bars[I].Hidden := True;
      end;
    for I := 0 to ItemCount - 1 do
      if (Items[I].Tag = 0 ) or (Items[I].Tag = Index) then
       Items[I].Visible := ivAlways
      else
       Items[I].Visible := ivNever;
    for i := 0 to Bars.Count - 1 do
      if (Chr(I) in VisibleBars[Index]) or (I = 0) then
      begin
        Bars[I].Visible := True;
        Bars[I].Hidden := False;
      end;
    NB.PageIndex := Index;
  end;
  dxBSIEStatus.Caption := '';
  dxBSStatus.Caption := '';
  dxBSPosition.Caption := '';
  dxBarProgress.Position := 0;
  dxBSIEStatus.Glyph := nil;
  if Index = 2 then
    dxBSIEStatus.Glyph.Assign(Image.Picture.Bitmap);

end;

procedure TMainForm.dxSideBarItemClick(Sender: TObject;
  Item: TdxSideBarItem);
begin
  Caption := 'ExpressBars Demo';
  LockWindowUpdate(MainForm.Handle);
  BarManager.LockUpdate := True;
  UpdateToolBar(Item.Tag);
  BarManager.LockUpdate := False;
  LockWindowUpdate(0);
end;

procedure TMainForm.dxBarButtonNewClick(Sender: TObject);
var
  Res : Integer;
begin
  if Editor.Modified then
  begin
    Res := Application.MessageBox(PChar(Format('Do you want to save the changes you made ?',
      [FileName])), PChar(FileName), MB_ICONQUESTION or MB_YESNOCANCEL);
    case Res of
      ID_YES:
        if SaveFile(False) then
          Editor.Lines.Clear
        else
          exit;
      ID_NO:
        Editor.Lines.Clear;
      ID_CANCEL:
        exit;
    end;
  end;
  Editor.Lines.Clear;
  FileName := '';
  ShowItems(True);
end;

function TMainForm.AskSaveFile: Boolean;
var
 Res: Integer;
begin
  Result := True;
  if Editor.Modified then
  begin
    Res := Application.MessageBox(PChar(Format('Do you want to save the changes you made to "%s"?',
    [FileName])), PChar(FileName), MB_ICONQUESTION or MB_YESNOCANCEL);
    if Res = ID_CANCEL then
      Result := False;
    if Res = ID_YES then
      Result := SaveFile(False);
  end;
end;

procedure TMainForm.dxBarButtonCloseClick(Sender: TObject);
begin
  if not AskSaveFile then exit;
  Editor.Lines.Clear;
  ShowItems(False);
end;

procedure TMainForm.dxBarButtonOpenClick(Sender: TObject);
begin
  if not AskSaveFile then exit;
  OpenDialog.FileName := '';
  if OpenDialog.Execute then
  begin
    FileName := OpenDialog.FileName;
    Editor.Lines.LoadFromFile(FileName);
    SetModified(False);
    ShowItems(True);
  end;
end;


procedure TMainForm.EditorChange(Sender: TObject);
begin
  if Editor = nil then Exit;
  Editor.OnSelectionChange(Editor);
  SetModified(Editor.Modified);
  dxBarButtonUndo.Caption := '&Undo';
  dxBarButtonUndo.Enabled := SendMessage(Editor.Handle, EM_CANUNDO, 0, 0) <> 0;
end;

procedure TMainForm.EditorSelectionChange(Sender: TObject);
var Col, Row : integer;
begin

  Row := SendMessage(Editor.Handle, EM_LINEFROMCHAR, Editor.SelStart, 0);
  Col := Editor.SelStart - SendMessage(Editor.Handle, EM_LINEINDEX, Row, 0);

  with Editor, SelAttributes do
  begin
    FUpdating := True;
    try
       dxBSPosition.Caption :=
         Format('Line: %3d   Col: %3d', [1 + Row, 1 + Col]);

       dxBarButtonCopy.Enabled := SelLength > 0;
       dxBarButtonCut.Enabled := dxBarButtonCopy.Enabled;
       dxBarButtonPaste.Enabled := ((SendMessage(Editor.Handle, EM_CANPASTE, 0, 0) <> 0) and dxBarButtonSave.Enabled);
       dxBarButtonClear.Enabled := dxBarButtonCopy.Enabled;

       dxBarComboFontSize.Text := IntToStr(Size);
       dxBarComboFontName.Text := Name;

       dxBarButtonBold.Down := fsBold in Style;
       dxBarButtonItalic.Down := fsItalic in Style;
       dxBarButtonUnderline.Down := fsUnderline in Style;

       dxBarButtonBullets.Down := Boolean(Paragraph.Numbering);
       case Ord(Paragraph.Alignment) of
         0: dxBarButtonAlignLeft.Down := True;
         1: dxBarButtonAlignRight.Down := True;
         2: dxBarButtonCenter.Down := True;
       end;
       dxBarButtonURLDetection.Down := Boolean(SendMessage(Editor.Handle, EM_GETAUTOURLDETECT, 0, 0));

       dxBarComboFontColor.Color := Editor.SelAttributes.Color;
    finally
      FUpdating := False;
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
  if Value then
    dxBSStatus.Caption := 'Modified'
  else
    dxBSStatus.Caption := '';
  if FileName <> '' then
    dxBarButtonSave.Enabled := Value;
end;

procedure TMainForm.ShowItems(AShow: Boolean);
var
  AVisible: TdxBarItemVisible;
begin
  if not AShow then
  begin
    dxBSStatus.Caption := '';
    dxBSPosition.Caption := '';
  end;
  BarManager.Groups[0].Enabled := AShow;
  if AShow then AVisible := ivAlways
  else AVisible := ivInCustomizing;

  dxBarSubItemEdit.Visible := AVisible;
  dxBarSubItemFormat.Visible := AVisible;

  PanelRE.Visible := AShow;
  Editor.Repaint;
end;

procedure TMainForm.dxBarButtonExitClick(Sender: TObject);
begin
  Close;
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
  if PrintDialog.Execute then
    Editor.Print(FileName);
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
  Editor.SelLength := 0;
  FindDialog.Execute;
end;

procedure TMainForm.dxBarButtonReplaceClick(Sender: TObject);
begin
  Editor.SelLength := 0;
  ReplaceDialog.Execute;
end;

procedure TMainForm.dxBarButtonFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(Editor.SelAttributes);
  if FontDialog.Execute then
    Editor.SelAttributes.Assign(FontDialog.Font);
end;

procedure TMainForm.dxBarButtonBulletsClick(Sender: TObject);
begin
  Editor.Paragraph.Numbering := TNumberingStyle(dxBarButtonBullets.Down);
end;

procedure TMainForm.dxBarButtonProtectedClick(Sender: TObject);
begin
  Editor.SelAttributes.Protected := not Editor.SelAttributes.Protected;
end;

procedure TMainForm.dxBarComboFontColorChange(Sender: TObject);
begin
  if not FUpdating then
    Editor.SelAttributes.Color := dxBarComboFontColor.Color;
end;

procedure TMainForm.dxBarComboFontColorClick(Sender: TObject);
begin
  FontDialog.Font.Assign(Editor.SelAttributes);
  if FontDialog.Execute then
    Editor.SelAttributes.Assign(FontDialog.Font);
end;

procedure TMainForm.dxBarComboHighlightClick(Sender: TObject);
begin
  FontDialog.Font.Assign(Editor.SelAttributes);
  if FontDialog.Execute then
    Editor.SelAttributes.Assign(FontDialog.Font);
end;

procedure TMainForm.dxBarButtonURLDetectionClick(Sender: TObject);
var URLDetection : Boolean;
begin
  URLdetection := Boolean(SendMessage(Editor.Handle, EM_GETAUTOURLDETECT, 0, 0));
  URLdetection := not URLdetection;
  SendMessage(Editor.Handle, EM_AUTOURLDETECT, Longint(URLdetection), 0);
end;

procedure TMainForm.dxBarButtonOnWebClick(Sender: TObject);
begin
  ShellExecute(0, nil, 'http://www.devexpress.com', nil, nil, SW_RESTORE);
end;

procedure TMainForm.dxBarComboFontNameChange(Sender: TObject);
begin
  if not FUpdating then
    Editor.SelAttributes.Name := dxBarComboFontName.Text;
end;

procedure TMainForm.dxBarComboFontNameClick(Sender: TObject);
begin
  FontDialog.Font.Assign(Editor.SelAttributes);
  if FontDialog.Execute then
    Editor.SelAttributes.Assign(FontDialog.Font);
end;

procedure TMainForm.dxBarComboFontSizeChange(Sender: TObject);
begin
  if not FUpdating then
    Editor.SelAttributes.Size := StrToInt(dxBarComboFontSize.Text);
end;

procedure TMainForm.dxBarComboFontSizeClick(Sender: TObject);
begin
  FontDialog.Font.Assign(Editor.SelAttributes);
  if FontDialog.Execute then
    Editor.SelAttributes.Assign(FontDialog.Font);
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

procedure TMainForm.dxBarButtonAlignLeftClick(Sender: TObject);
begin
  if TdxBarButton(Sender).Down then
    Editor.Paragraph.Alignment := TAlignment(0)
  else
    Editor.Paragraph.Alignment := taLeftJustify;
end;

procedure TMainForm.dxBarButtonCenterClick(Sender: TObject);
begin
  if TdxBarButton(Sender).Down then
    Editor.Paragraph.Alignment := TAlignment(2)
  else
    Editor.Paragraph.Alignment := taLeftJustify;
end;

procedure TMainForm.dxBarButtonAlignRightClick(Sender: TObject);
begin
  if TdxBarButton(Sender).Down then
    Editor.Paragraph.Alignment := TAlignment(1)
  else
    Editor.Paragraph.Alignment := taLeftJustify;
end;

procedure TMainForm.dxAddressComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    dxAddressCombo.Items.Insert(0, Address);
end;

procedure TMainForm.dxAddressComboDrawItem(Sender: TdxBarCustomCombo;
  AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
var
  RectText: TRect;
begin
  with Sender,Canvas,ARect do
  begin
    Brush.Color := clWindow;
    FillRect(ARect);
    RectText := ARect;
    Inc(RectText.Left, 16);
    if AIndex >= 0 then
      RectText.Right := RectText.Left + TextWidth(Items[AIndex]) + 4;
    if odSelected in AState then
    begin
      Brush.Color := clHighlight;
      FillRect(RectText);
    end;
    if AIndex >= 0 then
    begin
      Draw(Left + 1, Top + 2, Image.Picture.Bitmap);
      TextOut(RectText.Left + 2, Top , Items[AIndex]);
    end
    else
      if Sender.Text <> '' then begin
        Draw(Left + 1, Top + 2, Image.Picture.Bitmap);
        TextOut(RectText.Left + 2, Top , Sender.Text);
      end;
    if odSelected in AState then
      DrawFocusRect(RectText);
  end;
end;

procedure TMainForm.FindAddress;
var Flags, TargetFrameName, PostData, Headers: OleVariant;
begin
  HTML.Navigate(Address, Flags, TargetFrameName, PostData, Headers);
end;


procedure TMainForm.dxStopBtnClick(Sender: TObject);
begin
  if HistoryIndex <> -1 then HTML.Stop;
end;

procedure TMainForm.dxRefreshBtnClick(Sender: TObject);
begin
  if HistoryIndex <> -1 then HTML.Refresh;
end;

procedure TMainForm.dxHomeBtnClick(Sender: TObject);
begin
 Address := 'http://www.devexpress.com/';
 FindAddress;
end;

procedure TMainForm.dxProductsBtnClick(Sender: TObject);
begin
 Address := TdxBarButton(Sender).Hint;
 FindAddress;
end;

procedure TMainForm.dxAddressComboChange(Sender: TObject);
begin
  if UpdateCombo then
  begin
    Address := dxAddressCombo.Text;
    FindAddress;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  HTML.Stop;
  HistoryList.Free;
  HTML.Free;
end;

procedure TMainForm.dxBackBtnClick(Sender: TObject);
begin
  Address := HistoryList[HistoryIndex - 1];
  FindAddress;
end;

procedure TMainForm.dxForwardBtnClick(Sender: TObject);
begin
  Address := HistoryList[HistoryIndex + 1];
  FindAddress;
end;

procedure TMainForm.dxBarHistoryClick(Sender: TObject);
begin
  if TdxBarButton(Sender).ClickItemLink <> nil then
  begin
    Address := TdxBarButton(Sender).ClickItemLink.UserCaption;
    FindAddress;
  end;
end;

procedure TMainForm.dxSearchBtnClick(Sender: TObject);
begin
  HTML.GoSearch;
end;

procedure TMainForm.dxCityComboChange(Sender: TObject);
begin
  SetFilter;
end;

procedure TMainForm.SetFilter;
const
  PaymentStr: array [0..3] of string = ('CASH', 'VISA', 'MASTER', 'AMEX');
var
  Filter: string;
  I: integer;
begin
  Filter := '';
  with dxCityCombo do
    if Text <> '' then
      if TreeView.Selected.Count = 0 then
        Filter := 'City = ''' + Text + ''''
      else
      begin
        for I := 0 to TreeView.Selected.Count - 1 do
          if Filter = '' then
            Filter := Filter + '( City = ''' + TreeView.Selected.Item[I].Text + ''' )'
          else
            Filter := Filter + ' or ( City = ''' + TreeView.Selected.Item[I].Text + ''' )';
      end;
    if Filter <> '' then
      Filter := '(' + Filter + ')';
    if dxProductsCombo.Text <> '' then
      if Filter = '' then
        Filter := '( ProductID = ' + TProducts.FieldByName('ID').AsString + ')'
      else Filter := Filter + ' and ( ProductID = ' + TProducts.FieldByName('ID').AsString + ')';
    if dxDate.Text <> '' then
      if Filter = '' then
        Filter := '( PurchaseDate = ''' + DateToStr(dxDate.Date) + ''')'
      else
        Filter := Filter + ' and ( PurchaseDate = ''' + DateToStr(dxDate.Date) + ''')';
    if dxTypeCombo.Text <> '' then
      if Filter = '' then
        Filter := '( PaymentType = ''' + PaymentStr[dxTypeCombo.ItemIndex] + ''')'
      else
        Filter := Filter + ' and ( PaymentType = ''' + PaymentStr[dxTypeCombo.ItemIndex] + ''')';
  tContacts.Filter := Filter;
  tContacts.Filtered := True;
end;

procedure TMainForm.dxClearBtnClick(Sender: TObject);
begin
  dxCityCombo.Text := '';
  dxProductsCombo.KeyValue := null;
  dxProductsCombo.Text := '';
  dxDate.Text := '';
  dxTypeCombo.ItemIndex := -1;
  tContacts.Filter := '';
  tContacts.Filtered := False;
end;

procedure TMainForm.dxProductsComboChange(Sender: TObject);
begin
  SetFilter;
end;

procedure TMainForm.dxDateChange(Sender: TObject);
begin
  SetFilter;
end;

procedure TMainForm.dxOptionsClick(Sender: TObject);
begin
  OptionsForm.ShowModal;
end;

procedure TMainForm.dxTypeComboChange(Sender: TObject);
begin
  SetFilter;
end;

procedure TMainForm.ProgressChange(Sender: TObject; Progress,
  ProgressMax: Integer);
begin
  dxBarProgress.Max := ProgressMax;
  dxBarProgress.Position := Progress;
end;

procedure TMainForm.DocumentComplete(Sender: TObject; pDisp: IDispatch; var URL: OleVariant);
begin
  dxBarProgress.Position := 0;
end;

procedure TMainForm.FindDialogFind(Sender: TObject);
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
        Application.MessageBox('Text not found', 'Information', MB_ICONINFORMATION);
  end;
end;

procedure TMainForm.ReplaceDialogReplace(Sender: TObject);
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
      FindDialogFind(Sender);
    until not (frReplaceAll in Options) or (SelStart = PrevSelStart);
    if frReplaceAll in Options then
    begin
      Screen.Cursor := crDefault;
      if ReplacedCount = 0 then S := 'Text not found'
      else
      begin
        SelStart := OldSelStart;
        S := Format('Replace All', [ReplacedCount]);
      end;
      Application.MessageBox(PChar(S), 'Information',
        MB_ICONINFORMATION);
    end;
  end;
end;

procedure TMainForm.BeforeNavigate(Sender: TObject; pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData, Headers: OleVariant; var Cancel: WordBool);
var
  NewIndex, I: Integer;
  NAddress: string;
begin

  NAddress := URL;
  if NAddress = '' then NAddress := Address;
  if NAddress = '' then exit;

  NewIndex := HistoryList.IndexOf(NAddress);
  if NewIndex = -1 then
  begin
    HistoryList.Add(NAddress);
    NewIndex := HistoryList.IndexOf(NAddress);
  end;

  UpdateCombo := False;
  dxAddressCombo.Text := NAddress;
  UpdateCombo := True;


  with ForwardPopupMenu.ItemLinks do begin
   Clear;
   for I := HistoryList.Count - 1 downto NewIndex + 1 do
    with Add do
     begin
      Index := 0;
      Item := dxBarHistory;
      UserCaption := HistoryList[i];
     end;
   end;

  with BackPopupMenu.ItemLinks do begin
   Clear;
   for i := 0 to NewIndex - 1 do
    with Add do
     begin
      Index := 0;
      Item := dxBarHistory;
      UserCaption := HistoryList[I];
     end;
   end;

  HistoryIndex := NewIndex;

  if HistoryIndex = 0 then begin
    dxBackBtn.Enabled := False;
    dxIEBackBtn.Enabled := False;
  end else begin
    dxBackBtn.Enabled := True;
    dxIEBackBtn.Enabled := True;
  end;

  if HistoryIndex = HistoryList.Count - 1 then begin
    dxForwardBtn.Enabled := False;
    dxIEForwardBtn.Enabled := False;
  end else begin
    dxForwardBtn.Enabled := True;
    dxIEForwardBtn.Enabled := True;
  end;
end;

procedure TMainForm.StatusTextChange(Sender: TObject; const Text: WideString);
begin
  if Text = '' then
    dxBSIEStatus.Caption := 'Done'
  else
    dxBSIEStatus.Caption := TCaption(Text);
end;

procedure TMainForm.TitleChange(Sender: TObject; const Text: WideString);
begin
  Caption := TCaption(Text);
end;

procedure TMainForm.tContactsCalcFields(DataSet: TDataSet);
begin
  with DataSet do
    FieldByname('CustName').AsString := FieldByname('FirstName').AsString + ' ' + FieldByname('LastName').AsString;
end;

end.
