{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Media.iOS;

interface

uses
  iOSapi.CoreMedia, iOSapi.UIKit, iOSapi.AVFoundation, FMX.Media.AVFoundation;

type

  /// <summary>AVFoundation delegate specialization for iOS.</summary>
  TAVVideoSampleDelegate = class(TVideoSampleDelegateBase, AVCaptureVideoDataOutputSampleBufferDelegate)
  strict private
    FUIDevice: UIDevice;
    function DetectVideoOrientation: AVCaptureVideoOrientation;
  public
    /// <summary>Constructor with a device.</summary>
    constructor Create(const ACaptureDevice: TAVVideoCaptureDeviceBase);
    /// <summary>Delegate selector for captured video buffer.</summary>
    procedure captureOutput(captureOutput: AVCaptureOutput; didOutputSampleBuffer: CMSampleBufferRef; fromConnection: AVCaptureConnection); cdecl;
  end;

implementation

uses
  iOSapi.Foundation, iOSapi.CocoaTypes, iOSapi.CoreAudio, FMX.Platform.iOS, System.SysUtils, System.Messaging,
  System.Types, System.Classes, Macapi.Helpers, FMX.Consts, FMX.Forms, FMX.Types, FMX.Media, FMX.Controls,
  FMX.ZOrder.iOS, System.IOUtils, System.RTLConsts;

const
  UNKNOWN_VIDEO_ORIENTATION = 0;

type
  TAVMedia = class(TMedia)
  private
    FView: UIView;
    FPlayer: AVPlayer;
    FPlayerItem: AVPlayerItem;
    FPlayerLayer: AVPlayerLayer;
    FOrientationChangedId: Integer;
    procedure OrientationChanged(const Sender: TObject; const Msg: TMessage);
  protected
    function GetDuration: TMediaTime; override;
    function GetCurrent: TMediaTime; override;
    procedure SetCurrent(const Value: TMediaTime); override;
    function GetVideoSize: TPointF; override;
    function GetMediaState: TMediaState; override;
    function GetVolume: Single; override;
    procedure SetVolume(const Value: Single); override;
    procedure UpdateMediaFromControl; override;
    procedure DoPlay; override;
    procedure DoStop; override;
  public
    constructor Create(const AFileName: string); override;
    destructor Destroy; override;
  end;

  TAVMediaCodec = class(TCustomMediaCodec)
  public
    function CreateFromFile(const AFileName: string): TMedia; override;
  end;

{ TAVMedia }

constructor TAVMedia.Create(const AFileName: string);
var
  URL: NSUrl;
  AbsoluteFileName: string;
begin
  inherited Create(AFileName);
  AVMediaTypeAudio; // force load framework
  if FileExists(AFileName) then
  begin
    if ExtractFilePath(AFileName).IsEmpty then
      AbsoluteFileName := TPath.Combine(TPath.GetHomePath, AFileName)
    else
      AbsoluteFileName := AFileName;
    URL := TNSUrl.Wrap(TNSUrl.OCClass.fileURLWithPath(StrToNSStr(AbsoluteFileName)));
  end
  else
  begin
    URL := TNSUrl.Wrap(TNSUrl.OCClass.URLWithString(StrToNSStr(FileName)));
  end;

  if URL = nil then
    raise EFileNotFoundException.Create(SFileNotFound);

  FPlayerItem := TAVPlayerItem.Wrap(TAVPlayerItem.OCClass.playerItemWithURL(URL));
  FPlayerItem.retain;
  FPlayer := TAVPlayer.Wrap(TAVPlayer.OCClass.playerWithPlayerItem(FPlayerItem));
  FPlayer.retain;
  FPlayerLayer := TAVPlayerLayer.Wrap(TAVPlayerLayer.OCClass.playerLayerWithPlayer(FPlayer));
  FPlayerLayer.retain;
  FOrientationChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TOrientationChangedMessage,
    OrientationChanged);
  FView := TUIView.Create;
  FView.retain;
  FView.layer.addSublayer(FPlayerLayer);
end;

destructor TAVMedia.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TOrientationChangedMessage, FOrientationChangedId);
  FView.setHidden(True);
  FView.release;
  FView := nil;
  FOrientationChangedId := 0;
  if FPlayerLayer <> nil then
    FPlayerLayer.removeFromSuperlayer;
  FPlayerLayer.release;
  FPlayerLayer := nil;
  FPlayer.release;
  FPlayer := nil;
  FPlayerItem.release;
  FPlayerItem := nil;
  inherited Destroy;
end;

function TAVMedia.GetCurrent: TMediaTime;
begin
  if (FPlayerItem <> nil) and (FPlayerItem.currentTime.timeScale <> 0) then
    Result := Trunc(FPlayerItem.currentTime.Value / FPlayerItem.currentTime.timeScale * MediaTimeScale)
  else
    Result := 0;
end;

function TAVMedia.GetDuration: TMediaTime;
begin
  if (FPlayerItem <> nil) and (FPlayerItem.duration.timeScale <> 0) then
    Result := Trunc(FPlayerItem.duration.Value / FPlayerItem.duration.timeScale * MediaTimeScale)
  else
    Result := 0;
end;

