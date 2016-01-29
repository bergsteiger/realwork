unit ctrlsdemofrm;

interface

uses     
  {$IFDEF FPC}
  LResources,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vg_objects, vg_scene, vg_layouts, vg_controls, vg_textbox,
  vg_listbox, vg_tabcontrol, vg_extctrls, vg_treeview,
  vg_effects,
  vg_memo, Menus, vg_colors;

type

  { TfrmCtrlsDemo }

  TfrmCtrlsDemo = class(TForm)
    ControlsScene: TvgScene;
    Layout1: TvgBackground;
    ScaleTrack: TvgTrackBar;
    Text1: TvgLabel;
    Toolbar: TvgToolBar;
    ControlRoot: TvgLayout;
    ScaleRoot: TvgLayout;
    Button1: TvgButton;
    Text2: TvgLabel;
    Text3: TvgLabel;
    ScrollBar1: TvgScrollBar;
    ScrollBar2: TvgScrollBar;
    Track1: TvgTrack;
    Text4: TvgLabel;
    ScrollBox1: TvgScrollBox;
    TextScale: TvgLabel;
    TabControl1: TvgTabControl;
    TabItem1: TvgTabItem;
    TabItem2: TvgTabItem;
    tabLayout2: TvgLayout;
    CheckBox1: TvgCheckBox;
    RadioButton1: TvgRadioButton;
    RadioButton2: TvgRadioButton;
    ProgressBar1: TvgProgressBar;
    Label1: TvgLabel;
    StringComboBox1: TvgStringComboBox;
    TabItem3: TvgTabItem;
    Label2: TvgLabel;
    ListBoxItem1: TvgListBoxItem;
    ListBoxItem2: TvgListBoxItem;
    ListBoxItem3: TvgListBoxItem;
    ListBoxItem4: TvgListBoxItem;
    ListBoxItem6: TvgListBoxItem;
    Label3: TvgLabel;
    Label4: TvgLabel;
    Image1: TvgImage;
    Label5: TvgLabel;
    Path1: TvgPath;
    Label6: TvgLabel;
    Button2: TvgButton;
    TextBox2: TvgTextBox;
    tabLayout3: TvgLayout;
    Rectangle1: TvgRectangle;
    Text6: TvgLabel;
    Ellipse1: TvgEllipse;
    Label7: TvgLabel;
    TreeView1: TvgTreeView;
    TreeViewItem1: TvgTreeViewItem;
    TreeViewItem2: TvgTreeViewItem;
    TreeViewItem3: TvgTreeViewItem;
    TreeViewItem4: TvgTreeViewItem;
    TreeViewItem5: TvgTreeViewItem;
    TreeViewItem6: TvgTreeViewItem;
    TreeViewItem7: TvgTreeViewItem;
    TreeViewItem8: TvgTreeViewItem;
    TreeViewItem9: TvgTreeViewItem;
    TreeViewItem10: TvgTreeViewItem;
    TreeViewItem11: TvgTreeViewItem;
    TreeViewItem12: TvgTreeViewItem;
    TreeViewItem13: TvgTreeViewItem;
    TreeViewItem14: TvgTreeViewItem;
    TreeViewItem15: TvgTreeViewItem;
    TreeViewItem16: TvgTreeViewItem;
    TreeViewItem17: TvgTreeViewItem;
    TreeViewItem18: TvgTreeViewItem;
    TreeViewItem19: TvgTreeViewItem;
    TreeViewItem20: TvgTreeViewItem;
    TreeViewItem21: TvgTreeViewItem;
    TreeViewItem22: TvgTreeViewItem;
    TreeViewItem23: TvgTreeViewItem;
    TreeViewItem24: TvgTreeViewItem;
    TreeViewItem25: TvgTreeViewItem;
    TreeViewItem26: TvgTreeViewItem;
    TreeViewItem27: TvgTreeViewItem;
    TreeViewItem28: TvgTreeViewItem;
    TreeViewItem29: TvgTreeViewItem;
    TreeViewItem30: TvgTreeViewItem;
    TreeViewItem31: TvgTreeViewItem;
    TreeViewItem32: TvgTreeViewItem;
    TreeViewItem33: TvgTreeViewItem;
    TreeViewItem34: TvgTreeViewItem;
    TreeViewItem35: TvgTreeViewItem;
    TreeViewItem36: TvgTreeViewItem;
    TreeViewItem37: TvgTreeViewItem;
    TabItem4: TvgTabItem;
    Layout3: TvgLayout;
    Expander1: TvgExpander;
    Label8: TvgLabel;
    Button3: TvgButton;
    GroupBox1: TvgGroupBox;
    AniIndicator1: TvgAniIndicator;
    Button4: TvgButton;
    Image2: TvgImage;
    Button5: TvgButton;
    Label9: TvgLabel;
    Image3: TvgImage;
    Label10: TvgLabel;
    Label11: TvgLabel;
    NumberBox1: TvgNumberBox;
    TrackBar1: TvgTrackBar;
    Label12: TvgLabel;
    Button6: TvgButton;
    ListBox1: TvgListBox;
    GlowEffect2: TvgGlowEffect;
    Label13: TvgLabel;
    Label14: TvgLabel;
    Memo1: TvgMemo;
    Label15: TvgLabel;
    AngleButton1: TvgAngleButton;
    Label16: TvgLabel;
    AngleButton2: TvgAngleButton;
    AngleButton3: TvgAngleButton;
    Label17: TvgLabel;
    PopupBox1: TvgPopupBox;
    TextBox3: TvgTextBox;
    Rectangle2: TvgPanel;
    Splitter1: TvgSplitter;
    ModernStyle: TvgResources;
    Label18: TvgLabel;
    Panel1: TvgPanel;
    Label19: TvgLabel;
    SpeedButton2: TvgSpeedButton;
    SpeedButton3: TvgSpeedButton;
    VistaStyle: TvgResources;
    StyleBox: TvgPopupBox;
    externalStyle: TvgResources;
    OpenDialog1: TOpenDialog;
    StatusBar1: TvgStatusBar;
    Label20: TvgLabel;
    Panel2: TvgPanel;
    TabItem5: TvgTabItem;
    Layout2: TvgLayout;
    DropTarget1: TvgDropTarget;
    CloseButton1: TvgCloseButton;
    CloseButton2: TvgCloseButton;
    AirStyle: TvgResources;
    TabItem6: TvgTabItem;
    Layout4: TvgLayout;
    StringListBox1: TvgStringListBox;
    ListTransform: TvgStringListBox;
    TrackBar2: TvgTrackBar;
    Label21: TvgLabel;
    Label22: TvgLabel;
    TrackBar3: TvgTrackBar;
    Ellipse2: TvgEllipse;
    TextBox1: TvgTextBox;
    TextBox4: TvgTextBox;
    CompoundAngleBar1: TvgCompoundAngleBar;
    Panel3: TvgPanel;
    CompoundNumberBox1: TvgCompoundNumberBox;
    CompoundPopupBox1: TvgCompoundPopupBox;
    CompoundTextBox1: TvgCompoundTextBox;
    CompoundTrackBar1: TvgCompoundTrackBar;
    CompoundTrackBar2: TvgCompoundTrackBar;
    ToolButton1: TvgToolButton;
    ToolPathButton1: TvgToolPathButton;
    BitmapButton2: TvgBitmapButton;
    BitmapButton3: TvgBitmapButton;
    BitmapButton4: TvgBitmapButton;
    BitmapButton1: TvgBitmapButton;
    PathButton1: TvgPathButton;
    TabItem7: TvgTabItem;
    Layout5: TvgLayout;
    CornerButton1: TvgCornerButton;
    TrackBar4: TvgTrackBar;
    CheckBox3: TvgCheckBox;
    CheckBox4: TvgCheckBox;
    CheckBox5: TvgCheckBox;
    CheckBox6: TvgCheckBox;
    CornerButton2: TvgCornerButton;
    CornerButton3: TvgCornerButton;
    CornerButton4: TvgCornerButton;
    CornerButton5: TvgCornerButton;
    CornerButton6: TvgCornerButton;
    Path2: TvgPath;
    Path3: TvgPath;
    cornerList: TvgHorzListBox;
    btnHud: TvgToolPathButton;
    btnAbout: TvgToolButton;
    btnLoadStyle: TvgToolButton;
    PathCheckBox1: TvgPathCheckBox;
    PathCheckBox2: TvgPathCheckBox;
    PathCheckBox3: TvgPathCheckBox;
    Label23: TvgLabel;
    VertScrollBox1: TvgVertScrollBox;
    Button7: TvgButton;
    TrackBar5: TvgTrackBar;
    TextBox5: TvgTextBox;
    Expander2: TvgExpander;
    Expander3: TvgExpander;
    Expander4: TvgExpander;
    CompoundMemo1: TvgCompoundMemo;
    CompoundColorButton1: TvgCompoundColorButton;
    CompoundColorButton2: TvgCompoundColorButton;
    RoundButton1: TvgRoundButton;
    BlendStyle: TvgResources;
    ListBox2: TvgListBox;
    ListBoxItem5: TvgListBoxItem;
    ListBoxItem7: TvgListBoxItem;
    ListBoxItem8: TvgListBoxItem;
    ListBoxItem9: TvgListBoxItem;
    ListBoxItem10: TvgListBoxItem;
    ListBoxItem11: TvgListBoxItem;
    ListBoxItem12: TvgListBoxItem;
    TreeView2: TvgTreeView;
    TreeViewItem38: TvgTreeViewItem;
    CircleButton1: TvgCircleButton;
    PopupButton1: TvgPopupButton;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    RoundTextBox1: TvgRoundTextBox;
    TabItem8: TvgTabItem;
    Layout6: TvgLayout;
    Memo2: TvgMemo;
    Memo3: TvgMemo;
    Label24: TvgLabel;
    Label25: TvgLabel;
    SpinBox1: TvgSpinBox;
    Label26: TvgLabel;
    SmallScrollBar1: TvgSmallScrollBar;
    CheckBox7: TvgCheckBox;
    ExtremeStyle: TvgResources;
    CheckBox2: TvgCheckBox;
    ComboTextBox1: TvgComboTextBox;
    Label27: TvgLabel;
    ComboTrackBar1: TvgComboTrackBar;
    AlphaTrackBar1: TvgAlphaTrackBar;
    BWTrackBar1: TvgBWTrackBar;
    HueTrackBar1: TvgHueTrackBar;
    Label28: TvgLabel;
    ComboColorBox1: TvgComboColorBox;
    TextBoxClearBtn1: TvgTextBoxClearBtn;
    tabLayout1: TvgLayout;
    CalloutPanel1: TvgCalloutPanel;
    Label29: TvgLabel;
    calloutTop: TvgRadioButton;
    calloutLeft: TvgRadioButton;
    calloutBottom: TvgRadioButton;
    calloutRight: TvgRadioButton;
    Calendar1: TvgCalendar;
    CalendarBox1: TvgCalendarBox;
    CalendarTextBox1: TvgCalendarTextBox;
    procedure ScaleTrackChange(Sender: TObject);
    procedure AngleButton1Change(Sender: TObject);
    procedure AngleButton3Change(Sender: TObject);
    procedure AngleButton2Change(Sender: TObject);
    procedure StyleBoxChange(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnHudClick(Sender: TObject);
    procedure btnLoadStyleClick(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure CheckBox6Change(Sender: TObject);
    procedure cornerListChange(Sender: TObject);
    procedure CheckBox7Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure calloutBottomChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmCtrlsDemo: TfrmCtrlsDemo;

implementation

uses aboutboxfrm, hudctrls;

{$R *.dfm}

constructor TfrmCtrlsDemo.Create(AOwner: TComponent);
var
  i: integer;
begin
  inherited;
  for i := 0 to 50 do
    with TvgRectangle.Create(Self) do
    begin
      parent := ScrollBox1;
      width := (30 + random(150));
      height := (30 + random(150));
      hittest := false;
      Position.x := random(1600);
      Position.y := random(1600);
      xRadius := random(20);
      yRadius := xRadius;
      fill.SolidColor := ((50 + random(205)) shl 24) or random($FFFFFF);
    end;
end;

destructor TfrmCtrlsDemo.Destroy;
begin
  inherited;
end;

procedure TfrmCtrlsDemo.ScaleTrackChange(Sender: TObject);
begin
  { change scale }
  ControlRoot.Scale.X := ScaleTrack.Value;
  ControlRoot.Scale.Y := ScaleTrack.Value;
  TextScale.Text := IntToStr(Round(ScaleTrack.Value * 100)) + '%';
end;

procedure TfrmCtrlsDemo.AngleButton1Change(Sender: TObject);
begin
  Label17.Text := IntToStr(Trunc(AngleButton1.Value));
end;

procedure TfrmCtrlsDemo.AngleButton3Change(Sender: TObject);
begin
  Label17.Text := IntToStr(Trunc(AngleButton3.Value));
end;

procedure TfrmCtrlsDemo.AngleButton2Change(Sender: TObject);
begin
  Label17.Text := IntToStr(Trunc(AngleButton2.Value));
end;

procedure TfrmCtrlsDemo.StyleBoxChange(Sender: TObject);
begin
  case StyleBox.ItemIndex of
    0: ControlsScene.Style := nil;
    1: ControlsScene.Style := ModernStyle;
    2: ControlsScene.Style := VistaStyle;
    3: ControlsScene.Style := AirStyle;
    4: ControlsScene.Style := BlendStyle;
    5: ControlsScene.Style := ExtremeStyle;
  end;
end;

procedure TfrmCtrlsDemo.btnAboutClick(Sender: TObject);
begin
  frmAbout := TfrmAbout.Create(Self);
  frmAbout.ShowModal;
  frmAbout.Free;
end;

procedure TfrmCtrlsDemo.btnHudClick(Sender: TObject);
begin
  frmLayerDemo := TfrmLayerDemo.Create(Self);
  frmLayerDemo.ShowModal;
  frmLayerDemo.Free;
end;

procedure TfrmCtrlsDemo.btnLoadStyleClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    externalStyle.Resource.LoadFromFile(OpenDialog1.FileName);
    ControlsScene.Style := externalStyle;
  end;
end;

procedure TfrmCtrlsDemo.TrackBar2Change(Sender: TObject);
begin
  ListTransform.RotateAngle := TrackBar2.Value;
  TextBox4.RotateAngle := TrackBar2.Value;
end;

procedure TfrmCtrlsDemo.TrackBar3Change(Sender: TObject);
begin
  ListTransform.Opacity := TrackBar3.Value;
  TextBox4.Opacity := TrackBar3.Value;
end;

procedure TfrmCtrlsDemo.TrackBar4Change(Sender: TObject);
begin
  CornerButton1.xRadius := TrackBar4.Value;
  CornerButton1.yRadius := TrackBar4.Value;

  CornerButton2.xRadius := TrackBar4.Value;;
  CornerButton2.yRadius := TrackBar4.Value;;
  CornerButton3.xRadius := TrackBar4.Value;;
  CornerButton3.yRadius := TrackBar4.Value;;
  CornerButton4.xRadius := TrackBar4.Value;;
  CornerButton4.yRadius := TrackBar4.Value;;

  CornerButton5.xRadius := TrackBar4.Value;;
  CornerButton5.yRadius := TrackBar4.Value;;
  CornerButton6.xRadius := TrackBar4.Value;;
  CornerButton6.yRadius := TrackBar4.Value;;
end;

procedure TfrmCtrlsDemo.CheckBox3Change(Sender: TObject);
begin
  if CheckBox3.IsChecked then
    CornerButton1.Corners := CornerButton1.Corners + [vgCornerBottomRight]
  else
    CornerButton1.Corners := CornerButton1.Corners - [vgCornerBottomRight]
end;

procedure TfrmCtrlsDemo.CheckBox4Change(Sender: TObject);
begin
  if CheckBox4.IsChecked then
    CornerButton1.Corners := CornerButton1.Corners + [vgCornerTopRight]
  else
    CornerButton1.Corners := CornerButton1.Corners - [vgCornerTopRight]
end;

procedure TfrmCtrlsDemo.CheckBox5Change(Sender: TObject);
begin
  if CheckBox5.IsChecked then
    CornerButton1.Corners := CornerButton1.Corners + [vgCornerBottomLeft]
  else
    CornerButton1.Corners := CornerButton1.Corners - [vgCornerBottomLeft]
end;

procedure TfrmCtrlsDemo.CheckBox6Change(Sender: TObject);
begin
  if CheckBox6.IsChecked then
    CornerButton1.Corners := CornerButton1.Corners + [vgCornerTopLeft]
  else
    CornerButton1.Corners := CornerButton1.Corners - [vgCornerTopLeft]
end;

procedure TfrmCtrlsDemo.cornerListChange(Sender: TObject);
begin
  CornerButton1.CornerType := TvgCornerType(cornerList.ItemIndex);
  CornerButton2.CornerType := TvgCornerType(cornerList.ItemIndex);
  CornerButton3.CornerType := TvgCornerType(cornerList.ItemIndex);
  CornerButton4.CornerType := TvgCornerType(cornerList.ItemIndex);
  CornerButton5.CornerType := TvgCornerType(cornerList.ItemIndex);
  CornerButton6.CornerType := TvgCornerType(cornerList.ItemIndex);
end;

procedure TfrmCtrlsDemo.CheckBox7Change(Sender: TObject);
begin
  ListBox1.UseSmallScrollBars := CheckBox7.IsChecked;
  TreeView1.UseSmallScrollBars := CheckBox7.IsChecked;
end;

procedure TfrmCtrlsDemo.CheckBox2Change(Sender: TObject);
begin
  StringListBox1.MultiSelect := CheckBox2.IsChecked;
end;

procedure TfrmCtrlsDemo.calloutBottomChange(Sender: TObject);
begin
  if calloutLeft.IsChecked then
    CalloutPanel1.CalloutPosition := vgCalloutLeft;
  if calloutRight.IsChecked then
    CalloutPanel1.CalloutPosition := vgCalloutRight;
  if calloutTop.IsChecked then
    CalloutPanel1.CalloutPosition := vgCalloutTop;
  if calloutBottom.IsChecked then
    CalloutPanel1.CalloutPosition := vgCalloutBottom;
end;

end.
