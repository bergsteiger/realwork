unit flashdemofrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_flash, fe_flashplayer, vg_controls, vg_objects,
  vg_extctrls;

type
  TfrmFlash = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    feFlashList1: TfeFlashList;
    Button1: TvgButton;
    OpacityTrack: TvgCompoundTrackBar;
    Label1: TvgLabel;
    OpenDialog1: TOpenDialog;
    Label2: TvgLabel;
    HudWindow1: TvgHudWindow;
    FlashPlayer1: TvgFlashPlayer;
    procedure OpacityTrackChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFlash: TfrmFlash;

implementation

{$R *.dfm}

procedure TfrmFlash.OpacityTrackChange(Sender: TObject);
begin
  FlashPlayer1.Opacity := OpacityTrack.Value
end;

procedure TfrmFlash.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    FlashPlayer1.Movie := OpenDialog1.FileName;
end;

end.
