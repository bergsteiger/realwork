{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Context.DX10;

{ $DEFINE DXDEBUG}

interface

uses
  Winapi.DXGI, Winapi.D3D10, Winapi.D3D10_1, FMX.Types3D, System.Types, System.UITypes, System.SysUtils,
  System.Classes, System.Math, System.Generics.Collections;

type
  TCustomDX10Context = class(TContext3D)
  private class var
    FSharedDevice: ID3D10Device1;
    FDXGIFactory: IDXGIFactory;
    FVB: ID3D10Buffer;
    FIB: ID3D10Buffer;
    FVBLockPos, FIBLockPos: Integer;
    FBlankTexture: ID3D10Texture2D;
    FDriverType: TD3D10DriverType;
    FChecked: Boolean;
    class function GetSharedDevice: ID3D10Device; static;
    class procedure CreateSharedDevice; static;
    class function GetDXGIFactory: IDXGIFactory; static;
    class procedure CreateBlankTexture; static;
    class function GetBlankTexture: ID3D10Texture2D; static;
  public
    class procedure DestroySharedDevice; static;
    class function CheckDevice: TD3D10DriverType;
    class property SharedDevice: ID3D10Device read GetSharedDevice;
    class property DXGIFactory: IDXGIFactory read GetDXGIFactory;
    class property BlankTexture: ID3D10Texture2D read GetBlankTexture;
  end;

procedure RegisterContextClasses;
procedure UnregisterContextClasses;

implementation

uses
  Winapi.Windows, Winapi.DXTypes, System.Win.ComObj, FMX.Types, FMX.Forms, FMX.Platform.Win, FMX.PixelFormats,
  Winapi.DxgiType, Winapi.DxgiFormat, FMX.Context.DX9, FMX.Canvas.GPU;

var
  HR: HResult;
  VBSize: Integer = $FFFF * 56;
  IBSize: Integer = $FFFF * 2 * 2;

type

{ TDX10Context }

  TDX10Context = class(TCustomDX10Context)
  private class var
    FResources: IInterfaceList;
    FVSSlot: ID3D10Buffer;
    FPSSlot: ID3D10Buffer;
    FVSSlotModified, FPSSlotModified: Boolean;
    FVSBuf, FPSBuf: array of Byte;
    FInputLayout: ID3D10InputLayout;
    FResourceViews: array [0..16] of ID3D10ShaderResourceView;
    FSampleStates: array [0..16] of ID3D10SamplerState;
    FBlendDesc: TD3D10_BlendDesc;
    FBlendState: ID3D10BlendState;
    FBlendStateModified: Boolean;
    FRasterizerDesc: TD3D10_RasterizerDesc;
    FRasterizerState: ID3D10RasterizerState;
    FRasterizerStateModified: Boolean;
    FDepthStencilDesc: TD3D10_DepthStencilDesc;
    FDepthStencilState: ID3D10DepthStencilState;
    FDepthStencilModified: Boolean;
    FStencilRef: Integer;
  private
    class function AddResource(const Resource: IInterface): THandle;
    class procedure RemoveResource(Resource: THandle);
    class function ResourceToVertexShader(Resource: THandle): ID3D10VertexShader;
    class function ResourceToPixelShader(Resource: THandle): ID3D10PixelShader;
    class function ResourceToTexture(Resource: THandle): ID3D10Texture2D;
  private
    { states }
    FSavedRT: ID3D10RenderTargetView;
    FSavedDepth: ID3D10DepthStencilView;
    FSavedViewportNum: Cardinal;
    FSavedViewport: TD3D10_Viewport;
    { swapchain }
    FSwapChain: IDXGISwapChain;
    FRenderTargetView: ID3D10RenderTargetView;
    FDepthStencilTex: ID3D10Texture2D;
    FDepthStencilView: ID3D10DepthStencilView;
    { ms }
    FRenderTargetMSTex: ID3D10Texture2D;
    { copy }
    FCopyBuffer: ID3D10Texture2D;
    procedure FindBestMultisampleType(Format: DXGI_FORMAT; Multisample: TMultisample; out SampleCount, QualityLevel: Integer);
    procedure SetTexture(const AUnit: Integer; const Texture: TTexture);
  protected
    { assign }
    function GetValid: Boolean; override;
    { buffer }
    procedure DoCreateBuffer; override;
    procedure DoResize; override;
    procedure DoFreeBuffer; override;
    procedure DoCopyToBits(const Bits: Pointer; const Pitch: Integer; const ARect: TRect); override;
    { scene }
    function DoBeginScene: Boolean; override;
    procedure DoEndScene; override;
    { states }
    procedure DoClear(const ATarget: TClearTargets; const AColor: TAlphaColor; const ADepth: single; const AStencil: Cardinal); override;
    procedure DoSetContextState(AState: TContextState); override;
    procedure DoSetStencilOp(const Fail, ZFail, ZPass: TStencilOp); override;
    procedure DoSetStencilFunc(const Func: TStencilfunc; Ref, Mask: Cardinal); override;
    procedure DoSetScissorRect(const ScissorRect: TRect); override;
    { drawing }
    procedure DoDrawPrimitives(const AKind: TPrimitivesKind; const Vertices, Indices: Pointer; const VertexDeclaration: TVertexDeclaration;
      const VertexSize, VertexCount, IndexSize, IndexCount: Integer); override;
    { texture }
    class procedure DoInitializeTexture(const Texture: TTexture); override;
    class procedure DoFinalizeTexture(const Texture: TTexture); override;
    class procedure DoUpdateTexture(const Texture: TTexture; const Bits: Pointer; const Pitch: Integer); override;
    { bitmap }
    class function DoBitmapToTexture(const Bitmap: TBitmap): TTexture; override;
    { shaders }
    class procedure DoInitializeShader(const Shader: TContextShader); override;
    class procedure DoFinalizeShader(const Shader: TContextShader); override;
    procedure DoSetShaders(const VertexShader, PixelShader: TContextShader); override;
    procedure DoSetShaderVariable(const Name: string; const Data: array of TVector3D); override;
    procedure DoSetShaderVariable(const Name: string; const Texture: TTexture); override;
    procedure DoSetShaderVariable(const Name: string; const Matrix: TMatrix3D); override;
    { constructors }
    constructor CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
      const AMultisample: TMultisample; const ADepthStencil: Boolean); override;
    constructor CreateFromTexture(const ATexture: TTexture; const AMultisample: TMultisample;
      const ADepthStencil: Boolean); override;
  public
  end;

{$R-}

{$IFDEF CPUX64}
var
  PrevFPUState: TArithmeticExceptionMask;
{$ENDIF}

procedure SaveClearFPUState; inline;
begin
  {$IFDEF CPUX64}
  PrevFPUState:= GetExceptionMask();
  SetExceptionMask(exAllArithmeticExceptions);
  {$ENDIF}
end;

procedure RestoreFPUState; inline;
begin
  {$IFDEF CPUX64}
  SetExceptionMask(PrevFPUState);
  {$ENDIF}
end;

{$WARNINGS OFF}

function ColorToD3DColor(const AColor: TAlphaColor): TColorArray;
begin
  Result[0] := TAlphaColorRec(AColor).r / $FF;
  Result[1] := TAlphaColorRec(AColor).g / $FF;
  Result[2] := TAlphaColorRec(AColor).b / $FF;
  Result[3] := TAlphaColorRec(AColor).a / $FF;
end;

