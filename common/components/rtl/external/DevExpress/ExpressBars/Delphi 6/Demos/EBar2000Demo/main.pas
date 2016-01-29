unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxBar, dxBarExtItems, stdctrls, Buttons, ExtCtrls;

type
  TMainForm = class(TForm)
    dxBarManager: TdxBarManager;
    siFile: TdxBarSubItem;
    siEdit: TdxBarSubItem;
    siView: TdxBarSubItem;
    siInsert: TdxBarSubItem;
    siFormat: TdxBarSubItem;
    siTools: TdxBarSubItem;
    siTable: TdxBarSubItem;
    siWindow: TdxBarSubItem;
    siHelp: TdxBarSubItem;
    btnNew: TdxBarButton;
    btnNewWebPage: TdxBarButton;
    btnNewEmailMessage: TdxBarButton;
    btnNewBlankDocument: TdxBarButton;
    btnOpen: TdxBarButton;
    btnClose: TdxBarButton;
    btnCloseAll: TdxBarButton;
    btnSave: TdxBarButton;
    btnSaveAs: TdxBarButton;
    btnSaveAsWebPage: TdxBarButton;
    btnSaveAll: TdxBarButton;
    btnSaveVersion: TdxBarButton;
    btnWebPagePreview: TdxBarButton;
    btnPageSetup: TdxBarButton;
    btnPrintPreview: TdxBarButton;
    btnPrint: TdxBarButton;
    btnPrintSetup: TdxBarButton;
    btnMailRecipient: TdxBarButton;
    btnSendNow: TdxBarButton;
    btnRoundRecipient: TdxBarButton;
    btnExchengeFolder: TdxBarButton;
    btnFaxRecipient: TdxBarButton;
    btnSendToMicrosoftPowerPoint: TdxBarButton;
    btnVersion: TdxBarButton;
    btnProperties: TdxBarButton;
    btnExit: TdxBarButton;
    btnUndo: TdxBarButton;
    btnRedo: TdxBarButton;
    btnRepeat: TdxBarButton;
    btnCut: TdxBarButton;
    btnCopy: TdxBarButton;
    btnPaste: TdxBarButton;
    btnPasteTable: TdxBarButton;
    btnPasteSpecial: TdxBarButton;
    btnPasetAsHyperlink: TdxBarButton;
    btnClear: TdxBarButton;
    dxBarButton1: TdxBarButton;
    btnFind: TdxBarButton;
    btnFindNext: TdxBarButton;
    btnReplace: TdxBarButton;
    btnGoTo: TdxBarButton;
    btnLinks: TdxBarButton;
    btnObject: TdxBarButton;
    btnPicture: TdxBarButton;
    btnCreateTextBoxLink: TdxBarButton;
    btnBreakForwardLink: TdxBarButton;
    btnNextTextBox: TdxBarButton;
    btnPreviousTextBox: TdxBarButton;
    btnNextComment: TdxBarButton;
    btnPreviousComment: TdxBarButton;
    cbZoom: TdxBarCombo;
    btnRuler: TdxBarButton;
    btnShowAll: TdxBarButton;
    btnDocumentMap: TdxBarButton;
    btnViewFieldCodes: TdxBarButton;
    btnShowFieldShading: TdxBarButton;
    btnFullScreen: TdxBarButton;
    btnMagnifier: TdxBarButton;
    btnZoom100: TdxBarButton;
    btnFitToWindow: TdxBarButton;
    btnOnePage: TdxBarButton;
    btnNormal: TdxBarButton;
    btnWebLayout: TdxBarButton;
    btnPrintLayout: TdxBarButton;
    btnOutLine: TdxBarButton;
    siToolBars: TdxBarSubItem;
    btnComments: TdxBarButton;
    btnHTMLSource: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    btnPromote: TdxBarButton;
    btnDemote: TdxBarButton;
    btnDemoteToBodyText: TdxBarButton;
    btnMoveUp: TdxBarButton;
    btnMoveDown: TdxBarButton;
    btnExpand: TdxBarButton;
    btnCollapse: TdxBarButton;
    btnAll: TdxBarButton;
    btnShowHeading1: TdxBarButton;
    btnShowHeading2: TdxBarButton;
    btnShowHeading3: TdxBarButton;
    btnShowHeading4: TdxBarButton;
    btnShowHeading5: TdxBarButton;
    btnFirstLineOnlyView: TdxBarButton;
    btnShowFormatting: TdxBarButton;
    btnMasterDocumentView: TdxBarButton;
    btnNextHeader: TdxBarButton;
    btnPreviousHeader1: TdxBarButton;
    btnHideBodyText: TdxBarButton;
    btnPageBreak: TdxBarButton;
    btnInsertColumnBreak: TdxBarButton;
    btnInsertSectionBreak: TdxBarButton;
    btnPageNumber: TdxBarButton;
    btnNumberOfPages: TdxBarButton;
    btnDate: TdxBarButton;
    btnTime: TdxBarButton;
    btnPageNumbers: TdxBarButton;
    btnDateAndTime: TdxBarButton;
    btnAutoText: TdxBarButton;
    btnSumbol: TdxBarButton;
    btnComment: TdxBarButton;
    btnDeleteComment: TdxBarButton;
    btnFootnote: TdxBarButton;
    InsertListNumField: TdxBarButton;
    btnHyperlink: TdxBarButton;
    btnFromFile: TdxBarButton;
    btnTextBox: TdxBarButton;
    btnHorizontal: TdxBarButton;
    btnFile: TdxBarButton;
    btnInsertExcelSpreadsheet: TdxBarButton;
    btnChart: TdxBarButton;
    btnWordArt: TdxBarButton;
    btnEquationEditor: TdxBarButton;
    btnVoiceComment: TdxBarButton;
    btnPenComment: TdxBarButton;
    btnFromScannerOrCamear: TdxBarButton;
    btnClipArt: TdxBarButton;
    btnDataBase: TdxBarButton;
    btnAddressBook: TdxBarButton;
    btnObject1: TdxBarButton;
    cbFontName: TdxBarFontNameCombo;
    cnFontSize: TdxBarCombo;
    cbStyle: TdxBarCombo;
    btnBold: TdxBarButton;
    btnItalic: TdxBarButton;
    btnUnderline: TdxBarButton;
    btnFormatPainter: TdxBarButton;
    btnGrowFont: TdxBarButton;
    btnShrinkFont: TdxBarButton;
    btnGrowFont1Pt: TdxBarButton;
    btnShinkFont1Pt: TdxBarButton;
    btnSmallCaps: TdxBarButton;
    btnAllCaps: TdxBarButton;
    btnSuperscript: TdxBarButton;
    btnsubscript: TdxBarButton;
    btnDecreaseIndent: TdxBarButton;
    btnIncreaseIndent: TdxBarButton;
    btnNumbering: TdxBarButton;
    btnBullets: TdxBarButton;
    btnAlignLeft: TdxBarButton;
    btnCenter: TdxBarButton;
    btnAlignRight: TdxBarButton;
    btnJustify: TdxBarButton;
    btnColumns: TdxBarButton;
    btnAutoFormat: TdxBarButton;
    btnInsertListNumField: TdxBarButton;
    btnChangeTextDirection: TdxBarButton;
    btnFont: TdxBarButton;
    btnParagraph: TdxBarButton;
    btnBulletsAndNumbering1: TdxBarButton;
    btnGropCap: TdxBarButton;
    btnStyle: TdxBarButton;
    btnTextDirection: TdxBarButton;
    btnChangeCase: TdxBarButton;
    btnTheme: TdxBarButton;
    btnCOMAddIns: TdxBarButton;
    btnSpellingandGrammar: TdxBarButton;
    btnNextMisspelling: TdxBarButton;
    btnHideSpellingErrors: TdxBarButton;
    btnHideGrammarErrors: TdxBarButton;
    btnSpelling: TdxBarButton;
    btnDictionary: TdxBarButton;
    btnGrammar: TdxBarButton;
    btnSetLanguage: TdxBarButton;
    btnThesaurus: TdxBarButton;
    btnWordCount: TdxBarButton;
    btnAutoSummarize: TdxBarButton;
    btnResumarize: TdxBarButton;
    btnHighlightShowOnlySummary: TdxBarButton;
    btnAutoCorrect: TdxBarButton;
    btnToolsAutoCorrectExceptions: TdxBarButton;
    btnHighlightChanges: TdxBarButton;
    btnTrackChanges: TdxBarButton;
    btnAcceptOrRejectChanges: TdxBarButton;
    btnAcceptChange: TdxBarButton;
    btnRejectChange: TdxBarButton;
    btnNextChange: TdxBarButton;
    btnPreviousChange: TdxBarButton;
    btnCompareDocuments: TdxBarButton;
    btnMergeDocuments: TdxBarButton;
    btnProtectDocument: TdxBarButton;
    btnEnvelopesAndLabels: TdxBarButton;
    btnLetterWizard: TdxBarButton;
    btnMacros: TdxBarButton;
    btnRecordMacroStopRecorder: TdxBarButton;
    btnSecurity: TdxBarButton;
    btnVisualBasicEditor: TdxBarButton;
    btnMicrosoftScriptEditor: TdxBarButton;
    btnInsertScript: TdxBarButton;
    btnRemoveAllScripts: TdxBarButton;
    btnShowAllScripts: TdxBarButton;
    btnStopRecordind: TdxBarButton;
    btnPauseRecording: TdxBarButton;
    btnUpdateField: TdxBarButton;
    btnRepaginate: TdxBarButton;
    btnShrinkOnePage: TdxBarButton;
    btnInsertTable: TdxBarButton;
    dxBarButton4: TdxBarButton;
    btnCells: TdxBarButton;
    btnRows: TdxBarButton;
    btnColumnsToTheLeft: TdxBarButton;
    btnDeleteCells: TdxBarButton;
    btnDeleteRows: TdxBarButton;
    btnDeleteColumns: TdxBarButton;
    btnGridLines: TdxBarButton;
    btnTableAutoFormat: TdxBarButton;
    btnAutoSum: TdxBarButton;
    btnSortAscepring: TdxBarButton;
    btnSortDescending: TdxBarButton;
    btnFindInField: TdxBarButton;
    btnTableInsert: TdxBarSubItem;
    btnTablesandBordersToolbar: TdxBarButton;
    btnDrawTable: TdxBarButton;
    btnEraser: TdxBarButton;
    btnMergeCells: TdxBarButton;
    btnAplitCells: TdxBarButton;
    btnAlignTop: TdxBarButton;
    btnCenterVerticaly: TdxBarButton;
    btnAlignBottom: TdxBarButton;
    siCellAlignment: TdxBarSubItem;
    btnDistributeRowsEvenly: TdxBarButton;
    btnDistributeColumnsEvenly: TdxBarButton;
    btnNewWindow: TdxBarButton;
    btnArrangeAll: TdxBarButton;
    btnSplit: TdxBarButton;
    btnNextWindow: TdxBarButton;
    btnPreviousWindow: TdxBarButton;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    dxBarButton10: TdxBarButton;
    dxBarButton11: TdxBarButton;
    dxBarButton12: TdxBarButton;
    dxBarButton13: TdxBarButton;
    dxBarButton14: TdxBarButton;
    Images: TImageList;
    siSendTo: TdxBarSubItem;
    siPicture: TdxBarSubItem;
    siLanguage: TdxBarSubItem;
    btnCustomize: TdxBarButton;
    siMacro: TdxBarSubItem;
    siInsertTable: TdxBarSubItem;
    siDeleteTable: TdxBarSubItem;
    siAutoFit: TdxBarSubItem;
    btnTableProperties: TdxBarButton;
    StyleImages: TImageList;
    btnFontColor: TdxBarButton;
    btnHightlight: TdxBarButton;
    FontColorPopupMenu: TdxBarPopupMenu;
    HightlightColorPopupMenu: TdxBarPopupMenu;
    btnFontColorItem: TdxBarButton;
    btnDownFontColorItem: TdxBarButton;
    btnCustomFontColor: TdxBarButton;
    ColorDialog: TColorDialog;
    btnColorItem: TdxBarButton;
    btnDownColorItem: TdxBarButton;
    btnCustomColor: TdxBarButton;
    btnStandard: TdxBarButton;
    btnFormatting: TdxBarButton;
    FontDialog: TFontDialog;
    btnInternet: TdxBarButton;
    cbAddress: TdxBarCombo;
    btnBack: TdxBarLargeButton;
    btnForward: TdxBarLargeButton;
    btnStop: TdxBarLargeButton;
    btnRefresh: TdxBarLargeButton;
    btnHome: TdxBarLargeButton;
    gbOptions: TGroupBox;
    sbFont: TSpeedButton;
    cbCanCustomize: TCheckBox;
    pDockColor: TPanel;
    sbDockColor: TSpeedButton;
    cbAllowReset: TCheckBox;
    cbShowHelpButton: TCheckBox;
    cbSunkenBorder: TCheckBox;
    cbMenusShowRecentItemsFirst: TCheckBox;
    rgMenuAnimations: TRadioGroup;
    bgBar1: TGroupBox;
    SpeedButton1: TSpeedButton;
    cbAllowCustomizingBar1: TCheckBox;
    cbAllowQuickCustomizingBar1: TCheckBox;
    cbAllowResetBar1: TCheckBox;
    CheckBox1: TCheckBox;
    gbBar2: TGroupBox;
    SpeedButton2: TSpeedButton;
    cbAllowCustomizingBar2: TCheckBox;
    cbAllowQuickCustomizingBar2: TCheckBox;
    cbAllowResetBar2: TCheckBox;
    CheckBox2: TCheckBox;
    cbShowFullMenusAfterDelay: TCheckBox;
    rgBar3: TGroupBox;
    cbRotateWhenVertical: TCheckBox;
    cbStretchGlyphs: TCheckBox;
    rgStyle: TRadioGroup;
    procedure cbStyleMeasureItem(Sender: TdxBarCustomCombo;
      AIndex: Integer; var AHeight: Integer);
    procedure cbStyleDrawItem(Sender: TdxBarCustomCombo; AIndex: Integer;
      ARect: TRect; AState: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure btnFontColorItemClick(Sender: TObject);
    procedure btnCustomFontColorClick(Sender: TObject);
    procedure btnColorItemClick(Sender: TObject);
    procedure btnCustomColorClick(Sender: TObject);
    procedure btnStandardClick(Sender: TObject);
    procedure sbFontClick(Sender: TObject);
    procedure cbCanCustomizeClick(Sender: TObject);
    procedure sbDockColorClick(Sender: TObject);
    procedure cbAllowResetClick(Sender: TObject);
    procedure cbShowHelpButtonClick(Sender: TObject);
    procedure cbSunkenBorderClick(Sender: TObject);
    procedure cbMenusShowRecentItemsFirstClick(Sender: TObject);
    procedure rgMenuAnimationsClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure cbAllowCustomizingBar1Click(Sender: TObject);
    procedure cbAllowQuickCustomizingBar1Click(Sender: TObject);
    procedure cbAllowResetBar1Click(Sender: TObject);
    procedure cbAllowCustomizingBar2Click(Sender: TObject);
    procedure cbAllowQuickCustomizingBar2Click(Sender: TObject);
    procedure cbAllowResetBar2Click(Sender: TObject);
    procedure cbShowFullMenusAfterDelayClick(Sender: TObject);
    procedure dxBarManagerHelpButtonClick(Sender: TObject);
    procedure cbRotateWhenVerticalClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure dxBarManagerBarVisibleChange(Sender: TdxBarManager;
      ABar: TdxBar);
    procedure cbStretchGlyphsClick(Sender: TObject);
    procedure rgStyleClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateColorItems(AButton, ADownButton, ACustomButton,
      AItemButton: TdxBarButton; APopupMenu: TdxBarPopupMenu);
    procedure UpdateColorButtonGlyph(AButton: TdxBarButton);
  public
    { Public declarations }
    FUpdateVisible : Boolean;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.cbStyleMeasureItem(Sender: TdxBarCustomCombo;
  AIndex: Integer; var AHeight: Integer);
begin
  AHeight := 35;
end;

procedure TMainForm.cbStyleDrawItem(Sender: TdxBarCustomCombo;
  AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
begin
  if Sender.DroppedDown then
    with Sender.Canvas do
    begin
      StyleImages.Draw(Sender.Canvas, ARect.Left, ARect.Top, AIndex);
      FrameRect(ARect);
      InflateRect(ARect, -1, -1);
      FrameRect(ARect);
    end
  else
    Sender.Canvas.TextRect(ARect, ARect.Left + 1, ARect.Top, TdxBarCombo(Sender).Text);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  btnFontColor.Tag := clGray;
  UpdateColorItems(btnFontColor, btnDownFontColorItem, btnCustomFontColor, btnFontColorItem, FontColorPopupMenu);
  btnHightlight.Tag := clYellow;
  UpdateColorItems(btnHightlight, btnDownColorItem, btnCustomColor, btnColorItem, HightlightColorPopupMenu);
  FUpdateVisible := True;
end;

procedure TMainForm.UpdateColorItems(AButton, ADownButton, ACustomButton, AItemButton: TdxBarButton;
  APopupMenu: TdxBarPopupMenu);
const
  Colors: array [0..15] of TColor = (clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal, clGray, clSilver,
    clRed, clLime, clYellow, clBlue, clFuchsia, clAqua, clWhite);
  ColorNames: array [0..15] of string = ('Black', 'Maroon', 'Green', 'Olive', 'Navy', 'Purple', 'Teal', 'Gray', 'Silver',
    'Red', 'Lime', 'Yellow', 'Blue', 'Fuchsia', 'Aqua', 'White');
var
  I: Integer;
  B: TBitmap;
begin
  B := TBitmap.Create;
  B.Width := Images.Width + 1;
  B.Height := Images.Height;
  APopupMenu.ItemLinks.Clear;
  for I := 0 to 15 do
  begin
    if Colors[I] <> clBlack then
      B.Canvas.Brush.Color := clBlack
    else
      B.Canvas.Brush.Color := clWhite;
    B.Canvas.FillRect(Rect(0, 0, B.Width, B.Height));
    B.Canvas.Brush.Color := Colors[I];
    B.Canvas.Pen.Color := clGray;
    if AButton.Tag = Colors[I] then
      B.Canvas.Rectangle(1, 1, B.Width - 3, B.Height - 2)
    else
      B.Canvas.Rectangle(2, 2, B.Width - 2, B.Height - 1);
    with APopupMenu.ItemLinks.Add do
    begin
      if AButton.Tag = Colors[I] then
      begin
        Item := ADownButton;
        ADownButton.Down := True;
      end
      else
        Item := AItemButton;
      Data := Colors[I];
      UserCaption := ColorNames[I];
      UserGlyph := B;
    end;
  end;
  with APopupMenu.ItemLinks.Add do
  begin
    Item := ACustomButton;
    UserCaption := 'Custom ...';
    BeginGroup := True;
  end;
  B.Free;
end;

procedure TMainForm.btnFontColorItemClick(Sender: TObject);
begin
  btnFontColor.Tag := TdxBarButton(Sender).ClickItemLink.Data;
  UpdateColorItems(btnFontColor, btnDownFontColorItem, btnCustomFontColor, btnFontColorItem, FontColorPopupMenu);
  UpdateColorButtonGlyph(btnFontColor);
end;

procedure TMainForm.UpdateColorButtonGlyph(AButton: TdxBarButton);
var B : TBitmap;
    R : TRect;
begin
  B := TBitmap.Create;
  with B, Canvas do
  begin
    Width := AButton.Glyph.Width;
    Height := AButton.Glyph.Height;
    if AButton.Tag = clFuchsia then
      Brush.Color := clSilver
    else
      Brush.Color := clFuchsia;
    R := Rect(0, 0, Width, Height);
    FillRect(R);
    BrushCopy(R, AButton.Glyph, R, AButton.Glyph.TransparentColor);
    Brush.Color := AButton.Tag;
    if ColorToRGB(AButton.Tag) <> ColorToRGB(clBtnFace) then
      Pen.Color := AButton.Tag
    else
      Pen.Color := clBlack;
    Rectangle(0, Height - 4, Width, Height - 1)
  end;
  AButton.Glyph.Assign(B);
  B.Free;
end;

procedure TMainForm.btnCustomFontColorClick(Sender: TObject);
begin
  ColorDialog.Color := btnFontColor.Tag;
  if ColorDialog.Execute then
  begin
    btnFontColor.Tag := ColorDialog.Color;
    UpdateColorButtonGlyph(btnFontColor);
    UpdateColorItems(btnFontColor, btnDownFontColorItem, btnCustomFontColor, btnFontColorItem, FontColorPopupMenu);
  end;
end;

procedure TMainForm.btnColorItemClick(Sender: TObject);
begin
  btnHightlight.Tag := TdxBarButton(Sender).ClickItemLink.Data;
  UpdateColorItems(btnHightlight, btnDownColorItem, btnCustomColor, btnColorItem, HightlightColorPopupMenu);
  UpdateColorButtonGlyph(btnHightlight);
end;

procedure TMainForm.btnCustomColorClick(Sender: TObject);
begin
  ColorDialog.Color := btnHightlight.Tag;
  if ColorDialog.Execute then
  begin
    btnHightlight.Tag := ColorDialog.Color;
    UpdateColorButtonGlyph(btnHightlight);
    UpdateColorItems(btnHightlight, btnDownColorItem, btnCustomColor, btnColorItem, HightlightColorPopupMenu);
  end;
end;

procedure TMainForm.btnStandardClick(Sender: TObject);
begin
  FUpdateVisible := False;
  dxBarManager.Bars[TdxBarButton(Sender).Tag].Visible := TdxBarButton(Sender).Down;
  FUpdateVisible := True;
end;

procedure TMainForm.sbFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(dxBarManager.Font);
  if FontDialog.Execute then
    dxBarManager.Font.Assign(FontDialog.Font);
end;

procedure TMainForm.cbCanCustomizeClick(Sender: TObject);
begin
  dxBarManager.CanCustomize := TCheckBox(Sender).Checked;
end;

procedure TMainForm.sbDockColorClick(Sender: TObject);
begin
  if ColorDialog.Execute then
  begin
    pDockColor.Color := ColorDialog.Color;
    dxBarManager.DockColor := ColorDialog.Color;
  end;
end;

procedure TMainForm.cbAllowResetClick(Sender: TObject);
begin
  dxBarManager.AllowReset := TCheckBox(Sender).Checked;
end;

procedure TMainForm.cbShowHelpButtonClick(Sender: TObject);
begin
  dxBarManager.ShowHelpButton := TCheckBox(Sender).Checked;
end;

procedure TMainForm.cbSunkenBorderClick(Sender: TObject);
begin
  dxBarManager.SunkenBorder := TCheckBox(Sender).Checked;
end;

procedure TMainForm.cbMenusShowRecentItemsFirstClick(Sender: TObject);
begin
  dxBarManager.MenusShowRecentItemsFirst := TCheckBox(Sender).Checked;
end;

procedure TMainForm.rgMenuAnimationsClick(Sender: TObject);
begin
  dxBarManager.MenuAnimations := TdxBarMenuAnimations(rgMenuAnimations.ItemIndex);
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  FontDialog.Font.Assign(dxBarManager.Bars[1].Font);
  if FontDialog.Execute then
    dxBarManager.bars[1].Font.Assign(FontDialog.Font);
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
begin
  FontDialog.Font.Assign(dxBarManager.Bars[2].Font);
  if FontDialog.Execute then
    dxBarManager.bars[2].Font.Assign(FontDialog.Font);
end;

procedure TMainForm.cbAllowCustomizingBar1Click(Sender: TObject);
begin
  dxBarManager.Bars[1].AllowCustomizing := TCheckBox(Sender).Checked;
end;

procedure TMainForm.cbAllowQuickCustomizingBar1Click(Sender: TObject);
begin
  dxBarManager.Bars[1].AllowQuickCustomizing := TCheckBox(Sender).Checked;
end;

procedure TMainForm.cbAllowResetBar1Click(Sender: TObject);
begin
  dxBarManager.Bars[1].AllowReset := TCheckBox(Sender).Checked;
end;

procedure TMainForm.cbAllowCustomizingBar2Click(Sender: TObject);
begin
  dxBarManager.Bars[2].AllowCustomizing := TCheckBox(Sender).Checked;
end;

procedure TMainForm.cbAllowQuickCustomizingBar2Click(Sender: TObject);
begin
  dxBarManager.Bars[2].AllowQuickCustomizing := TCheckBox(Sender).Checked;
end;

procedure TMainForm.cbAllowResetBar2Click(Sender: TObject);
begin
  dxBarManager.Bars[2].AllowReset := TCheckBox(Sender).Checked;
end;

procedure TMainForm.cbShowFullMenusAfterDelayClick(Sender: TObject);
begin
  dxBarManager.ShowFullMenusAfterDelay := TCheckBox(Sender).Checked;
end;

procedure TMainForm.dxBarManagerHelpButtonClick(Sender: TObject);
begin
  MessageDlg('You click on Help Button .', mtInformation, [mbOK],0);
end;

procedure TMainForm.cbRotateWhenVerticalClick(Sender: TObject);
begin
  dxBarManager.Bars[3].RotateWhenVertical := TCheckBox(Sender).Checked;
end;

procedure TMainForm.btnCustomizeClick(Sender: TObject);
begin
  dxBarManager.Customizing(True);
end;

procedure TMainForm.dxBarManagerBarVisibleChange(Sender: TdxBarManager;
  ABar: TdxBar);
begin
  if FUpdateVisible and HandleAllocated then
    case ABar.Index of
      1: btnStandard.Down := ABar.Visible;
      2: btnFormatting.Down := ABar.Visible;
      3: btnInternet.Down := ABar.Visible;
    end;
end;

procedure TMainForm.cbStretchGlyphsClick(Sender: TObject);
begin
  dxBarManager.StretchGlyphs := TCheckBox(Sender).Checked;
end;

procedure TMainForm.rgStyleClick(Sender: TObject);
begin
  dxBarManager.Style := TdxBarManagerStyle(rgStyle.ItemIndex);
end;

procedure TMainForm.CheckBox1Click(Sender: TObject);
begin
  dxBarManager.Bars[1].MultiLine := TCheckBox(Sender).Checked;
end;

procedure TMainForm.CheckBox2Click(Sender: TObject);
begin
  dxBarManager.Bars[2].MultiLine := TCheckBox(Sender).Checked;
end;

end.
