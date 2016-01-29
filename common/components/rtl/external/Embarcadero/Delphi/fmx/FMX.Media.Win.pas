{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Media.Win;

interface

uses Winapi.Windows, Winapi.DirectShow9, Winapi.Direct3D9, Winapi.ActiveX,
  System.Win.ComObj, System.Variants, System.Classes, System.SysUtils, System.Math, FMX.Consts,
  System.Types, FMX.Context.DX9, FMX.Types, FMX.Types3D, FMX.Forms, FMX.Media, FMX.Platform.Win;

type

{ TWindowsCaptureDeviceManager }

  TWindowsCaptureDeviceManager = class(TCaptureDeviceManager)
  private
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

{ TWindowsCaptureDevice }

  TWindowsAudioCaptureDevice = class(TAudioCaptureDevice)
  private
    FMoniker: IMoniker;
    FBaseFilter: IBaseFilter;
    FGraphBuilder: IGraphBuilder;
    FCaptureGraphBuilder: ICaptureGraphBuilder2;
    FMediaControl: IMediaControl;
  protected
    procedure DoStartCapture; override;
    procedure DoStopCapture; override;
    function GetDeviceProperty(const Prop: TCaptureDevice.TProperty): string; override;
    function GetDeviceState: TCaptureDeviceState; override;
    function GetFilterString: string; override;
  public
    constructor Create(AManager: TCaptureDeviceManager; const AMoniker: IMoniker; const ADefault: Boolean); reintroduce;
    destructor Destroy; override;
  end;
  
{ TVMRRenderer }

  TVMRRenderer = class(TInterfacedPersistent, IVMRSurfaceAllocator9, IVMRImagePresenter9)
  private
    FVideoTexture: IDirect3DTexture9; // must be RenderTarget to allow GPU copy
    FSysMemSurface: IDirect3DSurface9;
    FSurface: IDirect3DSurface9;
    FSurfaceAllocatorNotify: IVMRSurfaceAllocatorNotify9;
    FBaseFilter: IBaseFilter;
    FVMRFilterConfig: IVMRFilterConfig9;
    FSampleBufferReady: TSampleBufferReadyEvent;
    FVMRLock: TRTLCriticalSection;
    FBitmap: TBitmap;
    FRunning: Boolean;
    { IVMRSurfaceAllocator9 }
    function InitializeDevice(dwUserID: DWORD; lpAllocInfo: PVMR9AllocationInfo;
      var lpNumBuffers: DWORD): HResult; stdcall;
    function TerminateDevice(dwID: DWORD): HResult; stdcall;
    function GetSurface(dwUserID: DWORD; SurfaceIndex: DWORD; SurfaceFlags: DWORD;
      out lplpSurface: IDirect3DSurface9): HResult; stdcall;
    function AdviseNotify(lpIVMRSurfAllocNotify: IVMRSurfaceAllocatorNotify9): HResult; stdcall;
    { IVMRImagePresenter9 }
    function StartPresenting(dwUserID: DWORD): HResult; stdcall;
    function StopPresenting(dwUserID: DWORD): HResult; stdcall;
    function PresentImage(dwUserID: DWORD; lpPresInfo: PVMR9PresentationInfo): HResult; stdcall;
    { }
    function AddToGraph(const FGraphBuilder: IGraphBuilder): Boolean;
    procedure SampleBufferToBitmap(const ABitmap: TBitmap; const ASetSize: Boolean);
    { sync }
    procedure Sync;
  public
    constructor Create;
    destructor Destroy; override;
  end;
  
{ TWindowsCaptureDevice }

  TWindowsVideoCaptureDevice = class(TVideoCaptureDevice)
  private
    FMoniker: IMoniker;
    FBaseFilter: IBaseFilter;
    FGraphBuilder: IGraphBuilder;
    FCaptureGraphBuilder: ICaptureGraphBuilder2;
    FMediaControl: IMediaControl;
    FVMRRenderer: TVMRRenderer;
    procedure VMRRendererSampleReady(Sender: TObject; const ATime: TMediaTime);
  protected
    procedure DoStartCapture; override;
    procedure DoStopCapture; override;
    procedure DoSampleBufferToBitmap(const ABitmap: TBitmap; const ASetSize: Boolean); override;
    function GetDeviceProperty(const Prop: TCaptureDevice.TProperty): string; override;
    function GetDeviceState: TCaptureDeviceState; override;
  public
    constructor Create(AManager: TCaptureDeviceManager; const AMoniker: IMoniker; const ADefault: Boolean); reintroduce;
    destructor Destroy; override;
  end;

{ TWindowsMedia }

  TWindowsMedia = class(TMedia)
  private
    FGraphBuilder: IGraphBuilder;
    FMediaControl: IMediaControl;
    FMediaSeeking: IMediaSeeking;
    FBasicAudio: IBasicAudio;
    FVMRRenderer: TVMRRenderer;
    FVMR: IBaseFilter;
    FVMRFilterConfig: IVMRFilterConfig9;
    FVMRWindowlessControl: IVMRWindowlessControl9;
    FWnd: HWND;
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
 
  TWindowsMediaCodec = class(TCustomMediaCodec)
  public
    function CreateFromFile(const AFileName: string): TMedia; override;
  end;
  
implementation

uses
  System.SysConst;

{ TWindowsCaptureDeviceManager }

constructor TWindowsCaptureDeviceManager.Create;
var
  Moniker: IMoniker;
  DevEnum: ICreateDevEnum;
  Enum: IEnumMoniker;
  Default: Boolean;
begin
  inherited;
  CoCreateInstance(CLSID_SystemDeviceEnum, nil, CLSCTX_INPROC_SERVER,
    IID_ICreateDevEnum, DevEnum);
  if DevEnum <> nil then
  begin
    // audio devices
    Default := True;
    DevEnum.CreateClassEnumerator(CLSID_AudioInputDeviceCategory, Enum, 0);
    if Enum <> nil then
      while (Enum.Next(1, Moniker, nil) = S_OK) do
      begin
        TWindowsAudioCaptureDevice.Create(Self, Moniker, Default);
        Default := False;
      end;
    Enum := nil;
    // video devices
    Default := True;
    DevEnum.CreateClassEnumerator(CLSID_VideoInputDeviceCategory, Enum, 0);
    if Enum <> nil then
      while (Enum.Next(1, Moniker, nil) = S_OK) do
      begin
        TWindowsVideoCaptureDevice.Create(Self, Moniker, Default);
        Default := False;
      end;
  end;
end;

destructor TWindowsCaptureDeviceManager.Destroy;
begin
  inherited;
end;

{ TWindowsAudioCaptureDevice }

constructor TWindowsAudioCaptureDevice.Create(AManager: TCaptureDeviceManager;
  const AMoniker: IMoniker; const ADefault: Boolean);
begin
  inherited Create(AManager, ADefault);
  FMoniker := AMoniker;
  if FMoniker <> nil then
    FMoniker.BindToObject(nil, nil, IID_IBaseFilter, FBaseFilter);
end;

destructor TWindowsAudioCaptureDevice.Destroy;
begin
  inherited;
end;

procedure TWindowsAudioCaptureDevice.DoStartCapture;
var
  HR: HResult;
  ppf: IBaseFilter;
  sink: IFileSinkfilter;
begin
  // Create GraphBuilder
  HR := CoCreateInstance(CLSID_CaptureGraphBuilder2, nil, CLSCTX_INPROC_SERVER, 
    IID_ICaptureGraphBuilder2, FCaptureGraphBuilder);
  if Succeeded(HR) then
  begin
    HR := CoCreateInstance(CLSID_FilterGraph, nil, CLSCTX_INPROC_SERVER, IID_IGraphBuilder, FGraphBuilder);
    if Succeeded(HR) then
    begin
      FCaptureGraphBuilder.SetFiltergraph(FGraphBuilder);
      // Get IMediaControl
      FGraphBuilder.QueryInterface(IID_IMediaControl, FMediaControl);
      if FBaseFilter <> nil then
      begin
        HR := FGraphBuilder.AddFilter(FBaseFilter, 'Capture Filter');
        if Succeeded(HR) then
        begin
          HR := FCaptureGraphBuilder.SetOutputFileName(MEDIASUBTYPE_AVI, PChar(FFileName), ppf, sink);
          if Succeeded(HR) then
          begin
            HR := FCaptureGraphBuilder.RenderStream(@PIN_CATEGORY_CAPTURE, @MEDIATYPE_Audio, FBaseFilter, nil, ppf);
            if Succeeded(HR) then
            begin
              if FMediaControl <> nil then
              begin
                FMediaControl.Run;
                Exit; // success
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  FCaptureGraphBuilder := nil;
  FGraphBuilder := nil;
  FMediaControl := nil;
end;

procedure TWindowsAudioCaptureDevice.DoStopCapture;
begin
  if FMediaControl <> nil then
  begin
    FMediaControl.Stop;
    FCaptureGraphBuilder := nil;
    FGraphBuilder := nil;
    FMediaControl := nil;
  end;
end;

function TWindowsAudioCaptureDevice.GetDeviceProperty(const Prop: TCaptureDevice.TProperty): string;
var
  PropBag: IPropertyBag;
  V: OleVariant;
begin
  FMoniker.BindToStorage(nil, nil, IPropertyBag, PropBag);
  if PropBag <> nil then
  begin
    case Prop of
      TProperty.Description: 
        begin
          PropBag.Read('Description', V, nil);
          Result := V;
        end;
      TProperty.Name:
        begin
          PropBag.Read('FriendlyName', V, nil);
          Result := V;
        end;
      TProperty.UniqueID:
        begin
          PropBag.Read('WaveInID', V, nil);
          Result := V;
        end;
    else
      Result := '';
    end;
  end
  else
    Result := '';
end;

function TWindowsAudioCaptureDevice.GetDeviceState: TCaptureDeviceState;
begin
  if FMediaControl <> nil then
    Result := TCaptureDeviceState.Capturing
  else
    Result := TCaptureDeviceState.Stopped;
end;

function TWindowsAudioCaptureDevice.GetFilterString: string;
begin
  Result := SVWAVFiles + '(*.wav)|*.wav';
end;

{ TVMRRenderer }

constructor TVMRRenderer.Create;
begin
  inherited Create;
  InitializeCriticalSection(FVMRLock);
end;

destructor TVMRRenderer.Destroy;
begin
  EnterCriticalSection(FVMRLock);
  FVideoTexture := nil;
  FSysMemSurface := nil;
  FSurfaceAllocatorNotify := nil;
  FBaseFilter := nil;
  FVMRFilterConfig := nil;
  LeaveCriticalSection(FVMRLock);
  DeleteCriticalSection(FVMRLock);
  inherited;
end;

function TVMRRenderer.AddToGraph(const FGraphBuilder: IGraphBuilder): Boolean;
var
  HR: HResult;
begin
  // Create VMR
  Result := True;
  HR := CoCreateInstance(CLSID_VideoMixingRenderer9, nil, CLSCTX_INPROC, IID_IBaseFilter, FBaseFilter);
  if Succeeded(HR) then
  begin
    FBaseFilter.QueryInterface(IVMRFilterConfig9, FVMRFilterConfig);
    HR := FVMRFilterConfig.SetRenderingMode(VMR9Mode_Renderless);
    if Succeeded(HR) then
    begin
      FBaseFilter.QueryInterface(IVMRSurfaceAllocatorNotify9, FSurfaceAllocatorNotify);
      HR := FSurfaceAllocatorNotify.AdviseSurfaceAllocator(Cardinal(Self), Self);
      if Succeeded(HR) then
      begin
        IVMRSurfaceAllocator9(Self).AdviseNotify(FSurfaceAllocatorNotify);
        HR := FGraphBuilder.AddFilter(FBaseFilter, 'Video Mixing Renderer9');
        if Succeeded(HR) then
          Exit; // Success
      end;
    end;
  end;
  Result := False;
  FVMRFilterConfig := nil;
  FBaseFilter := nil;
end;

{ IVMRSurfaceAllocator9 }

function TVMRRenderer.GetSurface(dwUserID, SurfaceIndex, SurfaceFlags: DWORD;
  out lplpSurface: IDirect3DSurface9): HResult;
begin
  if FSurface <> nil then
  begin
    lplpSurface := FSurface;
    Result := S_OK;
  end
  else
    Result := E_FAIL;
end;

function TVMRRenderer.InitializeDevice(dwUserID: DWORD; lpAllocInfo: PVMR9AllocationInfo; var lpNumBuffers: DWORD): HResult;
begin
  Result := E_NOTIMPL;
  if Assigned(TCustomDX9Context.SharedDevice) then
    Result := FSurfaceAllocatorNotify.AllocateSurfaceHelper(lpAllocInfo, lpNumBuffers, FSurface);
end;

function TVMRRenderer.TerminateDevice(dwID: DWORD): HResult;
begin
  FVideoTexture := nil;
  FSysMemSurface := nil;
  FSurface := nil;
  Result := S_OK;
end;

function TVMRRenderer.AdviseNotify(lpIVMRSurfAllocNotify: IVMRSurfaceAllocatorNotify9): HResult;
begin
  Result := E_NOTIMPL;
  if Assigned(TCustomDX9Context.SharedDevice) then
    Result := lpIVMRSurfAllocNotify.SetD3DDevice(TCustomDX9Context.SharedDevice, TCustomDX9Context.Direct3D9Obj.GetAdapterMonitor(D3DADAPTER_DEFAULT));
end;

{ IVMRImagePresenter9 }

function TVMRRenderer.StartPresenting(dwUserID: DWORD): HResult;
begin
  Result := S_OK;
  FRunning := True;
end;

function TVMRRenderer.StopPresenting(dwUserID: DWORD): HResult;
begin
  FRunning := False;
  Result := S_OK;
end;

function TVMRRenderer.PresentImage(dwUserID: DWORD; lpPresInfo: PVMR9PresentationInfo): HResult;
begin
  Result := S_OK;
  if not FRunning then
    Exit;
  EnterCriticalSection(FVMRLock);
  if Assigned(FSampleBufferReady) then
    FSampleBufferReady(Self, lpPresInfo.rtStart);
  LeaveCriticalSection(FVMRLock);
end;

procedure TVMRRenderer.SampleBufferToBitmap(const ABitmap: TBitmap; const ASetSize: Boolean);
var
  Res: HResult;
  R: TRect;
  VideoSurface: IDirect3DSurface9;
  Lock: TD3DLockedRect;
  Device: IDirect3DDevice9;
  Desc: TD3DSurfaceDesc;
  Map: TBitmapData;
  I: Integer;
begin
  Device := TCustomDX9Context.SharedDevice;
  { Resize bitmap if need }
  if ASetSize then
  begin
    FSurface.GetDesc(Desc);
    ABitmap.SetSize(Desc.Width, Desc.Height);
  end
  else
  begin
    if ABitmap.IsEmpty then Exit;
  end;
  { Resize surfaces if need }
  if FVideoTexture <> nil then
  begin
    FVideoTexture.GetLevelDesc(0, Desc);
    if (CompareValue(Desc.Width, ABitmap.Width) = EqualsValue)
    or (CompareValue(Desc.Height, ABitmap.Height) = EqualsValue) then
    begin
      FVideoTexture := nil;
      FSysMemSurface := nil;
      Device.CreateTexture(ABitmap.Width, ABitmap.Height, 1, D3DUSAGE_RENDERTARGET, D3DFMT_A8R8G8B8, D3DPOOL_DEFAULT, FVideoTexture, nil);
      Device.CreateOffscreenPlainSurface(ABitmap.Width, ABitmap.Height, D3DFMT_A8R8G8B8, D3DPOOL_SYSTEMMEM, FSysMemSurface, nil);
    end;
  end
  else
  begin
    FVideoTexture := nil;
    FSysMemSurface := nil;
    Device.CreateTexture(ABitmap.Width, ABitmap.Height, 1, D3DUSAGE_RENDERTARGET, D3DFMT_A8R8G8B8, D3DPOOL_DEFAULT, FVideoTexture, nil);
    Device.CreateOffscreenPlainSurface(ABitmap.Width, ABitmap.Height, D3DFMT_A8R8G8B8, D3DPOOL_SYSTEMMEM, FSysMemSurface, nil);
  end;
  { GPU copy and convertion from Video Foramt (UV) to RGBA }
  FVideoTexture.GetSurfaceLevel(0, VideoSurface);
  R := Rect(0, 0, ABitmap.Width, ABitmap.Height);
  Device.StretchRect(FSurface, nil, VideoSurface, @R, D3DTEXF_LINEAR);
  { Copy from GPU }
  Res := Device.GetRenderTargetData(VideoSurface, FSysMemSurface);
  { Copy to sys memory }
  if Res = S_OK then
  begin
    if Succeeded(FSysMemSurface.LockRect(Lock, nil, D3DLOCK_READONLY)) then
    begin
      try
        if ABitmap.Map(TMapAccess.maWrite, Map) then
        begin
          if Lock.Pitch = Map.Pitch then
            Move(Lock.pBits^, Map.Data^, Map.Pitch * ABitmap.Height)
          else
            for I := 0 to ABitmap.Height - 1 do
              Move(PAlphaColorArray(Lock.pBits)[Cardinal(I * (Lock.Pitch div 4))], PAlphaColorArray(Map.Data)[I * (Map.Pitch div 4)], Min(Lock.Pitch, Map.Pitch));
          ABitmap.Unmap(Map);
        end;
      finally
        FSysMemSurface.UnlockRect;
      end;
      { Update handles }
      FBitmap := ABitmap;
      TThread.Synchronize(nil, Sync);
    end;
  end; 
end;

procedure TVMRRenderer.Sync;
begin
end;

{ TWindowsVideoCaptureDevice }

constructor TWindowsVideoCaptureDevice.Create(AManager: TCaptureDeviceManager;
  const AMoniker: IMoniker; const ADefault: Boolean);
begin
  inherited Create(AManager, ADefault);
  FMoniker := AMoniker;
  if FMoniker <> nil then
  begin
    FMoniker.BindToObject(nil, nil, IID_IBaseFilter, FBaseFilter);
  end;
end;

destructor TWindowsVideoCaptureDevice.Destroy;
begin
  inherited;
end;

procedure TWindowsVideoCaptureDevice.DoStartCapture;
var
  HR: HResult;
begin
  // Create GraphBuilder
  HR := CoCreateInstance(CLSID_CaptureGraphBuilder2, nil, CLSCTX_INPROC_SERVER, 
    IID_ICaptureGraphBuilder2, FCaptureGraphBuilder);
  if Succeeded(HR) then
  begin
    HR := CoCreateInstance(CLSID_FilterGraph, nil, CLSCTX_INPROC_SERVER, IID_IFilterGraph2, FGraphBuilder);
    if Succeeded(HR) then
    begin
      FCaptureGraphBuilder.SetFiltergraph(FGraphBuilder);
      // Get IMediaControl
      FGraphBuilder.QueryInterface(IID_IMediaControl, FMediaControl);
      if FBaseFilter <> nil then
      begin
        // Set Capture
        HR := FGraphBuilder.AddFilter(FBaseFilter, 'Capture');
        if Succeeded(HR) then
        begin
          // Create VMR
          FVMRRenderer := TVMRRenderer.Create;
          FVMRRenderer.FSampleBufferReady := VMRRendererSampleReady;
          FVMRRenderer.AddToGraph(FGraphBuilder);
          // Start
          HR := FCaptureGraphBuilder.RenderStream(@PIN_CATEGORY_CAPTURE, @MEDIATYPE_Video, FBaseFilter, nil, FVMRRenderer.FBaseFilter); 
          if Succeeded(HR) then
          begin
            if FMediaControl <> nil then
            begin
              FMediaControl.Run;
              Exit; // Success
            end;
          end;
        end;
      end;
    end;
  end;
  FMediaControl := nil;
  FCaptureGraphBuilder := nil;
  FGraphBuilder := nil;
  FreeAndNil(FVMRRenderer);
end;

procedure TWindowsVideoCaptureDevice.DoStopCapture;
begin
  if (FMediaControl <> nil) then
  begin
    FMediaControl.Stop;
    FMediaControl := nil;
    FCaptureGraphBuilder := nil;
    FGraphBuilder := nil;
    FreeAndNil(FVMRRenderer);
  end;
end;

procedure TWindowsVideoCaptureDevice.DoSampleBufferToBitmap(const ABitmap: TBitmap; const ASetSize: Boolean);
begin
  FVMRRenderer.SampleBufferToBitmap(ABitmap, ASetSize);
end;

function TWindowsVideoCaptureDevice.GetDeviceProperty(const Prop: TCaptureDevice.TProperty): string;
var
  PropBag: IPropertyBag;
  HR: HRESULT;
  V: OleVariant;
begin
  HR := FMoniker.BindToStorage(nil, nil, IPropertyBag, PropBag);
  if Succeeded(HR) then
  begin
    case Prop of
      TProperty.Description: 
        begin
          PropBag.Read('Description', V, nil);
          Result := V;
        end;
      TProperty.Name:
        begin
          PropBag.Read('FriendlyName', V, nil);
          Result := V;
        end;
      TProperty.UniqueID:
        begin
          PropBag.Read('DevicePath', V, nil);
          Result := V;
        end;
    else
      Result := '';
    end;
  end
  else
    Result := '';
end;

function TWindowsVideoCaptureDevice.GetDeviceState: TCaptureDeviceState;
begin
  if FMediaControl <> nil then
    Result := TCaptureDeviceState.Capturing
  else
    Result := TCaptureDeviceState.Stopped;
end;

procedure TWindowsVideoCaptureDevice.VMRRendererSampleReady(Sender: TObject;
  const ATime: TMediaTime);
begin
  SampleBufferReady(ATime);
end;

{ TWindowsMedia }

constructor TWindowsMedia.Create(const AFileName: string);
var
  R: TRect;
  HR: HResult;
  WindowClass: TWndClass;
begin
  if not FileExists(AFileName) then
    raise EMediaException.Create(SFileNotFound);
  inherited;
  if not GetClassInfo(hInstance, PChar('VMRWindow'), WindowClass) then
  begin
    FillChar(WindowClass, SizeOf(WindowClass), 0);
    WindowClass.Style := CS_HREDRAW or CS_VREDRAW;
    WindowClass.lpfnWndProc := @DefWindowProc;
    WindowClass.cbClsExtra := 0;
    WindowClass.cbWndExtra := 0;
    WindowClass.hInstance := hInstance;
    WindowClass.hCursor := LoadCursorW(0, PChar(IDC_ARROW));
    WindowClass.hbrBackground := GetStockObject(NULL_BRUSH);
    WindowClass.lpszMenuName := nil;
    WindowClass.lpszClassName := PChar('VMRWindow');
    if Winapi.Windows.RegisterClass(WindowClass) = 0 then
      RaiseLastOSError;
  end;
  FWnd := CreateWindowEx(0, WindowClass.lpszClassName, nil, WS_CHILDWINDOW,
    0, 0, 0, 0, GetDesktopWindow, 0, hInstance, nil);
  ShowWindow(FWnd, SW_HIDE);
  // Create GraphBuilder
  HR := CoCreateInstance(CLSID_FilterGraph, nil, CLSCTX_INPROC_SERVER, IID_IGraphBuilder, FGraphBuilder);
  if Succeeded(HR) then
  begin
    // Get IMediaControl
    HR := FGraphBuilder.QueryInterface(IID_IMediaControl, FMediaControl);
    if Succeeded(HR) then
    begin
      HR := CoCreateInstance(CLSID_VideoMixingRenderer9, nil, CLSCTX_INPROC, IID_IBaseFilter, FVMR);
      if Succeeded(HR) then
      begin
        HR := FVMR.QueryInterface(IVMRFilterConfig9, FVMRFilterConfig);
        if Succeeded(HR) then
        begin
          HR := FGraphBuilder.AddFilter(FVMR, 'Video Mixing Renderer9');
          if Succeeded(HR) then
          begin
            HR := FVMRFilterConfig.SetRenderingMode(VMR9Mode_Windowless);
            if Succeeded(HR) then
            begin
              HR := FVMR.QueryInterface(IVMRWindowlessControl9, FVMRWindowlessControl);
              if Succeeded(HR) then
              begin
                FVMRWindowlessControl.SetVideoClippingWindow(FWnd);
                GetClientRect(FWnd, R);
                FVMRWindowlessControl.SetVideoPosition(nil, @R);
              end;
              // Create GraphTree
              HR := FGraphBuilder.RenderFile(PChar(AFileName), nil);
              if Succeeded(HR) then
              begin
                if FMediaControl <> nil then
                  FMediaControl.StopWhenReady;
                // Get IMediaSeeking
                FGraphBuilder.QueryInterface(IID_IMediaSeeking, FMediaSeeking);
                // Get IBaseAudio
                FGraphBuilder.QueryInterface(IID_IBasicAudio, FBasicAudio);
                Exit; // Success
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  DestroyWindow(FWnd);
  FGraphBuilder := nil;
  FMediaControl := nil;
  FreeAndNil(FVMRRenderer);
  raise EMediaException.CreateFmt(SMediaFileNotSupported, [ExtractFileName(AFileName)]);
end;

destructor TWindowsMedia.Destroy;
begin
  DestroyWindow(FWnd);
  if (FMediaControl <> nil) then
    FMediaControl.Stop;
  FGraphBuilder := nil;
  FMediaControl := nil;
  FreeAndNil(FVMRRenderer);
  inherited Destroy;
end;

procedure TWindowsMedia.DoPlay;
begin
  if (FMediaControl <> nil) then
    FMediaControl.Run;
end;

procedure TWindowsMedia.DoStop;
begin
  if (FMediaControl <> nil) then
    FMediaControl.Stop;
end;

procedure TWindowsMedia.UpdateMediaFromControl;
var
  P: TPointF;
  R: TRect;
  Bounds: TRectF;
  Form: TCommonCustomForm;
begin
  if FWnd <> 0 then
  begin
    if (Control <> nil) and not (csDesigning in Control.ComponentState) and (Control.ParentedVisible) and
       (Control.Root <> nil) and  (Control.Root.GetObject is TCommonCustomForm) then
    begin
      Form := TCommonCustomForm(Control.Root.GetObject);
      P := GetVideoSize;
      Bounds := TRectF.Create(0, 0, P.X, P.Y);
      Bounds.Fit(RectF(0, 0, Control.AbsoluteWidth, Control.AbsoluteHeight));
      Bounds.Offset(Control.AbsoluteRect.Left, Control.AbsoluteRect.Top);
      SetParent(FWnd, WindowHandleToPlatform(Form.Handle).Wnd);
      SetWindowPos(FWnd, 0, Bounds.Round.Left, Bounds.Round.Top, Bounds.Round.Width, Bounds.Round.Height, 0);
      R.Create(0, 0, Bounds.Round.Width, Bounds.Round.Height);
      if FVMRWindowlessControl <> nil then
        FVMRWindowlessControl.SetVideoPosition(nil, @R);
      ShowWindow(FWnd, SW_SHOW)
    end
    else
      ShowWindow(FWnd, SW_HIDE)
  end;
end;

function TWindowsMedia.GetDuration: TMediaTime;
var
  T: int64;
begin
  if (FMediaSeeking <> nil) then
  begin
    FMediaSeeking.GetDuration(T);
    Result := T;
  end
  else
    Result := 0;
end;

function TWindowsMedia.GetCurrent: TMediaTime;
var
  T: int64;
begin
  if (FMediaSeeking <> nil) then
  begin
    FMediaSeeking.GetCurrentPosition(T);
    Result := T;
  end
  else
    Result := 0;
end;

procedure TWindowsMedia.SetCurrent(const Value: TMediaTime);
var
  C, S: int64;
begin
  if (FMediaSeeking <> nil) then
  begin
    C := Value;
    FMediaSeeking.SetPositions(C, AM_SEEKING_AbsolutePositioning, S, AM_SEEKING_SeekToKeyFrame);
  end;
end;

function TWindowsMedia.GetVolume: Single;
var
  Vol: Integer;
begin
  if FBasicAudio <> nil then
  begin
    FBasicAudio.get_Volume(Vol);
    Result := Vol / 10000 + 1.0;
  end
  else
    Result := 1.0;
end;

procedure TWindowsMedia.SetVolume(const Value: Single);
begin
  if FBasicAudio <> nil then
    FBasicAudio.put_Volume(-10000 + round(Value * 10000));
end;

function TWindowsMedia.GetMediaState: TMediaState;
var
  State: TFilterState;
begin
  if (FMediaControl <> nil) then
  begin
    FMediaControl.GetState(0, State);
    case State of
      State_Running: Result := TMediaState.Playing;
    else
      Result := TMediaState.Stopped;
    end;
  end
  else
    Result := TMediaState.Unavailable;
end;

function TWindowsMedia.GetVideoSize: TPointF;
var
  W, H, AW, AH: Integer;
begin
  if FVMRWindowlessControl <> nil then
  begin
    FVMRWindowlessControl.GetNativeVideoSize(W, H, AW, AH);
    Result := TPointF.Create(W, H);
  end
  else
    Result := TPointF.Create(0, 0);
end;

{ TWindowsMediaCodec }

function TWindowsMediaCodec.CreateFromFile(const AFileName: string): TMedia;
begin
  Result := TWindowsMedia.Create(AFileName);
end;

initialization
  TMediaCodecManager.RegisterMediaCodecClass('.avi', SVAviFiles, TMediaType.Video, TWindowsMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.wmv', SVWMVFiles, TMediaType.Video, TWindowsMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.mp4', SVMP4Files, TMediaType.Video, TWindowsMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.m4v', SVMP4Files, TMediaType.Video, TWindowsMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.mov', SVMOVFiles, TMediaType.Video, TWindowsMediaCodec);

  TMediaCodecManager.RegisterMediaCodecClass('.wma', SVWMAFiles, TMediaType.Audio, TWindowsMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.mp3', SVMP3Files, TMediaType.Audio, TWindowsMediaCodec);
  TMediaCodecManager.RegisterMediaCodecClass('.wav', SVWAVFiles, TMediaType.Audio, TWindowsMediaCodec);
finalization
end.
