{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Context.Mac;

interface

uses
  System.Classes, System.SysUtils, System.Types, System.UITypes, System.UIConsts, System.Generics.Collections,
  System.Math, Macapi.ObjectiveC, Macapi.CocoaTypes, Macapi.AppKit, Macapi.OpenGL, FMX.Types, FMX.Types3D,
  FMX.Platform, FMX.Forms, FMX.PixelFormats, FMX.Platform.Mac;

type

  TShaderProgram = class
  private
    VS, PS: THandle;
    Prog: THandle;
    Variables: TDictionary<string, TContextShaderVariable>;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TCustomContextOpenGL = class(TContext3D)
  protected class var
    FSharedContext: NSOpenGLContext;
    FCurrentProgram: TShaderProgram;
    FPrograms: TList<TShaderProgram>;
    class procedure CreateSharedContext;
    class procedure DestroySharedContext;
    class function GetSharedContext: NSOpenGLContext; static;
  public
    class property SharedContext: NSOpenGLContext read GetSharedContext;
  end;

procedure RegisterContextClasses;
procedure UnregisterContextClasses;

implementation {===============================================================}

uses FMX.Consts;

const
  MaxStopLock = 16;

function GLGetErrorFlags(): Integer;
var
  Flag, StopLock: Integer;
begin
  Result := 0;

  StopLock := MaxStopLock;

  repeat
    Flag := glGetError();
    if (Flag <> GL_NO_ERROR) then
      Result := Result or Flag;

    Dec(StopLock);
  until (Flag = GL_NO_ERROR) or (StopLock <= 0);
end;

function GLHasAnyErrors(): Boolean;
begin
  Result := GLGetErrorFlags() <> 0;
end;

{ TShaderProgram }

constructor TShaderProgram.Create;
begin
  inherited ;
  Variables := TDictionary<string, TContextShaderVariable>.Create;
end;

destructor TShaderProgram.Destroy;
begin
  FreeAndNil(Variables);
  inherited;
end;

{ TCustomContextOpenGL }

const

  ATTRIB_VERTEX     = 0;
  ATTRIB_NORMAL     = 1;
  ATTRIB_COLOR0     = 2;
  ATTRIB_COLOR1     = 3;
  ATTRIB_COLOR2     = 4;
  ATTRIB_COLOR3     = 5;
  ATTRIB_TEXCOORD0  = 6;
  ATTRIB_TEXCOORD1  = 7;
  ATTRIB_TEXCOORD2  = 8;
  ATTRIB_TEXCOORD3  = 9;

const

  attrs: array  [0..5] of NSOpenGLPixelFormatAttribute =
    (
		NSOpenGLPFADoubleBuffer,
		NSOpenGLPFADepthSize, 24,
		NSOpenGLPFAStencilSize, 8,
                0
    );

class procedure TCustomContextOpenGL.CreateSharedContext;
var
  PixelFormat: NSOpenGLPixelFormat;
  Ctx: NSOpenGLContext;
begin
  if FSharedContext = nil then
  begin
    PixelFormat := TNSOpenGLPixelFormat.Create;
    PixelFormat := TNSOpenGLPixelFormat.Wrap(PixelFormat.initWithAttributes(@attrs[0]));
    Ctx := TNSOpenGLContext.Create;
    FSharedContext := TNSOpenGLContext.Wrap(Ctx.initWithFormat(PixelFormat, nil));
    FSharedContext.makeCurrentContext;
    PixelFormat.release;

    glDisable(GL_LIGHT0);
    glDisable(GL_LIGHT1);
    glDisable(GL_LIGHT2);
    glDisable(GL_LIGHT3);
    glDisable(GL_LIGHT4);
    glDisable(GL_LIGHT5);
    glDisable(GL_LIGHT6);
    glDisable(GL_LIGHT7);

    glEnable(GL_NORMALIZE);

    TCustomContextOpenGL.FStyle := [TContextStyle.RenderTargetFlipped];
    TCustomContextOpenGL.FPixelFormat := TPixelFormat.pfA8B8G8R8;
    TCustomContextOpenGL.FPixelToPixelPolygonOffset := PointF(0, 0);
    glGetIntegerv(GL_MAX_TEXTURE_SIZE, @TCustomContextOpenGL.FMaxTextureSize);
    glGetIntegerv(GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, @TCustomContextOpenGL.FTextureUnitCount);
  end;
end;

class procedure TCustomContextOpenGL.DestroySharedContext;
var
  Rec: TShaderProgram;
begin
  if FSharedContext <> nil then
  begin
    if FPrograms <> nil then
    begin
      for Rec in FPrograms do
        glDeleteProgram(Rec.Prog);
      FreeAndNil(FPrograms);
    end;
    FSharedContext := nil;
  end;
end;

class function TCustomContextOpenGL.GetSharedContext: NSOpenGLContext;
begin
  CreateSharedContext;
  Result := FSharedContext;
end;

type

  { TContextOpenGL }

  TContextOpenGL = class(TCustomContextOpenGL)
  private
    { buffers }
    FRenderBuf: GLuint;
    FFrameBuf: GLuint;
    FDepthBuf: GLuint;
    FContextObject: NSOpenGLContext;
    { bitmap }
    FBitmapBuffer: PAlphaColorArray;
    FBitmapBufferLen: Integer;
    { MS }
    FSupportMS: Boolean;
    FMSValue: Integer;
    FRenderBufMS: GLuint;
    FFrameBufMS: GLuint;
    FDepthBufMS: GLuint;
    { States }
    FOldFBO: GLuint;
    { hires }
    FScale: Single;
  protected
    class function BuildShader(AType: Integer; ACode: TContextShaderCode): Integer;
    class function FindProgram(const VS, PS: TContextShader): TShaderProgram; static;
    class procedure UseProgram(const VS, PS: TContextShader); static;
  protected
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
    destructor Destroy; override;
    property ContextObject: NSOpenGLContext read FContextObject;
  end;

function PixelFormatToInternalFormat(Source: TPixelFormat): Integer;
begin
  case Source of
    pfA16B16G16R16:
      Result := GL_RGBA16;

    pfA2B10G10R10:
      Result := GL_RGB10_A2;

    pfA2R10G10B10:
      Result := GL_RGB10_A2;

    pfA8R8G8B8:
      Result := GL_RGBA8;

    pfX8R8G8B8:
      Result := GL_RGB8;

    pfA8B8G8R8:
      Result := GL_RGBA8;

    pfX8B8G8R8:
      Result := GL_RGB8;

    pfR5G6B5:
      Result := GL_RGB8;

    pfA4R4G4B4:
      Result := GL_RGBA4;

    pfA1R5G5B5:
      Result := GL_RGB5_A1;

    pfX1R5G5B5:
      Result := GL_RGB5;

    pfG16R16:
      Result := GL_RG16;

    pfA8L8:
      Result := GL_LUMINANCE8_ALPHA8;

    pfA4L4:
      Result := GL_LUMINANCE4_ALPHA4;

    pfR16F:
      Result := GL_R16F;

    pfG16R16F:
      Result := GL_RG16F;

    pfA16B16G16R16F:
      Result := GL_RGBA_FLOAT16_APPLE;

    pfR32F:
      Result := GL_R32F;

    pfG32R32F:
      Result := GL_RG32F;

    pfA32B32G32R32F:
      Result := GL_RGBA_FLOAT32_APPLE;

    pfA8:
      Result := GL_ALPHA8;

    pfV8U8:
      Result := GL_RG8I;

    pfX8L8V8U8:
      Result := GL_RGBA8I_EXT;

    pfQ8W8V8U8:
      Result := GL_RGBA8I_EXT;

    pfV16U16:
      Result := GL_RG16I;

    pfU8Y8_V8Y8:
      Result := GL_UNSIGNED_SHORT_8_8_REV_APPLE;

    pfY8U8_Y8V8:
      Result := GL_UNSIGNED_SHORT_8_8_APPLE;

    pfB10G11R11F:
      Result := GL_R11F_G11F_B10F_EXT;

    pfDXT1, pfDXT2:
      Result := GL_COMPRESSED_RGBA_S3TC_DXT1_EXT;

    pfDXT3, pfDXT4:
      Result := GL_COMPRESSED_RGBA_S3TC_DXT3_EXT;

    pfDXT5:
      Result := GL_COMPRESSED_RGBA_S3TC_DXT5_EXT;

  else
    Result := -1;
  end;
end;

function PixelFormatToFormat(Source: TPixelFormat): Integer;
begin
  case Source of
    pfA16B16G16R16:
      Result := GL_RGBA;
    pfA2B10G10R10:
      Result := GL_RGBA;
    pfA2R10G10B10:
      Result := GL_BGRA;
    pfA8R8G8B8:
      Result := GL_BGRA;
    pfX8R8G8B8:
      Result := GL_BGR;
    pfA8B8G8R8:
      Result := GL_RGBA;
    pfX8B8G8R8:
      Result := GL_RGB;
    pfR5G6B5:
      Result := GL_BGR;
    pfA4R4G4B4:
      Result := GL_BGRA;
    pfA1R5G5B5:
      Result := GL_BGRA;
    pfX1R5G5B5:
      Result := GL_BGR;
    pfG16R16:
      Result := GL_RG;
    pfA8L8:
      Result := GL_LUMINANCE_ALPHA;
    pfA4L4:
      Result := GL_LUMINANCE_ALPHA;
    pfR16F:
      Result := GL_RED;
    pfG16R16F:
      Result := GL_RG;
    pfA16B16G16R16F:
      Result := GL_RGBA;
    pfR32F:
      Result := GL_RED;
    pfG32R32F:
      Result := GL_RG;
    pfA32B32G32R32F:
      Result := GL_RGBA;
    pfA8:
      Result := GL_ALPHA;
    pfV8U8:
      Result := GL_RG;
    pfX8L8V8U8:
      Result := GL_RGBA;
    pfQ8W8V8U8:
      Result := GL_RGBA;
    pfV16U16:
      Result := GL_RG;
    pfU8Y8_V8Y8:
      Result := GL_UNSIGNED_SHORT_8_8_REV_APPLE;
    pfY8U8_Y8V8:
      Result := GL_UNSIGNED_SHORT_8_8_APPLE;
    pfB10G11R11F:
      Result := GL_R11F_G11F_B10F_EXT;
    pfDXT1, pfDXT2:
      Result := GL_COMPRESSED_RGBA_S3TC_DXT1_EXT;
    pfDXT3, pfDXT4:
      Result := GL_COMPRESSED_RGBA_S3TC_DXT3_EXT;
    pfDXT5:
      Result := GL_COMPRESSED_RGBA_S3TC_DXT5_EXT;
  else
    Result := -1;
  end;
end;

function PixelFormatToType(Source: TPixelFormat): Integer;
begin
  case Source of
    pfA16B16G16R16:
      Result := GL_UNSIGNED_SHORT;
    pfA2B10G10R10:
      Result := GL_UNSIGNED_INT_2_10_10_10_REV;
    pfA2R10G10B10:
      Result := GL_UNSIGNED_INT_2_10_10_10_REV;
    pfA8R8G8B8:
      Result := GL_UNSIGNED_INT_8_8_8_8_REV;
    pfX8R8G8B8:
      Result := GL_UNSIGNED_INT_8_8_8_8_REV;
    pfA8B8G8R8:
      Result := GL_UNSIGNED_INT_8_8_8_8_REV;
    pfX8B8G8R8:
      Result := GL_UNSIGNED_INT_8_8_8_8_REV;
    pfR5G6B5:
      Result :=  GL_UNSIGNED_SHORT_5_6_5;
    pfA4R4G4B4:
      Result :=  GL_UNSIGNED_SHORT_4_4_4_4;
    pfA1R5G5B5:
      Result := GL_UNSIGNED_SHORT_1_5_5_5_REV;
    pfX1R5G5B5:
      Result := GL_UNSIGNED_SHORT_1_5_5_5_REV;
    pfG16R16:
      Result := GL_UNSIGNED_SHORT;
    pfA8L8:
      Result := GL_UNSIGNED_BYTE;
    pfA4L4:
      Result := -1;
    pfR16F:
      Result := GL_FLOAT;
    pfG16R16F:
      Result := GL_FLOAT;
    pfA16B16G16R16F:
      Result := GL_FLOAT;
    pfR32F:
      Result := GL_FLOAT;
    pfG32R32F:
      Result := GL_FLOAT;
    pfA32B32G32R32F:
      Result := GL_FLOAT;
    pfA8:
      Result := GL_UNSIGNED_BYTE;
    pfV8U8:
      Result := GL_UNSIGNED_BYTE;
    pfX8L8V8U8:
      Result := GL_UNSIGNED_BYTE;
    pfQ8W8V8U8:
      Result := GL_UNSIGNED_BYTE;
    pfV16U16:
      Result := GL_UNSIGNED_SHORT;
    pfU8Y8_V8Y8:
      Result := GL_UNSIGNED_SHORT_8_8_REV_APPLE;
    pfY8U8_Y8V8:
      Result := GL_UNSIGNED_SHORT_8_8_APPLE;
    pfB10G11R11F:
      Result := GL_R11F_G11F_B10F_EXT;
    pfDXT1, pfDXT2:
      Result := GL_COMPRESSED_RGBA_S3TC_DXT1_EXT;
    pfDXT3, pfDXT4:
      Result := GL_COMPRESSED_RGBA_S3TC_DXT3_EXT;
    pfDXT5:
      Result := GL_COMPRESSED_RGBA_S3TC_DXT5_EXT;
  else
    Result := -1;
  end;
end;

{ TContextOpenGL }

const

  attrs2: array  [0..11] of NSOpenGLPixelFormatAttribute =
    (
		NSOpenGLPFAAccelerated,
		NSOpenGLPFADoubleBuffer,
		NSOpenGLPFADepthSize, 24,
		NSOpenGLPFAStencilSize, 8,
                NSOpenGLPFAMultisample,
                NSOpenGLPFASampleBuffers, 1,
                NSOpenGLPFASamples, 2,
                0
    );
  attrs4: array  [0..11] of NSOpenGLPixelFormatAttribute =
    (
		NSOpenGLPFAAccelerated,
		NSOpenGLPFADoubleBuffer,
		NSOpenGLPFADepthSize, 24,
		NSOpenGLPFAStencilSize, 8,
                NSOpenGLPFAMultisample,
                NSOpenGLPFASampleBuffers, 1,
                NSOpenGLPFASamples, 4,
                0
    );

constructor TContextOpenGL.CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
      const AMultisample: TMultisample; const ADepthStencil: Boolean);