function TexturePixelFormatToDX(PF: TPixelFormat): DXGI_FORMAT;
begin
  case PF of
    pfA16B16G16R16:
      Result := DXGI_FORMAT_R16G16B16A16_UNORM;
    pfA2B10G10R10:
      Result := DXGI_FORMAT_R10G10B10A2_UNORM;
    pfA8R8G8B8:
      Result := DXGI_FORMAT_B8G8R8A8_UNORM;
    pfX8R8G8B8:
      Result := DXGI_FORMAT_B8G8R8X8_UNORM;
    pfA8B8G8R8:
      Result := DXGI_FORMAT_R8G8B8A8_UNORM;
    pfR5G6B5:
      Result := DXGI_FORMAT_B5G6R5_UNORM;
    pfA1R5G5B5:
      Result := DXGI_FORMAT_B5G5R5A1_UNORM;
    pfG16R16:
      Result := DXGI_FORMAT_R16G16_UNORM;
    pfA8L8:
      Result := DXGI_FORMAT_R8G8_UNORM;
    pfR16F:
      Result := DXGI_FORMAT_R16_FLOAT;
    pfG16R16F:
      Result := DXGI_FORMAT_R16G16_FLOAT;
    pfA16B16G16R16F:
      Result := DXGI_FORMAT_R16G16B16A16_FLOAT;
    pfR32F:
      Result := DXGI_FORMAT_R32_FLOAT;
    pfG32R32F:
      Result := DXGI_FORMAT_R32G32_FLOAT;
    pfA32B32G32R32F:
      Result := DXGI_FORMAT_R32G32B32A32_FLOAT;
    pfB10G11R11F:
      Result := DXGI_FORMAT_R11G11B10_FLOAT;
    pfA8:
      Result := DXGI_FORMAT_A8_UNORM;
    pfR8G8_B8G8:
      Result := DXGI_FORMAT_G8R8_G8B8_UNORM;
    pfG8R8_G8B8:
      Result := DXGI_FORMAT_R8G8_B8G8_UNORM;
    pfDXT1, pfDXT2:
      Result := DXGI_FORMAT_BC1_UNORM;
    pfDXT3, pfDXT4:
      Result := DXGI_FORMAT_BC2_UNORM;
    pfDXT5:
      Result := DXGI_FORMAT_BC3_UNORM;
    pfV8U8:
      Result := DXGI_FORMAT_R8G8_SNORM;
    pfQ8W8V8U8:
      Result := DXGI_FORMAT_R8G8B8A8_SNORM;
    pfV16U16:
      Result := DXGI_FORMAT_R16G16_SNORM;
    pfQ16W16V16U16:
      Result := DXGI_FORMAT_R16G16B16A16_SNORM;
    pfA32B32G32R32:
      Result := DXGI_FORMAT_R32G32B32A32_UINT;
  else
    Result := DXGI_FORMAT_UNKNOWN;
  end;
end;

function GetSlotSize(const Source: TContextShaderSource): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to High(Source.Variables) do
    Result := Result + Max(Source.Variables[I].Size, 16);
end;

function D3D10CreateDevice1Ex(DriverType: D3D10_DRIVER_TYPE; Flags: LongWord; out DDevice: ID3D10Device1): HResult;
begin
  Result := D3D10CreateDevice1(nil, DriverType, 0, Flags, D3D10_FEATURE_LEVEL_10_1, D3D10_1_SDK_VERSION, DDevice);

  if (Failed(Result)) then
    Result := D3D10CreateDevice1(nil, DriverType, 0, Flags, D3D10_FEATURE_LEVEL_10_0, D3D10_1_SDK_VERSION, DDevice);
end;

{ TCustomDX10Context }

class procedure TCustomDX10Context.CreateSharedDevice;
var
  Flags: Cardinal;
  DXGIDevice: IDXGIDevice;
  DXGIAdapter: IDXGIAdapter;
begin
  if not Assigned(FSharedDevice) then
  begin
    SaveClearFPUState;
    try
      Flags := {$ifdef DXDEBUG}D3D10_CREATE_DEVICE_DEBUG{$else}0{$endif};
      Flags := Flags or D3D10_CREATE_DEVICE_BGRA_SUPPORT;
      HR := D3D10CreateDevice1Ex(FDriverType, Flags, FSharedDevice);
      if Succeeded(HR) then
      begin
        HR := FSharedDevice.CreateBuffer(TD3D10_BufferDesc.Create(VBSize, D3D10_BIND_VERTEX_BUFFER, D3D10_USAGE_DYNAMIC, D3D10_CPU_ACCESS_WRITE), nil, @FVB);
        HR := FSharedDevice.CreateBuffer(TD3D10_BufferDesc.Create(IBSize, D3D10_BIND_INDEX_BUFFER, D3D10_USAGE_DYNAMIC, D3D10_CPU_ACCESS_WRITE), nil, @FIB);
        // Acquire device DXGI factory
        HR := FSharedDevice.QueryInterface(IDXGIDevice, DXGIDevice);
        if Succeeded(HR) and (DXGIDevice <> nil) then
        begin
          HR := DXGIDevice.GetParent(IDXGIAdapter, DXGIAdapter);
          if Succeeded(HR) and (DXGIAdapter <> nil) then
            HR := DXGIAdapter.GetParent(IDXGIFactory, FDXGIFactory);
        end;
        if not Assigned(FDXGIFactory) then
          HR := CreateDXGIFactory(IDXGIFactory, FDXGIFactory);
      end;
    finally
      RestoreFPUState;
    end;
    TCustomDX10Context.FPixelFormat := TPixelFormat.pfA8R8G8B8;
    TCustomDX10Context.FTextureUnitCount := 16;
    TCustomDX10Context.FMaxTextureSize := 4096 * 4;
    TCustomDX10Context.FPixelToPixelPolygonOffset := PointF(0, 0);

    Fillchar(TDX10Context.FBlendDesc, SizeOf(TDX10Context.FBlendDesc), 0);
    TDX10Context.FBlendDesc.AlphaToCoverageEnable := False;
    TDX10Context.FBlendDesc.BlendEnable[0] := True;
    TDX10Context.FBlendDesc.SrcBlend := D3D10_BLEND_ONE;
    TDX10Context.FBlendDesc.DestBlend := D3D10_BLEND_INV_SRC_ALPHA;
    TDX10Context.FBlendDesc.BlendOp := D3D10_BLEND_OP_ADD;
    TDX10Context.FBlendDesc.SrcBlendAlpha := D3D10_BLEND_ONE;
    TDX10Context.FBlendDesc.DestBlendAlpha := D3D10_BLEND_INV_SRC_ALPHA;
    TDX10Context.FBlendDesc.BlendOpAlpha := D3D10_BLEND_OP_ADD;
    TDX10Context.FBlendDesc.RenderTargetWriteMask[0] := Byte(D3D10_COLOR_WRITE_ENABLE_ALL);
    TDX10Context.FBlendStateModified := True;

    TDX10Context.FRasterizerDesc.FillMode := D3D10_FILL_SOLID;
    TDX10Context.FRasterizerDesc.CullMode := D3D10_CULL_BACK;
    TDX10Context.FRasterizerDesc.FrontCounterClockwise := False;
    TDX10Context.FRasterizerDesc.DepthBias := 0;
    TDX10Context.FRasterizerDesc.DepthBiasClamp := 0;
    TDX10Context.FRasterizerDesc.SlopeScaledDepthBias := 0;
    TDX10Context.FRasterizerDesc.DepthClipEnable := True;
    TDX10Context.FRasterizerDesc.ScissorEnable := False;
    TDX10Context.FRasterizerDesc.MultisampleEnable := True;
    TDX10Context.FRasterizerDesc.AntialiasedLineEnable := True;
    TDX10Context.FRasterizerStateModified := True;

    FillChar(TDX10Context.FDepthStencilDesc, SizeOf(TDX10Context.FDepthStencilDesc), 0);
    TDX10Context.FDepthStencilDesc.DepthEnable := False;
    TDX10Context.FDepthStencilDesc.DepthWriteMask := D3D10_DEPTH_WRITE_MASK_ALL;
    TDX10Context.FDepthStencilDesc.DepthFunc := D3D10_COMPARISON_LESS_EQUAL;
    TDX10Context.FDepthStencilDesc.StencilEnable := False;
    TDX10Context.FDepthStencilModified := True;
    TDX10Context.FStencilRef := 0;
  end;
end;

class function TCustomDX10Context.CheckDevice: TD3D10DriverType;
var
  dx10lib: THandle;
  g_pd3dDevice: ID3D10Device1;
begin
  if not FChecked then
  begin
    FChecked := True;
    FDriverType := D3D10_DRIVER_TYPE_NULL;
    if GlobalUseGPUCanvas then Exit(FDriverType);
    dx10lib := LoadLibrary(D3D10_1_dll);
    if dx10lib <> 0 then
    try
      if GlobalUseDX10Software then
        FDriverType := D3D10_DRIVER_TYPE_WARP
      else begin
        if GlobalUseDX10 then
        begin
          { check for support for DX10 hardware }
          SaveClearFPUState;
          try
            if GetProcAddress(dx10lib, 'D3D10CreateDevice1') <> nil then
            begin
              if Succeeded(D3D10CreateDevice1Ex(D3D10_DRIVER_TYPE_HARDWARE, D3D10_CREATE_DEVICE_BGRA_SUPPORT, g_pd3dDevice)) then
              begin
                g_pd3dDevice := nil;
                FDriverType := D3D10_DRIVER_TYPE_HARDWARE;
              end else if not TCustomDX9Context.HardwareSupported and Succeeded(D3D10CreateDevice1Ex(D3D10_DRIVER_TYPE_WARP, D3D10_CREATE_DEVICE_BGRA_SUPPORT, g_pd3dDevice)) then
              begin
                // Switch to software mode
                g_pd3dDevice := nil;
                FDriverType := D3D10_DRIVER_TYPE_WARP;
              end;
            end;
          finally
            RestoreFPUState;
          end;
        end;
      end;
    finally
      FreeLibrary(dx10Lib);
    end;
  end;
  Result := FDriverType;
