{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Media;

interface

uses
  System.Classes, System.SysUtils, System.Types, System.Generics.Collections,
  FMX.Types, FMX.Types3D, FMX.Forms, FMX.Consts, FMX.Controls;

const
  MediaTimeScale = 10000000;

type

  ECaptureDeviceException = class(Exception);

  TMediaTime = Int64;

{$SCOPEDENUMS ON}

  TMediaType = (Audio, Video);

{ TCaptureDevice }

  TCaptureDeviceState = (Capturing, Stopped);

  TSampleBufferReadyEvent = procedure (Sender: TObject; const ATime: TMediaTime) of object;

  TCaptureDeviceManager = class;

  TCaptureDevice = class abstract
  public type
    TProperty = (UniqueID, Name, Description);
  private
    FManager: TCaptureDeviceManager;
    FDefault: Boolean;
  protected
    function GetMediaType: TMediaType; virtual; abstract;
    function GetDeviceProperty(const Prop: TProperty): string; virtual;
    function GetDeviceState: TCaptureDeviceState; virtual; abstract;
    procedure DoStartCapture; virtual; abstract;
    procedure DoStopCapture; virtual; abstract;
  public
    constructor Create(const AManager: TCaptureDeviceManager; const ADefault: Boolean); virtual;
    procedure AfterConstruction; override;
    destructor Destroy; override;
    procedure StartCapture;
    procedure StopCapture;
    property Description: string index TProperty.Description read GetDeviceProperty;
    property IsDefault: Boolean read FDefault;
    property MediaType: TMediaType read GetMediaType;
    property Name: string index TProperty.Name read GetDeviceProperty;
    property State: TCaptureDeviceState read GetDeviceState;
    property UniqueID: string index TProperty.UniqueID read GetDeviceProperty;
  end;
  TCaptureDeviceClass = class of TCaptureDevice;

  TAudioCaptureDevice = class(TCaptureDevice)
  private
    procedure SetFileName(const Value: string);
  protected
    FFileName: string;
    function GetMediaType: TMediaType; override;
    function GetFilterString: string; virtual;
  public
    property FilterString: string read GetFilterString;
    property FileName: string read FFileName write SetFileName;
  end;

  TDevicePosition = (dpUnspecified, dpFront, dpBack);

  TFlashMode = (fmAutoFlash, fmFlashOff, fmFlashOn);
  TFocusMode = (fmAutoFocus, fmContinuousAutoFocus, fmLocked);
  TTorchMode = (tmModeOff, tmModeOn, tmModeAuto);

  TVideoCaptureQuality = (vcPhotoQuality, vcHighQuality, vcMediumQuality, vcLowQuality);

  TVideoCaptureDevice = class(TCaptureDevice)
  private
    FOnSampleBufferReady: TSampleBufferReadyEvent;
  protected
    function GetPosition: TDevicePosition; virtual;
    function GetQuality: TVideoCaptureQuality; virtual;
    procedure SetQuality(const Value: TVideoCaptureQuality); virtual;
    function GetHasFlash: Boolean; virtual;
    function GetFlashMode: TFlashMode; virtual;
    procedure SetFlashMode(const Value: TFlashMode); virtual;
    function GetHasTorch: Boolean; virtual;
    function GetTorchMode: TTorchMode; virtual;
    procedure SetTorchMode(const Value: TTorchMode); virtual;
    function GetFocusMode: TFocusMode; virtual;
    procedure SetFocusMode(const Value: TFocusMode); virtual;
    function GetMediaType: TMediaType; override;
    procedure SampleBufferReady(const ATime: TMediaTime);
    procedure DoSampleBufferToBitmap(const ABitmap: TBitmap; const ASetSize: Boolean); virtual; abstract;
  public
    procedure SampleBufferToBitmap(const ABitmap: TBitmap; const ASetSize: Boolean);
    property Position: TDevicePosition read GetPosition;
    property Quality: TVideoCaptureQuality read GetQuality write SetQuality;
    property HasFlash: Boolean read GetHasFlash;
    property HasTorch: Boolean read GetHasTorch;
    property FlashMode: TFlashMode read GetFlashMode write SetFlashMode;
    property FocusMode: TFocusMode read GetFocusMode write SetFocusMode;
    property TorchMode: TTorchMode read GetTorchMode write SetTorchMode;
    property OnSampleBufferReady: TSampleBufferReadyEvent read FOnSampleBufferReady write FOnSampleBufferReady;
  end;

  TCaptureDeviceList = TObjectList<TCaptureDevice>;
  TCaptureDeviceClassList = TList<TCaptureDeviceClass>;

  TCaptureDeviceManager = class abstract
  private class var
    FCustomDevices: TCaptureDeviceClassList;
    FCurrentManager: TCaptureDeviceManager;
    class function InternalGetCaptureDeviceManager: TCaptureDeviceManager; static;
  protected
    procedure AddDevice(const Device: TCaptureDevice);
    procedure RemoveDevice(const Device: TCaptureDevice);
  private
    FDevices: TCaptureDeviceList;
    FDevicesByKind: TCaptureDeviceList;
    function GetCount: Integer; inline;
    function GetDevice(Index: Integer): TCaptureDevice; inline;
    function GetDefaultAudioCaptureDevice: TAudioCaptureDevice;
    function GetDefaultVideoCaptureDevice: TVideoCaptureDevice;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    // Reserved for internal use only - do not call directly!
    class procedure UnInitialize; static;
    // Register a custom capture device class with a file extension, description
    class procedure RegisterCaptureDeviceClass(const CaptureDeviceClass: TCaptureDeviceClass);
    // Create list of available devices
    function GetDevicesByMediaType(MediaType: TMediaType): TCaptureDeviceList;
    function GetDefaultDeviceByMediaType(MediaType: TMediaType): TCaptureDevice;
    function GetDevicesByName(const Name: string): TCaptureDevice;
    // Properties
    property Count: Integer read GetCount;
    property DefaultAudioCaptureDevice: TAudioCaptureDevice read GetDefaultAudioCaptureDevice;
    property DefaultVideoCaptureDevice: TVideoCaptureDevice read GetDefaultVideoCaptureDevice;
    property Devices[Index: Integer]: TCaptureDevice read GetDevice; default;
    // Access to current Manager
    class property Current: TCaptureDeviceManager read InternalGetCaptureDeviceManager;
  end;

{ TCameraComponent }

  TCameraKind = (ckDefault, ckFrontCamera, ckBackCamera);

  TCameraComponent = class(TFmxObject)
  private
    FOnSampleBufferReady: TSampleBufferReadyEvent;
    FCameraKind: TCameraKind;
    FDevice: TVideoCaptureDevice;
    FActive: Boolean;
    function GetDevice: TVideoCaptureDevice;
    procedure SetCameraKind(const Value: TCameraKind);
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
    function GetFlashMode: TFlashMode;
    function GetFocusMode: TFocusMode;
    function GetHasFlash: Boolean;
    function GetHasTorch: Boolean;
    function GetQuality: TVideoCaptureQuality;
    function GetTorchMode: TTorchMode;
    procedure SetFlashMode(const Value: TFlashMode);
    procedure SetFocusMode(const Value: TFocusMode);
    procedure SetQuality(const Value: TVideoCaptureQuality);
    procedure SetTorchMode(const Value: TTorchMode);
  protected
    procedure DoStart;
    procedure DoStop;
    procedure DoSampleBufferReady(Sender: TObject; const ATime: TMediaTime);
    property Device: TVideoCaptureDevice read GetDevice;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SampleBufferToBitmap(const ABitmap: TBitmap; const ASetSize: Boolean);
    property Quality: TVideoCaptureQuality read GetQuality write SetQuality;
    property HasFlash: Boolean read GetHasFlash;
    property HasTorch: Boolean read GetHasTorch;
    property FlashMode: TFlashMode read GetFlashMode write SetFlashMode;
    property FocusMode: TFocusMode read GetFocusMode write SetFocusMode;
    property TorchMode: TTorchMode read GetTorchMode write SetTorchMode;
  published
    property Active: Boolean read GetActive write SetActive default False;
    property Kind: TCameraKind read FCameraKind write SetCameraKind default TCameraKind.ckDefault;
    property OnSampleBufferReady: TSampleBufferReadyEvent read FOnSampleBufferReady write FOnSampleBufferReady;
  end;

{ TMedia }

  EMediaException = class(Exception);

  TMediaState = (Unavailable, Playing, Stopped);

  TMediaPlayerControl = class;

  TMedia = class abstract
  private
    FFileName: string;
    FControl: TMediaPlayerControl;
    procedure SetControl(const Value: TMediaPlayerControl);
  protected
    function GetDuration: TMediaTime; virtual; abstract;
    function GetCurrent: TMediaTime; virtual; abstract;
    procedure SetCurrent(const Value: TMediaTime); virtual; abstract;
    function GetVideoSize: TPointF; virtual; abstract;
    function GetMediaState: TMediaState; virtual; abstract;
    function GetVolume: Single; virtual; abstract;
    procedure SetVolume(const Value: Single); virtual; abstract;
    procedure UpdateMediaFromControl; virtual;
    procedure DoPlay; virtual; abstract;
    procedure DoStop; virtual; abstract;
  public
    constructor Create(const AFileName: string); virtual;
    procedure Play; 
    procedure Stop; 
    property Control: TMediaPlayerControl read FControl write SetControl;
    property FileName: string read FFileName;
    property Duration: TMediaTime read GetDuration;
    property CurrentTime: TMediaTime read GetCurrent write SetCurrent;
    property VideoSize: TPointF read GetVideoSize;
    // Volume values 0..1
    property Volume: Single read GetVolume write SetVolume;
    property State: TMediaState read GetMediaState;
  end;

{ TMediaCodec }

  TCustomMediaCodec = class abstract
  public
    function CreateFromFile(const AFileName: string): TMedia; virtual; abstract;
  end;
  TCustomMediaCodecClass = class of TCustomMediaCodec;

{ TMediaCodecManager }

  EMediaCodecManagerException = class(Exception);

  TMediaCodecManager = class sealed
  public type
    TMediaCodecClassDescriptor = record
      Extension: string;
      Description: string;
      MediaType: TMediaType;
      MediaCodecClass: TCustomMediaCodecClass;
    end;
  strict private type
    TMediaCodecDescriptorField = (Extension, Description);
  strict private
    class var FMediaCodecClassDescriptors: TList<TMediaCodecClassDescriptor>;
    class function FindMediaCodecDescriptor(const Name: string; Field: TMediaCodecDescriptorField): TMediaCodecClassDescriptor;
  private
  public
    // Reserved for internal use only - do not call directly!
    class procedure UnInitialize;
    // Register a Media codec class with a file extension, description 
    class procedure RegisterMediaCodecClass(const Extension, Description: string; MediaType: TMediaType; MediaCodecClass: TCustomMediaCodecClass); overload;
    // Helpful function
    class function GetFileTypes: string;
    class function GetFileTypesByType(MediaType: TMediaType): string;
    class function GetFilterString: string;
    class function GetFilterStringByType(MediaType: TMediaType): string;
    class function IsCodedExists(const AFileName: string): Boolean; overload;
    class function CreateFromFile(const AFileName: string): TMedia;
  end;
  
{ TMediaPlayer }

  TMediaPlayer = class(TFmxObject)
  private
    FMedia: TMedia;
    FFileName: string;
    FControl: TMediaPlayerControl;
    procedure SetControl(const Value: TMediaPlayerControl);
    procedure SetFileName(const Value: string);
    function GetMediaState: TMediaState;
    function GetCurrent: TMediaTime;
    function GetDuration: TMediaTime;
    function GetMedia: TMedia;
    function GetVideoSize: TPointF;
    function GetVolume: Single;
    procedure SetCurrent(const Value: TMediaTime);
    procedure SetVolume(const Value: Single);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;                
    procedure Play; 
    procedure Stop; 
    procedure Clear; 
    property Media: TMedia read GetMedia;
    property Duration: TMediaTime read GetDuration;
    property CurrentTime: TMediaTime read GetCurrent write SetCurrent;
    property VideoSize: TPointF read GetVideoSize;
    property Volume: Single read GetVolume write SetVolume;
    property State: TMediaState read GetMediaState;
  published
    property FileName: string read FFileName write SetFileName;
  end;

{ TMediaPlayerControl }

  TMediaPlayerControl = class(TControl)
  private
    FMediaPlayer: TMediaPlayer;
    procedure SetMediaPlayer(const Value: TMediaPlayer);
    procedure UpdateMedia;
  protected
    procedure Move; override;
    procedure Resize; override;
    procedure Paint; override;
    procedure Show; override;
    procedure Hide; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;                
  published
    property Align;
    property Anchors;
    property Height;
    property Padding;
    property MediaPlayer: TMediaPlayer read FMediaPlayer write SetMediaPlayer;
    property Margins;
    property Position;
    property Visible default True;
    property Width;
  end;

implementation

{$IFDEF MSWINDOWS}
uses FMX.Media.Win,
{$ENDIF}
{$IFDEF MACOS}
{$IFNDEF NEXTGEN}
uses FMX.Media.Mac,
{$ELSE}
//uses FMX.Media.iOS;
{$ENDIF}
{$ENDIF}
{$IFDEF IOS}
uses FMX.Media.iOS,
{$ENDIF}
  System.SysConst;

{ TCaptureDeviceManager }

class procedure TCaptureDeviceManager.UnInitialize;
begin
  FreeAndNil(FCustomDevices);
  FreeAndNil(FCurrentManager);
end; 

class function TCaptureDeviceManager.InternalGetCaptureDeviceManager: TCaptureDeviceManager;
var
  DeviceClass: TCaptureDeviceClass;
begin
  if Not Assigned(FCurrentManager) then
  begin
    {$IFDEF MSWINDOWS}
    FCurrentManager := TWindowsCaptureDeviceManager.Create;
    {$ENDIF}
    {$IFDEF IOS}
    FCurrentManager := TAVCaptureDeviceManager.Create;
    {$ENDIF}
    {$IFDEF MACOS}
    {$IFNDEF NEXTGEN}
    FCurrentManager := TQTCaptureDeviceManager.Create;
    {$ENDIF}
    {$ENDIF}
    if Not Assigned(FCurrentManager) then
      raise ECaptureDeviceException.Create('No CaptureDeviceManager implementation found');
    // Add custom devices
    if Assigned(FCustomDevices) then
      for DeviceClass in FCustomDevices do
        DeviceClass.Create(FCurrentManager, False);
  end;
  Result := FCurrentManager;
end;

constructor TCaptureDeviceManager.Create;
begin
  inherited Create;
  FDevices := TCaptureDeviceList.Create;
  FDevicesByKind := TCaptureDeviceList.Create;
  FDevicesByKind.OwnsObjects := False;
end;

destructor TCaptureDeviceManager.Destroy;
begin
  FreeAndNil(FDevicesByKind);
  FreeAndNil(FDevices);
  inherited;
end;

procedure TCaptureDeviceManager.AddDevice(const Device: TCaptureDevice);
begin
  if Assigned(FDevices) and (FDevices.IndexOf(Device) < 0) then
    FDevices.Add(Device);
end;

class procedure TCaptureDeviceManager.RegisterCaptureDeviceClass(const CaptureDeviceClass: TCaptureDeviceClass);
begin
  if Not Assigned(FCustomDevices) then
    FCustomDevices := TCaptureDeviceClassList.Create;
  FCustomDevices.Add(CaptureDeviceClass);
end;

procedure TCaptureDeviceManager.RemoveDevice(const Device: TCaptureDevice);
begin
  if Assigned(FDevices) and Assigned(Device) and Assigned(Device.FManager) then
  begin
    Device.FManager := nil;
    FDevices.Remove(Device);
  end;
end;

function TCaptureDeviceManager.GetCount: Integer;
begin
  Result := FDevices.Count;
end;

function TCaptureDeviceManager.GetDefaultDeviceByMediaType(MediaType: TMediaType): TCaptureDevice;
var
  I: Integer;
  FirstDevice, Device: TCaptureDevice;
begin
  Result := nil;
  FirstDevice := nil;
  for I := 0 to Count - 1 do
  begin
    Device := Devices[I];
    if (Device.MediaType = MediaType) then
    begin
      if (Device.IsDefault) then
      begin
        Result := Device;
        Break;
      end;
      FirstDevice := Device;
    end;
  end;
  if Not Assigned(Result) then
    Result := FirstDevice;
end;

function TCaptureDeviceManager.GetDefaultAudioCaptureDevice: TAudioCaptureDevice;
var
  LDevice: TCaptureDevice ;
begin
  LDevice := GetDefaultDeviceByMediaType(TMediaType.Audio);
  if Assigned(LDevice) then
    Result := TAudioCaptureDevice(LDevice)
  else 
    Result := nil;
end;

function TCaptureDeviceManager.GetDefaultVideoCaptureDevice: TVideoCaptureDevice;
var
  LDevice: TCaptureDevice;
begin
  LDevice := GetDefaultDeviceByMediaType(TMediaType.Video);
  if Assigned(LDevice) then
    Result := TVideoCaptureDevice(LDevice)
  else 
    Result := nil;
end;

function TCaptureDeviceManager.GetDevice(Index: Integer): TCaptureDevice;
begin
  Result := FDevices[Index];
end;

function TCaptureDeviceManager.GetDevicesByMediaType(MediaType: TMediaType): TCaptureDeviceList;
var
  I: Integer;
  Device: TCaptureDevice;
begin
  FDevicesByKind.Clear;
  for I := 0 to Count - 1 do
  begin
    Device := Devices[I];
    if Device.MediaType = MediaType then
    begin
      FDevicesByKind.Add(Device);
    end;
  end;
  Result := FDevicesByKind;
end; 

function TCaptureDeviceManager.GetDevicesByName(const Name: string): TCaptureDevice;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if SameText(Devices[I].Name, Name, loUserLocale) then
      Result := Devices[I];
end;

{ TCaptureDevice }

constructor TCaptureDevice.Create(const AManager: TCaptureDeviceManager; const ADefault: Boolean);
begin
  inherited Create;
  FManager := AManager;
  FDefault := ADefault;
end;

destructor TCaptureDevice.Destroy;
begin
  StopCapture;
  if Assigned(FManager) then
    FManager.RemoveDevice(Self);
  inherited;
end;

procedure TCaptureDevice.AfterConstruction;
begin
  inherited;
  if Assigned(FManager) then
    FManager.AddDevice(Self);
end;

function TCaptureDevice.GetDeviceProperty(const Prop: TProperty): string;
begin
  Result := '';
end;

procedure TCaptureDevice.StartCapture;
begin
  if State = TCaptureDeviceState.Capturing then
    StopCapture;
  DoStartCapture;
end;

procedure TCaptureDevice.StopCapture;
begin
  DoStopCapture;
end;

{ TAudioCaptureDevice }

function TAudioCaptureDevice.GetFilterString: string;
begin
  Result := '';
end;

function TAudioCaptureDevice.GetMediaType: TMediaType;
begin
  Result := TMediaType.Audio;
end;

procedure TAudioCaptureDevice.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

{ TVideoCaptureDevice }

function TVideoCaptureDevice.GetPosition: TDevicePosition;
begin
  Result := TDevicePosition.dpUnspecified;
end;

function TVideoCaptureDevice.GetFlashMode: TFlashMode;
begin
  Result := TFlashMode.fmFlashOff;
end;

function TVideoCaptureDevice.GetFocusMode: TFocusMode;
begin
  Result := TFocusMode.fmAutoFocus;
end;

function TVideoCaptureDevice.GetHasFlash: Boolean;
begin
  Result := False;
end;

function TVideoCaptureDevice.GetHasTorch: Boolean;
begin
  Result := False;
end;

function TVideoCaptureDevice.GetMediaType: TMediaType;
begin
  Result := TMediaType.Video;
end;

function TVideoCaptureDevice.GetQuality: TVideoCaptureQuality;
begin
  Result := TVideoCaptureQuality.vcHighQuality;
end;

function TVideoCaptureDevice.GetTorchMode: TTorchMode;
begin
  Result := TTorchMode.tmModeOff;
end;

procedure TVideoCaptureDevice.SampleBufferReady(const ATime: TMediaTime);
begin
  if Assigned(FOnSampleBufferReady) then
    FOnSampleBufferReady(Self, ATime);
end;

procedure TVideoCaptureDevice.SampleBufferToBitmap(const ABitmap: TBitmap; const ASetSize: Boolean);
begin
  DoSampleBufferToBitmap(ABitmap, ASetSize);
end;

procedure TVideoCaptureDevice.SetFlashMode(const Value: TFlashMode);
begin
end;

procedure TVideoCaptureDevice.SetFocusMode(const Value: TFocusMode);
begin

end;

procedure TVideoCaptureDevice.SetQuality(const Value: TVideoCaptureQuality);
begin
end;

procedure TVideoCaptureDevice.SetTorchMode(const Value: TTorchMode);
begin

end;

{ TCameraComponent }

constructor TCameraComponent.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TCameraComponent.Destroy;
begin
  if Assigned(FDevice) then
    FDevice.OnSampleBufferReady := nil;
  inherited;
end;

function TCameraComponent.GetDevice: TVideoCaptureDevice;
var
  I: Integer;
  D: TCaptureDevice;
begin
  Result := FDevice;
  if not Assigned(Result) and Assigned(TCaptureDeviceManager.Current) then
  begin
    for I := 0 to TCaptureDeviceManager.Current.Count - 1 do
    begin
      D := TCaptureDeviceManager.Current.Devices[I];
      if (D.GetMediaType = TMediaType.Video) and (D is TVideoCaptureDevice) then
      begin
        if (Kind = TCameraKind.ckFrontCamera) and (TVideoCaptureDevice(D).Position = TDevicePosition.dpFront) then
        begin
          Result := TVideoCaptureDevice(D);
          Break;
        end;
        if (Kind = TCameraKind.ckBackCamera) and (TVideoCaptureDevice(D).Position = TDevicePosition.dpBack) then
        begin
          Result := TVideoCaptureDevice(D);
          Break;
        end;
      end;
    end;
    if not Assigned(Result) then
      Result := TCaptureDeviceManager.Current.DefaultVideoCaptureDevice;
  end;
end;

function TCameraComponent.GetFlashMode: TFlashMode;
begin
  if Assigned(Device) then
    Result := Device.FlashMode
  else
    Result := TFlashMode.fmFlashOff;
end;

function TCameraComponent.GetFocusMode: TFocusMode;
begin
  if Assigned(Device) then
    Result := Device.FocusMode
  else
    Result := TFocusMode.fmAutoFocus;
end;

function TCameraComponent.GetHasFlash: Boolean;
begin
  if Assigned(Device) then
    Result := Device.HasFlash
  else
    Result := False;
end;

function TCameraComponent.GetHasTorch: Boolean;
begin
  if Assigned(Device) then
    Result := Device.HasTorch
  else
    Result := False;
end;

function TCameraComponent.GetQuality: TVideoCaptureQuality;
begin
  if Assigned(Device) then
    Result := Device.GetQuality
  else
    Result := TVideoCaptureQuality.vcPhotoQuality;
end;

function TCameraComponent.GetTorchMode: TTorchMode;
begin
  if Assigned(Device) then
    Result := Device.TorchMode
  else
    Result := TTorchMode.tmModeOff;
end;

procedure TCameraComponent.DoSampleBufferReady(Sender: TObject; const ATime: TMediaTime);
begin
  if Assigned(FOnSampleBufferReady) then
    FOnSampleBufferReady(Self, ATime);
end;

procedure TCameraComponent.DoStart;
begin
  Device.StartCapture;
  if Assigned(FDevice) then
    FDevice.OnSampleBufferReady := DoSampleBufferReady;
end;

procedure TCameraComponent.DoStop;
begin
  Device.StopCapture;
  if Assigned(FDevice) then
    FDevice.OnSampleBufferReady := nil;
end;

function TCameraComponent.GetActive: Boolean;
begin
  if (csDesigning in ComponentState) then
    Result := FActive
  else
    Result := Assigned(TCaptureDeviceManager.Current) and Assigned(FDevice) and FActive;
end;

procedure TCameraComponent.SampleBufferToBitmap(const ABitmap: TBitmap; const ASetSize: Boolean);
begin
  if Active then
    FDevice.SampleBufferToBitmap(ABitmap, ASetSize);
end;

procedure TCameraComponent.SetActive(const Value: Boolean);
begin
  if (FActive <> Value) then
  begin
    FActive := Value;
    if not (csDesigning in ComponentState) and Assigned(TCaptureDeviceManager.Current) then
    begin
      FDevice := GetDevice;
      if Assigned(FDevice) then
      begin
        if FActive then
          DoStart
        else
          DoStop;
      end;
    end;
  end;
end;

procedure TCameraComponent.SetCameraKind(const Value: TCameraKind);
var
  SaveActive: Boolean;
begin
  if FCameraKind <> Value then
  begin
    FDevice := nil;
    SaveActive := Active;
    Active := False;
    FCameraKind := Value;
    Active := SaveActive;
  end;
end;

procedure TCameraComponent.SetFlashMode(const Value: TFlashMode);
begin
  if Assigned(Device) then
  begin
    if Device.HasFlash then
      Device.FlashMode := Value
    else
      raise ECaptureDeviceException.Create(SNoFlashError);
  end;
end;

procedure TCameraComponent.SetFocusMode(const Value: TFocusMode);
begin
  if Assigned(Device) then
    Device.FocusMode := Value;
end;

procedure TCameraComponent.SetQuality(const Value: TVideoCaptureQuality);
begin
  if Assigned(Device) then
    Device.Quality := Value;
end;

procedure TCameraComponent.SetTorchMode(const Value: TTorchMode);
begin
  if Assigned(Device) then
  begin
    if Device.HasTorch then
      Device.TorchMode := Value
    else
      raise ECaptureDeviceException.Create(SNoTorchError);
  end;
end;

{ TMedia }

constructor TMedia.Create(const AFileName: string);
begin
  inherited Create;
  FFileName := AFileName;
end;

procedure TMedia.Play;
begin
  DoPlay;
  if Assigned(FControl) then
    UpdateMediaFromControl;
end;

procedure TMedia.Stop;
begin
  DoStop;
end;

procedure TMedia.SetControl(const Value: TMediaPlayerControl);
begin
  if FControl <> Value then
  begin
    FControl := Value;
    if Assigned(FControl) then
      UpdateMediaFromControl;
  end;
end;

procedure TMedia.UpdateMediaFromControl;
begin
end;

{ TMediaCodecManager }

class procedure TMediaCodecManager.UnInitialize;
begin
  FreeAndNil(FMediaCodecClassDescriptors);
end;

class function TMediaCodecManager.FindMediaCodecDescriptor(const Name: string;
  Field: TMediaCodecDescriptorField): TMediaCodecClassDescriptor;
var
  LResult: Boolean;
  LDescriptor: TMediaCodecClassDescriptor;
begin
  FillChar(Result, SizeOf(Result), 0);
  if Assigned(FMediaCodecClassDescriptors) then
    for LDescriptor in FMediaCodecClassDescriptors do
    begin
      case Field of
        TMediaCodecDescriptorField.Extension: LResult := SameText(Name, LDescriptor.Extension, loUserLocale);
        TMediaCodecDescriptorField.Description: LResult := SameText(Name, LDescriptor.Description, loUserLocale);
      else
        LResult := False;
      end;
      if LResult then
        Result := LDescriptor;
    end;
end;

class procedure TMediaCodecManager.RegisterMediaCodecClass(const Extension, Description: string; MediaType: TMediaType; 
  MediaCodecClass: TCustomMediaCodecClass);
var
  LDescriptor: TMediaCodecClassDescriptor;
begin
  if not Assigned(FMediaCodecClassDescriptors) then
    FMediaCodecClassDescriptors := TList<TMediaCodecClassDescriptor>.Create;

  LDescriptor.Extension := Extension;
  LDescriptor.Description := Description;
  LDescriptor.MediaCodecClass := MediaCodecClass;
  LDescriptor.MediaType := MediaType;
  FMediaCodecClassDescriptors.Add(LDescriptor);
end;

class function TMediaCodecManager.IsCodedExists(const AFileName: string): Boolean;
begin
  Result :=
    FindMediaCodecDescriptor
    (ExtractFileExt(AFileName), TMediaCodecDescriptorField.Extension).MediaCodecClass <> nil;
end;

class function TMediaCodecManager.GetFileTypes: string;
var
  Descriptor: TMediaCodecClassDescriptor;
begin
  Result := '';
  if Assigned(FMediaCodecClassDescriptors) then
    for Descriptor in FMediaCodecClassDescriptors do
      if Result = '' then
        Result := '*' + Descriptor.Extension
      else
        Result := Result + ';' + '*' + Descriptor.Extension;
end;

class function TMediaCodecManager.GetFileTypesByType(MediaType: TMediaType): string;
var
  Descriptor: TMediaCodecClassDescriptor;
begin
  Result := '';
  if Assigned(FMediaCodecClassDescriptors) then
    for Descriptor in FMediaCodecClassDescriptors do
    begin
      if Descriptor.MediaType <> MediaType then Continue;
      if Result = '' then
        Result := '*' + Descriptor.Extension
      else
        Result := Result + ';' + '*' + Descriptor.Extension;
    end;
end;

class function TMediaCodecManager.GetFilterString: string;
var
  Descriptor: TMediaCodecClassDescriptor;
begin
  Result := '';
  if Assigned(FMediaCodecClassDescriptors) then
  begin
    for Descriptor in FMediaCodecClassDescriptors do
      if Result = '' then
        Result := Descriptor.Description + ' (' + '*' + Descriptor.Extension + ')|' + '*' + Descriptor.Extension
      else
        Result := Result + '|' + Descriptor.Description + ' (' + '*' + Descriptor.Extension + ')|' + '*' + Descriptor.Extension;
    // all files
    Result := SVAllFiles + ' (' + GetFileTypes + ')|' + GetFileTypes + '|' + Result;
  end;
end;

class function TMediaCodecManager.GetFilterStringByType(MediaType: TMediaType): string;
var
  Descriptor: TMediaCodecClassDescriptor;
begin
  Result := '';
  if Assigned(FMediaCodecClassDescriptors) then
  begin
    for Descriptor in FMediaCodecClassDescriptors do
    begin
      if Descriptor.MediaType <> MediaType then Continue;
      
      if Result = '' then
        Result := Descriptor.Description + ' (' + '*' + Descriptor.Extension + ')|' + '*' + Descriptor.Extension
      else
        Result := Result + '|' + Descriptor.Description + ' (' + '*' + Descriptor.Extension + ')|' + '*' + Descriptor.Extension;
    end;
    // all files
    Result := SVAllFiles + ' (' + GetFileTypesByType(MediaType) + ')|' + GetFileTypesByType(MediaType) + '|' + Result;
  end;
end;

class function TMediaCodecManager.CreateFromFile(const AFileName: string): TMedia;
var
  CodecClass: TCustomMediaCodecClass;
  Codec: TCustomMediaCodec;
begin
  CodecClass := FindMediaCodecDescriptor(ExtractFileExt(AFileName), TMediaCodecDescriptorField.Extension).MediaCodecClass;
  if Assigned(CodecClass) then
  begin
    Codec := CodecClass.Create;
    try
      Result := Codec.CreateFromFile(AFileName);
    finally
      Codec.Free;
    end;
  end
  else
    Result := nil;
end;

{ TMediaPlayer }

procedure TMediaPlayer.Clear;
begin
  FreeAndNil(FMedia);
  FFileName := '';
end;

constructor TMediaPlayer.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TMediaPlayer.Destroy;
begin
  FreeAndNil(FMedia);
  inherited;
end;

function TMediaPlayer.GetCurrent: TMediaTime;
begin
  if Assigned(FMedia) then
    Result := FMedia.CurrentTime
  else
    Result := 0;
end;

function TMediaPlayer.GetDuration: TMediaTime;
begin
  if Assigned(FMedia) then
    Result := FMedia.Duration
  else
    Result := 0;
end;

function TMediaPlayer.GetMedia: TMedia;
begin
  Result := FMedia;
end;

function TMediaPlayer.GetMediaState: TMediaState;
begin
  if Assigned(FMedia) then
    Result := FMedia.State
  else
    Result := TMediaState.Unavailable;
end;

function TMediaPlayer.GetVideoSize: TPointF;
begin
  if Assigned(FMedia) then
    Result := FMedia.VideoSize
  else
    Result := TPointF.Create(0, 0);
end;

function TMediaPlayer.GetVolume: Single;
begin
  if Assigned(FMedia) then
    Result := FMedia.Volume
  else
    Result := 1.0;
end;

procedure TMediaPlayer.Stop;
begin
  if Assigned(FMedia) then
    FMedia.Stop;
end;

procedure TMediaPlayer.Play;
begin
  if Assigned(FMedia) then
  begin
    FMedia.Play;
  end;
end;

procedure TMediaPlayer.SetControl(const Value: TMediaPlayerControl);
begin
  if FControl <> Value then
  begin
    FControl := Value;
    if Assigned(FMedia) then
    begin
      FMedia.Control := FControl;
      FMedia.UpdateMediaFromControl;
    end;
  end;
end;

procedure TMediaPlayer.SetCurrent(const Value: TMediaTime);
begin
  if Assigned(FMedia) then
    FMedia.CurrentTime := Value
end;

procedure TMediaPlayer.SetFileName(const Value: string);
begin
  if csDesigning in ComponentState then
  begin
    if FFileName <> Value then
      FFileName := Value;
  end
  else
  begin
    // We shall recreate media object as the file content could change.
    // For example if we make recording in the same file
    if Assigned(FMedia) then
      FMedia.DisposeOf;
    FFileName := Value;
    if FileExists(FFileName) then
    begin
      FMedia := TMediaCodecManager.CreateFromFile(FFileName);
      if Assigned(FMedia) then
        FMedia.Control := FControl;
    end
    else
      raise ECaptureDeviceException.Create(SFileNotFound);
  end;
end;

procedure TMediaPlayer.SetVolume(const Value: Single);
begin
  if Assigned(FMedia) then
    FMedia.Volume := Value;
end;

{ TMediaPlayerControl }

constructor TMediaPlayerControl.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TMediaPlayerControl.Destroy;
begin
  if Assigned(FMediaPlayer) then
    FMediaPlayer.SetControl(nil);
  inherited;
end;

procedure TMediaPlayerControl.UpdateMedia;
begin
  if Assigned(FMediaPlayer) and Assigned(FMediaPlayer.FMedia) then
    FMediaPlayer.FMedia.UpdateMediaFromControl;
end;

procedure TMediaPlayerControl.Hide;
begin
  inherited;
  UpdateMedia;
end;

procedure TMediaPlayerControl.Paint;
var
  R: TRectF;
begin
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.Stroke.Thickness := 1;
    Canvas.Stroke.Dash := TStrokeDash.sdDash;
    Canvas.Stroke.Kind := TBrushKind.bkSolid;
    Canvas.Stroke.Color := $A0909090;
    Canvas.DrawRect(R, 0, 0, AllCorners, AbsoluteOpacity);
    Canvas.Stroke.Dash := TStrokeDash.sdSolid;
  end;
end;

procedure TMediaPlayerControl.Move;
begin
  inherited;
  UpdateMedia;
end;

procedure TMediaPlayerControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FMediaPlayer) then
    MediaPlayer := nil;
end;

procedure TMediaPlayerControl.Resize;
begin
  inherited;
  UpdateMedia;
end;

procedure TMediaPlayerControl.SetMediaPlayer(const Value: TMediaPlayer);
begin
  if FMediaPlayer <> Value then
  begin
    if Assigned(FMediaPlayer) then
      FMediaPlayer.SetControl(nil);
    FMediaPlayer := Value;
    if Assigned(FMediaPlayer) then
      FMediaPlayer.SetControl(Self);
  end;
end;

procedure TMediaPlayerControl.Show;
begin
  inherited ;
  UpdateMedia;
end;

initialization
  RegisterFmxClasses([TCameraComponent, TMediaPlayer, TMediaPlayerControl]);
finalization
  TCaptureDeviceManager.UnInitialize;
  TMediaCodecManager.UnInitialize
end.