var
  PixelFormat: NSOpenGLPixelFormat;
  PF: Pointer;
  Ctx: NSOpenGLContext;
  WinSvc: IFMXWindowService;
  PaintControl: IPaintControl;
begin
  inherited;
  CreateSharedContext;
  PF := nil;
  case Multisample of
    TMultisample.ms4Samples:
      begin
        PixelFormat := TNSOpenGLPixelFormat.Create;
        PF := PixelFormat.initWithAttributes(@attrs4[0]);
        if PF = nil then
        begin
          PixelFormat := TNSOpenGLPixelFormat.Create;
          PF := PixelFormat.initWithAttributes(@attrs2[0]);
        end;
      end;
    TMultisample.ms2Samples:
      begin
        PixelFormat := TNSOpenGLPixelFormat.Create;
        PF := PixelFormat.initWithAttributes(@attrs2[0]);
      end;
  end;
  if PF = nil then
  begin
    PixelFormat := TNSOpenGLPixelFormat.Create;
    PF := PixelFormat.initWithAttributes(@attrs[0]);
  end;

  PixelFormat := TNSOpenGLPixelFormat.Wrap(PF);

  Ctx := TNSOpenGLContext.Create;
  FContextObject := TNSOpenGLContext.Wrap(Ctx.initWithFormat(PixelFormat, FSharedContext));
  PixelFormat.release;

  // set context to the view
  FScale := 1.0;
  if Assigned(WindowHandleToPlatform(Parent).GLView) then
  begin
    WindowHandleToPlatform(Parent).GLView.setOpenGLContext(FContextObject);
    if TPlatformServices.Current.SupportsPlatformService(IFMXWindowService, IInterface(WinSvc)) then
      FScale := WinSvc.GetWindowScale(WindowHandleToPlatform(Parent).Form);
  end else begin
    if TPlatformServices.Current.SupportsPlatformService(IFMXWindowService, IInterface(WinSvc)) then
      if Supports(WinSvc.FindForm(Parent), IPaintControl, PaintControl) then
      begin
        TNSOpenGLView.Wrap(Pointer(PaintControl.ContextHandle)).setOpenGLContext(FContextObject);
        FScale := WinSvc.GetWindowScale(WinSvc.FindForm(Parent));
      end;
  end;

  CreateBuffer;
