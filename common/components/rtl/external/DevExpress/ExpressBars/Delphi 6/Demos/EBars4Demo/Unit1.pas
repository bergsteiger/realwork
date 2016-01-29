unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxBar, dxBarExtItems, ComCtrls, ExtCtrls, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    BarManager: TdxBarManager;
    dxBarSubItemFile: TdxBarSubItem;
    dxBarSubItemHelp: TdxBarSubItem;
    dxBarButtonOnWeb: TdxBarButton;
    dxBarStaticEditor: TdxBarStatic;
    dxBarStaticStatus: TdxBarStatic;
    dxBarDockControl1: TdxBarDockControl;
    dxBarControlContainerItem: TdxBarControlContainerItem;
    ilComponents: TImageList;
    dxBarSubItemProducts: TdxBarSubItem;
    dxBarSubItemPages: TdxBarSubItem;
    dxBarSubItemView: TdxBarSubItem;
    Editor: TRichEdit;
    pcProducts: TPageControl;
    dxBarButtonExit: TdxBarButton;
    dxBarAnimateControl: TdxBarControlContainerItem;
    Animate: TAnimate;
    dxBarButtonNew: TdxBarButton;
    dxBarButtonOpen: TdxBarButton;
    dxBarButtonSave: TdxBarButton;
    dxBarButtonSaveAs: TdxBarButton;
    dxBarButtonPrint: TdxBarButton;
    dxBarProgressItem: TdxBarProgressItem;
    Timer1: TTimer;
    dxBarEdit: TdxBarEdit;
    iBars4: TImage;
    dxBLBDBGridLayoutList: TdxBarLargeButton;
    dxBLBTreeList: TdxBarLargeButton;
    dxBLBDBTreeList: TdxBarLargeButton;
    dxBLBCalculator: TdxBarLargeButton;
    dxBLBCalcDisplay: TdxBarLargeButton;
    dxBLBSpinImage: TdxBarLargeButton;
    dxBLBBarDockControl: TdxBarLargeButton;
    dxBLBBarConverter: TdxBarLargeButton;
    dxBLBBarManager: TdxBarLargeButton;
    dxBLBBarPopupMenu: TdxBarLargeButton;
    dxBLBBarDBNavigator: TdxBarLargeButton;
    dxBLBSideBarStore: TdxBarLargeButton;
    dxBLBSideBar: TdxBarLargeButton;
    dxBLBSideBarPopupMenu: TdxBarLargeButton;
    dxBLBImageListBox: TdxBarLargeButton;
    dxBLBImageComboBox: TdxBarLargeButton;
    dxBLBInspector: TdxBarLargeButton;
    dxBLBDBInspect: TdxBarLargeButton;
    dxBLBMasterView: TdxBarLargeButton;
    dxBLBEdit: TdxBarLargeButton;
    dxBLBMaskEdit: TdxBarLargeButton;
    dxBLBMemo: TdxBarLargeButton;
    dxBLBDateEdit: TdxBarLargeButton;
    dxBLBButtonEdit: TdxBarLargeButton;
    dxBLBCheckEdit: TdxBarLargeButton;
    dxBLBImageEdit: TdxBarLargeButton;
    dxBLBSpinEdit: TdxBarLargeButton;
    dxBLBPickEdit: TdxBarLargeButton;
    dxBLBCalcEdit: TdxBarLargeButton;
    dxBLBHyperLinkEdit: TdxBarLargeButton;
    dxBLBTimeEdit: TdxBarLargeButton;
    dxBLBCurrencyEdit: TdxBarLargeButton;
    dxBLBGraphicEdit: TdxBarLargeButton;
    dxBLBBlobEdit: TdxBarLargeButton;
    dxBLBMRUEdit: TdxBarLargeButton;
    dxBLBPopupEdit: TdxBarLargeButton;
    dxBLBDBEdit: TdxBarLargeButton;
    dxBLBDBMaskEdit: TdxBarLargeButton;
    dxBLBDBMemo: TdxBarLargeButton;
    dxBLBDBDateEdit: TdxBarLargeButton;
    dxBLBDBButtonEdit: TdxBarLargeButton;
    dxBLBDBCheckEdit: TdxBarLargeButton;
    dxBLBDBImageEdit: TdxBarLargeButton;
    dxBLBDBSpinEdit: TdxBarLargeButton;
    dxBLBDBPickEdit: TdxBarLargeButton;
    dxBLBDBCalcEdit: TdxBarLargeButton;
    dxBLBDBHyperLinkEdit: TdxBarLargeButton;
    dxBLBDBTimeEdit: TdxBarLargeButton;
    dxBLBDBCurrencyEdit: TdxBarLargeButton;
    dxBLBDBGraphicEdit: TdxBarLargeButton;
    dxBLBDBBlobEdit: TdxBarLargeButton;
    dxBLBDBMRUEdit: TdxBarLargeButton;
    dxBLBDBPopupEdit: TdxBarLargeButton;
    dxBLBDBLookupEdit: TdxBarLargeButton;
    dxBLBDBExtLookupEdit: TdxBarLargeButton;
    dxBLBEditStyleController: TdxBarLargeButton;
    dxBLBCheckEditStyleController: TdxBarLargeButton;
    dxBLBComponentPrinter: TdxBarLargeButton;
    dxBLBTreeView: TdxBarLargeButton;
    dxBLBDBTreeView: TdxBarLargeButton;
    dxBLBTreeViewEdit: TdxBarLargeButton;
    dxBLBDBTreeViewEdit: TdxBarLargeButton;
    dxBLBLookupTreeViewEdit: TdxBarLargeButton;
    dxBLBDBLookupTreeViewEdit: TdxBarLargeButton;
    dxBLBDBTreePrintData: TdxBarLargeButton;
    dxBLBOrgChart: TdxBarLargeButton;
    dxBLBDBOrgChart: TdxBarLargeButton;
    dxBLBFlowChart: TdxBarLargeButton;
    dxBLBStatus: TdxBarLargeButton;
    dxBLIPages: TdxBarListItem;
    Timer2: TTimer;
    dxBarListItem1: TdxBarListItem;
    dxBarListItem2: TdxBarListItem;
    dxBarListItem3: TdxBarListItem;
    dxBarListItem4: TdxBarListItem;
    dxBarListItem5: TdxBarListItem;
    dxBarInPlaceSubItem1: TdxBarInPlaceSubItem;
    dxBarInPlaceSubItem2: TdxBarInPlaceSubItem;
    dxBarInPlaceSubItem3: TdxBarInPlaceSubItem;
    dxBarInPlaceSubItem4: TdxBarInPlaceSubItem;
    dxBarInPlaceSubItem5: TdxBarInPlaceSubItem;
    dxBarInPlaceSubItem6: TdxBarInPlaceSubItem;
    dxBarInPlaceSubItem9: TdxBarInPlaceSubItem;
    dxBarInPlaceSubItem10: TdxBarInPlaceSubItem;
    dxBarInPlaceSubItem11: TdxBarInPlaceSubItem;
    dxBarInPlaceSubItem7: TdxBarInPlaceSubItem;
    dxBarInPlaceSubItem8: TdxBarInPlaceSubItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    dxBLBDBGrid: TdxBarLargeButton;
    procedure dxBarSubItemFilePaintBar(Sender: TObject; Canvas: TCanvas;
      const R: TRect);
    procedure FormCreate(Sender: TObject);
    procedure pcProductsChange(Sender: TObject);
    procedure dxBarButtonExitClick(Sender: TObject);
    procedure dxBarButtonOnWebClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure EditorSelectionChange(Sender: TObject);
    procedure dxBLBDBGridClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure dxBLBStatusClick(Sender: TObject);
    procedure dxBLIPagesClick(Sender: TObject);
    procedure dxBarSubItemProductsDetaching(Sender: TObject);
    procedure dxBarButtonNewClick(Sender: TObject);
    procedure dxBarButtonPrintClick(Sender: TObject);
    procedure dxBarButtonOpenClick(Sender: TObject);
    procedure dxBarButtonSaveClick(Sender: TObject);
    procedure dxBarButtonSaveAsClick(Sender: TObject);
  private
    Delta: Integer;
    DetachingBar: TdxBar;
    FFileName: string;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure SaveFile(ASaveAs: Boolean);
  public
  end;

  TdxBarManagerWrapper = class(TdxBarManager);
