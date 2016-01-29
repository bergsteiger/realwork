{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Context.GLES;

interface

uses
  System.Classes, System.SysUtils, System.Types, System.UITypes, System.UIConsts, System.Generics.Collections, System.Math,
  Macapi.CoreFoundation, iOSapi.CocoaTypes, iOSapi.CoreGraphics, iOSapi.Foundation, iOSapi.UIKit, iOSapi.OpenGLES, iOSapi.GLKit,
  FMX.Types, FMX.Types3D, FMX.Platform, FMX.Filter, FMX.Forms;

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
    FPrograms: TList<TShaderProgram>;
    FCurrentProgram: TShaderProgram;
    FSharedContext: EAGLContext;
    class procedure CreateSharedContext;
    class procedure DestroySharedContext;
    class function GetSharedContext: EAGLContext; static;
  public
    class property SharedContext: EAGLContext read GetSharedContext;
  end;

procedure RegisterContextClasses;
procedure UnregisterContextClasses;

implementation {===============================================================}

uses FMX.Consts, FMX.Platform.iOS, FMX.Canvas.GPU, FMX.Materials, FMX.PixelFormats;

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

class procedure TCustomContextOpenGL.CreateSharedContext;
begin
  if FSharedContext = nil then
  begin
    FSharedContext := TEAGLContext.Wrap(TEAGLContext.Create.initWithAPI(kEAGLRenderingAPIOpenGLES2));
    TEAGLContext.OCClass.setCurrentContext(FSharedContext);

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
    if Assigned(FPrograms) then
    begin
      for Rec in FPrograms do
        glDeleteProgram(Rec.Prog);
      FreeAndNil(FPrograms);
    end;
    FSharedContext := nil;
  end;
end;

class function TCustomContextOpenGL.GetSharedContext: EAGLContext;
begin
  CreateSharedContext;
  Result := FSharedContext;
end;

{ TContextOpenGL }

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

type

  TContextOpenGL = class(TCustomContextOpenGL)
  private
    { buffers }
    FRenderBuf: GLuint;
    FFrameBuf: GLuint;
    FDepthBuf: GLuint;
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
    FOldViewport: array [0..3] of GLuint;
    { Retina }
    FScale: Single;
    class function BuildShader(AType: Integer; const ACode: TContextShaderCode): Integer;
    class function FindProgram(const VS, PS: TContextShader): TShaderProgram;
    class procedure UseProgram(const VS, PS: TContextShader);
  protected
    function GetValid: Boolean; override;
    { buffer }
    procedure DoCreateBuffer; override;
    procedure DoResize; override;
    procedure DoFreeBuffer; override;
    procedure DoCopyToBitmap(const Dest: TBitmap; const ARect: TRect); override;
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
    destructor Destroy; override;
  end;

{ TContextOpenGL }

constructor TContextOpenGL.CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
      const AMultisample: TMultisample; const ADepthStencil: Boolean);
var
  WinSvc: IFMXWindowService;
  Form: TCommonCustomForm;
  View: GLKView;
begin
  inherited;
  FScale := 1.0;
  if TPlatformServices.Current.SupportsPlatformService(IFMXWindowService, IInterface(WinSvc)) then
  begin
    Form := WinSvc.FindForm(AParent);
    if Assigned(Form) then
      FScale := WinSvc.GetWindowScale(Form);
  end;
  View := WindowHandleToPlatform(AParent).GLView;
  if Assigned(View) and (Multisample <> TMultisample.msNone) then
    View.setDrawableMultisample(GLKViewDrawableMultisample4X);
  CreateSharedContext;
  CreateBuffer;
end;

constructor TContextOpenGL.CreateFromTexture(const ATexture: TTexture; const AMultisample: TMultisample;
      const ADepthStencil: Boolean);
begin
  inherited;
  FScale := ATexture.TextureScale;
  CreateSharedContext;
  {$WARNINGS OFF}
  FSupportMS := Pos('gl_apple_framebuffer_multisample', LowerCase(MarshaledAString(glGetString(GL_EXTENSIONS)))) > 0;
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
  inherited;
end;

