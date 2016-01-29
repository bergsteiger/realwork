unit ribbonfrm;

interface

uses
  {$IFNDEF FPC}Windows, {$ELSE}LResources, {$ENDIF} SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_controls, vg_objects, vg_layouts, vg_tabcontrol,
  vg_colors, vg_effects, vg_listbox, vg_textbox, vg_memo;

type
  TfrmRibbon = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    skinRibbon: TvgResources;
    Wnd: TvgHudWindow;
    RibbonButton: TvgHudButton;
    Text1: TvgText;
    Image1: TvgImage;
    HudTabControl1: TvgHudTabControl;
    HudTabItem1: TvgHudTabItem;
    Layout1: TvgLayout;
    HudTabItem2: TvgHudTabItem;
    Layout2: TvgLayout;
    HudTabItem3: TvgHudTabItem;
    Layout3: TvgLayout;
    HudStatusBar1: TvgHudStatusBar;
    ColorBox1: TvgColorBox;
    ColorPicker1: TvgColorPicker;
    ColorQuad1: TvgColorQuad;
    HudTabItem4: TvgHudTabItem;
    Layout4: TvgLayout;
    GlowEffect1: TvgGlowEffect;
    HudButton2: TvgHudButton;
    RibbonPopup: TvgPopup;
    Rectangle1: TvgRectangle;
    ShadowEffect1: TvgShadowEffect;
    HudButton1: TvgHudButton;
    HudSpeedButton1: TvgHudSpeedButton;
    HudSpeedButton2: TvgHudSpeedButton;
    HudSpeedButton3: TvgHudSpeedButton;
    HudSpeedButton4: TvgHudSpeedButton;
    HudSpeedButton5: TvgHudSpeedButton;
    Text2: TvgText;
    Rectangle3: TvgRectangle;
    Rectangle2: TvgRectangle;
    Rectangle4: TvgRectangle;
    HudLabel1: TvgHudLabel;
    HudSizeGrip1: TvgHudSizeGrip;
    HudAngleButton1: TvgHudAngleButton;
    HudCheckBox1: TvgHudCheckBox;
    HudHorzListBox1: TvgHudHorzListBox;
    HudGroupBox1: TvgHudGroupBox;
    HudGroupBox2: TvgHudGroupBox;
    Image2: TvgImage;
    Layout5: TvgLayout;
    HudSpeedButton6: TvgHudSpeedButton;
    HudSpeedButton7: TvgHudSpeedButton;
    HudSpeedButton8: TvgHudSpeedButton;
    HudTrackBar1: TvgHudTrackBar;
    HudTrackBar2: TvgHudTrackBar;
    HudLabel2: TvgHudLabel;
    HudLabel3: TvgHudLabel;
    Path1: TvgPath;
    ListBoxItem1: TvgListBoxItem;
    ListBoxItem2: TvgListBoxItem;
    ListBoxItem3: TvgListBoxItem;
    ListBoxItem4: TvgListBoxItem;
    ListBoxItem5: TvgListBoxItem;
    ListBoxItem6: TvgListBoxItem;
    ListBoxItem7: TvgListBoxItem;
    ListBoxItem8: TvgListBoxItem;
    ListBoxItem9: TvgListBoxItem;
    HudPopupBox1: TvgHudPopupBox;
    HudStringComboBox1: TvgHudStringComboBox;
    Layout6: TvgLayout;
    HudMemo1: TvgHudMemo;
    HudPanel1: TvgHudPanel;
    HudTextBox1: TvgHudTextBox;
    HudTrack1: TvgHudTrack;
    HudScrollBar1: TvgHudScrollBar;
    HudRadioButton1: TvgHudRadioButton;
    HudStringListBox1: TvgHudStringListBox;
    procedure ColorQuad1Change(Sender: TObject);
    procedure RibbonButtonClick(Sender: TObject);
    procedure HudButton1Click(Sender: TObject);
    procedure HudTrackBar1Change(Sender: TObject);
    procedure HudTrackBar2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRibbon: TfrmRibbon;

implementation

{$R *.dfm}

procedure TfrmRibbon.ColorQuad1Change(Sender: TObject);
begin
  Wnd.Fill.SolidColor := ColorBox1.color;
end;

procedure TfrmRibbon.RibbonButtonClick(Sender: TObject);
begin
  RibbonPopup.Popup;
end;

procedure TfrmRibbon.HudButton1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmRibbon.HudTrackBar1Change(Sender: TObject);
begin
  Wnd.Fill.SolidColor := (round(HudTrackBar1.Value * $FF) shl 24) or (Wnd.Fill.SolidColor and $FFFFFF);
  ColorQuad1.Alpha := HudTrackBar1.Value;
end;

procedure TfrmRibbon.HudTrackBar2Change(Sender: TObject);
begin
  Wnd.Opacity := HudTrackBar2.Value;
end;

end.
