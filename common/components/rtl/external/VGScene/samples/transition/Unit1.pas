unit Unit1;

interface

uses
  Classes, Controls, Forms, SysUtils, vg_layouts, vg_listbox, vg_scene,
  vg_controls, vg_textbox, vg_memo, vg_effects, vg_objects, vg_imagefx;

type
  TForm1 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    ToolBar1: TvgToolBar;
    Button11: TvgButton;
    Layout1: TvgPanel;
    Layout2: TvgPanel;
    Label3: TvgLabel;
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.Button11Click(Sender: TObject);
begin
  Button11.Enabled := false;
  with TvgRippleTransitionEffect.Create(Self) do
  begin
    if Layout2.Index < Layout1.Index then
    begin
      Parent := Layout1;
      Target := Layout2.MakeScreenshot;
    end
    else
    begin
      Parent := Layout2;
      Target := Layout1.MakeScreenshot;
    end;
    Progress := 0;
    AnimateFloatWait('Progress', 100, 1);
    Target.Free;
    Free;
    if Layout2.Index < Layout1.Index then
      Layout2.BringToFront
    else
      Layout1.BringToFront;
  end;
  Button11.Enabled := true;
end;

end.


