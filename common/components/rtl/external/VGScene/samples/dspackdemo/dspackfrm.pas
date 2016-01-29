unit dspackfrm;

interface

{$I vg_define.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_controls, vg_scene, vg_objects, DSPack, vg_extctrls,
  ExtCtrls, DirectShow9,
  {$IFDEF KS_COMPILER10_UP} DSUtils, {$ELSE} DSUtil,  {$ENDIF}
  vg_effects;

type
  TfrmDSPackDemo = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    HudWindow1: TvgHudWindow;
    FilterGraph: TFilterGraph;
    VideoWindow1: TVideoWindow;
    SampleGrabber1: TSampleGrabber;
    Image1: TvgImage;
    HudButton1: TvgHudButton;
    OpenDialog: TOpenDialog;
    Rectangle1: TvgRectangle;
    PositionTrack: TvgHudTrack;
    VolumeBar: TvgHudTrackBar;
    CompoundTrackBar1: TvgCompoundTrackBar;
    Timer1: TTimer;
    Frame: TvgRectangle;
    GlowEffect1: TvgGlowEffect;
    procedure SampleGrabber1Buffer(sender: TObject; SampleTime: Double;
      pBuffer: Pointer; BufferLen: Integer);
    procedure HudButton1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure VolumeBarChange(Sender: TObject);
    procedure CompoundTrackBar1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PositionTrackChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDSPackDemo: TfrmDSPackDemo;

implementation

{$R *.dfm}

procedure TfrmDSPackDemo.HudButton1Click(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    if not FilterGraph.Active then FilterGraph.Active := true;
    // clear load flag
    Image1.Tag := 0;
    //
    FilterGraph.ClearGraph;
    try
      FilterGraph.RenderFile(OpenDialog.FileName);
      VolumeBar.Value := FilterGraph.Volume / 10000;
      FilterGraph.Play;
    except
    end;
  end;
end;

procedure TfrmDSPackDemo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  // Important
  FilterGraph.ClearGraph;
end;

procedure TfrmDSPackDemo.SampleGrabber1Buffer(sender: TObject; SampleTime: Double;
  pBuffer: Pointer; BufferLen: Integer);
var
  i: integer;
  B: Tbitmap;
begin
  { skip transfer if scene is drawing }
  if vgScene1.IsDrawing then Exit;
  { grab stream to TvgBitmap }
  if Image1.Tag = 0 then
  begin
    { First time we need to get video size }
    B := Tbitmap.create;
    SampleGrabber1.GetBitmap(B);
    Image1.Bitmap.SetSize(B.Width, B.Height);
    // set load flag
    Image1.Tag := 1;
    // just for Fit
    Frame.SetBounds(0, 0, B.Width / 10, B.Height / 10);
    Rectangle1.Repaint;
    B.free;
  end;
  { grabbing }
  if Image1.Tag > 0 then
  begin
    // transfer - need to flip - because source have different orientation
    for i := 0 to Image1.Bitmap.Height - 1 do
      Move(PvgColorArray(pBuffer)[(Image1.Bitmap.Height - i - 1) * Image1.Bitmap.Width], Image1.Bitmap.Scanline[i]^, Image1.Bitmap.Width * 4);
    // set alpha-channel
    vgFillAlpha(Image1.Bitmap.Startline, BufferLen div 4, $FF);
  end;
  Image1.Repaint;
end;

procedure TfrmDSPackDemo.VolumeBarChange(Sender: TObject);
begin
  FilterGraph.Volume := Round(VolumeBar.Value * 10000);
end;

procedure TfrmDSPackDemo.CompoundTrackBar1Change(Sender: TObject);
begin
  Image1.Opacity := CompoundTrackBar1.Value;
end;

procedure TfrmDSPackDemo.Timer1Timer(Sender: TObject);
var
  MediaSeeking: IMediaSeeking;
  CurrentPos, StopPos: int64;
  MlsCurrentPos, MlsStopPos: Cardinal;
begin
  if FilterGraph.Active and (not PositionTrack.IsTracking) then
  begin
    FilterGraph.QueryInterface(IMediaSeeking, MediaSeeking);
    if Assigned(MediaSeeking) then
    begin
      if Succeeded(MediaSeeking.GetDuration(StopPos)) then
      if Succeeded(MediaSeeking.GetCurrentPosition(CurrentPos)) then
      begin
        MlsCurrentPos := RefTimeToMiliSec(CurrentPos);
        MlsStopPos    := RefTimeToMiliSec(StopPos);

        PositionTrack.OnChange := nil;
        PositionTrack.min := 0;
        PositionTrack.max := MlsStopPos;
        PositionTrack.value := MlsCurrentPos;
        PositionTrack.Viewportsize := MlsStopPos / 10;
        PositionTrack.OnChange := PositionTrackChange;
      end;
    end;
    MediaSeeking := nil;
  end;
end;

procedure TfrmDSPackDemo.PositionTrackChange(Sender: TObject);
var
  MediaSeeking: IMediaSeeking;
  CurrentPos, StopPos: int64;
  MlsCurrentPos, MlsStopPos: Cardinal;
begin
  if FilterGraph.Active then
  begin
    FilterGraph.QueryInterface(IMediaSeeking, MediaSeeking);
    if Assigned(MediaSeeking) then
    begin
      if Succeeded(MediaSeeking.GetDuration(StopPos)) then
      if Succeeded(MediaSeeking.GetCurrentPosition(CurrentPos)) then
      begin
        CurrentPos := (StopPos * trunc(PositionTrack.Value)) div trunc(PositionTrack.max);
        MediaSeeking.SetPositions(CurrentPos, AM_SEEKING_AbsolutePositioning,
          StopPos, AM_SEEKING_NoPositioning);
      end;
    end;
    MediaSeeking := nil;
  end;
end;

end.
