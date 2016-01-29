unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ElPanel, ElGroupBox, StdCtrls, ElCLabel, ElLabel, ElHeader,
  ElXPThemedControl, ElEdits, ElBtnEdit, ElCombos, ElListBox, ElPgCtl,
  ElBtnCtl, ElPopBtn, ElSpinBtn, ElCheckCtl, ElSpin, ElIPEdit, ElHotKey,
  ElDTPick, ElCurrEdit, ElNameEdits, ElTree, ElTreeGrids, ElStatBar,
  ElToolBar, ElSideBar, ImgList, ElImgLst, ElHTMLPanel, ElAdvPanel,
  ElExpBar, ElScrollBox, ElTrackBar, Grids, ElCalendar, ElBiProgr,
  ElScrollBar, ElThemes, ElUxTheme, ElStrUtils, ElTools, Menus;

type
  TForm1 = class(TForm)
    ElGroupBox1: TElGroupBox;
    ElGroupBox2: TElGroupBox;
    Bevel1: TBevel;
    ElLabel1: TElLabel;
    ElLabel2: TElLabel;
    ElLabel3: TElLabel;
    cmbColorSchemes: TElComboBox;
    ElPageControl1: TElPageControl;
    ElTabSheet1: TElTabSheet;
    ElGroupBox3: TElGroupBox;
    ElPopupButton1: TElPopupButton;
    ElPopupButton3: TElPopupButton;
    ElPopupButton2: TElPopupButton;
    ElGroupBox4: TElGroupBox;
    ElSpinButton1: TElSpinButton;
    ElSpinButton2: TElSpinButton;
    ElSpinButton3: TElSpinButton;
    ElSpinButton4: TElSpinButton;
    ElGroupBox5: TElGroupBox;
    ElCheckBox1: TElCheckBox;
    ElCheckBox2: TElCheckBox;
    ElCheckBox3: TElCheckBox;
    ElCheckBox4: TElCheckBox;
    ElCheckBox5: TElCheckBox;
    ElCheckBox6: TElCheckBox;
    ElTabSheet2: TElTabSheet;
    ElGroupBox6: TElGroupBox;
    ElEdit2: TElEdit;
    ElButtonEdit1: TElButtonEdit;
    ElSpinEdit1: TElSpinEdit;
    ElIPEdit1: TElIPEdit;
    ElHotKey1: TElHotKey;
    ElCurrencyEdit1: TElCurrencyEdit;
    ElFileNameEdit1: TElFileNameEdit;
    ElGroupBox7: TElGroupBox;
    ElListBox1: TElListBox;
    ElGroupBox8: TElGroupBox;
    ElComboBox2: TElComboBox;
    ElGroupBox9: TElGroupBox;
    ElRadioButton1: TElRadioButton;
    ElRadioButton2: TElRadioButton;
    ElRadioButton3: TElRadioButton;
    ElTabSheet3: TElTabSheet;
    ElTree1: TElTree;
    ElTreeStringGrid1: TElTreeStringGrid;
    ElTabSheet4: TElTabSheet;
    ElStatusBar1: TElStatusBar;
    ElToolBar1: TElToolBar;
    ElToolButton1: TElToolButton;
    ElToolButton2: TElToolButton;
    ElToolButton3: TElToolButton;
    ElToolButton4: TElToolButton;
    ElToolButton5: TElToolButton;
    ElToolButton6: TElToolButton;
    ElToolButton7: TElToolButton;
    ElSideBar1: TElSideBar;
    ElImageList1: TElImageList;
    ElExplorerBar1: TElExplorerBar;
    ElExplorerBarGroup1: TElExplorerBarGroup;
    ElExplorerBarGroup2: TElExplorerBarGroup;
    ElTrackBar1: TElTrackBar;
    ElTrackBar2: TElTrackBar;
    ElBiProgressBar1: TElBiProgressBar;
    ElBiProgressBar2: TElBiProgressBar;
    ElScrollBar1: TElScrollBar;
    edtThemeFile: TElFileNameEdit;
    ElLabel4: TElLabel;
    lblActiveTheme: TElLabel;
    ElLabel6: TElLabel;
    lblActiveColorScheme: TElLabel;
    btnActivate: TElPopupButton;
    btnDeactivate: TElPopupButton;
    procedure FormCreate(Sender: TObject);
    procedure btnDeactivateClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnActivateClick(Sender: TObject);
    procedure edtThemeFileDialogExecute(Sender: TObject);
  private
    FActiveManager: THandle;
    FLoadedManager: THandle;
    procedure LoadActiveThemeProps;
    procedure ELThemeChanged(var Msg: TMessage); message EL_THEMECHANGED;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