end;

class procedure TCustomDX10Context.CreateBlankTexture;
var
  Desc: TD3D10_Texture2DDesc;
  Data: D3D10_SUBRESOURCE_DATA;
  Color: UInt;
begin
  CreateSharedDevice;
  if Assigned(FSharedDevice) then
  begin
    FillChar(Desc, SizeOf(D3D10_TEXTURE2D_DESC), 0);
    Desc.Format := DXGI_FORMAT_B8G8R8A8_UNORM;
    Desc.Width := 1;
    Desc.Height := 1;
    Desc.MipLevels := 1;
    Desc.ArraySize := 1;
    Desc.SampleDesc.Count := 1;
    Desc.SampleDesc.Quality := 0;
    Desc.Usage := D3D10_USAGE_IMMUTABLE;
    Desc.BindFlags := D3D10_BIND_SHADER_RESOURCE;
    Color := $FFFFFFFF;
    Data.pSysMem := @Color;
    Data.SysMemPitch := 4;
    Data.SysMemSlicePitch := 0;
    SaveClearFPUState;
    try
      HR := SharedDevice.CreateTexture2D(Desc, @Data, FBlankTexture);
    finally
      RestoreFPUState;
    end;
  end;
end;

class function TCustomDX10Context.GetBlankTexture: ID3D10Texture2D;
begin
  CreateBlankTexture;
  Result := FBlankTexture;
end;

class function TCustomDX10Context.GetDXGIFactory: IDXGIFactory;
begin
  CreateSharedDevice;
  Result := FDXGIFactory;
end;

class function TCustomDX10Context.GetSharedDevice: ID3D10Device;
begin
  CreateSharedDevice;
  Result := FSharedDevice;
end;

class procedure TCustomDX10Context.DestroySharedDevice;
begin
  FVB := nil;
  FIB := nil;
  FDXGIFactory := nil;
  FBlankTexture := nil;
  FSharedDevice := nil;
end;

{ TDX10Context }

constructor TDX10Context.CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
  const AMultisample: TMultisample; const ADepthStencil: Boolean);
begin
  inherited;
  CreateSharedDevice;
  if Assigned(FSharedDevice) then
    CreateBuffer;
end;

constructor TDX10Context.CreateFromTexture(const ATexture: TTexture; const AMultisample: TMultisample; const ADepthStencil: Boolean);
begin
  inherited;
  CreateSharedDevice;
  if Assigned(FSharedDevice) then
    CreateBuffer;
end;

function TDX10Context.GetValid: Boolean;
begin
  Result := (SharedDevice <> nil);
end;

procedure TDX10Context.FindBestMultisampleType(Format: DXGI_FORMAT; Multisample: TMultisample; out SampleCount, QualityLevel: Integer);
var
  i, MaxSampleNo: Integer;
  QuaLevels: Cardinal;
  MultisampleCount: Integer;
begin
  if Multisample = TMultisample.ms4Samples then
    MultisampleCount := 4
  else if Multisample = TMultisample.ms2Samples then
    MultisampleCount := 2
  else
    MultisampleCount := 1;

  SampleCount := 1;
  QualityLevel:= 0;
  if (SharedDevice = nil) or (MultisampleCount < 2) or (Format = DXGI_FORMAT_UNKNOWN) then Exit;

  MaxSampleNo := Min(MultisampleCount, D3D10_MAX_MULTISAMPLE_SAMPLE_COUNT);

  SaveClearFPUState;
  try
    for i:= MaxSampleNo downto 2 do
    begin
      if (Failed(SharedDevice.CheckMultisampleQualityLevels(Format, i, QuaLevels))) then Continue;
      if (QuaLevels > 0) then
      begin
        SampleCount := i;
        QualityLevel:= QuaLevels - 1;
        Break;
      end;
    end;
  finally
    RestoreFPUState;
  end;
end;

procedure TDX10Context.DoCreateBuffer;
var
  Tex: ID3D10Texture2D;
  BackBuffer: ID3D10Texture2D;
  SwapDesc: TDXGISwapChainDesc;
  SampleCount, QualityLevel: Integer;
  TexDesc, Desc: TD3D10_Texture2DDesc;
begin
  if Valid then
  begin
    SaveClearFPUState;
    try
      { Create RenderTarget }
      if (Texture <> nil) then
      begin
        FindBestMultisampleType(TexturePixelFormatToDX(Texture.PixelFormat), Multisample, SampleCount, QualityLevel);
        if (Multisample <> TMultisample.msNone) and (SampleCount > 1) then
        begin
          FillChar(Desc, SizeOf(D3D10_TEXTURE2D_DESC), 0);
          Desc.Format := TexturePixelFormatToDX(Texture.PixelFormat);
          Desc.Width := Texture.Width;
          Desc.Height := Texture.Height;
          Desc.MipLevels := 1;
          Desc.ArraySize := 1;
          Desc.SampleDesc.Count  := SampleCount;
          Desc.SampleDesc.Quality := QualityLevel;
          Desc.Usage := D3D10_USAGE_DEFAULT;
          Desc.BindFlags := D3D10_BIND_SHADER_RESOURCE or D3D10_BIND_RENDER_TARGET;
          SaveClearFPUState;
          try
            HR := SharedDevice.CreateTexture2D(Desc, nil, FRenderTargetMSTex);
          finally
            RestoreFPUState;
          end;
          if Assigned(FRenderTargetMSTex) then
          begin
            HR := SharedDevice.CreateRenderTargetView(FRenderTargetMSTex, nil, @FRenderTargetView);
            if DepthStencil then
            begin
              FRenderTargetMSTex.GetDesc(TexDesc);
              FillChar(Desc, SizeOf(D3D10_TEXTURE2D_DESC), 0);
              Desc.Format := DXGI_FORMAT_D24_UNORM_S8_UINT;
              Desc.Width := TexDesc.Width;
              Desc.Height := TexDesc.Height;
              Desc.MipLevels := 1;
              Desc.ArraySize := 1;
              Desc.SampleDesc.Count  := SampleCount;
              Desc.SampleDesc.Quality:= QualityLevel;
              Desc.Usage := D3D10_USAGE_DEFAULT;
              Desc.BindFlags := D3D10_BIND_DEPTH_STENCIL;
              HR := SharedDevice.CreateTexture2D(Desc, nil, FDepthStencilTex);
              if Succeeded(HR) then
                HR := SharedDevice.CreateDepthStencilView(FDepthStencilTex, nil, @FDepthStencilView);
            end;
          end;
        end
        else
        begin
          Tex := ResourceToTexture(Texture.Handle);
          if Assigned(Tex) then
          begin
            Tex.GetDesc(TexDesc);
            HR := SharedDevice.CreateRenderTargetView(Tex, nil, @FRenderTargetView);
            if DepthStencil then
            begin
              FillChar(Desc, SizeOf(D3D10_TEXTURE2D_DESC), 0);
              Desc.Format := DXGI_FORMAT_D24_UNORM_S8_UINT;
              Desc.Width := TexDesc.Width;
              Desc.Height := TexDesc.Height;
              Desc.MipLevels := 1;
              Desc.ArraySize := 1;
              Desc.SampleDesc.Count := 1;
              Desc.SampleDesc.Quality := 0;
              Desc.Usage := D3D10_USAGE_DEFAULT;
              Desc.BindFlags := D3D10_BIND_DEPTH_STENCIL;
              HR := SharedDevice.CreateTexture2D(Desc, nil, FDepthStencilTex);
              if Succeeded(HR) then
                HR := SharedDevice.CreateDepthStencilView(FDepthStencilTex, nil, @FDepthStencilView);
            end;
          end;
        end;
      end
      else
      begin
        FillChar(SwapDesc, SizeOf(SwapDesc), 0);
        SwapDesc.BufferCount:= 1;
        SwapDesc.BufferDesc.Width := Width;
        SwapDesc.BufferDesc.Height:= Height;
        SwapDesc.BufferDesc.Format:= DXGI_FORMAT_B8G8R8A8_UNORM; // need to be choice
        SwapDesc.BufferUsage := DXGI_USAGE_RENDER_TARGET_OUTPUT;
        SwapDesc.OutputWindow := WindowHandleToPlatform(Parent).Wnd;
        FindBestMultisampleType(SwapDesc.BufferDesc.Format, Multisample, SampleCount, QualityLevel);
        SwapDesc.SampleDesc.Count  := SampleCount;
        SwapDesc.SampleDesc.Quality:= QualityLevel;
        SwapDesc.Windowed := True;
        HR := DXGIFactory.CreateSwapChain(SharedDevice, SwapDesc, FSwapChain);
        if Succeeded(HR) then
        begin
          HR := FSwapChain.GetBuffer(0, ID3D10Texture2D, BackBuffer);
          if Succeeded(HR) then
            HR := SharedDevice.CreateRenderTargetView(BackBuffer, nil, @FRenderTargetView);
          if DepthStencil then
          begin
            FillChar(Desc, SizeOf(D3D10_TEXTURE2D_DESC), 0);
            Desc.Format := DXGI_FORMAT_D24_UNORM_S8_UINT;
            Desc.Width := SwapDesc.BufferDesc.Width;
            Desc.Height := SwapDesc.BufferDesc.Height;
            Desc.MipLevels := 1;
            Desc.ArraySize := 1;
            Desc.SampleDesc.Count := SwapDesc.SampleDesc.Count;
            Desc.SampleDesc.Quality := SwapDesc.SampleDesc.Quality;
            Desc.Usage := D3D10_USAGE_DEFAULT;
            Desc.BindFlags := D3D10_BIND_DEPTH_STENCIL;
            HR := SharedDevice.CreateTexture2D(Desc, nil, FDepthStencilTex);
            if Succeeded(HR) then
              HR := SharedDevice.CreateDepthStencilView(FDepthStencilTex, nil, @FDepthStencilView);
          end;
        end;
      end;
    finally
      RestoreFPUState;
    end;
  end;