end;

constructor TContextOpenGL.CreateFromTexture(const ATexture: TTexture; const AMultisample: TMultisample;
      const ADepthStencil: Boolean);
begin
  inherited;
  FScale := 1.0;
  {$WARNINGS OFF}
  FSupportMS := Pos('gl_ext_framebuffer_multisample', LowerCase(MarshaledAString(glGetString(GL_EXTENSIONS)))) > 0;
  {$WARNINGS ON}
  if Multisample <> TMultisample.ms2Samples then
    FMSValue := 2
  else
    FMSValue := 4;
  CreateBuffer;
end;

destructor TContextOpenGL.Destroy;
begin
  if FBitmapBuffer <> nil then
    FreeMem(FBitmapBuffer);
  FContextObject := nil;
  inherited;
end;

procedure TContextOpenGL.DoCreateBuffer;
var
  Status: Integer;
  OldFBO: GLuint;
begin
  if (FSharedContext <> nil) and (Texture <> nil) then
  begin
    { create buffers }
    if (Multisample <> TMultisample.msNone) and FSupportMS then
    begin
      glGetIntegerv(GL_FRAMEBUFFER_BINDING, @OldFBO);
      glGenFramebuffersEXT(1, @FFrameBuf);
      glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, FFrameBuf);

      glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT, GL_TEXTURE_2D, Texture.Handle, 0);

      if DepthStencil then
      begin
        glGenRenderbuffersEXT(1, @FDepthBuf);
        glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, FDepthBuf);
        glRenderbufferStorageEXT(GL_RENDERBUFFER_EXT, GL_DEPTH24_STENCIL8_EXT, Width, Height);
        glFramebufferRenderbufferEXT(GL_FRAMEBUFFER_EXT, GL_DEPTH_ATTACHMENT_EXT, GL_RENDERBUFFER_EXT, FDepthBuf);
        glFramebufferRenderbufferEXT(GL_FRAMEBUFFER_EXT, GL_STENCIL_ATTACHMENT_EXT, GL_RENDERBUFFER_EXT, FDepthBuf);
        glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, 0);
      end;

      Status := glCheckFramebufferStatusEXT(GL_FRAMEBUFFER_EXT);
      if Status <> GL_FRAMEBUFFER_COMPLETE_EXT then
        EContext3DException.CreateResFmt(@SCannotCreateRenderBuffers, [ClassName]);

      { MS }
      glGenFramebuffersEXT(1, @FFrameBufMS);
      glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, FFrameBufMS);
      glGenRenderbuffersEXT(1, @FRenderBufMS);
      glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, FRenderBufMS);
      glRenderbufferStorageMultisampleEXT(GL_RENDERBUFFER_EXT, FMSValue, GL_RGBA, Width, Height);
      glFrameBufferRenderBufferEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT, GL_RENDERBUFFER_EXT, FRenderBufMS);
      if DepthStencil then
      begin
        glGenRenderbuffersEXT(1, @FDepthBufMS);
        glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, FDepthBufMS);
        glRenderbufferStorageMultisampleEXT(GL_RENDERBUFFER_EXT, FMSValue, GL_DEPTH24_STENCIL8_EXT, Width, Height);
        glFramebufferRenderbufferEXT(GL_FRAMEBUFFER_EXT, GL_DEPTH_ATTACHMENT_EXT, GL_RENDERBUFFER_EXT, FDepthBufMS);
        glFramebufferRenderbufferEXT(GL_FRAMEBUFFER_EXT, GL_STENCIL_ATTACHMENT_EXT, GL_RENDERBUFFER_EXT, FDepthBufMS);
        glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, 0);
      end;
      Status := glCheckFramebufferStatusEXT(GL_FRAMEBUFFER_EXT);
      if Status <> GL_FRAMEBUFFER_COMPLETE_EXT then
        EContext3DException.CreateResFmt(@SCannotCreateRenderBuffers, [ClassName]);
      glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, 0);

      glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, OldFBO);
    end
    else
    begin
      glGetIntegerv(GL_FRAMEBUFFER_BINDING, @OldFBO);
      glGenFramebuffersEXT(1, @FFrameBuf);
      glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, FFrameBuf);

      glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT, GL_TEXTURE_2D, Texture.Handle, 0);

      if DepthStencil then
      begin
        glGenRenderbuffersEXT(1, @FDepthBuf);
        glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, FDepthBuf);
        glRenderbufferStorageEXT(GL_RENDERBUFFER_EXT, GL_DEPTH24_STENCIL8_EXT, Width, Height);
        glFramebufferRenderbufferEXT(GL_FRAMEBUFFER_EXT, GL_DEPTH_ATTACHMENT_EXT, GL_RENDERBUFFER_EXT, FDepthBuf);
        glFramebufferRenderbufferEXT(GL_FRAMEBUFFER_EXT, GL_STENCIL_ATTACHMENT_EXT, GL_RENDERBUFFER_EXT, FDepthBuf);
        glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, 0);
      end;

      Status := glCheckFramebufferStatusEXT(GL_FRAMEBUFFER_EXT);
      if Status <> GL_FRAMEBUFFER_COMPLETE_EXT then
        EContext3DException.CreateResFmt(@SCannotCreateRenderBuffers, [ClassName]);
      glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, OldFBO);
    end;
    if (GLHasAnyErrors()) then
        EContext3DException.CreateResFmt(@SCannotCreateRenderBuffers, [ClassName]);
  end;