procedure TContextOpenGL.DoCreateBuffer;
var
  Status: Integer;
  OldFBO: GLuint;
begin
  if Assigned(FSharedContext) and Assigned(Texture) then
  begin
    { create buffers }
    if (Multisample <> TMultisample.msNone) and FSupportMS then
    begin
      glGetIntegerv(GL_FRAMEBUFFER_BINDING, @OldFBO);
      glGenFramebuffers(1, @FFrameBuf);
      glBindFramebuffer(GL_FRAMEBUFFER, FFrameBuf);

      glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, Texture.Handle, 0);

      if DepthStencil then
      begin
        glGenRenderbuffers(1, @FDepthBuf);
        glBindRenderbuffer(GL_RENDERBUFFER, FDepthBuf);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8_OES, Width, Height);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, FDepthBuf);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, FDepthBuf);
        glBindRenderbuffer(GL_RENDERBUFFER, 0);
      end;

      Status := glCheckFramebufferStatus(GL_FRAMEBUFFER);
      if Status <> GL_FRAMEBUFFER_COMPLETE then
        EContext3DException.CreateResFmt(@SCannotCreateRenderBuffers, [ClassName]);

      { MS }
      glGenFramebuffers(1, @FFrameBufMS);
      glBindFramebuffer(GL_FRAMEBUFFER, FFrameBufMS);
      glGenRenderbuffers(1, @FRenderBufMS);
      glBindRenderbuffer(GL_RENDERBUFFER, FRenderBufMS);
      glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, FMSValue, GL_RGBA8_OES, Width, Height);
      glFrameBufferRenderBuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, FRenderBufMS);
      if DepthStencil then
      begin
        glGenRenderbuffers(1, @FDepthBufMS);
        glBindRenderbuffer(GL_RENDERBUFFER, FDepthBufMS);
        glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, FMSValue, GL_DEPTH24_STENCIL8_OES, Width, Height);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, FDepthBufMS);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, FDepthBufMS);
        glBindRenderbuffer(GL_RENDERBUFFER, 0);
      end;
      Status := glCheckFramebufferStatus(GL_FRAMEBUFFER);
      if Status <> GL_FRAMEBUFFER_COMPLETE then
        EContext3DException.CreateResFmt(@SCannotCreateRenderBuffers, [ClassName]);

      glBindFramebuffer(GL_FRAMEBUFFER, OldFBO);
    end
    else
    begin
      glGetIntegerv(GL_FRAMEBUFFER_BINDING, @OldFBO);
      glGenFramebuffers(1, @FFrameBuf);
      glBindFramebuffer(GL_FRAMEBUFFER, FFrameBuf);

      glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, Texture.Handle, 0);

      if DepthStencil then
      begin
        glGenRenderbuffers(1, @FDepthBuf);
        glBindRenderbuffer(GL_RENDERBUFFER, FDepthBuf);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8_OES, Width, Height);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, FDepthBuf);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, FDepthBuf);
        glBindRenderbuffer(GL_RENDERBUFFER, 0);
      end;

      Status := glCheckFramebufferStatus(GL_FRAMEBUFFER);
      if Status <> GL_FRAMEBUFFER_COMPLETE then
        EContext3DException.CreateResFmt(@SCannotCreateRenderBuffers, [ClassName]);

      glBindFramebuffer(GL_FRAMEBUFFER, OldFBO);
    end;
    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SCannotCreateRenderBuffers, [ClassName]);
  end;
end;

procedure TContextOpenGL.DoResize;
begin
end;

procedure TContextOpenGL.DoFreeBuffer;
begin
  if FFrameBuf <> 0 then
  begin
    if FDepthBufMS <> 0 then
      glDeleteRenderbuffers(1, @FDepthBufMS);
    if FRenderBufMS <> 0 then
       glDeleteRenderbuffers(1, @FRenderBufMS);
    if FFrameBufMS <> 0 then
       glDeleteFramebuffers(1, @FFrameBufMS);
    FDepthBufMS := 0;
    FFrameBufMS := 0;
    FRenderBufMS := 0;
    if FDepthBuf <> 0 then
      glDeleteRenderbuffers(1, @FDepthBuf);
    if FRenderBuf <> 0 then
      glDeleteRenderbuffers(1, @FRenderBuf);
    if FFrameBuf <> 0 then
      glDeleteFramebuffers(1, @FFrameBuf);
  end;