{ TForm1 }

procedure TForm1.ELThemeChanged(var Msg: TMessage);
begin
  inherited;
  LoadActiveThemeProps;
end;

procedure TForm1.LoadActiveThemeProps;
var
  Manager: THandle;
  WS: WideString;
begin
  Manager := GetCurrentTheme;
  if Manager = 0 then
  begin
    lblActiveTheme.Caption := '[none]';
    lblActiveColorScheme.Caption := '[none]';
  end
  else
  begin
    // get current theme display name
    SetLength(WS, 100);
    if Succeeded(GetThemeDisplayName(Manager, PWideChar(WS), 100)) then
    begin
      SetLength(WS, WideStrLen(PWideChar(WS)));
      lblActiveTheme.Caption := WS;
    end
    else
    begin
      SetLength(WS, 0);
      lblActiveTheme.Caption := '[failed]';
    end;
    // get current color scheme
    SetLength(WS, 100);
    if Succeeded(GetCurrentThemeName(nil, 0, PWideChar(WS), 100, nil, 0)) then
    begin
      SetLength(WS, WideStrLen(PWideChar(WS)));
      lblActiveColorScheme.Caption := WS;
    end
    else
    begin
      SetLength(WS, 0);
      lblActiveTheme.Caption := '[failed]';
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ThemeFile: WideString;
begin
  FLoadedManager := 0;
  FActiveManager := 0;
  if IsWinXPUp and IsThemeActive then
    LoadActiveThemeProps
  else
  begin
    ThemeFile := ExtractFilePath(Application.ExeName) + 'BlueChrome.msstyles';
    FActiveManager := LoadTheme(PWideChar(ThemeFile));
    if FActiveManager <> 0 then
      ActivateTheme(FActiveManager, '');
  end;
end;

procedure TForm1.btnDeactivateClick(Sender: TObject);
begin
  DeactivateTheme;
  if (FActiveManager <> 0) and (FActiveManager <> FLoadedManager) then
    UnloadTheme(FActiveManager);
  FActiveManager := 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if FActiveManager <> 0 then
  begin
    if FActiveManager <> FLoadedManager then
      UnloadTheme(FActiveManager);
    FActiveManager := 0;
  end;
  if FLoadedManager <> 0 then
  begin
    UnloadTheme(FLoadedManager);
    FLoadedManager := 0;
  end;
end;

procedure TForm1.btnActivateClick(Sender: TObject);
var
  ColorScheme: WideString;
begin
  if FLoadedManager <> 0 then
  begin
    if cmbColorSchemes.ItemIndex < 0 then
      ColorScheme := ''
    else
      ColorScheme := cmbColorSchemes.Items[cmbColorSchemes.ItemIndex];
    if Succeeded(ActivateTheme(FLoadedManager, PWideChar(ColorScheme))) then
    begin
      if (FActiveManager <> 0) and (FActiveManager <> FLoadedManager) then
      begin
        UnloadTheme(FActiveManager);
        FActiveManager := 0;
      end;
      if FActiveManager <> FLoadedManager then
        FActiveManager := FLoadedManager;
    end;
  end;
end;

procedure TForm1.edtThemeFileDialogExecute(Sender: TObject);
var
  S: WideString;
  P: PWideChar;
  Scheme: WideString;
begin
  cmbColorSchemes.Items.Clear;
  if (FLoadedManager <> 0) and (FLoadedManager <> FActiveManager) then
  begin
    UnloadTheme(FLoadedManager);
    FLoadedManager := 0;
  end;
  S := edtThemeFile.Text;
  FLoadedManager := LoadTheme(PWideChar(S));
  if FLoadedManager <> 0 then
  begin
    SetLength(S, 500);
    if Succeeded(EnumThemeColorSchemes(FLoadedManager, PWideChar(S), 499)) then
    begin
      P := PWideChar(S);
      while WideStrLen(P) > 0 do
      begin
        Scheme := WideStrPas(P);
        cmbColorSchemes.Items.Add(Scheme);
        Inc(P, WideStrLen(P) + 1);
      end;
    end;
  end;
end;

end.