end;

procedure TDX10Context.DoResize;
begin
end;

procedure TDX10Context.DoFreeBuffer;
begin
  if Valid then
  begin
    SaveClearFPUState;
    try
      FRenderTargetMSTex := nil;
      FSwapChain := nil;
      FRenderTargetView := nil;
      FDepthStencilTex := nil;
      FDepthStencilView := nil;
    finally
      RestoreFPUState;
    end;
  end;
end;

procedure TDX10Context.DoClear(const ATarget: TClearTargets; const AColor: TAlphaColor; const ADepth: single; const AStencil: Cardinal);
var
  Flags: TD3D10_ClearFlag;
begin
  if Valid then
  begin
    SaveClearFPUState;
    try
      if DepthStencil then
      begin
        Flags := 0;
        if (TClearTarget.ctDepth in ATarget) then
          Flags := Flags or D3D10_CLEAR_DEPTH;
        if (TClearTarget.ctStencil in ATarget) then
          Flags := Flags or D3D10_CLEAR_STENCIL;
        SharedDevice.ClearDepthStencilView(FDepthStencilView, Flags, ADepth, AStencil);
      end;
      if (TClearTarget.ctColor in ATarget) and Assigned(FRenderTargetView) then
        SharedDevice.ClearRenderTargetView(FRenderTargetView, ColorToD3DColor(AColor));
    finally
      RestoreFPUState;
    end;
  end;
end;

procedure TDX10Context.DoCopyToBits(const Bits: Pointer; const Pitch: Integer; const ARect: TRect);
var
  Desc: TD3D10_Texture2DDesc;
  BackBuffer: ID3D10Texture2D;
  Mapped: D3D10_MAPPED_TEXTURE2D;
  M: TBitmapData;
  I, W: UInt;
begin
  if Valid then
  begin
    SaveClearFPUState;
    try
      if FCopyBuffer = nil then
      begin
        FillChar(Desc, SizeOf(D3D10_TEXTURE2D_DESC), 0);
        Desc.Format := DXGI_FORMAT_B8G8R8A8_UNORM;
        Desc.Width := Width;
        Desc.Height := Height;
        Desc.MipLevels := 1;
        Desc.ArraySize := 1;
        Desc.SampleDesc.Count := 1;
        Desc.SampleDesc.Quality := 0;
        Desc.CPUAccessFlags := D3D10_CPU_ACCESS_READ;
        Desc.Usage := D3D10_USAGE_STAGING;
        Desc.BindFlags := 0;
        HR := SharedDevice.CreateTexture2D(Desc, nil, FCopyBuffer);
      end;

      if Texture = nil then
        HR := FSwapChain.GetBuffer(0, ID3D10Texture2D, BackBuffer)
      else
        BackBuffer := ResourceToTexture(Texture.Handle);
      SharedDevice.CopyResource(FCopyBuffer, BackBuffer);

      if Succeeded(FCopyBuffer.Map(0, D3D10_MAP_READ, 0, Mapped)) then
      try
        if (ARect.Left = 0) and (ARect.Top = 0) and (ARect.Width = Width) and (ARect.Height = Height) and
           (Mapped.RowPitch = Cardinal(M.Pitch)) and (M.Pitch = Width * 4) then
          Move(Mapped.pData^, Bits^, Pitch * Height)
        else
        begin
          for I := ARect.Top to ARect.Bottom - 1 do
          begin
            W := ARect.Left;
            Move(PAlphaColorArray(Mapped.pData)[W + (I * (Mapped.RowPitch div 4))], PAlphaColorArray(Bits)[I * (Pitch div 4) + ARect.Left], ARect.Width * 4);
          end;
        end;
      finally
        FCopyBuffer.Unmap(0);
      end;
    finally
      RestoreFPUState;
    end;
  end;
end;

function TDX10Context.DoBeginScene: Boolean;
var
  Viewport: TD3D10_Viewport;
begin
  Result := False;
  if Valid then
  begin
    SaveClearFPUState;
    try
      SharedDevice.OMGetRenderTargets(1, @FSavedRT, @FSavedDepth);
      SharedDevice.RSGetViewports(FSavedViewportNum, nil);
      if FSavedViewportNum > 0 then
        SharedDevice.RSGetViewports(FSavedViewportNum, @FSavedViewport);

      SharedDevice.OMSetRenderTargets(1, @FRenderTargetView, FDepthStencilView);
      FillChar(Viewport, SizeOf(D3D10_VIEWPORT), 0);
      Viewport.Width := Width;
      Viewport.Height := Height;
      Viewport.MinDepth := 0.0;
      Viewport.MaxDepth := 1.0;
      SharedDevice.RSSetViewports(1, @Viewport);

      Result := inherited DoBeginScene;
    finally
      RestoreFPUState;
    end;
  end;
end;

procedure TDX10Context.DoEndScene;
begin
  if Valid then
  begin
    SaveClearFPUState;
    try
      if Assigned(FRenderTargetMSTex) then
        SharedDevice.ResolveSubresource(ResourceToTexture(Texture.Handle), 0, FRenderTargetMSTex, 0, TexturePixelFormatToDX(Texture.PixelFormat));

      if (BeginSceneCount = 1) and (Texture = nil) then
        HR := FSwapChain.Present(0, 0);
      SharedDevice.OMSetRenderTargets(1, @FSavedRT, FSavedDepth);
      FSavedRT := nil;
      FSavedDepth := nil;

      if FSavedViewportNum > 0 then
        SharedDevice.RSSetViewports(1, @FSavedViewport);
    finally
      RestoreFPUState;
    end;
  end;
  inherited ;
end;

class function TDX10Context.DoBitmapToTexture(const Bitmap: TBitmap): TTexture;
begin
  if Bitmap.CanvasClass.InheritsFrom(TCustomCanvasGpu) then
    Result := TBitmapCtx(Bitmap.Handle).PaintingTexture
  else
    Result := inherited DoBitmapToTexture(Bitmap);
end;

procedure TDX10Context.DoSetContextState(AState: TContextState);
begin
  if Assigned(FSharedDevice) then
  begin
    case AState of
      TContextState.csZTestOn:
        begin
          FDepthStencilDesc.DepthEnable := True;
          FDepthStencilModified := True;
        end;
      TContextState.csZTestOff:
        begin
          FDepthStencilDesc.DepthEnable := False;
          FDepthStencilModified := True;
        end;
      TContextState.csZWriteOn:
        begin
          FDepthStencilDesc.DepthWriteMask := D3D10_DEPTH_WRITE_MASK_ALL;
          FDepthStencilModified := True;
        end;
      TContextState.csZWriteOff:
        begin
          FDepthStencilDesc.DepthWriteMask := D3D10_DEPTH_WRITE_MASK_ZERO;
          FDepthStencilModified := True;
        end;
      TContextState.csAlphaBlendOn:
        begin
          FBlendDesc.BlendEnable[0] := True;
          FBlendStateModified := True;
        end;
      TContextState.csAlphaBlendOff:
        begin
          FBlendDesc.BlendEnable[0] := False;
          FBlendStateModified := True;
        end;
      TContextState.csStencilOn:
        begin
          FDepthStencilDesc.StencilEnable := True;
          FDepthStencilModified := True;
        end;
      TContextState.csStencilOff:
        begin
          FDepthStencilDesc.StencilEnable := False;
          FDepthStencilModified := True;
        end;
      TContextState.csColorWriteOn:
        begin
          FBlendDesc.RenderTargetWriteMask[0] := Byte(D3D10_COLOR_WRITE_ENABLE_ALL);
          FBlendStateModified := True;
        end;
      TContextState.csColorWriteOff:
        begin
          FBlendDesc.RenderTargetWriteMask[0] := 0;
          FBlendStateModified := True;
        end;
      TContextState.csScissorOn:
        begin
          FRasterizerDesc.ScissorEnable := True;
          FRasterizerStateModified := True;
        end;
      TContextState.csScissorOff:
        begin
          FRasterizerDesc.ScissorEnable := False;
          FRasterizerStateModified := True;
        end;
      TContextState.csFrontFace:
        begin
          FRasterizerDesc.CullMode := D3D10_CULL_BACK;
          FRasterizerStateModified := True;
        end;
      TContextState.csBackFace:
        begin
          FRasterizerDesc.CullMode := D3D10_CULL_FRONT;
          FRasterizerStateModified := True;
        end;
      TContextState.csAllFace:
        begin
          FRasterizerDesc.CullMode := D3D10_CULL_NONE;
          FRasterizerStateModified := True;
        end;
    end;
  end;
