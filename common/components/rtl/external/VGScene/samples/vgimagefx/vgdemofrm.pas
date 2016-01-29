unit vgdemofrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_imagefx, vg_objects, vg_controls, vg_layouts,
  vg_listbox, vg_ani, vg_effects;

type
  TForm1 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Image1: TvgImage;
    ToolBar1: TvgToolBar;
    HudPanel1: TvgHudPanel;
    RippleEffect1: TvgRippleEffect;
    HudStringListBox1: TvgHudStringListBox;
    Text1: TvgText;
    Label1: TvgLabel;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  RippleEffect1.Center := Point(round(x), round(y));
  RippleEffect1.Phase := 0;
  RippleEffect1.AnimateFloat('Phase', 20, 1);
  RippleEffect1.AnimateFloat('Amplitude', 0.1, 0.5);
  RippleEffect1.AnimateFloatDelay('Amplitude', 0, 0.5, 0.5);
end;

end.
