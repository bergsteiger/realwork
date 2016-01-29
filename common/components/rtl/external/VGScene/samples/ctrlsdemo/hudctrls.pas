unit hudctrls;

interface

uses
  {$IFDEF FPC}
  LResources,
  {$ENDIF}                                                                                          
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_layouts, vg_effects, vg_objects, vg_controls,
  vg_ani, vg_textbox,  vg_listbox, vg_tabcontrol;

type                                           
  TfrmLayerDemo = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgLayout;
    HudWindow1: TvgHudWindow;
    HudButton1: TvgHudButton;
    HudNumberBox1: TvgHudNumberBox;
    HudTextBox1: TvgHudTextBox;
    HudScrollBar1: TvgHudScrollBar;
    HudScrollBar2: TvgHudScrollBar;
    HudTrack1: TvgHudTrack;
    HudTrackBar1: TvgHudTrackBar;
    Label1: TvgLabel;
    Label2: TvgLabel;
    HudListBox1: TvgHudListBox;
    HudTabControl1: TvgHudTabControl;
    HudTabItem1: TvgHudTabItem;
    Layout1: TvgLayout;
    HudTabItem2: TvgHudTabItem;
    Layout2: TvgLayout;
    HudSpinBox1: TvgHudSpinBox;
    HudCircleButton1: TvgHudCircleButton;
    HudRoundTextBox1: TvgHudRoundTextBox;
    HudCheckBox1: TvgHudCheckBox;
    HudRadioButton1: TvgHudRadioButton;
    HudStringComboBox1: TvgHudStringComboBox;
    procedure closeButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLayerDemo: TfrmLayerDemo;

implementation

{$R *.dfm}

procedure TfrmLayerDemo.closeButtonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Close;
end;

end.