end;

procedure TDX10Context.DoSetStencilOp(const Fail, ZFail, ZPass: TStencilOp);
begin
  case Fail of
    TStencilOp.soKeep: FDepthStencilDesc.FrontFace.StencilFailOp := D3D10_STENCIL_OP_KEEP;
    TStencilOp.soZero: FDepthStencilDesc.FrontFace.StencilFailOp := D3D10_STENCIL_OP_ZERO;
    TStencilOp.soReplace: FDepthStencilDesc.FrontFace.StencilFailOp := D3D10_STENCIL_OP_REPLACE;
    TStencilOp.soIncrease: FDepthStencilDesc.FrontFace.StencilFailOp := D3D10_STENCIL_OP_INCR_SAT;
    TStencilOp.soDecrease: FDepthStencilDesc.FrontFace.StencilFailOp := D3D10_STENCIL_OP_DECR_SAT;
    TStencilOp.soInvert: FDepthStencilDesc.FrontFace.StencilFailOp := D3D10_STENCIL_OP_INVERT;
  end;
  case ZFail of
    TStencilOp.soKeep: FDepthStencilDesc.FrontFace.StencilDepthFailOp := D3D10_STENCIL_OP_KEEP;
    TStencilOp.soZero: FDepthStencilDesc.FrontFace.StencilDepthFailOp := D3D10_STENCIL_OP_ZERO;
    TStencilOp.soReplace: FDepthStencilDesc.FrontFace.StencilDepthFailOp := D3D10_STENCIL_OP_REPLACE;
    TStencilOp.soIncrease: FDepthStencilDesc.FrontFace.StencilDepthFailOp := D3D10_STENCIL_OP_INCR_SAT;
    TStencilOp.soDecrease: FDepthStencilDesc.FrontFace.StencilDepthFailOp := D3D10_STENCIL_OP_DECR_SAT;
    TStencilOp.soInvert: FDepthStencilDesc.FrontFace.StencilDepthFailOp := D3D10_STENCIL_OP_INVERT;
  end;
  case ZPass of
    TStencilOp.soKeep: FDepthStencilDesc.FrontFace.StencilPassOp := D3D10_STENCIL_OP_KEEP;
    TStencilOp.soZero: FDepthStencilDesc.FrontFace.StencilPassOp := D3D10_STENCIL_OP_ZERO;
    TStencilOp.soReplace: FDepthStencilDesc.FrontFace.StencilPassOp := D3D10_STENCIL_OP_REPLACE;
    TStencilOp.soIncrease: FDepthStencilDesc.FrontFace.StencilPassOp := D3D10_STENCIL_OP_INCR_SAT;
    TStencilOp.soDecrease: FDepthStencilDesc.FrontFace.StencilPassOp := D3D10_STENCIL_OP_DECR_SAT;
    TStencilOp.soInvert: FDepthStencilDesc.FrontFace.StencilPassOp := D3D10_STENCIL_OP_INVERT;
  end;
  FDepthStencilDesc.BackFace := FDepthStencilDesc.FrontFace;
  FDepthStencilModified := True;
end;

procedure TDX10Context.DoSetStencilFunc(const Func: TStencilfunc; Ref, Mask: Cardinal);
begin
  case Func of
    TStencilFunc.sfNever: FDepthStencilDesc.FrontFace.StencilFunc := D3D10_COMPARISON_NEVER;
    TStencilFunc.sfLess: FDepthStencilDesc.FrontFace.StencilFunc := D3D10_COMPARISON_LESS;
    TStencilFunc.sfLequal: FDepthStencilDesc.FrontFace.StencilFunc := D3D10_COMPARISON_LESS_EQUAL;
    TStencilFunc.sfGreater: FDepthStencilDesc.FrontFace.StencilFunc := D3D10_COMPARISON_GREATER;
    TStencilFunc.sfGequal: FDepthStencilDesc.FrontFace.StencilFunc := D3D10_COMPARISON_GREATER_EQUAL;
    TStencilFunc.sfEqual: FDepthStencilDesc.FrontFace.StencilFunc := D3D10_COMPARISON_EQUAL;
    TStencilFunc.sfNotEqual: FDepthStencilDesc.FrontFace.StencilFunc := D3D10_COMPARISON_NOT_EQUAL;
    TStencilFunc.sfAlways: FDepthStencilDesc.FrontFace.StencilFunc := D3D10_COMPARISON_ALWAYS;
  end;
  FDepthStencilDesc.StencilReadMask := Mask;
  FDepthStencilDesc.StencilWriteMask := Mask;
  FDepthStencilDesc.BackFace := FDepthStencilDesc.FrontFace;
  FStencilRef := Ref;
  FDepthStencilModified := True;
end;

procedure TDX10Context.DoDrawPrimitives(const AKind: TPrimitivesKind; const Vertices, Indices: Pointer; const VertexDeclaration: TVertexDeclaration;
      const VertexSize, VertexCount, IndexSize, IndexCount: Integer);
var
  Ver: Pointer;
  Idx: ^Word;
  BufData: Pointer;
  VtxStride, VtxOffset: LongWord;
  InputElements: array of TD3D10_InputElementDesc;
  Source: TContextShaderSource;
  Flags: TD3D10_Map;
  OldInputLayout: ID3D10InputLayout;
  OldDepthStencilState: ID3D10DepthStencilState;
  OldBlendState: ID3D10BlendState;
  OldRasterizerState: ID3D10RasterizerState;
  OldVSSlot: ID3D10Buffer;
  OldPSSlot: ID3D10Buffer;
  Desc: TD3D10_BufferDesc;
  NeedCreatePS, NeedCreateVS: Boolean;
  Element: TVertexElement;