function TAVMedia.GetMediaState: TMediaState;
begin
  if (FPlayer <> nil) and (FPlayer.status <> AVPlayerStatusFailed) then
  begin
    if (FPlayer.Rate > 0) then
      Result := TMediaState.Playing
    else
      Result := TMediaState.Stopped
  end
  else
    Result := TMediaState.Unavailable;
end;

function TAVMedia.GetVideoSize: TPointF;
begin
  if FPlayerItem <> nil then
    Result := PointF(FPlayerItem.presentationSize.width, FPlayerItem.presentationSize.height)
  else
    Result := TPointF.Zero;
end;

function TAVMedia.GetVolume: Single;
begin
  Result := FPlayer.volume;
end;

procedure TAVMedia.SetCurrent(const Value: TMediaTime);
begin
  if FPlayer <> nil then
    FPlayer.seekToTime(CMTimeMake(Value, MediaTimeScale));
end;

procedure TAVMedia.SetVolume(const Value: Single);
begin
  FPlayer.setVolume(Value);
end;

procedure TAVMedia.UpdateMediaFromControl;
var
  Form: TCommonCustomForm;
begin
  if (Control <> nil) and (FView <> nil) and (Control.Root is TCommonCustomForm) then
  begin
    Form := TCommonCustomForm(Control.Root);
    WindowHandleToPlatform(Form.Handle).ZOrderManager.UpdateOrderAndBounds(Control, FView);
    FPlayerLayer.setFrame(FView.bounds);
  end
  else
    FView.setHidden(True);
end;

procedure TAVMedia.OrientationChanged(const Sender: TObject; const Msg: TMessage);
begin
  UpdateMediaFromControl;
end;

procedure TAVMedia.DoStop;
begin
  if FPlayer <> nil then
    FPlayer.pause;
end;

procedure TAVMedia.DoPlay;
var
  error: NSError;
  AudioSession: AVAudioSession;
begin
  AudioSession := TAVAudioSession.Wrap(TAVAudioSession.OCClass.sharedInstance);
  AudioSession.setCategory(AVAudioSessionCategoryPlayback, error);
  AudioSession.setActive(True, Error);
  if FPlayer <> nil then
  begin
    FPlayer.play;
    UpdateMediaFromControl;
  end;
end;

{ TAVMediaCodec }

function TAVMediaCodec.CreateFromFile(const AFileName: string): TMedia;
begin
  Result := TAVMedia.Create(AFileName);
end;

{ TVideoSampleDelegate }

constructor TAVVideoSampleDelegate.Create(const ACaptureDevice: TAVVideoCaptureDeviceBase);
begin
  inherited;
  FIsProcessingCapture := False;
  FUIDevice := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
end;

function TAVVideoSampleDelegate.DetectVideoOrientation: AVCaptureVideoOrientation;
begin
  Result := UNKNOWN_VIDEO_ORIENTATION;

  case FUIDevice.orientation of
    AVCaptureVideoOrientationLandscapeLeft:
      if TScreenOrientation.Landscape in Application.FormFactor.Orientations then
        Result := AVCaptureVideoOrientationLandscapeLeft;
    AVCaptureVideoOrientationLandscapeRight:
      if TScreenOrientation.InvertedLandscape in Application.FormFactor.Orientations then
        Result := AVCaptureVideoOrientationLandscapeRight;
    AVCaptureVideoOrientationPortraitUpsideDown:
      if TScreenOrientation.InvertedPortrait in Application.FormFactor.Orientations then
        Result := AVCaptureVideoOrientationPortraitUpsideDown;
    AVCaptureVideoOrientationPortrait:
      if TScreenOrientation.Portrait in Application.FormFactor.Orientations then
        Result := AVCaptureVideoOrientationPortrait;
  end;
end;

procedure TAVVideoSampleDelegate.captureOutput(captureOutput: AVCaptureOutput; didOutputSampleBuffer: CMSampleBufferRef;
  fromConnection: AVCaptureConnection);
var
  VideoOrientation: NSInteger;
begin
  FIsProcessingCapture := True;
  try
    VideoOrientation := DetectVideoOrientation;
    if VideoOrientation <> UNKNOWN_VIDEO_ORIENTATION then
      fromConnection.setVideoOrientation(VideoOrientation);
    FCaptureDevice.SampleDelegate(didOutputSampleBuffer);
  finally
    FIsProcessingCapture := False;
  end;
end;

initialization
  TMediaCodecManager.RegisterMediaCodecClass('.mov', SVMOVFiles, TMediaType.Video, TAVMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.m4v', SVM4VFiles, TMediaType.Video, TAVMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.mp4', SVMP4Files, TMediaType.Video, TAVMediaCodec);

  TMediaCodecManager.RegisterMediaCodecClass('.wav', SVWAVFiles, TMediaType.Audio, TAVMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.m4a', SVM4AFiles, TMediaType.Audio, TAVMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.caf', SVCAFFiles, TMediaType.Audio, TAVMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.mp3', SVMP3Files, TMediaType.Audio, TAVMediaCodec);

  TMediaCodecManager.RegisterMediaCodecClass(SAllFilesExt, SDefault, TMediaType.Video, TAVMediaCodec);
end.