end;

procedure TContextOpenGL.DoResize;
var
  Status: Integer;
  OldFBO: GLuint;
begin
  if Valid then
  begin
    if FFrameBuf <> 0 then
    begin
      glGetIntegerv(GL_FRAMEBUFFER_BINDING, @OldFBO);
      glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, FFrameBuf);
      if FRenderBuf <> 0 then
      begin
        glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, FRenderBuf);
        glRenderbufferStorageEXT(GL_RENDERBUFFER_EXT, GL_RGBA, Width, Height);
      end;
      if FDepthBuf <> 0 then
      begin
        glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, FDepthBuf);
        glRenderbufferStorageEXT(GL_RENDERBUFFER_EXT, GL_DEPTH24_STENCIL8_EXT, Width, Height);
      end;
      Status := glCheckFramebufferStatusEXT(GL_FRAMEBUFFER_EXT);
      if Status <> GL_FRAMEBUFFER_COMPLETE_EXT then
        EContext3DException.CreateResFmt(@SCannotCreateRenderBuffers, [ClassName]);
      if FFrameBufMS <> 0 then
      begin
        glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, FFrameBufMS);
        glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, FRenderBufMS);
        glRenderbufferStorageMultisampleEXT(GL_RENDERBUFFER_EXT, FMSValue, GL_RGBA, Width, Height);
        if FDepthBufMS <> 0 then
        begin
          glBindRenderbufferEXT(GL_RENDERBUFFER_EXT, FDepthBufMS);
          glRenderbufferStorageMultisampleEXT(GL_RENDERBUFFER_EXT, FMSValue, GL_DEPTH24_STENCIL8_EXT, Width, Height);
        end;
        Status := glCheckFramebufferStatusEXT(GL_FRAMEBUFFER_EXT);
        if Status <> GL_FRAMEBUFFER_COMPLETE_EXT then
          EContext3DException.CreateResFmt(@SCannotCreateRenderBuffers, [ClassName]);
      end;
      glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, OldFBO);
      if (GLHasAnyErrors()) then
        EContext3DException.CreateResFmt(@SCannotCreateRenderBuffers, [ClassName]);
    end
    else
      FContextObject.update;
  end;
end;

procedure TContextOpenGL.DoFreeBuffer;
begin
  if FFrameBuf <> 0 then
  begin
    if FDepthBufMS <> 0 then
      glDeleteRenderbuffersEXT(1, @FDepthBufMS);
    if FRenderBufMS <> 0 then
       glDeleteRenderbuffersEXT(1, @FRenderBufMS);
    if FFrameBufMS <> 0 then
       glDeleteFramebuffersEXT(1, @FFrameBufMS);
    FDepthBufMS := 0;
    FFrameBufMS := 0;
    FRenderBufMS := 0;
    if FDepthBuf <> 0 then
      glDeleteRenderbuffersEXT(1, @FDepthBuf);
    if FRenderBuf <> 0 then
      glDeleteRenderbuffersEXT(1, @FRenderBuf);
    if FFrameBuf <> 0 then
      glDeleteFramebuffersEXT(1, @FFrameBuf);
  end;
end;

function TContextOpenGL.GetValid: Boolean;
begin
  Result := ((Texture <> nil) and (FFrameBuf <> 0)) or (FContextObject <> nil);
end;

function TContextOpenGL.DoBeginScene: Boolean;
begin
  Result := False;
  if Valid then
  begin
    glPushAttrib(GL_VIEWPORT_BIT);
    if FFrameBuf <> 0 then
    begin
      glGetIntegerv(GL_FRAMEBUFFER_BINDING, @FOldFBO);
      if FFrameBufMS <> 0 then
        glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, FFrameBufMS)
      else
        glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, FFrameBuf);
    end
    else
      FContextObject.makeCurrentContext;
    glViewport(0, 0, Round(Width * FScale), Round(Height * FScale));

    Result := inherited DoBeginScene;

    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SCannotBeginRenderingScene, [ClassName]);
  end;
end;

procedure TContextOpenGL.DoEndScene;
begin
  if Valid then
  begin
    if FFrameBuf <> 0 then
    begin
      if FFrameBufMS <> 0 then
      begin
        glBindFramebufferEXT(GL_READ_FRAMEBUFFER_EXT, FFrameBufMS);
        glBindFramebufferEXT(GL_DRAW_FRAMEBUFFER_EXT, FFrameBuf);
        glBlitFramebufferEXT(0, 0, Texture.Width, Texture.Height, 0, 0, Texture.Width, Texture.Height, GL_COLOR_BUFFER_BIT, GL_NEAREST);
        glBindFramebufferEXT(GL_READ_FRAMEBUFFER_EXT, 0);
        glBindFramebufferEXT(GL_DRAW_FRAMEBUFFER_EXT, 0);
      end;
      glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, FOldFBO);
    end
    else
      FContextObject.flushBuffer;
    glPopAttrib;
  end;
  inherited ;
end;