begin
  if Valid and (CurrentVertexShader <> nil) then
  begin
    SaveClearFPUState;
    try
      if FVBLockPos + VertexSize * VertexCount > VBSize then
      begin
        FVBLockPos := 0;
        Flags := D3D10_MAP_WRITE_DISCARD;
      end
      else
        Flags := D3D10_MAP_WRITE_NO_OVERWRITE;

      if Succeeded(FVB.Map(Flags, 0, Pointer(Ver))) then
      try
        Move(Vertices^, PByteArray(Ver)[FVBLockPos], VertexSize * VertexCount);
      finally
        { unlock }
        FVB.Unmap;
      end;

      if FIBLockPos + IndexCount * IndexSize > IBSize then
      begin
        FIBLockPos := 0;
        Flags := D3D10_MAP_WRITE_DISCARD;
      end
      else
        Flags := D3D10_MAP_WRITE_NO_OVERWRITE;

      if Succeeded(FIB.Map(Flags, 0, Pointer(Idx))) then
      try
        Move(Indices^, PByteArray(Idx)[FIBLockPos], IndexCount * IndexSize);
      finally
        FIB.Unmap;
      end;

      SetLength(InputElements, 0);
      for Element in VertexDeclaration do
      begin
        case Element.Format of
          TVertexFormat.vfVertex:
            begin
              SetLength(InputElements, Length(InputElements) + 1);
              InputElements[High(InputElements)].SemanticName := 'POSITION';
              InputElements[High(InputElements)].SemanticIndex := 0;
              InputElements[High(InputElements)].Format := DXGI_FORMAT_R32G32B32_FLOAT;
              InputElements[High(InputElements)].InputSlot := High(InputElements);
              InputElements[High(InputElements)].AlignedByteOffset := Element.Offset;
              InputElements[High(InputElements)].InputSlotClass := D3D10_INPUT_PER_VERTEX_DATA;
              InputElements[High(InputElements)].InstanceDataStepRate := 0;
            end;
          TVertexFormat.vfNormal:
            begin
              SetLength(InputElements, Length(InputElements) + 1);
              InputElements[High(InputElements)].SemanticName := 'NORMAL';
              InputElements[High(InputElements)].SemanticIndex := 0;
              InputElements[High(InputElements)].Format := DXGI_FORMAT_R32G32B32_FLOAT;
              InputElements[High(InputElements)].InputSlot := 0;
              InputElements[High(InputElements)].AlignedByteOffset := Element.Offset;
              InputElements[High(InputElements)].InputSlotClass := D3D10_INPUT_PER_VERTEX_DATA;
              InputElements[High(InputElements)].InstanceDataStepRate := 0;
            end;
          TVertexFormat.vfColor0:
            begin
              SetLength(InputElements, Length(InputElements) + 1);
              InputElements[High(InputElements)].SemanticName := 'COLOR';
              InputElements[High(InputElements)].SemanticIndex := 0;
              InputElements[High(InputElements)].Format := DXGI_FORMAT_B8G8R8A8_UNORM;
              InputElements[High(InputElements)].InputSlot := 0;
              InputElements[High(InputElements)].AlignedByteOffset := Element.Offset;
              InputElements[High(InputElements)].InputSlotClass := D3D10_INPUT_PER_VERTEX_DATA;
              InputElements[High(InputElements)].InstanceDataStepRate := 0;
            end;
          TVertexFormat.vfColor1:
            begin
              SetLength(InputElements, Length(InputElements) + 1);
              InputElements[High(InputElements)].SemanticName := 'COLOR';
              InputElements[High(InputElements)].SemanticIndex := 1;
              InputElements[High(InputElements)].Format := DXGI_FORMAT_B8G8R8A8_UNORM;
              InputElements[High(InputElements)].InputSlot := 0;
              InputElements[High(InputElements)].AlignedByteOffset := Element.Offset;
              InputElements[High(InputElements)].InputSlotClass := D3D10_INPUT_PER_VERTEX_DATA;
              InputElements[High(InputElements)].InstanceDataStepRate := 0;
            end;
          TVertexFormat.vfColor2:
            begin
              SetLength(InputElements, Length(InputElements) + 1);
              InputElements[High(InputElements)].SemanticName := 'COLOR';
              InputElements[High(InputElements)].SemanticIndex := 2;
              InputElements[High(InputElements)].Format := DXGI_FORMAT_B8G8R8A8_UNORM;
              InputElements[High(InputElements)].InputSlot := 0;
              InputElements[High(InputElements)].AlignedByteOffset := Element.Offset;
              InputElements[High(InputElements)].InputSlotClass := D3D10_INPUT_PER_VERTEX_DATA;
              InputElements[High(InputElements)].InstanceDataStepRate := 0;
            end;
          TVertexFormat.vfColor3:
            begin
              SetLength(InputElements, Length(InputElements) + 1);
              InputElements[High(InputElements)].SemanticName := 'COLOR';
              InputElements[High(InputElements)].SemanticIndex := 3;
              InputElements[High(InputElements)].Format := DXGI_FORMAT_B8G8R8A8_UNORM;
              InputElements[High(InputElements)].InputSlot := 0;
              InputElements[High(InputElements)].AlignedByteOffset := Element.Offset;
              InputElements[High(InputElements)].InputSlotClass := D3D10_INPUT_PER_VERTEX_DATA;
              InputElements[High(InputElements)].InstanceDataStepRate := 0;
            end;
          TVertexFormat.vfTexCoord0:
            begin
              SetLength(InputElements, Length(InputElements) + 1);
              InputElements[High(InputElements)].SemanticName := 'TEXCOORD';
              InputElements[High(InputElements)].SemanticIndex := 0;
              InputElements[High(InputElements)].Format := DXGI_FORMAT_R32G32_FLOAT;
              InputElements[High(InputElements)].InputSlot := 0;
              InputElements[High(InputElements)].AlignedByteOffset := Element.Offset;
              InputElements[High(InputElements)].InputSlotClass := D3D10_INPUT_PER_VERTEX_DATA;
              InputElements[High(InputElements)].InstanceDataStepRate := 0;
            end;
          TVertexFormat.vfTexCoord1:
            begin
              SetLength(InputElements, Length(InputElements) + 1);
              InputElements[High(InputElements)].SemanticName := 'TEXCOORD';
              InputElements[High(InputElements)].SemanticIndex := 1;
              InputElements[High(InputElements)].Format := DXGI_FORMAT_R32G32_FLOAT;
              InputElements[High(InputElements)].InputSlot := 0;
              InputElements[High(InputElements)].AlignedByteOffset := Element.Offset;
              InputElements[High(InputElements)].InputSlotClass := D3D10_INPUT_PER_VERTEX_DATA;
              InputElements[High(InputElements)].InstanceDataStepRate := 0;
            end;
          TVertexFormat.vfTexCoord2:
            begin
              SetLength(InputElements, Length(InputElements) + 1);
              InputElements[High(InputElements)].SemanticName := 'TEXCOORD';
              InputElements[High(InputElements)].SemanticIndex := 2;
              InputElements[High(InputElements)].Format := DXGI_FORMAT_R32G32_FLOAT;
              InputElements[High(InputElements)].InputSlot := 0;
              InputElements[High(InputElements)].AlignedByteOffset := Element.Offset;
              InputElements[High(InputElements)].InputSlotClass := D3D10_INPUT_PER_VERTEX_DATA;
              InputElements[High(InputElements)].InstanceDataStepRate := 0;
            end;
          TVertexFormat.vfTexCoord3:
            begin
              SetLength(InputElements, Length(InputElements) + 1);
              InputElements[High(InputElements)].SemanticName := 'TEXCOORD';
              InputElements[High(InputElements)].SemanticIndex := 3;
              InputElements[High(InputElements)].Format := DXGI_FORMAT_R32G32_FLOAT;
              InputElements[High(InputElements)].InputSlot := 0;
              InputElements[High(InputElements)].AlignedByteOffset := Element.Offset;
              InputElements[High(InputElements)].InputSlotClass := D3D10_INPUT_PER_VERTEX_DATA;
              InputElements[High(InputElements)].InstanceDataStepRate := 0;
            end;
          TVertexFormat.vfBiNormal:
            begin
              SetLength(InputElements, Length(InputElements) + 1);
              InputElements[High(InputElements)].SemanticName := 'BINORMAL';
              InputElements[High(InputElements)].SemanticIndex := 0;
              InputElements[High(InputElements)].Format := DXGI_FORMAT_R32G32B32_FLOAT;
              InputElements[High(InputElements)].InputSlot := 0;
              InputElements[High(InputElements)].AlignedByteOffset := Element.Offset;
              InputElements[High(InputElements)].InputSlotClass := D3D10_INPUT_PER_VERTEX_DATA;
              InputElements[High(InputElements)].InstanceDataStepRate := 0;
            end;
          TVertexFormat.vfTangent:
            begin
              SetLength(InputElements, Length(InputElements) + 1);
              InputElements[High(InputElements)].SemanticName := 'TANGENT';
              InputElements[High(InputElements)].SemanticIndex := 0;
              InputElements[High(InputElements)].Format := DXGI_FORMAT_R32G32B32_FLOAT;
              InputElements[High(InputElements)].InputSlot := 0;
              InputElements[High(InputElements)].AlignedByteOffset := Element.Offset;
              InputElements[High(InputElements)].InputSlotClass := D3D10_INPUT_PER_VERTEX_DATA;
              InputElements[High(InputElements)].InstanceDataStepRate := 0;
            end;
          TVertexFormat.vfColorF0:
            begin
              SetLength(InputElements, Length(InputElements) + 1);
              InputElements[High(InputElements)].SemanticName := 'COLOR';
              InputElements[High(InputElements)].SemanticIndex := 0;
              InputElements[High(InputElements)].Format := DXGI_FORMAT_R32G32B32A32_FLOAT;
              InputElements[High(InputElements)].InputSlot := 0;
              InputElements[High(InputElements)].AlignedByteOffset := Element.Offset;
              InputElements[High(InputElements)].InputSlotClass := D3D10_INPUT_PER_VERTEX_DATA;
              InputElements[High(InputElements)].InstanceDataStepRate := 0;
            end;
        end;
      end;

      if FVSSlotModified then
      begin
        NeedCreateVS := Length(FVSBuf) > 0;
        if Assigned(FVSSlot) then
        begin
          FVSSlot.GetDesc(Desc);
          if Desc.ByteWidth = Length(FVSBuf) then NeedCreateVS := False;
        end;
        if NeedCreateVS then
        begin
          OldVSSlot := FVSSlot;
          FVSSlot := nil;
          HR := FSharedDevice.CreateBuffer(TD3D10_BufferDesc.Create(Length(FVSBuf), D3D10_BIND_CONSTANT_BUFFER, D3D10_USAGE_DYNAMIC, D3D10_CPU_ACCESS_WRITE), nil, @FVSSlot);
        end;
        if Assigned(FVSSlot) then
        begin
          if Succeeded(FVSSlot.Map(D3D10_MAP_WRITE_DISCARD, 0, BufData)) then
          try
            Move(FVSBuf[0], BufData^, Length(FVSBuf));
          finally
            FVSSlot.Unmap;
          end;
          SharedDevice.VSSetConstantBuffers(0, 1, @FVSSlot);
        end;
        OldVSSlot := nil;
        FVSSlotModified := False;
      end;

      if FPSSlotModified then
      begin
        NeedCreatePS := Length(FPSBuf) > 0;
        if Assigned(FPSSlot) then
        begin
          FPSSlot.GetDesc(Desc);
          if Desc.ByteWidth = Length(FPSBuf) then NeedCreatePS := False;
        end;
        if NeedCreatePS then
        begin
          OldPSSlot := FPSSlot;
          FPSSlot := nil;
          HR := FSharedDevice.CreateBuffer(TD3D10_BufferDesc.Create(Length(FPSBuf), D3D10_BIND_CONSTANT_BUFFER, D3D10_USAGE_DYNAMIC, D3D10_CPU_ACCESS_WRITE), nil, @FPSSlot);
        end;
        if Assigned(FPSSlot) then
        begin
          if Succeeded(FPSSlot.Map(D3D10_MAP_WRITE_DISCARD, 0, Pointer(BufData))) then
          try
            Move(FPSBuf[0], BufData^, Length(FPSBuf));
          finally
            FPSSlot.Unmap;
          end;
          SharedDevice.PSSetConstantBuffers(0, 1, @FPSSlot);
        end;

        OldPSSlot := nil;
        FPSSlotModified := False;
      end;

      if FBlendStateModified then
      begin
        OldBlendState := FBlendState;
        FBlendState := nil;
        SharedDevice.CreateBlendState(FBlendDesc, @FBlendState);
        SharedDevice.OMSetBlendState(FBlendState, ColorToD3DColor($FFFFFFFF), $FFFFFFFF);
        OldBlendState := nil;
        FBlendStateModified := False;
      end
      else
        SharedDevice.OMSetBlendState(FBlendState, ColorToD3DColor($FFFFFFFF), $FFFFFFFF);

      if FDepthStencilModified then
      begin
        OldDepthStencilState := FDepthStencilState;
        FDepthStencilState := nil;
        SharedDevice.CreateDepthStencilState(FDepthStencilDesc, @FDepthStencilState);
        SharedDevice.OMSetDepthStencilState(FDepthStencilState, FStencilRef);
        OldDepthStencilState := nil;
        FDepthStencilModified := False;
      end
      else
        SharedDevice.OMSetDepthStencilState(FDepthStencilState, FStencilRef);

      if FRasterizerStateModified then
      begin
        OldRasterizerState := FRasterizerState;
        FRasterizerState := nil;
        SharedDevice.CreateRasterizerState(FRasterizerDesc, @FRasterizerState);
        SharedDevice.RSSetState(FRasterizerState);
        OldRasterizerState := nil;
        FRasterizerStateModified := False;
      end
      else
        SharedDevice.RSSetState(FRasterizerState);

      Source := CurrentVertexShader.GetSourceByArch(TContextShaderArch.saDX10);
      OldInputLayout := FInputLayout;
      FInputLayout := nil;
      HR := SharedDevice.CreateInputLayout(@InputElements[0], Length(InputElements), @Source.Code[0], Length(Source.Code), @FInputLayout);
      if Succeeded(HR) then
      begin
        VtxStride := VertexSize;
        VtxOffset := FVBLockPos;
        SharedDevice.IASetVertexBuffers(0, 1, @FVB, @VtxStride, @VtxOffset);
        SharedDevice.IASetInputLayout(FInputLayout);
        if IndexSize = 4 then
          SharedDevice.IASetIndexBuffer(FIB, DXGI_FORMAT_R32_UINT, FIBLockPos)
        else
          SharedDevice.IASetIndexBuffer(FIB, DXGI_FORMAT_R16_UINT, FIBLockPos);
        case AKind of
          TPrimitivesKind.pkPoints:
            SharedDevice.IASetPrimitiveTopology(D3D10_PRIMITIVE_TOPOLOGY_POINTLIST);
          TPrimitivesKind.pkLines:
            SharedDevice.IASetPrimitiveTopology(D3D10_PRIMITIVE_TOPOLOGY_LINELIST);
        else
          SharedDevice.IASetPrimitiveTopology(D3D10_PRIMITIVE_TOPOLOGY_TRIANGLELIST);
        end;
        SharedDevice.DrawIndexed(IndexCount, 0, 0);
        OldInputLayout := nil;
      end;
      FVBLockPos := FVBLockPos + VertexSize * VertexCount;
      FIBLockPos := FIBLockPos + IndexCount * IndexSize;
    finally
      RestoreFPUState;
    end;
  end;