end;

function TContextOpenGL.GetValid: Boolean;
begin
  Result := (FSharedContext <> nil);
  if Result then
    TEAGLContext.OCClass.setCurrentContext(FSharedContext);
end;

function TContextOpenGL.DoBeginScene: Boolean;
begin
  Result := False;
  if Valid then
  begin
    glGetIntegerv(GL_VIEWPORT, @FOldViewport[0]);
    if FFrameBuf <> 0 then
    begin
      glGetIntegerv(GL_FRAMEBUFFER_BINDING, @FOldFBO);
      if FFrameBufMS <> 0 then
        glBindFramebuffer(GL_FRAMEBUFFER, FFrameBufMS)
      else
        glBindFramebuffer(GL_FRAMEBUFFER, FFrameBuf);
    end;

    if Assigned(Texture) then
      glViewport(0, Height - Round(Height * FScale), Round(Width * FScale), Round(Height * FScale))
    else
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
    if FFrameBufMS <> 0 then
    begin
      glBindFramebuffer(GL_READ_FRAMEBUFFER_APPLE, FFrameBufMS);
      glBindFramebuffer(GL_DRAW_FRAMEBUFFER_APPLE, FFrameBuf);
      glResolveMultisampleFramebufferAPPLE;
      glBindFramebuffer(GL_READ_FRAMEBUFFER_APPLE, 0);
      glBindFramebuffer(GL_DRAW_FRAMEBUFFER_APPLE, 0);
    end;
    if FFrameBuf <> 0 then
      glBindFramebuffer(GL_FRAMEBUFFER, FOldFBO);
    glViewport(FOldViewport[0], FOldViewport[1], FOldViewport[2], FOldViewport[3]);
    inherited ;
  end;
end;

class function TContextOpenGL.DoBitmapToTexture(const Bitmap: TBitmap): TTexture;
begin
  if Bitmap.CanvasClass.InheritsFrom(TCustomCanvasGpu) then
    Result := TBitmapCtx(Bitmap.Handle).PaintingTexture
  else
    Result := inherited DoBitmapToTexture(Bitmap);
end;

procedure TContextOpenGL.DoSetScissorRect(const ScissorRect: TRect);
var
  R: TRect;
begin
  R := Rect(Round(ScissorRect.Left * FScale), Round(ScissorRect.Top * FScale),
    Round(ScissorRect.Right * FScale), Round(ScissorRect.Bottom * FScale));

  if Assigned(Texture) then
    glScissor(R.Left, Height - R.Bottom, R.Width, R.Height)
  else
    glScissor(R.Left, Round(Height * FScale) - R.Bottom, R.Width, R.Height);
  if (GLHasAnyErrors()) then
    EContext3DException.CreateResFmt(@SErrorInContextMethod, ['DoSetScissorRect']);
end;

procedure TContextOpenGL.DoSetContextState(AState: TContextState);
begin
  if Assigned(FSharedContext) then
  begin
    case AState of
      TContextState.csZTestOn:
        begin
          glEnable(GL_DEPTH_TEST);
          glDepthFunc(GL_LEQUAL);
        end;
      TContextState.csZTestOff: glDisable(GL_DEPTH_TEST);
      TContextState.csZWriteOn: glDepthMask(1);
      TContextState.csZWriteOff: glDepthMask(0);
      TContextState.csAlphaBlendOn:
        begin
          glEnable(GL_BLEND);
          glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
        end;
      TContextState.csAlphaBlendOff: glDisable(GL_BLEND);
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
      TContextState.csAllFace: glDisable(GL_CULL_FACE);
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
      glClearDepthf(ADepth);
    end;
    if DepthStencil and (TClearTarget.ctStencil in ATarget) then
    begin
      Flags := Flags or GL_STENCIL_BUFFER_BIT;
      glClearStencil(AStencil);
    end;
    if (TClearTarget.ctColor in ATarget) then
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