procedure TContextOpenGL.DoSetContextState(AState: TContextState);
begin
  if Valid then
  begin
    case AState of
      TContextState.csZTestOn:
        begin
          glEnable(GL_DEPTH_TEST);
          glDepthFunc(GL_LEQUAL);
          glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
        end;
      TContextState.csZTestOff: glDisable(GL_DEPTH_TEST);
      TContextState.csZWriteOn: glDepthMask(1);
      TContextState.csZWriteOff: glDepthMask(0);
      TContextState.csAlphaBlendOn:
        begin
          glEnable(GL_BLEND);
          glEnable(GL_ALPHA_TEST);
          glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
        end;
      TContextState.csAlphaBlendOff:
        begin
          glDisable(GL_BLEND);
          glDisable(GL_ALPHA_TEST);
        end;
      TContextState.csStencilOn: glEnable(GL_STENCIL_TEST);
      TContextState.csStencilOff: glDisable(GL_STENCIL_TEST);
      TContextState.csColorWriteOn: glColorMask(1, 1, 1, 1);
      TContextState.csColorWriteOff: glColorMask(0, 0, 0, 0);
      TContextState.csScissorOn: glEnable(GL_SCISSOR_TEST);
      TContextState.csScissorOff: glDisable(GL_SCISSOR_TEST);
      TContextState.csFrontFace:
        begin
          glFrontFace(GL_CW);
          glCullFace(GL_BACK);
          glEnable(GL_CULL_FACE);
        end;
      TContextState.csBackFace:
        begin
          glFrontFace(GL_CW);
          glCullFace(GL_FRONT);
          glEnable(GL_CULL_FACE);
        end;
      TContextState.csAllFace:
        glDisable(GL_CULL_FACE);
    end;
    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SErrorInContextMethod, ['DoSetContextState']);
  end;
end;

procedure TContextOpenGL.DoClear(const ATarget: TClearTargets; const AColor: TAlphaColor; const ADepth: single; const AStencil: Cardinal);
var
  Flags: Integer;
  SaveMask: GLint;
begin
  if Valid then
  begin
    Flags := 0;
    if DepthStencil and (TClearTarget.ctDepth in ATarget) then
    begin
      Flags := Flags or GL_DEPTH_BUFFER_BIT;
      glGetIntegerv(GL_DEPTH_WRITEMASK, @SaveMask);
      glDepthMask(1);
      glClearDepth(ADepth);
    end;
    if DepthStencil and (TClearTarget.ctStencil in ATarget) then
    begin
      Flags := Flags or GL_STENCIL_BUFFER_BIT;
      glClearStencil(AStencil);
    end;
    if (TClearTarget.cTColor in ATarget) then
    begin
      Flags := Flags or GL_COLOR_BUFFER_BIT;
      glClearColor(TAlphaColorRec(AColor).R / $FF, TAlphaColorRec(AColor).G / $FF, TAlphaColorRec(AColor).B / $FF, TAlphaColorRec(AColor).A / $FF);
    end;

    glClear(Flags);

    if DepthStencil and (TClearTarget.ctDepth in ATarget) then
      glDepthMask(SaveMask);

    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SErrorInContextMethod, ['DoClear']);
  end;
end;

procedure TContextOpenGL.DoCopyToBits(const Bits: Pointer; const Pitch: Integer; const ARect: TRect);
var
  I: integer;
  OldFBO: GLuint;
begin
  if FBitmapBuffer = nil then
  begin
    FBitmapBufferLen := Width * Height * 4;
    GetMem(FBitmapBuffer, FBitmapBufferLen);
  end;
  if FBitmapBufferLen <> Width * Height * 4 then
  begin
    FreeMem(FBitmapBuffer);
    FBitmapBufferLen := Width * Height * 4;
    GetMem(FBitmapBuffer, FBitmapBufferLen);
  end;
  if Texture <> nil then
  begin
    glBindTexture(GL_TEXTURE_2D, Texture.Handle);
    glGetTexImage(GL_TEXTURE_2D, 0, PixelFormatToFormat(pfA8B8G8R8), GL_UNSIGNED_BYTE, FBitmapBuffer);

    for I := ARect.Top to ARect.Bottom - 1 do
      Move(FBitmapBuffer[(Height - 1 - I) * Width + ARect.Left], PAlphaColorArray(Bits)[I * (Pitch div 4) + ARect.Left], ARect.Width * 4);
    glBindTexture(GL_TEXTURE_2D, 0);
  end
  else
  begin
    glGetIntegerv(GL_FRAMEBUFFER_BINDING, @OldFBO);
    glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, FFrameBuf);
    glReadPixels(0, 0, Width, Height, PixelFormatToFormat(pfA8B8G8R8), GL_UNSIGNED_BYTE, FBitmapBuffer);
    glBindFramebufferEXT(GL_FRAMEBUFFER_EXT, OldFBO);

    for I := ARect.Top to ARect.Bottom - 1 do
      Move(FBitmapBuffer[(Height - 1 - I) * Width + ARect.Left], PAlphaColorArray(Bits)[I * (Pitch div 4) + ARect.Left], ARect.Width * 4);
  end;
end;

{ drawing }

procedure TContextOpenGL.DoDrawPrimitives(const AKind: TPrimitivesKind; const Vertices, Indices: Pointer; const VertexDeclaration: TVertexDeclaration;
      const VertexSize, VertexCount, IndexSize, IndexCount: Integer);
var
  Element: TVertexElement;
  Mode: GLEnum;