var
  Form1: TForm1;
  StatusImIndex: Integer;

implementation

uses
  ShellAPI;
{$R *.DFM}

procedure TForm1.dxBarSubItemFilePaintBar(Sender: TObject; Canvas: TCanvas;
  const R: TRect);
var
  SR, BR: TRect;
begin
  DrawVerticalGradient(Canvas, R, 0, 0, 0, 0, 0, 255);
  SR := R;
  with iBars4.Picture.Bitmap do
  begin
    TransparentColor := clBlack;
    BR := Rect(0, 0, Width, Height);
  end;
  with SR do
  begin
    Left := (Left + Right - BR.Right) div 2;
    Right := Left + BR.Right;
    Top := Bottom - BR.Bottom;
  end;
  if SR.Top > 0 then
    with Canvas do
    begin
      Brush.Style := bsClear;
      BrushCopy(SR, iBars4.Picture.Bitmap, BR, clBlack);
      Brush.Style := bsSolid;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
  procedure FillPageList;
  var
    ItemList: TList;
    I: Integer;
  begin
    dxBLIPages.Items.Clear;
    ItemList := TList.Create;
    BarManager.GetItemsByCategory(BarManager.Categories.IndexOf('Pages'), ItemList);
    for I := 0 to ItemList.Count - 1 do
      with TdxBarListItem(ItemList.Items[I]) do
      begin
        dxBLIPages.Items.AddStrings(Items);
        dxBLIPages.Items.Add('-');
      end;
    ItemList.Free;
  end;

  procedure FillPageControl;
    function AddPage(ACaption: string): TTabSheet;
    begin
      Result := TTabSheet.Create(pcProducts);
      with Result do
      begin
        Parent := pcProducts;
        PageControl := pcProducts;
        Caption := ACaption;
        Brush.Color := TdxBarmanagerWrapper(BarManager).FlatToolbarsColor;
      end;
    end;

    function CreateDockControl(APage: TTabSheet): TdxBarDockControl;
    begin
      Result := TdxBarDockControl.Create(APage);
      with Result do
      begin
        Parent := APage;
        BarManager := Self.BarManager;
        Align := dalTop;
        AllowDocking := False;
      end;
    end;

    function CreateToolBar(ADockControl: TdxBarDockControl): TdxBar;
    begin
      Result := BarManager.Bars.Add;
      with Result do
      begin
        Caption := TTabSheet(ADockControl.Parent).Caption + ' Components';
        DockControl := ADockControl;
        Visible := True;
        Hidden := True;
        WholeRow := True;
        NotDocking := [dsNone..dsBottom];
        BorderStyle := bbsNone;
      end;
    end;

  var
    ItemList: TList;
    I: Integer;
    Page: TTabSheet;
    DockCtrl: TdxBarDockControl;
    ToolBar: TdxBar;
  begin
    ItemList := TList.Create;
    BarManager.GetItemsByCategory(BarManager.Categories.IndexOf('Products'), ItemList);
    for I := 0 to ItemList.Count - 1 do
    begin
      Page := AddPage(TdxBarItem(ItemList.Items[I]).Caption);
      DockCtrl := CreateDockControl(Page);
      ToolBar := CreateToolBar(DockCtrl);
      ToolBar.ItemLinks.Assign(TdxBarInPlaceSubItem(ItemList.Items[I]).ItemLinks);
    end;
    ItemList.Free;
  end;