procedure TContextOpenGL.DoCopyToBitmap(const Dest: TBitmap; const ARect: TRect);
begin
  if Valid then
  begin
    if (TCanvasStyle.NeedGPUSurface in Dest.CanvasClass.GetCanvasStyle) and Assigned(Texture) then
    begin
      if TCustomCanvasGpu(Dest.Canvas).BeginScene then
      try
        TCustomCanvasGpu(Dest.Canvas).Clear(0);
        TCustomCanvasGpu(Dest.Canvas).SetMatrix(IdentityMatrix);
        TCustomCanvasGpu(Dest.Canvas).DrawTexture(RectF(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom),
          RectF(0, 0, ARect.Width, ARect.Height), $FFFFFFFF, Texture);
      finally
        TCustomCanvasGpu(Dest.Canvas).EndScene;
      end;
    end else begin
      inherited DoCopyToBitmap(Dest, ARect);
    end;
  end;
end;

procedure TContextOpenGL.DoCopyToBits(const Bits: Pointer; const Pitch: Integer; const ARect: TRect);
var
  I: Integer;
  OldFBO: GLuint;
begin
  if Valid then
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

    glGetIntegerv(GL_FRAMEBUFFER_BINDING, @OldFBO);
    glBindFramebuffer(GL_FRAMEBUFFER, FFrameBuf);
    glReadPixels(0, 0, Width, Height, GL_RGBA, GL_UNSIGNED_BYTE, FBitmapBuffer);
    for I := 0 to Height - 1 do
      Move(PAlphaColorArray(FBitmapBuffer)^[I * Width], PLongByteArray(Bits)^[(Height - I - 1) * Pitch], Width * 4);
    glBindFramebuffer(GL_FRAMEBUFFER, OldFBO);

    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SErrorInContextMethod, ['DoCopyBitmap']);
  end;
end;

procedure TContextOpenGL.DoDrawPrimitives(const AKind: TPrimitivesKind; const Vertices, Indices: Pointer;
  const VertexDeclaration: TVertexDeclaration; const VertexSize, VertexCount, IndexSize, IndexCount: Integer);
var
  Element: TVertexElement;
  Mode: GLEnum;
begin
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

    glUseProgram(0);
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, 0);

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
    glActiveTexture(GL_TEXTURE0);
    glGenTextures(1, @Tex);
    glBindTexture(GL_TEXTURE_2D, Tex);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
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
      glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, Texture.Width, Texture.Height, 0, GL_RGBA, GL_UNSIGNED_BYTE, nil);
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
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, Texture.Handle);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, Texture.Width, Texture.Height, 0, GL_RGBA, GL_UNSIGNED_BYTE, Bits);
    if TTextureStyle.tsMipMaps in Texture.Style then
      glGenerateMipmap(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, 0);
    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SCannotUploadTexture, [ClassName]);
  end;
end;

{ shaders }