begin
  {$WARNINGS OFF}
  if Valid then
  begin
    for Element in VertexDeclaration do
    begin
      case Element.Format of
        TVertexFormat.vfVertex:
          begin
            glVertexAttribPointer(ATTRIB_VERTEX, 3, GL_FLOAT, GL_FALSE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_VERTEX);
          end;
        TVertexFormat.vfNormal:
          begin
            glVertexAttribPointer(ATTRIB_NORMAL, 3, GL_FLOAT, GL_FALSE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_NORMAL);
          end;
        TVertexFormat.vfTexCoord0:
          begin
            glVertexAttribPointer(ATTRIB_TEXCOORD0, 2, GL_FLOAT, GL_FALSE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_TEXCOORD0);
          end;
        TVertexFormat.vfTexCoord1:
          begin
            glVertexAttribPointer(ATTRIB_TEXCOORD1, 2, GL_FLOAT, GL_FALSE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_TEXCOORD1);
          end;
        TVertexFormat.vfTexCoord2:
          begin
            glVertexAttribPointer(ATTRIB_TEXCOORD2, 2, GL_FLOAT, GL_FALSE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_TEXCOORD2);
          end;
        TVertexFormat.vfTexCoord3:
          begin
            glVertexAttribPointer(ATTRIB_TEXCOORD3, 2, GL_FLOAT, GL_FALSE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_TEXCOORD3);
          end;
        TVertexFormat.vfColor0:
          begin
            glVertexAttribPointer(ATTRIB_COLOR0, 4, GL_UNSIGNED_BYTE, GL_TRUE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_COLOR0);
          end;
        TVertexFormat.vfColor1:
          begin
            glVertexAttribPointer(ATTRIB_COLOR0, 4, GL_UNSIGNED_BYTE, GL_TRUE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_COLOR0);
          end;
        TVertexFormat.vfColor2:
          begin
            glVertexAttribPointer(ATTRIB_COLOR0, 4, GL_UNSIGNED_BYTE, GL_TRUE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_COLOR0);
          end;
        TVertexFormat.vfColor3:
          begin
            glVertexAttribPointer(ATTRIB_COLOR0, 4, GL_UNSIGNED_BYTE, GL_TRUE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_COLOR0);
          end;
        TVertexFormat.vfColorF0:
          begin
            glVertexAttribPointer(ATTRIB_COLOR0, 4, GL_FLOAT, GL_FALSE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_COLOR0);
          end;
        TVertexFormat.vfColorF1:
          begin
            glVertexAttribPointer(ATTRIB_COLOR0, 4, GL_FLOAT, GL_FALSE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_COLOR0);
          end;
        TVertexFormat.vfColorF2:
          begin
            glVertexAttribPointer(ATTRIB_COLOR0, 4, GL_FLOAT, GL_FALSE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_COLOR0);
          end;
        TVertexFormat.vfColorF3:
          begin
            glVertexAttribPointer(ATTRIB_COLOR0, 4, GL_FLOAT, GL_FALSE, VertexSize, Pointer(NativeInt(Vertices) + Element.Offset));
            glEnableVertexAttribArray(ATTRIB_COLOR0);
          end;
      end;
    end;

    case AKind of
      TPrimitivesKind.pkPoints: Mode := GL_POINTS;
      TPrimitivesKind.pkLines: Mode := GL_LINES;
    else
      Mode := GL_TRIANGLES;
    end;

    if IndexSize = 4 then
      glDrawElements(Mode, IndexCount, GL_UNSIGNED_INT, Indices)
    else
      glDrawElements(Mode, IndexCount, GL_UNSIGNED_SHORT, Indices);

    glDisableVertexAttribArray(ATTRIB_VERTEX);
    glDisableVertexAttribArray(ATTRIB_NORMAL);
    glDisableVertexAttribArray(ATTRIB_COLOR0);
    glDisableVertexAttribArray(ATTRIB_COLOR1);
    glDisableVertexAttribArray(ATTRIB_COLOR2);
    glDisableVertexAttribArray(ATTRIB_COLOR3);
    glDisableVertexAttribArray(ATTRIB_TEXCOORD0);
    glDisableVertexAttribArray(ATTRIB_TEXCOORD1);
    glDisableVertexAttribArray(ATTRIB_TEXCOORD2);
    glDisableVertexAttribArray(ATTRIB_TEXCOORD3);
    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SErrorInContextMethod, ['DoDrawPrimitive']);
  {$WARNINGS ON}
  end;
end;

procedure TContextOpenGL.DoSetStencilOp(const Fail, ZFail, ZPass: TStencilOp);
var
  gFail, gZFail, gZPass: GLenum;
begin
  if Valid then
  begin
    case Fail of
      TStencilOp.soKeep: gFail := GL_KEEP;
      TStencilOp.soZero: gFail := GL_ZERO;
      TStencilOp.soReplace: gFail := GL_REPLACE;
      TStencilOp.soIncrease: gFail := GL_INCR;
      TStencilOp.soDecrease: gFail := GL_DECR;
      TStencilOp.soInvert: gFail := GL_INVERT;
    else
      gFail := GL_INVERT;
    end;
    case ZFail of
      TStencilOp.soKeep: gZFail := GL_KEEP;
      TStencilOp.soZero: gZFail := GL_ZERO;
      TStencilOp.soReplace: gZFail := GL_REPLACE;
      TStencilOp.soIncrease: gZFail := GL_INCR;
      TStencilOp.soDecrease: gZFail := GL_DECR;
      TStencilOp.soInvert: gZFail := GL_INVERT;
    else
      gZFail := GL_INVERT;
    end;
    case ZPass of
      TStencilOp.soKeep: gZPass := GL_KEEP;
      TStencilOp.soZero: gZPass := GL_ZERO;
      TStencilOp.soReplace: gZPass := GL_REPLACE;
      TStencilOp.soIncrease: gZPass := GL_INCR;
      TStencilOp.soDecrease: gZPass := GL_DECR;
      TStencilOp.soInvert: gZPass := GL_INVERT;
    else
      gZPass := GL_INVERT;
    end;
    glStencilOp(gFail, gZFail, gZPass);
    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SErrorInContextMethod, ['DoSetStencilOp']);
  end;
end;

procedure TContextOpenGL.DoSetStencilFunc(const Func: TStencilfunc; Ref, Mask: cardinal);
var
  gFunc: GLenum;
begin
  if Valid then
  begin
    case Func of
      TStencilFunc.sfNever: gFunc := GL_NEVER;
      TStencilFunc.sfLess: gFunc := GL_LESS;
      TStencilFunc.sfLequal: gFunc := GL_LEQUAL;
      TStencilFunc.sfGreater: gFunc := GL_GREATER;
      TStencilFunc.sfGequal: gFunc := GL_GEQUAL;
      TStencilFunc.sfEqual: gFunc := GL_EQUAL;
      TStencilFunc.sfNotEqual: gFunc := GL_NOTEQUAL;
      TStencilFunc.sfAlways: gFunc := GL_ALWAYS;
    else
      gFunc := GL_ALWAYS;
    end;
    glStencilFunc(gFunc, Ref, Mask);
    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SErrorInContextMethod, ['DoSetStencilFunc']);
  end;
end;

{ Textures }

class procedure TContextOpenGL.DoInitializeTexture(const Texture: TTexture);
var
  Tex: THandle;
begin
  CreateSharedContext;
  if FSharedContext <> nil then
  begin
    if Texture.PixelFormat = TPixelFormat.pfUnknown then
      Texture.PixelFormat := TPixelFormat.pfA8B8G8R8;
    glGenTextures(1, @Tex);
    glBindTexture(GL_TEXTURE_2D, Tex);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    case Texture.MagFilter of
      TTextureFilter.tfNearest: glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
      TTextureFilter.tfLinear: glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    end;
    if TTextureStyle.tsMipMaps in Texture.Style then
    begin
      case Texture.MinFilter of
        TTextureFilter.tfNearest: glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST_MIPMAP_NEAREST);
        TTextureFilter.tfLinear: glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
      end;
    end
    else
    begin
      case Texture.MinFilter of
        TTextureFilter.tfNearest: glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
        TTextureFilter.tfLinear: glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
      end;
    end;
    if TTextureStyle.tsRenderTarget in Texture.Style then
    begin
      glTexImage2D(GL_TEXTURE_2D, 0, PixelFormatToInternalFormat(Texture.PixelFormat), Texture.Width, Texture.Height, 0,
        PixelFormatToFormat(Texture.PixelFormat), PixelFormatToType(Texture.PixelFormat), nil);
      if TTextureStyle.tsMipMaps in Texture.Style then
        glGenerateMipmapEXT(GL_TEXTURE_2D);
    end;
    glBindTexture(GL_TEXTURE_2D, 0);
    ITextureAccess(Texture).Handle := Tex;
    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SCannotCreateTexture, [ClassName]);
  end;
