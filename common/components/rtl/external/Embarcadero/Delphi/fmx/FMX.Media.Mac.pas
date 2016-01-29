{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Media.Mac;

interface

uses 
  Macapi.ObjectiveC, Macapi.CocoaTypes, Macapi.Foundation, Macapi.Dispatch, Macapi.CoreVideo,
  Macapi.CoreGraphics, Macapi.CoreFoundation, Macapi.AppKit, Macapi.Quicktime, Macapi.QTKit,
  System.Variants, System.Classes, System.SysUtils, System.Math, System.Types, System.UITypes, 
  FMX.Consts, FMX.Types, FMX.Types3D, FMX.Forms, FMX.Media, FMX.Canvas.Mac, FMX.Platform.Mac;

type

{ TQTCaptureDeviceManager }

  TQTCaptureDeviceManager = class(TCaptureDeviceManager)
  private
  protected
  public
    constructor Create; override;
  end;

{ TQTAudioCaptureDevice }

  TQTAudioCaptureDevice = class(TAudioCaptureDevice)
  private
    FDevice: QTCaptureDevice;
    FCaptureSession: QTCaptureSession;
    FCaptureInput: QTCaptureDeviceInput;
    FCaptureOutput: QTCaptureFileOutput;
  protected
    procedure DoStartCapture; override;
    procedure DoStopCapture; override;
    function GetDeviceProperty(const Prop: TCaptureDevice.TProperty): string; override;
    function GetDeviceState: TCaptureDeviceState; override;
    function GetFilterString: string; override;
  public
    constructor Create(const AManager: TCaptureDeviceManager; const ADefault: Boolean; const ADevice: QTCaptureDevice); reintroduce;
  end;

{ TQTVideoCaptureDevice }

  TQTVideoCaptureDevice = class;

  TCaptureDecompressedVideoOutputDelegate = class(TOCLocal, QTCaptureDecompressedVideoOutput_Delegate)
  public
    FDevice: TQTVideoCaptureDevice;
    procedure captureOutput(captureOutput: QTCaptureOutput; didOutputVideoFrame: CVImageBufferRef;
      withSampleBuffer: QTSampleBuffer; fromConnection: QTCaptureConnection); cdecl;
  end;

  TQTVideoCaptureDevice = class(TVideoCaptureDevice)
  private
    FDevice: QTCaptureDevice;
    FCaptureSession: QTCaptureSession;
    FCaptureVideoDeviceInput: QTCaptureDeviceInput;
    FCaptureDecompressedVideoOutput: QTCaptureDecompressedVideoOutput;
    FDelegate: TCaptureDecompressedVideoOutputDelegate;
    FVideoFrame: CVImageBufferRef;
    procedure CallFromDelegate(AVideoFrame: CVImageBufferRef);
    procedure SyncCall;  
  protected 
    procedure DoStartCapture; override;
    procedure DoStopCapture; override;
    procedure DoSampleBufferToBitmap(const ABitmap: TBitmap; const ASetSize: Boolean); override;
    function GetDeviceProperty(const Prop: TCaptureDevice.TProperty): string; override;
    function GetDeviceState: TCaptureDeviceState; override;
  public
    constructor Create(const AManager: TCaptureDeviceManager; const ADefault: Boolean; const ADevice: QTCaptureDevice); reintroduce;
    destructor Destroy; override;
  end;
  
{ TQTMedia }

  TQTMedia = class(TMedia)
  private
    FMovie: QTMovie;
    FMovieView: QTMovieView;
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

{ TQTMediaCodec }

  TQTMediaCodec = class(TCustomMediaCodec)
  public
    function CreateFromFile(const AFileName: string): TMedia; override;
  end;
  
implementation

{ TQTCaptureDeviceManager }

constructor TQTCaptureDeviceManager.Create;
var
  I: Integer;
  DP: Pointer;
  D: QTCaptureDevice;
begin
  inherited;
  for I := 0 to Integer(TQTCaptureDevice.OCClass.inputDevicesWithMediaType(QTMediaTypeSound).count) - 1 do
  begin
    DP := TQTCaptureDevice.OCClass.inputDevicesWithMediaType(QTMediaTypeSound).objectAtIndex(I);
    D := TQTCaptureDevice.Wrap(DP);
    TQTAudioCaptureDevice.Create(Self, TQTCaptureDevice.OCClass.defaultInputDeviceWithMediaType(QTMediaTypeSound) = DP, D);
  end;
  for I := 0 to Integer(TQTCaptureDevice.OCClass.inputDevicesWithMediaType(QTMediaTypeVideo).count) - 1 do
  begin
    DP := TQTCaptureDevice.OCClass.inputDevicesWithMediaType(QTMediaTypeVideo).objectAtIndex(I);
    D := TQTCaptureDevice.Wrap(DP);
    TQTVideoCaptureDevice.Create(Self, TQTCaptureDevice.OCClass.defaultInputDeviceWithMediaType(QTMediaTypeVideo) = DP, D);
  end;
end;

{ TQTAudioCaptureDevice }

constructor TQTAudioCaptureDevice.Create(const AManager: TCaptureDeviceManager; const ADefault: Boolean; const ADevice: QTCaptureDevice);
begin
  inherited Create(AManager, ADefault);
  FDevice := ADevice;
end;

procedure TQTAudioCaptureDevice.DoStartCapture;
var
  URL: NSUrl;
  Error: NSError;
begin
  FDevice.open(Error);
  if Error <> nil then Exit;

  FCaptureSession := TQTCaptureSession.Create;
  FCaptureSession := TQTCaptureSession.Wrap(FCaptureSession.init);

  FCaptureInput := TQTCaptureDeviceInput.Wrap(TQTCaptureDeviceInput.OCClass.deviceInputWithDevice(FDevice));
  FCaptureSession.addInput(FCaptureInput, Error);

  URL := TNSUrl.Wrap(TNSUrl.OCClass.fileURLWithPath(NSStr(FileName)));

  FCaptureOutput := TQTCaptureMovieFileOutput.Create;
  FCaptureOutput := TQTCaptureMovieFileOutput.Wrap(FCaptureOutput.init);

  FCaptureSession.addOutput(FCaptureOutput, Error);
  if Error <> nil then Exit;

  FCaptureSession.startRunning;
  FCaptureOutput.recordToOutputFileURL(URL);
end;

procedure TQTAudioCaptureDevice.DoStopCapture;
begin
  if FCaptureSession <> nil then
  begin
    FCaptureOutput.recordToOutputFileURL(nil);
    FCaptureSession.stopRunning;

    FCaptureInput := nil;
    FCaptureOutput := nil;
    FCaptureSession := nil;

    FDevice.close;
  end;
end;

function TQTAudioCaptureDevice.GetDeviceProperty(const Prop: TCaptureDevice.TProperty): string;
begin
  if FDevice <> nil then
  begin
    case Prop of
      TProperty.Description: Result := '';
      TProperty.Name: Result := UTF8ToString(FDevice.localizedDisplayName.UTF8String);
      TProperty.UniqueID: Result := UTF8ToString(FDevice.uniqueID.UTF8String);
    else
      Result := '';
    end;
  end
  else
    Result := '';
end;

function TQTAudioCaptureDevice.GetDeviceState: TCaptureDeviceState;
begin
  if FCaptureSession <> nil then
    Result := TCaptureDeviceState.Capturing
  else
    Result := TCaptureDeviceState.Stopped;
end;

function TQTAudioCaptureDevice.GetFilterString: string;
begin
  Result := SVWAVFiles + '(*.wav)|*.wav';
end;

{ TCaptureDecompressedVideoOutputDelegate }

procedure TCaptureDecompressedVideoOutputDelegate.captureOutput(captureOutput: QTCaptureOutput; didOutputVideoFrame: CVImageBufferRef;
  withSampleBuffer: QTSampleBuffer; fromConnection: QTCaptureConnection);
begin
  FDevice.CallFromDelegate(didOutputVideoFrame);
end;

{ TQTVideoCaptureDevice }

constructor TQTVideoCaptureDevice.Create(const AManager: TCaptureDeviceManager; const ADefault: Boolean; const ADevice: QTCaptureDevice);
begin
  inherited Create(AManager, ADefault);
  FDevice := ADevice;
end;

destructor TQTVideoCaptureDevice.Destroy;
begin
  inherited;
end;

procedure TQTVideoCaptureDevice.SyncCall;
begin
  SampleBufferReady(0);
end;

procedure TQTVideoCaptureDevice.CallFromDelegate(AVideoFrame: CVImageBufferRef);
begin
  FVideoFrame := AVideoFrame;
  CVBufferRetain(FVideoFrame);
  try
    TThread.Synchronize(TThread.CurrentThread, SyncCall);
  finally
    CVBufferRelease(FVideoFrame);
    FVideoFrame := 0;
  end;
end;

function CGRectFromRect(const R: TRectF): CGRect;
begin
  Result.origin.x := R.Left;
  Result.origin.Y := R.Top;
  Result.size.Width := R.Right - R.Left;
  Result.size.Height := R.Bottom - R.Top;
end;

procedure TQTVideoCaptureDevice.DoSampleBufferToBitmap(const ABitmap: TBitmap; const ASetSize: Boolean);
var
  bytesPerRow, width, height, bufferSize: Integer;
  baseAddress: Pointer;
  dataProvider: CGDataProviderRef;
  cgImage: CGImageRef;
  CtxRef: CGContextRef;
  ColorSpace: CGColorSpaceRef;
  Map: TBitmapData;
begin
  // Lock the base address of the pixel buffer.
  if CVPixelBufferLockBaseAddress(FVideoFrame, 0) = 0 then
  begin
    // Get the number of bytes per row for the pixel buffer.
    bytesPerRow := CVPixelBufferGetBytesPerRow(FVideoFrame);
    // Get the pixel buffer width and height.
    width := CVPixelBufferGetWidth(FVideoFrame);
    height := CVPixelBufferGetHeight(FVideoFrame);
    // Get the base address of the pixel buffer.
    baseAddress := CVPixelBufferGetBaseAddress(FVideoFrame);
    // Get the data size for contiguous planes of the pixel buffer.
    bufferSize := CVPixelBufferGetDataSize(FVideoFrame);
    // Create a Quartz direct-access data provider that uses data we supply.
    dataProvider := CGDataProviderCreateWithData(nil, baseAddress, bufferSize, nil);
    // Create a bitmap image from data supplied by the data provider.
    ColorSpace := CGColorSpaceCreateDeviceRGB;
    cgImage := CGImageCreate(width, height, 8, 32, bytesPerRow,
      ColorSpace, kCGImageAlphaNoneSkipFirst or kCGBitmapByteOrder32Little,
      dataProvider, nil, 1, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    // Resize bitmap if need
    if ASetSize then
      ABitmap.SetSize(Width, Height);
    // Create and return an image object to represent the Quartz image.
    if ABitmap.Map(TMapAccess.maWrite, Map) then
    try
      CtxRef := CGBitmapContextCreate(Map.Data, ABitmap.Width, ABitmap.Height, 8, Map.Pitch,
        ColorSpace, kCGImageAlphaPremultipliedLast);
      CGContextDrawImage(CtxRef, CGRectFromRect(RectF(0, 0, ABitmap.Width, ABitmap.Height)), cgImage);
    finally
      ABitmap.Unmap(Map);
    end;
    CGColorSpaceRelease(ColorSpace);
  end;
end;

procedure TQTVideoCaptureDevice.DoStartCapture;
var
  Error: NSError;
  PixelBufferAttributes: NSDictionary;
begin
  FDevice.open(Error);  
  if Error <> nil then Exit;
  
  FCaptureSession := TQTCaptureSession.Create;
  FCaptureSession := TQTCaptureSession.Wrap(FCaptureSession.init);
 
  FCaptureVideoDeviceInput := TQTCaptureDeviceInput.Wrap(TQTCaptureDeviceInput.OCClass.deviceInputWithDevice(FDevice));
  FCaptureSession.addInput(FCaptureVideoDeviceInput, Error);
  
  FDelegate := TCaptureDecompressedVideoOutputDelegate.Create;
  FDelegate.FDevice := Self;

  FCaptureDecompressedVideoOutput := TQTCaptureDecompressedVideoOutput.Create;
  FCaptureDecompressedVideoOutput := TQTCaptureDecompressedVideoOutput.Wrap(FCaptureDecompressedVideoOutput.init);
  FCaptureDecompressedVideoOutput.setDelegate(ILocalObject(FDelegate).GetObjectID);
  PixelBufferAttributes := TNSDictionary.Wrap(TNSDictionary.OCClass.dictionaryWithObject(TNSNumber.OCClass.numberWithInt(kCVPixelFormatType_32BGRA), Pointer(kCVPixelBufferPixelFormatTypeKey)));
  FCaptureDecompressedVideoOutput.setPixelBufferAttributes(PixelBufferAttributes);

  FCaptureSession.addOutput(FCaptureDecompressedVideoOutput, Error);

  FCaptureSession.startRunning;
end;

procedure TQTVideoCaptureDevice.DoStopCapture;
begin
  if FCaptureSession <> nil then
  begin
    FCaptureSession.stopRunning;

    FCaptureVideoDeviceInput := nil;
    FCaptureDecompressedVideoOutput := nil;
    FCaptureSession := nil;
    FreeAndNil(FDelegate);

    FDevice.close;
  end;
end;

function TQTVideoCaptureDevice.GetDeviceProperty(const Prop: TCaptureDevice.TProperty): string;
begin
  if FDevice <> nil then
  begin
    case Prop of
      TProperty.Description: Result := '';
      TProperty.Name: Result := UTF8ToString(FDevice.localizedDisplayName.UTF8String);
      TProperty.UniqueID: Result := UTF8ToString(FDevice.uniqueID.UTF8String);
    else
      Result := '';
    end;
  end
  else 
    Result := '';
end;

function TQTVideoCaptureDevice.GetDeviceState: TCaptureDeviceState;
begin
  if FCaptureSession <> nil then
    Result := TCaptureDeviceState.Capturing
  else
    Result := TCaptureDeviceState.Stopped;
end;

{ TQTMedia }

constructor TQTMedia.Create(const AFileName: string);
var
  URL: NSUrl;
  Error: NSError;
begin
  inherited Create(AFileName);
  QTMediaTypeSound; // force load framework

  URL := TNSUrl.Wrap(TNSUrl.OCClass.fileURLWithPath(NSStr(FileName)));
  FMovie := TQTMovie.Wrap(TQTMovie.OCClass.movieWithURL(URL, Error));
  FMovieView := TQTMovieView.Create;
  FMovieView := TQTMovieView.Wrap(FMovieView.initWithFrame(MakeNSRect(0, 0, 0, 0)));
  FMovieView.setControllerVisible(False);
  FMovieView.setAutoresizingMask(NSViewMinYMargin);
  FMovieView.setMovie(FMovie);
end;

destructor TQTMedia.Destroy;
begin 
  if FMovieView <> nil then 
    FMovieView.removeFromSuperview;
  if FMovie <> nil then
    FMovie.stop;
  FMovie := nil;
  FMovieView := nil;
  inherited Destroy;
end;

function TQTMedia.GetCurrent: TMediaTime;
begin
  if (FMovie <> nil) then
    Result := Trunc(FMovie.currentTime.timeValue / FMovie.currentTime.timeScale * MediaTimeScale)
  else
    Result := 0;
end;

function TQTMedia.GetDuration: TMediaTime;
begin
  if (FMovie <> nil) then
    Result := Trunc(FMovie.duration.timeValue / FMovie.duration.timeScale * MediaTimeScale)
  else
    Result := 0;
end;

function TQTMedia.GetMediaState: TMediaState;
begin
  if (FMovie <> nil) then
  begin
    if FMovie.Rate > 0 then
      Result := TMediaState.Playing
    else
      Result := TMediaState.Stopped
  end
  else
    Result := TMediaState.Unavailable;
end;

function TQTMedia.GetVideoSize: TPointF;
var
  V: NSValue;
  S: NSSize;
begin
  Result := TPointF.Create(0, 0);
  if (FMovie <> nil) then
  begin
    V := TNSValue.Wrap(FMovie.attributeForKey(QTMovieNaturalSizeAttribute));
    if V <> nil then
    begin
      S := V.sizeValue;
      Result := TPointF.Create(S.width, S.height);
    end;
  end;
end;

function TQTMedia.GetVolume: Single;
begin
  if (FMovie <> nil) then
    Result := FMovie.volume
  else
    Result := 1.0;
end;

procedure TQTMedia.SetCurrent(const Value: TMediaTime);
var
  T: QTTime;
begin
  if (FMovie <> nil) then
  begin
    T.timeValue := Value;
    T.timeScale := MediaTimeScale;
    T.flags := 0;
    FMovie.setCurrentTime(T);
  end;
end;

procedure TQTMedia.SetVolume(const Value: Single);
begin
  if (FMovie <> nil) then
    FMovie.setVolume(Value);
end;

procedure TQTMedia.UpdateMediaFromControl;
var
  View: NSView;
  Bounds: TRectF;
  P: TPointF;
  Form: TCommonCustomForm;
begin
  if FMovieView <> nil then
  begin
    if (Control <> nil) and not (csDesigning in Control.ComponentState) and (Control.ParentedVisible) and
       (Control.Root <> nil) and  (Control.Root.GetObject is TCommonCustomForm) then
    begin
      Form := TCommonCustomForm(Control.Root.GetObject);
      P := GetVideoSize;
      Bounds := TRectF.Create(0, 0, P.X, P.Y);
      Bounds.Fit(Control.AbsoluteRect);
      View := TNSView.Wrap(WindowHandleToPlatform(Form.Handle).Wnd.contentView);
      View.addSubview(FMovieView, NSWindowBelow, nil);
      FMovieView.setFrame(MakeNSRect(Bounds.Left, Form.ClientHeight - Bounds.Bottom, Bounds.Width, Bounds.Height));
      FMovieView.setHidden(False);
    end
    else
      FMovieView.setHidden(True);
  end;
end;

procedure TQTMedia.DoStop;
begin
  if FMovie <> nil then
    FMovie.stop;
end;

procedure TQTMedia.DoPlay;
begin
  if FMovie <> nil then
    FMovie.play;
end;

{ TQTMediaCodec }

function TQTMediaCodec.CreateFromFile(const AFileName: string): TMedia;
begin
  Result := TQTMedia.Create(AFileName);
end;

initialization
  TMediaCodecManager.RegisterMediaCodecClass('.mov', SVMOVFiles, TMediaType.Video, TQTMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.m4v', SVMP4Files, TMediaType.Video, TQTMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.mp4', SVMP4Files, TMediaType.Video, TQTMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.avi', SVAviFiles, TMediaType.Video, TQTMediaCodec);

  TMediaCodecManager.RegisterMediaCodecClass('.wav', SVWAVFiles, TMediaType.Audio, TQTMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.mp3', SVMP3Files, TMediaType.Audio, TQTMediaCodec);
end.