const
  GLESHeaderMedium: array [0..24] of byte =
    (Byte('p'), Byte('r'), Byte('e'), Byte('c'), Byte('i'), Byte('s'), Byte('i'), Byte('o'), Byte('n'), Byte(' '),
     Byte('m'), Byte('e'), Byte('d'), Byte('i'), Byte('u'), Byte('m'), Byte('p'), Byte(' '), Byte('f'), Byte('l'),
     Byte('o'), Byte('a'), Byte('t'), Byte(';'), Byte(#13));
  GLESHeaderHigh: array [0..24] of byte =
    (Byte('p'), Byte('r'), Byte('e'), Byte('c'), Byte('i'), Byte('s'), Byte('i'), Byte('o'), Byte('n'), Byte(' '),
     Byte('h'), Byte('i'), Byte('g'), Byte('h'), Byte('p'), Byte(' '), Byte(' '), Byte(' '), Byte('f'), Byte('l'),
     Byte('o'), Byte('a'), Byte('t'), Byte(';'), Byte(#13));

class function TContextOpenGL.BuildShader(AType: Integer; const ACode: TContextShaderCode): Integer;
var
  log: array of Byte;
  len, compiled: Integer;
  code: array of Byte;
  I: Integer;
begin
  Result := 0;
  CreateSharedContext;
  if FSharedContext <> nil then
  begin
    if AType = GL_FRAGMENT_SHADER then
    begin
      SetLength(code, Length(GLESHeaderHigh) + Length(ACode));
      for I := 0 to High(GLESHeaderHigh) do
        code[I] := GLESHeaderHigh[I];
      for I := 0 to High(ACode) do
        code[Length(GLESHeaderHigh) + I] := ACode[I];
    end else begin
      SetLength(code, Length(ACode));
      for I := 0 to High(ACode) do
        code[I] := ACode[I];
    end;
    Result := glCreateShader(AType);
    len := Length(code);
    glShaderSource(Result, 1, @code, @len);
    glCompileShader(Result);
    glGetShaderiv(Result, GL_COMPILE_STATUS, @compiled);
    if compiled = 0 then
    begin
      glGetShaderiv(Result, GL_INFO_LOG_LENGTH, @compiled);
      if (compiled > 0) then
      begin
        {$WARNINGS OFF}
        SetLength(log, compiled);
        glGetShaderInfoLog(Result, compiled, @compiled, MarshaledAString(log));
        FMx.Types.Log.d(MarshaledAString(log));
        if AType = GL_VERTEX_SHADER then
          EContext3DException.CreateResFmt(@SCannotCreateVertexShader, [ClassName])
        else
          EContext3DException.CreateResFmt(@SCannotCreatePixelShader, [ClassName]);
        {$WARNINGS ON}
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
      Source := VS.GetSourceByArch(TContextShaderArch.saIOS);
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
      Source := PS.GetSourceByArch(TContextShaderArch.saIOS);
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
    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SCannotActivateShaderProgram, [ClassName]);

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

class procedure TContextOpenGL.DoInitializeShader(const Shader: TContextShader);
var
  Source: TContextShaderSource;
begin
  CreateSharedContext;
  if FSharedContext <> nil then
  begin
    if Shader.Kind = TContextShaderKind.skVertexShader then
    begin
      Source := Shader.GetSourceByArch(TContextShaderArch.saIOS);
      if Source.Arch = TContextShaderArch.saUndefined then
        Source := Shader.GetSourceByArch(TContextShaderArch.saGLSL);
      if Source.IsDefined then
        Shader.Handle := BuildShader(GL_VERTEX_SHADER, Source.Code)
    end else begin
      Source := Shader.GetSourceByArch(TContextShaderArch.saIOS);
      if Source.Arch = TContextShaderArch.saUndefined then
        Source := Shader.GetSourceByArch(TContextShaderArch.saGLSL);
      if Source.IsDefined then
        Shader.Handle := BuildShader(GL_FRAGMENT_SHADER, Source.Code)
    end;
  end;
end;

class procedure TContextOpenGL.DoFinalizeShader(const Shader: TContextShader);
begin
  if FSharedContext <> nil then
    glDeleteShader(Shader.Handle);
  Shader.Handle := 0;
end;

procedure TContextOpenGL.DoSetShaders(const VertexShader, PixelShader: TContextShader);
begin
  if Assigned(FSharedContext) then
    UseProgram(VertexShader, PixelShader);
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
      end;
    end;
    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SCannotFindShaderVariable, [ClassName]);
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
        glUniform1i(Variable.Index, Variable.TextureUnit);
        glActiveTexture(GL_TEXTURE0);
      end;
    end;
    if (GLHasAnyErrors()) then
      EContext3DException.CreateResFmt(@SCannotFindShaderVariable, [ClassName]);
  end;
end;

procedure TContextOpenGL.DoSetShaderVariable(const Name: string; const Matrix: TMatrix3D);
var
  Temp: TMatrix3D;
begin
  Temp := Matrix.Transpose;
  DoSetShaderVariable(Name, Temp.M);
end;

procedure RegisterContextClasses;
begin
  TContextManager.RegisterContext(TContextOpenGL, True);
end;

procedure UnregisterContextClasses;
begin
  TContextOpenGL.DestroySharedContext;
end;

end.