end;

{ Resources }

class function TDX10Context.AddResource(const Resource: IInterface): THandle;
begin
  if FResources = nil then
  begin
    FResources := TInterfaceList.Create;
    // Fill in the first slot with a dummy entry. This will make it so that a TContextShader value of 0 is invalid.
    FResources.Add(TInterfacedObject.Create);
  end;
  Result := 0;
  while (Result < FResources.Count) and (FResources[Result] <> nil) do
    Inc(Result);
  if Result < FResources.Count then
    FResources[Result] := Resource
  else
    Result := FResources.Add(Resource);
end;

class procedure TDX10Context.RemoveResource(Resource: THandle);
begin
  if (FResources <> nil) and (Resource <> 0) then
    FResources[Resource] := nil;
end;

class function TDX10Context.ResourceToTexture(Resource: THandle): ID3D10Texture2D;
begin
  if (FResources <> nil) and (Resource > 0) and (Resource < FResources.Count) then
    Result := FResources[Resource] as ID3D10Texture2D
  else
    Result := nil;
end;

class function TDX10Context.ResourceToPixelShader(Resource: THandle): ID3D10PixelShader;
begin
  if (FResources <> nil) and (Resource > 0) and (Resource < FResources.Count) then
    Result := FResources[Resource] as ID3D10PixelShader
  else
    Result := nil;
end;

class function TDX10Context.ResourceToVertexShader(Resource: THandle): ID3D10VertexShader;
begin
  if (FResources <> nil) and (Resource > 0) and (Resource < FResources.Count) then
    Result := FResources[Resource] as ID3D10VertexShader
  else
    Result := nil;
end;

{ Textures }

class procedure TDX10Context.DoInitializeTexture(const Texture: TTexture);
var
  Tex: ID3D10Texture2D;
  Desc: TD3D10_Texture2DDesc;
begin
  CreateSharedDevice;
  if Assigned(FSharedDevice) then
  begin
    FillChar(Desc, SizeOf(D3D10_TEXTURE2D_DESC), 0);
    if Texture.PixelFormat = TPixelFormat.pfUnknown then
      Texture.PixelFormat := TPixelFormat.pfA8R8G8B8;
    Desc.Format := TexturePixelFormatToDX(Texture.PixelFormat);
    Desc.Width := Texture.Width;
    Desc.Height := Texture.Height;
    if TTextureStyle.tsMipMaps in Texture.Style then
    begin
      if (TTextureStyle.tsDynamic in Texture.Style) then
        Desc.MipLevels := 1
      else
        Desc.MipLevels := 0;
    end
    else
      Desc.MipLevels := 1;
    Desc.ArraySize := 1;
    Desc.SampleDesc.Count := 1;
    Desc.SampleDesc.Quality := 0;
    if (TTextureStyle.tsDynamic in Texture.Style) and not (TTextureStyle.tsRenderTarget in Texture.Style) then
    begin
      Desc.CPUAccessFlags := D3D10_CPU_ACCESS_WRITE;
      Desc.Usage := D3D10_USAGE_DYNAMIC;
    end
    else
      Desc.Usage := D3D10_USAGE_DEFAULT;
    Desc.BindFlags := D3D10_BIND_SHADER_RESOURCE;
    if TTextureStyle.tsRenderTarget in Texture.Style then
      Desc.BindFlags := Desc.BindFlags or D3D10_BIND_RENDER_TARGET;
    SaveClearFPUState;
    try
      HR := SharedDevice.CreateTexture2D(Desc, nil, Tex);
    finally
      RestoreFPUState;
    end;
    if Assigned(Tex) then
      ITextureAccess(Texture).Handle := AddResource(Tex);
  end;
