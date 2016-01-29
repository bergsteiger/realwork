unit framefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_controls, StdCtrls;

type
  TfrmMain = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Label1: TvgLabel;
    Panel1: TvgPanel;
    Frame1: TvgFrame;
    Panel2: TvgPanel;
    Frame2: TvgFrame;
    Splitter1: TvgSplitter;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses secondfrm;

{$R *.dfm}

end.