var
  Path: string;
begin
  FillPageList;
  FillPageControl;
  pcProducts.Brush.Color := TdxBarManagerWrapper(BarManager).FlatToolbarsColor;
  Animate.Color := TdxBarManagerWrapper(BarManager).FlatToolbarsColor;
  Path := ExtractFileDir(Application.ExeName);
  try
    FFileName := Path +'\What''s New.rtf';
    Editor.Lines.LoadFromFile(FFileName);
    dxBarStaticStatus.Caption := 'Loaded';
  finally
  end;
  try
    Animate.FileName := Path + '\dx.avi';
    Animate.Active := True;
  finally
  end;
  Timer1.Enabled := True;
  Timer2.Enabled := True;
  StatusImIndex := -1;
  DetachingBar := nil;
  pcProductsChange(pcProducts);
end;

procedure TForm1.pcProductsChange(Sender: TObject);
var
  I: Integer;
  CurPage: string;
begin
  CurPage := TPageControl(Sender).ActivePage.Caption;
  dxBLIPages.ItemIndex := dxBLIPages.Items.IndexOf(CurPage);
  with BarManager.Bars[3].ItemLinks do
  for I := 0 to Count - 1 do
    with TdxBarListItem(Items[I].Item) do
      ItemIndex := Items.IndexOf(CurPage);
end;

procedure TForm1.dxBarButtonExitClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.dxBarButtonOnWebClick(Sender: TObject);
begin
  ShellExecute(0, nil, 'http://www.devexpress.com', nil, nil, SW_RESTORE);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if dxBarProgressItem.Position = 100 then
    Delta := -1;
  if dxBarProgressItem.Position = 0 then
    Delta := 1;
  dxBarProgressItem.StepBy(Delta);
end;

procedure TForm1.EditorSelectionChange(Sender: TObject);
var
  EditorRow, EditorCol: Integer;
