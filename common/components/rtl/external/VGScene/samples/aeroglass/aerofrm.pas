unit aerofrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_controls, vg_scene, vg_effects, vg_objects, StdCtrls, vg_listbox,
  vg_extctrls, vg_layouts;

type
  TfrmAeroGlass = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Label1: TLabel;
    Image1: TvgImage;
    Rectangle1: TvgRectangle;
    SpeedButton1: TvgSpeedButton;
    vgResources1: TvgResources;
    SpeedButton2: TvgSpeedButton;
    ShadowEffect1: TvgShadowEffect;
    ShadowEffect2: TvgShadowEffect;
    Text1: TvgText;
    ImageListBox1: TvgHorzImageListBox;
    Text2: TvgText;
    Text3: TvgText;
    OpenDialog1: TOpenDialog;
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAeroGlass: TfrmAeroGlass;

implementation

{$R *.dfm}

procedure TfrmAeroGlass.SpeedButton2Click(Sender: TObject);
begin
  { add folder }
  OpenDialog1.Filter := 'Image files|' + DefaultFilterClass.GetFileTypes;
  if OpenDialog1.Execute then
  begin
    ImageListBox1.AddFolder(ExtractFilePath(OpenDialog1.FileName));
  end;
end;

end.
