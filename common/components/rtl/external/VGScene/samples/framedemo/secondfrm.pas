unit secondfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_controls, vg_objects, vg_layouts, vg_listbox;

type
  TfrmChild = class(TForm)
    frameScene1: TvgScene;
    Root1: TvgBackground;
    Rectangle1: TvgRectangle;
    Label1: TvgLabel;
    HudTrackBar1: TvgHudTrackBar;
    Label2: TvgLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChild: TfrmChild;

implementation

{$R *.dfm}

end.