begin
  EditorRow := SendMessage(Editor.Handle, EM_LINEFROMCHAR, Editor.SelStart, 0);
  EditorCol := Editor.Selstart - SendMessage(Editor.Handle, EM_LINEINDEX, EditorRow, 0);
  dxBarStaticEditor.Caption := Format('Line: %3d   Col: %3d', [1 + EditorRow, 1 + EditorCol]);
end;

procedure TForm1.CMSysColorChange(var Message: TMessage);
var
  ToolbarsColor: TColor;
  I: Integer;
begin
  inherited;
  ToolbarsColor := TdxBarmanagerWrapper(BarManager).FlatToolbarsColor;
  pcProducts.Brush.Color := ToolbarsColor;
  SendMessage(pcProducts.Handle, WM_SYSCOLORCHANGE, 0, 0);
  for I := 0 to pcProducts.PageCount - 1 do
    pcProducts.Pages[I].Brush.Color := ToolbarsColor;
  SendMessage(pcProducts.ActivePage.Handle, WM_SYSCOLORCHANGE, 0, 0);
  Animate.Color := ToolbarsColor;
end;

procedure TForm1.dxBLBDBGridClick(Sender: TObject);
begin
  StatusImIndex := TdxBarLargeButton(Sender).LargeImageIndex;
  dxBLBStatus.LargeImageIndex :=  StatusImIndex;
  dxBLBStatus.Caption := TdxBarLargeButton(Sender).Caption;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  with dxBLBStatus do
    if LargeImageIndex = -1 then
      LargeImageIndex := StatusImIndex
    else
      LargeImageIndex := -1;
end;

procedure TForm1.dxBLBStatusClick(Sender: TObject);
begin
  if dxBLBStatus.Caption <> 'Not Selected' then
    MessageBox(Handle,PChar('You have selected the ' + dxBLBStatus.Caption + ' !'),
      'Status bar button',MB_OK or MB_ICONINFORMATION);
end;

procedure TForm1.dxBLIPagesClick(Sender: TObject);
  function FindPageByCaption(ACaption: string): TTabSheet;
  var
    I: Integer;
  begin
    Result := nil;
    with pcProducts do
      for I := 0 to PageCount - 1 do
        if Pages[I].Caption = ACaption then
        begin
          Result := Pages[I];
          break;
        end;
  end;

begin
  with TdxBarListItem(Sender) do
    pcProducts.ActivePage := FindPageByCaption(Items[ItemIndex]);
  pcProductsChange(pcProducts);
end;

procedure TForm1.dxBarSubItemProductsDetaching(Sender: TObject);
var
  I: Integer;
begin
  if DetachingBar = nil then
  begin
    DetachingBar := BarManager.Bars.Add;
    with DetachingBar do
    begin
      Caption := 'Products';
      AllowCustomizing := False;
      Hidden := True;
      MultiLine := True;
      dxBarSubItemProducts.DetachingBar := Index;
      for I := 0 to dxBarSubItemProducts.ItemLinks.Count - 1 do
        if dxBarSubItemProducts.ItemLinks.Items[I].Item.ClassName = 'TdxBarInPlaceSubItem' then
          ItemLinks.Add.Assign(dxBarSubItemProducts.ItemLinks.Items[I]);
    end;
  end;
end;

procedure TForm1.dxBarButtonNewClick(Sender: TObject);
begin
  Editor.Clear;
  dxBarStaticStatus.Caption := '';
  FFileName := '';
end;

procedure TForm1.dxBarButtonPrintClick(Sender: TObject);
begin
  if PrintDialog.Execute then Editor.Print(FFileName);
end;

procedure TForm1.dxBarButtonOpenClick(Sender: TObject);
begin
  OpenDialog.FileName := '';
  if OpenDialog.Execute then
  begin
    FFileName := OpenDialog.FileName;
    Editor.PlainText := (OpenDialog.FilterIndex = 2);
    Editor.Lines.LoadFromFile(FFileName);
    dxBarStaticStatus.Caption := 'Loaded';
  end;
end;

procedure TForm1.SaveFile(ASaveAs: Boolean);
begin
  if ASaveAs or (FFileName = '') then
  begin
    SaveDialog.FileName := FFileName;
    if not SaveDialog.Execute then Exit;
    Editor.PlainText := (SaveDialog.FilterIndex = 2);
    FFileName := SaveDialog.FileName;
  end;
  Editor.Lines.SaveToFile(FFileName);
end;

procedure TForm1.dxBarButtonSaveClick(Sender: TObject);
begin
  SaveFile(False);
end;

procedure TForm1.dxBarButtonSaveAsClick(Sender: TObject);
begin
  SaveFile(True);
end;

end.