end;

class procedure TContextOpenGL.DoFinalizeTexture(const Texture: TTexture);
begin
  if FSharedContext <> nil then
    glDeleteTextures(1, @Texture.Handle);
  ITextureAccess(Texture).Handle := 0;
end;

class procedure TContextOpenGL.DoUpdateTexture(const Texture: TTexture; const Bits: Pointer; const Pitch: Integer);
begin
  if FSharedContext <> nil then
  begin
    glBindTexture(GL_TEXTURE_2D, Texture.Handle);
    glTexImage2D(GL_TEXTURE_2D, 0, PixelFormatToInternalFormat(Texture.PixelFormat), Texture.Width, Texture.Height, 0,
      PixelFormatToFormat(Texture.PixelFormat), PixelFormatToType(Texture.PixelFormat), Bits);
    if TTextureStyle.tsMipMaps in Texture.Style then
      glGenerateMipmapEXT(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, 0);
    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SCannotUploadTexture, [ClassName]);
  end;
end;

class function TContextOpenGL.BuildShader(AType: Integer; ACode: TContextShaderCode): Integer;
var
  log: array of Byte;
  len, compiled: Integer;
begin
  Result := 0;
  CreateSharedContext;
  if FSharedContext <> nil then
  begin
    Result := glCreateShader(AType);
    len := Length(ACode);
    glShaderSource(Result, 1, @ACode, @len);
    glCompileShader(Result);
    glGetShaderiv(Result, GL_COMPILE_STATUS, @compiled);
    if compiled = 0 then
    begin
      glGetShaderiv(Result, GL_INFO_LOG_LENGTH, @compiled);
      if (compiled > 0) then
      begin
        SetLength(log, compiled);
        glGetShaderInfoLog(Result, compiled, @compiled, MarshaledAString(log));
        if AType = GL_VERTEX_SHADER then
          EContext3DException.CreateResFmt(@SCannotCreateVertexShader, [ClassName])
        else
          EContext3DException.CreateResFmt(@SCannotCreatePixelShader, [ClassName]);
      end;
    end;
    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SCannotCreateShader, [ClassName]);
  end
end;

class function TContextOpenGL.FindProgram(const VS, PS: TContextShader): TShaderProgram;
var
  ShaderProgram: TShaderProgram;
  compiled: Integer;
  S: TStringBuilder;
  I, J: Integer;
  Source: TContextShaderSource;
  TexUnit: Integer;
  Variable, Variable2: TContextShaderVariable;
begin
  Result := nil;
  if Assigned(FSharedContext) and Assigned(VS) and Assigned(PS) and (VS.Handle <> 0) and (PS.Handle <> 0) then
  begin
    if FPrograms <> nil then
      for ShaderProgram in FPrograms do
        if (ShaderProgram.VS = VS.Handle) and (ShaderProgram.PS = PS.Handle) then
          Exit(ShaderProgram);

    ShaderProgram := TShaderProgram.Create;
    ShaderProgram.Prog := glCreateProgram();

    glAttachShader(ShaderProgram.Prog, VS.Handle);
    glAttachShader(ShaderProgram.Prog, PS.Handle);

    glBindAttribLocation(ShaderProgram.Prog, ATTRIB_VERTEX, 'a_Position');
    glBindAttribLocation(ShaderProgram.Prog, ATTRIB_NORMAL, 'a_Normal');
    glBindAttribLocation(ShaderProgram.Prog, ATTRIB_TEXCOORD0, 'a_TexCoord0');
    glBindAttribLocation(ShaderProgram.Prog, ATTRIB_TEXCOORD1, 'a_TexCoord1');
    glBindAttribLocation(ShaderProgram.Prog, ATTRIB_TEXCOORD2, 'a_TexCoord2');
    glBindAttribLocation(ShaderProgram.Prog, ATTRIB_TEXCOORD3, 'a_TexCoord3');
    glBindAttribLocation(ShaderProgram.Prog, ATTRIB_COLOR0, 'a_Color');
    glBindAttribLocation(ShaderProgram.Prog, ATTRIB_COLOR1, 'a_Color1');
    glBindAttribLocation(ShaderProgram.Prog, ATTRIB_COLOR2, 'a_Color2');
    glBindAttribLocation(ShaderProgram.Prog, ATTRIB_COLOR3, 'a_Color3');

    glLinkProgram(ShaderProgram.Prog);
    glGetProgramiv(ShaderProgram.Prog, GL_LINK_STATUS, @compiled);
    if compiled = 0 then
    begin
      glDeleteProgram(ShaderProgram.Prog);
      EContext3DException.CreateResFmt(@SCannotActivateShaderProgram, [ClassName]);
    end;

    S := TStringBuilder.Create;
    try
      Source := VS.GetSourceByArch(TContextShaderArch.saMac);
      if Source.Arch = TContextShaderArch.saUndefined then
        Source := VS.GetSourceByArch(TContextShaderArch.saGLSL);
      if Source.IsDefined then
      begin
        // set vs
        for I := 0 to High(Source.Variables) do
        begin
          S.Clear;
          S.Append('_').Append(Source.Variables[I].Name);
          if Pos('.', S.ToString) > 0 then
            S.Insert(Pos('.', S.ToString), '_');
          Variable := Source.Variables[I];
          Variable.ShaderKind := TContextShaderKind.skVertexShader;
          Variable.Index := glGetUniformLocation(ShaderProgram.Prog, MarshaledAString(TMarshal.AsAnsi(S.ToString)));
          ShaderProgram.Variables.Add(Source.Variables[I].Name, Variable);
        end;
        // check locations - correct size if compiler decrease it
        if ShaderProgram.Variables.Count > 2 then
          for I := 0 to ShaderProgram.Variables.Count - 1 do
            for J := 0 to ShaderProgram.Variables.Count - 1 do
              if (I <> J) then
              begin
                Variable := ShaderProgram.Variables.ToArray[I].Value;
                Variable2 := ShaderProgram.Variables.ToArray[J].Value;
                if (Variable.ShaderKind = Variable2.ShaderKind) and
                   (Variable2.Index > Variable.Index) and (Variable.Index + Variable.Size > Variable2.Index) then
                begin
                  Variable.Size := Variable2.Index - Variable.Index;
                  ShaderProgram.Variables.AddOrSetValue(Variable.Name, Variable);
                end;
              end;
      end;
      // set ps
      Source := PS.GetSourceByArch(TContextShaderArch.saMac);
      if Source.Arch = TContextShaderArch.saUndefined then
        Source := PS.GetSourceByArch(TContextShaderArch.saGLSL);
      if Source.IsDefined then
      begin
        TexUnit := 0;
        for I := 0 to High(Source.Variables) do
        begin
          S.Clear;
          S.Append('_').Append(Source.Variables[I].Name);
          if Pos('.', S.ToString) > 0 then
            S.Insert(Pos('.', S.ToString), '_');

          Variable := Source.Variables[I];
          Variable.ShaderKind := TContextShaderKind.skPixelShader;
          Variable.Index := glGetUniformLocation(ShaderProgram.Prog, MarshaledAString(TMarshal.AsAnsi(S.ToString)));
          if (Variable.Index >= 0) and (Variable.Kind = TContextShaderVariableKind.vkTexture) then
          begin
            Variable.TextureUnit := TexUnit;
            TexUnit := TexUnit + 1;
          end;
          ShaderProgram.Variables.Add(Source.Variables[I].Name, Variable);
        end;
        // check locations - correct size if compiler decrease it
        if ShaderProgram.Variables.Count > 2 then
          for I := 0 to ShaderProgram.Variables.Count - 1 do
            for J := 0 to ShaderProgram.Variables.Count - 1 do
              if (I <> J) then
              begin
                Variable := ShaderProgram.Variables.ToArray[I].Value;
                Variable2 := ShaderProgram.Variables.ToArray[J].Value;
                if (Variable.ShaderKind = Variable2.ShaderKind) and
                   (Variable2.Index > Variable.Index) and (Variable.Index + Variable.Size > Variable2.Index) then
                begin
                  Variable.Size := Variable2.Index - Variable.Index;
                  ShaderProgram.Variables.AddOrSetValue(Variable.Name, Variable);
                end;
              end;
      end;
    finally
      S.DisposeOf;
    end;

    if FPrograms = nil then
      FPrograms := TList<TShaderProgram>.Create;

    ShaderProgram.VS := VS.Handle;
    ShaderProgram.PS := PS.Handle;
    FPrograms.Add(ShaderProgram);

    Result := ShaderProgram;
  end;