end;

class procedure TDX10Context.DoFinalizeTexture(const Texture: TTexture);
begin
  SaveClearFPUState;
  try
    if Assigned(FSharedDevice) then
      RemoveResource(Texture.Handle);
    ITextureAccess(Texture).Handle := 0;
  finally
    RestoreFPUState;
  end;
end;

procedure TDX10Context.SetTexture(const AUnit: Integer; const Texture: TTexture);
var
  Tex: ID3D10Texture2D;
  Desc: TD3D10_SamplerDesc;
  OldResourceView: ID3D10ShaderResourceView;
  OldSampleState: ID3D10SamplerState;
begin
  SaveClearFPUState;
  try
    if not Assigned(FSampleStates[AUnit]) then
    begin
      FillChar(Desc, SizeOf(Desc), 0);
      Desc.AddressU := D3D10_TEXTURE_ADDRESS_CLAMP;
      Desc.AddressV := D3D10_TEXTURE_ADDRESS_CLAMP;
      Desc.AddressW := D3D10_TEXTURE_ADDRESS_CLAMP;
      Desc.Filter := D3D10_FILTER_MIN_MAG_MIP_LINEAR;
      Desc.MipLODBias := 0;
      Desc.MaxAnisotropy := 1;
      Desc.ComparisonFunc := D3D10_COMPARISON_NEVER;
      Desc.MinLOD := -MaxSingle;
      Desc.MaxLOD := MaxSingle;
      OldSampleState := FSampleStates[AUnit];
      FSampleStates[AUnit] := nil;
      HR := SharedDevice.CreateSamplerState(Desc, @FSampleStates[AUnit]);
      if Succeeded(HR) then
      begin
        SharedDevice.PSSetSamplers(AUnit, 1, @FSampleStates[AUnit]);
        OldSampleState := nil;
      end;
    end;

    if (Texture <> nil) and (Texture.Handle <> 0) then
      Tex := ResourceToTexture(Texture.Handle)
    else
      Tex := BlankTexture;
    OldResourceView := FResourceViews[AUnit];
    FResourceViews[AUnit] := nil;
    HR := SharedDevice.CreateShaderResourceView(Tex, nil, @FResourceViews[AUnit]);
    if Succeeded(HR) then
    begin
      SharedDevice.PSSetShaderResources(AUnit, 1, @FResourceViews[AUnit]);
      OldResourceView := nil;
    end;
  finally
    RestoreFPUState;
  end;
end;

class procedure TDX10Context.DoUpdateTexture(const Texture: TTexture; const Bits: Pointer; const Pitch: Integer);
var
  Mapped: D3D10_MAPPED_TEXTURE2D;
  I, BytesToCopy: Integer;
  Tex: ID3D10Texture2D;
begin
  if (Texture <> nil) and (Texture.Handle <> 0) then
  begin
    SaveClearFPUState;
    try
      Tex := ResourceToTexture(Texture.Handle);
      if Succeeded(Tex.Map(0, D3D10_MAP_WRITE_DISCARD, 0, Mapped)) then
      try
        if Pitch = Mapped.RowPitch then
          Move(Bits^, Mapped.pData^, Texture.Height * Pitch)
        else
        begin
          BytesToCopy := Min(Pitch, Mapped.RowPitch);
          for I := 0 to Texture.Height - 1 do
            Move(PByteArray(Bits)[Pitch * I], PByteArray(Mapped.pData)[Mapped.RowPitch * I], BytesToCopy)
        end;
      finally
        Tex.Unmap(0);
      end;
    finally
      RestoreFPUState;
    end;
  end;
end;

{ Shader }

class procedure TDX10Context.DoInitializeShader(const Shader: TContextShader);
var
  VSShader: ID3D10VertexShader;
  PSShader: ID3D10PixelShader;
  Source: TContextShaderSource;
begin
  CreateSharedDevice;
  if Assigned(FSharedDevice) then
  begin
    Source := Shader.GetSourceByArch(TContextShaderArch.saDX10);
    if Source.IsDefined then
    begin
      SaveClearFPUState;
      try
        if Shader.Kind = TContextShaderKind.skVertexShader then
        begin
          HR := SharedDevice.CreateVertexShader(Source.Code, Length(Source.Code), @VSShader);
          if Assigned(VSShader) then
            Shader.Handle := AddResource(VSShader);
        end
        else
        begin
          HR := SharedDevice.CreatePixelShader(Source.Code, Length(Source.Code), @PSShader);
          if Assigned(PSShader) then
            Shader.Handle := AddResource(PSShader);
        end;
      finally
        RestoreFPUState;
      end;
    end;
  end;
end;

class procedure TDX10Context.DoFinalizeShader(const Shader: TContextShader);
begin
  if Assigned(FSharedDevice) then
  begin
    SaveClearFPUState;
    try
      RemoveResource(Shader.Handle);
    finally
      RestoreFPUState;
    end;
  end;
  Shader.Handle := 0;
end;

procedure TDX10Context.DoSetScissorRect(const ScissorRect: TRect);
begin
  if Assigned(FSharedDevice) then
  begin
    SaveClearFPUState;
    try
      FSharedDevice.RSSetScissorRects(1, @ScissorRect);
    finally
      RestoreFPUState;
    end;
  end;
end;

procedure TDX10Context.DoSetShaders(const VertexShader, PixelShader: TContextShader);
var
  Source: TContextShaderSource;
begin
  if Assigned(FSharedDevice) then
  begin
    SaveClearFPUState;
    try
      SharedDevice.VSSetShader(ResourceToVertexShader(VertexShader.Handle));
      SharedDevice.PSSetShader(ResourceToPixelShader(PixelShader.Handle));
    finally
      RestoreFPUState;
    end;
    if VertexShader <> nil then
    begin
      Source := VertexShader.GetSourceByArch(TContextShaderArch.saDX10);
      SetLength(FVSBuf, GetSlotSize(Source));
      FVSSlotModified := True;
    end;
    if PixelShader <> nil then
    begin
      Source := PixelShader.GetSourceByArch(TContextShaderArch.saDX10);
      SetLength(FPSBuf, GetSlotSize(Source));
      FPSSlotModified := True;
    end;
  end;
end;

procedure TDX10Context.DoSetShaderVariable(const Name: string; const Data: array of TVector3D);
var
  I: Integer;
  Source: TContextShaderSource;
begin
  if Assigned(FSharedDevice) then
  begin
    if (CurrentVertexShader <> nil) and (Length(FVSBuf) > 0) then
    begin
      Source := CurrentVertexShader.GetSourceByArch(TContextShaderArch.saDX10);
      for I := 0 to High(Source.Variables) do
        if SameText(Source.Variables[I].Name, Name) then
        begin
          Move(Data[0], FVSBuf[Source.Variables[I].Index], Min(SizeOf(Data), Source.Variables[I].Size));
          FVSSlotModified := True;
          Exit;
        end;
    end;
    if (CurrentPixelShader <> nil) and (Length(FPSBuf) > 0) then
    begin
      Source := CurrentPixelShader.GetSourceByArch(TContextShaderArch.saDX10);
      for I := 0 to High(Source.Variables) do
        if SameText(Source.Variables[I].Name, Name) then
        begin
          Move(Data[0], FPSBuf[Source.Variables[I].Index], Min(SizeOf(Data), Source.Variables[I].Size));
          FPSSlotModified := True;
          Exit;
        end;
    end;
  end;
end;

procedure TDX10Context.DoSetShaderVariable(const Name: string; const Texture: TTexture);
var
  I: Integer;
  Source: TContextShaderSource;
begin
  if Valid and (CurrentPixelShader <> nil) then
  begin
    Source := CurrentPixelShader.GetSourceByArch(TContextShaderArch.saDX10);
    for I := 0 to High(Source.Variables) do
      if SameText(Source.Variables[I].Name, Name) then
      begin
        SetTexture(Source.Variables[I].Index, Texture);
        Exit;
      end;
  end;
end;

procedure TDX10Context.DoSetShaderVariable(const Name: string; const Matrix: TMatrix3D);
begin
  SetShaderVariable(Name, Matrix.M);
end;

procedure RegisterContextClasses;
begin
  if (TCustomDX10Context.CheckDevice <> D3D10_DRIVER_TYPE_NULL) then
    TContextManager.RegisterContext(TDX10Context, True);
end;

procedure UnregisterContextClasses;
begin
  TDX10Context.DestroySharedDevice;
end;

initialization
end.
