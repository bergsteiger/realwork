{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Media.iOS;

interface

uses
  System.Variants, System.Classes, System.SysUtils, System.Math, System.Types,
  System.UIConsts,
  Macapi.ObjectiveC, Macapi.ObjCRuntime, Macapi.CoreFoundation, Macapi.Dispatch,
  iOSapi.CocoaTypes, iOSapi.Foundation, iOSapi.UIKit, iOSapi.CoreAudio, iOSapi.CoreVideo,
  iOSapi.CoreMedia, iOSapi.AVFoundation, iOSapi.CoreGraphics,
  FMX.Consts, FMX.Types, FMX.Types3D, FMX.Forms, FMX.Media, FMX.Canvas.iOS,
  FMX.Platform.iOS, FMX.PixelFormats;

type

{ TAVCaptureDeviceManager }

  TAVCaptureDeviceManager = class(TCaptureDeviceManager)
  public
    constructor Create; override;
  end;

{ TAVMedia }

  TAVMedia = class(TMedia)
  private
    FPlayer: AVPlayer;
    FPlayerItem: AVPlayerItem;
    FPlayerLayer: AVPlayerLayer;
  protected
    procedure SeekToBegin;
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

{ TAVMediaCodec }

  TAVMediaCodec = class(TCustomMediaCodec)
  public
    function CreateFromFile(const AFileName: string): TMedia; override;
  end;

implementation

uses
  System.RTLConsts;

type

{ TAVAudioCaptureDevice }

  TAVAudioCaptureDevice = class(TAudioCaptureDevice)
  private
    FDevice: AVCaptureDevice;
    FAudioRecorder: AVAudioRecorder;
  protected
    procedure DoStartCapture; override;
    procedure DoStopCapture; override;
    function GetDeviceProperty(const Prop: TCaptureDevice.TProperty): string; override;
    function GetDeviceState: TCaptureDeviceState; override;
  public
    constructor Create(const AManager: TCaptureDeviceManager; const ADefault: Boolean; const ADevice: AVCaptureDevice); reintroduce;
  end;

{ TAVVideoCaptureDevice }

  TAVVideoCaptureDevice = class;

  TVideoSampleDelegate = class(TOCLocal, AVCaptureVideoDataOutputSampleBufferDelegate)
  public
    FDevice: TAVVideoCaptureDevice;
    procedure captureOutput(captureOutput: AVCaptureOutput; didOutputSampleBuffer: CMSampleBufferRef; fromConnection: AVCaptureConnection); cdecl;
  end;

  TAVVideoCaptureDevice = class(TVideoCaptureDevice)
  private
    FCurrentDevice: UIDevice;
    FDevice: AVCaptureDevice;
    FSession: AVCaptureSession;
    FInput: AVCaptureDeviceInput;
    FOutput: AVCaptureVideoDataOutput;
    FSampleDelegate: TVideoSampleDelegate;
    FSampleBuffer: CMSampleBufferRef;
    FImageBuffer: CVImageBufferRef;
    FQuality: TVideoCaptureQuality;
    procedure SampleDelegate;
    procedure SyncCall;
  protected
    procedure DoStartCapture; override;
    procedure DoStopCapture; override;
    procedure DoSampleBufferToBitmap(const ABitmap: TBitmap; const ASetSize: Boolean); override;
    function GetDeviceProperty(const Prop: TCaptureDevice.TProperty): string; override;
    function GetDeviceState: TCaptureDeviceState; override;
    function GetPosition: TDevicePosition; override;
    function GetQuality: TVideoCaptureQuality; override;
    procedure SetQuality(const Value: TVideoCaptureQuality); override;
    function GetHasFlash: Boolean; override;
    function GetFlashMode: TFlashMode; override;
    procedure SetFlashMode(const Value: TFlashMode); override;
    function GetHasTorch: Boolean; override;
    function GetTorchMode: TTorchMode; override;
    procedure SetTorchMode(const Value: TTorchMode); override;
    function GetFocusMode: TFocusMode; override;
    procedure SetFocusMode(const Value: TFocusMode); override;
  public
    constructor Create(const AManager: TCaptureDeviceManager; const ADefault: Boolean; const ADevice: AVCaptureDevice); reintroduce;
  end;

{ TAVCaptureDeviceManager }

constructor TAVCaptureDeviceManager.Create;
var
  I: Integer;
  DP: Pointer;
  D: AVCaptureDevice;
  Device : TAVAudioCaptureDevice;
begin
  inherited;
  if TAVCaptureDevice.OCClass.devicesWithMediaType(AVMediaTypeAudio).count > 0 then
    for I := 0 to TAVCaptureDevice.OCClass.devicesWithMediaType(AVMediaTypeAudio).count - 1 do
    begin
      DP := TAVCaptureDevice.OCClass.devicesWithMediaType(AVMediaTypeAudio).objectAtIndex(I);
      D := TAVCaptureDevice.Wrap(DP);
      Device := TAVAudioCaptureDevice.Create(Self, TAVCaptureDevice.OCClass.defaultDeviceWithMediaType(AVMediaTypeAudio) = DP, D);
    end;
  if TAVCaptureDevice.OCClass.devicesWithMediaType(AVMediaTypeVideo).count > 0 then
    for I := 0 to TAVCaptureDevice.OCClass.devicesWithMediaType(AVMediaTypeVideo).count - 1 do
    begin
      DP := TAVCaptureDevice.OCClass.devicesWithMediaType(AVMediaTypeVideo).objectAtIndex(I);
      D := TAVCaptureDevice.Wrap(DP);
      TAVVideoCaptureDevice.Create(Self, TAVCaptureDevice.OCClass.defaultDeviceWithMediaType(AVMediaTypeVideo) = DP, D);
    end;
end;

{ TAVAudioCaptureDevice }

constructor TAVAudioCaptureDevice.Create(const AManager: TCaptureDeviceManager; const ADefault: Boolean; const ADevice: AVCaptureDevice);
begin
  inherited Create(AManager, ADefault);
  FDevice := ADevice;
end;

procedure TAVAudioCaptureDevice.DoStartCapture;

  function GetRecordSettings: NSMutableDictionary;
  begin
    Result := TNSMutableDictionary.Create;
    Result.setObject(TNSNumber.OCClass.numberWithFloat(44100.0), (AVSampleRateKey as ILocalObject).getObjectId);
    Result.setObject(TNSNumber.OCClass.numberWithFloat(12800.0), (AVEncoderBitRateKey as ILocalObject).getObjectId);
    Result.setObject(TNSNumber.OCClass.numberWithInt(16), (AVLinearPCMBitDepthKey as ILocalObject).getObjectId);
    Result.setObject(TNSNumber.OCClass.numberWithInt(2), (AVNumberOfChannelsKey as ILocalObject).getObjectId);
  end;

var
  Error: NSError;
  URL: NSUrl;
  AudioSession: AVAudioSession;
begin
  if Assigned(FAudioRecorder) and FAudioRecorder.isRecording then
    FAudioRecorder.stop;
  if Assigned(FAudioRecorder) then
  begin
    FAudioRecorder.release;
    FAudioRecorder := nil;
  end;

  URL := TNSUrl.Wrap(TNSUrl.OCClass.fileURLWithPath(NSStr(FileName)));

  AudioSession := TAVAudioSession.Wrap(TAVAudioSession.OCClass.sharedInstance);
  AudioSession.setCategory(AVAudioSessionCategoryRecord, error);
  AudioSession.setActive(True, Error);

  // Initialization of Audio Recorder
  FAudioRecorder := TAVAudioRecorder.Alloc;
  FAudioRecorder.initWithURL(URL, GetRecordSettings, Error);
  FAudioRecorder.retain;
  if not Assigned(Error) then
    FAudioRecorder.&record;
end;

procedure TAVAudioCaptureDevice.DoStopCapture;
begin
  if FAudioRecorder <> nil then
  begin
    FAudioRecorder.stop;
    FAudioRecorder.release;
    FAudioRecorder := nil;
  end;
end;

function TAVAudioCaptureDevice.GetDeviceProperty(const Prop: TCaptureDevice.TProperty): string;
begin
  if FDevice <> nil then
  begin
    case Prop of
      TProperty.Description: Result := '';
      TProperty.Name: Result := UTF8ToString(FDevice.localizedName.UTF8String);
      TProperty.UniqueID: Result := UTF8ToString(FDevice.uniqueID.UTF8String);
    else
      Result := '';
    end;
  end
  else
    Result := '';
end;

function TAVAudioCaptureDevice.GetDeviceState: TCaptureDeviceState;
begin
  if Assigned(FAudioRecorder) and (FAudioRecorder.isRecording) then
    Result := TCaptureDeviceState.Capturing
  else
    Result := TCaptureDeviceState.Stopped;
end;

{ TVideoSampleDelegate }

procedure TVideoSampleDelegate.captureOutput(captureOutput: AVCaptureOutput; didOutputSampleBuffer: CMSampleBufferRef; fromConnection: AVCaptureConnection);
begin
  case FDevice.FCurrentDevice.orientation of
    AVCaptureVideoOrientationLandscapeLeft:
      if TScreenOrientation.soLandscape in Application.FormFactor.Orientations then
        fromConnection.setVideoOrientation(AVCaptureVideoOrientationLandscapeLeft);
    AVCaptureVideoOrientationLandscapeRight:
      if TScreenOrientation.soInvertedLandscape in Application.FormFactor.Orientations then
        fromConnection.setVideoOrientation(AVCaptureVideoOrientationLandscapeRight);
    AVCaptureVideoOrientationPortraitUpsideDown:
      if TScreenOrientation.soInvertedPortrait in Application.FormFactor.Orientations then
        fromConnection.setVideoOrientation(AVCaptureVideoOrientationPortraitUpsideDown);
    AVCaptureVideoOrientationPortrait:
      if TScreenOrientation.soPortrait in Application.FormFactor.Orientations then
        fromConnection.setVideoOrientation(AVCaptureVideoOrientationPortrait);
  end;
  FDevice.FSampleBuffer := didOutputSampleBuffer;
  FDevice.SampleDelegate;
  FDevice.FSampleBuffer := nil;
end;

{ TAVVideoCaptureDevice }

constructor TAVVideoCaptureDevice.Create(const AManager: TCaptureDeviceManager; const ADefault: Boolean; const ADevice: AVCaptureDevice);
begin
  inherited Create(AManager, ADefault);
  FDevice := ADevice;
  FCurrentDevice := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
end;

procedure TAVVideoCaptureDevice.SampleDelegate;
begin
  FImageBuffer := CMSampleBufferGetImageBuffer(FSampleBuffer);
  CVBufferRetain(FImageBuffer);
  try
    TThread.Synchronize(TThread.CurrentThread, SyncCall);
  finally
    CVBufferRelease(FImageBuffer);
    FImageBuffer := 0;
  end;
end;

procedure TAVVideoCaptureDevice.SetFlashMode(const Value: TFlashMode);
begin
  if Assigned(FDevice) then
  begin
    FDevice.lockForConfiguration(nil);
    case Value of
      TFlashMode.fmAutoFlash:
        begin
          FDevice.setFlashMode(AVCaptureFlashModeAuto);
          FDevice.setTorchMode(AVCaptureTorchModeAuto);
        end;
      TFlashMode.fmFlashOff:
        begin
          FDevice.setFlashMode(AVCaptureFlashModeOff);
          FDevice.setTorchMode(AVCaptureTorchModeOff);
        end;
      TFlashMode.fmFlashOn:
        begin
          FDevice.setFlashMode(AVCaptureFlashModeOn);
          FDevice.setTorchMode(AVCaptureTorchModeOn);
        end;
    end;
    FDevice.unlockForConfiguration;
  end;
end;

procedure TAVVideoCaptureDevice.SetFocusMode(const Value: TFocusMode);
begin
  if Assigned(FDevice) then
  begin
    FDevice.lockForConfiguration(nil);
    case Value of
      TFocusMode.fmAutoFocus: FDevice.setFocusMode(AVCaptureFocusModeAutoFocus);
      TFocusMode.fmContinuousAutoFocus: FDevice.setFocusMode(AVCaptureFocusModeContinuousAutoFocus);
      TFocusMode.fmLocked: FDevice.setFocusMode(AVCaptureFocusModeLocked);
    end;
    FDevice.unlockForConfiguration;
  end;
end;

procedure TAVVideoCaptureDevice.SetQuality(const Value: TVideoCaptureQuality);
begin
  FQuality := Value;
end;

procedure TAVVideoCaptureDevice.SetTorchMode(const Value: TTorchMode);
begin
  if Assigned(FDevice) then
  begin
    FDevice.lockForConfiguration(nil);
    case Value of
      TTorchMode.tmModeOff: FDevice.setTorchMode(AVCaptureTorchModeOff);
      TTorchMode.tmModeOn: FDevice.setTorchMode(AVCaptureTorchModeOn);
      TTorchMode.tmModeAuto: FDevice.setTorchMode(AVCaptureTorchModeAuto);
    end;
    FDevice.unlockForConfiguration;
  end;
end;

procedure TAVVideoCaptureDevice.SyncCall;
var
  T: CMTime;
begin
  T := CMSampleBufferGetPresentationTimeStamp(FSampleBuffer);
  SampleBufferReady(T.value div T.timescale);
end;

function CGRectFromRect(const R: TRectF): CGRect;
begin
  Result.origin.x := R.Left;
  Result.origin.Y := R.Top;
  Result.size.Width := R.Right - R.Left;
  Result.size.Height := R.Bottom - R.Top;
end;

procedure TAVVideoCaptureDevice.DoSampleBufferToBitmap(const ABitmap: TBitmap; const ASetSize: Boolean);
var
  I: Integer;
  bytesPerRow, width, height: Integer;
  baseAddress: Pointer;
  AlphaColorLine: Pointer;
  Map: TBitmapData;
begin
  if FSampleBuffer = nil then Exit;
  // Lock the base address of the pixel buffer.
  if CVPixelBufferLockBaseAddress(FImageBuffer, 0) = 0 then
  begin
    // Get the number of bytes per row for the pixel buffer.
    bytesPerRow := CVPixelBufferGetBytesPerRow(FImageBuffer);
    // Get the pixel buffer width and height.
    width := CVPixelBufferGetWidth(FImageBuffer);
    height := CVPixelBufferGetHeight(FImageBuffer);
    // Get the base address of the pixel buffer.
    baseAddress := CVPixelBufferGetBaseAddress(FImageBuffer);
    // Resize bitmap if need
    if ASetSize then
      ABitmap.SetSize(width, height);
    // Create and return an image object to represent the Quartz image.
    if ABitmap.Map(TMapAccess.maWrite, Map) then
    try
      GetMem(AlphaColorLine, width * 4);
      for I := 0 to height - 1 do
      begin
        ScanlineToAlphaColor(@PLongByteArray(baseAddress)[bytesPerRow * I], AlphaColorLine, width, TPixelFormat.pfA8R8G8B8);
        AlphaColorToScanline(AlphaColorLine, Map.GetScanline(I), width, TPixelFormat.pfA8B8G8R8);
      end;
      FreeMem(AlphaColorLine);
    finally
      ABitmap.Unmap(Map);
    end;
    //
    CVPixelBufferUnlockBaseAddress(FImageBuffer, 0);
  end;
end;

procedure TAVVideoCaptureDevice.DoStartCapture;
var
  Error: NSError;
  Queue: dispatch_queue_t;
  VS: NSDictionary;
begin
  FSession := TAVCaptureSession.Create;
  case FQuality of
    TVideoCaptureQuality.vcPhotoQuality: FSession.setSessionPreset(AVCaptureSessionPresetPhoto);
    TVideoCaptureQuality.vcHighQuality: FSession.setSessionPreset(AVCaptureSessionPresetHigh);
    TVideoCaptureQuality.vcMediumQuality: FSession.setSessionPreset(AVCaptureSessionPresetMedium);
    TVideoCaptureQuality.vcLowQuality: FSession.setSessionPreset(AVCaptureSessionPresetLow);
  end;

  FInput := TAVCaptureDeviceInput.Wrap(TAVCaptureDeviceInput.OCClass.deviceInputWithDevice(FDevice, Error));
  FSession.addInput(FInput);

  FOutput := TAVCaptureVideoDataOutput.Create;
  FSession.addOutput(FOutput);

  FSampleDelegate := TVideoSampleDelegate.Create;
  FSampleDelegate.FDevice := Self;

  Queue := dispatch_queue_create('Video Capture Queue', 0);
  FOutput.setSampleBufferDelegate(ILocalObject(FSampleDelegate).GetObjectID, Queue);
  dispatch_release(Queue);

  VS := TNSDictionary.Wrap(TNSDictionary.OCClass.dictionaryWithObject(TNSNumber.OCClass.numberWithInt(kCVPixelFormatType_32BGRA), Pointer(kCVPixelBufferPixelFormatTypeKey)));
  FOutput.setVideoSettings(VS);
  FSession.startRunning;
end;

procedure TAVVideoCaptureDevice.DoStopCapture;
begin
  FSession.stopRunning;
end;

function TAVVideoCaptureDevice.GetDeviceProperty(const Prop: TCaptureDevice.TProperty): string;
begin
  if FDevice <> nil then
  begin
    case Prop of
      TProperty.Description: Result := '';
      TProperty.Name: Result := UTF8ToString(FDevice.localizedName.UTF8String);
      TProperty.UniqueID: Result := UTF8ToString(FDevice.uniqueID.UTF8String);
    else
      Result := '';
    end;
  end
  else
    Result := '';
end;

function TAVVideoCaptureDevice.GetDeviceState: TCaptureDeviceState;
begin
  if Assigned(FSession) and (FSession.isRunning) then
    Result := TCaptureDeviceState.Capturing
  else
    Result := TCaptureDeviceState.Stopped;
end;

function TAVVideoCaptureDevice.GetFlashMode: TFlashMode;
begin
  Result := inherited GetFlashMode;
  if Assigned(FDevice) then
    case FDevice.flashMode of
      AVCaptureFlashModeAuto: Result := TFlashMode.fmAutoFlash;
      AVCaptureFlashModeOff: Result := TFlashMode.fmFlashOff;
      AVCaptureFlashModeOn: Result := TFlashMode.fmFlashOn;
    end;
end;

function TAVVideoCaptureDevice.GetFocusMode: TFocusMode;
begin
  Result := inherited GetFocusMode;
  if Assigned(FDevice) then
    case FDevice.focusMode of
      AVCaptureFocusModeAutoFocus: Result := TFocusMode.fmAutoFocus;
      AVCaptureFocusModeContinuousAutoFocus: Result := TFocusMode.fmContinuousAutoFocus;
      AVCaptureFocusModeLocked: Result := TFocusMode.fmLocked;
    end;
end;

function TAVVideoCaptureDevice.GetHasFlash: Boolean;
begin
  if Assigned(FDevice) then
    Result := FDevice.hasFlash
  else
    Result := False;
end;

function TAVVideoCaptureDevice.GetHasTorch: Boolean;
begin
  if Assigned(FDevice) then
    Result := FDevice.hasTorch
  else
    Result := False;
end;

function TAVVideoCaptureDevice.GetPosition: TDevicePosition;
begin
  if FDevice <> nil then
  begin
    case FDevice.position of
      AVCaptureDevicePositionBack: Result := TDevicePosition.dpBack;
      AVCaptureDevicePositionFront: Result := TDevicePosition.dpFront;
    else
      Result := TDevicePosition.dpUnspecified;
    end;
  end
  else
    Result := TDevicePosition.dpUnspecified;
end;

function TAVVideoCaptureDevice.GetQuality: TVideoCaptureQuality;
begin
  Result := FQuality;
end;

function TAVVideoCaptureDevice.GetTorchMode: TTorchMode;
begin
  Result := inherited GetTorchMode;
  if Assigned(FDevice) then
    case FDevice.TorchMode of
      AVCaptureTorchModeOff: Result := TTorchMode.tmModeOff;
      AVCaptureTorchModeOn: Result := TTorchMode.tmModeOn;
      AVCaptureTorchModeAuto: Result := TTorchMode.tmModeAuto;
    end;
end;

{ TAVMedia }

constructor TAVMedia.Create(const AFileName: string);
var
  URL: NSUrl;
  AbsoluteFileName: string;
begin
  inherited Create(AFileName);
  AVMediaTypeAudio; // force load framework
  if ExtractFilePath(AFileName).IsEmpty then
    AbsoluteFileName := UTF8ToString(TNSString.Wrap(NSHomeDirectory).UTF8String) + '/' + AFileName
  else
    AbsoluteFileName := AFileName;
  URL := TNSUrl.Wrap(TNSUrl.OCClass.fileURLWithPath(NSStr(AbsoluteFileName)));
  FPlayerItem := TAVPlayerItem.Wrap(TAVPlayerItem.OCClass.playerItemWithURL(URL));
  FPlayerItem.retain;
  FPlayer := TAVPlayer.Wrap(TAVPlayer.OCClass.playerWithPlayerItem(FPlayerItem));
  FPlayer.retain;
  FPlayerLayer := TAVPlayerLayer.Wrap(TAVPlayerLayer.OCClass.playerLayerWithPlayer(FPlayer));
  FPlayerLayer.retain;
end;

destructor TAVMedia.Destroy;
begin
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
  if Assigned(FPlayerItem) then
    Result := Trunc(FPlayerItem.currentTime.Value / FPlayerItem.currentTime.timeScale * MediaTimeScale)
  else
    Result := 0;
end;

function TAVMedia.GetDuration: TMediaTime;
begin
  if Assigned(FPlayerItem) then
    Result := Trunc(FPlayerItem.duration.Value / FPlayerItem.duration.timeScale * MediaTimeScale)
  else
    Result := 0;
end;

function TAVMedia.GetMediaState: TMediaState;
begin
  if Assigned(FPlayer) and (FPlayer.status <> AVPlayerStatusFailed) then
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
  if Assigned(FPlayerItem) then
    Result := PointF(FPlayerItem.presentationSize.width, FPlayerItem.presentationSize.height)
  else
    Result := TPointF.Create(0, 0);
end;

function TAVMedia.GetVolume: Single;
begin
{  if Assigned(FPlayer) then
    Result := FPlayer.volume
  else}
    Result := 1.0;
end;

procedure TAVMedia.SeekToBegin;
begin
  FPlayer.seekToTime(CMTimeMake(0, 1));
end;

procedure TAVMedia.SetCurrent(const Value: TMediaTime);
begin
  if Assigned(FPlayer) then
    FPlayer.seekToTime(CMTimeMake(Value, MediaTimeScale));
end;

procedure TAVMedia.SetVolume(const Value: Single);
begin
{  if (FMovie <> nil) then
    FMovie.setVolume(Value);}
end;

procedure TAVMedia.UpdateMediaFromControl;
var
  View: UIView;
  Bounds: TRectF;
  P: TPointF;
  Form: TCommonCustomForm;
begin
  if Assigned(FPlayerLayer) then
  begin
    if (Control <> nil) and not (csDesigning in Control.ComponentState) and (Control.ParentedVisible) and
       (Control.Root <> nil) and  (Control.Root.GetObject is TCommonCustomForm) then
    begin
      Form := TCommonCustomForm(Control.Root.GetObject);
      P := GetVideoSize;
      Bounds := TRectF.Create(0, 0, P.X, P.Y);
      Bounds.Fit(Control.AbsoluteRect);

      if Assigned(FPlayerLayer.superlayer) then
        FPlayerLayer.removeFromSuperlayer;

      View := WindowHandleToPlatform(Form.Handle).View;
      View := TUIView.Wrap(View.superview);
      View.layer.addSublayer(FPlayerLayer);

      FPlayerLayer.setFrame(CGRectFromRect(RectF(Bounds.Left, Bounds.Top, Bounds.Right, Bounds.Bottom)));
      FPlayerLayer.setHidden(False);
      FPlayerLayer.removeAllAnimations;
    end
    else
      FPlayerLayer.setHidden(True);
  end;
end;

procedure TAVMedia.DoStop;
begin
  if Assigned(FPlayer) then
  begin
    FPlayer.pause;
    SeekToBegin;
  end;
end;

procedure TAVMedia.DoPlay;
var
  error: NSError;
  AudioSession: AVAudioSession;
begin
  AudioSession := TAVAudioSession.Wrap(TAVAudioSession.OCClass.sharedInstance);
  AudioSession.setCategory(AVAudioSessionCategoryPlayback, error);
  AudioSession.setActive(True, Error);

  if Assigned(FPlayer) then
  begin
    SeekToBegin;
    FPlayer.play;
  end;
end;

{ TAVMediaCodec }

function TAVMediaCodec.CreateFromFile(const AFileName: string): TMedia;
begin
  Result := TAVMedia.Create(AFileName);
end;

initialization
  TMediaCodecManager.RegisterMediaCodecClass('.mov', SVMOVFiles, TMediaType.Video, TAVMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.m4v', SVM4VFiles, TMediaType.Video, TAVMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.mp4', SVMP4Files, TMediaType.Video, TAVMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.mp3', SVMP3Files, TMediaType.Audio, TAVMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.caf', SVCAFFiles, TMediaType.Audio, TAVMediaCodec);
end.