end;

class procedure TContextOpenGL.UseProgram(const VS, PS: TContextShader);
var
  Prog: TShaderProgram;
begin
  if Assigned(FSharedContext) and (VS <> nil) and (PS <> nil) and (VS.Handle <> 0) and (PS.Handle <> 0) then
  begin
    Prog := FindProgram(VS, PS);

    FCurrentProgram := Prog;
    glUseProgram(FCurrentProgram.Prog);
    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SCannotActivateShaderProgram, [ClassName]);
  end;
end;

{ shaders }

class procedure TContextOpenGL.DoInitializeShader(const Shader: TContextShader);
var
  Source: TContextShaderSource;
begin
  CreateSharedContext;
  if FSharedContext <> nil then
  begin
    if Shader.Kind = TContextShaderKind.skVertexShader then
    begin
      Source := Shader.GetSourceByArch(TContextShaderArch.saMac);
      if Source.Arch = TContextShaderArch.saUndefined then
        Source := Shader.GetSourceByArch(TContextShaderArch.saGLSL);
      if Source.IsDefined then
        Shader.Handle := BuildShader(GL_VERTEX_SHADER, Source.Code)
    end else begin
      Source := Shader.GetSourceByArch(TContextShaderArch.saMac);
      if Source.Arch = TContextShaderArch.saUndefined then
        Source := Shader.GetSourceByArch(TContextShaderArch.saGLSL);
      if Source.IsDefined then
        Shader.Handle := BuildShader(GL_FRAGMENT_SHADER, Source.Code)
    end;
  end;
end;

class procedure TContextOpenGL.DoFinalizeShader(const Shader: TContextShader);
begin
  CreateSharedContext;
  if FSharedContext <> nil then
    glDeleteShader(Shader.Handle);
  Shader.Handle := 0;
end;

procedure TContextOpenGL.DoSetScissorRect(const ScissorRect: TRect);
begin
  glScissor(ScissorRect.Left, Round(Height * FScale) - ScissorRect.Bottom, ScissorRect.Width, ScissorRect.Height);
end;

procedure TContextOpenGL.DoSetShaders(const VertexShader, PixelShader: TContextShader);
begin
  if Valid then
    UseProgram(VertexShader, PixelShader);
end;

procedure TContextOpenGL.DoSetShaderVariable(const Name: string;
  const Matrix: TMatrix3D);
var
  Temp: TMatrix3D;
begin
  Temp := Matrix.Transpose;
  DoSetShaderVariable(Name, Temp.M);
end;

procedure TContextOpenGL.DoSetShaderVariable(const Name: string; const Data: array of TVector3D);
var
  J: Integer;
  Variable: TContextShaderVariable;
begin
  if Assigned(FSharedContext) then
  begin
    if Assigned(FCurrentProgram) then
    begin
      if FCurrentProgram.Variables.TryGetValue(Name, Variable) then
      begin
        case Variable.Kind of
          TContextShaderVariableKind.vkFloat:
             glUniform1f(Variable.Index, Data[0].X);
          TContextShaderVariableKind.vkFloat2:
             glUniform2f(Variable.Index, Data[0].X, Data[0].Y);
          TContextShaderVariableKind.vkFloat3:
             glUniform3f(Variable.Index, Data[0].X, Data[0].Y, Data[0].Z);
        else
          for J := 0 to Min(High(Data), Variable.Size - 1) do
            glUniform4f(Variable.Index + J, Data[J].X, Data[J].Y, Data[J].Z, Data[J].W);
        end;
        GLHasAnyErrors;
        if (GLHasAnyErrors()) then
          EContext3DException.CreateResFmt(@SCannotFindShaderVariable, [ClassName]);
      end;
    end;
  end;
end;

procedure TContextOpenGL.DoSetShaderVariable(const Name: string; const Texture: TTexture);
var
  Variable: TContextShaderVariable;
begin
  if Assigned(FSharedContext) then
  begin
    if Assigned(FCurrentProgram) then
    begin
      if FCurrentProgram.Variables.TryGetValue(Name, Variable) then
      begin
        glActiveTexture(GL_TEXTURE0 + Variable.TextureUnit);
        if Texture = nil then
          glBindTexture(GL_TEXTURE_2D, 0)
        else
          glBindTexture(GL_TEXTURE_2D, Texture.Handle);
        glActiveTexture(GL_TEXTURE0);
        glUniform1i(Variable.Index, Variable.TextureUnit);
        GLHasAnyErrors;
        if (GLHasAnyErrors()) then
          EContext3DException.CreateResFmt(@SCannotFindShaderVariable, [ClassName]);
      end;
    end;
  end;
end;

var
  OpenGLHandle: HMODULE;

procedure RegisterContextClasses;
var
  Vendor: string;
begin
  OpenGLHandle := InitOpenGL;

  TCustomContextOpenGL.CreateSharedContext;
  if TCustomContextOpenGL.FSharedContext <> nil then
  begin
    {$WARNINGS OFF}
    Vendor := MarshaledAString(glGetString(GL_VENDOR));
    {$WARNINGS ON}
    TContextManager.RegisterContext(TContextOpenGL, True)
  end;
end;

procedure UnregisterContextClasses;
begin
  TCustomContextOpenGL.DestroySharedContext;
  FreeLibrary(OpenGLHandle);
end;

end.
