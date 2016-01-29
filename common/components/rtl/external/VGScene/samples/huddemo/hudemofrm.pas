unit hudemofrm;

interface

uses
  {$IFNDEF FPC}Windows, {$ELSE}LResources, {$ENDIF} SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_controls, vg_layouts, vg_listbox, vg_objects,
  vg_dsgn;

type
  TfrmHUDDemo = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    HudWindow: TvgHudWindow;
    Layout1: TvgLayout;
    HudLabel1: TvgHudLabel;
    OpacityTrack: TvgHudTrackBar;
    HudGroupBox1: TvgHudGroupBox;
    checkShowCaption: TvgHudCheckBox;
    checkShowClose: TvgHudCheckBox;
    checkShowGrip: TvgHudCheckBox;
    radioButtonLeft: TvgHudRadioButton;
    HudLabel2: TvgHudLabel;
    radioButtonRight: TvgHudRadioButton;
    buttonFill: TvgHudButton;
    btnStroke: TvgHudButton;
    fillColor: TvgRoundRect;
    strokeColor: TvgRoundRect;
    vgBrushDialog1: TvgBrushDialog;
    HudGroupBox2: TvgHudGroupBox;
    HudLabel3: TvgHudLabel;
    trackStrokeThickness: TvgHudTrackBar;
    HudLabel4: TvgHudLabel;
    popupStrokeDash: TvgHudPopupBox;
    HudButton1: TvgHudButton;
    procedure OpacityTrackChange(Sender: TObject);
    procedure checkShowCaptionChange(Sender: TObject);
    procedure checkShowCloseChange(Sender: TObject);
    procedure checkShowGripChange(Sender: TObject);
    procedure radioButtonLeftChange(Sender: TObject);
    procedure buttonFillClick(Sender: TObject);
    procedure btnStrokeClick(Sender: TObject);
    procedure trackStrokeThicknessChange(Sender: TObject);
    procedure popupStrokeDashChange(Sender: TObject);
    procedure HudButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHUDDemo: TfrmHUDDemo;

implementation

{$R *.dfm}

procedure TfrmHUDDemo.OpacityTrackChange(Sender: TObject);
begin
  HudWindow.Opacity := OpacityTrack.Value;
end;

procedure TfrmHUDDemo.checkShowCaptionChange(Sender: TObject);
begin
  HudWindow.ShowCaption := checkShowCaption.IsChecked;
end;

procedure TfrmHUDDemo.checkShowCloseChange(Sender: TObject);
begin
  HudWindow.ShowCloseButton := checkShowClose.IsChecked;
end;

procedure TfrmHUDDemo.checkShowGripChange(Sender: TObject);
begin
  HudWindow.ShowSizeGrip := checkShowGrip.IsChecked;
end;

procedure TfrmHUDDemo.radioButtonLeftChange(Sender: TObject);
begin
  if radioButtonLeft.IsChecked then
    HudWindow.ButtonAlign := vgButtonAlignLeft
  else
    HudWindow.ButtonAlign := vgButtonAlignRight
end;

procedure TfrmHUDDemo.buttonFillClick(Sender: TObject);
begin
  vgBrushDialog1.Brush.Assign(HudWindow.Fill);
  if vgBrushDialog1.Execute then
  begin
    HudWindow.Fill.Assign(vgBrushDialog1.Brush);
    fillColor.Fill.Assign(vgBrushDialog1.Brush);
  end;
end;

procedure TfrmHUDDemo.btnStrokeClick(Sender: TObject);
begin
  vgBrushDialog1.Brush.Assign(HudWindow.Stroke);
  if vgBrushDialog1.Execute then
  begin
    HudWindow.Stroke.Assign(vgBrushDialog1.Brush);
    strokeColor.Fill.Assign(vgBrushDialog1.Brush);
  end;
end;

procedure TfrmHUDDemo.trackStrokeThicknessChange(Sender: TObject);
begin
  HudWindow.StrokeThickness := trackStrokeThickness.Value;
end;

procedure TfrmHUDDemo.popupStrokeDashChange(Sender: TObject);
begin
  HudWindow.StrokeDash := TvgStrokeDash(popupStrokeDash.ItemIndex);
end;

procedure TfrmHUDDemo.HudButton1Click(Sender: TObject);
begin
  Close;
end;

end.
